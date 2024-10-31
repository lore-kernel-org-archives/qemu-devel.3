Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC43AD767D8
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 15:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6XUw-0005Na-P5; Thu, 31 Oct 2024 11:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t6XUv-0005My-73
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 11:54:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t6XUt-0006KV-5S
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 11:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730390046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jx77iETQYs06DrQ8yZJRqTrlVINZpRE4CtA3A5HTGPg=;
 b=FdbAXTx5kBv63+yxTh+vXoX37P4uNeWQdDOwFZA+VVmoxf5gba6bg2VPl9iWKSa63QOxJ0
 cPNrTiZ8mp+vuwUtDWDmOTmz8jEa18tzNXoofrAEiXfrv4D19NMJ1bMCn72wonVQxyH8RO
 GqHqO8rCrf1m8fZyyvdxwQh5z4fMrTs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-Vm1DpznDO8KEu6coV4aH0g-1; Thu,
 31 Oct 2024 11:54:00 -0400
X-MC-Unique: Vm1DpznDO8KEu6coV4aH0g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16D83195609D
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 15:54:00 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.18])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6909D1956054; Thu, 31 Oct 2024 15:53:58 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC 3/5] convert code to object_new_dynamic() where appropriate
Date: Thu, 31 Oct 2024 15:53:48 +0000
Message-ID: <20241031155350.3240361-4-berrange@redhat.com>
In-Reply-To: <20241031155350.3240361-1-berrange@redhat.com>
References: <20241031155350.3240361-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

In cases where object_new() is not being passed a static, const
string, the caller cannot be sure what type they are instantiating.
There is a risk that instantiation could fail, if it is an abstract
type.

