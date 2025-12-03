Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5648D1266D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 06:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQg50-0006hI-7t; Wed, 03 Dec 2025 01:11:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQg4x-0006cV-TT
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 01:11:07 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQg4u-00019L-Jv
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 01:11:07 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42e2cf93f7dso2481163f8f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 22:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764742263; x=1765347063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cMxfe4ov4WmNjsTPrNW2SCp7e5pEivmzbHveo/n71po=;
 b=iS80TfM/hjUPPMMy7Ah/zqW6sBBS3gmFL/mDtholq/u+HYgx73IAjz6o4PhjVf7kxB
 d9M74u4GBqJ1NyBarW2gdf9SJdZMuJSC9rDZx0Epzin5LQ2JwM1LuzPd1Pf51AeXuI45
 J2JY6IDu3h7bpaoU2Ilp4eOlu0L84U2AVy8mSc3rHkwt4RI3XzAf3xIolkYzI2PsXwzm
 X8+1wXxPA1K2lbRBZkxRKtb6fsi/BrsRlPqnPvxHzrX8W53vhqrcLm3MiHAOIvx8vRiF
 fM4PLD4IeUnTL/otdIF+73rVfaD+dQW/LX/46Lo5nTLTyKpnVz/oY9+DRMKuRgQ9IPTB
 yDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764742263; x=1765347063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cMxfe4ov4WmNjsTPrNW2SCp7e5pEivmzbHveo/n71po=;
 b=aGI5ow561rQoQ+eLPtFIuKQ9fHa/Ye+1gzQYmiHQft9tSCybLWRP6LSsy3xCXsSWM7
 0pQM5hOYSF56hC1ggOldU5ben/UE9CTI04n9wQ2DsChFjoHOZ2SXawcF9s0zTVHbSQkl
 UZNJwlgeEal/wyZ5OodhIWFgKQrJUuXVtrqieyt+r9zMlk7cwEepZ39PE5GDHMHAR7Qq
 I2uqBcPyMvoGtRFQ57crikCagrNMjqeJp8oResLgD3M+633iO1giLbWRZIa0cNttqzLN
 HaoX0TP455Mgs/b9va6lDKhd1zL3gViy15b6O8324w0oIL9jWUWvI1Gw1VqsmMJCt4DO
 mfjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvysljIm7sfLho7QnCpPehBrayLUWQhSdHwGihz3LC30/rjviAtH4yikF6xzbTHXiYdZKKe6ccQnGx@nongnu.org
X-Gm-Message-State: AOJu0YzFU5f+N4+cUA29eYVkPif/gz2pwCvD3PAtnwfNpFrMlz3g24Dv
 nsPtd/EpkOUIlzc677urEXLAva/3+AinN8Gm2Gm27rimqeyH5VEKQ6G/23NL/vm7mLA=
X-Gm-Gg: ASbGncvJhvpKWd0icTkiUPfqTgms7b9+TkugboKaCFyjkLwYur89h+d0tkv6IsPaHZo
 xRXaE7fT1+cFeD2cMguBHlCplYCSP2H6KDnEKq3Rdpj46u8uyc+hZL0BGAoRuTrr3Meas1r57X7
 12JIbEgSiryBqG9C5iYOyyNv21MiGlyEFEQ8L1dl/EcnWuI78GRXxnxS9Z7x5rtjYgqeETu8Jh1
 8Qb3dq8FnRuI0eP169Y0xEONxu6BjvNHueV0dYgjmLTA76082hsJbVSIcQI34zcl/QrGHIi+9+S
 RAGnLeuDa+41LoUQCEdBfTuhaPtRMS0ZFeDPzhhe9AC5VGPdyZyBUWpPGS2Ix78p1uN341MVKCv
 xFZgzXGQX0LOZXQj92QC+frYobi3sC0cFTOayQGT2vsm0NkW3TRC8jki0n1iwDZIgyfgIDC/FUj
 ++HYWMcGVsay7kVN+fK5zgV/FsksYZ18HuWJfQoL2FRkXwNxne4oXy1rhlBnfE
