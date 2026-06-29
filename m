Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035A4C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 09:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we8AY-0000e5-8H; Mon, 29 Jun 2026 05:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1we8AQ-0000dZ-6H
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 05:20:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1we8AO-0008Pr-4P
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 05:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782724834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/7gox1afUBqGqCa3SRy96tT2Py3X9xkB9ybZTli7P0s=;
 b=DoN2DuR1gX4ttXnvRo5R+ZAEk2Jz2YYCu8Hkif6PYU1CgaaCH4Zn/5IFs/ryOgVr32LVR7
 p8ja4UPzfwf2jv7bSm0VKl5Kgf5J/LCTDibJdqjLIOVSZLhnlc4z8/rj5N0Bi///8glv9t
 d5elIAANQbCjaWdsASG9ryhTxnodIEI=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-dYsQlRPjOL2uD9ibwfVjkQ-1; Mon, 29 Jun 2026 05:20:32 -0400
X-MC-Unique: dYsQlRPjOL2uD9ibwfVjkQ-1
X-Mimecast-MFC-AGG-ID: dYsQlRPjOL2uD9ibwfVjkQ_1782724831
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-845bc2f62c9so2402036b3a.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 02:20:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782724831; cv=none;
 d=google.com; s=arc-20260327;
 b=HCTyu080qIh7D70xfqG5GNtZTvL5t4MFeIQl8pXq7i2TJQeIaKGl90gGbF8pSvpmzX
 4IDP+ROH0RG/9HPnkWDOvy3zLhCeX1Xdv/Hf0dC48tNQQ2tISgdkLNd4KNJy6da65hSk
 GyN7Y3efzhhKMLlRGvmowPRm5aMROEcC/B0dxMPGL5MuwhMCDdiZTr727Z8JuneNqriq
 NZ//S3Mmxiz/+8/17soSTpVlyiR4GK0M6SQY92l7/seU2TnPCnJ/ln1qhYNrgEcTsypz
 S2JFp2KYbvPWWGHmx7fmiTQUegL1xOvGysIoERMgms3EOZT5CmcDn1npJBOSSF7k43RC
 kzRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/7gox1afUBqGqCa3SRy96tT2Py3X9xkB9ybZTli7P0s=;
 fh=GIU+FyOM+eiO1tYKbHGSJ9iUu0d9Nn25uUBQaeMGCdg=;
 b=fWPADyRZDy4qcgT4CAMfVKLX+ofNBy8Hql3iIHlIkUxFZ44EULTBP8XoD9cSFX200T
 MRnWz789tS+MMJvVRJExFOO1WmBbucqjwy8Lw4a61jE2S1JZVJWYKZkGzULhao8QaCqk
 R9KrgLZg4u56MBmsbRhmUcB3IAO+LunjQF6p05737YtpmFu0IXhtyWrV+2LxQMyAD4NI
 WHHpz24v8IvGwLD/QrROExAwWY/81prQF5uJSkQc5tRhdEwfWumFWQ7hDmgM9JWENXjV
 +xkPF/p5ubdf5QQUjOv7rjw39L2x1VJLZfjkld6SyLKOr8K2Qkm35fd38nNq/IPoqSvR
 +QJA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782724831; x=1783329631; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/7gox1afUBqGqCa3SRy96tT2Py3X9xkB9ybZTli7P0s=;
 b=sdxin/4ONKpx1LxO6GF2KYqTHPdaMQJvvCHbVKIthAEWN8ecNGTzVrE/fzh4AEruPj
 Y/nDQJxawjvzQ6yPyOGr9SLjqbgKt53rTJKpO8VGirjemr0UxY1E7FAsrO6RK5X/AGlm
 ganEbuYBuPEDG4uauRZviPGsmp8KsxzNrdw1Jx6ZrxlN96GEQpGURXYDIJYm+GXOB7Ab
 kAk3sprnquX0rOksw3dIO9v42lKu1oOdPsKF2xzUMi+ioH3jF9Atvc3+9rISAYP8Bdr2
 RAxy4IgRS1HLykwPOUEemaMfnUV9Xj8umkPsBSB27Z7w9hp5PQwDQW0S1adMFVszee57
 tuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782724831; x=1783329631;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/7gox1afUBqGqCa3SRy96tT2Py3X9xkB9ybZTli7P0s=;
 b=U9qRaHYzOS9+6mn86zK/ICH4NNSyAONsQwgXXa3PfVJsqfTlR59rgSzudTz7iGx2IW
 WxV/OKbRbni5jxqn0LhsUb2zapJ7cpnWee2FEYBYMOsmM767uho4RMqKwsnPCJZug66q
 6HxknivcAhhG51yd0yi6wCGJwzk6aKeEMotrfT1kmaD/s1H1xsDyLQ4chKpiNebBFTf5
 7Nhp06oo8ctAlg0lpK+4yoUNus38aH63PrXl5j4j+8CSgas6ew145PTKbH2j4/rwIc5j
 wTGPKu4VSl6mU0uqNw/OxZ+xC5qq4+L39wya3gMa/SxmUYjIyEICVUDfIanHWDO7NTso
 U7wg==
