Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B329DC88E5A
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aBF-0003Wq-K9; Sat, 12 Sep 2026 22:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aBC-0003NS-EI
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:54 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aBA-0001xq-MH
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:54 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2dd53691be5so6770825ad.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267371; x=1789872171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=y3kcGIZ9KYzln4lxFM9XIbLkGkn+zkNKacqCBCqE6wI=;
 b=zEh+WapBVg2HT9WTr/UTLsZsft1ziiagQ4jqnK8nxPxaUUpn062ZRWwxB1ki0X/Wy3
 +czTTiallKRfb0Rge+u5vFHSMMfMWkNLdEfozlzspEzIC0uW15+01+NcNPFoSsjfcpJC
 A7K05cny3AJ3Y4EX6ZG6VSalIIBjwUQpbmdKNnPiiyH2X60FW+jtoELtv8QRqkYnvzkn
 Urc//xjKZniE9/J3TiCfkiU+YfehlFajBRYImd7ugwc1sltQt9LX04TTmtq28cF1VdRH
 CdxY1k8dHnDvxn2ldGLBP8/CyokJ5KCTrCqz8e0YEJfWM4HMs/pBgdMlSY6iucdqOx82
 A1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267371; x=1789872171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=y3kcGIZ9KYzln4lxFM9XIbLkGkn+zkNKacqCBCqE6wI=;
 b=oUeUAmUurNeR9kX+AgdxZq698xp+H2ioVMo4upNoa2d2tsU5HKxH4u/NnABsWjy48U
 +wjba4lOw8dvmAKb2KYLEXgsMfzXSd0uzfvFaSky/02nN4xGDgySulHXcHAbULQRKNLQ
 M+7DoxVjhF5PVL8GRlR1zYTDN4lhS4+rL2ywOTMWgSu3ThidwHlCIXNJ7Qvv2TzzDw2q
 Dynn3L4ND9kFKM8/+GTCMDXEowUxQ+9hc7zqAh8Sc5t/8snu/cCKJt/769KZJdFaQbBr
 KmHAv4vqod/KlNUhA+U+PXZE+wrlvQ6Prl0F3ThoilgvWJqKzd7Yx0efnzjOrl9o43B6
 HVZw==
X-Gm-Message-State: AFuF++mQSn91Jr0b/WHxMFgCs5A2klp8H8rc43jqEIXbMdm9BsZ3WXDt
 7im3/FZZdhWceAhZMdLXGf/bk7rb14fJcxwnEHU71nayTOC5FMbvw6GMgj5AgSE8Ex+SowS9QbJ
 +7bF1FvI=
X-Gm-Gg: AYBFou2Pc1SEHPjihvXEJmGVNPACOJVSCvvEEZIH7dKwq35JtrqrA9IGQSOFmJVhNjS
 nga2lptzT5EwzO4ogNJ+cg703pMKsZj9wcJUUflwXBcypBtZ9bceRUQcywu/om4nCAQKYJtd4k/
 Sp/dUQa//IoHPMuq+jl9TwtVtaMa5Eett64tE3fXL4u5hummqgKvdciKHEsJ+riqTzYVLkbuGXh
 SKtMHGA4E8FJ/l2CHM9d8I7zyyIW0Me28NkPSLlJssdPm0U+eDgSVgxCC0qoKc5QVptJvyENCkV
 PbZbYXPFnhjUT5MM1IF+CV9imwVMi1gSe6YyDUDORRSQ+U5WKhNj5jM1xECzLDpf8TUTPPXYnMG
 K6f/idOcIGyry0wxf5abfYp0G6n/TWpw2DI5q6zCevjYNS2Z4IDeSCNjRJoQWTxc9PCxOCuw6dr
 2RksOx63+y2CE9p/NYGSUQs1iiqrkekqtvm3dcOK3gMFEuD6ybYndXyk7WRW4oN2tsdx/g+ShMy
 B+luuY=
X-Received: by 2002:a17:902:f685:b0:2ca:e19c:97b with SMTP id
 d9443c01a7336-2dd4bc27c37mr93372755ad.5.1789267371219; 
 Sat, 12 Sep 2026 19:42:51 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.42.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:42:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 65/86] tcg: Generic expansion of tcg_gen_ext16s_*
Date: Sat, 12 Sep 2026 16:38:16 -1000
Message-ID: <20260913023837.741866-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 011d3aa522c..27952e3d36b 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -143,7 +143,6 @@ void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
@@ -185,7 +184,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_ext16s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext16u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 80807eac2b4..cb8436e3b39 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -20,6 +20,7 @@ DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
 DEF2(ext8s, TCGV, TCGV)
 DEF2(ext8u, TCGV, TCGV)
+DEF2(ext16s, TCGV, TCGV)
 DEF4(extract, TCGV, TCGV, unsigned, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 57e5ab9abb4..b07f3a67eed 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -704,6 +704,11 @@ static void gen_ext8u(TCGType type, TCGTemp *dst, TCGTemp *src)
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
@@ -1294,11 +1299,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
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
@@ -1590,11 +1590,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
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


