Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53217C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 19:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUXDI-0005jn-Tc; Mon, 29 Jan 2024 14:22:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rUXDF-0005iq-TZ; Mon, 29 Jan 2024 14:22:33 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rUXDD-0002dy-Sz; Mon, 29 Jan 2024 14:22:33 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33aeb088324so1112114f8f.2; 
 Mon, 29 Jan 2024 11:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706556149; x=1707160949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SwkzHyfB0UVsQH2g3dzgYzozoZkKb07+YjTkSdFXFP0=;
 b=MU0lTx+9172Ij4sZBc531fbpzg+LletILkxgIjXm0LfyQf5gZFvkgLoubv2NsV/O10
 P9XaKCRmWHa2mzGei0QuU1iurt/2qC8GUsjXDRoH94ANakS7Zm69VBGV+T9A36QRYj+n
 cy7AIzSVhP+it1ts7MGgl3Hps+DftX3GUesW2la09NQhK3l1SPKCXQhqbKgh3Vy89lB3
 zhug6FZ076edMQFdOCKu6LT5jk6jM/wjoGtW0h5U8S/X60N/Cx8QbgvmMwxy/nauoEm2
 O149kx5IqrDXn7SbKi13rvBiTw67F5gWxaTGyeMEr7JE34Nd63W6yVq/wUBcC1evsOmb
 Vb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706556149; x=1707160949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SwkzHyfB0UVsQH2g3dzgYzozoZkKb07+YjTkSdFXFP0=;
 b=JVHFGynXGzx0YuSuxw28ynMVZtuh17YwTSvAPae21eRFqntX/r/rm6Cqf+0FhuNfXg
 LygPsOMPZqHJRiPJuW6KE+YU97ycfD0CUfsXX+fCp5qaR4Zhtq5DtG06QuZ+vEtlmrkB
 B8Pn18Mz5tciK4FqZlb0s0stQJ+B4UH4TP5NA1OqlVNrI30Exe/zUVKk4QvVuRju6CrL
 y+eN6x4auZL5Cq5uvtlHM5LXGmKwHFjzPH85VtSHREpqZWpqgotA0g0GTF3wIFHHrfOy
 OxUKxA16GaA9RW9sn8MuYIZvBAS/uTQ//p08SraW83QAskssn9y5lN4rUamDDPVjpgk6
 kucg==
X-Gm-Message-State: AOJu0Yz0GUApX+cGWCNavIaAMh/DPXuhTa/Es5W9f6CvBsuliSGNxuTF
 xhvep6cAdEm0IF/2WGnIyxfRbawQtoT2dQO/lz6mVl/hFP4Zz0lcIdlR9HVOYEmiyQ==
X-Google-Smtp-Source: AGHT+IEN3HKHnAuNB77scdV3cY0muPdliytocQuZq5z4OGnZp/JSdPytMM4dHwLO/eVbGYx9BpvYfQ==
X-Received: by 2002:a05:6000:1561:b0:33a:edcd:6f38 with SMTP id
 1-20020a056000156100b0033aedcd6f38mr3038513wrz.34.1706556149566; 
 Mon, 29 Jan 2024 11:22:29 -0800 (PST)
Received: from freya.midgard (broadband-188-255-126-251.ip.moscow.rt.ru.
 [188.255.126.251]) by smtp.gmail.com with ESMTPSA id
 co28-20020a0560000a1c00b0033af0cb2a35sm2577206wrb.108.2024.01.29.11.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 11:22:28 -0800 (PST)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <me@deliversmonkey.space>
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 2/6] target/riscv: Add new CSR fields for S{sn, mn,
 m}pm extensions as part of Zjpm v0.8
Date: Mon, 29 Jan 2024 19:22:03 +0000
Message-Id: <20240129192207.2946870-3-me@deliversmonkey.space>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129192207.2946870-1-me@deliversmonkey.space>
References: <20240129192207.2946870-1-me@deliversmonkey.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=baturo.alexey@gmail.com; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h      |  8 ++++++++
 target/riscv/cpu_bits.h |  3 +++
 target/riscv/cpu_cfg.h  |  3 +++
 target/riscv/csr.c      | 11 +++++++++++
 target/riscv/machine.c  | 10 +++++++---
 target/riscv/pmp.c      | 13 ++++++++++---
 target/riscv/pmp.h      | 11 ++++++-----
 7 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a43c8fba57..c9bed5c9fc 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -101,6 +101,14 @@ typedef enum {
     EXT_STATUS_DIRTY,
 } RISCVExtStatus;
 
