Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F343C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 20:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKNoS-0008UH-8w; Wed, 28 May 2025 16:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uKNoQ-0008U1-RX
 for qemu-devel@nongnu.org; Wed, 28 May 2025 16:55:46 -0400
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uKNoM-0005fd-CD
 for qemu-devel@nongnu.org; Wed, 28 May 2025 16:55:46 -0400
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-4e45bfb885cso113935137.3
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 13:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748465740; x=1749070540; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=c1dW+MjMb1gwbQv9u5eh0QXnZTj7GjYzExak5PpiRHQ=;
 b=FylYPdCRA51fAhR8v3Fsamf5Q9zXmf9Lhp0QU2x2D9kWvDJzJ9P9SxFeeymo+HFawn
 rMxONENPSxkv1xMdvZcasbv7cbEXGWtFlwFEoWD1yffQWcFky+gUk9y5hnE0w/GNIw5N
 KAAKnMl8zr0po8V2e/vKac4OAynIM/B3KQarXw1h/Z1wUuENVlJt+Wu1j2fmRHaTpLBL
 5D8G1a+GR58/93q5KdEysMeBWTzLfmRwlN3jkJFUyIZncl0HqSGGyq79u9UVJoNqxVs6
 ORq9npBazN6RXJbUhfjlrOBoAyZZuLgX+zBBCJ5XuJa2uOu35iZ1rib/RDwUNjC/vRWf
 t/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748465740; x=1749070540;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c1dW+MjMb1gwbQv9u5eh0QXnZTj7GjYzExak5PpiRHQ=;
 b=th9IDUfvOOc9a17ZHz3H3/hoMnpLgYo/V60ggwKSrPIHw1EV3FIy5y84neQ1VjP++y
 SOexyxrMbUC1o2DPVR06NPlN46NPWCRaZ2D6TvTRKgKzEcByfwmzvVdWQofLG0eBEkto
 T3AcmtcsPh3oOqcXpmI1/Uz42AAIwN4x1w81kB3dEDGDS4cssVfyKu0irySo6Cu7gdaE
 ydlCSqnIwPLacrZF6kXSEdg0StyI5dGxwziS5KxfbijAbomsbMPepahd6IekQv+zzM+q
 rOm+O4gyfAaIq+ZVmXKy9YnfZqZ4zucGJqoVfrSaJ81KfVMh5ZgXV2/Bg+L9leaG4HtA
 nhOQ==
X-Gm-Message-State: AOJu0YxAvOX14vNlQDO9qvg4t+5h57k6m2rkdacobqFZoaOWuJeeUELP
 WbSzE4XnNBiC6Rx7Mot3ifVuVBYr4UAzDa+UO7OiUoVnv2QkjmxUcuL282pKmK2vZaA=
X-Gm-Gg: ASbGnctzrYyUet5qO7v27GyUVohWNZMu7DkSryzS8Zimw8t/eZnlrSabVgPd7ji+4s6
 Nymt27jHK+hGbr9CY4WVsuDWoYaa7VEcctuU/b/QhA/EqmYJhf1UON1HpyDHZOjY1LxIAONek8L
 mut/WO2a+nSAjBNk8nHGtUpSBL/g5E23Jx9lFvNaX7BUz9H41sUqOejhcII413xuGbAfV+UrKDX
 D0KM0q7FE4Xn96LDWgttNr/VQYwpjwxJWHtUnHBrCOyfAfRT76uFpusJTAzaoee4aJN0Ugp/nrE
 72pXEiV7wJe8Ba03NayenF2ta2RXcpYKKL6rO/P/d28zA97ok6pGqFQn2C9rFmOHriS4t/he+bQ
 nAKtC8OqZVF2FCM/UQfR31BQU9WhLgg==
