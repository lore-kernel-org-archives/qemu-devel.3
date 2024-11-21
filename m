Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC3FD75BBE
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 06:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE0RD-0004Tw-SQ; Thu, 21 Nov 2024 01:13:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tE0RC-0004TM-5G; Thu, 21 Nov 2024 01:13:10 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tE0RA-0006J8-43; Thu, 21 Nov 2024 01:13:09 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-53d9ff8ef3aso502600e87.1; 
 Wed, 20 Nov 2024 22:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732169586; x=1732774386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vrCdLZ8Ddyr2Q8mjwb19Axqv6cumMVuY8X4Ma76BPPk=;
 b=g6sLpoliEa0C14eusIU9tzqBuobQX3zrS3bRSLSiqri1fhEJ4AiqSnVUhh6mc3ZzX+
 Y9q3l4FIXlxGJc7qxoYtKetTbZlxR2Pw0mwY/menNPXPA2Ooqun+FtFKTPBZwmto9hiL
 86I2NBhsLEMY08CvJ3jLQiFa8I3x2P6k8/hl74wQUiK/vWbF9FGMkOxoY2eSh0zFRASj
 H79b8OKL9/k/YfPgDW1hpn6rRZiu+GOuZXWJF9a4Hv7CmVKp6k/zw8Yli0RiSpruDPkA
 XstvH+glaCVXvPEpzSS+fbebFS+eUuKsxUHwmR95f12pdNdVkzx1+ISA+34HZUCKFsID
 o2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732169586; x=1732774386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vrCdLZ8Ddyr2Q8mjwb19Axqv6cumMVuY8X4Ma76BPPk=;
 b=c1iEUguwddM6eTQucOlkoWEsKKQ1IOIUqOB7RpkAOys81NgpgwyEkILXqF3gMo95ph
 ObGgY1+l+7YeQoTcDAfuFmhZso2MRs+xr0nuZIyq+BdYQ3GLrhiP0T9mLTKlEednub8U
 f01DLRhNyQ19HHSrsJQWeaNBUl1lfrGZb1dlR8sQhZfe+S8Tmws0aV0f2oB9dGcRRIME
 xtCXrnYc3rQyN2c2qrpLK+Gd6knAAmMhRqr07oSFWUFN/5r4a4J4LyWps0cDQS8f8MIz
 EPpQYgXpBz8aOcB+OE6qlhf8yDHb4viArBIjFu1M137VRxcBN0QzblEqH/+ZEzVaMDGH
 Pvew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUi0u8nHqDmNu9TDI/SrlLXGeXdrGHDtQh1rDvvMtjolZJoYTsDb1HQQlLSj/Y+Z3jMypHblxt38rOt@nongnu.org,
 AJvYcCVd7Y6FMQI0e49USOjbo6MYnPLL6PtgVdiAPeEIfjKJYx3dqsnYoEh1t5ngNqf/UngzpU+rAJeqpg9yiA==@nongnu.org
X-Gm-Message-State: AOJu0Yz4+MdEKLcqfjP7V+xn3XMwLhiE6MgS3vCyKlkBUybMKnWJpYd7
 mv99H30/D0LwPJguIAI9GDjb067icNpNbYWQC7S9rdoLE+2NpOn0
X-Gm-Gg: ASbGnctJYTCLdWTxC/6ZfYJ48mDlVZX1341mVgQzh3P7uCQ9DE4WE108i1tVCf9/L9n
 om6VUHNr0MBUMDP6jrzzxx+/Bafz2KIe4SmDn2to+C58le3DfMvRKncyKpUtKsNBEjZvrqQBOUX
 bnwa8SMWx1pCX9ouHV4Uz+fxfLxUnoahw6JjbzvA6wezdhiScTT8puTKzisOfalDicxNpKzQz5u
 uzp3qp3PZDJe7y7/t+yPpv1Kt5wPBEs7wW5PKWtVDB5jeuI4UF3wxA=
X-Google-Smtp-Source: AGHT+IEXYG+GE9fI8JrY+3tupfwK39mKOr7g8xUWqyRlF+q/O5Td9vX5cNwioEO9nZ9Q2H2Et1koSw==
X-Received: by 2002:a05:6512:3da6:b0:539:da76:c77e with SMTP id
 2adb3069b0e04-53dc1327509mr2456764e87.5.1732169585772; 
 Wed, 20 Nov 2024 22:13:05 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53dbd4726c3sm840443e87.205.2024.11.20.22.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 22:13:04 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 2/7] target/riscv: Add new CSR fields for S{sn, mn,
 m}pm extensions as part of Zjpm v1.0
