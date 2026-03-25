Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA49FEA804
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 03:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5FFP-0003pa-OT; Tue, 24 Mar 2026 23:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5FFO-0003pE-G1
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 23:49:34 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5FFL-0004jK-4B
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 23:49:34 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b9382e59c0eso751656266b.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 20:49:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774410569; cv=none;
 d=google.com; s=arc-20240605;
 b=epghuProSR4zkoOOAZ1A7NR6Z0R+UCdZrHuwl1EplwHSHuvLanu9e+q/QavXqu35fT
 OQu5qDMXUuF4QihOR9IvBO2vBU73u3kG8tw8MMwwaZaX7SgCbYRKamwVqZ2rFeDOiusr
 V2Z7JNNl7egUHgjQ41TuxPEDPz3ivI0cwcX8g9rMA5RNlFmYGhHjny22zCfnd9nxNuA+
 8db0xrrqxEsrelzfgs4RPT0/8KkSVq82WAMRLIFqg9/wyz7FlfIuohsq4ecK7YrPntWv
 ZF7q5EXD2Z/ON0bcSD6KVn4GxYr0FbaZT+n/bhgdT5c1EGco++7/T1c6aQS41Imphdtc
 EI8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hfKCz2TviPVfxfe1HbQ2V+R1vBrKtI17XQbLz5tW72c=;
 fh=DLDnXFZbjLNeed5D/aqVrc4lZJWkEdKlL5/cir9ThjY=;
 b=WzBUyGSn8APx2vBGqfSPwEGGiwSagyeAiQ/jawkpaIY9FZJFe0BZVrUuN+Ivj8ErxY
 tzbjMUiDpNN5R9GBsozWh/5KqU4M8RuVLhl96qdluzh/PjWrnTjnpHoR5kw4NelFn6YL
 Su6WFE2EuNEJcnyeVWHmm2f1QPBqlyzZRz5OOW7hwNv4IQPnmpaXFvsydfl1A59gTM+a
 /X42Z6CA73mzabfSoH0UIit/LUVqStGbnCydOvsGKxI4ON8Gbfb84da6jf0nvyuzSYX6
 wwBu2FHs460FEtz/MD1A2Vb0iiyAv5Bu3VAyYHDWIJoV089mY2X8JY0kr0TLkm22VwUV
 rqBA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774410569; x=1775015369; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hfKCz2TviPVfxfe1HbQ2V+R1vBrKtI17XQbLz5tW72c=;
 b=L28+fOpxPBSvGbFL5IWfYd1c3PolSjuQ1PZZNbhzXQ4gx60RecumV5OUolY6Ky69de
 yXGrZwnW5X5BZHrzgj/HcSOo0sOV3P/mdD9WCLtvmOhReu6svZygYjX8FgsWSbLiX9lu
 UDiNlgYfDKdqyQJEYMdAhTzjo8H9m7ghIpnRWPEQn78ijCEz9Iwgq1DZ1nrs40sCv7t3
 x+jo1U2YTyV+b8eFwG7iJdgXiITj02fFwYwK84LAmXBYvjbUsmmuZXPC103CmzdrEXVX
 IsA5Rq4fwx74KsoErP8lzT0rXDBroAEc1HEy0wL+OY+hrXBuyLnk4pvpRY7uGC8Nu2eR
 92vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774410569; x=1775015369;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hfKCz2TviPVfxfe1HbQ2V+R1vBrKtI17XQbLz5tW72c=;
 b=JE4BjG2A4WZ3A0tEcl/3GCM9XH80RJSzm4b/a7veORu6HIqz1GNtv/sZ3w5V2w881v
 sUP4yOcuw7iCOxjWfNklMJ6edGFyTJYmZ32KgMgzz8mOt91YMOJbMMkR3bE2psAyhLWk
 Z/SR88+5WkrdbQUH4mndembImFry6Gf1vk8r8FghBd7N1aSB0ctU5h9PNY9C15P5VCwB
 ZFa2POl4tDMbOgHebsea3WcimWiO+FunvhbwEZVo3fQn4Hmrv5+udPemG+LFbGb1ucBQ
 JmiWo7LyxVXauZXCkMTxW+844SGprvLrW5YK5NyYXSSCeMvQu9mUjasNl8eJaLOMhYsP
 Lenw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFOHx0EWTeakc+e1bWx8uFO9OjcQ1VPSABBwn4uyKElBC7zegZvaJzBc8SReqgciACmZt3yiqekLqa@nongnu.org
