Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA72E81A2B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 14:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrzyh-0006lV-HD; Mon, 16 Feb 2026 09:53:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1vrzyf-0006l3-Fi
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 09:53:33 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1vrzyc-0005EM-KW
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 09:53:33 -0500
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fF5PC6ZBhzJ4680;
 Mon, 16 Feb 2026 22:53:19 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 7FF8B40539;
 Mon, 16 Feb 2026 22:53:28 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.67.55) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 16 Feb 2026 14:53:27 +0000
To: <qemu-devel@nongnu.org>, <lizhijian@fujitsu.com>
CC: <anisa.su887@gmail.com>, <armbru@redhat.com>, <david@kernel.org>,
 <gourry@gourry.net>, <imammedo@redhat.com>, <jonathan.cameron@huawei.com>,
 <linuxarm@huawei.com>, <mst@redhat.com>, <nifan.cxl@gmail.com>,
 <peterx@redhat.com>, <philmd@linaro.org>, <ppbonzini@redhat.com>,
 <venkataravis@micron.com>, <xiaoguangrong.eric@gmail.com>
Subject: [PATCH v3 2/2] hw/cxl: Add a performant (and correct) path for the
 non interleaved cases
Date: Mon, 16 Feb 2026 14:52:18 +0000
Message-ID: <20260216145219.1959-3-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.2
In-Reply-To: <20260216145219.1959-1-alireza.sanaee@huawei.com>
References: <20260216145219.1959-1-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.47.67.55]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The CXL address to device decoding logic is complex because of the need
to correctly decode fine grained interleave. The current implementation
prevents use with KVM where executed instructions may reside in that
memory and gives very slow performance even in TCG.

In many real cases non interleaved memory configurations are useful and
for those we can use a more conventional memory region alias allowing
similar performance to other memory in the system.

Whether this fast path is applicable can be established once the full
set of HDM decoders has been committed (in whatever order the guest
decides to commit them). As such a check is performed on each
commit/uncommit of HDM decoder to establish if the alias should be added
or removed.

Co-developed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Tested-by: Gregory Price <gourry@gourry.net>
---
 hw/cxl/cxl-component-utils.c |   6 ++
 hw/cxl/cxl-host.c            | 194 ++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c           |   4 +
 include/hw/cxl/cxl.h         |   1 +
 include/hw/cxl/cxl_device.h  |   1 +
 5 files changed, 202 insertions(+), 4 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index d36162e91b..a10fdb0cc2 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -142,6 +142,12 @@ static void dumb_hdm_handler(CXLComponentState *cxl_cstate, hwaddr offset,
         value = FIELD_DP32(value, CXL_HDM_DECODER0_CTRL, COMMITTED, 0);
     }
     stl_le_p((uint8_t *)cache_mem + offset, value);
+
+    if (should_commit) {
+        cfmws_update_non_interleaved(true);
+    } else if (should_uncommit) {
+        cfmws_update_non_interleaved(false);
+    }
 }
 
 static void bi_handler(CXLComponentState *cxl_cstate, hwaddr offset,
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 415a792380..1fcfe01164 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -104,7 +104,7 @@ void cxl_fmws_link_targets(Error **errp)
 }
 
 static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
-                                uint8_t *target)
+                                uint8_t *target, bool *interleaved)
 {
     int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
     unsigned int hdm_count;
@@ -138,6 +138,11 @@ static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
         found = true;
         ig_enc = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IG);
         iw_enc = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IW);
