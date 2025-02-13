Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055DBC0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 14:46:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiaTF-0000iN-TC; Thu, 13 Feb 2025 09:45:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tiaTD-0000iA-UV
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:45:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tiaTB-00022e-OY
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:45:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739457935;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uiy3fDmO+0dpJXKz2kH9WN67jyyv+7Y1Qch1Tu+/L6g=;
 b=fsCDtI1y4GnPVLClvD4tzL4hfqiWiBos80MOXpxPT6EX5qfU46nb/z16NyyUwB9OT2CYOx
 WbVAq4DO9n4T2Wc9XBPYVotJEircMnN3VDOr11nXkSdAXjQN2lAD+bq8Sd178WocpP5dCh
 i6K4DWHBGr25XuMP5Trheu5WxNd5OtU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-fexflc1IMiizym7dsSuJKw-1; Thu, 13 Feb 2025 09:45:34 -0500
X-MC-Unique: fexflc1IMiizym7dsSuJKw-1
X-Mimecast-MFC-AGG-ID: fexflc1IMiizym7dsSuJKw
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4393e89e910so5364875e9.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 06:45:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739457933; x=1740062733;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uiy3fDmO+0dpJXKz2kH9WN67jyyv+7Y1Qch1Tu+/L6g=;
 b=m8vgrsw0Q9qXrYisAAJTz0DZXJh/08T45MFE40z1SyHHp3ioWv15giSNZK9V6vkC3f
 K51ypQvf++HcVcJhKETxQRZzkI5ulWS7xSYFswZFHaTR8NMzT0f2+9ChC9G0kWeBmBJQ
 qarqAJtmKJi+oG6Bq+RZWtaYD4iUvqUVZZDkBZCRdpd3w9q7Ux+uEXkUDEOdvSc8dkOG
 hTtRZddSml1LNtSuGxBe9NK7uI5ZrIi0PSYVMSAoG9UDA0qX+CADVsU8brxOlq+wCUSr
 nQxklXk+jHAEyUOYFR100DPXOasDnBeFMLULZtGyko9KwxLWUael0T9zbYiuTIr7/ADj
 qrBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVIEax06LPnyId4tTjgJ6shP1JrjsUWh4bYMQp+Uxtboop1eADkVtdgX75yQEdTOwHjY08zaXnd4L3@nongnu.org
X-Gm-Message-State: AOJu0YzqmtoyZWybavAIQQkPxg0bTfqiQHOZ5VqkLlvCyS3/dHccM/wQ
 1fM7sRqh3t7cSW6l84Bn7lp0Xeyhc9POpyrbJ19KnnysMCndfwTisw7QUs23TNpi9oCoWvwSA73
 pXt58OhxWweX+Y3otmizBhSKI42CNEZM+ZVUjgeNaKajFh+y7bIRS
X-Gm-Gg: ASbGncvTBnPdBfsZgFws3wwR2xSYjxZQiynA97sWjEDMunPogn3dPyn8CZe6shVF+TU
 o62A0QkfqNRgz91j9E9wO6A0wn3QFp6cfzJca8DKJm5rXwdkqRRs0wuGRYQbW/M0u3oIHzMSAcC
 sV7GJOdMleYcSHXAS+Ow81394TuORdemqyV/PkFoiSj7xyhCfdzJ2Xy26wZFjvEKNfuJ65rhW6k
 ojpmT2fxIkMByFELaNtUjfZCEvcv73MKSGZnHt3kemAWJJhsd6Gel02ULW5AwkBX0XzxpRJIuSr
 zcnIIB27y1YOTDWLCtuelHnoQPvEInPDWP22IPlWfd6awoJNlQa/
X-Received: by 2002:a05:600c:8509:b0:439:3c71:16a6 with SMTP id
 5b1f17b1804b1-439601af46cmr47333275e9.29.1739457932974; 
 Thu, 13 Feb 2025 06:45:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAe3Zb+/Gn4R089ysba+qb+ER1JAnp+ElpU9I3/2l5gJ75WtP8jQQuuuwgu7jyCEvS3TjgCg==
X-Received: by 2002:a05:600c:8509:b0:439:3c71:16a6 with SMTP id
 5b1f17b1804b1-439601af46cmr47332585e9.29.1739457932487; 
 Thu, 13 Feb 2025 06:45:32 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a04f208sm50595605e9.6.2025.02.13.06.45.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 06:45:31 -0800 (PST)
Message-ID: <a5c82242-0a1d-46ca-9773-4a80d706e64f@redhat.com>
Date: Thu, 13 Feb 2025 15:45:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio: Add property documentation
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
References: <20250213135050.1426258-1-clg@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250213135050.1426258-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Cédric,


