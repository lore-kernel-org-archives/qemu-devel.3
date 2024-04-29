Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D522C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 16:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1TMH-0004Xv-Es; Mon, 29 Apr 2024 11:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TMB-0004Vu-7U
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:55:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TM5-0005Fo-U3
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:55:53 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43TFmnhD023131; Mon, 29 Apr 2024 15:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=TtzXAOMSJ+mFPsS060bW1BIYuL+1IqosMX6aAuhUFBc=;
 b=dEFIgmEMytoW7mzIPB9s9NsSaGxgiAVN5FiK6H0awX0hdVZYcIZsIzxpNJyl53UVt8h9
 MZN7isdagMCZldWq6LGYIwd+w6oQW0tsqfq/9QEOeN3XmMePtrlelIxiSXP95KEZTqdG
 CKsUp2WuRB4qUgkmei2hsBMfpAqJvoBvs8wwY7zGcKInC/oreMTrggEGFHgSr3WRw4U7
 dOFyQQO60HfdeARirSPiBPeCSDryvnO94DXP2sI01XKC4rlU6L4xVTkmh1yFb8iY5nLA
 qLJFkSvPIeX4dq8qAkcbjICS5+tr5npwpdZ4J4d/4Jr4jgBfrhTKITDPfr7tbwtm1BsI Yw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrryv2wbt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:47 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43TEheoD011366; Mon, 29 Apr 2024 15:55:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xrqt6j6ap-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:46 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43TFtaGq034442;
 Mon, 29 Apr 2024 15:55:45 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3xrqt6j5ys-13; Mon, 29 Apr 2024 15:55:45 +0000
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
Subject: [PATCH V1 12/26] migration: vmstate factory object
Date: Mon, 29 Apr 2024 08:55:21 -0700
Message-Id: <1714406135-451286-13-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: jCwUEuM3k0csDSnwJbllX2OWoYHJqr47
X-Proofpoint-ORIG-GUID: jCwUEuM3k0csDSnwJbllX2OWoYHJqr47
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

During the precreate phase, we will load migration state that will be used
to create objects, but those objects have not been created and have not
registered a vmstate handler yet.  We don't know how many objects will be
created, or what their names and ids will be, so we don't know what vmstate
handlers to register.

To solve this problem, define the factory object.  A factory object
is added to the outgoing migration stream as usual, by registering a
vmsd and opaque pointer.  During incoming migration, it is allocated
on demand, without relying on a pre-registered object's opaque address.
Instead, register a factory that knows the object's size.  loadvm receives
an idstr which contains a factory name, finds the factory, allocates
the object, then loads the fields as usual.  The object is added to a
factory_objects list, tagged by name and id, to be found and claimed
later by object-specific code.

A factory is a registered VMStateDescription with factory=true and
instance_id VMSTATE_INSTANCE_ID_FACTORY.

