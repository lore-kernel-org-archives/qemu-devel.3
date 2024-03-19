Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D040FCD11BF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbeU-0001Sl-O1; Tue, 19 Mar 2024 11:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbeO-0001Cd-Jf
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:45:16 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbeH-0005eP-Kt
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:45:16 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-41409fd8b6bso22694175e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 08:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710863108; x=1711467908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=obVPvpYss9xjXntv+zHtCP4dsVUmvSV/g5EeFxAwv28=;
 b=JEDll7kW8NCROw2F/aJWV6dWwlRhSVzzg2Kuv9ZIBGZKFQt/hV9MpxxV6mvDcn9K3q
 T92fMeK/XBV6e6ZYre6UEx7oRoz4k+qJSnxUUZfWttUk95ZGo9rHsmTHB0K2rG8vG2uL
 6yS61X85xMyGYkyqUxOhoYsOH5LRLFLlZ4km6T7UCbR5NK/rfXAx7FdWSfrzmb1ZvTcg
 pg6UkgJvDN3LlBlYuSeq33dC0VKgKMzTNKEraAgMv9YMybG9KL2KzT5ywHTR13aZsAuI
 8EFnYF14YEQ5c+oxAEx7ZWTz4J4kKdGHLe0mBVmrqUT0UA+Q7aVFNsNLm2lA6yDKbM/F
 O70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710863108; x=1711467908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=obVPvpYss9xjXntv+zHtCP4dsVUmvSV/g5EeFxAwv28=;
 b=Cy59xi1riFde/JCSGQVi7vg4z9E1s+shTWwL+CMrhep8s5o6MDfiqWIhhaMHiDDrrM
 7ClOTrsmNBICOJvrGcGlbuMqsd4X/xKXVsbJkccfK6niuYqA2HxMrwwJZ1ZgDme/Jov3
 n6+tICrKftqDhE3rGCUIGu77i2w4bjqiR0cL9cyDN8Jf06LhQwUMflvn7s5FEOV9Ytti
 7ZlJFxeR10OlSod6XIPTLQ5PxAS5dQlyJzkhAdZy7BStvczd5nYunnf+Pu/PjSFLr/oQ
 T+kaEyBcivm738hLm51mJdyMl+oRVUKp9kY98E8BI5HEIG3Yu+7e9dTM0cQB0dNbqe/Y
 pAwg==
X-Gm-Message-State: AOJu0Yy6ja2wdGgPyX/wTmAYaBKmDqbj0nuBfxF/Y3Yk3Q0W0f7oDY+G
 3g8DLLJD/F3/WdOhxGCzaVM9s4gkTPgiXDaAz3wwERsis/bNrM67vjOmtaRFo+jhVxziuSZQKq4
 r
X-Google-Smtp-Source: AGHT+IGAPpsVFRMXwyGR6AHHpUgvaLHwCY/rNd2n9r5LxZzbL23U8tDx92dVOHvVdGDrG0f8eCMeyg==
X-Received: by 2002:adf:fe0d:0:b0:33e:96c1:3da6 with SMTP id
 n13-20020adffe0d000000b0033e96c13da6mr9902776wrr.65.1710863107848; 
 Tue, 19 Mar 2024 08:45:07 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 v2-20020a5d59c2000000b0033e7503ce7esm6748445wry.46.2024.03.19.08.45.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 Mar 2024 08:45:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH-for-9.1 22/27] target/s390x: Convert to
 TCGCPUOps::get_cpu_state()
Date: Tue, 19 Mar 2024 16:42:51 +0100
Message-ID: <20240319154258.71206-23-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240319154258.71206-1-philmd@linaro.org>
References: <20240319154258.71206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Note, now s390x_get_cpu_state() is restricted to TCG.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/cpu.h            | 30 ------------------------------
 target/s390x/s390x-internal.h |  2 ++
 target/s390x/cpu.c            |  1 +
 target/s390x/tcg/mem_helper.c |  2 +-
 target/s390x/tcg/translate.c  | 23 +++++++++++++++++++++++
 5 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 2e184aabf5..c84ab43928 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -412,36 +412,6 @@ static inline int s390x_env_mmu_index(CPUS390XState *env, bool ifetch)
 #endif
 }
 
