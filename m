Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DE8D111A8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 22:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOkwu-0005Cd-3b; Thu, 27 Nov 2025 17:58:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1vOkws-0005B8-L5
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 17:58:50 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1vOkwq-0001qk-KQ
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 17:58:50 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dHWzd5WTJzJ467f;
 Fri, 28 Nov 2025 06:57:49 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 59AC81404C5;
 Fri, 28 Nov 2025 06:58:47 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.72.83) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 27 Nov 2025 22:58:46 +0000
To: <qemu-devel@nongnu.org>
CC: <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>, <eblake@redhat.com>, 
 <armbru@redhat.com>, <berrange@redhat.com>, <pbonzini@redhat.com>,
 <mst@redhat.com>, <lizhijian@fujitsu.com>, <anisa.su@samsung.com>,
 <linux-cxl@vger.kernel.org>
Subject: [RFC PATCH 6/7] hw/cxl: Add remove alias functionality for extent
 direct mapping
Date: Thu, 27 Nov 2025 22:55:24 +0000
Message-ID: <20251127225526.700-7-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.2
In-Reply-To: <20251127225526.700-1-alireza.sanaee@huawei.com>
References: <20251127225526.700-1-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.47.72.83]
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Remove alias related to an extent when the extent is longer available,
from removed from the VM.

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 57 ++++++++++++++++++++++++++++++-------
 hw/mem/cxl_type3.c          | 29 +++++++++++++++++--
 include/hw/cxl/cxl_device.h |  9 ++++--
 3 files changed, 81 insertions(+), 14 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 15114a5314..e0ac31ac41 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2847,7 +2847,8 @@ void cxl_insert_extent_to_extent_list(CXLDCExtentList *list,
                                              uint8_t *tag,
                                              uint16_t shared_seq,
                                              int rid,
-                                             uint64_t offset)
+                                             uint64_t offset,
+                                             uint32_t direct_window_idx)
 {
     CXLDCExtent *extent;
 
@@ -2863,6 +2864,7 @@ void cxl_insert_extent_to_extent_list(CXLDCExtentList *list,
         memcpy(extent->tag, tag, 0x10);
     }
     extent->shared_seq = shared_seq;
+    extent->direct_window_idx = direct_window_idx;
 
     QTAILQ_INSERT_TAIL(list, extent, node);
 }
@@ -2887,14 +2889,16 @@ CXLDCExtentGroup *cxl_insert_extent_to_extent_group(CXLDCExtentGroup *group,
                                                     uint8_t *tag,
                                                     uint16_t shared_seq,
                                                     int rid,
-                                                    uint64_t offset)
+                                                    uint64_t offset,
+                                                    uint32_t direct_window_idx)
 {
     if (!group) {
         group = g_new0(CXLDCExtentGroup, 1);
         QTAILQ_INIT(&group->list);
     }
-    cxl_insert_extent_to_extent_list(&group->list, host_mem, fw, dpa, len,
-                                     tag, shared_seq, rid, offset);
+    cxl_insert_extent_to_extent_list(&group->list, host_mem, fw, dpa, len, tag,
+                                     shared_seq, rid, offset,
+                                     direct_window_idx);
     return group;
 }
 
@@ -3173,10 +3177,10 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
             }
 
             cxl_insert_extent_to_extent_list(extent_list, hmb_dc, fw, dpa, len,
-                                             tag, 0, rid, offset);
+                                             tag, 0, rid, offset, mr_idx);
         } else {
             cxl_insert_extent_to_extent_list(extent_list, NULL, NULL, dpa, len,
-                                             NULL, 0, -1, -1);
+                                             NULL, 0, -1, -1, -1);
         }
 
         ct3d->dc.total_extent_count += 1;
@@ -3207,7 +3211,8 @@ static uint32_t copy_extent_list(CXLDCExtentList *dst,
     QTAILQ_FOREACH(ent, src, node) {
         cxl_insert_extent_to_extent_list(dst, ent->hm, ent->fw, ent->start_dpa,
                                          ent->len, ent->tag, ent->shared_seq,
-                                         ent->rid, ent->offset);
+                                         ent->rid, ent->offset,
+                                         ent->direct_window_idx);
         cnt++;
     }
     return cnt;
@@ -3215,6 +3220,7 @@ static uint32_t copy_extent_list(CXLDCExtentList *dst,
 
 static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
         const CXLUpdateDCExtentListInPl *in, CXLDCExtentList *updated_list,
+        CXLDCExtentList *updated_removed_list,
         uint32_t *updated_list_size)
 {
     CXLDCExtent *ent, *ent_next;
@@ -3224,6 +3230,9 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
     CXLRetCode ret = CXL_MBOX_SUCCESS;
 
     QTAILQ_INIT(updated_list);
+    if (updated_removed_list) {
+        QTAILQ_INIT(updated_removed_list);
+    }
     copy_extent_list(updated_list, &ct3d->dc.extents);
 
     for (i = 0; i < in->num_entries_updated; i++) {
@@ -3257,6 +3266,19 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
                     }
                     len_done = ent_len - len1 - len2;
 
+                    /* Cannot split extents with direct window mapping */
+                    if (ent->direct_window_idx >= 0 && (len1 || len2)) {
+                        ret = CXL_MBOX_INVALID_INPUT;
+                        goto free_and_exit;
+                    }
+
+                    if (updated_removed_list) {
+                        cxl_insert_extent_to_extent_list(
+                            updated_removed_list, ent->hm, ent->fw,
+                            ent->start_dpa, ent->len, ent->tag, ent->shared_seq,
+                            ent->rid, ent->offset, ent->direct_window_idx);
+                    }
+
                     cxl_remove_extent_from_extent_list(updated_list, ent);
                     cnt_delta--;
 
@@ -3264,14 +3286,16 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
                         cxl_insert_extent_to_extent_list(updated_list, NULL,
                                                          NULL, ent_start_dpa,
                                                          len1, ent->tag, 0,
-                                                         ent->rid, ent->offset);
+                                                         ent->rid, ent->offset,
+                                                         ent->direct_window_idx);
                         cnt_delta++;
                     }
                     if (len2) {
                         cxl_insert_extent_to_extent_list(updated_list, NULL,
                                                          NULL, dpa + len,
                                                          len2, ent->tag, 0,
-                                                         ent->rid, ent->offset);
+                                                         ent->rid, ent->offset,
+                                                         ent->direct_window_idx);
                         cnt_delta++;
                     }
 
