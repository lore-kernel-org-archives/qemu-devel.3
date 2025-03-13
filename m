Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3085C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 10:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsg8F-0006YL-Q8; Thu, 13 Mar 2025 06:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsg87-0006Xe-U6
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:49:39 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsg7x-0005l1-Tb
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:49:35 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43948021a45so6622395e9.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 03:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741862961; x=1742467761; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KZr7tAqupYotxFAT3768rv2+xIM1Zh3TECMg+P3I7cA=;
 b=bCJkX6Le4B6rgQKBu+hKyPg3HV7Gb4BtC/Ozcxv17pneCcihWDdOcdZK4wYI+BAMrI
 pBmG/vWHSr31ybq92eFNhdjDZIxRbaarVq+lUNy6eOHVP3ANn5hKs8M4DgAyRsmXp8O2
 59fpXsO6iRaCBWU2mQjR7Zb9rWVHSjZIOYLHM5wNixeZaY/KdMM9cnMCTn76ao7dZ9iB
 YlyQFhWsTVaQhg0hBMyrGOwWWvZgtRuPnqkzTW+34Uo/7TkCr7AewaRftGQRlC2PZftE
 cZo7ZvlEMgOC9BgEBtddzY/sjjrTDw2gfQ9Kse5pSz1P5FtvFnLUObd41MMQ7Pc3vflZ
 PfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741862961; x=1742467761;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KZr7tAqupYotxFAT3768rv2+xIM1Zh3TECMg+P3I7cA=;
 b=AIfBp2bxFxfyYbx/qkK7pH1ZPRK39v1803a1Vk66FK1PwwjTbV1Nto/eJGIMWtaSN7
 1HtFo7Db8XSX4KlwiuVjDsiZ+ATmrmMv10HXo6XoNZbvpkckNCtcqzDGV8JayakfYLZq
 aPQbSSdFFQzRYkNvZUZonXCElHRKXEs8tcmz8vcxkG7ZDUNiuXT7qsqvUr6zFhg0+FOr
 g1Kwrcb6nVvqKRElUNVX1gY0aafYYJy8WnwOuDhnvJl7smOdzhlXWAN96DILbsbc6Drk
 HE+1mF9euurOHmT7xhZ1QGDNl2pRisfyTP6GlzI3OtaZ4W6Z62AP7R7EG38DCp550HOA
 OO0g==
X-Gm-Message-State: AOJu0YwZuyUg+iT379ygX9F3yF86SoRhQZ9vJNgCMPPdF9dQZvlMW6MO
 2hiQpS6dCuqNI9DMnwjjeIH5AW/VrtWHoD7LaB/ouUBHGV6+/wvXXgPWdyQvnis=
X-Gm-Gg: ASbGncskBBLeAvSjm8dH8jjr9B55KPqG3H8MSOt3C5AMTtZ9wa5A2zT0HmL6saqUs6i
 5ksWTt+qB2b/Uos0N83OEj6Z/eS8MWzIzlMwYIjvca4G4HQCtdKvmCYBSMyu9WZ7c73fAcSyYUc
 aZI5Drq88H3P6dFfQ79mXtY0cHfN+R7jpBXGyBq81nNJHr6TC3xPYJODJ4/QxrEoBYJ8QOr2v9J
 vFvfVK4lggmuOdFS9yxZ4cU5cQZz26nF0g9MvfCVJ2O5IYPRTft5uK/yYIArRo3DZ85U9ktMefv
 laQx4dCoZYHFLQCalu7mrCVauk9rCJeLyYzHDC/4veq7bYg4HMlV/uUinMf3Lio2qwQDV00qBm7
 /qZawoENB50fN2OI=
