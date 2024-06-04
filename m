Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B71C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 08:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEPac-0006fM-8A; Tue, 04 Jun 2024 04:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEPaa-0006cj-2X
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 04:32:16 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEPaX-00023l-VG
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 04:32:15 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52b88740a93so4340419e87.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 01:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717489925; x=1718094725; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/1a337iNofICn0QfdhI1pB964tcmSA9D/L4nvkO2Y4Y=;
 b=sY3UnUd+/Gpun8ceWGbVo7xZnj0DgRUYFci8F/Uy4ING5ccRMcUhRJLIyh5LoCDXyX
 +NJ3iNZ5VeJs4LN9tdBWKOqh1LN8m1qK2xkl21s8cnIDClvYLhKnNZQsXHh6nZZZqgeZ
 bnMzJfAoK6UeJ/09SW1Jk8jqosvyi3ujN8MsK4NNbEjZyaegQTCL5rfhEwxF8eq7OzU/
 alPO0jUnFABlGw4bZYohn59qkR6spw1OwUtMMaNehqr3Iyb2BMt0DnwRhGGR4Z5Dsbyg
 4acX2CqxlEraf1uzyh4rf4NUByoiMg4okhDtAr2MFpwjDKyTtC08EGWxxrqzGqplS23X
 4Oxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717489925; x=1718094725;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/1a337iNofICn0QfdhI1pB964tcmSA9D/L4nvkO2Y4Y=;
 b=kyxeeuJr6d2VkprkVNelw83vYCpCAkr3kLp6ScwT3Hm6z6k/yTrIHdRKCOMAgPPLn4
 eWuCtFXIcITMpNUR5UcHrssbGLO8ISzkoty5AAA1g38IdDA6EX4bpFhyLbo5EK1eqiMc
 +8Onw+Ch5fDZIL0dTo+rtwe2XGZ4Cl45e5UZlLvOca4K92iR7plYaQalztwXi6/12JOJ
 W1tK++NnQsnHIhcEKGLaVirjys63a1knw6HWIIXwkC+Xz6d+ZN88rtyrxueu1OE0Gli3
 DBfC0zO7ZpL4frRZlYiz3/cyUUdnbS8lIoc7YLQEiuCxc0MI96DkWNnEYjRtLXfZs5kY
 4K7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCy2v910NlVFq4UNWx8e3Or9Ttmu/5+OFkg0RNMcfYmLnBPr/BpImXCR+2xs3NN5f2b9uvLMpE2v2oqpEQW6S+FG19rcI=
X-Gm-Message-State: AOJu0YyKvZoTVkEW38fR8VvSbsb+1pr95idrCCFf6Q6Oj8oSVlTJBLj7
 ACMEDefI1PdhzuSFrBdIiakfF+zltrbrHPcZNN4MoT7OtP8zNQuYiZ7ev39IhN8=
X-Google-Smtp-Source: AGHT+IH2iKrNHyHJGPlbkNij/pGgxYAsxPkOf0mZDqaTEoh4unGnA7rUYo+QTFHpw64W/rU811ETHQ==
X-Received: by 2002:a05:6512:54e:b0:52b:81de:1126 with SMTP id
 2adb3069b0e04-52b896bfb5fmr6616015e87.49.1717489924947; 
 Tue, 04 Jun 2024 01:32:04 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04d954fsm10728778f8f.52.2024.06.04.01.32.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 01:32:04 -0700 (PDT)
Message-ID: <681cf91c-dec7-44ab-91a3-efb6decc98e1@linaro.org>
Date: Tue, 4 Jun 2024 10:32:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: rvzicbo: Fixup CBO extension register
 calculation
To: Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@dabbelt.com, bin.meng@windriver.com, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>, fabian.thomas@cispa.de,
 Bin Meng <bmeng.cn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240514023910.301766-1-alistair.francis@wdc.com>
 <14e88990-963c-45ef-bf51-662d54857c6e@ventanamicro.com>
 <CAKmqyKP5dwLnvuXDbJkDV=CCGAsoVuyES7m+NB=7KceFEHoKzQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAKmqyKP5dwLnvuXDbJkDV=CCGAsoVuyES7m+NB=7KceFEHoKzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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

On 16/5/24 07:09, Alistair Francis wrote:
> On Tue, May 14, 2024 at 7:11 PM Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
>>
>>
>>
>> On 5/13/24 23:39, Alistair Francis wrote:
>>> When running the instruction
>>>
>>> ```
>>>       cbo.flush 0(x0)
>>> ```
>>>
>>> QEMU would segfault.
>>>
>>> The issue was in cpu_gpr[a->rs1] as QEMU does not have cpu_gpr[0]
>>> allocated.
>>>
>>> In order to fix this let's use the existing get_address()
>>> helper. This also has the benefit of performing pointer mask
>>> calculations on the address specified in rs1.
>>>
>>> The pointer masking specificiation specifically states:
>>>
>>> """
>>> Cache Management Operations: All instructions in Zicbom, Zicbop and Zicboz
>>> """
>>>
>>> So this is the correct behaviour and we previously have been incorrectly
>>> not masking the address.
>>>
>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>>> Reported-by: Fabian Thomas <fabian.thomas@cispa.de>
>>> Fixes: e05da09b7cfd ("target/riscv: implement Zicbom extension")

Reported-by: Zhiwei Jiang (姜智伟) <jiangzw@tecorigin.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>>> ---
>>
>> LGTM but I wonder if this is the same fix as this one sent by Phil a month
>> ago or so:
>>
>> https://lore.kernel.org/qemu-riscv/20240419110514.69697-1-philmd@linaro.org/
>> ("[PATCH] target/riscv: Use get_address() to get address with Zicbom extensions")
> 
> It is the same fix!
> 
> I somehow missed that patch at the time. Sorry Philippe!
> 
> I'm going to merge this one as it includes the details about pointer
> masking, which I think is useful as that's why we are using
> get_address() instead of get_gpr()

Fine by me :)

> Alistair
> 
>>
>>
>> Thanks,
>>
>> Daniel
>>
>>>    target/riscv/insn_trans/trans_rvzicbo.c.inc | 16 ++++++++++++----
>>>    1 file changed, 12 insertions(+), 4 deletions(-)


