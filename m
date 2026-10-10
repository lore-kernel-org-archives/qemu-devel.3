Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2FFCA9EC5
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 13:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFXIp-0004q1-3r; Sat, 10 Oct 2026 09:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xFXIm-0004oV-QH
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 09:39:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xFXIl-0004nM-5i
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 09:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791639590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EbqisRaIUe/W7PEZdi6C4FJJ74syA8YTjrnLe5iUXKw=;
 b=BjqYJWuuwksSls6LPNdWRHpZKDJGd950xpOTO66wahIdstxtvhkSp98vaP7gX65zBZic6H
 o08Nkf1aCfl1EBo7Nx9f/2beaQBj4r3oZ3N1W7tz58pcVTWPwyFL2fdZEB/FN1ZR2Bn/PS
 Ruz5rdg7+pzhiEQfQPX0dTGxQHwS918=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-YyMV1p93OGu2Gdk2UjROhw-1; Sat,
 10 Oct 2026 13:39:45 +0000
X-MC-Unique: YyMV1p93OGu2Gdk2UjROhw-1
X-Mimecast-MFC-AGG-ID: YyMV1p93OGu2Gdk2UjROhw_1791639584
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D911195DE58; Sat, 10 Oct 2026 13:39:44 +0000 (UTC)
Received: from laptop.redhat.corp (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 462FE30000E5; Sat, 10 Oct 2026 13:39:35 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com,
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org,
 sebott@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
Subject: [PATCH v10 25/26] arm-qmp-cmds: introspection for ID register props
Date: Sat, 10 Oct 2026 15:36:29 +0200
Message-ID: <20261010133725.642498-26-eric.auger@redhat.com>
In-Reply-To: <20261010133725.642498-1-eric.auger@redhat.com>
References: <20261010133725.642498-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

From: Cornelia Huck <cohuck@redhat.com>

Enhance the current host model query-cpu-model-expansion with the
capability to return SYSREG_* options and also test possible
values.

If no SYSREG prop is set, query-cpu-model-expansion returns the
default host values for all SYSREG properties. They are extracted
from a scratch vcpu featuring all the KVM advertised capabilities.

Here is a qmp-shell example:

(QEMU) query-cpu-model-expansion type=full model={"name":"host"}
{"return": {"model": {"name": "host", "props": {"SYSREG_ID_AA64PFR0_EL1_EL3": 1,
"SYSREG_ID_AA64ISAR2_EL1_CLRBHB": 0, "SYSREG_CTR_EL0_L1Ip": 3,
"SYSREG_MIDR_EL1_PartNum": 3407, "SYSREG_CTR_EL0_DminLine": 4,
"SYSREG_ID_AA64MMFR0_EL1_PARange": 5, "SYSREG_ID_AA64MMFR1_EL1_ECBHB": 0
../..

It becomes also possible to test new SYSREG property values.

With Full expansion of the host model, the SYSREG props are tested
against a scratch vcpu. With static expansion, no check is performed
against KVM but only against qemu code (the value does not exceed the
field size and if the field is associated to enum values, the set
value belongs to the list of arch enum values.

Examples
(QEMU) query-cpu-model-expansion type=full model={"name":"host","props":{"SYSREG_ID_AA64ISAR0_EL1_DP":0x13}}
{"error": {"class": "GenericError", "desc": "idreg SYSREG_ID_AA64ISAR0_EL1_DP set value (0x13) exceeds length of field (4)!"}}

(QEMU) query-cpu-model-expansion type=full model={"name":"host","props":{"SYSREG_ID_AA64ISAR0_EL1_DP":0x2}}
{"error": {"class": "GenericError", "desc": "idreg SYSREG_ID_AA64ISAR0_EL1_DP set value (0x2) does not match any arch valid enum value!"}}

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>

---

v9 -> v10:
- use new proto for kvm_arm_create_init_scratch_vcpu, rework error path
  and fix visit_type_uint64 call

v8 -> v9:
- fix the leak reported by Khushit
- implement static mode for host

v7 -> v8:
- do not check if the prop exists (this is checked elsewhere with a
  different error message)
- clarify that examples given in the commit msg are based on qmp-shell

v5 -> v6:
- add the write capability
---
 target/arm/arm-qmp-cmds.c | 130 ++++++++++++++++++++++++++++++++++----
 1 file changed, 118 insertions(+), 12 deletions(-)

diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index 83ec95c290..2765594c68 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -21,6 +21,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu/target-info.h"
 #include "hw/core/boards.h"
 #include "kvm_arm.h"
@@ -30,6 +31,7 @@
 #include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-commands-misc-arm.h"
 #include "qobject/qdict.h"
+#include "qobject/qnum.h"
 #include "qom/qom-qobject.h"
 #include "cpu.h"
 
@@ -83,15 +85,24 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
                                                      CpuModelInfo *model,
                                                      Error **errp)
 {
+    bool use_scratch_vcpu = kvm_enabled() && type == CPU_MODEL_EXPANSION_TYPE_FULL;
     CpuModelExpansionInfo *expansion_info;
+    ObjectPropertyIterator iter;
     const QDict *qdict_in;
+    ObjectProperty *idregprop;
     QDict *qdict_out;
     ObjectClass *oc;
     Object *obj;
+    Visitor *visitor = NULL;
+    Error *err = NULL;
+    bool scratch_created = false;
     const char *name;
+    int fdarray[3];
+    int fd = -1;
     int i;
 
-    if (type != CPU_MODEL_EXPANSION_TYPE_FULL) {
+    /* we support static expansion for host model only */
+    if (type != CPU_MODEL_EXPANSION_TYPE_FULL && strcmp(model->name, "host")) {
         error_setg(errp, "The requested expansion type is not supported");
         return NULL;
     }
@@ -134,9 +145,6 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
     obj = object_new(object_class_get_name(oc));
 
     if (model->props) {
-        Visitor *visitor;
-        Error *err = NULL;
-
         visitor = qobject_input_visitor_new(model->props);
         if (!visit_start_struct(visitor, "model.props", NULL, 0, errp)) {
             visit_free(visitor);
@@ -146,6 +154,8 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
 
         qdict_in = qobject_to(QDict, model->props);
         i = 0;
+
+        /* Test legacy composite option settings */
         while ((name = cpu_model_advertised_features[i++]) != NULL) {
             if (qdict_get(qdict_in, name)) {
                 if (!object_property_set(obj, name, visitor, &err)) {
@@ -154,19 +164,89 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
             }
         }
 
-        if (!err) {
-            visit_check_struct(visitor, &err);
-        }
         if (!err) {
             arm_cpu_finalize_features(ARM_CPU(obj), &err);
         }
+        if (err) {
+            goto bail_out;
+        }
+
+        /**
+         * Test SYSREG option settings
+         * In full mode, build a scratch vcpu that reflects composite legacy
+         * options
+         */
+        if (use_scratch_vcpu) {
+            Error *local_err = NULL;
+            bool has_virt = object_property_get_bool(OBJECT(current_machine),
+                                                     "virtualization",
+                                                     &local_err);
+
+            if (local_err) {
+                error_free(local_err); /* the machine property does not exist */
+            } else {
+                if (!has_virt && object_property_find(obj, "has_el2")) {
+                    object_property_set_bool(obj, "has_el2", false, NULL);
+                }
+            }
+            fd = kvm_arm_create_init_scratch_vcpu(ARM_CPU(obj), fdarray, errp);
+            if (fd < 0) {
+                goto bail_out;
+            }
+            scratch_created = true;
+        }
+
+        qdict_in = qobject_to(QDict, model->props);
+        for (const QDictEntry *entry = qdict_first(qdict_in);
+                 entry != NULL; entry = qdict_next(qdict_in, entry)) {
+            const char *key = qdict_entry_key(entry);
+            QObject *val_obj = qdict_entry_value(entry);
+            ObjectProperty *prop;
+            Visitor *v;
+            uint64_t val;
+
+            if (!g_str_has_prefix(key, "SYSREG_")) {
+                continue;
+            }
+
+            prop = object_property_find(obj, key);
+
+            /* consume the prop to avoid unexpected parameter */
+            if (!visit_type_uint64(visitor, key, &val, errp)) {
+                goto bail_out;
+            }
+
+            v = qobject_input_visitor_new(val_obj);
+
+            if (!object_property_set(obj, key, v, errp)) {
+                visit_free(v);
+                goto bail_out;
+            }
+
+            if (use_scratch_vcpu && prop) {
+                ARM64SysRegField *field = (ARM64SysRegField *)prop->opaque;
+
+                if (!kvm_idreg_write_scratch_vcpu(ARM_CPU(obj), fd,
+                                                  field, val, errp)) {
+                    visit_free(v);
+                    goto bail_out;
+                }
+            }
+            visit_free(v);
+        }
+
+        visit_check_struct(visitor, &err);
+        if (err) {
+            goto bail_out;
+        }
+
+        if (scratch_created) {
+            kvm_arm_destroy_scratch_host_vcpu(fdarray);
+            scratch_created = false;
+        }
         visit_end_struct(visitor, NULL);
         visit_free(visitor);
-        if (err) {
-            object_unref(obj);
-            error_propagate(errp, err);
-            return NULL;
-        }
+        visitor = NULL;
     } else {
         arm_cpu_finalize_features(ARM_CPU(obj), &error_abort);
     }
@@ -190,6 +270,18 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
         }
     }
 
+    object_property_iter_init(&iter, obj);
+
+    while ((idregprop = object_property_iter_next(&iter))) {
+        QObject *value;
+
+        if (!g_str_has_prefix(idregprop->name, "SYSREG_")) {
+            continue;
+        }
+        value = object_property_get_qobject(obj, idregprop->name, &error_abort);
+        qdict_put_obj(qdict_out, idregprop->name, value);
+    }
+
     if (!qdict_size(qdict_out)) {
         qobject_unref(qdict_out);
     } else {
@@ -199,6 +291,20 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
     object_unref(obj);
 
     return expansion_info;
+
+bail_out:
+    if (scratch_created) {
+        kvm_arm_destroy_scratch_host_vcpu(fdarray);
+    }
+    if (visitor) {
+        visit_end_struct(visitor, NULL);
+        visit_free(visitor);
+    }
+    if (err) {
+        error_propagate(errp, err);
+    }
+    object_unref(obj);
+    return NULL;
 }
 
 static void arm_cpu_add_definition(gpointer data, gpointer user_data)
-- 
2.53.0


