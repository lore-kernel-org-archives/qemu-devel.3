Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE1FE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 21:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVdmk-0005eJ-D9; Wed, 08 Jan 2025 16:40:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tVdmh-0005e4-2u
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:40:15 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tVdmf-0000ox-7p
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:40:14 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ee397a82f6so456780a91.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 13:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736372411; x=1736977211; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A8AgG+IBWMAblistbvndOjvBrQv6N59gJ/8ddMArDsI=;
 b=nmckedomWTAe1dQk3TN0muNen2sx+GM+3JrAE4Yl6cXD6ZC0Ce6Ahzfl7lnXDs5pJg
 2bsM8DDw1LDy0gF8zWvNapwJJn3qKiPpR6M92lps607yuuD1Y5RzhytVK+Uy2cm2O2kg
 hs0RTyIseVik7fJwA9zrTqGeZAltWAGJwvbDuLQUdkwD65DwyDWp3+1u7hEmlqeGyhgO
 aboJW0Qg5tm23MjKnIkMBVOHZutdo89YTr9tb85urNqEqk6duK1BWFSscPFJeDHPBlp7
 ggEWdnIbOlA4RBYeVFWnI7+t8ADhrzljFYOI1mVD78RiXManjl5ksALmVfd14i7RHNpU
 Obhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736372411; x=1736977211;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A8AgG+IBWMAblistbvndOjvBrQv6N59gJ/8ddMArDsI=;
 b=L0DYDzLeX+IUZ5QL80J0aQzRzJUQdK/UlShYlKofjRoEHhlYWCs9tNguhIjYF1uPPw
 rVM5t/jhQqusUJ6s5/1f9OY43dFlerB4EPQUcV1IUHAy14lmXxycbOnCiGgLAxwgQQRk
 rMwkCmEE+xQqUessLiVt11HI1Ot905Nt7VhGzd4JzTHS6VZjZ1qSusUoZeyVjaTmykIn
 k5WMOziOCOhO6vxz5xO47n40lFLW7SxQLK7is6oWGtdH5UrNjyyA0b7BWNCiimebkiPF
 6ONCV5KTIzkroHE3GZKDL4Xb/R4lw4NhvCaE+m+G1H041HCVviPj5B76WAMnU6OUznPP
 FXEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXh6Am3Ed/Tyr+UvPDfBfR2uuTxt2olOz+gMa95cMYQSLLL8QwKeyXWXX9IieXXU+t1aXAlks3KClTd@nongnu.org
X-Gm-Message-State: AOJu0YySEyf7qXLROYWAeJRoT0i16ac7+SxE+ZA1vyjO+5dKDzUo0J4b
 8O27artrnxUUfINKC0UkGd8a5hLvVPbEpiyNhcSwpx0CEA9jZiInd3NRQs/O2kE=
X-Gm-Gg: ASbGnctKmQIkWqJ7YCc6JwTBtlXoL4lf7JrJoppug4Mt7Rxh3tRTr1us4YddomWmkDg
 Khc+ItsMO3MiWTeVtFL+2u2drZDZ+8n/RhiLHz6uRTaJxZna0iYKoZvNy3p3tCcXz+qCf8/OrHx
 cj+cpZi1LoyaC6lTIee4XBy/15dKVtzOQkERaHcwzge2c331hYlrHREqX0yFXCfZUdGhz40Cgyb
 WpfGRVXPdQrILho/CMLiPSgIWA7nR1VXUTGC/CzJMG3LxADOMuSQa1zMAWzGA9vTZtIhioRs6mf
 WNyPsrtQXDpBkZHAtoNKaohx1ua+sHc=
X-Google-Smtp-Source: AGHT+IEWeUDwmoRGme7NitWsZCilzyBGfzPcLn5dN3qlqRW69J3k/enMTJnikl3BkinWaBiD7zd4iQ==
X-Received: by 2002:a17:90b:524d:b0:2ee:c9dd:b7ea with SMTP id
 98e67ed59e1d1-2f5490c20c4mr6791833a91.24.1736372411259; 
 Wed, 08 Jan 2025 13:40:11 -0800 (PST)
Received: from [192.168.132.227] (76-14-228-138.or.wavecable.com.
 [76.14.228.138]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f54a26590bsm2089559a91.4.2025.01.08.13.40.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 13:40:10 -0800 (PST)
Message-ID: <7acc5d65-61d1-4fd7-a6e1-9a84997adae4@linaro.org>
Date: Wed, 8 Jan 2025 13:40:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 55/81] tcg: Merge INDEX_op_and_{i32,i64}
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-56-richard.henderson@linaro.org>
 <9fb636d2-3abd-4dd8-983b-b6fe65fb2f15@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <9fb636d2-3abd-4dd8-983b-b6fe65fb2f15@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 1/8/25 09:53, Philippe Mathieu-Daudé wrote:
> On 7/1/25 09:00, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/tcg/tcg-opc.h    |  3 +--
>>   target/sh4/translate.c   |  4 ++--
>>   tcg/optimize.c           | 40 ++++++++++++----------------------------
>>   tcg/tcg-op.c             |  4 ++--
>>   tcg/tcg.c                |  9 +++------
>>   tcg/tci.c                |  5 ++---
>>   tcg/tci/tcg-target.c.inc |  2 +-
>>   7 files changed, 23 insertions(+), 44 deletions(-)
> 
> 
>> @@ -1694,8 +1693,7 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
>>       TempOptInfo *t2 = arg_info(op->args[2]);
>>       int ofs = op->args[3];
>>       int len = op->args[4];
>> -    int width;
>> -    TCGOpcode and_opc;
>> +    int width = ctx->type == TCG_TYPE_I32 ? 32 : 64;
> 
> Some places (like in patch #10) you add assertions and here you remove.
> Could leaving the switch case help if someone hypotecally implement for
> 128-bit hosts?

You're right that I probably should use tcg_type_size or something.


r~

> 
> Anyhow,
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>>       uint64_t z_mask, s_mask;
>>       if (ti_is_const(t1) && ti_is_const(t2)) {
>> @@ -1704,24 +1702,11 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
>>                                             ti_const_val(t2)));
>>       }
>> -    switch (ctx->type) {
>> -    case TCG_TYPE_I32:
>> -        and_opc = INDEX_op_and_i32;
>> -        width = 32;
>> -        break;
>> -    case TCG_TYPE_I64:
>> -        and_opc = INDEX_op_and_i64;
>> -        width = 64;
>> -        break;
>> -    default:
>> -        g_assert_not_reached();
>> -    }
> 


