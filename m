Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C799CEB2C9
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 22:12:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svOdF-0004GB-Dd; Mon, 30 Sep 2024 18:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svOdA-0003rm-I6
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 18:12:38 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svOd8-0002gQ-KY
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 18:12:36 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a93b2070e0cso588143166b.3
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 15:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727734352; x=1728339152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HzCOrw2J8efbxyRT08lYiOJpbQM+5XRqm9RS7QcrOb4=;
 b=cOZizfa+SKxWIhQzfChNsB/qWHNY5eY8f+41uwRogK7Ogo3kXzA+uhWQRLgHZZek/B
 ro3xSMqPXqJcStLdLd1tqcDWUyqG+kJGjaROU/TAKVIwBgABpnhSe/bAOkobb9Z1xhlq
 TN3vTJZVE8oKaVEUTbmAXbrLwOKtUuuHg+2gNfLHtgnau4I21VWFSuf0OWoq59FUUwJu
 kiz9L2KmRq8X86Qc2Pb6VLRDnqDbnlkJX+c0gqwyiCo7aVM1/ylGiNm2eJYSGAQSyoz8
 AyICWebyCRDvGzrB0snsnIHkJ3QKWyo61T1Tt8Ppjj7H3V4jkhxxSHkJlmqcnZJRZSlU
 foLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727734352; x=1728339152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HzCOrw2J8efbxyRT08lYiOJpbQM+5XRqm9RS7QcrOb4=;
 b=LCqYalZhJz3U4L8c9wy7nTp8yNvIroc0LWQxZdjcpXKQDC/VtBayxiA9ShW9g2i6vj
 0WaB0YVr63XvHKigai93bMDPyxq5hP3IRy8YAjf9D4Q1TY7S4Yg1b6qdIHiiLgm5YFSs
 7gYPqv5E5s9g1voSnHCOZ1FNA3hsaa9ZNE13PxRo5Ldo7nYL+gYHwfIwAiARYcM3evR0
 mTUzdiB6SdnqVA27Jyp7IzroKl+Y1S3EFm+URMqzTEV/qRWdiYcdYMwDqe67VO/xT3x5
 95oqDChV5z9vl4rFI29w785FJ474uT8NiWbPUkw1X7/QP5uo5H80YXYQBxertqheo/iN
 GBPQ==
X-Gm-Message-State: AOJu0YyKiB6u/aFESfN8hJ92tRQyXLjqf7FGBbRbXRNb/hokBFhzq4QB
 Lyjj1H8ozojIsh33Fg8/iH7JgHtSlsyBizkCEgGLb6p3PoeX8kxiUFnBBlDymVtUVA/D3vkLsZ5
 W5t4=
X-Google-Smtp-Source: AGHT+IHYen01M9wUzFbyMYNCpGCVFRY4BAhu5eAcrztfOElg9Xk0+IrqBQrjgwjo66yzaFX2I2MMMA==
X-Received: by 2002:a17:907:3f0e:b0:a7d:a00a:aa02 with SMTP id
 a640c23a62f3a-a93c48f1ba0mr1555258766b.1.1727734351755; 
 Mon, 30 Sep 2024 15:12:31 -0700 (PDT)
Received: from localhost.localdomain (46.170.88.92.rev.sfr.net. [92.88.170.46])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93c2978c18sm604258966b.148.2024.09.30.15.12.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 15:12:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Hao Wu <wuhaotsh@google.com>, Laurent Vivier <laurent@vivier.eu>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Steven Lee <steven_lee@aspeedtech.com>, Tyrone Ting <kfting@nuvoton.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 3/3] hw/arm: Replace tswap32() calls by target agnostic
 stl_endian_p()
Date: Tue,  1 Oct 2024 00:12:04 +0200
Message-ID: <20240930221205.59101-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930221205.59101-1-philmd@linaro.org>
References: <20240930221205.59101-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