Date: Thu, 21 Nov 2024 09:12:54 +0300
Message-Id: <20241121061259.4043177-3-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241121061259.4043177-1-baturo.alexey@gmail.com>
References: <20241121061259.4043177-1-baturo.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Alexey Baturo <baturo.alexey@gmail.com>

Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
---
 target/riscv/cpu.h      |  8 ++++++++
 target/riscv/cpu_bits.h |  4 ++++
 target/riscv/cpu_cfg.h  |  3 +++
 target/riscv/csr.c      | 31 ++++++++++++++++++++++++++++++-
 target/riscv/pmp.c      | 14 +++++++++++---
 target/riscv/pmp.h      |  1 +
 6 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index e11264231d..417ff45544 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -128,6 +128,14 @@ typedef enum {
     EXT_STATUS_DIRTY,
 } RISCVExtStatus;
 
+/* Enum holds PMM field values for Zjpm v1.0 extension */
+typedef enum {
+    PMM_FIELD_DISABLED = 0,
+    PMM_FIELD_RESERVED = 1,
+    PMM_FIELD_PMLEN7   = 2,
+    PMM_FIELD_PMLEN16  = 3,
+} RISCVPmPmm;
+
 typedef struct riscv_cpu_implied_exts_rule {
 #ifndef CONFIG_USER_ONLY
     /*
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 2a6aff63ed..d8f9bc68e3 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -574,6 +574,7 @@ typedef enum {
 #define HSTATUS_VTW          0x00200000
 #define HSTATUS_VTSR         0x00400000
 #define HSTATUS_VSXL         0x300000000
+#define HSTATUS_HUPMM        0x3000000000000
 
 #define HSTATUS32_WPRI       0xFF8FF87E
 #define HSTATUS64_WPRI       0xFFFFFFFFFF8FF87EULL
@@ -734,6 +735,7 @@ typedef enum RISCVException {
 #define MENVCFG_CBIE                       (3UL << 4)
 #define MENVCFG_CBCFE                      BIT(6)
 #define MENVCFG_CBZE                       BIT(7)
+#define MENVCFG_PMM                        (3ULL << 32)
 #define MENVCFG_ADUE                       (1ULL << 61)
 #define MENVCFG_PBMTE                      (1ULL << 62)
 #define MENVCFG_STCE                       (1ULL << 63)
@@ -749,6 +751,7 @@ typedef enum RISCVException {
 #define SENVCFG_CBIE                       MENVCFG_CBIE
 #define SENVCFG_CBCFE                      MENVCFG_CBCFE
 #define SENVCFG_CBZE                       MENVCFG_CBZE
+#define SENVCFG_PMM                        MENVCFG_PMM
 
 #define HENVCFG_FIOM                       MENVCFG_FIOM
 #define HENVCFG_LPE                        MENVCFG_LPE
@@ -756,6 +759,7 @@ typedef enum RISCVException {
 #define HENVCFG_CBIE                       MENVCFG_CBIE
 #define HENVCFG_CBCFE                      MENVCFG_CBCFE
 #define HENVCFG_CBZE                       MENVCFG_CBZE
+#define HENVCFG_PMM                        MENVCFG_PMM
 #define HENVCFG_ADUE                       MENVCFG_ADUE
 #define HENVCFG_PBMTE                      MENVCFG_PBMTE
 #define HENVCFG_STCE                       MENVCFG_STCE
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 59d6fc445d..79a114eb07 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -128,6 +128,9 @@ struct RISCVCPUConfig {
     bool ext_ssaia;
     bool ext_sscofpmf;
     bool ext_smepmp;
+    bool ext_ssnpm;
+    bool ext_smnpm;
+    bool ext_smmpm;
     bool rvv_ta_all_1s;
     bool rvv_ma_all_1s;
     bool rvv_vl_half_avl;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 941c9691da..5389ccb983 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -575,6 +575,9 @@ static RISCVException have_mseccfg(CPURISCVState *env, int csrno)
     if (riscv_cpu_cfg(env)->ext_zkr) {
         return RISCV_EXCP_NONE;
     }
+    if (riscv_cpu_cfg(env)->ext_smmpm) {
+        return RISCV_EXCP_NONE;
+    }
 
     return RISCV_EXCP_ILLEGAL_INST;
 }
@@ -2379,6 +2382,12 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
         if (env_archcpu(env)->cfg.ext_zicfiss) {
             mask |= MENVCFG_SSE;
         }
+
+        /* Update PMM field only if the value is valid according to Zjpm v1.0 */
+        if (env_archcpu(env)->cfg.ext_smnpm &&
+            get_field(val, MENVCFG_PMM) != PMM_FIELD_RESERVED) {
+            mask |= MENVCFG_PMM;
+        }
     }
     env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
 
