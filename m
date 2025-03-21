Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83EAC36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvgoL-0005sV-OJ; Fri, 21 Mar 2025 14:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvgoH-0005o6-IQ
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:09:35 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvgoF-00068B-6o
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:09:33 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22401f4d35aso51268455ad.2
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742580569; x=1743185369; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iYahRmDjo3AoM4y6+k6usMjWi0lqC7TSobI4jZQHYNo=;
 b=MOP1wxWEahRvwlZqHH4kLcdh3m+aij/ehTjsmMUYov3t/pY7BhLj5OmVVjaZjR87q9
 8IuNIDlh3q5aiiOLARThTAPh79FqOId4X9/cHWGCI+yoojfL/AUAnXhrn9cdDXPEFcrM
 MMPB39k9lnVX5+ksWx0ShWQVCT3R2uAHGtWJW/aj7tPSiJUBjMax8QKQYzhjwdx+aumG
 Ovl4pTG7U80L3LZKxeg5NiKApYRwxzCyf2QS1ZpzIMKLKytcD51TgNTEIzbBWKBznXtn
 QrsMD01kkjEo6/dcWZan/nKsKMThrn5P3IzUDfNfFFLCY1DEh3/pREEIqxzhvG4bmlP1
 stkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742580569; x=1743185369;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iYahRmDjo3AoM4y6+k6usMjWi0lqC7TSobI4jZQHYNo=;
 b=YZuhu6P4VRtVJhVf+J2LWw0c1MfXAjdE0q4HW2qsGz+yxFfXL+0A0bXZiqLtCS7fDe
 H4a2xjX8nCW6lBAVDf/fvfx3i9qQJmwrCAgUwGeIedG1Voz/3NjKfw3trFvxd/Rklq7N
 N8xFhj8CfFyJp1uXTQe8WTYSZ9hiKQyIkzToAgbWer4xPSF2njiXPBBG5c6UeeM42895
 cACm4iZBVXHwvy1GPci4Q8CBPr+P75lbYwd4GPhRSqUMbztbcQiya6+Wd1dA6SF2Fzup
 211SkGZrbN9md2COPhnOIprsAnCKhXP2RqrxXw4+F94FEAHT5m7QTEivPKur7yIRHm3E
 6frQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdmWJ/1FUsmvucxT4zrUrGgUKv+gV7Xhc8Iu0nHK9/OfI62vq9FM+bIHDeaZPlMNkQ6eoHFqGId1z6@nongnu.org
X-Gm-Message-State: AOJu0YyFRA6oWLpf3dJW1QcI1Lj2qH1Xqw+AfDRw2Tf95k7WKNwIvqpW
 Jgxxy9+PJI3/pNbWK0gpeQ4QMnWV78U78RugO4Eg5x2AcBvIKFXgBTcFZ+AaqtAEtJo7ix12/gD
 e
X-Gm-Gg: ASbGnctfZUZLPdnoAvmtdHltv6Ef1Fk/dgpCyFLMC1HCAcYoPuotk7W4rutivxMy0e+
 MJ2+qzSiIsCUi2Z914NPMj/Kon0DMeSlmyToTgfl5iAZWIDisBFnnc4pdOsipeF5oaQpL3xshzC
 NupyuIug8mlSFTTTfkP5ngX7m8wPwSDojVSszJ7htWc9tEuvI1VH+fM/YNNovixyaxshtfcS7hi
 xkIr2hAEp+Eo+2M58sGEVcIBsXUvFO9eJh/RqKja/FHKdCrM6HPQDkbpiHaRxe0ON8mtak//Wre
 J4mHyHpryEjC7GdvZ7Psf7z6XAt242pASnQh1dnqhwEYo5TR/7lkJnuHGz4=
X-Google-Smtp-Source: AGHT+IGEzpLgBssNtlnSo2d+4BPwRhsuDuNJMP3F9IXe0w77xd/Vh1TYYLKAw8Fk+vnKaucfwGRFpg==
X-Received: by 2002:a05:6a00:2ea5:b0:736:a7ec:a366 with SMTP id
 d2e1a72fcca58-73905999885mr5137245b3a.9.1742580568898; 
 Fri, 21 Mar 2025 11:09:28 -0700 (PDT)
Received: from [172.16.224.217] ([209.53.90.26])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73905fd7a3fsm2373139b3a.67.2025.03.21.11.09.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 11:09:28 -0700 (PDT)
Message-ID: <e738b8b8-e06f-48d0-845e-f263adb3dee5@linaro.org>
Date: Fri, 21 Mar 2025 11:09:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/30] exec/target_page: runtime defintion for
 TARGET_PAGE_BITS_MIN
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-18-pierrick.bouvier@linaro.org>
 <2e667bb0-7357-4caf-ab60-4e57aabdceeb@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <2e667bb0-7357-4caf-ab60-4e57aabdceeb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 3/21/25 11:05, Richard Henderson wrote:
> On 3/20/25 15:29, Pierrick Bouvier wrote:
>> We introduce later a mechanism to skip cpu definitions inclusion, so we
>> can detect it here, and call the correct runtime function instead.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    include/exec/target_page.h | 3 +++
>>    1 file changed, 3 insertions(+)
>>
>> diff --git a/include/exec/target_page.h b/include/exec/target_page.h
>> index 8e89e5cbe6f..aeddb25c743 100644
>> --- a/include/exec/target_page.h
>> +++ b/include/exec/target_page.h
>> @@ -40,6 +40,9 @@ extern const TargetPageBits target_page;
>>    #  define TARGET_PAGE_MASK   ((TARGET_PAGE_TYPE)target_page.mask)
>>    # endif
>>    # define TARGET_PAGE_SIZE    (-(int)TARGET_PAGE_MASK)
>> +# ifndef TARGET_PAGE_BITS_MIN
>> +#  define TARGET_PAGE_BITS_MIN qemu_target_page_bits_min()
>> +# endif
>>    #else
>>    # define TARGET_PAGE_BITS_MIN TARGET_PAGE_BITS
>>    # define TARGET_PAGE_SIZE    (1 << TARGET_PAGE_BITS)
> 
> Mmm, ok I guess.  Yesterday I would have suggested merging this with page-vary.h, but
> today I'm actively working on making TARGET_PAGE_BITS_MIN a global constant.
> 

When you mention this, do you mean "constant accross all architectures", 
or a global (const) variable vs having a function call?

> 
> r~


