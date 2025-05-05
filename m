Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A62FC3ABC0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:26:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC57C-0006RX-Lz; Mon, 05 May 2025 19:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC570-0006GF-18
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:38 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC56x-0003Z9-II
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:37 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22e331215dbso2997325ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487234; x=1747092034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4MSVLYsQ1aHRPUMsqKWeWNfiw/1OBObe6XUOYFWrKME=;
 b=TNgQvKH/fC9T7SCveW6dEBx0/aj3FHXZzEttTEp8SBkqEe2UaoV8FhfpOFfrKeDz5a
 V0nto/+/5JNSG7TwEKPJ+BwvS9E3/ko9cRlQLprdCxf04hy+3LKYtqkxbRNGscQ0Udo0
 a7ktarBNc04fnciUNJ6S4/RoH74uYEyqOcXufAVJu43HAqpjEtdOn1kj6G+lk1VvgnPo
 x111jJiTYP3b1gr34LAtRMvqRCt+w7B/iw7Nhlwj2dmEVeMWdhp7k472hXF5NNi5AbJL
 34Re2i8maj43tvXOUZBMY0qX8JF1Zr+rwiZMtwHcN3SRyuVAV5j9ydP1l+ALGgtKcdMJ
 rlhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487234; x=1747092034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4MSVLYsQ1aHRPUMsqKWeWNfiw/1OBObe6XUOYFWrKME=;
 b=cTr1+BS0Lvv1qqCPVqfT42lYcUquEIb+uW/yQpgGJVutNP7IMV6sir4Z/zk4IbB80D
 mr1H/Wx2iN0ERgFYtrmbwjVkQwgyagJM5FE7fNCKFBT75dLO0vPS0YnxyaO7NPwQxuk9
 RJfM8hkPxA2Z4OYemCEjhk8skxR/da4Zu4OAm5D8J3B3n9qKzPEr7XViFaHyDBkRb6D8
 GXmv1cgt8NLMiB4P+6J8lI14SF+dUCzjoc+ryML58uMwc3GSua1eo+ufZoHEHtUuHI9K
 fhrOXsifrBuY7eMXoPnUmwLwYRJJ/6LEbudwG+c/xDEqph9HkKiTnDBlm3bBF1lP3XbR
 RlTA==
X-Gm-Message-State: AOJu0YwvpQi8KEPnRVuyCgjwmClStXaYcc5sZYvEFTuxRyDaBx4ewfJ1
 OmIAczF/wAI06WFQJXF5CSXSZ3KiFIpZraSRJWoCQXvBtmyuumwplwBq5Jl798TlBVrd4lDnoJ2
 JYQo=
X-Gm-Gg: ASbGnctYujs8pb3Vs2fOX+DaEbV94RherhXtg6IRTo6/ZS1O96Pdyazl30XzLskrGFp
 boAF3NhUOjcB5vQYbbB4i7xB6rjQMNZFujIuEtAXD8NStygo5h10wylWgSbBpNXsiIWzj2cru7m
 aUknLeO43bA1f0GTUwhuXeUeYsuqeOGXAdl9vR1PoDrHxXZ/6dgf9zWG9Ue0yjfewfGPyp4FkKl
 syXiOxm4NT33VDb4y/I2gruQ/jQkcOCsz3Lsu6qguc6/WzyAZDQQY6vXL2oJLAduL/HPFWSdF+d
 VO7P8XwXeuXVm1RZZ+aGaBPwANgrSMN4V3CJqpQs
X-Google-Smtp-Source: AGHT+IHTINwaey7ySLvXtg1QPxU98WusV/OE2FldyD8VBKMIteaxM9KIYsWwhG915qemWBZmFL73qA==
X-Received: by 2002:a17:903:906:b0:215:a303:24e9 with SMTP id
 d9443c01a7336-22e31f7e424mr17270675ad.3.1746487233916; 
 Mon, 05 May 2025 16:20:33 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522917asm60981715ad.201.2025.05.05.16.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:20:33 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 15/50] target/arm/helper: use vaddr instead of target_ulong
 for exception_pc_alignment
Date: Mon,  5 May 2025 16:19:40 -0700
Message-ID: <20250505232015.130990-16-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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
index 8841f039bc6..4e3e96a2af0 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -277,7 +277,7 @@ void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
     arm_deliver_fault(cpu, vaddr, access_type, mmu_idx, &fi);
 }
 
-void helper_exception_pc_alignment(CPUARMState *env, target_ulong pc)
+void helper_exception_pc_alignment(CPUARMState *env, vaddr pc)
 {
     ARMMMUFaultInfo fi = { .type = ARMFault_Alignment };
     int target_el = exception_target_el(env);
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d9305f9d269..4f94fe179b0 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10243,7 +10243,7 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
          * start of the TB.
          */
         assert(s->base.num_insns == 1);
-        gen_helper_exception_pc_alignment(tcg_env, tcg_constant_tl(pc));
+        gen_helper_exception_pc_alignment(tcg_env, tcg_constant_vaddr(pc));
         s->base.is_jmp = DISAS_NORETURN;
         s->base.pc_next = QEMU_ALIGN_UP(pc, 4);
         return;
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 88df9c482ab..99f07047fe5 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -7790,7 +7790,7 @@ static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
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


