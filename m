Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E55F1C02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 13:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc2be-0001dS-By; Sun, 26 Jan 2025 08:23:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2bd-0001dJ-7F
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:23:17 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2bb-0003DD-Cb
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:23:16 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21644aca3a0so83651945ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 05:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737897793; x=1738502593; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KwumAkPy8KbNrHWeclt649rP1a3XUrQ7amD69kEHbRo=;
 b=rnuxU6ZAtYRjKnzYtwf8juG65OrDs3YP607ukmEjSQHpiK98167Vroh2NOq2vbJfMd
 RMWrumwG5OaIRH1biFXj9hQkbDDvP/kMsIIybq+wBq0hbarg1PxpUhhbzbdqYeW5BX6+
 k2gZ5jHvhdCOFcAT/2VfwPPdVbYyQnJxy7u1iIQXmaB/rYUN7yG0Y3gtqCuaUXb8xozC
 pLVTMtwtaGEHL6pfdd4cv0gCKpNV9SWgAwa7Wnh0mxoHcKRKR2KAvBE3OAFuczzO0Bi8
 owX4xLQnyjzZAgUKmlAa0IglmWLJRwLtSu1BcLEMtLjOkb1E0vPMeAWsu4/0zVPwuWXB
 r+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737897793; x=1738502593;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KwumAkPy8KbNrHWeclt649rP1a3XUrQ7amD69kEHbRo=;
 b=cgk6qP8PHX3D+E5JnrjKlidEINJpwZAVsql7Ve06l0L29UvJ4Hx87shMf5sEE+Q5yF
 585PVJzIxijnwm0F/ToCiuec33pSJAq/5T5cvl7d4afL9NH9N5ZeX63+Z4NmaBLVYvto
 R2p6IAhvJxMR0WHMaIFSmCqySnSaffUgmKIX68ED3qGLinEZNw1OXrHUsMLyWbn5KZe5
 gMvmrIBeDmoDud2IoNn3/kr5cJlh3BRMFTGMnkz77uI/mOoE24xOt3Ry/2d04yDxlBdr
 vdLKPYAg5BPCnwx2CAiVSfWDM5q7+hBysPgUFRErLXbGc0I3lmgfiOanE4w+gSXEEfVH
 h31g==
X-Gm-Message-State: AOJu0Yxxtur6EDvH6+UQCZretipyYa4tbZgJbthTUqHmGeapV3fowJwx
 vjT3Ht7ZepXl2zrmw6v09nHS5AbDywt9/dDYUfmvex+TmMl1xQSNIdmxizf+Xcv3jSeUiEwvEdR
 Q
X-Gm-Gg: ASbGncuE4uDp7DJVKc3JTvZk688BH7lMZW3e0qf9wvN53gN/p/mQBDypi9qrFKm2Vum
 6WjPLnxUSUrKZVupAAQp8q7JoSge55aUCee2O1O2Ywhroa9tmKR9LoVcvdU65baF3Kl+T3A27CP
 yYkeLPq+Et88mJhJViCa6zqial6/YjLTXPif6DgOQDBKToUc2KVtvd+4kRcO/207L6zbMZfo7km
 i5dOAZqFpypu3I0J7UasG0t26BPtzu7dROFVLoOZDgcxUD20I5MKLWvKA2s394q8FFrcX/3xNfL
 3FGDe0/1vOO1QEMI/ZusOC8=
X-Google-Smtp-Source: AGHT+IE0DcLh7DDwQMkN58xwz1ZF0GcP/drdCK6VBNKjJvcNqfySA8iKkv9eATxdBvaATs6XOxDvog==
X-Received: by 2002:a17:903:2b07:b0:215:853d:38 with SMTP id
 d9443c01a7336-21c355615a9mr583224155ad.25.1737897793606; 
 Sun, 26 Jan 2025 05:23:13 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3d9c9f2sm45875795ad.42.2025.01.26.05.23.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 05:23:13 -0800 (PST)
Message-ID: <6eff6e85-db96-4cab-9611-cd6052791c77@linaro.org>
Date: Sun, 26 Jan 2025 05:23:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 69/76] target/arm: Plumb FEAT_RPRES frecpe and frsqrte
 through to new helper
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-70-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-70-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 1/24/25 08:28, Peter Maydell wrote:
> FEAT_RPRES implements an "increased precision" variant of the single
> precision FRECPE and FRSQRTE instructions from an 8 bit to a 12
> bit mantissa. This applies only when FPCR.AH == 1. Note that the
> halfprec and double versions of these insns retain the 8 bit
> precision regardless.
> 
> In this commit we add all the plumbing to make these instructions
> call a new helper function when the increased-precision is in
> effect. In the following commit we will provide the actual change
> in behaviour in the helpers.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpu-features.h      |  5 +++++
>   target/arm/helper.h            |  4 ++++
>   target/arm/tcg/translate-a64.c | 34 ++++++++++++++++++++++++++++++----
>   target/arm/tcg/translate-sve.c | 16 ++++++++++++++--
>   target/arm/tcg/vec_helper.c    |  2 ++
>   target/arm/vfp_helper.c        | 32 ++++++++++++++++++++++++++++++--
>   6 files changed, 85 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

