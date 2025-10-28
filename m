Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A51CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDcxa-0003cu-7Z; Tue, 28 Oct 2025 02:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcxU-0003bI-Lq
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:13:29 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcxS-0006ky-0Q
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:13:28 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-475dbc3c9efso21720645e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 23:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761632003; x=1762236803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XB4scvM2utrFpVmeUUOjkW2XsKNOfvIvM6k/lnSZarI=;
 b=fu/JgioJLvXyk/zAdNGRJZliI4A51K2qszaK7BEtOBT2203w6N2dwrj6AFLqKRdtFk
 N3YI2n+XLt3FKjH2jORYeUz89JBSO4xMZbFjrtbpPcI7D6PaHUWaVp7ZazCF9KZGxy5n
 MeINsejXBCEgLBVhnyLlEK6bMi5YZ/8SV8v3XheAd88sx3+KcM0vCuD9H9HVKedP7gmj
 /ijIw/LA3z2/gejG8FdMsNY9LklQcjoAdcsBnHVGMLfs/9TA4BCX3FYjrnUV7ysg4RdE
 u9GKVvZSNL8eWC2tvbmyRMmq8I2He2yH4y/OmgZwQFd3j9A3z7zP38meWsdg5sgYXM3g
 MBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761632003; x=1762236803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XB4scvM2utrFpVmeUUOjkW2XsKNOfvIvM6k/lnSZarI=;
 b=Y5IKXQQ06VGOtMrenQwLMFBLDXuPe3uDWxeNT8/xWIjZPsCJpYfViXyC1Ep2hC1Bcu
 bdbMi7k+FTACCiAeRe1OhvP1YiVnxRymHI/jbO4VqF8WuVyM8zBt1YKhVGHfj84F7N6T
 ltkUKbPnVycI7T1zVJ17c8ahRt2CJHyslt5gqImDlgsXVe5i4rpAUqPT3Wjd+OPpOcGt
 rPGnb8thV6CjfaoVJgZkLY7wN1n5mNsni/TnG92sa72RIi8lNOBvu4An22QJd1MzszNj
 xBCNkBMiXb9HpBo/L7jtjy18357HwZ4UCtTuVbU2FUIG80Lx7uxMRT4RwHg2C2NPTg43
 L+fg==
X-Gm-Message-State: AOJu0YwW4KSTienCyF00ged7oq7PJWoTU4iwYSzeKFuJ4f1eAghZ2TP3
 K00i9evH3q8269msvAYt58wsqM4/Ajt/OYG0M+F2NuTCucdhbUp1C/AymqWwzcxgUqaMoApBIj5
 ulBwcv8Y=
X-Gm-Gg: ASbGnctWccoW/8ubClBofwmaXQPlfjWXuchex97wfOTiqV8iCGtJnwAwYesspHSeFJW
 J7rStMf3eTBKBqYRfR57LbVRREmAyS2eBvAvTNAMxszzjpYrypuv3gV0e2gVa1MioaxrRSI8mmI
 USbg9j6wGHbUfED7HmxcDeMmks2Q/XIRXyB29zjvGS/BxkYMifzSXBV35AMVukpHgHQD2FRSpRr
 3+pIVXbexHHgDBikmP9+FiHF38wBty2mmafzDw97dNl380rvWOLGhXoCz37n1+OQ6CcfMnizKh1
 mskTlJnIJeNSzLR8tE1VKKmx3BQPfZo+HfaacwRE8vIHuz2yWMGo+6s1ErnRdObJ/a9aqTODLxG
 r1HAudEhsCJMjSu07hoSB6rGjM8rWKsQr8AiZayeztPMIRcBJgPmWudyWAgQZgCuJkdBZTfq/aB
 uDAIlmEZ7EciOSr0UQ9XnzQJA8au00y3EKqY98kgRXaw/asqIF65oqTfI=
X-Google-Smtp-Source: AGHT+IGGItfAZ+2jiXFo/U2dbhz2Rh3B83tyo08hkzvQgdP0XAUz8weJ7eXn4FmVhmxceBp8UlQvkA==
X-Received: by 2002:a05:600c:1da3:b0:46e:4e6d:79f4 with SMTP id
 5b1f17b1804b1-47717dfaa6dmr15612635e9.15.1761632003476; 
 Mon, 27 Oct 2025 23:13:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47718fe6382sm11511685e9.4.2025.10.27.23.13.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 23:13:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 43/59] accel/hvf: Implement WFI without using pselect()
