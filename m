Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A11109C05A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 18:46:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5TFA-0004Mr-Us; Wed, 25 Mar 2026 14:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1w5TEx-0004A4-9j
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 14:46:05 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1w5TEu-00083H-Mo
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 14:46:02 -0400
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fgwnn6sp4zHnGjr;
 Thu, 26 Mar 2026 02:45:17 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id C5BF540584;
 Thu, 26 Mar 2026 02:45:53 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.66.203) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 25 Mar 2026 18:45:52 +0000
To: <qemu-devel@nongnu.org>
CC: <anisa.su@samsung.com>, <armbru@redhat.com>, <berrange@redhat.com>,
 <eblake@redhat.com>, <jonathan.cameron@huawei.com>,
 <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, <lizhijian@fujitsu.com>,
 <mst@redhat.com>, <pbonzini@redhat.com>, <gourry@gourry.net>,
 <nifan.cxl@gmail.com>, <me@linux.beauty>
Subject: [PATCH 5/9] hw/cxl: Map lazy memory backend after host acceptance
Date: Wed, 25 Mar 2026 18:42:53 +0000
Message-ID: <20260325184259.366-6-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.2
In-Reply-To: <20260325184259.366-1-alireza.sanaee@huawei.com>
References: <20260325184259.366-1-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.47.66.203]
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
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

In the dc-regions-total-size flow, a requested extent is not backed when it
is queued. It becomes usable only after the host accepts it with Add
Dynamic Capacity Response.

Use that response path to look up the first pending group's metadata for
each accepted extent, enable the selected host backend, and move the
backend and fixed-window references onto the committed extent list. The
accepted range is then marked backed just like the non-lazy path.

This wires host acceptance to the lazy backend lifecycle and leaves the
fixed-window direct aliasing to the following patch.

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 76 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 3 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index c5427adb3a..cc7be6e68c 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -3668,6 +3668,28 @@ static CXLRetCode cxl_detect_malformed_extent_list(CXLType3Dev *ct3d,
     return CXL_MBOX_SUCCESS;
 }
 
+/* Find extent details (backend, window, tag, rid) in the first pending group */
+static bool cxl_extent_find_extent_detail(CXLDCExtentGroupList *list,
+                                          uint64_t start_dpa, uint64_t len,
+                                          uint8_t *tag, HostMemoryBackend **hmb,
+                                          struct CXLFixedWindow **fw, int *rid)
+{
+    CXLDCExtent *ent;
+    CXLDCExtentGroup *group = QTAILQ_FIRST(list);
+
+    QTAILQ_FOREACH(ent, &group->list, node) {
+        if (ent->start_dpa == start_dpa && ent->len == len) {
+            *fw = ent->fw;
+            *hmb = ent->hm;
+            memcpy(tag, ent->tag, 0x10);
+            *rid = ent->rid;
+            return true;
+        }
+    }
+
+    return false;
+}
+
 static CXLRetCode cxl_dcd_add_dyn_cap_rsp_dry_run(CXLType3Dev *ct3d,
         const CXLUpdateDCExtentListInPl *in)
 {
@@ -3718,8 +3740,12 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
     CXLUpdateDCExtentListInPl *in = (void *)payload_in;
     CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
     CXLDCExtentList *extent_list = &ct3d->dc.extents;
+    struct CXLFixedWindow *fw;
+    HostMemoryBackend *hmb_dc;
+    uint8_t tag[0x10];
     uint32_t i, num;
     uint64_t dpa, len;
+    int rid;
     CXLRetCode ret;
 
     if (len_in < sizeof(*in)) {
@@ -3756,10 +3782,54 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
     for (i = 0; i < in->num_entries_updated; i++) {
         dpa = in->updated_entries[i].start_dpa;
         len = in->updated_entries[i].len;
+        if (ct3d->dc.total_capacity_cmd) {
+            bool found;
+            MemoryRegion *mr;
+
+            found = cxl_extent_find_extent_detail(&ct3d->dc.extents_pending,
+                                                  dpa, len, tag,
+                                                  &hmb_dc, &fw, &rid);
+
+            /*
+             * Host accepted an extent where device lacks details including
+             * wrong DPA or wrong length.
+             */
+            if (!found) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "Could not find the extent detail for DPA 0x%"
+                              PRIx64 " LEN 0x%" PRIx64 "\n", dpa, len);
+                return CXL_MBOX_INVALID_PA;
+            }
+
+            /* The host memory backend should not be already mapped */
+            if (host_memory_backend_is_mapped(hmb_dc)) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "The host memory backend for DPA 0x%" PRIx64
+                              " LEN 0x%" PRIx64 " is already mapped\n",
+                              dpa, len);
+                return CXL_MBOX_INVALID_PA;
+            }
 
-        cxl_insert_extent_to_extent_list(extent_list,
-                                         NULL, NULL, dpa, len,
-                                         NULL, 0, 0);
+            mr = host_memory_backend_get_memory(hmb_dc);
+            if (!mr) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "Could not get memory region from "
+                              "host memory backend\n");
+                return CXL_MBOX_INVALID_PA;
+            }
+
+            memory_region_set_nonvolatile(mr, false);
+            memory_region_set_enabled(mr, true);
+            host_memory_backend_set_mapped(hmb_dc, true);
+
+            cxl_insert_extent_to_extent_list(extent_list,
+                                             hmb_dc, fw, dpa, len,
+                                             NULL, 0, rid);
+        } else {
+            cxl_insert_extent_to_extent_list(extent_list,
+                                             NULL, NULL, dpa, len,
+                                             NULL, 0, -1);
+        }
         ct3d->dc.total_extent_count += 1;
         ct3d->dc.nr_extents_accepted += 1;
         ct3_set_region_block_backed(ct3d, dpa, len);
-- 
2.50.1 (Apple Git-155)


