Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7D1D6910A
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 13:30:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGebC-0003HC-RQ; Thu, 28 Nov 2024 08:30:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGebA-000396-Pd
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 08:30:24 -0500
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGeb9-00054n-Ap
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 08:30:24 -0500
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-297078d8eaeso864834fac.1
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 05:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732800622; x=1733405422; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TqtScC740xmd5u7iaeC83AA3tKDiDpqWYQrYgBVMH1o=;
 b=X/175QvDX0gg6ghqq+cuYznAW1jqBUbZNyAgk5h96v79NKI8rKMdrRp1slQjQz2AGf
 Y9h1tCUl/3AuBJ28h9w0aEyPdsRMyxfmjZIAni2Ca5TPFCMkHiUuYi5HbDoQrCMHThC+
 PwwXwi4KN7S/Z7aJ5OX2l7jwz2Dg8cGE2kEhqT9xg4IHcn0wnQp/6Evo0j7CwAMzOFNc
 GXqTqlaVxbPSWXNSNDGaYFAZg7Rrp1glyUVcv9YO4imKmjGOAlefvTeY8Yd4DLLy9FQz
 92BHWf/Q1sER+v9mwYTFxAOdIVDifXTi3keyAMPUxA/3C2vATHH2wkFL5aeQVikVrDN2
 YDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732800622; x=1733405422;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TqtScC740xmd5u7iaeC83AA3tKDiDpqWYQrYgBVMH1o=;
 b=o57NKWSBm0KPNr0+PNzK/RTcISEj3Qlale8Mx4dVmnYP/vwj/vtsKtmnwqgUsKrMp9
 5F3/XlHmx3rEihiM6QW9PLswt7WlCXEljqECEv+CjABBvIT8/7pWdvIjvK2JRyg1+mch
 EZpHsZoDYNjCTevs1/P8MtNXkz4R7o0JmFzSaAOb+3WuHbHuhxCeehkz32/pnzOfTO74
 c81gUaT7X7bWJXUEBAvGvIX1uSPdt7rZ+1wztzjrUOcxA+11L+tl5DPIH3iJzVs+V46a
 vwO6eC1VgG7EBjOcr14cZMDjOFO98ImntYXAANRsqhEISpHTmOmMrSgGB/kTmc8hepNz
 pXEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5OsewNhUi2zfsED3svzM3kJ5RhHln4Y0LJ92Qz12xUEzhMRihp0eG4wc1xnZeNXHSC0kKmnaByQIU@nongnu.org
X-Gm-Message-State: AOJu0Yxw61D2dzuWtb/0hJtV56hFipY0mlftka/KN6gy7MN+c0h1eRdo
 mWY1+l6hLJwPIIWjj66xmPbCTox/iDh/rEZdJkfn6BsTgIcFrFlPPspvu32LyH5czfz6Gl271bf
 alcM=
X-Gm-Gg: ASbGnctb6DNswWU3XrT6v6h2AtMzhkt72FFGsET3er/9VmRDiGNh8clEe5gp92i4rDj
 K/7y251yQ/AXxE1LBcLLYVHVizbhJWje6kPdpBLKYTx+PmaNdoYlCORECYP9IyjSqDmuTonyBf/
 A9FeRY/LG6z//tPDs9s0T6g0KQNtgOHsMXvWSJC/cDjOfZ7ImaPlyCqxZdGBhEzFPTw3lD6eDN5
 bbK8qErazfOLx21nLKQ57a3bN98gIZ9rUZtRo1fV0zkJBVEG6OeWb6VBR2r0l78bCR5Uc8e5x+d
 CZ2rD56UebJ0+dQtnZCHRoUef/Wk
X-Google-Smtp-Source: AGHT+IFFezvgwq65WNzdGeBNQjUHKiOOh1xaSs0ds/WBgMS/YD4L4mI/cRC4wvNWnS63xbyRjTa95A==
X-Received: by 2002:a05:6870:828a:b0:287:6f4:1ac5 with SMTP id
 586e51a60fabf-29dc418fdfamr6786035fac.20.1732800621797; 
 Thu, 28 Nov 2024 05:30:21 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d7255e6e2sm291024a34.32.2024.11.28.05.30.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 05:30:21 -0800 (PST)
Message-ID: <3448897b-c51a-43dc-8793-fc6c2a73304e@linaro.org>
Date: Thu, 28 Nov 2024 07:30:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0 09/25] target/sparc: Set FloatInfZeroNaNRule
 explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
 <20241128104310.3452934-10-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241128104310.3452934-10-peter.maydell@linaro.org>
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

On 11/28/24 04:42, Peter Maydell wrote:
> Set the FloatInfZeroNaNRule explicitly for the SPARC target,
> so we can remove the ifdef from pickNaNMulAdd().
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/sparc/cpu.c             | 2 ++
>   fpu/softfloat-specialize.c.inc | 3 +--
>   2 files changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

