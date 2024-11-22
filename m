Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6006E6918E
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 19:15:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEZ6t-0000G5-Fq; Fri, 22 Nov 2024 14:14:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEZ6s-0000Fw-6s
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 14:14:30 -0500
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEZ6p-0007NV-Qd
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 14:14:29 -0500
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-29680f21217so1636159fac.1
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 11:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732302866; x=1732907666; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FHOhEkNKxQOYAHzBo1RrbIBUKY/Jx69/gA6giSeOwwM=;
 b=qyPMF5BIAwpvlCC5NnJrmQa5mzv0Skl3iZHZUmTC63PKitiW4ht2WVfSH0Ewkr0I7g
 lb5PJNL8Kr27F0f1hDyy0KdMBZ4PrQcc4pbZUZhb5se7Q4UmdMKTp/2NIclNo+uONnBY
 O7eY/Z+GP7OGngSihSECze9G/G88fY6drs8xW1eYCC8WfCKnXB/5mWiCjVk8/DrL4hkb
 9I+UztJDtrERjkp8pgPBYxEvIHATgfM86Ezk/At4UfN1YoARJn5nbUEvNbXV3TN620ZX
 30y4/RdSvoqNhSVajqUn+eJfrOcb9D9VuO+/EtuHM9RDefi/WoiPOcnF+82og+ibeaa4
 JTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732302866; x=1732907666;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FHOhEkNKxQOYAHzBo1RrbIBUKY/Jx69/gA6giSeOwwM=;
 b=DnrYNCQ5zDXzXTwlEZ18oWsLCA63v96FJXctM26C4Zt/ja7EQ95JOHj1Z/BCTApNDm
 RJPswzEAKhjsoAEOwGyKUJHC5Y7OaqWKIThoeY7GDq0cyMBlWL+9KasHVTu2PKDDbsdi
 MTfOZ+vgkS5Z8V+I08hD5x9z8x2sX/cY4oPeWl3lvBhcfB1kqn0tIVCsSkFzrhQJ99+V
 XLk0yvgzqE/pzZkqtOukX9HswC6bxEephxHoOYpheF7PjIdK6OgX4TbSItVEMdGa7TDy
 JplSWWhYfIP63hURrmj15sSfZr4ERmMm90Hk4mxmO4wMbqVgh29Ny6cowJxI6rXMVGTC
 W/WA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrs7tOBCr37ignKUaLBqyUkNwkvv96Hwb6GP7Dr13BX8jAjNRfx3ByMrjXxdXG8VyLxroAJABqt9xV@nongnu.org
X-Gm-Message-State: AOJu0YyMBmXCEli/rfG8+8ibnLEfE6Ac/0PCZ36cf188TMY2EGCE8wMM
 7koscgc1C9KLWW7H1zxuxivKlmNXuKbT3a+W5nvvuOjHzBbBMTuZmIuUrJxoiwQ=
X-Gm-Gg: ASbGncujuMKCihH/QqJQSgjYVzZDh8fXMb2gSHwN1k3SfvIJoSLmbOGjZPyzk6LauBY
 kc1Z8of2HvG5is0oKiz5pcbkS7AouVtcv0pRqP/3w4Qxpom6/6BP9O0zzNfJ3cWMcRSC4FtsPrQ
 ddgIvQd9euLzBtihqQQEPToC+b0N5FZ9tCWYvJZGntJdPDdgLV3WEMFxmM89g8DrUZ2gt3ne9C4
 BpzaLFxvSRlj01rU8LQyWvlGkzhwUDqzD6QyqxhZFhr+6Z6Ja3Ez2xjN/U0E+JyoA==
X-Google-Smtp-Source: AGHT+IGJIcMmen8WAhJ0u2r1R1Zm/Ydku8oVlYfxAFiesuidSC31yL9jZ83CaUx+5/78aakHLyw8WA==
X-Received: by 2002:a05:6870:b251:b0:296:c543:46d5 with SMTP id
 586e51a60fabf-29720dd2a80mr4691837fac.27.1732302866126; 
 Fri, 22 Nov 2024 11:14:26 -0800 (PST)
Received: from [10.25.2.124] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2971d889d0esm755546fac.48.2024.11.22.11.14.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2024 11:14:25 -0800 (PST)
Message-ID: <fb4bba88-99a8-46f3-bc32-c7902d909fc6@linaro.org>
Date: Fri, 22 Nov 2024 13:14:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 06/43] tcg: Introduce tcg-global-mappings
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 philmd@linaro.org, alex.bennee@linaro.org
References: <20241121014947.18666-1-anjo@rev.ng>
 <20241121014947.18666-7-anjo@rev.ng>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241121014947.18666-7-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
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

