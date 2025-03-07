Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBEEC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:37:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqcZL-00076R-Pr; Fri, 07 Mar 2025 13:37:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tqcZK-00075u-4B
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:37:10 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tqcZH-0001fm-60
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:37:09 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-223594b3c6dso41345775ad.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 10:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741372624; x=1741977424; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rhFFJkeHQ1AGAYZ+/oiHnftqyefn26O2TFZAERcrCWA=;
 b=DS9zGJ70Yn0zV61mW9tmAFJB4fe9GDFL+CoRdWvah2NqqEsWxI+4DAa3jlA0048Ac4
 L006pQ3EKSm0h00lEVHqMfeVkBqz0uI1Hr7BHvqQxN6J7866QJpF+j+1m1HJmLKZQJ4d
 8NEEhha3dmd6JvJ3hE8Vi2UwRJfGdl7Z/+bLh2nDaOWAEMwVAo/i3k+F1bRboXzeANs+
 aCTnqqrvhAN4MJ0FK8TQDmGKW0mcN5o20JEEH4sXOSuMfHHO0eWWe0WSdTCMb+reV4Z8
 TQFwmBTtlN1an+S5A0zHWg03TJCL9XQIXgGgxkZW4lG5zBQyucetfit25m2ty4vmByCi
 tLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741372624; x=1741977424;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rhFFJkeHQ1AGAYZ+/oiHnftqyefn26O2TFZAERcrCWA=;
 b=T4I1a+icyqITjrzGPyirGaB+3ptcUAyVuIPx83xgxx0DjCdmGrx6Gvn05ihmEwnnFv
 VbtNljGeaQKdo2WwUfXUZiGedD6stth6eB2cBuPVw9PWcYfSipoGHKJ2OIy9Awrdtd4m
 ODfd2Um2sHgI7esvUrEMd4CsoTezO4whgh+pXW4bgu6CumYYAEEcTwnFVPX6XWGINHBo
 1NgxiRSgGWTdabZN3k6UHL4geGl1mHjiZ3MwFcin+heAdq6HtHeKP1467wkj6hcoySZm
 ahJ6mQ2UkJ+YhyIQ7qlDBo9gFt1JjjOR2LQDQVLzHzfH5hsUbibv73hoqGUsDTjKe7TZ
 URJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGoKHbPLGSIajAiyI2mjFdXJOYiw32tV3chHOzlEWr5ZwstBMngid+N0aaRnFKczhrwYQhvxCyYrS/@nongnu.org
X-Gm-Message-State: AOJu0YyA/ewbCRGEYSX1v8X48hHH36BMDTshuHawC3aRIczcH2u9Btev
 bACb5XWg9Dne/JCrr1pfmIPU8j53myNg01fereYPSqGqy0MEoug=
X-Gm-Gg: ASbGncsIQQ+4Fu5lbXjSSxREkGrexKtTgDJhczCSX5na8tv514SQ9uiM9x1dNVU4LLo
 6LDyYZWYm2cumu8Htsn/tUdAOTqbJQRfXeQqMlH20rZ7olI4iAj+SQPuAKbg93EBAYk4THkpzhg
 iGHkP7osddGpfoWGuPxWvlaeS8EdCoeO7ZQkMVf30eggh1RgdlaUB9OJaDYx18UWPKT8AXk32Ye
 EzgUg2LU//cepSqZDlDZlMEzpSnGe8Fuqd/sh/mQ5jSN3ifhN1jNaCHrZXGBoBTeUi+nsy0gG4U
 ORLFzAYoNo4hi5MNA1kST9TKLkHjElMnWRc0Lcme1/DViKWQzsF/ifagbP1AAZe+
X-Google-Smtp-Source: AGHT+IESDRGum//BUXgrQYBfwfIWxzaZ6tl5GMdr0wxNByz8UgdPCtPbTnSTna/NlxY31fFuZ2r2tA==
X-Received: by 2002:a05:6a00:b4e:b0:736:57cb:f2b6 with SMTP id
 d2e1a72fcca58-736aaa1acf0mr6203284b3a.12.1741372622832; 
 Fri, 07 Mar 2025 10:37:02 -0800 (PST)
