Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38101D1CDC6
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 15:40:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSzoi-00055E-FX; Tue, 09 Dec 2025 10:39:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vSzob-00053q-SI
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 10:39:50 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vSzoa-000764-7h
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 10:39:49 -0500
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7c75dd36b1bso4480995a34.2
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 07:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765294786; x=1765899586; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4iSgudwqXgs08W92kL1scBVgZ+jIqGebjnuAHk3IRVA=;
 b=bJf4UnCDj8dG1XCfNSS0Uwko3zFRItCdCbYVlqRdpvTcLQZ/OxSgb1v266Ogy3jTwB
 6G4cOBE3DBeO1NL1YpU0KAueKEuNmmiwDjF/SdoI0KmnLkObbEvtBhGGLMrIV5IaiRoW
 rlG4YH2HJXNY49wbY4AtVhBYZWNtz/Abjcygoheex5VL9dwlORKJ/wjiSDjQsa6OEXU6
 +lGgPF1mrz8WLAkW59lWoApKfHlmVQulc5EQtmL90X/zGSEf9GwUAOMhKODBSopkvIoi
 JYkQBDVdcotKqcs29jO8mj5ZzHi3nxn5eB0BEdQszP5ACwk4/flmtm+VuHIuqn8iglAf
 fo8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765294786; x=1765899586;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4iSgudwqXgs08W92kL1scBVgZ+jIqGebjnuAHk3IRVA=;
 b=A9jPqfperoKj9+9Q8G8pro+d97VOAuX4Ku0RU16aOmdoa4PvwtdxTNuW7JseAKzgj1
 /N4BaDuag2/rq31ExFFpncu201eL7zS75xt1q6ng+sXNaBeM2NafTfID9nb4kRkpzDeO
 2a1w15eSOiOQGTqVkkdWyiWOFCJTdW0zegG86wD8VXVaB8gaEVGmzroM3kVgZAiu1vu6
 rjkNfGORs6E7cZvOUlIW70Abiz1yzwr5MRpxeEILHk9FAMk7MIliSqPmN1g7NtPu25XO
 yQermJf+SbZoG6PMfGo64WGmzdEuGISvPYrAWoG8m23TIlZyNdc7WNzYtcM9K40APovK
 Iz4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGQnROd9iVFl/4nNj1fiI6BH3qSPiYAsmywGcOeAlPNGdO7Uktg7L8smtk3xSqwFHV5RWhzHnLVXHq@nongnu.org
X-Gm-Message-State: AOJu0YxHu0kCW3bdz5Bv0FOwGyerxSo7bryVWmSRijkF0l7m7UBbCxEq
 x02GJTdzf9cYWi15YZxCRrwe3a3tP0GAGXdkuJFUgJk8D42be3w9qpZQ5XXo49NxIDk=
X-Gm-Gg: ASbGncsA5a0kDUBpHU5dPrbOt66PGs5IqzobbNmlobJC4eBWeV20h5/Imm7j+a+Q4eW
 OLri9TbXInh2nYEfjCUGL7NfEoxcca5Mughe8KBlZBpLV3aBIAPuPebSw/Xip7kr27Ro5LXH/XD
 lZFaIETnJM7CTMgQokO9MjGlphfksm4TtLOyglvo7d5b6DqbY9CcSd8woa6ufAgJ/8QzZ37eA52
 c1Gp1OhM8yXRaRap2nJbEXDZPwJslsuky0Sc2sDU02ZqZOAX6lI7zm9oGHqU7H+nx6RVC/nzlsj
 BOXOS2SBp62LFUWUFZuiIU1RiSNvsO177OKsIhaVTA0kHEIdLXTMAt3koYdpG+7S0DmZBVBO/v0
 FF4+PduyoAvkVJcgXD8mq79V7Fc8uCRnMCtMJ5X6xGbIZgqjPtiH/PAV4ObRZ1hAidAB7XOWBSo
 xdbYjVNR607bAIUvvO66jDiZEQXMZal+VrV9Z7X+3TEKTMQM3wAi4EWKzfMqfNQHhW3dms60NQH
 RQ=
