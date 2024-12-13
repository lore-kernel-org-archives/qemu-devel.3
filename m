Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A037E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9XC-00073j-PI; Fri, 13 Dec 2024 12:33:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9X3-0006zI-TN
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:57 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9X0-0001UW-7H
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:53 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so11936045e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111167; x=1734715967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1Keb5Nej/LJZUnVN62xwMoD4AGB05WwZ2iHDeqJMuMI=;
 b=IIg9gTU2ruEtR+g6YxlBuEOej+on0Rjvo9i44o3UXBGsX0RLa7uqE/avhpyxLoeqcl
 AUC3eHKdUmTo+dXsgPDK1GmvZ7oD8JjbhYaRcgGXngWIPcDEteEHWZRf2DWVFhC9VNyy
 Y7GOlPWBgoz5wDHw4hd+AFOYgLSQZSpivzHF2wvVEmY8oYyCQ+JB8YK7ZZKJfFUdrSTg
 Ps084o0rCp88N6xr5oXHcbISbaQgFcCyyQ8r8ZQNXSKYR9eo2D88kWzkxOIvEd/9Boa3
 RFdzv+3YMKw3eGbfByMajS+yfjguJ0bn5SDirY1Fy+5J10eUOVhuqOCD1clb5wWUceKW
 OIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111167; x=1734715967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Keb5Nej/LJZUnVN62xwMoD4AGB05WwZ2iHDeqJMuMI=;
 b=kMTM2WQTrlOl9SQjAFBe7fDZ74ywntIyvr1ncTclPExR4EUD4VbfJLgylRbw+vziyV
 Noxq5IkFnqoW0RBuLnFNRWANFeW0vZSMwXYWGmkjGEhXkRWNnihqsfkZHzPTbT7QL141
 FQC2f1WTah6lTNveePMaVCrhQL+cwCMvSfvFHEUo5te6SbBIAlmaNwY5TeIj26AFzH95
 YsdVqnxhnsWchgeKOswY6ny8lIQ3Y0TOIrd/f0FWfMy66rJiEXnLPrEJMGa1ckYQesqA
 Mak65OfqMxNNiI3JjIUjuA+CaNR7RAcJA1iXttUOdIb6ENCqLTiMCdlu8ODW6ORlNceZ
 gDYA==
X-Gm-Message-State: AOJu0YzHLlooo5x44Y9v5nLiImEljzq9WdCNbvzM2KXL0mFzDpNOY/Tp
 5e7ngyaVzDYjekqE94MxcwbPKuojhHZEE1r5LFvcuwpFSMllKXUDXNp9yq4xh1Ndxl0ykVW3MPe
 N
X-Gm-Gg: ASbGncvq2JP9sOTvWsvbZSiaQQG3JviIbIb6KfCZdS9qNt4HNrKpuFpVLlCkEQOgK3R
 TYgq04mBOvUg0LWpwueh8cDDPCuo43qlukBvazc87W5BLHtI2XycXr1WL3ViGK0JSdzdFkbIlWd
 4etWQAyL5SEI5r/CyYsY/yLoVDMa9VWkiIUPrODrx/0aAFHLQV/57F3fv54tNN2xpAnlRWmLYZP
 2ylRWQ0CPd/Qqq5bI904z1xNPk/jIE1BIJ6bGwWLhh32LrZ3ThTH9In/o+SGg==
X-Google-Smtp-Source: AGHT+IFhJ768Fj//KW9C8KFcJXLsB6RHLqY0aB5p9D7PuBkIe2oDcrvDSuS1frpfkUhE2WzmqzfwYw==
X-Received: by 2002:a5d:6da2:0:b0:385:ec6e:e872 with SMTP id
 ffacd0b85a97d-3888e0b8c07mr2865062f8f.38.1734111167633; 
 Fri, 13 Dec 2024 09:32:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.32.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:32:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/85] target/arm: Convert disas_adc_sbc to decodetree
Date: Fri, 13 Dec 2024 17:31:19 +0000
Message-Id: <20241213173229.3308926-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
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

