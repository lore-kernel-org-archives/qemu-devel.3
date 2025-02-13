Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A26C0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 14:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiaXZ-0002wj-2w; Thu, 13 Feb 2025 09:50:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tiaXW-0002uc-4M
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:50:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tiaXU-0002j7-0Y
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:50:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739458202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wdTgFfONcRUZvA5/oSCvGFr3Kk3bkGg4Y+5Q6uxHqJc=;
 b=bP5u+TEwe+6ILXQOapqZhJa3aCaSK33dJwMu4xfv+6K7gESrW0M/ZOEoJ8icx5G8uLq59X
 Ad0oFW9M89jFFmFUx1ijRczHjsUyS7OZv1KmD6gJLg3MG1wkYZGrSwN29hNnBOa6wBG1k3
 Osd47IPKxLQnHqIrZvNrzK0sL/lB7QE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-nP6Q-ozdNxKHXH8yifJA4w-1; Thu, 13 Feb 2025 09:50:01 -0500
X-MC-Unique: nP6Q-ozdNxKHXH8yifJA4w-1
X-Mimecast-MFC-AGG-ID: nP6Q-ozdNxKHXH8yifJA4w
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4395f1c4354so7171765e9.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 06:50:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739458199; x=1740062999;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wdTgFfONcRUZvA5/oSCvGFr3Kk3bkGg4Y+5Q6uxHqJc=;
 b=af1vipOdD8NEGzOU4U41IZykrDWGfcRyRcMoT4R6jHuFT9748CsFyf2v6HRQ2mzcgp
 2GyErYd5ZFaGJqE0vSjhOVayNcxzF4vhvwsGHdcZi3nc9handU0jLpeRGRRj+88wfcCQ
 7eI1VbmwSvzzMGnp6/GRNYuIxkfE8o1sxTi15bxG/CLm8wTQlRQf5MO2YXs0NR5IiJLT
 27xIJqSfL/WZ7fCoTxiRuHp7jMpeqYnAB7xn/xNAaxxSQNYl18tpEZA0aFunUftQ7CHy
 MjD5BN73+ywo7T9mv8WG6qEPx1DOgcUbO3650FoOrUJizoO4ejfhD4uFRNap66MraYN/
 OQ/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRcHhdzzIAxJEE/L4poVUQpKYbcOkgN42IeKr6rgQWdGisKMlizwY6yl0I1ZNjEYuB97cRPBF4+UTN@nongnu.org
X-Gm-Message-State: AOJu0YzyUerDoZOWa8frBKWuMO8d89L69ZDny5T2gnPmhNv+7V+vgN8n
 Xf+nMO6UZBEYkAeAQuZPYtD6j96+Oz+Sur5UvaSaLfIQNi/C9EOszIROXCqNe5B3Sg5hncXv2dc
 60wNlWKkphHVd6ojg5RV2uyz+kJmkcz+NLR+5dXTolE3fT7aQlDdjs2vcW1pp
X-Gm-Gg: ASbGncseZGzChGuXIrVCugimcKtJQV5YudvPngV3yPGRenHty00ZaD7cx3z7rnlFnXb
 4LZri0s7+5UTvZ+jICSBz06sObqsKigavAwwqiiw8gFhY12sJwh3KuBSRwSrqDD+7xGS0v1ER2O
 +yrjO6wTAsv8jlB58Z5h0EaaOk0XZYbLxOjCFEtW8Y6scOa8ySsQhjxtyxWlbgqy6/Kaov3jzh8
 fOzokCdv8SrC5Mf5QJ9ante8kG4oF8QUi3snbQOihvDzlemw4QTOjP/3SMmApYVz5BvxuaB8CuN
 RQo1rH3EtKCphp+tNJpxD73MVp5rA0Gwwxg+BWxHPuA=
X-Received: by 2002:a05:600c:1e18:b0:439:6589:e1de with SMTP id
 5b1f17b1804b1-4396589e306mr8771725e9.26.1739458199309; 
 Thu, 13 Feb 2025 06:49:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjy9Ck13gI9iRpZpd8sAx0uuIzYk10uIXFb4iLJ72/7OqV2RRUeualyM7/IueDFPu302lPzw==
