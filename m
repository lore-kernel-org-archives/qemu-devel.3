Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43A8C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 10:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3ByP-0000LB-02; Fri, 11 Apr 2025 06:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u3ByN-0000Kc-9E
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:50:59 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u3ByK-00010c-9X
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:50:59 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43d04ea9d9aso8744385e9.3
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 03:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744368654; x=1744973454; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Iq9jjUjxQMvcNPRONFjv6Xn7v+b6NtpERTGuJsmABkI=;
 b=Ew9d8iLNEkHJCktnaFNiqmSXpA3pOlmFJfH1qKu37BCnJxSpOzWPUzYlWW0OKLNFiG
 rcgeOJ+uB9BeZnjURX0ysd5SUWYBxQ6eNF0uen8moZDCUvXB0HgjKYH+iAopR7ynTaBn
 y+l/u9v0rR7pH11P6M9zNKJDL0KBsVoZgswU4kvWRrBtvTBQYMSaBvmGDIrDK7gyxOL/
 Ks/xMHXInnyg/fit1QKN716fNCBkXxU3GsHhUdVmEd/eo4liWp+NrtTg15VYVN/3X7KQ
 texUl43enc722tcCFrJ50iCZZRKjipFZwmY3TMTi8iplPwJGl2CJcx1+QmDveJ1Wm10O
 ehlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744368654; x=1744973454;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Iq9jjUjxQMvcNPRONFjv6Xn7v+b6NtpERTGuJsmABkI=;
 b=GaFUZLP2JUpACZvc5PmAc3eBicP9kndLsDJY66jMPXZ5x17eXmAk1uwgArpFTWEGMl
 iIEWJgujE9t24dfuB7PmxrFFLfq6wtmlPvSb5fuAJiw6Vx7oKH56JjtfiwmmeJ1lV0C3
 OK72F9h7VQ+Mdxl33oXSrX/tSfcNILn7K/XspPFQ30VTPNezN1Euk4vzG02OzixRGHW2
 t2vpMiajfVhghLL5qTuQ5nUvIFgfHaxqzQSTXXyUSmqBpFOOGxUulzJkYHAYJ6h3AQfZ
 cCj8LoxT07k1Pe+mP2CfWziqAe386AvjOhTNmUu4XDReyze7x90kHJpOxbdLIAqDAwmh
 WlAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU29Ty24TuUSA1VmmYWkF+hl18vM1N0bADaVK7uiNLNArqZ3SFTFsuetUHfh1GEVLmQNGEo72dQV+z4@nongnu.org
X-Gm-Message-State: AOJu0YxY7AytIUblhehGRGcugWg50wEFwN9X9zfGyT4axqFfB2WwekhW
 hL9MMxLXnXRFxLGTHAJ1MDJBrvNB1tn6pIZ6ONwHZzLGBqtddyjhhpJ5fO4iNd4=
X-Gm-Gg: ASbGnctWViO2hLLeY4Yvcoo13NCjyrlIJmJTIqcHwgF0ywbClRExtzrfMaZAfdH7coC
 XqdZMRDq311ZAQLvCZYZQOzwiTjsNx/WRjDYiSOyfcggNo8Vz8FxTqs3ZzC11XEZjjpeozqjedl
 +STC5LEFbBIUA42e4EdwHMZMWwBcq4K+TqRGX1uwk6AFQAbkcCdAlzMV5Ks+A1W6Kj52Av+Z3cm
 W74MfasEz1gFUhbp4fsRIRnG2yGDUsIKyqonsQaOvwssoQYSa0HCF8NwP2NyljfqSDPTN8PVYBk
 Mv4i0PR0mwbOQWxKXE/k1lIvmTl7LWpeWtpnKFeYSSS9inLllcvQASCpODskvliCbn9fkltSmVF
 d+gHCDAv+
X-Google-Smtp-Source: AGHT+IEUzs9XR5D4XrEtui0VIUsz9arF4D9KrXvZlIBODeRZ6oSGMKZn1EOxR1kNn5qyfs2yYmKQQA==
X-Received: by 2002:a05:600c:384b:b0:43c:f3e4:d6f6 with SMTP id
 5b1f17b1804b1-43f3a9b1564mr23993035e9.31.1744368654276; 
 Fri, 11 Apr 2025 03:50:54 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae977fc8sm1620631f8f.48.2025.04.11.03.50.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 03:50:53 -0700 (PDT)
