Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8696CC35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 14:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx5Ui-0001EK-5s; Tue, 25 Mar 2025 10:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx5Ug-0001Dv-SG
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 10:43:06 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx5Uf-0003fn-1m
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 10:43:06 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43d0782d787so40599165e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 07:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742913783; x=1743518583; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GgxoCHWoCXT4lrb2fzmXF3FtxxO58T7UqGjVftgAB2A=;
 b=cqRRP8rzgIprD+jfBTGc3L5uF4G7Z9XESni1lRuNCFdElRNYdVzzZK6UVa5Tu+KVm0
 tm7FyMyc8zYZhhSIG2MBccU/aEajD00tqQWkGJGP96tOu5enj6Svp406drWtemyKXeaA
 7bz9ATPfre34pkWbp4KN5v+ByEi8b8tE06j9m5SrQgt/dTMkEsXKa0cs8VnviFOuh/W/
 wOWduRSY021uDsLBX/jABz+FQlWdZ4XWQ4Gr76NsxjXFuPdkTAroAaD9GVpxv2tEraii
 4ahbXqoQdUntU/6TMoyMmuhGxl7buwSWe7Ay9y8v0Jipg9fCiK9qzdQdnLZ/tGX+A4B+
 O9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742913783; x=1743518583;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GgxoCHWoCXT4lrb2fzmXF3FtxxO58T7UqGjVftgAB2A=;
 b=VLDrvAKTltb1x0BZ5KHYvR05O/ZwjJX0F9m7R22geEWkLV4FtnYqp6nu1c5wEu+8Pj
 gprHpoYRCrFhmk6nWQ8jLDhRjzJcCQ4v+HF0B7wrhPfG9EUd3yE1Rop/t1Q5w5cQ6DaP
 OmN1sMSyptLDrMtmXy7xB8sRXTDSRmirnuNY0cG4H/npGfLYkaaBVNaDnEBareFCBX+r
 U6lOwMrl8/ebu8t+2P7l199GBTgOmbN6eyKw7JJ7vQUls5Dg7XikGPxUtTr5vBn9lb/v
 56+S1aIWMY8LVqNPaAcCJqWf8fhpQHxlxaYo7EjT9PGk8rmVW/HiTYesdjuSPaU7gweQ
 usjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKmvOiwbLGOCZMHffOvXG1pupbcSvh2jNycajaSaD/m9GPE/vMOzLGyPnAuv6E8tf5Ysig7frx0H5h@nongnu.org
X-Gm-Message-State: AOJu0YwHz3Fy13KpJu65H0NmxJwo7gPGVu5WITrMUHXEJROtxMYfL4o/
 KecBLYYVmAd83EhtKcN1dqBvakSRbLksoVd52a4fHyky/3TO6oQ6KxZIAXI452wOtm39GQLIQZt
 t
X-Gm-Gg: ASbGncsYNjO1v6xJwNNUXHe8h6WTMDA264nMUF8o6ZA68QAk0emyl/0VOCAqw9YdxdI
 IOa7VK0A1zCteSDR762OsqQnC3/4V1tpIaGfesZMDrsdkpETH/xWizI3g6VIX6g/aLmoKOit6ql
 vMWxtsGZoJaVkfDvE2HzZO/eJKWxLf5+6a33/bNhnu4wNjOLEDqbRmWfanrlgIDZ00tceW+tfe5
 gdSOMS1WIQAL83YSljV+1+qcSUj5JX15fsxl/VpzCrRiLozQIOrteNQWabO6qTdwvMymAz0fJo8
 0L6Hdvw5RHTdSupFIRqUIgk6AOTok7rtAyAeUOHRap/7haXcRzpfrVwHcNliWvZEHaRWRX/xMi9
 YLj/mxAqHrDun
