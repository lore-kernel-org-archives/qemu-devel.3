Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5023ECA1014
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 20:15:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uttsy-0001AL-De; Wed, 03 Sep 2025 16:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uttsv-00015w-6x
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 16:15:13 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uttss-0003M3-DK
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 16:15:12 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-248c7f955a2so3457815ad.2
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 13:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1756930508; x=1757535308; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5T08h2g8sTvU4H0Y5og+g9NqTyFUMQh4K8hrNHa53qg=;
 b=Bsu2QSgGGsLr+ojLIij8Z0x8y+Rc1CdDQ+nccwjJRp8+gR16u6KJ7LHa+g5JKorn5E
 ZFv2cLvcmL3icS4YvOESAWl50DqlCJ/PeA2ivq18/Eoq5GssIJg57UUZKZEVsaGS/kYG
 h67Zg8zD+3o6RdsgVm183ARro32/wF2jGCSWokIM8B0eW0XavB2/TdaJy9a3b78zE9eg
 D7KUoVo3nH4ozRpIOLGmF2/cz2JyDSFVLgtSUqUKi+Aqe2frEKTWR1B23RkGvprGYA29
 Qet4i9luEoq2m3JKORI8stn2b8YntcCXcPPmwhcenGxRlKVLz40okAcIj2fYG4ZQrUGQ
 Q61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756930508; x=1757535308;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5T08h2g8sTvU4H0Y5og+g9NqTyFUMQh4K8hrNHa53qg=;
 b=Niiz3EkEWKm3PDYPI37fhEipIV5yGCSsXNR6yXJapXklYvleWgBcW3YECwGX2fsjqp
 /RcHt8LtQeWce7aFIpzaIVgKShN5Ekc4MpeWFaPxirgcFqoTqlGzipSHSrMojsRFW93m
 L6fGztSuYonKfZ8WPE4Jz7YK5owMKGvk2mwV2e84sY6ddsxMcpCHlLlWCaTGKZ+O5MLv
 dhyKxLolszWI1dbV1lEuqYF6bLKgPhBiZISUOCOTt46VfOB8QvDFxJKwYm4FDS/+gM+6
 QwNCpb6Xa7mN5EEsL1Xp2EQkrjcDeyTs8LzDpZUWazhmnjz4Z7SYLR84S8L2d16zu9+6
 3esA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWU0O97YxWUuzLWQin968EvQ2URkmxBDq9Au03CCJmwxn3eUbzms/LW0GwK9LAqxgxAA4uWpbye+uQM@nongnu.org
X-Gm-Message-State: AOJu0Yxf6T4fI5hhflrYyb/HxV8rBFen3JXG7vUnfayvaGWIeR459ZZo
 vUWnmV85T62qMxTuDNVMl3JMvPaIfdptCR25veFnEXY9Bh5Ghdn0S4dZde7tXyLuv/Q=
X-Gm-Gg: ASbGncvERfJVnTj/Z3G2yYWDi7YqOga1rxDEHJVuF1IkB5xUgbg8Cv0GTuh0Hfkopn3
 AOhNpBikX30FamP6VGAHCj1cFc7A11irLPVsf++3g0CPMqJk89BwBqGQvIo0eC7v8FECBHB/O7q
 RAsIKB5dcZeTtBY50YJyDYpCN2CW+EmpRYPsD8y4sZIhxjLRFTy8Teeh/XJbiyjA0xSvDWjlfiF
 2GDESK4VSHuO0Wax5nFDdxKI0QEuZBvkB93rZsKU2A3FdJJAffUysNOAVqjU3133OWudLAl0ZFx
 BdFvEXqFN/tkTg8ksooAQqwshlLC9iv4B0aKO8Fy8+GAb/U33bNvIarWUuR5umwfwxNJLQSG2h+
 tU2S1L5WswGcvmVOFmVOZaSlRfNsH7FYVx817
