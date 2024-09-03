Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E992CA101E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 06:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slNIR-0007Km-2J; Tue, 03 Sep 2024 02:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1slNIP-0007IR-2l
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 02:45:45 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1slNIH-0005DG-Vl
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 02:45:44 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-71744362c22so1818927b3a.2
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 23:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725345935; x=1725950735; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6qVDYD2ZCXmeSWgd/ENZQDQFWaIIuur/7PpUTN8kDgs=;
 b=XZxwrzVJQ9AIpE+fEyDFfxYKGqvP6s72X3s/KzKA0LJlRNRxEV9YTAGwfro3XIOP1v
 lH3NaOKxTRJh5Bwrz+IDJuiLMrMKcpyeJgJL94R3c7Ma9u9BI/teg0vSemKtY2W5hy6Q
 6vc3si2OnBsQz4tFXEOCXmaOH6VkY37zhQr7URy4tz+OSPRilEV4Zb5G9ltDl53Jji0i
 6rx1ScZkBtghjO22KUS8HNdP5AUgePiVz0HzEpbE7yPF+q/2fnfOremsT3KZh5i1jPpF
 QMYEeOgNqNazbJFxrjK7Nl6f9wIfhFdEk9U5zot4A6iW/tH4qXKrYNhyQrocIbZ2iXxq
 ZIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725345935; x=1725950735;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6qVDYD2ZCXmeSWgd/ENZQDQFWaIIuur/7PpUTN8kDgs=;
 b=fUvNp7r60hn3MWNmktjyyWsEvEqzAyltO7T+0i7ZB7HqEi+ksNNPeiKHLKbmSDtl+R
 KEGgWZpiSA97xgWMH0lp2R+Xafqpavl0VEDn8NEzo5NCQJr3WJn2NLwGEwMAsl9I5mA3
 BeHnY70231GldUq4lmJjLCLSgp2bcmLC3+nF39OK2TWEjrWQsjVJrGq2PRuWFTBQG506
 tTkTrM5g5gkP0NyhpSX15b0Kb/42+TiMkA6ZwCO5gVYbrwxwo5ZvhWuu50fwOwZ2GvdW
 7wDX/pWkRre8rGDN9iBvmBYRO+QyUa0i2p3UigpIftSTQSAaBCfp6+lLKxukew3WMEtY
 s/Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjkFJelDXqyvH5HoVgz/S1JoRGn/vIMWEjcRQVT2xFnyF3Iloj7f3sIGvzynPhXYhInroiS2Akez5k@nongnu.org
X-Gm-Message-State: AOJu0YzF8J1aOaS/dqmSfsuAS46BF/HJ+K5lPGxkFAhWdoxrNt8Knk43
 8VuGd0JKfd6SVxVBY0hPgTTXr+aLI8fsNrGLKylpffqFbDVCtxpcUhoJdDn3TNc=
X-Google-Smtp-Source: AGHT+IE20u7HK3i1RbhPz7NWUjldIJ1uwosvvasCvQGurGosGxpj0WQs1L2IX9/ruT1F1X11jBItlA==
X-Received: by 2002:a05:6a00:181e:b0:70b:2a:15cd with SMTP id
 d2e1a72fcca58-717454eac71mr9046021b3a.0.1725345934492; 
 Mon, 02 Sep 2024 23:45:34 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7d22e9be18esm8582647a12.73.2024.09.02.23.45.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Sep 2024 23:45:34 -0700 (PDT)
Message-ID: <629e9969-157e-4f58-b48f-52aea4c0c48f@linaro.org>
Date: Mon, 2 Sep 2024 23:45:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 08/14] tcg/riscv: Implement vector cmp ops
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240830061607.1940-1-zhiwei_liu@linux.alibaba.com>
 <20240830061607.1940-9-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20240830061607.1940-9-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 8/30/24 16:16, LIU Zhiwei wrote:
> From: TANG Tiancheng<tangtiancheng.ttc@alibaba-inc.com>
> 
> 1.Address immediate value constraints in RISC-V Vector Extension 1.0 for
> comparison instructions.
> 
> 2.Extend comparison results from mask registers to SEW-width elements,
>    following recommendations in The RISC-V SPEC Volume I (Version 20240411).
> 
> This aligns with TCG's cmp_vec behavior by expanding compare results to
> full element width: all 1s for true, all 0s for false.
> 
> Signed-off-by: TANG Tiancheng<tangtiancheng.ttc@alibaba-inc.com>
> Reviewed-by: Liu Zhiwei<zhiwei_liu@linux.alibaba.com>
> ---
>   tcg/riscv/tcg-target-con-set.h |   6 +-
>   tcg/riscv/tcg-target.c.inc     | 240 +++++++++++++++++++++++++++++++++
>   tcg/riscv/tcg-target.opc.h     |   5 +
>   3 files changed, 250 insertions(+), 1 deletion(-)
> 
> diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
> index 7277cb9af8..6c9ad5188b 100644
> --- a/tcg/riscv/tcg-target-con-set.h
> +++ b/tcg/riscv/tcg-target-con-set.h
> @@ -21,7 +21,11 @@ C_O1_I2(r, rZ, rZ)
>   C_N1_I2(r, r, rM)
>   C_O1_I4(r, r, rI, rM, rM)
>   C_O2_I4(r, r, rZ, rZ, rM, rM)
> +C_O0_I1(v)
> +C_O0_I2(v, v)
>   C_O0_I2(v, r)
> -C_O0_I2(v, vK)

Removing vK, just added in the previous patch.

> +static bool expand_vec_cmp_vi(TCGType type, unsigned vece,
> +                              TCGv_vec v1, TCGArg a2, TCGCond cond)
> +{
> +    int64_t arg2 = arg_temp(a2)->val;
> +    bool invert = false;
> +
> +    if (!tcg_vec_cmp_can_do_vi(cond, arg2)) {
...
> +static bool expand_vec_cmp_noinv(TCGType type, unsigned vece, TCGv_vec v1,
> +                          TCGArg a2, TCGCond cond)
> +{
> +    bool invert = false;
> +    TCGTemp *t1 = arg_temp(a2);
> +
> +    if (t1->kind == TEMP_CONST) {
> +        invert = expand_vec_cmp_vi(type, vece, v1, a2, cond);

This will not work as you intend, primarily because vector constants are stored in 
expanded form. E.g. MO_8 1 is stored as 0x0101010101010101.

This is handled transparently *if* you use tcg_target_const_match instead.
Otherwise one must (sign)extract the low vece bits, and then double-check that the 
replication of the low bits matches the complete 'a2' value.

I agree that we should be prepared for more vector x scalar operations, but that needs to 
happen during generic expansion rather than very late in the backend.

I think the first implementation should be simpler:

CONST('C', TCG_CT_CONST_CMP_VI)

tcg_target_const_match()
{
     ...
     if ((ct & TCG_CT_CONST_CMP_VI) &&
         val >= tcg_cmpcond_to_rvv_vi[cond].min &&
         val <= tcg_cmpcond_to_rvv_vi[cond].max) {
         return true;
     }
}

     case INDEX_op_cmp_vec:
         riscv_set_vec_config_vl_vece(s, type, vece);
         cond = args[3];
         if (c2) {
             tcg_out_opc_vi(s, tcg_cmpcond_to_rvv_vi[cond].op, a0, a1,
                            a2 - tcg_cmpcond_to_rvv_vi[cond].adjust);
         } else if (tcg_cmpcond_to_rvv_vv[cond].swap) {
             tcg_out_opc_vv(s, tcg_cmpcond_to_rvv_vv[cond].op, a0, a2, a1);
         } else {
             tcg_out_opc_vv(s, tcg_cmpcond_to_rvv_vv[cond].op, a0, a1, a2);
         }
         break;

This appears to not require any expansion in tcg_expand_vec_op at all.


r~

