Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6677ECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 16:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snhAI-0002nM-EJ; Mon, 09 Sep 2024 12:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snhAG-0002g7-OJ
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:22:56 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snhAF-0007jS-2h
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:22:56 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7163489149eso3639808a12.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 09:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725898973; x=1726503773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yy21jKPf3BqO69GaSde9b1IniNH9kQ/Ki9NWW9VeFKU=;
 b=yxlJEW43qJCXPL8dK/jE7DZcOv12ItTM/1/lhKb5G+syDccBc7KNxBedXaIlhzPzUq
 OFiNl0x8h6FP6xnJRhTkz2FDFnIuQSGhRGisoJMTU8HlFrgpcMU6GmUbhinksYVa8inl
 aqPAWUO7sVF4b54u9eRAuWSsywz1EqMjTrozqf281kMnsjfeY7qk9VaY/a/TxNg9LB8V
 3W27kGK1meimD4SduGxGOhh+eH22cywUCIIUjgS7UtXw4ZMY6aSQzGEl3Gogu/6A2yfq
 R3DQDcRkue+qWn1/Zzf4NeWdncFRasUd8Yd+ztYbZQdukMzrsrM5rS99KkcGV/YnZG1/
 nACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725898973; x=1726503773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yy21jKPf3BqO69GaSde9b1IniNH9kQ/Ki9NWW9VeFKU=;
 b=W/1YFcALgJyFyjLby38XP/3aKp3LofWII/4XG0PDpccBvlJw/zc5k1c1KcQzLd2KFC
 dyD7La7KIkQ9xWfcqAkAGgk8MdtfNoEV+ToQD+xdtiXyM9G3gjpXA0j6o1bM5JvawETO
 1MhI3RSCuQZzT+TvJc817cq8T3WSF1hxI/DGSmR5Yq18kFv1KfHNF9AaNxOU1nIM/AAT
 VTlE20aMiIDWs4qCwKP4wrabFyDlyi9wqlepZlHS/sfMhyoCW64Te8fc+n8XVuJ+DPXD
 eQr3rVXg6ysf7TxqnwSCtejHvFOMA0DTMTjJZUh8hZ2fmB8bp/AeFoS7WxIfd2PoSVDy
 nW3g==
X-Gm-Message-State: AOJu0Ywur9OK3Gc46EdT9lySjR4YnJQceeIydTEZRNUQTUy+AFS2hyNF
 hm9BOZgT2XLMh/nZHqu/0a+0VmFLpb101ZZ/7KKOcwMnYTeH5P3yghqJA48o1n/HZRVtH/lt6AF
 i
X-Google-Smtp-Source: AGHT+IEq3+8VNgbZVL7kcwxYgZbqSvkEpdffigSVtdWofgZCLsFmPAQDyVY1Thxvmt888/6WNz4fug==
X-Received: by 2002:a17:903:41c6:b0:205:82d5:2368 with SMTP id
 d9443c01a7336-206f05f6136mr129970015ad.49.1725898973469; 
 Mon, 09 Sep 2024 09:22:53 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f35d79sm35753305ad.288.2024.09.09.09.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 09:22:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 12/29] target/arm: Convert FMOVI (scalar,
 immediate) to decodetree
Date: Mon,  9 Sep 2024 09:22:22 -0700
Message-ID: <20240909162240.647173-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909162240.647173-1-richard.henderson@linaro.org>
References: <20240909162240.647173-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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


