Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1FBCD37AC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 02:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMyyb-0007L3-Ld; Tue, 12 May 2026 22:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wMyyV-0007JU-3b
 for qemu-devel@nongnu.org; Tue, 12 May 2026 22:05:27 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wMyyS-0007GT-PK
 for qemu-devel@nongnu.org; Tue, 12 May 2026 22:05:26 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-bb91b426e40so1036358566b.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 19:05:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778637923; cv=none;
 d=google.com; s=arc-20240605;
 b=ihOtrNI0gHVofDzE0ZC5q3Y2IL/vAKasxS7t/oXjEklJ5Sckf7wJGXQWbBMVsIdofs
 8HyNJ8fhZ0M/+ibs6H6Y1hUrGrZRnLHkigYLd+qzU92p5l6kD96r+RJsAjm11kNTCakV
 yAC3KW1dRAlun20skUoStnOZjwPpu6l3Z1qi/kSDeJaGK/0Hcc3opB4Gd19M5b/ilNzk
 K/9CGI7+q3MBTI+VQ0EXUHJR3KXGzfpk09P91C6H+3OoQ80BxjJH8R2BRtOPvR9yw3HK
 OxYUWr5dxbTbY9sjPfV6J2rQ2VK0jGtNJW+IuNPy+8oWWXok/4EnVb1TCtJEp5t6YJ/Z
 lRjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JguOUOxTvkPMEtn0r6ePqJsnD5qgY+4w8XygDR3TLGg=;
 fh=GJpzZP0+Pf7IJLAkk7GGIc2jeyRGihtCPQbHClgK+cI=;
 b=C50xyCEk4mCO82ZA18iWfuMDjFwg78dATESfSD7q5HXZXEl1LNeAFp4udcgpCucMKS
 jP8cjNbdNCM4vIBQtcE7fOA1gAXdHmvUM5IDJ7h0pXgqRXF23gsbqS5T9NAyVhpbJPC9
 PG3ul1TNHt9P+2qew38+7VsMQkln2pqG7cRqro7cbRrlGI8O02Misf0ujjY5n/ylbjeM
 Aryb9mc2uPvIAPAXdTrZpzhpIWmaYSRMMhDw9/cfra/gcIHN071jtaYj5CfZLhoeWT5p
 mUZGRMKwTVEsDcNaWW5wKnizc5THsM/s8zWSODvwvpUXKf26vo82BF02+zwGntLA0g6f
 gxyA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778637923; x=1779242723; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JguOUOxTvkPMEtn0r6ePqJsnD5qgY+4w8XygDR3TLGg=;
 b=Gq4aeAntsIDZT9ry+4oFqkfQmu4vnX9WInsgoqUybZrgWvL62fqw2wMhmxG6I+bwQZ
 gFQCbeDkEkzDriMUPD74jYPFsUPuHuuCyd6/zhBL4CdOr/HOvJouT2uiyy8iI9dJQ18u
 8wDp0D8OXoMtWHsClJ7MjUke6BTp0jND3NC+4deE/bk1qjrG8lO13PTItkUfSoW3daCi
 NzCWAZyexKlrgJB0YykD5xX8/khaD2aGQRf1Ifigrji+GlnzbrF74sNjbBOk/Y8w3WPG
 NAk9LG2JsPSVHL6Hc2YOGk5rc53RFvIdL3sHx1I9Yzny8k+c9HG/SvkWwUrvxTVSSA9+
 Vfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778637923; x=1779242723;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JguOUOxTvkPMEtn0r6ePqJsnD5qgY+4w8XygDR3TLGg=;
 b=Ku9iLCCcE2eTz89gX/Z6s7ZiveSztBJuFUFvYF6aQ/gkBw9TR5zUUjaais0CwNus4J
 Be5tY7ihqiS0bB96AKgBJ2WUEZmD7Yor9zQdoP8u0picDIdYjlPonUTV99yUBy8ew9uk
 TLcjmhZglQ/5/hZh8Qtgcamxnlk2m1ugR/pwlK4VVKhaLjCpdZz5iY8ZlqGRRTg3FYfv
 XNeC1LItO8k08ewxyPCW5D64JxHZfii7U37LQHZRF7bCf23+0tJhraBlMRpa+i63lcVt
 CBxcO4p4DV0uqkoQL7u4jFHla4yj+YXdzjmnnw4cz5hXRMOxfg020PQejpO/1LZL2TXW
 EIRw==
X-Gm-Message-State: AOJu0YxUmzjDdnJtam0XRrkeOwxw+3LLkQhOzkRLheSg+Ge9dER4rLlo
 AxH74hj0cEK6O5JztylTCvQWwuKQYP2RszbaJVn8vULOFnq0jJLazCDhpohDgPJeSvMD6oJxXYB
 EL71S+RAbzwcD42bBA2giVlcuPTIdfjt0LQ==
X-Gm-Gg: Acq92OE543oBRqXIJdbapaJaC69Xs3piTo484HQCELPh3ZrSWSm0gATzQhzBkb2Aers
 iMDa64mEZuX3GExvpKtI7bak5dxnUbWjIDit8CjpeMtt2bo6M9E/J6YbzaaHEF9IacJYYjzH6Tb
 k3tyFLINXZbmw58dlAqN+3lsUuEqdCi56FikIqO2Ttui7OWbIYASpnAY4JcstlAvPWy32DX5XOI
 XETuIoW/2BG6nEQNTSDO4HgZjGN/osDZEO5q63wsoxOADNZlAes6CPf1ulgD3Q2RYXZ/gTQZ+2Y
 gU4avJ/EOv0YNUFofPZK5B5LAJz1ePDLTTkJaA==
