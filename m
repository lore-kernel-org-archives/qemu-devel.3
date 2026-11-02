Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867DC606A326
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bQQKnGN+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNofn-0001C7-5r; Mon, 02 Nov 2026 04:49:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNofj-0001Bq-HT
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 04:49:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNofh-00039l-GI
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 04:49:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793612983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NLsOL2M4LpxnrQJ3CnmLEeop7cxmqS7NCiZZibDUqgc=;
 b=bQQKnGN+G33J/FvihBt5r4gKMYehyL1UJF96KchOmrIOezda+cqVq8F7wbkwsF4+5vrCTU
 URRG5vGir9bZRWhFPr2wK7/XmW9WDUJzUDYSqB7lT0D0+bRJEdaRtrZbs/x6QGKzFuqooh
 yLgnAlDpPiz2S+G7SEhu7JfhEf27HcM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-1tnZBwuDOsW1cv2w4KdERA-1; Mon,
 02 Nov 2026 04:49:42 -0500
X-MC-Unique: 1tnZBwuDOsW1cv2w4KdERA-1
X-Mimecast-MFC-AGG-ID: 1tnZBwuDOsW1cv2w4KdERA_1793612981
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCC9D1955DBE; Mon,  2 Nov 2026 09:49:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19FC77E0; Mon,  2 Nov 2026 09:49:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B36C721E6A04; Mon, 02 Nov 2026 10:49:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  marcandre.lureau@redhat.com,
 pbonzini@redhat.com,  berrange@redhat.com, stanleyjhu@google.com,
 jeuk20.kim@samsung.com
Subject: [PATCH v8 48.5/56] hw/ufs: Convert PropertyInfo to QAPITypeInfo
In-Reply-To: <20261101201717.3911097-49-armbru@redhat.com> (Markus
 Armbruster's message of "Sun, 1 Nov 2026 21:17:09 +0100")
References: <20261101201717.3911097-1-armbru@redhat.com>
 <20261101201717.3911097-49-armbru@redhat.com>
Date: Mon, 02 Nov 2026 10:49:37 +0100
Message-ID: <87tslzr2a6.fsf_-_@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This gives properties "x-fault-inject-tag" and "x-fault-inject-mode" a
generated type_info with a valid masked_name, so it appears in
query-qmp-schema introspection and the qapi-type field of
qom-list-properties output.

The conversion is trivial for ufs_prop_get_fault_inject_tag.  For
ufs_prop_get_fault_inject_tag, we need to conver UfsFaultInjectMode to
a QAPI enum.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
Fixup needed for commit c821f2f69f1 (hw/ufs: Add experimental fault
injection properties for holding requests)

 qapi/common.json | 30 ++++++++++++++++++++++++++++++
 hw/ufs/ufs.h     | 34 ----------------------------------
 hw/ufs/ufs.c     | 15 +++------------
 3 files changed, 33 insertions(+), 46 deletions(-)

diff --git a/qapi/common.json b/qapi/common.json
index 68b649ecf2..84f12c133a 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -245,3 +245,33 @@
     'tm_hour': 'int32',
     'tm_min': 'int32',
     'tm_sec': 'int32' } }
+
+##
+# @UfsFaultInjectMode:
+#     Fault injection modes for x-fault-inject-mode property.
+#     Controls how the held transfer request and subsequent Task
+#     Management Request (TMR) are resolved by the controller:
+#
+# @abort-success: TMR ABORT_TASK aborts the held request, clears its
+#     state, and returns SUCCESS (COMPL).
+#
+# @abort-failed: TMR ABORT_TASK returns TASK_MANAGEMENT_FUNC_FAILED,
+#     forcing host driver to escalate to Host Reset.
+#
+# @in-transition: TMR QUERY_TASK releases the held request to execute
+#     normally through the SCSI layer and returns the real task status
+#     (SUCCEEDED while the command is still in flight); ABORT_TASK
+#     cancels the held request and returns FUNCTION_COMPLETE.
+#
+# @timeout: TMR ABORT_TASK does not complete or clear doorbell,
+#     triggering hardware-level TMR timeout.
+#
+# @ssu-timeout: Intercepts SCSI START_STOP (0x1B) commands targeting
+#     the UFS Device WLUN when x-fault-inject-tag is armed.
+#
+# Since: 11.2
+##
+{ 'enum': 'UfsFaultInjectMode',
+  'prefix': 'UFS_FAULT_INJECT',
+  'data': [ 'abort-success', 'abort-failed', 'in-transition', 'timeout',
+            'ssu-timeout' ] }
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index 7ddc540546..0014978322 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -90,39 +90,6 @@ typedef struct UfsLu {
     UfsScsiOp scsi_op;
 } UfsLu;
 
