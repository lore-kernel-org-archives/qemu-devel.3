Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02FFCD98EE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZEB-0004iE-2k; Tue, 16 Jun 2026 15:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8S-0004iB-M5
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:49 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8L-0001Ar-3V
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:41 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-45eee266c6cso4364790f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636855; x=1782241655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7tdeWQqQChrKXEqNhu7cV02uqUE7ISdKHK1ikUIyuf0=;
 b=E0TbNX8VUfSdRhygmJW5B47rV3xc/f/acEezlvob1eehNyeKtzPClPZ9aZqLMXTWEh
 dSJ9ZYOFgYRw4XMBjq1b/xICVfu0ESW0XD3EW6bQ98ttMuZ6Epm3NmU4jEZhkW5DH7US
 MPoUMxkXhIWitTxJopa8fJUlgiqryUqRSZELRIXHaUv9ILQiVRyQVdQ87TAWR1GbKBhg
 WqNJFW8/zirJo+rKbAPIy69kzDpM73moBNjx049Nb8/YjMubUs73lZETnxzdLJkJtqUa
 fyzmJlw8mSnTdBjWUj3kdea3yC6/mXEPFLTsTgN+ngM2nGTh6GA8zXvZYu4V97Cc2bOa
 NaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636855; x=1782241655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7tdeWQqQChrKXEqNhu7cV02uqUE7ISdKHK1ikUIyuf0=;
 b=Jtbb+StHsZthXl+ry//E07y0aVEA2zKYhJxAPxtxswXe4vYSrnSt5/58jUJSKFicc1
 A58zEQrEQ5ZXKPYlYCk3eYftg8vhnCSI3mEP9NAjwJ+mn3v2gIsMIRdA+OuIFh65B6mb
 C7LD3rwlZrd47Z3AmTG8Bz24k06hmN3rCtPGR01ON2cd9iutanypyeVcQupWts202IyQ
 +VkP86j6r7VKGphQSN8e/6rS2Cx1BK0/jiV12uV8jLq2E0241soKVbTzQtQm6Z1BCX59
 Lps5rZfbpZNzkyRg1DaGVcj3Mio/6WuqwfhRJSKjZiBIgwAGCVALIOL5Gnp0WYkJOynI
 aEaA==
X-Gm-Message-State: AOJu0Yxw67F3dzc6LciFFajBtVwuT59VTp/o3VEJTftVGE5Q38UyPoMd
 ueNLEqf7l7dRATtsWS8bWpVf2EpsIv9zUEg044RhAqsDxglcNIyek5Rcts+pA0clGZRAuFYGIjN
 YZpHG
X-Gm-Gg: Acq92OHvxxWPbGkgav6YE29BWD7Z2BvsvyjsfaJ/hKNWboqPKoy7AcK7J8g0Z6khYM+
 ZQnSDARxoaFv19YwX+9y/cjQEvrMiMRZAPHinZkH7gFb627hspRwLE0yGBFaFXB3JlTArfxy08l
 iuOl8sTriyex7bPgqC3vJKQ/LsmefICDRK6kQaS8C310R83MKFw6Jwn09YeuafLDldQKEseAe0k
 zisMoEV6CyY6Z8GfuBveSoHYn5XkhVb60Z6CC3GwNbPPgmo7QJm4TbRaSKR0v1YUB3smTsR3CfM
 Ps2T0rkrJjIR8L5BlobfOlYE/qJ6u9TOcs6+cfcZHlqqQwY3zph2QtyMLSyyTk84I6fsAO4Tr+H
 BfVpP8bDET31leLk3uv8nV9AUz/ROHuZRApPfFlNnGpzdMa5TruYSR2kz07cbQpcZV7QRhAiask
 LJqpXffCsWGUmtpC0lcWbPzO17EMCPajy6VRR/creUWjXu7QxMa3yZOyb3nTswUfOcK9JRFFZGj
 +Ml7ZLzNToG8kGo/jrLhKU7SdO0dT/M
X-Received: by 2002:a05:6000:4619:b0:43f:e934:50ac with SMTP id
 ffacd0b85a97d-4623521c5f7mr1356068f8f.7.1781636855073; 
 Tue, 16 Jun 2026 12:07:35 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 48/61] target/arm: Implement SVE integer unary operations
 (predicated, zeroing)
Date: Tue, 16 Jun 2026 20:06:25 +0100
Message-ID: <20260616190639.3462006-49-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

This includes ABS, NEG, SXT{B,H,W}.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260604234852.573178-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve.decode      |  9 +++++++++
 target/arm/tcg/translate-sve.c | 15 +++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index c7e633ec4f..31b65fab1b 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -411,6 +411,15 @@ UXTH_m          00000100 .. 010 011 101 ... ..... .....         @rd_pg_rn
 SXTW_m          00000100 .. 010 100 101 ... ..... .....         @rd_pg_rn
 UXTW_m          00000100 .. 010 101 101 ... ..... .....         @rd_pg_rn
 
