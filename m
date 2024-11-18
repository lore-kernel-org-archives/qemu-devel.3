Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7549FD10F3E
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 01:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCqO4-00015Y-Cd; Sun, 17 Nov 2024 20:17:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tCqO2-00013Q-8Q
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 20:17:06 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tCqNx-0006Ql-Td
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 20:17:05 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-72483f6e2f3so1062007b3a.1
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2024 17:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731892619; x=1732497419;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LMnKYE8WPdvKl7s3HVfAdc/3hWY0P2i17ofoTw5jOGw=;
 b=MVtNO9o2nf6bMsK91+u6gKhyfpaYGQMCLtlWW9d5i3fZLcNXCA6CrajnOlx3pFXkL4
 XMJ2QJx4xwaTK6N1/YLLScIhG7y2DMQfl6ZnAet6ki3jcSx61gFyVRljyUvsYbUepG8k
 e8GekvgbSEHc/fp9Mp3Gt7XGnJmHSOkw7MGVi0KuD7tmRfI9DhM3rAHCex8BBZeVTdBr
 UKLsFIkOoifccgNRaTWQyQ6rqZpH5k8vIeNo0Osq3oYnKPCPCFSYPF1DaDJzhxSrTCJH
 Si0VIYDARwm1+UBTAD+ySbHsOosbE5b8FiFAOtnvWLBNGFq56KosILCarEAc6gfL273n
 k+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731892619; x=1732497419;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LMnKYE8WPdvKl7s3HVfAdc/3hWY0P2i17ofoTw5jOGw=;
 b=gL+v9i7JGplK+UXQpGYYGb2o4yNhiV2LKXWAqbMQ1IeF3ehIKm0nTgJkHeSgzRz7J0
 ZZbydL+txFgCwVSAv45PeCMgHrLVXL/5Hb5B/YrggRKIRoug0j5+UzN7Ur2lKA/hmIgI
 lk0gktC12ZLKsavbQJ820dPpoULGYmV93JBFRMrNHmIfnU9WX5+qw677GNMrDQmU4MHE
 nq+09X8dbPuhIrsKIXmCpKzEpTjV0IV2ogy04ammfxYcVnlpbqB4Aw7UkJFOEqk/fo1Q
 orbgKxTSYluWCsSVSQfY9rB3EJeSQDCUTnPQvv5l+aO87RqyhKKT/GL3OhR8wy5UpFCj
 G8zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCURMP+kyfoBksa1kOP2aGELB/gdQ2vGreb52SnykQgzE7X74x3P2dyxaRUG577NuXY4wW2DGnARHUBZ@nongnu.org
X-Gm-Message-State: AOJu0YyKVHNfnD4hb+NfrSdrUfH+aBtBPhTVLVm2SZejTkqo8C9FdBRK
 aXRb+DdSugY/eB6H3zg0OzY4dDKVBVipk9V963l9x7/roDAFIbdw5rw210nw1Xybh0anHmk5dw/
 1
X-Google-Smtp-Source: AGHT+IHkubgegAC2UVq4FfWZ/h3Z323o4J3qMCbTaT1eyzTGhbLAxMz+d0ipNn7osGPSt06zxOaZRQ==
X-Received: by 2002:a05:6a00:1144:b0:724:6c79:2787 with SMTP id
 d2e1a72fcca58-7246c79283amr23021206b3a.8.1731892619073; 
 Sun, 17 Nov 2024 17:16:59 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724771e8b75sm5134024b3a.147.2024.11.17.17.16.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Nov 2024 17:16:58 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Sun, 17 Nov 2024 17:15:54 -0800
Subject: [PATCH v3 06/11] target/riscv: Add counter delegation definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241117-counter_delegation-v3-6-476d6f36e3c8@rivosinc.com>
References: <20241117-counter_delegation-v3-0-476d6f36e3c8@rivosinc.com>
In-Reply-To: <20241117-counter_delegation-v3-0-476d6f36e3c8@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: kaiwenxue1@gmail.com, Atish Patra <atishp@rivosinc.com>, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 Kaiwen Xue <kaiwenx@rivosinc.com>
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=atishp@rivosinc.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Kaiwen Xue <kaiwenx@rivosinc.com>

This adds definitions for counter delegation, including the new
scountinhibit register and the mstateen.CD bit.

Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/cpu.h      | 1 +
 target/riscv/cpu_bits.h | 8 +++++++-
 target/riscv/machine.c  | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 284b11282197..903268626374 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -385,6 +385,7 @@ struct CPUArchState {
     uint32_t scounteren;
     uint32_t mcounteren;
 
+    uint32_t scountinhibit;
     uint32_t mcountinhibit;
 
     /* PMU cycle & instret privilege mode filtering */
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index e13c5420a251..4ac065ac5e5a 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -210,6 +210,9 @@
 #define CSR_SSTATEEN2       0x10E
 #define CSR_SSTATEEN3       0x10F
 
+/* Supervisor Counter Delegation */
+#define CSR_SCOUNTINHIBIT   0x120
+
 /* Supervisor Trap Handling */
 #define CSR_SSCRATCH        0x140
 #define CSR_SEPC            0x141
@@ -791,6 +794,7 @@ typedef enum RISCVException {
 #define MENVCFG_CBIE                       (3UL << 4)
 #define MENVCFG_CBCFE                      BIT(6)
 #define MENVCFG_CBZE                       BIT(7)
+#define MENVCFG_CDE                        (1ULL << 60)
 #define MENVCFG_ADUE                       (1ULL << 61)
 #define MENVCFG_PBMTE                      (1ULL << 62)
 #define MENVCFG_STCE                       (1ULL << 63)
@@ -886,7 +890,9 @@ typedef enum RISCVException {
 #define ISELECT_IMSIC_LAST                 ISELECT_IMSIC_EIE63
 #define ISELECT_MASK_AIA                   0x1ff
 
-/* MISELECT, SISELECT, and VSISELECT bits (AIA) */
+/* [M|S|VS]SELCT value for Indirect CSR Access Extension */
+#define ISELECT_CD_FIRST                   0x40
+#define ISELECT_CD_LAST                    0x5f
 #define ISELECT_MASK_SXCSRIND              0xfff
 
 /* Dummy [M|S|VS]ISELECT value for emulating [M|S|VS]TOPEI CSRs */
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 99f0af507717..e1bdc31c7c53 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -434,6 +434,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINTTL(env.siselect, RISCVCPU),
         VMSTATE_UINT32(env.scounteren, RISCVCPU),
         VMSTATE_UINT32(env.mcounteren, RISCVCPU),
+        VMSTATE_UINT32(env.scountinhibit, RISCVCPU),
         VMSTATE_UINT32(env.mcountinhibit, RISCVCPU),
         VMSTATE_STRUCT_ARRAY(env.pmu_ctrs, RISCVCPU, RV_MAX_MHPMCOUNTERS, 0,
                              vmstate_pmu_ctr_state, PMUCTRState),

-- 
2.34.1


