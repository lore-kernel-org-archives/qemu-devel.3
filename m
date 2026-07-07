Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB0CC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh3aO-0002ed-Fp; Tue, 07 Jul 2026 07:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wh3a5-0002Ks-9W
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:03:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wh3Zz-0007zm-0H
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783422185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=04KYZvQwpw+TnMF4p2ZFVqb3Y82GN5/Gn8zfmISmd/s=;
 b=IRtPyTVVD2K51wF9TvA6LknOQJBP3gsJBC2VpZpx6sOmz2qUwzJcFU7MbXmQXN1ZdyKzCP
 sjS4xpHHVhNEaWBFiUAWY/3L418YfuR2A6g7GItRDIlE/HJQwRxDEHyhQ6r4O2/kbxYd5w
 Qts4ifcw9LWfyvpa0+dzJxsUS0YBKAU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-pm_3PZc0PEy4AoHcOaoZiA-1; Tue,
 07 Jul 2026 07:03:04 -0400
X-MC-Unique: pm_3PZc0PEy4AoHcOaoZiA-1
X-Mimecast-MFC-AGG-ID: pm_3PZc0PEy4AoHcOaoZiA_1783422183
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97FE81954AE0
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2026 11:03:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 111FC1800745
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2026 11:03:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 97BBB21E692F; Tue, 07 Jul 2026 13:03:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 01/35] qom: replace 'can_be_deleted' with 'prepare_delete'
Date: Tue,  7 Jul 2026 13:02:26 +0200
Message-ID: <20260707110300.1918153-2-armbru@redhat.com>
In-Reply-To: <20260707110300.1918153-1-armbru@redhat.com>
References: <20260707110300.1918153-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Daniel P. Berrangé <berrange@redhat.com>

While most objects can perform all their cleanup in the finalizer
method, there can be interactions with other resources / subsystems
/ threads which require that some cleanup be performed on an user
creatable object before unparenting it and entering finalization.

The current 'can_be_deleted' method runs in the deletion path and
is intended to be used to block deletion. While it could be used
to perform cleanup tasks, its name suggests it should be free of
side-effects.

Generalize this by renaming it to 'prepare_delete', explicitly
allowing for cleanup to be provided. Existing users of 'can_be_deleted'
are re-written, which provides them with more detailed/tailored error
messages.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260706135824.2623960-2-berrange@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qom/object_interfaces.h  | 26 +++++++++++++++++---------
 include/system/event-loop-base.h |  2 +-
 backends/cryptodev.c             | 12 +++++++++---
 backends/hostmem.c               |  7 +++++--
 backends/iommufd.c               | 11 ++++++++---
 block/throttle-groups.c          | 12 +++++++++---
 event-loop-base.c                |  8 ++++----
 net/can/can_core.c               |  6 ++++--
 qom/object_interfaces.c          | 13 +++++--------
 util/main-loop.c                 |  6 ++++--
 tests/qemu-iotests/245           |  4 ++--
 11 files changed, 68 insertions(+), 39 deletions(-)

diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfaces.h
index e2b8615617..afd0fb93b2 100644
--- a/include/qom/object_interfaces.h
+++ b/include/qom/object_interfaces.h
@@ -20,8 +20,10 @@ typedef struct UserCreatable UserCreatable;
  * UserCreatableClass:
  * @parent_class: the base class
  * @complete: callback to be called after @obj's properties are set.
- * @can_be_deleted: callback to be called before an object is removed
- * to check if @obj can be removed safely.
+ * @prepare_delete: to be called before an attempt to delete @obj
+ * to validate whether the object can be deleted and trigger any
+ * cleanup of any resources which have to be dealt with before the
+ * object is unparented and enters finalization.
  *
  * Interface is designed to work with -object/object-add/object_add
  * commands.
@@ -36,7 +38,9 @@ typedef struct UserCreatable UserCreatable;
  * For objects created without using -object/object-add/object_add,
  * @user_creatable_complete() wrapper should be called manually if
  * object's type implements USER_CREATABLE interface and needs
