Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F55E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 19:46:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsnUk-0008Bd-J5; Wed, 18 Feb 2026 14:45:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vsnUh-0008AJ-1F
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 14:45:55 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vsnUc-0001xE-O4
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 14:45:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=epPUNeODLu3/CJQTbpXdPwfeDLz0LIyfW/cEHBlj6Lk=; b=OLyIwR/y0Ox70Rb
 6wc6hKWpyAephwLhuWj79piNyUZcW4MsOLVWpXA5wFkNGLPkGgn3xgTVCS/pSjlVRxeQl94O1064b
 7zZNXU0sUIkPl3pMIGk0VL/DmheLp8AXV+2aGT6VM5jSbWSOopDBmOu1yL0xBb/23xtNlpBon/6r6
 6g=;
Date: Wed, 18 Feb 2026 20:48:59 +0100
Subject: [PATCH v3 2/4] hppa: Introduce HPPACPUDef
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-hppa-c3600-v3-2-b37ad58a20dd@rev.ng>
References: <20260218-hppa-c3600-v3-0-b37ad58a20dd@rev.ng>
In-Reply-To: <20260218-hppa-c3600-v3-0-b37ad58a20dd@rev.ng>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771444170; l=4077;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=U1HFOW8gA9fD5XVXydQEHvlBHPfGP4u6n8C5Pn/UIBw=;
 b=eLdiDKL0vgQINPJf1xLlz/ztkGi4ymjKNA740tRHaHx9e7IZ21aiRBaNvX8fMAhs2DfRI/65z
 GE+NIXE6m0MBu5huZHIx9xRUlbpA8RK73L/nL9WsL9bd+MDVRJ382td
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In preparation for adding a C3600 machine with 40 bits of physical
address space, and moving C3700 to 44 bits, a CPU model configuration
struct is added to HPPACPUClass.

Two fields are added describing the size of the physical address space,
and whether or not the CPU uses the PA-RISC 2.0 architecture.  The
latter was previously a field in CPUHPPAState.

phys_addr_bits is currently set but unused, and will be used in the
following commit.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/hppa/cpu.h | 24 ++++++++++++++++++++----
 target/hppa/cpu.c | 25 +++++++++++++++++--------
 2 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 092e647ccf..43b4882fb4 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -270,8 +270,6 @@ typedef struct CPUArchState {
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
-    bool is_pa20;
-
     target_ulong kernel_entry; /* Linux kernel was loaded here */
     target_ulong cmdline_or_bootorder;
     target_ulong initrd_base, initrd_end;
@@ -290,6 +288,18 @@ struct ArchCPU {
     QEMUTimer *alarm_timer;
 };
 
+/**
+ * HPPACPUDef:
+ * @phys_addr_bits: Number of bits in the physical address space.
+ * @is_pa20: Whether the CPU model follows the PA-RISC 2.0 or 1.1 spec.
+ *
+ * Configuration options for a HPPA CPU model.
+ */
+typedef struct HPPACPUDef {
+    uint8_t phys_addr_bits;
+    bool is_pa20;
+} HPPACPUDef;
+
 /**
  * HPPACPUClass:
  * @parent_realize: The parent class' realize handler.
@@ -302,11 +312,17 @@ struct HPPACPUClass {
 
     DeviceRealize parent_realize;
     ResettablePhases parent_phases;
+    const HPPACPUDef *def;
 };
 
-static inline bool hppa_is_pa20(const CPUHPPAState *env)
+static inline const HPPACPUDef *hppa_def(CPUHPPAState *env)
+{
+    return HPPA_CPU_GET_CLASS(env_cpu(env))->def;
+}
+
+static inline bool hppa_is_pa20(CPUHPPAState *env)
 {
-    return env->is_pa20;
+    return hppa_def(env)->is_pa20;
 }
 
 static inline int HPPA_BTLB_ENTRIES(CPUHPPAState *env)
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index c8079016bf..7098940454 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -203,13 +203,6 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
     tcg_cflags_set(cs, CF_PCREL);
 }
 
-static void hppa_cpu_initfn(Object *obj)
-{
-    CPUHPPAState *env = cpu_env(CPU(obj));
-
-    env->is_pa20 = !!object_dynamic_cast(obj, TYPE_HPPA64_CPU_PA_8700);
-}
-
 static void hppa_cpu_reset_hold(Object *obj, ResetType type)
 {
     HPPACPUClass *scc = HPPA_CPU_GET_CLASS(obj);
@@ -284,6 +277,14 @@ static const TCGCPUOps hppa_tcg_ops = {
 #endif /* !CONFIG_USER_ONLY */
 };
 
+static void hppa_cpu_class_base_init(ObjectClass *oc, const void *data)
+{
+    HPPACPUClass *acc = HPPA_CPU_CLASS(oc);
+    /* Make sure all CPU models define a HPPACPUDef */
+    g_assert(!object_class_is_abstract(oc) && data != NULL);
+    acc->def = data;
+}
+
 static void hppa_cpu_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -318,18 +319,26 @@ static const TypeInfo hppa_cpu_type_infos[] = {
         .parent = TYPE_CPU,
         .instance_size = sizeof(HPPACPU),
         .instance_align = __alignof(HPPACPU),
-        .instance_init = hppa_cpu_initfn,
         .abstract = true,
         .class_size = sizeof(HPPACPUClass),
         .class_init = hppa_cpu_class_init,
+        .class_base_init = hppa_cpu_class_base_init,
     },
     {
         .name = TYPE_HPPA_CPU_PA_7300LC,
         .parent = TYPE_HPPA_CPU,
+        .class_data = &(const HPPACPUDef) {
+            .phys_addr_bits = 32,
+            .is_pa20 = false,
+        },
     },
     {
         .name = TYPE_HPPA_CPU_PA_8700,
         .parent = TYPE_HPPA_CPU,
+        .class_data = &(const HPPACPUDef) {
+            .phys_addr_bits = 40,
+            .is_pa20 = true,
+        },
     },
 };
 

-- 
2.52.0


