Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C34CDB46B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 04:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbWLS-0006v0-7o; Mon, 22 Jun 2026 00:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbWLQ-0006ur-H2
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 00:33:12 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbWLO-0003Nj-FY
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 00:33:12 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6976b0b2c79so1865563a12.2
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2026 21:33:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782102786; cv=none;
 d=google.com; s=arc-20240605;
 b=EXtZRZM3XkaG8UeUx9XFlAB6aM2GcRC30tFSsqXPJiG9VyGSwVx48jwWl6EkLit4cW
 MSVbGukt0e5sXa8ztkSc0fkCZELACCDT7E8ffmTsNGvlbUF5tgLQUMPk3wKPL3fd2ZSh
 d6O9NQ0RdL/ZngQynDCWXCPT2yyqdHuZFIaA+E/EsmDHdiscaj2wSXBkXeXpGRg9KEeX
 upXz17G4Uw6A0UTYz/JGYlVckdO1oHw/NIN6idtEhT85g648dgmx2edqV5b1KNGmMr7O
 oBtF4XO2i4MpS4BCRWUyJRvj+yc0XasvuKtWyz32iHQo6Uy9ALTey0dtcD5k9rJk6mzO
 QkmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iko6qtzR7nj/j+3wcvz/v6ftuT0oukRMIn9XinJ6kbY=;
 fh=V1EDceZ7zChz1s3YL4ehFSwq5J2qCDoED4kdD9wvJ5c=;
 b=drVJLb+Hrk+ca7HoITF8ar0u3h9ZXCvxTo4AVg6DaeKJ1hb+B4Er6ELLSBEUpEVAKR
 idwoJEtAggVJPrXh4dLYGgwt2QzILnjGQa7uaJG/TPLxV0UDdO/ts2xyP+ECngThIXKq
 GmN+zQvwHGyPpGvtkiM3C6szVaOZU49fTAYZeKJKVsUjVIu/wGo9Hl+HJrPcrsWMahKx
 yUrGDW0h2qW2AscycRrs/NhxFgSudFEXDczNCWaBUCoBfdifWZlo/lF6qePOgrtPimSb
 EGxrWsi7lm/ZUj16DjYas++liX3xU9qlLjvimVGRxggTZ97a9Cg4FQ3AYEPkBWQkOvJY
 AVCw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782102786; x=1782707586; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iko6qtzR7nj/j+3wcvz/v6ftuT0oukRMIn9XinJ6kbY=;
 b=hGX8oXxuDcfVBKjSva5bqpcAbOJgVlSVBYRuEYvAlsKBEpcr4TofIhzP/hfQEFdCuC
 LXu1o3kEjZjUYBq479LGvaHW9wjK1jGsul8nE4wPZKem3SHc32cSX4hw/BDeSQCZgT8n
 x2/5O4lknYcUBA7Y3WEb3pGC/02FDe8CND13kJW2ZbWnW//6c7qcGHdboNkHkYU2m3ES
 i5Tnn5RvF/ay6ScJbck1DQ2p66pbwzbd1RiAHVXDtnSF6brQtq5sFbVde7WkIud4u8xk
 Yg+ThLfOg/NWJYBVjF+2Ho8n0E0shZI4CL3ezuACvLrwKgcIdJy/LjcvaraX4ZP+fcPs
 /pLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782102786; x=1782707586;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iko6qtzR7nj/j+3wcvz/v6ftuT0oukRMIn9XinJ6kbY=;
 b=Js1tnPx1EjdBeJWAkdX5/z3BxjawwuBa9apMWwyM6rMCNA2Pjulr+P7Y6crqwxzii7
 zAU2gL+MA1QV0Zsf+Y4bME7c0qiIgAeB+yfAmAreXzbjoxPzHCqFtFUe5Ro2QuYs4Y1F
 BUagrtxQ63yWCzIR9wPwuJcgM0uIq5V+oI8lPAsDSxWahPlzthzQtjl/prOJU37MWr1J
 9NTpMHtuuoODGGEBjhacHKwDWRalbVD4ruQA0DZii1+McIipLgG9aDWuXWCU1KzAedpj
 FcFXh9MbnF/Ix+KULLCnTIDp4RD4Rj7c+e+Ajd6AQFRVDEzQexNdFccgCwEk1kpQX8Az
 hQJA==
X-Gm-Message-State: AOJu0YylVuJ1UABdJ8gLlVidgKGWFryu6rnjeVfFp1QJeSzsh+uVLc9Z
 dePxD0ke4JKQVyoopM9raiujA8evGjJyju+kzuSNPf0evbHIX0ZMkLqKQpvy4E4kKa425JUZpwi
 VtOC9GWcTc7rVic6zB5AdqBgac4iAoPg=
