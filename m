Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFBDC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhJ0-0006yA-Q0; Fri, 04 Jul 2025 10:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhI2-0004nD-2N
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:24 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhI0-0005Gv-5O
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:21 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2cc89c59cc0so1315376fac.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751638878; x=1752243678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xhDz0SUl+MnN71lAnlARYts8N3jBwawNRBYzEstPr2g=;
 b=DPKconh6sNJ85xBvt0PpJ9d4SVgKtAtT8WLR28+5O3SBx5V/xYTbU9+u4Bzr3v5kXB
 Liu5EIZrbfvTDFnEO2bpQZgtoKgN5wnhtvieY3SxfEWQ1+KeQQDCLDCc/0237ZeuzrXE
 yv262H0mwe8KpDH0XNc3CXYinKK5KpXO4fpqUwX4zvHWPr4/4QR6T6fym5YMvl3yB/Wl
 FDjrenK4AoE7ReeuHNwFlmlEyqtdcziFTEFbF1+PL9MWE1+VI/U6L2p+9OdbIXGC38N/
 w5pw7Nm24EmItykaPu46hmRfJAx15EstDgcUFrseCm8cbp7SM16mlPLMYH6GGt6aUtbx
 IDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751638878; x=1752243678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xhDz0SUl+MnN71lAnlARYts8N3jBwawNRBYzEstPr2g=;
 b=OSbcWH1K07BEv7al/IChC7Qun18HoEcRYrrckAoobwZmslhZheQYrjLRbkphUFGQBs
 j+phVuxSW7z/4oc/5/d6iAKePVxo74KS7up7Dug292G/RoJFJ9W6IYkTJ2Q0NoDtf73n
 PNYdYipMGXIcTAOre2wiEI1PADdsviYsrYSvvUIc1I4JJ1WuAs4QWVcjYdOh3Y80ru5L
 QFJPN1WtHqNtQrIj4VvJfz0TyDp7nfTQfl8OvSj+4sl9aQIwQh+/XSBYot0Tw/JKAaNb
 MKXCEra86LKhGWgkLJeCcegL44INsfqrRTCjmNcHdpMsS4q4iU9bHQCGNdXIk41paReP
 Xu0w==
X-Gm-Message-State: AOJu0Yz8SuzxwcsQbesjeFemAbwpC/bzEu6l8JsbxTWLGAeOJlisPBA8
 zZ2WExIrGlMPiO7F6CDeG+zPy1ZYKAUvM9bEuUncDT0MvY+Nll4EC4QtUBeJ4ud1pExv050cZ8f
 D+8QgMgQ=
X-Gm-Gg: ASbGncvEUbnDio9Lgbot/6MnFeEmw2Q2n2ecD57BpEE2TGUZTk/XwPSFXwGz7cjiMDk
 yIslqp78u8h/yAZtThGHRwRB4eWSNKFTw/KrYeVVZSS5chDuEyuJ0CQ3bHSF1Fr+6dMmL8biOqo
 NGBFuYNFRTfYqiOHbC8iOmQ+V45Ge0s5QoEC/vPsxI5D4zPOJTLYFffItGx0RFBPVmbSad3kwNG
 YJmXd4TzRjVR/LRVaPsn+nDkskRSGbRR/OXCrI+4zzl5Wk3cQyT9cfIlIKeNPr6OLulkLUqdwMS
 bKzn2BWL+sXAazIhX+FXm+QKt1pDJS36L2CbVGJrtJ8JxsJ854Y2ih29NbEuZvdfmMSwDM/h9zJ
 WEQzdyj5udrO3Ap/GX+PyIPHeP8dEi7Hk32+lztjTvxOT8B1P
X-Google-Smtp-Source: AGHT+IGg671jIraVDxAvE2MRcLuxypunc+1JUICJHL2cEyTctaVeRyT6YmJi22h2djXCYeHKSQroNg==
X-Received: by 2002:a05:6871:798a:b0:2ea:1e58:7a69 with SMTP id
 586e51a60fabf-2f792038bcfmr2441413fac.15.1751638878466; 
 Fri, 04 Jul 2025 07:21:18 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff0471esm528016fac.3.2025.07.04.07.21.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:21:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 004/108] target/arm: Replace @rda_rn_rm_e0 in sve.decode
Date: Fri,  4 Jul 2025 08:19:27 -0600
Message-ID: <20250704142112.1018902-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x33.google.com
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

Replace @rda_rn_rm_e0 with @rda_rn_rm_ex, and require
users to supply an explicit esz.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sve.decode | 48 +++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 04b6fcc0cf..3a99eb7299 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -131,11 +131,11 @@
 @rda_rn_rm      ........ esz:2 . rm:5 ... ... rn:5 rd:5 \
                 &rrrr_esz ra=%reg_movprfx
 
-# Four operand with unused vector element size
-@rda_rn_rm_e0   ........ ... rm:5 ... ... rn:5 rd:5 \
-                &rrrr_esz esz=0 ra=%reg_movprfx
-@rdn_ra_rm_e0   ........ ... rm:5 ... ... ra:5 rd:5 \
-                &rrrr_esz esz=0 rn=%reg_movprfx
+# Four operand with explicit vector element size
+@rda_rn_rm_ex   ........ ... rm:5 ... ... rn:5 rd:5 \
+                &rrrr_esz ra=%reg_movprfx
+@rdn_ra_rm_ex   ........ ... rm:5 ... ... ra:5 rd:5 \
+                &rrrr_esz rn=%reg_movprfx
 
 # Three operand with "memory" size, aka immediate left shift
 @rd_rn_msz_rm   ........ ... rm:5 .... imm:2 rn:5 rd:5          &rrri
