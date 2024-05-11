Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C539C04FFE
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 10:12:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5jhF-0005Sy-DB; Sat, 11 May 2024 06:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1s5jhC-0005RX-RS; Sat, 11 May 2024 06:11:14 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1s5jh6-00029n-5u; Sat, 11 May 2024 06:11:14 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a59a352bbd9so471002066b.1; 
 Sat, 11 May 2024 03:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715422266; x=1716027066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A1Ntzu9BEFtLKcUtz+NFIzasN3U9L0YdUu0S1V4wh0A=;
 b=i+tex6Srd8Uiwgeb149WNBUZnc2MvweWUJUmIgZ2OYdVMdHSkgfNtgX/ZKiYqs0gGt
 JwIxIZL1hzey5VtPx0HIpO1a8oM9QXT0FcazA6RU0M/z+JRDbXPjjYypIIkfDeZArj5z
 K8Jr4TdTPhjwz9H0p4WrpTm4BDrXrxKegVAq/5QVA0pdA5LVDx8zngPNqVOlhddyMy1r
 ff185k1oWpNsDVjD5Exuk/u7iWkBR7aqSpICO6pEfxALSHrwZRabvVYYe2sLsBqKz0vu
 6MNPm4YBhxdKBbcsXPrNpfhmrHxbnwenLNinoMtIfrRBIMw93/hyN+BpwrDxnT2lBIzp
 Oo8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715422266; x=1716027066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A1Ntzu9BEFtLKcUtz+NFIzasN3U9L0YdUu0S1V4wh0A=;
 b=Z+a6eJji8H5vtShBGIpbFTZ73+russF50VcWbSHmEaOB/365c3Yk1ebvOYYaXtrih/
 07gCkmc+tOT/MdggSJtQ93xQM5P1MGElTbryBzUtbos7pbyvZAkjPHHHafuR2C3yDNGe
 TjzXr6Bst4XKk3kuf6LpkTslt/vDREdDm5UQA6UMDuyzJw0GJyHcaJOO35cLKdyOEqfB
 CeCcdWci7kFuLC9s6jWD9RxwJPM1D/hBL2Z7IE+9IfLZnha0h2D8HKWJ6liYzqIzqauk
 AEX2w1QjWpXBex0DmfGNEvMEhEb2XJ4M+BVfugWoe9SO1NOfVQkqKdP/Y7OTzbDKb8zJ
 DsSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh1F7iOb/LP0XmX8zqTAsr++IunYSLW4lrl05E+CNWrHdQ7WooaaZxMzv6v+PCGmTiO3wk1AbaJYHjvkixzMvHOM3y9joMoBHfMQ00g5EoA8jlmmqtDiYxZrR5tQ==
X-Gm-Message-State: AOJu0YwSoOjcotnBLMcGUIZjLGsXQzs8ZkBJt9m+e31/r1Ks+w+uhvah
 iTDKMQDxBuVgUainHZYoxsBF37FozvM1e5qA45zEShBUcwugwunU
X-Google-Smtp-Source: AGHT+IGIONM+/KBADhWaOhM3t3cipfY70vjEIXSkS9qGUSjof9wS30MuHSDJfWgO3DtVd1NWR0k+VA==
X-Received: by 2002:a17:907:2d09:b0:a55:5520:f43f with SMTP id
 a640c23a62f3a-a5a115ef93dmr823636266b.10.1715422266388; 
 Sat, 11 May 2024 03:11:06 -0700 (PDT)
Received: from freya.midgard (broadband-188-255-126-251.ip.moscow.rt.ru.
 [188.255.126.251]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781d27bsm301687166b.21.2024.05.11.03.11.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 May 2024 03:11:05 -0700 (PDT)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <me@deliversmonkey.space>
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 space.monkey.delivers@gmail.com, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v9 2/6] target/riscv: Add new CSR fields for S{sn, mn,
 m}pm extensions as part of Zjpm v0.8
Date: Sat, 11 May 2024 13:10:49 +0300
Message-Id: <20240511101053.1875596-3-me@deliversmonkey.space>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240511101053.1875596-1-me@deliversmonkey.space>
References: <20240511101053.1875596-1-me@deliversmonkey.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ej1-x636.google.com
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
index 232521bb87..52b6ba73c8 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -121,6 +121,14 @@ typedef enum {
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
index da16ba236a..13ce2218d1 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -708,6 +708,7 @@ typedef enum RISCVException {
 #define MENVCFG_CBIE                       (3UL << 4)
 #define MENVCFG_CBCFE                      BIT(6)
 #define MENVCFG_CBZE                       BIT(7)
+#define MENVCFG_PMM                        (3ULL << 32)
 #define MENVCFG_ADUE                       (1ULL << 61)
 #define MENVCFG_PBMTE                      (1ULL << 62)
 #define MENVCFG_STCE                       (1ULL << 63)
@@ -721,11 +722,13 @@ typedef enum RISCVException {
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
index e1e4f32698..9ecdc792c5 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -120,6 +120,9 @@ struct RISCVCPUConfig {
     bool ext_ssaia;
     bool ext_sscofpmf;
     bool ext_smepmp;
+    bool ext_ssnpm;
+    bool ext_smnpm;
+    bool ext_smmpm;
     bool rvv_ta_all_1s;
     bool rvv_ma_all_1s;
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 4b2c932564..45b548eb0b 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -530,6 +530,9 @@ static RISCVException have_mseccfg(CPURISCVState *env, int csrno)
     if (riscv_cpu_cfg(env)->ext_zkr) {
         return RISCV_EXCP_NONE;
     }
+    if (riscv_cpu_cfg(env)->ext_smmpm) {
+        return RISCV_EXCP_NONE;
+    }
 
     return RISCV_EXCP_ILLEGAL_INST;
 }
@@ -2083,6 +2086,10 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
                 (cfg->ext_sstc ? MENVCFG_STCE : 0) |
                 (cfg->ext_svadu ? MENVCFG_ADUE : 0);
     }
+    /* Update PMM field only if the value is valid according to Zjpm v0.8 */
+    if (((val & MENVCFG_PMM) >> 32) != PMM_FIELD_RESERVED) {
+        mask |= MENVCFG_PMM;
+    }
     env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
 
     return RISCV_EXCP_NONE;
@@ -2127,6 +2134,10 @@ static RISCVException write_senvcfg(CPURISCVState *env, int csrno,
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
index 64ab66e332..bbbb28f373 100644
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
     .fields = (const VMStateField[]) {
+        VMSTATE_UINTTL(env.mseccfg, RISCVCPU),
+        VMSTATE_UINTTL(env.senvcfg, RISCVCPU),
+        VMSTATE_UINTTL(env.menvcfg, RISCVCPU),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 2a76b611a0..7ddb9dbf0b 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -574,6 +574,12 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
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
 
@@ -589,12 +595,13 @@ void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
 
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
index f5c10ce85c..ccff0eb9b6 100644
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


