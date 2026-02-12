Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F7ADEE3692
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvG-0005kT-Ke; Thu, 12 Feb 2026 09:44:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXuz-0005O1-BA
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXug-000641-6u
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j2J5S69ujIyTT8+25co0N6GqgCEdVM5HCv9XrkCpJ+g=;
 b=OlqI07OPWC49zi79SiC2ahIxr7EBgBmi5cwJpnFp7r7zIwMp3qRkYUPiZWInspiICClmKy
 yIt/7yFaEmgnWjvamHKGdeuE2MtlHVWAyrQm0WovI3z+2vn8sQWuh/zm8gDtmMrDhIOAUe
 zbHgqMousRJzNIJ/flaiFN3f66G8OuM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-9LnXJA8yMOOVQEivW69VQg-1; Thu, 12 Feb 2026 09:43:21 -0500
X-MC-Unique: 9LnXJA8yMOOVQEivW69VQg-1
X-Mimecast-MFC-AGG-ID: 9LnXJA8yMOOVQEivW69VQg_1770907400
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47ee3dd7fc8so60700775e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907399; x=1771512199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j2J5S69ujIyTT8+25co0N6GqgCEdVM5HCv9XrkCpJ+g=;
 b=gq6EdOVGDqU7o4DZrtaCTWCXVhiWp3f5Ih0UcGSEvuhuAO6RO0WBXh7bLE8JknAYEG
 EmX9CAs18UeR+afBmawOehAaIi59iOJBsrVwvv05S/f/XToURo8veCw6pSU8tYQ/xTit
 AyUfsvsJAjTw2BBZL/cP8+d6B3PR60QnxFd+2+xK6OVRqB8K6d0KSdwoatIEPJC2p0vF
 4tM8fFYFF5P1AR27U2z+m+xE0zM6aSWpVFl6r8gMWQxanv/AKIvVOxnLp77ax87yKh0O
 3FlhGKeRy8u+vg5u9iAHc0kOUkbuLywZ2Wu6R/S6iRVEq/LUD/O2bV/7rhhNNuQNDkEU
 Ofjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907399; x=1771512199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j2J5S69ujIyTT8+25co0N6GqgCEdVM5HCv9XrkCpJ+g=;
 b=U6E2DFqSnaoSspGl0caB5PHGOsLne02s82UT6hLEV2gRlgyCWm8KwU/NHYcINgxpT+
 cqhZytipMceU23v2jWbkMEUfOLUvo36GyC6TPB/AAgYylmYnl+7BrIDSXGQu8ejI5Ujw
 gTvbxfk6KNmY3MAHEaW6EcOMgYG8hxvtclMUrXHUb+KvMDT5HuCDCIdZNz5/DdmmYTcB
 31HBBsYPLi8zQUXsZ2cs/7hIT2+Oj4oXLXXA+cp9FxlqroBYLuVDtABj7ALD307GlMvl
 W7QTGKmMYWcFjJtAUgeoRg4pZnUj5MA4bzEIDYsJ1i4/zCCLCcHfrU1GSK6qQ/DeW/qM
 m22A==
X-Gm-Message-State: AOJu0YyNKHNqQ43aCb85nMvsE9nZfP48nVF755jKYkJgcIlkeadTYRRJ
 74+XR6LqWMiubb5RBlYnAfRwNR8C4PwuSJIUHiC652s1EyFs6ZCOAEo3ER+huJwQxDqndOR0UKW
 bop4cK1Ru2Cxoxah/PzF6jGO5i7sdduAxYQ0IUpJVK/eU1lL/NdfPAYBuko5twSxNzPU1s/8wfF
 s4ejuLjmoHhzML2ZwraczV4pqz+EYkFLkD0ivKZATx
