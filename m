Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF9B60A3801
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=O13mroCb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLJbT-0002ef-Vj; Mon, 26 Oct 2026 08:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fj2110jc@fujitsu.com>)
 id 1xLHPF-0002mh-4Z
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 05:54:18 -0400
Received: from esa8.hc1455-7.c3s2.iphmx.com ([139.138.61.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fj2110jc@fujitsu.com>)
 id 1xLHPD-00080Z-2C
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 05:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1793008455; x=1824544455;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RYV8jtdiDIttht3TRaM0y5nY4jvIepG6G6eTEjUpCEU=;
 b=O13mroCb2bN3qHprTmvJdK8JMjNtKuXnDjB5UHwXDjxnCaiH7qTMNJEI
 nhURbfn2RqpVmFWTX4kvJvUo9TyQk4ChoKDlbNaPPTrr0E/8XjrVH/90p
 UUAO19MO3bnKz9NJyPgSlDgIU58IyGH2EYfn4AKooOHZVnFK+zKdlcj0f
 pDPlsYpZHIhfUGBL/4LDGQOOLGDJHblon8tWeOKzvbj4rQUqYYucvuTHx
 dlSZeXlCSYwvtnvo76bOCzceUsMLJIyIneeFW1mAfRkZRVvA6ulHr91/4
 m/s822CtjvREMCu6Hwzyqh+3f+toID3d+L9H10Z8zN55UejcL+DSdQeOF Q==;
X-CSE-ConnectionGUID: m+RKfld6Tkqetn64k/YGGw==
X-CSE-MsgGUID: ulL2bKh9Q0exQrnwGV3hmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="247435609"
X-IronPort-AV: E=Sophos;i="6.27,179,1786978800"; d="scan'208";a="247435609"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 18:54:14 +0900
Received: from az2uksmgm2.o.css.fujitsu.com (unknown [10.151.22.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id 39ECDC01AED
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 09:54:14 +0000 (UTC)
Received: from m3003.s.css.fujitsu.com (unknown [10.128.233.114])
 by az2uksmgm2.o.css.fujitsu.com (Postfix) with ESMTP id 9FA4C1800276
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 09:54:13 +0000 (UTC)
Received: from tanjiro.soft.fujitsu.com (unknown [10.118.236.61])
 by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 63690202EBDE;
 Mon, 26 Oct 2026 18:54:12 +0900 (JST)
To: qemu-devel@nongnu.org
Cc: Yukiya Takaki <fj2110jc@fujitsu.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Anisa Su <anisa.su@samsung.com>,
 Jonathan Cameron <jic23@kernel.org>, Junjie Cao <junjie.cao@intel.com>,
 linux-cxl@vger.kernel.org, "Wolski, Tomasz" <tomasz.wolski@fujitsu.com>,
 lizhijian@fujitsu.com, y-goto@fujitsu.com, yukiya.takaki@gmail.com
Subject: [PATCH RFC 4/7] =?UTF-8?q?QEMU/hw/cxl:=20auto=E2=80=91program=20H?=
 =?UTF-8?q?DM=20decoders=20for=20CXL=20Type=203?=
Date: Mon, 26 Oct 2026 19:03:25 +0900
Message-ID: <a8e078e52c09acc0be7874b7c8dd244546127547.1793003983.git.fj2110jc@fujitsu.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1793003983.git.fj2110jc@fujitsu.com>
References: <cover.1793003983.git.fj2110jc@fujitsu.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.138.61.253; envelope-from=fj2110jc@fujitsu.com;
 helo=esa8.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:14:57 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Yukiya Takaki <fj2110jc@fujitsu.com>
From:  Yukiya Takaki via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On some real systems, firmware programs the HDM decoders on both the
endpoint and the CXL host bridge so that the OS can discover CXL memory
ranges at boot and the CXL driver can automatically create regions.

This patch adds helpers to program the HDM decoders in QEMU using the
per‑device HPA range from `ct3_type3_get_hpm_range()`, and wires them
into the CXL Type 3 reset path. When `program_hdm_decoder` is enabled,
both the endpoint and host‑bridge HDM decoders are configured so that
the guest sees the same kind of automatically assigned CXL regions as
on real hardware.

The reset hold phase processes child devices before their parents.
Consequently, the Type 3 reset handler programs the host bridge decoder
before the pxb-cxl reset handler runs. Calling
cxl_component_register_init_common() from the pxb-cxl reset handler
would then clear the component register block and erase the decoder
configuration that was just programmed.

When the affected HPA ranges are advertised through E820 and SRAT,
which will be added in the following patches, Linux attempts to use them
as system memory. Without a valid host bridge decoder, accesses to
these ranges cannot be routed to the Type 3 devices. This corrupts
kernel memory-management data and eventually causes a kernel panic.

Initialize the common host bridge component registers when the PXB is
realized instead. Keep the reset handler limited to the
topology-dependent HDM capability setup so that the automatically
programmed decoder settings are not overwritten.

Co-developed-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Yukiya Takaki <fj2110jc@fujitsu.com>
---
 hw/mem/cxl_type3.c                  | 98 +++++++++++++++++++++++++++++
 hw/pci-bridge/pci_expander_bridge.c | 13 +++-
 2 files changed, 109 insertions(+), 2 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 811f8e247d..60e4c0e20f 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -19,6 +19,9 @@
 #include "hw/pci/pci.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/pci/pcie_port.h"
+#include "hw/cxl/cxl_host.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
@@ -1358,6 +1361,59 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
     return address_space_write(as, dpa_offset, attrs, &data, size);
 }
 
+static void __update_hdm_decoder_n(uint32_t *cache_mem, int which,
+                                   uint32_t ctrl, uint64_t base,
+                                   uint64_t size)
+{
+    int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
+
+    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_LO + which * hdm_inc,
+             base & 0xffffffff);
+    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_HI + which * hdm_inc,
+             base >> 32);
+    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_LO + which * hdm_inc,
+             size & 0xffffffff);
+    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_HI + which * hdm_inc,
+             size >> 32);
+    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc, ctrl);
+}
+
+static void update_hdm_decoder_endpoint(uint32_t *cache_mem, int which,
+                                        uint32_t ctrl, uint64_t base,
+                                        uint64_t size)
+{
+    return __update_hdm_decoder_n(cache_mem, which, ctrl, base, size);
+}
+
+static void update_hdm_decoder_pxb(uint32_t *cache_mem, int which,
+                                   uint64_t tl, uint32_t ctrl,
+                                   uint64_t base, uint64_t size)
+{
+    int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
+
+    stl_le_p(cache_mem +
+             R_CXL_HDM_DECODER0_TARGET_LIST_LO + which * hdm_inc,
+             tl & 0xffffffff);
+    stl_le_p(cache_mem +
+             R_CXL_HDM_DECODER0_TARGET_LIST_HI + which * hdm_inc,
+             tl >> 32);
+
+    __update_hdm_decoder_n(cache_mem, which, ctrl, base, size);
+}
+
+static uint8_t ct3d_root_port_number(DeviceState *dev)
+{
+    BusState *bus = dev->parent_bus;
+    DeviceState *rp_dev;
+
+    assert(bus);
+    rp_dev = bus->parent;
+    assert(rp_dev);
+    assert(object_dynamic_cast(OBJECT(rp_dev), TYPE_PCIE_ROOT_PORT));
+
+    return PCIE_PORT(rp_dev)->port;
+}
+
 static uint64_t c3t_addr_size(DeviceState *dev)
 {
     CXLType3Dev *ct3d = CXL_TYPE3(dev);
@@ -1398,6 +1454,42 @@ void ct3_type3_get_hpm_range(CXLType3Dev *dev, uint64_t *base, uint64_t *size)
     *size = c3t_addr_size(DEVICE(dev));
 }
 
