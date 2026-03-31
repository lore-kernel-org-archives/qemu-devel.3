Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D552109B468
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Z0p-0002ho-9y; Tue, 31 Mar 2026 09:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7Z0n-0002g8-LD
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:20:05 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7Z0k-0004dk-PN
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:20:05 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48540d21f7dso68739745e9.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 06:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774963201; x=1775568001; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vpZWb/Xr06j6y+c297zVddDxDkXuJByamNTk20R0bTE=;
 b=pSELSrxnL9FaHGeTnq0adAOu4e4aqLhZF4vXr/3vJ0OnH155etC3faCnZhERL+ZAFs
 +3gDp28/73gMri/La94t/DJoLVeQYSBwfrDqnrrDiWbPJbWcZzuYnxPMDO38+PmoD/T1
 PZLwnm9ojgPo/DR4Me9PfC6LwZVo2/jXGayFsI620wJtaIB1cOTwfYCdUl7dHnyC5sqL
 jPPpkjNFZGevB7VYu2T9bjJmpMzJJdx29C9uD+dwd5EAlDou/cnCroZeWpRKXsBgyDxA
 +juvyxBPI2yvFPoeZuZ4AmPaQmB/IWqJCCDYLiJR75yZGfhhMu+thH6MV6l2wCqVxBmw
 IrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774963201; x=1775568001;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vpZWb/Xr06j6y+c297zVddDxDkXuJByamNTk20R0bTE=;
 b=H4POZGQcL0rUf4BOSBrnQAf1SePVqUyTSw6Pec3gkvRwDmjsSN/Txvzom26RacRrII
 FgIE7QOwdFCxJPWabFGkiGLSu3bmXlli8vydDaLIjX3n+JHl50nYLHymUvwwDko/3HUy
 m+c7dMtrQwPlXUPK2EmtysTBqcjMppe1Ld5U77bBJaE0LgMdG3XwZlaVjpOwILWFUS02
 MrbHgBbuuGspps/en6a353yZor4cHSW8pUfgqlDBSS22wsipHZKkHdWL+sfNZyYhLy3M
 TkUK1ZL6hOegF9w7ugiXneXSCAPqkh1xLCKpTVogbozaeRe0AE6s8rB56aFaX8yhwlek
 7BZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjO8xGdbUL4JPpy1O58CuItUo2Gcd8JX/tZ0IyBlUkkxVsEJ/LeqlvBK9GLYlY/oPdQG0pSH/74n3F@nongnu.org
X-Gm-Message-State: AOJu0Yz8PJA52KBt7opSzgPl91TCSKxCIGcbXjPjGxihsjZDD4XAx3iK
 puKG6xlm3fm3sEhQsFzMwxcIYle1mFpclNJCENvVs9BvR+/VCdFvRIMI3jr50LX0M/EFEFF1Pj0
 E05KifAI=
X-Gm-Gg: ATEYQzwtuu4rtocHsURBLMsOc+tXne/w4mY6etQY0DcJAkvThq2on45DbPG+B0ODotY
 LLeDMptpIM+YYXOta8PjVCHtprOQiH+Fe/LcjJ+FWNuCPhiPo9fc+cRxBR73BIumfg+9Z0ypV9F
 8cpG/5p5BkwUZRxLjR8ZVri08gebBi/0uOylk2RlXtccMJkHeBlT3EjVnmYb4SoC003KcaeqgNE
 6yTgErDaS36YZyQiwqDbiO6J0Rb5L/KGyBhfsAxE0k0+jbH0nvZXZh8e4esrHmKx093jACJd4k0
 /JQiAKsIeyX56hdyPVm+zICcZ3T6irDkEGkovV9jEfZvHiqOuemX59PVEqKPkG8RiaKY1I/bDMd
 ++g/Chf/i5JrbJckCQleJk4Nr8w2DwAqZqQZqXVzejgu5NnpaAKDGrZCsvhcqfY61Ca96s4r4K0
 KMzos8uD6cfE6p+7+f9kIZ5xBnNttljI8yOgDfZ4uldm1qsbE5okUyyWv2MfuqV1WLGCUv
X-Received: by 2002:a05:600c:8b63:b0:482:f564:d613 with SMTP id
 5b1f17b1804b1-48727eafa46mr249847485e9.15.1774963200790; 
 Tue, 31 Mar 2026 06:20:00 -0700 (PDT)
Received: from [10.193.39.66] (43.149.216.82.rev.sfr.net. [82.216.149.43])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c8797ecsm33572065e9.8.2026.03.31.06.19.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 06:19:59 -0700 (PDT)
Message-ID: <16410351-5181-47ed-aac4-f3a90fe80568@linaro.org>
Date: Tue, 31 Mar 2026 15:19:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: do_ats_write(): avoid assertion when ptw
 failed
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20260331092305.2062580-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260331092305.2062580-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 31/3/26 11:23, Peter Maydell wrote:
> In do_ats_write() we try to assert that the cacheattrs from
> get_phys_addr_for_at() are in the form we expect:
> 
>      /*
>       * ATS operations only do S1 or S1+S2 translations, so we never
>       * have to deal with the ARMCacheAttrs format for S2 only.
>       */
>      assert(!res.cacheattrs.is_s2_format);
> 
> However, the GetPhysAddrResult struct documents that its fields are
> only valid when the page table walk succeeded.  For a two stage page
> table walk which fails during stage two, we will return early from
> get_phys_addr_twostage() and depending on the fault type the
> res.cacheattrs may have been initialized with the stage 2 cache attr
> information in stage 2 format.  In this case we will incorrectly
> assert here.
> 
> Fix the assertion to not look at the res fields if the lookup failed.
> 
> Note for stable backports: the do_ats_write() function is in
> target/arm/helper.c in older QEMU versions, but the change to the
> assert line is the same.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3328
> Fixes: 9f225e607f21 ("target/arm: Postpone interpretation of stage 2 descriptor attribute bits")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Not a regression, but it's a very safe fix, so this will probably
> get into 11.0.
> 
>   target/arm/tcg/cpregs-at.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

