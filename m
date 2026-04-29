Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8DEFF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwte-0008HE-Tk; Wed, 29 Apr 2026 00:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwtX-0007pF-SJ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:51:35 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwtV-0000zY-Mp
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:51:31 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2ad9f316d68so53647335ad.2
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438287; x=1778043087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YPyTNiL1ojeRuEHyY4Guho9lr/cm4Zx8gYkYg9AMqhc=;
 b=nWpBmHzEXyxAWOV8EgwOAx2LLyc7qmAQjoKM2r6AKxyN9In9udZ0zdO7tqOkzr1ric
 oKcDGt+4UE1ECQ4wcgNLf4GeW9DqEEPoJEd/tAIZqUyoRIWTABYpOBFmATtHGRQi1F7Q
 N1JQ89AU0IfJdP0SdWkh+7bsYDKQ2GbWMydifg74nWnmOsOn8RKwBFLgMb6d2Hxp5AWn
 2DNlguFZcB9BsQgPVs1xu01P1BBu3I0L4o2HGeLiGaj41/IA+tFehmvRvV46txuu73+5
 m7UI+WO9X8MdS50mHzCmx3TU0Ae5+0T6VPFvlee18OfMaSQYYwLF9ilqBT7c185goLv2
 fXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438287; x=1778043087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YPyTNiL1ojeRuEHyY4Guho9lr/cm4Zx8gYkYg9AMqhc=;
 b=MP8CK+25rhgh/WXfEjr81Ef9f3LdbERGZvhpCqUwEpABVut/jXI3nSEXi8GHa8rd0t
 scZfFp9AfzIrIjgAehl0sQgatM6nZN921iD7UFLK/KPf7u5syzq96COqsZa/t/0aE/2j
 aM3EU90EfibKU3l7L+BTYUR8xmkO3YtHA0YbTDqHOEAF1ZDvPyl5lD7ZyxnvfJKzEda3
 +n3/AmHubmI9QLGvvj89+BXfFO+dswrnNu09c2P1BUxevHUI9/Dq5LPJt83dpc/GzC3N
 5o+jj/bpC9m0/7S4DqaxtidQ14lNMNb8mFrtQIJyQv48mRHQbrGVf5wXv/E/L3fRVYmJ
 kx6Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/nD493LjCiS9KI2V9iyH9kRPmFflr+14coAE2aSRpj0gUeRT85D7i0TS4GAfo7Got9tNC0fNJej+Qv@nongnu.org
X-Gm-Message-State: AOJu0YwrnpPZZMpr6vwbzROq2yajVDNQTmWMuPp4cPzU2ZUrmNwx42pH
 uAk8t+waUk06brbPfPwwzRznU5rJOe5xoJJ26t3NmpJvTCaBE3CKXv9/
X-Gm-Gg: AeBDiesQcr9cvc875aLtCyLeAxP2Z0l29T2J1NNzo8DisaKZL9gDqfIwzdZSO3RYQml
 y1210U5Qed5TC8l2Vec9uAtV4Y9nNDtLwe4GV2Ep8DAMOxI+nWYfoII3OoJy+DyPZIDVxs4vQJm
 SHgLoTdsAUYd9v3WLMtNK+AcbANifsVMgvSVOlgT/cfVzyvkWcJX+Yy2qJwXRbjJIAv1gua8vE+
 2nzYSgyq8Jon8fe+R5hFNayovNsTkcnrEUwQPy47rkmRkbSPmwPZmEVxisgd6UInA64ZjlugIPH
 UytC8uW+IrqEVw0PakibWl07d6aCS0ipoErrMuVQbsgcbUId7hdh9FHXPGSo+JP2093AGkh6i6T
 w6RE8yqRR/meZ46Kq4MfMYsKOxjJau5cBOtWedxlBGXLHusovTPgGTDSGyjfkrJCqLqbTaB0KtS
 KJPnLAeC7MLr23M7BBSEosRaXu90vpk6MCfuEApjRGMoBtoHUXNJOZ
X-Received: by 2002:a17:903:1a2b:b0:2b0:9101:1b77 with SMTP id
 d9443c01a7336-2b987391b1bmr23101075ad.17.1777438286621; 
 Tue, 28 Apr 2026 21:51:26 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:51:26 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Bruno Sa <bruno.vilaca.sa@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 39/51] target/riscv: fix RV32 stateen CSR handling
Date: Wed, 29 Apr 2026 14:47:40 +1000
Message-ID: <20260429044752.4176397-40-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Bruno Sa <bruno.vilaca.sa@gmail.com>

The RV32 stateen CSRs are split between the low-half CSR and the
corresponding xH CSR, but the current implementation still handles some
upper-half bits through the low-half write paths and also accepts the
xH CSRs on RV64.

