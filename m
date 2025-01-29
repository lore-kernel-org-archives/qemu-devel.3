Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF20C0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcx2z-0000tu-V8; Tue, 28 Jan 2025 20:39:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2v-0000qq-UI
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:13 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2u-0003Xi-HT
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:13 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso112725165ad.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738114751; x=1738719551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TizWhFZw5JvY75vssZ/TpOwGEzqE+NmThakWyt0pk6I=;
 b=pba2D1f4uKLFEE2sfkvjul4Ph4WV5zRkNitz5r9VxXMBykpLvVcQ9+R6Sbg6d/Yw9C
 H66tVrcSWXzLhZd74aExz4VZWRaxIpDqgjNjLums0sjpQoNQhQB+6H+7rTicxkcOaaUm
 d2n3lfsuFFm+2WcNQrkrOXiEodM1I0fQjazyr0myNLlRkPR40yzFaQc9SZgPi81ofdwu
 Uypjy7g1XQ92Jo++miLmOiY6A4ym1obRkXDj4dDnhMrbYZ5AkB4mCO1Z7O5YGUP3Nmvv
 A3p+pCe+URKTGDpAor56O2aevycu2rym0kh+tggXVodaK8O8EI6RDpVcscawhN6LQIzC
 KvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114751; x=1738719551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TizWhFZw5JvY75vssZ/TpOwGEzqE+NmThakWyt0pk6I=;
 b=F0/tOXLrizKd6yBC5d8A0xEexDIqOCN2i4bHke3Exm+XNCbWAzDbJ7znO2x8+VhnbK
 XVCSUP90ghJYIodwLS6KcG0N7i/TBjeo143dDtQVLghT8c4zJnB5Uf1NHw1+7tXE3Ix2
 RPzo6KJ1WjUgJafBAHtne99QyLVftOq4IIHjrtUukerx9HUDdrIMOHWKfptnpmy70uIZ
 vVxq0C3QnGvAAn/Nlp8lYsivFwnLTWQ47YQ28o8usmkAuLjierGmLIDsTkNPTZYz9UWI
 YiV/5+BoZUVuChyW5BNuBRKcz4VcRpC+I8y1Mu+uKsKUoEXSRNiuFJ3HrSw1qgsp5mBu
 yG+g==
X-Gm-Message-State: AOJu0Yxc5ov26b0W6ORtq5Fb3+yXAUo1lAWWX3qJy/i+qUtIgZWkan/m
 GIqBFp9UP4X3Cipkup8RyECZcCfejMd5RDcgl5MdmP8a90QsuhxVhzXfyWLUJVQYXv9GL2baF9T
 S
X-Gm-Gg: ASbGnct6DbZC+WMyCOYuAGu0/WRI/tdaZcxzPalJcyO5aTH/id3qXy+WkHH4hdlKLji
 oXw+xTDBaXrNGoR6UJrYceUOusbQVt4M1kZ/N9umbTcb5R5MRHIvceahJSoBuvE/gI7xISQrUcb
 5ZJyHMxjuqBVM0ktDZ0tC3qiuCDCl0bf4wx6nIzeMj/oBEMGlj815AI9kvfC+xgzBfNZwJpByA8
 dsAJIrDJ5vwp8YzUvuWFV6PNK/fAJCyMdJIOTY2EmeNEH+pf3wwcPprDSi7V/hNiYpJPRaYk69c
 0/zhm1/bkP/kUddeEFzRBekfX0pTYbhOEXxPsKlzLN6CiSHFgg==
X-Google-Smtp-Source: AGHT+IE48CN9AiuSTX9PZVIaI0hs40sMBj9Ll2YbJ1fL5w4vgnfvPY3Zc26aTd6Jg7KK6rbbDdm0nQ==
X-Received: by 2002:a17:903:1205:b0:21b:d105:26a5 with SMTP id
 d9443c01a7336-21dd7ddde73mr22100215ad.38.1738114751246; 
 Tue, 28 Jan 2025 17:39:11 -0800 (PST)
Received: from stoup.. (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea4200sm89341745ad.88.2025.01.28.17.39.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 17:39:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 18/34] target/arm: Introduce float*_maybe_ah_chs
Date: Tue, 28 Jan 2025 17:38:41 -0800
Message-ID: <20250129013857.135256-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129013857.135256-1-richard.henderson@linaro.org>
References: <20250129013857.135256-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Add versions of float*_ah_chs which takes fpcr_ah.
These will help simplify some usages.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_internal.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index a673935f48..6b93b5aeb9 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -285,4 +285,19 @@ static inline float64 float64_ah_chs(float64 a)
     return float64_is_any_nan(a) ? a : float64_chs(a);
 }
 
+static inline float16 float16_maybe_ah_chs(float16 a, bool fpcr_ah)
+{
+    return fpcr_ah && float16_is_any_nan(a) ? a : float16_chs(a);
+}
+
+static inline float32 float32_maybe_ah_chs(float32 a, bool fpcr_ah)
+{
+    return fpcr_ah && float32_is_any_nan(a) ? a : float32_chs(a);
+}
+
+static inline float64 float64_maybe_ah_chs(float64 a, bool fpcr_ah)
+{
+    return fpcr_ah && float64_is_any_nan(a) ? a : float64_chs(a);
+}
+
 #endif /* TARGET_ARM_VEC_INTERNAL_H */
-- 
2.43.0


