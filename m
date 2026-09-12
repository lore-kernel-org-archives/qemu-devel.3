Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344ABC79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L23-000697-DM; Sat, 12 Sep 2026 06:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1j-0005EQ-VL
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:32:07 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1i-0007Ns-0b
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:32:07 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-cc149372c14so1261298a12.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209124; x=1789813924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8IVsMDMM4CZXhMZJGkEVCkXEp5Yu4XfaShmImiuH300=;
 b=PaZjHbYf6BZYY6lUEVT8ZhEOTaVsNYmgt3KBBGoGNSErbiEH0zNm2eK05VHJrIAsDH
 Jdvi1KpRRqIeez3vhhmoG3/81cNESZbOgtcKZWzBgsCdIOgvDbfIxGsCu+lb0lNK47M2
 tFLyeGwLZc8IGJnzNH+H9bWHBAhffKJ25Tts2/u+l8inQDMqRTGVgekPrH5dvuZZqSh/
 5p2xqDka2wt10C8HJO/Y5gvDzravk169WhtKqRYE0v2ry6Hwf1WHagZkeLSw1go+rJNR
 j5XtJ1scvRdWHoDaQNiDPWH0yFXkrPk71fDubyx0JZKgzGPli+GgwUxhkN+7kzXHd/eR
 UlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209124; x=1789813924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8IVsMDMM4CZXhMZJGkEVCkXEp5Yu4XfaShmImiuH300=;
 b=XLtx8W1+YuYEu6tiIs4AIJltWfqX09gVrpSv5WzF5Ku63gqEWoiXYonRjvMN+bA3zX
 MZ6xR61z6VuxoG/G+UmyNStCN6p/bth8JXu0Id+gnYqn95Pl/qvKjG4QHnMOowxghark
 0vbIIk9qzeK2Pajblb5sfdSRhTt60NdbaHV4yvMqQ/M3/bUDWKBCXVC1ZV4m1REN312t
 2nXbj+3nPb+V691A8UFcteC2fNg54e7YmQbI1DBw5Y4YQ8skRe4AKkq8uYZVEbXcEG2U
 jLQ6PxHFad8XGpqXM3djNRx49zd7SbKVoZfKtu6MKBhrluLrMJpnoIk0DOeMvxgmdIn1
 8//g==
X-Gm-Message-State: AFuF++majmlnA2kErEVxTH8WTPsW/K1zV10t0MYDbSrrWA2QT+P+Cf5y
 ZBvUHmIIePu8D0Ob4SbWr6Yr/rBA9vpd81npDdfcJnjVvDTLO7A2F12Y9GS8sX+xfo/EJQgRgj8
 xZGUSfp0=
X-Gm-Gg: AYBFou273gEOAWtTy7HTvhwif7MB0QhczPiWK0yR24ifY1ivHFMktJ0EPN4JtnGtmDX
 fJvuTMGesCjqSplRASzYroO9yC06VUCmDImXXLE0sMCJOrB9kOzJCXxmcWbGZSZgZixV+qEgnQw
 23IqjsjvOeFBkg74CLXitNcixknARE5E/TEmlX05P3p/eTioc3g89Y2R1odlOShItRlDWD/WHp5
 UdA+QHOclUXGndwjTGoMFbQ5Oq2e8jqp3dC1ZtuQ0KNgMysfNvFYqTgtuzd26xbJRqL3y9dyh6z
 04S2JYtBdLsymW92GxdEqeSrHT1JG14EoD1FKmuCbyp6GcpMHHNL+YDrPSKY7H5jBwKGnv8nTGY
 7CaIHWcftCnn3RXlDOeZ/I/FgoN0iPS+ygv3V2lmbFGxedWu2LQdjh6lYS4CS4Md5Fev+RCCUxW
 I7Ez+ZAMtSiFx5dFicAvx/WXHazcN78Xem8wv3ThNFhefQLed9qVv3n0HflZxT4Oqm7p2lETtsM
 TQkz8U=
X-Received: by 2002:a17:90b:1d0c:b0:398:d292:e6d5 with SMTP id
 98e67ed59e1d1-39d9c35972cmr14750546a91.24.1789209124446; 
 Sat, 12 Sep 2026 03:32:04 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.32.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:32:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 38/82] tcg: Generic expansion of tcg_gen_brcondi_*
