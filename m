Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8B2CA9EC5
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 13:41:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFXIF-0003LM-9m; Sat, 10 Oct 2026 09:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xFXID-0003G6-Ew
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 09:39:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xFXIB-0004fg-SY
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 09:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791639555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dbX7/6NbWU/+92lr0pryibg29b53j8+3gzhn4Kx0DXg=;
 b=L4KpsaluHswsTeP2TZ6n7E4fEocIYMGJ3JuYxyvUrMPanQawUQciPW77uBoJo0w53k77xx
 vVhkFXB7qX9o1vvRKwc7aBD4X9B9g2jEu7Wmk9O4YQ88Uhk3dJWUlCNjQ81MQvlEqln34k
 JFN3cO1e013W9zudKYMN+ybbLiuFFiE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-fYQX9bN1O0qu-vdOe2UkIA-1; Sat,
 10 Oct 2026 13:39:07 +0000
X-MC-Unique: fYQX9bN1O0qu-vdOe2UkIA-1
X-Mimecast-MFC-AGG-ID: fYQX9bN1O0qu-vdOe2UkIA_1791639545
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5CCD195D032; Sat, 10 Oct 2026 13:39:05 +0000 (UTC)
Received: from laptop.redhat.corp (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE70F30000E5; Sat, 10 Oct 2026 13:39:00 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com,
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org,
 sebott@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
Subject: [PATCH v10 18/26] target/arm/cpu64: Introduce
 arm_cpu_apply_sysreg_props
Date: Sat, 10 Oct 2026 15:36:22 +0200
Message-ID: <20261010133725.642498-19-eric.auger@redhat.com>
In-Reply-To: <20261010133725.642498-1-eric.auger@redhat.com>
References: <20261010133725.642498-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This helper walks through all stored SYSREG field values and
apply them on the vcpu. It uses an accelerator specific callback
to apply the field value on the vcpu. If the value is successfully
applied, the cpu->isar.idregs[] value is updated accordingly.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 target/arm/cpu-idregs.h | 18 +++++++++++++
 target/arm/cpu64.c      | 57 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/target/arm/cpu-idregs.h b/target/arm/cpu-idregs.h
index e0399e251b..56c2324359 100644
--- a/target/arm/cpu-idregs.h
+++ b/target/arm/cpu-idregs.h
@@ -38,4 +38,22 @@ typedef struct ARM64SysReg {
  */
 extern ARM64SysReg arm64_id_regs[NUM_ID_IDX];
 
+/* accelerator specific callback used to apply a new field value on a vcpu */
+typedef int (*ARMSysregPropApplyFn)(ARMCPU *cpu, ARM64SysRegField *field,
+                                    uint64_t newfv, Error **errp);
+
+/**
+ * arm_cpu_apply_sysreg_props:
+ *
+ * Apply all SYSREG prop values
+ * @cpu:  vcpu on which the values are applied
+ * @accel_apply_fn: acceleration specific callback used to override
+ *                  a single field value
+ * @errp: error handle
+ *
+ * return 0 on sucess or negative value with errp set on failure
+ */
+int arm_cpu_apply_sysreg_props(ARMCPU *cpu, ARMSysregPropApplyFn accel_apply_fn,
+                               Error **errp);
+
 #endif
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 9662608675..26baee102c 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -803,6 +803,63 @@ static void kvm_arm_set_cpreg_mig_tolerances(ARMCPU *cpu)
 
 #define IDREG_FIELD_KEY(reg_idx, field_shift) \
     (((uint64_t)(reg_idx) << 8) | ((uint64_t)(field_shift) & 0xFF))
+#define IDREG_FIELD_KEY_TO_REG_IDX(key) \
+    ((uint32_t)(((uint64_t)(key)) >> 8))
+#define IDREG_FIELD_KEY_TO_SHIFT(key) \
+    ((uint8_t)(((uint64_t)(key)) & 0xFF))
+
+static ARM64SysRegField *arm_sysreg_get_field(ARM64SysReg *reg, int bit)
+{
+    for (int f = 0; f < reg->fields_count; f++) {
+        ARM64SysRegField *field = &reg->fields[f];
+        int upper = field->shift + field->length - 1;
+
+        if (bit >= field->shift && bit <= upper) {
+            return field;
+        }
+    }
+    return NULL;
+}
+
+/**
+ * arm_cpu_apply_sysreg_props:
+ *
+ * Iterate over all SYSREG_* property overrides, and apply them on the vcpu
+ * using the accelerataor specific @accel_apply_fn callback.
+ */
+int arm_cpu_apply_sysreg_props(ARMCPU *cpu, ARMSysregPropApplyFn accel_apply_fn,
+                               Error **errp)
+{
+    gpointer key_ptr, value_ptr;
+    GHashTableIter iter;
+
+    g_hash_table_iter_init(&iter, cpu->sysreg_props);
+
+    while (g_hash_table_iter_next(&iter, &key_ptr, &value_ptr)) {
+        uint64_t key = (uint64_t)key_ptr;
+        uint64_t newfv = (uint64_t)value_ptr;
+        uint32_t reg_idx = IDREG_FIELD_KEY_TO_REG_IDX(key);
+        uint8_t lower = IDREG_FIELD_KEY_TO_SHIFT(key);
+        ARM64SysReg *reg = &arm64_id_regs[reg_idx];
+        ARM64SysRegField *field = arm_sysreg_get_field(reg, lower);
+        int ret;
+
+        if (!field) {
+            error_setg(errp, "SYSREG property key 0x%" PRIx64
+                       " does not match any field of %s", key, reg->name);
+            return -EINVAL;
+        }
+
+        ret = accel_apply_fn(cpu, field, newfv, errp);
+        if (ret) {
+            return ret;
+        }
+        cpu->isar.idregs[field->index] =
+            deposit64(cpu->isar.idregs[field->index],
+                      field->shift, field->length, newfv);
+    }
+    return 0;
+}
 
 static void set_sysreg_prop(Object *obj, Visitor *v,
                             const char *name, void *opaque,
-- 
2.53.0


