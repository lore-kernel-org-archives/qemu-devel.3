Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30E6C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pNZ-00072R-JI; Wed, 16 Sep 2026 09:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pN8-0006jO-0j
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:27 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pN4-0001Oh-Ks
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:21 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-398c066106cso682108a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564097; x=1790168897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UfmJDtDaFnpCyOj4++FALZYQUjRRwtXojXnyTUkotwY=;
 b=UxD59h5zWfxnxTp7jNjq8BOWApvKJQNTarjI+/8ar+nXDOAhM78d1WXWUbo9IOQV5+
 zrbqvFEt/jGCre9k+9NiQMuI0DAxY5tB0CTnIYOeS62iAXlifGSmIVZoO0ije26HCgeZ
 I2OFqatBDYcbhFkn2bcq/8kqU8x5Q4/SaYwd3R0Sr1dAbc/2VE7FyTXESfoVo4j/MmN7
 LpHnhz8eyS0snxLTeIWrgRpJMgrFWswg1+sPFxZw6LR4ZtCObXjAHmtHlVP7ANeJA+HD
 BfuX33VzfhZXC59A8yIjedEWXmU7rN3x+w7r9TUgNr7/YbnhJC2gwE69wqpz3ttYhTJx
 5uFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564097; x=1790168897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UfmJDtDaFnpCyOj4++FALZYQUjRRwtXojXnyTUkotwY=;
 b=n1FzjYpjkSEOYAPEK20faB9pZmLXmaXlMvI5AriwN6DTDI5XLfKS2LQNmvFEmNmtS1
 zTQQ3b9+8sumqfgES4qu7ALWuZ5HDoCVGrzcDZQSVrxca1E2xELXmSQ16l43GUalUujY
 m9qavwxuGjMWMzKJ4xLFgO4c4XpLIaKOgOJmpKPx3WVWtrQ/IHk+GBLZY9dsPXt8rsFp
 iFf/Icr/pXA+aPWq+tUcZptEpSS351a/7l+CJTaIk1IPx47Ju6Y6LNts22PHBcjGwjQX
 UDjFHA90pe2gfv+OZlvghMdahELyX4nLA2Itp8F2TpqKq0Rpxf+w4QmQIFCXogH2O9aG
 /iFA==
X-Gm-Message-State: AFuF++nxr9n6jlr3MaKoXh3WA6P5iGZUdF09hS4sWqRa7aC9vlyC5KSR
 UTNFxsb3/Ib2MTowKotTp01U1X/73HDHPfUR9dv3Y0SGfStZ5GPc1qEHPQo4BpiczyG5EPQdLWA
 V4GUVYwk=
X-Gm-Gg: AYBFou2oy9Jdxp2BnZWoGPv0YUuXC2LGB68iiI4H3nVO5ZdCpmdu1E64ZRKerkOo0Qd
 EzeC4ANmKdWrFLnmfBlj0BQiqOcMxpRaqt80LEnCBL0A0LqBrJWCKXSs9NW0X9l7BBs1ysGlQHo
 m7WDFMnZd7muvk5uPftEpiZmZmaEA0TAusaMmIWN+GpxXSVVY0wL38eEpzvsqf1w3p8Z7by0FeX
 qwJfgsGsgNLVxJlvumys4UtFPWWzlaJxcNiyFNJkF9COlZqhKIHJGNud4H9nm5U2DqxedsJ7wY9
 XxwDsdQJY9n3YBINoiS6ewn5/4qbfxRGqTqkn+QIORrhJQ/sO3OqfuFCuCEeQPfnFyis2dHNTZx
 YRRiiTnd3wELBcar2JTofD/L4mmHru2tKTeixFcUNUvPV6qJVWlHIpnzlBYBtAi8+GxsfJp3rSp
 qnyKsI8g+ChqQvQMB+EaqaO45C4wtflU+UbUE9NFo7rlVCI8i1bXSbJBiv7lihAGfPx9DlX5Px+
 ZXYt3M=
X-Received: by 2002:a17:90b:4a51:b0:39d:ee20:1e28 with SMTP id
 98e67ed59e1d1-39e1e510f73mr6045782a91.21.1789564096810; 
 Wed, 16 Sep 2026 06:08:16 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm9398056eec.14.2026.09.16.06.08.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:08:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 43/92] tcg: Generic expansion of tcg_gen_setcondi_*
Date: Wed, 16 Sep 2026 03:03:18 -1000
Message-ID: <20260916130409.3382710-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
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
 tcg/tcg-op.c                 | 18 ++++++------------
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 2df3fe5f6a8..c3fd467400e 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,8 +146,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
-                          TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
                             TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
@@ -215,8 +213,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
-                          TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
                             TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 6ce86d2005a..42e0fde523a 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -27,6 +27,7 @@ DEF3(remu, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
 DEF4(setcond, TCGCond, TCGV, TCGV, TCGV)
+DEF4(setcondi, TCGCond, TCGV, TCGV, TINT)
 DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 20a31b8bcb9..d49ddbeb454 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -697,6 +697,12 @@ static void gen_setcond(TCGType type, TCGCond cond, TCGTemp *dst,
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
@@ -765,12 +771,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
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
@@ -1543,12 +1543,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
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


