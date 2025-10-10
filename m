Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1118BCAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 10:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7AWt-00046Z-Iy; Fri, 10 Oct 2025 06:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7AWq-000456-S7
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 06:39:17 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7AWn-00070r-VA
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 06:39:16 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3ee15b5435bso1149895f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 03:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760092749; x=1760697549; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O9iVZ5Q3cW7hr/RUC/phwyUJA2GkOJxml1ASShhmT30=;
 b=rPG3wYuT6tqZwU97ZopYW6MRdU0vfg99E1+IpqKQXE7XiUgf4TeGFXgYtDslHNrg1a
 Ie4QjiNbRVhOmw5OrrYg/9e51zHAhe2Mms2GMEsKSxeeITh7wjkLBqMoJVj2soyj70PT
 c4PXfB00YGvHFUVEGhaelFl1y5h7vUc4wT5dL2+6vkppkk439uKPX/Kf2+Wdlcv2lcgG
 Ogpi6zRcVjfBLzQ0TpQRP4FuDl3UbbPWlSPxEq/t/8acmR3/tNtgsoDGm/VJKP0R719k
 qOJgzSG2PPxV5VVsPN9an0qumx1mxhwHL6GKaSQt24FpH50IHmRSqXjhLoj3GikJK1Hr
 z0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760092749; x=1760697549;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O9iVZ5Q3cW7hr/RUC/phwyUJA2GkOJxml1ASShhmT30=;
 b=TAqr/Nm0ucMoVSOqQxhXWbPEEeDTR0lg2Lzf52axp4s6spV/kDr6W+hH8ttBwlQ3NE
 gFhckxqtQVzEU8V4FToKI2+kIR0ipeaLcwJaZ9xsecHoYU6tNaB+FgBgi2GkJBzaJuv7
 oGa4ci20nWxvnetC6xfmy0luqzfDeMAaUMNnLg0fyZYA2vKhCyaGfnrfxIAGiptK8ehn
 J+SGBwOdaP12y6vGj52UwexzG28/7IxVOqPSRSPYYaxC9SIdBhfN/VGZsErJJkmjHjAs
 HhdUlpv96ZuTHARMVoDALvEiwQEDivKVn270EE1v0yaH5VNWCTlmwLrt9gnvkjn1Vk9b
 lz8A==
X-Gm-Message-State: AOJu0YyVY8NwLIc3n0ZxqMOgQrwg7cOKlqBX+TIaLaOZrkbuXNShAcG+
 FERmhuWINxW3TVFyZuAliZ7J3gWLy8UD8cWRpquZ4bgZwBb4W+zEwbHIgC+lsaQ8zg8=
X-Gm-Gg: ASbGnctkL4wt+Ln2Ilg9aaNGAqydd79TB9AxKp9LKc3yrMdgX9t8rvqYgQoIRnI8ERt
 l83jSDEHSF9jMML0lYANi366OMEabYRPjVXwe550Sq3zYSH1ZqI0wNM44gwldsEGCNnMcc94Lzp
 QM2lQHzkQ5t07sWDD79VPbopqHJOck3l7qZ0M7He/W9WsbvFCpnxJk7xrTgLJ54QxhAZbpUj3kl
 3Sni0tKuhKVt6LgJRldTypKJXUmXypvn2nH5j9uXG/lbsAIji+puPbMrvs7fiAXQeRENIBXyUyl
 r9C11ZqWzwjJQdSueZH1h0XNkl0tVb5g75yV17I4UH3VE34B/CvHYb4XrWGe1oupdxuLVTQBPaw
 F9ULdN+ijmj0MehbX/6pIP7ChacDxwqpD3snMyChH1en2817lpB7Z06nF6gWHsfaB+oxqIu51Ad
 bHiPKCUhX+qrhz
X-Google-Smtp-Source: AGHT+IHXzCVOhUUfHUMsSRDTQ7ao8sC5dvSmKJ4A+9mi4LRist/2RzXc4gZO+0SOcNry84VRrgM9qA==
X-Received: by 2002:a05:600d:4203:b0:46e:6af4:ed83 with SMTP id
 5b1f17b1804b1-46fa9af9099mr80658745e9.23.1760092749352; 
 Fri, 10 Oct 2025 03:39:09 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5833dcsm3593962f8f.19.2025.10.10.03.39.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 03:39:08 -0700 (PDT)
