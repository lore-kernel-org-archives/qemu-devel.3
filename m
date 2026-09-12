Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FDDC88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:37:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L5K-0002KF-Fq; Sat, 12 Sep 2026 06:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L55-0000dp-Dt
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:35 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L53-0008R7-AZ
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:35 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d747ee1f38so7784515ad.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209332; x=1789814132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZUaOM8ch/eTmMYg60Xwfk6svanahlG07Mhbjk98QIEM=;
 b=AjO5q0Egc3XzMT4hqUsxM0x6tdpJ5ZIOBOB0WJyAubBYBYA1J9UPBPQ+UV9G/DGkp2
 bmUkAE5MBPlqELLtbO/OSSeHNAdBi84esysLp99dgL85EWjrFtAgSlyg/GN2QrSEY1wX
 Htk5Oxz7SO7wvNA9KxP7Vg4jUbHmE8BlBXiZ6SFxzNKFItMN/FG/MLrDP4AKxPyTzGop
 Lvq0nDcHfS8bJuziHNCDtaClyhBvodlKIm0fCt7Iee5wi41jk81nESk0cjoEzZu//BwP
 gg6sj9xlPsTd7/AqdgbQKRrHVCMxIIQ2V6alNHXoIm0XHg/dlR63IPGv0RngYExPgHBU
 NEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209332; x=1789814132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZUaOM8ch/eTmMYg60Xwfk6svanahlG07Mhbjk98QIEM=;
 b=Qb6w6XXrTnwZN10O2BZnh+M6SnZWmpKwv7+2zTzntZDd4qR+t8/XH4BLVE5Ut1IG+o
 TQjXZS4Qd14Oyvd6NTigiNrAzJIOKkX1boBvA1eemXcIEjbBesmKYnU+VjoU20J+e3KG
 mlaTgRwdogpRFjziKlAiFCMhIQmjabm0G0LRx7E6fzgjgypbOp6bt/Ad+3Oib3fVxBkD
 +K0J3ItU+lyobBcqpe9J8iMH1XmL6Z/+ECnydjBupe0L990iLQEqJRUZpw41zMkHek1a
 AjxafI10+9FMzKrSbJfoFw2QZ9+aiNOSzmxPTJaENfoKO+vzpP2ULBTeIlEZIA5hzpjh
 UC4w==
X-Gm-Message-State: AFuF++kzt/ntmTwJNl92eL/QX/uCK9X+VWXZp3jIKAuZRA4HR+452wdE
 29YmsqcCCliKbEm23ObjJgxm/m86jecWmSk9wsAgYSrZJM+YrllD2h7MkH9eAQ+YfMjZQVXTVyH
 nEmuYbBc=
X-Gm-Gg: AYBFou1pkM2JNtI6JCWKXe8exmriJ9uUdewnN4Z80Nf/LnGeRZLkQNaIYZYkYGqF8g1
 sUbRQapytsVTAuI5j54TOGjfftkAl22VuGw8fU3zj6EvP+BiwBVeD5L4Pp75lGmtwHGkF3W+vA7
 p2BIYAKnqFDXtaViTm7RgNripsfi0lRnAyl/hNvmeR3ZA9YjNCaLaexGmkSXUWnIKZT+3H4QjqH
 8k3Tr9oExmgaRI/vvnWamFNrX1W3FxoxxNOfrqvB/FR3oDE37k4XKVQLhLuYOvi8QYvqCHw0Jps
 iCL62lYQ35ICFxPy8/bOQKk0SBy6bS9MZ1PgEF2ToHdYCFIrpmb7Gfu8gZVbcpZW5KHAwTrp9TM
 s4+jnMDSaXBXlJF0nS+R2CDGwKIbLXW+CJZi4vGCodwidsgF6v3z0GG5pGtOHx2yYo/AD73ttLp
 Cpz90q0V52mWD+NIJr+1z24X4fA2mpMpxDoYdaD35i60qObVpdwV2J8gJRaHH6lxZRlbFdeZMnb
 ZrlMo0=
X-Received: by 2002:a17:903:1508:b0:2d8:d4cc:be62 with SMTP id
 d9443c01a7336-2dd2a35aa10mr162573705ad.15.1789209331948; 
 Sat, 12 Sep 2026 03:35:31 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 65/82] tcg: Generic expansion of tcg_gen_ext16s_*
Date: Sat, 12 Sep 2026 00:31:09 -1000
Message-ID: <20260912103126.598030-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h   |  2 --
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 25464d67306..a7edac63f69 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -162,7 +162,6 @@ void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
@@ -204,7 +203,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_ext16s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext16u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 05162cdaa87..3a8b1307b10 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -14,6 +14,7 @@ DEF_RR(clrsb)
 DEF_RR(ctpop)
 DEF_RR(ext8s)
 DEF_RR(ext8u)
+DEF_RR(ext16s)
 DEF_RR(mov)
 DEF_RR(neg)
 DEF_RR(not)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 7a617d2093a..3ef2220e424 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -658,6 +658,11 @@ static void gen_ext8u(TCGType type, TCGTemp *dst, TCGTemp *src)
     gen_extract(type, dst, src, 0, 8);
 }
 
+static void gen_ext16s(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    gen_sextract(type, dst, src, 0, 16);
+}
+
 static void gen_extract(TCGType type, TCGTemp *dst, TCGTemp *src,
                         unsigned int ofs, unsigned int len)
 {
@@ -1324,11 +1329,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
     tcg_temp_free_i64(t1);
 }
 
-void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    tcg_gen_sextract_i32(ret, arg, 0, 16);
-}
-
 void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     tcg_gen_extract_i32(ret, arg, 0, 16);
@@ -1620,11 +1620,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_ext16s_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    tcg_gen_sextract_i64(ret, arg, 0, 16);
-}
-
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_sextract_i64(ret, arg, 0, 32);
-- 
2.53.0


