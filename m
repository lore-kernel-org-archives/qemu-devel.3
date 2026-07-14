Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6005C44508
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 14:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjeOx-0002gi-QD; Tue, 14 Jul 2026 10:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wjeOp-0002eg-OW
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 10:46:19 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wjeOl-0007cH-LO
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 10:46:19 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2cc7ef7ec27so49464225ad.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 07:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784040373; x=1784645173; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pEuwMejFowMdCWNPLFyEu643LtN1cXWGJNAAG/USFAQ=;
 b=IqSsibt16KVed41yGtVKxAGb1XYhHGDCXe7nKaHierpqLoRcOWMN1Gsdok7Axa6BXH
 FKTALV9W1K6iT6HQU5QyMiNzlsIjtOKLL/nyCu2DY6z/giR1dc1v8TPZ5Zjsy8kjybKx
 c3SA6tiU3SakhHxjC7MIUw+V6Zg+pHZ6nAPuWLYh22JQv/UkLjIz7nE9IO4+Me+LlsTT
 PfBBC+3pkT/m275bjQ/incxjgyR9jJLykoAWTzgjaqMukrvpREZRa6yc0xFZ2zKMwR7l
 QYmvLGl6lzckHH148D7QqNJFzjg7KvBIXDbyFk/B/sVFkee2Rd4AlDwjg2i87iOR/i6X
 qxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784040373; x=1784645173;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pEuwMejFowMdCWNPLFyEu643LtN1cXWGJNAAG/USFAQ=;
 b=aT30rAF0K9cszvT1irCJIjT6giKFw/JDY89auw1JYXZkG1I8yW4bXN3gqKERFlOBJW
 L6VkLz+op6glj6U6OHAlljivqFeLGSMlCuLoGuduoURYkwubzkzQ1OFA4vMrjno02JQ8
 evUNAqoC+wKVY0GtiODH1gVXCYzyeA2YyovkOwZ3vwuA8Ty6i8joQcBS8dGN5hvFcrK7
 qR0c9xgwpLUqjO1wYMPLJU47B52n7j1XFyFx6xoaIg5jUXgnNCq2CA1qEWa6Q/35OzRi
 V+LCiQ4EkfzwWLWTHZslByPite0bdKnL/dDQ/B79mVURnSpSttiPdVcCFgN95pTbR0D8
 SNxg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqUkanNRgMo5LrZ7B0sX3L7K8ix+WEczFyrTBPd/kYUy2H0FTyEHnNfeUXlwXSm0zXPeMTYkAE5wRrR@nongnu.org
X-Gm-Message-State: AOJu0YzJR6FBR/3Z27ISp3ingwAt3yQFRDHJM0tiIQ4wL/zqtkbixlbE
 5UjAs/U4e+szGhGQgxbX/V424Sm05d0VgkgP9XfEM2WLcPZFTJM4CSPxtLJFsy/jaKY=
X-Gm-Gg: AfdE7cn8CTz6rOcSF8tM5tSMJBMo8Id8AixOrCBfD93BrJC1JO6Q+Ja7Am6poMp6HEh
 c7/ndwD4cSZCjjWdP88IhiWvvl5s0IriJA6eAQB+MKJvm2zeYubHjiZRp5HSFHck7L2sAE0Ib6H
 BA5IIUwWaaHqI8Moj7/9LMzpSwUgYB9yn5UvDJgwSGQ9o+RyOOtuFyrcebcp2vkh+F0nDUztaPb
 DEPj+EODRrBrwO2FzK9f+1TkYOt0K+HkjHDGiXxlv3I763Z7P/MdTuxKfeV5XurWb2tHog3UAaO
 4wYwSF1P3vhq/28MVJauacRFII/5+GD/44ZmM3dc6rq0VgRHKY31VBu4TqrFdZsFzrrqaC29Kg4
 +43rQu7Ze8OddzAns+dtiVBT62v/E3PQ95nfToIAsFlUD4AOWg6DZwrF9xqhL12AzycoX5KY5/J
 r5O/LLFxQVzDPeP6oPvmp5nJakbg==