X-Gm-Message-State: AOJu0Yw7FG98Pa5fUaPIXvZjAMxcqb8tmzcnm8x/yEHCvhvcCzpTAmUY
 eY3taRORl7RjV6U0fxpq6EyfLvjD8QMvwsa112i2IrB3hF1r7hKo03UhtG6rKIi544RQbOhpI/2
 fzgTUxSuRvNSgZMEFBoNL1s/tsjN9T3Oxm18otsM3jajQoTXhB6mQxDzikkMIW9kEoEmYvt4tQB
 cfFw6eBFnEaSl5e8jLHGI98ZsN9bd3Vao=
X-Gm-Gg: AfdE7ckLVn+hJ7mH3vySpZXVls0uTDF4vvcx3Z8N/OSg4gF1VIhkyKoNhzZo3QBwDz7
 yLLgSGWM0TveCVwb5cHDP9hTIJYIynYu3KfKGKtaQgIv7X4YIgdWsVaMsL6OJoY4PcD+wRHBY8+
 87Ktpf9PoLFYKpjY0gUwQ0HR/YoNrbYab7e5N2txGDlQLYhLfLg5F+hi9BUotWOYA4jved9GusB
 EtsEKZwOlscQd7MT7nNc+BbiGuy3wb8VOiyudJg+UkQ7yzZa4noubXRyKiDm71/TGC7KTEP2ZAt
 F9KdP3MkCBK9
X-Received: by 2002:a05:6a00:1248:b0:847:9015:e68c with SMTP id
 d2e1a72fcca58-8479015ef67mr1172070b3a.17.1782724830715; 
 Mon, 29 Jun 2026 02:20:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:1248:b0:847:9015:e68c with SMTP id
 d2e1a72fcca58-8479015ef67mr1172048b3a.17.1782724830121; Mon, 29 Jun 2026
 02:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260628-gtk-v2-1-1e4839012f09@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260628-gtk-v2-1-1e4839012f09@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 29 Jun 2026 13:20:18 +0400
X-Gm-Features: AVVi8Cdo5gpf1q-E-sbJWl2gHq8cX7efBOvAIp8pJg-6nD18fP7UfNAfZZMRsXo
Message-ID: <CAMxuvaxrGgD7EAwWdGG0BZgiyXPNrExExTVnANr6M2gw5+DzNQ@mail.gmail.com>
Subject: Re: [PATCH v2] ui/gtk: Narrow DMA-BUF critical section
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Akihiko

On Sun, Jun 28, 2026 at 5:59=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> Scanout operations need to be properly ordered to avoid tearing. The
> virtio specification allows the guest to use pageflip. With pageflip,
> the guest only modifies the invisible framebuffer while the host scans
> out the visible framebuffer. The guest may choose not to use pageflip to
> avoid its overhead, accepting the risk of tearing.
>
> ui/gtk performs the following procedure to flush a scanout:
> 1) Queue a draw event.
> 2) The draw event gets triggered.
> 3) Blit the guest framebuffer to the host framebuffer.
>
> When flushing a DMA-BUF scanout, ui/gtk blocks the device before 2) if
> possible and unblocks it after 3) to enforce proper ordering. However,
> blocking the device before 2) has two problems.
>
> First, it can leave the device blocked indefinitely because GTK
> sometimes decides to cancel 2) when the window is not visible for
> example. ui/gtk regularly repeats 1) as a workaround, but it is not
> applicable to GtkGLArea because it causes display corruption.
>
> Second, the behavior is inconsistent with the other types of scanout
> that leave the device unblocked between 1) and 2).
>
> To fix these problems, let ui/gtk block the device only when the
> queued draw event runs, immediately before 3). Blocking before that is
> unnecessary since ui/gtk does not access the framebuffer yet. If the
> guest does not use pageflip but instead updates the visible framebuffer
> directly, ui/gtk should not add the overhead of a pre-draw block.
>

Are you saying this won't create undesired drawing artefacts?

I don't see how the guest synchronizes with the display if the gl cmds
keep running.

