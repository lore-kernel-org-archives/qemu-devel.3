Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5A2C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 14:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1ofk-0002Jo-QR; Tue, 30 Apr 2024 10:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1s1ofg-0002JN-IM
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:41:29 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1s1ofe-0003KH-Kt
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:41:28 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4376e3fd7e4so32834991cf.2
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 07:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714488084; x=1715092884;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EcnPkBhDZ4Y0K9Sin/tS2wE+zVONULAgK7EIQTeVkBs=;
 b=GfIJfGziEDoPsAxGOhbBa0eEg5LAFdQzkgcupXY+J0emXbEgx9hJFVDucMs8YAQZci
 hrXspqMEFvKrAD5rFovF3yYa50U14c0D9K3gqPvYdyKWSl4xgZtXgiai4wmwNbRQ+v17
 16wxM8hguKFRuk4VuHn2LY+5sMjwGMESGVFkKobi5Y/d4n6XhiFBl5NAzGowNfRVLgYS
 XIgvNEG4yUjERKJW67NMjGXZOkuyEmpxnTr7ByaPyMAhV5K7aXXFQdUDh1iAjZdNMdXh
 b7Cgw8bGaePRasSi83LnWm21bkHOgF+Gfy47zMfZc5Mwk2YS2wxHhCTfap8phVQk8hXr
 BZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714488084; x=1715092884;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EcnPkBhDZ4Y0K9Sin/tS2wE+zVONULAgK7EIQTeVkBs=;
 b=aTzKwBPfvmrtANAITgLNmFG+CZKM4sDElEMM4ChxjsXRdQNA/r2YUfMCcCJMmaEpTo
 psl2t1wH6eVk2jDYKymepzXneufViv3DGizyvHe2Ot0U89FAggUPYaneGBG5E91u6jSA
 AChoXRepR3MsUC9HbtLsUrJtjuJpVaZj6DdShY5pmtxzYiezXfRYUHJttPLUiZI0oDi8
 HjdT8XLHiO8IwHw4Piai/XXhyngzcdnjh7tKoEUfeIxPc/rGSDTIWBBSBObEY05A/J+O
 GHxvYFJI5uCGXL463lyf6gbwHcCS46/1C+fZqDhvyLdEJ3rxVLsvM9wclwzLBO45UZa7
 DcRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUISgjGtABE1mKtxF76o+O0UfN5NH4sFCztPT+A7bxQq6cQBivSD1gGWLSygz4SN5X5wVspALIhtH16NmLTnzydS7EOvJY=
X-Gm-Message-State: AOJu0YwrwIi58n0XkKQ55TkpfbCC0ZAdKIYOSoDfI+VInl9VT0SkPZ9M
 7yGLsyWqALCYQ1T96u09m9O/l9a6Vo+7mr2Pzl+mJ3eFLrKITJRC/itOIVnm8T0zLzi6TkTorOk
 q64KH4syXzETlrVPGUbD18tvsGjhM19WE665Rgw==
X-Google-Smtp-Source: AGHT+IELVyBcMuVn3gYF2ihJPxi8HgfDFPR3iRYKiYrDWTcb2bZKch8P5fmm5ACYXnCIKPDaD4ectVwogHDjcKefKfc=
X-Received: by 2002:a05:622a:164d:b0:43b:1472:166d with SMTP id
 y13-20020a05622a164d00b0043b1472166dmr3845809qtj.51.1714488084231; Tue, 30
 Apr 2024 07:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240428-auto-v1-0-7b012216a120@daynix.com>
 <20240428-auto-v1-1-7b012216a120@daynix.com>
In-Reply-To: <20240428-auto-v1-1-7b012216a120@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Tue, 30 Apr 2024 17:41:13 +0300
Message-ID: <CAOEp5Oe-uO+Q+btn0bqs1tA-zCc9qth7ngR-fVzDGnSE41yJfg@mail.gmail.com>
Subject: Re: [PATCH 1/3] qdev-properties: Add DEFINE_PROP_ON_OFF_AUTO_BIT64()
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Luigi Rizzo <rizzo@iet.unipi.it>, Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org, 
 20240428-rss-v10-0-73cbaa91aeb6@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::832;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-qt1-x832.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Sun, Apr 28, 2024 at 10:21=E2=80=AFAM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> DEFINE_PROP_ON_OFF_AUTO_BIT64() corresponds to DEFINE_PROP_ON_OFF_AUTO()
