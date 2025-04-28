Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C05C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 22:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9X6v-0000wW-8J; Mon, 28 Apr 2025 18:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9X6s-0000vB-Tu
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 18:38:00 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9X6n-0001tO-2B
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 18:37:58 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-739be717eddso4453545b3a.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 15:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745879869; x=1746484669; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M5hlfZiLAYWt6bKYJLRFXVd9RsPvX+9Kz+as6sxKwm8=;
 b=hSwyUDkHqE2W8SqANYsU+WzZrHLflqQfm9X9Q+kxvpYx5siPzXEZyHTWpx82JVjmyd
 00384xp7B4H8MPALX9pi2wRYbGJgy87+ZXWBSezP2rfgka33gf6uMXvevbt9C6PmVEN9
 BaT1HBlPuogQ/xc9wcqplTN7I7s1dTpqETsqfKcQlHwQC9gR6h55cce75me12MGHXjBd
 f3mFYMwEYqFe2Im7d9Oa18j7fHYETCbWrx35S2uPSJ3zzxIYytQZ4ySU2NyIZMxgSkUl
 TCzZjYTryLTw2xNeYoywJPpT09P6BWzqpcxoiiiseS/oBRGS+CoKG51esz8MST4XFpfq
 13Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745879869; x=1746484669;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M5hlfZiLAYWt6bKYJLRFXVd9RsPvX+9Kz+as6sxKwm8=;
 b=sayQNfQ/KcFksmaWR4PQlTNLCvGMk7Tqzli+I1SibfyezMQxk2Sr5DCZJ5okQ9/g1F
 7LuLS+cSccdq1WhcLM/u7qC7qXI4tFDDJ437KqmvmlYJUP6nCeH3EMI6s+sfReIymieR
 eZMwNTNBN2aIa7bG4H+QbWVSjoCg0CeFPC+Tc8tzdq3Z/y6Zyh+mGn4k5bkLxQpgFyS4
 rAtjaONxNhh+TXhUybxDLuWG5Eh7eR3EKTR3zDkqIEFBIcs2KCvMxOgT6+z8K67Uga/C
 OjldSBUg9HOFpyR4n9Th5PSYAUPT+DYkgCKNWe/0xTpJujgZHt5pVrdhz5Ui0/KR/bZC
 Kc0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1RnCYBUcdc1aGDrAoPTEu56F6t0s7Wcc0vnx4S2HQdczXTUVMc4gaj9gzHvWx+0guRGRM59RHcCkl@nongnu.org
X-Gm-Message-State: AOJu0Yw7v7MA/JdgnG/RNmtzZ8z3mAJkXfOVxN3SbpqgNNhOm4Kt99et
 imdKNVcGJVYGSga1jFHEPEp1M9y/jnyzmcx9UzDEI3eXtTWEljWBNn3Dama/jMZX3Nw//R+K68X
 d
X-Gm-Gg: ASbGncsrM+InX4UDsi83X0wksc1tHu7vbUy1fjk/oGddeZ2iX7LGSr3f3DhtdwumgB9
 J1Ai3aFF6bO1v9KRxlUrdva/wLR4vYuDly6CKMcaCbexqvxhrnyD2IeQ5AC1bx30BXYGMm1ZrBi
 UzKhW5qUiep4Y4R9wLaDF156mFeWv8FhdcJyOoe4iy/H4RKpYfgqAF8WTGRuPME/nZx1DZ9Yq5w
 q2+X+DROxarbpj9QJEEmxqtZQ+8GN2mAk3L15x8tjh30+cJI+DPrX6Yc47cDlUefyi+LRLOZ5ri
 QuaQw9SoRErLlC3Uw4TR1KJgyPOruiw1MWCqxXhZRIZ4N7HLe5DEtXfR+aWYK1auQmMPXqK0w5e
 59pz5q8fYY+W31u5rhA==
X-Google-Smtp-Source: AGHT+IFApPHb1i4ZEI8FgaR00Q66tx9l3nFgn59sw6wveutNb1Dd4F/iW/FHAtMx4+bqxgCdkMXg1Q==
X-Received: by 2002:a05:6a00:ac5:b0:739:4a93:a5df with SMTP id
 d2e1a72fcca58-740294703dcmr945517b3a.12.1745879869344; 
 Mon, 28 Apr 2025 15:37:49 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6e252sm8536891b3a.119.2025.04.28.15.37.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 15:37:49 -0700 (PDT)
Message-ID: <ad2a2ba6-04c2-4618-9003-47625d31b365@linaro.org>
Date: Mon, 28 Apr 2025 15:37:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] accel/tcg: Return TCGTBCPUState from
 cpu_get_tb_cpu_state
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250428201028.1699157-1-richard.henderson@linaro.org>
 <20250428201028.1699157-8-richard.henderson@linaro.org>
 <e56a1170-9e0f-4aed-83f5-99ac5c1261a3@linaro.org>
 <31ec7f6c-e5fe-401e-96f4-74bc7b0dee36@linaro.org>
 <db0b8cff-b79f-4f4f-8322-c9f41462cdd5@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <db0b8cff-b79f-4f4f-8322-c9f41462cdd5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 4/28/25 15:26, Pierrick Bouvier wrote:
> On 4/28/25 3:07 PM, Richard Henderson wrote:
>> On 4/28/25 15:00, Pierrick Bouvier wrote:
>>> On 4/28/25 1:10 PM, Richard Henderson wrote:
>>>> diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
>>>> index f5e5746976..8dbe79ea7c 100644
>>>> --- a/include/accel/tcg/cpu-ops.h
>>>> +++ b/include/accel/tcg/cpu-ops.h
>>>> @@ -18,8 +18,13 @@
>>>>    #include "exec/vaddr.h"
>>>>    #include "tcg/tcg-mo.h"
>>>> -void cpu_get_tb_cpu_state(CPUArchState *env, vaddr *pc,
>>>> -                          uint64_t *cs_base, uint32_t *flags);
>>>> +struct TCGTBCPUState {
>>>> +    vaddr pc;
>>>> +    uint32_t flags;
>>>> +    uint64_t flags2;
>>>
>>> Could it be named cs_base instead?
>>> flags2 is a little bit generic.
>>
>> Of course flags2 is generic -- it's only cs_base for x86.
>>
> 
> It seems to be named the same for other architectures as well,
> so it's wrong for all other arch too?
> 
> My point is that:
> tb_gen_code(cpu, s.pc, s.flags2, s.flags, cflags);
> 
> is error prone, and it's easy to swap flags and flags2 by mistake.
> I don't mind the name, but something more distinct would help.

I fully intended to go on and pass in TCGTBCPUState, rather than 3 separate args.  I guess 
I stopped early with the meson.build change for build twice.


r~

