Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4028FCD4F50
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 04:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sm3kF-0007UV-Ac; Thu, 05 Sep 2024 00:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sm3kC-0007M2-RY
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 00:05:17 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sm3kA-0006PE-TJ
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 00:05:16 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5d5eec95a74so213538eaf.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 21:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725509113; x=1726113913; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XrZZ2kqTwwZvEdSTwDdyGdja4CBNBQQSsWCh76+3EIw=;
 b=bevZgbO02g3E1q84wd1IlMOE1RUJndyzLFJYlUjuFDmed+r5+c6PbmL44yXbgpSyK6
 aV2Y1EGSge3fT/Am8PzPB6QkSVIlKlaObj5Z7sXP9YQm22J16a+lFKRJcNJK3bUVocHu
 QA9mVSKYtwU3Y5YL5rsD52+rFS+mjy4ljZe1tswc326smATgq/JAHHC1Mjvud/u2hEw5
 hZH9l+wE2NHH+eA0eiz++/VkpXFgs3zDrUtodMEF9G/JKaR9ZDyDRJj6Ag7E9vyMKGfg
 tprn5D3c9jFaDfuYZnpAcECgjOWUVDBR/s89la1A1wq7n8K0eTBSbtK8fz4qSkiZfiY5
 5aMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725509113; x=1726113913;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XrZZ2kqTwwZvEdSTwDdyGdja4CBNBQQSsWCh76+3EIw=;
 b=J37jXVUJ7nSVfRMI6ZoxkcloK3+yUlbXfrAiVAuxXyan3pUb9mK9h0+bPEKvXz6joM
 DA8G43AMctiwRSSTOJPLCuUEJayQkm1MLNn6f4h/A3jSdVHaY1DWjGgOM4piUyk5vYIJ
 PZ5om5E8BY253eHlAYx1oEALLLuxstsLfHx+CHuOTI0v21LWp69q/T+P6qqwQffpsShq
 wQOaCs30BKVI5/5kF7ZMzGJxrb8rD+7U3J9u3ppfZ+y/T4ZBlAzB1JdbTz4N1tXrjCHr
 Br2EMpqWRr+zDCjGqnhBmwtDPkOdR5UbEtMmRv/16vhXE9PaGo7PTqRKLieTJii2if4O
 94gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWUXJ4Rc6g8A2SzRppElpp+Dfn2C6HYtCwikKyd0TF394Nzxk943B8fwSuV6Vm26UcI7jwzvy4jAD6@nongnu.org
X-Gm-Message-State: AOJu0Yzrj9XHfJ+YL8EHZk3uL5MOBZqHMG8rKwRhpHbIyhoTIpxmdeAT
 PDwQkofdcT32Yf3U/aF3TCNRmGbWeaHnfaILn1EnysSjPOlqdrkswlBrqhljDKU=
X-Google-Smtp-Source: AGHT+IGW89s12wvHVbFmvNaRMAKT7oI6BOZqglaRgMvReLFRk2N0MlNDUa+AyFidzIIg1gpt2buQVA==
X-Received: by 2002:a05:6870:a999:b0:267:df02:f7c0 with SMTP id
 586e51a60fabf-2781a945645mr8873959fac.33.1725509112824; 
 Wed, 04 Sep 2024 21:05:12 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-717785989d7sm2334599b3a.161.2024.09.04.21.05.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Sep 2024 21:05:12 -0700 (PDT)
Message-ID: <943abf2a-de03-49fd-b594-76b15224f2cc@linaro.org>
Date: Wed, 4 Sep 2024 21:05:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/14] tcg/riscv: Add basic support for vector
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 Swung0x48 <swung0x48@outlook.com>,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240904142739.854-1-zhiwei_liu@linux.alibaba.com>
 <20240904142739.854-4-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240904142739.854-4-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 9/4/24 07:27, LIU Zhiwei wrote:
> From: Swung0x48 <swung0x48@outlook.com>
> 
> The RISC-V vector instruction set utilizes the LMUL field to group
> multiple registers, enabling variable-length vector registers. This
> implementation uses only the first register number of each group while
> reserving the other register numbers within the group.
> 
> In TCG, each VEC_IR can have 3 types (TCG_TYPE_V64/128/256), and the
> host runtime needs to adjust LMUL based on the type to use different
> register groups.
> 
> This presents challenges for TCG's register allocation. Currently, we
> avoid modifying the register allocation part of TCG and only expose the
> minimum number of vector registers.
> 
> For example, when the host vlen is 64 bits and type is TCG_TYPE_V256, with
> LMUL equal to 4, we use 4 vector registers as one register group. We can
> use a maximum of 8 register groups, but the V0 register number is reserved
> as a mask register, so we can effectively use at most 7 register groups.
> Moreover, when type is smaller than TCG_TYPE_V256, only 7 registers are
> forced to be used. This is because TCG cannot yet dynamically constrain
> registers with type; likewise, when the host vlen is 128 bits and
> TCG_TYPE_V256, we can use at most 15 registers.
> 
> There is not much pressure on vector register allocation in TCG now, so
> using 7 registers is feasible and will not have a major impact on code
> generation.
> 
> This patch:
> 1. Reserves vector register 0 for use as a mask register.
> 2. When using register groups, reserves the additional registers within
>     each group.
> 
> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> Co-authored-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>

