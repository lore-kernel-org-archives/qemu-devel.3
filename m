Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532D6FD0076
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 00:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwr6I-0002va-OY; Sun, 01 Mar 2026 19:25:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vwr6F-0002vS-Aw
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 19:25:27 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vwr6C-0001jM-Bg
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 19:25:27 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3590042fa8eso2170006a91.1
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 16:25:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772411122; cv=none;
 d=google.com; s=arc-20240605;
 b=Jhl8oraqpRvIDjcUBxLBhFYBSKUlqWKSTiJKgWvzvMrEZLVl/Een8VR1Dy3XRRr9tH
 yirsRYax4WQeZ/wpfYuyDyOMCPY+8a5gBP4zxWHE6DYJAOeEgQH99JWU1Z6ZivI0yREu
 RokDK6xN50RKrnxV2o8XUsDHi6l7HUl0ESifqOF9Dl9/fo8Ket4OhgfVb9lZcvGKMvrW
 pD8tXGhTQ+4HALd8bw7ClyHJ0e9RUpT9WZgeOb3dIrDHCKGJh4CSsAl7jVZ5G4hwMD0o
 IKj9JSQxM1jQZzkmjb8uqFPYIric0aQ52cBhrteoLh93BYhPO0G10NRN0uki5vwtkOpx
 ASMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rsdJX+HuToPLTqdmkqboidrXHggnk/qEOH8btq8c4Bc=;
 fh=sbxuPqjMywa3JYEGeYJMyo5ksfdP/w06LeNzDEfn49s=;
 b=VopWJGu1AVgnbmvhvNUAGZG3hA0B/xP5HNdsgrHnryYYD7M8p0FZeCQU61SJSpKnIu
 mwAaZueAEXxyzkZmJ/m+p58rq9LGpkEjyWkjrF1WvGjNxLLcLB4SYA+F7yc1J6DUOS5T
 8d6ZOl9VDD9bfKrmHSjll5mAS2+2vGD4S3KLGSwANS5bufJcd8D+W6Wx6akvkHWbVis6
 nGvAcl+5asmsUDDn9i0on3T8ANLfJZRRBuyT51tLkjRS5Xe6j4mvP9Xs7zlvLnKzugzT
 4EGtBLRhNWcUWfop3jFpZ7/wF2Zd9BBLrdgVTywbp5ty8jpSKNDm3WqxYSonoi0fK7P1
 WJxA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772411122; x=1773015922; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rsdJX+HuToPLTqdmkqboidrXHggnk/qEOH8btq8c4Bc=;
 b=cut8srnaiqM+Z6tO881ShvlmxOOg3DpV4BmumY/PDGTXEVgGlrOdmPSS0N3KnZvE0I
 5xpF1QVs9YoPXJXh7dHta1T89ifNZEppOEFKb+UFsVVx0G3GPRnpUzFPDYUbjEC8O0zi
 +RzdwBgl5ETiyWYKVUeaOOhW/1ug8/5QgS3n8jIrluai3nGqIei3Z6Ax5EYRqXE5Avbl
 3k1OhkmGWvEBB6TwPdTtvBz42Bs92+cfD2BolUqeq1nBlC8JrmsotKIhRmuVjvy1O5QY
 v+emseDdiD4kiSeT6hiR/0aLcWCgkhWIfAQOQBakLmvXv+HOZUE4Q//7Tktb6/MHjNTQ
 cpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772411122; x=1773015922;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rsdJX+HuToPLTqdmkqboidrXHggnk/qEOH8btq8c4Bc=;
 b=XsPneUfSUZ7ptuUXXMHEufIF/GdlfrOcGI+dPMComqgkXe8qT/1sZS2bxitkYObRhi
 EyvJ2Ko6k/DB4lyvnGHaykWl6A10O1JHyjnj1Y59ukdbvj1RKQ3ITFUtrihvckb77uzv
 ga1mGRR/FuBVKHuoFdnZiauUKt7jyAxZoCVbQIxFWtNW6wLl+6UShCvHPLR1YjoQm0uY
 uN1y3igt5CEe8t59yMha8+E83qK2evZiqOBXJhWiBvu4L4GI/cpFOszHCz+KZAplxHiY
 83i/MDXQWBRlwSJssG8kIGZgOr8FQibNn4zRM4WevSBDt3rKRFH/4/++Crvne21zxTkP
 L3IQ==
X-Gm-Message-State: AOJu0YwW1jALEa4zOg9Cu/jThyAbkw0HmZUjIeBHkXkKEKnnPRQLYHXp
 E11L4Y6kDL4n5ZGogxr/GsrcmcuC+VpJRZQ2B/Nq2cyi/PpoWkPEp8WrlRv5Oy6dPfYFwaKWui1
 d5OjrzE76GAWxYdM3F5CUZBc1s4ojUSk=
X-Gm-Gg: ATEYQzw4ok4kf6iiGZYadRmG0FK3XsmTR6TcagF9J08ylSIm34UCiTf0M22K7RNSURB
 cNRXlGhCZqLQGf2OLnvCQVWOoqsWrxYyHVwuBSm1uUMpt/8lJUzTO6ufWfRV7eeUKGh+iG0HKSy
 I/+0E+pFuYvD7dcjcbQuZj8QN3npbJ+M1NOj/Dnj3Rhxlx6dfD2nPaCTTlUTfqWoQxr2xx/7D7h
 u8D7xB6AGmbtboVmHIzeinsd/pliwzA51myFvmVYe2bGQp9lL5m8l/TiNkGezTsNvVAodyPbjOn
 qz9FzwO6M5Z2M96M7tT43ki+egFi1o+SEWR34ts=
