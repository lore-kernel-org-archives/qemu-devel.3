Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870ECCD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 18:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUqId-0000ek-Sr; Wed, 03 Jun 2026 14:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wUqIT-0000YH-FT
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 14:26:35 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wUqIQ-0003a7-3e
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 14:26:33 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49050ff7cbdso122298255e9.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 11:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780511189; x=1781115989; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bTFIQnxOTusjqU6d0bx1jsZTWZ7O2YKAwwl7YH9M60w=;
 b=TV7hm+srmPmHublT4HuXQf41GAg7irVZ9+2JcFzY7BU7+jF8XzPKhVkT0Lz8W8QTu/
 keY3z3KowjjDqaeb8UjoDwaSED6HQiLRwJbbb8YZVpPp7rYq0Vw0cnb++r8vV3unSaUa
 qcgkIB4KuUkpmdEejKvjzXTU68qgPY6HigRwOmHnN+LLbhrz63iUKMGcrqqoRtAzwiL7
 cDfnCJgOLyYiBOrT0EpdJSV26aY8XmM5+v9xL4u9P5yx5FmX35WwM9a52a3dQPMFFpVA
 9OVJdlbohSshVmmXNeW04+TwdAgWY1O9Z5LQThEgAM5ftFQn/f/iwstOCZe/pzOn2B+u
 UwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780511189; x=1781115989;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bTFIQnxOTusjqU6d0bx1jsZTWZ7O2YKAwwl7YH9M60w=;
 b=bR3zmeHJXZGCXIh9AgZSbuw5WAUh1LxL/3rMX/YzBvxLbHAoe7hBTtvur8qgylOso7
 aSzPLFlQjxzugiu4Y3MlSkUai/YheHUBruoZgfzoUvkF97kspTvUPWY10VAMkhsYaps/
 RZ3PCDB7SVP4ffcqEFmmGgbj/OVnQW8L+Tra7JpNtuem+YiIJzEMFeI9ttd1XE3k8f5/
 Rdd2zu7MSwhFgzYHc2JK7QT0D3OD4rMUmHGPB/tWoIf3x/tNlJZtFSCG2tZEtnMLlJ0S
 9jz2S4qRJGCs1ymjAOadhLBV47P0NUUXsoOwTpBweFUub9gyVq/j0EdIEE6GBHioeIFJ
 FOJw==
X-Gm-Message-State: AOJu0Yxmf7qu1IlD4dmGntn86QMS4utE7WNmFSmCu6nMH9gRhdQRXoGW
 +GMUOlFGrktbwI1DjBzKtQlltvvCkDh9rFbKvIeMB9EIOPlmfrT+dqZxWIkfWYxEn0E=
X-Gm-Gg: Acq92OGoSQExHFn+BEXkIxkzbWK7akJ571nuTobHj9PYadeg6JL0sh8kTMUgYOMTewS
 Vm3r9CV1oV+wyrCfomcBaklPRAJiz/PAZrJRhxxs382WCzBu5jIPbEBV2F4bb6tkgSB9gpbXCFA
 Z1ccp/5eQf9w0iU47QaNwTv4KojMzYmgMNHyHIUAdDS/qXGypCeEPZ6jS+6ywAAmJ+DQknxCtbq
 neulzcVvagZCtLIJXAgLNiYnNfAqCOpEPxPyJgzp4Z500Ola05GQNKhl1LLNWbhUnQ8CyJyO15v
 P/eR2bVGVfrUYLELCSK13P4Q4KA/AcKKGCZnwAyChPqApvqALj5u5y0KIwpiEyEnOcW75w5tf81
 xpwdMK7pOz0cEivRi8r97LeF5cJOphD3g39Iiq+EFzTnuFElVkzM3oJrv96P80akEAYsdqVLEvL
 rFPEdCjIw9nhWIYplJBB80e9mC12J+U4B6vZoJ15lWSVZkeS+y
X-Received: by 2002:a05:600c:a03:b0:490:4663:691b with SMTP id
 5b1f17b1804b1-490b5e64599mr75273745e9.7.1780511187252; 
 Wed, 03 Jun 2026 11:26:27 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:d530:6a6b:58a7:e220])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2ed944sm9793127f8f.13.2026.06.03.11.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 11:26:26 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Wed, 03 Jun 2026 19:26:21 +0100
