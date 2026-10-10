Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6673CA9EC5
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 13:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFXIM-0003hz-2x; Sat, 10 Oct 2026 09:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xFXIK-0003gk-Ic
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 09:39:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xFXII-0004gP-Al
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 09:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791639560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1P6OGS90P5wwSpHO8d6e35D+/9E59SZZDqpt+CKzk0c=;
 b=bmkpThEezqoEBx6guZ9OQ3YKUyNwxkLoiYbWdIDTdDxFA3U7+fzk14MpUTsslqIKLuPSSm
 eOO9PHCV6p2yv81KSikB9759mRmjC423a9GZcRawInjvc8/OP91YKsfL35NhQJIJ4ETFf0
 pFAdwFplMjyige8CexMckjeHkkbXd3E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-aSmS0IB0ObCGGaOYOF72ig-1; Sat,
 10 Oct 2026 13:39:17 +0000
X-MC-Unique: aSmS0IB0ObCGGaOYOF72ig-1
X-Mimecast-MFC-AGG-ID: aSmS0IB0ObCGGaOYOF72ig_1791639555
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5244A195418F; Sat, 10 Oct 2026 13:39:15 +0000 (UTC)
Received: from laptop.redhat.corp (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E258930000E5; Sat, 10 Oct 2026 13:39:10 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com,
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org,
 sebott@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
Subject: [PATCH v10 20/26] target/arm/kvm: Add consistency checking for SYSREG
 props
Date: Sat, 10 Oct 2026 15:36:24 +0200
Message-ID: <20261010133725.642498-21-eric.auger@redhat.com>
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

Since legacy composite options (such as SVE, virtualization, ...)
and new SYSREG props coexist, add some basic consistency checks.

Those checks are performed in kvm_arch_init_vcpu() before
applying the SYSREG props at the end of the initialization chain.

Some ID reg fields corresponding to legacy composite option scope
are not (yet) writable (EL3, MTE, SVE, ...). As such they are not
supposed to be exposed through SYSREG properties. However in the
hypothesis they would become writable, and thus would be exposed
and attempted to be set, we need to reject any setting because no
consistency check is implemented yet.

The function is exported because it will be used on the qmp
expansion path too.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v9 -> v10
- improve commit description
- fix return in !arm_feature(&cpu->env, ARM_FEATURE_AARCH64) block
- removed cpu_isar_feature(aa64_sve, cpu) && value == 0 check
---
 target/arm/cpu-idregs.h | 17 ++++++++
 target/arm/cpu64.c      | 94 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+)

diff --git a/target/arm/cpu-idregs.h b/target/arm/cpu-idregs.h
index 56c2324359..465ec83c97 100644
--- a/target/arm/cpu-idregs.h
+++ b/target/arm/cpu-idregs.h
@@ -56,4 +56,21 @@ typedef int (*ARMSysregPropApplyFn)(ARMCPU *cpu, ARM64SysRegField *field,
 int arm_cpu_apply_sysreg_props(ARMCPU *cpu, ARMSysregPropApplyFn accel_apply_fn,
                                Error **errp);
 
+/**
+ * arm_cpu_validate_sysreg_prop:
+ *
+ * accelerator agnostic validation of a field value (especially regarding
+ * the consistency with legacy composite options such as virtualization, pmu,
+ * sve ...)
+ *
+ * @cpu: vcpu the field value is validated against
+ * @field: field the value is applied to
+ * @value: field value to be validated
+ * @errp: error handle set if validation fails
+ *
+ * returns true if validation succeeds
+ */
+bool arm_cpu_validate_sysreg_prop(ARMCPU *cpu, ARM64SysRegField *field,
+                                  uint64_t value, Error **errp);
+
 #endif
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index ff178bcaf5..b7c0a27b16 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -821,6 +821,63 @@ static ARM64SysRegField *arm_sysreg_get_field(ARM64SysReg *reg, int bit)
     return NULL;
 }
 
