Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E9EC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqEG7-0006rD-4h; Thu, 06 Mar 2025 11:39:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqEFz-0006lZ-EU
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:39:37 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqEFx-0004ZY-Dw
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:39:34 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43bbc8b7c65so10746905e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 08:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741279172; x=1741883972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=buL5XagIeXqBLgJBqfarfsuVQtwTrOnKW/TPgRyLsQw=;
 b=iQ1+eKJl5E/ZjpTszX6H/5GYgVqaAa8JF/fX54uXq5xM+qwDqZCgURHxpUWlhki9CT
 Sr2RMTRq17rbOIaZ//nBhoRX9K7kHVYsYJf0FfstVFE0pXvw/tohuH8+tM+9TmkvXpX4
 Y3bfNFZb+3CaNogGL5nsZnCoXFtYHExwdImX7EzgR/1URs/jspCwqDcUdnj374+XZCVi
 HaYNOAwwNBnhIeMyLFuDhJdN6WX07s4QGJZ9L6WqMRoFyxQRIeyGk0tQ+ZHN4HD72E/g
 9aFsLs711BO8sZCxayPOSgGS7dailEnTHq9gbV+GV9DKqQiybrsOCt4uHsYXZ+KRy/Ci
 VfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741279172; x=1741883972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=buL5XagIeXqBLgJBqfarfsuVQtwTrOnKW/TPgRyLsQw=;
 b=QMpyj77ETG8mY9sEGREDgRSjVP/LTB5rJqdLpwuJ+8Z2bIZMEa5ksbmLEmAbfssiky
 vSoYf8J5q+tEzG544Zbbi3lAgB+pcBy4BdNE1LlqspwkOxJUh9PiRScalg0U3B+WIkxn
 runK6rNcDfiQ/A51td7duyHXjlmwOloL/lzV3MQiOhGpFyBki8vaxAJ8sQadPVaCj4CR
 XFYdC93o7yH3VdJLgYlkfwtG1TTzNi09w9/B7yUfK2fA2PFADE5I0epf5atxnVq3ZYTL
 Wo1FuOO82rkZPpVPV8OHYXUFbJmLtzAVunDueD0ecqSOCCUVMroqlUF+F/Jx85heb6UB
 b6Bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpl5I845lBrk1RIG3TPzxokz62ZbFTbwSYrvfDmxQGr64+a6iK5TUKx3NVJUZW/rZLpwrhsX6TP5O7@nongnu.org
X-Gm-Message-State: AOJu0Yy/ptG/xtUcnENCPrVALwwSIdjW1qSY0IgsKnnrisxOFJU6JUPc
 /bTyYD2NN4Z+xI5Fr0DkbILhwxtJobb7jPlgmCxKeA5qrfZI2rHznm/EyFFz9FI=
X-Gm-Gg: ASbGncsrwsRitLs9LZV0vZLjtt+Dy23dLCdB73p50tVltf9g8tPJ8fkePfPfsXBarOp
 O7y6YM0Qjbk+D9Zew6wGpSVmO7OpOdnohn9JpVBg4hkAsnPO6tvClQMP3uSX34XlbEzpPn0qMW0
 cfD6vcehZ4LxXQrnktjdHSygRvz5n/NrDlVyUp3cagXU/x8KAJ4b2AIA1XZRc2k9Klu6lHOtvov
 kUg4zp/6t4lzAMnOt0cMOb4weURNNTJ3kxSA93d2LixMvYjJb36VBKx/20RlatFKEdfxTYIwUOY
 V2Kb7wRMRjmRkeBJYzHRiivkwhlSFrxKKr6/qtpoglCzwOuldqI=
X-Google-Smtp-Source: AGHT+IEEYGL9tqCMwfLyvefG1uTJpLPffLAmX4TKspr+p0zl4LlYyG/4959wzOxLRv/PwLIPVA6JoQ==
X-Received: by 2002:a05:600c:3b88:b0:43b:da79:582b with SMTP id
 5b1f17b1804b1-43c601d67edmr1966075e9.18.1741279171939; 
 Thu, 06 Mar 2025 08:39:31 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd94913fsm23999905e9.37.2025.03.06.08.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:39:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 05/10] target/arm: Move arm_cpu_data_is_big_endian() etc to
 internals.h
Date: Thu,  6 Mar 2025 16:39:19 +0000
Message-ID: <20250306163925.2940297-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306163925.2940297-1-peter.maydell@linaro.org>
References: <20250306163925.2940297-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

The arm_cpu_data_is_big_endian() and related functions are now used
only in target/arm; they can be moved to internals.h.