X-Gm-Message-State: AOJu0YzcmFicy7bcwb3VvEm7TG1NyUHcZUOjKRc0Obhz5awLf/uXXoVI
 fb8mH/ZzVns8e3Aw8DjWeO3YhubU0wS0me105bD1VAfMqoqmtqVjoIfimxPt1tllZeUmFI+SWgz
 GZUATcB1y/j4YIMAXPR5d8go61InIlV8=
X-Gm-Gg: ATEYQzyHxaMUqBbfmBLJCCKTX4HQNjsL8aeBGjjYRAQh1A5LEeLvTMyH0LbRog2NgcM
 jfZdYNmmVZRdLuhK+MojY9/TXtH02Q0q8Mou+T2A4umF/EVrtUl5LT6yaerhA+JTZ6HVRNTaked
 SqrEjsNm9ihL5sofQhHYUpIZvBDkXzppLSS2TYJSY7tU/ChLHcRyShWw9StO7JavihIY82Akyoc
 lLLspArpyK+SGfHytXSnNnqKi9uupkageBI4774dag0foiBQBUyey7ldJ2KvhPVAskzoyDVJcOI
 D60Vgdih/27YqBm9QDG7MSqPERQyVkZaVqZ7mQ==
X-Received: by 2002:a17:906:c394:b0:b98:528b:8466 with SMTP id
 a640c23a62f3a-b9a58b533d9mr87889866b.55.1774410569206; Tue, 24 Mar 2026
 20:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260321141345.599105-1-npiggin@gmail.com>
 <20260321141345.599105-6-npiggin@gmail.com>