X-Google-Smtp-Source: AGHT+IFDQbePRAlyK9jhmu5N1movr9VadUmzV2lr68YqHWBA3jggMK7nWnMBxGPewNugqWwJbW13gA==
X-Received: by 2002:a17:903:41cf:b0:235:e8da:8d1 with SMTP id
 d9443c01a7336-249448f9c03mr198796685ad.8.1756930508096; 
 Wed, 03 Sep 2025 13:15:08 -0700 (PDT)
Received: from [192.168.68.110] ([187.10.187.251])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24af8ab7e7bsm69528855ad.138.2025.09.03.13.15.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 13:15:07 -0700 (PDT)
Message-ID: <6f062bf7-e2a9-40bf-a025-418e45c0a98a@ventanamicro.com>
Date: Wed, 3 Sep 2025 17:15:04 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] tests/tcg/riscv64: Add vector state to signal test
To: Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-devel@nongnu.org
References: <20250903042510.279954-1-npiggin@gmail.com>
 <20250903042510.279954-5-npiggin@gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20250903042510.279954-5-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 9/3/25 1:25 AM, Nicholas Piggin wrote:
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   tests/tcg/riscv64/test-signal-handling.c | 215 ++++++++++++++++++++++-
>   1 file changed, 209 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/tcg/riscv64/test-signal-handling.c b/tests/tcg/riscv64/test-signal-handling.c
> index e9c0170c74..29b2fe169d 100644
> --- a/tests/tcg/riscv64/test-signal-handling.c
> +++ b/tests/tcg/riscv64/test-signal-handling.c
> @@ -19,9 +19,16 @@
>   #include <execinfo.h>
>   #include <unistd.h>
>   #include <assert.h>
> +#include <sys/auxv.h>
> +#include <elf.h>
>   #include <sys/mman.h>
>   #include <ucontext.h>
>   #include <asm/sigcontext.h>
> +#include "riscv_vector.h"


As I said in a review in the "[PATCH 0/3] target/riscv: corner case fixes" series,
this header will break 'make check-tcg'. We need extra changes in the Docker image
to recognize this header.


Thanks,

Daniel

