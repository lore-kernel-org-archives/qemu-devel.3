Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA311E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:16:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUPk-0001dX-PL; Thu, 19 Dec 2024 23:15:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUPR-00018Z-Pe
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:14:47 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUPQ-0006qL-99
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:14:41 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-216401de828so13652075ad.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734668079; x=1735272879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bjwaNKNFpgdbaIX3eqenSXZqLGMLSQbd2qnsL5aQqSM=;
 b=OKRbVJM2yGcTAm5YlyqIU8nScOE5OzoRHczxAN8n5sqJCP4z+diQWrkwfPhjVW7/hM
 t7DpQHpd5Nlqwjmk2f0zc+agmuRLRpjouohsNH17YbIN7p17v1cIp+crNpnkUq9DQTjH
 s/+1kM3pYAb2j8jcT9OppjeCWMO/rCeBtmMZxwDf2r7wenKZvdRIFpNiG6r9snz6rU46
 tnlWyZrIaYEIUuRP0or0YwEFgtW1KD6VbhcPBtnX9ehc1+bOYn7cqkfVcyTv3C2XOzZo
 xyjBj2hDBQbWMYG5uNbXUgjgyVxbk4+o4QE/vnRi0913Jzu2CuZaL/oevQjC+hYWvxVn
 7QzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734668079; x=1735272879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bjwaNKNFpgdbaIX3eqenSXZqLGMLSQbd2qnsL5aQqSM=;
 b=ilY7Y59Z3i83IsTSQkBDVASrFi5QdSqvYwvR/LndVuGdoKvXaUh6u1dbh/WqMiBC3V
 KA3YxH5hpJUxZ0BJcjPw3UxpER+AFeiZhMRAZWuUL6zWOWhlcIEK4wY+jbxEBljnY2zE
 C9UC3B3ffDZrXt/sQjJ2NA10qyAcB+lXg7odD1Im0FxGzTxl0yZCcsvt864Hl8YK85IX
 0Jrk19knGXGSuIfylgIkD9bRiBFgoclonZKMCmY4QsTiOMCTx8ZKomyuB5SXoyoX8YRB
 ekk3Fy1fBnchsAxOotpl76aPv8OJwzz/Jib7lZAMybtcP+COojwK1icOEada9ldM5e1p
 IXTQ==
X-Gm-Message-State: AOJu0YxrHB+faeutZ4t5n4on4i/EvP4QRW0abVjYtgyUGkt5cGG9OUSC
 i0Ax5ojfcSW5kAx2h5xsQYDrRp818L/WaLf6tn5KNMFsT1OkrkYMe8rb9VpPo0iZA03H7FtSNYh
 5
X-Gm-Gg: ASbGncvR/fMU/cPWhYu9ZK3gJAMz2BY3312QahXme6/C9OhmgcNzi5IL/2xSe+ZSq8j
 +efP+2y+XPKy7U3Clh5mHu8HM4CekYpGQxpze1V0x67NqSS+X0uABXV8Vfm8GPLSZKZklD2mc+g
 NTdu7kg0oy7gN5yUdBgBjm9+DfTPdDki1OoCwlGVwNiwhTMDCOQbBLdkyGXc2HCISHyrPCe7Laa
 BC4klJitiUQqjDNwp3hB+yAxoWwXCLU9mBwMYAP/v6SvW4c07ixRgywZSVrU/w=
X-Google-Smtp-Source: AGHT+IExVnBX4OzA6CZ1RuM5ltYL9T/9IRn6+SJFtLm9KmloxN483QG4XwszJjIiAOFIQW8t5ISI4g==
X-Received: by 2002:a17:902:d4c4:b0:216:7cbf:951f with SMTP id
 d9443c01a7336-219e6ea195cmr16677335ad.21.1734668078733; 
 Thu, 19 Dec 2024 20:14:38 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-8529e78a55dsm506952a12.80.2024.12.19.20.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:14:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 44/51] tcg/optimize: Use fold_masks_zs in fold_tcg_ld
Date: Thu, 19 Dec 2024 20:10:56 -0800
Message-ID: <20241220041104.53105-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Avoid the use of the OptContext slots.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index bfce2dcf60..56bf3c1aaa 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2675,33 +2675,35 @@ static bool fold_sub2(OptContext *ctx, TCGOp *op)
 
 static bool fold_tcg_ld(OptContext *ctx, TCGOp *op)
 {
+    uint64_t z_mask = -1, s_mask;
+
     /* We can't do any folding with a load, but we can record bits. */
     switch (op->opc) {
     CASE_OP_32_64(ld8s):
-        ctx->s_mask = MAKE_64BIT_MASK(8, 56);
+        s_mask = MAKE_64BIT_MASK(8, 56);
         break;
     CASE_OP_32_64(ld8u):
-        ctx->z_mask = MAKE_64BIT_MASK(0, 8);
-        ctx->s_mask = MAKE_64BIT_MASK(9, 55);
+        z_mask = MAKE_64BIT_MASK(0, 8);
+        s_mask = MAKE_64BIT_MASK(9, 55);
         break;
     CASE_OP_32_64(ld16s):
-        ctx->s_mask = MAKE_64BIT_MASK(16, 48);
+        s_mask = MAKE_64BIT_MASK(16, 48);
         break;
     CASE_OP_32_64(ld16u):
-        ctx->z_mask = MAKE_64BIT_MASK(0, 16);
-        ctx->s_mask = MAKE_64BIT_MASK(17, 47);
+        z_mask = MAKE_64BIT_MASK(0, 16);
+        s_mask = MAKE_64BIT_MASK(17, 47);
         break;
     case INDEX_op_ld32s_i64:
-        ctx->s_mask = MAKE_64BIT_MASK(32, 32);
+        s_mask = MAKE_64BIT_MASK(32, 32);
         break;
     case INDEX_op_ld32u_i64:
-        ctx->z_mask = MAKE_64BIT_MASK(0, 32);
-        ctx->s_mask = MAKE_64BIT_MASK(33, 31);
+        z_mask = MAKE_64BIT_MASK(0, 32);
+        s_mask = MAKE_64BIT_MASK(33, 31);
         break;
     default:
         g_assert_not_reached();
     }
-    return false;
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_tcg_ld_memcopy(OptContext *ctx, TCGOp *op)
-- 
2.43.0


