Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA296C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg80T-0007LP-5S; Thu, 06 Feb 2025 14:57:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg809-0007Bd-D6
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:29 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg807-0000Uc-Km
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:29 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21670dce0a7so32021585ad.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 11:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738871846; x=1739476646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pFaoy44FDyHM6oS2Rh4MY30zSGm4TJHCV7byOMX8lW8=;
 b=cdKjcCk0s/ILr4XSzI9DyPAdFHCvqs9ykdp6D6/dUHi7bdQOW7PuU6I3FJePXYXcVL
 UiAlRbK7wkOF8wQawKKmT/neOtZk4uqFa5D7MG3RtEpmsDv9O2HAN0n81aawcwINFJow
 jg4kUcIQ2ioDt/ghBo99uYsE2HNg4KMF61d+Zgt2AMiQwBV6+hfkD1E8+xjQpgwMGl2B
 6rv55lED54wWz+f/bk8lNOER1QbI925UAkeisiEuVRv7KOXdXlnKXxbPjrx/ShTZN/Dp
 iEaltEpGHZP765J7Wrpi1RjTu5miNGHuzD+2jJnsayTXFJZ7OV7lzDqxHrAofPTRuc37
 a+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738871846; x=1739476646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pFaoy44FDyHM6oS2Rh4MY30zSGm4TJHCV7byOMX8lW8=;
 b=gQQGib8SYph2LlzptKsGMKN4YkOler5QYj4b4+tbb4+kSZ/8qt57FAZSXl99pQJ8IF
 Ci2oU2uV8vMIUZ6chDPFAcjd856VFidvxtcG9iCYv+1i6AAcS/YSdEzh3CuH4LL3B1kM
 5ioQipBX4yARA1BI9XjBaWQ7AfqEVYJ1R7irfxjdhdcnF1echlUUVCasX9Mbus8WBUNc
 S49AqJSGI6CVKAfPwjUlDieglhyx1e1+6VfGhgME59kjN94YhdwqqHelmCHwJ18SCzpH
 OctCacFUc7xWts8n1lcYM9J9yw56xqmsTPTRnqruAbH89TlonQCXFlUKgThk1huQ+g2j
 7oIg==
X-Gm-Message-State: AOJu0YzIL6MG0Hj/LdwKyms8Ky+C6aB7aKZcONsvhwwcDKpIoRqQ8+qO
 9xNG+kMkmbnwPFXKTVov7BWWsq+UIWLfLSTMEEpQg7Or/75/9ZomAL91uQVKDxt9wyu+PS/ip9g
 C
X-Gm-Gg: ASbGnctz4KM540Ed9UWCCTfHeWRBAnXJviNOVn4ddS6bqek1ijYl6KHmtotTjZAqg2k
 JMY4m1PO+X2L5vkByyEgB8X6HJivXtHegJGLTdCnRgXCTmBz7KeHM4u+qVahsl64p/M47TxrFb4
 4AODf6sramx6/38ANCqwFlt/u9Swh7xBP33cxOtD+BbH7PCMazFPSPjprDZ8ls13S4lZto8Hqnl
 +AKHE6paJ7tRKTBUvaU/jLA4Y7B4blobnrdn0pfy7V4oLXUwN8rF2Vko8zsVcFZ0nLB3Cuw509a
 FTrthpXh4KvxRxwS3cHxYps/GfsQkVq32CkTmRXuj1JcTkw=
X-Google-Smtp-Source: AGHT+IEN7EfeBGWPPKvUe4Fr5e9MX7FAKd5qgrhnTvUeZ2RbMcGMGBLUb5y8g680aOfHGou2ZRR9AA==
X-Received: by 2002:a05:6a21:3a8d:b0:1e0:b5ae:8fc1 with SMTP id
 adf61e73a8af0-1ee03a3d141mr1494218637.13.1738871846308; 
 Thu, 06 Feb 2025 11:57:26 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048c16370sm1666993b3a.152.2025.02.06.11.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 11:57:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 13/61] target/arm: Add ZT0
Date: Thu,  6 Feb 2025 11:56:27 -0800
Message-ID: <20250206195715.2150758-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

This is a 512-bit array introduced with SME2.
Save it only when ZA is in use.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h     |  3 +++
 target/arm/machine.c | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 938c990854..091a517a93 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -734,6 +734,9 @@ typedef struct CPUArchState {
     uint64_t scxtnum_el[4];
 
     struct {
+        /* SME2 ZT0 -- 512 bit array, with data ordered like ARMVectorReg. */
+        uint64_t zt0[512 / 64] QEMU_ALIGNED(16);
+
         /*
          * SME ZA storage -- 256 x 256 byte array, with bytes in host
          * word order, as we do with vfp.zregs[].  This corresponds to
diff --git a/target/arm/machine.c b/target/arm/machine.c
index d41da414b3..416fe1b7be 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -320,6 +320,26 @@ static const VMStateDescription vmstate_za = {
         VMSTATE_END_OF_LIST()
     }
 };
+
+static bool zt0_needed(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+
+    return za_needed(cpu) && cpu_isar_feature(aa64_sme2, cpu);
+}
+
+static const VMStateDescription vmstate_zt0 = {
+    .name = "cpu/zt0",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = zt0_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64_ARRAY(env.za_state.zt0, ARMCPU,
+                             ARRAY_SIZE(((CPUARMState *)0)->za_state.zt0)),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 #endif /* AARCH64 */
 
 static bool serror_needed(void *opaque)
@@ -1104,6 +1124,7 @@ const VMStateDescription vmstate_arm_cpu = {
 #ifdef TARGET_AARCH64
         &vmstate_sve,
         &vmstate_za,
+        &vmstate_zt0,
 #endif
         &vmstate_serror,
         &vmstate_irq_line_state,
-- 
2.43.0


