Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA9AC44501
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 14:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjeYg-0006D8-1Y; Tue, 14 Jul 2026 10:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wjeYF-0006Bm-8B
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 10:56:04 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wjeYB-0000TC-FO
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 10:56:02 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-848643382fcso4963599b3a.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 07:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784040958; x=1784645758; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ThIpk0R/Ci9elKZrr6NOqcvpp/B+UnxtqFIuAhRTtSg=;
 b=lgCOfwr/djAZrWZ6wZ/7A+XYusRNcRLV6WsnvH5lnVmvUNYD5O+YbelexgzKfUpoib
 FHHaXdV1zA7Gt+l8i7kisUO7+RlF/fnX58w11BYwrzlqjMwU3H66JtmKRQ5nHQzyXFtx
 hU2VbAfTo/6LuGXCN0D7t/MGt/ZLCoXmpJzEzhmmrxSeVz/TYNn67rleq7gY4IJ+Rxrp
 ynndYKMJMCcUnxBkcCIXzNnzTH7n9CbCwgdKoqsLM4S5GPrpMdULQn2TbkDJT8HB7lIg
 UK3DFs0rAVvGtd35Xyxh30YiuxIBIZQYJ0e76JI0Mmv31If2IvolqWFUuYrFLJwCdYp9
 MQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784040958; x=1784645758;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ThIpk0R/Ci9elKZrr6NOqcvpp/B+UnxtqFIuAhRTtSg=;
 b=TstZWLdonWsjihz2l2F/RJ4WjHmncg+PPEw64UxnZZGpH6h4Hmi6UCxzqctnUOLy6Z
 9ljhgQ3PR5sxnJ5p9cOXvSdP0GK3tqyIDkRqr/m1Vr/tlm/JbBiBNoxC5Z+t0DRIm51z
 4thHepm0SsYvbD47gjtJj0iLu5srWVL1ugctaiT75hfdlJAAg/1JqZXiYXBu2c5Vt3De
 vkk+SmgTWrBuaYPf8shL+pEUOHbGkKaFBJTFtEh0rn5gBFj4ELeXk9zO03oSJXQLBVuT
 YIppF5OyNf6DoTg27g8qgQkop0Zj138mXJXD2JVINUvOcST1PcTIj94f182/R7FM1Byx
 VnbA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpIqT/eJhqg5AZOX0Np5yfttHJzseT2btz4/8MvopRBhs1mlLDFR9E8z7iX1gD/U8lkp+TXEiYyygBI@nongnu.org
X-Gm-Message-State: AOJu0YzOctE0eA1dE5tuMngBVRz72BqbmiEsN9bIP/GozM/h5d/TbiEg
 Shy2NdbSTXM9gMbfOKRrjFrmRRbKJL9BK6s2xSfDiWJo60cFMrtKcg1RFgx2yOMHAU0=
X-Gm-Gg: AfdE7cnwD1CVJjC4kJKN5QQvfNKaqLIiUjesv1wiGiLykis2ndKi6r4JMheUlfZ+ZjL
 DotWFCkDrBribqb6KHzMlHHHWQ5aZxRfTo9+goaZ2qtw1PfvwUuOW85/VDhhjIeOXCWwEJqvdqp
 munuO9LkF0M49f8MbLIc1Q2qVMCCtO0bxgedRSTxuX4f0ejm7jwxYxlKpjGnKBtQXX9j0+VEUNW
 lZfmpo9FE+EngN/x27zY0sexaflrwMnhlYitHKE16x9LJU8hCGIdAYzstzEyMJKoXoNChuZlkqT
 VlCarfuVasmJyu5Eu9It8ub5AwmXpJujYbDb723h8Xgc3/KrM9LUIuKt3VUAJr8CEa09aZ+y/ph
 Ucdg4RLfvzEOiPDRQU/hezLh2ildOcPGjEeIPJtAWdZiAng14ZeREteaHHLiCMjHykGyyerBAuN
 M6kVHbj8WYTnDR/aEXMyqa/1AwE8eImR872j/+NPesDEvf5Hg=
