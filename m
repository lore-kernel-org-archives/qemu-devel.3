Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D3AD1268E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 06:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQg5e-0007cr-Ir; Wed, 03 Dec 2025 01:11:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQg5C-000795-SA
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 01:11:30 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQg5A-0001C7-7t
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 01:11:22 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-477a219db05so40869325e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 22:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764742277; x=1765347077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DE3yZ1NezYm9j02BHfqvoIAZcoZs87VQEmFWXloIjT8=;
 b=nAcq39+UzDGcwFqrZs2uR98Up6OwppyzCx4RYy3ASPf+/lKdeAqLEY5J2YEOs8rTs0
 6/1EyDY/Kspb350qgg6R7YGDeI6JiSfmEQSIXF5yBzHitJS0aalyFxj6UoxT7scznE05
 hdv+K9x15aCn9vZjbvSjcs3+NQNObri0UOn97Jl8R6pkoDr855CFiMbLNlE1qXYFEtuz
 LDNQqhDbWj+wSJRN2/px0qnqYuaCw+A0JvR61VwE569oaydAwJ+8lP3AEuzjcrPC+K8K
 L0pJowfAHsnud56YvosbbFFiR2hVhwrvrq8YM8FurQTIMfizW/TOp3bHa2QECSPovbXb
 W0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764742277; x=1765347077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DE3yZ1NezYm9j02BHfqvoIAZcoZs87VQEmFWXloIjT8=;
 b=SKY/lw2+/8k8KHEglEQOkyl7Nee9qXcK1tcOxkym6QfdXbln7tjmG1I9fdlGFv6kPo
 eoOvMX2Qmjg3racGpp5lJD21LeSGu5wBWM6Wlx5mwvYBHDVH5v5PVLMSJi53IMPi6lvh
 VF7j65zRgdf7rg+tOZm1aiDDQZgRwGJYYR29tE5y/cozLt5iMqA2IdlfMJqK8H9lJk0X
 fOzrwPd2q9XlOqbMQBr38vF0vAs0Rzgqls2QdTI7+r8JPuf5Oc8rQMVVNOt2vfyVA3bR
 pK3DciEve2l7AeE7fsbEfgkWOiDSOZnWULzlsHCOChE940Yw79xcABVUDKIJ1phyaYt4
 yq1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh9aJIlJ6C0CoRhylkTIoRdn2EkeY2/prFzOjcKyzczEVXwJLtqHhfdKjL7YHgfSs7iJ97lf+/ms6i@nongnu.org
X-Gm-Message-State: AOJu0YwciUJwPbM1yG8o0C8uT1eewQw9CDbLxL9DFUSkSIJfy2ZXMXXO
 whcZTH9pucGx4gPFLbgnD9+/wrHhqnARPsfbaTMyUZ4f7ls2iAGEG9n759iYF58boxI=
X-Gm-Gg: ASbGncv2CissxlyfeB2RsGAZ4uGtpVAW538bHKOO39uijTx9XQkHQ5m0rV3Bn4ZJW0m
 JdIMLnQpUMn3WRhSIcW74KJv508hCrGRUfHNZYTpL1YQGY/6Q53Ce3EW+1S2QERv7fY6lwu9xQO
 heJMvkDMjaBn8r+CxVP7bbqq7OhPEY23GQfte9y6+UDQfgtJX5rTNs5rSeJlE62yBMCvXjEmriV
 ms6t38kaEBo4AUB0Dl47a+6YpRrbCJ2w3p+vS/53JGGULCwk6m8/oAtZVWMv0sKI6UxO+e2zcsS
 dllBe+t01TJ83b6jaK2SPiOnBuHZMmLlgPP+1EXKODyBhV1Q/nqqtECGX6lyif0Ob/Flso6f0Rh
 oRbjatgr+KGPczQ+MgTqTvgLYOtP1LNgcnDcE2WHOAc9YsPFnHBCXHeZK2ItJ0TCAVFRKvLpfuy
 DX0DJ8J3oMJcGFPqKQh39XZ2oaf8mONjJLR7p9qz/IOxeaofEzE+BvplF4r66w
X-Google-Smtp-Source: AGHT+IEq/86+CzKzCTytHX4tZkZlNU5G/sXLlnLZ3vAB9xUpFuB3omWGH1/kYggSr0K+xsKwnaFOEA==
X-Received: by 2002:a05:600c:450a:b0:477:b0b8:4dd0 with SMTP id
 5b1f17b1804b1-4792af1b10fmr9009105e9.17.1764742277023; 
 Tue, 02 Dec 2025 22:11:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4792a8c614esm26123685e9.11.2025.12.02.22.11.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Dec 2025 22:11:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Zhao Liu <zhao1.liu@intel.com>,
	qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH-for-11.0 v6 13/13] hw/i386: Remove linuxboot.bin
