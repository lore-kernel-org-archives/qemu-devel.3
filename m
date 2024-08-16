Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874C8C531DE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 07:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1serXZ-0000KH-0i; Fri, 16 Aug 2024 03:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1serXX-0000CH-6g; Fri, 16 Aug 2024 03:38:27 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1serXJ-0005ub-9E; Fri, 16 Aug 2024 03:38:26 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 8BE8FCE1EF7;
 Fri, 16 Aug 2024 07:37:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717A9C4AF15;
 Fri, 16 Aug 2024 07:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723793873;
 bh=nFa18EP1VntHvi50soKrL++v7UfmRI3rSREy+WDR8ps=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BQJq1HE1XGM9SJjGfeUOBcsmlY9qq5GHcVd8J1W5Ovq6j5eayzm2mLF5yF0PFUJer
 P6hGOpC1x57m1IwdRwr1Dkhs8Z40Qhl2RCYM/lKwYnzBrVl/Z8hAEmFq/jERBYW044
 eGBMwmLRotxuTOu27WXzEKYPbiFLZweoDszIcbhbrnr4+OFI+bPNI5O2xR0seEMpLb
 O6zPFNxneQ7VS4RNHw0txVk07newFQT/uBXEsrfFqiKmc6feRtimdsvsCJV3XFapCd
 srWhHMOVM2zjh6+v6cveD/5QsEVYQimUoxxR3CuLbqk6zm9GwBHd6ou8Pqre6+arkA
 xvrtxOV5FOqdQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1serWx-000000055ev-2oNH; Fri, 16 Aug 2024 09:37:51 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v8 10/13] target/arm: add an experimental mpidr arm cpu
 property object
Date: Fri, 16 Aug 2024 09:37:42 +0200
Message-ID: <2e1c52c861bdb33b95334bb3598038a73426f5c6.1723793768.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1723793768.git.mchehab+huawei@kernel.org>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.73.55;
 envelope-from=mchehab+huawei@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Accurately injecting an ARM Processor error ACPI/APEI GHES
error record requires the value of the ARM Multiprocessor
Affinity Register (mpidr).

While ARM implements it, this is currently not visible.

Add a field at CPU storing it, and place it at arm_cpu_properties
as experimental, thus allowing it to be queried via QMP using
qom-get function.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 target/arm/cpu.c    |  1 +
 target/arm/cpu.h    |  1 +
 target/arm/helper.c | 10 ++++++++--
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 19191c239181..30fcf0a10f46 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2619,6 +2619,7 @@ static ObjectClass *arm_cpu_class_by_name(const char *cpu_model)
 
 static Property arm_cpu_properties[] = {
     DEFINE_PROP_UINT64("midr", ARMCPU, midr, 0),
+    DEFINE_PROP_UINT64("x-mpidr", ARMCPU, mpidr, 0),
     DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
                         mp_affinity, ARM64_AFFINITY_INVALID),
     DEFINE_PROP_INT32("node-id", ARMCPU, node_id, CPU_UNSET_NUMA_NODE_ID),
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9a3fd595621f..3ad4de793409 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1033,6 +1033,7 @@ struct ArchCPU {
         uint64_t reset_pmcr_el0;
     } isar;
     uint64_t midr;
+    uint64_t mpidr;
     uint32_t revidr;
     uint32_t reset_fpsid;
     uint64_t ctr;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0a582c1cd3b3..d6e7aa069489 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4690,7 +4690,7 @@ static uint64_t mpidr_read_val(CPUARMState *env)
     return mpidr;
 }
 
-static uint64_t mpidr_read(CPUARMState *env, const ARMCPRegInfo *ri)
+static uint64_t mpidr_read(CPUARMState *env)
 {
     unsigned int cur_el = arm_current_el(env);
 
@@ -4700,6 +4700,11 @@ static uint64_t mpidr_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return mpidr_read_val(env);
 }
 
+static uint64_t mpidr_read_ri(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    return mpidr_read(env);
+}
+
 static const ARMCPRegInfo lpae_cp_reginfo[] = {
     /* NOP AMAIR0/1 */
     { .name = "AMAIR0", .state = ARM_CP_STATE_BOTH,
@@ -9721,7 +9726,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "MPIDR_EL1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .crn = 0, .crm = 0, .opc1 = 0, .opc2 = 5,
               .fgt = FGT_MPIDR_EL1,
-              .access = PL1_R, .readfn = mpidr_read, .type = ARM_CP_NO_RAW },
+              .access = PL1_R, .readfn = mpidr_read_ri, .type = ARM_CP_NO_RAW },
         };
 #ifdef CONFIG_USER_ONLY
         static const ARMCPRegUserSpaceInfo mpidr_user_cp_reginfo[] = {
@@ -9731,6 +9736,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         modify_arm_cp_regs(mpidr_cp_reginfo, mpidr_user_cp_reginfo);
 #endif
         define_arm_cp_regs(cpu, mpidr_cp_reginfo);
+        cpu->mpidr = mpidr_read(env);
     }
 
     if (arm_feature(env, ARM_FEATURE_AUXCR)) {
-- 
2.46.0


