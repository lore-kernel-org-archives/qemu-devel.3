Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 206B2C5DF71
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 07:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUJr5-0006B3-6K; Tue, 02 Jun 2026 03:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1wUJr2-00069c-Td; Tue, 02 Jun 2026 03:48:04 -0400
Received: from [115.124.30.97] (helo=out30-97.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1wUJr0-0004vi-A0; Tue, 02 Jun 2026 03:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780386456; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=8lZQdxMRvn1C3XUCXtvDihVYcgry9SAPjkeEBCgc8SQ=;
 b=SsYjWI6zOTUfs52tBALhoWyP4sY8WvVh5g+JhRleINXuoD1SOBzdLEZOPrJRggQKUj69V+8DcMI/oFbe5ONKr81qn5Sn0c1QIDZn9HS/C1vWw0p3UGCqZyTPBH05yA0XuHuDroWwdjH8K/EbekAFf8KaMNe6bvieu6WoKvYRCUk=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=cp0613@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0X43o4Na_1780386142; 
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com
 fp:SMTPD_---0X43o4Na_1780386142 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 02 Jun 2026 15:42:22 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: pbonzini@redhat.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 sunilvl@ventanamicro.com, jonathan.cameron@huawei.com, fan.ni@samsung.com,
 guoren@kernel.org
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Chen Pei <cp0613@linux.alibaba.com>
Subject: [PATCH 4/4] hw/cxl: Map committed HDM decoder ranges as RAM for
 direct DMA
Date: Tue,  2 Jun 2026 15:41:27 +0800
Message-ID: <20260602074127.63819-5-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602074127.63819-1-cp0613@linux.alibaba.com>
References: <20260602074127.63819-1-cp0613@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.97 (deferred)
Received-SPF: pass client-ip=115.124.30.97;
 envelope-from=cp0613@linux.alibaba.com; helo=out30-97.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

The CXL Fixed Memory Window (CFMW) is registered with
memory_region_init_io() and has no backing ram_block.  As a result
address_space_map() on a guest physical address inside the CFMW
takes the bounce-buffer path and is bounded by
DEFAULT_MAX_BOUNCE_BUFFER_SIZE (4 KiB by default for the system
AddressSpace).  Once a Type-3 device is brought online as system RAM
(daxctl online-memory), the kernel happily allocates DMA buffers from
the CFMW range and any virtio operation whose scatter list exceeds
4 KiB or that overlaps with another in-flight transfer fails with:

    qemu-system-riscv64: virtio: bogus descriptor or out of resources

The bug is not RISC-V specific: CFMW registration and the bounce
buffer limit are both arch-agnostic, so any guest that onlines CXL
memory and issues DMA larger than 4 KiB into it is affected.  It
shows up first on RISC-V virt because that is where the rest of
this series enables the daxctl + virtio path end-to-end.

Reproduce on RISC-V virt with cxl=on and a single Type-3 device:

    cxl create-region -m -t ram -d decoder0.0 -w 1 mem0 -s 4G
    daxctl online-memory dax0.0
    free -h    # triggers the error and stalls the guest

Fix it by overlaying a RAM alias of the device's memory backend
(hostvmem / hostpmem) at the committed HDM decoder's HPA range, with
higher priority than the CFMW I/O region.  flatview_translate() then
hits the alias, address_space_map() returns a direct host pointer,
and DMA proceeds without bouncing.  This mirrors the existing QEMU
pattern of PCI BAR and IOMMU MR overlays.  The alias is torn down on
hdm_decoder_uncommit() so subsequent region tear-down + re-creation
works.

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 hw/mem/cxl_type3.c          | 81 +++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h |  4 ++
 2 files changed, 85 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 4739239da3..f962bce66a 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -24,6 +24,7 @@
 #include "qemu/module.h"
 #include "qemu/pmem.h"
 #include "qemu/range.h"
+#include "system/address-spaces.h"
 #include "qemu/rcu.h"
 #include "qemu/guest-random.h"
 #include "system/hostmem.h"
@@ -420,6 +421,11 @@ static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
     ComponentRegisters *cregs = &ct3d->cxl_cstate.crb;
     uint32_t *cache_mem = cregs->cache_mem_registers;
     uint32_t ctrl;
+    uint32_t low, high;
+    uint64_t decoder_base, decoder_size;
+    MemoryRegion *mr = NULL;
+    uint64_t dpa_offset = 0;
+    char *alias_name;
 
     ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc);
     /* TODO: Sanity checks that the decoder is possible */
