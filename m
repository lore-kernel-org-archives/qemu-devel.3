Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C6ED5C0F0
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 15:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9R9Q-0003NN-TN; Fri, 08 Nov 2024 10:43:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9R96-0002pn-TR
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:43:37 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9R91-0005Pu-To
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:43:34 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43161e7bb25so18749785e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 07:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731080610; x=1731685410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hWbuZBdiwta9OCqh2H6+dZmGxN8LycHZheUEly/zthI=;
 b=Se+8/38jepgotJbNKAzI1x9T3tcHIlzmIkiHbzxfMtMmwX8wGwkbLZv4GXTgkCbmap
 6Md2/0FMwhZXQWwkro3uuBSsfGOYxNrzOSfClH90Mopv/CDtx3LGNoYw1UPx5YhMjWVO
 jzqqKzGhJJMNWIjS8JM7TPreVawXgMhsPrCsPpilMZppR8TgMU1SVW59tnW/cZPC8Dhy
 dC0OQH9+Gde1jHTaZ2BDp8qc00mTLO/INmLP2ZyoAaxJu+r9yiCFgZk76Dgsntg6upNN
 21Zmd9xzYdXGpfps1OmtaGwQ2ouirZGwFcZHjJrxsAPMIHw70ygM+HhrZ32SqSok+kU0
 cj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731080610; x=1731685410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hWbuZBdiwta9OCqh2H6+dZmGxN8LycHZheUEly/zthI=;
 b=velDqVa5Z1sTOaKLEUS3jTDaog5S/mvjYBKHKjFW07KXz/OjGIVR5rRASlicAybFUj
 BPKasL/UK39O0v30Bm6G6gOgmX/c8Qd5GDPZsNWOQJIiLB1FW7K/YC6MZQu5XWOgcbOb
 Pmzo4IflY1+4TfU/wW6s0xaBOiIkm0uPTphjOH3LazpzR0L5eTjG3vCBtF9i+dVuSAoL
 IlJ6bKtGqAOmd+AkC00p/q8mUNHidofyin9q9p5z6RO/+gkSoOfgRKV1GnDO0LS+BQrg
 h3AoZud7xNLh2jOl+t1IjIChNWr0cMlGVO6THFCFlJJBne8cT5sCPTcvOUWz9dRhSLyW
 +EUg==
X-Gm-Message-State: AOJu0YylLSWLjHa2fpQSOmlPoI94m3410owz6hBiMc+l2EOH5ymdRIws
 BEl48a38QMojxy6ti3lPGxgvGMFTE09MObWtuaTrutMq5or07idi5Mj2Y+ADQnh4CJkAMFzrDxA
 8
X-Google-Smtp-Source: AGHT+IEdrSsRdErytPC8DVn7is2xuHh0bQASnBkvct6Z5o8urKDsp6a8cZeqEPwxPKHpl5Suuqm9rw==
X-Received: by 2002:a05:600c:46cc:b0:42c:ba83:3f01 with SMTP id
 5b1f17b1804b1-432b75017e5mr28030815e9.8.1731080609775; 
 Fri, 08 Nov 2024 07:43:29 -0800 (PST)
Received: from localhost.localdomain ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa70a234sm111997735e9.34.2024.11.08.07.43.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 08 Nov 2024 07:43:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Anton Johansson <anjo@rev.ng>
Cc: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v3 02/17] hw/microblaze: Propagate CPU endianness to
 microblaze_load_kernel()
Date: Fri,  8 Nov 2024 15:43:02 +0000
Message-ID: <20241108154317.12129-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108154317.12129-1-philmd@linaro.org>
References: <20241108154317.12129-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Pass vCPU endianness as argument so we can load kernels
with different endianness (different from the qemu-system-binary
builtin one).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/microblaze/boot.h                     | 4 ++--
 hw/microblaze/boot.c                     | 8 ++++----
 hw/microblaze/petalogix_ml605_mmu.c      | 2 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 2 +-
 hw/microblaze/xlnx-zynqmp-pmu.c          | 2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/microblaze/boot.h b/hw/microblaze/boot.h
