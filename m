Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A04EC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 13:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uloqO-0001HH-Ft; Tue, 12 Aug 2025 09:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uloqJ-0001Gl-8h
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 09:15:07 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uloq1-0006sG-Cu
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 09:15:06 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3b788feab29so3363608f8f.2
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 06:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755004487; x=1755609287; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yMQUthE/7r3UTpNjP8p4UhkJxaTvamD1kv5+fu88bM8=;
 b=cA+8wb2ulH1KiRU+I0LzpAmYxtFwwrU0mSC/kP1WXZDBk5yedxu1ZLj1oDAjLOTt7z
 iBNvMBLlSuRSY4CdcJpe+AsYRg2YD0bvDk3lqwqFMEuTIOIuspL1OJ+dQa3BGycTNs9Q
 miV058DyH2IFIFafufVk3qLaFoL+cVLLG4Y+kAfnmoYVJ3p6Z6l3wSbYtJE4FZpBdvTw
 mc6ILq6ne6/fYRWZUbTvuxtEXTJTlcCzMUgnneEqukvJ2m0+bSbXadRERWm9HTMcM4A9
 b8LM49x78/b/XTpd5y8Sc8K7/zu5uqCOIlHlJdxPe2zxf2nmUFzQHn2eBHQMidXLbULT
 CfmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755004487; x=1755609287;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yMQUthE/7r3UTpNjP8p4UhkJxaTvamD1kv5+fu88bM8=;
 b=Y1UOSpqf3sdd8pdP8cSIvwddATkv+Kv1B0iCUz/MLlHubFLrr9W2Ar1sJh51QfXcWJ
 em7DSuRSiIYLphMTYZ6NIBHDVFkxfOLRMvY4WR4J3t2h7DswByKJZvFF4MH9IA4ZLg7Y
 28g26QXsl2Oa+JLOtHeLKFqvRzClldq6uGZF/JZqdvRHmn1izP8sWcUq3EspFnduCMOy
 AANn3yM1Byk6IbcLRMIagkbdqvIIekPXQPGqz3Nlt6Efaa16i5rCEwL91HdUVe5tdqCb
 RuQPvgsD9aIlkiYAI5ML/A0awng/xG2UInfdiB1d7F3KjHBXIes2fN9oyUcL+Ro08sHo
 Ad3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9xVNvINLjddhNKcQZypXZB03i8jGLIUYnSDfzYsQWo9Tcm90rAJZEm2Dt5ja3b0c+NfrCO6G27oeM@nongnu.org
X-Gm-Message-State: AOJu0Yxve8xb2D7tKogVt5p5JcNJdmoC7Rch/fvUOboIX0gBexCstOml
 If3F/c2I3P6W9BaHRXHEl1n1/C01b6BwqZsX1SLIjyCMAsBe0j/Ef8yLEr4hT5IxWGk=
X-Gm-Gg: ASbGncsIY0OqqE8eHbitqxqxkMAfeqHGhc+KTEc3rsuHVSfWFOT17S6fzmq5LXqFGA2
 OHkU1gh0Bg9Pv7LxYqRRl0jKgDn+LhYBkUbiTr2F/01UROCLYWlMnu/QKADB3BGgG2OgouxLueo
 74IWVcpUXMveJ6NCOUzlfkO5eEWc8FBMZno6kL5s7DMNQB6NPBgUaZZbb9GvWPXVfaY7e3SDwM2
 9Gfca9hWG08WP0Z20xB9q/H8IfRqHn9/mKg069q+/K3zZEkE1JNXv4NXMReMN9BzToVPbd5Pd+A
 BAhdbW6gnehuW9TOzkqRLcRNn/lDWamYGxqeCdbHDOOGx8eeU+j0LNa7ZJ3lSk3at156axekt7R
 0DgWKYAU0HvaxP6QjW3A3+An3jqTTamj8XwoHiW/wg5xtE5ypC+4dsA+R72bNdbehwQ==
X-Google-Smtp-Source: AGHT+IGU8Xejv3T7WgQTjxCBNaK8sVXxoCKGsF8YnLsLBOF8+kjiEEPV0mG6An9GCW2DdcbIbbqiNA==
X-Received: by 2002:a05:6000:40cb:b0:3b8:f318:dc61 with SMTP id
 ffacd0b85a97d-3b911010b31mr3308029f8f.40.1755004486644; 
 Tue, 12 Aug 2025 06:14:46 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3ac51asm45255181f8f.1.2025.08.12.06.14.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Aug 2025 06:14:46 -0700 (PDT)
Message-ID: <9de81169-5abe-4fd7-8a34-444361294954@linaro.org>
Date: Tue, 12 Aug 2025 15:14:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/85] target/arm: Expand syndrome parameter to
 raise_exception*
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
 <20250802232953.413294-24-richard.henderson@linaro.org>
 <3abbb8de-bbe6-4404-9714-50b487c46a8d@linaro.org>
 <d7e55a44-03ef-4d13-9705-a743921138be@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d7e55a44-03ef-4d13-9705-a743921138be@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 12/8/25 14:15, Richard Henderson wrote:
> On 8/12/25 16:26, Philippe Mathieu-Daudé wrote:
>> On 3/8/25 01:28, Richard Henderson wrote:
>>> Prepare for raising exceptions with 64-bit syndromes.
>>>
>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   target/arm/internals.h     | 6 +++---
>>>   target/arm/tcg-stubs.c     | 2 +-
>>>   target/arm/tcg/op_helper.c | 4 ++--
>>>   3 files changed, 6 insertions(+), 6 deletions(-)
>>
>> Maybe re-order with previous patch?
> 
> No.  With this order, the destination is never smaller than the source.
> 
> (1) Widen env->exception.syndrome
> (2) Widen raise_exception syndrome
> (3) Generate a 64-bit syndrome during translate.

Right. I was reading the series backwards 🤦


