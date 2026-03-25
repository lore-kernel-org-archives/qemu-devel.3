Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562321093176
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 01:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5DV5-0000XR-UN; Tue, 24 Mar 2026 21:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5DV3-0000X1-Ry
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 21:57:37 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5DV2-0003CC-6K
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 21:57:37 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b98133bdc4bso754727266b.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 18:57:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774403854; cv=none;
 d=google.com; s=arc-20240605;
 b=N8LaKYF1iJ+j+t6Q0r04oFnyU4Hj4PYZTnJA4vqHEMT/dNThTBe5UIvf5QwkxOQmo0
 Qxm8f+52AMxPPi6YyM0i7jOhDJgIFD0jvW9ghiPqcm2qYHcv79QYaOtQwlcwjTENxGAQ
 o2R6vENeqpr3cgMX0y4l6UTfAOI4oQOP5/bpSg37VFDqs22LJbMU6IPHzmujTIe2U+OO
 xbz4OjsvnHNQmRmlMuls2G0vsZCCDFnh1xUPeDrV3YWyIhv2GpAEVE8TLzZO/1JVDzGL
 8jtRb6Mnd1mZjYqkbfbvIWyih9SVcOnTXAA52uTFlOKOSBxJTEODeoYv15qPYfgRHdWc
 /OgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ijdJ4mvcFZ7C1s1v6O0GzF6p3eV2XeFgX5vgMgnXmEg=;
 fh=ucO2dSEtN7YoiRvbuheAle/RpVniasl+XUJ/YMdBvRs=;
 b=QDzkenxQc9kvcnYJOVthtp+cGvi5qSMT5F4NrInzfB6PGVzCkgJCo7j+rtlYD7yueY
 ErmAmBfr70LLBjruIZWX7u39i58hhuripNNv9T9eIspwKij8NjT1FJ05a8cwBmS37iP6
 oC27dzKeGDMgntj4qVBoh51OZv9/HJjE/xD3IBAUm8WEaJ449CwOJn4wsMtkU1/e5nGI
 8Y712BzVp13AegHLQqks4Lxw2nomffYiJlclumlRJ5vWc9C2V9mlq4BROFfQgMpK6dVK
 iLdqOOSK+/oLWvGpinz0a+6zTMqhVh+XWjMcLgXer5rQbutjX1XghTvNh6YAsaXg2QQg
 7fEw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774403854; x=1775008654; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ijdJ4mvcFZ7C1s1v6O0GzF6p3eV2XeFgX5vgMgnXmEg=;
 b=dlNBGVR4xgRfPNuCGZlTN3PCVjTvn3o+dw3jYPLnzwSd+akSgeubNxJGM3hm+136gw
 2GJroODCHbVUx+JM+EMI1fOM2g7m0p7MXKO1lKlzhvKJIaQAhC34+EgRdV5oefdlqj96
 SUt/v+fm1OndRyyaPir3Haj2JFVD3f+GdEc/F5JZ2ekNR2Ac3MVquRroG9YlD/WNRwGM
 YJc1gM7QRIaY6TN6tC9bNDqwCpF9vkLKDtcBJZve5AWoslwxY4NY49YPt/GEfOTRcMnp
 JAPVLwucvPw6WDUIWfYwBHUMczYOhgOsLS9G5NT9NNvEWtuH73U88D28oW1luhjo9nB8
 vNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774403854; x=1775008654;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ijdJ4mvcFZ7C1s1v6O0GzF6p3eV2XeFgX5vgMgnXmEg=;
 b=kX768bSj7QjWVC27XgaQOhS9VkpDrnrA0WYXOoSkyBTAmgxojeVdwYbHHDqDDX1ePg
 6eHi8ZU9xy5VAQIPEBzaTcKoV/LWw5N7Xcg+PUybJmfUw2aFZgERxEb6gm0y8uPEr3UF
 dk6lm7ecMbv0Nj2g2wvmlOX/19vqFhdZPHTK2OmQqJY6Q01wuY5fWqRh3zxBVGCnsjV7
 HBUhHBZPliHtUYXN94ScSE6t6vGPDh0L+9nkbP1P/Lwr/7Z9qMgoWB9fbp5hdzPlOmoI
 UGfQwbDU8skSAAf1IQ4V1xLBbmjGUhBSaeMKVYFWoDMykC26KmqbgDgxMo8nbwIoErfI
 Yw3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd6PhXwYEThyb8M0YMJeMt6BP0xRcxOu2oeqDbqSKb0QCeF/QCBAPLjnpBpPDafbLS9YvwxxqgWary@nongnu.org
