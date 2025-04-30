Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53AD6C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 18:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uABvA-0001tD-7P; Wed, 30 Apr 2025 14:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uABv7-0001rC-MU
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:12:33 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uABv5-0004fW-4S
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:12:32 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-223fb0f619dso2037825ad.1
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 11:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746036749; x=1746641549; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Oo5VAC6FFiaiCNIRU7t1i8OeYPVGZfcVM9VeES1ffjw=;
 b=Zs63d1rXdUNVoEavZXoaeEuoQ58vdt/g5NBjpRgrjrzTfLLKqe2QvEjzvVVhvfiIK8
 SsBZYhzjxZHs615WuXn3fZpUdEqjt9L2KfVSsDmhsITaIXh+3McbmqkRKtmNU9tf+g/y
 fBzxQyHl7ADAypgInoFDsk9nKYaXNFtQ3Z+pGI0+wOI8Wslz2yW4Hkty/N0VUuLfdW/6
 KdowQPYYSQ19jCdrtjEER+OQTRPemeL1SVhtPCak4gX/usy3bJEo60J4H+PxlJnJ6MSc
 +4UsuzGn6482ZKNbJ//TV9x8afyC8x01fTwljawHyS0C/PETveO2mc3MPNLbyslx563+
 nJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746036749; x=1746641549;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Oo5VAC6FFiaiCNIRU7t1i8OeYPVGZfcVM9VeES1ffjw=;
 b=CGnStoBdySsaGl3Md8K0m3pI6BLCvRggpb/rKLPtRZy9MWtvh5shmd1KN4GAOegrPH
 NcLfc9cWnYEnUt1UXyQEEjGb4vIV1W1NhCrfO6b9VoG7kLOCOsiofZwkqDHs+JfYKxsW
 564G90GK9sNTBCsnWIQm+No0EjPMb6i78Vq5e/rSE5XpyK89w/SobiJolLUQ3JZd4HKZ
 43xJ8F/48wb9P/b7bTDRnFiMDrapDQdY5doYP/KuxG1E9fb4dLhj6nGw0g+wEkwHik7O
 IzokmjQKetSZb9O/WxlKqV6SbGj3cf4WOiPfgbHs6kSFdGyxa4TROW3nGxow0mE+ulHV
 vGVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMb42GuHx4syQGZQXVKs1eEH2JKg44XQuHgdpC7UaaA/aiakuhznmcok2AbjMtmNBuRHRcYmn0pwOh@nongnu.org
X-Gm-Message-State: AOJu0YxmPlqnlPV0BpUlkKzmQYNwJNyPCQYtLzvSi2qpuXj/B/DnY/EG
 +5TfHhEZNN9jB963/iyIkjIB4pqlo3U+7fDkL/Mg+1sId4vo2X55labrLC7iEPc=
X-Gm-Gg: ASbGnctTqM1gCMt6qEZ9yzdrzSyC58vf427WHWzwo9u2+D9roCBfwYvCkfHGST96Poh
 oKse1nkM5LzskuPHQutV4nB75tYem5JYOF6wqVZTOiEf4G/Kw/UItI61aGd3u3bjyoSrVDBnIBn
 LFgBQqryMi2yisAIIkfMOeopmzEjyBxTnqM6sNbRXF52K4svdqSexoacWXmHKSZHVet11WFHz0f
 B58EUmFzZRF+xRn9ykE3LdA0NDroAcmGePK6aOjk9XnknPxgKsB+uOADePgr0iWR4Zan/OYiq/D
 kmUQN9mRbS7LEZmF+rtBGkuQQiC/Q95Cg4GAhbE2+sB3LeoeQMlkxA==
X-Google-Smtp-Source: AGHT+IGP+MnWTHimHJjTymYBKXMZ4Qzk3l4ccFmv0XPl9j5klcCO560yxO9CYx3CLEU0CQ445Hs1+g==
X-Received: by 2002:a17:903:144f:b0:220:fce7:d3a6 with SMTP id
 d9443c01a7336-22df3508d30mr68259535ad.23.1746036749533; 
 Wed, 30 Apr 2025 11:12:29 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4d76f4bsm125670985ad.49.2025.04.30.11.12.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 11:12:29 -0700 (PDT)
Message-ID: <c5bd354b-15e9-4f44-b768-8d2ded4d0e5a@linaro.org>
Date: Wed, 30 Apr 2025 11:12:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel/build-environment: enhance MSYS2 instructions
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250305213853.3685771-1-pierrick.bouvier@linaro.org>
 <b28bf347-aa8e-405e-8009-025aaf61a984@linaro.org>
 <88d6e264-4793-4095-8bb6-bc45621abeea@linaro.org>
 <06666850-90a1-4b4a-b454-53df477de215@redhat.com>
 <42a0987f-4f51-4d36-a3f5-1daf267c3e0d@linaro.org>
 <82b79386-ee34-4f06-8e61-76f47b4aaad7@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <82b79386-ee34-4f06-8e61-76f47b4aaad7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

On 4/30/25 10:54 AM, Thomas Huth wrote:
> On 30/04/2025 16.34, Pierrick Bouvier wrote:
>> On 4/30/25 3:09 AM, Thomas Huth wrote:
>>> On 28/04/2025 21.35, Pierrick Bouvier wrote:
>>>> On 3/24/25 10:47 AM, Pierrick Bouvier wrote:
>>>>> On 3/5/25 13:38, Pierrick Bouvier wrote:
>>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>>> ---
>>>>>>      docs/devel/build-environment.rst | 4 ++--
>>>>>>      1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/docs/devel/build-environment.rst b/docs/devel/build-
>>>>>> environment.rst
>>>>>> index f133ef2e012..661f6ea8504 100644
>>>>>> --- a/docs/devel/build-environment.rst
>>>>>> +++ b/docs/devel/build-environment.rst
>>>>>> @@ -97,11 +97,11 @@ build QEMU in MSYS2 itself.
>>>>>>      ::
>>>>>> -    pacman -S wget
>>>>>> +    pacman -S wget base-devel git
>>>>>>          wget https://raw.githubusercontent.com/msys2/MINGW-packages/refs/
>>>>>> heads/master/mingw-w64-qemu/PKGBUILD
>>>>>>          # Some packages may be missing for your environment, installation
>>>>>> will still
>>>>>>          # be done though.
>>>>>> -    makepkg -s PKGBUILD || true
>>>>>> +    makepkg --syncdeps --nobuild PKGBUILD || true
>>>>>>      Build on windows-aarch64
>>>>>>      ++++++++++++++++++++++++
>>>>>
>>>>> Gentle ping on this trivial change for doc.
>>>>>
>>>>
>>>> Another gentle ping on this trivial doc change.
>>>
>>> Not really my turf, I don't have much clue about the MSYS2 environment, but
>>> since there were no objections, I can add it to my next PR.
>>>
>>
>> Thank you, that's appreciated.
> 
> Could you still please provide a proper patch description, as Daniel suggested?
>

Sure.
I just sent v2: 20250430181047.2043492-1-pierrick.bouvier@linaro.org

>    Thanks,
>     Thomas
> 

Thanks,
Pierrick

