Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9082C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAklO-0003jw-85; Sun, 27 Sep 2026 05:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkE-0002Q9-KB
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:28 -0400
Received: from mail-pj2-x0e.google.com ([2607:f8b0:4864:39::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkC-0007PN-Ln
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:26 -0400
Received: by mail-pj2-x0e.google.com with SMTP id
 98e67ed59e1d1-396ccda24afso1119846a91.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499623; x=1791104423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t5FzK+7INxe+RKJnRcyyoVc5J2/mk3frDK+bALedL1I=;
 b=IyVy1WJvfPpw2A5ygpTlX84zL+MyMsXcOtEqK+cwKEEl9PTfDpupaz/pQ2MK4JLxDg
 /oCqrIYwhKJGZqYo4IZd7g08yrsEjQkXDpqqDKDSEkb062i3EYD4BGdZ2RlfIf8kztIV
 Vfs8F+IjiAxN9ROGvqmGubpPNSZupHAUgW8j7w2OC14b+QT8FcYu4m6lHzR5W0t7awiq
 7tgg+bb1NKfrMOSxVyLS3VegjYf31KpnZ/P0d4DyjJOt/mSmcxLoMUvJSAMQGKzdwFjg
 6yDWY/Tb1QZ2vSVCCTSXgDlKmtTkswrvCuUiuaRg+BNg6iOWWztF1Dv1e/eazkD4pM/P
 L2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499623; x=1791104423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=t5FzK+7INxe+RKJnRcyyoVc5J2/mk3frDK+bALedL1I=;
 b=wnjO8WlgaBpYRF9zR9FgUF0a/cABt9NJ0XNMQ+HdCo8zbzAF7Yc1VgVrNOLnZKlre6
 3DLJZKm7v4uINGszaw5paFLh/G70oJOTrI0RQEZMlgjzVQZ2ZYBBvx4qR/mZ4WF93MIj
 pBVMa1bj6yZutx1OL1nyUfcdyqYNJQTBg1rtDdnAC+0ZJ6ayBL8F76/cPr1PabylgZBk
 sCTtQpZxzYpwx/SxbdFa5J5B++iyDQbnmlrCvOVqabUYsYC1I1Q4y/MLc5WsUaxM8FT3
 p1nwZC/TdQ30ajsAyEIoILkjA0fcD5wyV97BPRw3nhrzDC8NB3Rp7cMU/1FYo1/Kr/g+
 /Vzg==
X-Gm-Message-State: AFq9FYJAOS0eYv+pcPtBrtxPXPCX4q+5jjoA+JfpV43ctQLIGhptYEbh
 0ZplkT1jzhbMaRCT21MVXjyXEj9aeOgjUvPckWDpQnqmUd7fGQ6GwB1x3NgXkRSLTXIbad0N5Ks
 H1Vg2
X-Gm-Gg: AYBFou3ITLlVNSwGS1Z9QWKuex/PWwhZRTY92fpY4tjnLNvxQq8TTqpO/obU5xWH8mh
 2xWFTXP+xZ3QqLmEi/tW+mjXGJ57WmYSWfYMspSB1of5YkX5RUr8mH22/ecdFE3EyxXPL4dUdHl
 Y55/IW/OvUA7LU2sQy6VVCYpuvksN8OoczXdlwmLRcwXnbRjDfRpzhwo+0T8PaD2JzZKyIovZxT
 Ampif7yZ5Qv/AgVanXvEACjxMajWBArcC7dDcS0GnQWnzhpN/hvvcEWQkt0tGOIh3GnU9vWlyzF
 QkThTJ28UvgIoAQHe5zTuI4iJVcDkF0mas2xbzy//iK2Y+jyHj1qdzikAtgAIJjIPNnOPg+/YSJ
 FlvTFnHncr9kLmbaWiJhKNfBlBdz7W1lXQKKtxClwveTTqtuL9br+n3YHqAKgixopPFPgUIa58t
 0s6N5indtKAkSfa8U5gIJrJ8i7OMnfsF+lhJCCSfhaBtJaKHsB2PtXt5HKVKJ0pceEhDeZsry6Q
 cqqM7yoe0PGMzaOgYQtZzksONkE3Q==
X-Received: by 2002:a17:90b:1d4e:b0:3a0:e247:3ad1 with SMTP id
 98e67ed59e1d1-3a0e2474cb8mr2015752a91.38.1790499623115; 
 Sun, 27 Sep 2026 02:00:23 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 011/101] tcg: Generic expansion of tcg_gen_discard_*
Date: Sun, 27 Sep 2026 01:58:41 -0700
Message-ID: <20260927090011.10724-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0e.google.com
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
 include/tcg/tcg-op-common.h  |  6 +++---
 tcg/tcg-internal.h           |  3 +++
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 30 ++++++++++--------------------
 4 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 55571653c7b..1dce1c6809e 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -92,6 +92,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
  * Construct operations from templates.
  */
 
+#define DEF1(NAME, T1) \
+    QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1);
 #define DEF2(NAME, T1, T2) \
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1, T2);
 
