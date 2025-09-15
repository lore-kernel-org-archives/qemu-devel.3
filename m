Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4831CAC598
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 10:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy6Tv-0001Dm-2O; Mon, 15 Sep 2025 06:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uy6Tt-0001DP-8M
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:30:45 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uy6Ti-0000rt-KJ
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:30:44 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3dad6252eacso1621893f8f.1
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 03:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757932230; x=1758537030; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eavLddbUrUQq9E0Jc3KGMkan9Di3pwYGRzcYUpW+7/4=;
 b=k2FNZ47/zwbAopnVZBTS900ILrppHmQkD7j+e2MhQa+7XfeV4+huLlPi74XDpmMmgl
 B3GBBn6JMrH3nM9IES5zkfFbSvr9TyothHryWJkAV3Ge5vsEaux8G7/P1IpX5rWllEg+
 HA00bdTTTmnsr5dBHvfJBJZ6+CTWDp0uUmC0vhVcsZ01QRPC+aaOdBYpX3E9RCaKiyNk
 9Ik0TLWhZPWay1AGv8C8mblljyrjrnHIDxZsBqlxzM6YqHUudUCy00XV9zLhU75dvuFc
 FkhEjGuq0ljuaX0fFd4vbB+K5snG6lpS2/m1xzfUn23b55IPiuIUGhOJ3OH57LHxl3JQ
 RRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757932230; x=1758537030;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eavLddbUrUQq9E0Jc3KGMkan9Di3pwYGRzcYUpW+7/4=;
 b=BRpvSaHr8oBWFduEz1w2LyhpQ/HOYSAsX2gjwMsKAeJq3c5EZVkKWhjTPQnbMnVA5q
 rrA8kUTaTmx3bBoiSF6ZLM7kUDBMcMKh/ZgBmrtuo1MoKI6m+9nsC+qGJB1h9NDaY9ry
 zEHGtmtG/WvULHebbMZ24jjHE6Y6lrsXaNJnZ/Xt6jefSvAyUxltmSRLI4//G49PJxNZ
 8DlwBVV8GlY0qEc5n7lP4wB89j7SUYle/8p7ATiu6hOa8x2NCaJOqQGgGn0qPoqGqMJH
 jCEQubTevZmQYB+HKAPL4y6eue4QKgafmvEOHzXCxayw4+U+nDfk+He9zN8mKmNzmIo7
 K5Yw==
X-Gm-Message-State: AOJu0YybEggNYVMNl2ayAOw5qIPRIZ8ph7zSQFtGk/kkykngwgM6InbZ
 A7lcgZaF/HyZN/UsKj+SSNzkSsviDJTGaxGQwxstg0WuD1xu0IdEHA0h9s4MJg==
X-Gm-Gg: ASbGncsLcvHDKSwM1SZJfcRmqTQOhBPzf+UyJN8bykMPxcDgIH/XpWQLkdOJJw7E/AK
 Fom3GIOFd5uhRfxy655mYNC8lLEr8CaUVekuUQ6/r+c00kmeQIASNlP2bT6MMieb0Fd/qSL3v+n
 dIJK2QJfcuWSmMr7o7H1Ahe0MXXMkqNbutULuAxG3pq5oVyK02xHnkhjV1pariCkq4i9st6UzDz
 at2WpBNO+PRARDXwBUZItOZekVsGymrq33nJrLW9UvcNpx42nP7qG+hQ+54/qe8pf1K8gYuYraw
 OOJgZLHQkZJbc+stclyCfeRHTpZGmCaMmmM34q6YC7HPeaRDO7vLWAHIF3tJ8qkcTxSVETQb97I
 AVcALqgz4Lhssy/lgmOyGRHAnFxpNZQttawQJDjNM
X-Google-Smtp-Source: AGHT+IFZKCX/t7ekNSU2Db0bPKuKgIXcSr8L2fdJaCuk3H4C8CDjTq5HwRWXxrNvVhLfUZZKANJOxw==
X-Received: by 2002:a05:6000:402b:b0:3ea:80ec:854c with SMTP id
 ffacd0b85a97d-3ea80ec89c0mr2333512f8f.19.1757932229512; 
 Mon, 15 Sep 2025 03:30:29 -0700 (PDT)
