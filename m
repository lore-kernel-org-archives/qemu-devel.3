Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 232D9C7115C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT7z2-00054v-L4; Sat, 21 Jun 2025 19:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7z0-00053U-Dq
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:50 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7yx-0004SA-QD
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:50 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7399a2dc13fso3409430b3a.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750549846; x=1751154646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ngevJrpfMa9qOn1y51wSWsXUGe7z7FPnhspxObhWiY8=;
 b=C28kPssIhH6+YUsf29hmt/ZVIiLuD8A1AaqO40O3QtBxwhilehmdq14KTEHc/wzQJX
 wgvMHHFgI7DbCiaplZ0/P9Ro6f72CrzjSeNcuZyuwZ6d5a81GPID6jbDtM9LpsSNeNsY
 AFAG9r+FAIgzIcTbjqSwJlSMOMJkZg0v25atF2CkHXEkzzYEu2Lt+lW57SpDSpxlJolr
 8kSCsV6TVjLFno8xxhvvM48eCIKFEGux/rvv1kiWU7J1kKebKk1WxJNSrK+r1F/JZmU6
 T/6XGJQhy6+on8tLyuSZIqw3rujPeNaCcaHXRijMyk+Ypf+g1OrrZGsMT619K+P/CbPG
 j2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750549846; x=1751154646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ngevJrpfMa9qOn1y51wSWsXUGe7z7FPnhspxObhWiY8=;
 b=Zvwbh4f4TEYsr/uD2tw9Y6a02iikk8PocMB9QnvAnptzbXcE2nuvN9OI9yMyx1DeR3
 3QbFN9vAnj4yFTnARcOwIwA2CozW2LCx2eA/UQ6N/Yd9StgYfWLa+lySKYRyimPPPFCy
 Zf66RJkgfP4oNhKDt3fIU9W5cMBmZuREcravsKtrl/mC0H7+/hyulX4dTIzV56lhb9LS
 wkHBUty5PrVdqe0g7OS0xJ4/95Y8wNRuilYZuROAbtaJfT9t/CtEfMjsW9JALMLjD7Yh
 nDlCoz5vpG+WxkC2/iQE2WC0ICETcBe0BZOONvfdWcjlQkf8AKSZL/bu9+cC+2kskRRw
 wvhw==
X-Gm-Message-State: AOJu0YyMCGPDc2oylczVuGKApnu1p42Fge7n5Tg5sPZYRI3is9amIGb3
 uVn+rMWkLKzFXY5pS6wFwOxgUxPIty4GebQEhyMJghJoAIoRhdU1/YwBFJDay39iGWRWyaZv3Oz
 EKQsc
X-Gm-Gg: ASbGncv0ZNrZZLR1XnDWOAqOEZea8MrtKdwgV8zirWo8A5x5wFrFkvlqkUfZW+a2ei0
 DN6YiJvMMryDYawxtIvB2TpcUsqGuJsWJ6ee/brRanMtU9Hwnc94wiXZM2MfmrrJXO5A7RlYZ0k
 f6f5TFDbuyYrWnKdI3xu+UrdFF+iti5uiw5ghOF/4dbNGG7em/3dMkHbXVp4CoWLpB4AwZQ6Vlh
 e6d9r6lNIJG6ZarWgtLoR7Xa6/3f0u15mLsRoaKWJxlBh1V6HQr45KrAxZ9iJ2DIjj2XIf4d942
 Cf/BDHUgTt49dHWk3dMPJejkXA7pLMAB4XqRephavpTwFENXhu2qEGdfDhHQ/v4u+/NsZ3M14Wc
 Si9JaQtPfMceBJS0gMNYk
X-Google-Smtp-Source: AGHT+IEjhRzWrOf7JQqru6wRZXhGQ151Hd8zU3z5lLcTbTKOjIJmSvVaVeTHUk3IQWQ0WRKgxnkidQ==
X-Received: by 2002:a05:6a00:1250:b0:736:5664:53f3 with SMTP id
 d2e1a72fcca58-7490d75932emr10053475b3a.15.1750549846373; 
 Sat, 21 Jun 2025 16:50:46 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a49ebd0sm5073744b3a.55.2025.06.21.16.50.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:50:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 011/101] target/arm: Remove CPUARMState.vfp.scratch
Date: Sat, 21 Jun 2025 16:49:07 -0700
Message-ID: <20250621235037.74091-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

The last use of this field was removed in b2fc7be972b9.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 302c24e232..15b47a5bfc 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -668,9 +668,6 @@ typedef struct CPUArchState {
 
         uint32_t xregs[16];
 
-        /* Scratch space for aa32 neon expansion.  */
-        uint32_t scratch[8];
-
         /* There are a number of distinct float control structures. */
         float_status fp_status[FPST_COUNT];
 
-- 
2.43.0