-/*
- * Fault injection modes for x-fault-inject-mode property.
- * Controls how the held transfer request and subsequent Task Management
- * Request (TMR) are resolved by the controller:
- *
- * UFS_FAULT_INJECT_ABORT_SUCCESS: TMR ABORT_TASK aborts the held request,
- *                                 clears its state, and returns SUCCESS
- *                                 (COMPL).
- * UFS_FAULT_INJECT_ABORT_FAILED:  TMR ABORT_TASK returns
- *                                 TASK_MANAGEMENT_FUNC_FAILED, forcing host
- *                                 driver to escalate to Host Reset.
- * UFS_FAULT_INJECT_IN_TRANSITION: TMR QUERY_TASK releases the held request to
- *                                 execute normally through the SCSI layer and
- *                                 returns the real task status (SUCCEEDED while
- *                                 the command is still in flight);
- *                                 ABORT_TASK cancels the held request and
- *                                 returns FUNCTION_COMPLETE.
- * UFS_FAULT_INJECT_TIMEOUT:       TMR ABORT_TASK does not complete or clear
- *                                 doorbell, triggering hardware-level TMR
- *                                 timeout.
- * UFS_FAULT_INJECT_SSU_TIMEOUT:   Intercepts SCSI START_STOP (0x1B) commands
- *                                 targeting the UFS Device WLUN when
- *                                 x-fault-inject-tag is armed.
- */
-typedef enum UfsFaultInjectMode {
-    UFS_FAULT_INJECT_ABORT_SUCCESS = 0,
-    UFS_FAULT_INJECT_ABORT_FAILED,
-    UFS_FAULT_INJECT_IN_TRANSITION,
-    UFS_FAULT_INJECT_TIMEOUT,
-    UFS_FAULT_INJECT_SSU_TIMEOUT,
-    UFS_FAULT_INJECT_MODE_MAX,
-} UfsFaultInjectMode;
-
 /*
  * Sentinel values for x-fault-inject-tag property.
  * Task Tags in UFS are 8-bit (0..255). Values >= 256 are reserved as
@@ -375,6 +342,5 @@ void ufs_unrealize(UfsHc *u);
 
 extern const PropertyInfo ufs_prop_fault_inject_tag;
 extern const PropertyInfo ufs_prop_fault_inject_mode;
-extern const QEnumLookup UfsFaultInjectMode_lookup;
 
 #endif /* HW_UFS_UFS_H */
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index f8da7c9554..3de67831ea 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -15,6 +15,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "qapi/visitor.h"
 #include "scsi/constants.h"
 #include "hw/core/irq.h"
@@ -3234,17 +3235,6 @@ static void ufs_init_hc(UfsHc *u)
     ufs_fault_inject_init(u);
 }
 
-const QEnumLookup UfsFaultInjectMode_lookup = {
-    .array = (const char *const[]) {
-        [UFS_FAULT_INJECT_ABORT_SUCCESS] = "abort-success",
-        [UFS_FAULT_INJECT_ABORT_FAILED] = "abort-failed",
-        [UFS_FAULT_INJECT_IN_TRANSITION] = "in-transition",
-        [UFS_FAULT_INJECT_TIMEOUT] = "timeout",
-        [UFS_FAULT_INJECT_SSU_TIMEOUT] = "ssu-timeout",
-    },
-    .size = UFS_FAULT_INJECT_MODE_MAX,
-};
-
 static void ufs_prop_get_fault_inject_tag(Object *obj, Visitor *v,
                                           const char *name, void *opaque,
                                           Error **errp)
@@ -3300,6 +3290,7 @@ static void ufs_prop_set_default_fault_inject_tag(ObjectProperty *op,
 
 const PropertyInfo ufs_prop_fault_inject_tag = {
     .type = "uint32",
+    .qapi_type = &uint32_type_info,
     .description = "Task tag to hold for fault injection",
     .get = ufs_prop_get_fault_inject_tag,
     .set = ufs_prop_set_fault_inject_tag,
@@ -3309,9 +3300,9 @@ const PropertyInfo ufs_prop_fault_inject_tag = {
 
 const PropertyInfo ufs_prop_fault_inject_mode = {
     .type = "UfsFaultInjectMode",
+    .qapi_type = &UfsFaultInjectMode_type_info,
     .description = "Fault injection mode: abort-success, abort-failed, "
                    "in-transition, timeout, ssu-timeout",
-    .enum_table = &UfsFaultInjectMode_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
-- 
2.55.0


