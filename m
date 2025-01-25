Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B023C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 17:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbjx1-0005Dn-Nh; Sat, 25 Jan 2025 12:28:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbjwv-0005Ch-D9
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:28:02 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbjwt-0005Az-Qa
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:28:01 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2164b1f05caso53618855ad.3
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737826078; x=1738430878; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NEIieqnnFpofjmIpZsTs4Ek//vNvzJmCPf7dativf/8=;
 b=o85BqWLAIXgGHweDIeoA2V3w8M8YeVaGWC83NadRCjUZUN0xn3+JNg5T82W0RR8Hzj
 HD92eXwVQsDR1SQaEjGaNB9cL4+zU2iAcYwPuj5yzidIHZzpR38am62y1mQ2v81cePUU
 4hmd5M0xZxT7EJ4fVbDl2ljGRMLeVF4Fs2lf/eULNn2X4+gLYXBmW5PqBreuJDmfbqUy
 SOKyyOGPm+xFbu3lDbVey1atypZlro/SLMVHQLWJ7rXdDy3l7fwOQKpew87goQar7mnc
 H0Frcg5pIMkh1CNIZmfyldG+BqBXc+M46BjLiit7fSdxQSmavA/TYYHVJibY9QzXX/yy
 fzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737826078; x=1738430878;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NEIieqnnFpofjmIpZsTs4Ek//vNvzJmCPf7dativf/8=;
 b=NkM2hM4DpKpfqFf35oGKgK2WGFEzIpb4Kg+5UmOGmwCet8oR3rqscAKK19m5r0GcAU
 fNPgwhGG0pyJ861skv9fb9EIB+qFZwSFnRyCzcjp8+bumzrDCaqh1Yn1gpKQBVMFoFu7
 sSXgcxFEuPRH8LIRu7OzgQ9B9WWb7S3iYQoyhIh2HdRc5ad+r3o+rt/+ajdPtNnILeMP
 Y24tB7ZM1h30QrxN5rBnPgp67di8IqDvGNVcNy0upwVh1DfnZp8cjsuyHveIOupLUSjQ
 ce7s8wqT2MWU0qtXpwIy0XV3jU1PsD95uugDYyQbmpp8XoLG56zgiTX40fNZ5t8WNJBU
 25FA==
X-Gm-Message-State: AOJu0YwuxOR+WTT0xZV7VWb8BVv/UYcjHX5vsBnYmTohYktcfnG3F4j4
 J8Y94vXLhpnyQkQ5tsXhqxAkL1UKFoe/9RZdW3OH3Vkb2EVpnKDJ495ibrN7tHVNRSN0QnUYUBO
 m
X-Gm-Gg: ASbGncs/hZjxQImXk/meLQJaM+lUt4l1aXuQfvbgYW9yKYH1X/h5afyxQoq/RnJlSEz
 V6ZWD7fb8QhE+p5pCDKgvgyWbnnSighLXI2NVCB93+X0Zc/WDVzbIeD1oF9II7qCBX+JbYiHqNN
 00TAA9s5OqNcN83pNEsF/1uG/7cVDfAsb+vefZEvILbkpai9VlA2tBOQ0fGxDKSz9/d/24BNomI
 tvMfnQPXLoP2RrTYasupkO2fgU+TMhZqhIaPT8+YeJDJOsJJMoJn4l8OF1XvmqLVjnrj2D8Od8I
 w6hDdhE1f5imvpfEYnSctQ==
X-Google-Smtp-Source: AGHT+IFTygMNZB4pVgoyPcIHjFx52QJOswurSyQcYrtlqxkWlC4ofJKuDGGxcvZS6EhgJyzetL+2BA==
X-Received: by 2002:a05:6a00:4c18:b0:725:c8ea:b320 with SMTP id
 d2e1a72fcca58-72daf99ec6dmr48209596b3a.14.1737826078351; 
 Sat, 25 Jan 2025 09:27:58 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a77c846sm3998694b3a.148.2025.01.25.09.27.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 09:27:58 -0800 (PST)
Message-ID: <068c3ad3-04d6-4f16-bae8-57d09a0debaf@linaro.org>
Date: Sat, 25 Jan 2025 09:27:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/76] target/arm: Adjust FP behaviour for FPCR.AH = 1
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-30-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-30-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 1/24/25 08:27, Peter Maydell wrote:
> When FPCR.AH is set, various behaviours of AArch64 floating point
> operations which are controlled by softfloat config settings change:
>   * tininess and ftz detection before/after rounding
>   * NaN propagation order
>   * result of 0 * Inf + NaN
>   * default NaN value
> 
> When the guest changes the value of the AH bit, switch these config
> settings on the fp_status_a64 and fp_status_f16_a64 float_status
> fields.
> 
> This requires us to make the arm_set_default_fp_behaviours() function
> global, since we now need to call it from cpu.c and vfp_helper.c; we
> move it to vfp_helper.c so it can be next to the new
> arm_set_ah_fp_behaviours().
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/internals.h  |  4 +++
>   target/arm/cpu.c        | 23 -----------------
>   target/arm/vfp_helper.c | 56 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 60 insertions(+), 23 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

