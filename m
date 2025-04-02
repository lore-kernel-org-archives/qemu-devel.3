Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA82C36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05Fj-0004LY-Sa; Wed, 02 Apr 2025 17:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Fi-0004LF-Az
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:04:02 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Fg-00068K-MV
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:04:02 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39c1efbefc6so157195f8f.1
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743627839; x=1744232639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QZfm8L4afKOtezoc8SztPnsV7fIAL11ANZr88iQSiiw=;
 b=NXdEwfck1LNTur0Y+cN0XG4UuX8720RibRrn5H45bbqe42jBQwvl+Tl2OP5PibiRkA
 GvbJk7hqdprG7mNfR6GmdvNXTOWzTTp+1gxqMYHBVYqRMuTau2XNt4Jk9mv6+lMIbwYt
 JOf2ogHDVOkCPoRj3ifmOxUr69GepShvFRcVK1BMJ0PYEMoG1aA+fpPouF/psteEpay4
 IeeJVg0IDScEyF3TRXHqR3Or8LCikNBPavv++zGsyAILng2Q9rtqZ4Ic2KJq+oyk2VQH
 6+REnWXkosUXPLXIeZ5qUujPtRPYMWwtcz1PMCsQFL8ZPkzqy02QRXDyosNFpJMz/Om4
 jFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627839; x=1744232639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QZfm8L4afKOtezoc8SztPnsV7fIAL11ANZr88iQSiiw=;
 b=LTSTtMIOqQEvudESJk9NY4sQSXjF4Vldv6188tu8bjROC6pjx/qu4b1hPyK45AbRiN
 DzYrAfR4W42wDXKf+Ecj7xLgujebH2LFrYaR6H/rDZtcoRmWDxNIjldxm0CpE9UPnaLZ
 EtmISSYsadjoCLWkE8ThcDsk7wxY6wmLLaf5qpsVCHuB/+V6nQlWUNTeZYX0JITanYmg
 58C+fgNcNzC+sAPGWdJ5tYb9sPc6nLAzb08P9yhu51OUds0g5WmoKi7FXhnO1t6NgDvj
 IdchA9x33wG/oTSPoc0g4lnMukAtHDaRiuNuGSVB15w8oZuo9NK2c+5AOgqCSNwUDf1K
 +RIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhOxSw9dx5++JDGKiJ7EWiOFDVPqzDBtqs+Ojx2yFpzBcvt2DBVAK1WMvmEXxC9GAScHBT+HMFQvAW@nongnu.org
X-Gm-Message-State: AOJu0YwE+yJh18nbXlRdhG4Ip9xyUe1iMlwj12bLzfvCiZHZ/7DqIMoN
 6y6d/3lFZSFGnGJjjnhM/ZwxOMuPCNYqb/Xe2VPcxweh/RMHMapwQiR41ktjorS/tjVpWg7IUOp
 c
X-Gm-Gg: ASbGncsRItKwpy6PYdkEzZ17rfNMkLjZgzkfoBstxjqwtfBfjOz0FZsZ0TuPWspRbga
 mCql5fgyRcMcKtsZ5j8Yki2lzhPsB7FrberuGzdpeDuF6Uka5qVVb4N1FzKCwLFXq9NH782E/Co
 6LaqaGvS5zxFXis7kEysaVZDNAE1sOEA9PXXl9HgN/2u0UpgxZCaM+ogRc5OFALHe4ZJHxkVG0S
 mRloSGtLIURPyar1AhIIGR2k8jyc/6oHcPwqAHCKUQh6JmWv06zEBL/NcSg+850ooCroAksoEXi
 7V5dRpF8wN1mEwTvA7oiCO9otQ56XLYyKh1lbB57KZ9eGAWqeFFlUHEqDva/J1tb8ySDyOFbXyE
 hDGNGD/USEqSZ6eZPPOJx1TnVCOhVdg==
X-Google-Smtp-Source: AGHT+IGijIlaEW2/jTfVyVs2g8dKxwLrlR1xdkRxN1i1lQZSTdGN/4HPkl4MGs0YIcTWw8/kLab2eg==
X-Received: by 2002:a05:6000:381:b0:391:1139:2653 with SMTP id
 ffacd0b85a97d-39c29807639mr3253263f8f.52.1743627838823; 
 Wed, 02 Apr 2025 14:03:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b79e37bsm18233837f8f.61.2025.04.02.14.03.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:03:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 06/43] target/arm: Restrict SoftMMU mmu_index() to TCG
Date: Wed,  2 Apr 2025 23:02:51 +0200
Message-ID: <20250402210328.52897-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Move arm_cpu_mmu_index() within CONFIG_TCG #ifdef'ry
and expose its prototype in "target/arm/internals.h".
Convert CPUClass::mmu_index() to TCGCPUOps::mmu_index().

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/internals.h   |  1 +
 target/arm/cpu.c         | 13 +++++++------
 target/arm/tcg/cpu-v7m.c |  1 +
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 895d60218e3..01408e40a34 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -374,6 +374,7 @@ void arm_cpu_synchronize_from_tb(CPUState *cs, const TranslationBlock *tb);
 
 /* Our implementation of TCGCPUOps::cpu_exec_halt */
 bool arm_cpu_exec_halt(CPUState *cs);
+int arm_cpu_mmu_index(CPUState *cs, bool ifetch);
 #endif /* CONFIG_TCG */
 
 typedef enum ARMFPRounding {
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f29661938c4..c9e043bc9b5 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -122,6 +122,12 @@ void arm_restore_state_to_opc(CPUState *cs,
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
@@ -145,11 +151,6 @@ static bool arm_cpu_has_work(CPUState *cs)
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
@@ -2675,6 +2676,7 @@ static const TCGCPUOps arm_tcg_ops = {
     .synchronize_from_tb = arm_cpu_synchronize_from_tb,
     .debug_excp_handler = arm_debug_excp_handler,
     .restore_state_to_opc = arm_restore_state_to_opc,
+    .mmu_index = arm_cpu_mmu_index,
 
 #ifdef CONFIG_USER_ONLY
     .record_sigsegv = arm_cpu_record_sigsegv,
@@ -2709,7 +2711,6 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
                                        &acc->parent_phases);
 
     cc->class_by_name = arm_cpu_class_by_name;
-    cc->mmu_index = arm_cpu_mmu_index;
     cc->dump_state = arm_cpu_dump_state;
     cc->set_pc = arm_cpu_set_pc;
     cc->get_pc = arm_cpu_get_pc;
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index c4dd3092726..1a913faa50f 100644
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
2.47.1


