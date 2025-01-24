Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1474C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 21:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbR04-00041e-DN; Fri, 24 Jan 2025 16:14:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tbR01-00041T-RZ
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 16:13:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tbQzv-0004Y5-35
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 16:13:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737753229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8NO4hWdolbIpf2qF8osr0eGD5kMbSOqb1UpAADZLCcA=;
 b=X0sZrUHuBWpdxJxe13U12Pro246EYpb45DWuJvCRJbXCEY1dsLdzOf1QBDyN0HBbjh7ZvF
 fybqR6LwaBpbbL6TFn2EY23tfM77IMz5y90uUR/Ytv5ASKGgNLyqJ4WNh19Cq6k2la2tSI
 kjoz9we2RM8hgvBvrqpCayFh3heMaYE=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-121Cfx2hM5aVvKShzdV--A-1; Fri, 24 Jan 2025 16:13:47 -0500
X-MC-Unique: 121Cfx2hM5aVvKShzdV--A-1
X-Mimecast-MFC-AGG-ID: 121Cfx2hM5aVvKShzdV--A
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-844e255c111so15865539f.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 13:13:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737753226; x=1738358026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8NO4hWdolbIpf2qF8osr0eGD5kMbSOqb1UpAADZLCcA=;
 b=I5NYZsLdfEBbf+/3vbZBsbR7z1M4lz2xbMokWOhCQTyKnzzMYqlwA5TaBB1H15A9fH
 YlAd2zZTht4Ifiq5snHfCirTAFav7yaEZRyM7eC5eh7aNwD9rrnp4/PuppPGZNooaYAo
 6pElUtoSj0ve5c3GsrNJImydbXFnJ+NLJoayZGgpiEOB7fADLQIesO1DHiBpbJr8ZuyM
 Px/aUfvKDjR4skJzUEZ1zufJcczUoS94G7bHVqujTjxT0PSPBVH/FX4dOg8Y7ggQ+IjF
 m2IzqBL7r0zti932ZA6Ke73JW6tSIKN4bzZWKYNfpwKVE6X9KxG9wNmQsN2DkeO07eUD
 kApQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2lk7CnIWNIu56t9rgh5lsiSKNLLJMXfF+PlhUWEDbjLc3O7Bj47rZJzlK+IOVwoBspi+ltQN+dW+n@nongnu.org
X-Gm-Message-State: AOJu0YxmO2GhC0kCZbwwJa33ZL/PlIf+f5I89W6p3NLRnJ0WQhMvRSkQ
 K29oJ0JZqmm0h4MwQVvJobSFV3LAZz7gJCZeNT2ZxgWJC6GGUVmhNknCKbzenn5C+cEkzhXtIkd
 5mIbuqgZ9KFz4dV7DXLOkTKLhx60m759Z4UjsS7x2dM8P5D7PBp9b0RfRujc4
X-Gm-Gg: ASbGncs57ao/1E9IRj85uDwPH4zHH+zhaOS9gp9be7otY8G2ecoMdaiV0I2wrzic7M+
 8z/uVZrjd8ECI3gtEb6w5WgbqKXsVAl/HvODiQskNx6+QlRIFIRUx0GILEGVEj3yJEhYdYisfP2
 g5TuA6O7rztb2tX22Ht17IyHlje+5Hpng1pBP5wgkxypvg9t7MuwxZMTt+gnyAjLgdJn2f2UyHB
 3b0lpfxs/nClc7tqTfIn+IwkinQmnfEr3hMxAHP3KYnWuf6HAp+KPro4Ec9LITsNNB+hnu51ORD
 42S/w4/A
X-Received: by 2002:a05:6e02:1a8e:b0:3cb:f2e6:55ab with SMTP id
 e9e14a558f8ab-3cf742812d9mr80699555ab.0.1737753225907; 
 Fri, 24 Jan 2025 13:13:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOvM34DFPgIhu3SbidvA4OcJ6KvCRI1BL50qCg9rgyp9JFZFKETgp2vfEKNI4b1ywbbrw9qg==
X-Received: by 2002:a05:6e02:1a8e:b0:3cb:f2e6:55ab with SMTP id
 e9e14a558f8ab-3cf742812d9mr80699505ab.0.1737753225419; 
 Fri, 24 Jan 2025 13:13:45 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3cfc744bd99sm9122575ab.42.2025.01.24.13.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 13:13:44 -0800 (PST)
