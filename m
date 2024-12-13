Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B2C3E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9XY-0007Kw-2y; Fri, 13 Dec 2024 12:33:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Wu-0006ss-1c
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:46 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Ws-0001Sq-5Y
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:43 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-435004228c0so24456375e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111160; x=1734715960; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rSouMkNKRgzvSW4AYEFfz23zzhUYufmzAA64c5qsrK8=;
 b=RuzGa8fd3SFow1wBGMsc3SfPnYUSOPY3nOFlng/xS2aZmz8YI47q2dqj/IdvqWOmJ6
 GhWyueFoA0dB7WhJXEaIAbhvAAqh7WMlckN8faNRyzp0LKzE+1LmLVSC5iEEMMprd0Wa
 c+c96Kd5MWGoXCWCaf/LC2To0bgeZg9EPkXZIW3AK5pP4qwxu/GoK4GGY78zrqOT9AaG
 /2nq5ip0Kl8QjxEH6WCkG6Aiay83NMFZ8vPPQELFMh6FL4qgInQGHaKZyKC33a9nJ1lA
 z9RDA/ZzeScOgqE7ptIrnWI6vDDq+T/jcdgO4XRtjZinUjBJ6INJjVEfx11vEGAMwhVT
 ZRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111160; x=1734715960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rSouMkNKRgzvSW4AYEFfz23zzhUYufmzAA64c5qsrK8=;
 b=CBRGMALfL5kgSQzINSLVqi8LYdaPm4Ay+CqK6NI/3u457dYvoTSu13dgIPyD8CiICl
 k/7HdAujiz+6bYoIy2SxIlNI1wNorIG0N7Pq7fXidOdbO3m1tWYjX9uZQL4HP7NjmgoR
 UiRdUw65/BWO67uL7IOhNgZPdkTCOba04aN7tFM/YkaTlOLzFzu8CeM8n/zvYD4IZQ+h
 p/51rsyyMncYxojWuSHjaGheV7374d0Ol5e7B0Vq2kEl+3Enit9Aj4rPl3MN4AMCQdvl
 7M5wBSEHDrPb6jDD1uQUUqwK7axp/F1HPfXuQ61zyjIje5GeI4RA9tu2KgrT7ZG/Soox
 6bNw==
X-Gm-Message-State: AOJu0Yxd6pnHo+iolv7cGE5aKE/10GYr8U0Qlh8SePnD0atLJ4j0G+m+
 a1c8bSc/GOt0IaS456j1wfWJr/pDmQS71SOYGmjbCa8stk2/9EU68wlM88MwUe1RPeLzCetTD1i
 H
X-Gm-Gg: ASbGncuXTX9UkAtKuWgFBWqGVDJwnR1qCwjBWyTe5OK6chSrmYLqVOYJQtUyrO3vIps
 wSwInK/5v8uHt7qaG8bibLL91nt3UuSZJc4qj+oJhTZETNFXEPf3I8jQZGiYqnSP4tCqSCr/JRo
 W5Zil2zh+6btWgWkLXznVNCLol67oDD78tW0F7fZty8y2n6LSTvvci1G8FJbY2pYejpakELucgU
 C11YeRrAQZgMhCA3yaecppKwYAxos/jBsR7cNf6n6Lc0NaHX3i6N5ZEG7OL3w==
X-Google-Smtp-Source: AGHT+IHzbc4fAVnPd7rEVGxijXQYy5k9BYhf7KyYmojZg5O0U5wTEH1HW2TqZEO6T8gNWwaUQrRHbQ==
X-Received: by 2002:a05:6000:18a5:b0:386:3a8e:64bd with SMTP id
 ffacd0b85a97d-38880ad912fmr2982634f8f.22.1734111160579; 
 Fri, 13 Dec 2024 09:32:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.32.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:32:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/85] target/arm: Convert CLZ, CLS to decodetree
Date: Fri, 13 Dec 2024 17:31:12 +0000
Message-Id: <20241213173229.3308926-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-9-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  3 ++
 target/arm/tcg/translate-a64.c | 72 ++++++++++++++--------------------
 2 files changed, 33 insertions(+), 42 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index dd44651f340..410eaa9333a 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -696,6 +696,9 @@ REV16           . 10 11010110 00000 000001 ..... .....  @rr_sf
 REV32           . 10 11010110 00000 000010 ..... .....  @rr_sf
 REV64           1 10 11010110 00000 000011 ..... .....  @rr
 
+CLZ             . 10 11010110 00000 000100 ..... .....  @rr_sf
+CLS             . 10 11010110 00000 000101 ..... .....  @rr_sf
+
 # Logical (shifted reg)
 # Add/subtract (shifted reg)
 # Add/subtract (extended reg)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 1805d77f43c..552b45b4e25 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7738,6 +7738,32 @@ TRANS(REV16, gen_rr, a->rd, a->rn, a->sf ? gen_rev16_64 : gen_rev16_32)
 TRANS(REV32, gen_rr, a->rd, a->rn, a->sf ? gen_rev32 : gen_rev_32)
 TRANS(REV64, gen_rr, a->rd, a->rn, tcg_gen_bswap64_i64)
 
