Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44186CA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY3s-0008DC-8S; Tue, 13 Oct 2026 04:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3S-000774-7M
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:15 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3L-0007p1-It
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:13 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-487049569b6so1851182f8f.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880804; x=1792485604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8uQRGGo33+t5uuGFTo4Z4S7EgGCw82RRO0sVfMQiO1g=;
 b=pI23lG78nJg3xQ4N/7hdnQNGXYZwk/4oXoWd9bUNxrxBWTpOF4+1nlLyrhLoeiC8OE
 LbBR47IOIuDEQKOFrS3clwJKD7pxLzIaQI4NS3y66MI9Bn3qbAuvCN4yksZuPMV5utTu
 3HYB6P89ZUsB2vmH433t2Xv1PbbRALYvGeVDuzAB+VyamSac9dVOvbvyH1HVQMq4Nl+E
 KjSOVOcY1IGxAIKuFGzyXbbJalwef77p6kSRO7lKt7bM+kD8Q9s1hjcexKEKeBE7y553
 7jpuJqzEW+XVCR+8zEZaCCH0FngcQrFKeYD6RWXfJ30B5iCN3ql5fitgbfVc8Q5U62kt
 wtgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880804; x=1792485604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8uQRGGo33+t5uuGFTo4Z4S7EgGCw82RRO0sVfMQiO1g=;
 b=rZqf/jprZGjW5fKSd47xGdG1IsnbNh6MH6bIOGm/D/LfdeH1cvsD40g8QQtZFnGKRT
 gQzfOJQqBNLJ5FjbeYk3y5Y9LfgojJUL96BVQKACSl1wyRrXAyDjNJvi0q/Oosrpl2rM
 Nggel6Qpno3a9qoIhn1qMbHLv9W9ZD/mJqbvv4A/RghFDOTaaP7MIiWA6p+f99ncBaxD
 rV6rsAOiusLWqQTLXJJ8UXYf4JIzNB8jp9MUVKrZ6+fFJ+jbY5kpGp6jJE/btAObcvlY
 wuWaLPo0lwDvMa3Zo3Y0vlFfOHVi+Nsz+uc+MEOKSDKkH/cu7vbMgY9DqmfjGQ+1Gdne
 Sa2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzb9tIrvqW49TAhUwbVN2zSXFpbdBt5/Rx9Ngr9DHG9FivhZpvC+j3UxIcbx87IxKXKTRqY1KfaKFsG@nongnu.org
X-Gm-Message-State: AFq9FYIQH0dNv4kQAylrTyKokMLKyHsbse/6tEhzlndqUfQyQtXDPN2t
 0JvgvhFa9bJhj9hGSop9yCxb6ag0JHCpcczIuAKilNrSLPgJg4+1zKBnzdbyMHTZKJ0=
X-Gm-Gg: AYBFou11eUltcd50PbpmBszYHIWakUT9dlY4Ul9ZxRgVCS5EZQpWEvwbk2shYuCs1p7
 JWnozfrnyu+bzXt3TpkcKl+N5so4tvi6VfP/Z6WOZ5RXO77Bv+a2CFgiiJIyPV0xBpoAcx2iEF9
 I6YkViwJlsLGTs6geB3VAUX1wDw9XFS7gP8vcdKlLvyxa6RmCI39cYgbtK/rMLjoiHG+sG0unnc
 Fg+phuk8TMNVFqRw7Z9W9ycwkfHSwgpOKwmgvBbos9u/C9KaKmk1tGEFqJFoUACW1LllxByYLy3
 P62uAGqScMAPBoIPu8+8EL2Ibp3L4C6m87DTV2LofWLt7yN9xPptGuT/Gdu0fKF0q5xaRMaN1n0
 ykOVO5iw4d0HO0NSIExZSDUIEZKhwd3HGV20VpKDB6EeFv93XmMM4Ycn5lYmt+gm+04CIpRLqkj
 MOMyCYOoWaRvoRj4Bek9EsPm+9tPq/BJfP27Rbu7nYVzU8n15YBr4k7O1/0HGe9u3reMBNC0+Io
 EkRdtXSbgTnfqPrKmNiq+lhe+/A/ZKnj6lsGE0JB9WLOBH0ubc5GtkrTdV7dKfQvAEjogW/NPcA
 PTvrBF3sDzdszg==
