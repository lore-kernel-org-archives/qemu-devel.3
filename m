Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DA0C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 16:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tezdn-0001lB-FX; Mon, 03 Feb 2025 11:49:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tezdc-0001XW-2A
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 11:49:36 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tezdZ-0008QR-Ti
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 11:49:31 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21636268e43so103243575ad.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 08:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738601367; x=1739206167; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MHV6LG/OUMsFlunW558ipXYcurIxuHGfH2zyN5HhCWU=;
 b=PWqcdsm67tiaudCv64QzosJlh/eCokkyOQ3KQI5LBgxPCKSyXYbqYPLCF6NvQdP3y0
 9Gpfs7lsBQtUIwcEXfXnSkaOdRU3YGvS7lEpD3yqbnUgRFQtTrol3MDvB7WEBUv9hoOz
 2iD/11u/AyQuycz1ZfLZHlAZnXlvO2RdtvCqE4BJKzER0BrLjjFcRJUOHzC/wKMmR7TC
 zSTitgJch/wADH5gEZKculiSY4O+uwf+npTfxAhG3WyBF9CM9cO399KlO4m7hGYCZWca
 AEBPk5xGd2cDX+snM/j0tgToyuF/Ik2ARdagl2eSpFvwmi9kBRGBc3OX0AbB11ytyS+5
 A/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738601367; x=1739206167;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MHV6LG/OUMsFlunW558ipXYcurIxuHGfH2zyN5HhCWU=;
 b=LaQZ+1A9ovjhHfsJY36Dlh9c4Ln7WgjcoBtmhjRvNbObz+cX46DNEGVX/M5psQ5I/B
 jSddej8rYUaizx+TajBee8WSvE90zoW2xgC+WeAwevCvDoJwpOvL811c0EPm8L6R8EH5
 9UmuHfWFvyUBwNUceyhQJImfrQlLfGaX40ms4k9R2MSMTArSI8xK72yGsDoWv3iW9LSv
 FuSge/klGOSWJST23QPYcuNZuvaPHdPsL9qNeeq4KFGQpcrFKD8/zpE72X1N9MjtMXby
 e/oxhz00Y8FYEf1M886+hPN17QxeSJ6xftVYhEIc7/PCTRiHQ6juljBj1l+8hEalAQyh
 YxXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmFXM8L+PGY08PAOTYW3kk4+SX0NiSd/x7M7iSbEo5r8a6OnP2zYeRLgmaf5hGbcaBzcO9F+ne8Lvo@nongnu.org
X-Gm-Message-State: AOJu0YxG+tIy25ptxxcTBp4qo3Cio8gbNhGKJL1847bvClMNrHv6ELqK
 eFsqvOFEDzYgLUewVKcqfg/SzDGDcAOJrrCAQvk7rSvzbA+68BNWZ4AmiAydFxc=
X-Gm-Gg: ASbGncsvSqaB9/vdHVlZRX4Zm0P0rbC/1M3NFZzYUzP8Ku0VtIm9aLTUPPU578YAVhJ
 jIX57FrIYD85ervV/kdsB1aNxmEI8f+a0M80DYpVTmWjKqBMs1+iPZEuJIf6uO5nKzh7r7r7nPo
 PT8Skf4z6AMSHXhrRwQjwnArCaZB/b/Y4sOmZHZI4p1E8xVWP/De6nIrB86qXcxvPsrG7fEtK6T
 o5McMVLIucYVaj22UC+neDQ6RrWuxTdm7hSZc6dB/Q8rZQgG0SDI3lmJbMTbApiGaaD1S36bSZH
 HZMOWVql3JOyosgwRYv9lG79C8pDrA3ItxpzIBxeYJ4ggz3+quCVnqU=
X-Google-Smtp-Source: AGHT+IFZLtbnFqon72r7F8YZQANlP8H/sF7FtzlEgkrZPmoyJH0o6hVXZO7x1aRCDIdb3mI1/RE1Xg==
X-Received: by 2002:a17:903:24d:b0:21d:cd0c:a1ac with SMTP id
 d9443c01a7336-21dd7c624e0mr348492845ad.17.1738601366594; 
 Mon, 03 Feb 2025 08:49:26 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21de32ea80csm79483455ad.140.2025.02.03.08.49.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 08:49:26 -0800 (PST)
Message-ID: <54d4e11f-75ea-42d7-9d53-0c7d4eb4b239@linaro.org>
Date: Mon, 3 Feb 2025 08:49:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/14] configure: Define TARGET_LONG_BITS in
 configs/targets/*.mak
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <20250203031821.741477-11-richard.henderson@linaro.org>
 <47d703f2-bee2-4ee1-af13-624f6f0e7ee1@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <47d703f2-bee2-4ee1-af13-624f6f0e7ee1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 2/3/25 02:39, Thomas Huth wrote:
> [...]> diff --git a/configs/targets/hppa-linux-user.mak b/configs/targets/hppa-linux-user.mak
>> index 8e0a80492f..4295cf384e 100644
>> --- a/configs/targets/hppa-linux-user.mak
>> +++ b/configs/targets/hppa-linux-user.mak
>> @@ -3,3 +3,5 @@ TARGET_ABI32=y
>>   TARGET_SYSTBL_ABI=common,32
>>   TARGET_SYSTBL=syscall.tbl
>>   TARGET_BIG_ENDIAN=y
>> +# Compromise to ease maintainence vs system mode
> 
> s/maintainence/maintenance/

Oops.

> 
>> diff --git a/configs/targets/mipsn32-linux-user.mak b/configs/targets/mipsn32-linux- 
>> user.mak
>> index 206095da64..39ae214633 100644
>> --- a/configs/targets/mipsn32-linux-user.mak
>> +++ b/configs/targets/mipsn32-linux-user.mak
>> @@ -5,3 +5,4 @@ TARGET_BASE_ARCH=mips
>>   TARGET_SYSTBL_ABI=n32
>>   TARGET_SYSTBL=syscall_n32.tbl
>>   TARGET_BIG_ENDIAN=y
>> +TARGET_LONG_BITS=64
> 
> Why is this 64 ?
> 
>> diff --git a/configs/targets/mipsn32el-linux-user.mak b/configs/targets/mipsn32el-linux- 
>> user.mak
>> index ca2a3ed753..d9b61d6990 100644
>> --- a/configs/targets/mipsn32el-linux-user.mak
>> +++ b/configs/targets/mipsn32el-linux-user.mak
>> @@ -4,3 +4,4 @@ TARGET_ABI32=y
>>   TARGET_BASE_ARCH=mips
>>   TARGET_SYSTBL_ABI=n32
>>   TARGET_SYSTBL=syscall_n32.tbl
>> +TARGET_LONG_BITS=64
> 
> dito?
> 
>> diff --git a/configs/targets/sparc32plus-linux-user.mak b/configs/targets/sparc32plus- 
>> linux-user.mak
>> index 6cc8fa516b..7a16934fd1 100644
>> --- a/configs/targets/sparc32plus-linux-user.mak
>> +++ b/configs/targets/sparc32plus-linux-user.mak
>> @@ -5,3 +5,4 @@ TARGET_ABI_DIR=sparc
>>   TARGET_SYSTBL_ABI=common,32
>>   TARGET_SYSTBL=syscall.tbl
>>   TARGET_BIG_ENDIAN=y
>> +TARGET_LONG_BITS=64
> 
> Same question here: Why 64? If this isn't a mistake, could you maybe add a comment?

All three are 64-bit cpus using an ABI with 32-bit pointers.


r~