Date: Sat, 12 Sep 2026 00:30:42 -1000
Message-ID: <20260912103126.598030-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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
 include/tcg/tcg-op-common.h   |  6 ++++--
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 30 ++++++++++++++++--------------
 3 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index e243ed93b55..b859af38355 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -113,6 +113,9 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #define DEF_CRRL(NAME) \
     void glue(glue(tcg_gen_,NAME),TEXT)(TCGCond a, TCGV b, TCGV c, TCGLabel *d);
 
+#define DEF_CRIL(NAME) \
+    void glue(glue(tcg_gen_,NAME),TEXT)(TCGCond a, TCGV b, TINT c, TCGLabel *d);
+
 #include "tcg-op-def.h.inc"
 
 #undef DEF_R
@@ -122,6 +125,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #undef DEF_RRI
 #undef DEF_RIR
 #undef DEF_CRRL
+#undef DEF_CRIL
 
 /* 32 bit ops */
 
@@ -145,7 +149,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_brcondi_i32(TCGCond cond, TCGv_i32 arg1, int32_t arg2, TCGLabel *);
 void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
                          TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
@@ -217,7 +220,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_brcondi_i64(TCGCond cond, TCGv_i64 arg1, int64_t arg2, TCGLabel *);
 void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
                          TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 7721c708e9c..da15a647e2e 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: MIT */
 
+DEF_CRIL(brcondi)
 DEF_CRRL(brcond)
 DEF_R(discard)
 DEF_RI(movi)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c2ae691622f..e1974aac41c 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -341,6 +341,9 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #define DEF_CRRL(NAME) \
     static void glue(gen_,NAME)(TCGType, TCGCond, TCGTemp *, TCGTemp *, TCGLabel *);
 
+#define DEF_CRIL(NAME) \
+    static void glue(gen_,NAME)(TCGType, TCGCond, TCGTemp *, int64_t, TCGLabel *);
+
 #include "tcg/tcg-op-def2.h.inc"
 
 #undef DEF_R
@@ -350,6 +353,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef DEF_RRI
 #undef DEF_RIR
 #undef DEF_CRRL
+#undef DEF_CRIL
 
 /*
  * Generic expansions for templated operations.
@@ -425,6 +429,12 @@ static void gen_brcond(TCGType type, TCGCond cond, TCGTemp *src1,
     }
 }
 
+static void gen_brcondi(TCGType type, TCGCond cond, TCGTemp *src1,
+                        int64_t src2, TCGLabel *l)
+{
+    gen_brcond(type, cond, src1, tcg_constant_internal(type, src2), l);
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -720,6 +730,11 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
                                         TCGV c, TCGLabel *d)            \
     { gen_##NAME(TYPE, a, TTMP(b), TTMP(c), d); }
 
+#define DEF_CRIL(NAME)                                                  \
+    void glue(glue(tcg_gen_,NAME),TEXT)(TCGCond a, TCGV b,              \
+                                        TINT c, TCGLabel *d)            \
+    { gen_##NAME(TYPE, a, TTMP(b), c, d); }
+
 #include "tcg/tcg-op-def.h.inc"
 
 #undef DEF_R
@@ -729,18 +744,10 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 #undef DEF_RRI
 #undef DEF_RIR
 #undef DEF_CRRL
+#undef DEF_CRIL
 
 /* 32 bit ops */
 
-void tcg_gen_brcondi_i32(TCGCond cond, TCGv_i32 arg1, int32_t arg2, TCGLabel *l)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_br(l);
-    } else if (cond != TCG_COND_NEVER) {
-        tcg_gen_brcond_i32(cond, arg1, tcg_constant_i32(arg2), l);
-    }
-}
-
 void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
                          TCGv_i32 arg1, TCGv_i32 arg2)
 {
@@ -1531,11 +1538,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_brcondi_i64(TCGCond cond, TCGv_i64 arg1, int64_t arg2, TCGLabel *l)
-{
-    tcg_gen_brcond_i64(cond, arg1, tcg_constant_i64(arg2), l);
-}
-
 void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
                          TCGv_i64 arg1, TCGv_i64 arg2)
 {
-- 
2.53.0


