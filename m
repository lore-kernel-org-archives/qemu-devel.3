Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46853C2BA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 21:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK2PX-0002DQ-P1; Wed, 19 Jun 2024 17:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2PU-0002CL-8P
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:05 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2PO-0000JZ-NW
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:03 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f700e4cb92so1729375ad.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 13:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718830797; x=1719435597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u7l+Et2g86i2TS/ecmwjK12lvtYgbXuxki4mug8kdNU=;
 b=vs2WV/ACgTEsN5Nerne7hBcYRB6zgb0iqlI5EGwn+huQnEBYnXRC0LOBChq7x5rzRO
 +mesjwhm+4T1XTHIGD5v8fd7AOT+47no/QdpRRu7P32GxCspY81mDkx11Mo+Av1fXjK/
 J8bKFA3yyyGj1hL0lSS0ltm0074VotXEg4QPXgORen42yKClvstMEf9vaBDO7gX7U2Qn
 FUJyWKccidP2+y63F5+V3HodcUN4DyANiYvul96H63ibFMIICYLDJvx2HCKvcqrhzsZe
 S5tpoTwyVhYdsHccB2jkQYvhrx+x4uhiwTL6lbUoxQUfdR6ztjzN59yhAEbqrnimmj9e
 ld0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718830797; x=1719435597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u7l+Et2g86i2TS/ecmwjK12lvtYgbXuxki4mug8kdNU=;
 b=Q9q3VjkP19tLjoLjJ0o8G7vhCEx3QZgT8mBAiFr1HSFrCI0hZqoZseudgVC7mpGkEB
 BDl4VIx38/kkvy+HXhgZmjdTBljvvWM1ENGlnt5ZV142IMTBFemWf/BF0FpOsubO73W2
 5Q6YBOqxZ7Jq6LnehcPjsPNoU/cuUTT7Fk8Di23zvkIaX1/aL1Q/OQ3qvPsXbP0dSp4/
 04rlH3adzeD+vltgbYTb5pVDJYqNyffhsgmkVp9amjK2nKrM33/BnmQdJgNOJVbsQXZC
 VMnD3yAvNfP8peNzWiWNi9aT0BuQ6Yvs8VJfFepe8ZyYT/nDb6IYG5TJFHfpS373rBmd
 8JUQ==
X-Gm-Message-State: AOJu0YyLE/cTZd4T1hQQBRVpDlp3hBDTeIF1BLpnxbgDtJcVaw913VVF
 ffg6ycEvSadu7zOeKcujOe9vpsx6G+tY2yk/SJWgIlBoRkEHbUwrxtFsJ7D6hMHpt/h194MYKAs
 T
X-Google-Smtp-Source: AGHT+IF3HE7lZzw7OPCFqrN9xfqABmKeU/ngzjt7BqNC2eugvPaB5L9r1Y0oa9vtw1m6xc01BJr9LA==
X-Received: by 2002:a17:902:f546:b0:1f9:ae6d:5697 with SMTP id
 d9443c01a7336-1f9ae6d5ac1mr30867165ad.35.1718830794704; 
 Wed, 19 Jun 2024 13:59:54 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f98f8f8c42sm39183765ad.162.2024.06.19.13.59.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 13:59:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/24] tcg/loongarch64: Import LASX, FP insns
Date: Wed, 19 Jun 2024 13:59:29 -0700
Message-Id: <20240619205952.235946-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619205952.235946-1-richard.henderson@linaro.org>
References: <20240619205952.235946-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-insn-defs.c.inc | 6181 +++++++++------------------
 1 file changed, 2123 insertions(+), 4058 deletions(-)

diff --git a/tcg/loongarch64/tcg-insn-defs.c.inc b/tcg/loongarch64/tcg-insn-defs.c.inc
index ee3b483b02..6bb8656fd8 100644
--- a/tcg/loongarch64/tcg-insn-defs.c.inc
+++ b/tcg/loongarch64/tcg-insn-defs.c.inc
@@ -4,11 +4,13 @@
  *
  * This file is auto-generated by genqemutcgdefs from
  * https://github.com/loongson-community/loongarch-opcodes,