X-Received: by 2002:a17:90b:560e:b0:352:d59a:b28 with SMTP id
 98e67ed59e1d1-35965c9d10fmr8055356a91.19.1772411122051; Sun, 01 Mar 2026
 16:25:22 -0800 (PST)
MIME-Version: 1.0
References: <20260226043436.648171-1-brian.cain@oss.qualcomm.com>
 <20260226043436.648171-3-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260226043436.648171-3-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Sun, 1 Mar 2026 17:25:10 -0700
X-Gm-Features: AaiRm53gRxplxNJlbkFs1ZHeNG5_VYr2B3FrsBwRE-dZxepqpepSyG_ib9G291U
Message-ID: <CAATN3NpEfCAjEUbxbp=FbGS_Ap_Gsyb1P_jD5Dqbjgv5pikvKw@mail.gmail.com>
Subject: Re: [PATCH 3/3] tests/tcg/hexagon: add test for predicated .new
 branch LSB evaluation
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000536f65064bff9f32"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000536f65064bff9f32
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 9:34=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com>
wrote:

> Test for predicated .new branches with non-standard predicate values
> (non-all-0, non-all-1).  Hexagon predicates are 8 bits wide but condition=
al
> branches evaluate only the LSB.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/Makefile.target        |   3 +
>  tests/tcg/hexagon/test_pnew_jump_loads.c | 339 +++++++++++++++++++++++
>  2 files changed, 342 insertions(+)
>  create mode 100644 tests/tcg/hexagon/test_pnew_jump_loads.c
>
> diff --git a/tests/tcg/hexagon/Makefile.target
> b/tests/tcg/hexagon/Makefile.target
> index f86f02bb31..5199c78536 100644
> --- a/tests/tcg/hexagon/Makefile.target
> +++ b/tests/tcg/hexagon/Makefile.target
> @@ -81,6 +81,8 @@ HEX_TESTS +=3D test_vminh
>  HEX_TESTS +=3D test_vpmpyh
>  HEX_TESTS +=3D test_vspliceb
>
> +HEX_TESTS +=3D test_pnew_jump_loads
> +
>  HEX_TESTS +=3D v68_scalar
>  HEX_TESTS +=3D v68_hvx
>  HEX_TESTS +=3D v69_hvx
> @@ -104,6 +106,7 @@ overflow: overflow.c hex_test.h
>  preg_alias: preg_alias.c hex_test.h
>  read_write_overlap: read_write_overlap.c hex_test.h
>  reg_mut: reg_mut.c hex_test.h
> +test_pnew_jump_loads: test_pnew_jump_loads.c hex_test.h
>  unaligned_pc: unaligned_pc.c
>
>  # This test has to be compiled for the -mv67t target
> diff --git a/tests/tcg/hexagon/test_pnew_jump_loads.c
> b/tests/tcg/hexagon/test_pnew_jump_loads.c
> new file mode 100644
> index 0000000000..2cba2b4002
> --- /dev/null
> +++ b/tests/tcg/hexagon/test_pnew_jump_loads.c
> @@ -0,0 +1,339 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Exhaustive test for predicated .new branches with non-standard
> predicate
> + * values (non-all-0, non-all-1).
> + *
> + * Hexagon predicates are 8 bits wide but conditional branches evaluate
> only
> + * bit 0 (the LSB).  A predicate value like 0xFE is non-zero yet has bit=
 0