> as DEFINE_PROP_BIT64() corresponds to DEFINE_PROP_BOOL(). The difference
> is that DEFINE_PROP_ON_OFF_AUTO_BIT64() exposes OnOffAuto instead of
> bool.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  include/hw/qdev-properties.h | 18 ++++++++++++
>  hw/core/qdev-properties.c    | 65 ++++++++++++++++++++++++++++++++++++++=
+++++-
>  2 files changed, 82 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index 09aa04ca1e27..afec53a48470 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -43,11 +43,22 @@ struct PropertyInfo {
>      ObjectPropertyRelease *release;
>  };
>
> +/**
> + * struct OnOffAutoBit64 - OnOffAuto storage with 64 elements.
> + * @on_bits: Bitmap of elements with "on".
> + * @auto_bits: Bitmap of elements with "auto".
> + */
> +typedef struct OnOffAutoBit64 {
> +    uint64_t on_bits;
> +    uint64_t auto_bits;
> +} OnOffAutoBit64;
> +
>
>  /*** qdev-properties.c ***/
>
>  extern const PropertyInfo qdev_prop_bit;
>  extern const PropertyInfo qdev_prop_bit64;
> +extern const PropertyInfo qdev_prop_on_off_auto_bit64;
>  extern const PropertyInfo qdev_prop_bool;
>  extern const PropertyInfo qdev_prop_enum;
>  extern const PropertyInfo qdev_prop_uint8;
> @@ -100,6 +111,13 @@ extern const PropertyInfo qdev_prop_link;
>                  .set_default =3D true,                              \
>                  .defval.u  =3D (bool)_defval)
>
> +#define DEFINE_PROP_ON_OFF_AUTO_BIT64(_name, _state, _field, _bit, _defv=
al) \
> +    DEFINE_PROP(_name, _state, _field, qdev_prop_on_off_auto_bit64,     =
    \
> +                OnOffAutoBit64,                                         =
    \
> +                .bitnr    =3D (_bit),                                   =
      \
> +                .set_default =3D true,                                  =
      \
> +                .defval.i =3D (OnOffAuto)_defval)
> +
>  #define DEFINE_PROP_BOOL(_name, _state, _field, _defval)     \
>      DEFINE_PROP(_name, _state, _field, qdev_prop_bool, bool, \
>                  .set_default =3D true,                         \
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 7d6fa726fdf2..b96f54a1b912 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -188,7 +188,8 @@ const PropertyInfo qdev_prop_bit =3D {
>
>  static uint64_t qdev_get_prop_mask64(Property *prop)
>  {
> -    assert(prop->info =3D=3D &qdev_prop_bit64);
> +    assert(prop->info =3D=3D &qdev_prop_bit64 ||
> +           prop->info =3D=3D &qdev_prop_on_off_auto_bit64);
>      return 0x1ull << prop->bitnr;
>  }
>
> @@ -233,6 +234,68 @@ const PropertyInfo qdev_prop_bit64 =3D {
>      .set_default_value =3D set_default_value_bool,
>  };
>
> +static void prop_get_on_off_auto_bit64(Object *obj, Visitor *v,
> +                                       const char *name, void *opaque,
> +                                       Error **errp)
> +{
> +    Property *prop =3D opaque;
> +    OnOffAutoBit64 *p =3D object_field_prop_ptr(obj, prop);
> +    int value;
> +    uint64_t mask =3D qdev_get_prop_mask64(prop);
> +
> +    if (p->auto_bits & mask) {
> +        value =3D ON_OFF_AUTO_AUTO;
> +    } else if (p->on_bits & mask) {
> +        value =3D ON_OFF_AUTO_ON;
> +    } else {
> +        value =3D ON_OFF_AUTO_OFF;
> +    }
> +
> +    visit_type_enum(v, name, &value, &OnOffAuto_lookup, errp);
> +}
> +
> +static void prop_set_on_off_auto_bit64(Object *obj, Visitor *v,
> +                                       const char *name, void *opaque,
> +                                       Error **errp)
> +{
> +    Property *prop =3D opaque;
> +    OnOffAutoBit64 *p =3D object_field_prop_ptr(obj, prop);
> +    int value;
> +    uint64_t mask =3D qdev_get_prop_mask64(prop);
> +
> +    if (!visit_type_enum(v, name, &value, &OnOffAuto_lookup, errp)) {
> +        return;
> +    }
> +
> +    switch (value) {
> +    case ON_OFF_AUTO_AUTO:
> +        p->on_bits &=3D ~mask;
> +        p->auto_bits |=3D mask;
> +        break;
> +
> +    case ON_OFF_AUTO_ON:
> +        p->on_bits |=3D mask;
> +        p->auto_bits &=3D ~mask;
> +        break;
> +
> +    case ON_OFF_AUTO_OFF:
> +        p->on_bits &=3D ~mask;
> +        p->auto_bits &=3D ~mask;
> +        break;
> +    }
> +}
> +
> +const PropertyInfo qdev_prop_on_off_auto_bit64 =3D {
> +    .name  =3D "bool",

Does it mean that the name of this tristate type is "bool"? Or I miss somet=
hing?

> +    .description =3D "on/off/auto",
> +    .enum_table =3D &OnOffAuto_lookup,
> +    .get =3D qdev_propinfo_get_enum,
> +    .set =3D qdev_propinfo_set_enum,
> +    .get =3D prop_get_on_off_auto_bit64,
> +    .set =3D prop_set_on_off_auto_bit64,
> +    .set_default_value =3D qdev_propinfo_set_default_value_enum,
> +};
> +
>  /* --- bool --- */
>
>  static void get_bool(Object *obj, Visitor *v, const char *name, void *op=
aque,
>
> --
> 2.44.0
>