Replace the target-specific tswap32() calls by stl_endian_p()
which does the same but takes the endianness as argument, thus
is target-agnostic.
Get the vCPU endianness calling arm_cpu_code_is_big_endian().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/boot.c        | 8 +++++---
 hw/arm/exynos4210.c  | 7 +++----
 hw/arm/npcm7xx.c     | 6 ++++--
 hw/arm/xilinx_zynq.c | 5 +++--
 4 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 6efd21f9c2..6e8dc00e6d 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -137,6 +137,7 @@ void arm_write_bootloader(const char *name,
                           const uint32_t *fixupcontext)
 {
     AddressSpace *as = arm_boot_address_space(cpu, info);
+    bool be = arm_cpu_code_is_big_endian(&cpu->env);
     /* Fix up the specified bootloader fragment and write it into
      * guest memory using rom_add_blob_fixed(). fixupcontext is
      * an array giving the values to write in for the fixup types
@@ -173,7 +174,7 @@ void arm_write_bootloader(const char *name,
         default:
             abort();
         }
-        code[i] = tswap32(insn);
+        stl_endian_p(be, &code[i], insn);
     }
 
     assert((len * sizeof(uint32_t)) < BOOTLOADER_MAX_SIZE);
@@ -205,6 +206,7 @@ void arm_write_secure_board_setup_dummy_smc(ARMCPU *cpu,
                                             hwaddr mvbar_addr)
 {
     AddressSpace *as = arm_boot_address_space(cpu, info);
+    bool be = arm_cpu_code_is_big_endian(&cpu->env);
     int n;
     uint32_t mvbar_blob[] = {
         /* mvbar_addr: secure monitor vectors
@@ -243,13 +245,13 @@ void arm_write_secure_board_setup_dummy_smc(ARMCPU *cpu,
           || (info->board_setup_addr + sizeof(board_setup_blob) <= mvbar_addr));
 
     for (n = 0; n < ARRAY_SIZE(mvbar_blob); n++) {
-        mvbar_blob[n] = tswap32(mvbar_blob[n]);
+        stl_endian_p(be, &mvbar_blob[n], mvbar_blob[n]);
     }
     rom_add_blob_fixed_as("board-setup-mvbar", mvbar_blob, sizeof(mvbar_blob),
                           mvbar_addr, as);
 
     for (n = 0; n < ARRAY_SIZE(board_setup_blob); n++) {
-        board_setup_blob[n] = tswap32(board_setup_blob[n]);
+        stl_endian_p(be, &board_setup_blob[n], board_setup_blob[n]);
     }
     rom_add_blob_fixed_as("board-setup", board_setup_blob,
                           sizeof(board_setup_blob), info->board_setup_addr, as);
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index e3f1de2631..78e3fae3c1 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -23,7 +23,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "exec/tswap.h"
 #include "cpu.h"
 #include "hw/cpu/a9mpcore.h"
 #include "hw/irq.h"
@@ -473,7 +472,7 @@ static const MemoryRegionOps exynos4210_chipid_and_omr_ops = {
 void exynos4210_write_secondary(ARMCPU *cpu,
         const struct arm_boot_info *info)
 {
-    int n;
+    bool be = arm_cpu_code_is_big_endian(&cpu->env);
     uint32_t smpboot[] = {
         0xe59f3034, /* ldr r3, External gic_cpu_if */
         0xe59f2034, /* ldr r2, Internal gic_cpu_if */
@@ -496,8 +495,8 @@ void exynos4210_write_secondary(ARMCPU *cpu,
     };
     smpboot[ARRAY_SIZE(smpboot) - 1] = info->smp_bootreg_addr;
     smpboot[ARRAY_SIZE(smpboot) - 2] = info->gic_cpu_if_addr;
-    for (n = 0; n < ARRAY_SIZE(smpboot); n++) {
-        smpboot[n] = tswap32(smpboot[n]);
+    for (int n = 0; n < ARRAY_SIZE(smpboot); n++) {
+        stl_endian_p(be, &smpboot[n], smpboot[n]);
     }
     rom_add_blob_fixed("smpboot", smpboot, sizeof(smpboot),
                        info->smp_loader_start);
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index cb7791301b..6afdbf1598 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -309,6 +309,7 @@ static const struct {
 static void npcm7xx_write_board_setup(ARMCPU *cpu,
                                       const struct arm_boot_info *info)
 {
+    bool be = arm_cpu_code_is_big_endian(&cpu->env);
     uint32_t board_setup[] = {
         0xe59f0010,     /* ldr r0, clk_base_addr */
         0xe59f1010,     /* ldr r1, pllcon1_value */
@@ -323,7 +324,7 @@ static void npcm7xx_write_board_setup(ARMCPU *cpu,
     int i;
 
     for (i = 0; i < ARRAY_SIZE(board_setup); i++) {
-        board_setup[i] = tswap32(board_setup[i]);
+        stl_endian_p(be, &board_setup[i], board_setup[i]);
     }
     rom_add_blob_fixed("board-setup", board_setup, sizeof(board_setup),
                        info->board_setup_addr);
@@ -332,6 +333,7 @@ static void npcm7xx_write_board_setup(ARMCPU *cpu,
 static void npcm7xx_write_secondary_boot(ARMCPU *cpu,
                                          const struct arm_boot_info *info)
 {
+    bool be = arm_cpu_code_is_big_endian(&cpu->env);
     /*
      * The default smpboot stub halts the secondary CPU with a 'wfi'
      * instruction, but the arch/arm/mach-npcm/platsmp.c in the Linux kernel
@@ -353,7 +355,7 @@ static void npcm7xx_write_secondary_boot(ARMCPU *cpu,
     int i;
 
     for (i = 0; i < ARRAY_SIZE(smpboot); i++) {
-        smpboot[i] = tswap32(smpboot[i]);
+        stl_endian_p(be, &smpboot[i], smpboot[i]);
     }
 
     rom_add_blob_fixed("smpboot", smpboot, sizeof(smpboot),
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 37c234f5ab..0d6e246543 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -36,9 +36,9 @@
 #include "hw/qdev-clock.h"
 #include "sysemu/reset.h"
 #include "qom/object.h"
-#include "exec/tswap.h"
 #include "target/arm/cpu-qom.h"
 #include "qapi/visitor.h"
+#include "cpu.h"
 
 #define TYPE_ZYNQ_MACHINE MACHINE_TYPE_NAME("xilinx-zynq-a9")
 OBJECT_DECLARE_SIMPLE_TYPE(ZynqMachineState, ZYNQ_MACHINE)
@@ -97,6 +97,7 @@ struct ZynqMachineState {
 static void zynq_write_board_setup(ARMCPU *cpu,
                                    const struct arm_boot_info *info)
 {
+    bool be = arm_cpu_code_is_big_endian(&cpu->env);
     int n;
     uint32_t board_setup_blob[] = {
         0xe3a004f8, /* mov r0, #0xf8000000 */
@@ -106,7 +107,7 @@ static void zynq_write_board_setup(ARMCPU *cpu,
         0xe12fff1e, /* bx lr */
     };
     for (n = 0; n < ARRAY_SIZE(board_setup_blob); n++) {
-        board_setup_blob[n] = tswap32(board_setup_blob[n]);
+        stl_endian_p(be, &board_setup_blob[n], board_setup_blob[n]);
     }
     rom_add_blob_fixed("board-setup", board_setup_blob,
                        sizeof(board_setup_blob), BOARD_SETUP_ADDR);
-- 
2.45.2