@@ -113,6 +115,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #undef TINT
 #undef TCGV
 
+#undef DEF1
 #undef DEF2
 
 /* 32 bit ops */
@@ -197,8 +200,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 /* Replicate a value of size @vece from @in to all the lanes in @out */
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
-void tcg_gen_discard_i32(TCGv_i32 arg);
-
 void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld8s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
@@ -317,7 +318,6 @@ void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_add_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 
-void tcg_gen_discard_i64(TCGv_i64 arg);
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld8s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 3568157ebb5..ed1f5f20f83 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -124,6 +124,8 @@ bool tcg_op_imm_match(TCGOpcode op, TCGType type, tcg_target_ulong imm);
  * Declarations of templated TCGv_i32 and TCGv_i64 operations.
  */
 
+#define DEF1(NAME, T1) \
+    QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1);
 #define DEF2(NAME, T1, T2) \
     QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2);
 
@@ -135,6 +137,7 @@ bool tcg_op_imm_match(TCGOpcode op, TCGType type, tcg_target_ulong imm);
 #undef TINT
 #undef TCGV
 
+#undef DEF1
 #undef DEF2
 
 #endif /* TCG_INTERNAL_H */
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index e55a9f99939..8c61a75cd09 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: MIT */
 /* Templated TCGv_i32 and TCGv_i64 operations */
 
+DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index b2fa509cd1f..046b10962fe 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -114,16 +114,6 @@ TCGOp * NI tcg_gen_op6(TCGOpcode opc, TCGType type, TCGArg a1, TCGArg a2,
 # define DNI
 #endif
 
-static void DNI tcg_gen_op1_i32(TCGOpcode opc, TCGType type, TCGv_i32 a1)
-{
-    tcg_gen_op1(opc, type, tcgv_i32_arg(a1));
-}
-
-static void DNI tcg_gen_op1_i64(TCGOpcode opc, TCGType type, TCGv_i64 a1)
-{
-    tcg_gen_op1(opc, type, tcgv_i64_arg(a1));
-}
-
 static TCGOp * DNI tcg_gen_op1i(TCGOpcode opc, TCGType type, TCGArg a1)
 {
     return tcg_gen_op1(opc, type, a1);
@@ -319,6 +309,10 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
  * Templated TCGv_i32 and TCGv_i64 operations.
  */
 
+#define DEF1(NAME, T1)                                                  \
+    void glue(glue(tcg_gen_,NAME),TExt)(T1 a)                           \
+    { tcg_gen_##NAME(TYPE, glue(C_,T1)(a)); }
+
 #define DEF2(NAME, T1, T2)                                              \
     void glue(glue(tcg_gen_,NAME),TExt)(T1 a, T2 b)                     \
     { tcg_gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b)); }
@@ -355,6 +349,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef C_int32_t
 #undef C_int64_t
 
+#undef DEF1
 #undef DEF2
 
 /*
@@ -363,6 +358,11 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
  * are of the proper type.
  */
 
+void tcg_gen_discard(TCGType type, TCGTemp *src)
+{
+    tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
+}
+
 void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -377,11 +377,6 @@ void tcg_gen_movi(TCGType type, TCGTemp *dst, int64_t src)
 
 /* 32 bit ops */
 
-void tcg_gen_discard_i32(TCGv_i32 arg)
-{
-    tcg_gen_op1_i32(INDEX_op_discard, TCG_TYPE_I32, arg);
-}
-
 void tcg_gen_add_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     tcg_gen_op3_i32(INDEX_op_add, ret, arg1, arg2);
@@ -1439,11 +1434,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 
 /* 64-bit ops */
 
-void tcg_gen_discard_i64(TCGv_i64 arg)
-{
-    tcg_gen_op1_i64(INDEX_op_discard, TCG_TYPE_I64, arg);
-}
-
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i64(INDEX_op_ld8u, ret, arg2, offset);
-- 
2.53.0


