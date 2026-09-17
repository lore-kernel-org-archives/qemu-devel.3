Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F9AC982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73l6-0003x0-HN; Thu, 17 Sep 2026 00:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k3-0003Bk-OH
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:00 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73jk-0006mt-EV
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:28:44 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-85469d249c6so338980b3a.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619318; x=1790224118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SutwjnqPe1GODElxHHrPeNhq6/LeSa0ui+ENqllO/0c=;
 b=uE/PQ71eTSZYCz3p9n4WEofiIqqiWAqnkkQHamhqJmriWVMo3Zv4ipVnw/hR6XeK3d
 0GFI9kI1dpiH2z1xdmBP1a9SRCYIxiaXL1D94o84jxnXENneHBGwTbtfaAujSTIg53Ug
 qZ6JcH4FbmmaMESFNYTiwHMFWE/Ootv4vs0jEOf4UGTm1tnzX+Y4O9HiMRFx1V/SvL6j
 STOu93BREtoi4DinuH4VUEoqfn8Ffa/c3aQKXqHX0VyyhiJyOIoKxxS7vWM02zGZNDoL
 nXkGScdDgZbk0dIHXVkfBZBZevSUNwGhdKQPAAvTIaYG1Ctga5mT2RPCl+rhYSb5EjxZ
 Cg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619318; x=1790224118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SutwjnqPe1GODElxHHrPeNhq6/LeSa0ui+ENqllO/0c=;
 b=SxDGCHcWT5FySLOp4Li2/REYsI1kTDFsNKP8l12j4oEdbRbh/Cd91Pu5iyqeY1AYQw
 BRYgDsCX2serCcdGMpvBNtGY/v1WQ2HUQBzDDqSVkfgdJFJOE2F9mRoTDEjyrIpxe76Y
 LRfdc+oE2QEEqEPknNS7ttnFlHjgvDrTLIFhsCcSXa175TOoBw15zL/AGtpeZIlQVFdZ
 dMvE0hR/DQOyPOCJ8tr+apMl3iEo3sWMsWEk5r8G69g2iA3udIVmhfbSvGQ98/mW7DrD
 /Fhl9xDk4f8ly+qerj9qFtveIlT2QYpXYXgKqvAzu58y6PzlcNzH1PHGR2YGycIM2UIP
 LHzA==
X-Gm-Message-State: AFuF++lIFwTNKBwX3B+Ov4ydSW0GfC5OCC20+n04mKeg9wwOAq+HKWtJ
 SH5BW5JxfIpDmRTaPTj1wOhpzpRLhOUPIJSw0B0OsNkrRiFkL/6oAWRncRlAW8e0KQd8ClP0sQ4
 ZtNIPm80=
X-Gm-Gg: AYBFou3xNb7byDRQsXpxIfgQt1QyFgWu32Ip44nO2mLLY0mG8bhvyK4DUfISvOAqIzs
 2a+QM77QoE7dNRtsJuK38aBqZu+6ym/XKgccxRgtTcXRp1OWwuH1aud0FE+hVwJtcjyrab62W/L
 BeDUYEazlOXs+HSzA9WePXJnWuBd7I+4+w/GqKaWXfZvUhYHgTUqlcJNQjVfo6aS0QSMCvvhrMl
 wXDX5aTBXyJIjZmhOqekc4Z+siRGm8drAKlDLaCzFom+/2UaGVTb0EVKgDBSdZ6fniows9Nmiv0
 3KggtxPzdp2Hzn2fCjjJ8LcbklPA3KRgIpuBbsI4p0DEC7GFS9Ch13q/iJA7Klshk8C/jhk7SZ/
 6vRsT505rzVb9LCLggaPkfIbdcAaF3o0eMfvMeBH9GsCvxXxRk/v9yyBEwZHPvE/cL5GKGIZdOm
 jPYzDAUuo8l3lovHsZ6uk2/CPk7IGdzaZ9FU/rdMDFN8R/DJrAKV88JK569iocfnfoPLomtJYpw
 TVrn5k=
X-Received: by 2002:a05:6a20:d8b:b0:3d0:d1f1:6ec5 with SMTP id
 adf61e73a8af0-3dd5f3c0a82mr13996811637.4.1789619318210; 
 Wed, 16 Sep 2026 21:28:38 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm10458984c88.15.2026.09.16.21.28.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:28:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 011/101] tcg: Generic expansion of tcg_gen_discard_*
Date: Wed, 16 Sep 2026 18:26:53 -1000
Message-ID: <20260917042823.542588-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  6 +++---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 33 +++++++++++++--------------------
 3 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index f54b3618e8d..e1c87792a69 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -92,6 +92,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
  * Construct operations from templates.
  */
 
+#define DEF1(NAME, T1) \
+    QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TEXT)(T1);
 #define DEF2(NAME, T1, T2) \
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TEXT)(T1, T2);
 
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
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 5de7648ed48..6ff97260dc6 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: MIT */
 
+DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 3b3bd5cdfa1..a6072f362e3 100644
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
@@ -324,6 +314,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
  * Forward declarations of generic expansions.
  */
 
+#define DEF1(NAME, T1) \
+    QEMU_ARG_NONNULL static void glue(gen_,NAME)(TCGType, T1);
 #define DEF2(NAME, T1, T2) \
     QEMU_ARG_NONNULL static void glue(gen_,NAME)(TCGType, T1, T2);
 
@@ -335,12 +327,17 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef TINT
 #undef TCGV
 
+#undef DEF1
 #undef DEF2
 
 /*
  * Templated operations.
  */
 
+#define DEF1(NAME, T1)                                                  \
+    void glue(glue(tcg_gen_,NAME),TEXT)(T1 a)                           \
+    { gen_##NAME(TYPE, glue(C_,T1)(a)); }
+
 #define DEF2(NAME, T1, T2)                                              \
     void glue(glue(tcg_gen_,NAME),TEXT)(T1 a, T2 b)                     \
     { gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b)); }
@@ -377,6 +374,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef C_int32_t
 #undef C_int64_t
 
+#undef DEF1
 #undef DEF2
 
 /*
@@ -385,6 +383,11 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
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
@@ -399,11 +402,6 @@ static void gen_movi(TCGType type, TCGTemp *dst, int64_t src)
 
 /* 32 bit ops */
 
-void tcg_gen_discard_i32(TCGv_i32 arg)
-{
-    tcg_gen_op1_i32(INDEX_op_discard, TCG_TYPE_I32, arg);
-}
-
 void tcg_gen_add_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     tcg_gen_op3_i32(INDEX_op_add, ret, arg1, arg2);
@@ -1461,11 +1459,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 
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


