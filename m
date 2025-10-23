Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C33FCCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwje-0004o0-5w; Thu, 23 Oct 2025 10:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBwjb-0004mv-MF
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:56:12 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBwjZ-0005Zn-Qx
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:56:11 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-471b80b994bso13024365e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761231368; x=1761836168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ar66TTmPzOwjx9/IPkHZAqhVMFm+dkSo+frnjYQI6Ts=;
 b=SqkzF6PkCVUOUe5g4LT6+fMMTN+h350TMB22iy7IUPxsNQvpB2uTFKxDjucTkZblMP
 OR3tnRLvfTmNvXJKL/qViFoRTm28c4WddV/czWYXhL1BDOt5diMhwG0t1Y7cvEM4YbnD
 fuYeNKKI+fkZsJ91UUeHx7amEvEr/xnxAArtLg0pRTLBVsQbg8fsMG5OtYcEOaTwIkA3
 8sBOGneKh7m00CfHk/HeJ6IShV5EXKyLzCsr1YvY3Pge1r3BurzSkqAqrVtc8TtBAR7O
 Th98SyqDgOf6gAZugP1YN3hk6PF/YEWJqIP1oNN1QLMlYbJoTdxyWd1MroSOfD/C0IL9
 3j8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761231368; x=1761836168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ar66TTmPzOwjx9/IPkHZAqhVMFm+dkSo+frnjYQI6Ts=;
 b=bK7T96gFQeEVPb4OLD6rQf2JSBcEqrrH5tHbcW8eYhPWh0N4U8yoFtz9xJBIEDUG7K
 qbm/fs0jDvq4pZl5nHZe0jBYWFHOgprzuMRfpi7nHnUe2mnJvPhYSWW3TAgtHew0/hiQ
 f6ipO9pi5/n12iTDYYHZEkTuqCSeMdhBgH+bMH6uhXSHoGG9cHfp3X25OP5ibfYfCmOX
 2O9KpwrYEZdwlq+zj3ZTmI4EDc17E0orgCZ0LXy73r/FpXOhUI3oWf4W7DnQzxBIrFCQ
 bu06YakW+n9Mt8zN4wZ/eJyL9BJBCkDZszCgAjXWfkmYBeXdP8xw1SIEQpwHsecqI3kz
 Auew==
X-Gm-Message-State: AOJu0YxgQPn9++I9lCxyUyRZCk1KYEkJ1jdGCwPEwC8rT4CdJMLvHGYp
 NaFA8r4m3/WYCf0B+dOM8+o2LBxonrjdsjGvmmYfXwmMkoeza6UKjiPXf4JshGly/fof++0qq3q
 0CGaU
X-Gm-Gg: ASbGncvuEslyoaqov+Q0YHhZefUREZkHBxFjjqbTu/isOTMAFoJLnJQN0+eS+GnctVx
 GNLgs82m40B2zdqmHZnDKV+pV569l6LX4WEWWqBj23V1D0CsykDcqODkKkmUNKYtY0SkFnkTkTR
 /EaQEGG1gOL6vNauI1Kk/jvyRsz02kfMgMu5LBxjPEcnYWZtPMACLx0W9m/MYogxz0rVVdbtgjq
 0E8TuI4T0+hX4X6Tv3Li3xM4mhdeipo1FfUQU4niXb/sUUB8N9MPAlH57Y9eRbSi3kk32jEKK+j
 f+vucoMUJ4SuNHNXToCjsiU5EC16S4Cixta52Teyb3FHYnI2ArPo1CHNwAWEVGlv9rnB01pN51c
 UQ7PkN8oo4OcN+Ss+dCKmBCsvVcrTVm6550C9exsO5y5X5ZtiK7lz86W5PViZOftigOnAwe8YTL
 FE3RyKPQuk9bY8iuf3
X-Google-Smtp-Source: AGHT+IFAC7Z93O8G8w+8wTuj+wQ/M1qOZr9n+fPLrXCAU0AU3sk9aJ/E114yInhoDPrevgAcDObaDg==
X-Received: by 2002:a05:600c:8b66:b0:46e:428a:b4c7 with SMTP id
 5b1f17b1804b1-471179120ccmr170785645e9.23.1761231367862; 
 Thu, 23 Oct 2025 07:56:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898acc63sm4398465f8f.27.2025.10.23.07.56.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 07:56:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/16] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
Date: Thu, 23 Oct 2025 15:55:49 +0100
Message-ID: <20251023145554.2062752-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023145554.2062752-1-peter.maydell@linaro.org>
References: <20251023145554.2062752-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

