Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DAAFCFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 22:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOkxZ-0005vJ-AK; Thu, 27 Nov 2025 17:59:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1vOkxW-0005uF-9a
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 17:59:30 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1vOkxU-0001x5-7G
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 17:59:30 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dHX0Q2b8GzHnGcp;
 Fri, 28 Nov 2025 06:58:30 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id AF1781402F1;
 Fri, 28 Nov 2025 06:59:19 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.72.83) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 27 Nov 2025 22:59:18 +0000
To: <qemu-devel@nongnu.org>
CC: <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>, <eblake@redhat.com>, 
 <armbru@redhat.com>, <berrange@redhat.com>, <pbonzini@redhat.com>,
 <mst@redhat.com>, <lizhijian@fujitsu.com>, <anisa.su@samsung.com>,
 <linux-cxl@vger.kernel.org>
Subject: [RFC PATCH 7/7] hw/cxl: Add tag-based removal functionality
Date: Thu, 27 Nov 2025 22:55:25 +0000
Message-ID: <20251127225526.700-8-alireza.sanaee@huawei.com>
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

Add tag based removal, in which alias tear down must be done properly.

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 hw/mem/cxl_type3.c | 119 +++++++++++++++++++++++++++++++++++++++++++++
 qapi/cxl.json      |  46 ++++++++++++++++++
 2 files changed, 165 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index d3ea62ef3f..29355792da 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -2186,6 +2186,61 @@ void qmp_cxl_add_dynamic_capacity(const char *path, uint16_t host_id,
     }
 }
 
