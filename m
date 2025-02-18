Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DE8C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 15:34:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkPbB-0007o0-04; Tue, 18 Feb 2025 10:33:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tkPb8-0007js-JM
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:33:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tkPb5-0001Ln-CU
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:33:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739892796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ndU9Di4R2IqeGpbU5mghQBAF34rY0eKfLpIZvUobsEg=;
 b=jFE+07c3FGp32JtJLEHlQ9CLHlhsEx2brnQHaUNoeSL9jcqs4PVrvzzLQag5FhblsaKWQe
 KuW3IEaOrtu3Chax3odoAdnwWZQTvvrz2DA161dQ8mqj+Q7ALuH7GcuyMZbDRFq3KZM3ei
 F6k9jI+si4YK0CLFK1c3Fnqkt7Am9vw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448--EjVF0QrN0GkqFWmYFMu-Q-1; Tue, 18 Feb 2025 10:33:10 -0500
X-MC-Unique: -EjVF0QrN0GkqFWmYFMu-Q-1
X-Mimecast-MFC-AGG-ID: -EjVF0QrN0GkqFWmYFMu-Q_1739892789
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4393e8738b3so47196285e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 07:33:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739892789; x=1740497589;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ndU9Di4R2IqeGpbU5mghQBAF34rY0eKfLpIZvUobsEg=;
 b=fLbjRncb1mJ158EIyQmLysmEmlLT8+15P3Mcby2MujL0GR/mjen/TmT4ki5ZlLUaUH
 ElU3vTDWR7pHa331T2MxELuszjG+vh+O2jOqoti7C4hMbgR4SEGxvWKr/vjWjSSy9dAe
 mqjKNgwqD3bFQrz15rrKf8djoiPnMyRZtg58FQ52zS/jA91ro6CTHsbud2NwhZ9RI1M1
 VKcV2hM0GQvNDyE+jG222gBQWgycDF+TaUKIfq6pIqkKzWDVU7GxgUSx+K/8oF7buJjm
 QwbcsPBcP9JTjXRJJcZtAFNwnjCWTctrQObAjO8IaFzkifuqFy49aaayslFE9qqisj5g
 OZ+Q==
X-Gm-Message-State: AOJu0YxAshjLsuI3XbSVrsjx7qLbf1IrDoTdXoMqdaQWykSMTr7YUidK
 96f0zwoOUroK2cI3GLgn3T1ZTNQf7eDkXKV0tpbURVoYATO98qg0m/OAl2TDEAB/5xuP1sOlALj
 M/zhoyJZLGqQAInT0j4XNFr2QNf5OWoZHMJZd2VBZ2v4B1ZuD2zVQ
X-Gm-Gg: ASbGncu4BzfG9GaWWQ1AuAboRvQ5BupOSrSeUrtOhiFWkwPvvnYHS/1NAXiFrhNmJlA
 7Rc+6OSjOG58XJXrko8peLWkdbsA8TFmTsrl0QZUKjHwahOwuom6cQq+oyxO8QgwBPoOVAIuEpV
 DlE9rq01Ojso5Y7A+FZePG3STHLPwRGxmFjaENmr14ZNQn/OFPTcUByod3IFMzsVh64dOEYuaAz
 yc4pC52x1k1qXV1Wz0w+pS9DR0ztQ+80KBAUS9orETfTr6zVqtT0f5ebfdbkY/zJ6892FY99tUd
 Z3Vus0Nh7S0ty+8bEEG1GUST6vMZ0kXkZGHn7Ewi
X-Received: by 2002:a05:600c:3ba6:b0:439:91dd:cfaf with SMTP id
 5b1f17b1804b1-43999da55damr753005e9.18.1739892788631; 
 Tue, 18 Feb 2025 07:33:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5qogONL/NH/4InurLRw8dJUV0dShaFxnj/mAb8SC8CvHqmz5d/xvEhM9/HANvzjhuYaKoQQ==
X-Received: by 2002:a05:600c:3ba6:b0:439:91dd:cfaf with SMTP id
 5b1f17b1804b1-43999da55damr752675e9.18.1739892788166; 
 Tue, 18 Feb 2025 07:33:08 -0800 (PST)
Received: from ?IPV6:2a01:e0a:165:d60:38c8:6df5:c9ca:a366?
 ([2a01:e0a:165:d60:38c8:6df5:c9ca:a366])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4398e35c522sm38174595e9.34.2025.02.18.07.33.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 07:33:07 -0800 (PST)
