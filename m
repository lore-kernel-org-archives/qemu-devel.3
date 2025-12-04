Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E749D1D86A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 06:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR2ly-0003qH-Qg; Thu, 04 Dec 2025 01:25:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vR2lx-0003oi-9T
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 01:25:01 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vR2lt-00046E-UR
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 01:25:00 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5B46Nm8X046440
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 4 Dec 2025 15:24:44 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=fA8fFASsMh0LHHtx3YWB0U5HBWtTBQpiKMCHK3BQ57g=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1764829485; v=1;
 b=pwIzW5Got14R6ycUbhAtvydpbJ9MnGZX6Z+6Z15kYbxLQ7T51wYXgpNxupD8wdAd
 Zm85MMePNt+lvFvsQTyc7Douo886nY7oYjEUsFMqk+j05evlreKQhbjhiaNJWsmz
 TzYhuCnYG2JLs0gvaNEGSCkWe7Jy6O0g2tasjSbUaU5wAZyKl2e6kTTwocMubqCY
 h5ntEzWSNpy4/A8emqeh6XI6mVUtueyDgDh0gXNfyH1Yx7mQ2N3dWkZEtJgeOqC0
 UVKPJuJgMC4L9oiomXZwKOTU7NPNQH3L5IwGRl26Wte+G4ARdOPHZkzDQz22ZoFF
 6ftZ9/wyFzDtZS/9oYl3VA==
Message-ID: <0d24a45f-fff9-4a37-89cc-f1d9943c83a7@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 4 Dec 2025 15:23:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 6/7] console: add cleanup callback for ScanoutTexture
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20251203040754.94487-1-j@getutm.app>
 <20251203040754.94487-7-j@getutm.app>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251203040754.94487-7-j@getutm.app>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/12/03 13:07, Joelle van Dyne wrote:
> Before we introduce changes that allow for QemuConsole to take ownership
> of a texture handle, we need scaffolding that will allow us to callback
> into a cleanup function any time the ScanoutTexture becomes invalid, which
> is whenever the `scanout.kind` or `scanout.texture` gets updated.
> 
> The ordering is important: we need to first update the DisplayScanout,
> then we need to notify all the listeners, and once all the listeners have
> had the chance to finish using the previous native texture, we are safe to
> call the cleanup function. This means we need to hold on to the previous
> scanout native handle locally until all listeners are notified.
> 
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> ---
>   include/ui/console.h          |  9 +++++-
>   hw/display/virtio-gpu-virgl.c |  2 +-
>   ui/console.c                  | 56 +++++++++++++++++++++++++++++++----
>   3 files changed, 59 insertions(+), 8 deletions(-)
> 
> diff --git a/include/ui/console.h b/include/ui/console.h
> index a45b524c57..df9c083a16 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -149,6 +149,11 @@ typedef struct ScanoutTextureNative {
>       .type = SCANOUT_TEXTURE_NATIVE_TYPE_NONE \
>   })
>   
> +/**
> + * Cleanup callback function when ScanoutTexture is about to be destroyed
> + */
> +typedef void (*dpy_cleanup_texture)(ScanoutTextureNative *native);

Please name this typedef CamelCase as like others.

> +
>   typedef struct ScanoutTexture {
>       uint32_t backing_id;
>       bool backing_y_0_top;
> @@ -159,6 +164,7 @@ typedef struct ScanoutTexture {
>       uint32_t width;
>       uint32_t height;
>       ScanoutTextureNative native;
> +    dpy_cleanup_texture cb_cleanup;
>   } ScanoutTexture;
>   
>   typedef struct QemuUIInfo {
> @@ -347,7 +353,8 @@ void dpy_gl_scanout_texture(QemuConsole *con,
>                               uint32_t backing_id, bool backing_y_0_top,
>                               uint32_t backing_width, uint32_t backing_height,
>                               uint32_t x, uint32_t y, uint32_t w, uint32_t h,
> -                            ScanoutTextureNative native);
> +                            ScanoutTextureNative native,
> +                            dpy_cleanup_texture cb_cleanup);
>   void dpy_gl_scanout_dmabuf(QemuConsole *con,
>                              QemuDmaBuf *dmabuf);
>   void dpy_gl_cursor_dmabuf(QemuConsole *con, QemuDmaBuf *dmabuf,
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index e091eb0c76..b7bc095676 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -492,7 +492,7 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
>               info.flags & VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP,
>               info.width, info.height,
>               ss.r.x, ss.r.y, ss.r.width, ss.r.height,
> -            native);
> +            native, NULL);
>       } else {
>           dpy_gfx_replace_surface(
>               g->parent_obj.scanout[ss.scanout_id].con, NULL);
> diff --git a/ui/console.c b/ui/console.c
> index 9378afd53d..8271c36586 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -808,6 +808,41 @@ void dpy_gfx_update_full(QemuConsole *con)
>       dpy_gfx_update(con, 0, 0, w, h);
>   }
>   
> +struct scanout_change {
> +    ScanoutTextureNative native;
> +    dpy_cleanup_texture cb_cleanup;
> +};

Struct should have typedef according to: docs/devel/style.rst

Regards,
Akihiko Odaki

