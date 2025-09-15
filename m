Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C64CAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 10:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy6u4-0000h8-QY; Mon, 15 Sep 2025 06:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uy6u1-0000eu-P2
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:57:45 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uy6tq-0003ZV-FE
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:57:42 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3ea3d3ae48fso650976f8f.1
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 03:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757933847; x=1758538647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C6i2DRzYJIis/Uk2wN5NldLokmy+IT755gxvFSuanb8=;
 b=Tb4SZx6r65ZNZ1xsHyZM4GemgUtkX45OTRzGPcxaAwodTxnbwGSvIY2IlCnPQfmOO4
 ni5wWVJMW06zaCArRWhZO+vEhgs7uU2EvcYDhM6biN4/k2OJOcF/aRq6xlbKOz2YX61w
 gQYXbhaobnwAQ0ldzqa/EFnEtpRT0pZDidsPX89WahOgvGHixlypsOBc3TUPXyiC88vN
 rSBE6kzlgdccv3WfBL+GTIuMhbN/sA2onlY5UKo9tyMgRf6whTMs+DM8gQHiVUq125vM
 hsrEMNgS+kwbJH7nzzhxVHcaPkvUrDIkfJdS9KxwMrLkKbg9827v+EkQmR0sYnI98Ymu
 vaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757933847; x=1758538647;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C6i2DRzYJIis/Uk2wN5NldLokmy+IT755gxvFSuanb8=;
 b=l7/0EK+3RUwMgyyzgZauZHuPpJrBYzrbJiPxlH6LDWKgd06QkoifNXPbfnVPDwFHes
 SkYrn71y72aSxaoVUkcpt7Thf2LJxEkY/WTAI4JSu+fDFOWvFRtNsUCvN/PT9WuA/M7n
 dTF325W88c8oQSGw0sbt6/E2CoWU4kKz8l3Nh14Htc55430e3sLzNz5WdwCfiJm9+CF3
 UK9QET/lI+akfzijzRxBt/SJtUk41djhkNZikSFxYRsmq3Bh9dM31APa8caecF7mOSpz
 Nd8Wvuam6hvKeCVhrsk01d/oNgUZO2M2m53vFhnPbjjj9gZzfIxfEAl04gVERQcjdad6
 0sXw==
X-Gm-Message-State: AOJu0YwbqRYq3M+orHFY0dKGaIBUMIrGrOEKWyP0TvhHYfCl6tp+OhGk
 SxGECvotxK+7//qfsxY+DaAJwjEcv0rJGS7hSDHW6nWlOIcv/eJ2n9L5tLtS5Q==
X-Gm-Gg: ASbGnctdAVVnHacACZV5vecW1CNnV5ZmvEAsM9461A7cYrTdEIm5Mp2JKfr6gGr3kXn
 btl9lZFHlk2eKKUuSx9C+/Yxgiyfg+JoOU+PfvEWbrZHxCADAcOXp92ObYoucj+5mCG7J4emgFh
 dbXTA3g6HLN6uPzisqxtpdl4DAXLDLGDPGxLD8HouTAYpsWkMsqI0u5HbI80BPkd0vl7YJzLmvn
 mNTQ3XHMtJcR2wByvWva3VCe/SJF0eCEgaSqEt6rGQemrH4JiEuQp+ArMSe2V2s+0UrEqZep+Ej
 03D7JRFVk04SqGRQ9WVWY3zMQ8Ssyy2pnpsOIpltIzpYMXRl0qDiulkbBRFxO5rGt4pCETymwSk
 u1ZUFLnBs3kGH9hvk0XZrchkUyXCUD8t8RKT8rroI
X-Google-Smtp-Source: AGHT+IE+F3vj+Xv2Ch2AWYx/Mnrh0LuKDZBudyo8pOSHCzhGBxf8Zbe/N4aBIeoQdOuuWh/7zuSlsA==
X-Received: by 2002:a05:6000:240a:b0:3dc:1473:17fb with SMTP id
 ffacd0b85a97d-3e75e146ed0mr11159486f8f.20.1757933847313; 
 Mon, 15 Sep 2025 03:57:27 -0700 (PDT)
