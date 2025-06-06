Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F89DC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 09:38:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNTWy-0004oC-DX; Fri, 06 Jun 2025 05:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNTWw-0004nu-T0
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 05:38:30 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNTWv-0002ny-1t
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 05:38:30 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-450cfb790f7so14690285e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 02:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749202707; x=1749807507; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oFOC02zVYZ8GEKW6KPKOoUyDIZPBuO6Qih5KVduNdNs=;
 b=dUqw4iLpYRo5/jeCB5ga4D1wffDKmuNapAMoRgXburH8jyWCo2eDyGR9zHLwYweJRf
 ZN+lMyRYLInDMIsXmvJ+xHrgurf4dO+Pjs4yGsbnSUjNGrYgBIP0AmOq777Kg0p14K78
 6DAJUQO4bEczbq5qjvB9Cii3KYvDLhNWIfXqEtjkLAbPM+3uG/iY52Nj0qi5Gxtbryb8
 UFh1bWaoWsqMNI+uxU0rAagmhErYqDafOBK8SSI1eAm0NjHFafJvEC7Zo/IMvpDP1ZoI
 +CG72pbTjAYS8F3N79QI8YMF/FcTkErHfhYByscBNDHd4NXXIblI4KsLYrS423AHNWmx
 FsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749202707; x=1749807507;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oFOC02zVYZ8GEKW6KPKOoUyDIZPBuO6Qih5KVduNdNs=;
 b=aLX5NE3nOYRLcF93x+up/YF2LPo71SHrXINkhEFcX6SONEP5P04lJaQub/fYGQY+Ro
 SREci05xggk/m+eRdbZYfrK3AzbV0UtHlypnxEkXwWL2itc+2gH3v2fx43eG332rmOME
 02x2G64mTCZaQHOWuvW20S5Gd4AU0Nb9pkj8MJte2Ghl+ZoOUEzrQ6V1SW+o3VCvumrL
 UDsCTJkVhtNzmSNIN19vLghD0ZZqrC60LjBGXG7sZPAr9SxuvbUUMDKJIWAjvyGnP4Gu
 fstV7NT3yr3NO+vuZwMgNBCZD7sJWXI43uP+rREtaZ0EuchpQLPclJ3V4Jg7H0+exQFs
 ILJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3OqtIw7B48SmZ0v0mY2IJqw/oVUVSipt32V4cgmPwjDEU96SsYY4ZOeCpawkD1k//Cy9tgJ0MZafs@nongnu.org
X-Gm-Message-State: AOJu0YwgM3hpczZfbn449vjHV909OFJ8K8FDD4O7ptyTQG68/vPOFHlb
 9ftqVraxjNSb8YlQND3tYHmQCm6Ku/VATrMxBw1m1tRf3McgsuUX5JC77a0KfCsWh8o=
X-Gm-Gg: ASbGnct+4Mff/G70KvNNBg7YgqjSMesYDjaB9jJdf8imf++TFfOt1Rt65kJ+6ODIO50
 b5pQyBs+5qj0nI4n0L9Fa2pGM8WnRRJ3cfWq3faNRjoz75LjbrX2mV4MtnICXks5906QMPOzZg7
 ybs+4VnDlTbyL6xQkrl+Z9qO+gzQKVFRnvw4iEIMo/gRZheKGZ8hFwlvRED0vJC5bpzuq75cRZ0
 NZ2Fh0iOJWoVlWfw9JYn1v/Z/QKEUt4qHLMIjgrROphBbKHSDgm9WfDkenil1T9Rnl//j1AJTcz
 sNK79TMAs8OJkhQ8NPsjp+29e7H0vO9hDE/c8Qzt4kxcOctvckp3wOT4yLepQe5liKRA4iZf3LN
 sSZIC00xCszPKrq81c7bkn+fClwfsPqN5rFbYlAp9
X-Google-Smtp-Source: AGHT+IGc07YjkGi4IbOcCx2T9VaIkh4KkapFRjAAvIvDSy4lZkEoSKnTCQBhDNrGU3Fr4dKOQJQLuA==
X-Received: by 2002:a05:600c:1d8d:b0:450:ddb7:ee4d with SMTP id
 5b1f17b1804b1-4520140ceccmr27494915e9.24.1749202706745; 
 Fri, 06 Jun 2025 02:38:26 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4524d8af1f3sm16295005e9.1.2025.06.06.02.38.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Jun 2025 02:38:26 -0700 (PDT)
Message-ID: <d0eb5075-0f68-4430-ae0e-fb41646f2734@linaro.org>
Date: Fri, 6 Jun 2025 11:38:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] i386/tdx: Fix build on 32-bit host
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Marcelo Tosatti <mtosatti@redhat.com>
References: <20250602173101.1052983-1-clg@redhat.com>
 <20250602173101.1052983-2-clg@redhat.com>
 <b30050b0-68d3-4b42-85f3-9aeca26fb830@intel.com>
 <06903e8d-d729-458d-8157-5a54d324a239@linaro.org>
 <a838e7cc-968e-4ca4-ba60-bbf201d689aa@redhat.com>
 <5fb2a861-26c9-4a48-9de7-6d872ac1e234@intel.com>
 <d22baf31-2722-4b89-ae99-475d6c5e4f33@linaro.org>
 <fde03bbf-415a-466f-a3cd-fac4f952c531@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <fde03bbf-415a-466f-a3cd-fac4f952c531@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 6/6/25 11:28, Xiaoyao Li wrote:
> On 6/6/2025 5:19 PM, Philippe Mathieu-Daudé wrote:
>> On 6/6/25 10:49, Xiaoyao Li wrote:
>>> On 6/3/2025 10:53 PM, Paolo Bonzini wrote:
>>>> On 6/3/25 13:26, Philippe Mathieu-Daudé wrote:
>>>>> On 3/6/25 05:04, Xiaoyao Li wrote:
>>>>>> On 6/3/2025 1:31 AM, Cédric Le Goater wrote:
>>>>>>> Use PRI formats where required and fix pointer cast.
>>>>>>
>>>>>> Maybe we can make 32-bit build exclusive with CONFIG_TDX? since 
>>>>>> TDX is not supported on 32-bit host.
>>>>>
>>>>> Yes please!
>>>>
>>>> No objections, but I'm still applying these first to fix the build.
>>>
>>> Can anyone guide how to implement it? Or directly help cook a patch?
>>>
>>> I'm struggling to learn the 32-bit build stuff and create a 32-bit 
>>> environment.
>>
>> -- >8 --
>> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
>> index eb65bda6e07..b5970f9a1f3 100644
>> --- a/hw/i386/Kconfig
>> +++ b/hw/i386/Kconfig
>> @@ -13,7 +13,7 @@ config SGX
>>   config TDX
>>       bool
>>       select X86_FW_OVMF
>> -    depends on KVM
>> +    depends on KVM && !I386
>>
>> ---
> 
> CONFIG_X86_64 selects I386 in target/i386/Kconfig, so above change will 
> just leads to CONFIG_TDX always being 0.
> 
> config X86_64
>      bool
>      select I386

Doh. We could expose TARGET_LONG_BITS to Kconfig (see commit 
bae3e3a5c6b, "meson: make target endianneess available to Kconfig"),
but there is likely a clever way.

