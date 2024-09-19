Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5068ECDD573
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srGwW-00057p-DG; Thu, 19 Sep 2024 09:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwJ-0004dl-De
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:19 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwF-00011G-U7
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:18 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42cafda818aso7651505e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 06:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726751474; x=1727356274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7Pb5Ur5SlwBbUkJJZB5BuBT+5Cma8+8Ft4qmvnIsqo4=;
 b=Qn66sjtEaM+Mo/vYNgzx7a7jrIffOwEeQMUVt7r9tY1EtSlxTqzh1tt3VSMyc4mTjT
 z30Q80AJf2PRJaaRXizLVZC8qTutyWC9WF3v9dYFL3iOk0iUibpPGSpfxqTuaf7cds/B
 Qu5n+Pj6cvECxiAKBfVqy6l1wNGqC4XW3/av+BBYOSdHqi7oZpwcl7A8INBhx0U7M1l1
 3SwTDe1iZwHzYPyVRAHOPv8y6a1j1txtvRHjGNrMRiAXV/bBAzNd5VNvHK8nY8G5EFoA
 TMkFrCCxnDiGupTGHO3+sT9dN5saJjc9EkMi/5YljvlXYqaoYKmWqc1X/oUSaHt1BRPi
 6gxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726751474; x=1727356274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Pb5Ur5SlwBbUkJJZB5BuBT+5Cma8+8Ft4qmvnIsqo4=;
 b=oJd01q4YQcCBMrZ1dJLflIgCPvFyPxvqJt0c1LAbIwSz89x2i/njHyHWM0opmBy3+u
 JN6ckt/6Ylpb4OAKAzdXSNoC9RJOv94EMHWfRSjuBa+OUIAc8AYeyvKB/I2RStEX/exP
 lXNzwQUK/40N9nmNOC8nbDj9z+ON3S6JDgw08YEjuPq3l5zzodhfrNlxq9vHFym1nWqS
 sdTo60c0rGkrJN194ucO6IgWGSnkW9pX7lby96sWCVT6l/ux8g+Ibkzanx48IaYsOwih
 elBXOLH6u6f3nZj9U6pcsqHhC3fPPNW1/7jvsQs/u5svfsI4xwX7HVgLEUWZZE1jHXwD
 0nRg==
X-Gm-Message-State: AOJu0YyGD3EpG6/FYTMX7Uxh8iZ+94pC3QazmE0nAC+32GWNYBRvWXM4
 XrnKRMiaNR2Dhk9jblK46e6qDFov6+jkAW0b5SEW1w/iiOuIxVJtMqwvb5k2ZpLGeYHQW6ea0iR
 h
X-Google-Smtp-Source: AGHT+IHCeJzHgVgX/WFCenv0p/JLrx3dFLKDow+r6mrAyxstBrAVSzfr0nfNOF6QocNGvptceon81w==
X-Received: by 2002:a05:600c:3504:b0:42c:b1ee:4afb with SMTP id
 5b1f17b1804b1-42cdfac946fmr192095805e9.26.1726751474536; 
 Thu, 19 Sep 2024 06:11:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e754091d3sm21667845e9.10.2024.09.19.06.11.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 06:11:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/38] target/arm: Convert FMOVI (scalar,
 immediate) to decodetree
Date: Thu, 19 Sep 2024 14:10:40 +0100
Message-Id: <20240919131106.3362543-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919131106.3362543-1-peter.maydell@linaro.org>
References: <20240919131106.3362543-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240912024114.1097832-13-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  4 ++
 target/arm/tcg/translate-a64.c | 74 ++++++++++++----------------------
 2 files changed, 30 insertions(+), 48 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index c77f9fc9870..e11e293631b 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1180,3 +1180,7 @@ FMAXV_s         0110 1110 00 11000 01111 10 ..... .....     @rr_q1e2
 
 FMINV_h         0.00 1110 10 11000 01111 10 ..... .....     @qrr_h
 FMINV_s         0110 1110 10 11000 01111 10 ..... .....     @rr_q1e2
+
+# Floating-point Immediate
+
+FMOVI_s         0001 1110 .. 1 imm:8 100 00000 rd:5         esz=%esz_hsd
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index aec2f6a542a..0e290062ef1 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6888,6 +6888,31 @@ TRANS(FMINNMV_s, do_fp_reduction, a, gen_helper_vfp_minnums)
 TRANS(FMAXV_s, do_fp_reduction, a, gen_helper_vfp_maxs)
 TRANS(FMINV_s, do_fp_reduction, a, gen_helper_vfp_mins)
 
+/*
+ * Floating-point Immediate
+ */
+
+static bool trans_FMOVI_s(DisasContext *s, arg_FMOVI_s *a)
+{
+    switch (a->esz) {
+    case MO_32:
+    case MO_64:
+        break;
+    case MO_16:
+        if (!dc_isar_feature(aa64_fp16, s)) {
+            return false;
+        }
+        break;
+    default:
+        return false;
+    }
+    if (fp_access_check(s)) {
+        uint64_t imm = vfp_expand_imm(a->esz, a->imm);
+        write_fp_dreg(s, a->rd, tcg_constant_i64(imm));
+    }
+    return true;
+}
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -8625,53 +8650,6 @@ static void disas_fp_1src(DisasContext *s, uint32_t insn)
     }
 }
 
-/* Floating point immediate
- *   31  30  29 28       24 23  22  21 20        13 12   10 9    5 4    0
- * +---+---+---+-----------+------+---+------------+-------+------+------+
- * | M | 0 | S | 1 1 1 1 0 | type | 1 |    imm8    | 1 0 0 | imm5 |  Rd  |
- * +---+---+---+-----------+------+---+------------+-------+------+------+
- */
-static void disas_fp_imm(DisasContext *s, uint32_t insn)
-{
-    int rd = extract32(insn, 0, 5);
-    int imm5 = extract32(insn, 5, 5);
-    int imm8 = extract32(insn, 13, 8);
-    int type = extract32(insn, 22, 2);
-    int mos = extract32(insn, 29, 3);
-    uint64_t imm;
-    MemOp sz;
-
-    if (mos || imm5) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    switch (type) {
-    case 0:
-        sz = MO_32;
-        break;
-    case 1:
-        sz = MO_64;
-        break;
-    case 3:
-        sz = MO_16;
-        if (dc_isar_feature(aa64_fp16, s)) {
-            break;
-        }
-        /* fallthru */
-    default:
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    imm = vfp_expand_imm(sz, imm8);
-    write_fp_dreg(s, rd, tcg_constant_i64(imm));
-}
-
 /* Handle floating point <=> fixed point conversions. Note that we can
  * also deal with fp <=> integer conversions as a special case (scale == 64)
  * OPTME: consider handling that special case specially or at least skipping
@@ -9091,7 +9069,7 @@ static void disas_data_proc_fp(DisasContext *s, uint32_t insn)
             switch (ctz32(extract32(insn, 12, 4))) {
             case 0: /* [15:12] == xxx1 */
                 /* Floating point immediate */
-                disas_fp_imm(s, insn);
+                unallocated_encoding(s); /* in decodetree */
                 break;
             case 1: /* [15:12] == xx10 */
                 /* Floating point compare */
-- 
2.34.1