This includes ADC, SBC, ADCS, SBCS.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-16-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  6 +++++
 target/arm/tcg/translate-a64.c | 43 +++++++++++++---------------------
 2 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index b0cc8bd476e..7a40ca455e4 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -746,6 +746,12 @@ ADDS_ext        . 01 01011001 ..... ... ... ..... .....     @addsub_ext
 SUBS_ext        . 11 01011001 ..... ... ... ..... .....     @addsub_ext
 
 # Add/subtract (carry)
+
+ADC             . 00 11010000 ..... 000000 ..... .....  @rrr_sf
+ADCS            . 01 11010000 ..... 000000 ..... .....  @rrr_sf
+SBC             . 10 11010000 ..... 000000 ..... .....  @rrr_sf
+SBCS            . 11 11010000 ..... 000000 ..... .....  @rrr_sf
+
 # Rotate right into flags
 # Evaluate into flags
 # Conditional compare (regster)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 99ff787c61f..d7747fcf575 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8017,42 +8017,34 @@ TRANS(SMSUBL, do_muladd, a, true, true, MO_SL)
 TRANS(UMADDL, do_muladd, a, true, false, MO_UL)
 TRANS(UMSUBL, do_muladd, a, true, true, MO_UL)
 
-/* Add/subtract (with carry)
- *  31 30 29 28 27 26 25 24 23 22 21  20  16  15       10  9    5 4   0
- * +--+--+--+------------------------+------+-------------+------+-----+
- * |sf|op| S| 1  1  0  1  0  0  0  0 |  rm  | 0 0 0 0 0 0 |  Rn  |  Rd |
- * +--+--+--+------------------------+------+-------------+------+-----+
- */
-
-static void disas_adc_sbc(DisasContext *s, uint32_t insn)
+static bool do_adc_sbc(DisasContext *s, arg_rrr_sf *a,
+                       bool is_sub, bool setflags)
 {
-    unsigned int sf, op, setflags, rm, rn, rd;
     TCGv_i64 tcg_y, tcg_rn, tcg_rd;
 
-    sf = extract32(insn, 31, 1);
-    op = extract32(insn, 30, 1);
-    setflags = extract32(insn, 29, 1);
-    rm = extract32(insn, 16, 5);
-    rn = extract32(insn, 5, 5);
-    rd = extract32(insn, 0, 5);
+    tcg_rd = cpu_reg(s, a->rd);
+    tcg_rn = cpu_reg(s, a->rn);
 
-    tcg_rd = cpu_reg(s, rd);
-    tcg_rn = cpu_reg(s, rn);
-
-    if (op) {
+    if (is_sub) {
         tcg_y = tcg_temp_new_i64();
-        tcg_gen_not_i64(tcg_y, cpu_reg(s, rm));
+        tcg_gen_not_i64(tcg_y, cpu_reg(s, a->rm));
     } else {
-        tcg_y = cpu_reg(s, rm);
+        tcg_y = cpu_reg(s, a->rm);
     }
 
     if (setflags) {
-        gen_adc_CC(sf, tcg_rd, tcg_rn, tcg_y);
+        gen_adc_CC(a->sf, tcg_rd, tcg_rn, tcg_y);
     } else {
-        gen_adc(sf, tcg_rd, tcg_rn, tcg_y);
+        gen_adc(a->sf, tcg_rd, tcg_rn, tcg_y);
     }
+    return true;
 }
 
+TRANS(ADC, do_adc_sbc, a, false, false)
+TRANS(SBC, do_adc_sbc, a, true, false)
+TRANS(ADCS, do_adc_sbc, a, false, true)
+TRANS(SBCS, do_adc_sbc, a, true, true)
+
 /*
  * Rotate right into flags
  *  31 30 29                21       15          10      5  4      0
@@ -8305,10 +8297,6 @@ static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
     switch (op2) {
     case 0x0:
         switch (op3) {
-        case 0x00: /* Add/subtract (with carry) */
-            disas_adc_sbc(s, insn);
-            break;
-
         case 0x01: /* Rotate right into flags */
         case 0x21:
             disas_rotate_right_into_flags(s, insn);
@@ -8322,6 +8310,7 @@ static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
             break;
 
         default:
+        case 0x00: /* Add/subtract (with carry) */
             goto do_unallocated;
         }
         break;
-- 
2.34.1


