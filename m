Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C93ED29FBC
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 01:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8rEV-0004gl-7p; Wed, 06 Nov 2024 20:22:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8rER-0004fx-7L
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 20:22:43 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8rEP-00033a-EH
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 20:22:42 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-37d495d217bso317917f8f.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 17:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730942560; x=1731547360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gVNNU4zI0zabCVfTlK35ClBmqCQUm+VaEpaZeazC3V0=;
 b=z2eHLLhm/nxirS8XPG0dDxzN6+AxnSt0zEvNrFym8FoiLVkKrwPOSxpUN7GdqtgM1N
 RtmQQbFwfXbEq5r65aoHajelqOCTFufxHTuw6mOc1wUUDxJCX1+ZPTeVoZvtV1MWcBNW
 wYrH4/aaPbYkMsF5Ak1dydqefPSxKO4xFaCFYOHZTUefWU/Y1E2eIcbWQEJgYkrL/zrN
 7N45sUYbTwI/nD7wojAxmf18p76Z9npBDeke5kkbU527Rw93wADNo8uwn/buDGYZg4zq
 LYcDo/g0l53WzsK64eqKV/nBavrinxEVVpgVvfDDeLkZMuxtXkLW1oWO6rzaXHagT4QL
 8arg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730942560; x=1731547360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gVNNU4zI0zabCVfTlK35ClBmqCQUm+VaEpaZeazC3V0=;
 b=FP/ZKwMzemzmTK4FD4wHy4ASQJ0Pbm2cDQNsXzynPPwFE0Ed5IEmS2zjW4ZzAdXo4g
 GBMKU95h1u+6rnmJsIi7tyTARcXV72bBz8aEp99y3vmypPq+MgRCoGKC01mm4lr005Cb
 sa9F7cHOPBEbfs+8nL0H121/34/QxHYdc6eRI7ofFyOf6M72uhg8qSMRdAiWKKsql0lc
 QlC7nphCbXMyzTHj7L2uUQqaaFmOjiPbJhrClWNSAdqns3wUK2jneU13J39e4WNdC7m9
 nq/bgZvAs4+6rCnxhx3BlY2r8FQ11AvmR4khKE3pg6xSCs0G5xLo4nV1HtMGDh0T5XJa
 tpCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrTY3LkhT8aNrX0+S5PrE5hE/DAYXvbu3NZX9EUg4TxA/RIYfqHqDUcCiR0vyhy+mhrAz307YZMbPd@nongnu.org
X-Gm-Message-State: AOJu0Yw1FR+U/5WE9WfUlb9Dp6/rHJ+/ivJdPB1xT8zRjTKbUanYeuP0
 DUTsyF0g/s7b7bc1chCKww/V2GCFxTJ/QCA6teCDonHJ52lG7NJ0oNsQ2G7SzGo=
X-Google-Smtp-Source: AGHT+IHF/9u9vSjDc+iEMUU6zgLXg7t6PjmliJiRoRxwDU3e6wJ2JwVCJkzlXO5nfGZCw6iVBJR1xw==
X-Received: by 2002:a05:6000:1fad:b0:37d:5130:b380 with SMTP id
 ffacd0b85a97d-381c7a5e114mr24972810f8f.23.1730942559815; 
 Wed, 06 Nov 2024 17:22:39 -0800 (PST)
Received: from localhost.localdomain ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9ea4ebsm236852f8f.69.2024.11.06.17.22.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 Nov 2024 17:22:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Anton Johansson <anjo@rev.ng>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>, devel@lists.libvirt.org,
 qemu-ppc@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v2 02/16] hw/microblaze: Propagate CPU endianness to
 microblaze_load_kernel()
Date: Thu,  7 Nov 2024 01:22:08 +0000
Message-ID: <20241107012223.94337-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241107012223.94337-1-philmd@linaro.org>
References: <20241107012223.94337-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Pass vCPU endianness as argument so we can load kernels
with different endianness (different from the qemu-system-binary
builtin one).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-Id: <20241105130431.22564-9-philmd@linaro.org>
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


