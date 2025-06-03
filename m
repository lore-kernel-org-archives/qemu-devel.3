Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EABC5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 08:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMMk5-0004vY-9e; Tue, 03 Jun 2025 04:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMk2-0004VO-5V
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:11:26 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMjx-0005qg-8v
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:11:25 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so19978025e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 01:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748938279; x=1749543079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jLyCJWwAAJN3vJgUym1RFGXdMsRqGuFjKTLnad9b308=;
 b=k/LSsmkYguol8tAhKuR2EhnDRvpYUMcUJot2em8CjMu7O2HeL5t7PK/LTmczuJEww6
 Kvgr4v8yzta1YrFULbgfNb3MpeOjH05lAXLpNLVIy7Oajz1l4/xkFpuyIpUC22tImcKI
 vXvuuOegECqos3fD6yoe7W6F/L/s3wuXZRmtlDyp/j+QJWx0aOX8f3aBgdeQuLZfVENf
 KdfdcTIifQ1S3LuzWXjdNHP/7fTTODVi5WbUdFgo1wqzYTbvOywHNeBI40oya16D/2xu
 TAph0B4R9zz6pNGR5h5sOAizawD78oTirn9d+ql63G6ByI3A7JCgixl12vJmBD6JiCcw
 k1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748938279; x=1749543079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jLyCJWwAAJN3vJgUym1RFGXdMsRqGuFjKTLnad9b308=;
 b=jxytURGaIxfm+lWrvr6QjHV8cqEv7ylYe8BBsJxC/llnP9R7J6ZTImltrX2AxSVrA3
 Na4GGbSX14jUKfrmpPdmGsAT52RhX0VKhIJ14SXu08Hp14uZQrPQFUnEmrapU0yL2/nv
 yamQKaEWrJta47ghRZRMaoHK7dWW5FAvFTFlQQ6J7CKIC6D0wiFwwI0ppRraxLDINhUf
 F1RxcJwz5f/0Va2VexUGgY57UMbLVQJDQymJqzdeiz4lxCCDNITfRiui9kxg3pR5G7xL
 41sqCWDR4IZLyzOogqsV/ZDAfKypG3I4W0pbwVZTfEEEJfQJ183mK7SgtB/PzydGcFOe
 KQug==
X-Gm-Message-State: AOJu0YxGL3xC6aOseAjjJ06JgwsIKuEgWUiMxpYvqK+NSQj6T77e8bsf
 EQW/XpzFwnYdzhztwKvnk+05sJum7IcQ4pWsSF6EE6OraxTzYKEsxA1IUdbAB6I+kL/MMfrjF5B
 Hd50aJSI=
X-Gm-Gg: ASbGncuAXBo4+OH1WyTx5Gkcqa4ry/1kFd0mzoJU56aYITrDe1VnySjUEhNBnA2pfCs
 ir8yhf5siM1jpOCWuifWVRX34v8Xagobh6Pb4rWn555j1ELhNCwgXvIe+bb4LxZM6v7N5i5/7R0
 EZ1QXyKdGsmxbIluzZAFJXlg1/qm/mppLRRZyWOlJ0LSnIpPdPcvL41R+NuMTflbNjOyfOFEH7A
 u+CDWhKtmygi1TOaWeyGFvBmcPac3xG5RJ9yE+CqcsaXBUdxtAN1p4VaCwdcewQPW0DYj9FQsdH
 M3g8MLKmqtfnSxOaUc8jT0yMF4PeqnPlSu9tLrt4mLPIEP+AZNrMu5ruIN+vNG5vTrE89rlZkiv
 gasCC1KBck1mO
X-Google-Smtp-Source: AGHT+IGF5UJLLdd8uChkx+M0Vmp6eb34haQy3KSxKeNWTAd6cbDntVtd83SZdIuYrDQSycqvnCgM0g==
X-Received: by 2002:a05:600c:3e8f:b0:441:b698:3431 with SMTP id
 5b1f17b1804b1-451221a1bb4mr76609435e9.28.1748938279338; 
 Tue, 03 Jun 2025 01:11:19 -0700 (PDT)
Received: from stoup.lan (host-80-41-64-133.as13285.net. [80.41.64.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009ff7asm17668852f8f.90.2025.06.03.01.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 01:11:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 20/27] tcg/optimize: Build and use o_bits in fold_sextract
Date: Tue,  3 Jun 2025 09:09:01 +0100
Message-ID: <20250603080908.559594-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603080908.559594-1-richard.henderson@linaro.org>
References: <20250603080908.559594-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This was the last use of fold_affected_mask,
now fully replaced by fold_masks_zosa.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index abcbee9111..673849f07a 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1121,22 +1121,6 @@ static bool fold_masks_s(OptContext *ctx, TCGOp *op, uint64_t s_mask)
     return fold_masks_zosa(ctx, op, -1, 0, s_mask, -1);
 }
 
-/*
- * An "affected" mask bit is 0 if and only if the result is identical
- * to the first input.  Thus if the entire mask is 0, the operation
- * is equivalent to a copy.
- */
-static bool fold_affected_mask(OptContext *ctx, TCGOp *op, uint64_t a_mask)
-{
-    if (ctx->type == TCG_TYPE_I32) {
-        a_mask = (uint32_t)a_mask;
-    }
-    if (a_mask == 0) {
-        return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
-    }
-    return false;
-}
-
 /*
  * Convert @op to NOT, if NOT is supported by the host.
  * Return true f the conversion is successful, which will still
@@ -2669,7 +2653,7 @@ static bool fold_setcond2(OptContext *ctx, TCGOp *op)
 
 static bool fold_sextract(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z_mask, s_mask, s_mask_old;
+    uint64_t z_mask, o_mask, s_mask, a_mask;
     TempOptInfo *t1 = arg_info(op->args[1]);
     int pos = op->args[2];
     int len = op->args[3];
@@ -2679,16 +2663,14 @@ static bool fold_sextract(OptContext *ctx, TCGOp *op)
                                 sextract64(ti_const_val(t1), pos, len));
     }
 
-    s_mask_old = t1->s_mask;
-    s_mask = s_mask_old >> pos;
+    s_mask = t1->s_mask >> pos;
     s_mask |= -1ull << (len - 1);
-
-    if (pos == 0 && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
-        return true;
-    }
+    a_mask = pos ? -1 : s_mask & ~t1->s_mask;
 
     z_mask = sextract64(t1->z_mask, pos, len);
-    return fold_masks_zs(ctx, op, z_mask, s_mask);
+    o_mask = sextract64(t1->o_mask, pos, len);
+
+    return fold_masks_zosa(ctx, op, z_mask, o_mask, s_mask, a_mask);
 }
 
 static bool fold_shift(OptContext *ctx, TCGOp *op)
-- 
2.43.0


