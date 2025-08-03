Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A0CC87FCB
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 20:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uif3E-0000Wr-Fq; Sun, 03 Aug 2025 16:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uif3C-0000Si-OV
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 16:11:23 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uif3B-0004k3-6g
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 16:11:22 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-76bee58e01cso1413091b3a.1
 for <qemu-devel@nongnu.org>; Sun, 03 Aug 2025 13:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754251879; x=1754856679; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xanaRFiYkmPmJ8LJAkHbPCeXPuFgBRpI2X0giNYkyhM=;
 b=HIKKz0NGBkSYleI53UWu+MlXt6leDVKlro8fKuMgSLG3cttQhzmCdYftiKegBO3iLa
 o6sdCBElmh1gM/UhwKnfusrvveThHCYGN3GG3+9M5TV1tbY5mcU6OhS2/WmawfxVgsdU
 G5diepE9u8josG0NZJuC1c6dL9x4TPBpOpb2bDunFwWhMZywJ+vZiwsjG0H69sTxRLT9
 lAUv9MITNbWXylMJ5fJr3jRfr3A0b595cRSK0dHjlfZ56LEKYIVpTgF4CTsrpwd6BsbS
 kwuFK/t8wjssHgzAjVjhFquNxSWctQZln+LFFRG5jnXbyn2KqkJtNs8EC/oJqE9mdgfQ
 E+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754251879; x=1754856679;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xanaRFiYkmPmJ8LJAkHbPCeXPuFgBRpI2X0giNYkyhM=;
 b=WvQJIVaRB3Bt5JKk3VmVTEPsUv/60zo0uYXlu4zuNkCHA2fD6tBfXXCbL4dlpGbJbM
 fI9n40TeayjZarBeXw/WhkzHfzZXKcaRBgZpMS6PC7aQPcUjvwPmK4rGNPeiamki72fX
 h+OypcMMSC2VxKJe+Zs5iJ32DE3EYSTKERuaJY+on70bwB6fCNllzR88/WVBeVIMI+t5
 oUc7FgRakS3TZfQNys4gteeaAKiso30pw7JD1535l2g6ipis1ALsSAALEjsk59pXrzQb
 UpRQ6G1ksuwbFJ4vKDIJM59mL+0fV/g1lLrBTO4Ym8cT62oCC9y/tDeAY3eHkhDZwTEo
 yPqA==
X-Gm-Message-State: AOJu0Yzwv8aRl8ihpXVXTssxucoJbeXDmmY6gLAMxcfCC8DNlo0eY4w7
 XmP16EmwwuGmul61rCLPMCf858RlbejszfYWNYDjNgGRCv/yPulTAtL7LSPTrgEZ+VSjMEPJJPi
 hhy7DJG8=
X-Gm-Gg: ASbGncsrQJWxfyR/a1k/QmkOd5+HhhfVLUo9Bk90AABBKtz2CrTPlaF1aQbkzPwd/To
 o+J+HOw7jPqWeVQgpPTp3YQWIt6iURJmUQ2eYc7AswFYqPwHZApcv8g5JCKrZPIhzEL4VvR4pXM
 m9vVFaGOWew9m7MNFwzMte8tOaMN6/31y6EOrM5YLFWHP2B9pb9vywqfu56txZroA/pD6o/dzEX
 XwIKGT6mKtqqax+i39vQUdCQxn3a6btgEJEXS8P9TGEBhvBoG1QMNLJpc9vDbBvmCtjhfuuFnhF
 G2D8XT59JcCPet/un55N2qcMSsslz39hjll2N+X0UIyKWWpMa/CQ4Koi4KsF6WTg3TkQ6e9LndC
 /48IaPDVDCtptLgiP9R5PwosIGjS957iO+butOrP+
X-Google-Smtp-Source: AGHT+IHK+5uwfRu26/OX9WKNjQofRQXqjiA3MforOmT/moAcfX0VdvbggCNfVsCsFyaNnDClS7q5cg==
X-Received: by 2002:a05:6a00:1484:b0:76b:2c12:334c with SMTP id
 d2e1a72fcca58-76bec4dbe98mr8415761b3a.23.1754251878973; 
 Sun, 03 Aug 2025 13:11:18 -0700 (PDT)
Received: from [192.168.4.112] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce6f6bfsm8808834b3a.23.2025.08.03.13.11.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Aug 2025 13:11:18 -0700 (PDT)
Message-ID: <9ff0f7da-f3e2-4bb6-8b76-aba7a38dcab3@linaro.org>
Date: Mon, 4 Aug 2025 06:11:13 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 45/95] linux-user: Remove target_elf_greg_t
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250802230459.412251-1-richard.henderson@linaro.org>
 <20250802230459.412251-46-richard.henderson@linaro.org>
 <CAFEAcA8RJ2NKRBL6USCL12kPY_D5C1os0-t57t6aGZHSxkOE2A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA8RJ2NKRBL6USCL12kPY_D5C1os0-t57t6aGZHSxkOE2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/3/25 20:59, Peter Maydell wrote:
> On Sun, 3 Aug 2025 at 00:20, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> This typedef is synonymous with target_ulong.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   linux-user/elfload.c | 29 +++++++++++++----------------
>>   1 file changed, 13 insertions(+), 16 deletions(-)
>>
>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>> index fce4c05674..70a1e402d3 100644
>> --- a/linux-user/elfload.c
>> +++ b/linux-user/elfload.c
>> @@ -131,10 +131,8 @@ int info_is_fdpic(struct image_info *info)
>>   #endif
>>
>>   #ifdef TARGET_ABI_MIPSN32
>> -typedef abi_ullong      target_elf_greg_t;
>>   #define tswapreg(ptr)   tswap64(ptr)
>>   #else
>> -typedef abi_ulong       target_elf_greg_t;
>>   #define tswapreg(ptr)   tswapal(ptr)
>>   #endif
> 
> Previously we had target_elf_greg_t:
>   * for MIPSN32: abi_ullong, which is 64 bits

MIPSN32 is a mips64 target.

>   * for other TARGET_ABI32: abi_ulong, which is 32 bits
>   * for 64-bit archs: abi_ulong, which is 64 bits
>   * for 32-bit archs: abi_ulong, which is 32 bits
> 
> Now we have target_ulong, which is:
>   * for 64-bit archs: 64 bits
>   * for 32-bit archs: 32 bits
> 
> So the two TARGET_ABI32 which weren't special cased
> (hppa and sparc32plus) will go from a 32-bit type to a 64-bit
> type, won't they ?
> 
> It wouldn't surprise me if this is a bug in the hppa and
> sparc32plus cases, but if so we should say in the commit
> message that we're fixing it.

Neither sparc nor hppa implement core dumps so far,
so we can put off considering them.

Perhaps the commit message can simply be expanded to

   For the set of targets which support core dumps,
   target_elf_greg_t is synonymous with target_ulong.

?

r~

