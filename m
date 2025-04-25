Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9089CC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RCD-0008BI-2V; Fri, 25 Apr 2025 18:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAo-0003bI-9U
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:32 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAl-0001pk-LN
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:29 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7376dd56f60so2134657b3a.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618726; x=1746223526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bOWCeKNlLhAgVYEVI4tqJhLjqQCbsv0AzZbbO08r8rw=;
 b=ARFYhvdgs1x68REt1B+n9Zs5ZYalXDGmfXFEvAAcwNYSIHXv5x5Kip9LpQuROrgAua
 kztA0V3f2Q+ytuM35UxEN8LkN0ITdrHbXFKMlHeI9FaunUyN1g9ReUfUnkn3MT7tisPr
 OFDFMdU2JPaLPCkDOkykdMmTrKw8NT08r7lG/rbi5/GBemmNiR5gDZ2J93i5JyjBnVvP
 DiJDJp99SytlGAvd8cPg7nqVMqx4iSXJwhfhljxYMe3vt9YrJxlvN9N2sg9ZmciVQaWj
 /A2T5NVz9h9pt95hyjQE5vf4JZVBIe6ACD88pqCVhC2wtWLnJ0w4EB+zt5svgvGux1Es
 Q6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618726; x=1746223526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bOWCeKNlLhAgVYEVI4tqJhLjqQCbsv0AzZbbO08r8rw=;
 b=k0TfDjiMIOnA5l7gcLP78vpjN84JlfA1yIt3WfCsszlPLQt3v45wyOYpcnjGUgDWrV
 OKeMOF0U8GvFzgfbLu+Jk2DbaouFkzDbdrf1XLs9H2q3HUEXVSJ6bKQ+xNgRFcSjLLSW
 va0IqQ13U/4VEV47gfls1YumzbS7axMgLJnrJypUIqc3s29ujcj7Lo0C8KW2QzzJwNxA
 QBD9XDDWu/Id29lZQgrH3vj0BDvvD2MPHQEaU6tuBg4/tHCleQo2zGQt8sDYg4wRunQO
 Wn/c91UGkr2hba1BQATHn1cBLsP4I5temGswuthVmWAZQoH/chlWZFVpiBYbsqIc27g0
 3GJQ==
X-Gm-Message-State: AOJu0Yzt0k9c11dsaYwqjG0wW5W/5JCjpO/+FwGe/J50R4+m3sGDwXUE
 vQG10dkh4Lj7rsskkaLVexStES/R/I+AX0UynTWgIVsarEGX+ofOvQ9qgLbQxlf/NtKfJZLYjJZ
 O
X-Gm-Gg: ASbGncsUQ+VgJyMbpclVCRpUqW0aZSfZYlzTMjUOYQs0+/pnhgdDEUjEPLCdiOfu8Bm
 yvK3V8jWv9y6ng14o4EIPGmpOeu0ZaWN1/djftRouzCSCnyvgAw/2lav3NYhlPe2PEaNvAZcO8A
 sglKT2If+JDnKibgFL21oDIJa80ckpECAnN7YsJlvPK15oMt45cg6m/rLFE4bVnJM1fvsbPkq+k
 Ve5MJVHlSU4DUUJHpJKXCyHsi4S+kXbGmCuACBptBAR4rUhz669TZg5dPHqISdw2Qky0WRq6vJI
 1q89miljpDj/DRfkPL3TME7RyKlSBoimV2mkkyIEX/ljDPBYx3WPQ5XcKCfvezOR4JmrhDA8kcc
 =
X-Google-Smtp-Source: AGHT+IFyx0uSmctGyPocRt1NUp94H1j+vwzkAtkpUyfuIANclqYyYqnATwnkHedk1gxMk7vi4WeuBQ==
X-Received: by 2002:a05:6a00:1817:b0:73f:1c49:90f3 with SMTP id
 d2e1a72fcca58-73fd73c806emr4393370b3a.11.1745618726103; 
 Fri, 25 Apr 2025 15:05:26 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3796573b3a.106.2025.04.25.15.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:05:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 122/159] tcg: Use sub carry opcodes to expand sub2
Date: Fri, 25 Apr 2025 14:54:16 -0700
Message-ID: <20250425215454.886111-123-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


