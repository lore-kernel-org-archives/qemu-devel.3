Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5829D65C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 13:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVs1r-0005Dh-Tr; Wed, 17 Dec 2025 08:57:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vVs1p-0005As-OX
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 08:57:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vVs1m-0005dD-Fm
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 08:57:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765979836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3F0WNLaHFmVlf6aY2Jthg+sJHJ2H3h6kMJ0SNkDNwm0=;
 b=UDnNgoPBmNB37p1gBebfjU8GTXbj22LHXYAU9tDS0pNkKg6u26Tk3Jfq9XhkmlLVsgRyTb
 Ww4QNY0LYpGJZVyAD5yTlbiZ993kAhUOOta2g0jvYEx6Db+nvsmIxkdgAE+emURphKhsgC
 X8dZZkT3GYBtq4d/79IXAJOspX0NBi8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-k8tYS2qwOOmzsT3R3MsDjw-1; Wed, 17 Dec 2025 08:57:15 -0500
X-MC-Unique: k8tYS2qwOOmzsT3R3MsDjw-1
X-Mimecast-MFC-AGG-ID: k8tYS2qwOOmzsT3R3MsDjw_1765979834
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-430fcfe4494so2302210f8f.2
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 05:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765979833; x=1766584633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3F0WNLaHFmVlf6aY2Jthg+sJHJ2H3h6kMJ0SNkDNwm0=;
 b=HIfqZyk8L0e+w6QclsKmx7gXFcaLAWFRkagrSUWlHYm+12qo4uZoBXA5Dzsmb+aJ4O
 dkbefQy3Ut1P1c0DsXyIGxYmgUMmTvVRbPMrAubawO2rRraMqRbkuKxQfkuyckxDwx68
 JeC0lv7zuXNIyPBOcqQxs85cxrqIUqt9TG1iSyzJPY6smIVHnqb4e2GDiQcVW3UFhpoH
 iDkYF+2i9V4jjQ63K/zUfHqo8TFWVhOivI3O6c8lVU9JFa3ac8VleukJ3lJ8Z8Fy9ybE
 WMrdLScKjQqE/YX3NiHxa54EaMs0Gv1guD6xbnsOJPYEIGuAg77xO+ksYonZyhRVL7Rz
 IsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765979833; x=1766584633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3F0WNLaHFmVlf6aY2Jthg+sJHJ2H3h6kMJ0SNkDNwm0=;
 b=OdoLl4XncRraF20GvWo5JjPYnVyfYLoXeOSPNPwhNwZ73+tmhYfrdH/oJBimBdh46H
 zyiyAftYkiqFcjmHo6bBc32GrzqXMegXc2kYN3JvuCJ4VUu5kBx1vMkbPfkEM79/SRnS
 qkchJbHHwC/7IOOJ0VEsNO2DL8Dz5UiQohSkAthJXGjoihLDE84fVCbM8iwdrxJIxt9E
 KaVAyu1np5DPeCHRPTmiJK71QuX+H9PGNR2t1JhqN9OejhZNwOgtrGkhoIUNGjMa7KoU
 xWYhUxhPwmZg0yrW9oLdPpl1PFxKZ4nUrnlJF/wLAoYX2jDjKl0+uRvHpjJ1GCe4FvBX
 dNbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxyqfOtqqQ5YzbUIVK9yJrDKL1M9YukXMUKYYjcd0WnH3W92LMIN31vEl1lrb1nK5oAGFYvquOtE+C@nongnu.org
X-Gm-Message-State: AOJu0Yy0K5uyEOtvgPRvH2DJiyIn1KM2BzciW4DAZ6Oojo5nWKqnPlWx
 0Us8N8H52wqYul5x5o1ZXtv7R81juB09G3eQjTCIuwpbmuuNeU85bI/2GT/lq61KZ36fcpZNb2p
 FZ7WwKomT55Q+EYQ1Nus2tbpRUt2lhjh8i8DqPqFHLiTcEXrY5Y37SD+qcwZ+zTu5