X-Google-Smtp-Source: AGHT+IFr2W1PiFLa+PgxZXS3roncQib5al+afU6XgoW2Cd5B5VnGMRP46hbUEhK2utVAgxQgyHcQyw==
X-Received: by 2002:a05:600c:4e87:b0:43c:fe15:41c9 with SMTP id
 5b1f17b1804b1-43d509ec508mr148263025e9.9.1742913783479; 
 Tue, 25 Mar 2025 07:43:03 -0700 (PDT)
Received: from [192.168.69.175] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d7413cf10sm6751745e9.37.2025.03.25.07.43.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 07:43:02 -0700 (PDT)
Message-ID: <c18d5db7-916a-4de9-b90e-07b24a12d636@linaro.org>
Date: Tue, 25 Mar 2025 15:43:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 1/4] target/sparc: Expose more CPU features
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250325123927.74939-1-philmd@linaro.org>
 <20250325123927.74939-2-philmd@linaro.org>
 <2bfe3f4b-95d3-46a3-8236-75e7a8210a9f@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2bfe3f4b-95d3-46a3-8236-75e7a8210a9f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 25/3/25 15:11, Richard Henderson wrote:
> On 3/25/25 05:39, Philippe Mathieu-Daudé wrote:
>> Various features were not displayed or settable from command line.
>>
>> Diff of 'qemu-system-sparc -cpu help':
>>
>>   ...
>>     TI-SuperSparc-60     (IU 40000000 FPU 00000000 MMU 01000800 NWINS 8)
>>     TI-SuperSparc-61     (IU 44000000 FPU 00000000 MMU 01000000 NWINS 8)
>>     TI-SuperSparc-II     (IU 40000000 FPU 00000000 MMU 08000000 NWINS 8)
>>   - LEON2                (IU f2000000 FPU 00080000 MMU f2000000 NWINS 8)
>>   - LEON3                (IU f3000000 FPU 00080000 MMU f3000000 NWINS 8)
>>   + LEON2                (IU f2000000 FPU 00080000 MMU f2000000 NWINS 
>> 8) +shutdown
>>   + LEON3                (IU f3000000 FPU 00080000 MMU f3000000 NWINS 
>> 8) +shutdown +asr17 +cachectrl +powerdown +casa
>>    Default CPU feature flags (use '-' to remove): mul div fsmuld
>>   -Available CPU feature flags (use '+' to add): float128
>>   +Available CPU feature flags (use '+' to add): shutdown asr17 
>> cachectrl powerdown casa float128
>>    Numerical features (use '=' to set): iu_version fpu_version 
>> mmu_version nwindows
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/sparc/cpu.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
>> index 57161201173..37406227cb7 100644
>> --- a/target/sparc/cpu.c
>> +++ b/target/sparc/cpu.c
>> @@ -548,6 +548,11 @@ static const sparc_def_t sparc_defs[] = {
>>   /* This must match sparc_cpu_properties[]. */
>>   static const char * const feature_name[] = {
>>       [CPU_FEATURE_BIT_FLOAT128] = "float128",
>> +    [CPU_FEATURE_BIT_TA0_SHUTDOWN] = "shutdown",
>> +    [CPU_FEATURE_BIT_POWERDOWN] = "powerdown",
>> +    [CPU_FEATURE_BIT_CACHE_CTRL] = "cachectrl",
>> +    [CPU_FEATURE_BIT_ASR17] = "asr17",
>> +    [CPU_FEATURE_BIT_CASA] = "casa",
>>   #ifdef TARGET_SPARC64
>>       [CPU_FEATURE_BIT_CMT] = "cmt",
>>       [CPU_FEATURE_BIT_GL] = "gl",
> 
> I'm not convinced this is a good idea.
> 
> The only effect of disabling these is to break LEON kernels. These 
> features are not exposed for kernel discovery, so you can't just turn 
> them on and have them used on supersparc either.  They will certainly 
> break anything sparc64.

OK. It seems there is a lot of hidden knowledge behind this features
array :)

