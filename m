Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B2DC2A072
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 04:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vccCA-0007na-3x; Sun, 04 Jan 2026 23:27:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vccC8-0007mz-V9
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 23:27:52 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vccC6-0006g9-N6
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 23:27:52 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a0833b5aeeso184505425ad.1
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 20:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767587269; x=1768192069; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lL2w4pgghzqy1pf9FWqDLtBIDaM+nRomP4bF3pICVSU=;
 b=Lkxw/afxrs7kkW9B0EARBwFVEiMwDbgK2A3Sw4I4Vd7wKb08e+ylS2XSYjmy9s5Kig
 7cC2zgrZl+2392xfI5jq0YCCV6JOLSIaOOPUdwKivEaAAoJdaYeftNsoAcdFMta0SMYn
 ZfbgB+KsF1KL/6WituLAjZjbpTzCbKevTXjruuu0Po1QpMSioJoPu4q2/EN2fGQ57BEx
 bcpIgmRmNKw2o7pe/p+iVxJ2xr73WswFuDk4pMO7vnMj4B38dYYtCmiEvGHY55fJ/dgm
 xMNdLj6zCWOs70zGl413Tib2d2zHIkUvJ9QBHk3UJJhJb3rS7CYB6ySR4sxVvLAilNW6
 Q09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767587269; x=1768192069;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lL2w4pgghzqy1pf9FWqDLtBIDaM+nRomP4bF3pICVSU=;
 b=ZIFeTHtsxUEizeifUrDRUxkIU6xWAjlHREAne1jWC44rAus9lhZ04c+g5mB/BH0w+a
 XuYLFIN4SBvLSzs/5LyWHVh0OyYk9n9lP/jAXjCBNmcR99LfsrmCbtokT8zFYys14xVo
 BTMsiDy+Aq6GS6WqQsG7dQpvRCMBI+VfGyvDeVrNl560UFJwhxoM/OO+y6ZRWioAbsUF
 qDj+EPo/QK5T1dEXGRVO54nxNKjCv4mfr3iLH5HasuctpHgpDO5XEIS7eyqfU0U7pZaz
 B7pdu99h1VoCVZ0ZK/hz9ht5gPjxysrEqFwXeGoDhmCbqgu2Zi3N+tBcaxtjOQ02cnWt
 xO8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3vWq4G3p60ZNO7eWfhKq2KvwHJfTJY8MXlUwqv8CYiAYGh3LvzncU7XSVwY0rrvohB8Gc/BU2GY4r@nongnu.org
X-Gm-Message-State: AOJu0YzVoxpHcyJlGA2DKUXcwH4M3jmVq2b3ntKl1OYgBG6N1kq5o9pr
 RL4+CczyBilwuwlEqBUaFyiWG5mHZ/4BUWHHe7L/k2h8ah3XaGrdlm/n3qICEyVJ+gU=
X-Gm-Gg: AY/fxX59/oWTTk3J5J2ghC3heCHlQEAKxK3UoefxzUUYWTPjLlmeqdM1GGkvqlVf384
 S3TBgkd6OqLRKPNB2KEGWhwPFzGILV1UDv16VnK4KLNPYwKUxUsC/sByNHwla1SbT6DNlPM2mio
 w2DwPAHHl/2RhuzYz7XvXMR/L6uQswTCJSrFvbg7O9FVYGgDyTwhHywZKxYTgwMkZmSF8LnnG75
 iYpCG8/ZZ4hHWLzNbilX38LJ8ueFUOQ9xrXIouk1RXm6cTXSDYf8t2qQ7iRevihDzdHWHqy2dch
 gnk75VPmyaaCNLbjUcjKNWgT2bO8pmGLPSNnJDkOUOzpLUF76+GowgIFXEJtRoQNW8e2tEMvq/i
 oHbXYm84Et0IG+OrBTp+haEeAEW2MncdNdVkwd1W46guedMTUymIt9jNgmr2J7BBv+VFZC74zi7
 IGeiRjXFt3i+3hNSPh5fzZ0R6HisNqYg==