X-Gm-Gg: AY/fxX5ZLL/CMmceGPa6yr9xzyxc/t8cAE/gequlH9G+h3RuoSzPrT/YsfoY27yccdv
 Ydt4CyvvnDylvin4opziDX1E9jsFkTSbSYBauySqDzq8ejFi2G2kWpoQ06cpBeL251KmeI3m6Fa
 hnOXN1vy/71O1wPocdkvpbxUUQy+elHCvX5zdLC6mPKxEpfKIjyjlxk7e7uk8iI7S+Uns2VLYsL
 w7Y3mSh9BSZ9y1afw6jeOch1oybSPi+S985YP2XuIrLQtRG65sXrLpK2HPCFqujMEVn/77ngj0U
 dFIjiFU792np6vNQ7orHvYDMtniCdgHqw+IfapWOHl4DJbs8sJgh6hOsefmeopH3ENHwEQ==
X-Received: by 2002:adf:facf:0:b0:42f:b707:56ef with SMTP id
 ffacd0b85a97d-42fb7075b6cmr15802329f8f.39.1765979833334; 
 Wed, 17 Dec 2025 05:57:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRSB9EC73JDvLGo3x+MzaKK4LeTXIeDiVz9ApXbCYEhRDC0td/CszxCOm3C8378xhfhySZtA==
X-Received: by 2002:adf:facf:0:b0:42f:b707:56ef with SMTP id
 ffacd0b85a97d-42fb7075b6cmr15802289f8f.39.1765979832753; 
 Wed, 17 Dec 2025 05:57:12 -0800 (PST)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4310ade8072sm5151757f8f.25.2025.12.17.05.57.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 05:57:12 -0800 (PST)
Date: Wed, 17 Dec 2025 14:57:09 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas
 Huth <thuth@redhat.com>, qemu-devel@nongnu.org, devel@lists.libvirt.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org, Richard
 Henderson <richard.henderson@linaro.org>, Sergio Lopez <slp@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, Jiaxun
 Yang <jiaxun.yang@flygoat.com>, Yi Liu <yi.l.liu@intel.com>, Eduardo
 Habkost <eduardo@habkost.net>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Weiwei Li <liwei1518@gmail.com>, Amit Shah
 <amit@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, Yanan Wang
 <wangyanan55@huawei.com>, Helge Deller <deller@gmx.de>, Palmer Dabbelt
 <palmer@dabbelt.com>, "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Ani Sinha <anisinha@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?B?Q2zDqW1lbnQ=?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, Huacai
 Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>, Mark
 Cave-Ayland <mark.caveayland@nutanix.com>, BALATON Zoltan
 <balaton@eik.bme.hu>, Peter Krempa <pkrempa@redhat.com>, Jiri Denemark
 <jdenemar@redhat.com>
Subject: Re: [PATCH v5 04/28] hw/i386/pc: Remove
 PCMachineClass::legacy_cpu_hotplug field
Message-ID: <20251217145709.21b9e2d6@imammedo>
In-Reply-To: <20251202162835.3227894-5-zhao1.liu@intel.com>
References: <20251202162835.3227894-1-zhao1.liu@intel.com>
 <20251202162835.3227894-5-zhao1.liu@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed,  3 Dec 2025 00:28:11 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>=20
