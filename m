Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636CFC9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkoC-0005BE-5v; Sun, 27 Sep 2026 05:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAknt-0004cJ-EQ
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:13 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAknr-0007ds-Hf
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:13 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-39b2ad83dc6so1441783a91.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499850; x=1791104650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T5QcgkylO1Z0/SmPVTFK2bRSwmuiWkqQ068QPJvr2I8=;
 b=ihdi0S1ujE1lAcCGv1Osj54e/dbmkClSYVnHOhX+c5O9kwFXyXAK9jf26k/usRQ/Gt
 dgfdqZClne+X5pKLUXQuuVQNX28VqCmi5BenVRTodLfv9ySanJserSVJEI51lSL3fFDu
 CO5oKQLwkB2+ngSX9fYcQOMAjIX1OG6V3zRtjAw0bEhZoapTfOymhInaK4NN83csuSIW
 0IVc2VDr7yrOVVUuFV62wEaEjZY8430GqQZVdtftyUrWYqM37VZwZk31vIXjq9odUzCV
 O59UJxZBiP/5HhN8wJNCoAolFurjAiwMFg+8jlns41bHbWfCRSNAVuhjbwR4W9pCDWZ7
 hhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499850; x=1791104650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=T5QcgkylO1Z0/SmPVTFK2bRSwmuiWkqQ068QPJvr2I8=;
 b=wLFvzuAAxsXp3b7JmFAxULJsNtyIC+BtQJLgHu/502qkP/+l5JaZmf+/i2BxZBZ5Q8
 KMAxYNRteraeQnaxpKi3DGEShyAjKdT2dSzE0AM1jk2fvG5eC8MGB3IDPqdUDFiSgier
 tUbe4ncUQGP4+qRBZHoVvto7Lk7iMt7f7+mTpMq+O5XPsdKgVCttA/qdsglSaIrdiIO0
 3fYn1JMJ7XtPljyV9LmFb+OGoNlTC5fBw7oV+jHxWewPEwD9VJl2UbhNTfTAwbkAxArz
 z/FQ9VHu64V2+nwW8EzwTlL5K6t/2w6lV+CPIOVQFoDN5d7Go7bLKQZ4bu6syLvAnLOc
 XTxQ==
X-Gm-Message-State: AFq9FYLGMBjXCMwF8rE83MqIs6pT6USiQ4BpZRO0M6LOnt3jGIbB27v6
 jICoLVQPqlv7Llt/Fp0gT0/m9JREvAugF8K80RC8OfjMitqjj5emNRh7qW+6MpP74bLDfOrcPDL
 NjTaN
X-Gm-Gg: AYBFou3qUwJOwYVDPtBMt+llD72n4wIaP/RJaCJMFx+jtFo8IUfgfrF3erTrcIsyyzi
 9HGwuXcRwpEyDH/Sn+QCmu4QDh3ESI9KyPhO5G/Ke2sLpv1N5cw3ZAdHTVwDdlm46Ee+js94g1z
 SWFrRFv4prO2woouQU9Lhp9DJ2x3c/OCkx1eJh4U6SgN3kTVS+ssFboCpzJEhYcm0QEP/hRP2TN
 3yYsbre7sge8h5byiG/DZtrXh6c97ONSSrFMndzNub1V8Kb/qRNaZzM3leHKYsaEWnQbSWrp1Wp
 /HyLY2mgd5IG/R3547MtN2g4lALQ5a2GeSuTayT9Y6HweENKkYbSvAYL5U/eSGPBW0XBhhlS8sx
 q6uzHHcmXXAYTXfj2iR8okydqmGk9x4g9g8U4Yqg7XtyEXbtlCy+qELZ94yG+pzujqk1CBEGdiR
 QdJW24T7sRJ8yBwEaxjPqsdKsrxDaOCjd0k0VSNUtGqlELQKWECWmlmzhYdY4oEq3kXJxiOz6lF
 N0Ui+q9iYCgni2Gg1YQoIOU2ddX8w==
X-Received: by 2002:a17:90b:4d85:b0:39e:53a:c8d4 with SMTP id
 98e67ed59e1d1-3a098ae21c7mr9513365a91.12.1790499850065; 
 Sun, 27 Sep 2026 02:04:10 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:04:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 054/101] tcg: Generic expansion of tcg_gen_ctpop_*
Date: Sun, 27 Sep 2026 01:59:24 -0700
Message-ID: <20260927090011.10724-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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
 tcg/tcg-op.c                 | 41 +++++++++++++++---------------------
 3 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index acdd31dbeaf..7f977661b3d 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -132,7 +132,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_ctpop_i32(TCGv_i32 a1, TCGv_i32 a2);
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -191,7 +190,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_ctpop_i64(TCGv_i64 a1, TCGv_i64 a2);
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index cf832a6dc07..66977cada1f 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -10,6 +10,7 @@ DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
 DEF4(brcondi, TCGCond, TCGV, TINT, TCGLabelPtr)
 DEF3(clz, TCGV, TCGV, TCGV)
 DEF3(clzi, TCGV, TCGV, TINT)
+DEF2(ctpop, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index f168386f46b..86dae114859 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -450,6 +450,23 @@ void tcg_gen_clzi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     tcg_gen_clz(type, dst, src1, tcg_constant_internal(type, src2));
 }
 
+void tcg_gen_ctpop(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    if (tcg_op_supported(INDEX_op_ctpop, type, 0)) {
+        tcg_gen_op_tt(INDEX_op_ctpop, type, dst, src);
+    } else if (type == TCG_TYPE_I64) {
+        gen_helper_ctpop_i64(temp_tcgv_i64(dst), temp_tcgv_i64(src));
+    } else if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
+        g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(TCG_TYPE_I64);
+
+        tcg_gen_extu(tmp, src);
+        tcg_gen_op_tt(INDEX_op_ctpop, TCG_TYPE_I64, tmp, src);
+        tcg_gen_extrl(dst, tmp);
+    } else {
+        gen_helper_ctpop_i32(temp_tcgv_i32(dst), temp_tcgv_i32(src));
+    }
+}
+
 void tcg_gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -828,21 +845,6 @@ void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_ctpop_i32(TCGv_i32 ret, TCGv_i32 arg1)
-{
-    if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I32, 0)) {
-        tcg_gen_op2_i32(INDEX_op_ctpop, ret, arg1);
-    } else if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t = tcg_temp_ebb_new_i64();
-        tcg_gen_extu_i32_i64(t, arg1);
-        tcg_gen_ctpop_i64(t, t);
-        tcg_gen_extrl_i64_i32(ret, t);
-        tcg_temp_free_i64(t);
-    } else {
-        gen_helper_ctpop_i32(ret, arg1);
-    }
-}
-
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
@@ -1733,15 +1735,6 @@ void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_ctpop_i64(TCGv_i64 ret, TCGv_i64 arg1)
-{
-    if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
-        tcg_gen_op2_i64(INDEX_op_ctpop, ret, arg1);
-    } else {
-        gen_helper_ctpop_i64(ret, arg1);
-    }
-}
-
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-- 
2.53.0