X-Received: by 2002:a17:907:2da3:b0:bb8:b536:55dd with SMTP id
 a640c23a62f3a-bd3e30afdd8mr46577466b.41.1778637922849; Tue, 12 May 2026
 19:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
 <20260510-qom-qapi-v1-20-48ba6a1a1fa5@redhat.com>
In-Reply-To: <20260510-qom-qapi-v1-20-48ba6a1a1fa5@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 13 May 2026 12:04:55 +1000
X-Gm-Features: AVHnY4I9IOY_HbtEeylc8aDTfQTNVoyeWX-Q_EdX_PdSzd3qPXKDdGytC4Fru-g
Message-ID: <CAKmqyKNRiyUh07RiemEW6CvS-SDLOEwJb3NQ8ChRusP-0eGX3A@mail.gmail.com>
Subject: Re: [PATCH 20/54] riscv/virt: convert OnOffAuto properties to
 QAPI-aware registration
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Sun, May 10, 2026 at 11:49=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Convert the acpi and iommu-sys OnOffAuto properties from manual
> visitor-based callbacks to property_add_qapi_enum().
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c | 54 ++++++++++++++++++++++++---------------------------=
---
>  1 file changed, 24 insertions(+), 30 deletions(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index a1c323e66df..5148044df95 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -55,7 +55,7 @@
>  #include "hw/pci-host/gpex.h"
>  #include "hw/display/ramfb.h"
>  #include "hw/acpi/aml-build.h"
> -#include "qapi/qapi-visit-common.h"
> +#include "qapi/qapi-type-infos-common.h"
>  #include "hw/virtio/virtio-iommu.h"
>  #include "hw/uefi/var-service-api.h"
>
> @@ -1832,21 +1832,16 @@ bool virt_is_iommu_sys_enabled(RISCVVirtState *s)
>      return s->iommu_sys =3D=3D ON_OFF_AUTO_ON;
>  }
>
> -static void virt_get_iommu_sys(Object *obj, Visitor *v, const char *name=
,
> -                               void *opaque, Error **errp)
> +static int virt_get_iommu_sys(Object *obj, Error **errp)
>  {
>      RISCVVirtState *s =3D RISCV_VIRT_MACHINE(obj);
> -    OnOffAuto iommu_sys =3D s->iommu_sys;
> -
> -    visit_type_OnOffAuto(v, name, &iommu_sys, errp);
> +    return s->iommu_sys;
>  }
>
> -static void virt_set_iommu_sys(Object *obj, Visitor *v, const char *name=
,
> -                               void *opaque, Error **errp)
> +static void virt_set_iommu_sys(Object *obj, int value, Error **errp)
>  {
>      RISCVVirtState *s =3D RISCV_VIRT_MACHINE(obj);
> -
> -    visit_type_OnOffAuto(v, name, &s->iommu_sys, errp);
> +    s->iommu_sys =3D value;
>  }
>
>  bool virt_is_acpi_enabled(RISCVVirtState *s)
> @@ -1854,21 +1849,16 @@ bool virt_is_acpi_enabled(RISCVVirtState *s)
>      return s->acpi !=3D ON_OFF_AUTO_OFF;
>  }
>
> -static void virt_get_acpi(Object *obj, Visitor *v, const char *name,
> -                          void *opaque, Error **errp)
> +static int virt_get_acpi(Object *obj, Error **errp)
>  {
>      RISCVVirtState *s =3D RISCV_VIRT_MACHINE(obj);
> -    OnOffAuto acpi =3D s->acpi;
> -
> -    visit_type_OnOffAuto(v, name, &acpi, errp);
> +    return s->acpi;
>  }
>
> -static void virt_set_acpi(Object *obj, Visitor *v, const char *name,
> -                          void *opaque, Error **errp)
> +static void virt_set_acpi(Object *obj, int value, Error **errp)
>  {
>      RISCVVirtState *s =3D RISCV_VIRT_MACHINE(obj);
> -
> -    visit_type_OnOffAuto(v, name, &s->acpi, errp);
> +    s->acpi =3D value;
>  }
>
>  static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *ma=
chine,
> @@ -1966,17 +1956,21 @@ static void virt_machine_class_init(ObjectClass *=
oc, const void *data)
>          object_class_property_set_description(oc, "aia-guests", str);
>      }
>
> -    object_class_property_add(oc, "acpi", "OnOffAuto",
> -                              virt_get_acpi, virt_set_acpi,
> -                              NULL, NULL);
> -    object_class_property_set_description(oc, "acpi",
> -                                          "Enable ACPI");
> -
> -    object_class_property_add(oc, "iommu-sys", "OnOffAuto",
> -                              virt_get_iommu_sys, virt_set_iommu_sys,
> -                              NULL, NULL);
> -    object_class_property_set_description(oc, "iommu-sys",
> -                                          "Enable IOMMU platform device"=
);
> +    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
> +        .name =3D "acpi",
> +        .description =3D "Enable ACPI",
> +        .qapi_type =3D &OnOffAuto_type_info,
> +        .get =3D virt_get_acpi,
> +        .set =3D virt_set_acpi,
> +    ));
> +
> +    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
> +        .name =3D "iommu-sys",
> +        .description =3D "Enable IOMMU platform device",
> +        .qapi_type =3D &OnOffAuto_type_info,
> +        .get =3D virt_get_iommu_sys,
> +        .set =3D virt_set_iommu_sys,
> +    ));
>  }
>
>  static const TypeInfo virt_machine_typeinfo =3D {
>
> --
> 2.54.0
>
>