Date: Fri, 24 Jan 2025 14:13:42 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 5/5] vfio/igd: handle x-igd-opregion in
 vfio_probe_igd_config_quirk()
Message-ID: <20250124141342.255a79d3.alex.williamson@redhat.com>
In-Reply-To: <20250124191245.12464-6-tomitamoeko@gmail.com>
References: <20250124191245.12464-1-tomitamoeko@gmail.com>
 <20250124191245.12464-6-tomitamoeko@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, 25 Jan 2025 03:12:45 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> Both enable opregion option (x-igd-opregion) and legacy mode require
> setting up OpRegion copy for IGD devices. Move x-igd-opregion handler
> in vfio_realize() to vfio_probe_igd_config_quirk() to elimate duplicate
> code. Finally we moved all the IGD-related code into igd.c.
> 
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
>  hw/vfio/igd.c        | 143 +++++++++++++++++++++++++++++++++----------
>  hw/vfio/pci-quirks.c |  50 ---------------
>  hw/vfio/pci.c        |  25 --------
>  hw/vfio/pci.h        |   4 --
>  4 files changed, 110 insertions(+), 112 deletions(-)
> 
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 6e06dd774a..015beacf5f 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -106,6 +106,7 @@ static int igd_gen(VFIOPCIDevice *vdev)
>      return -1;
>  }
>  
> +#define IGD_ASLS 0xfc /* ASL Storage Register */
>  #define IGD_GMCH 0x50 /* Graphics Control Register */
>  #define IGD_BDSM 0x5c /* Base Data of Stolen Memory */
>  #define IGD_BDSM_GEN11 0xc0 /* Base Data of Stolen Memory of gen 11 and later */
> @@ -138,6 +139,55 @@ static uint64_t igd_stolen_memory_size(int gen, uint32_t gmch)
>      return 0;
>  }
>  
> +/*
> + * The OpRegion includes the Video BIOS Table, which seems important for
> + * telling the driver what sort of outputs it has.  Without this, the device
> + * may work in the guest, but we may not get output.  This also requires BIOS
> + * support to reserve and populate a section of guest memory sufficient for
> + * the table and to write the base address of that memory to the ASLS register
> + * of the IGD device.
> + */
> +static bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
> +                                       struct vfio_region_info *info,
> +                                       Error **errp)
> +{
> +    int ret;
> +
> +    vdev->igd_opregion = g_malloc0(info->size);
> +    ret = pread(vdev->vbasedev.fd, vdev->igd_opregion,
> +                info->size, info->offset);
> +    if (ret != info->size) {
> +        error_setg(errp, "failed to read IGD OpRegion");
> +        g_free(vdev->igd_opregion);
> +        vdev->igd_opregion = NULL;
> +        return false;
> +    }
> +
> +    /*
> +     * Provide fw_cfg with a copy of the OpRegion which the VM firmware is to
> +     * allocate 32bit reserved memory for, copy these contents into, and write
> +     * the reserved memory base address to the device ASLS register at 0xFC.
> +     * Alignment of this reserved region seems flexible, but using a 4k page
> +     * alignment seems to work well.  This interface assumes a single IGD
> +     * device, which may be at VM address 00:02.0 in legacy mode or another
> +     * address in UPT mode.
> +     *
> +     * NB, there may be future use cases discovered where the VM should have
> +     * direct interaction with the host OpRegion, in which case the write to
> +     * the ASLS register would trigger MemoryRegion setup to enable that.
> +     */
> +    fw_cfg_add_file(fw_cfg_find(), "etc/igd-opregion",
> +                    vdev->igd_opregion, info->size);
> +
> +    trace_vfio_pci_igd_opregion_enabled(vdev->vbasedev.name);
> +
> +    pci_set_long(vdev->pdev.config + IGD_ASLS, 0);
> +    pci_set_long(vdev->pdev.wmask + IGD_ASLS, ~0);
> +    pci_set_long(vdev->emulated_config_bits + IGD_ASLS, ~0);
> +
> +    return true;
> +}
> +
>  /*
>   * The rather short list of registers that we copy from the host devices.
>   * The LPC/ISA bridge values are definitely needed to support the vBIOS, the
> @@ -339,29 +389,83 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>      QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, bdsm_quirk, next);
>  }
>  
> +static bool vfio_igd_try_enable_opregion(VFIOPCIDevice *vdev, Error **errp)
> +{
> +    g_autofree struct vfio_region_info *opregion = NULL;
> +    int ret;
> +
> +    /*
> +     * Hotplugging is not supprted for both opregion access and legacy mode.
> +     * For legacy mode, we also need to mark the ROM failed.
> +     */