X-Google-Smtp-Source: AGHT+IGR454Vi4tyBqUoMBpmO72jRDqL3EtPtVUZV/RJG7xo7SF7Buo7G6EiLQygLXMOiV9h47XhcQ==
X-Received: by 2002:a17:903:1207:b0:26c:2e56:ec27 with SMTP id
 d9443c01a7336-2a2f222b5d3mr494012865ad.19.1767587268734; 
 Sun, 04 Jan 2026 20:27:48 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c82858sm432784745ad.29.2026.01.04.20.27.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 20:27:48 -0800 (PST)
Message-ID: <1694cd13-981f-4e3d-8651-8ad788279991@linaro.org>
Date: Mon, 5 Jan 2026 15:27:43 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] target/arm: Correctly honour HCR.TID3 for v7A cores
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20251231170858.254594-1-peter.maydell@linaro.org>
 <20251231170858.254594-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251231170858.254594-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 1/1/26 04:08, Peter Maydell wrote:
> The HCR.TID3 bit defines that we should trap to the hypervisor for
> reads to a collection of ID registers. Different architecture versions
> have defined this differently:
> 
>   * v7A has a set of ID regs that definitely must trap:
>      - ID_PFR{0,1}, ID_DFR0, ID_AFR0, ID_MMFR{0,1,2,3},
>        ID_ISAR{0,1,2,3,4,5}, MVFR{0,1}
>     and somewhat vaguely says that "there is no requirement"
>     to trap for registers that are reserved in the ID reg space
>     (i.e. which RAZ and might be used for new ID regs in future)
>   * v8A adds to this list:
>      - ID_PFR2 and MVFR2 must trap
>      - ID_MMFR4, ID_MMFR5, ID_ISAR6, ID_DFR1 and reserved registers
>        in the ID reg space must trap if FEAT_FGT is implemented,
>        and it is IMPDEF if they trap if FEAT_FGT is not implemented
> 
> In QEMU we seem to have attempted to implement this distinction
> (taking the "we do trap" IMPDEF choice if no FEAT_FGT), with
> access_aa64_tid3() always trapping on TID3 and access_aa32_tid3()
> trapping only if ARM_FEATURE_V8 is set.  However, we didn't apply
> these to the right set of registers: we use access_aa32_tid3() on all
> the 32-bit ID registers*except* ID_PFR2, ID_DFR1, ID_MMFR5 and the
> RES0 space, which means that for a v7 CPU we don't trap on a lot of
> registers that we should trap on, and we do trap on various things
> that the v7A Arm ARM says there is "no requirement" to trap on.
> 
> Straighten this out by naming the access functions more clearly for
> their purpose, and documenting this: access_v7_tid3() is only for the
> fixed set of ID registers that v7A traps on HCR.TID3, and
> access_tid3() is for any others, including the reserved encoding
> spaces and any new registers we add in future.
> 
> AArch32 MVFR2 access is handled differently, in check_hcr_el2_trap;
> there we already do not trap on TID3 on v7A cores (where MVFR2
> doesn't exist), because we in the code-generation function we UNDEF
> if ARM_FEATURE_V8 is not set, without generating code to call
> check_hcr_el2_trap.
> 
> This bug was causing a problem for Xen which (after a recent change
> to Xen) expects to be able to trap ID_PFR0 on a Cortex-A15.
> 
> The result of these changes is that our v8A behaviour remains
> the same, and on v7A we now trap the registers the Arm ARM definitely
> requires us to trap, and don't trap the reserved space that "there is
> no requirement" to trap.
> 
> Cc:qemu-stable@nongnu.org
> Fixes: 6a4ef4e5d1084c ("target/arm: Honor HCR_EL2.TID3 trapping requirements")
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 146 ++++++++++++++++++++++++--------------------
>   1 file changed, 81 insertions(+), 65 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

