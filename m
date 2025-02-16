Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1ECC02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjntP-0002wz-2q; Sun, 16 Feb 2025 18:17:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnt2-0001mg-D2
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:20 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnsz-0005zs-8A
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:19 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-219f8263ae0so65624445ad.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747835; x=1740352635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zLecgdFcx9vj4rrBOS94LABacIUGVfkhSy89AY/MSu4=;
 b=NuHsSgphF0il6rTq256gxINGbhjp4GchgZHsuZAMTbRXAtfI81ND/Kt3+HJ2+vLr7l
 +Kot45MPFZMYGna5f5xWmD2wmMFQm9jHJWmE43tok2BPn+uA/ScyWNulbW/NF+c1hn+a
 6UUBDT20n1Ao/BxbY8T2izVPQ0vmhrwDpQsurnFhQzYHygswE/bKWvKug5oVX3w/CI5E
 GhaTbjxKWvUEtEWfvQkA1LWab/laCIcSacTnTEuAnloXM3hGsa9Li1UtNcMIlWy8kfIE
 y5VVolmRecNYZfcxYt3bk2ePPAX39v3zWLQP2MhAacTOXKqGj57HKBh7x4z2Wn7JKzpU
 vcvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747835; x=1740352635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zLecgdFcx9vj4rrBOS94LABacIUGVfkhSy89AY/MSu4=;
 b=I1X+8vIUY2ZuI4mdPpWDc00j5KzzkRq19q3GgwNB9fDsavUNYDIrJjjw46u6Mhgq/o
 NKCiFm/FQ0N0Qm1tdez6C51XGY1B0m7GXVCkZU1Ieol9iBrG5fgVhCUGLunSWBp/Ix8r
 yANbLTBijCpjyR5AzSLBdYC984yWBB+gzU1A+Hngj6nORXHFdisanx0bsFRQIGgVB/pk
 xoV9zIvCvolEC3KMWLxd/M5PHhp7vQOY9HOypNbB3CuGlsE8V5WYVARvxGoH/o2A1emH
 HidrmCLmwl6nmV/ijMMe6OpfVdFq4ABwi/uaLwirx2Lm90r9VvEmtrJoEzs2g/SGDVlM
 YrYA==
X-Gm-Message-State: AOJu0Yxnct7R6DAYaLwh2VvlKcGUo/1WxXj/cu3D5y56VDzvpVvtLaUD
 t06m4MRcgadFWkDFR1Kr0XINUPFFq+eFJcjKRkN3nVt9MNKke6VSgEMl0wPnC+mN9O4fWPvGjdU
 P
X-Gm-Gg: ASbGncuHQeNDwKFtJNvTaL9yB2HG0qvI9SD4O+9j5GWaqm2tZEedfP7/CheUB86Er74
 eP49cMwx1GvcnTeGPccn5JX6cPf0GFIQu1XXVZBuZbq7ZNZ6pX+/Emc0VXjTeyV1ecW42JiOMv3
 AnWXtt6CAPHElvpEohFpYqXZwWC5bxUwdRnbiiyuiKUh3JshLg2Tl+fdz5x8EX7vVGA+iBaEVL3
 VqtYpFB4JkmQAphlAd3UP0v9lagxdIa16UvTlpNDzICxcq2jeHtck+QagukUL4mymrqtGuw+QQL
 eUILJwEXPlxS8NLKTKyjBarBXeysK6zqAi0JGHLVldEzxFA=
X-Google-Smtp-Source: AGHT+IEmDN97OYDU94gdvb18Oq1+HRzuXUPHam4gtDePn51/gPrcE2bM7p5IEPQl15YYT3ZYAJC3XQ==
X-Received: by 2002:a17:903:1a2d:b0:220:c813:dfd1 with SMTP id
 d9443c01a7336-221040bd77bmr118782605ad.36.1739747835264; 
 Sun, 16 Feb 2025 15:17:15 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2213394d6c8sm5449885ad.181.2025.02.16.15.17.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:17:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 083/162] tcg/ppc: Expand arguments to tcg_out_cmp2
Date: Sun, 16 Feb 2025 15:08:52 -0800
Message-ID: <20250216231012.2808572-84-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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


