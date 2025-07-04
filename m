Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28A6C83F05
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeOm-0000KZ-UJ; Fri, 04 Jul 2025 07:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeNH-0005R1-Ce
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:14:35 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeNF-0004Vc-3q
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:14:35 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2366e5e4dbaso14995485ad.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627671; x=1752232471; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NqE5fVFQfHyb6UDdosLT6q2NRwyGZ/+U3lfNU21fzaw=;
 b=jxjhTwoKWvq6bLGPBTS+773odY0j1v8roVNUJX0DPrQIAkyYIxCwqgF0orzPUdyfpv
 k/2cqQNRhxTnCoHLeQyiKFAY8PA/KpTx7ExPfvpeZSCVA3BVaS8ZQ54wzjSLZGTaR2SL
 A5DnkGyuPLZVPpIqYkm8nNXw4VkrIrO/Mkx7G/8NplTy6Im3bfGojJUFXrQ7a5gEIbU0
 auSkiDd6GSCs7q7GAyso865UEQ6y+sH4xvnyWYtAas/Jm2G58cvsXXdwXTocgmaKmIW/
 JmXLyoA0M3jb6Fx9LdcCEakFeNu7i4PUIIAnyaLCx9z94bluE3ntCZ8UmQwvHRFuZknd
 QTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627671; x=1752232471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NqE5fVFQfHyb6UDdosLT6q2NRwyGZ/+U3lfNU21fzaw=;
 b=jTod3/3uIe24lZ9pfeebGw3atkn/y+pAVIxFZ+AvHi3aQM1B3J0wtbfowRMs/pCkZ1
 6vgRIomz6foFEB7JzaHeISXO5cnDYpGpBMv9uEOhlnUODc9bTQPgWu0UrowBf9ifPgQj
 vwy3ifCV7nBuUmnD+VxzAN5ZSk+YCT940cPJ2KPneQcdgRaI+lQNQEFT11aR5zcVr5r9
 uVEwov0rsHwQNPS2Eb21Hl5kkm19Bee3ppgMxykVnt6MJuSSK/6+RcCXf+v50n28RiHh
 zZaMqw4xBnMMq0130X8BN5XNmzGP+vJTBvngxgxeGEeU5hkwwn+P1VFATnMoiy3h0M/h
 q6ug==
X-Gm-Message-State: AOJu0YzUfdmwws8WI2PfJ5QFVyb3FFCHa/DRWwd2c7zKvbd/1xTvDsSH
 pTA0EwASP55sMx5GWnHb41cVxbjq+WVEv4o/JGX/1g6kBgn8fs+qOpvJ7L1P/g==
X-Gm-Gg: ASbGncvd73HfY3sOA3/zCwm0RXvaMQvLxNL7JS5TZmXBKuwOj/sjqSvtHCjdJ7m8+Xd
 A8Zzh6a9sdzYzMwBkYYPe5Qhs1ixaHAvectZNFZq+9+sxv6doGsuE08yeCSHiGnFEqO+ZKjl+eO
 0reM4qvb0OX7m9FL7LnmDciBBJKC3rx2AyezioeRbPdowezgkIX8XlGQLX272pziuOeHYzverbl
 859TfkICR//uNgmei8x3NCLdXD5e/Q3+TodZg8y+wsocTgzDc3ZrWXAeA4HzpJyMFveGUiM6w4A
 hif+JaZnIUdSbqnLi8UQ4jyMdaZwhUf7ObiYSwlXa81b3Qr6b7xMLcGqd3LTm36tPxAmS0N3efM
 9WCJuLmsS3/Y2BdJ/6Kcr5HlQUctYxm89u6JFLickIqRHytHm3q1edcrMv+TMQDP0jwQ=
X-Google-Smtp-Source: AGHT+IELRC4nApgmQVoI2EPIDY80ZcIwXWLiU6MMxWxl7m7bEpKxELKvjtWZDJhhfj9h/ZMBiNLiFQ==
X-Received: by 2002:a17:903:22d0:b0:234:1e11:95a3 with SMTP id
 d9443c01a7336-23c84b6842dmr43353245ad.13.1751627671528; 
 Fri, 04 Jul 2025 04:14:31 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.14.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:14:31 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Deepak Gupta <debug@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nutty Liu <liujingqi@lanxincomputing.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 40/40] target: riscv: Add Svrsw60t59b extension support
Date: Fri,  4 Jul 2025 21:12:07 +1000
Message-ID: <20250704111207.591994-41-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
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

From: Alexandre Ghiti <alexghiti@rivosinc.com>

The Svrsw60t59b extension allows to free the PTE reserved bits 60 and 59
for software to use.

Reviewed-by: Deepak Gupta <debug@rivosinc.com>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Nutty Liu<liujingqi@lanxincomputing.com>
Message-ID: <20250702-dev-alex-svrsw60b59b_v2-v2-1-504ddf0f8530@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu-bits.h       | 1 +
 target/riscv/cpu_bits.h           | 3 ++-
 target/riscv/cpu_cfg_fields.h.inc | 1 +
 hw/riscv/riscv-iommu.c            | 3 ++-
 target/riscv/cpu.c                | 2 ++
 target/riscv/cpu_helper.c         | 3 ++-
 target/riscv/tcg/tcg-cpu.c        | 8 ++++++++
 7 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
