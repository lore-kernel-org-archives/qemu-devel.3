Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58472C35FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 13:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tutju-0003JM-RI; Wed, 19 Mar 2025 09:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tutjr-0003BY-J3
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:45:43 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tutjp-00043r-EJ
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:45:43 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so46008515e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 06:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742391939; x=1742996739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pD8YI+wp8fAxGYCXUbWnDA857RwLaG+OiY+C78OOnko=;
 b=mDi72MQqymkWS7J3ocE66/1GdZSI3L44auqHOU2bTmCR/NXov57zhGJyIw68e72EXd
 Mtnu1bBLZpIkWW/8pSVvqnfJ1+/ByhF6tm2WgVboX6m/3lAKWYvrZbooKFD5VPmPT1Gx
 YBTM58RDrox9uv6sPk7J0RENvykmjtqZXB7Bo29DLBqOIjYr+dy64kd0Nqz1fqCnvgDP
 3b2i/ynj84Ja9j3KhyFj49CGcaxYjAzoeJdWlbfk5kPBSptxwrIX6XCFQG+T0SZWW1S1
 KBLPy0apqOnILd55AzrYhSc5LQPXrl7hY3V/we9JyWG9XC/vUsjKzob3x3HRNLZIQZBC
 wZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742391939; x=1742996739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pD8YI+wp8fAxGYCXUbWnDA857RwLaG+OiY+C78OOnko=;
 b=Br40DFa6htosJ0+WQDY96z52CbuGqdEneFy6rMO4nAdzuXb1K/d2tx+AgS0N5zkYUK
 DoRwAx8LVbrz1jh5y1GWJVXk/7e5kre2Gf8TSotMIeH1pbUOt8qyCDSIMCN0xJqoJmWJ
 ORvmS0stBX1We2d/WBAPIfVfisRmmrhDo5YPbxcnmsMEufSpKKpAXXIn58sdAc35y1a3
 xoR1i8bbagfDvKBm0EHEXkVArzUNCD8vTg3pttQBkcoTO06XwdwPI1UM0LkjqkjP92Hr
 l4klmabMGOGKkI4q/1AV/ZGfI5rUgHireuc8m8kWfLog/66iB+nqn7J9KtDBiAsZrGEI
 QRkw==
X-Gm-Message-State: AOJu0Yx42EGcmJn84KDQ5NlENgXjSvLkiodOQ+fM/4Y6qXe6+6sJkaD9
 lTNmPNxZudyIvpD+cvoZDcNaWquJ6XdwfRhb3bQsupMQZNQT2ib2MBlchLeIrSsQbXlOBsp7c0l
 c
X-Gm-Gg: ASbGncuAGZXu3RHrdbRm5SzaS0jTlkRwyv0mH7e9CqiQ/npfiQqZXcO7GWoGa5b4M3j
 +fXpT8GYJil2mGCuG696aikJutkytWlnK5TbzWf73lKJI19CWbXQuXQRvCrl2BLCUs7IEih0Yqo
 t2ZnTazOdngfmfielMjR2VQ1sBXzHxhTGQl6aHNu07pWHG7fWPmFJZXClbbGYVavIUOn5fDSEw+
 NtxSVfl8qSUWIG2NjqCcQ2O/qnWx3d0RYLHSQpnLnFWoTNHRn9U9OrNLyUUQuaBCBZfAPNvovPZ
 QXH8UNu4WlMEUK0175BGXBI3KQ3r6bPq3lB9H9joaGhi1L5xLCMRIuW52UjT+qZ7V/jaS0JUyOp
 9B/qWkSZmzAdHGJefmmc=
X-Google-Smtp-Source: AGHT+IGKa4oWttNsqHXMh8BDPvwSL/vQCmGeFIJ/lqir+cLPbnhbasw3uQmt0q22je6I0gU7fDYIFQ==
X-Received: by 2002:a05:600c:83c3:b0:43d:2230:300f with SMTP id
 5b1f17b1804b1-43d436ca01emr29911785e9.0.1742391939470; 
 Wed, 19 Mar 2025 06:45:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440eda26sm19201125e9.36.2025.03.19.06.45.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Mar 2025 06:45:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 06/12] tcg: Use TCGContext::insn_start_words in
 translate-all.c methods
