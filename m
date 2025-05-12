Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B410C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXXP-0003IE-7s; Mon, 12 May 2025 14:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWq-0002RT-D4
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:30 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWo-0008Uz-BJ
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:27 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22e4db05fe8so43638045ad.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073124; x=1747677924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hulB2UBYIXOqzJFKVn1ypmpXSnKnDaK1c4I5WrAN9H8=;
 b=AfD2JiyeBAncqEpaEV+eqm5xVoAxKXQIEo/4veHNVClgvDNEmc/iXy+/6ijJIrLFuZ
 0Xs54b+mZPIdQRw179oL8qF8F7KVxARzW+BRGSciLlh7iiQd+6E8DoVFd5aa5j7pSUZz
 /UwQL9HxlXsp9pvqsup8ask+9gBumnbrWgHSDq46Zb7idC5Zp8bgx7YQw7JWfHki+JZV
 W5PRwSWDii1bvGuyrVrBtQE0t0Vck/sMt4KgiHybyLv046U1vTLOPcpZ1DmarkkawGjt
 sdmy/vRyhkYwECfxNsz0AvBY4fO+cGPdSdzJW0zqcNH6+BUdRd951YW0GQUEmQEVMtZM
 m0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073124; x=1747677924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hulB2UBYIXOqzJFKVn1ypmpXSnKnDaK1c4I5WrAN9H8=;
 b=ZcrPZ7qcXTp9RnIaWS4cZRvz0zgBafkWzsZfKua8Z7Fm1k/fUIvbG6WNm0UGbaf7ET
 jRDvonFtv6iKHNx3d9+301IhNwbTEZJJNT0A9NIotN/idRMoEAR+L4if4i3oIvylkkLE
 kKJjAvWlGFpyNFAlQVBbZjZ6hwLyym4JKx6oPcDLhCv9yknw07SVsvv53gpJ7ESEO8cA
 trmoGAvvlT71PrJoBk397mLi5szY2SvR1eseEV47vlOXnVFQrSDqoW4dO9YYrC7fs3sh
 hzQeYkuLQq6JkzYoRzjW5nILrXhmuqxod1mR64L2kgtwYOXtRW2ZkWIfNJcsD4Ba7VvC
 0eJQ==
X-Gm-Message-State: AOJu0YyvJNVaNS7HR5I2jzuISAFM/+uStfnBzzYnsbVooILu1I+7KLrN
 akcdM9HFNb1OMEllbjhKT3B1reDLyfEgklsCmUhebR28G2SHD796cnVJ05q5OedvivV0Zmktc7D
 m
X-Gm-Gg: ASbGncujqd9NMbNx7jOsBJCVtUSPaQzaslEVq3jqUDBIra+AkfvgesPv7z9CqgDVkDL
 rB8vDTrTq2CdNd7Y4a9leLo9ii8r+Ub3F+en6IhiqYchwkVO5+WH7ArNlEWCO+T8niKXYZfYZtS
 Svs7H6OAmKo2Y0yyXuqw7T3v1VjhCJXtiHytK2Otg5p8ybiHPKS+Dkbxw/L309itdXXBMQPiYIT
 1LRHOZl2ouU8/IhtXBD8RamPXKPLt7AX+0Nb1fiSjE41CrmnKGR41ypTjftclxlOeJheEpQ21CQ
 C0cCrA0ewIrkAMINi+epO53+v68gSCi/sU8mw79s7E8dnix/ADo=
X-Google-Smtp-Source: AGHT+IGwq1tKRijfOMpNf6jcDnCb5CsbqOkXM1HmtY5XbufEcxIBy7HmQc4p5cmL1ZbzIfEVQPoTSg==
X-Received: by 2002:a17:903:3ba3:b0:220:ca08:8986 with SMTP id
 d9443c01a7336-22fc8b3e338mr213945315ad.22.1747073123534; 
 Mon, 12 May 2025 11:05:23 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:23 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 13/48] target/arm/helper: use vaddr instead of target_ulong
 for exception_pc_alignment
Date: Mon, 12 May 2025 11:04:27 -0700
Message-ID: <20250512180502.2395029-14-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
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


