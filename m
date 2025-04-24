Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 575FDC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 09:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tMH-0006RO-Ba; Thu, 24 Apr 2025 05:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7tMG-0006RB-04
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:59:04 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7tM9-0003fh-GO
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:59:03 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cf3192f3bso6906615e9.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 02:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745488736; x=1746093536; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/DgcfQP2UisEY1e7KO+lUAZgaP5I5G1PDN40xB3c/ek=;
 b=f3mXIIGdHMUdAErlLH/8W0GbqKyasTnbRwHMyY/P7kn78ONuRj+L8cIC8+0NfbsH21
 yb+bs2765/1jBdlSCNa7kkDJGaToWaOESZD/ifCrAh+DleqswC91PKOVVw+7VXhgVbSF
 BSW+C9yuOfL1GtGStMQo8RHI3sJwVtLct4z05FINGo8YIT0gxr+LHGF6xQehKcI2Bvtj
 qDqOX3oEiVA9OEc1SpmuTyYWksSVKiO3tXexMMKVnCS7AUCLNoM/naMkORHymd+C6k+D
 8z6RKY8BRRmqLKKKRlLSHjDyXGsE8tBNODWYYspvVwGEFja4qvpBR28Ef1I173Bg18LV
 +rJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745488736; x=1746093536;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/DgcfQP2UisEY1e7KO+lUAZgaP5I5G1PDN40xB3c/ek=;
 b=i/KK7G4DolWgk7cYCrTCIXSOleF63ObYW+UIODGuoh6lbPTPI0mdmg7ho+3db7KD9s
 lPs3t1FCiay/wS37lFRvDaE8kQVLjj1RWJ6AP1fRteDEa93b1Ftuzb0yQvSYP0hp8Lqy
 tHzZvHC5fuzCUUH7A6LC97FOKIDcVIKTeJBjFp963jAn36FNolXOP0Gr0FbHDgWt24Ib
 lmaIW0BCvy91BrQneav1gTF2A4LGEBr+UlG5w/rB7u6pewSTcoPyi7Evq+yaJYQ87B2P
 zWHuLhjR7Op+pQaUNUm8So4u1/HxtH2dyTDXQFG2mPNyhQaN9lJBWOUFg0OShfhWQsjk
 y36Q==
X-Gm-Message-State: AOJu0YxgGpAkZWmh8buhMdyk1FwrFIAT9f6l4Kntx3HNq8mqKCKc3SOY
 xpjKzh3TlQDvAyPOwv+lKfSNVShKCFcBF5PPD+r3YZ+Ot+rIrgJmh9wxo625kNQ=
X-Gm-Gg: ASbGncuFoBdjZzagC0FLtbOuqIX7vkmDYl1XV28B8OYF6FWFonBjiG0PkV0VuPk+KrU
 FZ4romB0AfdnnBxPxpQNdTFoPPjfMbOgYDDsRP6+NLjCysAB8p7Q1Im/8jQY+TTSrOxovkMjfFp
 9lQ3LVC5OJnXIM+umfXOFMOrGb0xILmTTkXjk7XYjynAPEYBzZaK1daZJBJKBJakCQT4Gboz3Pf
 25SnfqwGr/pj/ziIVXTyzst0LMK+AhK9jHfqxsHlPEwQWUs5Aiqk5rmq/9vus+qhm11sCwSi9Ja
 +VnIoP1i40owB2sYn7zmTtDGArduXdlg/IGRROLmjDdvoPoQUHLhaKl+h2TFe+nJcdbIHx+veX9
 JZ9ho/HSSCHPFQQ==
X-Google-Smtp-Source: AGHT+IGHS6WMz+38v2mBJKXSP9HtHLLBw9A7vyfxkEIkfskZ5IfrJzOYPqYGGa0aBrSiTB367OFD0A==
X-Received: by 2002:a05:600c:3d17:b0:440:6a1a:d89f with SMTP id
 5b1f17b1804b1-4409bcfc201mr17770735e9.4.1745488735733; 
 Thu, 24 Apr 2025 02:58:55 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d4bc3a0sm1574923f8f.35.2025.04.24.02.58.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 02:58:55 -0700 (PDT)
