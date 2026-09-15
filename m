Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E65C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6WdI-0005P3-0Y; Tue, 15 Sep 2026 13:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdE-0005Nu-If
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:07:44 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdC-0003U9-GA
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:07:44 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f6350f89so1854606f8f.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 10:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789492061; x=1790096861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=24Orj4A/cTGpGkp1mwzozDfIPHw3PzO0nF/DEKBkz6w=;
 b=AKwmIoiQbV1NHd/gTasZsxx5v/0EEptV9DzTzR/U82+mIA1D+FzcQOxC3VUbi6ntSn
 PjCf2NpYsNN7X/4vjWkOhSveCuYrqhvp/VSGdVJBumTA9EwBWtgmS2Nv0q2hnsLGZqys
 O2ei4blZnlve6jt4LzrffWQbTgq8ayfrW0kh3gld8sMnfW1nRi+VE0V6wi0oSbHukP6m
 uOWJcM/cEaCuCCAqdOuopa6f51wX3yI1fSkY5f2Ecm4qX9affK6Ykx3r07o0kshCgmBA
 NKhonalqtiMSgTeSsWtXyjYbxR4+jsNkyQOxYQH4xmGjurwKYKBYoXqIYMa82Zl/5anx
 La5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789492061; x=1790096861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=24Orj4A/cTGpGkp1mwzozDfIPHw3PzO0nF/DEKBkz6w=;
 b=onCrEs++C1mSx/yLVzfL9xJgocx4xzqbzuZ3LYyKBO04yzHp/yLs+FpQJ1TM4ijhTn
 KliVQT7Ain7onEbw+NtZWQLPxRIHpdZsV3WEsmvElQnCZXgtIJ5JRWSsQuSlKJh1RlE+
 FeDJExPM+CJkdqikIUOalLbbFte6DFid8Cn0z1lbRXe3HNPVlr0zQgSSO9+amxS1FrC8
 DvarC9Nw2sXPgVljYPpzUOgXQzbN1NWJ+vT1Anq84y0iLqKeVEGpQoU+Rt4x/EpIYnpb
 4CEwcSlmlxYigLPkEO1FI9g5H4laxQnGZdqTP/fK8aoTrqcWUdWzuMqHjv0ntQwCUFUa
 fFVQ==
X-Gm-Message-State: AFuF++nsEfvpn00wlRMEQpp3w4/up5ThxgCZM0O4oTRzv5rFshUwU2AI
 0C4KH213xzNMyfBCO9eWkF886xhZQukA/dse2sCq2mVUzx+mfQEUZU2v4I0VdW5xgXus/6KA5W4
 xwSPvboY=
X-Gm-Gg: AYBFou192lV45cJt2iEAtcRy7BHkUJbdfQNz49ClzTk94VTn57i4WomGVlbHoYL5nbh
 3yxS8k27SWO5NMRAJcc0/RK5PVQq7Fpiw4GWPQespB8dg0yaZX+vOBPmTc2KZzFA8OuId9HJdid
 +lcviyGh7oSAG+VhNvA9hvdnoIMYkaaY+LoT1Gi9B4bGfVV+Hxl7UCosvg82s6ktcRAR+U/QDqf
 aNMl5lR3jLwUkQ08mA5pZEx57tC6tUkG5yLuXy7h+SCKZTf6iNfTDXBztRCoERYy0WkhHY0WZv+
 k8ysXmA3dknAyQOpq1MpQ8r3OMDYLmb1iKZ6HiFAZXW6GMscQb5YEzVTY9XCGn6fGd6tnJ7DSjc
 ubpiYtufR9lFDyyKHVGLrNCSkcdfSv7tXCWECxH3Ty8yCwCXWtgotsBgljEI1XMqRxScRYm1Mi7
 nC7yHaoIECpw9v+aWFZAumKlvVUMQOI2a9zFlV/5WRxM/pGhrCcO75UsNzg9aky0KVYZ3bwi6VG
 luSR2V6oxMv6cBdjbramaAox639+dYg6BQ+B7CVTR2prk9JFNs7dM97Ts2vtGtEbYjHeC7X0mra
 W6s1
X-Received: by 2002:a05:6000:2313:b0:487:8c8:8cb with SMTP id
 ffacd0b85a97d-48708c80907mr3966077f8f.8.1789492060948; 
 Tue, 15 Sep 2026 10:07:40 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf33e01sm431826f8f.23.2026.09.15.10.07.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 10:07:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/20] target/arm/whpx: fix whpx-arm post-reset CPU state
Date: Tue, 15 Sep 2026 18:07:18 +0100
Message-ID: <20260915170735.425445-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915170735.425445-1-peter.maydell@linaro.org>
References: <20260915170735.425445-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x10.google.com
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

From: Doug Cook <dcook@microsoft.com>

Reset should leave CPU 0 running, and should leave all other CPUs
suspended. Instead, no CPUs are suspended and CPUs may be left in
low-power states.

Fix by updating state in whpx_set_registers WHPX_LEVEL_RESET_STATE.

Signed-off-by: Doug Cook <dcook@microsoft.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/whpx/whpx-all.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index a05df7d2cb3..d106400686f 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -613,6 +613,37 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
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
2.43.0