+static void program_pxb_hdm_decoder(DeviceState *dev)
+{
+    CXLHost *cxl = ct3d_to_cxl_pxb(dev);
+    CXLType3Dev *ct3d = CXL_TYPE3(dev);
+    int hdm_num = ct3d->idx;
+    int order = ct3d_root_port_number(dev);
+    assert(cxl);
+    uint64_t base, size;
+    ct3_type3_get_hpm_range(ct3d, &base, &size);
+
+    CXLComponentState *cxl_cstate = &cxl->cxl_cstate;
+    uint32_t *cache_mem = cxl_cstate->crb.cache_mem_registers;
+
+    uint32_t ctrl = R_CXL_HDM_DECODER0_CTRL_COMMIT_MASK |
+                    R_CXL_HDM_DECODER0_CTRL_COMMITTED_MASK |
+                    R_CXL_HDM_DECODER0_CTRL_TYPE_MASK;
+
+    update_hdm_decoder_pxb(cache_mem, hdm_num, order, ctrl, base, size);
+}
+
+static void program_hdm_decoder(DeviceState *dev)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(dev);
+    uint64_t base, size;
+    ComponentRegisters *cregs = &ct3d->cxl_cstate.crb;
+    uint32_t *cache_mem = cregs->cache_mem_registers;
+
+    ct3_type3_get_hpm_range(ct3d, &base, &size);
+
+    uint32_t ctrl = R_CXL_HDM_DECODER0_CTRL_COMMIT_MASK |
+                    R_CXL_HDM_DECODER0_CTRL_COMMITTED_MASK |
+                    R_CXL_HDM_DECODER0_CTRL_TYPE_MASK;
+
+    update_hdm_decoder_endpoint(cache_mem, 0, ctrl, base, size);
+}
+
 static void ct3d_reset(DeviceState *dev)
 {
     CXLType3Dev *ct3d = CXL_TYPE3(dev);
@@ -1408,6 +1500,12 @@ static void ct3d_reset(DeviceState *dev)
                               ct3d->flitmode);
     cxl_component_register_init_common(reg_state, write_msk,
                                        CXL2_TYPE3_DEVICE, ct3d->hdmdb);
