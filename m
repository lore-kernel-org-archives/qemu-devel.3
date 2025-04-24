Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF81C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kxj-0006lc-Nw; Wed, 23 Apr 2025 21:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwr-00055Y-Tf
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:18 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwo-0005UY-6g
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:17 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2279915e06eso4598915ad.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456412; x=1746061212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q2Qeo3QXQKKP4XnDRGevpdG6ZhTAI9iOzSVzVjKvTY4=;
 b=SlSL46FI/gIygliorbCTrsQm3AKSfDEBmbDjP9wXHgE9aHEENP19pgKDY7qDVpFhB/
 74P9bk+XwLYW2djFgqb9OZ8o+Wj6Yyc8dhJ8no0ZR0GtNh5aR19/sNjPKt8MGIA8g2Eq
 CQMIvSUNjUej7B5Pr6Y4Jp0sZycB+Blc6L1a7kRsGRfAiYfw3lVwerSYtus8zrbRz4ke
 iYbNRUKxmKy5EPz9c+1fl24X1T32XSaYX+KnDGX8EtCcszAjZKRQnCvqhLmvUs4tvIoS
 oIeLTXPa+sCq+3/s2zTUuJt85OC8xlFxOlZDkucQzOj4xDpX/FEz+W0ZvlEb9oZ06z4h
 GXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456412; x=1746061212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q2Qeo3QXQKKP4XnDRGevpdG6ZhTAI9iOzSVzVjKvTY4=;
 b=FyNYgw/j16/yP6ZTm4simL3ncS/91YUjbQ0F4s7juXnFUstfNBQPDaQKHz09DlG8RX
 MZnd8PDPRPbcpG6qPBCxLefX8VhmEK+LJikDpAIaHEyEruXz8/krL5S3RqhSMnt9gMYD
 G8sN1kpMn3zxGW6J60qIuKCLUH9AF3V8xGOEjOevJJoWzRcZlblHkrnBZwf2za0F/5SG
 IwD61vNz5usX2YMXDgP61vDMg7JQbzCP5UNH+4Co1VrAaqvqmSeebvloqtrq1hWOAg9K
 GgImqMZQxub9R+mTW8tc9NR+7QH2I7VPoFaPhBbAHKpBaO77DXBuVmB28OmGXSqq8DtP
 u4vg==
X-Gm-Message-State: AOJu0Yzdt9wh6QhyJJ7ZopraOjsiSlMq5k7oyIr+BPTsmA4dNAPXzXG1
 SOT+IBkSQyFJ1a8kD8DvCYpHgKf1FzaWwDgaD5iOUutmq2l3bxixdCn8KppYMJ+zuc+pgPFtkQu
 4
X-Gm-Gg: ASbGncuyURlgu3SN0dkMk230FYa+odhdnNMqhIOGxFw8a2VZ3/V3RHqobPFs04zOfRw
 E2W/5stnk/l8cVX+ySDHVnc44bNOuLyZ8ty05EyT0+tsL3dkNuUR4AYOxoCsXuy8atzpHyCM544
 VywsLC0o29y0tTFfUJhpUJOYyA1NpY+Yjo3Qe7cvHjZlS5+y4/KyjhRm7mZXhFCz/3E+2DD8N11
 LHfQarLRaGvdv76kLAraRw7txyPD6uj0NqSfRIGIu3UI0IatmNz8aIBANEnIttlGiBzaKEI0lm8
 SnrFTo3ADP+fj8o6NzhHJ2OKPviaHeelvKVSfaPtowRno0rNVs87HGI3v78P1ceL9iDsc/UoAk0
 =
X-Google-Smtp-Source: AGHT+IGADe+im9ly3FB6Kr/dvjB/AAy1U1i1IAFEAyU3jQiVpmTxczvuTKhW//Kx0OJEJPHI1SKWmA==
X-Received: by 2002:a17:903:8c6:b0:223:619e:71e9 with SMTP id
 d9443c01a7336-22db3bb6f8cmr8245595ad.11.1745456412471; 
 Wed, 23 Apr 2025 18:00:12 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f45c7sm129259a12.16.2025.04.23.18.00.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:00:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 133/148] tcg: Always define TCG_GUEST_DEFAULT_MO
Date: Wed, 23 Apr 2025 17:49:18 -0700
Message-ID: <20250424004934.598783-134-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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


