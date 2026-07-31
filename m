Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A9AAC55165
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 00:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpakc-0001nF-TN; Thu, 30 Jul 2026 20:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpakZ-0001me-85
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 20:05:20 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpakW-0001QM-3y
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 20:05:18 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-ca913a601fbso241868a12.3
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 17:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785456314; x=1786061114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0ns65FLTaqMAOS6M+ta0Sf/0BSXRfHxqkcsDeE7GiUs=;
 b=XUXa/gLjGsgjXHi7v/KlkJmtvbR0bmI72N5vuU6uSP8mkbYoOTBJI2alFDJrRwPeUR
 reDwJkteUTs2EOFAkUmqr50sTDqjAWBfWtWnSnRDY5lnxm/AAxbCjcMSmyMmE2qBVTbZ
 aFSf6SMGiS09Gk2AS22HtOI2siifsZ/jFTOTYplpWRh7BAZwP3hlCqzNxOzDgx2dNCYD
 oG2nXGljzmnU5B9nrA6n3+t49/mzN+lAa1reLsvg2KjqWD5YhvIQm4j1sRHtzngDawcZ
 /tnH4aVZK9s3Z4aMmp43iHVtrTEfD1Xfy/487p27248H4dsVCyuw9tR9XX1Hx7z1WLDP
 Q2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785456314; x=1786061114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0ns65FLTaqMAOS6M+ta0Sf/0BSXRfHxqkcsDeE7GiUs=;
 b=FS9mI++3pYRf9Yetl6EVmH/JGs+15KWlaXs6Tc1VIikm3mKSnzKjPhLurjmVZfvTGW
 R94tccGzcoaH9HGD4y6/u0238dbwJ0k9t8YIiQrTDmJ/y186idbRN5pZvQFfOOgX+09C
 Yt1GkkTfZL9ga38BOG0/CT6dXEEKRz04NYrYPfww8geCmfMBbo9r4d4EVj4UTD83Msvq
 WeEtNCusQqIWCdvsmWr+i+LqCtkjj2Y97uPyKHC2IF/ZYADm/5c565GHen+7KY3obDfZ
 WnorxJOtLwZxpN7o8mn8MFoYEFcP1gdRoE325wwqMyNj+lbMq1JFjHMIsJMV5tg2XVnF
 9ojQ==
X-Gm-Message-State: AOJu0YwhRLnVYFh/PaqJk/WI8ooxMfHp+2C03r9Rxq+hqLO93m2EkK9f
 vYbxIpkm7M7+r7MAULoVd0lFkpkB+pODZ0vgTNDsRsXBZUjDrHhRiq3mo62Wo9TTnHoHly9Dg2A
 stwuj
X-Gm-Gg: AR+sD13aaLDI983Q48x3Be3dkDrPZLtr7XsHtbNdtbZdhjC4+HpjklW4dojx8E/YVPG
 vAZ9UFXFvLly96RofKlzTTH9/FRSza+zDstHcSnf27Saq4e8SGpRpoEl+sc0ysLm+fTzaj5ULq/
 y38zWvCm1iIRwU24DV9ShqK664JwcYeAn4TBeiObcirLyvdfqAjZiQuL9EwBwbp8PX6Jje5UGg7
 S56w6svl3GJBnAdz6dtM8dGff9tQpB35NnJyy2xiE9jWV4WHQCQX32VO27n8YG78IX7SldGjtRj
 T1GT0YOPDAhM59/nKcuq/Ddu6/j+358hfZOAS0qBCss+S4MkGUjJfDhN7Peo0HZR4XGvRBVO09n
 TQGg9NVgxwSAh9Qzw46397+ChavLvENrDPB9ZTW3jUmaGpQNJ1DvI8NfqqepBy8daUcDuez9Q2t
 EV53jkl3MEQoz6pLL2YgngovUNH/2Lavm5TL+5w+S1FHLUnsXmk2/YFfVrZ5fPJB5wb0EMBseVp
 OeEfeiSEK/n3IleeIHS
X-Received: by 2002:a05:6a20:430b:b0:3bf:aab1:cc8b with SMTP id
 adf61e73a8af0-3c9008ccb6bmr3723856637.46.1785456314400; 
 Thu, 30 Jul 2026 17:05:14 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbdb7a999ddsm2656460a12.4.2026.07.30.17.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 17:05:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, qemu-arm@nongnu.org, git@xen0n.name, 17746591750@163.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, philmd@mailo.com
Subject: [PATCH 11/11] tcg/loongarch64: Implement revbit{32,64}
Date: Thu, 30 Jul 2026 17:05:03 -0700
Message-ID: <20260731000503.170446-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731000503.170446-1-richard.henderson@linaro.org>
References: <20260731000503.170446-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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
 tcg/loongarch64/tcg-target.c.inc | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index a5cd3c3b1e..9072a447ed 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1866,12 +1866,30 @@ static const TCGOutOpUnary outop_bswap64 = {
     .out_rr = tgen_bswap64,
 };
 
+static void tgen_revbit32(TCGContext *s, TCGType type,
+                          TCGReg a0, TCGReg a1, unsigned flags)
+{
+    tcg_out_opc_revbit_w(s, a0, a1);
+
+    /* All 32-bit values are computed sign-extended in the register.  */
+    if (type == TCG_TYPE_I64 && (flags & TCG_BSWAP_OZ)) {
+        tcg_out_ext32u(s, a0, a0);
+    }
+}
+
 static const TCGOutOpBswap outop_revbit32 = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_revbit32,
 };
 
+static void tgen_revbit64(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tcg_out_opc_revbit_d(s, a0, a1);
+}
+
 static const TCGOutOpUnary outop_revbit64 = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_revbit64,
 };
 
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
-- 
2.43.0