Message-ID: <264d9113-16ce-4c05-a468-78e1f9921df6@linaro.org>
Date: Fri, 11 Apr 2025 12:50:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] tcg: Add a TCG backend for WebAssembly
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
References: <cover.1744032780.git.ktokunaga.mail@gmail.com>
 <24b5ff124d70043aff97dc30aa45f8a502676989.1744032780.git.ktokunaga.mail@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <24b5ff124d70043aff97dc30aa45f8a502676989.1744032780.git.ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Hi Kohei,

On 7/4/25 16:45, Kohei Tokunaga wrote:
> A TB consists of a wasmTBHeader followed by the data listed below. The
> wasmTBHeader contains pointers for each element:
> 
> - TCI code
> - Wasm code
> - Array of function indices imported into the Wasm instance
> - Counter tracking the number of TB executions
> - Pointer to the Wasm instance information
> 
> The Wasm backend (tcg/wasm32.c) and Wasm instances running on the same
> thread share information, such as CPUArchState, through a wasmContext
> structure. The Wasm backend defines tcg_qemu_tb_exec as a common entry point
> for TBs, similar to the TCI backend. tcg_qemu_tb_exec runs TBs on a forked
> TCI interpreter by default, while compiles and executes frequently executed
> TBs as Wasm.
> 
> The code generator (tcg/wasm32) receives TCG IR and generates both Wasm and
> TCI instructions. Since Wasm cannot directly jump to specific addresses,
> labels are implemented using Wasm control flow instructions. As shown in the
> pseudo-code below, a TB wraps instructions in a large loop, where codes are
> placed within if blocks separated by labels. Branching is handled by
> breaking from the current block and entering the target block.
> 
> loop
>    if
>      ... code after label1
>    end
>    if
>      ... code after label2
>    end
>    ...
> end
> 
> Additionally, the Wasm backend differs from other backends in several ways:
> 
> - goto_tb and goto_ptr return control to tcg_qemu_tb_exec which runs the
>    target TB
> - Helper function pointers are stored in an array in TB and imported into
>    the Wasm instance on execution
> - Wasm TBs lack prologue and epilogue. TBs are executed via tcg_qemu_tb_exec
> 
> Browsers cause out of memory error if too many Wasm instances are
> created. To prevent this, the Wasm backend tracks active instances using an
> array. When instantiating a new instance risks exceeding the limit, the
> backend removes older instances to avoid browser errors. These removed
> instances are re-instantiated when needed.
> 
> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> ---
>   include/accel/tcg/getpc.h        |    2 +-
>   include/tcg/helper-info.h        |    4 +-
>   include/tcg/tcg.h                |    2 +-
>   meson.build                      |    2 +
>   tcg/meson.build                  |    5 +
>   tcg/tcg.c                        |   26 +-
>   tcg/wasm32.c                     | 1260 +++++++++
>   tcg/wasm32.h                     |   39 +
>   tcg/wasm32/tcg-target-con-set.h  |   18 +
>   tcg/wasm32/tcg-target-con-str.h  |    8 +
>   tcg/wasm32/tcg-target-has.h      |  102 +
>   tcg/wasm32/tcg-target-mo.h       |   12 +
>   tcg/wasm32/tcg-target-opc.h.inc  |    4 +
>   tcg/wasm32/tcg-target-reg-bits.h |   12 +
>   tcg/wasm32/tcg-target.c.inc      | 4484 ++++++++++++++++++++++++++++++
>   tcg/wasm32/tcg-target.h          |   65 +
>   16 files changed, 6035 insertions(+), 10 deletions(-)
>   create mode 100644 tcg/wasm32.c
>   create mode 100644 tcg/wasm32.h
>   create mode 100644 tcg/wasm32/tcg-target-con-set.h
>   create mode 100644 tcg/wasm32/tcg-target-con-str.h
>   create mode 100644 tcg/wasm32/tcg-target-has.h
>   create mode 100644 tcg/wasm32/tcg-target-mo.h
>   create mode 100644 tcg/wasm32/tcg-target-opc.h.inc
>   create mode 100644 tcg/wasm32/tcg-target-reg-bits.h
>   create mode 100644 tcg/wasm32/tcg-target.c.inc
>   create mode 100644 tcg/wasm32/tcg-target.h


> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index dfd48b8264..154a4dafa7 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -136,6 +136,10 @@ static void tcg_out_goto_tb(TCGContext *s, int which);
>   static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                          const TCGArg args[TCG_MAX_OP_ARGS],
>                          const int const_args[TCG_MAX_OP_ARGS]);
> +#if defined(EMSCRIPTEN)

Maybe we can let this independently of EMSCRIPTEN, to reduce #ifdef'ry.

> +static void tcg_out_label_cb(TCGContext *s, TCGLabel *l);
> +static int tcg_out_tb_end(TCGContext *s);
> +#endif
>   #if TCG_TARGET_MAYBE_vec
>   static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
>                               TCGReg dst, TCGReg src);
> @@ -251,7 +255,7 @@ TCGv_env tcg_env;
>   const void *tcg_code_gen_epilogue;
>   uintptr_t tcg_splitwx_diff;
>   
> -#ifndef CONFIG_TCG_INTERPRETER
> +#if !defined(CONFIG_TCG_INTERPRETER) && !defined(EMSCRIPTEN)

s/&&/||/ otherwise breaks TCI? (various cases)

>   tcg_prologue_fn *tcg_qemu_tb_exec;
>   #endif
>   
> @@ -358,6 +362,9 @@ static void tcg_out_label(TCGContext *s, TCGLabel *l)
>       tcg_debug_assert(!l->has_value);
>       l->has_value = 1;
>       l->u.value_ptr = tcg_splitwx_to_rx(s->code_ptr);
> +#if defined(EMSCRIPTEN)
> +    tcg_out_label_cb(s, l);
> +#endif
>   }
>   
>   TCGLabel *gen_new_label(void)
> @@ -1139,7 +1146,7 @@ static TCGHelperInfo info_helper_st128_mmu = {
>                 | dh_typemask(ptr, 5)  /* uintptr_t ra */
>   };
>   
> -#ifdef CONFIG_TCG_INTERPRETER
> +#if defined(CONFIG_TCG_INTERPRETER) || defined(EMSCRIPTEN)
>   static ffi_type *typecode_to_ffi(int argmask)
>   {
>       /*
> @@ -1593,7 +1600,7 @@ void tcg_prologue_init(void)
>       s->code_buf = s->code_gen_ptr;
>       s->data_gen_ptr = NULL;
>   
> -#ifndef CONFIG_TCG_INTERPRETER
> +#if !defined(CONFIG_TCG_INTERPRETER) && !defined(EMSCRIPTEN)
>       tcg_qemu_tb_exec = (tcg_prologue_fn *)tcg_splitwx_to_rx(s->code_ptr);
>   #endif
>   
> @@ -1649,11 +1656,11 @@ void tcg_prologue_init(void)
>           }
>       }
>   
> -#ifndef CONFIG_TCG_INTERPRETER
> +#if !defined(CONFIG_TCG_INTERPRETER) && !defined(EMSCRIPTEN)
>       /*
>        * Assert that goto_ptr is implemented completely, setting an epilogue.
> -     * For tci, we use NULL as the signal to return from the interpreter,
> -     * so skip this check.
> +     * For tci and wasm backend, we use NULL as the signal to return from the
> +     * interpreter, so skip this check.
>        */
>       tcg_debug_assert(tcg_code_gen_epilogue != NULL);
>   #endif
> @@ -6505,6 +6512,13 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
>                           tcg_ptr_byte_diff(s->code_ptr, s->code_buf));
>   #endif
>   
> +#if defined(EMSCRIPTEN)
> +    i = tcg_out_tb_end(s);
> +    if (i < 0) {
> +        return i;
> +    }
> +#endif
> +
>       return tcg_current_code_size(s);
>   }

Out of curiosity, have you tried to run a big-endian guest?


