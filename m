Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50163E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4Xc-0000rU-NS; Tue, 07 Jan 2025 03:02:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Wi-0000CY-VR
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:25 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Wh-0002tY-G5
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:24 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-215770613dbso164901875ad.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736236882; x=1736841682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pKmXb1m3DMp90fmFisjNG4WdmYNCL6RTfNDqnFc9oqQ=;
 b=mlYXWCgjgpM5HlJMhwewu8zMhU5+7EcmUGucgPY8YIRou8dsMZVd2hxr4KZ6IRhlZX
 ri5ZZ4v3WWjOV5LzmVr+dgnUObK8kmqYtH/fEOSxHkkB4ZVQM0WsMu9/c0dE+ehPYkPQ
 ea7vEWA4BMbVT8IRNCvoJmrOD5p0L6T/DoDHI+P8Iz/8QC1eP1ryvcUZyRgpYyf3PIat
 FrjUSpnuoja5YrGD58eUbgZ45LRs9VD3eZF7Y8YWXFmDQweGFH3ilV6NiT1N9iwScGHw
 1wVHtMlhMofI/MJYfvPTHBqEaKNIQfo9AkevqA29rAyyc3iJIVt5sdGI8pivzg8yhbwc
 xacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736236882; x=1736841682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pKmXb1m3DMp90fmFisjNG4WdmYNCL6RTfNDqnFc9oqQ=;
 b=SL/XmmV6cL9+U47gCINQiSf41VAo6j62zN6BwRK6VaPBqD90p5b5vuyeHUoK3EboCX
 iCoHJM0vr+o3supsArBZ8fhdRZorY326ZTvxlDTi9sIuhLDekOKTwEOZWJe6vf7TnbQ2
 2ZXI6CG0ovhrAUbkLjbhFbZNfV1vVeEqK17FEYCtXvFeNzRDRfE6Tmly5D1pAhjF5uHq
 x4MoLGBuHv/xIq+XvUAHkW5g53WAYhOd9Pk1WPicSNttyx2QDNKcEEJoFt7KSql7NO4R
 P0S4UtVYyNSJgW4QqfqKYpMfmtv2JzUCiOtF4Q6U0YrC2DaFh+Wh/zc9gs9zeHkCt3kk
 aWyg==
X-Gm-Message-State: AOJu0YwhGR1sMTFItCY5lcL62FLIqYLkugB/WVl+K0MxwJUC70kMxU91
 JXE/f7cEO0Xw+YIeCh3cdkWbeuQTWQVhXHuw2vzWTMjTPO+mQosJoSRwYxbo4SYe1OuR0DNRM0N
 6
X-Gm-Gg: ASbGncuXffUvxuD4OBzuVuMwuIVUgHIMKdCr4VsV3r+Qptwz3Q7d7W/7ujJwhD8D/Qy
 465tgPfMQjltchGg4jRxVkRf/uwBtzeUo9UXl6Ti3ZugqOgKWdAfco5Sk0S/mEwSo4g+1UKR7fQ
 oNZBm8VxICzIfAWB8sU/aQIG7nsNDHispFtwFkLWBRs3l1wZhYG0rTL9HNZWuu75eHrKDOjubSv
 sCAd3+i9ozldwEw9Gf/ZUqMkQRUWWLfBgbFf2a4+/1DsVILbLa3fPlLgg2ognfIXa03k3fi2zgP
 1LD4vKbhxFsa+G6vWQ==
X-Google-Smtp-Source: AGHT+IHfFTecU6lzpJzWtCGaKeSJoO7gIGiYdOG38PLKl5WLN7Ehk38sznzrJIvS+p+aeLGTrBELUQ==
X-Received: by 2002:a17:903:32c5:b0:215:e98c:c5bb with SMTP id
 d9443c01a7336-219e6eb43d6mr894059505ad.28.1736236882107; 
 Tue, 07 Jan 2025 00:01:22 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eb12sm306765995ad.87.2025.01.07.00.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:01:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 07/81] target/arm: Do not test TCG_TARGET_HAS_bitsel_vec
Date: Mon,  6 Jan 2025 23:59:58 -0800
Message-ID: <20250107080112.1175095-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Rely on tcg-op-vec.c to expand the opcode if missing.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 49d32fabc9..732453db6f 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -596,14 +596,8 @@ static void gen_bsl1n_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_i64 k)
 static void gen_bsl1n_vec(unsigned vece, TCGv_vec d, TCGv_vec n,
                           TCGv_vec m, TCGv_vec k)
 {
-    if (TCG_TARGET_HAS_bitsel_vec) {
-        tcg_gen_not_vec(vece, n, n);
-        tcg_gen_bitsel_vec(vece, d, k, n, m);
-    } else {
-        tcg_gen_andc_vec(vece, n, k, n);
-        tcg_gen_andc_vec(vece, m, m, k);
-        tcg_gen_or_vec(vece, d, n, m);
-    }
+    tcg_gen_not_vec(vece, n, n);
+    tcg_gen_bitsel_vec(vece, d, k, n, m);
 }
 
 static void gen_bsl1n(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
@@ -640,14 +634,8 @@ static void gen_bsl2n_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_i64 k)
 static void gen_bsl2n_vec(unsigned vece, TCGv_vec d, TCGv_vec n,
                           TCGv_vec m, TCGv_vec k)
 {
-    if (TCG_TARGET_HAS_bitsel_vec) {
-        tcg_gen_not_vec(vece, m, m);
-        tcg_gen_bitsel_vec(vece, d, k, n, m);
-    } else {
-        tcg_gen_and_vec(vece, n, n, k);
-        tcg_gen_or_vec(vece, m, m, k);
-        tcg_gen_orc_vec(vece, d, n, m);
-    }
+    tcg_gen_not_vec(vece, m, m);
+    tcg_gen_bitsel_vec(vece, d, k, n, m);
 }
 
 static void gen_bsl2n(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
-- 
2.43.0


