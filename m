Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F65CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 07:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDeZ0-0000CH-Kd; Tue, 28 Oct 2025 03:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeYr-000063-8B
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:56:12 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeYn-00087u-7t
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:56:08 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4770e7062b5so16839325e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 00:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761638161; x=1762242961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lF28QKdT3RfIB/W6XCisIVlSd4+8PsjB71ZnMRL0G44=;
 b=ivBcSU9RnFxi955TK7RlYN8ToTS3/e6OnU0abUKzsfI98Vw0ziYgJuI8lsuyVeFRkH
 yM4sVuP8mN/fFt1eb3g1p+ej+wInjH+NIx6GpsK2EgLk8opyRqY5IozmIxGLBtzex3hj
 MsyKxxYVGNjm/tN0k7XAsdwZlD+SMcZswjnEPuovJ3ZDv8IZOwcwxSWqbQbHpcYhQVHL
 2teLA+79mT9luCk3bS2+8/N7PdWU93vJNZjqOGcC+UENkpa9Y+ky/vlybtnu3tIjhFGn
 +JpGZ1P1PRwo+4DZvCttaFKKrQzy+FeJoc77MfaXaDKFstxBfbo53bA38QrUUUx89Km6
 WNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761638161; x=1762242961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lF28QKdT3RfIB/W6XCisIVlSd4+8PsjB71ZnMRL0G44=;
 b=bvt9sXUemtmqJ320WrZcZdFcD9L2vZ+FxAHrZkJHLhsNIpgPQsz8O2zU6Z8j7bF3qF
 YOQl3t9zZ2rqwASRONtq3sZ9kSBJYhb0vHqohtKBDooK32FvXXj65S0Vo7+4KTcDHjM4
 ngvm7uxZJD+sWY/K0l9xPMKOYEV7F95e8qwPta9LAniC2yDk5QZNFWB3W4kzvNvFnu3k
 pyxYp6DqSSta7h98aBnsZQtMu0O6QC65Tsk+CSDqV+tU5eekQWxwAwpIlAriVTC4swE5
 V57jIJ/j58kmcuenHcQPL6vpy4mIXJwPNnJQyLFNAT4HqICCEQXS5013aSVSeif75RPN
 6I2w==
X-Gm-Message-State: AOJu0YwDUjTAM4Af6OMUX19CT58TSSeHGXjQcmOr+W8CyKC/wS2n5FOC
 8aa1bNCcPO9FcAZq0xhoDkK0uDPcffDtIDD80xqem5gJQ5GRNDn2k4DGWe8Wgqf8pgX30YOahRE
 jlyLU6q8=
X-Gm-Gg: ASbGncv4I/OgJb6Nc8X8DAFx+GApLeylC32GYKh9hp5gurmHV8aRB0LgrG5f/tHnosx
 256ZOvmlYTfvwCq1AGq6NkpDBtLRxzSpAiso7b7yhn3rcYfm/oSP+vZ2oIn+GXPs0JKfBmpLMBa
 cXPJPr/HjLcvpf7bFdGO3euaX7kYFNXqLwid/Tg7hDEWgK6xbJoI7ksMxe3CMacG6MRhKPwh142
 dMrwnaI8ING17iIWrCP0jQPOewTRaOO/f/ILTx3DVzGfvsGllde+Dk3IRv6fZcwdwmG4Vbth027
 u4N2QWEtI4wqCh2JLEoBJ0ZDVhLjFuhU7MZ5Cx2IFamEiWxLXA6UCekl7zpxaddnQ6I3Q4DQwNs
 Rlp4reZm1IgeQLXEJPBRsLNgydme5DCSRg1eI9TnElEahJWpHp0oLgeJKV7m85DH5zLxj1jXM/L
 qWvCnDWw8wBoLbJ4bROf1oFIsssqjOId422glcTy55XvHiYqEt1CDKJ1I=
