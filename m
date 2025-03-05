Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D2CC282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 02:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdzQ-0008VP-C0; Tue, 04 Mar 2025 20:56:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdz2-0007Y5-0F
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:46 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdz0-0000Sm-A3
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:39 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2f9b91dff71so10116302a91.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139736; x=1741744536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vfQRyN/xN8XAWj3zfMJIH9rgEdaZ3OiHYiZVgE3ckyQ=;
 b=Otb4IGQk3ksakcUgwb+rY1miqLEc2fgjyoOXI3+vvm9bwhj1kN95H1DCsBVnREUqGY
 KNg3WewfyHi/5Z+j+7JZ1pPHbcR9rDIYatix7BxdUVmUv/d4D8WET5juhOLwS4HDw9F3
 0d0UB9eRJk6sp6kV6v3ao0IRhehNtGtPwd6DFK0hnCVpi1q3QBAZRR3sJDCZ7ApZEjOC
 JMpPD4cg7iUjxo8tDHdj59qjIwz5GkpwG42xVpRUM6fZI3X5jwS+i+RJ/hts6YFZCZ5h
 /Pelno1lcvrfoIWj9o8D24fu8rZZBV2na4wT01FwnV7LpOFFslKzvpOQiU2sUrsg1E+Q
 cMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139736; x=1741744536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vfQRyN/xN8XAWj3zfMJIH9rgEdaZ3OiHYiZVgE3ckyQ=;
 b=n9xAYR2yboPwfeNbfOAyYCbQz4a6nCk+Z8LOJt82Xo4Yh9C4VcopYMYG+8nCT77lqE
 te+iW2k+j7Kodw5dPDJU3aS+EzCTSe0ANpG9RVMK9St2Nx5mNjo1ncyPgB/fBnLG1PAC
 50x7nZ+H675V71FmPK+n6X+FGVlJluEKv37XGF3sJtdSH08s1EzgH459u7mr0yS7SlGu
 TTeEp3FFpajDYErpihtWA9eaam0mcVspYrw/ZeB5iMP4pQleQThTzm/XT8ZpxCQEzYZR
 YzRMezwS5WlFmDjEkZUYLCu8xgm7kFAq8ol74/Atb3BWtcpFjDaX+nhbeDDTqrFsJjKR
 FrPw==
X-Gm-Message-State: AOJu0Ywk+H88OupYe4NC5ZHydle2apSejwzgxS4wSRquoV2lGGpBoRMR
 EUO0oIVgBjbUEQvlAXz+B5MZ2sVtt3vjjOgi4viByIB95n3W3rZjQODrtPjN+BU=
X-Gm-Gg: ASbGncv/VNIm+eeif9W8XCAWv0TsTeNI9lR25hH8O8At2eDMqeZuahcW0se1f2pF/pd
 P9o2r/Dn5Ql6CrSetAO/k7mHfnxIgYzijjOVDW6Dhxk+3YMwJSwFfJQqgAgxB1DVSGwvuKypCvg
 8P9eTnKTL/2DL3pW60MZUy81WiumiojrpNwKHoaHfk6MeCYI+0l63B0kO68G8ZNHkSF0f0Zw223
 C9R1ZVYSRcmEtuM4N0EPM3ZGA43iPXk6vlnK6slTuqn6+TIz2WSZrlKq/qJqQOvDHZnudH4dTHe
 HnN5gcaTS62rZFReOwzOMYgyBWQk6sPsAGZ02G0e5cObJpGerLdHOhqzMf4P7LWEV1FZucQqCkg
 uiirAa4GB2HMtVJfHpe8uaj+oekfLjPss1h7ljCcbMosydMUIDyQ=
X-Google-Smtp-Source: AGHT+IHEw3as2pbON/PWvHehLC2D8fnuVJygciAdwM0+4+Z9oxf6awgfltuvIigFkZDzx2FeJclpNQ==
X-Received: by 2002:a17:90a:e7d2:b0:2ee:3cc1:793a with SMTP id
 98e67ed59e1d1-2ff497c2e0amr2496745a91.29.1741139735783; 
 Tue, 04 Mar 2025 17:55:35 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.55.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:55:35 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 48/59] hw/riscv: add IOMMU HPM trace events
Date: Wed,  5 Mar 2025 11:52:56 +1000
Message-ID: <20250305015307.1463560-49-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Add a handful of trace events to allow for an easier time debugging the
HPM feature.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250224190826.1858473-11-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
index 7bcbb03d08..b50b14a654 100644
--- a/hw/riscv/trace-events
+++ b/hw/riscv/trace-events
@@ -19,3 +19,8 @@ riscv_iommu_sys_irq_sent(uint32_t vector) "IRQ sent to vector %u"
 riscv_iommu_sys_msi_sent(uint32_t vector, uint64_t msi_addr, uint32_t msi_data, uint32_t result) "MSI sent to vector %u msi_addr 0x%"PRIx64" msi_data 0x%x result %u"
 riscv_iommu_sys_reset_hold(int reset_type) "reset type %d"
 riscv_iommu_pci_reset_hold(int reset_type) "reset type %d"
+riscv_iommu_hpm_read(uint64_t cycle, uint32_t inhibit, uint64_t ctr_prev, uint64_t ctr_val) "cycle 0x%"PRIx64" inhibit 0x%x ctr_prev 0x%"PRIx64" ctr_val 0x%"PRIx64
+riscv_iommu_hpm_incr_ctr(uint64_t cntr_val) "cntr_val 0x%"PRIx64
+riscv_iommu_hpm_iocntinh_cy(bool prev_cy_inh) "prev_cy_inh %d"
+riscv_iommu_hpm_cycle_write(uint32_t ovf, uint64_t val) "ovf 0x%x val 0x%"PRIx64
+riscv_iommu_hpm_evt_write(uint32_t ctr_idx, uint32_t ovf, uint64_t val) "ctr_idx 0x%x ovf 0x%x val 0x%"PRIx64
-- 
2.48.1


