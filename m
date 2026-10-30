Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666F3606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UKDnxQfl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMmRw-00014i-T3; Fri, 30 Oct 2026 09:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xMmRq-0000sX-Cc
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:15:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xMmRo-0005Oy-Oq
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793366108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SDRnyZJOF/BglrkgN/ZDKrqt82uGjI3c0tID3Y2DFrA=;
 b=UKDnxQflv53aRuC7lWZwnYumiuo/Oryu7CMUbnupjo516lio3DbJLmRApOrIfwLvU3XCyf
 sazmrWHJgacRUTbbE30Eh44i0NJy3LCCjlRWYBc2A07EvpAAGRWWyHBUavtQA6aXGMbczs
 GhRbpzYdse/Goz3Q5TLCx2FakZIv0j8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-GXb15PtPN0KOcpe3E-1MMg-1; Fri,
 30 Oct 2026 09:14:55 -0400
X-MC-Unique: GXb15PtPN0KOcpe3E-1MMg-1
X-Mimecast-MFC-AGG-ID: GXb15PtPN0KOcpe3E-1MMg_1793366093
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 13E7318009C0; Fri, 30 Oct 2026 13:14:53 +0000 (UTC)
Received: from laptop.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3AAF51956088; Fri, 30 Oct 2026 13:14:48 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, shaju.abraham@nutanix.com,
 khushit.shah@nutanix.com, richard.henderson@linaro.org,
 pbonzini@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com,
 7746591750@163.com, maobibo@loongson.cn, harshpb@linux.ibm.com,
 amachhiw@linux.ibm.com, daniel.barboza@oss.qualcomm.com,
 milesg@linux.ibm.com, farman@linux.ibm.com, cohuck@redhat.com,
 alireza.sanaee@huawei.com
Cc: armbru@redhat.com,
	mbawa@redhat.com
Subject: [PATCH v4 for-11.2 07/10] target/arm/kvm: Introduce
 kvm_arm_vcpu_prepare_init_features helper
Date: Fri, 30 Oct 2026 14:13:15 +0100
Message-ID: <20261030131406.461599-8-eric.auger@redhat.com>
In-Reply-To: <20261030131406.461599-1-eric.auger@redhat.com>
References: <20261030131406.461599-1-eric.auger@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Factorize the code that initializes the kvm init features from the
cpu settings in a helper. Use it in kvm_arch_init_vcpu(). Soon it will
be used by another function.

The only change in the code relates to the check of kvm_state. The
future caller won't have the VM created when calling the helper and
for this caller it is OK ignoring PSCI version setting.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Gustavo Romero <gromero@redhat.com>
Reviewed-by: Sebastian Ott <sebott@redhat.com>
Reviewed-by: Mohammadfaiz Bawa <mbawa@redhat.com>
---
 target/arm/kvm.c | 50 ++++++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 86a4d2a6b1..b4b20c5dc2 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2008,34 +2008,18 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
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
-    if (cpu->kvm_target == QEMU_KVM_ARM_TARGET_CORTEX_A53 ||
-        cpu->kvm_target == QEMU_KVM_ARM_TARGET_CORTEX_A57) {
-        warn_report_once("Using the cortex-a53 and cortex-a57 CPU types "
-                         "with KVM is deprecated. Use the max or host CPU "
-                         "types instead.");
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
@@ -2059,6 +2043,30 @@ int kvm_arch_init_vcpu(CPUState *cs, Error **errp)
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
+    if (cpu->kvm_target == QEMU_KVM_ARM_TARGET_CORTEX_A53 ||
+        cpu->kvm_target == QEMU_KVM_ARM_TARGET_CORTEX_A57) {
+        warn_report_once("Using the cortex-a53 and cortex-a57 CPU types "
+                         "with KVM is deprecated. Use the max or host CPU "
+                         "types instead.");
+    }
+
+    qemu_add_vm_change_state_handler(kvm_arm_vm_state_change, cpu);
+
+    kvm_arm_vcpu_prepare_init_features(cpu);
 
     /* Do KVM_ARM_VCPU_INIT ioctl */
     ret = kvm_arm_vcpu_init(cpu);
-- 
2.53.0


