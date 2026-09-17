Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634A0C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:34:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73nu-00035C-RQ; Thu, 17 Sep 2026 00:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nK-0001UP-HQ
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:23 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nH-0007DQ-QC
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:22 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc4d04d73b8so309983a12.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619536; x=1790224336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2nXWGw5zcUWnvEdQ2sHc/iNn1wy6zCyjLDR0NtaCqJA=;
 b=WjujNkk2mW2jPQhxJxjyAxwI/INxqY5jtMqOsPPbhRG+u+Xwps76wQaZ6U5X+SdveF
 M8zJOhoRX16vKM+soCx94s7fk5cjd30XjEZdJPa+7umh+/Mi4JmKyAtoInGfp5mudeLG
 A/Vkn6zy0MbSbowjYFFX1UHr3LC8sieDRUVH0kyiiHktK//Iz/+y4yjPvKB1LY6bW2OU
 hD5bIFPXiHWn7Mi2Goh0n/mz9lRN2Ib0P2gsjg/fIl4Ca5mdeWSGjP41gB3OIo2lptF+
 iATE5dYIBTOfrMR/FKEiD6hqkf1N96HJ5M+8glLC2oqsIaYedMU7rmw7cpxqai5TMr+v
 8QhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619536; x=1790224336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2nXWGw5zcUWnvEdQ2sHc/iNn1wy6zCyjLDR0NtaCqJA=;
 b=IZfYx2xoCMCnE4AC30vh4fDl88P21aThZTAAD4QPq8F0WVQQstYvjXBuZUAmHlHIZQ
 hEt0bOiJ8S0cr+8Rvdpy1IviqZ32RNijnkUbitzgW4i22o7YkypkmsCE5KkSjAi9Xs3R
 9Z8CNBnOznS6qDjtWSKTUfhggR5A3CK6X+HDuNtAM16jNsWuRUzVNCKJR31JXsF6mwLd
 bMuzys6hrhRDyPhYzrQFI3sGI0tu822cnXwFb4PIO+LXRWB8ZvyVZP8wccl6S39Otbdp
 qpDkC7mwrEtRXG7g8gghH3lIf3TYpI02E/WeK1AHCnMJNeQXt2FdS20qbWoCwV+Jy0Ng
 /MiQ==
X-Gm-Message-State: AFuF++lXLHEIOCvnyHXiK8QQHTTeIcnsxbMp79IJpkXZmkLkOo6q9lYK
 xOKpYenzgGKGqQ9H8rSAas3xVJiKAwDwvRjWeSjeqv+sklIwOmEyWmi/8guoeH81hxhYjUtYZDL
 f3oKpL5Q=
X-Gm-Gg: AYBFou2xlJDLA0Mto/K2nrJXw6MpUyL2a630RLjhWUZfksdYY4Ljd/EGmH+j+1nWlXP
 MAJw8yt5Y2JRsF8Ku5L8Bs+p3Zj/3rP8AE/bHdCR/kmOlsSCuwrHllaG4O7rZEadLhyGHumLfCN
 xgeC+53g3BMwOQ6Kx/oY7N5piwRMKU9CgH6wkD70hEMUrOmd86lyOXjsTkmFwaWDcmgnlxWXM4B
 PHSXBdVT/SfcsPyFxMzqYl/CAuXm26XV1KlVgXYwYmMq4BUR125oFFQQ5pyYar4BLPNjzmFU0at
 qMMgXYYEITEgK9J+GKksUklqWkpDjDLzzN1NNA+7Nwygv0SC5/Q+CQV7jNpMg+Jo/WIKebwrIgj
 O3LL+ubWAPGy5vyQmwcBJ3Uuii4hcaAGGP9rvB7mZ2BcHiPx6hsl1vkFXquURVLw0Ld/ptjavIZ
 fG0i0OsJslVoOqcHZ/057dIKRfI+Wb8vGrER/XlnVRBnHQSBVRs7UD64Zd6aOil5IAp1wqiZ9GN
 UTQTS8=
X-Received: by 2002:a05:6a20:6f0e:b0:3d1:e510:905f with SMTP id
 adf61e73a8af0-3dd5f3c26dfmr13201208637.1.1789619536379; 
 Wed, 16 Sep 2026 21:32:16 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 047/101] tcg: Generic expansion of tcg_gen_negsetcond_*
Date: Wed, 16 Sep 2026 18:27:29 -1000
Message-ID: <20260917042823.542588-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
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
index 38902e4b54b..4fc8d23e629 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -575,6 +575,18 @@ static void gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
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
@@ -765,18 +777,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
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
@@ -1543,18 +1543,6 @@ void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
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


