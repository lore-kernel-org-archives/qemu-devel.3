Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F3DC3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 18:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKLXt-0001tY-DT; Wed, 28 May 2025 14:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1uKLXr-0001tD-My
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:30:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1uKLXp-0006r4-CO
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748457026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jkRilHRpRbJEHAR7sOU/qo6TZFdvmWpZNOGWlrigNQo=;
 b=VA9ULUSXn7c/Qu2I4yQ8UcJUVCFZGQMoYojEG5zzdMs3G3FJNcuE9JI5SeHBY/ZbIaIrqC
 LwRuW8JuR9qbRXIgV1RLHEqkgQtzAYdMKZCr9W217gLa6ZesTViUhHIcy5zbT36oZMnhG6
 TkYudGZTMCkkq2hk4Vfm3w6D9jLHfMg=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-wXRbBSIINuCHZzszFcT13g-1; Wed, 28 May 2025 14:30:24 -0400
X-MC-Unique: wXRbBSIINuCHZzszFcT13g-1
X-Mimecast-MFC-AGG-ID: wXRbBSIINuCHZzszFcT13g_1748457024
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-3dd756e44bcso177755ab.2
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 11:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748457024; x=1749061824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jkRilHRpRbJEHAR7sOU/qo6TZFdvmWpZNOGWlrigNQo=;
 b=UwsdZ3USAh+HbucgtpJTmOGxWz6+9ma7oaqJdJW5Rqj5ouE+zx8l+pzjcoOMkTX85h
 hTF2aYVwgoKa3c3c6n0512B7QQkBPpNpITcQ3r7ShLIjaer7vQthL50q6IWVMrB5kMGq
 /F4Gir8lAmijkq2hOPDLx8iyKaS3Sit8nghZt+l/9L07YK9uHOUNB+pRCdKGfsT1FnID
 IEMrCOhoqaXcHiU7mPWbPjDzI30n+vKeh0W9KykpxiPh6eVPa6iitfC66QnA5m9N/mQ3
 caLGZoAeVrnz6yKd5mcPn/ZItMlXuzs8Z5Pbj/w6f6tBeMANpsI8mXy/COuG8kU7msIC
 mmhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsD1a4A6eo/oUglsXqFAKWmuL4VG4L79qlQShLXtLUv39CoaB+1KaWQMiyLxXMnNTSwBoVIvSGUh2Z@nongnu.org
X-Gm-Message-State: AOJu0YyPGfunx8r7TqNslbv7+SCctV4ghD7AKiViuduCypvIJfK5sv03
 Cd31JW5+ra5g2XWfGQVmLDgTzh5LYPEI6VhKrW33yt3808J9l7rWcPcJ6PJNVf2n0cMigjNiZTI
 c5n2v4yQBBo3GeOhQ0tIHgPFpTpWAn798Pd4iB7YH0XGUI/5politSuzo
X-Gm-Gg: ASbGnctCPi/j6owv+mTjZqanVPfyT5Zvs57regN7LTuVXWS3u/OrfbkDxyfbeGUhO1V
 bEWYXZ4LpyfTTaBSihlEV3bu+pBtA9JbBa+pZcOGSFRnRFxWCTbNAUgytqTaKhC8odLU6S1I123
 bA9leY1HnpGUzK8lpQdmIQj633Wab+8Lqu+PvrqYDToN54wKaDlekkuecrxNhZ+tyl5Aw1pmrlP
 oudmVXo7dKAYDaAk0ANREu/UK79y4TGQHfmInNcUodDeYDbJZi1uH5/5ED434nDdwmM1iJfDFjz
 Hj6qmQCZyl5Cnpc=
X-Received: by 2002:a05:6e02:2403:b0:3dc:8a5f:7ccb with SMTP id
 e9e14a558f8ab-3dc9b546ec9mr54986255ab.0.1748457023613; 
 Wed, 28 May 2025 11:30:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7PYSKlhIbVOF+eesrdazasjG6Z/yQ5tmLiqT18UPJJOGlx5WOkJzU3COuL6e/MithmJ6+2A==