X-Gm-Gg: AfdE7cnNpzCs+DBfco5EHN+fM6OADS+gCn7RiHL27AU/lV72aPxVJcdyTCbqQRqZv/7
 LzZ90tFuKdyTuIJd0wXrLlbuOIshhmuAnaVsdsIMbydSeky5arK1XAJhmRQ3awWMb2uq4A+v2dh
 2AWWRT8rQ4VvUsl9TvpDsI5KOuHFsM7IxaSpeqyRlYw/W3uEi1Z4UvnkmqYDmZeG6bzlFOHF5Rb
 BIaRYLC6MLCoOSeKBDY+H23h9Cfidty9BjsUm6Ay1ly7OagDBrQbbDIxnbk7pyMkRtKR2PISsLQ
 s8Ga+WN0WVFpU6eXMXG5IDUbbRc=
X-Received: by 2002:a05:6402:2482:b0:676:9c6d:7448 with SMTP id
 4fb4d7f45d1cf-6975689013amr5057775a12.22.1782102786339; Sun, 21 Jun 2026
 21:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260619-fix-sign-extended-32-bit-addresses-v1-0-47ae14f8e8c5@maquefel.me>
 <20260619-fix-sign-extended-32-bit-addresses-v1-2-47ae14f8e8c5@maquefel.me>