X-Google-Smtp-Source: AGHT+IG3owF5YVO+29FDLMWEaG3rdyH/no1XWja8uD0E8T0HrvzCGiQk5MVRPUQeVysbpyj2zF/J+w==
X-Received: by 2002:a05:600c:5618:b0:43b:ce3c:19d0 with SMTP id
 5b1f17b1804b1-43cdfb7db88mr178611635e9.29.1741862960786; 
 Thu, 13 Mar 2025 03:49:20 -0700 (PDT)
Received: from [192.168.1.20] (88-178-97-237.subs.proxad.net. [88.178.97.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d0a7310e1sm49797505e9.6.2025.03.13.03.49.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 03:49:20 -0700 (PDT)
Message-ID: <fff0b105-a317-4148-82d1-ac847a3fce6e@linaro.org>
Date: Thu, 13 Mar 2025 11:49:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/72] ppc-for-10.0-1 queue
To: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20250311125815.903177-1-npiggin@gmail.com>
 <CAJSP0QWLW+YwsLeJ1496Q8uT92E3wUDsOiVyzVFwrOFid3FUWA@mail.gmail.com>
 <71d0b4bf-7732-44f2-8796-f19eb2822958@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <71d0b4bf-7732-44f2-8796-f19eb2822958@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 13/3/25 07:13, Thomas Huth wrote:
> On 13/03/2025 03.34, Stefan Hajnoczi wrote:
>> On Tue, Mar 11, 2025 at 8:59 PM Nicholas Piggin <npiggin@gmail.com> 
>> wrote:
>>>
>>> The following changes since commit 
>>> 825b96dbcee23d134b691fc75618b59c5f53da32:
>>>
>>>    Merge tag 'migration-20250310-pull-request' of https://gitlab.com/ 
>>> farosas/qemu into staging (2025-03-11 09:32:07 +0800)
>>>
>>> are available in the Git repository at:
>>>
>>>    https://gitlab.com/npiggin/qemu.git tags/pull-ppc-for-10.0-1-20250311
>>>
>>> for you to fetch changes up to 0f17ae24b53eaab4bbe9cfab267c536e2f7fdbd7:
>>>
>>>    docs/system/ppc/amigang.rst: Update for NVRAM emulation 
>>> (2025-03-11 22:43:32 +1000)
>>>
>>> ----------------------------------------------------------------
>>> * amigaone enhancements, NVRAM and kernel/initrd support
>>> * Next round of XIVE group/crowd changes
>>> * SPI updates for powernv
>>> * Power10 2nd DAWR support for powernv and spapr
>>> * powernv HOMER/OCC fixes and improvements for power management
>>> * powernv PNOR support
>>> * Big cleanup to move TCG code under ifdef or into its own file
>>> * Update SLOF and skiboot ROMs
>>> * Remove 405 boards and deprecate 405 CPU
>>> * Add support for nested KVM "hostwide state" data.
>>
>> I fixed a CI failure on FreeBSD 14 hosts because of the __packed macro
>> redefinition in hw/ppc/pnv_occ.c:
>> https://gitlab.com/qemu-project/qemu/-/jobs/9388495246#L5857
>>
>> Here is my fix in the merge commit, if you prefer a different fix,
>> please send a follow-up commit:
>> diff --git i/hw/ppc/pnv_occ.c w/hw/ppc/pnv_occ.c
>> index d9ce35a4d6..bda6b23ad3 100644
>> --- i/hw/ppc/pnv_occ.c
>> +++ w/hw/ppc/pnv_occ.c
>> @@ -394,7 +394,9 @@ type_init(pnv_occ_register_types);
>>   #define s64 int64_t
>>   #define __be16 uint16_t
>>   #define __be32 uint32_t
>> +#ifndef __packed
>>   #define __packed QEMU_PACKED
>> +#endif /* !__packed */
> 
> We should never define such macros in userspace - everything with two 
> underscores at the beginning is reserved for the system and the compiler 
> and must not be created by the userspace code.
> Why doesn't this code use QEMU_PACKED directly instead?

Similar question with __be16 / __be32.


