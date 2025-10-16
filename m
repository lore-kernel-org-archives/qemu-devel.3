Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E91CCD195
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 13:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9OTi-0006hS-PD; Thu, 16 Oct 2025 09:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v9OTh-0006gm-FX
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 09:57:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v9OTZ-00068G-EM
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 09:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760623023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ntVvVf8/M035uETjgq/33f4ABncTA+oJSQYYqx0UURM=;
 b=VdhlLvr7RLNt6rlDxCGhXsMLppFhmEw4/wn/Sxp+1pYIvGNxCsrkA4ndMzcfTtng/CL/yd
 20dZiWdQC7dMVD7UTw6eRHl1vBiy4NxVV3AtaHvr3A+RP0zPUIw11bkPS7wR7hKzG3aFMv
 +wHP/dyJp1tTZqL/rxM2X5XwOnS32Xw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-jZX_75tNMwWv01aua5eXOg-1; Thu,
 16 Oct 2025 09:57:00 -0400
X-MC-Unique: jZX_75tNMwWv01aua5eXOg-1
X-Mimecast-MFC-AGG-ID: jZX_75tNMwWv01aua5eXOg_1760623018
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5A6A180A233; Thu, 16 Oct 2025 13:56:58 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.238])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C272B19560AD; Thu, 16 Oct 2025 13:56:54 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com,
 gshan@redhat.com, ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: [PATCH 5/7] target/arm/cpu: Implement hide_reg callback()
Date: Thu, 16 Oct 2025 15:55:17 +0200
Message-ID: <20251016135625.249551-6-eric.auger@redhat.com>
In-Reply-To: <20251016135625.249551-1-eric.auger@redhat.com>
References: <20251016135625.249551-1-eric.auger@redhat.com>
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
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Checks if the register is hidden.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 target/arm/cpu.h |  2 ++
 target/arm/cpu.c | 12 ++++++++++++
 target/arm/kvm.c | 23 ++---------------------
 3 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 30d59a51d6..3ae4d65422 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2687,4 +2687,6 @@ static inline bool is_fake_reg(ARMCPU *cpu, uint64_t regidx)
 #define LOG2_TAG_GRANULE 4
 #define TAG_GRANULE      (1 << LOG2_TAG_GRANULE)
 
+bool arm_cpu_hide_reg(CPUState *s, uint64_t regidx);
+
 #endif
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 3b556f1404..60eee82742 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2366,6 +2366,17 @@ static const TCGCPUOps arm_tcg_ops = {
 };
 #endif /* CONFIG_TCG */
 
+bool arm_cpu_hide_reg(CPUState *s, uint64_t regidx)
+{
+    ARMCPU *cpu = ARM_CPU(s);
+    for (int i = 0; i < cpu->nr_kvm_hidden_regs; i++) {
+        if (cpu->kvm_hidden_regs[i] == regidx) {
+            return true;
+        }
+    }
+    return false;
+}
+
 static void arm_cpu_class_init(ObjectClass *oc, const void *data)
 {
     ARMCPUClass *acc = ARM_CPU_CLASS(oc);
@@ -2394,6 +2405,7 @@ static void arm_cpu_class_init(ObjectClass *oc, const void *data)
     cc->gdb_get_core_xml_file = arm_gdb_get_core_xml_file;
     cc->gdb_stop_before_watchpoint = true;
     cc->disas_set_info = arm_disas_set_info;
+    cc->hide_reg = arm_cpu_hide_reg;
 
 #ifdef CONFIG_TCG
     cc->tcg_ops = &arm_tcg_ops;
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 7551c43e79..1a95e2c667 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -754,25 +754,6 @@ static bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx)
     }
 }
 
-/**
- * kvm_vcpu_compat_hidden_reg:
- * @cpu: ARMCPU
- * @regidx: index of the register to check
- *
- * Depending on the CPU compat returns true if @regidx must be
- * ignored during sync & migration
- */
-static inline bool
-kvm_vcpu_compat_hidden_reg(ARMCPU *cpu, uint64_t regidx)
-{
-    for (int i = 0; i < cpu->nr_kvm_hidden_regs; i++) {
-        if (cpu->kvm_hidden_regs[i] == regidx) {
-            return true;
-        }
-    }
-    return false;
-}
-
 /**
  * kvm_arm_init_cpreg_list:
  * @cpu: ARMCPU
@@ -834,7 +815,7 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
         uint64_t regidx = rlp->reg[i];
 
         if (!kvm_arm_reg_syncs_via_cpreg_list(regidx) ||
-            kvm_vcpu_compat_hidden_reg(cpu, regidx)) {
+            arm_cpu_hide_reg(&cpu->parent_obj, regidx)) {
             continue;
         }
         switch (rlp->reg[i] & KVM_REG_SIZE_MASK) {
@@ -867,7 +848,7 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
         if (!kvm_arm_reg_syncs_via_cpreg_list(regidx)) {
             continue;
         }
-        if (kvm_vcpu_compat_hidden_reg(cpu, regidx)) {
+        if (arm_cpu_hide_reg(&cpu->parent_obj, regidx)) {
             trace_kvm_arm_init_cpreg_list_skip_hidden_reg(rlp->reg[i]);
             continue;
         }
-- 
2.49.0


