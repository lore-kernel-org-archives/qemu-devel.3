Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A60DCD6E43
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:48:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvgn-0001dr-1x; Fri, 29 May 2026 07:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvgl-0001cb-GQ
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:43 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvgj-0008DU-KY
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:43 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-44a74032ff8so10352004f8f.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 04:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780055260; x=1780660060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8wRv/E3k2nzF756LIvjiKBw9+SXmuBb0NqpGmE3Ip94=;
 b=qRqCOAivZ12G9ao6sKZTAP4rfUQ/gOYIxrt4MK1ui2dbM1xm8KuGbatmWPsNUBUruv
 /p44BQfPxFetrQ/Riqv66iqZDqgMQiboL2JTucjsKS6mjngQyCnI+72Fv0hlpStIhXSq
 rMydwRKpo0t4xU4D1+xh3cfr9C9zg8OtLaw2o6uDORQyqqQat1m5NLwQmJdwAbJEoSkc
 cQT3Lpb+4AcWzjhaV6o8QQ+/s7LwaLX/CyHbXbiqmOvhLQlOzS3gNzSZMSY9J8VBcuFB
 mz/lvnAAl09v5Wkh2xYkhK4MsYRFicIAkEoAFIVsiQh0QNDsU+Q4/ZBOHZfSY3st27bD
 4GyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780055260; x=1780660060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8wRv/E3k2nzF756LIvjiKBw9+SXmuBb0NqpGmE3Ip94=;
 b=YiivilyDhKqmSpTIa9d2yC3lvDsAoKaIkwoiHLPLDd7GNP5hm7MJf1NgwmFYV1gBPe
 6ywclKSUcqlWKFq2kU8n77B8sf80ehb/Rrix0RUHX0c3gRMj8zEOlda8hbt5E2ibDxxX
 P2Fx7EOYRMB5A53NLb3090Y5zCEO6rLeWOO/jBUvLLZvPyaiLxYdsv3zofEyxFjqNAFX
 L54wxBmP58WUFaun0/TgPyHc1mrwMsQ+E4OTnESlfGgIPs1pPF/itLQalwnaZZur01fw
 e3QZ2sJswfd0UopwdJVQm9+UhYYq7oKsTTfQIg9McLrObSEnIMn6Ybfwdl9WTxpj65E8
 KKfQ==
X-Gm-Message-State: AOJu0Ywg2Y6/RA4vkTSTrHE8p+HfQvbmXZol+Ox6LhaZp2XDAVtJUZyz
 xZ47NP9TlDfpDndkNPz/XPEPDei9m0XhCMBQ3FG0vuyT7HNUjS6TZhJLHu6t/1cfYgYnIjhQs3P
 n/5gS
X-Gm-Gg: Acq92OEql2Ro4y3TiBXIK/y2VhBu/arWPSxkzuZNxNgTcXxkgL/419/x3CYGfz4FqPr
 tXl3AmiZ6vM7mRaDZ3/F4Ml6hcuG5gl5fIojaJxb+Kwkp7jj1rpvVWgHZNrnWDYbWv0cR3nYgnq
 pw7lhoUolxscj4P4Lt3yUF+banPIHXF26i2ENGNQssucxzVwd+wHDbcx5yGiOCICS03f0UKhRcr
 T3XdLojYGlWkcar6N1r5Hx0RB1LNO5cQjroRsdiOMdX2kx9lH0w85yZxnE4+DpKJmOWJ5gYayEe
 Yn3k+x2vtIkSR/jXaGeujVfxQ1DUF1s1QebXPifCIh866oWsIfWddsbZnF1DrAO9+AGR2UIleZs
 CHcEvhNwvAJ0e5TU80P4u4Q3PAWYQB/IWiIABbmTUdBuuUZ4iUB5kczhyg4XCqMbRjbJEp1B/NS
 UT55sLexscZVeSMTLdyCjwSoIj9/Kj1u7w+A1FEw0N0SkD21Kipv43B2ojDPIuv9IXai6NSwsWR
 3sP2wCh11jKlXWUsksnLmxhFS7rvOkW55JEHFf/1g==
X-Received: by 2002:a05:600c:3b10:b0:48f:e230:2a21 with SMTP id
 5b1f17b1804b1-4909c0d0f1bmr48824385e9.32.1780055260148; 
 Fri, 29 May 2026 04:47:40 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef3563cb9sm3007358f8f.29.2026.05.29.04.47.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:47:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/21] target/arm: Enable FEAT_CMPBR for -cpu max
Date: Fri, 29 May 2026 12:47:15 +0100
Message-ID: <20260529114723.42040-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529114723.42040-1-peter.maydell@linaro.org>
References: <20260529114723.42040-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260518174750.660258-5-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 linux-user/aarch64/elfload.c  | 1 +
 target/arm/tcg/cpu64.c        | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index e44b3016be..37ca4e47b8 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -35,6 +35,7 @@ the following architecture extensions:
 - FEAT_CCIDX (Extended cache index)
 - FEAT_CHK (Check Feature Status)
 - FEAT_CMOW (Control for cache maintenance permission)
+- FEAT_CMPBR (Compare and Branch instructions)
 - FEAT_CRC32 (CRC32 instructions)
 - FEAT_Crypto (Cryptographic Extension)
 - FEAT_CSSC (Common Short Sequence Compression instructions)
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index ceeeee5315..228b593316 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -170,6 +170,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_rcpc_8_3, ARM_HWCAP_A64_LRCPC);
     GET_FEATURE_ID(aa64_rcpc_8_4, ARM_HWCAP_A64_ILRCPC);
     GET_FEATURE_ID(aa64_gcs, ARM_HWCAP_A64_GCS);
+    GET_FEATURE_ID(aa64_cmpbr, ARM_HWCAP_A64_CMPBR);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index a377f67b9c..ce76e09d52 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1262,7 +1262,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR2, MOPS, 1);     /* FEAT_MOPS */
     t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);       /* FEAT_HBC */
     t = FIELD_DP64(t, ID_AA64ISAR2, WFXT, 2);     /* FEAT_WFxT */
-    t = FIELD_DP64(t, ID_AA64ISAR2, CSSC, 1);     /* FEAT_CSSC */
+    t = FIELD_DP64(t, ID_AA64ISAR2, CSSC, 2);     /* FEAT_CSSC, FEAT_CMPBR */
     t = FIELD_DP64(t, ID_AA64ISAR2, ATS1A, 1);    /* FEAT_ATS1A */
     SET_IDREG(isar, ID_AA64ISAR2, t);
 
-- 
2.43.0


