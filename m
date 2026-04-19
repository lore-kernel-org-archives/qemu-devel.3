Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FFDEA71AD
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2026 23:28:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEbYh-0001U6-IU; Sun, 19 Apr 2026 19:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1wEbYf-0001Tm-V7; Sun, 19 Apr 2026 19:28:10 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1wEbYe-0001Ac-3A; Sun, 19 Apr 2026 19:28:09 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1776641272; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=nRgX8dDV5kCJsi4nWs1nE5Ii2Z3qdccNefQhQ2Bpq+rKE607N0B92nBqTaSn4E2WeFP9VrOyhojqSlNbuO48rwWTOtw6UzF+0G6Wl5a8J6m7py8kkxTnKn48I8JE/Vj1+CB4rNLCLDyk9dLXkVQYVLr+8SnadmZL1SWpm2FFTKE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776641272;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=JIhbYXixL4uRDbQNpcaMN5A1+mj2hsocTLQEX2bHG5s=; 
 b=Q6psjy1SEaL4vTIlPww9m7dWhgWvHjlF00ZaPDv9MGZAR75y4I/R5ypLDMciKOJsey/NwTT0vTl1g0+IxaJdkOAe/8+YelTzJ8IS6rSMPqMqyapYyFkW9ZsRuc2HLGSSkLuCLfxz8szHLSO6clQ19ye3n9FuqMWF2zBCrG89Sng=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776641272; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=JIhbYXixL4uRDbQNpcaMN5A1+mj2hsocTLQEX2bHG5s=;
 b=MvBKK7BJI8W1eD6OfAqQNyI/d5RL21ZaktCrnhlcYSaTduhNFYg9vYseZ7AK/Qlt
 nC5vLNUFd8m09wrX1bqj0I2rP5jDYoSiIaowOoQevccn5Jd27NB9ORxj6liPSi9v1KE
 DA5mNzhCcy6XFkKSqm8fcwxWpNs0mrDn3uufkgXQ=
Received: by mx.zohomail.com with SMTPS id 1776641270632430.8355693571791;
 Sun, 19 Apr 2026 16:27:50 -0700 (PDT)
Message-ID: <fe058805-6746-408a-a976-64d0c7978017@collabora.com>
Date: Mon, 20 Apr 2026 02:27:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] hw/display: don't accidentally autofree existing
 virgl resources
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, qemu-stable@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260417094443.785462-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260417094443.785462-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
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

On 4/17/26 12:44, Alex Bennée wrote:
> While sanity checking a create blob operation the use of the auto
> freed res variable could lead to inadvertently freeing an existing
> blob.
> 
> Avoid this by in-lining the virtio_gpu_virgl_find_resource() check as
> the value is not needed anyway.
> 
> While at it add a comment to the end and use g_steal_pointer to make
> it clearer the object lifetime exceeds the function bounds if we pass
> all the checks.
> 
> Fixes: 7c092f17cce (virtio-gpu: Handle resource blob commands)
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: qemu-stable@nongnu.org
> ---
>  hw/display/virtio-gpu-virgl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index b7a2d160ddd..add85bd4e61 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -830,8 +830,7 @@ static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
>          return;
>      }
>  
> -    res = virtio_gpu_virgl_find_resource(g, cblob.resource_id);
> -    if (res) {
> +    if (virtio_gpu_virgl_find_resource(g, cblob.resource_id)) {
>          qemu_log_mask(LOG_GUEST_ERROR, "%s: resource already exists %d\n",
>                        __func__, cblob.resource_id);
>          cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> @@ -884,8 +883,9 @@ static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
>  
>      res->base.dmabuf_fd = info.fd;
>  
> +    /* Now live, cleaned up in virtio_gpu_virgl_resource_unref */
>      QTAILQ_INSERT_HEAD(&g->reslist, &res->base, next);
> -    res = NULL;
> +    g_steal_pointer(&res);
>  }
>  
>  static void virgl_cmd_resource_map_blob(VirtIOGPU *g,

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry

