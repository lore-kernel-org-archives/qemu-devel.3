Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E72EC54ED1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 02:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK6Ea-00053A-G6; Tue, 27 May 2025 22:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uK6EW-000511-Ka
 for qemu-devel@nongnu.org; Tue, 27 May 2025 22:09:33 -0400
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uK6ET-0004r0-BQ
 for qemu-devel@nongnu.org; Tue, 27 May 2025 22:09:31 -0400
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-86feb84877aso971295241.3
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 19:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748398168; x=1749002968; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wtbq2h+y9kthJuDsybddcS0fiWltNSujth8UJ2mhJ14=;
 b=j1mV7IEWLDMce7CIpTCeJsefdlIwR/MVbvcIZSOIPKj9z17X8F+Tc+g22VEJj8LbMg
 2zjNGY8jxrhrTwR0hLG9553PbAjHyGv9SUI9gAx74Di3Jl5UlJydeAW2o9O+Zkz8KzOh
 oynR6FgW7vlgcqxMiHbTuSsZb53NnWTv1f7i1tQW230UMcERjHmZwmnzPZ8dsWtMuyjG
 8FZAAxHO9apYOWx6YG4+fDSrWjF+H8vf5TMnQiDGIhHKtgZkr1kczS3slmLJ0Baj0prd
 1vH+mmyfgdO57vTAMlmhoRPakunRgoM8r/NoBGa0vOMvKT0qIB7u/l8+EMkbyDOycT/U
 54TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748398168; x=1749002968;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wtbq2h+y9kthJuDsybddcS0fiWltNSujth8UJ2mhJ14=;
 b=xPYUzU67P6/rxAFZZM7sUIjRbW2tmAzlzwzhqzlvPEymP3QvZCsTtA+OKDQmCnaU57
 1agDBtI8OmqiZCV/7p117EMP5QtIpDjTmBwQ8U7jRl3A8f+V2MOFhduNWOFR327IU1hI
 1JhVahhzzSZmZZXK0GX98K4LC1dMt8s2GLT5FoFHZlnFhWhAWou7QcFyt35q5JmOiKyL
 ks60ZZ0m3lLirhPeNjCpwfTfKw0p6fijyi8bX794lgybMMvibcDphnqeQQVoHupkKxkW
 94pSXR/qxyJCSU8MBOsjZae9mM2iTzM1dcUucYKydBxiIzgenef5ncXnebEdXjm8mo/d
 GmdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7WkXInY7SxY4v8vZrbsomjXVHKjisMhpb8L8DZJFjF6yaOyZwqMGEHLhK2VXPVyErrFE22rPaRQPZ@nongnu.org
X-Gm-Message-State: AOJu0YzVRXBmHBWOXFPQ6QrPhuyC8kdEuHX+piHbLXQ4LetCkmYFA138
 bEY0uiZFDPwGPjsdllL7QWaS8yIfDaeq2ZffcfgYZmW05jleXA0kJRQJqNAiL9SNXUM=
X-Gm-Gg: ASbGncs83PcV9uYLJXxsBMuSEcIvC+fpJrVdZXCP2+JIPE2vmviMlRpDEi/DG5hYGgp
 YJ9tSCQ3eUKO9ltRlGw+hO7g6mqTWSUbTu+9UUASjG6m5XYkvKYhwtl+7vIsgizZP7LkB+Pb0EU
 H0tuJeuUZ+zBak0vGAquTy62lGQOpmso+UBLER9C4zAR0478o8ZflGlaSv7w4haGseQj8h8wKoP
 kVc/WYjYxhCaqvAMGX6CXstpkyl25tYnKmsYyBQQsQzcgrjzP0zsk3zVdRvW3VbOyj4SGHCHHfA
 mGXYJH8DJ1PcU/XH7HZMf3ZGXqj73av2MioRilMLmrHK3+3BvQVMV8CCOxY1Jll3wzCoXh7y3YM
 8SOIykX4YuaYfolemqrgaO/HV3xYGyQ==
X-Google-Smtp-Source: AGHT+IGZAjy0fZu4/FipeUhUSoiBaPcyKNc2/KS/gA8KsVt+YWu82yAS7NM8wp0Oxk5jnHeUp7UjTQ==
X-Received: by 2002:a05:6102:2ad6:b0:4e2:9826:b72a with SMTP id
 ada2fe7eead31-4e42418a79bmr12520169137.23.1748398168178; 
 Tue, 27 May 2025 19:09:28 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b402:6ba2:2066:dacd:9134:8586?
 ([2804:7f0:b402:6ba2:2066:dacd:9134:8586])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4e5a0307470sm113809137.17.2025.05.27.19.09.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 19:09:27 -0700 (PDT)
Message-ID: <b5e8dc94-913a-4582-9235-44dbe9bcb989@linaro.org>
Date: Tue, 27 May 2025 23:09:25 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tests/functional/test_aarch64_hotplug_pci: Update SHA
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 eric.auger@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org
References: <20250527150229.1617074-1-gustavo.romero@linaro.org>
 <20250527150229.1617074-2-gustavo.romero@linaro.org>
 <33015b21-bd6b-473f-8066-1df6c0c731aa@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <33015b21-bd6b-473f-8066-1df6c0c731aa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=gustavo.romero@linaro.org; helo=mail-ua1-x929.google.com
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

Hi Thomas,

On 5/27/25 12:11, Thomas Huth wrote:
> On 27/05/2025 17.02, Gustavo Romero wrote:
>> Update SHA for 'linux' and 'initrd.gz' images.
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> ---
>>   tests/functional/test_aarch64_hotplug_pci.py | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/functional/test_aarch64_hotplug_pci.py b/tests/functional/test_aarch64_hotplug_pci.py
>> index fa1bb62c8f..bb2c121503 100755
>> --- a/tests/functional/test_aarch64_hotplug_pci.py
>> +++ b/tests/functional/test_aarch64_hotplug_pci.py
>> @@ -20,12 +20,12 @@ class HotplugPCI(LinuxKernelTest):
>>       ASSET_KERNEL = Asset(
>>           ('https://ftp.debian.org/debian/dists/stable/main/installer-arm64/'
>>            'current/images/netboot/debian-installer/arm64/linux'),
>> -        '3821d4db56d42c6a4eac62f31846e35465940afd87746b4cfcdf5c9eca3117b2')
>> +         'd92a60392ce1e379ca198a1a820899f8f0d39a62d047c41ab79492f81541a9d9')
>>       ASSET_INITRD = Asset(
>>           ('https://ftp.debian.org/debian/dists/stable/main/installer-arm64/'
>>            'current/images/netboot/debian-installer/arm64/initrd.gz'),
>> -        '2583ec22b45265ad69e82f198674f53d4cd85be124fe012eedc2fd91156bc4b4')
>> +        '9f817f76951f3237bca8216bee35267bfb826815687f4b2fcdd5e6c2a917790c')
> 
> If the images reside in a subfolder of a folder called "current" there, and are changed in the course of time, that's a good indication that we should use different location for the test images instead, otherwise we'll continue to play SHA-updating-whack-a-mole forever here.
> 
> Could you please try whether it works with the images from the "20230607" or the "20230607+deb12u11" folder, too, instead? (see https://ftp.debian.org/debian/dists/stable/main/installer-arm64/ ).

Thanks for the review. "20230607+deb12u11" works fine and I chose it.

I decided to split these two patches so this one can get merged first
and doesn't need to wait for the ACPI PCI hotplug series:

https://lists.nongnu.org/archive/html/qemu-devel/2025-05/msg06331.html


Cheers,
Gustavo

