Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A752FCD0A6
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2nqB-0004RN-Kb; Wed, 18 Mar 2026 06:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2nqB-0004R8-2N
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:09:27 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2nq9-00054v-3E
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:09:26 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43b4d734678so1519183f8f.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 03:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773828563; x=1774433363; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+lAYt0pkLbcYah3cW5JmMxZMLWVOnVd43OasVJOYXms=;
 b=thSdYVoy4FQQl9GMaGlpEHPwAh4HTJNE/dUgI8AxwfPjIV7tpYvJBterxn1wYOLGs2
 bPFJ9ujrZtQsV7EMBt5MVoVwVwvoEU81Xbf5p1iJZ4KbT1d/ORm8LC9tjcKda3dex1zi
 wbcrEJ3NNh9DMb6cVs9lah+DJGnPIxxyGgYgbDSoqKuWBK/DmloiuMh01i8LKh7zG5f9
 ppdXJUisJY35hH0gbYj61uZytS5MjeQzGwuleSgWNeB4sdvNcP7waJmGTNUvgNRciFPy
 saNJ3Ucl7ooGcXY2vyuzRf0q+Vm3rB4hiFW/UXyFscOfzuqt6R4x6WC+5l1a8M6gMNQc
 aKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773828563; x=1774433363;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+lAYt0pkLbcYah3cW5JmMxZMLWVOnVd43OasVJOYXms=;
 b=qYe2+CoA8sBkQMEDEgxFSO0u9cK0zHn9xG37VjAjSS+rQalT9RDRhqbpLrs0S0SisG
 tcL5PHcgtPV+C8PkNe9lInh0Su31gcImqNvj+BCpGG7mB/9WBXUmoWFIrDwdxOfJl7hB
 lWkcqdltyIZ+6UkmctWoiuFC4u4l4dJp1KOtcCJvBPbRa2BCMhgepL6dbq8nd2NqxAl4
 liKraOTxPJQf4WJjZ6ffgpWb4wH6EbGKDEm/MFAyzvcumcqNDn6ay3VH0pA+WKcuy9ec
 xvXdf+66TdikA4b2rAQUx1Wa00rh/6TGFzqO8hlLP9QBw6qUITlest+B8cEB5yzbgzUx
 Doyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0AJobUKNGHTarKBUvm5qHzNFeNy+b0O+hpEL4ItivM0GV88wwscf8b23lPr0kAJFqaMT4xxzRWBj/@nongnu.org
X-Gm-Message-State: AOJu0Yw1nqUVXALhYTtfGD8ImyDx7N6hXkwpuEAFyOU5ug//5io2rOxw
 lRhJvvgCj74Y27jpm78n1SvgD4lEjNEIWWxhFM3/6Umrx8jX1WYFXo1TsjrYAk2Y1S4=
X-Gm-Gg: ATEYQzxFYpFhB7A4uFdCUBK7fs92GSTfdttUL0LbkO4lTXoihAXU/tXxe1a5PXortuF
 ZjXPG3Y2jQihuEky8f7xpmdkCKFYTno3KMwHMAAhoNtgKT5SLzengq/HCV38CkcwUTfCXsyyVph
 10QL3W2Q54Tm6SYzjsltm2JCjVjNx18afaCLM/VyYQaFNvHuUlxBDZJfo6P1WYUjSVhdT88PJbQ
 n+AZDh8xSIUX+SO7eaf4OpbnletQ1OY4X4OZYlUDuqmEmhrQOlRjzD3e11ALmeeUhKuKajRb5b5
 3XqdaUx343ho246q6Oqtfo8GZOW6jZnpoOgmQFivUlQBV3DWuAoj9M5qZAL3Fg6egPukDT5yx8B
 KvekK5jgT6sdVELWvc5+7uGn/9K7oX+n60v8jGaThRT/+gNJzY/X7eii20dSdcEoDSWL7jjh7M6
 gtSKq1qg6/vt4mGoeRs3pmHMMQMOH5hDMFdlObpZrRQ/6JV+7NjL7/SdBQKelKxHaGkQ==
X-Received: by 2002:a05:6000:2c0e:b0:439:cd10:a1f9 with SMTP id
 ffacd0b85a97d-43b527cc035mr4524179f8f.54.1773828562683; 
 Wed, 18 Mar 2026 03:09:22 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51851e43sm6283803f8f.10.2026.03.18.03.09.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2026 03:09:22 -0700 (PDT)
