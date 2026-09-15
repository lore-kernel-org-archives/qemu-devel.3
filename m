Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A08C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 09:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Pri-0007dd-VR; Tue, 15 Sep 2026 05:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x6Prh-0007dP-TT
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 05:54:13 -0400
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x6Prg-0005Hz-0p
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 05:54:13 -0400
Received: by mail-pz2-x0f.google.com with SMTP id
 d2e1a72fcca58-85469a34908so2545860b3a.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 02:54:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789466050; cv=none;
 d=google.com; s=arc-20260327;
 b=ORZRHsAM/USlQLwgSlQQZl62DQx9/2+dIjMWjcUyHi1nvDcictfsFyCcSVx+yWiB6N
 ZnLlKkr2qx1psH8iiU6X4Wb+HFTB45H1e6c/UIcG6M3lrJcGoAS5cVH+QKIbIj8AfMG+
 A8RqZ+jpVdppm8JeIwXn02QcDEJVuV8jT8O0ofWgM2JctP0gwI1bW7CUZUllV/o815HO
 uH80Gwn5uPIize8uaBEGHnfX3nLvl02dt3YpOz9qqrdMH2MKNJwHKBoVaryGbItPGwiw
 Qk4Er371DLyq4sUMzNXwhXE8gOFpfFB3DI7tYxw+RnYkON3iHCBDwugpEmJIQ0l9FsiA
 OEfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YZC1CwVSt8Io5jByrJekTrRT1QlDVKp/06Xdfpv4ZEo=;
 fh=cOsNULT/G3KmuphHDOpmhJ0EqPaEyNDPfyDGSK/csWI=;
 b=AL9nNGjq2aVBdc7EYlGjveQS1HQta24X+PlP3zRA4ZXczT4uauyi/tU1V6EVUbNu7P
 WhyF9XAred1zhc5JjvPtOYF6z2K6bQvSpcxTQ6far/6kC4j5JtLt+vnqNqm7GWv7AFiu
 RzsNsCGYcd5Gg/0ndCq0iVZxOI5Y8m3ZCEGC8GYO10z3+XfjQv+7p8OsoPuNaJeCoyA0
 8E9MrSrD1W0fFDmARMdX4dmT0rkcCp9UIczqjhmInYXPRjoUU3XdUXHdhqrI38sFMLFv
 9HIeaf9Vyf65KvwHxFb3+G+SSSriT/jWfaYxf2kC4yxk7AoFNhtxXvPeXH29b2eSgWfs
 BLzQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789466050; x=1790070850; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YZC1CwVSt8Io5jByrJekTrRT1QlDVKp/06Xdfpv4ZEo=;
 b=IwcHI0KbXOO7yMh5phQu/tr4YEypk+PrZ2Dc9/SQoIafJhJAvFKlIydaS9q0otpdo+
 NxUmaEHM+1+mfjHbHJmLXDjhl9XCcKcZQVjOrposNw9TaH/j9FkE1gPcXWJ/+tFKzVcQ
 /onHEcUDBgUdH0VuI+p5mWvA+PsWKzreXDbp69RobKUpeiskdaN20QSlC6BpvMK+rZmq
 uqtKRYS1eLtK4q2+FxEtTkaYg60RDeb1bX+sHuYmJsP2Xih5RWDAP/jv87BDtJuACjZ7
 H3ZSex0/3ohulghX/KMBF0k6qjGzkXpUqM2Q7jTG/6TQ8o3x2v6mUpQfOU09UdCW29Ze
 2C1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789466050; x=1790070850;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YZC1CwVSt8Io5jByrJekTrRT1QlDVKp/06Xdfpv4ZEo=;
 b=KQwWiitf2lGaZBXuO53MrAuWiue3jVaLFYo8xIMTLErPL1EYyVP7DLbvs7KxOM7n+Q
 xfB04FUowOiUkTHTaltvE0bOnbiRa1Utu5qE5nacYUhHbf7Du4A3lEwNLoy7GSzO7mQO
 DoL4nDIQIj87uyMuzrjQL0TOrHolprm/Tctz8tOSdhyWXS/XkGc5LuqWx+VTk6P+Tuu8
 1LhxNgyg5UzhFzu4iMWbaAtgmvHdP4pOhkiCBbOWmyedsV3E1MTjtu4uLo7kbwPUmhJB
 B7KQdeVy01NAMt9+vgK/goJPS8VVa32SWU/GLHKKvavES7/AVvjfN5FeaLLwdDtTgeXC
 OXRw==
X-Gm-Message-State: AFuF++nUkoKgfxfhQaV9UGzpS4qQQHLwfqJtds2TLz6P5SDMWbtk4UmQ
 irCh8DdLGvJjvXm5BMojDTgBVKL3UAU2DBFoSN5BHzpYUS4u4FHlQPqTMJD7BlQmvJqXRaXBJup
 3L7IoaRJmiBFNyQNkHXjjjnqV1CLJ2fo=
