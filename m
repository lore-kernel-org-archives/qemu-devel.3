Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0F2C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 21:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tih1W-0002oo-5X; Thu, 13 Feb 2025 16:45:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tih1T-0002oU-3f
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 16:45:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tih1Q-0008E1-FW
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 16:45:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739483121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=krwafJ1MS1poo1Quibb7pwn+T4kemrIIEH0blMUzKL4=;
 b=WYXTYoNasK6IOlGemjWUdPHLHXrLGYwttJZTBP0Rl9ppThrKWRuVSa3qfBXRHZ6fubmvht
 zu2RXLhWNN+mS7KAWk2N+Nt/4DrfHlmaNyT4owcLquiDfaCgMvGe4IOJsEQEdwL3y0p2NV
 hMwjD/4L3jxyjIRnSuWsOPJEW1W92Nk=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-R3J5khKOO02pWDNkZBGtIQ-1; Thu, 13 Feb 2025 16:45:19 -0500
X-MC-Unique: R3J5khKOO02pWDNkZBGtIQ-1
X-Mimecast-MFC-AGG-ID: R3J5khKOO02pWDNkZBGtIQ_1739483119
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-3d14222533bso1326295ab.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 13:45:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739483119; x=1740087919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=krwafJ1MS1poo1Quibb7pwn+T4kemrIIEH0blMUzKL4=;
 b=NqlOPPwDCwm+WyFRXFZYYuuygmbuNKB2g8HgaZ9ZxDfr/2Ls6xVUxFcpA+6Z1BDthP
 JuqZ0xpdATa//unp/v+ZpYUSgGd5vZ/NDSQB01TSl9gz91WgfGFzDJClY7ZPCDJFrQA0
 pCyiziq2PkBB2ft1Yvyyh94BnJcxFd/IqdmiyhLgYGmolmpboWKVkuKdn7tUIheocMKt
 U6qoyDKFvT1VW5SwarGsWhsyRnSExnvNEiIzrYP0M5OsmOxyEAgNL49xNlLksgeMAojR
 IVJcs5MLzgFFLqICg/m2vcy001VQxOz97E06iE2Nx0hz7UefjJgGZVhnVF2+xtS9jczC
 U4aQ==
X-Gm-Message-State: AOJu0YxdjGG6rTIb6zF/LzAWD3SAtxkfdL4kDmn//3fcn/GF1f+RydXx
 hSmDLokCBo/YcWPMRAtFyaY/S7hxzwA5kyYEttOW9l2QLqCEzvts9wu90MnxKuoKMNJkykmPKEi
 fhU9pqbJ+YoJnjbW0N/cy662IRWt2kyAn9BsN/wjdS/xJ4JAEi5kP
X-Gm-Gg: ASbGncud0cEOa5qQPWbhNnkaIFqMn+Q2K3bjWQ0Qu3TIheEKZvs9K66rtsyFoEQHVUv
 JCx9P53RI8VXuZIVAT506cFHL4XL3qdoZITGkDW0Paq7A2QhRfqwH9kuBTI+Xx9yqIbyieLEOcK
 Df+uFbIWEElL3553ymlfSDa666bm0/MsSVqhUrHunKnxNzLhXvbhWY0WgXb0CBSPXYEFBfxB9T0
 P90xiTj9u8iRbNV/udSQsQnw4Fgwz713aTHtqyBDDVpCM1mXkdPIPFbWJ8FohJyZ4RCK68LNHyv
 UphmD4gu
X-Received: by 2002:a05:6602:3411:b0:83a:e6b2:be3 with SMTP id
 ca18e2360f4ac-85556253fa8mr226984739f.0.1739483118912; 
 Thu, 13 Feb 2025 13:45:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7ABOe6pjOnZRr6s8LhslVJL7EaUcYVforsqLLs99D59r23MDobEflrh7/PW/0b1pTt1PqfQ==
X-Received: by 2002:a05:6602:3411:b0:83a:e6b2:be3 with SMTP id
 ca18e2360f4ac-85556253fa8mr226984239f.0.1739483118420; 
 Thu, 13 Feb 2025 13:45:18 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed282afff9sm507978173.90.2025.02.13.13.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 13:45:16 -0800 (PST)
Date: Thu, 13 Feb 2025 14:45:13 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Tony Krowiak <akrowiak@linux.ibm.com>, Eric
 Farman <farman@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>,
 tomitamoeko@gmail.com, corvin.koehne@gmail.com
