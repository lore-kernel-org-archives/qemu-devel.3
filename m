Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98F3C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyEg-0003CO-6Q; Fri, 31 Jan 2025 16:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyEd-00032f-BX
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:07:31 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyEa-0007xl-4m
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:07:31 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-437a92d7b96so24164645e9.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738357646; x=1738962446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=emmOs0Opw6C6HTsSGMk+16isz8yUvgEMOQYgzBPFsyk=;
 b=BYq1nMTXQMC0tCZIoY3NepgbhsVblhfPFukSqA45hRuZNG2Mn8FXK1OCg4QSSghlsB
 frXFx3U6vRtQqQIr7W/vOCsZ24m3YEOKDry8yGHBbkibmacroJEsTdfRZktTevjN1hOr
 G97JHn+/SQilsEmBxU1KDLp0D1IUSsYiwNXdj4xeXMqwvIVT8HrQ8h/gTmbQs9T6JhS3
 WWaAH4Ej3FkXrbi0oIANttRmbqI+MCX0zQYS2qlwtlTTwUTvPColXxOQmnxDl/v0LYHf
 0P/b9bFjCthvQ/sCpyJa3PZMdvH2wMUDcYLplU8k7vklwO4WU6rwwNl3MG9GP2o62hGh
 RvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357646; x=1738962446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=emmOs0Opw6C6HTsSGMk+16isz8yUvgEMOQYgzBPFsyk=;
 b=LBQh+nov/WerygvJjdHUdFfpGBlwwcwSuzMCZSoI81EVQmV/AeUDvXoYmcnBC9gpQg
 0WqH6pL8u8f05vxEDpq0sBppTi4mERymVUW8MibsAajmEGf4HbHukkQr22s4yEvFqcT+
 bcprIqSSWX9aY8Nnqs5K8R8CKcIwy2xPRCt85+aRDULe0u4l2smWXD8xUB7EYFK3/4Xl
 aMemeEMK2sMGlFBsY1jla7um9PDzbK8bozhB42ko6LqIfzDLJAV+KDKvM3HKGH8BRQSB
 ZbtEsvA3cBeeFzYr0LoS3faWO6hdaBC6CC74duhb7fNQrfRVIN62O8c11d/1HIvxWgNP
 Hbgw==
X-Gm-Message-State: AOJu0YxuxAwbVz3BAeQQUhnfmbv9FX2kcXu2r6YhKvVLx3AscXSAWWTc
 dLdQtc1KPsaWJRZ89LKp7h484wdRmYXueGJIVNE/s7Zx8UZH6UMjbCj87YfHoUW3fWD0BeRejAk
 j380=
X-Gm-Gg: ASbGncsAPOUr057bCZHQbjphdwognQnn2c9Mst+pkqZT7fM4N4n9Hlwd6C6s3WYPnBS
 RV8e0x60PJFpu/yyb32dq1G1qK0kp8ToMtUjQjdiTujMhPKxLbSDDh+n9ca70ibl1z4kF0TGKbv
 IfLbp4sTc/V9FN4BUAPa4SbBWeTgXrmNhTlg5fmNfhJZoLFF1UXpnKEDQjKjyU+7qt5CuQM7SUX
 YyjGZHJ+tohRTRzHGftxTRfL8zHtNlyPWKxmVA6x45ngyAnwgG+wne+E+i9mzqwh2dTGLtjUtnS
 hsm7/n4clnHN5xScz8s4dP3pp5eRCJQeEdh6Rk+HizMnaSWseu3jhBhztBkEeeDKew==
X-Google-Smtp-Source: AGHT+IF2d9Vdx1crVS7Z6VbfeQTZjJC1Gjil1ZSNN4AMLKmLw4FpsJ4F7SfY83RAwoDVIJ2lj4nveQ==
X-Received: by 2002:a05:600c:5486:b0:436:4708:9fb6 with SMTP id
 5b1f17b1804b1-438dc40b42dmr104967265e9.20.1738357646012; 
 Fri, 31 Jan 2025 13:07:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c0ec89csm5491416f8f.6.2025.01.31.13.07.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Jan 2025 13:07:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 25/36] hw/loader: Pass ELFDATA endian order argument to
 load_elf()
