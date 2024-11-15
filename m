Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8397D68BCD
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 17:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC04k-00043B-1V; Fri, 15 Nov 2024 12:25:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tC04f-00042f-I2
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:25:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tC04d-0001WJ-NF
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:25:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731691534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cgD9ehYu1Tjdp6JJALrItoKNs/50PojM5Ut2/ekClU8=;
 b=W1nCyjgS9Antc71kDz0lU183T+/DKFw15E10OM5ciltLAW8EMjlCrxvXKITL1luD/0E8eQ
 CnQHKUHPrf9X97MyQHAePxwEO7PKVWd/m9fuAvQIyWI7LNgdUJ8O9wpzb7jwpwW2acexrH
 muwvVnTpckcWXKWRrIqmvWJLXTHOWmM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-dJgSnjdRNA-3jkhsTJWWgA-1; Fri,
 15 Nov 2024 12:25:33 -0500
X-MC-Unique: dJgSnjdRNA-3jkhsTJWWgA-1
X-Mimecast-MFC-AGG-ID: dJgSnjdRNA-3jkhsTJWWgA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A30211955F42
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 17:25:32 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.102])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D4AD13003B74; Fri, 15 Nov 2024 17:25:30 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 3/9] qom: allow failure of object_new_with_class
Date: Fri, 15 Nov 2024 17:25:15 +0000
Message-ID: <20241115172521.504102-4-berrange@redhat.com>
In-Reply-To: <20241115172521.504102-1-berrange@redhat.com>
References: <20241115172521.504102-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.12,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.658,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Since object_new_with_class() accepts a non-const parameter for
the class, callers should be prepared for failures from unexpected
input. Add an Error parameter for this and make callers check.
If the caller does not already have an Error parameter, it is
satisfactory to use &error_abort if the class parameter choice is
not driven by untrusted user input.

This conversion allows removal of any object_class_is_abstract()
checks immediately before object_new_with_class().

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 accel/accel-user.c               |  4 +++-
 include/qom/object.h             |  9 +++++++--
 net/net.c                        |  3 ++-
 qom/object.c                     |  4 ++--
 qom/object_interfaces.c          |  7 +++----
 qom/qom-qmp-cmds.c               | 11 ++++++-----
 system/vl.c                      |  6 ++++--
 target/i386/cpu-apic.c           |  8 +++++++-
 target/i386/cpu-sysemu.c         | 11 ++++++++---
 target/i386/cpu.c                |  4 ++--
 target/s390x/cpu_models_sysemu.c |  7 +++++--
 11 files changed, 49 insertions(+), 25 deletions(-)

diff --git a/accel/accel-user.c b/accel/accel-user.c
index 22b6a1a1a8..df673ec0e4 100644
--- a/accel/accel-user.c
+++ b/accel/accel-user.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/accel.h"
+#include "qapi/error.h"
 
 AccelState *current_accel(void)
 {
@@ -18,7 +19,8 @@ AccelState *current_accel(void)
         AccelClass *ac = accel_find("tcg");
 
         g_assert(ac != NULL);
-        accel = ACCEL(object_new_with_class(OBJECT_CLASS(ac)));
+        accel = ACCEL(object_new_with_class(OBJECT_CLASS(ac),
+                                            &error_abort));
     }
     return accel;
 }
diff --git a/include/qom/object.h b/include/qom/object.h
index 43c135984a..11ee472719 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -606,14 +606,19 @@ struct InterfaceClass
 /**
  * object_new_with_class:
  * @klass: The class to instantiate.
+ * @errp: pointer to be filled with error details on failure
  *
  * This function will initialize a new object using heap allocated memory.
  * The returned object has a reference count of 1, and will be freed when
  * the last reference is dropped.
  *
- * Returns: The newly allocated and instantiated object.
+ * If an instance of @klass is not permitted to be instantiated, an
+ * error will be raised. This can happen if @klass is abstract.
+ *
+ * Returns: The newly allocated and instantiated object, or NULL
+ * on error.
  */
