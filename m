Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98657C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 14:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNBTj-0006mo-MM; Thu, 05 Jun 2025 10:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexghiti@rivosinc.com>)
 id 1uNBTT-0006lV-F2
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 10:21:43 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexghiti@rivosinc.com>)
 id 1uNBTO-0001e5-Rz
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 10:21:43 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2320d06b728so9569795ad.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 07:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1749133294; x=1749738094;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KXXXFrJFdk4huw55fmj7c8efWKURKDsWycIpd79ULng=;
 b=3bM0bRHjNlrvXTKe2SSrnkxGSYRmH/ryaZyRy06Jkh01AIgv///TARXA6W030I+43I
 betaEK96G70/naoxM73nXY+8Gi4p8Ir0t3I8xwRsTiRyO1cRA9eIVfRoBsXoDRvnNQju
 iYxo4mVy+ZsM9GscdXVCt2rvhwvw5xoK571SAWMBWWAwAU63MvODMOfz1IUyipAyudB3
 48q/02Jg+YvpjhXYoQdbH86AasmmzFp854HcyBexhQyc++XhLhjD4lbVbIueG+6k8hVc
 GPaxgSOGEfPQprIVpDJO4+l1w393Wb45GjkMbcVsjqH3xj7Ao+tLR5n58bGlBw88LJQ6
 5wJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749133294; x=1749738094;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KXXXFrJFdk4huw55fmj7c8efWKURKDsWycIpd79ULng=;
 b=dvgywJi2kHXHEwTGYRdcxjjiWOkkhZUsQqvXQ+bFjd0aWjHQy7W/olaS30lCU6bms/
 Vz4xXPELpJkAep7cYwe9AmnrWE+getVf+OvDRmQ/8qrBo1T5RDpDMz5kskn+fridNw3g
 ctk6kYO/Man2xTZ9fvGRru3KJykh0uB+cTO5jKoxcvrWM3d27XHL00v3jcsiBBo6F6cE
 5HJeqSRiDE106rlSsR7pRYHmiwhf5vRiuDjpCe61tBoyF0BCPQBd2iZNwvMNW9woE6ft
 4tdjHyW3QR8oYpf+cI76Il9evf/nYD5LgX1IS2Ywxo9h2cFN80nn7fjKQcqy7WSZKgtz
 aycA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4Vsy22eiyO8GaWG9sNviqdLMgcNi8Obt3vLM/yqPKO2v7an+OSVPPKy//odlzpphstXfSP+m4ujvs@nongnu.org
X-Gm-Message-State: AOJu0YzuNQFhnvZWkE2wWxHYGIoEyDahBMjvO/jqFvNG8MpTjFodxAxZ
 DdxHgtwBxjUllNnbyWGNomCGN7zk6oeVClUxL7nKpKYiKPCXfP1ZpK8SG/I7+k6xGMQ=
X-Gm-Gg: ASbGncuRz8PPTT8ypNqfm9asu4dR/66HPd4gdCLkI08Sqi9Qfd65lJj4KunNBs1gGjF
 XfHo3SQsvRkrsZoV5IEkNmAUSiaPCBKgZe63Bip5DXHvzw5zEJ1K+hASz8+L2yajlsdtSuiZZmd
 vWid2nfM5x9FNKl170E5jb1tqSjEvmVZX9Ava5p9BeWBRatMoVzE/dJx7ykQqNQUwu32m6Mg6P4
 mqjFN28ZRvGTUTpfGbV4MsuMNNUyvBvKGSJARch0nIqIoRBcFSnRALHiG7/gcjPrMmQO6RQ4xxP
 Unm4dzcQBXGGuKkIzeFHCiTJ6wseQnrXGwDmM5dBl470zqJQ/Xrt3Ne8bChtEjvQxk5+0atQ5v5
 2TlbzXG2gcoLw/7P6hM7mBso=