@@ -3313,6 +3337,7 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
     CXLUpdateDCExtentListInPl *in = (void *)payload_in;
     CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
     CXLDCExtentList updated_list;
+    CXLDCExtentList updated_removed_list;
     CXLDCExtent *ent, *ent_next;
     uint32_t updated_list_size;
     CXLRetCode ret;
@@ -3336,11 +3361,22 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
     }
 
     ret = cxl_dc_extent_release_dry_run(ct3d, in, &updated_list,
+                                        &updated_removed_list,
                                         &updated_list_size);
     if (ret != CXL_MBOX_SUCCESS) {
         return ret;
     }
 
+    if (ct3d->direct_mr_enabled) {
+        /*
+         * Remove memory alias for the removed extents
+         */
+        QTAILQ_FOREACH_SAFE(ent, &updated_removed_list, node, ent_next) {
+            cxl_remove_memory_alias(ct3d, ent->fw, ent->direct_window_idx);
+            cxl_remove_extent_from_extent_list(&updated_removed_list, ent);
+        }
+    }
+
     /*
      * If the dry run release passes, the returned updated_list will
      * be the updated extent list and we just need to clear the extents
@@ -3747,7 +3783,7 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
                                                           ext->start_dpa,
                                                           ext->len, ext->tag,
                                                           ext->shared_seq, 0,
-                                                          -1);
+                                                          -1, -1);
             }
 
             cxl_extent_group_list_insert_tail(&ct3d->dc.extents_pending, group);
@@ -3829,6 +3865,7 @@ static CXLRetCode cmd_fm_initiate_dc_release(const struct cxl_cmd *cmd,
             rc = cxl_dc_extent_release_dry_run(ct3d,
                                                list,
                                                &updated_list,
+                                               NULL,
                                                &updated_list_size);
             if (rc) {
                 return rc;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index e3093f63a3..d3ea62ef3f 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -2140,7 +2140,8 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
                                                           extents[i].tag,
                                                           extents[i].shared_seq,
                                                           rid,
-                                                          offset);
+                                                          offset,
+                                                          0);
             } else {
                 group = cxl_insert_extent_to_extent_group(group,
                                                           dcd->dc.host_dc,
@@ -2150,7 +2151,8 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
                                                           extents[i].tag,
                                                           extents[i].shared_seq,
                                                           rid,
-                                                          offset);
+                                                          offset,
+                                                          0);
             }
         }
 
@@ -2216,6 +2218,29 @@ void qmp_cxl_release_dynamic_capacity(const char *path, uint16_t host_id,
     }
 }
 
+void cxl_remove_memory_alias(CXLType3Dev *dcd, struct CXLFixedWindow *fw,
+                             uint32_t hdm_id)
+{
+    MemoryRegion *mr;
+
+    if (dcd->dc.total_capacity_cmd > 0) {
+        mr = &dcd->dc.dc_direct_mr[hdm_id];
+    } else {
+        qemu_log("No dynamic capacity command support, "
+                 "cannot remove memory region alias\n");
+        return;
+    }
+
+    if (!fw) {
+        qemu_log(
+            "Cannot remove memory region alias without a valid fixed window\n");
+        return;
+    }
+
+    memory_region_del_subregion(&fw->mr, mr);
+    return;
+}
+
 static void ct3_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 1a521df881..c8c57ac837 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -525,6 +525,7 @@ typedef struct CXLDCExtent {
     uint8_t rsvd[0x6];
     int rid;
     uint64_t offset;
+    int direct_window_idx;
 
     QTAILQ_ENTRY(CXLDCExtent) node;
 } CXLDCExtent;
@@ -739,7 +740,8 @@ void cxl_insert_extent_to_extent_list(CXLDCExtentList *list,
                                       uint8_t *tag,
                                       uint16_t shared_seq,
                                       int rid,
-                                      uint64_t offset);
+                                      uint64_t offset,
+                                      uint32_t direct_window_idx);
 bool test_any_bits_set(const unsigned long *addr, unsigned long nr,
                        unsigned long size);
 bool cxl_extents_contains_dpa_range(CXLDCExtentList *list,
@@ -752,7 +754,8 @@ CXLDCExtentGroup *cxl_insert_extent_to_extent_group(CXLDCExtentGroup *group,
                                                     uint8_t *tag,
                                                     uint16_t shared_seq,
                                                     int rid,
-                                                    uint64_t offset);
+                                                    uint64_t offset,
+                                                    uint32_t direct_window_idx);
 void cxl_extent_group_list_insert_tail(CXLDCExtentGroupList *list,
                                        CXLDCExtentGroup *group);
 uint32_t cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list);
@@ -773,4 +776,6 @@ bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
                                     uint64_t dpa, uint64_t len);
 bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
                                           uint64_t dpa, uint64_t len);
+void cxl_remove_memory_alias(CXLType3Dev *dcd, struct CXLFixedWindow *fw,
+                             uint32_t hdm_id);
 #endif
-- 
2.43.0


