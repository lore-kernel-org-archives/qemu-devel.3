Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F202ACA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urauJ-0003cw-DL; Thu, 28 Aug 2025 07:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urauF-0003Vr-2G
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:35:03 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urauD-0005r5-5m
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:35:02 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45b7d497ab9so1635915e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 04:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756380899; x=1756985699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jYyNxAEYuDq5SIsEhCR5IeKunK9WAoYLVLlbeucS6+w=;
 b=KE57gZxbR6q6V4WK+4z7Pr1YzD8gNf7eGPrfnwmhNSvk5MyafIzhZM6F/FSwL+2CZi
 zlquqjTumOk41rzHbr2AW0ze6vLyhbpNPe34sbQHCSPvh+00nynRgTtXBmCUcmt9EO9A
 keRM+hxRxPH47dyztNpUT0j3pJLqHx7aCfMo2RNVgOS8Mt9/63hb15/g0bysOOBr94Hl
 BPA0lfgDBE1394b4bu2Hc6AhjubGFaEFN0e7OMIfHTAJHjiZfr+t2i3yi25J68/roesB
 CbS1HOGU+t80UwCSqN2P0fWxC5KmKtJZ3lfZ3n3T0otQaHvwkNGxTOdtjQc9uU/kk22Q
 hCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756380899; x=1756985699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jYyNxAEYuDq5SIsEhCR5IeKunK9WAoYLVLlbeucS6+w=;
 b=ZjTmrLeUxlZ1wiLFHl9sgQaifAjmBR8GCDSoYbEqTQ4NT5yM5Eb6nfuqzuRtnEQex/
 TOPiFc4zPO0A0jE41/Q2X/uoCm6IlRKqXGPGKkf+WSg31zB1CzwSr+8q7IJSEJ7ygXgf
 RYUOipBKsP2qu+xBWhNZ1JYdoV7y9V7itedKM6EgLck8XOWx186Q8kcz61SprO+v+l8m
 BTvo6BAWCXRKIN1jwmXTbZVQI+lDQEjL1LTn7gZva0LjRDgeCjvQEKEqcWSo5RS9Es4e
 P4Mv6IcvfVUWtWwTya6Dy/LXy1ZO+GS2bHyBqIzMTiImWSIj2Qk8toYzLCRGEMMs9dOM
 pAaA==
X-Gm-Message-State: AOJu0Ywnj30rUUqJzEQ6xMR3DXMnTip0Pr1ZKS6KgukWch1/LovpkrxR
 o9lQX5UIFt4Q6vSgl65ZTEECTMHmw24ElwjQNQMkiV8nQl5I48Rwm1Bf2etLIfwLWQgZHOEZiF8
 3+R4K
X-Gm-Gg: ASbGnctlxwAD6n2HbJal+aoJ+PTn/Z71rMsrRehh+gZSxPL9V7ybt1n1opVcjC3LMrN
 V04fRv/78u+dhr0r/0kbW57z4caakjnpDq9GO8lmWmhzNaw94ZQjDM0N1S1uv73DuwpL7vgm+Ju
 wEoPb20vAwQ9AsdkQUwJkpOxlOkZDT9iimawDCwKSLx4YTEomYzrvxukVzQE86AMyNGNuc3TM2S
 oNYhgBLMTaaonAcSS9WTzDdryUQK4itxYYML5WKId1AR0wJ+7e87N6yd5UmFkUAhByKYJZ0zy4d
 l/QLKBRk0FYrlzNnXlkPKiiJ2x3pQlloJ8E4N0E6g5t0TeimO0O8F402+JDB0QSdwYqXdMhV4Bn
 vYPwbNPcIG2nl4PKKIq3AcMDn4yIAJ+GZMJ9ahQQ=
X-Google-Smtp-Source: AGHT+IHyoLvA+DFB0hWaLwNqkE4u1309DYmCa8J5R1JQswG9t/tmTVn7k4fKeimLpfJXWjXtLk2+eQ==
X-Received: by 2002:a05:600c:3b26:b0:456:1ac8:cac8 with SMTP id
 5b1f17b1804b1-45b517ad6c8mr196832655e9.15.1756380899179; 
 Thu, 28 Aug 2025 04:34:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b79799c33sm28691015e9.5.2025.08.28.04.34.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 04:34:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/32] target/arm: Correct condition of aa64_atomics feature
 function
Date: Thu, 28 Aug 2025 12:34:21 +0100
Message-ID: <20250828113430.3214314-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828113430.3214314-1-peter.maydell@linaro.org>
References: <20250828113430.3214314-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

The ARMv8.1-Atomics feature (renamed FEAT_LSE in more modern versions
of the Arm ARM) has always ben indicated by ID_AA64ISAR0.ATOMIC being
0b0010 or greater; 0b0001 is a reserved unused value.

We were incorrectly checking for != 0; this had no harmful effects
because all the CPUs set their value for this field to either 0
(for not having the feature) or 2 (if they do have it), but it's
better to match what the architecture specifies here.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250819145659.2165160-1-peter.maydell@linaro.org
---
 target/arm/cpu-features.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 41511d08350..d48754bcf27 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -408,7 +408,7 @@ static inline bool isar_feature_aa64_crc32(const ARMISARegisters *id)
 
 static inline bool isar_feature_aa64_atomics(const ARMISARegisters *id)
 {
-    return FIELD_EX64_IDREG(id, ID_AA64ISAR0, ATOMIC) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR0, ATOMIC) >= 2;
 }
 
 static inline bool isar_feature_aa64_rdm(const ARMISARegisters *id)
-- 
2.43.0


