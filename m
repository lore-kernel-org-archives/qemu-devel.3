Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B08DE7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 13:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJByO-0002QH-KW; Thu, 05 Dec 2024 08:32:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tJBwR-0001Fm-4I
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 08:30:54 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tJBwM-0005k0-Gg
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 08:30:49 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7251abe0e69so942188b3a.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 05:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1733405441; x=1734010241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EMWelhyb6LhFgpAB7Jml7kse+RoXi53PYiYc5I5dJ0Q=;
 b=jz1hk7DXYTrPZBr9GQPC9RbzKlMvjjzJ1hzvgGvVerZzqk2iUfnkCO9na3eJj8bPDx
 5Ow8x1tb1R4N3hOVA/FtxfARFeUEThUCM0ThyBfuNc2ltZ0iI4sQ4M1E1XpWzS58n305
 acUs7GS0QW7r6WTvHCOREWga3dDCv81qEeFiMt3i1m8f2xgCxIkjvlKcdXiekdrcMDbg
 6JkG9x67aQNJk1t26P4yFGcsshJdGCwUdqaX75EbpRX86t0iLJIVPCfd7XESZ/DkTAGs
 QT0wWO1nyZ7otQiWWRIVramYBeXnrXUgrbYYgWfGZF8Iu79dCOovdlirrftXNM1FYW3c
 RF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733405441; x=1734010241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EMWelhyb6LhFgpAB7Jml7kse+RoXi53PYiYc5I5dJ0Q=;
 b=OlILKuvADl0M3hst6DUIXjunsrGIAikqIIUyaV7flL0f3g5dcDtCPCfnflbbhdAp4K
 9R0gHHhcw1J1YPizcmiqU2NoamrwwKNd9qSppPE4lK+rYLLNIH4MufGTyDVSowDGGUZi
 ATTZX1RZinN/DYxJxxlytvJybvNe+ZGnU20k4Zb9wXp/eh+xKMP8bek7AoAg+HDsbYjT
 qQhmnMtzssd8E20I3EnW1SbSFtrwx3FoqB7yMGERaUV9eTBYhw5F0P8YjEcIOn/GCLhy
 D29QyzZRwwMKIdQuPvrRunXX5YQgH23MrWDPsiRo1Z/w3nTWa6JMG5N0XfAlXn4f5wit
 OBew==
X-Gm-Message-State: AOJu0YzmqQgb854K6OSAqt4PukQsg19bPSItH5ZpHTt4MB6AWdwTBQX7
 KkLBCKh88ahaNTihAXghO7zYSxxPV3n1AUUak8y923WoBovXpfK0z7hMRUhH4WLEB9HNNOnQMjR
 O
X-Gm-Gg: ASbGncsR43QO3PcuefhfPwjdbH/5im4uGRr2gkaA6VI8PeHoyumdN6/Ak8ZO/H/vQ3F
 4kExt3Zen/nI1KBW7VRxrMj6VzWh6aAFqe555Ue6nkczaU4jK4j7zzKpNPqqyknYPm+d7hYz8uG
 5c6k4W74esm9IRWpESXqnMir2sm+jtmdZwx4L18Bn8yAU/dJRvIuOF2063VYA2fYE5t8IjfoLm2
 SRS/hWj9Qh35i08NKloB71mR364F8ImoSuh8OG9H2favA9tDHZXRcUZJWuovg9VIRD18ghroibW
X-Google-Smtp-Source: AGHT+IFSqQrfCERwoCrXCqjh1BNtqqM60xGHb4m+r65wvSYxWVJtAiOl2PKHBTfDuu4nK9f/YtuCIg==
X-Received: by 2002:a05:6a00:2e99:b0:725:b347:c3cd with SMTP id
 d2e1a72fcca58-725b347c4a8mr221786b3a.9.1733405440560; 
 Thu, 05 Dec 2024 05:30:40 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725a2a8f512sm1250315b3a.126.2024.12.05.05.30.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 05:30:40 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-10.0 10/11] hw/riscv: add IOMMU HPM trace events
Date: Thu,  5 Dec 2024 10:30:02 -0300
Message-ID: <20241205133003.184581-11-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241205133003.184581-1-dbarboza@ventanamicro.com>
References: <20241205133003.184581-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42e.google.com
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