Convert such cases over to use object_new_dynamic() such that they
are forced to expect failure. In some cases failure can be easily
propagated, but in others using &error_abort maintainers existing
behaviour.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 chardev/char.c                   |  5 ++++-
 hw/core/bus.c                    |  2 +-
 hw/core/cpu-common.c             |  2 +-
 hw/core/qdev.c                   |  4 ++--
 hw/i386/x86-common.c             |  5 ++++-
 hw/i386/xen/xen-pvh.c            |  2 +-
 hw/vfio/common.c                 |  6 +++++-
 hw/vfio/container.c              |  6 +++++-
 qom/object_interfaces.c          |  7 ++-----
 qom/qom-qmp-cmds.c               | 15 +++++++++------
 tests/unit/check-qom-interface.c |  3 ++-
 tests/unit/test-smp-parse.c      | 20 ++++++++++----------
 12 files changed, 46 insertions(+), 31 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index a1722aa076..4de9a496a2 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -996,7 +996,10 @@ static Chardev *chardev_new(const char *id, const char *typename,
     assert(g_str_has_prefix(typename, "chardev-"));
     assert(id);
 
-    obj = object_new(typename);
+    if (!(obj = object_new_dynamic(typename, errp))) {
+        return NULL;
+    }
+    
     chr = CHARDEV(obj);
     chr->handover_yank_instance = handover_yank_instance;
     chr->label = g_strdup(id);
diff --git a/hw/core/bus.c b/hw/core/bus.c
index b9d89495cd..2de714b274 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -163,7 +163,7 @@ BusState *qbus_new(const char *typename, DeviceState *parent, const char *name)
 {
     BusState *bus;
 
-    bus = BUS(object_new(typename));
+    bus = BUS(object_new_dynamic(typename, &error_abort));
     qbus_init_internal(bus, parent, name);
 
     return bus;
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 09c7903594..8768ae39ed 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -57,7 +57,7 @@ bool cpu_exists(int64_t id)
 CPUState *cpu_create(const char *typename)
 {
     Error *err = NULL;
-    CPUState *cpu = CPU(object_new(typename));
+    CPUState *cpu = CPU(object_new_dynamic(typename, &error_abort));
     if (!qdev_realize(DEVICE(cpu), NULL, &err)) {
         error_report_err(err);
         object_unref(OBJECT(cpu));
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index db36f54d91..a143d8b721 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -162,7 +162,7 @@ DeviceState *qdev_new(const char *name)
         error_report("unknown type '%s'", name);
         abort();
     }
-    return DEVICE(object_new(name));
+    return DEVICE(object_new_dynamic(name, &error_abort));
 }
 
 DeviceState *qdev_try_new(const char *name)
@@ -170,7 +170,7 @@ DeviceState *qdev_try_new(const char *name)
     if (!module_object_class_by_name(name)) {
         return NULL;
     }
-    return DEVICE(object_new(name));
+    return DEVICE(object_new_dynamic(name, &error_abort));
 }
 
 static QTAILQ_HEAD(, DeviceListener) device_listeners
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index b86c38212e..b75443ec26 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -55,7 +55,10 @@ static size_t pvh_start_addr;
 
 static void x86_cpu_new(X86MachineState *x86ms, int64_t apic_id, Error **errp)
 {
-    Object *cpu = object_new(MACHINE(x86ms)->cpu_type);
+    Object *cpu = object_new_dynamic(MACHINE(x86ms)->cpu_type, errp);
+    if (!cpu) {
+        return;
+    }
 
     if (!object_property_set_uint(cpu, "apic-id", apic_id, errp)) {
         goto out;
diff --git a/hw/i386/xen/xen-pvh.c b/hw/i386/xen/xen-pvh.c
index f1f02d3311..9aeb4e430b 100644
--- a/hw/i386/xen/xen-pvh.c
+++ b/hw/i386/xen/xen-pvh.c
@@ -28,7 +28,7 @@ struct XenPVHx86State {
 static DeviceState *xen_pvh_cpu_new(MachineState *ms,
                                     int64_t apic_id)
 {
-    Object *cpu = object_new(ms->cpu_type);
+    Object *cpu = object_new_dynamic(ms->cpu_type, &error_abort);
 
     object_property_add_child(OBJECT(ms), "cpu[*]", cpu);
     object_property_set_uint(cpu, "apic-id", apic_id, &error_fatal);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 36d0cf6585..d57097a194 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1550,7 +1550,11 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
 
 
     if (!vbasedev->mdev) {
-        hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
+        Object *obj = object_new_dynamic(ops->hiod_typename, errp);
+        if (!obj) {
+            return false;
+        }
+        hiod = HOST_IOMMU_DEVICE(obj);
         vbasedev->hiod = hiod;
     }
 
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 9ccdb639ac..5964009a3c 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -419,6 +419,7 @@ static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
 {
     int iommu_type;
     const char *vioc_name;
+    Object *obj;
     VFIOContainer *container;
 
     iommu_type = vfio_get_iommu_type(fd, errp);
@@ -432,7 +433,10 @@ static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
 
     vioc_name = vfio_get_iommu_class_name(iommu_type);
 
-    container = VFIO_IOMMU_LEGACY(object_new(vioc_name));
+    if (!(obj = object_new_dynamic(vioc_name, NULL))) {
+        return NULL;
+    }
+    container = VFIO_IOMMU_LEGACY(obj);
     container->fd = fd;
     container->iommu_type = iommu_type;
     return container;
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index e0833c8bfe..756fca3649 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -102,13 +102,10 @@ Object *user_creatable_add_type(const char *type, const char *id,
         return NULL;
     }
 
-    if (object_class_is_abstract(klass)) {
-        error_setg(errp, "object type '%s' is abstract", type);
+    assert(qdict);
+    if (!(obj = object_new_dynamic(type, errp))) {
         return NULL;
     }
-
-    assert(qdict);
-    obj = object_new(type);
     object_set_properties_from_qdict(obj, qdict, v, &local_err);
     if (local_err) {
         goto out;
diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index e91a235347..b1590231d7 100644
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
+        error_setg(errp, "Object type '%s' is not a device",
+                   typename);
         return NULL;
     }
 
-    obj = object_new(typename);
+    if (!(obj = object_new_dynamic(typename, errp))) {
+        return NULL;
+    }
 
     object_property_iter_init(&iter, obj);
     while ((prop = object_property_iter_next(&iter))) {
@@ -202,7 +203,9 @@ ObjectPropertyInfoList *qmp_qom_list_properties(const char *typename,
     if (object_class_is_abstract(klass)) {
         object_class_property_iter_init(&iter, klass);
     } else {
-        obj = object_new(typename);
+        if (!(obj = object_new_dynamic(typename, errp))) {
+            return NULL;
+        }
         object_property_iter_init(&iter, obj);
     }
     while ((prop = object_property_iter_next(&iter))) {
diff --git a/tests/unit/check-qom-interface.c b/tests/unit/check-qom-interface.c
index c99be97ed8..e4532ae814 100644
--- a/tests/unit/check-qom-interface.c
+++ b/tests/unit/check-qom-interface.c
@@ -13,6 +13,7 @@
 
 #include "qom/object.h"
 #include "qemu/module.h"
+#include "qapi/error.h"
 
 
 #define TYPE_TEST_IF "test-interface"
@@ -67,7 +68,7 @@ static const TypeInfo intermediate_impl_info = {
 
 static void test_interface_impl(const char *type)
 {
-    Object *obj = object_new(type);
+    Object *obj = object_new_dynamic(type, &error_abort);
     TestIf *iobj = TEST_IF(obj);
     TestIfClass *ioc = TEST_IF_GET_CLASS(iobj);
 
diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index f9bccb56ab..f4893d5f24 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -1008,7 +1008,7 @@ static void machine_full_topo_class_init(ObjectClass *oc, void *data)
 static void test_generic_valid(const void *opaque)
 {
     const char *machine_type = opaque;
-    Object *obj = object_new(machine_type);
+    Object *obj = object_new_dynamic(machine_type, &error_abort);
     MachineState *ms = MACHINE(obj);
     MachineClass *mc = MACHINE_GET_CLASS(obj);
     SMPTestData data = {};
@@ -1027,7 +1027,7 @@ static void test_generic_valid(const void *opaque)
 static void test_generic_invalid(const void *opaque)
 {
     const char *machine_type = opaque;
-    Object *obj = object_new(machine_type);
+    Object *obj = object_new_dynamic(machine_type, &error_abort);
     MachineState *ms = MACHINE(obj);
     MachineClass *mc = MACHINE_GET_CLASS(obj);
     SMPTestData data = {};
@@ -1046,7 +1046,7 @@ static void test_generic_invalid(const void *opaque)
 static void test_with_modules(const void *opaque)
 {
     const char *machine_type = opaque;
-    Object *obj = object_new(machine_type);
+    Object *obj = object_new_dynamic(machine_type, &error_abort);
     MachineState *ms = MACHINE(obj);
     MachineClass *mc = MACHINE_GET_CLASS(obj);
     SMPTestData data = {};
@@ -1096,7 +1096,7 @@ static void test_with_modules(const void *opaque)
 static void test_with_dies(const void *opaque)
 {
     const char *machine_type = opaque;
-    Object *obj = object_new(machine_type);
+    Object *obj = object_new_dynamic(machine_type, &error_abort);
     MachineState *ms = MACHINE(obj);
     MachineClass *mc = MACHINE_GET_CLASS(obj);
     SMPTestData data = {};
@@ -1146,7 +1146,7 @@ static void test_with_dies(const void *opaque)
 static void test_with_modules_dies(const void *opaque)
 {
     const char *machine_type = opaque;
-    Object *obj = object_new(machine_type);
+    Object *obj = object_new_dynamic(machine_type, &error_abort);
     MachineState *ms = MACHINE(obj);
     MachineClass *mc = MACHINE_GET_CLASS(obj);
     SMPTestData data = {};
@@ -1207,7 +1207,7 @@ static void test_with_modules_dies(const void *opaque)
 static void test_with_clusters(const void *opaque)
 {
     const char *machine_type = opaque;
-    Object *obj = object_new(machine_type);
+    Object *obj = object_new_dynamic(machine_type, &error_abort);
     MachineState *ms = MACHINE(obj);
     MachineClass *mc = MACHINE_GET_CLASS(obj);
     SMPTestData data = {};
@@ -1257,7 +1257,7 @@ static void test_with_clusters(const void *opaque)
 static void test_with_books(const void *opaque)
 {
     const char *machine_type = opaque;
-    Object *obj = object_new(machine_type);
+    Object *obj = object_new_dynamic(machine_type, &error_abort);
     MachineState *ms = MACHINE(obj);
     MachineClass *mc = MACHINE_GET_CLASS(obj);
     SMPTestData data = {};
@@ -1307,7 +1307,7 @@ static void test_with_books(const void *opaque)
 static void test_with_drawers(const void *opaque)
 {
     const char *machine_type = opaque;
-    Object *obj = object_new(machine_type);
+    Object *obj = object_new_dynamic(machine_type, &error_abort);
     MachineState *ms = MACHINE(obj);
     MachineClass *mc = MACHINE_GET_CLASS(obj);
     SMPTestData data = {};
@@ -1357,7 +1357,7 @@ static void test_with_drawers(const void *opaque)
 static void test_with_drawers_books(const void *opaque)
 {
     const char *machine_type = opaque;
-    Object *obj = object_new(machine_type);
+    Object *obj = object_new_dynamic(machine_type, &error_abort);
     MachineState *ms = MACHINE(obj);
     MachineClass *mc = MACHINE_GET_CLASS(obj);
     SMPTestData data = {};
@@ -1418,7 +1418,7 @@ static void test_with_drawers_books(const void *opaque)
 static void test_full_topo(const void *opaque)
 {
     const char *machine_type = opaque;
-    Object *obj = object_new(machine_type);
+    Object *obj = object_new_dynamic(machine_type, &error_abort);
     MachineState *ms = MACHINE(obj);
     MachineClass *mc = MACHINE_GET_CLASS(obj);
     SMPTestData data = {};
-- 
2.46.0


