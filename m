Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E9B10775EA
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 17:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2uZS-00019f-P1; Wed, 18 Mar 2026 13:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1w2uZP-00019F-8Y
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 13:20:35 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1w2uZM-00011A-9j
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 13:20:34 -0400
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fbbD13nzzzJ467X;
 Thu, 19 Mar 2026 01:19:29 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 8E1664056A;
 Thu, 19 Mar 2026 01:20:27 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.203.177.99) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 18 Mar 2026 17:20:26 +0000
To: <qemu-devel@nongnu.org>
CC: <anisa.su887@gmail.com>, <armbru@redhat.com>, <david@kernel.org>,
 <gourry@gourry.net>, <imammedo@redhat.com>, <jonathan.cameron@huawei.com>,
 <linuxarm@huawei.com>, <lizhijian@fujitsu.com>, <mst@redhat.com>,
 <nifan.cxl@gmail.com>, <pbonzini@redhat.com>, <peterx@redhat.com>,
 <philmd@linaro.org>, <venkataravis@micron.com>, <me@linux.beauty>,
 <xiaoguangrong.eric@gmail.com>
Subject: [PATCH v8 2/3] hw/cxl: Allow cxl_cfmws_find_device() to filter on
 whether interleaved paths are accepted
Date: Wed, 18 Mar 2026 17:19:16 +0000
Message-ID: <20260318171918.146-3-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.2
In-Reply-To: <20260318171918.146-1-alireza.sanaee@huawei.com>
References: <20260318171918.146-1-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.203.177.99]
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

Extend cxl_cfmws_find_device() with a parameter that filters on whether the
address lies in an interleaved range. For now all callers accept
interleave configurations so no functional changes.

Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Tested-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 hw/cxl/cxl-host.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index a94b893e99..2dc9f77007 100644
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
@@ -157,7 +162,8 @@ static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
     return found;
 }
 
-static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
+static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr,
+                                        bool allow_interleave)
 {
     CXLComponentState *hb_cstate, *usp_cstate;
     PCIHostState *hb;
@@ -165,9 +171,13 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
     int rb_index;
     uint32_t *cache_mem;
     uint8_t target;
-    bool target_found;
+    bool target_found, interleaved;
     PCIDevice *rp, *d;
 
+    if ((fw->num_targets > 1) && !allow_interleave) {
+        return NULL;
+    }
+
     rb_index = (addr / cxl_decode_ig(fw->enc_int_gran)) % fw->num_targets;
     hb = PCI_HOST_BRIDGE(fw->target_hbs[rb_index]->cxl_host_bridge);
     if (!hb || !hb->bus || !pci_bus_is_cxl(hb->bus)) {
@@ -187,11 +197,16 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
 
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
@@ -223,11 +238,15 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
 
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
@@ -251,7 +270,7 @@ static MemTxResult cxl_read_cfmws(void *opaque, hwaddr addr, uint64_t *data,
     CXLFixedWindow *fw = opaque;
     PCIDevice *d;
 
-    d = cxl_cfmws_find_device(fw, addr + fw->base);
+    d = cxl_cfmws_find_device(fw, addr + fw->base, true);
     if (d == NULL) {
         *data = 0;
         /* Reads to invalid address return poison */
@@ -268,7 +287,7 @@ static MemTxResult cxl_write_cfmws(void *opaque, hwaddr addr,
     CXLFixedWindow *fw = opaque;
     PCIDevice *d;
 
-    d = cxl_cfmws_find_device(fw, addr + fw->base);
+    d = cxl_cfmws_find_device(fw, addr + fw->base, true);
     if (d == NULL) {
         /* Writes to invalid address are silent */
         return MEMTX_OK;
-- 
2.43.0


