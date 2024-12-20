Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39740E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfil-0003nl-30; Fri, 20 Dec 2024 11:19:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfiW-0002CW-Ik
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:19:09 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfiU-0008EP-Qu
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:19:08 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3862ca8e0bbso1610480f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711545; x=1735316345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ObB9h5ClA82vSBh+n3DvAS5J1rT6h/dh6ysnz8owrU4=;
 b=TJKYjpqUv6zTaAgIZZKAkwC8Ufegn5+m+Wg/fYDhg+lfGXLYkLMee5eZjACZvqZ9Tn
 Ig0WbLfNc+oYftu70X0x7Qyo8BmcS5euIG5eVQmWHgbYsI4zFdUIJlyTpIjJb7pbsYDB
 YvAkw7u4zFOQnzob/z9Eo+cRAcKt1RqEO4V9ssP1x1IgoUFJJ9Sch4iR9cfLn41AI9Kf
 haT7V3Rm7N3oqAlRHbxBO7rBrGgZ6iAnX3GtsiyiC4V6gFZ8EjYTuqW7D+bFIMYfei4C
 ydoJ4uMoev9M88pA+6vv4R9dBMksMQw0xCVfB+c6/bM26cEZDAdOzhlSn5Q6dmA+w2qc
 x1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711545; x=1735316345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ObB9h5ClA82vSBh+n3DvAS5J1rT6h/dh6ysnz8owrU4=;
 b=Ea8D44YLH4s424OtppKKojKcmCXpAwYsPi1ebI/KiaODViCGcJTsvKF3c9UBj0kax5
 GWSDRZTglf8ZUjWJjfuGOBjMCX4kpCIAonNxYsVnI0KMz1VVpON0a+730FwIFbK003ym
 e2zG1b3CP1P7g5fXSaENKklQG4jMl0stYsqe+f9WeoFk+t7v1AbmgXLrN6B+jmmP6lFM
 OxcvTL2s/4eNVUZcBT8to9knHIuO0pLheEF4aU6RFgjTBWBJ+lG4sb+ZyqJahtrzoK+A
 G5zsESNzEHc71esde9Qf4gP6x/orHVEUb9riZx2dWBm5jeaMR2D/MGg9HJeUNtL/PM0z
 P2aw==
X-Gm-Message-State: AOJu0Yw1fWnTdaHShAf4PZwKD8NZmkbnl3qg3SZZ346pNygcSpeoCKwR
 I486ML34cJhSM4sr0R3QmFo/bFpT1WZvEaCdESwaejU/bMTde1YKjwPe+Cb2DOE0XVgi2J1TJ18
 r
X-Gm-Gg: ASbGncu+Z3V6Yei67Y0aOe6Rt+F8cMTUmNBk0U7c3gWF4JgaM9zyPZw/2Kvk/aLY2qs
 TqNs6qPW+kE6s9zNLJNYdJwNl25P4NNafn+y3RtgpnINWDwv/7y91DB3wW8b3cgQQ54vT1v7D4h
 L64N0i2QQ2aAwEl5XpIDLZZVylQmro6BZtVwe0jfCJ8f9AghSrNJEsWW/cmxoNG/tJ0fV8PTO7r
 UfjLLw/hES33N2RBD78sToOFxSS4NNEVxarT6YSCgSfFHwoJBv/oEqDGthHl93chDvycZpaWNY=
X-Google-Smtp-Source: AGHT+IG0H4WKbnDMxjcypPt0obg8g5lL0mNzHOD5wQv/HKGPZI/yNSMzBRKHhQrPJJQM1Wv+Q36Z8w==
X-Received: by 2002:a5d:6f16:0:b0:382:40ad:44b2 with SMTP id
 ffacd0b85a97d-38a221fadadmr3791555f8f.34.1734711544863; 
 Fri, 20 Dec 2024 08:19:04 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366120086bsm50474225e9.12.2024.12.20.08.19.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:19:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 42/59] target/sparc: Uninline cpu_get_tb_cpu_state()
Date: Fri, 20 Dec 2024 17:15:33 +0100
Message-ID: <20241220161551.89317-43-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

