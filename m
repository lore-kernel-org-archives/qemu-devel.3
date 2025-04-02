Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69053C3601B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05Hy-0000Bo-4r; Wed, 02 Apr 2025 17:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Hi-0007Fy-1R
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:06:07 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Hf-0006iM-Sp
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:06:05 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so1686855e9.2
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743627962; x=1744232762; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9MO7LV0/gXNfytPX25lgbZnxOJWCw84WsDrMRmk30ac=;
 b=bI4ATBe26Dr9iep86zw5IPjUc90bVQdygh6nWT0Im8jKefRhnFarsqA6Kv5Si+p3LQ
 AcxuE8LJ5NlD8zSOk2owHIpglpccZGgshEo8phtqXyiRUJS0bs4JaPl52kEORW556uv6
 zGXgUwEajTNXheJrLwE5V1Hjo8cIpbb7GIoYJTpHF28UZ/N3nOSMfVNfmYezWy9ul+56
 CvGHMMkGouYo5WwuqcFtNiD2tQnq8rK/uuplqtSUzZ6MP9LYefKiC/l646q2XjfbAud5
 jDZbFEJqvWEO8ChF90xaG5f/D78NT4HSg4CCqp7lIi4Cv6Z36ufsHt34yUONpeXm9D2h
 9AqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627962; x=1744232762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9MO7LV0/gXNfytPX25lgbZnxOJWCw84WsDrMRmk30ac=;
 b=CG6J0PASxo0b9uPYgxgJ1b8xkX/AzI+7vfIeyMbBowv0c6kwQqf+cegIDKxUqzig68
 U9d0Jk7BCtzsDPR4cCXz+iJhuWulyGCT+gj0qd0x68pPRMAhyxhYa9JRVyBhWK1N4yPI
 nuBwGohSXOHjGCc78+sBTSWZlPyU/OFluNBYj7tQloq8K/t/lpTFg4pvHT4NQRkMq5K8
 TlLeup065uQKxEGL891ZPQDDBdPwwjtLK6xMUoq8ZO9tbtc7B02wM3ZEpk1NilZAQiXY
 782epYsa/ocAfkcYf/u7zzW+2BepJtiQA1lJoUy4kcJ0UNVHMEqA3qSP/2v7eBfFLFPU
 2NwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZrohvicdZhuDJ1HSGnLKCQL4yCk5GlPqlLcXk0WrmpNt7Acu9BUV/tf0IjuxBYRbq/2BzHIP+z/Oi@nongnu.org
X-Gm-Message-State: AOJu0Ywir4KoGnrydYcSC41A8OnWOyA2yn11wKLUt0WCvf1WBFGegOKT
 xjxBlt0FzoHXqCOab6zHeYzReF836qejv2SwP39P4oKeWAkp2JGuGp0NzTLsnW0=
X-Gm-Gg: ASbGnctzYw2aW1WEWgNHWayf+synFY9yuIJs5m4PwPkbRgFCdYPjD/C7whsCOmT9CpG
 kFnPVFdmLoSovbv1l5QPKC+9RVdjmpbRErU3RBIGhNk93NnFFGfirj1hh5pqQ6KcsDVvgeIv88f
 HR5mN0AHL9YLfQ8zhOTimSHug/n2SHejrYQmgBSu/nQ7r5AZDt/e7AbBh06F30l83QQ+iOQ6Vpo
 5tQLVO7XU70Bv5JyGURxXYTXmGWMyr+CZCQXUye8Dg7jlNqfi01ZxeUpOkd5bwsV2IWAu56WEI+
 +ly1agAG+phQZv1+6v1M7Ed6k67C6UVOPDGXSS2deRZu7uVH+cIIKiuWgnY1V3kOUAeAECv7Shy
 0Rd3Umlc7D629Ps38f98=
X-Google-Smtp-Source: AGHT+IGHB9VHwIFsdSrHADmcG7EBVXRGq0ohOrC1Cb24MLX9wwVHmFOuD93TroYIPKrE/DP8Tv0w6w==
X-Received: by 2002:a05:600c:1f17:b0:439:643a:c8d5 with SMTP id
 5b1f17b1804b1-43e99ab533cmr159971185e9.0.1743627962155; 
 Wed, 02 Apr 2025 14:06:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec24b22a0sm135735e9.6.2025.04.02.14.06.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:06:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 31/43] tcg: Always define TCG_GUEST_DEFAULT_MO
Date: Wed,  2 Apr 2025 23:03:16 +0200
Message-ID: <20250402210328.52897-32-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
 target/hexagon/cpu-param.h | 3 +++
 target/m68k/cpu-param.h    | 3 +++
 target/rx/cpu-param.h      | 3 +++
 target/sh4/cpu-param.h     | 3 +++
 target/tricore/cpu-param.h | 3 +++
 accel/tcg/translate-all.c  | 4 ----
 6 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/target/hexagon/cpu-param.h b/target/hexagon/cpu-param.h
index 635d509e743..7cc63a01d4b 100644
--- a/target/hexagon/cpu-param.h
+++ b/target/hexagon/cpu-param.h
@@ -25,4 +25,7 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
 
+/* MTTCG not yet supported: require strict ordering */
+#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
+
 #endif
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
index ed41fc5d0cc..cb1cf270888 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -352,11 +352,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
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