Received: from [192.168.0.113] ([58.37.175.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736aead3439sm1707204b3a.64.2025.03.07.10.37.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 10:37:02 -0800 (PST)
Message-ID: <46b7c8ff-06b3-4e01-a00d-1a388a0bf6a3@gmail.com>
Date: Sat, 8 Mar 2025 02:37:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] vfio/igd: Decouple common quirks from legacy mode
To: Alex Williamson <alex.williamson@redhat.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Corvin_K=C3=B6hne?=
 <corvin.koehne@gmail.com>
References: <20250306180131.32970-1-tomitamoeko@gmail.com>
 <20250306180131.32970-8-tomitamoeko@gmail.com>
 <20250306154920.0e1936eb.alex.williamson@redhat.com>
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <20250306154920.0e1936eb.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x644.google.com
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

On 2025/3/7 6:49, Alex Williamson wrote:
> On Fri,  7 Mar 2025 02:01:27 +0800
> Tomita Moeko <tomitamoeko@gmail.com> wrote:
> 
>> So far, IGD-specific quirks all require enabling legacy mode, which is
>> toggled by assigning IGD to 00:02.0. However, some quirks, like the BDSM
>> and GGC register quirks, should be applied to all supported IGD devices.
>> A new config option, x-igd-legacy-mode=[on|off|auto], is introduced to
>> control the legacy mode only quirks. The default value is "auto", which
>> keeps current behavior that enables legacy mode implicitly and continues
>> on error when all following conditions are met.
>> * Machine type is i440fx
>> * IGD device is at guest BDF 00:02.0
>>
>> If any one of the conditions above is not met, the default behavior is
>> equivalent to "off", QEMU will fail immediately if any error occurs.
>>
>> Users can also use "on" to force enabling legacy mode. It checks if all
>> the conditions above are met and set up legacy mode. QEMU will also fail
>> immediately on error in this case.
>>
>> Additionally, the hotplug check in legacy mode is removed as hotplugging
>> IGD device is never supported, and it will be checked when enabling the
>> OpRegion quirk.
>>
>> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
>> ---
>>  hw/vfio/igd.c | 127 +++++++++++++++++++++++++++++---------------------
>>  hw/vfio/pci.c |   2 +
>>  hw/vfio/pci.h |   1 +
>>  3 files changed, 77 insertions(+), 53 deletions(-)
>>
>> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
>> index f5e19f1241..ac096e2eb5 100644
>> --- a/hw/vfio/igd.c
>> +++ b/hw/vfio/igd.c
>> @@ -15,6 +15,7 @@
>>  #include "qemu/error-report.h"
>>  #include "qapi/error.h"
>>  #include "qapi/qmp/qerror.h"
>> +#include "hw/boards.h"
>>  #include "hw/hw.h"
>>  #include "hw/nvram/fw_cfg.h"
>>  #include "pci.h"
>> @@ -432,9 +433,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>>       * bus address.
>>       */
>>      if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
>> -        !vfio_is_vga(vdev) || nr != 0 ||
>> -        &vdev->pdev != pci_find_device(pci_device_root_bus(&vdev->pdev),
>> -                                       0, PCI_DEVFN(0x2, 0))) {
>> +        !vfio_is_vga(vdev) || nr != 0) {
>>          return;
>>      }
>>  
>> @@ -482,14 +481,13 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>>      QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, bdsm_quirk, next);
>>  }
>>  
>> -bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
>> -                                 Error **errp G_GNUC_UNUSED)
>> +bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>>  {
>> -    g_autofree struct vfio_region_info *rom = NULL;
>>      int ret, gen;
>>      uint64_t gms_size;
>>      uint64_t *bdsm_size;
>>      uint32_t gmch;
>> +    bool legacy_mode_enabled = false;
>>      Error *err = NULL;
>>  
>>      /*
>> @@ -498,9 +496,7 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
>>       * PCI bus address.
>>       */
>>      if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
>> -        !vfio_is_vga(vdev) ||
>> -        &vdev->pdev != pci_find_device(pci_device_root_bus(&vdev->pdev),
>> -                                       0, PCI_DEVFN(0x2, 0))) {
>> +        !vfio_is_vga(vdev)) {
>>          return true;
>>      }
>>  
>> @@ -516,56 +512,67 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
>>          return true;
>>      }
>>  
>> -    /*
>> -     * Most of what we're doing here is to enable the ROM to run, so if
>> -     * there's no ROM, there's no point in setting up this quirk.
>> -     * NB. We only seem to get BIOS ROMs, so a UEFI VM would need CSM support.
>> -     */
>> -    ret = vfio_get_region_info(&vdev->vbasedev,
>> -                               VFIO_PCI_ROM_REGION_INDEX, &rom);
>> -    if ((ret || !rom->size) && !vdev->pdev.romfile) {
>> -        error_report("IGD device %s has no ROM, legacy mode disabled",
>> -                     vdev->vbasedev.name);
>> -        return true;
>> -    }
>> -
>> -    /*
>> -     * Ignore the hotplug corner case, mark the ROM failed, we can't
>> -     * create the devices we need for legacy mode in the hotplug scenario.
>> -     */
>> -    if (vdev->pdev.qdev.hotplugged) {
>> -        error_report("IGD device %s hotplugged, ROM disabled, "
>> -                     "legacy mode disabled", vdev->vbasedev.name);
>> -        vdev->rom_read_failed = true;
>> -        return true;
>> -    }
>> -
>>      gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, 4);
>>  
>>      /*
>> -     * If IGD VGA Disable is clear (expected) and VGA is not already enabled,
>> -     * try to enable it.  Probably shouldn't be using legacy mode without VGA,
>> -     * but also no point in us enabling VGA if disabled in hardware.
>> +     * For backward compatibilty, enable legacy mode when
>> +     * - Machine type is i440fx (pc_piix)
>> +     * - IGD device is at guest BDF 00:02.0
>> +     * - Not manually disabled by x-igd-legacy-mode=off
>>       */
>> -    if (!(gmch & 0x2) && !vdev->vga && !vfio_populate_vga(vdev, &err)) {
>> -        error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>> -        error_report("IGD device %s failed to enable VGA access, "
>> -                     "legacy mode disabled", vdev->vbasedev.name);
>> -        return true;
>> -    }
>> +    if ((vdev->igd_legacy_mode != ON_OFF_AUTO_OFF) &&
>> +        !strcmp(MACHINE_GET_CLASS(qdev_get_machine())->family, "pc_piix") &&
>> +        (&vdev->pdev == pci_find_device(pci_device_root_bus(&vdev->pdev),
>> +        0, PCI_DEVFN(0x2, 0)))) {
>> +        /*
>> +         * IGD legacy mode requires:
>> +         * - VBIOS in ROM BAR or file
>> +         * - VGA IO/MMIO ranges are claimed by IGD
>> +         * - OpRegion
>> +         * - Same LPC bridge and Host bridge VID/DID/SVID/SSID as host
>> +         */
>> +        g_autofree struct vfio_region_info *rom = NULL;
>> +
>> +        legacy_mode_enabled = true;
>> +        warn_report("IGD legacy mode enabled, "
>> +                    "use x-igd-legacy-mode=off to disable it if unwanted.");
> 
> info_report() maybe?  These aren't great choices for a user, get a
> warning for using the intended mode or silence that warning by
> requiring experimental options that taint the VM relative to libvirt.

Got it. If possible, please help change this to info_report when
applying.

> Also, why do we list all the requirements then only test a few of them
> before declaring we're using legacy mode?  It seems like the above
> should be moved to the end of this branch.

Having i440fx machine type and BDF 00:02.0 are the must-have condition
for considering enabling legacy mode, while others are the requirements
for legacy mode itself. In this verison, legacy mode is equivalent to
    romfile=oprom.bin,x-vga=on,x-igd-opregion=on,x-igd-lpc=on

BDF being 00:02.0 is a requirement of VBIOS, and hacking the LPC DID
currently only works on i440fx. Though for Q35, we can overwrite the
existing ICH9 LPC DID to make IGD driver happy, it won't break ACPI PM
in recent guest kernel, and maybe later making it an option for Q35,
its still too risky to make it an implicit default. That's why I prefer
to check the must-have condtions first, then check other requirements
when setting up them.  

Setting the `legacy_mode_enabled` flag here is for error handling, as
we have to keep the old "continue on error" behavior for legacy mode.

> Given the pending release deadline, maybe these aren't blockers, but
> let's follow-up with something that assumes the user wants something
> other than what they're doing.  Thanks,
> 
> Alex
>

Sure.

Moeko
 
>> +
>> +        /*
>> +         * Most of what we're doing here is to enable the ROM to run, so if
>> +         * there's no ROM, there's no point in setting up this quirk.
>> +         * NB. We only seem to get BIOS ROMs, so UEFI VM would need CSM support.
>> +         */
>> +        ret = vfio_get_region_info(&vdev->vbasedev,
>> +                                   VFIO_PCI_ROM_REGION_INDEX, &rom);
>> +        if ((ret || !rom->size) && !vdev->pdev.romfile) {
>> +            error_setg(&err, "Device has no ROM");
>> +            goto error;
>> +        }
>>  
>> -    /* Setup OpRegion access */
>> -    if (!vfio_pci_igd_setup_opregion(vdev, &err)) {
>> -        error_append_hint(&err, "IGD legacy mode disabled\n");
>> -        error_report_err(err);
>> -        return true;
>> -    }
>> +        /*
>> +         * If IGD VGA Disable is clear (expected) and VGA is not already
>> +         * enabled, try to enable it. Probably shouldn't be using legacy mode
>> +         * without VGA, but also no point in us enabling VGA if disabled in
>> +         * hardware.
>> +         */
>> +        if (!(gmch & 0x2) && !vdev->vga && !vfio_populate_vga(vdev, &err)) {
>> +            error_setg(&err, "Unable to enable VGA access");
>> +            goto error;
>> +        }
>>  
>> -    /* Setup LPC bridge / Host bridge PCI IDs */
>> -    if (!vfio_pci_igd_setup_lpc_bridge(vdev, &err)) {
>> -        error_append_hint(&err, "IGD legacy mode disabled\n");
>> -        error_report_err(err);
>> -        return true;
>> +        /* Setup OpRegion access */
>> +        if (!vfio_pci_igd_setup_opregion(vdev, &err)) {
>> +            goto error;
>> +        }
>> +
>> +        /* Setup LPC bridge / Host bridge PCI IDs */
>> +        if (!vfio_pci_igd_setup_lpc_bridge(vdev, &err)) {
>> +            goto error;
>> +        }
>> +    } else if (vdev->igd_legacy_mode == ON_OFF_AUTO_ON) {
>> +        error_setg(&err,
>> +                   "Machine is not i440fx or assigned BDF is not 00:02.0");
>> +        goto error;
>>      }
>>  
>>      /*
>> @@ -627,4 +634,18 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
>>      trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name, (gms_size / MiB));
>>  
>>      return true;
>> +
>> +error:
>> +    /*
>> +     * When legacy mode is implicity enabled, continue on error,
>> +     * to keep compatibility
>> +     */
>> +    if (legacy_mode_enabled && (vdev->igd_legacy_mode == ON_OFF_AUTO_AUTO)) {
>> +        error_report_err(err);
>> +        error_report("IGD legacy mode disabled");
>> +        return true;
>> +    }
>> +
>> +    error_propagate(errp, err);
>> +    return false;
>>  }
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index a58d555934..d5ff8c1ea8 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -3363,6 +3363,8 @@ static const Property vfio_pci_dev_properties[] = {
>>                      VFIO_FEATURE_ENABLE_REQ_BIT, true),
>>      DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
>>                      VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
>> +    DEFINE_PROP_ON_OFF_AUTO("x-igd-legacy-mode", VFIOPCIDevice,
>> +                            igd_legacy_mode, ON_OFF_AUTO_AUTO),
>>      DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
>>                              vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
>>      DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>> index 2e81f9eb19..aa67ceb346 100644
>> --- a/hw/vfio/pci.h
>> +++ b/hw/vfio/pci.h
>> @@ -158,6 +158,7 @@ struct VFIOPCIDevice {
>>      uint32_t display_xres;
>>      uint32_t display_yres;
>>      int32_t bootindex;
>> +    OnOffAuto igd_legacy_mode;
>>      uint32_t igd_gms;
>>      OffAutoPCIBAR msix_relo;
>>      uint8_t pm_cap;
> 


