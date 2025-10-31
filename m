Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FC4CCFA02
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtxP-000561-Gv; Fri, 31 Oct 2025 14:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtxM-00055C-FO
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:36 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwd-0006IW-RQ
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:35 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-471b80b994bso32174075e9.3
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935625; x=1762540425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pd6KmT081lP+mK8y068yakZPC/MNKPhbrMK15wWgQvM=;
 b=Qs1v1WrNthT4tw7Tv4Cg0YdkaFJf2QlLiv3OyVxBCLvYKSPQGCvn6zmu9pvV6o7tXW
 IbRb2U9PxsFXnwWKUWwCQlwRoYf6ajeubNwwld1NbiJcTSiVCwuEZRhDwKbWIenTfXxB
 hn3ctdIlyP9Xfgu80/hQe2e1Yqy1yIDVSK/HRCELWBPckOJoCo/bggXY/ug4o7H8H1GP
 d9BWgCCZnJgdbIqTgmYRh8W39PbiBqyAr+JCMxXG5xdZozNLkjl9fZpa6wH5jSvg7fW+
 TnUg6FSnYQuvjqkOC+EdR+Ym2RY1waDz0e5iybPJJbdc1qi3L1UUYtWPFLY6qHAsOHku
 0X3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935625; x=1762540425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pd6KmT081lP+mK8y068yakZPC/MNKPhbrMK15wWgQvM=;
 b=sqnKvxCTVW7RhGQQYdHFryoaQBjsNO9CXS/UeUNwN/sGo4kr0/34DnGVt1jjYxNwk0
 MNr4/Xn2Q/ng23y2DLDkLJwd01V4+U2j5J3CbffhsVbRvgUpI4edd1wZcNbyMP5p/RsX
 EfZYheIry9Uy8WuD/8s9+85VSqELV0NZm4VDxwZm79kfVcvNzEqfSVF7DKI2YEdxdR1E
 6kwxEFZZicNZat1N8EiDwCRwh4PQjOwnlNcJ2htBlNq3LUGePaK1tJ0t+JLWnB/nF8t+
 bPyv0/SEOg9SReSnfl3z2Ym9KQq4HODLmpxGvh6L27u5JE1flMCQev4vjF+ZLjylhr+F
 2W5A==
X-Gm-Message-State: AOJu0YyIxiiD1pvvbnMWYpQfXBVlcZKcuISGpdRp2I49/OU4jl2IUvHu
 tK56nUAwDK8Kbkk0Df9LWt3HwSF1CigSgnGy+Ug0iF+dbqppErdetJpyOHdxzAM8OHYRLiC4VYs
 X9jTy
X-Gm-Gg: ASbGncsuAyFm65EE9108pQUbhS63gDnoHcHZ6CHJF/l7Rf+0PBS0bw5M1P828RwnQoS
 NYXRsUmzNyuM0SiuD9bh9VZqKuWqkFWBKqcDaxSyDR2lMUb5DRdY9Ykbs6HMt2pyPa9P+/79g7Z
 EMKhpm3O+ATGtdnEqDbvPEx3UgB5xI4bSxqS+6AofST+jTDjt52g5/jIHgTQHD+M0fIKyn+gdIs
 lngCvyjspsTQXHksAZ7mlZEvAwqKpa9/jdUU2YPUsE2D8SnlI6Um6y5KgNH7odpV7ukxQNaQRon
 fe5YdOcoIwHj0zAP8CKMAk7M+9+vFISKtFBOj62/73oMxNk4khDkEQN4gKorXeUTop976e652tI
 2EayUnN4sRhEv8sUO2MuEd5XksHJ4bbhZSdqNufdqr8RN9OG/iPPAPeqHgwy17+wt5aFG+wep0V
 EpLNR4cA==
X-Google-Smtp-Source: AGHT+IEX9SkvrDkMpT4JsZN/1gRg4e7eDNj/o2HLXPTeIhz4MIvhwXIlNHJdNntcDsHrxJvE5nRnLg==
X-Received: by 2002:a05:600c:1c1d:b0:475:de14:db16 with SMTP id
 5b1f17b1804b1-4773086e39amr42888345e9.25.1761935624799; 
 Fri, 31 Oct 2025 11:33:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/38] target/arm/hvf: Rename 'vgic' -> 'emu_reginfo' in trace
 events