- * from commit 8027da9a8157a8b47fc48ff1def292e09c5668bd.
+ * from commit 7f353fb69bd99ce6edfad7ad63948c4bb526f0bf.
  * DO NOT EDIT.
  */
 
 typedef enum {
+    OPC_MOVGR2SCR = 0x00000800,
+    OPC_MOVSCR2GR = 0x00000c00,
     OPC_CLZ_W = 0x00001400,
     OPC_CTZ_W = 0x00001c00,
     OPC_CLZ_D = 0x00002400,
@@ -38,6 +40,8 @@ typedef enum {
     OPC_SLL_D = 0x00188000,
     OPC_SRL_D = 0x00190000,
     OPC_SRA_D = 0x00198000,
+    OPC_ROTR_B = 0x001a0000,
+    OPC_ROTR_H = 0x001a8000,
     OPC_ROTR_W = 0x001b0000,
     OPC_ROTR_D = 0x001b8000,
     OPC_MUL_W = 0x001c0000,
@@ -60,12 +64,17 @@ typedef enum {
     OPC_SRLI_D = 0x00450000,
     OPC_SRAI_W = 0x00488000,
     OPC_SRAI_D = 0x00490000,
+    OPC_ROTRI_B = 0x004c2000,
+    OPC_ROTRI_H = 0x004c4000,
     OPC_ROTRI_W = 0x004c8000,
     OPC_ROTRI_D = 0x004d0000,
     OPC_BSTRINS_W = 0x00600000,
     OPC_BSTRPICK_W = 0x00608000,
     OPC_BSTRINS_D = 0x00800000,
     OPC_BSTRPICK_D = 0x00c00000,
+    OPC_FMOV_D = 0x01149800,
+    OPC_MOVGR2FR_D = 0x0114a800,
+    OPC_MOVFR2GR_D = 0x0114b800,
     OPC_SLTI = 0x02000000,
     OPC_SLTUI = 0x02400000,
     OPC_ADDI_W = 0x02800000,
@@ -74,60 +83,10 @@ typedef enum {
     OPC_ANDI = 0x03400000,
     OPC_ORI = 0x03800000,
     OPC_XORI = 0x03c00000,
-    OPC_VFMADD_S = 0x09100000,
-    OPC_VFMADD_D = 0x09200000,
-    OPC_VFMSUB_S = 0x09500000,
-    OPC_VFMSUB_D = 0x09600000,
-    OPC_VFNMADD_S = 0x09900000,
-    OPC_VFNMADD_D = 0x09a00000,
-    OPC_VFNMSUB_S = 0x09d00000,
-    OPC_VFNMSUB_D = 0x09e00000,
-    OPC_VFCMP_CAF_S = 0x0c500000,
-    OPC_VFCMP_SAF_S = 0x0c508000,
-    OPC_VFCMP_CLT_S = 0x0c510000,
-    OPC_VFCMP_SLT_S = 0x0c518000,
-    OPC_VFCMP_CEQ_S = 0x0c520000,
-    OPC_VFCMP_SEQ_S = 0x0c528000,
-    OPC_VFCMP_CLE_S = 0x0c530000,
-    OPC_VFCMP_SLE_S = 0x0c538000,
-    OPC_VFCMP_CUN_S = 0x0c540000,
-    OPC_VFCMP_SUN_S = 0x0c548000,
-    OPC_VFCMP_CULT_S = 0x0c550000,
-    OPC_VFCMP_SULT_S = 0x0c558000,
-    OPC_VFCMP_CUEQ_S = 0x0c560000,
-    OPC_VFCMP_SUEQ_S = 0x0c568000,
-    OPC_VFCMP_CULE_S = 0x0c570000,
-    OPC_VFCMP_SULE_S = 0x0c578000,
-    OPC_VFCMP_CNE_S = 0x0c580000,
-    OPC_VFCMP_SNE_S = 0x0c588000,
-    OPC_VFCMP_COR_S = 0x0c5a0000,
-    OPC_VFCMP_SOR_S = 0x0c5a8000,
-    OPC_VFCMP_CUNE_S = 0x0c5c0000,
-    OPC_VFCMP_SUNE_S = 0x0c5c8000,
-    OPC_VFCMP_CAF_D = 0x0c600000,
-    OPC_VFCMP_SAF_D = 0x0c608000,
-    OPC_VFCMP_CLT_D = 0x0c610000,
-    OPC_VFCMP_SLT_D = 0x0c618000,
-    OPC_VFCMP_CEQ_D = 0x0c620000,
-    OPC_VFCMP_SEQ_D = 0x0c628000,
-    OPC_VFCMP_CLE_D = 0x0c630000,
-    OPC_VFCMP_SLE_D = 0x0c638000,
-    OPC_VFCMP_CUN_D = 0x0c640000,
-    OPC_VFCMP_SUN_D = 0x0c648000,
-    OPC_VFCMP_CULT_D = 0x0c650000,
-    OPC_VFCMP_SULT_D = 0x0c658000,
-    OPC_VFCMP_CUEQ_D = 0x0c660000,
-    OPC_VFCMP_SUEQ_D = 0x0c668000,
-    OPC_VFCMP_CULE_D = 0x0c670000,
-    OPC_VFCMP_SULE_D = 0x0c678000,
-    OPC_VFCMP_CNE_D = 0x0c680000,
-    OPC_VFCMP_SNE_D = 0x0c688000,
-    OPC_VFCMP_COR_D = 0x0c6a0000,
-    OPC_VFCMP_SOR_D = 0x0c6a8000,
-    OPC_VFCMP_CUNE_D = 0x0c6c0000,
-    OPC_VFCMP_SUNE_D = 0x0c6c8000,
     OPC_VBITSEL_V = 0x0d100000,
+    OPC_XVBITSEL_V = 0x0d200000,
     OPC_VSHUF_B = 0x0d500000,
+    OPC_XVSHUF_B = 0x0d600000,
     OPC_ADDU16I_D = 0x10000000,
     OPC_LU12I_W = 0x14000000,
     OPC_CU32I_D = 0x16000000,
@@ -146,8 +105,14 @@ typedef enum {
     OPC_LD_BU = 0x2a000000,
     OPC_LD_HU = 0x2a400000,
     OPC_LD_WU = 0x2a800000,
+    OPC_FLD_S = 0x2b000000,
+    OPC_FST_S = 0x2b400000,
+    OPC_FLD_D = 0x2b800000,
+    OPC_FST_D = 0x2bc00000,
     OPC_VLD = 0x2c000000,
     OPC_VST = 0x2c400000,
+    OPC_XVLD = 0x2c800000,
+    OPC_XVST = 0x2cc00000,
     OPC_VLDREPL_D = 0x30100000,
     OPC_VLDREPL_W = 0x30200000,
     OPC_VLDREPL_H = 0x30400000,
@@ -156,6 +121,14 @@ typedef enum {
     OPC_VSTELM_W = 0x31200000,
     OPC_VSTELM_H = 0x31400000,
     OPC_VSTELM_B = 0x31800000,
+    OPC_XVLDREPL_D = 0x32100000,
+    OPC_XVLDREPL_W = 0x32200000,
+    OPC_XVLDREPL_H = 0x32400000,
+    OPC_XVLDREPL_B = 0x32800000,
+    OPC_XVSTELM_D = 0x33100000,
+    OPC_XVSTELM_W = 0x33200000,
+    OPC_XVSTELM_H = 0x33400000,
+    OPC_XVSTELM_B = 0x33800000,
     OPC_LDX_B = 0x38000000,
     OPC_LDX_H = 0x38040000,
     OPC_LDX_W = 0x38080000,
@@ -167,9 +140,17 @@ typedef enum {
     OPC_LDX_BU = 0x38200000,
     OPC_LDX_HU = 0x38240000,
     OPC_LDX_WU = 0x38280000,
+    OPC_FLDX_S = 0x38300000,
+    OPC_FLDX_D = 0x38340000,
+    OPC_FSTX_S = 0x38380000,
+    OPC_FSTX_D = 0x383c0000,
     OPC_VLDX = 0x38400000,
     OPC_VSTX = 0x38440000,
+    OPC_XVLDX = 0x38480000,
+    OPC_XVSTX = 0x384c0000,
     OPC_DBAR = 0x38720000,
+    OPC_JISCR0 = 0x48000200,
+    OPC_JISCR1 = 0x48000300,
     OPC_JIRL = 0x4c000000,
     OPC_B = 0x50000000,
     OPC_BL = 0x54000000,
@@ -207,46 +188,6 @@ typedef enum {
     OPC_VSUB_H = 0x700c8000,
     OPC_VSUB_W = 0x700d0000,
     OPC_VSUB_D = 0x700d8000,
-    OPC_VADDWEV_H_B = 0x701e0000,
-    OPC_VADDWEV_W_H = 0x701e8000,
-    OPC_VADDWEV_D_W = 0x701f0000,
-    OPC_VADDWEV_Q_D = 0x701f8000,
-    OPC_VSUBWEV_H_B = 0x70200000,
-    OPC_VSUBWEV_W_H = 0x70208000,
-    OPC_VSUBWEV_D_W = 0x70210000,
-    OPC_VSUBWEV_Q_D = 0x70218000,
-    OPC_VADDWOD_H_B = 0x70220000,
-    OPC_VADDWOD_W_H = 0x70228000,
-    OPC_VADDWOD_D_W = 0x70230000,
-    OPC_VADDWOD_Q_D = 0x70238000,
-    OPC_VSUBWOD_H_B = 0x70240000,
-    OPC_VSUBWOD_W_H = 0x70248000,
-    OPC_VSUBWOD_D_W = 0x70250000,
-    OPC_VSUBWOD_Q_D = 0x70258000,
-    OPC_VADDWEV_H_BU = 0x702e0000,
-    OPC_VADDWEV_W_HU = 0x702e8000,
-    OPC_VADDWEV_D_WU = 0x702f0000,
-    OPC_VADDWEV_Q_DU = 0x702f8000,
-    OPC_VSUBWEV_H_BU = 0x70300000,
-    OPC_VSUBWEV_W_HU = 0x70308000,
-    OPC_VSUBWEV_D_WU = 0x70310000,
-    OPC_VSUBWEV_Q_DU = 0x70318000,
-    OPC_VADDWOD_H_BU = 0x70320000,
-    OPC_VADDWOD_W_HU = 0x70328000,
-    OPC_VADDWOD_D_WU = 0x70330000,
-    OPC_VADDWOD_Q_DU = 0x70338000,
-    OPC_VSUBWOD_H_BU = 0x70340000,
-    OPC_VSUBWOD_W_HU = 0x70348000,
-    OPC_VSUBWOD_D_WU = 0x70350000,
-    OPC_VSUBWOD_Q_DU = 0x70358000,
-    OPC_VADDWEV_H_BU_B = 0x703e0000,
-    OPC_VADDWEV_W_HU_H = 0x703e8000,
-    OPC_VADDWEV_D_WU_W = 0x703f0000,
-    OPC_VADDWEV_Q_DU_D = 0x703f8000,
-    OPC_VADDWOD_H_BU_B = 0x70400000,
-    OPC_VADDWOD_W_HU_H = 0x70408000,
-    OPC_VADDWOD_D_WU_W = 0x70410000,
-    OPC_VADDWOD_Q_DU_D = 0x70418000,
     OPC_VSADD_B = 0x70460000,
     OPC_VSADD_H = 0x70468000,
     OPC_VSADD_W = 0x70470000,
@@ -263,50 +204,6 @@ typedef enum {
     OPC_VSSUB_HU = 0x704c8000,
     OPC_VSSUB_WU = 0x704d0000,
     OPC_VSSUB_DU = 0x704d8000,
-    OPC_VHADDW_H_B = 0x70540000,
-    OPC_VHADDW_W_H = 0x70548000,
-    OPC_VHADDW_D_W = 0x70550000,
-    OPC_VHADDW_Q_D = 0x70558000,
-    OPC_VHSUBW_H_B = 0x70560000,
-    OPC_VHSUBW_W_H = 0x70568000,
-    OPC_VHSUBW_D_W = 0x70570000,
-    OPC_VHSUBW_Q_D = 0x70578000,
-    OPC_VHADDW_HU_BU = 0x70580000,
-    OPC_VHADDW_WU_HU = 0x70588000,
-    OPC_VHADDW_DU_WU = 0x70590000,
-    OPC_VHADDW_QU_DU = 0x70598000,
-    OPC_VHSUBW_HU_BU = 0x705a0000,
-    OPC_VHSUBW_WU_HU = 0x705a8000,
-    OPC_VHSUBW_DU_WU = 0x705b0000,
-    OPC_VHSUBW_QU_DU = 0x705b8000,
-    OPC_VADDA_B = 0x705c0000,
-    OPC_VADDA_H = 0x705c8000,
-    OPC_VADDA_W = 0x705d0000,
-    OPC_VADDA_D = 0x705d8000,
-    OPC_VABSD_B = 0x70600000,
-    OPC_VABSD_H = 0x70608000,
-    OPC_VABSD_W = 0x70610000,
-    OPC_VABSD_D = 0x70618000,
-    OPC_VABSD_BU = 0x70620000,
-    OPC_VABSD_HU = 0x70628000,
-    OPC_VABSD_WU = 0x70630000,
-    OPC_VABSD_DU = 0x70638000,
-    OPC_VAVG_B = 0x70640000,
-    OPC_VAVG_H = 0x70648000,
-    OPC_VAVG_W = 0x70650000,
-    OPC_VAVG_D = 0x70658000,
-    OPC_VAVG_BU = 0x70660000,
-    OPC_VAVG_HU = 0x70668000,
-    OPC_VAVG_WU = 0x70670000,
-    OPC_VAVG_DU = 0x70678000,
-    OPC_VAVGR_B = 0x70680000,
-    OPC_VAVGR_H = 0x70688000,
-    OPC_VAVGR_W = 0x70690000,
-    OPC_VAVGR_D = 0x70698000,
-    OPC_VAVGR_BU = 0x706a0000,
-    OPC_VAVGR_HU = 0x706a8000,
-    OPC_VAVGR_WU = 0x706b0000,
-    OPC_VAVGR_DU = 0x706b8000,
     OPC_VMAX_B = 0x70700000,
     OPC_VMAX_H = 0x70708000,
     OPC_VMAX_W = 0x70710000,
@@ -327,86 +224,6 @@ typedef enum {
     OPC_VMUL_H = 0x70848000,
     OPC_VMUL_W = 0x70850000,
     OPC_VMUL_D = 0x70858000,
-    OPC_VMUH_B = 0x70860000,
-    OPC_VMUH_H = 0x70868000,
-    OPC_VMUH_W = 0x70870000,
-    OPC_VMUH_D = 0x70878000,
-    OPC_VMUH_BU = 0x70880000,
-    OPC_VMUH_HU = 0x70888000,
-    OPC_VMUH_WU = 0x70890000,
-    OPC_VMUH_DU = 0x70898000,
-    OPC_VMULWEV_H_B = 0x70900000,
-    OPC_VMULWEV_W_H = 0x70908000,
-    OPC_VMULWEV_D_W = 0x70910000,
-    OPC_VMULWEV_Q_D = 0x70918000,
-    OPC_VMULWOD_H_B = 0x70920000,
-    OPC_VMULWOD_W_H = 0x70928000,
-    OPC_VMULWOD_D_W = 0x70930000,
-    OPC_VMULWOD_Q_D = 0x70938000,
-    OPC_VMULWEV_H_BU = 0x70980000,
-    OPC_VMULWEV_W_HU = 0x70988000,
-    OPC_VMULWEV_D_WU = 0x70990000,
-    OPC_VMULWEV_Q_DU = 0x70998000,
-    OPC_VMULWOD_H_BU = 0x709a0000,
-    OPC_VMULWOD_W_HU = 0x709a8000,
-    OPC_VMULWOD_D_WU = 0x709b0000,
-    OPC_VMULWOD_Q_DU = 0x709b8000,
-    OPC_VMULWEV_H_BU_B = 0x70a00000,
-    OPC_VMULWEV_W_HU_H = 0x70a08000,
-    OPC_VMULWEV_D_WU_W = 0x70a10000,
-    OPC_VMULWEV_Q_DU_D = 0x70a18000,
-    OPC_VMULWOD_H_BU_B = 0x70a20000,
-    OPC_VMULWOD_W_HU_H = 0x70a28000,
-    OPC_VMULWOD_D_WU_W = 0x70a30000,
-    OPC_VMULWOD_Q_DU_D = 0x70a38000,
-    OPC_VMADD_B = 0x70a80000,
-    OPC_VMADD_H = 0x70a88000,
-    OPC_VMADD_W = 0x70a90000,
-    OPC_VMADD_D = 0x70a98000,
-    OPC_VMSUB_B = 0x70aa0000,
-    OPC_VMSUB_H = 0x70aa8000,
-    OPC_VMSUB_W = 0x70ab0000,
-    OPC_VMSUB_D = 0x70ab8000,
-    OPC_VMADDWEV_H_B = 0x70ac0000,
-    OPC_VMADDWEV_W_H = 0x70ac8000,
-    OPC_VMADDWEV_D_W = 0x70ad0000,
-    OPC_VMADDWEV_Q_D = 0x70ad8000,
-    OPC_VMADDWOD_H_B = 0x70ae0000,
-    OPC_VMADDWOD_W_H = 0x70ae8000,
-    OPC_VMADDWOD_D_W = 0x70af0000,
-    OPC_VMADDWOD_Q_D = 0x70af8000,
-    OPC_VMADDWEV_H_BU = 0x70b40000,
-    OPC_VMADDWEV_W_HU = 0x70b48000,
-    OPC_VMADDWEV_D_WU = 0x70b50000,
-    OPC_VMADDWEV_Q_DU = 0x70b58000,
-    OPC_VMADDWOD_H_BU = 0x70b60000,
-    OPC_VMADDWOD_W_HU = 0x70b68000,
-    OPC_VMADDWOD_D_WU = 0x70b70000,
-    OPC_VMADDWOD_Q_DU = 0x70b78000,
-    OPC_VMADDWEV_H_BU_B = 0x70bc0000,
-    OPC_VMADDWEV_W_HU_H = 0x70bc8000,
-    OPC_VMADDWEV_D_WU_W = 0x70bd0000,
-    OPC_VMADDWEV_Q_DU_D = 0x70bd8000,
-    OPC_VMADDWOD_H_BU_B = 0x70be0000,
-    OPC_VMADDWOD_W_HU_H = 0x70be8000,
-    OPC_VMADDWOD_D_WU_W = 0x70bf0000,
-    OPC_VMADDWOD_Q_DU_D = 0x70bf8000,
-    OPC_VDIV_B = 0x70e00000,
-    OPC_VDIV_H = 0x70e08000,
-    OPC_VDIV_W = 0x70e10000,
-    OPC_VDIV_D = 0x70e18000,
-    OPC_VMOD_B = 0x70e20000,
-    OPC_VMOD_H = 0x70e28000,
-    OPC_VMOD_W = 0x70e30000,
-    OPC_VMOD_D = 0x70e38000,
-    OPC_VDIV_BU = 0x70e40000,
-    OPC_VDIV_HU = 0x70e48000,
-    OPC_VDIV_WU = 0x70e50000,
-    OPC_VDIV_DU = 0x70e58000,
-    OPC_VMOD_BU = 0x70e60000,
-    OPC_VMOD_HU = 0x70e68000,
-    OPC_VMOD_WU = 0x70e70000,
-    OPC_VMOD_DU = 0x70e78000,
     OPC_VSLL_B = 0x70e80000,
     OPC_VSLL_H = 0x70e88000,
     OPC_VSLL_W = 0x70e90000,
@@ -423,86 +240,6 @@ typedef enum {
     OPC_VROTR_H = 0x70ee8000,
     OPC_VROTR_W = 0x70ef0000,
     OPC_VROTR_D = 0x70ef8000,
-    OPC_VSRLR_B = 0x70f00000,
-    OPC_VSRLR_H = 0x70f08000,
-    OPC_VSRLR_W = 0x70f10000,
-    OPC_VSRLR_D = 0x70f18000,
-    OPC_VSRAR_B = 0x70f20000,
-    OPC_VSRAR_H = 0x70f28000,
-    OPC_VSRAR_W = 0x70f30000,
-    OPC_VSRAR_D = 0x70f38000,
-    OPC_VSRLN_B_H = 0x70f48000,
-    OPC_VSRLN_H_W = 0x70f50000,
-    OPC_VSRLN_W_D = 0x70f58000,
-    OPC_VSRAN_B_H = 0x70f68000,
-    OPC_VSRAN_H_W = 0x70f70000,
-    OPC_VSRAN_W_D = 0x70f78000,
-    OPC_VSRLRN_B_H = 0x70f88000,
-    OPC_VSRLRN_H_W = 0x70f90000,
-    OPC_VSRLRN_W_D = 0x70f98000,
-    OPC_VSRARN_B_H = 0x70fa8000,
-    OPC_VSRARN_H_W = 0x70fb0000,
-    OPC_VSRARN_W_D = 0x70fb8000,
-    OPC_VSSRLN_B_H = 0x70fc8000,
-    OPC_VSSRLN_H_W = 0x70fd0000,
-    OPC_VSSRLN_W_D = 0x70fd8000,
-    OPC_VSSRAN_B_H = 0x70fe8000,
-    OPC_VSSRAN_H_W = 0x70ff0000,
-    OPC_VSSRAN_W_D = 0x70ff8000,
-    OPC_VSSRLRN_B_H = 0x71008000,
-    OPC_VSSRLRN_H_W = 0x71010000,
-    OPC_VSSRLRN_W_D = 0x71018000,
-    OPC_VSSRARN_B_H = 0x71028000,
-    OPC_VSSRARN_H_W = 0x71030000,
-    OPC_VSSRARN_W_D = 0x71038000,
-    OPC_VSSRLN_BU_H = 0x71048000,
-    OPC_VSSRLN_HU_W = 0x71050000,
-    OPC_VSSRLN_WU_D = 0x71058000,
-    OPC_VSSRAN_BU_H = 0x71068000,
-    OPC_VSSRAN_HU_W = 0x71070000,
-    OPC_VSSRAN_WU_D = 0x71078000,
-    OPC_VSSRLRN_BU_H = 0x71088000,
-    OPC_VSSRLRN_HU_W = 0x71090000,
-    OPC_VSSRLRN_WU_D = 0x71098000,
-    OPC_VSSRARN_BU_H = 0x710a8000,
-    OPC_VSSRARN_HU_W = 0x710b0000,
-    OPC_VSSRARN_WU_D = 0x710b8000,
-    OPC_VBITCLR_B = 0x710c0000,
-    OPC_VBITCLR_H = 0x710c8000,
-    OPC_VBITCLR_W = 0x710d0000,
-    OPC_VBITCLR_D = 0x710d8000,
-    OPC_VBITSET_B = 0x710e0000,
-    OPC_VBITSET_H = 0x710e8000,
-    OPC_VBITSET_W = 0x710f0000,
-    OPC_VBITSET_D = 0x710f8000,
-    OPC_VBITREV_B = 0x71100000,
-    OPC_VBITREV_H = 0x71108000,
-    OPC_VBITREV_W = 0x71110000,
-    OPC_VBITREV_D = 0x71118000,
-    OPC_VPACKEV_B = 0x71160000,
-    OPC_VPACKEV_H = 0x71168000,
-    OPC_VPACKEV_W = 0x71170000,
-    OPC_VPACKEV_D = 0x71178000,
-    OPC_VPACKOD_B = 0x71180000,
-    OPC_VPACKOD_H = 0x71188000,
-    OPC_VPACKOD_W = 0x71190000,
-    OPC_VPACKOD_D = 0x71198000,
-    OPC_VILVL_B = 0x711a0000,
-    OPC_VILVL_H = 0x711a8000,
-    OPC_VILVL_W = 0x711b0000,
-    OPC_VILVL_D = 0x711b8000,
-    OPC_VILVH_B = 0x711c0000,
-    OPC_VILVH_H = 0x711c8000,
-    OPC_VILVH_W = 0x711d0000,
-    OPC_VILVH_D = 0x711d8000,
-    OPC_VPICKEV_B = 0x711e0000,
-    OPC_VPICKEV_H = 0x711e8000,
-    OPC_VPICKEV_W = 0x711f0000,
-    OPC_VPICKEV_D = 0x711f8000,
-    OPC_VPICKOD_B = 0x71200000,
-    OPC_VPICKOD_H = 0x71208000,
-    OPC_VPICKOD_W = 0x71210000,
-    OPC_VPICKOD_D = 0x71218000,
     OPC_VREPLVE_B = 0x71220000,
     OPC_VREPLVE_H = 0x71228000,
     OPC_VREPLVE_W = 0x71230000,
@@ -513,41 +250,6 @@ typedef enum {
     OPC_VNOR_V = 0x71278000,
     OPC_VANDN_V = 0x71280000,
     OPC_VORN_V = 0x71288000,
-    OPC_VFRSTP_B = 0x712b0000,
-    OPC_VFRSTP_H = 0x712b8000,
-    OPC_VADD_Q = 0x712d0000,
-    OPC_VSUB_Q = 0x712d8000,
-    OPC_VSIGNCOV_B = 0x712e0000,
-    OPC_VSIGNCOV_H = 0x712e8000,
-    OPC_VSIGNCOV_W = 0x712f0000,
-    OPC_VSIGNCOV_D = 0x712f8000,
-    OPC_VFADD_S = 0x71308000,
-    OPC_VFADD_D = 0x71310000,
-    OPC_VFSUB_S = 0x71328000,
-    OPC_VFSUB_D = 0x71330000,
-    OPC_VFMUL_S = 0x71388000,
-    OPC_VFMUL_D = 0x71390000,
-    OPC_VFDIV_S = 0x713a8000,
-    OPC_VFDIV_D = 0x713b0000,
-    OPC_VFMAX_S = 0x713c8000,
-    OPC_VFMAX_D = 0x713d0000,
-    OPC_VFMIN_S = 0x713e8000,
-    OPC_VFMIN_D = 0x713f0000,
-    OPC_VFMAXA_S = 0x71408000,
-    OPC_VFMAXA_D = 0x71410000,
-    OPC_VFMINA_S = 0x71428000,
-    OPC_VFMINA_D = 0x71430000,
-    OPC_VFCVT_H_S = 0x71460000,
-    OPC_VFCVT_S_D = 0x71468000,
-    OPC_VFFINT_S_L = 0x71480000,
-    OPC_VFTINT_W_D = 0x71498000,
-    OPC_VFTINTRM_W_D = 0x714a0000,
-    OPC_VFTINTRP_W_D = 0x714a8000,
-    OPC_VFTINTRZ_W_D = 0x714b0000,
-    OPC_VFTINTRNE_W_D = 0x714b8000,
-    OPC_VSHUF_H = 0x717a8000,
-    OPC_VSHUF_W = 0x717b0000,
-    OPC_VSHUF_D = 0x717b8000,
     OPC_VSEQI_B = 0x72800000,
     OPC_VSEQI_H = 0x72808000,
     OPC_VSEQI_W = 0x72810000,
@@ -576,8 +278,6 @@ typedef enum {
     OPC_VSUBI_HU = 0x728c8000,
     OPC_VSUBI_WU = 0x728d0000,
     OPC_VSUBI_DU = 0x728d8000,
-    OPC_VBSLL_V = 0x728e0000,
-    OPC_VBSRL_V = 0x728e8000,
     OPC_VMAXI_B = 0x72900000,
     OPC_VMAXI_H = 0x72908000,
     OPC_VMAXI_W = 0x72910000,
@@ -594,102 +294,10 @@ typedef enum {
     OPC_VMINI_HU = 0x72968000,
     OPC_VMINI_WU = 0x72970000,
     OPC_VMINI_DU = 0x72978000,
-    OPC_VFRSTPI_B = 0x729a0000,
-    OPC_VFRSTPI_H = 0x729a8000,
-    OPC_VCLO_B = 0x729c0000,
-    OPC_VCLO_H = 0x729c0400,
-    OPC_VCLO_W = 0x729c0800,
-    OPC_VCLO_D = 0x729c0c00,
-    OPC_VCLZ_B = 0x729c1000,
-    OPC_VCLZ_H = 0x729c1400,
-    OPC_VCLZ_W = 0x729c1800,
-    OPC_VCLZ_D = 0x729c1c00,
-    OPC_VPCNT_B = 0x729c2000,
-    OPC_VPCNT_H = 0x729c2400,
-    OPC_VPCNT_W = 0x729c2800,
-    OPC_VPCNT_D = 0x729c2c00,
     OPC_VNEG_B = 0x729c3000,
     OPC_VNEG_H = 0x729c3400,
     OPC_VNEG_W = 0x729c3800,
     OPC_VNEG_D = 0x729c3c00,
-    OPC_VMSKLTZ_B = 0x729c4000,
-    OPC_VMSKLTZ_H = 0x729c4400,
-    OPC_VMSKLTZ_W = 0x729c4800,
-    OPC_VMSKLTZ_D = 0x729c4c00,
-    OPC_VMSKGEZ_B = 0x729c5000,
-    OPC_VMSKNZ_B = 0x729c6000,
-    OPC_VSETEQZ_V = 0x729c9800,
-    OPC_VSETNEZ_V = 0x729c9c00,
-    OPC_VSETANYEQZ_B = 0x729ca000,
-    OPC_VSETANYEQZ_H = 0x729ca400,
-    OPC_VSETANYEQZ_W = 0x729ca800,
-    OPC_VSETANYEQZ_D = 0x729cac00,
-    OPC_VSETALLNEZ_B = 0x729cb000,
-    OPC_VSETALLNEZ_H = 0x729cb400,
-    OPC_VSETALLNEZ_W = 0x729cb800,
-    OPC_VSETALLNEZ_D = 0x729cbc00,
-    OPC_VFLOGB_S = 0x729cc400,
-    OPC_VFLOGB_D = 0x729cc800,
-    OPC_VFCLASS_S = 0x729cd400,
-    OPC_VFCLASS_D = 0x729cd800,
-    OPC_VFSQRT_S = 0x729ce400,
-    OPC_VFSQRT_D = 0x729ce800,
-    OPC_VFRECIP_S = 0x729cf400,
-    OPC_VFRECIP_D = 0x729cf800,
-    OPC_VFRSQRT_S = 0x729d0400,
-    OPC_VFRSQRT_D = 0x729d0800,
-    OPC_VFRINT_S = 0x729d3400,
-    OPC_VFRINT_D = 0x729d3800,
-    OPC_VFRINTRM_S = 0x729d4400,
-    OPC_VFRINTRM_D = 0x729d4800,
-    OPC_VFRINTRP_S = 0x729d5400,
-    OPC_VFRINTRP_D = 0x729d5800,
-    OPC_VFRINTRZ_S = 0x729d6400,
-    OPC_VFRINTRZ_D = 0x729d6800,
-    OPC_VFRINTRNE_S = 0x729d7400,
-    OPC_VFRINTRNE_D = 0x729d7800,
-    OPC_VFCVTL_S_H = 0x729de800,
-    OPC_VFCVTH_S_H = 0x729dec00,
-    OPC_VFCVTL_D_S = 0x729df000,
-    OPC_VFCVTH_D_S = 0x729df400,
-    OPC_VFFINT_S_W = 0x729e0000,
-    OPC_VFFINT_S_WU = 0x729e0400,
-    OPC_VFFINT_D_L = 0x729e0800,
-    OPC_VFFINT_D_LU = 0x729e0c00,
-    OPC_VFFINTL_D_W = 0x729e1000,
-    OPC_VFFINTH_D_W = 0x729e1400,
-    OPC_VFTINT_W_S = 0x729e3000,
-    OPC_VFTINT_L_D = 0x729e3400,
-    OPC_VFTINTRM_W_S = 0x729e3800,
-    OPC_VFTINTRM_L_D = 0x729e3c00,
-    OPC_VFTINTRP_W_S = 0x729e4000,
-    OPC_VFTINTRP_L_D = 0x729e4400,
-    OPC_VFTINTRZ_W_S = 0x729e4800,
-    OPC_VFTINTRZ_L_D = 0x729e4c00,
-    OPC_VFTINTRNE_W_S = 0x729e5000,
-    OPC_VFTINTRNE_L_D = 0x729e5400,
-    OPC_VFTINT_WU_S = 0x729e5800,
-    OPC_VFTINT_LU_D = 0x729e5c00,
-    OPC_VFTINTRZ_WU_S = 0x729e7000,
-    OPC_VFTINTRZ_LU_D = 0x729e7400,
-    OPC_VFTINTL_L_S = 0x729e8000,
-    OPC_VFTINTH_L_S = 0x729e8400,
-    OPC_VFTINTRML_L_S = 0x729e8800,
-    OPC_VFTINTRMH_L_S = 0x729e8c00,
-    OPC_VFTINTRPL_L_S = 0x729e9000,
-    OPC_VFTINTRPH_L_S = 0x729e9400,
-    OPC_VFTINTRZL_L_S = 0x729e9800,
-    OPC_VFTINTRZH_L_S = 0x729e9c00,
-    OPC_VFTINTRNEL_L_S = 0x729ea000,
-    OPC_VFTINTRNEH_L_S = 0x729ea400,
-    OPC_VEXTH_H_B = 0x729ee000,
-    OPC_VEXTH_W_H = 0x729ee400,
-    OPC_VEXTH_D_W = 0x729ee800,
-    OPC_VEXTH_Q_D = 0x729eec00,
-    OPC_VEXTH_HU_BU = 0x729ef000,
-    OPC_VEXTH_WU_HU = 0x729ef400,
-    OPC_VEXTH_DU_WU = 0x729ef800,
-    OPC_VEXTH_QU_DU = 0x729efc00,
     OPC_VREPLGR2VR_B = 0x729f0000,
     OPC_VREPLGR2VR_H = 0x729f0400,
     OPC_VREPLGR2VR_W = 0x729f0800,
@@ -698,14 +306,6 @@ typedef enum {
     OPC_VROTRI_H = 0x72a04000,
     OPC_VROTRI_W = 0x72a08000,
     OPC_VROTRI_D = 0x72a10000,
-    OPC_VSRLRI_B = 0x72a42000,
-    OPC_VSRLRI_H = 0x72a44000,
-    OPC_VSRLRI_W = 0x72a48000,
-    OPC_VSRLRI_D = 0x72a50000,
-    OPC_VSRARI_B = 0x72a82000,
-    OPC_VSRARI_H = 0x72a84000,
-    OPC_VSRARI_W = 0x72a88000,
-    OPC_VSRARI_D = 0x72a90000,
     OPC_VINSGR2VR_B = 0x72eb8000,
     OPC_VINSGR2VR_H = 0x72ebc000,
     OPC_VINSGR2VR_W = 0x72ebe000,
@@ -722,14 +322,6 @@ typedef enum {
     OPC_VREPLVEI_H = 0x72f7c000,
     OPC_VREPLVEI_W = 0x72f7e000,
     OPC_VREPLVEI_D = 0x72f7f000,
-    OPC_VSLLWIL_H_B = 0x73082000,
-    OPC_VSLLWIL_W_H = 0x73084000,
-    OPC_VSLLWIL_D_W = 0x73088000,
-    OPC_VEXTL_Q_D = 0x73090000,
-    OPC_VSLLWIL_HU_BU = 0x730c2000,
-    OPC_VSLLWIL_WU_HU = 0x730c4000,
-    OPC_VSLLWIL_DU_WU = 0x730c8000,
-    OPC_VEXTL_QU_DU = 0x730d0000,
     OPC_VBITCLRI_B = 0x73102000,
     OPC_VBITCLRI_H = 0x73104000,
     OPC_VBITCLRI_W = 0x73108000,
@@ -742,14 +334,6 @@ typedef enum {
     OPC_VBITREVI_H = 0x73184000,
     OPC_VBITREVI_W = 0x73188000,
     OPC_VBITREVI_D = 0x73190000,
-    OPC_VSAT_B = 0x73242000,
-    OPC_VSAT_H = 0x73244000,
-    OPC_VSAT_W = 0x73248000,
-    OPC_VSAT_D = 0x73250000,
-    OPC_VSAT_BU = 0x73282000,
-    OPC_VSAT_HU = 0x73284000,
-    OPC_VSAT_WU = 0x73288000,
-    OPC_VSAT_DU = 0x73290000,
     OPC_VSLLI_B = 0x732c2000,
     OPC_VSLLI_H = 0x732c4000,
     OPC_VSLLI_W = 0x732c8000,
@@ -762,69 +346,203 @@ typedef enum {
     OPC_VSRAI_H = 0x73344000,
     OPC_VSRAI_W = 0x73348000,
     OPC_VSRAI_D = 0x73350000,
-    OPC_VSRLNI_B_H = 0x73404000,
-    OPC_VSRLNI_H_W = 0x73408000,
-    OPC_VSRLNI_W_D = 0x73410000,
-    OPC_VSRLNI_D_Q = 0x73420000,
-    OPC_VSRLRNI_B_H = 0x73444000,
-    OPC_VSRLRNI_H_W = 0x73448000,
-    OPC_VSRLRNI_W_D = 0x73450000,
-    OPC_VSRLRNI_D_Q = 0x73460000,
-    OPC_VSSRLNI_B_H = 0x73484000,
-    OPC_VSSRLNI_H_W = 0x73488000,
-    OPC_VSSRLNI_W_D = 0x73490000,
-    OPC_VSSRLNI_D_Q = 0x734a0000,
-    OPC_VSSRLNI_BU_H = 0x734c4000,
-    OPC_VSSRLNI_HU_W = 0x734c8000,
-    OPC_VSSRLNI_WU_D = 0x734d0000,
-    OPC_VSSRLNI_DU_Q = 0x734e0000,
-    OPC_VSSRLRNI_B_H = 0x73504000,
-    OPC_VSSRLRNI_H_W = 0x73508000,
-    OPC_VSSRLRNI_W_D = 0x73510000,
-    OPC_VSSRLRNI_D_Q = 0x73520000,
-    OPC_VSSRLRNI_BU_H = 0x73544000,
-    OPC_VSSRLRNI_HU_W = 0x73548000,
-    OPC_VSSRLRNI_WU_D = 0x73550000,
-    OPC_VSSRLRNI_DU_Q = 0x73560000,
-    OPC_VSRANI_B_H = 0x73584000,
-    OPC_VSRANI_H_W = 0x73588000,
-    OPC_VSRANI_W_D = 0x73590000,
-    OPC_VSRANI_D_Q = 0x735a0000,
-    OPC_VSRARNI_B_H = 0x735c4000,
-    OPC_VSRARNI_H_W = 0x735c8000,
-    OPC_VSRARNI_W_D = 0x735d0000,
-    OPC_VSRARNI_D_Q = 0x735e0000,
-    OPC_VSSRANI_B_H = 0x73604000,
-    OPC_VSSRANI_H_W = 0x73608000,
-    OPC_VSSRANI_W_D = 0x73610000,
-    OPC_VSSRANI_D_Q = 0x73620000,
-    OPC_VSSRANI_BU_H = 0x73644000,
-    OPC_VSSRANI_HU_W = 0x73648000,
-    OPC_VSSRANI_WU_D = 0x73650000,
-    OPC_VSSRANI_DU_Q = 0x73660000,
-    OPC_VSSRARNI_B_H = 0x73684000,
-    OPC_VSSRARNI_H_W = 0x73688000,
-    OPC_VSSRARNI_W_D = 0x73690000,
-    OPC_VSSRARNI_D_Q = 0x736a0000,
-    OPC_VSSRARNI_BU_H = 0x736c4000,
-    OPC_VSSRARNI_HU_W = 0x736c8000,
-    OPC_VSSRARNI_WU_D = 0x736d0000,
-    OPC_VSSRARNI_DU_Q = 0x736e0000,
-    OPC_VEXTRINS_D = 0x73800000,
-    OPC_VEXTRINS_W = 0x73840000,
-    OPC_VEXTRINS_H = 0x73880000,
-    OPC_VEXTRINS_B = 0x738c0000,
-    OPC_VSHUF4I_B = 0x73900000,
-    OPC_VSHUF4I_H = 0x73940000,
-    OPC_VSHUF4I_W = 0x73980000,
-    OPC_VSHUF4I_D = 0x739c0000,
     OPC_VBITSELI_B = 0x73c40000,
     OPC_VANDI_B = 0x73d00000,
     OPC_VORI_B = 0x73d40000,
     OPC_VXORI_B = 0x73d80000,
     OPC_VNORI_B = 0x73dc0000,
     OPC_VLDI = 0x73e00000,
-    OPC_VPERMI_W = 0x73e40000,
+    OPC_XVSEQ_B = 0x74000000,
+    OPC_XVSEQ_H = 0x74008000,
+    OPC_XVSEQ_W = 0x74010000,
+    OPC_XVSEQ_D = 0x74018000,
+    OPC_XVSLE_B = 0x74020000,
+    OPC_XVSLE_H = 0x74028000,
+    OPC_XVSLE_W = 0x74030000,
+    OPC_XVSLE_D = 0x74038000,
+    OPC_XVSLE_BU = 0x74040000,
+    OPC_XVSLE_HU = 0x74048000,
+    OPC_XVSLE_WU = 0x74050000,
+    OPC_XVSLE_DU = 0x74058000,
+    OPC_XVSLT_B = 0x74060000,
+    OPC_XVSLT_H = 0x74068000,
+    OPC_XVSLT_W = 0x74070000,
+    OPC_XVSLT_D = 0x74078000,
+    OPC_XVSLT_BU = 0x74080000,
+    OPC_XVSLT_HU = 0x74088000,
+    OPC_XVSLT_WU = 0x74090000,
+    OPC_XVSLT_DU = 0x74098000,
+    OPC_XVADD_B = 0x740a0000,
+    OPC_XVADD_H = 0x740a8000,
+    OPC_XVADD_W = 0x740b0000,
+    OPC_XVADD_D = 0x740b8000,
+    OPC_XVSUB_B = 0x740c0000,
+    OPC_XVSUB_H = 0x740c8000,
+    OPC_XVSUB_W = 0x740d0000,
+    OPC_XVSUB_D = 0x740d8000,
+    OPC_XVSADD_B = 0x74460000,
+    OPC_XVSADD_H = 0x74468000,
+    OPC_XVSADD_W = 0x74470000,
+    OPC_XVSADD_D = 0x74478000,
+    OPC_XVSSUB_B = 0x74480000,
+    OPC_XVSSUB_H = 0x74488000,
+    OPC_XVSSUB_W = 0x74490000,
+    OPC_XVSSUB_D = 0x74498000,
+    OPC_XVSADD_BU = 0x744a0000,
+    OPC_XVSADD_HU = 0x744a8000,
+    OPC_XVSADD_WU = 0x744b0000,
+    OPC_XVSADD_DU = 0x744b8000,
+    OPC_XVSSUB_BU = 0x744c0000,
+    OPC_XVSSUB_HU = 0x744c8000,
+    OPC_XVSSUB_WU = 0x744d0000,
+    OPC_XVSSUB_DU = 0x744d8000,
+    OPC_XVMAX_B = 0x74700000,
+    OPC_XVMAX_H = 0x74708000,
+    OPC_XVMAX_W = 0x74710000,
+    OPC_XVMAX_D = 0x74718000,
+    OPC_XVMIN_B = 0x74720000,
+    OPC_XVMIN_H = 0x74728000,
+    OPC_XVMIN_W = 0x74730000,
+    OPC_XVMIN_D = 0x74738000,
+    OPC_XVMAX_BU = 0x74740000,
+    OPC_XVMAX_HU = 0x74748000,
+    OPC_XVMAX_WU = 0x74750000,
+    OPC_XVMAX_DU = 0x74758000,
+    OPC_XVMIN_BU = 0x74760000,
+    OPC_XVMIN_HU = 0x74768000,
+    OPC_XVMIN_WU = 0x74770000,
+    OPC_XVMIN_DU = 0x74778000,
+    OPC_XVMUL_B = 0x74840000,
+    OPC_XVMUL_H = 0x74848000,
+    OPC_XVMUL_W = 0x74850000,
+    OPC_XVMUL_D = 0x74858000,
+    OPC_XVSLL_B = 0x74e80000,
+    OPC_XVSLL_H = 0x74e88000,
+    OPC_XVSLL_W = 0x74e90000,
+    OPC_XVSLL_D = 0x74e98000,
+    OPC_XVSRL_B = 0x74ea0000,
+    OPC_XVSRL_H = 0x74ea8000,
+    OPC_XVSRL_W = 0x74eb0000,
+    OPC_XVSRL_D = 0x74eb8000,
+    OPC_XVSRA_B = 0x74ec0000,
+    OPC_XVSRA_H = 0x74ec8000,
+    OPC_XVSRA_W = 0x74ed0000,
+    OPC_XVSRA_D = 0x74ed8000,
+    OPC_XVROTR_B = 0x74ee0000,
+    OPC_XVROTR_H = 0x74ee8000,
+    OPC_XVROTR_W = 0x74ef0000,
+    OPC_XVROTR_D = 0x74ef8000,
+    OPC_XVREPLVE_B = 0x75220000,
+    OPC_XVREPLVE_H = 0x75228000,
+    OPC_XVREPLVE_W = 0x75230000,
+    OPC_XVREPLVE_D = 0x75238000,
+    OPC_XVAND_V = 0x75260000,
+    OPC_XVOR_V = 0x75268000,
+    OPC_XVXOR_V = 0x75270000,
+    OPC_XVNOR_V = 0x75278000,
+    OPC_XVANDN_V = 0x75280000,
+    OPC_XVORN_V = 0x75288000,
+    OPC_XVSEQI_B = 0x76800000,
+    OPC_XVSEQI_H = 0x76808000,
+    OPC_XVSEQI_W = 0x76810000,
+    OPC_XVSEQI_D = 0x76818000,
+    OPC_XVSLEI_B = 0x76820000,
+    OPC_XVSLEI_H = 0x76828000,
+    OPC_XVSLEI_W = 0x76830000,
+    OPC_XVSLEI_D = 0x76838000,
+    OPC_XVSLEI_BU = 0x76840000,
+    OPC_XVSLEI_HU = 0x76848000,
+    OPC_XVSLEI_WU = 0x76850000,
+    OPC_XVSLEI_DU = 0x76858000,
+    OPC_XVSLTI_B = 0x76860000,
+    OPC_XVSLTI_H = 0x76868000,
+    OPC_XVSLTI_W = 0x76870000,
+    OPC_XVSLTI_D = 0x76878000,
+    OPC_XVSLTI_BU = 0x76880000,
+    OPC_XVSLTI_HU = 0x76888000,
+    OPC_XVSLTI_WU = 0x76890000,
+    OPC_XVSLTI_DU = 0x76898000,
+    OPC_XVADDI_BU = 0x768a0000,
+    OPC_XVADDI_HU = 0x768a8000,
+    OPC_XVADDI_WU = 0x768b0000,
+    OPC_XVADDI_DU = 0x768b8000,
+    OPC_XVSUBI_BU = 0x768c0000,
+    OPC_XVSUBI_HU = 0x768c8000,
+    OPC_XVSUBI_WU = 0x768d0000,
+    OPC_XVSUBI_DU = 0x768d8000,
+    OPC_XVMAXI_B = 0x76900000,
+    OPC_XVMAXI_H = 0x76908000,
+    OPC_XVMAXI_W = 0x76910000,
+    OPC_XVMAXI_D = 0x76918000,
+    OPC_XVMINI_B = 0x76920000,
+    OPC_XVMINI_H = 0x76928000,
+    OPC_XVMINI_W = 0x76930000,
+    OPC_XVMINI_D = 0x76938000,
+    OPC_XVMAXI_BU = 0x76940000,
+    OPC_XVMAXI_HU = 0x76948000,
+    OPC_XVMAXI_WU = 0x76950000,
+    OPC_XVMAXI_DU = 0x76958000,
+    OPC_XVMINI_BU = 0x76960000,
+    OPC_XVMINI_HU = 0x76968000,
+    OPC_XVMINI_WU = 0x76970000,
+    OPC_XVMINI_DU = 0x76978000,
+    OPC_XVNEG_B = 0x769c3000,
+    OPC_XVNEG_H = 0x769c3400,
+    OPC_XVNEG_W = 0x769c3800,
+    OPC_XVNEG_D = 0x769c3c00,
+    OPC_XVREPLGR2VR_B = 0x769f0000,
+    OPC_XVREPLGR2VR_H = 0x769f0400,
+    OPC_XVREPLGR2VR_W = 0x769f0800,
+    OPC_XVREPLGR2VR_D = 0x769f0c00,
+    OPC_XVROTRI_B = 0x76a02000,
+    OPC_XVROTRI_H = 0x76a04000,
+    OPC_XVROTRI_W = 0x76a08000,
+    OPC_XVROTRI_D = 0x76a10000,
+    OPC_XVINSGR2VR_W = 0x76ebc000,
+    OPC_XVINSGR2VR_D = 0x76ebe000,
+    OPC_XVPICKVE2GR_W = 0x76efc000,
+    OPC_XVPICKVE2GR_D = 0x76efe000,
+    OPC_XVPICKVE2GR_WU = 0x76f3c000,
+    OPC_XVPICKVE2GR_DU = 0x76f3e000,
+    OPC_XVREPL128VEI_B = 0x76f78000,
+    OPC_XVREPL128VEI_H = 0x76f7c000,
+    OPC_XVREPL128VEI_W = 0x76f7e000,
+    OPC_XVREPL128VEI_D = 0x76f7f000,
+    OPC_XVREPLVE0_B = 0x77070000,
+    OPC_XVREPLVE0_H = 0x77078000,
+    OPC_XVREPLVE0_W = 0x7707c000,
+    OPC_XVREPLVE0_D = 0x7707e000,
+    OPC_XVREPLVE0_Q = 0x7707f000,
+    OPC_XVBITCLRI_B = 0x77102000,
+    OPC_XVBITCLRI_H = 0x77104000,
+    OPC_XVBITCLRI_W = 0x77108000,
+    OPC_XVBITCLRI_D = 0x77110000,
+    OPC_XVBITSETI_B = 0x77142000,
+    OPC_XVBITSETI_H = 0x77144000,
+    OPC_XVBITSETI_W = 0x77148000,
+    OPC_XVBITSETI_D = 0x77150000,
+    OPC_XVBITREVI_B = 0x77182000,
+    OPC_XVBITREVI_H = 0x77184000,
+    OPC_XVBITREVI_W = 0x77188000,
+    OPC_XVBITREVI_D = 0x77190000,
+    OPC_XVSLLI_B = 0x772c2000,
+    OPC_XVSLLI_H = 0x772c4000,
+    OPC_XVSLLI_W = 0x772c8000,
+    OPC_XVSLLI_D = 0x772d0000,
+    OPC_XVSRLI_B = 0x77302000,
+    OPC_XVSRLI_H = 0x77304000,
+    OPC_XVSRLI_W = 0x77308000,
+    OPC_XVSRLI_D = 0x77310000,
+    OPC_XVSRAI_B = 0x77342000,
+    OPC_XVSRAI_H = 0x77344000,
+    OPC_XVSRAI_W = 0x77348000,
+    OPC_XVSRAI_D = 0x77350000,
+    OPC_XVBITSELI_B = 0x77c40000,
+    OPC_XVANDI_B = 0x77d00000,
+    OPC_XVORI_B = 0x77d40000,
+    OPC_XVXORI_B = 0x77d80000,
+    OPC_XVNORI_B = 0x77dc0000,
+    OPC_XVLDI = 0x77e00000,
 } LoongArchInsn;
 
 static int32_t __attribute__((unused))
@@ -873,11 +591,11 @@ encode_dk_slots(LoongArchInsn opc, uint32_t d, uint32_t k)
 }
 
 static int32_t __attribute__((unused))
-encode_cdvj_insn(LoongArchInsn opc, TCGReg cd, TCGReg vj)
+encode_dfj_insn(LoongArchInsn opc, TCGReg d, TCGReg fj)
 {
-    tcg_debug_assert(cd >= 0 && cd <= 0x7);
-    tcg_debug_assert(vj >= 0x20 && vj <= 0x3f);
-    return encode_dj_slots(opc, cd, vj & 0x1f);
+    tcg_debug_assert(d >= 0 && d <= 0x1f);
+    tcg_debug_assert(fj >= 0x20 && fj <= 0x3f);
+    return encode_dj_slots(opc, d, fj & 0x1f);
 }
 
 static int32_t __attribute__((unused))
@@ -924,6 +642,24 @@ encode_djuk12_insn(LoongArchInsn opc, TCGReg d, TCGReg j, uint32_t uk12)
     return encode_djk_slots(opc, d, j, uk12);
 }
 
+static int32_t __attribute__((unused))
+encode_djuk3_insn(LoongArchInsn opc, TCGReg d, TCGReg j, uint32_t uk3)
+{
+    tcg_debug_assert(d >= 0 && d <= 0x1f);
+    tcg_debug_assert(j >= 0 && j <= 0x1f);
+    tcg_debug_assert(uk3 <= 0x7);
+    return encode_djk_slots(opc, d, j, uk3);
+}
+
+static int32_t __attribute__((unused))
+encode_djuk4_insn(LoongArchInsn opc, TCGReg d, TCGReg j, uint32_t uk4)
+{
+    tcg_debug_assert(d >= 0 && d <= 0x1f);
+    tcg_debug_assert(j >= 0 && j <= 0x1f);
+    tcg_debug_assert(uk4 <= 0xf);
+    return encode_djk_slots(opc, d, j, uk4);
+}
+
 static int32_t __attribute__((unused))
 encode_djuk5_insn(LoongArchInsn opc, TCGReg d, TCGReg j, uint32_t uk5)
 {
@@ -972,6 +708,14 @@ encode_dsj20_insn(LoongArchInsn opc, TCGReg d, int32_t sj20)
     return encode_dj_slots(opc, d, sj20 & 0xfffff);
 }
 
+static int32_t __attribute__((unused))
+encode_dtj_insn(LoongArchInsn opc, TCGReg d, TCGReg tj)
+{
+    tcg_debug_assert(d >= 0 && d <= 0x1f);
+    tcg_debug_assert(tj >= 0 && tj <= 0x3);
+    return encode_dj_slots(opc, d, tj);
+}
+
 static int32_t __attribute__((unused))
 encode_dvjuk1_insn(LoongArchInsn opc, TCGReg d, TCGReg vj, uint32_t uk1)
 {
@@ -1008,6 +752,58 @@ encode_dvjuk4_insn(LoongArchInsn opc, TCGReg d, TCGReg vj, uint32_t uk4)
     return encode_djk_slots(opc, d, vj & 0x1f, uk4);
 }
 
+static int32_t __attribute__((unused))
+encode_dxjuk2_insn(LoongArchInsn opc, TCGReg d, TCGReg xj, uint32_t uk2)
+{
+    tcg_debug_assert(d >= 0 && d <= 0x1f);
+    tcg_debug_assert(xj >= 0x20 && xj <= 0x3f);
+    tcg_debug_assert(uk2 <= 0x3);
+    return encode_djk_slots(opc, d, xj & 0x1f, uk2);
+}
+
+static int32_t __attribute__((unused))
+encode_dxjuk3_insn(LoongArchInsn opc, TCGReg d, TCGReg xj, uint32_t uk3)
+{
+    tcg_debug_assert(d >= 0 && d <= 0x1f);
+    tcg_debug_assert(xj >= 0x20 && xj <= 0x3f);
+    tcg_debug_assert(uk3 <= 0x7);
+    return encode_djk_slots(opc, d, xj & 0x1f, uk3);
+}
+
+static int32_t __attribute__((unused))
+encode_fdfj_insn(LoongArchInsn opc, TCGReg fd, TCGReg fj)
+{
+    tcg_debug_assert(fd >= 0x20 && fd <= 0x3f);
+    tcg_debug_assert(fj >= 0x20 && fj <= 0x3f);
+    return encode_dj_slots(opc, fd & 0x1f, fj & 0x1f);
+}
+
+static int32_t __attribute__((unused))
+encode_fdj_insn(LoongArchInsn opc, TCGReg fd, TCGReg j)
+{
+    tcg_debug_assert(fd >= 0x20 && fd <= 0x3f);
+    tcg_debug_assert(j >= 0 && j <= 0x1f);
+    return encode_dj_slots(opc, fd & 0x1f, j);
+}
+
+static int32_t __attribute__((unused))
+encode_fdjk_insn(LoongArchInsn opc, TCGReg fd, TCGReg j, TCGReg k)
+{
+    tcg_debug_assert(fd >= 0x20 && fd <= 0x3f);
+    tcg_debug_assert(j >= 0 && j <= 0x1f);
+    tcg_debug_assert(k >= 0 && k <= 0x1f);
+    return encode_djk_slots(opc, fd & 0x1f, j, k);
+}
+
+static int32_t __attribute__((unused))
+encode_fdjsk12_insn(LoongArchInsn opc, TCGReg fd, TCGReg j, int32_t sk12)
+{
+    tcg_debug_assert(fd >= 0x20 && fd <= 0x3f);
+    tcg_debug_assert(j >= 0 && j <= 0x1f);
+    tcg_debug_assert(sk12 >= -0x800 && sk12 <= 0x7ff);
+    return encode_djk_slots(opc, fd & 0x1f, j, sk12 & 0xfff);
+}
+
 static int32_t __attribute__((unused))
 encode_sd10k16_insn(LoongArchInsn opc, int32_t sd10k16)
 {
@@ -1015,6 +811,21 @@ encode_sd10k16_insn(LoongArchInsn opc, int32_t sd10k16)
     return encode_dk_slots(opc, (sd10k16 >> 16) & 0x3ff, sd10k16 & 0xffff);
 }
 
+static int32_t __attribute__((unused))
+encode_sd5k16_insn(LoongArchInsn opc, int32_t sd5k16)
+{
+    tcg_debug_assert(sd5k16 >= -0x100000 && sd5k16 <= 0xfffff);
+    return encode_dk_slots(opc, (sd5k16 >> 16) & 0x1f, sd5k16 & 0xffff);
+}
+
+static int32_t __attribute__((unused))
+encode_tdj_insn(LoongArchInsn opc, TCGReg td, TCGReg j)
+{
+    tcg_debug_assert(td >= 0 && td <= 0x3);
+    tcg_debug_assert(j >= 0 && j <= 0x1f);
+    return encode_dj_slots(opc, td, j);
+}
+
 static int32_t __attribute__((unused))
 encode_ud15_insn(LoongArchInsn opc, uint32_t ud15)
 {
@@ -1243,15 +1054,6 @@ encode_vdvjuk6_insn(LoongArchInsn opc, TCGReg vd, TCGReg vj, uint32_t uk6)
     return encode_djk_slots(opc, vd & 0x1f, vj & 0x1f, uk6);
 }
 
-static int32_t __attribute__((unused))
-encode_vdvjuk7_insn(LoongArchInsn opc, TCGReg vd, TCGReg vj, uint32_t uk7)
-{
-    tcg_debug_assert(vd >= 0x20 && vd <= 0x3f);
-    tcg_debug_assert(vj >= 0x20 && vj <= 0x3f);
-    tcg_debug_assert(uk7 <= 0x7f);
-    return encode_djk_slots(opc, vd & 0x1f, vj & 0x1f, uk7);
-}
-
 static int32_t __attribute__((unused))
 encode_vdvjuk8_insn(LoongArchInsn opc, TCGReg vd, TCGReg vj, uint32_t uk8)
 {
@@ -1281,6 +1083,252 @@ encode_vdvjvkva_insn(LoongArchInsn opc, TCGReg vd, TCGReg vj, TCGReg vk,
     return encode_djka_slots(opc, vd & 0x1f, vj & 0x1f, vk & 0x1f, va & 0x1f);
 }
 
+static int32_t __attribute__((unused))
+encode_xdj_insn(LoongArchInsn opc, TCGReg xd, TCGReg j)
+{
+    tcg_debug_assert(xd >= 0x20 && xd <= 0x3f);
+    tcg_debug_assert(j >= 0 && j <= 0x1f);
+    return encode_dj_slots(opc, xd & 0x1f, j);
+}
+
+static int32_t __attribute__((unused))
+encode_xdjk_insn(LoongArchInsn opc, TCGReg xd, TCGReg j, TCGReg k)
+{
+    tcg_debug_assert(xd >= 0x20 && xd <= 0x3f);
+    tcg_debug_assert(j >= 0 && j <= 0x1f);
+    tcg_debug_assert(k >= 0 && k <= 0x1f);
+    return encode_djk_slots(opc, xd & 0x1f, j, k);
+}
+
+static int32_t __attribute__((unused))
+encode_xdjsk10_insn(LoongArchInsn opc, TCGReg xd, TCGReg j, int32_t sk10)
+{
+    tcg_debug_assert(xd >= 0x20 && xd <= 0x3f);
+    tcg_debug_assert(j >= 0 && j <= 0x1f);
+    tcg_debug_assert(sk10 >= -0x200 && sk10 <= 0x1ff);
+    return encode_djk_slots(opc, xd & 0x1f, j, sk10 & 0x3ff);
+}
+
+static int32_t __attribute__((unused))
+encode_xdjsk11_insn(LoongArchInsn opc, TCGReg xd, TCGReg j, int32_t sk11)
+{
+    tcg_debug_assert(xd >= 0x20 && xd <= 0x3f);
+    tcg_debug_assert(j >= 0 && j <= 0x1f);
+    tcg_debug_assert(sk11 >= -0x400 && sk11 <= 0x3ff);
+    return encode_djk_slots(opc, xd & 0x1f, j, sk11 & 0x7ff);
+}
+
+static int32_t __attribute__((unused))
+encode_xdjsk12_insn(LoongArchInsn opc, TCGReg xd, TCGReg j, int32_t sk12)
+{
+    tcg_debug_assert(xd >= 0x20 && xd <= 0x3f);
+    tcg_debug_assert(j >= 0 && j <= 0x1f);
+    tcg_debug_assert(sk12 >= -0x800 && sk12 <= 0x7ff);
+    return encode_djk_slots(opc, xd & 0x1f, j, sk12 & 0xfff);
+}
+
+static int32_t __attribute__((unused))
+encode_xdjsk8un2_insn(LoongArchInsn opc, TCGReg xd, TCGReg j, int32_t sk8,
+                      uint32_t un2)
+{
+    tcg_debug_assert(xd >= 0x20 && xd <= 0x3f);
+    tcg_debug_assert(j >= 0 && j <= 0x1f);
+    tcg_debug_assert(sk8 >= -0x80 && sk8 <= 0x7f);
+    tcg_debug_assert(un2 <= 0x3);
+    return encode_djkn_slots(opc, xd & 0x1f, j, sk8 & 0xff, un2);
+}
+
+static int32_t __attribute__((unused))
+encode_xdjsk8un3_insn(LoongArchInsn opc, TCGReg xd, TCGReg j, int32_t sk8,
+                      uint32_t un3)
+{
+    tcg_debug_assert(xd >= 0x20 && xd <= 0x3f);
+    tcg_debug_assert(j >= 0 && j <= 0x1f);
+    tcg_debug_assert(sk8 >= -0x80 && sk8 <= 0x7f);
+    tcg_debug_assert(un3 <= 0x7);
+    return encode_djkn_slots(opc, xd & 0x1f, j, sk8 & 0xff, un3);
+}
+
+static int32_t __attribute__((unused))
+encode_xdjsk8un4_insn(LoongArchInsn opc, TCGReg xd, TCGReg j, int32_t sk8,
+                      uint32_t un4)
+{
+    tcg_debug_assert(xd >= 0x20 && xd <= 0x3f);
+    tcg_debug_assert(j >= 0 && j <= 0x1f);
+    tcg_debug_assert(sk8 >= -0x80 && sk8 <= 0x7f);
+    tcg_debug_assert(un4 <= 0xf);
+    return encode_djkn_slots(opc, xd & 0x1f, j, sk8 & 0xff, un4);
+}
+
+static int32_t __attribute__((unused))
+encode_xdjsk8un5_insn(LoongArchInsn opc, TCGReg xd, TCGReg j, int32_t sk8,
+                      uint32_t un5)
+{
+    tcg_debug_assert(xd >= 0x20 && xd <= 0x3f);
+    tcg_debug_assert(j >= 0 && j <= 0x1f);
+    tcg_debug_assert(sk8 >= -0x80 && sk8 <= 0x7f);
+    tcg_debug_assert(un5 <= 0x1f);
+    return encode_djkn_slots(opc, xd & 0x1f, j, sk8 & 0xff, un5);
+}
+
+static int32_t __attribute__((unused))
+encode_xdjsk9_insn(LoongArchInsn opc, TCGReg xd, TCGReg j, int32_t sk9)
+{
+    tcg_debug_assert(xd >= 0x20 && xd <= 0x3f);
+    tcg_debug_assert(j >= 0 && j <= 0x1f);
+    tcg_debug_assert(sk9 >= -0x100 && sk9 <= 0xff);
+    return encode_djk_slots(opc, xd & 0x1f, j, sk9 & 0x1ff);
+}
+
+static int32_t __attribute__((unused))
+encode_xdjuk2_insn(LoongArchInsn opc, TCGReg xd, TCGReg j, uint32_t uk2)
+{
+    tcg_debug_assert(xd >= 0x20 && xd <= 0x3f);
+    tcg_debug_assert(j >= 0 && j <= 0x1f);
+    tcg_debug_assert(uk2 <= 0x3);
+    return encode_djk_slots(opc, xd & 0x1f, j, uk2);
+}
+
+static int32_t __attribute__((unused))
+encode_xdjuk3_insn(LoongArchInsn opc, TCGReg xd, TCGReg j, uint32_t uk3)
+{
+    tcg_debug_assert(xd >= 0x20 && xd <= 0x3f);
+    tcg_debug_assert(j >= 0 && j <= 0x1f);
+    tcg_debug_assert(uk3 <= 0x7);
+    return encode_djk_slots(opc, xd & 0x1f, j, uk3);
+}
+
+static int32_t __attribute__((unused))
+encode_xdsj13_insn(LoongArchInsn opc, TCGReg xd, int32_t sj13)
+{
+    tcg_debug_assert(xd >= 0x20 && xd <= 0x3f);
+    tcg_debug_assert(sj13 >= -0x1000 && sj13 <= 0xfff);
+    return encode_dj_slots(opc, xd & 0x1f, sj13 & 0x1fff);
+}
+
+static int32_t __attribute__((unused))
+encode_xdxj_insn(LoongArchInsn opc, TCGReg xd, TCGReg xj)
+{
+    tcg_debug_assert(xd >= 0x20 && xd <= 0x3f);
+    tcg_debug_assert(xj >= 0x20 && xj <= 0x3f);
+    return encode_dj_slots(opc, xd & 0x1f, xj & 0x1f);
+}
+
+static int32_t __attribute__((unused))
+encode_xdxjk_insn(LoongArchInsn opc, TCGReg xd, TCGReg xj, TCGReg k)
+{
+    tcg_debug_assert(xd >= 0x20 && xd <= 0x3f);
+    tcg_debug_assert(xj >= 0x20 && xj <= 0x3f);
+    tcg_debug_assert(k >= 0 && k <= 0x1f);
+    return encode_djk_slots(opc, xd & 0x1f, xj & 0x1f, k);
+}
+
+static int32_t __attribute__((unused))
+encode_xdxjsk5_insn(LoongArchInsn opc, TCGReg xd, TCGReg xj, int32_t sk5)
+{
+    tcg_debug_assert(xd >= 0x20 && xd <= 0x3f);
+    tcg_debug_assert(xj >= 0x20 && xj <= 0x3f);
+    tcg_debug_assert(sk5 >= -0x10 && sk5 <= 0xf);
+    return encode_djk_slots(opc, xd & 0x1f, xj & 0x1f, sk5 & 0x1f);
+}
+
+static int32_t __attribute__((unused))
+encode_xdxjuk1_insn(LoongArchInsn opc, TCGReg xd, TCGReg xj, uint32_t uk1)
+{
+    tcg_debug_assert(xd >= 0x20 && xd <= 0x3f);
+    tcg_debug_assert(xj >= 0x20 && xj <= 0x3f);
+    tcg_debug_assert(uk1 <= 0x1);
+    return encode_djk_slots(opc, xd & 0x1f, xj & 0x1f, uk1);
+}
+
+static int32_t __attribute__((unused))
+encode_xdxjuk2_insn(LoongArchInsn opc, TCGReg xd, TCGReg xj, uint32_t uk2)
+{
+    tcg_debug_assert(xd >= 0x20 && xd <= 0x3f);
+    tcg_debug_assert(xj >= 0x20 && xj <= 0x3f);
+    tcg_debug_assert(uk2 <= 0x3);
+    return encode_djk_slots(opc, xd & 0x1f, xj & 0x1f, uk2);
+}
+
+static int32_t __attribute__((unused))
+encode_xdxjuk3_insn(LoongArchInsn opc, TCGReg xd, TCGReg xj, uint32_t uk3)
+{
+    tcg_debug_assert(xd >= 0x20 && xd <= 0x3f);
+    tcg_debug_assert(xj >= 0x20 && xj <= 0x3f);
+    tcg_debug_assert(uk3 <= 0x7);
+    return encode_djk_slots(opc, xd & 0x1f, xj & 0x1f, uk3);
+}
+
+static int32_t __attribute__((unused))
+encode_xdxjuk4_insn(LoongArchInsn opc, TCGReg xd, TCGReg xj, uint32_t uk4)
+{
+    tcg_debug_assert(xd >= 0x20 && xd <= 0x3f);
+    tcg_debug_assert(xj >= 0x20 && xj <= 0x3f);
+    tcg_debug_assert(uk4 <= 0xf);
+    return encode_djk_slots(opc, xd & 0x1f, xj & 0x1f, uk4);
+}
+
+static int32_t __attribute__((unused))
+encode_xdxjuk5_insn(LoongArchInsn opc, TCGReg xd, TCGReg xj, uint32_t uk5)
+{
+    tcg_debug_assert(xd >= 0x20 && xd <= 0x3f);
+    tcg_debug_assert(xj >= 0x20 && xj <= 0x3f);
+    tcg_debug_assert(uk5 <= 0x1f);
+    return encode_djk_slots(opc, xd & 0x1f, xj & 0x1f, uk5);
+}
+
+static int32_t __attribute__((unused))
+encode_xdxjuk6_insn(LoongArchInsn opc, TCGReg xd, TCGReg xj, uint32_t uk6)
+{
+    tcg_debug_assert(xd >= 0x20 && xd <= 0x3f);
+    tcg_debug_assert(xj >= 0x20 && xj <= 0x3f);
+    tcg_debug_assert(uk6 <= 0x3f);
+    return encode_djk_slots(opc, xd & 0x1f, xj & 0x1f, uk6);
+}
+
+static int32_t __attribute__((unused))
+encode_xdxjuk8_insn(LoongArchInsn opc, TCGReg xd, TCGReg xj, uint32_t uk8)
+{
+    tcg_debug_assert(xd >= 0x20 && xd <= 0x3f);
+    tcg_debug_assert(xj >= 0x20 && xj <= 0x3f);
+    tcg_debug_assert(uk8 <= 0xff);
+    return encode_djk_slots(opc, xd & 0x1f, xj & 0x1f, uk8);
+}
+
+static int32_t __attribute__((unused))
+encode_xdxjxk_insn(LoongArchInsn opc, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_debug_assert(xd >= 0x20 && xd <= 0x3f);
+    tcg_debug_assert(xj >= 0x20 && xj <= 0x3f);
+    tcg_debug_assert(xk >= 0x20 && xk <= 0x3f);
+    return encode_djk_slots(opc, xd & 0x1f, xj & 0x1f, xk & 0x1f);
+}
+
+static int32_t __attribute__((unused))
+encode_xdxjxkxa_insn(LoongArchInsn opc, TCGReg xd, TCGReg xj, TCGReg xk,
+                     TCGReg xa)
+{
+    tcg_debug_assert(xd >= 0x20 && xd <= 0x3f);
+    tcg_debug_assert(xj >= 0x20 && xj <= 0x3f);
+    tcg_debug_assert(xk >= 0x20 && xk <= 0x3f);
+    tcg_debug_assert(xa >= 0x20 && xa <= 0x3f);
+    return encode_djka_slots(opc, xd & 0x1f, xj & 0x1f, xk & 0x1f, xa & 0x1f);
+}
+
+/* Emits the `movgr2scr td, j` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_movgr2scr(TCGContext *s, TCGReg td, TCGReg j)
+{
+    tcg_out32(s, encode_tdj_insn(OPC_MOVGR2SCR, td, j));
+}
+
+/* Emits the `movscr2gr d, tj` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_movscr2gr(TCGContext *s, TCGReg d, TCGReg tj)
+{
+    tcg_out32(s, encode_dtj_insn(OPC_MOVSCR2GR, d, tj));
+}
+
 /* Emits the `clz.w d, j` instruction.  */
 static void __attribute__((unused))
 tcg_out_opc_clz_w(TCGContext *s, TCGReg d, TCGReg j)
@@ -1484,6 +1532,20 @@ tcg_out_opc_sra_d(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
     tcg_out32(s, encode_djk_insn(OPC_SRA_D, d, j, k));
 }
 
+/* Emits the `rotr.b d, j, k` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_rotr_b(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+{
+    tcg_out32(s, encode_djk_insn(OPC_ROTR_B, d, j, k));
+}
+
+/* Emits the `rotr.h d, j, k` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_rotr_h(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
+{
+    tcg_out32(s, encode_djk_insn(OPC_ROTR_H, d, j, k));
+}
+
 /* Emits the `rotr.w d, j, k` instruction.  */
 static void __attribute__((unused))
 tcg_out_opc_rotr_w(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
@@ -1638,6 +1700,20 @@ tcg_out_opc_srai_d(TCGContext *s, TCGReg d, TCGReg j, uint32_t uk6)
     tcg_out32(s, encode_djuk6_insn(OPC_SRAI_D, d, j, uk6));
 }
 
+/* Emits the `rotri.b d, j, uk3` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_rotri_b(TCGContext *s, TCGReg d, TCGReg j, uint32_t uk3)
+{
+    tcg_out32(s, encode_djuk3_insn(OPC_ROTRI_B, d, j, uk3));
+}
+
+/* Emits the `rotri.h d, j, uk4` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_rotri_h(TCGContext *s, TCGReg d, TCGReg j, uint32_t uk4)
+{
+    tcg_out32(s, encode_djuk4_insn(OPC_ROTRI_H, d, j, uk4));
+}
+
 /* Emits the `rotri.w d, j, uk5` instruction.  */
 static void __attribute__((unused))
 tcg_out_opc_rotri_w(TCGContext *s, TCGReg d, TCGReg j, uint32_t uk5)
@@ -1684,6 +1760,27 @@ tcg_out_opc_bstrpick_d(TCGContext *s, TCGReg d, TCGReg j, uint32_t uk6,
     tcg_out32(s, encode_djuk6um6_insn(OPC_BSTRPICK_D, d, j, uk6, um6));
 }
 
+/* Emits the `fmov.d fd, fj` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_fmov_d(TCGContext *s, TCGReg fd, TCGReg fj)
+{
+    tcg_out32(s, encode_fdfj_insn(OPC_FMOV_D, fd, fj));
+}
+
+/* Emits the `movgr2fr.d fd, j` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_movgr2fr_d(TCGContext *s, TCGReg fd, TCGReg j)
+{
+    tcg_out32(s, encode_fdj_insn(OPC_MOVGR2FR_D, fd, j));
+}
+
+/* Emits the `movfr2gr.d d, fj` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_movfr2gr_d(TCGContext *s, TCGReg d, TCGReg fj)
+{
+    tcg_out32(s, encode_dfj_insn(OPC_MOVFR2GR_D, d, fj));
+}
+
 /* Emits the `slti d, j, sk12` instruction.  */
 static void __attribute__((unused))
 tcg_out_opc_slti(TCGContext *s, TCGReg d, TCGReg j, int32_t sk12)
@@ -1740,370 +1837,6 @@ tcg_out_opc_xori(TCGContext *s, TCGReg d, TCGReg j, uint32_t uk12)
     tcg_out32(s, encode_djuk12_insn(OPC_XORI, d, j, uk12));
 }
 
-/* Emits the `vfmadd.s vd, vj, vk, va` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfmadd_s(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk, TCGReg va)
-{
-    tcg_out32(s, encode_vdvjvkva_insn(OPC_VFMADD_S, vd, vj, vk, va));
-}
-
-/* Emits the `vfmadd.d vd, vj, vk, va` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfmadd_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk, TCGReg va)
-{
-    tcg_out32(s, encode_vdvjvkva_insn(OPC_VFMADD_D, vd, vj, vk, va));
-}
-
-/* Emits the `vfmsub.s vd, vj, vk, va` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfmsub_s(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk, TCGReg va)
-{
-    tcg_out32(s, encode_vdvjvkva_insn(OPC_VFMSUB_S, vd, vj, vk, va));
-}
-
-/* Emits the `vfmsub.d vd, vj, vk, va` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfmsub_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk, TCGReg va)
-{
-    tcg_out32(s, encode_vdvjvkva_insn(OPC_VFMSUB_D, vd, vj, vk, va));
-}
-
-/* Emits the `vfnmadd.s vd, vj, vk, va` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfnmadd_s(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk, TCGReg va)
-{
-    tcg_out32(s, encode_vdvjvkva_insn(OPC_VFNMADD_S, vd, vj, vk, va));
-}
-
-/* Emits the `vfnmadd.d vd, vj, vk, va` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfnmadd_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk, TCGReg va)
-{
-    tcg_out32(s, encode_vdvjvkva_insn(OPC_VFNMADD_D, vd, vj, vk, va));
-}
-
-/* Emits the `vfnmsub.s vd, vj, vk, va` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfnmsub_s(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk, TCGReg va)
-{
-    tcg_out32(s, encode_vdvjvkva_insn(OPC_VFNMSUB_S, vd, vj, vk, va));
-}
-
-/* Emits the `vfnmsub.d vd, vj, vk, va` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfnmsub_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk, TCGReg va)
-{
-    tcg_out32(s, encode_vdvjvkva_insn(OPC_VFNMSUB_D, vd, vj, vk, va));
-}
-
-/* Emits the `vfcmp.caf.s vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_caf_s(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_CAF_S, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.saf.s vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_saf_s(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_SAF_S, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.clt.s vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_clt_s(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_CLT_S, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.slt.s vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_slt_s(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_SLT_S, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.ceq.s vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_ceq_s(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_CEQ_S, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.seq.s vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_seq_s(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_SEQ_S, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.cle.s vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_cle_s(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_CLE_S, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.sle.s vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_sle_s(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_SLE_S, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.cun.s vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_cun_s(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_CUN_S, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.sun.s vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_sun_s(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_SUN_S, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.cult.s vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_cult_s(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_CULT_S, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.sult.s vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_sult_s(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_SULT_S, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.cueq.s vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_cueq_s(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_CUEQ_S, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.sueq.s vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_sueq_s(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_SUEQ_S, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.cule.s vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_cule_s(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_CULE_S, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.sule.s vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_sule_s(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_SULE_S, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.cne.s vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_cne_s(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_CNE_S, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.sne.s vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_sne_s(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_SNE_S, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.cor.s vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_cor_s(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_COR_S, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.sor.s vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_sor_s(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_SOR_S, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.cune.s vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_cune_s(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_CUNE_S, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.sune.s vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_sune_s(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_SUNE_S, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.caf.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_caf_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_CAF_D, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.saf.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_saf_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_SAF_D, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.clt.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_clt_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_CLT_D, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.slt.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_slt_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_SLT_D, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.ceq.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_ceq_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_CEQ_D, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.seq.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_seq_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_SEQ_D, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.cle.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_cle_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_CLE_D, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.sle.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_sle_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_SLE_D, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.cun.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_cun_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_CUN_D, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.sun.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_sun_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_SUN_D, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.cult.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_cult_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_CULT_D, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.sult.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_sult_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_SULT_D, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.cueq.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_cueq_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_CUEQ_D, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.sueq.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_sueq_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_SUEQ_D, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.cule.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_cule_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_CULE_D, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.sule.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_sule_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_SULE_D, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.cne.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_cne_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_CNE_D, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.sne.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_sne_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_SNE_D, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.cor.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_cor_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_COR_D, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.sor.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_sor_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_SOR_D, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.cune.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_cune_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_CUNE_D, vd, vj, vk));
-}
-
-/* Emits the `vfcmp.sune.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcmp_sune_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCMP_SUNE_D, vd, vj, vk));
-}
-
 /* Emits the `vbitsel.v vd, vj, vk, va` instruction.  */
 static void __attribute__((unused))
 tcg_out_opc_vbitsel_v(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk, TCGReg va)
@@ -2111,6 +1844,14 @@ tcg_out_opc_vbitsel_v(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk, TCGReg va)
     tcg_out32(s, encode_vdvjvkva_insn(OPC_VBITSEL_V, vd, vj, vk, va));
 }
 
+/* Emits the `xvbitsel.v xd, xj, xk, xa` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvbitsel_v(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk,
+                       TCGReg xa)
+{
+    tcg_out32(s, encode_xdxjxkxa_insn(OPC_XVBITSEL_V, xd, xj, xk, xa));
+}
+
 /* Emits the `vshuf.b vd, vj, vk, va` instruction.  */
 static void __attribute__((unused))
 tcg_out_opc_vshuf_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk, TCGReg va)
@@ -2118,6 +1859,13 @@ tcg_out_opc_vshuf_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk, TCGReg va)
     tcg_out32(s, encode_vdvjvkva_insn(OPC_VSHUF_B, vd, vj, vk, va));
 }
 
+/* Emits the `xvshuf.b xd, xj, xk, xa` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvshuf_b(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk, TCGReg xa)
+{
+    tcg_out32(s, encode_xdxjxkxa_insn(OPC_XVSHUF_B, xd, xj, xk, xa));
+}
+
 /* Emits the `addu16i.d d, j, sk16` instruction.  */
 static void __attribute__((unused))
 tcg_out_opc_addu16i_d(TCGContext *s, TCGReg d, TCGReg j, int32_t sk16)
@@ -2244,6 +1992,34 @@ tcg_out_opc_ld_wu(TCGContext *s, TCGReg d, TCGReg j, int32_t sk12)
     tcg_out32(s, encode_djsk12_insn(OPC_LD_WU, d, j, sk12));
 }
 
+/* Emits the `fld.s fd, j, sk12` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_fld_s(TCGContext *s, TCGReg fd, TCGReg j, int32_t sk12)
+{
+    tcg_out32(s, encode_fdjsk12_insn(OPC_FLD_S, fd, j, sk12));
+}
+
+/* Emits the `fst.s fd, j, sk12` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_fst_s(TCGContext *s, TCGReg fd, TCGReg j, int32_t sk12)
+{
+    tcg_out32(s, encode_fdjsk12_insn(OPC_FST_S, fd, j, sk12));
+}
+
+/* Emits the `fld.d fd, j, sk12` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_fld_d(TCGContext *s, TCGReg fd, TCGReg j, int32_t sk12)
+{
+    tcg_out32(s, encode_fdjsk12_insn(OPC_FLD_D, fd, j, sk12));
+}
+
+/* Emits the `fst.d fd, j, sk12` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_fst_d(TCGContext *s, TCGReg fd, TCGReg j, int32_t sk12)
+{
+    tcg_out32(s, encode_fdjsk12_insn(OPC_FST_D, fd, j, sk12));
+}
+
 /* Emits the `vld vd, j, sk12` instruction.  */
 static void __attribute__((unused))
 tcg_out_opc_vld(TCGContext *s, TCGReg vd, TCGReg j, int32_t sk12)
@@ -2258,6 +2034,20 @@ tcg_out_opc_vst(TCGContext *s, TCGReg vd, TCGReg j, int32_t sk12)
     tcg_out32(s, encode_vdjsk12_insn(OPC_VST, vd, j, sk12));
 }
 
+/* Emits the `xvld xd, j, sk12` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvld(TCGContext *s, TCGReg xd, TCGReg j, int32_t sk12)
+{
+    tcg_out32(s, encode_xdjsk12_insn(OPC_XVLD, xd, j, sk12));
+}
+
+/* Emits the `xvst xd, j, sk12` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvst(TCGContext *s, TCGReg xd, TCGReg j, int32_t sk12)
+{
+    tcg_out32(s, encode_xdjsk12_insn(OPC_XVST, xd, j, sk12));
+}
+
 /* Emits the `vldrepl.d vd, j, sk9` instruction.  */
 static void __attribute__((unused))
 tcg_out_opc_vldrepl_d(TCGContext *s, TCGReg vd, TCGReg j, int32_t sk9)
@@ -2318,6 +2108,66 @@ tcg_out_opc_vstelm_b(TCGContext *s, TCGReg vd, TCGReg j, int32_t sk8,
     tcg_out32(s, encode_vdjsk8un4_insn(OPC_VSTELM_B, vd, j, sk8, un4));
 }
 
+/* Emits the `xvldrepl.d xd, j, sk9` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvldrepl_d(TCGContext *s, TCGReg xd, TCGReg j, int32_t sk9)
+{
+    tcg_out32(s, encode_xdjsk9_insn(OPC_XVLDREPL_D, xd, j, sk9));
+}
+
+/* Emits the `xvldrepl.w xd, j, sk10` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvldrepl_w(TCGContext *s, TCGReg xd, TCGReg j, int32_t sk10)
+{
+    tcg_out32(s, encode_xdjsk10_insn(OPC_XVLDREPL_W, xd, j, sk10));
+}
+
+/* Emits the `xvldrepl.h xd, j, sk11` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvldrepl_h(TCGContext *s, TCGReg xd, TCGReg j, int32_t sk11)
+{
+    tcg_out32(s, encode_xdjsk11_insn(OPC_XVLDREPL_H, xd, j, sk11));
+}
+
+/* Emits the `xvldrepl.b xd, j, sk12` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvldrepl_b(TCGContext *s, TCGReg xd, TCGReg j, int32_t sk12)
+{
+    tcg_out32(s, encode_xdjsk12_insn(OPC_XVLDREPL_B, xd, j, sk12));
+}
+
+/* Emits the `xvstelm.d xd, j, sk8, un2` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvstelm_d(TCGContext *s, TCGReg xd, TCGReg j, int32_t sk8,
+                      uint32_t un2)
+{
+    tcg_out32(s, encode_xdjsk8un2_insn(OPC_XVSTELM_D, xd, j, sk8, un2));
+}
+
+/* Emits the `xvstelm.w xd, j, sk8, un3` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvstelm_w(TCGContext *s, TCGReg xd, TCGReg j, int32_t sk8,
+                      uint32_t un3)
+{
+    tcg_out32(s, encode_xdjsk8un3_insn(OPC_XVSTELM_W, xd, j, sk8, un3));
+}
+
+/* Emits the `xvstelm.h xd, j, sk8, un4` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvstelm_h(TCGContext *s, TCGReg xd, TCGReg j, int32_t sk8,
+                      uint32_t un4)
+{
+    tcg_out32(s, encode_xdjsk8un4_insn(OPC_XVSTELM_H, xd, j, sk8, un4));
+}
+
+/* Emits the `xvstelm.b xd, j, sk8, un5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvstelm_b(TCGContext *s, TCGReg xd, TCGReg j, int32_t sk8,
+                      uint32_t un5)
+{
+    tcg_out32(s, encode_xdjsk8un5_insn(OPC_XVSTELM_B, xd, j, sk8, un5));
+}
+
 /* Emits the `ldx.b d, j, k` instruction.  */
 static void __attribute__((unused))
 tcg_out_opc_ldx_b(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
@@ -2395,6 +2245,34 @@ tcg_out_opc_ldx_wu(TCGContext *s, TCGReg d, TCGReg j, TCGReg k)
     tcg_out32(s, encode_djk_insn(OPC_LDX_WU, d, j, k));
 }
 
+/* Emits the `fldx.s fd, j, k` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_fldx_s(TCGContext *s, TCGReg fd, TCGReg j, TCGReg k)
+{
+    tcg_out32(s, encode_fdjk_insn(OPC_FLDX_S, fd, j, k));
+}
+
+/* Emits the `fldx.d fd, j, k` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_fldx_d(TCGContext *s, TCGReg fd, TCGReg j, TCGReg k)
+{
+    tcg_out32(s, encode_fdjk_insn(OPC_FLDX_D, fd, j, k));
+}
+
+/* Emits the `fstx.s fd, j, k` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_fstx_s(TCGContext *s, TCGReg fd, TCGReg j, TCGReg k)
+{
+    tcg_out32(s, encode_fdjk_insn(OPC_FSTX_S, fd, j, k));
+}
+
+/* Emits the `fstx.d fd, j, k` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_fstx_d(TCGContext *s, TCGReg fd, TCGReg j, TCGReg k)
+{
+    tcg_out32(s, encode_fdjk_insn(OPC_FSTX_D, fd, j, k));
+}
+
 /* Emits the `vldx vd, j, k` instruction.  */
 static void __attribute__((unused))
 tcg_out_opc_vldx(TCGContext *s, TCGReg vd, TCGReg j, TCGReg k)
@@ -2409,6 +2287,20 @@ tcg_out_opc_vstx(TCGContext *s, TCGReg vd, TCGReg j, TCGReg k)
     tcg_out32(s, encode_vdjk_insn(OPC_VSTX, vd, j, k));
 }
 
+/* Emits the `xvldx xd, j, k` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvldx(TCGContext *s, TCGReg xd, TCGReg j, TCGReg k)
+{
+    tcg_out32(s, encode_xdjk_insn(OPC_XVLDX, xd, j, k));
+}
+
+/* Emits the `xvstx xd, j, k` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvstx(TCGContext *s, TCGReg xd, TCGReg j, TCGReg k)
+{
+    tcg_out32(s, encode_xdjk_insn(OPC_XVSTX, xd, j, k));
+}
+
 /* Emits the `dbar ud15` instruction.  */
 static void __attribute__((unused))
 tcg_out_opc_dbar(TCGContext *s, uint32_t ud15)
@@ -2416,6 +2308,20 @@ tcg_out_opc_dbar(TCGContext *s, uint32_t ud15)
     tcg_out32(s, encode_ud15_insn(OPC_DBAR, ud15));
 }
 
+/* Emits the `jiscr0 sd5k16` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_jiscr0(TCGContext *s, int32_t sd5k16)
+{
+    tcg_out32(s, encode_sd5k16_insn(OPC_JISCR0, sd5k16));
+}
+
+/* Emits the `jiscr1 sd5k16` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_jiscr1(TCGContext *s, int32_t sd5k16)
+{
+    tcg_out32(s, encode_sd5k16_insn(OPC_JISCR1, sd5k16));
+}
+
 /* Emits the `jirl d, j, sk16` instruction.  */
 static void __attribute__((unused))
 tcg_out_opc_jirl(TCGContext *s, TCGReg d, TCGReg j, int32_t sk16)
@@ -2675,286 +2581,6 @@ tcg_out_opc_vsub_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
     tcg_out32(s, encode_vdvjvk_insn(OPC_VSUB_D, vd, vj, vk));
 }
 
-/* Emits the `vaddwev.h.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vaddwev_h_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VADDWEV_H_B, vd, vj, vk));
-}
-
-/* Emits the `vaddwev.w.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vaddwev_w_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VADDWEV_W_H, vd, vj, vk));
-}
-
-/* Emits the `vaddwev.d.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vaddwev_d_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VADDWEV_D_W, vd, vj, vk));
-}
-
-/* Emits the `vaddwev.q.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vaddwev_q_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VADDWEV_Q_D, vd, vj, vk));
-}
-
-/* Emits the `vsubwev.h.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsubwev_h_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSUBWEV_H_B, vd, vj, vk));
-}
-
-/* Emits the `vsubwev.w.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsubwev_w_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSUBWEV_W_H, vd, vj, vk));
-}
-
-/* Emits the `vsubwev.d.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsubwev_d_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSUBWEV_D_W, vd, vj, vk));
-}
-
-/* Emits the `vsubwev.q.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsubwev_q_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSUBWEV_Q_D, vd, vj, vk));
-}
-
-/* Emits the `vaddwod.h.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vaddwod_h_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VADDWOD_H_B, vd, vj, vk));
-}
-
-/* Emits the `vaddwod.w.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vaddwod_w_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VADDWOD_W_H, vd, vj, vk));
-}
-
-/* Emits the `vaddwod.d.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vaddwod_d_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VADDWOD_D_W, vd, vj, vk));
-}
-
-/* Emits the `vaddwod.q.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vaddwod_q_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VADDWOD_Q_D, vd, vj, vk));
-}
-
-/* Emits the `vsubwod.h.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsubwod_h_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSUBWOD_H_B, vd, vj, vk));
-}
-
-/* Emits the `vsubwod.w.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsubwod_w_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSUBWOD_W_H, vd, vj, vk));
-}
-
-/* Emits the `vsubwod.d.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsubwod_d_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSUBWOD_D_W, vd, vj, vk));
-}
-
-/* Emits the `vsubwod.q.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsubwod_q_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSUBWOD_Q_D, vd, vj, vk));
-}
-
-/* Emits the `vaddwev.h.bu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vaddwev_h_bu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VADDWEV_H_BU, vd, vj, vk));
-}
-
-/* Emits the `vaddwev.w.hu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vaddwev_w_hu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VADDWEV_W_HU, vd, vj, vk));
-}
-
-/* Emits the `vaddwev.d.wu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vaddwev_d_wu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VADDWEV_D_WU, vd, vj, vk));
-}
-
-/* Emits the `vaddwev.q.du vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vaddwev_q_du(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VADDWEV_Q_DU, vd, vj, vk));
-}
-
-/* Emits the `vsubwev.h.bu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsubwev_h_bu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSUBWEV_H_BU, vd, vj, vk));
-}
-
-/* Emits the `vsubwev.w.hu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsubwev_w_hu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSUBWEV_W_HU, vd, vj, vk));
-}
-
-/* Emits the `vsubwev.d.wu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsubwev_d_wu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSUBWEV_D_WU, vd, vj, vk));
-}
-
-/* Emits the `vsubwev.q.du vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsubwev_q_du(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSUBWEV_Q_DU, vd, vj, vk));
-}
-
-/* Emits the `vaddwod.h.bu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vaddwod_h_bu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VADDWOD_H_BU, vd, vj, vk));
-}
-
-/* Emits the `vaddwod.w.hu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vaddwod_w_hu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VADDWOD_W_HU, vd, vj, vk));
-}
-
-/* Emits the `vaddwod.d.wu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vaddwod_d_wu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VADDWOD_D_WU, vd, vj, vk));
-}
-
-/* Emits the `vaddwod.q.du vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vaddwod_q_du(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VADDWOD_Q_DU, vd, vj, vk));
-}
-
-/* Emits the `vsubwod.h.bu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsubwod_h_bu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSUBWOD_H_BU, vd, vj, vk));
-}
-
-/* Emits the `vsubwod.w.hu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsubwod_w_hu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSUBWOD_W_HU, vd, vj, vk));
-}
-
-/* Emits the `vsubwod.d.wu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsubwod_d_wu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSUBWOD_D_WU, vd, vj, vk));
-}
-
-/* Emits the `vsubwod.q.du vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsubwod_q_du(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSUBWOD_Q_DU, vd, vj, vk));
-}
-
-/* Emits the `vaddwev.h.bu.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vaddwev_h_bu_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VADDWEV_H_BU_B, vd, vj, vk));
-}
-
-/* Emits the `vaddwev.w.hu.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vaddwev_w_hu_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VADDWEV_W_HU_H, vd, vj, vk));
-}
-
-/* Emits the `vaddwev.d.wu.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vaddwev_d_wu_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VADDWEV_D_WU_W, vd, vj, vk));
-}
-
-/* Emits the `vaddwev.q.du.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vaddwev_q_du_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VADDWEV_Q_DU_D, vd, vj, vk));
-}
-
-/* Emits the `vaddwod.h.bu.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vaddwod_h_bu_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VADDWOD_H_BU_B, vd, vj, vk));
-}
-
-/* Emits the `vaddwod.w.hu.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vaddwod_w_hu_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VADDWOD_W_HU_H, vd, vj, vk));
-}
-
-/* Emits the `vaddwod.d.wu.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vaddwod_d_wu_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VADDWOD_D_WU_W, vd, vj, vk));
-}
-
-/* Emits the `vaddwod.q.du.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vaddwod_q_du_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VADDWOD_Q_DU_D, vd, vj, vk));
-}
-
 /* Emits the `vsadd.b vd, vj, vk` instruction.  */
 static void __attribute__((unused))
 tcg_out_opc_vsadd_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
@@ -3067,314 +2693,6 @@ tcg_out_opc_vssub_du(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
     tcg_out32(s, encode_vdvjvk_insn(OPC_VSSUB_DU, vd, vj, vk));
 }
 
-/* Emits the `vhaddw.h.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vhaddw_h_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VHADDW_H_B, vd, vj, vk));
-}
-
-/* Emits the `vhaddw.w.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vhaddw_w_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VHADDW_W_H, vd, vj, vk));
-}
-
-/* Emits the `vhaddw.d.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vhaddw_d_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VHADDW_D_W, vd, vj, vk));
-}
-
-/* Emits the `vhaddw.q.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vhaddw_q_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VHADDW_Q_D, vd, vj, vk));
-}
-
-/* Emits the `vhsubw.h.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vhsubw_h_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VHSUBW_H_B, vd, vj, vk));
-}
-
-/* Emits the `vhsubw.w.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vhsubw_w_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VHSUBW_W_H, vd, vj, vk));
-}
-
-/* Emits the `vhsubw.d.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vhsubw_d_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VHSUBW_D_W, vd, vj, vk));
-}
-
-/* Emits the `vhsubw.q.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vhsubw_q_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VHSUBW_Q_D, vd, vj, vk));
-}
-
-/* Emits the `vhaddw.hu.bu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vhaddw_hu_bu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VHADDW_HU_BU, vd, vj, vk));
-}
-
-/* Emits the `vhaddw.wu.hu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vhaddw_wu_hu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VHADDW_WU_HU, vd, vj, vk));
-}
-
-/* Emits the `vhaddw.du.wu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vhaddw_du_wu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VHADDW_DU_WU, vd, vj, vk));
-}
-
-/* Emits the `vhaddw.qu.du vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vhaddw_qu_du(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VHADDW_QU_DU, vd, vj, vk));
-}
-
-/* Emits the `vhsubw.hu.bu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vhsubw_hu_bu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VHSUBW_HU_BU, vd, vj, vk));
-}
-
-/* Emits the `vhsubw.wu.hu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vhsubw_wu_hu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VHSUBW_WU_HU, vd, vj, vk));
-}
-
-/* Emits the `vhsubw.du.wu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vhsubw_du_wu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VHSUBW_DU_WU, vd, vj, vk));
-}
-
-/* Emits the `vhsubw.qu.du vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vhsubw_qu_du(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VHSUBW_QU_DU, vd, vj, vk));
-}
-
-/* Emits the `vadda.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vadda_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VADDA_B, vd, vj, vk));
-}
-
-/* Emits the `vadda.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vadda_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VADDA_H, vd, vj, vk));
-}
-
-/* Emits the `vadda.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vadda_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VADDA_W, vd, vj, vk));
-}
-
-/* Emits the `vadda.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vadda_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VADDA_D, vd, vj, vk));
-}
-
-/* Emits the `vabsd.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vabsd_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VABSD_B, vd, vj, vk));
-}
-
-/* Emits the `vabsd.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vabsd_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VABSD_H, vd, vj, vk));
-}
-
-/* Emits the `vabsd.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vabsd_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VABSD_W, vd, vj, vk));
-}
-
-/* Emits the `vabsd.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vabsd_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VABSD_D, vd, vj, vk));
-}
-
-/* Emits the `vabsd.bu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vabsd_bu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VABSD_BU, vd, vj, vk));
-}
-
-/* Emits the `vabsd.hu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vabsd_hu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VABSD_HU, vd, vj, vk));
-}
-
-/* Emits the `vabsd.wu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vabsd_wu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VABSD_WU, vd, vj, vk));
-}
-
-/* Emits the `vabsd.du vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vabsd_du(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VABSD_DU, vd, vj, vk));
-}
-
-/* Emits the `vavg.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vavg_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VAVG_B, vd, vj, vk));
-}
-
-/* Emits the `vavg.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vavg_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VAVG_H, vd, vj, vk));
-}
-
-/* Emits the `vavg.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vavg_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VAVG_W, vd, vj, vk));
-}
-
-/* Emits the `vavg.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vavg_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VAVG_D, vd, vj, vk));
-}
-
-/* Emits the `vavg.bu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vavg_bu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VAVG_BU, vd, vj, vk));
-}
-
-/* Emits the `vavg.hu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vavg_hu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VAVG_HU, vd, vj, vk));
-}
-
-/* Emits the `vavg.wu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vavg_wu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VAVG_WU, vd, vj, vk));
-}
-
-/* Emits the `vavg.du vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vavg_du(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VAVG_DU, vd, vj, vk));
-}
-
-/* Emits the `vavgr.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vavgr_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VAVGR_B, vd, vj, vk));
-}
-
-/* Emits the `vavgr.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vavgr_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VAVGR_H, vd, vj, vk));
-}
-
-/* Emits the `vavgr.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vavgr_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VAVGR_W, vd, vj, vk));
-}
-
-/* Emits the `vavgr.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vavgr_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VAVGR_D, vd, vj, vk));
-}
-
-/* Emits the `vavgr.bu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vavgr_bu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VAVGR_BU, vd, vj, vk));
-}
-
-/* Emits the `vavgr.hu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vavgr_hu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VAVGR_HU, vd, vj, vk));
-}
-
-/* Emits the `vavgr.wu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vavgr_wu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VAVGR_WU, vd, vj, vk));
-}
-
-/* Emits the `vavgr.du vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vavgr_du(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VAVGR_DU, vd, vj, vk));
-}
-
 /* Emits the `vmax.b vd, vj, vk` instruction.  */
 static void __attribute__((unused))
 tcg_out_opc_vmax_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
@@ -3515,566 +2833,6 @@ tcg_out_opc_vmul_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
     tcg_out32(s, encode_vdvjvk_insn(OPC_VMUL_D, vd, vj, vk));
 }
 
-/* Emits the `vmuh.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmuh_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMUH_B, vd, vj, vk));
-}
-
-/* Emits the `vmuh.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmuh_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMUH_H, vd, vj, vk));
-}
-
-/* Emits the `vmuh.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmuh_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMUH_W, vd, vj, vk));
-}
-
-/* Emits the `vmuh.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmuh_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMUH_D, vd, vj, vk));
-}
-
-/* Emits the `vmuh.bu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmuh_bu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMUH_BU, vd, vj, vk));
-}
-
-/* Emits the `vmuh.hu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmuh_hu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMUH_HU, vd, vj, vk));
-}
-
-/* Emits the `vmuh.wu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmuh_wu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMUH_WU, vd, vj, vk));
-}
-
-/* Emits the `vmuh.du vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmuh_du(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMUH_DU, vd, vj, vk));
-}
-
-/* Emits the `vmulwev.h.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmulwev_h_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMULWEV_H_B, vd, vj, vk));
-}
-
-/* Emits the `vmulwev.w.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmulwev_w_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMULWEV_W_H, vd, vj, vk));
-}
-
-/* Emits the `vmulwev.d.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmulwev_d_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMULWEV_D_W, vd, vj, vk));
-}
-
-/* Emits the `vmulwev.q.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmulwev_q_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMULWEV_Q_D, vd, vj, vk));
-}
-
-/* Emits the `vmulwod.h.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmulwod_h_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMULWOD_H_B, vd, vj, vk));
-}
-
-/* Emits the `vmulwod.w.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmulwod_w_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMULWOD_W_H, vd, vj, vk));
-}
-
-/* Emits the `vmulwod.d.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmulwod_d_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMULWOD_D_W, vd, vj, vk));
-}
-
-/* Emits the `vmulwod.q.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmulwod_q_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMULWOD_Q_D, vd, vj, vk));
-}
-
-/* Emits the `vmulwev.h.bu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmulwev_h_bu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMULWEV_H_BU, vd, vj, vk));
-}
-
-/* Emits the `vmulwev.w.hu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmulwev_w_hu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMULWEV_W_HU, vd, vj, vk));
-}
-
-/* Emits the `vmulwev.d.wu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmulwev_d_wu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMULWEV_D_WU, vd, vj, vk));
-}
-
-/* Emits the `vmulwev.q.du vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmulwev_q_du(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMULWEV_Q_DU, vd, vj, vk));
-}
-
-/* Emits the `vmulwod.h.bu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmulwod_h_bu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMULWOD_H_BU, vd, vj, vk));
-}
-
-/* Emits the `vmulwod.w.hu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmulwod_w_hu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMULWOD_W_HU, vd, vj, vk));
-}
-
-/* Emits the `vmulwod.d.wu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmulwod_d_wu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMULWOD_D_WU, vd, vj, vk));
-}
-
-/* Emits the `vmulwod.q.du vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmulwod_q_du(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMULWOD_Q_DU, vd, vj, vk));
-}
-
-/* Emits the `vmulwev.h.bu.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmulwev_h_bu_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMULWEV_H_BU_B, vd, vj, vk));
-}
-
-/* Emits the `vmulwev.w.hu.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmulwev_w_hu_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMULWEV_W_HU_H, vd, vj, vk));
-}
-
-/* Emits the `vmulwev.d.wu.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmulwev_d_wu_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMULWEV_D_WU_W, vd, vj, vk));
-}
-
-/* Emits the `vmulwev.q.du.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmulwev_q_du_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMULWEV_Q_DU_D, vd, vj, vk));
-}
-
-/* Emits the `vmulwod.h.bu.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmulwod_h_bu_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMULWOD_H_BU_B, vd, vj, vk));
-}
-
-/* Emits the `vmulwod.w.hu.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmulwod_w_hu_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMULWOD_W_HU_H, vd, vj, vk));
-}
-
-/* Emits the `vmulwod.d.wu.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmulwod_d_wu_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMULWOD_D_WU_W, vd, vj, vk));
-}
-
-/* Emits the `vmulwod.q.du.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmulwod_q_du_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMULWOD_Q_DU_D, vd, vj, vk));
-}
-
-/* Emits the `vmadd.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmadd_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMADD_B, vd, vj, vk));
-}
-
-/* Emits the `vmadd.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmadd_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMADD_H, vd, vj, vk));
-}
-
-/* Emits the `vmadd.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmadd_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMADD_W, vd, vj, vk));
-}
-
-/* Emits the `vmadd.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmadd_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMADD_D, vd, vj, vk));
-}
-
-/* Emits the `vmsub.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmsub_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMSUB_B, vd, vj, vk));
-}
-
-/* Emits the `vmsub.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmsub_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMSUB_H, vd, vj, vk));
-}
-
-/* Emits the `vmsub.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmsub_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMSUB_W, vd, vj, vk));
-}
-
-/* Emits the `vmsub.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmsub_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMSUB_D, vd, vj, vk));
-}
-
-/* Emits the `vmaddwev.h.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmaddwev_h_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMADDWEV_H_B, vd, vj, vk));
-}
-
-/* Emits the `vmaddwev.w.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmaddwev_w_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMADDWEV_W_H, vd, vj, vk));
-}
-
-/* Emits the `vmaddwev.d.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmaddwev_d_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMADDWEV_D_W, vd, vj, vk));
-}
-
-/* Emits the `vmaddwev.q.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmaddwev_q_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMADDWEV_Q_D, vd, vj, vk));
-}
-
-/* Emits the `vmaddwod.h.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmaddwod_h_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMADDWOD_H_B, vd, vj, vk));
-}
-
-/* Emits the `vmaddwod.w.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmaddwod_w_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMADDWOD_W_H, vd, vj, vk));
-}
-
-/* Emits the `vmaddwod.d.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmaddwod_d_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMADDWOD_D_W, vd, vj, vk));
-}
-
-/* Emits the `vmaddwod.q.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmaddwod_q_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMADDWOD_Q_D, vd, vj, vk));
-}
-
-/* Emits the `vmaddwev.h.bu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmaddwev_h_bu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMADDWEV_H_BU, vd, vj, vk));
-}
-
-/* Emits the `vmaddwev.w.hu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmaddwev_w_hu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMADDWEV_W_HU, vd, vj, vk));
-}
-
-/* Emits the `vmaddwev.d.wu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmaddwev_d_wu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMADDWEV_D_WU, vd, vj, vk));
-}
-
-/* Emits the `vmaddwev.q.du vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmaddwev_q_du(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMADDWEV_Q_DU, vd, vj, vk));
-}
-
-/* Emits the `vmaddwod.h.bu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmaddwod_h_bu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMADDWOD_H_BU, vd, vj, vk));
-}
-
-/* Emits the `vmaddwod.w.hu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmaddwod_w_hu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMADDWOD_W_HU, vd, vj, vk));
-}
-
-/* Emits the `vmaddwod.d.wu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmaddwod_d_wu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMADDWOD_D_WU, vd, vj, vk));
-}
-
-/* Emits the `vmaddwod.q.du vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmaddwod_q_du(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMADDWOD_Q_DU, vd, vj, vk));
-}
-
-/* Emits the `vmaddwev.h.bu.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmaddwev_h_bu_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMADDWEV_H_BU_B, vd, vj, vk));
-}
-
-/* Emits the `vmaddwev.w.hu.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmaddwev_w_hu_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMADDWEV_W_HU_H, vd, vj, vk));
-}
-
-/* Emits the `vmaddwev.d.wu.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmaddwev_d_wu_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMADDWEV_D_WU_W, vd, vj, vk));
-}
-
-/* Emits the `vmaddwev.q.du.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmaddwev_q_du_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMADDWEV_Q_DU_D, vd, vj, vk));
-}
-
-/* Emits the `vmaddwod.h.bu.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmaddwod_h_bu_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMADDWOD_H_BU_B, vd, vj, vk));
-}
-
-/* Emits the `vmaddwod.w.hu.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmaddwod_w_hu_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMADDWOD_W_HU_H, vd, vj, vk));
-}
-
-/* Emits the `vmaddwod.d.wu.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmaddwod_d_wu_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMADDWOD_D_WU_W, vd, vj, vk));
-}
-
-/* Emits the `vmaddwod.q.du.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmaddwod_q_du_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMADDWOD_Q_DU_D, vd, vj, vk));
-}
-
-/* Emits the `vdiv.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vdiv_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VDIV_B, vd, vj, vk));
-}
-
-/* Emits the `vdiv.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vdiv_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VDIV_H, vd, vj, vk));
-}
-
-/* Emits the `vdiv.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vdiv_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VDIV_W, vd, vj, vk));
-}
-
-/* Emits the `vdiv.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vdiv_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VDIV_D, vd, vj, vk));
-}
-
-/* Emits the `vmod.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmod_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMOD_B, vd, vj, vk));
-}
-
-/* Emits the `vmod.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmod_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMOD_H, vd, vj, vk));
-}
-
-/* Emits the `vmod.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmod_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMOD_W, vd, vj, vk));
-}
-
-/* Emits the `vmod.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmod_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMOD_D, vd, vj, vk));
-}
-
-/* Emits the `vdiv.bu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vdiv_bu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VDIV_BU, vd, vj, vk));
-}
-
-/* Emits the `vdiv.hu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vdiv_hu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VDIV_HU, vd, vj, vk));
-}
-
-/* Emits the `vdiv.wu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vdiv_wu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VDIV_WU, vd, vj, vk));
-}
-
-/* Emits the `vdiv.du vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vdiv_du(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VDIV_DU, vd, vj, vk));
-}
-
-/* Emits the `vmod.bu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmod_bu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMOD_BU, vd, vj, vk));
-}
-
-/* Emits the `vmod.hu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmod_hu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMOD_HU, vd, vj, vk));
-}
-
-/* Emits the `vmod.wu vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmod_wu(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMOD_WU, vd, vj, vk));
-}
-
-/* Emits the `vmod.du vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmod_du(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VMOD_DU, vd, vj, vk));
-}
-
 /* Emits the `vsll.b vd, vj, vk` instruction.  */
 static void __attribute__((unused))
 tcg_out_opc_vsll_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
@@ -4187,566 +2945,6 @@ tcg_out_opc_vrotr_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
     tcg_out32(s, encode_vdvjvk_insn(OPC_VROTR_D, vd, vj, vk));
 }
 
-/* Emits the `vsrlr.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrlr_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSRLR_B, vd, vj, vk));
-}
-
-/* Emits the `vsrlr.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrlr_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSRLR_H, vd, vj, vk));
-}
-
-/* Emits the `vsrlr.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrlr_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSRLR_W, vd, vj, vk));
-}
-
-/* Emits the `vsrlr.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrlr_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSRLR_D, vd, vj, vk));
-}
-
-/* Emits the `vsrar.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrar_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSRAR_B, vd, vj, vk));
-}
-
-/* Emits the `vsrar.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrar_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSRAR_H, vd, vj, vk));
-}
-
-/* Emits the `vsrar.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrar_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSRAR_W, vd, vj, vk));
-}
-
-/* Emits the `vsrar.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrar_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSRAR_D, vd, vj, vk));
-}
-
-/* Emits the `vsrln.b.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrln_b_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSRLN_B_H, vd, vj, vk));
-}
-
-/* Emits the `vsrln.h.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrln_h_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSRLN_H_W, vd, vj, vk));
-}
-
-/* Emits the `vsrln.w.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrln_w_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSRLN_W_D, vd, vj, vk));
-}
-
-/* Emits the `vsran.b.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsran_b_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSRAN_B_H, vd, vj, vk));
-}
-
-/* Emits the `vsran.h.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsran_h_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSRAN_H_W, vd, vj, vk));
-}
-
-/* Emits the `vsran.w.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsran_w_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSRAN_W_D, vd, vj, vk));
-}
-
-/* Emits the `vsrlrn.b.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrlrn_b_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSRLRN_B_H, vd, vj, vk));
-}
-
-/* Emits the `vsrlrn.h.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrlrn_h_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSRLRN_H_W, vd, vj, vk));
-}
-
-/* Emits the `vsrlrn.w.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrlrn_w_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSRLRN_W_D, vd, vj, vk));
-}
-
-/* Emits the `vsrarn.b.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrarn_b_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSRARN_B_H, vd, vj, vk));
-}
-
-/* Emits the `vsrarn.h.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrarn_h_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSRARN_H_W, vd, vj, vk));
-}
-
-/* Emits the `vsrarn.w.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrarn_w_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSRARN_W_D, vd, vj, vk));
-}
-
-/* Emits the `vssrln.b.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrln_b_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSSRLN_B_H, vd, vj, vk));
-}
-
-/* Emits the `vssrln.h.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrln_h_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSSRLN_H_W, vd, vj, vk));
-}
-
-/* Emits the `vssrln.w.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrln_w_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSSRLN_W_D, vd, vj, vk));
-}
-
-/* Emits the `vssran.b.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssran_b_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSSRAN_B_H, vd, vj, vk));
-}
-
-/* Emits the `vssran.h.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssran_h_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSSRAN_H_W, vd, vj, vk));
-}
-
-/* Emits the `vssran.w.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssran_w_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSSRAN_W_D, vd, vj, vk));
-}
-
-/* Emits the `vssrlrn.b.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrlrn_b_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSSRLRN_B_H, vd, vj, vk));
-}
-
-/* Emits the `vssrlrn.h.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrlrn_h_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSSRLRN_H_W, vd, vj, vk));
-}
-
-/* Emits the `vssrlrn.w.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrlrn_w_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSSRLRN_W_D, vd, vj, vk));
-}
-
-/* Emits the `vssrarn.b.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrarn_b_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSSRARN_B_H, vd, vj, vk));
-}
-
-/* Emits the `vssrarn.h.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrarn_h_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSSRARN_H_W, vd, vj, vk));
-}
-
-/* Emits the `vssrarn.w.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrarn_w_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSSRARN_W_D, vd, vj, vk));
-}
-
-/* Emits the `vssrln.bu.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrln_bu_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSSRLN_BU_H, vd, vj, vk));
-}
-
-/* Emits the `vssrln.hu.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrln_hu_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSSRLN_HU_W, vd, vj, vk));
-}
-
-/* Emits the `vssrln.wu.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrln_wu_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSSRLN_WU_D, vd, vj, vk));
-}
-
-/* Emits the `vssran.bu.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssran_bu_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSSRAN_BU_H, vd, vj, vk));
-}
-
-/* Emits the `vssran.hu.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssran_hu_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSSRAN_HU_W, vd, vj, vk));
-}
-
-/* Emits the `vssran.wu.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssran_wu_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSSRAN_WU_D, vd, vj, vk));
-}
-
-/* Emits the `vssrlrn.bu.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrlrn_bu_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSSRLRN_BU_H, vd, vj, vk));
-}
-
-/* Emits the `vssrlrn.hu.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrlrn_hu_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSSRLRN_HU_W, vd, vj, vk));
-}
-
-/* Emits the `vssrlrn.wu.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrlrn_wu_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSSRLRN_WU_D, vd, vj, vk));
-}
-
-/* Emits the `vssrarn.bu.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrarn_bu_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSSRARN_BU_H, vd, vj, vk));
-}
-
-/* Emits the `vssrarn.hu.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrarn_hu_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSSRARN_HU_W, vd, vj, vk));
-}
-
-/* Emits the `vssrarn.wu.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrarn_wu_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSSRARN_WU_D, vd, vj, vk));
-}
-
-/* Emits the `vbitclr.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vbitclr_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VBITCLR_B, vd, vj, vk));
-}
-
-/* Emits the `vbitclr.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vbitclr_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VBITCLR_H, vd, vj, vk));
-}
-
-/* Emits the `vbitclr.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vbitclr_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VBITCLR_W, vd, vj, vk));
-}
-
-/* Emits the `vbitclr.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vbitclr_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VBITCLR_D, vd, vj, vk));
-}
-
-/* Emits the `vbitset.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vbitset_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VBITSET_B, vd, vj, vk));
-}
-
-/* Emits the `vbitset.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vbitset_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VBITSET_H, vd, vj, vk));
-}
-
-/* Emits the `vbitset.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vbitset_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VBITSET_W, vd, vj, vk));
-}
-
-/* Emits the `vbitset.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vbitset_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VBITSET_D, vd, vj, vk));
-}
-
-/* Emits the `vbitrev.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vbitrev_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VBITREV_B, vd, vj, vk));
-}
-
-/* Emits the `vbitrev.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vbitrev_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VBITREV_H, vd, vj, vk));
-}
-
-/* Emits the `vbitrev.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vbitrev_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VBITREV_W, vd, vj, vk));
-}
-
-/* Emits the `vbitrev.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vbitrev_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VBITREV_D, vd, vj, vk));
-}
-
-/* Emits the `vpackev.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vpackev_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VPACKEV_B, vd, vj, vk));
-}
-
-/* Emits the `vpackev.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vpackev_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VPACKEV_H, vd, vj, vk));
-}
-
-/* Emits the `vpackev.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vpackev_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VPACKEV_W, vd, vj, vk));
-}
-
-/* Emits the `vpackev.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vpackev_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VPACKEV_D, vd, vj, vk));
-}
-
-/* Emits the `vpackod.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vpackod_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VPACKOD_B, vd, vj, vk));
-}
-
-/* Emits the `vpackod.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vpackod_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VPACKOD_H, vd, vj, vk));
-}
-
-/* Emits the `vpackod.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vpackod_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VPACKOD_W, vd, vj, vk));
-}
-
-/* Emits the `vpackod.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vpackod_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VPACKOD_D, vd, vj, vk));
-}
-
-/* Emits the `vilvl.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vilvl_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VILVL_B, vd, vj, vk));
-}
-
-/* Emits the `vilvl.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vilvl_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VILVL_H, vd, vj, vk));
-}
-
-/* Emits the `vilvl.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vilvl_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VILVL_W, vd, vj, vk));
-}
-
-/* Emits the `vilvl.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vilvl_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VILVL_D, vd, vj, vk));
-}
-
-/* Emits the `vilvh.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vilvh_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VILVH_B, vd, vj, vk));
-}
-
-/* Emits the `vilvh.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vilvh_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VILVH_H, vd, vj, vk));
-}
-
-/* Emits the `vilvh.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vilvh_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VILVH_W, vd, vj, vk));
-}
-
-/* Emits the `vilvh.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vilvh_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VILVH_D, vd, vj, vk));
-}
-
-/* Emits the `vpickev.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vpickev_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VPICKEV_B, vd, vj, vk));
-}
-
-/* Emits the `vpickev.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vpickev_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VPICKEV_H, vd, vj, vk));
-}
-
-/* Emits the `vpickev.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vpickev_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VPICKEV_W, vd, vj, vk));
-}
-
-/* Emits the `vpickev.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vpickev_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VPICKEV_D, vd, vj, vk));
-}
-
-/* Emits the `vpickod.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vpickod_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VPICKOD_B, vd, vj, vk));
-}
-
-/* Emits the `vpickod.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vpickod_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VPICKOD_H, vd, vj, vk));
-}
-
-/* Emits the `vpickod.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vpickod_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VPICKOD_W, vd, vj, vk));
-}
-
-/* Emits the `vpickod.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vpickod_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VPICKOD_D, vd, vj, vk));
-}
-
 /* Emits the `vreplve.b vd, vj, k` instruction.  */
 static void __attribute__((unused))
 tcg_out_opc_vreplve_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg k)
@@ -4817,251 +3015,6 @@ tcg_out_opc_vorn_v(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
     tcg_out32(s, encode_vdvjvk_insn(OPC_VORN_V, vd, vj, vk));
 }
 
-/* Emits the `vfrstp.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfrstp_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFRSTP_B, vd, vj, vk));
-}
-
-/* Emits the `vfrstp.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfrstp_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFRSTP_H, vd, vj, vk));
-}
-
-/* Emits the `vadd.q vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vadd_q(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VADD_Q, vd, vj, vk));
-}
-
-/* Emits the `vsub.q vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsub_q(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSUB_Q, vd, vj, vk));
-}
-
-/* Emits the `vsigncov.b vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsigncov_b(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSIGNCOV_B, vd, vj, vk));
-}
-
-/* Emits the `vsigncov.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsigncov_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSIGNCOV_H, vd, vj, vk));
-}
-
-/* Emits the `vsigncov.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsigncov_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSIGNCOV_W, vd, vj, vk));
-}
-
-/* Emits the `vsigncov.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsigncov_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSIGNCOV_D, vd, vj, vk));
-}
-
-/* Emits the `vfadd.s vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfadd_s(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFADD_S, vd, vj, vk));
-}
-
-/* Emits the `vfadd.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfadd_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFADD_D, vd, vj, vk));
-}
-
-/* Emits the `vfsub.s vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfsub_s(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFSUB_S, vd, vj, vk));
-}
-
-/* Emits the `vfsub.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfsub_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFSUB_D, vd, vj, vk));
-}
-
-/* Emits the `vfmul.s vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfmul_s(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFMUL_S, vd, vj, vk));
-}
-
-/* Emits the `vfmul.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfmul_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFMUL_D, vd, vj, vk));
-}
-
-/* Emits the `vfdiv.s vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfdiv_s(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFDIV_S, vd, vj, vk));
-}
-
-/* Emits the `vfdiv.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfdiv_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFDIV_D, vd, vj, vk));
-}
-
-/* Emits the `vfmax.s vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfmax_s(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFMAX_S, vd, vj, vk));
-}
-
-/* Emits the `vfmax.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfmax_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFMAX_D, vd, vj, vk));
-}
-
-/* Emits the `vfmin.s vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfmin_s(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFMIN_S, vd, vj, vk));
-}
-
-/* Emits the `vfmin.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfmin_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFMIN_D, vd, vj, vk));
-}
-
-/* Emits the `vfmaxa.s vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfmaxa_s(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFMAXA_S, vd, vj, vk));
-}
-
-/* Emits the `vfmaxa.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfmaxa_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFMAXA_D, vd, vj, vk));
-}
-
-/* Emits the `vfmina.s vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfmina_s(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFMINA_S, vd, vj, vk));
-}
-
-/* Emits the `vfmina.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfmina_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFMINA_D, vd, vj, vk));
-}
-
-/* Emits the `vfcvt.h.s vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcvt_h_s(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCVT_H_S, vd, vj, vk));
-}
-
-/* Emits the `vfcvt.s.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcvt_s_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFCVT_S_D, vd, vj, vk));
-}
-
-/* Emits the `vffint.s.l vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vffint_s_l(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFFINT_S_L, vd, vj, vk));
-}
-
-/* Emits the `vftint.w.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vftint_w_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFTINT_W_D, vd, vj, vk));
-}
-
-/* Emits the `vftintrm.w.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vftintrm_w_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFTINTRM_W_D, vd, vj, vk));
-}
-
-/* Emits the `vftintrp.w.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vftintrp_w_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFTINTRP_W_D, vd, vj, vk));
-}
-
-/* Emits the `vftintrz.w.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vftintrz_w_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFTINTRZ_W_D, vd, vj, vk));
-}
-
-/* Emits the `vftintrne.w.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vftintrne_w_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VFTINTRNE_W_D, vd, vj, vk));
-}
-
-/* Emits the `vshuf.h vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vshuf_h(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSHUF_H, vd, vj, vk));
-}
-
-/* Emits the `vshuf.w vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vshuf_w(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSHUF_W, vd, vj, vk));
-}
-
-/* Emits the `vshuf.d vd, vj, vk` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vshuf_d(TCGContext *s, TCGReg vd, TCGReg vj, TCGReg vk)
-{
-    tcg_out32(s, encode_vdvjvk_insn(OPC_VSHUF_D, vd, vj, vk));
-}
-
 /* Emits the `vseqi.b vd, vj, sk5` instruction.  */
 static void __attribute__((unused))
 tcg_out_opc_vseqi_b(TCGContext *s, TCGReg vd, TCGReg vj, int32_t sk5)
@@ -5258,20 +3211,6 @@ tcg_out_opc_vsubi_du(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk5)
     tcg_out32(s, encode_vdvjuk5_insn(OPC_VSUBI_DU, vd, vj, uk5));
 }
 
-/* Emits the `vbsll.v vd, vj, uk5` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vbsll_v(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk5)
-{
-    tcg_out32(s, encode_vdvjuk5_insn(OPC_VBSLL_V, vd, vj, uk5));
-}
-
-/* Emits the `vbsrl.v vd, vj, uk5` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vbsrl_v(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk5)
-{
-    tcg_out32(s, encode_vdvjuk5_insn(OPC_VBSRL_V, vd, vj, uk5));
-}
-
 /* Emits the `vmaxi.b vd, vj, sk5` instruction.  */
 static void __attribute__((unused))
 tcg_out_opc_vmaxi_b(TCGContext *s, TCGReg vd, TCGReg vj, int32_t sk5)
@@ -5384,104 +3323,6 @@ tcg_out_opc_vmini_du(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk5)
     tcg_out32(s, encode_vdvjuk5_insn(OPC_VMINI_DU, vd, vj, uk5));
 }
 
-/* Emits the `vfrstpi.b vd, vj, uk5` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfrstpi_b(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk5)
-{
-    tcg_out32(s, encode_vdvjuk5_insn(OPC_VFRSTPI_B, vd, vj, uk5));
-}
-
-/* Emits the `vfrstpi.h vd, vj, uk5` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfrstpi_h(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk5)
-{
-    tcg_out32(s, encode_vdvjuk5_insn(OPC_VFRSTPI_H, vd, vj, uk5));
-}
-
-/* Emits the `vclo.b vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vclo_b(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VCLO_B, vd, vj));
-}
-
-/* Emits the `vclo.h vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vclo_h(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VCLO_H, vd, vj));
-}
-
-/* Emits the `vclo.w vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vclo_w(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VCLO_W, vd, vj));
-}
-
-/* Emits the `vclo.d vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vclo_d(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VCLO_D, vd, vj));
-}
-
-/* Emits the `vclz.b vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vclz_b(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VCLZ_B, vd, vj));
-}
-
-/* Emits the `vclz.h vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vclz_h(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VCLZ_H, vd, vj));
-}
-
-/* Emits the `vclz.w vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vclz_w(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VCLZ_W, vd, vj));
-}
-
-/* Emits the `vclz.d vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vclz_d(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VCLZ_D, vd, vj));
-}
-
-/* Emits the `vpcnt.b vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vpcnt_b(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VPCNT_B, vd, vj));
-}
-
-/* Emits the `vpcnt.h vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vpcnt_h(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VPCNT_H, vd, vj));
-}
-
-/* Emits the `vpcnt.w vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vpcnt_w(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VPCNT_W, vd, vj));
-}
-
-/* Emits the `vpcnt.d vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vpcnt_d(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VPCNT_D, vd, vj));
-}
-
 /* Emits the `vneg.b vd, vj` instruction.  */
 static void __attribute__((unused))
 tcg_out_opc_vneg_b(TCGContext *s, TCGReg vd, TCGReg vj)
@@ -5510,552 +3351,6 @@ tcg_out_opc_vneg_d(TCGContext *s, TCGReg vd, TCGReg vj)
     tcg_out32(s, encode_vdvj_insn(OPC_VNEG_D, vd, vj));
 }
 
