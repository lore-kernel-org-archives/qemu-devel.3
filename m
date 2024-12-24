Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA20E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBAF-0002yj-MC; Tue, 24 Dec 2024 15:05:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9t-0002lV-0t
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:37 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9r-0002YL-9K
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:36 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21675fd60feso73525435ad.2
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070734; x=1735675534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pZ0KIsF1BBfIHqPWVMCdpClBho97FcY+wzgcx7bn3Cs=;
 b=whvym1ejpDLxcBCimTNssEFz4EZQR1b1FBqicwIehHEDNOM78yqxhJFoqfUmPMMrNR
 ZJ5TEceHYkCxy2bB2MwgEV2zJAwLo6rNp+VMIqFis77Nh78720ASQHcDaSTifaR8BhZy
 diz0NOvvnEXB3wu6J6unSUVs0r6jO5XiAq987T+OOJhNK6ULjov1Bo4PrjGOxS5zYqE/
 2psBWewT6eztV03FaDP41w3eHAq/iq2h1L7/+UeL9cetcRhNxVpyjHqGHFOzywGmZi/M
 dJIn5vb9txUT0e5x36w+aO/KOJfH25uFxT51Z7sc5nzzJ1T08sMWApY1IX2L7jL+D/Dj
 NYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070734; x=1735675534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pZ0KIsF1BBfIHqPWVMCdpClBho97FcY+wzgcx7bn3Cs=;
 b=Oikatbx7Eob7MXCiUGIHuvkdBsVOJP+Ccsp9FZ6pT4un+xfTyhdryMh/jj187bZLRD
 FOl5KBuNxl+WLd/9leGqQHYOn7R485higaDDgUFi+7yrSPY962b7UpBvwiFtvAeKJSRF
 IKk4WDXOJyhxm1NH1VflRyND0iekUjyaFQ1lyRAUycXDUxEiZ2XJXe+apddddNwhGZjD
 /yU217GjdZYJtWVzcc0oFpGvpaLfzVmPADY1M9Vu30gJqhwoZRmeuFiBoRvNDgsQCvrI
 rbFWuFH769fTUfSYrKOZ0otGomvHJbbXYl2DLbTvqNx498RP1SK5smbt2qAKKrdxHttf
 QMPA==
X-Gm-Message-State: AOJu0Yy+xMjmbpIxHys91hKP2ZWpPNWS2Zvq/2ok2gwZVwPA8il/UlD9
 wPb7A1eo/6HubgcEC7vPLEyjqo2qEW/sqCPyY8/AqUaNdx4B9gHrnFPWf/p8xDtFiqFIE2Qr9C4
 Bl4Y=
X-Gm-Gg: ASbGncsN8AdKACo5QuqXsP/sLjKo8HG421Fx3pKz06x+wqo39MSVzXkB1sGi6YKY2zi
 0ovisD3nSFMajEPZv28dufmn3ws3roPEKOfsxiNkXvckAx4pZhbQlnG22Xt75yB1UiE/60Wj9Pw
 kyUVyQF3K21/57kl47FWnuIX5fj7WfuCj695FrL7OaDFCUomqtjmvwnm5Q18b517T3FOcTlZxji
 3frNe5JPqVWtX/29ahXDVyoWUrR0GUzd1JdxPb/8wvyFhX0NQ33jXD2Vr3vP9ouh8m37Geqayg7
 nthc8Y8yoEjh9/F05Mv23tZhfg==
X-Google-Smtp-Source: AGHT+IGIWgRL/q+1g+3i/m8GQzdib+BNDdR7mA6ZObrWwJsi2Qg3Ibe7bFpEO3CbfHoo9+tDSJRsYg==
X-Received: by 2002:a05:6a21:1014:b0:1e3:e836:8aea with SMTP id
 adf61e73a8af0-1e5e046f453mr32506448637.14.1735070733786; 
 Tue, 24 Dec 2024 12:05:33 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 12/72] tcg/optimize: Use fold_masks_zs in fold_andc
Date: Tue, 24 Dec 2024 12:04:21 -0800
Message-ID: <20241224200521.310066-13-richard.henderson@linaro.org>
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
Avoid double inversion of the value of second const operand.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 4a5b52916a..2096d705bd 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1330,7 +1330,8 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
 
 static bool fold_andc(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z1;
+    uint64_t z_mask, s_mask;
+    TempOptInfo *t1, *t2;
 
     if (fold_const2(ctx, op) ||
         fold_xx_to_i(ctx, op, 0) ||
@@ -1339,24 +1340,24 @@ static bool fold_andc(OptContext *ctx, TCGOp *op)
         return true;
     }
 
-    z1 = arg_info(op->args[1])->z_mask;
+    t1 = arg_info(op->args[1]);
+    t2 = arg_info(op->args[2]);
+    z_mask = t1->z_mask;
 
     /*
      * Known-zeros does not imply known-ones.  Therefore unless
      * arg2 is constant, we can't infer anything from it.
      */
-    if (arg_is_const(op->args[2])) {
-        uint64_t z2 = ~arg_info(op->args[2])->z_mask;
-        if (fold_affected_mask(ctx, op, z1 & ~z2)) {
+    if (ti_is_const(t2)) {
+        uint64_t v2 = ti_const_val(t2);
+        if (fold_affected_mask(ctx, op, z_mask & v2)) {
             return true;
         }
-        z1 &= z2;
+        z_mask &= ~v2;
     }
-    ctx->z_mask = z1;
 
-    ctx->s_mask = arg_info(op->args[1])->s_mask
-                & arg_info(op->args[2])->s_mask;
-    return fold_masks(ctx, op);
+    s_mask = t1->s_mask & t2->s_mask;
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_brcond(OptContext *ctx, TCGOp *op)
-- 
2.43.0


