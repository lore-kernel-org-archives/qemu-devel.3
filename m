Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DED6C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 06:11:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTxrj-0006cx-OB; Wed, 17 Jul 2024 02:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTxrJ-0005Lt-SV
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:09:49 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTxrF-00035O-Q2
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:09:49 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-78964fd9f2dso4003451a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 23:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721196583; x=1721801383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6XuY01gcGNghIOOf5X8qApquvihmysZWPJ2xnop5Jqo=;
 b=R9KKfeNECve2q7WUzksTcnEHUiEzWuiBg8H4HMIaKQ5PXjdXOfMI9h1zUAXV5LHXQN
 CYZpD5zP/aHy5X7XtlVKCFrirPoV843adgSs4DcaVnoK230czhsfQtAG+btebkUyEOvH
 ymDjg74r93BA2U385wbDFz4h29bj0lYNozZhtOmyHHhTudqiJfYAFu20HUapPiRThPlA
 TVw+ZdgbLtbjnqAD23QfLEz/O7cGp6p2V+FZ8zTsNEyfW7CMx7j7RpoaCdlxyRrSszC8
 KrGHLtBvDJg0eez9HubO1MlJmKs3mes0bq4kuIePHYfF4A0N4lC8QfNnhsNTGBdTjyqH
 PkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721196583; x=1721801383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6XuY01gcGNghIOOf5X8qApquvihmysZWPJ2xnop5Jqo=;
 b=o6/grKUOZcLA8BAM8leaDJj1mJZsXV5ovHzVpItmA5pFY94+od4N0fA3cODZMZ+bmD
 cTYjoK/JUOJy8aRXMlnDxf6n9euGQmGKgpb4MMNvXW+28gQ7gxAKXiL6bue05y+fKzHH
 WO3uUvE07CPOToYg4N4L7Hqn5ETpMMFwSmfW9SzN/0vNnj1UwBk8HWfqWIZ4TLZ4cFjw
 guImXE6D15DFoXpGS0EIejsPrvjaSg4quj68ZROmvnuMrsD0Cc1CuH9lp4fYCh5FB/XV
 KbWRnkB3xm2UbkzhZNBx1GnT/OiJIih0dkIUUFVFi/eONbmrfSgkUzbkdhsWpjGzKc2X
 2yZA==
X-Gm-Message-State: AOJu0YyLNsMJwQMS35Rz/hQGCdCv7jIfgTjgSRG5HxZ8DiKLw1kV2fWd
 /7IP2U28Hn3vd0eam2JRRQS+pgOeVK9HwEtzh/rQzJqdQBEoTlHR36GC28pVE9u/vYXXr8HAtde
 NLlY=
X-Google-Smtp-Source: AGHT+IE70b6i36S3WST98ZZdog9bLcXMAOV3X+X632dUm4VQkKZOi1/iqr1cKU1v0DxyfKY/tx/cAw==
X-Received: by 2002:a05:6a21:458a:b0:1c2:8b78:880 with SMTP id
 adf61e73a8af0-1c3fddc9683mr856533637.41.1721196583135; 
 Tue, 16 Jul 2024 23:09:43 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7ecd603bsm7330404b3a.219.2024.07.16.23.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 23:09:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 13/17] target/arm: Convet handle_vec_simd_shli to decodetree
Date: Wed, 17 Jul 2024 16:08:59 +1000
Message-ID: <20240717060903.205098-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717060903.205098-1-richard.henderson@linaro.org>
References: <20240717060903.205098-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

This includes SHL and SLI.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 40 +++++++++-------------------------
 target/arm/tcg/a64.decode      |  6 +++++
 2 files changed, 16 insertions(+), 30 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 1e482477c5..fd90752dee 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -84,6 +84,13 @@ static int rcount_immhb(DisasContext *s, int x)
     return (16 << size) - x;
 }
 
+/* For Advanced SIMD shift by immediate, left shift count. */
+static int lcount_immhb(DisasContext *s, int x)
+{
+    int size = esz_immh(s, x >> 3);
+    return x - (8 << size);
+}
+
 /*
  * Include the generated decoders.
  */
