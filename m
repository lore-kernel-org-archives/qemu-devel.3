Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF04C83F07
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 15:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYnyZ-00057e-Pi; Mon, 07 Jul 2025 11:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYnZS-000575-6P
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 11:15:54 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYnZQ-00024k-Cg
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 11:15:53 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2da3c572a0bso2954514fac.3
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 08:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751901351; x=1752506151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bI3cu7GDszasTfxVkgNgSTZnwpreTUViKPsKKclbv5c=;
 b=QXR+gbPtnJe8QsoIqc1IEsha8IJ5q6rmTZiTYVDbNflibzmKJ0NMZK+BqboW2IIC48
 IRd2hV7fxtluE+LdwAY9cTOqAg3CyrGYeTB6caONlP/LRCzrSq7Y3Sy61ab3X1E46N26
 /W5T9xNg7sTaErcHt4xt/vJdZM6eM7xMHYMGsI6FtggzFvoWMIJgcTrYaw7wsbpShlCC
 Faiyr4cgotbL6+pluhf5Klbv6NhZtbASWf2Xv49SKrEhgsZcYWjTyk4HlIyri++xqsFQ
 sq+mQByUgq6K0n96PGkDgpU1Qontkt3nw6/9Co4+dRFSK8PKCAvYrns4A/JDWtSZyKiP
 YWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751901351; x=1752506151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bI3cu7GDszasTfxVkgNgSTZnwpreTUViKPsKKclbv5c=;
 b=g/JlIq3w+T3LO9dLOLS7Pz7J3BaEUx8rnhyNgeoujF0IF9OojPGv+KLm+AZjgbnCyK
 SljHV/05cwbY8wdcPmQYLRkOAge+bRfwIEfFcZZ4QAK9t+E6bFXL1GIaWdxWZDxk9LQ4
 ORnrpIhH/RvUPZWetxrCypBuX3Hscg1bJbMr7ZMPFt3mO2pGXg79SlnYZh/1vEgMhdaZ
 yjobFlZmLwTaW9FM2Cs47/SYk0CImWql+71c8Kb6hFkCrxCwpaWh5QiXPbMOIW9bRzyN
 v8Y9BlM9SqC7c8JtS+qDcPMValnfyUz7NhTPMpw4HdHjUOoTPRP+h2PVEPfbTfuPV4oJ
 Yjhw==
X-Gm-Message-State: AOJu0Yx/PSaFQIwYqbDqV5bnhV7VH3KIKNYaeLByRKgBKFvHETvq1jEH
 ptRtQ7qLN7BX17nPkVh9Awks/8R8RlWPZ+URuUy7UnyKLbL4qVz/Kuh1bVfWLXn3vsIm1JwSnuX
 J6DLZwiM=
X-Gm-Gg: ASbGncs4HwtueFGz9MsGknoBk+/9R3lAcGaA5OTMfYPf9PJQZEdZKTVdcbGylNPko1f
 K3qFaUbX5tdV6PNa2vgyohq/5xLYAo70ur2dIaBKNYVwOUfe4tj2TXi39/GsAzk9pFkqEaWUTC7
 stkBdCnpJtVG8IQJYsGFnRlV5ArMmMf6zRh8rkSOhxTnqswWGAgPo9aT+tFtTEEw77wi1z1NAuD
 KjKifTNBettHW9dRSllJQqUrnzw3gftGzhFuokvo5OucIfCxsGqywDZt53HIUWr1JbpznZ64vee
 uudXnXeM/n9h4YECqvZrSMyIZKg6pZdTfWks6T386WvNA8T7r37ZTLPKVeBtVuj0b8OdHxEfEeo
 c61nUfRqMBkDXuBVZfQakW02W30R6KH9tDRmBRoc9W7dymkwQqe7gofM1vN0=
X-Google-Smtp-Source: AGHT+IHid/1s77zFJznhPNtc4waNTG6ZiwAd6BjuxaThkEm9l34a9d2/7WGISJrTmjJTUY4La420HQ==
X-Received: by 2002:a05:6870:37d1:b0:2ea:83e7:d525 with SMTP id
 586e51a60fabf-2f7afdb198emr7208169fac.16.1751901350380; 
 Mon, 07 Jul 2025 08:15:50 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f7902d65f6sm2236393fac.46.2025.07.07.08.15.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 08:15:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] target/arm: Drop stub for define_tlb_insn_regs
Date: Mon,  7 Jul 2025 09:15:45 -0600
Message-ID: <20250707151547.196393-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707151547.196393-1-richard.henderson@linaro.org>
References: <20250707151547.196393-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Allow the call to be compiled out by protecting it
with tcg_enabled.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c    | 4 +++-
 target/arm/tcg-stubs.c | 5 -----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c311d2df21..be84954360 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7767,7 +7767,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     }
 
 #ifndef CONFIG_USER_ONLY
-    define_tlb_insn_regs(cpu);
+    if (tcg_enabled()) {
+        define_tlb_insn_regs(cpu);
+    }
 #endif
 
     if (arm_feature(env, ARM_FEATURE_V6)) {
diff --git a/target/arm/tcg-stubs.c b/target/arm/tcg-stubs.c
index 5e5166c049..aac99b2672 100644
--- a/target/arm/tcg-stubs.c
+++ b/target/arm/tcg-stubs.c
@@ -22,11 +22,6 @@ void raise_exception_ra(CPUARMState *env, uint32_t excp, uint32_t syndrome,
     g_assert_not_reached();
 }
 
-/* TLBI insns are only used by TCG, so we don't need to do anything for KVM */
-void define_tlb_insn_regs(ARMCPU *cpu)
-{
-}
-
 /* With KVM, we never use float_status, so these can be no-ops */
 void arm_set_default_fp_behaviours(float_status *s)
 {
-- 
2.43.0