X-Google-Smtp-Source: AGHT+IE0l2Zzhk64PIfhz6+M9b5bgqGM5x4IUDlJDXjKRTcqPNJww2f7XpYf6TzdE34Cj16Eb2NoRQ==
X-Received: by 2002:a05:6000:12c1:b0:42b:41dc:1b61 with SMTP id
 ffacd0b85a97d-42f731a4dc4mr632856f8f.35.1764742262752; 
 Tue, 02 Dec 2025 22:11:02 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1ca1a303sm39294494f8f.27.2025.12.02.22.11.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Dec 2025 22:11:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Zhao Liu <zhao1.liu@intel.com>,
	qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH-for-11.0 v6 11/13] hw/i386/pc: Remove multiboot.bin
Date: Wed,  3 Dec 2025 07:09:39 +0100
Message-ID: <20251203060942.57851-12-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251203060942.57851-1-philmd@linaro.org>
References: <20251203060942.57851-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

All PC machines now use the multiboot_dma.bin binary,
we can remove the non-DMA version (multiboot.bin).

This doesn't change multiboot_dma binary file.

Suggested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 pc-bios/optionrom/optionrom.h     |   4 -
 hw/i386/pc.c                      |   1 -
 pc-bios/meson.build               |   1 -
 pc-bios/multiboot.bin             | Bin 1024 -> 0 bytes
 pc-bios/optionrom/Makefile        |   2 +-
 pc-bios/optionrom/multiboot.S     | 232 -----------------------------
 pc-bios/optionrom/multiboot_dma.S | 234 +++++++++++++++++++++++++++++-
 7 files changed, 233 insertions(+), 241 deletions(-)
 delete mode 100644 pc-bios/multiboot.bin
 delete mode 100644 pc-bios/optionrom/multiboot.S

diff --git a/pc-bios/optionrom/optionrom.h b/pc-bios/optionrom/optionrom.h
index 7bcdf0eeb24..2e6e2493f83 100644
--- a/pc-bios/optionrom/optionrom.h
+++ b/pc-bios/optionrom/optionrom.h
@@ -117,16 +117,12 @@
  *
  * Clobbers: %eax, %edx, %es, %ecx, %edi and adresses %esp-20 to %esp
  */
-#ifdef USE_FW_CFG_DMA
 #define read_fw_blob_dma(var)                           \
         read_fw         var ## _SIZE;                   \
         mov             %eax, %ecx;                     \
         read_fw         var ## _ADDR;                   \
         mov             %eax, %edi ;                    \
         read_fw_dma     var ## _DATA, %ecx, %edi