X-Google-Smtp-Source: AGHT+IHcuPtKDtunOBQLZwVBjEums2tZ1GaCA0uqS/LNriZM34KwVEfMS1XZDBHo+zqWQMljH9n4Eg==
X-Received: by 2002:a17:902:e845:b0:234:b41e:37a2 with SMTP id
 d9443c01a7336-235e1485b45mr96099825ad.11.1749133294513; 
 Thu, 05 Jun 2025 07:21:34 -0700 (PDT)
Received: from alexghiti.ba.rivosinc.com (alexghiti.eu.rivosinc.com.
 [141.95.202.232]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506cd3407sm120464055ad.141.2025.06.05.07.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 07:21:34 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, debug@rivosinc.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH] target: riscv: Add Svrsw60t59b extension support
Date: Thu,  5 Jun 2025 14:21:26 +0000
Message-Id: <20250605142126.1939798-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alexghiti@rivosinc.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The Svrsw60t59b extension allows to free the PTE reserved bits 60 and 59
for software to use.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---

Changes in v2:
 - Add support for IOMMU
 - Make svrsw60t59b depend on sv39 (deepak)

Open question: svrsw60t59b in IOMMU should also depend on 64bit, but I
did not find an easy to way in riscv_iommu_realize() to detect that, how
should I do?

 hw/riscv/riscv-iommu-bits.h       | 1 +
 hw/riscv/riscv-iommu.c            | 3 ++-
 target/riscv/cpu.c                | 2 ++
 target/riscv/cpu_bits.h           | 3 ++-
 target/riscv/cpu_cfg_fields.h.inc | 1 +
 target/riscv/cpu_helper.c         | 3 ++-
 target/riscv/tcg/tcg-cpu.c        | 6 ++++++
 7 files changed, 16 insertions(+), 3 deletions(-)

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
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index a877e5da84..36eda95a1c 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2355,7 +2355,8 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
     }
     if (s->enable_g_stage) {
         s->cap |= RISCV_IOMMU_CAP_SV32X4 | RISCV_IOMMU_CAP_SV39X4 |
-                  RISCV_IOMMU_CAP_SV48X4 | RISCV_IOMMU_CAP_SV57X4;
+                  RISCV_IOMMU_CAP_SV48X4 | RISCV_IOMMU_CAP_SV57X4 |
+                  RISCV_IOMMU_CAP_SVRSW60T59B;
     }
 
     if (s->hpm_cntrs > 0) {
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 629ac37501..13f1f56d95 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -228,6 +228,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
     ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
     ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
+    ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b),
     ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
@@ -1282,6 +1283,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
     MULTI_EXT_CFG_BOOL("svnapot", ext_svnapot, false),
     MULTI_EXT_CFG_BOOL("svpbmt", ext_svpbmt, false),
+    MULTI_EXT_CFG_BOOL("svrsw60t59b", ext_svrsw60t59b, false),
     MULTI_EXT_CFG_BOOL("svvptc", ext_svvptc, true),
 
     MULTI_EXT_CFG_BOOL("zicntr", ext_zicntr, true),
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index a30317c617..51eb7114da 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -675,7 +675,8 @@ typedef enum {
 #define PTE_SOFT            0x300 /* Reserved for Software */
 #define PTE_PBMT            0x6000000000000000ULL /* Page-based memory types */
 #define PTE_N               0x8000000000000000ULL /* NAPOT translation */
-#define PTE_RESERVED        0x1FC0000000000000ULL /* Reserved bits */
+#define PTE_RESERVED(svrsw60t59b)		\
+		(svrsw60t59b ? 0x07C0000000000000ULL : 0x1FC0000000000000ULL) /* Reserved bits */
 #define PTE_ATTR            (PTE_N | PTE_PBMT) /* All attributes bits */
 
 /* Page table PPN shift amount */
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 59f134a419..ab61c1ccf2 100644
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
index 305912b8dd..886006abc3 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -804,6 +804,12 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
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
-- 
2.34.1


