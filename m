Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE17DC83F21
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 13:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubfsh-0007My-9w; Tue, 15 Jul 2025 09:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubfMs-0008QX-RQ
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 09:06:47 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubfMo-0003Th-Tf
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 09:06:46 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45610582d07so18825805e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 06:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752584800; x=1753189600; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RT3q6+aCUO9Nik1c2NVnXBCkKK56bsil88LDSh+ktX0=;
 b=pZzSpJmTR53720Cf9VMCrWtfbBMsPSkH0VRbg6501YtZPWQpRTWR6h7ZmLvIqa9wTK
 QVwc4ioaGo0nouTcUn7IP1RD6aGuXC0u8uhm2965K1GrztQuaqUI3MTy8m09/9FvMHxQ
 DsUDDAoeKk51mVcC52N/5pleUEWXfQEzCaI2pl8c6vyCJ7ADO6Z1nQ35aWMe5QsrbKb9
 xMtNtgqfw0pdNHa03PtUBOXfWN/PhiAoiCnDLRxcaJMmSVygD3PushuK0QzGocrwfL5p
 YSFZBYjMVJUaFB0oVNX2QvZXoAZyfE+gd+j3tvMBTCLROr42kAwyhdYr2A87HXY4KXlc
 Ft0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752584800; x=1753189600;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RT3q6+aCUO9Nik1c2NVnXBCkKK56bsil88LDSh+ktX0=;
 b=MdQWmqAAew4xPUsz6s0ihgbmvAL9NmysX45P9Dx5E+fmj6IQBQCYZ6sGv1Uv4a0x/O
 4LF+9pcDuD5JIUi+asWK9V9uneF5011q/2IUK+tdnlSDKjM29rkogI035rnMYxLmCaxn
 AltgSAByrKH2HQG4DrZVAAjb+ecZ1SkUWCUr11QfbGOb+anHkamtLEhn0b3UyeJa5Hda
 WxZ1csZFwKv6uDH8T+bNTWzV/fP/8FNMYuEI6qTNkMq+mhi6yzTyakEenEa4R+LS7IoD
 4A4gdYn1QWVxAlwSiuJRVEDkl2cAODvUBccPK2sj+houzok3TBIOTzTZyhpax0ZjCyG0
 MuHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIJFBC8vmwnrOztP44kmT8QMHiIwvq5E0iwdDKYXaLtUS7zP757ylyJ8m/8iXjZJKQMn0D4WULcZXJ@nongnu.org
X-Gm-Message-State: AOJu0YxTifuCaxjJmbQ4F8vDbr3Tpqg8KWvopd/8zxbefI2hA+q8W81e
 VRVSkOMXXkO5I242ZCFNSWQPWZZVoxKeKe6rbanfLjTf67TOz7r6hGV0TYMsN11lpy4=
X-Gm-Gg: ASbGncv0dCOCaOdpl30icTL244uUygsseECdpyFveEK61E19P3YcmOh4fS+smxGf/K/
 fR5bIkbX/YwCij5i/oRUh6NJLKKpKzY3Ai9vppNRftjgUevU3JhwN45bZyE0vQl/LHrkKXCeuOH
 qm0dgbyBZpjFUegS7077YsSYn+dv7HaYnU1Te2dQikv+yXJCZvRy2uRHxgWUZbguupC7qUmx7a2
 E2NSlToLTfc0muaqULgpXrDxRes0nSFahrsbIpojLET07WUDvi2xEh1DVYCbX1Q8lyPFI4UffUZ
 Sc675GLR3Ld6W4HNfjNI5ZwcAeJKWJJ1c20seFeDurBQlsL+SGlr1AhpFMdoHFqOLO/arJdjXCc
 eaEbaAg70AvV0XuO2JZW/pfMFm+7R4S7szqnvL2jHNw2knoGc3IHGj1FtnmqnmljyuxP6WmqcpQ
 8/gm74MA==
X-Google-Smtp-Source: AGHT+IFgozBuWBo8EncpJrvTbu4jMOwsbvbNOujmRigXXOAuMPSj2HUhbdVS4j47NjzfCdEi7s0YVA==
X-Received: by 2002:a05:600d:10d:b0:455:e858:cd04 with SMTP id
 5b1f17b1804b1-455e858cfe6mr89726975e9.25.1752584799398; 
 Tue, 15 Jul 2025 06:06:39 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45624651a09sm30659515e9.12.2025.07.15.06.06.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 06:06:38 -0700 (PDT)
Message-ID: <9e199d53-9b7e-400a-9172-9986602cf6a7@linaro.org>
Date: Tue, 15 Jul 2025 15:06:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v5 6/7] accel/tcg: Implement get_[vcpu]_stats()
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eric Blake <eblake@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Mads Ynddal <mads@ynddal.dk>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>
References: <20250715104015.72663-1-philmd@linaro.org>
 <20250715104015.72663-7-philmd@linaro.org>
 <c741d3b1-6a6a-4702-a33b-2d5c7c2e3598@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c741d3b1-6a6a-4702-a33b-2d5c7c2e3598@linaro.org>
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

On 15/7/25 14:48, Richard Henderson wrote:
> On 7/15/25 04:40, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   accel/tcg/tcg-all.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
> 
> Oh, this is what causes tcg-stats to be used by user-only binaries, is it?

Indeed, otherwise we'd have to use #ifdef'ry or stubs; and there is
no good reason to not dump TCG stats on user emulation (except indeed
this code path is currently unreachable there).

> 
>>
>> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
>> index eaeb465dfd5..fc3f28e3532 100644
>> --- a/accel/tcg/tcg-all.c
>> +++ b/accel/tcg/tcg-all.c
>> @@ -236,6 +236,11 @@ static int 
>> tcg_gdbstub_supported_sstep_flags(AccelState *as)
>>       }
>>   }
>> +static void tcg_get_stats(AccelState *as, GString *buf)
>> +{
>> +    tcg_dump_stats(as, buf);
>> +}
> 
> Is this shim preparatory for something else?

No, I didn't realize during rebase this can be simplified.

> Otherwise...
> 
>> +
>>   static void tcg_accel_class_init(ObjectClass *oc, const void *data)
>>   {
>>       AccelClass *ac = ACCEL_CLASS(oc);
>> @@ -243,6 +248,7 @@ static void tcg_accel_class_init(ObjectClass *oc, 
>> const void *data)
>>       ac->init_machine = tcg_init_machine;
>>       ac->cpu_common_realize = tcg_exec_realizefn;
>>       ac->cpu_common_unrealize = tcg_exec_unrealizefn;
>> +    ac->get_stats = tcg_get_stats;
> 
> ... assign tcg_dump_stats directly?
> 
> 
> r~
> 
>>       ac->allowed = &tcg_allowed;
>>       ac->gdbstub_supported_sstep_flags = 
>> tcg_gdbstub_supported_sstep_flags;
> 


