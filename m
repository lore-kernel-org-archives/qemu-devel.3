Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA3CC02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 21:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcWG6-0001CI-Mw; Mon, 27 Jan 2025 16:03:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcWG5-0001Bd-9h
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 16:03:01 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcWG3-0007UC-J0
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 16:03:01 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21619108a6bso84440425ad.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 13:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738011778; x=1738616578; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YtP6v629R9AhTit9oytNBZMXV51Or2oSLikgU2s5c74=;
 b=oHsKyitmTYX4686IBZvnsOgEykitk7M3GEVryrETlc1uAtQYKUNzg2yzHKcZL2NdfR
 2GvHMYZwwjeCd73ZKMlJDpU4rgfPrbeFPWQ9yENb9vTJoVdVQowzd7zfdvhJsFIuSgyf
 cZCxAzgjLX3yOBRzGYpcM9iZoi9+SlRKPWSxm4TWqI09aCkdH/ik3FysJpShEu4n3/l5
 YGcFNxM0uwOAz+MwyDKjqXD71N8255nNM+5lfv2YzZUlYQzD788GC7isebIKLZz4ir13
 Ji4jFw3xeTPoVJKpIW+4dOqOT03/cFhUCCcVXW54vlOKZuCzW6KaHr+BEju7JyqOCeKR
 UWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738011778; x=1738616578;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YtP6v629R9AhTit9oytNBZMXV51Or2oSLikgU2s5c74=;
 b=gWSHHf7qjROzJweq32FACdyuHrifO1DjCr1bPDF05L3gx0Ua1WmEsRod13uySKnEkG
 j5ADYzfhjK4/6uPjn57eA8CcOw4P6bScMp3H4Zz6s8bZkCoNvuA/kdZZD683S7SuJdXB
 dL8eqhdRAQKcCrhm4Msqrj3kkcOgOklxfm8CBRHTZM+bBRfCmvyDrSXlnAAvBpuqWqSe
 5pm3fWQVSvxR1N4DAlAIv6aSiqzz61ICx67LmwANXBlgSvGqkRDBXapoi3lbW3G43oXR
 T/CAfg9CevP/B81nQ6L7r2ZGcGzyTsK8sJ686rqQV5QPzmuwYKjTF+HHjBOYC4ycWIyg
 LgsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYeCUyGzYrERTapU866GHKCrWKwUFzIpMqEiRo/H7aX0PuPtAe9s2cuPAS9nEYDzYmQGbOho53nTm6@nongnu.org
X-Gm-Message-State: AOJu0YyKD5+vw+a02aSUAdN2GTdS8gKnnGDzXMIVtZNFiAMrkSYlRISU
 1/WIkT5Xz5+hhVozpS7B993sJ5GZcOxFbdDgxFEKjdorU9959srqprjKJYjzsAU=
X-Gm-Gg: ASbGnctBzo0x1XlRGQto93ofmM9szsFji/iyGyr+vNmW6Ng4K1VxySuISNT7pX9moFJ
 LM8LWMI0tEBiE6+LikmM20/JWW7E4cegE2ccLyheaa6tP3oKnNbeDRjLvBR2UIRyZY3W81jdmML
 HcMPGCpTIHi/UiWARhuoI3Xprd73jVR659vufqMRR10FxTehcZsCOBdNiBFWAYMn91YtFdFDY4Y
 BV92MUGAiFDbCYLbixkoJDjq4w+BRjDXxN2QShcuy/6eOrCTrhVH94DvG1Yt905KYyk+wRZqbi5
 cSkQbRRKzfCO9/ZlD0tjw5GM51HoD5FI444FBKBPPgHACFI=
X-Google-Smtp-Source: AGHT+IGvJN/nla0Df1H4OnTomN1kuRsxdBhfJQOWePadN1GFOfV+IR/TJ+J+tE4B6Hoayi+KnEvBGA==
X-Received: by 2002:a05:6a20:914e:b0:1e1:70ab:b369 with SMTP id
 adf61e73a8af0-1eb214983dfmr65788520637.13.1738011777822; 
 Mon, 27 Jan 2025 13:02:57 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ac496bbd9e7sm6764996a12.65.2025.01.27.13.02.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 13:02:57 -0800 (PST)
Message-ID: <27599be5-9669-466e-8e34-4ec0831c91cc@linaro.org>
Date: Mon, 27 Jan 2025 13:02:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Deprecate nwfpe emulation?
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20250127112715.2936555-1-peter.maydell@linaro.org>
 <44f75f64-4480-4cd2-a907-cf0638568e55@linaro.org>
 <CAFEAcA_BF_b8r8cOJVsk13qEQZg0BS5F16s9M6NFLQVHZBfq4Q@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA_BF_b8r8cOJVsk13qEQZg0BS5F16s9M6NFLQVHZBfq4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/27/25 09:46, Peter Maydell wrote:
> On Mon, 27 Jan 2025 at 17:27, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>> On 27/1/25 12:27, Peter Maydell wrote:
>>> We have one test case in check-tcg which purports to be checking
>>> iwMMXt. In fact it is doing no such thing: it runs the test without
>>> selecting an iwMMXt CPU, which means the iwMMXt insns are interpreted
>>> as FPA11 insns by the linux-user emulate_arm_fpa11() code. So the test
>>> prints garbage and then succeeds anyway.
>>
>> Uh...
> 
> It had me confused for a while, because I'd convinced myself
> by code inspection that we only enabled iwMMXt if you
> manually asked for a pxa2xx CPU and not in the default 'max'
> CPU, and then I found this test case that we were running
> with the default CPU type and which was apparently passing :-)

Any chance we can deprecate the fpa11 stuff too?

I see it's still enabled by the kernel for some boards,
but it depends on really old configury:

config FPE_NWFPE
         bool "NWFPE math emulation"
         depends on (!AEABI || OABI_COMPAT) && !THUMB2_KERNEL
         help
           Say Y to include the NWFPE floating point emulator in the kernel.
           This is necessary to run most binaries. Linux does not currently
           support floating point hardware so you need to say Y here even if
           your machine has an FPA or floating point co-processor podule.

No thumb2, no eabi, and oabi_compat enabled.
I suspect that's a very rare configuration these days.

I'll note the help message is somewhat dated.  :-)


r~