+
+        if (interleaved) {
+            *interleaved = iw_enc != 0;
+        }
+
         target_idx = (addr / cxl_decode_ig(ig_enc)) % (1 << iw_enc);
 
         if (target_idx < 4) {
@@ -166,9 +171,12 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr,
     int rb_index;
     uint32_t *cache_mem;
     uint8_t target;
-    bool target_found;
+    bool target_found, interleaved;
     PCIDevice *rp, *d;
 
+    if ((fw->num_targets > 1) && !allow_interleave) {
+        return NULL;
+    }
 
     rb_index = (addr / cxl_decode_ig(fw->enc_int_gran)) % fw->num_targets;
     hb = PCI_HOST_BRIDGE(fw->target_hbs[rb_index]->cxl_host_bridge);
@@ -189,11 +197,16 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr,
 
         cache_mem = hb_cstate->crb.cache_mem_registers;
 
-        target_found = cxl_hdm_find_target(cache_mem, addr, &target);
+        target_found = cxl_hdm_find_target(cache_mem, addr, &target,
+                                           &interleaved);
         if (!target_found) {
             return NULL;
         }
 
+        if (interleaved && !allow_interleave) {
+            return NULL;
+        }
+
         rp = pcie_find_port_by_pn(hb->bus, target);
         if (!rp) {
             return NULL;
@@ -225,11 +238,15 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr,
 
     cache_mem = usp_cstate->crb.cache_mem_registers;
 
-    target_found = cxl_hdm_find_target(cache_mem, addr, &target);
+    target_found = cxl_hdm_find_target(cache_mem, addr, &target, &interleaved);
     if (!target_found) {
         return NULL;
     }
 
+    if (interleaved && !allow_interleave) {
+        return NULL;
+    }
+
     d = pcie_find_port_by_pn(&PCI_BRIDGE(d)->sec_bus, target);
     if (!d) {
         return NULL;
@@ -247,6 +264,175 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr,
     return d;
 }
 
+typedef struct CXLDirectPTState {
+    CXLType3Dev *ct3d;
+    hwaddr decoder_base;
+    hwaddr decoder_size;
+    hwaddr dpa_base;
+    unsigned int hdm_decoder_idx;
+    bool commit;
+} CXLDirectPTState;
+
+static void cxl_fmws_direct_passthrough_setup(CXLDirectPTState *state,
+                                              CXLFixedWindow *fw)
+{
+    CXLType3Dev *ct3d = state->ct3d;
+    MemoryRegion *mr = NULL;
+    uint64_t vmr_size = 0, pmr_size = 0, offset = 0;
+    MemoryRegion *direct_mr;
+
+    if (ct3d->hostvmem) {
+        MemoryRegion *vmr = host_memory_backend_get_memory(ct3d->hostvmem);
+
+        vmr_size = memory_region_size(vmr);
+        if (state->dpa_base < vmr_size) {
+            mr = vmr;
+            offset = state->dpa_base;
+        }
+    }
+    if (!mr && ct3d->hostpmem) {
+        MemoryRegion *pmr = host_memory_backend_get_memory(ct3d->hostpmem);
+
+        pmr_size = memory_region_size(pmr);
+        if (state->dpa_base - vmr_size < pmr_size) {
+            mr = pmr;
+            offset = state->dpa_base - vmr_size;
+        }
+    }
+    if (!mr) {
+        return;
+    }
+
+    direct_mr = &ct3d->direct_mr[state->hdm_decoder_idx];
+    if (memory_region_is_mapped(direct_mr)) {
+        return;
+    }
+
+    memory_region_init_alias(direct_mr, OBJECT(ct3d), "direct-mapping", mr,
+                             offset, state->decoder_size);
+    memory_region_add_subregion(&fw->mr,
+                                state->decoder_base - fw->base, direct_mr);
+}
+
+static void cxl_fmws_direct_passthrough_teardown(CXLDirectPTState *state,
+                                                 CXLFixedWindow *fw)
+{
+    CXLType3Dev *ct3d = state->ct3d;
+    MemoryRegion *direct_mr = &ct3d->direct_mr[state->hdm_decoder_idx];
+
+    if (memory_region_is_mapped(direct_mr)) {
+        memory_region_del_subregion(&fw->mr, direct_mr);
+    }
+}
+
+static int cxl_fmws_direct_passthrough(Object *obj, void *opaque)
+{
+    CXLDirectPTState *state = opaque;
+    CXLFixedWindow *fw;
+
+    if (!object_dynamic_cast(obj, TYPE_CXL_FMW)) {
+        return 0;
+    }
+
+    fw = CXL_FMW(obj);
+
+    /* Verify not interleaved */
+    if (!cxl_cfmws_find_device(fw, state->decoder_base, false)) {
+        return 0;
+    }
+
+   if (state->commit) {
+        cxl_fmws_direct_passthrough_setup(state, fw);
+    } else {
+        cxl_fmws_direct_passthrough_teardown(state, fw);
+    }
+
+    return 0;
+}
+
+static int update_non_interleaved(Object *obj, void *opaque)
+{
+    const int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
+    bool commit = *(bool *)opaque;
+    CXLType3Dev *ct3d;
+    uint32_t *cache_mem;
+    unsigned int hdm_count, i;
+    uint32_t cap;
+    uint64_t dpa_base = 0;
+
+    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
+        return 0;
+    }
+
+    ct3d = CXL_TYPE3(obj);
+    cache_mem = ct3d->cxl_cstate.crb.cache_mem_registers;
+    cap = ldl_le_p(cache_mem + R_CXL_HDM_DECODER_CAPABILITY);
+    hdm_count = cxl_decoder_count_dec(FIELD_EX32(cap,
+                                                 CXL_HDM_DECODER_CAPABILITY,
+                                                 DECODER_COUNT));
+    /*
+     * Walk the decoders and find any committed with iw set to 0
+     * (non interleaved).
+     */
+    for (i = 0; i < hdm_count; i++) {
+        uint64_t decoder_base, decoder_size, skip;
+        uint32_t hdm_ctrl, low, high;
+        int iw, committed;
+
+        hdm_ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + i * hdm_inc);
+        committed = FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED);
+        if (commit ^ committed) {
+            return 0;
+        }
+
+        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_DPA_SKIP_LO +
+                       i * hdm_inc);
+        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_DPA_SKIP_HI +
+                        i * hdm_inc);
+        skip = ((uint64_t)high << 32) | (low & 0xf0000000);
+        dpa_base += skip;
+
+        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_LO + i * hdm_inc);
+        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_HI + i * hdm_inc);
+        decoder_size = ((uint64_t)high << 32) | (low & 0xf0000000);
+
+        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_LO + i * hdm_inc);
+        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_HI + i * hdm_inc);
+        decoder_base = ((uint64_t)high << 32) | (low & 0xf0000000);
+
+        iw = FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL, IW);
+
+        if (iw == 0) {
+            CXLDirectPTState state = {
+                .ct3d = ct3d,
+                .decoder_base = decoder_base,
+                .decoder_size = decoder_size,
+                .dpa_base = dpa_base,
+                .hdm_decoder_idx = i,
+                .commit = commit,
+            };
+
+            object_child_foreach_recursive(object_get_root(),
+                                           cxl_fmws_direct_passthrough, &state);
+        }
+        dpa_base += decoder_size / cxl_interleave_ways_dec(iw, &error_fatal);
+    }
+
+    return 0;
+}
+
+bool cfmws_update_non_interleaved(bool commit)
+{
+    /*
+     * Walk endpoints to find committed decoders then check if they are not
+     * interleaved (but path is fully set up).
+     */
+    object_child_foreach_recursive(object_get_root(),
+                                   update_non_interleaved, &commit);
+
+    return false;
+}
+
 static MemTxResult cxl_read_cfmws(void *opaque, hwaddr addr, uint64_t *data,
                                   unsigned size, MemTxAttrs attrs)
 {
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 3f09c589ae..a95f6a4014 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -427,6 +427,8 @@ static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
 
     stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc, ctrl);
