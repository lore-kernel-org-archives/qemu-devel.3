Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B027DD78794
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWd53-0003Jd-4e; Fri, 19 Dec 2025 11:11:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bT.jegqzs1agqdnj80=r7yuam1tkpbc=7h5r03to7ynf44@em483429.getutm.app>)
 id 1vWd50-0003JJ-Sr
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:11:47 -0500
Received: from a2i327.smtp2go.com ([103.47.205.71])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bT.jegqzs1agqdnj80=r7yuam1tkpbc=7h5r03to7ynf44@em483429.getutm.app>)
 id 1vWd4q-0003nI-48
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:11:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=smtpservice.net; s=mad0l0.a1-4.dyn; x=1766161580; h=Feedback-ID:
 X-Smtpcorp-Track:To:Subject:Message-ID:Date:From:Reply-To:Sender:
 List-Unsubscribe:List-Unsubscribe-Post;
 bh=17A7t+d3kUrI/x9e9rRGsC2ts/HYx5LSN4keImN6zAc=; b=sbFuIPirkuOcfGu56n6fbMqC4I
 7JE14RPeEJlYXs54tRd2wkKEB/IeLq2hxjAltDX2brV814fRQwPFOof4fEmjz5XezHrXUic5l9IVf
 knXMcPWfsdMnZk1MvqBWLIRDGqFcBqQ1f8zOehOgIN/T+1Zz4QrZS0apYuR8VtmtU06h5DcRzb8qx
 /T4CovYsu9ngnJtaSB8BvF6TKSXFutrWqnhP+yu+n6BAzkJQTqnowZjM3t3G6+4YCY44BM0Eyd7nJ
 oUhHED+TYlTwDhp0m/4vNUM0G2M/QewWXYK0VLwesFSOTKCWtHi0/RrVEFX2V61anlSgVx4cJnCp7
 5gzbnU5g==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getutm.app;
 i=@getutm.app; q=dns/txt; s=s483429; t=1766160680; h=from : subject :
 to : message-id : date;
 bh=17A7t+d3kUrI/x9e9rRGsC2ts/HYx5LSN4keImN6zAc=;
 b=iksGyYC62Jw18shMTArZjgBLwm8pgmesx9+HwTqbJ5txQeinWHmAyXOIi0efCSUObW4mi
 bakRCmNUgVJ+enS2DmaDfIoNICpxwwFNjC/GPKSJKtjAMQxo55KWP9pawunU+nKaXaGjoXH
 Z40ZP0g9Zl25rG4w9btlcb++NaduauJ6hCnpvWrE6bD+q3ekcqkrfaAyjgTzMDIpcq1lG29
 ycS1+YThmgkj5Y9wPK2MUAz2yaog2GCg9p8wcBYxj7AznnwZy0bQtU1FBnCTtd7FSrgsI0Z
 N9syAU9nbJCkT/K8mgcajNOiwI8zM1sxM7hK+xNS8qLfSO6Emn6MP0ffoa3w==
Received: from [10.172.234.246] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <j@getutm.app>) id 1vWd4Y-pH9RI0-8g
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 16:11:18 +0000
Received: from [10.159.238.187] (helo=mail-ej1-f49.google.com)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
 (Exim 4.98.1-S2G) (envelope-from <j@getutm.app>)
 id 1vWd4X-AIkwcC8pD66-Ea6V for qemu-devel@nongnu.org;
 Fri, 19 Dec 2025 16:11:17 +0000
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-b7697e8b01aso352892766b.2
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:11:17 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVmNZBdtrkOkzNK70VOvC8s5Vrbl0LeDNCeSwi0aMVD4RhjeIJny141aD29HpDXmk+LOrWmg34CO/g6@nongnu.org
X-Gm-Message-State: AOJu0YwF26ciFngbxKr2hIsI/rFv21fksPy/1jdkSEX3eH9T4xfrndl/
 y2ihP4W9g7bWiieicAynE8prezjlrm8OG9FqZthQ3mqBaJxgPMurAgsVka5OfdhxehTehw6AhO0
 oqWhy3BY3MPfmEbG5h2QR6g4o791/u3g=
X-Google-Smtp-Source: AGHT+IF7bPIy9tUCNcYfpFcPE63p7eyRfzQ0yxFTylXCA495xMO6D9sWDJPitPCf0DuD9k637Q2zZmVHFe0TJbUZmKQ=
X-Received: by 2002:a17:907:c0f:b0:b73:8798:3c00 with SMTP id
 a640c23a62f3a-b8036ebbbdcmr289824366b.3.1766160675647; Fri, 19 Dec 2025
 08:11:15 -0800 (PST)
MIME-Version: 1.0
References: <20251203040754.94487-1-j@getutm.app>
 <20251203040754.94487-2-j@getutm.app>
 <3a401334-700f-4b11-b006-a93470d38a66@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <3a401334-700f-4b11-b006-a93470d38a66@rsg.ci.i.u-tokyo.ac.jp>
From: Joelle van Dyne <j@getutm.app>
Date: Fri, 19 Dec 2025 08:11:04 -0800
X-Gmail-Original-Message-ID: <CA+E+eSBOEzzb-aO2B_yWtJeoK4QGvjf=pB555+GGE2U0OH=vbw@mail.gmail.com>
X-Gm-Features: AQt7F2oVN0AI0Xkle-7V__r6USmH0JlL_EKr7eXdrBNVjjeeqoeS5KCGEEvndcw
Message-ID: <CA+E+eSBOEzzb-aO2B_yWtJeoK4QGvjf=pB555+GGE2U0OH=vbw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/7] egl-helpers: store handle to native device
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Smtpcorp-Track: 1fbb-YFmhVzr.RBnaJkJuSLj0.vhZVEwoYw06
Feedback-ID: 483429m:483429abrvJvs:483429sWxEtmuJYa
X-Report-Abuse: Please forward a copy of this message, including all headers, 
 to <abuse-report@smtp2go.com>
Received-SPF: pass client-ip=103.47.205.71;
 envelope-from=bT.jegqzs1agqdnj80=r7yuam1tkpbc=7h5r03to7ynf44@em483429.getutm.app;
 helo=a2i327.smtp2go.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Wed, Dec 3, 2025 at 10:31=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2025/12/03 13:07, Joelle van Dyne wrote:
> > Make way for other platforms by making the variable more general. Also =
we
> > will be using the device in the future so let's save the pointer in the
> > global instead of just a boolean flag.
> >
> > Signed-off-by: Joelle van Dyne <j@getutm.app>
> > ---
> >   include/ui/egl-helpers.h      | 2 +-
> >   hw/display/virtio-gpu-virgl.c | 2 +-
> >   ui/egl-helpers.c              | 4 ++--
> >   3 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
> > index acf993fcf5..c239d32317 100644
> > --- a/include/ui/egl-helpers.h
> > +++ b/include/ui/egl-helpers.h
> > @@ -12,7 +12,7 @@
> >   extern EGLDisplay *qemu_egl_display;
> >   extern EGLConfig qemu_egl_config;
> >   extern DisplayGLMode qemu_egl_mode;
> > -extern bool qemu_egl_angle_d3d;
> > +extern void *qemu_egl_angle_native_device;
>
> I guess ANGLE will not be relevant for Metal and leaving it will be
> misleading.
What is your suggestion? This is just to remove "D3D" from the
variable name. If you want to remove "ANGLE" from the variable name as
well, it may be misleading because this variable is only used with an
ANGLE EGL backend.

>
> Regards,
> Akihiko Odaki
>
> >
> >   typedef struct egl_fb {
> >       int width;
> > diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virg=
l.c
> > index 07f6355ad6..20c856c04e 100644
> > --- a/hw/display/virtio-gpu-virgl.c
> > +++ b/hw/display/virtio-gpu-virgl.c
> > @@ -1152,7 +1152,7 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
> >       }
> >   #endif
> >   #ifdef VIRGL_RENDERER_D3D11_SHARE_TEXTURE
> > -    if (qemu_egl_angle_d3d) {
> > +    if (qemu_egl_angle_native_device) {
> >           flags |=3D VIRGL_RENDERER_D3D11_SHARE_TEXTURE;
> >       }
> >   #endif
> > diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> > index e3f2872cc1..57bcf99498 100644
> > --- a/ui/egl-helpers.c
> > +++ b/ui/egl-helpers.c
> > @@ -28,7 +28,7 @@
> >   EGLDisplay *qemu_egl_display;
> >   EGLConfig qemu_egl_config;
> >   DisplayGLMode qemu_egl_mode;
> > -bool qemu_egl_angle_d3d;
> > +void *qemu_egl_angle_native_device;
> >
> >   /* ------------------------------------------------------------------=
 */
> >
> > @@ -651,7 +651,7 @@ int qemu_egl_init_dpy_win32(EGLNativeDisplayType dp=
y, DisplayGLMode mode)
> >           }
> >
> >           trace_egl_init_d3d11_device(device);
> > -        qemu_egl_angle_d3d =3D device !=3D NULL;
> > +        qemu_egl_angle_native_device =3D d3d11_device;
> >       }
> >   #endif
> >
>

