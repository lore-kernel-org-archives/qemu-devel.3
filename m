Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B10AD65C5A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 14:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVswN-0006X4-7D; Wed, 17 Dec 2025 09:55:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vVswG-0006Vn-Sa
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:55:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vVswE-0003Ij-EI
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:55:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765983337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hmf5VC+b3x+LaGkm+jOlklLFunTAIeNMxOXVsFoA2R4=;
 b=h5TLZLLH4DDu7Xg7NK06xkGLVbi2ciWg7Pi5LK/3/TYMGepbiuokL5p8DXMcBtNq8kOoWF
 E+mYGphyRc1acOiX47/JtHsG+XghDk1nndTztWxkuQp3jMajDrhP0jjtXyFL+wQAgk5eUx
 0GSB9B1kSo9HeDpSc01s7guBmscRELM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-AlOwPx02MP-lIgqC8l-Pqg-1; Wed, 17 Dec 2025 09:55:36 -0500
X-MC-Unique: AlOwPx02MP-lIgqC8l-Pqg-1
X-Mimecast-MFC-AGG-ID: AlOwPx02MP-lIgqC8l-Pqg_1765983335
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477c49f273fso73508055e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 06:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765983335; x=1766588135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hmf5VC+b3x+LaGkm+jOlklLFunTAIeNMxOXVsFoA2R4=;
 b=b/KV0ZRycjYF7PwSOCekSwr9IrR+ivZ1EY3IQ3tyyulOyXj1uyykDZSY1LblJkIv8t
 UdifXly/AkIZMUvf3aXd18FvdvAQp2ruOGXgoiL3/w90tcXFV+ejk0ZLRGiEsg/QrEb1
 TLAxlC5dDqitBNyxRa97fQMeOi4ToPvQa6DmDH/dco8z8NTwFF42R/9sVzB8OazYtcL8
 IcVnztUVzDhlZB4JolevcJ2wukKNfW9x1Jgl5q4rSx/DJQX1ZvPQnRVuqefWHM4EvqKG
 SJb0GGxGtvr67pG/2P4fL3tMUj2LfyWYC9pvcufXHc4iZ4SsRyQx0i0C1DH8IJhBoI18
 zyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765983335; x=1766588135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hmf5VC+b3x+LaGkm+jOlklLFunTAIeNMxOXVsFoA2R4=;
 b=UGzx1Uj86HlddLOGwqEHQX0FrfgfBM2+lIDT+GMk974EvkrMiKGuvpG143SfG4Dct2
 jJxJnqN2REflweHo90tMcr02oMB6NYX5zo2giXDWbFG4p1/RKbyis7B+OHvLGGuS3Bfc
 Avj0u50ojtSjH9O35VBm6kPRROSAGIP35+UfgP01cQArgJj3DrerWWvqHo+hmJQwWnoX
 7tcEqkK246k76VuyZhSza/vpvpAP+ahCsUNf2ro8BR8TrmjhIR+TSn6oioLtKn4iQkHu
 P6RUmBV1xXim4E4oqtikqb8n8OgJ0lVGLX2saJfzJBRnCFGOD78MD4/n91pqTSuQiaUk
 EEyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURLoC1U/YnlbofawpjRYC1eUEeANn3ef4msG4Y9o0xGTFDV+Mec8ZYjmcV/FO8cpvfzDO+2rJiiEJT@nongnu.org
X-Gm-Message-State: AOJu0YzoA2mMd+Do0AaFuknPGstOX7tBCUQADEYXQSVk453zb6+aTRjy
 LtOnrUaVKKiGFsqaVLtLIhuiDOD8dsXMFYAcYOeTMPtsECFL5vA5GFgYFAzSh6uikZCMN3+bf9b
 GEKMeGDcDOSC46WI/E267Gf+ymLZ0TkAf7f1bTxxyBzaWU27yybPVbxjT
X-Gm-Gg: AY/fxX7fJe7gM30hTm7qxVxDgFvjc0gxYxpLRMzXKekRs5ed1m+WxZwC8/NzRUn4ekk
 XJ7IcmgfhIjy7txYDJFuw9dDwkkARSRlkYm63Tp3+T2F47UJHxj18xCbTky70hUPXhgtKTMV1sX
 +v7hCctSQfKp2MMsPjjQ98GC68+MyldTMt/hldU6nku4zRSekCpRKO8Jc1dOtVUcU6t44pDAyWA
 91AoOfQ7RByR6jUo7cLtd7d2vEtwVqt2K1l9p8ZgsHRdQ5iE9jUouf+CsX3u7O9G3I6yPIPK+8/
 XLg6T0htQ9MAbnSoEOZU+ylR1FmQzzMQrIN6etek0yb0lvJAX4k0n8YgXHiMNmHJ8qfj0w==