The explanation was a little better in the removed comment.

> +    if (vdev->pdev.qdev.hotplugged) {
> +        vdev->rom_read_failed = true;
> +        error_setg(errp,
> +                   "IGD OpRegion is not supported on hotplugged device");

As was the error log.

> +        return false;
> +    }
> +
> +    ret = vfio_get_dev_region_info(&vdev->vbasedev,
> +                    VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
> +                    VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, &opregion);
> +    if (ret) {
> +        error_setg_errno(errp, -ret,
> +                         "device does not supports IGD OpRegion feature");
> +        return false;
> +    }
> +
> +    if (!vfio_pci_igd_opregion_init(vdev, opregion, errp)) {
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>  bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
> -                                 Error **errp G_GNUC_UNUSED)
> +                                 Error **errp)
>  {
>      g_autofree struct vfio_region_info *rom = NULL;
> -    g_autofree struct vfio_region_info *opregion = NULL;
>      g_autofree struct vfio_region_info *host = NULL;
>      g_autofree struct vfio_region_info *lpc = NULL;
> +    PCIBus *bus;
>      PCIDevice *lpc_bridge;
>      int ret, gen;
> +    bool legacy_mode, enable_opregion;
>      uint64_t gms_size;
>      uint64_t *bdsm_size;
>      uint32_t gmch;
>      Error *err = NULL;
>  
> +    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
> +        !vfio_is_vga(vdev)) {
> +        return true;
> +    }
> +
>      /*
>       * This must be an Intel VGA device at address 00:02.0 for us to even
>       * consider enabling legacy mode.  The vBIOS has dependencies on the
>       * PCI bus address.
>       */
> -    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
> -        !vfio_is_vga(vdev) ||
> -        &vdev->pdev != pci_find_device(pci_device_root_bus(&vdev->pdev),
> -                                       0, PCI_DEVFN(0x2, 0))) {
> +    bus = pci_device_root_bus(&vdev->pdev);
> +    legacy_mode = (&vdev->pdev == pci_find_device(bus, 0, PCI_DEVFN(0x2, 0)));
> +    enable_opregion = (vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION);
> +
> +    if (!enable_opregion && !legacy_mode) {
> +        return true;
> +    }
> +
> +    if (!vfio_igd_try_enable_opregion(vdev, &err)) {
> +        if (enable_opregion) {
> +            error_propagate(errp, err);
> +            return false;
> +        } else if (legacy_mode) {
> +            error_append_hint(&err, "IGD legacy mode disabled\n");
> +            error_report_err(err);
> +            return true;
> +        }
> +    }
> +
> +    if (!legacy_mode) {
>          return true;
>      }
>  
> @@ -404,30 +508,10 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
>          return true;
>      }
>  
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
>      /*
>       * Check whether we have all the vfio device specific regions to
>       * support legacy mode (added in Linux v4.6).  If not, bail.
>       */

And we're disassociating opregion setup from this useful comment.

What are we actually accomplishing here?  What specific code
duplication is eliminated?

Why is it important to move all this code to igd.c?

It's really difficult to untangle this refactor, I think it could be
done more iteratively, if it's really even beneficial.  Thanks,

Alex