Received: from ehlo.thunderbird.net ([185.238.219.94])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e9511abbccsm7446860f8f.9.2025.09.15.03.57.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Sep 2025 03:57:26 -0700 (PDT)
Date: Mon, 15 Sep 2025 10:48:44 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
CC: Huacai Chen <chenhuacai@kernel.org>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 4/5] hw/pci-host/bonito: Rework PCI config space accessor
In-Reply-To: <20250508-bonito-v1-4-4f9f27733028@flygoat.com>
References: <20250508-bonito-v1-0-4f9f27733028@flygoat.com>
 <20250508-bonito-v1-4-4f9f27733028@flygoat.com>
Message-ID: <A03AF224-5F3F-43A7-A24E-ED1B4CE35385@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x434.google.com
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



Am 8=2E Mai 2025 14:46:09 UTC schrieb Jiaxun Yang <jiaxun=2Eyang@flygoat=
=2Ecom>:
>The original PCI config space accessor failed to issue master abort
>interrupt as necessary, it also didn't handle type 1 access and
>using south bridge concept which doesn't exist in Bonito=2E
>
>Rework the whole mechanism accorading to the manual, also remove
>inaccurate comments=2E
>
>Signed-off-by: Jiaxun Yang <jiaxun=2Eyang@flygoat=2Ecom>
>---
> hw/pci-host/bonito=2Ec     | 202 ++++++++++++++++++---------------------=
--------
> hw/pci-host/trace-events |   3 -
> 2 files changed, 75 insertions(+), 130 deletions(-)
>
>diff --git a/hw/pci-host/bonito=2Ec b/hw/pci-host/bonito=2Ec
>index 1c0d502a1e2dfa3c9803ca219cf505e08bf94a75=2E=2E49b4be26393a08eda4f99=
c8e2ef8a0c455c57bc0 100644
>--- a/hw/pci-host/bonito=2Ec
>+++ b/hw/pci-host/bonito=2Ec
>@@ -14,30 +14,6 @@
>  * fuloong 2e mini pc has a bonito north bridge=2E
>  */
>=20
>-/*
>- * what is the meaning of devfn in qemu and IDSEL in bonito northbridge?
>- *
>- * devfn   pci_slot<<3  + funno
>- * one pci bus can have 32 devices and each device can have 8 functions=
=2E
>- *
>- * In bonito north bridge, pci slot =3D IDSEL bit - 12=2E
>- * For example, PCI_IDSEL_VIA686B =3D 17,
>- * pci slot =3D 17-12=3D5
>- *
>- * so
>- * VT686B_FUN0's devfn =3D (5<<3)+0
>- * VT686B_FUN1's devfn =3D (5<<3)+1
>- *
>- * qemu also uses pci address for north bridge to access pci config regi=
ster=2E
>- * bus_no   [23:16]
>- * dev_no   [15:11]
>- * fun_no   [10:8]
>- * reg_no   [7:2]
>- *
>- * so function bonito_sbridge_pciaddr for the translation from
>- * north bridge address to pci address=2E
>- */
>-
> #include "qemu/osdep=2Eh"
> #include "qemu/units=2Eh"
> #include "qapi/error=2Eh"
>@@ -106,11 +82,6 @@
> #define BONITO_INTERNAL_REG_BASE  (BONITO_REGBASE + BONITO_REG_BASE)
> #define BONITO_INTERNAL_REG_SIZE  (0x70)
>=20
>-#define BONITO_SPCICONFIG_BASE  (BONITO_PCICFG_BASE)
>-#define BONITO_SPCICONFIG_SIZE  (BONITO_PCICFG_SIZE)
>-
>-
>-
> /* 1=2E Bonito h/w Configuration */
> /* Power on register */
>=20
>@@ -156,6 +127,9 @@ FIELD(PCIMEMBASECFG, IO1, 23, 1)
>=20
>=20
> #define BONITO_PCIMAP_CFG       (0x18 >> 2)      /* 0x118 */
>+REG32(PCIMAP_CFG,    0x118)
>+FIELD(PCIMAP_CFG, AD16UP, 0, 16)
>+FIELD(PCIMAP_CFG, TYPE1, 16, 1)
>=20
> /* 5=2E ICU & GPIO regs */
> /* GPIO Regs - r/w */
>@@ -214,23 +188,14 @@ FIELD(PCIMEMBASECFG, IO1, 23, 1)
>=20
> #define BONITO_REGS             (0x70 >> 2)
>=20
>-/* PCI config for south bridge=2E type 0 */
>-#define BONITO_PCICONF_IDSEL_MASK      0xfffff800     /* [31:11] */
>-#define BONITO_PCICONF_IDSEL_OFFSET    11
>-#define BONITO_PCICONF_FUN_MASK        0x700    /* [10:8] */
>-#define BONITO_PCICONF_FUN_OFFSET      8
>-#define BONITO_PCICONF_REG_MASK_DS     (~3)         /* Per datasheet */
>-#define BONITO_PCICONF_REG_MASK_HW     0xff         /* As seen running P=
MON */
>-#define BONITO_PCICONF_REG_OFFSET      0
>-
>+/* PCI Access Cycle Fields */
>+FIELD(TYPE0_CYCLE, FUNC, 8, 3)
>+FIELD(TYPE0_CYCLE, IDSEL, 11, 21)
>=20
>-/* idsel BIT =3D pci slot number +12 */
>-#define PCI_SLOT_BASE              12
>-#define PCI_IDSEL_VIA686B_BIT      (17)
>-#define PCI_IDSEL_VIA686B          (1 << PCI_IDSEL_VIA686B_BIT)
>-
>-#define PCI_ADDR(busno , devno , funno , regno)  \
>-    ((PCI_BUILD_BDF(busno, PCI_DEVFN(devno , funno)) << 8) + (regno))
>+FIELD(TYPE1_CYCLE, FUNC, 8, 3)
>+FIELD(TYPE1_CYCLE, DEV, 11, 5)
>+FIELD(TYPE1_CYCLE, BUS, 16, 8)
>+FIELD(TYPE1_CYCLE, IDSEL, 24, 8)
>=20
> typedef struct BonitoState BonitoState;
>=20
>@@ -580,108 +545,91 @@ static const MemoryRegionOps bonito_cop_ops =3D {
>     },
> };
>=20
>-static uint32_t bonito_sbridge_pciaddr(void *opaque, hwaddr addr)
>+static PCIDevice *bonito_pcihost_cfg_decode(PCIBonitoState *s, hwaddr ad=
dr)
> {
>-    PCIBonitoState *s =3D opaque;
>     PCIHostState *phb =3D PCI_HOST_BRIDGE(s->pcihost);
>-    uint32_t cfgaddr;
>-    uint32_t idsel;
>-    uint32_t devno;
>-    uint32_t funno;
>-    uint32_t regno;
>-    uint32_t pciaddr;
>-
>-    /* support type0 pci config */
>-    if ((s->regs[BONITO_PCIMAP_CFG] & 0x10000) !=3D 0x0) {
>-        return 0xffffffff;
>+    uint32_t pcimap_cfg =3D s->regs[BONITO_PCIMAP_CFG];
>+    uint32_t cycle, dev, func, bus;
>+
>+    cycle =3D addr | FIELD_EX32(pcimap_cfg, PCIMAP_CFG, AD16UP) << 16;
>+
>+    if (FIELD_EX32(pcimap_cfg, PCIMAP_CFG, TYPE1)) {
>+        dev =3D FIELD_EX32(cycle, TYPE1_CYCLE, DEV);
>+        func =3D FIELD_EX32(cycle, TYPE1_CYCLE, FUNC);
>+        bus =3D FIELD_EX32(cycle, TYPE1_CYCLE, BUS);
>+    } else {
>+        uint32_t idsel =3D FIELD_EX32(cycle, TYPE0_CYCLE, IDSEL);
>+        if (idsel =3D=3D 0) {
>+            return NULL;
>+        }
>+        dev =3D ctz32(idsel);
>+        func =3D FIELD_EX32(cycle, TYPE0_CYCLE, FUNC);
>+        bus =3D 0;
>     }
>=20
>-    cfgaddr =3D addr & 0xffff;
>-    cfgaddr |=3D (s->regs[BONITO_PCIMAP_CFG] & 0xffff) << 16;
>+    return pci_find_device(phb->bus, bus, PCI_DEVFN(dev, func));
>+}
>=20
>-    idsel =3D (cfgaddr & BONITO_PCICONF_IDSEL_MASK) >>
>-             BONITO_PCICONF_IDSEL_OFFSET;
>-    devno =3D ctz32(idsel);
>-    funno =3D (cfgaddr & BONITO_PCICONF_FUN_MASK) >> BONITO_PCICONF_FUN_=
OFFSET;
>-    regno =3D (cfgaddr & BONITO_PCICONF_REG_MASK_HW) >> BONITO_PCICONF_R=
EG_OFFSET;
>+static void bonito_pcihost_signal_mabort(PCIBonitoState *s)
>+{
>+    PCIDevice *d =3D &s->dev;
>+    uint16_t status =3D pci_get_word(d->config + PCI_STATUS);
>=20
>-    if (idsel =3D=3D 0) {
>-        error_report("error in bonito pci config address 0x" HWADDR_FMT_=
plx
>-                     ",pcimap_cfg=3D0x%x", addr, s->regs[BONITO_PCIMAP_C=
FG]);
>-        exit(1);
>-    }
>-    pciaddr =3D PCI_ADDR(pci_bus_num(phb->bus), devno, funno, regno);
>-    DPRINTF("cfgaddr %x pciaddr %x busno %x devno %d funno %d regno %d\n=
",
>-        cfgaddr, pciaddr, pci_bus_num(phb->bus), devno, funno, regno);
>+    status |=3D PCI_STATUS_REC_MASTER_ABORT;
>+    pci_set_word(d->config + PCI_STATUS, status);
>=20
>-    return pciaddr;
>+    /* Generate a pulse, it's a edge triggered IRQ */
>+    bonito_set_irq(s->pcihost, ICU_PIN_MASTERERR, 1);
>+    bonito_set_irq(s->pcihost, ICU_PIN_MASTERERR, 0);
> }
>=20
>-static void bonito_spciconf_write(void *opaque, hwaddr addr, uint64_t va=
l,
>-                                  unsigned size)
>+static MemTxResult bonito_pcihost_cfg_read(void *opaque, hwaddr addr,
>+                                           uint64_t *data, unsigned len,
>+                                           MemTxAttrs attrs)
> {
>     PCIBonitoState *s =3D opaque;
>-    PCIDevice *d =3D PCI_DEVICE(s);
>-    PCIHostState *phb =3D PCI_HOST_BRIDGE(s->pcihost);
>-    uint32_t pciaddr;
>-    uint16_t status;
>-
>-    DPRINTF("bonito_spciconf_write "HWADDR_FMT_plx" size %d val %lx\n",
>-            addr, size, val);
>-
>-    pciaddr =3D bonito_sbridge_pciaddr(s, addr);
>-
>-    if (pciaddr =3D=3D 0xffffffff) {
>-        return;
>-    }
>-    if (addr & ~BONITO_PCICONF_REG_MASK_DS) {
>-        trace_bonito_spciconf_small_access(addr, size);
>+    PCIDevice *dev;
>+
>+    dev =3D bonito_pcihost_cfg_decode(s, addr);
>+    if (!dev) {
>+        bonito_pcihost_signal_mabort(s);
>+        /*
>+         * Vanilla bonito will actually triiger a bus error on master ab=
ort,
>+         * Godson variant won't=2E We need to return all 1s=2E
>+         */
>+        *data =3D UINT64_MAX;
>+        return MEMTX_OK;
>     }
>=20
>-    /* set the pci address in s->config_reg */
>-    phb->config_reg =3D (pciaddr) | (1u << 31);
>-    pci_data_write(phb->bus, phb->config_reg, val, size);
>+    addr &=3D PCI_CONFIG_SPACE_SIZE - 1;
>+    *data =3D pci_host_config_read_common(dev, addr, pci_config_size(dev=
), len);
>=20
>-    /* clear PCI_STATUS_REC_MASTER_ABORT and PCI_STATUS_REC_TARGET_ABORT=
 */
>-    status =3D pci_get_word(d->config + PCI_STATUS);
>-    status &=3D ~(PCI_STATUS_REC_MASTER_ABORT | PCI_STATUS_REC_TARGET_AB=
ORT);
>-    pci_set_word(d->config + PCI_STATUS, status);
>+    return MEMTX_OK;
> }
>=20
>-static uint64_t bonito_spciconf_read(void *opaque, hwaddr addr, unsigned=
 size)
>+static MemTxResult bonito_pcihost_cfg_write(void *opaque, hwaddr addr,
>+                                            uint64_t data, unsigned len,
>+                                            MemTxAttrs attrs)
> {
>     PCIBonitoState *s =3D opaque;
>-    PCIDevice *d =3D PCI_DEVICE(s);
>-    PCIHostState *phb =3D PCI_HOST_BRIDGE(s->pcihost);
>-    uint32_t pciaddr;
>-    uint16_t status;
>-
>-    DPRINTF("bonito_spciconf_read "HWADDR_FMT_plx" size %d\n", addr, siz=
e);
>+    PCIDevice *dev;
>=20
>-    pciaddr =3D bonito_sbridge_pciaddr(s, addr);
>-
>-    if (pciaddr =3D=3D 0xffffffff) {
>-        return MAKE_64BIT_MASK(0, size * 8);
>-    }
>-    if (addr & ~BONITO_PCICONF_REG_MASK_DS) {
>-        trace_bonito_spciconf_small_access(addr, size);
>+    dev =3D bonito_pcihost_cfg_decode(s, addr);
>+    if (!dev) {
>+        bonito_pcihost_signal_mabort(s);
>+        return MEMTX_OK;
>     }
>=20
>-    /* set the pci address in s->config_reg */
>-    phb->config_reg =3D (pciaddr) | (1u << 31);
>-
>-    /* clear PCI_STATUS_REC_MASTER_ABORT and PCI_STATUS_REC_TARGET_ABORT=
 */
>-    status =3D pci_get_word(d->config + PCI_STATUS);
>-    status &=3D ~(PCI_STATUS_REC_MASTER_ABORT | PCI_STATUS_REC_TARGET_AB=
ORT);
>-    pci_set_word(d->config + PCI_STATUS, status);
>+    addr &=3D PCI_CONFIG_SPACE_SIZE - 1;
>+    pci_host_config_write_common(dev, addr, pci_config_size(dev), data, =
len);
>=20
>-    return pci_data_read(phb->bus, phb->config_reg, size);
>+    return MEMTX_OK;
> }
>=20
>-/* south bridge PCI configure space=2E 0x1fe8 0000 - 0x1fef ffff */
>-static const MemoryRegionOps bonito_spciconf_ops =3D {
>-    =2Eread =3D bonito_spciconf_read,
>-    =2Ewrite =3D bonito_spciconf_write,
>+/* PCI Configure Space access region=2E 0x1fe8 0000 - 0x1fef ffff */

s/Configure Space/configuration space/

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

>+static const MemoryRegionOps bonito_pcihost_cfg_ops =3D {
>+    =2Eread_with_attrs =3D bonito_pcihost_cfg_read,
>+    =2Ewrite_with_attrs =3D bonito_pcihost_cfg_write,
>     =2Evalid=2Emin_access_size =3D 1,
>     =2Evalid=2Emax_access_size =3D 4,
>     =2Eimpl=2Emin_access_size =3D 1,
>@@ -812,10 +760,10 @@ static void bonito_pci_realize(PCIDevice *dev, Erro=
r **errp)
>     memory_region_add_subregion(host_mem, BONITO_PCICONFIG_BASE,
>                                 &phb->conf_mem);
>=20
>-    /* set the south bridge pci configure  mapping */
>-    memory_region_init_io(&phb->data_mem, OBJECT(s), &bonito_spciconf_op=
s, s,
>-                          "south-bridge-pci-config", BONITO_SPCICONFIG_S=
IZE);
>-    memory_region_add_subregion(host_mem, BONITO_SPCICONFIG_BASE,
>+    /* set the pci config space accessor mapping */
>+    memory_region_init_io(&phb->data_mem, OBJECT(s), &bonito_pcihost_cfg=
_ops, s,
>+                          "pci-host-config-access", BONITO_PCICFG_SIZE);
>+    memory_region_add_subregion(host_mem, BONITO_PCICFG_BASE,
>                                 &phb->data_mem);
>=20
>     create_unimplemented_device("bonito", BONITO_REG_BASE, BONITO_REG_SI=
ZE);
>diff --git a/hw/pci-host/trace-events b/hw/pci-host/trace-events
>index 0a816b9aa129bb0c37d207e2612e09ac4762d51a=2E=2Ebd9bdeadfd3678e303a41=
2688d689cc01d06f709 100644
>--- a/hw/pci-host/trace-events
>+++ b/hw/pci-host/trace-events
>@@ -1,8 +1,5 @@
> # See docs/devel/tracing=2Erst for syntax documentation=2E
>=20
>-# bonito=2Ec
>-bonito_spciconf_small_access(uint64_t addr, unsigned size) "PCI config a=
ddress is smaller then 32-bit, addr: 0x%"PRIx64", size: %u"
>-
> # grackle=2Ec
> grackle_set_irq(int irq_num, int level) "set_irq num %d level %d"
>=20
>

