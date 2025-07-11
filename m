Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B32C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 07:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua7lN-0005t1-Es; Fri, 11 Jul 2025 03:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ua7lK-0005dy-Os
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 03:01:38 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ua7lJ-0001zf-3G
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 03:01:38 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4a9bf46adedso18379441cf.2
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 00:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752217296; x=1752822096; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9lCRXle5tk1OwaWOWS1SyI3Gq9XNzX1gvGtfTEjeqjk=;
 b=CMiZKe9LSNyfupq7/FCq/NNzCd7Bj6FuXxd5vQDQjUJ6/W+cLYCx8VknQwApVHWOo9
 IFTYYGZKlP86hmX9NA3WhfQYDXZ7+01VVSKOgLfl8AGPOup0c+HaW+VBNj4mXWRAHFLO
 cOFHGXy3UIac1KsHIGTByjjkcWKCRS1jueQKGZ4FPTXbSxDpIH9MnR1Y53IoAA8NWnGx
 0v8sxTlBYQTsOA05jKNq/B6ynFR+IaHFSI90yS5TI3QoHrO+dwMt4MriWxk2sggaZt/C
 bE9rm5VWQMlnqNW4CegxZUAgUOMJEohQVgYcPL58MOP64vMvNGyycb6r5ffa2u0sMg0c
 HDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752217296; x=1752822096;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9lCRXle5tk1OwaWOWS1SyI3Gq9XNzX1gvGtfTEjeqjk=;
 b=sKuZS/lOyEYOFC2boabEocnvi11DWp9daqzi6N/9oxJfQ3X4ww7KRgxR76QD7KZCio
 gZVunl4rJh4kVK9sCJ0LYCzYJboPCMEA4prrq9XoQcbo/+9gzjRgSWnHLqCyOV0StjcR
 EK9flwx2/dDPuLiIO9fILKlHNhAmHQZlKOnO/8fnp44fQe9cig0zB7CG0/pDLDPbUaeg
 luAPRGXHysAJUSbCZpO+VWbtlkMbMwNQ/zGojKkCwpAU9xQb9i/h22Ysb4fhmTY1aLYU
 jD2W8YlpeYuVN2s9zIRK1hrutSKiPmdURbgfCfJ388bsPX9orA5lJTFJfwCumn9KzfWy
 /jPA==
X-Gm-Message-State: AOJu0Yx/xNOdvEkjWqFCx17ddYCOHu4Kb5XGcfFbkDBLip9MVyJuao3/
 bjOdK7wEiEs3TU//QcTUzQQUVRlFbYBiyjRzFKT2GkTo7TuBYKICX2n7gUw/T+hVsaOwxzKmmVU
 O3Gz6TqeCKnKwwP2S46PhHQ4xz/YNgbU=
X-Gm-Gg: ASbGncuomIVE/1Gs362a2PQxoeUIsig8WjXQ7JrAQxgixB2xYkaL2NMjr40OzB4eM6x
 fvjYKZ9xP+AUd53WF3QHI8czkzNzCdAQlvRidJiAJl22u//YEcE45rWBUyXiJ/y2N/m0kTUZtFL
 LeFzTDMI1/27mrps5EhhrzWozHIkJb9Um11vYUdGeUpmXhpQaxMuNPS2z6olgykI7wzRHIhibcs
 cuO5ElB
X-Google-Smtp-Source: AGHT+IGlemIDXRhhphu33zPS1NhfvFfcl9qL1Oj4cf8xOQ5uugqnepWb88dlpd5OyDOLeO8/eQSBKfwDxnAlMoq/lgA=
X-Received: by 2002:a05:622a:1a1d:b0:4a9:e5c2:129c with SMTP id
 d75a77b69052e-4aa35eeae53mr22880461cf.45.1752217295505; Fri, 11 Jul 2025
 00:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250524173514.317886-1-marcandre.lureau@redhat.com>
 <20250524173514.317886-15-marcandre.lureau@redhat.com>
 <CAFEAcA_WKw124t-92KLSq_GT2wVWU9QtiF_qEHxPqjkXJSDAGg@mail.gmail.com>
In-Reply-To: <CAFEAcA_WKw124t-92KLSq_GT2wVWU9QtiF_qEHxPqjkXJSDAGg@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 11 Jul 2025 11:01:24 +0400
X-Gm-Features: Ac12FXxrUrgmxhyzNjOR2rBtZfYnUAfPUz-zOYIS4w8Avv1pvNtDyWkDeXCxhyY
Message-ID: <CAJ+F1C+ux0GGyCpLn3sHzic7OWX-7gn7NtdYybaWD-snbWNMkA@mail.gmail.com>
Subject: Re: [PULL 14/19] ui/gtk: Update scales in fixed-scale mode when
 rendering GL area
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, 
 Weifeng Liu <weifeng.liu.z@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Thu, Jul 10, 2025 at 4:24=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Sat, 24 May 2025 at 18:37, <marcandre.lureau@redhat.com> wrote:
> >
> > From: Weifeng Liu <weifeng.liu.z@gmail.com>
> >
> > When gl=3Don, scale_x and scale_y were set to 1 on startup that didn't
> > reflect the real situation of the scan-out in free scale mode, resultin=
g
> > in incorrect cursor coordinates to be sent when moving the mouse
> > pointer. Simply updating the scales before rendering the image fixes
> > this issue.
> >
> > Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
> > Message-ID: <20250511073337.876650-5-weifeng.liu.z@gmail.com>
> > Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> > Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Hi; Coverity complains about this change CID 1610328):
>
> > @@ -50,8 +52,14 @@ void gd_gl_area_draw(VirtualConsole *vc)
> >
> >      gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
> >      gs =3D gdk_window_get_scale_factor(gtk_widget_get_window(vc->gfx.d=
rawing_area));
> > -    pw =3D gtk_widget_get_allocated_width(vc->gfx.drawing_area) * gs;
> > -    ph =3D gtk_widget_get_allocated_height(vc->gfx.drawing_area) * gs;
> > +    fbw =3D surface_width(vc->gfx.ds);
> > +    fbh =3D surface_height(vc->gfx.ds);
>
> Here we now unconditionally dereference vc->gfx.ds at the start of
> gd_gl_area_draw().
>
> But towards the end of this function we have a NULL check:
>
>         if (!vc->gfx.ds) {
>             return;
>         }
>
> Either vc->gfx.ds can be NULL, in which case we need some
> kind of guard on these surface_width() and surface_height()
> calls; or else it can't, and the NULL check later is dead code.
> Which is correct ?

Given that it's simply called from a GTK callback, it can be NULL. I
think we should simply return in this case, or perhaps use the older
code path as a fallback. Weifeng, wdyt?

--=20
Marc-Andr=C3=A9 Lureau

