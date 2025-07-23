Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E680C83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 16:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uecBU-0005zM-Op; Wed, 23 Jul 2025 12:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uecBS-0005nT-Bh
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 12:19:10 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uecBQ-0005yK-8R
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 12:19:09 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4563cfac2d2so56645235e9.3
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 09:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753287547; x=1753892347; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cWi1xg6TqVJV9Q3V1vDbJp1BsIWYYwrENbU8rPFEc48=;
 b=gYhrZlbG7BDF57GdVCsIr8CC0Lq2v0nb+KtFCozAHakE6N5774B7OIr5BxYjrlmYdc
 PXw0S/SKgkwO04zLNBI+3IiDspZwbdwk2yekX/xkSfspHLDmB/ErREbL2jbPTQgPEnxX
 eRtiYMSpeyG//m3IoLTxs2CK6/ge2eqBTPvOTbddJbmwca+A+kAdMaytt+v9B2Bu/57M
 MqQamLOeMfS3riFwa7AaZBBf9etgEPG2Aq09egQr2nvItRGNvYiT5Vd4UC1rm765V4s3
 qzjyX2l2NW7AsYHrppcivgVKhmBukS+PI8kOCX87xLNPQDUAVwAbW+wf41O/W2d/V0+s
 NsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753287547; x=1753892347;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cWi1xg6TqVJV9Q3V1vDbJp1BsIWYYwrENbU8rPFEc48=;
 b=hnCQs7kaoxwuYLF80GKHhGTjbtYANj8Q7VvZtkxQ/8OXvVoHaZByLtGnGd6b7q++jo
 5qSx/uGGfnD6aoAEquI9f12j0B4DuaVfKhZvcEVIZoDZNWwZuSBCnz8H3A7umP2MuvP8
 KVBE0rLezTg7JdKT8XC7tlbx1PheTEbqYZ8M+ZVKyyF8H/4UA3sDo4CHf86ky88R0YeB
 GtlVAXhBajRTO27cQWTXWDHfm2b6urIXNbXT8Le2VBhmXcD4A4jQQp5m8w1KnDHzxlCS
 NoVa5cQDSfGBEXmzdvqjJ7k0OjERfCB48GKeAmLA7eDXZ4inbuDE1phuokZrsJS0btpV
 oY2A==
X-Gm-Message-State: AOJu0Yw0aLtj2wez4Um12Vp4jCpmaM8+SMHlyf47YvLINF/mDIEg5KD6
 WYNzQJs3YY13djO3x03EQnXpZmsoIu8ipS8rQ8G3IWNTF0T0C9QOdYZePfG4sclrVTQ=
X-Gm-Gg: ASbGncuEotyOgLiUOis+TKCk8zHNPNf0/T3SKgMiTtcG/XZ5wfbJmkgzXuhNuJmbMP1
 4vTNLO9KLAYBOvd6DgL5yH4GGN3XrdhjQU4H+PiDuu1QHofcK5rcS3+WNEMCdeomJrgZXmPcZ7u
 c+YsY/EhIa/VhlTRGTnCRQNj/V039kyaOEnCU+/tnytA9JcePGfMqJDbGfCrqdUZhRfpTCilSNU
 EZSR3ao3Ut7zm+e3UUbXfmbcn+NSiyxJDc1vnPb25rg4awnj204gOTtdKaV/i7VujiM5QFjRXFM
 zSnhbcqyRrpM4DXi3H0wK+edmZIN+yg/wJUbB+/ZHJ4laRysqgTj0y1TQjzkeSxw0Mww6z1Iqqn
 8s0WnlIUaKYqpoMLrofJdozc9Thb6KFPsMQfqm5PSjEuPXO38OXD3MLM3J4PyhtI4ng==
X-Google-Smtp-Source: AGHT+IEXEMGg5xs/yyxPHcDZhF9g5nIvzjn+zvmuny0Ia6ajv+Oj9VxRvR/CrN5BMb1Hzc/z9xASbw==
X-Received: by 2002:a05:600c:198d:b0:453:483b:626c with SMTP id
 5b1f17b1804b1-45868d256a7mr27246935e9.23.1753287546599; 
 Wed, 23 Jul 2025 09:19:06 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45869180a00sm28100955e9.3.2025.07.23.09.19.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jul 2025 09:19:06 -0700 (PDT)
Message-ID: <bb780015-f5fa-4036-972c-a233b2b2af52@linaro.org>
Date: Wed, 23 Jul 2025 18:19:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v4 3/4] target/arm: Create GTimers *after*
 features finalized / accel realized
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Roman Bolshakov
 <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250723135156.85426-1-philmd@linaro.org>
 <20250723135156.85426-4-philmd@linaro.org>
 <CAFEAcA9HMvDjKa06iWMUTYsmM6zPQJZ3fAcZHcyF_pwa5pczvQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9HMvDjKa06iWMUTYsmM6zPQJZ3fAcZHcyF_pwa5pczvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 23/7/25 18:00, Peter Maydell wrote:
> On Wed, 23 Jul 2025 at 14:52, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Call generic (including accelerator) cpu_realize() handlers
>> *before* setting @gt_cntfrq_hz default
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/cpu.c | 65 ++++++++++++++++++++++++------------------------
>>   1 file changed, 33 insertions(+), 32 deletions(-)
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> (I think my previous misgivings about this patch were due to
> not looking closely enough at it -- it looks at first glance
> as if it might be moving the cpu_exec_realizefn calls above
> more code than just the timer stuff, but it does not.)

I agree the default git diff output is misleading.

