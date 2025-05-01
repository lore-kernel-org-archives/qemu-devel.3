Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70E9C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uANLZ-0005Qo-72; Thu, 01 May 2025 02:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANL6-0005C6-38
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:11 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANL2-000790-Is
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:07 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b13e0471a2dso474694a12.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 23:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746080643; x=1746685443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eC/HRV8/2d4cTcu2Y+L56bEld1xnVZxGu+at/3yGTOk=;
 b=cnjS+hMGYISUN0F6uf+LWWzI+cP96/oI7IJX+zDZxna/RbBmKbBRmi7p7mr81Warlm
 /gsUvWzmJDI+XbvpR1OnE1gifDLTO+vxDJ7Lv9HCIbWXnujcM846kC6f6xAq1XDwTFvq
 oZcIA4j2RTqrvtJAVCpR9hY3SsBtII84ij3gWrMPtciERSsSSQEdAJaKcrUEspZQgud+
 SDuNNIj4WXuc2nlziw4nIipK0npHMARZgiVxeOkzhPQ9lq2GVkXpqlLOckjt/Pu1zM5W
 AMFCtHCuIq2RKJRg6xJ7TGlfH/wzGorMgOX6N1t8we3wva4kCR5531/k8jAmIgXyzgqY
 /c+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746080643; x=1746685443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eC/HRV8/2d4cTcu2Y+L56bEld1xnVZxGu+at/3yGTOk=;
 b=jT2T7YfT6hcHjJVVnwbr4fzJfvBep4B6dOy/z5Jui209q84392MI7/6Rc5ARcdL2PZ
 m39+O6bAHvaO5K8YM7dA6s22/vzOUdiEWckzfkE0heOJ2g3YQ1Rbg6WD5z2M2qUM7Fu3
 siN9M459ofsaYHNAY2noZtcTtI7WUtFVu/7/fwURG+yZLvn4HxeFPq2HG9WB33d98iU/
 Ap6M2WyVzCINlC8HAFumO+Ods6rcN8GS9VBebQhM1VWI9fFvXgOJt+hV/laIZwIYqeBk
 A+skFx3YBtWEAo800x/YDV+Rd/jTltNTiIY0GnadblgwNCLawxaMhvm6HYAbJApvj0aF
 CEfg==
X-Gm-Message-State: AOJu0YwYOpoC5dxaK05tjmiyEm4XaF/eptLl18LwkShNs3+Lkgy+I3sF
 1WDMrUzVDYqJtZ52Sx25osYfLc72CpjSRagcoQN0D5rBItmzNyQhBcFIrsiJMC6QH8kukgFLL/k
 G
X-Gm-Gg: ASbGncsqIdaBW5oFy0pIFC5BX7TUoBau/ONGmF1ONRHOK9YHpyghrLX2t9e683dM63L
 k/bmWxljkKU94ROSQoezkX0X9aCyZD/34poV/DH/Dx3W6cxR+gFDO4UqJiGraxIG0p/N16EOOxT
 VzRhW1nOF0v/8eDaSc3lajOFw+jJ8JnjTKu6eghOPi632xB91ogqR6y/rFKAp4Ibx/pYuTPGtMb
 14451PfXFcO3b/sf+Mu226FQwJ4KBB66CrA9t1758I7VpiZGrr9s2cye+CteBiDqtheDSakfwjd
 TMIAs02jVhiW6eV9iN/Ql9JocCLdFUtmnCDofQKB
X-Google-Smtp-Source: AGHT+IHB80u1428PHxy6JDVfoTMR3OZQ1FT85u62QQ1lo3XoiXyKZwox+P7tK2iUDXZ/GGwXnMlKuw==
X-Received: by 2002:a05:6a21:600c:b0:1f5:8f65:a6f5 with SMTP id
 adf61e73a8af0-20ba8789a2dmr2995051637.30.1746080643013; 
 Wed, 30 Apr 2025 23:24:03 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404f9fed21sm108134b3a.93.2025.04.30.23.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 23:24:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 13/33] target/arm/helper: use i64 for exception_pc_alignment
Date: Wed, 30 Apr 2025 23:23:24 -0700
Message-ID: <20250501062344.2526061-14-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/helper.h            | 2 +-
 target/arm/tcg/tlb_helper.c    | 2 +-
 target/arm/tcg/translate-a64.c | 2 +-
 target/arm/tcg/translate.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 09075058391..450c9d841bf 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -49,7 +49,7 @@ DEF_HELPER_3(exception_with_syndrome, noreturn, env, i32, i32)
 DEF_HELPER_4(exception_with_syndrome_el, noreturn, env, i32, i32, i32)
 DEF_HELPER_2(exception_bkpt_insn, noreturn, env, i32)
 DEF_HELPER_2(exception_swstep, noreturn, env, i32)
-DEF_HELPER_2(exception_pc_alignment, noreturn, env, tl)
+DEF_HELPER_2(exception_pc_alignment, noreturn, env, i64)
 DEF_HELPER_1(setend, void, env)
 DEF_HELPER_2(wfi, void, env, i32)
 DEF_HELPER_1(wfe, void, env)
diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 8841f039bc6..943b8438fc7 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -277,7 +277,7 @@ void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
     arm_deliver_fault(cpu, vaddr, access_type, mmu_idx, &fi);
 }
 
-void helper_exception_pc_alignment(CPUARMState *env, target_ulong pc)
+void helper_exception_pc_alignment(CPUARMState *env, uint64_t pc)
 {
     ARMMMUFaultInfo fi = { .type = ARMFault_Alignment };
     int target_el = exception_target_el(env);
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 43408c71bbd..2fe8ada803a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10247,7 +10247,7 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
          * start of the TB.
          */
         assert(s->base.num_insns == 1);
-        gen_helper_exception_pc_alignment(tcg_env, tcg_constant_tl(pc));
+        gen_helper_exception_pc_alignment(tcg_env, tcg_constant_i64(pc));
         s->base.is_jmp = DISAS_NORETURN;
         s->base.pc_next = QEMU_ALIGN_UP(pc, 4);
         return;
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 273b860d572..1577ef697b2 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -7801,7 +7801,7 @@ static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
          * be possible after an indirect branch, at the start of the TB.
          */
         assert(dc->base.num_insns == 1);
-        gen_helper_exception_pc_alignment(tcg_env, tcg_constant_tl(pc));
+        gen_helper_exception_pc_alignment(tcg_env, tcg_constant_i64(pc));
         dc->base.is_jmp = DISAS_NORETURN;
         dc->base.pc_next = QEMU_ALIGN_UP(pc, 4);
         return;
-- 
2.47.2


