Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E448AC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD0zo-0004RO-Tv; Fri, 31 May 2024 08:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zl-0004Pm-09
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:29 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zh-0003TT-7A
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:28 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2e974862b00so21462871fa.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717157063; x=1717761863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oMbgRTaYkPeH4Tm2qrpbQDSGLC5c/jIwU6UV8EdlfHE=;
 b=ViOb1xDLkKUNPQ3Bh2c2fwP2xzuyVenWALwxbYkoIR6CZJe8YDcZjczQeMIc7v5+6s
 6UpbZ7YwGW27psX1LezOycPuvBiil+lFkOGhaWuj7VRl11Hj+TTEAXQy/ImL0oLv4p0O
 IeLFNJG87OETzihS8aoUMcfScIDvzFtJOeuqPK/uQVqwdBliZMHSbOlJkhQukdelWfv+
 Tf9sx8Ojna8jyC74ceORDpq3wJMq5TdKs31E9S623F89oG0OaAVCg2m4LjMsh2Lbc55U
 QGxzoTZ3K8SXp49rhb1B/5pTClnU9FLVaAwDmnqne5vuzJZK30tBaMNU4/uZjO9+uDkC
 h4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717157063; x=1717761863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oMbgRTaYkPeH4Tm2qrpbQDSGLC5c/jIwU6UV8EdlfHE=;
 b=fkIqzfh/LP8cqGtZKh34HYH4rba7vCUfMJwdauSpJCke839tmB+lQL5vXhcms1GYx1
 ZCm/ev0vxygq78+5eNWbneDODZ99jU2N77//dONVR0XhFg0AktMSQiLGMzLTKH2lm8UQ
 gJ9FF3nfTrZnOVE+GKRLOEjTzqxyn+Rowbd9G7XqmhJbY60yfNwNpUocoiHALk7rd/NB
 5CNyRNeicfWO6ilkeKyBHMlVRF3+X42MM4iq7O49Vxr2KpFwtpRt1UAdQslB1gbA+QvC
 jWo3CgW3XqTSONzHWW/lK5i02djba87ougywGdd5EFVu3/ZSRG9BXbqTNvt46L0xgqnY
 quMg==
X-Gm-Message-State: AOJu0YwawsrCali++e/MGCurLj6vKDzRksdPG7ztLcAPB/M5cXrktlKV
 ZB6tZxBdkCIGyyv7ZIEmB8+dO2Gh3XJBD7IB+Pmz0ITvmAhXoO9s8ovGUG/8Q+oO2TAvQGTUega
 6
X-Google-Smtp-Source: AGHT+IEYqsgTioyj1KkGM42hkpvS/G1Bw31O7qy79wBXG7nJJ9cjtlhGYF5A+hFbRxrCXrG6+QfLnw==
X-Received: by 2002:a2e:9dc7:0:b0:2e9:69ec:f690 with SMTP id
 38308e7fff4ca-2ea95153dbamr13513261fa.30.1717157062765; 
 Fri, 31 May 2024 05:04:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42129de0cf9sm37027685e9.13.2024.05.31.05.04.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 05:04:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/43] target/arm: Convert SHSUB, UHSUB to decodetree
Date: Fri, 31 May 2024 13:03:46 +0100
Message-Id: <20240531120401.394550-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531120401.394550-1-peter.maydell@linaro.org>
References: <20240531120401.394550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240528203044.612851-24-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  2 ++
 target/arm/tcg/translate-a64.c | 11 +++--------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index e33d91fd0a4..b1bbcb144eb 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -914,6 +914,8 @@ CMTST_v         0.00 1110 ..1 ..... 10001 1 ..... ..... @qrrr_e
 CMEQ_v          0.10 1110 ..1 ..... 10001 1 ..... ..... @qrrr_e
 SHADD_v         0.00 1110 ..1 ..... 00000 1 ..... ..... @qrrr_e
 UHADD_v         0.10 1110 ..1 ..... 00000 1 ..... ..... @qrrr_e
+SHSUB_v         0.00 1110 ..1 ..... 00100 1 ..... ..... @qrrr_e
+UHSUB_v         0.10 1110 ..1 ..... 00100 1 ..... ..... @qrrr_e
 
 ### Advanced SIMD scalar x indexed element
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 63f7a59f949..6571b999f49 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5456,6 +5456,8 @@ TRANS(ADD_v, do_gvec_fn3, a, tcg_gen_gvec_add)
 TRANS(SUB_v, do_gvec_fn3, a, tcg_gen_gvec_sub)
 TRANS(SHADD_v, do_gvec_fn3_no64, a, gen_gvec_shadd)
 TRANS(UHADD_v, do_gvec_fn3_no64, a, gen_gvec_uhadd)
+TRANS(SHSUB_v, do_gvec_fn3_no64, a, gen_gvec_shsub)
+TRANS(UHSUB_v, do_gvec_fn3_no64, a, gen_gvec_uhsub)
 
 static bool do_cmop_v(DisasContext *s, arg_qrrr_e *a, TCGCond cond)
 {
@@ -10923,7 +10925,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
         }
         /* fall through */
     case 0x2: /* SRHADD, URHADD */
-    case 0x4: /* SHSUB, UHSUB */
     case 0xc: /* SMAX, UMAX */
     case 0xd: /* SMIN, UMIN */
     case 0xe: /* SABD, UABD */
@@ -10949,6 +10950,7 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
 
     case 0x0: /* SHADD, UHADD */
     case 0x01: /* SQADD, UQADD */
+    case 0x04: /* SHSUB, UHSUB */
     case 0x05: /* SQSUB, UQSUB */
     case 0x06: /* CMGT, CMHI */
     case 0x07: /* CMGE, CMHS */
@@ -10967,13 +10969,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x04: /* SHSUB, UHSUB */
-        if (u) {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_uhsub, size);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_shsub, size);
-        }
-        return;
     case 0x0c: /* SMAX, UMAX */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_umax, size);
-- 
2.34.1


