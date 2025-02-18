Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18FA5C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 15:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkPOR-0003vT-Ij; Tue, 18 Feb 2025 10:20:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tkPON-0003tp-Kn
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:20:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tkPOH-0006kP-Q3
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:20:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739892002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+dqiMdOqvbsj/eOfHi8v2rwXuPrIwccDTNhNy41PIso=;
 b=a8dMbvIOsEKJfGzlXhobuQDC2cbeqd/z9+flZo6xpFZ5JvRHhiXGtOF5bQGfzxivcIo5jM
 KsU2Yc/ANIQR2SF0kqtoCKoeIaUM9F/zkAZFFa75An88jiN0N7n2aiIcoQxaXq6kSzhJh8
 kFwlmpz6Kwnqqc0li0qn67cE/TqXYhM=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-nUFC55zENQWe0arab8Xagw-1; Tue, 18 Feb 2025 10:20:00 -0500
X-MC-Unique: nUFC55zENQWe0arab8Xagw-1
X-Mimecast-MFC-AGG-ID: nUFC55zENQWe0arab8Xagw_1739891999
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-3d2a939f02fso1402905ab.3
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 07:20:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739891999; x=1740496799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+dqiMdOqvbsj/eOfHi8v2rwXuPrIwccDTNhNy41PIso=;
 b=AOIhwgBDCyrdz9B/tmVQJuC+vvVfUQU3eprsr1fayHAh4Ss8YbnJ8S417JkDQ1+lO5
 qmEMcrXYK9Y1DHwQOzmhv/cYGXdggT4E+MncYFOy7kl4RhAoMe+efJBXq0BM/KhpJV76
 fir5JLM2n0YMoldrgpewMCww7PBP2EdqLQFvdlVl97nnj69CTFzHGqXWnDCsJAKSeKV6
 t++TsaFt11h5StKjFhVG7GahyEyW8tsoWgSMmuG8b4kCgEC5IpoQYQ+tcaEUB32Rgqex
 xGLJS5v0j9H8nOAEHjPcmYXbPzWyWF/IRAw1qAGgtjWo+Zk3FODQD6unaCGYesaek1uH
 D82A==
X-Gm-Message-State: AOJu0Yw/BMhAwRZhSmk1DqNUJTLqXK2nuijO2+awkrmTFKSUyI5nTBEG
 aqiD97uLfnKeBZgnC+KWNsxGNSclxbigIrqnOhjri2ETv33kyTgmVrjhEEXAj2nsFuxrXCUDOl2
 0rVJuJkMt5lDRAQEvAbBYzwReJlYZhnIEoB0LMzNsCa+WQlxmbHI7
X-Gm-Gg: ASbGncsa8w7bGt/jMOrYo+CHlN94yHyOMt2szr6kpzVsxZXUWVMiNKe6LWgMmvBc7Qg
 qNttAci4YDBvnvd5h+eZbH/BpV+vA/9XbZZbUWI8mT/+84hMvj7uM3G4Kg1hxpAj/oqn+kgNTNC
 3nvDimbtxn5JB+SIngpSCsJyk3lttHiyGEJhK09ckYr4HXQ3MEyHnDSM3t9IOENQ2PxcMAaPKA6
 5pGKmkjdamxtO+WOpFFJI0H9/m2WzuUVIqJkJo/iVurQc5zZ7BVHNoVsxprwM4b3hNwU3esClqQ
 U/0rdGQ9
X-Received: by 2002:a05:6602:6408:b0:81f:86e1:5a84 with SMTP id
 ca18e2360f4ac-8557a0d2a4fmr347170539f.2.1739891999348; 
 Tue, 18 Feb 2025 07:19:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEn8piJZLv4ChhuHi0r7wRBBPSJ8gdo2Ehs/gGoBHjLCs46anv9hcG0tAIPs3dxzOc8FuEG2w==
X-Received: by 2002:a05:6602:6408:b0:81f:86e1:5a84 with SMTP id
 ca18e2360f4ac-8557a0d2a4fmr347168139f.2.1739891998742; 
 Tue, 18 Feb 2025 07:19:58 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed282b1066sm2632438173.101.2025.02.18.07.19.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 07:19:57 -0800 (PST)