X-Google-Smtp-Source: AGHT+IH97XIWgZ94XsCwA9YCZQjyfoTtiHGb4Jhygm3ekbasZL0s6GjW0oJcsAgz90j0ZINdWSweXg==
X-Received: by 2002:a05:600c:3b14:b0:46e:394b:49b7 with SMTP id
 5b1f17b1804b1-47717e7cca6mr18280415e9.37.1761638161087; 
 Tue, 28 Oct 2025 00:56:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd4783b8sm181131845e9.15.2025.10.28.00.55.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 00:56:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Vishal Chourasia <vishalc@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org
Subject: [PULL 19/23] hw/ppc: Pass error_fatal to load_image_targphys()
Date: Tue, 28 Oct 2025 08:48:55 +0100
Message-ID: <20251028074901.22062-20-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028074901.22062-1-philmd@linaro.org>
References: <20251028074901.22062-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Pass error_fatal to load_image_targphys() calls in ppc machine initialization
to capture detailed error information when loading firmware, kernel,
and initrd images.

Passing error_fatal automatically reports detailed error messages and
exits immediately on failure. Eliminating redundant exit(1) calls, as
error_fatal handles termination

The behavior remains functionally identical, but error messages now
come directly from the loader function with more context about the
failure cause.

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
Message-ID: <20251024130556.1942835-14-vishalc@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/amigaone.c      | 13 ++-----------
 hw/ppc/e500.c          | 19 +++----------------
 hw/ppc/mac_newworld.c  | 16 +++-------------
 hw/ppc/mac_oldworld.c  | 16 +++-------------
 hw/ppc/pegasos2.c      |  9 ++-------
 hw/ppc/pnv.c           | 28 +++++-----------------------
 hw/ppc/ppc440_bamboo.c |  8 +-------
 hw/ppc/prep.c          | 17 ++++-------------
 hw/ppc/sam460ex.c      |  7 +------
 hw/ppc/spapr.c         | 13 ++-----------
 hw/ppc/virtex_ml507.c  | 10 ++--------
 11 files changed, 28 insertions(+), 128 deletions(-)

diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 192474e0aee..74a1fa3b635 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -324,11 +324,7 @@ static void amigaone_init(MachineState *machine)
             error_report("Could not find firmware '%s'", machine->firmware);
             exit(1);
         }
-        sz = load_image_targphys(filename, PROM_ADDR, PROM_SIZE, NULL);
-        if (sz <= 0 || sz > PROM_SIZE) {
-            error_report("Could not load firmware '%s'", filename);
-            exit(1);
-        }
+        sz = load_image_targphys(filename, PROM_ADDR, PROM_SIZE, &error_fatal);
     }
 
     /* Articia S */
@@ -413,12 +409,7 @@ static void amigaone_init(MachineState *machine)
         loadaddr = ROUND_UP(loadaddr + 4 * MiB, 4 * KiB);
         loadaddr = MAX(loadaddr, INITRD_MIN_ADDR);
         sz = load_image_targphys(machine->initrd_filename, loadaddr,
-                                 bi->bd_info - loadaddr, NULL);
-        if (sz <= 0) {
-            error_report("Could not load initrd '%s'",
-                         machine->initrd_filename);
-            exit(1);
-        }
+                                 bi->bd_info - loadaddr, &error_fatal);
         bi->initrd_start = loadaddr;
         bi->initrd_end = loadaddr + sz;
     }
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 418e1bb2fb4..8842f7f6b88 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -1226,14 +1226,8 @@ void ppce500_init(MachineState *machine)
     if (machine->kernel_filename && !kernel_as_payload) {
         kernel_base = cur_base;
         kernel_size = load_image_targphys(machine->kernel_filename,
-                                          cur_base,
-                                          machine->ram_size - cur_base, NULL);
-        if (kernel_size < 0) {
-            error_report("could not load kernel '%s'",
-                         machine->kernel_filename);
-            exit(1);
-        }
-
+                                      cur_base, machine->ram_size - cur_base,
+                                      &error_fatal);
         cur_base += kernel_size;
     }
 
