Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F5AC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weBNq-0005n4-7z; Mon, 29 Jun 2026 08:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1weBNo-0005mf-Ey
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:46:40 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1weBNl-000333-Ov
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:46:39 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-80cebd41372so14100107b3.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:46:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782737196; cv=none;
 d=google.com; s=arc-20260327;
 b=lKwz9DD9XhNFrA+T+EmLCIfGkl9XX5CgSMVYn6HGTryF0HlSUubT0QYNSAjOwE53r6
 YJciP/uGfpAx669BZu2kjVRbQGGddXPqXvoXgPF2B57ek3nXC7nw9JJgaDYidjJnkMaT
 K98wK0mr7ZGVBkh5j0Sk5nV2XHTNUnlDy1WEArycroDoZNjO1F16dLchbEdiN8usgdPd
 BaI9BzrOS5Vs8DRnonL1X0g875Y2niXePKDmu2Lp6V7mmgP82eRyTJHmHqs/tDy6ox3L
 Kzev+PBrFzxHohIm4xDgmXJ28wa49PJ3Qn8SLMifrpk9n380/51jyIQVzQB9D7kzI2d9
 e17w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vI80sHi/tt8TOPOauDHywy8KK54fitIt0MNEuElYMT4=;
 fh=GIU+FyOM+eiO1tYKbHGSJ9iUu0d9Nn25uUBQaeMGCdg=;
 b=UpIgVzK71do0vYMOpAWK78RTIBcUe2kQl1kozkoi+p3umvVe0SSjpmm/d+jmG+Fcvb
 BOGOi+zzWmrlRdFh/MK0XhI+YQPaaZ7CN+U8P1++c6padY7FHp+ti/c8og6yM11CssTv
 Kwa9VRHdvVrMeaJ7dVAJdtMGr0dKFljm3gsFTpHz7/9UVCgp/PKvA0RNeSs06chGj9sB
 gS9vBmsgVLTwj0mPU7YHP4hpJ408zmk9k8r2c8j633aErP3um5c5JIgesud3/vFRdrEu
 dJf8Si4ML0EQjclaEktBZ/ntd8RzZQHb6QyEYEur+x88KDlGrFWmGdUjoQdIgvk80ySd
 6lrg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782737196; x=1783341996; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vI80sHi/tt8TOPOauDHywy8KK54fitIt0MNEuElYMT4=;
 b=e7YTzcXjcuwV6f/qZQLvAVoRBq/J5jd79+5Zyt7DnWNFJ473KnPsO2SMadyBAphoBt
 jOSEFcueakRbd1Sv+/PbTC7/UaW3FfDYff398PSqzkWx3NXAtiXX4+RMIPvDsgIQYNgS
 KwkpnIfdqvk//Q6ffJ1We51VWCoOGC/j3Y7fxCSzcw0yPvsa0UmU/VAthrBYpCAE9Kk6
 2yVoYOBaxoI4wez++SDz3jH928+QhAqigdcu8aRGCQDXNWgvl/KNSCjxlJhANuOHakWg
 zy6FqYNY6G2fRNcD7QduYFmpxvtdVLsmGxr0hE7t1zJ3syQdkj0km5ZJO8mRHTUvNIlI
 Ghkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782737196; x=1783341996;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vI80sHi/tt8TOPOauDHywy8KK54fitIt0MNEuElYMT4=;
 b=mRkSjQjwN3XSI+uKK08hec0wdcgZi6erPdtD4hQzDKCO5632Bvn39NE4GvzW7Xtt/3
 mdj0Ihy07lYLBQc4GcFkHSILEzVQKJJJOmtwuwNmxCmHCHLEfnqi8LsQEdBuxCVqrNTX
 jxw5WwUwbgGY4xV0iN5Y/er6BlhpMkS0Fk5/nalqxTnLPHdM6tWxs0ZbXgiqnpfia1Q7
 pbiflg9LORPHQJ3nId4UTkepOTjRNMNTkeYU+o8W8qEnxJy5sAWaK601Ab0vkcnwWSp4
 Qj2s7NhVFDlnTKX8C5LSyYjURAVpMaRJMtG9bja+g63cp+xYnK8ENnOKoca9PHVe/xxm
 hQFA==
X-Gm-Message-State: AOJu0YzOjZZ7jMdRm1ISzPjF1rO+24M2S12WK83Yj3hGxpiAxmNbF5Bo
 BCfDFcPDepnME/q6tSlSTiRSKDwhIKS+b0VBTurlWwx4Gm9urfzXgMmfxFBNc6Y2aSCEax3WLk0
 G1Q0jDK9pl/fsWd/fDp/nkUdy8lzrQPbgfMw/