-/* Emits the `vmskltz.b vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmskltz_b(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VMSKLTZ_B, vd, vj));
-}
-
-/* Emits the `vmskltz.h vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmskltz_h(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VMSKLTZ_H, vd, vj));
-}
-
-/* Emits the `vmskltz.w vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmskltz_w(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VMSKLTZ_W, vd, vj));
-}
-
-/* Emits the `vmskltz.d vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmskltz_d(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VMSKLTZ_D, vd, vj));
-}
-
-/* Emits the `vmskgez.b vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmskgez_b(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VMSKGEZ_B, vd, vj));
-}
-
-/* Emits the `vmsknz.b vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vmsknz_b(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VMSKNZ_B, vd, vj));
-}
-
-/* Emits the `vseteqz.v cd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vseteqz_v(TCGContext *s, TCGReg cd, TCGReg vj)
-{
-    tcg_out32(s, encode_cdvj_insn(OPC_VSETEQZ_V, cd, vj));
-}
-
-/* Emits the `vsetnez.v cd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsetnez_v(TCGContext *s, TCGReg cd, TCGReg vj)
-{
-    tcg_out32(s, encode_cdvj_insn(OPC_VSETNEZ_V, cd, vj));
-}
-
-/* Emits the `vsetanyeqz.b cd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsetanyeqz_b(TCGContext *s, TCGReg cd, TCGReg vj)
-{
-    tcg_out32(s, encode_cdvj_insn(OPC_VSETANYEQZ_B, cd, vj));
-}
-
-/* Emits the `vsetanyeqz.h cd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsetanyeqz_h(TCGContext *s, TCGReg cd, TCGReg vj)
-{
-    tcg_out32(s, encode_cdvj_insn(OPC_VSETANYEQZ_H, cd, vj));
-}
-
-/* Emits the `vsetanyeqz.w cd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsetanyeqz_w(TCGContext *s, TCGReg cd, TCGReg vj)
-{
-    tcg_out32(s, encode_cdvj_insn(OPC_VSETANYEQZ_W, cd, vj));
-}
-
-/* Emits the `vsetanyeqz.d cd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsetanyeqz_d(TCGContext *s, TCGReg cd, TCGReg vj)
-{
-    tcg_out32(s, encode_cdvj_insn(OPC_VSETANYEQZ_D, cd, vj));
-}
-
-/* Emits the `vsetallnez.b cd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsetallnez_b(TCGContext *s, TCGReg cd, TCGReg vj)
-{
-    tcg_out32(s, encode_cdvj_insn(OPC_VSETALLNEZ_B, cd, vj));
-}
-
-/* Emits the `vsetallnez.h cd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsetallnez_h(TCGContext *s, TCGReg cd, TCGReg vj)
-{
-    tcg_out32(s, encode_cdvj_insn(OPC_VSETALLNEZ_H, cd, vj));
-}
-
-/* Emits the `vsetallnez.w cd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsetallnez_w(TCGContext *s, TCGReg cd, TCGReg vj)
-{
-    tcg_out32(s, encode_cdvj_insn(OPC_VSETALLNEZ_W, cd, vj));
-}
-
-/* Emits the `vsetallnez.d cd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsetallnez_d(TCGContext *s, TCGReg cd, TCGReg vj)
-{
-    tcg_out32(s, encode_cdvj_insn(OPC_VSETALLNEZ_D, cd, vj));
-}
-
-/* Emits the `vflogb.s vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vflogb_s(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFLOGB_S, vd, vj));
-}
-
-/* Emits the `vflogb.d vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vflogb_d(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFLOGB_D, vd, vj));
-}
-
-/* Emits the `vfclass.s vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfclass_s(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFCLASS_S, vd, vj));
-}
-
-/* Emits the `vfclass.d vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfclass_d(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFCLASS_D, vd, vj));
-}
-
-/* Emits the `vfsqrt.s vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfsqrt_s(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFSQRT_S, vd, vj));
-}
-
-/* Emits the `vfsqrt.d vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfsqrt_d(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFSQRT_D, vd, vj));
-}
-
-/* Emits the `vfrecip.s vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfrecip_s(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFRECIP_S, vd, vj));
-}
-
-/* Emits the `vfrecip.d vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfrecip_d(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFRECIP_D, vd, vj));
-}
-
-/* Emits the `vfrsqrt.s vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfrsqrt_s(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFRSQRT_S, vd, vj));
-}
-
-/* Emits the `vfrsqrt.d vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfrsqrt_d(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFRSQRT_D, vd, vj));
-}
-
-/* Emits the `vfrint.s vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfrint_s(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFRINT_S, vd, vj));
-}
-
-/* Emits the `vfrint.d vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfrint_d(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFRINT_D, vd, vj));
-}
-
-/* Emits the `vfrintrm.s vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfrintrm_s(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFRINTRM_S, vd, vj));
-}
-
-/* Emits the `vfrintrm.d vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfrintrm_d(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFRINTRM_D, vd, vj));
-}
-
-/* Emits the `vfrintrp.s vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfrintrp_s(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFRINTRP_S, vd, vj));
-}
-
-/* Emits the `vfrintrp.d vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfrintrp_d(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFRINTRP_D, vd, vj));
-}
-
-/* Emits the `vfrintrz.s vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfrintrz_s(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFRINTRZ_S, vd, vj));
-}
-
-/* Emits the `vfrintrz.d vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfrintrz_d(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFRINTRZ_D, vd, vj));
-}
-
-/* Emits the `vfrintrne.s vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfrintrne_s(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFRINTRNE_S, vd, vj));
-}
-
-/* Emits the `vfrintrne.d vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfrintrne_d(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFRINTRNE_D, vd, vj));
-}
-
-/* Emits the `vfcvtl.s.h vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcvtl_s_h(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFCVTL_S_H, vd, vj));
-}
-
-/* Emits the `vfcvth.s.h vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcvth_s_h(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFCVTH_S_H, vd, vj));
-}
-
-/* Emits the `vfcvtl.d.s vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcvtl_d_s(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFCVTL_D_S, vd, vj));
-}
-
-/* Emits the `vfcvth.d.s vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vfcvth_d_s(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFCVTH_D_S, vd, vj));
-}
-
-/* Emits the `vffint.s.w vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vffint_s_w(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFFINT_S_W, vd, vj));
-}
-
-/* Emits the `vffint.s.wu vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vffint_s_wu(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFFINT_S_WU, vd, vj));
-}
-
-/* Emits the `vffint.d.l vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vffint_d_l(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFFINT_D_L, vd, vj));
-}
-
-/* Emits the `vffint.d.lu vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vffint_d_lu(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFFINT_D_LU, vd, vj));
-}
-
-/* Emits the `vffintl.d.w vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vffintl_d_w(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFFINTL_D_W, vd, vj));
-}
-
-/* Emits the `vffinth.d.w vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vffinth_d_w(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFFINTH_D_W, vd, vj));
-}
-
-/* Emits the `vftint.w.s vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vftint_w_s(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFTINT_W_S, vd, vj));
-}
-
-/* Emits the `vftint.l.d vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vftint_l_d(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFTINT_L_D, vd, vj));
-}
-
-/* Emits the `vftintrm.w.s vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vftintrm_w_s(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFTINTRM_W_S, vd, vj));
-}
-
-/* Emits the `vftintrm.l.d vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vftintrm_l_d(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFTINTRM_L_D, vd, vj));
-}
-
-/* Emits the `vftintrp.w.s vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vftintrp_w_s(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFTINTRP_W_S, vd, vj));
-}
-
-/* Emits the `vftintrp.l.d vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vftintrp_l_d(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFTINTRP_L_D, vd, vj));
-}
-
-/* Emits the `vftintrz.w.s vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vftintrz_w_s(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFTINTRZ_W_S, vd, vj));
-}
-
-/* Emits the `vftintrz.l.d vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vftintrz_l_d(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFTINTRZ_L_D, vd, vj));
-}
-
-/* Emits the `vftintrne.w.s vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vftintrne_w_s(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFTINTRNE_W_S, vd, vj));
-}
-
-/* Emits the `vftintrne.l.d vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vftintrne_l_d(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFTINTRNE_L_D, vd, vj));
-}
-
-/* Emits the `vftint.wu.s vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vftint_wu_s(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFTINT_WU_S, vd, vj));
-}
-
-/* Emits the `vftint.lu.d vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vftint_lu_d(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFTINT_LU_D, vd, vj));
-}
-
-/* Emits the `vftintrz.wu.s vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vftintrz_wu_s(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFTINTRZ_WU_S, vd, vj));
-}
-
-/* Emits the `vftintrz.lu.d vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vftintrz_lu_d(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFTINTRZ_LU_D, vd, vj));
-}
-
-/* Emits the `vftintl.l.s vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vftintl_l_s(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFTINTL_L_S, vd, vj));
-}
-
-/* Emits the `vftinth.l.s vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vftinth_l_s(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFTINTH_L_S, vd, vj));
-}
-
-/* Emits the `vftintrml.l.s vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vftintrml_l_s(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFTINTRML_L_S, vd, vj));
-}
-
-/* Emits the `vftintrmh.l.s vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vftintrmh_l_s(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFTINTRMH_L_S, vd, vj));
-}
-
-/* Emits the `vftintrpl.l.s vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vftintrpl_l_s(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFTINTRPL_L_S, vd, vj));
-}
-
-/* Emits the `vftintrph.l.s vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vftintrph_l_s(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFTINTRPH_L_S, vd, vj));
-}
-
-/* Emits the `vftintrzl.l.s vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vftintrzl_l_s(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFTINTRZL_L_S, vd, vj));
-}
-
-/* Emits the `vftintrzh.l.s vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vftintrzh_l_s(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFTINTRZH_L_S, vd, vj));
-}
-
-/* Emits the `vftintrnel.l.s vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vftintrnel_l_s(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFTINTRNEL_L_S, vd, vj));
-}
-
-/* Emits the `vftintrneh.l.s vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vftintrneh_l_s(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VFTINTRNEH_L_S, vd, vj));
-}
-
-/* Emits the `vexth.h.b vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vexth_h_b(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VEXTH_H_B, vd, vj));
-}
-
-/* Emits the `vexth.w.h vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vexth_w_h(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VEXTH_W_H, vd, vj));
-}
-
-/* Emits the `vexth.d.w vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vexth_d_w(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VEXTH_D_W, vd, vj));
-}
-
-/* Emits the `vexth.q.d vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vexth_q_d(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VEXTH_Q_D, vd, vj));
-}
-
-/* Emits the `vexth.hu.bu vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vexth_hu_bu(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VEXTH_HU_BU, vd, vj));
-}
-
-/* Emits the `vexth.wu.hu vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vexth_wu_hu(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VEXTH_WU_HU, vd, vj));
-}
-
-/* Emits the `vexth.du.wu vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vexth_du_wu(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VEXTH_DU_WU, vd, vj));
-}
-
-/* Emits the `vexth.qu.du vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vexth_qu_du(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VEXTH_QU_DU, vd, vj));
-}
-
 /* Emits the `vreplgr2vr.b vd, j` instruction.  */
 static void __attribute__((unused))
 tcg_out_opc_vreplgr2vr_b(TCGContext *s, TCGReg vd, TCGReg j)