> + * clear, so it must evaluate as "false".
> + *
> + * This test covers the distinct TCG code paths for predicated .new ops:
> + *
> + *   1. gen_cond_jump      - J2_jumptnewpt / J2_jumpfnewpt  (p0..p3)
> + *   2. gen_cond_jumpr     - J2_jumprtnewpt / J2_jumprfnewpt
> + *   3. gen_cond_jumpr31   - SL2_jumpr31_tnew / SL2_jumpr31_fnew (duplex=
)
> + *   4. gen_testbit0_jumpnv - J4_tstbit0_t/f_jumpnv_t
> + *   5. Conditional .new loads and stores
> + */
> +
> +#include <stdio.h>
> +#include <stdint.h>
> +
> +int err;
> +
> +#include "hex_test.h"
> +
> +/*
> + * Non-standard predicate: non-zero (0xFE) but bit 0 clear =3D> false.
> + * This distinguishes correct LSB evaluation from incorrect non-zero
> checks.
> + */
> +#define PRED_VAL    0xFEu
> +#define SENTINEL    0xDEADBEEFu
> +#define LOAD_VAL    0xAAAABBBBu
> +
> +/* gen_cond_jump (J2_jumptnewpt) */
> +
> +/*
> + * Macro to test jumptnew across predicate registers p0..p3.
> + * { Pn =3D and(Pn, Pn); if (Pn.new) jump:t TARGET }
> + *
> + * Pn.new =3D PRED_VAL & PRED_VAL =3D 0xFE =3D> bit0=3D0 =3D> not taken.
> + * Different predicate registers produce different instruction encodings=
.
> + */
> +#define TEST_JUMPTNEW(PREG)                                     \
> +static void test_jumptnew_##PREG(void)                          \
> +{                                                               \
> +    uint32_t jumped;                                            \
> +    asm volatile(                                               \
>

Don't need volatile here.


> +        #PREG " =3D %[pred]\n"                                    \
> +        "{ " #PREG " =3D and(" #PREG ", " #PREG ")\n"            \
> +        "  if (" #PREG ".new) jump:t 1f }\n"                   \
> +        "%[jumped] =3D #0\n"                                      \
> +        "jump 2f\n"                                             \
> +        "1:\n"                                                  \
> +        "%[jumped] =3D #1\n"                                      \
> +        "2:\n"                                                  \
> +        : [jumped] "=3D&r"(jumped)                                \
>

You don't need the & here.  Jumped is written after all the inputs are read=
.


> +        : [pred] "r"(PRED_VAL)                                  \
> +        : #PREG                                                 \
> +    );                                                          \
> +    check32(jumped, 0);                                         \
> +}
> +
> +TEST_JUMPTNEW(p0)
> +TEST_JUMPTNEW(p1)
> +TEST_JUMPTNEW(p2)
> +TEST_JUMPTNEW(p3)
> +
> +/* jumpfnew: bit0=3D0 =3D> condition "false" =3D> negated =3D> jump IS t=
aken */
> +static void test_jumpfnew_p0(void)
> +{
> +    uint32_t jumped;
> +
> +    asm volatile(
>

Don't need volatile


> +        "p0 =3D %[pred]\n"
> +        "{ p0 =3D and(p0, p0)\n"
> +        "  if (!p0.new) jump:t 1f }\n"
> +        "%[jumped] =3D #0\n"
> +        "jump 2f\n"
> +        "1:\n"
> +        "%[jumped] =3D #1\n"
> +        "2:\n"
> +        : [jumped] "=3D&r"(jumped)
>

Don't need &.


> +        : [pred] "r"(PRED_VAL)
> +        : "p0"
> +    );
> +    check32(jumped, 1);
> +}
> +
> +/* gen_cond_jumpr (J2_jumprtnewpt) */
> +
> +static void test_jumprtnew_p0(void)
> +{
> +    uint32_t jumped;
> +
> +    asm volatile(
>

Don't need volatile


> +        "p0 =3D %[pred]\n"
> +        "r0 =3D ##1f\n"
> +        "{ p0 =3D and(p0, p0)\n"
> +        "  if (p0.new) jumpr:t r0 }\n"
> +        "%[jumped] =3D #0\n"
> +        "jump 2f\n"
> +        "1:\n"
> +        "%[jumped] =3D #1\n"
> +        "2:\n"
> +        : [jumped] "=3D&r"(jumped)
>

Don't need &


> +        : [pred] "r"(PRED_VAL)
> +        : "p0", "r0"
> +    );
> +    check32(jumped, 0);
> +}
> +
> +static void test_jumprfnew_p0(void)
> +{
> +    uint32_t jumped;
> +
> +    asm volatile(
>

Don't need volatile


> +        "p0 =3D %[pred]\n"
> +        "r0 =3D ##1f\n"
> +        "{ p0 =3D and(p0, p0)\n"
> +        "  if (!p0.new) jumpr:t r0 }\n"
> +        "%[jumped] =3D #0\n"
> +        "jump 2f\n"
> +        "1:\n"
> +        "%[jumped] =3D #1\n"
> +        "2:\n"
> +        : [jumped] "=3D&r"(jumped)
>

Don't need &


> +        : [pred] "r"(PRED_VAL)
> +        : "p0", "r0"
> +    );
> +    check32(jumped, 1);
> +}
> +
> +/* gen_cond_jumpr31 (SL2_jumpr31_tnew) */
> +
> +/*
> + * Duplex sub-instructions: only SA1_cmpeqi and similar can produce .new
> + * predicates in a duplex packet, and those only yield 0x00/0xFF.
> + * We test with standard values to exercise the duplex decode path.
> + *
> + * { p0 =3D cmp.eq(r0, #0); if (p0.new) jumpr:nt r31 }
> + * With r0=3D0: p0.new =3D 0xFF =3D> bit0=3D1 =3D> taken.
> + */
> +static void test_jumpr31_tnew(void)
> +{
> +    uint32_t jumped;
> +
> +    asm volatile(
>

Don't need volatile


> +        "r0 =3D #0\n"
> +        "r31 =3D ##1f\n"
> +        "{ p0 =3D cmp.eq(r0, #0)\n"
> +        "  if (p0.new) jumpr:nt r31 }\n"
> +        "%[jumped] =3D #0\n"
> +        "jump 2f\n"
> +        "1:\n"
> +        "%[jumped] =3D #1\n"
> +        "2:\n"
> +        : [jumped] "=3D&r"(jumped)
>

Don't need &


> +        :
> +        : "r0", "r31", "p0"
> +    );
> +    check32(jumped, 1);
> +}
> +
> +/* p0.new =3D 0xFF =3D> bit0=3D1 =3D> !true =3D> not taken */
> +static void test_jumpr31_fnew(void)
> +{
> +    uint32_t jumped;
> +
> +    asm volatile(
>

Don't need volatile


> +        "r0 =3D #0\n"
> +        "r31 =3D ##1f\n"
> +        "{ p0 =3D cmp.eq(r0, #0)\n"
> +        "  if (!p0.new) jumpr:nt r31 }\n"
> +        "%[jumped] =3D #0\n"
> +        "jump 2f\n"
> +        "1:\n"
> +        "%[jumped] =3D #1\n"
> +        "2:\n"
> +        : [jumped] "=3D&r"(jumped)
>

Don't need &


> +        :
> +        : "r0", "r31", "p0"
> +    );
> +    check32(jumped, 0);
> +}
> +
> +/* gen_testbit0_jumpnv (J4_tstbit0) */
> +
> +/*
> + * { r0 =3D #0xFE; if (tstbit(r0.new, #0)) jump:t TARGET }
> + * r0.new =3D 0xFE =3D> bit0=3D0 =3D> tstbit false =3D> not taken.
> + */
> +static void test_tstbit0_t_jumpnv(void)
> +{
> +    uint32_t jumped;
> +
> +    asm volatile(
>

Don't need volatile


> +        "{ r0 =3D #0xFE\n"
> +        "  if (tstbit(r0.new, #0)) jump:t 1f }\n"
> +        "%[jumped] =3D #0\n"
> +        "jump 2f\n"
> +        "1:\n"
> +        "%[jumped] =3D #1\n"
> +        "2:\n"
> +        : [jumped] "=3D&r"(jumped)
>

Don't need &


> +        :
> +        : "r0"
> +    );
> +    check32(jumped, 0);
> +}
> +
> +/* bit0=3D0 =3D> tstbit false =3D> negated =3D> taken */
> +static void test_tstbit0_f_jumpnv(void)
> +{
> +    uint32_t jumped;
> +
> +    asm volatile(
>

Don't need volatile


> +        "{ r0 =3D #0xFE\n"
> +        "  if (!tstbit(r0.new, #0)) jump:t 1f }\n"
> +        "%[jumped] =3D #0\n"
> +        "jump 2f\n"
> +        "1:\n"
> +        "%[jumped] =3D #1\n"
> +        "2:\n"
> +        : [jumped] "=3D&r"(jumped)
>

Don't need &


> +        :
> +        : "r0"
> +    );
> +    check32(jumped, 1);
> +}
> +
> +/* conditional .new loads and stores */
> +
> +static uint32_t load_val;
> +static uint32_t store_dst;
> +
> +/* bit0=3D0 =3D> condition false =3D> load skipped =3D> sentinel remains=
 */
