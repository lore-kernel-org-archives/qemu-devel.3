Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D7AC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 13:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt4u5-00056D-Hl; Fri, 14 Mar 2025 09:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt4u4-00054m-2E
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:16:44 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt4u2-00011w-8B
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:16:43 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38dcac27bcbso2094327f8f.0
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 06:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741958200; x=1742563000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4ToRpJuRoPb7o2I7g2P2qw74Vo1+7N2AXe+vV531Ojk=;
 b=yEeJYN7+0reXXcI0DYVBqTuYsmJ4jkTjFl6p2KscntmZT91Tq/7st/N3Rpmhzwp+Rj
 KUt3UypdJBwvv/6dCs6OjRjgXYNWEb2P/AkD4Zo1CFsAMYr+R/pY5xZlDCRlDBY/HzFz
 MuEe0gCzIbnAbaRqzleapvVMGUB/d5O85dh3rOI8okgYrKPe4BF+Mvxs8LZdlcDBvzvk
 yFyQeaa/nRlgVZayH5u/mrcmYwaJFv1lV8BARuyBH+/z9RjxXvfaK8PUedSSaOH6h3bo
 CprlTgtQQcjrfElKkosMu0naWREUl6qkxye4J3XP1/8ouq48yJkYcXFHafHsbowqah9b
 ZEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741958200; x=1742563000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4ToRpJuRoPb7o2I7g2P2qw74Vo1+7N2AXe+vV531Ojk=;
 b=Pe1Bf3UZkxSSo4HQqd5zH8L1Z72TFDrnilO4uVweGPdqZMhEPO36m26ZaCz2p3ucKV
 zn48qHoQGVtKaIt0qCJ+pGJx8qftPXfN1PX8qMHtlZp3fKClwrXbHLIANm+Pt/T1Q/QX
 Tmdu4i+PzPkN/z0192wY4gGVlTcXxqpz8eHWSmqDRGcuIvoBWepHxQyWzf4QwLK65vrr
 3hjYrA4rkKSE18kR2Pj8QTsujTYLFlzoFxjBEzmU3AoZ3ogTuKnj1mpCzXNwmCAqF0IF
 kzs7V5KhIZO5dC4EkYgC1g3RIAkqheo+sLkHY2VR9k4MWVBjnaAgZZg++A3HC44AMPEx
 3HOg==
X-Gm-Message-State: AOJu0YyYOKe9lsnjD3QCyAnF4WY4emd20Txc9YtlWZbZQvQ6N69GanhW
 Cvla74Eml7bp83xa4ORdIvwfHanoobqf8K8Pl1Its5JnRTO6lqWB4InSJ0vT5gyynA3+QLC7q7I
 d
X-Gm-Gg: ASbGncuyBM52/5rCeHLT66ECHwCuNND2W0uLXq6BkXSaYEGovRk38pNNJ8JdYPuXO2n
 AdbSfin3k7N7qoSgffbPZ7Cx1oLq9V+AIlNre8Y2RH4vCK+ZD+AXiywE1wwb6LHM9fr0dXCC4HC
 IgWUXCi7F6h0T7wQfJ1OFR1rzU3Lj7k/yjVH+SRbfMXS4JO/cLMEtGkxU1l/MIE9EqVFx8yFpOP
 7cXVLB6cL2eZLm5xisL1GA+G/ljkPQ5kroieZOOEaxv3729yXzxwpZ/zeqszXDCuyEsmD37QDlv
 doy9sfTyGDv1SeI1i2GhGp80mYsJ47dEfBy73XCMCgPlkwDbuck=
X-Google-Smtp-Source: AGHT+IFwFbzFvM3scj21QfBYKz/g2ZyNo+jSL2SW/wsXajh8KdOTnuk8kkJJEb8l6+GpZiBBEulUew==
X-Received: by 2002:a5d:47a1:0:b0:38d:e3da:8b4f with SMTP id
 ffacd0b85a97d-39719032633mr3280337f8f.0.1741958200501; 
 Fri, 14 Mar 2025 06:16:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7eb93csm5437923f8f.86.2025.03.14.06.16.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 06:16:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/17] target/arm: Move A32_BANKED_REG_{GET,
 SET} macros to cpregs.h