Message-ID: <92abffc9-d171-49d4-ae44-2bffdf9b8103@linaro.org>
Date: Wed, 18 Mar 2026 11:09:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/riscv: Restrict access to RV128 registers on
 RV32
Content-Language: en-US
To: =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?=
 <frederic.petrot@univ-grenoble-alpes.fr>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20260315165949.40027-1-philmd@linaro.org>
 <35544128-3c7f-48b2-a67f-9253cf8f5df0@univ-grenoble-alpes.fr>
 <abfb425a-50b3-4807-b600-6977b8d1f2fe@linaro.org>
 <27b3c263-45eb-4adc-9fc6-5693bed31345@univ-grenoble-alpes.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <27b3c263-45eb-4adc-9fc6-5693bed31345@univ-grenoble-alpes.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 17/3/26 17:48, Frédéric Pétrot wrote:
> Thanks Phil,
> 
> On 3/17/26 11:05, Philippe Mathieu-Daudé wrote:
>> Hi Frédéric,
>>
>> On 15/3/26 19:55, Frédéric Pétrot wrote:
>>> Hi Phil,
>>>
>>>    my understanding is that rv128 makes no sense with rv32, and
>>>    the user is not expected to run qemu-system-riscv32 with
>>>    the -cpu=x-rv128 (it triggers an "unable to find CPU model
>>>    'x-rv128'" error).
>>>    The rv128 code just relies on XLEN being 128, and assumes
>>>    (implicitely I admit) running on a 64-bit host machine, so
>>>    with tl = 64.
>>>    The code is absolutely erroneous when tl = 32, agreed.
>>>    The thing is that, as we want to get rid of the
>>>    TARGET_RISCV64/TARGET_RISCV32 defines, the rv128 specific
>>>    code still must compile whatever tl, so that qemu can be built.
>>>    However, it should never be executed if tl = 32.
>>>    Typically, the patches I sent earlier this year to deal
>>>    with lq/sq endianness fit into that 'compile only' category
>>>    for rv32.
>>
>> I'd really like to include your patch which fixes the endianness
>> issue I reported, but unfortunately as reported it doesn't even
>> build for rv32 builds:
>>
>> https://lore.kernel.org/qemu-devel/ad717d8c-a6b9-4dd8-a4bd- 
>> fdd6d1d756a5@linaro.org/
> 
>    Very sorry for that.
>    I took care of the errors in a later patch you might have
>    missed :
> 
> https://lore.kernel.org/qemu-devel/20260101181442.2489496-1- 
> frederic.petrot@univ-grenoble-alpes.fr/

Oh indeed this isn't in my mailbox... Fortunately the list got
it so I could import it.

> 
>    This compiles fine on Alister current riscv-to-apply.next
>    branch for both 32 and 64 bit versions (known that the
>    32 bit version does nothing useful, but is never used
>    anyway).

Yep, this is sufficient to fixes my issues and let me continue!

> 
>>
>> Which is why I'm trying to restrict RV128 on rv32 binary so
>> we can apply your other patch.
>>
>> Anyway, Daniel suggestions to use 'get_xl(ctx) == MXL_RV32'
>> instead of this ugly TARGET_RISCV32 #ifdef'ry is certainly
>> the way to go (which is why I posted this as RFC).
> 
>    It might, indeed.
>    Thanks again for your time,

Sorry if I sounded grumpy ;)

>    Frédéric
> 
>>
>>>
>>>    Thanks,
>>>    Frédéric
>>>
>>> On 3/15/26 17:59, Philippe Mathieu-Daudé wrote:
>>>> One half of 128-bit registers code is not reachable for CPUs
>>>> running in 32-bit mode, while the other half is completely
>>>> broken (handled as a pair of 32-bit registers).
>>>> Better restrict this code on 32-bit builds until RV128 is
>>>> properly implemented.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>> More than 1y having issue with the 128-bit code path and
>>>> the single binary effort. Fortunately while I dunno how to
>>>> test 128-bit I could with 32/64 bits.
>>>> ---
>>>>   target/riscv/cpu.h                          |  2 ++
>>>>   target/riscv/machine.c                      |  4 +++
>>>>   target/riscv/monitor.c                      |  4 +++
>>>>   target/riscv/translate.c                    | 31 +++++++++++++++++ 
>>>> ++--
>>>>   target/riscv/insn_trans/trans_rvzacas.c.inc |  2 ++
>>>>   5 files changed, 41 insertions(+), 2 deletions(-)
>>
>>
>>
>>
>>
> 


