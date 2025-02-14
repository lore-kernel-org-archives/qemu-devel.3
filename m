Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8664C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 15:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tixsB-0008QA-QQ; Fri, 14 Feb 2025 10:44:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tixs9-0008Pr-Ic
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 10:44:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tixs6-0003un-F4
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 10:44:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739547892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aGGaVv+akGxkMyDryYDQJcyoPGfBpa0qvxnEQxw9yio=;
 b=G6Cmn+fxd8Iv+O2mBW8RjWbm28MLSU8xir/RDJcaz7j6tN5M+rx9jTQ4Z1Z5Eeven8bsEZ
 1fnHpWani3tvak4mI8xu2zEqNtgSCeYB4ls2OY8gP8XwkiWsZMf8pGWdOdWzQhOc0/QmQS
 WplcKu0Qrb178dshRA5SSBD8C3N8zbA=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-T_Hbp2IcNYqpUaNIgUmSgg-1; Fri, 14 Feb 2025 10:44:50 -0500
X-MC-Unique: T_Hbp2IcNYqpUaNIgUmSgg-1
X-Mimecast-MFC-AGG-ID: T_Hbp2IcNYqpUaNIgUmSgg_1739547890
Received: by mail-il1-f197.google.com with SMTP id
 e9e14a558f8ab-3d18f59b9d0so426465ab.2
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 07:44:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739547890; x=1740152690;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aGGaVv+akGxkMyDryYDQJcyoPGfBpa0qvxnEQxw9yio=;
 b=bZXLHAbN+Wi8P1h7Tg49pfXWb4mSJ9ICHlDSLrIROaR+vhKTatV+W7C2jtZrcQJ2cR
 MJzf21pHiwpxO25Za9SvzQEDIqpAQbvM+dhoPZaygu2rDEZAzZqNRRRx6OKspEx6Ofwv
 HuyefZ+7I8TTOkN8lzUkbdUjLcalQ07TNUf4tX5r25Tg2lcfeNPTmq6mjt9hQtJyEMSU
 sbzTGx1Lt8Ao14z7kIduZJNqnF754tIgO6Wq9gor9DerW1iF3QUEL+tE+omJVnyeXbNJ
 0ZLId2O22lmlE71yc1JTBjYvezPkYl9jI9Eu3/+Suj77aQ6/X4auNEG050PPcdqUpeYw
 lzSg==
X-Gm-Message-State: AOJu0Yy950tBCFKHELrF+L5hbUYEyCCfvXPW/7ke3raytoXkD2W3pd+q
 SyzcRIbGDShjd4e7hBND/ulKd5yseuikuVhj9I36Ce56iDzP6wZ6bWvHWSbKgvaOw8hn49Zu/sc
 vzYSkJPbTo/JVnyuYOFIYbFIFRaVjQPwXE659qB5BdIS5JqAN8Yrl
X-Gm-Gg: ASbGncvME1bDCKctwLWhNmZzCW7qBu9pds2DTZF0I1TNwTlsyJ0uR9Bh6VGONHbN/Pc
 MxDbyulxIrK9O/XHXcd05/eDnw2wM0OniNoJU8r0jFB7nC559dQ2gSz35OnT4M2MXuFTVae2WyK
 Eq2mrZbH4LFlTG5dRYx7UIcbv3v1CwS9qE4UoSwgZWRfGvftSsbg4dZ0kOELOlvyuQO7SkmqE1Y
 AUGWYSSzG+2a7wjm1SuDjgo9A69V99VCiqwqjr1/lTdvFhiMh95gJDWew7JcIpGuz3ufP1FxLER
 VIGtH2e1
X-Received: by 2002:a05:6e02:320f:b0:3cf:c62c:761b with SMTP id
 e9e14a558f8ab-3d1999bbab4mr6830865ab.6.1739547889618; 
 Fri, 14 Feb 2025 07:44:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHcX5J1MfmTuxC+GJP0g/psGjD2+/gdOFlZRaYOMmE2gdnUnTi/KLN88BxhLlVBHaIAE8U0g==
X-Received: by 2002:a05:6e02:320f:b0:3cf:c62c:761b with SMTP id
 e9e14a558f8ab-3d1999bbab4mr6830835ab.6.1739547888844; 
 Fri, 14 Feb 2025 07:44:48 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed281487f0sm869396173.9.2025.02.14.07.44.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 07:44:48 -0800 (PST)
Date: Fri, 14 Feb 2025 08:44:45 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, tomitamoeko@gmail.com, corvin.koehne@gmail.com,
 Kirti Wankhede <kwankhede@nvidia.com>, Joao Martins
 <joao.m.martins@oracle.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Eric
 Farman <farman@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v3] vfio: Add property documentation