+ABS_z           00000100 .. 000 110 101 ... ..... .....         @rd_pg_rn
+NEG_z           00000100 .. 000 111 101 ... ..... .....         @rd_pg_rn
+SXTB_z          00000100 .. 000 000 101 ... ..... .....         @rd_pg_rn
+UXTB_z          00000100 .. 000 001 101 ... ..... .....         @rd_pg_rn
+SXTH_z          00000100 .. 000 010 101 ... ..... .....         @rd_pg_rn
+UXTH_z          00000100 .. 000 011 101 ... ..... .....         @rd_pg_rn
+SXTW_z          00000100 .. 000 100 101 ... ..... .....         @rd_pg_rn
+UXTW_z          00000100 .. 000 101 101 ... ..... .....         @rd_pg_rn
+
 ### SVE Floating Point Compare - Vectors Group
 
 # SVE floating-point compare vectors
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 8ab4526468..afbed77ec3 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -811,12 +811,14 @@ static gen_helper_gvec_3 * const sve_abs_fns[4] = {
     gen_helper_sve_abs_s, gen_helper_sve_abs_d,
 };
 TRANS_FEAT(ABS_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, sve_abs_fns[a->esz], a, 0)
+TRANS_FEAT(ABS_z, aa64_sme2p2_or_sve2p2, gen_gvec_ool_arg_zpz, sve_abs_fns[a->esz], a, 1)
 
 static gen_helper_gvec_3 * const sve_neg_fns[4] = {
     gen_helper_sve_neg_b, gen_helper_sve_neg_h,
     gen_helper_sve_neg_s, gen_helper_sve_neg_d,
 };
 TRANS_FEAT(NEG_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, sve_neg_fns[a->esz], a, 0)
+TRANS_FEAT(NEG_z, aa64_sme2p2_or_sve2p2, gen_gvec_ool_arg_zpz, sve_neg_fns[a->esz], a, 1)
 
 static gen_helper_gvec_3 * const sve_rbit_fns[4] = {
     gen_helper_sve_rbit_b, gen_helper_sve_rbit_h,
@@ -873,6 +875,8 @@ static gen_helper_gvec_3 * const sxtb_fns[4] = {
 };
 TRANS_FEAT(SXTB_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
            sxtb_fns[a->esz], a, 0)
+TRANS_FEAT(SXTB_z, aa64_sme2p2_or_sve2p2, gen_gvec_ool_arg_zpz,
+           sxtb_fns[a->esz], a, 1)
 
 static gen_helper_gvec_3 * const uxtb_fns[4] = {
     NULL,                  gen_helper_sve_uxtb_h,
@@ -880,23 +884,34 @@ static gen_helper_gvec_3 * const uxtb_fns[4] = {
 };
 TRANS_FEAT(UXTB_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
            uxtb_fns[a->esz], a, 0)
+TRANS_FEAT(UXTB_z, aa64_sme2p2_or_sve2p2, gen_gvec_ool_arg_zpz,
+           uxtb_fns[a->esz], a, 1)
 
 static gen_helper_gvec_3 * const sxth_fns[4] = {
     NULL, NULL, gen_helper_sve_sxth_s, gen_helper_sve_sxth_d
 };
 TRANS_FEAT(SXTH_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
            sxth_fns[a->esz], a, 0)
+TRANS_FEAT(SXTH_z, aa64_sme2p2_or_sve2p2, gen_gvec_ool_arg_zpz,
+           sxth_fns[a->esz], a, 1)
 
 static gen_helper_gvec_3 * const uxth_fns[4] = {
     NULL, NULL, gen_helper_sve_uxth_s, gen_helper_sve_uxth_d
 };
 TRANS_FEAT(UXTH_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
            uxth_fns[a->esz], a, 0)
+TRANS_FEAT(UXTH_z, aa64_sme2p2_or_sve2p2, gen_gvec_ool_arg_zpz,
+           uxth_fns[a->esz], a, 1)
 
 TRANS_FEAT(SXTW_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
            a->esz == 3 ? gen_helper_sve_sxtw_d : NULL, a, 0)
+TRANS_FEAT(SXTW_z, aa64_sme2p2_or_sve2p2, gen_gvec_ool_arg_zpz,
+           a->esz == 3 ? gen_helper_sve_sxtw_d : NULL, a, 1)
+
 TRANS_FEAT(UXTW_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
            a->esz == 3 ? gen_helper_sve_uxtw_d : NULL, a, 0)
+TRANS_FEAT(UXTW_z, aa64_sme2p2_or_sve2p2, gen_gvec_ool_arg_zpz,
+           a->esz == 3 ? gen_helper_sve_uxtw_d : NULL, a, 1)
 
 static gen_helper_gvec_3 * const addqv_fns[4] = {
     gen_helper_sve2p1_addqv_b, gen_helper_sve2p1_addqv_h,
-- 
2.43.0


