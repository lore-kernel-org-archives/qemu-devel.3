Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBC3CA9EBE
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 13:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFXIY-0004EM-Tj; Sat, 10 Oct 2026 09:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xFXIR-0003zo-TR
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 09:39:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xFXIO-0004hw-2A
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 09:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791639565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v43ocM3DpQoBMOmnWjOUY1Uk4kwBrzKU6IVEiEb5hkU=;
 b=Y0Fdprf1pUXjEiZSS4EIPOLyxOgwfdU+VuZYTJMlEuAWiJBWaytp3da7Zo360V+SQBYa4K
 LQP1dX3a5t+obGvr5zqKZ8h2Rdz1IqMa+oazbe3Z4dsrROL6iHGYgiXh2Wq3NXYvCH1DWO
 6roD1heBfEf/TGKE3Xf6++dJnMa7KrI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-BPK8EFKOOj6vqxxTk1BCAQ-1; Sat,
 10 Oct 2026 13:39:22 +0000
X-MC-Unique: BPK8EFKOOj6vqxxTk1BCAQ-1
X-Mimecast-MFC-AGG-ID: BPK8EFKOOj6vqxxTk1BCAQ_1791639560
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C8F31944B01; Sat, 10 Oct 2026 13:39:20 +0000 (UTC)
Received: from laptop.redhat.corp (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AB66D30000E5; Sat, 10 Oct 2026 13:39:15 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com,
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org,
 sebott@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
Subject: [PATCH v10 21/26] target/arm/cpu64: Add helper to test SYSREG props
 against a scratch vcpu
Date: Sat, 10 Oct 2026 15:36:25 +0200
Message-ID: <20261010133725.642498-22-eric.auger@redhat.com>
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

Add kvm_idreg_write_scratch_vcpu helper that will be used
by qmp_query_cpu_model_expansion code to test SYSREG settings
against a scratch vcpu. Indeed when the expansion code is called
the actual vcpu has not been initialized so we use a scratch vcpu.
This latter has been initialized with features taken from
legacy compositive options (EL2, SVE, ...). So the trial is
very close to the final setup.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 target/arm/kvm_arm.h    |  4 ++++
 target/arm/kvm-stub.c   |  7 +++++++
 target/arm/kvm.c        | 21 +++++++++++++++++++++
 target/arm/trace-events |  1 +
 4 files changed, 33 insertions(+)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index e7c40fb003..25a1dec095 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -14,6 +14,7 @@
 #include "qapi/qapi-types-misc-arm.h"
 #include "system/kvm.h"
 #include "target/arm/cpu-qom.h"
+#include "cpu-idregs.h"
 
 #define KVM_ARM_VGIC_V2   (1 << 0)
 #define KVM_ARM_VGIC_V3   (1 << 1)
@@ -240,4 +241,7 @@ void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3);
  */
 char *kvm_print_register_name(uint64_t regidx);
 
+bool kvm_idreg_write_scratch_vcpu(ARMCPU *cpu, int cpufd,
+                                  ARM64SysRegField *field, uint64_t newfv,
+                                  Error **errp);
 #endif
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 88cbe8d85c..8e6fae0a4d 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -119,3 +119,10 @@ char *kvm_print_register_name(uint64_t regidx)
 {
     g_assert_not_reached();
 }
+
+bool kvm_idreg_write_scratch_vcpu(ARMCPU *cpu, int cpufd,
+                                  ARM64SysRegField *field, uint64_t newfv,
+                                  Error **errp)
+{
+    g_assert_not_reached();
+}
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 0c7e80aea8..82ffcac7e3 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1297,6 +1297,27 @@ static int kvm_arm_apply_one_sysreg_prop(ARMCPU *cpu, ARM64SysRegField *field,
     return kvm_arm_override_idreg_field(CPU(cpu)->kvm_fd, field, newfv, errp);
 }
 
+bool kvm_idreg_write_scratch_vcpu(ARMCPU *cpu, int cpufd,
+                                  ARM64SysRegField *field, uint64_t newfv,
+                                  Error **errp)
+{
+    int ret;
+
+    if (!arm_cpu_validate_sysreg_prop(cpu, field, newfv, errp)) {
+        return false;
+    }
+
+    ret = kvm_arm_override_idreg_field(cpufd, field, newfv, errp);
+    if (ret) {
+        return false;
+    }
+
+    cpu->isar.idregs[field->index] =
+        deposit64(cpu->isar.idregs[field->index],
+                  field->shift, field->length, newfv);
+    return true;
+}
+
 static int kvm_arm_apply_sysreg_props(ARMCPU *cpu, Error **errp)
 {
     return arm_cpu_apply_sysreg_props(cpu, kvm_arm_apply_one_sysreg_prop, errp);
diff --git a/target/arm/trace-events b/target/arm/trace-events
index 81564f1d96..a731b5d4ba 100644
--- a/target/arm/trace-events
+++ b/target/arm/trace-events
@@ -15,6 +15,7 @@ arm_gt_update_irq(int timer, int irqstate) "gt_update_irq: timer %d irqstate %d"
 kvm_arm_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is translated into 0x%"PRIx64
 get_host_cpu_idregs(const char *name, uint64_t value) "scratch vcpu host value for %s is 0x%"PRIx64
 kvm_arm_override_idreg_field(const char *reg_name, const char *field_name, uint64_t currentfv, uint64_t newfv) "%s.%s current=0x%"PRIx64" new=0x%"PRIx64
+kvm_arm_idreg_write_scratch_vcpu(const char *name, uint64_t oldfv, uint64_t newfv, uint64_t actualfv) "successful dry-run for %s old=0x%"PRIx64" new=0x%"PRIx64" actual=0x%"PRIx64
 
 # cpu.c
 arm_cpu_reset(uint64_t mp_aff) "cpu %" PRIu64
-- 
2.53.0