-Object *object_new_with_class(ObjectClass *klass);
+Object *object_new_with_class(ObjectClass *klass, Error **errp);
 
 /**
  * object_new:
diff --git a/net/net.c b/net/net.c
index 7ef6885876..fbbfe602a4 100644
--- a/net/net.c
+++ b/net/net.c
@@ -948,7 +948,8 @@ GPtrArray *qemu_get_nic_models(const char *device_type)
              * create this property during instance_init, so we have to create
              * a temporary instance here to be able to check it.
              */
-            Object *obj = object_new_with_class(OBJECT_CLASS(dc));
+            Object *obj = object_new_with_class(OBJECT_CLASS(dc),
+                                                &error_abort);
             if (object_property_find(obj, "netdev")) {
                 g_ptr_array_add(nic_models, (gpointer)name);
             }
diff --git a/qom/object.c b/qom/object.c
index 9632a894ee..ad5b3b9582 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -794,9 +794,9 @@ static Object *object_new_with_type(Type type, Error **errp)
     return obj;
 }
 
-Object *object_new_with_class(ObjectClass *klass)
+Object *object_new_with_class(ObjectClass *klass, Error **errp)
 {
-    return object_new_with_type(klass->type, &error_abort);
+    return object_new_with_type(klass->type, errp);
 }
 
 Object *object_new(const char *typename)
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 1a6f29c053..967b906755 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -102,13 +102,12 @@ Object *user_creatable_add_type(const char *type, const char *id,
         return NULL;
     }
 
-    if (object_class_is_abstract(klass)) {
-        error_setg(errp, "object type '%s' is abstract", type);
+    assert(qdict);
+    obj = object_new_with_class(klass, errp);
+    if (!obj) {
         return NULL;
     }
 
-    assert(qdict);
-    obj = object_new_with_class(klass);
     object_set_properties_from_qdict(obj, qdict, v, &local_err);
     if (local_err) {
         goto out;
diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 46e4562300..4a8e269fef 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -134,14 +134,15 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
         return NULL;
     }
 
-    if (!object_class_dynamic_cast(klass, TYPE_DEVICE)
-        || object_class_is_abstract(klass)) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "typename",
-                   "a non-abstract device type");
+    if (!object_class_dynamic_cast(klass, TYPE_DEVICE)) {
+        error_setg(errp, "Object '%s' is not a device type", typename);
         return NULL;
     }
 