Received: from ehlo.thunderbird.net ([185.238.219.77])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e7c778f764sm11806826f8f.57.2025.09.15.03.30.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Sep 2025 03:30:29 -0700 (PDT)
Date: Mon, 15 Sep 2025 10:30:28 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
CC: Huacai Chen <chenhuacai@kernel.org>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 3/5] hw/pci-host/bonito: Implement DMA address translation
In-Reply-To: <20250508-bonito-v1-3-4f9f27733028@flygoat.com>
References: <20250508-bonito-v1-0-4f9f27733028@flygoat.com>
 <20250508-bonito-v1-3-4f9f27733028@flygoat.com>
Message-ID: <DA22DFAE-CD22-4A99-8FEB-D665F7C6B827@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42b.google.com
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



Am 8=2E Mai 2025 14:46:08 UTC schrieb Jiaxun Yang <jiaxun=2Eyang@flygoat=
=2Ecom>:
>PCIBase (Host Bridge config space BARs) and PCIBaseCfg registers
>in Bonito controls PCI DMA address translation=2E
>
>For any incoming DMA requests, it will be matched against PCiBase{0, 1}
>together with PciBaseCfg=2EMASK{0,1}=2E If it hits any of both, higher bi=
ts
>of address will be replaced by PciBaseCfg=2ETRANSx=2E
>
>Emulating this behavior by PCI IOMMU DMA address space with dynamic
>remapping on register writes=2E
>
>Signed-off-by: Jiaxun Yang <jiaxun=2Eyang@flygoat=2Ecom>
>---
> hw/pci-host/bonito=2Ec | 113 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
> 1 file changed, 113 insertions(+)
>
>diff --git a/hw/pci-host/bonito=2Ec b/hw/pci-host/bonito=2Ec
>index f509f22df90ff7ed31ff5387a0acc239c22fd5f6=2E=2E1c0d502a1e2dfa3c9803c=
a219cf505e08bf94a75 100644
>--- a/hw/pci-host/bonito=2Ec
>+++ b/hw/pci-host/bonito=2Ec
>@@ -144,6 +144,17 @@ FIELD(PCIMAP, LO2, 12, 6)
> FIELD(PCIMAP, 2, 18, 1)
>=20
> #define BONITO_PCIMEMBASECFG    (0x14 >> 2)      /* 0x114 */
>+REG32(PCIMEMBASECFG, 0x114)
>+FIELD(PCIMEMBASECFG, MASK0, 0, 5)
>+FIELD(PCIMEMBASECFG, TRANS0, 5, 5)
>+FIELD(PCIMEMBASECFG, CACHED0, 10, 1)
>+FIELD(PCIMEMBASECFG, IO0, 11, 1)
>+FIELD(PCIMEMBASECFG, MASK1, 12, 5)
>+FIELD(PCIMEMBASECFG, TRANS1, 17, 5)
>+FIELD(PCIMEMBASECFG, CACHED1, 22, 1)
>+FIELD(PCIMEMBASECFG, IO1, 23, 1)
>+
>+
> #define BONITO_PCIMAP_CFG       (0x18 >> 2)      /* 0x118 */
>=20
> /* 5=2E ICU & GPIO regs */
>@@ -258,9 +269,12 @@ struct BonitoState {
>     PCIHostState parent_obj;
>     qemu_irq *pic;
>     PCIBonitoState *pci_dev;
>+    MemoryRegion dma_mr;
>     MemoryRegion pci_mem;
>+    AddressSpace dma_as;
>     MemoryRegion *pcimem_lo_alias;
>     MemoryRegion *pcimem_hi_alias;
>+    MemoryRegion *dma_alias;

Should be `MemoryRegion dma_alias[2]` for simplicity and to avoid memory l=
eaks=2E

> };
>=20
> #define TYPE_PCI_BONITO "Bonito"
>@@ -314,6 +328,57 @@ static void bonito_update_pcimap(PCIBonitoState *s)
>                                    FIELD_EX32(pcimap, PCIMAP, 2) << 31);
> }
>=20
>+static void pcibasecfg_decode(uint32_t mask, uint32_t trans, bool io,
>+                                     uint32_t *base, uint32_t *size)
>+{
>+    uint32_t val;
>+
>+    mask =3D (mask << 23 | 0xF0000000);
>+    val =3D ctz32(mask);
>+    *size =3D 1 << val;
>+    *base =3D (trans & ~(*size - 1)) | io << 28;
>+}
>+
>+static void bonito_update_pcibase(PCIBonitoState *s)
>+{
>+    uint32_t pcibasecfg =3D s->regs[BONITO_PCIMEMBASECFG];
>+    uint32_t size, base;
>+    uint32_t pcibase, wmask;
>+
>+    pcibasecfg_decode(FIELD_EX32(pcibasecfg, PCIMEMBASECFG, MASK0),
>+                      FIELD_EX32(pcibasecfg, PCIMEMBASECFG, TRANS0),
>+                      FIELD_EX32(pcibasecfg, PCIMEMBASECFG, IO0),
>+                      &base, &size);
>+
>+    wmask =3D ~(size - 1);
>+    /* Mask will also influence PCIBase register writable range */
>+    pci_set_long(s->dev=2Ewmask + PCI_BASE_ADDRESS_0, wmask);
>+    /* Clear RO bits in PCIBase */
>+    pcibase =3D pci_get_long(s->dev=2Econfig + PCI_BASE_ADDRESS_0);
>+    pcibase &=3D wmask;
>+    pci_set_long(s->dev=2Econfig + PCI_BASE_ADDRESS_0, pcibase);
>+    /* Adjust DMA spaces */
>+    memory_region_set_size(&s->pcihost->dma_alias[0], size);
>+    memory_region_set_alias_offset(&s->pcihost->dma_alias[0], base);
>+    memory_region_set_address(&s->pcihost->dma_alias[0], pcibase);
>+
>+    /* Ditto for PCIMEMBASECFG1 */
>+    pcibasecfg_decode(FIELD_EX32(pcibasecfg, PCIMEMBASECFG, MASK1),
>+                      FIELD_EX32(pcibasecfg, PCIMEMBASECFG, TRANS1),
>+                      FIELD_EX32(pcibasecfg, PCIMEMBASECFG, IO1),
>+                      &base, &size);
>+
>+    wmask =3D ~(size - 1);
>+    pci_set_long(s->dev=2Ewmask + PCI_BASE_ADDRESS_1, wmask);
>+    pcibase =3D pci_get_long(s->dev=2Econfig + PCI_BASE_ADDRESS_1);
>+    pcibase &=3D wmask;
>+    pci_set_long(s->dev=2Econfig + PCI_BASE_ADDRESS_1, pcibase);
>+
>+    memory_region_set_size(&s->pcihost->dma_alias[1], size);
>+    memory_region_set_alias_offset(&s->pcihost->dma_alias[1], base);
>+    memory_region_set_address(&s->pcihost->dma_alias[1], pcibase);
>+}
>+
> static void bonito_writel(void *opaque, hwaddr addr,
>                           uint64_t val, unsigned size)
> {
>@@ -624,12 +689,35 @@ static const MemoryRegionOps bonito_spciconf_ops =
=3D {
>     =2Eendianness =3D DEVICE_NATIVE_ENDIAN,
> };
>=20
>+static void bonito_pci_write_config(PCIDevice *dev, uint32_t address,
>+                                    uint32_t val, int len)
>+{
>+    pci_default_write_config(dev, address, val, len);
>+
>+    if (ranges_overlap(address, len, PCI_BASE_ADDRESS_0, 12)) {
>+        /* Bonito Host Bridge BARs are defined as DMA windows (pciBase) =
*/
>+        bonito_update_pcibase(PCI_BONITO(dev));
>+    }
>+}
>+
> static int pci_bonito_map_irq(PCIDevice *pci_dev, int irq_num)
> {
>     /* Fuloong 2E PCI INTX are connected to Bonito GPIN[3:0] */
>     return ICU_PIN_GPINx(irq_num);
> }
>=20
>+static AddressSpace *bonito_pcihost_set_iommu(PCIBus *bus, void *opaque,

s/set/get/ since it gets assigned to `get_address_space`=2E

>+                                              int devfn)
>+{
>+    BonitoState *bs =3D opaque;
>+
>+    return &bs->dma_as;
>+}
>+
>+static const PCIIOMMUOps bonito_iommu_ops =3D {
>+    =2Eget_address_space =3D bonito_pcihost_set_iommu,
>+};
>+
> static void bonito_reset_hold(Object *obj, ResetType type)
> {
>     PCIBonitoState *s =3D PCI_BONITO(obj);
>@@ -653,6 +741,11 @@ static void bonito_reset_hold(Object *obj, ResetType=
 type)
>     s->regs[BONITO_DQCFG] =3D 0x8;
>     s->regs[BONITO_MEMSIZE] =3D 0x10000000;
>     s->regs[BONITO_PCIMAP] =3D 0x6140;
>+    bonito_update_pcimap(s);
>+
>+    pci_set_long(s->dev=2Econfig + PCI_BASE_ADDRESS_0, 0x80000000);
>+    pci_set_long(s->dev=2Econfig + PCI_BASE_ADDRESS_1, 0x0);
>+    bonito_update_pcibase(s);
> }
>=20
> static const VMStateDescription vmstate_bonito =3D {
>@@ -700,6 +793,7 @@ static void bonito_pci_realize(PCIDevice *dev, Error =
**errp)
>     PCIHostState *phb =3D PCI_HOST_BRIDGE(s->pcihost);
>     BonitoState *bs =3D s->pcihost;
>     MemoryRegion *pcimem_hi_alias =3D g_new(MemoryRegion, 1);
>+    MemoryRegion *dma_alias =3D g_new(MemoryRegion, 2);
>=20
>     /*
>      * Bonito North Bridge, built on FPGA,
>@@ -764,6 +858,24 @@ static void bonito_pci_realize(PCIDevice *dev, Error=
 **errp)
>                                 (hwaddr)BONITO_PCIHI_BASE + BONITO_PCIHI=
_SIZE,
>                                 2 * GiB);
>=20
>+    /* 32bit DMA */
>+    memory_region_init(&bs->dma_mr, OBJECT(s), "dma=2EpciBase", 4 * GiB)=
;
>+
>+    /* pciBase0, mapped to system RAM */
>+    memory_region_init_alias(&dma_alias[0], NULL, "pciBase0=2Emem=2Ealia=
s",
>+                             host_mem, 0x80000000, 256 * MiB);
>+    memory_region_add_subregion_overlap(&bs->dma_mr, 0, &dma_alias[0], 2=
);
>+
>+    /* pciBase1, mapped to system RAM */
>+    memory_region_init_alias(&dma_alias[1], NULL, "pciBase1=2Emem=2Ealia=
s",
>+                            host_mem, 0, 256 * MiB);
>+    memory_region_add_subregion_overlap(&bs->dma_mr, 0, &dma_alias[1], 1=
);
>+
>+    bs->dma_alias =3D dma_alias;
>+
>+    address_space_init(&bs->dma_as, &bs->dma_mr, "pciBase=2Edma");
>+    pci_setup_iommu(phb->bus, &bonito_iommu_ops, bs);
>+
>     /* set the default value of north bridge pci config */
>     pci_set_word(dev->config + PCI_COMMAND, 0x0000);
>     pci_set_word(dev->config + PCI_STATUS, 0x0000);
>@@ -806,6 +918,7 @@ static void bonito_pci_class_init(ObjectClass *klass,=
 const void *data)
>     PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
>     ResettableClass *rc =3D RESETTABLE_CLASS(klass);
>=20
>+    k->config_write =3D bonito_pci_write_config;
>     rc->phases=2Ehold =3D bonito_reset_hold;
>     k->realize =3D bonito_pci_realize;
>     k->vendor_id =3D 0xdf53;
>

With the above comments addressed:
Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

