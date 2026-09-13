Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CB0C88E53
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a8D-0001Wm-1a; Sat, 12 Sep 2026 22:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7e-0008SI-6v
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:15 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7a-00012q-8p
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:13 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccda24afso681105a91.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267147; x=1789871947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BZvUUSdPOwlXPFtmsxk5REpukmqyCDmE1WQT2kDCsqU=;
 b=W4O9OMe2AyrNDfpy5vZOumpX+mu2FICr68e2VyaN16hcxYU2rEu3YkHm/6cz1CCISY
 KRXr34b+uaVwBjM1VBQdwqEUcb86086ljMba1u6JMX9kXhP6O/zidpRMG2rRXzId7es1
 xRqiX8h2F2iCWtoaIGN5JxDodtBP9/ATvsfMgEr5lB0OpeEECvATx64wPyQOVZuYtKXp
 rVR+MajcxeUdh9i/npe+diPHZJ/jHN7A7LqA2Oer6tVc+UfnE+ZWTEIcVTPwbAz5ZzU3
 c6x1qFQTFf1svQVluQjMJs5t2DQTt7Pp9D/0HBD3Sd2mf/THHLp37t/nfRtN9kdwogj8
 H2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267147; x=1789871947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BZvUUSdPOwlXPFtmsxk5REpukmqyCDmE1WQT2kDCsqU=;
 b=TOSQamarFhs8PlBwWPfXNL8j/5wfFt0MSO6y2PXzDj+PZZe0Gb+mFhXIxa2fKgmJ2u
 mI4Bxl1rJzYa8acK59m/kb6JGppepXDaC+rGEMaQTU3tEU+jbLLsxh6bOPZixpWlK4Hs
 +ufoLF8IP9Iarpl/pJgv8ZVLMhwqGW3DaCIRuyuUOW8fMZvS8NglIkktiSxVSTBRaf19
 KWEWhH+VlVACnlj9OGr5BzrbCC70YWsl2p4iG3PX7f9A+h3wLa9+IC0pbhEbR3eVLSRX
 6pYnbPkboMzwIP2G+v7zxA59o2UM4rqWNp9VLlYa4us09XRPg9LKqNwFineg7alGC7Dr
 hk8Q==
X-Gm-Message-State: AFuF++l/Uv8SKaZ98gmJSab6GH47FJ9qIkTtOYXLORWOv3zIhBm/v8uU
 GBTiniN1ESNU7zYVAJ2ueXR5TCIeMG3NejurJIgOvlZpkx2MWEGlgrMYMPsWcUNLMWNgvmzjdVU
 VILHN
X-Gm-Gg: AYBFou36qm0IKcp6cMgJoONibl3sF5oGsnU4RngRqYRYlPItUiMoB4cz0nAemzr2j4w
 99YoK5ZzjF9mMhlfVyuzNzwSGXOraDaWt2Q/7FedlpyUjL819yx4M1phOSv8Wxzz54enA9nVgDr
 61L6e4FP9J+0yIZHadzeLLQDkUF7015T5Vpnm9/NZyoibcizR9vR1ki1mBnNKdyTsAshF8ida4e
 12VQRcyTY/W/jZn1rHcDgbB/Tg0oSR8uW4qgC/aFA4dCZA3GerLB1oSB1bV1dWydR0wg14TCXFZ
 ib0PG7C1b81VygmK6CTu/YtSlT4Vjc9Gq3NMHj2iXOZDWNki8wq2EtOmqnXknzCfmgLqUtcvfoi
 0wq77p8GfsvTpnsak9fwHsCSm/3nF70aOd1BjfIMoooscofkQAuHdHXlEsmw+PMgVI0djv7RCSm
 MmyW09kKDN8+FMSsS7y2A39U0nfQYloPYQ/ZwB8al8e8Z/xVcVuE6JKxGquN0O+pvoJmJ3Jh1Tm
 /7pQOQ=
X-Received: by 2002:a17:90b:4fc5:b0:399:149a:3f27 with SMTP id
 98e67ed59e1d1-39d9bd71246mr20316092a91.9.1789267147057; 
 Sat, 12 Sep 2026 19:39:07 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.39.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:39:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 24/86] tcg: Generic expansion of tcg_gen_xori_*
Date: Sat, 12 Sep 2026 16:37:35 -1000
Message-ID: <20260913023837.741866-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 34 +++++++++-------------------------
 3 files changed, 10 insertions(+), 27 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index cee21891451..80e6f77c379 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -209,7 +208,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 2c3604cc7ed..b620a314480 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -21,3 +21,4 @@ DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
 DEF3(xor, TCGV, TCGV, TCGV)
+DEF3(xori, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index b2bd2f51e1a..0e6c21e9077 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -558,22 +558,20 @@ static void gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_xor, type, dst, src1, src2);
 }
 
-/* 32 bit ops */
-
-void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
+static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 {
-    /* Some cases can be optimized here.  */
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else if (arg2 == -1 &&
-               tcg_op_supported(INDEX_op_not, TCG_TYPE_I32, 0)) {
-        /* Don't recurse with tcg_gen_not_i32.  */
-        tcg_gen_op2_i32(INDEX_op_not, ret, arg1);
+    if (src2 == 0) {
+        gen_mov(type, dst, src1);
+    } else if (src2 == -1 && tcg_op_supported(INDEX_op_not, type, 0)) {
+        /* Do not recurse with gen_not.  */
+        gen_op_tt(INDEX_op_not, type, dst, src1);
     } else {
-        tcg_gen_xor_i32(ret, arg1, tcg_constant_i32(arg2));
+        gen_xor(type, dst, src1, tcg_constant_internal(type, src2));
     }
 }
 
+/* 32 bit ops */
+
 void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     if (tcg_op_supported(INDEX_op_not, TCG_TYPE_I32, 0)) {
@@ -1526,20 +1524,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    /* Some cases can be optimized here.  */
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else if (arg2 == -1 &&
-               tcg_op_supported(INDEX_op_not, TCG_TYPE_I64, 0)) {
-        /* Don't recurse with tcg_gen_not_i64.  */
-        tcg_gen_op2_i64(INDEX_op_not, ret, arg1);
-    } else {
-        tcg_gen_xor_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_brcond_i64(TCGCond cond, TCGv_i64 arg1, TCGv_i64 arg2, TCGLabel *l)
 {
     if (cond == TCG_COND_ALWAYS) {
-- 
2.53.0


