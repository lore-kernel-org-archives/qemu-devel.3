Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160C0D149CD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 18:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4P0N-0000bg-16; Fri, 25 Oct 2024 14:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1t4P0K-0000bT-GH
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 14:25:44 -0400
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1t4P0I-0005W2-T9
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 14:25:44 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 17BAEA4458B;
 Fri, 25 Oct 2024 18:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11608C4CEC3;
 Fri, 25 Oct 2024 18:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1729880737;
 bh=FmwR/ay6PwEFHuH1C4wrx2HXPkh5ZckcKd2xk0bLx8s=;
 h=Date:From:To:Subject:From;
 b=TkVb6Nd2o9Q+1wCNDjRf3g1qSlFnzKcE942FUcFlqq4uS179xAV4mqbJmVmzawvKd
 +Ecs4vDgcbMsqsg8rKhF0XWKXfpoi89s1PWNNrXbqIGSBmes+8wIhLRXd6IwZ5lPix
 DfdfcT5CnDAap3d2945F6343nrQRTldlz3Blx6ypfRvMXc6yxqb04JktfHUK1A04Mu
 QW7mmazdGa5O/n88V5EyIXSF9ZDgR49TcQUGvRFhUXlmTxfMsXkctp5mbQXy2S2xdC
 PhyyO1i0W8W9BZ+K4PMRNeI9x64kc10LW4pZK+JjOa3IVSBcdbQ8fBRAtOXdh973Hi
 CSRTDUDk0P3Bg==
Date: Fri, 25 Oct 2024 20:25:33 +0200
From: Helge Deller <deller@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: [PATCH] target/hppa: Add CPU reset method
Message-ID: <Zxvinao2jcZgyAVG@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=147.75.193.91; envelope-from=deller@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add the missing CPU reset method, which resets all CPU registers and the
TLB to zero. Then the CPU will switch to 32-bit mode (PSW_W bit is not
set) and start execution at address 0xf0000004.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index c38439c180..0cc696ccd3 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -235,15 +235,39 @@ static const TCGCPUOps hppa_tcg_ops = {
 #endif /* !CONFIG_USER_ONLY */
 };
 
+static void hppa_cpu_reset_hold(Object *obj, ResetType type)
+{
+    HPPACPU *cpu = HPPA_CPU(obj);
+    HPPACPUClass *scc = HPPA_CPU_GET_CLASS(cpu);
+    CPUHPPAState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
+
+    if (scc->parent_phases.hold) {
+        scc->parent_phases.hold(obj, type);
+    }
+
+    memset(env, 0, sizeof(*env));
+
+    cpu_set_pc(cs, 0xf0000004);
+    env->psw = PSW_Q;
+
+    cs->exception_index = -1;
+    cs->halted = 0;
+}
+
 static void hppa_cpu_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     CPUClass *cc = CPU_CLASS(oc);
     HPPACPUClass *acc = HPPA_CPU_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
 
     device_class_set_parent_realize(dc, hppa_cpu_realizefn,
                                     &acc->parent_realize);
 
+    resettable_class_set_parent_phases(rc, NULL, hppa_cpu_reset_hold, NULL,
+                                       &acc->parent_phases);
+
     cc->class_by_name = hppa_cpu_class_by_name;
     cc->has_work = hppa_cpu_has_work;
     cc->mmu_index = hppa_cpu_mmu_index;
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index e45ba50a59..44ee115139 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -281,6 +281,7 @@ struct ArchCPU {
 /**
  * HPPACPUClass:
  * @parent_realize: The parent class' realize handler.
+ * @parent_phases: The parent class' reset phase handlers.
  *
  * An HPPA CPU model.
  */
@@ -288,6 +289,7 @@ struct HPPACPUClass {
     CPUClass parent_class;
 
     DeviceRealize parent_realize;
+    ResettablePhases parent_phases;
 };
 
 #include "exec/cpu-all.h"

