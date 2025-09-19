Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9540CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 08:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzW8H-0005OO-7m; Fri, 19 Sep 2025 04:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uzW8F-0005L0-W5
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 04:06:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uzW8D-00070i-AJ
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 04:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758269172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HSLzVcJ3k5VfjMfwaGziJmBIigImbG32w8i35pTTc0c=;
 b=MrPgU0mNp60BXouIUv0EYB9VcFj1LXaJfL69BEs2iAS49ylILmu0vC7Ti8TjU5fgHyNkxX
 RLWPZ88ZgY47YhbkAeARt/ORf8+IwB5K9U7TQ0fRkC9IIXJkWYlMC52YU6EMaiJpvIu87X
 lp5mopMqG6vieBOIlCywsesn4pLbtM4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-fR2-I5zJNx2iNzK9hQJU6w-1; Fri, 19 Sep 2025 04:06:10 -0400
X-MC-Unique: fR2-I5zJNx2iNzK9hQJU6w-1
X-Mimecast-MFC-AGG-ID: fR2-I5zJNx2iNzK9hQJU6w_1758269170
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45b9a856d58so14259915e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 01:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758269169; x=1758873969;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HSLzVcJ3k5VfjMfwaGziJmBIigImbG32w8i35pTTc0c=;
 b=ZUyc9zB6iQ7ay5bTN+CzxhHcEo+ipLFgpggvdI1VMBvfzpmvKaCjBBpohSndlo51WI
 bAzQd9/nzD0czlGce2X/e0ST8LTRA3lz1cDs3cZoZn4VxcVYOF9k/9d7U1HDXRxOpYkv
 clqhMbB3B/oMAx6gbytdi6AsekVo49X+TnqO4CdgETsXO3oW9e7BRjA1DlkyqolOTVOp
 mYr/mWaecFjUqjQEg2+g39x7Y8M3Q8CTzF4FefqnpT15Fys9vt/Sge/BWjlYPF4gBtJT
 vbEIdKsujJgPTf26RwV/gsn4mSBvo93Vc6ghE0SPW/ZFmXR3DXaONzKXBgj5DD6CnhYI
 9BLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg6FpqmKPapml+SAHVU+aXZ0UJ7hACqkcfWKL4+Xa2PQh0vIl2IYQFtPEaStf9tgvJ0O46CpOVEGhL@nongnu.org
X-Gm-Message-State: AOJu0YxSXFA6SNz6oXaCg84sqTBNHEQhQBSAdf4S4xC1bx7zshlMiJF/
 8udklMW17Lq3x2raJfJx45+UbEa/u91GKQe2tSg5Zn7d1bR238636tJcYwIK/DalseSXbqpEx3V
 ZvkDfyzwx8hKyCRgEMvoZXrgmn/RcgQ/ZqA2G16oKPROfFixpK1B0KgqT
X-Gm-Gg: ASbGnct3vLQNNTtYIcJakZPXd0KGf9LDoQfkC4TpBmgucwnK2LvCF0lDnsLQ/RQaHRT
 FLzScbGtUvNfTkwXP/f4c865LY/5AQvDrcXCZPR3pl2rX6RMv4gMR9e/Z2hpvV5YdbPVEm73SGx
 99H6jpmSV9XAXWjx69l4EW2KynBpZNrtrb89EZYWZ3TtMCtJiFIOX3t6kINiClgHK/XCLvznypK
 2iye33LnUJ07S1Uu1cVTFdDHziEvUWPUsfIeJdeU4zp/IUem8rvlCTVZ2xJ5j0Ural1u6q4WMDG
 07DTGlFwENl6MXkIfxqJQOuf60R5IlOkO76uh6r7JEtKElOU80UL8shqUAXzuLxL36VdF+zV0Ef
 Pt/8=
X-Received: by 2002:a05:600c:1f06:b0:45d:d88b:cc6 with SMTP id
 5b1f17b1804b1-467f0b4ee72mr16623385e9.25.1758269169335; 
 Fri, 19 Sep 2025 01:06:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEygJu1LYsqKF/u2fbvX9rumdsN70QVD/7fzQHwGiy0QjTxfkZhK89lGe7LpshOeDfudYNEqA==