Message-ID: <20250214084445.339f3476.alex.williamson@redhat.com>
In-Reply-To: <20250214143415.1686526-1-clg@redhat.com>
References: <20250214143415.1686526-1-clg@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 14 Feb 2025 15:34:15 +0100
C=C3=A9dric Le Goater <clg@redhat.com> wrote:

> Investigate the git history to uncover when and why the VFIO
> properties were introduced and update the models. This is mostly
> targeting vfio-pci device, since vfio-platform, vfio-ap and vfio-ccw
> devices are simpler.
>=20
> Sort the properties based on the QEMU version in which they were
> introduced.
>=20
> Cc: Tony Krowiak <akrowiak@linux.ibm.com>
> Cc: Eric Farman <farman@linux.ibm.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>=20
>  Should we introduce documentation for properties like the kernel has
>  in Documentation/ABI/*/sysfs-* ?
>=20
>  Changes in v3:
>=20
>  - Re-organized the vfio-pci properties based on the QEMU version in
>    which they were introduced
>  - Added property labels
>  - Improved description as suggested by Alex, Tomita and Corvin
>=20
>  Changes in v2:
>=20
>  - Fixed version numbers
>  - Fixed #ifdef in vfio/ccw.c
>  - Addressed vfio-pci-nohotplug
>  - Organize the vfio-pci properties in topics
> =20
>  hw/vfio/ap.c       |   9 ++++
>  hw/vfio/ccw.c      |  15 ++++++
>  hw/vfio/pci.c      | 122 +++++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/platform.c |  25 ++++++++++
>  4 files changed, 171 insertions(+)
>=20
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 30b08ad375d5ecae886c5000fbaa364799fe76d0..c7ab4ff57ada0ed0e5a76f52b=
5a05c86ca4fe0b4 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -257,6 +257,15 @@ static void vfio_ap_class_init(ObjectClass *klass, v=
oid *data)
>      dc->hotpluggable =3D true;
>      device_class_set_legacy_reset(dc, vfio_ap_reset);
>      dc->bus_type =3D TYPE_AP_BUS;
> +
> +    object_class_property_set_description(klass, /* 3.1 */
> +                                          "sysfsdev",
> +                                          "Host sysfs path of assigned d=
evice");
> +#ifdef CONFIG_IOMMUFD
> +    object_class_property_set_description(klass, /* 9.0 */
> +                                          "iommufd",
> +                                          "Set host IOMMUFD backend devi=
ce");
> +#endif
>  }
> =20
>  static const TypeInfo vfio_ap_info =3D {
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 67bc137f9be6d43c5970c6271f3cdbfffd8a32de..ea766ae26c744c05515e1cc80=
a486a3462d82834 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -717,6 +717,21 @@ static void vfio_ccw_class_init(ObjectClass *klass, =
void *data)
>      cdc->handle_halt =3D vfio_ccw_handle_halt;
>      cdc->handle_clear =3D vfio_ccw_handle_clear;
>      cdc->handle_store =3D vfio_ccw_handle_store;
> +
> +    object_class_property_set_description(klass, /* 2.10 */
> +                                          "sysfsdev",
> +                                          "Host sysfs path of assigned d=
evice");
> +    object_class_property_set_description(klass, /* 3.0 */
> +                                          "force-orb-pfch",
> +                                          "Force unlimited prefetch");
> +#ifdef CONFIG_IOMMUFD
> +    object_class_property_set_description(klass, /* 9.0 */
> +                                          "iommufd",
> +                                          "Set host IOMMUFD backend devi=
ce");
> +#endif
> +    object_class_property_set_description(klass, /* 9.2 */
> +                                          "loadparm",
> +                                          "Define which devices that can=
 be used for booting");
>  }
> =20
>  static const TypeInfo vfio_ccw_info =3D {
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 9a55e7b77324babf7295132b08e3ba23b482a291..cdf4cdcf88c143ff145427cae=
3fd64239a2d1e74 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3433,6 +3433,119 @@ static void vfio_pci_dev_class_init(ObjectClass *=
klass, void *data)
>      pdc->exit =3D vfio_exitfn;
>      pdc->config_read =3D vfio_pci_read_config;
>      pdc->config_write =3D vfio_pci_write_config;
> +
> +    object_class_property_set_description(klass, /* 1.3 */
> +                                          "host",
> +                                          "Host PCI address [domain:]<bu=
s:slot.function> of assigned device");
> +    object_class_property_set_description(klass, /* 1.3 */
> +                                          "x-intx-mmap-timeout-ms",
> +                                          "When EOI is not provided by K=
VM/QEMU, wait time "
> +                                          "(milliseconds) to re-enable d=
evice direct access "
> +                                          "after INTx (DEBUG)");
> +    object_class_property_set_description(klass, /* 1.5 */
> +                                          "x-vga",
> +                                          "Expose VGA address spaces for=
 device");
> +    object_class_property_set_description(klass, /* 2.3 */
> +                                          "x-req",
> +                                          "Disable device request notifi=
cation support (DEBUG)");
> +    object_class_property_set_description(klass, /* 2.4 and 2.5 */
> +                                          "x-no-mmap",
> +                                          "Disable MMAP for device. Allo=
ws to trace MMIO "
> +                                          "accesses (DEBUG)");
> +    object_class_property_set_description(klass, /* 2.5 */
> +                                          "x-no-kvm-intx",
> +                                          "Disable direct VFIO->KVM INTx=
 injection. Allows to "
> +                                          "trace INTx interrupts (DEBUG)=
");
> +    object_class_property_set_description(klass, /* 2.5 */
> +                                          "x-no-kvm-msi",
> +                                          "Disable direct VFIO->KVM MSI =
injection. Allows to "
> +                                          "trace MSI interrupts (DEBUG)"=
);
> +    object_class_property_set_description(klass, /* 2.5 */
> +                                          "x-no-kvm-msix",
> +                                          "Disable direct VFIO->KVM MSIx=
 injection. Allows to "
> +                                          "trace MSIx interrupts (DEBUG)=
");
> +    object_class_property_set_description(klass, /* 2.5 */
> +                                          "x-pci-vendor-id",
> +                                          "Override PCI Vendor ID with p=
rovided value (DEBUG)");
> +    object_class_property_set_description(klass, /* 2.5 */
> +                                          "x-pci-device-id",
> +                                          "Override PCI device ID with p=
rovided value (DEBUG)");
> +    object_class_property_set_description(klass, /* 2.5 */
> +                                          "x-pci-sub-vendor-id",
> +                                          "Override PCI Sub Vendor ID wi=
th provided value (DEBUG)");
> +    object_class_property_set_description(klass, /* 2.5 */
> +                                          "x-pci-sub-device-id",
> +                                          "Override PCI Sub Device ID wi=
th provided value (DEBUG)");

Nit, we don't seem to have a character limit, so I'd go ahead and
s/Sub/Subsystem/.


> +    object_class_property_set_description(klass, /* 2.6 */
> +                                          "sysfsdev",
> +                                          "Host sysfs path of assigned d=
evice");
> +    object_class_property_set_description(klass, /* 2.7 */
> +                                          "x-igd-opregion",
> +                                          "Expose host IGD OpRegion to g=
uest");
> +    object_class_property_set_description(klass, /* 2.7 (See c4c45e943e5=
1) */
> +                                          "x-igd-gms",
> +                                          "Override IGD data stolen memo=
ry size (32MiB units). "
> +                                          "Assign 00:02.0 from the host =
to 00:02.0 in the VM");

Maybe it's a good general hint to assign IGD identity mapped to the
same PCI address in the guest as on the host, but it doesn't seem
particularly relevant to this specific option.

> +    object_class_property_set_description(klass, /* 2.11 */
> +                                          "x-nv-gpudirect-clique",
> +                                          "Add NVIDIA GPUDirect capabili=
ty indicating P2P DMA "
> +                                          "clique for device [0-15]");
> +    object_class_property_set_description(klass, /* 2.12 */
> +                                          "x-no-geforce-quirks",
> +                                          "Disable GeForce quirks (for N=
VIDIA Quadro/GRID/Tesla). "
> +                                          "Improves performance");
> +    object_class_property_set_description(klass, /* 2.12 */
> +                                          "display",
> +                                          "Enable display support for de=
vice, ex. vGPU");
> +    object_class_property_set_description(klass, /* 2.12 */
> +                                          "x-msix-relocation",
> +                                          "Specify MSI-X MMIO relocation=
 to the end of specified "
> +                                          "existing BAR or new BAR to av=
oid virtualization overhead "
> +                                          "due to adjacent device regist=
ers (sPAPR)");

I'd drop sPAPR reference, there are other reasons it can be useful.

> +    object_class_property_set_description(klass, /* 3.0 */
> +                                          "x-no-kvm-ioeventfd",
> +                                          "Disable registration of ioeve=
ntfds with KVM (DEBUG)");
> +    object_class_property_set_description(klass, /* 3.0 */
> +                                          "x-no-vfio-ioeventfd",
> +                                          "Disable linking of KVM ioeven=
tfds to VFIO ioeventfds"
> +                                          " (NVIDIA, DEBUG)");

Likewise dropping NVIDIA here.  Only currently used by an NVIDIA quirk,
but that could change.

> +    object_class_property_set_description(klass, /* 3.1 */
> +                                          "x-balloon-allowed",
> +                                          "Override allowing ballooning =
with device (DEBUG, DANGER)");
> +    object_class_property_set_description(klass, /* 3.2 */
> +                                          "xres",
> +                                          "Set X display resolution the =
vGPU should use");
> +    object_class_property_set_description(klass, /* 3.2 */
> +                                          "yres",
> +                                          "Set Y display resolution the =
vGPU should use");
> +    object_class_property_set_description(klass, /* 5.2 */
> +                                          "x-pre-copy-dirty-page-trackin=
g",
> +                                          "Disable dirty pages tracking =
during iterative phase");
> +    object_class_property_set_description(klass, /* 5.2, 8.0 non-experim=
etal */
> +                                          "enable-migration",
> +                                          "Enale device migration. Also =
requires a host VFIO PCI "
> +                                          "variant driver with migration=
 support enabled");

Variant or mdev.

> +    object_class_property_set_description(klass, /* 8.1 */
> +                                          "vf-token",
> +                                          "Specify UUID VF token. Requir=
ed for VF when PF is owned "
> +                                          "by another VFIO driver");
> +#ifdef CONFIG_IOMMUFD
> +    object_class_property_set_description(klass, /* 9.0 */
> +                                          "iommufd",
> +                                          "Set host IOMMUFD backend devi=
ce");
> +#endif
> +    object_class_property_set_description(klass, /* 9.1 */
> +                                          "x-device-dirty-page-tracking",
> +                                          "Disable device dirty page tra=
cking and use "
> +                                          "container-based dirty page tr=
acking");

This sounds like debug to me.

> +    object_class_property_set_description(klass, /* 9.1 */
> +                                          "migration-events",
> +                                          "Emit VFIO migration QAPI even=
t when a VFIO device "
> +                                          "changes its migration state. =
For management applications");
> +    object_class_property_set_description(klass, /* 9.1 */
> +                                          "skip-vsc-check",
> +                                          "Skip config space check for V=
endor Specific Capability "
> +                                          "(NVIDIA, DEBUG)");

Required for a specific migration use case with NVIDIA, but the option
is generic.  Given the polarity is by default true for the current
machine type, we might also indicate this provides an option for strict
VSC content enforcement.

>  }
> =20
>  static const TypeInfo vfio_pci_dev_info =3D {
> @@ -3461,6 +3574,15 @@ static void vfio_pci_nohotplug_dev_class_init(Obje=
ctClass *klass, void *data)
> =20
>      device_class_set_props(dc, vfio_pci_dev_nohotplug_properties);
>      dc->hotpluggable =3D false;
> +
> +    object_class_property_set_description(klass, /* 3.1 */
> +                                          "ramfb",
> +                                          "Enable ramfb to provide pre-b=
oot graphics for devices "
> +                                          "enabling display option");
> +    object_class_property_set_description(klass, /* 8.2 */
> +                                          "x-ramfb-migrate",
> +                                          "Override default migration su=
pport for ramfb support "
> +                                          "(DEBUG)");
>  }
> =20
>  static const TypeInfo vfio_pci_nohotplug_dev_info =3D {
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index 1070a2113a17edb9ebafb5066e51ee2bc52a767d..61b8b856fac26e26a4805dc2d=
5e65266b907ef58 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -674,6 +674,31 @@ static void vfio_platform_class_init(ObjectClass *kl=
ass, void *data)
>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>      /* Supported by TYPE_VIRT_MACHINE */
>      dc->user_creatable =3D true;
> +
> +    object_class_property_set_description(klass, /* 2.4 */
> +                                          "host",
> +                                          "Host device name of assigned =
device");
> +    object_class_property_set_description(klass, /* 2.4 and 2.5 */
> +                                          "x-no-mmap",
> +                                          "Disable MMAP for device. Allo=
ws to trace MMIO "
> +                                          "accesses (DEBUG)");
> +    object_class_property_set_description(klass, /* 2.4 */
> +                                          "mmap-timeout-ms",
> +                                          "When EOI is not provided by K=
VM/QEMU, wait time "
> +                                          "(milliseconds) to re-enable d=
evice direct access "
> +                                          "after INTx (DEBUG)");

INTx is a PCI-ism, maybe we should just call it level interrupts.

Thanks!
Alex

> +    object_class_property_set_description(klass, /* 2.4 */
> +                                          "x-irqfd",
> +                                          "Allow disabling irqfd support=
 (DEBUG)");
> +    object_class_property_set_description(klass, /* 2.6 */
> +                                          "sysfsdev",
> +                                          "Host sysfs path of assigned d=
evice");
> +#ifdef CONFIG_IOMMUFD
> +    object_class_property_set_description(klass, /* 9.0 */
> +                                          "iommufd",
> +                                          "Set host IOMMUFD backend devi=
ce");
> +#endif
> +
>  }
> =20
>  static const TypeInfo vfio_platform_dev_info =3D {


