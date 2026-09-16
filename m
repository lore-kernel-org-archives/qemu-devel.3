Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474EAC982C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 14:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6qwk-0007Xk-CB; Wed, 16 Sep 2026 10:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x6qwc-0007RS-Gl
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 10:49:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x6qwa-0006co-Ps
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 10:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789570144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EiBclqfnHyEK7XPO+qxnPMI8the5N2406mXliaMHR/I=;
 b=ZNActeQsSb+yX7vpQ/Qn8vgFJ9SE28MQUGibTgaBk3fu8db+zcTif9WLMxwtdItwTS1R7f
 z1aEwkioatLHqasUBz/tAkQKeOPhIJMwShC9GEBOb0/rw/sLgHZno8tbOu13Cnr6CI35T5
 ARcnYKc3O7F3TPVITEMP52GV3aqBuXw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-uHjc4MGCNpW2kIzBVsog1g-1; Wed,
 16 Sep 2026 10:49:02 -0400
X-MC-Unique: uHjc4MGCNpW2kIzBVsog1g-1
X-Mimecast-MFC-AGG-ID: uHjc4MGCNpW2kIzBVsog1g_1789570141
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E843818009D8; Wed, 16 Sep 2026 14:49:00 +0000 (UTC)
Received: from laptop.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 215941956053; Wed, 16 Sep 2026 14:48:55 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com,
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org,
 sebott@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
Subject: [PATCH v9 17/26] target/arm/kvm: Add consistency checking for SYSREG
 props
Date: Wed, 16 Sep 2026 16:45:40 +0200
Message-ID: <20260916144721.751810-18-eric.auger@redhat.com>
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

Since legacy composite options (such as SVE, virtualization, ...)
and new SYSREG props coexist, add some basic consistency checks.

Those checks are performed both in kvm_arch_init_vcpu() before
applying the SYSREG props at the end of the initialization chain.

Some ID reg fields corresponding to legacy composite option scope
are not writable. In that case we just check that the field has
not become writable.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 target/arm/kvm.c | 105 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index ddf320d0e6..f52c03745e 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -340,6 +340,107 @@ static ARM64SysRegField *get_field(int i, ARM64SysReg *reg)
     return NULL;
 }
 
+
+/**
+ * kvm_arm_vcpu_validate_sysreg:
+ *
+ * Validate a SYSREG field value is consistent with legacy composite options
+ * Some checks are not implemented because the corresponding sysreg field
+ * is not currently writable. In that case we make sure the field has not
+ * become writable, which would mean the user had the capability to set the
+ * corresponding property.
+ *
+ * return true if consistent. false if it is not, along with an error handle
+ */
+static bool kvm_arm_vcpu_validate_sysreg(ARMCPU *cpu, ARM64SysRegField *field,
+                                         uint64_t value, Error **errp)
+{
+    const char *fieldname = field->name;
+    ARM64SysReg *sysregdesc = &arm64_id_regs[field->index];
+    const char *regname = sysregdesc->name;
+    g_autofree char *propname = g_strdup_printf("SYSREG_%s_%s", regname, fieldname);
+
+    /* virtualization */
+    if (!strcmp(propname, "SYSREG_ID_AA64PFR0_EL1_EL2")) {
+        /* consistency with machine virtualization property */
+        if (cpu->has_el2 && value == 0) {
+            error_setg(errp,
+                "Inconsistent -machine virtualization=on and "
+                "%s=0", propname);
+            return false;
+        } else if (!cpu->has_el2 && value > 0) {
+            error_setg(errp,
+                "Inconsistent -machine virtualization=off and "
+                "%s > 0", propname);
+            return false;
+        }
+    /* secure */
+    } else if (!strcmp(propname, "SYSREG_ID_AA64PFR0_EL1_EL3") && value > 0) {
+        /* consistency with machine secure property */
+        error_setg(errp, "%s is set but qemu is not ready to support it",
+                   propname);
+        return false;
+    /* MTE */
+    } else if (!strcmp(propname, "SYSREG_ID_AA64PFR1_EL1_MTE")) {
+        error_setg(errp, "%s is now exposed but qemu is not ready to support it",
+                   propname);
+        return false;
+    /* SVE */
+    } else if (!strcmp(propname, "SYSREG_ID_AA64PFR0_EL1_SVE")) {
+        error_setg(errp, "%s is now exposed but qemu is not ready to support it",
+                   propname);
+        return false;
+    } else if (!strcmp(propname, "SYSREG_ID_AA64ZFR0_EL1_SVEver")) {
+        if (cpu_isar_feature(aa64_sve, cpu) && value == 0) {
+            error_setg(errp, "sve is set but %s is set to 0", propname);
+            return false;
+        } else if (!cpu_isar_feature(aa64_sve, cpu) && value > 0) {
+            error_setg(errp, "sve is not set but %s is greater than 0",
+                       propname);
+            return false;
+        }
+    /* PAUTH */
+    } else if (!strcmp(propname, "SYSREG_ID_AA64ISAR1_EL1_APA")) {
+        /* PAUTH QARMA5 address authentification */
+        error_setg(errp, "%s is now exposed but qemu is not ready to support it",
+                   propname);
+        return false;
+    } else if (!strcmp(propname, "SYSREG_ID_AA64ISAR1_EL1_API")) {
+        /* PAUTH Impl Defined address authentification */
+        error_setg(errp, "%s is now exposed but qemu is not ready to support it",
+                   propname);
+        return false;
+    } else if (!strcmp(propname, "SYSREG_ID_AA64ISAR1_EL1_GPA")) {
+        /* QARMA5 generic code authentification */
+        error_setg(errp, "%s is now exposed but qemu is not ready to support it",
+                   propname);
+        return false;
+    } else if (!strcmp(propname, "SYSREG_ID_AA64ISAR1_EL1_GPI")) {
+        /* QARMA5 generic code authentification */
+        error_setg(errp, "%s is now exposed but qemu is not ready to support it",
+                   propname);
+        return false;
+    /* PMU */
+    } else if (!strcmp(propname, "SYSREG_ID_AA64DFR0_EL1_PMUVer")) {
+        if (cpu->has_pmu && value == 0) {
+            error_setg(errp, "%s is 0 whereas pmu is set", propname);
+            return false;
+        } else if (!cpu->has_pmu && value) {
+            error_setg(errp, "%s is non null whereas pmu is unset", propname);
+            return false;
+        }
+    /* aarch64 false */
+    } else if (!arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
+        if ((!strcmp(propname, "SYSREG_ID_AA64PFR0_EL1_EL0") ||
+             !strcmp(propname, "SYSREG_ID_AA64PFR0_EL1_EL1") ||
+             !strcmp(propname, "SYSREG_ID_AA64PFR0_EL1_EL2")) && value < 2)
+            error_setg(errp, "%s is < 2 while aarch64 is set to off",
+                       propname);
+            return false;
+    }
+    return true;
+}
+
 #define MAKE_IDREG_KEY(reg_idx, field_shift) \
     (((uint64_t)(reg_idx) << 8) | ((uint64_t)(field_shift) & 0xFF))
 
@@ -2241,6 +2342,10 @@ static int kvm_arm_apply_sysreg_props(ARMCPU *cpu, Error **errp)
         uint64_t oldfv;
         int ret;
 
+        if (!kvm_arm_vcpu_validate_sysreg(cpu, field, value, errp)) {
+            return -1;
+        }
+
         mask = MAKE_64BIT_MASK(lower, length);
         value = value << lower;
 
-- 
2.53.0