-#else
-#define read_fw_blob_dma(var) read_fw_blob(var)
-#endif
 
 #define read_fw_blob_pre(var)                           \
         read_fw         var ## _SIZE;                   \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5c52079be31..edba8e4b97d 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -670,7 +670,6 @@ void xen_load_linux(PCMachineState *pcms)
         assert(!strcmp(option_rom[i].name, "linuxboot.bin") ||
                !strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
                !strcmp(option_rom[i].name, "pvh.bin") ||
-               !strcmp(option_rom[i].name, "multiboot.bin") ||
                !strcmp(option_rom[i].name, "multiboot_dma.bin"));
         rom_add_option(option_rom[i].name, option_rom[i].bootindex);
     }
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index 9260aaad78e..efe45c16705 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -62,7 +62,6 @@ blobs = [
   'efi-e1000e.rom',
   'efi-vmxnet3.rom',
   'qemu-nsis.bmp',
-  'multiboot.bin',
   'multiboot_dma.bin',
   'linuxboot.bin',
   'linuxboot_dma.bin',
diff --git a/pc-bios/multiboot.bin b/pc-bios/multiboot.bin
deleted file mode 100644
index e772713c95749bee82c20002b50ec6d05b2d4987..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 1024
zcmeHFF-Tic6utlZQ$OjD#Hxcx2u0GNQv6GySOkZR(ulaX<>%N!Y#>cWhY}nf36J7X
zN(%*X6NHY>xcqO11dG^02a8L@B~ihln|%1*|7(haWa`)l@80w7;U4Ziyv0rZ8{K-w
zX(Ib3tLZ)RgZ}w1ei{~QEqQq9q1J-iHc<Nk_t=0qf%XfPZVHw2DY#ujc2P|}*P%6X
z5J{pPlX4<yP&N5pXK;s@UhB~&!E&UdqEwGZF6xQMIcu9YL#zeSRCoLGt{Nh+08t>}
z{m%E-b32A??+@XljSYirtWObwngi<ymS1Ta*dFGMp;8@=_3Z52!v09{UU~`QnFsB_
z7BiEC)uZxH%SW9kPWCicN{_iUjmk<~D^H|R%@|m9%43Woc(Pkeq%n{&8ND5Z*tPt#
zJua+xXAQhN4K(1MMs0{u_6sp>l#NmvPZ7KC<lsLdQgMFC@A6POvMoDMgW=M+K;T<o
zTkpnNq6x*`vM0CGE>t40l-CQ}*)y<y--c)(x}o&1TMzwX+ToGS@VER4zR&s70fl+(
qI)9<-H_-!n#lLJmGq*^~<$US&%R-@)$`@YPx#A6#|L`9<;9UXPG71m?

diff --git a/pc-bios/optionrom/Makefile b/pc-bios/optionrom/Makefile
index 30d07026c79..1183ef88922 100644
--- a/pc-bios/optionrom/Makefile
+++ b/pc-bios/optionrom/Makefile
@@ -2,7 +2,7 @@ include config.mak
 SRC_DIR := $(TOPSRC_DIR)/pc-bios/optionrom
 VPATH = $(SRC_DIR)
 
-all: multiboot.bin multiboot_dma.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin pvh.bin
+all: multiboot_dma.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin pvh.bin
 # Dummy command so that make thinks it has done something
 	@true
 
diff --git a/pc-bios/optionrom/multiboot.S b/pc-bios/optionrom/multiboot.S
deleted file mode 100644
index c95e35c9cb6..00000000000
--- a/pc-bios/optionrom/multiboot.S
+++ /dev/null
@@ -1,232 +0,0 @@
-/*
- * Multiboot Option ROM
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
- */
-
-#include "optionrom.h"
-
-#define BOOT_ROM_PRODUCT "multiboot loader"
-
-#define MULTIBOOT_MAGIC		0x2badb002
-
-#define GS_PROT_JUMP		0
-#define GS_GDT_DESC		6
-
-
-BOOT_ROM_START
-
-run_multiboot:
-
-	cli
-	cld
-
-	mov		%cs, %eax
-	shl		$0x4, %eax
-
-	/* set up a long jump descriptor that is PC relative */
-
-	/* move stack memory to %gs */
-	mov		%ss, %ecx
-	shl		$0x4, %ecx
-	mov		%esp, %ebx
-	add		%ebx, %ecx
-	sub		$0x20, %ecx
-	sub		$0x30, %esp
-	shr		$0x4, %ecx
-	mov		%cx, %gs
-
-	/* now push the indirect jump descriptor there */
-	mov		(prot_jump), %ebx
-	add		%eax, %ebx
-	movl		%ebx, %gs:GS_PROT_JUMP
-	mov		$8, %bx
-	movw		%bx, %gs:GS_PROT_JUMP + 4
-
-	/* fix the gdt descriptor to be PC relative */
-	movw		(gdt_desc), %bx
-	movw		%bx, %gs:GS_GDT_DESC
-	movl		(gdt_desc+2), %ebx
-	add		%eax, %ebx
-	movl		%ebx, %gs:GS_GDT_DESC + 2
-
-	xor		%eax, %eax
-	mov		%eax, %es
-
-	/* Read the bootinfo struct into RAM */
-	read_fw_blob_dma(FW_CFG_INITRD)
-
-	/* FS = bootinfo_struct */
-	read_fw		FW_CFG_INITRD_ADDR
-	shr		$4, %eax
-	mov		%ax, %fs
-
-	/* Account for the EBDA in the multiboot structure's e801
-	 * map.
-	 */
-	int		$0x12
-	cwtl
-	movl		%eax, %fs:4
-
-	/* ES = mmap_addr */
-	mov 		%fs:48, %eax
-	shr		$4, %eax
-	mov		%ax, %es
-
-	/* Initialize multiboot mmap structs using int 0x15(e820) */
-	xor		%ebx, %ebx
-	/* Start storing mmap data at %es:0 */
-	xor		%edi, %edi
-
-mmap_loop:
-	/* The multiboot entry size has offset -4, so leave some space */
-	add		$4, %di
-	/* entry size (mmap struct) & max buffer size (int15) */
-	movl		$20, %ecx
-	/* e820 */
-	movl		$0x0000e820, %eax
-	/* 'SMAP' magic */
-	movl		$0x534d4150, %edx
-	int		$0x15
-
-mmap_check_entry:
-	/* Error or last entry already done? */
-	jb		mmap_done
-
-mmap_store_entry:
-	/* store entry size */
-	/* old as(1) doesn't like this insn so emit the bytes instead:
-	movl		%ecx, %es:-4(%edi)
-	*/
-	.dc.b		0x26,0x67,0x66,0x89,0x4f,0xfc
-
-	/* %edi += entry_size, store as mbs_mmap_length */
-	add		%ecx, %edi
-	movw		%di, %fs:0x2c
-
-	/* Continuation value 0 means last entry */
-	test		%ebx, %ebx
-	jnz		mmap_loop
-
-mmap_done:
-	/* Calculate upper_mem field: The amount of memory between 1 MB and
-	   the first upper memory hole. Get it from the mmap. */
-	xor		%di, %di
-	mov		$0x100000, %edx
-upper_mem_entry:
-	cmp		%fs:0x2c, %di
-	je		upper_mem_done
-	add		$4, %di
-
-	/* Skip if type != 1 */
-	cmpl		$1, %es:16(%di)
-	jne		upper_mem_next
-
-	/* Skip if > 4 GB */
-	movl		%es:4(%di), %eax
-	test		%eax, %eax
-	jnz		upper_mem_next
-
-	/* Check for contiguous extension (base <= %edx < base + length) */
-	movl		%es:(%di), %eax
-	cmp		%eax, %edx
-	jb		upper_mem_next
-	addl		%es:8(%di), %eax
-	cmp		%eax, %edx
-	jae		upper_mem_next
-
-	/* If so, update %edx, and restart the search (mmap isn't ordered) */
-	mov		%eax, %edx
-	xor		%di, %di
-	jmp		upper_mem_entry
-
-upper_mem_next:
-	addl		%es:-4(%di), %edi
-	jmp		upper_mem_entry
-
-upper_mem_done:
-	sub		$0x100000, %edx
-	shr		$10, %edx
-	mov		%edx, %fs:0x8
-
-real_to_prot:
-	/* Load the GDT before going into protected mode */
-lgdt:
-	data32 lgdt	%gs:GS_GDT_DESC
-
-	/* get us to protected mode now */
-	movl		$1, %eax
-	movl		%eax, %cr0
-
-	/* the LJMP sets CS for us and gets us to 32-bit */
-ljmp:
-	data32 ljmp	*%gs:GS_PROT_JUMP
-
-prot_mode:
-.code32
-
-	/* initialize all other segments */
-	movl		$0x10, %eax
-	movl		%eax, %ss
-	movl		%eax, %ds
-	movl		%eax, %es
-	movl		%eax, %fs
-	movl		%eax, %gs
-
-	/* Read the kernel and modules into RAM */
-	read_fw_blob_dma(FW_CFG_KERNEL)
-
-	/* Jump off to the kernel */
-	read_fw		FW_CFG_KERNEL_ENTRY
-	mov		%eax, %ecx
-
-	/* EBX contains a pointer to the bootinfo struct */
-	read_fw		FW_CFG_INITRD_ADDR
-	movl		%eax, %ebx
-
-	/* EAX has to contain the magic */
-	movl		$MULTIBOOT_MAGIC, %eax
-ljmp2:
-	jmp		*%ecx
-
-/* Variables */
-.align 4, 0
-prot_jump:	.long prot_mode
-		.short 8
-
-.align 8, 0
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
-	/* 0x18: code segment (base=0, limit=0x0ffff, type=16bit code exec/read/conf, DPL=0, 1b) */
-.byte	0xff, 0xff, 0x00, 0x00, 0x00, 0x9e, 0x00, 0x00
-
-	/* 0x20: data segment (base=0, limit=0x0ffff, type=16bit data read/write, DPL=0, 1b) */
-.byte	0xff, 0xff, 0x00, 0x00, 0x00, 0x92, 0x00, 0x00
-
-gdt_desc:
-.short	(5 * 8) - 1
-.long	gdt
-
-BOOT_ROM_END
diff --git a/pc-bios/optionrom/multiboot_dma.S b/pc-bios/optionrom/multiboot_dma.S
index d809af3e23f..c95e35c9cb6 100644
--- a/pc-bios/optionrom/multiboot_dma.S
+++ b/pc-bios/optionrom/multiboot_dma.S
@@ -1,2 +1,232 @@
-#define USE_FW_CFG_DMA 1
-#include "multiboot.S"
+/*
+ * Multiboot Option ROM
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Copyright Novell Inc, 2009
+ *   Authors: Alexander Graf <agraf@suse.de>
+ */
+
+#include "optionrom.h"
+
+#define BOOT_ROM_PRODUCT "multiboot loader"
+
+#define MULTIBOOT_MAGIC		0x2badb002
+
+#define GS_PROT_JUMP		0
+#define GS_GDT_DESC		6
+
+
+BOOT_ROM_START
+
+run_multiboot:
+
+	cli
+	cld
+
+	mov		%cs, %eax
+	shl		$0x4, %eax
+
+	/* set up a long jump descriptor that is PC relative */
+
+	/* move stack memory to %gs */
+	mov		%ss, %ecx
+	shl		$0x4, %ecx
+	mov		%esp, %ebx
+	add		%ebx, %ecx
+	sub		$0x20, %ecx
+	sub		$0x30, %esp
+	shr		$0x4, %ecx
+	mov		%cx, %gs
+
+	/* now push the indirect jump descriptor there */
+	mov		(prot_jump), %ebx
+	add		%eax, %ebx
+	movl		%ebx, %gs:GS_PROT_JUMP
+	mov		$8, %bx
+	movw		%bx, %gs:GS_PROT_JUMP + 4
+
+	/* fix the gdt descriptor to be PC relative */
+	movw		(gdt_desc), %bx
+	movw		%bx, %gs:GS_GDT_DESC
+	movl		(gdt_desc+2), %ebx
+	add		%eax, %ebx
+	movl		%ebx, %gs:GS_GDT_DESC + 2
+
+	xor		%eax, %eax
+	mov		%eax, %es
+
+	/* Read the bootinfo struct into RAM */
+	read_fw_blob_dma(FW_CFG_INITRD)
+
+	/* FS = bootinfo_struct */
+	read_fw		FW_CFG_INITRD_ADDR
+	shr		$4, %eax
+	mov		%ax, %fs
+
+	/* Account for the EBDA in the multiboot structure's e801
+	 * map.
+	 */
+	int		$0x12
+	cwtl
+	movl		%eax, %fs:4
+
+	/* ES = mmap_addr */
+	mov 		%fs:48, %eax
+	shr		$4, %eax
+	mov		%ax, %es
+
+	/* Initialize multiboot mmap structs using int 0x15(e820) */
+	xor		%ebx, %ebx
+	/* Start storing mmap data at %es:0 */
+	xor		%edi, %edi
+
+mmap_loop:
+	/* The multiboot entry size has offset -4, so leave some space */
+	add		$4, %di
+	/* entry size (mmap struct) & max buffer size (int15) */
+	movl		$20, %ecx
+	/* e820 */
+	movl		$0x0000e820, %eax
+	/* 'SMAP' magic */
+	movl		$0x534d4150, %edx
+	int		$0x15
+
+mmap_check_entry:
+	/* Error or last entry already done? */
+	jb		mmap_done
+
+mmap_store_entry:
+	/* store entry size */
+	/* old as(1) doesn't like this insn so emit the bytes instead:
+	movl		%ecx, %es:-4(%edi)
+	*/
+	.dc.b		0x26,0x67,0x66,0x89,0x4f,0xfc
+
+	/* %edi += entry_size, store as mbs_mmap_length */
+	add		%ecx, %edi
+	movw		%di, %fs:0x2c
+
+	/* Continuation value 0 means last entry */
+	test		%ebx, %ebx
+	jnz		mmap_loop
+
+mmap_done:
+	/* Calculate upper_mem field: The amount of memory between 1 MB and
+	   the first upper memory hole. Get it from the mmap. */
+	xor		%di, %di
+	mov		$0x100000, %edx
+upper_mem_entry:
+	cmp		%fs:0x2c, %di
+	je		upper_mem_done
+	add		$4, %di
+
+	/* Skip if type != 1 */
+	cmpl		$1, %es:16(%di)
+	jne		upper_mem_next
+
+	/* Skip if > 4 GB */
+	movl		%es:4(%di), %eax
+	test		%eax, %eax
+	jnz		upper_mem_next
+
+	/* Check for contiguous extension (base <= %edx < base + length) */
+	movl		%es:(%di), %eax
+	cmp		%eax, %edx
+	jb		upper_mem_next
+	addl		%es:8(%di), %eax
+	cmp		%eax, %edx
+	jae		upper_mem_next
+
+	/* If so, update %edx, and restart the search (mmap isn't ordered) */
+	mov		%eax, %edx
+	xor		%di, %di
+	jmp		upper_mem_entry
+
+upper_mem_next:
+	addl		%es:-4(%di), %edi
+	jmp		upper_mem_entry
+
+upper_mem_done:
+	sub		$0x100000, %edx
+	shr		$10, %edx
+	mov		%edx, %fs:0x8
+
+real_to_prot:
+	/* Load the GDT before going into protected mode */
+lgdt:
+	data32 lgdt	%gs:GS_GDT_DESC
+
+	/* get us to protected mode now */
+	movl		$1, %eax
+	movl		%eax, %cr0
+
+	/* the LJMP sets CS for us and gets us to 32-bit */
+ljmp:
+	data32 ljmp	*%gs:GS_PROT_JUMP
+
+prot_mode:
+.code32
+
+	/* initialize all other segments */
+	movl		$0x10, %eax
+	movl		%eax, %ss
+	movl		%eax, %ds
+	movl		%eax, %es
+	movl		%eax, %fs
+	movl		%eax, %gs
+
+	/* Read the kernel and modules into RAM */
+	read_fw_blob_dma(FW_CFG_KERNEL)
+
+	/* Jump off to the kernel */
+	read_fw		FW_CFG_KERNEL_ENTRY
+	mov		%eax, %ecx
+
+	/* EBX contains a pointer to the bootinfo struct */
+	read_fw		FW_CFG_INITRD_ADDR
+	movl		%eax, %ebx
+
+	/* EAX has to contain the magic */
+	movl		$MULTIBOOT_MAGIC, %eax
+ljmp2:
+	jmp		*%ecx
+
+/* Variables */
+.align 4, 0
+prot_jump:	.long prot_mode
+		.short 8
+
+.align 8, 0
+gdt:
+	/* 0x00 */
+.byte	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+
+	/* 0x08: code segment (base=0, limit=0xfffff, type=32bit code exec/read, DPL=0, 4k) */
+.byte	0xff, 0xff, 0x00, 0x00, 0x00, 0x9a, 0xcf, 0x00
+
+	/* 0x10: data segment (base=0, limit=0xfffff, type=32bit data read/write, DPL=0, 4k) */
+.byte	0xff, 0xff, 0x00, 0x00, 0x00, 0x92, 0xcf, 0x00
+
+	/* 0x18: code segment (base=0, limit=0x0ffff, type=16bit code exec/read/conf, DPL=0, 1b) */
+.byte	0xff, 0xff, 0x00, 0x00, 0x00, 0x9e, 0x00, 0x00
+
+	/* 0x20: data segment (base=0, limit=0x0ffff, type=16bit data read/write, DPL=0, 1b) */
+.byte	0xff, 0xff, 0x00, 0x00, 0x00, 0x92, 0x00, 0x00
+
+gdt_desc:
+.short	(5 * 8) - 1
+.long	gdt
+
+BOOT_ROM_END
-- 
2.51.0