X-Received: by 2002:a05:600c:1f06:b0:45d:d88b:cc6 with SMTP id
 5b1f17b1804b1-467f0b4ee72mr16622815e9.25.1758269168754; 
 Fri, 19 Sep 2025 01:06:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee15bfab67sm2987490f8f.43.2025.09.19.01.06.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Sep 2025 01:06:08 -0700 (PDT)
Message-ID: <366839f7-101e-45e7-9821-ac7ac0eceed3@redhat.com>
Date: Fri, 19 Sep 2025 10:06:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v4 06/14] hw/pci-host/aspeed: Add MSI support and
 per-RC IOMMU address space
To: Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, nabihestefan@google.com, wuhaotsh@google.com,
 titusr@google.com
References: <20250919032431.3316764-1-jamin_lin@aspeedtech.com>
 <20250919032431.3316764-7-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250919032431.3316764-7-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/19/25 05:24, Jamin Lin wrote:
> Add MSI support to the ASPEED PCIe RC/Config model and introduce a per-RC
> "IOMMU root" address space to correctly route MSI writes.
> 
> On AST2700 all RCs use the same MSI address, and the MSI target is PCI
> system memory (not normal DRAM). If the MSI window were mapped into real
> system RAM, an endpoint's write could be observed by other RCs and
> spuriously trigger their interrupts. To avoid this, each RC now owns an
> isolated IOMMU root AddressSpace that contains a small MSI window and a
> DRAM alias region for normal DMA.
> 
> The MSI window captures writes and asserts the RC IRQ. MSI status bits
> are tracked in new H2X RC_H registers (R_H2X_RC_H_MSI_EN{0,1} and
> R_H2X_RC_H_MSI_STS{0,1}). Clearing all status bits drops the IRQ. The
> default MSI address is set to 0x1e77005c and can be overridden via the
> msi-addr property.
> 
> This keeps MSI traffic contained within each RC while preserving normal
> DMA to system DRAM. It enables correct MSI/MSI-X interrupt delivery when
> multiple RCs use the same MSI target address.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/pci-host/aspeed_pcie.h |  10 +++
>   hw/pci-host/aspeed_pcie.c         | 132 ++++++++++++++++++++++++++++++
>   hw/pci-host/trace-events          |   3 +
>   3 files changed, 145 insertions(+)
> 
> diff --git a/include/hw/pci-host/aspeed_pcie.h b/include/hw/pci-host/aspeed_pcie.h
> index 5346c15c81..5e60cba07b 100644
> --- a/include/hw/pci-host/aspeed_pcie.h
> +++ b/include/hw/pci-host/aspeed_pcie.h
> @@ -35,6 +35,8 @@ typedef struct AspeedPCIECfgTxDesc {
>   typedef struct AspeedPCIERcRegs {
>       uint32_t int_en_reg;
>       uint32_t int_sts_reg;
> +    uint32_t msi_sts0_reg;
> +    uint32_t msi_sts1_reg;
>   } AspeedPCIERcRegs;
>   
>   typedef struct AspeedPCIERegMap {
> @@ -61,11 +63,18 @@ OBJECT_DECLARE_SIMPLE_TYPE(AspeedPCIERcState, ASPEED_PCIE_RC);
>   struct AspeedPCIERcState {
>       PCIExpressHost parent_obj;
>   
> +    MemoryRegion iommu_root;
> +    AddressSpace iommu_as;
> +    MemoryRegion dram_alias;
> +    MemoryRegion *dram_mr;
>       MemoryRegion mmio_window;
> +    MemoryRegion msi_window;
>       MemoryRegion io_window;
>       MemoryRegion mmio;
>       MemoryRegion io;
>   
> +    uint64_t dram_base;
> +    uint32_t msi_addr;
>       uint32_t rp_addr;
>       uint32_t bus_nr;
>       char name[16];
> @@ -97,6 +106,7 @@ struct AspeedPCIECfgClass {
>       const AspeedPCIERegMap *reg_map;
>       const MemoryRegionOps *reg_ops;
>   
> +    uint32_t rc_msi_addr;
>       uint32_t rc_rp_addr;
>       uint64_t rc_bus_nr;
>       uint64_t nr_regs;
> diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c
> index dafffbde61..8be55b962f 100644
> --- a/hw/pci-host/aspeed_pcie.c
> +++ b/hw/pci-host/aspeed_pcie.c
> @@ -94,6 +94,8 @@ static const TypeInfo aspeed_pcie_root_port_info = {
>    * PCIe Root Complex (RC)
>    */
>   
> +#define ASPEED_PCIE_CFG_RC_MAX_MSI 64
> +
>   static void aspeed_pcie_rc_set_irq(void *opaque, int irq, int level)
>   {
>       AspeedPCIERcState *rc = (AspeedPCIERcState *) opaque;
> @@ -120,6 +122,58 @@ static int aspeed_pcie_rc_map_irq(PCIDevice *pci_dev, int irq_num)
>       return irq_num % PCI_NUM_PINS;
>   }
>   
> +static void aspeed_pcie_rc_msi_notify(AspeedPCIERcState *rc, uint64_t data)
> +{
> +    AspeedPCIECfgState *cfg =
> +           container_of(rc, AspeedPCIECfgState, rc);
> +    uint32_t reg;
> +
> +    /* Written data is the HW IRQ number */
> +    assert(data < ASPEED_PCIE_CFG_RC_MAX_MSI);
> +
> +    reg = (data < 32) ?
> +            cfg->rc_regs->msi_sts0_reg : cfg->rc_regs->msi_sts1_reg;
> +    cfg->regs[reg] |= BIT(data % 32);
> +
> +    trace_aspeed_pcie_rc_msi_set_irq(cfg->id, data, 1);
> +    qemu_set_irq(rc->irq, 1);
> +}
> +
> +static void aspeed_pcie_rc_msi_write(void *opaque, hwaddr addr, uint64_t data,
> +                                     unsigned int size)
> +{
> +    AspeedPCIERcState *rc = ASPEED_PCIE_RC(opaque);
> +    AspeedPCIECfgState *cfg =
> +           container_of(rc, AspeedPCIECfgState, rc);
> +
> +    trace_aspeed_pcie_rc_msi_notify(cfg->id, addr + rc->msi_addr, data);
> +    aspeed_pcie_rc_msi_notify(rc, data);
> +}
> +
> +static const MemoryRegionOps aspeed_pcie_rc_msi_ops = {
> +    .write = aspeed_pcie_rc_msi_write,
> +    .read = NULL,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +    .impl = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static AddressSpace *aspeed_pcie_rc_get_as(PCIBus *bus, void *opaque, int devfn)
> +{
> +    AspeedPCIERcState *rc = ASPEED_PCIE_RC(opaque);
> +    return &rc->iommu_as;
> +}
> +
> +static const PCIIOMMUOps aspeed_pcie_rc_iommu_ops = {
> +    .get_address_space = aspeed_pcie_rc_get_as,
> +};
> +
>   static void aspeed_pcie_rc_realize(DeviceState *dev, Error **errp)
>   {
>       PCIExpressHost *pex = PCIE_HOST_BRIDGE(dev);
> @@ -130,6 +184,8 @@ static void aspeed_pcie_rc_realize(DeviceState *dev, Error **errp)
>       SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>       g_autofree char *ioport_window_name = NULL;
>       g_autofree char *mmio_window_name = NULL;
> +    g_autofree char *iommu_root_name = NULL;
> +    g_autofree char *dram_alias_name = NULL;
>       g_autofree char *root_bus_name = NULL;
>   
>       /* PCI configuration space */
> @@ -160,6 +216,43 @@ static void aspeed_pcie_rc_realize(DeviceState *dev, Error **errp)
>                                        &rc->io, 0, 4, TYPE_PCIE_BUS);
>       pci->bus->flags |= PCI_BUS_EXTENDED_CONFIG_SPACE;
>   
> +   /*
> +    * PCIe memory view setup
> +    *
> +    * Background:
> +    * - On AST2700, all Root Complexes use the same MSI address. This MSI
> +    *   address is not normal system RAM - it is a PCI system memory address.
> +    *   If we map the MSI/MSI-X window into real system memory, a write from
> +    *   one EP can be seen by all RCs and wrongly trigger interrupts on them.
> +    *
> +    * Design:
> +    * - MSI/MSI-X here is just a placeholder address so RC and EP can talk.
> +    *   We make a separate MMIO space (iommu_root) for the MSI window so the
> +    *   writes stay local to each RC.
> +    *
> +    * DMA:
> +    * - EPs still need access to real system memory for DMA. We add a DRAM
> +    *   alias in the PCI space so DMA works as expected.
> +    */
> +    iommu_root_name = g_strdup_printf("pcie.%d.iommu_root", cfg->id);
> +    memory_region_init(&rc->iommu_root, OBJECT(rc), iommu_root_name,
> +                       UINT64_MAX);
> +    address_space_init(&rc->iommu_as, &rc->iommu_root, iommu_root_name);
> +    /* setup MSI */
> +    memory_region_init_io(&rc->msi_window, OBJECT(rc),
> +                          &aspeed_pcie_rc_msi_ops, rc,
> +                          "msi_window", 4);
> +    memory_region_add_subregion(&rc->iommu_root, rc->msi_addr,
> +                                &rc->msi_window);
> +    /* setup DRAM for DMA */
> +    assert(rc->dram_mr != NULL);
> +    dram_alias_name = g_strdup_printf("pcie.%d.dram_alias", cfg->id);
> +    memory_region_init_alias(&rc->dram_alias, OBJECT(rc), dram_alias_name,
> +                             rc->dram_mr, 0, memory_region_size(rc->dram_mr));
> +    memory_region_add_subregion(&rc->iommu_root, rc->dram_base,
> +                                &rc->dram_alias);
> +    pci_setup_iommu(pci->bus, &aspeed_pcie_rc_iommu_ops, rc);
> +
>       /* setup root device */
>       if (rc->has_rd) {
>           object_initialize_child(OBJECT(rc), "root_device", &rc->root_device,
> @@ -205,6 +298,10 @@ static const Property aspeed_pcie_rc_props[] = {
>       DEFINE_PROP_UINT32("bus-nr", AspeedPCIERcState, bus_nr, 0),
>       DEFINE_PROP_BOOL("has-rd", AspeedPCIERcState, has_rd, 0),
>       DEFINE_PROP_UINT32("rp-addr", AspeedPCIERcState, rp_addr, 0),
> +    DEFINE_PROP_UINT32("msi-addr", AspeedPCIERcState, msi_addr, 0),
> +    DEFINE_PROP_UINT64("dram-base", AspeedPCIERcState, dram_base, 0),
> +    DEFINE_PROP_LINK("dram", AspeedPCIERcState, dram_mr, TYPE_MEMORY_REGION,
> +                     MemoryRegion *),
>   };
>   
>   static void aspeed_pcie_rc_class_init(ObjectClass *klass, const void *data)
> @@ -265,6 +362,10 @@ REG32(H2X_RC_H_INT_STS,     0xC8)
>       SHARED_FIELD(H2X_RC_INT_INTDONE, 4, 1)
>       SHARED_FIELD(H2X_RC_INT_INTX, 0, 4)
>   REG32(H2X_RC_H_RDATA,       0xCC)
> +REG32(H2X_RC_H_MSI_EN0,     0xE0)
> +REG32(H2X_RC_H_MSI_EN1,     0xE4)
> +REG32(H2X_RC_H_MSI_STS0,    0xE8)
> +REG32(H2X_RC_H_MSI_STS1,    0xEC)
>   
>   #define TLP_FMTTYPE_CFGRD0  0x04 /* Configuration Read  Type 0 */
>   #define TLP_FMTTYPE_CFGWR0  0x44 /* Configuration Write Type 0 */
> @@ -278,6 +379,8 @@ static const AspeedPCIERegMap aspeed_regmap = {
>       .rc = {
>           .int_en_reg     = R_H2X_RC_H_INT_EN,
>           .int_sts_reg    = R_H2X_RC_H_INT_STS,
> +        .msi_sts0_reg   = R_H2X_RC_H_MSI_STS0,
> +        .msi_sts1_reg   = R_H2X_RC_H_MSI_STS1,
>       },
>   };
>   
> @@ -447,6 +550,29 @@ static void aspeed_pcie_cfg_write(void *opaque, hwaddr addr, uint64_t data,
>           }
>           s->regs[reg] &= ~data | H2X_RC_INT_INTX_MASK;
>           break;
> +    /*
> +     * These status registers are used for notify sources ISR are executed.
> +     * If one source ISR is executed, it will clear one bit.
> +     * If it clear all bits, it means to initialize this register status
> +     * rather than sources ISR are executed.
> +     */
> +    case R_H2X_RC_H_MSI_STS0:
> +    case R_H2X_RC_H_MSI_STS1:
> +        if (data == 0) {
> +            return ;
> +        }
> +
> +        s->regs[reg] &= ~data;
> +        if (data == 0xffffffff) {
> +            return;
> +        }
> +
> +        if (!s->regs[R_H2X_RC_H_MSI_STS0] &&
> +            !s->regs[R_H2X_RC_H_MSI_STS1]) {
> +            trace_aspeed_pcie_rc_msi_clear_irq(s->id, 0);
> +            qemu_set_irq(s->rc.irq, 0);
> +        }
> +        break;
>       default:
>           s->regs[reg] = data;
>           break;
> @@ -468,6 +594,8 @@ static void aspeed_pcie_cfg_instance_init(Object *obj)
>       AspeedPCIECfgState *s = ASPEED_PCIE_CFG(obj);
>   
>       object_initialize_child(obj, "rc", &s->rc, TYPE_ASPEED_PCIE_RC);
> +    object_property_add_alias(obj, "dram", OBJECT(&s->rc), "dram");
> +    object_property_add_alias(obj, "dram-base", OBJECT(&s->rc), "dram-base");
>   
>       return;
>   }
> @@ -503,6 +631,9 @@ static void aspeed_pcie_cfg_realize(DeviceState *dev, Error **errp)
>       object_property_set_int(OBJECT(&s->rc), "rp-addr",
>                               apc->rc_rp_addr,
>                               &error_abort);
> +    object_property_set_int(OBJECT(&s->rc), "msi-addr",
> +                            apc->rc_msi_addr,
> +                            &error_abort);
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->rc), errp)) {
>           return;
>       }
> @@ -534,6 +665,7 @@ static void aspeed_pcie_cfg_class_init(ObjectClass *klass, const void *data)
>       apc->reg_ops = &aspeed_pcie_cfg_ops;
>       apc->reg_map = &aspeed_regmap;
>       apc->nr_regs = 0x100 >> 2;
> +    apc->rc_msi_addr = 0x1e77005C;
>       apc->rc_bus_nr = 0x80;
>       apc->rc_has_rd = true;
>       apc->rc_rp_addr = PCI_DEVFN(8, 0);
> diff --git a/hw/pci-host/trace-events b/hw/pci-host/trace-events
> index 2584ea56e2..a6fd88c2c4 100644
> --- a/hw/pci-host/trace-events
> +++ b/hw/pci-host/trace-events
> @@ -2,6 +2,9 @@
>   
>   # aspeed_pcie.c
>   aspeed_pcie_rc_intx_set_irq(uint32_t id, int num, int level) "%d: num %d set IRQ leve %d"
> +aspeed_pcie_rc_msi_notify(uint32_t id, uint64_t addr, uint64_t data) "%d: 0x%" PRIx64 " data 0x%" PRIx64
> +aspeed_pcie_rc_msi_set_irq(uint32_t id, uint64_t unm, int level) "%d: num 0x%" PRIx64 " set IRQ level %d"
> +aspeed_pcie_rc_msi_clear_irq(uint32_t id, int level) "%d: clear IRQ level %d"
>   aspeed_pcie_cfg_read(uint32_t id, uint64_t addr, uint32_t value) "%d: addr 0x%" PRIx64 " value 0x%" PRIx32
>   aspeed_pcie_cfg_write(uint32_t id, uint64_t addr, uint32_t value) "%d: addr 0x%" PRIx64 " value 0x%" PRIx32
>   aspeed_pcie_cfg_rw(uint32_t id, const char *dir, uint8_t bus, uint8_t devfn, uint64_t addr, uint64_t data) "%d: %s bus:0x%x devfn:0x%x addr 0x%" PRIx64 " data 0x%" PRIx64