X-Gm-Message-State: AOJu0YzPS+Vkp6JkTKh+svUxLgGEuEa5Y8cjrDWZgb/jRGWIoqlh5LT8
 FCgB+WUzrPJCHeh81jH5SQSJvff0TMYWAthBXInFuBjyUsQiamoHboaSAYFmdVAIf2bH5e6l9oT
 V+z7JCXOpnI33eIUaTK9NNDXo8Lu8QlA=
X-Gm-Gg: ATEYQzyeq4Ryu/C+Cmgtz3tXazgLuC+V1SDu9S8hCeqMJok7KRzw/aBXBgdnx9ubWTr
 QqYwQppIaAiVatgmhtshB7RW+MwRLO0Cw7wgYj8ofH52XtphltbH18p7IaAktCyFNBLxBEJUQCR
 4bpowt1siPh8NUvl3dPmUxHrWbXkCkaRhx3qpcmOJuyZVnSMzLGFmfVNMG2l8FUqFONdmLPHCDm
 BgIcWoAjn3P5vBRg99eY26NWBhYuWSLuPtgig+G9++YLG5O+PO5MafBjrQtJB7RptpZFxvlRT4d
 /I1aGbwvtjR66ez87dnFqYOQ0IwtdAUPhF3IoQ==
X-Received: by 2002:a17:906:175a:b0:b73:4d06:bc8 with SMTP id
 a640c23a62f3a-b9a653a22c3mr81420366b.53.1774403854049; Tue, 24 Mar 2026
 18:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260321144554.606417-1-npiggin@gmail.com>
 <20260321144554.606417-3-npiggin@gmail.com>
In-Reply-To: <20260321144554.606417-3-npiggin@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 25 Mar 2026 11:57:07 +1000
X-Gm-Features: AQROBzDWJMTpsi4GA8nHlv7M_EMtUc1TCFdhhrs3SE-aNo8weE8iMNQTTj2DtQE
Message-ID: <CAKmqyKP4ufK9qoMRbZvhoNuy-K_hh+yxx68-VnfEU7tkMK-3Bg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] target/riscv: Fix vector whole ldst vstart check
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-riscv@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org, 
 Joel Stanley <joel@jms.id.au>, Nicholas Joaquin <njoaquin@tenstorrent.com>, 
 Ganesh Valliappan <gvalliappan@tenstorrent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x633.google.com
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

