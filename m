Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD33C79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L1Z-0004o9-JH; Sat, 12 Sep 2026 06:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1F-0004mX-4v
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:38 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1D-0007F8-8b
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:36 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6b128dd0cb1so1212795eaf.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209094; x=1789813894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AaerkQwBwop4pHWbYWDAQ1y16TgWLuxxI5C3BWXAulU=;
 b=Szws1ylF0ihFqCqKN3peh/KQP+wLOlU+BCjEU3s6AH5lDsIogQsa4vRStyOyD3lwaz
 H7VAZnoCU7RhnsbW2K5ffz+SlxuTEwc4SZQD8TXsmM7tZg9unOTsaLdvyvOaXNMXQsuE
 SwrG0TWfGZTrQiH/6/59DUqIs4GtcLQXSNkgE3gymvx3UzTeBtvdmDO08pBpCNeZIQK+
 5s5uz6BCui5CSM3AP6iSWbibfSjDGMhASme9q6y3gfBl2PmldDqIFXwgUSDpFaw8/egD
 TNv//0efOATiR/Xq9q+kndCjVEkuuulwoz9ZPZZUJeeI44QJdY+UsXDRiSArV4QtqWXZ
 S55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209094; x=1789813894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AaerkQwBwop4pHWbYWDAQ1y16TgWLuxxI5C3BWXAulU=;
 b=dl5pFlq8ciY6upcBm4ZNEUJ+Ez0ADCLpg+l1rX++B+YpB2BzRkzC/YL5B3pnjh7BZN
 fxQ1dC03rL+6UHshiyZzds3+NzOJrkqc1+inrCgNItcOn69Axvc5nq7/OOkYHwB/xqch
 eZWrozltQYsmweeklQGgpLhlZOzBMFv49khpXVbVpTwCcTzQKmEqYb4GJpNatJPmXdqg
 YV03JKeiUikkiDP0WMvDQm5qpLgtL5y1IA51cFqVtMgf1/g1P9TdHDvVCgQ/7V2WCXMk
 Yi/3oY7xeiz4da4aQA7StM4jxejhER1Xvw843KXrRcSTfOJl3y8tjlrDtMZZVETUrw0n
 b5Aw==
X-Gm-Message-State: AFuF++nGbyGg5Gi95eoCXd/AxbVe7G/uoVhprytvbUKEPXbmbr1lyXcn
 WmQb03BiZLsjw0/B70dqa/H2UkLGUGTYaRSRjG/EUs7wCVnSuijeIjtpCIYjNLNR27Gu3ihQUI7
 tBpHTqEs=
X-Gm-Gg: AYBFou0GNmo8+khxwN8YtLLXzu0kaDVlQS9PobA8HIaUY2Nnlu/TiTkP6OA211bg0M3
 +yQzRbRTTc5ECJeYmjciy39ThurzfDDTeUrjb4VBtkUyU/XpwK6PWDILWXhxAlgUoEajQCFvqGk
 ghRZd0VUSv30awfcA2vTi/4uUmpPb7Lu5nqnLEBpzyEwF1Hi1/yiD3NJf1AbX6F0WIEE69JI7rJ
 PRrGONhBBlI+N9lSURTcPN0/TiMchLaIhAqGGP/xX0CLpcj2PchwwOAWwN+AEwTKWV/A+6TODdB
 tZ+ocNXa37Mp5MHuMd4GTDOpXvQEU6xtljUY2HRbuZQh1VnlQB6t9fzvqB3/JW8cFT3vS2eoNlP
 ZfJ+/DnE1sjpu3KQDL6w2XmiexVBPuND1U23u0D4Bx9+F5RcIF09izFxjm4v43ZAbi01x7GWDPD
 /DrWbwEE0c3Dwx6RqIdBYkhAIyOZt4ZYcmSnZePfXWa2xZ0Wa/gX3Fv9qE53x+7IgY6m2bdgzVQ
 4bv3EPp
X-Received: by 2002:a05:6820:161f:b0:6be:731b:5544 with SMTP id
 006d021491bc7-6c0bc1d6d86mr5683414eaf.37.1789209093705; 
 Sat, 12 Sep 2026 03:31:33 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.31.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:31:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/82] tcg: Generic expansion of tcg_gen_discard_*
Date: Sat, 12 Sep 2026 00:30:09 -1000
Message-ID: <20260912103126.598030-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc32.google.com
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
 include/tcg/tcg-op-common.h   |  7 ++++---
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 34 ++++++++++++++--------------------
 3 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 5fc8b43d083..c0de3f9f45e 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -92,6 +92,9 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
  * Construct operations from templates.
  */
 
+#define DEF_R(NAME) \
+    void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a);
+
 #define DEF_RR(NAME) \
     void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b);
 
@@ -100,6 +103,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 #include "tcg-op-def.h.inc"
 
+#undef DEF_R
 #undef DEF_RR
 #undef DEF_RI
 
@@ -185,8 +189,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 /* Replicate a value of size @vece from @in to all the lanes in @out */
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
-void tcg_gen_discard_i32(TCGv_i32 arg);
-
 void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld8s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
@@ -305,7 +307,6 @@ void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_add_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 
-void tcg_gen_discard_i64(TCGv_i64 arg);
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld8s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 0f8ee5f9976..7943746a44a 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: MIT */
 
+DEF_R(discard)
 DEF_RI(movi)
 DEF_RR(mov)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 8350110ebae..d796016ca26 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -119,16 +119,6 @@ static void gen_op_tt(TCGOpcode opc, TCGType type, TCGTemp *t0, TCGTemp *t1)
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
@@ -324,6 +314,9 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
  * Forward declarations of generic expansions.
  */
 
+#define DEF_R(NAME) \
+    static void glue(gen_,NAME)(TCGType, TCGTemp *);
+
 #define DEF_RR(NAME) \
     static void glue(gen_,NAME)(TCGType, TCGTemp *, TCGTemp *);
 
@@ -332,6 +325,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 
 #include "tcg/tcg-op-def2.h.inc"
 
+#undef DEF_R
 #undef DEF_RR
 #undef DEF_RI
 
@@ -341,6 +335,11 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
  * are of the proper type.
  */
 
+static void gen_discard(TCGType type, TCGTemp *src)
+{
+    tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
+}
+
 static void gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -357,6 +356,10 @@ static void gen_movi(TCGType type, TCGTemp *dst, int64_t src)
  * Templated operations.
  */
 
+#define DEF_R(NAME)                                                     \
+    DNI void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a)                     \
+    { gen_##NAME(TYPE, TTMP(a)); }
+
 #define DEF_RR(NAME)                                                    \
     DNI void glue(glue(tcg_gen_,NAME),TEXT)(TCGV a, TCGV b)             \
     { gen_##NAME(TYPE, TTMP(a), TTMP(b)); }
@@ -367,16 +370,12 @@ static void gen_movi(TCGType type, TCGTemp *dst, int64_t src)
 
 #include "tcg/tcg-op-def.h.inc"
 
+#undef DEF_R
 #undef DEF_RR
 #undef DEF_RI
 
 /* 32 bit ops */
 
-void tcg_gen_discard_i32(TCGv_i32 arg)
-{
-    tcg_gen_op1_i32(INDEX_op_discard, TCG_TYPE_I32, arg);
-}
-
 void tcg_gen_add_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     tcg_gen_op3_i32(INDEX_op_add, ret, arg1, arg2);
@@ -1434,11 +1433,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 
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


