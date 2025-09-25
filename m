Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19BEACAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 15:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1oJ5-0002P2-GI; Thu, 25 Sep 2025 11:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1oJ4-0002Ob-4o
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 11:54:54 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1oIw-0006cH-Fv
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 11:54:53 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4060b4b1200so1220506f8f.3
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 08:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758815682; x=1759420482; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hm7whsFYISmy7dLa/PeFakqCR790Q2wvG2RaA/IoxvQ=;
 b=cv7AeD7Ip8wU+IWLoYEmG5/xYX+XqTMixzBVQu4Jdc84A9KqYDgXHe8aMuTbT7TVyg
 WFwzvwPokWcUwP5CmlvXt1udFfdlP7hGT1fKdN/sSZb5SKlMHY1xuJdhopg4aicZO64O
 b2TCHUI1gutOWDyZsfsYAUO6HwDtO1kz/1N+9b87mPRtCn2qZmVcQ6ElGK1Kbbe4305S
 UwFczQ6iTnfYOrKo9PO+s0EcEycphwXjRjZUZuWjg3T0U1gf2SKyY9IznM2/tld+gQAw
 EzhFZJx1CW2fF9gfiHInXWLYEDF+hrTrVLge+WIVKLfU5iLY2Rjny8VS8HlONUogBYd+
 kCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758815682; x=1759420482;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hm7whsFYISmy7dLa/PeFakqCR790Q2wvG2RaA/IoxvQ=;
 b=ZKTY/N5cqDuld4yu9ZMOB3i5Z8M6UIBKr8NiLKJHrjqlH0gwCnpHQ8ZWtuC0y1D0X9
 ZX3K8fmrEdNTU3f3FkD+CYqZ/QSHRtVF1AfjYkw65ODEBx6/LmLTz9R6dzirdD03TgJ4
 nT0SCEGnc1CF0A7O91MMY6FErGmiMKd87kNZQDb8ruQ2wi6e0Ml5RFdhIh0ZHAWjb/Rt
 6yTyFdu25QbuUDZXVA+aml3Blb5xOH4dHMB1/tPXtry/a+6crIX88VecTseKya84FIIl
 0IhP1NcaUnSQ0oM9b3vQwwxK6Q/ivaKCQNLRCl+CnjG8PVaSxHJeCoiclm2Mx3mGJPGM
 +uXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf1vpZSveSxE70UgIuPhaEGuGuMKuG5NTChv0WBGEt1m173s8HfePQ0Qhgrn8950/CwYBJM/hS3AbY@nongnu.org
X-Gm-Message-State: AOJu0Yy/T1KLCr9T3lhN66Gr1ISBKKnmUGfqrisA0ehcgxkcNDQVsw+T
 sy07jne4CzQZjMueV5Twsr3kw/8dn2Bz/Umzt21pJZ/r2zX4NheHAbtEc2RwvOYYJkc=
X-Gm-Gg: ASbGncsAqRr8T8TuL32mG6LdyZD+J2QG5X2XPFysj8GBXYTlI4vzaVFe0hE8O+FbJPy
 pdDLTXEuYzwQehhS7QS9R49LiSHyrW264TItiPKOQHtLflGffTgqcz+6JVs9Da/MHCXcNRW/sQj
 UQHGTUrm7G75HNuH7aRxs1pgKaKGHgAIHmv57ljfH2OpbEIvm00nEciJm93aP2WL6o9Z2ph8nIz
 3cv+aJLw+5aP/v08kXZBiZRGWzHgLhbrWnj3DbPz3141S4yO5ORFKb1iB7/HfrJogDbyQZ6RI/2
 7fEGWgTSQU5c8H0/AkuAw/upcrFzCfkvi4pg7UnvRU8YXQ5Kbka6Zce8yZGMV5V4HZ9OME4E8aE
 64tMXkc7x11rBKagNxXXNQdIgBRjxorZkKfmsDfItON5Wme47ejVptZkR3ifvp6ntfA==
X-Google-Smtp-Source: AGHT+IGpYOrppO9JCm1OAv8A0ioH40AgfAnaWD4cUYPzbXr721bt9q+wRFVjI/UNJI5wpiVU6T/cqQ==
X-Received: by 2002:a05:6000:105:b0:3ea:63d:44c6 with SMTP id
 ffacd0b85a97d-413591d794amr397045f8f.35.1758815681721; 
 Thu, 25 Sep 2025 08:54:41 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb9e1b665sm3417758f8f.27.2025.09.25.08.54.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 08:54:41 -0700 (PDT)
Message-ID: <55d6e655-85ac-4a1d-b278-8a5c1f78e417@linaro.org>
Date: Thu, 25 Sep 2025 17:54:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/36] target/arm: Add key parameter to
 add_cpreg_to_hashtable
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-25-richard.henderson@linaro.org>
 <63a29a08-67ea-449f-954b-f62abbc39346@linaro.org>
 <CAFEAcA86ruJ9R8OFCXd1LHhNffyNNC_N92oXunm6UgBh6yyYDQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA86ruJ9R8OFCXd1LHhNffyNNC_N92oXunm6UgBh6yyYDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 25/9/25 16:51, Peter Maydell wrote:
> On Thu, 25 Sept 2025 at 12:07, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 16/9/25 16:22, Richard Henderson wrote:
>>> Hoist the computation of key into the caller, where
>>> state is a known constant.
> 
>>> @@ -7587,18 +7582,22 @@ static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, const ARMCPRegInfo *r,
>>>             */
>>>            ARMCPRegInfo nxs_ri = *r;
>>>            g_autofree char *name = g_strdup_printf("%sNXS", r->name);
>>> +        uint32_t nxs_key;
>>>
>>>            assert(nxs_ri.crn < 0xf);
>>>            nxs_ri.crn++;
>>> +        nxs_key = key + (1 << CP_REG_ARM64_SYSREG_CRN_SHIFT);
>>
>> This is new but not mentioned. While the CRN bit is know to be 0,
>> we usually use '|' to set a bit, not '+'. Preferably using '|':
> 
> I thought so too at first glance -- but what we're doing here
> is adding one to crn (there's a comment in this function that's
> just outside the context of the diff that explains this).
> Since crn is both in the reginfo field and also encoded into
> the key, we need to increment both the crn and the bitfield
> inside the key. As it happens, at the moment all the regdefs
> with ARM_CP_ADD_TLBI_NXS have crn == 8 and so whether we add
> or OR makes no difference, but conceptually the addition is
> correct.
> 
> I have added a comment
>   /* Also increment the CRN field inside the key value */
> to hopefully make it a bit clearer that we're doing an
> increment operation here.

Thanks!


