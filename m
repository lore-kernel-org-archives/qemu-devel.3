Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179ABC28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzKP-0007RK-EZ; Tue, 11 Mar 2025 09:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzFG-0006Hj-2C; Tue, 11 Mar 2025 09:02:09 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzFD-0000NY-UW; Tue, 11 Mar 2025 09:02:05 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ff6a98c638so10165510a91.0; 
 Tue, 11 Mar 2025 06:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698119; x=1742302919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iy9MYT8fdEi9vMpgSjXfvO+etPc3lGZwDZWPx6oNxPs=;
 b=ZgUxvN2GDTbONgbtd5S93LMiXrGOdwobqPLcLN7+1MoCUGQcGtc/FhwLP2ypxMK1Yz
 50wEN3M04V9aIPdQ0mDt6QXDDgqAi40tSxFQJUnMuq7hqy1tQc3oBsXmBMsIC0OEYVXa
 RY+V0Hy8bjujuec9dnI5vEbqZyGPxcQ/cfzNWUT0TL0MK7lnd61IACmT7jtcmyPVFBGT
 6CJJHGtEzuv+4NwJ3aVWt6Pgpj+pPUvXEj4rpjqmotQKzLD6r3ESdyMipxCJQApPjIlt
 PpLVZADgnGNPbdrFMFVqiFOqG9DNOvPAzUCblnsRWa4Bgpkjzdpc0RrgpzAjvPMRFJdx
 pRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698119; x=1742302919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iy9MYT8fdEi9vMpgSjXfvO+etPc3lGZwDZWPx6oNxPs=;
 b=fw7rqkscA0T2kIeFxmEc68PYC0wgJtMnhSsWV5LyDOt7DalTwFhia5N37TZ74z2jLY
 9J8up8I3NvoImNJ9/T2KtF2czz+JbYdcQTZHmU0K91vkBGC8wGa6RfPABjR64EdRx9ey
 IImgvBYrUTllp4lfvWpu74Ozp13/cKjEOGU27xAI3STYS2Ej8+cuuW49n6oIfovFC7Gq
 2TJb755HaVdIGZ+godcyQlNberzK9GZHFEedfdDadQkWZhal5bRinElU1JrP4cQJ5LBx
 c1Dx0AeVNXQFxBTdFHHsHpHoWVfjrYD2idEwSTZCQwcLwJZ2C9oKSj1BSRwEkLzjwpcZ
 STNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYewsH9Tz2yTo3mHO1SGifXxjICjhJCQFcW5aVGKy+vpp3R+IuR7r02LB6p3Z1o1xWrDCjM8JffA==@nongnu.org
X-Gm-Message-State: AOJu0YxCPQ78b4JJ0E0pQfG3KwgKuEAvD+zIhRy2OJnCS/FBc95CZQN2
 th2unRDLJNHBl1tyzYJJMUe3YeVaEkT01aiWZLW1MQ6MyuCCHVrI6OLeuQ==
X-Gm-Gg: ASbGncvOOzCmjlcACO+wafeaS0HME1mTGBDjmN9S3rZZH5J+RtPiXGCOO6/3LwH7XXG
 HKHTKO7C4006jnk+R2hmsbbUdRgEBtdvTQqU0yAiTdFZwyseB6XdU2ETfYbCpg0DpbUBECGoM3n
 4ouSsgPf2xYToe1jaYo64SPNZxl5RFNhPYG3JEpCos8U/gWAvEzTg+L+jweeQRgrwQwLKVZ2c0X
 P88Ij1vMMqbXiK3VK5KEtMpVj9hspvEZmsjgEKgeQ9gLS6NJKUrg1wb3ak+qJgksZeAOAEq0iyC
 /ZcOZI5TV65w0/1grwL79tQ76alsr6kXwoycIpw+DmCLXEFh/VI=
X-Google-Smtp-Source: AGHT+IFgqL9bbZ2fICseOPZfQrNrcT0fAz/HZJGis76AwygYFFwD63MWTP2pBrIZ4Xa8Fl8lXeX+CQ==
X-Received: by 2002:a17:90b:3ec2:b0:2ee:9e06:7db0 with SMTP id
 98e67ed59e1d1-2ff7ce6349emr28202121a91.11.1741698118226; 
 Tue, 11 Mar 2025 06:01:58 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:01:57 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 70/72] ppc/amigaone: Add kernel and initrd support
Date: Tue, 11 Mar 2025 22:58:04 +1000
Message-ID: <20250311125815.903177-71-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1029.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Add support for -kernel, -initrd and -append command line options.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <489b1be5d95d5153e924c95b0691b8b53f9ffb9e.1740673173.git.balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/amigaone.c | 113 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 112 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 1c6f2a944d..359f5fa125 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -25,11 +25,14 @@
 #include "system/qtest.h"
 #include "system/reset.h"
 #include "kvm_ppc.h"
+#include "elf.h"
 
 #include <zlib.h> /* for crc32 */
 
 #define BUS_FREQ_HZ 100000000
 
