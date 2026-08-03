Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74841C55196
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 22:10:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr0rn-0007DN-HZ; Mon, 03 Aug 2026 18:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wr0rh-0007Cr-Pt
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 18:10:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wr0rf-0001KV-0B
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 18:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785795030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GsILbCg/L3lbT/ZcN2MQ2CJjY3WSErCj8bnJKzdOR9E=;
 b=UrrDYOxom21DRyvl+fXK8srIdSdvgtK7/VlBcIPxmEWzEoppWAbSZezxv2HNo7AddavSvZ
 BoVmWxtxuUiH3H6XXv8veiCA1NHkgyzFRSGWn8kDtompL7vSB+Pjx5xaX5ktKMRm69Gq0x
 32lLAjERwqooGODLPrmQMvHR8HDkdN8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-hoAvomw8OMGXBXIHCuRgAQ-1; Mon, 03 Aug 2026 18:10:29 -0400
X-MC-Unique: hoAvomw8OMGXBXIHCuRgAQ-1
X-Mimecast-MFC-AGG-ID: hoAvomw8OMGXBXIHCuRgAQ_1785795028
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-69c6057f3a3so3922715a12.3
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 15:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785795028; x=1786399828; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GsILbCg/L3lbT/ZcN2MQ2CJjY3WSErCj8bnJKzdOR9E=;
 b=G+9VTx9Z0R9tM/wJysWSpLdsC7fHQ9gsgJRfD3/+68cQEk10WpNRky/rUhkNOJQ/P5
 scJevPpVH+m4YltohzOyeppCkqqWagpV8JFmTxuM0HrefBL/pSb8wCcG7bNWndbQ6oI6
 kUIB66zinzeV1IjuqL1yuXsQLW7Pm9CDsszxL2VToGYOjfMXJo9AWhgeIN5XHjreU/TH
 CHbzjslb6Dv7h+Y/XfiM06yx+a5lnY7oX/W859JCpoQHBV6ifxOyepvm5sckIQosdTMz
 W9/uTC30fM0+9fBQa+u5IPDyquXsu1mxk/HcHHNP0VCDlc//9586TnOQ1UAXakUBiAE5
 ROeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785795028; x=1786399828;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GsILbCg/L3lbT/ZcN2MQ2CJjY3WSErCj8bnJKzdOR9E=;
 b=BDdcWhzCZy7zxhjTVqV+vUsCpeAMzelhFPcu6ZhvAOLPqzBPfj/BEIp2wmfAZgUSMo
 NAgFd5CM2ldaGZPOtfzNI6SOW24r+95J7+ordBw9CRhMhQ0NPs7spDTyOmEU21pdDydy
 ggDrI9XLBPPpORJWLd5CBaj5EgoLj3Rgj7vWFXcHJm4Oe6LjR7Gi7KRMmQoPfUxf+3nG
 kmAyQ2njmDVGBI3CzIqLokzYeQ8vo5j50YiIt+9ptuvFLeVQBjf/F4U1/1iiV77uHE1C
 0G+qn9pUSNgBwy4QvYfd6GmGV4o2GIPDXL+XlvtYVL1V0OoJyzmlN+TlhTXOsD8kA/WG
 Bzfg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrlzgIDbnstA/61AfIWBNfV8qX6nqon2QihPoK3OBbt+jQvhXTB7j25mTP7Bl+YsBVWZcgZiOH9jz9F@nongnu.org
X-Gm-Message-State: AOJu0YwVjgnGVLocHjIvB3Gj9UU5Fwuot215P+DndRoMifOELZU0Fm9A
 uN8nDdlINC5drUGVlPnphT6+NLi7J+nwu0gb5COkyCuzi6e0NZU6Cxb47xRGJTde9iX6nYHI1Np
 G638OBZWOfGZd17WKjmyoujlgyYkam09Tw+1BYuc6RChCwRfqupF49NIR
X-Gm-Gg: AR+sD10wvkQ9QHM6dyCq6j5DKRv8suca2fScykLuARbfUCF5VC5HsbqO2pstIj4T5Go
 Av/0XZ3pcbAwcYE8OWyRpQd9ST5lJ37nI3ui+orAJVNRsTmzIQR9icn9B08ZdAFYL0+aUv00NRf
 0L35sc3fpNAB6NxQBCpqMPMrN+KCA2FFvmilcQO5nEFr7tyiG2mnHuUVYhoRH3w9jDkful4LPC9
 pM05oBfCAwAXrLlxd2+m+QnHfRkre0wLh0JoRcaadlgOZ11p/MCU29bAo3cWraX1PK28BG93k90
 jkYR6QT+wNc2btmCJmlqhbXMfi59Ebl41gCnz+5In3PPCKwGwoIXXBJHF89Mr45RC5gb
