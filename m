Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD6C109C057
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 18:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5TH4-00068g-Qp; Wed, 25 Mar 2026 14:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1w5TH0-00063s-Ts
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 14:48:11 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1w5TGw-0000Jm-IY
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 14:48:10 -0400
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fgwrq2fRtzJ469d;
 Thu, 26 Mar 2026 02:47:55 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 5254F4056B;
 Thu, 26 Mar 2026 02:48:04 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.66.203) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 25 Mar 2026 18:48:03 +0000
To: <qemu-devel@nongnu.org>
CC: <anisa.su@samsung.com>, <armbru@redhat.com>, <berrange@redhat.com>,
 <eblake@redhat.com>, <jonathan.cameron@huawei.com>,
 <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, <lizhijian@fujitsu.com>,
 <mst@redhat.com>, <pbonzini@redhat.com>, <gourry@gourry.net>,
 <nifan.cxl@gmail.com>, <me@linux.beauty>
Subject: [PATCH 9/9] hw/cxl: Add QMP status query for dynamic-capacity extent
 release
Date: Wed, 25 Mar 2026 18:42:57 +0000
Message-ID: <20260325184259.366-10-alireza.sanaee@huawei.com>
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

Add a small status query so orchestration layers can check whether a tagged
extent is still pending, committed, or no longer present after a release
request.

Introduce the ExtentStatus QAPI struct and the
cxl-release-dynamic-capacity-status command.

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 hw/mem/cxl_type3.c       | 85 ++++++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3_stubs.c | 10 +++++
 qapi/cxl.json            | 46 ++++++++++++++++++++++
 3 files changed, 141 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index d5fa8a530a..8999b36e61 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -2635,6 +2635,91 @@ void cxl_remove_memory_alias(CXLType3Dev *dcd, struct CXLFixedWindow *fw,
     dcd->dc.direct_mr_bitmap &= ~(1u << hdm_id);
 }
 
+/*
+ * This function allows for a simple check to make sure that
+ * our extent is removed. It can be used by an orchestration layer.
+ */
+ExtentStatus *
+qmp_cxl_release_dynamic_capacity_status(const char *path,
+                                        uint16_t hid, uint8_t rid,
+                                        const char *tag,
+                                        Error **errp)
+{
+    Object *obj;
+    CXLType3Dev *dcd;
+    CXLDCExtentList *list = NULL;
+    CXLDCExtent *ent;
+    QemuUUID uuid_req;
+    ExtentStatus *res;
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
+    res = g_new0(ExtentStatus, 1);
+
+    /* Check committed extents */
+    QTAILQ_FOREACH(ent, list, node) {
+        QemuUUID uuid_ext;
+        g_autofree char *uuid_str = NULL;
+        memcpy(&uuid_ext.data, ent->tag, sizeof(ent->tag));
+        if (qemu_uuid_is_equal(&uuid_req, &uuid_ext)) {
+            uuid_str = qemu_uuid_unparse_strdup(&uuid_ext);
+            res->status = g_strdup("Committed");
+            res->message =
+                g_strdup_printf("Found committed extent with tag %s dpa 0x%"
+                                PRIx64 " len 0x%" PRIx64,
+                                uuid_str, ent->start_dpa, ent->len);
+            return res;
+        }
+    }
+
+    /* Check pending extents (not yet committed by kernel) */
+    {
+        CXLDCExtentGroup *group;
+        QTAILQ_FOREACH(group, &dcd->dc.extents_pending, node) {
+            QTAILQ_FOREACH(ent, &group->list, node) {
+                QemuUUID uuid_ext;
+                g_autofree char *uuid_str = NULL;
+                memcpy(&uuid_ext.data, ent->tag, sizeof(ent->tag));
+                if (qemu_uuid_is_equal(&uuid_req, &uuid_ext)) {
+                    uuid_str = qemu_uuid_unparse_strdup(&uuid_ext);
+                    res->status = g_strdup("Pending");
+                    res->message =
+                        g_strdup_printf("Found pending extent with tag %s"
+                                        " dpa 0x%" PRIx64 " len 0x%" PRIx64,
+                                        uuid_str, ent->start_dpa, ent->len);
+                    return res;
+                }
+            }
+        }
+    }
+
+    res->status = g_strdup("Released");
+    res->message = g_strdup_printf("Tag %s released or not found", tag);
+    return res;
+}
+
 static void ct3_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index 98292a931c..17f9414142 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -127,3 +127,13 @@ void qmp_cxl_release_dynamic_capacity(const char *path, uint16_t host_id,
 {
     error_setg(errp, "CXL Type 3 support is not compiled in");
 }
+
+ExtentStatus *qmp_cxl_release_dynamic_capacity_status(const char *path,
+                                                      uint16_t host_id,
+                                                      uint8_t region,
+                                                      const char *tag,
+                                                      Error **errp)
+{
+    error_setg(errp, "CXL Type 3 support is not compiled in");
+    return NULL;
+}
diff --git a/qapi/cxl.json b/qapi/cxl.json
index 81d6198ba0..53325ba530 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -636,3 +636,49 @@
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
+          },
+  'features': [ 'unstable' ],
+  'returns': 'ExtentStatus'
+}
-- 
2.50.1 (Apple Git-155)


