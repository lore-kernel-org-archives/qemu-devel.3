Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CCCE77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2x7-0002vG-D5; Tue, 10 Dec 2024 11:19:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2wg-0002ip-Oc
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:18:47 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2we-0006Pd-Up
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:18:46 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-54026562221so728493e87.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847523; x=1734452323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Io19/CScrA5Q2D7CSJ00bcM9NMayI0ImV9POYZmxx0=;
 b=qcJ655o7q3Zb8YtLuzbz/FEhPFQ2nIFqs9jJVkZGOmGcewsXipnrVxliwZebKt+Cm8
 5i1UNq9NckFDqxi5CfrNBHKp2lHy5bB/ScNdpxcOGwQNCyjQvecJVFFdN4TQilruEffV
 vM8YCVPUydpqODQf60H12lcdl++HelpULOBl3AmHuf+lsfZZOJqvl0wImxqP6OO3B5r5
 0oMpKfXWJ/O1m0NrCRCVs8GKhGEMu0x/t/OnZiq2J331sYoG+S09Sebs+8kj3yVBeTvM
 +8eFvUKaYDarDm20PTyo8mCHYnAhzbEggfDSwrRGUzVARk9dSZtcbRAtZezIwGOXHAm6
 zOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847523; x=1734452323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Io19/CScrA5Q2D7CSJ00bcM9NMayI0ImV9POYZmxx0=;
 b=r+BNMTIwxFcWWoZsyWzYZrKrecJomJ6lT1TMA22zYJ45CMDaJ1J//jtEbM5RPSO0gu
 kU8aCPyPykjBdJ7+u10JY09qkoiNGag42VIm+R3Lyd3aKBJLMIitnnstUMShdu7d84fM
 yPK1/VxqqLVGVBFNKCRc1JNfHbIizYe/GfxUapgNaxNwSfctbyRXQJGV8bl+hBI8pCmB
 NoV+qoEdXe8LKT+RnDcI6gMvMSuH4g2QWkyCaz5N7er0GBlvyJu5CcCveSUwbM51ahXB
 9tue0bQwtPbCCmzV7qYgdwnPLDuatL1wZUoxJq8wjMNJOu09eEM+R5q/lrDa0TmBcHNZ
 pCEw==
X-Gm-Message-State: AOJu0YySPA4m+i46XQJ7sk1DnhLVqnvioMEscj2P5OF/U4Gjr2XNZiNa
 Tywys3EVKsQ6YKmp8DcEfehbg4k7bfcXoM3ZHKv49rfrVaPzAGz4gGxTd1dYn1PpiJjTj7LVSHV
 L8DSvEwEP
X-Gm-Gg: ASbGncu6qNZCYbmJS58vWAgN73wXaCwrHd2ZKnC/kP2lrqSpf993LKCGG18AP6EOqZh
 6RXzUe3UGxI3gWqXwOBqu+wxdLh2H+sNAtIZ/2FKHviRJhIVVhoZ+2LsesJcWklWtQuqoGO/WWX
 qwAobQADx9BL1r5OmVAUzFZPlW1wcZQUkKZyaKEmVnO+yKtS3pAUwXNu7pXYGiOyKFZ0TXV0Nuv
 fvjYAgwqXQtfkrLldPsIrikTqex4RurBQv/2RxGTgSDYSnVhkRwnqMdEDQ=
X-Google-Smtp-Source: AGHT+IHdTM52CdMS2s0xZIrSkxHOH7z9AqV9APDjKPughY2Isjtj1Y02cegNX0yoCzUOI2TCkGn/qg==
X-Received: by 2002:a05:6512:ba6:b0:540:1c6e:f046 with SMTP id
 2adb3069b0e04-54024107755mr1825392e87.36.1733847523210; 
 Tue, 10 Dec 2024 08:18:43 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53f93377eefsm1026343e87.67.2024.12.10.08.18.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:18:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 15/69] target/arm: Convert disas_adc_sbc to decodetree
Date: Tue, 10 Dec 2024 10:16:39 -0600
Message-ID: <20241210161733.1830573-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12f.google.com
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

This includes ADC, SBC, ADCS, SBCS.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 43 +++++++++++++---------------------
 target/arm/tcg/a64.decode      |  6 +++++
 2 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 99ff787c61..d7747fcf57 100644
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
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index b0cc8bd476..7a40ca455e 100644
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
-- 
2.43.0


