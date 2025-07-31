Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E52BC87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhalY-00025l-Hv; Thu, 31 Jul 2025 17:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhaHq-0007R9-C6
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 16:54:02 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhaHo-0002J0-RF
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 16:54:02 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-76bc68cc9e4so1050554b3a.2
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 13:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753995239; x=1754600039; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZIAkqrIOgetL8HzndJ6YdKjNn1VZNvytvE3me8fVVdU=;
 b=dSFh28TwJ2i4zdFbfV5EZt849EYdPK+zIwL1DFAPWQczyUN55xc7uZY6rfV89h1+Ob
 CSDhNqc+SobNWt5B+g0c0NhIXdr3ElDibHtNwfaZJ4rpH+1YWWTp8GpnQVODCum1ul1C
 szWeTCGagX8c7uPoZhmDHDdgxzs/8Z+mrk0P7zthbYFqeYrCraMQgDqHJbBBN5Vq1pai
 oNLABShnAmXWhHNE8wp2E7hcxz+mFVxX8hTeuBPg54cXOHYDJUz3wei3BXYmNGKpGo4C
 0bXohcl55ek+wAzHm0KDPKZtNJaK0iWmDi/3zyQpVZgTyniyFMDbwKyJdkGkD4yE7X1q
 fqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753995239; x=1754600039;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZIAkqrIOgetL8HzndJ6YdKjNn1VZNvytvE3me8fVVdU=;
 b=Nu9r8ma+Mn9Q106iWiZvKxMuQ7GmmhdTUldHLBswgsGxr6WzT10VRcf12xUGT7+UEi
 74tU+njknLSN7bDqNFxc29tToQ60qYISb4mPft/8OBFpbzaFUtfpSzvDrlsJX7UDo/qQ
 vlDEj6c5TnnmLcxUDSTwWsCkYeZvUzrnt197o7ek56DZT/jhA5ZAaV5UMuR/3Iql/KiQ
 H81o4xD1+vOuabXlM4na/LS8/eVyec7OuBI8W2Y5S4ynzn4bH497djFZyiM2MdoFStYx
 W7EGIE+c3pw9MuVdGXRDK4MZJ3So8Cyi7A2vwVqSQtcUp2sG+1ISPhgGxQeRT0M162OJ
 7gYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWegpEDffjw1JFGwB0vcbYzOgFPRBUMRo+OBdYSbXEHIqcED8ayD1X3QlxQXvfBoIxSeMwJdC/qVO6F@nongnu.org
X-Gm-Message-State: AOJu0Yytm8q5T/9erhAUE4IVX+rpqnqCtM+eYgJ7zBqepXvs03iGip/a
 kM1fUP3Q3kMEy2YWIvlR+nTBjn8L1bKqAEqdBy2PecCZRBvs9iQJ0zrd+fEv7xA4Ang=
X-Gm-Gg: ASbGncuXgm+HpXjJlbvdxxoO0w+QttO2mneWsVqUX/tXeQ1qHN02pWeADjLhrTTpVNP
 BakuiAxw+iMhak66pqB3Y+9j+ArxSRfnI5oPVgtsBZ56MkVOdZ4S5id/G0ovUN21mmugovFnS6p
 RCROv+zyqI75OQV3C3HshYjT6FkPvoWfUVedxoMkFSA+r0/K+YYk7ELDZmoUOmhYH/S77pVnFPG
 i3qpnZ7SOnN3q1Nr15SjLSk9phzz3NG9/FxGI5IhhHeXkBZxmOUMMn/LE2SUQj1q5yimnggAHUt
 NItJjjBwiSbJegqgOVbs/M7OB1tOGqGUxWZFZR07Cg71PpLgNfCaAEJb4UQne54TtcghPPcaVup
 PLKPBv1SYv8XqOe4HqVBctaIZe8O6nEJ+xQkzG7yjTflxNQ==
X-Google-Smtp-Source: AGHT+IEYnYC3wPR+qqWw5QraVT14e1aMse5S92uIcqEJ5GJ13cChCaH9mldqnkN0euGMxxwIJryckw==
X-Received: by 2002:a05:6a20:938e:b0:23d:798b:d290 with SMTP id
 adf61e73a8af0-23de81a36e9mr18688637.29.1753995239114; 
 Thu, 31 Jul 2025 13:53:59 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b422b785696sm2031156a12.9.2025.07.31.13.53.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 13:53:58 -0700 (PDT)
Message-ID: <353d73b8-b6c4-410d-819d-5890e01810ce@linaro.org>
Date: Thu, 31 Jul 2025 13:53:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 49/82] target/arm: Implement EXLOCKException for ELR_ELx
 and SPSR_ELx
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-50-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-50-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> If PSTATE.EXLOCK is set, and the GCS EXLOCK enable bit is set,
> and nested virt is in the appropriate state, then we need to
> raise an EXLOCK exception.
> 
> Since PSTATE.EXLOCK cannot be set without GCS being present
> and enabled, no explicit check for GCS is required.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpregs.h        |  3 ++
>   target/arm/cpu.h           |  1 +
>   target/arm/helper.c        | 83 +++++++++++++++++++++++++++++++++++---
>   target/arm/tcg/op_helper.c |  4 ++
>   4 files changed, 85 insertions(+), 6 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


