Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75AF5C88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L4l-0007lm-H0; Sat, 12 Sep 2026 06:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4h-0007bY-Kn
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:11 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4f-00086b-4A
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:11 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc4c08393b0so288928a12.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209308; x=1789814108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yEDXHLI6f7eFpTuZkz4cFWCdqzPKB1hE2bwtp+6nsgE=;
 b=EF2iYCCk4E4jGLOfswVtGC1i9GJdkKWAimgjL2lbJxVYm8CEJIuUGz2aYCj8mz6bJa
 WZ6ydi0yoV+Geix6xrAWdiQI09chHsNd7AViee90RyWNzU2XJ+8xx0ZA5i0tqyGS6tlv
 w+OOf++a2k12uzEoJXdmenClpaHJE+cM/5mew4d3rH2pTogOmOOnRVLacFjk3Bb3BH7z
 OlzNnabgF19yio2ims6BVh1yOPacRnvXNAQRo5o+qDfBSzWO/EVe+IWk6T3eATkD7waz
 wHTKSMgkOvsH+xjolgM6r8yNeS/X0BMyss3378q21aQHwH2PUp5PL9qKY9T4XNnq1WUs
 hUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209308; x=1789814108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=yEDXHLI6f7eFpTuZkz4cFWCdqzPKB1hE2bwtp+6nsgE=;
 b=ONlI0pD7ey36rrzuy7Hsm9wdDkhsZRGN+aeBCBGsZxylifzS04GYQ9wgTmyZ+9IaUZ
 Sxii8mZ/Lz0BVpG7z+UU90WBc5k6YA8xVeKcPP19i1GqIUE3Gnykh6EHs1ur/Dso5bJL
 kZgl7GmhGjgAFlzLK8Fr4Q+IhuBkO8nJQRQCwbGqK3DmnxpUZk28xpIwj2I7XRiT7Pal
 Oy8eQVbDg+098W56GNoSO8Hvaw0F2rupx/9GVW7pl1rj19MJACIAVxyVrQu5V3prfl2b
 e4cgapm9O3a5RVzzPqYMg75NGi2EUxfxi/GydbGrx6Jr5XJBGi45WrN+6bnrsLyheHM1
 RAkw==
X-Gm-Message-State: AFuF++nu6WYykvRZDYVQqT3k1wjzzYBVVovoTMle+QjhawBN5xoZQani
 vWeBIgSHI6/idufKqDxLh+0cTGwfRGwnGFodqqSpHYOQiSpcLYDZUprz8sN4cuqaoI4pZdLJrz4
 Qk+4yeaU=
X-Gm-Gg: AYBFou2TaUoGAAFdFN1sNpVgWilD1P/a9HJ7e7luwln2zvhGpb5amto335y0ak6J2Av
 2lvn8R4jLMWkLiXS7zmwkF6wFtsxOWmpfognh1SIcl+ytvR6NzFPn78l3PmsenHDlcwq39zmSSW
 d7tHH0OoSFmW+g7xX8YIaRO8nBcgepr5y1xO0BD33FPubt/OJ2T12VA/Wm/bPRyhtIAIBwEUqjB
 ggVly4k8/uTFMLrg25BJSHT8TtxA5Bo1xukN3vkP57CGYw0K0ECNajdbLKIRN8gIpU80/io0XGd
 vykCi0RDh+Fn31DrVgwttscNcgNdbylQNWxwddum753w9Q2T77ItGbPHeM6b/U2BA2Jfzwd0X58
 i7BmSEslhfPiYFbITuSS7+db+QyXYE4sMiSlFkzwvVU7BCKxpVfbRLJ38SeJTR0u9GIZXpXjJEM
 w68w6xazGIdazvLXPCXPSi0bWp5EC7LAziGlC23De2tSt4P0ukHpN54aO8miV2l9njkH9U41gI4
 SJHBzc=
