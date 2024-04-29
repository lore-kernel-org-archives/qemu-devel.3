Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B62EC19F53
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 16:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1TMI-0004YK-7e; Mon, 29 Apr 2024 11:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TMB-0004Vt-5M
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:55:55 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TM5-0005FQ-UR
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:55:53 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43TFmtke024859; Mon, 29 Apr 2024 15:55:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=1iyEuKHKhjkeO1rjz/LH8X1Di+OzUJZsFON4pYrDrmQ=;
 b=bVY32c4lgfahy4gdY4NuLsYkqiWiJ710CAtCJyg2oBcVtVAXwad1Ik/oE0ccS0yrlyyn
 KtpO4RsrZ3KOwSIZDzYnR77tnLq6MgRQfP0wUpTx/wH6YnNecpIJrzbAq/vyn9QBDPKs
 0mYKN2vvXhxg4u9TPB9Y/dzlMSKK/Q8RhqrCqKwqfeBVVzhRmN+MXDaBTouZ1ylDjTFv
 p/fww9fmJ1frOHE4P14EUr6c2oLh5cFFXVWPMMPWk6vddFM3/J5ZLOg6G1WD6E8dMOqC
 B6q1+bbIN60+EBc6HuotKoOj8W2mL4iKZzaaChYsl6kfD1LYkYi2KQtANp5H14gX3jzX nw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqsetx3m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:45 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43TEgWMf011336; Mon, 29 Apr 2024 15:55:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xrqt6j68u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:44 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43TFtaGm034442;
 Mon, 29 Apr 2024 15:55:43 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3xrqt6j5ys-11; Mon, 29 Apr 2024 15:55:43 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 10/26] migration: vmstate_unregister_named
Date: Mon, 29 Apr 2024 08:55:19 -0700
Message-Id: <1714406135-451286-11-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_14,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290101
X-Proofpoint-ORIG-GUID: BuDJYYtSpP_O1DFjifLULu__09e91xiN
X-Proofpoint-GUID: BuDJYYtSpP_O1DFjifLULu__09e91xiN
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Define an accessor to find vmstate state handler by name and id and
unregister it.  This is needed to unregister a specific instance of an
object that is not an Object, since it lacks the VMStateIf get_id hook.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/vmstate.h |  9 +++++++++
 migration/savevm.c          | 27 +++++++++++++++++++++++++++
 migration/trace-events      |  1 +
 stubs/vmstate.c             |  6 ++++++
 4 files changed, 43 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 22aa3c6..3d71b34 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1299,6 +1299,15 @@ static inline int vmstate_register_named(const char *instance_name,
 void vmstate_unregister(VMStateIf *obj, const VMStateDescription *vmsd,
                         void *opaque);
 
+/**
+ * Delete the VMSD handler for the object with name "vmsd_name/instance_name"
+ * and matching instance_id.  If instance_id is VMSTATE_INSTANCE_ID_ANY,
+ * delete all instances matching name.
+ */
+void vmstate_unregister_named(const char *vmsd_name,
+                              const char *instance_name,
+                              int instance_id);
+
 void vmstate_register_ram(struct MemoryRegion *memory, DeviceState *dev);
 void vmstate_unregister_ram(struct MemoryRegion *memory, DeviceState *dev);
 void vmstate_register_ram_global(struct MemoryRegion *memory);
diff --git a/migration/savevm.c b/migration/savevm.c
index 86b4c87..cd2eabe 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -964,6 +964,8 @@ void vmstate_unregister(VMStateIf *obj, const VMStateDescription *vmsd,
 
     SAVEVM_FOREACH_SAFE_ALL(se, entry, new_se) {
         if (se->vmsd == vmsd && se->opaque == opaque) {
+            trace_vmstate_unregister(se->idstr, se->instance_id, (void *)vmsd,
+                                     opaque);
             savevm_state_handler_remove(se);
             g_free(se->compat);
             g_free(se);
@@ -971,6 +973,31 @@ void vmstate_unregister(VMStateIf *obj, const VMStateDescription *vmsd,
     }
 }
 
+void vmstate_unregister_named(const char *vmsd_name,
+                              const char *instance_name,
+                              int instance_id)
+{
+    SaveStateEntry *se, *new_se;
+    VMStateId idstr;
+
+    snprintf(idstr, sizeof(idstr), "%s/%s", vmsd_name, instance_name);
+
+    SAVEVM_FOREACH_SAFE_ALL(se, entry, new_se) {
+        if (!strcmp(se->idstr, idstr) &&
+            (instance_id == VMSTATE_INSTANCE_ID_ANY ||
+             se->instance_id == instance_id)) {
+            trace_vmstate_unregister(idstr, se->instance_id, (void *)se->vmsd,
+                                     se->opaque);
+            savevm_state_handler_remove(se);
+            g_free(se->compat);
+            g_free(se);
+            if (instance_id != VMSTATE_INSTANCE_ID_ANY) {
+                return;
+            }
+        }
+    }
+}
+
 static int vmstate_load(QEMUFile *f, SaveStateEntry *se)
 {
     trace_vmstate_load(se->idstr, se->vmsd ? se->vmsd->name : "(old)");
diff --git a/migration/trace-events b/migration/trace-events
index 8647147..1e23238 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -54,6 +54,7 @@ postcopy_pause_incoming(void) ""
 postcopy_pause_incoming_continued(void) ""
 postcopy_page_req_sync(void *host_addr) "sync page req %p"
 vmstate_register(const char *idstr, int id, void *vmsd, void *opaque) "%s, %d, vmsd %p, opaque %p"
+vmstate_unregister(const char *idstr, int id, void *vmsd, void *opaque) "%s, %d, vmsd %p, opaque %p"
 
 # vmstate.c
 vmstate_load_field_error(const char *field, int ret) "field \"%s\" load failed, ret = %d"
diff --git a/stubs/vmstate.c b/stubs/vmstate.c
index d67506e..eff8be4 100644
--- a/stubs/vmstate.c
+++ b/stubs/vmstate.c
@@ -18,6 +18,12 @@ void vmstate_unregister(VMStateIf *obj,
 {
 }
 
+void vmstate_unregister_named(const char *vmsd_name,
+                              const char *instance_name,
+                              int instance_id)
+{
+}
+
 bool vmstate_check_only_migratable(const VMStateDescription *vmsd)
 {
     return true;
-- 
1.8.3.1


