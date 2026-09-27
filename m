Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693EFC9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:03:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkkI-0002SZ-6u; Sun, 27 Sep 2026 05:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkD-0002Q8-UB
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:28 -0400
Received: from mail-pj2-x0d.google.com ([2607:f8b0:4864:39::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkB-0007P4-7D
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:25 -0400
Received: by mail-pj2-x0d.google.com with SMTP id
 98e67ed59e1d1-3a0aa9d356eso1721408a91.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499622; x=1791104422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PXtUJ/PcQdH5xvfN08yQNJYMpfNvokq/uCqteWubVwk=;
 b=kNeaG+e/Pu1p5rpu5BfsEIA6vN7xoF2JnhxfqqsQgbPfMbKJxx6CYwnXrDVPiDUUHD
 x9brY4FEPo2kRJ8ISnP+p14N5D/J/TjHNiOTPvlhRagxxTRaQoGRnTpBi3CgOFYp+zC1
 W0UuYke++3QBYuGsukZsMH3EdzYBH5O27kKtFFF4FYIv4WFAPN5U+Su+wcd5XpEUykH7
 tNA1nlzok4KVuCel7qBvJpYG6FGzjUSBKlIETxNR3vsfMSr6HmhmnGF3sZlspq1+pD+j
 b7stx/2Lqq/G/1x4XGxQzCCwL1+3NzFfaWPo7DS2q0wQSKlt0H1GF5VPiedRMyxyPJ7j
 kL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499622; x=1791104422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PXtUJ/PcQdH5xvfN08yQNJYMpfNvokq/uCqteWubVwk=;
 b=cQFMfOEN6VfNjo4d15Z49L83x7b3X3BKiuwLUQQQ7ZN21xohZC4cVEjixirTMRx8Pr
 v8qtaO5Mu+6pOtNgZNShbcY2RN7sPmVTTkhhV197sGgtAkm29+dE8YYTpJghHMXAlfSS
 0tW3WftIJ0VN/JJ1GhX3HmKsrjMqHtu+2H3y6hCcKjvDGVT5UEszTYm+5m6aVkAimJdM
 Jpubpwg6fzcXeNP59iZizQpa8cnXNo1jRbKkBkgspFf9yeACoZfF0/cPwUG5qB1rec5x
 EGphX0M48rs5i92s/6Af5253EoNpWLAVcs37iYoIZWmwsE3OQyAEFUeLIMUrnkzzPU67
 CAFg==
X-Gm-Message-State: AFq9FYJqVnepkU8R6opcn3/ciqw6ydo75B2B69BZRXVkzGXS0eLr1DKV
 4rtL42NHni4FNTdYd33zxDaj9FzSPDl5I6WuTPhqRHBLQQk8Y4vdiEktvjXVwGHgUFd9hVGRpL3
 er837
X-Gm-Gg: AYBFou0LK/K3+2lMmKra5Gkp3b49pi1j2iofAAgFtj9pLrVUWwxdwWE1LsVe4ckNXxT
 TKnV4dY2Af9CxXfRgdx1aXS0OH49+1JhlO5EWBcQW2ZdGe3OPvuLbH7tTk/91QvTMC612+VKPTd
 dRBE5YFIi4b5pHQITQCMx0u4RIRF4QpoCKLYrVQjBZoMn0uyeCooCMaqtinpmDovbPBRn3gDSl+
 TazD+rMEd1GxTPc53L6OU+Ed8nU1IJC4Xb3UYqWCA6nu1i94+JXm4cTD1e8FpWQaMIeUjKh2uuf
 ukMWaW0L8QXbFC1pPyGe2Heee9Wd6gxYMiuMrKvdQiEWg2Nn8owE1xdTDbJnBRGkL1YcP19FMp0
 0AeJs+0CT1z7FTmD0ifuDQW7EFLZdl1zdpCmNomcb/i1ZXJUE4WYtpO4nv3XlNO6w82mxE8yGC/
 KwVe0lWnj8LDsUp1Xk7RrQpVRwa8YwnDaewxyTQFgek7EFBSvnmF57gESXZslDzPmnn2gWuqNMU
 k16FN4/Klu7ID6hYH+DThmWxMvIwg==
X-Received: by 2002:a17:90b:4a12:b0:3a0:e5ed:ef97 with SMTP id
 98e67ed59e1d1-3a0e5edf01cmr2888871a91.49.1790499621603; 
 Sun, 27 Sep 2026 02:00:21 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 009/101] tcg: Generic expansion of tcg_gen_mov_*
Date: Sun, 27 Sep 2026 01:58:39 -0700
Message-ID: <20260927090011.10724-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0d.google.com
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

Begin sharing code in the expansion of operations
for various TCG types.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  | 29 +++++++++++++--
 tcg/tcg-internal.h           | 23 ++++++++++++
 include/tcg/tcg-op-def.h.inc |  4 +++
 tcg/tcg-op.c                 | 69 ++++++++++++++++++++++++++++--------
 4 files changed, 109 insertions(+), 16 deletions(-)
 create mode 100644 include/tcg/tcg-op-def.h.inc

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 888f00d5f24..eba3ad4f93c 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -88,6 +88,33 @@ void tcg_gen_lookup_and_goto_ptr(void);
 void tcg_gen_plugin_cb(unsigned from);
 void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
+/*
+ * Construct operations from templates.
+ */
+
+#define DEF2(NAME, T1, T2) \
+    QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1, T2);
+
+#define TCGV  glue(TCGv,TExt)
+#define TExt  _i32
+#define TINT  int32_t
+
+#include "tcg-op-def.h.inc"
+
+#undef TExt
+#undef TINT
+
+#define TExt  _i64
+#define TINT  int64_t
+
+#include "tcg-op-def.h.inc"
+
+#undef TExt
+#undef TINT
+#undef TCGV
+
+#undef DEF2
+
 /* 32 bit ops */
 
 void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg);
