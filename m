Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005A0C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 17:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwjgH-0005DU-4t; Wed, 19 Aug 2026 13:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwjgF-0005D8-EA
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:02:23 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwjgD-0003oN-Mm
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:02:23 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-84faf87d19dso1373117b3a.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 10:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787158934; x=1787763734; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HgUUAFwAgpfyCeW14taFa3bM+P7nWCuBRhZOVTGc8bE=;
 b=A76K296JPvEyPwfRs+iX/WsiQxGjH9jNveGaC9RJ6xrALb+NJhHLdAvqm363ZQdZKZ
 fUV5rST4swPBX7+pvbz53EsaS117eS3OiIANH31P6Kjp7iXlRJIzx0UZnJG0o3rj9PsY
 cY17nm5Jc8NZnAfc4Khed200YCOd/BCkGe+x9hvc2ozf3Nc5ZVYJ07MmE2UDbI51A+HJ
 dEJt7Jr+WpfwIF/GS9fdQBwjiek9pn5J/8i3RskCSNwk4i4ifG7RltvRl+9BwJYXn5Lo
 fZ0cF0rqriT7VhTfiBrh43NNJzJfBjVAP9++871W9K1TBjMKW88rq9w0evQw1dBT4kHt
 wj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787158934; x=1787763734;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HgUUAFwAgpfyCeW14taFa3bM+P7nWCuBRhZOVTGc8bE=;
 b=Y3TOvrH1kODVPdzSiaYLMJryuF60JwQasV1tSC8RWSYlSThxGsGuCzsQs4JuZchVbl
 HGg9w1zT8O1ch+v5Hy8qx7JaLzl9npoWwQmlKmiMgoFVfbtJ3Oi94DsaejYFMxF/s474
 R7rkE6SL2/yXl8kNUdZEnoYU7Gi/buSjmparfbdD7/lWsf0Tcv1ccqi/nPOJguM8Be1H
 6vR25r7zfZlwSfxNJnbdbyDHQSAiaVKu9TPaP0VeMowXJX8tndZKPyPLjoNLi2krqvTa
 qAGAKiYmN0HJ0bMITscjjSVM9vAAOPmNuPHipJF/uNgudcoDcMl0ObPgQYpzkpQiKb9R
 /ekA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoGKpLnfS8r9jcs+WHKZ79yhBYBRrwPV4Ekv987WuKxsHcBLvf/Mnt6hMXiYF3G+MdsFvPJUeIIoCTh@nongnu.org
X-Gm-Message-State: AOJu0YwA0MDnealGRsNgeCpC1QS6jO1E03ST1mYJECYgE1TDz1sdBsF/
 ar4Wi7Dpe953AVb7gtkyg0jtYg1KhNzilVo0amep9xOm26qH9IR27iM9G74X21lGUoQ=
X-Gm-Gg: AR+sD13RRSsxGv30dewCpqkPb9Pug2V+/UP8zz7Wg1+ThC0PhBTTNxcbX1SVWPUkpAE
 5n7U/f+divoIrpHDOEY5ZFXOZCcHFL9qw1MAGg4FzrExHQJyfFWwlfkwY0mjw/tugAtE+0btcc/
 9HRvywU9G2ieluRWp75gl2ICl8fXNtBDoAQ/8IOFImR5WbRbEsLNeYRaw3YZHomRXyp1nOnyLKG
 Hd6bEkdUUBo3diNnBfY6751Pvqi45M/rIlJGcDckKuFqhuV9FM+TcTyY65RveFhXz3IGuZe6HrP
 mFe2/x4VkXhxbfFqy4PhWZHJPA97/CQn4q+cTE5BUlv9rkldXtGi5dJgvI1TopXJX5CmvA2FP/o
 jSgo6Oy8/PHTqglKgXXamViEokWbXgjebqx6VTURRVvcKgI4BGHJGgUR3zm9ErKa3FD6rYfob9o
 HMngfMiQLOsSgi08qZhVL7kDwUcUWwnMxU+Slpf4sbJ6BwxS+iBypWsMFh9cslZL3uDHqBFOJEm
 0rlLIr9
X-Received: by 2002:a05:6a00:2e16:b0:846:4d4c:23f8 with SMTP id
 d2e1a72fcca58-851d3809eb0mr9036969b3a.1.1787158933355; 
 Wed, 19 Aug 2026 10:02:13 -0700 (PDT)
Received: from [192.168.122.51] ([173.164.107.233])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851d336291esm898335b3a.12.2026.08.19.10.02.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 10:02:12 -0700 (PDT)
Message-ID: <e97abd17-5462-40d1-aaa0-895c4203366b@linaro.org>
Date: Wed, 19 Aug 2026 10:02:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Correct reset value of SCTLR for arm926
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260818115814.2268429-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260818115814.2268429-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 8/18/26 04:58, Peter Maydell wrote:
> For the arm926 CPU we reset the SCTLR to 0x00090078.  This is not the
> value specified in the ARM926EJ-S TRM (ARM DDI 0198E), which states
> that bits 16 and 18 are SBO, bit 17 is SBZ, and bits [31:19] are SBZ.
> It's also not the value seen on real hardware.
> 
> This has been wrong in QEMU since 2007 when we first started actively
> resetting the SCTLR to some fixed value rather than zero.
> 
> This wrong value didn't affect any of QEMU's behaviour, because we
> don't implement any handling of the old pre-v6 meanings of these bits
> (which were IMPDEF), and their v8 reuse is guarded by appropriate
> version checks.
> 
> Correct the reset value to 0x00050078 (i.e set bit 18 and not 19).
> 
> (We use the same reset value for the arm1020; this might also be
> wrong, but as the ARM1020 TRM doesn't seem to be available we can't
> check, so leave it as-is.)

Found ARM DDI 0244C, ARM1026EJ-S r0p2:

https://www.datasheetarchive.com/datasheet/ARM1026EJ-S/ARM?term=ARM1026EJ-S%25E2%2584%25A2&version=1

which appears to be what arm1026_initfn is modeling.

It also has [23:19] SBZ, [18] SBO, 17 [SBZ], 16 [SBO].

> 
> Cc: qemu-stable@nongnu.org
> Fixes: 610c3c8afd99f4f11 ("Reset ARM cp15.c1_sys to default values. Fix XScale cp15 accesses.")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4202
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/cpu32.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Anyway, for this one,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

