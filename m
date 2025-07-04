Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE8BC83F0B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjGy-00012l-1h; Fri, 04 Jul 2025 12:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFH-0003O7-9I
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:39 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFF-0006tN-Iu
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:38 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45363645a8eso7856305e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646396; x=1752251196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=se2gnVwR6vM2+v9+co13XyRxuQtGJ6VFah26G5tVziA=;
 b=F2QbDTpyERrx7mQIJsq3JldJmD2FD4WvlNz67Wg3qpeECJqldKCGiESk/Hp4vp9R8x
 ssCbhDn0l1ER+qjjQqo4i49bqVH7ANIzjWHYfcb+4lYQV/Tb9UaaPNMAjIh95AO526Oy
 ZhL9nxLxHCjXLQK93suaUoQyVKCLnim0aMM2I3eShDudJRmmdT2EXFgPSv4rHzA19uF0
 dFFgNKuXpSPriF4YMNc7936pMN5t438X8OPMrhMlOoNvkbv/wBm5zeOGDXRKlAy8KApi
 L73DJN0ogQ4BTlwFfvMFo9ix7PRpf2S7Iwq/rJUHqvkgkCCEoDgu6Z81+VwEYKU3/lrQ
 3z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646396; x=1752251196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=se2gnVwR6vM2+v9+co13XyRxuQtGJ6VFah26G5tVziA=;
 b=YSVS5Cuz5lX3sh1f3Y7QkHuAyXi9E4SaopDUp/EgNeP2xMrv+bve3FdfTgfM5VyngD
 Bz9W37xp/uJv8sUY0vu5HccRzkgA2kszw9TiPfaxiYIQR9+Zesulncf+qmk44rabLCsG
 bc3vQLOhO8VNL93OEzfblYm8mjtC7O4hCd3qyWFTuGwm0AU5TaQeIN2QorROL7QFR9OZ
 wa1Otics65q0zLzfR6gV3QTfZwtoPicc/pGeOL8udqv1QlfcTb0H5jCqszuMDAMUH243
 /fOp16hrPWPx2zihz2ds7mvFraJMR3NrRjmyD0dlUc9fwx/QrakQp6KWbvjxSeyQUMIL
 3wOg==
X-Gm-Message-State: AOJu0Yw4d/GCeqqr7OsBPcpmfp+EBrYp6YCUfghnXQUgsCocI84j/hLO
 6M9HTemS5HgLsLA9URZmAUbrngEUr5ZTh8DtuUfYszqbwjQJxXbIFViCebmNsnEIaaLpVFxePWI
 Wt+e8
X-Gm-Gg: ASbGncshoJBo3JdSwUU491jawcpegZhvWXN+pxs22tfFzTfhS8VLZxrkyeAL580NpTF
 BtIHwyu/LnE+Qzou1agv21B6e4jg1e7somHRwCkamV0YYWPxY5Mf99m9oo9zztE/i4xcEjkaltF
 G8QeMN/qRcuSA2fDNhrw8MLxLMp8vFaWVXPdOpICsF0zsgWLayHim2GgEDWwfGmKSt39mCFv5Vx
 jcbce31V2kJhIxku8VDWleUOODVAG3peIUIrifhIO8AWc0SPcls+p3JPNSY1VrfPON+UveJjSZu
 2LheDNv77mRRVlhwAtiDCIQKO1omjZ2xwKv//nfuFppG+kZGgZlRU/e29Ag26FfaZYRu
X-Google-Smtp-Source: AGHT+IFqwJ9f6dgFFPJp7j+Is5q27DIbD0MWWUKybt/gl/Hj0qgud1NQAnEGfOV7wIrfEiu1w0zSPQ==
X-Received: by 2002:a05:600c:8507:b0:440:6a37:be0d with SMTP id
 5b1f17b1804b1-454b31240ccmr36401865e9.15.1751646396114; 
 Fri, 04 Jul 2025 09:26:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 098/119] target/arm: Implement BFMLSLB{L, T} for SME2/SVE2p1
Date: Fri,  4 Jul 2025 17:24:38 +0100
Message-ID: <20250704162501.249138-99-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-87-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve.decode      |  6 ++++++
 target/arm/tcg/translate-sve.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 10cac2de22f..0df33127395 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1727,18 +1727,24 @@ FMLSLT_zzzw     01100100 10 1 ..... 10 1 00 1 ..... .....  @rda_rn_rm_ex esz=2
 
 BFMLALB_zzzw    01100100 11 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 BFMLALT_zzzw    01100100 11 1 ..... 10 0 00 1 ..... .....  @rda_rn_rm_ex esz=2