-    obj = object_new_with_class(klass);
+    obj = object_new_with_class(klass, errp);
+    if (!obj) {
+        return NULL;
+    }
 
     object_property_iter_init(&iter, obj);
     while ((prop = object_property_iter_next(&iter))) {
diff --git a/system/vl.c b/system/vl.c
index d217b3d64d..f4eec7f35c 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2117,7 +2117,8 @@ static void qemu_create_machine(QDict *qdict)
     MachineClass *machine_class = select_machine(qdict, &error_fatal);
     object_set_machine_compat_props(machine_class->compat_props);
 
-    current_machine = MACHINE(object_new_with_class(OBJECT_CLASS(machine_class)));
+    current_machine = MACHINE(object_new_with_class(OBJECT_CLASS(machine_class),
+                                                    &error_fatal));
     object_property_add_child(object_get_root(), "machine",
                               OBJECT(current_machine));
     object_property_add_child(container_get(OBJECT(current_machine),
@@ -2327,7 +2328,8 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
         }
         goto bad;
     }
-    accel = ACCEL(object_new_with_class(OBJECT_CLASS(ac)));
+    accel = ACCEL(object_new_with_class(OBJECT_CLASS(ac),
+                                        &error_fatal));
     object_apply_compat_props(OBJECT(accel));
     qemu_opt_foreach(opts, accelerator_set_property,
                      accel,
diff --git a/target/i386/cpu-apic.c b/target/i386/cpu-apic.c
index d397ec94dc..8a518c50c7 100644
--- a/target/i386/cpu-apic.c
+++ b/target/i386/cpu-apic.c
@@ -43,12 +43,18 @@ void x86_cpu_apic_create(X86CPU *cpu, Error **errp)
 {
     APICCommonState *apic;
     APICCommonClass *apic_class = apic_get_class(errp);
+    Object *apicobj;
 
     if (!apic_class) {
         return;
     }
 
-    cpu->apic_state = DEVICE(object_new_with_class(OBJECT_CLASS(apic_class)));
+    apicobj = object_new_with_class(OBJECT_CLASS(apic_class),
+                                    errp);
+    if (!apicobj) {
+        return;
+    }
+    cpu->apic_state = DEVICE(apicobj);
     object_property_add_child(OBJECT(cpu), "lapic",
                               OBJECT(cpu->apic_state));
     object_unref(OBJECT(cpu->apic_state));
diff --git a/target/i386/cpu-sysemu.c b/target/i386/cpu-sysemu.c
index 227ac021f6..612ff09e57 100644
--- a/target/i386/cpu-sysemu.c
+++ b/target/i386/cpu-sysemu.c
@@ -156,15 +156,20 @@ static X86CPU *x86_cpu_from_model(const char *model, QObject *props,
 {
     X86CPU *xc = NULL;
     X86CPUClass *xcc;
+    Object *xcobj;
     Error *err = NULL;
 
     xcc = X86_CPU_CLASS(cpu_class_by_name(TYPE_X86_CPU, model));
     if (xcc == NULL) {
-        error_setg(&err, "CPU model '%s' not found", model);
-        goto out;
+        error_setg(errp, "CPU model '%s' not found", model);
+        return NULL;
     }
 
-    xc = X86_CPU(object_new_with_class(OBJECT_CLASS(xcc)));
+    xcobj = object_new_with_class(OBJECT_CLASS(xcc), errp);
+    if (!xcobj) {
+        return NULL;
+    }
+    xc = X86_CPU(xcobj);
     if (props) {
         object_apply_props(OBJECT(xc), props, props_arg_name, &err);
         if (err) {
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3725dbbc4b..d4315df29f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5973,7 +5973,7 @@ static GSList *get_sorted_cpu_model_list(void)
 
 static char *x86_cpu_class_get_model_id(X86CPUClass *xc)
 {
-    Object *obj = object_new_with_class(OBJECT_CLASS(xc));
+    Object *obj = object_new_with_class(OBJECT_CLASS(xc), &error_abort);
     char *r = object_property_get_str(obj, "model-id", &error_abort);
     object_unref(obj);
     return r;
@@ -6071,7 +6071,7 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
         return;
     }
 
-    xc = X86_CPU(object_new_with_class(OBJECT_CLASS(xcc)));
+    xc = X86_CPU(object_new_with_class(OBJECT_CLASS(xcc), &error_abort));
 
     x86_cpu_expand_features(xc, &err);
     if (err) {
diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_sysemu.c
index f6df691b66..7fe3093056 100644
--- a/target/s390x/cpu_models_sysemu.c
+++ b/target/s390x/cpu_models_sysemu.c
@@ -69,7 +69,7 @@ static void create_cpu_model_list(ObjectClass *klass, void *opaque)
     if (cpu_list_data->model) {
         Object *obj;
         S390CPU *sc;
-        obj = object_new_with_class(klass);
+        obj = object_new_with_class(klass, &error_abort);
         sc = S390_CPU(obj);
         if (sc->model) {
             info->has_unavailable_features = true;
@@ -116,7 +116,10 @@ static void cpu_model_from_info(S390CPUModel *model, const CpuModelInfo *info,
         error_setg(errp, "The CPU definition '%s' requires KVM", info->name);
         return;
     }
-    obj = object_new_with_class(oc);
+    obj = object_new_with_class(oc, errp);
+    if (!obj) {
+        return;
+    }
     cpu = S390_CPU(obj);
 
     if (!cpu->model) {
-- 
2.46.0


