Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2119BCAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 10:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Myh-0005AI-Vw; Wed, 24 Sep 2025 06:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1Myg-00059p-4Y
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 06:44:02 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1Myc-0008T4-Q3
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 06:44:01 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46dfd711172so25815855e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 03:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758710634; x=1759315434; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nji9yyYky8rAiTvrwcFVWvAZRmkN9aZ2dHZq9spdqps=;
 b=SuAYnI7iyTCK9SnwK/97Y3T+aQD039xRfP/9oCM2Co/nhi1Z+UOZGhn7Yw5NhByPCv
 j4j1MIE/YfdZ3VM56abyeLVOHkp5p4YeCP2g95AF6mq31vBO+rBtgS1h5UUWSmmCCE63
 wk6sAo6CQeJfyjJxUR5vXr7PJ2WPjdDuJfGjAfUX5HpKdn+nd3QQEtOC4WNUGZkxFjUC
 NbcwuUgN6N5L0/xwRbJfT+siy+z9G5btfZtDG7qHQE5J++w/sQt5upZtMQQVH0j5lINU
 ItE3X1QZZBqiJn+NNp02HiTk1Sfja8G3Qqy3w88SKQp6A+v/YUkdI//6rMjltxCZtD9H
 08vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758710634; x=1759315434;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nji9yyYky8rAiTvrwcFVWvAZRmkN9aZ2dHZq9spdqps=;
 b=ow9pTV65Gv6ubVZstUSCPa9cXcUaopDGOjvyvSK3vdj8bGy/EBtdkErm6l+4SB8JWT
 3VF5TbXA8+2tmHMHaMe9M2LEYFBnxmGYCAx14lY0XPDsj2nnaWkdHce1x4qfbCLO7gqC
 Z5IbEfZRnhF0R3Hsmdh++VUQwPmh+OJZklokimpqeXa0A91FNIOWmFbTRV6r5VCKA9iy
 yILayMVHENAfhpJcY4rcza4OnH4XX/qnY1eGAMs+svg3p5YEPGm4nv5XDX/aKlBnFyqP
 8V6upHm2CySPk/bF+aIw4ezkLhefWigDSmkVSVlnyjy4d9ZvM+Z5VxQO1QJZOBdXlwrJ
 sG+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyQM5zM3UOngwcEZpj0lwW5/AQq/RGIZ3DVrFvXLJEFqfIsH5ugkQm2k3xuzPF1m46anFzyV7fcFsC@nongnu.org
X-Gm-Message-State: AOJu0YwOB/L/K9YdOjfp+1ebVLi/EtoyznNiP6W7LQxlJioBqE1KdzMC
 JPoQ5OtxWXXdW8imaB0Nqv+xUJqr4iYL02ATp9QVmyBmkxYTNGxVAeTlfu8VGg1ulck=
X-Gm-Gg: ASbGncv0JG6Rg0DiBRW3BwvdzdLHHaffJjJRR3S/Ai4VMUDfgimfbSssA0NZfCB1Utb
 U7FBU0/qltxrRGhlu1Oj1lQxWjYYyFmo7lX83Kpm+HroXhEYFPKgeoGIdyhBjZL0GxB4PSls5+g
 ZxDMxhtgTL45z2sKNcDwpnxFvcczXqZ8/RVg4yyG1svecRmmwY0Ni5KMmmDpw1Y32/YNjyIR+tx
 1EQlsAc8USVHTMWWuFtble5AA8HEKFjPkcmtcbWjPvHZxio6W7K9Xpdw4L2FkY1CvZch2HmSLdq
 MV8y0OdvXmdFW2onJVdYYGSV0kIGaI8TR0nBxg5iYKnTed9i4LHLxNeZ04FWY+33l8CKAVXaFGj
 MXg3Jg9F4imKf9ayrD7WKqRr1Kuyj1NGavp1TQQirRUlHPuqAqfIJcg4c0jL6/VJ6rA==
X-Google-Smtp-Source: AGHT+IHPYrektlnhZfomQXYmLob7r1Z7oSdIj7Hy6E4JyNEwU1Cu01uEqwI4WLwi9bmNQ0QliPfibg==
X-Received: by 2002:a05:600c:322a:b0:46e:1deb:fcb7 with SMTP id
 5b1f17b1804b1-46e1debfe32mr34177245e9.11.1758710633672; 
 Wed, 24 Sep 2025 03:43:53 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2a998314sm31315315e9.3.2025.09.24.03.43.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 03:43:52 -0700 (PDT)
Message-ID: <551c2907-32a1-401b-9ad6-2994bbbbe6cf@linaro.org>
Date: Wed, 24 Sep 2025 12:43:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/34] target/riscv: Use 32 bits for misa extensions
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
References: <20250924072124.6493-1-anjo@rev.ng>
 <20250924072124.6493-2-anjo@rev.ng>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250924072124.6493-2-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 24/9/25 09:20, Anton Johansson wrote:
> uint32_t is already in use in most places storing misa extensions such
> as CPUArchState::misa_exts, RISCVCPUProfile::misa_exts,
> RISCVImpliedExtsRule::implied_misa_exts, etc.

Also, the field is migrated as 32-bit:

   VMSTATE_UINT32(env.misa_ext, RISCVCPU),
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 4a862da615..a0b2ef1cc1 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -50,7 +50,7 @@ typedef struct CPUArchState CPURISCVState;
>    */
>   #define RISCV_UW2_ALWAYS_STORE_AMO 1
>   
> -#define RV(x) ((target_ulong)1 << (x - 'A'))
> +#define RV(x) ((uint32_t)1 << (x - 'A'))

1u, or simply using BIT():

   #define RV(x) BIT(x - 'A')

>   
>   /*
>    * Update misa_bits[], misa_ext_info_arr[] and misa_ext_cfgs[]
> @@ -582,7 +582,7 @@ struct RISCVCPUClass {
>       RISCVCPUDef *def;
>   };
>   
> -static inline int riscv_has_ext(CPURISCVState *env, target_ulong ext)
> +static inline int riscv_has_ext(CPURISCVState *env, uint32_t ext)
>   {
>       return (env->misa_ext & ext) != 0;
>   }


