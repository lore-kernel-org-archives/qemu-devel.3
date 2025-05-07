Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576BFC3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoPx-0000Fv-5A; Wed, 07 May 2025 19:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPj-0008NB-C4
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:42:59 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPh-0002UL-2V
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:42:58 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22e3b069f23so4518515ad.2
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661375; x=1747266175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hulB2UBYIXOqzJFKVn1ypmpXSnKnDaK1c4I5WrAN9H8=;
 b=esAvGWxZfn0eFBX0URT0iK612TrIV25UgcXri4GnFQEEnBnzJWNbb0dUSxFVfMF6hz
 XaOM+ddSBq1CUEfM1kKE34qyX79P7nCuFzE5T0dDTNllQlsAXjwA/dO3GAmU+D6zyuVs
 mBipOiPSM1PTNedMiom5zdXvbxgyJHL1gHkOVy8WzK2JVGvM90acFQrkCY/K75GQ7U11
 BzfCHCQZb227UYZlMkWJnYhOxMcBMVv77a7e4kqdt8Wl817Kx/6JAE+rhixqc9CjsWy3
 PKwPEfSUNu7HYUEuR9Xu9GHVTnhdF5Hny8Ek974m+T8iLsODoHz9XHKm26twm0Yut05u
 Ppyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661375; x=1747266175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hulB2UBYIXOqzJFKVn1ypmpXSnKnDaK1c4I5WrAN9H8=;
 b=LC1cvMnichQFjZkgqCDeKFrunnG5CkpszR8JFBXxryioRtXUcAyd4u/Wvy56CK4pNq
 TNIL2VEVVo1lucJxnGfR/afHFktn3ar+fzpdRrCPvfpsln+7+iFjpiED5/B3zb+yl9ij
 MylobwQmhPgAntCP7WHGDA1FcCIREWdq2h4b0qBT6LPXNzW7KjX03Fr7piq+4OKeKzbS
 8jSztYP7Lt1c8g3Pdnos5JGgvwtQPonCSUZGSjwx0wBPHVb7DNWRLnZJLoU0KI1KHZht
 s2cD4eZ8IyvLqDYoH9Bm5CJKq7HLcmn0k6xrhufC3A2OG7ti8RafBbQMSNXpJrJTljiQ
 v6Kg==
X-Gm-Message-State: AOJu0YyHmePA7/WGbganMvQSDDqGaSve5XW+FAIe3jFgoqft0ueFjqac
 dkTEW38I+kpxSlMOp1CEIdhkACW6XsCEgm19uXuDfcs/qntKKqAicoTEBL1z5kICSO7GeTCDq/b
 nMNX3hQ==
X-Gm-Gg: ASbGncvOCSnV3nnoyaVmcXlU4oZ4Icwua0fVZvXknjOo0eQ3Sd6PAQHBofD7SyT6X5S
 2s7/swkDkRIzD4rh8iPQVzL8ycFFfR8zGN+W7BxD/FDVBN91uTf1gbsvIUP+u76HflFNu/efMz8
 0+ifj904dQTYZ05pbBvP3s61c61mcYXf+gsES48dL++r//6Sm0G95AmcSs2jZvRKonvDv9u4R90
 QIdRUtt0u5ExRgU1NgDvW26YfyH5Rmh037gQ1yCDfCYHXfGZaxAJ4AugJ1HBJ4VtOmeCzNR1XU9
 VMxPV39UbnUin1D7PJrLmwdduFw5M1gOQfneD7yX
X-Google-Smtp-Source: AGHT+IG0668HnujjOop4MRhdufku9w1ExNwRIuz4QjwGB7uvWhg2Mg9/z3MDPW/4Cc15wrPc+nQsvg==
X-Received: by 2002:a17:902:daca:b0:223:5379:5e4e with SMTP id
 d9443c01a7336-22e5ea70aedmr96307875ad.10.1746661375655; 
 Wed, 07 May 2025 16:42:55 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e815806fdsm6491325ad.17.2025.05.07.16.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:42:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 14/49] target/arm/helper: use vaddr instead of target_ulong
 for exception_pc_alignment
Date: Wed,  7 May 2025 16:42:05 -0700
Message-ID: <20250507234241.957746-15-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/helper.h            | 2 +-
 target/arm/tcg/tlb_helper.c    | 2 +-
 target/arm/tcg/translate-a64.c | 2 +-
 target/arm/tcg/translate.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 09075058391..95b9211c6f4 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -49,7 +49,7 @@ DEF_HELPER_3(exception_with_syndrome, noreturn, env, i32, i32)
 DEF_HELPER_4(exception_with_syndrome_el, noreturn, env, i32, i32, i32)
 DEF_HELPER_2(exception_bkpt_insn, noreturn, env, i32)
 DEF_HELPER_2(exception_swstep, noreturn, env, i32)
-DEF_HELPER_2(exception_pc_alignment, noreturn, env, tl)
+DEF_HELPER_2(exception_pc_alignment, noreturn, env, vaddr)
 DEF_HELPER_1(setend, void, env)
 DEF_HELPER_2(wfi, void, env, i32)
 DEF_HELPER_1(wfe, void, env)
diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 5ea4d6590f2..d9e6c827d43 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -276,7 +276,7 @@ void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
     arm_deliver_fault(cpu, vaddr, access_type, mmu_idx, &fi);
 }
 
-void helper_exception_pc_alignment(CPUARMState *env, target_ulong pc)
+void helper_exception_pc_alignment(CPUARMState *env, vaddr pc)
 {
     ARMMMUFaultInfo fi = { .type = ARMFault_Alignment };
     int target_el = exception_target_el(env);
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 52cf47e775f..ac80f572a2d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10242,7 +10242,7 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
          * start of the TB.
          */
         assert(s->base.num_insns == 1);
-        gen_helper_exception_pc_alignment(tcg_env, tcg_constant_tl(pc));
+        gen_helper_exception_pc_alignment(tcg_env, tcg_constant_vaddr(pc));
         s->base.is_jmp = DISAS_NORETURN;
         s->base.pc_next = QEMU_ALIGN_UP(pc, 4);
         return;
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index e773ab72685..9962f43b1d0 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -7791,7 +7791,7 @@ static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
          * be possible after an indirect branch, at the start of the TB.
          */
         assert(dc->base.num_insns == 1);
-        gen_helper_exception_pc_alignment(tcg_env, tcg_constant_tl(pc));
+        gen_helper_exception_pc_alignment(tcg_env, tcg_constant_vaddr(pc));
         dc->base.is_jmp = DISAS_NORETURN;
         dc->base.pc_next = QEMU_ALIGN_UP(pc, 4);
         return;
-- 
2.47.2


