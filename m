Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BACFC79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L5V-0002rp-29; Sat, 12 Sep 2026 06:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4x-0008TX-07
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:27 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4r-0008Kz-2N
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:24 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-cc149372c14so1261843a12.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209319; x=1789814119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TzZ16HfG+4DjQO6xaS1UPutZGVlxRQbMg1ThbMxXJ5I=;
 b=jLaRbIT1UPT37wMwyaTIjgRyOT8n42mDAzBfky6aub4x06HCb0MiDwytwjjAoRxZfy
 QjSBZK2C0ZmN2EmFMNDirMVvYknv8+Xa8Lp9qlxVxQUWM3GJa2UyquGJTbcQaRh3rRwd
 tvRx/WkrakVUlmlhT97pM8WT0L7HZ5IYOFj7NdaPN2FHlXfZodEvQ2elOUNPbUCx1gfq
 nsnzqBqgDQqg00UcO/XBBRyKl/QJ9EjWaxcjbyIop66OszzoagB5TkXye7OHOwNobBDM
 +z+BYWwuok6xMsDmlyWc57GR9ik1BHxZUgQKNTx/xUa2Ie5gsZsRauWoWQtYnvIlhUAS
 fAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209319; x=1789814119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TzZ16HfG+4DjQO6xaS1UPutZGVlxRQbMg1ThbMxXJ5I=;
 b=QziGs+fM53ajjo9dAN9INEY2ttdU5heyzg/sKrcUr6yHSdUz1+tPNvmRRBQl4XHyOr
 Qi+RBkLjm7kUW9xcXs92i8SDufEZ5/7dbxWukG3M5Q6ojcpTpvs/ZWKEGyiVwvQkgPVA
 080jaTdFvHE+/WFh/OnWObJRkcabRo8dA/QIH4LMlp2DIzRRdwuF+i3Bfzb0k2BMOl1s
 Ri/L5nxVyQ6RhWn2XfX5DzJjdZ/B3FaYTcfS+oK90eSQ883qLl1tfzAeVpCOLzrbxvcN
 IbBwF+cOZYc+v32Wq/hcJt3Aht+rj+c0QbzGVLhz6UKJIO/UayPLhq624yyypnI5NaQu
 rhOg==
X-Gm-Message-State: AFuF++nhorTDtPl9plAL8dT38F1FtpMeeStSMxhDKleedbdLPaPx9hD5
 czaHUEytkHxTvQPPgq5Ue07m8VXHmzCjsgrLhxFuWnpCgeeVI2JA4yqxzZ+4v1Pyha412W8JN/h
 W1J4bqao=
X-Gm-Gg: AYBFou2peuqDG9VmusSDzHaAHJpcLqYBVjJ5rQuNXtitJsq0l/gu+oVg05tTUg5eaZy
 wfku5FQoRqDUHFSvWL36E5kxGOud7IDcLsTDzRFujmGJPKhDk7NVau0xv5QSd7pXcCXMzTvZclo
 ose+NXWKa70TPJaUmweifwhg8UoxCOL7sYkbAtjA5K4JHtSmfJ6W74sqb87xwdnqA1VhUQbqN7h
 NHarS+ucnpwSydJiSCtsGKdkQcbMyAcyIjpUL8TDA/jKv3mG6uspcMLb0ls0Dcp/5+C0qwJt+Uv
 ud6pzY4h8JS3uQ60PsJ22MEvW7ti7Wt4mO3R3MDntCl+TrZukj2LPRz+AsD0ZcUn7ODOuzP4rlG
 ml9gwNOjo4KPtPFoV/bdO7jMJcG39hnYGPkl8NMFBl18xaqf24GW8V5iOFfGFX4C4Sy3P0RRv8w
 TRc9grmLitVBpw0jOQ4qKLC+udU08mlEplTFrMueSQ5uM/6eetSp6vteaMgbU4uIpj+cw/xSWZo
 eq1HfI=
X-Received: by 2002:a17:90b:1d0c:b0:398:d292:e6d5 with SMTP id
 98e67ed59e1d1-39d9c35972cmr14770930a91.24.1789209318668; 
 Sat, 12 Sep 2026 03:35:18 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 51/82] tcg: Generic expansion of tcg_gen_ctpop_*
Date: Sat, 12 Sep 2026 00:30:55 -1000
Message-ID: <20260912103126.598030-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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
 include/tcg/tcg-op-common.h   |  2 --
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 42 +++++++++++++++--------------------
 3 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 86922380019..802d7c8352a 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -145,7 +145,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_ctpop_i32(TCGv_i32 a1, TCGv_i32 a2);
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -204,7 +203,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_ctpop_i64(TCGv_i64 a1, TCGv_i64 a2);
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 30288a01327..4497f2b6927 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -10,6 +10,7 @@ DEF_CRRRRR(movcond)
 DEF_R(discard)
 DEF_RI(movi)
 DEF_RIR(subfi)
+DEF_RR(ctpop)
 DEF_RR(mov)
 DEF_RR(neg)
 DEF_RR(not)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index fd8f93f4bde..2be51a5762a 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -481,6 +481,24 @@ static void gen_clzi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     gen_clz(type, dst, src1, tcg_constant_internal(type, src2));
 }
 
+static void gen_ctpop(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    if (tcg_op_supported(INDEX_op_ctpop, type, 0)) {
+        gen_op_tt(INDEX_op_ctpop, type, dst, src);
+    } else if (type == TCG_TYPE_I64) {
+        gen_helper_ctpop_i64(temp_tcgv_i64(dst), temp_tcgv_i64(src));
+    } else if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
+        TCGTemp *tmp = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
+
+        gen_extu_i32_i64(tmp, src);
+        gen_op_tt(INDEX_op_ctpop, TCG_TYPE_I64, tmp, src);
+        gen_extrl_i64_i32(dst, tmp);
+        tcg_temp_free_internal(tmp);
+    } else {
+        gen_helper_ctpop_i32(temp_tcgv_i32(dst), temp_tcgv_i32(src));
+    }
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -948,21 +966,6 @@ void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg)
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
@@ -1853,15 +1856,6 @@ void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg)
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


