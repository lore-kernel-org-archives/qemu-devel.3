Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F617EDF021
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 03:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqNTe-0007lG-2x; Wed, 11 Feb 2026 22:34:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vqNTc-0007jH-Oi
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 22:34:48 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vqNTa-0008Hx-Uk
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 22:34:48 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-45f004e7d71so1040187b6e.1
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 19:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770867285; x=1771472085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1vV/gFCM2s8n0DXOgCi7/aaN4xg+tYlUyC1onltEOpg=;
 b=mvI3c4OMYZ5M4M0wrmXmv4aipIQszeJ8b3xXjLG13JcuhXT2GdBLS/MEdSBD/cH2Nm
 V03eleCzMIAg3eLuctpSLFKqy4k4ZytmjAnut2b5r/iCPrvjkAKiCqa0QtQruf8hKkVJ
 Si4JngSX+dEBnAAf2mWPeaTVCwQsX/i1EnFmjXoEOqAhNqhQOczQ6zgZPc7amEAtk5sw
 tGalGIp3A0muZfphRD3MGN8/D/bJV6r3RYEqUEmc2xy6MaYA1AEqWBUeZieU9pfVvn10
 lIsFGrJqxPCzbllBkv3obqdgnhbONuRv6RUm2NdY0wkv93Fbq5deyfo29sm7B3+v4nHB
 P80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770867285; x=1771472085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1vV/gFCM2s8n0DXOgCi7/aaN4xg+tYlUyC1onltEOpg=;
 b=D7vIJXFML6HbakHtN6n/Q0jltgHtg2Sp2Sd6AccudxTa7M/z9+x3O9ju8k15+C9mLl
 q79DIbHqjLijAhI1eERx7kqISeesFPXJEmHXPdhCIt5CRS7wnJ6S17DAIMttZOr/INfL
 HFblzj4ao0bHFM/YUHtK9pQHJiRUd6YhOGqUh16VjY5veYtHURHRp05CPau+VXGHVyus
 SZ6SM01cTB2SKa+G2Xes9NZc0/dji1PuT7bepgHux9RaXY96eQ8HN00JPCMrX2W51kDU
 4i9UIgoAkp372bhtuWprBBb0xMBHLIAsZ2sIzh/fKowA5n+cKb+Ta1iAzvQV0XHbyMYd
 Qd0Q==
X-Gm-Message-State: AOJu0YxacakMsLGWe3+2FPfrgarUsM+zg9/hP9m6fznMopyoYahHV3DD
 YtYm1KVoLYDLrGz8rWkKv/7ehj0TNiBuyVZ6Le0f5diW/5B9YgL+T+qtZy0JBQ==
X-Gm-Gg: AZuq6aLjoINX+S3R7HsRQXhxgFKRTKWwrLgQwX5qIQY6HWa5E/1gxqNrpIJxSWuK36U
 Oz1PhCxJm2lTUe6GfBBJ0Rel4HxZmMa2DBfDkS4etXnEZ8X8DP+/CR9l4WV2mTIH6KJDLIl2v4U
 7Qnq+mFSeIxaIvPgEJAWBGb8kFRtM9szbIpkayE5TshBQ49CyR+AODBLRjD4u6x6SWBZHjIIVzN
 dDB5PkzJydft3Ray+pZIF8idsKVSQSaaNKDqfPD15R2JvCB/Sq/HisVgmzNtT90AfvlvXc8V/ZY
 G8kH96YTKfmhFFZAXLiX0SSg6Fe1SrRFP2akRzYCKKKNnhHV6MWjzGppGiM6cUi5dmSuPGqOOLU
 Edf/BPABudBPI1jdoqrUSzQGp5GzzHbYccDe26bnX58DmKq91N4TeWnb8tmD3h7a8jtrR1MxR/4
 P+2JGg06amRwCONo9LKkxjZGZdTD92lzY4HY+b7jaVI2TY8K8gakFM7qHSuc0dcgEtmHwVY6UQt
 nqGE4mbORPETIwW
X-Received: by 2002:a05:6808:4fca:b0:43b:7b80:5cf2 with SMTP id
 5614622812f47-4637dbbb583mr786348b6e.11.1770867285460; 
 Wed, 11 Feb 2026 19:34:45 -0800 (PST)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a76e1b0csm2682858a34.14.2026.02.11.19.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 19:34:45 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH 6/8] Hexagon (linux-user/hexagon) Convert INVALID_PACKET into
 SIGILL
Date: Wed, 11 Feb 2026 20:34:33 -0700
Message-ID: <20260212033435.3598-7-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260212033435.3598-1-ltaylorsimpson@gmail.com>
References: <20260212033435.3598-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Brian Cain <brian.cain@oss.qualcomm.com>

tests/tcg/hexagon: Handle SIGILL internally in invalid-slots test

Rewrite invalid-slots.c to catch and verify SIGILL using a sigaction
handler that modifies the ucontext, matching the pattern used by
invalid-encoding.c.

Co-authored-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Co-authored-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 linux-user/hexagon/cpu_loop.c     |  4 ++
 target/hexagon/translate.c        | 19 +++++++-
 tests/tcg/hexagon/invalid-slots.c | 76 ++++++++++++++++++++++++-------
 tests/tcg/hexagon/Makefile.target |  6 ---
 4 files changed, 80 insertions(+), 25 deletions(-)

diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.c
index 1941f4c9c1..c0e1098e3f 100644
--- a/linux-user/hexagon/cpu_loop.c
+++ b/linux-user/hexagon/cpu_loop.c
@@ -64,6 +64,10 @@ void cpu_loop(CPUHexagonState *env)
             force_sig_fault(TARGET_SIGBUS, TARGET_BUS_ADRALN,
                             env->gpr[HEX_REG_R31]);
             break;
+        case HEX_CAUSE_INVALID_PACKET:
+            force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC,
+                            env->gpr[HEX_REG_PC]);
+            break;
         case EXCP_ATOMIC:
             cpu_exec_step_atomic(cs);
             break;
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 9498cd4502..78e0d6c219 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -198,6 +198,21 @@ static void gen_exception_end_tb(DisasContext *ctx, int excp)
 
 }
 
+/*
+ * Generate exception for decode failures. Unlike gen_exception_end_tb,
+ * this is used when decode fails before ctx->next_PC is initialized.
+ */
+static void gen_exception_decode_fail(DisasContext *ctx, int nwords, int excp)
+{
+    target_ulong fail_pc = ctx->base.pc_next + nwords * sizeof(uint32_t);
+
+    gen_exec_counters(ctx);
+    tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], fail_pc);
+    gen_exception_raw(excp);
+    ctx->base.is_jmp = DISAS_NORETURN;
+    ctx->base.pc_next = fail_pc;
+}
+
 static int read_packet_words(CPUHexagonState *env, DisasContext *ctx,
                              uint32_t words[])
 {
@@ -935,7 +950,7 @@ static void decode_and_translate_packet(CPUHexagonState *env, DisasContext *ctx)
 
     nwords = read_packet_words(env, ctx, words);
     if (!nwords) {
-        gen_exception_end_tb(ctx, HEX_CAUSE_INVALID_PACKET);
+        gen_exception_decode_fail(ctx, 0, HEX_CAUSE_INVALID_PACKET);
         return;
     }
 
@@ -950,7 +965,7 @@ static void decode_and_translate_packet(CPUHexagonState *env, DisasContext *ctx)
         gen_commit_packet(ctx);
         ctx->base.pc_next += pkt.encod_pkt_size_in_bytes;
     } else {
-        gen_exception_end_tb(ctx, HEX_CAUSE_INVALID_PACKET);
+        gen_exception_decode_fail(ctx, nwords, HEX_CAUSE_INVALID_PACKET);
     }
 }
 
diff --git a/tests/tcg/hexagon/invalid-slots.c b/tests/tcg/hexagon/invalid-slots.c
index 366ce4f42f..607027f314 100644
--- a/tests/tcg/hexagon/invalid-slots.c
+++ b/tests/tcg/hexagon/invalid-slots.c
@@ -1,29 +1,71 @@
 /*
- *  Copyright(c) 2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ * Test that invalid slot assignments are properly rejected.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
+#include <assert.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+static void *resume_pc;
+
+static void handle_sigill(int sig, siginfo_t *info, void *puc)
+{
+    ucontext_t *uc = (ucontext_t *)puc;
+
+    if (sig != SIGILL) {
+        _exit(EXIT_FAILURE);
+    }
+
+    uc->uc_mcontext.r0 = SIGILL;
+    uc->uc_mcontext.pc = (unsigned long)resume_pc;
+}
+
 char mem[8] __attribute__((aligned(8)));
 
-int main()
+/*
+ * Invalid packet with 2 instructions at slot 0:
+ * - Word 0: 0xa1804100 = memw(r0) = r1
+ * - Word 1: 0x28032804 = { r3 = #0; r4 = #0 }
+ *
+ * This should raise SIGILL due to the invalid slot assignment.
+ */
+static int test_invalid_slots(void)
 {
+    int sig;
+
     asm volatile(
+        "r0 = #0\n"
+        "r1 = ##1f\n"
+        "memw(%1) = r1\n"
         "r0 = #mem\n"
-        /* Invalid packet (2 instructions at slot 0): */
         ".word 0xa1804100\n" /* { memw(r0) = r1;      */
         ".word 0x28032804\n" /*   r3 = #0; r4 = #0 }  */
-        : : : "r0", "r3", "r4", "memory");
-    return 0;
+        "1:\n"
+        "%0 = r0\n"
+        : "=r"(sig)
+        : "r"(&resume_pc)
+        : "r0", "r1", "r3", "r4", "memory");
+
+    return sig;
+}
+
+int main()
+{
+    struct sigaction act;
+
+    memset(&act, 0, sizeof(act));
+    act.sa_sigaction = handle_sigill;
+    act.sa_flags = SA_SIGINFO;
+    assert(sigaction(SIGILL, &act, NULL) == 0);
+
+    assert(test_invalid_slots() == SIGILL);
+
+    puts("PASS");
+    return EXIT_SUCCESS;
 }
diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile.target
index e5182c01d8..8c9d48fc4d 100644
--- a/tests/tcg/hexagon/Makefile.target
+++ b/tests/tcg/hexagon/Makefile.target
@@ -53,12 +53,6 @@ HEX_TESTS += hvx_histogram
 HEX_TESTS += invalid-slots
 HEX_TESTS += unaligned_pc
 
-run-and-check-exception = $(call run-test,$2,$3 2>$2.stderr; \
-	test $$? -eq 1 && grep -q "exception $(strip $1)" $2.stderr)
-
-run-invalid-slots: invalid-slots
-	$(call run-and-check-exception, 0x15, $@, $(QEMU) $(QEMU_OPTS) $<)
-
 HEX_TESTS += test_abs
 HEX_TESTS += test_bitcnt
 HEX_TESTS += test_bitsplit
-- 
2.43.0