@@ -6112,62 +3407,6 @@ tcg_out_opc_vrotri_d(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk6)
     tcg_out32(s, encode_vdvjuk6_insn(OPC_VROTRI_D, vd, vj, uk6));
 }
 
-/* Emits the `vsrlri.b vd, vj, uk3` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrlri_b(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk3)
-{
-    tcg_out32(s, encode_vdvjuk3_insn(OPC_VSRLRI_B, vd, vj, uk3));
-}
-
-/* Emits the `vsrlri.h vd, vj, uk4` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrlri_h(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk4)
-{
-    tcg_out32(s, encode_vdvjuk4_insn(OPC_VSRLRI_H, vd, vj, uk4));
-}
-
-/* Emits the `vsrlri.w vd, vj, uk5` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrlri_w(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk5)
-{
-    tcg_out32(s, encode_vdvjuk5_insn(OPC_VSRLRI_W, vd, vj, uk5));
-}
-
-/* Emits the `vsrlri.d vd, vj, uk6` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrlri_d(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk6)
-{
-    tcg_out32(s, encode_vdvjuk6_insn(OPC_VSRLRI_D, vd, vj, uk6));
-}
-
-/* Emits the `vsrari.b vd, vj, uk3` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrari_b(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk3)
-{
-    tcg_out32(s, encode_vdvjuk3_insn(OPC_VSRARI_B, vd, vj, uk3));
-}
-
-/* Emits the `vsrari.h vd, vj, uk4` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrari_h(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk4)
-{
-    tcg_out32(s, encode_vdvjuk4_insn(OPC_VSRARI_H, vd, vj, uk4));
-}
-
-/* Emits the `vsrari.w vd, vj, uk5` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrari_w(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk5)
-{
-    tcg_out32(s, encode_vdvjuk5_insn(OPC_VSRARI_W, vd, vj, uk5));
-}
-
-/* Emits the `vsrari.d vd, vj, uk6` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrari_d(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk6)
-{
-    tcg_out32(s, encode_vdvjuk6_insn(OPC_VSRARI_D, vd, vj, uk6));
-}
-
 /* Emits the `vinsgr2vr.b vd, j, uk4` instruction.  */
 static void __attribute__((unused))
 tcg_out_opc_vinsgr2vr_b(TCGContext *s, TCGReg vd, TCGReg j, uint32_t uk4)