@@ -1242,14 +1236,7 @@ void ppce500_init(MachineState *machine)
         initrd_base = (cur_base + INITRD_LOAD_PAD) & ~INITRD_PAD_MASK;
         initrd_size = load_image_targphys(machine->initrd_filename, initrd_base,
                                           machine->ram_size - initrd_base,
-                                          NULL);
-
-        if (initrd_size < 0) {
-            error_report("could not load initial ram disk '%s'",
-                         machine->initrd_filename);
-            exit(1);
-        }
-
+                                          &error_fatal);
         cur_base = initrd_base + initrd_size;
     }
 
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 004efc6b97b..951de4bae4b 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -189,7 +189,7 @@ static void ppc_core99_init(MachineState *machine)
         if (bios_size <= 0) {
             /* or load binary ROM image */
             bios_size = load_image_targphys(filename, PROM_BASE, PROM_SIZE,
-                                            NULL);
+                                            &error_fatal);
         }
         g_free(filename);
     }
@@ -212,12 +212,7 @@ static void ppc_core99_init(MachineState *machine)
             kernel_size = load_image_targphys(machine->kernel_filename,
                                               kernel_base,
                                               machine->ram_size - kernel_base,
-                                              NULL);
-        }
-        if (kernel_size < 0) {
-            error_report("could not load kernel '%s'",
-                         machine->kernel_filename);
-            exit(1);
+                                              &error_fatal);
         }
         /* load initrd */
         if (machine->initrd_filename) {
@@ -225,12 +220,7 @@ static void ppc_core99_init(MachineState *machine)
             initrd_size = load_image_targphys(machine->initrd_filename,
                                               initrd_base,
                                               machine->ram_size - initrd_base,
-                                              NULL);
-            if (initrd_size < 0) {
-                error_report("could not load initial ram disk '%s'",
-                             machine->initrd_filename);
-                exit(1);
-            }
+                                              &error_fatal);
             cmdline_base = TARGET_PAGE_ALIGN(initrd_base + initrd_size);
         } else {
             cmdline_base = TARGET_PAGE_ALIGN(kernel_base + kernel_size + KERNEL_GAP);
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index c7e44d49b07..cd2bb46442f 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -144,7 +144,7 @@ static void ppc_heathrow_init(MachineState *machine)
         if (bios_size <= 0) {
             /* or if could not load ELF try loading a binary ROM image */
             bios_size = load_image_targphys(filename, PROM_BASE, PROM_SIZE,
-                                            NULL);
+                                            &error_fatal);
             bios_addr = PROM_BASE;
         }
         g_free(filename);
@@ -168,12 +168,7 @@ static void ppc_heathrow_init(MachineState *machine)
             kernel_size = load_image_targphys(machine->kernel_filename,
                                               kernel_base,
                                               machine->ram_size - kernel_base,
-                                              NULL);
-        }
-        if (kernel_size < 0) {
-            error_report("could not load kernel '%s'",
-                         machine->kernel_filename);
-            exit(1);
+                                              &error_fatal);
         }
         /* load initrd */
         if (machine->initrd_filename) {
@@ -182,12 +177,7 @@ static void ppc_heathrow_init(MachineState *machine)
             initrd_size = load_image_targphys(machine->initrd_filename,
                                               initrd_base,
                                               machine->ram_size - initrd_base,
-                                              NULL);
-            if (initrd_size < 0) {
-                error_report("could not load initial ram disk '%s'",
-                             machine->initrd_filename);
-                exit(1);
-            }
+                                              &error_fatal);
             cmdline_base = TARGET_PAGE_ALIGN(initrd_base + initrd_size);
         } else {
             cmdline_base = TARGET_PAGE_ALIGN(kernel_base + kernel_size + KERNEL_GAP);
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index a9e706644c5..3c02c53c3aa 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -198,7 +198,7 @@ static void pegasos_init(MachineState *machine)
                   ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
     if (sz <= 0) {
         sz = load_image_targphys(filename, pm->vof ? 0 : prom_addr, PROM_SIZE,
-                                 NULL);
+                                 &error_fatal);
     }
     if (sz <= 0 || sz > PROM_SIZE) {
         error_report("Could not load firmware '%s'", filename);
@@ -302,12 +302,7 @@ static void pegasos_init(MachineState *machine)
         pm->initrd_addr = ROUND_UP(pm->initrd_addr, 4);
         pm->initrd_addr = MAX(pm->initrd_addr, INITRD_MIN_ADDR);
         sz = load_image_targphys(machine->initrd_filename, pm->initrd_addr,
-                                 machine->ram_size - pm->initrd_addr, NULL);
-        if (sz <= 0) {
-            error_report("Could not load initrd '%s'",
-                         machine->initrd_filename);
-            exit(1);
-        }
+                            machine->ram_size - pm->initrd_addr, &error_fatal);
         pm->initrd_size = sz;
     }
 
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 1c0dadda876..895132da91b 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1009,7 +1009,6 @@ static void pnv_init(MachineState *machine)
     PnvMachineClass *pmc = PNV_MACHINE_GET_CLASS(machine);
     int max_smt_threads = pmc->max_smt_threads;
     char *fw_filename;
