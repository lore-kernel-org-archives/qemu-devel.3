Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FA3C25B74
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 10:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8Hc5-0003GD-8X; Sat, 18 May 2024 06:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s8Hc2-0003F8-4Q
 for qemu-devel@nongnu.org; Sat, 18 May 2024 06:48:27 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s8Hby-0002MP-0b
 for qemu-devel@nongnu.org; Sat, 18 May 2024 06:48:25 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a5a5cb0e6b7so572282266b.1
 for <qemu-devel@nongnu.org>; Sat, 18 May 2024 03:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716029296; x=1716634096; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IdCjzgjIzDm9BV1b0g2JHHKgRRD3ycKf0+xho+30EJc=;
 b=IiAVNOUqvMfRUrcBO+1FhwFQ/QPQkQpZAfP+yqmjuID10b9EEuKVWdHqMoi2tLBbeu
 TupqrqO4hFiI/oonVfIIcx2gqDJ6hHRvhJX2KoXpRU47gP+KChh4RDq0xJ+YDrHrCC1X
 zKdH5IvA4269qIYQHI7k3Lt81HXtE0nQO8gHdG0us1h1V28Wr8IX3W8hIJnhkUzhWokY
 mUEcLl3wU+d8yFscyUSn9hkwnjEuNd9j2XRMWD7Kv4Y7vOb4WnwoHaQz+0cv73AyhGlC
 SnzsqAnl/ZQhdDahaPRTVkYJ5dl7RrQv40OQ1iD8ONYGClHA7pjanFQnToPqYh8VVD55
 lDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716029296; x=1716634096;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IdCjzgjIzDm9BV1b0g2JHHKgRRD3ycKf0+xho+30EJc=;
 b=GlzORQi8mGMmbRLc4RfRm1Erc94Bc0c3FGu2+pqy06elu7mTurfvItBja6bjhpHjK/
 HGTwmfdzvIIcuCWy6rv1+fSXv4r7caOsxFbLhy+Lh3WLxIWSeOvPzyxMM19EWMZV1npw
 Vw+tI4tgHDn/pU2TMOVzVtW7h8mTKFK3OHqQYo3qkT+ZAnT60hbCCrkVVTCHSZD1v4hS
 ynVkK1Nps+yrygxGoC8NLF+USUafl69KRjNvhUII+Y6/KQ6CjZwIyvC3lqkqnlcdoOF0
 4MdXSxCKhjKgNxQXWybyz82UUARUOJ2UrGgkIk7lYHBs0CuaI8X5BAm9vugkbJmZz8Mt
 B8Uw==
X-Gm-Message-State: AOJu0Yz65XG8gki2D6ogHO7fcsH0S+0P97x0NVT5LkZkbx+vdDHLLE2Z
 7nsCThAXiLOr1+q4MC6sG9AuuISrC8AD80YFtxK1DAl6kxjdYOvavSkxQZTWKrw=
X-Google-Smtp-Source: AGHT+IFiL0QiCmzHoVZpJd9lkmRR51AZo1hszRClgHTA/6XdXsCgpippP306xx68o3XrPonFZne7Ag==
X-Received: by 2002:a17:907:7e9e:b0:a5a:6367:7186 with SMTP id
 a640c23a62f3a-a5a6367bcb3mr1401421066b.70.1716029296260; 
 Sat, 18 May 2024 03:48:16 -0700 (PDT)
Received: from [10.1.1.126] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b17844sm1207345866b.190.2024.05.18.03.48.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 May 2024 03:48:15 -0700 (PDT)
Message-ID: <eba18599-1e0a-4b57-a728-b5a7847e4f14@linaro.org>
Date: Sat, 18 May 2024 12:48:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] target/ppc: Move div/mod fixed-point insns (64
 bits operands) to decodetree.
To: Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, danielhb413@gmail.com, harshpb@linux.ibm.com
References: <20240423063234.76282-1-rathc@linux.ibm.com>
 <20240423063234.76282-7-rathc@linux.ibm.com>
 <D1BXJXYYCCJF.1KUFFHK83W8CV@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <D1BXJXYYCCJF.1KUFFHK83W8CV@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/17/24 14:48, Nicholas Piggin wrote:
> On Tue Apr 23, 2024 at 4:32 PM AEST, Chinmay Rath wrote:
>> Moving the below instructions to decodetree specification :
>>
>> 	divd[u, e, eu][o][.]	: XO-form
>> 	mod{sd, ud}		: X-form
>>
>> With this patch, all the fixed-point arithmetic instructions have been
>> moved to decodetree.
>> The changes were verified by validating that the tcg ops generated by those
>> instructions remain the same, which were captured using the '-d in_asm,op' flag.
>> Also, remaned do_divwe method in fixedpoint-impl.c.inc to do_dive because it is
>> now used to divide doubleword operands as well, and not just words.
>>
>> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> [...]
> 
>> +static bool do_divd(DisasContext *ctx, arg_XO *a, bool sign)
>> +{
>> +    gen_op_arith_divd(ctx, cpu_gpr[a->rt], cpu_gpr[a->ra], cpu_gpr[a->rb],
>> +                      sign, a->oe, a->rc);
>> +    return true;
>> +}
>> +
>> +static bool do_modd(DisasContext *ctx, arg_X *a, bool sign)
>> +{
>> +    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
>> +    gen_op_arith_modd(ctx, cpu_gpr[a->rt], cpu_gpr[a->ra], cpu_gpr[a->rb],
>> +                      sign);
>> +    return true;
>> +}
>> +
>> +TRANS64(DIVD, do_divd, true);
>> +TRANS64(DIVDU, do_divd, false);
>> +TRANS64(DIVDE, do_dive, gen_helper_DIVDE);
>> +TRANS64(DIVDEU, do_dive, gen_helper_DIVDEU);
>> +
>> +TRANS64(MODSD, do_modd, true);
>> +TRANS64(MODUD, do_modd, false);
> 
> Sigh. I'm having to fix a bunch of these for 32-bit builds. Just
> doing the #ifdef TARGET_PPC64 ... #else qemu_build_not_reached();
> thing.
> 
> Which is quite ugly and actually prevents using some of these
> macros and requires open coding (e.g., because DIVDE helper is
> not declared for 32-bit in this case).

Compare sparc:

# define gen_helper_pdist     ({ qemu_build_not_reached(); NULL; })

etc.

> Maybe we should move 64-bit only instructions into their own
> .decode file and not build them for 32-bit, so we don't have
> to add all these dummy translate functions for them.

That's another option, yes.  The decodetree script will take multiple input files to 
produce one output, so you could separate the insns by base vs 64-bit.


r~


