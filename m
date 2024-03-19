Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E69CD11BF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbe7-00087H-LX; Tue, 19 Mar 2024 11:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbdj-0006vJ-4D
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:44:35 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbdY-00059L-GT
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:44:34 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d46d729d89so75978801fa.3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 08:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710863056; x=1711467856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lFh6leBQNpipJMM3/s/OcU4SdyeufSpSeMnLPrJ3AQ8=;
 b=yj9osDfrqU7QkCrwjP9VCRrr8Ab0rydLLrs/1x9FJjBFXuQ0PXMVDlL6Q6DF36F8sA
 TR39483s33mOuLK3ctZR3dSV5E7yVGOSe/9FXHdFrQPYUkY1KK+dGQpo02kwRIMeZkc+
 gTZuuOZ4T0G2Nfu744qXzsUPoGhWxWqR7EM6xiZWG57TIpDqO4ou9ezkotyYN3VjXnmQ
 mWK38+r+43Itli9Twlb39WZywFwGNjoUkuoDTvW3E2Ieu0WWHhl9VofoDcXIqz1I8TgL
 D/58Y6BG8jw+dkr5kG63Lpjrbt574my5/8OORefyGYvph9ytAii2KxRsvxOKwXDS4bW/
 6W2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710863056; x=1711467856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lFh6leBQNpipJMM3/s/OcU4SdyeufSpSeMnLPrJ3AQ8=;
 b=nGzDyBJCKSlgWJgAYdjEswBIJzusvf1uELbV27yf/wduoGiFIRk4tsDysy/0GUACpp
 A3bVZ7WQapGy3AEo1rAymdOz3zbe9qaaG7vB9AUWCJARBnjn7xhFArpvxtJMZFaSagXW
 MryO6bOxptHuY9VFNuTKt4q8hUimo0G/uC5eCysIA8vEooQsFjc0/jdHSk0tPpe5188Q
 K9NKDRlwOQaEh/oDRcjYCJM2lP7h7PW1oBaxhNtJS6PvBtwdukZMEZQWQkhMFodHwSIx
 x3vjR5hqvNgGH1o8vdIsUtHdQ9AO9nUlEH/Yval19dF/CsNGDgzIODfO7hghVgUktYGn
 3gkg==
X-Gm-Message-State: AOJu0YzRQwATnbcEqaVUCrwZRRZe5SITOL1hSiWnAFgpKme5nHBhImQX
 5SH5YtiCH+uc488eYlFNi7214WA9VdB7svz83twkRV5iwQdBtmHHoODdiox3sXQWzGFvXV0wqtJ
 Q
X-Google-Smtp-Source: AGHT+IGyDqHbLMvC9xHaQRruEUp1XZ2HhTDXxTLlkSOTif8NPbbufMK+mX1HlR0dTgYLfljinJdY0A==
X-Received: by 2002:a2e:9653:0:b0:2d3:1bd0:6bcf with SMTP id
 z19-20020a2e9653000000b002d31bd06bcfmr9018846ljh.8.1710863056510; 
 Tue, 19 Mar 2024 08:44:16 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 g7-20020a05600c310700b0041465879011sm2205757wmo.12.2024.03.19.08.44.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 Mar 2024 08:44:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH-for-9.1 13/27] target/microblaze: Convert to
 TCGCPUOps::get_cpu_state()
Date: Tue, 19 Mar 2024 16:42:42 +0100
Message-ID: <20240319154258.71206-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240319154258.71206-1-philmd@linaro.org>
References: <20240319154258.71206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Convert cpu_get_tb_cpu_state() to TCGCPUOps::get_cpu_state().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/cpu.h | 10 ----------
 target/microblaze/cpu.c |  9 +++++++++
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 8058dcac7f..956269250c 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -415,16 +415,6 @@ void mb_tcg_init(void);
 /* Ensure there is no overlap between the two masks. */
 QEMU_BUILD_BUG_ON(MSR_TB_MASK & IFLAGS_TB_MASK);
 
-#define TARGET_HAS_CPU_GET_TB_CPU_STATE
-
-static inline void cpu_get_tb_cpu_state(CPUMBState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    *pc = env->pc;
-    *flags = (env->iflags & IFLAGS_TB_MASK) | (env->msr & MSR_TB_MASK);
-    *cs_base = (*flags & IMM_FLAG ? env->imm : 0);
-}
-
 #if !defined(CONFIG_USER_ONLY)
 bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                      MMUAccessType access_type, int mmu_idx,
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 96c2b71f7f..ded4c7a0de 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -113,6 +113,14 @@ static void mb_restore_state_to_opc(CPUState *cs,
     cpu->env.iflags = data[1];
 }
 
+static void mb_get_cpu_state(CPUMBState *env, vaddr *pc,
+                             uint64_t *cs_base, uint32_t *flags)
+{
+    *pc = env->pc;
+    *flags = (env->iflags & IFLAGS_TB_MASK) | (env->msr & MSR_TB_MASK);
+    *cs_base = (*flags & IMM_FLAG ? env->imm : 0);
+}
+
 static bool mb_cpu_has_work(CPUState *cs)
 {
     return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
@@ -408,6 +416,7 @@ static const TCGCPUOps mb_tcg_ops = {
     .initialize = mb_tcg_init,
     .synchronize_from_tb = mb_cpu_synchronize_from_tb,
     .restore_state_to_opc = mb_restore_state_to_opc,
+    .get_cpu_state = mb_get_cpu_state,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = mb_cpu_tlb_fill,
-- 
2.41.0


