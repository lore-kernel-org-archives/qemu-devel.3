Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63186E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 23:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWO5D-00060m-85; Fri, 10 Jan 2025 18:06:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWO5A-000602-SI
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 18:06:24 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWO59-0007Ms-48
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 18:06:24 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-436341f575fso27253535e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 15:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736550381; x=1737155181; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9WvEiz7oRaAe+ed3CIaBlI+rsVdRU+nVSLZIrb/e8xA=;
 b=p8hpos9V2g6UVsKl6qII9wL96ky2Ej6Si2Wpq8s8EF0AfXE0LtXdZX3/V+69OtQCfK
 oTevlEyNF5AZ5C7twm9H9NDMRJBpsrwl9yLYvwOwFr/KIxxTWUmk4hfeYnMJkatUyWsC
 ogKrdDSn1ECExMhzlMYzzxAVQ2sJn+pBj9N7611ySqkfL/TXQaAw4F+K+rajkMzfv7kj
 2/xQbuxCxHp4f/BRH+y70VuzhZYGu5h0Fw93RnA1U8JJcYBGWvNqlejVP3UDxCP8/duS
 4XKP233EL3gbXW1SNYNooQFsJCtoXQXXZOWl5ddBsstJCYfAmDPzdOVT1g3VOIgP9AgE
 lZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736550381; x=1737155181;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9WvEiz7oRaAe+ed3CIaBlI+rsVdRU+nVSLZIrb/e8xA=;
 b=cDZJnsrICZOTbMZiwt/PbUWC2+vEjhxphSDU5yYX60U+w4AmFNYxDrOgWZk8Z/Bm1x
 CSYdkixpClPQw4IV0ikAY7THoWoWNtZpajmqW2HG+Tge/EvWfA8naOzYO7ygPRLG5RQe
 QqdBH0tq8Xc+3qqjh7w5gvmfruex/0YexeNSC9fxV4ipR6n0rApUDDte877r33bj16wL
 m8JztRIKiqWJnA+R9rxTd7I4zny1RqHJrcCvkfT1Tbt2WSDMYZG646pHYrrvCvjEzSH5
 aeAMrrB3UJHvXTR/mFd7B7wr7/NmOtLitfLaz5C17DjiGiYh0VRq6rPXa325CcO4gLlm
 7vmQ==
X-Gm-Message-State: AOJu0YxiR0oWdLS7ZRUHRL7zK7G+b6O+IWUSMtHjFuSxMXehEMK0WQny
 hwW+wrq8Q7EVtbX9+M3Zun6h2hikcPU7y2ghLtwvZIYf+d22L1t48mQrliu5p1Y=
X-Gm-Gg: ASbGnctCIViVSt53YKxL7X6lB9CzEGPC9SJLXYqV6rJXY30qhgOkoVg7i/wt1sq2JIf
 16c9yVdZJPDqsIK68b043VfGJ5RDoaHshJTIOE8Hf7L6ECkhEhnRzR2av+EPoOvqDemVvaPaf9r
 I56VLhvaduXssY105LrjHoUcDQnijxpdE2E+n0Ag3oDjiF2/hLl0Yp6icUB/Uk31Bx0B6uE4cTx
 0gkkHTjihHCtnbkwPL35kqflGsDwaKjoMPzkWzRmvUF8RbTlpPlncsqWhyM77uzRIL5jiV/Cgom
 8E0cN2HVFpVeG4wx3kNeVLSaeyS/HQ==
X-Google-Smtp-Source: AGHT+IHpF8D887abFDPO14FrPzkdLY625uKWEyjv9MKG+wSN5u5jA2Z7ku3bOO8lVQCcI0WKqUYrDA==
X-Received: by 2002:a05:600c:3c85:b0:436:18d0:aa6e with SMTP id
 5b1f17b1804b1-436e2679a7cmr131881975e9.5.1736550381551; 
 Fri, 10 Jan 2025 15:06:21 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9d8fba4sm65855165e9.4.2025.01.10.15.06.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 15:06:20 -0800 (PST)
Message-ID: <11eae685-4bf4-4d64-8cd9-733775df82ed@linaro.org>
Date: Sat, 11 Jan 2025 00:06:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] docs/system/arm/virt: mention specific migration
 information
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20241219183211.3493974-1-pierrick.bouvier@linaro.org>
 <20241219183211.3493974-4-pierrick.bouvier@linaro.org>
 <CAFEAcA-LYWhtFaUanq_qS8nDEVdhDOhDR2kcKv8Ch_5fKSnv-Q@mail.gmail.com>
 <331d0b7b-40db-4a6b-80ba-178892f60506@linaro.org>
 <77f1cf6d-afba-4311-a15b-50594cb5fda0@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <77f1cf6d-afba-4311-a15b-50594cb5fda0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 10/1/25 23:59, Pierrick Bouvier wrote:
> On 1/10/25 13:29, Philippe Mathieu-Daudé wrote:
>> On 10/1/25 17:30, Peter Maydell wrote:
>>> On Thu, 19 Dec 2024 at 18:32, Pierrick Bouvier
>>> <pierrick.bouvier@linaro.org> wrote:
>>>>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> ---
>>>>    docs/system/arm/virt.rst | 14 +++++++++++---
>>>>    1 file changed, 11 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
>>>> index d25275c27ce..9f1457cf9a2 100644
>>>> --- a/docs/system/arm/virt.rst
>>>> +++ b/docs/system/arm/virt.rst
>>
>>
>>>> +VM migration is not guaranteed when using ``-cpu max``, as features 
>>>> supported
>>>> +may change between QEMU versions. To ensure your VM can be 
>>>> migrated, it is
>>>> +recommended to use another cpu model instead.
>>>
>>> This paragraph is good, though -- that 'max' doesn't work for migration
>>> is important, and we should definitely document that.
>>
>> Ah yes, I've been there. 2 close-by comments:
>>
>> - 'max' is not restricted to the 'virt' ARM machine, but this document
>>     is about it, what about other ARM machines?
>>
>> - More generally, "max" CPU won't migrate easily (in different versions)
>>     on all target archs.
>>
>> Not sure where to document that; maybe a generic chapter that can be
>> included in a board.rst template?
> 
> It's a good point.
> Maybe somewhere in docs/devel/migration, where versioning is mentioned?

Yep. docs/devel/migration/compatibility.rst sounds the best place.

