Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B7BCCD183
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 16:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6WdU-0003SR-Iy; Wed, 08 Oct 2025 12:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6WdM-0003Pk-DP
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 12:03:21 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6Wcw-0002S4-U2
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 12:03:19 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-27edcbbe7bfso117726585ad.0
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 09:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759939368; x=1760544168; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rWAh6iT1BTM+JU8RITlgdOAdYNdcr/rIU/+63TMPvFQ=;
 b=teTZAkyi+bcBhst0s7dcRLM1vIjHM0R0YnEZwQCzz++M5y/ltg/FhtabqRk+2CA8RT
 zwjze8IxLYKZtblOHwRJyHSKCuJwVFesEwWlIhrQ1KzFBB67URCbQCp7EPENyC263TLw
 O+SA3z+HEMEhEY00vKusHzTgeoQGBXAApzAQhnaVDyXmo4kCFAR2S9fPdI3CRYDAiW84
 FfrKtHJ8ialBI8NJ2cBtPG3FpsSAb+etmP++tFq1ar75htAJgfXE+W40F2NRbmsgy74Q
 T4nG5QVpBJ8GDimirSleMc9qWZfhBxCXyFbl+nvu7GoZ28+HOyO6e0DKyf17wtEetE18
 VPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759939368; x=1760544168;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rWAh6iT1BTM+JU8RITlgdOAdYNdcr/rIU/+63TMPvFQ=;
 b=ngyThBGowvyTHouVzQ8aa7z4+amy6D2QQ4e7qy7EvnkYQA3l7PAo3afj/kISXlL9KN
 No2O7/3dP7J9qQO+LLVS5/H/94kmvKlkWZWOhudJfIF+ZYM/YF33fsaMVIccKqZW8vmq
 mlVUP9/elTP13/C6tPYKobQOE6ztz59H9fi7KCrPIjyqNG8CcdA+rjng34qy2RaqGsHX
 2Pk5BJIkc9McXAp3QMwYLIsW+ujrsB8ppePOfLkHl0OovWTKUIdoj/laXORoQhli5g7T
 UG6vB3sDkB2eoB11XPbn6Azslca2sHRKLz7LfJaGc14ACjJjYcGKjEPvXqqR+MWqCqDJ
 isQw==
X-Gm-Message-State: AOJu0Yyf/VIXDLMEx42EGYrFtnaCM0qbGVNyNflchaNxiZ9wPPF801+v
 PIGXVe9oxHeISDOMoAoRd5oLjYvKvAE4Dxka6Zna6lrmwtBVKIQmN9PeAkgr+BGAI9c=
X-Gm-Gg: ASbGncu6TxoQMYxT+AN2Vakhar/GskNe3Oj+rVtUcttnEg9kmWzsI/uweR6W4/01PBq
 pYbErKIbTpKoFeUjU+/OIKUtGC22Or7xfmkNia5aGsa07OhOp2hFveGACXjQvb0De/olnPeI8OZ
 fnNMSPe6DDcETxlOomP+1Zsg8ckuMr5ZwM3kQbblxk/EtpDwHyksxptXmIlWgEey843tURnBt4J
 2eZ/ZTK95VaTZuCGR6zcwcPYW3d5Jsf0UhRmYDUkI5wGGWi114FuVjM0MUMlrBqQ9qvM3UCDmOH
 zSwxcT2II07JaMrZ5zQ2WaK0pC4sH4w9NBQR4N+GvCUXeyKYPFcurSAQz95dfuRta3XnwNLHGVJ
 +uGHL7Za66dEbgBDHNQoVGTR87I5mnmCrYZPzj6Wu0AENet78ZOAZ5ze7N0dOdGTs
X-Google-Smtp-Source: AGHT+IE/siM2fhco5D7ldeSE1RxJvt+VpR+5LpSTmVAlH59RWa/Ge26apAT5zoB49N+YD7n9YKXYDw==
X-Received: by 2002:a17:902:e5c5:b0:264:f3ed:ee10 with SMTP id
 d9443c01a7336-290272157b5mr61995715ad.11.1759939367529; 
 Wed, 08 Oct 2025 09:02:47 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f05c2dsm1160045ad.73.2025.10.08.09.02.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Oct 2025 09:02:47 -0700 (PDT)
Message-ID: <7bf3d8c5-df07-4cbd-ba62-4c7246a5f96b@linaro.org>
Date: Wed, 8 Oct 2025 09:02:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] linux-user/hexagon: Fix sigcontext
To: Anton Johansson <anjo@rev.ng>, Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org,
 matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, =?UTF-8?Q?Alex_R=C3=B8nne_Petersen?=
 <alex@alexrp.com>, Laurent Vivier <laurent@vivier.eu>
References: <20251008014754.3565553-1-brian.cain@oss.qualcomm.com>
 <37cyiiwd6ktmjvfue7t6ifw727p4pdl52wfpbuyll7aqsocxk7@6wro7hlwb6mc>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <37cyiiwd6ktmjvfue7t6ifw727p4pdl52wfpbuyll7aqsocxk7@6wro7hlwb6mc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 10/8/25 08:27, Anton Johansson wrote:
> On 08/10/25, Brian Cain wrote:
>> In order to correspond with the kernel, we've now (1) moved the
>> preds[] to the right offset and combined the representation as a single
>> ulong "p3_0", (2), added the cs{0,1} registers, (3) added a pad for 48
>> words, (4) added the user regs structure to an 8-byte aligned
>> target_sigcontext structure.
>>
>> Co-authored-by: Alex Rønne Petersen <alex@alexrp.com>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   linux-user/hexagon/signal.c | 199 ++++++++++++++++++++----------------
>>   1 file changed, 111 insertions(+), 88 deletions(-)
>>
>> diff --git a/linux-user/hexagon/signal.c b/linux-user/hexagon/signal.c
>> index 492b51f155..6c3dbf91fa 100644
>> --- a/linux-user/hexagon/signal.c
>> +++ b/linux-user/hexagon/signal.c
>> @@ -23,7 +23,7 @@
>>   #include "signal-common.h"
>>   #include "linux-user/trace.h"
>>   
>> -struct target_sigcontext {
>> +struct target_user_regs_struct {
>>       target_ulong r0,  r1,  r2,  r3;
>>       target_ulong r4,  r5,  r6,  r7;
>>       target_ulong r8,  r9, r10, r11;
>> @@ -39,14 +39,21 @@ struct target_sigcontext {
>>       target_ulong m0;
>>       target_ulong m1;
>>       target_ulong usr;
>> +    target_ulong p3_0;
>>       target_ulong gp;
>>       target_ulong ugp;
>>       target_ulong pc;
>>       target_ulong cause;
>>       target_ulong badva;
>> -    target_ulong pred[NUM_PREGS];
>> +    target_ulong cs0;
>> +    target_ulong cs1;
>> +    target_ulong pad1;
>>   };
> 
> struct layout looks good assuming it must correspond to
> `arch/hexagon/include/uapi/asm/user.h`.  Add a `/* pad to 48 words */`
> comment to pad1, and static assert following the struct definition
> 
>    QEMU_BUILD_BUG_ON(sizeof(struct target_user_regs_struct) != 48*4);

As long as you're fixing things, all of these target_ulong should be abi_ulong, because 
user_regs_struct uses 'unsigned long'.


r~

