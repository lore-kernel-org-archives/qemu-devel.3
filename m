Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF241D40D13
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 00:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8TzP-0004uV-TA; Tue, 05 Nov 2024 19:33:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t8TzN-0004uJ-Um
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 19:33:37 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t8TzM-0008K7-2g
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 19:33:37 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1730853209; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=UuSNcybz/PH8fGXgaOUf11OSxEf4w9MrGaeLovgFtcwvKOpjk8pibplsO1zVBBp0azE6BhdondKS7g+CqvO54AeCUdnsFXu5kuIWKnKVPRm+wXzc0db60bDUCkryfT1io1MxKFE5fk+ocO/MQUhHUhdrTUcVbw3k9BoQUqzIVUg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1730853209;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=CDnI0H+Oq1DthbZcclTaYxpDO0RBjyEmb9cwehgFPKw=; 
 b=gTI6s7ScGcc2Yk3Rk7F+1glUr5inXYV0xUD4MEhTQzYeL/b/l7zwIEPYuXHKQlUhgxJXak0nSOVL2nFavBLJkT0yLhEKS+o+xnrEXoiLxIy3pBrCZvUSdkBEHvUpc+XcZdRI3nmVQkrWiZfY9Iv4395IN1poovOQRZGLp4AII9M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730853209; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=CDnI0H+Oq1DthbZcclTaYxpDO0RBjyEmb9cwehgFPKw=;
 b=LCMSrbQbAUhL2AK4DQsZdcy4sEwEuYGb1eOYfd1HTWed/D7ZgR5ijF6nHu0oOpMi
 XxPVWLw6zGupbUwMN2jvPQxHjDH89dBkxEMZZRwoxosO9CEjnzDLMQvTEHOMgn0gYY5
 /Gk21b4yXwvJK2v+/u/4Mu0bZkgqCEAr/NOcF3Pk=
Received: by mx.zohomail.com with SMTPS id 1730853206524538.3362883086296;
 Tue, 5 Nov 2024 16:33:26 -0800 (PST)
Message-ID: <21888d29-b9ee-4c1c-99b3-09f980d7cfd0@collabora.com>
Date: Wed, 6 Nov 2024 03:33:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/display: factor out the scanout blob to fb
 conversion
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>
References: <20241104165348.2361299-1-alex.bennee@linaro.org>
 <20241104165348.2361299-2-alex.bennee@linaro.org>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20241104165348.2361299-2-alex.bennee@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 11/4/24 19:53, Alex Bennée wrote:
> There are two identical sequences of a code doing the same thing that
> raise warnings with Coverity. Before fixing those issues lets factor
> out the common code into a helper function we can share.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  include/hw/virtio/virtio-gpu.h | 15 +++++++++
>  hw/display/virtio-gpu-virgl.c  | 21 +-----------
>  hw/display/virtio-gpu.c        | 60 +++++++++++++++++++++-------------
>  3 files changed, 53 insertions(+), 43 deletions(-)
> 
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index 553799b8cc..90e4abe788 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -333,6 +333,21 @@ void virtio_gpu_update_cursor_data(VirtIOGPU *g,
>                                     struct virtio_gpu_scanout *s,
>                                     uint32_t resource_id);
>  
> +/**
> + * virtio_gpu_scanout_blob_to_fb() - fill out fb based on scanout data
> + * fb: the frame-buffer descriptor to fill out
> + * ss: the scanout blob data
> + * blob_size: the maximum size the blob can accommodate

Nit: 'maximum size the blob can accommodate' makes it sound to me like
data will be copied into the blob. What about 'size of scanout blob data'.

> + *
> + * This will check we have enough space for the frame taking into
> + * account that stride for all but the last line.
> + *
> + * Returns true on success, otherwise logs guest error and returns false
> + */
> +bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
> +                                   struct virtio_gpu_set_scanout_blob *ss,
> +                                   uint64_t blob_size);
> +
>  /* virtio-gpu-udmabuf.c */
>  bool virtio_gpu_have_udmabuf(void);
>  void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res);
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index eedae7357f..35599cddab 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -852,26 +852,7 @@ static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
>          return;
>      }
>  
> -    fb.format = virtio_gpu_get_pixman_format(ss.format);
> -    if (!fb.format) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "%s: pixel format not supported %d\n",
> -                      __func__, ss.format);
> -        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> -        return;
> -    }
> -
> -    fb.bytes_pp = DIV_ROUND_UP(PIXMAN_FORMAT_BPP(fb.format), 8);
> -    fb.width = ss.width;
> -    fb.height = ss.height;
> -    fb.stride = ss.strides[0];
> -    fb.offset = ss.offsets[0] + ss.r.x * fb.bytes_pp + ss.r.y * fb.stride;
> -
> -    fbend = fb.offset;
> -    fbend += fb.stride * (ss.r.height - 1);
> -    fbend += fb.bytes_pp * ss.r.width;
> -    if (fbend > res->base.blob_size) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "%s: fb end out of range\n",
> -                      __func__);
> +    if (!virtio_gpu_scanout_blob_to_fb(&fb, &ss, res->blob_size)) {

This fails to compile, needs s/res->blob_size/res->base.blob_size/

../hw/display/virtio-gpu-virgl.c:855:53: error: 'struct
virtio_gpu_virgl_resource' has no member named 'blob_size'
  855 |     if (!virtio_gpu_scanout_blob_to_fb(&fb, &ss, res->blob_size)) {
      |                                                     ^~
../hw/display/virtio-gpu-virgl.c:808:14: error: unused variable 'fbend'
[-Werror=unused-variable]
  808 |     uint64_t fbend;
      |              ^~~~~
cc1: all warnings being treated as errors

Please correct in v2.

>          cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
>          return;
>      }
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index c0570ef856..e7ca8fd1cf 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -721,13 +721,48 @@ static void virtio_gpu_set_scanout(VirtIOGPU *g,
>                                &fb, res, &ss.r, &cmd->error);
>  }
>  
> +bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
> +                                   struct virtio_gpu_set_scanout_blob *ss,
> +                                   uint64_t blob_size)
> +{
> +    uint64_t fbend;
> +
> +    fb->format = virtio_gpu_get_pixman_format(ss->format);
> +    if (!fb->format) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: host couldn't handle guest format %d\n",
> +                      __func__, ss->format);
> +        return false;
> +    }
> +
> +    fb->bytes_pp = DIV_ROUND_UP(PIXMAN_FORMAT_BPP(fb->format), 8);
> +    fb->width = ss->width;
> +    fb->height = ss->height;
> +    fb->stride = ss->strides[0];
> +    fb->offset = ss->offsets[0] + ss->r.x * fb->bytes_pp + ss->r.y * fb->stride;
> +
> +    fbend = fb->offset;
> +    fbend += fb->stride * (ss->r.height - 1);
> +    fbend += fb->bytes_pp * ss->r.width;
> +
> +    if (fbend > blob_size) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: fb end out of range\n",
> +                      __func__);
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +
> +

Nit: extra newlines

-- 
Best regards,
Dmitry

