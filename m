Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 168B4C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 16:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4L6V-00049U-4x; Wed, 09 Sep 2026 12:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x4L6T-00049H-1Z
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 12:24:53 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x4L6P-0000qr-OK
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 12:24:52 -0400
Received: from [192.168.10.145] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 689GOb79078937
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 10 Sep 2026 01:24:38 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=qvCZTWQSpQPGyF75pKEVal0T/bqvJdRokVmSr+D+ydM=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1788971078; v=1;
 b=Pbd9YiuICImnvkmMXj5KZn3T0X7qGe9vHKskx7IFvZslX53XPa4Wdq9Y6FCFYtXD
 WZqn6dxCd8si8PZ3yJzxsxEOVFFcvFkyhHZKaJzuNAdra/VOnXgeslDAbX9bXmKi
 Np1JtJ+rdWPdkR1HBWCvXr+xtNQXYdDgHfABiWq/mSgCFiuhpS/dq3bYQ0qOrC4o
 aJoDs/yCTU267y05FBDuXTgVLB1fJjaw8EAheP078v5jped2RGN3VWC3zIvAGsU3
 uwieQjCwSR0PjSZnua0xxDv9yoYEMF5xigV9LMipsD27FSU7pXj151D51DR4c+G7
 9g0wxkr/hQTGR/Vv6wsEHg==
Message-ID: <122c0938-08e2-423d-b1ea-578d630af81f@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 10 Sep 2026 01:24:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/24] ui/gtk: move draw_submitted from QemuDmaBuf to
 VirtualGfxConsole
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Alex Williamson
 <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20260909-virtio-gpu-cleanup-v3-0-99266590e79d@redhat.com>
 <20260909-virtio-gpu-cleanup-v3-7-99266590e79d@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260909-virtio-gpu-cleanup-v3-7-99266590e79d@redhat.com>
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

On 2026/09/09 20:03, Marc-André Lureau wrote:
> The draw_submitted flag on QemuDmaBuf is only used by the GTK display
> backend to gate the draw pipeline and prevent gl_block refcount
> imbalance when the guest submits frames faster than GTK draws them. It
> is not an intrinsic property of the DMA-BUF but transient display
> listener state.
> 
> Move it to VirtualGfxConsole, replacing the getter/setter calls with
> direct struct member access. Reset the flag when the active dmabuf is
> released in gd_gl_release_dmabuf().
> 
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/ui/dmabuf.h |  2 --
>   include/ui/gtk.h    |  1 +
>   ui/dmabuf.c         | 13 -------------
>   ui/gtk-egl.c        | 13 ++++++-------
>   ui/gtk-gl-area.c    | 10 +++++-----
>   ui/gtk.c            |  1 +
>   6 files changed, 13 insertions(+), 27 deletions(-)
> 
> diff --git a/include/ui/dmabuf.h b/include/ui/dmabuf.h
> index 381583bd536c..b972099859f2 100644
> --- a/include/ui/dmabuf.h
> +++ b/include/ui/dmabuf.h
> @@ -42,8 +42,6 @@ uint32_t qemu_dmabuf_get_backing_width(QemuDmaBuf *dmabuf);
>   uint32_t qemu_dmabuf_get_backing_height(QemuDmaBuf *dmabuf);
>   bool qemu_dmabuf_get_y0_top(QemuDmaBuf *dmabuf);
>   bool qemu_dmabuf_get_allow_fences(QemuDmaBuf *dmabuf);
> -bool qemu_dmabuf_get_draw_submitted(QemuDmaBuf *dmabuf);
>   void qemu_dmabuf_set_texture(QemuDmaBuf *dmabuf, uint32_t texture);
> -void qemu_dmabuf_set_draw_submitted(QemuDmaBuf *dmabuf, bool draw_submitted);
>   
>   #endif
> diff --git a/include/ui/gtk.h b/include/ui/gtk.h
> index 4b4ef50e3701..b66b9ca5c519 100644
> --- a/include/ui/gtk.h
> +++ b/include/ui/gtk.h
> @@ -59,6 +59,7 @@ typedef struct VirtualGfxConsole {
>       bool scanout_mode;
>       bool has_dmabuf;
>       int gl_fence_fd;
> +    bool draw_submitted;
>   #endif
>   } VirtualGfxConsole;
>   
> diff --git a/ui/dmabuf.c b/ui/dmabuf.c
> index b61dc7ad2783..16063dc62ae8 100644
> --- a/ui/dmabuf.c
> +++ b/ui/dmabuf.c
> @@ -26,7 +26,6 @@ struct QemuDmaBuf {
>       uint32_t  backing_height;
>       bool      y0_top;
>       bool      allow_fences;
> -    bool      draw_submitted;
>   };
>   
>   QemuDmaBuf *qemu_dmabuf_new(uint32_t width, uint32_t height,
> @@ -212,21 +211,9 @@ bool qemu_dmabuf_get_allow_fences(QemuDmaBuf *dmabuf)
>       return dmabuf->allow_fences;
>   }
>   
> -bool qemu_dmabuf_get_draw_submitted(QemuDmaBuf *dmabuf)
> -{
> -    assert(dmabuf != NULL);
> -
> -    return dmabuf->draw_submitted;
> -}
> -
>   void qemu_dmabuf_set_texture(QemuDmaBuf *dmabuf, uint32_t texture)
>   {
>       assert(dmabuf != NULL);
>       dmabuf->texture = texture;
>   }
>   
> -void qemu_dmabuf_set_draw_submitted(QemuDmaBuf *dmabuf, bool draw_submitted)
> -{
> -    assert(dmabuf != NULL);
> -    dmabuf->draw_submitted = draw_submitted;
> -}

