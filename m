Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02FFCA5FAD
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUf6-0007DO-2Y; Tue, 29 Sep 2026 06:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUf2-00076G-MU
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:08 -0400
Received: from mail-ed2-x0f.google.com ([2a00:1450:4864:33::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUf0-0008Cr-UO
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:08 -0400
Received: by mail-ed2-x0f.google.com with SMTP id
 4fb4d7f45d1cf-6aaf10bf094so5330876a12.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790676125; x=1791280925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZecOmEL0EosAEgUUdUpmmCK1UvTTzJmCXcuxyvRlH+8=;
 b=uWiRJ0LWjvMSGIVCjs6ydrAWFqXXzOTIJZ1ct6wanCxWU7zxrtsPfr99tIg6RBqfjA
 UmTIMTEH0ffe250gEcAGq2lLUYM+MkBb75nN7YoChGrWPrWLI/rpzFA9MyH8a3r398FX
 lDzcgdsJ31+Hjss2iQHM7OaDAmGeYR+mjPTIWcGMj6sB1Ph6TrDgwhG1yge4Y9jRM7ye
 /bVPSe2LoHIVhMbvzIP/6cMEYvINZnJtZ+UNa6jbqDztmm0gMz86bpQhBMIcGnPVP4KY
 jStA2MXypJo5/4F3UzMSvId2xt2b50sQTY6886Lnq3Y7bfhSVihLBsvJJDmrM7Ze1XoS
 G+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676125; x=1791280925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZecOmEL0EosAEgUUdUpmmCK1UvTTzJmCXcuxyvRlH+8=;
 b=kQmVNymR46gueW8MzP9vBxCKLoDmjSbf2RH1+b4C1ERb7cKwm91wKHv6PQWcwY/Ykf
 Hm6lAz6XKw6UjJ08BxEG/aA1P85PivlAlB8zriLOVbTMznxy6T3HRMgfvkIVZJrXbj37
 +JYSAhQCJN7nOxWo43d6iIo96QQ3Ah35IoZ/yxKYH9KgxDtG9qG/lq9XPIvePsSe/L+Q
 MkcZN0J34JNBimODUfzlBraUHL213mn4Wpd99g7GBVAEyxTO98T3DP0RWhoh78PoWE08
 ZO7k+a+pck30nwp5rC+ZN8Alys5ocRYkEaeFHEfRPpZf4sw/AoZ1NpfH+zPuuxzlb/xx
 OvBw==
X-Gm-Message-State: AFq9FYJ8xm1cloE4s/9GYuFti3Hp+jZKNYObb4dXvq3BXI7b48O77FOj
 Sf57Z+nSbea2UsvTWcA+J4PE0mdGFZa+trOBlWRYrUXoh36erhDzcx6Nq+6BRIpaRZ5JiJ0qrTG
 99JDu
X-Gm-Gg: AYBFou0PapjNu++Y0EOMRQcFOvyXa1AZKJO/kwnXfid+1dfQCf/Gof58rjR4eFTRDlN
 pDQXBcTEiLWowWFQXtdeqYRdJdeojy960PuaL2yCSk1rMBMeEvRpKEvgAtdqbdsyRQI7iu5k2i0
 giJ+GSMXCbaM/66uBc0NfxVxZckoMv6bA3yXtGhPTQyqISFftPnTZ21QnveGKzI8E4a/9LOHYqI
 l9hdTHomxTOfbQG7oE9cDUsxha/cYPjWnzt2wf85vqYL3Kt5q/Wkq6W0xFZld5WIhMQ0Sd2Nhfy
 dRQhNvuMM7BIPznCff37NPndmRH6sWeE1lzNf7xBMhM1zhFI6hDylE2ee+hognbcJQ87BiJqzEm
 2hmqrlg6akCa4OSQqSjBLouE9lNux/hk2gsHSNaY2h4v1mpwsceGrAOCAunECShhBuocDIu6jvu
 vp+AWfGyEXgRjKm7iNY6S3G5RL1eSHXugwhuJis0pfMB4K2tWqYY2CSngy0L8b9hZv9bRQ497ZP
 FyMQNWcPB5uHH/LipxM9UPPfm8OczptcAa3+EFJ8DjU9YZhS/7W+rHreGHdIUPAmDVJZMOko4nf
 Ki2/b2X2PVGB1w==
X-Received: by 2002:a05:6402:454c:b0:6aa:734b:1a28 with SMTP id
 4fb4d7f45d1cf-6aac8f828cdmr9674939a12.34.1790676125061; 
 Tue, 29 Sep 2026 03:02:05 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88b37sm3091412f8f.5.2026.09.29.03.02.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:02:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/37] target/arm: Don't register 64-bit TTBR0, TTBR1 for PMSA
Date: Tue, 29 Sep 2026 11:01:14 +0100
Message-ID: <20260929100133.2598676-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929100133.2598676-1-peter.maydell@linaro.org>
References: <20260929100133.2598676-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:33::f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed2-x0f.google.com
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

We register the 64-bit versions of TTBR0 and TTBR1 in
lpae_cp_reginfo[], marking them as ARM_CP_ALIAS because the AArch64
definitions in vmsa_cp_reginfo[] will handle their migration.

However, this means that we are also defining these registers as
present in the Cortex-R52, which is a v8R PMSA CPU.  v8R does define
AMAIR0, AMAIR1 and the PAR, but does not have TTBR0 or TTBR1.

Split the TTBR0 and TTBR1 definitions into a new lpae_vmsa_cp_reginfo
which we only register when we have both LPAE and VMSA.

This is a migration break for Cortex-R52 CPUs (which we don't use in
any versioned machine type).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260907130223.3148989-8-peter.maydell@linaro.org
---
 target/arm/helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5f930f6fa8f..1fe06a6351c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3098,6 +3098,9 @@ static const ARMCPRegInfo lpae_cp_reginfo[] = {
       .access = PL1_RW, .type = ARM_CP_64BIT, .resetvalue = 0,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.par_s),
                              offsetof(CPUARMState, cp15.par_ns)} },
+};
+
+static const ARMCPRegInfo lpae_vmsa_cp_reginfo[] = {
     { .name = "TTBR0", .cp = 15, .crm = 2, .opc1 = 0,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .type = ARM_CP_64BIT | ARM_CP_ALIAS,
@@ -7226,6 +7229,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     }
     if (arm_feature(env, ARM_FEATURE_LPAE)) {
         define_arm_cp_regs(cpu, lpae_cp_reginfo);
+        if (!arm_feature(env, ARM_FEATURE_PMSA)) {
+            define_arm_cp_regs(cpu, lpae_vmsa_cp_reginfo);
+        }
     }
     if (cpu_isar_feature(aa32_jazelle, cpu)) {
         define_arm_cp_regs(cpu, jazelle_regs);
-- 
2.43.0


