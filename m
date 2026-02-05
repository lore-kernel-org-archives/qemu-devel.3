Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DFE1EC1EB2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 13:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnzJ4-0001n0-G9; Thu, 05 Feb 2026 08:22:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vnzJ2-0001lv-Cz
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:22:00 -0500
Received: from mail-dl1-x1242.google.com ([2607:f8b0:4864:20::1242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vnzJ0-00049P-Bn
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:22:00 -0500
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-12460a7caa2so1258483c88.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 05:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770297714; x=1770902514; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CZ7cL0UTpw8Eo3kfIkOPHApx4PGcm+z0vOcu8vOa8NQ=;
 b=VFTsgXe3JFRQ/zvHV/mxno7+8bn4dL+bbUkESGWh6oxMFV49zJGmpXi0xjGzZZ+h+c
 8x8FhMVA4pwvLmX4U1UPtOOypZLcRYFjtjujY/AenbwOuXeIjhI7JUy5jZvlFaS7oZhh
 mbZmy+szR6JAYkSDccxLbjPlX7HR63+BUGqyqi+/JmJOTsY/z+B1DHPmDM2NRE6VjIN8
 BzJADrMJ5U8cQKr4Z5Ee7TzaBQ76nSH2AMuwfDQWbqURNWAAsNyDqZOLFlRjclGK9Iu8
 GMlespKhpKtk+c9qcN4HAXqLztYqurTDfN5I46YWi5IrTAOa0keNshS+2HzRDHr/sqyp
 g1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770297714; x=1770902514;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CZ7cL0UTpw8Eo3kfIkOPHApx4PGcm+z0vOcu8vOa8NQ=;
 b=e30e54VqU4Xd20ocCfzwUU+uZ8N544CsvInSQrypPq4fTJZtvQTbEhiku5Hq+y+rT9
 XoNhSseB3ocbkoyntPYpSoF7DFa9hBoPAF4EcbqGhEcWYmme+9HLNqYlxua9ixMRuoUR
 6BSH8OjUoHy51gqGWlczG1nflhK1SkP6BJrox2l1kUV5XxJz0gwrDh+JC0c7cZHgaTy7
 OZKgowWrwo8uMpCFeAVsC7aE+z0t2T06l+PaV0nOyn/yOjBlOS2E+ff7s0QrUzci5DFd
 Z5NHIHyrvdNmrQNH+JvrOQhLiSZhM0otKV6HRBZjKrmpcuXGDKJD2vcCxuX/NDttBmVZ
 mIRQ==
X-Gm-Message-State: AOJu0Yyv0oQP+73m26F06ckBsp5dlKP6d4BDz8C1PCkutTX/ZNu49vTo
 lwhHRwouLIzZHq4wSXuS4Q/nfk+1K8v0fztgLTsKmgiojJL4gdGpAkY9
X-Gm-Gg: AZuq6aJmvC+gOduL7ih5xChLy4YhpdVBh3BR/QMu4SwnEqfzAUBwiteUgm9rQ3OlpdU
 7erAc318uXyPT8yHXvZndzitahrHuYT9Cly4I8ZhlotUEsWKOOFDKLbRqiQM9pxL2NSI8i6f09F
 uIvj1YCpww/yr3G3ya2WtBTiP9Bzr1e/vsYZFuZN93vlC9pQrnA6B053wvNYXtYDSMr/tEypkni
 bE4Pk7z9REtNFo3VluFQRDxio/1k3XVh7Kjfx3PIrkamkkWPQSMQFpSUpEvfH34QJSirHwSFuMy
 Co1d3oi6TnV79kpR5XwVSBqcIolaAHDmkhCY9XssOmT2tuwcN/b7k7wKp5uVkqGQ06QclSMZauJ
 eUsm0V3MaTmACoRsW00AI9/GVNXZ6QFYPwOeQWfSDABqWCPGcqqNhvYbNGDi0APO7FRw9xisncj
 BKCEHtiXTjXu6wychOh0l4cTYURFPnw6MfyQnOt9O8LdHJ2C7Oy4fod8fgU/kAKyLHpNMs4e0EO
 fT4lf+l2Gr+SzJyzwmSdLScpTTSbQ==
X-Received: by 2002:a05:7022:f8b:b0:11c:b3ae:c9f1 with SMTP id
 a92af1059eb24-126f4779f4fmr2739761c88.1.1770297713549; 
 Thu, 05 Feb 2026 05:21:53 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-126f503ea14sm4728984c88.16.2026.02.05.05.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 05:21:52 -0800 (PST)
Date: Thu, 5 Feb 2026 21:21:34 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Max Chou <max.chou@sifive.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v3 05/19] fpu/softfloat: Support OCP(Open Compute
 Project) OFP8 data type
Message-ID: <aYSUzRnX4ImNeaVT@ZEVORN-PC.localdomain>
References: <20260204051756.667397-1-max.chou@sifive.com>
 <20260204051756.667397-6-max.chou@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204051756.667397-6-max.chou@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1242;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1242.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Max,

I've been testing the OCP FP8 implementation by writing
a simple test suite in tests/fp/ that covers various boundary cases for E4M3,
E5M2, E2M1, and BFloat16 formats. During testing, I found some issues in the
float_class_inf handling in partsN(uncanon_sat).

On Wed, Feb 04, 2026 at 01:17:41PM +0800, Max Chou wrote:
> This commit provides the implementation defined behavior flags and the basic
> operation support for the OCP float8 data types(E4M3 & E5M2).
> 
> According to the definition in OFP8 spec, the conversion from a wider
> format infinity depends on the saturation mode defined in the spec.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>  fpu/softfloat-parts.c.inc      | 159 +++++++++++++++++++++------
>  fpu/softfloat-specialize.c.inc |  62 +++++++++++
>  fpu/softfloat.c                | 191 +++++++++++++++++++++++++++++++--
>  include/fpu/softfloat-types.h  |  12 +++
>  include/fpu/softfloat.h        |  81 ++++++++++++++
>  5 files changed, 467 insertions(+), 38 deletions(-)
> 
> diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
> index 5e0438fc0b..eee7daae4d 100644
> --- a/fpu/softfloat-parts.c.inc
> +++ b/fpu/softfloat-parts.c.inc

[...]

> -static void partsN(uncanon)(FloatPartsN *p, float_status *s,
> -                            const FloatFmt *fmt)
> +static void partsN(uncanon_sat)(FloatPartsN *p, float_status *s,
> +                                const FloatFmt *fmt, bool saturate)
>  {
>      if (likely(is_anynorm(p->cls))) {
> -        parts_uncanon_normal(p, s, fmt);
> +        parts_uncanon_normal(p, s, fmt, saturate);
>      } else {
>          switch (p->cls) {
>          case float_class_zero:
> @@ -434,13 +510,30 @@ static void partsN(uncanon)(FloatPartsN *p, float_status *s,
>              frac_clear(p);
>              return;
>          case float_class_inf:
> -            g_assert(!fmt->arm_althp);
> -            p->exp = fmt->exp_max;
> -            frac_clear(p);
> +            /*
> +             * Unified infinity handling using format capabilities.
> +             * Formats with no_infinity must convert infinity to something else
> +             */
> +            if (!fmt->no_infinity) {
> +                p->exp = fmt->exp_max;
> +                frac_clear(p);
The saturate flag is not checked here. For IEEE-like formats such as
E5M2 that have infinity encoding, when saturate=true, the result should be
the maximum normal value, not infinity.

Per OCP FP8 specification Section 4.2 "Saturation", when saturation mode is
enabled, infinity should be converted to the maximum finite value even for
formats that support infinity representation.

My case:
  bfloat16_to_float8_e5m2(BF16_INF_POS, true, &status)
  Expected: 0x7b (max normal)
  Actual:   0x7c (infinity)

Suggested fix:
            if (!fmt->no_infinity && !saturate) {
                p->exp = fmt->exp_max;
                frac_clea
                r(p);
            } else if (!fmt->no_infinity && saturate) {
                /* Saturate infinity to max normal for IEEE-like formats */
                p->exp = fmt->exp_max - 1;
                frac_allones(p);
                frac_shr(p, fmt->frac_shift);
            } else if ...

> +            } else if (fmt_has_nan_encoding(fmt)) {
> +                if (saturate) {
> +                    parts_set_max_normal(p, fmt);
Missing frac_shr() call after parts_set_max_normal().

The parts_set_max_normal() function sets frac_hi to the normalized
fraction value (with implicit bit at position 63). Before packing into
the final format, the fraction must be shifted right by frac_shift to
position it correctly.

Compare with the float_class_qnan/snan case below which correctly calls
frac_shr(p, fmt->frac_shift) before returning.

My case:
  bfloat16_to_float8_e4m3(BF16_INF_POS, true, &status)
  Expected: 0x7e (max normal, exp=15, frac=6)
  Actual:   0x78 (exp=15, frac=0 - incorrect due to missing shift)

Suggested fix:
                if (saturate) {
                    parts_set_max_normal(p, fmt);
                    frac_shr(p, fmt->frac_shift);

> +                } else {
> +                    uint8_t dnan = s->default_nan_pattern;
> +                    p->cls = float_class_qnan;
> +                    p->sign = dnan >> 7;
> +                    p->exp = fmt->exp_max;
> +                    frac_allones(p);
Same issue - missing frac_shr() call after frac_allones().

> +                }
> +            } else {
> +                parts_set_max_normal(p, fmt);
Same issue - missing frac_shr() call after parts_set_max_normal().

PS: This path is taken for formats without NaN encoding (like E2M1).

> +            }
>              return;
>          case float_class_qnan:
>          case float_class_snan:
> -            g_assert(!fmt->arm_althp);
> +            g_assert(fmt_has_nan_encoding(fmt));
>              p->exp = fmt->exp_max;
>              frac_shr(p, fmt->frac_shift); /* <-- This is correct */
>              return;
The qnan/snan case correctly calls frac_shr(), which is good, but the inf case above does not.

---

I've prepared a fix patch and a test suite (tests/fp/fp-test-ocp.c) with 97
test cases covering:

- Classification functions for E4M3, E5M2, E2M1, BFloat16
- Format conversions with and without saturation
- Rounding mode handling
- Canonical NaN generation per Zvfofp8min specification


git repo:
https://github.com/zevorn/qemu/tree/riscv-zvfofp8min-zvfofp4min-v3

command:
cd $QEMU_SRC_PATH/build && ninja tests/fp/fp-test-ocp
./pyvenv/bin/meson test --suite softfloat-ocp -v


With the fix applied, all saturation tests pass:
  PASS: BF16 +inf -> E4M3 max normal (with saturation), got 0x7e
  PASS: BF16 +inf -> E5M2 max normal (with saturation), got 0x7b
  PASS: F32 +inf -> E4M3 max normal (with saturation), got 0x7e
  PASS: F32 +inf -> E5M2 max normal (with saturation), got 0x7b

---

@Richard: I noticed that the current tests/fp/ directory doesn't have test
coverage for BFloat16, OCP FP8 (E4M3/E5M2), or FP4 (E2M1) formats.

The existing fp-test relies on Berkeley TestFloat which doesn't support
these newer formats. Would it be useful if I clean up and submit my test
suite (fp-test-ocp.c) as a separate patch to provide basic test coverage
for these OCP floating-point formats? It could help catch similar issues
in future softfloat changes.

Thanks,
Chao

