Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89350CCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 02:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6gio-0002uA-6I; Wed, 08 Oct 2025 22:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v6gil-0002tn-Ub
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 22:49:35 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v6gii-0001E3-DG
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 22:49:35 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6398ff5fbd3so790329a12.2
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 19:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759978171; x=1760582971; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yH4AuKdoLQ9xOoy/d07/zj/77KvcPhZbDyODxZ+I61E=;
 b=N7maCthYgH6nzjKY9aMa/lA8+2yDI91teBGLEwv5f6LP4X2QD4xUabw8jKDgkSt3q/
 srHxrqwFEf0r6ZjDL7yE3xz9BfypzoYvF/fLGH40mEAIOeSrPsiV4+O+BWF6bqXowWUc
 WFDoutS3TlhjfAlqegN8xH8rcBU40i0kIKZlacX97PGC3BR9PPLzUJASwoJEsONdGy0b
 Qf0P8mtRybSyMlUYcdZPgPVk+RgRlxFE3OTZqPTsWN+IvdxUJ/1p7KgeRUgMvxfoYMr9
 Pl0tWKtPWQZfXf1fU5ecKiXcGixxxqaP7dis1eFT4/htw+3eQylvw2XQIHuQGDe91umw
 zQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759978171; x=1760582971;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yH4AuKdoLQ9xOoy/d07/zj/77KvcPhZbDyODxZ+I61E=;
 b=hJcUcHWctJG9zPdZ+uAPOekbVyT7Fxv6eQdsdNRn7AM/AJiK2+AnO5HbQhrpqXJdV+
 r3KLot6TGKaQrEcw8oiVVCBpTf+Ixg3ZJw9Wg6Dh29fpyx55Dn68ey9+dU3Fp+jVsjMx
 ZAfwRY8tur7LceJDoIHPMo/G9fS41fqpowQwwxnXOy5YLFGW4aaIkkHjH2D1fzKcKBbJ
 YfKL9cjuGLpcA2gxzEZgR9htZs0kHSBMQ3F+55Mx5qxmen0Z1c909LiEHSmk8PotKsu7
 o9HvQYx3JJIZbuz6xNeyhGcdNk2UPSb31kYiQuG8oAFYcjiMX2qPFDg4MMVyH4qtdD8N
 Khaw==
X-Gm-Message-State: AOJu0Yyv+vNtzelwhiSdbfEhPjCr3XCRj847kqpNVq8M1FqcYLEy/mLe
 nbyqoDcHnD23N9UY3DjH+vY5o6scCKvU7Cy6Kpx24BbjBiZteuu7dDcUWQn4YjG0YXvjY8pdr9D
 kkxR8IjtWyC7+Bv/eGgl2rrqoTOME8DQ=
X-Gm-Gg: ASbGncs5ubT5x6KqekRQkJA89x4zKEIHCd9edy+XQ2azrrYUS9lG7e4wudMqyOyRN7+
 AQroUZW1y5591jJSyvCQAXC9NhM7tHiqtsj02okzbIJ8YrIdXb0nF1clH9QEhO8RWAPnkNCgqS8
 9NJeUlO6akQzNIFVlKFjBqNOkjzEKjGUmkNanvJ1RbMjbRgQ3Fzy3AHc1hAm5oMAWGz1w4LoQRM
 d7X+A5/BnaGCQG6jFseGfrR2JLanP38NAsNEJuS/7CfUOrE3ACBlKBafPdbZg==
X-Google-Smtp-Source: AGHT+IGRfo40TUXjHZT8oRa0hRePykXcyz3MHRTohWErytqZEswdQE7sH9onc8Ut/2FRlTx0lkHzFF+RXyTZomic1Ms=
X-Received: by 2002:a05:6402:5205:b0:634:5297:e3bc with SMTP id
 4fb4d7f45d1cf-639d5b5e42bmr5619004a12.6.1759978170577; Wed, 08 Oct 2025
 19:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1759744337.git.neither@nut.email>
 <a3059c9e241a7ab5749db825908550768de81e9a.1759744337.git.neither@nut.email>
In-Reply-To: <a3059c9e241a7ab5749db825908550768de81e9a.1759744337.git.neither@nut.email>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 Oct 2025 12:49:03 +1000
X-Gm-Features: AS18NWDW88rGHjAH7iLE1Do9d_uucpsQB8X_6KIVoOY7FDOjJxwoZGOX1_voW6Y
Message-ID: <CAKmqyKNDGK4EPNqi7GohoqY6N=t2aPa_Kdo8yRqRuQrO0ZnC3Q@mail.gmail.com>
Subject: Re: [PATCH v7 24/25] tests: add test for double-traps on rv64
To: Julian Ganz <neither@nut.email>
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x534.google.com
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