Date: Fri, 31 Jan 2025 22:05:08 +0100
Message-ID: <20250131210520.85874-26-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131210520.85874-1-philmd@linaro.org>
References: <20250131210520.85874-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Rather than passing a boolean 'is_big_endian' argument,
directly pass the ELFDATA, which can be unspecified using
the ELFDATANONE value.

Update the call sites:
  0                 -> ELFDATA2LSB
  1                 -> ELFDATA2MSB
  TARGET_BIG_ENDIAN -> TARGET_BIG_ENDIAN ? ELFDATA2MSB : ELFDATA2LSB

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250127113824.50177-7-philmd@linaro.org>
---
 include/hw/loader.h            | 2 +-
 hw/alpha/dp264.c               | 4 ++--
 hw/core/loader.c               | 5 ++---
 hw/hppa/machine.c              | 4 ++--
 hw/i386/multiboot.c            | 4 ++--
 hw/i386/x86-common.c           | 4 ++--
 hw/loongarch/boot.c            | 2 +-
 hw/m68k/an5206.c               | 2 +-
 hw/m68k/mcf5208.c              | 2 +-
 hw/m68k/q800.c                 | 2 +-
 hw/m68k/virt.c                 | 2 +-
 hw/microblaze/boot.c           | 6 ++++--
 hw/mips/boston.c               | 2 +-
 hw/mips/fuloong2e.c            | 2 +-
 hw/mips/loongson3_virt.c       | 2 +-
 hw/mips/malta.c                | 5 +++--
 hw/mips/mipssim.c              | 3 ++-
 hw/openrisc/boot.c             | 2 +-
 hw/pci-host/raven.c            | 4 ++--
 hw/ppc/e500.c                  | 2 +-
 hw/ppc/mac_newworld.c          | 5 +++--
 hw/ppc/mac_oldworld.c          | 4 ++--
 hw/ppc/pegasos2.c              | 8 ++++----
 hw/ppc/ppc405_boards.c         | 2 +-
 hw/ppc/ppc440_bamboo.c         | 3 ++-
 hw/ppc/sam460ex.c              | 2 +-
 hw/ppc/spapr.c                 | 8 ++++----
 hw/ppc/virtex_ml507.c          | 4 ++--
 hw/s390x/ipl.c                 | 6 +++---
 hw/sparc/leon3.c               | 2 +-
 hw/sparc/sun4m.c               | 5 +++--
 hw/sparc64/sun4u.c             | 6 +++---
 hw/tricore/triboard.c          | 2 +-
 hw/tricore/tricore_testboard.c | 2 +-
 hw/xtensa/sim.c                | 3 ++-
 hw/xtensa/xtfpga.c             | 3 ++-
 36 files changed, 67 insertions(+), 59 deletions(-)

