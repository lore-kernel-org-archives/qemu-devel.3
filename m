Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43D0D767DF
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 15:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6XUr-0005Mi-7S; Thu, 31 Oct 2024 11:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t6XUq-0005MA-2H
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 11:54:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t6XUo-0006K7-D8
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 11:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730390041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nJlRx6Y+wtG+T3LLQeEE1rg8875ZaX09z0Et7RmwsCI=;
 b=fxF3TEaSATVz1UZglnzdCeZwKuPg5MdQ9KjY7yE678b3PEKvaG8wE8w0DlZ+bkfIy34Pio
 IFEQgo3wd3qG+FX8ZBuO9xUHaKgok1oZ8VptPzrpapukAYxhdLVIM6i4R2yMogSAnQjckA
 NWMX+NF9N7MOYkPfwM/OhDnj2Qwhjdk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-1nXQIbvGO1WlTgF3c5lEmQ-1; Thu,
 31 Oct 2024 11:53:59 -0400
X-MC-Unique: 1nXQIbvGO1WlTgF3c5lEmQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CDA3A19560B1
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 15:53:57 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.18])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5D97C195605F; Thu, 31 Oct 2024 15:53:56 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC 2/5] qom: allow failure of object_new_with_class
Date: Thu, 31 Oct 2024 15:53:47 +0000
Message-ID: <20241031155350.3240361-3-berrange@redhat.com>
In-Reply-To: <20241031155350.3240361-1-berrange@redhat.com>
References: <20241031155350.3240361-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 accel/accel-user.c               |  3 ++-
 include/qom/object.h             |  9 +++++++--
 net/net.c                        | 10 ++++++----
 qom/object.c                     |  4 ++--
 system/vl.c                      |  6 ++++--
 target/i386/cpu-apic.c           |  8 +++++++-
 target/i386/cpu-sysemu.c         | 11 ++++++++---
 target/i386/cpu.c                |  4 ++--
 target/s390x/cpu_models_sysemu.c |  7 +++++--
 9 files changed, 43 insertions(+), 19 deletions(-)

diff --git a/accel/accel-user.c b/accel/accel-user.c
index 22b6a1a1a8..04ba4ab920 100644
--- a/accel/accel-user.c
+++ b/accel/accel-user.c
@@ -18,7 +18,8 @@ AccelState *current_accel(void)
         AccelClass *ac = accel_find("tcg");
 
         g_assert(ac != NULL);
-        accel = ACCEL(object_new_with_class(OBJECT_CLASS(ac)));
+        accel = ACCEL(object_new_with_class(OBJECT_CLASS(ac),
+                                            &error_abort));
     }
     return accel;
 }
diff --git a/include/qom/object.h b/include/qom/object.h
index 2af9854675..222c60e205 100644
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
index d9b23a8f8c..7fb5e966f3 100644
--- a/net/net.c
+++ b/net/net.c
@@ -944,11 +944,13 @@ GPtrArray *qemu_get_nic_models(const char *device_type)
              * create this property during instance_init, so we have to create
              * a temporary instance here to be able to check it.
              */
-            Object *obj = object_new_with_class(OBJECT_CLASS(dc));
-            if (object_property_find(obj, "netdev")) {
-                g_ptr_array_add(nic_models, (gpointer)name);
+            Object *obj = object_new_with_class(OBJECT_CLASS(dc), NULL);
+            if (obj) {
+                if (object_property_find(obj, "netdev")) {
+                    g_ptr_array_add(nic_models, (gpointer)name);
+                }
+                object_unref(obj);
             }
-            object_unref(obj);
         }
         next = list->next;
         g_slist_free_1(list);
diff --git a/qom/object.c b/qom/object.c
index 8eed5f6ed3..1f139aa9c8 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -795,9 +795,9 @@ static Object *object_new_with_type(Type type, Error **errp)
     return obj;
 }
 
-Object *object_new_with_class(ObjectClass *klass)
+Object *object_new_with_class(ObjectClass *klass, Error **errp)
 {
-    return object_new_with_type(klass->type, &error_abort);
+    return object_new_with_type(klass->type, errp);
 }
 
 Object *object_new(const char *typename)
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
index 1ff1af032e..8760f408fa 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5894,7 +5894,7 @@ static GSList *get_sorted_cpu_model_list(void)
 
 static char *x86_cpu_class_get_model_id(X86CPUClass *xc)
 {
-    Object *obj = object_new_with_class(OBJECT_CLASS(xc));
+    Object *obj = object_new_with_class(OBJECT_CLASS(xc), &error_abort);
     char *r = object_property_get_str(obj, "model-id", &error_abort);
     object_unref(obj);
     return r;
@@ -5992,7 +5992,7 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
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


