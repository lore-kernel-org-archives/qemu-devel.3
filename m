Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19D6C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 17:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk5Jx-0006te-KQ; Mon, 17 Feb 2025 12:54:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tk5Ju-0006tF-3G
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 12:54:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tk5Jq-0003nv-N0
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 12:54:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739814848;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UBkk+Mm5jJ3pcnxrYc4+SoNdq86aXLvaFeK1PoZV+Kk=;
 b=fxs3YedXe/a+HAB1ctRtydYjnMMwXI3rqlAoy8PTkLY7JtlVHDDeoL9hXwdzdtQEBRXrb/
 f5GLkc1mjfxAAVRzuiBcQ1MMDw8Ximr2dUO9DtVepmbA6mM3YgfSsqbpxEw70v94IRjqna
 IGW6+2ZDk1lQIVqnu5ltBO7U/aq9XTQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-w7TX2I02PAm-Vqb_MbB8ng-1; Mon, 17 Feb 2025 12:54:06 -0500
X-MC-Unique: w7TX2I02PAm-Vqb_MbB8ng-1
X-Mimecast-MFC-AGG-ID: w7TX2I02PAm-Vqb_MbB8ng_1739814845
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4394b2c19ccso37763515e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 09:54:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739814845; x=1740419645;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UBkk+Mm5jJ3pcnxrYc4+SoNdq86aXLvaFeK1PoZV+Kk=;
 b=cE4ZhvZKq691Dj3hnCAfQ3W/tnG2KDcf05EKOj++7tmWJWA16F0aUqI/5t1CRDFQ67
 VJOd8P+vQZKn+Xd0R1oDuVGZJgdpp0RzY5Dp+htg3qOZei0xWWzzwcE5RJFLQqWz0jrU
 inR62svAOHx15Z+EPcxa1h+2mAwQ3amtOTw363Jt5gd3IqDgCgoZ5WzjtGMtvNuPbCma
 YFy+gd6l2Y+R3d9gYeJFLJwn0HjlYiTNzhq5e27icr+zupVOOSjCVjN5AV4Fz02tr7UF
 OZxi4XL3DIb4sWEKVu7oEFWAeHmpAPwHeobOYenJASDQDQ5ouLKMl/LNr6PSemf4rm0+
 5EVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQLL8FJNI3ffjHCQ18JaHD99G1yeb6vQcIC5kMH8zAQGCnBCuUpuqhTsF/QYQvAtAt4oTWxgtfjWLv@nongnu.org
X-Gm-Message-State: AOJu0YxUqzftOgUzJQx0TtV0DlEvv9OLy5f1469M84uYPe3+jwXNZw+k
 ifB5XPGkUL7ES6JT4HUuwFYRFfMHGKt+Fm+00lJGMll/xHjahfK7ObPYEVSHNi6v2kYumaqP+Tg
 uXVzibR3TzTFOUsj9OEIm0wWn5Xw5/wuK8ndqiw8Gc+6+VGd4d6No
X-Gm-Gg: ASbGncsrdA11jLTqLMKaRfN1MV3g+yOvDtlaKAleMEKECheMiEWWKNUc6lL1fDcYkeV
 z6yz/JzeQoWIvDwq6nJ8wY75SDtYRlO4u8xltDhjUy+A4ZEXTYrIocf9SU22FREmYO5oHTmSgHH
 xid+z/RT2IAwyXl46JRbfc3kQM8rxMQ/I4jBFyv2PFYe+9apAMUGKcPo7Nhk75zIijBp8Um/v/D
 3RI8rHQ+nYCxOax3UcSBIuP9Rwo2JkSbGM1Y+Z4Cr7R3LfIJmOnSSFHzeLmxftMz/F+7k545GED
 g2M5Y6kFVT4sY4KrbH0/UnhbmWGDTV4VUFOVGzDmdL4l7RRbQoc+
X-Received: by 2002:a05:600c:1d1a:b0:439:5756:ad4c with SMTP id
 5b1f17b1804b1-4396e6c1885mr114132535e9.14.1739814845094; 
 Mon, 17 Feb 2025 09:54:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGVX/ZYPoG8/KLwCsTLB+QGl3B4ZdZIatfRwHD+5mDslgxkyUkHv77g33/LMq8d8FggUcEyg==
X-Received: by 2002:a05:600c:1d1a:b0:439:5756:ad4c with SMTP id
 5b1f17b1804b1-4396e6c1885mr114132285e9.14.1739814844637; 
 Mon, 17 Feb 2025 09:54:04 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439617da784sm131554705e9.5.2025.02.17.09.54.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 09:54:03 -0800 (PST)
