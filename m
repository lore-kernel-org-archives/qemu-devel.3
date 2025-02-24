Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB47C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 19:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmdpN-0005lX-Qi; Mon, 24 Feb 2025 14:09:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tmdp1-0005fV-0s
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:08:56 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tmdoy-0004pd-7w
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:08:54 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-220c8f38febso101996175ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 11:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740424130; x=1741028930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yk1rl5jPE9Nq4m5iJHnqOZWE623sEepVUXfLI4QAl9s=;
 b=gElUSMMvO2wPmc/dK3K5rAts/kvmtaWf0Mzn2fzWRbtR3/4U4pgbEJVzoHbKJZQ0qk
 h3mIZUwjVDj8xrvd0vdphaTNvHx9eDR4U3q0a3U6QWsUguvG8Lvik4S2AsCpc7TRoSsd
 iEVp2AsBp3CSlgE+5OYY2opdoELAOkQq6pxnX2Vt+iiypjhJnO7Bso0kWpE2ZPbNA1t6
 5May6tvCNWpoVahwylSdgL+sBlGrDl+U+c0B6b0aMtylblIB16HXJE9Hgf0muxASaroe
 SVflj0B2txypNOTImHS+oRN/O1dD1bZmLGHPk0XQrOJfsgP0sv12D9uhpSnCU31eXNCM
 wbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740424130; x=1741028930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yk1rl5jPE9Nq4m5iJHnqOZWE623sEepVUXfLI4QAl9s=;
 b=u3IQSN1uyX0cP+OnQ8+tsXqVxwhnvXk1Eh7rTVKdxbvIOHxmh7+JUKxlct/3ZQ6Sds
 T/RzdnKcQUAilzl09kMhdQjLHkD8anMNwcLmot/3lmfyS3S0+n4OCm0PTqLgEgqzM7rw
 8yYMR2+G+X+NIf3e0uhaKdvm+kiWfHSkWlGhJRp3jboplLts54GljK8wdGTqgguJs+80
 0tkaSzae+5Q7gKBEUITMQpvxDPYYVf9WhjwuY8v8HcTk8ogPUxp1it6reDjtr/lovlRf
 fjDmLKUciVPZSMnXR+/BN7QWEymcOcdrlz8l1soImowbWMvPrrE7zrqldihI2Yzsee4T
 46SA==
X-Gm-Message-State: AOJu0YwGCY6mton28fY7hbKgLsvWBBosN8nh7nrkaPHztGrxhxAzT4Dp
 GPTTgnUJYx16o5VAJvSkiSEV4iutZARSQ9ToHLHXXBPa7B9hc3ZsnoWDqbidnPnBKWUoWlcKTuq
 s
X-Gm-Gg: ASbGnctDR9axyGcfnvvVewrsQ70OQUoq/3IbmAWB/ASDpttB+ocbz/bUtLhj4emKh22
 nkQW66Znqwehd/mdPL/rQxNiVWgtA6HGOePeGI7cmh5yUtF914bffOlKBOGbSWIFlrTBesMhtkH
 1qe8GD4hrhRwbV8NqxXqccyoBDszbPRU2fbSd9ZwmXC/9W+YsZ/PScOQUDDVX07YE8BS0zA/BkM
 agq9ajWW+zyMooHOsI+n1bClqnJySkZjFrPtRitCxofisu5kW5nJYQTO+RyFgR4qsu4UrqC/UlA
 QAUbvjEHbTOZcuC+pVlZBXkXa39sYQ==
X-Google-Smtp-Source: AGHT+IGvd/3CkakVkdQqy3xTxE6xG/4agTOWBT2PT3gfzJF0nw3kTYz4Ij71i3IzNaVfa8gN3x4wig==
X-Received: by 2002:a17:902:f544:b0:215:6cb2:7877 with SMTP id
 d9443c01a7336-2219ff827cdmr287733175ad.4.1740424130477; 
 Mon, 24 Feb 2025 11:08:50 -0800 (PST)
Received: from grind.. ([2804:7f0:bcc0:6edb:f473:a9df:d551:443b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545df28sm183583155ad.153.2025.02.24.11.08.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 11:08:50 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Tomasz Jeznach <tjeznach@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 06/11] hw/riscv/riscv-iommu: add IOCOUNTINH mmio writes
Date: Mon, 24 Feb 2025 16:08:21 -0300
Message-ID: <20250224190826.1858473-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224190826.1858473-1-dbarboza@ventanamicro.com>
References: <20250224190826.1858473-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x630.google.com
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
Acked-by: Alistair Francis <alistair.francis@wdc.com>
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
index f26aa15f55..a4580dca0b 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2024,6 +2024,27 @@ static void riscv_iommu_update_ipsr(RISCVIOMMUState *s, uint64_t data)
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
@@ -2051,6 +2072,7 @@ static MemTxResult riscv_iommu_mmio_write(void *opaque, hwaddr addr,
     uint32_t regb = addr & ~3;
     uint32_t busy = 0;
     uint64_t val = 0;
+    bool cy_inh = false;
 
     if ((addr & (size - 1)) != 0) {
         /* Unsupported MMIO alignment or access size */
@@ -2118,6 +2140,16 @@ static MemTxResult riscv_iommu_mmio_write(void *opaque, hwaddr addr,
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
@@ -2136,6 +2168,12 @@ static MemTxResult riscv_iommu_mmio_write(void *opaque, hwaddr addr,
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
2.48.1


