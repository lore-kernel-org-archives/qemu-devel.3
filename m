Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E980ECCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 17:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6ufk-0004RT-4C; Thu, 09 Oct 2025 13:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6ufg-0004RB-3O
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:43:20 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6ufc-0005nM-8z
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:43:19 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-26c209802c0so12883935ad.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 10:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760031793; x=1760636593; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1rw47ZkWgjMwlr6iJUjZpho1/IE4CCt9CzOsiPMXHNg=;
 b=SRNgdnwj6D75Y0Bjbocz6yXsH1YnsRPIJqNSDJ9yffss69iVeugJhDP7rp8SfXRQEQ
 3mzrssieught0lfAHs/jPIZISKAV85unMpi1KXALh7nzGscrCmK+/m5VXeaxAjv+5Wzm
 Vs81eY6DH3zuCEyzQz/A0/1LSuy4NJ7FdO7IU8GjWe9/CcAGN0bpW/ip1swrmIl7CLsJ
 d3+mHLhFY3HR3MkmvdG3h7fdaopPtKTZ61/su65Nf8M3eK/RuQ4lS4RP09eKaPEYU2BS
 fUIwrbUzL1ruf4fITykN4pHj4TUaN88mBjVqcJMylqumYedsfzGRZMkxLGwv9zhsaga5
 ujiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760031793; x=1760636593;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1rw47ZkWgjMwlr6iJUjZpho1/IE4CCt9CzOsiPMXHNg=;
 b=PRME28l4nitTwuHv64hoD0GV0eQ2tqXfIsoxSl2Pa9Zl+MuZhaWKF4HTDCorJMh8BM
 hNdwtC4s2zL7K4GhsHMwsm2+hP6Icm+h1vvhPg95aAp02nAP1Ioy4yRq01n3EaxS7bhX
 w9YCse3Fwt9JwJDNBoRznfsVN9qooH8v7Xa739fKsdz1dSVLr6HIdQSDav0v0E/MExuL
 UGGZorZ/zDnQ3Qw/9oy66eZbg/UDhkp2IUC3YGhb3suOVtynlFd7rYRTY+8znNe+sU7h
 5LayVhxQcEbX8zFTXhBEsPfsWRXsjqe7EB0NCVnb0vRFpJ8wZQMMXsEu19AwGLq0ssyq
 8xkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuIomCQO7a57PALfCyX2IR2SHOgU8VGzjZ4qjkOLnzsmKzWe/Yr8KBTxrKxtB4xDzGGmdWyR96eeN+@nongnu.org
X-Gm-Message-State: AOJu0YwaFMwlrHOEULCo3nRf7hoG0Grx+uKsTMXpaL66ZawnTVvEIu1V
 4Nj5QG5h7kAM5ZVLkr7rcu51cRR8/4UirXjulGgsRzbbfFR7PSWNk1xKrlcV1IGJMDI=
X-Gm-Gg: ASbGncuKZ++/IXKZfWVHuiSY6WTiLfSVHkXQ0Q1UnItHpV4I84pQ7xEqy2rIzahZ71/
 dhQ5WJ/Z1Hmbhd7Vn/nbiyc8jg2oRzuDgCBr+DIOI5ASIf03t36PU1aTShWo/+tMx4leTugQvoy
 7DrIIaaXOIptuY4bVhP62OtvANolMogGwt1aARDouWOtdN80fvHFTfmivOoCo/PKPdJOQek/DVb
 OUPq/JbPMHAx6IXwQcTJdZPRGjT/l2p6nNcpIlofKjjQYF4jQWky3kLwxIbts95uoTqeeV/vWcJ
 xdqU+zr/l7nMKrh+6n2kRzXZWDR+MNz6mX6isiDM8GgeLY6VLrqKkjQNGtITceYqusR42RJ0Ruk
 J/GEvAg72HAFFYlkfSuufZZePlBeZ5CTBntplAXNZUvyXhEUSugskWWOsQsKdlzNt
X-Google-Smtp-Source: AGHT+IFijQOI+hnyHC/G8T9aE9lw2O606LXRIao4dB1BkFibDc/LSU5JKVNUga+avjUIkvQkSVAqVg==
X-Received: by 2002:a17:902:d54b:b0:288:e46d:b318 with SMTP id
 d9443c01a7336-290274008ddmr125193985ad.40.1760031793413; 
 Thu, 09 Oct 2025 10:43:13 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f8770dsm34334805ad.117.2025.10.09.10.43.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 10:43:13 -0700 (PDT)
Message-ID: <081b5886-56de-4037-9be3-5f60345bf5b5@linaro.org>
Date: Thu, 9 Oct 2025 10:43:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/73] target/arm: Expand
 CPUARMState.exception.syndrome to 64 bits
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
 <20251008215613.300150-11-richard.henderson@linaro.org>
 <e16277df-c8e1-41ea-8a59-da2ae11dafe1@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <e16277df-c8e1-41ea-8a59-da2ae11dafe1@linaro.org>
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

On 10/9/25 07:14, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 8/10/25 23:55, Richard Henderson wrote:
>> This will be used for storing the ISS2 portion of the
>> ESR_ELx registers in aarch64 state.  Re-order the fsr
>> member to eliminate two structure holes.
>>
>> Drop the comment about "if we implement EL2" since we
>> have already done so.
>>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/cpu.h     |  7 ++-----
>>   target/arm/helper.c  |  2 +-
>>   target/arm/machine.c | 32 +++++++++++++++++++++++++++++++-
>>   3 files changed, 34 insertions(+), 7 deletions(-)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index c9ea160d03..04b57f1dc5 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -633,13 +633,10 @@ typedef struct CPUArchState {
>>        * entry process.
>>        */
>>       struct {
>> -        uint32_t syndrome; /* AArch64 format syndrome register */
>> -        uint32_t fsr; /* AArch32 format fault status register info */
>> +        uint64_t syndrome; /* AArch64 format syndrome register */
>>           uint64_t vaddress; /* virtual addr associated with exception, if any */
>> +        uint32_t fsr; /* AArch32 format fault status register info */
>>           uint32_t target_el; /* EL the exception should be targeted for */
>> -        /* If we implement EL2 we will also need to store information
>> -         * about the intermediate physical address for stage 2 faults.
>> -         */
>>       } exception;
> 
> 
>> diff --git a/target/arm/machine.c b/target/arm/machine.c
>> index 6666a0c50c..ce20b46f50 100644
>> --- a/target/arm/machine.c
>> +++ b/target/arm/machine.c
>> @@ -848,6 +848,23 @@ static const VMStateInfo vmstate_powered_off = {
>>       .put = put_power,
>>   };
>> +static bool syndrome64_needed(void *opaque)
>> +{
>> +    ARMCPU *cpu = opaque;
>> +    return cpu->env.exception.syndrome > UINT32_MAX;
> 
> Hmm...
> 
>> +}
>> +
>> +static const VMStateDescription vmstate_syndrome64 = {
>> +    .name = "cpu/syndrome64",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .needed = syndrome64_needed,
> 
> Why not simply add a new description for the high bits and
> always migrate?
> 
>         .info = &vmstate_info_uint32,
>         .offset = offsetofhigh32(ARMCPU, env.exception.syndrome),
> 
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_UINT64(env.exception.syndrome, ARMCPU),
>> +        VMSTATE_END_OF_LIST()
>> +    },
>> +};
>> +

Because that's more complicated, IMO.


r~

