Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38956C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:00:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mHY-0003iI-HT; Tue, 15 Apr 2025 15:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m8x-0005I9-MC
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:40:31 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m7o-0005w3-Hx
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:40:26 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3f8d2f8d890so3210758b6e.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745954; x=1745350754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZWOTLh+v7Qvy+QAWebFNxhuSAQgbLlmVC9g8h/0PkG0=;
 b=Lg+mxUd8Z60ddHLx1j7pDBbSP+Gzwa7HNHW+bdCuWDRFhm79/PoZV2NU0duYxlHc5/
 QCukqCpVJD6W9v6n+LNc/83RUkvP+1540FqmYBhFpwhPSwjFqYOttegMV1i+BAC1izk2
 RCIttJ9NvwvU1IijLE33onvzazfJm2qAZOxec5YkTBrLFQlDEueNvNX1RpoJ2qDLzLb+
 xP2W4Jx6zSFXYv+qpatLD0GYz+Ey6McekQmR8TsHKlVJz5RbKv+5iXATANKe4lIqHJ0L
 IlV+4s6EApqR/ZclIYfPtCBfd8s6UJNMqaSQ4OgxZ4eZg/XM+mUAR40bkZmFj7BkdWP7
 ouXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745954; x=1745350754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZWOTLh+v7Qvy+QAWebFNxhuSAQgbLlmVC9g8h/0PkG0=;
 b=ZbvkMh2xVX9UBXUpJ9S0kZuoEk7MVWQXlQv8p/tsh8FweD/k2aef+AQKKZiThWor4H
 A8zNOujBUM+XABO7lwfwfC2vM/EWlVMBhsIsBg3UCkhB+7q1m9TsIxJ4HNdZf7rSutHi
 rCEpu2it77qnICQoRwR60bUEIel3N3s2W6EmWI/yxBqazOpme3JxVf+/IJfMKOm/n/fi
 ib0O+2doy6H57Gr26L2U4eZBxuSrEagxMLcBd96zjxhAvreiU3CzfG4XnqnjVZzhai+c
 Cvjx+GjNnblJQWdOLAYTyj0XmwnpgXE5cbmIT3A11DpoBI8Hd3+Ykjw1hm/O7YBjL/OZ
 r71g==
X-Gm-Message-State: AOJu0YyYIZEANAYVGIQTefCG/bV85k17rBhgEkLEafrH58cnMtEcvuA8
 AWNk4DUtAQO/PyZa8OSK+N4qwkBmFXiv/umtV/KxxgZYTCPSsPvjQBpoDFkRl2/YEq0scg7fYNY
 +
X-Gm-Gg: ASbGncvgE9z47QxJsZq9yPvCEbLW3Zo0MeAEfpXnqZfS8V4RluNRF4f2kYJ50P+nI+3
 2ZI7b2Bkd0/oHKTPor6zNWu9u+zwCgRIYeNqhrkxeFIaISOcZ2OUsp4hrL0JGSYzpMZ/xInX2pi
 dP+MDIS983lWhhFydh5OfriWCu0rzTu00a6Gk3jSmZPbu0gPw5Xh90In6seSbhWMrnQNMGYbi/U
 gWmFoddHuWV5ADNQarUlxNkextf69/DBqDuGy/Pnzy1j2N8EAJmh+VVm19cR/OxctEpc8ApFGKe
 e41EzG3icse7E6EILxh6Z4HOtVgeTRfjls7Gn2rrlLSliMRgQ+7yVTsfaVzxWlTuKg0BCNc0AOE
 =
X-Google-Smtp-Source: AGHT+IGVc8qviAqrm3nMl71I2LOVJi37TNlknH7ghMM6U1FlKvWygVzQMQnihvnlFt2hIbtMwS4h5g==
X-Received: by 2002:a17:902:daca:b0:21f:6546:9af0 with SMTP id
 d9443c01a7336-22c31ab2c14mr6442195ad.44.1744745575141; 
 Tue, 15 Apr 2025 12:32:55 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7ccbd5esm122062355ad.248.2025.04.15.12.32.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:32:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 118/163] tcg: Use sub carry opcodes to expand sub2
Date: Tue, 15 Apr 2025 12:24:29 -0700
Message-ID: <20250415192515.232910-119-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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
 tcg/tcg-op.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index f17ec658fb..447b0ebacd 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1126,7 +1126,13 @@ void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
 {
-    if (TCG_TARGET_HAS_sub2_i32) {
+    if (tcg_op_supported(INDEX_op_subbi, TCG_TYPE_I32, 0)) {
+        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
+        tcg_gen_op3_i32(INDEX_op_subbo, t0, al, bl);
+        tcg_gen_op3_i32(INDEX_op_subbi, rh, ah, bh);
+        tcg_gen_mov_i32(rl, t0);
+        tcg_temp_free_i32(t0);
+    } else if (TCG_TARGET_HAS_sub2_i32) {
         tcg_gen_op6_i32(INDEX_op_sub2_i32, rl, rh, al, ah, bl, bh);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
@@ -2865,7 +2871,26 @@ void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
 void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
 {
-    if (TCG_TARGET_HAS_sub2_i64) {
+    if (tcg_op_supported(INDEX_op_subbi, TCG_TYPE_REG, 0)) {
+        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
+
+        if (TCG_TARGET_REG_BITS == 32) {
+            tcg_gen_op3_i32(INDEX_op_subbo, TCGV_LOW(t0),
+                            TCGV_LOW(al), TCGV_LOW(bl));
+            tcg_gen_op3_i32(INDEX_op_subbio, TCGV_HIGH(t0),
+                            TCGV_HIGH(al), TCGV_HIGH(bl));
+            tcg_gen_op3_i32(INDEX_op_subbio, TCGV_LOW(rh),
+                            TCGV_LOW(ah), TCGV_LOW(bh));
+            tcg_gen_op3_i32(INDEX_op_subbi, TCGV_HIGH(rh),
+                            TCGV_HIGH(ah), TCGV_HIGH(bh));
+        } else {
+            tcg_gen_op3_i64(INDEX_op_subbo, t0, al, bl);
+            tcg_gen_op3_i64(INDEX_op_subbi, rh, ah, bh);
+        }
+
+        tcg_gen_mov_i64(rl, t0);
+        tcg_temp_free_i64(t0);
+    } else if (TCG_TARGET_HAS_sub2_i64) {
         tcg_gen_op6_i64(INDEX_op_sub2_i64, rl, rh, al, ah, bl, bh);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-- 
2.43.0


