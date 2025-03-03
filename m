Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3A8C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 14:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp6ob-00041u-4d; Mon, 03 Mar 2025 09:30:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp6oV-00040D-DX
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:30:35 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp6oS-00027z-IS
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:30:35 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4399a1eada3so41404535e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 06:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741012229; x=1741617029; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DMVd9MNd1PnHNmaJHp21ZybDlxhwTi6WU5SVQWvJZ80=;
 b=KUnbH0C4Y2Ru1vm5D6GqHim725kyzOAIpw1l3+n7iFklYIr1GVo+5e+sYREDjj8hx8
 5wONuAf7oOnIbwAhPvkonaoNaRhxAeWbSLqwo3oPKpEXPG8HKXJKw1jYbM0T7BuPU9Uj
 hhsVrTHsWIBxpmabglwGyLcPgeIZqc4Jl49UpOrbXF0mWgOltvldc/NLWtHEAffL9xeR
 w8QG8+VPamdiVD/sMj5kB8X+0f2c86ARQPCF+BlO2N/73gUUM2LKQ5GVxyWpygmr7alR
 cfC3XCmpUte5kf0/d7ZAUBbAMyFQDikLNq/ddSNnSpUMmin93yUWk3UIzb4F8yzEFsyE
 ZZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741012229; x=1741617029;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DMVd9MNd1PnHNmaJHp21ZybDlxhwTi6WU5SVQWvJZ80=;
 b=OsTqy7JrZWKrBGRkSynRwNWdMM96YU17dbcAUGb0qCHCyDQ85Vk54uqAxIX/xWcx81
 V2wqAT4XayBmwTgwQ2aNjZp/JMA8FtqV04bWUHko0a4gIrbTbijMjKAuLzDKkQIzhQEu
 Dl0zcMSKbiRCji3XxABWIyXJAJVZlT9YL9VA4wDqEDQXOm0EPVUE8oWkkrrmRIADkR7F
 zuY5ndKStcSjO0NC5yTwug3qef5In2PUohRo6wNg3wyi7tYr59Xt7zsVRAzHH5BEbr/I
 7jaP6v10kUDiFwxThxsz9zODkakbKlCIWh58whFB/Jb/MHFTAIoRaeEH9+SssRcjpoNM
 KfrA==
X-Gm-Message-State: AOJu0YzElU1BJjDJQiuiIR/CqqszzHVxhsmAb0mkSkFh6l4SEO9wY95g
 7pwOOVy14I2/OUdXd7KQYiudj5kQvK/MIZNYk+CiDvxC3K+K/o5bbx542hnY19o=
X-Gm-Gg: ASbGncskHOwWO9NXTSbpk3HkvOu8+ltbOFYKqk9qkFHZ7NDPG6Nr8qCv1x9nUiFllJ4
 Dl0ZsejYE2LSAdPBH4L4rtytcfz1iJiGzFZJOEEiLdx+Di07pgcvAUR31QWiwIZCZhxFAM4yNZQ
 /eYkxA9/uBL+xWQZ9fWLDML8FDWpXoX++s8stLxhB4ZpaX6JQC7SBAUeIH/T6AB5lnFWFOFkSj0
 IniavXBzmW4ukn8YEcpNcAv5HcI8bEXfTk8ZXPVroGpogyqHMWaelD/XTNz3fnD+uSShylPGuY/
 +AYcnOZndm2ovqvl6OnwoLUmoNkJH7zD+bPUP5pwPNFkD8WyrdkvYpUG7Mm+H2/GUZcDphUwpSB
 a3tCfAGnUah02
X-Google-Smtp-Source: AGHT+IHuevJg8tw9ZnQA9oemBl/AEY+csbD8h8s4/azHO2eusiqmcgaDW0XxwTAAXKjI8BWqqYOq7Q==
X-Received: by 2002:a05:600c:4693:b0:438:a240:c63 with SMTP id
 5b1f17b1804b1-43ba66e257emr105890535e9.2.1741012228949; 
 Mon, 03 Mar 2025 06:30:28 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bc227dbeasm38009785e9.38.2025.03.03.06.30.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 06:30:28 -0800 (PST)