Message-ID: <9c49aa4e-5402-42b6-9a80-ddd19bb81db5@linaro.org>
Date: Fri, 10 Oct 2025 12:39:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] buildsys: Remove support for 32-bit MIPS hosts
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>
References: <20251009195210.33161-1-philmd@linaro.org>
 <20251009195210.33161-8-philmd@linaro.org> <aOjH2b5YbeyBmiZS@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aOjH2b5YbeyBmiZS@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 10/10/25 10:46, Daniel P. Berrangé wrote:
> On Thu, Oct 09, 2025 at 09:52:10PM +0200, Philippe Mathieu-Daudé wrote:
>> Stop detecting 32-bit MIPS host as supported, update the
>> deprecation document. See previous commit for rationale.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   docs/about/deprecated.rst       | 13 +++++--------
>>   docs/about/removed-features.rst |  6 ++++++
>>   configure                       |  7 -------
>>   3 files changed, 11 insertions(+), 15 deletions(-)
>>
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index 67e527740c0..79cc34cfeb6 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -172,17 +172,14 @@ This argument has always been ignored.
>>   Host Architectures
>>   ------------------
>>   
>> -Big endian MIPS since 7.2; 32-bit little endian MIPS since 9.2, MIPS since 11.0
> 
> Did 'Big endian MIPS' refer to 32-bit, or both 32 & 64-bit ?  I'm guessing
> it was only 32-bit BE, given the heading of your removed-features.txt
> change.

Both.

* 7.2 deprecated:

   - 32-bit big endian MIPS host
   - 64-bit big endian MIPS host

   Not deprecated remaining:

   - 32-bit little endian MIPS host
   - 64-bit little endian MIPS host

* 9.2 deprecated:

   - 32-bit little endian MIPS host

   Not deprecated remaining:

   - 64-bit little endian MIPS host

* 11.0 deprecated:

   - 64-bit little endian MIPS host

   No non-deprecated MIPS host remaining

As of 11.0 we can remove what was deprecated previous 10.1.

> 
> But then did "MIPS since 11.0" refer to 64-bit little endian only, or
> both big & little endian for 64-bit ?
> 
> Given the wide variety of things all ambiguously called "MIPS",
> its worth being explicit....
> 
>> -'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>> +MIPS (since 11.0)
>> +'''''''''''''''''
> 
> ...so if this is 64-bit MIPS, big & little endian, lets say so
I'll update to "64-bit little endian MIPS".

> 
>>   
>> -As Debian 10 ("Buster") moved into LTS the big endian 32 bit version of
>> -MIPS moved out of support making it hard to maintain our
>> -cross-compilation CI tests of the architecture. As we no longer have
>> -CI coverage support may bitrot away before the deprecation process
>> +MIPS is not supported by Debian 13 ("Trixie") and newer, making it hard to
>> +maintain our cross-compilation CI tests of the architecture. As we no longer
>> +have CI coverage support may bitrot away before the deprecation process
>>   completes.
>>   
>> -Likewise, MIPS is not supported by Debian 13 ("Trixie") and newer.
>> -
>>   System emulation on 32-bit x86 hosts (since 8.0)
>>   ''''''''''''''''''''''''''''''''''''''''''''''''
>>   
>> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
>> index a5338e44c24..53829f59e65 100644
>> --- a/docs/about/removed-features.rst
>> +++ b/docs/about/removed-features.rst
>> @@ -896,6 +896,12 @@ work around the atomicity issues in system mode by running all vCPUs
>>   in a single thread context; in user mode atomicity was simply broken.
>>   From 10.0, QEMU has disabled configuration of 64-bit guests on 32-bit hosts.
>>   
>> +32-bit MIPS (since 11.0)
>> +''''''''''''''''''''''''
>> +
>> +Debian 12 "Bookworm" removed support for 32-bit MIPS, making it hard to
>> +maintain our cross-compilation CI tests of the architecture.
>> +
>>   Guest Emulator ISAs
>>   -------------------