> +
> +#ifndef COMPAT_HWCAP_ISA_V
> +#define COMPAT_HWCAP_ISA_V (1 << ('V' - 'A'))
> +#endif
>   
>   /*
>    * This horrible hack seems to be required when including
> @@ -41,6 +48,10 @@ static uint64_t *signal_gvalues;
>   static double *initial_fvalues;
>   static double *final_fvalues;
>   static double *signal_fvalues;
> +static size_t vlenb;
> +static uint8_t *initial_vvalues;
> +static uint8_t *final_vvalues;
> +static uint8_t *signal_vvalues;
>   
>   extern unsigned long unimp_addr[];
>   
> @@ -64,6 +75,8 @@ static void ILL_handler(int signo, siginfo_t *info, void *context)
>   {
>       ucontext_t *uc = context;
>       struct sigcontext *sc = (struct sigcontext *)&uc->uc_mcontext;
> +    struct __riscv_ctx_hdr *sc_ext = &sc->sc_extdesc.hdr;
> +    bool found_v = false;
>   
>       got_signal = true;
>   
> @@ -82,12 +95,47 @@ static void ILL_handler(int signo, siginfo_t *info, void *context)
>       }
>       /* Test sc->sc_fpregs.d.fcsr ? */
>   
> +    assert(sc->sc_extdesc.reserved == 0);
> +    while (sc_ext->magic != END_MAGIC) {
> +        assert(sc_ext->size != 0);
> +
> +        if (sc_ext->magic == RISCV_V_MAGIC) {
> +            struct __sc_riscv_v_state *sc_v_state = (struct __sc_riscv_v_state *)(sc_ext + 1);
> +            struct __riscv_v_ext_state *v_state = &sc_v_state->v_state;
> +
> +            found_v = true;
> +
> +            assert(getauxval(AT_HWCAP) & COMPAT_HWCAP_ISA_V);
> +
> +            assert(v_state->vlenb == vlenb);
> +            assert(v_state->vtype == 0xc0); /* vma, vta */
> +            assert(v_state->vl == vlenb);
> +            assert(v_state->vstart == 0);
> +            assert(v_state->vcsr == 0);
> +
> +            uint64_t *vregs = v_state->datap;
> +            for (int i = 0; i < 32; i++) {
> +                for (int j = 0; j < vlenb; j += 8) {
> +                    size_t idx = (i * vlenb + j) / 8;
> +                    ((uint64_t *)signal_vvalues)[idx] = vregs[idx];
> +                }
> +            }
> +        }
> +
> +        sc_ext = (void *)sc_ext + sc_ext->size;
> +    }
> +
> +    assert(sc_ext->size == 0);
> +    if (getauxval(AT_HWCAP) & COMPAT_HWCAP_ISA_V) {
> +        assert(found_v);
> +    }
> +
>       sc->sc_regs.pc += 4;
>   }
>   
>   static void init_test(void)
>   {
> -    int i;
> +    int i, j;
>   
>       callchain_root = find_callchain_root();
>   
> @@ -107,6 +155,19 @@ static void init_test(void)
>       memset(final_fvalues, 0, 8 * 32);
>       signal_fvalues = malloc(8 * 32);
>       memset(signal_fvalues, 0, 8 * 32);
> +
> +    vlenb = __riscv_vlenb();
> +    initial_vvalues = malloc(vlenb * 32);
> +    memset(initial_vvalues, 0, vlenb * 32);
> +    for (i = 0; i < 32 ; i++) {
> +        for (j = 0; j < vlenb; j++) {
> +            initial_vvalues[i * vlenb + j] = i * vlenb + j;
> +        }
> +    }
> +    final_vvalues = malloc(vlenb * 32);
> +    memset(final_vvalues, 0, vlenb * 32);
> +    signal_vvalues = malloc(vlenb * 32);
> +    memset(signal_vvalues, 0, vlenb * 32);
>   }
>   
>   static void run_test(void)
> @@ -179,6 +240,72 @@ static void run_test(void)
>   "    fld    f29, 0xe8(t0)            \n"
>   "    fld    f30, 0xf0(t0)            \n"
>   "    fld    f31, 0xf8(t0)            \n"
> +    /* Load initial values into vector registers */
> +"    mv    t0, %[initial_vvalues]    \n"
> +"    vsetvli x0,%[vlenb],e8,m1,ta,ma \n"
> +"    vle8.v    v0, (t0)              \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vle8.v    v1, (t0)              \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vle8.v    v2, (t0)              \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vle8.v    v3, (t0)              \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vle8.v    v4, (t0)              \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vle8.v    v5, (t0)              \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vle8.v    v6, (t0)              \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vle8.v    v7, (t0)              \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vle8.v    v8, (t0)              \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vle8.v    v9, (t0)              \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vle8.v    v10, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vle8.v    v11, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vle8.v    v12, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vle8.v    v13, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vle8.v    v14, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vle8.v    v15, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vle8.v    v16, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vle8.v    v17, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vle8.v    v18, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vle8.v    v19, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vle8.v    v20, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vle8.v    v21, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vle8.v    v22, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vle8.v    v23, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vle8.v    v24, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vle8.v    v25, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vle8.v    v26, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vle8.v    v27, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vle8.v    v28, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vle8.v    v29, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vle8.v    v30, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vle8.v    v31, (t0)             \n"
>       /* Trigger the SIGILL */
>   ".global unimp_addr                  \n"
>   "unimp_addr:                         \n"
> @@ -251,19 +378,93 @@ static void run_test(void)
>   "    fsd    f29, 0xe8(t0)            \n"
>   "    fsd    f30, 0xf0(t0)            \n"
>   "    fsd    f31, 0xf8(t0)            \n"
> +    /* Save final values from vector registers */
> +"    mv    t0, %[final_vvalues]      \n"
> +"    vse8.v    v0, (t0)              \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vse8.v    v1, (t0)              \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vse8.v    v2, (t0)              \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vse8.v    v3, (t0)              \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vse8.v    v4, (t0)              \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vse8.v    v5, (t0)              \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vse8.v    v6, (t0)              \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vse8.v    v7, (t0)              \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vse8.v    v8, (t0)              \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vse8.v    v9, (t0)              \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vse8.v    v10, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vse8.v    v11, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vse8.v    v12, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vse8.v    v13, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vse8.v    v14, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vse8.v    v15, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vse8.v    v16, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vse8.v    v17, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vse8.v    v18, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vse8.v    v19, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vse8.v    v20, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vse8.v    v21, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vse8.v    v22, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vse8.v    v23, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vse8.v    v24, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vse8.v    v25, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vse8.v    v26, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vse8.v    v27, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vse8.v    v28, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vse8.v    v29, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vse8.v    v30, (t0)             \n"
> +"    add    t0, t0, %[vlenb]         \n"
> +"    vse8.v    v31, (t0)             \n"
>       : "=m" (initial_gvalues),
>         "=m" (final_gvalues),
> -      "=m" (final_fvalues)
> -    : "m" (initial_fvalues),
> +      "=m" (final_fvalues),
> +      "=m" (final_vvalues)
> +    : [vlenb] "r" (vlenb),
> +      "m" (initial_fvalues),
> +      "m" (initial_vvalues),
>         [initial_gvalues] "r" (initial_gvalues),
>         [initial_fvalues] "r" (initial_fvalues),
> +      [initial_vvalues] "r" (initial_vvalues),
>         [final_gvalues] "r" (final_gvalues),
> -      [final_fvalues] "r" (final_fvalues)
> +      [final_fvalues] "r" (final_fvalues),
> +      [final_vvalues] "r" (final_vvalues)
>       : "t0",
>         "f0", "f1", "f2", "f3", "f4", "f5", "f6", "f7",
>         "f8", "f9", "f10", "f11", "f12", "f13", "f14", "f15",
>         "f16", "f17", "f18", "f19", "f20", "f21", "f22", "f23",
> -      "f24", "f25", "f26", "f27", "f28", "f29", "f30", "f31");
> +      "f24", "f25", "f26", "f27", "f28", "f29", "f30", "f31",
> +      "v0", "v1", "v2", "v3", "v4", "v5", "v6", "v7",
> +      "v8", "v9", "v10", "v11", "v12", "v13", "v14", "v15",
> +      "v16", "v17", "v18", "v19", "v20", "v21", "v22", "v23",
> +      "v24", "v25", "v26", "v27", "v28", "v29", "v30", "v31");
>   
>       assert(got_signal);
>   
> @@ -272,7 +473,7 @@ static void run_test(void)
>        * and is not a simple equality.
>        */
>       assert(initial_gvalues[4] == (unsigned long)initial_gvalues);
> -    assert(signal_gvalues[4] == (unsigned long)initial_fvalues);
> +    assert(signal_gvalues[4] == (unsigned long)initial_vvalues + 31 * vlenb);
>       assert(final_gvalues[4] == (unsigned long)final_gvalues);
>       initial_gvalues[4] = final_gvalues[4] = signal_gvalues[4] = 0;
>   
> @@ -284,6 +485,8 @@ static void run_test(void)
>       assert(!memcmp(initial_gvalues, signal_gvalues, 8 * 31));
>       assert(!memcmp(initial_fvalues, final_fvalues, 8 * 32));
>       assert(!memcmp(initial_fvalues, signal_fvalues, 8 * 32));
> +    assert(!memcmp(initial_vvalues, signal_vvalues, vlenb * 32));
> +    assert(!memcmp(initial_vvalues, final_vvalues, vlenb * 32));
>   }
>   
>   int main(void)


