Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B2AFEA802
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 03:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Eao-0008AG-8a; Tue, 24 Mar 2026 23:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5Eam-00089l-D4
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 23:07:36 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5Eak-0006Ru-80
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 23:07:36 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-66a33f61d80so3202586a12.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 20:07:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774408052; cv=none;
 d=google.com; s=arc-20240605;
 b=Xf815LJu/PPhkprieyPlqNitHscq1zOEjMhX/LrCFFZmW96hDAgs6rNEA2nPh4T/8S
 L3fnq0Evzh/9DXgw/ZEUniIrBx58S0kkb7xd8uxQKyXeb33PNbrUVMr4uz1L2Y7xnPjZ
 JMy2NNQbjNv/wmFTukfRvesRx4HBKeMUClJR5m+28jvuWmdBTx7NwV8XYn3ADbqvJBMD
 Oyv8I260cQEHsPuL1/DkZtINnXK99gR3jpERo/9R0w3y9oQUs7YMeZM1ae3GtPOefr09
 gHlywROChA5g4MBi440AO9EYN1GOc/vyKfqJY70HI7Pxgu5SbBlPBrN3QBDdRvNpjQIH
 nPDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nm+XSK+m+BhdDCY4BQHWionLiFCoJ0AoHqQNzBS91MI=;
 fh=Gjj0O3ByZUBWoglWgnr+x42s5tjVWzy6EDyY+nxV49E=;
 b=Q1PeMKOcIvHy5LVD6neIrpUOc+ZBkyD/XumKDlbJ0IJux2Gx0ecG564Q22jrkbiAzO
 zAkMOMXuKYAqF9zpuX/HMuhkHGq6oqLAorWWbiIaDs++Ia/lZuzsrmN5Wq7WkTKniWEh
 0z7g8tc5/wpCgJFrPe8lGhk82s7cstoRnPHYTyoo1qJFm8WZSyLikpifbybeKAvlj/UT
 MjVFlnwJ+8MURfJRCk/HJsr8Fw57u9MD/NEUTrFAwjf4zSYwj5/19nw1o3PAnU8mOy+8
 iVlfEbbMlnkuvfDk/qyB2Xfi6eX5lkTqaskhCAiy+p5z9OI9qHTkhp1gcE0Xl//TMSQm
 tvww==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774408052; x=1775012852; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nm+XSK+m+BhdDCY4BQHWionLiFCoJ0AoHqQNzBS91MI=;
 b=RS05U8RSt1XmJ1IalTDGRqaSOgDqDH7wD7BQmU5brCeGPGAPe4E9mn1jAf10GlbDh7
 ohk9Lnt7Q47lcQGi2whGuk/gGftxDs1cD8MMKDdM8e411ikuUx+VeBfUOSnqf1uKZOHi
 nnYpQYRBznozDg3itnsjvCWJvM0AH7Fy+3tgLDOgM4MeENyJ7i3C22r0nkhD1PmbsbRp
 q60pblYTa9sTn/r+Aol750piiU36ni4oW0y0gH67mbBoPhENBrTeGvxhqzmWNN8Fo1Jn
 ztAQTWnuT33RTDlkQvMRJvh95GknPDO0LC0shqNNIuHtYV6TpqGRNKCBr/COFTMWB3hC
 bRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774408052; x=1775012852;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nm+XSK+m+BhdDCY4BQHWionLiFCoJ0AoHqQNzBS91MI=;
 b=GxfJHGq9KE3XF+nUzEKj4b0N5sdufdd2rwg9OGR+TQsv8slFk+amk8gfVA4/lg67YA
 EfL99xn4kVJhqEYj1LXzx/mC14YF40EmyzJMdmgixp5aLQ9rcyKPASNb2Z8CmYp2X1jV
 vD8CMFwfOGKEJK/bvXpBOn84RCK5qR7+TZiHBkZ19HjvdW74hVOYDtwF45Epe4/dCAzD
 /r+kSPIcGQ7LyJPR0wEcZH/Ivd2PDsP/HME+Zia6rkw+TFJjrS86sul4cZEl0qqyqG49
 UgKN+n8IMg3fBGmFMyNTDImunaoNgg3RZOSVqwBNvgQujiZNU0quObsQuSHk3yvPQVhW
 gNVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVns6WTeSDpbb8XSkdn8KvgmNIbSrULIu7nB+emyq6N9ptm2Ci9BsX7slTna5YLxFvAn0uzbxsddnLL@nongnu.org