> Now all PC & Q35 machiens are using modern hotplug from the beginning,
> and all legacy_cpu_hotplug flags keep false during runtime.
>=20
> So it's safe to remove legacy_cpu_hotplug flags and related properties,
> with unused gpe_cpu field.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
> Changes since v4:
>  * Referring Igor's v5 [*], drop gpe_cpu field and does not only remove
>    build_legacy_cpu_hotplug_aml(), but instead remove the entire
>    cpu_hotplug.c file in a separate patch.
>=20
> [*]: https://lore.kernel.org/qemu-devel/20251031142825.179239-1-imammedo@=
redhat.com/
> ---
>  hw/acpi/ich9.c          | 40 ++++------------------------------------
>  hw/acpi/piix4.c         | 40 ++++------------------------------------
>  hw/i386/acpi-build.c    |  4 +---
>  include/hw/acpi/ich9.h  |  2 --
>  include/hw/acpi/piix4.h |  2 --
>  include/hw/i386/pc.h    |  3 ---
>  6 files changed, 9 insertions(+), 82 deletions(-)
>=20
> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> index 54590129c695..f254f3879716 100644
> --- a/hw/acpi/ich9.c
> +++ b/hw/acpi/ich9.c
> @@ -339,26 +339,6 @@ static void ich9_pm_get_gpe0_blk(Object *obj, Visito=
r *v, const char *name,
>      visit_type_uint32(v, name, &value, errp);
>  }
> =20
> -static bool ich9_pm_get_cpu_hotplug_legacy(Object *obj, Error **errp)
> -{
> -    ICH9LPCState *s =3D ICH9_LPC_DEVICE(obj);
> -
> -    return s->pm.cpu_hotplug_legacy;
> -}
> -
> -static void ich9_pm_set_cpu_hotplug_legacy(Object *obj, bool value,
> -                                           Error **errp)
> -{
> -    ICH9LPCState *s =3D ICH9_LPC_DEVICE(obj);
> -
> -    assert(!value);
> -    if (s->pm.cpu_hotplug_legacy && value =3D=3D false) {
> -        acpi_switch_to_modern_cphp(&s->pm.gpe_cpu, &s->pm.cpuhp_state,
> -                                   ICH9_CPU_HOTPLUG_IO_BASE);
> -    }
> -    s->pm.cpu_hotplug_legacy =3D value;
> -}
> -
>  static bool ich9_pm_get_enable_tco(Object *obj, Error **errp)
>  {
>      ICH9LPCState *s =3D ICH9_LPC_DEVICE(obj);
> @@ -403,7 +383,6 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMReg=
s *pm)
>  {
>      static const uint32_t gpe0_len =3D ICH9_PMIO_GPE0_LEN;
>      pm->acpi_memory_hotplug.is_enabled =3D true;
> -    pm->cpu_hotplug_legacy =3D false;
>      pm->disable_s3 =3D 0;
>      pm->disable_s4 =3D 0;
>      pm->s4_val =3D 2;
> @@ -422,9 +401,6 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMReg=
s *pm)
>                          NULL, NULL, pm);
>      object_property_add_uint32_ptr(obj, ACPI_PM_PROP_GPE0_BLK_LEN,
>                                     &gpe0_len, OBJ_PROP_FLAG_READ);
> -    object_property_add_bool(obj, "cpu-hotplug-legacy",
> -                             ich9_pm_get_cpu_hotplug_legacy,
> -                             ich9_pm_set_cpu_hotplug_legacy);
>      object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S3_DISABLED,
>                                    &pm->disable_s3, OBJ_PROP_FLAG_READWRI=
TE);
>      object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S4_DISABLED,
> @@ -477,11 +453,7 @@ void ich9_pm_device_plug_cb(HotplugHandler *hotplug_=
dev, DeviceState *dev,
>                                  dev, errp);
>          }
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> -        if (lpc->pm.cpu_hotplug_legacy) {
> -            legacy_acpi_cpu_plug_cb(hotplug_dev, &lpc->pm.gpe_cpu, dev, =
errp);
> -        } else {
> -            acpi_cpu_plug_cb(hotplug_dev, &lpc->pm.cpuhp_state, dev, err=
p);
> -        }
> +        acpi_cpu_plug_cb(hotplug_dev, &lpc->pm.cpuhp_state, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>          acpi_pcihp_device_plug_cb(hotplug_dev, &lpc->pm.acpi_pci_hotplug,
>                                    dev, errp);
> @@ -500,8 +472,7 @@ void ich9_pm_device_unplug_request_cb(HotplugHandler =
*hotplug_dev,
>          acpi_memory_unplug_request_cb(hotplug_dev,
>                                        &lpc->pm.acpi_memory_hotplug, dev,
>                                        errp);
> -    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) &&
> -               !lpc->pm.cpu_hotplug_legacy) {
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>          uint64_t negotiated =3D lpc->smi_negotiated_features;
> =20
>          if (negotiated & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT) &&
> @@ -533,8 +504,7 @@ void ich9_pm_device_unplug_cb(HotplugHandler *hotplug=
_dev, DeviceState *dev,
> =20
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          acpi_memory_unplug_cb(&lpc->pm.acpi_memory_hotplug, dev, errp);
> -    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) &&
> -               !lpc->pm.cpu_hotplug_legacy) {
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>          acpi_cpu_unplug_cb(&lpc->pm.cpuhp_state, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>          acpi_pcihp_device_unplug_cb(hotplug_dev, &lpc->pm.acpi_pci_hotpl=
ug,
> @@ -556,7 +526,5 @@ void ich9_pm_ospm_status(AcpiDeviceIf *adev, ACPIOSTI=
nfoList ***list)
>      ICH9LPCState *s =3D ICH9_LPC_DEVICE(adev);
> =20
>      acpi_memory_ospm_status(&s->pm.acpi_memory_hotplug, list);
> -    if (!s->pm.cpu_hotplug_legacy) {
> -        acpi_cpu_ospm_status(&s->pm.cpuhp_state, list);
> -    }
> +    acpi_cpu_ospm_status(&s->pm.cpuhp_state, list);
>  }
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index a7a29b0d09a9..6ad5f1d1c19d 100644
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -336,11 +336,7 @@ static void piix4_device_plug_cb(HotplugHandler *hot=
plug_dev,
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>          acpi_pcihp_device_plug_cb(hotplug_dev, &s->acpi_pci_hotplug, dev=
, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> -        if (s->cpu_hotplug_legacy) {
> -            legacy_acpi_cpu_plug_cb(hotplug_dev, &s->gpe_cpu, dev, errp);
> -        } else {
> -            acpi_cpu_plug_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
> -        }
> +        acpi_cpu_plug_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
>      } else {
>          g_assert_not_reached();
>      }
> @@ -358,8 +354,7 @@ static void piix4_device_unplug_request_cb(HotplugHan=
dler *hotplug_dev,
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>          acpi_pcihp_device_unplug_request_cb(hotplug_dev, &s->acpi_pci_ho=
tplug,
>                                              dev, errp);
> -    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) &&
> -               !s->cpu_hotplug_legacy) {
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>          acpi_cpu_unplug_request_cb(hotplug_dev, &s->cpuhp_state, dev, er=
rp);
>      } else {
>          error_setg(errp, "acpi: device unplug request for not supported =
device"
> @@ -378,8 +373,7 @@ static void piix4_device_unplug_cb(HotplugHandler *ho=
tplug_dev,
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>          acpi_pcihp_device_unplug_cb(hotplug_dev, &s->acpi_pci_hotplug, d=
ev,
>                                      errp);
> -    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) &&
> -               !s->cpu_hotplug_legacy) {
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>          acpi_cpu_unplug_cb(&s->cpuhp_state, dev, errp);
>      } else {
>          error_setg(errp, "acpi: device unplug for not supported device"
> @@ -523,26 +517,6 @@ static const MemoryRegionOps piix4_gpe_ops =3D {
>      .endianness =3D DEVICE_LITTLE_ENDIAN,
>  };
> =20
> -
> -static bool piix4_get_cpu_hotplug_legacy(Object *obj, Error **errp)
> -{
> -    PIIX4PMState *s =3D PIIX4_PM(obj);
> -
> -    return s->cpu_hotplug_legacy;
> -}
> -
> -static void piix4_set_cpu_hotplug_legacy(Object *obj, bool value, Error =
**errp)
> -{
> -    PIIX4PMState *s =3D PIIX4_PM(obj);
> -
> -    assert(!value);
> -    if (s->cpu_hotplug_legacy && value =3D=3D false) {
> -        acpi_switch_to_modern_cphp(&s->gpe_cpu, &s->cpuhp_state,
> -                                   PIIX4_CPU_HOTPLUG_IO_BASE);
> -    }
> -    s->cpu_hotplug_legacy =3D value;
> -}
> -
>  static void piix4_acpi_system_hot_add_init(MemoryRegion *parent,
>                                             PCIBus *bus, PIIX4PMState *s)
>  {
> @@ -558,10 +532,6 @@ static void piix4_acpi_system_hot_add_init(MemoryReg=
ion *parent,
>          qbus_set_hotplug_handler(BUS(pci_get_bus(PCI_DEVICE(s))), OBJECT=
(s));
>      }
> =20
> -    s->cpu_hotplug_legacy =3D false;
> -    object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
> -                             piix4_get_cpu_hotplug_legacy,
> -                             piix4_set_cpu_hotplug_legacy);
>      cpu_hotplug_hw_init(parent, OBJECT(s), &s->cpuhp_state,
>                          PIIX4_CPU_HOTPLUG_IO_BASE);
> =20
> @@ -576,9 +546,7 @@ static void piix4_ospm_status(AcpiDeviceIf *adev, ACP=
IOSTInfoList ***list)
>      PIIX4PMState *s =3D PIIX4_PM(adev);
> =20
>      acpi_memory_ospm_status(&s->acpi_memory_hotplug, list);
> -    if (!s->cpu_hotplug_legacy) {
> -        acpi_cpu_ospm_status(&s->cpuhp_state, list);
> -    }
> +    acpi_cpu_ospm_status(&s->cpuhp_state, list);
>  }
> =20
>  static void piix4_send_gpe(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 23147ddc25e7..bf7ed2e50837 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -960,9 +960,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>      }
>      aml_append(dsdt, scope);
> =20
> -    if (pcmc->legacy_cpu_hotplug) {
> -        build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
> -    } else {
> +    {
>          CPUHotplugFeatures opts =3D {
>              .acpi_1_compatible =3D true,
>              .smi_path =3D pm->smi_on_cpuhp ? "\\_SB.PCI0.SMI0.SMIC" : NU=
LL,
> diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
> index 245fe08dc245..6a21472eb32e 100644
> --- a/include/hw/acpi/ich9.h
> +++ b/include/hw/acpi/ich9.h
> @@ -53,8 +53,6 @@ typedef struct ICH9LPCPMRegs {
>      uint32_t pm_io_base;
>      Notifier powerdown_notifier;
> =20
> -    bool cpu_hotplug_legacy;
> -    AcpiCpuHotplug gpe_cpu;
>      CPUHotplugState cpuhp_state;
> =20
>      bool keep_pci_slot_hpc;
> diff --git a/include/hw/acpi/piix4.h b/include/hw/acpi/piix4.h
> index eb1c122d8069..e075f0cbeaf1 100644
> --- a/include/hw/acpi/piix4.h
> +++ b/include/hw/acpi/piix4.h
> @@ -63,8 +63,6 @@ struct PIIX4PMState {
>      uint8_t disable_s4;
>      uint8_t s4_val;
> =20
> -    bool cpu_hotplug_legacy;
> -    AcpiCpuHotplug gpe_cpu;
>      CPUHotplugState cpuhp_state;
> =20
>      MemHotplugState acpi_memory_hotplug;
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index e83157ab358f..698e3fb84af0 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -110,9 +110,6 @@ struct PCMachineClass {
>      bool enforce_amd_1tb_hole;
>      bool isa_bios_alias;
> =20
> -    /* generate legacy CPU hotplug AML */
> -    bool legacy_cpu_hotplug;
> -
>      /* use PVH to load kernels that support this feature */
>      bool pvh_enabled;
> =20


