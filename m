Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7152C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 16:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiawB-0003vf-25; Sat, 11 Jul 2026 12:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiaw9-0003uv-In
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 12:52:21 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiaw8-0005Dw-2o
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 12:52:21 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3811e59df58so1241202a91.1
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2026 09:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783788738; x=1784393538; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nefIjTWKSN7IYNh5mubqdUhbFGrCxOtboRLZ3Plmug4=;
 b=POAhqcC8LB4+RsivEmssD2nuLbWXmAuGUhcU5pHyyTfYT00XCWuyO7gmW6K8V7lCWM
 lLipKP9FWgSWet8D80juoRbKIE4che5hQuKymRo81nc/zCYIolKvM+L+8zP+zeq52xLu
 KYBgggQ44BdMs13PKIpet0HX2RVLruDZIzVDeXmtl8ezRyReFrbsAc/5QCD358YexvsT
 PyXE5p+FtoR1CsPuCvotlWKMGf1GWv1MXQ6fqGnRA9+nz9iHwPuerugs4oxf/z53rXHG
 UXDHvkKRaehbG+ArlkJovo5PoYYpLVz3tHijYOwnxKwPYcIHiqj8xCEPC5bP9Z4d90vx
 ExIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783788738; x=1784393538;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nefIjTWKSN7IYNh5mubqdUhbFGrCxOtboRLZ3Plmug4=;
 b=AWh2AyEVDS55g4K71TN+KnRwQsU9vdRnHxh18FwQroYlWnCKiPxFNxt6moFIUBIk16
 WPV4mW4wadWSBwQG0PXxewfimWwBr9fVKTyUvKwUZOGrlEJz6HoaE5cZlN/aCfzYz8bY
 Sldwt7Uv8PWiSf39SH8Zn2nZRpbDSNE6DbGtGjWn1ZJFhb3kSGTFk7I8tx/cwVcDJmk6
 ip4wbxayjpdND/zq0S1Y40c4z4/3T82KrbkW9j7nGzOhG+Z05mOcKqcfFtwjsgd3t9YJ
 r39Ch1ympfsApammIi5TZHJBF9qD9JnYA+FikwLFNnvOQf9U9N8tJoGp7RdbwPkDlTXf
 B7SA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq7NxN3h4NBGHLchFMBVQVYweY9oAgBEbGz7dbW6Zl1pQNzkNmbM0qxXsmPJxumcCrbwPmuV5nwzKur@nongnu.org
X-Gm-Message-State: AOJu0Yzr9h4fo1rx0ZzIm/loP4dlvOGvm5ExOiGgGaDLZcDdvPeU6LKZ
 Li5XQR4TyOCtbCHt0slos+VqN2JG7rLMoSUh+jIosQGRD4OvXuRWEI8y6EnksuymQVo=
X-Gm-Gg: AfdE7cnjAa+fLaCla5KWAF5IbSrADWR5U/5jrfj+OLjUv6wIP5PjHGG9sqBkpJaCfgZ
 Gh0OZ94gbO1AFNqEugYVAZlRY6dI+3LP2KPilhdqyp5IWctsrH1BvoIHxd5SQQX70I8IbwONaKI
 QT7fBLGOSSiDYKa8QYyQeA9j1wasgMgEM9z1PiSr8LlcWH1Uee5FEP3vupbPaW2BH2dF/J1InmY
 FXt1b/owqR58JGakcPwNBV0/1y411obzX7ohSyoweq2kp5q7XvqkLn3ZESPnC00Sq9kxegwCqc9
 ZT0I4XvDrZdD5ZK7wCqsDfZe1ZebLIduwDQfjB57bla2fWBzFCxLENBq49oCHBtbT7MVvj261kE
 XMPo7kBuccFpADaKg2krXdgjKJSp7zruYtQ1LHUAaWRYI6OgBXU64QORJez0xjXCUwPp7tI9uON
 x8+WnnssuvtdJ/AIvJkGVt0LoxpA==
X-Received: by 2002:a17:90b:1c91:b0:380:534f:58c2 with SMTP id
 98e67ed59e1d1-38dc7b81c27mr3067888a91.30.1783788738173; 
 Sat, 11 Jul 2026 09:52:18 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.146.49])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38a583a16c2sm4194226a91.13.2026.07.11.09.52.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Jul 2026 09:52:17 -0700 (PDT)
Message-ID: <8e9907db-68b6-4644-9c16-6fbbbcd52b0b@linaro.org>
Date: Sat, 11 Jul 2026 09:52:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 33/51] target/ppc: Simplify
 ppc_cpu_debug_check_watchpoint
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-34-richard.henderson@linaro.org>
 <bf1b73da-919c-4b02-8b46-78b939077610@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <bf1b73da-919c-4b02-8b46-78b939077610@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 7/11/26 03:54, Harsh Prateek Bora wrote:
> + Cedric, Shiva
> 
> On 11/07/26 2:23 am, Richard Henderson wrote:
>> We don't need to check either ISA bit, because that's already
>> done starting with SPR registration.  Replace target_ulong with
>> uint64_t, as we're under TARGET_PPC64.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/ppc/tcg-excp_helper.c | 30 +++++++++---------------------
>>   1 file changed, 9 insertions(+), 21 deletions(-)
>>
>> diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
>> index 99ffe4a820..4065440949 100644
>> --- a/target/ppc/tcg-excp_helper.c
>> +++ b/target/ppc/tcg-excp_helper.c
>> @@ -353,35 +353,23 @@ bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUBreakpoint *wp)
>>   {
>>   #if defined(TARGET_PPC64)
>>       CPUPPCState *env = cpu_env(cs);
>> -    bool wt, wti, hv, sv, pr;
>> -    uint32_t dawrx;
>> +    uint32_t dawrx = env->spr[wp->id ? SPR_DAWRX1 : SPR_DAWRX0];
>> +    bool wt = extract32(dawrx, PPC_BIT_NR(59), 1);
>> +    bool wti = extract32(dawrx, PPC_BIT_NR(60), 1);
>> +    bool hv = extract32(dawrx, PPC_BIT_NR(61), 1);
>> +    bool sv = extract32(dawrx, PPC_BIT_NR(62), 1);
>> +    bool pr = extract32(dawrx, PPC_BIT_NR(62), 1);
>> -    if ((env->insns_flags2 & PPC2_ISA207S) &&
>> -        (wp == env->dawr_watchpoint[0])) {
>> -        dawrx = env->spr[SPR_DAWRX0];
>> -    } else if ((env->insns_flags2 & PPC2_ISA310) &&
>> -               (wp == env->dawr_watchpoint[1])) {
>> -        dawrx = env->spr[SPR_DAWRX1];
>> -    } else {
> 
> Previously, there were different ISA version checks resulting in different behaviour, now 
> with this change we are allowing for both ISA versions. Not sure if this would be an 
> expected behaviour?

Per the commit comment, the ISA version checks are done when registering the system 
register.  One cannot write to DAWRX1 unless ISA310, and therefore dawr_watchpoint[1] will 
not be set nor wp->id be 1.


r~