Message-ID: <d66ad60f-fea0-4781-b1ae-0b5a59756811@redhat.com>
Date: Tue, 18 Feb 2025 16:33:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] vfio: Add property documentation
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, tomitamoeko@gmail.com, corvin.koehne@gmail.com,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Eric Auger <eric.auger@redhat.com>
References: <20250217173455.449983-1-clg@redhat.com>
 <20250218081955.50c733fb.alex.williamson@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250218081955.50c733fb.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/18/25 16:19, Alex Williamson wrote:
> On Mon, 17 Feb 2025 18:34:55 +0100
> Cédric Le Goater <clg@redhat.com> wrote:
> 
>> Investigate the git history to uncover when and why the VFIO
>> properties were introduced and update the models. This is mostly
>> targeting vfio-pci device, since vfio-platform, vfio-ap and vfio-ccw
>> devices are simpler.
>>
>> Sort the properties based on the QEMU version in which they were
>> introduced.
>>
>> Cc: Tony Krowiak <akrowiak@linux.ibm.com>
>> Cc: Eric Farman <farman@linux.ibm.com>
>> Cc: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>
>>   Should we introduce documentation for properties like the kernel has
>>   in Documentation/ABI/*/sysfs-* ?
>>
>>   Changes in v4:
>>
>>   - Latest improvements from Alex
>>
>>   Changes in v3:
>>
>>   - Re-organized the vfio-pci properties based on the QEMU version in
>>     which they were introduced
>>   - Added property labels
>>   - Improved description as suggested by Alex, Tomita and Corvin
>>
>>   Changes in v2:
>>
>>   - Fixed version numbers
>>   - Fixed #ifdef in vfio/ccw.c
>>   - Addressed vfio-pci-nohotplug
>>   - Organize the vfio-pci properties in topics
>>
>>   hw/vfio/ap.c       |   9 ++++
>>   hw/vfio/ccw.c      |  15 ++++++
>>   hw/vfio/pci.c      | 125 +++++++++++++++++++++++++++++++++++++++++++++
>>   hw/vfio/platform.c |  24 +++++++++
>>   4 files changed, 173 insertions(+)
>>
>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>> index 30b08ad375d5ecae886c5000fbaa364799fe76d0..c7ab4ff57ada0ed0e5a76f52b5a05c86ca4fe0b4 100644
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
>> +                                          "Set host IOMMUFD backend device");
>> +#endif
>>   }
>>   
>>   static const TypeInfo vfio_ap_info = {
>> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
>> index 6bb8882d3f2b965eb47cc9e65d7e74bbdb5e7685..e5e0d9e3e7ed124f242b3eda345bc973e418a64c 100644
>> --- a/hw/vfio/ccw.c
>> +++ b/hw/vfio/ccw.c
>> @@ -709,6 +709,21 @@ static void vfio_ccw_class_init(ObjectClass *klass, void *data)
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
>> +                                          "Set host IOMMUFD backend device");
>> +#endif
>> +    object_class_property_set_description(klass, /* 9.2 */
>> +                                          "loadparm",
>> +                                          "Define which devices that can be used for booting");
>>   }
>>   
>>   static const TypeInfo vfio_ccw_info = {
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 89d900e9cf0ce364f7c813d81b0317bb3b3e80ca..4f92b50b133060c9199079a0ab620793ecdac0ee 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -3433,6 +3433,122 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
>>       pdc->exit = vfio_exitfn;
>>       pdc->config_read = vfio_pci_read_config;
>>       pdc->config_write = vfio_pci_write_config;
>> +
>> +    object_class_property_set_description(klass, /* 1.3 */
>> +                                          "host",
>> +                                          "Host PCI address [domain:]<bus:slot.function> of assigned device");
>> +    object_class_property_set_description(klass, /* 1.3 */
>> +                                          "x-intx-mmap-timeout-ms",
>> +                                          "When EOI is not provided by KVM/QEMU, wait time "
>> +                                          "(milliseconds) to re-enable device direct access "
>> +                                          "after INTx (DEBUG)");
>> +    object_class_property_set_description(klass, /* 1.5 */
>> +                                          "x-vga",
>> +                                          "Expose VGA address spaces for device");
>> +    object_class_property_set_description(klass, /* 2.3 */
>> +                                          "x-req",
>> +                                          "Disable device request notification support (DEBUG)");
>> +    object_class_property_set_description(klass, /* 2.4 and 2.5 */
>> +                                          "x-no-mmap",
>> +                                          "Disable MMAP for device. Allows to trace MMIO "
>> +                                          "accesses (DEBUG)");
>> +    object_class_property_set_description(klass, /* 2.5 */
>> +                                          "x-no-kvm-intx",
>> +                                          "Disable direct VFIO->KVM INTx injection. Allows to "
>> +                                          "trace INTx interrupts (DEBUG)");
>> +    object_class_property_set_description(klass, /* 2.5 */
>> +                                          "x-no-kvm-msi",
>> +                                          "Disable direct VFIO->KVM MSI injection. Allows to "
>> +                                          "trace MSI interrupts (DEBUG)");
>> +    object_class_property_set_description(klass, /* 2.5 */
>> +                                          "x-no-kvm-msix",
>> +                                          "Disable direct VFIO->KVM MSIx injection. Allows to "
>> +                                          "trace MSIx interrupts (DEBUG)");
>> +    object_class_property_set_description(klass, /* 2.5 */
>> +                                          "x-pci-vendor-id",
>> +                                          "Override PCI Vendor ID with provided value (DEBUG)");
>> +    object_class_property_set_description(klass, /* 2.5 */
>> +                                          "x-pci-device-id",
>> +                                          "Override PCI device ID with provided value (DEBUG)");
> 
> nit for consistency, s/device/Device/  Otherwise:


Fixed
  
> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


Applied to vfio-next.

Thanks,

C.



> 
> 
>> +    object_class_property_set_description(klass, /* 2.5 */
>> +                                          "x-pci-sub-vendor-id",
>> +                                          "Override PCI Subsystem Vendor ID with provided value "
>> +                                          "(DEBUG)");
>> +    object_class_property_set_description(klass, /* 2.5 */
>> +                                          "x-pci-sub-device-id",
>> +                                          "Override PCI Subsystem Device ID with provided value "
>> +                                          "(DEBUG)");
>> +    object_class_property_set_description(klass, /* 2.6 */
>> +                                          "sysfsdev",
>> +                                          "Host sysfs path of assigned device");
>> +    object_class_property_set_description(klass, /* 2.7 */
>> +                                          "x-igd-opregion",
>> +                                          "Expose host IGD OpRegion to guest");
>> +    object_class_property_set_description(klass, /* 2.7 (See c4c45e943e51) */
>> +                                          "x-igd-gms",
>> +                                          "Override IGD data stolen memory size (32MiB units)");
>> +    object_class_property_set_description(klass, /* 2.11 */
>> +                                          "x-nv-gpudirect-clique",
>> +                                          "Add NVIDIA GPUDirect capability indicating P2P DMA "
>> +                                          "clique for device [0-15]");
>> +    object_class_property_set_description(klass, /* 2.12 */
>> +                                          "x-no-geforce-quirks",
>> +                                          "Disable GeForce quirks (for NVIDIA Quadro/GRID/Tesla). "
>> +                                          "Improves performance");
>> +    object_class_property_set_description(klass, /* 2.12 */
>> +                                          "display",
>> +                                          "Enable display support for device, ex. vGPU");
>> +    object_class_property_set_description(klass, /* 2.12 */
>> +                                          "x-msix-relocation",
>> +                                          "Specify MSI-X MMIO relocation to the end of specified "
>> +                                          "existing BAR or new BAR to avoid virtualization overhead "
>> +                                          "due to adjacent device registers");
>> +    object_class_property_set_description(klass, /* 3.0 */
>> +                                          "x-no-kvm-ioeventfd",
>> +                                          "Disable registration of ioeventfds with KVM (DEBUG)");
>> +    object_class_property_set_description(klass, /* 3.0 */
>> +                                          "x-no-vfio-ioeventfd",
>> +                                          "Disable linking of KVM ioeventfds to VFIO ioeventfds "
>> +                                          "(DEBUG)");
>> +    object_class_property_set_description(klass, /* 3.1 */
>> +                                          "x-balloon-allowed",
>> +                                          "Override allowing ballooning with device (DEBUG, DANGER)");
>> +    object_class_property_set_description(klass, /* 3.2 */
>> +                                          "xres",
>> +                                          "Set X display resolution the vGPU should use");
>> +    object_class_property_set_description(klass, /* 3.2 */
>> +                                          "yres",
>> +                                          "Set Y display resolution the vGPU should use");
>> +    object_class_property_set_description(klass, /* 5.2 */
>> +                                          "x-pre-copy-dirty-page-tracking",
>> +                                          "Disable dirty pages tracking during iterative phase "
>> +                                          "(DEBUG)");
>> +    object_class_property_set_description(klass, /* 5.2, 8.0 non-experimetal */
>> +                                          "enable-migration",
>> +                                          "Enale device migration. Also requires a host VFIO PCI "
>> +                                          "variant or mdev driver with migration support enabled");
>> +    object_class_property_set_description(klass, /* 8.1 */
>> +                                          "vf-token",
>> +                                          "Specify UUID VF token. Required for VF when PF is owned "
>> +                                          "by another VFIO driver");
>> +#ifdef CONFIG_IOMMUFD
>> +    object_class_property_set_description(klass, /* 9.0 */
>> +                                          "iommufd",
>> +                                          "Set host IOMMUFD backend device");
>> +#endif
>> +    object_class_property_set_description(klass, /* 9.1 */
>> +                                          "x-device-dirty-page-tracking",
>> +                                          "Disable device dirty page tracking and use "
>> +                                          "container-based dirty page tracking (DEBUG)");
>> +    object_class_property_set_description(klass, /* 9.1 */
>> +                                          "migration-events",
>> +                                          "Emit VFIO migration QAPI event when a VFIO device "
>> +                                          "changes its migration state. For management applications");
>> +    object_class_property_set_description(klass, /* 9.1 */
>> +                                          "skip-vsc-check",
>> +                                          "Skip config space check for Vendor Specific Capability. "
>> +                                          "Setting to false will enforce strict checking of VSC content "
>> +                                          "(DEBUG)");
>>   }
>>   
>>   static const TypeInfo vfio_pci_dev_info = {
>> @@ -3461,6 +3577,15 @@ static void vfio_pci_nohotplug_dev_class_init(ObjectClass *klass, void *data)
>>   
>>       device_class_set_props(dc, vfio_pci_dev_nohotplug_properties);
>>       dc->hotpluggable = false;
>> +
>> +    object_class_property_set_description(klass, /* 3.1 */
>> +                                          "ramfb",
>> +                                          "Enable ramfb to provide pre-boot graphics for devices "
>> +                                          "enabling display option");
>> +    object_class_property_set_description(klass, /* 8.2 */
>> +                                          "x-ramfb-migrate",
>> +                                          "Override default migration support for ramfb support "
>> +                                          "(DEBUG)");
>>   }
>>   
>>   static const TypeInfo vfio_pci_nohotplug_dev_info = {
>> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
>> index f491f4dc9543c2ea3a7af4e51ee82fbc7ee6e4bb..d9faaa73959ad36aa3a835b87964ab940928bd9f 100644
>> --- a/hw/vfio/platform.c
>> +++ b/hw/vfio/platform.c
>> @@ -672,6 +672,30 @@ static void vfio_platform_class_init(ObjectClass *klass, void *data)
>>       dc->desc = "VFIO-based platform device assignment";
>>       sbc->connect_irq_notifier = vfio_start_irqfd_injection;
>>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>> +
>> +    object_class_property_set_description(klass, /* 2.4 */
>> +                                          "host",
>> +                                          "Host device name of assigned device");
>> +    object_class_property_set_description(klass, /* 2.4 and 2.5 */
>> +                                          "x-no-mmap",
>> +                                          "Disable MMAP for device. Allows to trace MMIO "
>> +                                          "accesses (DEBUG)");
>> +    object_class_property_set_description(klass, /* 2.4 */
>> +                                          "mmap-timeout-ms",
>> +                                          "When EOI is not provided by KVM/QEMU, wait time "
>> +                                          "(milliseconds) to re-enable device direct access "
>> +                                          "after level interrupt (DEBUG)");
>> +    object_class_property_set_description(klass, /* 2.4 */
>> +                                          "x-irqfd",
>> +                                          "Allow disabling irqfd support (DEBUG)");
>> +    object_class_property_set_description(klass, /* 2.6 */
>> +                                          "sysfsdev",
>> +                                          "Host sysfs path of assigned device");
>> +#ifdef CONFIG_IOMMUFD
>> +    object_class_property_set_description(klass, /* 9.0 */
>> +                                          "iommufd",
>> +                                          "Set host IOMMUFD backend device");
>> +#endif
>>   }
>>   
>>   static const TypeInfo vfio_platform_dev_info = {
> 


