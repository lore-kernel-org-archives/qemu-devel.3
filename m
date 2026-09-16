Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C95C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pQv-00086d-RX; Wed, 16 Sep 2026 09:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pQl-00073b-Pp
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:12:08 -0400
Received: from mail-oo2-x0c.google.com ([2607:f8b0:4864:31::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pQj-00020Y-BG
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:12:07 -0400
Received: by mail-oo2-x0c.google.com with SMTP id
 46e09a7af769-7f4f0d1779dso845449a34.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564324; x=1790169124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DjYmYwBMbxBqNOl5TN7j1zkbJH9NFU/KIkmYxr+nLn4=;
 b=LEv8R8GUQoD59cwvBvI1kedpCAFU8DS+1+utrO1wk1W0Ivkg124b3RtDl1tGvDfgWG
 qN5gf/7+NId3E+hQfBN33Q9KcuzVPPwvxa3xIVEdnGe5Vu6wBNabnwOlkaH7kXBDmZ7g
 swRUTcwUR9In7W6kUncJSXfdZKEF1C1TO/jc8b6Gh0mMV/9p5mIneCoov64KXmACSz9C
 hOUlqC95R6BZZVBgOpAZs+XWEBwYCkWoDaZEr4p65xUd0SgVJAaO5aCXXJfRzDMA87mo
 Ud2jD2HvxOT6Xphjs+ms6FpxRZqRRrMorR8eoubW/zp0YQXZ+lrgU5IpN50l47X4Fqks
 IzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564324; x=1790169124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DjYmYwBMbxBqNOl5TN7j1zkbJH9NFU/KIkmYxr+nLn4=;
 b=DIbiSCPvBUZ4BEdR8PHPnUWPSWdA/p6zBMGGjts7c0TgJjbPGopAMS4eZXr8dHVr44
 V1TntQZ6dSEf7lPeWYbhftPQ+qnxzPrX4trFEUvxR3yXbO0v7N9i+jgS8uOlwn62mz+F
 6p6p++x7EkeidcJDzL6Bkuk6kkqnzH3+xQwqtQkjeTbo/qwFh2BCFfu4glfENVX22dj2
 nHijxpNV6EvMUh8af2CITA4vHO6KDboCFn3JBPVyxPqy8MjFXYU4ZHPWY4xhTN0sovBm
 qI0DH8AU+a2Dj9eZIBh9QvWITLXfz843cf9tRedWXjAHkS3Jz/GUHNUf3d3OTSRPddBC
 TReA==
X-Gm-Message-State: AFuF++lmcXzUe/CRVtI69KneOtkVhL+AVsMwODPvfKVfOSp1QrYukrzC
 xBWgdxT2kM9C91wK/ecX362M4u1hXpivry9Qofcv8kwPX/9TXV9LBAtDrAT6hqZqJ2ssf1VfBft
 MZVaC7Ns=
X-Gm-Gg: AYBFou03IFTMHAVv4ZeubShstobadNngaWTZZUGOt9FXylNhUsZanLpPe6leg6bUtu+
 snJmq2XkeZzQAMarzxC4t31AmneRbTMWX7MFlH/ArIqjoEHULN3uSgVhtZELMF0xJC+brE0E5xZ
 KtDrUwETh0SFm4kqX85bFaFq/MxnronqVqwyqboeUtI06tn44xjG3za02o0hQ28URdPPJHIdC8s
 3m28RsRj3PaJkZe2HULnGR4VQ2+4TllS+gbm+tE2/Ji5coUrAw78FxP95y1zapIxigAvZpwLFdQ
 jMOnidf6jSeK0e/22tfX0+CCJhxCDmnF4wS8zzRmwYVYlPtGOTTyT/oe9h/QCiIUWIFhHgJ9IP9
 s6UODFq9aZTfUOi1Hnq/Ds+6srmmxEV18H5O0oCYcMRnGWCohDUuMC7J4bSTvTMqf1tkHYAtOJ8
 2vKr2mxQ1n6tICEvfeMjWmLqmjucJkbMpg0Tj/6K6qMTUI1P7gfpxwBfXu5JumyFbgwVi5sXoql
 ooXw1s=
X-Received: by 2002:a05:6820:8c7:b0:6b7:83c5:fdef with SMTP id
 006d021491bc7-6c7d44e804emr2445815eaf.48.1789564323791; 
 Wed, 16 Sep 2026 06:12:03 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5b22b74sm7873110eec.30.2026.09.16.06.12.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:12:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 88/92] tcg: Generic expansion of tcg_gen_revbit8_*
Date: Wed, 16 Sep 2026 03:04:03 -1000
Message-ID: <20260916130409.3382710-89-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x0c.google.com
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
 tcg/tcg-op.c                 | 51 +++++++++++++-----------------------
 3 files changed, 19 insertions(+), 35 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 56bc8ce4ace..c3d080222d9 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -135,7 +135,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* Replicate a value of size @vece from @in to all the lanes in @out */
@@ -161,7 +160,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
 void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
 
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 28cfa68db3e..13aa8e15e42 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -48,6 +48,7 @@ DEF3(ori, TCGV, TCGV, TINT)
 DEF3(orc, TCGV, TCGV, TCGV)
 DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
+DEF2(revbit8, TCGV, TCGV)
 DEF3(rotl, TCGV, TCGV, TCGV)
 DEF3(rotli, TCGV, TCGV, TINT)
 DEF3(rotr, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c77d25cfa75..555af3cf24b 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -179,11 +179,6 @@ static TCGOp * DNI tcg_gen_op1i(TCGOpcode opc, TCGType type, TCGArg a1)
     return tcg_gen_op1(opc, type, a1);
 }
 
-static void DNI tcg_gen_op2_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2)
-{
-    tcg_gen_op2(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2));
-}
-
 static void DNI tcg_gen_op2_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2)
 {
     tcg_gen_op2(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2));
