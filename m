Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12524E7718D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBA4-0002ox-PF; Tue, 24 Dec 2024 15:05:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9t-0002lj-Ja
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:37 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9s-0002YU-3n
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:37 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-216281bc30fso65715595ad.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070735; x=1735675535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xHQE8MNsLMMkg9lb7/TKEPUriJ232hDu2DMvoc1Ulx4=;
 b=KBpfssXZ+7DL0DZuitWLROndsVlwi8iEIErFJthoTod7MtKVnkBgL2O3tJWR0+dS8w
 LAMHKNynTqqAC5F8HxeXX7GIcH9QEPlvcub8FjvfEiWAOLkOyGfX9MSop/rZrqN0aFid
 guFgbLEm8q9WCEoFpOletrfYB72NV3QM7W5yF5wrpdjxf0rWzs63nr2DWNdKZlT+aNg2
 qjLljy4Bv1YwCuz4TCYUJR21UEBlp9vnvp+DIJhlvbOzyaup6JMHV7/jrYZrebj23QlN
 kyFPDckjTpiBu5CCMGk+/+qNYD8acOcK3hcm7V+Uaz3PqhtDWH6gCqOMZj01hUH7Lq1g
 BsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070735; x=1735675535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xHQE8MNsLMMkg9lb7/TKEPUriJ232hDu2DMvoc1Ulx4=;
 b=OBlhoWheXXltMLprWBx7uCynznSNLXPFb/D5ViR4CMWk/9N5qRKcUH2RSbzWTdCzak
 hMge7g8zq819oFYSoDkj3AiKbnDm1hKAq6fx3hi69eRlM8TX4iXT2SFVEl6OERgGFvFI
 w3oHiuxBFiAycKdoit1cbuVtdgdWUN9Jpc4J3AMsA3rtTNLgNYD70CXSmFypJizL1I7G
 pimohLqN2fhdcvfGXMIUCGegu4Xkhxl0Omyy692myfbdONlDU0Ye7lHvhLkQrQzXoi57
 jkOBAjToRgwor42pVjjVW+ilnIEAuUQCe9/th87chFFV3/fOe36rPcziz+w1Kn83FuYz
 DGfQ==
X-Gm-Message-State: AOJu0YwGXLc+zLgCmFjdDuRnGWyAphdDrxWC7cJvXirL8BgvWm3monu2
 2oC3KNL+HJaUyWt9N8wl7dOl3k5zSnFRFBllpDNyN2xUcoZwLGhbrAjKYzIscTZjT0BWSX+844+
 Y1jc=
X-Gm-Gg: ASbGncs4Nl1kq1tMdC1J44aN7dHgIHefMq9KyWVW6jTLEXmV8cB/LiVvQabjWBNXxtm
 w57Lo3bVKM9R07KJdpF0755W74RpHtPOSGSANe+CIF0ybxrEd1z2F6DLZdprFWD1nZZGrHGq2Rr
 QkFe1NK9P8Sf/2vhVWR0zsUlCIj9pF6C6bGckXlkFtstsyqPJm8Z7o/nyv5jkvRSNkLLjiCQue8
 AniwbUd56i9iBeOK3DOr76tfbdlC5tDYXoyyXmw49vAz8tp27+YGyJsScrR4TM0kbO1o81HylY2
 VL9lelXbKa2B3XHVXDxdsTf5pA==
X-Google-Smtp-Source: AGHT+IGfG7AS/QNH4Nebwr8deUzTfPxn8UJNPvVZZvePxgTHTodBSa5ExNDVhjJbzZtRaDT26tKxqg==
X-Received: by 2002:a05:6a21:6d86:b0:1e1:932e:b348 with SMTP id
 adf61e73a8af0-1e5e080cb76mr30131289637.41.1735070734850; 
 Tue, 24 Dec 2024 12:05:34 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 13/72] tcg/optimize: Use fold_masks_zs in fold_bswap
Date: Tue, 24 Dec 2024 12:04:22 -0800
Message-ID: <20241224200521.310066-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Avoid the use of the OptContext slots.  Find TempOptInfo once.
Always set s_mask along the BSWAP_OS path, since the result is
being explicitly sign-extended.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 2096d705bd..054109d347 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1477,16 +1477,16 @@ static bool fold_brcond2(OptContext *ctx, TCGOp *op)
 static bool fold_bswap(OptContext *ctx, TCGOp *op)
 {
     uint64_t z_mask, s_mask, sign;
+    TempOptInfo *t1 = arg_info(op->args[1]);
 
-    if (arg_is_const(op->args[1])) {
-        uint64_t t = arg_info(op->args[1])->val;
-
-        t = do_constant_folding(op->opc, ctx->type, t, op->args[2]);
-        return tcg_opt_gen_movi(ctx, op, op->args[0], t);
+    if (ti_is_const(t1)) {
+        return tcg_opt_gen_movi(ctx, op, op->args[0],
+                                do_constant_folding(op->opc, ctx->type,
+                                                    ti_const_val(t1),
+                                                    op->args[2]));
     }
 
-    z_mask = arg_info(op->args[1])->z_mask;
-
+    z_mask = t1->z_mask;
     switch (op->opc) {
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap16_i64:
@@ -1514,18 +1514,17 @@ static bool fold_bswap(OptContext *ctx, TCGOp *op)
         /* If the sign bit may be 1, force all the bits above to 1. */
         if (z_mask & sign) {
             z_mask |= sign;
-            s_mask = sign << 1;
         }
+        /* The value and therefore s_mask is explicitly sign-extended. */
+        s_mask = sign;
         break;
     default:
         /* The high bits are undefined: force all bits above the sign to 1. */
         z_mask |= sign << 1;
         break;
     }
-    ctx->z_mask = z_mask;
-    ctx->s_mask = s_mask;
 
-    return fold_masks(ctx, op);
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_call(OptContext *ctx, TCGOp *op)
-- 
2.43.0