X-Received: by 2002:a17:902:f68b:b0:2cc:7c36:2c23 with SMTP id
 d9443c01a7336-2ce9f178346mr124367455ad.43.1784040372874; 
 Tue, 14 Jul 2026 07:46:12 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.146.49])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d1edb0sm116971485ad.53.2026.07.14.07.46.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 07:46:12 -0700 (PDT)
Message-ID: <b709599a-c1f4-4e24-853b-f7da06981f6b@linaro.org>
Date: Tue, 14 Jul 2026 07:46:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/51] cpu: Use interval-tree for CPUBreakpoint
To: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-16-richard.henderson@linaro.org>
 <f64a5bc8-870e-492f-9a89-cbbb4c2e204f@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <f64a5bc8-870e-492f-9a89-cbbb4c2e204f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 7/14/26 05:39, Ilya Leoshkevich wrote:
> 
> 
> On 7/10/26 22:53, Richard Henderson wrote:
>> Use a balanced binary tree rather than a simple list for breakpoints.
>> Using an interval tree makes it easy to probe for all breakpoints on
>> a virtual page.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/exec/breakpoint.h   |  4 +--
>>   include/hw/core/cpu.h       |  3 +-
>>   accel/tcg/cpu-exec.c        | 58 +++++++++++++++++++++----------------
>>   accel/whpx/whpx-common.c    |  9 +++---
>>   cpu-common.c                | 46 +++++++++++++++--------------
>>   hw/core/cpu-common.c        |  1 -
>>   linux-user/main.c           | 14 ++++++---
>>   target/i386/whpx/whpx-all.c | 15 +++++-----
>>   8 files changed, 84 insertions(+), 66 deletions(-)
> 
> [...]
> 
>> @@ -312,33 +312,34 @@ static bool check_for_breakpoints_slow(CPUState *cpu, vaddr pc,
>>           return false;
>>       }
>> -    QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
>> -        /*
>> -         * If we have an exact pc match, trigger the breakpoint.
>> -         * Otherwise, note matches within the page.
>> -         */
>> -        if (pc == bp->pc) {
>> -            bool match_bp = false;
>> -
>> -            if (bp->flags & BP_GDB) {
>> -                match_bp = true;
>> -            } else if (bp->flags & BP_CPU) {
>> +    n = interval_tree_iter_first(&cpu->breakpoints, pc, pc);
>> +    if (n) {
>>   #ifdef CONFIG_USER_ONLY
>> -                g_assert_not_reached();
>> +        bp = container_of(n, CPUBreakpoint, itree);
>> +        assert(bp->flags & BP_GDB);
>> +        goto found;
>>   #else
>> -                const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
>> -                assert(tcg_ops->debug_check_breakpoint);
>> -                match_bp = tcg_ops->debug_check_breakpoint(cpu, bp);
>> -#endif
>> +        /* Prefer GDB breakpoint over architectural breakpoint. */
>> +        do {
>> +            bp = container_of(n, CPUBreakpoint, itree);
>> +            if (bp->flags & BP_GDB) {
>> +                goto found;
>>               }
>> +            n = interval_tree_iter_next(n, pc, pc);
>> +        } while (n);
>> -            if (match_bp) {
>> -                cpu->exception_index = EXCP_DEBUG;
>> -                return true;
>> +        const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
>> +        assert(tcg_ops->debug_check_breakpoint);
>> +
>> +        for (n = interval_tree_iter_first(&cpu->breakpoints, pc, pc); n;
>> +             n = interval_tree_iter_next(n, pc, pc)) {
>> +            bp = container_of(n, CPUBreakpoint, itree);
>> +            if ((bp->flags & BP_CPU) &&
>> +                tcg_ops->debug_check_breakpoint(cpu, bp)) {
>> +                goto found;
>>               }
> 
> 
> Walking the tree twice feels slightly inefficient, but the only
> alternative I can think of entails calling
> tcg_ops->debug_check_breakpoint() for each node, which may be even
> worse.

That's what I thought -- if we ever called debug_check_breakpoint when a gdb breakpoint 
exists, then we're doing something wrong.  The only alternative is to separate the two 
types of breakpoints into two different interval trees.


r~

> 
> Reviewed-by: Ilya Leoskevich <iii@linux.ibm.com>


