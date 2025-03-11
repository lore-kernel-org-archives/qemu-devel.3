Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C09C9C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 09:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trwHN-0000Tr-Jh; Tue, 11 Mar 2025 05:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trwHM-0000Sa-49
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 05:52:04 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trwHJ-0002Pi-UX
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 05:52:03 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3912c09be7dso2816884f8f.1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 02:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741686718; x=1742291518; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GYo7wZUvWtuQ4GeVN/8DmIxOvRCI+jQxMYgNJ5qz12o=;
 b=MMvQUv0BzsQgXVD35boB4yXzYk9hSdhz67u8tsZqCeHMflZMTbFilhgYOBd3dGCP3S
 P6gPSM/BikGFPRKhinYDvTkFufboNNVteDfMTYte9RHZz22vqt/hwx2S3fEinGWIFS/2
 gwk+nuwPlE9LLSStBAdhaBut71MRRryAvO2u3+1HnGR6abzd3M7QSkha5VZpPV6UXvE3
 j4UuHo4ISlmy3Ne7eOhXepEvNnJ+zgXuw+sEeRCe0xSOdsDNlMmkbMyTVnsOwHrkfgxz
 l4zneKVxDvwWNUAhJ+j2Ju9B43twmXp9OrQIj/qPNuhKM/qjdy8zXVQwIBpakWTWZ0pw
 9Zzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741686718; x=1742291518;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GYo7wZUvWtuQ4GeVN/8DmIxOvRCI+jQxMYgNJ5qz12o=;
 b=g62ja7j6O86ZqQz5tVnXxduQSqHiFb7Lijq28RSHQCyhXwhwbOGYcKPZRM3YD5OCOR
 rBYL8/NJ/lJWueeL+hOUy5vsiptL3mqvk+7w8OxgIKQXfk3MgfuYBlStc8pMyozIGbT0
 eO119leXANNBz51k1q4Jh+2X/Pfqy5AO3vLek3rDUmk63CMa9qVP6EoZs1iXo+znPJdH
 ZH5U+UrTPourwOfjYByyJnVkwXTjlxWDuygi8Wre+a04vOxc5s/0CXtl3q/OojrQe4ry
 7hi51MPyn5AKgcKDKLy53CJmQWHU2AzmauXUaFPoBvf+Yvwl1ogXP/lBDONcdq55Uw73
 I+kQ==
X-Gm-Message-State: AOJu0YyQ7j5ZBgVT9OfaiWzQhbNS5/l3w1aK14oNeNgz549B3BnFv8Gy
 bxV8Lo2eAuwj89N+zDKWBtkdxx0sMwZKh0wrptw3rXlB1qytR7YWvCwuOVqVmtw=
X-Gm-Gg: ASbGncsbyPxpbYfyNCTs1ZmaO0Lf/P52+5n/ryMT8I9El0xTjDFuxQHlgeEVxkF6cBn
 KZle2H6yaVyqbpA4DBN29KwOv53Vo8MEg/7tjMGQGm1xLeF/llAVzAp63aXt0D13TKNBwrznpR9
 71N7ob5ctX1ueJ1WY1Rs3pU4uH90hlWO6IJVpUk/ZR+67XPH347yJtq6kSDEZR5hrWLZ3wlSbQR
 yanbFuTfAvurzF14SOvNFZnJwBiZxAEVxkIztCx5atss+WljdAbFpe+z0WdUr5u4L3Wezs7kivC
 TPQPGsiwjGY/8sFp90JrRTvqyXFlC3IX2x8TkzbTVRtbQxL7t8Fh2m2XRzXDX6flFgiLjkmruy3
 ACNp9aBI7BbKW2oWC3nmPO5Y=
X-Google-Smtp-Source: AGHT+IE4GGtMiu1k3+lQrHotXVBSD0kz471b7vYqMHptf4w403diJ2k7hsWWsmw8Qgp2TKH1QcKtKA==
X-Received: by 2002:a05:6000:1a86:b0:38d:e48b:1787 with SMTP id
 ffacd0b85a97d-39132d1d1efmr13703852f8f.14.1741686718399; 
 Tue, 11 Mar 2025 02:51:58 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfad7sm17428248f8f.26.2025.03.11.02.51.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 02:51:57 -0700 (PDT)
Message-ID: <a6a2ddc4-dca5-4234-9254-eacea37efe47@linaro.org>
Date: Tue, 11 Mar 2025 10:51:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/sd/sdhci: Set reset value of interrupt registers
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>
References: <20250210160329.DDA7F4E600E@zero.eik.bme.hu>
 <918e9ae0-fb22-43c7-a2cf-376aaee0e98b@linaro.org>
 <ad0e4bde-40dd-db32-b8d9-46c27c257aa3@eik.bme.hu>
 <0f3814d3-7c27-fd50-2ad3-b4d5344d9fc1@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0f3814d3-7c27-fd50-2ad3-b4d5344d9fc1@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 6/3/25 19:23, BALATON Zoltan wrote:
> On Mon, 3 Mar 2025, BALATON Zoltan wrote:
>> On Mon, 3 Mar 2025, Philippe Mathieu-Daudé wrote:
>>> Hi Zoltan,
>>>
>>> On 10/2/25 17:03, BALATON Zoltan wrote:
>>>> The interrupt enable registers are not reset to 0 on Freescale eSDHC
>>>> but some bits are enabled on reset. At least some U-Boot versions seem
>>>> to expect this and not initialise these registers before expecting
>>>> interrupts. Use existing vendor property for Freescale eSDHC and set
>>>> the reset value of the interrupt registers to match Freescale
>>>> documentation.
>>>>
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> ---
>>>> v2: Restrict to e500. Adding a reset method in a subclass does not
>>>> work because the common reset function is called directly on register
>>>> write from the guest but there's already provision for vendor specific
>>>> behaviour which can be used to restrict this to Freescale SoCs.
>>>>
>>>>   hw/ppc/e500.c         | 1 +
>>>>   hw/sd/sdhci.c         | 4 ++++
>>>>   include/hw/sd/sdhci.h | 1 +
>>>>   3 files changed, 6 insertions(+)


> This patch wasn't in the pull request but I haven't seen an answer to 
> this message either so was it missed or do you have furhter comments? 
> Bernhard has a comment about naming of SDHCI_VENDOR_FSL but I think the 
> already existing IMX name is what's wrong not the one added in this 
> patch but I don't think that's really that confusing to worth further 
> effort. We still have time as this can be considered a fix but I'd like 
> this to not get forgotten so I bring it up again.

Patch queued, thanks.

