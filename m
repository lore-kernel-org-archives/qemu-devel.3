Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C91FC0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 17:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbNHL-0004Fa-CK; Fri, 24 Jan 2025 12:15:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tbNHJ-0004Ek-R9
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:15:33 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tbNHH-0006j0-3g
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:15:32 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5d982de9547so4499107a12.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 09:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737738929; x=1738343729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QOxYa3EJTbJh3iB+yrLi3g+/aOlJrblntX1P9nuDz50=;
 b=heuSIpxZl7N4uFW69j4oTAMz99r2aGsDaATtYLhAz8ALhz7lfAT7r56tw9ss+pl49n
 QAUSsuZ5S/XztV40hm96CbKJmjU2HN0IiBdMG2fJX4BnSNY/fBZs6Z2gykfO9q565l+G
 eb+T4OW8v0WArFlTAZ7+TaqG4tHzgXPIH3EIVi7giZbaxf0oCtnjGhbdPuzCfKDzYvSF
 xcpwMrueDWCgoe/sU8VVRv6nU/htwMY4bt4VdhPFf3XSy5xkRwEdbdyfoEtSliZaWyZ6
 l5fLAc5ed7wnj2jeaODnK8kIn30JOfMPsqkbV+vg5F79nNB65j8vdhZaFA5GXA++Y1ax
 ZKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737738929; x=1738343729;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QOxYa3EJTbJh3iB+yrLi3g+/aOlJrblntX1P9nuDz50=;
 b=YqiJVKtrx2ml99LjFrNThqDNIC8DU0VThmSXbb7my7hVDkXdjg1ypEBb0+eHfooAGA
 xBHDyAllzFTohfCN4TrQNqmRDpwQ5wUJ3QGKngKpDCdzV0KBpC5cCLdZxgrFUh1AxHm9
 1mBRzlORhpiKMswoijLTLmP2eBxF59WiXyJKHABGUSlO7wvtazWXFqhnIBJ5Bbrz5vju
 kGSmdfsW19FVVGRjdyCWh9MTZ4iIjSKVNNzHsPhQOSjNZ7zBphhHzOaiMkh8ZAA3UrMg
 VLcWmqdipWb6nyF61mwHnMncm8pNYXF1q1Ix5ozLOnfQTnwElC1DQ36/OeOD+0E0JFfu
 /U9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkdGEUhgHarKOr8vtRnepnlIhHmnkXwZTNBoYdbJZsENF2r58ojVXIwz74nwAwBoy/nU8CglF0TRp0@nongnu.org
X-Gm-Message-State: AOJu0YyBGZ0Xp/04yCXjv7IKCy2krRUVLWi+M9B/j/6hdcvZSPHfttOC
 eJdGUpE2+/3NmT/WCuG+X7VKPTP2oQNvl8WkRKcHuFahIjHoWw1i+ewJN6AuzF0=
X-Gm-Gg: ASbGncvq4Mq9KWPF0rT4Rplo0eraaLv32YmdZmttYbDdOHr9vCHoZWwDvBpGkIKa9Tz
 L8Crh0VsW4XXFeAUklSMbEDyyDTGkyGBMv7nGqG8MWPRaiZej9JvJQMBRIghrYUcAfg4bTElFDt
 B6dcpcxWPhEt5jdA1mQIEcnR0yOHgp1AMR3bib7F9Ahbj7qRZblp/4bDgdkd9T0SfPtnYo6Axc/
 Vb2rmyy/VSxxeCh+B4pQPUStnDaN+mU7bgMic+DuPUaiZOqQAMQZYfPDIXLYhULFCxyWhDjg7RE
 V8g=
X-Google-Smtp-Source: AGHT+IEppoJyZAOYmghbL/Y3Khu+YGLY2SGGAAsKO+89lSLTRPwnQon5aVIzQErmi3TTemKtgExL1A==
X-Received: by 2002:a05:6402:40c7:b0:5dc:100c:1569 with SMTP id
 4fb4d7f45d1cf-5dc100c17f2mr6972764a12.13.1737738928763; 
 Fri, 24 Jan 2025 09:15:28 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dc1861973asm1370688a12.2.2025.01.24.09.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 09:15:27 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1501D5F839;
 Fri, 24 Jan 2025 17:15:26 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH 02/76] tests/tcg/x86_64/fma: Test some x86
 fused-multiply-add cases
