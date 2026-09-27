Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE6BC9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkkT-0002Un-L7; Sun, 27 Sep 2026 05:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkF-0002QD-Ep
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:28 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkD-0007Pb-8R
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:26 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccd4f99dso1413470a91.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499624; x=1791104424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pvuLXwE5a9Zgkb2rfjKlm7ILvnGmo1Tkfq5CSpSi57s=;
 b=K4zHf4ZyetDz49UZjxUoWBCmvYKSrmMQ1gnWMLx5N3iepFqDBm2kaKV+NjaeagvHU+
 J8nSutIFxiV42AihHst+E1xqAoSZOnOaxr0RNVRJJCi8o6KYV3SMzq9J9KYZ09zPVt0j
 YVvPo5u0OcV8TOLbtvaSag5zQahaRFLnK0BVKPNBPm9NKkjXQzJD+kbqlqNqnNkz5y1f
 UclTfnjCJwXQ20Xls+4pOEIhkiI9GWbzifGRwU2uFZwDPEtGw/jQP23jwQRyDpreQGe0
 afS7hZg6pZkvJQSpLrCi0uyKJBaiyLPNEG+FbVRIwRdUwwSOKahn0uQvtpKTD1eEYEkZ
 xfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499624; x=1791104424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pvuLXwE5a9Zgkb2rfjKlm7ILvnGmo1Tkfq5CSpSi57s=;
 b=cLWifVyWWQoGERFcaJjaFBp4VV1iqcW9hNf7wHJfSpQe5Vqk1dtQG1hlZMa6eBgGPc
 ZkSbZ2Y1klKWgqRIAdYaymKCjMNlF91PlLrCeiumNjqSgcskQjXzJWgIP6aJ/PPTdEaj
 KqFwnCdnX7WDb5cvdHZzvUpZGK2CqWBrvzX4CD30NKcBk9Ol44WgBLTz+4jAN/+BDUQ7
 2qg1bFVYUkXN4n7qlZ3Z5X0rzFyFF3nrdMQ/cl9Y9BN26op80t2vuXOZgw0DXznCi6E/
 s9bl725S/wK4GsYbbOHU51ZRplRVzk6lddyK7XHmV8m5RO12fi98tcTZhP6QLETyaOpt
 XpnQ==
X-Gm-Message-State: AFq9FYLYcjHTzdJ1gWo5XCadqxEEwCZJVXTTKINmIQNY+838gliSHQUB
 lKCYqIjR8fKsPGa9Nj6wLnAkT71iXADhFZyTPRZDKR3+EigDyMf76ymYJ6CWbf9GnazxCagHAWt
 GbkKI
X-Gm-Gg: AYBFou2UgN/E5Tyaxq8cULtLF3+BWSO/Pg9My5/smjAOqEkhu4tCFdbseq+mPpmN+um
 gBsn7SddTUjf/cVi8PMB+hfs/I7oHYlaQ8WcR2ZA2+cOm2EcH4OwiSvWzovIIurc4GdNOtx/mUB
 5YaJ9/OiPK8LqdTTSL34Hk31zZcPeLWXvkdKXGYmlyWaw1jB6Jf7mPwaiyzveqssn55cf5savwm
 1kVUVjMuvmIFfIhgUmPjOT2GVG43sOdt48CwZV+H9/qAqutZdbj23b3ZFCavnjTB3q62XyE1bBQ
 7FMYVH1UrZ5mP6Vvx8OdhxrxP4qucvcMZoXLd9gHjC1wYxJW+dPdHgcxrTLpio/7PfbJRCd0GV/
 hjqoWjjXJx95ArFYt51t4wdF9HlsLqcahNMM4xNm2MqYtuOTGVmcSzcg+owyRNfyRTtgR7LlKW3
 svfniU0+kKEWn/h0udUJFc959N4N7WoQrOGNGHQoS7B75rGFiPx9WDuWE1sA8wQODtS8thxB6Sj
 NfF62BULytC38MY3HgFZM+apT1MLg==