X-Gm-Message-State: AOJu0Yw36X130o/iSNziBPbgJ++PHslW54vnQvXry6p6aeViR9LJozvJ
 rhltzc6TZ1+6w5mLuoqsPMWPXuONXn7YYAakkrQK+su/1MtnOaCVxFklq0fssHWKDUl87TzaHz6
 pDr+RJHrmrUxdd48RsfSn7WOyv27f1U0ro3P0
X-Gm-Gg: ATEYQzykuT25qi/zF+bfWTcTT377T2CCGqMfMoa0L6COcK5HU0hzBsko5qSQ2jxKErV
 vYUReXFcBNkUdK6pgEjCisGac8pnVmPJeWrpOJZ876TlLj780O3FWZpqV0xG/7g80g9nhpr/VeG
 J8gdxbQ7YxHcyCIH2lEZag8HCT0/sthLglFzDe0uc8YKScmWv9pn1Xj/wgoes65LF2+GZaTOi2E
 pSbIh+G5Yhn9SHq5QHCiC/JwHW3AQfA4n801j/0U4Pp0X30FBHEBRIJYx2Ti7pH+JqPhRF/ZT4j
 6Fni9LSS8P4tkLa1P0xsMUbrGiF1BWgwpKT+AQ==
X-Received: by 2002:a17:907:1c87:b0:b93:6ae4:aa83 with SMTP id
 a640c23a62f3a-b9a3f1aef56mr112309766b.18.1774408052230; Tue, 24 Mar 2026
 20:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260321141345.599105-1-npiggin@gmail.com>
 <20260321141345.599105-2-npiggin@gmail.com>
In-Reply-To: <20260321141345.599105-2-npiggin@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 25 Mar 2026 13:07:05 +1000
X-Gm-Features: AQROBzCLkzaFNg7LJT2GAz-pvlBvLbzU1IU2Y3OcdvkZK97GY9WXZqZSRXrQR_Q
Message-ID: <CAKmqyKPWK+e9sd8Rk-5k_NSyHzJ-nrhPfdERrwOuo-qhYDC6_g@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] tests/tcg/riscv64: Add a user signal handling test
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52c.google.com
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

