Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F24DC53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 09:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp0As-0001UL-2v; Wed, 29 Jul 2026 05:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wp0Ap-0001S3-Qc
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:02:00 -0400
Received: from mail-pj2-x03.google.com ([2607:f8b0:4864:39::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wp0Al-0003Ko-Py
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:01:59 -0400
Received: by mail-pj2-x03.google.com with SMTP id
 98e67ed59e1d1-3810f0aba07so317719a91.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 02:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785315712; x=1785920512; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nTAeHOSmsuRrdO8gNOhcZ+RPd3QZGnbOiszmjQPTYrI=;
 b=DQVFGdjiWYh729rGXlK270rRlrHjPTICue6xiHtCzTOMJQHLNYsbVqC+RQnnPwLdtw
 69+B0847dyYVHzZ1LMTUrXyq9bd7S8Gw5P5KapTDxqhZPvvHY2SEEFT9lVs/ROLgmllI
 TWnfdchU+jR2jjP5nEoNNueVrOtDmlA4z/8jvuP5Blg9J847Bv5SEJ/LLBrR00APvvlp
 aU+D6ylTJpIMq7S8A7/uI2uRNJiyCEPw573SuEJJGTqHT6XB9xl1EMKMUy3zVcmrSI3S
 NGsXOblwp6BhC7xvuPPqJxwKpzXLjIkMxh+empE2YkxbvMdLy1C4AybzvdNALU8tgdca
 3T5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785315712; x=1785920512;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nTAeHOSmsuRrdO8gNOhcZ+RPd3QZGnbOiszmjQPTYrI=;
 b=YGwRERXa5bI9KmKIrqT8Pzd31QmIUZ3b7Bxq98nj7v/WnKFWyCHToZahhXopunnGNi
 1rSdPhYxB7fu6kxiuHn+ju8zyCmd5IZelvdCRbTla29BjuYDW81ME3ZXMcmsYqHorv/w
 1M5K+qSO/6ncfwAivSP5X0H5gx7wz4/E+6PK+dxf1FAIjymKM6ctDm63QnTuoYTQLTnZ
 N8Y/xsrWNgUhbqjFDjWnsBah2zqmgBtC+EkQA6OXJ68e3U+FAX0+w0zjYLz9UzTEuX/f
 hwQDm21d2722r4jr56tvZXv/UPlCfqnPyA3A2MYb2ee37W8PH9iIVyKIs9Rmlbl+zGWP
 /SAQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpNN0xTbcmJTayVl9CKH3P4dhsQ+dVV3tN4+dUtjLRTt0H6PF98xfjkPV2JLN9+d3If0IguNiAmBCrU@nongnu.org
X-Gm-Message-State: AOJu0YyE0tf6cw6ISjVv2YpTK21Msm8B5W1ZvX6zxE4MxNhd/a2vqiFV
 yqBqPKkxFRcwuRo2Eo6nEfkA1zNcXNSKA1AfJvm05J5DO0ABdkHLfBGq
X-Gm-Gg: AR+sD10UUwPF0Qppx3yCveaq8/VAwz0qDTKj6yTACl2rzNyNntlVmxD476k8KSW8cci
 cIDueIh/hDpwbRjMFvFZHreEtAU3QPPrfeUqvWsNCivrPr9BGeivAplPqM0DTpMitf+1sbsVgCQ
 7CGGf9YCQl0lsmDACiHzbVgcWmHNHUfSGqMAVcwFK+CXKKh3iUSqBrQ6CbI2FHjs62P+Iu6dOgg
 r1vZTdI+J0nQQzF6MAnXIPLs6q2xvTFia/jiI453Krc4Z74QQE87n/y9hBk2OoLW6GFoS6uxmA/
 Ps2/OV1U9KS6ikN/Rpj2W8fTcwI9tf33+o4rRdwRUDSfpeILorkSMmj/jFFg6TYMbv5c8b0xYhA
 EpOpGMu1tvlxZ7L3/z8uDqhGhNKLpp4zTP5vSIlIz+gtsnYV8KjAOJ6y0Zn/pzursjz9ryAzYsg
 kaWQQX86OiIKS0rAYbn7iR29/F5edQG0dfg1OSRcw4h4bVvo5Z2DYxFFB16QC2lY141bAmxJ6Ww
 zkIbR8nhbCa+Mq7vvQXcPagvl+oV1CfxeVfkA==
X-Received: by 2002:a17:90b:1e4c:b0:38e:9e9e:ec57 with SMTP id
 98e67ed59e1d1-38f6a588a24mr3929308a91.43.1785315712267; 
 Wed, 29 Jul 2026 02:01:52 -0700 (PDT)
Received: from localhost ([179.255.148.148]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504dd42a9sm9104945eec.30.2026.07.29.02.01.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 02:01:51 -0700 (PDT)
Date: Wed, 29 Jul 2026 17:01:48 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Molly Chen <xiaoou@iscas.ac.cn>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 02/18] target/riscv: Add packed SIMD helper framework
Message-ID: <amm9gBzFKzKq0whI@ChaodeMacBook-Pro.local>
References: <cover.1784280142.git.xiaoou@iscas.ac.cn>
 <e3775ec9235fa974e9a318edf1836cdaab197e27.1784280142.git.xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3775ec9235fa974e9a318edf1836cdaab197e27.1784280142.git.xiaoou@iscas.ac.cn>
Received-SPF: pass client-ip=2607:f8b0:4864:39::3;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pj2-x03.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Jul 17, 2026 at 10:06:55AM +0800, Molly Chen wrote:
> Signed-off-by: Molly Chen <xiaoou@iscas.ac.cn>
> ---
>  target/riscv/tcg/meson.build    |    3 +-
>  target/riscv/tcg/psimd_helper.c | 1656 +++++++++++++++++++++++++++++++
>  2 files changed, 1658 insertions(+), 1 deletion(-)
>  create mode 100644 target/riscv/tcg/psimd_helper.c
> 
> diff --git a/target/riscv/tcg/meson.build b/target/riscv/tcg/meson.build
> index a05ab642f41..cc438d7c0d2 100644
> --- a/target/riscv/tcg/meson.build
> +++ b/target/riscv/tcg/meson.build
> @@ -15,7 +15,8 @@ riscv_ss.add(files(
>    'vcrypto_helper.c',
>    'vector_helper.c',
>    'vector_internals.c',
> -  'zce_helper.c'))
> +  'zce_helper.c',
> +  'psimd_helper.c'))
>  
>  
>  riscv_system_ss.add(files(
> diff --git a/target/riscv/tcg/psimd_helper.c b/target/riscv/tcg/psimd_helper.c
> new file mode 100644
> index 00000000000..2948bbb2a86
> --- /dev/null
> +++ b/target/riscv/tcg/psimd_helper.c
> @@ -0,0 +1,1656 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/* RISC-V Packed SIMD Extension Helpers for QEMU. */
> +/* Copyright (C) 2026 ISRC ISCAS. */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "qemu/host-utils.h"
> +#include "exec/helper-proto.h"
> +#include "fpu/softfloat.h"
> +#include "internals.h"
> +
> +
> +/* Helper macros */
> +
> +/* Element count calculations */
> +#define ELEMS_B(target) (sizeof(target) * 8 / 8)    /* byte elements count */
> +#define ELEMS_H(target) (sizeof(target) * 8 / 16)
> +#define ELEMS_W(target) (sizeof(target) * 8 / 32)   /* word elements count */
> +#define ELEMS_D(target) (sizeof(target) * 8 / 64)
> +
> +/* Element extraction macros - unsigned to avoid sign extension */
> +#define EXTRACT8(val, idx)  (((val) >> ((idx) * 8)) & 0xFF)
> +#define EXTRACT16(val, idx) (((val) >> ((idx) * 16)) & 0xFFFF)
> +#define EXTRACT32(val, idx) (((val) >> ((idx) * 32)) & 0xFFFFFFFF)
> +#define EXTRACT64(val, idx) (((val) >> ((idx) * 64)) & 0xFFFFFFFFFFFFFFFFULL)
> +
QEMU has the generator bit-operation helper macros. I believe you don't need to
define them again, so you can just follow this header file path.

path: include/qemu/bitops.h

```
  extract8(value, start, length)
  extract16(value, start, length)
  extract32(value, start, length)
  extract64(value, start, length)

  sextract32(value, start, length)
  sextract64(value, start, length)
```

So we can redefine these helper macros like this:

```
  #define EXTRACT_B(val, idx) extract64((val), (idx) * 8, 8)
  #define EXTRACT_H(val, idx) extract64((val), (idx) * 16, 16)
  #define EXTRACT_W(val, idx) extract64((val), (idx) * 32, 32)
  #define EXTRACT_D(val, idx) extract64((val), (idx) * 64, 64)
```

> +/* Element insertion macros */
> +#define INSERT8(val, res, idx) \
> +    ((val) | ((target_ulong)(uint8_t)(res) << ((idx) * 8)))
> +#define INSERT16(val, res, idx) \
> +    ((val) | ((target_ulong)(uint16_t)(res) << ((idx) * 16)))
> +#define INSERT32(val, res, idx) \
> +    ((val) | ((target_ulong)(uint32_t)(res) << ((idx) * 32)))
> +#define INSERT32_64(val, res, idx) \
> +    ((val) | ((uint64_t)(uint32_t)(res) << ((idx) * 32)))
> +#define INSERT64(val, res, idx) \
> +    ((val) | ((uint64_t)(res) << ((idx) * 64)))
> +
> +/* Saturation constants */
> +static const int8_t   SAT_MAX_B = 127;
> +static const int8_t   SAT_MIN_B = -128;
> +static const int16_t  SAT_MAX_H = 32767;
> +static const int16_t  SAT_MIN_H = -32768;
> +static const int32_t  SAT_MAX_W = 2147483647;
> +static const int32_t  SAT_MIN_W = -2147483648LL;
> +static const uint8_t  USAT_MAX_B = 255;
> +static const uint16_t USAT_MAX_H = 65535;
> +static const uint32_t USAT_MAX_W = 4294967295U;
> +
> +
> +/* Saturation helper functions */
> +
> +/**
> + * Signed saturation for 8-bit elements
> + * Returns saturated value and sets *sat if saturation occurred
> + */
This helper function has some comments that explain what it does.
I believe we don't need these explanations if the function name is
already clear.

The other helper functions below are similar. I think we only need
to add comments when it's necessary to explain the reasoning behind
why we're doing something.

d> +static inline int8_t signed_saturate_b(int32_t val, int *sat)
> +{
> +    if (val > SAT_MAX_B) {
> +        *sat = 1;
> +        return SAT_MAX_B;
> +    }
> +    if (val < SAT_MIN_B) {
> +        *sat = 1;
> +        return SAT_MIN_B;
> +    }
> +    return (int8_t)val;
> +}
> +
> +/**
> + * Signed saturation for 16-bit elements
> + */
> +static inline int16_t signed_saturate_h(int32_t val, int *sat)
> +{
> +    if (val > SAT_MAX_H) {
> +        *sat = 1;
> +        return SAT_MAX_H;
> +    }
> +    if (val < SAT_MIN_H) {
> +        *sat = 1;
> +        return SAT_MIN_H;
> +    }
> +    return (int16_t)val;
> +}
> +
> +/**
> + * Signed saturation for 32-bit elements
> + */
> +static inline int32_t signed_saturate_w(int64_t val, int *sat)
> +{
> +    if (val > SAT_MAX_W) {
> +        *sat = 1;
> +        return SAT_MAX_W;
> +    }
> +    if (val < SAT_MIN_W) {
> +        *sat = 1;
> +        return SAT_MIN_W;
> +    }
> +    return (int32_t)val;
> +}
> +
> +/**
> + * Unsigned saturation for 8-bit elements
> + */
> +static inline uint8_t unsigned_saturate_b(uint32_t val, int *sat)
> +{
> +    if (val > USAT_MAX_B) {
> +        *sat = 1;
> +        return USAT_MAX_B;
> +    }
> +    return (uint8_t)val;
> +}
> +
> +/**
> + * Unsigned saturation for 16-bit elements
> + */
> +static inline uint16_t unsigned_saturate_h(uint32_t val, int *sat)
> +{
> +    if (val > USAT_MAX_H) {
> +        *sat = 1;
> +        return USAT_MAX_H;
> +    }
> +    return (uint16_t)val;
> +}
> +
> +/**
> + * Unsigned saturation for 32-bit elements
> + */
> +static inline uint32_t unsigned_saturate_w(uint64_t val, int *sat)
> +{
> +    if (val > USAT_MAX_W) {
> +        *sat = 1;
> +        return USAT_MAX_W;
> +    }
> +    return (uint32_t)val;
> +}
> +
> +static inline target_ulong psimd_abdsumu_b(target_ulong rs1,
> +                                           target_ulong rs2,
> +                                           target_ulong sum)
> +{
> +    int elems = ELEMS_B(rs1);
> +
> +    for (int i = 0; i < elems; i++) {
> +        uint8_t e1 = EXTRACT8(rs1, i);
> +        uint8_t e2 = EXTRACT8(rs2, i);
> +        uint8_t diff = (e1 > e2) ? (e1 - e2) : (e2 - e1);
> +        sum += diff;
> +    }
> +
> +    return sum;
> +}
> +
> +#define PSIMD_DO_ADD(N, M) ((N) + (M))
> +#define PSIMD_DO_SUB(N, M) ((N) - (M))
> +#define PSIMD_DO_ABD(N, M) ((N) >= (M) ? (N) - (M) : (M) - (N))
> +#define PSIMD_DO_EQ_MASK(N, M) ((N) == (M) ? -1 : 0)
> +#define PSIMD_DO_LT_MASK(N, M) ((N) < (M) ? -1 : 0)
> +#define PSIMD_DO_MIN(N, M) ((N) < (M) ? (N) : (M))
> +#define PSIMD_DO_MAX(N, M) ((N) > (M) ? (N) : (M))
> +#define PSIMD_DO_SLL(N, M) ((N) << (M))
> +#define PSIMD_DO_SRL(N, M) ((N) >> (M))
> +#define PSIMD_DO_SRA(N, M) ((N) >> (M))
> +

[...]

> +
> +#define GEN_PSIMD_SCALAR_ABS(NAME, RTYPE, STYPE, UTYPE)                   \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1)                         \
> +{                                                                         \
> +    STYPE value = (STYPE)rs1;                                            \
> +    UTYPE result = (UTYPE)value;                                         \
> +                                                                          \
> +    if (value < 0) {                                                      \
> +        result = (UTYPE)0 - result;                                      \
> +    }                                                                     \
> +    return (RTYPE)(STYPE)result;                                         \
> +}
The '\' for the column widths aren't aligned here. It would
look much better if we could align them consistently throughout.

[...]

> +uint64_t HELPER(NAME)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)     \
> +{                                                                         \
> +    int64_t a = (int64_t)rs1;                                            \
> +    int8_t shamt = (int8_t)(rs2 & 0xff);                                 \
> +                                                                          \
> +    if (shamt >= 0) {                                                     \
> +        return (uint64_t)(a << shamt);                                    \
> +    }                                                                     \
> +                                                                          \
> +    int right = -shamt;                                                   \
> +    if (right >= 64) {                                                    \
> +        return (a < 0) ? (uint64_t)-1 : 0;                               \
> +    }                                                                     \
> +    return (uint64_t)RIGHT_OP(a, right);                                  \
> +}
There are similar alignment issues here.

> +
> +#define PSIMD_DO_SRL64(A, B) (((B) >= 64) ? 0 : ((A) >> (B)))
> +#define PSIMD_DO_RNDSRL64(A, B)                                          \
> +    (((B) > 64) ? 0 : ((((A) >> ((B) - 1)) + 1) >> 1))
> +
> +#define GEN_PSIMD_VAR_SRL64(NAME, RIGHT_OP)                               \
> +uint64_t HELPER(NAME)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)     \
> +{                                                                         \
> +    int8_t shamt = (int8_t)(rs2 & 0xff);                                 \
> +                                                                          \
> +    if (shamt < 0) {                                                      \
> +        return RIGHT_OP(rs1, -shamt);                                     \
> +    }                                                                     \
> +    return (shamt >= 64) ? 0 : (rs1 << shamt);                           \
> +}
> +
Same here.You can check again for the patches.

Thanks,
Chao