X-Received: by 2002:a05:6e02:2403:b0:3dc:8a5f:7ccb with SMTP id
 e9e14a558f8ab-3dc9b546ec9mr54985995ab.0.1748457023142; 
 Wed, 28 May 2025 11:30:23 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fdbd495bfdsm340297173.7.2025.05.28.11.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 11:30:22 -0700 (PDT)
Date: Wed, 28 May 2025 12:30:19 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] vfio/pci: Introduce x-pci-class-code option
Message-ID: <20250528123019.5ff938ed.alex.williamson@redhat.com>
In-Reply-To: <20250528155548.29344-1-tomitamoeko@gmail.com>
References: <20250528155548.29344-1-tomitamoeko@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
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

On Wed, 28 May 2025 23:55:48 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> Introduce x-pci-class-code option to allow users to override PCI class
> code of a device, similar to the existing x-pci-vendor-id option. Only
> the lower 24 bits of this option are used, though a uint32 is used here
> for determining whether the value is valid and set by user.
> 
> Additionally, to prevent exposing VGA ranges on non-VGA devices, the
> x-vga=on option requires x-pci-class-code is either unset or set to
> VGA controller class.
> 
> This is mainly intended for IGD devices that expose themselves either
> as VGA controller (primary display) or Display controller (non-primary
> display). The UEFI GOP driver depends on the device reporting a VGA
> controller class code (0x030000).
> 
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
> v2:
> * Add vdev class code check in vfio_populate_vga().
> * Fix type in trace-events.
> Link: https://lore.kernel.org/all/20250524153102.19747-1-tomitamoeko@gmail.com/
> 
>  hw/vfio/pci.c        | 25 +++++++++++++++++++++++++
>  hw/vfio/pci.h        |  1 +
>  hw/vfio/trace-events |  1 +
>  3 files changed, 27 insertions(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index b1250d85bf..d57cb7356e 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2726,6 +2726,14 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
>          return false;
>      }
>  
> +    /* vdev class should be either unmodified (PCI_ANY_ID), or VGA controller */
> +    if ((vdev->class_code != PCI_ANY_ID) &&
> +        (vdev->class_code != (PCI_CLASS_DISPLAY_VGA << 8)) &&
> +        (vdev->class_code != (PCI_CLASS_NOT_DEFINED_VGA << 8))) {
> +        error_setg(errp, "vdev is not a VGA device");
> +        return false;
> +    }

I think we should follow the scheme used for vendor_id and device_id to
populate the struct field when not specified.  That let's us use it
more easily and consistently for things like this.

I think we can ignore PCI_CLASS_NOT_DEFINED_VGA.  The PCI Local Bus
Specification 2.1, dated June 1, 1995 (earliest I can find on the SIG)
includes the VGA class code and specifies base class 0x00 is reserved
for compatibility with devices built before the base class field was
defined, so at least before 1995.  Also, neither the kernel or QEMU
is_vga helpers account for this, so they'd not have a VGA region or be
properly detected elsewhere.  Thanks,

Alex

> +
>      if (!(reg_info->flags & VFIO_REGION_INFO_FLAG_READ) ||
>          !(reg_info->flags & VFIO_REGION_INFO_FLAG_WRITE) ||
>          reg_info->size < 0xbffff + 1) {
> @@ -3092,6 +3100,21 @@ static bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
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
> @@ -3489,6 +3512,8 @@ static const Property vfio_pci_dev_properties[] = {
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
> index e90ec9bff8..e8d585b49a 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -46,6 +46,7 @@ vfio_pci_emulated_vendor_id(const char *name, uint16_t val) "%s 0x%04x"
>  vfio_pci_emulated_device_id(const char *name, uint16_t val) "%s 0x%04x"
>  vfio_pci_emulated_sub_vendor_id(const char *name, uint16_t val) "%s 0x%04x"
>  vfio_pci_emulated_sub_device_id(const char *name, uint16_t val) "%s 0x%04x"
> +vfio_pci_emulated_class_code(const char *name, uint32_t val) "%s 0x%06x"
>  
>  # pci-quirks.c
>  vfio_quirk_rom_in_denylist(const char *name, uint16_t vid, uint16_t did) "%s %04x:%04x"


