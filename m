Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C30C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:04:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Yzj-0006Ci-VN; Mon, 07 Sep 2026 09:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3YzZ-00068L-18
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:02:34 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3YzW-000509-5R
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:02:32 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-49d0da752ffso13868555e9.3
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 06:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788786149; x=1789390949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MCXaA9JKSbsLcHED56ZOmYfMXgeBVruvAR+utYnVKl4=;
 b=ngcKfUw+uWQqSCwLD89xTCzTU4piYfIssFqvzOW/vDfLIXCN0OYtm91dv6I9TwAMlK
 dLSM0m73n5+gOFfQq+uN/SY6j3OFGnJcNXvaxfX7Q3E7ziWPw3DSjE4Vkf31sen32/Jv
 XeNE5pZ3QuJi4tRcog/X6/Cd5jB+BXuBIjVnChG74UiNrk4ZbZkT0Ju50actL7zcQegS
 galgMdK4OcPOGRU0zoBfE/c+BfRfYbQrjBW9ID+/p+EFXD/O53wHIH+RS9m9s8xeJwlR
 0GkVJihKTaOAsWGx6VOFvEWYIV7f/7YYn4givd9vt3FW+Q1eK8oBvsngZdrKFIHzHk3V
 2Cwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788786149; x=1789390949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MCXaA9JKSbsLcHED56ZOmYfMXgeBVruvAR+utYnVKl4=;
 b=Po2s9xJ+/FJ+oBtzeRhm7cqUDIazNCOXBZbzP9ZfeoRDjF7D9VjWBJHeUowJfi9f5v
 Z4z5tY4QconppJzbyz8YshyJkJwi6Jg173svPNSeF4kxwixsaJYO+Yezmq/wuio4i7N5
 hCb1nILMODi3fb4tcWWlTREWODtOn48zpXfSBqHFlRvbzEoEESRjTH6lMVJpmhOK2XRw
 hSkD2PFu+OTe44xbJHxnFLh37XOukLnNnAqM2RDR7LSOSuwcoSdH6JsFOSw9WJHkmFGY
 NliCtl4xb5EdHtni771UbuiZBoFsTmA8xKzWntzAu0W6CnuFnR3u7SncVMgcWtm/cNKv
 ZyfA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxNOXKQ1uVxANr03TbdjJoKUkp60jzuMFK1VGy662VauYUQ3ORFV3PLbkelciZbD7aGdsdT0whevjli@nongnu.org
X-Gm-Message-State: AFuF++kitvpXJa0UCG33WyE4OWnHAeITF4EWc6vnM8YDZSh+VgDK+Xu4
 xwqkX3g5I5++UnkUcqcrImY8pwGlXw2S2DijY/3NhIjuMKCNc26Y4XF6mba/pwmKisS5W100TbS
 F3HlJ++8=
X-Gm-Gg: AYBFou1p2f3H46+QjZHx3Q/ky0MMEcvQKUSLBCHP161cvNwdNzzANdF1d53fuGVtI/o
 fRcnhNMKddMF7CSBAdBqUyD3D7PAM0mNnGIivgLquXQeDiolDs1swSIRppWCyaRsA2DmuRlfuH0
 hnr1Qt/9+VtC9FpUn6vuyVPI9QY7egm8tUrpRuYNOiEcC+AhXogzQTJRpaIqpCX9CmA19sCGRGl
 hE1mZjR0Zw2kVhpBMNFzX/+sLat4K1LS4bW7K61nAGLyfuRjl6rx1NorjmPjOpJOVxqHBrseEqj
 EGFFjKbFnFIa4okf/6Qq6CvRhozBcGn3kWtE5DNSVb3ADgIFOnOpetoVMoChJ8xbHGhmCR/gkRA
 vT5wzDhLFyDDCSey8NtpZLJA9fkT0U1GGmdhl2dN9nfbtbsu+zVA5ZE5pPB+6EXJ+DR+2GufWTV
 5i59z+V0Nbbw+J7GxP4udWz3oji8YrtK/gwuHHUL/6vQKLbL0cVnKRwfGgKJLQaUwJWcZn/SNSx
 /0fr8GRzdkdf0DJfjMw9s9e9Ibdfl06s7nqDieLi0W2Dq88WQKQoWbYVUoUjmqdpCmovg==