In-Reply-To: <20260619-fix-sign-extended-32-bit-addresses-v1-2-47ae14f8e8c5@maquefel.me>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 22 Jun 2026 14:32:39 +1000
X-Gm-Features: AVVi8Ce9giIifPnXBsyn448i_mXtQjBVUvXQDK5kv5Fq0EhKtQ0AGUswpGkRwRI
Message-ID: <CAKmqyKO+kXkAxcmbf2kACG-ZvBQcFXsL_pMTOPwtz4D=SDg1Jw@mail.gmail.com>
Subject: Re: [PATCH 2/2] tests/tcg/riscv32: Add RISC-V 32-bit semihosting test
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jun 19, 2026 at 7:53=E2=80=AFPM Nikita Shubin <nikita.shubin@maquef=
el.me> wrote:
>
> Extend the TCG test infrastructure to support 32-bit RISC-V (riscv32)
> system tests.
>
> - configure: Add riscv32 to probe_target_compiler() using the same
>   container (debian-all-test-cross) as riscv64, with cross prefix
>   riscv64-linux-gnu- (the compiler can generate 32-bit code with
>   -march=3Drv32imafdch -mabi=3Dilp32d).
>
> - tests/tcg/riscv32/: New directory with:
>   * Makefile.softmmu-target =E2=80=93 build rules for 32-bit softmmu test=
s
>   * semihost.ld =E2=80=93 linker script (same as riscv64, RAM at 0x800000=
00)
>   * test-semihosting-open.S =E2=80=93 test for SYS_OPEN with auto length =
(-1)
>
> The semihosting test validates the fix for sign-extended 32-bit
> pointers when running riscv32 guests on qemu-system-riscv32.
>
> CFLAGS and LDFLAGS are explicitly set for rv32imafdch/ilp32d ABI,
> and LDFLAGS includes -melf32lriscv to produce 32-bit ELF.
>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  configure                                 |  6 +++-
>  tests/tcg/riscv32/Makefile.softmmu-target | 30 +++++++++++++++++
>  tests/tcg/riscv32/semihost.ld             | 24 +++++++++++++
>  tests/tcg/riscv32/test-semihosting-open.S | 56 +++++++++++++++++++++++++=
++++++
>  4 files changed, 115 insertions(+), 1 deletion(-)
>
> diff --git a/configure b/configure
> index d8bc10060e..2df0811b5d 100755
> --- a/configure
> +++ b/configure
> @@ -1405,7 +1405,7 @@ probe_target_compiler() {
>      mips) container_hosts=3Dx86_64 ;;
>      ppc) container_hosts=3Dx86_64 ;;
>      ppc64|ppc64le) container_hosts=3Dx86_64 ;;
> -    riscv64) container_hosts=3Dx86_64 ;;
> +    riscv32|riscv64) container_hosts=3Dx86_64 ;;
>      s390x) container_hosts=3Dx86_64 ;;
>      sh4) container_hosts=3Dx86_64 ;;
>      sparc64) container_hosts=3Dx86_64 ;;
> @@ -1424,6 +1424,10 @@ probe_target_compiler() {
>          container_image=3Ddebian-all-test-cross
>          container_cross_prefix=3Daarch64-linux-gnu-
>          ;;
> +      riscv32)
> +        container_image=3Ddebian-all-test-cross
> +        container_cross_prefix=3Driscv64-linux-gnu-
> +        ;;
>        alpha|hppa|m68k|mips|mipsel|riscv64|sh4|sparc64)
>          container_image=3Ddebian-all-test-cross
>          ;;
> diff --git a/tests/tcg/riscv32/Makefile.softmmu-target b/tests/tcg/riscv3=
2/Makefile.softmmu-target
> new file mode 100644
> index 0000000000..eff5b000f0
> --- /dev/null
> +++ b/tests/tcg/riscv32/Makefile.softmmu-target
> @@ -0,0 +1,30 @@
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# RISC-V 32-bit system tests
> +#
> +
> +TEST_SRC =3D $(SRC_PATH)/tests/tcg/riscv32
> +VPATH +=3D $(TEST_SRC)
> +
> +LINK_SCRIPT =3D $(TEST_SRC)/semihost.ld
> +LDFLAGS =3D -T $(LINK_SCRIPT)
> +CFLAGS +=3D -g -Og
> +
> +%.o: %.S
> +       $(CC) $(CFLAGS) $< -Wa,--noexecstack -c -o $@
> +%: %.o $(LINK_SCRIPT)
> +       $(LD) $(LDFLAGS) $< -o $@
> +
> +QEMU_OPTS +=3D -M virt -display none -semihosting -device loader,file=3D
> +# provide flags for riscv32 as we are using riscv64-linux-gnu-
> +CFLAGS +=3D -march=3Drv32imafdch -mabi=3Dilp32d
> +LDFLAGS +=3D -melf32lriscv
> +
> +EXTRA_RUNS +=3D run-semihosting-open
> +run-semihosting-open: test-semihosting-open
> +       $(call run-test, $<, \
> +         $(QEMU) $(QEMU_OPTS)$<)
> +
> +# We don't currently support the multiarch system tests
> +undefine MULTIARCH_TESTS
> \ No newline at end of file
> diff --git a/tests/tcg/riscv32/semihost.ld b/tests/tcg/riscv32/semihost.l=
d
> new file mode 100644
> index 0000000000..ff3b786481
> --- /dev/null
> +++ b/tests/tcg/riscv32/semihost.ld
> @@ -0,0 +1,24 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +ENTRY(_start)
> +
> +SECTIONS
> +{
> +    /* virt machine, RAM starts at 2gb */
> +    . =3D 0x80000000;
> +    .text : {
> +        *(.text)
> +    }
> +    .rodata : {
> +        *(.rodata)
> +    }
> +    /* align r/w section to next 2mb */
> +    . =3D ALIGN(1 << 21);
> +    .data : {
> +        *(.data)
> +    }
> +    .bss : {
> +        *(.bss)
> +    }
> +}
> diff --git a/tests/tcg/riscv32/test-semihosting-open.S b/tests/tcg/riscv3=
2/test-semihosting-open.S
> new file mode 100644
> index 0000000000..acbb31c558
> --- /dev/null
> +++ b/tests/tcg/riscv32/test-semihosting-open.S
> @@ -0,0 +1,56 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +.option norvc
> +.text
> +.global _start
> +_start:
> +    # Argument block for SYS_OPEN (each arg is 4 bytes in RV32)
> +    la      a1, open_args
> +    la      t0, test_filename
> +    sw      t0, 0(a1)          # arg0: pointer to filename
> +    li      t0, 4              # arg1: "w" (write, create, truncate)
> +    sw      t0, 4(a1)
> +    li      t0, -1             # arg2: auto length (-1 =3D 0xffffffff)
> +    sw      t0, 8(a1)
> +
> +    # SYS_OPEN semihosting call
> +    li      a0, 0x01
> +    .balign 16
> +    slli    zero, zero, 0x1f
> +    ebreak
> +    srai    zero, zero, 0x7
> +
> +    # Check result: a0 should be a valid file descriptor (not -1)
> +    li      t0, -1
> +    beq     a0, t0, fail
> +
> +    # Success
> +    li      a0, 0
> +    j       exit
> +
> +fail:
> +    li      a0, 1
> +
> +exit:
> +    # Extended semihosting exit
> +    la      a1, semiargs
> +    li      t0, 0x20026        # ADP_Stopped_ApplicationExit
> +    sw      t0, 0(a1)
> +    sw      a0, 4(a1)
> +    li      a0, 0x20           # TARGET_SYS_EXIT_EXTENDED
> +    .balign 16
> +    slli    zero, zero, 0x1f
> +    ebreak
> +    srai    zero, zero, 0x7
> +
> +    j       .
> +
> +.data
> +.balign 16
> +test_filename:
> +    .string "testfile.txt"
> +open_args:
> +    .space 12                  # 3 * 4 bytes
> +semiargs:
> +    .space 8                   # 2 * 4 bytes
>
> --
> 2.52.0
>
>

