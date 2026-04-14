Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706AAF531DC
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCRvM-0006d2-PM; Mon, 13 Apr 2026 20:46:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRvL-0006cs-LN
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:46:39 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRvK-0007EG-99
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:46:39 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-483487335c2so54818365e9.2
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776127596; x=1776732396; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HhWT+KTJmFWL3YfVm8UGn0lt9F9fnqn78XxEtKESSnY=;
 b=JWKNPjEd0fv84Iv2wwwSDPCnZOFS8Hk9wFH1z9m6O+zTHmRXisDF9tigawx+wziU2W
 ntXcvGH1EI8tAyVY50BfrooXN1ufvTf049hP6Jl0wYKVECrIIAce5PgWJ/sL8JHb9AUy
 s3S2SHFK3IeDC3pcx3wIquxutQOZjD1RpZcucdep4TE3vf3XCT2O5TPcEGWcUoAtWth+
 FA9PvOtNth05VIa1RCAct7y4DAwljtLKHU5GMsljMatjKzeFtopalYS9Uyn/E0pYPToV
 HcrEnOR59an42xn9xG0cy4c2ZOj0lbGA5Dl9cpZyZ1t7Y086s+FqmfTlzd1ZqPzRQona
 gcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776127596; x=1776732396;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HhWT+KTJmFWL3YfVm8UGn0lt9F9fnqn78XxEtKESSnY=;
 b=jpADx3aJCwjZ3FBZjUSKiEW35g2GzF6yFtf5gywBktg+x83HJd4hZbX0CyO3yM4D+w
 tUA2+6sv9QwOvZvoUlb6cpQl/t58XBe2+EO8gIO6ub0cEbU0023+FFvuQSkSIG0EzQ7j
 Tf4eXKxqYNmvtBnBP6DNuA++6ACj83Rk9gWFYljY10y6mCO05jwGIjnmPm2TTBCruOvT
 13FmaLAClgLiDLN1ExL/WGAEswXhXZtEdheitcMri43Lrfwmw+uxn43ech8y6HaP8aH4
 WiK9I6QnTMgMRKpL8dbuyfWi+yVV28xpcarVU4G9CrSHOVOJoktjvyrL/lA1gw/2aVq+
 zYbQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+xFXzcSF5K7GFJ6KhUat2WcISbxEAZARp8qbYi8yYlArZcZksgC5EvcKmaA08irKoigfnaYpSWnQuv@nongnu.org
X-Gm-Message-State: AOJu0YwGADEvrx7WdhwEwrxxTkArFDvj1rjePcJS7AgbWvJO/ALeKX7M
 Ktqy7clQsA0zAh3tFXol+aI8T32R8/YUTrEMRNm2KdYISj62H+ZZRJI/c1OtGPO9dIE=
X-Gm-Gg: AeBDiesVYluBZCQG/lKDaoBStY5DL0iQfksNwjD3ae4XHdHADb0i6Hlrs14iCuhNfXr
 CUDVusfDRwlPHA3YGZVHnIzIwCgGKKKTj0D/pELYCdVfJGoYdWTQi7j1OB+JLkkFnw6CTiwzLup
 qrKrP3RjzGGaZMfMQIjfULiwOx6SqswduJUWTXpsg20ykwEjgUImg5tmP2qRnxEX0ARGiuym08o
 gZ5GttRkFIm4ka9wVXEEhUQySWaa5wSVJ207rEMPBk3ClFlGM1yzdyqh7P91hBxTFbZgrmQUWwS
 DGakBG7XHAuaCGC7bmCFxZBQvf5sVSBABZi4iyQCRTo6CpDpQ/va+PI8CYYIRQYBe2IAPKOcrGp
 CPxp0fp4SncKpFOaSxJgOE8q27eqJcrd7RDRaZ1WwlMwzbQvxs9tHcKrvrCbSaS/nNDc2t+25Ow
 +ruPY9fWuphyxz4DiqnxixnKSsLHt/ncY+LAwYGcq3tBIYlRqi9NkVLVls2SV1g18/ug==
X-Received: by 2002:a05:6000:1447:b0:43c:fdd9:1890 with SMTP id
 ffacd0b85a97d-43d642c999dmr21355173f8f.51.1776127596437; 
 Mon, 13 Apr 2026 17:46:36 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d7bc5f70fsm8932671f8f.3.2026.04.13.17.46.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 17:46:34 -0700 (PDT)
Message-ID: <e15646a5-2207-455b-9aec-cdd8ce72a119@linaro.org>
Date: Tue, 14 Apr 2026 02:46:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/9] target/arm: Introduce mo_endian() helper
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260410200628.19378-1-philmd@linaro.org>
 <20260410200628.19378-6-philmd@linaro.org>
 <0c1cbc35-acc2-4ead-a8cd-419cf952a750@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <0c1cbc35-acc2-4ead-a8cd-419cf952a750@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 14/4/26 01:47, Richard Henderson wrote:
> On 4/11/26 06:06, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/arm/internals.h      | 3 +++
>>   target/arm/helper.c         | 8 ++++++++
>>   target/arm/tcg/mve_helper.c | 3 ++-
>>   3 files changed, 13 insertions(+), 1 deletion(-)


>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index 7389f2988c4..037d2bcf376 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -38,6 +38,14 @@
>>   static void switch_mode(CPUARMState *env, int mode);
>> +MemOp mo_endian(CPUARMState *env)
>> +{
>> +    if (!is_a64(env) && arm_cpu_data_is_big_endian_a32(env, 
>> arm_sctlr_b(env))) {
>> +        return MO_BE;
>> +    }
>> +    return MO_LE;
>> +}
> 
> For use within tcg, which this is,
> 
>    EX_TBFLAG_ANY(env->hflags, BE_DATA)
> 
> would be better.

Ah, I know somthing ougth to be better, thanks :)

