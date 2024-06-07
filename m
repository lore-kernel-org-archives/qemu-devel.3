Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05EE7C27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 23:49:50 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFbwe-00035U-Qj; Fri, 07 Jun 2024 11:56:01 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sFbwc-0002ls-5x
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 11:55:58 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sFbwa-0000Y0-GR
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 11:55:57 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2c2c9199568so478441a91.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2024 08:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717775754; x=1718380554; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dKQCez3uiZ4tZi33y7W79rxhO03X4Gur/OuJpi2G+uE=;
 b=eL8q1xrzhXo3wpV0KyOYKV+6jeUeWqRVOZSAVh5mLRmO22HctxthlpSf3XzRlxHBeH
 u77m02dZTNJQX8L1t55N0y0Zwl3kFKUZNCYpwnqZ3eEZC/zFqPcqlQLKJd3LiInXnMU0
 uuEeZxKpJQFXV303Z4bWdt9OFZ/iosS+4BirjIqkpQvIoSEZCXczVn/n39vWBlhXgjwI
 pp7sV/onisFzAAZ7CRZp3ObsvbX2/2VrEL4ZLuzx6nob8nCNYUuOIlw3I1aGr/sJARPf
 BEbIk2x8dhGlcDezwRc7aNaStquEF5zd9GFeKON93TyyeWqK5QJeodwtmuB7bliywl3s
 ydtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717775754; x=1718380554;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dKQCez3uiZ4tZi33y7W79rxhO03X4Gur/OuJpi2G+uE=;
 b=tfniNnq1E+64O7PbMvD3JxPg6A4gcq0dC9I9wW7H9Z3AZJZyHlrS+vSuOevEHKG7CN
 Y843Q0Yq6lFYcOUZ0sCXSLDovxHukeJ+1rA4ToV36mNVG01YZ1fatpjRPOKbCybHNB//
 Wt+ex7U0pCVIzBSn/SPFD3r3sgeA5wFr2f3pC0mKRWswOO+40oyCc9zSV3WHBVil1I3o
 DZln+hYUhlOtY9iY+KxJBhoN6H56rYPIJZhhUWscmSDQK16i2pUgdRI3iIq9cHWSOhT9
 mIk8LUcbehMeFk/OAvOxIIi3vk9TopwLQHkgNs2oc4/uRK75yRdFlIS5smjo7mZ8tYXM
 U3HA==
X-Gm-Message-State: AOJu0Yyjv9Z4+Zt0thPS7MRi5l70YrXK1h1g8yh4O5H1xZjvVI/DRu5n
 FGM4LvEyeprAnd8j1zBfKmE0VK3Vp0HFa8mERpgBb87mYwfGjN7pKo4xsBZcVW4=
X-Google-Smtp-Source: AGHT+IEd0Ng5CKsbZ5dM4kyaLiaPpkIn40S5dqdZO89e93ReEdkXKdycgT9qfUCnGsEPhYDtNty7UA==
X-Received: by 2002:a17:90b:3544:b0:2ae:6cc7:23d8 with SMTP id
 98e67ed59e1d1-2c2bd63ac7bmr2544956a91.41.1717775754451; 
 Fri, 07 Jun 2024 08:55:54 -0700 (PDT)
Received: from [192.168.223.227] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c29c4a54cesm3770824a91.57.2024.06.07.08.55.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jun 2024 08:55:54 -0700 (PDT)
Message-ID: <5419796e-f56f-49e6-8094-dd6795866c0b@linaro.org>
Date: Fri, 7 Jun 2024 08:55:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] target/ppc: Move VSX fp compare insns to decodetree.
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240607144921.726730-1-rathc@linux.ibm.com>
 <20240607144921.726730-5-rathc@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240607144921.726730-5-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 6/7/24 07:49, Chinmay Rath wrote:
> +static bool do_cmp(DisasContext *ctx, arg_XX3_rc *a,
> +            void (*helper)(TCGv_i32, TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_ptr))
> +{
> +    TCGv_i32 ignored;
> +    TCGv_ptr xt, xa, xb;
> +    REQUIRE_VSX(ctx);
> +    xt = gen_vsr_ptr(a->xt);
> +    xa = gen_vsr_ptr(a->xa);
> +    xb = gen_vsr_ptr(a->xb);
> +    if (a->rc) {
> +        helper(cpu_crf[6], tcg_env, xt, xa, xb);
> +    } else {
> +        ignored = tcg_temp_new_i32();
> +        helper(ignored, tcg_env, xt, xa, xb);
> +    }

Better to unify the helper call.  E.g.

     dest = a->rc ? cpu_crf[6] : tcg_temp_new_i32();
     helper(dest, ...)


Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

