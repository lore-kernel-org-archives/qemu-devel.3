Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A2DC4451B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 05:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlgRr-0006v6-4i; Mon, 20 Jul 2026 01:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1wlgRk-0006ua-7E; Mon, 20 Jul 2026 01:21:45 -0400
Received: from sender4-op-o11.zoho.com ([136.143.188.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1wlgRh-0007aw-OP; Mon, 20 Jul 2026 01:21:43 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1784524885; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Bb1GF4mJku8VpBb7zzHQ2z4EiExTG0nJCz/AXJfb7X0orXvTwqkUxXs0kN/gqDUBNbE+xs8f/Coi55Pb7xd6NtFV0B9LRw7yRCYqBU3hUpdM+XQfUJ15jKUwrnrHB8HY0bflNUeIK4K0kiRKsSTWkQlyY6BRx5inIAP4pstgCmo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784524885;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=48AFrF4se8ACX53XnlQHyeN7lFvzQ3ItcEj508mTzHs=; 
 b=msBMWcO/T+EKig8ksETn2h9n3zTlETbLb8/0w/Gh6xEVqavbF8lzxKJSki2pSjAZOyQgay3RvtkxzPwofzfp90aaqoJBTLGhH1F3vdXOd3dDlzMiWT/RlnzIOpsJeuhMLPIRTMh5fQ4rZrleYLxE6G1OIETI+toZkMiE7q+NSz4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784524885; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=48AFrF4se8ACX53XnlQHyeN7lFvzQ3ItcEj508mTzHs=;
 b=giY+QmzBPsD4PShMZTtxPUAODqtEcDtSrMMnAYzy8sDzcjwaaC+NVxBpaMlwZ4ob
 EK/QdxzSxel2wdqI6MabOQXEwU6DlxzrUP0K/DHxWVPriWErfw3bHGL5/3AUe0YZZds
 j3st2pMaf5NJYEKYQZLdpCaiyTV31DpddQquESpc=
Received: by mx.zohomail.com with SMTPS id 1784524883100714.1723671972308;
 Sun, 19 Jul 2026 22:21:23 -0700 (PDT)
Message-ID: <35907323-7733-4440-95e0-5bbbbb6e56c9@collabora.com>
Date: Mon, 20 Jul 2026 08:21:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/virtio-gpu: Remove the bytes_pp field
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-stable@nongnu.org
References: <20260719-bpp-v1-1-9b91946d6cf3@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260719-bpp-v1-1-9b91946d6cf3@rsg.ci.i.u-tokyo.ac.jp>
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

On 7/19/26 14:35, Akihiko Odaki wrote:
> virtio_gpu_do_set_scanout() validates the stride field of struct
> virtio_gpu_framebuffer against the bytes_pp field, but bytes_pp in the
> migration stream may be inconsistent with the format field, which
> pixman_image_create_bits() uses when it accesses the framebuffer.
> That validation is therefore incomplete.
> 
> To avoid the trouble of synchronizing the two fields, remove bytes_pp,
> and always derive its value from format. Removing bytes_pp is safe
> because no released version of QEMU uses its migrated value.
> 
> Fixes: 7b5574225429 ("hw/display: check frame buffer can hold blob")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
> Based-on: <20260715201055.2465320-1-marcandre.lureau@redhat.com>
> ("[PATCH] hw/display/virtio-gpu: validate stride against width on scanout")
> ---
>  include/hw/virtio/virtio-gpu.h |  1 -
>  hw/display/virtio-gpu.c        | 27 +++++++++++++++++----------
>  2 files changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index f69fc1946273..6f889ee84a16 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -65,7 +65,6 @@ struct virtio_gpu_simple_resource {
>  
>  struct virtio_gpu_framebuffer {
>      pixman_format_code_t format;
> -    uint32_t bytes_pp;
>      uint32_t width, height;
>      uint32_t stride;
>      uint32_t offset;
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index e00fb6effa50..660191d15f78 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -617,6 +617,11 @@ void virtio_gpu_update_scanout(VirtIOGPU *g,
>      scanout->fb = *fb;
>  }
>  
> +static uint32_t virtio_gpu_format_bytes_pp(pixman_format_code_t format)
> +{
> +    return DIV_ROUND_UP(PIXMAN_FORMAT_BPP(format), 8);
> +}
> +
>  static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
>                                        uint32_t scanout_id,
>                                        struct virtio_gpu_framebuffer *fb,
> @@ -625,6 +630,7 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
>                                        uint32_t *error)
>  {
>      struct virtio_gpu_scanout *scanout;
> +    uint32_t bytes_pp = virtio_gpu_format_bytes_pp(fb->format);
>      uint8_t *data;
>  
>      scanout = &g->parent_obj.scanout[scanout_id];
> @@ -646,10 +652,10 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
>          return false;
>      }
>  
> -    if (fb->stride < (uint64_t)fb->width * fb->bytes_pp) {
> +    if (fb->stride < (uint64_t)fb->width * bytes_pp) {
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: stride %u too small for width %u at %u bpp\n",
> -                      __func__, fb->stride, fb->width, fb->bytes_pp);
> +                      __func__, fb->stride, fb->width, bytes_pp);
>          *error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
>          return false;
>      }
> @@ -708,6 +714,7 @@ static void virtio_gpu_set_scanout(VirtIOGPU *g,
>      struct virtio_gpu_simple_resource *res;
>      struct virtio_gpu_framebuffer fb = { 0 };
>      struct virtio_gpu_set_scanout ss;
> +    uint32_t bytes_pp;
>  
>      VIRTIO_GPU_FILL_CMD(ss);
>      virtio_gpu_bswap_32(&ss, sizeof(ss));
> @@ -733,11 +740,11 @@ static void virtio_gpu_set_scanout(VirtIOGPU *g,
>      }
>  
>      fb.format = pixman_image_get_format(res->image);
> -    fb.bytes_pp = DIV_ROUND_UP(PIXMAN_FORMAT_BPP(fb.format), 8);
> +    bytes_pp = virtio_gpu_format_bytes_pp(fb.format);
>      fb.width  = pixman_image_get_width(res->image);
>      fb.height = pixman_image_get_height(res->image);
>      fb.stride = pixman_image_get_stride(res->image);
> -    fb.offset = ss.r.x * fb.bytes_pp + ss.r.y * fb.stride;
> +    fb.offset = ss.r.x * bytes_pp + ss.r.y * fb.stride;
>  
>      virtio_gpu_do_set_scanout(g, ss.scanout_id,
>                                &fb, res, &ss.r, &cmd->error);
> @@ -748,6 +755,7 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
>                                     uint64_t blob_size)
>  {
>      uint64_t fbend;
> +    uint32_t bytes_pp;
>  
>      fb->format = virtio_gpu_get_pixman_format(ss->format);
>      if (!fb->format) {
> @@ -757,19 +765,19 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
>          return false;
>      }
>  
> -    fb->bytes_pp = DIV_ROUND_UP(PIXMAN_FORMAT_BPP(fb->format), 8);
> +    bytes_pp = virtio_gpu_format_bytes_pp(fb->format);
>      fb->width = ss->width;
>      fb->height = ss->height;
>      fb->stride = ss->strides[0];
>  
> -    if (fb->stride < (uint64_t)fb->width * fb->bytes_pp) {
> +    if (fb->stride < (uint64_t)fb->width * bytes_pp) {
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: stride %u too small for width %u at %u bpp\n",
> -                      __func__, fb->stride, fb->width, fb->bytes_pp);
> +                      __func__, fb->stride, fb->width, bytes_pp);
>          return false;
>      }
>  
> -    fb->offset = ss->offsets[0] + ss->r.x * fb->bytes_pp + ss->r.y * fb->stride;
> +    fb->offset = ss->offsets[0] + ss->r.x * bytes_pp + ss->r.y * fb->stride;
>  
>      fbend = fb->offset;
>      fbend += (uint64_t) fb->stride * ss->r.height;
> @@ -1219,8 +1227,7 @@ static const VMStateDescription vmstate_virtio_gpu_scanout = {
>          VMSTATE_UINT32(cursor.pos.y, struct virtio_gpu_scanout),
>          VMSTATE_UINT32_TEST(fb.format, struct virtio_gpu_scanout,
>                              scanout_vmstate_after_v2),
> -        VMSTATE_UINT32_TEST(fb.bytes_pp, struct virtio_gpu_scanout,
> -                            scanout_vmstate_after_v2),
> +        VMSTATE_UNUSED_TEST(scanout_vmstate_after_v2, 4),
>          VMSTATE_UINT32_TEST(fb.width, struct virtio_gpu_scanout,
>                              scanout_vmstate_after_v2),
>          VMSTATE_UINT32_TEST(fb.height, struct virtio_gpu_scanout,
> 
> ---
> base-commit: 499039798cdad7d86b787fec0eaf1da4151c0f05
> change-id: 20260719-bpp-803a3544fb79
> prerequisite-message-id: <20260715201055.2465320-1-marcandre.lureau@redhat.com>
> prerequisite-patch-id: 2c43dfa5d6a955e0fa3e3ca39ce3038968d85e7a
> 
> Best regards,
> --  
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> 

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry

