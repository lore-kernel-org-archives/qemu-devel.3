Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC10FC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 14:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBxUk-0001Yw-MR; Tue, 28 May 2024 10:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUi-0001WK-It
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:04 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUg-00072i-Ld
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:04 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42101a2ac2cso6923375e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 07:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905281; x=1717510081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7mmWhNodKbmTLVdPuiuTCYlFcWsuhcev1rLaRhnWvpU=;
 b=PtUL9w1jIYyYZoccIPB2P6ENWUhQKBcYY+hOc+awKoF+Pi1MgtnAploO2f5FtzDYJb
 7L+KhJyGQC1b88nyX7e3kj4yhbTQK3ltCYX2Jc1vlVDg2vL8+bYcUXD/h01cg6pv/uaU
 jHGIUvwoCQtS/HlZ7oZsJFGFc1OCuZgXTOcww3YFa+L180RO+HatXdwNhzV4EHDj0SUF
 pwfDTXRkw1lWV4VnS2o1RzUNuD6ToqIXksbrNnwr/s1HIeHrlmBelRsMJ6xBRs/3sGVS
 sZOSwYrghEt7Y0Grbis3IcNhl3TyP25vI7DkXAb+0pWX4OdJ1rRwi0ub4r/SGCr+TmGt
 qbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905281; x=1717510081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7mmWhNodKbmTLVdPuiuTCYlFcWsuhcev1rLaRhnWvpU=;
 b=iPOnxzUv/KTKa06NvA278Ycu3XjAaGiBqOeNQXeQb2iudxTZ9YPlHnDapQDwhbxDVV
 Z+r1hy8/1WpWGY6ZZCvIPnu59EXvXbcchjpb9cmkjwfxQs9r+yGWIMGo1yhsMe0UTMNA
 IIUKtt/dC7BUhZ8QRjNYCHWvy9LAbtOFfU+r/PNe8h0ZHDW4wYpZdiCr2iwh9Tz2vgqm
 wS8lmPYoW0Tk7Dt40okjgtXXEIJ7OCc42NgJ2NPSB+ekwviQw91IegobRGAjAnQETuJH
 QukNcMkfd4wBDrHGSNhJSMXY/risXGzJIuAW09uts5oDHI9RU83mrE20vI3zPS7m7MBb
 cDtw==
X-Gm-Message-State: AOJu0YxZvLErENYs7cRmv55v2LnXZ7PTWotSNEVEAT7lJUcAxza4z7Mv
 FriXHUvJqbsChclEhKrZ/fij+etDsVdaBm9meCRq6NheAToD+qKP8XX6Jr5vlGmLN0zlNvBx0VE
 w
X-Google-Smtp-Source: AGHT+IGeBqYFLHS1UoX1nAhiiyf/DYm6/EqGcuMyJzvNQoL2Wwq1uQSgTm9W5ppbw1xnVkJlkuXvrQ==
X-Received: by 2002:a5d:54cf:0:b0:357:73ca:9c00 with SMTP id
 ffacd0b85a97d-35773ca9de0mr5997579f8f.32.1716905281275; 
 Tue, 28 May 2024 07:08:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3564afc3577sm11361473f8f.102.2024.05.28.07.08.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:08:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/42] target/arm: Use PLD, PLDW, PLI not NOP for t32
Date: Tue, 28 May 2024 15:07:20 +0100
Message-Id: <20240528140753.3620597-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528140753.3620597-1-peter.maydell@linaro.org>
References: <20240528140753.3620597-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

This fixes a bug in that neither PLI nor PLDW are present in ARMv6T2,
but are introduced with ARMv7 and ARMv7MP respectively.
For clarity, do not use NOP for PLD.

Note that there is no PLDW (literal). Architecturally in the
T1 encoding of "PLD (literal)" bit 5 is "(0)", which means
that it should be zero and if it is not then the behaviour
is CONSTRAINED UNPREDICTABLE (might UNDEF, NOP, or ignore the
value of the bit).

In our implementation we have patterns for both:

+    PLD          1111 1000 -001 1111 1111 ------------        # (literal)
+    PLD          1111 1000 -011 1111 1111 ------------        # (literal)

and so we effectively ignore the value of bit 5.  (This is a
permitted option for this CONSTRAINED UNPREDICTABLE.) This isn't a
behaviour change in this commit, since we previously had NOP lines
for both those patterns.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240524232121.284515-3-richard.henderson@linaro.org
[PMM: adjusted commit message to note that PLD (lit) T1 bit 5
being 1 is an UNPREDICTABLE case.]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/t32.decode  | 25 ++++++++++++-------------
 target/arm/tcg/translate.c |  4 ++--
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/t32.decode b/target/arm/tcg/t32.decode
index f21ad0167ab..d327178829d 100644
--- a/target/arm/tcg/t32.decode
+++ b/target/arm/tcg/t32.decode
@@ -458,41 +458,41 @@ STR_ri           1111 1000 1100 .... .... ............        @ldst_ri_pos
 # Note that Load, unsigned (literal) overlaps all other load encodings.
 {
   {
-    NOP          1111 1000 -001 1111 1111 ------------        # PLD
+    PLD          1111 1000 -001 1111 1111 ------------        # (literal)
     LDRB_ri      1111 1000 .001 1111 .... ............        @ldst_ri_lit
   }
   {
-    NOP          1111 1000 1001 ---- 1111 ------------        # PLD
+    PLD          1111 1000 1001 ---- 1111 ------------        # (immediate T1)
     LDRB_ri      1111 1000 1001 .... .... ............        @ldst_ri_pos
   }
   LDRB_ri        1111 1000 0001 .... .... 1..1 ........       @ldst_ri_idx
   {
-    NOP          1111 1000 0001 ---- 1111 1100 --------       # PLD
+    PLD          1111 1000 0001 ---- 1111 1100 --------       # (immediate T2)
     LDRB_ri      1111 1000 0001 .... .... 1100 ........       @ldst_ri_neg
   }
   LDRBT_ri       1111 1000 0001 .... .... 1110 ........       @ldst_ri_unp
   {
-    NOP          1111 1000 0001 ---- 1111 000000 -- ----      # PLD
+    PLD          1111 1000 0001 ---- 1111 000000 -- ----      # (register)
     LDRB_rr      1111 1000 0001 .... .... 000000 .. ....      @ldst_rr
   }
 }
 {
   {
-    NOP          1111 1000 -011 1111 1111 ------------        # PLD
+    PLD          1111 1000 -011 1111 1111 ------------        # (literal)
     LDRH_ri      1111 1000 .011 1111 .... ............        @ldst_ri_lit
   }
   {
-    NOP          1111 1000 1011 ---- 1111 ------------        # PLDW
+    PLDW         1111 1000 1011 ---- 1111 ------------        # (immediate T1)
     LDRH_ri      1111 1000 1011 .... .... ............        @ldst_ri_pos
   }
   LDRH_ri        1111 1000 0011 .... .... 1..1 ........       @ldst_ri_idx
   {
-    NOP          1111 1000 0011 ---- 1111 1100 --------       # PLDW
+    PLDW         1111 1000 0011 ---- 1111 1100 --------       # (immediate T2)
     LDRH_ri      1111 1000 0011 .... .... 1100 ........       @ldst_ri_neg
   }
   LDRHT_ri       1111 1000 0011 .... .... 1110 ........       @ldst_ri_unp
   {
-    NOP          1111 1000 0011 ---- 1111 000000 -- ----      # PLDW
+    PLDW         1111 1000 0011 ---- 1111 000000 -- ----      # (register)
     LDRH_rr      1111 1000 0011 .... .... 000000 .. ....      @ldst_rr
   }
 }
@@ -504,24 +504,23 @@ STR_ri           1111 1000 1100 .... .... ............        @ldst_ri_pos
   LDRT_ri        1111 1000 0101 .... .... 1110 ........       @ldst_ri_unp
   LDR_rr         1111 1000 0101 .... .... 000000 .. ....      @ldst_rr
 }
-# NOPs here are PLI.
 {
   {
-    NOP          1111 1001 -001 1111 1111 ------------
+    PLI          1111 1001 -001 1111 1111 ------------        # (literal T3)
     LDRSB_ri     1111 1001 .001 1111 .... ............        @ldst_ri_lit
   }
   {
-    NOP          1111 1001 1001 ---- 1111 ------------
+    PLI          1111 1001 1001 ---- 1111 ------------        # (immediate T1)
     LDRSB_ri     1111 1001 1001 .... .... ............        @ldst_ri_pos
   }
   LDRSB_ri       1111 1001 0001 .... .... 1..1 ........       @ldst_ri_idx
   {
-    NOP          1111 1001 0001 ---- 1111 1100 --------
+    PLI          1111 1001 0001 ---- 1111 1100 --------       # (immediate T2)
     LDRSB_ri     1111 1001 0001 .... .... 1100 ........       @ldst_ri_neg
   }
   LDRSBT_ri      1111 1001 0001 .... .... 1110 ........       @ldst_ri_unp
   {
-    NOP          1111 1001 0001 ---- 1111 000000 -- ----
+    PLI          1111 1001 0001 ---- 1111 000000 -- ----      # (register)
     LDRSB_rr     1111 1001 0001 .... .... 000000 .. ....      @ldst_rr
   }
 }
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index d605e10f110..187eacffd96 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -8765,12 +8765,12 @@ static bool trans_PLD(DisasContext *s, arg_PLD *a)
     return ENABLE_ARCH_5TE;
 }
 
-static bool trans_PLDW(DisasContext *s, arg_PLD *a)
+static bool trans_PLDW(DisasContext *s, arg_PLDW *a)
 {
     return arm_dc_feature(s, ARM_FEATURE_V7MP);
 }
 
-static bool trans_PLI(DisasContext *s, arg_PLD *a)
+static bool trans_PLI(DisasContext *s, arg_PLI *a)
 {
     return ENABLE_ARCH_7;
 }
-- 
2.34.1