diff --git a/include/hw/loader.h b/include/hw/loader.h
index 84737c05b8d..784a93d6c17 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -174,7 +174,7 @@ ssize_t load_elf(const char *filename,
                  uint64_t (*elf_note_fn)(void *, void *, bool),
                  uint64_t (*translate_fn)(void *, uint64_t),
                  void *translate_opaque, uint64_t *pentry, uint64_t *lowaddr,
-                 uint64_t *highaddr, uint32_t *pflags, int big_endian,
+                 uint64_t *highaddr, uint32_t *pflags, int elf_data_order,
                  int elf_machine, int clear_lsb, int data_swab);
 
 /** load_elf_hdr:
diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 52a1fa310b9..570ea9edf24 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -144,7 +144,7 @@ static void clipper_init(MachineState *machine)
     }
     size = load_elf(palcode_filename, NULL, cpu_alpha_superpage_to_phys,
                     NULL, &palcode_entry, NULL, NULL, NULL,
-                    0, EM_ALPHA, 0, 0);
+                    ELFDATA2LSB, EM_ALPHA, 0, 0);
     if (size < 0) {
         error_report("could not load palcode '%s'", palcode_filename);
         exit(1);
@@ -163,7 +163,7 @@ static void clipper_init(MachineState *machine)
 
         size = load_elf(kernel_filename, NULL, cpu_alpha_superpage_to_phys,
                         NULL, &kernel_entry, &kernel_low, NULL, NULL,
-                        0, EM_ALPHA, 0, 0);
+                        ELFDATA2LSB, EM_ALPHA, 0, 0);
         if (size < 0) {
             error_report("could not load kernel '%s'", kernel_filename);
             exit(1);
diff --git a/hw/core/loader.c b/hw/core/loader.c
index cc0631e7dd5..fd25c5e01bd 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -409,12 +409,11 @@ ssize_t load_elf(const char *filename,
                  uint64_t (*elf_note_fn)(void *, void *, bool),
                  uint64_t (*translate_fn)(void *, uint64_t),
                  void *translate_opaque, uint64_t *pentry, uint64_t *lowaddr,
-                 uint64_t *highaddr, uint32_t *pflags, int big_endian,
+                 uint64_t *highaddr, uint32_t *pflags, int elf_data_order,
                  int elf_machine, int clear_lsb, int data_swab)
 {
     return load_elf_as(filename, elf_note_fn, translate_fn, translate_opaque,
-                       pentry, lowaddr, highaddr, pflags,
-                       big_endian ? ELFDATA2MSB : ELFDATA2LSB,
+                       pentry, lowaddr, highaddr, pflags, elf_data_order,
                        elf_machine, clear_lsb, data_swab, NULL);
 }
 
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 0dd19082146..b6135d95261 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -440,7 +440,7 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
 
         size = load_elf(firmware_filename, NULL, translate, NULL,
                         &firmware_entry, &firmware_low, &firmware_high, NULL,
-                        true, EM_PARISC, 0, 0);
+                        ELFDATA2MSB, EM_PARISC, 0, 0);
 
         if (size < 0) {
             error_report("could not load firmware '%s'", firmware_filename);
@@ -467,7 +467,7 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
     if (kernel_filename) {
         size = load_elf(kernel_filename, NULL, linux_kernel_virt_to_phys,
                         NULL, &kernel_entry, &kernel_low, &kernel_high, NULL,
-                        true, EM_PARISC, 0, 0);
+                        ELFDATA2MSB, EM_PARISC, 0, 0);
 
         kernel_entry = linux_kernel_virt_to_phys(NULL, kernel_entry);
 
diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index 1d66ca3204a..cd07a058614 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -202,8 +202,8 @@ int load_multiboot(X86MachineState *x86ms,
         }
 
         kernel_size = load_elf(kernel_filename, NULL, NULL, NULL, &elf_entry,
-                               &elf_low, &elf_high, NULL, 0, I386_ELF_MACHINE,
-                               0, 0);
+                               &elf_low, &elf_high, NULL,
+                               ELFDATA2LSB, I386_ELF_MACHINE, 0, 0);
         if (kernel_size < 0) {
             error_report("Error while loading elf kernel");
             exit(1);
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 008496b5b85..1b0671c5239 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -608,8 +608,8 @@ static bool load_elfboot(const char *kernel_filename,
     uint64_t elf_note_type = XEN_ELFNOTE_PHYS32_ENTRY;
     kernel_size = load_elf(kernel_filename, read_pvh_start_addr,
                            NULL, &elf_note_type, &elf_entry,
-                           &elf_low, &elf_high, NULL, 0, I386_ELF_MACHINE,
-                           0, 0);
+                           &elf_low, &elf_high, NULL,
+                           ELFDATA2LSB, I386_ELF_MACHINE, 0, 0);
 
     if (kernel_size < 0) {
         error_report("Error while loading elf kernel");
diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index bd8763c61c3..354cf458c81 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -243,7 +243,7 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
     kernel_size = load_elf(info->kernel_filename, NULL,
                            cpu_loongarch_virt_to_phys, NULL,
                            &kernel_entry, &kernel_low,
-                           &kernel_high, NULL, 0,
+                           &kernel_high, NULL, ELFDATA2LSB,
                            EM_LOONGARCH, 1, 0);
     if (kernel_size < 0) {
         kernel_size = load_loongarch_linux_image(info->kernel_filename,
diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index 7b8210475ec..d97399b882b 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -74,7 +74,7 @@ static void an5206_init(MachineState *machine)
     }
 
     kernel_size = load_elf(kernel_filename, NULL, NULL, NULL, &elf_entry,
-                           NULL, NULL, NULL, 1, EM_68K, 0, 0);
+                           NULL, NULL, NULL, ELFDATA2MSB, EM_68K, 0, 0);
     entry = elf_entry;
     if (kernel_size < 0) {
         kernel_size = load_uimage(kernel_filename, &entry, NULL, NULL,
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index 409bb72574c..75cc076f787 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -372,7 +372,7 @@ static void mcf5208evb_init(MachineState *machine)
     }
 
     kernel_size = load_elf(kernel_filename, NULL, NULL, NULL, &elf_entry,
-                           NULL, NULL, NULL, 1, EM_68K, 0, 0);
+                           NULL, NULL, NULL, ELFDATA2MSB, EM_68K, 0, 0);
     entry = elf_entry;
     if (kernel_size < 0) {
         kernel_size = load_uimage(kernel_filename, &entry, NULL, NULL,
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index ca3adb9a8ae..aeed4c8ddb8 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -585,7 +585,7 @@ static void q800_machine_init(MachineState *machine)
         }
 
         kernel_size = load_elf(kernel_filename, NULL, NULL, NULL,
-                               &elf_entry, NULL, &high, NULL, 1,
+                               &elf_entry, NULL, &high, NULL, ELFDATA2MSB,
                                EM_68K, 0, 0);
         if (kernel_size < 0) {
             error_report("could not load kernel '%s'", kernel_filename);
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 87ec39eeae1..d967bdd7438 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -228,7 +228,7 @@ static void virt_init(MachineState *machine)
         }
 
         kernel_size = load_elf(kernel_filename, NULL, NULL, NULL,
-                               &elf_entry, NULL, &high, NULL, 1,
+                               &elf_entry, NULL, &high, NULL, ELFDATA2MSB,
                                EM_68K, 0, 0);
         if (kernel_size < 0) {
             error_report("could not load kernel '%s'", kernel_filename);
diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
index 3854bc2291b..60b4ef0abe7 100644
--- a/hw/microblaze/boot.c
+++ b/hw/microblaze/boot.c
@@ -144,13 +144,15 @@ void microblaze_load_kernel(MicroBlazeCPU *cpu, bool is_little_endian,
         /* Boots a kernel elf binary.  */
         kernel_size = load_elf(kernel_filename, NULL, NULL, NULL,
                                &entry, NULL, &high, NULL,
-                               !is_little_endian, EM_MICROBLAZE, 0, 0);
+                               is_little_endian ? ELFDATA2LSB : ELFDATA2MSB,
+                               EM_MICROBLAZE, 0, 0);
         base32 = entry;
         if (base32 == 0xc0000000) {
             kernel_size = load_elf(kernel_filename, NULL,
                                    translate_kernel_address, NULL,
                                    &entry, NULL, NULL, NULL,
-                                   !is_little_endian, EM_MICROBLAZE, 0, 0);
+                                   is_little_endian ? ELFDATA2LSB : ELFDATA2MSB,
+                                   EM_MICROBLAZE, 0, 0);
         }
         /* Always boot into physical ram.  */
         boot_info.bootstrap_pc = (uint32_t)entry;
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 67044af962a..364c328032a 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -792,7 +792,7 @@ static void boston_mach_init(MachineState *machine)
         kernel_size = load_elf(machine->kernel_filename, NULL,
                            cpu_mips_kseg0_to_phys, NULL,
                            &kernel_entry, NULL, &kernel_high,
-                           NULL, 0, EM_MIPS, 1, 0);
+                           NULL, ELFDATA2LSB, EM_MIPS, 1, 0);
 
         if (kernel_size > 0) {
             int dt_size;
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index 16b6a5129e7..646044e2749 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -106,7 +106,7 @@ static uint64_t load_kernel(MIPSCPU *cpu)
                            cpu_mips_kseg0_to_phys, NULL,
                            &kernel_entry, NULL,
                            &kernel_high, NULL,
-                           0, EM_MIPS, 1, 0);
+                           ELFDATA2LSB, EM_MIPS, 1, 0);
     if (kernel_size < 0) {
         error_report("could not load kernel '%s': %s",
                      loaderparams.kernel_filename,
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 85cf1f707fa..831fddb1bd7 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -358,7 +358,7 @@ static uint64_t load_kernel(CPUMIPSState *env)
                            cpu_mips_kseg0_to_phys, NULL,
                            &kernel_entry,
                            &kernel_low, &kernel_high,
-                           NULL, 0, EM_MIPS, 1, 0);
+                           NULL, ELFDATA2LSB, EM_MIPS, 1, 0);
     if (kernel_size < 0) {
         error_report("could not load kernel '%s': %s",
                      loaderparams.kernel_filename,
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 4e9cccaa347..8e9cea70b13 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -880,8 +880,9 @@ static uint64_t load_kernel(void)
     kernel_size = load_elf(loaderparams.kernel_filename, NULL,
                            cpu_mips_kseg0_to_phys, NULL,
                            &kernel_entry, NULL,
-                           &kernel_high, NULL, TARGET_BIG_ENDIAN, EM_MIPS,
-                           1, 0);
+                           &kernel_high, NULL,
+                           TARGET_BIG_ENDIAN ? ELFDATA2MSB : ELFDATA2LSB,
+                           EM_MIPS, 1, 0);
     if (kernel_size < 0) {
         error_report("could not load kernel '%s': %s",
                      loaderparams.kernel_filename,
diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index a294779a82b..c530688e769 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -73,7 +73,8 @@ static uint64_t load_kernel(void)
     kernel_size = load_elf(loaderparams.kernel_filename, NULL,
                            cpu_mips_kseg0_to_phys, NULL,
                            &entry, NULL,
-                           &kernel_high, NULL, TARGET_BIG_ENDIAN,
+                           &kernel_high, NULL,
+                           TARGET_BIG_ENDIAN ? ELFDATA2MSB : ELFDATA2LSB,
                            EM_MIPS, 1, 0);
     if (kernel_size < 0) {
         error_report("could not load kernel '%s': %s",
diff --git a/hw/openrisc/boot.c b/hw/openrisc/boot.c
index 83c1fc6705e..0f08df812dc 100644
--- a/hw/openrisc/boot.c
+++ b/hw/openrisc/boot.c
@@ -32,7 +32,7 @@ hwaddr openrisc_load_kernel(ram_addr_t ram_size,
 
     if (kernel_filename && !qtest_enabled()) {
         kernel_size = load_elf(kernel_filename, NULL, NULL, NULL,
-                               &elf_entry, NULL, &high_addr, NULL, 1,
+                               &elf_entry, NULL, &high_addr, NULL, ELFDATA2MSB,
                                EM_OPENRISC, 1, 0);
         entry = elf_entry;
         if (kernel_size < 0) {
diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index 918a3237a9e..e3d8d206b73 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -357,8 +357,8 @@ static void raven_realize(PCIDevice *d, Error **errp)
         if (filename) {
             if (s->elf_machine != EM_NONE) {
                 bios_size = load_elf(filename, NULL, NULL, NULL, NULL,
-                                     NULL, NULL, NULL, 1, s->elf_machine,
-                                     0, 0);
+                                     NULL, NULL, NULL,
+                                     ELFDATA2MSB, s->elf_machine, 0, 0);
             }
             if (bios_size < 0) {
                 bios_size = get_image_size(filename);
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 4551157c011..26933e0457e 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -1194,7 +1194,7 @@ void ppce500_init(MachineState *machine)
 
     payload_size = load_elf(filename, NULL, NULL, NULL,
                             &bios_entry, &loadaddr, NULL, NULL,
-                            1, PPC_ELF_MACHINE, 0, 0);
+                            ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
     if (payload_size < 0) {
         /*
          * Hrm. No ELF image? Try a uImage, maybe someone is giving us an
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 6369961f78a..cb3dc3ab482 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -182,7 +182,8 @@ static void ppc_core99_init(MachineState *machine)
     if (filename) {
         /* Load OpenBIOS (ELF) */
         bios_size = load_elf(filename, NULL, NULL, NULL, NULL,
-                             NULL, NULL, NULL, 1, PPC_ELF_MACHINE, 0, 0);
+                             NULL, NULL, NULL,
+                             ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
 
         if (bios_size <= 0) {
             /* or load binary ROM image */
@@ -204,7 +205,7 @@ static void ppc_core99_init(MachineState *machine)
         kernel_base = KERNEL_LOAD_ADDR;
         kernel_size = load_elf(machine->kernel_filename, NULL,
                                translate_kernel_address, NULL, NULL, NULL,
-                               NULL, NULL, 1, PPC_ELF_MACHINE, 0, 0);
+                               NULL, NULL, ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
         if (kernel_size < 0) {
             kernel_size = load_aout(machine->kernel_filename, kernel_base,
                                     machine->ram_size - kernel_base,
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 59653e174b8..0dbcea035c3 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -136,7 +136,7 @@ static void ppc_heathrow_init(MachineState *machine)
     if (filename) {
         /* Load OpenBIOS (ELF) */
         bios_size = load_elf(filename, NULL, NULL, NULL, NULL, &bios_addr,
-                             NULL, NULL, 1, PPC_ELF_MACHINE, 0, 0);
+                             NULL, NULL, ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
         /* Unfortunately, load_elf sign-extends reading elf32 */
         bios_addr = (uint32_t)bios_addr;
 
@@ -161,7 +161,7 @@ static void ppc_heathrow_init(MachineState *machine)
         kernel_base = KERNEL_LOAD_ADDR;
         kernel_size = load_elf(machine->kernel_filename, NULL,
                                translate_kernel_address, NULL, NULL, NULL,
-                               NULL, NULL, 1, PPC_ELF_MACHINE, 0, 0);
+                               NULL, NULL, ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
         if (kernel_size < 0) {
             kernel_size = load_aout(machine->kernel_filename, kernel_base,
                                     machine->ram_size - kernel_base,
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index b3c21bdc57c..0364243f4fe 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -160,8 +160,8 @@ static void pegasos2_init(MachineState *machine)
     }
     memory_region_init_rom(rom, NULL, "pegasos2.rom", PROM_SIZE, &error_fatal);
     memory_region_add_subregion(get_system_memory(), PROM_ADDR, rom);
-    sz = load_elf(filename, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1,
-                  PPC_ELF_MACHINE, 0, 0);
+    sz = load_elf(filename, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+                  ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
     if (sz <= 0) {
         sz = load_image_targphys(filename, pm->vof ? 0 : PROM_ADDR, PROM_SIZE);
     }
@@ -239,8 +239,8 @@ static void pegasos2_init(MachineState *machine)
 
     if (machine->kernel_filename) {
         sz = load_elf(machine->kernel_filename, NULL, NULL, NULL,
-                      &pm->kernel_entry, &pm->kernel_addr, NULL, NULL, 1,
-                      PPC_ELF_MACHINE, 0, 0);
+                      &pm->kernel_entry, &pm->kernel_addr, NULL, NULL,
+                      ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
         if (sz <= 0) {
             error_report("Could not load kernel '%s'",
                          machine->kernel_filename);
diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index e9f65fab70d..969cac345ac 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -232,7 +232,7 @@ static void boot_from_kernel(MachineState *machine, PowerPCCPU *cpu)
 
     kernel_size = load_elf(machine->kernel_filename, NULL, NULL, NULL,
                            &boot_entry, &kernel_base, NULL, NULL,
-                           1, PPC_ELF_MACHINE, 0, 0);
+                           ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
     if (kernel_size < 0) {
         error_report("Could not load kernel '%s' : %s",
                      machine->kernel_filename, load_elf_strerror(kernel_size));
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 45c5b8678d9..099fda39092 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -228,7 +228,8 @@ static void bamboo_init(MachineState *machine)
         if (success < 0) {
             uint64_t elf_entry;
             success = load_elf(kernel_filename, NULL, NULL, NULL, &elf_entry,
-                               NULL, NULL, NULL, 1, PPC_ELF_MACHINE, 0, 0);
+                               NULL, NULL, NULL,
+                               ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
             entry = elf_entry;
         }
         /* XXX try again as binary */
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index e74642a3b71..3ecae6a9504 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -479,7 +479,7 @@ static void sam460ex_init(MachineState *machine)
 
             success = load_elf(machine->kernel_filename, NULL, NULL, NULL,
                                &elf_entry, NULL, NULL, NULL,
-                               1, PPC_ELF_MACHINE, 0, 0);
+                               ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
             entry = elf_entry;
         }
         /* XXX try again as binary */
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 623842f8064..f3a4b4235d4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3022,13 +3022,13 @@ static void spapr_machine_init(MachineState *machine)
 
         spapr->kernel_size = load_elf(kernel_filename, NULL,
                                       translate_kernel_address, spapr,
-                                      NULL, &loaded_addr, NULL, NULL, 1,
-                                      PPC_ELF_MACHINE, 0, 0);
+                                      NULL, &loaded_addr, NULL, NULL,
+                                      ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
         if (spapr->kernel_size == ELF_LOAD_WRONG_ENDIAN) {
             spapr->kernel_size = load_elf(kernel_filename, NULL,
                                           translate_kernel_address, spapr,
-                                          NULL, &loaded_addr, NULL, NULL, 0,
-                                          PPC_ELF_MACHINE, 0, 0);
+                                          NULL, &loaded_addr, NULL, NULL,
+                                          ELFDATA2LSB, PPC_ELF_MACHINE, 0, 0);
             spapr->kernel_le = spapr->kernel_size > 0;
         }
         if (spapr->kernel_size < 0) {
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index ea7ab8a5694..23238119273 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -242,8 +242,8 @@ static void virtex_init(MachineState *machine)
 
         /* Boots a kernel elf binary.  */
         kernel_size = load_elf(kernel_filename, NULL, NULL, NULL,
-                               &entry, NULL, &high, NULL, 1, PPC_ELF_MACHINE,
-                               0, 0);
+                               &entry, NULL, &high, NULL,
+                               ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
         boot_info.bootstrap_pc = entry & 0x00ffffff;
 
         if (kernel_size < 0) {
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 4aa21c91fca..ce6f6078d74 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -162,8 +162,8 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
 
         bios_size = load_elf(bios_filename, NULL,
                              bios_translate_addr, &fwbase,
-                             &ipl->bios_start_addr, NULL, NULL, NULL, 1,
-                             EM_S390, 0, 0);
+                             &ipl->bios_start_addr, NULL, NULL, NULL,
+                             ELFDATA2MSB, EM_S390, 0, 0);
         if (bios_size > 0) {
             /* Adjust ELF start address to final location */
             ipl->bios_start_addr += fwbase;
@@ -187,7 +187,7 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
     if (ipl->kernel) {
         kernel_size = load_elf(ipl->kernel, NULL, NULL, NULL,
                                &pentry, NULL,
-                               NULL, NULL, 1, EM_S390, 0, 0);
+                               NULL, NULL, ELFDATA2MSB, EM_S390, 0, 0);
         if (kernel_size < 0) {
             kernel_size = load_image_targphys(ipl->kernel, 0, ms->ram_size);
             if (kernel_size < 0) {
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 84381254ad0..0aeaad3becc 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -380,7 +380,7 @@ static void leon3_generic_hw_init(MachineState *machine)
 
         kernel_size = load_elf(kernel_filename, NULL, NULL, NULL,
                                &entry, NULL, NULL, NULL,
-                               1 /* big endian */, EM_SPARC, 0, 0);
+                               ELFDATA2MSB, EM_SPARC, 0, 0);
         if (kernel_size < 0) {
             kernel_size = load_uimage(kernel_filename, NULL, &entry,
                                       NULL, NULL, NULL);
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index e070360a2c7..a48d3622c5a 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -242,7 +242,8 @@ static unsigned long sun4m_load_kernel(const char *kernel_filename,
 #endif
         kernel_size = load_elf(kernel_filename, NULL,
                                translate_kernel_address, NULL,
-                               NULL, NULL, NULL, NULL, 1, EM_SPARC, 0, 0);
+                               NULL, NULL, NULL, NULL,
+                               ELFDATA2MSB, EM_SPARC, 0, 0);
         if (kernel_size < 0)
             kernel_size = load_aout(kernel_filename, KERNEL_LOAD_ADDR,
                                     RAM_size - KERNEL_LOAD_ADDR, bswap_needed,
@@ -703,7 +704,7 @@ static void prom_init(hwaddr addr, const char *bios_name)
     if (filename) {
         ret = load_elf(filename, NULL,
                        translate_prom_address, &addr, NULL,
-                       NULL, NULL, NULL, 1, EM_SPARC, 0, 0);
+                       NULL, NULL, NULL, ELFDATA2MSB, EM_SPARC, 0, 0);
         if (ret < 0 || ret > PROM_SIZE_MAX) {
             ret = load_image_targphys(filename, addr, PROM_SIZE_MAX);
         }
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 0980b446593..8ab5cf0461f 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -176,8 +176,8 @@ static uint64_t sun4u_load_kernel(const char *kernel_filename,
         bswap_needed = 0;
 #endif
         kernel_size = load_elf(kernel_filename, NULL, NULL, NULL, kernel_entry,
-                               kernel_addr, &kernel_top, NULL, 1, EM_SPARCV9, 0,
-                               0);
+                               kernel_addr, &kernel_top, NULL,
+                               ELFDATA2MSB, EM_SPARCV9, 0, 0);
         if (kernel_size < 0) {
             *kernel_addr = KERNEL_LOAD_ADDR;
             *kernel_entry = KERNEL_LOAD_ADDR;
@@ -441,7 +441,7 @@ static void prom_init(hwaddr addr, const char *bios_name)
     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
     if (filename) {
         ret = load_elf(filename, NULL, translate_prom_address, &addr,
-                       NULL, NULL, NULL, NULL, 1, EM_SPARCV9, 0, 0);
+                       NULL, NULL, NULL, NULL, ELFDATA2MSB, EM_SPARCV9, 0, 0);
         if (ret < 0 || ret > PROM_SIZE_MAX) {
             ret = load_image_targphys(filename, addr, PROM_SIZE_MAX);
         }
diff --git a/hw/tricore/triboard.c b/hw/tricore/triboard.c
index 9cc8d282ff2..f5baa8ccbb3 100644
--- a/hw/tricore/triboard.c
+++ b/hw/tricore/triboard.c
@@ -39,7 +39,7 @@ static void tricore_load_kernel(TriCoreCPU *cpu, const char *kernel_filename)
 
     kernel_size = load_elf(kernel_filename, NULL,
                            NULL, NULL, &entry, NULL,
-                           NULL, NULL, 0,
+                           NULL, NULL, ELFDATA2LSB,
                            EM_TRICORE, 1, 0);
     if (kernel_size <= 0) {
         error_report("no kernel file '%s'", kernel_filename);
diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboard.c
index c29db8b451c..3facfdfd611 100644
--- a/hw/tricore/tricore_testboard.c
+++ b/hw/tricore/tricore_testboard.c
@@ -42,7 +42,7 @@ static void tricore_load_kernel(CPUTriCoreState *env)
 
     kernel_size = load_elf(tricoretb_binfo.kernel_filename, NULL,
                            NULL, NULL, &entry, NULL,
-                           NULL, NULL, 0,
+                           NULL, NULL, ELFDATA2LSB,
                            EM_TRICORE, 1, 0);
     if (kernel_size <= 0) {
         error_report("no kernel file '%s'",
diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index 0a1fd900376..1cea29c66d4 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -100,7 +100,8 @@ void xtensa_sim_load_kernel(XtensaCPU *cpu, MachineState *machine)
     if (kernel_filename) {
         uint64_t elf_entry;
         int success = load_elf(kernel_filename, NULL, translate_phys_addr, cpu,
-                               &elf_entry, NULL, NULL, NULL, TARGET_BIG_ENDIAN,
+                               &elf_entry, NULL, NULL, NULL,
+                               TARGET_BIG_ENDIAN ? ELFDATA2MSB : ELFDATA2LSB,
                                EM_XTENSA, 0, 0);
 
         if (success > 0) {
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 9efe91933f9..3f3677f1c9a 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -398,7 +398,8 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
 
         uint64_t elf_entry;
         int success = load_elf(kernel_filename, NULL, translate_phys_addr, cpu,
-                               &elf_entry, NULL, NULL, NULL, TARGET_BIG_ENDIAN,
+                               &elf_entry, NULL, NULL, NULL,
+                               TARGET_BIG_ENDIAN ? ELFDATA2MSB : ELFDATA2LSB,
                                EM_XTENSA, 0, 0);
         if (success > 0) {
             entry_point = elf_entry;
-- 
2.47.1


