Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E283CD11DB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbf1-0002OO-90; Tue, 19 Mar 2024 11:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbeT-0001UJ-Hr
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:45:22 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbeN-0005gh-Ex
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:45:21 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3417a3151c4so1615948f8f.3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 08:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710863113; x=1711467913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UywTiyuwpzYSJP7ec90xP7SAWTKz8NCufjjlUtL7sy8=;
 b=VhvMKZ00oWQCsZlXDW+CDjJhc+7HBvAAuL6u++pQTXOZS25GtXqAHUNqbv3W2yGeaH
 8a5299KXs/HOHHuCh9xkuffcmnIP+jTfFQm2SxygBezDnvohumbyBbASnRzIa4dZ6GRv
 23zDdDyRAurinokrGNwRTY+mqimy2BLhn2x2Sf5XAzUsO/r9PyTGyKBQb+iIPIxcORx7
 iqBS1icQtaL3gA3AH2j/0+lyyFtqBOzNfs5SEHM9IgkUBgL+EEdgGg9ygcMkQzcqKOy3
 YHA8T8JC5Es5TdjBI9FVYbpKwyiVAzYCR8DVk53ZwhqWKLr08HHrBWOOLYb48aRGbrtZ
 DqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710863113; x=1711467913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UywTiyuwpzYSJP7ec90xP7SAWTKz8NCufjjlUtL7sy8=;
 b=E3hG9DxPqruKzLJtg4hpz8qKvwzzpn9kJgh+/HPSDznd/LhOSj+hRBnRul7LRGqWZn
 KItKXKeaKj+FJH+9l6z9vV7SU29BaJguIewekgW1LeALjJe8p0vSrcZ0yy0/wGvwpm4n
 WUJ1+NK/M3/MLyMTuc9s4vALUKrvICUloDTiq5LIvavuaXngFKle2X6URznMba4IcQyT
 tkTURPCEYKqky2Kuqu69UnZ4JyVoagtEDEhfELFQJXV+n2P3bKF3bjqkTapVCZIXHgh9
 5ntZ859Rh8tbf8bwgLte6JwhATfobpWg5Ox/qepVc3tbScsl5joRYUOsUvRaX2CWKeav
 l/Mg==
X-Gm-Message-State: AOJu0YyCsVgBEcTyyN4uRU+CBsA457pN/G2ie+Kzy1RvN21l/XwsPa/0
 A2FUerh9kMocFsVRjWFRHwwOtqsc2TTyJaXdhQekzDuFopg4Ct5clSacrbhgaFt3z7jg0djibhy
 t
X-Google-Smtp-Source: AGHT+IEmip1MVKVeiZMVEKE7LKBDm7eOgl8lmI6hh/So6qEffNSULV57GRBPBP4W4X4Z2Y5NYU9Wkw==
X-Received: by 2002:adf:f3c2:0:b0:33e:bb67:9596 with SMTP id
 g2-20020adff3c2000000b0033ebb679596mr11018901wrp.64.1710863113462; 
 Tue, 19 Mar 2024 08:45:13 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 o9-20020adfe809000000b0033ec6ebf878sm12573736wrm.93.2024.03.19.08.45.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 Mar 2024 08:45:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH-for-9.1 23/27] target/sh4: Convert to
 TCGCPUOps::get_cpu_state()
Date: Tue, 19 Mar 2024 16:42:52 +0100
Message-ID: <20240319154258.71206-24-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240319154258.71206-1-philmd@linaro.org>
References: <20240319154258.71206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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
 target/sh4/cpu.h | 15 ---------------
 target/sh4/cpu.c | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 9211da6bde..36aff035cf 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -370,19 +370,4 @@ static inline void cpu_write_sr(CPUSH4State *env, target_ulong sr)
     env->sr = sr & ~((1u << SR_M) | (1u << SR_Q) | (1u << SR_T));
 }
 
-static inline void cpu_get_tb_cpu_state(CPUSH4State *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    *pc = env->pc;
-    /* For a gUSA region, notice the end of the region.  */
-    *cs_base = env->flags & TB_FLAG_GUSA_MASK ? env->gregs[0] : 0;
-    *flags = env->flags
-            | (env->fpscr & TB_FLAG_FPSCR_MASK)
-            | (env->sr & TB_FLAG_SR_MASK)
-            | (env->movcal_backup ? TB_FLAG_PENDING_MOVCA : 0); /* Bit 3 */
-#ifdef CONFIG_USER_ONLY
-    *flags |= TB_FLAG_UNALIGN * !env_cpu(env)->prctl_unalign_sigbus;
-#endif
-}
-
 #endif /* SH4_CPU_H */
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 4f5a4a3d98..9b2b377e29 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -67,6 +67,21 @@ static void superh_restore_state_to_opc(CPUState *cs,
      */
 }
 
+static void sh4_get_cpu_state(CPUSH4State *env, vaddr *pc,
+                              uint64_t *cs_base, uint32_t *flags)
+{
+    *pc = env->pc;
+    /* For a gUSA region, notice the end of the region.  */
+    *cs_base = env->flags & TB_FLAG_GUSA_MASK ? env->gregs[0] : 0;
+    *flags = env->flags
+             | (env->fpscr & TB_FLAG_FPSCR_MASK)
+             | (env->sr & TB_FLAG_SR_MASK)
+             | (env->movcal_backup ? TB_FLAG_PENDING_MOVCA : 0); /* Bit 3 */
+#ifdef CONFIG_USER_ONLY
+    *flags |= TB_FLAG_UNALIGN * !env_cpu(env)->prctl_unalign_sigbus;
+#endif
+}
+
 #ifndef CONFIG_USER_ONLY
 static bool superh_io_recompile_replay_branch(CPUState *cs,
                                               const TranslationBlock *tb)
@@ -250,6 +265,7 @@ static const TCGCPUOps superh_tcg_ops = {
     .initialize = sh4_translate_init,
     .synchronize_from_tb = superh_cpu_synchronize_from_tb,
     .restore_state_to_opc = superh_restore_state_to_opc,
+    .get_cpu_state = sh4_get_cpu_state,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = superh_cpu_tlb_fill,
-- 
2.41.0


