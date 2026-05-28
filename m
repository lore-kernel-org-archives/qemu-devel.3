Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2088CD6E45
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 19:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSgoE-00080w-2x; Thu, 28 May 2026 15:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSgo9-0007zy-5w
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:54:21 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSgo7-0001tc-Ie
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:54:20 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c855599a77aso1112278a12.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 12:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779998058; x=1780602858; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XBuSsHiEHgYnWgeNK9Jy+biU6DBsZhKV8neRcmnLcmw=;
 b=ZfSwlDljHJRHyeCFOMgCYoui/+mge41AbvuenqJTTabBUb9jNy/ZfrP1R3voFPuMmt
 rfe9JK5HWJJVaEOXYoxJxN3Olo9Txk7fbkCmcFbsk/Aqr8Dn6xBbfTfI7AzzxCJdoEMs
 06O9BiaOl4XT+jFB7FytwEJXjHQ1otmAYqJUvKn1VtIADLIOyD/VHaxBJA3kQEGG4TSK
 KIAVLjuq+4+5SQJIr5l6wuvchZeRJd8kD0astbMKDlJWwBtZck+P9FtO7tzyrzFJh3sf
 mst9Nq58QA0nFhW5IUP8zX0rU4gOG23x8tjo6bMd4a2Ck9R1YSVu6z0OsrptFEEWb4uP
 05Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779998058; x=1780602858;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XBuSsHiEHgYnWgeNK9Jy+biU6DBsZhKV8neRcmnLcmw=;
 b=FX6+H+lPWTdaHN1d2gYK5qns3h+Enzk4kqTrF69dIVKxnLB88O1niH0E2v34g9+d9g
 xKm7EUHULcW0eHmHXwo1zHTgOxFK5nxJ0/ouTxE+8jkcELYyEY2m0DkeyGh7Fjw6+hO0
 pkA2V8qEwVVI+ktuXZ+DrgTOJKwqHQWJ5zygVsM6+beqfzEof5cBNMuQNqvHA5M3v0Jq
 xLSI5zANRpVZJfWMrv8cAf+ett/uef7vHrATCOntug8V+0BjbpsH/0sT2/37mehWSE0A
 OEYMXF3weAG1pu18vd5k1OheFTth7fw314UUueT8kswMmrb1eVR2j+3gldkwKXsVGoVE
 9O7A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8IIv6zVQYIpHbISphxOMlGOb/9Ss8kt53Ze9MRyxQVNWwEBEX/SfOaxjkXxehWBCEWIPXHYxzbyMYr@nongnu.org
X-Gm-Message-State: AOJu0Yx98OE/ipZ9Om5WBLmMLL7DEwWg9DhUbq6X00jMcqJk4/4Do++0
 a0S/eT1LqfX80rDUInQUxp4hOTU9rYHZK1t5nJP0yMfhNK1h2VGvK3UUwOubsSKh2Eo=
X-Gm-Gg: Acq92OGSUuh3jqbO38pouWwbVFUSEAQW/bUYWc6Cg1F8fL8XpNkih4nzNmKokOCk/ts
 40boNFi+6dDMEx/LaNHs0GGSJJPg+rDpXQ321zkYg+00/MaL8ZUo+dvakmAFgHK+fiqaeOEDxm/
 TF+eAhDCXZC4zINOY5VNZIE0f5dy3rDhTF+eX9/WrlwEqAnZ1lcO0AEouHhOnujw0wGx2OJEvSj
 B5aQSPcxk1zaaTqvCSDkAP7QfWcnAn/vNUQ51oszqOOcg3bi8BjR1iFnoiZ2KF2RdTPu6GpeCN9
 bPUWmtz2qKsxlrb01hKy0qdZMDVpAYlXQc24R/YYL/3j5hcrzHJUo1Gbs32JH8TXUAVWcK2hT3m
 Cs5rxnmCgvP6MQaSJIJp0aNQaakLebE7Nw0w7ycg4WS8kCFyWnWPblwzTRDEa+zROxnuPKz7amx
 vZmrZbECDQKsPr8+dD9OIpNrNA8aO3wWq2hTpokpVBRI8xwn4=
X-Received: by 2002:a05:6300:2293:b0:3a3:90d8:fd7f with SMTP id
 adf61e73a8af0-3b40e2e8f2fmr219851637.8.1779998057738; 
 Thu, 28 May 2026 12:54:17 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8573062c4fsm88729a12.22.2026.05.28.12.54.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 12:54:17 -0700 (PDT)
Message-ID: <5eae07fe-f397-472a-8a49-346471d27d3c@linaro.org>
Date: Thu, 28 May 2026 12:54:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] target/arm: implement FEAT_RNG_TRAP for RNDR/RNDRRS
To: Jason Wright <wrigjl@proton.me>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20260519153249.31100-1-wrigjl@proton.me>
 <20260524002617.69593-1-wrigjl@proton.me>
 <20260528181857.92087-1-wrigjl@proton.me>
 <20260528181857.92087-2-wrigjl@proton.me>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260528181857.92087-2-wrigjl@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 5/28/26 11:19, Jason Wright wrote:
> Add an .accessfn to the RNDR and RNDRRS system registers that traps
> reads to EL3 when SCR_EL3.TRNDR is set, as required by FEAT_RNG_TRAP.
> Mark SCR_EL3.TRNDR (bit 40) as a writable field in scr_write() when
> the CPU advertises the feature. The pseudocode in DDI0487 revision M.b
> shows the trap firing from EL0, EL1, EL2, and EL3, so there is no
> check of arm_current_el().
> 
> When FEAT_RNG_TRAP is implemented without FEAT_RNG, an RNDR/RNDRRS read
> with SCR_EL3.TRNDR=0 should UNDEF rather than succeed; handle that case
> in access_rndr(). Register the rndr_reginfo CP reg entries whenever either
> FEAT_RNG or FEAT_RNG_TRAP is implemented, so the accessfn fires even on a
> FEAT_RNG_TRAP-only CPU.
> 
> When SCR_EL3.TRNDR is set, ID_AA64ISAR0_EL1.RNDR reads as 1 regardless
> of whether FEAT_RNG is implemented; give ID_AA64ISAR0_EL1 a readfn so it
> reports this at runtime, as we already do for ID_AA64PFR0_EL1.
> 
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Suggested-by: Peter Maydell<peter.maydell@linaro.org>
> Signed-off-by: Jason Wright<wrigjl@proton.me>
> ---
>   target/arm/cpu-features.h |  5 ++++
>   target/arm/helper.c       | 58 +++++++++++++++++++++++++++++++++++----
>   2 files changed, 58 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

