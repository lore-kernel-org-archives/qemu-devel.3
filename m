Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D52EEC0463
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 10:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxMbg-0007lS-4I; Tue, 03 Mar 2026 05:04:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vxMbe-0007lF-Gb
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:03:58 -0500
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vxMbc-0003au-Tn
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:03:58 -0500
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-506a1b23c05so65122661cf.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 02:03:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772532232; cv=none;
 d=google.com; s=arc-20240605;
 b=XOrXpmuxBJ5Ci7HSpJzXveXW+FD7//Lz1HAzm0qHFHXgOB6m+Qx29tMYCls9Ap5ZJ5
 KV4giW5YqMbfkH57bUPjcDZmQKXnUZRFurag7L3l6Ad4XmGhUdyO8t/ji/Rk4KL9I8kR
 XPzWiTOf8n/MINkb04BXVXAUFUR1dRpT2M4yiD8D9ECMfs5YJsqkJm2ztzN05pwcCoRA
 DCDxJ857SW1KH29/FdsCdqnqwlVXnl7dtEABZ24Fvb6vzanmDthM1TRfL7uw3gTKjmne
 G3+b6uwk5S3pNDk6Yc40Ou+rDd+YXmrDzjmtc8iYZYsM5da2ubbTU5/lrfoS4dpgwS+N
 D/1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wLUlowBlfngB2jnDMYXDdpJO5FyXbVX2yiCbAb0KDdI=;
 fh=77h/AplD1uXQRVNC+PY/QlMUYbaYNuAq9ChcTIRorvI=;
 b=Crkd8MOVzwGumwitMzfpvztauYugqrciWn33bJtjDn6ITFgKwI9CpxU4Eh/vbj/p32
 2sHAqeJuri1Eo7dPrQa0Al9lma9g5S1D+MmJUG8VNJDqtKNKMLKXk5DHioSpZV6vANRh
 SSRe9N/ayPK6yw0TGHzvXqgMmbjVHF7hEGG3OKLPsy0AUaS5ZbqZY5n46/iqbcm3W81m
 /U19y1fadzen7xCc3E+QgkeFsR/2k7q/Zlw0ig/SW5lW91SLaAXJb5KlU/gsdCPoit+0
 +ciO4Xyi8e/q7SyakrqbQyDxvLYI2d0dQUkl8upeRo7KO1PWFTul6ekSlqX4qZEtMDrm
 igkg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772532232; x=1773137032; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wLUlowBlfngB2jnDMYXDdpJO5FyXbVX2yiCbAb0KDdI=;
 b=QcmXjK64151AbBXUunk4YvysxNp3T/ur7AElR2BKTlFaqo41vlueS5TU0e0epa4Q1M
 hN/qPrQy95Ct+/6fxfgpJc/BkgE0+zYVu9Krgy2N7SS8zYm727NunMeZs3aTm6MmNouu
 WGOV1zorK+YlSxmV8feQL/10Ozl42NhrSIvg9ty4mEC1v2z2F/uVh7KBSnsmPyH3g/SX
 fJ7ea10mNhYHfDraP1uOVWDMphsEE3TckzgqbL5Hl4n22+XPsAdSCmupx8EBiSB0atWW
 2JmwM2kI7XVVPAVPEUPE/MWGtIYppz8h8Wc1M/uWSIHDFSmUkOdXypY1mKQ4Kv5UaxuV
 3HYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772532232; x=1773137032;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wLUlowBlfngB2jnDMYXDdpJO5FyXbVX2yiCbAb0KDdI=;
 b=nAcC4N6liC3wkCvRz8YziqVL5FRafJsNJjLmclVX/3IkD7GSNbWEkSpW+0d3WRE15U
 4ihV11Nht2GBM+uGP9mPD37TPHXmbDB3yikHD/Z+ETJWnGZocNlydW3Hm1UtS8QI5z5y
 gPWqr8wtL1ZtZoprw6zHOMDYAiNEmlQ7+GsZ7t4JRSnGQ/28q5/EzDl/7Y0cw1U5o8Pf
 hUb2EiiIDxuaFogU4s9/DRZnimPU4j4obg+/z6lyiDof9mHRIEGcLILtT7DtUxrd+3a+
 kA55mLwKXUA0jYesFkFW7DmlszUJAL9IMnoeSxA8nn7zdWlKCXQaTo9VBMKoo6K8Il63
 Yq8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCqucjeVGmRrvWSbzDdASDDNNMmEJfruTYIfi0EjzolCQb9CF4C68tF9OdKZNeLboUhtSA24GpCsag@nongnu.org
