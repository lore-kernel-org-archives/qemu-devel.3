Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F7ECD4F59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 06:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sm6Q8-0001Zm-T3; Thu, 05 Sep 2024 02:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sm6Q4-0001Ya-K9
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 02:56:41 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sm6Q2-0001Wp-2H
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 02:56:39 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2d889ba25f7so301968a91.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 23:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725519396; x=1726124196; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z7+EhAEa/A/jhyQXJZ0Fh+KfV6tTidInLnLvB/+1CaI=;
 b=OO207fP7jkjEhoxLLiLdFKL8QeSPJe/quCQ+Xip8kE5etYUNW1oSyFPbBlbkHO75BE
 6P/Ywd3pOXbir0gScsjcpdi/ty779fPl/Z+1ba2zW0qVqqakf8pd/icGqVQwHMYliO36
 sYijKwuSnVslM87l9x/K6ejJWMREVzE5dLPngNmPyyyWSVLd9fJ6+qRCEfkZSOgbOXDk
 6i4OoQhRBofW0EcCbUgqSROQJByDe8BqV4FrYBQVbnOCvbgH/5lzOdRI5SKpPiGCVMw0
 EZoBss1oufEVMY6dglzr/Y25LDLLs/kJLo3lyBj9VGZ9C9fRFeITmWaoLnBTdELgcf6p
 5oMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725519396; x=1726124196;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z7+EhAEa/A/jhyQXJZ0Fh+KfV6tTidInLnLvB/+1CaI=;
 b=qWY/qINvcOdZXaaqReh5NgpXDkf+O/y+ksGJqHX4WV4Bvdjevb3uLlyxZIOX6mFbsc
 RgTR+e5kjhS676GHaNn5a+19ppcVsYaKbIi6lm72FKZn+Yp0VsdQ1EBRPop7kmeNQPYf
 TUVfaeXjHZwqTa5Gp0TPV0nMSPT+YjgG5xa1ui23FDekg/57KdNssQBr5BouCgohqw3l
 ymUNfZ40xdzRk+r8EGkWZzjQXOXeIukfafgXCySTfmD7JVb3atkZABJcrbYKuKm3R/qy
 brC9GN9QKHmW65RYB0bjyP20idtte4DVPPCYAAnfMKDzyPmKBZe990WLaZ7L70ccIdSk
 iB9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgG4bWXTzZScE4VE9OlxGe3H0psgI3O9x577sNMOC8xDCIQptVan+H/jUI7AT424RMOgspv7BUhV47@nongnu.org
X-Gm-Message-State: AOJu0Yw+ZWle+pLfWddSIT8GFsesGjLXL4LL3HonP6RvwdsuTb56n5JI
 4bTVnWKWuFbiUntAfrZ/RaoT3bUHxBihVRx2X0beEcPUI3Zg8EXx0Tsg4Eirre8=
X-Google-Smtp-Source: AGHT+IFhqakyQHr6NhE0W7io3qdRIVfIKMhl/zx5IbEp6Wjp6hHxTuHu6jPPzsSEpsYKkKkFiCftBQ==
X-Received: by 2002:a17:90a:6788:b0:2d8:8818:4d51 with SMTP id
 98e67ed59e1d1-2d8972730cfmr14981100a91.7.1725519396190; 
 Wed, 04 Sep 2024 23:56:36 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d85afb2d88sm14744599a91.0.2024.09.04.23.56.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Sep 2024 23:56:35 -0700 (PDT)
Message-ID: <e8091bd4-95f3-4a7c-966e-521d75a33c79@linaro.org>
Date: Wed, 4 Sep 2024 23:56:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/14] tcg/riscv: Implement vector mov/dup{m/i}
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240904142739.854-1-zhiwei_liu@linux.alibaba.com>
 <20240904142739.854-7-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240904142739.854-7-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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
> @@ -698,6 +704,21 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
>       case TCG_TYPE_I64:
>           tcg_out_opc_imm(s, OPC_ADDI, ret, arg, 0);
>           break;
> +    case TCG_TYPE_V64:
> +    case TCG_TYPE_V128:
> +    case TCG_TYPE_V256:
> +        {
> +            int nf = get_vec_type_bytes(type) / riscv_vlenb;
> +
> +            if (nf != 0) {
> +                tcg_debug_assert(is_power_of_2(nf) && nf <= 8);
> +                tcg_out_opc_vi(s, OPC_VMVNR_V, ret, arg, nf - 1, true);
> +            } else {
> +                riscv_set_vec_config_vl(s, type);
> +                tcg_out_opc_vv(s, OPC_VMV_V_V, ret, TCG_REG_V0, arg, true);
> +            }
> +        }
> +        break;

Perhaps

         int lmul = type - riscv_lg2_vlenb;
         int nf = 1 << MIN(lmul, 0);
         tcg_out_opc_vi(s, OPC_VMVNR_V, ret, arg, nf - 1);

Is there a reason to prefer vmv.v.v over vmvnr.v?
Seems like we can always move one vector reg...

> +static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
> +                                    TCGReg dst, int64_t arg)
> +{
> +    if (arg < 16 && arg >= -16) {
> +        riscv_set_vec_config_vl_vece(s, type, vece);
> +        tcg_out_opc_vi(s, OPC_VMV_V_I, dst, TCG_REG_V0, arg, true);
> +        return;
> +    }
> +    tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP0, arg);
> +    tcg_out_dup_vec(s, type, vece, dst, TCG_REG_TMP0);
> +}

I'll note that 0 and -1 do not require SEW change. I don't know how often that will come 
up, since in my testing with aarch64, we usually needed to swap to TCG_TYPE_V256 anyway.


r~

