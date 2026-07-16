Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7155DC44511
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 07:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkGfS-0001jb-LU; Thu, 16 Jul 2026 03:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wkGfP-0001j9-09
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 03:37:59 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wkGfM-0001Pq-7s
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 03:37:58 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66G7biit025499
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 16 Jul 2026 16:37:44 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=0f7nbAm4goNtKRi7yaKSN2slX/Bz5GuTU4zAryYyNaM=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1784187464; v=1;
 b=fG0lOBmdP67XQ63UAqIPXrxs2V5Nt7yck85LpuxSmZmKUFNjuNR58Y/vzy0S3cur
 SYPpMOK3ahzVTLI2ekSlmoqSMume4FQ9NvqJndriTsf1bXjkkskFNXU/KaJQ7XZN
 1wdCbZtaXXPdF9Nzm3d+1UzJH4if1gPLAK/RKnKT8vDuAdwAboUVJJUXL0OBItlX
 1QUEbISGPCA2AjUJAYL0zH2AFZGF3uuQxYz9bQ6nW1kGMpWtVXylXt59QgLGPbpA
 JZr1mjjdX0rjjgRjHG4rmSAPsdz0cWrDP5FPNQjkSZV1PLh16aPPp47fkRscxNBV
 t8DGR04cyidGvfMXDFME5A==
Message-ID: <25541fac-4e55-477c-8599-7e503bff31c6@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 16 Jul 2026 16:37:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/virtio-gpu: validate stride against width on
 scanout
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20260715201055.2465320-1-marcandre.lureau@redhat.com>
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260715201055.2465320-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/07/16 5:10, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Validate that the framebuffer stride is at least width * bytes_per_pixel
> in both virtio_gpu_scanout_blob_to_fb() and virtio_gpu_do_set_scanout().
> 
> A guest can set a very small stride while using a large width. The total
> size check (offset + stride * height <= blob_size) passes because
> stride * height is small, but pixman reads width * bytes_per_pixel per
> row, causing heap OOB reads. The leaked data is rendered to the host
> display.
> 
> The check is added in virtio_gpu_do_set_scanout() to cover all paths:
> blob scanout, non-blob scanout and migration post_load. The additional
> early check in virtio_gpu_scanout_blob_to_fb() rejects invalid blob
> configurations early.
> 
> Fixes: CVE-2026-63109
> Fixes: 144bd171c837 ("virtio-gpu: Support blob scanout using dmabuf fd")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3989
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

