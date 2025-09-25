Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B239CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 00:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Zlg-0002M3-FI; Wed, 24 Sep 2025 20:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1Zle-0002LX-BB
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 20:23:26 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1ZlZ-0004G9-7q
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 20:23:26 -0400
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b90so270254f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 17:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758759798; x=1759364598; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=45od+RfowEozm3KkW0rCtG0TsUXjQjNE9/V2mzgOnFc=;
 b=RNEAwQ+w3HhqJ1Yj5Qz3mVZvvGIZEc31Xmme1XHjnwW7t7y0lz34rQh8oY7Q3Fls0c
 suCX6qkEM34NsxMQEYytzV/moFUQv2NoxcfYw+0e9kNxmHKkIbOjr72J5RGQwiGU83pL
 rbq4J6pwPrCSAdgWBmL2w8YLqUdUR66ReNeUXA7p8ot/W7lLGmEJL4U+BjKWU0GrPYRH
 foJYmz6QjAIdZefDaeIaJBi3jOfQhslcOvXUjGeYrzTcacyRImVEKldec+qypRCySGiN
 FHdkL6uC5F3oghtR19thEqIfYxkeEjo8SEsV0oRav673NTc918fkusZjThRzhaR5LuzX
 bM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758759798; x=1759364598;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=45od+RfowEozm3KkW0rCtG0TsUXjQjNE9/V2mzgOnFc=;
 b=OCKuolK+7yKy3V4vR/2EpW7zcVb6hLsp9yYKTnALlu1InWQ/vO9uUQlGatfJbZS07b
 bSFA33LuPTuT92xaBNCMAnwW1+6J/dQubZG6yfT1zIzWrPp5YIUVxn0k4wPex0tpPHJ3
 sV/lLUmuq2Jt6DzojU5tU/sTuOL/XTTFxIdFooCTF/nIlpF/uBVHZ7NhBqDV0KDQ+J08
 Bh7lU1eqjl9cUdqxaONApzWjlNw+FWVFeCKfnGaofXpDgp+AQyDGdsRLkKIOhPT2ggwz
 u96t0WGftVDPiU9m8Z/Qa/z8fTBkDr/ZjaKHGL5+tOjnWPsYWZHE2/CEV3HMI1L15Wum
 FnRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNRAfUTmBZwt+cwmcSd/4nvpV4NOQt0XO0C2NB75pw5ogGtR744Kz/hPIKTFWw51b7YSwdmJ2qlQX/@nongnu.org
X-Gm-Message-State: AOJu0Yy2r3658mdpaMStrILCw1QhppuACs+Rabq+rp5ES/fu8Mi5+LiT
 EN5Mf0Q02JKvakNKwFX+tOwgnjkCHjHvwc8Me7DfE1VIdqwRG3/zPOZ4gyJbPjkBfQthS5mgjE3
 XEtUQk6Gukixy
X-Gm-Gg: ASbGncuUkSS5WbO3aFJ52U6MXQadCovT2zNtVczLynoZ19ZuREEABCyAfQLrL1wwk2l
 nMYPjW1XEhvSfL368Ygy8b+AHD+lVd0pY13TQs39i06GOUwYPMeLpAVA/xpsfbbGJfplbJ5rof9
 mh9RIhA/dkBj+4lZlvHz7KI1LGbbYs0chez0wYZTXPoB0Wp4cnGw3L1P0CFDaH2hEPGEnflRIik
 ygnjAHWM2i2Jyp+HVznBkoPx9wt4tknQ/KG7xGBw+tFEp18hbCVGaL45DBGxEchwq4C+ESZV82X
 ySrLJUdSC62URxze4EtJRLiW891kgJJZeC6nmk+BKvXf2AvxejFvWrEedgWQbOpO8H/wsuQcG8q
 Oc78QW7CS/cz1DhP08NO14B7sYHkGcV7xOWp3ge2hSiqpW7X4V+hgfuVbDPEwM8Xfew==