In-Reply-To: <20250124162836.2332150-3-peter.maydell@linaro.org> (Peter
 Maydell's message of "Fri, 24 Jan 2025 16:27:22 +0000")
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-3-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 24 Jan 2025 17:15:26 +0000
Message-ID: <87r04si15d.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> Add a test case which tests some corner case behaviour of
> fused-multiply-add on x86:
>  * 0 * Inf + SNaN should raise Invalid
>  * 0 * Inf + QNaN shouldh not raise Invalid
>  * tininess should be detected after rounding
>
> There is also one currently-disabled test case:
>  * flush-to-zero should be done after rounding
>
> This is disabled because QEMU's emulation currently does this
> incorrectly (and so would fail the test).  The test case is kept in
> but disabled, as the justification for why the test running harness
> has support for testing both with and without FTZ set.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  tests/tcg/x86_64/fma.c           | 109 +++++++++++++++++++++++++++++++
>  tests/tcg/x86_64/Makefile.target |   1 +
>  2 files changed, 110 insertions(+)
>  create mode 100644 tests/tcg/x86_64/fma.c
>
> diff --git a/tests/tcg/x86_64/fma.c b/tests/tcg/x86_64/fma.c
> new file mode 100644
> index 00000000000..09c622ebc00
> --- /dev/null
> +++ b/tests/tcg/x86_64/fma.c
> @@ -0,0 +1,109 @@
> +/*
> + * Test some fused multiply add corner cases.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include <stdio.h>
> +#include <stdint.h>
> +#include <stdbool.h>
> +#include <inttypes.h>
> +
> +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> +
> +/*
> + * Perform one "n * m + a" operation using the vfmadd insn and return
> + * the result; on return *mxcsr_p is set to the bottom 6 bits of MXCSR
> + * (the Flag bits). If ftz is true then we set MXCSR.FTZ while doing
> + * the operation.
> + * We print the operation and its results to stdout.
> + */
> +static uint64_t do_fmadd(uint64_t n, uint64_t m, uint64_t a,
> +                         bool ftz, uint32_t *mxcsr_p)
> +{
> +    uint64_t r;
> +    uint32_t mxcsr =3D 0;
> +    uint32_t ftz_bit =3D ftz ? (1 << 15) : 0;
> +    uint32_t saved_mxcsr =3D 0;
> +
> +    asm volatile("stmxcsr %[saved_mxcsr]\n"
> +                 "stmxcsr %[mxcsr]\n"
> +                 "andl $0xffff7fc0, %[mxcsr]\n"
> +                 "orl %[ftz_bit], %[mxcsr]\n"
> +                 "ldmxcsr %[mxcsr]\n"
> +                 "movq %[a], %%xmm0\n"
> +                 "movq %[m], %%xmm1\n"
> +                 "movq %[n], %%xmm2\n"
> +                 /* xmm0 =3D xmm0 + xmm2 * xmm1 */
> +                 "vfmadd231sd %%xmm1, %%xmm2, %%xmm0\n"
> +                 "movq %%xmm0, %[r]\n"
> +                 "stmxcsr %[mxcsr]\n"
> +                 "ldmxcsr %[saved_mxcsr]\n"
> +                 : [r] "=3Dr" (r), [mxcsr] "=3Dm" (mxcsr),
> +                   [saved_mxcsr] "=3Dm" (saved_mxcsr)
> +                 : [n] "r" (n), [m] "r" (m), [a] "r" (a),
> +                   [ftz_bit] "r" (ftz_bit)
> +                 : "xmm0", "xmm1", "xmm2");
> +    *mxcsr_p =3D mxcsr & 0x3f;
> +    printf("vfmadd132sd 0x%" PRIx64 " 0x%" PRIx64 " 0x%" PRIx64
> +           " =3D 0x%" PRIx64 " MXCSR flags 0x%" PRIx32 "\n",
> +           n, m, a, r, *mxcsr_p);
> +    return r;
> +}
> +
> +typedef struct testdata {
> +    /* Input n, m, a */
> +    uint64_t n;
> +    uint64_t m;
> +    uint64_t a;
> +    bool ftz;
> +    /* Expected result */
> +    uint64_t expected_r;
> +    /* Expected low 6 bits of MXCSR (the Flag bits) */
> +    uint32_t expected_mxcsr;
> +} testdata;
> +
> +static testdata tests[] =3D {
> +    { 0, 0x7ff0000000000000, 0x7ff000000000aaaa, false, /* 0 * Inf + SNa=
N */
> +      0x7ff800000000aaaa, 1 }, /* Should be QNaN and does raise Invalid =
*/
> +    { 0, 0x7ff0000000000000, 0x7ff800000000aaaa, false, /* 0 * Inf + QNa=
N */
> +      0x7ff800000000aaaa, 0 }, /* Should be QNaN and does *not* raise In=
valid */
> +    /*
> +     * These inputs give a result which is tiny before rounding but which
> +     * becomes non-tiny after rounding. x86 is a "detect tininess after
> +     * rounding" architecture, so it should give a non-denormal result a=
nd
> +     * not set the Underflow flag (only the Precision flag for an inexact
> +     * result).
> +     */
> +    { 0x3fdfffffffffffff, 0x001fffffffffffff, 0x801fffffffffffff, false,
> +      0x8010000000000000, 0x20 },
> +    /*
> +     * Flushing of denormal outputs to zero should also happen after
> +     * rounding, so setting FTZ should not affect the result or the flag=
s.
> +     * QEMU currently does not emulate this correctly because we do the
> +     * flush-to-zero check before rounding, so we incorrectly produce a
> +     * zero result and set Underflow as well as Precision.
> +     */
> +#ifdef ENABLE_FAILING_TESTS
> +    { 0x3fdfffffffffffff, 0x001fffffffffffff, 0x801fffffffffffff, true,
> +      0x8010000000000000, 0x20 }, /* Enabling FTZ shouldn't change flags=
 */
> +#endif

We could extend the multiarch/float_madds test to handle doubles as well
(or create a new multiarch test).

If the right FMA instructions can be forced via cflags you could then
add a specific binary to exercise the vfmadd231sd instruction like we do
for neon:

  float_madds: CFLAGS+=3D-mfpu=3Dneon-vfpv4

The test does basic testing but ideally you would add a reference output
to check against.

> +};
> +
> +int main(void)
> +{
> +    bool passed =3D true;
> +    for (int i =3D 0; i < ARRAY_SIZE(tests); i++) {
> +        uint32_t mxcsr;
> +        uint64_t r =3D do_fmadd(tests[i].n, tests[i].m, tests[i].a,
> +                              tests[i].ftz, &mxcsr);
> +        if (r !=3D tests[i].expected_r) {
> +            printf("expected result 0x%" PRIx64 "\n", tests[i].expected_=
r);
> +            passed =3D false;
> +        }
> +        if (mxcsr !=3D tests[i].expected_mxcsr) {
> +            printf("expected MXCSR flags 0x%x\n", tests[i].expected_mxcs=
r);
> +            passed =3D false;
> +        }
> +    }
> +    return passed ? 0 : 1;
> +}
> diff --git a/tests/tcg/x86_64/Makefile.target b/tests/tcg/x86_64/Makefile=
.target
> index d6dff559c7d..be20fc64e88 100644
> --- a/tests/tcg/x86_64/Makefile.target
> +++ b/tests/tcg/x86_64/Makefile.target
> @@ -18,6 +18,7 @@ X86_64_TESTS +=3D adox
>  X86_64_TESTS +=3D test-1648
>  X86_64_TESTS +=3D test-2175
>  X86_64_TESTS +=3D cross-modifying-code
> +X86_64_TESTS +=3D fma
>  TESTS=3D$(MULTIARCH_TESTS) $(X86_64_TESTS) test-x86_64
>  else
>  TESTS=3D$(MULTIARCH_TESTS)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