Subject: [PATCH v2 2/6] target/arm: Setup new registers for GPC3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-jmac-gpc3b-v2-2-115c51936962@linaro.org>
References: <20260603-jmac-gpc3b-v2-0-115c51936962@linaro.org>
In-Reply-To: <20260603-jmac-gpc3b-v2-0-115c51936962@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32f.google.com
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

Adds GPCBW_EL3. A custom write function is necessary to flush TLBs
when this register is written. Also allows write to the GPCBW bit of
GPCCR_EL3.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 target/arm/cpu.h    |  7 +++++++
 target/arm/helper.c | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 85552b573c..9944dc9727 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -546,6 +546,7 @@ typedef struct CPUArchState {
         /* RME registers */
         uint64_t gpccr_el3;
         uint64_t gptbr_el3;
+        uint64_t gpcbw_el3;
         uint64_t mfar_el3;
 
         /* NV2 register */
@@ -1228,6 +1229,8 @@ void arm_v7m_cpu_do_interrupt(CPUState *cpu);
 typedef struct ARMGranuleProtectionConfig {
     /* GPCCR_EL3 */
     uint64_t gpccr;
+    /* GPCBW_EL3 */
+    uint64_t gpcbw;
     /* GPTBR_EL3 */
     uint64_t gptbr;
     /* ID_AA64MMFR0_EL1.PARange */
@@ -2098,6 +2101,10 @@ FIELD(GPCCR, NA6, 27, 1)
 FIELD(GPCCR, NA7, 28, 1)
 FIELD(GPCCR, GPCBW, 29, 1)
 
+FIELD(GPCBW, BWSIZE, 37, 2)
+FIELD(GPCBW, BWSTRIDE, 32, 5)
+FIELD(GPCBW, BWADDR, 0, 25)
+
 FIELD(MFAR, FPA, 12, 40)
 FIELD(MFAR, NSE, 62, 1)
 FIELD(MFAR, NS, 63, 1)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9dd8fdfa41..05fca2a271 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4993,6 +4993,10 @@ static void gpccr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                    R_GPCCR_SPAD_MASK | R_GPCCR_NSPAD_MASK | R_GPCCR_RLPAD_MASK;
     }
 
+    if (cpu_isar_feature(aa64_rme_gpc3 , env_archcpu(env))) {
+        rw_mask |= R_GPCCR_GPCBW_MASK;
+    }
+
     env->cp15.gpccr_el3 = (value & rw_mask) | (env->cp15.gpccr_el3 & ~rw_mask);
 }
 
@@ -5002,11 +5006,26 @@ static void gpccr_reset(CPUARMState *env, const ARMCPRegInfo *ri)
                                      env_archcpu(env)->reset_l0gptsz);
 }
 
+static void gpcbw_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                        uint64_t value)
+{
+    uint64_t rw_mask = R_GPCBW_BWADDR_MASK | R_GPCBW_BWSTRIDE_MASK |
+                       R_GPCBW_BWSIZE_MASK;
+    ARMCPU *cpu = env_archcpu(env);
+
+    tlb_flush(CPU(cpu));
+    env->cp15.gpcbw_el3 = (value & rw_mask);
+}
+
 static const ARMCPRegInfo rme_reginfo[] = {
     { .name = "GPCCR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 2, .crm = 1, .opc2 = 6,
       .access = PL3_RW, .writefn = gpccr_write, .resetfn = gpccr_reset,
       .fieldoffset = offsetof(CPUARMState, cp15.gpccr_el3) },
+    { .name = "GPCBW_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 2, .crm = 1, .opc2 = 5,
+      .access = PL3_RW, .writefn = gpcbw_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.gpcbw_el3) },
     { .name = "GPTBR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 2, .crm = 1, .opc2 = 4,
       .access = PL3_RW, .fieldoffset = offsetof(CPUARMState, cp15.gptbr_el3) },

-- 
2.43.0