The motivation here is that we would like to move arm_current_el()
to internals.h.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h       | 48 ------------------------------------------
 target/arm/internals.h | 48 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 5ae40f32491..16c9083be61 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3030,47 +3030,6 @@ static inline bool arm_sctlr_b(CPUARMState *env)
 
 uint64_t arm_sctlr(CPUARMState *env, int el);
 
-static inline bool arm_cpu_data_is_big_endian_a32(CPUARMState *env,
-                                                  bool sctlr_b)
-{
-#ifdef CONFIG_USER_ONLY
-    /*
-     * In system mode, BE32 is modelled in line with the
-     * architecture (as word-invariant big-endianness), where loads
-     * and stores are done little endian but from addresses which
-     * are adjusted by XORing with the appropriate constant. So the
-     * endianness to use for the raw data access is not affected by
-     * SCTLR.B.
-     * In user mode, however, we model BE32 as byte-invariant
-     * big-endianness (because user-only code cannot tell the
-     * difference), and so we need to use a data access endianness
-     * that depends on SCTLR.B.
-     */
-    if (sctlr_b) {
-        return true;
-    }
-#endif
-    /* In 32bit endianness is determined by looking at CPSR's E bit */
-    return env->uncached_cpsr & CPSR_E;
-}
-
-static inline bool arm_cpu_data_is_big_endian_a64(int el, uint64_t sctlr)
-{
-    return sctlr & (el ? SCTLR_EE : SCTLR_E0E);
-}
-
-/* Return true if the processor is in big-endian mode. */
-static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
-{
-    if (!is_a64(env)) {
-        return arm_cpu_data_is_big_endian_a32(env, arm_sctlr_b(env));
-    } else {
-        int cur_el = arm_current_el(env);
-        uint64_t sctlr = arm_sctlr(env, cur_el);
-        return arm_cpu_data_is_big_endian_a64(cur_el, sctlr);
-    }
-}
-
 #include "exec/cpu-all.h"
 
 /*
@@ -3256,13 +3215,6 @@ static inline bool bswap_code(bool sctlr_b)
 #endif
 }
 
-#ifdef CONFIG_USER_ONLY
-static inline bool arm_cpu_bswap_data(CPUARMState *env)
-{
-    return TARGET_BIG_ENDIAN ^ arm_cpu_data_is_big_endian(env);
-}
-#endif
-
 void cpu_get_tb_cpu_state(CPUARMState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *flags);
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index a6ff228f9fd..70d1f88c20b 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -392,6 +392,54 @@ static inline FloatRoundMode arm_rmode_to_sf(ARMFPRounding rmode)
     return arm_rmode_to_sf_map[rmode];
 }
 
+static inline bool arm_cpu_data_is_big_endian_a32(CPUARMState *env,
+                                                  bool sctlr_b)
+{
+#ifdef CONFIG_USER_ONLY
+    /*
+     * In system mode, BE32 is modelled in line with the
+     * architecture (as word-invariant big-endianness), where loads
+     * and stores are done little endian but from addresses which
+     * are adjusted by XORing with the appropriate constant. So the
+     * endianness to use for the raw data access is not affected by
+     * SCTLR.B.
+     * In user mode, however, we model BE32 as byte-invariant
+     * big-endianness (because user-only code cannot tell the
+     * difference), and so we need to use a data access endianness
+     * that depends on SCTLR.B.
+     */
+    if (sctlr_b) {
+        return true;
+    }
+#endif
+    /* In 32bit endianness is determined by looking at CPSR's E bit */
+    return env->uncached_cpsr & CPSR_E;
+}
+
+static inline bool arm_cpu_data_is_big_endian_a64(int el, uint64_t sctlr)
+{
+    return sctlr & (el ? SCTLR_EE : SCTLR_E0E);
+}
+
+/* Return true if the processor is in big-endian mode. */
+static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
+{
+    if (!is_a64(env)) {
+        return arm_cpu_data_is_big_endian_a32(env, arm_sctlr_b(env));
+    } else {
+        int cur_el = arm_current_el(env);
+        uint64_t sctlr = arm_sctlr(env, cur_el);
+        return arm_cpu_data_is_big_endian_a64(cur_el, sctlr);
+    }
+}
+
+#ifdef CONFIG_USER_ONLY
+static inline bool arm_cpu_bswap_data(CPUARMState *env)
+{
+    return TARGET_BIG_ENDIAN ^ arm_cpu_data_is_big_endian(env);
+}
+#endif
+
 static inline void aarch64_save_sp(CPUARMState *env, int el)
 {
     if (env->pstate & PSTATE_SP) {
-- 
2.43.0


