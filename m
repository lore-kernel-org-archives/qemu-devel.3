Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9C0C5B559
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 08:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMMkF-00061Y-4e; Tue, 03 Jun 2025 04:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMkC-0005gJ-1P
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:11:36 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMk8-0005sa-KV
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:11:35 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-451d54214adso19343705e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 01:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748938290; x=1749543090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W7U4qvIdnSjKEmKjhZg9LPBWKFbOmg9j7tuwb6rQ0l4=;
 b=PUud556+N2c+WWpWCyjH705xWj7NoEDpATX4ZNHrd0h0FAIdk6LA2BqSOs/B5AP8gw
 qJBShVK6NWhGkZG1gVL9BPVqG8VOWZiCdIV4fRRMrq6NPuXy+mnxPsH5KQMYrCeI2D1M
 0G8nA5BL1VeYen/UrluMTiGVN15nW5payFF+bxLpjdeWUOJNmaHj8WWfGtC6t7jY0zd1
 c0BO+UAL2I7z/++tBO7LTZT8Y6SaZABHvY541j0t9xDuhFDDK+Je0fH/64juTWlErG9z
 eYAmrWQVlt6EW/03U4gwg2mAvoCHeZOy+erjVN6ErcvdeXdIqFXfsIeiC5p8i37eMzDo
 CUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748938290; x=1749543090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W7U4qvIdnSjKEmKjhZg9LPBWKFbOmg9j7tuwb6rQ0l4=;
 b=WbqoD6Uw61ZAwX4bmMEWBr1bXBjiHnE3c3bpBJE0QhkyP2gkXn93BrJK765ON8XP3N
 dJut4Jc8nY3pVhnlaPaXI68d2a7RFJ5wqXqRDlpB18z3j4LlKGXwl/vpEDX4OTQS+5An
 tfXKmI6zgT7Wz4NUiho0hk/hMgK2oqvHGQGZEEY0PhKUBND2uWYMhigsqwBy0RGG0iOx
 h44vkcY5FVO+tArGx8z5agrY8aQFGLUVeEcJdfHCz1CHS3069CsfaoTPYq0THtOJQb5j
 Ehym6iI2ep8HSORUAkT5RbpDsELxWbPGSdfhgi5B2h4w6ryfTZvh5tuKmBQwgtzJxd0R
 e+1w==
X-Gm-Message-State: AOJu0YwNjWx6Kt+xJBDOjv0jRlvqxOI/Z/Ns2z/hw33OuiuzqoHguz8C
 Wku+LYzUpcLRrcR7qC72NdP8b6Q88FSYtEUjg/DKHow2PUSuK/xjWCqmmg6QkyRnnTet2GK3LkD
 eYCwF/Zk=
X-Gm-Gg: ASbGncua6Ul2Gdievr9yWD2G87OgfvqXg0oMniAbJsO/+vfhAx4LLWrh46Gm504xF8G
 lx0aoKBAXQR+vKEBdhWhI9048e9DJLn8v4aTUxk/WTkEsb1FWf6efRs2SRnam+BX1xHiBBxEY0q
 soJSfVuEbGygpoXD/mtFk9q/MSNV0ZSTZ2mW2OaEusWSPiG4hBJsR/J+U1rsrSZBFpIw9iahw/g
 cG8UpQN48NVdaaqqaya9aZP12OMK/eeewFTkRmtDOx+0UxQ3zDudbKPPF9wokh+0ireQpp83lbk
 ZTm/5IKqe8DMAYN4jQFePFtnsWgMLobnUDl1ftjwAmbep3Koa5+O3if3J2UOlpD8R+vB2ujvpKJ
 OyVFySlOu8LyBrJX3LVxPYSI=
X-Google-Smtp-Source: AGHT+IGKaI5CX+3sCS3/nrqoUMgWiFtHDjg9DUi7Gt4OxBDFweEzvlVFkvHtplid0NCq99LrWMTWIQ==
X-Received: by 2002:a05:600c:4387:b0:451:df39:f7c5 with SMTP id
 5b1f17b1804b1-451df39fbe0mr26618885e9.20.1748938290604; 
 Tue, 03 Jun 2025 01:11:30 -0700 (PDT)
Received: from stoup.lan (host-80-41-64-133.as13285.net. [80.41.64.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009ff7asm17668852f8f.90.2025.06.03.01.11.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 01:11:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 22/27] tcg/optimize: Use fold_and in
 do_constant_folding_cond[12]
Date: Tue,  3 Jun 2025 09:09:03 +0100
Message-ID: <20250603080908.559594-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603080908.559594-1-richard.henderson@linaro.org>
References: <20250603080908.559594-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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

When lowering tst comparisons, completely fold the and
opcode that we generate.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 0b441bc611..aa64f15779 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -784,6 +784,7 @@ static bool swap_commutative2(TCGArg *p1, TCGArg *p2)
  * Return -1 if the condition can't be simplified,
  * and the result of the condition (0 or 1) if it can.
  */
+static bool fold_and(OptContext *ctx, TCGOp *op);
 static int do_constant_folding_cond1(OptContext *ctx, TCGOp *op, TCGArg dest,
                                      TCGArg *p1, TCGArg *p2, TCGArg *pcond)
 {
@@ -834,6 +835,7 @@ static int do_constant_folding_cond1(OptContext *ctx, TCGOp *op, TCGArg dest,
         op2->args[0] = tmp;
         op2->args[1] = *p1;
         op2->args[2] = *p2;
+        fold_and(ctx, op2);
 
         *p1 = tmp;
         *p2 = arg_new_constant(ctx, 0);
@@ -929,9 +931,12 @@ static int do_constant_folding_cond2(OptContext *ctx, TCGOp *op, TCGArg *args)
         op1->args[0] = t1;
         op1->args[1] = al;
         op1->args[2] = bl;
+        fold_and(ctx, op1);
+
         op2->args[0] = t2;
         op2->args[1] = ah;
         op2->args[2] = bh;
+        fold_and(ctx, op1);
 
         args[0] = t1;
         args[1] = t2;
-- 
2.43.0