+
+    if (ct3d->program_hdm_decoder) {
+        program_hdm_decoder(dev);
+        program_pxb_hdm_decoder(dev);
+    }
+
     cxl_device_register_init_t3(ct3d, CXL_T3_MSIX_MBOX);
 
     /*
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 40ffbc4e08..e8fd7343d1 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -297,16 +297,24 @@ static int pxb_map_irq_fn(PCIDevice *pci_dev, int pin)
     return pin - PCI_SLOT(pxb->devfn);
 }
 
+static void pxb_cxl_dev_init(DeviceState *dev)
+{
+    CXLHost *cxl = PXB_CXL_DEV(dev)->cxl_host_bridge;
+    CXLComponentState *cxl_cstate = &cxl->cxl_cstate;
+    uint32_t *reg_state = cxl_cstate->crb.cache_mem_registers;
+    uint32_t *write_msk = cxl_cstate->crb.cache_mem_regs_write_mask;
+
+    cxl_component_register_init_common(reg_state, write_msk, CXL2_RC, false);
+}
+
 static void pxb_cxl_dev_reset(DeviceState *dev)
 {
     CXLHost *cxl = PXB_CXL_DEV(dev)->cxl_host_bridge;
     CXLComponentState *cxl_cstate = &cxl->cxl_cstate;
     PCIHostState *hb = PCI_HOST_BRIDGE(cxl);
     uint32_t *reg_state = cxl_cstate->crb.cache_mem_registers;
-    uint32_t *write_msk = cxl_cstate->crb.cache_mem_regs_write_mask;
     int dsp_count = 0;
 
-    cxl_component_register_init_common(reg_state, write_msk, CXL2_RC, false);
     /*
      * The CXL specification allows for host bridges with no HDM decoders
      * if they only have a single root port.
@@ -507,6 +515,7 @@ static void pxb_cxl_dev_realize(PCIDevice *dev, Error **errp)
     if (!pxb_dev_realize_common(dev, CXL, errp)) {
         return;
     }
+    pxb_cxl_dev_init(DEVICE(dev));
     pxb_cxl_dev_reset(DEVICE(dev));
 }
 
-- 
2.52.0


