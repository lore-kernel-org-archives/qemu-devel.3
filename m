Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E54C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 18:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJzI8-0006hJ-7f; Tue, 27 May 2025 14:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1uJzI7-0006h5-Bk
 for qemu-devel@nongnu.org; Tue, 27 May 2025 14:44:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1uJzI4-0002m3-Iw
 for qemu-devel@nongnu.org; Tue, 27 May 2025 14:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748371481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8XiULHF74Ovmz3Q8cXZyaidbCYJBenNBgcJ7e9q2zNk=;
 b=gfBhPJ09kONGoqCssuvVkhBODBVglXhzJWMOkTE31hxufQmIJemeERtyWgKZGWgbAUjSIZ
 93rbrJxXg09u6KDBI19IvrpfvON5uXVOo2NSY1XSJR6RM50ejyIO68JEj7/D3/54FqWGqR
 o93+HwDBu4iQ0/UtXLsk6YXSSTXNnk0=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-i_MEyeoCOXqmFR5mfVk63A-1; Tue, 27 May 2025 14:44:39 -0400
X-MC-Unique: i_MEyeoCOXqmFR5mfVk63A-1
X-Mimecast-MFC-AGG-ID: i_MEyeoCOXqmFR5mfVk63A_1748371479
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-85b45e94b08so43068939f.0
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 11:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748371478; x=1748976278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8XiULHF74Ovmz3Q8cXZyaidbCYJBenNBgcJ7e9q2zNk=;
 b=L8FNdbWVFJ5yiu38iDbrvG16APAnFUfTfe+LtmiCEdbnVOa8ua/UGJDlcCs4yYhpfn
 J7cOVHreEhz96u0PVYfo6Kdc6JirmS9fd4c4cbVw6B7mmfnTpmuMFG8Yq/rZSDxRGVPK
 4AVnmqL+vdyHigXzPo9/i61Wa77KlhWQr8x1cHzYHvo5NGH4vOCeLa/ymEmjTqIhyeKN
 NPwcyO2JrHhTs4h2qEapP04+Yq28WkRP4+UC7aZpn4f+FyEUkWKgelZsw8uUww5SkdyG
 pzcZOrtvY+srP5AhCbnuqirXIHV319kSAVyRL8a6F2hB9KAyBdWwCONWQE7TwTZlx7qL
 DxCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgBR1TfDfPwjxJgw63FKaeqxMhwHdTiUXtH/kaQaj/mFkvStAN+B5x+EYZl5HryQSsurMu9emQ50db@nongnu.org
X-Gm-Message-State: AOJu0Yw1l1nebQwr/9TTXT1BcQnO+eokqAh3ox7ZhOB840o6GU3a84Uu
 asFlEbFyUq8ld9u9DrN0y4RUfPnNxjkEZTvTjaK/S+dRTt2TmudSawe8rURmKQEqyb4ik1wYj6t
 103dcRV5q0Dn6UqMte8ztbE/twM47ImhxHZwPXU9GrRb2Y3bv2/hrPUHH
X-Gm-Gg: ASbGncvScU4r2OHRKz/7mVz3lQpsePJV8AGI/jq8kv4LjI+15r2FhPdn1SaKVxyx17b
 2537peF/2vjcgnmnjjQa5hspgITOFxebz4XFJUq1dEtYcPszXKU4A5JUFkBhb1UIp89SsK0FFfl
 b6MJh+5tVB4zXamjglxhtM0UyEktImIk0lZrPiLyUiSk93ynHsZO7JZnGNiF2R9jw/b0JfsS7QB
 ptrz3igu9hxnH8XB9jZUYZPjrX9Gt9Oq5UxoRyvLEmPjoTY+x7eajiWE4RfsCVXs9vXF4GUAwug
 YxVYXXSpKmsmVug=
X-Received: by 2002:a05:6e02:160b:b0:3dc:7ba2:7a2e with SMTP id
 e9e14a558f8ab-3dc9b6e51d4mr35280105ab.3.1748371478597; 
 Tue, 27 May 2025 11:44:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHB/2EtU54VkxztbMQx8DzxGDZD6yvXNFJVd0Ea+ChAE3ohzOS5m/8z3l/avFd7n1TH6dXzrA==
X-Received: by 2002:a05:6e02:160b:b0:3dc:7ba2:7a2e with SMTP id
 e9e14a558f8ab-3dc9b6e51d4mr35280025ab.3.1748371478189; 
 Tue, 27 May 2025 11:44:38 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dca0d1d00esm20197595ab.13.2025.05.27.11.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 11:44:37 -0700 (PDT)