> -    ret = vfio_get_dev_region_info(&vdev->vbasedev,
> -                        VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
> -                        VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, &opregion);
> -    if (ret) {
> -        error_report("IGD device %s does not support OpRegion access,"
> -                     "legacy mode disabled", vdev->vbasedev.name);
> -        return true;
> -    }
> -
>      ret = vfio_get_dev_region_info(&vdev->vbasedev,
>                          VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
>                          VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG, &host);
> @@ -476,13 +560,6 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
>          return true;
>      }
>  
> -    /* Setup OpRegion access */
> -    if (!vfio_pci_igd_opregion_init(vdev, opregion, &err)) {
> -        error_append_hint(&err, "IGD legacy mode disabled\n");
> -        error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> -        return true;
> -    }
> -
>      /*
>       * Allow user to override dsm size using x-igd-gms option, in multiples of
>       * 32MiB. This option should only be used when the desired size cannot be
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index b8379cb512..f2b37910f0 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -1114,56 +1114,6 @@ static void vfio_probe_rtl8168_bar2_quirk(VFIOPCIDevice *vdev, int nr)
>      trace_vfio_quirk_rtl8168_probe(vdev->vbasedev.name);
>  }
>  
> -#define IGD_ASLS 0xfc /* ASL Storage Register */
> -
> -/*
> - * The OpRegion includes the Video BIOS Table, which seems important for
> - * telling the driver what sort of outputs it has.  Without this, the device
> - * may work in the guest, but we may not get output.  This also requires BIOS
> - * support to reserve and populate a section of guest memory sufficient for
> - * the table and to write the base address of that memory to the ASLS register
> - * of the IGD device.
> - */
> -bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
> -                                struct vfio_region_info *info, Error **errp)
> -{
> -    int ret;
> -
> -    vdev->igd_opregion = g_malloc0(info->size);
> -    ret = pread(vdev->vbasedev.fd, vdev->igd_opregion,
> -                info->size, info->offset);
> -    if (ret != info->size) {
> -        error_setg(errp, "failed to read IGD OpRegion");
> -        g_free(vdev->igd_opregion);
> -        vdev->igd_opregion = NULL;
> -        return false;
> -    }
> -
> -    /*
> -     * Provide fw_cfg with a copy of the OpRegion which the VM firmware is to
> -     * allocate 32bit reserved memory for, copy these contents into, and write
> -     * the reserved memory base address to the device ASLS register at 0xFC.
> -     * Alignment of this reserved region seems flexible, but using a 4k page
> -     * alignment seems to work well.  This interface assumes a single IGD
> -     * device, which may be at VM address 00:02.0 in legacy mode or another
> -     * address in UPT mode.
> -     *
> -     * NB, there may be future use cases discovered where the VM should have
> -     * direct interaction with the host OpRegion, in which case the write to
> -     * the ASLS register would trigger MemoryRegion setup to enable that.
> -     */
> -    fw_cfg_add_file(fw_cfg_find(), "etc/igd-opregion",
> -                    vdev->igd_opregion, info->size);
> -
> -    trace_vfio_pci_igd_opregion_enabled(vdev->vbasedev.name);
> -
> -    pci_set_long(vdev->pdev.config + IGD_ASLS, 0);
> -    pci_set_long(vdev->pdev.wmask + IGD_ASLS, ~0);
> -    pci_set_long(vdev->emulated_config_bits + IGD_ASLS, ~0);
> -
> -    return true;
> -}
> -
>  /*
>   * Common quirk probe entry points.
>   */
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index e624ae56c4..1b90c78c5a 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3136,31 +3136,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>          vfio_bar_quirk_setup(vdev, i);
>      }
>  
> -    if (!vdev->igd_opregion &&
> -        vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION) {
> -        g_autofree struct vfio_region_info *opregion = NULL;
> -
> -        if (vdev->pdev.qdev.hotplugged) {
> -            error_setg(errp,
> -                       "cannot support IGD OpRegion feature on hotplugged "
> -                       "device");
> -            goto out_unset_idev;
> -        }
> -
> -        ret = vfio_get_dev_region_info(vbasedev,
> -                        VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
> -                        VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, &opregion);
> -        if (ret) {
> -            error_setg_errno(errp, -ret,
> -                             "does not support requested IGD OpRegion feature");
> -            goto out_unset_idev;
> -        }
> -
> -        if (!vfio_pci_igd_opregion_init(vdev, opregion, errp)) {
> -            goto out_unset_idev;
> -        }
> -    }
> -
>      /* QEMU emulates all of MSI & MSIX */
>      if (pdev->cap_present & QEMU_PCI_CAP_MSIX) {
>          memset(vdev->emulated_config_bits + pdev->msix_cap, 0xff,
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 5c64de0270..b9e920a6b4 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -229,10 +229,6 @@ int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
>  
>  bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp);
>  
> -bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
> -                                struct vfio_region_info *info,
> -                                Error **errp);
> -
>  void vfio_display_reset(VFIOPCIDevice *vdev);
>  bool vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
>  void vfio_display_finalize(VFIOPCIDevice *vdev);


