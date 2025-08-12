Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E894CA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 17:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulsyt-0004Fr-UU; Tue, 12 Aug 2025 13:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulsys-0004FB-AZ
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 13:40:14 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulsyk-00059S-Pp
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 13:40:12 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3b788feab29so3556260f8f.2
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 10:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755020400; x=1755625200; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=54Y7ecwCX1DQuE+WdBnur410o07WRJgqBKRhN5gF/vM=;
 b=CnKiFa4dTpqKN+aOd9s0XDEex87DXgWTs4Op93RIA7r2X9LFz1RgWXfrdvcc4QhX2P
 sYCMC3Nwvv2WYf1Ghwv9tFmjrZXEOjL7kBbgtmIb1Ygcwb9/uHeETFN85BwIkz9LvCEz
 GrxAmcz8lwdofi43QBgv5EESSFOdIcH/eF+PSyZP+zb29UUvCQ0fgcjRHko3rY8A0ifb
 spyUNSaFy4Yxg9/yG8GZQxhlmdhDMb4X9fxYPnyEWOz42GYqwcDGZ5J6+JKgWJ/c01gB
 pn9rYF/O36Lb6W6uks3BKrcq1x42lo4Eox3MTzISFp0ObSsltaM4PmS1FPA4z5EjitQf
 BzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755020400; x=1755625200;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=54Y7ecwCX1DQuE+WdBnur410o07WRJgqBKRhN5gF/vM=;
 b=FE3mMMteaj8owbp+sXIlDLn/6TeXTU6Cwiw42ptxEEX02bw01TcmmnbkTn3lJg5evV
 3z0aFm67qvMCRy7TS6xAJ8mqOXrSSMY9VgfiIwsnD6NYjzEq/YSVKLfKWtL05QlwlwiS
 MbKLIv9pjYxLpCdDrcJZGC6Ns1jUw1Nui9kyPR15cpSiTXXGsvJSffcYLGDR+eHfOO05
 cr7cZV77YHTYlGUydVG/fp461ZyEqgTFVjjMO5avsUeTkPf6t5TPUDhVJU9q7dUNpL7F
 ehZy70BHTdNKEILySSaW8Zlp5AuPl7ES19bz8KH8slhgeAS+9y9rVCRDtRJGNaNqEMBB
 G1ZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/bAN6mLlYHiXZncEUqZewlxb1Ge6tCeF4nGrqfR63H4HbtW/4X6OzkgivtFxXq+YGAwgOCG5zYG4D@nongnu.org
X-Gm-Message-State: AOJu0YzyvR3avB+FPYQ0MZlQdlkFsgmV0T6XR1NedQpekpUnEVJNv/FR
 gytMo7VZqw8mkzQs9BH4StPaXBGuoeblV5SwpgWXAClvXWvIOwxOkzrDQ2SmXtQc6iE=
X-Gm-Gg: ASbGncuT74cVbOFPVzAlwlFqwGeVGaJmQt//hqkoOQjfoXNzy1Qz4jKvgsJIV2JqV48
 fOf4L5CGGDe7fr/55Yjic6GBnVB8+KfVQJwENtWr3R+cVWSWeM0AQXXAjFOKlrCP3rjg7r/FQXo
 1uzkEZERkpjiPQGZKAJqqbRPuxD+juzDCX6Zg0KhN7eX8n3VN4k+rNZWCgJVVlF4TB4AclK5hnV
 cKRusly2TXCC6kGTlMUWXltRERglCDCCxe2tSeIuaktChyUbWGcBX3pX4djFw3dwJj3WLeD9dv1
 ibxK0iYWWbMAJ7oaCZNE9qNGxZQb1O63BvpbsCnA1eqLV8CEvTxvKbKxDNMKXxzVTxd8ArLlBCu
 ZPsuUKF2nerEiEPMwizBSa9EzN51nwkFBXZD60a8OlZx0/79wsDRb9YqCQGUb7d0XNQ==
X-Google-Smtp-Source: AGHT+IHbM77TKgvDRA1+zpAxaEdnN+pIynh8fTQOmmcfplC+fAQK8RdB9uOvzZ6If0riUOS18U2nBw==
X-Received: by 2002:a05:6000:3111:b0:3b7:78c8:937f with SMTP id
 ffacd0b85a97d-3b917241097mr251794f8f.20.1755020400206; 
 Tue, 12 Aug 2025 10:40:00 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c485444sm45516784f8f.66.2025.08.12.10.39.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Aug 2025 10:39:59 -0700 (PDT)
Message-ID: <c775c856-277a-4a55-9fda-5516e1e8a414@linaro.org>
Date: Tue, 12 Aug 2025 19:39:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 04/11] hw/arm/smmuv3: Enable command processing for the
 Secure state
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Tao Tang <tangtao1634@phytium.com.cn>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>, smostafa@google.com,
 jean-philippe@linaro.org