Date: Tue, 27 May 2025 12:44:35 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] vfio/pci: Introduce x-pci-class-code option
Message-ID: <20250527124435.4a0201c7.alex.williamson@redhat.com>
In-Reply-To: <20250524153102.19747-1-tomitamoeko@gmail.com>
References: <20250524153102.19747-1-tomitamoeko@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
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

On Sat, 24 May 2025 23:31:02 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> Introduce x-pci-class-code option to allow users to override PCI class
> code of a device, similar to the existing x-pci-vendor-id option. Only
> the lower 24 bits of this option are used, though a uint32 is used here
> for determining whether the value is valid and set by user.
> 
> This is mainly intended for IGD devices that expose themselves either
> as VGA controller (primary display) or Display controller (non-primary
> display). The UEFI GOP driver depends on the device reporting a VGA
> controller class code (0x030000).

Seems like a tricky one.  Arguably it's no more crazy than allowing
vendor and device ID overrides.  We're probably safe in the fact that
this is an experimental option (user keeps the pieces when it breaks)
and the obscurity of raw class values means it's unlikely to enter any
kind of common usage.

But, vfio_populate_vga() only cares that the device has a VGA region
because these only exist on VGA class devices.  With this we can assign
a VGA device, override the class code to Display, use x-vga=on, and now
we've got a mess of VGA access to a non-VGA device that doesn't make
any sense.  vfio_populate_vga() needs to care about the exposed class
code now too.  Thanks,

Alex

> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
>  hw/vfio/pci.c        | 17 +++++++++++++++++
>  hw/vfio/pci.h        |  1 +
>  hw/vfio/trace-events |  1 +
>  3 files changed, 19 insertions(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index a1bfdfe375..879347a54e 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3062,6 +3062,21 @@ static bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
>                                                vdev->sub_device_id);
>      }
>  
> +    /*
> +     * Class code is a 24-bit value at config space 0x09. Allow overriding it
> +     * with any 24-bit value.
> +     */
> +    if (vdev->class_code != PCI_ANY_ID) {
> +        if (vdev->class_code > 0xffffff) {
> +            error_setg(errp, "invalid PCI class code provided");
> +            return false;
> +        }
> +        /* Higher 24 bits of PCI_CLASS_REVISION are class code */
> +        vfio_add_emulated_long(vdev, PCI_CLASS_REVISION,
> +                               vdev->class_code << 8, ~0xff);
> +        trace_vfio_pci_emulated_class_code(vbasedev->name, vdev->class_code);
> +    }
> +
>      /* QEMU can change multi-function devices to single function, or reverse */
>      vdev->emulated_config_bits[PCI_HEADER_TYPE] =
>                                                PCI_HEADER_TYPE_MULTI_FUNCTION;
> @@ -3482,6 +3497,8 @@ static const Property vfio_pci_dev_properties[] = {
>                         sub_vendor_id, PCI_ANY_ID),
>      DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
>                         sub_device_id, PCI_ANY_ID),
> +    DEFINE_PROP_UINT32("x-pci-class-code", VFIOPCIDevice,
> +                       class_code, PCI_ANY_ID),
>      DEFINE_PROP_UINT32("x-igd-gms", VFIOPCIDevice, igd_gms, 0),
>      DEFINE_PROP_UNSIGNED_NODEFAULT("x-nv-gpudirect-clique", VFIOPCIDevice,
>                                     nv_gpudirect_clique,
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 5ce0fb916f..587eb8cc9a 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -156,6 +156,7 @@ struct VFIOPCIDevice {
>      uint32_t device_id;
>      uint32_t sub_vendor_id;
>      uint32_t sub_device_id;
> +    uint32_t class_code;
>      uint32_t features;
>  #define VFIO_FEATURE_ENABLE_VGA_BIT 0
>  #define VFIO_FEATURE_ENABLE_VGA (1 << VFIO_FEATURE_ENABLE_VGA_BIT)
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index e90ec9bff8..d0b006aa29 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -46,6 +46,7 @@ vfio_pci_emulated_vendor_id(const char *name, uint16_t val) "%s 0x%04x"
>  vfio_pci_emulated_device_id(const char *name, uint16_t val) "%s 0x%04x"
>  vfio_pci_emulated_sub_vendor_id(const char *name, uint16_t val) "%s 0x%04x"
>  vfio_pci_emulated_sub_device_id(const char *name, uint16_t val) "%s 0x%04x"
> +vfio_pci_emulated_class_code(const char *name, uint16_t val) "%s 0x%06x"
>  
>  # pci-quirks.c
>  vfio_quirk_rom_in_denylist(const char *name, uint16_t vid, uint16_t did) "%s %04x:%04x"


