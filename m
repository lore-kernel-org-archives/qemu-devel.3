Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28EBCCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 19:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6w4u-0005xp-N1; Thu, 09 Oct 2025 15:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6w4t-0005xf-12
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:13:27 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6w4p-0007oh-FN
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:13:26 -0400
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-46e34052bb7so15998135e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 12:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760037199; x=1760641999; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LsRf36nDc+pGUoipjWTJPy+E7vmtzxM8ieVkpb7+MjU=;
 b=s7BZ/10gj6TJP1zj+ioPNcTBItTjnR8NzWTfyQ2O8lYhfvGxOkbH6l4+wC6E09NcBw
 N2Hon7El33sY1PK0FZaux8WVUShso6zB4dA01Wc1cABrOZ5Aq0xaKPfEufPADP0BED0E
 Cwf38GDWw6zsJUiRHEKNb1Rtyp/X6FykLEhFr9K5+rXiI4ONFwdfBMWz2JJ6UULAnHb2
 1hxiuKC9cq+Ap21RDd4xockeBrCOQ1i/1ROxda7pXmItyChkGT4273DSAu/wL1XjjT28
 KiV6T6mtt4Jj+Enj2vzxsSrI7MioSoI26LZ94PTCfBCfwecb3+i9h8tcattwqrenB6Ug
 SLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760037199; x=1760641999;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LsRf36nDc+pGUoipjWTJPy+E7vmtzxM8ieVkpb7+MjU=;
 b=eoivByQLQKphFK2aaQyO7k0yvv6iyyCHNISq9wKWF2BF1UK0OHF1sosn4z6lH8QDqs
 a5CoXUeDGvQFcotoCYP1r3lSaoLAXukcOZ4qu3vmJVfXKGFW61Pa97uIl6V/1MbbAioo
 UOlmnnumq/Gl0aZENDi+GSzAX1oJb/UCm3Lo5Je1HdM3WnI/rrwFBB6yXHlOfxPnvL8h
 S4p4rzGDDs+LlELMST3EVdOhJseuiYVMJ3rnQcW7E/2DKrlEt6k7We2LpZO0rarkUF10
 /RLUXfCRLtRbOcAtlBt6XYCh0GsYgbTI0sFHtqQ17wc2oGKoJgjzCn1jLr1H/U0adsts
 tsdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWK4b/DuCN6sfpaYDL6RawKR0QweC+aszCdIiBsjzsYt1e4i4NFGMQoFinc73Zfkyk3+cScdfYzrmMM@nongnu.org
X-Gm-Message-State: AOJu0YzJBA9Ha1a+O19z5lWpQRsv6LmigrG8jCGs7Y7HLI8Z21fuyMzT
 Xm7720h1AEUqqUttwXFPt8Q8SGOiuNFXRZXysSMyuqscJDeEmZHN/8aphObghYMQ3kQ=
X-Gm-Gg: ASbGncs+uUur4AfcOoE9xT1+hxc6r8lVCj+v9+BPfY7Y1KvMWhxkYtSqkr7Qrm5QJTC
 yT4vOkN5jFalJnRDRhQYxrBlqFXkYXEvvk19nOEgN1p0/djHz+4mQ7CzRavnwlN9aKcB81t6lY3
 WjWwcHQXr4M/+ZOt2OdiK72srATNmTQDh8nndHhkiPcxitBtNFuGmnHIOXzXJ+9Yf/9l0gsIQmg
 LZFdbqOclxG0dRMSmx1jcm2KdZ1ytvFUkCaOvj4SBnXb/62q+8Ha3C8ZwuvTT5aKbs88fYqNcBt
 c7QStRJZwRX8FPN1ulwtAqHPEYjPuuZs+T8NEM3GEcvgxMOVsSzYXRYd3sLOyOduu2sOOitnES1
 PloHdEX1VxAC4vtIUZRDOfp3U4JbO/6inxkaE2HERP2WMsNnViREsDzaOnU4+ULjE4CE1Itjb39
 ZcSyAEXujmWSFu0bQQQA==
X-Google-Smtp-Source: AGHT+IHBHNPjKRw5ThkNbBdjkX3IdedLfg4ozDOzg2Mk5nrV784GmIA5hunOLPMLOZjdPpx8yMCXBQ==
X-Received: by 2002:a05:600c:1d11:b0:46e:49dd:525e with SMTP id
 5b1f17b1804b1-46fa9af197fmr70597475e9.21.1760037199307; 
 Thu, 09 Oct 2025 12:13:19 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e81d2sm371489f8f.49.2025.10.09.12.13.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 12:13:18 -0700 (PDT)
Message-ID: <30b243ef-e1b6-4f61-a6cd-a693c6c043ed@linaro.org>
Date: Thu, 9 Oct 2025 21:13:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tcg: Restrict qemu_ld2 and qemu_st2 opcodes to 32-bit
 hosts
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250820134937.45077-1-philmd@linaro.org>
 <226ab909-0482-493f-bacf-5d2930d07ad7@linaro.org>
 <f745f163-6bad-47ad-a1c0-4be96b604266@linaro.org>
 <b9e34640-43bf-4345-9718-f319ff185c1a@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b9e34640-43bf-4345-9718-f319ff185c1a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
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

On 9/10/25 19:38, Richard Henderson wrote:
> On 10/9/25 10:23, Philippe Mathieu-Daudé wrote:
>> On 21/8/25 22:27, Richard Henderson wrote:
>>> On 8/20/25 23:49, Philippe Mathieu-Daudé wrote:
>>>> qemu_ld2 and qemu_st2 opcodes are band-aid for 32-bit hosts
>>>> and can't be reached on 64-bit ones. See in commit 3bedb9d3e28
>>>> ("tcg: Convert qemu_ld{2} to TCGOutOpLoad{2}") and 86fe5c2597c
>>>> ("tcg: Convert qemu_st{2} to TCGOutOpLdSt{2}") their constraint
>>>> is C_NotImplemented.
>>>
>>> Not true: ld2/st2 are also used for 128-bit load store.
>>>
>>> See: aarch64, x86_64, loongarch64, ppc64, s390x.
>>
>> OK. Hmm I guess I need to add a __attribute__((unused)) check like
>> you did in commit f408df587a0 ("tcg: Convert brcond2_i32 to
>> TCGOutOpBrcond2") to outop_qemu_ld2/st2 then.
> 
> Why?  Please expand on the error you're seeing.

It was a mistake on my side, no worry:
https://lore.kernel.org/qemu-devel/c75dc27a-5c56-4010-a205-a8296a9ab1e0@linaro.org/