> +
> +#define SCANOUT_CHANGE_NONE ((struct scanout_change){ NO_NATIVE_TEXTURE })
> +
> +static struct scanout_change dpy_change_scanout_kind(DisplayScanout *scanout,
> +                                                     enum display_scanout kind)
> +{
> +    struct scanout_change change = SCANOUT_CHANGE_NONE;
> +
> +    /**
> +     * We cannot cleanup until the resource is no longer in use, so we record it
> +     * You MUST call dpy_complete_scanout_change after all listeners are updated
> +     */
> +    if (scanout->kind == SCANOUT_TEXTURE && scanout->texture.cb_cleanup) {
> +        change.native = scanout->texture.native;
> +        change.cb_cleanup = scanout->texture.cb_cleanup;
> +    }
> +    scanout->kind = kind;
> +
> +    return change;
> +}
> +
> +static void dpy_complete_scanout_change(struct scanout_change *change)
> +{
> +    /**
> +     * If we previously have a texture and cleanup is required, we call it now
> +     */
> +    if (change->native.type != SCANOUT_TEXTURE_NATIVE_TYPE_NONE && change->cb_cleanup) {
> +        change->cb_cleanup(&change->native);
> +    }
> +}
> +
>   void dpy_gfx_replace_surface(QemuConsole *con,
>                                DisplaySurface *surface)
>   {
> @@ -818,6 +853,7 @@ void dpy_gfx_replace_surface(QemuConsole *con,
>       DisplayChangeListener *dcl;
>       int width;
>       int height;
> +    struct scanout_change change = SCANOUT_CHANGE_NONE;
>   
>       if (!surface) {
>           if (old_surface) {
> @@ -833,7 +869,7 @@ void dpy_gfx_replace_surface(QemuConsole *con,
>   
>       assert(old_surface != new_surface);
>   
> -    con->scanout.kind = SCANOUT_SURFACE;
> +    change = dpy_change_scanout_kind(&con->scanout, SCANOUT_SURFACE);
>       con->surface = new_surface;
>       dpy_gfx_create_texture(con, new_surface);
>       QLIST_FOREACH(dcl, &s->listeners, next) {
> @@ -844,6 +880,7 @@ void dpy_gfx_replace_surface(QemuConsole *con,
>       }
>       dpy_gfx_destroy_texture(con, old_surface);
>       qemu_free_displaysurface(old_surface);
> +    dpy_complete_scanout_change(&change);
>   }
>   
>   bool dpy_gfx_check_format(QemuConsole *con,
> @@ -1002,9 +1039,10 @@ void dpy_gl_scanout_disable(QemuConsole *con)
>   {
>       DisplayState *s = con->ds;
>       DisplayChangeListener *dcl;
> +    struct scanout_change change = SCANOUT_CHANGE_NONE;
>   
>       if (con->scanout.kind != SCANOUT_SURFACE) {
> -        con->scanout.kind = SCANOUT_NONE;
> +        change = dpy_change_scanout_kind(&con->scanout, SCANOUT_NONE);
>       }
>       QLIST_FOREACH(dcl, &s->listeners, next) {
>           if (con != dcl->con) {
> @@ -1014,6 +1052,7 @@ void dpy_gl_scanout_disable(QemuConsole *con)
>               dcl->ops->dpy_gl_scanout_disable(dcl);
>           }
>       }
> +    dpy_complete_scanout_change(&change);
>   }
>   
>   void dpy_gl_scanout_texture(QemuConsole *con,
> @@ -1023,15 +1062,17 @@ void dpy_gl_scanout_texture(QemuConsole *con,
>                               uint32_t backing_height,
>                               uint32_t x, uint32_t y,
>                               uint32_t width, uint32_t height,
> -                            ScanoutTextureNative native)
> +                            ScanoutTextureNative native,
> +                            dpy_cleanup_texture cb_cleanup)
>   {
>       DisplayState *s = con->ds;
>       DisplayChangeListener *dcl;
> +    struct scanout_change change = SCANOUT_CHANGE_NONE;
>   
> -    con->scanout.kind = SCANOUT_TEXTURE;
> +    change = dpy_change_scanout_kind(&con->scanout, SCANOUT_TEXTURE);
>       con->scanout.texture = (ScanoutTexture) {
>           backing_id, backing_y_0_top, backing_width, backing_height,
> -        x, y, width, height, native,
> +        x, y, width, height, native, cb_cleanup
>       };
>       QLIST_FOREACH(dcl, &s->listeners, next) {
>           if (con != dcl->con) {
> @@ -1045,6 +1086,7 @@ void dpy_gl_scanout_texture(QemuConsole *con,
>                                                native);
>           }
>       }
> +    dpy_complete_scanout_change(&change);
>   }
>   
>   void dpy_gl_scanout_dmabuf(QemuConsole *con,
> @@ -1052,8 +1094,9 @@ void dpy_gl_scanout_dmabuf(QemuConsole *con,
>   {
>       DisplayState *s = con->ds;
>       DisplayChangeListener *dcl;
> +    struct scanout_change change = SCANOUT_CHANGE_NONE;
>   
> -    con->scanout.kind = SCANOUT_DMABUF;
> +    change = dpy_change_scanout_kind(&con->scanout, SCANOUT_DMABUF);
>       con->scanout.dmabuf = dmabuf;
>       QLIST_FOREACH(dcl, &s->listeners, next) {
>           if (con != dcl->con) {
> @@ -1063,6 +1106,7 @@ void dpy_gl_scanout_dmabuf(QemuConsole *con,
>               dcl->ops->dpy_gl_scanout_dmabuf(dcl, dmabuf);
>           }
>       }
> +    dpy_complete_scanout_change(&change);
>   }
>   
>   void dpy_gl_cursor_dmabuf(QemuConsole *con, QemuDmaBuf *dmabuf,


