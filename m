Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89698C88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:35:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L1o-0005KJ-7h; Sat, 12 Sep 2026 06:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1j-0005DT-24
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:32:07 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1h-0007Nd-30
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:32:06 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-398a5aad413so1820774a91.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209124; x=1789813924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Tu5sPnG+Ehsw3C9RXP2r50fQdoX3B5fQd0sDhNvUkLQ=;
 b=hU6/e+ZszM92ox9PGXF+Rmkhc1p9CfCCYoneOtyBAIgQmZjN64+P5Wav4OPJKOwx3A
 D7CR460BpyfB3imDAgUD+J8hp07l9VqkYxzI/71ZTDhTiuZ861L90YO99r9VHGDS5rPx
 aKSYHHRQTxmk/pI+dF/Nvr3r8/fkVIhlJjY8wG3ZuYMRoqJN/Y1zB0/eUWWTea+e3rsk
 C4b/ZejWh9iX9xPI6HoSJtwGZX5Sa2r+ZN4KvNxb0qosnxF0xN9FsyvJsbpA07TkospR
 DqJFfnIIl3pr502mrHm/CVfE4AOarPGO0rWfBAJXT+pDbPn+KdXEaoIQISIsbx0St2LS
 c1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209124; x=1789813924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Tu5sPnG+Ehsw3C9RXP2r50fQdoX3B5fQd0sDhNvUkLQ=;
 b=YS8KPDyzMtq2EJ5+XJb7JJ+tVSYYeWQZKNdhIBD9jrWWQJTJ1jZlEdVOe5j0KCHoqM
 ViQ0hk0M8rFGtbkjWiLjm+fm1bTvUGzxV9ovoOP0wtrg27ISoMp4jLI2a8Z7z2rWgNvE
 kd35ojybd0u2Xoc/xK/rYcfxLMv9bs4tVoS8HWHzjuzPZQkEIpX5iik2+8vYrws1GMjY
 vNDaTc7ab8vMsn8gwe3hqSAoLzCqe73wL2k77S9R/2FJJ29katwjbIlPRYVaFTFV4CvP
 NpvP3eeSfz47WMX9AT0fuksTDy59O9kqhHclqkqCmTtEqAILPf5Y8l+2oPDp7tP0NR2N
 G1cg==
X-Gm-Message-State: AFuF++k8GOhtP2kSuyuf9jDOxR6zu5kQKy2Fnlliaz6inQDnUuqjjdUl
 YffHUDRwNahICsggrkF5o9gNTb+3Zk5TU9gSd43ulCdCnQDKZL9qT6SsQZAQmDppZxNWx0dl7L1
 zutcy
X-Gm-Gg: AYBFou1ZH/fE3MRiw4lRiikNALqukYEOGH9IhHWFULD3hEpC2rFJFay9GPIomG7PznL
 ybvvqYMdlAzcQDTt89ja+bXmlUQVdEnpBf/HIUk2pRXH5C8k8vuMUcvlzSkaoqUknZJ8yF9Ed4d
 6EZV4SXDpjLU7FuGC1QLtJroTet6bm84QRO8vzCZYkPEcq5I+7UJXdMxxH/Ea3lGEIqPJTVTlLn
 +eKIaocYlOK7GTj7a69KQtqC9c+tGuKhGr1sSwtIVYV2giEmhgfMJJCoHTAsrps+nWqtBDKh2Tm
 p8UnQg5XMXuWx1CBXqvf8bvqJ4oPZqaMTlwdomaMINPLQgoERBxqbyHDrGb7c1Fn9dxfGPH36tS
 fg4k2BOmiKW4I6Vy4oeVuyjT4Bpmmh7OUWHX5LyrnWqpvRk1wJ92CaXy6NstyOvOmHuqWJ1cKOl
 KOUtrTaupE+yLe/IDiHOXyRD6p+sX10MegF6pc+jWdZ1fkCADpOb8C7B8ruq8vCRIvfaBlbhPVF
 idoyeA=
X-Received: by 2002:a17:90b:3812:b0:398:990e:1587 with SMTP id
 98e67ed59e1d1-39d9beb8e80mr13530761a91.9.1789209123506; 
 Sat, 12 Sep 2026 03:32:03 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.32.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:32:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 37/82] tcg: Generic expansion of tcg_gen_brcond_*
Date: Sat, 12 Sep 2026 00:30:41 -1000
Message-ID: <20260912103126.598030-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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
 include/tcg/tcg-op-common.h   |  6 +++--
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 44 +++++++++++++++++------------------
 3 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 831502dd994..e243ed93b55 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -110,6 +110,9 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #define DEF_RIR(NAME) \
     void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TINT b, TCGV c);
 