> ui/gtk still blocks the device during 3) for DMA-BUF. Unlike the other
> scanout types, 3) can happen asynchronously with the device for a
> DMA-BUF, so ui/gtk needs to keep the visible guest framebuffer stable
> for the blit.
>
> With the problems fixed, the workaround to repeat 1) is no longer
> necessary and is removed.
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
> Changes in v2:
> - Clarified that guests can use pageflip to avoid tearing while ui/gtk
>   only needs to keep the DMA-BUF stable during the blit.
> - Avoided the unprotected gd_egl_scanout_flush() fallback by queuing
>   redraws through gtk_widget_queue_draw_area().
> - Link to v1: https://lore.kernel.org/qemu-devel/20260115-gtk-v1-1-57f49e=
856408@rsg.ci.i.u-tokyo.ac.jp
> ---
>  ui/gtk-egl.c     |  6 ++----
>  ui/gtk-gl-area.c | 23 +----------------------
>  2 files changed, 3 insertions(+), 26 deletions(-)
>
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index 7c5c9b2428c2..adc81f34b1c8 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -91,6 +91,7 @@ void gd_egl_draw(VirtualConsole *vc)
>              } else {
>                  qemu_dmabuf_set_draw_submitted(dmabuf, false);
>              }
> +            qemu_console_hw_gl_block(vc->gfx.dcl.con, true);
>          }
>  #endif
>          gd_egl_scanout_flush(&vc->gfx.dcl, 0, 0, vc->gfx.w, vc->gfx.h);
> @@ -405,14 +406,11 @@ void gd_egl_flush(DisplayChangeListener *dcl,
>
>      if (vc->gfx.guest_fb.dmabuf &&
>          !qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
> -        qemu_console_hw_gl_block(vc->gfx.dcl.con, true);
>          qemu_dmabuf_set_draw_submitted(vc->gfx.guest_fb.dmabuf, true);
>          gtk_egl_set_scanout_mode(vc, true);
> -        gtk_widget_queue_draw_area(area, x, y, w, h);
> -        return;
>      }
>
> -    gd_egl_scanout_flush(&vc->gfx.dcl, x, y, w, h);
> +    gtk_widget_queue_draw_area(area, x, y, w, h);
>  }
>
>  void gtk_egl_init(DisplayGLMode mode)
> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> index 23806b9d01bb..29497019ee46 100644
> --- a/ui/gtk-gl-area.c
> +++ b/ui/gtk-gl-area.c
> @@ -86,6 +86,7 @@ void gd_gl_area_draw(VirtualConsole *vc)
>              } else {
>                  qemu_dmabuf_set_draw_submitted(dmabuf, false);
>              }
> +            qemu_console_hw_gl_block(vc->gfx.dcl.con, true);
>          }
>  #endif
>
> @@ -163,27 +164,6 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
>
>      gd_update_monitor_refresh_rate(vc, vc->window ? vc->window : vc->gfx=
.drawing_area);
>
> -    if (vc->gfx.guest_fb.dmabuf &&
> -        qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
> -        /*
> -         * gd_egl_refresh() calls gd_egl_draw() if a DMA-BUF draw has al=
ready
> -         * been submitted, but this function does not call gd_gl_area_dr=
aw() in
> -         * such a case due to display corruption.
> -         *
> -         * Calling gd_gl_area_draw() is necessary to prevent a situation=
 where
> -         * there is a scheduled draw event but it won't happen bacause t=
he window
> -         * is currently in inactive state (minimized or tabified). If dr=
aw is not
> -         * done for a long time, gl_block timeout and/or fence timeout (=
on the
> -         * guest) will happen eventually.
> -         *
> -         * However, it is found that calling gd_gl_area_draw() here caus=
es guest
> -         * display corruption on a Wayland Compositor. The display corru=
ption is
> -         * more serious than the possible fence timeout so gd_gl_area_dr=
aw() is
> -         * omitted for now.
> -         */
> -        return;
> -    }
> -
>      if (!vc->gfx.gls) {
>          if (!gtk_widget_get_realized(vc->gfx.drawing_area)) {
>              return;
> @@ -347,7 +327,6 @@ void gd_gl_area_scanout_flush(DisplayChangeListener *=
dcl,
>
>      if (vc->gfx.guest_fb.dmabuf &&
>          !qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
> -        qemu_console_hw_gl_block(vc->gfx.dcl.con, true);
>          qemu_dmabuf_set_draw_submitted(vc->gfx.guest_fb.dmabuf, true);
>          gtk_gl_area_set_scanout_mode(vc, true);
>      }
>
> ---
> base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
> change-id: 20260115-gtk-424c2b910e65
>
> Best regards,
> --
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>


