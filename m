Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A140C28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 18:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u02Yr-0003N8-PY; Wed, 02 Apr 2025 14:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u02Yg-0003M4-Ov
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 14:11:28 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u02Yd-0002Om-Cu
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 14:11:25 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-226185948ffso1561345ad.0
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 11:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743617481; x=1744222281; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qfgdw4kaeGTPriUB8nti+BFMqadk8NUrM4ya7NdN4SI=;
 b=yPx+a5RaOVa55hhFmbkmjogKOEnRxl3Gt8oWMkYdhd13hYoLjKT+VhvwMYYWEnBQrs
 r9B9u/5GSjlz6S6WzoR9NR6RW69V1WL2+2sMc+Smwd+9lKSJbutLNMM2Cyigdl/0CzN3
 sbepx5b9upkNm5yhvBYhR6q9UXcco6/j3j7+u3QubR3lFJpppq367xgq0SPef7FPRZyy
 JRyJl37vvhQE2ZHMKu114U13k8QYjGqvgGIG8szN3ExgAXUECgMD9gaeRKL7sLwQ1/6q
 VTmLm71UibjCtN/S/WhUTa6Aqap9wt8Vb7F+NSIdRTvInvquKpQrJ2VeZtWahOx0ag7I
 6coQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743617481; x=1744222281;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qfgdw4kaeGTPriUB8nti+BFMqadk8NUrM4ya7NdN4SI=;
 b=xQAEF4yh5aX9Op0naz3KUQft+SHM8BD2OWSJWHyxYt0QlY4ffrAioe+Pho4Jqfh7X1
 0J6p2TaOX0byZnNEBMtxQDL+d/5DefuAGzYXFfy0IyI4+FnxACDxSxOAXYTNPJbhGBFm
 9rfU1EBMXjDrqvED9JOCjnUZEFMPrbZrYqQHv79pzSOLEqFfHJ5VyMg7WchLpE6OafD7
 njXwbIFg2TfQ9bFZUybGiiLivYEHuQaiAKk6GuFoFvYk0v+jMot6KjkDeUfLY0EhhYsJ
 ovSenQ+Il0akp39eers3UlOyA/W5koZimX7uYjvYSJYJLxn7MVFkgp0uqdRN5V3oxsHw
 lYSA==
X-Gm-Message-State: AOJu0Yxy3evsQpCiowSgMaudkcG0tURm0rMcZ8iQgIKE7U/m69q93oE4
 0icqsA45O1Pt1ctXHmhxsO9R2n8T31pPZ/ADOz1neq8m1WZFdraimB0jQ3IfQU0=
X-Gm-Gg: ASbGncsPEJokb+JKF80lxe20resykh9/cukzXxqUG+TYhvClrgtk1jdaEX+OPhxRMah
 6vxUK838zGfsgYL1Ah8Xei6p2WBeCPVV2RydY8jOI+rKqleBJUib8PKxQCrz+O03PTU3CQCt8FM
 ywzLuvJqrBlQ269/6S9c7RKYugM1t879KqtDtdhuB2wTu10euGuBzl1fnvroL8XozxGfqUB0lLy
 qZCOA/+XxXYY8w8z5lSBe992FZO4cAfPfnsC5z2Nc3hs+DeEjSjXM/2eyyCAtYSJ+Vile4pxW/2
 zU26GiKpcq6wHS41eSZ9FRhCi8TqrC2MsqGSBDnRd3HWyTH0RJA9iExA3vfURvf6y10P1fqLMX9
 dYWd5pcRe
X-Google-Smtp-Source: AGHT+IF5tEGHev0xHtnBM5vNqMuDNBFvWLRIN8wbPFaD/sft8mJUNteDPutCjz2CTNc5iErVrcPoOg==
X-Received: by 2002:a17:903:2b04:b0:224:1c1:4aba with SMTP id
 d9443c01a7336-2296c86c83bmr43919375ad.50.1743617481022; 
 Wed, 02 Apr 2025 11:11:21 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291f1ce133sm111712395ad.112.2025.04.02.11.11.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 11:11:20 -0700 (PDT)
Message-ID: <8d897be6-24b6-4fe3-8201-59f0bd08763d@linaro.org>
Date: Wed, 2 Apr 2025 11:11:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/mips: Revert TARGET_PAGE_BITS_VARY
To: Huacai Chen <chenhuacai@kernel.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com,
 arikalo@gmail.com
References: <20250328175526.368121-1-richard.henderson@linaro.org>
 <20250328175526.368121-2-richard.henderson@linaro.org>
 <CAAhV-H6=iZOBfxF=_DXqc5M9GjTiXJ7nxotLAJ-0Eb7=zVd0bQ@mail.gmail.com>
 <b17663bc-40c3-4501-be88-065363138038@linaro.org>
 <CAAhV-H4mmKvJ75uSm_LCFrCFYM0QG=4oh0ZLVTGXdKX+svs5eA@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAAhV-H4mmKvJ75uSm_LCFrCFYM0QG=4oh0ZLVTGXdKX+svs5eA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 4/1/25 20:04, Huacai Chen wrote:
> Hi, Richard,
> 
> On Tue, Apr 1, 2025 at 9:39 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 3/31/25 20:15, Huacai Chen wrote:
>>>>    #  define TARGET_VIRT_ADDR_SPACE_BITS 32
>>>>    #endif
>>>>    #endif
>>>> -#ifdef CONFIG_USER_ONLY
>>>>    #define TARGET_PAGE_BITS 12
>>>> -#else
>>>> -#define TARGET_PAGE_BITS_VARY
>>>> -#define TARGET_PAGE_BITS_MIN 12
>>>> -#endif
>>> I'm a bit confused about TARGET_PAGE_BITS and other macros.
>>>
>>> In my opinion, if we define TARGET_PAGE_BITS as 12, that means we only
>>> support 4K pages. And if we define TARGET_PAGE_BITS_VARY and
>>> TARGET_PAGE_BITS_MIN as 12, that means we support the minimum page as
>>> 4K, but we also support larger pages.
>>>
>>> Am I wrong?
>> Yes.
>>
>> TARGET_PAGE_BITS is a minimum value that is used by the memory subsystem for managing ram
>> and i/o.  If variable, via TARGET_PAGE_BITS_VARY, this is set very early in qemu startup
>> and cannot be changed.
>>
>> The page size for the mips cpu, like many others, may be changed at runtime.  The page
>> size used at that point is reported to softmmu during tlb_fill.
>>
>> The value of TARGET_PAGE_BITS must be the minimum supported by the cpu.
>>
>> For Arm, the minimum for armv6 was 1k, then armv7 dropped support for tiny pages so the
>> minimum is 4k.  At runtime, armv8 supports page sizes of 4k, 16k, and 64k.
>>
>> For MIPS, ignoring those cpus which support 1k pages, the minimum is 4k.
> If all types of cpus of the target arch has the same minimum supported
> page size, we only need to define TARGET_PAGE_BITS; otherwise we need
> to define TARGET_PAGE_BITS_VARY, and TARGET_PAGE_BITS_MIN means the
> minimum supported page size of the smallest supported page's cpu type.
> Here we remove TARGET_PAGE_BITS_VARY because we just ignore the 1K
> pages.
> 
> Am I right now?

Yes.


r~

