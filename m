Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1FDE6FE46
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 20:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smfV2-0000t7-PX; Fri, 06 Sep 2024 16:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tjeznach@rivosinc.com>)
 id 1smfV1-0000rB-2A
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 16:24:07 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tjeznach@rivosinc.com>)
 id 1smfUz-0000QO-41
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 16:24:06 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7d4ed6158bcso1906975a12.1
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 13:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725654243; x=1726259043;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AX79wnx6dRXtMeJe0s8GrSGb+R1ctuDzrWj8yIejzpA=;
 b=ha6hd5Iac6HCmLXVOu453Jvw1oW+B6dheMw7RRboHJl/3z+JuUbszl7iio3kTCNrNr
 vVaeuzrN3TDcskVrHElL3VZFeC6J5k4Bg8uZzoNw0fp7QOLBDHxA8kvENS+QPybKl2xf
 smJK399dytnFetonPXEeeS4UdYc9EZBjh41jsuiElQDApABUNnYn+/wQTv2dGDUFPInR
 ZcdyAbXrhA9JTutwlitLI8PLhzIlFCBD5QSrdhBBqx8kXlRibdL6MuQAUYfb4j0unUhB
 HeEzdwgBzJId/cqrTxVaxeQBItXbwTVATVriP5IdmDPrqQft6U2+2HQvy3zQhx3pEQzp
 ub4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725654243; x=1726259043;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AX79wnx6dRXtMeJe0s8GrSGb+R1ctuDzrWj8yIejzpA=;
 b=by28wkLzDjwZxdF6T7Tfqrckc4Td9dQsKY3sX2ZzVrwwRIB+oln2dZ5MFQ+KSIL9AS
 u1QEDcC95EH1hyhKHGszsjhzeSk364JpqGvcIjh0TQAlbhXUJmqEOrI0dfSUyvC4iGE+
 Ke3v5lxayzCGM9saEo1C5wUTtS6CazmFNQRHJY5wWDnN6XdPf2P7PxRcXOPjhvaG9mv1
 Ay0sC+X/UG/hOuaZZB7OJlaeDMDAsi/oRc8fU55aqzHXbQreehvPLjBrRDNW+Gs76TW5
 O2Fmk4XGJrYnmqnaM1mwa5Qmayg7fpkci5i9a/wkb8XYxw0l4ekK0h0O78w1R2/8mBJ6
 NBpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIa9/1Hk4GB0FbgDZzaiTmQRyLob0dO3/9PM+KRsFLYho3dQ3LSJYFa2QAFjcXyUTT3FFkz7bb2pb9@nongnu.org
X-Gm-Message-State: AOJu0YzxQl7NCR2Meas4WntknpI65t572uPy1cgIs7uT7/YAy8eCiWrD
 QjRgqUcEknwzXnJiy9R73G3wbvz5mM04ZK1V3fGzQNEehgrRm7AwgdVvnFaElEw=
X-Google-Smtp-Source: AGHT+IF+2ZT2/j9xELWPvuUiEnd7zF6Uh6O6bIhTJXSQxhkkjjfEqIqbfqUc2Ca9vzs1xmbtgB+2Og==
X-Received: by 2002:a17:90b:388f:b0:2c8:647:1600 with SMTP id
 98e67ed59e1d1-2dad4efde2dmr4253482a91.9.1725654242507; 
 Fri, 06 Sep 2024 13:24:02 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadc127c5bsm2027119a91.52.2024.09.06.13.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 13:24:02 -0700 (PDT)
From: Tomasz Jeznach <tjeznach@rivosinc.com>
To: Anup Patel <anup.patel@wdc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Tomasz Jeznach <tjeznach@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH] hw/intc: riscv-imsic: Fix interrupt state updates.
Date: Fri,  6 Sep 2024 13:23:13 -0700
Message-Id: <a7604e4d61068ca4d384ae2a1377e1521d4d0235.1725651699.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=tjeznach@rivosinc.com; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The IMSIC state variable eistate[] is modified by CSR instructions
within a range dedicated to the local CPU and by MMIO writes from any CPU.
Access to eistate from MMIO accessors is protected by the BQL, but
read-modify-write (RMW) sequences from CSRRW do not acquire the BQL,
making the RMW sequence vulnerable to a race condition with MMIO access
from a remote CPU.

This race can manifest as missing IPI or MSI in multi-CPU systems, eg:

[   43.008092] watchdog: BUG: soft lockup - CPU#2 stuck for 27s! [kworker/u19:1:52]
[   43.011723] CPU: 2 UID: 0 PID: 52 Comm: kworker/u19:1 Not tainted 6.11.0-rc6
[   43.013070] Workqueue: events_unbound deferred_probe_work_func
[   43.018776] [<ffffffff800b4a86>] smp_call_function_many_cond+0x190/0x5c2
[   43.019205] [<ffffffff800b4f28>] on_each_cpu_cond_mask+0x20/0x32
[   43.019447] [<ffffffff8001069a>] __flush_tlb_range+0xf2/0x190
[   43.019683] [<ffffffff80010914>] flush_tlb_kernel_range+0x20/0x28

