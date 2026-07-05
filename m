Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4C6C43602
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 04:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgEee-0001Lx-VX; Sun, 05 Jul 2026 00:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEcb-0005Mr-4l
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:38:25 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEcH-0004NI-LS
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:38:24 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2cacf197759so28987515ad.2
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 21:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783226274; x=1783831074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mes9xDUQ0Ck2g/+WTnUtzsbUXNthtYb/ogAdhSHGYlY=;
 b=RRqaEcfxaiRmjYVBkmGKhQJuCxjQtQQtWZTgqI5vcn6nZae0SmFcOxaxGQehREDzuP
 DOiXOTedxpkYZIu4l2CVSkiy0e7aFrcB3pb6JPoPH0xpyyxqtMhsQR+LlJNso/d7qenG
 PHfe1YQ9IYL5R+xp8klfaQaGjBrGoNmkvWuqHWkUEl3LeBYZTgxJmpvc0TgOhmAPDGM7
 M6gyFxqh7kphZcevXZgAnGzzs+pZ2xj8ypY7hSfV3/md2e8xsYGNk8owtO9nnkQkjRQt
 lOsbN2Vcmc9J7WEncn1iLyAmwdPCBHrLIQgGk0I7Souir8NSf1ji+rAKNhmV8MmT9bKU
 ZHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783226274; x=1783831074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mes9xDUQ0Ck2g/+WTnUtzsbUXNthtYb/ogAdhSHGYlY=;
 b=ACOFN1+BL40Ml+xnLBTBE8CPaxkNudeuMkfn+z7MNU6WyRijdDbyldxmG/OIkq4Gz+
 2n8VLwkN7eOp3tmJOcSQ7lI6F/Arvs/F5aGXKf1jF8KaNXc8Oxr8H5kGIkMGzyX4rxTU
 9GC+tfVz19a4YsUyEYpyVA1wzcVeZVSVnRegyxC8Dqryj7cOMLLYiVNXzdkJNvTICg6b
 w4vl59yer3OjOGWuC9znle3JReSeMdQuTtus9Be8WWwDdVxiGsSQHQNJgRDs5hLzBiaB
 Jnzts43f+zqIRHkMlkda7IaxEdpokIg67hDyYOvbmb3phCf6K3vJXTdk9Z+yx6Y1Dbz0
 +8IA==
X-Gm-Message-State: AOJu0Yz+q05IjAVj6PQuD0V0QXv7fg8uV1F08/dB2cfCrNretvqi2TFV
 VuGrrXWFFGE8941T941nArSFAnWhsWXAORU4B5Y+2eXFubE32ObAFaDU2+0f5EpBcvJ3AurXwk3
 3vtsl
X-Gm-Gg: AfdE7cmGe54E7/qWEO7qTZMV6dUCJzfqr4U++Mf3SYi3sZvl2IJB7s5VXjbZMJ/mtQz
 9ujhQb8+EdC7+EShKor2USKd5WQDWkOkV8vWoegRrtkCObpGJKJBJrQhZn68xGHCUkhB8W2SK98
 anGyjuQkWMP/U8GoI8DdUMuXHnoYwUgviYt690EQj2UtJoO+cEmMNZYKuSl2u79LzYYs6LufPVL
 0cDxoiNTgiENmSrlH02XB0omeh0Ov8H2K/ftVuf9texAbLXHyqEuzBpDrz1gjv06j2a1SZp/LpX
 RMissn2uQ3Dp6tIkb7grPFUR8cGIKia2sCHNdJ1WhL/31czPBlYyzvfyMla0WzNmaYzTlQR/Sco
 b9NUR7qdid2AoTsJiJYHKi7GmMWJw5hXw9ZjTgodGVOwkR6TmkbOfJfL5ARsjpA4QxRdSJ3Ivga
 Dqs1pItuARlhPQbQZVn6stFvszyQTlqkr5ZEijYtkJCUETjq0=
X-Received: by 2002:a17:903:b8f:b0:2c9:97a9:2097 with SMTP id
 d9443c01a7336-2cbb9efe254mr56878805ad.43.1783226274109; 
 Sat, 04 Jul 2026 21:37:54 -0700 (PDT)
Received: from stoup.. (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cad712ca17sm29863785ad.28.2026.07.04.21.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 21:37:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, philmd@oss.qualcomm.com
Subject: [PATCH v2 32/46] target/arm: Use CPUBreakpoint arg in
 arm_debug_excp_handler
Date: Sat,  4 Jul 2026 21:37:11 -0700
Message-ID: <20260705043725.1373137-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705043725.1373137-1-richard.henderson@linaro.org>
References: <20260705043725.1373137-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We no longer need to search for a matched breakpoint,
test for BP_CPU, or clear watchpoint_hit.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/debug.c | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/target/arm/tcg/debug.c b/target/arm/tcg/debug.c
index fe8513a5de..d705f7aef2 100644
--- a/target/arm/tcg/debug.c
+++ b/target/arm/tcg/debug.c
@@ -422,42 +422,27 @@ void arm_debug_excp_handler(CPUState *cs, CPUBreakpoint *hit)
      */
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
-    CPUBreakpoint *wp_hit = cs->watchpoint_hit;
+    uint32_t excp, syndrome;
 
-    if (wp_hit) {
-        if (wp_hit->flags & BP_CPU) {
-            bool wnr = (wp_hit->flags & BP_WATCHPOINT_HIT_WRITE) != 0;
+    if (hit->flags & BP_MEM_ACCESS) {
+        bool wnr = hit->flags & BP_WATCHPOINT_HIT_WRITE;
+        syndrome = syn_watchpoint(0, 0, wnr);
+        excp = EXCP_DATA_ABORT;
 
-            cs->watchpoint_hit = NULL;
-
-            env->exception.fsr = arm_debug_exception_fsr(env);
-            env->exception.vaddress = wp_hit->hitaddr;
-            raise_exception_debug(env, EXCP_DATA_ABORT,
-                                  syn_watchpoint(0, 0, wnr));
-        }
+        env->exception.vaddress = hit->hitaddr;
     } else {
-        uint64_t pc = is_a64(env) ? env->pc : env->regs[15];
+        syndrome = syn_breakpoint(0);
+        excp = EXCP_PREFETCH_ABORT;
 
-        /*
-         * (1) GDB breakpoints should be handled first.
-         * (2) Do not raise a CPU exception if no CPU breakpoint has fired,
-         * since singlestep is also done by generating a debug internal
-         * exception.
-         */
-        if (cpu_breakpoint_test(cs, pc, BP_GDB)
-            || !cpu_breakpoint_test(cs, pc, BP_CPU)) {
-            return;
-        }
-
-        env->exception.fsr = arm_debug_exception_fsr(env);
         /*
          * FAR is UNKNOWN: clear vaddress to avoid potentially exposing
          * values to the guest that it shouldn't be able to see at its
          * exception/security level.
          */
         env->exception.vaddress = 0;
-        raise_exception_debug(env, EXCP_PREFETCH_ABORT, syn_breakpoint(0));
     }
+    env->exception.fsr = arm_debug_exception_fsr(env);
+    raise_exception_debug(env, excp, syndrome);
 }
 
 /*
-- 
2.43.0