> +static void test_cond_load_tnew(void)
> +{
> +    uint32_t result;
> +
> +    load_val =3D LOAD_VAL;
> +    asm volatile(
>

Don't need volatile


> +        "p0 =3D %[pred]\n"
> +        "%[res] =3D ##0xDEADBEEF\n"
>

Use SENTINEL instead of 0xDEADBEEF


> +        "{ p0 =3D and(p0, p0)\n"
> +        "  if (p0.new) %[res] =3D memw(%[addr]+#0) }\n"
> +        : [res] "=3D&r"(result)
>

Note that & *is* needed here.


> +        : [pred] "r"(PRED_VAL),
> +          [addr] "r"(&load_val)
> +        : "p0", "memory"
> +    );
> +    check32(result, SENTINEL);
> +}
> +
> +/* bit0=3D0 =3D> condition false =3D> negated =3D> load executed */
> +static void test_cond_load_fnew(void)
> +{
> +    uint32_t result;
> +
> +    load_val =3D LOAD_VAL;
> +    asm volatile(
>

Don't need volatile


> +        "p0 =3D %[pred]\n"
> +        "%[res] =3D ##0xDEADBEEF\n"
>

SENTINEL


> +        "{ p0 =3D and(p0, p0)\n"
> +        "  if (!p0.new) %[res] =3D memw(%[addr]+#0) }\n"
> +        : [res] "=3D&r"(result)
> +        : [pred] "r"(PRED_VAL),
> +          [addr] "r"(&load_val)
> +        : "p0", "memory"
> +    );
> +    check32(result, LOAD_VAL);
> +}
> +
> +/* bit0=3D0 =3D> condition false =3D> store skipped =3D> sentinel remain=
s */
> +static void test_cond_store_tnew(void)
> +{
> +    store_dst =3D SENTINEL;
> +    asm volatile(
>
+        "p0 =3D %[pred]\n"
> +        "{ p0 =3D and(p0, p0)\n"
> +        "  if (p0.new) memw(%[addr]+#0) =3D %[val] }\n"
> +        :
> +        : [pred] "r"(PRED_VAL),
> +          [addr] "r"(&store_dst),
> +          [val] "r"(LOAD_VAL)
> +        : "p0", "memory"
> +    );
> +    check32(store_dst, SENTINEL);
> +}
> +
> +/* bit0=3D0 =3D> condition false =3D> negated =3D> store executed */
> +static void test_cond_store_fnew(void)
> +{
> +    store_dst =3D SENTINEL;
> +    asm volatile(
> +        "p0 =3D %[pred]\n"
> +        "{ p0 =3D and(p0, p0)\n"
> +        "  if (!p0.new) memw(%[addr]+#0) =3D %[val] }\n"
> +        :
> +        : [pred] "r"(PRED_VAL),
> +          [addr] "r"(&store_dst),
> +          [val] "r"(LOAD_VAL)
> +        : "p0", "memory"
> +    );
> +    check32(store_dst, LOAD_VAL);
> +}
> +
> +int main(void)
> +{
> +    /* gen_cond_jump with all predicate registers */
> +    test_jumptnew_p0();
> +    test_jumptnew_p1();
> +    test_jumptnew_p2();
> +    test_jumptnew_p3();
> +    test_jumpfnew_p0();
> +
> +    /* gen_cond_jumpr */
> +    test_jumprtnew_p0();
> +    test_jumprfnew_p0();
> +
> +    /* gen_cond_jumpr31 (duplex, standard values) */
> +    test_jumpr31_tnew();
> +    test_jumpr31_fnew();
> +
> +    /* gen_testbit0_jumpnv */
> +    test_tstbit0_t_jumpnv();
> +    test_tstbit0_f_jumpnv();
> +
> +    /* conditional .new loads and stores */
> +    test_cond_load_tnew();
> +    test_cond_load_fnew();
> +    test_cond_store_tnew();
> +    test_cond_store_fnew();
> +
> +    puts(err ? "FAIL" : "PASS");
> +    return err ? 1 : 0;
> +}
>

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--000000000000536f65064bff9f32
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 25,=
 2026 at 9:34=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qu=
alcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">Test for predicated .new branches wi=
th non-standard predicate values<br>
(non-all-0, non-all-1).=C2=A0 Hexagon predicates are 8 bits wide but condit=
ional<br>
branches evaluate only the LSB.<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0tests/tcg/hexagon/Makefile.target=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A03 +<br>
=C2=A0tests/tcg/hexagon/test_pnew_jump_loads.c | 339 ++++++++++++++++++++++=
+<br>
=C2=A02 files changed, 342 insertions(+)<br>
=C2=A0create mode 100644 tests/tcg/hexagon/test_pnew_jump_loads.c<br>
<br>
diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile=
.target<br>
index f86f02bb31..5199c78536 100644<br>
--- a/tests/tcg/hexagon/Makefile.target<br>
+++ b/tests/tcg/hexagon/Makefile.target<br>
@@ -81,6 +81,8 @@ HEX_TESTS +=3D test_vminh<br>
=C2=A0HEX_TESTS +=3D test_vpmpyh<br>
=C2=A0HEX_TESTS +=3D test_vspliceb<br>
<br>
+HEX_TESTS +=3D test_pnew_jump_loads<br>
+<br>
=C2=A0HEX_TESTS +=3D v68_scalar<br>
=C2=A0HEX_TESTS +=3D v68_hvx<br>
=C2=A0HEX_TESTS +=3D v69_hvx<br>
@@ -104,6 +106,7 @@ overflow: overflow.c hex_test.h<br>
=C2=A0preg_alias: preg_alias.c hex_test.h<br>
=C2=A0read_write_overlap: read_write_overlap.c hex_test.h<br>
=C2=A0reg_mut: reg_mut.c hex_test.h<br>
+test_pnew_jump_loads: test_pnew_jump_loads.c hex_test.h<br>
=C2=A0unaligned_pc: unaligned_pc.c<br>
<br>
=C2=A0# This test has to be compiled for the -mv67t target<br>
diff --git a/tests/tcg/hexagon/test_pnew_jump_loads.c b/tests/tcg/hexagon/t=
est_pnew_jump_loads.c<br>
new file mode 100644<br>
index 0000000000..2cba2b4002<br>
--- /dev/null<br>
+++ b/tests/tcg/hexagon/test_pnew_jump_loads.c<br>
@@ -0,0 +1,339 @@<br>
+/*<br>
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.<br>
+ * SPDX-License-Identifier: GPL-2.0-or-later<br>
+ *<br>
+ * Exhaustive test for predicated .new branches with non-standard predicat=
e<br>
+ * values (non-all-0, non-all-1).<br>
+ *<br>
+ * Hexagon predicates are 8 bits wide but conditional branches evaluate on=
ly<br>
+ * bit 0 (the LSB).=C2=A0 A predicate value like 0xFE is non-zero yet has =
bit 0<br>
+ * clear, so it must evaluate as &quot;false&quot;.<br>
+ *<br>
+ * This test covers the distinct TCG code paths for predicated .new ops:<b=
r>
+ *<br>
+ *=C2=A0 =C2=A01. gen_cond_jump=C2=A0 =C2=A0 =C2=A0 - J2_jumptnewpt / J2_j=
umpfnewpt=C2=A0 (p0..p3)<br>
+ *=C2=A0 =C2=A02. gen_cond_jumpr=C2=A0 =C2=A0 =C2=A0- J2_jumprtnewpt / J2_=
jumprfnewpt<br>
+ *=C2=A0 =C2=A03. gen_cond_jumpr31=C2=A0 =C2=A0- SL2_jumpr31_tnew / SL2_ju=
mpr31_fnew (duplex)<br>
+ *=C2=A0 =C2=A04. gen_testbit0_jumpnv - J4_tstbit0_t/f_jumpnv_t<br>
+ *=C2=A0 =C2=A05. Conditional .new loads and stores<br>
+ */<br>
+<br>
+#include &lt;stdio.h&gt;<br>
+#include &lt;stdint.h&gt;<br>
+<br>
+int err;<br>
+<br>
+#include &quot;hex_test.h&quot;<br>
+<br>
+/*<br>
+ * Non-standard predicate: non-zero (0xFE) but bit 0 clear =3D&gt; false.<=
br>
+ * This distinguishes correct LSB evaluation from incorrect non-zero check=
s.<br>
+ */<br>
+#define PRED_VAL=C2=A0 =C2=A0 0xFEu<br>
+#define SENTINEL=C2=A0 =C2=A0 0xDEADBEEFu<br>
+#define LOAD_VAL=C2=A0 =C2=A0 0xAAAABBBBu<br>
+<br>
+/* gen_cond_jump (J2_jumptnewpt) */<br>
+<br>
+/*<br>
+ * Macro to test jumptnew across predicate registers p0..p3.<br>
+ * { Pn =3D and(Pn, Pn); if (Pn.new) jump:t TARGET }<br>
+ *<br>
+ * Pn.new =3D PRED_VAL &amp; PRED_VAL =3D 0xFE =3D&gt; bit0=3D0 =3D&gt; no=
t taken.<br>
+ * Different predicate registers produce different instruction encodings.<=
br>
+ */<br>
+#define TEST_JUMPTNEW(PREG)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0\<br>
+static void test_jumptnew_##PREG(void)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+{=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0\<br>
+=C2=A0 =C2=A0 uint32_t jumped;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 asm volatile(=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br></blockquote><div><br>=
</div><div>Don&#39;t need volatile here.</div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 #PREG &quot; =3D %[pred]\n&quot;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;{ &quot; #PREG &quot; =3D and(&quot; #PR=
EG &quot;, &quot; #PREG &quot;)\n&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 if (&quot; #PREG &quot;.new) jump=
:t 1f }\n&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%[jumped] =3D #0\n&quot;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;jump 2f\n&quot;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;1:\n&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%[jumped] =3D #1\n&quot;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;2:\n&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : [jumped] &quot;=3D&amp;r&quot;(jumped)=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br></blockquote><div><br></div><div>You d=
on&#39;t need the &amp; here.=C2=A0 Jumped is written after all the inputs =
are read.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : [pred] &quot;r&quot;(PRED_VAL)=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : #PREG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 );=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \=
<br>
+=C2=A0 =C2=A0 check32(jumped, 0);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
+}<br>
+<br>
+TEST_JUMPTNEW(p0)<br>
+TEST_JUMPTNEW(p1)<br>
+TEST_JUMPTNEW(p2)<br>
+TEST_JUMPTNEW(p3)<br>
+<br>
+/* jumpfnew: bit0=3D0 =3D&gt; condition &quot;false&quot; =3D&gt; negated =
=3D&gt; jump IS taken */<br>
+static void test_jumpfnew_p0(void)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t jumped;<br>
+<br>
+=C2=A0 =C2=A0 asm volatile(<br></blockquote><div><br></div><div>Don&#39;t =
need volatile</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;p0 =3D %[pred]\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;{ p0 =3D and(p0, p0)\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 if (!<a href=3D"http://p0.new" re=
l=3D"noreferrer" target=3D"_blank">p0.new</a>) jump:t 1f }\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%[jumped] =3D #0\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;jump 2f\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;1:\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%[jumped] =3D #1\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;2:\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : [jumped] &quot;=3D&amp;r&quot;(jumped)<br></=
blockquote><div><br></div><div>Don&#39;t need &amp;.</div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : [pred] &quot;r&quot;(PRED_VAL)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : &quot;p0&quot;<br>
+=C2=A0 =C2=A0 );<br>
+=C2=A0 =C2=A0 check32(jumped, 1);<br>
+}<br>
+<br>
+/* gen_cond_jumpr (J2_jumprtnewpt) */<br>
+<br>
+static void test_jumprtnew_p0(void)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t jumped;<br>
+<br>
+=C2=A0 =C2=A0 asm volatile(<br></blockquote><div><br></div><div>Don&#39;t =
need volatile</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;p0 =3D %[pred]\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;r0 =3D ##1f\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;{ p0 =3D and(p0, p0)\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 if (<a href=3D"http://p0.new" rel=
=3D"noreferrer" target=3D"_blank">p0.new</a>) jumpr:t r0 }\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%[jumped] =3D #0\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;jump 2f\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;1:\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%[jumped] =3D #1\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;2:\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : [jumped] &quot;=3D&amp;r&quot;(jumped)<br></=
blockquote><div><br></div><div>Don&#39;t need &amp;</div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : [pred] &quot;r&quot;(PRED_VAL)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : &quot;p0&quot;, &quot;r0&quot;<br>
+=C2=A0 =C2=A0 );<br>
+=C2=A0 =C2=A0 check32(jumped, 0);<br>
+}<br>
+<br>
+static void test_jumprfnew_p0(void)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t jumped;<br>
+<br>
+=C2=A0 =C2=A0 asm volatile(<br></blockquote><div><br></div><div>Don&#39;t =
need volatile</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;p0 =3D %[pred]\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;r0 =3D ##1f\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;{ p0 =3D and(p0, p0)\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 if (!<a href=3D"http://p0.new" re=
l=3D"noreferrer" target=3D"_blank">p0.new</a>) jumpr:t r0 }\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%[jumped] =3D #0\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;jump 2f\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;1:\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%[jumped] =3D #1\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;2:\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : [jumped] &quot;=3D&amp;r&quot;(jumped)<br></=
blockquote><div><br></div><div>Don&#39;t need &amp;</div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : [pred] &quot;r&quot;(PRED_VAL)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : &quot;p0&quot;, &quot;r0&quot;<br>
+=C2=A0 =C2=A0 );<br>
+=C2=A0 =C2=A0 check32(jumped, 1);<br>
+}<br>
+<br>
+/* gen_cond_jumpr31 (SL2_jumpr31_tnew) */<br>
+<br>
+/*<br>
+ * Duplex sub-instructions: only SA1_cmpeqi and similar can produce .new<b=
r>
+ * predicates in a duplex packet, and those only yield 0x00/0xFF.<br>
+ * We test with standard values to exercise the duplex decode path.<br>
+ *<br>
+ * { p0 =3D cmp.eq(r0, #0); if (<a href=3D"http://p0.new" rel=3D"noreferre=
r" target=3D"_blank">p0.new</a>) jumpr:nt r31 }<br>
+ * With r0=3D0: <a href=3D"http://p0.new" rel=3D"noreferrer" target=3D"_bl=
ank">p0.new</a> =3D 0xFF =3D&gt; bit0=3D1 =3D&gt; taken.<br>
+ */<br>
+static void test_jumpr31_tnew(void)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t jumped;<br>
+<br>
+=C2=A0 =C2=A0 asm volatile(<br></blockquote><div><br></div><div>Don&#39;t =
need volatile</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;r0 =3D #0\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;r31 =3D ##1f\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;{ p0 =3D cmp.eq(r0, #0)\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 if (<a href=3D"http://p0.new" rel=
=3D"noreferrer" target=3D"_blank">p0.new</a>) jumpr:nt r31 }\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%[jumped] =3D #0\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;jump 2f\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;1:\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%[jumped] =3D #1\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;2:\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : [jumped] &quot;=3D&amp;r&quot;(jumped)<br></=
blockquote><div><br></div><div>Don&#39;t need &amp;</div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : &quot;r0&quot;, &quot;r31&quot;, &quot;p0&qu=
ot;<br>
+=C2=A0 =C2=A0 );<br>
+=C2=A0 =C2=A0 check32(jumped, 1);<br>
+}<br>
+<br>
+/* <a href=3D"http://p0.new" rel=3D"noreferrer" target=3D"_blank">p0.new</=
a> =3D 0xFF =3D&gt; bit0=3D1 =3D&gt; !true =3D&gt; not taken */<br>
+static void test_jumpr31_fnew(void)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t jumped;<br>
+<br>
+=C2=A0 =C2=A0 asm volatile(<br></blockquote><div><br></div><div>Don&#39;t =
need volatile</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;r0 =3D #0\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;r31 =3D ##1f\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;{ p0 =3D cmp.eq(r0, #0)\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 if (!<a href=3D"http://p0.new" re=
l=3D"noreferrer" target=3D"_blank">p0.new</a>) jumpr:nt r31 }\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%[jumped] =3D #0\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;jump 2f\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;1:\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%[jumped] =3D #1\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;2:\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : [jumped] &quot;=3D&amp;r&quot;(jumped)<br></=
blockquote><div><br></div><div>Don&#39;t need &amp;</div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : &quot;r0&quot;, &quot;r31&quot;, &quot;p0&qu=
ot;<br>
+=C2=A0 =C2=A0 );<br>
+=C2=A0 =C2=A0 check32(jumped, 0);<br>
+}<br>
+<br>
+/* gen_testbit0_jumpnv (J4_tstbit0) */<br>
+<br>
+/*<br>
+ * { r0 =3D #0xFE; if (tstbit(<a href=3D"http://r0.new" rel=3D"noreferrer"=
 target=3D"_blank">r0.new</a>, #0)) jump:t TARGET }<br>
+ * <a href=3D"http://r0.new" rel=3D"noreferrer" target=3D"_blank">r0.new</=
a> =3D 0xFE =3D&gt; bit0=3D0 =3D&gt; tstbit false =3D&gt; not taken.<br>
+ */<br>
+static void test_tstbit0_t_jumpnv(void)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t jumped;<br>
+<br>
+=C2=A0 =C2=A0 asm volatile(<br></blockquote><div><br></div><div>Don&#39;t =
need volatile</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;{ r0 =3D #0xFE\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 if (tstbit(<a href=3D"http://r0.n=
ew" rel=3D"noreferrer" target=3D"_blank">r0.new</a>, #0)) jump:t 1f }\n&quo=
t;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%[jumped] =3D #0\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;jump 2f\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;1:\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%[jumped] =3D #1\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;2:\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : [jumped] &quot;=3D&amp;r&quot;(jumped)<br></=
blockquote><div><br></div><div>Don&#39;t need &amp;</div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : &quot;r0&quot;<br>
+=C2=A0 =C2=A0 );<br>
+=C2=A0 =C2=A0 check32(jumped, 0);<br>
+}<br>
+<br>
+/* bit0=3D0 =3D&gt; tstbit false =3D&gt; negated =3D&gt; taken */<br>
+static void test_tstbit0_f_jumpnv(void)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t jumped;<br>
+<br>
+=C2=A0 =C2=A0 asm volatile(<br></blockquote><div><br></div><div>Don&#39;t =
need volatile</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;{ r0 =3D #0xFE\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 if (!tstbit(<a href=3D"http://r0.=
new" rel=3D"noreferrer" target=3D"_blank">r0.new</a>, #0)) jump:t 1f }\n&qu=
ot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%[jumped] =3D #0\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;jump 2f\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;1:\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%[jumped] =3D #1\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;2:\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : [jumped] &quot;=3D&amp;r&quot;(jumped)<br></=
blockquote><div><br></div><div>Don&#39;t need &amp;</div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : &quot;r0&quot;<br>
+=C2=A0 =C2=A0 );<br>
+=C2=A0 =C2=A0 check32(jumped, 1);<br>
+}<br>
+<br>
+/* conditional .new loads and stores */<br>
+<br>
+static uint32_t load_val;<br>
+static uint32_t store_dst;<br>
+<br>
+/* bit0=3D0 =3D&gt; condition false =3D&gt; load skipped =3D&gt; sentinel =
remains */<br>
+static void test_cond_load_tnew(void)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t result;<br>
+<br>
+=C2=A0 =C2=A0 load_val =3D LOAD_VAL;<br>
+=C2=A0 =C2=A0 asm volatile(<br></blockquote><div><br></div><div>Don&#39;t =
need volatile</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;p0 =3D %[pred]\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%[res] =3D ##0xDEADBEEF\n&quot;<br></blo=
ckquote><div><br></div><div>Use SENTINEL instead of 0xDEADBEEF</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;{ p0 =3D and(p0, p0)\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 if (<a href=3D"http://p0.new" rel=
=3D"noreferrer" target=3D"_blank">p0.new</a>) %[res] =3D memw(%[addr]+#0) }=
\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : [res] &quot;=3D&amp;r&quot;(result)<br></blo=
ckquote><div><br></div><div>Note that &amp; *is* needed here.</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : [pred] &quot;r&quot;(PRED_VAL),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [addr] &quot;r&quot;(&amp;load_val)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : &quot;p0&quot;, &quot;memory&quot;<br>
+=C2=A0 =C2=A0 );<br>
+=C2=A0 =C2=A0 check32(result, SENTINEL);<br>
+}<br>
+<br>
+/* bit0=3D0 =3D&gt; condition false =3D&gt; negated =3D&gt; load executed =
*/<br>
+static void test_cond_load_fnew(void)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t result;<br>
+<br>
+=C2=A0 =C2=A0 load_val =3D LOAD_VAL;<br>
+=C2=A0 =C2=A0 asm volatile(<br></blockquote><div><br></div><div>Don&#39;t =
need volatile</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;p0 =3D %[pred]\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%[res] =3D ##0xDEADBEEF\n&quot;<br></blo=
ckquote><div><br></div><div>SENTINEL</div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;{ p0 =3D and(p0, p0)\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 if (!<a href=3D"http://p0.new" re=
l=3D"noreferrer" target=3D"_blank">p0.new</a>) %[res] =3D memw(%[addr]+#0) =
}\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : [res] &quot;=3D&amp;r&quot;(result)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : [pred] &quot;r&quot;(PRED_VAL),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [addr] &quot;r&quot;(&amp;load_val)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : &quot;p0&quot;, &quot;memory&quot;<br>
+=C2=A0 =C2=A0 );<br>
+=C2=A0 =C2=A0 check32(result, LOAD_VAL);<br>
+}<br>
+<br>
+/* bit0=3D0 =3D&gt; condition false =3D&gt; store skipped =3D&gt; sentinel=
 remains */<br>
+static void test_cond_store_tnew(void)<br>
+{<br>
+=C2=A0 =C2=A0 store_dst =3D SENTINEL;<br>
+=C2=A0 =C2=A0 asm volatile(<br></blockquote><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;p0 =3D %[pred]\n&quo=
t;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;{ p0 =3D and(p0, p0)\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 if (<a href=3D"http://p0.new" rel=
=3D"noreferrer" target=3D"_blank">p0.new</a>) memw(%[addr]+#0) =3D %[val] }=
\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : [pred] &quot;r&quot;(PRED_VAL),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [addr] &quot;r&quot;(&amp;store_dst),<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [val] &quot;r&quot;(LOAD_VAL)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : &quot;p0&quot;, &quot;memory&quot;<br>
+=C2=A0 =C2=A0 );<br>
+=C2=A0 =C2=A0 check32(store_dst, SENTINEL);<br>
+}<br>
+<br>
+/* bit0=3D0 =3D&gt; condition false =3D&gt; negated =3D&gt; store executed=
 */<br>
+static void test_cond_store_fnew(void)<br>
+{<br>
+=C2=A0 =C2=A0 store_dst =3D SENTINEL;<br>
+=C2=A0 =C2=A0 asm volatile(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;p0 =3D %[pred]\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;{ p0 =3D and(p0, p0)\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 if (!<a href=3D"http://p0.new" re=
l=3D"noreferrer" target=3D"_blank">p0.new</a>) memw(%[addr]+#0) =3D %[val] =
}\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : [pred] &quot;r&quot;(PRED_VAL),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [addr] &quot;r&quot;(&amp;store_dst),<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [val] &quot;r&quot;(LOAD_VAL)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : &quot;p0&quot;, &quot;memory&quot;<br>
+=C2=A0 =C2=A0 );<br>
+=C2=A0 =C2=A0 check32(store_dst, LOAD_VAL);<br>
+}<br>
+<br>
+int main(void)<br>
+{<br>
+=C2=A0 =C2=A0 /* gen_cond_jump with all predicate registers */<br>
+=C2=A0 =C2=A0 test_jumptnew_p0();<br>
+=C2=A0 =C2=A0 test_jumptnew_p1();<br>
+=C2=A0 =C2=A0 test_jumptnew_p2();<br>
+=C2=A0 =C2=A0 test_jumptnew_p3();<br>
+=C2=A0 =C2=A0 test_jumpfnew_p0();<br>
+<br>
+=C2=A0 =C2=A0 /* gen_cond_jumpr */<br>
+=C2=A0 =C2=A0 test_jumprtnew_p0();<br>
+=C2=A0 =C2=A0 test_jumprfnew_p0();<br>
+<br>
+=C2=A0 =C2=A0 /* gen_cond_jumpr31 (duplex, standard values) */<br>
+=C2=A0 =C2=A0 test_jumpr31_tnew();<br>
+=C2=A0 =C2=A0 test_jumpr31_fnew();<br>
+<br>
+=C2=A0 =C2=A0 /* gen_testbit0_jumpnv */<br>
+=C2=A0 =C2=A0 test_tstbit0_t_jumpnv();<br>
+=C2=A0 =C2=A0 test_tstbit0_f_jumpnv();<br>
+<br>
+=C2=A0 =C2=A0 /* conditional .new loads and stores */<br>
+=C2=A0 =C2=A0 test_cond_load_tnew();<br>
+=C2=A0 =C2=A0 test_cond_load_fnew();<br>
+=C2=A0 =C2=A0 test_cond_store_tnew();<br>
+=C2=A0 =C2=A0 test_cond_store_fnew();<br>
+<br>
+=C2=A0 =C2=A0 puts(err ? &quot;FAIL&quot; : &quot;PASS&quot;);<br>
+=C2=A0 =C2=A0 return err ? 1 : 0;<br>
+}<br></blockquote><div><br></div><div>Otherwise</div><div>Reviewed-by: Tay=
lor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.com">ltaylorsimpson@=
gmail.com</a>&gt;=C2=A0</div></div></div>

--000000000000536f65064bff9f32--