X-Received: by 2002:a05:600c:1d0e:b0:49f:ec98:f030 with SMTP id
 5b1f17b1804b1-4a18e4e9db3mr236851375e9.33.1791880803659; 
 Tue, 13 Oct 2026 01:40:03 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.40.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:40:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 21/86] target/arm: GICv5 cpuif: Implement ICC_SRE_ELx
Date: Tue, 13 Oct 2026 09:38:28 +0100
Message-ID: <20261013083933.1024405-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

When FEAT_GCIE and FEAT_EL2 are implemented, the GICv5 specification
requires that the old GICv3 ICC_SRE_EL1 and ICC_SRE_EL2 registers are
present, with RAO/WI bits, even if FEAT_GCIE_LEGACY is not
implemented or enabled.  ICC_SRE_EL3 is not present, but the CPU
behaves as if its Enable and SRE bits are always set. (See R_SLVXV,
R_MCTMX, R_HQBBN.)

Implement the ICC_SRE_EL1 and ICC_SRE_EL2 registers.  For QEMU, this
"all bits RAO" is identical to how we implemented it for GICv3,
because we didn't implement the memory-map register interface, we
didn't support IRQ or FIQ bypass and we took advantage of the IMPDEF
option to make the ENABLE bit RAO so we didn't need to trap lower-EL
accesses to ICC_SRE_ELx.  The RAO behaviours correspond to "do
nothing" -- don't trap system register accesses, no IRQ/FIQ bypass
handling -- so we don't need any special handling in any part of the
CPU implementation, just as we didn't for GICv3.

Because ICC_SRE_EL1 is EL1-visible but only present when FEAT_EL2
is implemented, we need to put it in a cpreg array that we only
register when ARM_FEATURE_EL2 is set, rather than being able to
list it in the main gicv5_cpuif_reginfo array and relying on the
access field as we do for other FEAT_EL2 GICv5 registers.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/gicv5-cpuif.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index be34312d242..8cb790204f1 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -1017,6 +1017,11 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .fieldoffset = offsetof(CPUARMState, cp15.fgt_read[FGTREG_ICH_HFGRTR]),
         .resetvalue = ICH_HFGRTR_EL2_RES1_MASK,
     },
+    {   .name = "ICC_SRE_EL2", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 9, .opc2 = 5,
+        .access = PL2_RW, .type = ARM_CP_NO_RAW | ARM_CP_CONST,
+        .resetvalue = 0xf,
+    },
     {   .name = "ICH_HFGWTR_EL2", .state = ARM_CP_STATE_AA64,
         .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 9, .opc2 = 6,
         .access = PL2_RW, .type = ARM_CP_NO_RAW,
@@ -1116,6 +1121,14 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
     },
 };
 
+static const ARMCPRegInfo gicv5_cpuif_el2_reginfo[] = {
+    {   .name = "ICC_SRE_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 12, .opc2 = 5,
+        .access = PL1_RW, .type = ARM_CP_NO_RAW | ARM_CP_CONST,
+        .resetvalue = 0x7,
+    },
+};
+
 void define_gicv5_cpuif_regs(ARMCPU *cpu)
 {
     if (cpu_isar_feature(aa64_gcie, cpu)) {
@@ -1153,5 +1166,9 @@ void define_gicv5_cpuif_regs(ARMCPU *cpu)
             };
             define_one_arm_cp_reg(cpu, &ppi_prio);
         }
+
+        if (arm_feature(&cpu->env, ARM_FEATURE_EL2)) {
+            define_arm_cp_regs(cpu, gicv5_cpuif_el2_reginfo);
+        }
     }
 }
-- 
2.43.0


