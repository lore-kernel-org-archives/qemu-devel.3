Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCC4E7718B
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jan 2025 09:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSvE5-0000jV-Tt; Wed, 01 Jan 2025 04:41:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tSvE4-0000j0-CC
 for qemu-devel@nongnu.org; Wed, 01 Jan 2025 04:41:16 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tSvE2-0000XL-3F
 for qemu-devel@nongnu.org; Wed, 01 Jan 2025 04:41:16 -0500
Received: by mail-pj1-x1041.google.com with SMTP id
 98e67ed59e1d1-2f4448bf96fso11047793a91.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jan 2025 01:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735724472; x=1736329272; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h09+K2O/uwP/e/0o7OKTrjxBVl1w5bpxRVKFtGTvo3g=;
 b=h5VfNARDP5L+TW8ofaa2lrbx+qN/0OX0c3/oU1+dEXOFh2AIZ8XS83uNnkoCMBasWC
 KTfIq33ydj0RVY6/sNMvEE1iROH8nNXw5iJ3HazAZovAwQHc0abdc8j8kQsMYfzEhJOf
 AtdNApOLKPinGZY6+MV2iDJHX5OA5bK8JCVz6YHjdrpuhQwRxgRyv0EU6C4+a2iG4VsS
 Z6h0ZCLvt7r11kgrQFaKRtNpO0IXAr6bOn6+q+9VNKQzKgX/gPaplNnyjzCZIc09Sql9
 ORO4VoPmPKKtZsu8PU9j460GxcCIs6I8jWVLF61neZ/Te8koFZvFtrsnd89f2uN49dfK
 UQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735724472; x=1736329272;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h09+K2O/uwP/e/0o7OKTrjxBVl1w5bpxRVKFtGTvo3g=;
 b=KUfPlT3Gj1IN//dmwXRqwarpADHx3HCghnVaKiBg2uS53foz5WVXKPBJgCYP478trg
 67wpztHjaNXMIVseAqQvg6LbkhFungKntMbxSRmKpmqAz7JRHI4A/V6Cj0ze2UrgHFc6
 434MVCxZvsUHZZJp6ihhxaPKJFUhL5d6CaIlfjc+twbWApto5AWf6HbzF8jJQbzaFuSv
 V3Pac6gjwZ5zTldYArbOjwwJzFlFS37T3N0JtnGWW9qv2F5bghaAcBySsuvRUSwczjRo
 rSXXiHgXZXq6rzV9Skcrzttw/BLX4TwN2L746AtlrfRnzpBF3px2swbfuZz+pFxytezf
 m22w==
X-Gm-Message-State: AOJu0YzTdEQuxcZYDN26PtArbHQeg0jcmq6uvNNskDnQh6V016Ks/HC8
 1QmKPiuFJf/VwKdNKzE6ZG8ffEQMHIpIK82CwpQniOmhPH/+jmo=
X-Gm-Gg: ASbGncuL0H3mMcSVK7zVim7XGAeD3RMfIVam4jvowLHYFqhsSQRCcfe7rwmRWAqCx8r
 T4GkmckNGf2PkpdMhui8+Zw+ANMdTQydJC90yebmbhmOZ7Flb8trlBDXU/6dyXKPNEAeB1B8fo2
 Jf02MIIqT9gqWEGRVr9wN7LLpJq+vjB4FSmXK11shuMRs0vo3TkPiHd5pwx2VzGnX5rQa0zW4mb
 iZYPf2QOVsT8PDjZIXg4+HzxYdOVq0JYuo95xyDlx0Tj559USyKqdEi4E/TuQ==
X-Google-Smtp-Source: AGHT+IGZyMb6xdx099/oQsy7TOkYwZlX5JjuBRo7QZ7J6HxUKjq6jz7eLJl5pM4moSm+Zragi/68RQ==
X-Received: by 2002:a17:90b:270d:b0:2ee:48bf:7dc3 with SMTP id
 98e67ed59e1d1-2f452e1606amr66400351a91.15.1735724472453; 
 Wed, 01 Jan 2025 01:41:12 -0800 (PST)
Received: from [192.168.0.163] ([58.38.120.107])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ed644d87sm28509735a91.27.2025.01.01.01.41.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jan 2025 01:41:12 -0800 (PST)
Message-ID: <4cfa35a5-d2e1-4715-afd2-c32de0d21421@gmail.com>
Date: Wed, 1 Jan 2025 17:41:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] vfio/pci: declare generic quirks in a new header file
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20241231151953.59992-1-tomitamoeko@gmail.com>
 <20241231151953.59992-2-tomitamoeko@gmail.com>