-#ifdef CONFIG_TCG
-
-#include "tcg/tcg_s390x.h"
-
-#define TARGET_HAS_CPU_GET_TB_CPU_STATE
-
-static inline void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    if (env->psw.addr & 1) {
-        /*
-         * Instructions must be at even addresses.
-         * This needs to be checked before address translation.
-         */
-        env->int_pgm_ilen = 2; /* see s390_cpu_tlb_fill() */
-        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, 0);
-    }
-    *pc = env->psw.addr;
-    *cs_base = env->ex_value;
-    *flags = (env->psw.mask >> FLAG_MASK_PSW_SHIFT) & FLAG_MASK_PSW;
-    if (env->cregs[0] & CR0_AFP) {
-        *flags |= FLAG_MASK_AFP;
-    }
-    if (env->cregs[0] & CR0_VECTOR) {
-        *flags |= FLAG_MASK_VECTOR;
-    }
-}
-
-#endif /* CONFIG_TCG */
-
 /* PER bits from control register 9 */
 #define PER_CR9_EVENT_BRANCH           0x80000000
 #define PER_CR9_EVENT_IFETCH           0x40000000
diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index 559c9f561d..f9796c2742 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -403,6 +403,8 @@ void s390x_translate_init(void);
 void s390x_restore_state_to_opc(CPUState *cs,
                                 const TranslationBlock *tb,
                                 const uint64_t *data);
+void s390x_get_cpu_state(CPUS390XState *env, vaddr *pc,
+                         uint64_t *cs_base, uint32_t *flags);
 #endif /* CONFIG_TCG */
 
 /* sigp.c */
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index f7194534ae..afade52b76 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -327,6 +327,7 @@ static void s390_cpu_reset_full(DeviceState *dev)
 static const TCGCPUOps s390_tcg_ops = {
     .initialize = s390x_translate_init,
     .restore_state_to_opc = s390x_restore_state_to_opc,
+    .get_cpu_state = s390x_get_cpu_state,
 
 #ifdef CONFIG_USER_ONLY
     .record_sigsegv = s390_cpu_record_sigsegv,
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 557831def4..e1d0133439 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -2391,7 +2391,7 @@ uint64_t HELPER(lra)(CPUS390XState *env, uint64_t r1, uint64_t addr)
    it does not change the program counter.
 
    Perform this by recording the modified instruction in env->ex_value.
-   This will be noticed by cpu_get_tb_cpu_state and thus tb translation.
+   This will be noticed by s390x_get_cpu_state and thus tb translation.
 */
 void HELPER(ex)(CPUS390XState *env, uint32_t ilen, uint64_t r1, uint64_t addr)
 {
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 0d0c672c95..bf8d00ecef 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -44,6 +44,7 @@
 #include "exec/translator.h"
 #include "exec/log.h"
 #include "qemu/atomic128.h"
+#include "tcg_s390x.h"
 
 #define HELPER_H "helper.h"
 #include "exec/helper-info.c.inc"
@@ -6569,3 +6570,25 @@ void s390x_restore_state_to_opc(CPUState *cs,
     /* Record ILEN.  */
     env->int_pgm_ilen = data[2];
 }
+
+void s390x_get_cpu_state(CPUS390XState *env, vaddr *pc,
+                         uint64_t *cs_base, uint32_t *flags)
+{
+    if (env->psw.addr & 1) {
+        /*
+         * Instructions must be at even addresses.
+         * This needs to be checked before address translation.
+         */
+        env->int_pgm_ilen = 2; /* see s390_cpu_tlb_fill() */
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, 0);
+    }
+    *pc = env->psw.addr;
+    *cs_base = env->ex_value;
+    *flags = (env->psw.mask >> FLAG_MASK_PSW_SHIFT) & FLAG_MASK_PSW;
+    if (env->cregs[0] & CR0_AFP) {
+        *flags |= FLAG_MASK_AFP;
+    }
+    if (env->cregs[0] & CR0_VECTOR) {
+        *flags |= FLAG_MASK_VECTOR;
+    }
+}
-- 
2.41.0


