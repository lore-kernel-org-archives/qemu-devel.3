Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC1FC4451B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 06:07:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlh9A-0007oW-Hn; Mon, 20 Jul 2026 02:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1wlh91-0007o9-DZ; Mon, 20 Jul 2026 02:06:27 -0400
Received: from sender4-op-o11.zoho.com ([136.143.188.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1wlh8x-0003Dd-W0; Mon, 20 Jul 2026 02:06:26 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1784527561; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZwaMdc1p/emfuXLJoQbEv5S0w4mw+OQGtPpe9alSDZqf/Xu3tWpY1AMXAjB8TF+pmbxRll1iS5kAb5yB9Gy98jYNxXG5q2bZYCFNfFvuZkVKPWjOQgibAyNdgcGEiVYW4W2A88tvZDiOMsqsQZCmNol+9JYKdbTbpC/LoQk2Rng=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784527561;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=nMsCNolPexEx6u1vFcnXkWFCOLRdSGr3Fti69DCtoQo=; 
 b=PgZrpIxoXxtEcogPZ/xG3q+I1YxAzCV2IiCPtkJLf+prtdrgriatmy58WZdyvVfBf/2H4U09BR6Tvj3CjQoYkAlOq/sY5FMmM+e2hWnHgiVKpmPY8xnTX19ekj3gmIGaEent65R/oS77uJoDCoPUqXrTh0nqbEXtHN2bkvgva2w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784527561; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=nMsCNolPexEx6u1vFcnXkWFCOLRdSGr3Fti69DCtoQo=;
 b=ZyhSmxt9Xsnb6KwozoYldHxUUcKfRnfkmuulLuCNAXfScjg6HQrB/QyouvgILkxC
 5cGrY6SN1biikGxbX7qxkegjGB7eaqwIrO0rCv/eSUc+fPVnmPfD44RYPvUm2r77Krw
 YZFA/FIY7Vbx4bNyyPhEHTVSB/9W7LLqWS6JiTmY=
Received: by mx.zohomail.com with SMTPS id 178452755910930.13272056713754;
 Sun, 19 Jul 2026 23:05:59 -0700 (PDT)
Message-ID: <a2bb53b9-2af2-4303-980d-844093e410e0@collabora.com>
Date: Mon, 20 Jul 2026 09:05:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-gpu: fix NULL deref in rutabaga set_scanout
To: jianghaotian.sunday@gmail.com, qemu-devel@nongnu.org
Cc: mst@redhat.com, alex.bennee@linaro.org, odaki@rsg.ci.i.u-tokyo.ac.jp,
 qemu-stable@nongnu.org, Haotian Jiang <sundayjiang@tencent.com>
References: <20260720022100.3700582-1-jianghaotian.sunday@gmail.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260720022100.3700582-1-jianghaotian.sunday@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.11;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-op-o11.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/20/26 05:21, jianghaotian.sunday@gmail.com wrote:
> From: Haotian Jiang <sundayjiang@tencent.com>
> 
> rutabaga_cmd_set_scanout() checks scanout_id < VIRTIO_GPU_MAX_SCANOUTS
> (16), but does not check scanout_id < conf.max_outputs like the base
> class (virtio-gpu.c) and virgl backend (virtio-gpu-virgl.c) do.
> 
> With the default max_outputs=1, virtio_gpu_base_device_realize only
> initializes scanout[0].con. A guest submitting SET_SCANOUT with
> scanout_id >= 1 takes the con=NULL path, and
> qemu_console_set_surface(NULL, NULL) dereferences con->ds, crashing
> QEMU.
> 
> Replace VIRTIO_GPU_MAX_SCANOUTS with vb->conf.max_outputs in the
> CHECK, since realization already ensures max_outputs <=
> VIRTIO_GPU_MAX_SCANOUTS.
> 
> Fixes: 1dcc6adbc1 ("gfxstream + rutabaga: add initial support for gfxstream")
> Reported-by: Haotian Jiang of Tencent Security (Yunding Lab) <jianghaotian.sunday@gmail.com>
> Signed-off-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
> Cc: qemu-stable@nongnu.org
> ---
>  hw/display/virtio-gpu-rutabaga.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
> index 6ff1263901..3f78899442 100644
> --- a/hw/display/virtio-gpu-rutabaga.c
> +++ b/hw/display/virtio-gpu-rutabaga.c
> @@ -302,7 +302,7 @@ rutabaga_cmd_set_scanout(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
>      trace_virtio_gpu_cmd_set_scanout(ss.scanout_id, ss.resource_id,
>                                       ss.r.width, ss.r.height, ss.r.x, ss.r.y);
>  
> -    CHECK(ss.scanout_id < VIRTIO_GPU_MAX_SCANOUTS, cmd);
> +    CHECK(ss.scanout_id < vb->conf.max_outputs, cmd);
>      scanout = &vb->scanout[ss.scanout_id];
>  
>      if (ss.resource_id == 0) {

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry

