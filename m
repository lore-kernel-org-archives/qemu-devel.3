Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2C9E75424
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 07:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYJkF-00021y-Qc; Wed, 24 Dec 2025 02:57:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bT.fjyexl7n5it28i0=pg1qg0xgqeu1=tq7o9ddt3qqokw@em483429.getutm.app>)
 id 1vYJkD-00020k-EQ
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 02:57:17 -0500
Received: from a2i327.smtp2go.com ([103.47.205.71])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bT.fjyexl7n5it28i0=pg1qg0xgqeu1=tq7o9ddt3qqokw@em483429.getutm.app>)
 id 1vYJkB-0006vV-SR
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 02:57:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=smtpservice.net; s=mad0l0.a1-4.dyn; x=1766563921; h=Feedback-ID:
 X-Smtpcorp-Track:To:Subject:Message-ID:Date:From:Reply-To:Sender:
 List-Unsubscribe:List-Unsubscribe-Post;
 bh=1eiikYYLad7ERGAgOiDl1Hrsu+GDiQoXB4vBMrhFhPo=; b=V2uvzXRJ/VjsyR3c8xJp+lFzhi
 /m7QcxOvcmxLyW095rI8IMKhIr+vOSpnqvPZKUm5SigjI4wcOh277OfQg+u5TG5ixIyMrq9TrXH9W
 lIMwA0s44tPMEPBwRaWDlEaQ+dx0Z7+8NdDWI/MESYwcDnqXr7w7z+fzaP182KYNCA1XDQvDT3k6C
 2a+ZneojtLJIyMoK2TswelLaXPZ8nycZP7+OWJrisStyIXbdhhCvTWzM9C9gxUn4QQFDYXwTswOz/
 bSZ2FCMlO5hckcLuNEQcVzg7fwiZBSOnAbO6YJFpi9TWwPT6Ldy9bAVUBM0eIUo+bHrTJsPHCFs7c
 Uxz6Db6g==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getutm.app;
 i=@getutm.app; q=dns/txt; s=s483429; t=1766563021; h=from : subject :
 to : message-id : date;
 bh=1eiikYYLad7ERGAgOiDl1Hrsu+GDiQoXB4vBMrhFhPo=;
 b=myZ8b8mOUtOASBJ2CAhP3z1dFnBNe4x2P2FHTmKZSBO9XOGw5Y2GaGQ+OI62ymP7UpAgI
 ISgNRorDW0Tf7ncfSv0+ZH2U4x3nTc87e3spqgIyipgS7bHXSQ5dFWGmRCZUb63k1+sCyVB
 EM5+NW3vojvL/im3IHAqkrYjCRCF5OuBleGqQwMaynOHmPLFZPzo0F/1Mb06bsFay1+30ZZ
 84MrZSMZf94zq2qnSImM3Pzy25qg2ZcPtYme3NmR3swijvXTNcGIWet82oZlXzYGmy3mXKw
 dEEocUH3IukxxerhF5etETBXngFw8jXzfJcj8d9RcBEAIPSUPDwatLxHUBjw==
Received: from [10.173.255.233] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <j@getutm.app>) id 1vYJjw-pH9U74-Aa
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 07:57:00 +0000
Received: from [10.159.238.187] (helo=mail-ej1-f46.google.com)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
 (Exim 4.98.1-S2G) (envelope-from <j@getutm.app>)
 id 1vYJjv-FnQW0hPtzfp-40Gt for qemu-devel@nongnu.org;
 Wed, 24 Dec 2025 07:56:59 +0000
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-b7355f6ef12so1070382066b.3
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 23:56:59 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUym9wXZ0+1vZ/U+/5OJ0epeWvIwq1gJkeSCVR5DW3upL6CU/DfTwDqkPcPuCMDHOM7TNCMeEWxDpRV@nongnu.org
X-Gm-Message-State: AOJu0YyoBCdRcGhEqjFacRD0uFS0USfkEVFBirjaO4r0Jnok2qJaPGUb
 ZFqRTXfT6jYI+3MKpA/D1K6Cyd0FzMESbVZ3IW6/+k1Du1IqNKwSfYw1xE91A06v1uwbd6tez7X
 /tTagIK1ZwhBIa8zBPuMdw9vCs+YFINw=
X-Google-Smtp-Source: AGHT+IG1MrvJzEm9HRi6d1L2wRdKmyVtIK7BgvZAMq6EE+HjreBqH4ecW3jpnUKW9GdPxa0GNuO/Rb6p9u6pOypuCDw=
X-Received: by 2002:a17:906:23e9:b0:b80:6ddc:83f8 with SMTP id
 a640c23a62f3a-b806ddc8a5emr753238166b.32.1766563019102; Tue, 23 Dec 2025
 23:56:59 -0800 (PST)
MIME-Version: 1.0
References: <20251203040754.94487-1-j@getutm.app>
 <20251203040754.94487-4-j@getutm.app>
 <a3f3b84a-451d-4b41-8f32-fa96ed8a608f@rsg.ci.i.u-tokyo.ac.jp>
 <CA+E+eSB7rV9dvrB+1=wFyAgCQt89Ez8U3fxgyWvbb5QfOJTMkA@mail.gmail.com>
 <f26efe44-0ed6-4cc7-9ca1-729a9fdad83e@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <f26efe44-0ed6-4cc7-9ca1-729a9fdad83e@rsg.ci.i.u-tokyo.ac.jp>
From: Joelle van Dyne <j@getutm.app>
Date: Tue, 23 Dec 2025 23:56:47 -0800
X-Gmail-Original-Message-ID: <CA+E+eSDh7Q-_+FgRvCs6B5SGCwEgk8siqupVbR=wCUtVJxOiGg@mail.gmail.com>
X-Gm-Features: AQt7F2qgl_PepIze7so3EkQhWrE7C2Dh7kLQHSNp9KvCb-ICZRUvQbzoUzdlTbg
Message-ID: <CA+E+eSDh7Q-_+FgRvCs6B5SGCwEgk8siqupVbR=wCUtVJxOiGg@mail.gmail.com>
Subject: Re: [PATCH RFC 3/7] console: rename `d3d_tex2d` to `native`
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Smtpcorp-Track: 3XAwYsX4IzEd.SfX1ZogyCXiE.6Y1uzwCiNU2
Feedback-ID: 483429m:483429abrvJvs:483429sSQBnn4Ium
X-Report-Abuse: Please forward a copy of this message, including all headers, 
 to <abuse-report@smtp2go.com>
Received-SPF: pass client-ip=103.47.205.71;
 envelope-from=bT.fjyexl7n5it28i0=pg1qg0xgqeu1=tq7o9ddt3qqokw@em483429.getutm.app;
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

On Tue, Dec 23, 2025 at 10:29=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2025/12/20 1:16, Joelle van Dyne wrote:
> > On Wed, Dec 3, 2025 at 10:41=E2=80=AFPM Akihiko Odaki
> > <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> >>
> >> On 2025/12/03 13:07, Joelle van Dyne wrote:
> >>> In order to support native texture scanout beyond D3D, we make this m=
ore
> >>> generic allowing for multiple native texture handle types.
> >>>
> >>> Signed-off-by: Joelle van Dyne <j@getutm.app>
> >>> ---
> >>>    include/ui/console.h          | 22 +++++++++++++++++++---
> >>>    include/ui/gtk.h              |  4 ++--
> >>>    include/ui/sdl2.h             |  2 +-
> >>>    hw/display/virtio-gpu-virgl.c | 10 +++++++---
> >>>    ui/console.c                  |  8 ++++----
> >>>    ui/dbus-console.c             |  2 +-
> >>>    ui/dbus-listener.c            |  8 ++++----
> >>>    ui/egl-headless.c             |  2 +-
> >>>    ui/gtk-egl.c                  |  2 +-
> >>>    ui/gtk-gl-area.c              |  2 +-
> >>>    ui/sdl2-gl.c                  |  2 +-
> >>>    ui/spice-display.c            |  2 +-
> >>>    12 files changed, 43 insertions(+), 23 deletions(-)
> >>>
> >>> diff --git a/include/ui/console.h b/include/ui/console.h
> >>> index 98feaa58bd..25e45295d4 100644
> >>> --- a/include/ui/console.h
> >>> +++ b/include/ui/console.h
> >>> @@ -131,6 +131,22 @@ struct QemuConsoleClass {
> >>>        ObjectClass parent_class;
> >>>    };
> >>>
> >>> +typedef enum ScanoutTextureNativeType {
> >>> +    SCANOUT_TEXTURE_NATIVE_TYPE_NONE,
> >>> +    SCANOUT_TEXTURE_NATIVE_TYPE_D3D,
> >>> +} ScanoutTextureNativeType;
> >>> +
> >>> +typedef struct ScanoutTextureNative {
> >>> +    ScanoutTextureNativeType type;
> >>> +    union {
> >>> +        void *d3d_tex2d;
> >>> +    } u;> +} ScanoutTextureNative;
> >>
> >> Instead, I suggest:
> >>
> >> typedef struct ScanoutTextureNative {
> >>       ScanoutTextureNativeType type;
> >>       void *handle;
> >> } ScanoutTextureNative;
> >>
> >> ...to align with the definition of struct
> >> virgl_renderer_resource_info_ext and
> >> virgl_renderer_create_handle_for_scanout(), which do not add a field f=
or
> >> each type (except the one for the backward compatibility).
> > I've updated virglrenderer to use a union as well. Since we are
> > passing ScanoutTextureNative around byval and it can grow with
> > additional platform support, I think it would be better to keep it as
> > a union.
>
> I don't think using a union for virglrenderer is a good idea because
> adding another member to the union can change its size and cause an ABI
> breakage. Sticking to void * is the safest choice. We rely on void * to
> represent platform-specific types anyway so there is practically no type
> safetey here, unfortunately.
That's fair, we can use a struct in virglrenderer. However, in QEMU if
we are passing byval and a struct (once increased in size) could lead
to needless copying.

>
> Regards,
> Akihiko Odaki

