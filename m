Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B848CC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 12:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzEeh-0005Bz-38; Mon, 31 Mar 2025 08:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzEee-0005Bk-JC
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 08:54:17 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzEec-0000ly-5o
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 08:54:15 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38f2f391864so2654635f8f.3
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 05:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743425652; x=1744030452; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gkiEEZMJm99j/mZOjo/cuNWyPY8AU+8kAzHuEAHfD/A=;
 b=V5zRtWsF/uxA8FrrK0phCQtXeGAmaEkHMls6QhX7ozGenom+WZGijNuE3eYGrV7KUH
 AltdNrrdg7IX+1Os9AHR4G8ZXz7kOea+RFFbovyA1hCAomJczWjSm/1qMbyz3Lui+bnT
 oL4dnrR1WVpxuyP4kja6ZCmL1uhs+o6lnfVueReHKclXq1rHywkDD+iyUxuKrrVp8pjz
 mUiqOoaEr/lelBT9f9gj1a4R0xO1HeB9ojYE9OUc0bNryz3AUe50MgbHPO1vVFavFB6q
 bwM7PO8BZzMvgJmsHWiO3aXY1Qlt2qbUtSSoDYXP2NOo23d/rhkfwDZgWbGwWKmEz1u1
 TKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743425652; x=1744030452;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gkiEEZMJm99j/mZOjo/cuNWyPY8AU+8kAzHuEAHfD/A=;
 b=vRjjB9hCXhvaPDjhSv2fuc4ud3ozrHrbC0LUKI8zyUDg4bbZgwpFG6QuCXQsnZdSfZ
 nJi15dE073S5BWHbZOvQy0gm7Bw20bt3PxG3DLuQGRuWJbPnmxkCRb7u9ZkkahguIX5h
 iCqyFMnssnalWlfoNDoqmJrsufMwPClWqqzwp8KuoO88uP6S3CtWGYHihPOfxEbx861h
 myVWWpd83cSMShvWrdmJ4Ug7IYgnMLvUy9skeGGDBZs7NR0myv80rwwdAXl+hJtaHH32
 G6K79RvY5BRHriMwWKitt5PcIHMY44AKhgDkcFsCwhY/BX5VLIu0SZGH25FsBqEDQGjE
 XnoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMThNeSLPn+i6FtWz7AiyLjN6X9w78+hsYpLxMJEmg1/3RUG0keR/aDg4TV1FmPPrMo/JjK9SN5iMZ@nongnu.org
X-Gm-Message-State: AOJu0YzQrZKY6/CWC2aWFOdNKgMrZkIK1vhD7EKj1VpsrGpv30+oF14q
 zl+JNelHtzoMyab8jVq8D5eBjJ7xJwR98KB+QeGtkGqw6SV6EOuB9cjwwpV7DiQ=
X-Gm-Gg: ASbGncsf9ooxUIcPhwqem62HR/7id7mVrKAhGIvwiNBnk5AcdfU/RA6V44ZuSLMCBs9
 4Gq8fsMn638VxkGS+TvQXUl0Ci9M7N4/S7Y8se+Mnfg6/kClexPD1A3XHSl9eOKKMrCjc8RuqYf
 u5qrm3N585AdIQ3G13MPT8dDGvNAwCWK1F0BlyXOproF+MWJTZ03kkaugpzMaAj2SJiCqjihjVF
 6E4Nue8wIxgM90xbE0wSQpDVBgn+PXM16WfBjSUfvFLsTsbU0ToLX/X44A/SwYDgFl032BCQw3Q
 fvZ+yW3vUgm70fHkOXBse6OFVccEab9bymu2eAslD29ejzHnfB21apupRtF+N1A35S8BnavuY4o
 bhHiIRu0MewWy
X-Google-Smtp-Source: AGHT+IGV1OWZYTOn6Uq7B23VgyczCx4kyTd4iuqJlQwJsrWLwVE8IfU145nSrcwYo4gPEcVEJ0Bnrg==
X-Received: by 2002:a05:6000:1789:b0:391:4999:778b with SMTP id
 ffacd0b85a97d-39c120e1bedmr7126015f8f.28.1743425652124; 
 Mon, 31 Mar 2025 05:54:12 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b65b4fcsm11425406f8f.11.2025.03.31.05.54.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 05:54:11 -0700 (PDT)
Message-ID: <9de1212d-966c-4cc5-ab11-843e6b40d8e9@linaro.org>
Date: Mon, 31 Mar 2025 14:54:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/mips: Simplify and fix update_pagemask
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: chenhuacai@kernel.org, jiaxun.yang@flygoat.com, arikalo@gmail.com
References: <20250328175526.368121-1-richard.henderson@linaro.org>
 <20250328175526.368121-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250328175526.368121-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 28/3/25 18:55, Richard Henderson wrote:
> When update_pagemask was split from helper_mtc0_pagemask,
> we failed to actually write to the new parameter but continue
> to write to env->CP0_PageMask.  Thus the use within
> page_table_walk_refill modifies cpu state and not the local
> variable as expected.
> 
> Simplify by renaming to compute_pagemask and returning the
> value directly.  No need for either env or pointer return.
> 
> Fixes: 074cfcb4dae ("target/mips: Implement hardware page table walker for MIPS32")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/mips/tcg/tcg-internal.h      |  2 +-
>   target/mips/tcg/system/cp0_helper.c | 10 +++++-----
>   target/mips/tcg/system/tlb_helper.c |  2 +-
>   3 files changed, 7 insertions(+), 7 deletions(-)


>   void helper_mtc0_pagegrain(CPUMIPSState *env, target_ulong arg1)
> diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
> index 123639fa18..df80301a41 100644
> --- a/target/mips/tcg/system/tlb_helper.c
> +++ b/target/mips/tcg/system/tlb_helper.c
> @@ -876,7 +876,7 @@ refill:
>           }
>       }
>       pw_pagemask = m >> TARGET_PAGE_BITS;
> -    update_pagemask(env, pw_pagemask << CP0PM_MASK, &pw_pagemask);
> +    pw_pagemask = compute_pagemask(pw_pagemask << CP0PM_MASK);

Nice catch.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


