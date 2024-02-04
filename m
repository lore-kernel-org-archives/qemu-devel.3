Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8EC0C4828F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkF9-0002Gi-QY; Sun, 04 Feb 2024 16:41:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkF7-0002B1-Lb
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:37 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkF5-0003Xk-IQ
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:37 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5ce2aada130so3527642a12.1
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082894; x=1707687694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wnrIxg69BVtmJ/0Uf+G15vykcNV6rAlJagI7YZZGePs=;
 b=svLr56dbTX/i/EFmKdxXiJZjhE+arTdr2rUcBJpRc5FRiFw+/8kJpb85+r1zNj776z
 zigvJlF+tFnfkr32Vo1tWwivqVRSGNKgrCJpqgsZ//yLPUSfSyZKaVfMqi9VLBvFYwOi
 OIy9F0W4I5NBCgqOZSmCoJAIJr2B+HztvCsmikxoQucfidcRPjC9vAaIJpEw+AlLDJQB
 0MU/6nzweq4Y/0KM+Pth9c8pNcP3lsOaM52fHy2LpNLWUlrizxpWIc+CqDTdBScLI18W
 p9l5gdTGgadEjISQAf3BkEZVdMDdUZA8sOJ69JHG7/2Ppwy8ml35b5wVYUqc8UIATpk3
 2Bog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082894; x=1707687694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wnrIxg69BVtmJ/0Uf+G15vykcNV6rAlJagI7YZZGePs=;
 b=baRmqNAYRv0qMhhD8A6/40evcyMO3/JxcO6C4uj7j4XO0LxAyydtjwPQEbQe33VPwh
 LYdOmynLH2U2RjHfWmLoX1d+yiF99cgljQlzPwL591exOIjXoz3waOFJRuPdwO1DGwg9
 8DKdUVOGbkJ4XH09EJPyhCehAcHhTU6K4EpHszxevq+apzfws5xMLIj2h4Oy8kt9Ds3W
 pPUhotXdjWwT7TownASDZ3fnzeWajCkPH6i3ensH5hcJWERSqFy7BaG6z/HqJwFXcPYs
 8M8HkzJ8M97ir1sL76ODTaY6vWy2igvORWnlSpDjQYVEnvlq5PBupY9O6QR49xm6v/Ep
 nR6A==
X-Gm-Message-State: AOJu0Ywl7/lazJPV4sQioGUI4IMNdRjFB0CRDUswlPGO7ovBhuIVkkFg
 nVCeegRdzQDY79/XB8X3ND51X1PVFT9CUC7seIxxyM9Q4Qc85xRcCUFfwpUr1qax5y5OtwlzI/4
 lOIA=
X-Google-Smtp-Source: AGHT+IEy85ga81QP4m62TS558sFDpYe98k2V71fznpX7hUcRUnNix/CMPMB3WQ641xYACy6S4yaiFQ==
X-Received: by 2002:a17:902:d548:b0:1d9:3f27:42ed with SMTP id
 z8-20020a170902d54800b001d93f2742edmr17835271plf.1.1707082894279; 
 Sun, 04 Feb 2024 13:41:34 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.41.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:41:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/39] tcg/aarch64: Massage tcg_out_brcond()
Date: Mon,  5 Feb 2024 07:40:31 +1000
Message-Id: <20240204214052.5639-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204214052.5639-1-richard.henderson@linaro.org>
References: <20240204214052.5639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

In order to ease next commit review, modify tcg_out_brcond()
to switch over TCGCond. No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240119224737.48943-1-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 70df250c04..a19158f4ea 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1416,12 +1416,20 @@ static void tcg_out_brcond(TCGContext *s, TCGType ext, TCGCond c, TCGArg a,
                            TCGArg b, bool b_const, TCGLabel *l)
 {
     intptr_t offset;
-    bool need_cmp;
+    bool need_cmp = true;
 
-    if (b_const && b == 0 && (c == TCG_COND_EQ || c == TCG_COND_NE)) {
-        need_cmp = false;
-    } else {
-        need_cmp = true;
+    switch (c) {
+    case TCG_COND_EQ:
+    case TCG_COND_NE:
+        if (b_const && b == 0) {
+            need_cmp = false;
+        }
+        break;
+    default:
+        break;
+    }
+
+    if (need_cmp) {
         tcg_out_cmp(s, ext, c, a, b, b_const);
     }
 
@@ -1435,10 +1443,17 @@ static void tcg_out_brcond(TCGContext *s, TCGType ext, TCGCond c, TCGArg a,
 
     if (need_cmp) {
         tcg_out_insn(s, 3202, B_C, c, offset);
-    } else if (c == TCG_COND_EQ) {
-        tcg_out_insn(s, 3201, CBZ, ext, a, offset);
     } else {
-        tcg_out_insn(s, 3201, CBNZ, ext, a, offset);
+        switch (c) {
+        case TCG_COND_EQ:
+            tcg_out_insn(s, 3201, CBZ, ext, a, offset);
+            break;
+        case TCG_COND_NE:
+            tcg_out_insn(s, 3201, CBNZ, ext, a, offset);
+            break;
+        default:
+            g_assert_not_reached();
+        }
     }
 }
 
-- 
2.34.1


