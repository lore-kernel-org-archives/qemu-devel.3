Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE19C36001
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 16:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuvyn-0003vR-Vy; Wed, 19 Mar 2025 12:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuvyE-0003cY-1k
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:08:43 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuvyA-0004cD-4W
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:08:41 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-223594b3c6dso157264165ad.2
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 09:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742400513; x=1743005313; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9ggNZfnQdXNYbUp1B/xCgKD+zHGOqcTA/82gv/CfJCM=;
 b=wHDh22no9q8w0nn3xCa1B5+pD7w/4gHFMST/2SEi1adjJTaKbQY30MGJxh7HrGpCo1
 see6za0kVM44vIsUWMUBNPnqSFNUatyEXMmDhyqb9y3gn4j/95Bhql0+JG/aOQjfv16/
 sL0xM1amBAvIGiSDEFB3Fose1Yr+HaNhXhIqrFI2VyFR64XB6pJO9Rai8fj9gZzUmlcE
 7yMJMvnrUaK8qGmCNZhhf0ENDhClLwarTwXgSSAFf6jPsyM6PQ6Y+WgQcp+szxywPFZs
 29izW9Nnxly42Bjr/WBnCs994BC0SNoF2yN49pq2+kV9us4Eyn1uzD08vMBkcKsW1/TG
 xttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742400513; x=1743005313;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9ggNZfnQdXNYbUp1B/xCgKD+zHGOqcTA/82gv/CfJCM=;
 b=CpfutWdWYiyPthKVauFJK06atgbGwaXZu6Di+oMmCBYoKWP3S4TzLJbs1u6jAeChDl
 eDiOpwju97m+d4nGau2fnvFXt84w8t/C3S2JOE36D6Cq54igMN7t6vZTEg/ZBaNuFZ0W
 bdiUaMAQK1ZKIQQLOICS8YU6syLP0wckD2+d9GOn0lXRTeHnewSijsTm65pykZmbeafy
 n0ZQW6Kh9vH2S01uho1V/nS5/682376jLhArjdR8VhCFhFlO4BelH0tTWRAJb/2c8+fM
 IcNVmtd8vHF6M9WJJgwyK4DvZSBsp171tOLwNmwxb5fjcA8IAvSKdVel6H3fAFrMtcvF
 z4sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGTrPonI7tljE0VPQLXPzhOxoPSxqOAnTyalRFlf//psb935XFZ3J+wxQCurs3qxZ2KplZEIW/3+Oh@nongnu.org
X-Gm-Message-State: AOJu0YzrWF3Y8zi0oypGgFMVigWIZJAotiOiZSkmsOuYqku/A931JnFV
 8TmYk3Gh0iNv/c+rHCTdgK9VLnJVMnzNQrtNolAAvwfN20yQm/G9AIwna0upBdU=
X-Gm-Gg: ASbGnctZr66CuQYnRFjxemFvDACEJFamQE1iNABD20bsqXlu8qV2ykB3S+B408OM4Vy
 WjGSqSrVkvKukmRWy6iuJkXbGfcPW4Piozxx2S4SvMkG+wdN7TSzomHYZXTmUzN87uol+Xca2nD
 q5xZBf3Qynx7ddSoLXVA9khpnSZwryL8yYeXx2Qxe2racht5iGUFy+TZIz1vBTIGiNKqRA9N0PX
 o4cYsaVzErMnmypeElvy4xrLw4LaoEeXnCkDsH/liwSKZhN5xmMd3PbD2Axf7DUTxs29ptBqhLP
 EB7HBW+dZCJNPOATF6VqifkVQkmBv2QgSOwVS4rdfgY3GEF6Bg7s4+suWLlrkVIpcquKX0pz2Ml
 Or90inCZt
X-Google-Smtp-Source: AGHT+IE0XHLlJ8P7cf0gdsJa0UdG6xhxpPzq/dVCsvoUbFdHQClhaFmgDnjJtMUYistPnl6dVOmClw==
X-Received: by 2002:a17:902:cf0c:b0:223:54e5:bf4b with SMTP id
 d9443c01a7336-22649a387e1mr53215715ad.25.1742400513167; 
 Wed, 19 Mar 2025 09:08:33 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bbe5a2sm116503485ad.196.2025.03.19.09.08.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 09:08:32 -0700 (PDT)
Message-ID: <d077759f-f3a8-47b2-9e6a-34360042a1de@linaro.org>
Date: Wed, 19 Mar 2025 09:08:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 01/12] tcg: Declare TARGET_INSN_START_EXTRA_WORDS
 in 'cpu-param.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250319134507.45045-1-philmd@linaro.org>
 <20250319134507.45045-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250319134507.45045-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 3/19/25 06:44, Philippe Mathieu-Daudé wrote:
> To avoid including the huge "cpu.h" for a simple definition,
> move TARGET_INSN_START_EXTRA_WORDS to "cpu-param.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/cpu-param.h        | 14 ++++++++++++++
>   target/arm/cpu.h              | 14 --------------
>   target/hppa/cpu-param.h       |  2 ++
>   target/hppa/cpu.h             |  2 --
>   target/i386/cpu-param.h       |  2 ++
>   target/i386/cpu.h             |  2 --
>   target/m68k/cpu-param.h       |  2 ++
>   target/m68k/cpu.h             |  2 --
>   target/microblaze/cpu-param.h |  2 ++
>   target/microblaze/cpu.h       |  2 --
>   target/mips/cpu-param.h       |  2 ++
>   target/mips/cpu.h             |  2 --
>   target/openrisc/cpu-param.h   |  2 ++
>   target/openrisc/cpu.h         |  2 --
>   target/riscv/cpu-param.h      |  8 ++++++++
>   target/riscv/cpu.h            |  6 ------
>   target/s390x/cpu-param.h      |  2 ++
>   target/s390x/cpu.h            |  2 --
>   target/sh4/cpu-param.h        |  2 ++
>   target/sh4/cpu.h              |  2 --
>   target/sparc/cpu-param.h      |  2 ++
>   target/sparc/cpu.h            |  1 -
>   22 files changed, 40 insertions(+), 37 deletions(-)
> 
> diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
> index 896b35bd6d5..ed1f0b16e51 100644
> --- a/target/arm/cpu-param.h
> +++ b/target/arm/cpu-param.h
> @@ -38,6 +38,20 @@
>   # define TARGET_PAGE_BITS_MIN  10
>   #endif /* !CONFIG_USER_ONLY */
>   
> +/* ARM-specific extra insn start words:
> + * 1: Conditional execution bits
> + * 2: Partial exception syndrome for data aborts
> + */
> +#define TARGET_INSN_START_EXTRA_WORDS 2
> +
> +/* The 2nd extra word holding syndrome info for data aborts does not use
> + * the upper 6 bits nor the lower 13 bits. We mask and shift it down to
> + * help the sleb128 encoder do a better job.
> + * When restoring the CPU state, we shift it back up.
> + */
> +#define ARM_INSN_START_WORD2_MASK ((1 << 26) - 1)
> +#define ARM_INSN_START_WORD2_SHIFT 13

This does not belong in cpu-param.h.  This is private to target/arm/, and should probably 
be moved to internals.h or translate.h or some such.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

