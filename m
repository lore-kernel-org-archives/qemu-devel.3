Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6DAC982C3
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 14:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6qwX-0007Lx-GH; Wed, 16 Sep 2026 10:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x6qwR-0007JU-3U
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 10:48:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x6qwP-0006Z5-8o
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 10:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789570132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jM95nmouJtf6ZLy1kR42fC99c9Xk1R+7+8fMZCtX3ao=;
 b=ZqJEn/molqkU4CZxqfp3cN9C5rkZp2lMuQPYjRY3LAUbZIQpPhlGNkhmEWZHaCmDyz2V9i
 NBI2VpDMODRRbt6ROlHkmpAATrO7slY0oWXiK8boDI6yU5Bldf0XvNI3tLzl5B7Vvy87iu
 5ilIk7zbkR6+R/aU64BPRokjGjEAnnk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-jxgTD__OMdq3_2lnAW-DOg-1; Wed,
 16 Sep 2026 10:48:48 -0400
X-MC-Unique: jxgTD__OMdq3_2lnAW-DOg-1
X-Mimecast-MFC-AGG-ID: jxgTD__OMdq3_2lnAW-DOg_1789570125
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BACC3180217F; Wed, 16 Sep 2026 14:48:45 +0000 (UTC)
Received: from laptop.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A52AD19560AB; Wed, 16 Sep 2026 14:48:40 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com,
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org,
 sebott@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
Subject: [PATCH v9 14/26] target/arm/kvm: Implement SYSREG property setter and
 getter
Date: Wed, 16 Sep 2026 16:45:37 +0200
Message-ID: <20260916144721.751810-15-eric.auger@redhat.com>
In-Reply-To: <20260916144721.751810-1-eric.auger@redhat.com>
References: <20260916144721.751810-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When the setter is called, the final vcpu is not created yet.
Applying the override on vcpu.isar initialized with the max scratch
vcpu would not be correct because the final vcpu may have some features
turned off (for instance virtualization) while the scratch vcpu
features it. So we need to postpone the actual override until the
final vcpu has been initialized.

In terms of input value validation what can be done now is checking
against field length and arch enum value if any.

If this succeeds, the field value is added in the hash table to be
written later on once the final vcpu has been created

With regards to the getter, if the sysreg prop was set, we return the
set value, otherwise, we return the value in cpu->isar.idregs[].

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 target/arm/cpu.h |  2 ++
 target/arm/cpu.c |  5 ++--
 target/arm/kvm.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e3f931dba2..9bbd42dd2b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -952,6 +952,8 @@ struct ArchCPU {
     uint64_t *cpreg_vmstate_values;
     int32_t cpreg_vmstate_array_len;
 
+    GHashTable *sysreg_props;
+
     DynamicGDBFeatureInfo dyn_sysreg_feature;
     DynamicGDBFeatureInfo dyn_svereg_feature;
     DynamicGDBFeatureInfo dyn_smereg_feature;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 77aa78f00e..917f709cb4 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1236,8 +1236,8 @@ static void arm_cpu_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
 
-    cpu->cp_regs = g_hash_table_new_full(g_direct_hash, g_direct_equal,
-                                         NULL, g_free);
+    cpu->cp_regs = g_hash_table_new(g_direct_hash, g_direct_equal);
+    cpu->sysreg_props = g_hash_table_new(g_direct_hash, g_direct_equal);
 
     QLIST_INIT(&cpu->pre_el_change_hooks);
     QLIST_INIT(&cpu->el_change_hooks);
@@ -1725,6 +1725,7 @@ static void arm_cpu_finalizefn(Object *obj)
     ARMCPRegMigTolerance *t, *n;
 
     g_hash_table_destroy(cpu->cp_regs);
+    g_hash_table_destroy(cpu->sysreg_props);
 
     QLIST_FOREACH_SAFE(hook, &cpu->pre_el_change_hooks, node, next) {
         QLIST_REMOVE(hook, node);
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 341542279d..cdc3779321 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -340,18 +340,79 @@ static ARM64SysRegField *get_field(int i, ARM64SysReg *reg)
     return NULL;
 }
 
+#define MAKE_IDREG_KEY(reg_idx, field_shift) \
+    (((uint64_t)(reg_idx) << 8) | ((uint64_t)(field_shift) & 0xFF))
+
 static void set_sysreg_prop(Object *obj, Visitor *v,
                             const char *name, void *opaque,
                             Error **errp)
 {
-    error_setg(errp, "%s setter not yet implemented", name);
+    ARM64SysRegField *field = (ARM64SysRegField *)opaque;
+    ARMCPU *cpu = ARM_CPU(obj);
+    int index = field->index;
+    int lower = field->shift;
+    int length = field->length;
+    uint64_t key, value;
+
+    if (!visit_type_uint64(v, name, &value, errp)) {
+        return;
+    }
+
+    if (length < 64 && value > ((1 << length) - 1)) {
+        error_setg(errp,
+                   "idreg %s set value (0x%lx) exceeds length of field (%d)!",
+                   name, value, length);
+        return;
+    }
+
+    if (field->arch_vals) {
+        /* this field has some enum values */
+        for (int i = 0; i < field->arch_vals_count; i++) {
+            if (value == field->arch_vals[i]) {
+                goto valid;
+            }
+        }
+        error_setg(errp,
+                   "idreg %s set value (0x%lx) does not match any "
+                   "arch valid enum value", name, value);
+        return;
+    }
+
+valid:
+
+    key = MAKE_IDREG_KEY(index, lower);
+    g_hash_table_insert(cpu->sysreg_props, GUINT_TO_POINTER(key),
+                       GUINT_TO_POINTER(value));
 }
 
 static void get_sysreg_prop(Object *obj, Visitor *v,
                             const char *name, void *opaque,
                             Error **errp)
 {
-    error_setg(errp, "%s getter not yet implemented", name);
+    ARM64SysRegField *field = (ARM64SysRegField *)opaque;
+    ARMCPU *cpu = ARM_CPU(obj);
+    int index = field->index;
+    int lower = field->shift;
+    int length = field->length;
+    gpointer value_ptr;
+    uint64_t value;
+    uint64_t key = MAKE_IDREG_KEY(index, lower);
+    gboolean exists;
+
+    exists = g_hash_table_lookup_extended(cpu->sysreg_props,
+                                          GUINT_TO_POINTER(key), NULL,
+                                          &value_ptr);
+    if (exists) {
+        value = GPOINTER_TO_UINT(value_ptr);
+    } else {
+        uint64_t mask = MAKE_64BIT_MASK(lower, length);
+        uint64_t *idregs = cpu->isar.idregs;
+
+        value = (idregs[index] & mask) >> lower;
+    }
+
+    visit_type_uint64(v, name, &value, errp);
+    trace_get_sysreg_prop(name, value);
 }
 
 /*
-- 
2.53.0