Content-Language: en-US
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <20241231151953.59992-2-tomitamoeko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pj1-x1041.google.com
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



On 12/31/24 23:19, Tomita Moeko wrote:
> Declare generic vfio_generic_{window_address,window_data,mirror}_quirk
> in newly created pci_quirks.h so that they can be used elsewhere, like
> igd.c.
> 
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
>  hw/vfio/pci-quirks.c | 59 ++++--------------------------------
>  hw/vfio/pci-quirks.h | 71 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 77 insertions(+), 53 deletions(-)
>  create mode 100644 hw/vfio/pci-quirks.h
> 
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index c8e60475d5..bb2ce1d904 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -25,6 +25,7 @@
>  #include "hw/nvram/fw_cfg.h"
>  #include "hw/qdev-properties.h"
>  #include "pci.h"
> +#include "pci-quirks.h"
>  #include "trace.h"
>  
>  /*
> @@ -66,40 +67,6 @@ bool vfio_opt_rom_in_denylist(VFIOPCIDevice *vdev)
>   * Device specific region quirks (mostly backdoors to PCI config space)
>   */
>  
> -/*
> - * The generic window quirks operate on an address and data register,
> - * vfio_generic_window_address_quirk handles the address register and
> - * vfio_generic_window_data_quirk handles the data register.  These ops
> - * pass reads and writes through to hardware until a value matching the
> - * stored address match/mask is written.  When this occurs, the data
> - * register access emulated PCI config space for the device rather than
> - * passing through accesses.  This enables devices where PCI config space
> - * is accessible behind a window register to maintain the virtualization
> - * provided through vfio.
> - */
> -typedef struct VFIOConfigWindowMatch {
> -    uint32_t match;
> -    uint32_t mask;
> -} VFIOConfigWindowMatch;
> -
> -typedef struct VFIOConfigWindowQuirk {
> -    struct VFIOPCIDevice *vdev;
> -
> -    uint32_t address_val;
> -
> -    uint32_t address_offset;
> -    uint32_t data_offset;
> -
> -    bool window_enabled;
> -    uint8_t bar;
> -
> -    MemoryRegion *addr_mem;
> -    MemoryRegion *data_mem;
> -
> -    uint32_t nr_matches;
> -    VFIOConfigWindowMatch matches[];
> -} VFIOConfigWindowQuirk;
> -
>  static uint64_t vfio_generic_window_quirk_address_read(void *opaque,
>                                                         hwaddr addr,
>                                                         unsigned size)
> @@ -135,7 +102,7 @@ static void vfio_generic_window_quirk_address_write(void *opaque, hwaddr addr,
>      }
>  }
>  
> -static const MemoryRegionOps vfio_generic_window_address_quirk = {
> +const MemoryRegionOps vfio_generic_window_address_quirk = {
>      .read = vfio_generic_window_quirk_address_read,
>      .write = vfio_generic_window_quirk_address_write,
>      .endianness = DEVICE_LITTLE_ENDIAN,
> @@ -178,26 +145,12 @@ static void vfio_generic_window_quirk_data_write(void *opaque, hwaddr addr,
>                        addr + window->data_offset, data, size);
>  }
>  
> -static const MemoryRegionOps vfio_generic_window_data_quirk = {
> +const MemoryRegionOps vfio_generic_window_data_quirk = {
>      .read = vfio_generic_window_quirk_data_read,
>      .write = vfio_generic_window_quirk_data_write,
>      .endianness = DEVICE_LITTLE_ENDIAN,
>  };
>  
> -/*
> - * The generic mirror quirk handles devices which expose PCI config space
> - * through a region within a BAR.  When enabled, reads and writes are
> - * redirected through to emulated PCI config space.  XXX if PCI config space
> - * used memory regions, this could just be an alias.
> - */
> -typedef struct VFIOConfigMirrorQuirk {
> -    struct VFIOPCIDevice *vdev;
> -    uint32_t offset;
> -    uint8_t bar;
> -    MemoryRegion *mem;
> -    uint8_t data[];
> -} VFIOConfigMirrorQuirk;
> -
>  static uint64_t vfio_generic_quirk_mirror_read(void *opaque,
>                                                 hwaddr addr, unsigned size)
>  {
> @@ -228,7 +181,7 @@ static void vfio_generic_quirk_mirror_write(void *opaque, hwaddr addr,
>                                            addr, data);
>  }
>  
> -static const MemoryRegionOps vfio_generic_mirror_quirk = {
> +const MemoryRegionOps vfio_generic_mirror_quirk = {
>      .read = vfio_generic_quirk_mirror_read,
>      .write = vfio_generic_quirk_mirror_write,
>      .endianness = DEVICE_LITTLE_ENDIAN,
> @@ -1499,7 +1452,7 @@ static void get_nv_gpudirect_clique_id(Object *obj, Visitor *v,
>                                         const char *name, void *opaque,
>                                         Error **errp)
>  {
> -    const Property *prop = opaque;
> +    Property *prop = opaque;

Sorry this was a mistake when I rebasing my changes. I will revert this in v2.

>      uint8_t *ptr = object_field_prop_ptr(obj, prop);
>  
>      visit_type_uint8(v, name, ptr, errp);
> @@ -1509,7 +1462,7 @@ static void set_nv_gpudirect_clique_id(Object *obj, Visitor *v,
>                                         const char *name, void *opaque,
>                                         Error **errp)
>  {
> -    const Property *prop = opaque;
> +    Property *prop = opaque;

ditto

>      uint8_t value, *ptr = object_field_prop_ptr(obj, prop);
>  
>      if (!visit_type_uint8(v, name, &value, errp)) {
> diff --git a/hw/vfio/pci-quirks.h b/hw/vfio/pci-quirks.h
> new file mode 100644
> index 0000000000..c0e96a01cc
> --- /dev/null
> +++ b/hw/vfio/pci-quirks.h
> @@ -0,0 +1,71 @@
> +/*
> + * vfio generic region quirks (mostly backdoors to PCI config space)
> + *
> + * Copyright Red Hat, Inc. 2012-2015
> + *
> + * Authors:
> + *  Alex Williamson <alex.williamson@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the COPYING file in the top-level directory.
> + */
> +#ifndef HW_VFIO_VFIO_PCI_QUIRKS_H
> +#define HW_VFIO_VFIO_PCI_QUIRKS_H
> +
> +#include "qemu/osdep.h"
> +#include "exec/memop.h"
> +
> +/*
> + * The generic window quirks operate on an address and data register,
> + * vfio_generic_window_address_quirk handles the address register and
> + * vfio_generic_window_data_quirk handles the data register.  These ops
> + * pass reads and writes through to hardware until a value matching the
> + * stored address match/mask is written.  When this occurs, the data
> + * register access emulated PCI config space for the device rather than
> + * passing through accesses.  This enables devices where PCI config space
> + * is accessible behind a window register to maintain the virtualization
> + * provided through vfio.
> + */
> +typedef struct VFIOConfigWindowMatch {
> +    uint32_t match;
> +    uint32_t mask;
> +} VFIOConfigWindowMatch;
> +
> +typedef struct VFIOConfigWindowQuirk {
> +    struct VFIOPCIDevice *vdev;
> +
> +    uint32_t address_val;
> +
> +    uint32_t address_offset;
> +    uint32_t data_offset;
> +
> +    bool window_enabled;
> +    uint8_t bar;
> +
> +    MemoryRegion *addr_mem;
> +    MemoryRegion *data_mem;
> +
> +    uint32_t nr_matches;
> +    VFIOConfigWindowMatch matches[];
> +} VFIOConfigWindowQuirk;
> +
> +extern const MemoryRegionOps vfio_generic_window_address_quirk;
> +extern const MemoryRegionOps vfio_generic_window_data_quirk;
> +
> +/*
> + * The generic mirror quirk handles devices which expose PCI config space
> + * through a region within a BAR.  When enabled, reads and writes are
> + * redirected through to emulated PCI config space.  XXX if PCI config space
> + * used memory regions, this could just be an alias.
> + */
> +typedef struct VFIOConfigMirrorQuirk {
> +    struct VFIOPCIDevice *vdev;
> +    uint32_t offset;
> +    uint8_t bar;
> +    MemoryRegion *mem;
> +    uint8_t data[];
> +} VFIOConfigMirrorQuirk;
> +
> +extern const MemoryRegionOps vfio_generic_mirror_quirk;
> +
> +#endif /* HW_VFIO_VFIO_PCI_QUIRKS_H */