@@ -172,7 +199,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
 void tcg_gen_discard_i32(TCGv_i32 arg);
-void tcg_gen_mov_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld8s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
@@ -294,7 +320,6 @@ void tcg_gen_add_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 
 void tcg_gen_discard_i64(TCGv_i64 arg);
-void tcg_gen_mov_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld8s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index d480d10878c..3568157ebb5 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -102,6 +102,12 @@ void vec_gen_4(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg, TCGArg, TCGArg);
 void vec_gen_6(TCGOpcode opc, TCGType type, unsigned vece, TCGArg r,
                TCGArg a, TCGArg b, TCGArg c, TCGArg d, TCGArg e);
 
+static inline void tcg_gen_op_tt(TCGOpcode opc, TCGType type,
+                                 TCGTemp *t0, TCGTemp *t1)
+{
+    tcg_gen_op2(opc, type, temp_arg(t0), temp_arg(t1));
+}
+
 QEMU_RET_ARG_NONNULL
 TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *op,
                             TCGOpcode, TCGType, unsigned nargs);
@@ -114,4 +120,21 @@ TCGOp *tcg_op_insert_after(TCGContext *s, TCGOp *op,
  */
 bool tcg_op_imm_match(TCGOpcode op, TCGType type, tcg_target_ulong imm);
 
+/*
+ * Declarations of templated TCGv_i32 and TCGv_i64 operations.
+ */
+
+#define DEF2(NAME, T1, T2) \
+    QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2);
+
+#define TCGV  TCGTemp *
+#define TINT  int64_t
+
+#include "tcg/tcg-op-def.h.inc"
+
+#undef TINT
+#undef TCGV
+
+#undef DEF2
+
 #endif /* TCG_INTERNAL_H */
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
new file mode 100644
index 00000000000..c76e83396ae
--- /dev/null
+++ b/include/tcg/tcg-op-def.h.inc
@@ -0,0 +1,4 @@
+/* SPDX-License-Identifier: MIT */
+/* Templated TCGv_i32 and TCGv_i64 operations */
+
+DEF2(mov, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index b738863ea69..77ed34fcb8f 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -315,6 +315,61 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     tcg_gen_op2(INDEX_op_plugin_mem_cb, 0, tcgv_i64_arg(addr), meminfo);
 }
 
+/*
+ * Templated TCGv_i32 and TCGv_i64 operations.
+ */
+
+#define DEF2(NAME, T1, T2)                                              \
+    void glue(glue(tcg_gen_,NAME),TExt)(T1 a, T2 b)                     \
+    { tcg_gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b)); }
+
+#define C_TCGv_i32      tcgv_i32_temp
+#define C_TCGv_i64      tcgv_i64_temp
+#define C_int32_t
+#define C_int64_t
+
+#define TCGV  glue(TCGv,TExt)
+#define TExt  _i32
+#define TINT  int32_t
+#define TYPE  TCG_TYPE_I32
+
+#include "tcg/tcg-op-def.h.inc"
+
+#undef TExt
+#undef TINT
+#undef TYPE
+
+#define TExt  _i64
+#define TINT  int64_t
+#define TYPE  TCG_TYPE_I64
+
+#include "tcg/tcg-op-def.h.inc"
+
+#undef TExt
+#undef TINT
+#undef TCGV
+#undef TYPE
+
+#undef C_TCGv_i32
+#undef C_TCGv_i64
+#undef C_int32_t
+#undef C_int64_t
+
+#undef DEF2
+
+/*
+ * Generic expansions for templated operations.
+ * We have used compiler type checks to ensure all TCGTemp
+ * are of the proper type.
+ */
+
+void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    if (src != dst) {
+        tcg_gen_op_tt(INDEX_op_mov, type, dst, src);
+    }
+}
+
 /* 32 bit ops */
 
 void tcg_gen_discard_i32(TCGv_i32 arg)
@@ -322,13 +377,6 @@ void tcg_gen_discard_i32(TCGv_i32 arg)
     tcg_gen_op1_i32(INDEX_op_discard, TCG_TYPE_I32, arg);
 }
 
-void tcg_gen_mov_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    if (ret != arg) {
-        tcg_gen_op2_i32(INDEX_op_mov, ret, arg);
-    }
-}
-
 void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg)
 {
     tcg_gen_mov_i32(ret, tcg_constant_i32(arg));
@@ -1396,13 +1444,6 @@ void tcg_gen_discard_i64(TCGv_i64 arg)
     tcg_gen_op1_i64(INDEX_op_discard, TCG_TYPE_I64, arg);
 }
 
-void tcg_gen_mov_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    if (ret != arg) {
-        tcg_gen_op2_i64(INDEX_op_mov, ret, arg);
-    }
-}
-
 void tcg_gen_movi_i64(TCGv_i64 ret, int64_t arg)
 {
     tcg_gen_mov_i64(ret, tcg_constant_i64(arg));
-- 
2.53.0


