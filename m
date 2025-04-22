Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B1CC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JSh-000520-0M; Tue, 22 Apr 2025 15:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSF-00045h-Dx
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:38:51 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSD-0007Lk-7e
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:38:51 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-227914acd20so1954565ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350728; x=1745955528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q2Qeo3QXQKKP4XnDRGevpdG6ZhTAI9iOzSVzVjKvTY4=;
 b=B+b4TYzskieNgoxz2hYMI08GjhauWR+fMH3cRdx41CxRfVw09BAaUpynj9R0fa95JH
 +e2GJWh9Jt8DA7ZH6vIQdbKZmEHiOXbAXaQPTmo1wCzNn7t4feRmjs1AD4lsSKF2dvQ0
 Va4F+UFSwsFjyf0usOp1buC/hd2qA9RaPLUGll/ULJ/qRpWUqLU0UHqJPyhDiJ3KoKVu
 SEbRibQAp2Krovn8y7t4AJEWyZapwqliw4reIdyXo7mvD8jMTnNnIepxGFKI+TNWHDS6
 Bav293FCl/27YkE21+JgqwDVxpL6T0TOfog0Jg0YRIUHuXgiRZT/5NVVn/N+eiD2dp1Q
 +E0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350728; x=1745955528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q2Qeo3QXQKKP4XnDRGevpdG6ZhTAI9iOzSVzVjKvTY4=;
 b=M7LH3gTcH7HbE8tpDnfFFMWeCvTKSQZ+MAmZeSnnbvKEwRwentqJhWqGya+O6uxQ5Y
 M3HWycobKNKbRVvLS0q3J9T4inOdEQTG1J4bgYyE+ayqJS7qfFyjA7TzVKvdQ2YmODBc
 Tg5KVJ3KfnXN6alF0YMcxhG2pycEx3tn9o0embW3F+Jeecy85urvfXLIgJQHRJqvCxVw
 phLd4pGpERPBaTendtRio/wW475cw4k/v+MKIXFXg9HOiYBLOg68isVJbxXAIIg5Bnk0
 A+JGx1Ji2aYcZ5s5oiNOhsOtvrMfxsDa4uSYBkWJDlGVRk14Zbc1qc1nRIAmVS5WoGOl
 fuhw==
X-Gm-Message-State: AOJu0YzfPs08tNVCKZc/YzdCYn+q3DAv+smHliDyLlo15HFSOU0rlxzB
 mlqns5ACs61y4rsStKa2nMJHikoCDz0NO5jS34NN7aHDGT8W4DzDL60yA/8aExsjcRUJZehEgsb
 A
X-Gm-Gg: ASbGncvVPQT40A9/jimWmjxzi4hNLAqx7IBVz7khoZ50Zkcg+6l0aaL/EqLuY/cvg0E
 4rFf6RKzw+rCIrGk+0jdYPRuTatZ/RzsUuhARoVrEwyqB2dfKpP2mcxrOnX1mxhlRlO69ZulBX6
 eQvufRfvROUz7lXyaEgOorqcwJkC+x3sAHhUsDn7vEc+O7Gl4fvL9mF/yGmOjYJyJXwIJAe1BPu
 oBEcIzt6YmmD8QN5BUZVlhgxZbknLEC44k6N9PQmpkpEqeINxW8ZVlCzAI/LtbMb9zfhpNPHbFX
 0cKDT+B7Qf8aDxRm81zjqiheTM4fK4/7C/bgsUYXdocBpgXjm0zICj8HGEeZtrehzLPJjEK1JAE
 =
X-Google-Smtp-Source: AGHT+IESJa7MesmduoVh/F36xBloNm2lMZFs8puxoNSx4WYmM6G3t98CKNmJ6/dr7T9sFx7xu9wibA==
X-Received: by 2002:a17:903:2352:b0:224:3610:bef4 with SMTP id
 d9443c01a7336-22da337b263mr2908145ad.25.1745350727770; 
 Tue, 22 Apr 2025 12:38:47 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb484dsm88951765ad.148.2025.04.22.12.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:38:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 132/147] tcg: Always define TCG_GUEST_DEFAULT_MO
Date: Tue, 22 Apr 2025 12:28:01 -0700
Message-ID: <20250422192819.302784-133-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

We only require the TCG_GUEST_DEFAULT_MO for MTTCG-enabled
frontends, otherwise we use a default value of TCG_MO_ALL.

In order to simplify, require the definition for all targets,
defining it for hexagon, m68k, rx, sh4 and tricore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hexagon/cpu-param.h | 3 +++
 target/m68k/cpu-param.h    | 3 +++
 target/rx/cpu-param.h      | 3 +++
 target/sh4/cpu-param.h     | 3 +++
 target/tricore/cpu-param.h | 3 +++
 accel/tcg/translate-all.c  | 4 ----
 6 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/target/hexagon/cpu-param.h b/target/hexagon/cpu-param.h
index 635d509e74..7cc63a01d4 100644
--- a/target/hexagon/cpu-param.h
+++ b/target/hexagon/cpu-param.h
@@ -25,4 +25,7 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
 
+/* MTTCG not yet supported: require strict ordering */
+#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
+
 #endif
diff --git a/target/m68k/cpu-param.h b/target/m68k/cpu-param.h
index 256a2b5f8b..10a8d74bfa 100644
--- a/target/m68k/cpu-param.h
+++ b/target/m68k/cpu-param.h
@@ -19,4 +19,7 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
+/* MTTCG not yet supported: require strict ordering */
+#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
+
 #endif
diff --git a/target/rx/cpu-param.h b/target/rx/cpu-param.h
index 84934f3bca..fe39a77ca3 100644
--- a/target/rx/cpu-param.h
+++ b/target/rx/cpu-param.h
@@ -26,4 +26,7 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
 
+/* MTTCG not yet supported: require strict ordering */
+#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
+
 #endif
diff --git a/target/sh4/cpu-param.h b/target/sh4/cpu-param.h
index f328715ee8..acdf239749 100644
--- a/target/sh4/cpu-param.h
+++ b/target/sh4/cpu-param.h
@@ -18,4 +18,7 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
+/* MTTCG not yet supported: require strict ordering */
+#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
+
 #endif
diff --git a/target/tricore/cpu-param.h b/target/tricore/cpu-param.h
index eb33a67c41..45fde756b6 100644
--- a/target/tricore/cpu-param.h
+++ b/target/tricore/cpu-param.h
@@ -14,4 +14,7 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
 
+/* MTTCG not yet supported: require strict ordering */
+#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
+
 #endif
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index c5590eb695..7467255f6e 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -353,11 +353,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tcg_ctx->tlb_dyn_max_bits = CPU_TLB_DYN_MAX_BITS;
 #endif
     tcg_ctx->insn_start_words = TARGET_INSN_START_WORDS;
-#ifdef TCG_GUEST_DEFAULT_MO
     tcg_ctx->guest_mo = TCG_GUEST_DEFAULT_MO;
-#else
-    tcg_ctx->guest_mo = TCG_MO_ALL;
-#endif
 
  restart_translate:
     trace_translate_block(tb, pc, tb->tc.ptr);
-- 
2.43.0


