Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71CD0C36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 16:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u169W-0000XW-Sf; Sat, 05 Apr 2025 12:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u169V-0000X8-5m
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:13:49 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u169T-0005EL-FW
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:13:48 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso24357915e9.2
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 09:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743869625; x=1744474425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=22lxwaDoEwngFmE/+xTqkjd0CAM2fFfU6hC2em0g/bA=;
 b=nOmVKJ4zaATB7GL6dATMvWX7fxkCPbFJlqz4Hm+IEg2326ds8Odw8u5z/5DBUUJ2qo
 rnLz5Pu5PRE7K6N7udqmfYSw7sMq3sDKxFqWGZ4mv8wbJvK23TiqDKNTk4s7TpShu6x+
 qe4YAsy1EXapo1dyA5hEDoKxBy5jmfO6ITJMGA6OxZeLPvphK9aM5IiE7tM/p01A6vQf
 q3LJHrZSpPzQ2lKS2G9dXbmtnCgBpGHQrRfMP/ljOgXt/pUMZhRKg6MoXOjN+il7WlGq
 GjqRL4d8SWiR4dRtD4jKJm/1KUs+gYxpI0S6xUSNAjX+n9qwV1yw713ebediS2ujvu3F
 2qqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743869625; x=1744474425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=22lxwaDoEwngFmE/+xTqkjd0CAM2fFfU6hC2em0g/bA=;
 b=svl7ektJqBJnKiwYy+UlnN+QvzH2qNv+nToQLKTV7CXNJpfCkWbb4QSCj2yscsM4Qi
 GEgQXJwWmrIxDHMMAyAuUNYkSvDFK5fdKuiJ30RL8b1FtCZ4FIlCKTtRxecFmS/odzVh
 y8nldheeIgVOO+XYBeOc6jTuY4YHPM2V+PkRIhZvn5/cnzeRbzkNPLg6ogs1TbKL3z8J
 spr+8pRGSc9mvKt9ENy0gpKukvO91DkbgV/AiF5bFKh7FgOP1hYVrhPulx2FsIX0Zxro
 DRP1I3LwgnRUhkdTVc8Bsiduno98nN3tP/shd8SUYnoZApXahLyyIgxmU5C3HsIdqTEi
 Sj9Q==
X-Gm-Message-State: AOJu0YyXzRGxmCK0go5LknvQb1NRfsMWz271hkbH1x9KYPCRpETHoBTC
 bjnUpaAbowiYojbQ9MmFSHqlvL/YuuiZagX+LScgrRU255PZUoI1MvO2gMKkaakakkfsfIETJAO
 +
X-Gm-Gg: ASbGncvuCnFRa+zj7ZY5RRZhrYBbrBp9mpLNq4cgvutD9rtQ+V/i53elDhOaIFFv9KA
 RRL+9cS2X+/ZeacJeA+qizfvzkbgBpwKl3TlX8YTXRltIWWR6FtuDcLPCjh+8L8BgSJb1Se4qrJ
 0gxhbpLUvFHbTPSrzL/YJOBH2Nw1DIzdktPJy2l9IkS4Ag7AOYum8Lr8jIwHpCFT0bPZf+5TUPr
 sZTLkitCzr4B6fIg60AdboIYEELTcWGc+gpKapvWSaVPka5qQgFadXq6LBp37j2F0iy+mvytipo
 K5wg93UjFknn6v5fUNeS1tKO2jawZYpVSOjUU649+kRykJQ56wkUKIrJcHBR3WAU0cxb8bAf5NB
 Tv+d7XxGXsNFVGbA0FOKWiy1F
X-Google-Smtp-Source: AGHT+IGSrm/mb4PJDDqFvoc7hQEWBmgUAFUhSrSe+kLbllRmaM6IX9G01WoRq3TRgZ9QBaUl3UsZRg==
X-Received: by 2002:a05:600c:c0e:b0:43c:ed61:2c26 with SMTP id
 5b1f17b1804b1-43ee0694e51mr34531615e9.17.1743869625214; 
 Sat, 05 Apr 2025 09:13:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec364ec90sm76948075e9.27.2025.04.05.09.13.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 05 Apr 2025 09:13:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH-for-10.1 v4 05/16] tcg: Always define TCG_GUEST_DEFAULT_MO
Date: Sat,  5 Apr 2025 18:13:09 +0200
Message-ID: <20250405161320.76854-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250405161320.76854-1-philmd@linaro.org>
References: <20250405161320.76854-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

We only require the TCG_GUEST_DEFAULT_MO for MTTCG-enabled
frontends, otherwise we use a default value of TCG_MO_ALL.

In order to simplify, require the definition for all targets,
defining it for hexagon, m68k, rx, sh4 and tricore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/m68k/cpu-param.h    | 3 +++
 target/rx/cpu-param.h      | 3 +++
 target/sh4/cpu-param.h     | 3 +++
 target/tricore/cpu-param.h | 3 +++
 accel/tcg/translate-all.c  | 4 ----
 5 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/target/m68k/cpu-param.h b/target/m68k/cpu-param.h
index 256a2b5f8b2..10a8d74bfa9 100644
--- a/target/m68k/cpu-param.h
+++ b/target/m68k/cpu-param.h
@@ -19,4 +19,7 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
+/* MTTCG not yet supported: require strict ordering */
+#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
+
 #endif
diff --git a/target/rx/cpu-param.h b/target/rx/cpu-param.h
index 84934f3bcaf..fe39a77ca38 100644
--- a/target/rx/cpu-param.h
+++ b/target/rx/cpu-param.h
@@ -26,4 +26,7 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
 
+/* MTTCG not yet supported: require strict ordering */
+#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
+
 #endif
diff --git a/target/sh4/cpu-param.h b/target/sh4/cpu-param.h
index f328715ee86..acdf2397495 100644
--- a/target/sh4/cpu-param.h
+++ b/target/sh4/cpu-param.h
@@ -18,4 +18,7 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
+/* MTTCG not yet supported: require strict ordering */
+#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
+
 #endif
diff --git a/target/tricore/cpu-param.h b/target/tricore/cpu-param.h
index eb33a67c419..45fde756b6a 100644
--- a/target/tricore/cpu-param.h
+++ b/target/tricore/cpu-param.h
@@ -14,4 +14,7 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
 
+/* MTTCG not yet supported: require strict ordering */
+#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
+
 #endif
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index c5590eb6955..7467255f6e4 100644
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
2.47.1