@@ -6280,62 +3519,6 @@ tcg_out_opc_vreplvei_d(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk1)
     tcg_out32(s, encode_vdvjuk1_insn(OPC_VREPLVEI_D, vd, vj, uk1));
 }
 
-/* Emits the `vsllwil.h.b vd, vj, uk3` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsllwil_h_b(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk3)
-{
-    tcg_out32(s, encode_vdvjuk3_insn(OPC_VSLLWIL_H_B, vd, vj, uk3));
-}
-
-/* Emits the `vsllwil.w.h vd, vj, uk4` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsllwil_w_h(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk4)
-{
-    tcg_out32(s, encode_vdvjuk4_insn(OPC_VSLLWIL_W_H, vd, vj, uk4));
-}
-
-/* Emits the `vsllwil.d.w vd, vj, uk5` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsllwil_d_w(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk5)
-{
-    tcg_out32(s, encode_vdvjuk5_insn(OPC_VSLLWIL_D_W, vd, vj, uk5));
-}
-
-/* Emits the `vextl.q.d vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vextl_q_d(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VEXTL_Q_D, vd, vj));
-}
-
-/* Emits the `vsllwil.hu.bu vd, vj, uk3` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsllwil_hu_bu(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk3)
-{
-    tcg_out32(s, encode_vdvjuk3_insn(OPC_VSLLWIL_HU_BU, vd, vj, uk3));
-}
-
-/* Emits the `vsllwil.wu.hu vd, vj, uk4` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsllwil_wu_hu(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk4)
-{
-    tcg_out32(s, encode_vdvjuk4_insn(OPC_VSLLWIL_WU_HU, vd, vj, uk4));
-}
-
-/* Emits the `vsllwil.du.wu vd, vj, uk5` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsllwil_du_wu(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk5)
-{
-    tcg_out32(s, encode_vdvjuk5_insn(OPC_VSLLWIL_DU_WU, vd, vj, uk5));
-}
-
-/* Emits the `vextl.qu.du vd, vj` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vextl_qu_du(TCGContext *s, TCGReg vd, TCGReg vj)
-{
-    tcg_out32(s, encode_vdvj_insn(OPC_VEXTL_QU_DU, vd, vj));
-}
-
 /* Emits the `vbitclri.b vd, vj, uk3` instruction.  */
 static void __attribute__((unused))
 tcg_out_opc_vbitclri_b(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk3)