Nit: This leaves a blank line at EOF.

Regards,
Akihiko Odaki

> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index c671aabd11b3..8623181336e9 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -86,10 +86,10 @@ void gd_egl_draw(VirtualConsole *vc)
>       if (vc->gfx.scanout_mode) {
>   #ifdef CONFIG_GBM
>           if (dmabuf) {
> -            if (!qemu_dmabuf_get_draw_submitted(dmabuf)) {
> +            if (!vc->gfx.draw_submitted) {
>                   return;
>               } else {
> -                qemu_dmabuf_set_draw_submitted(dmabuf, false);
> +                vc->gfx.draw_submitted = false;
>               }
>               qemu_console_hw_gl_block(vc->gfx.dcl.con, true);
>           }
> @@ -169,8 +169,7 @@ void gd_egl_refresh(DisplayChangeListener *dcl)
>   #endif
>       }
>   
> -    if (vc->gfx.guest_fb.dmabuf &&
> -        qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
> +    if (vc->gfx.guest_fb.dmabuf && vc->gfx.draw_submitted) {
>           gd_egl_draw(vc);
>           return;
>       }
> @@ -290,6 +289,7 @@ void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
>   
>       if (qemu_dmabuf_get_allow_fences(dmabuf)) {
>           vc->gfx.guest_fb.dmabuf = dmabuf;
> +        vc->gfx.draw_submitted = false;
>       }
>   #endif
>   }
> @@ -406,9 +406,8 @@ void gd_egl_flush(DisplayChangeListener *dcl,
>       VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
>       GtkWidget *area = vc->gfx.drawing_area;
>   
> -    if (vc->gfx.guest_fb.dmabuf &&
> -        !qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
> -        qemu_dmabuf_set_draw_submitted(vc->gfx.guest_fb.dmabuf, true);
> +    if (vc->gfx.guest_fb.dmabuf && !vc->gfx.draw_submitted) {
> +        vc->gfx.draw_submitted = true;
>           gtk_egl_set_scanout_mode(vc, true);
>       }
>   
> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> index 29d1b1e4116f..45c0c8c81a11 100644
> --- a/ui/gtk-gl-area.c
> +++ b/ui/gtk-gl-area.c
> @@ -82,10 +82,10 @@ void gd_gl_area_draw(VirtualConsole *vc)
>   
>   #ifdef CONFIG_GBM
>           if (dmabuf) {
> -            if (!qemu_dmabuf_get_draw_submitted(dmabuf)) {
> +            if (!vc->gfx.draw_submitted) {
>                   return;
>               } else {
> -                qemu_dmabuf_set_draw_submitted(dmabuf, false);
> +                vc->gfx.draw_submitted = false;
>               }
>               qemu_console_hw_gl_block(vc->gfx.dcl.con, true);
>           }
> @@ -319,9 +319,8 @@ void gd_gl_area_scanout_flush(DisplayChangeListener *dcl,
>   {
>       VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
>   
> -    if (vc->gfx.guest_fb.dmabuf &&
> -        !qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
> -        qemu_dmabuf_set_draw_submitted(vc->gfx.guest_fb.dmabuf, true);
> +    if (vc->gfx.guest_fb.dmabuf && !vc->gfx.draw_submitted) {
> +        vc->gfx.draw_submitted = true;
>           gtk_gl_area_set_scanout_mode(vc, true);
>       }
>       gtk_gl_area_queue_render(GTK_GL_AREA(vc->gfx.drawing_area));
> @@ -356,6 +355,7 @@ void gd_gl_area_scanout_dmabuf(DisplayChangeListener *dcl,
>   
>       if (qemu_dmabuf_get_allow_fences(dmabuf)) {
>           vc->gfx.guest_fb.dmabuf = dmabuf;
> +        vc->gfx.draw_submitted = false;
>       }
>   #endif
>   }
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 1c75b9ea3c4d..55e45e8445bc 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -593,6 +593,7 @@ static void gd_gl_release_dmabuf(DisplayChangeListener *dcl,
>       egl_dmabuf_release_texture(dmabuf);
>       if (vc->gfx.guest_fb.dmabuf == dmabuf) {
>           vc->gfx.guest_fb.dmabuf = NULL;
> +        vc->gfx.draw_submitted = false;
>       }
>   #endif
>   }
> 


