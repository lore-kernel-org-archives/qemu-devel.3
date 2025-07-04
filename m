Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142AEC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:26:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjE3-0008KW-44; Fri, 04 Jul 2025 12:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjE2-0008JR-0z
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:22 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjE0-00067d-3M
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:21 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so8642245e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646318; x=1752251118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dmtyuSjmao+bChYJa65R37Jk6mVzQjSFZFloZ8Y3fhI=;
 b=lq1Fu1gBu6LdC81CilHJdZVv7q1ISihYEFj08JsbUw3rwpLdyt9Z4EK1xYZcuF8psT
 gd5BjklVdZRby1mYuV2oeBVrWW+DyM89X/vQVDc0iYn5A226AaRzILpyEYGoA0CtcUNK
 My6jzgUEp2uwdpEXoPjO83dwAGsBkt01PLITCzIDyOjOBgztbRu5jcGJ/nZBRkB2q6tQ
 8yVRzE1ecDc09B+6D7dLiPzUBRTdgoKAve/AeFwQpucX1ILh6mXQGVSFLxDNu6pRKmQW
 WY3ES5N26u++FU5QSaUSEEOXBDqS61TgRmsdzj4K8/yjueRu0iB4Yfo2pAbertTRYgHQ
 7Cnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646318; x=1752251118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dmtyuSjmao+bChYJa65R37Jk6mVzQjSFZFloZ8Y3fhI=;
 b=TS48FzU01+P2hlZiQVdEsMFxNsdc8nj0t2wzQAnbL4SEAGOlZcz0CclfXUou5l5wZo
 /Rp/hmNyDJBbSDd6xZCnl87qelyIFuTHTo9pcz6eRgXkP+P1LmJzYz8tG9N30lPjSXE3
 YxblGhoDyKatD5UBKm5rTFEmvGWf6PnKIjzEtcnyYWTE+pTkBsH9ds5WBOG+QVE2UsMM
 NwhSAOB78oe4V8HniNyovpRoSk9GyPXO9I8ilBByY4JlSTfUUJ+wjEiiHAXOTqVGvCYS
 lYTHlD1HTBdbNfYdCinRREtGHRS0prUUzadSOq9s8X6zDtgHGJK/JWh8hSlBg9R+r1QS
 MrKA==
X-Gm-Message-State: AOJu0YzmSDKDRUfWsnEm8hpqdUvxd21ApBV7PRMr1hH0IVrRzSXjoosk
 e1eW0myMoL0wrE2MJj9njzcr04vNfqYTQXUAnBt9Eeu5BPltC8dqnc/F5IZAMxW/JxDVXiAPcHj
 hJFtj
X-Gm-Gg: ASbGncuQXYtvNSY2oqMow2qXAoPdakjrUwvTUVsuQeO37SFIklFYAuUGWcFR9nxNY6l
 Ocx/HdRSBGNlPpUWKbZ5bm+KYO+vYM7B701UXLb4hk44FYKDcE114653udeu1UfI7YhPdJ1GPcO
 R/1Ay6SEkU2f0HuJNUlwCM9Hvt4PUcSPqjqzcVZkSyebv5p4GsfWQxSD93H+hs5g9hZl2ER8FYx
 Jp4N9EPK9/9ezqCJaYWNTHgDma0N+Kmtp918hmhOw1iyPutds/6pwNFNeK3RxawPpG7v7MG8oJD
 XoyPgsX7xCm4a9ko2xoYRilcNdrk5xeKG0qFiFN6YenKNCMTax5qcVpWqc1MDxrknil0
X-Google-Smtp-Source: AGHT+IHCzrHwfvUf4mfef0B9e6zT7k7Xtuk9GktDTBGGQOoBpojwdw2ZvCcVDwJ9Jfky8LtG4f8ftA==
X-Received: by 2002:a05:6000:18a8:b0:3a5:3b56:974e with SMTP id
 ffacd0b85a97d-3b4964bb5f7mr2799216f8f.6.1751646318166; 
 Fri, 04 Jul 2025 09:25:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 016/119] target/arm: Replace @rda_rn_rm_e0 in sve.decode
Date: Fri,  4 Jul 2025 17:23:16 +0100
Message-ID: <20250704162501.249138-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

Replace @rda_rn_rm_e0 with @rda_rn_rm_ex, and require
users to supply an explicit esz.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve.decode | 48 +++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 04b6fcc0cfd..3a99eb72998 100644
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