X-Received: by 2002:a05:600c:1e18:b0:439:6589:e1de with SMTP id
 5b1f17b1804b1-4396589e306mr8771455e9.26.1739458198911; 
 Thu, 13 Feb 2025 06:49:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:ecac:5b28:cd98:868a?
 ([2a01:e0a:280:24f0:ecac:5b28:cd98:868a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f85c2sm2129330f8f.91.2025.02.13.06.49.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 06:49:58 -0800 (PST)
Message-ID: <f961628d-f2d4-4957-8b77-0f065c100c67@redhat.com>
Date: Thu, 13 Feb 2025 15:49:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio: Add property documentation
To: eric.auger@redhat.com, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
References: <20250213135050.1426258-1-clg@redhat.com>
 <a5c82242-0a1d-46ca-9773-4a80d706e64f@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <a5c82242-0a1d-46ca-9773-4a80d706e64f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 2/13/25 15:45, Eric Auger wrote:
> Hi Cédric,
> 
> 
> On 2/13/25 2:50 PM, Cédric Le Goater wrote:
>> Investigate the git history to uncover when and why the VFIO
>> properties were introduced and update the models. This is mostly
>> targeting vfio-pci device, since vfio-plateform, vfio-ap and vfio-ccw
>> devices are simpler.
>>
>> Organize the vfio-pci properties in topics. It would be great to have
>> a way to do the same for the output.
>>
>> Cc: Tony Krowiak <akrowiak@linux.ibm.com>
>> Cc: Eric Farman <farman@linux.ibm.com>
>> Cc: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>
>>   Changes in v2:
>>
>>   - Fixed version numbers
>>   - Fixed #ifdef in vfio/ccw.c
>>   - Addressed vfio-pci-nohotplug
>>   - Organize the vfio-pci properties in topics
>>
>>   hw/vfio/ap.c       |   9 +++
>>   hw/vfio/ccw.c      |  15 +++++
>>   hw/vfio/pci.c      | 134 +++++++++++++++++++++++++++++++++++++++++++++
>>   hw/vfio/platform.c |  23 ++++++++
>>   4 files changed, 181 insertions(+)
>>
>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>> index 30b08ad375d5ecae886c5000fbaa364799fe76d0..ec1150e5d627fce83a5a6319af471fd0aa45ae9b 100644
>> --- a/hw/vfio/ap.c
>> +++ b/hw/vfio/ap.c
>> @@ -257,6 +257,15 @@ static void vfio_ap_class_init(ObjectClass *klass, void *data)
>>       dc->hotpluggable = true;
>>       device_class_set_legacy_reset(dc, vfio_ap_reset);
>>       dc->bus_type = TYPE_AP_BUS;
>> +
>> +    object_class_property_set_description(klass, /* 3.1 */
>> +                                          "sysfsdev",
>> +                                          "Host sysfs path of assigned device");
>> +#ifdef CONFIG_IOMMUFD
>> +    object_class_property_set_description(klass, /* 9.0 */
>> +                                          "iommufd",
>> +                                          "Set host IOMMUFD backend device ");
>> +#endif
>>   }
>>   
>>   static const TypeInfo vfio_ap_info = {
>> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
>> index 67bc137f9be6d43c5970c6271f3cdbfffd8a32de..242dc39660fcd028722093d637b7b64440649863 100644
>> --- a/hw/vfio/ccw.c
>> +++ b/hw/vfio/ccw.c
>> @@ -717,6 +717,21 @@ static void vfio_ccw_class_init(ObjectClass *klass, void *data)
>>       cdc->handle_halt = vfio_ccw_handle_halt;
>>       cdc->handle_clear = vfio_ccw_handle_clear;
>>       cdc->handle_store = vfio_ccw_handle_store;
>> +
>> +    object_class_property_set_description(klass, /* 2.10 */
>> +                                          "sysfsdev",
>> +                                          "Host sysfs path of assigned device");
>> +    object_class_property_set_description(klass, /* 3.0 */
>> +                                          "force-orb-pfch",
>> +                                          "Force unlimited prefetch");
>> +#ifdef CONFIG_IOMMUFD
>> +    object_class_property_set_description(klass, /* 9.0 */
>> +                                          "iommufd",
>> +                                          "Set host IOMMUFD backend device ");
>> +#endif
>> +    object_class_property_set_description(klass, /* 9.2 */
>> +                                          "loadparm",
>> +                                          "Define which devices that can be used for booting");
>>   }
>>   
>>   static const TypeInfo vfio_ccw_info = {
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 9a55e7b77324babf7295132b08e3ba23b482a291..fbd8cf566b1cfd508ccb0042a395e3b79ba781c0 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -3433,6 +3433,133 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
>>       pdc->exit = vfio_exitfn;
>>       pdc->config_read = vfio_pci_read_config;
>>       pdc->config_write = vfio_pci_write_config;
>> +
>> +    object_class_property_set_description(klass, /* 1.3 */
>> +                                          "host",
>> +                                          "Host PCI address [domain:]<bus:slot.function> of assigned device");
>> +    object_class_property_set_description(klass, /* 2.6 */
>> +                                          "sysfsdev",
>> +                                          "Host sysfs path of assigned device");
>> +    /*
>> +     * Display
>> +     */
>> +
>> +    object_class_property_set_description(klass, /* 1.5 */
>> +                                          "x-vga",
>> +                                          "Add support for VGA MMIO and I/O port access");
>> +    object_class_property_set_description(klass, /* 2.12 */
>> +                                          "display",
>> +                                          "Add display support");
>> +    object_class_property_set_description(klass, /* 3.2 */
>> +                                          "xres",
>> +                                          "Set X display resolution the vgpu should use");
>> +    object_class_property_set_description(klass, /* 3.2 */
>> +                                          "yres",
>> +                                          "Set Y display resolution the vgpu should use");
>> +
>> +    /*
>> +     * IGD
>> +     */
>> +
>> +    object_class_property_set_description(klass, /* 2.7 */
>> +                                          "x-igd-opregion",
>> +                                          "Add IGD OpRegion support for (headless system)");
>> +    object_class_property_set_description(klass, /* 2.7 (See c4c45e943e51) */
>> +                                          "x-igd-gms",
>> +                                          "Add Intel graphics legacy mode device assignment support. "
>> +                                          "Assign 00:02.0 from the host to 00:02.0 in the VM");
>> +
>> +    /*
>> +     * NVIDIA
>> +     */
>> +    object_class_property_set_description(klass, /* 2.12 */
>> +                                          "x-no-geforce-quirks",
>> +                                          "Disable GeForce quirks (for NVIDIA Quadro/GRID/Tesla). Improves performance");
>> +    object_class_property_set_description(klass, /* 3.0 */
>> +                                          "x-no-kvm-ioeventfd",
>> +                                          "Disable ioeventfd quirk (NVIDIA)");
>> +    object_class_property_set_description(klass, /* 3.0 */
>> +                                          "x-no-vfio-ioeventfd",
>> +                                          "Enable ioeventfd quirks to be handled by VFIO directly. Improves performance");
>> +    object_class_property_set_description(klass, /* 2.11 */
>> +                                          "x-nv-gpudirect-clique",
>> +                                          "Add NVIDIA GPUDirect Cliques support");
>> +
>> +    /*
>> +     * Migration support
>> +     */
>> +    object_class_property_set_description(klass, /* 5.2 */
>> +                                          "x-pre-copy-dirty-page-tracking",
>> +                                          "Disable dirty pages tracking during iterative phase");
>> +    object_class_property_set_description(klass, /* 9.1 */
>> +                                          "x-device-dirty-page-tracking",
>> +                                          "Disable device dirty page tracking and use container-based dirty page tracking");
>> +    object_class_property_set_description(klass, /* 5.2, 8.0 non-experimetal */
>> +                                          "enable-migration",
>> +                                          "Enale device migration. Also requires a host VFIO PCI variant "
>> +                                          "driver with migration support enabled");
>> +    object_class_property_set_description(klass, /* 9.1 */
>> +                                          "migration-events",
>> +                                          "Emit VFIO migration QAPI event when a VFIO device changes its migration "
>> +                                          "state. For management applications");
>> +    object_class_property_set_description(klass, /* 9.1 */
>> +                                          "skip-vsc-check",
>> +                                          "Skip config space check for Vendor Specific Capability. Useful for "
>> +                                          "NVIDIA vGPU driver migration");
>> +
>> +    /*
>> +     * debug, tracing
>> +     */
>> +    object_class_property_set_description(klass, /* 2.4 and 2.5 */
>> +                                          "x-no-mmap",
>> +                                          "Disable MMAP for device. Allows to trace MMIO accesses");
>> +    object_class_property_set_description(klass, /* 2.5 */
>> +                                          "x-no-kvm-intx",
>> +                                          "Bypass INTx interrupts. Allows interrupt tracing");
>> +    object_class_property_set_description(klass, /* 2.5 */
>> +                                          "x-no-kvm-msi",
>> +                                          "Bypass MSI interrupts. Allows interrupt tracing");
>> +    object_class_property_set_description(klass, /* 2.5 */
>> +                                          "x-no-kvm-msix",
>> +                                          "Bypass MSIx interrupts. Allows interrupt tracing");
>> +    object_class_property_set_description(klass, /* 2.5 */
>> +                                          "x-pci-vendor-id",
>> +                                          "Set emulated PCI Vendor ID. Allows testing quirks");
>> +    object_class_property_set_description(klass, /* 2.5 */
>> +                                          "x-pci-device-id",
>> +                                          "Set emulated PCI device ID. Allows testing quirks");
>> +
>> +    /*
>> +     * other
>> +     */
>> +    object_class_property_set_description(klass, /* 8.1 */
>> +                                          "vf-token",
>> +                                          "Add support for VF token among PF and VFs (Linux 5.7+)");
>> +    object_class_property_set_description(klass, /* 1.3 */
>> +                                          "x-intx-mmap-timeout-ms",
>> +                                          "Timeout value in milliseconds to re-enable BAR mapping when under "
>> +                                          "INTx interrupts. Improves performance");
>> +    object_class_property_set_description(klass, /* 2.3 */
>> +                                          "x-req",
>> +                                          "Add device request notification support (Linux 4.0+)");
>> +    object_class_property_set_description(klass, /* 3.1 */
>> +                                          "x-balloon-allowed",
>> +                                          "Allow devices to opt-in for ballooning");
>> +    object_class_property_set_description(klass, /* 2.5 */
>> +                                          "x-pci-sub-vendor-id",
>> +                                          "Set emulated PCI Sub-vendor ID");
>> +    object_class_property_set_description(klass, /* 2.5 */
>> +                                          "x-pci-sub-device-id",
>> +                                          "Set emulated PCI Sub-device ID");
>> +    object_class_property_set_description(klass, /* 2.12 */
>> +                                          "x-msix-relocation",
>> +                                          "Allow relocating MSI-X MMIO on systems which page size is larger "
>> +                                          "than the PCI spec recommendation. Mostly for sPAPR");
>> +#ifdef CONFIG_IOMMUFD
>> +    object_class_property_set_description(klass, /* 9.0 */
>> +                                          "iommufd",
>> +                                          "Set host IOMMUFD backend device ");
>> +#endif
>>   }
>>   
>>   static const TypeInfo vfio_pci_dev_info = {
>> @@ -3461,6 +3588,13 @@ static void vfio_pci_nohotplug_dev_class_init(ObjectClass *klass, void *data)
>>   
>>       device_class_set_props(dc, vfio_pci_dev_nohotplug_properties);
>>       dc->hotpluggable = false;
>> +    object_class_property_set_description(klass, /* 3.1 */
>> +                                          "ramfb",
>> +                                          "Add ramfb support");
>> +    object_class_property_set_description(klass, /* 8.2 */
>> +                                          "x-ramfb-migrate",
>> +                                          "Add ramfb migration support");
>> +
>>   }
>>   
>>   static const TypeInfo vfio_pci_nohotplug_dev_info = {
>> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
>> index 1070a2113a17edb9ebafb5066e51ee2bc52a767d..8e646e543692221e86b16fecd8bf40316f064a7d 100644
>> --- a/hw/vfio/platform.c
>> +++ b/hw/vfio/platform.c
>> @@ -674,6 +674,29 @@ static void vfio_platform_class_init(ObjectClass *klass, void *data)
>>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>>       /* Supported by TYPE_VIRT_MACHINE */
>>       dc->user_creatable = true;
>> +
>> +    object_class_property_set_description(klass, /* 2.4 */
>> +                                          "host",
>> +                                          "Host device name of assigned device");
>> +    object_class_property_set_description(klass, /* 2.6 */
>> +                                          "sysfsdev",
>> +                                          "Host sysfs path of assigned device");
>> +    object_class_property_set_description(klass, /* 2.4 and 2.5 */
>> +                                          "x-no-mmap",
>> +                                          "Disable MMAP for device. Allows to trace MMIO accesses");
>> +    object_class_property_set_description(klass, /* 2.4 */
>> +                                          "mmap-timeout-ms",
>> +                                          "Timeout value in milliseconds to re-enable BAR mapping");
>> +    object_class_property_set_description(klass, /* 2.4 */
>> +                                          "x-irqfd",
>> +                                          "Use irqfd for IRQ handling");
> nit: why not reorder by release of introduction then? Same for other
> devices.

Yep. I will do that in v3.


Thanks,

C.


> 
> Thanks
> 
> Eric
>> +
>> +#ifdef CONFIG_IOMMUFD
>> +    object_class_property_set_description(klass, /* 9.0 */
>> +                                          "iommufd",
>> +                                          "Set host IOMMUFD backend device ");
>> +#endif
>> +
>>   }
>>   
>>   static const TypeInfo vfio_platform_dev_info = {
> 


