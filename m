Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709CEE7716D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 13:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJByO-0002Su-V9; Thu, 05 Dec 2024 08:32:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tJBwN-0001F4-MK
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 08:30:49 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tJBwH-0005CD-4l
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 08:30:43 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-724ffe64923so1042791b3a.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 05:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1733405429; x=1734010229; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o3wQwqjU1VzzKyMbT4hRnaV/t/aFay9eavJGn9ofOPk=;
 b=QMVdm16l74kp857dnVMVsHMaamQAY0A+1gEC4/mkxd+F9FwQFinhHXfikx4Hwtq6b5
 omm1aA+jHRq4y7HhsIQt6JiScA/Jj6AWDhF16qEl6tApBsIpqWWiffL4OUz+aoZcr0K9
 Oz6T4TLdcnpJuFI9AxwOszbRAhBCv9R1gfT8PKbVtkizTUquzEhNsbI6Jvb6MzHGOnNK
 QFaWh0t5OgCPN69ym4q0lhA3ea+wO+t6UlrY8U1anTqzxz8EpfXeC+YxxBK1Im444IvL
 8oleMrZyi7zb/25oWIo30MzLCLFmKrvvbM3F/vRo+eFhcoIPeX+0tP8AR3o7eff5phPY
 HHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733405429; x=1734010229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o3wQwqjU1VzzKyMbT4hRnaV/t/aFay9eavJGn9ofOPk=;
 b=Z5g0CHZR0pzt/QTQQlJOD6DaeLydNIJQ3VqTSzwJO4KlN/nFzu5u1IA22Up2PTEfry
 MWKrsIohx3+iawYPAzostClgzoSizbCyQ4WgjVBtkSqu5YzXsEfe1qnQ39Qest6XSZCo
 4qxnTtfTfWtFZH3oSXiRaSko/dw66MJ58uC57Fze5UaLbG63VuDAFxYsNxWUtQyCN6MP
 9/pC5dxfwrHlrtJAjk8I4PjisFZbHoINSfAntHzxI53XqjyC1CrbgXWuUG5BKzq3dZ6G
 XS8cVTgzd1fv0NYUBWBN1y2fhBDoh+rKx+vEQexYZ1CBZWDexFx6WoE4LOh/1HajE4cn
 wshg==
X-Gm-Message-State: AOJu0YzMVScqG6TmjEDjcVI83/oU8fH5+0TrnlIRYEMR2958KAKXZX5V
 TNxL9+53GtvUJ9PyBYRoFrc1dvyssEdUbqyrEr14W61lXh9GHxzCYw/r4xv8gf1JZ8cUDUktX+o
 4
X-Gm-Gg: ASbGncs9x5ytXIGXVKi3raP06eJ3vlE40598mNsJ1CMslFuo+Ww+xADCQU/O4FaDWlh
 d/fxMqnLl1N4/xhOztjYt4G9lSGAYq2r6hmf+YQ+Xo0FqHCFZ/Kmacb5GT60gdzvmwy/9XRNNKH
 xcHEB7pOMtKNkjUvdY3hEP7tWDSK/LU8E0lzvrNPy8ny/qqgeii3JHCftmyjthAU4VD1MP4kP6U
 4QbkspR9yaBdIc74sqVa3jvFD1ia7gcPUyF7xV6yrTqVMd1aURDA8sT18WxGB13mu8TNoIC/mgB
X-Google-Smtp-Source: AGHT+IFUyMlCc8OOYnlwW4TEHgHD7BgeQx09ZelVl/jN33gIeobFDKhkbO5QBwpMQns2PuA3E+tJ4Q==
X-Received: by 2002:a05:6a00:1387:b0:71e:4296:2e with SMTP id
 d2e1a72fcca58-7257fa77460mr14354642b3a.11.1733405428641; 
 Thu, 05 Dec 2024 05:30:28 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725a2a8f512sm1250315b3a.126.2024.12.05.05.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 05:30:28 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Tomasz Jeznach <tjeznach@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-10.0 06/11] hw/riscv/riscv-iommu: add IOCOUNTINH mmio
 writes
Date: Thu,  5 Dec 2024 10:29:58 -0300
Message-ID: <20241205133003.184581-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241205133003.184581-1-dbarboza@ventanamicro.com>
References: <20241205133003.184581-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x435.google.com
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

From: Tomasz Jeznach <tjeznach@rivosinc.com>

RISCV_IOMMU_REG_IOCOUNTINH is done by riscv_iommu_process_iocntinh_cy(),
which is called during riscv_iommu_mmio_write() callback via a new
riscv_iommu_pricess_hpm_writes() helper.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/riscv-iommu-hpm.c | 60 ++++++++++++++++++++++++++++++++++++++
 hw/riscv/riscv-iommu-hpm.h |  1 +
 hw/riscv/riscv-iommu.c     | 38 ++++++++++++++++++++++++
 3 files changed, 99 insertions(+)

diff --git a/hw/riscv/riscv-iommu-hpm.c b/hw/riscv/riscv-iommu-hpm.c
index 325088333e..70814b942d 100644
--- a/hw/riscv/riscv-iommu-hpm.c
+++ b/hw/riscv/riscv-iommu-hpm.c
@@ -202,3 +202,63 @@ void riscv_iommu_hpm_timer_cb(void *priv)
         riscv_iommu_notify(s, RISCV_IOMMU_INTR_PM);
     }
 }