X-Gm-Gg: AZuq6aJAH/+MyZO2gbBCtiBoKwR22PiUlm1DpEJHwoaDY++VxVOzXILvyW78nl/IVsh
 oCSu18IU9/A80mfLU6db64AfgpQqWO8ajoIkY2FVbSOnprN8xpXhXPwObJraQ8XtbCWPV3CYCfQ
 LggbXwp3yenEDucrLD6B5u1/EDEUbB+rrz93WaibMt8G5oyf0a2VznEFgPeBdO8vX4KbvZd8/2J
 taYAJGlxnLVigkw5x/m2QW8PmGZo9R6yLIL8TaKMP5UHPWdulN+tyEDTXZpf9SgKv2KAtbtHJZj
 bGBm1RXQu1gKpNzu/UjMzjaI5d+0ltyK07dfYpk0nX1BuG6WzOpZnqshhvQap0nD2lk9pY4VWCU
 QjjOqyBZJISTN/U6wBk7VrYSHoU51gXppR+geJAsuchYeIvKZklD70KTJjqZJAY62IXfREm6nyZ
 1FrFhZ+hHnbu8kV+TfklYj/XjVo32eQknrVtA2mOk1SA2ZnI80pWo=
X-Received: by 2002:a05:600c:458c:b0:477:55ce:f3c2 with SMTP id
 5b1f17b1804b1-483656c608cmr38197945e9.14.1770907398870; 
 Thu, 12 Feb 2026 06:43:18 -0800 (PST)
X-Received: by 2002:a05:600c:458c:b0:477:55ce:f3c2 with SMTP id
 5b1f17b1804b1-483656c608cmr38197175e9.14.1770907398144; 
 Thu, 12 Feb 2026 06:43:18 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835a627c96sm71706275e9.2.2026.02.12.06.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:43:16 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 14/41] hw/i386/pc: Remove multiboot.bin
Date: Thu, 12 Feb 2026 15:42:16 +0100
Message-ID: <20260212144244.22579-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212144244.22579-1-pbonzini@redhat.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Philippe Mathieu-Daudé <philmd@linaro.org>

All PC machines now use the multiboot_dma.bin binary,
we can remove the non-DMA version (multiboot.bin).

This doesn't change multiboot_dma binary file.

Suggested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20260108033051.777361-14-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
index 716962f24fc..b033fc67cf9 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -672,7 +672,6 @@ void xen_load_linux(PCMachineState *pcms)
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
zcmeHFF=!KE7=3rWv_~9rsoFv02vW|$BE3Z@O2HvxF(Tbn?w$(KKupFCa&$N@9Fjpq
zK@c}VaQwY4cgc{Tlqxt>x}>-yZJ|RqIXJnrkq&Z`qYu9S`*@G<!T0!A-^*X{S6sw=
z<w-@7C*lkF^`H61m~8d^?O!oleMSR?t#6EW6}mqu{h%`{(K%RTG*bK#J^ijsscX~K
zfejV5t1IyI=d$hU)1arfC$b8fp&yDo0xfqK6mtiR2I}dj(5KrIXEOCj%z}ZI15%6l
zsG98;4HbW|Im?$8-zl*8b`fJPq`5;gae4|rodZBo8UhR|H&^a#p0A%Z9?-oNQ`)lJ
z<ppqkr}^DX7yufq>&pvhTyuJgL1#^qn)3#|vcmPSdBLEU<5H(yG&ogOxzu?&L$_ll
z`=1R?t;PFYKHEz@813aPx^pUQ7NogpP)Gm@mqMG#RX}I}{ICADANm7-NHH@$nuknt
zOJkc<q3`x6)C@VID5jAD$LsM?l|sv2$Y;o1A%FaECE3M>1gMiQ1RzNOyxKbM?UVlI
lgl_|v@lXbCmseKtxLIvHx?ig`O4Zsu%dVet`Hz2u_&3=y3J?GQ

diff --git a/pc-bios/optionrom/Makefile b/pc-bios/optionrom/Makefile
index e6674a76e73..963a77a3298 100644
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
2.52.0


