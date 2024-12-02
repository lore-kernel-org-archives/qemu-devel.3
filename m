Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FD7D78321
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6Yu-0002dS-LM; Mon, 02 Dec 2024 08:34:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6HB-0003Iv-CA
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:49 -0500
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6Ga-0003rD-2M
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:40 -0500
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2ffd6af012eso50644091fa.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145306; x=1733750106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3+p59mil36Jx5sXbuX/nuYCVFK4hOA1MfgGjeXhWnZ8=;
 b=COGpc1P5T2J984nvpF754D+jXTsAkTONxHk/yRRvs1X5Xk3g1i8l00b0mIfXKOr6QK
 w96wi5r2B9ZCgw8WdVzHYOdgZPYAGKv07oJfg63hF7BWPM7bfvi+IYnNQZAX4iHLM598
 H0yEOgqIIWtTYi8+cXdHkRzHsZNFViy2C7DJO4vzqNghNX4lqQUQBgUgSnhWXoWRtXSh
 9a7F/DkRxlK3b/uYFWpSu2kBpgZz/AmeUNq6dm0O/EZqZbsw6gDTRkHKH1sucwNhXbW7
 vMFvHvRobF8nd5V8q2rHWrPo1h6+iqWVjlrcfDyDvA9kaIdk3VX5TpIO6jzAHVvzaRG9
 1r3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145306; x=1733750106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3+p59mil36Jx5sXbuX/nuYCVFK4hOA1MfgGjeXhWnZ8=;
 b=oD0WQMViGOMQkYcXgnqrKY0dCHrl5I8W6FXmjW0FmaRIT4iuAe8+PVPmccT3wuqRcM
 PdqZKfulQd0rkq5O9+aRR32o87ECtjVJVooR0nSGpcHe/d01YwukCHEzPwvjX/9WtknX
 //qY4lkMOg7bbc3NoQzuRQ8ZEJfFbSWh5mOe4ODm3hj7PVDvR0tpQztCsGhGSuzWGPZj
 /jeqWOv33D+qx/FFNmynukXAE+KlAghu+OLaDbnTNeA5xcKBOedfJWIXluN6yXhTq7Yo
 LzcbunBGRex3J+UsVuvVa4YDo00FfYMEpAX0SEVpuiN27ekdXpubQgrio8GmnilSXJV2
 fKug==
X-Gm-Message-State: AOJu0YzB2nSrSkSlwYLG+Kl/gllEKM2oLTOL+lfCWadGPdh02M+xtj09
 fitAbMjBmy4uuVsILJAlbVa0QovRnc1Dl/O/Vhl7/fqX4FtVUe5kf9vGNnArOGh4Fym2MU/Mp78
 C
X-Gm-Gg: ASbGnctpZLohWPodnKCOSO4ld//vnuiZXB95oxJ872/+s1KKpol+8se+k7/xfrey3Qm
 d4oJVd/QezNe1oGwIBDtM0upIGAoPx47yjyqtY+ArA95RmPk3B4vMkNtphak0fHvf3tB5tGPfWr
 cd2axCSsE7GfkzCEIuv2i39X1cYFDIirAZhni59UbRyLISfN8d9N6X+d/fKK1jYm2sbAMBHA+pJ
 Jur1T4f0EYOWU5Fw7hGu6kmy/wnk4ImFOdWDWnAWK5LJ3hWOzX3UB4=
X-Google-Smtp-Source: AGHT+IHphx87kWVxOi7U2XvnsxZQjFZxWWWkqumFQb2lLvHXTj2payivvRcQYH/MGvdQ+/OF8DxViQ==
X-Received: by 2002:a05:6512:224f:b0:53d:d3f1:13aa with SMTP id
 2adb3069b0e04-53df00d1177mr12216593e87.20.1733145305814; 
 Mon, 02 Dec 2024 05:15:05 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:15:05 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 for-10.0 54/54] fpu: Remove default handling for
 dnan_pattern
Date: Mon,  2 Dec 2024 13:13:47 +0000
Message-Id: <20241202131347.498124-55-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
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

Now that all our targets have bene converted to explicitly specify
their pattern for the default NaN value we can remove the remaining
fallback code in parts64_default_nan().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 fpu/softfloat-specialize.c.inc | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 5954a6213b9..e075c47889a 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -135,20 +135,6 @@ static void parts64_default_nan(FloatParts64 *p, float_status *status)
     uint64_t frac;
     uint8_t dnan_pattern = status->default_nan_pattern;
 
-    if (dnan_pattern == 0) {
-        /*
-         * This case is true for Alpha, ARM, MIPS, OpenRISC, PPC, RISC-V,
-         * S390, SH4, TriCore, and Xtensa.  Our other supported targets
-         * do not have floating-point.
-         */
-        if (snan_bit_is_one(status)) {
-            /* sign bit clear, set all frac bits other than msb */
-            dnan_pattern = 0b00111111;
-        } else {
-            /* sign bit clear, set frac msb */
-            dnan_pattern = 0b01000000;
-        }
-    }
     assert(dnan_pattern != 0);
 
     sign = dnan_pattern >> 7;
-- 
2.34.1


