Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA20CC19F4F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qfQ-0002oN-6U; Tue, 30 Apr 2024 12:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qf3-0002Oe-Gg
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:48:58 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qew-0005cb-NE
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:48:57 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2dfb4ea2bbfso41739371fa.2
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714495729; x=1715100529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8ybX+f9OWY45lhLb2oST3kDQoeWzOe+ZNsl1K+EOruA=;
 b=JFzQgNhA5Kho8Ps/Yl3nBspWrK1kFH/ER2zweeALj/RkAUy/aZS1L4aMn/qOVbwbx/
 ZDdjMRL+q2NLRSPFJUyiaWUuPbvzUnRV05kmAY1+awkv24yNLVi8gBGoZa9435poFfyt
 DyRL4Si/YwjMxLqSG19KjbMMZm/hP063TobEcxiqCejsHSYR+nlE+JHySPM4PlyYwy8o
 u9qjgOjsN7pzy3JyZzf8tdCQ+tokjtHvvQqfT0i7087X4gFp0rkno0N5fBl23QGX7bCf
 XjndvCBgOelnMZw6PTL0CnO8DHLFTetrSu3JA/FUynLGos+g9Ery+yJBdWEfjAc4YamQ
 NufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495729; x=1715100529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8ybX+f9OWY45lhLb2oST3kDQoeWzOe+ZNsl1K+EOruA=;
 b=MNLRU7cqzmGThvZYMPE0+r1MnzyTpKcdtscEXAPqb3U9InH4O0e/SDU+GUNJ/Df9Uc
 VH7+mESGPQ+ZXK6jU5V3yISv6Sc+QwUO9nZLWGqFD42ARn3z62FtTNH4zXmD7aMND/zf
 ag2jFW5vXbBvh5+UIcwGxeMduqFRSis+xXsg1S2Bg2BueFISti91SYw0x/amNj4ugQS6
 g/loNZvaetvqShEYzUU8TBpBBfta6C2S18sZSQxV8mdUwcdC+m31kt+g3lEP6bjCNwhY
 bLjA8h7Im7Tb6lQ02xo4HW24rSWtNiR1A5xpuGLlhoU/Ga/GXov3oXwC/SDOqtlMfnPm
 +n5w==
X-Gm-Message-State: AOJu0YzgiwogIJUWByr2585TmOEws9AXzhnGQQz4mztNexsz3sYunWM8
 HyfV8cA9Pf2ww7uWhrqK1eDR9iyPtKbRR3vcPGegNj3orn9DMnh1ZIQbG3qke2qPjzWpkr41TXv
 P
X-Google-Smtp-Source: AGHT+IG05y1Q+h5mQ522BnICErxBCN/vmR8JLiHT4Z1+5dd5NCeTbcj1lxD1gNvziZI6KoSfdZ+oGQ==
X-Received: by 2002:a2e:8515:0:b0:2d5:9703:263c with SMTP id
 j21-20020a2e8515000000b002d59703263cmr202574lji.4.1714495729135; 
 Tue, 30 Apr 2024 09:48:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 b6-20020a05600c4e0600b0041be3383a2fsm12920384wmq.19.2024.04.30.09.48.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:48:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/21] target/arm: Refactor default generic timer frequency
 handling
Date: Tue, 30 Apr 2024 17:48:31 +0100
Message-Id: <20240430164842.4074734-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430164842.4074734-1-peter.maydell@linaro.org>
References: <20240430164842.4074734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22f.google.com
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

The generic timer frequency is settable by board code via a QOM
property "cntfrq", but otherwise defaults to 62.5MHz.  The way this
is done includes some complication resulting from how this was
originally a fixed value with no QOM property.  Clean it up:

 * always set cpu->gt_cntfrq_hz to some sensible value, whether
   the CPU has the generic timer or not, and whether it's system
   or user-only emulation
 * this means we can always use gt_cntfrq_hz, and never need
   the old GTIMER_SCALE define
 * set the default value in exactly one place, in the realize fn

The aim here is to pave the way for handling the ARMv8.6 requirement
that the generic timer frequency is always 1GHz.  We're going to do
that by having old CPU types keep their legacy-in-QEMU behaviour and
having the default for any new CPU types be a 1GHz rather han 62.5MHz
cntfrq, so we want the point where the default is decided to be in
one place, and in code, not in a DEFINE_PROP_UINT64() initializer.