@@ -428,12 +428,12 @@ XAR             00000100 .. 1 ..... 001 101 rm:5  rd:5   &rrri_esz \
                 rn=%reg_movprfx esz=%tszimm16_esz imm=%tszimm16_shr
 
 # SVE2 bitwise ternary operations
-EOR3            00000100 00 1 ..... 001 110 ..... .....         @rdn_ra_rm_e0
-BSL             00000100 00 1 ..... 001 111 ..... .....         @rdn_ra_rm_e0
-BCAX            00000100 01 1 ..... 001 110 ..... .....         @rdn_ra_rm_e0
-BSL1N           00000100 01 1 ..... 001 111 ..... .....         @rdn_ra_rm_e0
-BSL2N           00000100 10 1 ..... 001 111 ..... .....         @rdn_ra_rm_e0
-NBSL            00000100 11 1 ..... 001 111 ..... .....         @rdn_ra_rm_e0
+EOR3            00000100 00 1 ..... 001 110 ..... .....     @rdn_ra_rm_ex esz=0
+BSL             00000100 00 1 ..... 001 111 ..... .....     @rdn_ra_rm_ex esz=0
+BCAX            00000100 01 1 ..... 001 110 ..... .....     @rdn_ra_rm_ex esz=0
+BSL1N           00000100 01 1 ..... 001 111 ..... .....     @rdn_ra_rm_ex esz=0
+BSL2N           00000100 10 1 ..... 001 111 ..... .....     @rdn_ra_rm_ex esz=0
+NBSL            00000100 11 1 ..... 001 111 ..... .....     @rdn_ra_rm_ex esz=0
 
 ### SVE Index Generation Group
 
@@ -1450,9 +1450,9 @@ EORTB           01000101 .. 0 ..... 10010 1 ..... .....  @rd_rn_rm
 
 ## SVE integer matrix multiply accumulate
 
-SMMLA           01000101 00 0 ..... 10011 0 ..... .....  @rda_rn_rm_e0
-USMMLA          01000101 10 0 ..... 10011 0 ..... .....  @rda_rn_rm_e0
-UMMLA           01000101 11 0 ..... 10011 0 ..... .....  @rda_rn_rm_e0
+SMMLA           01000101 00 0 ..... 10011 0 ..... .....  @rda_rn_rm_ex esz=2
+USMMLA          01000101 10 0 ..... 10011 0 ..... .....  @rda_rn_rm_ex esz=2
+UMMLA           01000101 11 0 ..... 10011 0 ..... .....  @rda_rn_rm_ex esz=2
 
 ## SVE2 bitwise permute
 
@@ -1602,9 +1602,9 @@ SQRDCMLAH_zzzz  01000100 esz:2 0 rm:5 0011 rot:2 rn:5 rd:5  ra=%reg_movprfx
 USDOT_zzzz      01000100 .. 0 ..... 011 110 ..... .....  @rda_rn_rm
 
 ### SVE2 floating point matrix multiply accumulate
-BFMMLA          01100100 01 1 ..... 111 001 ..... .....  @rda_rn_rm_e0
-FMMLA_s         01100100 10 1 ..... 111 001 ..... .....  @rda_rn_rm_e0
-FMMLA_d         01100100 11 1 ..... 111 001 ..... .....  @rda_rn_rm_e0
+BFMMLA          01100100 01 1 ..... 111 001 ..... .....  @rda_rn_rm_ex esz=1
+FMMLA_s         01100100 10 1 ..... 111 001 ..... .....  @rda_rn_rm_ex esz=2
+FMMLA_d         01100100 11 1 ..... 111 001 ..... .....  @rda_rn_rm_ex esz=3
 
 ### SVE2 Memory Gather Load Group
 
@@ -1654,16 +1654,16 @@ FCVTLT_sd       01100100 11 0010 11 101 ... ..... .....  @rd_pg_rn_e0
 FLOGB           01100101 00 011 esz:2 0101 pg:3 rn:5 rd:5  &rpr_esz
 
 ### SVE2 floating-point multiply-add long (vectors)
-FMLALB_zzzw     01100100 10 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_e0
-FMLALT_zzzw     01100100 10 1 ..... 10 0 00 1 ..... .....  @rda_rn_rm_e0
-FMLSLB_zzzw     01100100 10 1 ..... 10 1 00 0 ..... .....  @rda_rn_rm_e0
-FMLSLT_zzzw     01100100 10 1 ..... 10 1 00 1 ..... .....  @rda_rn_rm_e0
+FMLALB_zzzw     01100100 10 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
+FMLALT_zzzw     01100100 10 1 ..... 10 0 00 1 ..... .....  @rda_rn_rm_ex esz=2
+FMLSLB_zzzw     01100100 10 1 ..... 10 1 00 0 ..... .....  @rda_rn_rm_ex esz=2
+FMLSLT_zzzw     01100100 10 1 ..... 10 1 00 1 ..... .....  @rda_rn_rm_ex esz=2
 
-BFMLALB_zzzw    01100100 11 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_e0
-BFMLALT_zzzw    01100100 11 1 ..... 10 0 00 1 ..... .....  @rda_rn_rm_e0
+BFMLALB_zzzw    01100100 11 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
+BFMLALT_zzzw    01100100 11 1 ..... 10 0 00 1 ..... .....  @rda_rn_rm_ex esz=2
 
 ### SVE2 floating-point bfloat16 dot-product
-BFDOT_zzzz      01100100 01 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_e0
+BFDOT_zzzz      01100100 01 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 
 ### SVE2 floating-point multiply-add long (indexed)
 FMLALB_zzxw     01100100 10 1 ..... 0100.0 ..... .....     @rrxr_3a esz=2
-- 
2.43.0


