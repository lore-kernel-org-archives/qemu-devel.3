Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21755C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 08:10:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMMiT-0000ob-TN; Tue, 03 Jun 2025 04:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMiR-0000nV-SZ
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:09:47 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMiQ-0005Ta-9C
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:09:47 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a5096158dcso1591349f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 01:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748938185; x=1749542985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tmwJBz7F0rnN0Jca+1BmXr+MUdOgft8U8n0tUdpppT0=;
 b=bumZhcOJU5LFKEa1hSdk1sft33jZuSXZRO14nIa/ttMqJcTPF7ADmkJJ5H5eJBcf9b
 KBHbx94I2Pc0tVl+mMY/2yMOwOfqMNCt/yI2NhhViX25XKQTE6M2nta/3qRbOJ0Xpev5
 8GY2gE9j4VLapWohIAtBBC1WaqF6rHvPZ7Qg1eqc32JKNhp4H2CEzQw97j2ocnSuxWXr
 JjL6r/5jLtX68oK/C1XcnYG88y0YCScpRDzMgDRuQpJeztC//bmC/4+oMmPILmY4k3dn
 u+EHJEm6R0R5S16ee33QLOV5bjWsdRpdWmnq5x9TJjX2IrBzYnvQZkZFR11dteyCkSLX
 Ru7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748938185; x=1749542985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tmwJBz7F0rnN0Jca+1BmXr+MUdOgft8U8n0tUdpppT0=;
 b=e2Hhk15FL72XnPLyk91mOfkXr5wwv9QjMx4yRh5HxeaD/9718Co2czCS3DZdFRqXS+
 EoVN6PxdERVrVKydps/m+koAhwQx0DW7JozefoulODxt/RGdKY/tm3WZ3HKnBiTw3sth
 rEbxxsn/rrlHxl7xWxnaUGQ3eaCe1GT+YNe+8iMdbRAW8mOCzmL71b2k5rOBOrl9P06e
 FZBl6/JHfsKNH5UCa10riPv67hhQzZ2wKtp3GrjEU1tDTVWwTu86vRImnGnbR1IMORg2
 KMorNdxgSeQBrNn6aFqcsl1YHdcYkL35nL1lJDFB1Ii2qgWyNEXnfZPPEIF5J0FZfEi8
 nX/A==
X-Gm-Message-State: AOJu0YyJVPW70Jsoqw0Sl52XO23JsoF44FmOlIJCxUtEZ1GowuDlJNmQ
 cBNbxWx4W4sFaWerKGhE2bkljO2wqNSRE1tC3Bg6mbA+3lF6/iLPgbZktogLxtxujdGHdEppirH
 IU65RENU=
X-Gm-Gg: ASbGncvCo82AMviF0N5Q4tGwBbxkG5JE8jbICKr6+whqCpRW2sIcpJIoksUJnU8KOyk
 dHPm7eTEHGf0+q4tFFD+Dk5Uopj6/0ygiK2wh/2g6BQnTFPoNDXConeKcgW5oC4o/ituFsu2t94
 SuFEmXr2gMJtHcBTVHPO0hr3uAKoymzLdOuINkY1V/GajLf5+SaaUksTgrrbf3IivnH7I4R/duF
 /DOrR9lDnFxSCeoSsask/Zqzcm/luTIe850IUT4OUsjS8vQ8ZYqX/Y6WOTX4IJM2LvgKxN60dhw
 lBlngEp3KXnP1DzETMPPE69yoHPx4wQORFRtXk6JLpvaOG9M657pbjBEWMoO1F0BpLoWj5SprEn
 xmU2fe/LBXnFDJY0CzvqJHIM=
X-Google-Smtp-Source: AGHT+IGXdGZhG3OTg8NTlcYpINTkohVkCXzUvv7flMMP10DUMYgD0oxVD6sgMtpjuRCoreKrsO9Iww==
X-Received: by 2002:a05:6000:2c0f:b0:3a4:e6e7:3acd with SMTP id
 ffacd0b85a97d-3a4fe16a68cmr8965081f8f.18.1748938184722; 
 Tue, 03 Jun 2025 01:09:44 -0700 (PDT)
Received: from stoup.lan (host-80-41-64-133.as13285.net. [80.41.64.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009ff7asm17668852f8f.90.2025.06.03.01.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 01:09:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 03/27] tcg/optimize: Introduce fold_masks_zosa
Date: Tue,  3 Jun 2025 09:08:44 +0100
Message-ID: <20250603080908.559594-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603080908.559594-1-richard.henderson@linaro.org>
References: <20250603080908.559594-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x430.google.com
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

Add a new function with an affected mask.  This will allow
folding to a constant to happen before folding to a copy,
without having to mind the ordering in all users.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index ce3cb4d7bc..49ef039932 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1039,8 +1039,8 @@ static bool fold_const2_commutative(OptContext *ctx, TCGOp *op)
  * If z_mask allows, fold the output to constant zero.
  * The passed s_mask may be augmented by z_mask.
  */
-static bool fold_masks_zos(OptContext *ctx, TCGOp *op, uint64_t z_mask,
-                           uint64_t o_mask, int64_t s_mask)
+static bool fold_masks_zosa(OptContext *ctx, TCGOp *op, uint64_t z_mask,
+                            uint64_t o_mask, int64_t s_mask, uint64_t a_mask)
 {
     const TCGOpDef *def = &tcg_op_defs[op->opc];
     TCGTemp *ts;
@@ -1061,6 +1061,7 @@ static bool fold_masks_zos(OptContext *ctx, TCGOp *op, uint64_t z_mask,
         z_mask = (int32_t)z_mask;
         o_mask = (int32_t)o_mask;
         s_mask |= INT32_MIN;
+        a_mask = (uint32_t)a_mask;
     }
 
     /* Bits that are known 1 and bits that are known 0 must not overlap. */
@@ -1071,6 +1072,11 @@ static bool fold_masks_zos(OptContext *ctx, TCGOp *op, uint64_t z_mask,
         return tcg_opt_gen_movi(ctx, op, op->args[0], o_mask);
     }
 
+    /* If no bits are affected, the operation devolves to a copy. */
+    if (a_mask == 0) {
+        return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
+    }
+
     ts = arg_temp(op->args[0]);
     reset_ts(ctx, ts);
 
@@ -1090,17 +1096,17 @@ static bool fold_masks_zos(OptContext *ctx, TCGOp *op, uint64_t z_mask,
 static bool fold_masks_zs(OptContext *ctx, TCGOp *op,
                           uint64_t z_mask, uint64_t s_mask)
 {
-    return fold_masks_zos(ctx, op, z_mask, 0, s_mask);
+    return fold_masks_zosa(ctx, op, z_mask, 0, s_mask, -1);
 }
 
 static bool fold_masks_z(OptContext *ctx, TCGOp *op, uint64_t z_mask)
 {
-    return fold_masks_zos(ctx, op, z_mask, 0, 0);
+    return fold_masks_zosa(ctx, op, z_mask, 0, 0, -1);
 }
 
 static bool fold_masks_s(OptContext *ctx, TCGOp *op, uint64_t s_mask)
 {
-    return fold_masks_zos(ctx, op, -1, 0, s_mask);
+    return fold_masks_zosa(ctx, op, -1, 0, s_mask, -1);
 }
 
 /*
-- 
2.43.0