X-Received: by 2002:a05:600c:528a:b0:47b:d949:9ba9 with SMTP id
 5b1f17b1804b1-47bd9499cf6mr51863365e9.13.1765983334940; 
 Wed, 17 Dec 2025 06:55:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCgPp3Zk8qHTNA+WDCbAp3YDWWtS6/6R+MJ8UYvQwsCNZi3scFHvl7ITonyEAWnlTi/e7hIQ==
X-Received: by 2002:a05:600c:528a:b0:47b:d949:9ba9 with SMTP id
 5b1f17b1804b1-47bd9499cf6mr51862785e9.13.1765983334482; 
 Wed, 17 Dec 2025 06:55:34 -0800 (PST)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4310ade7c4asm5149594f8f.28.2025.12.17.06.55.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 06:55:34 -0800 (PST)
Date: Wed, 17 Dec 2025 15:55:30 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas
 Huth <thuth@redhat.com>, qemu-devel@nongnu.org, devel@lists.libvirt.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org, Richard
 Henderson <richard.henderson@linaro.org>, Sergio Lopez <slp@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, Jiaxun
 Yang <jiaxun.yang@flygoat.com>, Yi Liu <yi.l.liu@intel.com>, Eduardo
 Habkost <eduardo@habkost.net>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Weiwei Li <liwei1518@gmail.com>, Amit Shah
 <amit@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, Yanan Wang
 <wangyanan55@huawei.com>, Helge Deller <deller@gmx.de>, Palmer Dabbelt
 <palmer@dabbelt.com>, "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Ani Sinha <anisinha@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?B?Q2zDqW1lbnQ=?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, Huacai
 Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>, Mark
 Cave-Ayland <mark.caveayland@nutanix.com>, BALATON Zoltan
 <balaton@eik.bme.hu>, Peter Krempa <pkrempa@redhat.com>, Jiri Denemark
 <jdenemar@redhat.com>
Subject: Re: [PATCH v5 16/28] hw/i386: Remove linuxboot.bin
Message-ID: <20251217155530.3353e904@imammedo>
In-Reply-To: <20251202162835.3227894-17-zhao1.liu@intel.com>
References: <20251202162835.3227894-1-zhao1.liu@intel.com>
 <20251202162835.3227894-17-zhao1.liu@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 LOTS_OF_MONEY=0.001, MONEY_NOHTML=0.069, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Wed,  3 Dec 2025 00:28:23 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>=20
> All machines now use the linuxboot_dma.bin binary, so it's safe to
> remove the non-DMA version (linuxboot.bin).

after applying this patch:

git grep linuxboot.bin

    option_rom[nb_option_roms].bootindex =3D 0;                            =
       =20
    option_rom[nb_option_roms].name =3D "linuxboot.bin";                   =
       =20
    if (fw_cfg_dma_enabled(fw_cfg)) {                                      =
     =20
        option_rom[nb_option_roms].name =3D "linuxboot_dma.bin";           =
       =20
    }       =20

perhaps it should be fixed in previous patch