X-Received: by 2002:a05:6402:2b8c:b0:697:decc:7f9a with SMTP id
 4fb4d7f45d1cf-6a0a7c60eb2mr8891776a12.9.1785795027671; 
 Mon, 03 Aug 2026 15:10:27 -0700 (PDT)
X-Received: by 2002:a05:6402:2b8c:b0:697:decc:7f9a with SMTP id
 4fb4d7f45d1cf-6a0a7c60eb2mr8891759a12.9.1785795027251; 
 Mon, 03 Aug 2026 15:10:27 -0700 (PDT)
Received: from redhat.com ([186.247.166.67]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a0d320226dsm2688683a12.28.2026.08.03.15.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 15:10:26 -0700 (PDT)
Date: Mon, 3 Aug 2026 18:10:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, vasant.hegde@amd.com, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH 7/8] acpi_build: Cleanup AMD IOMMU IVRS building
Message-ID: <20260803180841-mutt-send-email-mst@kernel.org>
References: <20260511123937.32743-1-sarunkod@amd.com>
 <20260511123937.32743-8-sarunkod@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511123937.32743-8-sarunkod@amd.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, May 11, 2026 at 06:09:36PM +0530, Sairaj Kodilkar wrote:
> Use structs and macros to improve the readability and maintainability of
> the the code. 
> 
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>

This does not "improve the readability and maintainability" it blows up
code size by a factor of 4, makes it impossible to find things in the
spec and breaks endian-ness.

Please don't.