Message-ID: <5d285d42-f91f-4e3d-9cda-ba9058236f95@linaro.org>
Date: Thu, 24 Apr 2025 11:58:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/virt.c: Fix wrong default cpu type in AARCH64
To: Zhang Chen <zhangckid@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Andrew Jones <ajones@ventanamicro.com>,
 Alexander Graf <agraf@csgraf.de>
References: <20250402135402.14526-1-zhangckid@gmail.com>
 <d39ed054-d99b-46a8-afc8-1a2981d919e1@linaro.org>
 <CAK3tnvLqGLzQffAi=dk_VzXgH_k_r_z2xNTN3tVE-G+xjpPWcw@mail.gmail.com>
 <CAK3tnvJMOe+rtjnwbfQ8nuZyQAtGMPKjgXBVo2RpkmKNtzAXpQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAK3tnvJMOe+rtjnwbfQ8nuZyQAtGMPKjgXBVo2RpkmKNtzAXpQ@mail.gmail.com>
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

On 24/4/25 10:56, Zhang Chen wrote:
> On Thu, Apr 3, 2025 at 10:23 AM Zhang Chen <zhangckid@gmail.com> wrote:
>>
>> On Thu, Apr 3, 2025 at 2:43 AM Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>>
>>> On 4/2/25 06:54, Zhang Chen wrote:
>>>> Because of the CONFIG_TCG auto enabled, the cpu type "cortex-a15"
>>>> is mistakenly set to the default AARCH64 target.
>>>
>>> This is the correct backward compatible setting.
>>> In essence, it means that you *must* supply a -cpu argument.
>>>
>>>
>>
>> If the "-cpu" is required, the VM should not be started without this argument.
>> If yes, I will skip this patch and submit another one to make QEMU
>> refuse to start without this parameter.
>>
> 
> Ping... and let me explain this status, it is not just for the default value.
> 1. The cpu type "cortex-a15" is not the correct backward compatible
> setting for AARCH64 target.

IIUC it was meant to be backward compatible for KVM (as in "not TCG"),
HVF was not a thing for ARM at this time.

> The ARM cortex-a15 is a 32 bit CPU based on ARMv7-A architecture. It
> can not boot for AARCH64 target.
> For example, the Apple M silicon can not boot with the default -cpu value.

A respin of this series might help you, I'll try to remember to Cc you:
https://lore.kernel.org/qemu-devel/b883f0ef-6131-4335-b273-90fd3d8cc5e4@linaro.org/

> 2. Most of QEMU docs does not said user *must* supply a -cpu argument.
> https://www.qemu.org/docs/master/system/qemu-manpage.html
> 
> Thanks
> Chen
> 
>> Thanks
>> Chen
>>
>>> r~
>>>
>>>>
>>>> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>>>> ---
>>>>    hw/arm/virt.c | 5 +++--
>>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>>>> index a96452f17a..63649e9543 100644
>>>> --- a/hw/arm/virt.c
>>>> +++ b/hw/arm/virt.c
>>>> @@ -3178,9 +3178,10 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>>>>        mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
>>>>    #ifdef CONFIG_TCG
>>>>        mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
>>>> -#else
>>>> +#ifdef TARGET_AARCH64
>>>>        mc->default_cpu_type = ARM_CPU_TYPE_NAME("max");
>>>> -#endif
>>>> +#endif /* TARGET_AARCH64 */
>>>> +#endif /* CONFIG_TCG */
>>>>        mc->valid_cpu_types = valid_cpu_types;
>>>>        mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
>>>>        mc->kvm_type = virt_kvm_type;
>>>
>>>
> 


