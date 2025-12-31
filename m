Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67DDEEB569
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 17:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vazhD-0002Xi-44; Wed, 31 Dec 2025 12:09:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vazh7-0002WK-GN
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 12:09:09 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vazh3-0000Yq-Dd
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 12:09:08 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47d3ffa5f33so22649345e9.2
 for <qemu-devel@nongnu.org>; Wed, 31 Dec 2025 09:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767200941; x=1767805741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q9gRGfWHfjtxXAmgTOBvA8NGElHsA6CC6jlKP1KrJHU=;
 b=AIbkHfikit2Tz2jZ7cC0XshiFuKbP1gj8li2ZetagS0b6N5Oxri+9lurnvFyQwNODq
 iBqqk/waKooO+KCXtG/exEqg2Uu7cUpAU6sPY0GFT4vBvOEv7WlAgzoujQj10jt6UdX7
 2S2fOQhJLRZiEYVzRsIJi7HYLMrmz6B0g5oChp/qwUlSlIo7FGBeu8adMHDqOLprvGbt
 99F/YR9yq+zyEvYzg/kU7QmxusEx+n6QJZfufZPrbxNefASxjR5IK84WrRNZ4ZuJesED
 lzWvQHOTFGZgk5dfxvEifc3Rd9nlo8xb6VzA2bz680cGY+s+O2zPcDKauw4erweXyY4R
 Zzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767200941; x=1767805741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q9gRGfWHfjtxXAmgTOBvA8NGElHsA6CC6jlKP1KrJHU=;
 b=jXdO+rn/ktCYft3IhvVpQGBvcoedZtVMT5v3g9nRBimi4S70A1BlT42gskoSx5CzmA
 lqygRZ3Jz0Aj2Jls8y18LLaJBNs7Yj1KHpac9acGRR9v2YZ0h5uomuFemQupxjtH4aUp
 /qkS7OYGt8G+JgxvsxFxzy2IZLx1nnGlwVcVRc4eKuUq2+rMOLRMfweQn52gAuFRpeXF
 IjJ+8l7HnUFOPKAj+2YpRXXxZUz27DdnGkwC8ErQFU9HhQtXZWGE3BYDLtuoXIzDd7vN
 CpJw1gy1152MM8Elz5gg0E/HFsFWmCn2tH5/KTrj/84EQihEo0OZHFvghVR02ncD4kNo
 K9OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAOJgGx/s3cyfBdlS3dEKH9Dlxnv9ej6KczWx2CCwEsVcxKr5Qp7B0sfGGQjXPmowMCvXi2IRAZqpQ@nongnu.org
X-Gm-Message-State: AOJu0YyWDShAwZjHb5+FEhVGcOBoGmYdExOPH6EATcnPVhUu35L2Vbqh
 kD4WRmsW4M/ixj5SPYghFxDnjeqTT0ZdESCxw5Nw1DmEY2CenB8pQczh/Nn6ZmFZD0Y=
X-Gm-Gg: AY/fxX4pc9JUlVvuGJNFadLcMXZTnT8ZRTST1BNuihV6atRfUJqMsZG7KEwJHsW3Qw2
 ameUMtYjkr0LVLd/prOqtMabSJv3RXHwgruaVtVPwcZ4eTWoA/vjWVXmzB3ZZ6ZFn2YWbRxiIjl
 2ioCoiSk/MWfTQtBDeL/CzKEeuGS/bqPC5UdYUwuSlDmP6873UQlx+C3waGQwnqtgr2HTNQ6hKh
 2KCUsNSLqUkHvc6tmWL8vE3WF6aPlUTFpBZifVIjqqJF/x25a7AZw4D7SLbyQxvp4OfOtCbwpVL
 Yb+N4ujoBHDMQzue3EaW4VSoNaN3qNs2mCblZ1vpafJQLWE8d4HIxQvD4R+VUCTSKxBsbDdV4D8
 yckuPb4CLq2RzDTMRDEDbV+1W4L92QXfcV07nwSfw2lAKjWRpNg2gSeS0GxeDE8N3FsdKJZM5EP
 hT0mfIHcLIlJBCgWQG6QlGGftFzANjAnIFKP9D3SJEJJDuFGjinYUJdS3T+Cyrcm5PnFuzXviMF
 udfRpsLNfu8eR6NbUCfzLybo/ZIIsOOyHnesTyY/YtbebBEkqXgc6ee
X-Google-Smtp-Source: AGHT+IECmRubD8LCUNFDp3y5YP+oy96ChnImbpffFYz3jUA9OxD/Tvx3VADR56J43xIUN/Ndw4I98Q==
X-Received: by 2002:a05:600c:350b:b0:471:1774:3003 with SMTP id
 5b1f17b1804b1-47d1958ef07mr395042785e9.29.1767200941115; 
 Wed, 31 Dec 2025 09:09:01 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa64cesm75208990f8f.35.2025.12.31.09.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 09:09:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH 1/4] target/arm: Don't specify ID_PFR1 accessfn twice
Date: Wed, 31 Dec 2025 17:08:55 +0000
Message-ID: <20251231170858.254594-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251231170858.254594-1-peter.maydell@linaro.org>
References: <20251231170858.254594-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In the definition of ID_PFR1 we have an ifdef block; we specify the
accessfn once in the common part of the ifdef and once in the
not-user-only part, which is redundant but harmless.

The accessfn will always return success in user-only mode (because
we won't trap to EL2), so specify it only in the not-user-only
half of the ifdef, as was probably the intention.

This is only cc'd to stable to avoid a textual conflict with
the following patch, which is a bug fix.

Cc: qemu-stable@nongnu.org
Fixes: 0f150c8499e970bd ("target/arm: Constify ID_PFR1 on user emulation")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 27ebc6f29b..ec82ea6203 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6296,7 +6296,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "ID_PFR1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_NO_RAW,
-              .accessfn = access_aa32_tid3,
 #ifdef CONFIG_USER_ONLY
               .type = ARM_CP_CONST,
               .resetvalue = GET_IDREG(isar, ID_PFR1),
-- 
2.47.3


