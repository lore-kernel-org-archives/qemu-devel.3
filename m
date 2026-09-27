Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D60C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkpM-0007zR-93; Sun, 27 Sep 2026 05:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkoM-0005iQ-IJ
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:42 -0400
Received: from mail-pj2-x0c.google.com ([2607:f8b0:4864:39::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkoJ-0007j9-6b
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:41 -0400
Received: by mail-pj2-x0c.google.com with SMTP id
 98e67ed59e1d1-3a0d31bda43so888650a91.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499878; x=1791104678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tUUNLz8lYScv/+rheYXCIAhl2z60y1qLZmtOekMyZPM=;
 b=nkaPnA7pf7MDU+hypg4zHicz36C88Tc6PC0Bltc0s6/fBB14ps8t4ZRa2kvgCm/vyC
 aSTucDbpbWB6KBGR8LkDvWDQitPcb8krdMmtk207gvxie6hOr6LfhGXN7oVWjOLfn8wT
 QDFJcsPDaMA0fMkDKSLBIH1b0HUuMLzanpoN6BYNbF1gbI0mgNsBHkZ3/7IiZqWbKEaF
 toD7SX7Ye+PnIGChRgPxlxn8JtpkfcuEX7RsuCMO4b/LNDZzEYeil3WsDOH2baSginVN
 AFevysWSU7kx7YNzcIyEM57UQCzCseuW/ALV+ohbM4R9QqLNchmxqbVkqPL6FOeBgsMp
 Je0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499878; x=1791104678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tUUNLz8lYScv/+rheYXCIAhl2z60y1qLZmtOekMyZPM=;
 b=na0lTnrb6sgLU8dSfKXtHkQldUpmTZrHZNWwWmxv3MCL+pul/tN7vWHkmxhDg+3AqO
 /65pGChGJL6qRrWf91H3OqT206C36gE1yIIk6UBhGjlJGqHGqe/BND7cte8Lt9HCz+oF
 OF/baDLo6d32104kHJSRpxRla5BsGl191uL3nnGSDv0fwK8xIabktlxEaxHnMQ1TInN1
 u3HljRl4kxNLMT0fIbUCnVstkb4yeZaNK+UdkE7wfGnJcwU2PeAyYGJCMCG4g6RHJWVE
 htH4MOVADSulO43oNGF1kwiEMs8liddWA3TC/eVg+5HqGmaCa6JE2lVwml5FHGYiuM2E
 Bq1w==
X-Gm-Message-State: AFq9FYIch7KDkKKrdp0rjhOuD1nIr50RWi4Mnc6g3siID3EsQM3TOL1t
 7fLNSV9qx1hV8JA6GIdiz9iOH8xyWIMBOPHtRqLtbTeLXroqFQlDNF6DuEcgep1f33kaQkd0l9v
 deNgX
X-Gm-Gg: AYBFou0h6TUU62zta+xm/Je/6LxaFpRIMIZk1HYlCNqyvJiS/EgWOz98aT/SUrxu32S
 9BNXyo0Nyc8VN0TlwHhYpTFqNhM/4HrcV4Bq/BxIC58M5AYLwRT7MXFBUBDqWUJk3mC4cOTPIUo
 Tmdkthav8jmxh2FgD5g/dUR4ThZ6N8PoPnAVCRegvjOz6ypFme6JCoKh0E8PA0BqtT8nOxNeg4y
 /KyI33gK0To5VerzOgCcJ6G9yUdQ8Bq/erUM0Y+knyATakt/OdBrXb91fBCCbEMK34H2q+XA50v
 VNiJOjD+gFiy59rlajKYu9DYsK27uEbZXoGhlcYoPSOw77fDHRfrRYWi2ZWbpFNZbeGvkJThIJt
 IBV6nNI4NYuG4lrOmQJWxncosGFiKDO9mGr6hQHhm0n/i8Ur65qsU+JU5CGvtMTg2gTKhIiAMUR
 8OjC6iP8d725/RM2AiVvyhnkRKvc7qIb3pLYojhEOLNyKD4qr6M2WFBqYooluosrlRK2TLmFjPV
 hO6DXR6EHBRmiws5uXduiDBVrh/VROENpcsyr3d
X-Received: by 2002:a17:90b:4c51:b0:3a2:a576:f67a with SMTP id
 98e67ed59e1d1-3a2a576fc30mr1314001a91.52.1790499877739; 
 Sun, 27 Sep 2026 02:04:37 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.04.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:04:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 079/101] tcg: Generic expansion of tcg_gen_addcio_*
Date: Sun, 27 Sep 2026 01:59:49 -0700
Message-ID: <20260927090011.10724-80-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  4 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 77 +++++++++++-------------------------
 3 files changed, 24 insertions(+), 58 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 9fbf582e413..9cc941478ba 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -136,8 +136,6 @@ void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
-void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
-                        TCGv_i32 a, TCGv_i32 b, TCGv_i32 ci);
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -166,8 +164,6 @@ void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
-void tcg_gen_addcio_i64(TCGv_i64 r, TCGv_i64 co,
-                        TCGv_i64 a, TCGv_i64 b, TCGv_i64 ci);
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index a237ccd0c51..003384b65df 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -4,6 +4,7 @@
 DEF2(abs, TCGV, TCGV)
 DEF3(add, TCGV, TCGV, TCGV)
 DEF3(addi, TCGV, TCGV, TINT)