On Sun, Mar 22, 2026 at 12:16=E2=80=AFAM Nicholas Piggin <npiggin@gmail.com=
> wrote:
>
> Add a few basic signal handling tests for user emulation.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/tcg/riscv64/Makefile.target        |   5 +
>  tests/tcg/riscv64/test-signal-handling.c | 303 +++++++++++++++++++++++
>  2 files changed, 308 insertions(+)
>  create mode 100644 tests/tcg/riscv64/test-signal-handling.c
>
> diff --git a/tests/tcg/riscv64/Makefile.target b/tests/tcg/riscv64/Makefi=
le.target
> index 4da5b9a3b3..f318891396 100644
> --- a/tests/tcg/riscv64/Makefile.target
> +++ b/tests/tcg/riscv64/Makefile.target
> @@ -18,3 +18,8 @@ TESTS +=3D test-fcvtmod
>  test-fcvtmod: CFLAGS +=3D -march=3Drv64imafdc
>  test-fcvtmod: LDFLAGS +=3D -static
>  run-test-fcvtmod: QEMU_OPTS +=3D -cpu rv64,d=3Dtrue,zfa=3Dtrue
> +
> +# Test signal handling.
> +TESTS +=3D test-signal-handling
> +test-signal-handling: CFLAGS +=3D -march=3Drv64gc
> +run-test-signal-handling: QEMU_OPTS +=3D -cpu rv64
> diff --git a/tests/tcg/riscv64/test-signal-handling.c b/tests/tcg/riscv64=
/test-signal-handling.c
> new file mode 100644
> index 0000000000..c202503382
> --- /dev/null
> +++ b/tests/tcg/riscv64/test-signal-handling.c
> @@ -0,0 +1,303 @@
> +/*
> + * Test for linux-user signal handling.
> + *
> + * This ensures that integer and fp register values are
> + * saved as expected in the sigcontext, created by a SIGILL.
> + *
> + * TODO: Register restore is not explicitly verified, except
> + * for advancing pc, and the restoring of registers that were
> + * clobbered by the compiler in the signal handler.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#define _GNU_SOURCE
> +#include <stdlib.h>
> +#include <stdint.h>
> +#include <string.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <execinfo.h>
> +#include <unistd.h>
> +#include <assert.h>
> +#include <sys/mman.h>
> +#include <ucontext.h>
> +#include <asm/sigcontext.h>
> +
> +/*
> + * This horrible hack seems to be required when including
> + * signal.h and asm/sigcontext.h, to prevent sigcontext
> + * redefinition by bits/sigcontext.h :(
> + *
> + * bits/sigcontext.h does not have the extended state or
> + * RISCV_V_MAGIC, etc. It could have just been introduced
> + * as a new type.
> + */
> +#define _BITS_SIGCONTEXT_H 1
> +#include <signal.h>
> +
> +static uint64_t *initial_gvalues;
> +static uint64_t *final_gvalues;
> +static uint64_t *signal_gvalues;
> +static double *initial_fvalues;
> +static double *final_fvalues;
> +static double *signal_fvalues;
> +
> +extern unsigned long unimp_addr[];
> +
> +static bool got_signal =3D false;
> +
> +#define BT_BUF_SIZE 100
> +
> +static void *find_callchain_root(void)
> +{
> +   int nptrs;
> +   void *buffer[BT_BUF_SIZE];
> +
> +   nptrs =3D backtrace(buffer, BT_BUF_SIZE);
> +
> +   return buffer[nptrs - 1];
> +}
> +
> +static void *callchain_root;
> +
> +static void ILL_handler(int signo, siginfo_t *info, void *context)
> +{
> +    ucontext_t *uc =3D context;
> +    struct sigcontext *sc =3D (struct sigcontext *)&uc->uc_mcontext;
> +
> +    got_signal =3D true;
> +
> +    assert(unimp_addr =3D=3D info->si_addr);
> +    assert(sc->sc_regs.pc =3D=3D (unsigned long)info->si_addr);
> +
> +    /* Ensure stack unwind through the signal frame is not broken */
> +    assert(callchain_root =3D=3D find_callchain_root());
> +
> +    for (int i =3D 0; i < 31; i++) {
> +        ((uint64_t *)signal_gvalues)[i] =3D ((unsigned long *)&sc->sc_re=
gs.ra)[i];
> +    }
> +
> +    for (int i =3D 0; i < 32; i++) {
> +        ((uint64_t *)signal_fvalues)[i] =3D sc->sc_fpregs.d.f[i];
> +    }
> +    /* Test sc->sc_fpregs.d.fcsr ? */
> +
> +    sc->sc_regs.pc +=3D 4;
> +}
> +
> +static void init_test(void)
> +{
> +    int i;
> +
> +    callchain_root =3D find_callchain_root();
> +
> +    initial_gvalues =3D malloc(8 * 31);
> +    memset(initial_gvalues, 0, 8 * 31);
> +    final_gvalues =3D malloc(8 * 31);
> +    memset(final_gvalues, 0, 8 * 31);
> +    signal_gvalues =3D malloc(8 * 31);
> +    memset(signal_gvalues, 0, 8 * 31);
> +
> +    initial_fvalues =3D malloc(8 * 32);
> +    memset(initial_fvalues, 0, 8 * 32);
> +    for (i =3D 0; i < 32 ; i++) {
> +        initial_fvalues[i] =3D 3.142 * (i + 1);
> +    }
> +    final_fvalues =3D malloc(8 * 32);
> +    memset(final_fvalues, 0, 8 * 32);
> +    signal_fvalues =3D malloc(8 * 32);
> +    memset(signal_fvalues, 0, 8 * 32);
> +}
> +
> +static void run_test(void)
> +{
> +    asm volatile(
> +    /* Save initial values from gp registers */
> +    "mv    t0, %[initial_gvalues]\n\t"
> +    "sd    x1, 0x0(t0)\n\t"
> +    "sd    x2, 0x8(t0)\n\t"
> +    "sd    x3, 0x10(t0)\n\t"
> +    "sd    x4, 0x18(t0)\n\t"
> +    "sd    x5, 0x20(t0)\n\t"
> +    "sd    x6, 0x28(t0)\n\t"
> +    "sd    x7, 0x30(t0)\n\t"
> +    "sd    x8, 0x38(t0)\n\t"
> +    "sd    x9, 0x40(t0)\n\t"
> +    "sd    x10, 0x48(t0)\n\t"
> +    "sd    x11, 0x50(t0)\n\t"
> +    "sd    x12, 0x58(t0)\n\t"
> +    "sd    x13, 0x60(t0)\n\t"
> +    "sd    x14, 0x68(t0)\n\t"
> +    "sd    x15, 0x70(t0)\n\t"
> +    "sd    x16, 0x78(t0)\n\t"
> +    "sd    x17, 0x80(t0)\n\t"
> +    "sd    x18, 0x88(t0)\n\t"
> +    "sd    x19, 0x90(t0)\n\t"
> +    "sd    x20, 0x98(t0)\n\t"
> +    "sd    x21, 0xa0(t0)\n\t"
> +    "sd    x22, 0xa8(t0)\n\t"
> +    "sd    x23, 0xb0(t0)\n\t"
> +    "sd    x24, 0xb8(t0)\n\t"
> +    "sd    x25, 0xc0(t0)\n\t"
> +    "sd    x26, 0xc8(t0)\n\t"
> +    "sd    x27, 0xd0(t0)\n\t"
> +    "sd    x28, 0xd8(t0)\n\t"
> +    "sd    x29, 0xe0(t0)\n\t"
> +    "sd    x30, 0xe8(t0)\n\t"
> +    "sd    x31, 0xf0(t0)\n\t"
> +    /* Load initial values into float registers */
> +    "mv    t0, %[initial_fvalues]\n\t"
> +    "fld    f0, 0x0(t0)\n\t"
> +    "fld    f1, 0x8(t0)\n\t"
> +    "fld    f2, 0x10(t0)\n\t"
> +    "fld    f3, 0x18(t0)\n\t"
> +    "fld    f4, 0x20(t0)\n\t"
> +    "fld    f5, 0x28(t0)\n\t"
> +    "fld    f6, 0x30(t0)\n\t"
> +    "fld    f7, 0x38(t0)\n\t"
> +    "fld    f8, 0x40(t0)\n\t"
> +    "fld    f9, 0x48(t0)\n\t"
> +    "fld    f10, 0x50(t0)\n\t"
> +    "fld    f11, 0x58(t0)\n\t"
> +    "fld    f12, 0x60(t0)\n\t"
> +    "fld    f13, 0x68(t0)\n\t"
> +    "fld    f14, 0x70(t0)\n\t"
> +    "fld    f15, 0x78(t0)\n\t"
> +    "fld    f16, 0x80(t0)\n\t"
> +    "fld    f17, 0x88(t0)\n\t"
> +    "fld    f18, 0x90(t0)\n\t"
> +    "fld    f19, 0x98(t0)\n\t"
> +    "fld    f20, 0xa0(t0)\n\t"
> +    "fld    f21, 0xa8(t0)\n\t"
> +    "fld    f22, 0xb0(t0)\n\t"
> +    "fld    f23, 0xb8(t0)\n\t"
> +    "fld    f24, 0xc0(t0)\n\t"
> +    "fld    f25, 0xc8(t0)\n\t"
> +    "fld    f26, 0xd0(t0)\n\t"
> +    "fld    f27, 0xd8(t0)\n\t"
> +    "fld    f28, 0xe0(t0)\n\t"
> +    "fld    f29, 0xe8(t0)\n\t"
> +    "fld    f30, 0xf0(t0)\n\t"
> +    "fld    f31, 0xf8(t0)\n\t"
> +    /* Trigger the SIGILL */
> +".global unimp_addr\n\t"
> +"unimp_addr:\n\t"
> +    "unimp\n\t"
> +    "nop\n\t"
> +    /* Save final values from gp registers */
> +    "mv    t0, %[final_gvalues]\n\t"
> +    "sd    x1, 0x0(t0)\n\t"
> +    "sd    x2, 0x8(t0)\n\t"
> +    "sd    x3, 0x10(t0)\n\t"
> +    "sd    x4, 0x18(t0)\n\t"
> +    "sd    x5, 0x20(t0)\n\t"
> +    "sd    x6, 0x28(t0)\n\t"
> +    "sd    x7, 0x30(t0)\n\t"
> +    "sd    x8, 0x38(t0)\n\t"
> +    "sd    x9, 0x40(t0)\n\t"
> +    "sd    x10, 0x48(t0)\n\t"
> +    "sd    x11, 0x50(t0)\n\t"
> +    "sd    x12, 0x58(t0)\n\t"
> +    "sd    x13, 0x60(t0)\n\t"
> +    "sd    x14, 0x68(t0)\n\t"
> +    "sd    x15, 0x70(t0)\n\t"
> +    "sd    x16, 0x78(t0)\n\t"
> +    "sd    x17, 0x80(t0)\n\t"
> +    "sd    x18, 0x88(t0)\n\t"
> +    "sd    x19, 0x90(t0)\n\t"
> +    "sd    x20, 0x98(t0)\n\t"
> +    "sd    x21, 0xa0(t0)\n\t"
> +    "sd    x22, 0xa8(t0)\n\t"
> +    "sd    x23, 0xb0(t0)\n\t"
> +    "sd    x24, 0xb8(t0)\n\t"
> +    "sd    x25, 0xc0(t0)\n\t"
> +    "sd    x26, 0xc8(t0)\n\t"
> +    "sd    x27, 0xd0(t0)\n\t"
> +    "sd    x28, 0xd8(t0)\n\t"
> +    "sd    x29, 0xe0(t0)\n\t"
> +    "sd    x30, 0xe8(t0)\n\t"
> +    "sd    x31, 0xf0(t0)\n\t"
> +    /* Save final values from float registers */
> +    "mv    t0, %[final_fvalues]\n\t"
> +    "fsd    f0, 0x0(t0)\n\t"
> +    "fsd    f1, 0x8(t0)\n\t"
> +    "fsd    f2, 0x10(t0)\n\t"
> +    "fsd    f3, 0x18(t0)\n\t"
> +    "fsd    f4, 0x20(t0)\n\t"
> +    "fsd    f5, 0x28(t0)\n\t"
> +    "fsd    f6, 0x30(t0)\n\t"
> +    "fsd    f7, 0x38(t0)\n\t"
> +    "fsd    f8, 0x40(t0)\n\t"
> +    "fsd    f9, 0x48(t0)\n\t"
> +    "fsd    f10, 0x50(t0)\n\t"
> +    "fsd    f11, 0x58(t0)\n\t"
> +    "fsd    f12, 0x60(t0)\n\t"
> +    "fsd    f13, 0x68(t0)\n\t"
> +    "fsd    f14, 0x70(t0)\n\t"
> +    "fsd    f15, 0x78(t0)\n\t"
> +    "fsd    f16, 0x80(t0)\n\t"
> +    "fsd    f17, 0x88(t0)\n\t"
> +    "fsd    f18, 0x90(t0)\n\t"
> +    "fsd    f19, 0x98(t0)\n\t"
> +    "fsd    f20, 0xa0(t0)\n\t"
> +    "fsd    f21, 0xa8(t0)\n\t"
> +    "fsd    f22, 0xb0(t0)\n\t"
> +    "fsd    f23, 0xb8(t0)\n\t"
> +    "fsd    f24, 0xc0(t0)\n\t"
> +    "fsd    f25, 0xc8(t0)\n\t"
> +    "fsd    f26, 0xd0(t0)\n\t"
> +    "fsd    f27, 0xd8(t0)\n\t"
> +    "fsd    f28, 0xe0(t0)\n\t"
> +    "fsd    f29, 0xe8(t0)\n\t"
> +    "fsd    f30, 0xf0(t0)\n\t"
> +    "fsd    f31, 0xf8(t0)\n\t"
> +    : "=3Dm" (initial_gvalues),
> +      "=3Dm" (final_gvalues),
> +      "=3Dm" (final_fvalues)
> +    : "m" (initial_fvalues),
> +      [initial_gvalues] "r" (initial_gvalues),
> +      [initial_fvalues] "r" (initial_fvalues),
> +      [final_gvalues] "r" (final_gvalues),
> +      [final_fvalues] "r" (final_fvalues)
> +    : "t0",
> +      "f0", "f1", "f2", "f3", "f4", "f5", "f6", "f7",
> +      "f8", "f9", "f10", "f11", "f12", "f13", "f14", "f15",
> +      "f16", "f17", "f18", "f19", "f20", "f21", "f22", "f23",
> +      "f24", "f25", "f26", "f27", "f28", "f29", "f30", "f31");
> +
> +    assert(got_signal);
> +
> +    /*
> +     * x4 / t0 is used in the asm so it has to be handled specially
> +     * and is not a simple equality.
> +     */
> +    assert(initial_gvalues[4] =3D=3D (unsigned long)initial_gvalues);
> +    assert(signal_gvalues[4] =3D=3D (unsigned long)initial_fvalues);
> +    assert(final_gvalues[4] =3D=3D (unsigned long)final_gvalues);
> +    initial_gvalues[4] =3D final_gvalues[4] =3D signal_gvalues[4] =3D 0;
> +
> +    /*
> +     * Ensure registers match before, inside, and after signal
> +     * handler.
> +     */
> +    assert(!memcmp(initial_gvalues, final_gvalues, 8 * 31));
> +    assert(!memcmp(initial_gvalues, signal_gvalues, 8 * 31));
> +    assert(!memcmp(initial_fvalues, final_fvalues, 8 * 32));
> +    assert(!memcmp(initial_fvalues, signal_fvalues, 8 * 32));
> +}
> +
> +int main(void)
> +{
> +    struct sigaction act =3D { 0 };
> +
> +    act.sa_flags =3D SA_SIGINFO;
> +    act.sa_sigaction =3D &ILL_handler;
> +    if (sigaction(SIGILL, &act, NULL) =3D=3D -1) {
> +        perror("sigaction");
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    init_test();
> +
> +    run_test();
> +}
> --
> 2.51.0
>
>

