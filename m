Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA98CCF9EF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 07:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDeXc-0007NW-15; Tue, 28 Oct 2025 03:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeXS-0007CH-5y
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:54:45 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeXM-0007pv-Ff
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:54:41 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b85so5752571f8f.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 00:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761638074; x=1762242874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iEXf1iTNvju/0qCkmlIbqPXceBSmDEb0O/+ERD/Eqbk=;
 b=mPVGqusQ/fZP5WIFHoFOQggtP1F2/FSQak0WJDUuOMxnASoEL09c/rhyaUT0BdaeJp
 1TNS/0xCqErqIOHGtme0nZvO62kNp9MqSFUv8o7Uy59c60v+CFbHStt76NEGKKb1vLTE
 x+92tWPCUHIQnzZeKPBp/gLcy8Z2fbULiScVD9i1TR4joadmhROHnWCmYyJ9Dyc4eWag
 16aKjwaUWt6bADok9xc6S4KNuouqRZTztafDujKqiszI06zAeMw5e7FTIRDP8E7arhr3
 nX4PrDlr3YQZdRTdeuguUfIotSQGdC3mAuqWd5jVgmSlGBfuPGUWSSq5ihAZ057aJwPU
 3QDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761638074; x=1762242874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iEXf1iTNvju/0qCkmlIbqPXceBSmDEb0O/+ERD/Eqbk=;
 b=Uv8WSM3mtZ/VUEPGxZbyZxUG/TC/et293HqlMBOwGpMn1XTN69E0afBTJgwGl801U5
 yTuNGx1dXv1ChOSs+nW86/c4N5Rd+zilxXneMk8wAYtp1oPTdNRhP+VPAj8/ZAoaE1ek
 afi6iFbKokZCCpZGMPga0YQ0qxDUQC9hXSMLNZJsvDhLhKxbMp5yITas+XehXLvM4psT
 Iu4HkMrpXGAnRB1Z81SMoleKrLlcSAHU2V0MQiyD5pz68bDEuWXhCGV7cnz8SRWR0JwL
 VGVO3aGhF4xTMolAaKtasYMtlGoKMYROW1yqIQBIWESIa/RH4+2Vfz8eZkaZlKKvTxYa
 vHbg==
X-Gm-Message-State: AOJu0YyBl8EyvmtxaQ1ZcRW3793WsVrV5f4Rhle7vyfSXSVREGi7smWP
 6zijoCQUX+mrmFf///WQv9vPs8C+XUxyGCld92wAncOATgmVaZj68I5lwX77+US0JqxwlgQjBwx
 U7S0xI0c=
X-Gm-Gg: ASbGncsY/LvOLoBzbs9NF7Tav+viA9Xq9t2bLWuRyx9bByJ7RlX4rlGzh9LfFXYGpdR
 KtZA/tVESINSlGsZcTwCDcSXQE3jHZqJMiI6l1hEhWyKAA/7HVcq4LaJX/Dq7OCtq7DXElZT2xc
 h9GWvrh2W4Y1+t8aGwmLNpayBkUaaOEGZyRdc0lIWmmsug5Cm64tN3QZOX9RKv+K0Fx6C4SGxkS
 n9+Er0hsNU5tczoThN++BAAw//V55EE/EAKSkNauQ/VNDzK79CdrNMRJ7ByrtNw4iOhqB7dBTbl
 jKw0xrnTGO1MPKvAFlc1Gqad5pRy+pOT2M7Fi5J6E53D5wlQDQSR8jjdj4X4SBY1r+iUELAX5J0
 ToHScc6QUOqssrzEpAz/dFWujvCnLnc0y9EIoGNABChereyulgo2v0cvV1mR0VbvjCqNAzWta8W
 xn7ap0dRjK8/mYgt4aFmX6fAnTf2me9+xTkNGj5KnDQYzxs7T9ppa7kgk=
X-Google-Smtp-Source: AGHT+IFf13OU1ZPusAWSPVHihsiwy391vLPhdFrs6JeMIwxTttzkkwHZp/kMhWxFQJCzm2Y24v+pZQ==
X-Received: by 2002:a05:6000:2406:b0:427:847:9d59 with SMTP id
 ffacd0b85a97d-429a7e7a6c4mr2205809f8f.45.1761638073322; 
 Tue, 28 Oct 2025 00:54:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d5c9dsm19503426f8f.26.2025.10.28.00.54.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 00:54:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Vishal Chourasia <vishalc@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aditya Gupta <adityag@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Antony Pavlov <antonynpavlov@gmail.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Corey Minyard <minyard@acm.org>, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <paulburton@kernel.org>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Stafford Horne <shorne@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Magnus Damm <magnus.damm@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Subject: [PULL 15/23] hw/core/loader: capture Error from load_image_targphys
Date: Tue, 28 Oct 2025 08:48:51 +0100
Message-ID: <20251028074901.22062-16-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028074901.22062-1-philmd@linaro.org>
References: <20251028074901.22062-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

From: Vishal Chourasia <vishalc@linux.ibm.com>

Add Error **errp parameter to load_image_targphys(),
load_image_targphys_as(), and get_image_size() to enable better
error reporting when image loading fails.

Pass NULL for errp in all existing call sites to maintain current
behavior. No functional change intended in this patch.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Tested-by: Aditya Gupta <adityag@linux.ibm.com>
Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
Message-ID: <20251024130556.1942835-6-vishalc@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/loader.h      |  8 +++++---
 hw/alpha/dp264.c         |  4 ++--
 hw/arm/armv7m.c          |  2 +-
 hw/arm/boot.c            |  5 +++--
 hw/arm/digic_boards.c    |  2 +-
 hw/arm/highbank.c        |  3 ++-
 hw/arm/raspi.c           |  2 +-
 hw/arm/vexpress.c        |  2 +-
 hw/core/generic-loader.c |  3 ++-
 hw/core/guest-loader.c   |  2 +-
 hw/core/loader.c         | 16 +++++++++-------
 hw/hppa/machine.c        |  5 +++--
 hw/i386/multiboot.c      |  2 +-
 hw/i386/x86-common.c     |  4 ++--
 hw/ipmi/ipmi_bmc_sim.c   |  2 +-
 hw/loongarch/boot.c      |  5 ++---
 hw/m68k/an5206.c         |  2 +-
 hw/m68k/mcf5208.c        |  4 ++--
 hw/m68k/next-cube.c      |  2 +-
 hw/m68k/q800.c           |  7 ++++---
 hw/m68k/virt.c           |  4 ++--
 hw/microblaze/boot.c     |  5 +++--
 hw/mips/boston.c         |  2 +-
 hw/mips/fuloong2e.c      |  9 +++++----
 hw/mips/jazz.c           |  2 +-
 hw/mips/loongson3_virt.c | 10 ++++++----
 hw/mips/malta.c          |  9 +++++----
 hw/nubus/nubus-device.c  |  2 +-
 hw/openrisc/boot.c       |  5 +++--
 hw/pci/pci.c             |  2 +-
 hw/ppc/amigaone.c        |  4 ++--
 hw/ppc/e500.c            |  5 +++--
 hw/ppc/mac_newworld.c    |  9 ++++++---
 hw/ppc/mac_oldworld.c    |  9 ++++++---
 hw/ppc/pegasos2.c        |  5 +++--
 hw/ppc/pnv.c             |  9 ++++++---
 hw/ppc/ppc440_bamboo.c   |  3 ++-
 hw/ppc/prep.c            |  8 +++++---
 hw/ppc/sam460ex.c        |  3 ++-
 hw/ppc/spapr.c           |  8 ++++----
 hw/ppc/virtex_ml507.c    |  5 +++--
 hw/riscv/boot.c          |  7 ++++---
 hw/rx/rx-gdbsim.c        |  2 +-
 hw/s390x/ipl.c           |  8 +++++---
 hw/sh4/r2d.c             |  8 +++++---
 hw/smbios/smbios.c       |  2 +-
 hw/sparc/leon3.c         |  4 ++--
 hw/sparc/sun4m.c         |  8 +++++---
 hw/sparc64/sun4u.c       |  7 ++++---
 hw/xtensa/xtfpga.c       |  3 ++-
 system/device_tree.c     |  2 +-
 51 files changed, 145 insertions(+), 106 deletions(-)