Date: Tue, 18 Feb 2025 08:19:55 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, tomitamoeko@gmail.com, corvin.koehne@gmail.com,
 Kirti Wankhede <kwankhede@nvidia.com>, Joao Martins
 <joao.m.martins@oracle.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Eric
 Farman <farman@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v4] vfio: Add property documentation
Message-ID: <20250218081955.50c733fb.alex.williamson@redhat.com>
In-Reply-To: <20250217173455.449983-1-clg@redhat.com>
References: <20250217173455.449983-1-clg@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, 17 Feb 2025 18:34:55 +0100
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
>  Changes in v4:
>=20
>  - Latest improvements from Alex=20
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
>=20
>  hw/vfio/ap.c       |   9 ++++
>  hw/vfio/ccw.c      |  15 ++++++
>  hw/vfio/pci.c      | 125 +++++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/platform.c |  24 +++++++++
>  4 files changed, 173 insertions(+)
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
> index 6bb8882d3f2b965eb47cc9e65d7e74bbdb5e7685..e5e0d9e3e7ed124f242b3eda3=
45bc973e418a64c 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -709,6 +709,21 @@ static void vfio_ccw_class_init(ObjectClass *klass, =
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
> index 89d900e9cf0ce364f7c813d81b0317bb3b3e80ca..4f92b50b133060c9199079a0a=
b620793ecdac0ee 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3433,6 +3433,122 @@ static void vfio_pci_dev_class_init(ObjectClass *=
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

nit for consistency, s/device/Device/  Otherwise:

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


> +    object_class_property_set_description(klass, /* 2.5 */
> +                                          "x-pci-sub-vendor-id",
> +                                          "Override PCI Subsystem Vendor=
 ID with provided value "
> +                                          "(DEBUG)");
> +    object_class_property_set_description(klass, /* 2.5 */
> +                                          "x-pci-sub-device-id",
> +                                          "Override PCI Subsystem Device=
 ID with provided value "
> +                                          "(DEBUG)");
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
ry size (32MiB units)");
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
ers");
> +    object_class_property_set_description(klass, /* 3.0 */
> +                                          "x-no-kvm-ioeventfd",
> +                                          "Disable registration of ioeve=
ntfds with KVM (DEBUG)");
> +    object_class_property_set_description(klass, /* 3.0 */
> +                                          "x-no-vfio-ioeventfd",
> +                                          "Disable linking of KVM ioeven=
tfds to VFIO ioeventfds "
> +                                          "(DEBUG)");
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
during iterative phase "
> +                                          "(DEBUG)");
> +    object_class_property_set_description(klass, /* 5.2, 8.0 non-experim=
etal */
> +                                          "enable-migration",
> +                                          "Enale device migration. Also =
requires a host VFIO PCI "
> +                                          "variant or mdev driver with m=
igration support enabled");
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
acking (DEBUG)");
> +    object_class_property_set_description(klass, /* 9.1 */
> +                                          "migration-events",
> +                                          "Emit VFIO migration QAPI even=
t when a VFIO device "
> +                                          "changes its migration state. =
For management applications");
> +    object_class_property_set_description(klass, /* 9.1 */
> +                                          "skip-vsc-check",
> +                                          "Skip config space check for V=
endor Specific Capability. "
> +                                          "Setting to false will enforce=
 strict checking of VSC content "
> +                                          "(DEBUG)");
>  }
> =20
>  static const TypeInfo vfio_pci_dev_info =3D {
> @@ -3461,6 +3577,15 @@ static void vfio_pci_nohotplug_dev_class_init(Obje=
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
> index f491f4dc9543c2ea3a7af4e51ee82fbc7ee6e4bb..d9faaa73959ad36aa3a835b87=
964ab940928bd9f 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -672,6 +672,30 @@ static void vfio_platform_class_init(ObjectClass *kl=
ass, void *data)
>      dc->desc =3D "VFIO-based platform device assignment";
>      sbc->connect_irq_notifier =3D vfio_start_irqfd_injection;
>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
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
> +                                          "after level interrupt (DEBUG)=
");
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
>  }
> =20
>  static const TypeInfo vfio_platform_dev_info =3D {


