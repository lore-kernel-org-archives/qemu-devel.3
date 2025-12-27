Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8AACE92716
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 21:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZbkJ-0000md-0B; Sat, 27 Dec 2025 16:22:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vZbkH-0000mJ-HX
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 16:22:41 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vZbkE-0007bL-Tp
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 16:22:40 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a0d5c365ceso105823455ad.3
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 13:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766870556; x=1767475356; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ukPY+wecDD816Go77BPGjZ2rqdmj3GrBKdUhVI/tAfU=;
 b=IOTRI/ig6mk1JIv/O0QZlmWP9I1pp+yjvrn9+D1eaGKBTwgKoICD7a2SBVhpFEwjxM
 llpvHlXHR8wkTG3D6JdTsvXnln+v/D+F7pLrMiJP19r56pTMHRfPnw8quCeVCYH690b8
 Gy/5xCYy4NAgN/mkhJwyqV30Mhu4q0zkKAI3cYwnQZ4cvpOUYKypBrjaUM5PncauI/0U
 fKiq1LzxU5AXYlszs5RUblRxsNphmp8oOR+FgOeU6yOlpoMdpMlg8Bt0LwUkrTXwfg15
 IppTYSxlGlu3+RsoQDTD6frMczOjiK9Ho3B/uFlkFlm9fely0Gn5NrgwhnESFRuzdA3u
 aOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766870556; x=1767475356;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ukPY+wecDD816Go77BPGjZ2rqdmj3GrBKdUhVI/tAfU=;
 b=nUMIxmziAtRbaLjr6lTaJQ7KH6j3XDFh3Ab3/H0+xRkDb4seqMd1AvSqWovFZQ2VsQ
 Ae6AiMPHrNSANjcxp4ghTAfY4C1byUc/FLnEdWfZfhZFAsV2BscBpajaCIsDYMVlCGiG
 EsNc71TTbJ6talLvi2BtJsThBapwzpR3L2XRuGwKTIKUYe+LoOMYvV98s4rbepHt1rzA
 EjDZcZ7oyQPOB5w7Na9+wr7nWFYyQroZyayW+MfnelqnVDsChPEWYpVgXBeVlyuYtAl0
 zQmjito+sec5oOA3r98/+7WbenTh3fegsQuq7q/JayBlgld+fPYaTaWjkf8kwSN3R7bF
 an2w==
X-Gm-Message-State: AOJu0YzJLymF4iv7b2c9EOaWnkkQRQ7zwsESPQSuZXHmiDiT6BQDHCNJ
 A/R3kw4KPGs22b3HOu1i5Ewk7rVto/Xx8Rr6JKRuV5QcVLb0we5GKmqmqSucfZW7h7E=
X-Gm-Gg: AY/fxX5eVzoddH7f+W2xh0hSMnD2bx/cC68n/eneI/BTd/DHsGUhS0q3slJBLHFRluO
 gU6nHaW6vPmO7tDLjYZfvia7wUyvlnR4tgo2KImlQMz9gDlHG1LOR4iyRS8gKju1mRV7YQkarht
 SLgxZxCqZycwjx69Nmu3uibesudXctUeWFbo779zrk1JzTkLKNXNQ5p+xEsY1+VZLDueZOhtRb+
 A+Y7v7ulAN9ew2TjoD0wSr/jf/UaV14ve+jSRN6Akp7xFlptlpI036g7oKz4iinoiYQmaEVZpC7
 bD0YjxuHCKtwS8oGnroY6czjV4vBVz9IW3JuJ47B4Hf3J1HUks+mQOixJK7YxgZpUZhDaDZXG+S
 4idZT6aFRp665RkH2TGHKjwhC/n4r+ccHjliuk6vMFqopHj/lDcHITw0cC187ugWn+2AY11PNgY
 wqWWw+q6pNs/EC5pKhJlY1wyZy0z+fw0tPbeLTanEkLnW8ygSLX3maEbAo6dHboCjZulA=
X-Google-Smtp-Source: AGHT+IFiwgGa9az7asTZkSqNsXD/5kmss/UT/gRho0vs8iv7vsgx8BWXSRgpx481UKFL1tprmWw7hw==
X-Received: by 2002:a17:903:943:b0:2a0:a0cc:9994 with SMTP id
 d9443c01a7336-2a2f2833076mr290736305ad.47.1766870556135; 
 Sat, 27 Dec 2025 13:22:36 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f330d25esm232483755ad.0.2025.12.27.13.22.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Dec 2025 13:22:35 -0800 (PST)