On 11/20/24 19:49, Anton Johansson wrote:
> Adds a cpu_mapping struct to describe, in a declarative fashion, the
> mapping between fields in a struct, and a corresponding TCG global.  As
> such, tcg_global_mem_new() can be automatically called given an array of
> cpu_mappings.
> 
> This change is not limited to helper-to-tcg, but will be required in
> future commits to map between offsets into CPUArchState and TCGv
> globals in a target-agnostic way.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   include/tcg/tcg-global-mappings.h | 111 ++++++++++++++++++++++++++++++
>   tcg/meson.build                   |   1 +
>   tcg/tcg-global-mappings.c         |  61 ++++++++++++++++
>   3 files changed, 173 insertions(+)
>   create mode 100644 include/tcg/tcg-global-mappings.h
>   create mode 100644 tcg/tcg-global-mappings.c

Plausible.

In the most ideal of cases, helpers would *never* access TCG globals directly.  They would 
always be passed in/out via normal parameters.  I know this sometimes becomes impractical 
with multiple outputs.  But quite often we create TCG globals for e.g. control registers 
which ought not be TCG globals in the first place.  This can often allow helpers to be 
marked TCG_CALL_NO_RWG etc, which helps even out-of-line helpers.

How often is Hexagon referencing globals directly?


r~