Date: Tue, 28 Oct 2025 06:42:19 +0100
Message-ID: <20251028054238.14949-44-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Return to the main loop where we'll be waken again.
This avoid a tricky race with signals introduced in
commit 219c101fa7f ("Add HVF WFI handler").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/hvf_int.h  |  1 -
 accel/hvf/hvf-accel-ops.c |  5 +--
 target/arm/hvf/hvf.c      | 74 +++------------------------------------
 3 files changed, 8 insertions(+), 72 deletions(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index d842d4b2b99..c8e407a1463 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -47,7 +47,6 @@ struct AccelCPUState {
 #ifdef __aarch64__
     hv_vcpu_exit_t *exit;
     bool vtimer_masked;
-    sigset_t unblock_ipi_mask;
     bool guest_debug_enabled;
 #endif
 };
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index bbb0b385fe9..e9dd2d24745 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -128,14 +128,15 @@ static int hvf_init_vcpu(CPUState *cpu)
     cpu->accel = g_new0(AccelCPUState, 1);
 
     /* init cpu signals */
+    sigset_t unblock_ipi_mask;
     struct sigaction sigact;
 
     memset(&sigact, 0, sizeof(sigact));
     sigact.sa_handler = dummy_signal;
     sigaction(SIG_IPI, &sigact, NULL);
 
-    pthread_sigmask(SIG_BLOCK, NULL, &cpu->accel->unblock_ipi_mask);
-    sigdelset(&cpu->accel->unblock_ipi_mask, SIG_IPI);
+    pthread_sigmask(SIG_BLOCK, NULL, &unblock_ipi_mask);
+    sigdelset(&unblock_ipi_mask, SIG_IPI);
 
 #ifdef __aarch64__
     r = hv_vcpu_create(&cpu->accel->fd,
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 1abb4a7d7a9..5fc9b217a11 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -301,7 +301,7 @@ void hvf_arm_init_debug(void)
 #define TMR_CTL_IMASK   (1 << 1)
 #define TMR_CTL_ISTATUS (1 << 2)
 
-static void hvf_wfi(CPUState *cpu);
+static int hvf_wfi(CPUState *cpu);
 
 static uint32_t chosen_ipa_bit_size;
 
@@ -1703,81 +1703,17 @@ static uint64_t hvf_vtimer_val_raw(void)
     return mach_absolute_time() - hvf_state->vtimer_offset;
 }
 
-static uint64_t hvf_vtimer_val(void)
+static int hvf_wfi(CPUState *cpu)
 {
-    if (!runstate_is_running()) {
-        /* VM is paused, the vtimer value is in vtimer.vtimer_val */
-        return vtimer.vtimer_val;
-    }
-
-    return hvf_vtimer_val_raw();
-}
-
-static void hvf_wait_for_ipi(CPUState *cpu, struct timespec *ts)
-{
-    /*
-     * Use pselect to sleep so that other threads can IPI us while we're
-     * sleeping.
-     */
-    qatomic_set_mb(&cpu->thread_kicked, false);
-    bql_unlock();
-    pselect(0, 0, 0, 0, ts, &cpu->accel->unblock_ipi_mask);
-    bql_lock();
-}
-
-static void hvf_wfi(CPUState *cpu)
-{
-    ARMCPU *arm_cpu = ARM_CPU(cpu);
-    struct timespec ts;
-    hv_return_t r;
-    uint64_t ctl;
-    uint64_t cval;
-    int64_t ticks_to_sleep;
-    uint64_t seconds;
-    uint64_t nanos;
-    uint32_t cntfrq;
-
     if (cpu_has_work(cpu)) {
         /*
          * Don't bother to go into our "low power state" if
          * we would just wake up immediately.
          */
-        return;
+        return 0;
     }
 
-    r = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CTL_EL0, &ctl);
-    assert_hvf_ok(r);
-
-    if (!(ctl & 1) || (ctl & 2)) {
-        /* Timer disabled or masked, just wait for an IPI. */
-        hvf_wait_for_ipi(cpu, NULL);
-        return;
-    }
-
-    r = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CVAL_EL0, &cval);
-    assert_hvf_ok(r);
-
-    ticks_to_sleep = cval - hvf_vtimer_val();
-    if (ticks_to_sleep < 0) {
-        return;
-    }
-
-    cntfrq = gt_cntfrq_period_ns(arm_cpu);
-    seconds = muldiv64(ticks_to_sleep, cntfrq, NANOSECONDS_PER_SECOND);
-    ticks_to_sleep -= muldiv64(seconds, NANOSECONDS_PER_SECOND, cntfrq);
-    nanos = ticks_to_sleep * cntfrq;
-
-    /*
-     * Don't sleep for less than the time a context switch would take,
-     * so that we can satisfy fast timer requests on the same CPU.
-     * Measurements on M1 show the sweet spot to be ~2ms.
-     */
-    if (!seconds && nanos < (2 * SCALE_MS)) {
-        return;
-    }
-
-    ts = (struct timespec) { seconds, nanos };
-    hvf_wait_for_ipi(cpu, &ts);
+    return EXCP_HLT;
 }
 
 /* Must be called by the owning thread */
@@ -1967,7 +1903,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
     case EC_WFX_TRAP:
         advance_pc = true;
         if (!(syndrome & WFX_IS_WFE)) {
-            hvf_wfi(cpu);
+            ret = hvf_wfi(cpu);
         }
         break;
     case EC_AA64_HVC:
-- 
2.51.0