X-Received: by 2002:a05:6a21:468a:b0:3d3:ae40:51df with SMTP id
 adf61e73a8af0-3db0e482b85mr4488466637.19.1789209307552; 
 Sat, 12 Sep 2026 03:35:07 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 40/82] tcg: Generic expansion of tcg_gen_setcondi_*
Date: Sat, 12 Sep 2026 00:30:44 -1000
Message-ID: <20260912103126.598030-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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
 include/tcg/tcg-op-common.h   |  8 ++++----
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 27 +++++++++++++++------------
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 9b01acb3128..02272bc7e20 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -119,6 +119,9 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #define DEF_CRRR(NAME) \
     void glue(glue(tcg_gen_,NAME),TEXT)(TCGCond a, TCGV b, TCGV c, TCGV d);
 
+#define DEF_CRRI(NAME) \
+    void glue(glue(tcg_gen_,NAME),TEXT)(TCGCond a, TCGV b, TCGV c, TINT d);
+
 #include "tcg-op-def.h.inc"
 
 #undef DEF_R
@@ -130,6 +133,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #undef DEF_CRRL
 #undef DEF_CRIL
 #undef DEF_CRRR
+#undef DEF_CRRI
 
 /* 32 bit ops */
 
@@ -153,8 +157,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
-                          TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
                             TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
@@ -222,8 +224,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
-                          TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
                             TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 560e7f0394e..030c59bcd47 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: MIT */
 
 DEF_CRIL(brcondi)
+DEF_CRRI(setcondi)
 DEF_CRRL(brcond)
 DEF_CRRR(setcond)
 DEF_R(discard)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index ee6099461f3..1b4cb935bb9 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -353,6 +353,9 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #define DEF_CRRR(NAME) \
     static void glue(gen_,NAME)(TCGType, TCGCond, TCGTemp *, TCGTemp *, TCGTemp *);
 
+#define DEF_CRRI(NAME) \
+    static void glue(gen_,NAME)(TCGType, TCGCond, TCGTemp *, TCGTemp *, int64_t);
+
 #include "tcg/tcg-op-def2.h.inc"
 
 #undef DEF_R
@@ -364,6 +367,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef DEF_CRRL
 #undef DEF_CRIL
 #undef DEF_CRRR
+#undef DEF_CRRI
 
 /*
  * Generic expansions for templated operations.
@@ -653,6 +657,12 @@ static void gen_setcond(TCGType type, TCGCond cond, TCGTemp *dst,
     }
 }
 
+static void gen_setcondi(TCGType type, TCGCond cond, TCGTemp *dst,
+                         TCGTemp *src1, int64_t src2)
+{
+    gen_setcond(type, cond, dst, src1, tcg_constant_internal(type, src2));
+}
+
 static void gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
@@ -761,6 +771,10 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     void glue(glue(tcg_gen_,NAME),TEXT)(TCGCond a, TCGV b, TCGV c, TCGV d) \
     { gen_##NAME(TYPE, a, TTMP(b), TTMP(c), TTMP(d)); }
 
+#define DEF_CRRI(NAME)                                                  \
+    void glue(glue(tcg_gen_,NAME),TEXT)(TCGCond a, TCGV b, TCGV c, TINT d) \
+    { gen_##NAME(TYPE, a, TTMP(b), TTMP(c), d); }
+
 #include "tcg/tcg-op-def.h.inc"
 
 #undef DEF_R
@@ -772,15 +786,10 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 #undef DEF_CRRL
 #undef DEF_CRIL
 #undef DEF_CRRR
+#undef DEF_CRRI
 
 /* 32 bit ops */
 
-void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
-                          TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_gen_setcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
-}
-
 void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
                             TCGv_i32 arg1, TCGv_i32 arg2)
 {
@@ -1553,12 +1562,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
-                          TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_gen_setcond_i64(cond, ret, arg1, tcg_constant_i64(arg2));
-}
-
 void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
                              TCGv_i64 arg1, int64_t arg2)
 {
-- 
2.53.0


