Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634D3C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 20:58:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiIHI-0005U7-Bs; Fri, 10 Jul 2026 16:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIFS-00028k-F4
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:55:04 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIFA-0000va-PZ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:55:02 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-848595b338cso1566754b3a.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783716873; x=1784321673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mes9xDUQ0Ck2g/+WTnUtzsbUXNthtYb/ogAdhSHGYlY=;
 b=D7uamCcbKptZF5/gWoDeMxTHveTlQYCOwvaB2wV+R0XYsjRioLNBj81mv0lXsCb8tu
 mBOiHoqXeIgr9G2jT2ZVt7mgnYA/D50C3MaMFAaoNyUgHD9tmSM+Rc/ERtg13Q+59JWf
 FZn1ha/2+jQmZyGDHfaTBCppjXz6HauXW6qZP+ponMw0frIah4ivLw+V/MIJ3DBqlcJB
 yOIcS9tML/QbjOPllTzY/UADUM7wmptO3acUD5IkFUuD6mgGtnUEoYILMC5J6Sm4Whao
 6trghKSLWVUPGsL17IHmK86nJ4DWTSwKekva5pJeal6z0IJwe4nMisD3yA5cmiOoCHqt
 9XWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783716873; x=1784321673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mes9xDUQ0Ck2g/+WTnUtzsbUXNthtYb/ogAdhSHGYlY=;
 b=j87nW+5k59okqQv499MhfjD7X4t4NlYWBgQJdZI8wqWaTy10qgWprJdC8TkUomYYbc
 hp7XMuKJMBmGGjBrNk+2hR5SCgALQNd7evVFCCaSNRyZEiISwqXt1eMnCBVs5nUvPpA+
 GXQbSgmhNan7x2keCRBbowNiyYHV1MQ20iVJERD65/Vp49A5afVblJKAMZ7lh9brdGXf
 R02+3P1IFgI8Sc2wtoQP5d+Zd22icdVN41JX9PhF+bpisVujkpLn2bLdcpfauuzB845p
 ZZntY8fdQPy80sN7S4qMfHtoB3wX95zaQ79ENaWUSbsQA4j1LGl3gcTWaoPQTsZtTH/3
 SEZQ==
X-Gm-Message-State: AOJu0YxD7aPhaPQ6r+OMsMhx0Pgx8A+5Hj92iTW71I/2X2xIWd4JQxgK
 1yeD5nJze72nqH2pJhC3xLVbw+EfeJ6JuOofiOhZSe6pTIIvVvDT7aB9K3k1KDuN/C5O1NtSID5
 Luq4u
X-Gm-Gg: AfdE7cm8iZ54/kp43eeXrjzNjoBZgoH7IeQaPALDs7hTM2/K8Ij5yyJQByQ4ZxK7IKd
 RtQ+pIw1t4UEheqMRTxtc0mcWIQy467ZHCiMPyepIz7kteWUXAJoahQrHoQU63/mFPIg8HbgSLt
 mtmWuvMzT4/tUQKZomqJl+QMgTUChZ7zCqfKl6s3ZYf8Vt6ldj4I3skrLtbWiS8y5vn8IU9eEgP
 xQdu412aKfnM73ujGsw0QSTK7Z0/DOFtBcbuNzGwe3pmhBLEC7i/Tw0TVFfE7sFtyUrhWIvwuXs
 /Vc9FU2vfraaszO46dBvQKLHlMRqZawB0vYrLnowYIcyRMiqEkXYokyeqZPGbDzq54Y0EtXiWsj
 ulBDg2o/tkAIxjG7HMPOkqv8hP8iM30G0uzbEgVGn082hCGute9wwr/KpM1AYXIfx9n2Y2C6bq6
 JdHNJIuyBFy9Mv1feJn5BjjNS5WyFC
X-Received: by 2002:a05:6a00:14d1:b0:848:2f6e:e532 with SMTP id
 d2e1a72fcca58-848897cdcadmr473243b3a.70.1783716873368; 
 Fri, 10 Jul 2026 13:54:33 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6d76106sm10780574b3a.40.2026.07.10.13.54.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 13:54:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
Subject: [PATCH v3 28/51] target/arm: Use CPUBreakpoint arg in
 arm_debug_excp_handler
Date: Fri, 10 Jul 2026 13:53:38 -0700
Message-ID: <20260710205401.836304-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205401.836304-1-richard.henderson@linaro.org>
References: <20260710205401.836304-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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