From: Anton Johansson <anjo@rev.ng>

Required to compile accel/tcg/translate-all.c once for softmmu targets.
The function gets quite big for some targets so uninlining makes sense.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Anton Johansson<anjo@rev.ng>
Message-Id: <20240119144024.14289-14-anjo@rev.ng>
[PMD: Only take SPARC part]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/cpu.h | 39 ++-------------------------------------
 target/sparc/cpu.c | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index f517e5a383b..e9ccec6175f 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -747,43 +747,8 @@ trap_state* cpu_tsptr(CPUSPARCState* env);
 #define TB_FLAG_FSR_QNE      (1 << 8)
 #define TB_FLAG_ASI_SHIFT    24
 
-static inline void cpu_get_tb_cpu_state(CPUSPARCState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *pflags)
-{
-    uint32_t flags;
-    *pc = env->pc;
-    *cs_base = env->npc;
-    flags = cpu_mmu_index(env_cpu(env), false);
-#ifndef CONFIG_USER_ONLY
-    if (cpu_supervisor_mode(env)) {
-        flags |= TB_FLAG_SUPER;
-    }
-#endif
-#ifdef TARGET_SPARC64
-#ifndef CONFIG_USER_ONLY
-    if (cpu_hypervisor_mode(env)) {
-        flags |= TB_FLAG_HYPER;
-    }
-#endif
-    if (env->pstate & PS_AM) {
-        flags |= TB_FLAG_AM_ENABLED;
-    }
-    if ((env->pstate & PS_PEF) && (env->fprs & FPRS_FEF)) {
-        flags |= TB_FLAG_FPU_ENABLED;
-    }
-    flags |= env->asi << TB_FLAG_ASI_SHIFT;
-#else
-    if (env->psref) {
-        flags |= TB_FLAG_FPU_ENABLED;
-    }
-#ifndef CONFIG_USER_ONLY
-    if (env->fsr_qne) {
-        flags |= TB_FLAG_FSR_QNE;
-    }
-#endif /* !CONFIG_USER_ONLY */
-#endif /* TARGET_SPARC64 */
-    *pflags = flags;
-}
+void cpu_get_tb_cpu_state(CPUSPARCState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *pflags);
 
 static inline bool tb_fpu_enabled(int tb_flags)
 {
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 8f494c286ae..b11f3248d82 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -713,6 +713,44 @@ static void sparc_cpu_synchronize_from_tb(CPUState *cs,
     cpu->env.npc = tb->cs_base;
 }
 
+void cpu_get_tb_cpu_state(CPUSPARCState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *pflags)
+{
+    uint32_t flags;
+    *pc = env->pc;
+    *cs_base = env->npc;
+    flags = cpu_mmu_index(env_cpu(env), false);
+#ifndef CONFIG_USER_ONLY
+    if (cpu_supervisor_mode(env)) {
+        flags |= TB_FLAG_SUPER;
+    }
+#endif
+#ifdef TARGET_SPARC64
+#ifndef CONFIG_USER_ONLY
+    if (cpu_hypervisor_mode(env)) {
+        flags |= TB_FLAG_HYPER;
+    }
+#endif
+    if (env->pstate & PS_AM) {
+        flags |= TB_FLAG_AM_ENABLED;
+    }
+    if ((env->pstate & PS_PEF) && (env->fprs & FPRS_FEF)) {
+        flags |= TB_FLAG_FPU_ENABLED;
+    }
+    flags |= env->asi << TB_FLAG_ASI_SHIFT;
+#else
+    if (env->psref) {
+        flags |= TB_FLAG_FPU_ENABLED;
+    }
+#ifndef CONFIG_USER_ONLY
+    if (env->fsr_qne) {
+        flags |= TB_FLAG_FSR_QNE;
+    }
+#endif /* !CONFIG_USER_ONLY */
+#endif /* TARGET_SPARC64 */
+    *pflags = flags;
+}
+
 static bool sparc_cpu_has_work(CPUState *cs)
 {
     return (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
-- 
2.47.1


