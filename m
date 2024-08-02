Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5092CC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 13:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZsGW-0007m3-7s; Fri, 02 Aug 2024 09:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZsGU-0007g8-Nj
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:24:14 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZsGT-00047D-36
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:24:14 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-428243f928cso32254785e9.3
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 06:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722605050; x=1723209850; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZNii2MPtYLiVNY0jl5Km6X2OnzPpBlIH+aplfeD/nRA=;
 b=rVo3G5VU8lFJ3ZyvyYTSPadTH92tEYlILxrRESXmET5eVQ5tTy7pjzMd/Z1CPen4Vc
 TucRw91bmvvkjQ9IeX/cuNoglYdU/VIdaZqEAJ8HRAxesfWEajf2gaygAl5N9Ggb5NLj
 j/fYuRT7w/E81UJn5dYOLzkz2Oj3/bAwZIjEiD4m80RN9WVQftswsmIM/fyiXUGQX547
 c501klN+nInCmW+UMbLlllTYekXE26TBj3ulLcfUzLgW2ad10vD0cGZ1ZVNxa/+tuhrI
 7C4Se0kCtad4sgQ56TXTxoTm4YNhXFo+06yN1p3iibup9Lytp7PdGQ8v7ac/Ti+CMVfR
 13NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722605050; x=1723209850;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZNii2MPtYLiVNY0jl5Km6X2OnzPpBlIH+aplfeD/nRA=;
 b=nMyHUbvAPwOfY7Xdhh6kBJgGROMQ9AVGpBurMdZ5Gpq/X0C8I6dhhZLrAWzklYMpSY
 azfdw7RtI66XVYN0/eX2gN/3LEDmSohDTywIWijfKzwksMYUQb75du8tjtoczW604FgX
 LLG+aEO9HVzx6spIIjBfZeEqxCuN3mdRMjvQ+9gvxK1Zkrrhn10bOcCplss3+MxNXRZa
 2GcDqw++dKDmIKEt10/bYVRqk/e0/mJdaGtpMaFUe+HwP7Ck5VKNWO93n4q2fpU04W6F
 bF0Qme2TTYwYL0t8L7X2+3KKIP4NaOQ4KHysgGXffAM23lop4zTmXHY0VbkgGHZt3dx6
 UKqA==
X-Gm-Message-State: AOJu0YzE0k73CfT3XC3r1BpSJQ8XXC9fDOQccNvu1l3WUFZiF/DG3+k2
 xm4pHhvAxrRjP6JFtwPMvUQEaRPFAF5zIMyWXGRoHRXOTIy7yf5s964xyLfph3I=
X-Google-Smtp-Source: AGHT+IHLFoxI85HsvCrKHVuZROKGjhhLXTGQeeilCeIA9QCr2TVRkLSnUUdYhM7LJDhrD45KUr9O0g==
X-Received: by 2002:a05:600c:3d8d:b0:426:6710:223c with SMTP id
 5b1f17b1804b1-428e6b03f2cmr22490005e9.9.1722605050254; 
 Fri, 02 Aug 2024 06:24:10 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.94])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282baba5f2sm95189945e9.26.2024.08.02.06.24.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 06:24:09 -0700 (PDT)
Message-ID: <b940de19-6e65-4d00-95bc-d7ec88c7afb0@linaro.org>
Date: Fri, 2 Aug 2024 15:24:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/24] tests/functional: add a module for handling
 asset download & caching
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-9-berrange@redhat.com>
 <b9a55935-ccf6-4f13-9437-52608afc0db3@linaro.org>
 <Zqu_q1dXsPFjT4PP@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Zqu_q1dXsPFjT4PP@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 1/8/24 19:02, Daniel P. Berrangé wrote:
> On Thu, Aug 01, 2024 at 06:20:58PM +0200, Philippe Mathieu-Daudé wrote:
>> On 30/7/24 19:03, Daniel P. Berrangé wrote:
>>> The 'Asset' class is a simple module that declares a downloadable
>>> asset that can be cached locally. Downloads are stored in the user's
>>> home dir at ~/.cache/qemu/download, using a sha256 sum of the URL.
>>>
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---
>>>    tests/functional/qemu_test/__init__.py |  1 +
>>>    tests/functional/qemu_test/asset.py    | 96 ++++++++++++++++++++++++++
>>>    2 files changed, 97 insertions(+)
>>>    create mode 100644 tests/functional/qemu_test/asset.py
>>>
>>> diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
>>> index 2f1e0bc70d..db05c8f412 100644
>>> --- a/tests/functional/qemu_test/__init__.py
>>> +++ b/tests/functional/qemu_test/__init__.py
>>> @@ -6,6 +6,7 @@
>>>    # later.  See the COPYING file in the top-level directory.
>>> +from .asset import Asset
>>
>> For next patch?
> 
> No, the idea is that a test class can just do 'from qemu_test import Asset',
> so they don't need to be aware of the fact that we've split up the code into
> separate files beneath the qemu_test/ directory.

Oh indeed I missed that, thanks for clarifying.