On 2/13/25 2:50 PM, Cédric Le Goater wrote:
> Investigate the git history to uncover when and why the VFIO
> properties were introduced and update the models. This is mostly
> targeting vfio-pci device, since vfio-plateform, vfio-ap and vfio-ccw
> devices are simpler.
>
> Organize the vfio-pci properties in topics. It would be great to have
> a way to do the same for the output.
>
> Cc: Tony Krowiak <akrowiak@linux.ibm.com>
> Cc: Eric Farman <farman@linux.ibm.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>
>  Changes in v2:
>
>  - Fixed version numbers
>  - Fixed #ifdef in vfio/ccw.c
>  - Addressed vfio-pci-nohotplug
>  - Organize the vfio-pci properties in topics
>
>  hw/vfio/ap.c       |   9 +++
>  hw/vfio/ccw.c      |  15 +++++
>  hw/vfio/pci.c      | 134 +++++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/platform.c |  23 ++++++++
>  4 files changed, 181 insertions(+)
>
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 30b08ad375d5ecae886c5000fbaa364799fe76d0..ec1150e5d627fce83a5a6319af471fd0aa45ae9b 100644
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
> +                                          "Set host IOMMUFD backend device ");
> +#endif
>  }
>  
>  static const TypeInfo vfio_ap_info = {
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 67bc137f9be6d43c5970c6271f3cdbfffd8a32de..242dc39660fcd028722093d637b7b64440649863 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -717,6 +717,21 @@ static void vfio_ccw_class_init(ObjectClass *klass, void *data)
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
> +                                          "Set host IOMMUFD backend device ");
> +#endif
> +    object_class_property_set_description(klass, /* 9.2 */
> +                                          "loadparm",
> +                                          "Define which devices that can be used for booting");
>  }
>  
>  static const TypeInfo vfio_ccw_info = {
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 9a55e7b77324babf7295132b08e3ba23b482a291..fbd8cf566b1cfd508ccb0042a395e3b79ba781c0 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3433,6 +3433,133 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
>      pdc->exit = vfio_exitfn;
>      pdc->config_read = vfio_pci_read_config;
>      pdc->config_write = vfio_pci_write_config;
> +
> +    object_class_property_set_description(klass, /* 1.3 */
> +                                          "host",
> +                                          "Host PCI address [domain:]<bus:slot.function> of assigned device");
> +    object_class_property_set_description(klass, /* 2.6 */
> +                                          "sysfsdev",
> +                                          "Host sysfs path of assigned device");
> +    /*
> +     * Display
> +     */
> +
> +    object_class_property_set_description(klass, /* 1.5 */
> +                                          "x-vga",
> +                                          "Add support for VGA MMIO and I/O port access");
> +    object_class_property_set_description(klass, /* 2.12 */
> +                                          "display",
> +                                          "Add display support");
> +    object_class_property_set_description(klass, /* 3.2 */
> +                                          "xres",
> +                                          "Set X display resolution the vgpu should use");
> +    object_class_property_set_description(klass, /* 3.2 */
> +                                          "yres",
> +                                          "Set Y display resolution the vgpu should use");
> +
> +    /*
> +     * IGD
> +     */
> +
> +    object_class_property_set_description(klass, /* 2.7 */
> +                                          "x-igd-opregion",
> +                                          "Add IGD OpRegion support for (headless system)");
> +    object_class_property_set_description(klass, /* 2.7 (See c4c45e943e51) */
> +                                          "x-igd-gms",
> +                                          "Add Intel graphics legacy mode device assignment support. "
> +                                          "Assign 00:02.0 from the host to 00:02.0 in the VM");
> +
> +    /*
> +     * NVIDIA
> +     */
> +    object_class_property_set_description(klass, /* 2.12 */
> +                                          "x-no-geforce-quirks",
> +                                          "Disable GeForce quirks (for NVIDIA Quadro/GRID/Tesla). Improves performance");
> +    object_class_property_set_description(klass, /* 3.0 */
> +                                          "x-no-kvm-ioeventfd",
> +                                          "Disable ioeventfd quirk (NVIDIA)");
> +    object_class_property_set_description(klass, /* 3.0 */
> +                                          "x-no-vfio-ioeventfd",
> +                                          "Enable ioeventfd quirks to be handled by VFIO directly. Improves performance");
> +    object_class_property_set_description(klass, /* 2.11 */
> +                                          "x-nv-gpudirect-clique",
> +                                          "Add NVIDIA GPUDirect Cliques support");
> +
> +    /*
> +     * Migration support
> +     */
> +    object_class_property_set_description(klass, /* 5.2 */
> +                                          "x-pre-copy-dirty-page-tracking",
> +                                          "Disable dirty pages tracking during iterative phase");
> +    object_class_property_set_description(klass, /* 9.1 */
> +                                          "x-device-dirty-page-tracking",
> +                                          "Disable device dirty page tracking and use container-based dirty page tracking");
> +    object_class_property_set_description(klass, /* 5.2, 8.0 non-experimetal */
> +                                          "enable-migration",
> +                                          "Enale device migration. Also requires a host VFIO PCI variant "
> +                                          "driver with migration support enabled");
> +    object_class_property_set_description(klass, /* 9.1 */
> +                                          "migration-events",
> +                                          "Emit VFIO migration QAPI event when a VFIO device changes its migration "
> +                                          "state. For management applications");
> +    object_class_property_set_description(klass, /* 9.1 */
> +                                          "skip-vsc-check",
> +                                          "Skip config space check for Vendor Specific Capability. Useful for "
> +                                          "NVIDIA vGPU driver migration");
> +
> +    /*
> +     * debug, tracing
> +     */
> +    object_class_property_set_description(klass, /* 2.4 and 2.5 */
> +                                          "x-no-mmap",
> +                                          "Disable MMAP for device. Allows to trace MMIO accesses");
> +    object_class_property_set_description(klass, /* 2.5 */
> +                                          "x-no-kvm-intx",
> +                                          "Bypass INTx interrupts. Allows interrupt tracing");
> +    object_class_property_set_description(klass, /* 2.5 */
> +                                          "x-no-kvm-msi",
> +                                          "Bypass MSI interrupts. Allows interrupt tracing");
> +    object_class_property_set_description(klass, /* 2.5 */
> +                                          "x-no-kvm-msix",
> +                                          "Bypass MSIx interrupts. Allows interrupt tracing");
> +    object_class_property_set_description(klass, /* 2.5 */
> +                                          "x-pci-vendor-id",
> +                                          "Set emulated PCI Vendor ID. Allows testing quirks");
> +    object_class_property_set_description(klass, /* 2.5 */
> +                                          "x-pci-device-id",
> +                                          "Set emulated PCI device ID. Allows testing quirks");
> +
> +    /*
> +     * other
> +     */
> +    object_class_property_set_description(klass, /* 8.1 */
> +                                          "vf-token",
> +                                          "Add support for VF token among PF and VFs (Linux 5.7+)");
> +    object_class_property_set_description(klass, /* 1.3 */
> +                                          "x-intx-mmap-timeout-ms",
> +                                          "Timeout value in milliseconds to re-enable BAR mapping when under "
> +                                          "INTx interrupts. Improves performance");
> +    object_class_property_set_description(klass, /* 2.3 */
> +                                          "x-req",
> +                                          "Add device request notification support (Linux 4.0+)");
> +    object_class_property_set_description(klass, /* 3.1 */
> +                                          "x-balloon-allowed",
> +                                          "Allow devices to opt-in for ballooning");
> +    object_class_property_set_description(klass, /* 2.5 */
> +                                          "x-pci-sub-vendor-id",
> +                                          "Set emulated PCI Sub-vendor ID");
> +    object_class_property_set_description(klass, /* 2.5 */
> +                                          "x-pci-sub-device-id",
> +                                          "Set emulated PCI Sub-device ID");
> +    object_class_property_set_description(klass, /* 2.12 */
> +                                          "x-msix-relocation",
> +                                          "Allow relocating MSI-X MMIO on systems which page size is larger "
> +                                          "than the PCI spec recommendation. Mostly for sPAPR");
> +#ifdef CONFIG_IOMMUFD
> +    object_class_property_set_description(klass, /* 9.0 */
> +                                          "iommufd",
> +                                          "Set host IOMMUFD backend device ");
> +#endif
>  }
>  
>  static const TypeInfo vfio_pci_dev_info = {
> @@ -3461,6 +3588,13 @@ static void vfio_pci_nohotplug_dev_class_init(ObjectClass *klass, void *data)
>  
>      device_class_set_props(dc, vfio_pci_dev_nohotplug_properties);
>      dc->hotpluggable = false;
> +    object_class_property_set_description(klass, /* 3.1 */
> +                                          "ramfb",
> +                                          "Add ramfb support");
> +    object_class_property_set_description(klass, /* 8.2 */
> +                                          "x-ramfb-migrate",
> +                                          "Add ramfb migration support");
> +
>  }
>  
>  static const TypeInfo vfio_pci_nohotplug_dev_info = {
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index 1070a2113a17edb9ebafb5066e51ee2bc52a767d..8e646e543692221e86b16fecd8bf40316f064a7d 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -674,6 +674,29 @@ static void vfio_platform_class_init(ObjectClass *klass, void *data)
>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>      /* Supported by TYPE_VIRT_MACHINE */
>      dc->user_creatable = true;
> +
> +    object_class_property_set_description(klass, /* 2.4 */
> +                                          "host",
> +                                          "Host device name of assigned device");
> +    object_class_property_set_description(klass, /* 2.6 */
> +                                          "sysfsdev",
> +                                          "Host sysfs path of assigned device");
> +    object_class_property_set_description(klass, /* 2.4 and 2.5 */
> +                                          "x-no-mmap",
> +                                          "Disable MMAP for device. Allows to trace MMIO accesses");
> +    object_class_property_set_description(klass, /* 2.4 */
> +                                          "mmap-timeout-ms",
> +                                          "Timeout value in milliseconds to re-enable BAR mapping");
> +    object_class_property_set_description(klass, /* 2.4 */
> +                                          "x-irqfd",
> +                                          "Use irqfd for IRQ handling");
nit: why not reorder by release of introduction then? Same for other
devices.

Thanks

Eric
> +
> +#ifdef CONFIG_IOMMUFD
> +    object_class_property_set_description(klass, /* 9.0 */
> +                                          "iommufd",
> +                                          "Set host IOMMUFD backend device ");
> +#endif
> +
>  }
>  
>  static const TypeInfo vfio_platform_dev_info = {