+static void qmp_cxl_process_dynamic_capacity_tag_based(const char *path,
+        uint16_t hid, CXLDCEventType type, uint8_t rid, const char *tag,
+        CxlDynamicCapacityExtentList *records, Error **errp) {
+
+    Object *obj;
+    CXLType3Dev *dcd;
+    CXLDCExtentList *list = NULL;
+    CXLDCExtent *ent;
+    g_autofree CXLDCExtentRaw *extents = NULL;
+
+    obj = object_resolve_path_type(path, TYPE_CXL_TYPE3, NULL);
+    if (!obj) {
+        error_setg(errp, "Unable to resolve CXL type 3 device");
+        return;
+    }
+
+    dcd = CXL_TYPE3(obj);
+    if (!dcd->dc.num_regions) {
+        error_setg(errp, "No dynamic capacity support from the device");
+        return;
+    }
+
+    if (rid >= dcd->dc.num_regions) {
+        error_setg(errp, "region id is too large");
+        return;
+    }
+
+    QemuUUID uuid_req;
+    qemu_uuid_parse(tag, &uuid_req);
+
+    list = &dcd->dc.extents;
+    size_t cap = 8, n = 0;
+    extents = g_new0(CXLDCExtentRaw, cap);
+    QTAILQ_FOREACH(ent, list, node) {
+        QemuUUID uuid_ext;
+        memcpy(&uuid_ext.data, ent->tag, sizeof(ent->tag));
+        if (!qemu_uuid_is_equal(&uuid_req, &uuid_ext)) {
+            continue;
+        }
+
+        if (n == cap) {
+            cap = cap < 8 ? 8 : cap * 2;
+            extents = g_renew(CXLDCExtentRaw, extents, cap);
+        }
+
+        extents[n++] = (CXLDCExtentRaw){ .start_dpa = ent->start_dpa,
+                                         .len = ent->len,
+                                         .shared_seq = 0 };
+    }
+
+    extents = g_renew(CXLDCExtentRaw, extents, n);
+    cxl_create_dc_event_records_for_extents(dcd, type, extents, n);
+    return;
+}
+
 void qmp_cxl_release_dynamic_capacity(const char *path, uint16_t host_id,
                                       CxlExtentRemovalPolicy removal_policy,
                                       bool has_forced_removal,
@@ -2212,6 +2267,10 @@ void qmp_cxl_release_dynamic_capacity(const char *path, uint16_t host_id,
                                                       region, tag, extents,
                                                       errp);
         return;
+    case CXL_EXTENT_REMOVAL_POLICY_TAG_BASED:
+        qmp_cxl_process_dynamic_capacity_tag_based(path, host_id, type, region,
+                                                   tag, extents, errp);
+        return;
     default:
         error_setg(errp, "Removal policy not supported");
         return;
@@ -2241,6 +2300,66 @@ void cxl_remove_memory_alias(CXLType3Dev *dcd, struct CXLFixedWindow *fw,
     return;
 }
 
+/*
+ * This function allows for a simple check to make sure that
+ * our extent is removed. It can be used by an orchestration layer.
+ */
+ExtentStatus *qmp_cxl_release_dynamic_capacity_status(const char *path,
+                                                      uint16_t hid, uint8_t rid,
+                                                      const char *tag,
+                                                      Error **errp)
+{
+    Object *obj;
+    CXLType3Dev *dcd;
+    CXLDCExtentList *list = NULL;
+    CXLDCExtent *ent;
+    QemuUUID uuid_req;
+    ExtentStatus *res = g_new0(ExtentStatus, 1);
+
+    obj = object_resolve_path_type(path, TYPE_CXL_TYPE3, NULL);
+    if (!obj) {
+        error_setg(errp, "Unable to resolve CXL type 3 device");
+        return NULL;
+    }
+
+    dcd = CXL_TYPE3(obj);
+    if (!dcd->dc.num_regions) {
+        error_setg(errp, "No dynamic capacity support from the device");
+        return NULL;
+    }
+
+    if (rid >= dcd->dc.num_regions) {
+        error_setg(errp, "Region id is too large");
+        return NULL;
+    }
+
+    if (!tag) {
+        error_setg(errp, "Tag must be valid");
+        return NULL;
+    }
+
+    list = &dcd->dc.extents;
+    qemu_uuid_parse(tag, &uuid_req);
+
+    QTAILQ_FOREACH(ent, list, node) {
+        QemuUUID uuid_ext;
+        memcpy(&uuid_ext.data, ent->tag, sizeof(ent->tag));
+        if (qemu_uuid_is_equal(&uuid_req, &uuid_ext) == true) {
+            res->status = g_strdup("Not Released");
+            res->message =
+                g_strdup_printf("Found extent with tag %s dpa 0x%" PRIx64
+                                " len 0x%" PRIx64 "\n",
+                                ent->tag, ent->start_dpa, ent->len);
+            return res;
+        }
+    }
+
+
+    res->status = g_strdup("Released");
+    res->message = g_strdup_printf("Tag %s released or not found\n", tag);
+    return res;
+}
+
 static void ct3_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
diff --git a/qapi/cxl.json b/qapi/cxl.json
index 52cc5d4f33..3372ce3745 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -555,3 +555,49 @@
            },
   'features': [ 'unstable' ]
 }
+
+##
+# @ExtentStatus:
+# This is an object that describes the status of an extent.
+#
+# @status:   String indicating the overall result, e.g. "success".
+# @message:  Human-readable description of the outcome.
+#
+# Since: 9.1
+##
+{ 'struct': 'ExtentStatus',
+      'data': { 'status': 'str', 'message': 'str' }
+}
+
+##
+# @cxl-release-dynamic-capacity-status:
+#
+# This commands checks if an extent tag has been released or not.
+#
+# @path: path to the CXL Dynamic Capacity Device in the QOM tree.
+#
+# @host-id: The "Host ID" field as defined in Compute Express Link
+#     (CXL) Specification, Revision 3.1, Table 7-71.
+#
+# @region: The "Region Number" field as defined in Compute Express
+#     Link Specification, Revision 3.1, Table 7-71.  Valid range
+#     is from 0-7.
+#
+# @tag: The "Tag" field as defined in Compute Express Link (CXL)
+#     Specification, Revision 3.1, Table 7-71.
+#
+# Features:
+#
+# @unstable: For now this command is subject to change.
+#
+# Since: 9.1
+##
+{ 'command': 'cxl-release-dynamic-capacity-status',
+  'data': { 'path': 'str',
+            'host-id': 'uint16',
+            'region': 'uint8',
+            'tag': 'str'
+           },
+  'features': [ 'unstable' ],
+  'returns': 'ExtentStatus'
+}
-- 
2.43.0


