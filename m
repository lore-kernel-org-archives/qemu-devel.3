Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5796BC55838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 04:00:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrpGJ-0006JT-Ts; Wed, 05 Aug 2026 23:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wrpGC-0006Iy-1D
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 23:59:12 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wrpG8-0007kl-CX
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 23:59:11 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6763x2fU023562
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 6 Aug 2026 12:59:02 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=m3lI0EV58vzyPtFq6Kblv60ssqqlf+jvhqbGaMm5PHI=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1785988742; v=1;
 b=B0pImNTZ7QOsiuK49P70YKUayH3ph9r1mYo0ZNh/Ma0BDHYUSI1vDV9J9zTY9KIo
 JeGaOrPqKjlX4GtBhHYrml6x4dFWVzTPpKJPu6GesxmyCDMcyXA4OiZwLcQr1XMK
 Or3Vs6icfjrbtyMSrcPR3JxCMhbkwoB4EyAt+OFofem4HuDYdXQl/Lui8Rcd5PzP
 cybbCFxO8A55vaI2DLpp9R3wnW7JvPrOkMkcdh57DujjklcGjMT4K7pZ6DVNvdtU
 ZkmO+AUATTBo/wTL9NH/JTMEdw2Rgt9cOTjB5IKSMUrb9ntAqz+7TQCIw/0v3VCt
 wCcboNjz/lHDDd2gy+MEcg==