+#define INITRD_MIN_ADDR 0x600000
+
 /*
  * Firmware binary available at
  * https://www.hyperion-entertainment.com/index.php/downloads?view=files&parent=28
@@ -178,12 +181,68 @@ static const TypeInfo nvram_types[] = {
 };
 DEFINE_TYPES(nvram_types)
 
+struct boot_info {
+    hwaddr entry;
+    hwaddr stack;
+    hwaddr bd_info;
+    hwaddr initrd_start;
+    hwaddr initrd_end;
+    hwaddr cmdline_start;
+    hwaddr cmdline_end;
+};
+
+/* Board info struct from U-Boot */
+struct bd_info {
+    uint32_t bi_memstart;
+    uint32_t bi_memsize;
+    uint32_t bi_flashstart;
+    uint32_t bi_flashsize;
+    uint32_t bi_flashoffset;
+    uint32_t bi_sramstart;
+    uint32_t bi_sramsize;
+    uint32_t bi_bootflags;
+    uint32_t bi_ip_addr;
+    uint8_t  bi_enetaddr[6];
+    uint16_t bi_ethspeed;
+    uint32_t bi_intfreq;
+    uint32_t bi_busfreq;
+    uint32_t bi_baudrate;
+} QEMU_PACKED;
+
+static void create_bd_info(hwaddr addr, ram_addr_t ram_size)
+{
+    struct bd_info *bd = g_new0(struct bd_info, 1);
+
+    bd->bi_memsize =    cpu_to_be32(ram_size);
+    bd->bi_flashstart = cpu_to_be32(PROM_ADDR);
+    bd->bi_flashsize =  cpu_to_be32(1); /* match what U-Boot detects */
+    bd->bi_bootflags =  cpu_to_be32(1);
+    bd->bi_intfreq =    cpu_to_be32(11.5 * BUS_FREQ_HZ);
+    bd->bi_busfreq =    cpu_to_be32(BUS_FREQ_HZ);
+    bd->bi_baudrate =   cpu_to_be32(115200);
+
+    cpu_physical_memory_write(addr, bd, sizeof(*bd));
+}
+
 static void amigaone_cpu_reset(void *opaque)
 {
     PowerPCCPU *cpu = opaque;
+    CPUPPCState *env = &cpu->env;
 
     cpu_reset(CPU(cpu));
-    cpu_ppc_tb_reset(&cpu->env);
+    if (env->load_info) {
+        struct boot_info *bi = env->load_info;
+
+        env->gpr[1] = bi->stack;
+        env->gpr[2] = 1024;
+        env->gpr[3] = bi->bd_info;
+        env->gpr[4] = bi->initrd_start;
+        env->gpr[5] = bi->initrd_end;
+        env->gpr[6] = bi->cmdline_start;
+        env->gpr[7] = bi->cmdline_end;
+        env->nip = bi->entry;
+    }
+    cpu_ppc_tb_reset(env);
 }
 
 static void fix_spd_data(uint8_t *spd)
@@ -205,6 +264,8 @@ static void amigaone_init(MachineState *machine)
     I2CBus *i2c_bus;
     uint8_t *spd_data;
     DriveInfo *di;
+    hwaddr loadaddr;
+    struct boot_info *bi = NULL;
 
     /* init CPU */
     cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
@@ -301,6 +362,56 @@ static void amigaone_init(MachineState *machine)
     }
     pci_ide_create_devs(PCI_DEVICE(object_resolve_path_component(via, "ide")));
     pci_vga_init(pci_bus);
+
+    if (!machine->kernel_filename) {
+        return;
+    }
+
+    /* handle -kernel, -initrd, -append options and emulate U-Boot */
+    bi = g_new0(struct boot_info, 1);
+    cpu->env.load_info = bi;
+
+    loadaddr = MIN(machine->ram_size, 256 * MiB);
+    bi->bd_info = loadaddr - 8 * MiB;
+    create_bd_info(bi->bd_info, machine->ram_size);
+    bi->stack = bi->bd_info - 64 * KiB - 8;
+
+    if (machine->kernel_cmdline && machine->kernel_cmdline[0]) {
+        size_t len = strlen(machine->kernel_cmdline);
+
+        loadaddr = bi->bd_info + 1 * MiB;
+        cpu_physical_memory_write(loadaddr, machine->kernel_cmdline, len + 1);
+        bi->cmdline_start = loadaddr;
+        bi->cmdline_end = loadaddr + len + 1; /* including terminating '\0' */
+    }
+
+    sz = load_elf(machine->kernel_filename, NULL, NULL, NULL,
+                  &bi->entry, &loadaddr, NULL, NULL,
+                  ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
+    if (sz <= 0) {
+        sz = load_uimage(machine->kernel_filename, &bi->entry, &loadaddr,
+                         NULL, NULL, NULL);
+    }
+    if (sz <= 0) {
+        error_report("Could not load kernel '%s'",
+                     machine->kernel_filename);
+        exit(1);
+    }
+    loadaddr += sz;
+
+    if (machine->initrd_filename) {
+        loadaddr = ROUND_UP(loadaddr + 4 * MiB, 4 * KiB);
+        loadaddr = MAX(loadaddr, INITRD_MIN_ADDR);
+        sz = load_image_targphys(machine->initrd_filename, loadaddr,
+                                 bi->bd_info - loadaddr);
+        if (sz <= 0) {
+            error_report("Could not load initrd '%s'",
+                         machine->initrd_filename);
+            exit(1);
+        }
+        bi->initrd_start = loadaddr;
+        bi->initrd_end = loadaddr + sz;
+    }
 }
 
 static void amigaone_machine_init(MachineClass *mc)
-- 
2.47.1


