Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97A4C83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 14:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueEEW-00067P-2d; Tue, 22 Jul 2025 10:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ueEDY-0005lc-11
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 10:43:51 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ueEDW-0003Jn-1d
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 10:43:43 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-235f9ea8d08so47618725ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 07:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753195419; x=1753800219; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aQOUnN1xucPPtCCqpuR2gyqjS5+FDrqZMoOVX0YnoYs=;
 b=oN6cXmouP/xJGrhl6UIZThsBtQy20naPYN2F9NjdDFcN1F7UUt/Nj5fJa5UdePdKlA
 gvDRi5563n6uJZC1XFpg/qbAnuFQFmLONLN3oHhay2/C6uJZyreyduTQElGM8DN5HI9E
 fUe7Os7S8krIbsMuUhha5mzU87Tu/mtL+R9ED2tHs7XmGGendX9e/g6fWEGQcrr95SU1
 R/NLD7qrkaE7aplVWT2sH3P6YfdPBwRJFr4BOL7hj/oPngy2HAG4wClEA16PIybQII/1
 avOzOWM2t0yKz6kUj7NOj1gF1n+05D/Y0D7rpFBxmaOYyyH3KV5Ibj5cH2NANgcwpsXB
 qE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753195419; x=1753800219;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aQOUnN1xucPPtCCqpuR2gyqjS5+FDrqZMoOVX0YnoYs=;
 b=WS2KdZjw6tfcHL6iZn56hVlBfL6kLx9bWPqvDrihh+nSoN/8byDluvU7G+9TKyHoMy
 U0XLXlGvEN/awlJ0k7yn8+ULMfo3oJ9JtRf0EJYC8ytFDjm6CNPp2c6CSPet26jICbqV
 VOCHObEZAzL77fKSifciwrv39EkFrKv08xcJiIMDpp6aeunzUIpKoK4GJh5jmTT4TeVc
 v4jmmpHRNYvvx2olVliDrYewhD9h5sSG5enUKlr8NfcUOEmqAsMU+4lypkP6KTuvucEk
 Emp99fWzbAk+K2/3RAlwz2C2qZyB5+cLIv6nFcCTyXFDjaP1QG96YE6MriBIZMO6UDzW
 kjlQ==
X-Gm-Message-State: AOJu0YzYs75VrcvyYIUiQ9Y2LtZH0XsRPjp+mUctlXNNVbWofA2Op1Yl
 xs5sA5/n2ndyaJXLJ2C/5Cuh1bHudUeOeahWiJnOT0Rd2ZNoBj4vWsw5RfvY2hl6nuCer3xB3+6
 eBJqd
X-Gm-Gg: ASbGnctByWglFkjQtxdbFobAdbXbgGllwVGIUglESi8grx9+PNLrHkC7vifjjuO7oeQ
 4eIpbESFamiORJ1nFQ7c5luLLOL9iFZyYCaAmqGvH2xxVyu4phaKVevgU8fbfwt+XIxZwfqHCuj
 veVKV29VJ6+nwhBtltuphffytgHwKgFyOxsXA25adoxXTfM2kqPxYAAZOxlGJvgC9NcucFK4WPf
 Wz8XtjWZJk3B321jG70tItJIxPAhdxVQ6nuF51pmQx7UhONWxUWBJlxTk81cb+O/hL5TohnHHfR
 dnAoUy388Pg89//umBewgsw70Dyyoi0BdZbml4+dR2oOKNl+7nWCD/hnzN58+THX3uXYI7zE4da
 6OSt+orb1D8wag61zPEER6smI53VE7lGmSik6
X-Google-Smtp-Source: AGHT+IHFGrrIYlQTYMWsNLVtn7ZzrgkVQf9jBt9Z8WU5KYY1v47JgQz6rjjfaEcUNjSkAch0+xWx9w==
X-Received: by 2002:a17:902:cece:b0:22e:6cc6:cf77 with SMTP id
 d9443c01a7336-23e24f96140mr382879705ad.53.1753195418980; 
 Tue, 22 Jul 2025 07:43:38 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b6b55ebsm77976495ad.103.2025.07.22.07.43.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Jul 2025 07:43:38 -0700 (PDT)
Message-ID: <cb7d165e-8500-4833-9fb9-1db509cdf616@linaro.org>
Date: Tue, 22 Jul 2025 07:43:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: check for NULL before using
 interval_tree_iter_first result
To: qemu-devel@nongnu.org
References: <20250722101544.16366-1-gerben@altlinux.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250722101544.16366-1-gerben@altlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 7/22/25 03:15, gerben@altlinux.org wrote:
> From: Denis Rastyogin <gerben@altlinux.org>
> 
> interval_tree_iter_first() may return NULL if the interval tree is empty or invalid.
> Add a check for NULL before dereferencing the pointer to avoid potential crashes
> due to null pointer dereference in open_self_maps_2().
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
> ---
>   linux-user/syscall.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 91360a072c..d5d5912c96 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8172,6 +8172,9 @@ static int open_self_maps_2(void *opaque, vaddr guest_start,
>       while (1) {
>           IntervalTreeNode *n =
>               interval_tree_iter_first(d->host_maps, host_start, host_start);
> +        if (n == NULL) {
> +            return -1;
> +        }
>           MapInfo *mi = container_of(n, MapInfo, itree);
>           uintptr_t this_hlast = MIN(host_last, n->last);
>           target_ulong this_gend = h2g(this_hlast) + 1;

This will not return null.  Via our caller, we have already verified that there is guest 
memory present for the virtual address.  There *must* be host memory present to back it.


r~