Message-ID: <4c57fce5-f9ef-4327-ac78-f57f5822e387@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 6 Aug 2026 12:59:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] hw/display/qxl: validate primary surface stride
 against width
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20260805134425.249695-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260805134425.249695-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2026/08/05 22:44, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The existing validation in qxl_create_guest_primary() checks that
> abs(stride) * height fits in vgamem_size and that stride is 4-byte
> aligned, but never checks that abs(stride) is large enough to hold one
> row of pixels for the declared width and format.
> 
> A malicious guest can create a primary surface with a stride much
> smaller than width * bytes_per_pixel (e.g. stride=4 for a 64-wide 32bpp
> surface). The spice server rejects this via red_validate_surface(), but
> the return is void and QEMU unconditionally proceeds to set up the local
> rendering state. On the next display refresh, VNC or SDL reads width *
> bytes_pp per scanline from a region backed by only stride bytes per
> row, causing a host-side out-of-bounds read.
> 
> Add three checks in qxl_create_guest_primary() before creating the
> surface:
>   - reject unknown surface formats
>   - reject zero width or height
>   - reject surfaces where abs(stride) < width * bytes_per_pixel
> 
> Also fix three related issues in qxl-render.c:
>   - qxl_blit() used abs_stride to advance the dst pointer into the
>     DisplaySurface, but when stride is negative the DisplaySurface is a
>     packed buffer whose stride may be smaller. Use surface_stride()
>     instead.
>   - qxl_render_update_area_unlocked() uses guest_head0_width (set via
>     QXL_IO_MONITORS_CONFIG_ASYNC) without validating it against
>     abs_stride, bypassing the new validation. Clamp the effective width
>     to abs_stride / bytes_pp to prevent out-of-bounds access while
>     tolerating the normal transient where the monitor config arrives
>     before the primary surface is resized to match.
>   - Similarly, guest_head0_height bypasses qxl_create_guest_primary()
>     validation. Without clamping, abs_stride * height can overrun
>     vgamem_size, and the product can also overflow 32 bits (e.g.
>     abs_stride=16 MiB, height=256 wraps to zero), defeating the
>     qxl_phys2virt() bounds check. Clamp height to
>     vgamem_size / abs_stride to prevent both.
> 
> Fixes: CVE-2026-16271
> Fixes: a19cbfb34642 ("spice: add qxl device")
> Fixes: 979f7ef8966b ("qxl: use guest_monitor_config for local renderer.")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3637
> Reported-by: huntr bubble
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> ---
> v4:
>   - do not flag zero dimensions as guest bug in render path,
>     since QXL_MODE_UNDEFINED starts with a zeroed primary surface
>   - clamp negative-stride to the surface height, so qxl_blit()
>     cannot walk before it
>   - tweak commit message
> ---
>   hw/display/qxl.h        |  2 ++
>   hw/display/qxl-render.c | 49 ++++++++++++++++++----------------
>   hw/display/qxl.c        | 59 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 87 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/display/qxl.h b/hw/display/qxl.h
> index 48d664f77736..6f5b96fe86cc 100644
> --- a/hw/display/qxl.h
> +++ b/hw/display/qxl.h
> @@ -181,6 +181,8 @@ void qxl_spice_oom(PCIQXLDevice *qxl);
>   void qxl_spice_reset_memslots(PCIQXLDevice *qxl);
>   void qxl_spice_reset_image_cache(PCIQXLDevice *qxl);
>   void qxl_spice_reset_cursor(PCIQXLDevice *qxl);
> +bool qxl_format_bpp(PCIQXLDevice *qxl, SpiceSurfaceFmt format,
> +                    uint32_t *bytes_pp, uint32_t *bits_pp);
>   
>   /* qxl-logger.c */
>   int qxl_log_cmd_cursor(PCIQXLDevice *qxl, QXLCursorCmd *cmd, int group_id);
> diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
> index 4799c9e8befd..57820f211fe6 100644
> --- a/hw/display/qxl-render.c
> +++ b/hw/display/qxl-render.c
> @@ -27,6 +27,7 @@
>   static void qxl_blit(PCIQXLDevice *qxl, QXLRect *rect)
>   {
>       DisplaySurface *surface = qemu_console_surface(qxl->vga.con);
> +    int dst_stride = surface_stride(surface);
>       uint8_t *dst = surface_data(surface);
>       uint8_t *src;
>       int len, i;
> @@ -45,14 +46,14 @@ static void qxl_blit(PCIQXLDevice *qxl, QXLRect *rect)
>       } else {
>           src += rect->top * qxl->guest_primary.abs_stride;
>       }
> -    dst += rect->top  * qxl->guest_primary.abs_stride;
> +    dst += rect->top  * dst_stride;
>       src += rect->left * qxl->guest_primary.bytes_pp;
>       dst += rect->left * qxl->guest_primary.bytes_pp;
>       len  = (rect->right - rect->left) * qxl->guest_primary.bytes_pp;
>   
>       for (i = rect->top; i < rect->bottom; i++) {
>           memcpy(dst, src, len);
> -        dst += qxl->guest_primary.abs_stride;
> +        dst += dst_stride;
>           src += qxl->guest_primary.qxl_stride;
>       }
>   }
> @@ -64,27 +65,9 @@ void qxl_render_resize(PCIQXLDevice *qxl)
>       qxl->guest_primary.qxl_stride = sc->stride;
>       qxl->guest_primary.abs_stride = abs(sc->stride);
>       qxl->guest_primary.resized++;
> -    switch (sc->format) {
> -    case SPICE_SURFACE_FMT_16_555:
> -        qxl->guest_primary.bytes_pp = 2;
> -        qxl->guest_primary.bits_pp = 15;
> -        break;
> -    case SPICE_SURFACE_FMT_16_565:
> -        qxl->guest_primary.bytes_pp = 2;
> -        qxl->guest_primary.bits_pp = 16;
> -        break;
> -    case SPICE_SURFACE_FMT_32_xRGB:
> -    case SPICE_SURFACE_FMT_32_ARGB:
> -        qxl->guest_primary.bytes_pp = 4;
> -        qxl->guest_primary.bits_pp = 32;
> -        break;
> -    default:
> -        fprintf(stderr, "%s: unhandled format: %x\n", __func__,
> -                qxl->guest_primary.surface.format);
> -        qxl->guest_primary.bytes_pp = 4;
> -        qxl->guest_primary.bits_pp = 32;
> -        break;
> -    }
> +    /* fallback to default bpp if format is unknown */
> +    qxl_format_bpp(qxl, sc->format, &qxl->guest_primary.bytes_pp,
> +                   &qxl->guest_primary.bits_pp);

sc->format is a raw guest-little-endian field. On a big-endian host, 
every valid format misses the switch and qxl_format_bpp() now latches 
guest_bug, disabling command-ring and I/O processing. Previously this 
function merely used its fallback, so the device-wide failure is 
introduced here.

