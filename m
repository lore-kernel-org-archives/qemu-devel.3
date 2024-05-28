Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834C8C27C50
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 14:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBxUm-0001Zo-Ab; Tue, 28 May 2024 10:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUl-0001ZV-9P
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:07 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUi-000737-Nh
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:06 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-354df3ee1a9so762448f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 07:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905282; x=1717510082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dZiOjDpaTDBfQcZ9XO1B8DxujP/epjSMsXMLUfhPG4s=;
 b=EGqjzigM3hczXyA1ep8QwUHRljJ94Ftf7Sn1vjI/A7ts5km95xdXUFiNdpaBb2+ETn
 xa8qqjUbr6EqJR54dMaKRU7SXRFH0FVU9FGhPpjfgFB34/XJjxHpPHFfG4k5P8jIVGea
 kH/qZaEuHAaLKLV6auKbMlqTyES6ML+rIhP82r4V7lWnZrWvD/zpPQZrJZElBQblCpDH
 2IFmYno36/rohVyG5JlZE/X0qrj4Io7gLumkeY+IpRYvBj9c320+5UZFNJ4jx7/Ykg2K
 otr4QFQ2ir/FRvzok7gPUxmlnSQISXGQxAsX+ZaIF+6QhESKZnxUdRaLbXAdBzExIgFD
 3P3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905282; x=1717510082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dZiOjDpaTDBfQcZ9XO1B8DxujP/epjSMsXMLUfhPG4s=;
 b=r7YQSdZrDPUrnpr5a2ChlYFnPumcTLQqjxvS0mLukM3fgb+UIsarsYG3J5hiDWvp3X
 HX9AMJHFyWqFYH2YTgISMuNqvoUtH/dtvkrFdiH9l1hFA2f+iCsKKoK71WEhIuBIKEx5
 0rPVM0/DsifOIjUK+IJ6xnmLCL86EAIiBQjVu+PYt25lWGh+fmYZtuv0ppkgji5fg+rf
 Daqvw8nbJsZ64kpcRQWr3OqSzXCUDTNJZNIhjmPSmuF5gEa7rEDQyrIY2ABT/oTcZPno
 P0gNSdn7vwwTIl7eTAcTLFAcUQRdh+GqWtst6T7jI7tzVfdmLKpSOa7COjzbxmy3wHfg
 PNMQ==
X-Gm-Message-State: AOJu0Yy/oEH3QvvW3t0AlpCLDK5G9uEGUMwElfqzwOuiaC29pIBiEbeO
 BBw1+rxSEo2480fldVzSpoDD8d/FnEleJBrQ+FKSzUqvKD3NfbeUQFTksKedO7hi/lYHzxhJ4q3
 i
X-Google-Smtp-Source: AGHT+IEs9vA8Zghze8cuzKzJQ2/KDtNXjSSIUM/+8kAqhZEzUZQSbf+0J62m4HazcytImSBLwpEptw==
X-Received: by 2002:a05:6000:1001:b0:354:f52b:db65 with SMTP id
 ffacd0b85a97d-355245e3d1dmr9303927f8f.3.1716905282324; 
 Tue, 28 May 2024 07:08:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3564afc3577sm11361473f8f.102.2024.05.28.07.08.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:08:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/42] target/arm: Fix decode of FMOV (hp) vs MOVI
Date: Tue, 28 May 2024 15:07:22 +0100
Message-Id: <20240528140753.3620597-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528140753.3620597-1-peter.maydell@linaro.org>
References: <20240528140753.3620597-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

The decode of FMOV (vector, immediate, half-precision) vs
invalid cases of MOVI are incorrect.

Fixes RISU mismatch for invalid insn 0x2f01fd31.

Fixes: 70b4e6a4457 ("arm/translate-a64: add FP16 FMOV to simd_mod_imm")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240524232121.284515-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d97acdbaf9a..5455ae36850 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7904,27 +7904,31 @@ static void disas_simd_mod_imm(DisasContext *s, uint32_t insn)
     bool is_q = extract32(insn, 30, 1);
     uint64_t imm = 0;
 
-    if (o2 != 0 || ((cmode == 0xf) && is_neg && !is_q)) {
-        /* Check for FMOV (vector, immediate) - half-precision */
-        if (!(dc_isar_feature(aa64_fp16, s) && o2 && cmode == 0xf)) {
+    if (o2) {
+        if (cmode != 0xf || is_neg) {
             unallocated_encoding(s);
             return;
         }
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    if (cmode == 15 && o2 && !is_neg) {
         /* FMOV (vector, immediate) - half-precision */
+        if (!dc_isar_feature(aa64_fp16, s)) {
+            unallocated_encoding(s);
+            return;
+        }
         imm = vfp_expand_imm(MO_16, abcdefgh);
         /* now duplicate across the lanes */
         imm = dup_const(MO_16, imm);
     } else {
+        if (cmode == 0xf && is_neg && !is_q) {
+            unallocated_encoding(s);
+            return;
+        }
         imm = asimd_imm_const(abcdefgh, cmode, is_neg);
     }
 
+    if (!fp_access_check(s)) {
+        return;
+    }
+
     if (!((cmode & 0x9) == 0x1 || (cmode & 0xd) == 0x9)) {
         /* MOVI or MVNI, with MVNI negation handled above.  */
         tcg_gen_gvec_dup_imm(MO_64, vec_full_reg_offset(s, rd), is_q ? 16 : 8,
-- 
2.34.1