X-Gm-Message-State: AOJu0YzppNpwGTEb/9zIFwobtrXTfliqrUgwB+pa/a5ZHTJUcdYy1/4S
 r2l5Wz9QKrRZjbfRf6xaszzQFudeHxScIxxU9cHyoysXL1F0gJ1qPVH+oMClbQ324v8qiU5lkyG
 v47eSQRfRtoErOpoSVi6UK9lQ6/mH6lM=
X-Gm-Gg: ATEYQzz7yYTUFfT6a/skamuj97rENS5UCmcCPsMFVBwpRi0X61fni0Hvs05SanE1YRQ
 /VS2sTbL7HeBYc28pUhKi0H8v4mwtTgGycZplaDJf8A6Yze8w719lhaUB6GmkG1rA5UIgOy/KRv
 0PE7OxHGRuUfhPJ14RAc7bhYbSx4hmf6FTY9F0MEQu/SQ5kp5lBib2RpHmzB15fK46CW2VRxhoB
 LGinDJY5LV2WrLlO2yowhQA4Kb08tRLXmpmqP6a/7TsKvkPzrm91niuIldjpm0UTWK+dbyeH4Az
 H1TwghCwRxLQSdPg/68y9vL75t4gqDWMw626rsQ=
X-Received: by 2002:ac8:570f:0:b0:501:17cb:bfbc with SMTP id
 d75a77b69052e-507527ca62fmr192991661cf.33.1772532232026; Tue, 03 Mar 2026
 02:03:52 -0800 (PST)
MIME-Version: 1.0
References: <20260302145920.735423-1-dmitry.osipenko@collabora.com>
 <20260302145920.735423-5-dmitry.osipenko@collabora.com>
In-Reply-To: <20260302145920.735423-5-dmitry.osipenko@collabora.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 3 Mar 2026 11:03:40 +0100
X-Gm-Features: AaiRm52ZUMh0R1fgZRRsluzCeZCyrRiSrfqyKcR1LSSfD48YfYjVeO_Nznzpt8U
Message-ID: <CAJ+F1C+KL2dAYGurXAk3Fc6TLNRa=FQU6U2=UqRkdeBw1uQRbw@mail.gmail.com>
Subject: Re: [PATCH v21 04/18] ui/gdk: Restore original context after new
 context creation
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Yiwei Zhang <zzyiwei@gmail.com>, 
 Sergio Lopez Pascual <slp@redhat.com>, Gert Wollny <gert.wollny@collabora.com>,
 qemu-devel@nongnu.org, 
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>, 
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, 
 Julia Zhang <julia.zhang@amd.com>, Chen Jiqian <Jiqian.Chen@amd.com>, 
 Rob Clark <robdclark@gmail.com>, Robert Beckett <bob.beckett@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x832.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, Mar 2, 2026 at 4:04=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Get currently bound GL context when creating new GL context and restore
> it after the creation for consistency with behavior expected by virglrend=
erer
> that assumes context-creation doesn't switch context.
>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/gtk-gl-area.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> index c709b2ce0f63..ce49000d3f17 100644
> --- a/ui/gtk-gl-area.c
> +++ b/ui/gtk-gl-area.c
> @@ -250,11 +250,13 @@ QEMUGLContext gd_gl_area_create_context(DisplayGLCt=
x *dgc,
>                                          QEMUGLParams *params)
>  {
>      VirtualConsole *vc =3D container_of(dgc, VirtualConsole, gfx.dgc);
> +    GdkGLContext *ctx, *current_ctx;
>      GdkWindow *window;
> -    GdkGLContext *ctx;
>      GError *err =3D NULL;
>      int major, minor;
>
> +    current_ctx =3D gdk_gl_context_get_current();
> +
>      window =3D gtk_widget_get_window(vc->gfx.drawing_area);
>      ctx =3D gdk_window_create_gl_context(window, &err);
>      if (err) {
> @@ -275,8 +277,12 @@ QEMUGLContext gd_gl_area_create_context(DisplayGLCtx=
 *dgc,
>
>      gdk_gl_context_make_current(ctx);
>      gdk_gl_context_get_version(ctx, &major, &minor);
> -    gdk_gl_context_clear_current();
> -    gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
> +
> +    if (current_ctx) {
> +        gdk_gl_context_make_current(current_ctx);
> +    } else {
> +        gdk_gl_context_clear_current();
> +    }
>
>      if (gd_cmp_gl_context_version(major, minor, params) =3D=3D -1) {
>          /* created ctx version < requested version */
> --
> 2.52.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