index 5a8c2f7975..d179a551a6 100644
--- a/hw/microblaze/boot.h
+++ b/hw/microblaze/boot.h
@@ -2,8 +2,8 @@
 #define MICROBLAZE_BOOT_H
 
 
-void microblaze_load_kernel(MicroBlazeCPU *cpu, hwaddr ddr_base,
-                            uint32_t ramsize,
+void microblaze_load_kernel(MicroBlazeCPU *cpu, bool is_little_endian,
+                            hwaddr ddr_base, uint32_t ramsize,
                             const char *initrd_filename,
                             const char *dtb_filename,
                             void (*machine_cpu_reset)(MicroBlazeCPU *));
diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
index ed61e483ee..3675489fa5 100644
--- a/hw/microblaze/boot.c
+++ b/hw/microblaze/boot.c
@@ -114,8 +114,8 @@ static uint64_t translate_kernel_address(void *opaque, uint64_t addr)
     return addr - 0x30000000LL;
 }
 
-void microblaze_load_kernel(MicroBlazeCPU *cpu, hwaddr ddr_base,
-                            uint32_t ramsize,
+void microblaze_load_kernel(MicroBlazeCPU *cpu, bool is_little_endian,
+                            hwaddr ddr_base, uint32_t ramsize,
                             const char *initrd_filename,
                             const char *dtb_filename,
                             void (*machine_cpu_reset)(MicroBlazeCPU *))
@@ -144,13 +144,13 @@ void microblaze_load_kernel(MicroBlazeCPU *cpu, hwaddr ddr_base,
         /* Boots a kernel elf binary.  */
         kernel_size = load_elf(kernel_filename, NULL, NULL, NULL,
                                &entry, NULL, &high, NULL,
-                               TARGET_BIG_ENDIAN, EM_MICROBLAZE, 0, 0);
+                               !is_little_endian, EM_MICROBLAZE, 0, 0);
         base32 = entry;
         if (base32 == 0xc0000000) {
             kernel_size = load_elf(kernel_filename, NULL,
                                    translate_kernel_address, NULL,
                                    &entry, NULL, NULL, NULL,
-                                   TARGET_BIG_ENDIAN, EM_MICROBLAZE, 0, 0);
+                                   !is_little_endian, EM_MICROBLAZE, 0, 0);
         }
         /* Always boot into physical ram.  */
         boot_info.bootstrap_pc = (uint32_t)entry;
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index 61e47d8398..d2b2109065 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -204,7 +204,7 @@ petalogix_ml605_init(MachineState *machine)
     cpu->cfg.pvr_regs[5] = 0xc56be000;
     cpu->cfg.pvr_regs[10] = 0x0e000000; /* virtex 6 */
 
-    microblaze_load_kernel(cpu, MEMORY_BASEADDR, ram_size,
+    microblaze_load_kernel(cpu, true, MEMORY_BASEADDR, ram_size,
                            machine->initrd_filename,
                            BINARY_DEVICE_TREE_FILE,
                            NULL);
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 6c0f5c6c65..8110be8371 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -129,7 +129,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
 
     create_unimplemented_device("xps_gpio", GPIO_BASEADDR, 0x10000);
 
-    microblaze_load_kernel(cpu, ddr_base, ram_size,
+    microblaze_load_kernel(cpu, !TARGET_BIG_ENDIAN, ddr_base, ram_size,
                            machine->initrd_filename,
                            BINARY_DEVICE_TREE_FILE,
                            NULL);
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index 567aad47bf..bdbf7328bf 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -172,7 +172,7 @@ static void xlnx_zynqmp_pmu_init(MachineState *machine)
     qdev_realize(DEVICE(pmu), NULL, &error_fatal);
 
     /* Load the kernel */
-    microblaze_load_kernel(&pmu->cpu, XLNX_ZYNQMP_PMU_RAM_ADDR,
+    microblaze_load_kernel(&pmu->cpu, true, XLNX_ZYNQMP_PMU_RAM_ADDR,
                            machine->ram_size,
                            machine->initrd_filename,
                            machine->dtb,
-- 
2.45.2


