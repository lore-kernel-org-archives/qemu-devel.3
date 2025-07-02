Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C226C7EE30
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 07:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWrv7-0002Fv-F8; Wed, 02 Jul 2025 03:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexghiti@rivosinc.com>)
 id 1uWrv0-0002DM-C4
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 03:30:10 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexghiti@rivosinc.com>)
 id 1uWrup-0007o2-9i
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 03:30:06 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-74b27c1481bso2049942b3a.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 00:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1751441396; x=1752046196;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o+1kya4exW9pPD1MNqhgnKAyBAUA3fmXeCE+T7pu/Zw=;
 b=3T//lL2m47/u281B0iqsssG9ZPDPFG4cbqQiUPDT5wzNVIY5luNxHmklmty1Nisas4
 nvAOcIQITSU+WvDUoL7n4SdwWXR5To62OpM1cegrTSn8EMsSPWU+L1oaEUBX489YAshy
 eAn2X8TA4B8dl0C6P9lKqHKJuxx3aO+xbgmgrhTxxb5k/pOQhc1uRF1RjrWYf3Pt/KZ7
 TJL0LvxkmYLCWTP5sQW1oNEqu7bfTX15blH2toOsAzugbbFzDfbEv4AMttzDaGW4yKlI
 1Vy91nYpVG4fM41hlrwlROtvHDQC9rj7u6aoSd1mpkxs+0hPeAYwU58N8qQ/P8khd0On
 G/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751441396; x=1752046196;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o+1kya4exW9pPD1MNqhgnKAyBAUA3fmXeCE+T7pu/Zw=;
 b=EDYhGqLvQyi2wjKkZoyPSGK15RTN3vJbhoebPk5S/Nc/t5n3aqBbkkSS2i9djRvUbI
 eH6hDfGjmGfh/k6DNzjWeho9geOc2Dt1y3fgarPzZazj72yDig/4sf9UX+1M5dJJr3TI
 Y1/i4XzpCCiX8moSgrif3PMQCARqjNnjmeb7lRzOubHGpIMYiQGCEa4h0BfJnmWHuXhC
 X3grcJ5VR85/N9tGi3zgIqYekaA5XFX9wJ5McVc3Maz09NUfgIsKzyKF0ZsjkgdKheXi
 8H0Vd27ULC6B7CQANuj3EkGx8c8H8VPu+dYLls02rmun9w8CrcFDFRyds38+b4RMCH7c
 w4Iw==
X-Gm-Message-State: AOJu0YwEhmxXGIMeKJ/27ZCSGf1FFCRZwFc8RHiV7j457bTjBmQyI94N
 X57IiINxIlo5fINl6N9NmQsfwzhgX35/OoyJKTFW6ZsNbaAYNcGn+qxhqI+bVx/RNk8=
X-Gm-Gg: ASbGncswaLLKAkRGTUbA9vqKkrNSJ7ATknzEHiNHTsrG7KB1rC8wox1gI1FajhzJ2ah
 fc1mJ76GF6+grcNihn8BWqZONfVB5iRU/IxLIieH4NDJqmE8tuim4m8iCijs02hCKvcptll2J3V
 kKe/y6Jb237cktr74suB2viKm1X7ARjuBztAnPkv7gU5lTaWw8s9FFRpFt7CP+kh2ZXkF7SUlwr
 0FdyvrDyFXIGFmDmlP6ML8TffI5V9+f+WeW+Mnz/uLg5z/qlKRXlyWTJrDZX5B+4sOZ3GOIe8hj
 3Al6oEo5cBGr01g97iCgHyftto/fnV5jRNDXrSs7HfvMC6QPOVOIhT0fSQTo5t5Cw8PrRY2eKyB
 DyNILPP96NrHXZfOHS+Tdt7u8AsrIDaVEfQ==
X-Google-Smtp-Source: AGHT+IEU0tC+FaWGEWPxe6+oTneC0ovTI2YwHKtrKdY6mo+O1NQdyBTrlYmrJkHW3FS0LOTCnSrkUQ==
X-Received: by 2002:a05:6a20:394a:b0:220:9838:32ca with SMTP id
 adf61e73a8af0-222d7de5178mr4050095637.14.1751441395911; 
 Wed, 02 Jul 2025 00:29:55 -0700 (PDT)
