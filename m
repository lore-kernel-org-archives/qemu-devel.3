Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECCBC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 22:50:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqK2G-0003hu-Nr; Thu, 06 Mar 2025 17:49:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tqK2F-0003hf-KD
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 17:49:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tqK2D-0005Ot-Eg
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 17:49:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741301379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HN/Ndc54AhXkD6PQayckWD4TtCKeI5EtehR1QL3am2w=;
 b=ZAvcfURxWiCVi6CnVznz7s9L89iVA2BPqjvXVRo+nL/ixqf0pZUbdX0zZcsJOrNP0AzbtW
 9j57lPaOMxWTHQfOeg/FYy1bDrJoh1ABlf5khcIr/8ajj8ttR+ym2fbT8X8tHC7erEfHGy
 t1YQEAzmKNxlZ3VMUtTXNngQzEJivuM=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-3SgxdFpkOAS0ie_uhWJTRw-1; Thu, 06 Mar 2025 17:49:28 -0500
X-MC-Unique: 3SgxdFpkOAS0ie_uhWJTRw-1
X-Mimecast-MFC-AGG-ID: 3SgxdFpkOAS0ie_uhWJTRw_1741301368
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-8560c8e8f29so21213539f.3
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 14:49:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741301368; x=1741906168;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HN/Ndc54AhXkD6PQayckWD4TtCKeI5EtehR1QL3am2w=;
 b=ELBrRxJM47sfBSJOGcahXDjOU/xbaG79RlrSyv/QcGen/xQs/wE8gqro6nkOWP6Z48
 4ZpT9O+vKnTCtvSIS8yFUb07ATO21JrfDyO/CnVoVFtwYcZ+swzoDfsQYQWbzFoidZIQ
 zvMMBSGM63mbQ/iedUYhq4/jja9MlXs8x/CBNtcKPfX0o6xYAGj3D6ETUGeXWHspTO5F
 3JfaQUhY1dewMBfR6Ahss3xq+SmX/320h3gTf1qQud6A3IUyeRHAyeUg2VDhXOxJCitr
 UtYXJ3e2DuGSxlLBFxt5hlZypPWXB53LWVGUl++BN8+2ayGc2A0o7tucBvgt+INf7NR3
 POBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNFQbI83pGvMOcB7VIRvPtAVFek4hktNBOdzVAgTpcPUXlNipMmJ5KtnE4CPAyUX+4I+Mqw9/0XRPp@nongnu.org
X-Gm-Message-State: AOJu0YxAWgs9nCivaP/59e9KtVYVmMuSZUeo8CLwNov7dxWu5ueOf2Fm
 ecxA7rCI89dgspWqfKonPcq5arAYbz/jPVKpcLlkXakyAmu9YzW5GhOsfQaVWI19HHnLBAK/E01
 K8v03bPzXo3+m+/ilBqEmKA45O+vpnDbxAIOTMUzAFjD3mVz0qvB0
X-Gm-Gg: ASbGnctN6FvadjTUjDw1BbC6V8zEhG9wLB4i1dsugThVyz1QdAmAqIEOatfCL5rJKfR
 1wUfOai0D9J0+qQvfOxI4UQ5w+Jq6Ux1VQRkGEVIMqvBJIUd2LBCZQc53VwGnZIZibwWMgSt0TQ
 dOsOf1ze3FPWce+KjgBYmQCrFQXJ+VFCgE4shPXKIK6XDKA9pfcLZGaZHOFbuQ5H0cC1QauHS/z
 aUueUw10rwGM6EqTM1lZyncuXjCpp0nn6iv5TOZNkR8uIvvXrPWMDG2AaOYNogyubCa4W1xlEjk
 pcREorpAJzEsQOuGFfY=
X-Received: by 2002:a05:6e02:1949:b0:3d3:d4f0:2710 with SMTP id
 e9e14a558f8ab-3d443ef18c4mr128445ab.1.1741301367701; 
 Thu, 06 Mar 2025 14:49:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnb9UNztN2oHvmqdpQjp4rAXA79KfMj6O28hjX3TQCNZunxK9PcRxHl1dovFehpw7m1fZfTQ==
X-Received: by 2002:a05:6e02:1949:b0:3d3:d4f0:2710 with SMTP id
 e9e14a558f8ab-3d443ef18c4mr128395ab.1.1741301367288; 
 Thu, 06 Mar 2025 14:49:27 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f209e155fasm584871173.34.2025.03.06.14.49.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 14:49:26 -0800 (PST)
Date: Thu, 6 Mar 2025 15:49:20 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Corvin =?UTF-8?B?S8O2aG5l?=
 <corvin.koehne@gmail.com>
Subject: Re: [PATCH v3 07/10] vfio/igd: Decouple common quirks from legacy mode
Message-ID: <20250306154920.0e1936eb.alex.williamson@redhat.com>
In-Reply-To: <20250306180131.32970-8-tomitamoeko@gmail.com>
References: <20250306180131.32970-1-tomitamoeko@gmail.com>
 <20250306180131.32970-8-tomitamoeko@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri,  7 Mar 2025 02:01:27 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> So far, IGD-specific quirks all require enabling legacy mode, which is