Message-ID: <c85dbed0-abca-489c-bca7-717a53a5d23d@redhat.com>
Date: Mon, 17 Feb 2025 18:54:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] vfio: Add property documentation
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, tomitamoeko@gmail.com,
 corvin.koehne@gmail.com, Kirti Wankhede <kwankhede@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
References: <20250217173455.449983-1-clg@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250217173455.449983-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org




On 2/17/25 6:34 PM, Cédric Le Goater wrote:
> Investigate the git history to uncover when and why the VFIO
> properties were introduced and update the models. This is mostly
> targeting vfio-pci device, since vfio-platform, vfio-ap and vfio-ccw
> devices are simpler.
>
> Sort the properties based on the QEMU version in which they were
> introduced.
>
> Cc: Tony Krowiak <akrowiak@linux.ibm.com>
> Cc: Eric Farman <farman@linux.ibm.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>
>  Should we introduce documentation for properties like the kernel has
>  in Documentation/ABI/*/sysfs-* ?
>
>  Changes in v4:
>
>  - Latest improvements from Alex 
>
>  Changes in v3:
>
>  - Re-organized the vfio-pci properties based on the QEMU version in
>    which they were introduced
>  - Added property labels
>  - Improved description as suggested by Alex, Tomita and Corvin
>
>  Changes in v2:
>
>  - Fixed version numbers
>  - Fixed #ifdef in vfio/ccw.c
>  - Addressed vfio-pci-nohotplug
>  - Organize the vfio-pci properties in topics
>
>  hw/vfio/ap.c       |   9 ++++
>  hw/vfio/ccw.c      |  15 ++++++
>  hw/vfio/pci.c      | 125 +++++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/platform.c |  24 +++++++++
>  4 files changed, 173 insertions(+)
>
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 30b08ad375d5ecae886c5000fbaa364799fe76d0..c7ab4ff57ada0ed0e5a76f52b5a05c86ca4fe0b4 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -257,6 +257,15 @@ static void vfio_ap_class_init(ObjectClass *klass, void *data)
>      dc->hotpluggable = true;
>      device_class_set_legacy_reset(dc, vfio_ap_reset);
>      dc->bus_type = TYPE_AP_BUS;
> +
> +    object_class_property_set_description(klass, /* 3.1 */
> +                                          "sysfsdev",
> +                                          "Host sysfs path of assigned device");
> +#ifdef CONFIG_IOMMUFD
> +    object_class_property_set_description(klass, /* 9.0 */
> +                                          "iommufd",
> +                                          "Set host IOMMUFD backend device");
> +#endif
>  }
>  
>  static const TypeInfo vfio_ap_info = {
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 6bb8882d3f2b965eb47cc9e65d7e74bbdb5e7685..e5e0d9e3e7ed124f242b3eda345bc973e418a64c 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -709,6 +709,21 @@ static void vfio_ccw_class_init(ObjectClass *klass, void *data)
>      cdc->handle_halt = vfio_ccw_handle_halt;
>      cdc->handle_clear = vfio_ccw_handle_clear;
>      cdc->handle_store = vfio_ccw_handle_store;
> +
> +    object_class_property_set_description(klass, /* 2.10 */
> +                                          "sysfsdev",
> +                                          "Host sysfs path of assigned device");
> +    object_class_property_set_description(klass, /* 3.0 */
> +                                          "force-orb-pfch",
> +                                          "Force unlimited prefetch");
> +#ifdef CONFIG_IOMMUFD
> +    object_class_property_set_description(klass, /* 9.0 */
> +                                          "iommufd",
> +                                          "Set host IOMMUFD backend device");
> +#endif
> +    object_class_property_set_description(klass, /* 9.2 */
> +                                          "loadparm",
> +                                          "Define which devices that can be used for booting");
>  }
>  
>  static const TypeInfo vfio_ccw_info = {
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 89d900e9cf0ce364f7c813d81b0317bb3b3e80ca..4f92b50b133060c9199079a0ab620793ecdac0ee 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3433,6 +3433,122 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
>      pdc->exit = vfio_exitfn;
>      pdc->config_read = vfio_pci_read_config;
>      pdc->config_write = vfio_pci_write_config;
> +
> +    object_class_property_set_description(klass, /* 1.3 */
> +                                          "host",
> +                                          "Host PCI address [domain:]<bus:slot.function> of assigned device");
> +    object_class_property_set_description(klass, /* 1.3 */
> +                                          "x-intx-mmap-timeout-ms",
> +                                          "When EOI is not provided by KVM/QEMU, wait time "
> +                                          "(milliseconds) to re-enable device direct access "
> +                                          "after INTx (DEBUG)");
> +    object_class_property_set_description(klass, /* 1.5 */
> +                                          "x-vga",
> +                                          "Expose VGA address spaces for device");
> +    object_class_property_set_description(klass, /* 2.3 */
> +                                          "x-req",
> +                                          "Disable device request notification support (DEBUG)");
> +    object_class_property_set_description(klass, /* 2.4 and 2.5 */
> +                                          "x-no-mmap",
> +                                          "Disable MMAP for device. Allows to trace MMIO "
> +                                          "accesses (DEBUG)");
> +    object_class_property_set_description(klass, /* 2.5 */
> +                                          "x-no-kvm-intx",
> +                                          "Disable direct VFIO->KVM INTx injection. Allows to "
> +                                          "trace INTx interrupts (DEBUG)");
> +    object_class_property_set_description(klass, /* 2.5 */
> +                                          "x-no-kvm-msi",
> +                                          "Disable direct VFIO->KVM MSI injection. Allows to "
> +                                          "trace MSI interrupts (DEBUG)");
> +    object_class_property_set_description(klass, /* 2.5 */
> +                                          "x-no-kvm-msix",
> +                                          "Disable direct VFIO->KVM MSIx injection. Allows to "
> +                                          "trace MSIx interrupts (DEBUG)");
> +    object_class_property_set_description(klass, /* 2.5 */
> +                                          "x-pci-vendor-id",
> +                                          "Override PCI Vendor ID with provided value (DEBUG)");
> +    object_class_property_set_description(klass, /* 2.5 */
> +                                          "x-pci-device-id",
> +                                          "Override PCI device ID with provided value (DEBUG)");
> +    object_class_property_set_description(klass, /* 2.5 */
> +                                          "x-pci-sub-vendor-id",
> +                                          "Override PCI Subsystem Vendor ID with provided value "
> +                                          "(DEBUG)");
> +    object_class_property_set_description(klass, /* 2.5 */
> +                                          "x-pci-sub-device-id",
> +                                          "Override PCI Subsystem Device ID with provided value "
> +                                          "(DEBUG)");
> +    object_class_property_set_description(klass, /* 2.6 */
> +                                          "sysfsdev",
> +                                          "Host sysfs path of assigned device");
> +    object_class_property_set_description(klass, /* 2.7 */
> +                                          "x-igd-opregion",
> +                                          "Expose host IGD OpRegion to guest");
> +    object_class_property_set_description(klass, /* 2.7 (See c4c45e943e51) */
> +                                          "x-igd-gms",
> +                                          "Override IGD data stolen memory size (32MiB units)");
> +    object_class_property_set_description(klass, /* 2.11 */
> +                                          "x-nv-gpudirect-clique",
> +                                          "Add NVIDIA GPUDirect capability indicating P2P DMA "
> +                                          "clique for device [0-15]");
> +    object_class_property_set_description(klass, /* 2.12 */
> +                                          "x-no-geforce-quirks",
> +                                          "Disable GeForce quirks (for NVIDIA Quadro/GRID/Tesla). "
> +                                          "Improves performance");
> +    object_class_property_set_description(klass, /* 2.12 */
> +                                          "display",
> +                                          "Enable display support for device, ex. vGPU");
> +    object_class_property_set_description(klass, /* 2.12 */
> +                                          "x-msix-relocation",
> +                                          "Specify MSI-X MMIO relocation to the end of specified "
> +                                          "existing BAR or new BAR to avoid virtualization overhead "
> +                                          "due to adjacent device registers");
> +    object_class_property_set_description(klass, /* 3.0 */
> +                                          "x-no-kvm-ioeventfd",
> +                                          "Disable registration of ioeventfds with KVM (DEBUG)");
> +    object_class_property_set_description(klass, /* 3.0 */
> +                                          "x-no-vfio-ioeventfd",
> +                                          "Disable linking of KVM ioeventfds to VFIO ioeventfds "
> +                                          "(DEBUG)");
> +    object_class_property_set_description(klass, /* 3.1 */
> +                                          "x-balloon-allowed",
> +                                          "Override allowing ballooning with device (DEBUG, DANGER)");
> +    object_class_property_set_description(klass, /* 3.2 */
> +                                          "xres",
> +                                          "Set X display resolution the vGPU should use");
> +    object_class_property_set_description(klass, /* 3.2 */
> +                                          "yres",
> +                                          "Set Y display resolution the vGPU should use");
> +    object_class_property_set_description(klass, /* 5.2 */
> +                                          "x-pre-copy-dirty-page-tracking",
> +                                          "Disable dirty pages tracking during iterative phase "
> +                                          "(DEBUG)");
> +    object_class_property_set_description(klass, /* 5.2, 8.0 non-experimetal */
> +                                          "enable-migration",
> +                                          "Enale device migration. Also requires a host VFIO PCI "
> +                                          "variant or mdev driver with migration support enabled");
> +    object_class_property_set_description(klass, /* 8.1 */
> +                                          "vf-token",
> +                                          "Specify UUID VF token. Required for VF when PF is owned "
> +                                          "by another VFIO driver");
> +#ifdef CONFIG_IOMMUFD
> +    object_class_property_set_description(klass, /* 9.0 */
> +                                          "iommufd",
> +                                          "Set host IOMMUFD backend device");
> +#endif
> +    object_class_property_set_description(klass, /* 9.1 */
> +                                          "x-device-dirty-page-tracking",
> +                                          "Disable device dirty page tracking and use "
> +                                          "container-based dirty page tracking (DEBUG)");
> +    object_class_property_set_description(klass, /* 9.1 */
> +                                          "migration-events",
> +                                          "Emit VFIO migration QAPI event when a VFIO device "
> +                                          "changes its migration state. For management applications");
> +    object_class_property_set_description(klass, /* 9.1 */
> +                                          "skip-vsc-check",
> +                                          "Skip config space check for Vendor Specific Capability. "
> +                                          "Setting to false will enforce strict checking of VSC content "
> +                                          "(DEBUG)");
>  }
>  
>  static const TypeInfo vfio_pci_dev_info = {
> @@ -3461,6 +3577,15 @@ static void vfio_pci_nohotplug_dev_class_init(ObjectClass *klass, void *data)
>  
>      device_class_set_props(dc, vfio_pci_dev_nohotplug_properties);
>      dc->hotpluggable = false;
> +
> +    object_class_property_set_description(klass, /* 3.1 */
> +                                          "ramfb",
> +                                          "Enable ramfb to provide pre-boot graphics for devices "
> +                                          "enabling display option");
> +    object_class_property_set_description(klass, /* 8.2 */
> +                                          "x-ramfb-migrate",
> +                                          "Override default migration support for ramfb support "
> +                                          "(DEBUG)");
>  }
>  
>  static const TypeInfo vfio_pci_nohotplug_dev_info = {
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index f491f4dc9543c2ea3a7af4e51ee82fbc7ee6e4bb..d9faaa73959ad36aa3a835b87964ab940928bd9f 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -672,6 +672,30 @@ static void vfio_platform_class_init(ObjectClass *klass, void *data)
>      dc->desc = "VFIO-based platform device assignment";
>      sbc->connect_irq_notifier = vfio_start_irqfd_injection;
>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +
> +    object_class_property_set_description(klass, /* 2.4 */
> +                                          "host",
> +                                          "Host device name of assigned device");
> +    object_class_property_set_description(klass, /* 2.4 and 2.5 */
> +                                          "x-no-mmap",
> +                                          "Disable MMAP for device. Allows to trace MMIO "
> +                                          "accesses (DEBUG)");
> +    object_class_property_set_description(klass, /* 2.4 */
> +                                          "mmap-timeout-ms",
> +                                          "When EOI is not provided by KVM/QEMU, wait time "
> +                                          "(milliseconds) to re-enable device direct access "
> +                                          "after level interrupt (DEBUG)");
> +    object_class_property_set_description(klass, /* 2.4 */
> +                                          "x-irqfd",
> +                                          "Allow disabling irqfd support (DEBUG)");
> +    object_class_property_set_description(klass, /* 2.6 */
> +                                          "sysfsdev",
> +                                          "Host sysfs path of assigned device");
> +#ifdef CONFIG_IOMMUFD
> +    object_class_property_set_description(klass, /* 9.0 */
> +                                          "iommufd",
> +                                          "Set host IOMMUFD backend device");
> +#endif

for the vfio-platform part,

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
>  }
>  
>  static const TypeInfo vfio_platform_dev_info = {


