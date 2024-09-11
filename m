Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD76CEE57C6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 16:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soQYW-0002Ck-9V; Wed, 11 Sep 2024 12:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYU-00024z-5T
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:50:58 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYS-0003ey-2k
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:50:57 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7163489149eso71387a12.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 09:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726073455; x=1726678255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m+T4dcqyJxvJdq82j2M/HcYPFc2eysHobPrKz3oAZqo=;
 b=cvVK1PcvCMWYn35CN/50Cmg/b1JmxKH99U4Wnwe/M1THKD182wjK43f7yu55xiILC3
 eqlIrNhBqvoKeE9y7rlw90JMVlgjtf1koKN1yleRq5O+WaWYsWiYOr9Ewm0u/PihP27x
 mZuwpZcawFQYPfC1Z/DAITw4rVQmQsa+RYB5cLvVZ+kSV8eCMsSK1cw3/sISg26MI81Q
 BkIXNXFbwb/VncOFXVPsZBJ9fBb3P+NFWv+DcbqTOUP58ZM+S71rMq3bX57wVVxdTYy7
 998Nz8Q34AdWvEznSYwcy57c3/Py5e4489zqvDUGPTdb+9whCrApH6dEdU51oAnBTXZG
 z25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726073455; x=1726678255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m+T4dcqyJxvJdq82j2M/HcYPFc2eysHobPrKz3oAZqo=;
 b=ncO8+y2QWfHE7Wkqe2ClJP9/9VvFSLI0j7OCk//bm1zuavK/dDV6VAy1Ua9DtT7aaq
 ZhippeHnd0BMIsM91YaBSY74ElNlm3coVzAZ6QBz3q5QDtnDTZQupjOF1UG1UL+lRoBf
 2f/PTKhJrzMKend3+8JlJlqTR9A+uH0v4i7s7Hr2AM3BFcWzhnzKE3MN5KxxbI/uS6B3
 HQ8fH+uoYV4GnZ4Rjgp9kag9DSo5YV16TVUtFQlhqM5xgSaPiv3KImzRb133K6MsvYCD
 flhCgZN+x+FQKcQ41aiOiFbPT+OX+UAAcL1/h1s3K+L4FJR4j6SIgdRirWPiPiKXwGBr
 Z8cA==
X-Gm-Message-State: AOJu0YxgU/C5trE6XhUL5E58HefwqjgfCn1lmuFkBAwAPbvtOPBjPOuw
 PnLDSwX2Gv03uF9m+/lnDtMncTl0GNSful1qt26CVwg3YhggZNGR7FkpbZgDG+3AOUH74SiDNCi
 L
X-Google-Smtp-Source: AGHT+IG1WlnVTprn91dLrD91pQiFsNcwtLYy9qZqauWcbpS5Jm3c4v1D+QxnQc7u8q8EYzABrUzqBQ==
X-Received: by 2002:a05:6300:41:b0:1cf:1fbd:9299 with SMTP id
 adf61e73a8af0-1cf5e1f6738mr7490421637.49.1726073454688; 
 Wed, 11 Sep 2024 09:50:54 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe4e7esm3186947b3a.80.2024.09.11.09.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 09:50:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 philmd@linaro.org
Subject: [PATCH v2 06/18] tcg/s390x: Do not expand cmp_vec early
Date: Wed, 11 Sep 2024 09:50:35 -0700
Message-ID: <20240911165047.1035764-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240911165047.1035764-1-richard.henderson@linaro.org>
References: <20240911165047.1035764-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

Move expansion to opcode generation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/s390x/tcg-target.c.inc | 139 +++++++++++++++++--------------------
 1 file changed, 65 insertions(+), 74 deletions(-)

diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index ad587325fc..23935fd0f0 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2841,6 +2841,67 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
     tcg_out_insn(s, VRX, VLREP, dst, TCG_TMP0, TCG_REG_NONE, 0, MO_64);
 }
 