+
+    cfmws_update_non_interleaved(true);
 }
 
 static void hdm_decoder_uncommit(CXLType3Dev *ct3d, int which)
@@ -442,6 +444,8 @@ static void hdm_decoder_uncommit(CXLType3Dev *ct3d, int which)
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 0);
 
     stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc, ctrl);
+
+    cfmws_update_non_interleaved(false);
 }
 
 static int ct3d_qmp_uncor_err_to_cxl(CxlUncorErrorType qmp_err)
diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 998f495a98..931f5680bd 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -71,4 +71,5 @@ CXLComponentState *cxl_usp_to_cstate(CXLUpstreamPort *usp);
 typedef struct CXLDownstreamPort CXLDownstreamPort;
 DECLARE_INSTANCE_CHECKER(CXLDownstreamPort, CXL_DSP, TYPE_CXL_DSP)
 
+bool cfmws_update_non_interleaved(bool commit);
 #endif
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 393f312217..d295469301 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -712,6 +712,7 @@ struct CXLType3Dev {
     uint64_t sn;
 
     /* State */
+    MemoryRegion direct_mr[CXL_HDM_DECODER_COUNT];
     AddressSpace hostvmem_as;
     AddressSpace hostpmem_as;
     CXLComponentState cxl_cstate;
-- 
2.43.0