@@ -6420,62 +3603,6 @@ tcg_out_opc_vbitrevi_d(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk6)
     tcg_out32(s, encode_vdvjuk6_insn(OPC_VBITREVI_D, vd, vj, uk6));
 }
 
-/* Emits the `vsat.b vd, vj, uk3` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsat_b(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk3)
-{
-    tcg_out32(s, encode_vdvjuk3_insn(OPC_VSAT_B, vd, vj, uk3));
-}
-
-/* Emits the `vsat.h vd, vj, uk4` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsat_h(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk4)
-{
-    tcg_out32(s, encode_vdvjuk4_insn(OPC_VSAT_H, vd, vj, uk4));
-}
-
-/* Emits the `vsat.w vd, vj, uk5` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsat_w(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk5)
-{
-    tcg_out32(s, encode_vdvjuk5_insn(OPC_VSAT_W, vd, vj, uk5));
-}
-
-/* Emits the `vsat.d vd, vj, uk6` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsat_d(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk6)
-{
-    tcg_out32(s, encode_vdvjuk6_insn(OPC_VSAT_D, vd, vj, uk6));
-}
-
-/* Emits the `vsat.bu vd, vj, uk3` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsat_bu(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk3)
-{
-    tcg_out32(s, encode_vdvjuk3_insn(OPC_VSAT_BU, vd, vj, uk3));
-}
-
-/* Emits the `vsat.hu vd, vj, uk4` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsat_hu(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk4)
-{
-    tcg_out32(s, encode_vdvjuk4_insn(OPC_VSAT_HU, vd, vj, uk4));
-}
-
-/* Emits the `vsat.wu vd, vj, uk5` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsat_wu(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk5)
-{
-    tcg_out32(s, encode_vdvjuk5_insn(OPC_VSAT_WU, vd, vj, uk5));
-}
-
-/* Emits the `vsat.du vd, vj, uk6` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsat_du(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk6)
-{
-    tcg_out32(s, encode_vdvjuk6_insn(OPC_VSAT_DU, vd, vj, uk6));
-}
-
 /* Emits the `vslli.b vd, vj, uk3` instruction.  */
 static void __attribute__((unused))
 tcg_out_opc_vslli_b(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk3)
@@ -6560,398 +3687,6 @@ tcg_out_opc_vsrai_d(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk6)
     tcg_out32(s, encode_vdvjuk6_insn(OPC_VSRAI_D, vd, vj, uk6));
 }
 
