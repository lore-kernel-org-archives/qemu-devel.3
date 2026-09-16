Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887C5C982C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 14:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6qxL-0001V7-65; Wed, 16 Sep 2026 10:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x6qxA-00016Z-KF
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 10:49:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x6qx8-0006nR-MZ
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 10:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789570178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nHTQyV3fsb5dGPVizKLS+8CWG7EJNOQy7+/Wy/+0kNs=;
 b=UEVHp4N2r2T+9Yuwkwfn5nm9U0roupGiBSFNS1FzPmLzdgXFtxXnHVEqxCPk3vxfOSqVgy
 nWkcLgn0facOK1qeGy2NnXedgmgfisqh2DCTydWUl62U4nCCJsFVcFEZL9JYctMr7CN8OP
 Rr7GqQj6J3KBgQEtE89Rg129NsdIz6o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-yGtr9CB3M_GUjxiL2SnAzQ-1; Wed,
 16 Sep 2026 10:49:34 -0400
X-MC-Unique: yGtr9CB3M_GUjxiL2SnAzQ-1
X-Mimecast-MFC-AGG-ID: yGtr9CB3M_GUjxiL2SnAzQ_1789570172
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0F9E1829E28; Wed, 16 Sep 2026 14:49:32 +0000 (UTC)
Received: from laptop.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F35C219560AB; Wed, 16 Sep 2026 14:49:27 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com,
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org,
 sebott@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
Subject: [PATCH v9 23/26] target/arm/kvm: Introduce
 kvm_arm_vcpu_prepare_init_features helper
Date: Wed, 16 Sep 2026 16:45:46 +0200
Message-ID: <20260916144721.751810-24-eric.auger@redhat.com>
In-Reply-To: <20260916144721.751810-1-eric.auger@redhat.com>
References: <20260916144721.751810-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Factorize the code that initializes the kvm init features from the
cpu settings in a helper. Use it kvm_arch_init_vcpu(). Soon it will
be used by another function.

The only change in the code relates to the check of kvm_state. The
future caller won't have the VM created when calling the helper and
for this caller it is OK ignoring PSCI version setting.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 target/arm/kvm.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 43fb61bef4..a459942a73 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2448,27 +2448,18 @@ static int kvm_arm_apply_sysreg_props(ARMCPU *cpu, Error **errp)
     return 0;
 }
 
-int kvm_arch_init_vcpu(CPUState *cs, Error **errp)
+/* Determine init features for this CPU */
+static void kvm_arm_vcpu_prepare_init_features(ARMCPU *cpu)
 {
-    int ret;
-    uint64_t mpidr;
-    ARMCPU *cpu = ARM_CPU(cs);
+    CPUState *cs = CPU(cpu);
     CPUARMState *env = &cpu->env;
-    uint64_t psciver;
 
-    if (cpu->kvm_target == QEMU_KVM_ARM_TARGET_NONE) {
-        error_setg(errp, "KVM is not supported for this guest CPU type");
-        return -EINVAL;
-    }
-
-    qemu_add_vm_change_state_handler(kvm_arm_vm_state_change, cpu);
-
-    /* Determine init features for this CPU */
     memset(cpu->kvm_init_features, 0, sizeof(cpu->kvm_init_features));
+
     if (cs->start_powered_off) {
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_POWER_OFF;
     }
-    if (cpu->psci_version != QEMU_PSCI_VERSION_0_1 &&
+    if (cpu->psci_version != QEMU_PSCI_VERSION_0_1 && cs->kvm_state &&
         kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PSCI_0_2)) {
         /*
          * Versions >= v0.2 are backward compatible with v0.2
@@ -2492,6 +2483,23 @@ int kvm_arch_init_vcpu(CPUState *cs, Error **errp)
     if (cpu->has_el2 && kvm_arm_el2_supported()) {
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_HAS_EL2;
     }
+}
+
+int kvm_arch_init_vcpu(CPUState *cs, Error **errp)
+{
+    int ret;
+    uint64_t mpidr;
+    ARMCPU *cpu = ARM_CPU(cs);
+    uint64_t psciver;
+
+    if (cpu->kvm_target == QEMU_KVM_ARM_TARGET_NONE) {
+        error_setg(errp, "KVM is not supported for this guest CPU type");
+        return -EINVAL;
+    }
+
+    qemu_add_vm_change_state_handler(kvm_arm_vm_state_change, cpu);
+
+    kvm_arm_vcpu_prepare_init_features(cpu);
 
     /* Do KVM_ARM_VCPU_INIT ioctl */
     ret = kvm_arm_vcpu_init(cpu);
-- 
2.53.0