On Sun, Mar 22, 2026 at 12:47=E2=80=AFAM Nicholas Piggin <npiggin@gmail.com=
> wrote:
>
> The whole vector ldst instructions do not include a vstart check, so an
> overflowed vstart can result in an underflowed memory address offset and
> crash:
>
>     accel/tcg/cputlb.c:1465:probe_access_flags:
>       assertion failed: (-(addr | TARGET_PAGE_MASK) >=3D size)
>
> Add the VSTART_CHECK_EARLY_EXIT() check for these helpers.
>
> This was found with a verification test generator based on RiESCUE.
>
> Reported-by: Nicholas Joaquin <njoaquin@tenstorrent.com>
> Reported-by: Ganesh Valliappan <gvalliappan@tenstorrent.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/vector_helper.c             |  2 +
>  tests/tcg/riscv64/Makefile.target        |  5 ++
>  tests/tcg/riscv64/test-vstart-overflow.c | 78 ++++++++++++++++++++++++
>  3 files changed, 85 insertions(+)
>  create mode 100644 tests/tcg/riscv64/test-vstart-overflow.c
>
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index caa8dd9c12..4126447d11 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -825,6 +825,8 @@ vext_ldst_whole(void *vd, target_ulong base, CPURISCV=
State *env, uint32_t desc,
>      uint32_t esz =3D 1 << log2_esz;
>      int mmu_index =3D riscv_env_mmu_index(env, false);
>
> +    VSTART_CHECK_EARLY_EXIT(env, evl);
> +
>      /* Calculate the page range of first page */
>      addr =3D base + (env->vstart << log2_esz);
>      page_split =3D -(addr | TARGET_PAGE_MASK);
> diff --git a/tests/tcg/riscv64/Makefile.target b/tests/tcg/riscv64/Makefi=
le.target
> index 4da5b9a3b3..19a49b6467 100644
> --- a/tests/tcg/riscv64/Makefile.target
> +++ b/tests/tcg/riscv64/Makefile.target
> @@ -18,3 +18,8 @@ TESTS +=3D test-fcvtmod
>  test-fcvtmod: CFLAGS +=3D -march=3Drv64imafdc
>  test-fcvtmod: LDFLAGS +=3D -static
>  run-test-fcvtmod: QEMU_OPTS +=3D -cpu rv64,d=3Dtrue,zfa=3Dtrue
> +
> +# Test for vstart >=3D vl
> +TESTS +=3D test-vstart-overflow
> +test-vstart-overflow: CFLAGS +=3D -march=3Drv64gcv
> +run-test-vstart-overflow: QEMU_OPTS +=3D -cpu rv64,v=3Don
> diff --git a/tests/tcg/riscv64/test-vstart-overflow.c b/tests/tcg/riscv64=
/test-vstart-overflow.c
> new file mode 100644
> index 0000000000..6c904ab309
> --- /dev/null
> +++ b/tests/tcg/riscv64/test-vstart-overflow.c
> @@ -0,0 +1,78 @@
> +/*
> + * Test for VSTART set to overflow VL
> + *
> + * TCG vector instructions should call VSTART_CHECK_EARLY_EXIT() to chec=
k
> + * this case, otherwise memory addresses can underflow and misbehave or
> + * crash QEMU.
> + *
> + * TODO: Add stores and other instructions.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include <stdint.h>
> +
> +#define VSTART_OVERFLOW_TEST(insn)                \
> +({                                                \
> +    uint8_t vmem[64] =3D { 0 };                     \
> +    uint64_t vstart;                              \
> +    asm volatile("                           \r\n \
> +    # Set VL=3D52 and VSTART=3D56                \r\n \
> +    li          t0, 52                       \r\n \
> +    vsetvli     x0, t0, e8, m4, ta, ma       \r\n \
> +    li          t0, 56                       \r\n \
> +    csrrw       x0, vstart, t0               \r\n \
> +    li          t1, 64                       \r\n \
> +    " insn "                                 \r\n \
> +    csrr        %0, vstart                   \r\n \
> +    " : "=3Dr"(vstart), "+A"(vmem) :: "t0", "t1", "v24", "memory"); \
> +    vstart;                                       \
> +})
> +
> +int run_vstart_overflow_tests()
> +{
> +    /*
> +     * An implementation is permitted to raise an illegal instruction
> +     * exception when executing a vector instruction if vstart is set to=
 a
> +     * value that could not be produced by the execution of that instruc=
tion
> +     * with the same vtype. If TCG is changed to do this, then this test
> +     * could be updated to handle the SIGILL.
> +     */
> +    if (VSTART_OVERFLOW_TEST("vl1re16.v    v24, %1")) {
> +        return 1;
> +    }
> +
> +    if (VSTART_OVERFLOW_TEST("vs1r.v       v24, %1")) {
> +        return 1;
> +    }
> +
> +    if (VSTART_OVERFLOW_TEST("vle16.v      v24, %1")) {
> +        return 1;
> +    }
> +
> +    if (VSTART_OVERFLOW_TEST("vse16.v      v24, %1")) {
> +        return 1;
> +    }
> +
> +    if (VSTART_OVERFLOW_TEST("vluxei8.v    v24, %1, v20")) {
> +        return 1;
> +    }
> +
> +    if (VSTART_OVERFLOW_TEST("vloxei8.v    v24, %1, v20")) {
> +        return 1;
> +    }
> +
> +    if (VSTART_OVERFLOW_TEST("vlse16.v     v24, %1, t1")) {
> +        return 1;
> +    }
> +
> +    if (VSTART_OVERFLOW_TEST("vlseg2e8.v  v24, %1")) {
> +        return 1;
> +    }
> +
> +    return 0;
> +}
> +
> +int main()
> +{
> +    return run_vstart_overflow_tests();
> +}
> --
> 2.51.0
>
>