>   }
>   
>   static void qxl_set_rect_to_surface(PCIQXLDevice *qxl, QXLRect *area)
> @@ -103,6 +86,26 @@ static void qxl_render_update_area_unlocked(PCIQXLDevice *qxl)
>       int height = qxl->guest_head0_height ?: qxl->guest_primary.surface.height;
>       int i;
>   
> +    if (width <= 0 || height <= 0) {
> +        goto end;
> +    }
> +
> +    if (qxl->guest_primary.bytes_pp > 0) {
> +        int max_width = qxl->guest_primary.abs_stride
> +                        / qxl->guest_primary.bytes_pp;
> +        width = MIN(width, max_width);
> +    }
> +
> +    if (qxl->guest_primary.qxl_stride < 0) {
> +        /* qxl_blit() uses the primary height to find the first scanline. */
> +        height = MIN(height, (int)qxl->guest_primary.surface.height);
> +    }
> +
> +    if (qxl->guest_primary.abs_stride > 0) {
> +        int max_height = qxl->vgamem_size / qxl->guest_primary.abs_stride;
> +        height = MIN(height, max_height);
> +    }

qxl_render_update_area_unlocked() maps abs_stride * height, but 
qxl_blit() indexes from the declared surface.height. When the monitor 
height is smaller, a permitted dirty row can read beyond the span 
validated by qxl_phys2virt().

Regards,
Akihiko Odaki

> +
>       if (qxl->guest_primary.resized) {
>           qxl->guest_primary.resized = 0;
>           qxl->guest_primary.data = qxl_phys2virt(qxl,
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index b7d871b9ee33..384b8767b8e6 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -1489,6 +1489,47 @@ static void qxl_create_guest_primary_complete(PCIQXLDevice *qxl)
>       qxl_render_resize(qxl);
>   }
>   
> +/*
> + * Convert a SpiceSurfaceFormat to bytes per pixel and bits per pixel.
> + *
> + * Only valid for surface suitable for rendering.
> + */
> +bool qxl_format_bpp(PCIQXLDevice *qxl, SpiceSurfaceFmt format,
> +                    uint32_t *bytes_pp, uint32_t *bits_pp)
> +{
> +    uint32_t bypp = 4;
> +    uint32_t bipp = 32;
> +    bool ret = true;
> +
> +    switch (format) {
> +    case SPICE_SURFACE_FMT_16_555:
> +        bypp = 2;
> +        bipp = 15;
> +        break;
> +    case SPICE_SURFACE_FMT_16_565:
> +        bypp = 2;
> +        bipp = 16;
> +        break;
> +    case SPICE_SURFACE_FMT_32_xRGB:
> +    case SPICE_SURFACE_FMT_32_ARGB:
> +        bypp = 4;
> +        bipp = 32;
> +        break;
> +    default:
> +        ret = false;
> +        qxl_set_guest_bug(qxl, "%s: unhandled format: %x", __func__, format);
> +    }
> +
> +    if (bytes_pp != NULL) {
> +        *bytes_pp = bypp;
> +    }
> +    if (bits_pp != NULL) {
> +        *bits_pp = bipp;
> +    }
> +
> +    return ret;
> +}
> +
>   static void qxl_create_guest_primary(PCIQXLDevice *qxl, int loadvm,
>                                        qxl_async_io async)
>   {
> @@ -1496,6 +1537,7 @@ static void qxl_create_guest_primary(PCIQXLDevice *qxl, int loadvm,
>       QXLSurfaceCreate *sc = &qxl->guest_primary.surface;
>       uint32_t requested_height = le32_to_cpu(sc->height);
>       int requested_stride = le32_to_cpu(sc->stride);
> +    uint32_t bytes_pp;
>   
>       if (requested_stride == INT32_MIN ||
>           abs(requested_stride) * (uint64_t)requested_height
> @@ -1532,6 +1574,23 @@ static void qxl_create_guest_primary(PCIQXLDevice *qxl, int loadvm,
>           return;
>       }
>   
> +    if (!qxl_format_bpp(qxl, surface.format, &bytes_pp, NULL)) {
> +        return;
> +    }
> +
> +    if (surface.width == 0 || surface.height == 0) {
> +        qxl_set_guest_bug(qxl, "%s: zero dimension %ux%u",
> +                          __func__, surface.width, surface.height);
> +        return;
> +    }
> +
> +    if ((uint64_t)surface.width * bytes_pp > abs(surface.stride)) {
> +        qxl_set_guest_bug(qxl, "%s: stride too small for width:"
> +                          " stride %d width %u bpp %u",
> +                          __func__, surface.stride, surface.width, bytes_pp);
> +        return;
> +    }
> +
>       surface.mouse_mode = true;
>       surface.group_id   = MEMSLOT_GROUP_GUEST;
>       if (loadvm) {


