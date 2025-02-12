Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FEC6C021A0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 14:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiE94-0002AM-Ge; Wed, 12 Feb 2025 09:55:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiE93-0002AD-5C
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 09:55:21 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiE91-0003bA-87
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 09:55:20 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38dcae0d6dcso3182639f8f.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 06:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739372117; x=1739976917; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mt2icEd3aQS0C2Ql9TphBzrjfFN9naLhSkQ/xtNrwNU=;
 b=QUplkvn6ZMx32EyCOntK8Zti60IUoST6mRhNvzgqbrymjR1U4ZjqKooG+WijrgZ1tQ
 9lzvwz5zSl55J1UphCkCkTXUUUpPQFGilC2ZsVgUjBN3Afv57pSHNIbr47zgNpKsHaQg
 0oj2LBUukPOMYYSHMQ8Cak7np+P4bsa7R7gOlWxQAiOyXbuWP28DIsXa4MBLjT8Z1dQ7
 9K8vB4T8+zxzaM6dj4zxeixy9Ya1nWA7yTWQYH+hq6KwAhpw7lSNgZkJxI+2/1rmtuRR
 e27R3xQCsdhQ7FoesxNKEckOxd8ZjoziXYr1fiKo3PJp5bW3yCzR+pvrRhzwYIch7+3f
 4smw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739372117; x=1739976917;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mt2icEd3aQS0C2Ql9TphBzrjfFN9naLhSkQ/xtNrwNU=;
 b=oPow9GQgE8K85FfOzVnQ8sKS+2Q5QpOA0VFKTsjyovprN0e5cb7clN8XJrKjmpkJv6
 0tnzAfXHciTeo5W8aLe7oZJUVq+c6lEHRnWcENRDWuNcNy/5oTVYGuXIJ7aO3SbBEj/p
 wXkFU3eiXtsZTv1jWx5e2NgC5YdsQBuIRPbnrEj3MOUgFeJ8XadgmzJM8O6xChZClZg0
 wIYDHLh5yrh9k1xCQLc2TIWbDQ6PUzc7xzlSPt5unmavCmS5yPdGWQB8svQki2DBYsf6
 LTYjAS2g3jJFXK++p6ZlMMWvB365YCFvLvPY+cmEzzIKh7buNO3IULwen3zQj2qN/XIm
 n+sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+J39XrsWfp48/yv34luWUH2WLsENNaravluGbzboqaJrdC69nFKul7z+hvGaIPXCjfu0So+wM+Js1@nongnu.org
X-Gm-Message-State: AOJu0YwoYH0A8v/5jzMEFiouSMMNyFgCemWiayxkmb7PRu9N4QaWTVkX
 VG5oRbXlf0H53plm4pI89gjjEWwdx7F4DWOOsDH1xcE8s0UFJpVPSgIq6kUn9U8=
X-Gm-Gg: ASbGnctnr7/IESplj5tyM8MEFH1AkzNlIKmhSMBP5Nd5Nfd81lhZD5tyqzbPRfrZxGT
 UrV8bTKihCfdj5+q5Pck3Db4B3cDWEPBdNvH7QPp9xCkfT5Qmn2hUeh3OUXjXloR0uRXGhyWG4y
 Oln/h++2ocoRusWbEQ5WwEfVgTjKgxsPPdJ5VGoviz4rXUjbUI9y9nwQApOjbDnUC8dZ12sOoMQ
 xxCsiAhBQ0KP86DapCC3ndSa7zJ4S2Q4f/dWWE54Y+yIn6+9syBpoU0BgNahta9H1vKOVKrtRCu
 Kg5x2Q7NOf1K068Nr3hIPAXpIsHbOghIa6NpgAi/lomRENMsPAT8Msy4EQU=
X-Google-Smtp-Source: AGHT+IGcbXDMCFB7ZO7WBaDSgAwiISuYmGN61nYQxvl2wKaSHMmQ5JTYca+TK6LoDSAbZPAzXf/2SA==
X-Received: by 2002:a05:6000:400f:b0:38d:e572:4db4 with SMTP id
 ffacd0b85a97d-38dea2e6942mr2917434f8f.43.1739372117112; 
 Wed, 12 Feb 2025 06:55:17 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395cf084d5sm8941445e9.1.2025.02.12.06.55.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 06:55:16 -0800 (PST)
Message-ID: <518aa8ee-ccd7-411f-9ec7-2b09a791156b@linaro.org>
Date: Wed, 12 Feb 2025 15:55:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] os: add an ability to lock memory on_fault
To: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org
References: <20250212143920.1269754-1-d-tatianin@yandex-team.ru>
 <20250212143920.1269754-2-d-tatianin@yandex-team.ru>
 <8099a911-88a1-4eed-a17c-5a18e25b4d68@linaro.org>
 <be37d63c-b1c3-4c76-8113-0bad556aef37@yandex-team.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <be37d63c-b1c3-4c76-8113-0bad556aef37@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 12/2/25 15:51, Daniil Tatianin wrote:
> On 2/12/25 5:48 PM, Philippe Mathieu-Daudé wrote:
> 
>> Hi Daniil,
>>
>> On 12/2/25 15:39, Daniil Tatianin wrote:
>>> This will be used in the following commits to make it possible to only
>>> lock memory on fault instead of right away.
>>>
>>> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
>>> ---
>>>   include/system/os-posix.h |  2 +-
>>>   include/system/os-win32.h |  3 ++-
>>>   meson.build               |  6 ++++++
>>>   migration/postcopy-ram.c  |  2 +-
>>>   os-posix.c                | 14 ++++++++++++--
>>>   system/vl.c               |  2 +-
>>>   6 files changed, 23 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/include/system/os-posix.h b/include/system/os-posix.h
>>> index b881ac6c6f..ce5b3bccf8 100644
>>> --- a/include/system/os-posix.h
>>> +++ b/include/system/os-posix.h
>>> @@ -53,7 +53,7 @@ bool os_set_runas(const char *user_id);
>>>   void os_set_chroot(const char *path);
>>>   void os_setup_limits(void);
>>>   void os_setup_post(void);
>>> -int os_mlock(void);
>>> +int os_mlock(bool on_fault);
>>
>> If we need to support more flag, is your plan to add more arguments?
>> Otherwise, why not use a 'int flags' argument, and have the callers
>> pass MCL_ONFAULT?
> 
> Hi!
> 
> I chose this approach because MCL_ONFAULT is a POSIX/linux-specific 
> flag, and this function is called in places that are platform-agnostic, 
> thus a bool flag seemed more fitting.

OK then.