Received: from alexghiti.eu.rivosinc.com (alexghiti.eu.rivosinc.com.
 [141.95.202.232]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b34e31beab2sm12389878a12.47.2025.07.02.00.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 00:29:55 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Wed, 02 Jul 2025 07:28:52 +0000
Subject: [PATCH v2] target: riscv: Add Svrsw60t59b extension support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-dev-alex-svrsw60b59b_v2-v2-1-504ddf0f8530@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIALPfZGgC/x3MQQqDMBBG4avIrB0IA4nWq5QiSf3VgaIlA1EQ7
 97Q5bd47yJDVhgNzUUZRU33rULaht5r3BawTtUkTrwL4nlC4fjByVayHcEl/0hjEY4hdXPvE4K
 Aav3NmPX8n5+v+/4BirsCjmkAAAA=
X-Change-ID: 20250625-dev-alex-svrsw60b59b_v2-a6b7f85be62e
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Deepak Gupta <debug@rivosinc.com>, Alexandre Ghiti <alexghiti@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6847;
 i=alexghiti@rivosinc.com; h=from:subject:message-id;
 bh=kB+PZ+OBnsQwjKb0LVHflg7ULO3HRw3rKAlcQWd9IBo=;
 b=owGbwMvMwCGWYr9pz6TW912Mp9WSGDJS7t/guLytd6PMdIMON7sL7Xlet7Zs5XzIfuvNndlzp
 msf9r6wuaOUhUGMg0FWTJFFwTyhq8X+bP3sP5few8xhZQIZwsDFKQATaeFg+MNbxyKSceLG3j2z
 lkc2br+bxPNrUzSn5+O8Tx0nUjJmpk1k+Mm4p6teZN3Lwsc923fKhKednrPhUdRypu1Lp9VKrMu
 cfo4HAA==
X-Developer-Key: i=alexghiti@rivosinc.com; a=openpgp;
 fpr=DC049C97114ED82152FE79A783E4BA75438E93E3
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=alexghiti@rivosinc.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Deepak Gupta <debug@rivosinc.com>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
Changes in v2:
  - Fix riscv32 max config (thanks Daniel!)
  - Add RB from Deepak
  - Remove tab usage
---
 hw/riscv/riscv-iommu-bits.h       | 1 +
 hw/riscv/riscv-iommu.c            | 3 ++-
 target/riscv/cpu.c                | 2 ++
 target/riscv/cpu_bits.h           | 3 ++-
 target/riscv/cpu_cfg_fields.h.inc | 1 +
 target/riscv/cpu_helper.c         | 3 ++-
 target/riscv/tcg/tcg-cpu.c        | 8 ++++++++
 7 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
index 1017d73fc6e7368dae9bec7314e68cde707d4bad..47fe01bee58697544104cfe16618307ece236132 100644
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
index a877e5da84b66e3d1991bb70cc58e80d9d88d0d0..36eda95a1c6e149976c1bd60b9f6b4753682bc0a 100644
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
index 629ac37501e585bc772f3004139db363426e1596..13f1f56d9583141d913aec92344148f2e627b491 100644
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
index a30317c6178111b827dddc15a18c66f2762c43bf..97384dcfa04f55e19c0da7774553fee80f6ebbb4 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -675,7 +675,8 @@ typedef enum {
 #define PTE_SOFT            0x300 /* Reserved for Software */
 #define PTE_PBMT            0x6000000000000000ULL /* Page-based memory types */
 #define PTE_N               0x8000000000000000ULL /* NAPOT translation */
-#define PTE_RESERVED        0x1FC0000000000000ULL /* Reserved bits */
+#define PTE_RESERVED(svrsw60t59b)    \
+    (svrsw60t59b ? 0x07C0000000000000ULL : 0x1FC0000000000000ULL) /* Reserved bits */
 #define PTE_ATTR            (PTE_N | PTE_PBMT) /* All attributes bits */
 
 /* Page table PPN shift amount */
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 59f134a41924e361e0a5f7ede44214823fd971ba..ab61c1ccf214bdeaea41fbf815909fad24d40124 100644
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
index 2ed69d7c2d21e59868fea9e9e77d6d36561dfb5f..3479a62cc7f3cedc6c127dc2db8e01919e3a9f15 100644
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
index 55fd9e5584581b20406a7dc66037d6d88f4cf86d..96201e15c6d409414db68ba976ab944ba1c8f2fd 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -830,6 +830,12 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
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
@@ -1606,6 +1612,8 @@ static void riscv_init_max_cpu_extensions(Object *obj)
 
     if (env->misa_mxl != MXL_RV32) {
         isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zcf), false);
+    } else {
+        isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_svrsw60t59b), false);
     }
 
     /*

---
base-commit: f9a3def17b2a57679902c33064cf7853263db0ef
change-id: 20250625-dev-alex-svrsw60b59b_v2-a6b7f85be62e

Best regards,
-- 
Alexandre Ghiti <alexghiti@rivosinc.com>


