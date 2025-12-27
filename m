Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B17E8FDCD
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 15:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZWdE-00086w-8B; Sat, 27 Dec 2025 10:55:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZWdC-00085A-Ds
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 10:55:02 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZWdA-0002z3-9F
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 10:55:02 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4779a4fc95aso42597145e9.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 07:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766850898; x=1767455698; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QdvmLruiVsbgl5zamO0j9b+6ZRIAlO8QZ5wv1YJUuBI=;
 b=jRqXzS2D+tHFp9R0vorT+0jtORb935D/L1V8BLVC+12+sEN7YPVvu7f3610L9wz91J
 H7itq/1LkOOonuBL4jcwwoU/GGLYe7X2SdMwwoejLPSQfX4Iw37U6sPXR7gp70UeQ+jx
 /YGOHgMn1l/M5HicDiEVOR+PddUl0Febw9SaEezl6546Cw+3CpUPrXVB/L8xWfI4lnX+
 JVMca9UdhsAo0RI3zU7Xrm0oO7LLduipR0rrZ9TXQmCM0tmjb0jZAbpn4FzfPW0/p6Va
 FZfSRptsH8tHD6MtUFnMFvXXL58VJ3MRJtbaWsS5/0cKmCuCNRG5YRKpP/Wm7r85SMx8
 BoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766850898; x=1767455698;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QdvmLruiVsbgl5zamO0j9b+6ZRIAlO8QZ5wv1YJUuBI=;
 b=uBl/jZeSagN2FUZ1vfROr9yuus53CZf8/8Gkh1oOkeZBOOC3D/5F+ppRClhap6SnFi
 b3LKfSNbd1kN9czrh9pL10YoCGKyoH3g/5iKH9vSaWGgz96xM4uARXck3Kj1/fTodDZA
 k1vO+9CmBZJH+T3x35l7oSZykJM8OLsqFVSHf7spoVXaKx13MRve3qzORE6UUQlsi4G7
 2nwGtsGO+KCx0YHpLUSRcXTVv7uQLYSMwUsCrTRF6gzGp2i10DgA6VpRo9Zv1drmbfVB
 Av5jYTuttQazg+Kqsar1ksFVSsCqzeGh9TCOsKWQ0KFznjfzLxBfsMenxcwd24wrTR18
 fQag==
X-Gm-Message-State: AOJu0Yy6j7Xv1rJtuqQFwyaqk3n5jfcUx+oyI+UIoQsMwqTmg6q/P88V
 7sHAAxOqi6onSK4JlSwzMHcUCS05epbkeXECtHWblYh+YkQiQ+0NqTpQUT882q5BRjE=
X-Gm-Gg: AY/fxX68XtZLtJ6gIyY9WyQR5nudnhdokUf5+l0JNFDAHVvtrsV5ZvpVRRlu4wbk2Ds
 XrAZ8EuA4J/M8bOkF6VbUiWx0NaWjT7Xknm57a0oXRpqAjsqLGlJds8s19Xq2dGMnZtJze02q4X
 kme3xHM7Y7YhxI6fhF/tncL+FwX70Fc5XYZBpN0P1b2+N4YC0mFPS3LqZikYcthBR2VU2f07tn8
 Xq7+nWYzMTMBTzMJ7+b/JuGpVzBmYEljyweVcbBo5gFkF9wFyCDFUDIRgTkKySormBhHfMmhtVH
 VANevhfnTygloM5yDQyKMEGqXy7GT25hxalvwuWvaD5cWIbjyTgxh2oC+Dphdpe98ZeqW6sp15Z
 hDFuMDr/jNCLMJIvnbEu6skdqIJEkwmuVP+bcIWY+o5m/2xqGxozaC45fGemDVt/1bZN3euhJYO
 NwisYC6h51xduPeg+uwhK72pQk38VFw0KsdinFbFwQroycToqF+k1cJmnBiP5UyA==
X-Google-Smtp-Source: AGHT+IGwI7wyY90jgFEY2Hh10x0oT5wnGfiYH2pOL+Z/8Ey4/zOOvAVDeaSLLvlhR+hfqYLdTiM2xg==
X-Received: by 2002:a5d:64c4:0:b0:430:f593:aa34 with SMTP id
 ffacd0b85a97d-432448b7ee5mr38309898f8f.17.1766850897941; 
 Sat, 27 Dec 2025 07:54:57 -0800 (PST)
