Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE092C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 19:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9qFV-0002g8-Ss; Tue, 29 Apr 2025 15:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9qFR-0002fT-JZ
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 15:04:06 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9qFP-0001LC-TB
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 15:04:05 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-225df540edcso2311305ad.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 12:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745953441; x=1746558241; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KJUA94wbzrF2TqG5k3OIFWX0mNWNsjxKNMoNENadxj4=;
 b=zErQ2EwtwsH+ZETgylJvPV8WRX2wr3U+yTD+TzehScTq0sovhqJ/sB79xWVULxdmTl
 X3Le7DnM+lu62NDQr76x04Y/d8O4N5o9Ik/dUIQP/iW+WTeH3i55Y/sCP5lo9s9hAAWb
 ZviiImR/laVCYNqJ3x87KrRMUd/yNbw1efFVb9z68CY3ZEWtPY9zWAY7QRBKO24JTdZb
 fxny0CISLSUvcKHbVcn2hfpVwj2Tul0l7wlVsAb7oesxgGRIztIJ+xyeZr4XVuXqckY/
 RAMqfEMa1qOrvBd9PM7Xv3HKEFjPsuhqJhTlObtFVADfBtixS1nuBYnGorX0eDCFOBOf
 dR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745953441; x=1746558241;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KJUA94wbzrF2TqG5k3OIFWX0mNWNsjxKNMoNENadxj4=;
 b=YjpzmtPGNvr4frnLzrxe6qz765z28SgjhGflTYFOaVw4JLDbeEoGWLII2DhO9E6W+d
 N3idKeoQxQ5Hd6eyk5SAkZkZB2HkxX608G3tVHk+zgxuVN2TQgu9P0JcKyaRd6nR4e0x
 JLjg1Q1ktToYqb2XjJ6jX5el152PEEsjpefco019N8BYzUSQfd69CCXLm1FVm10zKAF7
 fG0coE0MZXk1use+UMTob7JHrXsMBq/hgaa7JzBy6igEgbvmRWFgiSzWNcdcndVk3E75
 OAhL4IcQa4ZtXQUKFjIZOu1Lsu++xJDGfCjj6Tl9arcAAnfyfzvLfMd9uTxd9oW96UUH
 WIfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkB8B9tYeYvY23sg9gw91Ri0D6kuXhiCoV7UjZ+8SS4DjH2m2maUQLlXYh3EiRHX+7zAjIlLxTDuPR@nongnu.org
X-Gm-Message-State: AOJu0Yz+UQNLoJakQRQi/eov1SLgjkgXN3vHtpCI+LU/YTDwQrx7Z23V
 9JXriF02sBMqu5BDawuhWVaLvmlT4U2n6bqAd5NaYkoLQWOoI5y6CZWXx8CbDL8=
X-Gm-Gg: ASbGncsmVBesg2XZK/cEEiRQ/srUg6qGbG+vwkctMJwgTemwumgtg3Dg8FncuSvp/Hj
 x/anz2oQW5hYZWIUYbJhcPvhNhWcePrzyF7mVz2VkkjfATlQI3j3BNAnSVIOtPHEcfsFXWv1o8v
 0oItetvMxiPXc4ZeqfKF7o4bD/zt1/8uw3tmgttMrwOXa6ZvFPeH4sVfGk7HhHX5gACo3DJrK2v
 qH85YJ9Jt1DALzS2aCkvij+zOzkvydmCvEzKoSeCJEzlnJnL65VRT/HrqAVXQzEYmIvycZvl8OU
 i5NEl85S7Wapjp3m9ZQVSipiMbA+fiJhLZoqAmZ2JpEHluw8l3u4OA==
X-Google-Smtp-Source: AGHT+IEFhCUzUk6NtiiOx7T9qwwC+alD3nE57XwtdM9FuF3xJNQubdNRWmbxgoGf5ZE6BkijouEEdg==
X-Received: by 2002:a17:903:1a05:b0:225:abd2:5e5a with SMTP id
 d9443c01a7336-22df474794fmr461365ad.4.1745953441450; 
 Tue, 29 Apr 2025 12:04:01 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dc70efsm106342925ad.95.2025.04.29.12.04.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 12:04:01 -0700 (PDT)
Message-ID: <0fe55a8a-a12b-4673-9d18-57ca42871fe8@linaro.org>
Date: Tue, 29 Apr 2025 12:04:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] accel/tcg: Return TCGTBCPUState from
 cpu_get_tb_cpu_state
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250428201028.1699157-1-richard.henderson@linaro.org>
 <20250428201028.1699157-8-richard.henderson@linaro.org>
 <e56a1170-9e0f-4aed-83f5-99ac5c1261a3@linaro.org>
 <31ec7f6c-e5fe-401e-96f4-74bc7b0dee36@linaro.org>
 <db0b8cff-b79f-4f4f-8322-c9f41462cdd5@linaro.org>
 <ad2a2ba6-04c2-4618-9003-47625d31b365@linaro.org>
 <1d3bc5b5-1bd8-4f18-9da4-db82f037e5de@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <1d3bc5b5-1bd8-4f18-9da4-db82f037e5de@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

On 4/29/25 11:55 AM, Richard Henderson wrote:
> On 4/28/25 15:37, Richard Henderson wrote:
>> On 4/28/25 15:26, Pierrick Bouvier wrote:
>>> On 4/28/25 3:07 PM, Richard Henderson wrote:
>>>> On 4/28/25 15:00, Pierrick Bouvier wrote:
>>>>> On 4/28/25 1:10 PM, Richard Henderson wrote:
>>>>>> diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
>>>>>> index f5e5746976..8dbe79ea7c 100644
>>>>>> --- a/include/accel/tcg/cpu-ops.h
>>>>>> +++ b/include/accel/tcg/cpu-ops.h
>>>>>> @@ -18,8 +18,13 @@
>>>>>>     #include "exec/vaddr.h"
>>>>>>     #include "tcg/tcg-mo.h"
>>>>>> -void cpu_get_tb_cpu_state(CPUArchState *env, vaddr *pc,
>>>>>> -                          uint64_t *cs_base, uint32_t *flags);
>>>>>> +struct TCGTBCPUState {
>>>>>> +    vaddr pc;
>>>>>> +    uint32_t flags;
>>>>>> +    uint64_t flags2;
>>>>>
>>>>> Could it be named cs_base instead?
>>>>> flags2 is a little bit generic.
>>>>
>>>> Of course flags2 is generic -- it's only cs_base for x86.
>>>>
>>>
>>> It seems to be named the same for other architectures as well,
>>> so it's wrong for all other arch too?
>>>
>>> My point is that:
>>> tb_gen_code(cpu, s.pc, s.flags2, s.flags, cflags);
>>>
>>> is error prone, and it's easy to swap flags and flags2 by mistake.
>>> I don't mind the name, but something more distinct would help.
>>
>> I fully intended to go on and pass in TCGTBCPUState, rather than 3 separate args.  I guess
>> I stopped early with the meson.build change for build twice.
> 
> You do have a point that it's still named "cs_base" within TranslationBlock.  I'll keep
> the cs_base name for now and rename it all at once at a later date.
>

Sounds good.

> 
> r~


