Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03FAC0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcx32-0000va-Jn; Tue, 28 Jan 2025 20:39:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx30-0000uG-4S
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:18 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2y-0003ZB-LV
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:17 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2164b662090so123698955ad.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738114755; x=1738719555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C41uiM9HmX9DdQU14esIOGr300PL7vhMHPqRUk9JveA=;
 b=NRHgZz/eGY7jpU3/sjw3GdP2Y3wv1PQWtEYmSmCLfETg1Tl7NCxu2eTLipZq8Rbb92
 BaHzT9d99veiT5V2Dpcd2a5t1yXByYHdnnxefY1FsJDXNxpK4jqul7a1bpbAjXQ/2y5K
 XgwwW9pR5eXfl3/0m6q9koIwJ1kGUqYxvr9tPqJEtZqpRFtqq6aO+lZ3PB5F9Q8kt9sW
 UouE+dfPrKdvmVprDp/o2bQCX1YDvRx9ht1QXfmSZUXted1aDWihutpcn1Dh2pBb9uGy
 ueqCcbwawXtzYLQDM8Kx4yuUOLreH+ojmw3tYTFqKZT8S19yDyHm/lXp/QX3WdikKMIy
 74PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114755; x=1738719555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C41uiM9HmX9DdQU14esIOGr300PL7vhMHPqRUk9JveA=;
 b=MB9SGE2LNvl+aYdzG/UXuwNkAScBn2VD1ICHBfnhBEQbf0x+d7wvleH26EnDFsVyps
 KSNwjBQ0kIr8H8MXs67nhfp3HQvs0uadVZnldyZeb0OI0VTmZpTI0grH5ZBN7xTF616t
 84YLWlxdXQ8fgsjxejEb8iozfTnD6KFjv3ixezFjXlVyi9TQyFZ1mUB/y2wyHvMMnZk4
 RFTtt3S1bk2v2R8ctMPvwQ+gvO0xfm/lXTtx+ZB+s+MmK5wTKwOUJ+/IuJUSwDKwDBmc
 Q+IkiHGMGfSFIHybBmdFDkOnNKFX7XaH3AOIAsBvX5Fbu2c+iIlMsSt5NjCXt1p/Ib+c
 0UIw==
X-Gm-Message-State: AOJu0YxFP4fx3rZCBW/u9Ip/xtSw0va1dtGTlFXrqgOe6nqJxeN2S3dZ
 x+coB8lDBCi9AfrWKgfNeqBhgoqB3aPrZywcuq9bgWTeiq+g84MTKLJbaDPCeFXsGupdAacj+Ee
 x
X-Gm-Gg: ASbGncvPN81XZsrFq+Az9z9u1GBJ9ZiN3ocYuzczIpfL+Bc1tpLI0SynyVyKI0YSwI9
 nsDO4XF3wnKNmlSy4eop92iqMWwMmw3Bk6YMMuwfesMq3Wl9iPFTuLoXx8e+VA2ZIUkNLDL1G8J
 6rkuxj+wl12pFLGJnMqkjbHPLWtvp5UrWf8rCp8rLWCdZot5458Gq7+59w8RdDbcy6Y3x3jFL3N
 h8u2IGYbO7BnjyBlThQ79KTDT63R8Oh21BLMnRFGWUkK2UxGspx3aVP1etQF1YSAIRAySJXwvtg
 jOMDVogk1Y6DBIhcUCPYoL+5JDX/RDb8Jezq+2PGy0OCUXi6NA==
X-Google-Smtp-Source: AGHT+IGlPHnGF3AJnQ+qw14P+8jnS8DgmQzq0xD08uXtkAwAr3FaBqlZnvsTYCqd3gkvBElI15d3Wg==
X-Received: by 2002:a17:903:2444:b0:212:1ebf:9a03 with SMTP id
 d9443c01a7336-21dd7c3c86amr18780195ad.2.1738114755175; 
 Tue, 28 Jan 2025 17:39:15 -0800 (PST)
Received: from stoup.. (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea4200sm89341745ad.88.2025.01.28.17.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 17:39:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 24/34] target/arm: Use flags for AH negation in
 float*_ah_mulsub_f
Date: Tue, 28 Jan 2025 17:38:47 -0800
Message-ID: <20250129013857.135256-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129013857.135256-1-richard.henderson@linaro.org>
References: <20250129013857.135256-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

The float_muladd_negate_product flag produces the same result
as negating either of the multiplication operands, assuming
neither of the operands are NaNs.  But since FEAT_AFP does not
negate NaNs, this behaviour is exactly what we need.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_helper.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 55bac9536f..5c1e84bf27 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -1563,22 +1563,19 @@ static float64 float64_mulsub_f(float64 dest, float64 op1, float64 op2,
 static float16 float16_ah_mulsub_f(float16 dest, float16 op1, float16 op2,
                                  float_status *stat)
 {
-    op1 = float16_is_any_nan(op1) ? op1 : float16_chs(op1);
-    return float16_muladd(op1, op2, dest, 0, stat);
+    return float16_muladd(op1, op2, dest, float_muladd_negate_product, stat);
 }
 
 static float32 float32_ah_mulsub_f(float32 dest, float32 op1, float32 op2,
                                  float_status *stat)
 {
-    op1 = float32_is_any_nan(op1) ? op1 : float32_chs(op1);
-    return float32_muladd(op1, op2, dest, 0, stat);
+    return float32_muladd(op1, op2, dest, float_muladd_negate_product, stat);
 }
 
 static float64 float64_ah_mulsub_f(float64 dest, float64 op1, float64 op2,
                                  float_status *stat)
 {
-    op1 = float64_is_any_nan(op1) ? op1 : float64_chs(op1);
-    return float64_muladd(op1, op2, dest, 0, stat);
+    return float64_muladd(op1, op2, dest, float_muladd_negate_product, stat);
 }
 
 #define DO_MULADD(NAME, FUNC, TYPE)                                        \
-- 
2.43.0