-    long fw_size;
     uint64_t chip_ram_start = 0;
     int i;
     char *chip_typename;
@@ -1068,26 +1067,14 @@ static void pnv_init(MachineState *machine)
         exit(1);
     }
 
-    fw_size = load_image_targphys(fw_filename, pnv->fw_load_addr, FW_MAX_SIZE,
-                                  NULL);
-    if (fw_size < 0) {
-        error_report("Could not load OPAL firmware '%s'", fw_filename);
-        exit(1);
-    }
+    load_image_targphys(fw_filename, pnv->fw_load_addr, FW_MAX_SIZE,
+                        &error_fatal);
     g_free(fw_filename);
 
     /* load kernel */
     if (machine->kernel_filename) {
-        long kernel_size;
-
-        kernel_size = load_image_targphys(machine->kernel_filename,
-                                          KERNEL_LOAD_ADDR, KERNEL_MAX_SIZE,
-                                          NULL);
-        if (kernel_size < 0) {
-            error_report("Could not load kernel '%s'",
-                         machine->kernel_filename);
-            exit(1);
-        }
+        load_image_targphys(machine->kernel_filename,
+                            KERNEL_LOAD_ADDR, KERNEL_MAX_SIZE, &error_fatal);
     }
 
     /* load initrd */
@@ -1095,12 +1082,7 @@ static void pnv_init(MachineState *machine)
         pnv->initrd_base = INITRD_LOAD_ADDR;
         pnv->initrd_size = load_image_targphys(machine->initrd_filename,
                                                pnv->initrd_base,
-                                               INITRD_MAX_SIZE, NULL);
-        if (pnv->initrd_size < 0) {
-            error_report("Could not load initial ram disk '%s'",
-                         machine->initrd_filename);
-            exit(1);
-        }
+                                               INITRD_MAX_SIZE, &error_fatal);
     }
 
     /* load dtb if passed */
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 7c66912c103..7e739a21147 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -243,13 +243,7 @@ static void bamboo_init(MachineState *machine)
     if (initrd_filename) {
         initrd_size = load_image_targphys(initrd_filename, RAMDISK_ADDR,
                                           machine->ram_size - RAMDISK_ADDR,
-                                          NULL);
-
-        if (initrd_size < 0) {
-            error_report("could not load ram disk '%s' at %x",
-                         initrd_filename, RAMDISK_ADDR);
-            exit(1);
-        }
+                                          &error_fatal);
     }
 
     /* If we're loading a kernel directly, we must load the device tree too. */
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 0759e95cb64..c2fe16e985a 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -280,7 +280,8 @@ static void ibm_40p_init(MachineState *machine)
     bios_size = load_elf(filename, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
                          ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
     if (bios_size < 0) {
-        bios_size = load_image_targphys(filename, BIOS_ADDR, BIOS_SIZE, NULL);
+        bios_size = load_image_targphys(filename, BIOS_ADDR, BIOS_SIZE,
+                                        &error_fatal);
     }
     if (bios_size < 0 || bios_size > BIOS_SIZE) {
         error_report("Could not load bios image '%s'", filename);
@@ -380,12 +381,7 @@ static void ibm_40p_init(MachineState *machine)
         kernel_size = load_image_targphys(machine->kernel_filename,
                                           kernel_base,
                                           machine->ram_size - kernel_base,
-                                          NULL);
-        if (kernel_size < 0) {
-            error_report("could not load kernel '%s'",
-                         machine->kernel_filename);
-            exit(1);
-        }
+                                          &error_fatal);
         fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, kernel_base);
         fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, kernel_size);
         /* load initrd */