X-Gm-Gg: AfdE7cneueRrFBkTXOJ/B2hnqT+pXYH8fjsFx0c/klukBE1MVJ5ZV9Av3JPxyKwEmsi
 h/Hf9SeXHHweyWNZIJyK3H+lPSbs48mC8iCMT+TLSNJ8aGiA3koP8PfGG7Lzp4LU0JYyi9vphnG
 6GORy4egL3aN2hd1VoA7c3D532lWFuosVO/f62gtP3n04vtzdXzj7G1Pry6YJ0ojP9WUZUf9lhx
 h/O92HVlds8Fy8wjkSGllVLHvJ6yINlwo8+C7gNqYpRcpl8FNp5cseJaogH23gZpwyJ+K3f7gJL
 qEsyECl8vuGE4xL+1mr71O/JIKFx
X-Received: by 2002:a05:690c:6185:b0:80c:3b36:2026 with SMTP id
 00721157ae682-80c3b3624dfmr95398487b3.25.1782737196382; Mon, 29 Jun 2026
 05:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260628-gtk-v2-1-1e4839012f09@rsg.ci.i.u-tokyo.ac.jp>
 <CAMxuvaxrGgD7EAwWdGG0BZgiyXPNrExExTVnANr6M2gw5+DzNQ@mail.gmail.com>
 <b57f9a79-f48d-4fab-a70f-e26f26fcfcbf@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <b57f9a79-f48d-4fab-a70f-e26f26fcfcbf@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 29 Jun 2026 16:46:23 +0400
X-Gm-Features: AVVi8CfhDCtq7MmD2wuFflsWMp0XvxY3Sei_8wCgm-vAyimtR5zL0Jun43UZtGE
Message-ID: <CAJ+F1CJoSn9qaA4JtNz1c3ZoAUJP1dPk58AOF-sQbf-t_YqKTA@mail.gmail.com>
Subject: Re: [PATCH v2] ui/gtk: Narrow DMA-BUF critical section
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yw1-x1135.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi

On Mon, Jun 29, 2026 at 4:24=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/06/29 18:20, Marc-Andr=C3=A9 Lureau wrote:
> > Hi Akihiko
> >
> > On Sun, Jun 28, 2026 at 5:59=E2=80=AFPM Akihiko Odaki
> > <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> >>
> >> Scanout operations need to be properly ordered to avoid tearing. The
> >> virtio specification allows the guest to use pageflip. With pageflip,
> >> the guest only modifies the invisible framebuffer while the host scans
> >> out the visible framebuffer. The guest may choose not to use pageflip =
to
> >> avoid its overhead, accepting the risk of tearing.
> >>
> >> ui/gtk performs the following procedure to flush a scanout:
> >> 1) Queue a draw event.
> >> 2) The draw event gets triggered.
> >> 3) Blit the guest framebuffer to the host framebuffer.
> >>
> >> When flushing a DMA-BUF scanout, ui/gtk blocks the device before 2) if
> >> possible and unblocks it after 3) to enforce proper ordering. However,
> >> blocking the device before 2) has two problems.
> >>
> >> First, it can leave the device blocked indefinitely because GTK
> >> sometimes decides to cancel 2) when the window is not visible for
> >> example. ui/gtk regularly repeats 1) as a workaround, but it is not
> >> applicable to GtkGLArea because it causes display corruption.
> >>
> >> Second, the behavior is inconsistent with the other types of scanout
> >> that leave the device unblocked between 1) and 2).
> >>
> >> To fix these problems, let ui/gtk block the device only when the
> >> queued draw event runs, immediately before 3). Blocking before that is
> >> unnecessary since ui/gtk does not access the framebuffer yet. If the
> >> guest does not use pageflip but instead updates the visible framebuffe=
r
> >> directly, ui/gtk should not add the overhead of a pre-draw block.
> >>
> >
> > Are you saying this won't create undesired drawing artefacts?
> >
> > I don't see how the guest synchronizes with the display if the gl cmds
> > keep running.
>
> The point of pageflip is to avoid drawing artifacts when scanout and
> rendering can happen concurrently. The virtio-gpu spec adopts that
> model: the guest can switch the scanout resource with
> VIRTIO_GPU_CMD_SET_SCANOUT instead of rendering into the resource
> currently being scanned out.
>
> So, if a guest chooses not to use pageflip on a system where scanout and
> rendering run concurrently, it can get artifacts. This change does not
> try to make that case artifact-free.
>
> What this patch is trying to preserve is the display model already used
> by the 2D code and by the other display implementations: QEMU keeps the
> framebuffer stable while it is actually reading/blitting it. The extra
> blocking before the queued draw callback runs does not add
> synchronization for that model, because ui/gtk is not accessing the
> framebuffer yet.

I am missing some pieces to understand how the guest will be fenced.
How does qemu say: "I have consumed the resource (for the
flush/display), you can reuse it"?

