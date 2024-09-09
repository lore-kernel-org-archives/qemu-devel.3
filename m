Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A808ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 18:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sninJ-0003r4-Fo; Mon, 09 Sep 2024 14:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sninI-0003gy-6E
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 14:07:20 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sninF-0001wd-OC
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 14:07:19 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-656d8b346d2so2936553a12.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 11:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725905236; x=1726510036; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bKKi0pMicJbraFe0EvfP4hRpwt+nXYvkFQlWAnrDKc0=;
 b=akUttigd8EVsy6ByCyyfjFGudFoXT+6d3PaKCWyr/tLitlyHohOacXZX653VF2J7pW
 QqROtvbidu14tmj4wxCuX8ToybH5xhRnfuheCJlEfQbuxD1kLT+GnVxJFlu5OKwcN4wN
 aAUPh4NwUYWmt0GZ7l98+/DG2ckFqGDgop3TfG806PCOP2AWV9S0fo3u/B3ECESRwsEP
 URIsYyXwofz3NLYMgr3nq0ty/7/in3ya9QGdOQVSQmpVa+sHZdIlrf8zAuX4vOJ3p/vT
 rlyjtFqlEuijTFbNXyJiMzCAdyfoPRnqAxGHuXVYJ5eD2a5JSrXwEW511YzGj2IROOFM
 57KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725905236; x=1726510036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bKKi0pMicJbraFe0EvfP4hRpwt+nXYvkFQlWAnrDKc0=;
 b=WVmKHRNc7LNYbNtgVM3hMGrYtBhLaj4JO3XKuNfk+2W+fKZla+mtHyLv4gOE9P7Scs
 HUhCxfnF2fB3JjWSSyGOlzNSDmdhEaLD+4jRgyTYMqjiM/sTnS8NcTygntVG31KhA1Jy
 QPS2QyfcL1ycLX4VkqiKXx10rUX0iUxf7HAwB7u4Dm/F/edPaXuXqGCXaEa3kcoXYPTr
 b8VaOLrmHxwK3ZRziKMfJ/2JHMiBNUa0Qk9SbTV0NU4Tzq2JK+fufESQvjpgXsQMLZA5
 Hn5s+dZMH+aw+OKuah7gRRJFfeMHj98v1Ov2e5bNHacPlwSPMcUd1Y3tSR+wKz8lbCrU
 16Pw==
X-Gm-Message-State: AOJu0Ywdk2dUfWE/tEUMlW3EoMYgeu9yMEBPVXTwhhNzjYH4qssYOYrx
 PxHOYpXJbvShKywGWZ/GewyNPeN2zJyoGIsvyApEkSSXcxNXwMt59HjRKT1C2UjLJwobesWUmmf
 d
X-Google-Smtp-Source: AGHT+IFsVeeZiS/sawRrbLTH9LqJb/j426q/xV7fUshPpfqBz8Bt2U0zif9hrBV6p6uw6sunm86Hng==
X-Received: by 2002:a05:6a21:4d81:b0:1cf:43c6:d53f with SMTP id
 adf61e73a8af0-1cf43c6d637mr3376136637.19.1725905235888; 
 Mon, 09 Sep 2024 11:07:15 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc84efsm25431b3a.8.2024.09.09.11.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 11:07:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	chauser@pullman.com
Subject: [PATCH v4 2/5] target/sparc: Populate sparc32 FQ when raising fp
 exception
Date: Mon,  9 Sep 2024 11:07:09 -0700
Message-ID: <20240909180712.651651-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909180712.651651-1-richard.henderson@linaro.org>
References: <20240909180712.651651-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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


