Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A2CE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBDi-0007bv-62; Tue, 24 Dec 2024 15:09:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDb-0007DQ-18
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:27 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDZ-0002ze-Hw
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:26 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-215770613dbso41216155ad.2
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070964; x=1735675764; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pM1P4H8kwtouAZ2NoWkwRl0qCbuYni4Pia78By+9+hY=;
 b=QTp3ms79A+LVU76nAD4T4SzLQpRH75f+g+bJmTfbLlrbbniM5d9/AhIKJokpHfCWe/
 ITMe5Bb3IAxG28sRl1FW/uQgeksN5EdBdylAhqRPd8a7ISWbDUW1OzT6QblG/PoC5MA3
 ALvd/naTSy8cp/dmjIUDVEvEBFD17Z+T2bpemCCe93tCxjhgGomsm43X2d/5bd0cYcjN
 mQ8G7ybZ8X3yrWAw3FY2Y3EKXV2evTr8f2JhYa3a2wtz7V13vd7sQJEsMm2BU77w04ZL
 vfKK4wxxJ6B5u/sf0Dr7cHB2rXbgYYKc0/4COKkhvOMB1W+Y0vAxmzn5tjL/RvjbU+e9
 tQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070964; x=1735675764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pM1P4H8kwtouAZ2NoWkwRl0qCbuYni4Pia78By+9+hY=;
 b=sCmdn2sl2yi+HkkQQH8aqb6GK+SwU6QAwEj6nqxiHplPcf989AR0mW+daPPd54bnGk
 NPxHX0lLP47KmYABEK8qKQeC86TNqLjlQnRYodTLuktfc/boo90PikqDXF1galxn2YS3
 9pGRb13ppOYVJZ/QI3tKJReGj8SThjGBpe2js0GNBTuJkyuDBo4UpD5NPujZQ2OX8902
 rXq6xUNcgt4Q/Vz4F7t/UNJruRuLrAR7eqDwNgZMLx1wZN3YivDTTgN+DUbYf0JvzRzW
 eA2elNdM7/7JUR4/uo85H75C+Chwd6cMJum91r8Hd+CMOytp+2RQtubAl+px5suc/+gA
 b+og==
X-Gm-Message-State: AOJu0Yw4+Mu7+xKHT8lRc1hpL7EPvu87cIX/l+cIxcp9T3LChq0etV8l
 MI/uuxCP0zlWyJxHTBKi21h316LQwBBSD5tUkZ+HTtX4QRsi6/26Qw53O5tvU14FIkI3SsLcbaQ
 queU=
X-Gm-Gg: ASbGnctOciuU5qvpcXLDXRj85kgVMLydxTe345QYEP4MsTbp0ITBY/qxxpT2u8+pmLK
 ybCHi7i44HZkkDzXgU34A2zBJFMV41fkuzM8mZWo/36Dpb3v1sMZnrbM5j+3i2dKVG35Npe1I4m
 7536bxqXw4wSMz9h/JOeCO9hY3gUn2oDoKqfaFyRVvgCZ2KUhI/PeA5Sc/wGZa9iBVJwFpNlAmK
 hGLccbIf9e2eC+x7qLId3CpDn+ed88gt/2KXByM2zqenSD6/rFq/ZqHvKI7zeJNGbGPzsBYIw//
 1WzixX1U+ebrzeSaH/Ego8h0tQ==
X-Google-Smtp-Source: AGHT+IEPNAkpa+ZAxpg2BfRC8jxoRhCkHmdZVsedT9ZGErNX3et8yx1rHrmXhGchT8VKOwzuGBEy3Q==
X-Received: by 2002:a05:6a00:4096:b0:729:c7b:9385 with SMTP id
 d2e1a72fcca58-72abdd7bdecmr26688209b3a.6.1735070964271; 
 Tue, 24 Dec 2024 12:09:24 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8309acsm10033521b3a.45.2024.12.24.12.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:09:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PULL 64/72] target/hexagon: Use float32_muladd_scalbn for
 helper_sffma_sc
Date: Tue, 24 Dec 2024 12:05:13 -0800
Message-ID: <20241224200521.310066-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

This instruction has a special case that 0 * x + c returns c
without the normal sign folding that comes with 0 + -0.
Use the new float_muladd_suppress_add_product_zero to
describe this.

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hexagon/op_helper.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 95bfa5d029..53c65e852e 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -1080,15 +1080,10 @@ static float32 check_nan(float32 dst, float32 x, float_status *fp_status)
 float32 HELPER(sffma_sc)(CPUHexagonState *env, float32 RxV,
                          float32 RsV, float32 RtV, float32 PuV)
 {
-    size4s_t tmp;
     arch_fpop_start(env);
-    RxV = check_nan(RxV, RxV, &env->fp_status);
-    RxV = check_nan(RxV, RsV, &env->fp_status);
-    RxV = check_nan(RxV, RtV, &env->fp_status);
-    tmp = internal_fmafx(RsV, RtV, RxV, fSXTN(8, 64, PuV), &env->fp_status);
-    if (!(float32_is_zero(RxV) && is_zero_prod(RsV, RtV))) {
-        RxV = tmp;
-    }
+    RxV = float32_muladd_scalbn(RsV, RtV, RxV, fSXTN(8, 64, PuV),
+                                float_muladd_suppress_add_product_zero,
+                                &env->fp_status);
     arch_fpop_end(env);
     return RxV;
 }
-- 
2.43.0