Currently in arm_gicv3_icc_reset() we read the kernel's value of
ICC_CTLR_EL1 as part of resetting the CPU interface.  This mostly
works, but we're actually breaking an assumption the kernel makes
that userspace only accesses the in-kernel GIC data when the VM is
totally paused, which may not be the case if a single vCPU is being
reset.  The effect is that it's possible that the read attempt
returns EBUSY.

Avoid this by reading the kernel's value of the reset ICC_CTLR_EL1
once in device realize. This brings ICC_CTLR_EL1 into line with
the other cpuif registers, where we assume we know what the kernel
is resetting them to and just update QEMU's data structures in
arm_gicv3_icc_reset().

Reviewed-by: Salil Mehta <salil.mehta@huawei.com>
Tested-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20251014102439.319915-1-peter.maydell@linaro.org
---
 include/hw/intc/arm_gicv3_common.h |  3 ++
 hw/intc/arm_gicv3_kvm.c            | 49 +++++++++++++++++++++---------
 2 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index 38aa1961c50..61d51915e07 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -166,6 +166,9 @@ struct GICv3CPUState {
     uint64_t icc_igrpen[3];
     uint64_t icc_ctlr_el3;
 
+    /* For KVM, cached copy of the kernel reset value of ICC_CTLR_EL1 */
+    uint64_t kvm_reset_icc_ctlr_el1;
+
     /* Virtualization control interface */
     uint64_t ich_apr[3][4]; /* ich_apr[GICV3_G1][x] never used */
     uint64_t ich_hcr_el2;
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 405496c7bb3..66b0dddfd4b 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -658,11 +658,24 @@ static void kvm_arm_gicv3_get(GICv3State *s)
 
 static void arm_gicv3_icc_reset(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    GICv3State *s;
-    GICv3CPUState *c;
+    GICv3CPUState *c = (GICv3CPUState *)env->gicv3state;
 
-    c = (GICv3CPUState *)env->gicv3state;
-    s = c->gic;
+    /*
+     * This function is called when each vcpu resets. The kernel
+     * API for the GIC assumes that it is only to be used when the
+     * whole VM is paused, so if we attempt to read the kernel's
+     * reset values here we might get EBUSY failures.
+     * So instead we assume we know what the kernel's reset values
+     * are (mostly zeroes) and only update the QEMU state struct
+     * fields. The exception is that we do need to know the kernel's
+     * idea of the ICC_CTLR_EL1 reset value, so we cache that at
+     * device realize time.
+     *
+     * This makes these sysregs different from the usual CPU ones,
+     * which can be validly read and written when only the single
+     * vcpu they apply to is paused, and where (in target/arm code)
+     * we read the reset values out of the kernel on every reset.
+     */
 
     c->icc_pmr_el1 = 0;
     /*
@@ -683,16 +696,8 @@ static void arm_gicv3_icc_reset(CPUARMState *env, const ARMCPRegInfo *ri)
     memset(c->icc_apr, 0, sizeof(c->icc_apr));
     memset(c->icc_igrpen, 0, sizeof(c->icc_igrpen));
 
-    if (s->migration_blocker) {
-        return;
-    }
-
-    /* Initialize to actual HW supported configuration */
-    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS,
-                      KVM_VGIC_ATTR(ICC_CTLR_EL1, c->gicr_typer),
-                      &c->icc_ctlr_el1[GICV3_NS], false, &error_abort);
-
-    c->icc_ctlr_el1[GICV3_S] = c->icc_ctlr_el1[GICV3_NS];
+    c->icc_ctlr_el1[GICV3_NS] = c->kvm_reset_icc_ctlr_el1;
+    c->icc_ctlr_el1[GICV3_S] = c->kvm_reset_icc_ctlr_el1;
 }
 
 static void kvm_arm_gicv3_reset_hold(Object *obj, ResetType type)
@@ -926,6 +931,22 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
                                     kvm_arm_gicv3_notifier,
                                     MIG_MODE_CPR_TRANSFER);
     }
+
+    /*
+     * Now we can read the kernel's initial value of ICC_CTLR_EL1, which
+     * we will need if a CPU interface is reset. If the kernel is ancient
+     * and doesn't support writing the GIC state then we don't need to
+     * care what reset does to QEMU's data structures.
+     */
+    if (!s->migration_blocker) {
+        for (i = 0; i < s->num_cpu; i++) {
+            GICv3CPUState *c = &s->cpu[i];
+
+            kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS,
+                              KVM_VGIC_ATTR(ICC_CTLR_EL1, c->gicr_typer),
+                              &c->kvm_reset_icc_ctlr_el1, false, &error_abort);
+        }
+    }
 }
 
 static void kvm_arm_gicv3_class_init(ObjectClass *klass, const void *data)
-- 
2.43.0


