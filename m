Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9D5C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 08:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnZfL-0002nb-KI; Thu, 27 Feb 2025 03:54:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnZfJ-0002n5-FS
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 03:54:45 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnZfH-0001KN-1c
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 03:54:45 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-438a3216fc2so6676925e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 00:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740646480; x=1741251280; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z60gqmVupRyv8bYgjGl9QykHfjVgRaaROSY0nuZNdtw=;
 b=KGnqtaMN1yix8frvF8hSgdLiCRbC7OYsuBlcfRDW3+D481iiN4v4tOHRWaBAKd/jhQ
 BqvvndyO6oSFqobGkXp7Fw8Edo+OYri3nf3BzedsVl9s/KjmKxkzDiC8bJZsUOCk/+sp
 ax+5WKruPLV5zsZdkZ+w8Rg8/Ec9tBY4ZhtD8Yqbdlryu4ch4VFlGXEWENSb0ccDOA9I
 /nn19RBqYqa9wiNlchELaSlK8aLbaS4ZJ4nGBMr80RpSpAEzSgw5D7CBdpKQ9nwB9pTq
 zu5pLw8B9J8TJ21zWUZGPFvlYxFM3Z53BCKEDE+79bbOFlYFPG1ilryMWRCDUscvH5gm
 Ebrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740646480; x=1741251280;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z60gqmVupRyv8bYgjGl9QykHfjVgRaaROSY0nuZNdtw=;
 b=txZNpc+ALvSZbsWtgYbaEOArqKBAuOfJUOkx2o05QkBA+RZ8BVMmE0u9Ss7nCUZgYy
 kGWEMmVqNKw4yW4LaIzu/bXAk0V1K+Krnoi4+wKac1Y9j1r2KqzcfuhwVgOHr1Zqd03D
 4IM/WBkDiIhBJxt+BtgdKNgz0mbHPsffHkabGROwfEptTxSRGgJaxSr2r198rEbnHhPX
 zjRBdBrpZJxp11V2ectivodE4KkdRzSEZUaiMxivezIcovlhWHIxjoa71Tzj92B0HByS
 hZGRE+XXogGEK76RNIaMYnwd9nbbh8auCmq3TWap4szyrdDwr7Ov8FET3+LHt147sglt
 HIbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoKW+dTb46jY46hb2yqdoQITFpfQVAzsa3BYbeYB0e7J/kdH+wjvNGtG3Ro7YDYgEhzsGnlhlrKsks@nongnu.org
X-Gm-Message-State: AOJu0Yw6u7nYr4Be+JllrdDqwypDofdUOW9cp0qWr2huJ2vapuRvpn/7
 bYliQvAFT7EwhutMVpeowVw1mm8Fobfzsxx3CKGzqor/JU//S2Hh9I578+MjASc=
X-Gm-Gg: ASbGncsCjz4yg/LyLSR7vOwbQVXwgy5LFwveqw0gKbXUJ5pVsd7RXrByuf1NAzj60/T
 5nvnf4ynZ2wpiEzWX/6BfL02OQ9lhpfza+2AUw2peLZ5C63ZomblLFCmhxvvrg+Pcd3cd+OId1A
 wK9WRia6EFchVW3oxyvpuwsZVPKwM69qZLGs9FCZl+GsDefI+qFNh6Pej0aU66egu3tLAR8AJDt
 r9gYqJd+DhrqIHUa4wgH+qZ0bmQNzgm6VBqiSyvBWMQLO7RpnKJjGuXH1BhxMVu2VcOsPsPW/KK
 R27u/vGE/IVEer/g4r6UmDntgPg//dEU3SB8D+RVPkf4wRbFxpA0s24fUOn1BE7imAdLIg==
X-Google-Smtp-Source: AGHT+IGJUOAh60oe4DFjrVsnmUVfpzMmylsiByP4RvJq3ByFeqmoZvxspk+EDnB9MJ/DZ9CTH36O2A==
X-Received: by 2002:a05:600c:5489:b0:439:86fb:7326 with SMTP id
 5b1f17b1804b1-439aebb5558mr176748375e9.22.1740646480066; 
 Thu, 27 Feb 2025 00:54:40 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba532c49sm46718975e9.16.2025.02.27.00.54.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 00:54:38 -0800 (PST)
Message-ID: <681b4df0-0e89-4ba2-9ad0-edae330b23f5@linaro.org>
Date: Thu, 27 Feb 2025 09:54:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 030/162] tcg: Convert neg to TCGOutOpUnary
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-31-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-31-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 17/2/25 00:07, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c                        | 20 ++++++++++++++++++--
>   tcg/aarch64/tcg-target.c.inc     | 18 +++++++++++-------
>   tcg/arm/tcg-target.c.inc         | 14 ++++++++++----
>   tcg/i386/tcg-target.c.inc        | 16 +++++++++++-----
>   tcg/loongarch64/tcg-target.c.inc | 19 ++++++++++---------
>   tcg/mips/tcg-target.c.inc        | 18 ++++++++++--------
>   tcg/ppc/tcg-target.c.inc         | 17 ++++++++++-------
>   tcg/riscv/tcg-target.c.inc       | 19 ++++++++++---------
>   tcg/s390x/tcg-target.c.inc       | 22 ++++++++++++++--------
>   tcg/sparc64/tcg-target.c.inc     | 15 ++++++++++-----
>   tcg/tci/tcg-target.c.inc         | 13 ++++++++++---
>   11 files changed, 124 insertions(+), 67 deletions(-)


> +    case INDEX_op_neg_i32:
> +    case INDEX_op_neg_i64:
> +        {
> +            const TCGOutOpUnary *out =
> +                container_of(all_outop[op->opc], TCGOutOpUnary, base);
> +

      /* Constants should never appear in the first source operand. */

> +            tcg_debug_assert(!const_args[1]);
> +            out->out_rr(s, type, new_args[0], new_args[1]);
> +        }
> +        break;
> +
>       default:
>           if (def->flags & TCG_OPF_VECTOR) {
>               tcg_out_vec_op(s, op->opc, type - TCG_TYPE_V64,

Easy one!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


