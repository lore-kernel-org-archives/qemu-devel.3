Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF8AC2BA18
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 15:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJaeG-0006mF-E5; Tue, 18 Jun 2024 11:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJaeE-0006lt-5d
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 11:21:26 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJaeC-0008Pn-DL
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 11:21:25 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-704313fa830so4338583b3a.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 08:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718724082; x=1719328882; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zaS3i79kglVym64kFiPanOXSUpkMdn2FYkatJLQNJzw=;
 b=BqgIt8EatdOJe8UEJ7oM7N7JmTv1i8mS/37KSGc9Or9nV9MyHT0qflLGu2wP4JWLx2
 916k7lbkp4YwPZ7beqAxDOQzLfX6S+WI+l58eQWsGj9EmcUsj1JwHTAcYsqRPxvG/WUK
 ihyV3sriAgrdVfr3lhlZXrJoI9l9ZFlEkpc3kSZ/w54pRDc8qb8144gzzI9+clb+D0sU
 oWfJN/s38EzyaXC/cU4Q7yOSV2Emh2uo9pedtfmC3eD8KPboY9pp0ou3o+i1R4CVZCOD
 Ar5qSKSCIt72PnbVICM5apm/b4st5Xl5og345sGWeu48bFIyUY87mIPWKIzES0AlXcQi
 6uyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718724082; x=1719328882;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zaS3i79kglVym64kFiPanOXSUpkMdn2FYkatJLQNJzw=;
 b=KFpBQXV/nE9e7Oj4JrT4p6lwBCrU/jYcfcupLfS+9Vcn5cMLxUy9B7eqM7v0y6080W
 NQehDLXCb4E85zEt0vSc61yVMGD0J2dASVifCQaJDkS3V7LJgZWvXSiNOB68XJaTvALR
 wrJXAzhm8K66CopNnqU+UQxdWGRqZQmnPkmqPe4DYZYcP2BZI9Vyr0QWaMuAH/5Jn0K3
 T2lr/7bgMcu5QpTQuifZVUXLeAO4aULbqcM7lNyeBfu1mGcZg9F5pjHUeC4S4Fswrf+M
 /p19x1FD5Os/uBVIPHUJTXnVYdM2ya4Uuk0abCEfKHFRj8IEc6OPt+gRS47IjWGXZw2n
 5IMg==
X-Gm-Message-State: AOJu0YxA0odaV+7TJBb5+RZJlMavjVoQ9gHpdEsdrn7eQNeIZQkDiDcv
 d0O+1Rfa7GlkJdeWt3m3XDa5msG9FsppbGgmuRacx375nlY69SdXYvyPmal1M2U=
X-Google-Smtp-Source: AGHT+IGyi91yjFOv9VhBlgsAb9jbfhT0CghlUz+FbYgUPj0Zf/BR+TE8hf8QrHcGmsc/Bskh++bNgA==
X-Received: by 2002:a05:6a20:8427:b0:1b5:834b:ad75 with SMTP id
 adf61e73a8af0-1bae82f70b4mr13431331637.52.1718724081703; 
 Tue, 18 Jun 2024 08:21:21 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb3e42fsm9093651b3a.100.2024.06.18.08.21.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 08:21:21 -0700 (PDT)
Message-ID: <f0360d29-7348-4910-8057-849418049c6d@linaro.org>
Date: Tue, 18 Jun 2024 08:21:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 27/34] accel/tcg: Make translate-all.c target
 independent
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-28-anjo@rev.ng>
 <63dfead3-ddab-4502-b3aa-b7481a4f0ebc@linaro.org>
 <n5zuo5jky5zblncdnfitmch7fdy3qki6o5k5tyjpc7bmvkczck@7g6m6m7jukfb>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <n5zuo5jky5zblncdnfitmch7fdy3qki6o5k5tyjpc7bmvkczck@7g6m6m7jukfb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/13/24 02:50, Anton Johansson wrote:
> On 24/01/24, Richard Henderson wrote:
>> On 1/20/24 00:40, Anton Johansson wrote:
>>> Makes translate-all.c independent of softmmu target by switching
>>>
>>>       TARGET_LONG_BITS        -> target_long_bits()
>>>
>>>       TARGET_INSN_START_WORDS -> tcg_ctx->insn_start_words,
>>>                                  target_insn_start_words(),
>>>
>>>       TCG_GUEST_DEFAULT_MO    -> target_default_memory_order()
>>>
>>>       MO_TE                   -> target_endian_memory_order()
>>>
>>> Signed-off-by: Anton Johansson <anjo@rev.ng>
>>> ---
>>>    accel/tcg/translate-all.c | 38 ++++++++++++++++++--------------------
>>>    1 file changed, 18 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
>>> index 9c981d1750..a3ae0c6910 100644
>>> --- a/accel/tcg/translate-all.c
>>> +++ b/accel/tcg/translate-all.c
>>> @@ -65,7 +65,6 @@
>>>    #include "internal-common.h"
>>>    #include "internal-target.h"
>>>    #include "perf.h"
>>> -#include "tcg/insn-start-words.h"
>>>    TBContext tb_ctx;
>>> @@ -106,7 +105,7 @@ static int64_t decode_sleb128(const uint8_t **pp)
>>>            val |= (int64_t)(byte & 0x7f) << shift;
>>>            shift += 7;
>>>        } while (byte & 0x80);
>>> -    if (shift < TARGET_LONG_BITS && (byte & 0x40)) {
>>> +    if (shift < target_long_bits() && (byte & 0x40)) {
>>
>> You just make TARGET_PAGE_SIZE etc target independent, right?
>> So you don't need this?  Or is this because of user-only still.
> 
> Hi, Richard!
> 
> I missed this piece of feedback previously.  I don't see how
> TARGET_PAGE_[SIZE|BITS] would be used here.  Are the values we're
> encoding always TARGET_PAGE_BITS in size?

I was obviously tired here, since they're obviously unrelated.

However in this case I think TARGET_LONG_BITS is a red herring, and we should be using 
int64_t not target_long at all, and thus the shift count must be less than 64.


r~