X-Received: by 2002:a17:90b:4b12:b0:3a0:b959:4479 with SMTP id
 98e67ed59e1d1-3a0b959478fmr6403879a91.38.1790499623875; 
 Sun, 27 Sep 2026 02:00:23 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 012/101] tcg: Generic expansion of tcg_gen_add_*
Date: Sun, 27 Sep 2026 01:58:42 -0700
Message-ID: <20260927090011.10724-13-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  5 +++--
 tcg/tcg-internal.h           |  9 +++++++++
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 20 ++++++++++----------
 4 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 1dce1c6809e..3d72d338277 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -96,6 +96,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1);
 #define DEF2(NAME, T1, T2) \
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1, T2);
+#define DEF3(NAME, T1, T2, T3) \
+    QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1, T2, T3);
 
 #define TCGV  glue(TCGv,TExt)
 #define TExt  _i32
@@ -117,6 +119,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 #undef DEF1
 #undef DEF2
+#undef DEF3
 
 /* 32 bit ops */
 
@@ -210,7 +213,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_add_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_sub_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_or_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -315,7 +317,6 @@ void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_add_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index ed1f5f20f83..0da1a9c440c 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -108,6 +108,12 @@ static inline void tcg_gen_op_tt(TCGOpcode opc, TCGType type,
     tcg_gen_op2(opc, type, temp_arg(t0), temp_arg(t1));
 }
 
+static inline void tcg_gen_op_ttt(TCGOpcode opc, TCGType type,
+                                  TCGTemp *t0, TCGTemp *t1, TCGTemp *t2)
+{
+    tcg_gen_op3(opc, type, temp_arg(t0), temp_arg(t1), temp_arg(t2));
+}
+
 QEMU_RET_ARG_NONNULL
 TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *op,
                             TCGOpcode, TCGType, unsigned nargs);
@@ -128,6 +134,8 @@ bool tcg_op_imm_match(TCGOpcode op, TCGType type, tcg_target_ulong imm);
     QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1);
 #define DEF2(NAME, T1, T2) \
     QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2);
+#define DEF3(NAME, T1, T2, T3) \
+    QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2, T3);
 
 #define TCGV  TCGTemp *
 #define TINT  int64_t
@@ -139,5 +147,6 @@ bool tcg_op_imm_match(TCGOpcode op, TCGType type, tcg_target_ulong imm);
 
 #undef DEF1
 #undef DEF2
+#undef DEF3
 
 #endif /* TCG_INTERNAL_H */
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 8c61a75cd09..73b1ec3d057 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: MIT */
 /* Templated TCGv_i32 and TCGv_i64 operations */
 
+DEF3(add, TCGV, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 046b10962fe..a17a9db8203 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -317,6 +317,10 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     void glue(glue(tcg_gen_,NAME),TExt)(T1 a, T2 b)                     \
     { tcg_gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b)); }
 
+#define DEF3(NAME, T1, T2, T3)                                          \
+    void glue(glue(tcg_gen_,NAME),TExt)(T1 a, T2 b, T3 c)               \
+    { tcg_gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b), glue(C_,T3)(c)); }
+
 #define C_TCGv_i32      tcgv_i32_temp
 #define C_TCGv_i64      tcgv_i64_temp
 #define C_int32_t
@@ -351,6 +355,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 
 #undef DEF1
 #undef DEF2
+#undef DEF3
 
 /*
  * Generic expansions for templated operations.
@@ -358,6 +363,11 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
  * are of the proper type.
  */
 
+void tcg_gen_add(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    tcg_gen_op_ttt(INDEX_op_add, type, dst, src1, src2);
+}
+
 void tcg_gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -377,11 +387,6 @@ void tcg_gen_movi(TCGType type, TCGTemp *dst, int64_t src)
 
 /* 32 bit ops */
 
-void tcg_gen_add_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_add, ret, arg1, arg2);
-}
-
 void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* some cases can be optimized here */
@@ -1489,11 +1494,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_add_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_add, ret, arg1, arg2);
-}
-
 void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_sub, ret, arg1, arg2);
-- 
2.53.0