Date: Wed,  3 Dec 2025 07:09:41 +0100
Message-ID: <20251203060942.57851-14-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251203060942.57851-1-philmd@linaro.org>
References: <20251203060942.57851-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, LOTS_OF_MONEY=0.001,
 MONEY_NOHTML=1.499, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

All machines now use the linuxboot_dma.bin binary, so it's safe to
remove the non-DMA version (linuxboot.bin).

Suggested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/i386/pc.c                  |   3 +-
 pc-bios/meson.build           |   1 -
 pc-bios/optionrom/Makefile    |   2 +-
 pc-bios/optionrom/linuxboot.S | 195 ----------------------------------
 4 files changed, 2 insertions(+), 199 deletions(-)
 delete mode 100644 pc-bios/optionrom/linuxboot.S

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index edba8e4b97d..08aa28e6a8d 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -667,8 +667,7 @@ void xen_load_linux(PCMachineState *pcms)
 
     x86_load_linux(x86ms, fw_cfg, PC_FW_DATA, pcmc->pvh_enabled);
     for (i = 0; i < nb_option_roms; i++) {
-        assert(!strcmp(option_rom[i].name, "linuxboot.bin") ||
-               !strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
+        assert(!strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
                !strcmp(option_rom[i].name, "pvh.bin") ||
                !strcmp(option_rom[i].name, "multiboot_dma.bin"));
         rom_add_option(option_rom[i].name, option_rom[i].bootindex);
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index efe45c16705..2f470ed1294 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -63,7 +63,6 @@ blobs = [
   'efi-vmxnet3.rom',
   'qemu-nsis.bmp',
   'multiboot_dma.bin',
-  'linuxboot.bin',
   'linuxboot_dma.bin',
   'kvmvapic.bin',
   'pvh.bin',
diff --git a/pc-bios/optionrom/Makefile b/pc-bios/optionrom/Makefile
index 1183ef88922..e694c7aac00 100644
--- a/pc-bios/optionrom/Makefile
+++ b/pc-bios/optionrom/Makefile
@@ -2,7 +2,7 @@ include config.mak
 SRC_DIR := $(TOPSRC_DIR)/pc-bios/optionrom
 VPATH = $(SRC_DIR)
 
-all: multiboot_dma.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin pvh.bin
+all: multiboot_dma.bin linuxboot_dma.bin kvmvapic.bin pvh.bin
 # Dummy command so that make thinks it has done something
 	@true
 
diff --git a/pc-bios/optionrom/linuxboot.S b/pc-bios/optionrom/linuxboot.S
deleted file mode 100644
index ba821ab922d..00000000000
--- a/pc-bios/optionrom/linuxboot.S
+++ /dev/null
@@ -1,195 +0,0 @@
-/*
- * Linux Boot Option ROM
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
- * Copyright Novell Inc, 2009
- *   Authors: Alexander Graf <agraf@suse.de>
- *
- * Based on code in hw/pc.c.
- */
-
-#include "optionrom.h"
-
-#define BOOT_ROM_PRODUCT "Linux loader"
-
-BOOT_ROM_START
-
-run_linuxboot:
-
-	cli
-	cld
-
-	jmp		copy_kernel
-boot_kernel:
-
-	read_fw		FW_CFG_SETUP_ADDR
-
-	mov		%eax, %ebx
-	shr		$4, %ebx
-
-	/* All segments contain real_addr */
-	mov		%bx, %ds
-	mov		%bx, %es
-	mov		%bx, %fs
-	mov		%bx, %gs
-	mov		%bx, %ss
-
-	/* CX = CS we want to jump to */
-	add		$0x20, %bx
-	mov		%bx, %cx
-
-	/* SP = cmdline_addr-real_addr-16 */
-	read_fw		FW_CFG_CMDLINE_ADDR
-	mov		%eax, %ebx
-	read_fw		FW_CFG_SETUP_ADDR
-	sub		%eax, %ebx
-	sub		$16, %ebx
-	mov		%ebx, %esp
-
-	/* Build indirect lret descriptor */
-	pushw		%cx		/* CS */
-	xor		%ax, %ax
-	pushw		%ax		/* IP = 0 */
-
-	/* Clear registers */
-	xor		%eax, %eax
-	xor		%ebx, %ebx
-	xor		%ecx, %ecx
-	xor		%edx, %edx
-	xor		%edi, %edi
-	xor		%ebp, %ebp
-
-	/* Jump to Linux */
-	lret
-
-
-copy_kernel:
-	/* Read info block in low memory (0x10000 or 0x90000) */
-	read_fw		FW_CFG_SETUP_ADDR
-	shr		$4, %eax
-	mov		%eax, %es
-	xor		%edi, %edi
-	read_fw_blob_addr32_edi(FW_CFG_SETUP)
-
-	cmpw            $0x203, %es:0x206      // if protocol >= 0x203
-	jae             1f                     // have initrd_max
-	movl            $0x37ffffff, %es:0x22c // else assume 0x37ffffff
-1:
-
-	/* Check if using kernel-specified initrd address */
-	read_fw		FW_CFG_INITRD_ADDR
-	mov		%eax, %edi             // (load_kernel wants it in %edi)
-	read_fw		FW_CFG_INITRD_SIZE     // find end of initrd
-	add		%edi, %eax
-	xor		%es:0x22c, %eax        // if it matches es:0x22c
-	and		$-4096, %eax           // (apart from padding for page)
-	jz		load_kernel            // then initrd is not at top
-					       // of memory
-
-	/* pc.c placed the initrd at end of memory.  Compute a better
-	 * initrd address based on e801 data.
-	 */
-	mov		$0xe801, %ax
-	xor		%cx, %cx
-	xor		%dx, %dx
-	int		$0x15
-
-	/* Output could be in AX/BX or CX/DX */
-	or		%cx, %cx
-	jnz		1f
-	or		%dx, %dx
-	jnz		1f
-	mov		%ax, %cx
-	mov		%bx, %dx
-1:
-
-	or		%dx, %dx
-	jnz		2f
-	addw		$1024, %cx            /* add 1 MB */
-	movzwl		%cx, %edi
-	shll		$10, %edi             /* convert to bytes */
-	jmp		3f
-
-2:
-	addw		$16777216 >> 16, %dx  /* add 16 MB */
-	movzwl		%dx, %edi
-	shll		$16, %edi             /* convert to bytes */
-
-3:
-	read_fw         FW_CFG_INITRD_SIZE
-	subl            %eax, %edi
-	andl            $-4096, %edi          /* EDI = start of initrd */
-	movl		%edi, %es:0x218       /* put it in the header */
-
-load_kernel:
-	/* We need to load the kernel into memory we can't access in 16 bit
-	   mode, so let's get into 32 bit mode, write the kernel and jump
-	   back again. */
-
-	/* Reserve space on the stack for our GDT descriptor. */
-	mov             %esp, %ebp
-	sub             $16, %esp
-
-	/* Now create the GDT descriptor */
-	movw		$((3 * 8) - 1), -16(%bp)
-	mov		%cs, %eax
-	movzwl		%ax, %eax
-	shl		$4, %eax
-	addl		$gdt, %eax
-	movl		%eax, -14(%bp)
-
-	/* And load the GDT */
-	data32 lgdt	-16(%bp)
-	mov		%ebp, %esp
-
-	/* Get us to protected mode now */
-	mov		$1, %eax
-	mov		%eax, %cr0
-
-	/* So we can set ES to a 32-bit segment */
-	mov		$0x10, %eax
-	mov		%eax, %es
-
-	/* We're now running in 16-bit CS, but 32-bit ES! */
-
-	/* Load kernel and initrd */
-	read_fw_blob_addr32_edi(FW_CFG_INITRD)
-	read_fw_blob_addr32(FW_CFG_KERNEL)
-	read_fw_blob_addr32(FW_CFG_CMDLINE)
-
-	/* And now jump into Linux! */
-	mov		$0, %eax
-	mov		%eax, %cr0
-
-	/* ES = CS */
-	mov		%cs, %ax
-	mov		%ax, %es
-
-	jmp		boot_kernel
-
-/* Variables */
-
-.align 4, 0
-gdt:
-	/* 0x00 */
-.byte	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
-
-	/* 0x08: code segment (base=0, limit=0xfffff, type=32bit code exec/read, DPL=0, 4k) */
-.byte	0xff, 0xff, 0x00, 0x00, 0x00, 0x9a, 0xcf, 0x00
-
-	/* 0x10: data segment (base=0, limit=0xfffff, type=32bit data read/write, DPL=0, 4k) */
-.byte	0xff, 0xff, 0x00, 0x00, 0x00, 0x92, 0xcf, 0x00
-
-BOOT_ROM_END
-- 
2.51.0


