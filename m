Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0009DC9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkoW-0005yB-51; Sun, 27 Sep 2026 05:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAknr-0004VS-AB
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:12 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkno-0007dB-Fc
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:10 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc797656e5eso867881a12.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499847; x=1791104647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vAH72kPbfcImibawvornnt4QI4YOAphsACDmVxoDJ3k=;
 b=Bn6P/SNx8wWFLN5o2QGWqJhEJrpFvVW07I7Bq2zIdxxjT6U3Mkyt8Wtbq68PqKu0s+
 swQM88x/GO8hIL8LWsLF99SBVUOxaccfzLWE6xeu+cXgGyNPQKCbBc2ncS0qGKpmurJS
 te/iazrYGPvsRtbZZDqrNdtsb6CSqctTS20GWbwQxhfMxbr6oS1QrXAfHBv9eyIFm8tU
 6C1Dj3dp7RNSaoq72If4rLFDKxfoBBqKacWHOLzzOH7pHHJuJAxStVPMna0uT/HwJ3rN
 9l9kmIc8JUrlGYkkTmtoVOusVoEksvMlJ4UrqMFGIo/XBjnmDYUl89DyvY084rQHNFgK
 0DJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499847; x=1791104647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vAH72kPbfcImibawvornnt4QI4YOAphsACDmVxoDJ3k=;
 b=H8SEyYzP3Xnfb8gGrk/rUUPW3JFGec5UYzfnrylcuKDkP5m60DuPq0+WOE3464DpuT
 MA5vOKMPcsClX1VsJGOuDVPA7eTZlTtc9QxNWMu5H0nJpay4GRTQgKfBxJ6wumWIx5Bx
 pAQN+hBWEr3M9yr9H8eL9gitLhYC8859QCq2HYF8PDJYmolPq6X4Q3ljD2snCeEgsI1U
 44E4pJn6V8moxQgBOWoQ27RvGQpHG9A0WmoWVk9shSjgROnBXC8adZYfOPRFR1nrEJ4L
 xGCmu0+Y88OgqTLEh9Q81FVdqm0d/y5O5PO0RBO32i/+Y2ySbR1P7aVLHOs46sgiUtQS
 BsuA==
X-Gm-Message-State: AFq9FYLYnGCbVWFfyz7OVSyJwNXKK2Bsmq/CMXow7hKNPZihHWrk4B1a
 p6An8a8+GrHwOpGIEmelzzYFYQ/5ZE/A+taFkPy3X5xqwgiEar9YKc4wqYZddS8RbDM1Mbw+aCL
 sQF0h
X-Gm-Gg: AYBFou3xn6u4VDC/L7LNX/xzYHdB4ppuj5wN1GQglLJ8nURFNn0GNJvJxinybrObcbJ
 tvkBVWY9vmT03gLXsBuR/0OdlPUFCzlT21C+m2XekVCgUDRzyZRU1rTe08F+rxztyO5y+/19/Nl
 CBF9OLouAZ7VkuEtrB9emzAoQQXrlrMjSFiACNlrO9KvcHBvIDk7xbrJAmj9Fgwr/nsFxozCbEU
 RKfZ5xgwLxhVa9eanZnxKHEG4UJTFw3LcZacJKHMNVSowv3MWfaRHvekfe0q5nHMgydYvVAEgR6
 0jeobW9SmQWY5nDCtdWax7RreOow7Er2GNbXej92LL9d+qujLGjOD4NqNi2WUdopS85DxKDZhtO
 IrJoJv3uPrir/l/gJ6eviKh2KerVZpJFhSm/1mExEoSsVFNNlA9ulkiTWrID5QTV2K6sLK2eSc5
 7JiP9y8t3vWkCWbEbNb/2kF6ZIR5wE4t9JHb6V3Jbb0maDBCdwWKiE700QgtwLm2cB9yBkONJNx
 z7utuwzZOIIP0zaSAioD/DVwfEgWQ==
X-Received: by 2002:a17:90b:2250:b0:39d:f247:bb3 with SMTP id
 98e67ed59e1d1-3a098b4b334mr8367837a91.21.1790499847068; 
 Sun, 27 Sep 2026 02:04:07 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:04:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 051/101] tcg: Generic expansion of tcg_gen_clz_*
Date: Sun, 27 Sep 2026 01:59:21 -0700
Message-ID: <20260927090011.10724-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
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
 tcg/tcg-op.c                 | 52 ++++++++++++++++--------------------
 3 files changed, 24 insertions(+), 31 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index c6b8af46de4..f40c286a831 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -129,7 +129,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2);
 void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2);
@@ -190,7 +189,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
 void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index a1c1e9b9186..74c68f46b76 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -8,6 +8,7 @@ DEF3(andi, TCGV, TCGV, TINT)
 DEF3(andc, TCGV, TCGV, TCGV)
 DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
 DEF4(brcondi, TCGCond, TCGV, TINT, TCGLabelPtr)
+DEF3(clz, TCGV, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 6a5f77e9977..74e1e1aae2d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -422,6 +422,29 @@ void tcg_gen_brcondi(TCGType type, TCGCond cond, TCGTemp *src1,
     tcg_gen_brcond(type, cond, src1, tcg_constant_internal(type, src2), l);
 }
 
+void tcg_gen_clz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_clz, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_clz, type, dst, src1, src2);
+    } else if (type == TCG_TYPE_I64) {
+        gen_helper_clz_i64(temp_tcgv_i64(dst), temp_tcgv_i64(src1),
+                           temp_tcgv_i64(src2));
+    } else if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
+        g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(TCG_TYPE_I64);
+        g_autoptr(TCGTemp) t2 = tcg_temp_new_ebb(TCG_TYPE_I64);
+
+        tcg_gen_extu(t1, src1);
+        tcg_gen_extu(t2, src2);
+        tcg_gen_addi(TCG_TYPE_I64, t2, t2, 32);
+        tcg_gen_op_ttt(INDEX_op_clz, TCG_TYPE_I64, t1, t1, t2);
+        tcg_gen_extrl(dst, t1);
+        tcg_gen_addi(TCG_TYPE_I32, dst, dst, -32);
+    } else {
+        gen_helper_clz_i32(temp_tcgv_i32(dst), temp_tcgv_i32(src1),
+                           temp_tcgv_i32(src2));
+    }
+}
+
 void tcg_gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -730,26 +753,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_clz, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t2 = tcg_temp_ebb_new_i64();
-        tcg_gen_extu_i32_i64(t1, arg1);
-        tcg_gen_extu_i32_i64(t2, arg2);
-        tcg_gen_addi_i64(t2, t2, 32);
-        tcg_gen_clz_i64(t1, t1, t2);
-        tcg_gen_extrl_i64_i32(ret, t1);
-        tcg_temp_free_i64(t1);
-        tcg_temp_free_i64(t2);
-        tcg_gen_subi_i32(ret, ret, 32);
-    } else {
-        gen_helper_clz_i32(ret, arg1, arg2);
-    }
-}
-
 void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
 {
     tcg_gen_clz_i32(ret, arg1, tcg_constant_i32(arg2));
@@ -1671,15 +1674,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_clz, ret, arg1, arg2);
-    } else {
-        gen_helper_clz_i64(ret, arg1, arg2);
-    }
-}
-
 void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
 {
     tcg_gen_clz_i64(ret, arg1, tcg_constant_i64(arg2));
-- 
2.53.0


