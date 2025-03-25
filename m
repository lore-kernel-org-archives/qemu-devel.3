Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9F7C36002
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 01:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twt0D-0007Ac-Hf; Mon, 24 Mar 2025 21:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twt0C-0007AM-Ol
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 21:22:48 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twt0A-000605-V1
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 21:22:48 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ff4a4f901fso9302683a91.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 18:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742865764; x=1743470564; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aG/ikolZ9gVRmszvosTh9e33E/vQ1AmQm3yTNYjPZIM=;
 b=FcqfCDrk+g/7LnlW2v2aEfE/Zo7AFpFrg3z5W2DdaC3swzg78YkiDNfp2tw6vDChcY
 VNIJpqZyNBKYIWh+PdV7goVaO28FRRCAqvCNXPT19NVltDIFnMfenZdojWss7w4bc34B
 4nqxbmVF7lYDStZK8WAntJx48i/rYnX6s6lLs4q6WZVKEJveXN/cgThrvCMwEFbi+83n
 i6Kgako6rixQOMwrb15npxhisXmvkeFAjK7xJpy4Z55xvb8Qfiqq29qXcZTtQkgjDow9
 o8Z2k0WDIKp6rPuDIasdRjjVDQjJNSSUIoObEJoRCU5HqIabddE2iheaaZw4X4vJtSL/
 5Qdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742865764; x=1743470564;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aG/ikolZ9gVRmszvosTh9e33E/vQ1AmQm3yTNYjPZIM=;
 b=WX0Fh5SxQ6vrDrJxQHct5ZheGYcEoxAEt+jwee8SDVoO1Gx2KGFLZar1ZsMJ47naqx
 RO3edRtQKfHueNSX9OS5CyuzFTm730tauKdr50qMI+tF6Oumhd3aNKFYB7kl65zbS581
 FwUkLB1EhIliDdTMeVPYLalFDDHv8r+uY9DLWvdJ5ekzC00Coj4/7P85IeDJGzSef7t4
 rBE7ZnEfCFtunuBlPpPVIH5XxVje4emrURBo2F2VWNIBgjnnM4YmfHPKfoIDtKS9X7la
 Xu7FSaNu6iZQ6Di4uGQcwe/qTWgpQUBnE+I9FdNYWMLkuZElgRd/oWiwltNGog6VSfGa
 KGqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiZRJBw7P0U9MdhFbvxEJcbq7Y68YmveYCnQa4tKYryTHIoX1520nkyJyujQAVEZ0+uleZZjRljNwe@nongnu.org
X-Gm-Message-State: AOJu0YzJS0bmLHssmrBOXJrTwYPY/Eqx/+IBZC1tosZnXyeYGLZZx/wS
 ugxSHC7jWUq9LhL0MrAibKhL+o8xQfD5qxJ8U6aecFi4Z2ND+4SJftv9bh1ere4=
X-Gm-Gg: ASbGncvHiVy79IgNzqW4eZUWDO8/aFu5GsrhrBXKZiYloYcLcNNreVP0XE2d9PEAgAr
 r154b9US7AChsvY1IiEzErsGXA/fmL77ZoEqRVqMfeHgr9O1Z2PFVSC1TAOA8Gaq1pwtKMRhKtn
 oM6dy8kGWVV6cEfB8UOIzK8eTX+OyPdHN+4Psqzr83Iy1/rpnkB6/JrlvHZnswTsKl6hnR2nB6K
 /X7gJwXjZtt8y2t5rnen1b7QpsIeHxlHaBt4BD6RPqvRs1/iELiBSRihSiqsQeB14U7cVQPh8i2
 OMH25OM1RgWwyJfQxNvA56tFe67vm5qNU9pGVTKiGsZWTrXKtqccnsS7rMZrbqow6P0hd/TLybU
 u7kOyOO19
X-Google-Smtp-Source: AGHT+IHEZCg9xs1G0ztU1F3GqMs42dpDB5T8VAwisopTv+ewq4W5/2ROGq56Z/iMGj+HJJwkTysYNg==
X-Received: by 2002:a17:90b:2743:b0:2ff:4a8d:74f8 with SMTP id
 98e67ed59e1d1-3030fe721dfmr21437984a91.6.1742865764131; 
 Mon, 24 Mar 2025 18:22:44 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3030fe83d50sm8832615a91.24.2025.03.24.18.22.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 18:22:43 -0700 (PDT)
Message-ID: <67313299-0ce6-457d-ace7-73ad864a0eb0@linaro.org>
Date: Mon, 24 Mar 2025 18:22:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 26/30] hw/arm/armv7m: prepare compilation unit to be
 common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-27-pierrick.bouvier@linaro.org>
 <0c9055a3-2650-4802-a28c-e5d79052bc81@linaro.org>
 <6cce9fd1-d008-4b63-a77f-c091fcd933e0@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <6cce9fd1-d008-4b63-a77f-c091fcd933e0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 3/24/25 14:31, Pierrick Bouvier wrote:
> On 3/23/25 12:48, Richard Henderson wrote:
>> On 3/20/25 15:29, Pierrick Bouvier wrote:
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    hw/arm/armv7m.c | 12 ++++++++----
>>>    1 file changed, 8 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
>>> index 98a69846119..c367c2dcb99 100644
>>> --- a/hw/arm/armv7m.c
>>> +++ b/hw/arm/armv7m.c
>>> @@ -139,8 +139,9 @@ static MemTxResult v7m_sysreg_ns_write(void *opaque, hwaddr addr,
>>>        if (attrs.secure) {
>>>            /* S accesses to the alias act like NS accesses to the real region */
>>>            attrs.secure = 0;
>>> +        MemOp end = target_words_bigendian() ? MO_BE : MO_LE;
>>>            return memory_region_dispatch_write(mr, addr, value,
>>> -                                            size_memop(size) | MO_TE, attrs);
>>> +                                            size_memop(size) | end, attrs);
>>
>> target_words_bigendian() is always false for arm system mode.
>> Just s/TE/LE/.
>>
> 
> Good point.
> 
> By the way, what's the QEMU rationale behind having Arm big endian user binaries, and not 
> provide it for softmmu binaries?

For system mode, endianness is set via a combination of CPSR.E, SCTLR.B and SCTLR.EE, 
details depending on armv4, armv6, armv7+.

It is IMPLEMENTATION DEFINED how the cpu initiailizes at reset.  In olden times, via a 
board-level pin (sometimes switched, sometimes soldered).  We model the board-level pin 
via the "cfgend" cpu property.

In any case, for system mode we expect the guest to do the same thing it would need to do 
on real hardware.  For user mode, we can't do that, as we're also emulating the OS layer, 
which needs to know the endianness to expect from the guest binaries.

> If those systems are so rare, why would people need a user mode emulation?

IMO armbe-linux-user is extinct.

Debian never had big-endian support at all.  If there was some other distro which had it, 
I don't recall which.  Otherwise you'd need to bootstrap the entire toolchain, which to me 
seems rather beside the point.


r~

