Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D092EC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 15:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1TMN-0004cI-QA; Mon, 29 Apr 2024 11:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TMI-0004Ya-9Z
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:56:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TMF-0005FH-V6
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:56:02 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43TFmjb6006712; Mon, 29 Apr 2024 15:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=tY/XgqmbfugZCppNeWrHSHTrYbFcI73pMuTKk9NtCoo=;
 b=og8uEnDik4o9IunnbXEIkAo0ddegTvIJDL1SPrX/fudCdjknuQgfNpTf0UY4xZTkU/o0
 fU4X0ips4EGve5OnlC+GKZVSqss5K8eULOj5wd75fVMkQmeTnmXikcVbQg09at9QEiYz
 p7p0NWiumeaUo0Fyb4jhwEuZih3+0c/262uf2BcK1ax4zqAkCzEaIlaC1k6x4zGtH0qf
 Tp+3wSJ4PptbvvJPKx6Q5oSHy7q1yvITpIWD+HSsdVGise7UF9MrCUFtNIZffxLj79XW
 ojVIYrXG3RQbyaChmhBQWObiNAPrRVbKcGnA7bmkSh6O9d1yPCvbFB+bEDWF3fv5KuKs iA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrsdejwmv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:44 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43TEdOSa011469; Mon, 29 Apr 2024 15:55:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xrqt6j67k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:43 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43TFtaGk034442;
 Mon, 29 Apr 2024 15:55:42 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3xrqt6j5ys-10; Mon, 29 Apr 2024 15:55:42 +0000
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
Subject: [PATCH V1 09/26] migration: vmstate_register_named
Date: Mon, 29 Apr 2024 08:55:18 -0700
Message-Id: <1714406135-451286-10-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: WEZZNIVNuHiWFwWOzeazeRuLu8RgV6TC
X-Proofpoint-ORIG-GUID: WEZZNIVNuHiWFwWOzeazeRuLu8RgV6TC
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

Define vmstate_register_named which takes the instance name as its first
parameter, instead of generating the name from VMStateIf of the Object.
This will be needed to register objects that are not Objects.  Pass the
new name parameter to vmstate_register_with_alias_id.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/core/qdev.c              |  1 +
 hw/intc/apic_common.c       |  2 +-
 include/migration/vmstate.h | 19 +++++++++++++++++--
 migration/savevm.c          | 35 ++++++++++++++++++++++++-----------
 migration/trace-events      |  1 +
 stubs/vmstate.c             |  1 +
 6 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 00efaf1..b352e8a 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -535,6 +535,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
                                                qdev_get_vmsd(dev), dev,
                                                dev->instance_id_alias,
                                                dev->alias_required_for_version,
