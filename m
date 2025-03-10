Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A8EC28B30
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 08:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trY6c-00065z-UC; Mon, 10 Mar 2025 04:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1trY6a-00065d-AR
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 04:03:20 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1trY6W-0000eZ-Lq
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 04:03:20 -0400
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-224100e9a5cso69981725ad.2
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 01:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741593794; x=1742198594; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zYqWeoTf/TKPCfsiXfd/y5tHc55L3g6R544wsr2f890=;
 b=QhTb1j/Uk/W5ksn6VwIqAuZRw9os9G/Pd+M670Uvl4xhHu5q2QYMZbK2ABpD21d3uV
 0LklSKQmzbu/tmKQckFN709kf0YZCtiEegm3m4rycnnVfY47snTfpQ46AHleBIEsyqdb
 jDvloQqfaoXFWQMrMLlI2ex9/cgzNC3wklAAnGRRAL93YBK19sUqLO2/YfJs8xiOiQCo
 b/d0OJfkAwosFKstyJmDz7FY5Zpj/bs2omBZ8Sa9pluvsBPpT0YuZDeZp7+IIuRAoqSp
 b72LhsbyIHF/ZXw/CUf0rbwiV9VfKPLA5HakhyikAHLAmBslpkHkgOBxt2o0VZjQYqNv
 X0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741593794; x=1742198594;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zYqWeoTf/TKPCfsiXfd/y5tHc55L3g6R544wsr2f890=;
 b=cu32fYscJ3SgsOaWfncQfJiKtvEOC4uwHfkmPee+xB28T2bLZ1BRlIGlgSJx1dRaQw
 ye57Er4sIANgOm4tAT/nWFdqinas2UqdU5IsYVa8ctbfCcFTM6wTKDbIMD+liF53ULOY
 jUOfxH23SkWGA8DkVgHGCwQh9zCCzh6uHzchnlMN4+TARF0pY5GKubIdhab0lnyRThvw
 lhsgmmUu45Xnlrr4mw6EqERX35q7drasBUyQmBwA1LzDdLPGJcvPTKpM+CCIPW0S66Vt
 Uj62lq7x/ICuPStIZon8J3nNc19wU2NmVRbxQ1QShH/poI1CnHf6Dj+AfX/rYpMdDiXj
 kryA==
X-Gm-Message-State: AOJu0YxqeHCFyBTYY5ZqgnTvgrFOLIzHigJNS1/u2GuGDDTVK41mMUrt
 UfCI8bX7NlfHOJAEIIxpJX4H1Ziz8I7N7LucdfqStesjL/tjRmmwtj046FrdSdpF
X-Gm-Gg: ASbGncusuzpZGpoNNN22a0MGQ4qx7LsD8LS6Y0FPyW/6OqNHeG1zqfta1GJthrmerGz
 +nuUQJ0SwtqHAa1HBs3iSxsisWNkgDXNPxbOghWm6ev4BgFsH4QShaP7M1iu6VEWLxbk9n7BMVd
 K9H7S+97xCR6tWK2ejYB0NmgwK2ECL8RgyRRNcskF3GRFLDzYbDajQMgQLdM/BuuTHFGB/0gPCJ
 s4m4kYfoz0Vqh5d2vt0096Bd6cHy+uwlXwzfoS2RMXDEZnDe8GN7fGn/1yMDC+xa9Oa/GhePRH9
 R1E3YoeTUbU8/dNda4lj2cVb1R34aReYNMiBsU3RUlPLpK3iFuoKxmh/aobDbCoMH/KJMS4=
X-Google-Smtp-Source: AGHT+IGt6sXFHNYL8sZtK88TVdNlc0on7bwgv7YCXZ+F7rOUoo3NUBaLys8tuaAN448rSOX+FquTNQ==
X-Received: by 2002:a05:6a00:23cb:b0:736:55ec:ea8b with SMTP id
 d2e1a72fcca58-736e1b3e670mr1969090b3a.24.1741593793542; 
 Mon, 10 Mar 2025 01:03:13 -0700 (PDT)
Received: from [172.20.10.3] ([58.247.23.80]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73698538ecbsm7842290b3a.176.2025.03.10.01.03.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 01:03:13 -0700 (PDT)
Message-ID: <9932832b-ae57-417b-8b26-57ef08d827a3@gmail.com>
Date: Mon, 10 Mar 2025 16:03:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] vfio/igd: Decouple common quirks from legacy mode
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Corvin_K=C3=B6hne?=
 <corvin.koehne@gmail.com>