+DEF5(addcio, TCGV, TCGV, TCGV, TCGV, TCGV)
 DEF3(and, TCGV, TCGV, TCGV)
 DEF3(andi, TCGV, TCGV, TINT)
 DEF3(andc, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 98f21004a84..eb59bc37631 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -346,6 +346,29 @@ void tcg_gen_addi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+void tcg_gen_addcio(TCGType type, TCGTemp *r, TCGTemp *co,
+                    TCGTemp *a, TCGTemp *b, TCGTemp *ci)
+{
+    g_autoptr(TCGTemp) t0 = tcg_temp_new_ebb(type);
+
+    if (tcg_op_supported(INDEX_op_addci, type, 0)) {
+        TCGTemp *zero = tcg_constant_internal(type, 0);
+        TCGTemp *mone = tcg_constant_internal(type, -1);
+
+        tcg_gen_op_ttt(INDEX_op_addco, type, t0, ci, mone);
+        tcg_gen_op_ttt(INDEX_op_addcio, type, r, a, b);
+        tcg_gen_op_ttt(INDEX_op_addci, type, co, zero, zero);
+    } else {
+        g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(type);
+
+        tcg_gen_add(type, t0, a, b);
+        tcg_gen_setcond(type, TCG_COND_LTU, t1, t0, a);
+        tcg_gen_add(type, r, t0, ci);
+        tcg_gen_setcond(type, TCG_COND_LTU, t0, r, t0);
+        tcg_gen_or(type, co, t0, t1);
+    }
+}
+
 void tcg_gen_and(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_and, type, dst, src1, src2);
@@ -1147,33 +1170,6 @@ void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
     }
 }
 
-void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
-                        TCGv_i32 a, TCGv_i32 b, TCGv_i32 ci)
-{
-    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 zero = tcg_constant_i32(0);
-        TCGv_i32 mone = tcg_constant_i32(-1);
-
-        tcg_gen_op3_i32(INDEX_op_addco, t0, ci, mone);
-        tcg_gen_op3_i32(INDEX_op_addcio, r, a, b);
-        tcg_gen_op3_i32(INDEX_op_addci, co, zero, zero);
-        tcg_temp_free_i32(t0);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-
-        tcg_gen_add_i32(t0, a, b);
-        tcg_gen_setcond_i32(TCG_COND_LTU, t1, t0, a);
-        tcg_gen_add_i32(r, t0, ci);
-        tcg_gen_setcond_i32(TCG_COND_LTU, t0, r, t0);
-        tcg_gen_or_i32(co, t0, t1);
-
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
-    }
-}
-
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
 {
@@ -1684,33 +1680,6 @@ void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
     }
 }
 
-void tcg_gen_addcio_i64(TCGv_i64 r, TCGv_i64 co,
-                        TCGv_i64 a, TCGv_i64 b, TCGv_i64 ci)
-{
-    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I64, 0)) {
-        TCGv_i64 discard = tcg_temp_ebb_new_i64();
-        TCGv_i64 zero = tcg_constant_i64(0);
-        TCGv_i64 mone = tcg_constant_i64(-1);
-
-        tcg_gen_op3_i64(INDEX_op_addco, discard, ci, mone);
-        tcg_gen_op3_i64(INDEX_op_addcio, r, a, b);
-        tcg_gen_op3_i64(INDEX_op_addci, co, zero, zero);
-        tcg_temp_free_i64(discard);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-
-        tcg_gen_add_i64(t0, a, b);
-        tcg_gen_setcond_i64(TCG_COND_LTU, t1, t0, a);
-        tcg_gen_add_i64(r, t0, ci);
-        tcg_gen_setcond_i64(TCG_COND_LTU, t0, r, t0);
-        tcg_gen_or_i64(co, t0, t1);
-
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b)
 {
     tcg_debug_assert(n > 2);
-- 
2.53.0


