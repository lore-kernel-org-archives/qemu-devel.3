Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4642AC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 20:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSkAS-0006zt-Fz; Wed, 24 Jan 2024 15:48:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rSkAP-0006yM-Qy
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 15:48:14 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rSkAK-0001X1-Bs
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 15:48:13 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33921b8988fso5155081f8f.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 12:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706129286; x=1706734086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2DFoEEORhbYqrzpaYOOIPvsx4spA+Behkc0xiRJOJKg=;
 b=pXYrNxbPaufHiqVLrHdrZfSZ8xovHMnhWLwoZ99rLn9+l5bp8DQ6eurqKtizq2pTtM
 pRSfI97cXBPlYWwUkysw4otYVFJ8gejvxj07+jypJAGf+2PlfUAuWrDFW3yz1VlkBWCa
 m5Tq8RJeGO5QDlJfHilOmLoQDWb/UEJYHghKW+eipYNI2IIqIQf5tAYTNeg9nAVzCXq5
 dbm/lFPs9kOCWX68U03mFQ+FtdQ4Z0exwu1VYIRoviWGjXtoIFCrLvoduXUyqC5BaO9l
 R8cuTIbgI23HlojcQycklWyF5OYcaiaFNQC2oL2CdI2vrzxY9zZNbhtCUki5V1FLwJhV
 TeMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706129286; x=1706734086;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2DFoEEORhbYqrzpaYOOIPvsx4spA+Behkc0xiRJOJKg=;
 b=s5KIHE5BFxNuGXVZMtz1F9VJF7Vx2N1s+IsloNfOfjaus0enVmrQn3+08LWJaE/Qkv
 yXeeQ/08QO7XYiuUK7rGyQq1dlBLXNZQRyc2cVXHB3LEPFLFCrh2vi7EPlVIdlrmmOjt
 /4TDOIIT1oS9ShSFs6xMWYDsJ5INyi1oI0ZOZNnq1MfZwMmjMraZla4oE+qMeyUhehgq
 9CG7q96NtnOrlmHJKCuH08XddQscL29hzyDZ9XU5Bq3rbwxKnHUt5wck8C2FCbkXJBRq
 4AOVDz3jg8SSf7QYqnSx4c++GgJg2+oDvoThjmwENe0vBdrf7qJ+5nirEZIOJECdhhfG
 mr7g==
X-Gm-Message-State: AOJu0YweHCm87B5J100ZhaIwcd4fa/HqATMP0Yvc2JINnSHjpGjg4a/t
 hmPsvzTImXqmRC17FPmlF/xH6TWBquVjyRy5IyMYCDGs+s+ZxbHoJbBaT75Fv0w=
X-Google-Smtp-Source: AGHT+IHY14kD5rNW/WqXoLuPWKhJG2siL9M1HTav9Wf26p7ngHZruTutoSDn9MvT5UR5mm2IYM7j0g==
X-Received: by 2002:a05:600c:4fc9:b0:40e:b17d:2f56 with SMTP id
 o9-20020a05600c4fc900b0040eb17d2f56mr1779043wmq.23.1706129285703; 
 Wed, 24 Jan 2024 12:48:05 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 v17-20020a05600c471100b0040d91fa270fsm248736wmo.36.2024.01.24.12.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 12:48:05 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D81A55F754;
 Wed, 24 Jan 2024 20:48:04 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-riscv@nongnu.org,  qemu-s390x@nongnu.org,
 qemu-block@nongnu.org,  qemu-arm@nongnu.org,  Bin Meng
 <bmeng@tinylab.org>,  Richard Henderson <richard.henderson@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PULL 33/36] hw/elf_ops: Ignore loadable segments with zero size
In-Reply-To: <20240119113507.31951-34-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 19 Jan 2024 12:35:02
 +0100")
References: <20240119113507.31951-1-philmd@linaro.org>
 <20240119113507.31951-34-philmd@linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Wed, 24 Jan 2024 20:48:04 +0000
Message-ID: <87r0i65ugr.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> From: Bin Meng <bmeng@tinylab.org>
>
> Some ELF files really do have segments of zero size, e.g.:
>
> Program Headers:
>   Type           Offset             VirtAddr           PhysAddr
>                  FileSiz            MemSiz              Flags  Align
>   RISCV_ATTRIBUT 0x00000000000025b8 0x0000000000000000 0x0000000000000000
>                  0x000000000000003e 0x0000000000000000  R      0x1
>   LOAD           0x0000000000001000 0x0000000080200000 0x0000000080200000
>                  0x00000000000001d1 0x00000000000001d1  R E    0x1000
>   LOAD           0x00000000000011d1 0x00000000802001d1 0x00000000802001d1
>                  0x0000000000000e37 0x0000000000000e37  RW     0x1000
>   LOAD           0x0000000000000120 0x0000000000000000 0x0000000000000000
>                  0x0000000000000000 0x0000000000000000         0x1000
>
> The current logic does not check for this condition, resulting in
> the incorrect assignment of 'lowaddr' as zero.
>
> There is already a piece of codes inside the segment traversal loop
> that checks for zero-sized loadable segments for not creating empty
> ROM blobs. Let's move this check to the beginning of the loop to
> cover both scenarios.
>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20240116155049.390301-1-bmeng@tinylab.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