Date: Fri, 31 Oct 2025 18:33:06 +0000
Message-ID: <20251031183310.3778349-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

In order to extend the trace events to other registers,
rename and pass the register group as argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c        | 14 ++++++++------
 target/arm/hvf/trace-events |  4 ++--
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index c882f4c89cf..26bafee259e 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1149,7 +1149,8 @@ static uint32_t hvf_reg2cp_reg(uint32_t reg)
                               (reg >> SYSREG_OP2_SHIFT) & SYSREG_OP2_MASK);
 }
 
-static bool hvf_sysreg_read_cp(CPUState *cpu, uint32_t reg, uint64_t *val)
+static bool hvf_sysreg_read_cp(CPUState *cpu, const char *cpname,
+                               uint32_t reg, uint64_t *val)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
@@ -1172,7 +1173,7 @@ static bool hvf_sysreg_read_cp(CPUState *cpu, uint32_t reg, uint64_t *val)
         } else {
             *val = raw_read(env, ri);
         }
-        trace_hvf_vgic_read(ri->name, *val);
+        trace_hvf_emu_reginfo_read(cpname, ri->name, *val);
         return true;
     }
 
@@ -1261,7 +1262,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_ICC_SRE_EL1:
     case SYSREG_ICC_CTLR_EL1:
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
-        if (hvf_sysreg_read_cp(cpu, reg, val)) {
+        if (hvf_sysreg_read_cp(cpu, "GICv3", reg, val)) {
             return 0;
         }
         break;
@@ -1432,7 +1433,8 @@ static void pmswinc_write(CPUARMState *env, uint64_t value)
     }
 }
 
-static bool hvf_sysreg_write_cp(CPUState *cpu, uint32_t reg, uint64_t val)
+static bool hvf_sysreg_write_cp(CPUState *cpu, const char *cpname,
+                                uint32_t reg, uint64_t val)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
@@ -1455,7 +1457,7 @@ static bool hvf_sysreg_write_cp(CPUState *cpu, uint32_t reg, uint64_t val)
             raw_write(env, ri, val);
         }
 
-        trace_hvf_vgic_write(ri->name, val);
+        trace_hvf_emu_reginfo_write(cpname, ri->name, val);
         return true;
     }
 
@@ -1581,7 +1583,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
-        if (hvf_sysreg_write_cp(cpu, reg, val)) {
+        if (hvf_sysreg_write_cp(cpu, "GICv3", reg, val)) {
             return 0;
         }
         break;
diff --git a/target/arm/hvf/trace-events b/target/arm/hvf/trace-events
index 538af6e0707..29387780e3f 100644
--- a/target/arm/hvf/trace-events
+++ b/target/arm/hvf/trace-events
@@ -9,7 +9,7 @@ hvf_unknown_hvc(uint64_t pc, uint64_t x0) "pc=0x%"PRIx64" unknown HVC! 0x%016"PR
 hvf_unknown_smc(uint64_t x0) "unknown SMC! 0x%016"PRIx64
 hvf_exit(uint64_t syndrome, uint32_t ec, uint64_t pc) "exit: 0x%"PRIx64" [ec=0x%x pc=0x%"PRIx64"]"
 hvf_psci_call(uint64_t x0, uint64_t x1, uint64_t x2, uint64_t x3, uint32_t cpuid) "PSCI Call x0=0x%016"PRIx64" x1=0x%016"PRIx64" x2=0x%016"PRIx64" x3=0x%016"PRIx64" cpuid=0x%x"
-hvf_vgic_write(const char *name, uint64_t val) "vgic write to %s [val=0x%016"PRIx64"]"
-hvf_vgic_read(const char *name, uint64_t val) "vgic read from %s [val=0x%016"PRIx64"]"
+hvf_emu_reginfo_write(const char *cpname, const char *regname, uint64_t val) "[%s] write to %s [val=0x%016"PRIx64"]"
+hvf_emu_reginfo_read(const char *cpname, const char *regname, uint64_t val) "[%s] read from %s [val=0x%016"PRIx64"]"
 hvf_illegal_guest_state(void) "HV_ILLEGAL_GUEST_STATE"
 hvf_kick_vcpu_thread(unsigned cpuidx, bool stop) "cpu:%u stop:%u"
-- 
2.43.0