References: <20250306180131.32970-1-tomitamoeko@gmail.com>
 <20250306180131.32970-8-tomitamoeko@gmail.com>
 <20250306154920.0e1936eb.alex.williamson@redhat.com>
 <46b7c8ff-06b3-4e01-a00d-1a388a0bf6a3@gmail.com>
 <f394edb5-f8f0-4b5f-ab5f-e40c1e8c9f78@redhat.com>
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <f394edb5-f8f0-4b5f-ab5f-e40c1e8c9f78@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x641.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/3/10 15:13, Cédric Le Goater wrote:
> Tomita,
> 
> On 3/7/25 19:37, Tomita Moeko wrote:
>> On 2025/3/7 6:49, Alex Williamson wrote:
>>> On Fri,  7 Mar 2025 02:01:27 +0800
>>> Tomita Moeko <tomitamoeko@gmail.com> wrote:
>>>
>>>> So far, IGD-specific quirks all require enabling legacy mode, which is
>>>> toggled by assigning IGD to 00:02.0. However, some quirks, like the BDSM
>>>> and GGC register quirks, should be applied to all supported IGD devices.
>>>> A new config option, x-igd-legacy-mode=[on|off|auto], is introduced to
>>>> control the legacy mode only quirks. The default value is "auto", which
>>>> keeps current behavior that enables legacy mode implicitly and continues
>>>> on error when all following conditions are met.
>>>> * Machine type is i440fx
>>>> * IGD device is at guest BDF 00:02.0
>>>>
>>>> If any one of the conditions above is not met, the default behavior is
>>>> equivalent to "off", QEMU will fail immediately if any error occurs.
>>>>
>>>> Users can also use "on" to force enabling legacy mode. It checks if all
>>>> the conditions above are met and set up legacy mode. QEMU will also fail
>>>> immediately on error in this case.
>>>>
>>>> Additionally, the hotplug check in legacy mode is removed as hotplugging
>>>> IGD device is never supported, and it will be checked when enabling the
>>>> OpRegion quirk.
>>>>
>>>> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
>>>> ---
>>>>   hw/vfio/igd.c | 127 +++++++++++++++++++++++++++++---------------------
>>>>   hw/vfio/pci.c |   2 +
>>>>   hw/vfio/pci.h |   1 +
>>>>   3 files changed, 77 insertions(+), 53 deletions(-)
>>>>
>>>> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
>>>> index f5e19f1241..ac096e2eb5 100644
>>>> --- a/hw/vfio/igd.c
>>>> +++ b/hw/vfio/igd.c
>>>> @@ -15,6 +15,7 @@
>>>>   #include "qemu/error-report.h"
>>>>   #include "qapi/error.h"
>>>>   #include "qapi/qmp/qerror.h"
>>>> +#include "hw/boards.h"
>>>>   #include "hw/hw.h"
>>>>   #include "hw/nvram/fw_cfg.h"
>>>>   #include "pci.h"
>>>> @@ -432,9 +433,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>>>>        * bus address.
>>>>        */
>>>>       if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
>>>> -        !vfio_is_vga(vdev) || nr != 0 ||
>>>> -        &vdev->pdev != pci_find_device(pci_device_root_bus(&vdev->pdev),
>>>> -                                       0, PCI_DEVFN(0x2, 0))) {
>>>> +        !vfio_is_vga(vdev) || nr != 0) {
>>>>           return;
>>>>       }
>>>>   @@ -482,14 +481,13 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>>>>       QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, bdsm_quirk, next);
>>>>   }
>>>>   -bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
>>>> -                                 Error **errp G_GNUC_UNUSED)
>>>> +bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>>>>   {
>>>> -    g_autofree struct vfio_region_info *rom = NULL;
>>>>       int ret, gen;
>>>>       uint64_t gms_size;
>>>>       uint64_t *bdsm_size;
>>>>       uint32_t gmch;
>>>> +    bool legacy_mode_enabled = false;
>>>>       Error *err = NULL;
>>>>         /*
>>>> @@ -498,9 +496,7 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
>>>>        * PCI bus address.
>>>>        */
>>>>       if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
>>>> -        !vfio_is_vga(vdev) ||
>>>> -        &vdev->pdev != pci_find_device(pci_device_root_bus(&vdev->pdev),
>>>> -                                       0, PCI_DEVFN(0x2, 0))) {
>>>> +        !vfio_is_vga(vdev)) {
>>>>           return true;
>>>>       }
>>>>   @@ -516,56 +512,67 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
>>>>           return true;
>>>>       }
>>>>   -    /*
>>>> -     * Most of what we're doing here is to enable the ROM to run, so if
>>>> -     * there's no ROM, there's no point in setting up this quirk.
>>>> -     * NB. We only seem to get BIOS ROMs, so a UEFI VM would need CSM support.
>>>> -     */
>>>> -    ret = vfio_get_region_info(&vdev->vbasedev,
>>>> -                               VFIO_PCI_ROM_REGION_INDEX, &rom);
>>>> -    if ((ret || !rom->size) && !vdev->pdev.romfile) {
>>>> -        error_report("IGD device %s has no ROM, legacy mode disabled",
>>>> -                     vdev->vbasedev.name);
>>>> -        return true;
>>>> -    }
>>>> -
>>>> -    /*
>>>> -     * Ignore the hotplug corner case, mark the ROM failed, we can't
>>>> -     * create the devices we need for legacy mode in the hotplug scenario.
>>>> -     */
>>>> -    if (vdev->pdev.qdev.hotplugged) {
>>>> -        error_report("IGD device %s hotplugged, ROM disabled, "
>>>> -                     "legacy mode disabled", vdev->vbasedev.name);
>>>> -        vdev->rom_read_failed = true;
>>>> -        return true;
>>>> -    }
>>>> -
>>>>       gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, 4);
>>>>         /*
>>>> -     * If IGD VGA Disable is clear (expected) and VGA is not already enabled,
>>>> -     * try to enable it.  Probably shouldn't be using legacy mode without VGA,
>>>> -     * but also no point in us enabling VGA if disabled in hardware.
>>>> +     * For backward compatibilty, enable legacy mode when
>>>> +     * - Machine type is i440fx (pc_piix)
>>>> +     * - IGD device is at guest BDF 00:02.0
>>>> +     * - Not manually disabled by x-igd-legacy-mode=off
>>>>        */
>>>> -    if (!(gmch & 0x2) && !vdev->vga && !vfio_populate_vga(vdev, &err)) {
>>>> -        error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>>>> -        error_report("IGD device %s failed to enable VGA access, "
>>>> -                     "legacy mode disabled", vdev->vbasedev.name);
>>>> -        return true;
>>>> -    }
>>>> +    if ((vdev->igd_legacy_mode != ON_OFF_AUTO_OFF) &&
>>>> +        !strcmp(MACHINE_GET_CLASS(qdev_get_machine())->family, "pc_piix") &&
>>>> +        (&vdev->pdev == pci_find_device(pci_device_root_bus(&vdev->pdev),
>>>> +        0, PCI_DEVFN(0x2, 0)))) {
>>>> +        /*
>>>> +         * IGD legacy mode requires:
>>>> +         * - VBIOS in ROM BAR or file
>>>> +         * - VGA IO/MMIO ranges are claimed by IGD
>>>> +         * - OpRegion
>>>> +         * - Same LPC bridge and Host bridge VID/DID/SVID/SSID as host
>>>> +         */
>>>> +        g_autofree struct vfio_region_info *rom = NULL;
>>>> +
>>>> +        legacy_mode_enabled = true;
>>>> +        warn_report("IGD legacy mode enabled, "
>>>> +                    "use x-igd-legacy-mode=off to disable it if unwanted.");
>>>
>>> info_report() maybe?  These aren't great choices for a user, get a
>>> warning for using the intended mode or silence that warning by
>>> requiring experimental options that taint the VM relative to libvirt.
>>
>> Got it. If possible, please help change this to info_report when
>> applying.
> 
> done.
> 
> 
>>
>>> Also, why do we list all the requirements then only test a few of them
>>> before declaring we're using legacy mode?  It seems like the above
>>> should be moved to the end of this branch.
>>
>> Having i440fx machine type and BDF 00:02.0 are the must-have condition
>> for considering enabling legacy mode, while others are the requirements
>> for legacy mode itself. In this verison, legacy mode is equivalent to
>>      romfile=oprom.bin,x-vga=on,x-igd-opregion=on,x-igd-lpc=on
>>
>> BDF being 00:02.0 is a requirement of VBIOS, and hacking the LPC DID
>> currently only works on i440fx. Though for Q35, we can overwrite the
>> existing ICH9 LPC DID to make IGD driver happy, it won't break ACPI PM
>> in recent guest kernel, and maybe later making it an option for Q35,
>> its still too risky to make it an implicit default. That's why I prefer
>> to check the must-have condtions first, then check other requirements
>> when setting up them.
>>
>> Setting the `legacy_mode_enabled` flag here is for error handling, as
>> we have to keep the old "continue on error" behavior for legacy mode.
> 
> A ducomentation update is welcome ! Could you do that before hard-freeze ?
> 
> Thanks,
> 
> C.
> 

Let me try to make it before Mar 18.

Thanks,
Moeko

>>> Given the pending release deadline, maybe these aren't blockers, but
>>> let's follow-up with something that assumes the user wants something
>>> other than what they're doing.  Thanks,
>>>
>>> Alex
>>>
>>
>> Sure.
>>
>> Moeko
>>  
>>>> +
>>>> +        /*
>>>> +         * Most of what we're doing here is to enable the ROM to run, so if
>>>> +         * there's no ROM, there's no point in setting up this quirk.
>>>> +         * NB. We only seem to get BIOS ROMs, so UEFI VM would need CSM support.
>>>> +         */
>>>> +        ret = vfio_get_region_info(&vdev->vbasedev,
>>>> +                                   VFIO_PCI_ROM_REGION_INDEX, &rom);
>>>> +        if ((ret || !rom->size) && !vdev->pdev.romfile) {
>>>> +            error_setg(&err, "Device has no ROM");
>>>> +            goto error;
>>>> +        }
>>>>   -    /* Setup OpRegion access */
>>>> -    if (!vfio_pci_igd_setup_opregion(vdev, &err)) {
>>>> -        error_append_hint(&err, "IGD legacy mode disabled\n");
>>>> -        error_report_err(err);
>>>> -        return true;
>>>> -    }
>>>> +        /*
>>>> +         * If IGD VGA Disable is clear (expected) and VGA is not already
>>>> +         * enabled, try to enable it. Probably shouldn't be using legacy mode
>>>> +         * without VGA, but also no point in us enabling VGA if disabled in
>>>> +         * hardware.
>>>> +         */
>>>> +        if (!(gmch & 0x2) && !vdev->vga && !vfio_populate_vga(vdev, &err)) {
>>>> +            error_setg(&err, "Unable to enable VGA access");
>>>> +            goto error;
>>>> +        }
>>>>   -    /* Setup LPC bridge / Host bridge PCI IDs */
>>>> -    if (!vfio_pci_igd_setup_lpc_bridge(vdev, &err)) {
>>>> -        error_append_hint(&err, "IGD legacy mode disabled\n");
>>>> -        error_report_err(err);
>>>> -        return true;
>>>> +        /* Setup OpRegion access */
>>>> +        if (!vfio_pci_igd_setup_opregion(vdev, &err)) {
>>>> +            goto error;
>>>> +        }
>>>> +
>>>> +        /* Setup LPC bridge / Host bridge PCI IDs */
>>>> +        if (!vfio_pci_igd_setup_lpc_bridge(vdev, &err)) {
>>>> +            goto error;
>>>> +        }
>>>> +    } else if (vdev->igd_legacy_mode == ON_OFF_AUTO_ON) {
>>>> +        error_setg(&err,
>>>> +                   "Machine is not i440fx or assigned BDF is not 00:02.0");
>>>> +        goto error;
>>>>       }
>>>>         /*
>>>> @@ -627,4 +634,18 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
>>>>       trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name, (gms_size / MiB));
>>>>         return true;
>>>> +
>>>> +error:
>>>> +    /*
>>>> +     * When legacy mode is implicity enabled, continue on error,
>>>> +     * to keep compatibility
>>>> +     */
>>>> +    if (legacy_mode_enabled && (vdev->igd_legacy_mode == ON_OFF_AUTO_AUTO)) {
>>>> +        error_report_err(err);
>>>> +        error_report("IGD legacy mode disabled");
>>>> +        return true;
>>>> +    }
>>>> +
>>>> +    error_propagate(errp, err);
>>>> +    return false;
>>>>   }
>>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>>> index a58d555934..d5ff8c1ea8 100644
>>>> --- a/hw/vfio/pci.c
>>>> +++ b/hw/vfio/pci.c
>>>> @@ -3363,6 +3363,8 @@ static const Property vfio_pci_dev_properties[] = {
>>>>                       VFIO_FEATURE_ENABLE_REQ_BIT, true),
>>>>       DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
>>>>                       VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
>>>> +    DEFINE_PROP_ON_OFF_AUTO("x-igd-legacy-mode", VFIOPCIDevice,
>>>> +                            igd_legacy_mode, ON_OFF_AUTO_AUTO),
>>>>       DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
>>>>                               vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
>>>>       DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
>>>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>>>> index 2e81f9eb19..aa67ceb346 100644
>>>> --- a/hw/vfio/pci.h
>>>> +++ b/hw/vfio/pci.h
>>>> @@ -158,6 +158,7 @@ struct VFIOPCIDevice {
>>>>       uint32_t display_xres;
>>>>       uint32_t display_yres;
>>>>       int32_t bootindex;
>>>> +    OnOffAuto igd_legacy_mode;
>>>>       uint32_t igd_gms;
>>>>       OffAutoPCIBAR msix_relo;
>>>>       uint8_t pm_cap;
>>>
>>
> 


