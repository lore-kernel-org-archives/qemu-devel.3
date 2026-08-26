Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD96C61DC7
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 09:39:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzA6b-0006R4-Gl; Wed, 26 Aug 2026 05:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wzA6P-0006MZ-BC
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 05:39:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wzA6N-0003Ml-Ae
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 05:39:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787737162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LEgXoqm/fsa1CNBP2BasKFrmY0Glp+eh8Xj7YX9Au+8=;
 b=Apv/gEUqSQO5ijB2/awb2TNDx5MzX9VbQk7Ghepfs+pP6elIWB2DVfLT7uVHXK+C1ykeqr
 7SLi3wSVZ5E/BEPa25zNSgvaHb0KqNBPYivkB6kaD+RD3L16xNH1zQ+TZyDSH85cEJ7yCv
 kmlUGcTCP2x6VddVIHPID9oqx+abLEk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-DOsqQznRNleHd2LcUgX7zA-1; Wed,
 26 Aug 2026 05:39:18 -0400
X-MC-Unique: DOsqQznRNleHd2LcUgX7zA-1
X-Mimecast-MFC-AGG-ID: DOsqQznRNleHd2LcUgX7zA_1787737156
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D042218CC496; Wed, 26 Aug 2026 09:39:16 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.48.93])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A30B71955F05; Wed, 26 Aug 2026 09:39:10 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com,
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org,
 sebott@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
Subject: [RFC PATCH v8 12/20] target/arm/kvm: Introduce
 kvm_arm_expose_idreg_properties
Date: Wed, 26 Aug 2026 11:36:17 +0200
Message-ID: <20260826093747.1670077-13-eric.auger@redhat.com>
In-Reply-To: <20260826093747.1670077-1-eric.auger@redhat.com>
References: <20260826093747.1670077-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This helper decode the ID reg writable mask, matches it against
ID reg fields defined in target/arm/cpu-idregs.h.inc and
for each writable named field, generates a uint64 property.

REVIDR_EL1 and AIDR_EL1 are writable but they do not expose any
field. They will be handled separately.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v7 -> v8
- scratch the '!' in the error_setg
- addapt to the removal of struct ArmIdRegArchVal

v5 -> v6
- for enum values, check against value value when setting the prop
- do not check writable_map flag anymore

v4 -> v5:
- free prop_name
- check cpu->writable_map as a preamble in kvm_arm_expose_idreg_properties
---
 target/arm/kvm_arm.h    |  10 +++
 target/arm/kvm.c        | 143 ++++++++++++++++++++++++++++++++++++++++
 target/arm/trace-events |   4 ++
 3 files changed, 157 insertions(+)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index e7c40fb003..2b3474cc36 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -142,6 +142,16 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu);
  */
 void kvm_arm_add_vcpu_properties(ARMCPU *cpu);
 
