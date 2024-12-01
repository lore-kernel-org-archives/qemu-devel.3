Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F87D49771
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlWt-0001Oj-UA; Sun, 01 Dec 2024 10:06:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWo-0001KB-4J
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:30 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWm-0004Am-Ds
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:29 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-71d4c462ab1so1139968a34.0
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065587; x=1733670387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e1OIFt6Wa9ivuGHrhRCcysL/gALDZ16yEs6HdTP8v7U=;
 b=HG+FMbOgfKTAyK5sTeeqbKd6jIyKdhAcbpVUR1CaWh5GieImoLrLhALzvzBynj4Tm7
 ODQjtOEDpMT912HmiVS0tyRnO/3F5Bgvga80MToX2GsdH/Yo76MBmP2OBAjIjTV91QA0
 Pi+NULxMsLLvwVbZynIAyInRGaHjSNbPzDRhhrbVMYv3r56i50pm4pm6Ual92lMN6c2/
 HCiMxSB3ZqR+mnTpRnG1imkw6u7NTPfIr130SwxZ9IgxIw+RwLZaM48beKMUC9CWd+Kj
 p6lhhXHD+bl8yxfSUB1wapOCrWd4JCh8SeKotSxPjbeGG+REQ3Z2nZi/C+F4cGbWFjdQ
 f0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065587; x=1733670387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e1OIFt6Wa9ivuGHrhRCcysL/gALDZ16yEs6HdTP8v7U=;
 b=rBE4/2vxgnqX72pjz5bS04ngp2IlHny+G9/JWzN+ptAYIdAUXU3wwchwWcMgmjxAKm
 1vsDdNsv1Q2Dt67LAXo1J2jjOc3msyqGd2SqH9Noy/PVXHi4qHzV2PkuYKnYuKUG7pqz
 6GaGVe7II8heQ/sGndqXuLnWg3UqAG+hFfcsZpcYoS7/Uu+tginIk9lpXBnbrYKvyqql
 rLtgLXkmxknlEPZ5Ho4zeeBVBF8tVchANLgLjiMaj8r9+HNGAsjEBFB81vw5NoNWALMH
 HyKCXk2sJTdfWjweefbdJVKJOgrRRes6KC7g6NpgLYJyPQU1ZvQxV3gGp7N2rVHDQMCR
 tfVA==
X-Gm-Message-State: AOJu0YwbpGUc1Yz+BTRkXemOXHfcS5fLBVU10oPMWbBAPV5xTqjimA4J
 +Jynj31QGxTMGgXFM8ychbN8b8kHRKpY/9xS63i2j7oaLWUUGNsqHRhvEMA1CHOyxN6MRBNwXoG
 Yvzg=
X-Gm-Gg: ASbGncvdgn3Y5XqRRk1yAZRHRFUtxfjemsGO8EiWEZq6pPKnmpZeqkCMHCC/mHkXbW9
 Z2I1x8uf30zaPTFc6MtZ2vyDlZYNB5D22jCukCIqV91XgTJzEbX5FL8KeSswKm+G5yreW74agua
 kmJ8TW6dv0HgheuuEZ7u8bGT7YuQ+j6MI8nfO3Grc6YuBoJtZLMVlYLgqg8MdjeXxZm6M9lMO4k
 FLIiJWT2e7suV5jfrW97AOZvr9ir7DiL3e0TZVoeDty023AMwMUpmnK6OaaTX+UgarPGxmqBFc0
 +TagqUUU3GVAmOSyuaz9DURbWFi/jOzsa9uM
X-Google-Smtp-Source: AGHT+IHrXLf5JSll7TjMegVZmyNopQg/6IRPU9wgp7nev6lKtpgU1GdeCzg/DqKWws9SVopLydW2KQ==
X-Received: by 2002:a05:6830:7199:b0:71d:5043:1026 with SMTP id
 46e09a7af769-71d65c932demr13944881a34.9.1733065586925; 
 Sun, 01 Dec 2024 07:06:26 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d7254473asm1822220a34.27.2024.12.01.07.06.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:06:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 15/67] target/arm: Convert disas_adc_sbc to decodetree
Date: Sun,  1 Dec 2024 09:05:14 -0600
Message-ID: <20241201150607.12812-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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

This includes ADC, SBC, ADCS, SBCS.

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
index c6609749ae..34bff988f7 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -746,6 +746,12 @@ ADDS_ext        . 01 01011001 ..... ... ... ..... .....  @addsub_ext
 SUBS_ext        . 11 01011001 ..... ... ... ..... .....  @addsub_ext
 
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


