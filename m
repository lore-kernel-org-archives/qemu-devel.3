Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F5B5C54F56
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wonS2-00038Q-L8; Tue, 28 Jul 2026 15:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wonRy-00031V-1L
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:26:50 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wonRv-0001PS-G6
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:26:49 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so201101a91.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 12:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785266806; x=1785871606; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P0YSgKbTi94FPXUFvygJmUQ5Zpn1OBxkC+C5ko65QCo=;
 b=Hoe8gUDs+9DHxkt75XvhowLJeWnXaCldHYGh713I8fk+OByYrjvgSg1YBAcL6IDV8b
 l8tazjBayBUB+vHbz/MHq8KNfCt7ngBS7iksRQazaxS5YpI668EAzAPALVBJEPmubRJc
 Mb0U9kGOphq7UYljtZfct+NtY49KeOa64JRk09qQ7EzzU+kT9+1mzkSqIh6kppLi8VK2
 owjghndnXTwsYGIy+8H9C3cYYhi6rdWYgkQ87zkOuVQIdutmFDFz6pa7s2kvzNv9YX4B
 3yxIzVo2cMJrLTOQvlp5sUxRlolc2E1Fwox5SFOTUe9/MV126FnSNuZS8e7Z7IMj8c+L
 1r6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785266806; x=1785871606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=P0YSgKbTi94FPXUFvygJmUQ5Zpn1OBxkC+C5ko65QCo=;
 b=g0tfxp8xySdfGl/HA4yufzVJZNF4sq4EAjqiryTp374HAoTjzSF5HQFrPL0kW+sLrm
 B7BMsBZoCuQjlVE7YoPraiVU96SKqPCdh255nW2aux99s4U2y9b/TabBs/ix3abKtlBw
 k1dv5yh0yOfDhIoVYo8QbpMQBAekPfGRUlcT51NH5c97ENDQgNsFIImwYsvmTrxsqpWN
 WsbMJU5nrRUu+G45dpL2hu9HrOEXCNeDTxQqEK8Ay1VHjLIGJKhr2dWCsXQM0lwseUjX
 BdGyjgHjKXyqSvNoFcVK6cR9fNBjrfys8fmDHii+IKPvEs0ZTG61S+7ltLmUb7OPMC5r
 iJRQ==
X-Gm-Message-State: AOJu0YxZpNfGa4TYKUnqobG5Pjs50Oyqyfg00DCqvuGealJdGH+dARoc
 ku1pmG9EA+bkCMg/pKsqWv/mdaMLq0It81R3WNzdzwj2B5qA4TS7m1uzWP/RJ6PQPSM=
X-Gm-Gg: AR+sD110JEqKczxOhYnNwaGCpn8Db4e8PElyU5tV7f1stlE/EZx2dI9QAnPLBKc1dzU
 B70rXLdEzhef98/NMpKs1CQL5n4egKPX4h6E6+yez3bvuhMAWKg7vryuOjF+u7GGMSNBLGlvdbk
 h3G4src0T3b7lEMhhjkL296aQbL7tH9oq9HbRYzqCRixNgMN6HqmJrJ4fsCzOVVuRY+Krk1Gjxt
 5T3WUBbFPmIEvaMeg8Hej5b4nZpzCvSuVnB65I4qjBSZD9lBzXGlmHlOiGHcaojQ5rbE0GICwrY
 pBjdqERWVDbRxMW2yF6PVcvTJPs8KKtABY4VHWVCM16ccOV5exrU5Ave2nVx2WJhsXp8Zu3iqU6
 OSHCPrir1jfeCLg1qnoUyWVIqg7fwBv6rXrmZ00FQ4it/Qra44ITSGHiDOIUIp7+O6qemPu9rnu
 kACUNBxPRIZQ2AhH2rlhCERj/oAz0M
X-Received: by 2002:a17:90b:50c3:b0:37d:ee77:78ac with SMTP id
 98e67ed59e1d1-38f6a3aba5emr4059612a91.19.1785266805956; 
 Tue, 28 Jul 2026 12:26:45 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 12:26:44 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v2 06/24] target/arm/kvm-rme: Initialize vCPU
Date: Tue, 28 Jul 2026 13:26:12 -0600
Message-ID: <20260728192630.240375-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728192630.240375-1-mathieu.poirier@linaro.org>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

