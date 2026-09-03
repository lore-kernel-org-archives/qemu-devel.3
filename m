Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E76EC624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:07:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x26CX-00039f-Dl; Thu, 03 Sep 2026 08:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1x26CS-0002yu-03
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 08:05:49 -0400
Received: from mx2.catap.net ([2a01:4f9:3b:5410::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1x26CP-0005LP-Ki
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 08:05:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=HSXENeI
 JsLofcj6myfLouGpyRAj20qnRyyUMOj9ivGOUfqC00yE2O1I6HJNzzgUMdVnoKKm3Nfe37
 sz+uzpKJZ1+JrX6YvmWvmhgYeZnTxHm+fBEYop4aPODuCAvUz+XzLt+pOIZewu/2ONiqjS
 kGO5VDVuD5EF/S2IBO2QLlXI/CemLaSydIUeUeexnHI7/Lwyoj+jbGWvjDh2mEK8etdWoV
 XPTwZQPimFUDm/vZ3B9KG2QGrTaOtUzRCJtR5Qs+UcyaGrNbhqCpoE1yhyZmF5UkHwUufT
 0dlKA9Wsbohf+2+0O4QgUy/8b+Y0VhYsIsDimdsLiu2EVxhFovAypEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=n
 uFO7LRIQOm580PX9X/euSBat09d/+pN13p352WestQ=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=fGULJ+aZcDCGCMt2plrs2HPOhAbPa+q2kHRtNpZi7mHFbd88kRseZlnxf6G3DVPuUrgE
 XJVnwgNplM6VBR8PbjV8eVhKyfzmD7aQAtrf5+5RrH2PVOJlSCKnG8jdDX0RN9dEERx8oi
 mlqYO/4tlSkr9+iz2WeeQtsWloEYwZh/ztJ321v06Clq9z4K0QLhY3Wi7Wf0V+oJJodr9G
 VXGuF2l54h0aLB7qpbvNMn3XbIab6dnptKPF19jEYHbxCI2D1QLm+jouAZHFoJRdfc7pjQ
 iD7wwhxYkuuza0sBEj5TE0LWazINsi6BcSVrthV5O6XKx950z9M05T6tqf3lJLYA==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=SHHRWdkh; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=mBummw1g;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=nuFO7LRI
 QOm580PX9X/euSBat09d/+pN13p352WestQ=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=SHHRWdkhlfhaLl0gCZuq2Hpbri9wf8uoVr/
 BEPW7kIjRnTG1mkMl30H7w57ELzeFM+YpEkOoDul1rFHs4qctNmg8MWUncYS0tStiT1og7
 NFUJv5qsXEdaZFzpo3u2xma944h6XVWumO0wdc2FlOZ6eORbpTUxu45NxREli9caW0mrmv
 /0L4ytKFCxl62+TSO0vT3NAaqmOp+S0VHkDvhpT84W9W7JsFgLUSCM1hWAd1Vw17iamVSH
 7EqYweVAuEqj3vFkaPPBHc9FPqcjbjl3CLzmiauSEjoSpcS6CXe6zzSlhUMB4dZv3jQ4oF
 kz9P0YLqYqrfMr5lU8LWXVCSMww==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=nuFO7LRIQOm580PX9X/euSBat09d/+pN13p352WestQ=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=mBummw1glvtUIQdB5q
 I24FIXbM4wBlHD2rnGXJdaZXV62tL5rfMVNobinVDaqEjQEB4rpySTPv53rorhO1WVAA==
Received: by mx2.catap.net (OpenSMTPD) with ESMTPSA id 13c34ed9
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 3 Sep 2026 14:05:35 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id c0f7e4e2;
 Thu, 3 Sep 2026 14:05:16 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v2 24/25] hw/pci-bridge: add Octeon PCI memory window
Date: Thu,  3 Sep 2026 14:02:12 +0200
Message-ID: <20260903120510.34876-25-kirill@korins.ky>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903120510.34876-1-kirill@korins.ky>
References: <20260903120510.34876-1-kirill@korins.ky>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f9:3b:5410::2;
 envelope-from=kirill@korins.ky; helo=mx2.catap.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Map the PCI memory aperture and PEXP register bank. Apply SUBID
controlled byte swapping to transactions between the big endian CPU and
little endian PCI memory space.
---
 hw/mips/octeon.c           |  26 ++++++
 hw/mips/octeon_internal.h  |   8 ++
 hw/pci-bridge/octeon_pci.c | 174 +++++++++++++++++++++++++++++++++++++
 3 files changed, 208 insertions(+)

diff --git a/hw/mips/octeon.c b/hw/mips/octeon.c
index 19d1451464..596fd678ff 100644
--- a/hw/mips/octeon.c
+++ b/hw/mips/octeon.c
@@ -2075,6 +2075,27 @@ static void octeon_stateful_io_write(OcteonState *s, uint64_t base,
     octeon_csr_store(s, reg, octeon_write64(old, addr, value, size));
 }
 
+static uint64_t octeon_pexp_read(void *opaque, hwaddr addr, unsigned size)
+{
+    return octeon_pci_pexp_read(opaque, addr, size);
+}
+
+static void octeon_pexp_write(void *opaque, hwaddr addr,
+                              uint64_t value, unsigned size)
+{
+    octeon_pci_pexp_write(opaque, addr, value, size);
+}
+
+static const MemoryRegionOps octeon_pexp_ops = {
+    .read = octeon_pexp_read,
+    .write = octeon_pexp_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+};
+
 static uint64_t octeon_dpi_read(void *opaque, hwaddr addr, unsigned size)
 {
     return octeon_stateful_io_read(opaque, OCTEON_DPI_BASE, addr, size);
@@ -2854,6 +2875,11 @@ static void mips_octeon_init(MachineState *machine)
     memory_region_add_subregion_overlap(get_system_memory(), OCTEON_CSR_BASE,
                                         &s->csr_bank->csr, -1);
 
+    memory_region_init_io(&s->pexp, NULL, &octeon_pexp_ops, s,
+                          "octeon.pexp", OCTEON_PEXP_SIZE);
+    memory_region_add_subregion(get_system_memory(), OCTEON_PEXP_BASE,
+                                &s->pexp);
+
     memory_region_init_io(&s->dpi, NULL, &octeon_dpi_ops, s,
                           "octeon.dpi", OCTEON_DPI_SIZE);
     memory_region_add_subregion(get_system_memory(), OCTEON_DPI_BASE,
diff --git a/hw/mips/octeon_internal.h b/hw/mips/octeon_internal.h
index c2a88dac46..f4ecbbac4f 100644
--- a/hw/mips/octeon_internal.h
+++ b/hw/mips/octeon_internal.h
@@ -18,6 +18,8 @@
 #define OCTEON_CIU_GPIO_COUNT       32
 #define OCTEON_CIU3_CP0_IRQ_COUNT   4
 #define OCTEON_CIU3_IDT_COUNT       (OCTEON_MAX_CPUS * 4)
+#define OCTEON_PEXP_BASE            0x11f0000000000ULL
+#define OCTEON_PEXP_SIZE            0x40000
 #define OCTEON_MIO_BOOT_REG_CFG_COUNT 8
 #define OCTEON_MIO_BOOT_LOC_SIZE    0x100
 #define OCTEON_MIO_EMM_BUF_SIZE     512
@@ -78,6 +80,7 @@ struct OcteonState {
     MemoryRegion boot_flash;
     MemoryRegion boot_flash_alias;
     MemoryRegion cvmseg;
+    MemoryRegion pexp;
     MemoryRegion dpi;
     MemoryRegion fpa;
     MemoryRegion ipd;
@@ -98,6 +101,8 @@ struct OcteonState {
     MemoryRegion pcie_cfg;
     MemoryRegion pcie_sli_cfg;
     MemoryRegion pcie0_io;
+    MemoryRegion pcie0_mem;
+    AddressSpace pcie0_mem_as;
 
     DeviceState *pci_host;
     PCIBus *pci_bus;
@@ -122,5 +127,8 @@ uint64_t octeon_pci_pem_read(OcteonState *s, hwaddr reg,
                              hwaddr addr, unsigned size);
 void octeon_pci_pem_write(OcteonState *s, hwaddr reg, hwaddr addr,
                           uint64_t value, unsigned size);
+uint64_t octeon_pci_pexp_read(OcteonState *s, hwaddr addr, unsigned size);
+void octeon_pci_pexp_write(OcteonState *s, hwaddr addr,
+                           uint64_t value, unsigned size);
 
 #endif
diff --git a/hw/pci-bridge/octeon_pci.c b/hw/pci-bridge/octeon_pci.c
index e2f856e164..02c42c4d09 100644
--- a/hw/pci-bridge/octeon_pci.c
+++ b/hw/pci-bridge/octeon_pci.c
@@ -7,6 +7,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 #include "qapi/error.h"
 #include "hw/core/resettable.h"
 #include "hw/core/sysbus.h"
@@ -14,6 +15,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
 #include "qemu/module.h"
+#include "system/address-spaces.h"
 #include "system/memory.h"
 
 #define TYPE_OCTEON_PCI_HOST "octeon-pci-host"
@@ -29,7 +31,15 @@ OBJECT_DECLARE_TYPE(OcteonPCIHostState, OcteonPCIHostClass,
     (OCTEON_PCIE_SLI_CFG_PORTS * OCTEON_PCIE_SLI_CFG_PORT_SIZE)
 #define OCTEON_PCIE0_IO_BASE        0x11a0400000000ULL
 #define OCTEON_PCIE0_IO_SIZE        (1ULL << 32)
+#define OCTEON_PCIE0_MEM_BASE       0x11b0000000000ULL
 #define OCTEON_PCIE0_MEM_SIZE       (1ULL << 32)
+#define OCTEON_SLI_MEM_ACCESS_SUBID_BASE   0x000000e0
+#define OCTEON_SLI_MEM_ACCESS_SUBID_STRIDE 16
+#define OCTEON_SLI_MEM_ACCESS_SUBID_ESR_M  0x0000003000000000ULL
+#define OCTEON_SLI_MEM_ACCESS_SUBID_ESR_S  36
+#define OCTEON_SLI_MEM_ACCESS_SUBID_ESW_M  0x0000000c00000000ULL
+#define OCTEON_SLI_MEM_ACCESS_SUBID_ESW_S  34
+#define OCTEON_SLI_MEM_ACCESS_SWAP         3
 #define OCTEON_PCIE0_ENDPOINT_DEVFN PCI_DEVFN(0x0b, 0)
 #define OCTEON_PEMX_CFG_WR0         0xc0000028
 #define OCTEON_PEMX_CFG_RD0         0xc0000030
@@ -45,6 +55,7 @@ struct OcteonPCIHostState {
     uint32_t pem_cfg_rd_addr;
     uint64_t pem_cfg_wr;
     GHashTable *root_cfg;
+    GHashTable *pexp_regs;
 };
 
 struct OcteonPCIHostClass {
@@ -64,6 +75,7 @@ static void octeon_pci_host_reset_hold(Object *obj, ResetType type)
     host->pem_cfg_rd_addr = 0;
     host->pem_cfg_wr = 0;
     g_hash_table_remove_all(host->root_cfg);
+    g_hash_table_remove_all(host->pexp_regs);
 }
 
 static OcteonPCIHostState *octeon_pci_host(OcteonState *s)
@@ -160,6 +172,34 @@ void octeon_pci_pem_write(OcteonState *s, hwaddr reg, hwaddr addr,
     }
 }
 
+uint64_t octeon_pci_pexp_read(OcteonState *s, hwaddr addr, unsigned size)
+{
+    OcteonPCIHostState *host = octeon_pci_host(s);
+    uint64_t reg = OCTEON_PEXP_BASE + (addr & ~7ULL);
+    uint64_t value;
+
+    if (!octeon_reg_lookup(host->pexp_regs, reg, &value)) {
+        value = 0;
+    }
+
+    return octeon_read64(value, addr, size);
+}
+
+void octeon_pci_pexp_write(OcteonState *s, hwaddr addr,
+                           uint64_t value, unsigned size)
+{
+    OcteonPCIHostState *host = octeon_pci_host(s);
+    uint64_t reg = OCTEON_PEXP_BASE + (addr & ~7ULL);
+    uint64_t old;
+
+    if (!octeon_reg_lookup(host->pexp_regs, reg, &old)) {
+        old = 0;
+    }
+
+    octeon_reg_store(host->pexp_regs, reg,
+                     octeon_write64(old, addr, value, size));
+}
+
 static uint64_t octeon_pci_absent(unsigned size)
 {
     return size == 1 ? 0xff : size == 2 ? 0xffff : 0xffffffffU;
@@ -256,6 +296,130 @@ static const MemoryRegionOps octeon_pcie_sli_cfg_ops = {
     },
 };
 
+static uint64_t octeon_pcie_bswap(uint64_t value, unsigned size)
+{
+    switch (size) {
+    case 1:
+        return value;
+    case 2:
+        return bswap16(value);
+    case 4:
+        return bswap32(value);
+    case 8:
+        return bswap64(value);
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static uint64_t octeon_pcie_mem_subid_reg(hwaddr addr)
+{
+    unsigned int subid = (addr >> 28) & 3;
+
+    return OCTEON_PEXP_BASE + OCTEON_SLI_MEM_ACCESS_SUBID_BASE +
+           subid * OCTEON_SLI_MEM_ACCESS_SUBID_STRIDE;
+}
+
+static bool octeon_pcie_mem_swap_enabled(OcteonPCIHostState *host,
+                                         hwaddr addr, bool write)
+{
+    uint64_t value;
+    uint64_t mask = write ? OCTEON_SLI_MEM_ACCESS_SUBID_ESW_M :
+                            OCTEON_SLI_MEM_ACCESS_SUBID_ESR_M;
+    unsigned int shift = write ? OCTEON_SLI_MEM_ACCESS_SUBID_ESW_S :
+                                 OCTEON_SLI_MEM_ACCESS_SUBID_ESR_S;
+
+    if (!octeon_reg_lookup(host->pexp_regs,
+                           octeon_pcie_mem_subid_reg(addr), &value)) {
+        return false;
+    }
+
+    return ((value & mask) >> shift) == OCTEON_SLI_MEM_ACCESS_SWAP;
+}
+
+static uint64_t octeon_pcie0_mem_read(void *opaque, hwaddr addr,
+                                      unsigned size)
+{
+    OcteonState *s = opaque;
+    OcteonPCIHostState *host = octeon_pci_host(s);
+    uint64_t value;
+
+    switch (size) {
+    case 1:
+        value = address_space_ldub(&s->pcie0_mem_as, addr,
+                                   MEMTXATTRS_UNSPECIFIED, NULL);
+        break;
+    case 2:
+        value = address_space_lduw_le(&s->pcie0_mem_as, addr,
+                                      MEMTXATTRS_UNSPECIFIED, NULL);
+        break;
+    case 4:
+        value = address_space_ldl_le(&s->pcie0_mem_as, addr,
+                                     MEMTXATTRS_UNSPECIFIED, NULL);
+        break;
+    case 8:
+        value = address_space_ldq_le(&s->pcie0_mem_as, addr,
+                                     MEMTXATTRS_UNSPECIFIED, NULL);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (TARGET_BIG_ENDIAN &&
+        !octeon_pcie_mem_swap_enabled(host, addr, false)) {
+        value = octeon_pcie_bswap(value, size);
+    }
+
+    return value;
+}
+
+static void octeon_pcie0_mem_write(void *opaque, hwaddr addr,
+                                   uint64_t value, unsigned size)
+{
+    OcteonState *s = opaque;
+    OcteonPCIHostState *host = octeon_pci_host(s);
+
+    if (TARGET_BIG_ENDIAN &&
+        !octeon_pcie_mem_swap_enabled(host, addr, true)) {
+        value = octeon_pcie_bswap(value, size);
+    }
+
+    switch (size) {
+    case 1:
+        address_space_stb(&s->pcie0_mem_as, addr, value,
+                          MEMTXATTRS_UNSPECIFIED, NULL);
+        break;
+    case 2:
+        address_space_stw_le(&s->pcie0_mem_as, addr, value,
+                             MEMTXATTRS_UNSPECIFIED, NULL);
+        break;
+    case 4:
+        address_space_stl_le(&s->pcie0_mem_as, addr, value,
+                             MEMTXATTRS_UNSPECIFIED, NULL);
+        break;
+    case 8:
+        address_space_stq_le(&s->pcie0_mem_as, addr, value,
+                             MEMTXATTRS_UNSPECIFIED, NULL);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static const MemoryRegionOps octeon_pcie0_mem_ops = {
+    .read = octeon_pcie0_mem_read,
+    .write = octeon_pcie0_mem_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+    },
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+    },
+};
+
 static int octeon_pci_map_irq(PCIDevice *pci_dev, int irq_num)
 {
     return 0;
@@ -273,6 +437,9 @@ static void octeon_pci_host_init(Object *obj)
     host->root_cfg = g_hash_table_new_full(octeon_uint64_hash,
                                            octeon_uint64_equal,
                                            g_free, g_free);
+    host->pexp_regs = g_hash_table_new_full(octeon_uint64_hash,
+                                            octeon_uint64_equal,
+                                            g_free, g_free);
 }
 
 static void octeon_pci_host_finalize(Object *obj)
@@ -280,6 +447,7 @@ static void octeon_pci_host_finalize(Object *obj)
     OcteonPCIHostState *host = OCTEON_PCI_HOST(obj);
 
     g_hash_table_destroy(host->root_cfg);
+    g_hash_table_destroy(host->pexp_regs);
 }
 
 static void octeon_pci_host_class_init(ObjectClass *klass, const void *data)
@@ -353,4 +521,10 @@ void octeon_init_pci(OcteonState *s)
     memory_region_add_subregion(get_system_memory(), OCTEON_PCIE0_IO_BASE,
                                 &s->pcie0_io);
 
+    address_space_init(&s->pcie0_mem_as, &host->mem,
+                       "octeon.pcie0-mem-as");
+    memory_region_init_io(&s->pcie0_mem, NULL, &octeon_pcie0_mem_ops, s,
+                          "octeon.pcie0-mem", OCTEON_PCIE0_MEM_SIZE);
+    memory_region_add_subregion(get_system_memory(), OCTEON_PCIE0_MEM_BASE,
+                                &s->pcie0_mem);
 }
-- 
2.55.0