The interrupt line raise/lower sequence was changed to prevent a race
between the evaluation of the eistate and the execution of the qemu_irq
raise/lower, ensuring that the interrupt line is not incorrectly
deactivated based on a stale topei check result. To avoid holding BQL
all modifications of eistate are converted to atomic operations.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
---
 hw/intc/riscv_imsic.c | 50 +++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index b90f0d731d..9ef65d4012 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -55,7 +55,7 @@ static uint32_t riscv_imsic_topei(RISCVIMSICState *imsic, uint32_t page)
                (imsic->eithreshold[page] <= imsic->num_irqs)) ?
                imsic->eithreshold[page] : imsic->num_irqs;
     for (i = 1; i < max_irq; i++) {
-        if ((imsic->eistate[base + i] & IMSIC_EISTATE_ENPEND) ==
+        if ((qatomic_read(&imsic->eistate[base + i]) & IMSIC_EISTATE_ENPEND) ==
                 IMSIC_EISTATE_ENPEND) {
             return (i << IMSIC_TOPEI_IID_SHIFT) | i;
         }
@@ -66,10 +66,24 @@ static uint32_t riscv_imsic_topei(RISCVIMSICState *imsic, uint32_t page)
 
 static void riscv_imsic_update(RISCVIMSICState *imsic, uint32_t page)
 {
+    uint32_t base = page * imsic->num_irqs;
+
+    /*
+     * Lower the interrupt line if necessary, then evaluate the current
+     * IMSIC state.
+     * This sequence ensures that any race between evaluating the eistate and
+     * updating the interrupt line will not result in an incorrectly
+     * deactivated connected CPU IRQ line.
+     * If multiple interrupts are pending, this sequence functions identically
+     * to qemu_irq_pulse.
+     */
+
+    if (qatomic_fetch_and(&imsic->eistate[base], ~IMSIC_EISTATE_ENPEND)) {
+        qemu_irq_lower(imsic->external_irqs[page]);
+    }
     if (imsic->eidelivery[page] && riscv_imsic_topei(imsic, page)) {
         qemu_irq_raise(imsic->external_irqs[page]);
-    } else {
-        qemu_irq_lower(imsic->external_irqs[page]);
+        qatomic_or(&imsic->eistate[base], IMSIC_EISTATE_ENPEND);
     }
 }
 
@@ -125,12 +139,11 @@ static int riscv_imsic_topei_rmw(RISCVIMSICState *imsic, uint32_t page,
         topei >>= IMSIC_TOPEI_IID_SHIFT;
         base = page * imsic->num_irqs;
         if (topei) {
-            imsic->eistate[base + topei] &= ~IMSIC_EISTATE_PENDING;
+            qatomic_and(&imsic->eistate[base + topei], ~IMSIC_EISTATE_PENDING);
         }
-
-        riscv_imsic_update(imsic, page);
     }
 
+    riscv_imsic_update(imsic, page);
     return 0;
 }
 
@@ -139,7 +152,7 @@ static int riscv_imsic_eix_rmw(RISCVIMSICState *imsic,
                                uint32_t num, bool pend, target_ulong *val,
                                target_ulong new_val, target_ulong wr_mask)
 {
-    uint32_t i, base;
+    uint32_t i, base, prev;
     target_ulong mask;
     uint32_t state = (pend) ? IMSIC_EISTATE_PENDING : IMSIC_EISTATE_ENABLED;
 
@@ -157,10 +170,6 @@ static int riscv_imsic_eix_rmw(RISCVIMSICState *imsic,
 
     if (val) {
         *val = 0;
-        for (i = 0; i < xlen; i++) {
-            mask = (target_ulong)1 << i;
-            *val |= (imsic->eistate[base + i] & state) ? mask : 0;
-        }
     }
 
     for (i = 0; i < xlen; i++) {
@@ -172,10 +181,15 @@ static int riscv_imsic_eix_rmw(RISCVIMSICState *imsic,
         mask = (target_ulong)1 << i;
         if (wr_mask & mask) {
             if (new_val & mask) {
-                imsic->eistate[base + i] |= state;
+                prev = qatomic_fetch_or(&imsic->eistate[base + i], state);
             } else {
-                imsic->eistate[base + i] &= ~state;
+                prev = qatomic_fetch_and(&imsic->eistate[base + i], ~state);
             }
+        } else {
+            prev = qatomic_read(&imsic->eistate[base + i]);
+        }
+        if (val && (prev & state)) {
+            *val |= mask;
         }
     }
 
@@ -302,14 +316,14 @@ static void riscv_imsic_write(void *opaque, hwaddr addr, uint64_t value,
     page = addr >> IMSIC_MMIO_PAGE_SHIFT;
     if ((addr & (IMSIC_MMIO_PAGE_SZ - 1)) == IMSIC_MMIO_PAGE_LE) {
         if (value && (value < imsic->num_irqs)) {
-            imsic->eistate[(page * imsic->num_irqs) + value] |=
-                                                    IMSIC_EISTATE_PENDING;
+            qatomic_or(&imsic->eistate[(page * imsic->num_irqs) + value],
+                       IMSIC_EISTATE_PENDING);
+
+            /* Update CPU external interrupt status */
+            riscv_imsic_update(imsic, page);
         }
     }
 
-    /* Update CPU external interrupt status */
-    riscv_imsic_update(imsic, page);
-
     return;
 
 err:

base-commit: fd1952d814da738ed107e05583b3e02ac11e88ff
-- 
2.34.1