@@ -394,12 +390,7 @@ static void ibm_40p_init(MachineState *machine)
             initrd_size = load_image_targphys(machine->initrd_filename,
                                               initrd_base,
                                               machine->ram_size - initrd_base,
-                                              NULL);
-            if (initrd_size < 0) {
-                error_report("could not load initial ram disk '%s'",
-                             machine->initrd_filename);
-                exit(1);
-            }
+                                              &error_fatal);
             fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, initrd_base);
             fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
         }
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 68d3eacbff8..258d43f8d2d 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -495,12 +495,7 @@ static void sam460ex_init(MachineState *machine)
         initrd_size = load_image_targphys(machine->initrd_filename,
                                           RAMDISK_ADDR,
                                           machine->ram_size - RAMDISK_ADDR,
-                                          NULL);
-        if (initrd_size < 0) {
-            error_report("could not load ram disk '%s' at %x",
-                    machine->initrd_filename, RAMDISK_ADDR);
-            exit(1);
-        }
+                                          &error_fatal);
     }
 
     /* If we're loading a kernel directly, we must load the device tree too. */
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index cdf2fdeadc2..99b843ba2fa 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2854,11 +2854,7 @@ static void spapr_machine_init(MachineState *machine)
         error_report("Could not find LPAR firmware '%s'", bios_name);
         exit(1);
     }
-    fw_size = load_image_targphys(filename, 0, FW_MAX_SIZE, NULL);
-    if (fw_size <= 0) {
-        error_report("Could not load LPAR firmware '%s'", filename);
-        exit(1);
-    }
+    fw_size = load_image_targphys(filename, 0, FW_MAX_SIZE, &error_fatal);
 
     /*
      * if Secure VM (PEF) support is configured, then initialize it
@@ -3117,12 +3113,7 @@ static void spapr_machine_init(MachineState *machine)
             spapr->initrd_size = load_image_targphys(initrd_filename,
                                                 spapr->initrd_base,
                                                 load_limit - spapr->initrd_base,
-                                                NULL);
-            if (spapr->initrd_size < 0) {
-                error_report("could not load initial ram disk '%s'",
-                             initrd_filename);
-                exit(1);
-            }
+                                                &error_fatal);
         }
     }
 
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 00d9ab75090..43a6d505a84 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -253,7 +253,7 @@ static void virtex_init(MachineState *machine)
             /* If we failed loading ELF's try a raw image.  */
             kernel_size = load_image_targphys(kernel_filename,
                                               boot_offset,
-                                              machine->ram_size, NULL);
+                                              machine->ram_size, &error_fatal);
             boot_info.bootstrap_pc = boot_offset;
             high = boot_info.bootstrap_pc + kernel_size + 8192;
         }
@@ -265,13 +265,7 @@ static void virtex_init(MachineState *machine)
             initrd_base = high = ROUND_UP(high, 4);
             initrd_size = load_image_targphys(machine->initrd_filename,
                                               high, machine->ram_size - high,
-                                              NULL);
-
-            if (initrd_size < 0) {
-                error_report("couldn't load ram disk '%s'",
-                             machine->initrd_filename);
-                exit(1);
-            }
+                                              &error_fatal);
             high = ROUND_UP(high + initrd_size, 4);
         }
 
-- 
2.51.0


