Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E843FCD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 16:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waFnD-0003wl-RB; Thu, 18 Jun 2026 12:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waFn5-0003wZ-6z
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 12:40:31 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waFn3-0000sd-LI
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 12:40:30 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c855599a77aso603226a12.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 09:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781800827; x=1782405627; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aj4Rs4VF3vyG1MUFWZRlfYSO8RUHcZIrumLmSbNWmCU=;
 b=A0yVTGGTpm2w+SnWgPQw/UByUaxVkfrD+K/X1dLwa8I4Xe/I2jh/vGuNP+daRX145C
 WD8bhA41zCl8Y+MowHD6p/nNCeNAPRL2L4vEhUuU7tbmcebAZitv6LnrqGpXO/DYRy56
 wnC+dVAFig1og5Z7Fx7gJPbnkPfJxuKv3+DxcYdTxB2zbW4f4reNILVIuG4grwDt1SEX
 LbOZAhuWP0AwwvgSwP5c+cK92e/LfHXhEjjWeqVQXR6ceI4DdLe26D4FJQL70TrqH2E0
 SXZCTwIYDOD+0kOEka42Lpcmr12F8V9A5S5/Ed9LJffsmJLcI6N0RM0J+ZJcoir1LuJE
 fZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781800827; x=1782405627;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aj4Rs4VF3vyG1MUFWZRlfYSO8RUHcZIrumLmSbNWmCU=;
 b=ojm5NInnisi7SVVTTMbzYcIsxM1Cw99wJx59VuU5AMawmzTjRtQ8mM/DkwrMRMWHU0
 Sw5pxiEXtFdbmhz0fOU9HsmrVijQOCh9Uo7N1BFz2y1BsylymeuQ43LbwyHLUgAN7jf/
 gfcXKV49F/6NJ3PWEIE0GOeLVq1QUWUM9g2mbZBTtju5JT1lbEx1SSLlp3BkT2cNNmea
 M4KD3MNjn3+Ks/WXSbOXFr5DzHYthgswezP5XK+6LT3TR0bNFmj90UOK1Z65XV73jMay
 2h+4gvDT1f03lwXEqxwmWzaYq0663nAJ23RRfr9BjqJu1eezbaQScLYoAKUkLcdLG/ZM
 f7Gw==
X-Gm-Message-State: AOJu0YzuIf4xS3+BA6QNIO86qt4+PP47vAg4AbvwBZuPH6u0kr2vamUh
 nH2D8/4kCKdG1ynaKFovPndA7Jm+Lte+ItiUgqlr7bdlNEG0PzSPtrdoorSb1ALDqNY=
X-Gm-Gg: AfdE7ckCtS0IMsH5KOgg1okPeUJe2yaD0agY4C3UWHSxtIFjNNiUe08mb6gmF6SvVms
 WJn6wAIf9JIDIg4yu2+4PqX3kO6ZV9+qXnMgqkmNGuR8iOo7dHLEe4p3pA4IK3fVNZEn/pKNGKc
 +9sAJKaMM/z53xMAg0YZHBtjZO3fD8bk6DXZoy0v6uygzgQBZZJQcPImHBfsH4Zb9DKPvsdaW46
 ErzjmsBL0TZdl7Z94Yz0Tet89hLE7NxwBlUVNWDpF4lhhyi3sFwV71CQDAaEiOBJA20/EwOHGKc
 FuQC+cdRtWpRL+UaKkRFESrcrTUOcVSmm7T4s5XEk9ZtOjv8ybNTdWhi5+MZsawL2UzpmAlY+gO
 8ZpolvF6fJMEdKBX/FP0X778hYKMvJIDMixqG9tYBM9hhWxBg887351taaHwiCeEFVqTOQKcyaS
 U9MVaUg+nG0rZLdVZ1RMxPF3txnr1AnV2QcvbYTFIwOSZdl7cffsG1UWAf5Q==
X-Received: by 2002:a17:903:38cc:b0:2c0:d9b7:b7b0 with SMTP id
 d9443c01a7336-2c6bc24e17fmr101710075ad.31.1781800827443; 
 Thu, 18 Jun 2026 09:40:27 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c6a403b242sm84587795ad.31.2026.06.18.09.40.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 09:40:26 -0700 (PDT)
Message-ID: <1947c117-3a1c-46fe-8a6a-95f9e81433ce@linaro.org>
Date: Thu, 18 Jun 2026 09:40:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] target/arm/ptw.c: Add Granule Bypass Windows
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20260603-jmac-gpc3b-v2-0-115c51936962@linaro.org>
 <20260603-jmac-gpc3b-v2-3-115c51936962@linaro.org>
 <7615fda1-4052-4696-b477-6eacc057c4a5@linaro.org>
 <ajQFQ1RY_JfYooNH@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <ajQFQ1RY_JfYooNH@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/18/26 07:48, Jim MacArthur wrote:
> On Wed, Jun 10, 2026 at 09:41:56AM -0700, Richard Henderson wrote:
>> On 6/3/26 11:26, Jim MacArthur wrote:
>>> +    const uint64_t BW_STRIDE_SHIFT = 40;
>> ...
>>> +        switch (bw_stride_field) {
>>> +        case 0b00000:
>>> +        case 0b00010:
>>> +        case 0b00100:
>>> +        case 0b00110:
>>> +        case 0b00111:
>>> +        case 0b01000:
>>> +        case 0b01001:
>>> +        case 0b01010:
>>> +        case 0b10000:
>>> +            bw_stride = 1ULL << (bw_stride_field + BW_STRIDE_SHIFT);
>>
>> BW_STRIDE_SHIFT should be 39 not 40.
>>
>> Everything else is correct.
>>
> 
> Agree with the simplification, but BW_STRIDE_SHIFT should be 40. As per D24.2.54, a BWSTRIDE field of 0 gives a stride size of 1TB or 1<<40 bytes.
> (gpcbwu, the highest bit set in the mask, is indeed 39+BWSTRIDE, but the subtraction of bw_size from bw_stride has the same effect.)
> There was an error in a later use of bw_stride which might have made it look like something else was intended.

Ah yes.  Thanks for double checking.


r~

