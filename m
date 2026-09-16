Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF97C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pOF-0008UE-Ss; Wed, 16 Sep 2026 09:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNV-0006sY-Kv
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:46 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNS-0001UJ-2Q
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:45 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cebad4aeso753327a12.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564120; x=1790168920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+7jQDthd6qDrSaal31YI3HVx8YsrquoYAL1EE/MY/rg=;
 b=VxS1+mGRjUhW9ysuLnPFbas2242B9GMplS8ul7V//jIenisND+3S/t6XC5n+Bi1zED
 YQt6gOhesVyBQcdk9KOCwZj5ILYPsI195FyZpy8YgZqV33fDqQUnzmI8eA5zuaq2U3UF
 l0VcCR6Yts/n6DFv3V6rs5ybvWJDf2oEUouQ8ZxeAyxthLX3e9xTDmL5PZmveOhhsp2K
 tpot0/EntcWu4nmvFtzlISZgQo8Pdov41GYlCr7x6AWLBQBALnqurw2j9uJQJ1ep0K4j
 513FM6aqaM+/TSvB8rswuZrDGXBCF/l2z3CAPU8Glx1QqsL0ZMCBbkiKqUej5rJ65Aek
 Pd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564120; x=1790168920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+7jQDthd6qDrSaal31YI3HVx8YsrquoYAL1EE/MY/rg=;
 b=BcabcIK09dwdA8j7k5gocey7R3HhJTVo0OK2wrlrXcLaMZ6Zg+OFJ+Nv8e1nE7Ma1m
 BtErXf/QJp57k7T9tR0cAexhTnFlw4oxIoXkM8HuXWOgxQNmLe9Z97yRD6j2FQPS4KU7
 8N7CaKCx2eU9apHSZW0emtGsZUL/6rjWDzq236Ek2A9IYMA1xEdt+J0z+JnbbYmUjdDf
 04Oz9Vr0wJ8fitbAAWcdCFbGLPjwlTTuTBEo2wV93iGn3DI+5qEjZFIDYxHlQYM0dAHh
 45KKRSJkT2xfVnESbI2xiWqD7P7OpFuEhd57OJ/F/Z+PO/Q5gxwf78KG+9j96FbcJs3k
 IICw==
X-Gm-Message-State: AFuF++nrREipTGIskHTk1YHpQb6CvwS0wsgGXSLRewvwUjvJ2Kt7bQU1
 J0kauaV0vKK4YUAfCrs/Ywe6zBanusJKKbYeABJKGssmv2W4HCk1NJfKL0cXCPP6yLCbZ4U+l8Y
 42eMPhN8=
X-Gm-Gg: AYBFou0Pfapv98IoV3sePMyaDeNzQ28dsC5ZJiqh3krJ1VxOeYX36k+ZsSpei2lQGG6
 ulVZKIOkF1f1LhNmLGtkhcVJSJSIfZAmXB+ffBoendxQnZ2PIBer24oAJTEjFENKXORCUXYJh9q
 vBUPcC7IWgeM5FinDu3PsiDab0vXxafKktb0G4ELPAAhWkvGAyO7HHkmdcPrJKshp0tLLUl4y4S
 Y0V8jw+eCsy8SRw3x/Lx0rjdSEtZcQMMF6oWuG+ak3Jd4mLhx+nYEeVY3ehbFc52SgA+fOkU3Lf
 A5/3OUDlqu3CFuorACjlWwwCtSy6gT/SE//jPkVQz4m0Qe/Whd9tFQQlk6wvojOK1r8KmV8w4/8
 cF8Rh+Dc/0Mzj2gAWhF197MbRnoMeedGuG0iKEsqHrJDq+JeRDO2/hQle0He65CywrbZ23T/9jK
 DHGRrahj3P7qdEtP6UIibLg8WeDv8PrLC7KPuY1Ey5wZH4dTObK9yeWnVGX6tf77xfAerQrh5ht
 Nu3lr0=
X-Received: by 2002:a17:90b:510a:b0:39e:423:bb8f with SMTP id
 98e67ed59e1d1-39e1e24fa7amr7078483a91.1.1789564119315; 
 Wed, 16 Sep 2026 06:08:39 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm9398056eec.14.2026.09.16.06.08.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:08:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 66/92] tcg: Generic expansion of tcg_gen_ext8s_*
Date: Wed, 16 Sep 2026 03:03:41 -1000
Message-ID: <20260916130409.3382710-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 4838e06f1d4..cae95b3d42a 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -143,7 +143,6 @@ void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_ext8s_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext8u_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -187,7 +186,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_ext8s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext16s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext8u_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 3b44db51f55..afb8bac515b 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -18,6 +18,7 @@ DEF4(deposit_z, TCGV, TCGV, unsigned, unsigned)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
+DEF2(ext8s, TCGV, TCGV)
 DEF4(extract, TCGV, TCGV, unsigned, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 40dfaab5670..32c65e38d17 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -694,6 +694,11 @@ static void gen_eqv(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_ext8s(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    gen_sextract(type, dst, src, 0, 8);
+}
+
 static void gen_extract(TCGType type, TCGTemp *dst, TCGTemp *src,
                         unsigned int ofs, unsigned int len)
 {
@@ -1284,11 +1289,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
     tcg_temp_free_i64(t1);
 }
 
-void tcg_gen_ext8s_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    tcg_gen_sextract_i32(ret, arg, 0, 8);
-}
-
 void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     tcg_gen_sextract_i32(ret, arg, 0, 16);
@@ -1590,11 +1590,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_ext8s_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    tcg_gen_sextract_i64(ret, arg, 0, 8);
-}
-
 void tcg_gen_ext16s_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_sextract_i64(ret, arg, 0, 16);
-- 
2.53.0