- * complete() callback to be called.
+ * complete() callback to be called. Similarly @user_creatable_prepare_delete()
+ * should be called manually prior to an attempt to the delete the
+ * object.
  */
 struct UserCreatableClass {
     /* <private> */
@@ -44,7 +48,7 @@ struct UserCreatableClass {
 
     /* <public> */
     void (*complete)(UserCreatable *uc, Error **errp);
-    bool (*can_be_deleted)(UserCreatable *uc);
+    bool (*prepare_delete)(UserCreatable *uc, Error **errp);
 };
 
 /**
@@ -61,13 +65,17 @@ struct UserCreatableClass {
 bool user_creatable_complete(UserCreatable *uc, Error **errp);
 
 /**
- * user_creatable_can_be_deleted:
- * @uc: the object whose can_be_deleted() method is called if implemented
+ * user_creatable_prepare_delete:
+ * @uc: the user-creatable object whose prepare_delete() method is called
+ * @errp: if an error occurs, a pointer to an area to store the error
  *
- * Wrapper to call can_be_deleted() method if one of types it's inherited
- * from implements USER_CREATABLE interface.
+ * Wrapper to call prepare_delete() class method if defined, otherwise
+ * does nothing.
+ *
+ * Returns: %true on success or if prepare_delete() is not defined,
+ *          %false on failure.
  */
-bool user_creatable_can_be_deleted(UserCreatable *uc);
+bool user_creatable_prepare_delete(UserCreatable *uc, Error **errp);
 
 /**
  * user_creatable_add_qapi:
diff --git a/include/system/event-loop-base.h b/include/system/event-loop-base.h
index 130629e7f3..1e1e427ac7 100644
--- a/include/system/event-loop-base.h
+++ b/include/system/event-loop-base.h
@@ -24,7 +24,7 @@ struct EventLoopBaseClass {
 
     void (*init)(EventLoopBase *base, Error **errp);
     void (*update_params)(EventLoopBase *base, Error **errp);
-    bool (*can_be_deleted)(EventLoopBase *base);
+    bool (*prepare_delete)(EventLoopBase *base, Error **errp);
 };
 
 struct EventLoopBase {
diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index 79f8882d3b..e8f2b18f20 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -454,9 +454,15 @@ bool cryptodev_backend_is_ready(CryptoDevBackend *backend)
 }
 
 static bool
-cryptodev_backend_can_be_deleted(UserCreatable *uc)
+cryptodev_backend_prepare_delete(UserCreatable *uc, Error **errp)
 {
-    return !cryptodev_backend_is_used(CRYPTODEV_BACKEND(uc));
+    if (cryptodev_backend_is_used(CRYPTODEV_BACKEND(uc))) {
+        error_setg(errp,
+                   "Cannot delete cryptodev backend '%s' that is in use",
+                   object_get_canonical_path_component(OBJECT(uc)));
+        return false;
+    }
+    return true;
 }
 
 static void cryptodev_backend_instance_init(Object *obj)
@@ -613,7 +619,7 @@ cryptodev_backend_class_init(ObjectClass *oc, const void *data)
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
 
     ucc->complete = cryptodev_backend_complete;
-    ucc->can_be_deleted = cryptodev_backend_can_be_deleted;
+    ucc->prepare_delete = cryptodev_backend_prepare_delete;
 
     QTAILQ_INIT(&crypto_clients);
     object_class_property_add(oc, "queues", "uint32",
diff --git a/backends/hostmem.c b/backends/hostmem.c
index cd2085fb3c..5dd5fb155c 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -434,9 +434,12 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
 }
 
 static bool
-host_memory_backend_can_be_deleted(UserCreatable *uc)
+host_memory_backend_prepare_delete(UserCreatable *uc, Error **errp)
 {
     if (host_memory_backend_is_mapped(MEMORY_BACKEND(uc))) {
+        error_setg(errp,
+                   "Cannot delete host memory backend '%s' which is mapped",
+                   object_get_canonical_path_component(OBJECT(uc)));
         return false;
     } else {
         return true;
@@ -508,7 +511,7 @@ host_memory_backend_class_init(ObjectClass *oc, const void *data)
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
 
     ucc->complete = host_memory_backend_memory_complete;
-    ucc->can_be_deleted = host_memory_backend_can_be_deleted;
+    ucc->prepare_delete = host_memory_backend_prepare_delete;
 
     object_class_property_add_bool(oc, "merge",
         host_memory_backend_get_merge,
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 09624cd652..0643947140 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -63,11 +63,16 @@ static void iommufd_backend_set_fd(Object *obj, const char *str, Error **errp)
     trace_iommu_backend_set_fd(be->fd);
 }
 
-static bool iommufd_backend_can_be_deleted(UserCreatable *uc)
+static bool iommufd_backend_prepare_delete(UserCreatable *uc, Error **errp)
 {
     IOMMUFDBackend *be = IOMMUFD_BACKEND(uc);
 
-    return !be->users;
+    if (be->users) {
+        error_setg(errp, "Can not delete IOMMUFD backend '%s' with %d users",
+                   object_get_canonical_path_component(OBJECT(uc)), be->users);
+        return false;
+    }
+    return true;
 }
 
 static void iommufd_backend_complete(UserCreatable *uc, Error **errp)
@@ -92,7 +97,7 @@ static void iommufd_backend_class_init(ObjectClass *oc, const void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
 
-    ucc->can_be_deleted = iommufd_backend_can_be_deleted;
+    ucc->prepare_delete = iommufd_backend_prepare_delete;
     ucc->complete = iommufd_backend_complete;
 
     object_class_property_add_str(oc, "fd", NULL, iommufd_backend_set_fd);
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 4b1b1944c2..805e47270c 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -960,9 +960,15 @@ static void throttle_group_get_limits(Object *obj, Visitor *v,
     visit_type_ThrottleLimits(v, name, &argp, errp);
 }
 
-static bool throttle_group_can_be_deleted(UserCreatable *uc)
+static bool throttle_group_prepare_delete(UserCreatable *uc, Error **errp)
 {
-    return OBJECT(uc)->ref == 1;
+    if (OBJECT(uc)->ref > 1) {
+        error_setg(errp,
+                   "Cannot delete throttle group '%s' with active references",
+                   object_get_canonical_path_component(OBJECT(uc)));
+        return false;
+    }
+    return true;
 }
 
 static void throttle_group_obj_class_init(ObjectClass *klass,
@@ -972,7 +978,7 @@ static void throttle_group_obj_class_init(ObjectClass *klass,
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(klass);
 
     ucc->complete = throttle_group_obj_complete;
-    ucc->can_be_deleted = throttle_group_can_be_deleted;
+    ucc->prepare_delete = throttle_group_prepare_delete;
 
     /* individual properties */
     for (i = 0; i < sizeof(properties) / sizeof(ThrottleParamInfo); i++) {
diff --git a/event-loop-base.c b/event-loop-base.c
index 8ca143bea4..ee5987ddbf 100644
--- a/event-loop-base.c
+++ b/event-loop-base.c
@@ -85,13 +85,13 @@ static void event_loop_base_complete(UserCreatable *uc, Error **errp)
     }
 }
 