+#define DEF_CRRL(NAME) \
+    void glue(glue(tcg_gen_,NAME),TEXT)(TCGCond a, TCGV b, TCGV c, TCGLabel *d);
+
 #include "tcg-op-def.h.inc"
 
 #undef DEF_R
@@ -118,6 +121,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #undef DEF_RI
 #undef DEF_RRI
 #undef DEF_RIR
+#undef DEF_CRRL
 
 /* 32 bit ops */
 
@@ -141,7 +145,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_brcond_i32(TCGCond cond, TCGv_i32 arg1, TCGv_i32 arg2, TCGLabel *);
 void tcg_gen_brcondi_i32(TCGCond cond, TCGv_i32 arg1, int32_t arg2, TCGLabel *);
 void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
                          TCGv_i32 arg1, TCGv_i32 arg2);
@@ -214,7 +217,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_brcond_i64(TCGCond cond, TCGv_i64 arg1, TCGv_i64 arg2, TCGLabel *);
 void tcg_gen_brcondi_i64(TCGCond cond, TCGv_i64 arg1, int64_t arg2, TCGLabel *);
 void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
                          TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index bad7f4753c1..7721c708e9c 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: MIT */
 
+DEF_CRRL(brcond)
 DEF_R(discard)
 DEF_RI(movi)
 DEF_RIR(subfi)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 233ecdc5b98..c2ae691622f 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -338,6 +338,9 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #define DEF_RIR(NAME) \
     static void glue(gen_,NAME)(TCGType, TCGTemp *, int64_t, TCGTemp *);
 
+#define DEF_CRRL(NAME) \
+    static void glue(gen_,NAME)(TCGType, TCGCond, TCGTemp *, TCGTemp *, TCGLabel *);
+
 #include "tcg/tcg-op-def2.h.inc"
 
 #undef DEF_R
@@ -346,6 +349,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef DEF_RI
 #undef DEF_RRI
 #undef DEF_RIR
+#undef DEF_CRRL
 
 /*
  * Generic expansions for templated operations.
@@ -409,6 +413,18 @@ static void gen_andc(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_brcond(TCGType type, TCGCond cond, TCGTemp *src1,
+                       TCGTemp *src2, TCGLabel *l)
+{
+    if (cond == TCG_COND_ALWAYS) {
+        tcg_gen_br(l);
+    } else if (cond != TCG_COND_NEVER) {
+        TCGOp *op = gen_op_ttii(INDEX_op_brcond, type,
+                                src1, src2, cond, label_arg(l));
+        add_as_label_use(l, op);
+    }
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -699,6 +715,11 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TINT b, TCGV c)         \
     { gen_##NAME(TYPE, TTMP(a), b, TTMP(c)); }
 
+#define DEF_CRRL(NAME)                                                  \
+    void glue(glue(tcg_gen_,NAME),TEXT)(TCGCond a, TCGV b,              \
+                                        TCGV c, TCGLabel *d)            \
+    { gen_##NAME(TYPE, a, TTMP(b), TTMP(c), d); }
+
 #include "tcg/tcg-op-def.h.inc"
 
 #undef DEF_R
@@ -707,20 +728,10 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 #undef DEF_RI
 #undef DEF_RRI
 #undef DEF_RIR
+#undef DEF_CRRL
 
 /* 32 bit ops */
 
-void tcg_gen_brcond_i32(TCGCond cond, TCGv_i32 arg1, TCGv_i32 arg2, TCGLabel *l)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_br(l);
-    } else if (cond != TCG_COND_NEVER) {
-        TCGOp *op = tcg_gen_op4ii_i32(INDEX_op_brcond,
-                                      arg1, arg2, cond, label_arg(l));
-        add_as_label_use(l, op);
-    }
-}
-
 void tcg_gen_brcondi_i32(TCGCond cond, TCGv_i32 arg1, int32_t arg2, TCGLabel *l)
 {
     if (cond == TCG_COND_ALWAYS) {
@@ -1520,17 +1531,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_brcond_i64(TCGCond cond, TCGv_i64 arg1, TCGv_i64 arg2, TCGLabel *l)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_br(l);
-    } else if (cond != TCG_COND_NEVER) {
-        TCGOp *op = tcg_gen_op4ii_i64(INDEX_op_brcond, arg1, arg2, cond,
-                                      label_arg(l));
-        add_as_label_use(l, op);
-    }
-}
-
 void tcg_gen_brcondi_i64(TCGCond cond, TCGv_i64 arg1, int64_t arg2, TCGLabel *l)
 {
     tcg_gen_brcond_i64(cond, arg1, tcg_constant_i64(arg2), l);
-- 
2.53.0


