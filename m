Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B58C54FC6
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 01:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1skw2X-0001W0-1H; Sun, 01 Sep 2024 21:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1skw2V-0001TL-9V
 for qemu-devel@nongnu.org; Sun, 01 Sep 2024 21:39:31 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1skw2T-0003oL-IH
 for qemu-devel@nongnu.org; Sun, 01 Sep 2024 21:39:31 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-714187df604so2730910b3a.1
 for <qemu-devel@nongnu.org>; Sun, 01 Sep 2024 18:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725241168; x=1725845968; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BweZi/jq7mdbxjr0NXJOqzVD2ej+YtagBJ6925LcZ7U=;
 b=GuOzQzq6O7qldVsY2NI3oNyFgN7ax6gEUYvnSKZ+qjQClVUOezTW374sJ8kXpf/Igu
 KQMMsvBefBEO6XKha2ns+/0ABFGXRaP4WnLnB52igYu+AIdfihdsOFFtkkEv8KXd9Jx5
 oywHTSbMnfYjwQmhn0GfjMXzV5TiXaYc211S/GaQY5vNG+QzcFFbbNM7TqXQNTuW8YCi
 IqYbA3QtSVF+NPZ5qGkBbW1O/J4IMjhhO+mgb7CFmNqg7LczFOGe45USjMaS7x8/EbVK
 vbabzLQY0L9m0WiTaRAz6KVYv8bmi9I1wRhSY8LV6NEKxjVTjAyIFX2Gbd4cLocHaM2v
 Hw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725241168; x=1725845968;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BweZi/jq7mdbxjr0NXJOqzVD2ej+YtagBJ6925LcZ7U=;
 b=YTj6B2ytzFMU4Gj+MrK+wp7PM78mAJdTsR1tWUtZ4mBhJX9rd4ujXW2RDglJS0qDdP
 PiGPnwT1g+edk+PCmAfIsu/55WVTYEBAna5S0woRPYMrpmOs9DsbKqqM4aPL7xwTxein
 LhxdSzREd/KWJgc3rIR7qd5dXQ/zTdGot1xY1Uhw5Uv2ECFuJerzSJYWuuKOU4JtV1Wj
 VzjHdjMZ4BNmZTYw6YuAsPQf/SA4DPmMzKrQHDxDYxGy0NlGaVlk7zzUqTRIUaufXWAA
 sNjqjHv1WSyhsC/ADi78V5z6DssMnLuphx1GIQw4niI8NHgJUSHxTBjgitMJVaP0UtmO
 rhzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwRUMlYahwA985fXpyjcs/nZR/pclCeM7nunYOkRWhnZe3tW7iK9XY2NcCB++JWHRF52T7wj96FDZ1@nongnu.org
X-Gm-Message-State: AOJu0YywgR6qEV2paM1c99xq6xbO/ZULtoqhX3ZUlx8P4IUDIOp/0bAN
 pRKIbdpfNoOBLrlaDmWRCRK1UGt/TmCeUJ+t7TKHoYtlMcGJ7iQI1xXkLKXWSd4=
X-Google-Smtp-Source: AGHT+IHD9euHqzPsrsgtqKSwOADMe8ef16lomMhk1G43/T4GbOxkVO5A1e7mpNw2zP9wqc/qYFcOCA==
X-Received: by 2002:a17:903:2288:b0:205:7007:84fa with SMTP id
 d9443c01a7336-2057007877fmr32952045ad.28.1725241167646; 
 Sun, 01 Sep 2024 18:39:27 -0700 (PDT)
Received: from ?IPV6:2001:8004:5170:1fd8:ef9d:e346:b99e:7072?
 ([2001:8004:5170:1fd8:ef9d:e346:b99e:7072])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2056912c543sm12224465ad.247.2024.09.01.18.39.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Sep 2024 18:39:27 -0700 (PDT)
Message-ID: <c0b4cb92-30fe-42dc-a245-57d3b3c04b82@linaro.org>
Date: Mon, 2 Sep 2024 11:39:20 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] tcg/riscv: Add support for basic vector opcodes
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240830061607.1940-1-zhiwei_liu@linux.alibaba.com>
 <20240830061607.1940-8-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240830061607.1940-8-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
> Signed-off-by: TANG Tiancheng<tangtiancheng.ttc@alibaba-inc.com>
> Reviewed-by: Liu Zhiwei<zhiwei_liu@linux.alibaba.com>
> ---
>   tcg/riscv/tcg-target-con-set.h |  2 ++
>   tcg/riscv/tcg-target-con-str.h |  1 +
>   tcg/riscv/tcg-target.c.inc     | 54 ++++++++++++++++++++++++++++++++++
>   tcg/riscv/tcg-target.h         |  2 +-
>   4 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
> index d73a62b0f2..7277cb9af8 100644
> --- a/tcg/riscv/tcg-target-con-set.h
> +++ b/tcg/riscv/tcg-target-con-set.h
> @@ -22,4 +22,6 @@ C_N1_I2(r, r, rM)
>   C_O1_I4(r, r, rI, rM, rM)
>   C_O2_I4(r, r, rZ, rZ, rM, rM)
>   C_O0_I2(v, r)
> +C_O0_I2(v, vK)
>   C_O1_I1(v, r)
> +C_O1_I1(v, v)
> diff --git a/tcg/riscv/tcg-target-con-str.h b/tcg/riscv/tcg-target-con-str.h
> index 21c4a0a0e0..a4ae7b49c8 100644
> --- a/tcg/riscv/tcg-target-con-str.h
> +++ b/tcg/riscv/tcg-target-con-str.h
> @@ -17,6 +17,7 @@ REGS('v', GET_VREG_SET(riscv_vlen))
>    */
>   CONST('I', TCG_CT_CONST_S12)
>   CONST('J', TCG_CT_CONST_J12)
> +CONST('K', TCG_CT_CONST_S5)
>   CONST('N', TCG_CT_CONST_N12)
>   CONST('M', TCG_CT_CONST_M12)
>   CONST('Z', TCG_CT_CONST_ZERO)
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index b6b4bdc269..fde4e71260 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -111,6 +111,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
>   #define TCG_CT_CONST_N12   0x400
>   #define TCG_CT_CONST_M12   0x800
>   #define TCG_CT_CONST_J12  0x1000
> +#define TCG_CT_CONST_S5   0x2000
>   

Added, but not used in this patch?


r~