X-Google-Smtp-Source: AGHT+IGuNhmSW4zVPTQfQQSeDlHOQOJ18P8jrXstwXXJnmPgG5g4Vmoib7gsvW2diYoljsE8p1+C7Q==
X-Received: by 2002:a5d:5d07:0:b0:3f1:ee44:8c00 with SMTP id
 ffacd0b85a97d-40e46514ffamr1462531f8f.10.1758759797929; 
 Wed, 24 Sep 2025 17:23:17 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e33b9eabbsm9408955e9.3.2025.09.24.17.23.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 17:23:17 -0700 (PDT)
Message-ID: <fffc64b1-f17b-4c90-831c-b82fe3449484@linaro.org>
Date: Thu, 25 Sep 2025 02:23:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/optimize: Fix folding of vector bitsel
Content-Language: en-US
To: WANG Rui <wangrui@loongson.cn>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu@hev.cc
References: <20250919124901.2756538-1-wangrui@loongson.cn>
 <c0fc38df-9c52-406f-8d8b-f2496b4e410f@linaro.org>
 <CAHirt9ifqqrzcc3oJ1VAfEhHAP+U4bW=yh+BJJxkgaArKOhG+A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAHirt9ifqqrzcc3oJ1VAfEhHAP+U4bW=yh+BJJxkgaArKOhG+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x441.google.com
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

On 24/9/25 06:29, WANG Rui wrote:
> On Wed, Sep 24, 2025 at 12:03 PM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> On 19/9/25 14:49, WANG Rui wrote:
>>> It looks like a typo.
>>
>> Likely from the TCG_TARGET_HAS_andc_vec case.
>>
>>> When the false value (C) is the constant -1, the
>>> correct fold should be: R = B | ~A
>>>
>>> Reproducer (LoongArch64 assembly):
>>>
>>>        .text
>>>        .globl  _start
>>>    _start:
>>>        vldi    $vr1, 3073
>>>        vldi    $vr2, 1023
>>>        vbitsel.v       $vr0, $vr2, $vr1, $vr2
>>>        vpickve2gr.d    $a1, $vr0, 1
>>>        xori    $a0, $a1, 1
>>>        li.w    $a7, 93
>>>        syscall 0
>>>
>>> Fixes: e58b977238e3 ("tcg/optimize: Optimize bitsel_vec")
>>> Link: https://github.com/llvm/llvm-project/issues/159610
>>> Signed-off-by: WANG Rui <wangrui@loongson.cn>
>>> ---
>>>    tcg/optimize.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tcg/optimize.c b/tcg/optimize.c
>>> index 3638ab9fea..f69702b26e 100644
>>> --- a/tcg/optimize.c
>>> +++ b/tcg/optimize.c
>>> @@ -1568,9 +1568,10 @@ static bool fold_bitsel_vec(OptContext *ctx, TCGOp *op)
>>>                return fold_and(ctx, op);
>>>            }
>>>            if (fv == -1 && TCG_TARGET_HAS_orc_vec) {
>>> +            TCGArg ta = op->args[2];
>>>                op->opc = INDEX_op_orc_vec;
>>>                op->args[2] = op->args[1];
>>> -            op->args[1] = op->args[3];
>>> +            op->args[1] = ta;
>>>                return fold_orc(ctx, op);
>>>            }
>>>        }
>> Looks correct, but I don't understand the swap. Can't we justkeep the
>> same argument order for an ORC opcode? I'd have done:
>>
>> -- >8 --
>> @@ -1569,8 +1569,6 @@ static bool fold_bitsel_vec(OptContext *ctx, TCGOp
>> *op)
>>            }
>>            if (fv == -1 && TCG_TARGET_HAS_orc_vec) {
>>                op->opc = INDEX_op_orc_vec;
>> -            op->args[2] = op->args[1];
>> -            op->args[1] = op->args[3];
>>                return fold_orc(ctx, op);
>>            }
> 
> Bitwise logic can be tricky and easy to get wrong. In general, (a |
> ~b) != (b | ~a). For example, when a = 0 and b = 1, the results
> differ.

Oh right.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> 
>>        }
>> ---
> 

