Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29005CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZrji-0004hm-3b; Wed, 17 Jun 2026 10:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZrjg-0004hL-4d
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:59:24 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZrje-0002Ra-OD
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:59:23 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c85b2139015so2104748a12.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 07:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781708361; x=1782313161; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uY8W6rRRUiYb1NWUG3Aulu/DXA8oYfv+jnIYL75EieE=;
 b=l0Z0TA+D8rL96MelZN/F+DIrfntO/jQJnt8obDUJS6Ul2HJIPYEUh8fEGYERx4HlmV
 OIa4In4mCTRXsYyV9ET0KvjhBnsQU2RIhsF0YrIRmlzXfnwffNgIuSl6w9YDt+VbeZM9
 QNYf7GfalIxBmAg7zuCfLyVqwlWugPyiBnCKdqUV4rNWuyeCmZoEBIN0dLgzZa6q+yTl
 o4k9f3VcbGJi3uSGY2wJwL5s3PEeKrLbl7btnFDP6qHpkzkdnlj8kZwJ1GOfzB1A21+l
 PLNcAtQgHnY8r/QUJo6q3AhH9JUsGm4NgRdQC1vBU4xWzXXWG23eRFMlSWzrZc2yYi09
 klgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781708361; x=1782313161;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uY8W6rRRUiYb1NWUG3Aulu/DXA8oYfv+jnIYL75EieE=;
 b=HGckxmeoy8nCzIn3FG9RGbQdL7zLu+1AHmQvc6FKKNzFAOWdgV5PjsSLmGDSk7Sigj
 UAQx6FvvsCPqhPzhM6KI1+iBijU42kmDH436QDOAxFOMoyHhPFHwCcfi7BcSDqzpYU2I
 izc2PIw5yPk27hj8PxVEia9jkGm1V1yqQAfqbfA3q0zW5c+HxJcApEkc8ubmr1W1Wm7N
 QA5xwqKFqq/NrrO8nbPnHp7g6tSqZtZZedGcO1WU30pfcwKm+ZNRtuSr9VVCfn03/Gs5
 lUQ64lbbUtLrCIU+HQvzbX7AIVJA4KEY9xhAMJsSYYiul10oh2xpU30+yMQaJ7tskIEY
 N5XA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/wBjrLVRQUw66kaXb0nIhPOxsofqDUsn+pEpjBZtlHcbmnIzeBgNTssaEXzLplgvuqFJXpz1noEODQ@nongnu.org
X-Gm-Message-State: AOJu0YyE5pQdqa4KztqtEA5+tUnLfUMGkGSpGopd9fr9A5dCdEybpEGS
 t2t6HfGSTp78YG3/jW5+aSmSr9gvggrICxEtS7E4q4FX8bHxYWmLLGaUlSXWnfTlUzs=
X-Gm-Gg: Acq92OG8l+69mUQpOa7SKo6vCaveBtMrA29CAMiWTqNydIg0bSV3R8zG2G1jgu0oBTt
 TLi57rCWaZgqoJ2UnE0HRjDdy9x4bF51k17mI3MBhFt7J8/0uFPXw1U4zaaOOr9z7ICevydXtAM
 AqYnCy60zDs1kQAyV7zJHOr3NRI9bgJIX85l6seXmt20+tPVEGP3BfsAwv8wV6G3wFP1/iIYo7Y
 xIAE5huZhyYvU6NnyXK6TkqV/l5cl+tXod7eMVrIQ4BLuNyUHqL5JyvSUpmdyZnzD2mfEtpWhon
 M2rtDRd4Gw2CpAgP71L08w447SnzguBdSEQ6scN1djLUETCCt/s6WK2KhRH+vZ8Vfe37+Wo/nZO
 orh5kbP+sBFHODpk6LuFil2e9yOG4F3NEEwPChcMzUvkL6WBKriYfkTSQHybDJz40axx4miHRqT
 ADv0HWInZMIHtghgWi+rYO2o3TQO9DkeoA4rgSntnIiva8Qrc/JpmVhQ3leQ==
X-Received: by 2002:a05:6a21:3990:b0:3a1:90ef:7e46 with SMTP id
 adf61e73a8af0-3b8b7dd9b4fmr4736969637.33.1781708361111; 
 Wed, 17 Jun 2026 07:59:21 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434ac9dc96sm16432944b3a.6.2026.06.17.07.59.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 07:59:20 -0700 (PDT)
Message-ID: <338e63f3-ee06-4a2e-ab61-e3ba71fe3071@linaro.org>
Date: Wed, 17 Jun 2026 07:59:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] accel/tcg: Restrict headers being TCG specific
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20260616191716.12932-1-philmd@oss.qualcomm.com>
 <20260616191716.12932-11-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260616191716.12932-11-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

On 6/16/26 12:17, Philippe Mathieu-Daudé wrote:
> Forbid including TCG-specific headers in non-TCG builds.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   include/accel/tcg/cpu-mmu-index.h  | 4 ++++
>   include/accel/tcg/cpu-ops.h        | 4 ++++
>   include/accel/tcg/getpc.h          | 4 ++++
>   include/accel/tcg/helper-retaddr.h | 4 ++++
>   include/accel/tcg/probe.h          | 4 ++++
>   include/accel/tcg/tb-cpu-state.h   | 4 ++++
>   6 files changed, 24 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