X-Gm-Gg: AYBFou1RQVtI5hFgHmjv3l39VJqIJ74b8x6p7Nb3V48ra2uOHviboK5FlvJCBaBUouc
 MGyD4TkstNIy+Jf3UmH2k56J2GL3rF1olKgqvgT72JaMj9gtPMVl7kxkAgXLHbuFLIDqxxAfyWS
 dwGch+lq4X1q0rRK67HP0ewETdTkcvLASLhFEo8HhsR2nFasOvaVdHRDoyuSxrgIgvED93vV6lW
 whmDerwKlJ74vcU0ajith898rjSeZ2QHyDF3z2nv/7bpWP0eLmWeqLaG389gOyhBAViKejPyLqG
 5Usfhw/rJkgkW+bIptCFd9rRlRPPPherjsRZsrEXHwa76VJ3eYIdMZq+gKJq0hFoJRZdkcLHYAE
 ZbN2YMUPRZzxE
X-Received: by 2002:a05:6a21:7a97:b0:3d3:ae0f:526d with SMTP id
 adf61e73a8af0-3db406f54aemr13143356637.25.1789466050244; Tue, 15 Sep 2026
 02:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260804090847.18871-1-dongwon.kim@intel.com>
In-Reply-To: <20260804090847.18871-1-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 15 Sep 2026 13:53:58 +0400
X-Gm-Features: AcwNN1WJT37ahgxzERp6h0JC4njtLHTuLuaTekFFL9hZg1PuSz8NRqWMlDcKZUM
Message-ID: <CAJ+F1CJd6P7YPpCMx4Ntv6KAD=hv8yHzPHDq8=c2ZEcwHnjN2A@mail.gmail.com>
Subject: Re: [PATCH 1/2] ui/gtk: enable fullscreen hotkey for detached windows
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:3b::f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pz2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Mon, Sep 14, 2026 at 10:50=E2=80=AFPM <dongwon.kim@intel.com> wrote:
>
> From: Dongwon Kim <dongwon.kim@intel.com>
>
> Currently, the fullscreen toggle hotkey (Ctrl+Alt+f by default) only
> functions for the main QEMU window. When a Virtual Console (VC) is
> detached into its own separate window (untabified), it loses this
> capability.
>
> Implement a toggle helper, gd_win_fullscreen, and connect it to
> the 'f' accelerator when a detached window is created in
> gd_menu_untabify. This allows individual detached windows to be
> toggled fullscreen independently.
>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  ui/gtk.c | 46 +++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 43 insertions(+), 3 deletions(-)
>
> diff --git a/ui/gtk.c b/ui/gtk.c
> index a723c8215d..3c9720a330 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -1556,6 +1556,42 @@ static gboolean gd_win_grab(void *opaque)
>      return TRUE;
>  }
>
> +static void gd_win_fullscreen(void *opaque)
> +{
> +    VirtualConsole *vc =3D opaque;
> +    GtkDisplayState *s =3D vc->s;
> +    GdkWindow *window;
> +    GdkWindowState state;
> +
> +    if (!vc->window || !gtk_widget_get_realized(vc->window)) {
> +        return;
> +    }
> +
> +    window =3D gtk_widget_get_window(vc->window);
> +    if (!window) {
> +        return;
> +    }
> +
> +    state =3D gdk_window_get_state(window);
> +
> +    if (state & GDK_WINDOW_STATE_FULLSCREEN) {
> +        gtk_window_unfullscreen(GTK_WINDOW(vc->window));
> +
> +        if (vc->type =3D=3D GD_VC_GFX) {
> +            if (!s->free_scale) {
> +                vc->gfx.scale_x =3D 1.0;
> +                vc->gfx.scale_y =3D 1.0;

gd_menu_full_screen restores it to gfx.preferred_scale

> +            }
> +            gd_update_windowsize(vc);
> +        }
> +    } else {
> +        if (vc->type =3D=3D GD_VC_GFX) {
> +            gtk_widget_set_size_request(vc->gfx.drawing_area, -1, -1);
> +        }
> +        gtk_window_fullscreen(GTK_WINDOW(vc->window));
> +    }
> +}

For consistency with gd_menu_full_screen() it should call gd_update_cursor

> +
>  static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
>  {
>      GtkDisplayState *s =3D opaque;
> @@ -1590,9 +1626,13 @@ static void gd_menu_untabify(GtkMenuItem *item, vo=
id *opaque)
>              GtkAccelGroup *ag =3D gtk_accel_group_new();
>              gtk_window_add_accel_group(GTK_WINDOW(vc->window), ag);
>
> -            GClosure *cb =3D g_cclosure_new_swap(G_CALLBACK(gd_win_grab)=
,
> -                                               vc, NULL);
> -            gtk_accel_group_connect(ag, GDK_KEY_g, HOTKEY_MODIFIERS, 0, =
cb);
> +            GClosure *cb_grab =3D g_cclosure_new_swap(G_CALLBACK(gd_win_=
grab),
> +                                                    vc, NULL);
> +            gtk_accel_group_connect(ag, GDK_KEY_g, HOTKEY_MODIFIERS, 0, =
cb_grab);

You also hook grab, this should be mentionned in the commit message.

btw, it would be nice to remove the stderr printf there..

Why not add the zoom keys while at it?

thanks

> +            GClosure *cb_fullscreen =3D g_cclosure_new_swap(
> +                                             G_CALLBACK(gd_win_fullscree=
n),
> +                                             vc, NULL);
> +            gtk_accel_group_connect(ag, GDK_KEY_f, HOTKEY_MODIFIERS, 0, =
cb_fullscreen);
>          }
>
>          gd_rebuild_vc_menu(s);
> --
> 2.43.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