Message-ID: <54a238fa-2946-4df9-ae6c-ee30ab10fb46@linaro.org>
Date: Sat, 27 Dec 2025 13:22:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v8 1/7] hw/arm/smmuv3: Extract common definitions to
 smmuv3-common.h
To: Tao Tang <tangtao1634@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20251224034647.2596434-1-tangtao1634@phytium.com.cn>
 <20251224034647.2596434-2-tangtao1634@phytium.com.cn>
 <1c56c2d4-d472-4ec7-b3f2-22c7b4e935fb@linaro.org>
 <9388d28b-1c94-4863-b295-68eb84595501@phytium.com.cn>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <9388d28b-1c94-4863-b295-68eb84595501@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

On 12/26/25 9:01 PM, Tao Tang wrote:
> Hi Philippe,
> 
> On 2025/12/27 06:45, Philippe Mathieu-Daudé wrote:
>> On 24/12/25 04:46, Tao Tang wrote:
>>> Move register definitions, command enums, and Stream Table Entry (STE) /
>>> Context Descriptor (CD) structure definitions from the internal header
>>> hw/arm/smmuv3-internal.h to a new common header
>>> include/hw/arm/smmuv3-common.h.
>>>
>>> This allows other components, such as generic SMMUv3 tests or test
>>> devices,
>>> to utilize these definitions without including the specific SMMUv3
>>> device
>>> internal state.
>>>
>>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    hw/arm/smmuv3-internal.h       | 255 +------------------------------
>>>    include/hw/arm/smmuv3-common.h | 268 +++++++++++++++++++++++++++++++++
>>>    2 files changed, 269 insertions(+), 254 deletions(-)
>>>    create mode 100644 include/hw/arm/smmuv3-common.h
>>
>>
>>> --- /dev/null
>>> +++ b/include/hw/arm/smmuv3-common.h
>>> @@ -0,0 +1,268 @@
>>> +/*
>>> + * ARM SMMUv3 support - Common API
>>> + *
>>> + * Copyright (C) 2014-2016 Broadcom Corporation
>>> + * Copyright (c) 2017 Red Hat, Inc.
>>> + * Written by Prem Mallappa, Eric Auger
>>> + *
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + */
>>> +
>>> +#ifndef HW_ARM_SMMUV3_COMMON_H
>>> +#define HW_ARM_SMMUV3_COMMON_H
>>> +
>>> +/* Configuration Data */
>>> +
>>> +/* STE Level 1 Descriptor */
>>> +typedef struct STEDesc {
>>> +    uint32_t word[2];
>>> +} STEDesc;
>>> +
>>> +/* CD Level 1 Descriptor */
>>> +typedef struct CDDesc {
>>> +    uint32_t word[2];
>>> +} CDDesc;
>>> +
>>> +/* Stream Table Entry(STE) */
>>> +typedef struct STE {
>>> +    uint32_t word[16];
>>> +} STE;
>>> +
>>> +/* Context Descriptor(CD) */
>>> +typedef struct CD {
>>> +    uint32_t word[16];
>>> +} CD;
>> Pre-existing: should these be QEMU_PACKED?
> 
> 
> Thanks for the feedback.
> 
> 
> I tried adding QEMU_PACKED to STEDesc/CDDesc/STE/CD in smmuv3-common.h,
> but that means some call sites need updates.
> 
> For example, with packed structs, this triggers
> -Waddress-of-packed-member (and becomes a build failure with -Werror):
> 
>       le32_to_cpus(&buf->word[i]); // smmu_get_ste function in
> hw/arm/smmuv3.c
> 
> It needs to be changed to something like:
> 
>       buf->word[i] = le32_to_cpu(buf->word[i]);
> 
> 
> Do you prefer that I send an extra commit to fix all affected call sites
> and keep QEMU_PACKED, or should we instead drop QEMU_PACKED and add
> compile-time size checks, e.g.:
> 
>       QEMU_BUILD_BUG_ON(sizeof(STEDesc) != 8);
>       QEMU_BUILD_BUG_ON(sizeof(CDDesc) != 8);
>       QEMU_BUILD_BUG_ON(sizeof(STE) != 64);
>       QEMU_BUILD_BUG_ON(sizeof(CD) != 64);
>

I think it's not really needed.
Those structs have only one member, which is an array, thus contiguous, 
so packed attribute will have no effect in practice.

> Best regards,
> 
> Tao
> 