References: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
 <20250806151134.365755-5-tangtao1634@phytium.com.cn>
 <0b38d386-9d8b-46bd-a981-718cc7281eb6@linaro.org>
 <f74b4d64-893f-4b39-aa95-4e9ff52edebd@phytium.com.cn>
 <4ff26d30-3b0d-4392-8bac-698ecb0fbdde@linaro.org>
 <2cb0e32f-6660-4fcd-8a37-52cdeaf9dc19@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2cb0e32f-6660-4fcd-8a37-52cdeaf9dc19@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 12/8/25 19:27, Pierrick Bouvier wrote:
> On 8/11/25 3:34 AM, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> On 10/8/25 18:59, Tao Tang wrote:
>>> On 2025/8/7 05:55, Pierrick Bouvier wrote:
>>>> On 8/6/25 8:11 AM, Tao Tang wrote:
>>>>> This patch enables the secure command queue, providing a dedicated
>>>>> interface for secure software to issue commands to the SMMU. Based on
>>>>> the SMMU_S_CMDQ_BASE configuration, the SMMU now fetches command
>>>>> entries directly from the Secure PA space so that we need to pass the
>>>>> memory transaction attributes when reading the command queue.
>>>>>
>>>>> This provides a parallel command mechanism to the non-secure world.
>>>>>
>>>>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>>>>> ---
>>>>>    hw/arm/smmuv3-internal.h |  8 ++++--
>>>>>    hw/arm/smmuv3.c          | 55 ++++++++++++++++++++++++ 
>>>>> +---------------
>>>>>    hw/arm/trace-events      |  2 +-
>>>>>    3 files changed, 41 insertions(+), 24 deletions(-)
>>>>>
>>>>> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
>>>>> index 1a8b1cb204..5b2ca00832 100644
>>>>> --- a/hw/arm/smmuv3-internal.h
>>>>> +++ b/hw/arm/smmuv3-internal.h
>>>>> @@ -319,9 +319,13 @@ static inline void queue_cons_incr(SMMUQueue *q)
>>>>>        q->cons = deposit32(q->cons, 0, q->log2size + 1, q->cons + 1);
>>>>>    }
>>>>>    -static inline bool smmuv3_cmdq_enabled(SMMUv3State *s)
>>>>> +static inline bool smmuv3_cmdq_enabled(SMMUv3State *s, bool 
>>>>> is_secure)
>>>>>    {
>>>>> -    return FIELD_EX32(s->cr[0], CR0, CMDQEN);
>>>>> +    if (is_secure) {
>>>>> +        return FIELD_EX32(s->secure_cr[0], S_CR0, CMDQEN);
>>>>> +    } else {
>>>>> +        return FIELD_EX32(s->cr[0], CR0, CMDQEN);
>>>>> +    }
>>>>>    }
>>
>>
>>>> This looks like a reasonable and readable approach to support secure
>>>> and non secure accesses.
>>>
>>> Hi Pierrick,
>>>
>>> Thank you so much for taking the time to review and for the very
>>> positive feedback.
>>>
>>> I'm very relieved to hear you find the approach "reasonable and
>>> readable". I was hoping that explicitly passing the parameter was the
>>> right way to avoid issues with global state or code duplication, and
>>> your confirmation is the best encouragement I could ask for.
>>
>> An alternative (also suggested in patch #1) is to use index for banked
>> registers.
>>
>> For example we use M_REG_NS with Cortex-M cores (target/arm/cpu-qom.h):
>>
>>       /* For M profile, some registers are banked secure vs non-secure;
>>        * these are represented as a 2-element array where the first
>>        * element is the non-secure copy and the second is the secure 
>> copy.
>>        * When the CPU does not have implement the security extension then
>>        * only the first element is used.
>>        * This means that the copy for the current security state can be
>>        * accessed via env->registerfield[env->v7m.secure] (whether the
>>        * security extension is implemented or not).
>>        */
>>       enum {
>>           M_REG_NS = 0,
>>           M_REG_S = 1,
>>           M_REG_NUM_BANKS = 2,
>>       };
>>
>> And generally for address spaces (target/arm/cpu.h):
>>
>>       typedef enum ARMASIdx {
>>           ARMASIdx_NS = 0,
>>           ARMASIdx_S = 1,
>>           ARMASIdx_TagNS = 2,
>>           ARMASIdx_TagS = 3,
>>       } ARMASIdx;
>>
>> (not sure this one is appropriate here).
>>
> 
> This could be useful, especially to not duplicate register definitions.
> 
> However, for now, we only have two indexes (secure vs non-secure) and 
> it's not clear if we'll need something more than that in a close future.
> I think the current approach (a simple bool) is quite readable, and the 
> boilerplate is limited, especially versus changing all existing code to 
> support the new Idx approach.
> As well, it can always be refactored easily later, when we'll need it.
> 
> That said, I will let the maintainers decide which approach they want to 
> see implemented, to avoid Tao jumping between different people opinions.

Sure, no problem.


