Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100A7C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 21:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rz0oZ-00063z-62; Mon, 22 Apr 2024 17:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rz0oX-00063D-FD
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 17:03:01 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rz0oU-0005VZ-8Y
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 17:03:01 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-417e327773cso32618755e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 14:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713819776; x=1714424576; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6ak5XeA0640VgfQxYSkPrN8QnihldUnPedgpmsGPrtQ=;
 b=Nj6mQ0Q60gt5k7S9CZrZiPvgbrIF0T4d87bkcOYiXR+qrRr6ph2DlX+JNxb5ml6Emm
 6uVUCmEGB2MNT0Tx50GGbMNkLVhDSFsuFnmaB225kcHzY00D4JIntAKEJLJNJvsnKIzn
 nBTX/DErfYTHY9qbpkSypivcoPQrX/LG92UpuzWmql/qtzp187jRtk3tSC/YGrgUNCst
 Bvu0hnTqU9K2iUeSS28CCkuu1vK748qIzC/pTWqtoMO5QFu60jO3tfaDHSuMCKVAO/Qv
 b8YgUFqw7aMadTwfd373nkMIydNyG0xMYAmWzBJUvTgrOsRutstOv0gMjQ8FHqgiuzqx
 qAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713819776; x=1714424576;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6ak5XeA0640VgfQxYSkPrN8QnihldUnPedgpmsGPrtQ=;
 b=Lvmocw1WI1F/66e3BtmiklOZ4+rzgoJfHV02aIuRIExHFaY7O4xtq1jBCdKqrkctur
 OoNicsxincapk7qgC6yektJ4OY1BbeLtD+iTjXnRfMplu2JbZDMC1pWci2rS2G5cSHhK
 KQPPbXIggisKKESPfGlbMVBNWbxf20RqlKT1j0jwDqKN47PU2u7KoqmOzsUVyEJdVdfP
 gxY20Di62syWbLfpUjd8/L0S/I8yrLnZ8EsDAADZMPsSMf4dyiu/KnnYlUBYXKZc63iU
 wGhRsZNmSRUp9sHRmKmSk97Jg/6TbutFRMxr2vhDLPIH3tZRrOKRqE3rlCxnQOqc6S3S
 DWnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/lKJ+be0NrOJ4/WV/zGhaTDNcaYVHcZie7cEnZ1wni/VOy+3mrCOrJUIT/WlKbpR+cRC/6gM1zc6McnqDurn5uyDRkbg=
X-Gm-Message-State: AOJu0YyrAocK+/ihBOB41PfkrBCgtckTlTv0PIWzdLBL5+hnDagroqKJ
 b+mKZr7T3Sk2mP8BTeljcMSuptgl4w+gSMYxAW3lU8ruFgHbnuGy5ypTBCxtmuw=
X-Google-Smtp-Source: AGHT+IGXjXy54Rin9Ce9eOXqGzpK59o+WHoAhpU3ZzgqfzbYXj+n8tAsx8eQE45r0k4JkX5dzX89KA==
X-Received: by 2002:a05:600c:3549:b0:418:9bd6:be2c with SMTP id
 i9-20020a05600c354900b004189bd6be2cmr529007wmq.2.1713819776096; 
 Mon, 22 Apr 2024 14:02:56 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 z9-20020a05600c0a0900b0041668162b45sm21361643wmp.26.2024.04.22.14.02.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Apr 2024 14:02:55 -0700 (PDT)
Message-ID: <98baa946-494c-4907-9a1a-5333482b5193@linaro.org>
Date: Mon, 22 Apr 2024 23:02:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Restrict translation disabled alignment check
 to VMSA
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?Q?Cl=C3=A9ment_Chigot?=
 <chigot@adacore.com>, qemu-stable@nongnu.org
References: <20240422170722.117409-1-richard.henderson@linaro.org>
 <ea575a44-9ce6-4da0-ac62-f283c436c540@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ea575a44-9ce6-4da0-ac62-f283c436c540@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 22/4/24 19:09, Richard Henderson wrote:
> On 4/22/24 10:07, Richard Henderson wrote:
>> For cpus using PMSA, when the MPU is disabled, the default memory
>> type is Normal, Non-cachable.
>>
>> Fixes: 59754f85ed3 ("target/arm: Do memory type alignment check when 
>> translation disabled")
>> Reported-by: Clément Chigot <chigot@adacore.com>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>
>> Since v9 will likely be tagged tomorrow without this fixed,
>> Cc: qemu-stable@nongnu.org
>>
>> ---
>>   target/arm/tcg/hflags.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
>> index 5da1b0fc1d..66de30b828 100644
>> --- a/target/arm/tcg/hflags.c
>> +++ b/target/arm/tcg/hflags.c
>> @@ -38,8 +38,16 @@ static bool aprofile_require_alignment(CPUARMState 
>> *env, int el, uint64_t sctlr)
>>       }
>>       /*
>> -     * If translation is disabled, then the default memory type is
>> -     * Device(-nGnRnE) instead of Normal, which requires that alignment
>> +     * With PMSA, when the MPU is disabled, all memory types in the
>> +     * default map is Normal.
>> +     */
>> +    if (arm_feature(env, ARM_FEATURE_PMSA)) {
>> +        return false;
>> +    }
>> +
>> +    /*
>> +     * With VMSA, if translation is disabled, then the default memory 
>> type
>> +     * is Device(-nGnRnE) instead of Normal, which requires that 
>> alignment
>>        * be enforced.  Since this affects all ram, it is most efficient
>>        * to handle this during translation.
>>        */
> 
> Oh, I meant to add: since the armv7 manual has both VMSA and PMSA 
> sections, and the language about default Device type and alignment 
> traps, is in the VMSA section.

To the best of my knowledge,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