> ---
>  hw/i386/acpi-build.c | 149 +++++++++++++++++--------------------------
>  1 file changed, 59 insertions(+), 90 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 82208e06e155..e18c9be801a2 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1663,11 +1663,13 @@ static void
>  insert_ivhd(PCIBus *bus, PCIDevice *dev, void *opaque)
>  {
>      GArray *table_data = opaque;
> -    uint32_t entry;
> +    AmdIvhdDeviceEntry entry = {};
>  
>      /* "Select" IVHD entry, type 0x2 */
> -    entry = PCI_BUILD_BDF(pci_bus_num(bus), dev->devfn) << 8 | 0x2;
> -    build_append_int_noprefix(table_data, entry, 4);
> +    entry.type = AMD_IVHD_DEVICE_ENTRY_TYPE_SELECT;
> +    entry.devid = PCI_BUILD_BDF(pci_bus_num(bus), dev->devfn);
> +
> +    g_array_append_vals(table_data, &entry, sizeof(entry));
>  
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
>          PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(dev));
> @@ -1691,11 +1693,14 @@ insert_ivhd(PCIBus *bus, PCIDevice *dev, void *opaque)
>               */
>              if (sec == sub) { /* leaf bus */
>                  /* "Start of Range" IVHD entry, type 0x3 */
> -                entry = PCI_BUILD_BDF(sec, PCI_DEVFN(0, 0)) << 8 | 0x3;
> -                build_append_int_noprefix(table_data, entry, 4);
> +                entry.type = AMD_IVHD_DEVICE_ENTRY_TYPE_START_RANGE;
> +                entry.devid = PCI_BUILD_BDF(sec, PCI_DEVFN(0, 0));
> +                g_array_append_vals(table_data, &entry, sizeof(entry));
> +
>                  /* "End of Range" IVHD entry, type 0x4 */
> -                entry = PCI_BUILD_BDF(sub, PCI_DEVFN(31, 7)) << 8 | 0x4;
> -                build_append_int_noprefix(table_data, entry, 4);
> +                entry.type = AMD_IVHD_DEVICE_ENTRY_TYPE_END_RANGE;
> +                entry.devid = PCI_BUILD_BDF(sub, PCI_DEVFN_MAX - 1);
> +                g_array_append_vals(table_data, &entry, sizeof(entry));
>              } else {
>                  pci_for_each_device(sec_bus, sec, insert_ivhd, table_data);
>              }
> @@ -1708,24 +1713,26 @@ insert_ivhd(PCIBus *bus, PCIDevice *dev, void *opaque)
>               * express bridges, just as in pci_device_iommu_address_space().
>               * DeviceIDa vs DeviceIDb as per the AMD IOMMU spec.
>               */
> -            uint16_t dev_id_a, dev_id_b;
> +            AmdIvhdDeviceEntryExt entry_ext = {};
>  
> -            dev_id_a = PCI_BUILD_BDF(sec, PCI_DEVFN(0, 0));
> +            entry_ext.type = AMD_IVHD_DEVICE_ENTRY_TYPE_ALIAS_START_RANGE;
> +            entry_ext.devid_a = PCI_BUILD_BDF(sec, PCI_DEVFN(0, 0));
>  
>              if (pci_is_express(dev) &&
>                  pcie_cap_get_type(dev) == PCI_EXP_TYPE_PCI_BRIDGE) {
> -                dev_id_b = dev_id_a;
> +                entry_ext.devid_b = entry_ext.devid_a;
>              } else {
> -                dev_id_b = PCI_BUILD_BDF(pci_bus_num(bus), dev->devfn);
> +                entry_ext.devid_b = PCI_BUILD_BDF(pci_bus_num(bus),
> +                                                  dev->devfn);
>              }
>  
>              /* "Alias Start of Range" IVHD entry, type 0x43, 8 bytes */
> -            build_append_int_noprefix(table_data, dev_id_a << 8 | 0x43, 4);
> -            build_append_int_noprefix(table_data, dev_id_b << 8 | 0x0, 4);
> +            g_array_append_vals(table_data, &entry_ext, sizeof(entry_ext));
>  
>              /* "End of Range" IVHD entry, type 0x4 */
> -            entry = PCI_BUILD_BDF(sub, PCI_DEVFN(31, 7)) << 8 | 0x4;
> -            build_append_int_noprefix(table_data, entry, 4);
> +            entry.type = AMD_IVHD_DEVICE_ENTRY_TYPE_END_RANGE;
> +            entry.devid = PCI_BUILD_BDF(sub, PCI_DEVFN_MAX - 1);
> +            g_array_append_vals(table_data, &entry, sizeof(entry));
>          }
>      }
>  }
> @@ -1786,20 +1793,20 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
>      GArray *ivhd_blob = g_array_new(false, true, 1);
>      AcpiTable table = { .sig = "IVRS", .rev = 1, .oem_id = oem_id,
>                          .oem_table_id = oem_table_id };
> -    uint64_t feature_report;
>      int iommu_bus = pci_bus_num(pci_get_bus(iommu_dev));
>      uint16_t iommu_devid = PCI_BUILD_BDF(iommu_bus, iommu_dev->devfn);
> +    AmdIvrsVendorHdr ivrs_hdr = {};
> +    AmdIvhdHdr10 ivhd10 = {};
> +    AmdIvhdHdr11 ivhd11 = {};
>  
>      acpi_table_begin(&table, table_data);
>      /* IVinfo - IO virtualization information common to all
>       * IOMMU units in a system
>       */
> -    build_append_int_noprefix(table_data,
> -                             (1UL << 0) | /* EFRSup */
> -                             AMDVI_PA_SIZE_52,
> -                             4);
> -    /* reserved */
> -    build_append_int_noprefix(table_data, 0, 8);
> +    ivrs_hdr.ivinfo = AMD_IVINFO_EFR_SUP | AMDVI_GVA_SIZE_48 |
> +                      AMDVI_PA_SIZE_52 | AMDVI_VA_SIZE_64;
> +
> +    g_array_append_vals(table_data, &ivrs_hdr, sizeof(ivrs_hdr));
>  
>      /*
>       * A PCI bus walk, for each PCI host bridge, is necessary to create a
> @@ -1817,7 +1824,8 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
>           *   These are 4-byte device entries currently reporting the range of
>           *   Refer to Spec - Table 95:IVHD Device Entry Type Codes(4-byte)
>           */
> -        build_append_int_noprefix(ivhd_blob, 0x0000001, 4);
> +        AmdIvhdDeviceEntry entry = { .type = AMD_IVHD_DEVICE_ENTRY_TYPE_ALL };
> +        g_array_append_vals(ivhd_blob, &entry, sizeof(entry));
>      }
>  
>      /*
> @@ -1829,76 +1837,37 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
>       * See Linux kernel commit 'c2ff5cf5294bcbd7fa50f7d860e90a66db7e5059'
>       */
>      if (x86_iommu_ir_supported(x86_iommu_get_default())) {
> -        build_append_int_noprefix(ivhd_blob,
> -                                 (0x1ull << 56) |           /* type IOAPIC */
> -                                 (IOAPIC_SB_DEVID << 40) |  /* IOAPIC devid */
> -                                 0x48,                      /* special device */
> -                                 8);
> -    }
> -
> -    /* IVHD definition - type 10h */
> -    build_append_int_noprefix(table_data, 0x10, 1);
> -    /* virtualization flags */
> -    build_append_int_noprefix(table_data,
> -                             (1UL << 0) | /* HtTunEn      */
> -                             (1UL << 4) | /* iotblSup     */
> -                             (1UL << 6) | /* PrefSup      */
> -                             (1UL << 7),  /* PPRSup       */
> -                             1);
> -
> -    /* IVHD length */
> -    build_append_int_noprefix(table_data, ivhd_blob->len + 24, 2);
> -    /* DeviceID */
> -    build_append_int_noprefix(table_data, iommu_devid, 2);
> -    /* Capability offset */
> -    build_append_int_noprefix(table_data, s->pci->capab_offset, 2);
> -    /* IOMMU base address */
> -    build_append_int_noprefix(table_data, s->mr_mmio.addr, 8);
> -    /* PCI Segment Group */
> -    build_append_int_noprefix(table_data, 0, 2);
> -    /* IOMMU info */
> -    build_append_int_noprefix(table_data, 0, 2);
> -    /* IOMMU Feature Reporting */
> -    feature_report = get_amd_ivhd_feature_report(s);
> -    build_append_int_noprefix(table_data, feature_report, 4);
> -
> +        AmdIvhdDeviceEntryExt entry_ext = {
> +                    .type = AMD_IVHD_DEVICE_ENTRY_TYPE_SPECIAL_DEVICE,
> +                    .devid_b = IOAPIC_SB_DEVID,
> +                    .variety = IVHD_VARIETY_IOAPIC
> +                };
> +
> +        g_array_append_vals(ivhd_blob, &entry_ext, sizeof(entry_ext));
> +    }
> +
> +    ivhd10.type = 0x10;
> +    ivhd10.flags = AMD_IVHD_FLAG_HT_TUN_EN | AMD_IVHD_FLAG_IOTLB_SUP |
> +                   AMD_IVHD_FLAG_PREF_SUP  | AMD_IVHD_FLAG_PPR_SUP;
> +    ivhd10.length = ivhd_blob->len + sizeof(ivhd10);
> +    ivhd10.devid = iommu_devid;
> +    ivhd10.capab_offset = s->pci->capab_offset;
> +    ivhd10.base_addr = s->mr_mmio.addr;
> +    ivhd10.iommu_feature_report = get_amd_ivhd_feature_report(s);
> +    g_array_append_vals(table_data, &ivhd10, sizeof(ivhd10));
>      /* IVHD entries as found above */
>      g_array_append_vals(table_data, ivhd_blob->data, ivhd_blob->len);
>  
> -   /* IVHD definition - type 11h */
> -    build_append_int_noprefix(table_data, 0x11, 1);
> -    /* virtualization flags */
> -    build_append_int_noprefix(table_data,
> -                             (1UL << 0) | /* HtTunEn      */
> -                             (1UL << 4),  /* iotblSup     */
> -                             1);
> -
> -    /* IVHD length */
> -    build_append_int_noprefix(table_data, ivhd_blob->len + 40, 2);
> -
> -    /* DeviceID */
> -    build_append_int_noprefix(table_data, iommu_devid, 2);
> -    /* Capability offset */
> -    build_append_int_noprefix(table_data, s->pci->capab_offset, 2);
> -    /* IOMMU base address */
> -    build_append_int_noprefix(table_data, s->mr_mmio.addr, 8);
> -    /* PCI Segment Group */
> -    build_append_int_noprefix(table_data, 0, 2);
> -    /* IOMMU info */
> -    build_append_int_noprefix(table_data, 0, 2);
> -    /* IOMMU Attributes */
> -    if (!s->iommu.dma_translation) {
> -        build_append_int_noprefix(table_data, (1UL << 0) /* HATDis */, 4);
> -    } else {
> -        build_append_int_noprefix(table_data, 0, 4);
> -    }
> -    /* EFR Register Image */
> -    build_append_int_noprefix(table_data,
> -                              amdvi_extended_feature_register(s),
> -                              8);
> -    /* EFR Register Image 2 */
> -    build_append_int_noprefix(table_data, 0, 8);
> -
> +    ivhd11.type = 0x11;
> +    ivhd11.flags = AMD_IVHD_FLAG_HT_TUN_EN | AMD_IVHD_FLAG_IOTLB_SUP;
> +    ivhd11.length = ivhd_blob->len + sizeof(ivhd11);
> +    ivhd11.devid = iommu_devid;
> +    ivhd11.capab_offset = s->pci->capab_offset;
> +    ivhd11.base_addr = s->mr_mmio.addr;
> +    ivhd11.iommu_attributes = !s->iommu.dma_translation <<
> +                              AMD_IVHD_ATTRIBUTES_HATDIS_SHIFT;
> +    ivhd11.efr = amdvi_extended_feature_register(s);
> +    g_array_append_vals(table_data, &ivhd11, sizeof(ivhd11));
>      /* IVHD entries as found above */
>      g_array_append_vals(table_data, ivhd_blob->data, ivhd_blob->len);
>  
> -- 
> 2.34.1