@@ -2425,6 +2434,12 @@ static RISCVException write_senvcfg(CPURISCVState *env, int csrno,
 {
     uint64_t mask = SENVCFG_FIOM | SENVCFG_CBIE | SENVCFG_CBCFE | SENVCFG_CBZE;
     RISCVException ret;
+    /* Update PMM field only if the value is valid according to Zjpm v1.0 */
+    if (env_archcpu(env)->cfg.ext_ssnpm &&
+        riscv_cpu_mxl(env) == MXL_RV64 &&
+        get_field(val, SENVCFG_PMM) != PMM_FIELD_RESERVED) {
+        mask |= SENVCFG_PMM;
+    }
 
     ret = smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
     if (ret != RISCV_EXCP_NONE) {
@@ -2489,6 +2504,12 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
             get_field(env->menvcfg, MENVCFG_SSE)) {
             mask |= HENVCFG_SSE;
         }
+
+        /* Update PMM field only if the value is valid according to Zjpm v1.0 */
+        if (env_archcpu(env)->cfg.ext_ssnpm &&
+            get_field(val, HENVCFG_PMM) != PMM_FIELD_RESERVED) {
+            mask |= HENVCFG_PMM;
+        }
     }
 
     env->henvcfg = (env->henvcfg & ~mask) | (val & mask);
@@ -3525,7 +3546,15 @@ static RISCVException read_hstatus(CPURISCVState *env, int csrno,
 static RISCVException write_hstatus(CPURISCVState *env, int csrno,
                                     target_ulong val)
 {
-    env->hstatus = val;
+    uint64_t mask = (target_ulong)-1;
+    /* Update PMM field only if the value is valid according to Zjpm v1.0 */
+    if (!env_archcpu(env)->cfg.ext_ssnpm ||
+        riscv_cpu_mxl(env) != MXL_RV64 ||
+        get_field(val, HSTATUS_HUPMM) == PMM_FIELD_RESERVED) {
+        mask &= ~HSTATUS_HUPMM;
+    }
+    env->hstatus = (env->hstatus & ~mask) | (val & mask);
+
     if (riscv_cpu_mxl(env) != MXL_RV32 && get_field(val, HSTATUS_VSXL) != 2) {
         qemu_log_mask(LOG_UNIMP,
                       "QEMU does not support mixed HSXLEN options.");
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index a1b36664fc..a185c246d6 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -575,6 +575,13 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
 void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
 {
     int i;
+    uint64_t mask = MSECCFG_MMWP | MSECCFG_MML;
+    /* Update PMM field only if the value is valid according to Zjpm v1.0 */
+    if (riscv_cpu_cfg(env)->ext_smmpm &&
+        riscv_cpu_mxl(env) == MXL_RV64 &&
+        get_field(val, MSECCFG_PMM) != PMM_FIELD_RESERVED) {
+        mask |= MSECCFG_PMM;
+    }
 
     trace_mseccfg_csr_write(env->mhartid, val);
 
@@ -590,12 +597,13 @@ void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
 
     if (riscv_cpu_cfg(env)->ext_smepmp) {
         /* Sticky bits */
-        val |= (env->mseccfg & (MSECCFG_MMWP | MSECCFG_MML));
-        if ((val ^ env->mseccfg) & (MSECCFG_MMWP | MSECCFG_MML)) {
+        val |= (env->mseccfg & mask);
+        if ((val ^ env->mseccfg) & mask) {
             tlb_flush(env_cpu(env));
         }
     } else {
-        val &= ~(MSECCFG_MMWP | MSECCFG_MML | MSECCFG_RLB);
+        mask |= MSECCFG_RLB;
+        val &= ~(mask);
     }
 
     /* M-mode forward cfi to be enabled if cfi extension is implemented */
diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
index e0530a17a3..271cf24169 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -46,6 +46,7 @@ typedef enum {
     MSECCFG_USEED = 1 << 8,
     MSECCFG_SSEED = 1 << 9,
     MSECCFG_MLPE =  1 << 10,
+    MSECCFG_PMM = 3ULL << 32,
 } mseccfg_field_t;
 
 typedef struct {
-- 
2.39.5


