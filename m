Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CC1C55182
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 21:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr0eS-0005E8-OK; Mon, 03 Aug 2026 17:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wr0eQ-0005CR-FB
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 17:56:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wr0eN-0008Su-Tw
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 17:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785794192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HDxJ7c+XeIBql9RuF7XyG/EqSK429stu2cdB2f7gp40=;
 b=cYWgRpt10jX/kzQn2bUr2wYrQppsTv33yZXmGhu1es9/ZV1DOJFivim+40zR8ltaOhCNmP
 /TXSOK3ObXGTuxC/HJU7dbkAmEEDb4rhTbIANEGUwn/2TT+kS0BxwKwS/iATFVt96jXIHS
 c8gwoX5IijEyPpSHDtRIvKoZlwNwg44=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-bZEJTTqFPoG3nQmhkT_ngw-1; Mon, 03 Aug 2026 17:56:30 -0400
X-MC-Unique: bZEJTTqFPoG3nQmhkT_ngw-1
X-Mimecast-MFC-AGG-ID: bZEJTTqFPoG3nQmhkT_ngw_1785794189
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-69841da1946so3664019a12.2
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 14:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785794189; x=1786398989; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HDxJ7c+XeIBql9RuF7XyG/EqSK429stu2cdB2f7gp40=;
 b=W9K7PZAIslZr36igm4pXirDsaexdMBovUe13htgGtdTS+U5g/u8CFqT0ejoX2yHz3w
 tH1btC37631jvZErSbUnzm/EmcR54etUz2MYrHwxx8gbIHNejkHt9wxnjGFcKotWZxVw
 1he5YMkC3CNv98rqH2HZCIQFdw5wmaFgcTxq1Yga7PIifQ+SkS8jhVLUPVxDR30d36lb
 k68r1+py8kDWiXK7E+hn8Cmb/RwLgcdDfo3TjzjKC1lx/DFpjPj4tTXbpuUmfTmqc6go
 ZjqO6NwG+VUoTai+d1bJvvZC5Uwoen8ziJTWgtD4AZylAC0jVN+hzRTW20ceNt06Gv/+
 PalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785794189; x=1786398989;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HDxJ7c+XeIBql9RuF7XyG/EqSK429stu2cdB2f7gp40=;
 b=HdWE42Vb7gfMn+Tsze0/jD53deGCaWZr1TZmH56n7v6oMI6HhmSkptpN7HvVSaond8
 3VCM6rNvo2uU3trxY0lTgXvFx5QzX/4caxxKkLindjAXsLLoghbWnIezZvZpOFElcyJM
 fV7H/npUCPCj00NIOiDzC8npGwX6qFcP8bnIBJIo0sm3hHYNS9isGO3xL/JxECs6afBA
 A2clh7dXKIZUpFdiA8Sv37QNky4w6b7RIpsaZdcGONPbcTiVAtD9MqQPISXzRaLCeXH4
 PTBpYntVQJQq+ellqUC9BWkZW4UkMmYafHnhDbo4lFFeNWr+asXmNed1ABiHIiPdF6St
 UXAQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrbQ8gK/76Ki+4dYaN7o2EsxkJWf5/2nS+Bi/ud74DbE3m1g3pb1BcRRSRFprS3ng9ARHyjORKge7pN@nongnu.org
X-Gm-Message-State: AOJu0Yz3JyRviO8J433ky3V3s1sidStQs81C6fagu3fbrCHTFFRNePZk
 Fa0loqEP0+m5WyNft/dpXVaipKgS8IodIwBdnUc3R2Z97TnOXdbe4y59UXajo8zDnHWCUARSYS8
 w+/JPy232evAWAs04xAt4bvVUhBxzrZnAZ3L63CFRSi7EAIkTOsOF5nle
X-Gm-Gg: AR+sD10p/JR1HsuA322fCitAvN6ZmF2RG3RDiQSZ5NQvYo++82hQSOEjDEdldzUmdo7
 Z/Qqp1S/dUAUzx+UZVRFLMdgZPs4XAwTpLaJW1KiQlB0G9QIKFQ+/i/zLpNDMJk7RBWOsaFhuA0
 kLcu8fScHbvPkqhF+gZCi6BX874/W8b0wmuNrQ/zToeUG4U2pb6IPbjF5FdNkRviuel8Xuf01sN
 T/c2Bu4u5Rf2ghiPJUialzxra9CgBxObF6ApT+rJbqq+JM6NQ/inAD80rxxv+FLCAGPm3oyWEc6
 iYxTsJ0CJxS/RXCD/uwQrlq4KmajKJP9FdCBN7bEsPzu+yRNFO13F5rMRuOZxqrZ00EY
X-Received: by 2002:a17:906:5ad7:b0:c1c:2fd3:bbd7 with SMTP id
 a640c23a62f3a-c1fe822975dmr676094266b.26.1785794189332; 
 Mon, 03 Aug 2026 14:56:29 -0700 (PDT)
X-Received: by 2002:a17:906:5ad7:b0:c1c:2fd3:bbd7 with SMTP id
 a640c23a62f3a-c1fe822975dmr676091766b.26.1785794188779; 
 Mon, 03 Aug 2026 14:56:28 -0700 (PDT)
Received: from redhat.com ([186.247.166.67]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fd4537755sm607017866b.54.2026.08.03.14.56.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 14:56:28 -0700 (PDT)
Date: Mon, 3 Aug 2026 17:56:24 -0400
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
Message-ID: <20260803175508-mutt-send-email-mst@kernel.org>
References: <20260511123937.32743-1-sarunkod@amd.com>
 <20260511123937.32743-8-sarunkod@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511123937.32743-8-sarunkod@amd.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


This has broken endian-ness.



Please do not use packed structs.


ACPI has infrastructure to build up structs such as
build_append_int_noprefix.

Just use that.


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


