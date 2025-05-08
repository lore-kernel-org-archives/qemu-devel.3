Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDA7C3ABC5
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 13:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1T0-00029P-K0; Thu, 08 May 2025 09:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1Sv-0001xU-LI
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:39:09 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1Sr-000411-Ra
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:39:09 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-736c062b1f5so1067455b3a.0
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 06:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746711544; x=1747316344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kTrksqwiAVthFG19vVz8wjp27rY4ezfgcLCtbhgdHyw=;
 b=a2IJVOiLWKV765cqUBc47qV8tAD5vKbCTBT+rF+5yYw6TRr5/xyw7ByRCow3EYmJ0n
 2yynVdAuQ3/FhDCypzq5hVQZbI8QXEanjnNj8CGMJ/ulz42WGuNXcXJFasG45m9FjRjI
 VwHUlu5jB4hDp4+jfLHBHjICQiYdaa0uSkY5IMFpk1Ts51ode+gqS44D7oiTmCY76/Eh
 svzwO+N2USXD9YRR+wzz4xsbo8qSeUGdyIc0uUi0n9U3ij1GLtJ/+gjrkieIwoT0/mcc
 c1CzPapBkwpYTKOzJX7ABQqHylZtb+oZ9XIO+Ksn+h1EIV8vwj/6aCJr0ZqjQyTxGthA
 mzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746711544; x=1747316344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kTrksqwiAVthFG19vVz8wjp27rY4ezfgcLCtbhgdHyw=;
 b=B3yFNzPjXYa0mryQptbts0b/lYVldVUVSGxtUTonMdcFtQbggX+6MV2JL9R7QLNmIl
 BpVMusVrNl05t90Ic9z3R8/2e0sLobyS4mcNqYzyG2I7U29cfQsRWV22RYz+CtedthYw
 1yhUlMeMMvNsifc/Mu9MfjgIJTNgEVLhG/NNhUGuGgHxBtTEns/jXcu8cMkBnb3QsKWx
 t+znGLUVlLLU8kYu5gsI4woJYc+wybV2Z94ugkkeEIfnURaScUtDLTtd4JdlxzLIP5RY
 5TVLdYfhSetCWq6ZtM9vgwtXPpEjGOYG2/9fvFFsW64uR4C1SNcJRsplWguopTny+SaZ
 ERFA==
X-Gm-Message-State: AOJu0YwifzYdO8HYV8RNc6EwRnsfl7O8Gv1n6BY+QLeKg3OwJbG+uAB9
 Ia+fkR4FHts/LxvJ7gS6x+tIOJD62vuGyIp0ffOrK1nvRWBGYLri8ZqPgdtfWptVtbRjN8iVB3s
 QEWUBzQ==
X-Gm-Gg: ASbGncs/srsM9+A+Y0tx14r9DU0J25q6jRceZsfMI+wXw9asVO45GRH6vJvEihN1Gl3
 7EM5+czamoUy74p3qjgHfatDhGxaAXbc37yS+RWrXsGHvOrk1HIljTPc1LAE1uUmHgI/jPl6s0f
 Sjw79muu90WPL33yQBL8jM6crjVzSNpEMzhKVoz/qgLRwYyV7pyTvFOBDy53fQPOBgUUCpI0js+
 6ul0cOtiIr1F+lnRbe9LmHUd7CV6HhEp11esHnnoP16YZeXmL+yWE9vDyAl+Clqx2vUj9YNP+ur
 hf3sCQt37y0OXYi+d0+LsGmyAhtJVB8+YDkYHKvxe1EySa7IerxpmqyeeFSDh4vCxZohCBOEcz1
 NZRlMtjkIVgDZrVo=
X-Google-Smtp-Source: AGHT+IHVMEmPLFOMQyrLszcKEm1uVOufStVqgQk61xDh0fHw1ybJ7tr/eA0o0zdbB40nebp8AAzvOA==
X-Received: by 2002:aa7:804e:0:b0:740:aa31:fe66 with SMTP id
 d2e1a72fcca58-740aa31fee7mr3700388b3a.4.1746711543560; 
 Thu, 08 May 2025 06:39:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740d961e27fsm131505b3a.19.2025.05.08.06.38.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 May 2025 06:39:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Helge Deller <deller@gmx.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v4 08/27] hw/i386/pc: Remove multiboot.bin
Date: Thu,  8 May 2025 15:35:31 +0200
Message-ID: <20250508133550.81391-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250508133550.81391-1-philmd@linaro.org>
References: <20250508133550.81391-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x42d.google.com
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

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index 49632b69d29..524d2fd98e8 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -657,7 +657,6 @@ void xen_load_linux(PCMachineState *pcms)
         assert(!strcmp(option_rom[i].name, "linuxboot.bin") ||
                !strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
                !strcmp(option_rom[i].name, "pvh.bin") ||
-               !strcmp(option_rom[i].name, "multiboot.bin") ||
                !strcmp(option_rom[i].name, "multiboot_dma.bin"));
         rom_add_option(option_rom[i].name, option_rom[i].bootindex);
     }
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index 79bb2e18008..f2d4dc416a4 100644
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
index 181a4b03a3f..00000000000
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
index d809af3e23f..181a4b03a3f 100644
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
+.align 4, 0
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
2.47.1