> 
> diff --git a/include/tcg/tcg-global-mappings.h b/include/tcg/tcg-global-mappings.h
> new file mode 100644
> index 0000000000..736380fb20
> --- /dev/null
> +++ b/include/tcg/tcg-global-mappings.h
> @@ -0,0 +1,111 @@
> +/*
> + *  Copyright(c) 2024 rev.ng Labs Srl. All Rights Reserved.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef TCG_GLOBAL_MAP_H
> +#define TCG_GLOBAL_MAP_H
> +
> +#include "qemu/osdep.h"
> +
> +/**
> + * cpu_tcg_mapping: Declarative mapping of offsets into a struct to global
> + *                  TCGvs.  Parseable by LLVM-based tools.
> + * @tcg_var_name: String name of the TCGv to use as destination of the mapping.
> + * @tcg_var_base_address: Address of the above TCGv.
> + * @cpu_var_names: Array of printable names of TCGvs, used when calling
> + *                 tcg_global_mem_new from init_cpu_tcg_mappings.
> + * @cpu_var_base_offset: Base offset of field in the source struct.
> + * @cpu_var_size: Size of field in the source struct, if the field is an array,
> + *                this holds the size of the element type.
> + * @cpu_var_stride: Stride between array elements in the source struct.  This
> + *                  can be greater than the element size when mapping a field
> + *                  in an array of structs.
> + * @number_of_elements: Number of elements of array in the source struct.
> + */
> +typedef struct cpu_tcg_mapping {
> +    const char *tcg_var_name;
> +    void *tcg_var_base_address;
> +
> +    const char *const *cpu_var_names;
> +    size_t cpu_var_base_offset;
> +    size_t cpu_var_size;
> +    size_t cpu_var_stride;
> +
> +    size_t number_of_elements;
> +} cpu_tcg_mapping;
> +
> +#define STRUCT_SIZEOF_FIELD(S, member) sizeof(((S *)0)->member)
> +
> +#define STRUCT_ARRAY_SIZE(S, array)                                            \
> +    (STRUCT_SIZEOF_FIELD(S, array) / STRUCT_SIZEOF_FIELD(S, array[0]))
> +
> +/*
> + * Following are a few macros that aid in constructing
> + * `cpu_tcg_mapping`s for a few common cases.
> + */
> +
> +/* Map between single CPU register and to TCG global */
> +#define CPU_TCG_MAP(struct_type, tcg_var, cpu_var, name_str)                   \
> +    (cpu_tcg_mapping)                                                          \
> +    {                                                                          \
> +        .tcg_var_name = stringify(tcg_var), .tcg_var_base_address = &tcg_var,  \
> +        .cpu_var_names = (const char *[]){name_str},                           \
> +        .cpu_var_base_offset = offsetof(struct_type, cpu_var),                 \
> +        .cpu_var_size = STRUCT_SIZEOF_FIELD(struct_type, cpu_var),             \
> +        .cpu_var_stride = 0, .number_of_elements = 1,                          \
> +    }
> +
> +/* Map between array of CPU registers and array of TCG globals. */
> +#define CPU_TCG_MAP_ARRAY(struct_type, tcg_var, cpu_var, names)                \
> +    (cpu_tcg_mapping)                                                          \
> +    {                                                                          \
> +        .tcg_var_name = #tcg_var, .tcg_var_base_address = tcg_var,             \
> +        .cpu_var_names = names,                                                \
> +        .cpu_var_base_offset = offsetof(struct_type, cpu_var),                 \
> +        .cpu_var_size = STRUCT_SIZEOF_FIELD(struct_type, cpu_var[0]),          \
> +        .cpu_var_stride = STRUCT_SIZEOF_FIELD(struct_type, cpu_var[0]),        \
> +        .number_of_elements = STRUCT_ARRAY_SIZE(struct_type, cpu_var),         \
> +    }
> +
> +/*
> + * Map between single member in an array of structs to an array
> + * of TCG globals, e.g. maps
> + *
> + *     cpu_state.array_of_structs[i].member
> + *
> + * to
> + *
> + *     tcg_global_member[i]
> + */
> +#define CPU_TCG_MAP_ARRAY_OF_STRUCTS(struct_type, tcg_var, cpu_struct,         \
> +                                     cpu_var, names)                           \
> +    (cpu_tcg_mapping)                                                          \
> +    {                                                                          \
> +        .tcg_var_name = #tcg_var, .tcg_var_base_address = tcg_var,             \
> +        .cpu_var_names = names,                                                \
> +        .cpu_var_base_offset = offsetof(struct_type, cpu_struct[0].cpu_var),   \
> +        .cpu_var_size =                                                        \
> +            STRUCT_SIZEOF_FIELD(struct_type, cpu_struct[0].cpu_var),           \
> +        .cpu_var_stride = STRUCT_SIZEOF_FIELD(struct_type, cpu_struct[0]),     \
> +        .number_of_elements = STRUCT_ARRAY_SIZE(struct_type, cpu_struct),      \
> +    }
> +
> +extern cpu_tcg_mapping tcg_global_mappings[];
> +extern size_t tcg_global_mapping_count;
> +
> +void init_cpu_tcg_mappings(cpu_tcg_mapping *mappings, size_t size);
> +
> +#endif /* TCG_GLOBAL_MAP_H */
> diff --git a/tcg/meson.build b/tcg/meson.build
> index 69ebb4908a..a0d6b09d85 100644
> --- a/tcg/meson.build
> +++ b/tcg/meson.build
> @@ -13,6 +13,7 @@ tcg_ss.add(files(
>     'tcg-op-ldst.c',
>     'tcg-op-gvec.c',
>     'tcg-op-vec.c',
> +  'tcg-global-mappings.c',
>   ))
>   
>   if get_option('tcg_interpreter')
> diff --git a/tcg/tcg-global-mappings.c b/tcg/tcg-global-mappings.c
> new file mode 100644
> index 0000000000..cc1f07fae4
> --- /dev/null
> +++ b/tcg/tcg-global-mappings.c
> @@ -0,0 +1,61 @@
> +/*
> + *  Copyright(c) 2024 rev.ng Labs Srl. All Rights Reserved.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "tcg/tcg-global-mappings.h"
> +#include "tcg/tcg-op-common.h"
> +#include "tcg/tcg.h"
> +
> +void init_cpu_tcg_mappings(cpu_tcg_mapping *mappings, size_t size)
> +{
> +    uintptr_t tcg_addr;
> +    size_t cpu_offset;
> +    const char *name;
> +    cpu_tcg_mapping m;
> +
> +    /*
> +     * Paranoid assertion, this should always hold since
> +     * they're typedef'd to pointers. But you never know!
> +     */
> +    g_assert(sizeof(TCGv_i32) == sizeof(TCGv_i64));
> +
> +    /*
> +     * Loop over entries in tcg_global_mappings and
> +     * create the `mapped to` TCGv's.
> +     */
> +    for (int i = 0; i < size; ++i) {
> +        m = mappings[i];
> +
> +        for (int j = 0; j < m.number_of_elements; ++j) {
> +            /*
> +             * Here we are using the fact that
> +             * sizeof(TCGv_i32) == sizeof(TCGv_i64) == sizeof(TCGv)
> +             */
> +            assert(sizeof(TCGv_i32) == sizeof(TCGv_i64));
> +            tcg_addr = (uintptr_t)m.tcg_var_base_address + j * sizeof(TCGv_i32);
> +            cpu_offset = m.cpu_var_base_offset + j * m.cpu_var_stride;
> +            name = m.cpu_var_names[j];
> +
> +            if (m.cpu_var_size < 8) {
> +                *(TCGv_i32 *)tcg_addr =
> +                    tcg_global_mem_new_i32(tcg_env, cpu_offset, name);
> +            } else {
> +                *(TCGv_i64 *)tcg_addr =
> +                    tcg_global_mem_new_i64(tcg_env, cpu_offset, name);
> +            }
> +        }
> +    }
> +}


