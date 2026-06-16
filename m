Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA659CD98DE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 00:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZI48-0000ca-OO; Mon, 15 Jun 2026 20:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZI47-0000bs-0Z
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 20:54:07 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZI45-00017t-9Z
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 20:54:06 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-bec450b950dso559495166b.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 17:54:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781571243; cv=none;
 d=google.com; s=arc-20240605;
 b=SGmMgqwuNuxtTnc4MOUQ545/GbdQNz7l3XZo7Lzx8FHzjPc7YTgyGRo3lWE+Pzahu6
 Kr3xANw5+Z0t+l3yzOydGffTHb/gje2ypCuFzJYQ0kuihz/9VuA8iLGRQ6JoJmPDLh0t
 fdu/TsSYIl+G1en+LmuBcgabAZtnrAPeTOEfihqkd/iQb2cody6DxozQk0hiZUPqC0jt
 Rq6qVHpLsiPLsDLpSnAeeeZwvd9YsJkGTU6Nd2ZiOF9Xd2ccp7mq+StxW6d2U/V2jGge
 OCO5pNoKCgaBkZD2fA2kFGi2TXN+af7bBTz4P+MSQKlHH0fN+Cm8ga+ui2oWvhmY8+yv
 fAlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=frN6oDZDGwh/1St6L1aoSNXbKtPOtK8QsjG0LTW437w=;
 fh=VWpDDznhhkns+RBYcpzRS+HdjURLRuFdq8+B6bSxo40=;
 b=FvzuP9/EU2M0u66kJyD/RRGqFpRGTBV4sRDtOF3rYjLEHFNlnK2LvwochJL2CUvqvx
 J48fyD7ANz6hoLgtHaJL7rPE5OBVsDm9lVKpk4p9OfXOB96LnXfgexxWKQzOCTMbFEqG
 jacvaGq6H3D75C0tbrd0yuCMoZTHpEIWrqeNyX07UmV2+LwFTVcqaWNlYwurV5F+QFIN
 1/dy+eOjRQOLQVn77+sVmxdBeXFH0RrvKp4i4v66R4kgzzasB4EJV3fwV+P1+ImFV6iZ
 MF5Vy9S8ajyjgYGYfYGyFmyIKEPQvGVrHk6Giyu1jGr8XeeR14D/HQ/PSS5pZ5fhIHkW
 JGVg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781571243; x=1782176043; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=frN6oDZDGwh/1St6L1aoSNXbKtPOtK8QsjG0LTW437w=;
 b=LiRP4oJb1z5kttTWyZ5ksclJODTi/d0C7aR+Y/x7PDN4wbJTriAStfpKP/z/p/c1Ar
 vWpPCNjQ7G8nNOirJ2bWVznJnxpYqtsTO4M5Cp3qC/vtna/fmptKPh7bvQk/b3Wd2rvB
 /oxXtOODaTVcHGe0dLQNOshc8mnGrlENx29BuzkahMegmWe1EFcsZE3/F6S1sYvRaWsn
 D1uH4Lp+EPEyzJZ0kEPNzrbKB239n3wrBDQkbeisttICrX2dI1w2u+u7qd7hSDDgYma8
 KJ1ZyANqs4fgYItSQ0FzfK+DeMYRya4Y/D56IL4beUhGbOxTSYmyTto6g+4INZUIPe2O
 C4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781571243; x=1782176043;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=frN6oDZDGwh/1St6L1aoSNXbKtPOtK8QsjG0LTW437w=;
 b=Fd3k3LIlIk9979/n89gJ2OQ9T3KAXskG4/aHfLolbG0gbPfKNHwd8LcKkMvbjT2ERo
 la4hU04I/8rxnNl+u6GOV01Fh0BOzfckabckvibzjhd+6pWiIidsQ32i4aF/Kq2hJP60
 rzKgUD1RlC2yQONkKddO/79EGf+t2g5o8jQC5LnRyots6AsKsG35FkZnuU6+xl3T3gHh
 KTOjHiw7xR3aaS64U5E7zwgEi7R4u8d+vtXdUCYXoKs8a5bQcrRn0tVSZ5U7uyUbzWLA
 H+wfS369Or5pel2dlK9aNEo0cjF9NL5hgh9Y3Rvh+3hM3Y/+gmgGcLFS/rby5hqxmyag
 IXRA==
X-Gm-Message-State: AOJu0YzyvdVQga+0YY4f5kKXKlN7DKYd67yZD0YlAv9mAKX5i2GAplVS
 Bfsfk8jHeKwX88b/5+j2yGpBH9Q04iKmOKyJiGI49NU+MMHKhY5bLQvxUrSdmyXRqT/L91hgfPK
 vzmk3m1aZLcLVcQDmncVj2LU73UnaCF0=
X-Gm-Gg: Acq92OFa92C+34jxDmH6YDthTFcBj4tnD9cKVjgcEXv3bQaHvXCQwDTxQatZPFXLy52
 /3r84sVtjHTVsYUv3orvg4S/HvjToT3I2nOPH/qmItDi6ngWVKtapOvZRoMXqxgrLX1ZQELQBVq
 6c0S+vh+TtPBz9Q3Ll/xq6Z1KAS+K5tXAL1jhMvUF9FQMhS64NaZCW6gc66VyMl/URttBC7usIf
 oTCjCfQHC4R/CecB4hng2MRmz/CZhNn44PIdz0FT1YP1ZQW95kfC+suOgrRXlv0Ivy+v0iEmG+a
 Ht/jw7c/yE/uGHeqPF13bwgKeRwW1eYdKA1BCA==
X-Received: by 2002:a17:907:98c:b0:c02:d992:a5fa with SMTP id
 a640c23a62f3a-c02d992ac4emr339158966b.28.1781571243077; Mon, 15 Jun 2026
 17:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
 <20260616-qom-qapi-v2-20-cc9396b9c18c@redhat.com>
In-Reply-To: <20260616-qom-qapi-v2-20-cc9396b9c18c@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 16 Jun 2026 10:53:35 +1000
X-Gm-Features: AVVi8Cd4Q61CKl9MEacghYBfPVQrrmf0iMn0iS_vm-wT9ry9L2x8xkK0ObWqHWY
Message-ID: <CAKmqyKPV1D4W1BMZAtZ6MfKLN-wEyDJ9iS2mYoPRC80xW10xZw@mail.gmail.com>
Subject: Re: [PATCH v2 20/53] riscv/virt: convert OnOffAuto properties to
 QAPI-aware registration
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x636.google.com
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

On Tue, Jun 16, 2026 at 6:40=E2=80=AFAM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Convert the acpi and iommu-sys OnOffAuto properties from manual
> visitor-based callbacks to property_add_qapi_enum().
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c | 54 ++++++++++++++++++++++++---------------------------=
---
>  1 file changed, 24 insertions(+), 30 deletions(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index ce64eaaef7d..65c3e27ec85 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -56,7 +56,7 @@
>  #include "hw/pci-host/gpex.h"
>  #include "hw/display/ramfb.h"
>  #include "hw/acpi/aml-build.h"
> -#include "qapi/qapi-visit-common.h"
> +#include "qapi/qapi-type-infos-common.h"
>  #include "hw/virtio/virtio-iommu.h"
>  #include "hw/uefi/var-service-api.h"
>
> @@ -1846,21 +1846,16 @@ bool virt_is_iommu_sys_enabled(RISCVVirtState *s)
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
> @@ -1868,21 +1863,16 @@ bool virt_is_acpi_enabled(RISCVVirtState *s)
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
> @@ -1980,17 +1970,21 @@ static void virt_machine_class_init(ObjectClass *=
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

