Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 047171093168
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 02:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Dg7-0002of-5X; Tue, 24 Mar 2026 22:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5Dg6-0002oR-5W
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 22:09:02 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5Dg3-0005Mc-NI
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 22:09:01 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b93698bb57aso97850866b.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 19:08:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774404538; cv=none;
 d=google.com; s=arc-20240605;
 b=P6ErH9oETWC5ZA6Mk4Q1q/Nu7yePYRAx70SO0Va6HFia4LgQ/bmgjKoRJAqinFaiPG
 tK9/sRGz6QWkCC/iV+KT6Pm4YOO+IACPa9hvsN97heqS94I0yjBWYrA05SHs9vy8BBKQ
 Ypp72S1fftTW02iMpMRmUJDz+HgWsOEq3z3z7DqRwRvEO2Ie/YHPSpAxBp/gtv80FH+z
 5Xj0JJfJFdCxzd8sqlIrfx0xUXX+71dU5yjU6RXRt/PpMKDceFvIsMsnHEpCCP9lQSIl
 MG4DB2J6AQubi/D/NF3dzzlne+vMYT4xSUBQjsJMhyRFVyO1bIqW1Ku2F9beiCBNF0K8
 CViA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=07oiRVKHJkRhMErOMJgQaNGho06xV/T+gbhZqqwx8kg=;
 fh=oxc//47PJYPQEvay9aICOKlni50QEUqoO/7LuDLpGec=;
 b=hCMrLujmp4BlncEyTWIcc0Cs0jE0ZSVyT0dcbIxGNKqWs035Te4IL++r5Xo2JemE40
 +tj8yJR/yfBYC5rN2/lMsO8Jf2aBJ1NMlcHvdondh7jl+ERzhyyKlk/CMHpLnlJLewF3
 gtAkDKmS71BQZiDwuNzNtVAOifHIUtIBzmHt8x5LPLRQ0XguiccMMNzhoDdRjfA+UFwu
 CYON89OF5RM5pLosi6Z2n7BVGi4k9YrMzLotihxUZTMap/RD4lNYdkf4FHrc2d8XYmAM
 nofjFdsLSr6VrFCOgmBi1TUNxvFeb8hUVAzz5wTtBUsoX0IBj2uYlP5flaVtpniub6f3
 7s4A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774404538; x=1775009338; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=07oiRVKHJkRhMErOMJgQaNGho06xV/T+gbhZqqwx8kg=;
 b=hb8k1R1xQi/uF7ZPIfRUrr5IqM2psypAp8aevQb5iaLtLWrvUEge+3GuURlhQtRKIx
 lI9XStlMgatbDEfsoZmqcfDYFhwkkUsEBOC4EnJJ6nR88i83w5PG7J64D6iQXaDW/T40
 zHRX2NGm6GXpYepkOrkH7gEhBZAzccNdnnS/GgvgVAhQgV3b8IBljEKjVZAGx6tbIXSf
 dTv5RNaWNF3eDxXQXRsinksP6tUQtNKRMdD0EK7vEL90JkTZO2dYvBhlX1I6QK1bMiga
 iUT60DgJZCIL5mwyFyyrBWeZ1pxRrVJkidGPklIizVnq3XU0Ap2vilhtcF9sBSF6Jr9H
 unpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774404538; x=1775009338;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=07oiRVKHJkRhMErOMJgQaNGho06xV/T+gbhZqqwx8kg=;
 b=ZykanKtDVzEcWnXsux6G6bS0ujoxFbFo+vqxwjxtssGzJVEmJpVty7pIjj3IOvHdNz
 MJlIvAMdtmSlAP8j8BgctTu8jmd2VaVKqs2zEfFRONNUkTWgIusvbViMI9crAvXQCxOq
 8ZXy1LpEPBcqUXIPwsCDiJ2ilmATbGId2kS777XPCAsJD5f+iw50nQH7L7tiKxHoGi58
 ZbTTPm3hzknY5+aDA4HKkWsIxowrUtO4djcBa2IuUOBCFv2HXqK0DoxLBlRu5Dhgtpmr
 0mAvBHQ+KeXWVe1pGcPNxfFdnCVzxyEu8XJk4hSQ0vIvmAHu+49fxqv2NpZwn2NyL7VA
 ZgQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7J0+luVF2xdEvck4xgzAk9vw+mR11LMq7DsnPdxL8E+FK4v57UsQtQ/LafUbQm4XK6ruib/dI6nUU@nongnu.org
