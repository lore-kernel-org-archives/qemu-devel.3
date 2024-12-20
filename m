Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4042EE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:15:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUMP-0008Sq-Rg; Thu, 19 Dec 2024 23:11:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUM9-0008Nv-A6
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:18 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUM7-0006JD-Lf
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:17 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7fc88476a02so1174240a12.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667874; x=1735272674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0rhYtVOEwyu15py/YrAnbR2XfkR4Vy3WymLT2+T9y40=;
 b=jqNujmXzXkhAasEjuhyN5Q1ZTethUrM47fN5QApZHrsuFSAXszPswy1P8T535H7T5T
 KrcY7vjSpp1r/h+zhnkqWE8ZNa4lP1AurAebkBY/PZt02TRil/QbroD3LFFwOZm0NO08
 R6JFIbRrRPFxBntootqifybz+UP0ZOnQcKyA2XIEXGhLxdbJXK31DZR5tXE+phBiDHSL
 cF3ren9m5jI273myJGSXBWz2wOJoAempYHlN+EIyffqrWW+9YA8psgspv6Y6/DqcwrBm
 0JBb7qdA4bKEZ3M8vWKlQRtlGaA9pvWg5k5sptjNUVKGUWBAHM+EkZmFfhEqQ5uGvoJ1
 CHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667874; x=1735272674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0rhYtVOEwyu15py/YrAnbR2XfkR4Vy3WymLT2+T9y40=;
 b=Ytw4G1wmiMJHY197CaUrx95muEJkVWafjj6c3bOeOh6ctL+Zw446bnoiiJ3lQSMeHW
 oML7wlsZgHd1QVKr3cxRPoSQ3/2TEumrfjlxY5CEX8Gxq9Dc8QTYO96/ShEx2JFLHkzh
 0TECqUkttE1rfNaJV75AOpwm2Hn9alddOPW0h3u1ZJq3rGYy/wxhAYZ3Q3PJB+Vcp/sI
 rGVrBA0LYCuRN7dusA1IP3veoPwphZuGnStBbHz+3wn1gsLR19ZmR+s8hUUlrF+H36sD
 hXWRG/bA3Q+2Nf/PcoNlDqPbeqHTvCLwStxfkr9isWMvRXXvndh3CgARowvaXBBZxdDb
 6W7w==
X-Gm-Message-State: AOJu0Yy6XGrlXyjp/fCgIYfX2oFPTi6XaBOjLjmq6+tpa5qz7Uoy60Mq
 Tmu0E+whY1NO+vrOtcQRaQ8e4xQV19vzbX2bDGVhUEf5AkbRVNVCvL5TyqosC7j9YEBSY0CGkWd
 /
X-Gm-Gg: ASbGnctIp8dFcGJANFk94zsDP8SEUSrzaMK24+w3M2SIkpQSvJJzzDRTOj2cNG5HUAr
 fgYeQX4kF5iK1YMZnFtn8yvHh/2bgjq6odElk3qqzva2R/IkExShAte8wRvKtWbFtPlmZJarvyt
 aGN3gNvquXXh/6GgsXeBi4Y7oimKZRH0anz107M7jGFgUeDGTk5JcWfXUbhxVTHMcBvh+uW+huc
 wopvXSbhgJugkrOqO2cHgWZAdx5iK8X0bH3EyIEzRK4OLsUa4s5p1WKVrHNsqY=
X-Google-Smtp-Source: AGHT+IH1V9tct6NOShDI924xOoqgSAQWJhGFToq3EpOZSGm3yx7W/Ltk3357o7iB7l6SB6lcmRQrog==
X-Received: by 2002:a17:90a:cf97:b0:2ef:1134:e350 with SMTP id
 98e67ed59e1d1-2f452f02689mr2383973a91.35.1734667874433; 
 Thu, 19 Dec 2024 20:11:14 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/51] tcg/optimize: Compute sign mask in fold_deposit
Date: Thu, 19 Dec 2024 20:10:25 -0800
Message-ID: <20241220041104.53105-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

The input which overlaps the sign bit of the output can
have its input s_mask propagated to the output s_mask.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index de32cc0323..e4f68241ce 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1646,8 +1646,9 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
     TempOptInfo *t2 = arg_info(op->args[2]);
     int ofs = op->args[3];
     int len = op->args[4];
+    int width;
     TCGOpcode and_opc;
-    uint64_t z_mask;
+    uint64_t z_mask, s_mask;
 
     if (t1->is_const && t2->is_const) {
         return tcg_opt_gen_movi(ctx, op, op->args[0],
@@ -1657,9 +1658,11 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
     switch (ctx->type) {
     case TCG_TYPE_I32:
         and_opc = INDEX_op_and_i32;
+        width = 32;
         break;
     case TCG_TYPE_I64:
         and_opc = INDEX_op_and_i64;
+        width = 64;
         break;
     default:
         g_assert_not_reached();
@@ -1684,8 +1687,15 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
         return fold_and(ctx, op);
     }
 
+    /* The s_mask from the top portion of the deposit is still valid. */
+    if (ofs + len == width) {
+        s_mask = t2->s_mask << ofs;
+    } else {
+        s_mask = t1->s_mask & ~MAKE_64BIT_MASK(0, ofs + len);
+    }
+
     z_mask = deposit64(t1->z_mask, ofs, len, t2->z_mask);
-    return fold_masks_z(ctx, op, z_mask);
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_divide(OptContext *ctx, TCGOp *op)
-- 
2.43.0