X-Received: by 2002:a05:600c:4e11:b0:49c:f2f4:eddd with SMTP id
 5b1f17b1804b1-49cf8268795mr244661775e9.16.1788786148773; 
 Mon, 07 Sep 2026 06:02:28 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee60bae6sm468589935e9.9.2026.09.07.06.02.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 06:02:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Tao Ding <dingtao0430@163.com>
Subject: [PATCH 3/8] target/arm: Drop uses of reset_ignore for banked AArch32
 registers
Date: Mon,  7 Sep 2026 14:02:18 +0100
Message-ID: <20260907130223.3148989-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907130223.3148989-1-peter.maydell@linaro.org>
References: <20260907130223.3148989-1-peter.maydell@linaro.org>
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

Some banked AArch32 cpregs set up a resetfn of arm_cp_reset_ignore.
This is presumably in an expectation that some other AArch64
register will handle resetting the underlying state. However
this isn't true for some of them:

 * TPIDRURO's S bank is in cp15.tpidruro_s and this isn't shared
   with any AArch64 register
 * TPIDRURW's S bank similarly is in cp15.tpidrurw_s, not shared
   with any AArch64 register

Remove the use of arm_cp_reset_ignore here; this means that the state
for the NS versions of these registers will be reset twice, but that
is fine because it will always be to the same value (and the
cp_reg_check_reset() code will assert if we introduce a bug where the
AArch64 and AArch32 regs disagree about the reset value).

For the MAIR0 and MAIR1 banked registers, doing nothing on reset is
OK because they are backed by state that is always covered by the
MAIR_EL1 and MAIR_EL3 AArch64 registers that will always be present
if the AArch32 registers are.  But it's not consistent with how we
handle all the other banked regs, so drop it here too.  Again, the
cp_reg_check_reset() checks will catch any mismatches in what the
reset value should be.

The lack of reset-to-zero for the S banked versions of TPIDRURO and
TPIDRURW is very unlikely to have had any guest visible consquences,
because these registers are architecturally UNKNOWN at reset and so
guest code should be initializing them itself regardless.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1b024adc703..f8185b201be 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1072,14 +1072,12 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .cp = 15, .opc1 = 0, .crn = 10, .crm = 2, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.mair0_s),
-                             offsetof(CPUARMState, cp15.mair0_ns) },
-      .resetfn = arm_cp_reset_ignore },
+                             offsetof(CPUARMState, cp15.mair0_ns) }, },
     { .name = "MAIR1", .state = ARM_CP_STATE_AA32,
       .cp = 15, .opc1 = 0, .crn = 10, .crm = 2, .opc2 = 1,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.mair1_s),
-                             offsetof(CPUARMState, cp15.mair1_ns) },
-      .resetfn = arm_cp_reset_ignore },
+                             offsetof(CPUARMState, cp15.mair1_ns) }, },
     { .name = "ISR_EL1", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 1, .opc2 = 0,
       .fgt = FGT_ISR_EL1,
@@ -1136,8 +1134,7 @@ static const ARMCPRegInfo v6k_cp_reginfo[] = {
       .access = PL0_RW,
       .fgt = FGT_TPIDR_EL0,
       .bank_fieldoffsets = { offsetoflow32(CPUARMState, cp15.tpidrurw_s),
-                             offsetoflow32(CPUARMState, cp15.tpidrurw_ns) },
-      .resetfn = arm_cp_reset_ignore },
+                             offsetoflow32(CPUARMState, cp15.tpidrurw_ns) }, },
     { .name = "TPIDRRO_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .opc2 = 3, .crn = 13, .crm = 0,
       .access = PL0_R | PL1_W,
@@ -1148,8 +1145,7 @@ static const ARMCPRegInfo v6k_cp_reginfo[] = {
       .access = PL0_R | PL1_W,
       .fgt = FGT_TPIDRRO_EL0,
       .bank_fieldoffsets = { offsetoflow32(CPUARMState, cp15.tpidruro_s),
-                             offsetoflow32(CPUARMState, cp15.tpidruro_ns) },
-      .resetfn = arm_cp_reset_ignore },
+                             offsetoflow32(CPUARMState, cp15.tpidruro_ns) }, },
     { .name = "TPIDR_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .opc2 = 4, .crn = 13, .crm = 0,
       .access = PL1_RW,
-- 
2.43.0


