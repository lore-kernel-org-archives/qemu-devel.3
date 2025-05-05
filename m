Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD524C3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 19:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC1JX-0002mV-Ho; Mon, 05 May 2025 15:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC1JV-0002kf-QJ
 for qemu-devel@nongnu.org; Mon, 05 May 2025 15:17:17 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC1JT-0001gP-Ex
 for qemu-devel@nongnu.org; Mon, 05 May 2025 15:17:17 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22e331215dbso1596895ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 12:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746472633; x=1747077433; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GW6KVIAEijcEBLlWWBZL706R8iQgdB2ZER5S3nvinZo=;
 b=JCL/L8fE62cyd+F5/18Fd9PDlmPAO6TmU4WMWZr+ceus9z4CLWNc98nPIsgKbAJ8Tc
 wZOfKds42joqtO3u+c1LiScH1n5Im+61zRVzC7epI3KFpGqR2wweNs966yjfmhjjFA+1
 NtUyCN1l/eGaaG/p2AheQfVXmp0jsisCfqHAbGAtxAcScuyZh0zh98bfZZS9mSlVGDCG
 clBIIdQatOwwXoy8Piahauyfr8B1um/QtQH1LVOoxW9zqwgf0f30udZi5tqrA7lNTciz
 0KSSO/oHhdO8HmGQTlHudYvLUYAcekGRbWItDtLJgxov5vcrQEAwxka0mLczjPAUtNVf
 DfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746472633; x=1747077433;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GW6KVIAEijcEBLlWWBZL706R8iQgdB2ZER5S3nvinZo=;
 b=RUUcTAUVwG5aDC3CPQXLV/PLWZlfBy80zP2mYTsH6/+ukrWGq32Wt8G5uHpeJDVYGc
 MIMAQ/K9u8JRlm0dbdmm62n51OfDKHXnU+AE45nOlOsltvh3uZAhcji0h/WWRep83AjU
 0u5Fca4jNUgxoeoRYNeB/RQStEtb/H0eQtPLQRCbh38Iekp0wYsG4djh6IEMVRzVjzHA
 JAxukjKFpHcFDYXuVZ5jvGOfRDW4biMOtJIdpTkXYp9LIh5H6veU5noKtugU4JTbP2cG
 KeN/EvdX1hTq7DlRmEv6P7I3pyodvA0MQ6RApzNcchffeaMEgyfSy9hvCSvaY5+yYkgW
 8UZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHynC3djlT6vAaIEcnBXea2Y3sponghhCVi++J8QwW8lAIdG+9De9JQQR/UEAB/id4L8qvRq2ObbKQ@nongnu.org
X-Gm-Message-State: AOJu0YzGsyiRa7uE4bUmamJtQWFaeLd2eRzQwKe9r5+tFvKkDCqtBFR4
 e5HieEsPN3O3LaCpE8DEy+V8dgmUcdy96c/nxUw1DKpSl9rWEtjEkeaTO/lx4/c=
X-Gm-Gg: ASbGnct8fp6a0WQs6tSwV2YfBaiVLMmxvFtW7+1et5rSwaaCbXHckAvGdyYtlQxLhrN
 YmsGS3YVAhKyi4U0CZ7ic4GbZOWqL5CFrqMmg3Mu1sm6Gl4Kvl/YTT1cOnJ/HanvT1CRku1/35m
 9xLHoiNsvvd+tRX8kFs1Uld0cabHIxIcA9Th2H4HPFViEbOHd3/QHHhWwd6gxcDC2K/AHUK/P8e
 czr2I+v9ZWQucZU6OVp9x9QDr1xhap5mj9T3GSy0DMJouZNB8jqSgCx1eDEtL/SohTZeM7Giu7F
 FuH/flKiO+wG9xbGQ23kmGtIkUrSuoN0eDJKZlej+CaLtgA+9IRbi4beQb22ScDY
X-Google-Smtp-Source: AGHT+IGnPIGHq8VjO3UXrxZyCh63NER++S0TiK8mYQqalmCCQirVcYO0Wpw015CxlvaOu9I3VCFpcQ==
X-Received: by 2002:a17:902:d591:b0:215:a2f4:d4ab with SMTP id
 d9443c01a7336-22e327567a0mr9562555ad.7.1746472633594; 
 Mon, 05 May 2025 12:17:13 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522936csm58574325ad.204.2025.05.05.12.17.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 12:17:13 -0700 (PDT)
Message-ID: <14dc3ba2-576a-4ce6-b07d-6b78280e235f@linaro.org>
Date: Mon, 5 May 2025 12:17:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 41/48] target/arm/tcg/crypto_helper: compile file twice
 (system, user)
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
 <20250505015223.3895275-42-pierrick.bouvier@linaro.org>
 <79916f8d-2793-40a7-b769-ee109c52ef63@linaro.org>
 <f33fa744-1557-4c01-ba49-e64b4d3b6368@linaro.org>
 <c67c4a79-7855-4d15-8064-b2f448ac9a42@linaro.org>
 <83038814-8527-44ec-b1c1-2d17362d08da@linaro.org>
In-Reply-To: <83038814-8527-44ec-b1c1-2d17362d08da@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

On 5/5/25 11:53 AM, Pierrick Bouvier wrote:
> On 5/5/25 11:51 AM, Richard Henderson wrote:
>> On 5/5/25 11:47, Pierrick Bouvier wrote:
>>> On 5/5/25 11:38 AM, Richard Henderson wrote:
>>>> On 5/4/25 18:52, Pierrick Bouvier wrote:
>>>>> --- a/target/arm/tcg/meson.build
>>>>> +++ b/target/arm/tcg/meson.build
>>>>> @@ -30,7 +30,6 @@ arm_ss.add(files(
>>>>>        'translate-mve.c',
>>>>>        'translate-neon.c',
>>>>>        'translate-vfp.c',
>>>>> -  'crypto_helper.c',
>>>>>        'hflags.c',
>>>>>        'iwmmxt_helper.c',
>>>>>        'm_helper.c',
>>>>> @@ -63,3 +62,10 @@ arm_system_ss.add(files(
>>>>>      arm_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
>>>>>      arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
>>>>> +
>>>>> +arm_common_system_ss.add(files(
>>>>> +  'crypto_helper.c',
>>>>> +))
>>>>> +arm_user_ss.add(files(
>>>>> +  'crypto_helper.c',
>>>>> +))
>>>>
>>>> Could this use arm_common_ss?  I don't see anything that needs to be built user/system in
>>>> this file...
>>>>
>>>
>>> It needs vec_internal.h (clear_tail), which needs CPUARMState, which pulls cpu.h, which
>>> uses CONFIG_USER_ONLY.
>>
>> Ah, right.  I didn't see that coming.  :-)
>>
> 
> I like the idea to have it built once though, since so far
> {arch}_common_ss was not used, and I was not even sure such a
> compilation unit exists.
>

Done.

>>> I'll take a look to break this dependency, so it can be built only once, and for other
>>> files as well.
>>
>> Thanks.  Building twice is still an improvement, so for this set,
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> r~
> 


