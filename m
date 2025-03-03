Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5758C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 14:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp7Ap-0003Zt-4m; Mon, 03 Mar 2025 09:53:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp7Al-0003YD-3I
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:53:35 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp7Ai-0006pV-HG
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:53:34 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-390e88caa4dso2033837f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 06:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741013610; x=1741618410; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oYtkfweF/0z3z7jSYdFaM98btDld44kvHKxV5PacVoQ=;
 b=REFW36/jvI6KxIwPQO469zphRboMdiDy5PVW+Eae58GSX1av7/tJ2QjpBTqLhKO0NO
 Z+2pCueHnTVfJcLT4d7HI/g8f5b3riI8BKVRdHV4k5jBCmoDXL5C8LE4bKLVhtOAqfMk
 Z55GMtYT1Pid8wgO36YDD65pw+pxRO/3SWuzvdP2Bz2+2Xp1IHLQ4awRH8hjbXanWU0C
 WDr7LeAtyMezcntJVkeHifeDO4WDH9cnJsYyLTRE7WpdqdyI34bhzvshUqczZNSeMiz5
 +tTxxcf3jbN6mlLFTXxMeNutuh3COTRHbAxSulmDhkxTo3t5S0W0n2aeFASzp9Hm4BEc
 X3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741013610; x=1741618410;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oYtkfweF/0z3z7jSYdFaM98btDld44kvHKxV5PacVoQ=;
 b=wl3kE6oh2LXY/TtWcBmp9/HE+El/e9xCVDmHPCz7FbnYgj7VpfkgxqlFyZ/lN104OF
 VvcevopC4oN2EhZROSXS+8Y0LyTKmy+t0rlkDIIoqnDHii+EUH/UioT4zxSbuHIIZEIP
 5bnzvMF2T6n9lk/9R3FiF9zkClzHNFrGpzn5HzfUbNP57OWjC3pD4IL+Y798tySE12l2
 MaiLV7fWiiTY5BxtrNt+HogDGj6/5UAKoODfoxCcNNYHSkTuGGbrHR8bNE8wCT2xTIZV
 LClKkwhYLhUWVAJzg+EIWf+/v3iE9ocwUQ0JkS3nJAudjULYLnO6S9i2EiuxUqgC8Qqa
 Oo8A==
X-Gm-Message-State: AOJu0YyCwuOpamaNI8MeX9f6gJcJMyojZNiRsMl+miZ5chwcgjWGi/Ir
 zdhk6akVrijA70IGnkS8GL8R7yCUkvDy9FaF/NBlvx749lj3B/pWcdko5m34MAQ=
X-Gm-Gg: ASbGncszf3qo+0XAx6ak8ADhWsTDfTXQg829XnCWczsxrYq9J3KmQrMYyZ0jZNvUy+6
 i4jy6IrXsGo3DGHA+09LSmF4FxDX0DKsNKRVeGOCZheoHprjTGFkFZl+CdikWlv+coLmk6y/Y+I
 OQoZ6qTXQUeMDnEqsbeyr31X6vrZYBkDYsW4QEuQ53IV03xCq1lUmVOk9vC5wNe49ZKTmMRnO1e
 O2/dLfVtJ5ZmNk7GoESgOf445KdDbH02dZ0111PZz2xQ+mZiiS66lRPbz8Ulj6eFKZEqpmEuVPM
 9Z/J76pwgyiRIAIbIpdvQaTneXO32obVVOKNwfXN4faS1chpo4lFf4G3TghcQQhvrl/kRRhwkfs
 vJHQB6089O2a7
X-Google-Smtp-Source: AGHT+IGKHZuANKzhEsUwd9x4Zfg08YDVpvqc/6+yErOnI8oBaBzxIkpBxnB3wiCypGU5d9bYWL8IJA==
X-Received: by 2002:a05:6000:1f86:b0:390:f6aa:4e80 with SMTP id
 ffacd0b85a97d-390f6aa5102mr9155965f8f.53.1741013610645; 
 Mon, 03 Mar 2025 06:53:30 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e484452asm14852963f8f.61.2025.03.03.06.53.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 06:53:30 -0800 (PST)
Message-ID: <a19520bf-9e0a-4a63-bc31-06b63e23c3d3@linaro.org>
Date: Mon, 3 Mar 2025 15:53:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio: Make vfio-pci available on 64-bit host
 platforms only
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Eric Auger <eric.auger@redhat.com>
References: <20250226084721.232703-1-clg@redhat.com>
 <20250226084721.232703-2-clg@redhat.com>
 <a39e97c2-c6fd-34e4-f91b-b3491185b789@eik.bme.hu>
 <c60b7780-5b3f-43a0-a7f1-30820d4e6fb8@redhat.com>
 <7982159d-710f-4948-830f-ab61b100a5d6@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <7982159d-710f-4948-830f-ab61b100a5d6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 3/3/25 15:43, Paolo Bonzini wrote:
> On 2/26/25 17:26, Cédric Le Goater wrote:
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
> No, Zoltan is correct.  They are defined for the target,

Oops indeed, not my day.

> so if you build 
> for 32-bit ARM you'd still get things with "depends on AARCH64" in qemu- 
> system-aarch64.  You can check that you have
> 
> config SBSA_REF
>      bool
>      default y
>      depends on TCG && AARCH64
> 
> but on x86-64:
> 
> $ qemu-system-aarch64 -M help|grep sbsa
> sbsa-ref             QEMU 'SBSA Reference' ARM Virtual Machine
> 
> 
>> As per commit 6d701c9bac1d3571e9ad511e01b27df7237f0b13 "meson: Deprecate
>> 32-bit host support", support will be fully removed in 2 releases and
>> it doesn't need to be addressed by VFIO.
> 
> Note that a deprecation *allows* full removal in 2 releases.  We have a 
> lot of things that are deprecated but have not been removed.  For example
> 
>     Short-form boolean options (since 6.0)
>     ''''''''''''''''''''''''''''''''''''''
> 
>     Boolean options such as ``share=on``/``share=off`` could be written
>     in short form as ``share`` and ``noshare``.  This is now deprecated
>     and will cause a warning.
> 
> is deprecated to *allow* switching command-line options from the "qemu- 
> options" parser to the "keyval" parser that doesn't support short-form 
> boolean options, but it's unlikely that qemu-options will drop support 
> for short-form boolean options.

In another thread Daniel said deprecated options shall be removed, the
only justification for delay being man power, IIRC.

