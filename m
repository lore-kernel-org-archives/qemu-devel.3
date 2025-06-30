Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7DCC8302B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGSF-0000jL-7m; Mon, 30 Jun 2025 11:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRi-0000Sl-Tz
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:31 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRa-0008Dc-If
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:26 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2e95ab2704fso1521509fac.3
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751297353; x=1751902153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4H1axxFmY1zlJ3Z/D9SyseYLfrfcCGZjjnsW9t5XeR0=;
 b=Q/qeM8x7mJzp8jpKtx6NTFnQaA6a51QlFbcSjfpTfEKnGi7fMqxrVHlbnTbr4Pa1/J
 hB90XeoLHG7Qmw14QApusuqi+lsncgtLNQAcN02n1npLRgyIpOOfxQ9BK2E7URL2r5Ul
 nB9RNXgR/JKzfD8LOHiflgHjvzBh21RJYpok97S5VY/dEQvtC0zAF6MFJB8/Wl8Kkzul
 7w4HEOyYoSvYfzNVgzfjN8CjF8Q0+h+0vzrvGSM2gTkiYiWayA7Z7L1Cx/UddNu/cHxC
 fmVA2/X0oqdViIP/ZWdhhhYrESnmt6APq+4GYb93MPxql4/L86TMwJpREUv0YnpiQ2SO
 aN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297353; x=1751902153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4H1axxFmY1zlJ3Z/D9SyseYLfrfcCGZjjnsW9t5XeR0=;
 b=VDZCqCgl5o2ATI02fJUpszdixMUZCSin97lddYq6tZBBsxZVeTkFXdQjsf4UlnFzDs
 LZtVTqTEH4iiQj3aeRn6muvn7WW1/6qHDjAUf1/4pwWIM7XwBbi/HN86870Dz57whtHj
 U6M6Q9lEXYlICpoEpdp5QvVyGl3ShwbZb7x52hq7NMHpZayGeBm3B+fsAJZTWuCyOSEu
 x23bCLmfXewySFK/ygboU/S1jCIeJt8Kiv63Kggs4YTDyQkNbN2YFkR3TJar6OgY1GS8
 fG7E/N7rwYf4sRwGkIw0GZZRWUUR0S6uJstMqCdGdxZ6P8cMymxAaYASaGNfU/zv+whw
 vVEQ==
X-Gm-Message-State: AOJu0Yx+TEvDZk98gP6DRUHdHPSNgG8XVOKd8jgCqIYWVaJ5QK0u8n5G
 55hW4xXSSSEyMcVbiRBALEx5cAyIvQKkYctHWtRc+P9fplTcWN5QPFASR902HaIDenLr16ojjeI
 iTn/e
X-Gm-Gg: ASbGncsvw3qQMlhkIIMb9GutFA9zlSwbP+UeTSkTEtGOYGZeF8I2X4kbD/q/kpYC4yE
 bWtf0oKomiUFWYb+lLJHG68v0aCObKKJ02yE67WwmMnqwzojAUASCq/5NfHZWSehUFd8RwoBHj9
 qVorEBVSAJ2o54vWrs+D8NrL4Ef4ny75SS/E9zWz1SqbXsz0NeJyuRZBhPO0/wpvlJDplW4FeYR
 XGPgrtVpmhQDA8fB500fl3OxEiX+1yaK0094B/mYj3ydaNOhbvldY0R/PPg4YssXqUCxn6PSfqu
 DT2f3avwCeZe4Z85Cp4Zk/T6vdYozqDCNIycpQSIqNqYS223AefX0G6ZDoofEkJ90EsW/g==
X-Google-Smtp-Source: AGHT+IFM3dsBfs9g8qYzS5Gapq6L3lMwKpkrRxAvthY67K1fn1kL6Wk3CerUrTy5i8w2Jsf6UDCFyA==
X-Received: by 2002:a05:6871:3385:b0:2b8:78c0:2592 with SMTP id
 586e51a60fabf-2efed7ce659mr8356105fac.23.1751297353608; 
 Mon, 30 Jun 2025 08:29:13 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb00c48asm1712478a34.27.2025.06.30.08.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:29:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 15/29] tcg/optimize: Build and use o_bits in fold_extract
Date: Mon, 30 Jun 2025 09:28:41 -0600
Message-ID: <20250630152855.148018-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630152855.148018-1-richard.henderson@linaro.org>
References: <20250630152855.148018-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 043568a10d..f5fc0cfff9 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1963,7 +1963,7 @@ static bool fold_eqv(OptContext *ctx, TCGOp *op)
 
 static bool fold_extract(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z_mask_old, z_mask;
+    uint64_t z_mask, o_mask, a_mask;
     TempOptInfo *t1 = arg_info(op->args[1]);
     int pos = op->args[2];
     int len = op->args[3];
@@ -1973,13 +1973,11 @@ static bool fold_extract(OptContext *ctx, TCGOp *op)
                                 extract64(ti_const_val(t1), pos, len));
     }
 
-    z_mask_old = t1->z_mask;
-    z_mask = extract64(z_mask_old, pos, len);
-    if (pos == 0 && fold_affected_mask(ctx, op, z_mask_old ^ z_mask)) {
-        return true;
-    }
+    z_mask = extract64(t1->z_mask, pos, len);
+    o_mask = extract64(t1->o_mask, pos, len);
+    a_mask = pos ? -1 : t1->z_mask ^ z_mask;
 
-    return fold_masks_z(ctx, op, z_mask);
+    return fold_masks_zosa(ctx, op, z_mask, o_mask, 0, a_mask);
 }
 
 static bool fold_extract2(OptContext *ctx, TCGOp *op)
-- 
2.43.0


