Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5145CC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 15:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufK14-0002hT-0q; Fri, 25 Jul 2025 11:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1ufK0c-0002A0-0Q
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:06:54 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1ufK0a-0001Vn-Bn
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:06:53 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-23dc5bcf49eso29556965ad.2
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 08:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753456010; x=1754060810; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z6Py8ZwS0kfqeDhym1u+VYnJ4E+KS3P82qJoNRkABKk=;
 b=O9Luj0goe15UWMH9/lQpVzWA29OMVDbnf+jS9eKs4WkrCPBLi/rYl7P7nhGejCv5Qp
 XproAf2b2H57mW1SRuctET4OSOD9L87OvNRQTd5EQWYk+7Fw1GUj0nJIv6t5xYZ9CTZZ
 /I4SHxpL8VGNXL8lDCRwcA6RmJQ/okwF2EU75/1I8Ff/Np2jsCo8zKyc1MvnKnMO9mnn
 27BlGNzl2Ru1d2Uib4NZylSCFbIBVR5mtzaVQD/0F0XtFDGX764YnNxGGiAp/xDf/DrE
 J4JEHF3Ejr8MQ+izQg0M1NI7Wr3YUEC7CzOzN6FAhOynNVOBIjxAVTd3ja4DlgvXvzmq
 2wRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753456010; x=1754060810;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z6Py8ZwS0kfqeDhym1u+VYnJ4E+KS3P82qJoNRkABKk=;
 b=mwkatZfCgPSACFBBIXjRWxsMwPH2eT+xzS/aGKv1M/Rh5nC0LwhthrF78gr9KyV8S6
 aXJyUhvGegnl1+Q7Dy2pT3366dm5FHhxeU/FTEKm23t5Bf0dlavCpq27s1DVE7N9jnEg
 bhTc5glb6zDKdLuiPGOqMq5RDlsPzUHEA57HsH1yrO2DOa4NozXiAauSRjxeWo5OXKvq
 yZFoazzkpwI+GeSli4RMQoPTZucEiNFE0c0gJMXBrJVS6ODrIvNXMv7+ExaCjk7k/0LX
 tQsSokozbBhKYizqae2s2kkbu18/DorQISnD3IJK6fFkB1eOnw5BJli3EF0918+qXm6c
 dxyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv086oITTfr5YZ/MEF8Ez+0ehUR+odOli3+/sk6neTYniuqK+JPlheIilZ3UAPI4HXmJJdQ0ucAbKJ@nongnu.org
X-Gm-Message-State: AOJu0YwGAmye8K/MEhpYmOM0/ruCF8/8gjM8dA0KsoEO3u3fdl5js69X
 0taEt2ACK8BwXFp8OROr20IvzRWnnWJrLB8PYUDn+6M5K4joGr9udkYXtq2kOfsXb5M=
X-Gm-Gg: ASbGncsFY6DYt3yWVnN06sI/f3WbEv7hsgRvKCS1IooewJuliww7xzmACR2Y2Il9NUL
 /aOyZPDJ9xPmL/067+szUZSmWk/P8LCp0jxttSWOt2yKQxNujUL05fAqeMnv8DLINlnkOh7I5H0
 5jtda7ZXofouwagRxaaQTV5EA4JH7FFI4D7FGKoEb2VeZ8qyHKaKsllCjoLKeKfmBZzqijn+bAI
 w0KGc/avU9NcJR5Ys2JsfpsIKBrfOaR6/ouuWc5N8+3msxG5ovZOTzoyLECrD6HsDOUHshNjbTH
 KBzYFLaFsxwznenQ7V+U2jE9CNF50drsPVkY3rxazUS/4Z9AK1cwkVK17oO74+Tww2KhUoi6zq9
 AbbVE/233SBWa4v1/GKGyP+eaN0y2CK1o6A==