This has broken Xtensa system emulation:

  =E2=9E=9C  /bin/sh -c "cd builds/bisect; ninja; make check-tcg"
  [8/8] Linking target qemu-system-xtensa
    BUILD   debian-xtensa-cross
    BUILD   xtensa-softmmu guest-tests
    RUN     xtensa-softmmu guest-tests
    TEST    test_bi on xtensa
    TEST    test_boolean on xtensa
    TEST    test_break on xtensa
    TEST    test_b on xtensa
    TEST    test_bz on xtensa
    TEST    test_cache on xtensa
    TEST    test_clamps on xtensa
    TEST    test_dfp0_arith on xtensa
    TEST    test_exclusive on xtensa
    TEST    test_extui on xtensa
    TEST    test_flix on xtensa
    TEST    test_fp0_arith on xtensa
    TEST    test_fp0_conv on xtensa
    TEST    test_fp0_div on xtensa
    TEST    test_fp0_sqrt on xtensa
    TEST    test_fp1 on xtensa
    TEST    test_fp_cpenable on xtensa
    TEST    test_interrupt on xtensa
    TEST    test_load_store on xtensa
  qemu-system-xtensa: Some ROM regions are overlapping
  These ROM regions might have been loaded by direct user request or by def=
ault.
  They could be BIOS/firmware images, a guest kernel, initrd or some other =
file loaded into guest memory.
  Check whether you intended to load all this guest code, and whether it ha=
s been built to load to the correct addresses.

  The following two regions overlap (in the memory address space):
    test_load_store ELF program header segment 1 (addresses 0x0000000000001=
000 - 0x0000000000001f26)
    test_load_store ELF program header segment 2 (addresses 0x0000000000001=
ab8 - 0x0000000000001ab8)
  make[1]: *** [Makefile:187: run-test_load_store] Error 1
  make: *** [/home/alex/lsrc/qemu.git/tests/Makefile.include:56: run-tcg-te=
sts-xtensa-softmmu] Error 2

> ---
>  include/hw/elf_ops.h | 71 +++++++++++++++++++++++---------------------
>  1 file changed, 37 insertions(+), 34 deletions(-)
>
> diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
> index 9c35d1b9da..3e966ddd5a 100644
> --- a/include/hw/elf_ops.h
> +++ b/include/hw/elf_ops.h
> @@ -427,6 +427,16 @@ static ssize_t glue(load_elf, SZ)(const char *name, =
int fd,
>              file_size =3D ph->p_filesz; /* Size of the allocated data */
>              data_offset =3D ph->p_offset; /* Offset where the data is lo=
cated */
>=20=20
> +            /*
> +             * Some ELF files really do have segments of zero size;
> +             * just ignore them rather than trying to set the wrong addr,
> +             * or create empty ROM blobs, because the zero-length blob c=
an
> +             * falsely trigger the overlapping-ROM-blobs check.
> +             */
> +            if (mem_size =3D=3D 0) {
> +                continue;
> +            }
> +
>              if (file_size > 0) {
>                  if (g_mapped_file_get_length(mapped_file) <
>                      file_size + data_offset) {
> @@ -530,45 +540,38 @@ static ssize_t glue(load_elf, SZ)(const char *name,=
 int fd,
>                  *pentry =3D ehdr.e_entry - ph->p_vaddr + ph->p_paddr;
>              }
>=20=20
> -            /* Some ELF files really do have segments of zero size;
> -             * just ignore them rather than trying to create empty
> -             * ROM blobs, because the zero-length blob can falsely
> -             * trigger the overlapping-ROM-blobs check.
> -             */
> -            if (mem_size !=3D 0) {
> -                if (load_rom) {
> -                    g_autofree char *label =3D
> -                        g_strdup_printf("%s ELF program header segment %=
d",
> -                                        name, i);
> +            if (load_rom) {
> +                g_autofree char *label =3D
> +                    g_strdup_printf("%s ELF program header segment %d",
> +                                    name, i);
>=20=20
> -                    /*
> -                     * rom_add_elf_program() takes its own reference to
> -                     * 'mapped_file'.
> -                     */
> -                    rom_add_elf_program(label, mapped_file, data, file_s=
ize,
> -                                        mem_size, addr, as);
> -                } else {
> -                    MemTxResult res;
> +                /*
> +                 * rom_add_elf_program() takes its own reference to
> +                 * 'mapped_file'.
> +                 */
> +                rom_add_elf_program(label, mapped_file, data, file_size,
> +                                    mem_size, addr, as);
> +            } else {
> +                MemTxResult res;
>=20=20
> -                    res =3D address_space_write(as ? as : &address_space=
_memory,
> -                                              addr, MEMTXATTRS_UNSPECIFI=
ED,
> -                                              data, file_size);
> +                res =3D address_space_write(as ? as : &address_space_mem=
ory,
> +                                          addr, MEMTXATTRS_UNSPECIFIED,
> +                                          data, file_size);
> +                if (res !=3D MEMTX_OK) {
> +                    goto fail;
> +                }
> +                /*
> +                 * We need to zero'ify the space that is not copied
> +                 * from file
> +                 */
> +                if (file_size < mem_size) {
> +                    res =3D address_space_set(as ? as : &address_space_m=
emory,
> +                                            addr + file_size, 0,
> +                                            mem_size - file_size,
> +                                            MEMTXATTRS_UNSPECIFIED);
>                      if (res !=3D MEMTX_OK) {
>                          goto fail;
>                      }
> -                    /*
> -                     * We need to zero'ify the space that is not copied
> -                     * from file
> -                     */
> -                    if (file_size < mem_size) {
> -                        res =3D address_space_set(as ? as : &address_spa=
ce_memory,
> -                                                addr + file_size, 0,
> -                                                mem_size - file_size,
> -                                                MEMTXATTRS_UNSPECIFIED);
> -                        if (res !=3D MEMTX_OK) {
> -                            goto fail;
> -                        }
> -                    }
>                  }
>              }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