+BFMLSLB_zzzw    01100100 11 1 ..... 10 1 00 0 ..... .....  @rda_rn_rm_ex esz=2
+BFMLSLT_zzzw    01100100 11 1 ..... 10 1 00 1 ..... .....  @rda_rn_rm_ex esz=2
 
 ### SVE2 floating-point dot-product
 FDOT_zzzz       01100100 00 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 BFDOT_zzzz      01100100 01 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 
 ### SVE2 floating-point multiply-add long (indexed)
+
 FMLALB_zzxw     01100100 10 1 ..... 0100.0 ..... .....     @rrxr_3a esz=2
 FMLALT_zzxw     01100100 10 1 ..... 0100.1 ..... .....     @rrxr_3a esz=2
 FMLSLB_zzxw     01100100 10 1 ..... 0110.0 ..... .....     @rrxr_3a esz=2
 FMLSLT_zzxw     01100100 10 1 ..... 0110.1 ..... .....     @rrxr_3a esz=2
+
 BFMLALB_zzxw    01100100 11 1 ..... 0100.0 ..... .....     @rrxr_3a esz=2
 BFMLALT_zzxw    01100100 11 1 ..... 0100.1 ..... .....     @rrxr_3a esz=2
+BFMLSLB_zzxw    01100100 11 1 ..... 0110.0 ..... .....     @rrxr_3a esz=2
+BFMLSLT_zzxw    01100100 11 1 ..... 0110.1 ..... .....     @rrxr_3a esz=2
 
 ### SVE2 floating-point dot-product (indexed)
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 05c0fc948a7..079d3109607 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7421,6 +7421,36 @@ static bool do_BFMLAL_zzxw(DisasContext *s, arg_rrxr_esz *a, bool sel)
 TRANS_FEAT(BFMLALB_zzxw, aa64_sve_bf16, do_BFMLAL_zzxw, a, false)
 TRANS_FEAT(BFMLALT_zzxw, aa64_sve_bf16, do_BFMLAL_zzxw, a, true)
 
+static bool do_BFMLSL_zzzw(DisasContext *s, arg_rrrr_esz *a, bool sel)
+{
+    if (s->fpcr_ah) {
+        return gen_gvec_fpst_zzzz(s, gen_helper_gvec_ah_bfmlsl,
+                                  a->rd, a->rn, a->rm, a->ra, sel, FPST_AH);
+    } else {
+        return gen_gvec_fpst_zzzz(s, gen_helper_gvec_bfmlsl,
+                                  a->rd, a->rn, a->rm, a->ra, sel, FPST_A64);
+    }
+}
+
+TRANS_FEAT(BFMLSLB_zzzw, aa64_sme2_or_sve2p1, do_BFMLSL_zzzw, a, false)
+TRANS_FEAT(BFMLSLT_zzzw, aa64_sme2_or_sve2p1, do_BFMLSL_zzzw, a, true)
+
+static bool do_BFMLSL_zzxw(DisasContext *s, arg_rrxr_esz *a, bool sel)
+{
+    if (s->fpcr_ah) {
+        return gen_gvec_fpst_zzzz(s, gen_helper_gvec_ah_bfmlsl_idx,
+                                  a->rd, a->rn, a->rm, a->ra,
+                                  (a->index << 1) | sel, FPST_AH);
+    } else {
+        return gen_gvec_fpst_zzzz(s, gen_helper_gvec_bfmlsl_idx,
+                                  a->rd, a->rn, a->rm, a->ra,
+                                  (a->index << 1) | sel, FPST_A64);
+    }
+}
+
+TRANS_FEAT(BFMLSLB_zzxw, aa64_sme2_or_sve2p1, do_BFMLSL_zzxw, a, false)
+TRANS_FEAT(BFMLSLT_zzxw, aa64_sme2_or_sve2p1, do_BFMLSL_zzxw, a, true)
+
 static bool trans_PSEL(DisasContext *s, arg_psel *a)
 {
     int vl = vec_full_reg_size(s);
-- 
2.43.0