> toggled by assigning IGD to 00:02.0. However, some quirks, like the BDSM
> and GGC register quirks, should be applied to all supported IGD devices.
> A new config option, x-igd-legacy-mode=[on|off|auto], is introduced to
> control the legacy mode only quirks. The default value is "auto", which
> keeps current behavior that enables legacy mode implicitly and continues
> on error when all following conditions are met.
> * Machine type is i440fx
> * IGD device is at guest BDF 00:02.0
> 
> If any one of the conditions above is not met, the default behavior is
> equivalent to "off", QEMU will fail immediately if any error occurs.
> 
> Users can also use "on" to force enabling legacy mode. It checks if all
> the conditions above are met and set up legacy mode. QEMU will also fail
> immediately on error in this case.
> 
> Additionally, the hotplug check in legacy mode is removed as hotplugging
> IGD device is never supported, and it will be checked when enabling the
> OpRegion quirk.
> 
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
>  hw/vfio/igd.c | 127 +++++++++++++++++++++++++++++---------------------
>  hw/vfio/pci.c |   2 +
>  hw/vfio/pci.h |   1 +
>  3 files changed, 77 insertions(+), 53 deletions(-)
> 
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index f5e19f1241..ac096e2eb5 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -15,6 +15,7 @@
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "qapi/qmp/qerror.h"
> +#include "hw/boards.h"
>  #include "hw/hw.h"
>  #include "hw/nvram/fw_cfg.h"
>  #include "pci.h"
> @@ -432,9 +433,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>       * bus address.
>       */
>      if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
> -        !vfio_is_vga(vdev) || nr != 0 ||
> -        &vdev->pdev != pci_find_device(pci_device_root_bus(&vdev->pdev),
> -                                       0, PCI_DEVFN(0x2, 0))) {
> +        !vfio_is_vga(vdev) || nr != 0) {
>          return;
>      }
>  
> @@ -482,14 +481,13 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>      QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, bdsm_quirk, next);
>  }
>  
> -bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
> -                                 Error **errp G_GNUC_UNUSED)
> +bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>  {
> -    g_autofree struct vfio_region_info *rom = NULL;
>      int ret, gen;
>      uint64_t gms_size;
>      uint64_t *bdsm_size;
>      uint32_t gmch;
> +    bool legacy_mode_enabled = false;
>      Error *err = NULL;
>  
>      /*
> @@ -498,9 +496,7 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
>       * PCI bus address.
>       */
>      if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
> -        !vfio_is_vga(vdev) ||
> -        &vdev->pdev != pci_find_device(pci_device_root_bus(&vdev->pdev),
> -                                       0, PCI_DEVFN(0x2, 0))) {
> +        !vfio_is_vga(vdev)) {
>          return true;
>      }
>  
> @@ -516,56 +512,67 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
>          return true;
>      }
>  
> -    /*
> -     * Most of what we're doing here is to enable the ROM to run, so if
> -     * there's no ROM, there's no point in setting up this quirk.
> -     * NB. We only seem to get BIOS ROMs, so a UEFI VM would need CSM support.
> -     */
> -    ret = vfio_get_region_info(&vdev->vbasedev,
> -                               VFIO_PCI_ROM_REGION_INDEX, &rom);
> -    if ((ret || !rom->size) && !vdev->pdev.romfile) {
> -        error_report("IGD device %s has no ROM, legacy mode disabled",
> -                     vdev->vbasedev.name);
> -        return true;
> -    }
> -
> -    /*
> -     * Ignore the hotplug corner case, mark the ROM failed, we can't
> -     * create the devices we need for legacy mode in the hotplug scenario.
> -     */
> -    if (vdev->pdev.qdev.hotplugged) {
> -        error_report("IGD device %s hotplugged, ROM disabled, "
> -                     "legacy mode disabled", vdev->vbasedev.name);
> -        vdev->rom_read_failed = true;
> -        return true;
> -    }
> -
>      gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, 4);
>  
>      /*
> -     * If IGD VGA Disable is clear (expected) and VGA is not already enabled,
> -     * try to enable it.  Probably shouldn't be using legacy mode without VGA,
> -     * but also no point in us enabling VGA if disabled in hardware.
> +     * For backward compatibilty, enable legacy mode when
> +     * - Machine type is i440fx (pc_piix)
> +     * - IGD device is at guest BDF 00:02.0
> +     * - Not manually disabled by x-igd-legacy-mode=off
>       */
> -    if (!(gmch & 0x2) && !vdev->vga && !vfio_populate_vga(vdev, &err)) {
> -        error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> -        error_report("IGD device %s failed to enable VGA access, "
> -                     "legacy mode disabled", vdev->vbasedev.name);
> -        return true;
> -    }
> +    if ((vdev->igd_legacy_mode != ON_OFF_AUTO_OFF) &&
> +        !strcmp(MACHINE_GET_CLASS(qdev_get_machine())->family, "pc_piix") &&
> +        (&vdev->pdev == pci_find_device(pci_device_root_bus(&vdev->pdev),
> +        0, PCI_DEVFN(0x2, 0)))) {
> +        /*
> +         * IGD legacy mode requires:
> +         * - VBIOS in ROM BAR or file
> +         * - VGA IO/MMIO ranges are claimed by IGD
> +         * - OpRegion
> +         * - Same LPC bridge and Host bridge VID/DID/SVID/SSID as host
> +         */
> +        g_autofree struct vfio_region_info *rom = NULL;
> +
> +        legacy_mode_enabled = true;
> +        warn_report("IGD legacy mode enabled, "
> +                    "use x-igd-legacy-mode=off to disable it if unwanted.");

info_report() maybe?  These aren't great choices for a user, get a
warning for using the intended mode or silence that warning by
requiring experimental options that taint the VM relative to libvirt.

Also, why do we list all the requirements then only test a few of them
before declaring we're using legacy mode?  It seems like the above
should be moved to the end of this branch.

Given the pending release deadline, maybe these aren't blockers, but
let's follow-up with something that assumes the user wants something
other than what they're doing.  Thanks,

Alex

> +
> +        /*
> +         * Most of what we're doing here is to enable the ROM to run, so if
> +         * there's no ROM, there's no point in setting up this quirk.
> +         * NB. We only seem to get BIOS ROMs, so UEFI VM would need CSM support.
> +         */
> +        ret = vfio_get_region_info(&vdev->vbasedev,
> +                                   VFIO_PCI_ROM_REGION_INDEX, &rom);
> +        if ((ret || !rom->size) && !vdev->pdev.romfile) {
> +            error_setg(&err, "Device has no ROM");
> +            goto error;
> +        }
>  
> -    /* Setup OpRegion access */
> -    if (!vfio_pci_igd_setup_opregion(vdev, &err)) {
> -        error_append_hint(&err, "IGD legacy mode disabled\n");
> -        error_report_err(err);
> -        return true;
> -    }
> +        /*
> +         * If IGD VGA Disable is clear (expected) and VGA is not already
> +         * enabled, try to enable it. Probably shouldn't be using legacy mode
> +         * without VGA, but also no point in us enabling VGA if disabled in
> +         * hardware.
> +         */
> +        if (!(gmch & 0x2) && !vdev->vga && !vfio_populate_vga(vdev, &err)) {
> +            error_setg(&err, "Unable to enable VGA access");
> +            goto error;
> +        }
>  
> -    /* Setup LPC bridge / Host bridge PCI IDs */
> -    if (!vfio_pci_igd_setup_lpc_bridge(vdev, &err)) {
> -        error_append_hint(&err, "IGD legacy mode disabled\n");
> -        error_report_err(err);
> -        return true;
> +        /* Setup OpRegion access */
> +        if (!vfio_pci_igd_setup_opregion(vdev, &err)) {
> +            goto error;
> +        }
> +
> +        /* Setup LPC bridge / Host bridge PCI IDs */
> +        if (!vfio_pci_igd_setup_lpc_bridge(vdev, &err)) {
> +            goto error;
> +        }
> +    } else if (vdev->igd_legacy_mode == ON_OFF_AUTO_ON) {
> +        error_setg(&err,
> +                   "Machine is not i440fx or assigned BDF is not 00:02.0");
> +        goto error;
>      }
>  
>      /*
> @@ -627,4 +634,18 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
>      trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name, (gms_size / MiB));
>  
>      return true;
> +
> +error:
> +    /*
> +     * When legacy mode is implicity enabled, continue on error,
> +     * to keep compatibility
> +     */
> +    if (legacy_mode_enabled && (vdev->igd_legacy_mode == ON_OFF_AUTO_AUTO)) {
> +        error_report_err(err);
> +        error_report("IGD legacy mode disabled");
> +        return true;
> +    }
> +
> +    error_propagate(errp, err);
> +    return false;
>  }
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index a58d555934..d5ff8c1ea8 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3363,6 +3363,8 @@ static const Property vfio_pci_dev_properties[] = {
>                      VFIO_FEATURE_ENABLE_REQ_BIT, true),
>      DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
>                      VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
> +    DEFINE_PROP_ON_OFF_AUTO("x-igd-legacy-mode", VFIOPCIDevice,
> +                            igd_legacy_mode, ON_OFF_AUTO_AUTO),
>      DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
>                              vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
>      DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 2e81f9eb19..aa67ceb346 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -158,6 +158,7 @@ struct VFIOPCIDevice {
>      uint32_t display_xres;
>      uint32_t display_yres;
>      int32_t bootindex;
> +    OnOffAuto igd_legacy_mode;
>      uint32_t igd_gms;
>      OffAutoPCIBAR msix_relo;
>      uint8_t pm_cap;


