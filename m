Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E530EE6423
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 02:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soZm2-00039n-1b; Wed, 11 Sep 2024 22:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soZlz-0002wI-54
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:41:31 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soZlw-0004Ar-Ob
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:41:30 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-207115e3056so4980215ad.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 19:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726108887; x=1726713687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yy21jKPf3BqO69GaSde9b1IniNH9kQ/Ki9NWW9VeFKU=;
 b=sPQBhYyXGGtBdZrvwuincdjwGKs2tc5ovwAOKGBzPLipNZqhuR5Hh4sUSScKj4xFMR
 y5msrV8s1MCsC1z4BzekSuC4nQtW4j88DKci578c1J8EupNpS8W5X0s4uJCb1YIIZ8Uy
 nomMaCw/Xg0KBkJBR39m/TA+gSsvoKvGMbXsELzuqu5J8KuNwOIlA07kIENCorETc2d9
 DbCiZqjS3wU1Q/3K8djo4ZvMcMBXve9tuaCeDq8mlUXgF5eq5Zur7geCjEimb6iG9r6M
 h3hVhoHPQvSL9Ww/zZTFkoKp0rZLVAkxybeASdbhzE5eA6E2oMnmJaRtANb/dFnJP7q2
 INJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726108887; x=1726713687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yy21jKPf3BqO69GaSde9b1IniNH9kQ/Ki9NWW9VeFKU=;
 b=T2mGDdGNO0t930F68eqiFl6qTmv45s3qzV4LCp506ht+T7ODDY6WE74VLCVbQ02F0G
 eq91V+gNHYPgyZOWJV9n/fwbsPIMdMGCHhxmbHlgfIhPvUuxv7qLvAqBXlJFUBYMXMjh
 RJN7aNqB2UxjjLa7jvup/qhU2ZftBT9FKf+CvdeG4MeeSb4Vn3CyCxYScEIeieoP3HY0
 x5JCDh88ho6IN9KAfsNMvMyBwd0tlflzO0hoXzza54ic9cN2fvlMjj5vg5xOkLldeCWg
 apiLCmZxpHIRnXFECLP7Dpv1SvmJBSvxr1LjmzZlmHHR+dGbpr8pFVFJS2kgMMIXicng
 uZYA==
X-Gm-Message-State: AOJu0Yy0Q0EXsb90XPOQTGtnPgcRaIQXMAYKPhTjJVtjZTDmic6XQe9b
 W2vG/FmlhLriU1/ZDn+RM2qzIAp86ZAWgvGSXMNGfnHC9ueBY+RFOgJZlZdQJYRA996/tdanhNF
 +
X-Google-Smtp-Source: AGHT+IGy+YEuvDQVvv6/kRQL5CdYfSIg4JviMH60DtRgVZ5v7ux0gTjM/if+hK4bI3FxyotqoWCPBw==
X-Received: by 2002:a17:902:f78d:b0:205:968b:31cf with SMTP id
 d9443c01a7336-2076e3f6207mr18840995ad.33.1726108887158; 
 Wed, 11 Sep 2024 19:41:27 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2076afe9c61sm5635915ad.231.2024.09.11.19.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 19:41:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 12/29] target/arm: Convert FMOVI (scalar,
 immediate) to decodetree
Date: Wed, 11 Sep 2024 19:40:57 -0700
Message-ID: <20240912024114.1097832-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240912024114.1097832-1-richard.henderson@linaro.org>
References: <20240912024114.1097832-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 74 ++++++++++++----------------------
 target/arm/tcg/a64.decode      |  4 ++
 2 files changed, 30 insertions(+), 48 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index aec2f6a542..0e290062ef 100644
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
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index c77f9fc987..e11e293631 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1180,3 +1180,7 @@ FMAXV_s         0110 1110 00 11000 01111 10 ..... .....     @rr_q1e2
 
 FMINV_h         0.00 1110 10 11000 01111 10 ..... .....     @qrr_h
 FMINV_s         0110 1110 10 11000 01111 10 ..... .....     @rr_q1e2
+
+# Floating-point Immediate
+
+FMOVI_s         0001 1110 .. 1 imm:8 100 00000 rd:5         esz=%esz_hsd
-- 
2.43.0