Message-ID: <aa01f3dd-e3ac-4ee5-87b4-8133103bd000@linaro.org>
Date: Mon, 3 Mar 2025 15:30:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio: Make vfio-pci available on 64-bit host
 platforms only
To: BALATON Zoltan <balaton@eik.bme.hu>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Eric Auger <eric.auger@redhat.com>
References: <20250226084721.232703-1-clg@redhat.com>
 <20250226084721.232703-2-clg@redhat.com>
 <a39e97c2-c6fd-34e4-f91b-b3491185b789@eik.bme.hu>
 <c60b7780-5b3f-43a0-a7f1-30820d4e6fb8@redhat.com>
 <bb7c2adf-f146-50c7-7716-c1ee7b606b01@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <bb7c2adf-f146-50c7-7716-c1ee7b606b01@eik.bme.hu>
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

On 26/2/25 18:57, BALATON Zoltan wrote:
> On Wed, 26 Feb 2025, Cédric Le Goater wrote:
>> On 2/26/25 15:12, BALATON Zoltan wrote:
>>> On Wed, 26 Feb 2025, Cédric Le Goater wrote:
>>>> VFIO PCI never worked on PPC32 nor ARM, S390x is 64-bit, it might have
>>>> worked on i386 long ago but we have no plans to further support VFIO
>>>> on any 32-bit host platforms. Restrict to 64-bit host platforms.
>>>>
>>>> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>>> Cc: Tony Krowiak <akrowiak@linux.ibm.com>
>>>> Cc: Eric Farman <farman@linux.ibm.com>
>>>> Cc: Eric Auger <eric.auger@redhat.com>
>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>>> ---
>>>> hw/vfio/Kconfig | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/vfio/Kconfig b/hw/vfio/Kconfig
>>>> index 
>>>> 7cdba0560aa821c88d3420b36f86020575834202..6ed825429a9151fcdff33e95d1a310210689b258 100644
>>>> --- a/hw/vfio/Kconfig
>>>> +++ b/hw/vfio/Kconfig
>>>> @@ -7,7 +7,7 @@ config VFIO_PCI
>>>>     default y
>>>>     select VFIO
>>>>     select EDID
>>>> -    depends on LINUX && PCI
>>>> +    depends on LINUX && PCI && (AARCH64 || PPC64 || X86_64 || S390X)
>>>
>>> Are these defined for the host or target? 
>>
>> host.
> 
> Where are these defined? I thought compiling qemu-system-ppc on x64_64 
> or aarch64 would have PPC defined not X86_64 or AARCH64 but I could well 
> be missing something.
> 
>>> I see PPC is defined in target/ppc/Kconfig so I think these mark the 
>>> target not the host. Vfio-pci works with qemu-system-ppc 
>>
>> Ah ! I am surprised. Which host and QEMU machine please ?
> 
> I've seen people do this on x86_64 host

Since this patch does:

   LINUX && PCI && (...  X86_64 ...)

these users won't see any change.

> with pegasos2, amigaone and 
> mac99 running 32 bit guests (AmigaOS and MacOS). Some people running 
> older 32 bit Windows versions on pc machine might also use this.
> 
>>> and we are trying to use it for GPU pass through for 32 bit PPC 
>>> guests. Please keep that enabled.
>>
>> As per commit 6d701c9bac1d3571e9ad511e01b27df7237f0b13 "meson: Deprecate
>> 32-bit host support", support will be fully removed in 2 releases and
>> it doesn't need to be addressed by VFIO.
> 
> That's about removing support for compiling QEMU on 32 bit host OSes not 
> using 32 bit guests with qemu-system-ppc and qemu-system-i386 isn't it?
> 
> Regards,
> BALATON Zoltan