Fix this by:
- rejecting mstateen*h and hstateen*h accesses on RV64
- keeping the RV64-only writable bits in the low-half write paths
- handling the RV32 upper-half writable bits in write_mstateen0h() and
  write_hstateen0h()
- dropping unsupported writable bits from write_sstateen0()

Signed-off-by: Bruno Sa <bruno.vilaca.sa@gmail.com>
Message-ID: <20260410110928.1014170-1-bruno.vilaca.sa@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 117 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 83 insertions(+), 34 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index cfd076b368..80727aa81e 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -502,6 +502,15 @@ static RISCVException mstateen(CPURISCVState *env, int csrno)
     return any(env, csrno);
 }
 
+static RISCVException mstateen_32(CPURISCVState *env, int csrno)
+{
+    if (riscv_cpu_mxl(env) != MXL_RV32) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return mstateen(env, csrno);
+}
+
 static RISCVException hstateen_pred(CPURISCVState *env, int csrno, int base)
 {
     if (!riscv_cpu_cfg(env)->ext_smstateen) {
@@ -533,6 +542,10 @@ static RISCVException hstateen(CPURISCVState *env, int csrno)
 
 static RISCVException hstateenh(CPURISCVState *env, int csrno)
 {
+    if (riscv_cpu_mxl(env) != MXL_RV32) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
     return hstateen_pred(env, csrno, CSR_HSTATEEN0H);
 }
 
@@ -3447,25 +3460,29 @@ static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
         wr_mask |= SMSTATEEN0_FCSR;
     }
 
-    if (env->priv_ver >= PRIV_VERSION_1_13_0) {
-        wr_mask |= SMSTATEEN0_P1P13;
-    }
+    if (riscv_cpu_mxl(env) == MXL_RV64) {
+        if (env->priv_ver >= PRIV_VERSION_1_13_0) {
+            wr_mask |= SMSTATEEN0_P1P13;
+        }
 
-    if (riscv_cpu_cfg(env)->ext_smaia || riscv_cpu_cfg(env)->ext_smcsrind) {
-        wr_mask |= SMSTATEEN0_SVSLCT;
-    }
+        if (riscv_cpu_cfg(env)->ext_smaia ||
+            riscv_cpu_cfg(env)->ext_smcsrind) {
+            wr_mask |= SMSTATEEN0_SVSLCT;
+        }
 
-    /*
-     * As per the AIA specification, SMSTATEEN0_IMSIC is valid only if IMSIC is
-     * implemented. However, that information is with MachineState and we can't
-     * figure that out in csr.c. Just enable if Smaia is available.
-     */
-    if (riscv_cpu_cfg(env)->ext_smaia) {
-        wr_mask |= (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
-    }
+        /*
+         * As per the AIA specification, SMSTATEEN0_IMSIC is valid
+         * only if IMSIC is implemented. However, that information is
+         * with MachineState and we can't figure that out in csr.c.
+         * Just enable if Smaia is available.
+         */
+        if (riscv_cpu_cfg(env)->ext_smaia) {
+            wr_mask |= (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
+        }
 
-    if (riscv_cpu_cfg(env)->ext_ssctr) {
-        wr_mask |= SMSTATEEN0_CTR;
+        if (riscv_cpu_cfg(env)->ext_ssctr) {
+            wr_mask |= SMSTATEEN0_CTR;
+        }
     }
 
     return write_mstateen(env, csrno, wr_mask, new_val);
@@ -3507,6 +3524,20 @@ static RISCVException write_mstateen0h(CPURISCVState *env, int csrno,
         wr_mask |= SMSTATEEN0_P1P13;
     }
 
+    if (riscv_cpu_cfg(env)->ext_smaia || riscv_cpu_cfg(env)->ext_smcsrind) {
+        wr_mask |= SMSTATEEN0_SVSLCT;
+    }
+
+    /*
+     * As per the AIA specification, SMSTATEEN0_IMSIC is valid only if
+     * IMSIC is implemented. However, that information is with
+     * MachineState and we can't figure that out in csr.c. Just enable
+     * if Smaia is available.
+     */
+    if (riscv_cpu_cfg(env)->ext_smaia) {
+        wr_mask |= (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
+    }
+
     if (riscv_cpu_cfg(env)->ext_ssctr) {
         wr_mask |= SMSTATEEN0_CTR;
     }
@@ -3552,21 +3583,25 @@ static RISCVException write_hstateen0(CPURISCVState *env, int csrno,
         wr_mask |= SMSTATEEN0_FCSR;
     }
 
-    if (riscv_cpu_cfg(env)->ext_ssaia || riscv_cpu_cfg(env)->ext_sscsrind) {
-        wr_mask |= SMSTATEEN0_SVSLCT;
-    }
+    if (riscv_cpu_mxl(env) == MXL_RV64) {
+        if (riscv_cpu_cfg(env)->ext_ssaia ||
+            riscv_cpu_cfg(env)->ext_sscsrind) {
+            wr_mask |= SMSTATEEN0_SVSLCT;
+        }
 
-    /*
-     * As per the AIA specification, SMSTATEEN0_IMSIC is valid only if IMSIC is
-     * implemented. However, that information is with MachineState and we can't
-     * figure that out in csr.c. Just enable if Ssaia is available.
-     */
-    if (riscv_cpu_cfg(env)->ext_ssaia) {
-        wr_mask |= (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
-    }
+        /*
+         * As per the AIA specification, SMSTATEEN0_IMSIC is valid
+         * only if IMSIC is implemented. However, that information is
+         * with MachineState and we can't figure that out in csr.c.
+         * Just enable if Ssaia is available.
+         */
+        if (riscv_cpu_cfg(env)->ext_ssaia) {
+            wr_mask |= (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
+        }
 
-    if (riscv_cpu_cfg(env)->ext_ssctr) {
-        wr_mask |= SMSTATEEN0_CTR;
+        if (riscv_cpu_cfg(env)->ext_ssctr) {
+            wr_mask |= SMSTATEEN0_CTR;
+        }
     }
 
     return write_hstateen(env, csrno, wr_mask, new_val);
@@ -3608,6 +3643,20 @@ static RISCVException write_hstateen0h(CPURISCVState *env, int csrno,
 {
     uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
 
+    if (riscv_cpu_cfg(env)->ext_ssaia || riscv_cpu_cfg(env)->ext_sscsrind) {
+        wr_mask |= SMSTATEEN0_SVSLCT;
+    }
+
+    /*
+     * As per the AIA specification, SMSTATEEN0_IMSIC is valid only if
+     * IMSIC is implemented. However, that information is with
+     * MachineState and we can't figure that out in csr.c. Just enable
+     * if Ssaia is available.
+     */
+    if (riscv_cpu_cfg(env)->ext_ssaia) {
+        wr_mask |= (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
+    }
+
     if (riscv_cpu_cfg(env)->ext_ssctr) {
         wr_mask |= SMSTATEEN0_CTR;
     }
@@ -3657,7 +3706,7 @@ static RISCVException write_sstateen(CPURISCVState *env, int csrno,
 static RISCVException write_sstateen0(CPURISCVState *env, int csrno,
                                       target_ulong new_val, uintptr_t ra)
 {
-    uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
+    uint64_t wr_mask = 0;
 
     if (!riscv_has_ext(env, RVF)) {
         wr_mask |= SMSTATEEN0_FCSR;
@@ -5937,25 +5986,25 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     /* Smstateen extension CSRs */
     [CSR_MSTATEEN0] = { "mstateen0", mstateen, read_mstateen, write_mstateen0,
                         .min_priv_ver = PRIV_VERSION_1_12_0 },
-    [CSR_MSTATEEN0H] = { "mstateen0h", mstateen, read_mstateenh,
+    [CSR_MSTATEEN0H] = { "mstateen0h", mstateen_32, read_mstateenh,
                           write_mstateen0h,
                          .min_priv_ver = PRIV_VERSION_1_12_0 },
     [CSR_MSTATEEN1] = { "mstateen1", mstateen, read_mstateen,
                         write_mstateen_1_3,
                         .min_priv_ver = PRIV_VERSION_1_12_0 },
-    [CSR_MSTATEEN1H] = { "mstateen1h", mstateen, read_mstateenh,
+    [CSR_MSTATEEN1H] = { "mstateen1h", mstateen_32, read_mstateenh,
                          write_mstateenh_1_3,
                          .min_priv_ver = PRIV_VERSION_1_12_0 },
     [CSR_MSTATEEN2] = { "mstateen2", mstateen, read_mstateen,
                         write_mstateen_1_3,
                         .min_priv_ver = PRIV_VERSION_1_12_0 },
-    [CSR_MSTATEEN2H] = { "mstateen2h", mstateen, read_mstateenh,
+    [CSR_MSTATEEN2H] = { "mstateen2h", mstateen_32, read_mstateenh,
                          write_mstateenh_1_3,
                          .min_priv_ver = PRIV_VERSION_1_12_0 },
     [CSR_MSTATEEN3] = { "mstateen3", mstateen, read_mstateen,
                         write_mstateen_1_3,
                         .min_priv_ver = PRIV_VERSION_1_12_0 },
-    [CSR_MSTATEEN3H] = { "mstateen3h", mstateen, read_mstateenh,
+    [CSR_MSTATEEN3H] = { "mstateen3h", mstateen_32, read_mstateenh,
                          write_mstateenh_1_3,
                          .min_priv_ver = PRIV_VERSION_1_12_0 },
     [CSR_HSTATEEN0] = { "hstateen0", hstateen, read_hstateen, write_hstateen0,
-- 
2.53.0