@@ -6962,6 +6969,8 @@ TRANS(URSHR_v, do_vec_shift_imm, a, gen_gvec_urshr)
 TRANS(SRSRA_v, do_vec_shift_imm, a, gen_gvec_srsra)
 TRANS(URSRA_v, do_vec_shift_imm, a, gen_gvec_ursra)
 TRANS(SRI_v, do_vec_shift_imm, a, gen_gvec_sri)
+TRANS(SHL_v, do_vec_shift_imm, a, tcg_gen_gvec_shli)
+TRANS(SLI_v, do_vec_shift_imm, a, gen_gvec_sli);
 
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
@@ -10427,33 +10436,6 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
     }
 }
 
-/* SHL/SLI - Vector shift left */
-static void handle_vec_simd_shli(DisasContext *s, bool is_q, bool insert,
-                                 int immh, int immb, int opcode, int rn, int rd)
-{
-    int size = 32 - clz32(immh) - 1;
-    int immhb = immh << 3 | immb;
-    int shift = immhb - (8 << size);
-
-    /* Range of size is limited by decode: immh is a non-zero 4 bit field */
-    assert(size >= 0 && size <= 3);
-
-    if (extract32(immh, 3, 1) && !is_q) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    if (insert) {
-        gen_gvec_fn2i(s, is_q, rd, rn, shift, gen_gvec_sli, size);
-    } else {
-        gen_gvec_fn2i(s, is_q, rd, rn, shift, tcg_gen_gvec_shli, size);
-    }
-}
-
 /* USHLL/SHLL - Vector shift left with widening */
 static void handle_vec_simd_wshli(DisasContext *s, bool is_q, bool is_u,
                                  int immh, int immb, int opcode, int rn, int rd)
@@ -10566,9 +10548,6 @@ static void disas_simd_shift_imm(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x0a: /* SHL / SLI */
-        handle_vec_simd_shli(s, is_q, is_u, immh, immb, opcode, rn, rd);
-        break;
     case 0x10: /* SHRN */
     case 0x11: /* RSHRN / SQRSHRUN */
         if (is_u) {
@@ -10609,6 +10588,7 @@ static void disas_simd_shift_imm(DisasContext *s, uint32_t insn)
     case 0x04: /* SRSHR / URSHR (rounding) */
     case 0x06: /* SRSRA / URSRA (accum + rounding) */
     case 0x08: /* SRI */
+    case 0x0a: /* SHL / SLI */
         unallocated_encoding(s);
         return;
     }
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index c525f5fc35..6aa8a18240 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1191,9 +1191,12 @@ FMOVI_s         0001 1110 .. 1 imm:8 100 00000 rd:5         esz=%esz_hsd
 %abcdefgh       16:3 5:5
 %esz_immh       19:4 !function=esz_immh
 %rcount_immhb   16:7 !function=rcount_immhb
+%lcount_immhb   16:7 !function=lcount_immhb
 
 @qrshifti       . q:1 .. ..... .... ... ..... . rn:5 rd:5   \
                 &qrri_e esz=%esz_immh imm=%rcount_immhb
+@qlshifti       . q:1 .. ..... .... ... ..... . rn:5 rd:5   \
+                &qrri_e esz=%esz_immh imm=%lcount_immhb
 
 FMOVI_v_h       0 q:1 00 1111 00000 ... 1111 11 ..... rd:5  %abcdefgh
 
@@ -1212,5 +1215,8 @@ FMOVI_v_h       0 q:1 00 1111 00000 ... 1111 11 ..... rd:5  %abcdefgh
     SRSRA_v     0.00 11110 .... ... 00110 1 ..... .....     @qrshifti
     URSRA_v     0.10 11110 .... ... 00110 1 ..... .....     @qrshifti
     SRI_v       0.10 11110 .... ... 01000 1 ..... .....     @qrshifti
+
+    SHL_v       0.00 11110 .... ... 01010 1 ..... .....     @qlshifti
+    SLI_v       0.10 11110 .... ... 01010 1 ..... .....     @qlshifti
   ]
 }
-- 
2.43.0