>
> Regards,
> Akihiko Odaki
>
> >
> >> ui/gtk still blocks the device during 3) for DMA-BUF. Unlike the other
> >> scanout types, 3) can happen asynchronously with the device for a
> >> DMA-BUF, so ui/gtk needs to keep the visible guest framebuffer stable
> >> for the blit.
> >>
> >> With the problems fixed, the workaround to repeat 1) is no longer
> >> necessary and is removed.
> >>
> >> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >> ---
> >> Changes in v2:
> >> - Clarified that guests can use pageflip to avoid tearing while ui/gtk
> >>    only needs to keep the DMA-BUF stable during the blit.
> >> - Avoided the unprotected gd_egl_scanout_flush() fallback by queuing
> >>    redraws through gtk_widget_queue_draw_area().
> >> - Link to v1: https://lore.kernel.org/qemu-devel/20260115-gtk-v1-1-57f=
49e856408@rsg.ci.i.u-tokyo.ac.jp
> >> ---
> >>   ui/gtk-egl.c     |  6 ++----
> >>   ui/gtk-gl-area.c | 23 +----------------------
> >>   2 files changed, 3 insertions(+), 26 deletions(-)
> >>
> >> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> >> index 7c5c9b2428c2..adc81f34b1c8 100644
> >> --- a/ui/gtk-egl.c
> >> +++ b/ui/gtk-egl.c
> >> @@ -91,6 +91,7 @@ void gd_egl_draw(VirtualConsole *vc)
> >>               } else {
> >>                   qemu_dmabuf_set_draw_submitted(dmabuf, false);
> >>               }
> >> +            qemu_console_hw_gl_block(vc->gfx.dcl.con, true);
> >>           }
> >>   #endif
> >>           gd_egl_scanout_flush(&vc->gfx.dcl, 0, 0, vc->gfx.w, vc->gfx.=
h);
> >> @@ -405,14 +406,11 @@ void gd_egl_flush(DisplayChangeListener *dcl,
> >>
> >>       if (vc->gfx.guest_fb.dmabuf &&
> >>           !qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
> >> -        qemu_console_hw_gl_block(vc->gfx.dcl.con, true);
> >>           qemu_dmabuf_set_draw_submitted(vc->gfx.guest_fb.dmabuf, true=
);
> >>           gtk_egl_set_scanout_mode(vc, true);
> >> -        gtk_widget_queue_draw_area(area, x, y, w, h);
> >> -        return;
> >>       }
> >>
> >> -    gd_egl_scanout_flush(&vc->gfx.dcl, x, y, w, h);
> >> +    gtk_widget_queue_draw_area(area, x, y, w, h);
> >>   }
> >>
> >>   void gtk_egl_init(DisplayGLMode mode)
> >> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> >> index 23806b9d01bb..29497019ee46 100644
> >> --- a/ui/gtk-gl-area.c
> >> +++ b/ui/gtk-gl-area.c
> >> @@ -86,6 +86,7 @@ void gd_gl_area_draw(VirtualConsole *vc)
> >>               } else {
> >>                   qemu_dmabuf_set_draw_submitted(dmabuf, false);
> >>               }
> >> +            qemu_console_hw_gl_block(vc->gfx.dcl.con, true);
> >>           }
> >>   #endif
> >>
> >> @@ -163,27 +164,6 @@ void gd_gl_area_refresh(DisplayChangeListener *dc=
l)
> >>
> >>       gd_update_monitor_refresh_rate(vc, vc->window ? vc->window : vc-=
>gfx.drawing_area);
> >>
> >> -    if (vc->gfx.guest_fb.dmabuf &&
> >> -        qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
> >> -        /*
> >> -         * gd_egl_refresh() calls gd_egl_draw() if a DMA-BUF draw has=
 already
> >> -         * been submitted, but this function does not call gd_gl_area=
_draw() in
> >> -         * such a case due to display corruption.
> >> -         *
> >> -         * Calling gd_gl_area_draw() is necessary to prevent a situat=
ion where
> >> -         * there is a scheduled draw event but it won't happen bacaus=
e the window
> >> -         * is currently in inactive state (minimized or tabified). If=
 draw is not
> >> -         * done for a long time, gl_block timeout and/or fence timeou=
t (on the
> >> -         * guest) will happen eventually.
> >> -         *
> >> -         * However, it is found that calling gd_gl_area_draw() here c=
auses guest
> >> -         * display corruption on a Wayland Compositor. The display co=
rruption is
> >> -         * more serious than the possible fence timeout so gd_gl_area=
_draw() is
> >> -         * omitted for now.
> >> -         */
> >> -        return;
> >> -    }
> >> -
> >>       if (!vc->gfx.gls) {
> >>           if (!gtk_widget_get_realized(vc->gfx.drawing_area)) {
> >>               return;
> >> @@ -347,7 +327,6 @@ void gd_gl_area_scanout_flush(DisplayChangeListene=
r *dcl,
> >>
> >>       if (vc->gfx.guest_fb.dmabuf &&
> >>           !qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
> >> -        qemu_console_hw_gl_block(vc->gfx.dcl.con, true);
> >>           qemu_dmabuf_set_draw_submitted(vc->gfx.guest_fb.dmabuf, true=
);
> >>           gtk_gl_area_set_scanout_mode(vc, true);
> >>       }
> >>
> >> ---
> >> base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
> >> change-id: 20260115-gtk-424c2b910e65
> >>
> >> Best regards,
> >> --
> >> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>
> >
>
>