+/**
+ * arm_cpu_validate_sysreg_prop:
+ *
+ * Validate a SYSREG field value against legacy composite options
+ * (virtualization, pmu, sve, aarch64, ...). Some other fields are known
+ * to conflict but they are not writable yet. For those we just skip them
+ * in aarch64_add_one_idreg_properties() in the hypothesis their property
+ * shows up.
+ */
+bool arm_cpu_validate_sysreg_prop(ARMCPU *cpu, ARM64SysRegField *field,
+                                  uint64_t value, Error **errp)
+{
+    ARM64SysReg *sysregdesc = &arm64_id_regs[field->index];
+    g_autofree char *propname =
+        g_strdup_printf("SYSREG_%s_%s", sysregdesc->name, field->name);
+
+    /* virtualization */
+    if (!strcmp(propname, "SYSREG_ID_AA64PFR0_EL1_EL2")) {
+        if (cpu->has_el2 && value == 0) {
+            error_setg(errp,
+                       "Inconsistent -machine virtualization=on and %s=0",
+                       propname);
+            return false;
+        } else if (!cpu->has_el2 && value > 0) {
+            error_setg(errp,
+                       "Inconsistent -machine virtualization=off and %s > 0",
+                       propname);
+            return false;
+        }
+    } else if (!strcmp(propname, "SYSREG_ID_AA64ZFR0_EL1_SVEver")) {
+        if (!cpu_isar_feature(aa64_sve, cpu) && value > 0) {
+            error_setg(errp, "sve is not set but %s is greater than 0",
+                       propname);
+            return false;
+        }
+    /* PMU */
+    } else if (!strcmp(propname, "SYSREG_ID_AA64DFR0_EL1_PMUVer")) {
+        if (cpu->has_pmu && value == 0) {
+            error_setg(errp, "%s is 0 whereas pmu is set", propname);
+            return false;
+        } else if (!cpu->has_pmu && value) {
+            error_setg(errp, "%s is non null whereas pmu is unset", propname);
+            return false;
+        }
+    /* aarch64=off */
+    } else if (!arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
+        if ((!strcmp(propname, "SYSREG_ID_AA64PFR0_EL1_EL0") ||
+             !strcmp(propname, "SYSREG_ID_AA64PFR0_EL1_EL1") ||
+             !strcmp(propname, "SYSREG_ID_AA64PFR0_EL1_EL2")) && value < 2) {
+            error_setg(errp, "%s is < 2 while aarch64 is set to off",
+                       propname);
+            return false;
+        }
+    }
+    return true;
+}
+
 /**
  * arm_cpu_apply_sysreg_props:
  *
@@ -850,6 +907,10 @@ int arm_cpu_apply_sysreg_props(ARMCPU *cpu, ARMSysregPropApplyFn accel_apply_fn,
             return -EINVAL;
         }
 
+        if (!arm_cpu_validate_sysreg_prop(cpu, field, newfv, errp)) {
+            return -EINVAL;
+        }
+
         ret = accel_apply_fn(cpu, field, newfv, errp);
         if (ret) {
             return ret;
@@ -934,6 +995,35 @@ static void get_sysreg_prop(Object *obj, Visitor *v,
     trace_get_sysreg_prop(name, value);
 }
 
+/*
+ * SYSREG properties that are not exposed yet because the fields
+ * are not yet writable and which are known to conflict with legacy
+ * composite options (EL3, MTE, SVE, pauth, ...). In case the
+ * associated fields would become exposed, we skip them when registering
+ * the properties.
+ */
+static const char * const aarch64_sysreg_prop_skip_list[] = {
+    "SYSREG_ID_AA64PFR0_EL1_EL3",
+    "SYSREG_ID_AA64PFR1_EL1_MTE",
+    "SYSREG_ID_AA64PFR0_EL1_SVE",
+    "SYSREG_ID_AA64ISAR1_EL1_APA",
+    "SYSREG_ID_AA64ISAR1_EL1_API",
+    "SYSREG_ID_AA64ISAR1_EL1_GPA",
+    "SYSREG_ID_AA64ISAR1_EL1_GPI",
+    "SYSREG_ID_AA64ISAR2_EL1_APA3",
+    "SYSREG_ID_AA64ISAR2_EL1_GPA3",
+};
+
+static bool aarch64_sysreg_prop_skipped(const char *prop_name)
+{
+    for (int i = 0; i < ARRAY_SIZE(aarch64_sysreg_prop_skip_list); i++) {
+        if (g_str_equal(prop_name, aarch64_sysreg_prop_skip_list[i])) {
+            return true;
+        }
+    }
+    return false;
+}
+
 /**
  * aarch64_add_idreg_properties: Add SYSREG_<REG>_<FIELD> properties
  * for named fields of an ID register
@@ -985,6 +1075,10 @@ aarch64_add_one_idreg_properties(Object *obj, ARM64SysReg *reg,
         }
 
         prop_name = g_strdup_printf("SYSREG_%s_%s", reg->name, field->name);
+        if (aarch64_sysreg_prop_skipped(prop_name)) {
+            g_free(prop_name);
+            continue;
+        }
         object_property_add(obj, prop_name, "uint64",
                             get_sysreg_prop, set_sysreg_prop, NULL, field);
         trace_add_idreg_property(prop_name, lower, upper, field_writable_mask);
-- 
2.53.0