X-Google-Smtp-Source: AGHT+IHP69mvkV6J1NoYGMnKr/W4aNwIS8AKl897sDFXRo/m5F6BIEskvMxCmP4+rHJxasf6FE2aiQ==
X-Received: by 2002:a17:903:246:b0:235:ed01:18cd with SMTP id
 d9443c01a7336-23fb317ae95mr32840655ad.44.1753456010440; 
 Fri, 25 Jul 2025 08:06:50 -0700 (PDT)
Received: from [192.168.0.102] ([187.75.37.236])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fa491804bsm39106985ad.206.2025.07.25.08.06.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 08:06:50 -0700 (PDT)
Message-ID: <29a7b7ac-831d-4124-9f93-427bec6205ff@linaro.org>
Date: Fri, 25 Jul 2025 12:07:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Clean up of register field definitions
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
References: <20250725014755.2122579-1-gustavo.romero@linaro.org>
 <17254b66-4902-4ee0-8c9a-4082146255e3@linaro.org>
 <aad0c640-b736-4f5a-a6cf-e5459f60630d@linaro.org>
 <CAFEAcA8CN2GEGGrPZGweFHffSsBLF5Q-kfHwYhiRXfrgqGJ_Mg@mail.gmail.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <CAFEAcA8CN2GEGGrPZGweFHffSsBLF5Q-kfHwYhiRXfrgqGJ_Mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62a.google.com
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

Hi Peter,

On 7/25/25 11:47, Peter Maydell wrote:
> On Fri, 25 Jul 2025 at 15:38, Gustavo Romero <gustavo.romero@linaro.org> wrote:
>>
>> Hi Phil,
>>
>> On 7/25/25 10:18, Philippe Mathieu-Daudé wrote:
>>> Hi Gustavo,
>>>
>>> On 25/7/25 03:47, Gustavo Romero wrote:
>>>>            if (stage2idx == ARMMMUIdx_Stage2_S) {
>>>> -            s2walk_secure = !(env->cp15.vstcr_el2 & VSTCR_SW);
>>>> +            s2walk_secure = !(env->cp15.vstcr_el2 & R_VSTCR_SW_MASK);
>>>
>>> FYI register API provides helper macros:
>>>
>>>               s2walk_secure = !FIELD_EX32(env->cp15.vstcr_el2, VSTCR, SW);
>>>
>>
>> Do you know which form is currently preferred? I see that R_<REGNAME>_<FIELD>_MASK is used a lot, .e.g, in helper.c.
> 
> Where a mask is the most simple or useful way to get what
> you want, it's fine to use R_*_MASK directly; for instance
> in this patch
>   (env->cp15.vstcr_el2 & (R_VSTCR_SA_MASK | R_VSTCR_SW_MASK)
> is better than
>   (FIELD_EX64(env->cp15.vstcr_el2, VSTCR, SA) ||
>    FIELD_EX64(env->cp15.vstcr_el2, VSTCR, SW))
> and
>    value |= R_FOO_BAR_MASK;
> seems simpler than
>    value = FIELD_DP64(value, FOO, BAR, 1);
> 
> I think (though this is to some extent a matter of personal taste).

I also prefer the mask for the most simple cases, like in 1 bit masks and where the code becomes more succinct.


> Where we're using the mask to test whether a single bit field
> is set or not, you could do it either way. I think in new code
> I would probably use the FIELD_EX64 macro, but a test against
> the mask value is fine too.
> 
>> Also, even tho the SW field in VSTCR is <= 31, VSTCR is a 64-bit register, so should I really use FIELD_EX32 (which works) or FIELD_EX64 (my first thought would be to use it, i.e. based on the register size, not the field)?
> 
> Use FIELD_EX64 for working on 64-bit values, yes.

Thanks for the clarifications.


> Personally I don't feel strongly about any of this, so I
> would be happy taking this patch the way it is.
> 
> -- PMM

OK, thanks.


Cheers,
Gustavo

