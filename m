Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 781A9C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 12:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZrrw-00012W-4R; Fri, 02 Aug 2024 08:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZrrt-00011v-PX
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 08:58:49 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZrrs-0003Nz-5t
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 08:58:49 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2cd5e3c27c5so5643035a91.3
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 05:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722603526; x=1723208326; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BdrIrSvxSG0D/0gD2xrHW0aNNpXztW+srY7Y0IIKG8E=;
 b=DBGy4o7TqtUYCX4XlGk2lT6Cf/JWMPghRpyF0jZL4TLu72ZBWjAarww15Dx+6A52ov
 OVmyig4p/yJIZ1qNb4EB0AZazjNVnAcV9sbjiSmSv2WRTl5er4GP+/O3xyTR9kIdZi7G
 /uuXT4+Ruo8hTiXHjdoW1v0y0XVgV1uwsFQ94wXagz2RrvreM3K3dm51xFjJ9Xp1izBn
 eMM+ftO/tiLeDHn1jDKC0vY5fA2RFkH+qeYLn4h2jS84cUuWv1mIoSYtP2XwR2KtSTKd
 YOOmBZ0bT2vut0Tn7jpCC6xqXnjxTKR7WuoFS0/LNgm0hP4V2X6cOR7mFf7iScRIVxuc
 GeKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722603526; x=1723208326;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BdrIrSvxSG0D/0gD2xrHW0aNNpXztW+srY7Y0IIKG8E=;
 b=My8bOMiqjwJkwSjE9Ud2oXJOxP7COKYIKF4ZNYKcgJ8qk2abONUy1WXZmDfVTMva9y
 3D2C89JVG4BOIBJRxI9BUz7aUMqeN0a0gf9pDiHBanHs8te6ZGefb4d3EAmYTI8YEqQv
 Wi6skSrkSizqpKw2EJGVOAlLHE0bx9wbw5v/MJ1z+PcRNAprYlEtIaUgOlhLHsB1vXXp
 eUPDcSOiTeu686PsbgSS2WuCmKSPfc3UraYLlDoZNdYvpLwo1RFRUoub75tYqyXOba2o
 V2LZGfeYDeIY8yzQT4BQYLEa6eQ4UDTYCOpCVFWFsYYKTYqrVCPZ4z1OIZ8Ww0p7GwMh
 omPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw0DiPKn1dVHzWJJzRrGe94bRA5BQW3DlX6enalzoX49jliP067UF3voaf6uKy9DPDB09q9SvBS7KmRAFZnJ5Ob20DIIc=
X-Gm-Message-State: AOJu0YyMfjv06f5nTbZ8gveE7XZx8Ly2ZFix17Fa2FyEZ6ZduzPrKjNZ
 PlNtWQLxoe5EQEsoiyHdIgXy7CwojbdfT3ZvGAOufo7posIZlcxDj9VSBObUB6A=
X-Google-Smtp-Source: AGHT+IF+lGoA5JgCY/zlUC39faAxvGB+rvArFVumCkJuNTT4hyfuXKAL+Pt2QZ67L7rX/TPfflB3Yg==
X-Received: by 2002:a17:90b:4b87:b0:2c9:6a38:54e4 with SMTP id
 98e67ed59e1d1-2cff9546780mr3665456a91.41.1722603526056; 
 Fri, 02 Aug 2024 05:58:46 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cfdc42fa06sm5142661a91.16.2024.08.02.05.58.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 05:58:45 -0700 (PDT)
Message-ID: <861d9ac6-2cd4-4831-91dc-850eb146c9a2@linaro.org>
Date: Fri, 2 Aug 2024 22:58:37 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/18] bsd-user: Implement RISC-V CPU register cloning and
 reset functions
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark.corbin@embecsom.com>,
 Ajeet Singh <itachis@FreeBSD.org>
References: <20240802083423.142365-1-itachis@FreeBSD.org>
 <20240802083423.142365-4-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802083423.142365-4-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 8/2/24 18:34, Ajeet Singh wrote:
> From: Mark Corbin <mark.corbin@embecsom.com>
> 
> Added functions for cloning CPU registers and resetting the CPU state
> for RISC-V architecture.
> 
> Signed-off-by: Mark Corbin <mark.corbin@embecsom.com>
> Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
> ---
>   bsd-user/riscv/target_arch_cpu.h | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/bsd-user/riscv/target_arch_cpu.h b/bsd-user/riscv/target_arch_cpu.h
> index 5b436b2ac9..53db790517 100644
> --- a/bsd-user/riscv/target_arch_cpu.h
> +++ b/bsd-user/riscv/target_arch_cpu.h
> @@ -130,4 +130,18 @@ static inline void target_cpu_loop(CPURISCVState *env)
>       }
>   }
>   
> +static inline void target_cpu_clone_regs(CPURISCVState *env, target_ulong newsp)
> +{
> +    if (newsp) {
> +        env->gpr[xSP] = newsp;
> +    }
> +
> +    env->gpr[xA0] = 0; /* a0 */
> +    env->gpr[5] = 0;   /* t0 */

There is an xT0 define too.
That probably obviates the two comments.

With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