Add a handful of trace events to allow for an easier time debugging the
HPM feature.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/riscv-iommu-hpm.c | 10 ++++++++++
 hw/riscv/trace-events      |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/hw/riscv/riscv-iommu-hpm.c b/hw/riscv/riscv-iommu-hpm.c
index 5518c287a5..c5034bff79 100644
--- a/hw/riscv/riscv-iommu-hpm.c
+++ b/hw/riscv/riscv-iommu-hpm.c
@@ -39,6 +39,8 @@ uint64_t riscv_iommu_hpmcycle_read(RISCVIOMMUState *s)
     const uint64_t ctr_prev = s->hpmcycle_prev;
     const uint64_t ctr_val = s->hpmcycle_val;
 
+    trace_riscv_iommu_hpm_read(cycle, inhibit, ctr_prev, ctr_val);
+
     if (get_field(inhibit, RISCV_IOMMU_IOCOUNTINH_CY)) {
         /*
          * Counter should not increment if inhibit bit is set. We can't really
@@ -61,6 +63,8 @@ static void hpm_incr_ctr(RISCVIOMMUState *s, uint32_t ctr_idx)
     cntr_val = ldq_le_p(&s->regs_rw[RISCV_IOMMU_REG_IOHPMCTR_BASE + off]);
     stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_IOHPMCTR_BASE + off], cntr_val + 1);
 
+    trace_riscv_iommu_hpm_incr_ctr(cntr_val);
+
     /* Handle the overflow scenario. */
     if (cntr_val == UINT64_MAX) {
         /*
@@ -244,6 +248,8 @@ void riscv_iommu_process_iocntinh_cy(RISCVIOMMUState *s, bool prev_cy_inh)
         return;
     }
 
+    trace_riscv_iommu_hpm_iocntinh_cy(prev_cy_inh);
+
     if (!(inhibit & RISCV_IOMMU_IOCOUNTINH_CY)) {
         /*
          * Cycle counter is enabled. Just start the timer again and update
@@ -268,6 +274,8 @@ void riscv_iommu_process_hpmcycle_write(RISCVIOMMUState *s)
     const uint64_t val = riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_IOHPMCYCLES);
     const uint32_t ovf = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_IOCOUNTOVF);
 
+    trace_riscv_iommu_hpm_cycle_write(ovf, val);
+
     /*
      * Clear OF bit in IOCNTOVF if it's being cleared in IOHPMCYCLES register.
      */
@@ -352,6 +360,8 @@ void riscv_iommu_process_hpmevt_write(RISCVIOMMUState *s, uint32_t evt_reg)
         return;
     }
 
+    trace_riscv_iommu_hpm_evt_write(ctr_idx, ovf, val);
+
     /* Clear OF bit in IOCNTOVF if it's being cleared in IOHPMEVT register. */
     if (get_field(ovf, BIT(ctr_idx + 1)) &&
         !get_field(val, RISCV_IOMMU_IOHPMEVT_OF)) {
diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
index aaa2c0eb94..846f5f19c7 100644
--- a/hw/riscv/trace-events
+++ b/hw/riscv/trace-events
@@ -19,3 +19,8 @@ riscv_iommu_sys_irq_sent(uint32_t vector) "IRQ sent to vector %u"
 riscv_iommu_sys_msi_sent(uint32_t vector, uint64_t msi_addr, uint32_t msi_data, uint32_t result) "MSI sent to vector %u msi_addr 0x%lx msi_data 0x%x result %u"
 riscv_iommu_sys_reset_hold(int reset_type) "reset type %d"
 riscv_iommu_pci_reset_hold(int reset_type) "reset type %d"
+riscv_iommu_hpm_read(uint64_t cycle, uint32_t inhibit, uint64_t ctr_prev, uint64_t ctr_val) "cycle 0x%lx inhibit 0x%x ctr_prev 0x%lx ctr_val 0x%lx"
+riscv_iommu_hpm_incr_ctr(uint64_t cntr_val) "cntr_val 0x%lx"
+riscv_iommu_hpm_iocntinh_cy(bool prev_cy_inh) "prev_cy_inh %d"
+riscv_iommu_hpm_cycle_write(uint32_t ovf, uint64_t val) "ovf 0x%x val 0x%lx"
+riscv_iommu_hpm_evt_write(uint32_t ctr_idx, uint32_t ovf, uint64_t val) "ctr_idx 0x%x ovf 0x%x val 0x%lx"
-- 
2.47.1