diff --git a/include/hw/loader.h b/include/hw/loader.h
index c96b5e141c6..d035e72748a 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -1,6 +1,7 @@
 #ifndef LOADER_H
 #define LOADER_H
 #include "hw/nvram/fw_cfg.h"
+#include "qemu/typedefs.h"
 
 /* loader.c */
 /**
@@ -10,7 +11,7 @@
  * Returns the size of the image file on success, -1 otherwise.
  * On error, errno is also set as appropriate.
  */
-int64_t get_image_size(const char *filename);
+int64_t get_image_size(const char *filename, Error **errp);
 /**
  * load_image_size: load an image file into specified buffer
  * @filename: Path to the image file
@@ -41,7 +42,8 @@ ssize_t load_image_size(const char *filename, void *addr, size_t size);
  * Returns the size of the loaded image on success, -1 otherwise.
  */
 ssize_t load_image_targphys_as(const char *filename,
-                               hwaddr addr, uint64_t max_sz, AddressSpace *as);
+                               hwaddr addr, uint64_t max_sz, AddressSpace *as,
+                               Error **errp);
 
 /**load_targphys_hex_as:
  * @filename: Path to the .hex file
@@ -61,7 +63,7 @@ ssize_t load_targphys_hex_as(const char *filename, hwaddr *entry,
  * an AddressSpace.
  */
 ssize_t load_image_targphys(const char *filename, hwaddr,
-                            uint64_t max_sz);
+                            uint64_t max_sz, Error **errp);
 
 /**
  * load_image_mr: load an image into a memory region
diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 19562b59674..b6155646ef7 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -182,7 +182,7 @@ static void clipper_init(MachineState *machine)
             long initrd_base;
             int64_t initrd_size;
 
-            initrd_size = get_image_size(initrd_filename);
+            initrd_size = get_image_size(initrd_filename, NULL);
             if (initrd_size < 0) {
                 error_report("could not load initial ram disk '%s'",
                              initrd_filename);
@@ -192,7 +192,7 @@ static void clipper_init(MachineState *machine)
             /* Put the initrd image as high in memory as possible.  */
             initrd_base = (ram_size - initrd_size) & TARGET_PAGE_MASK;
             load_image_targphys(initrd_filename, initrd_base,
-                                ram_size - initrd_base);
+                                ram_size - initrd_base, NULL);
 
             address_space_stq(&address_space_memory, param_offset + 0x100,
                               initrd_base + 0xfffffc0000000000ULL,
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index cea3eb49ee5..c4a9c3ac529 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -611,7 +611,7 @@ void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename,
                                  NULL, ELFDATA2LSB, EM_ARM, 1, 0, as);
         if (image_size < 0) {
             image_size = load_image_targphys_as(kernel_filename, mem_base,
-                                                mem_size, as);
+                                                mem_size, as, NULL);
         }
         if (image_size < 0) {
             error_report("Could not load kernel '%s'", kernel_filename);
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index e77d8679d88..b91660208f5 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -964,7 +964,8 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
         /* 32-bit ARM */
         entry = info->loader_start + KERNEL_LOAD_ADDR;
         kernel_size = load_image_targphys_as(info->kernel_filename, entry,
-                                             ram_end - KERNEL_LOAD_ADDR, as);
+                                             ram_end - KERNEL_LOAD_ADDR, as,
+                                             NULL);
         is_linux = 1;
         if (kernel_size >= 0) {
             image_low_addr = entry;
@@ -1025,7 +1026,7 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
                                                      info->initrd_start,
                                                      ram_end -
                                                      info->initrd_start,
-                                                     as);
+                                                     as, NULL);
             }
             if (initrd_size < 0) {
                 error_report("could not load initrd '%s'",
diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index 466b8b84c0e..de56991baca 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -97,7 +97,7 @@ static void digic_load_rom(DigicState *s, hwaddr addr,
             exit(1);
         }
 
-        rom_size = load_image_targphys(fn, addr, max_size);
+        rom_size = load_image_targphys(fn, addr, max_size, NULL);
         if (rom_size < 0 || rom_size > max_size) {
             error_report("Couldn't load rom image '%s'.", filename);
             exit(1);
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index 165c0b741a5..ff987467a99 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -235,7 +235,8 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
     if (machine->firmware != NULL) {
         sysboot_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, machine->firmware);
         if (sysboot_filename != NULL) {
-            if (load_image_targphys(sysboot_filename, 0xfff88000, 0x8000) < 0) {
+            if (load_image_targphys(sysboot_filename, 0xfff88000, 0x8000,
+                                    NULL) < 0) {
                 error_report("Unable to load %s", machine->firmware);
                 exit(1);
             }
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 9d9af63d654..fbf3e09c030 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -230,7 +230,7 @@ static void setup_boot(MachineState *machine, ARMCPU *cpu,
                              ? FIRMWARE_ADDR_2 : FIRMWARE_ADDR_3;
         /* load the firmware image (typically kernel.img) */
         r = load_image_targphys(machine->firmware, firmware_addr,
-                                ram_size - firmware_addr);
+                                ram_size - firmware_addr, NULL);
         if (r < 0) {
             error_report("Failed to load firmware from %s", machine->firmware);
             exit(1);
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 35f8d05ea17..60cd375fe75 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -578,7 +578,7 @@ static void vexpress_common_init(MachineState *machine)
             exit(1);
         }
         image_size = load_image_targphys(fn, map[VE_NORFLASH0],
-                                         VEXPRESS_FLASH_SIZE);
+                                         VEXPRESS_FLASH_SIZE, NULL);
         g_free(fn);
         if (image_size < 0) {
             error_report("Could not load ROM image '%s'", machine->firmware);
diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index e72bbde2a23..6689847c33f 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -148,7 +148,8 @@ static void generic_loader_realize(DeviceState *dev, Error **errp)
 
         if (size < 0 || s->force_raw) {
             /* Default to the maximum size being the machine's ram size */
-            size = load_image_targphys_as(s->file, s->addr, current_machine->ram_size, as);
+            size = load_image_targphys_as(s->file, s->addr,
+                    current_machine->ram_size, as, NULL);
         } else {
             s->addr = entry;
         }
diff --git a/hw/core/guest-loader.c b/hw/core/guest-loader.c
index 3db89d7a2e1..59f325ad9c5 100644
--- a/hw/core/guest-loader.c
+++ b/hw/core/guest-loader.c
@@ -101,7 +101,7 @@ static void guest_loader_realize(DeviceState *dev, Error **errp)
 
     /* Default to the maximum size being the machine's ram size */
     size = load_image_targphys_as(file, s->addr, current_machine->ram_size,
-                                  NULL);
+                                  NULL, NULL);
     if (size < 0) {
         error_setg(errp, "Cannot load specified image %s", file);
         return;
diff --git a/hw/core/loader.c b/hw/core/loader.c
index c9782d67e86..7aca4989ef0 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -48,6 +48,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qapi/type-helpers.h"
+#include "qemu/units.h"
 #include "trace.h"
 #include "hw/hw.h"
 #include "disas/disas.h"
@@ -70,11 +71,11 @@
 static int roms_loaded;
 
 /* return the size or -1 if error */
-int64_t get_image_size(const char *filename)
+int64_t get_image_size(const char *filename, Error **errp)
 {
     int fd;
     int64_t size;
-    fd = qemu_open(filename, O_RDONLY | O_BINARY, NULL);
+    fd = qemu_open(filename, O_RDONLY | O_BINARY, errp);
     if (fd < 0)
         return -1;
     size = lseek(fd, 0, SEEK_END);
@@ -118,18 +119,19 @@ ssize_t read_targphys(const char *name,
 }
 
 ssize_t load_image_targphys(const char *filename,
-                            hwaddr addr, uint64_t max_sz)
+                            hwaddr addr, uint64_t max_sz, Error **errp)
 {
-    return load_image_targphys_as(filename, addr, max_sz, NULL);
+    return load_image_targphys_as(filename, addr, max_sz, NULL, errp);
 }
 
 /* return the size or -1 if error */
 ssize_t load_image_targphys_as(const char *filename,
-                               hwaddr addr, uint64_t max_sz, AddressSpace *as)
+                               hwaddr addr, uint64_t max_sz, AddressSpace *as,
+                               Error **errp)
 {
     ssize_t size;
 
-    size = get_image_size(filename);
+    size = get_image_size(filename, errp);
     if (size < 0 || size > max_sz) {
         return -1;
     }
@@ -150,7 +152,7 @@ ssize_t load_image_mr(const char *filename, MemoryRegion *mr)
         return -1;
     }
 
-    size = get_image_size(filename);
+    size = get_image_size(filename, NULL);
 
     if (size < 0 || size > memory_region_size(mr)) {
         return -1;
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index cddca69b938..ba894f8b1e9 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -495,7 +495,7 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
             ram_addr_t initrd_base;
             int64_t initrd_size;
 
-            initrd_size = get_image_size(initrd_filename);
+            initrd_size = get_image_size(initrd_filename, NULL);
             if (initrd_size < 0) {
                 error_report("could not load initial ram disk '%s'",
                              initrd_filename);
@@ -516,7 +516,8 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
                 exit(1);
             }
 
-            load_image_targphys(initrd_filename, initrd_base, initrd_size);
+            load_image_targphys(initrd_filename, initrd_base, initrd_size,
+                                NULL);
             cpu[0]->env.initrd_base = initrd_base;
             cpu[0]->env.initrd_end  = initrd_base + initrd_size;
         }
diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index 6e6b96bc345..78690781b74 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -337,7 +337,7 @@ int load_multiboot(X86MachineState *x86ms,
                 *next_space = '\0';
             }
             mb_debug("multiboot loading module: %s", one_file);
-            mb_mod_length = get_image_size(one_file);
+            mb_mod_length = get_image_size(one_file, NULL);
             if (mb_mod_length < 0) {
                 error_report("Failed to open file '%s'", one_file);
                 exit(1);
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 7512be64d67..6e78f3d07d6 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -924,7 +924,7 @@ void x86_load_linux(X86MachineState *x86ms,
             exit(1);
         }
 
-        dtb_size = get_image_size(dtb_filename);
+        dtb_size = get_image_size(dtb_filename, NULL);
         if (dtb_size <= 0) {
             fprintf(stderr, "qemu: error reading dtb %s: %s\n",
                     dtb_filename, strerror(errno));
@@ -1025,7 +1025,7 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
     bios_name = MACHINE(x86ms)->firmware ?: default_firmware;
     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
     if (filename) {
-        bios_size = get_image_size(filename);
+        bios_size = get_image_size(filename, NULL);
     } else {
         bios_size = -1;
     }
diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 04e1dcd0e76..4604d632b1e 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -2211,7 +2211,7 @@ static void ipmi_fru_init(IPMIFru *fru)
         goto out;
     }
 
-    fsize = get_image_size(fru->filename);
+    fsize = get_image_size(fru->filename, NULL);
     if (fsize > 0) {
         size = QEMU_ALIGN_UP(fsize, fru->areasize);
         fru->data = g_malloc0(size);
diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 3dd48cb8aab..8857a049980 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -328,14 +328,13 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
     }
 
     if (info->initrd_filename) {
-        ssize_t initrd_size = get_image_size(info->initrd_filename);
-
+        ssize_t initrd_size = get_image_size(info->initrd_filename, NULL);
         if (initrd_size > 0) {
             initrd_offset = ROUND_UP(kernel_high + 4 * kernel_size, 64 * KiB);
             initrd_offset = alloc_initrd_memory(info, initrd_offset,
                                                 initrd_size);
             initrd_size = load_image_targphys(info->initrd_filename,
-                                              initrd_offset, initrd_size);
+                                              initrd_offset, initrd_size, NULL);
         }
 
         if (initrd_size == -1) {
diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index d97399b882b..ff21d7779e1 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -82,7 +82,7 @@ static void an5206_init(MachineState *machine)
     }
     if (kernel_size < 0) {
         kernel_size = load_image_targphys(kernel_filename, KERNEL_LOAD_ADDR,
-                                          ram_size - KERNEL_LOAD_ADDR);
+                                          ram_size - KERNEL_LOAD_ADDR, NULL);
         entry = KERNEL_LOAD_ADDR;
     }
     if (kernel_size < 0) {
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index 75cc076f787..4a585b231db 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -351,7 +351,7 @@ static void mcf5208evb_init(MachineState *machine)
             error_report("Could not find ROM image '%s'", machine->firmware);
             exit(1);
         }
-        if (load_image_targphys(fn, 0x0, ROM_SIZE) < 8) {
+        if (load_image_targphys(fn, 0x0, ROM_SIZE, NULL) < 8) {
             error_report("Could not load ROM image '%s'", machine->firmware);
             exit(1);
         }
@@ -380,7 +380,7 @@ static void mcf5208evb_init(MachineState *machine)
     }
     if (kernel_size < 0) {
         kernel_size = load_image_targphys(kernel_filename, 0x40000000,
-                                          ram_size);
+                                          ram_size, NULL);
         entry = 0x40000000;
     }
     if (kernel_size < 0) {
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 957644b2d1e..cfb2b319e5e 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -1325,7 +1325,7 @@ static void next_cube_init(MachineState *machine)
     memory_region_init_alias(&m->rom2, NULL, "next.rom2", &m->rom, 0x0,
                              0x20000);
     memory_region_add_subregion(sysmem, 0x0, &m->rom2);
-    if (load_image_targphys(bios_name, 0x01000000, 0x20000) < 8) {
+    if (load_image_targphys(bios_name, 0x01000000, 0x20000, NULL) < 8) {
         if (!qtest_enabled()) {
             error_report("Failed to load firmware '%s'.", bios_name);
         }
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 793b23f8155..b8676feb418 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -629,7 +629,7 @@ static void q800_machine_init(MachineState *machine)
 
         /* load initrd */
         if (initrd_filename) {
-            initrd_size = get_image_size(initrd_filename);
+            initrd_size = get_image_size(initrd_filename, NULL);
             if (initrd_size < 0) {
                 error_report("could not load initial ram disk '%s'",
                              initrd_filename);
@@ -638,7 +638,7 @@ static void q800_machine_init(MachineState *machine)
 
             initrd_base = (ram_size - initrd_size) & TARGET_PAGE_MASK;
             load_image_targphys(initrd_filename, initrd_base,
-                                ram_size - initrd_base);
+                                ram_size - initrd_base, NULL);
             BOOTINFO2(param_ptr, BI_RAMDISK, initrd_base,
                       initrd_size);
         } else {
@@ -668,7 +668,8 @@ static void q800_machine_init(MachineState *machine)
 
         /* Load MacROM binary */
         if (filename) {
-            bios_size = load_image_targphys(filename, MACROM_ADDR, MACROM_SIZE);
+            bios_size = load_image_targphys(filename, MACROM_ADDR, MACROM_SIZE,
+                                            NULL);
             g_free(filename);
         } else {
             bios_size = -1;
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 98cfe43c73a..3f65d915561 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -283,7 +283,7 @@ static void virt_init(MachineState *machine)
 
         /* load initrd */
         if (initrd_filename) {
-            initrd_size = get_image_size(initrd_filename);
+            initrd_size = get_image_size(initrd_filename, NULL);
             if (initrd_size < 0) {
                 error_report("could not load initial ram disk '%s'",
                              initrd_filename);
@@ -292,7 +292,7 @@ static void virt_init(MachineState *machine)
 
             initrd_base = (ram_size - initrd_size) & TARGET_PAGE_MASK;
             load_image_targphys(initrd_filename, initrd_base,
-                                ram_size - initrd_base);
+                                ram_size - initrd_base, NULL);
             BOOTINFO2(param_ptr, BI_RAMDISK, initrd_base,
                       initrd_size);
         } else {
diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
index 4a9c9df3181..ec38107f503 100644
--- a/hw/microblaze/boot.c
+++ b/hw/microblaze/boot.c
@@ -170,7 +170,7 @@ void microblaze_load_kernel(MicroBlazeCPU *cpu, bool is_little_endian,
         /* Not an ELF image nor an u-boot image, try a RAW image.  */
         if (kernel_size < 0) {
             kernel_size = load_image_targphys(kernel_filename, ddr_base,
-                                              ramsize);
+                                              ramsize, NULL);
             boot_info.bootstrap_pc = ddr_base;
             high = (ddr_base + kernel_size + 3) & ~3;
         }
@@ -189,7 +189,8 @@ void microblaze_load_kernel(MicroBlazeCPU *cpu, bool is_little_endian,
             if (initrd_size < 0) {
                 initrd_size = load_image_targphys(initrd_filename,
                                                   boot_info.initrd_start,
-                                                  ramsize - initrd_offset);
+                                                  ramsize - initrd_offset,
+                                                  NULL);
             }
             if (initrd_size < 0) {
                 error_report("could not load initrd '%s'",
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 149a263bd5a..0a3a827b5f6 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -778,7 +778,7 @@ static void boston_mach_init(MachineState *machine)
 
     if (machine->firmware) {
         fw_size = load_image_targphys(machine->firmware,
-                                      0x1fc00000, 4 * MiB);
+                                      0x1fc00000, 4 * MiB, NULL);
         if (fw_size == -1) {
             error_report("unable to load firmware image '%s'",
                           machine->firmware);
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index 2a8507b8b0a..5fe40eee65a 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -118,7 +118,7 @@ static uint64_t load_kernel(MIPSCPU *cpu)
     initrd_size = 0;
     initrd_offset = 0;
     if (loaderparams.initrd_filename) {
-        initrd_size = get_image_size(loaderparams.initrd_filename);
+        initrd_size = get_image_size(loaderparams.initrd_filename, NULL);
         if (initrd_size > 0) {
             initrd_offset = ROUND_UP(kernel_high, INITRD_PAGE_SIZE);
             if (initrd_offset + initrd_size > loaderparams.ram_size) {
@@ -127,8 +127,9 @@ static uint64_t load_kernel(MIPSCPU *cpu)
                 exit(1);
             }
             initrd_size = load_image_targphys(loaderparams.initrd_filename,
-                                              initrd_offset,
-                                              loaderparams.ram_size - initrd_offset);
+                                         initrd_offset,
+                                         loaderparams.ram_size - initrd_offset,
+                                         NULL);
         }
         if (initrd_size == (target_ulong) -1) {
             error_report("could not load initial ram disk '%s'",
@@ -264,7 +265,7 @@ static void mips_fuloong2e_init(MachineState *machine)
                                   machine->firmware ?: FULOONG_BIOSNAME);
         if (filename) {
             bios_size = load_image_targphys(filename, 0x1fc00000LL,
-                                            BIOS_SIZE);
+                                            BIOS_SIZE, NULL);
             g_free(filename);
         } else {
             bios_size = -1;
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index 7fb0b97a388..1d6bdc00917 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -245,7 +245,7 @@ static void mips_jazz_init(MachineState *machine,
                               machine->firmware ?: bios_name);
     if (filename) {
         bios_size = load_image_targphys(filename, 0xfff00000LL,
-                                        MAGNUM_BIOS_SIZE);
+                                        MAGNUM_BIOS_SIZE, NULL);
         g_free(filename);
     } else {
         bios_size = -1;
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 672083dec98..77dc895648f 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -371,7 +371,7 @@ static uint64_t load_kernel(CPUMIPSState *env)
     initrd_size = 0;
     initrd_offset = 0;
     if (loaderparams.initrd_filename) {
-        initrd_size = get_image_size(loaderparams.initrd_filename);
+        initrd_size = get_image_size(loaderparams.initrd_filename, NULL);
         if (initrd_size > 0) {
             initrd_offset = MAX(loader_memmap[LOADER_INITRD].base,
                                 ROUND_UP(kernel_high, INITRD_PAGE_SIZE));
@@ -383,8 +383,9 @@ static uint64_t load_kernel(CPUMIPSState *env)
             }
 
             initrd_size = load_image_targphys(loaderparams.initrd_filename,
-                                              initrd_offset,
-                                              loaderparams.ram_size - initrd_offset);
+                                        initrd_offset,
+                                        loaderparams.ram_size - initrd_offset,
+                                        NULL);
         }
 
         if (initrd_size == (target_ulong) -1) {
@@ -650,7 +651,8 @@ static void mips_loongson3_virt_init(MachineState *machine)
         if (filename) {
             bios_size = load_image_targphys(filename,
                                             virt_memmap[VIRT_BIOS_ROM].base,
-                                            virt_memmap[VIRT_BIOS_ROM].size);
+                                            virt_memmap[VIRT_BIOS_ROM].size,
+                                            NULL);
             g_free(filename);
         } else {
             bios_size = -1;
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 02da629b5af..806e8d50789 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -892,7 +892,7 @@ static uint64_t load_kernel(void)
     initrd_size = 0;
     initrd_offset = 0;
     if (loaderparams.initrd_filename) {
-        initrd_size = get_image_size(loaderparams.initrd_filename);
+        initrd_size = get_image_size(loaderparams.initrd_filename, NULL);
         if (initrd_size > 0) {
             /*
              * The kernel allocates the bootmap memory in the low memory after
@@ -908,8 +908,9 @@ static uint64_t load_kernel(void)
                 exit(1);
             }
             initrd_size = load_image_targphys(loaderparams.initrd_filename,
-                                              initrd_offset,
-                                              loaderparams.ram_size - initrd_offset);
+                                        initrd_offset,
+                                        loaderparams.ram_size - initrd_offset,
+                                        NULL);
         }
         if (initrd_size == (target_ulong) -1) {
             error_report("could not load initial ram disk '%s'",
@@ -1176,7 +1177,7 @@ void mips_malta_init(MachineState *machine)
                                       machine->firmware ?: bios_name);
             if (filename) {
                 bios_size = load_image_targphys(filename, FLASH_ADDRESS,
-                                                BIOS_SIZE);
+                                                BIOS_SIZE, NULL);
                 g_free(filename);
             } else {
                 bios_size = -1;
diff --git a/hw/nubus/nubus-device.c b/hw/nubus/nubus-device.c
index 7797e61c7fc..0d4d6c0d875 100644
--- a/hw/nubus/nubus-device.c
+++ b/hw/nubus/nubus-device.c
@@ -68,7 +68,7 @@ static void nubus_device_realize(DeviceState *dev, Error **errp)
             path = g_strdup(nd->romfile);
         }
 
-        size = get_image_size(path);
+        size = get_image_size(path, NULL);
         if (size < 0) {
             error_setg(errp, "failed to find romfile \"%s\"", nd->romfile);
             g_free(path);
diff --git a/hw/openrisc/boot.c b/hw/openrisc/boot.c
index c81efe8138a..db6fea071e8 100644
--- a/hw/openrisc/boot.c
+++ b/hw/openrisc/boot.c
@@ -44,7 +44,8 @@ hwaddr openrisc_load_kernel(ram_addr_t ram_size,
         if (kernel_size < 0) {
             kernel_size = load_image_targphys(kernel_filename,
                                               KERNEL_LOAD_ADDR,
-                                              ram_size - KERNEL_LOAD_ADDR);
+                                              ram_size - KERNEL_LOAD_ADDR,
+                                              NULL);
             high_addr = KERNEL_LOAD_ADDR + kernel_size;
         }
 
@@ -74,7 +75,7 @@ hwaddr openrisc_load_initrd(void *fdt, const char *filename,
 
     size = load_ramdisk(filename, start, mem_size - start);
     if (size < 0) {
-        size = load_image_targphys(filename, start, mem_size - start);
+        size = load_image_targphys(filename, start, mem_size - start, NULL);
         if (size < 0) {
             error_report("could not load ramdisk '%s'", filename);
             exit(1);
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index acc03fd4707..738b0c41ae5 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2557,7 +2557,7 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
             path = g_strdup(pdev->romfile);
         }
 
-        size = get_image_size(path);
+        size = get_image_size(path, NULL);
         if (size < 0) {
             error_setg(errp, "failed to find romfile \"%s\"", pdev->romfile);
             return;
diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 47fb016b4aa..192474e0aee 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -324,7 +324,7 @@ static void amigaone_init(MachineState *machine)
             error_report("Could not find firmware '%s'", machine->firmware);
             exit(1);
         }
-        sz = load_image_targphys(filename, PROM_ADDR, PROM_SIZE);
+        sz = load_image_targphys(filename, PROM_ADDR, PROM_SIZE, NULL);
         if (sz <= 0 || sz > PROM_SIZE) {
             error_report("Could not load firmware '%s'", filename);
             exit(1);
@@ -413,7 +413,7 @@ static void amigaone_init(MachineState *machine)
         loadaddr = ROUND_UP(loadaddr + 4 * MiB, 4 * KiB);
         loadaddr = MAX(loadaddr, INITRD_MIN_ADDR);
         sz = load_image_targphys(machine->initrd_filename, loadaddr,
-                                 bi->bd_info - loadaddr);
+                                 bi->bd_info - loadaddr, NULL);
         if (sz <= 0) {
             error_report("Could not load initrd '%s'",
                          machine->initrd_filename);
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 3d69428f31c..418e1bb2fb4 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -1227,7 +1227,7 @@ void ppce500_init(MachineState *machine)
         kernel_base = cur_base;
         kernel_size = load_image_targphys(machine->kernel_filename,
                                           cur_base,
-                                          machine->ram_size - cur_base);
+                                          machine->ram_size - cur_base, NULL);
         if (kernel_size < 0) {
             error_report("could not load kernel '%s'",
                          machine->kernel_filename);
@@ -1241,7 +1241,8 @@ void ppce500_init(MachineState *machine)
     if (machine->initrd_filename) {
         initrd_base = (cur_base + INITRD_LOAD_PAD) & ~INITRD_PAD_MASK;
         initrd_size = load_image_targphys(machine->initrd_filename, initrd_base,
-                                          machine->ram_size - initrd_base);
+                                          machine->ram_size - initrd_base,
+                                          NULL);
 
         if (initrd_size < 0) {
             error_report("could not load initial ram disk '%s'",
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 0b6e096116a..004efc6b97b 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -188,7 +188,8 @@ static void ppc_core99_init(MachineState *machine)
 
         if (bios_size <= 0) {
             /* or load binary ROM image */
-            bios_size = load_image_targphys(filename, PROM_BASE, PROM_SIZE);
+            bios_size = load_image_targphys(filename, PROM_BASE, PROM_SIZE,
+                                            NULL);
         }
         g_free(filename);
     }
@@ -210,7 +211,8 @@ static void ppc_core99_init(MachineState *machine)
         if (kernel_size < 0) {
             kernel_size = load_image_targphys(machine->kernel_filename,
                                               kernel_base,
-                                              machine->ram_size - kernel_base);
+                                              machine->ram_size - kernel_base,
+                                              NULL);
         }
         if (kernel_size < 0) {
             error_report("could not load kernel '%s'",
@@ -222,7 +224,8 @@ static void ppc_core99_init(MachineState *machine)
             initrd_base = TARGET_PAGE_ALIGN(kernel_base + kernel_size + KERNEL_GAP);
             initrd_size = load_image_targphys(machine->initrd_filename,
                                               initrd_base,
-                                              machine->ram_size - initrd_base);
+                                              machine->ram_size - initrd_base,
+                                              NULL);
             if (initrd_size < 0) {
                 error_report("could not load initial ram disk '%s'",
                              machine->initrd_filename);
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 40ae936ad8a..c7e44d49b07 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -143,7 +143,8 @@ static void ppc_heathrow_init(MachineState *machine)
 
         if (bios_size <= 0) {
             /* or if could not load ELF try loading a binary ROM image */
-            bios_size = load_image_targphys(filename, PROM_BASE, PROM_SIZE);
+            bios_size = load_image_targphys(filename, PROM_BASE, PROM_SIZE,
+                                            NULL);
             bios_addr = PROM_BASE;
         }
         g_free(filename);
@@ -166,7 +167,8 @@ static void ppc_heathrow_init(MachineState *machine)
         if (kernel_size < 0) {
             kernel_size = load_image_targphys(machine->kernel_filename,
                                               kernel_base,
-                                              machine->ram_size - kernel_base);
+                                              machine->ram_size - kernel_base,
+                                              NULL);
         }
         if (kernel_size < 0) {
             error_report("could not load kernel '%s'",
@@ -179,7 +181,8 @@ static void ppc_heathrow_init(MachineState *machine)
                                             KERNEL_GAP);
             initrd_size = load_image_targphys(machine->initrd_filename,
                                               initrd_base,
-                                              machine->ram_size - initrd_base);
+                                              machine->ram_size - initrd_base,
+                                              NULL);
             if (initrd_size < 0) {
                 error_report("could not load initial ram disk '%s'",
                              machine->initrd_filename);
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 93696ed381f..a9e706644c5 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -197,7 +197,8 @@ static void pegasos_init(MachineState *machine)
     sz = load_elf(filename, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
                   ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
     if (sz <= 0) {
-        sz = load_image_targphys(filename, pm->vof ? 0 : prom_addr, PROM_SIZE);
+        sz = load_image_targphys(filename, pm->vof ? 0 : prom_addr, PROM_SIZE,
+                                 NULL);
     }
     if (sz <= 0 || sz > PROM_SIZE) {
         error_report("Could not load firmware '%s'", filename);
@@ -301,7 +302,7 @@ static void pegasos_init(MachineState *machine)
         pm->initrd_addr = ROUND_UP(pm->initrd_addr, 4);
         pm->initrd_addr = MAX(pm->initrd_addr, INITRD_MIN_ADDR);
         sz = load_image_targphys(machine->initrd_filename, pm->initrd_addr,
-                                 machine->ram_size - pm->initrd_addr);
+                                 machine->ram_size - pm->initrd_addr, NULL);
         if (sz <= 0) {
             error_report("Could not load initrd '%s'",
                          machine->initrd_filename);
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index f0469cdb8b6..1c0dadda876 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1068,7 +1068,8 @@ static void pnv_init(MachineState *machine)
         exit(1);
     }
 
-    fw_size = load_image_targphys(fw_filename, pnv->fw_load_addr, FW_MAX_SIZE);
+    fw_size = load_image_targphys(fw_filename, pnv->fw_load_addr, FW_MAX_SIZE,
+                                  NULL);
     if (fw_size < 0) {
         error_report("Could not load OPAL firmware '%s'", fw_filename);
         exit(1);
@@ -1080,7 +1081,8 @@ static void pnv_init(MachineState *machine)
         long kernel_size;
 
         kernel_size = load_image_targphys(machine->kernel_filename,
-                                          KERNEL_LOAD_ADDR, KERNEL_MAX_SIZE);
+                                          KERNEL_LOAD_ADDR, KERNEL_MAX_SIZE,
+                                          NULL);
         if (kernel_size < 0) {
             error_report("Could not load kernel '%s'",
                          machine->kernel_filename);
@@ -1092,7 +1094,8 @@ static void pnv_init(MachineState *machine)
     if (machine->initrd_filename) {
         pnv->initrd_base = INITRD_LOAD_ADDR;
         pnv->initrd_size = load_image_targphys(machine->initrd_filename,
-                                  pnv->initrd_base, INITRD_MAX_SIZE);
+                                               pnv->initrd_base,
+                                               INITRD_MAX_SIZE, NULL);
         if (pnv->initrd_size < 0) {
             error_report("Could not load initial ram disk '%s'",
                          machine->initrd_filename);
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 6fff0d8afbc..7c66912c103 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -242,7 +242,8 @@ static void bamboo_init(MachineState *machine)
     /* Load initrd. */
     if (initrd_filename) {
         initrd_size = load_image_targphys(initrd_filename, RAMDISK_ADDR,
-                                          machine->ram_size - RAMDISK_ADDR);
+                                          machine->ram_size - RAMDISK_ADDR,
+                                          NULL);
 
         if (initrd_size < 0) {
             error_report("could not load ram disk '%s' at %x",
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index c730cb3429e..0759e95cb64 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -280,7 +280,7 @@ static void ibm_40p_init(MachineState *machine)
     bios_size = load_elf(filename, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
                          ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
     if (bios_size < 0) {
-        bios_size = load_image_targphys(filename, BIOS_ADDR, BIOS_SIZE);
+        bios_size = load_image_targphys(filename, BIOS_ADDR, BIOS_SIZE, NULL);
     }
     if (bios_size < 0 || bios_size > BIOS_SIZE) {
         error_report("Could not load bios image '%s'", filename);
@@ -379,7 +379,8 @@ static void ibm_40p_init(MachineState *machine)
         kernel_base = KERNEL_LOAD_ADDR;
         kernel_size = load_image_targphys(machine->kernel_filename,
                                           kernel_base,
-                                          machine->ram_size - kernel_base);
+                                          machine->ram_size - kernel_base,
+                                          NULL);
         if (kernel_size < 0) {
             error_report("could not load kernel '%s'",
                          machine->kernel_filename);
@@ -392,7 +393,8 @@ static void ibm_40p_init(MachineState *machine)
             initrd_base = INITRD_LOAD_ADDR;
             initrd_size = load_image_targphys(machine->initrd_filename,
                                               initrd_base,
-                                              machine->ram_size - initrd_base);
+                                              machine->ram_size - initrd_base,
+                                              NULL);
             if (initrd_size < 0) {
                 error_report("could not load initial ram disk '%s'",
                              machine->initrd_filename);
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index ee31bd8f349..68d3eacbff8 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -494,7 +494,8 @@ static void sam460ex_init(MachineState *machine)
     if (machine->initrd_filename) {
         initrd_size = load_image_targphys(machine->initrd_filename,
                                           RAMDISK_ADDR,
-                                          machine->ram_size - RAMDISK_ADDR);
+                                          machine->ram_size - RAMDISK_ADDR,
+                                          NULL);
         if (initrd_size < 0) {
             error_report("could not load ram disk '%s' at %x",
                     machine->initrd_filename, RAMDISK_ADDR);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 6764730beb4..cdf2fdeadc2 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2854,7 +2854,7 @@ static void spapr_machine_init(MachineState *machine)
         error_report("Could not find LPAR firmware '%s'", bios_name);
         exit(1);
     }
-    fw_size = load_image_targphys(filename, 0, FW_MAX_SIZE);
+    fw_size = load_image_targphys(filename, 0, FW_MAX_SIZE, NULL);
     if (fw_size <= 0) {
         error_report("Could not load LPAR firmware '%s'", filename);
         exit(1);
@@ -3115,9 +3115,9 @@ static void spapr_machine_init(MachineState *machine)
             spapr->initrd_base = (spapr->kernel_addr + spapr->kernel_size
                                   + 0x1ffff) & ~0xffff;
             spapr->initrd_size = load_image_targphys(initrd_filename,
-                                                     spapr->initrd_base,
-                                                     load_limit
-                                                     - spapr->initrd_base);
+                                                spapr->initrd_base,
+                                                load_limit - spapr->initrd_base,
+                                                NULL);
             if (spapr->initrd_size < 0) {
                 error_report("could not load initial ram disk '%s'",
                              initrd_filename);
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index c9969ae48a8..00d9ab75090 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -253,7 +253,7 @@ static void virtex_init(MachineState *machine)
             /* If we failed loading ELF's try a raw image.  */
             kernel_size = load_image_targphys(kernel_filename,
                                               boot_offset,
-                                              machine->ram_size);
+                                              machine->ram_size, NULL);
             boot_info.bootstrap_pc = boot_offset;
             high = boot_info.bootstrap_pc + kernel_size + 8192;
         }
@@ -264,7 +264,8 @@ static void virtex_init(MachineState *machine)
         if (machine->initrd_filename) {
             initrd_base = high = ROUND_UP(high, 4);
             initrd_size = load_image_targphys(machine->initrd_filename,
-                                              high, machine->ram_size - high);
+                                              high, machine->ram_size - high,
+                                              NULL);
 
             if (initrd_size < 0) {
                 error_report("couldn't load ram disk '%s'",
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 828a867be39..f38078c8c22 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -172,7 +172,8 @@ target_ulong riscv_load_firmware(const char *firmware_filename,
 
     firmware_size = load_image_targphys_as(firmware_filename,
                                            *firmware_load_addr,
-                                           current_machine->ram_size, NULL);
+                                           current_machine->ram_size, NULL,
+                                           NULL);
 
     if (firmware_size > 0) {
         return *firmware_load_addr + firmware_size;
@@ -207,7 +208,7 @@ static void riscv_load_initrd(MachineState *machine, RISCVBootInfo *info)
 
     size = load_ramdisk(filename, start, mem_size - start);
     if (size == -1) {
-        size = load_image_targphys(filename, start, mem_size - start);
+        size = load_image_targphys(filename, start, mem_size - start, NULL);
         if (size == -1) {
             error_report("could not load ramdisk '%s'", filename);
             exit(1);
@@ -262,7 +263,7 @@ void riscv_load_kernel(MachineState *machine,
     }
 
     kernel_size = load_image_targphys_as(kernel_filename, kernel_start_addr,
-                                         current_machine->ram_size, NULL);
+                                         current_machine->ram_size, NULL, NULL);
     if (kernel_size > 0) {
         info->kernel_size = kernel_size;
         info->image_low_addr = kernel_start_addr;
diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
index 5b9004e9e15..ed91c631788 100644
--- a/hw/rx/rx-gdbsim.c
+++ b/hw/rx/rx-gdbsim.c
@@ -63,7 +63,7 @@ static void rx_load_image(RXCPU *cpu, const char *filename,
     long kernel_size;
     int i;
 
-    kernel_size = load_image_targphys(filename, start, size);
+    kernel_size = load_image_targphys(filename, start, size, NULL);
     if (kernel_size < 0) {
         fprintf(stderr, "qemu: could not load kernel '%s'\n", filename);
         exit(1);
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 2f082396c73..3843d2a8505 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -169,7 +169,7 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
         } else {
             /* Try to load non-ELF file */
             bios_size = load_image_targphys(bios_filename, ZIPL_IMAGE_START,
-                                            4096);
+                                            4096, NULL);
             ipl->bios_start_addr = ZIPL_IMAGE_START;
         }
         g_free(bios_filename);
@@ -188,7 +188,8 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
                                &pentry, NULL,
                                NULL, NULL, ELFDATA2MSB, EM_S390, 0, 0);
         if (kernel_size < 0) {
-            kernel_size = load_image_targphys(ipl->kernel, 0, ms->ram_size);
+            kernel_size = load_image_targphys(ipl->kernel, 0, ms->ram_size,
+                                              NULL);
             if (kernel_size < 0) {
                 error_setg(errp, "could not load kernel '%s'", ipl->kernel);
                 return;
@@ -247,7 +248,8 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
                 initrd_offset += 0x100000;
             }
             initrd_size = load_image_targphys(ipl->initrd, initrd_offset,
-                                              ms->ram_size - initrd_offset);
+                                              ms->ram_size - initrd_offset,
+                                              NULL);
             if (initrd_size == -1) {
                 error_setg(errp, "could not load initrd '%s'", ipl->initrd);
                 return;
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index d68c94e82ef..010be6d5394 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -329,8 +329,9 @@ static void r2d_init(MachineState *machine)
         int kernel_size;
 
         kernel_size = load_image_targphys(kernel_filename,
-                                          SDRAM_BASE + LINUX_LOAD_OFFSET,
-                                          INITRD_LOAD_OFFSET - LINUX_LOAD_OFFSET);
+                                        SDRAM_BASE + LINUX_LOAD_OFFSET,
+                                        INITRD_LOAD_OFFSET - LINUX_LOAD_OFFSET,
+                                        NULL);
         if (kernel_size < 0) {
             error_report("qemu: could not load kernel '%s'", kernel_filename);
             exit(1);
@@ -350,7 +351,8 @@ static void r2d_init(MachineState *machine)
 
         initrd_size = load_image_targphys(initrd_filename,
                                           SDRAM_BASE + INITRD_LOAD_OFFSET,
-                                          SDRAM_SIZE - INITRD_LOAD_OFFSET);
+                                          SDRAM_SIZE - INITRD_LOAD_OFFSET,
+                                          NULL);
 
         if (initrd_size < 0) {
             error_report("qemu: could not load initrd '%s'", initrd_filename);
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 13e21a9c43e..7558b2ad839 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -1340,7 +1340,7 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
             return;
         }
 
-        size = get_image_size(val);
+        size = get_image_size(val, NULL);
         if (size == -1 || size < sizeof(struct smbios_structure_header)) {
             error_setg(errp, "Cannot read SMBIOS file %s", val);
             return;
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 09d2cec488c..631c6113b5c 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -349,7 +349,7 @@ static void leon3_generic_hw_init(MachineState *machine)
     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
 
     if (filename) {
-        bios_size = get_image_size(filename);
+        bios_size = get_image_size(filename, NULL);
     } else {
         bios_size = -1;
     }
@@ -360,7 +360,7 @@ static void leon3_generic_hw_init(MachineState *machine)
     }
 
     if (bios_size > 0) {
-        ret = load_image_targphys(filename, LEON3_PROM_OFFSET, bios_size);
+        ret = load_image_targphys(filename, LEON3_PROM_OFFSET, bios_size, NULL);
         if (ret < 0 || ret > prom_size) {
             error_report("could not load prom '%s'", filename);
             exit(1);
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 8ac7e625ef1..53d7ae08ae9 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -245,7 +245,8 @@ static unsigned long sun4m_load_kernel(const char *kernel_filename,
         if (kernel_size < 0)
             kernel_size = load_image_targphys(kernel_filename,
                                               KERNEL_LOAD_ADDR,
-                                              RAM_size - KERNEL_LOAD_ADDR);
+                                              RAM_size - KERNEL_LOAD_ADDR,
+                                              NULL);
         if (kernel_size < 0) {
             error_report("could not load kernel '%s'", kernel_filename);
             exit(1);
@@ -256,7 +257,8 @@ static unsigned long sun4m_load_kernel(const char *kernel_filename,
         if (initrd_filename) {
             *initrd_size = load_image_targphys(initrd_filename,
                                                INITRD_LOAD_ADDR,
-                                               RAM_size - INITRD_LOAD_ADDR);
+                                               RAM_size - INITRD_LOAD_ADDR,
+                                               NULL);
             if ((int)*initrd_size < 0) {
                 error_report("could not load initial ram disk '%s'",
                              initrd_filename);
@@ -700,7 +702,7 @@ static void prom_init(hwaddr addr, const char *bios_name)
                        translate_prom_address, &addr, NULL,
                        NULL, NULL, NULL, ELFDATA2MSB, EM_SPARC, 0, 0);
         if (ret < 0 || ret > PROM_SIZE_MAX) {
-            ret = load_image_targphys(filename, addr, PROM_SIZE_MAX);
+            ret = load_image_targphys(filename, addr, PROM_SIZE_MAX, NULL);
         }
         g_free(filename);
     } else {
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index e9f9b0a4cb9..82c3e7c855b 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -182,7 +182,8 @@ static uint64_t sun4u_load_kernel(const char *kernel_filename,
         if (kernel_size < 0) {
             kernel_size = load_image_targphys(kernel_filename,
                                               KERNEL_LOAD_ADDR,
-                                              RAM_size - KERNEL_LOAD_ADDR);
+                                              RAM_size - KERNEL_LOAD_ADDR,
+                                              NULL);
         }
         if (kernel_size < 0) {
             error_report("could not load kernel '%s'", kernel_filename);
@@ -195,7 +196,7 @@ static uint64_t sun4u_load_kernel(const char *kernel_filename,
 
             *initrd_size = load_image_targphys(initrd_filename,
                                                *initrd_addr,
-                                               RAM_size - *initrd_addr);
+                                               RAM_size - *initrd_addr, NULL);
             if ((int)*initrd_size < 0) {
                 error_report("could not load initial ram disk '%s'",
                              initrd_filename);
@@ -437,7 +438,7 @@ static void prom_init(hwaddr addr, const char *bios_name)
         ret = load_elf(filename, NULL, translate_prom_address, &addr,
                        NULL, NULL, NULL, NULL, ELFDATA2MSB, EM_SPARCV9, 0, 0);
         if (ret < 0 || ret > PROM_SIZE_MAX) {
-            ret = load_image_targphys(filename, addr, PROM_SIZE_MAX);
+            ret = load_image_targphys(filename, addr, PROM_SIZE_MAX, NULL);
         }
         g_free(filename);
     } else {
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 55de1a7a073..db3b0155495 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -381,7 +381,8 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
             if (initrd_size < 0) {
                 initrd_size = load_image_targphys(initrd_filename,
                                                   cur_lowmem,
-                                                  lowmem_end - cur_lowmem);
+                                                  lowmem_end - cur_lowmem,
+                                                  NULL);
             }
             if (initrd_size < 0) {
                 error_report("could not load initrd '%s'", initrd_filename);
diff --git a/system/device_tree.c b/system/device_tree.c
index aa3fe9516f3..7850b90fa72 100644
--- a/system/device_tree.c
+++ b/system/device_tree.c
@@ -83,7 +83,7 @@ void *load_device_tree(const char *filename_path, int *sizep)
     void *fdt = NULL;
 
     *sizep = 0;
-    dt_size = get_image_size(filename_path);
+    dt_size = get_image_size(filename_path, NULL);
     if (dt_size < 0) {
         error_report("Unable to get size of device tree file '%s'",
                      filename_path);
-- 
2.51.0