-static bool event_loop_base_can_be_deleted(UserCreatable *uc)
+static bool event_loop_base_prepare_delete(UserCreatable *uc, Error **errp)
 {
     EventLoopBaseClass *bc = EVENT_LOOP_BASE_GET_CLASS(uc);
     EventLoopBase *backend = EVENT_LOOP_BASE(uc);
 
-    if (bc->can_be_deleted) {
-        return bc->can_be_deleted(backend);
+    if (bc->prepare_delete) {
+        return bc->prepare_delete(backend, errp);
     }
 
     return true;
@@ -102,7 +102,7 @@ static void event_loop_base_class_init(ObjectClass *klass,
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(klass);
     ucc->complete = event_loop_base_complete;
-    ucc->can_be_deleted = event_loop_base_can_be_deleted;
+    ucc->prepare_delete = event_loop_base_prepare_delete;
 
     object_class_property_add(klass, "aio-max-batch", "int",
                               event_loop_base_get_param,
diff --git a/net/can/can_core.c b/net/can/can_core.c
index 77fe2b8ba4..6a56b33251 100644
--- a/net/can/can_core.c
+++ b/net/can/can_core.c
@@ -143,8 +143,10 @@ int can_bus_client_set_filters(CanBusClientState *client,
 }
 
 
-static bool can_bus_can_be_deleted(UserCreatable *uc)
+static bool can_bus_prepare_delete(UserCreatable *uc, Error **errp)
 {
+    error_setg(errp, "Deleting CAN bus device '%s' is not supported",
+               object_get_canonical_path_component(OBJECT(uc)));
     return false;
 }
 
@@ -153,7 +155,7 @@ static void can_bus_class_init(ObjectClass *klass,
 {
     UserCreatableClass *uc_klass = USER_CREATABLE_CLASS(klass);
 
-    uc_klass->can_be_deleted = can_bus_can_be_deleted;
+    uc_klass->prepare_delete = can_bus_prepare_delete;
 }
 
 static const TypeInfo can_bus_info = {
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 7080f85f95..3216a754ed 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -32,16 +32,14 @@ bool user_creatable_complete(UserCreatable *uc, Error **errp)
     return !*errp;
 }
 
-bool user_creatable_can_be_deleted(UserCreatable *uc)
+bool user_creatable_prepare_delete(UserCreatable *uc, Error **errp)
 {
-
     UserCreatableClass *ucc = USER_CREATABLE_GET_CLASS(uc);
 
-    if (ucc->can_be_deleted) {
-        return ucc->can_be_deleted(uc);
-    } else {
-        return true;
+    if (ucc->prepare_delete) {
+        return ucc->prepare_delete(uc, errp);
     }
+    return true;
 }
 
 void user_creatable_add_qapi(ObjectOptions *options, Error **errp)
@@ -253,8 +251,7 @@ bool user_creatable_del(const char *id, Error **errp)
         return false;
     }
 
-    if (!user_creatable_can_be_deleted(USER_CREATABLE(obj))) {
-        error_setg(errp, "object '%s' is in use, can not be deleted", id);
+    if (!user_creatable_prepare_delete(USER_CREATABLE(obj), errp)) {
         return false;
     }
 
diff --git a/util/main-loop.c b/util/main-loop.c
index ad8645c30a..65e5dbcc94 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -218,8 +218,10 @@ static void main_loop_init(EventLoopBase *base, Error **errp)
     mloop = m;
 }
 
-static bool main_loop_can_be_deleted(EventLoopBase *base)
+static bool main_loop_prepare_delete(EventLoopBase *base, Error **errp)
 {
+    error_setg(errp, "Deleting main loop '%s' is not supported",
+               object_get_canonical_path_component(OBJECT(base)));
     return false;
 }
 
@@ -229,7 +231,7 @@ static void main_loop_class_init(ObjectClass *oc, const void *class_data)
 
     bc->init = main_loop_init;
     bc->update_params = main_loop_update_params;
-    bc->can_be_deleted = main_loop_can_be_deleted;
+    bc->prepare_delete = main_loop_prepare_delete;
 }
 
 static const TypeInfo main_loop_info = {
diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index f96610f510..03550b9971 100755
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -801,7 +801,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         # Now group1 is in use, it cannot be deleted
         result = self.vm.qmp('object-del', id = 'group1')
         self.assert_qmp(result, 'error/class', 'GenericError')
-        self.assert_qmp(result, 'error/desc', "object 'group1' is in use, can not be deleted")
+        self.assert_qmp(result, 'error/desc', "Cannot delete throttle group 'group1' with active references")
 
         # Default options, this switches the group back to group0
         self.reopen(opts)
@@ -809,7 +809,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         # So now we cannot delete group0
         result = self.vm.qmp('object-del', id = 'group0')
         self.assert_qmp(result, 'error/class', 'GenericError')
-        self.assert_qmp(result, 'error/desc', "object 'group0' is in use, can not be deleted")
+        self.assert_qmp(result, 'error/desc', "Cannot delete throttle group 'group0' with active references")
 
         # But group1 is free this time, and it can be deleted
         self.vm.cmd('object-del', id = 'group1')
-- 
2.54.0


