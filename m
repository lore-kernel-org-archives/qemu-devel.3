Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D289AEE644B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socPy-0002Ny-AG; Thu, 12 Sep 2024 01:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1socPq-0001s8-LB
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:52 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1socPo-000329-HC
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:50 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20573eb852aso11269435ad.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726119047; x=1726723847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eaeJ4vIVtml8YIdsCzBuc3r44GRxLtYAklX7iK/54rg=;
 b=RPnO9Y6WVQp+IDb2aOOYIq/38m/QnyITREaZSeVOAKzxK8LcDs31D9mm2pp0ZXbPjG
 6ebHfl/ngkEjMTpAGukih+s8fNvHaxp9EFTYhjRgC+xhzEbX1byBDRQTfgyTON9lrn/0
 zR/rCf95Id3IVEua9zhBseqxlr6T2M/tINyKD1tVP7sVni889h503Em3nTFgkMoKjPYe
 v9eJg14YeFa7hYFgrygRyaQq3fuXQSmu+sbRHjERcVWUZK/JwLNhY4hW9X+3s7XmYsmO
 6A3258VM9bhN9WGyJsEw2Oh4bQdNajcSVDhe9f9OX0lmBwa/1mjd0AAp+bl9B4Zx8C4a
 WrQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119047; x=1726723847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eaeJ4vIVtml8YIdsCzBuc3r44GRxLtYAklX7iK/54rg=;
 b=rKVq0g7XoJmbf9F3BdofPDp8zj3v2QP6B7xd1Ez5HtruqhiEpx5+tm2fF8jWoX2Khn
 jNfmswNnEs5xtSb+42Lnw/x1gie9wa9pVVgTjxsVjFATrqb0VMrVlcgtH189ntt4Qw+3
 xNXBDlR/85i37ad05ykus6cOU97F6PXI0IvecCffNcdH6uwabwwIUNmzc1/mtAI8cGb2
 nvGkm+jTlYvR3dJXnbwUtRFGW4QkiAHirIQMxmwzxhqY4ejGcH+0lb5iDHMK22HozyyP
 C/dCCqFYooXpOAb8iTQQQ7lJhPW07Wsrkfak74eJWond4p5WqJsX6NJOzwd7BOVnQUDH
 EUfw==
X-Gm-Message-State: AOJu0Yxq2FJgfvPQMqWgJB9Z0sKOXUzYCLZ9yGKt1NrPm2Mi9m3msU2h
 JpbHkrDPWht0Qi+6YAwYPCzmPs9yEEvgGyCi7tVfjqnV0jhBcAhmjVL3NKXNli+5MfxORr2ZI/b
 O
X-Google-Smtp-Source: AGHT+IFDyoVjkdrLl/yKyQ8Yo/6A0CMeygj2kLAUG00J5ENRuLr4OWzAy5XCGBDDQsdP+d4PTBoA2w==
X-Received: by 2002:a17:902:e545:b0:206:8f25:a4f with SMTP id
 d9443c01a7336-2074c624134mr106942425ad.16.1726119046784; 
 Wed, 11 Sep 2024 22:30:46 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2076afe9e1dsm7513155ad.236.2024.09.11.22.30.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:30:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Carl Hauser <chauser@pullman.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 2/5] target/sparc: Populate sparc32 FQ when raising fp exception
Date: Wed, 11 Sep 2024 22:30:40 -0700
Message-ID: <20240912053043.1131626-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240912053043.1131626-1-richard.henderson@linaro.org>
References: <20240912053043.1131626-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

From: Carl Hauser <chauser@pullman.com>

Implement a single instruction floating point queue,
populated while delivering an fp exception.

Signed-off-by: Carl Hauser <chauser@pullman.com>
[rth: Split from a larger patch]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Carl Hauser <chauser@pullman.com>
---
 target/sparc/int32_helper.c | 40 +++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index 6b7d65b031..f2dd8bcb2e 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -21,10 +21,10 @@
 #include "qemu/main-loop.h"
 #include "cpu.h"
 #include "trace.h"
+#include "exec/cpu_ldst.h"
 #include "exec/log.h"
 #include "sysemu/runstate.h"
 
-
 static const char * const excp_names[0x80] = {
     [TT_TFAULT] = "Instruction Access Fault",
     [TT_ILL_INSN] = "Illegal Instruction",
@@ -116,22 +116,9 @@ void sparc_cpu_do_interrupt(CPUState *cs)
 
         qemu_log("%6d: %s (v=%02x)\n", count, name, intno);
         log_cpu_state(cs, 0);
-#if 0
-        {
-            int i;
-            uint8_t *ptr;
-
-            qemu_log("       code=");
-            ptr = (uint8_t *)env->pc;
-            for (i = 0; i < 16; i++) {
-                qemu_log(" %02x", ldub(ptr + i));
-            }
-            qemu_log("\n");
-        }
-#endif
         count++;
     }
-#if !defined(CONFIG_USER_ONLY)
+#ifndef CONFIG_USER_ONLY
     if (env->psret == 0) {
         if (cs->exception_index == 0x80 &&
             env->def.features & CPU_FEATURE_TA0_SHUTDOWN) {
@@ -143,6 +130,29 @@ void sparc_cpu_do_interrupt(CPUState *cs)
         }
         return;
     }
+    if (intno == TT_FP_EXCP) {
+        /*
+         * The sparc32 fpu has three states related to exception handling.
+         * The FPop that signals an exception transitions from fp_execute
+         * to fp_exception_pending.  A subsequent FPop transitions from
+         * fp_exception_pending to fp_exception, which forces the trap.
+         *
+         * If the queue is not empty, this trap is due to execution of an
+         * illegal FPop while in fp_exception state.  Here we are to
+         * re-enter fp_exception_pending state without queuing the insn.
+         *
+         * We do not model the fp_exception_pending state, but instead
+         * skip directly to fp_exception state.  We advance pc/npc to
+         * mimic delayed trap delivery as if by the subsequent insn.
+         */
+        if (!env->fsr_qne) {
+            env->fsr_qne = FSR_QNE;
+            env->fq.s.addr = env->pc;
+            env->fq.s.insn = cpu_ldl_code(env, env->pc);
+        }
+        env->pc = env->npc;
+        env->npc = env->npc + 4;
+    }
 #endif
     env->psret = 0;
     cwp = cpu_cwp_dec(env, env->cwp - 1);
-- 
2.43.0


