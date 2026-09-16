Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8DEC982C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6lfc-0001u9-E4; Wed, 16 Sep 2026 05:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6lfO-0000vK-AG; Wed, 16 Sep 2026 05:11:02 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6lfM-0007uc-Ma; Wed, 16 Sep 2026 05:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789549562; bh=vLGvC5zUkfPEy2DPF2t5YDzCFoKSBwPb98aoEix/IEc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=vbeLcJvsoBTR5C1g8mpuQ35bBubTTtX4DVfBHU3JNSdjfaXJu7WvCr4ny6tjC+Mj2
 VfnEo2up4RkO7WcSUEXEDqk8uLfGDvdd96LA+TEuBMYv3oVS2gExxJdUomxjcwdmFv
 0JbNCceHYQcmu+b0cjmIUqmhizV6jVcpuq4Oy/PyY1utEKlV2pJZy/MdCfmt/ZJEsK
 tdz6K3Q5J1U4KvJrxwBg+A7/+o7C3EeqmCn8KU4FS9B8yT9bXBycUShhhebOR+UGyA
 38HloMfeR4RrEtQ9PEQQa6Mmrlo+B1uxBrkrcdwvKtKaxzui3/fxFd5224EtpFkERy
 Vk4MHGmx/+QEQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 78B811D56EE;
 Wed, 16 Sep 2026 12:06:02 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 23CE8429E4D;
 Wed, 16 Sep 2026 12:06:45 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 0066E5A7CB; Wed, 16 Sep 2026 12:06:44 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Doug Cook <dcook@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 57/57] target/arm/whpx: fix whpx-arm post-reset CPU
 state
Date: Wed, 16 Sep 2026 12:04:21 +0300
Message-ID: <20260916090516.677749-57-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Doug Cook <dcook@microsoft.com>

Reset should leave CPU 0 running, and should leave all other CPUs
suspended. Instead, no CPUs are suspended and CPUs may be left in
low-power states.

Fix by updating state in whpx_set_registers WHPX_LEVEL_RESET_STATE.

Signed-off-by: Doug Cook <dcook@microsoft.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 57197bf183f3afa906f9007de918244adff9ab7e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 6aa5e2cfd25..cca0f8e30d7 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -617,6 +617,37 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
             whpx_set_reg(cpu, whpx_sreg_match[i].reg, val);
         }
     }
+
+    if (level == WHPX_LEVEL_RESET_STATE) {
+        /*
+         * WHPX keeps the "vCPU is in a low-power wait" state (entered when the
+         * guest executes WFI/WFE) in WHvRegisterInternalActivityState, and that
+         * state is not affected by writing the architectural registers above.
+         * If the guest happened to be idle when the reset was requested, the
+         * vCPU would stay suspended forever.
+         *
+         * StartupSuspend is the bit WHP uses to hold a vCPU that has not been
+         * started yet, and it is how secondary vCPUs are parked until PSCI
+         * CPU_ON releases them.
+         */
+        WHV_REGISTER_NAME name = WHvRegisterInternalActivityState;
+        bool powered_off = arm_cpu->power_state == PSCI_OFF;
+        WHV_REGISTER_VALUE ia;
+        HRESULT hr;
+
+        clean_whv_register_value(&ia);
+        hr = whp_dispatch.WHvGetVirtualProcessorRegisters(
+            whpx_global.partition, cpu->cpu_index, &name, 1, &ia);
+        if (SUCCEEDED(hr) &&
+            (ia.InternalActivity.IdleSuspend ||
+             ia.InternalActivity.HaltSuspend ||
+             ia.InternalActivity.StartupSuspend != powered_off)) {
+            ia.InternalActivity.IdleSuspend = 0;
+            ia.InternalActivity.HaltSuspend = 0;
+            ia.InternalActivity.StartupSuspend = powered_off;
+            whpx_set_reg(cpu, WHvRegisterInternalActivityState, ia);
+        }
+    }
 }
 
 static uint32_t max_vcpu_index;
-- 
2.47.3


