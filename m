Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62AAC9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAklO-0003jf-3Z; Sun, 27 Sep 2026 05:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkj-0002ZF-G0
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:01:03 -0400
Received: from mail-pj2-x0c.google.com ([2607:f8b0:4864:39::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkZ-0007TN-TV
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:51 -0400
Received: by mail-pj2-x0c.google.com with SMTP id
 98e67ed59e1d1-3a0dc47fee0so448864a91.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499642; x=1791104442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6pMysBxSrTlkFbts4bdYIULpu9xsJQzHV0u1JZuNmsc=;
 b=jnjmBTHPyl90L0WvGWF4PwdCvULfO8O8nLlm9TtXNGXrWaC2GHJiN629C/jYvt8Efq
 jtj1XLpYQTAaSC/l4xbXCl+PccYRzpWfZZEuS59RvuGuPIg0fgHxmGyK6qfV5kQt2IOo
 RO62Uztv7hK4ulrBtmMZoWuxBps7xMsQM/hYKsv/GoW+bTgiU9+TylhNERtatDtn6QfX
 NpuaP1xmB3fwdEAnZ4PkAxUmsIfZECVaAwn68t5Vojq+ktcq8OfNgMr23xK6TzMgN8wn
 JT1qvl+cjsZt7i+izHMEH/OB2DeDVIuuRW8YKoypLqxCc6ZZrHbEoLeYIsRvfETcbkK4
 Dlzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499642; x=1791104442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6pMysBxSrTlkFbts4bdYIULpu9xsJQzHV0u1JZuNmsc=;
 b=Ut6sh4tYE6YL5y98EsUkE+uOGj5c3ZWIuftQj5w+bY+lYsUsyM5BCfdny4jCZroBeg
 NXvdRTNgqMITtN14IHZCIdfyOBb2zYen+3ceWDDFyYLQfVtWjiojrrQjCA5GKxuQS9nj
 t0z8q8Rq+LxiDVF79d7vEnPyDiW1EBAkFBoTJDpLkKRCc4hcif5D4K6FiFrBH1s2RwFq
 iMEQ039iJmpOa/wkpjkfgqqETYaBTW62ti8bI8gjrxJFfKaStc6W5HjFcOTZRc9PiBR1
 gvPkAARG1+IyoladXCiZFgm+9sSoPMAMaa4/v7gyZRlIibXFjqWv6mfj1eQaKoIXfauP
 9PSA==
X-Gm-Message-State: AFq9FYLgyJCi6XiVBbvLoWh5DKdBd0SvZy1wEk1AWMBNiZn8S+t7qqdw
 j7B6s1DsZuHDHymjJOuYpokzwaQ1/b/WlZZDaaTlWIIgNJ14DHEiXNcuh9ZrEpKOKR5dJdOX9LC
 3ZP3b
X-Gm-Gg: AYBFou3LYwkHzyi8/2+OgTkeERZPvY2frzu8Bj57G9DijjwCmgNr1hlGKiAZS7KD/Mv
 TrlVpByFaMnpKS0zwdnzsU7WgbbOnG2mXXiqNg4CVSMHUctm+FDfcgdU657c166gWaeqesYDDNQ
 goQBn8/r3vA1W43hoS+9XpUAiKPy6zl0KJ/VfwXXyMhGnCABrPea9Vt5bfljrR6joitpYOuqWtH
 5Gho+UMS6bJkwN3rFwhMUv/kb1LUQbk7Vv+z+YVN7uZwn2Q54S5nh0gII3enr7mlU+mvK82aYJY
 zKeGmhsfIs1vL5CUdpF8aC7LYa4T/5KgP1l2CHVq5lBe76BHhAOgUConxed3CCvFqEwy0Of41ws
 rlsUjwEdh0NVLHeFwYs2Coh2Lj4OdklVYPP6UVgF5n/35I7hRK3GRxI0smFe5P+AVWC18bPLR9q
 z7AOX/HCAkYG6qsXCOOmOr9vCeOik0OQ411WXYUftd2YAJR6lvQsIPsxtX3h1xeCuOWGnvBJ7Bh
 WovvvAcfjGgcacE7B2c9/swDo7j4Q==
X-Received: by 2002:a17:90b:4b0f:b0:39e:4c80:f67f with SMTP id
 98e67ed59e1d1-3a098983faemr8589954a91.30.1790499642261; 
 Sun, 27 Sep 2026 02:00:42 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 030/101] tcg: Generic expansion of tcg_gen_xori_*
Date: Sun, 27 Sep 2026 01:59:00 -0700
Message-ID: <20260927090011.10724-31-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 34 +++++++++-------------------------
 3 files changed, 10 insertions(+), 27 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index b574a8f4f4f..87aab828112 100644
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
index f7a7dc69c9d..b38969478a9 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -22,3 +22,4 @@ DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
 DEF3(xor, TCGV, TCGV, TCGV)
+DEF3(xori, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 90aae9ed4c9..153a759305e 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -518,22 +518,20 @@ void tcg_gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_gen_op_ttt(INDEX_op_xor, type, dst, src1, src2);
 }
 
-/* 32 bit ops */
-
-void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
+void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 {
-    /* Some cases can be optimized here.  */
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else if (arg2 == -1 &&
-               tcg_op_supported(INDEX_op_not, TCG_TYPE_I32, 0)) {
-        /* Don't recurse with tcg_gen_not_i32.  */
-        tcg_gen_op2_i32(INDEX_op_not, ret, arg1);
+    if (src2 == 0) {
+        tcg_gen_mov(type, dst, src1);
+    } else if (src2 == -1 && tcg_op_supported(INDEX_op_not, type, 0)) {
+        /* Do not recurse with gen_not.  */
+        tcg_gen_op_tt(INDEX_op_not, type, dst, src1);
     } else {
-        tcg_gen_xor_i32(ret, arg1, tcg_constant_i32(arg2));
+        tcg_gen_xor(type, dst, src1, tcg_constant_internal(type, src2));
     }
 }
 
+/* 32 bit ops */
+
 void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     if (tcg_op_supported(INDEX_op_not, TCG_TYPE_I32, 0)) {
@@ -1486,20 +1484,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
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


