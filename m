Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FEC1C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7krv-0006wQ-5h; Wed, 23 Apr 2025 20:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqX-00015l-QI
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:46 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqK-0004lA-My
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:34 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7376e311086so491029b3a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456011; x=1746060811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z4XK59Un/F/cXTQA+raQ2QBk7p5qcqGVyAJ27nWp3Cg=;
 b=ZovYEuyZJj15duiSN6wZ5JElSE7KqVi9sZVS0G8E8oucx/Ru9zncz6rbrtY2cHk66s
 BVgPuQEhxnHVCJnT6K9tLHUBU35ePbb/VyGtpvkwJLnmCNC/eaC9iNFWNxPwd9Q6mm8i
 0dRMVBZ8xg/ML+tHZfuLUm4w7To+VEDHrW5jOKAwi3PeY0cqZbxfd27wzXD357H8xxIO
 Z0RrdiWwAbv2Kd+tmjLTj0YLUZ4wGeDnOlloC/W0dkQfqlR5zBWXlqX711VvzUxyR+1d
 +usuKL3d3V5h5FRoZurU36fWGKfn/DPxzcuQ0Cmy3pMoIibRRmwxevZvhv2olL8mrPLk
 HJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456011; x=1746060811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z4XK59Un/F/cXTQA+raQ2QBk7p5qcqGVyAJ27nWp3Cg=;
 b=Omtm5r/xIOS3LA2tBJXt61Aq3lBaIvxNqBRSljtvE1yE7u3UD4cyvcneEzF898I+bU
 6z2WUJKVOsm6WIwQZcLWtxpeXyotSYolQZsH10VU9FMNPPWZIKmdcpci9yeOhSPV2jQr
 3CtDEjIA969EZHeGed2SefTyOymP+pBxeqvyH3hhAsJGYlm39kaY2mx5tAaWxXbXqBmy
 5Ekysor5Ow9r+qGnKiuUk1LyquPhILRMRRZQm6s6fM3XoHvq1OHIOzKSAHENdVzp5Hvy
 p16phjiyAcsgiMxlX+RJKUznh/On33XSVd+J6rkocQ5iWEuS98N/E98DzVUFo6T1nskG
 sVFA==
X-Gm-Message-State: AOJu0YxAwz68kzybdBNmrtyNky9cYcyffQP8kppFv+L4sE4kE6Ki0ssv
 yrO2Xzi7ViGDjR3S7sdAvWDOjQgE5A4ZqBzNo1Miq4T3GAy/SoVdAPQ2h7esV4/zw6/xKEAT9A9
 u
X-Gm-Gg: ASbGncto6o/yS3b6m5iIYFMPowcmVa1TVA4G5SXKpsxmYBKrxofeYQ1ddemPG8TiD0Q
 lWDPw2WLuG3oyOX0dCLaP9JiFcD7zyKea/UGH55M0IXB6YIW5eQsx+zQvfUeCEpU8b5ISDjEyN3
 qsKR2mxZSHMsmrGZnbtELOc06aPO6MuvpRE4MMfwjf9pniLlZ28vViXkE65ygAQBgiW1Qtu9WGv
 HvCUqdtCQZycVLXFuwDzQmZo/C6nbPNBhrf/1+MIQqcACy076Yq1YGmsV49gMO7QSCdY+AYs2sF
 EMOtaVLnTA7lTfKVlB4HT7V7948WnhM+/qVUcMyfINottI9weFtSRJHr3Z6cALcmzW8g+PE4mY4
 kCRxz6N93IA==
X-Google-Smtp-Source: AGHT+IEqwmQswtBYuu3lPakwA5JEVaL2rWJFrA195gF/wJ8GGx2OFVDT0C0lzPTjlqpU9NYPwYu/vw==
X-Received: by 2002:a05:6a21:3389:b0:1f5:a3e8:64d3 with SMTP id
 adf61e73a8af0-20444f0024bmr855357637.21.1745456010831; 
 Wed, 23 Apr 2025 17:53:30 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 075/148] target/arm: Restrict SoftMMU mmu_index() to TCG
Date: Wed, 23 Apr 2025 17:48:20 -0700
Message-ID: <20250424004934.598783-76-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Move arm_cpu_mmu_index() within CONFIG_TCG #ifdef'ry,
convert CPUClass::mmu_index() to TCGCPUOps::mmu_index().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-5-philmd@linaro.org>
---
 target/arm/internals.h   |  1 +
 target/arm/cpu.c         | 13 +++++++------
 target/arm/tcg/cpu-v7m.c |  1 +
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 28585c0755..8756c24c08 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -373,6 +373,7 @@ void arm_cpu_synchronize_from_tb(CPUState *cs, const TranslationBlock *tb);
 
 /* Our implementation of TCGCPUOps::cpu_exec_halt */
 bool arm_cpu_exec_halt(CPUState *cs);
+int arm_cpu_mmu_index(CPUState *cs, bool ifetch);
 #endif /* CONFIG_TCG */
 
 typedef enum ARMFPRounding {
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 01786ac787..21e8cf1400 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -121,6 +121,12 @@ void arm_restore_state_to_opc(CPUState *cs,
         env->exception.syndrome = data[2] << ARM_INSN_START_WORD2_SHIFT;
     }
 }
+
+int arm_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    return arm_env_mmu_index(cpu_env(cs));
+}
+
 #endif /* CONFIG_TCG */
 
 #ifndef CONFIG_USER_ONLY
@@ -144,11 +150,6 @@ static bool arm_cpu_has_work(CPUState *cs)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-static int arm_cpu_mmu_index(CPUState *cs, bool ifetch)
-{
-    return arm_env_mmu_index(cpu_env(cs));
-}
-
 void arm_register_pre_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
                                  void *opaque)
 {
@@ -2674,6 +2675,7 @@ static const TCGCPUOps arm_tcg_ops = {
     .synchronize_from_tb = arm_cpu_synchronize_from_tb,
     .debug_excp_handler = arm_debug_excp_handler,
     .restore_state_to_opc = arm_restore_state_to_opc,
+    .mmu_index = arm_cpu_mmu_index,
 
 #ifdef CONFIG_USER_ONLY
     .record_sigsegv = arm_cpu_record_sigsegv,
@@ -2708,7 +2710,6 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
                                        &acc->parent_phases);
 
     cc->class_by_name = arm_cpu_class_by_name;
-    cc->mmu_index = arm_cpu_mmu_index;
     cc->dump_state = arm_cpu_dump_state;
     cc->set_pc = arm_cpu_set_pc;
     cc->get_pc = arm_cpu_get_pc;
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index c4dd309272..1a913faa50 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -237,6 +237,7 @@ static const TCGCPUOps arm_v7m_tcg_ops = {
     .synchronize_from_tb = arm_cpu_synchronize_from_tb,
     .debug_excp_handler = arm_debug_excp_handler,
     .restore_state_to_opc = arm_restore_state_to_opc,
+    .mmu_index = arm_cpu_mmu_index,
 
 #ifdef CONFIG_USER_ONLY
     .record_sigsegv = arm_cpu_record_sigsegv,
-- 
2.43.0


