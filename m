Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73467FCB608
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWfo-0005mw-Il; Fri, 06 Mar 2026 10:01:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWfP-0004oK-92
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:45 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWfL-0002nz-EE
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:38 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4852a8482fcso2561275e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809232; x=1773414032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lPAVCki5fzTClwwWXBog13/g0q9UBCatamyseofWAHE=;
 b=AEW5ouEKgIrAHpMMIM7pVNQiunVxo/tBxpseeNkkZihXmvcOnhQ3rVPUHmAgGD/p/2
 QMGcyUHc2EFh6H2FRiIYgHnrbzDz974U1mDu7nHCUJvQut6RdfTmrw036xtsWEkoheb2
 elt00DPaP8YNSjwZo54dzJi0XSzeq7C2MAZDUb8mxkBxamAVJU1yuWLED6QdcjUsvPHd
 Y7Rkf9PUq4MUL46453zg2RZJJ1AzIz1geh3P4wT4SpXBOzxRe9xPr3hy0Qz1lQDStcu4
 B/D+A7S9zWUijGmkPI8BwII9ms/l/92t23oItBIP2C/FGWEU0QHUdHDxfTAwEOn/tyWs
 Tsew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809232; x=1773414032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lPAVCki5fzTClwwWXBog13/g0q9UBCatamyseofWAHE=;
 b=dw5DFyQS92YA/77tfn0FNagTlX9rls+Cgqk5BEUcPAFkPP4iZYGGNqDl09KmUzeyQF
 VE/hNAChwWRzh3ITlgQF9vm36PpaSmFCuxtSinfZ6F4le0c4Mo89miqXGQBKd7VvBDEP
 6ZXpH6KN7FBgVboxJ/D3YStzlAwij1o8eI+f75Iee2AESD2Kea5UwzFkJ1kfFI0ouOIL
 9DbkcCjIw0AKmWRQg/cM0FdFCvYDTiRBaWlgI73IMMKpoajh2aABOOFhRwI2HooxdGtC
 BbfZtcV8jAU8reBBKYGRZINLuT+p2q7OraaZwe3gvJjXp8kW5Ywlg/tuylGQKNuixi71
 ZNpQ==
X-Gm-Message-State: AOJu0Yz/R6RgJnf+jKiwjtpE0wy0yQnAHcMnIccE7wqp7gqL991g1Pb9
 eS45TxfpiPGph4KVIBlbgekTtwrCGY3+O6y+t89No3lOs7iieRQQfg1d3dLFE2idlJxBhKpY4Pz
 Z/E2m
X-Gm-Gg: ATEYQzzBp3R3/1n8Q5md0daZJVe1qVX/uTFQaCj/AfVjtIXvHUZyE1rmlzuYRoaIT4D
 IR8Kc8lfk7zRNMDLHGgH4i3mh97VNZeGD5egCOnwiqrPDpyFAeAA84rvh0d1p3h6IvkY/THA+ah
 Jm2GVSd6YSJxv5+O1R+d2HEFtJS9PwSnCuDZ/UEiq5Qvvkp+EJpa8UIE3r2m70nbHQDKW/5Gyog
 SyY/ag7P8o3oWFlfog90XnboT702uKr3SLITFwrBKt94yHodYEJjEQjTWVR4GJZwbFik5y9ybSu
 I73fvof8BEx4Jjg2y8bkOjDGTUqLsGJMBQ1Dt94bDzDuwU9FsrMFBsKFASrev8E20h0U5Bh2G9/
 +yji+EvrgVdJn/JiGnrDBrAqxVRF2nP6nXUUdPhzSs/uWzZxt5imfmsH9DCyAeavtRc8E6NH6Kn
 AyHCfMmIEpaqMaffIWg0tgA7MdXVtofo4JNiTKh4kPPZ3Ax+b8W3sTC5i7Rx2Zm4pNceXUUYrGt
 xEhOxgVBcu19ryxBVX80GEdHNgauq4=
X-Received: by 2002:a05:600c:4591:b0:483:6d4a:7e6d with SMTP id
 5b1f17b1804b1-48526978644mr35776515e9.30.1772809231415; 
 Fri, 06 Mar 2026 07:00:31 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.07.00.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:00:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/49] hvf: gate ARM_FEATURE_PMU register emulation behind not
 being at EL2
Date: Fri,  6 Mar 2026 14:59:33 +0000
Message-ID: <20260306145939.2162189-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

From Apple documentation:

> When EL2 is disabled, PMU register accesses trigger "Trapped MSR, MRS, or
> System Instruction" exceptions. When this happens, hv_vcpu_run() returns, and the
>  hv_vcpu_exit_t object contains the information about this exception.

> When EL2 is enabled, the handling of PMU register accesses is determined by the PMUVer
> field of ID_AA64DFR0_EL1 register.
> If the PMUVer field value is zero or is invalid, PMU register accesses generate "Undefined"
> exceptions, which are sent to the guest.
> If the PMUVer field value is non-zero and valid, PMU register accesses are emulated by the framework.
> The ID_AA64DFR0_EL1 register can be modified via hv_vcpu_set_sys_reg API.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260306130107.35359-12-mohamed@unpredictable.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 8363e10eff..91bbb2013b 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1589,7 +1589,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
 
-    if (arm_feature(env, ARM_FEATURE_PMU)) {
+    if (!hvf_nested_virt_enabled() && arm_feature(env, ARM_FEATURE_PMU)) {
         switch (reg) {
         case SYSREG_PMCR_EL0:
             *val = env->cp15.c9_pmcr;
@@ -1850,7 +1850,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
                            SYSREG_OP2(reg),
                            val);
 
-    if (arm_feature(env, ARM_FEATURE_PMU)) {
+    if (!hvf_nested_virt_enabled() && arm_feature(env, ARM_FEATURE_PMU)) {
         switch (reg) {
         case SYSREG_PMCCNTR_EL0:
             pmu_op_start(env);
-- 
2.43.0


