Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 567A6CCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 10:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8cD3-0004wt-6i; Tue, 14 Oct 2025 06:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8cD1-0004wl-I0
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 06:24:47 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8cCz-0000xX-6h
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 06:24:47 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3ece0e4c5faso4855322f8f.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 03:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760437481; x=1761042281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oJRYSBU6xVE0gEQyYOxxtPPrr9N1wGu437usvsxtC5Y=;
 b=W9t8+Cyq6Rih/0wZkTEXAc/4xtaC9P2ezhqQ93aXRrvYhmrX6cYnROGgUoTj0NSD6k
 xwEz1q1Z6PRDP58URONxq2iyKAF4rjGkDSaLv8Qg4EdxGC+ExFGHiRsDOfSjj56ydzfg
 OJzxr1vxlX0Hu9S0rJs1yo5+YmWvEyRPgArKlmxbkYaKW06+tPJx86zpYAEvrdDDv+p5
 MfDOnilihsyDodvSzRR8ueTMkrbT3oknI2nLLDyDR/5nWPPO/ekJcuwh2J0i+ghGhVTL
 Gq6tI/s25A7ENi/91XZjmF7q+e3xn4crg4N2A5WUVee5hJP0mAcerB4FZCD9fgDi/7jV
 6xMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760437481; x=1761042281;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oJRYSBU6xVE0gEQyYOxxtPPrr9N1wGu437usvsxtC5Y=;
 b=J8HpG9ef+AXhexWVOw7L+DyfJZ07o5rpIJ+/+5mf5QdoCz4+uwCUlqZ/7I1mZV9hit
 QKDcIwr2Ukz4HIexAYGTaC7W4k/oee+akxxBmBgJoWIdLtGG0xViMJSeWq999y7ZQB5I
 F71Oq5+p9xUu0xh1DjzZev8Od+YV3/mrpUuG6CshHIt6tU8Eh/v6LzEY1/jyy3mWqHfa
 ETwrvg69qF26F+q8jkNCoGM/lYpFL4LU25O62BwnQlhegWQUTO/As826xsw9VtwcZUIG
 RB5DQW2/lwN7jcvW6Ei7fZ9IJajtzsNmXYxJaNElU7vcT7O+mS+4qFQTCv5R8TVNmt74
 xlkQ==
X-Gm-Message-State: AOJu0Yzgevb6699bgLQG+NYj3wSr+emPO1nR2is56i89eqMnK8VDnrlV
 Y82WTQ4Z/WMJraxSDveptOSBhatUIkbBH0KBeZL+D81RW13rdHTgvLuA9T0m/dfZK0dilc8t/LR
 TMzaS
X-Gm-Gg: ASbGncshiYr4sOulGAs5tkMQkc3vDSa9BQzBzWFeuVSPx6Hj9p3+HooRtDl4TYeyVtU
 bVpgZH+3hhoT+NHmGYWtcahIymkVl1sK2w9/DWHOTDL5ioXykBuON6d8kUM8/1/TLCEkbfYsmsE
 m7IrkHhw9hETElMOU8Zt6Avfg/QszcVFVp/zOxDUPJGdL29JAC0HntJSO5LKp/pPB8rSyau7YjX
 K6rqReQn19cd16ukUcKn+KC56GwoEZPLkQo0TwBloXlvslBa6qzyu2ZzGIYV862RrnF/XLgiqTm
 FvUWzubmk4i7xxlZcH554uh3FZ0h9oLGA0orK2iAFPZ+VVXuMqflDGK9tD5RbSXZVZzNYyj+Nrp
 4ArEG4Q8rNpU5aNPJcjiezrAqWRvKAUSk8l1Fb1EugFuYVIgnvPs=
X-Google-Smtp-Source: AGHT+IEg64Fdq2fbLxbhtzYxETZtPWR+eZvMa2L57TLsTV0j9JSw173gCwZmOkGJrGIhrpEfYbAe0w==
X-Received: by 2002:a05:6000:4210:b0:3f2:b077:94bc with SMTP id
 ffacd0b85a97d-42666ac4119mr13769500f8f.4.1760437481475; 
 Tue, 14 Oct 2025 03:24:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57cd11sm23270265f8f.5.2025.10.14.03.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 03:24:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Salil Mehta <salil.mehta@opnsrc.net>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from kernel
 in cpuif reset
Date: Tue, 14 Oct 2025 11:24:39 +0100
Message-ID: <20251014102439.319915-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I've only tested this fairly lightly, but it seems to work.
Salil, does this fix the EBUSY issues you were seeing ?

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
index 9829e2146da..b95e6ea057a 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -666,11 +666,24 @@ static void kvm_arm_gicv3_get(GICv3State *s)
 
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
@@ -691,16 +704,8 @@ static void arm_gicv3_icc_reset(CPUARMState *env, const ARMCPRegInfo *ri)
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
@@ -939,6 +944,22 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
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