Date: Wed, 19 Mar 2025 14:45:00 +0100
Message-ID: <20250319134507.45045-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250319134507.45045-1-philmd@linaro.org>
References: <20250319134507.45045-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Replace TARGET_INSN_START_WORDS -> tcg_ctx->insn_start_words
(see previous commit for justification).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/translate-all.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index a857aefd756..54bba995a04 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -131,19 +131,20 @@ static int encode_search(TranslationBlock *tb, uint8_t *block)
     uint8_t *highwater = tcg_ctx->code_gen_highwater;
     uint64_t *insn_data = tcg_ctx->gen_insn_data;
     uint16_t *insn_end_off = tcg_ctx->gen_insn_end_off;
+    unsigned insn_start_words = tcg_ctx->insn_start_words;
     uint8_t *p = block;
     int i, j, n;
 
     for (i = 0, n = tb->icount; i < n; ++i) {
         uint64_t prev, curr;
 
-        for (j = 0; j < TARGET_INSN_START_WORDS; ++j) {
+        for (j = 0; j < insn_start_words; ++j) {
             if (i == 0) {
                 prev = (!(tb_cflags(tb) & CF_PCREL) && j == 0 ? tb->pc : 0);
             } else {
-                prev = insn_data[(i - 1) * TARGET_INSN_START_WORDS + j];
+                prev = insn_data[(i - 1) * insn_start_words + j];
             }
-            curr = insn_data[i * TARGET_INSN_START_WORDS + j];
+            curr = insn_data[i * insn_start_words + j];
             p = encode_sleb128(p, curr - prev);
         }
         prev = (i == 0 ? 0 : insn_end_off[i - 1]);
@@ -167,6 +168,7 @@ static int cpu_unwind_data_from_tb(TranslationBlock *tb, uintptr_t host_pc,
 {
     uintptr_t iter_pc = (uintptr_t)tb->tc.ptr;
     const uint8_t *p = tb->tc.ptr + tb->tc.size;
+    unsigned insn_start_words = tcg_ctx->insn_start_words;
     int i, j, num_insns = tb->icount;
 
     host_pc -= GETPC_ADJ;
@@ -175,7 +177,7 @@ static int cpu_unwind_data_from_tb(TranslationBlock *tb, uintptr_t host_pc,
         return -1;
     }
 
-    memset(data, 0, sizeof(uint64_t) * TARGET_INSN_START_WORDS);
+    memset(data, 0, sizeof(uint64_t) * insn_start_words);
     if (!(tb_cflags(tb) & CF_PCREL)) {
         data[0] = tb->pc;
     }
@@ -185,7 +187,7 @@ static int cpu_unwind_data_from_tb(TranslationBlock *tb, uintptr_t host_pc,
      * at which the end of the insn exceeds host_pc.
      */
     for (i = 0; i < num_insns; ++i) {
-        for (j = 0; j < TARGET_INSN_START_WORDS; ++j) {
+        for (j = 0; j < insn_start_words; ++j) {
             data[j] += decode_sleb128(&p);
         }
         iter_pc += decode_sleb128(&p);
@@ -443,6 +445,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
         if (logfile) {
             int code_size, data_size;
             const tcg_target_ulong *rx_data_gen_ptr;
+            unsigned insn_start_words = tcg_ctx->insn_start_words;
             size_t chunk_start;
             int insn = 0;
 
@@ -460,7 +463,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
             fprintf(logfile, "OUT: [size=%d]\n", gen_code_size);
             fprintf(logfile,
                     "  -- guest addr 0x%016" PRIx64 " + tb prologue\n",
-                    tcg_ctx->gen_insn_data[insn * TARGET_INSN_START_WORDS]);
+                    tcg_ctx->gen_insn_data[insn * insn_start_words]);
             chunk_start = tcg_ctx->gen_insn_end_off[insn];
             disas(logfile, tb->tc.ptr, chunk_start);
 
@@ -473,7 +476,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
                 size_t chunk_end = tcg_ctx->gen_insn_end_off[insn];
                 if (chunk_end > chunk_start) {
                     fprintf(logfile, "  -- guest addr 0x%016" PRIx64 "\n",
-                            tcg_ctx->gen_insn_data[insn * TARGET_INSN_START_WORDS]);
+                            tcg_ctx->gen_insn_data[insn * insn_start_words]);
                     disas(logfile, tb->tc.ptr + chunk_start,
                           chunk_end - chunk_start);
                     chunk_start = chunk_end;
-- 
2.47.1