The target code calls kvm_arm_vcpu_init() to mark the vCPU as part of a
Realm. For a Realm vCPU, only x0-x7 can be set at runtime. Before boot,
the PC can also be set, and is ignored at runtime. KVM also accepts a
few system register changes during initial configuration, as returned by
KVM_GET_REG_LIST.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/cpu.h      |  3 +++
 target/arm/kvm-rme.c  |  9 ++++++++
 target/arm/kvm-stub.c |  5 ++++
 target/arm/kvm.c      | 54 +++++++++++++++++++++++++++++++++++++++++--
 target/arm/kvm_arm.h  | 10 ++++++++
 5 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 03a30afcbed1..c7927036360c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1055,6 +1055,9 @@ struct ArchCPU {
     /* KVM steal time */
     OnOffAuto kvm_steal_time;
 
+    /* Realm Management Extension */
+    bool kvm_rme;
+
     /* Uniprocessor system with MP extensions */
     bool mp_is_up;
 
diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index eb8e65ba438f..5d6814fcf9e5 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -69,6 +69,15 @@ static int kvm_arm_rme_init(ConfidentialGuestSupport *cgs, Error **errp)
     return 0;
 }
 
+void kvm_arm_rme_vcpu_init(ARMCPU *cpu)
+{
+    if (!rme_guest) {
+        return;
+    }
+
+    cpu->kvm_rme = true;
+}
+
 static void rme_guest_class_init(ObjectClass *oc, const void *data)
 {
     ConfidentialGuestSupportClass *klass = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 88cbe8d85c41..5fde96f9b281 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -119,3 +119,8 @@ char *kvm_print_register_name(uint64_t regidx)
 {
     g_assert_not_reached();
 }
+
+void kvm_arm_rme_vcpu_init(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 33c3763aebfa..b4c6da1fb9f3 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2015,6 +2015,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_HAS_EL2;
     }
 
+    kvm_arm_rme_vcpu_init(cpu);
+
     /* Do KVM_ARM_VCPU_INIT ioctl */
     ret = kvm_arm_vcpu_init(cpu);
     if (ret) {
@@ -2169,6 +2171,29 @@ static int kvm_arch_put_sve(CPUState *cs, uint32_t vq, bool have_ffr)
     return 0;
 }
 
+static int kvm_arm_rme_put_core_regs(CPUState *cs, Error **errp)
+{
+    int i, ret;
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    /* The RME ABI only allows us to set 8 GPRs and the PC */
+    for (i = 0; i < 8; i++) {
+        ret = kvm_set_one_reg(cs, AARCH64_CORE_REG(regs.regs[i]),
+                              &env->xregs[i]);
+        if (ret) {
+            return ret;
+        }
+    }
+
+    ret = kvm_set_one_reg(cs, AARCH64_CORE_REG(regs.pc), &env->pc);
+    if (ret) {
+        return ret;
+    }
+
+    return 0;
+}
+
 static int kvm_arm_put_core_regs(CPUState *cs, Error **errp)
 {
     uint64_t val;
@@ -2280,7 +2305,11 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
     int ret;
     ARMCPU *cpu = ARM_CPU(cs);
 
-    ret = kvm_arm_put_core_regs(cs, errp);
+    if (cpu->kvm_rme) {
+        ret = kvm_arm_rme_put_core_regs(cs, errp);
+    } else {
+        ret = kvm_arm_put_core_regs(cs, errp);
+    }
     if (ret) {
         return ret;
     }
@@ -2367,6 +2396,23 @@ static int kvm_arch_get_sve(CPUState *cs, uint32_t vq, bool have_ffr)
     return 0;
 }
 
+static int kvm_arm_rme_get_core_regs(CPUState *cs, Error **errp)
+{
+    int i, ret;
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    for (i = 0; i < 8; i++) {
+        ret = kvm_get_one_reg(cs, AARCH64_CORE_REG(regs.regs[i]),
+                              &env->xregs[i]);
+        if (ret) {
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
 static int kvm_arm_get_core_regs(CPUState *cs, Error **errp)
 {
     uint64_t val;
@@ -2478,7 +2524,11 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
     int ret;
     ARMCPU *cpu = ARM_CPU(cs);
 
-    ret = kvm_arm_get_core_regs(cs, errp);
+    if (cpu->kvm_rme) {
+        ret = kvm_arm_rme_get_core_regs(cs, errp);
+    } else {
+        ret = kvm_arm_get_core_regs(cs, errp);
+    }
     if (ret) {
         return ret;
     }
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index e7c40fb003e4..d95381c13afa 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -240,4 +240,14 @@ void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3);
  */
 char *kvm_print_register_name(uint64_t regidx);
 
+/**
+ * kvm_arm_rme_vcpu_init
+ * @cs: the CPU
+ *
+ * If the user requested a Realm, setup the given vCPU accordingly. Realm vCPUs
+ * behave a little differently, for example most of their register state is
+ * hidden from the host.
+ */
+void kvm_arm_rme_vcpu_init(ARMCPU *cpu);
+
 #endif
-- 
2.43.0


