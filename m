Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11AE0C982C3
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pNa-00077T-OU; Wed, 16 Sep 2026 09:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pN9-0006jq-TD
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:30 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pN5-0001Op-Rk
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:23 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc1cebad4adso731549a12.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564098; x=1790168898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0/433TiAnz5/pppLOHUA8lXRzQi6KXKZ1FyAmUmZNzo=;
 b=CRQ05jsoAjxZhzCFcRDhbQZ3uuodj3xMvz9bRDAwf8CzyEzlpksuepOWQKGe8sO4fn
 V7lSVyEs2bPST0SXOUBWb4ZAuR7acNnL0kS/N5gSeFIvRoWWe2r8B95OrjEupwD1n3u2
 PprE+PSQZJcfE9Kp4yafb6/ahg7fstsMF6eRumyeY+A1t52Z/hLtBmJ4KOHW1rvGjcYd
 hpmJdIy6HfHB0xy3PxUW0Pd4+cGNMaJ7ELB1ReiK4nr3WRkQla2aI36HJD/AA2lSV58b
 w3nX0+zCsJ4heXjf7TnWRZWxXoCa2f6PynvGlaOULDvp6dC590oRwjlgIM9MAx20VcZd
 0AXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564098; x=1790168898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0/433TiAnz5/pppLOHUA8lXRzQi6KXKZ1FyAmUmZNzo=;
 b=qtfM0YptL7BNXrE33opc70XlV94kmh+QTzIe8eTjAmZeynjq74Xh1W9woNxMeJ6Q48
 307Qwq/ZSkv8f6ZK1sajFG93Tw/3NY9f6N4W7ekF62HBDnciJU0t16Gbnikn3UU6TdrS
 LUVI0KcyN1nTmMeF+t9y+OAsmDgrefOpJzOEdVRHtqWAPEwxMEp5Nwr6CqZBUhUvwG6H
 IpPJwtabwqdqKqTdYNCjCHWXh0sgKS9juTFxXKdsHVMHxsseuw8yFDXsahELfLpum7JI
 geOfvX3HKFQDlAbkEVS/rgb5sUXWw/Z7pjWS0s4kwATfDX9JsqhjOJmY+4Fv+/ZobqUC
 skHg==
X-Gm-Message-State: AFuF++k2OnXh9yFVrBhBtdD4NYIFOWHMQzR71ojqGJOAh39hGnZn1kAO
 mstAelErp8oyrGII/EC/kty4vF9ksbDjk5IakxXMTSk7eap27pZ1Ovq/HuY4XCSvutgXJx2fA9C
 sue5x4fg=
X-Gm-Gg: AYBFou22n7QIZ8DwanRfQOP9jNia1eiJRHgLVnr+5OOZDXThiAtX7OMEoi1UZv5mV+O
 eWftE1aVTsGP/BZH7e3ngUYLUVQomQ2hK8h0k7ocptrPX7sQmdW4GYAjzBY/MLXvdNNwFjx88Xd
 xflXRcZWEWJmiLzj92mpazzOeOf6+pBpxFlKunRR34uiX7T+6+4eQqZPYZLOPqljapvKC7cRwM4
 45Au8heG5/4eaLDV11kZupecB9Oom1U/ahXizx04CLJ9Iphz9ofGvCrzMttiBCg13+CEjXRp1FT
 VK6+jlHdkOPDjEt331FWor8/9pYQF6k+jO2XYy7w8KXRokDEouAmmtojTVZxmrWZS88XYfRbHF+
 3eO9jKbs7n/mnIQ2wy/yaJ/dJ9/YRu0/vk2dJhGbwm/ecOi4SIAyGvkCMPqowQtBVRLqua2P5I5
 1/SOJ2t7gvhfjDuITXy82QdZbIWKD5YPcjboSeUvalG3phb0Zh546EolbLISB6bE8K/6dAljm70
 AizEsE=
X-Received: by 2002:a17:90b:586f:b0:39e:28dc:3682 with SMTP id
 98e67ed59e1d1-39e28dc380fmr3424619a91.21.1789564097893; 
 Wed, 16 Sep 2026 06:08:17 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm9398056eec.14.2026.09.16.06.08.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:08:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 44/92] tcg: Generic expansion of tcg_gen_negsetcond_*
Date: Wed, 16 Sep 2026 03:03:19 -1000
Message-ID: <20260916130409.3382710-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
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
 include/tcg/tcg-op-common.h  |  4 ----
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 36 ++++++++++++------------------------
 3 files changed, 13 insertions(+), 28 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index c3fd467400e..6ec53bd7a15 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,8 +146,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
-                            TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
                              TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_movcond_i32(TCGCond cond, TCGv_i32 ret, TCGv_i32 c1,
@@ -213,8 +211,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
-                            TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
                              TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_movcond_i64(TCGCond cond, TCGv_i64 ret, TCGv_i64 c1,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 42e0fde523a..8bbbf39f13a 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -17,6 +17,7 @@ DEF3(mul, TCGV, TCGV, TCGV)
 DEF3(muli, TCGV, TCGV, TINT)
 DEF3(nand, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
+DEF4(negsetcond, TCGCond, TCGV, TCGV, TCGV)
 DEF3(nor, TCGV, TCGV, TCGV)
 DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index d49ddbeb454..2799d4abce9 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -578,6 +578,18 @@ static void gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
     gen_op_tt(INDEX_op_neg, type, dst, src);
 }
 
+static void gen_negsetcond(TCGType type, TCGCond cond, TCGTemp *dst,
+                           TCGTemp *src1, TCGTemp *src2)
+{
+    if (cond == TCG_COND_ALWAYS) {
+        gen_movi(type, dst, -1);
+    } else if (cond == TCG_COND_NEVER) {
+        gen_movi(type, dst, 0);
+    } else {
+        gen_op_ttti(INDEX_op_negsetcond, type, dst, src1, src2, cond);
+    }
+}
+
 static void gen_nor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_nor, type, 0)) {
@@ -771,18 +783,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
-                            TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_movi_i32(ret, -1);
-    } else if (cond == TCG_COND_NEVER) {
-        tcg_gen_movi_i32(ret, 0);
-    } else {
-        tcg_gen_op4i_i32(INDEX_op_negsetcond, ret, arg1, arg2, cond);
-    }
-}
-
 void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
                              TCGv_i32 arg1, int32_t arg2)
 {
@@ -1549,18 +1549,6 @@ void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
     tcg_gen_negsetcond_i64(cond, ret, arg1, tcg_constant_i64(arg2));
 }
 
-void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
-                            TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_movi_i64(ret, -1);
-    } else if (cond == TCG_COND_NEVER) {
-        tcg_gen_movi_i64(ret, 0);
-    } else {
-        tcg_gen_op4i_i64(INDEX_op_negsetcond, ret, arg1, arg2, cond);
-    }
-}
-
 void tcg_gen_ext8s_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_sextract_i64(ret, arg, 0, 8);
-- 
2.53.0