+/* Enum holds PMM field values for Zjpm v0.8 extension */
+typedef enum {
+    PMM_FIELD_DISABLED = 0,
+    PMM_FIELD_RESERVED = 1,
+    PMM_FIELD_PMLEN7   = 2,
+    PMM_FIELD_PMLEN16  = 3,
+} RISCVPmPmm;
+
 #define MMU_USER_IDX 3
 
 #define MAX_RISCV_PMPS (16)
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 1c92458a01..7cf1049bf4 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -715,6 +715,7 @@ typedef enum RISCVException {
 #define MENVCFG_CBIE                       (3UL << 4)
 #define MENVCFG_CBCFE                      BIT(6)
 #define MENVCFG_CBZE                       BIT(7)
+#define MENVCFG_PMM                        (3ULL << 32)
 #define MENVCFG_ADUE                       (1ULL << 61)
 #define MENVCFG_PBMTE                      (1ULL << 62)
 #define MENVCFG_STCE                       (1ULL << 63)
@@ -728,11 +729,13 @@ typedef enum RISCVException {
 #define SENVCFG_CBIE                       MENVCFG_CBIE
 #define SENVCFG_CBCFE                      MENVCFG_CBCFE
 #define SENVCFG_CBZE                       MENVCFG_CBZE
+#define SENVCFG_PMM                        MENVCFG_PMM
 
 #define HENVCFG_FIOM                       MENVCFG_FIOM
 #define HENVCFG_CBIE                       MENVCFG_CBIE
 #define HENVCFG_CBCFE                      MENVCFG_CBCFE
 #define HENVCFG_CBZE                       MENVCFG_CBZE
+#define HENVCFG_PMM                        MENVCFG_PMM
 #define HENVCFG_ADUE                       MENVCFG_ADUE
 #define HENVCFG_PBMTE                      MENVCFG_PBMTE
 #define HENVCFG_STCE                       MENVCFG_STCE
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index f4605fb190..201f8af6ae 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -113,6 +113,9 @@ struct RISCVCPUConfig {
     bool ext_ssaia;
     bool ext_sscofpmf;
     bool ext_smepmp;
+    bool ext_ssnpm;
+    bool ext_smnpm;
+    bool ext_smmpm;
     bool rvv_ta_all_1s;
     bool rvv_ma_all_1s;
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ea4e1ac6ef..a67ba30494 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -527,6 +527,9 @@ static RISCVException have_mseccfg(CPURISCVState *env, int csrno)
     if (riscv_cpu_cfg(env)->ext_zkr) {
         return RISCV_EXCP_NONE;
     }
+    if (riscv_cpu_cfg(env)->ext_smmpm) {
+        return RISCV_EXCP_NONE;
+    }
 
     return RISCV_EXCP_ILLEGAL_INST;
 }
@@ -2030,6 +2033,10 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
                 (cfg->ext_sstc ? MENVCFG_STCE : 0) |
                 (cfg->ext_svadu ? MENVCFG_ADUE : 0);
     }
+    /* Update PMM field only if the value is valid according to Zjpm v0.8 */
+    if (((val & MENVCFG_PMM) >> 32) != PMM_FIELD_RESERVED) {
+        mask |= MENVCFG_PMM;
+    }
     env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
 
     return RISCV_EXCP_NONE;
@@ -2074,6 +2081,10 @@ static RISCVException write_senvcfg(CPURISCVState *env, int csrno,
                                     target_ulong val)
 {
     uint64_t mask = SENVCFG_FIOM | SENVCFG_CBIE | SENVCFG_CBCFE | SENVCFG_CBZE;
+    /* Update PMM field only if the value is valid according to Zjpm v0.8 */
+    if (((val & SENVCFG_PMM) >> 32) != PMM_FIELD_RESERVED) {
+        mask |= SENVCFG_PMM;
+    }
     RISCVException ret;
 
     ret = smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 71ee8bab19..0ad593ed5a 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -152,15 +152,19 @@ static const VMStateDescription vmstate_vector = {
 
 static bool pointermasking_needed(void *opaque)
 {
-    return false;
+    RISCVCPU *cpu = opaque;
+    return cpu->cfg.ext_ssnpm || cpu->cfg.ext_smnpm || cpu->cfg.ext_smmpm;
 }
 
 static const VMStateDescription vmstate_pointermasking = {
     .name = "cpu/pointer_masking",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .needed = pointermasking_needed,
     .fields = (VMStateField[]) {
+        VMSTATE_UINTTL(env.mseccfg, RISCVCPU),
+        VMSTATE_UINTTL(env.senvcfg, RISCVCPU),
+        VMSTATE_UINTTL(env.menvcfg, RISCVCPU),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 162e88a90a..893ccd58d8 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -576,6 +576,12 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
 void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
 {
     int i;
+    uint64_t mask = MSECCFG_MMWP | MSECCFG_MML;
+
+    /* Update PMM field only if the value is valid according to Zjpm v0.8 */
+    if (((val & MSECCFG_PMM) >> 32) != PMM_FIELD_RESERVED) {
+        mask |= MSECCFG_PMM;
+    }
 
     trace_mseccfg_csr_write(env->mhartid, val);
 
@@ -591,12 +597,13 @@ void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
 
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
 
     env->mseccfg = val;
diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
index 9af8614cd4..b3ca51c26d 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -40,11 +40,12 @@ typedef enum {
 } pmp_am_t;
 
 typedef enum {
-    MSECCFG_MML   = 1 << 0,
-    MSECCFG_MMWP  = 1 << 1,
-    MSECCFG_RLB   = 1 << 2,
-    MSECCFG_USEED = 1 << 8,
-    MSECCFG_SSEED = 1 << 9
+    MSECCFG_MML       = 1 << 0,
+    MSECCFG_MMWP      = 1 << 1,
+    MSECCFG_RLB       = 1 << 2,
+    MSECCFG_USEED     = 1 << 8,
+    MSECCFG_SSEED     = 1 << 9,
+    MSECCFG_PMM       = 3UL << 32,
 } mseccfg_field_t;
 
 typedef struct {
-- 
2.34.1


