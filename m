Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71436CD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 15:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSclL-0002Kq-W4; Thu, 28 May 2026 11:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wSclA-0002Gc-Et
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:35:04 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wScl7-0007Ws-Hr
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:35:00 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49050ff7cbdso54388195e9.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 08:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779982495; x=1780587295; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1qXL1l1v7Mc9jI0Bv0/cp9n0LoICATpSs3WZIgkwsgA=;
 b=CrY/SyjfXwF/bb2qTPmkgMoG/pr9QblrHuCxoOkPW3EQH7bDI2DGzYteS+0NWzo7Au
 pZoKoWi+KkjllWOrJh4/8VsKTWYS8ElIfnbsGqX4MRA4DaWcUQ3X9xP5RjjAkSORFV+j
 g5Xpdc5ahY+X31l1qiBWXOIw9dXgfHZiGFtP2/jqEHpEbbkTQGAhiZzkH330EcwTLOtL
 ogVx0iGzYs81O7HFcd46NR6Hn2LM6SU5Zk8lPxH2Ech/Crb75eaSs/i/s+ieD6mIlpE6
 5a9ukIZWSRp0mDfqzxo+BxDMnxfBY81vbPZ1muplPONTsfBoIHarfsKeVaSn0+aZZRjK
 U0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779982495; x=1780587295;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1qXL1l1v7Mc9jI0Bv0/cp9n0LoICATpSs3WZIgkwsgA=;
 b=fE0uOkJgyizGya7Y4jHNWJcHlDIvbBhgYWHRssnpbYDyHsh5pV6YA+RS36AdY1m4mJ
 C3b6ZXT1nv+HF8Kwgy6sqAYGdCnhfaYELZbLkeyIbjhB3Zxl0VwGKvBYa8hBIEMNtFe+
 Xzblt6iLDfteRW0JGzJasgZi2srNeBycEqgPaUVdhVKp43aDEoA0EizbvLWJNWF9WpSk
 Fm1ImC1n+mprguOtM3+IBIJlgXq9PDtdLaA6HnGt7TV7m/RCd2GKZ0cEndLP/xlrryRZ
 J+wIcsJa2dr58vB2JM1Qz9Ia8MSgcBpkqFIp9dMTtFtiNzIOXbv2tqXVAzwisNj8XoWy
 VvAg==
X-Gm-Message-State: AOJu0Yyxqwv1YTIseHSCvUTr2VsA3zsUZ1yKSFSqzFnjdd97TiaMp+Ha
 91Bse9W6HYll2E5BlvUWO1vsHGZS8GgNA9E4PLHJg1WzfaiVzYV9FwJrmG8Tf6fLZxo=
X-Gm-Gg: Acq92OE+4PyVdNCV/Vpa/9WNZWTXd3b3oDK2JDVd+XzHNHsfJtXTKPKPyK/Ebs3Y9kz
 wWFNRc7szT8LDipNgwTdDFAeLKZzsXPmPogDczoVgzUAMuqdTPZxuoe4kwvG3ag29Z2Yzb9c8XB
 th7CdkHOa/dEz3p99UGmsfJwGF2vFWrLgYe2bEkUS7AnG0YnGeeS9V+XyPifbH5TDI6FGGZqW64
 zNZt7onsdM8l3jMghuN09kr53ZujvETMbUZzbh/jpTegv+LkC7mQPtlYjFK7gNiTBFxQKtRSHoP
 5+ZsMyAfs9bzNy3sm1XL0kg1lKD3+Jt5xmxHydMf1Yo1cARaz+VeLF2JNwy/X1O6ezG8dhZXN5i
 YjnQAshgFyF31Wgt812L+IjF3HW26pClUbJrBKgI3xDxEu/2fAS+nqtMiGUDJQPv8+Wil0sztZt
 N6LrGfzH5YWNgESaqG2liGOVydU4qmqWjZFGMHcA==
X-Received: by 2002:a05:600c:3581:b0:490:482c:4391 with SMTP id
 5b1f17b1804b1-490482c4586mr493006935e9.23.1779982495493; 
 Thu, 28 May 2026 08:34:55 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:f5a7:372a:ab8b:3c01])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909298d41bsm46514785e9.11.2026.05.28.08.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 08:34:55 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Thu, 28 May 2026 16:34:36 +0100
Subject: [PATCH 1/5] target/arm/cpu-features.h: x-rme now means GPC3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-jmac-gpc3b-v1-1-d34c46c5069f@linaro.org>
References: <20260528-jmac-gpc3b-v1-0-d34c46c5069f@linaro.org>
In-Reply-To: <20260528-jmac-gpc3b-v1-0-d34c46c5069f@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x330.google.com
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

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 target/arm/cpu-features.h | 5 +++++
 target/arm/tcg/cpu64.c    | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index f9c979d20b..6819d5f6a7 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1138,6 +1138,11 @@ static inline bool isar_feature_aa64_rme_gpc2(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64PFR0, RME) >= 2;
 }
 
+static inline bool isar_feature_aa64_rme_gpc3(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64PFR0, RME) >= 3;
+}
+
 static inline bool isar_feature_aa64_dit(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64PFR0, DIT) != 0;
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index a377f67b9c..53f0ea0404 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -159,8 +159,8 @@ static void cpu_arm_set_rme(Object *obj, bool value, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(obj);
 
-    /* Enable FEAT_RME_GPC2 */
-    FIELD_DP64_IDREG(&cpu->isar, ID_AA64PFR0, RME, value ? 2 : 0);
+    /* Enable FEAT_RME_GPC3 */
+    FIELD_DP64_IDREG(&cpu->isar, ID_AA64PFR0, RME, value ? 3 : 0);
 }
 
 static void cpu_max_set_l0gptsz(Object *obj, Visitor *v, const char *name,

-- 
2.43.0