On Tue, Oct 7, 2025 at 1:22=E2=80=AFAM Julian Ganz <neither@nut.email> wrot=
e:
>
> We do have a number of test-case for various architectures exercising
> their interrupt/exception logic. However, for the recently introduced
> trap API we also want to exercise the logic for double traps on at least
> one architecture.
>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Signed-off-by: Julian Ganz <neither@nut.email>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/tcg/riscv64/Makefile.softmmu-target |  6 ++
>  tests/tcg/riscv64/doubletrap.S            | 73 +++++++++++++++++++++++
>  2 files changed, 79 insertions(+)
>  create mode 100644 tests/tcg/riscv64/doubletrap.S
>
> diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv6=
4/Makefile.softmmu-target
> index 3ca595335d..1a71a78653 100644
> --- a/tests/tcg/riscv64/Makefile.softmmu-target
> +++ b/tests/tcg/riscv64/Makefile.softmmu-target
> @@ -24,5 +24,11 @@ EXTRA_RUNS +=3D run-test-mepc-masking
>  run-test-mepc-masking: test-mepc-masking
>         $(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
>
> +EXTRA_RUNS +=3D run-plugin-doubletrap
> +run-plugin-doubletrap: doubletrap
> +       $(call run-test, $<, \
> +         $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $*.pout \
> +         $(QEMU_OPTS)$<)
> +
>  # We don't currently support the multiarch system tests
>  undefine MULTIARCH_TESTS
> diff --git a/tests/tcg/riscv64/doubletrap.S b/tests/tcg/riscv64/doubletra=
p.S
> new file mode 100644
> index 0000000000..b61089c9c1
> --- /dev/null
> +++ b/tests/tcg/riscv64/doubletrap.S
> @@ -0,0 +1,73 @@
> +       .option norvc
> +
> +       .text
> +       .global _start
> +_start:
> +       # Set up vectored interrupts
> +       lla     t0, trap
> +       add     t0, t0, 1
> +       csrw    mtvec, t0
> +
> +       # Enable sw interrupts
> +       csrrsi  zero, mie, 0x8
> +       csrrsi  zero, mstatus, 0x8
> +
> +       # Engage the double trap: we trigger an machine-level software
> +       # interrupt, which will trap to an illegal instruction
> +       lui     t1, 0x02000
> +       li      t0, 1
> +       sw      t0, 0(t1)
> +
> +       # If we still not went out via the software interrupt route after=
 a
> +       # short while, we failed the test.
> +       lui     t0, 0x1
> +0:
> +       addi    t0, t0, -1
> +       bnez    t0, 0b
> +       j       fail
> +
> +trap:
> +       j       illegal_insn # Exceptions
> +       j       fail # Supervisor software interrupt
> +       j       fail
> +       .insn   i CUSTOM_0, 0, x0, x0, 0 # Machine software interrupt
> +       j       fail
> +       j       fail # Supervisor timer interrupt
> +       j       fail
> +       j       fail # Machine timer interrupt
> +       j       fail
> +       j       fail # Supervisor external interrupt
> +       j       fail
> +       j       fail # Machine external interrupt
> +       j       fail
> +       j       fail # Counter overflow interrupt
> +       j       fail
> +       j       fail
> +
> +illegal_insn:
> +       # Check whether we really got an illegal instruction
> +       csrr    t0, mcause
> +       li      t1, 2
> +       bne     t0, t1, fail
> +       li      a0, 0
> +       j       _exit
> +fail:
> +       li      a0, 1
> +_exit:
> +       lla     a1, semiargs
> +       li      t0, 0x20026     # ADP_Stopped_ApplicationExit
> +       sd      t0, 0(a1)
> +       sd      a0, 8(a1)
> +       li      a0, 0x20        # TARGET_SYS_EXIT_EXTENDED
> +
> +       # Semihosting call sequence
> +       .balign 16
> +       slli    zero, zero, 0x1f
> +       ebreak
> +       srai    zero, zero, 0x7
> +       j       .
> +
> +       .data
> +       .balign 16
> +semiargs:
> +       .space  16
> --
> 2.49.1
>
>