X-Received: by 2002:a05:6a00:3405:b0:847:8f8a:a05d with SMTP id
 d2e1a72fcca58-84a5146b46cmr3409035b3a.29.1784040957421; 
 Tue, 14 Jul 2026 07:55:57 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.146.49])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84a4f818ec4sm1670325b3a.57.2026.07.14.07.55.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 07:55:57 -0700 (PDT)
Message-ID: <01b9590c-2243-46f8-8f5a-de3ba0709ad8@linaro.org>
Date: Tue, 14 Jul 2026 07:55:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/51] cpu: Use interval-tree for CPUWatchpoint
To: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-19-richard.henderson@linaro.org>
 <9aed7950-405a-4414-a951-9d044a8c9d53@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <9aed7950-405a-4414-a951-9d044a8c9d53@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 7/14/26 06:02, Ilya Leoshkevich wrote:
> 
> 
> On 7/10/26 22:53, Richard Henderson wrote:
>> Use a balanced binary tree rather than a simple list for watchpoints.
>> Using an interval tree makes it easy to probe for any overlapping address.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/exec/breakpoint.h |   7 +-
>>   include/hw/core/cpu.h     |   3 +-
>>   accel/tcg/cpu-exec.c      |   8 +-
>>   accel/tcg/watchpoint.c    | 155 +++++++++++++++++++++-----------------
>>   hw/core/cpu-common.c      |   1 -
>>   system/watchpoint.c       |  43 ++++++-----
>>   target/arm/hyp_gdbstub.c  |   3 +-
>>   7 files changed, 119 insertions(+), 101 deletions(-)
>>
>> diff --git a/include/exec/breakpoint.h b/include/exec/breakpoint.h
>> index bb7cbc626d..e0826a1a2d 100644
>> --- a/include/exec/breakpoint.h
>> +++ b/include/exec/breakpoint.h
>> @@ -9,7 +9,6 @@
>>   #define EXEC_BREAKPOINT_H
>>   #include "qemu/interval-tree.h"
>> -#include "qemu/queue.h"
>>   #include "exec/vaddr.h"
>>   #include "exec/memattrs.h"
>> @@ -36,13 +35,11 @@ struct CPUBreakpoint {
>>   };
>>   struct CPUWatchpoint {
>> -    vaddr vaddr;
>> -    vaddr len;
>> +    IntervalTreeNode itree;
>>       vaddr hitaddr;
>>       MemTxAttrs hitattrs;
>> -    int flags; /* BP_* */
>> +    BreakpointFlags flags;
> 
> Should this go into 1/51?
> 
>>       unsigned id;
>> -    QTAILQ_ENTRY(CPUWatchpoint) entry;
>>   };
>>   int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, BreakpointFlags flags,
>> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
>> index b8a1419860..7e19ea418d 100644
>> --- a/include/hw/core/cpu.h
>> +++ b/include/hw/core/cpu.h
>> @@ -525,8 +525,7 @@ struct CPUState {
>>       /* ice debug support */
>>       IntervalTreeRoot breakpoints;
>> -
>> -    QTAILQ_HEAD(, CPUWatchpoint) watchpoints;
>> +    IntervalTreeRoot watchpoints;
>>       CPUWatchpoint *watchpoint_hit;
>>       void *opaque;
>> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
>> index 2762cf6705..ab299387e3 100644
>> --- a/accel/tcg/cpu-exec.c
>> +++ b/accel/tcg/cpu-exec.c
>> @@ -682,10 +682,12 @@ static inline bool cpu_handle_halt(CPUState *cpu)
>>   static inline void cpu_handle_debug_exception(CPUState *cpu)
>>   {
>>       const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
>> -    CPUWatchpoint *wp;
>> +    IntervalTreeNode *n;
>> -    if (!cpu->watchpoint_hit) {
> 
> Isn't it reasonable to continue checking for this, or can it never be
> NULL if we come here?

Intermediate steps.

Before this patch we walk the entire watchpoint list performing this same clearing in 
cpu_check_watchpoint.  With this patch, we no longer walk every element in 
cpu_check_watchpoint, but have not yet eliminated some manual checks for BP_WATCHPOINT_HIT 
in the target code.  By the end of the patch series, this loop is gone completely.

Helpful if I add a /* Will be cleaned up */ comment at this point in the series?


r~