+static void gen_clz32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
+{
+    TCGv_i32 t32 = tcg_temp_new_i32();
+
+    tcg_gen_extrl_i64_i32(t32, tcg_rn);
+    tcg_gen_clzi_i32(t32, t32, 32);
+    tcg_gen_extu_i32_i64(tcg_rd, t32);
+}
+
+static void gen_clz64(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
+{
+    tcg_gen_clzi_i64(tcg_rd, tcg_rn, 64);
+}
+
+static void gen_cls32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
+{
+    TCGv_i32 t32 = tcg_temp_new_i32();
+
+    tcg_gen_extrl_i64_i32(t32, tcg_rn);
+    tcg_gen_clrsb_i32(t32, t32);
+    tcg_gen_extu_i32_i64(tcg_rd, t32);
+}
+
+TRANS(CLZ, gen_rr, a->rd, a->rn, a->sf ? gen_clz64 : gen_clz32)
+TRANS(CLS, gen_rr, a->rd, a->rn, a->sf ? tcg_gen_clrsb_i64 : gen_cls32)
+
 /* Logical (shifted register)
  *   31  30 29 28       24 23   22 21  20  16 15    10 9    5 4    0
  * +----+-----+-----------+-------+---+------+--------+------+------+
@@ -8322,40 +8348,6 @@ static void disas_cond_select(DisasContext *s, uint32_t insn)
     }
 }
 
-static void handle_clz(DisasContext *s, unsigned int sf,
-                       unsigned int rn, unsigned int rd)
-{
-    TCGv_i64 tcg_rd, tcg_rn;
-    tcg_rd = cpu_reg(s, rd);
-    tcg_rn = cpu_reg(s, rn);
-
-    if (sf) {
-        tcg_gen_clzi_i64(tcg_rd, tcg_rn, 64);
-    } else {
-        TCGv_i32 tcg_tmp32 = tcg_temp_new_i32();
-        tcg_gen_extrl_i64_i32(tcg_tmp32, tcg_rn);
-        tcg_gen_clzi_i32(tcg_tmp32, tcg_tmp32, 32);
-        tcg_gen_extu_i32_i64(tcg_rd, tcg_tmp32);
-    }
-}
-
-static void handle_cls(DisasContext *s, unsigned int sf,
-                       unsigned int rn, unsigned int rd)
-{
-    TCGv_i64 tcg_rd, tcg_rn;
-    tcg_rd = cpu_reg(s, rd);
-    tcg_rn = cpu_reg(s, rn);
-
-    if (sf) {
-        tcg_gen_clrsb_i64(tcg_rd, tcg_rn);
-    } else {
-        TCGv_i32 tcg_tmp32 = tcg_temp_new_i32();
-        tcg_gen_extrl_i64_i32(tcg_tmp32, tcg_rn);
-        tcg_gen_clrsb_i32(tcg_tmp32, tcg_tmp32);
-        tcg_gen_extu_i32_i64(tcg_rd, tcg_tmp32);
-    }
-}
-
 /* Data-processing (1 source)
  *   31  30  29  28             21 20     16 15    10 9    5 4    0
  * +----+---+---+-----------------+---------+--------+------+------+
@@ -8381,14 +8373,6 @@ static void disas_data_proc_1src(DisasContext *s, uint32_t insn)
 #define MAP(SF, O2, O1) ((SF) | (O1 << 1) | (O2 << 7))
 
     switch (MAP(sf, opcode2, opcode)) {
-    case MAP(0, 0x00, 0x04): /* CLZ */
-    case MAP(1, 0x00, 0x04):
-        handle_clz(s, sf, rn, rd);
-        break;
-    case MAP(0, 0x00, 0x05): /* CLS */
-    case MAP(1, 0x00, 0x05):
-        handle_cls(s, sf, rn, rd);
-        break;
     case MAP(1, 0x01, 0x00): /* PACIA */
         if (s->pauth_active) {
             tcg_rd = cpu_reg(s, rd);
@@ -8542,6 +8526,10 @@ static void disas_data_proc_1src(DisasContext *s, uint32_t insn)
     case MAP(0, 0x00, 0x02): /* REV/REV32 */
     case MAP(1, 0x00, 0x02):
     case MAP(1, 0x00, 0x03): /* REV64 */
+    case MAP(0, 0x00, 0x04): /* CLZ */
+    case MAP(1, 0x00, 0x04):
+    case MAP(0, 0x00, 0x05): /* CLS */
+    case MAP(1, 0x00, 0x05):
         unallocated_encoding(s);
         break;
     }
-- 
2.34.1