@@ -427,6 +433,73 @@ static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
 
     stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc, ctrl);
+
+    /*
+     * Create a RAM alias in system memory for the committed decoder range.
+     * This enables direct DMA mapping (address_space_map) for devices like
+     * virtio that need to DMA to/from CXL memory.  Without this, the CFMW
+     * I/O region would require bounce buffering which is limited to 4KB.
+     */
+    low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_LO + which * hdm_inc);
+    high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_HI + which * hdm_inc);
+    decoder_base = ((uint64_t)high << 32) | (low & 0xf0000000);
+
+    low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_LO + which * hdm_inc);
+    high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_HI + which * hdm_inc);
+    decoder_size = ((uint64_t)high << 32) | (low & 0xf0000000);
+
+    if (!decoder_base || !decoder_size) {
+        return;
+    }
+
+    /* Calculate DPA offset by summing sizes of preceding decoders */
+    for (int i = 0; i < which; i++) {
+        uint32_t prev_low, prev_high;
+        uint64_t prev_size;
+        uint32_t prev_ctrl;
+
+        prev_ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL +
+                             i * hdm_inc);
+        if (!FIELD_EX32(prev_ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED)) {
+            continue;
+        }
+        prev_low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_LO +
+                            i * hdm_inc);
+        prev_high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_HI +
+                             i * hdm_inc);
+        prev_size = ((uint64_t)prev_high << 32) | (prev_low & 0xf0000000);
+        dpa_offset += prev_size;
+    }
+
+    /* Determine which memory backend to alias */
+    if (ct3d->hostvmem) {
+        MemoryRegion *vmr = host_memory_backend_get_memory(ct3d->hostvmem);
+        uint64_t vmr_size = memory_region_size(vmr);
+
+        if (dpa_offset < vmr_size) {
+            mr = vmr;
+        }
+    }
+    if (!mr && ct3d->hostpmem) {
+        MemoryRegion *pmr = host_memory_backend_get_memory(ct3d->hostpmem);
+        uint64_t vmr_size = ct3d->hostvmem ?
+            memory_region_size(
+                host_memory_backend_get_memory(ct3d->hostvmem)) : 0;
+        mr = pmr;
+        dpa_offset -= vmr_size;
+    }
+
+    if (!mr) {
+        return;
+    }
+
+    alias_name = g_strdup_printf("cxl-hdm%d-ram-alias", which);
+    memory_region_init_alias(&ct3d->hdm_ram_alias[which], OBJECT(ct3d),
+                             alias_name, mr, dpa_offset, decoder_size);
+    memory_region_add_subregion_overlap(get_system_memory(), decoder_base,
+                                        &ct3d->hdm_ram_alias[which], 1);
+    ct3d->hdm_ram_alias_valid[which] = true;
+    g_free(alias_name);
 }
 
 static void hdm_decoder_uncommit(CXLType3Dev *ct3d, int which)
@@ -442,6 +515,14 @@ static void hdm_decoder_uncommit(CXLType3Dev *ct3d, int which)
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 0);
 
     stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc, ctrl);
+
+    /* Remove the RAM alias if it was added during commit */
+    if (ct3d->hdm_ram_alias_valid[which]) {
+        memory_region_del_subregion(get_system_memory(),
+                                    &ct3d->hdm_ram_alias[which]);
+        object_unparent(OBJECT(&ct3d->hdm_ram_alias[which]));
+        ct3d->hdm_ram_alias_valid[which] = false;
+    }
 }
 
 static int ct3d_qmp_uncor_err_to_cxl(CxlUncorErrorType qmp_err)
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 393f312217..07deef2e2c 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -714,6 +714,10 @@ struct CXLType3Dev {
     /* State */
     AddressSpace hostvmem_as;
     AddressSpace hostpmem_as;
+
+    /* RAM aliases for HDM decoders - enables direct DMA mapping */
+    MemoryRegion hdm_ram_alias[CXL_HDM_DECODER_COUNT];
+    bool hdm_ram_alias_valid[CXL_HDM_DECODER_COUNT];
     CXLComponentState cxl_cstate;
     CXLDeviceState cxl_dstate;
     CXLCCI cci; /* Primary PCI mailbox CCI */
-- 
2.50.1