+typedef struct ARM64SysReg ARM64SysReg;
+/**
+ * kvm_arm_expose_idreg_properties:
+ * @cpu: The CPU object to generate the properties for
+ * @reg: registers from the host
+ *
+ * analyze the writable mask and generate properties for writable fields
+ */
+void kvm_arm_expose_idreg_properties(ARMCPU *cpu, ARM64SysReg *regs);
+
 /**
  * kvm_arm_steal_time_finalize:
  * @cpu: ARMCPU for which to finalize kvm-steal-time
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 683f9efb88..2557d7b0d9 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -327,6 +327,149 @@ static int get_host_cpu_idregs(int fd, ARMHostCPUFeatures *ahcf)
     return err;
 }
 
+static ARM64SysRegField *get_field(int i, ARM64SysReg *reg)
+{
+    for (int f = 0; f < reg->fields_count; f++) {
+        struct ARM64SysRegField *field = &reg->fields[f];
+        int upper = field->shift + field->length - 1;
+
+        if (i >= field->shift && i <= upper) {
+            return field;
+        }
+    }
+    return NULL;
+}
+
+static void set_sysreg_prop(Object *obj, Visitor *v,
+                            const char *name, void *opaque,
+                            Error **errp)
+{
+    ARM64SysRegField *field = (ARM64SysRegField *)opaque;
+    ARMCPU *cpu = ARM_CPU(obj);
+    uint64_t *idregs = cpu->isar.idregs;
+    uint64_t old, value, mask;
+    int lower = field->shift;
+    int length = field->length;
+    int index = field->index;
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
+    mask = MAKE_64BIT_MASK(lower, length);
+    value = value << lower;
+    old = idregs[index];
+    idregs[index] = old & ~mask;
+    idregs[index] |= value;
+    trace_set_sysreg_prop(name, old, mask, value, idregs[index]);
+}
+
+static void get_sysreg_prop(Object *obj, Visitor *v,
+                            const char *name, void *opaque,
+                            Error **errp)
+{
+    ARM64SysRegField *field = (ARM64SysRegField *)opaque;
+    ARMCPU *cpu = ARM_CPU(obj);
+    uint64_t *idregs = cpu->isar.idregs;
+    uint64_t value, mask;
+    int lower = field->shift;
+    int length = field->length;
+    int index = field->index;
+
+    mask = MAKE_64BIT_MASK(lower, length);
+    value = (idregs[index] & mask) >> lower;
+    visit_type_uint64(v, name, &value, errp);
+    trace_get_sysreg_prop(name, value);
+}
+
+/*
+ * decode_idreg_writemap: Generate props for writable fields
+ *
+ * @obj: CPU object
+ * @reg: description of the sysreg
+ */
+static int
+decode_idreg_writemap(Object *obj, ARM64SysReg *reg)
+{
+    uint64_t map = reg->writable_mask;
+    int i = ctz64(map);
+    int nb_sysreg_props = 0;
+
+    while (map) {
+        ARM64SysRegField *field = get_field(i, reg);
+        int lower, upper;
+        char *prop_name;
+        uint64_t field_mask;
+
+        if (!field) {
+            warn_report("%s bit %d of %s is writable but no named field "
+                        "in target/arm/cpu-idregs.h.inc",
+                        __func__, i, reg->name);
+            map =  map & ~BIT_ULL(i);
+            i = ctz64(map);
+            continue;
+        }
+        lower = field->shift;
+        upper = field->shift + field->length - 1;
+        prop_name = g_strdup_printf("SYSREG_%s_%s", reg->name, field->name);
+        trace_decode_idreg_writemap(field->name, lower, upper, prop_name);
+        object_property_add(obj, prop_name, "uint64",
+                            get_sysreg_prop, set_sysreg_prop, NULL, field);
+        g_free(prop_name);
+        nb_sysreg_props++;
+
+        field_mask = MAKE_64BIT_MASK(lower, field->length);
+        map = map & ~field_mask;
+        i = ctz64(map);
+    }
+    trace_nb_sysreg_props(reg->name, nb_sysreg_props);
+    return 0;
+}
+
+/* analyze the writable mask and generate properties for writable fields */
+void kvm_arm_expose_idreg_properties(ARMCPU *cpu, ARM64SysReg *regs)
+{
+    Object *obj = OBJECT(cpu);
+
+    for (int i = 0; i < NUM_ID_IDX; i++) {
+        ARM64SysReg *sysregdesc = &regs[i];
+
+        if (sysregdesc->writable_mask) {
+            /*
+             * special case REVIDR_EL1 and AIDR_EL1 which are writable but
+             * do not expose named fields. They will need to be handled
+             * separately
+             */
+            if (strcmp(sysregdesc->name, "REVIDR_EL1") &&
+                strcmp(sysregdesc->name, "AIDR_EL1")) {
+                decode_idreg_writemap(obj, sysregdesc);
+            }
+        }
+    }
+}
+
 static void
 kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 {
diff --git a/target/arm/trace-events b/target/arm/trace-events
index c25d2a1191..d72ad6b671 100644
--- a/target/arm/trace-events
+++ b/target/arm/trace-events
@@ -15,6 +15,10 @@ arm_gt_update_irq(int timer, int irqstate) "gt_update_irq: timer %d irqstate %d"
 kvm_arm_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is translated into 0x%"PRIx64
 get_host_cpu_idregs(const char *name, uint64_t value) "scratch vcpu host value for %s is 0x%"PRIx64
 kvm_arm_writable_idregs_to_cpreg_list(const char *name, uint64_t previous, uint64_t new) "%s overwrite default 0x%"PRIx64" with 0x%"PRIx64
+decode_idreg_writemap(const char* name, int lower, int upper, char *prop_name) "%s [%d:%d] is writable (prop %s)"
+get_sysreg_prop(const char *name, uint64_t value) "%s 0x%"PRIx64
+set_sysreg_prop(const char *name, uint64_t old, uint64_t mask, uint64_t field_value, uint64_t new) "%s old reg value=0x%"PRIx64" mask=0x%"PRIx64" new field value=0x%"PRIx64" new reg value=0x%"PRIx64
+nb_sysreg_props(const char *name, int count) "%s: %d SYSREG properties"
 
 # cpu.c
 arm_cpu_reset(uint64_t mp_aff) "cpu %" PRIu64
-- 
2.53.0