+
+static void hpm_setup_timer(RISCVIOMMUState *s, uint64_t value)
+{
+    const uint32_t inhibit = riscv_iommu_reg_get32(
+        s, RISCV_IOMMU_REG_IOCOUNTINH);
+    uint64_t overflow_at, overflow_ns;
+
+    if (get_field(inhibit, RISCV_IOMMU_IOCOUNTINH_CY)) {
+        return;
+    }
+
+    /*
+     * We are using INT64_MAX here instead to UINT64_MAX because cycle counter
+     * has 63-bit precision and INT64_MAX is the maximum it can store.
+     */
+    if (value) {
+        overflow_ns = INT64_MAX - value + 1;
+    } else {
+        overflow_ns = INT64_MAX;
+    }
+
+    overflow_at = (uint64_t)qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + overflow_ns;
+
+    if (overflow_at > INT64_MAX) {
+        s->irq_overflow_left = overflow_at - INT64_MAX;
+        overflow_at = INT64_MAX;
+    }
+
+    timer_mod_anticipate_ns(s->hpm_timer, overflow_at);
+}
+
+/* Updates the internal cycle counter state when iocntinh:CY is changed. */
+void riscv_iommu_process_iocntinh_cy(RISCVIOMMUState *s, bool prev_cy_inh)
+{
+    const uint32_t inhibit = riscv_iommu_reg_get32(
+        s, RISCV_IOMMU_REG_IOCOUNTINH);
+
+    /* We only need to process CY bit toggle. */
+    if (!(inhibit ^ prev_cy_inh)) {
+        return;
+    }
+
+    if (!(inhibit & RISCV_IOMMU_IOCOUNTINH_CY)) {
+        /*
+         * Cycle counter is enabled. Just start the timer again and update
+         * the clock snapshot value to point to the current time to make
+         * sure iohpmcycles read is correct.
+         */
+        s->hpmcycle_prev = get_cycles();
+        hpm_setup_timer(s, s->hpmcycle_val);
+    } else {
+        /*
+         * Cycle counter is disabled. Stop the timer and update the cycle
+         * counter to record the current value which is last programmed
+         * value + the cycles passed so far.
+         */
+        s->hpmcycle_val = s->hpmcycle_val + (get_cycles() - s->hpmcycle_prev);
+        timer_del(s->hpm_timer);
+    }
+}
diff --git a/hw/riscv/riscv-iommu-hpm.h b/hw/riscv/riscv-iommu-hpm.h
index cd896d3b7c..ee888650fb 100644
--- a/hw/riscv/riscv-iommu-hpm.h
+++ b/hw/riscv/riscv-iommu-hpm.h
@@ -26,5 +26,6 @@ uint64_t riscv_iommu_hpmcycle_read(RISCVIOMMUState *s);
 void riscv_iommu_hpm_incr_ctr(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
                               unsigned event_id);
 void riscv_iommu_hpm_timer_cb(void *priv);
+void riscv_iommu_process_iocntinh_cy(RISCVIOMMUState *s, bool prev_cy_inh);
 
 #endif
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 2ec388ff3d..56ec2d6d42 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1923,6 +1923,27 @@ static void riscv_iommu_update_ipsr(RISCVIOMMUState *s, uint64_t data)
     riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_IPSR, ipsr_set, ipsr_clr);
 }
 
+static void riscv_iommu_process_hpm_writes(RISCVIOMMUState *s,
+                                           uint32_t regb,
+                                           bool prev_cy_inh)
+{
+    switch (regb) {
+    case RISCV_IOMMU_REG_IOCOUNTINH:
+        riscv_iommu_process_iocntinh_cy(s, prev_cy_inh);
+        break;
+
+    case RISCV_IOMMU_REG_IOHPMCYCLES:
+    case RISCV_IOMMU_REG_IOHPMCYCLES + 4:
+        /* not yet implemented */
+        break;
+
+    case RISCV_IOMMU_REG_IOHPMEVT_BASE ...
+        RISCV_IOMMU_REG_IOHPMEVT(RISCV_IOMMU_IOCOUNT_NUM) + 4:
+        /* not yet implemented */
+        break;
+    }
+}
+
 /*
  * Write the resulting value of 'data' for the reg specified
  * by 'reg_addr', after considering read-only/read-write/write-clear
@@ -1950,6 +1971,7 @@ static MemTxResult riscv_iommu_mmio_write(void *opaque, hwaddr addr,
     uint32_t regb = addr & ~3;
     uint32_t busy = 0;
     uint64_t val = 0;
+    bool cy_inh = false;
 
     if ((addr & (size - 1)) != 0) {
         /* Unsupported MMIO alignment or access size */
@@ -2017,6 +2039,16 @@ static MemTxResult riscv_iommu_mmio_write(void *opaque, hwaddr addr,
         busy = RISCV_IOMMU_TR_REQ_CTL_GO_BUSY;
         break;
 
+    case RISCV_IOMMU_REG_IOCOUNTINH:
+        if (addr != RISCV_IOMMU_REG_IOCOUNTINH) {
+            break;
+        }
+        /* Store previous value of CY bit. */
+        cy_inh = !!(riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_IOCOUNTINH) &
+            RISCV_IOMMU_IOCOUNTINH_CY);
+        break;
+
+
     default:
         break;
     }
@@ -2035,6 +2067,12 @@ static MemTxResult riscv_iommu_mmio_write(void *opaque, hwaddr addr,
         stl_le_p(&s->regs_rw[regb], rw | busy);
     }
 
+    /* Process HPM writes and update any internal state if needed. */
+    if (regb >= RISCV_IOMMU_REG_IOCOUNTOVF &&
+        regb <= (RISCV_IOMMU_REG_IOHPMEVT(RISCV_IOMMU_IOCOUNT_NUM) + 4)) {
+        riscv_iommu_process_hpm_writes(s, regb, cy_inh);
+    }
+
     if (process_fn) {
         process_fn(s);
     }
-- 
2.47.1