This commit should have no behavioural changes.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240426122913.3427983-2-peter.maydell@linaro.org
---
 target/arm/internals.h |  7 ++++---
 target/arm/cpu.c       | 31 +++++++++++++++++--------------
 target/arm/helper.c    | 16 ++++++++--------
 3 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index e40ec453d56..b6c78db0243 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -60,10 +60,11 @@ static inline bool excp_is_internal(int excp)
         || excp == EXCP_SEMIHOST;
 }
 
-/* Scale factor for generic timers, ie number of ns per tick.
- * This gives a 62.5MHz timer.
+/*
+ * Default frequency for the generic timer, in Hz.
+ * This is 62.5MHz, which gives a 16 ns tick period.
  */
-#define GTIMER_SCALE 16
+#define GTIMER_DEFAULT_HZ 62500000
 
 /* Bit definitions for the v7M CONTROL register */
 FIELD(V7M_CONTROL, NPRIV, 0, 1)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a152def2413..9f2ca6633a1 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1506,9 +1506,12 @@ static void arm_cpu_initfn(Object *obj)
     }
 }
 
+/*
+ * 0 means "unset, use the default value". That default might vary depending
+ * on the CPU type, and is set in the realize fn.
+ */
 static Property arm_cpu_gt_cntfrq_property =
-            DEFINE_PROP_UINT64("cntfrq", ARMCPU, gt_cntfrq_hz,
-                               NANOSECONDS_PER_SECOND / GTIMER_SCALE);
+            DEFINE_PROP_UINT64("cntfrq", ARMCPU, gt_cntfrq_hz, 0);
 
 static Property arm_cpu_reset_cbar_property =
             DEFINE_PROP_UINT64("reset-cbar", ARMCPU, reset_cbar, 0);
@@ -1954,6 +1957,17 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (!cpu->gt_cntfrq_hz) {
+        /*
+         * 0 means "the board didn't set a value, use the default".
+         * The default value of the generic timer frequency (as seen in
+         * CNTFRQ_EL0) is 62.5MHz, which corresponds to a period of 16ns.
+         * This is what you get (a) for a CONFIG_USER_ONLY CPU (b) if the
+         * board doesn't set it.
+         */
+        cpu->gt_cntfrq_hz = GTIMER_DEFAULT_HZ;
+    }
+
 #ifndef CONFIG_USER_ONLY
     /* The NVIC and M-profile CPU are two halves of a single piece of
      * hardware; trying to use one without the other is a command line
@@ -2002,18 +2016,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
     {
-        uint64_t scale;
-
-        if (arm_feature(env, ARM_FEATURE_GENERIC_TIMER)) {
-            if (!cpu->gt_cntfrq_hz) {
-                error_setg(errp, "Invalid CNTFRQ: %"PRId64"Hz",
-                           cpu->gt_cntfrq_hz);
-                return;
-            }
-            scale = gt_cntfrq_period_ns(cpu);
-        } else {
-            scale = GTIMER_SCALE;
-        }
+        uint64_t scale = gt_cntfrq_period_ns(cpu);
 
         cpu->gt_timer[GTIMER_PHYS] = timer_new(QEMU_CLOCK_VIRTUAL, scale,
                                                arm_gt_ptimer_cb, cpu);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index bb0e1baf628..75876359608 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2474,6 +2474,13 @@ static const ARMCPRegInfo v6k_cp_reginfo[] = {
       .resetvalue = 0 },
 };
 
+static void arm_gt_cntfrq_reset(CPUARMState *env, const ARMCPRegInfo *opaque)
+{
+    ARMCPU *cpu = env_archcpu(env);
+
+    cpu->env.cp15.c14_cntfrq = cpu->gt_cntfrq_hz;
+}
+
 #ifndef CONFIG_USER_ONLY
 
 static CPAccessResult gt_cntfrq_access(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -3228,13 +3235,6 @@ void arm_gt_hvtimer_cb(void *opaque)
     gt_recalc_timer(cpu, GTIMER_HYPVIRT);
 }
 
-static void arm_gt_cntfrq_reset(CPUARMState *env, const ARMCPRegInfo *opaque)
-{
-    ARMCPU *cpu = env_archcpu(env);
-
-    cpu->env.cp15.c14_cntfrq = cpu->gt_cntfrq_hz;
-}
-
 static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
     /*
      * Note that CNTFRQ is purely reads-as-written for the benefit
@@ -3514,7 +3514,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 0, .opc2 = 0,
       .type = ARM_CP_CONST, .access = PL0_R /* no PL1_RW in linux-user */,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_cntfrq),
-      .resetvalue = NANOSECONDS_PER_SECOND / GTIMER_SCALE,
+      .resetfn = arm_gt_cntfrq_reset,
     },
     { .name = "CNTVCT_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 0, .opc2 = 2,
-- 
2.34.1


