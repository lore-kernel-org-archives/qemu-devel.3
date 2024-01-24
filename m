Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D255BC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 02:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSTLB-0007ai-Ke; Tue, 23 Jan 2024 21:50:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSTL9-0007aT-51
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 21:50:11 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSTL7-0007OU-CI
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 21:50:10 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3bd6581bc62so3483838b6e.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 18:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706064606; x=1706669406; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QH9cKBpP5sSR5LCKwwh3f1JzaqtUU0FUjP4Gq8BAb/U=;
 b=ays2AaHzNM7zfigtAPyaIFq7vuMlBLGrP+VptQnMjvQcFeC1nHxEMhG+Cl5zhyjuOF
 6pSmi9ULsVwlzOSnlT7aPMEz/GIT/P6/mBtoh4UywwmvaMY0PDchQ/E8NZUa3Hkhl8Lr
 fr7gjfQOyKfF6P4/cekOCSpMzW0GxG8lfTse5uIFwoetaXidvCYwOchd3mlx1vKrTEvu
 A9C+s/ZThyeFuAS/mMtrpLN5Gf9IjBjk2UTYHuOOdr9yrRBHRpOXZ7Y8IDytHkMXGhNL
 RFCqWD4clvqKDMJwgZBNcPNjXixK43lKluGpkeLCGb0Eny6VumHOj5Tl8u8ygpb/y8jF
 Xi1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706064606; x=1706669406;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QH9cKBpP5sSR5LCKwwh3f1JzaqtUU0FUjP4Gq8BAb/U=;
 b=JyzREB3k4DCGIft+uq+Wx6WOZiV/ZKzusuUqauBb7MkeqOHT14WJ5gQrZxByTmFyL1
 OoxRiWnH8bq9tBgIr8Qm7CE0zRLHP2XgE1FKnMQWOwYWfEE3LaoWbwQv/KWwdG37/9WS
 1GeqOZjLSdJWq5H7Qgr2bTp9AcsuY8lPGYu09DoI3rVXzoxndCrY0yY+JDOJGyQr6480
 qX+sDu+Y5YV9eqvD24I7Upsy/CVP37UGtyRnfcOM5GdQMzXWVa2na2O3WNP2f54JpOhH
 /NvbisdBHw0hH3CSCWvRYTQXyBfrtZgiTozcDUXrqkoTp2bkGl5nejFEx2sIbxTqh8dk
 R65g==
X-Gm-Message-State: AOJu0Yzj5n/tdJjmrp5jgTbmwvacGSupFujVZB40tP/PddLLGQrpMV8r
 dt4Vy7jR0tG7Y9sxJqWFCs7/1op83wlh/FG6FoSGzVOIx9erGOMq5RW9ukYn/pE=
X-Google-Smtp-Source: AGHT+IG67LNtf9NxIvagAVr2WN9G5UrZxkPNfqwnu+POX2rGXiAPUfH+C2w3PH8OO0N6JUKb2TRZhw==
X-Received: by 2002:a05:6808:238a:b0:3bd:4cc0:3ba1 with SMTP id
 bp10-20020a056808238a00b003bd4cc03ba1mr1120364oib.16.1706064606484; 
 Tue, 23 Jan 2024 18:50:06 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:dd1:291f:3c3c:2485?
 (2001-44b8-2176-c800-0dd1-291f-3c3c-2485.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:dd1:291f:3c3c:2485])
 by smtp.gmail.com with ESMTPSA id
 u33-20020a631421000000b005cdad153d84sm10803393pgl.90.2024.01.23.18.50.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 18:50:06 -0800 (PST)
Message-ID: <49702a11-d61c-428e-bb6f-e60a6ec2ecea@linaro.org>
Date: Wed, 24 Jan 2024 12:50:01 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 26/34] Wrap target macros in functions
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, ale@rev.ng
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-27-anjo@rev.ng>
 <a69519cf-27f6-479e-9ec6-ff7e11454c90@linaro.org>
 <n2u2ifeti6fqzppvojuyi4i4phzrb4xbk3x2rpjhhesnwxwbdy@lmf3m6fqcr7g>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <n2u2ifeti6fqzppvojuyi4i4phzrb4xbk3x2rpjhhesnwxwbdy@lmf3m6fqcr7g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

On 1/23/24 22:12, Anton Johansson wrote:
> On 23/01/24, Philippe Mathieu-Daudé wrote:
>> Hi Anton,
>>
>> On 19/1/24 15:40, Anton Johansson wrote:
>>> Adds wrapper functions around common target specific macros required by
>>> accel/tcg.
>>>
>>> Signed-off-by: Anton Johansson <anjo@rev.ng>
>>> ---
>>>    include/hw/core/cpu.h |  9 +++++++
>>>    cpu-target.c          | 62 +++++++++++++++++++++++++++++++++++++++++++
>>>    2 files changed, 71 insertions(+)
>>>
>>> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
>>> index 57d100c203..a2d65c1d7a 100644
>>> --- a/include/hw/core/cpu.h
>>> +++ b/include/hw/core/cpu.h
>>> @@ -26,6 +26,7 @@
>>>    #include "exec/vaddr.h"
>>>    #include "exec/memattrs.h"
>>>    #include "exec/tlb-common.h"
>>> +#include "exec/memop.h"
>>>    #include "qapi/qapi-types-run-state.h"
>>>    #include "qemu/bitmap.h"
>>>    #include "qemu/rcu_queue.h"
>>> @@ -1164,6 +1165,14 @@ void cpu_exec_unrealizefn(CPUState *cpu);
>>>     * what you are doing!
>>>     */
>>>    bool target_words_bigendian(void);
>>> +bool target_supports_mttcg(void);
>>> +bool target_has_precise_smc(void);
>>> +int target_long_bits(void);
>>> +int target_phys_addr_space_bits(void);
>>> +uint8_t target_insn_start_words(void);
>>> +uint8_t target_default_memory_order(void);
>>> +uint8_t target_tlb_dyn_max_bits(void);
>>> +MemOp target_endian_memory_order(void);
>>
>> None of these helpers take argument. I don't understand
>> how they can be called in heterogeneous context.
> 
> No you're right, I was focused mostly on getting accel/tcg to compile
> with hetrogeneous being a goal downt the line.
> 
> I like the idea of moving these fields to a struct filled out per
> target, but dispatching would also work.

All of the bits that you're referencing in TCGContext, outside of compilation, should be 
treated the same way.  Like Phil, I'd prefer to move these once and get the API right.


r~