X-Gm-Message-State: AOJu0Yx7U/jjaKh5mdjbXP4DSZ1WmiPZNfPyCX+cQQRSsZNoysa6l+oj
 8/p2PGboD0xedlDJKdz1ccYW3XkZIc4nqdADfplAPeSYZD+8mlUKQaWwXCDFJdk1wrv7GMYpEgi
 Sf3e2ryeVtD0pnId3nZFWbs8f9RU0eeU=
X-Gm-Gg: ATEYQzyrvNHuwJANNu5aA1wBqWn7uqBAUnIugynA5NgCqyRNDb93XBTKFENQxir9yEh
 TdJMzIcddvx4po6YC2TPTkLaOqhVYLVye2zR9l/PCgaAjpDc4MtR6Y77iQEbHHQgwdtB2bNaG+1
 DFDtr303OI1BwMyhmM+Prknldh+DtSBFtdEgLHvrvtNQiyOMHmkFJe3FEzwnyOVHeTiRFCXvXBm
 Tcskm56LFEw26GPmOrUau14C22s4nNhXKQuGAHAdd9qdZ2JdSubsh9w1QkohgGl89IMY7k/rt1D
 dqq4bkhSl6W4ASSoEzSt10YEynObIeUzmSqu/Q==
X-Received: by 2002:a17:907:db02:b0:b97:be1a:3bac with SMTP id
 a640c23a62f3a-b988642a96amr354117066b.26.1774404537882; Tue, 24 Mar 2026
 19:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260321144554.606417-1-npiggin@gmail.com>
 <20260321144554.606417-4-npiggin@gmail.com>