>=20
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Changes since v4:
>  * Update commit message: not only pc, but also microvm enables
>    DMA for FwCfgState (in microvm_memory_init).
> ---
>  hw/i386/pc.c                  |   3 +-
>  pc-bios/meson.build           |   1 -
>  pc-bios/optionrom/Makefile    |   2 +-
>  pc-bios/optionrom/linuxboot.S | 195 ----------------------------------
>  4 files changed, 2 insertions(+), 199 deletions(-)
>  delete mode 100644 pc-bios/optionrom/linuxboot.S
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 9d88d4a5207a..2e315414aeaf 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -666,8 +666,7 @@ void xen_load_linux(PCMachineState *pcms)
> =20
>      x86_load_linux(x86ms, fw_cfg, PC_FW_DATA, pcmc->pvh_enabled);
>      for (i =3D 0; i < nb_option_roms; i++) {
> -        assert(!strcmp(option_rom[i].name, "linuxboot.bin") ||
> -               !strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
> +        assert(!strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
>                 !strcmp(option_rom[i].name, "pvh.bin") ||
>                 !strcmp(option_rom[i].name, "multiboot_dma.bin"));
>          rom_add_option(option_rom[i].name, option_rom[i].bootindex);
> diff --git a/pc-bios/meson.build b/pc-bios/meson.build
> index efe45c16705d..2f470ed12942 100644
> --- a/pc-bios/meson.build
> +++ b/pc-bios/meson.build
> @@ -63,7 +63,6 @@ blobs =3D [
>    'efi-vmxnet3.rom',
>    'qemu-nsis.bmp',
>    'multiboot_dma.bin',
> -  'linuxboot.bin',
>    'linuxboot_dma.bin',
>    'kvmvapic.bin',
>    'pvh.bin',
> diff --git a/pc-bios/optionrom/Makefile b/pc-bios/optionrom/Makefile
> index 1183ef889228..e694c7aac007 100644
> --- a/pc-bios/optionrom/Makefile
> +++ b/pc-bios/optionrom/Makefile
> @@ -2,7 +2,7 @@ include config.mak
>  SRC_DIR :=3D $(TOPSRC_DIR)/pc-bios/optionrom
>  VPATH =3D $(SRC_DIR)
> =20
> -all: multiboot_dma.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin pvh.=
bin
> +all: multiboot_dma.bin linuxboot_dma.bin kvmvapic.bin pvh.bin
>  # Dummy command so that make thinks it has done something
>  	@true
> =20
> diff --git a/pc-bios/optionrom/linuxboot.S b/pc-bios/optionrom/linuxboot.S
> deleted file mode 100644
> index ba821ab922da..000000000000
> --- a/pc-bios/optionrom/linuxboot.S
> +++ /dev/null
> @@ -1,195 +0,0 @@
> -/*
> - * Linux Boot Option ROM
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, see <http://www.gnu.org/licenses/>.
> - *
> - * Copyright Novell Inc, 2009
> - *   Authors: Alexander Graf <agraf@suse.de>
> - *
> - * Based on code in hw/pc.c.
> - */
> -
> -#include "optionrom.h"
> -
> -#define BOOT_ROM_PRODUCT "Linux loader"
> -
> -BOOT_ROM_START
> -
> -run_linuxboot:
> -
> -	cli
> -	cld
> -
> -	jmp		copy_kernel
> -boot_kernel:
> -
> -	read_fw		FW_CFG_SETUP_ADDR
> -
> -	mov		%eax, %ebx
> -	shr		$4, %ebx
> -
> -	/* All segments contain real_addr */
> -	mov		%bx, %ds
> -	mov		%bx, %es
> -	mov		%bx, %fs
> -	mov		%bx, %gs
> -	mov		%bx, %ss
> -
> -	/* CX =3D CS we want to jump to */
> -	add		$0x20, %bx
> -	mov		%bx, %cx
> -
> -	/* SP =3D cmdline_addr-real_addr-16 */
> -	read_fw		FW_CFG_CMDLINE_ADDR
> -	mov		%eax, %ebx
> -	read_fw		FW_CFG_SETUP_ADDR
> -	sub		%eax, %ebx
> -	sub		$16, %ebx
> -	mov		%ebx, %esp
> -
> -	/* Build indirect lret descriptor */
> -	pushw		%cx		/* CS */
> -	xor		%ax, %ax
> -	pushw		%ax		/* IP =3D 0 */
> -
> -	/* Clear registers */
> -	xor		%eax, %eax
> -	xor		%ebx, %ebx
> -	xor		%ecx, %ecx
> -	xor		%edx, %edx
> -	xor		%edi, %edi
> -	xor		%ebp, %ebp
> -
> -	/* Jump to Linux */
> -	lret
> -
> -
> -copy_kernel:
> -	/* Read info block in low memory (0x10000 or 0x90000) */
> -	read_fw		FW_CFG_SETUP_ADDR
> -	shr		$4, %eax
> -	mov		%eax, %es
> -	xor		%edi, %edi
> -	read_fw_blob_addr32_edi(FW_CFG_SETUP)
> -
> -	cmpw            $0x203, %es:0x206      // if protocol >=3D 0x203
> -	jae             1f                     // have initrd_max
> -	movl            $0x37ffffff, %es:0x22c // else assume 0x37ffffff
> -1:
> -
> -	/* Check if using kernel-specified initrd address */
> -	read_fw		FW_CFG_INITRD_ADDR
> -	mov		%eax, %edi             // (load_kernel wants it in %edi)
> -	read_fw		FW_CFG_INITRD_SIZE     // find end of initrd
> -	add		%edi, %eax
> -	xor		%es:0x22c, %eax        // if it matches es:0x22c
> -	and		$-4096, %eax           // (apart from padding for page)
> -	jz		load_kernel            // then initrd is not at top
> -					       // of memory
> -
> -	/* pc.c placed the initrd at end of memory.  Compute a better
> -	 * initrd address based on e801 data.
> -	 */
> -	mov		$0xe801, %ax
> -	xor		%cx, %cx
> -	xor		%dx, %dx
> -	int		$0x15
> -
> -	/* Output could be in AX/BX or CX/DX */
> -	or		%cx, %cx
> -	jnz		1f
> -	or		%dx, %dx
> -	jnz		1f
> -	mov		%ax, %cx
> -	mov		%bx, %dx
> -1:
> -
> -	or		%dx, %dx
> -	jnz		2f
> -	addw		$1024, %cx            /* add 1 MB */
> -	movzwl		%cx, %edi
> -	shll		$10, %edi             /* convert to bytes */
> -	jmp		3f
> -
> -2:
> -	addw		$16777216 >> 16, %dx  /* add 16 MB */
> -	movzwl		%dx, %edi
> -	shll		$16, %edi             /* convert to bytes */
> -
> -3:
> -	read_fw         FW_CFG_INITRD_SIZE
> -	subl            %eax, %edi
> -	andl            $-4096, %edi          /* EDI =3D start of initrd */
> -	movl		%edi, %es:0x218       /* put it in the header */
> -
> -load_kernel:
> -	/* We need to load the kernel into memory we can't access in 16 bit
> -	   mode, so let's get into 32 bit mode, write the kernel and jump
> -	   back again. */
> -
> -	/* Reserve space on the stack for our GDT descriptor. */
> -	mov             %esp, %ebp
> -	sub             $16, %esp
> -
> -	/* Now create the GDT descriptor */
> -	movw		$((3 * 8) - 1), -16(%bp)
> -	mov		%cs, %eax
> -	movzwl		%ax, %eax
> -	shl		$4, %eax
> -	addl		$gdt, %eax
> -	movl		%eax, -14(%bp)
> -
> -	/* And load the GDT */
> -	data32 lgdt	-16(%bp)
> -	mov		%ebp, %esp
> -
> -	/* Get us to protected mode now */
> -	mov		$1, %eax
> -	mov		%eax, %cr0
> -
> -	/* So we can set ES to a 32-bit segment */
> -	mov		$0x10, %eax
> -	mov		%eax, %es
> -
> -	/* We're now running in 16-bit CS, but 32-bit ES! */
> -
> -	/* Load kernel and initrd */
> -	read_fw_blob_addr32_edi(FW_CFG_INITRD)
> -	read_fw_blob_addr32(FW_CFG_KERNEL)
> -	read_fw_blob_addr32(FW_CFG_CMDLINE)
> -
> -	/* And now jump into Linux! */
> -	mov		$0, %eax
> -	mov		%eax, %cr0
> -
> -	/* ES =3D CS */
> -	mov		%cs, %ax
> -	mov		%ax, %es
> -
> -	jmp		boot_kernel
> -
> -/* Variables */
> -
> -.align 4, 0
> -gdt:
> -	/* 0x00 */
> -.byte	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> -
> -	/* 0x08: code segment (base=3D0, limit=3D0xfffff, type=3D32bit code exe=
c/read, DPL=3D0, 4k) */
> -.byte	0xff, 0xff, 0x00, 0x00, 0x00, 0x9a, 0xcf, 0x00
> -
> -	/* 0x10: data segment (base=3D0, limit=3D0xfffff, type=3D32bit data rea=
d/write, DPL=3D0, 4k) */
> -.byte	0xff, 0xff, 0x00, 0x00, 0x00, 0x92, 0xcf, 0x00
> -
> -BOOT_ROM_END