-/* Emits the `vsrlni.b.h vd, vj, uk4` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrlni_b_h(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk4)
-{
-    tcg_out32(s, encode_vdvjuk4_insn(OPC_VSRLNI_B_H, vd, vj, uk4));
-}
-
-/* Emits the `vsrlni.h.w vd, vj, uk5` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrlni_h_w(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk5)
-{
-    tcg_out32(s, encode_vdvjuk5_insn(OPC_VSRLNI_H_W, vd, vj, uk5));
-}
-
-/* Emits the `vsrlni.w.d vd, vj, uk6` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrlni_w_d(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk6)
-{
-    tcg_out32(s, encode_vdvjuk6_insn(OPC_VSRLNI_W_D, vd, vj, uk6));
-}
-
-/* Emits the `vsrlni.d.q vd, vj, uk7` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrlni_d_q(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk7)
-{
-    tcg_out32(s, encode_vdvjuk7_insn(OPC_VSRLNI_D_Q, vd, vj, uk7));
-}
-
-/* Emits the `vsrlrni.b.h vd, vj, uk4` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrlrni_b_h(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk4)
-{
-    tcg_out32(s, encode_vdvjuk4_insn(OPC_VSRLRNI_B_H, vd, vj, uk4));
-}
-
-/* Emits the `vsrlrni.h.w vd, vj, uk5` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrlrni_h_w(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk5)
-{
-    tcg_out32(s, encode_vdvjuk5_insn(OPC_VSRLRNI_H_W, vd, vj, uk5));
-}
-
-/* Emits the `vsrlrni.w.d vd, vj, uk6` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrlrni_w_d(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk6)
-{
-    tcg_out32(s, encode_vdvjuk6_insn(OPC_VSRLRNI_W_D, vd, vj, uk6));
-}
-
-/* Emits the `vsrlrni.d.q vd, vj, uk7` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrlrni_d_q(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk7)
-{
-    tcg_out32(s, encode_vdvjuk7_insn(OPC_VSRLRNI_D_Q, vd, vj, uk7));
-}
-
-/* Emits the `vssrlni.b.h vd, vj, uk4` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrlni_b_h(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk4)
-{
-    tcg_out32(s, encode_vdvjuk4_insn(OPC_VSSRLNI_B_H, vd, vj, uk4));
-}
-
-/* Emits the `vssrlni.h.w vd, vj, uk5` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrlni_h_w(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk5)
-{
-    tcg_out32(s, encode_vdvjuk5_insn(OPC_VSSRLNI_H_W, vd, vj, uk5));
-}
-
-/* Emits the `vssrlni.w.d vd, vj, uk6` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrlni_w_d(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk6)
-{
-    tcg_out32(s, encode_vdvjuk6_insn(OPC_VSSRLNI_W_D, vd, vj, uk6));
-}
-
-/* Emits the `vssrlni.d.q vd, vj, uk7` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrlni_d_q(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk7)
-{
-    tcg_out32(s, encode_vdvjuk7_insn(OPC_VSSRLNI_D_Q, vd, vj, uk7));
-}
-
-/* Emits the `vssrlni.bu.h vd, vj, uk4` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrlni_bu_h(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk4)
-{
-    tcg_out32(s, encode_vdvjuk4_insn(OPC_VSSRLNI_BU_H, vd, vj, uk4));
-}
-
-/* Emits the `vssrlni.hu.w vd, vj, uk5` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrlni_hu_w(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk5)
-{
-    tcg_out32(s, encode_vdvjuk5_insn(OPC_VSSRLNI_HU_W, vd, vj, uk5));
-}
-
-/* Emits the `vssrlni.wu.d vd, vj, uk6` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrlni_wu_d(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk6)
-{
-    tcg_out32(s, encode_vdvjuk6_insn(OPC_VSSRLNI_WU_D, vd, vj, uk6));
-}
-
-/* Emits the `vssrlni.du.q vd, vj, uk7` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrlni_du_q(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk7)
-{
-    tcg_out32(s, encode_vdvjuk7_insn(OPC_VSSRLNI_DU_Q, vd, vj, uk7));
-}
-
-/* Emits the `vssrlrni.b.h vd, vj, uk4` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrlrni_b_h(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk4)
-{
-    tcg_out32(s, encode_vdvjuk4_insn(OPC_VSSRLRNI_B_H, vd, vj, uk4));
-}
-
-/* Emits the `vssrlrni.h.w vd, vj, uk5` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrlrni_h_w(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk5)
-{
-    tcg_out32(s, encode_vdvjuk5_insn(OPC_VSSRLRNI_H_W, vd, vj, uk5));
-}
-
-/* Emits the `vssrlrni.w.d vd, vj, uk6` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrlrni_w_d(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk6)
-{
-    tcg_out32(s, encode_vdvjuk6_insn(OPC_VSSRLRNI_W_D, vd, vj, uk6));
-}
-
-/* Emits the `vssrlrni.d.q vd, vj, uk7` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrlrni_d_q(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk7)
-{
-    tcg_out32(s, encode_vdvjuk7_insn(OPC_VSSRLRNI_D_Q, vd, vj, uk7));
-}
-
-/* Emits the `vssrlrni.bu.h vd, vj, uk4` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrlrni_bu_h(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk4)
-{
-    tcg_out32(s, encode_vdvjuk4_insn(OPC_VSSRLRNI_BU_H, vd, vj, uk4));
-}
-
-/* Emits the `vssrlrni.hu.w vd, vj, uk5` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrlrni_hu_w(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk5)
-{
-    tcg_out32(s, encode_vdvjuk5_insn(OPC_VSSRLRNI_HU_W, vd, vj, uk5));
-}
-
-/* Emits the `vssrlrni.wu.d vd, vj, uk6` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrlrni_wu_d(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk6)
-{
-    tcg_out32(s, encode_vdvjuk6_insn(OPC_VSSRLRNI_WU_D, vd, vj, uk6));
-}
-
-/* Emits the `vssrlrni.du.q vd, vj, uk7` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrlrni_du_q(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk7)
-{
-    tcg_out32(s, encode_vdvjuk7_insn(OPC_VSSRLRNI_DU_Q, vd, vj, uk7));
-}
-
-/* Emits the `vsrani.b.h vd, vj, uk4` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrani_b_h(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk4)
-{
-    tcg_out32(s, encode_vdvjuk4_insn(OPC_VSRANI_B_H, vd, vj, uk4));
-}
-
-/* Emits the `vsrani.h.w vd, vj, uk5` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrani_h_w(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk5)
-{
-    tcg_out32(s, encode_vdvjuk5_insn(OPC_VSRANI_H_W, vd, vj, uk5));
-}
-
-/* Emits the `vsrani.w.d vd, vj, uk6` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrani_w_d(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk6)
-{
-    tcg_out32(s, encode_vdvjuk6_insn(OPC_VSRANI_W_D, vd, vj, uk6));
-}
-
-/* Emits the `vsrani.d.q vd, vj, uk7` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrani_d_q(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk7)
-{
-    tcg_out32(s, encode_vdvjuk7_insn(OPC_VSRANI_D_Q, vd, vj, uk7));
-}
-
-/* Emits the `vsrarni.b.h vd, vj, uk4` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrarni_b_h(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk4)
-{
-    tcg_out32(s, encode_vdvjuk4_insn(OPC_VSRARNI_B_H, vd, vj, uk4));
-}
-
-/* Emits the `vsrarni.h.w vd, vj, uk5` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrarni_h_w(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk5)
-{
-    tcg_out32(s, encode_vdvjuk5_insn(OPC_VSRARNI_H_W, vd, vj, uk5));
-}
-
-/* Emits the `vsrarni.w.d vd, vj, uk6` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrarni_w_d(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk6)
-{
-    tcg_out32(s, encode_vdvjuk6_insn(OPC_VSRARNI_W_D, vd, vj, uk6));
-}
-
-/* Emits the `vsrarni.d.q vd, vj, uk7` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vsrarni_d_q(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk7)
-{
-    tcg_out32(s, encode_vdvjuk7_insn(OPC_VSRARNI_D_Q, vd, vj, uk7));
-}
-
-/* Emits the `vssrani.b.h vd, vj, uk4` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrani_b_h(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk4)
-{
-    tcg_out32(s, encode_vdvjuk4_insn(OPC_VSSRANI_B_H, vd, vj, uk4));
-}
-
-/* Emits the `vssrani.h.w vd, vj, uk5` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrani_h_w(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk5)
-{
-    tcg_out32(s, encode_vdvjuk5_insn(OPC_VSSRANI_H_W, vd, vj, uk5));
-}
-
-/* Emits the `vssrani.w.d vd, vj, uk6` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrani_w_d(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk6)
-{
-    tcg_out32(s, encode_vdvjuk6_insn(OPC_VSSRANI_W_D, vd, vj, uk6));
-}
-
-/* Emits the `vssrani.d.q vd, vj, uk7` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrani_d_q(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk7)
-{
-    tcg_out32(s, encode_vdvjuk7_insn(OPC_VSSRANI_D_Q, vd, vj, uk7));
-}
-
-/* Emits the `vssrani.bu.h vd, vj, uk4` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrani_bu_h(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk4)
-{
-    tcg_out32(s, encode_vdvjuk4_insn(OPC_VSSRANI_BU_H, vd, vj, uk4));
-}
-
-/* Emits the `vssrani.hu.w vd, vj, uk5` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrani_hu_w(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk5)
-{
-    tcg_out32(s, encode_vdvjuk5_insn(OPC_VSSRANI_HU_W, vd, vj, uk5));
-}
-
-/* Emits the `vssrani.wu.d vd, vj, uk6` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrani_wu_d(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk6)
-{
-    tcg_out32(s, encode_vdvjuk6_insn(OPC_VSSRANI_WU_D, vd, vj, uk6));
-}
-
-/* Emits the `vssrani.du.q vd, vj, uk7` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrani_du_q(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk7)
-{
-    tcg_out32(s, encode_vdvjuk7_insn(OPC_VSSRANI_DU_Q, vd, vj, uk7));
-}
-
-/* Emits the `vssrarni.b.h vd, vj, uk4` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrarni_b_h(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk4)
-{
-    tcg_out32(s, encode_vdvjuk4_insn(OPC_VSSRARNI_B_H, vd, vj, uk4));
-}
-
-/* Emits the `vssrarni.h.w vd, vj, uk5` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrarni_h_w(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk5)
-{
-    tcg_out32(s, encode_vdvjuk5_insn(OPC_VSSRARNI_H_W, vd, vj, uk5));
-}
-
-/* Emits the `vssrarni.w.d vd, vj, uk6` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrarni_w_d(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk6)
-{
-    tcg_out32(s, encode_vdvjuk6_insn(OPC_VSSRARNI_W_D, vd, vj, uk6));
-}
-
-/* Emits the `vssrarni.d.q vd, vj, uk7` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrarni_d_q(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk7)
-{
-    tcg_out32(s, encode_vdvjuk7_insn(OPC_VSSRARNI_D_Q, vd, vj, uk7));
-}
-
-/* Emits the `vssrarni.bu.h vd, vj, uk4` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrarni_bu_h(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk4)
-{
-    tcg_out32(s, encode_vdvjuk4_insn(OPC_VSSRARNI_BU_H, vd, vj, uk4));
-}
-
-/* Emits the `vssrarni.hu.w vd, vj, uk5` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrarni_hu_w(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk5)
-{
-    tcg_out32(s, encode_vdvjuk5_insn(OPC_VSSRARNI_HU_W, vd, vj, uk5));
-}
-
-/* Emits the `vssrarni.wu.d vd, vj, uk6` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrarni_wu_d(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk6)
-{
-    tcg_out32(s, encode_vdvjuk6_insn(OPC_VSSRARNI_WU_D, vd, vj, uk6));
-}
-
-/* Emits the `vssrarni.du.q vd, vj, uk7` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vssrarni_du_q(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk7)
-{
-    tcg_out32(s, encode_vdvjuk7_insn(OPC_VSSRARNI_DU_Q, vd, vj, uk7));
-}
-
-/* Emits the `vextrins.d vd, vj, uk8` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vextrins_d(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk8)
-{
-    tcg_out32(s, encode_vdvjuk8_insn(OPC_VEXTRINS_D, vd, vj, uk8));
-}
-
-/* Emits the `vextrins.w vd, vj, uk8` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vextrins_w(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk8)
-{
-    tcg_out32(s, encode_vdvjuk8_insn(OPC_VEXTRINS_W, vd, vj, uk8));
-}
-
-/* Emits the `vextrins.h vd, vj, uk8` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vextrins_h(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk8)
-{
-    tcg_out32(s, encode_vdvjuk8_insn(OPC_VEXTRINS_H, vd, vj, uk8));
-}
-
-/* Emits the `vextrins.b vd, vj, uk8` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vextrins_b(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk8)
-{
-    tcg_out32(s, encode_vdvjuk8_insn(OPC_VEXTRINS_B, vd, vj, uk8));
-}
-
-/* Emits the `vshuf4i.b vd, vj, uk8` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vshuf4i_b(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk8)
-{
-    tcg_out32(s, encode_vdvjuk8_insn(OPC_VSHUF4I_B, vd, vj, uk8));
-}
-
-/* Emits the `vshuf4i.h vd, vj, uk8` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vshuf4i_h(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk8)
-{
-    tcg_out32(s, encode_vdvjuk8_insn(OPC_VSHUF4I_H, vd, vj, uk8));
-}
-
-/* Emits the `vshuf4i.w vd, vj, uk8` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vshuf4i_w(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk8)
-{
-    tcg_out32(s, encode_vdvjuk8_insn(OPC_VSHUF4I_W, vd, vj, uk8));
-}
-
-/* Emits the `vshuf4i.d vd, vj, uk8` instruction.  */
-static void __attribute__((unused))
-tcg_out_opc_vshuf4i_d(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk8)
-{
-    tcg_out32(s, encode_vdvjuk8_insn(OPC_VSHUF4I_D, vd, vj, uk8));
-}
-
 /* Emits the `vbitseli.b vd, vj, uk8` instruction.  */
 static void __attribute__((unused))
 tcg_out_opc_vbitseli_b(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk8)
@@ -6994,11 +3729,1341 @@ tcg_out_opc_vldi(TCGContext *s, TCGReg vd, int32_t sj13)
     tcg_out32(s, encode_vdsj13_insn(OPC_VLDI, vd, sj13));
 }
 
-/* Emits the `vpermi.w vd, vj, uk8` instruction.  */
+/* Emits the `xvseq.b xd, xj, xk` instruction.  */
 static void __attribute__((unused))