+static bool tcg_out_cmp_vec_noinv(TCGContext *s, unsigned vece, TCGReg a0,
+                                  TCGReg a1, TCGReg a2, TCGCond cond)
+{
+    bool need_swap = false, need_inv = false;
+
+    switch (cond) {
+    case TCG_COND_EQ:
+    case TCG_COND_GT:
+    case TCG_COND_GTU:
+        break;
+    case TCG_COND_NE:
+    case TCG_COND_LE:
+    case TCG_COND_LEU:
+        need_inv = true;
+        break;
+    case TCG_COND_LT:
+    case TCG_COND_LTU:
+        need_swap = true;
+        break;
+    case TCG_COND_GE:
+    case TCG_COND_GEU:
+        need_swap = need_inv = true;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (need_inv) {
+        cond = tcg_invert_cond(cond);
+    }
+    if (need_swap) {
+        TCGReg swap = a1;
+        a1 = a2;
+        a2 = swap;
+        cond = tcg_swap_cond(cond);
+    }
+
+    switch (cond) {
+    case TCG_COND_EQ:
+        tcg_out_insn(s, VRRc, VCEQ, a0, a1, a2, vece);
+        break;
+    case TCG_COND_GT:
+        tcg_out_insn(s, VRRc, VCH, a0, a1, a2, vece);
+        break;
+    case TCG_COND_GTU:
+        tcg_out_insn(s, VRRc, VCHL, a0, a1, a2, vece);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return need_inv;
+}
+
+static void tcg_out_cmp_vec(TCGContext *s, unsigned vece, TCGReg a0,
+                            TCGReg a1, TCGReg a2, TCGCond cond)
+{
+    if (tcg_out_cmp_vec_noinv(s, vece, a0, a1, a2, cond)) {
+        tcg_out_insn(s, VRRc, VNO, a0, a0, a0, 0);
+    }
+}
+
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                            unsigned vecl, unsigned vece,
                            const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2959,19 +3020,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         break;
 
     case INDEX_op_cmp_vec:
-        switch ((TCGCond)args[3]) {
-        case TCG_COND_EQ:
-            tcg_out_insn(s, VRRc, VCEQ, a0, a1, a2, vece);
-            break;
-        case TCG_COND_GT:
-            tcg_out_insn(s, VRRc, VCH, a0, a1, a2, vece);
-            break;
-        case TCG_COND_GTU:
-            tcg_out_insn(s, VRRc, VCHL, a0, a1, a2, vece);
-            break;
-        default:
-            g_assert_not_reached();
-        }
+        tcg_out_cmp_vec(s, vece, a0, a1, a2, args[3]);
         break;
 
     case INDEX_op_s390_vuph_vec:
@@ -3024,8 +3073,8 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_umax_vec:
     case INDEX_op_umin_vec:
     case INDEX_op_xor_vec:
-        return 1;
     case INDEX_op_cmp_vec:
+        return 1;
     case INDEX_op_cmpsel_vec:
     case INDEX_op_rotrv_vec:
         return -1;
@@ -3039,68 +3088,14 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     }
 }
 
-static bool expand_vec_cmp_noinv(TCGType type, unsigned vece, TCGv_vec v0,
-                                 TCGv_vec v1, TCGv_vec v2, TCGCond cond)
-{
-    bool need_swap = false, need_inv = false;
-
-    switch (cond) {
-    case TCG_COND_EQ:
-    case TCG_COND_GT:
-    case TCG_COND_GTU:
-        break;
-    case TCG_COND_NE:
-    case TCG_COND_LE:
-    case TCG_COND_LEU:
-        need_inv = true;
-        break;
-    case TCG_COND_LT:
-    case TCG_COND_LTU:
-        need_swap = true;
-        break;
-    case TCG_COND_GE:
-    case TCG_COND_GEU:
-        need_swap = need_inv = true;
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
-    if (need_inv) {
-        cond = tcg_invert_cond(cond);
-    }
-    if (need_swap) {
-        TCGv_vec t1;
-        t1 = v1, v1 = v2, v2 = t1;
-        cond = tcg_swap_cond(cond);
-    }
-
-    vec_gen_4(INDEX_op_cmp_vec, type, vece, tcgv_vec_arg(v0),
-              tcgv_vec_arg(v1), tcgv_vec_arg(v2), cond);
-
-    return need_inv;
-}
-
-static void expand_vec_cmp(TCGType type, unsigned vece, TCGv_vec v0,
-                           TCGv_vec v1, TCGv_vec v2, TCGCond cond)
-{
-    if (expand_vec_cmp_noinv(type, vece, v0, v1, v2, cond)) {
-        tcg_gen_not_vec(vece, v0, v0);
-    }
-}
-
 static void expand_vec_cmpsel(TCGType type, unsigned vece, TCGv_vec v0,
                               TCGv_vec c1, TCGv_vec c2,
                               TCGv_vec v3, TCGv_vec v4, TCGCond cond)
 {
     TCGv_vec t = tcg_temp_new_vec(type);
 
-    if (expand_vec_cmp_noinv(type, vece, t, c1, c2, cond)) {
-        /* Invert the sense of the compare by swapping arguments.  */
-        tcg_gen_bitsel_vec(vece, v0, t, v4, v3);
-    } else {
-        tcg_gen_bitsel_vec(vece, v0, t, v3, v4);
-    }
+    tcg_gen_cmp_vec(cond, vece, t, c1, c2);
+    tcg_gen_bitsel_vec(vece, v0, t, v3, v4);
     tcg_temp_free_vec(t);
 }
 
@@ -3153,10 +3148,6 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
     v2 = temp_tcgv_vec(arg_temp(va_arg(va, TCGArg)));
 
     switch (opc) {
-    case INDEX_op_cmp_vec:
-        expand_vec_cmp(type, vece, v0, v1, v2, va_arg(va, TCGArg));
-        break;
-
     case INDEX_op_cmpsel_vec:
         v3 = temp_tcgv_vec(arg_temp(va_arg(va, TCGArg)));
         v4 = temp_tcgv_vec(arg_temp(va_arg(va, TCGArg)));
-- 
2.43.0