In-Reply-To: <20260321141345.599105-6-npiggin@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 25 Mar 2026 13:49:01 +1000
X-Gm-Features: AQROBzAJxPIXczF8macGC-DqOz4f9tDlm8r_WyLqQMnWJDX_XUWJSQrshEWTtW0
Message-ID: <CAKmqyKM6vmxKB2SZeqeyUhpn-TxYrRrpssvbhkzS+o8KyErEPQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] tests/tcg/riscv64: Add vector state to signal test
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
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x629.google.com
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
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/tcg/riscv64/Makefile.target        |   4 +-
>  tests/tcg/riscv64/test-signal-handling.c | 226 ++++++++++++++++++++++-
>  2 files changed, 222 insertions(+), 8 deletions(-)
>
> diff --git a/tests/tcg/riscv64/Makefile.target b/tests/tcg/riscv64/Makefi=
le.target
> index f318891396..86b6889a3d 100644
> --- a/tests/tcg/riscv64/Makefile.target
> +++ b/tests/tcg/riscv64/Makefile.target
> @@ -21,5 +21,5 @@ run-test-fcvtmod: QEMU_OPTS +=3D -cpu rv64,d=3Dtrue,zfa=
=3Dtrue
>
>  # Test signal handling.
>  TESTS +=3D test-signal-handling
> -test-signal-handling: CFLAGS +=3D -march=3Drv64gc
> -run-test-signal-handling: QEMU_OPTS +=3D -cpu rv64
> +test-signal-handling: CFLAGS +=3D -march=3Drv64gcv
> +run-test-signal-handling: QEMU_OPTS +=3D -cpu rv64,v=3Don
> diff --git a/tests/tcg/riscv64/test-signal-handling.c b/tests/tcg/riscv64=
/test-signal-handling.c
> index c202503382..b71fa6ee87 100644
> --- a/tests/tcg/riscv64/test-signal-handling.c
> +++ b/tests/tcg/riscv64/test-signal-handling.c
> @@ -19,10 +19,27 @@
>  #include <execinfo.h>
>  #include <unistd.h>
>  #include <assert.h>
> +#include <sys/auxv.h>
> +#include <elf.h>
>  #include <sys/mman.h>
>  #include <ucontext.h>
>  #include <asm/sigcontext.h>
>
> +#ifdef __riscv_v_intrinsic
> +#include <riscv_vector.h>
> +#else
> +static inline unsigned long __riscv_vlenb(void)
> +{
> +    unsigned long vlenb;
> +    __asm__ __volatile__ ("csrr %0, vlenb" : "=3Dr" (vlenb));
> +    return vlenb;
> +}
> +#endif
> +
> +#ifndef COMPAT_HWCAP_ISA_V
> +#define COMPAT_HWCAP_ISA_V (1 << ('V' - 'A'))
> +#endif
> +
>  /*
>   * This horrible hack seems to be required when including
>   * signal.h and asm/sigcontext.h, to prevent sigcontext
> @@ -41,6 +58,10 @@ static uint64_t *signal_gvalues;
>  static double *initial_fvalues;
>  static double *final_fvalues;
>  static double *signal_fvalues;
> +static size_t vlenb;
> +static uint8_t *initial_vvalues;
> +static uint8_t *final_vvalues;
> +static uint8_t *signal_vvalues;
>
>  extern unsigned long unimp_addr[];
>
> @@ -64,6 +85,8 @@ static void ILL_handler(int signo, siginfo_t *info, voi=
d *context)
>  {
>      ucontext_t *uc =3D context;
>      struct sigcontext *sc =3D (struct sigcontext *)&uc->uc_mcontext;
> +    struct __riscv_ctx_hdr *sc_ext =3D &sc->sc_extdesc.hdr;
> +    bool found_v =3D false;
>
>      got_signal =3D true;
>
> @@ -82,12 +105,48 @@ static void ILL_handler(int signo, siginfo_t *info, =
void *context)
>      }
>      /* Test sc->sc_fpregs.d.fcsr ? */
>
> +    assert(sc->sc_extdesc.reserved =3D=3D 0);
> +    while (sc_ext->magic !=3D END_MAGIC) {
> +        assert(sc_ext->size !=3D 0);
> +
> +        if (sc_ext->magic =3D=3D RISCV_V_MAGIC) {
> +            struct __sc_riscv_v_state *sc_v_state =3D
> +                        (struct __sc_riscv_v_state *)(sc_ext + 1);
> +            struct __riscv_v_ext_state *v_state =3D &sc_v_state->v_state=
;
> +
> +            found_v =3D true;
> +
> +            assert(getauxval(AT_HWCAP) & COMPAT_HWCAP_ISA_V);
> +
> +            assert(v_state->vlenb =3D=3D vlenb);
> +            assert(v_state->vtype =3D=3D 0xc0); /* vma, vta */
> +            assert(v_state->vl =3D=3D vlenb);
> +            assert(v_state->vstart =3D=3D 0);
> +            assert(v_state->vcsr =3D=3D 0);
> +
> +            uint64_t *vregs =3D v_state->datap;
> +            for (int i =3D 0; i < 32; i++) {
> +                for (int j =3D 0; j < vlenb; j +=3D 8) {
> +                    size_t idx =3D (i * vlenb + j) / 8;
> +                    ((uint64_t *)signal_vvalues)[idx] =3D vregs[idx];
> +                }
> +            }
> +        }
> +
> +        sc_ext =3D (void *)sc_ext + sc_ext->size;
> +    }
> +
> +    assert(sc_ext->size =3D=3D 0);
> +    if (getauxval(AT_HWCAP) & COMPAT_HWCAP_ISA_V) {
> +        assert(found_v);
> +    }
> +
>      sc->sc_regs.pc +=3D 4;
>  }
>
>  static void init_test(void)
>  {
> -    int i;
> +    int i, j;
>
>      callchain_root =3D find_callchain_root();
>
> @@ -107,6 +166,19 @@ static void init_test(void)
>      memset(final_fvalues, 0, 8 * 32);
>      signal_fvalues =3D malloc(8 * 32);
>      memset(signal_fvalues, 0, 8 * 32);
> +
> +    vlenb =3D __riscv_vlenb();
> +    initial_vvalues =3D malloc(vlenb * 32);
> +    memset(initial_vvalues, 0, vlenb * 32);
> +    for (i =3D 0; i < 32 ; i++) {
> +        for (j =3D 0; j < vlenb; j++) {
> +            initial_vvalues[i * vlenb + j] =3D i * vlenb + j;
> +        }
> +    }
> +    final_vvalues =3D malloc(vlenb * 32);
> +    memset(final_vvalues, 0, vlenb * 32);
> +    signal_vvalues =3D malloc(vlenb * 32);
> +    memset(signal_vvalues, 0, vlenb * 32);
>  }
>
>  static void run_test(void)
> @@ -179,6 +251,72 @@ static void run_test(void)
>      "fld    f29, 0xe8(t0)\n\t"
>      "fld    f30, 0xf0(t0)\n\t"
>      "fld    f31, 0xf8(t0)\n\t"
> +    /* Load initial values into vector registers */
> +    "mv    t0, %[initial_vvalues]\n\t"
> +    "vsetvli x0,%[vlenb],e8,m1,ta,ma\n\t"
> +    "vle8.v    v0, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vle8.v    v1, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vle8.v    v2, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vle8.v    v3, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vle8.v    v4, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vle8.v    v5, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vle8.v    v6, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vle8.v    v7, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vle8.v    v8, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vle8.v    v9, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vle8.v    v10, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vle8.v    v11, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vle8.v    v12, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vle8.v    v13, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vle8.v    v14, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vle8.v    v15, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vle8.v    v16, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vle8.v    v17, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vle8.v    v18, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vle8.v    v19, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vle8.v    v20, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vle8.v    v21, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vle8.v    v22, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vle8.v    v23, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vle8.v    v24, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vle8.v    v25, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vle8.v    v26, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vle8.v    v27, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vle8.v    v28, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vle8.v    v29, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vle8.v    v30, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vle8.v    v31, (t0)\n\t"
>      /* Trigger the SIGILL */
>  ".global unimp_addr\n\t"
>  "unimp_addr:\n\t"
> @@ -251,19 +389,93 @@ static void run_test(void)
>      "fsd    f29, 0xe8(t0)\n\t"
>      "fsd    f30, 0xf0(t0)\n\t"
>      "fsd    f31, 0xf8(t0)\n\t"
> +    /* Save final values from vector registers */
> +    "mv    t0, %[final_vvalues]\n\t"
> +    "vse8.v    v0, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vse8.v    v1, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vse8.v    v2, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vse8.v    v3, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vse8.v    v4, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vse8.v    v5, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vse8.v    v6, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vse8.v    v7, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vse8.v    v8, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vse8.v    v9, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vse8.v    v10, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vse8.v    v11, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vse8.v    v12, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vse8.v    v13, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vse8.v    v14, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vse8.v    v15, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vse8.v    v16, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vse8.v    v17, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vse8.v    v18, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vse8.v    v19, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vse8.v    v20, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vse8.v    v21, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vse8.v    v22, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vse8.v    v23, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vse8.v    v24, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vse8.v    v25, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vse8.v    v26, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vse8.v    v27, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vse8.v    v28, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vse8.v    v29, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vse8.v    v30, (t0)\n\t"
> +    "add    t0, t0, %[vlenb]\n\t"
> +    "vse8.v    v31, (t0)\n\t"
>      : "=3Dm" (initial_gvalues),
>        "=3Dm" (final_gvalues),
> -      "=3Dm" (final_fvalues)
> -    : "m" (initial_fvalues),
> +      "=3Dm" (final_fvalues),
> +      "=3Dm" (final_vvalues)
> +    : [vlenb] "r" (vlenb),
> +      "m" (initial_fvalues),
> +      "m" (initial_vvalues),
>        [initial_gvalues] "r" (initial_gvalues),
>        [initial_fvalues] "r" (initial_fvalues),
> +      [initial_vvalues] "r" (initial_vvalues),
>        [final_gvalues] "r" (final_gvalues),
> -      [final_fvalues] "r" (final_fvalues)
> +      [final_fvalues] "r" (final_fvalues),
> +      [final_vvalues] "r" (final_vvalues)
>      : "t0",
>        "f0", "f1", "f2", "f3", "f4", "f5", "f6", "f7",
>        "f8", "f9", "f10", "f11", "f12", "f13", "f14", "f15",
>        "f16", "f17", "f18", "f19", "f20", "f21", "f22", "f23",
> -      "f24", "f25", "f26", "f27", "f28", "f29", "f30", "f31");
> +      "f24", "f25", "f26", "f27", "f28", "f29", "f30", "f31",
> +      "v0", "v1", "v2", "v3", "v4", "v5", "v6", "v7",
> +      "v8", "v9", "v10", "v11", "v12", "v13", "v14", "v15",
> +      "v16", "v17", "v18", "v19", "v20", "v21", "v22", "v23",
> +      "v24", "v25", "v26", "v27", "v28", "v29", "v30", "v31");
>
>      assert(got_signal);
>
> @@ -272,7 +484,7 @@ static void run_test(void)
>       * and is not a simple equality.
>       */
>      assert(initial_gvalues[4] =3D=3D (unsigned long)initial_gvalues);
> -    assert(signal_gvalues[4] =3D=3D (unsigned long)initial_fvalues);
> +    assert(signal_gvalues[4] =3D=3D (unsigned long)initial_vvalues + 31 =
* vlenb);
>      assert(final_gvalues[4] =3D=3D (unsigned long)final_gvalues);
>      initial_gvalues[4] =3D final_gvalues[4] =3D signal_gvalues[4] =3D 0;
>
> @@ -284,6 +496,8 @@ static void run_test(void)
>      assert(!memcmp(initial_gvalues, signal_gvalues, 8 * 31));
>      assert(!memcmp(initial_fvalues, final_fvalues, 8 * 32));
>      assert(!memcmp(initial_fvalues, signal_fvalues, 8 * 32));
> +    assert(!memcmp(initial_vvalues, signal_vvalues, vlenb * 32));
> +    assert(!memcmp(initial_vvalues, final_vvalues, vlenb * 32));
>  }
>
>  int main(void)
> --
> 2.51.0
>
>