X-Google-Smtp-Source: AGHT+IHG6I2lGvXhcPdshjuTm1zXizGQouNQCq9yGAyrukx99p66KE7cIREg7Jnu2baOz1+RP4ZuJw==
X-Received: by 2002:a4a:e841:0:b0:659:9a49:907d with SMTP id
 006d021491bc7-6599a982eabmr5085720eaf.72.1765294786485; 
 Tue, 09 Dec 2025 07:39:46 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6597ef48d23sm7666579eaf.16.2025.12.09.07.39.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 07:39:46 -0800 (PST)
Message-ID: <b45b9b09-634b-4de5-b86b-28014c37f9c1@linaro.org>
Date: Tue, 9 Dec 2025 09:39:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] target/arm: Allow writes to FNG1, FNG0, A2
To: Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org
References: <20251204180617.1190660-1-jim.macarthur@linaro.org>
 <20251204180617.1190660-3-jim.macarthur@linaro.org>
 <59cb24e2-699e-4511-84e5-ad5d3ee90b58@linaro.org>
 <64beb7f0-5406-433a-9cca-f94c5f4164ff@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <64beb7f0-5406-433a-9cca-f94c5f4164ff@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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

On 12/9/25 09:04, Jim MacArthur wrote:
> On 12/5/25 15:30, Richard Henderson wrote:
>> On 12/4/25 12:04, Jim MacArthur wrote:
>>> @@ -6121,8 +6131,16 @@ static void tcr2_el2_write(CPUARMState *env, const ARMCPRegInfo 
>>> *ri,
>>>       if (cpu_isar_feature(aa64_mec, cpu)) {
>>>           valid_mask |= TCR2_AMEC0 | TCR2_AMEC1;
>>>       }
>>> +    if (cpu_isar_feature(aa64_asid2, cpu)) {
>>> +        valid_mask |= TCR2_FNG1 | TCR2_FNG0 | TCR2_A2;
>>> +        require_flush = true;
>>> +    }
>>>       value &= valid_mask;
>>>       raw_write(env, ri, value);
>>> +
>>> +    if (require_flush) {
>>> +        tlb_flush(CPU(cpu));
>>> +    }
>>
>> Just because A2 is valid doesn't mean the A2 bit changed.
>>
>> Compare, for instance, vmsa_ttbr_write, where we notice if the ASID has changed before 
>> performing the flush.
>>
>> Note as well that we don't need to flush all tlbs.  In tcr2_el1_write we know that we 
>> are only affecting the EL1&0 regime (alle1_tlbmask). In tcr2_el2_write, we know that we 
>> are only affecting the EL2&0 regime (see the E2H part of vae2_tlbmask).
>>
>>
>> r~
>>
> 
> Before I make a full patch series, can I check this looks correct?
> 
> In tcr2_el1_write:
> 
>      if (cpu_isar_feature(aa64_asid2, cpu)) {
>          uint64_t asid_nonglobal_flags = TCR2_FNG1 | TCR2_FNG0 | TCR2_A2;
>          valid_mask |= asid_nonglobal_flags;
>          require_flush = ((raw_read(env, ri) ^ value) & asid_nonglobal_flags) != 0;
>      }
>      value &= valid_mask;
>      raw_write(env, ri, value);
> 
>      if (require_flush) {
>          tlb_flush_by_mmuidx(CPU(cpu), alle1_tlbmask(env));
>      }
> 
> And then in tcr_el2_write, the same check but flushing by: ARMMMUIdxBit_E20_2 | 
> ARMMMUIdxBit_E20_2_PAN | ARMMMUIdxBit_E20_2_GCS | ARMMMUIdxBit_E20_0 | 
> ARMMMUIdxBit_E20_0_GCS, as used in vmsa_tcr_ttbr_el2_write. This could be factored out 
> into a constant function like alle1_tlbmask.

You don't actually need the require_flush boolean. You could just as well perform the 
flush immediately -- there's nothing about tlb_flush that requires the raw_write to happen 
first.

The FNG[01] bits don't affect ASID selection, so you don't need to flush when they change, 
only when the A2 bit changes.


r~