index 1017d73fc6..47fe01bee5 100644
--- a/hw/riscv/riscv-iommu-bits.h
+++ b/hw/riscv/riscv-iommu-bits.h
@@ -79,6 +79,7 @@ struct riscv_iommu_pq_record {
 #define RISCV_IOMMU_CAP_SV39            BIT_ULL(9)
 #define RISCV_IOMMU_CAP_SV48            BIT_ULL(10)
 #define RISCV_IOMMU_CAP_SV57            BIT_ULL(11)
+#define RISCV_IOMMU_CAP_SVRSW60T59B     BIT_ULL(14)
 #define RISCV_IOMMU_CAP_SV32X4          BIT_ULL(16)
 #define RISCV_IOMMU_CAP_SV39X4          BIT_ULL(17)
 #define RISCV_IOMMU_CAP_SV48X4          BIT_ULL(18)
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index e6b3e28386..b62dd82fe7 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -735,7 +735,8 @@ typedef enum {
 #define PTE_SOFT            0x300 /* Reserved for Software */
 #define PTE_PBMT            0x6000000000000000ULL /* Page-based memory types */
 #define PTE_N               0x8000000000000000ULL /* NAPOT translation */
-#define PTE_RESERVED        0x1FC0000000000000ULL /* Reserved bits */
+#define PTE_RESERVED(svrsw60t59b)    \
+    (svrsw60t59b ? 0x07C0000000000000ULL : 0x1FC0000000000000ULL) /* Reserved bits */
 #define PTE_ATTR            (PTE_N | PTE_PBMT) /* All attributes bits */
 
 /* Page table PPN shift amount */
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 98ceb7b340..e2d116f0df 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -57,6 +57,7 @@ BOOL_FIELD(ext_svadu)
 BOOL_FIELD(ext_svinval)
 BOOL_FIELD(ext_svnapot)
 BOOL_FIELD(ext_svpbmt)
+BOOL_FIELD(ext_svrsw60t59b)
 BOOL_FIELD(ext_svvptc)
 BOOL_FIELD(ext_svukte)
 BOOL_FIELD(ext_zdinx)
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index d8b1cb03a8..96a7fbdefc 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2351,7 +2351,8 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
     }
     if (s->enable_g_stage) {
         s->cap |= RISCV_IOMMU_CAP_SV32X4 | RISCV_IOMMU_CAP_SV39X4 |
-                  RISCV_IOMMU_CAP_SV48X4 | RISCV_IOMMU_CAP_SV57X4;
+                  RISCV_IOMMU_CAP_SV48X4 | RISCV_IOMMU_CAP_SV57X4 |
+                  RISCV_IOMMU_CAP_SVRSW60T59B;
     }
 
     if (s->hpm_cntrs > 0) {
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6f1d0618f1..d055ddf462 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -230,6 +230,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
     ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
     ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
+    ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b),
     ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
@@ -1285,6 +1286,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
     MULTI_EXT_CFG_BOOL("svnapot", ext_svnapot, false),
     MULTI_EXT_CFG_BOOL("svpbmt", ext_svpbmt, false),
+    MULTI_EXT_CFG_BOOL("svrsw60t59b", ext_svrsw60t59b, false),
     MULTI_EXT_CFG_BOOL("svvptc", ext_svvptc, true),
 
     MULTI_EXT_CFG_BOOL("zicntr", ext_zicntr, true),
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 2ed69d7c2d..3479a62cc7 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1309,6 +1309,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     bool svade = riscv_cpu_cfg(env)->ext_svade;
     bool svadu = riscv_cpu_cfg(env)->ext_svadu;
     bool adue = svadu ? env->menvcfg & MENVCFG_ADUE : !svade;
+    bool svrsw60t59b = riscv_cpu_cfg(env)->ext_svrsw60t59b;
 
     if (first_stage && two_stage && env->virt_enabled) {
         pbmte = pbmte && (env->henvcfg & HENVCFG_PBMTE);
@@ -1376,7 +1377,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
         if (riscv_cpu_sxl(env) == MXL_RV32) {
             ppn = pte >> PTE_PPN_SHIFT;
         } else {
-            if (pte & PTE_RESERVED) {
+            if (pte & PTE_RESERVED(svrsw60t59b)) {
                 qemu_log_mask(LOG_GUEST_ERROR, "%s: reserved bits set in PTE: "
                               "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "\n",
                               __func__, pte_addr, pte);
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 163e7ce364..78fb279184 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -839,6 +839,12 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         cpu->cfg.ext_ssctr = false;
     }
 
+    if (cpu->cfg.ext_svrsw60t59b &&
+        (!cpu->cfg.mmu || mcc->def->misa_mxl_max == MXL_RV32)) {
+        error_setg(errp, "svrsw60t59b is not supported on RV32 and MMU-less platforms");
+        return;
+    }
+
     /*
      * Disable isa extensions based on priv spec after we
      * validated and set everything we need.
@@ -1588,6 +1594,8 @@ static void riscv_init_max_cpu_extensions(Object *obj)
 
     if (env->misa_mxl != MXL_RV32) {
         isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zcf), false);
+    } else {
+        isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_svrsw60t59b), false);
     }
 
     /*
-- 
2.50.0