+                                               NULL,
                                                &local_err) < 0) {
                 goto post_realize_fail;
             }
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index d8fc1e2..d6cd293 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -298,7 +298,7 @@ static void apic_common_realize(DeviceState *dev, Error **errp)
         instance_id = VMSTATE_INSTANCE_ID_ANY;
     }
     vmstate_register_with_alias_id(NULL, instance_id, &vmstate_apic_common,
-                                   s, -1, 0, NULL);
+                                   s, -1, 0, NULL, NULL);
 
     /* APIC LDR in x2APIC mode */
     s->extended_log_dest = ((s->initial_apic_id >> 4) << 16) |
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index bb885d9..22aa3c6 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1234,6 +1234,7 @@ int vmstate_register_with_alias_id(VMStateIf *obj, uint32_t instance_id,
                                    const VMStateDescription *vmsd,
                                    void *base, int alias_id,
                                    int required_for_version,
+                                   const char *instance_name,
                                    Error **errp);
 
 /**
@@ -1250,7 +1251,7 @@ static inline int vmstate_register(VMStateIf *obj, int instance_id,
                                    void *opaque)
 {
     return vmstate_register_with_alias_id(obj, instance_id, vmsd,
-                                          opaque, -1, 0, NULL);
+                                          opaque, -1, 0, NULL, NULL);
 }
 
 /**
@@ -1278,7 +1279,21 @@ static inline int vmstate_register_any(VMStateIf *obj,
                                        void *opaque)
 {
     return vmstate_register_with_alias_id(obj, VMSTATE_INSTANCE_ID_ANY, vmsd,
-                                          opaque, -1, 0, NULL);
+                                          opaque, -1, 0, NULL, NULL);
+}
+
+/**
+ * vmstate_register_named() - pass an instance_name explicitly instead of
+ * implicitly via VMStateIf get_id().  Needed to register a instance-specific
+ * VMSD for objects that are not Objects.
+ */
+static inline int vmstate_register_named(const char *instance_name,
+                                         int instance_id,
+                                         const VMStateDescription *vmsd,
+                                         void *opaque)
+{
+    return vmstate_register_with_alias_id(NULL, instance_id, vmsd, opaque,
+                                          -1, 0, instance_name, NULL);
 }
 
 void vmstate_unregister(VMStateIf *obj, const VMStateDescription *vmsd,
diff --git a/migration/savevm.c b/migration/savevm.c
index 9b1a335..86b4c87 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -889,10 +889,20 @@ int vmstate_replace_hack_for_ppc(VMStateIf *obj, int instance_id,
     return vmstate_register(obj, instance_id, vmsd, opaque);
 }
 
+static bool make_new_idstr(VMStateId idstr, const char *id, Error **errp)
+{
+    if (snprintf(idstr, sizeof(VMStateId), "%s/", id) >= sizeof(VMStateId)) {
+        error_setg(errp, "Path too long for VMState (%s)", id);
+        return false;
+    }
+    return true;
+}
+
 int vmstate_register_with_alias_id(VMStateIf *obj, uint32_t instance_id,
                                    const VMStateDescription *vmsd,
                                    void *opaque, int alias_id,
                                    int required_for_version,
+                                   const char *instance_name,
                                    Error **errp)
 {
     SaveStateEntry *se;
@@ -907,19 +917,17 @@ int vmstate_register_with_alias_id(VMStateIf *obj, uint32_t instance_id,
     se->vmsd = vmsd;
     se->alias_id = alias_id;
 
-    if (obj) {
-        char *id = vmstate_if_get_id(obj);
+    if (instance_name) {
+        if (!make_new_idstr(se->idstr, instance_name, errp)) {
+            goto err;
+        }
+
+    } else if (obj) {
+        g_autofree char *id = vmstate_if_get_id(obj);
         if (id) {
-            if (snprintf(se->idstr, sizeof(se->idstr), "%s/", id) >=
-                sizeof(se->idstr)) {
-                error_setg(errp, "Path too long for VMState (%s)", id);
-                g_free(id);
-                g_free(se);
-
-                return -1;
+            if (!make_new_idstr(se->idstr, id, errp)) {
+                goto err;
             }
-            g_free(id);
-
             se->compat = g_new0(CompatEntry, 1);
             pstrcpy(se->compat->idstr, sizeof(se->compat->idstr), vmsd->name);
             se->compat->instance_id = instance_id == VMSTATE_INSTANCE_ID_ANY ?
@@ -941,7 +949,12 @@ int vmstate_register_with_alias_id(VMStateIf *obj, uint32_t instance_id,
     }
     assert(!se->compat || se->instance_id == 0);
     savevm_state_handler_insert(se);
+    trace_vmstate_register(se->idstr, se->instance_id, (void *)vmsd, opaque);
     return 0;
+
+err:
+    g_free(se);
+    return -1;
 }
 
 void vmstate_unregister(VMStateIf *obj, const VMStateDescription *vmsd,
diff --git a/migration/trace-events b/migration/trace-events
index f0e1cb8..8647147 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -53,6 +53,7 @@ vmstate_downtime_checkpoint(const char *checkpoint) "%s"
 postcopy_pause_incoming(void) ""
 postcopy_pause_incoming_continued(void) ""
 postcopy_page_req_sync(void *host_addr) "sync page req %p"
+vmstate_register(const char *idstr, int id, void *vmsd, void *opaque) "%s, %d, vmsd %p, opaque %p"
 
 # vmstate.c
 vmstate_load_field_error(const char *field, int ret) "field \"%s\" load failed, ret = %d"
diff --git a/stubs/vmstate.c b/stubs/vmstate.c
index 8513d92..d67506e 100644
--- a/stubs/vmstate.c
+++ b/stubs/vmstate.c
@@ -6,6 +6,7 @@ int vmstate_register_with_alias_id(VMStateIf *obj,
                                    const VMStateDescription *vmsd,
                                    void *base, int alias_id,
                                    int required_for_version,
+                                   const char *instance_name,
                                    Error **errp)
 {
     return 0;
-- 
1.8.3.1


