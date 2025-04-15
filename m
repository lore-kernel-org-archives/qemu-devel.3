Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32535C3ABA0
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mB5-0008OB-Ma; Tue, 15 Apr 2025 15:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m2e-0004TN-4q
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:34:03 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m1G-0002gy-Vh
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:33:37 -0400
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-225477548e1so58493545ad.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745548; x=1745350348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zLecgdFcx9vj4rrBOS94LABacIUGVfkhSy89AY/MSu4=;
 b=BDWeADulZ5Ron0eTXOxRQ5rvxpRyLzqKtIu60T+LBoaZ/4cGgO4PnbTpjnTAs37prw
 33hMNx+DMEcV6otTx5MVdsAoF8ghpe+47SFJFnR9+mt628NVlcZPGbiPxuuoeeENwnWu
 Jr49QQoutdgDdfVKkN4xThEasOv8E8E+2Pj2QzZ8/RWAHhLm2BaQtghI7W3LSemGO5Bn
 7rUtJYmJ8hI0LWesR0MJ4dex60+Gak3Xjkowzx0OMF47xXwfrvLjo83xaGGXqpjY+OxF
 oZwOL/7C4CNpVev/oMBPBRKTZ2AGp8Ukt+ydER2etIkgRyXBtqV5e7iU/YNm6d1DS8cX
 ZaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745548; x=1745350348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zLecgdFcx9vj4rrBOS94LABacIUGVfkhSy89AY/MSu4=;
 b=ZfV6UM8PWoTRlEq5meu0u0XUKEw65qsp9CAQWMBaKfjXMSz0n2R0qmnG0y+Bqg22bX
 kM+uqS1KW7ElBgq5qunMDe0ka1NyaO9A7FDdsNClyP1Y5ZdIg6ghOFjLNQUHByCqzCRg
 Sp822EnUFYLOWjIS2JDa4z8QmhuXHrezJOEw8e54Ha2mOcv+bIFdjOM87RaM92HH+Tk6
 7/kRZiZdOZwV0KU1+27IxoK+mjJiqhHOMDrrtjSRopZzKibk09fYK1DZDCBLgWpYkyNo
 eC+9V2wx2j7giVeT8DvnNnRyRLLD3SaVIpuEbX5YXPk8ej933bL92SDgf2653+UnM3mi
 49GA==
X-Gm-Message-State: AOJu0YxUhJPnjrnxfqPY1W92ggrNkOjX6A2jzqnvx+rkwW7NtyMd32kN
 /MQOxzvmDiLBizVdnFHkFabAsVPEO7FddAN1heyKVHFiEaINi+mcemGGHyPFs9wg/y73qvzatg0
 D
X-Gm-Gg: ASbGncsSb4VliGbgkLg7h3F6zg8e/D1CrDA1S6NkkRhx/wPS3dAJ7ANXf+GukKxNHdv
 8tlBBzgI3o8H3e/QE3A+f4lMPFPyhpFGfq/u13RQ4AJAxMa2J6DFbjiKIjPUbMUfseP/cfqD26H
 chloP9cvn9AYTJvgnR/x4/dCgP5ZnNuz9VQyNK+i7ahp9kynyu4SSbFhMcVxhkiVfEj4lTdj++O
 jEIGsYmaxZJnGMrZtc7wR0t8oqRWL0Sszzx9tfYG2ANoc26v6Cz39LG/dQrLQtZOg7fr8mvb45x
 V4Lhv83EbQWxsn18FXeo6yzKhawK6igSTMx7ekuYbIgcfpuwiPGXukW6P99mvgpXFYTgw/uKEXW
 YieplDLMH9Q==
X-Google-Smtp-Source: AGHT+IGlysaT+96+rEIyZ0C1zt/hHFwyyDpbeO6xJZcVwJX3pZceIYCGZWe4HB4XYgGZ4NkbkAe8Mg==
X-Received: by 2002:a17:902:ea06:b0:223:f9a4:3f9c with SMTP id
 d9443c01a7336-22c31a0c7e0mr4192395ad.9.1744745547883; 
 Tue, 15 Apr 2025 12:32:27 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7ccbd5esm122062355ad.248.2025.04.15.12.32.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:32:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 084/163] tcg/ppc: Expand arguments to tcg_out_cmp2
Date: Tue, 15 Apr 2025 12:23:55 -0700
Message-ID: <20250415192515.232910-85-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.214.174;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-f174.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 tcg/ppc/tcg-target.c.inc | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 1782d05290..669c5eae4a 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2206,8 +2206,8 @@ static void tcg_out_cntxz(TCGContext *s, TCGType type, uint32_t opc,
     }
 }
 
-static void tcg_out_cmp2(TCGContext *s, const TCGArg *args,
-                         const int *const_args)
+static void tcg_out_cmp2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
+                         TCGArg bl, bool blconst, TCGArg bh, bool bhconst)
 {
     static const struct { uint8_t bit1, bit2; } bits[] = {
         [TCG_COND_LT ] = { CR_LT, CR_LT },
@@ -2220,18 +2220,9 @@ static void tcg_out_cmp2(TCGContext *s, const TCGArg *args,
         [TCG_COND_GEU] = { CR_GT, CR_LT },
     };
 
-    TCGCond cond = args[4], cond2;
-    TCGArg al, ah, bl, bh;
-    int blconst, bhconst;
+    TCGCond cond2;
     int op, bit1, bit2;
 
-    al = args[0];
-    ah = args[1];
-    bl = args[2];
-    bh = args[3];
-    blconst = const_args[2];
-    bhconst = const_args[3];
-
     switch (cond) {
     case TCG_COND_EQ:
         op = CRAND;
@@ -2286,7 +2277,8 @@ static void tcg_out_cmp2(TCGContext *s, const TCGArg *args,
 static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
                              const int *const_args)
 {
-    tcg_out_cmp2(s, args + 1, const_args + 1);
+    tcg_out_cmp2(s, args[5], args[1], args[2], args[3], const_args[3],
+                 args[4], const_args[4]);
     tcg_out32(s, MFOCRF | RT(TCG_REG_R0) | FXM(0));
     tcg_out_rlw(s, RLWINM, args[0], TCG_REG_R0, CR_EQ + 0*4 + 1, 31, 31);
 }
@@ -2294,7 +2286,8 @@ static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
 static void tcg_out_brcond2(TCGContext *s, const TCGArg *args,
                             const int *const_args)
 {
-    tcg_out_cmp2(s, args, const_args);
+    tcg_out_cmp2(s, args[4], args[0], args[1], args[2], const_args[2],
+                 args[3], const_args[3]);
     tcg_out_bc_lab(s, TCG_COND_EQ, arg_label(args[5]));
 }
 
-- 
2.43.0


