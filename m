Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9C7C3DA4D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 13:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSG8D-0005nT-Bq; Fri, 12 Jul 2024 09:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab@kernel.org>)
 id 1sSG7c-0004zK-H6; Fri, 12 Jul 2024 09:15:37 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab@kernel.org>)
 id 1sSG7a-0001Eu-0x; Fri, 12 Jul 2024 09:15:36 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 800BECE1AF5;
 Fri, 12 Jul 2024 13:15:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CAEC4AF10;
 Fri, 12 Jul 2024 13:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1720790122;
 bh=9YH+uN2FpTDfQsql9e3P4xbbtz8E4TbY1G0zlNhC2vc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eapYYC1YsFxVkG74Ij9c7WPxBrDik6Dqz5rJDE067AbX4V7pyvKO6RY/TBroOU5cb
 i9NYFBukMQs8CJKDCGCMSpuGTmIf7zD1x4HHEBoPVzh0viqR3CR3jRddADhVMzc7JS
 nwlpJuMzv4wokjqYHdC82c7TxO8JXL1HVST+t1toy0fvyEJvMR09s9E5G/pSfkDgAH
 hLpFOKLu4dIMADQInwO6h5sLrv6HK2ganuIdozDycsvr2CWfOg+J3AyJ9Fc20wMXEA
 KsBQmLZYMeB8i/t4aqRJhEosxKpNjU1Lb/E+7mNwsrgAVjqpERP0203NQMYHluXqQ3
 mPWoOMxPRO5jg==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
 (envelope-from <mchehab@kernel.org>) id 1sSG7K-00000003iED-1V73;
 Fri, 12 Jul 2024 15:15:18 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 "Shiju Jose" <shiju.jose@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 5/7] target/arm: preserve mpidr value
Date: Fri, 12 Jul 2024 15:15:12 +0200
Message-ID: <f0b1356f3f734446ed490911871510965d5cbd2c.1720789922.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720789921.git.mchehab+huawei@kernel.org>
References: <cover.1720789921.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.73.55; envelope-from=mchehab@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

There is a logic at helper to properly fill the mpidr information.
This is needed for ARM Processor error injection, so store the
value inside a cpu opaque value, to allow it to be used.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 target/arm/cpu.h    |  1 +
 target/arm/helper.c | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a12859fc5335..d2e86f0877cc 100644
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
index ce319572354a..2432b5b09607 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4692,7 +4692,7 @@ static uint64_t mpidr_read_val(CPUARMState *env)
     return mpidr;
 }
 
-static uint64_t mpidr_read(CPUARMState *env, const ARMCPRegInfo *ri)
+static uint64_t mpidr_read(CPUARMState *env)
 {
     unsigned int cur_el = arm_current_el(env);
 
@@ -4702,6 +4702,11 @@ static uint64_t mpidr_read(CPUARMState *env, const ARMCPRegInfo *ri)
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
@@ -9723,7 +9728,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "MPIDR_EL1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .crn = 0, .crm = 0, .opc1 = 0, .opc2 = 5,
               .fgt = FGT_MPIDR_EL1,
-              .access = PL1_R, .readfn = mpidr_read, .type = ARM_CP_NO_RAW },
+              .access = PL1_R, .readfn = mpidr_read_ri, .type = ARM_CP_NO_RAW },
         };
 #ifdef CONFIG_USER_ONLY
         static const ARMCPRegUserSpaceInfo mpidr_user_cp_reginfo[] = {
@@ -9733,6 +9738,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         modify_arm_cp_regs(mpidr_cp_reginfo, mpidr_user_cp_reginfo);
 #endif
         define_arm_cp_regs(cpu, mpidr_cp_reginfo);
+        cpu->mpidr = mpidr_read(env);
     }
 
     if (arm_feature(env, ARM_FEATURE_AUXCR)) {
-- 
2.45.2