A factory object is registered using the same VMStateDescription, but with
its own instance_name and instance_id.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/vmstate.h | 66 +++++++++++++++++++++++++++++++++++++-
 migration/meson.build       |  1 +
 migration/savevm.c          | 66 ++++++++++++++++++++++++++++++++++++--
 migration/trace-events      |  5 +++
 migration/vmstate-factory.c | 78 +++++++++++++++++++++++++++++++++++++++++++++
 stubs/vmstate.c             |  6 ++++
 6 files changed, 218 insertions(+), 4 deletions(-)
 create mode 100644 migration/vmstate-factory.c

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 8cb3d2b..00ad864 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -204,6 +204,11 @@ struct VMStateDescription {
      */
     bool precreate;
 
+    /*
+     * This VMSD is a factory or a factory object.
+     */
+    bool factory;
+
     int version_id;
     int minimum_version_id;
     MigrationPriority priority;
@@ -1228,6 +1233,17 @@ bool vmstate_section_needed(const VMStateDescription *vmsd, void *opaque);
 typedef char (VMStateId)[256];
 
 #define  VMSTATE_INSTANCE_ID_ANY  -1
+#define VMSTATE_INSTANCE_ID_FACTORY -2
+
+#include "qemu/queue.h"
+
+typedef struct FactoryObject {
+    char *factory_name;
+    char *instance_name;
+    int instance_id;
+    void *opaque;
+    QLIST_ENTRY(FactoryObject) next;
+} FactoryObject;
 
 /* Returns: 0 on success, -1 on failure */
 int vmstate_register_with_alias_id(VMStateIf *obj, uint32_t instance_id,
@@ -1266,6 +1282,10 @@ static void __attribute__((constructor)) vmstate_register_ ## _vmsd(void)   \
     vmstate_register_init_add(_obj, _id, &_vmsd, _opaque);                  \
 }
 
+#define vmstate_register_init_factory(_vmsd, _type)                         \
+    vmstate_register_init(NULL, VMSTATE_INSTANCE_ID_FACTORY,                \
+                          _vmsd, (void *)sizeof(_type))
+
 void vmstate_register_init_add(VMStateIf *obj, int instance_id,
                                const VMStateDescription *vmsd, void *opaque);
 
@@ -1301,8 +1321,20 @@ static inline int vmstate_register_any(VMStateIf *obj,
 }
 
 /**
+ * vmstate_register_factory() - register a factory name and size, needed to
+ * recognize incoming factory objects.
+ */
+static inline int vmstate_register_factory(const VMStateDescription *vmsd,
+                                           long size)
+{
+    return vmstate_register_with_alias_id(NULL, VMSTATE_INSTANCE_ID_FACTORY,
+                                          vmsd, (void *)size, -1, 0, NULL,
+                                          NULL);
+}
+
+/**
  * vmstate_register_named() - pass an instance_name explicitly instead of
- * implicitly via VMStateIf get_id().  Needed to register a instance-specific
+ * implicitly via VMStateIf get_id().  Needed to register an instance-specific
  * VMSD for objects that are not Objects.
  */
 static inline int vmstate_register_named(const char *instance_name,
@@ -1332,4 +1364,36 @@ void vmstate_register_ram_global(struct MemoryRegion *memory);
 
 bool vmstate_check_only_migratable(const VMStateDescription *vmsd);
 
+/*
+ * Add to the factory object list, called during loadvm.
+ */
+void vmstate_add_factory_object(const char *factory_name,
+                                const char *instance_name,
+                                int instance_id,
+                                void *opaque);
+
+/*
+ * Search for and return a factory object.
+ */
+void *vmstate_find_factory_object(const char *factory_name,
+                                  const char *instance_name,
+                                  int instance_id);
+
+/*
+ * Search for and return a factory object, removing it from the list.
+ */
+void *vmstate_claim_factory_object(const char *factory_name,
+                                   const char *instance_name,
+                                   int instance_id);
+
+typedef int (*vmstate_walk_factory_cb)(FactoryObject *obj, void *opaque);
+
+/*
+ * Search for registered factory objects (ie, outgoing)
+ * and call cb passing opaque.
+ */
+int vmstate_walk_factory_outgoing(const char *factory_name,
+                                  vmstate_walk_factory_cb cb,
+                                  void *opaque);
+
 #endif
diff --git a/migration/meson.build b/migration/meson.build
index 50e7cb2..e667b40 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -5,6 +5,7 @@ migration_files = files(
   'xbzrle.c',
   'vmstate-types.c',
   'vmstate.c',
+  'vmstate-factory.c',
   'qemu-file.c',
   'yank_functions.c',
 )
diff --git a/migration/savevm.c b/migration/savevm.c
index ec48da9..01ed78c 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1407,7 +1407,8 @@ int qemu_savevm_precreate_save(QEMUFile *f, Error **errp)
     qemu_put_be32(f, QEMU_VM_FILE_VERSION);
 
     SAVEVM_FOREACH_ALL(se, entry) {
-        if (se->vmsd && se->vmsd->precreate) {
+        if (se->vmsd && se->vmsd->precreate &&
+            se->instance_id != VMSTATE_INSTANCE_ID_FACTORY) {
             ret = vmstate_save(f, se, NULL, errp);
             if (ret) {
                 qemu_file_set_error(f, ret);
@@ -1951,6 +1952,45 @@ static SaveStateEntry *find_se(const char *idstr, uint32_t instance_id)
     return NULL;
 }
 
+int vmstate_walk_factory_outgoing(const char *factory_name,
+                                  vmstate_walk_factory_cb cb, void *cb_data)
+{
+    SaveStateEntry *se, *new_se;
+    int ret, instance_len;
+    FactoryObject obj;
+    VMStateId idstr;
+    char *se_factory_name;
+
+    SAVEVM_FOREACH_SAFE_ALL(se, entry, new_se) {
+        if (!se->vmsd || !se->vmsd->factory) {
+            continue;
+        }
+        if (se->instance_id == VMSTATE_INSTANCE_ID_FACTORY) {
+            /* This is the factory itself, not a generated instance */
+            continue;
+        }
+
+        se_factory_name = strrchr(se->idstr, '/');
+        if (factory_name && strcmp(se_factory_name + 1, factory_name)) {
+            continue;
+        }
+
+        strcpy(idstr, se->idstr);
+        instance_len = se_factory_name - se->idstr;
+        idstr[instance_len] = 0;
+        obj.factory_name = idstr + instance_len + 1;
+        obj.instance_name = idstr;
+        obj.instance_id = se->instance_id;
+        obj.opaque = se->opaque;
+
+        ret = cb(&obj, cb_data);
+        if (ret) {
+            return ret;
+        }
+    }
+    return 0;
+}
+
 enum LoadVMExitCodes {
     /* Allow a command to quit all layers of nested loadvm loops */
     LOADVM_QUIT     =  1,
@@ -2721,8 +2761,9 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
     bool trace_downtime = (type == QEMU_VM_SECTION_FULL);
     uint32_t instance_id, version_id, section_id;
     int64_t start_ts, end_ts;
-    SaveStateEntry *se;
-    VMStateId idstr;
+    SaveStateEntry *se, new_se;
+    VMStateId idstr, instance_name;
+    char *factory_name = NULL;
     int ret;
 
     /* Read section start */
@@ -2744,8 +2785,22 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
 
     trace_qemu_loadvm_state_section_startfull(section_id, idstr,
             instance_id, version_id);
+
     /* Find savevm section */
     se = find_se(idstr, instance_id);
+
+    if (se == NULL) {
+        pstrcpy(instance_name, sizeof(idstr), idstr);
+        factory_name = strrchr(instance_name, '/');
+        if (factory_name) {
+            *factory_name++ = 0;
+            se = find_se(factory_name, VMSTATE_INSTANCE_ID_FACTORY);
+            new_se = *se;
+            new_se.opaque = g_malloc((long)se->opaque);
+            se = &new_se;
+        }
+    }
+
     if (se == NULL) {
         error_report("Unknown savevm section or instance '%s' %"PRIu32". "
                      "Make sure that your current VM setup matches your "
@@ -2780,6 +2835,11 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
         return ret;
     }
 
+    if (factory_name) {
+        vmstate_add_factory_object(factory_name, instance_name, instance_id,
+                                   se->opaque);
+    }
+
     if (trace_downtime) {
         end_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
         trace_vmstate_downtime_load("non-iterable", se->idstr,
diff --git a/migration/trace-events b/migration/trace-events
index 1e23238..3b9c292 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -72,6 +72,11 @@ vmstate_subsection_save_loop(const char *name, const char *sub) "%s/%s"
 vmstate_subsection_save_top(const char *idstr) "%s"
 vmstate_field_exists(const char *vmsd, const char *name, int field_version, int version, int result) "%s:%s field_version %d version %d result %d"
 
+# vmstate-factory.c
+vmstate_add_factory_object(const char *factory_name, const char *idstr, int instance_id, void *opaque) " %s, %s, %d, %p"
+vmstate_find_factory_object(const char *factory_name, const char *instance_name, int instance_id, void *opaque) "%s, %s, %d -> %p"
+vmstate_claim_factory_object(const char *factory_name, const char *instance_name, int instance_id, void *opaque) "%s, %s, %d -> %p"
+
 # vmstate-types.c
 get_qtailq(const char *name, int version_id) "%s v%d"
 get_qtailq_end(const char *name, const char *reason, int val) "%s %s/%d"
diff --git a/migration/vmstate-factory.c b/migration/vmstate-factory.c
new file mode 100644
index 0000000..e425666
--- /dev/null
+++ b/migration/vmstate-factory.c
@@ -0,0 +1,78 @@
+/*
+ * Copyright (c) 2024 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+
+static QLIST_HEAD(, FactoryObject) factory_objects;
+
+void vmstate_add_factory_object(const char *factory_name,
+                                const char *instance_name,
+                                int instance_id,
+                                void *opaque)
+{
+    FactoryObject *obj = g_new0(FactoryObject, 1);
+
+    obj->opaque = opaque;
+    obj->factory_name = g_strdup(factory_name);
+    obj->instance_name = g_strdup(instance_name);
+    obj->instance_id = instance_id;
+    QLIST_INSERT_HEAD(&factory_objects, obj, next);
+    trace_vmstate_add_factory_object(factory_name, instance_name, instance_id,
+                                     opaque);
+
+}
+
+#define object_match(obj, _factory_name, _instance_name, _instance_id) \
+    (!strcmp(obj->factory_name, _factory_name) &&                      \
+     !strcmp(obj->instance_name, _instance_name) &&                    \
+     obj->instance_id == _instance_id)
+
+static FactoryObject *find_object(const char *factory_name,
+                                  const char *instance_name,
+                                  int instance_id)
+{
+    FactoryObject *obj;
+
+    QLIST_FOREACH(obj, &factory_objects, next) {
+        if (object_match(obj, factory_name, instance_name, instance_id)) {
+            return obj;
+        }
+    }
+
+    return NULL;
+}
+
+void *vmstate_find_factory_object(const char *factory_name,
+                                  const char *instance_name,
+                                  int instance_id)
+{
+    FactoryObject *obj = find_object(factory_name, instance_name, instance_id);
+    void *opaque = obj ? obj->opaque : NULL;
+
+    trace_vmstate_find_factory_object(factory_name, instance_name, instance_id,
+                                      opaque);
+    return opaque;
+}
+
+void *vmstate_claim_factory_object(const char *factory_name,
+                                   const char *instance_name,
+                                   int instance_id)
+{
+    FactoryObject *obj = find_object(factory_name, instance_name, instance_id);
+    void *opaque = obj ? obj->opaque : NULL;
+
+    if (obj) {
+        g_free(obj->factory_name);
+        g_free(obj->instance_name);
+        QLIST_REMOVE(obj, next);
+    }
+
+    trace_vmstate_claim_factory_object(factory_name, instance_name, instance_id,
+                                       opaque);
+    return opaque;
+}
diff --git a/stubs/vmstate.c b/stubs/vmstate.c
index eff8be4..0e977e2 100644
--- a/stubs/vmstate.c
+++ b/stubs/vmstate.c
@@ -24,6 +24,12 @@ void vmstate_unregister_named(const char *vmsd_name,
 {
 }
 
+int vmstate_walk_factory_outgoing(const char *factory_name,
+                                  vmstate_walk_factory_cb cb, void *cb_data)
+{
+    return 1;
+}
+
 bool vmstate_check_only_migratable(const VMStateDescription *vmsd)
 {
     return true;
-- 
1.8.3.1