Subject: Re: [PATCH v2] vfio: Add property documentation
Message-ID: <20250213144513.32b3241f.alex.williamson@redhat.com>
In-Reply-To: <20250213135050.1426258-1-clg@redhat.com>
References: <20250213135050.1426258-1-clg@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, 13 Feb 2025 14:50:50 +0100
C=C3=A9dric Le Goater <clg@redhat.com> wrote:

> Investigate the git history to uncover when and why the VFIO
> properties were introduced and update the models. This is mostly
> targeting vfio-pci device, since vfio-plateform, vfio-ap and vfio-ccw
> devices are simpler.
>=20
> Organize the vfio-pci properties in topics. It would be great to have
> a way to do the same for the output.
>=20
> Cc: Tony Krowiak <akrowiak@linux.ibm.com>
> Cc: Eric Farman <farman@linux.ibm.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>=20
>  Changes in v2:
>=20
>  - Fixed version numbers
>  - Fixed #ifdef in vfio/ccw.c
>  - Addressed vfio-pci-nohotplug
>  - Organize the vfio-pci properties in topics
>=20
>  hw/vfio/ap.c       |   9 +++
>  hw/vfio/ccw.c      |  15 +++++
>  hw/vfio/pci.c      | 134 +++++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/platform.c |  23 ++++++++
>  4 files changed, 181 insertions(+)
>=20
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 30b08ad375d5ecae886c5000fbaa364799fe76d0..ec1150e5d627fce83a5a6319a=
f471fd0aa45ae9b 100644
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
ce ");
> +#endif
>  }
> =20
>  static const TypeInfo vfio_ap_info =3D {
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 67bc137f9be6d43c5970c6271f3cdbfffd8a32de..242dc39660fcd028722093d63=
7b7b64440649863 100644
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
ce ");
> +#endif
> +    object_class_property_set_description(klass, /* 9.2 */
> +                                          "loadparm",
> +                                          "Define which devices that can=
 be used for booting");
>  }
> =20
>  static const TypeInfo vfio_ccw_info =3D {
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 9a55e7b77324babf7295132b08e3ba23b482a291..fbd8cf566b1cfd508ccb0042a=
395e3b79ba781c0 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3433,6 +3433,133 @@ static void vfio_pci_dev_class_init(ObjectClass *=
klass, void *data)
>      pdc->exit =3D vfio_exitfn;
>      pdc->config_read =3D vfio_pci_read_config;
>      pdc->config_write =3D vfio_pci_write_config;
> +
> +    object_class_property_set_description(klass, /* 1.3 */
> +                                          "host",
> +                                          "Host PCI address [domain:]<bu=
s:slot.function> of assigned device");
> +    object_class_property_set_description(klass, /* 2.6 */
> +                                          "sysfsdev",
> +                                          "Host sysfs path of assigned d=
evice");
> +    /*
> +     * Display
> +     */
> +
> +    object_class_property_set_description(klass, /* 1.5 */
> +                                          "x-vga",
> +                                          "Add support for VGA MMIO and =
I/O port access");

"Expose VGA address spaces for device"

> +    object_class_property_set_description(klass, /* 2.12 */
> +                                          "display",
> +                                          "Add display support");

"Enable display support for device, ex. vGPU"

> +    object_class_property_set_description(klass, /* 3.2 */
> +                                          "xres",
> +                                          "Set X display resolution the =
vgpu should use");

Maybe capitalize for consistency, vGPU.

> +    object_class_property_set_description(klass, /* 3.2 */
> +                                          "yres",
> +                                          "Set Y display resolution the =
vgpu should use");
> +
> +    /*
> +     * IGD
> +     */
> +
> +    object_class_property_set_description(klass, /* 2.7 */
> +                                          "x-igd-opregion",
> +                                          "Add IGD OpRegion support for =
(headless system)");

[Cc Tomita and Corvin have more recent understanding of IGD options]

Not necessarily for headless systems, unless others have better
suggestions, maybe just "Expose host IGD OpRegion table to guest".

> +    object_class_property_set_description(klass, /* 2.7 (See c4c45e943e5=
1) */
> +                                          "x-igd-gms",
> +                                          "Add Intel graphics legacy mod=
e device assignment support. "
> +                                          "Assign 00:02.0 from the host =
to 00:02.0 in the VM");

Not really.  Tomita added a useful comment and commit log in
37f05a59e869.  Perhaps:

"Override DVMT Pre-Allocated value for IGD stolen memory. (32MiB units)"

> +
> +    /*
> +     * NVIDIA
> +     */
> +    object_class_property_set_description(klass, /* 2.12 */
> +                                          "x-no-geforce-quirks",
> +                                          "Disable GeForce quirks (for N=
VIDIA Quadro/GRID/Tesla). Improves performance");
> +    object_class_property_set_description(klass, /* 3.0 */
> +                                          "x-no-kvm-ioeventfd",
> +                                          "Disable ioeventfd quirk (NVID=
IA)");
> +    object_class_property_set_description(klass, /* 3.0 */
> +                                          "x-no-vfio-ioeventfd",
> +                                          "Enable ioeventfd quirks to be=
 handled by VFIO directly. Improves performance");

The above two should be under debugging, they're only used by NVIDIA
quirks but they exist for the purpose of validating behavior with and
without.  The first disables registering an ioeventfd with KVM and the
latter disables directly "wiring" it through to vfio.  Maybe
(respectively):

"Disable registration of ioeventfds with KVM"

"Disable linking of KVM ioeventfds to VFIO ioeventfds"

NB. setting the latter does not improve performance.

> +    object_class_property_set_description(klass, /* 2.11 */
> +                                          "x-nv-gpudirect-clique",
> +                                          "Add NVIDIA GPUDirect Cliques =
support");

"Add NVIDIA GPUDirect capability indicating P2P DMA clique for device. (0~1=
5)"

(maybe this is already specified as a uint4 given the PropertyInfo?)

> +
> +    /*
> +     * Migration support
> +     */
> +    object_class_property_set_description(klass, /* 5.2 */
> +                                          "x-pre-copy-dirty-page-trackin=
g",
> +                                          "Disable dirty pages tracking =
during iterative phase");
> +    object_class_property_set_description(klass, /* 9.1 */
> +                                          "x-device-dirty-page-tracking",
> +                                          "Disable device dirty page tra=
cking and use container-based dirty page tracking");

These are really debug as well, right?  They just happen to be
migration related debug.

> +    object_class_property_set_description(klass, /* 5.2, 8.0 non-experim=
etal */
> +                                          "enable-migration",
> +                                          "Enale device migration. Also =
requires a host VFIO PCI variant "
> +                                          "driver with migration support=
 enabled");
> +    object_class_property_set_description(klass, /* 9.1 */
> +                                          "migration-events",
> +                                          "Emit VFIO migration QAPI even=
t when a VFIO device changes its migration "
> +                                          "state. For management applica=
tions");
> +    object_class_property_set_description(klass, /* 9.1 */
> +                                          "skip-vsc-check",
> +                                          "Skip config space check for V=
endor Specific Capability. Useful for "
> +                                          "NVIDIA vGPU driver migration"=
);

The vsc check is really for debug too since it's enabled by default and
mostly only exists as a visible option for manipulation by the machine
type.

> +
> +    /*
> +     * debug, tracing
> +     */
> +    object_class_property_set_description(klass, /* 2.4 and 2.5 */
> +                                          "x-no-mmap",
> +                                          "Disable MMAP for device. Allo=
ws to trace MMIO accesses");
> +    object_class_property_set_description(klass, /* 2.5 */
> +                                          "x-no-kvm-intx",
> +                                          "Bypass INTx interrupts. Allow=
s interrupt tracing");

"Disable direct VFIO->KVM INTx injection. Allows to trace INTx interrupts"

s/INTx/MSI/
s/INTx/MSIx/

for the next.

> +    object_class_property_set_description(klass, /* 2.5 */
> +                                          "x-no-kvm-msi",
> +                                          "Bypass MSI interrupts. Allows=
 interrupt tracing");
> +    object_class_property_set_description(klass, /* 2.5 */
> +                                          "x-no-kvm-msix",
> +                                          "Bypass MSIx interrupts. Allow=
s interrupt tracing");
> +    object_class_property_set_description(klass, /* 2.5 */
> +                                          "x-pci-vendor-id",
> +                                          "Set emulated PCI Vendor ID. A=
llows testing quirks");
> +    object_class_property_set_description(klass, /* 2.5 */
> +                                          "x-pci-device-id",
> +                                          "Set emulated PCI device ID. A=
llows testing quirks");

"Override PCI Vendor ID with provided value"

s/Vendor/Device/

There are also "sub" versions of these for subsystem Vendor and Device
IDs.

None of these are really for quirks, they're more for making devices
appear as other devices.  For reasons.

> +
> +    /*
> +     * other
> +     */
> +    object_class_property_set_description(klass, /* 8.1 */
> +                                          "vf-token",
> +                                          "Add support for VF token amon=
g PF and VFs (Linux 5.7+)");

"Specify UUID VF token.  Required for VF when PF is owned by another VFIO d=
river"

> +    object_class_property_set_description(klass, /* 1.3 */
> +                                          "x-intx-mmap-timeout-ms",
> +                                          "Timeout value in milliseconds=
 to re-enable BAR mapping when under "
> +                                          "INTx interrupts. Improves per=
formance");

Changes performance perhaps.  This should also be under debug.

"When EOI is not provided by KVM/QEMU, wait time to re-enable device direct=
 access after INTx"

> +    object_class_property_set_description(klass, /* 2.3 */
> +                                          "x-req",
> +                                          "Add device request notificati=
on support (Linux 4.0+)");

Also debug.

"Disable device request notification support"

> +    object_class_property_set_description(klass, /* 3.1 */
> +                                          "x-balloon-allowed",
> +                                          "Allow devices to opt-in for b=
allooning");

Debug.

"Override allowing ballooning with device. (DANGER)"

> +    object_class_property_set_description(klass, /* 2.5 */
> +                                          "x-pci-sub-vendor-id",
> +                                          "Set emulated PCI Sub-vendor I=
D");
> +    object_class_property_set_description(klass, /* 2.5 */
> +                                          "x-pci-sub-device-id",
> +                                          "Set emulated PCI Sub-device I=
D");

Ah, here they are.  Grouping with non-subsystem would make sense to me.

> +    object_class_property_set_description(klass, /* 2.12 */
> +                                          "x-msix-relocation",
> +                                          "Allow relocating MSI-X MMIO o=
n systems which page size is larger "
> +                                          "than the PCI spec recommendat=
ion. Mostly for sPAPR");

Yes, we added it because of systems with >4K pages, but there do exist
devices that do not follow the PCI spec recommendation and place
non-MSI related registers too close the vector table and pba.

"Specify MSI-X MMIO relocation to the end of specified existing BAR or
new BAR to avoid virtualization overhead due to adjacent device
registers"

> +#ifdef CONFIG_IOMMUFD
> +    object_class_property_set_description(klass, /* 9.0 */
> +                                          "iommufd",
> +                                          "Set host IOMMUFD backend devi=
ce ");
> +#endif
>  }
> =20
>  static const TypeInfo vfio_pci_dev_info =3D {
> @@ -3461,6 +3588,13 @@ static void vfio_pci_nohotplug_dev_class_init(Obje=
ctClass *klass, void *data)
> =20
>      device_class_set_props(dc, vfio_pci_dev_nohotplug_properties);
>      dc->hotpluggable =3D false;
> +    object_class_property_set_description(klass, /* 3.1 */
> +                                          "ramfb",
> +                                          "Add ramfb support");

"Enable ramfb to provide pre-boot graphics for devices enabling display opt=
ion"

> +    object_class_property_set_description(klass, /* 8.2 */
> +                                          "x-ramfb-migrate",
> +                                          "Add ramfb migration support");

Debug.

"Override default migration support for ramfb support"

> +
>  }
> =20
>  static const TypeInfo vfio_pci_nohotplug_dev_info =3D {
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index 1070a2113a17edb9ebafb5066e51ee2bc52a767d..8e646e543692221e86b16fecd=
8bf40316f064a7d 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -674,6 +674,29 @@ static void vfio_platform_class_init(ObjectClass *kl=
ass, void *data)
>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>      /* Supported by TYPE_VIRT_MACHINE */
>      dc->user_creatable =3D true;
> +
> +    object_class_property_set_description(klass, /* 2.4 */
> +                                          "host",
> +                                          "Host device name of assigned =
device");
> +    object_class_property_set_description(klass, /* 2.6 */
> +                                          "sysfsdev",
> +                                          "Host sysfs path of assigned d=
evice");
> +    object_class_property_set_description(klass, /* 2.4 and 2.5 */
> +                                          "x-no-mmap",
> +                                          "Disable MMAP for device. Allo=
ws to trace MMIO accesses");
> +    object_class_property_set_description(klass, /* 2.4 */
> +                                          "mmap-timeout-ms",
> +                                          "Timeout value in milliseconds=
 to re-enable BAR mapping");

This is essentially the same as the vfio-pci INTx version, only used
when we don't have a mechanism for EOI.

> +    object_class_property_set_description(klass, /* 2.4 */
> +                                          "x-irqfd",
> +                                          "Use irqfd for IRQ handling");

Debug.  Allow disabling irqfd support.

Maybe rather than trying to group debug options together they should
just be explicitly labeled in the description, ex. "[DEBUG]"

Thanks,
Alex

> +
> +#ifdef CONFIG_IOMMUFD
> +    object_class_property_set_description(klass, /* 9.0 */
> +                                          "iommufd",
> +                                          "Set host IOMMUFD backend devi=
ce ");
> +#endif
> +
>  }
> =20
>  static const TypeInfo vfio_platform_dev_info =3D {


