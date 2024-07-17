Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE2AC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 06:12:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTxrP-0005b1-CN; Wed, 17 Jul 2024 02:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTxr5-0004NG-Kk
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:09:35 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTxr3-00033M-SM
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:09:35 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70af4868d3dso4867690b3a.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 23:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721196571; x=1721801371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=puWWSP6upP4R/fjMKe0cqFEKfKot06skzqXFozehvXc=;
 b=dJZH363KBT+F8cjqaHSSt+joanD0gt44JhNVrC8kS2oEkXqYShtRYpAWOZAoSq9ouO
 V90/7mSlypR8Cy5qI/uKawsPGWd5aO0GivYOJjEVK9ocLpxuQ+rGTthnpuAt7z5OFn+5
 WS+jd7haB8Fa8u3TxSFjdVe35E5sVcvG/XLcAllanGKGilgkTDrZpdQu1Ltn1Yet4kUJ
 gys6bv5nkwWnXHqKhyXwt4nhDPErQY35dUWsaLtmF0jW9Di12ndkVYkIOwNZwh4K+TTg
 fzTDgatOxsKUtXLfzOPclEXG+gWnMzKm2XDMnO6m5TRTOGuB0Ozb2+8MCm1/+0a+2q7Z
 IJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721196571; x=1721801371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=puWWSP6upP4R/fjMKe0cqFEKfKot06skzqXFozehvXc=;
 b=cz5J0AKM8J+I3TnXIDVPy5xiUifCZe+YDtckTtV7zIBZPZJW284VCeu4FpDSJ+ZKGJ
 p4knm7zXfVdwLnvAGTtUoiWdgtXCxjDuHHtT4D5lgyetqcXarAfIj0AjWrF1fY3jsH3a
 a5is62zvm0AD8kf96c/7XZ/rZou69PI1uJ+buOtJVZWdtDqhIT8VHkReJEo+b1yqE+1o
 ItSgPuZdjj5TS64P1urR8MMbmcdKciD8o/t25L9w9Id1RS0dVQU5i7ymVlnYZfF3P0kH
 JIetyoNAfEsgqj0Pm9+EtwmpUqwLMJp/lIsCW1YXxoglTehjrc/POVLpkS2JvCuT2Mpi
 g1bQ==
X-Gm-Message-State: AOJu0Yxd1gkgUaDeZhDgL6N6xGuK78OP/Q5NrsdJx5IOQwPrV6TarFGp
 vdQwyP0ybNnutIHqe2uj73dIxrg/mEWJkPBBsZXNizFUKXfHBY51L25aowwg5nNXQXp1PpSxkmi
 cgoo=
X-Google-Smtp-Source: AGHT+IEYuNseG6riZO5WEmp4ZA5C2gDLXBmgCLJZO8MxqmQnWWUDbooRO/SkGpcobllKa4s9LnTUTw==
X-Received: by 2002:a05:6a00:1402:b0:706:6af8:e088 with SMTP id
 d2e1a72fcca58-70ce4f936a8mr783739b3a.3.1721196570998; 
 Tue, 16 Jul 2024 23:09:30 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7ecd603bsm7330404b3a.219.2024.07.16.23.09.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 23:09:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 08/17] target/arm: Convert FMOVI (scalar,
 immediate) to decodetree
Date: Wed, 17 Jul 2024 16:08:54 +1000
Message-ID: <20240717060903.205098-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717060903.205098-1-richard.henderson@linaro.org>
References: <20240717060903.205098-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 target/arm/tcg/translate-a64.c | 74 ++++++++++++----------------------
 target/arm/tcg/a64.decode      |  4 ++
 2 files changed, 30 insertions(+), 48 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 2964279c00..6582816e4e 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6847,6 +6847,31 @@ TRANS(FMINNMV_s, do_fp_reduction, a, gen_helper_vfp_minnums)
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
@@ -8584,53 +8609,6 @@ static void disas_fp_1src(DisasContext *s, uint32_t insn)
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
@@ -9050,7 +9028,7 @@ static void disas_data_proc_fp(DisasContext *s, uint32_t insn)
             switch (ctz32(extract32(insn, 12, 4))) {
             case 0: /* [15:12] == xxx1 */
                 /* Floating point immediate */
-                disas_fp_imm(s, insn);
+                unallocated_encoding(s); /* in decodetree */
                 break;
             case 1: /* [15:12] == xx10 */
                 /* Floating point compare */
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 117269803d..de763d3f12 100644
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