@@ -1175,6 +1170,24 @@ static void gen_remu(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_revbit8(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    static const TCGOpcode revw[2] = { INDEX_op_revbit32, INDEX_op_revbit64 };
+    static const TCGOpcode bswapw[2] = { INDEX_op_bswap32, INDEX_op_bswap64 };
+
+    if (tcg_op_supported(INDEX_op_revbit8, type, 0)) {
+        gen_op_tt(INDEX_op_revbit8, type, dst, src);
+    } else if (tcg_op_supported(revw[type], type, 0) &&
+               tcg_op_supported(bswapw[type], type, 0)) {
+        gen_op_tt(revw[type], type, dst, src);
+        gen_op_tti(bswapw[type], type, dst, dst, 0);
+    } else {
+        gen_bitswap(type, dst, src, 0x5555555555555555ull);
+        gen_bitswap(type, dst, dst, 0x3333333333333333ull);
+        gen_bitswap(type, dst, dst, 0x0f0f0f0f0f0f0f0full);
+    }
+}
+
 static void gen_rotl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_rotl, type, 0)) {
@@ -1510,20 +1523,6 @@ void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg)
     tcg_gen_rotli_i32(ret, arg, 16);
 }
 
-void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    if (tcg_op_supported(INDEX_op_revbit8, TCG_TYPE_I32, 0)) {
-        tcg_gen_op2_i32(INDEX_op_revbit8, ret, arg);
-    } else if (tcg_op_supported(INDEX_op_revbit32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op2_i32(INDEX_op_revbit32, ret, arg);
-        tcg_gen_bswap32_i32(ret, ret);
-    } else {
-        gen_bitswap_i32(ret, arg, 0x55555555u);
-        gen_bitswap_i32(ret, ret, 0x33333333u);
-        gen_bitswap_i32(ret, ret, 0x0f0f0f0fu);
-    }
-}
-
 void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     if (tcg_op_supported(INDEX_op_revbit32, TCG_TYPE_I32, 0)) {
@@ -1744,20 +1743,6 @@ void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags)
     }
 }
 
-void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    if (tcg_op_supported(INDEX_op_revbit8, TCG_TYPE_I64, 0)) {
-        tcg_gen_op2_i64(INDEX_op_revbit8, ret, arg);
-    } else if (tcg_op_supported(INDEX_op_revbit64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op2_i64(INDEX_op_revbit64, ret, arg);
-        tcg_gen_bswap64_i64(ret, ret);
-    } else {
-        gen_bitswap_i64(ret, arg, 0x5555555555555555ull);
-        gen_bitswap_i64(ret, ret, 0x3333333333333333ull);
-        gen_bitswap_i64(ret, ret, 0x0f0f0f0f0f0f0f0full);
-    }
-}
-
 void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     if (tcg_op_supported(INDEX_op_revbit64, TCG_TYPE_I64, 0)) {
-- 
2.53.0