X-Google-Smtp-Source: AGHT+IFOOELlhvuIbNRZh/Ks5IafJD2BJOdg3J5toZlMOkMTWajWNJeg7+zb16g2WbWNpn5Iqff5JA==
X-Received: by 2002:a05:6102:1613:b0:4cb:5d6c:9942 with SMTP id
 ada2fe7eead31-4e4240a445fmr16146479137.10.1748465739814; 
 Wed, 28 May 2025 13:55:39 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b402:6ba2:c792:c8df:e54f:dec7?
 ([2804:7f0:b402:6ba2:c792:c8df:e54f:dec7])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-87e2a390157sm43211241.27.2025.05.28.13.55.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 13:55:39 -0700 (PDT)
Message-ID: <559a5656-755b-4735-9578-64ecdf803bf2@linaro.org>
Date: Wed, 28 May 2025 17:55:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/test_aarch64_hotplug_pci: Update images
From: Gustavo Romero <gustavo.romero@linaro.org>
To: Thomas Huth <thuth@redhat.com>, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20250528014737.1630668-1-gustavo.romero@linaro.org>
 <f79878fc-b5d3-4b5c-a717-0173f9c50056@redhat.com>
 <7e019a90-8715-46ce-9bae-50b070d4904d@linaro.org>
Content-Language: en-US
In-Reply-To: <7e019a90-8715-46ce-9bae-50b070d4904d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e30;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vs1-xe30.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/28/25 09:11, Gustavo Romero wrote:
> Hi Thomas,
> 
> On 5/28/25 04:57, Thomas Huth wrote:
>> On 28/05/2025 03.47, Gustavo Romero wrote:
>>> The current links for the Linux and initrd.gz images are not truly
>>> immutable, so let's change them to point to immutable versions, to avoid
>>> having to keep updating their SHAs.
>>>
>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>> ---
>>>   tests/functional/test_aarch64_hotplug_pci.py | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tests/functional/test_aarch64_hotplug_pci.py b/tests/functional/test_aarch64_hotplug_pci.py
>>> index fa1bb62c8f..2cf5c28b9f 100755
>>> --- a/tests/functional/test_aarch64_hotplug_pci.py
>>> +++ b/tests/functional/test_aarch64_hotplug_pci.py
>>> @@ -19,13 +19,13 @@ class HotplugPCI(LinuxKernelTest):
>>>       ASSET_KERNEL = Asset(
>>>           ('https://ftp.debian.org/debian/dists/stable/main/installer-arm64/'
>>> -         'current/images/netboot/debian-installer/arm64/linux'),
>>> -        '3821d4db56d42c6a4eac62f31846e35465940afd87746b4cfcdf5c9eca3117b2')
>>> +         '20230607+deb12u11/images/netboot/debian-installer/arm64/linux'),
>>> +         'd92a60392ce1e379ca198a1a820899f8f0d39a62d047c41ab79492f81541a9d9')
>>>       ASSET_INITRD = Asset(
>>>           ('https://ftp.debian.org/debian/dists/stable/main/installer-arm64/'
>>> -         'current/images/netboot/debian-installer/arm64/initrd.gz'),
>>> -        '2583ec22b45265ad69e82f198674f53d4cd85be124fe012eedc2fd91156bc4b4')
>>> +         '20230607+deb12u11/images/netboot/debian-installer/arm64/initrd.gz'),
>>> +         '9f817f76951f3237bca8216bee35267bfb826815687f4b2fcdd5e6c2a917790c')
>>>       def test_hotplug_pci(self):
>>
>> Acked-by: Thomas Huth <thuth@redhat.com>
>>
>> Since the original patch is still sitting in Alex' queue, I assume that he'll squash it into that original patch before it gets upstream?
> 
> Exactly. I have a meeting with him in a couple of hours and will ask him to queue it.

Alex had removed the original patch from his queue, so he asked me
to squash it with this one. I've posted the squashed version here:

https://lists.gnu.org/archive/html/qemu-devel/2025-05/msg06621.html


Cheers,
Gustavo