Received: from [192.168.1.15] (alyon-655-1-564-32.w80-9.abo.wanadoo.fr.
 [80.9.105.32]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa46c0sm52111460f8f.34.2025.12.27.07.54.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Dec 2025 07:54:57 -0800 (PST)
Message-ID: <5ce59811-f408-4ecb-9650-9c9aa5aa6c8c@linaro.org>
Date: Sat, 27 Dec 2025 16:54:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v8 3/7] hw/misc: Introduce iommu-testdev for bare-metal
 IOMMU testing
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>, Paolo Bonzini
 <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20251224034647.2596434-1-tangtao1634@phytium.com.cn>
 <20251224034647.2596434-4-tangtao1634@phytium.com.cn>
 <f3c919df-076c-4f19-ba28-686c713fc53f@linaro.org>
 <e77c63ea-471f-4bea-af4b-378081446e0a@phytium.com.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e77c63ea-471f-4bea-af4b-378081446e0a@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 27/12/25 06:16, Tao Tang wrote:
> Hi Philippe,
> 
> On 2025/12/27 06:56, Philippe Mathieu-Daudé wrote:
>> Hi Tao,
>>
>> On 24/12/25 04:46, Tao Tang wrote:
>>> Add a minimal PCI test device designed to exercise IOMMU translation
>>> (such as ARM SMMUv3) without requiring guest firmware or OS. The device
>>> provides MMIO registers to configure and trigger DMA operations with
>>> controllable attributes (security state, address space), enabling
>>> deterministic IOMMU testing.
>>>
>>> Key features:
>>> - Bare-metal IOMMU testing via simple MMIO interface
>>> - Configurable DMA attributes for security states and address spaces
>>> - Write-then-read verification pattern with automatic result checking
>>>
>>> The device performs a deterministic DMA test pattern: write a known
>>> value (0x12345678) to a configured GVA, read it back, and verify data
>>> integrity. Results are reported through a dedicated result register,
>>> eliminating the need for complex interrupt handling or driver
>>> infrastructure in tests.
>>>
>>> This is purely a test device and not intended for production use or
>>> machine realism. It complements existing test infrastructure like
>>> pci-testdev but focuses specifically on IOMMU translation path
>>> validation.
>>>
>>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> Reviewed-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
>>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>>> ---
>>>   MAINTAINERS                     |   7 +
>>>   docs/specs/index.rst            |   1 +
>>>   docs/specs/iommu-testdev.rst    | 112 +++++++++++++
>>>   hw/misc/Kconfig                 |   5 +
>>>   hw/misc/iommu-testdev.c         | 271 ++++++++++++++++++++++++++++++++
>>>   hw/misc/meson.build             |   1 +
>>>   hw/misc/trace-events            |  10 ++
>>>   include/hw/misc/iommu-testdev.h |  68 ++++++++
>>>   8 files changed, 475 insertions(+)
>>>   create mode 100644 docs/specs/iommu-testdev.rst
>>>   create mode 100644 hw/misc/iommu-testdev.c
>>>   create mode 100644 include/hw/misc/iommu-testdev.h
>>
>>
>>> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
>>> index fccd735c24..b5f6fdbd9c 100644
>>> --- a/hw/misc/Kconfig
>>> +++ b/hw/misc/Kconfig
>>> @@ -25,6 +25,11 @@ config PCI_TESTDEV
>>>       default y if TEST_DEVICES
>>>       depends on PCI
>>>   +config IOMMU_TESTDEV
>>> +    bool
>>> +    default y if TEST_DEVICES
>>> +    depends on PCI
>>
>>        "depends on PCI && ARM"
>>
>> ?
> 
> 
> Thanks for your review.
> 
> 
> iommu-testdev is intended to be a generic PCI test DMA engine, usable to 
> exercise different IOMMU models, not ARM-specific. The current series 
> uses SMMUv3 as the first backend/example, but the device itself should 
> only depend on PCI and is gated by TEST_DEVICES.

Ah great, I just noticed the "Translation Setup Workflow" chapter of
this patch :)

Regards,

Phil.

