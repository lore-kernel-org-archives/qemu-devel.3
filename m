Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A57CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 15:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSclH-0002Ii-RA; Thu, 28 May 2026 11:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wSclA-0002Go-Hi
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:35:04 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wScl7-0007ZC-IQ
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:35:00 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49068493267so32736115e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 08:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779982496; x=1780587296; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nhpWidENFAb6JwyuWIKzWAKDnchWz5BOJ0Z4yzFFWl0=;
 b=SZ58cDc42UPzH9qSzVd0jxb+utorn7AI5WKrYnQfG1ON0KLFFlpJFXqpk2j1WljnOS
 sy0EtwxXQbb2AZE2f3OOcKd/Bsv55QBM0r11ZLjsk97PvPXUUCKEyJm8677AM+9R8or9
 ctv6nhbuYhG+PIf5cO+jtXVI+3QLVLnLOj0/xuqcebFDr3yNNryp98BFiHEfcVDFJE4Q
 lYt5L3svihuniv4M5Hu9SCyKkj+eb02wMlcUTUhEBlHAAmVdX3AJs+CORlYV5wApnEVD
 Lzu7K+SSqLT6r9CyK1j5AJGvdGP6pc7+Uuy2loNRVUMbESoeAfBcQkw2lS613l8xdztW
 DV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779982496; x=1780587296;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nhpWidENFAb6JwyuWIKzWAKDnchWz5BOJ0Z4yzFFWl0=;
 b=Lt/vob6sCU6RR7YUHlE0ag349aUlOq1EaLVjV3kbtwQBXzec4mQMsnvgK/+BbeecXz
 SSGxVU/kq68Rqg5xtEgHKOu8oL29X9Nl9yS55xvNCwR2iuejekez0VrLCyrmYI5KH/zL
 GnvY9+JPhWfu/i05QqjAWQHPh3Xo1fbiIvAGar+io971MKEtjlwxvydBVHFChCYGcqSh
 A9aLavhXDNHf/6jatd381rAMIwAZ1gRw2nWnbPSUyMdjwXrIgWUyoAHymLkio7FuN4l6
 h55DbuUrOL8uEhK/gL3JFSQjWLglgtT5yiIBQqUXKmUi4FCMqJZ/q1PwOTtd9vrNrIIh
 iDhQ==
X-Gm-Message-State: AOJu0Yw0XBiDWMO1/C3u/4pEGhxYsO9Ib2XJ6HbkvRV1WXNGDI/DL5l6
 rpHMoXeV/68ed7S0PBuzTXMz0THJmGxsvik7JS/qanZGGdkKvkNIdSfdU8FbPOZPF/Y=
X-Gm-Gg: Acq92OFUS8qST4nXnXOgbPEY0MH2/tAJWMwe1jZ3KcDMDo+lkJ1fVOA0WxoBPJKxNeg
 r23TlUo3jOJFxgbXxHsWzH+cdc17p/AhOF8CCE5Lpf7mdgCVBBe5SWCOQXZ9rfgF4M/8ZT27eSW
 0sOYnVk5f97kiztLJdd5WtC7lRV6rA9ii9mPc1ICce/uiIkn40JhK2ZKEr9qajruNE6KqwPzp3/
 2sE0S72Pll1bxLk4rBt/3fov+S2KZ59m1iAaSOCLk/CiqyAw4vZSLBVMtRjAoaWdnzU4DbJMFyL
 h9lFj0SsxbmWiXXcwJGB1IP6UAiNArMfo7OAVCafjmOULP/SUjP/KhmlV3Z4vGJJosIYhvRKV1l
 yusmK01RIYlt9u6J09Nq58j9canDPnfSLOydq5nhbhH20AnHMtpkyXTdL5h5Ysu7Qap1hJuMmWE
 bIEbzkIUw0c80CBeYGVjNssz/wQnfMCyI9XMdGWw==
X-Received: by 2002:a05:600c:45d2:b0:490:6237:521d with SMTP id
 5b1f17b1804b1-490623753admr300744025e9.13.1779982496054; 
 Thu, 28 May 2026 08:34:56 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:f5a7:372a:ab8b:3c01])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909298d41bsm46514785e9.11.2026.05.28.08.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 08:34:55 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Thu, 28 May 2026 16:34:37 +0100
Subject: [PATCH 2/5] target/arm: Setup new registers for GPC3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-jmac-gpc3b-v1-2-d34c46c5069f@linaro.org>
References: <20260528-jmac-gpc3b-v1-0-d34c46c5069f@linaro.org>
In-Reply-To: <20260528-jmac-gpc3b-v1-0-d34c46c5069f@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x336.google.com
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
index 34487eeaa3..12453fe39f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4990,6 +4990,10 @@ static void gpccr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                    R_GPCCR_SPAD_MASK | R_GPCCR_NSPAD_MASK | R_GPCCR_RLPAD_MASK;
     }
 
+    if (cpu_isar_feature(aa64_rme_gpc3 , env_archcpu(env))) {
+        rw_mask |= R_GPCCR_GPCBW_MASK;
+    }
+
     env->cp15.gpccr_el3 = (value & rw_mask) | (env->cp15.gpccr_el3 & ~rw_mask);
 }
 
@@ -4999,11 +5003,26 @@ static void gpccr_reset(CPUARMState *env, const ARMCPRegInfo *ri)
                                      env_archcpu(env)->reset_l0gptsz);
 }
 
+static void gpcbw_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                        uint64_t value)
+{
+    uint64_t rw_mask = R_GPCBW_BWADDR_MASK | R_GPCBW_BWSTRIDE_MASK |
+                       R_GPCBW_BWSIZE_MASK;
+    ARMCPU *cpu = env_archcpu(env);
+    tlb_flush_by_mmuidx(CPU(cpu), alle1_tlbmask(env));
+
+    env->cp15.gpcbw_el3 = (value & rw_mask) | (env->cp15.gpcbw_el3 & ~rw_mask);
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


