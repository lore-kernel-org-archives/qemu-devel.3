Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA6AF94CA2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 01:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFMda-00055g-5j; Tue, 21 Apr 2026 21:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFMdZ-00055W-Bp
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 21:44:21 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFMdX-0004yX-QQ
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 21:44:21 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-40ede943bf0so2922083fac.2
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 18:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776822258; x=1777427058; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3hIfXoR3smtI59cJ9ejNun/84EMLH8/mmE8oLstjuPw=;
 b=YFPIPLuTtN9zWh3ruO6j5UeupXARK+q1MJok9VNuediKVMsjyMyAEFf0EeCVI239lb
 mtmYPYlds8segHLqNeYfkcf+8qdnqSplXVsaw56Ra18Bn9VH3i2AdgQ6En0dtys4tFPe
 44CkPUHNtc+YyAzUTSNbtcX8svuFnWmSMhFHX4HCQQ+KGhJpJCnOF2unifNBK7Dc2STj
 xcRYssA6za3RQn0txEzQ7AEUOwzi9yUgcUegsAZlaYs1YvC9kfnKDGXRz0BwRLvNMX1a
 71XLchPv468jvfNUo3amlzLTLa7/vRiowOWNtjGL0SSsqnHlYaYskTuQrGogQtFYHkvN
 tLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776822258; x=1777427058;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3hIfXoR3smtI59cJ9ejNun/84EMLH8/mmE8oLstjuPw=;
 b=hVALWTeGXVCEjmkFys1mnAT/6oNdX+nGEaknOC5EppLv7XLk5nLmZJfUyacAQm6DfG
 nF038V2zTLiPGmwfqae8YSwPSu21tnhk77WvGBGSuX49yWKbfzAEaghkXxGZFDkwCjPK
 znsBrNtMf5nM4jKY+EggIQyvWOB5J53HwcUaG9/i+KSey6wRhyRgskKg/RQsBpx6dgTh
 a8AYVgJ/aWK8vla1kEmEzBT/d/AQHdkckHrFgRqgavTe+noDiR3wier0CN0RNkWeOAFS
 0rRURn+DUzShxyxSmrg1sX/FVSUIM6/4DNyC/45YbofZ3rN131sasQ5gfRjLwdnFqKGt
 qIbg==
X-Gm-Message-State: AOJu0Yw/QYkT5Xo/YsRvg9Lh2xaYQTgOOgLKsBzkEP0Rtu2IoZy3zJLu
 XKLcJoWL8LSAAgIj7bkjzoRpidR5kjj9/euVcNNdmumQyapbxQ8KKvwMGryBopAAviDwUSJoVh6
 jrBxSrZM=
X-Gm-Gg: AeBDievhioipUdcCA23VkbdhJy0rql9rjHc1othLUVbT55eYnKekgvFdQahzZKmYVqj
 2Jz/mpXKxcYfrOy1NoL90H4JbyeCY94kULsEZYI6SzXJezw4N/TyRWxZcU56iAL5VKbJCsqZiLZ
 cTGqLi+caTVxifCDJ7gDpPZXJNHRwk2ml46n+rmM/HwkDL6hbnfCK61w0OT/DMtIfYXg+ssTE55
 /JSSDW0qsKYZxFCgu2BWEDUY8Pef//X03h5aUi3oUzOaOjyD/tc7wC/+KrK/lRxlmkq78p3ioH2
 x6daLIbwPEhrvJs/6AA5HzcAoAsqC5IOErtP6MMurvvxsL+MVJX2B8thytYRvYaPE97d4lBmTIE
 wFSuStIYxIIJanW3I9ROign9RgB2Cd4d/ev7uokK+7ZFLsZ7DyHYGkfwFPaY+mzC22d6niJokYT
 2WJqgx4dz6rFZcZT5/GhtMXqFFidXfR2MD66pSSk6IyZjZ8h85ct14OdSPWvzO15CIN+ef7c0z
X-Received: by 2002:a05:6870:2b03:b0:417:70c2:8537 with SMTP id
 586e51a60fabf-42adecbfb02mr12611587fac.25.1776822257612; 
 Tue, 21 Apr 2026 18:44:17 -0700 (PDT)
Received: from [10.72.56.227] ([172.59.197.244])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b930afa63sm12594136fac.5.2026.04.21.18.44.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 18:44:16 -0700 (PDT)
Message-ID: <544be217-d0b9-4ba3-ac52-06056782e637@linaro.org>
Date: Wed, 22 Apr 2026 11:44:09 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/13] target/mips: fix Octeon arithmetic destination
 handling
To: qemu-devel@nongnu.org
References: <20260421-mips-octeon-missing-insns-v2-v2-0-a0791df188c9@gmail.com>
 <20260421-mips-octeon-missing-insns-v2-v2-2-a0791df188c9@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260421-mips-octeon-missing-insns-v2-v2-2-a0791df188c9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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

On 4/22/26 03:27, James Hilliard wrote:
> BADDU and DMUL write their results to rd, not rt. Avoid treating rt ==
> $zero as a nop, and route writes through gen_store_gpr() so rd == $zero
> is handled consistently.

If you do the second, you can completely remove the initial IF.

That has been my preferred solution for other targets: minimize the number of checks for 
these unlikely cases for all instruction implementations.  You know for a fact that no 
compiler is going to generate such instructions.  The only place they'll appear are within 
architectural compliance testsuites.  Let code be generated and then the store_gpr helper 
will discard the results.

The only place a special write-to-zero-register check is useful are for the architected 
NOP instructions, because we do expect a fair few of those.  Even then, when using 
decodetree, consider specialization within the decode, not within the helpers.  See the 
nop/copy/or example at the end of docs/devel/decodetree.rst.


r~