This patch does not compile.

../src/tcg/tcg.c:135:13: error: 'tcg_out_dup_vec' used but never defined [-Werror]
   135 | static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
       |             ^~~~~~~~~~~~~~~
../src/tcg/tcg.c:137:13: error: 'tcg_out_dupm_vec' used but never defined [-Werror]
   137 | static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
       |             ^~~~~~~~~~~~~~~~
../src/tcg/tcg.c:139:13: error: 'tcg_out_dupi_vec' used but never defined [-Werror]
   139 | static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
       |             ^~~~~~~~~~~~~~~~
In file included from ../src/tcg/tcg.c:755:
/home/rth/qemu/src/tcg/riscv/tcg-target.c.inc:516:13: error: 'tcg_out_opc_ldst_vec' 
defined but not used [-Werror=unused-function]
   516 | static void tcg_out_opc_ldst_vec(TCGContext *s, RISCVInsn opc, TCGReg data,
       |             ^~~~~~~~~~~~~~~~~~~~
/home/rth/qemu/src/tcg/riscv/tcg-target.c.inc:507:13: error: 'tcg_out_opc_vi' defined but 
not used [-Werror=unused-function]
   507 | static void tcg_out_opc_vi(TCGContext *s, RISCVInsn opc, TCGReg vd,
       |             ^~~~~~~~~~~~~~
/home/rth/qemu/src/tcg/riscv/tcg-target.c.inc:501:13: error: 'tcg_out_opc_vx' defined but 
not used [-Werror=unused-function]
   501 | static void tcg_out_opc_vx(TCGContext *s, RISCVInsn opc, TCGReg vd,
       |             ^~~~~~~~~~~~~~
/home/rth/qemu/src/tcg/riscv/tcg-target.c.inc:495:13: error: 'tcg_out_opc_vv' defined but 
not used [-Werror=unused-function]
   495 | static void tcg_out_opc_vv(TCGContext *s, RISCVInsn opc, TCGReg vd,
       |             ^~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Either:
(1) Provide stubs for the functions that are required, and delay implementation
     of the unused functions until the patch(es) that use them.
(2) Merge the dup patch so that these functions are defined and implemented,
     which will also provide uses for most of the tcg_out_opc_* functions.


> @@ -2100,6 +2174,32 @@ static void tcg_target_init(TCGContext *s)
>   {
>       tcg_target_available_regs[TCG_TYPE_I32] = 0xffffffff;
>       tcg_target_available_regs[TCG_TYPE_I64] = 0xffffffff;
> +    s->reserved_regs = 0;
> +
> +    if (cpuinfo & CPUINFO_ZVE64X) {
> +        switch (riscv_vlen) {
> +        case 64:
> +            tcg_target_available_regs[TCG_TYPE_V64] = ALL_VECTOR_REGS;
> +            tcg_target_available_regs[TCG_TYPE_V128] = ALL_DVECTOR_REG_GROUPS;
> +            tcg_target_available_regs[TCG_TYPE_V256] = ALL_QVECTOR_REG_GROUPS;
> +            s->reserved_regs |= (~ALL_QVECTOR_REG_GROUPS & 0xffffffff00000000);

No need for ().
Use ALL_VECTOR_REGS instead of the immediate integer.

> +            break;
> +        case 128:
> +            tcg_target_available_regs[TCG_TYPE_V64] = ALL_VECTOR_REGS;
> +            tcg_target_available_regs[TCG_TYPE_V128] = ALL_VECTOR_REGS;
> +            tcg_target_available_regs[TCG_TYPE_V256] = ALL_DVECTOR_REG_GROUPS;
> +            s->reserved_regs |= (~ALL_DVECTOR_REG_GROUPS & 0xffffffff00000000);
> +            break;
> +        case 256:
> +            tcg_target_available_regs[TCG_TYPE_V64] = ALL_VECTOR_REGS;
> +            tcg_target_available_regs[TCG_TYPE_V128] = ALL_VECTOR_REGS;
> +            tcg_target_available_regs[TCG_TYPE_V256] = ALL_VECTOR_REGS;
> +            break;
> +        default:
> +            g_assert_not_reached();

The first host with 512-bit or larger vectors will trigger the assert.

With my suggestion against patch 2, this becomes

     switch (riscv_lg2_vlenb) {
     case TCG_TYPE_V64:
         ...
     case TCG_TYPE_V128:
         ...
     default:
         /* Guaranteed by Zve64x. */
         tcg_debug_assert(riscv_lg2_vlenb >= TCG_TYPE_V256);
     }


r~