Date: Fri, 14 Mar 2025 13:16:21 +0000
Message-ID: <20250314131637.371866-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314131637.371866-1-peter.maydell@linaro.org>
References: <20250314131637.371866-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

The A32_BANKED_REG_{GET,SET} macros are only used inside target/arm;
move their definitions to cpregs.h. There's no need to have them
defined in all the code that includes cpu.h.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h | 28 ++++++++++++++++++++++++++++
 target/arm/cpu.h    | 27 ---------------------------
 2 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 52377c6eb50..2183de8eda6 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -1157,4 +1157,32 @@ static inline bool arm_cpreg_traps_in_nv(const ARMCPRegInfo *ri)
     return ri->opc1 == 4 || ri->opc1 == 5;
 }
 
+/* Macros for accessing a specified CP register bank */
+#define A32_BANKED_REG_GET(_env, _regname, _secure)                     \
+    ((_secure) ? (_env)->cp15._regname##_s : (_env)->cp15._regname##_ns)
+
+#define A32_BANKED_REG_SET(_env, _regname, _secure, _val)       \
+    do {                                                        \
+        if (_secure) {                                          \
+            (_env)->cp15._regname##_s = (_val);                 \
+        } else {                                                \
+            (_env)->cp15._regname##_ns = (_val);                \
+        }                                                       \
+    } while (0)
+
+/*
+ * Macros for automatically accessing a specific CP register bank depending on
+ * the current secure state of the system.  These macros are not intended for
+ * supporting instruction translation reads/writes as these are dependent
+ * solely on the SCR.NS bit and not the mode.
+ */
+#define A32_BANKED_CURRENT_REG_GET(_env, _regname)                          \
+    A32_BANKED_REG_GET((_env), _regname,                                    \
+                       (arm_is_secure(_env) && !arm_el_is_aa64((_env), 3)))
+
+#define A32_BANKED_CURRENT_REG_SET(_env, _regname, _val)                    \
+    A32_BANKED_REG_SET((_env), _regname,                                    \
+                       (arm_is_secure(_env) && !arm_el_is_aa64((_env), 3)), \
+                       (_val))
+
 #endif /* TARGET_ARM_CPREGS_H */
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8f52380c88c..15d3a79b0af 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2684,33 +2684,6 @@ static inline bool access_secure_reg(CPUARMState *env)
     return ret;
 }
 
-/* Macros for accessing a specified CP register bank */
-#define A32_BANKED_REG_GET(_env, _regname, _secure)    \
-    ((_secure) ? (_env)->cp15._regname##_s : (_env)->cp15._regname##_ns)
-
-#define A32_BANKED_REG_SET(_env, _regname, _secure, _val)   \
-    do {                                                \
-        if (_secure) {                                   \
-            (_env)->cp15._regname##_s = (_val);            \
-        } else {                                        \
-            (_env)->cp15._regname##_ns = (_val);           \
-        }                                               \
-    } while (0)
-
-/* Macros for automatically accessing a specific CP register bank depending on
- * the current secure state of the system.  These macros are not intended for
- * supporting instruction translation reads/writes as these are dependent
- * solely on the SCR.NS bit and not the mode.
- */
-#define A32_BANKED_CURRENT_REG_GET(_env, _regname)        \
-    A32_BANKED_REG_GET((_env), _regname,                \
-                       (arm_is_secure(_env) && !arm_el_is_aa64((_env), 3)))
-
-#define A32_BANKED_CURRENT_REG_SET(_env, _regname, _val)                       \
-    A32_BANKED_REG_SET((_env), _regname,                                    \
-                       (arm_is_secure(_env) && !arm_el_is_aa64((_env), 3)), \
-                       (_val))
-
 uint32_t arm_phys_excp_target_el(CPUState *cs, uint32_t excp_idx,
                                  uint32_t cur_el, bool secure);
 
-- 
2.43.0