-tcg_out_opc_vpermi_w(TCGContext *s, TCGReg vd, TCGReg vj, uint32_t uk8)
+tcg_out_opc_xvseq_b(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
 {
-    tcg_out32(s, encode_vdvjuk8_insn(OPC_VPERMI_W, vd, vj, uk8));
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSEQ_B, xd, xj, xk));
+}
+
+/* Emits the `xvseq.h xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvseq_h(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSEQ_H, xd, xj, xk));
+}
+
+/* Emits the `xvseq.w xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvseq_w(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSEQ_W, xd, xj, xk));
+}
+
+/* Emits the `xvseq.d xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvseq_d(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSEQ_D, xd, xj, xk));
+}
+
+/* Emits the `xvsle.b xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsle_b(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSLE_B, xd, xj, xk));
+}
+
+/* Emits the `xvsle.h xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsle_h(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSLE_H, xd, xj, xk));
+}
+
+/* Emits the `xvsle.w xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsle_w(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSLE_W, xd, xj, xk));
+}
+
+/* Emits the `xvsle.d xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsle_d(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSLE_D, xd, xj, xk));
+}
+
+/* Emits the `xvsle.bu xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsle_bu(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSLE_BU, xd, xj, xk));
+}
+
+/* Emits the `xvsle.hu xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsle_hu(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSLE_HU, xd, xj, xk));
+}
+
+/* Emits the `xvsle.wu xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsle_wu(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSLE_WU, xd, xj, xk));
+}
+
+/* Emits the `xvsle.du xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsle_du(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSLE_DU, xd, xj, xk));
+}
+
+/* Emits the `xvslt.b xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvslt_b(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSLT_B, xd, xj, xk));
+}
+
+/* Emits the `xvslt.h xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvslt_h(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSLT_H, xd, xj, xk));
+}
+
+/* Emits the `xvslt.w xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvslt_w(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSLT_W, xd, xj, xk));
+}
+
+/* Emits the `xvslt.d xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvslt_d(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSLT_D, xd, xj, xk));
+}
+
+/* Emits the `xvslt.bu xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvslt_bu(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSLT_BU, xd, xj, xk));
+}
+
+/* Emits the `xvslt.hu xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvslt_hu(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSLT_HU, xd, xj, xk));
+}
+
+/* Emits the `xvslt.wu xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvslt_wu(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSLT_WU, xd, xj, xk));
+}
+
+/* Emits the `xvslt.du xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvslt_du(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSLT_DU, xd, xj, xk));
+}
+
+/* Emits the `xvadd.b xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvadd_b(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVADD_B, xd, xj, xk));
+}
+
+/* Emits the `xvadd.h xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvadd_h(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVADD_H, xd, xj, xk));
+}
+
+/* Emits the `xvadd.w xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvadd_w(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVADD_W, xd, xj, xk));
+}
+
+/* Emits the `xvadd.d xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvadd_d(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVADD_D, xd, xj, xk));
+}
+
+/* Emits the `xvsub.b xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsub_b(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSUB_B, xd, xj, xk));
+}
+
+/* Emits the `xvsub.h xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsub_h(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSUB_H, xd, xj, xk));
+}
+
+/* Emits the `xvsub.w xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsub_w(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSUB_W, xd, xj, xk));
+}
+
+/* Emits the `xvsub.d xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsub_d(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSUB_D, xd, xj, xk));
+}
+
+/* Emits the `xvsadd.b xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsadd_b(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSADD_B, xd, xj, xk));
+}
+
+/* Emits the `xvsadd.h xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsadd_h(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSADD_H, xd, xj, xk));
+}
+
+/* Emits the `xvsadd.w xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsadd_w(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSADD_W, xd, xj, xk));
+}
+
+/* Emits the `xvsadd.d xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsadd_d(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSADD_D, xd, xj, xk));
+}
+
+/* Emits the `xvssub.b xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvssub_b(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSSUB_B, xd, xj, xk));
+}
+
+/* Emits the `xvssub.h xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvssub_h(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSSUB_H, xd, xj, xk));
+}
+
+/* Emits the `xvssub.w xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvssub_w(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSSUB_W, xd, xj, xk));
+}
+
+/* Emits the `xvssub.d xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvssub_d(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSSUB_D, xd, xj, xk));
+}
+
+/* Emits the `xvsadd.bu xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsadd_bu(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSADD_BU, xd, xj, xk));
+}
+
+/* Emits the `xvsadd.hu xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsadd_hu(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSADD_HU, xd, xj, xk));
+}
+
+/* Emits the `xvsadd.wu xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsadd_wu(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSADD_WU, xd, xj, xk));
+}
+
+/* Emits the `xvsadd.du xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsadd_du(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSADD_DU, xd, xj, xk));
+}
+
+/* Emits the `xvssub.bu xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvssub_bu(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSSUB_BU, xd, xj, xk));
+}
+
+/* Emits the `xvssub.hu xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvssub_hu(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSSUB_HU, xd, xj, xk));
+}
+
+/* Emits the `xvssub.wu xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvssub_wu(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSSUB_WU, xd, xj, xk));
+}
+
+/* Emits the `xvssub.du xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvssub_du(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSSUB_DU, xd, xj, xk));
+}
+
+/* Emits the `xvmax.b xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvmax_b(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVMAX_B, xd, xj, xk));
+}
+
+/* Emits the `xvmax.h xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvmax_h(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVMAX_H, xd, xj, xk));
+}
+
+/* Emits the `xvmax.w xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvmax_w(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVMAX_W, xd, xj, xk));
+}
+
+/* Emits the `xvmax.d xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvmax_d(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVMAX_D, xd, xj, xk));
+}
+
+/* Emits the `xvmin.b xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvmin_b(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVMIN_B, xd, xj, xk));
+}
+
+/* Emits the `xvmin.h xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvmin_h(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVMIN_H, xd, xj, xk));
+}
+
+/* Emits the `xvmin.w xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvmin_w(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVMIN_W, xd, xj, xk));
+}
+
+/* Emits the `xvmin.d xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvmin_d(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVMIN_D, xd, xj, xk));
+}
+
+/* Emits the `xvmax.bu xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvmax_bu(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVMAX_BU, xd, xj, xk));
+}
+
+/* Emits the `xvmax.hu xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvmax_hu(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVMAX_HU, xd, xj, xk));
+}
+
+/* Emits the `xvmax.wu xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvmax_wu(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVMAX_WU, xd, xj, xk));
+}
+
+/* Emits the `xvmax.du xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvmax_du(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVMAX_DU, xd, xj, xk));
+}
+
+/* Emits the `xvmin.bu xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvmin_bu(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVMIN_BU, xd, xj, xk));
+}
+
+/* Emits the `xvmin.hu xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvmin_hu(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVMIN_HU, xd, xj, xk));
+}
+
+/* Emits the `xvmin.wu xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvmin_wu(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVMIN_WU, xd, xj, xk));
+}
+
+/* Emits the `xvmin.du xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvmin_du(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVMIN_DU, xd, xj, xk));
+}
+
+/* Emits the `xvmul.b xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvmul_b(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVMUL_B, xd, xj, xk));
+}
+
+/* Emits the `xvmul.h xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvmul_h(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVMUL_H, xd, xj, xk));
+}
+
+/* Emits the `xvmul.w xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvmul_w(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVMUL_W, xd, xj, xk));
+}
+
+/* Emits the `xvmul.d xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvmul_d(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVMUL_D, xd, xj, xk));
+}
+
+/* Emits the `xvsll.b xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsll_b(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSLL_B, xd, xj, xk));
+}
+
+/* Emits the `xvsll.h xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsll_h(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSLL_H, xd, xj, xk));
+}
+
+/* Emits the `xvsll.w xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsll_w(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSLL_W, xd, xj, xk));
+}
+
+/* Emits the `xvsll.d xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsll_d(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSLL_D, xd, xj, xk));
+}
+
+/* Emits the `xvsrl.b xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsrl_b(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSRL_B, xd, xj, xk));
+}
+
+/* Emits the `xvsrl.h xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsrl_h(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSRL_H, xd, xj, xk));
+}
+
+/* Emits the `xvsrl.w xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsrl_w(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSRL_W, xd, xj, xk));
+}
+
+/* Emits the `xvsrl.d xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsrl_d(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSRL_D, xd, xj, xk));
+}
+
+/* Emits the `xvsra.b xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsra_b(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSRA_B, xd, xj, xk));
+}
+
+/* Emits the `xvsra.h xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsra_h(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSRA_H, xd, xj, xk));
+}
+
+/* Emits the `xvsra.w xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsra_w(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSRA_W, xd, xj, xk));
+}
+
+/* Emits the `xvsra.d xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsra_d(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVSRA_D, xd, xj, xk));
+}
+
+/* Emits the `xvrotr.b xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvrotr_b(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVROTR_B, xd, xj, xk));
+}
+
+/* Emits the `xvrotr.h xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvrotr_h(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVROTR_H, xd, xj, xk));
+}
+
+/* Emits the `xvrotr.w xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvrotr_w(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVROTR_W, xd, xj, xk));
+}
+
+/* Emits the `xvrotr.d xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvrotr_d(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVROTR_D, xd, xj, xk));
+}
+
+/* Emits the `xvreplve.b xd, xj, k` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvreplve_b(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg k)
+{
+    tcg_out32(s, encode_xdxjk_insn(OPC_XVREPLVE_B, xd, xj, k));
+}
+
+/* Emits the `xvreplve.h xd, xj, k` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvreplve_h(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg k)
+{
+    tcg_out32(s, encode_xdxjk_insn(OPC_XVREPLVE_H, xd, xj, k));
+}
+
+/* Emits the `xvreplve.w xd, xj, k` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvreplve_w(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg k)
+{
+    tcg_out32(s, encode_xdxjk_insn(OPC_XVREPLVE_W, xd, xj, k));
+}
+
+/* Emits the `xvreplve.d xd, xj, k` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvreplve_d(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg k)
+{
+    tcg_out32(s, encode_xdxjk_insn(OPC_XVREPLVE_D, xd, xj, k));
+}
+
+/* Emits the `xvand.v xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvand_v(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVAND_V, xd, xj, xk));
+}
+
+/* Emits the `xvor.v xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvor_v(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVOR_V, xd, xj, xk));
+}
+
+/* Emits the `xvxor.v xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvxor_v(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVXOR_V, xd, xj, xk));
+}
+
+/* Emits the `xvnor.v xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvnor_v(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVNOR_V, xd, xj, xk));
+}
+
+/* Emits the `xvandn.v xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvandn_v(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVANDN_V, xd, xj, xk));
+}
+
+/* Emits the `xvorn.v xd, xj, xk` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvorn_v(TCGContext *s, TCGReg xd, TCGReg xj, TCGReg xk)
+{
+    tcg_out32(s, encode_xdxjxk_insn(OPC_XVORN_V, xd, xj, xk));
+}
+
+/* Emits the `xvseqi.b xd, xj, sk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvseqi_b(TCGContext *s, TCGReg xd, TCGReg xj, int32_t sk5)
+{
+    tcg_out32(s, encode_xdxjsk5_insn(OPC_XVSEQI_B, xd, xj, sk5));
+}
+
+/* Emits the `xvseqi.h xd, xj, sk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvseqi_h(TCGContext *s, TCGReg xd, TCGReg xj, int32_t sk5)
+{
+    tcg_out32(s, encode_xdxjsk5_insn(OPC_XVSEQI_H, xd, xj, sk5));
+}
+
+/* Emits the `xvseqi.w xd, xj, sk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvseqi_w(TCGContext *s, TCGReg xd, TCGReg xj, int32_t sk5)
+{
+    tcg_out32(s, encode_xdxjsk5_insn(OPC_XVSEQI_W, xd, xj, sk5));
+}
+
+/* Emits the `xvseqi.d xd, xj, sk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvseqi_d(TCGContext *s, TCGReg xd, TCGReg xj, int32_t sk5)
+{
+    tcg_out32(s, encode_xdxjsk5_insn(OPC_XVSEQI_D, xd, xj, sk5));
+}
+
+/* Emits the `xvslei.b xd, xj, sk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvslei_b(TCGContext *s, TCGReg xd, TCGReg xj, int32_t sk5)
+{
+    tcg_out32(s, encode_xdxjsk5_insn(OPC_XVSLEI_B, xd, xj, sk5));
+}
+
+/* Emits the `xvslei.h xd, xj, sk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvslei_h(TCGContext *s, TCGReg xd, TCGReg xj, int32_t sk5)
+{
+    tcg_out32(s, encode_xdxjsk5_insn(OPC_XVSLEI_H, xd, xj, sk5));
+}
+
+/* Emits the `xvslei.w xd, xj, sk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvslei_w(TCGContext *s, TCGReg xd, TCGReg xj, int32_t sk5)
+{
+    tcg_out32(s, encode_xdxjsk5_insn(OPC_XVSLEI_W, xd, xj, sk5));
+}
+
+/* Emits the `xvslei.d xd, xj, sk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvslei_d(TCGContext *s, TCGReg xd, TCGReg xj, int32_t sk5)
+{
+    tcg_out32(s, encode_xdxjsk5_insn(OPC_XVSLEI_D, xd, xj, sk5));
+}
+
+/* Emits the `xvslei.bu xd, xj, uk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvslei_bu(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk5)
+{
+    tcg_out32(s, encode_xdxjuk5_insn(OPC_XVSLEI_BU, xd, xj, uk5));
+}
+
+/* Emits the `xvslei.hu xd, xj, uk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvslei_hu(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk5)
+{
+    tcg_out32(s, encode_xdxjuk5_insn(OPC_XVSLEI_HU, xd, xj, uk5));
+}
+
+/* Emits the `xvslei.wu xd, xj, uk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvslei_wu(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk5)
+{
+    tcg_out32(s, encode_xdxjuk5_insn(OPC_XVSLEI_WU, xd, xj, uk5));
+}
+
+/* Emits the `xvslei.du xd, xj, uk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvslei_du(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk5)
+{
+    tcg_out32(s, encode_xdxjuk5_insn(OPC_XVSLEI_DU, xd, xj, uk5));
+}
+
+/* Emits the `xvslti.b xd, xj, sk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvslti_b(TCGContext *s, TCGReg xd, TCGReg xj, int32_t sk5)
+{
+    tcg_out32(s, encode_xdxjsk5_insn(OPC_XVSLTI_B, xd, xj, sk5));
+}
+
+/* Emits the `xvslti.h xd, xj, sk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvslti_h(TCGContext *s, TCGReg xd, TCGReg xj, int32_t sk5)
+{
+    tcg_out32(s, encode_xdxjsk5_insn(OPC_XVSLTI_H, xd, xj, sk5));
+}
+
+/* Emits the `xvslti.w xd, xj, sk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvslti_w(TCGContext *s, TCGReg xd, TCGReg xj, int32_t sk5)
+{
+    tcg_out32(s, encode_xdxjsk5_insn(OPC_XVSLTI_W, xd, xj, sk5));
+}
+
+/* Emits the `xvslti.d xd, xj, sk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvslti_d(TCGContext *s, TCGReg xd, TCGReg xj, int32_t sk5)
+{
+    tcg_out32(s, encode_xdxjsk5_insn(OPC_XVSLTI_D, xd, xj, sk5));
+}
+
+/* Emits the `xvslti.bu xd, xj, uk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvslti_bu(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk5)
+{
+    tcg_out32(s, encode_xdxjuk5_insn(OPC_XVSLTI_BU, xd, xj, uk5));
+}
+
+/* Emits the `xvslti.hu xd, xj, uk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvslti_hu(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk5)
+{
+    tcg_out32(s, encode_xdxjuk5_insn(OPC_XVSLTI_HU, xd, xj, uk5));
+}
+
+/* Emits the `xvslti.wu xd, xj, uk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvslti_wu(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk5)
+{
+    tcg_out32(s, encode_xdxjuk5_insn(OPC_XVSLTI_WU, xd, xj, uk5));
+}
+
+/* Emits the `xvslti.du xd, xj, uk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvslti_du(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk5)
+{
+    tcg_out32(s, encode_xdxjuk5_insn(OPC_XVSLTI_DU, xd, xj, uk5));
+}
+
+/* Emits the `xvaddi.bu xd, xj, uk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvaddi_bu(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk5)
+{
+    tcg_out32(s, encode_xdxjuk5_insn(OPC_XVADDI_BU, xd, xj, uk5));
+}
+
+/* Emits the `xvaddi.hu xd, xj, uk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvaddi_hu(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk5)
+{
+    tcg_out32(s, encode_xdxjuk5_insn(OPC_XVADDI_HU, xd, xj, uk5));
+}
+
+/* Emits the `xvaddi.wu xd, xj, uk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvaddi_wu(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk5)
+{
+    tcg_out32(s, encode_xdxjuk5_insn(OPC_XVADDI_WU, xd, xj, uk5));
+}
+
+/* Emits the `xvaddi.du xd, xj, uk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvaddi_du(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk5)
+{
+    tcg_out32(s, encode_xdxjuk5_insn(OPC_XVADDI_DU, xd, xj, uk5));
+}
+
+/* Emits the `xvsubi.bu xd, xj, uk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsubi_bu(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk5)
+{
+    tcg_out32(s, encode_xdxjuk5_insn(OPC_XVSUBI_BU, xd, xj, uk5));
+}
+
+/* Emits the `xvsubi.hu xd, xj, uk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsubi_hu(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk5)
+{
+    tcg_out32(s, encode_xdxjuk5_insn(OPC_XVSUBI_HU, xd, xj, uk5));
+}
+
+/* Emits the `xvsubi.wu xd, xj, uk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsubi_wu(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk5)
+{
+    tcg_out32(s, encode_xdxjuk5_insn(OPC_XVSUBI_WU, xd, xj, uk5));
+}
+
+/* Emits the `xvsubi.du xd, xj, uk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsubi_du(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk5)
+{
+    tcg_out32(s, encode_xdxjuk5_insn(OPC_XVSUBI_DU, xd, xj, uk5));
+}
+
+/* Emits the `xvmaxi.b xd, xj, sk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvmaxi_b(TCGContext *s, TCGReg xd, TCGReg xj, int32_t sk5)
+{
+    tcg_out32(s, encode_xdxjsk5_insn(OPC_XVMAXI_B, xd, xj, sk5));
+}
+
+/* Emits the `xvmaxi.h xd, xj, sk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvmaxi_h(TCGContext *s, TCGReg xd, TCGReg xj, int32_t sk5)
+{
+    tcg_out32(s, encode_xdxjsk5_insn(OPC_XVMAXI_H, xd, xj, sk5));
+}
+
+/* Emits the `xvmaxi.w xd, xj, sk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvmaxi_w(TCGContext *s, TCGReg xd, TCGReg xj, int32_t sk5)
+{
+    tcg_out32(s, encode_xdxjsk5_insn(OPC_XVMAXI_W, xd, xj, sk5));
+}
+
+/* Emits the `xvmaxi.d xd, xj, sk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvmaxi_d(TCGContext *s, TCGReg xd, TCGReg xj, int32_t sk5)
+{
+    tcg_out32(s, encode_xdxjsk5_insn(OPC_XVMAXI_D, xd, xj, sk5));
+}
+
+/* Emits the `xvmini.b xd, xj, sk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvmini_b(TCGContext *s, TCGReg xd, TCGReg xj, int32_t sk5)
+{
+    tcg_out32(s, encode_xdxjsk5_insn(OPC_XVMINI_B, xd, xj, sk5));
+}
+
+/* Emits the `xvmini.h xd, xj, sk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvmini_h(TCGContext *s, TCGReg xd, TCGReg xj, int32_t sk5)
+{
+    tcg_out32(s, encode_xdxjsk5_insn(OPC_XVMINI_H, xd, xj, sk5));
+}
+
+/* Emits the `xvmini.w xd, xj, sk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvmini_w(TCGContext *s, TCGReg xd, TCGReg xj, int32_t sk5)
+{
+    tcg_out32(s, encode_xdxjsk5_insn(OPC_XVMINI_W, xd, xj, sk5));
+}
+
+/* Emits the `xvmini.d xd, xj, sk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvmini_d(TCGContext *s, TCGReg xd, TCGReg xj, int32_t sk5)
+{
+    tcg_out32(s, encode_xdxjsk5_insn(OPC_XVMINI_D, xd, xj, sk5));
+}
+
+/* Emits the `xvmaxi.bu xd, xj, uk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvmaxi_bu(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk5)
+{
+    tcg_out32(s, encode_xdxjuk5_insn(OPC_XVMAXI_BU, xd, xj, uk5));
+}
+
+/* Emits the `xvmaxi.hu xd, xj, uk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvmaxi_hu(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk5)
+{
+    tcg_out32(s, encode_xdxjuk5_insn(OPC_XVMAXI_HU, xd, xj, uk5));
+}
+
+/* Emits the `xvmaxi.wu xd, xj, uk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvmaxi_wu(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk5)
+{
+    tcg_out32(s, encode_xdxjuk5_insn(OPC_XVMAXI_WU, xd, xj, uk5));
+}
+
+/* Emits the `xvmaxi.du xd, xj, uk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvmaxi_du(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk5)
+{
+    tcg_out32(s, encode_xdxjuk5_insn(OPC_XVMAXI_DU, xd, xj, uk5));
+}
+
+/* Emits the `xvmini.bu xd, xj, uk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvmini_bu(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk5)
+{
+    tcg_out32(s, encode_xdxjuk5_insn(OPC_XVMINI_BU, xd, xj, uk5));
+}
+
+/* Emits the `xvmini.hu xd, xj, uk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvmini_hu(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk5)
+{
+    tcg_out32(s, encode_xdxjuk5_insn(OPC_XVMINI_HU, xd, xj, uk5));
+}
+
+/* Emits the `xvmini.wu xd, xj, uk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvmini_wu(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk5)
+{
+    tcg_out32(s, encode_xdxjuk5_insn(OPC_XVMINI_WU, xd, xj, uk5));
+}
+
+/* Emits the `xvmini.du xd, xj, uk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvmini_du(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk5)
+{
+    tcg_out32(s, encode_xdxjuk5_insn(OPC_XVMINI_DU, xd, xj, uk5));
+}
+
+/* Emits the `xvneg.b xd, xj` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvneg_b(TCGContext *s, TCGReg xd, TCGReg xj)
+{
+    tcg_out32(s, encode_xdxj_insn(OPC_XVNEG_B, xd, xj));
+}
+
+/* Emits the `xvneg.h xd, xj` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvneg_h(TCGContext *s, TCGReg xd, TCGReg xj)
+{
+    tcg_out32(s, encode_xdxj_insn(OPC_XVNEG_H, xd, xj));
+}
+
+/* Emits the `xvneg.w xd, xj` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvneg_w(TCGContext *s, TCGReg xd, TCGReg xj)
+{
+    tcg_out32(s, encode_xdxj_insn(OPC_XVNEG_W, xd, xj));
+}
+
+/* Emits the `xvneg.d xd, xj` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvneg_d(TCGContext *s, TCGReg xd, TCGReg xj)
+{
+    tcg_out32(s, encode_xdxj_insn(OPC_XVNEG_D, xd, xj));
+}
+
+/* Emits the `xvreplgr2vr.b xd, j` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvreplgr2vr_b(TCGContext *s, TCGReg xd, TCGReg j)
+{
+    tcg_out32(s, encode_xdj_insn(OPC_XVREPLGR2VR_B, xd, j));
+}
+
+/* Emits the `xvreplgr2vr.h xd, j` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvreplgr2vr_h(TCGContext *s, TCGReg xd, TCGReg j)
+{
+    tcg_out32(s, encode_xdj_insn(OPC_XVREPLGR2VR_H, xd, j));
+}
+
+/* Emits the `xvreplgr2vr.w xd, j` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvreplgr2vr_w(TCGContext *s, TCGReg xd, TCGReg j)
+{
+    tcg_out32(s, encode_xdj_insn(OPC_XVREPLGR2VR_W, xd, j));
+}
+
+/* Emits the `xvreplgr2vr.d xd, j` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvreplgr2vr_d(TCGContext *s, TCGReg xd, TCGReg j)
+{
+    tcg_out32(s, encode_xdj_insn(OPC_XVREPLGR2VR_D, xd, j));
+}
+
+/* Emits the `xvrotri.b xd, xj, uk3` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvrotri_b(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk3)
+{
+    tcg_out32(s, encode_xdxjuk3_insn(OPC_XVROTRI_B, xd, xj, uk3));
+}
+
+/* Emits the `xvrotri.h xd, xj, uk4` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvrotri_h(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk4)
+{
+    tcg_out32(s, encode_xdxjuk4_insn(OPC_XVROTRI_H, xd, xj, uk4));
+}
+
+/* Emits the `xvrotri.w xd, xj, uk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvrotri_w(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk5)
+{
+    tcg_out32(s, encode_xdxjuk5_insn(OPC_XVROTRI_W, xd, xj, uk5));
+}
+
+/* Emits the `xvrotri.d xd, xj, uk6` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvrotri_d(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk6)
+{
+    tcg_out32(s, encode_xdxjuk6_insn(OPC_XVROTRI_D, xd, xj, uk6));
+}
+
+/* Emits the `xvinsgr2vr.w xd, j, uk3` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvinsgr2vr_w(TCGContext *s, TCGReg xd, TCGReg j, uint32_t uk3)
+{
+    tcg_out32(s, encode_xdjuk3_insn(OPC_XVINSGR2VR_W, xd, j, uk3));
+}
+
+/* Emits the `xvinsgr2vr.d xd, j, uk2` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvinsgr2vr_d(TCGContext *s, TCGReg xd, TCGReg j, uint32_t uk2)
+{
+    tcg_out32(s, encode_xdjuk2_insn(OPC_XVINSGR2VR_D, xd, j, uk2));
+}
+
+/* Emits the `xvpickve2gr.w d, xj, uk3` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvpickve2gr_w(TCGContext *s, TCGReg d, TCGReg xj, uint32_t uk3)
+{
+    tcg_out32(s, encode_dxjuk3_insn(OPC_XVPICKVE2GR_W, d, xj, uk3));
+}
+
+/* Emits the `xvpickve2gr.d d, xj, uk2` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvpickve2gr_d(TCGContext *s, TCGReg d, TCGReg xj, uint32_t uk2)
+{
+    tcg_out32(s, encode_dxjuk2_insn(OPC_XVPICKVE2GR_D, d, xj, uk2));
+}
+
+/* Emits the `xvpickve2gr.wu d, xj, uk3` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvpickve2gr_wu(TCGContext *s, TCGReg d, TCGReg xj, uint32_t uk3)
+{
+    tcg_out32(s, encode_dxjuk3_insn(OPC_XVPICKVE2GR_WU, d, xj, uk3));
+}
+
+/* Emits the `xvpickve2gr.du d, xj, uk2` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvpickve2gr_du(TCGContext *s, TCGReg d, TCGReg xj, uint32_t uk2)
+{
+    tcg_out32(s, encode_dxjuk2_insn(OPC_XVPICKVE2GR_DU, d, xj, uk2));
+}
+
+/* Emits the `xvrepl128vei.b xd, xj, uk4` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvrepl128vei_b(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk4)
+{
+    tcg_out32(s, encode_xdxjuk4_insn(OPC_XVREPL128VEI_B, xd, xj, uk4));
+}
+
+/* Emits the `xvrepl128vei.h xd, xj, uk3` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvrepl128vei_h(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk3)
+{
+    tcg_out32(s, encode_xdxjuk3_insn(OPC_XVREPL128VEI_H, xd, xj, uk3));
+}
+
+/* Emits the `xvrepl128vei.w xd, xj, uk2` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvrepl128vei_w(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk2)
+{
+    tcg_out32(s, encode_xdxjuk2_insn(OPC_XVREPL128VEI_W, xd, xj, uk2));
+}
+
+/* Emits the `xvrepl128vei.d xd, xj, uk1` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvrepl128vei_d(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk1)
+{
+    tcg_out32(s, encode_xdxjuk1_insn(OPC_XVREPL128VEI_D, xd, xj, uk1));
+}
+
+/* Emits the `xvreplve0.b xd, xj` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvreplve0_b(TCGContext *s, TCGReg xd, TCGReg xj)
+{
+    tcg_out32(s, encode_xdxj_insn(OPC_XVREPLVE0_B, xd, xj));
+}
+
+/* Emits the `xvreplve0.h xd, xj` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvreplve0_h(TCGContext *s, TCGReg xd, TCGReg xj)
+{
+    tcg_out32(s, encode_xdxj_insn(OPC_XVREPLVE0_H, xd, xj));
+}
+
+/* Emits the `xvreplve0.w xd, xj` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvreplve0_w(TCGContext *s, TCGReg xd, TCGReg xj)
+{
+    tcg_out32(s, encode_xdxj_insn(OPC_XVREPLVE0_W, xd, xj));
+}
+
+/* Emits the `xvreplve0.d xd, xj` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvreplve0_d(TCGContext *s, TCGReg xd, TCGReg xj)
+{
+    tcg_out32(s, encode_xdxj_insn(OPC_XVREPLVE0_D, xd, xj));
+}
+
+/* Emits the `xvreplve0.q xd, xj` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvreplve0_q(TCGContext *s, TCGReg xd, TCGReg xj)
+{
+    tcg_out32(s, encode_xdxj_insn(OPC_XVREPLVE0_Q, xd, xj));
+}
+
+/* Emits the `xvbitclri.b xd, xj, uk3` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvbitclri_b(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk3)
+{
+    tcg_out32(s, encode_xdxjuk3_insn(OPC_XVBITCLRI_B, xd, xj, uk3));
+}
+
+/* Emits the `xvbitclri.h xd, xj, uk4` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvbitclri_h(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk4)
+{
+    tcg_out32(s, encode_xdxjuk4_insn(OPC_XVBITCLRI_H, xd, xj, uk4));
+}
+
+/* Emits the `xvbitclri.w xd, xj, uk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvbitclri_w(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk5)
+{
+    tcg_out32(s, encode_xdxjuk5_insn(OPC_XVBITCLRI_W, xd, xj, uk5));
+}
+
+/* Emits the `xvbitclri.d xd, xj, uk6` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvbitclri_d(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk6)
+{
+    tcg_out32(s, encode_xdxjuk6_insn(OPC_XVBITCLRI_D, xd, xj, uk6));
+}
+
+/* Emits the `xvbitseti.b xd, xj, uk3` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvbitseti_b(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk3)
+{
+    tcg_out32(s, encode_xdxjuk3_insn(OPC_XVBITSETI_B, xd, xj, uk3));
+}
+
+/* Emits the `xvbitseti.h xd, xj, uk4` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvbitseti_h(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk4)
+{
+    tcg_out32(s, encode_xdxjuk4_insn(OPC_XVBITSETI_H, xd, xj, uk4));
+}
+
+/* Emits the `xvbitseti.w xd, xj, uk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvbitseti_w(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk5)
+{
+    tcg_out32(s, encode_xdxjuk5_insn(OPC_XVBITSETI_W, xd, xj, uk5));
+}
+
+/* Emits the `xvbitseti.d xd, xj, uk6` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvbitseti_d(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk6)
+{
+    tcg_out32(s, encode_xdxjuk6_insn(OPC_XVBITSETI_D, xd, xj, uk6));
+}
+
+/* Emits the `xvbitrevi.b xd, xj, uk3` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvbitrevi_b(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk3)
+{
+    tcg_out32(s, encode_xdxjuk3_insn(OPC_XVBITREVI_B, xd, xj, uk3));
+}
+
+/* Emits the `xvbitrevi.h xd, xj, uk4` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvbitrevi_h(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk4)
+{
+    tcg_out32(s, encode_xdxjuk4_insn(OPC_XVBITREVI_H, xd, xj, uk4));
+}
+
+/* Emits the `xvbitrevi.w xd, xj, uk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvbitrevi_w(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk5)
+{
+    tcg_out32(s, encode_xdxjuk5_insn(OPC_XVBITREVI_W, xd, xj, uk5));
+}
+
+/* Emits the `xvbitrevi.d xd, xj, uk6` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvbitrevi_d(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk6)
+{
+    tcg_out32(s, encode_xdxjuk6_insn(OPC_XVBITREVI_D, xd, xj, uk6));
+}
+
+/* Emits the `xvslli.b xd, xj, uk3` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvslli_b(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk3)
+{
+    tcg_out32(s, encode_xdxjuk3_insn(OPC_XVSLLI_B, xd, xj, uk3));
+}
+
+/* Emits the `xvslli.h xd, xj, uk4` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvslli_h(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk4)
+{
+    tcg_out32(s, encode_xdxjuk4_insn(OPC_XVSLLI_H, xd, xj, uk4));
+}
+
+/* Emits the `xvslli.w xd, xj, uk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvslli_w(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk5)
+{
+    tcg_out32(s, encode_xdxjuk5_insn(OPC_XVSLLI_W, xd, xj, uk5));
+}
+
+/* Emits the `xvslli.d xd, xj, uk6` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvslli_d(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk6)
+{
+    tcg_out32(s, encode_xdxjuk6_insn(OPC_XVSLLI_D, xd, xj, uk6));
+}
+
+/* Emits the `xvsrli.b xd, xj, uk3` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsrli_b(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk3)
+{
+    tcg_out32(s, encode_xdxjuk3_insn(OPC_XVSRLI_B, xd, xj, uk3));
+}
+
+/* Emits the `xvsrli.h xd, xj, uk4` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsrli_h(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk4)
+{
+    tcg_out32(s, encode_xdxjuk4_insn(OPC_XVSRLI_H, xd, xj, uk4));
+}
+
+/* Emits the `xvsrli.w xd, xj, uk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsrli_w(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk5)
+{
+    tcg_out32(s, encode_xdxjuk5_insn(OPC_XVSRLI_W, xd, xj, uk5));
+}
+
+/* Emits the `xvsrli.d xd, xj, uk6` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsrli_d(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk6)
+{
+    tcg_out32(s, encode_xdxjuk6_insn(OPC_XVSRLI_D, xd, xj, uk6));
+}
+
+/* Emits the `xvsrai.b xd, xj, uk3` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsrai_b(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk3)
+{
+    tcg_out32(s, encode_xdxjuk3_insn(OPC_XVSRAI_B, xd, xj, uk3));
+}
+
+/* Emits the `xvsrai.h xd, xj, uk4` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsrai_h(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk4)
+{
+    tcg_out32(s, encode_xdxjuk4_insn(OPC_XVSRAI_H, xd, xj, uk4));
+}
+
+/* Emits the `xvsrai.w xd, xj, uk5` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsrai_w(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk5)
+{
+    tcg_out32(s, encode_xdxjuk5_insn(OPC_XVSRAI_W, xd, xj, uk5));
+}
+
+/* Emits the `xvsrai.d xd, xj, uk6` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvsrai_d(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk6)
+{
+    tcg_out32(s, encode_xdxjuk6_insn(OPC_XVSRAI_D, xd, xj, uk6));
+}
+
+/* Emits the `xvbitseli.b xd, xj, uk8` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvbitseli_b(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk8)
+{
+    tcg_out32(s, encode_xdxjuk8_insn(OPC_XVBITSELI_B, xd, xj, uk8));
+}
+
+/* Emits the `xvandi.b xd, xj, uk8` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvandi_b(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk8)
+{
+    tcg_out32(s, encode_xdxjuk8_insn(OPC_XVANDI_B, xd, xj, uk8));
+}
+
+/* Emits the `xvori.b xd, xj, uk8` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvori_b(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk8)
+{
+    tcg_out32(s, encode_xdxjuk8_insn(OPC_XVORI_B, xd, xj, uk8));
+}
+
+/* Emits the `xvxori.b xd, xj, uk8` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvxori_b(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk8)
+{
+    tcg_out32(s, encode_xdxjuk8_insn(OPC_XVXORI_B, xd, xj, uk8));
+}
+
+/* Emits the `xvnori.b xd, xj, uk8` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvnori_b(TCGContext *s, TCGReg xd, TCGReg xj, uint32_t uk8)
+{
+    tcg_out32(s, encode_xdxjuk8_insn(OPC_XVNORI_B, xd, xj, uk8));
+}
+
+/* Emits the `xvldi xd, sj13` instruction.  */
+static void __attribute__((unused))
+tcg_out_opc_xvldi(TCGContext *s, TCGReg xd, int32_t sj13)
+{
+    tcg_out32(s, encode_xdsj13_insn(OPC_XVLDI, xd, sj13));
 }
 
 /* End of generated code.  */
-- 
2.34.1


