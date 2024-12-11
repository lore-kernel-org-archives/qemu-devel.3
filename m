Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F176E77182
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSP-0000bJ-3D; Wed, 11 Dec 2024 11:21:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSN-0000aI-9A
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:59 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSL-0007nQ-Qo
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:59 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-434e69857d9so5483865e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934056; x=1734538856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mgg20eSIrnOO5pFUHw3GiJXeV9/eizL/vriHmsBEKfE=;
 b=txfUR1EPDLwkLsg0hB1aiX6Uk1iLyt/AJpqA3RRqWRiM8MS/HRFnaYMMeD8JEGZ1nn
 Cwz3fAyFVzppPq9143lcnY5K6jA55Wzn/AakOxUiMzioENv78Zva2HgrLKcKsRgzdP4n
 BScStUK2yRoXlGxwJQfYw8dXWfbT2st+0/GnWhcPYaqqucaTGv7QsHbnO9szoLAmQjGZ
 FUwNRF2Uuo+KGMoaTGRjXi0g9NX46YeOtvUm4DKoDYX46fVeYImzecEpWJzkWWp13t99
 lcAVgQHLCatntRxJ2DU0MgP72x8QHZ1CgagOvcrXcz6lO/rIgNou6i+rtOQso4gkr0ma
 Es+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934056; x=1734538856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mgg20eSIrnOO5pFUHw3GiJXeV9/eizL/vriHmsBEKfE=;
 b=v2+mzRU9Bk9SvXrLNRsqbPxacXEQ1aguq9ValAHKscp6puop79vaAG7RGYcvSUbxDG
 NHNB3qC4AZV01w7X5MwuVdhDUdVlU2+AV0SkhYah/6m1mqmPArR9DLS0RvFAHejHHxrX
 gi1WHPSUeZNxrdhKlcvpV69iLdQMw3FYOqPn0O8k7nMVQXUFzS5RO1I2ltsSvYlFaB6l
 8/mYSjbWxSbcN6rr5PbNnajxkrgzcFldfgLqI/lfD92aIqg1Q7Bm/QlFDJTimzT9V01G
 VYfMde96fwbXQeacV4ECmSpVrFMJoZGx4MVRlP/jpLN/CrzohRjYBy7juJd/nnezkVFG
 0bGg==
X-Gm-Message-State: AOJu0YwsDPwsr8UZdcVAkJgHigq2Ikv/bZ277HRutwmvYxBG3gRtQQIv
 QdUuwMK4+ZqK5o/6HlNaz8+WljmrvB4jTDE25Wt9rLQrNFC3TtjzhvnmyCmN/VPjf4IaD12NPwV
 Y
X-Gm-Gg: ASbGncsqDlQOdMcaf20lvQrE0jAozGzq8iIW9GoIxWVEvuN8g1kmzBykqfmtMMEjG3v
 0131SNAV4nZA9nkOcP2/QBcV6IeqsVSpSfnsAqM+jEELgQemB7nouVvqXCtM0IEBMMNLXVTSOl7
 i1t475jwRadINwwlnL26ebu1xoMv6IFzNvUB+FV5tMka6Gg6gaKd71oEed9jVjGHXhuACPVQ2J6
 ek66m/Ymb9nGujQonWq7oD1AEHuD0xmcgCTxv3RsxfRhee7f2kSZogc+TMQ
X-Google-Smtp-Source: AGHT+IFuD6xbDKVA01OFDi2TVLbvP1/LhUc6aVTS7LriGFTQeXFI24WOqX7pisXpghIUYn+3Hj2XBA==
X-Received: by 2002:a05:600c:3ca2:b0:436:1b0b:2633 with SMTP id
 5b1f17b1804b1-4361c6050b9mr24329085e9.9.1733934056472; 
 Wed, 11 Dec 2024 08:20:56 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/72] target/i386: Set default NaN pattern explicitly
Date: Wed, 11 Dec 2024 16:19:35 +0000
Message-Id: <20241211162004.2795499-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
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

Set the default NaN pattern explicitly, and remove the ifdef from
parts64_default_nan().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-38-peter.maydell@linaro.org
---
 target/i386/tcg/fpu_helper.c   | 4 ++++
 fpu/softfloat-specialize.c.inc | 3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 4303b3356aa..d0a1e2f3c8a 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -181,6 +181,10 @@ void cpu_init_fp_statuses(CPUX86State *env)
      */
     set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->sse_status);
     set_float_3nan_prop_rule(float_3nan_prop_abc, &env->sse_status);
+    /* Default NaN: sign bit set, most significant frac bit set */
+    set_float_default_nan_pattern(0b11000000, &env->fp_status);
+    set_float_default_nan_pattern(0b11000000, &env->mmx_status);
+    set_float_default_nan_pattern(0b11000000, &env->sse_status);
 }
 
 static inline uint8_t save_exception_flags(CPUX86State *env)
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index d77404f0c47..452fe378cd2 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -139,9 +139,6 @@ static void parts64_default_nan(FloatParts64 *p, float_status *status)
 #if defined(TARGET_SPARC) || defined(TARGET_M68K)
         /* Sign bit clear, all frac bits set */
         dnan_pattern = 0b01111111;
-#elif defined(TARGET_I386) || defined(TARGET_X86_64)
-        /* Sign bit set, most significant frac bit set */
-        dnan_pattern = 0b11000000;
 #elif defined(TARGET_HPPA)
         /* Sign bit clear, msb-1 frac bit set */
         dnan_pattern = 0b00100000;
-- 
2.34.1