In-Reply-To: <20260321144554.606417-4-npiggin@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 25 Mar 2026 12:08:31 +1000
X-Gm-Features: AQROBzCl7P7H1GeYH5LBcLyCgGsyA_aCr8vGBMSn7Z9XcX9Eez7duOzO_poTMKQ
Message-ID: <CAKmqyKOPAzi3g-BCGmqSpRnumq6RPLPSvV7ORP5Jh+5nrfVduw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] tests/tcg: Add riscv test for interrupted vector
 ops
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-riscv@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org, 
 Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x635.google.com
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
> riscv vector instructions can be interrupted with a trap, and partial
> completion is recorded in the vstart register. Some causes are
> implementation dependent, for example an asynchronous interrupt (which I
> don't think TCG allows). Others are architectural, typically memory
> access faults on vector load/store instructions.
>
> Add some TCG tests for interrupting vector load instructions and
> resuming partially completed ones.
>
> This would have caught a recent (now reverted) regression in vector
> stride load implementation, commit 28c12c1f2f50d ("Generate strided
> vector loads/stores with tcg nodes.")
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/tcg/riscv64/Makefile.target      |  11 +
>  tests/tcg/riscv64/test-interrupted-v.c | 329 +++++++++++++++++++++++++
>  2 files changed, 340 insertions(+)
>  create mode 100644 tests/tcg/riscv64/test-interrupted-v.c
>
> diff --git a/tests/tcg/riscv64/Makefile.target b/tests/tcg/riscv64/Makefi=
le.target
> index 19a49b6467..b2b2325843 100644
> --- a/tests/tcg/riscv64/Makefile.target
> +++ b/tests/tcg/riscv64/Makefile.target
> @@ -1,6 +1,10 @@
>  # -*- Mode: makefile -*-
>  # RISC-V specific tweaks
>
> +# Not all environments have compilers with vector intrinsics yet.
> +HAVE_RISCV_VECTOR_INTRINSICS :=3D $(shell echo '#ifndef __riscv_v_intrin=
sic\n#error\n#endif' |  \
> +                                  $(CC) -march=3Drv64gcv -E -x c - >/dev=
/null 2>&1 && echo y)
> +
>  VPATH +=3D $(SRC_PATH)/tests/tcg/riscv64
>  TESTS +=3D test-div
>  TESTS +=3D noexec
> @@ -23,3 +27,10 @@ run-test-fcvtmod: QEMU_OPTS +=3D -cpu rv64,d=3Dtrue,zf=
a=3Dtrue
>  TESTS +=3D test-vstart-overflow
>  test-vstart-overflow: CFLAGS +=3D -march=3Drv64gcv
>  run-test-vstart-overflow: QEMU_OPTS +=3D -cpu rv64,v=3Don
> +
> +ifeq ($(HAVE_RISCV_VECTOR_INTRINSICS),y)
> +# Test for interrupted vector instructions
> +TESTS +=3D test-interrupted-v
> +test-interrupted-v: CFLAGS +=3D -march=3Drv64gcv
> +run-test-interrupted-v: QEMU_OPTS +=3D -cpu rv64,v=3Don
> +endif
> diff --git a/tests/tcg/riscv64/test-interrupted-v.c b/tests/tcg/riscv64/t=
est-interrupted-v.c
> new file mode 100644
> index 0000000000..3d0d21b49b
> --- /dev/null
> +++ b/tests/tcg/riscv64/test-interrupted-v.c
> @@ -0,0 +1,329 @@
> +/*
> + * Test for interrupted vector operations.
> + *
> + * Some vector instructions can be interrupted partially complete, vstar=
t will
> + * be set to where the operation has progressed to, and the instruction =
can be
> + * re-executed with vstart !=3D 0. It is implementation dependent as to =
what
> + * instructions can be interrupted and what vstart values are permitted =
when
> + * executing them. Vector memory operations can typically be interrupted
> + * (as they can take page faults), so these are easy to test.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include <stdlib.h>
> +#include <stdint.h>
> +#include <stdbool.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include <stdio.h>
> +#include <assert.h>
> +#include <signal.h>
> +#include <unistd.h>
> +#include <riscv_vector.h>
> +
> +static unsigned long page_size;
> +
> +static volatile int nr_segv;
> +static volatile unsigned long fault_start, fault_end;
> +static volatile bool fault_write;
> +
> +/*
> + * Careful: qemu-user does not save/restore vector state in
> + * signals yet, so any library or compiler autovec code will
> + * corrupt our test.
> + *
> + * Do only minimal work in the signal handler.
> + */
> +static void SEGV_handler(int signo, siginfo_t *info, void *context)
> +{
> +    unsigned long page =3D (unsigned long)info->si_addr &
> +                             ~(unsigned long)(page_size - 1);
> +
> +    assert((unsigned long)info->si_addr >=3D fault_start);
> +    assert((unsigned long)info->si_addr < fault_end);
> +    if (fault_write) {
> +        mprotect((void *)page, page_size, PROT_READ | PROT_WRITE);
> +    } else {
> +        mprotect((void *)page, page_size, PROT_READ);
> +    }
> +    nr_segv++;
> +}
> +
> +/* Use noinline to make generated code easier to inspect */
> +static __attribute__((noinline))
> +uint8_t unit_load(uint8_t *mem, size_t nr, bool ff)
> +{
> +    size_t vl;
> +    vuint8m1_t vec, redvec, sum;
> +
> +    vl =3D __riscv_vsetvl_e8m1(nr);
> +    if (ff) {
> +        vec =3D __riscv_vle8ff_v_u8m1(mem, &vl, vl);
> +    } else {
> +        vec =3D __riscv_vle8_v_u8m1(mem, vl);
> +    }
> +    redvec =3D __riscv_vmv_v_x_u8m1(0, vl);
> +    sum =3D __riscv_vredsum_vs_u8m1_u8m1(vec, redvec, vl);
> +    return __riscv_vmv_x_s_u8m1_u8(sum);
> +}
> +
> +static __attribute__((noinline))
> +uint8_t seg2_load(uint8_t *mem, size_t nr, bool ff)
> +{
> +    size_t vl;
> +    vuint8m1x2_t segvec;
> +    vuint8m1_t vec, redvec, sum;
> +
> +    vl =3D __riscv_vsetvl_e8m1(nr);
> +    if (ff) {
> +        segvec =3D __riscv_vlseg2e8ff_v_u8m1x2(mem, &vl, vl);
> +    } else {
> +        segvec =3D __riscv_vlseg2e8_v_u8m1x2(mem, vl);
> +    }
> +    vec =3D __riscv_vadd_vv_u8m1(__riscv_vget_v_u8m1x2_u8m1(segvec, 0),
> +                   __riscv_vget_v_u8m1x2_u8m1(segvec, 1), vl);
> +    redvec =3D __riscv_vmv_v_x_u8m1(0, vl);
> +    sum =3D __riscv_vredsum_vs_u8m1_u8m1(vec, redvec, vl);
> +    return __riscv_vmv_x_s_u8m1_u8(sum);
> +}
> +
> +static __attribute__((noinline))
> +uint8_t strided_load(uint8_t *mem, size_t nr, size_t stride)
> +{
> +    size_t vl;
> +    vuint8m1_t vec, redvec, sum;
> +
> +    vl =3D __riscv_vsetvl_e8m1(nr);
> +    vec =3D __riscv_vlse8_v_u8m1(mem, stride, vl);
> +    redvec =3D __riscv_vmv_v_x_u8m1(0, vl);
> +    sum =3D __riscv_vredsum_vs_u8m1_u8m1(vec, redvec, vl);
> +    return __riscv_vmv_x_s_u8m1_u8(sum);
> +}
> +
> +static __attribute__((noinline))
> +uint8_t indexed_load(uint8_t *mem, size_t nr, uint32_t *indices)
> +{
> +    size_t vl;
> +    vuint32m4_t idx;
> +    vuint8m1_t vec, redvec, sum;
> +
> +    vl =3D __riscv_vsetvl_e8m1(nr);
> +    idx =3D __riscv_vle32_v_u32m4(indices, vl);
> +    vec =3D __riscv_vloxei32_v_u8m1(mem, idx, vl);
> +    redvec =3D __riscv_vmv_v_x_u8m1(0, vl);
> +    sum =3D __riscv_vredsum_vs_u8m1_u8m1(vec, redvec, vl);
> +    return __riscv_vmv_x_s_u8m1_u8(sum);
> +}
> +
> +/* New store functions */
> +static __attribute__((noinline))
> +void unit_store(uint8_t *mem, size_t nr, vuint8m1_t vec)
> +{
> +    size_t vl;
> +
> +    vl =3D __riscv_vsetvl_e8m1(nr);
> +    __riscv_vse8_v_u8m1(mem, vec, vl);
> +}
> +
> +static __attribute__((noinline))
> +void seg2_store(uint8_t *mem, size_t nr, vuint8m1x2_t segvec)
> +{
> +    size_t vl;
> +
> +    vl =3D __riscv_vsetvl_e8m1(nr);
> +    __riscv_vsseg2e8_v_u8m1x2(mem, segvec, vl);
> +}
> +
> +static __attribute__((noinline))
> +void strided_store(uint8_t *mem, size_t nr, size_t stride, vuint8m1_t ve=
c)
> +{
> +    size_t vl;
> +
> +    vl =3D __riscv_vsetvl_e8m1(nr);
> +    __riscv_vsse8_v_u8m1(mem, stride, vec, vl);
> +}
> +
> +static __attribute__((noinline))
> +void indexed_store(uint8_t *mem, size_t nr, uint32_t *indices, vuint8m1_=
t vec)
> +{
> +    size_t vl;
> +    vuint32m4_t idx;
> +
> +    vl =3D __riscv_vsetvl_e8m1(nr);
> +    idx =3D __riscv_vle32_v_u32m4(indices, vl);
> +    __riscv_vsoxei32_v_u8m1(mem, idx, vec, vl);
> +}
> +
> +/* Use e8 elements, 128-bit vectors */
> +#define NR_ELEMS 16
> +
> +static int run_interrupted_v_tests(void)
> +{
> +    struct sigaction act =3D { 0 };
> +    uint8_t *mem;
> +    uint32_t indices[NR_ELEMS];
> +    int i;
> +
> +    page_size =3D sysconf(_SC_PAGESIZE);
> +
> +    act.sa_flags =3D SA_SIGINFO;
> +    act.sa_sigaction =3D &SEGV_handler;
> +    if (sigaction(SIGSEGV, &act, NULL) =3D=3D -1) {
> +        perror("sigaction");
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    mem =3D mmap(NULL, NR_ELEMS * page_size, PROT_READ | PROT_WRITE,
> +               MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +    assert(mem !=3D MAP_FAILED);
> +    madvise(mem, NR_ELEMS * page_size, MADV_NOHUGEPAGE);
> +
> +    /*** Load tests ***/
> +    fault_write =3D false;
> +
> +    /* Unit-stride tests load memory crossing a page boundary */
> +    memset(mem, 0, NR_ELEMS * page_size);
> +    for (i =3D 0; i < NR_ELEMS; i++) {
> +        mem[page_size - NR_ELEMS + i] =3D 3;
> +    }
> +    for (i =3D 0; i < NR_ELEMS; i++) {
> +        mem[page_size + i] =3D 5;
> +    }
> +
> +    nr_segv =3D 0;
> +    fault_start =3D (unsigned long)&mem[page_size - (NR_ELEMS / 2)];
> +    fault_end =3D fault_start + NR_ELEMS;
> +    mprotect(mem, page_size * 2, PROT_NONE);
> +    assert(unit_load(&mem[page_size - (NR_ELEMS / 2)], NR_ELEMS, false)
> +                    =3D=3D 8 * NR_ELEMS / 2);
> +    assert(nr_segv =3D=3D 2);
> +
> +    nr_segv =3D 0;
> +    fault_start =3D (unsigned long)&mem[page_size - NR_ELEMS];
> +    fault_end =3D fault_start + NR_ELEMS * 2;
> +    mprotect(mem, page_size * 2, PROT_NONE);
> +    assert(seg2_load(&mem[page_size - NR_ELEMS], NR_ELEMS, false)
> +                    =3D=3D 8 * NR_ELEMS);
> +    assert(nr_segv =3D=3D 2);
> +
> +    nr_segv =3D 0;
> +    fault_start =3D (unsigned long)&mem[page_size - (NR_ELEMS / 2)];
> +    fault_end =3D fault_start + (NR_ELEMS / 2);
> +    mprotect(mem, page_size * 2, PROT_NONE);
> +    assert(unit_load(&mem[page_size - (NR_ELEMS / 2)], NR_ELEMS, true)
> +                    =3D=3D 3 * NR_ELEMS / 2);
> +    assert(nr_segv =3D=3D 1); /* fault-first does not fault the second p=
age */
> +
> +    nr_segv =3D 0;
> +    fault_start =3D (unsigned long)&mem[page_size - NR_ELEMS];
> +    fault_end =3D fault_start + NR_ELEMS;
> +    mprotect(mem, page_size * 2, PROT_NONE);
> +    assert(seg2_load(&mem[page_size - NR_ELEMS], NR_ELEMS * 2, true)
> +                    =3D=3D 3 * NR_ELEMS);
> +    assert(nr_segv =3D=3D 1); /* fault-first does not fault the second p=
age */
> +
> +    /* Following tests load one element from first byte of each page */
> +    mprotect(mem, page_size * 2, PROT_READ | PROT_WRITE);
> +    memset(mem, 0, NR_ELEMS * page_size);
> +    for (i =3D 0; i < NR_ELEMS; i++) {
> +        mem[i * page_size] =3D 3;
> +        indices[i] =3D i * page_size;
> +    }
> +
> +    nr_segv =3D 0;
> +    fault_start =3D (unsigned long)mem;
> +    fault_end =3D fault_start + NR_ELEMS * page_size;
> +    mprotect(mem, NR_ELEMS * page_size, PROT_NONE);
> +    assert(strided_load(mem, NR_ELEMS, page_size) =3D=3D 3 * NR_ELEMS);
> +    assert(nr_segv =3D=3D NR_ELEMS);
> +
> +    nr_segv =3D 0;
> +    fault_start =3D (unsigned long)mem;
> +    fault_end =3D fault_start + NR_ELEMS * page_size;
> +    mprotect(mem, NR_ELEMS * page_size, PROT_NONE);
> +    assert(indexed_load(mem, NR_ELEMS, indices) =3D=3D 3 * NR_ELEMS);
> +    assert(nr_segv =3D=3D NR_ELEMS);
> +
> +    /*** Store tests ***/
> +    fault_write =3D true;
> +
> +    uint8_t store_data[NR_ELEMS];
> +    uint8_t store_data_seg0[NR_ELEMS];
> +    uint8_t store_data_seg1[NR_ELEMS];
> +    vuint8m1_t vec;
> +    vuint8m1x2_t segvec;
> +    size_t vl =3D __riscv_vsetvl_e8m1(NR_ELEMS);
> +
> +    /* Create some data to store */
> +    for (i =3D 0; i < NR_ELEMS; i++) {
> +        store_data[i] =3D i * 3;
> +        store_data_seg0[i] =3D i * 5;
> +        store_data_seg1[i] =3D i * 7;
> +    }
> +    vec =3D __riscv_vle8_v_u8m1(store_data, vl);
> +    segvec =3D __riscv_vcreate_v_u8m1x2(
> +        __riscv_vle8_v_u8m1(store_data_seg0, vl),
> +        __riscv_vle8_v_u8m1(store_data_seg1, vl));
> +
> +    /* Unit-stride store test crossing a page boundary */
> +    mprotect(mem, page_size * 2, PROT_READ | PROT_WRITE);
> +    memset(mem, 0, page_size * 2);
> +    nr_segv =3D 0;
> +    fault_start =3D (unsigned long)&mem[page_size - (NR_ELEMS / 2)];
> +    fault_end =3D fault_start + NR_ELEMS;
> +    mprotect(mem, page_size * 2, PROT_NONE);
> +    unit_store(&mem[page_size - (NR_ELEMS / 2)], NR_ELEMS, vec);
> +    assert(nr_segv =3D=3D 2);
> +    for (i =3D 0; i < NR_ELEMS; i++) {
> +        assert(mem[page_size - (NR_ELEMS / 2) + i] =3D=3D store_data[i])=
;
> +    }
> +
> +    /* Segmented store test crossing a page boundary */
> +    mprotect(mem, page_size * 2, PROT_READ | PROT_WRITE);
> +    memset(mem, 0, page_size * 2);
> +    nr_segv =3D 0;
> +    fault_start =3D (unsigned long)&mem[page_size - NR_ELEMS];
> +    fault_end =3D fault_start + NR_ELEMS * 2;
> +    mprotect(mem, page_size * 2, PROT_NONE);
> +    seg2_store(&mem[page_size - NR_ELEMS], NR_ELEMS, segvec);
> +    assert(nr_segv =3D=3D 2);
> +    for (i =3D 0; i < NR_ELEMS; i++) {
> +        assert(mem[page_size - NR_ELEMS + i * 2] =3D=3D store_data_seg0[=
i]);
> +        assert(mem[page_size - NR_ELEMS + i * 2 + 1] =3D=3D store_data_s=
eg1[i]);
> +    }
> +
> +    /* Strided store test to one element on each page */
> +    mprotect(mem, NR_ELEMS * page_size, PROT_READ | PROT_WRITE);
> +    memset(mem, 0, NR_ELEMS * page_size);
> +    nr_segv =3D 0;
> +    fault_start =3D (unsigned long)mem;
> +    fault_end =3D fault_start + NR_ELEMS * page_size;
> +    mprotect(mem, NR_ELEMS * page_size, PROT_NONE);
> +    strided_store(mem, NR_ELEMS, page_size, vec);
> +    assert(nr_segv =3D=3D NR_ELEMS);
> +    for (i =3D 0; i < NR_ELEMS; i++) {
> +        assert(mem[i * page_size] =3D=3D store_data[i]);
> +    }
> +
> +    /* Indexed store test to one element on each page */
> +    mprotect(mem, NR_ELEMS * page_size, PROT_READ | PROT_WRITE);
> +    memset(mem, 0, NR_ELEMS * page_size);
> +    nr_segv =3D 0;
> +    fault_start =3D (unsigned long)mem;
> +    fault_end =3D fault_start + NR_ELEMS * page_size;
> +    mprotect(mem, NR_ELEMS * page_size, PROT_NONE);
> +    indexed_store(mem, NR_ELEMS, indices, vec);
> +    assert(nr_segv =3D=3D NR_ELEMS);
> +    for (i =3D 0; i < NR_ELEMS; i++) {
> +        assert(mem[indices[i]] =3D=3D store_data[i]);
> +    }
> +
> +    munmap(mem, NR_ELEMS * page_size);
> +
> +    return 0;
> +}
> +
> +int main(void)
> +{
> +    return run_interrupted_v_tests();
> +}
> --
> 2.51.0
>
>

