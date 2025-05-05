Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B48C3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 20:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC2QC-0006qK-Mb; Mon, 05 May 2025 16:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Q0-0006jv-Ee
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:04 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Py-0000Of-PC
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:04 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2264aefc45dso77383345ad.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 13:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746476881; x=1747081681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FSxWHLphTp6UlArdA8CaklzqquouBrX+hsreO8uW3QM=;
 b=ev1qvXKW8Grbmry0sYSFN6QJG4t18Ve0DsB3t+50cgD2Ro8CoiudcKfRoiJTS6EIzP
 RSWIZRqYSHLmskeyfdYLGOpBBk0yhgXcKS7hsV/pZlavu2ytUtVzBhk+Itm0myVqAVVP
 sWg0Ru4JfMX4dY9ybwKHksAfq9x2O8RlvX8p0w69/Ix4G/JWD3WLyT1OfbX5QbmaWAw+
 CoqEIShHcZrUIk16dZb/VjqlkVan3M3BrD4/5svgsYVqLHKd+1dSj36IeooXuIt5qS+k
 Aun7sNPaiWaRkvxpnWSbLgvyFMAneCB8wqyY22XDjpBiGfEWKOzPikoZDPruBCQOa/xk
 aGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746476881; x=1747081681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FSxWHLphTp6UlArdA8CaklzqquouBrX+hsreO8uW3QM=;
 b=J+rlSGHzf9vVpNDvMF33iLvGv2tiwp9Xxxvfive6eyrV1t2J9s1nRPnWr4leITWZ6n
 uz2oyXbx27oqm5YaYbOHxutvI3M4GBjZPw+e9zZE9ukDknwChUcIAvOStZytqUrBCMAn
 jswJDdq14jqS3KzN1FnG3d+x9+tdfz1+NJauLGzcU+0zY7wVg/OLSQ6wK+zqIpb3FG+u
 i88g6guWKYelkztNSyxt3ObKE3DK3lT5tuKlN9c7uQnMYbCypS4Qc26UyPFkg9v/Ek3S
 VmSeypkhHBhS1sz5vfbmihtc5B2I2G3NcWWMp9qy70ESVWRJCD6f0yRE8dc1SsLWhgvl
 4TmQ==
X-Gm-Message-State: AOJu0YzRoYMUBn0b1LJROf7bKJ2/iJTMFtEjyGMtvoc+fP8FQVoKgwIF
 XpMqBfmCuoVr//E8x3MNzeSzZyOWH/YwNjH8Xnng7fG8c9Crkq4Hq9JPfCYyJojCm8UphDcn83J
 w
X-Gm-Gg: ASbGncuHDS7vMVQu7Vyi9WuA5TrJTACM8H4LvYBX6/WIXoubWB0L+kX5OxhVpbC5Q3q
 g2CTkoOJMV4txWh6fkGGZ1VY5a5LxdxIIk0iK96NIHIZk1AXZahJrXVlyFPSQbX1Cq1IFM3vD0E
 EKXBd69Ka+LXucehd+YxpREtWtyazOB/MaRFwyvtPHqX/iuTk2TYkQawRL8DQSj+MLl8Z1i8sZ5
 2lMVtIpXwb4gILCYlAWhHrV/Ic1dwftf0WUicBraQU3GUribAA3qZ51cttN0xPo9jYQzjXQy2sx
 w7x87OvvWvZ23T/ewG944FWhs1MZasoeN5OplQTK96ZdOYZ3nnRTNr85V91j5P53Wx9gIt4NFWA
 =
X-Google-Smtp-Source: AGHT+IH6RPZXkw9sNdGUgDeGJZygkGAecjoOSkJR/3v19vg0XfylOHw7s/qyM87FagvExxS7fWbx4w==
X-Received: by 2002:a17:903:1a08:b0:223:2aab:4626 with SMTP id
 d9443c01a7336-22e1e8eb4bbmr126321035ad.11.1746476881176; 
 Mon, 05 May 2025 13:28:01 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059021067sm7516485b3a.107.2025.05.05.13.28.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 13:28:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/20] tcg/optimize: Build and use one and affected bits in
 fold_or
Date: Mon,  5 May 2025 13:27:40 -0700
Message-ID: <20250505202751.3510517-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505202751.3510517-1-richard.henderson@linaro.org>
References: <20250505202751.3510517-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 8fbf682e6d..22d302c9bf 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2258,7 +2258,7 @@ static bool fold_not(OptContext *ctx, TCGOp *op)
 
 static bool fold_or(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z_mask, s_mask;
+    uint64_t z_mask, o_mask, s_mask;
     TempOptInfo *t1, *t2;
 
     if (fold_const2_commutative(ctx, op) ||
@@ -2269,9 +2269,17 @@ static bool fold_or(OptContext *ctx, TCGOp *op)
 
     t1 = arg_info(op->args[1]);
     t2 = arg_info(op->args[2]);
+
+    /* Affected bits are those not known one, masked by those known zero. */
+    if (fold_affected_mask(ctx, op, ~t1->o_mask & t2->z_mask)) {
+        return true;
+    }
+
     z_mask = t1->z_mask | t2->z_mask;
+    o_mask = t1->o_mask | t2->o_mask;
     s_mask = t1->s_mask & t2->s_mask;
-    return fold_masks_zs(ctx, op, z_mask, s_mask);
+
+    return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
 }
 
 static bool fold_orc(OptContext *ctx, TCGOp *op)
-- 
2.43.0


