Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6745C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 14:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA8Wg-0008NB-OF; Wed, 30 Apr 2025 10:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uA8Wb-0008F6-RH
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:35:03 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uA8WZ-0008Bq-JZ
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:35:01 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7376dd56f8fso9857327b3a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 07:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746023692; x=1746628492; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NBgzcavwdDjclrrC+CCUvPhUAmfW5aJ/3QAHhQXFjgU=;
 b=oFN45bhanPLqMW5BtmAKhuUviFO/V1ieumtPjcPUZSGxPQ9PY/ndAhcuMskyPhst68
 EfFr+N9FnQo3LUlqnpZ69YRhfY18rlKPv3jbdzagkeu/9eDZzTwqswRK893c17w3zM+f
 iUvBoy4HBbcR0/ih2nWbT5kdm0ItMJi59mOxg2SVux58We/8aAfNr6ILjN2w8AEXIktd
 wV1hsBmpMkoyp0dL2EG9mlfwllmRvEuEH3jCki2zmDlbrbIYETn3ND351IwTgG1Xhy1u
 thlL/rteDCTsExqn9FjbQ1min2mO6QP0/HGHX8GPFM6KSzL8c/tVTzdBRqeTtWQtVdI7
 ALYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746023692; x=1746628492;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NBgzcavwdDjclrrC+CCUvPhUAmfW5aJ/3QAHhQXFjgU=;
 b=iSP5G6aBnwxnAHId/H+nDd1zBG2yObyueusn/7H7Hnayr7y/ipf0Kz3oQwU5ZCmg8h
 k7ZgGNmhwXXPmnWFS1TtbVdsw7InUptujiJlEkDog33tIL+Ef6eAU6TWP91Q+Cs/626f
 n1ueICNGeaQel1+U34o6fz7UwWOO49OaAZgA56nWlPxrKhlFqk+7EABerTqkK80mUZ3W
 ouSWxswz1HpZwIC1AZX1m01oa45o0dgi5adlyziEnOS6K5ZR0DEaIKRGomRIpeGv2s66
 xLtB1K1WRGHHRe7X1jPEbaQltUwq00ahJaAl0nV0MT1gGps447oMYyb3IjyuuiHQJm9z
 Hg7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQRrJQMhd6f87fKg3j7gGTtkb2IiBmqOExaoHFMqZ02kCOUc9MjRisMjIMpViY69elY1e2L9o4L0Jv@nongnu.org
X-Gm-Message-State: AOJu0YwFQSWsOS9Qd4HWhGkpa8ZrQDlcu7g0aLfgDRwbjIydGToK/JpZ
 XtQQmM0DeYDsyP7ZXPZWCw0tXBE2YOTQibKqq8R7yfIiMzZ0s/LwanqvLHYZPLY=
X-Gm-Gg: ASbGncuekTGWZKSvGxJMp5iyD2GdslsxlFi0Ui4ZD6yVcPQ/Aqq16/u1ml7Ybuleo5P
 snuyj+WeIRcl44CL37YApBCQH65ChrsvZHgYP6P49Ho2eOQ1+EKjsfAYGXbyvTxs67T4iYdcrdv
 ArJ8+OajP43TF0v+B4lMZdO/xxPkAvHB8nnn71Nqn528fmoCj7DLZcDWL+HC0FQ1XGwrxL1OwyL
 1vN0jse1jvL1710+yxXZUjbuWmFnYCia5HsF7Tu6PRFU8qPqLRtOg28Zaxqs+PMYpnPTgOHr394
 cvqdc6YL8IZz8aGqW7LSeSykxxlS6OkAfN4MCRbCcsrGd9SqhGkUTA==
X-Google-Smtp-Source: AGHT+IHvBVpRYFKLJXtKnLPwgMRqq9OO1ls+IKJ06waHSKQ4+di0DdW5FEyt9larc0d2mQ3X/ldptQ==
X-Received: by 2002:a05:6a00:139b:b0:736:bfc4:ef2c with SMTP id
 d2e1a72fcca58-74038793f8dmr4830837b3a.0.1746023692235; 
 Wed, 30 Apr 2025 07:34:52 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f770302csm10850448a12.12.2025.04.30.07.34.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 07:34:51 -0700 (PDT)
Message-ID: <42a0987f-4f51-4d36-a3f5-1daf267c3e0d@linaro.org>
Date: Wed, 30 Apr 2025 07:34:51 -0700
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
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <06666850-90a1-4b4a-b454-53df477de215@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

On 4/30/25 3:09 AM, Thomas Huth wrote:
> On 28/04/2025 21.35, Pierrick Bouvier wrote:
>> On 3/24/25 10:47 AM, Pierrick Bouvier wrote:
>>> On 3/5/25 13:38, Pierrick Bouvier wrote:
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> ---
>>>>     docs/devel/build-environment.rst | 4 ++--
>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/docs/devel/build-environment.rst b/docs/devel/build-
>>>> environment.rst
>>>> index f133ef2e012..661f6ea8504 100644
>>>> --- a/docs/devel/build-environment.rst
>>>> +++ b/docs/devel/build-environment.rst
>>>> @@ -97,11 +97,11 @@ build QEMU in MSYS2 itself.
>>>>     ::
>>>> -    pacman -S wget
>>>> +    pacman -S wget base-devel git
>>>>         wget https://raw.githubusercontent.com/msys2/MINGW-packages/refs/
>>>> heads/master/mingw-w64-qemu/PKGBUILD
>>>>         # Some packages may be missing for your environment, installation
>>>> will still
>>>>         # be done though.
>>>> -    makepkg -s PKGBUILD || true
>>>> +    makepkg --syncdeps --nobuild PKGBUILD || true
>>>>     Build on windows-aarch64
>>>>     ++++++++++++++++++++++++
>>>
>>> Gentle ping on this trivial change for doc.
>>>
>>
>> Another gentle ping on this trivial doc change.
> 
> Not really my turf, I don't have much clue about the MSYS2 environment, but
> since there were no objections, I can add it to my next PR.
>

Thank you, that's appreciated.

>    Thomas
> 


