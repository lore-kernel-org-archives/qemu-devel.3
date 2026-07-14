Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E05C44501
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 14:37:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjeG3-0006Lp-2X; Tue, 14 Jul 2026 10:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wjeG0-0006LL-JI
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 10:37:12 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wjeFx-0006CJ-EA
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 10:37:11 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-38dd55ad76cso791593a91.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 07:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784039827; x=1784644627; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tL5FWT+1l3XDdM5rt0ZW1QNmGgGxdSRMzn/Q9zeEy3A=;
 b=Q60Uuf14koAKVsuwYQ5jv23Nbcw9p6ZpfJF2GFRLYMboJzLZsExn8ReNZHOgvoqXCf
 34Nc0ubFygYfRyvB4PKhYZG/Y/ivxssLbttpZc4nlmK0Vy3vZbAmzDfDyZ+hPq1qOoN/
 CEeAVX+kzfpopWEPW1+Yddlre2aX6WdEiYmvpkDBQxuRo+HhRcKxNWquvU67Tb6JSbBo
 qASNp1jp0z7Wp6sq7pw3hVKD0yMbRNYeujJdd50/Qd/0N4lZ9KGNkYcVLsqy0bfwUSct
 r4SMIpzB+A68xzH2dTDvIOZ+No+qtcTLPPXWXHGJwr/ZSjOXRei9BBmyaBwoZKCzKnn+
 OQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784039827; x=1784644627;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tL5FWT+1l3XDdM5rt0ZW1QNmGgGxdSRMzn/Q9zeEy3A=;
 b=QEon1tSbxDHFKwPGf8IcZossG/H3vMjTZa68RjfHY2HFMy6r0JSD8F4FBu+VKHBK18
 zh9/NLXmMRmRQqQM+rJdUo1BdfBosW1KsifpbGIr1uvTW9uGJuA2LFCKr4XxUyfn0vNF
 Kl7pw+Di9MrkODpGi5sZe/I8kanaSJjE8tSm8iVCxkzNCStDIeH9mcpzT4x409Co8cQb
 Ies3q6Qs6FSTK3RdQoidwHYtxo/5oYGI8L1XUHELilLzzTKdDstL5f8xHM8z5oO8gw4g
 9aHVgVhWZwyryd9hYPw9a22n1C9r0PhVJ/V5ZwarFfTvm8A94gO3GL3t2sXUXeNfNzS5
 TqYw==
X-Gm-Message-State: AOJu0YySIuvqfova3sI2y7KmI1/Mhd69Ht20rb5TJ0anQ/JpEnAMbsxz
 e/Gb4gT+uVk6x4kjGNiDLttkernsHWl7+brT/ATYEThVojSs0xAYceJxCuDsBm6dylodRn/mVBu
 6Wh70
X-Gm-Gg: AfdE7cmIAju3JCgwAaAnU9H7N8JdimGvo7HUArAbXLQ0DCpUxuYf1lZvnnptl5KXU4K
 POBZz6TtX30L5RK3QkiQxRqBTtkSrIMq41fHSbnPx6oRkRvh1jbxa6WiYMt0J84Ac9HofS2KXke
 3uYUhmay/IY7CFPWX4XJRB9Pla43ZFPkgyqS8h0dQ1Oc9SZKBbyQ3xrfv4DptYA0/EeS7xGK0G3
 MTpcPj3UDdXeVDWD9KhkckpMZS+3XN0sVnMv5Cgvsd6r/KWp+iMSaY7Ffe2OK+Urvwz/9944udd
 DKKKfVfIbjvGTEV+lZGGlxip6RcaIYJOxdJtGxvFSvHbDc9MKHWp6+KKLFsd/lcQrgYZGNJKJ6M
 Uo+Ykf/KW49Ph/fMAZbV6NfhaUIlWzXFFxELkqi4s/deAmFP85iTw8lGA1l4ccfOhtA3sJrCC0n
 9yyF3qz1w6XfzVoDNzlLZxYtPHig==
X-Received: by 2002:a17:90b:35c9:b0:380:8bb9:aba9 with SMTP id
 98e67ed59e1d1-38d13767fa7mr18146882a91.3.1784039827429; 
 Tue, 14 Jul 2026 07:37:07 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.146.49])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38e172dc530sm1602518a91.8.2026.07.14.07.37.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 07:37:06 -0700 (PDT)
Message-ID: <42e2bce6-199c-4f71-95b8-67c8ee7df466@linaro.org>
Date: Tue, 14 Jul 2026 07:37:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/arm: GICv5 cpuif: gicr_cdia_read() ppibit
 should be 64 bits
To: qemu-devel@nongnu.org
References: <20260714091806.3568281-1-peter.maydell@linaro.org>
 <20260714091806.3568281-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260714091806.3568281-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 7/14/26 02:18, Peter Maydell wrote:
> In gicr_cdia_read() we turn a PPI interrupt ID into a register
> index and a bit mask with a 1 for the bit we want to change:
> 
>          ppireg = id / 64;
>          ppibit = 1ULL << (id % 64);
> 
> However, we used the wrong type for ppibit, making it a uint32_t.  If
> 'id' is too large we'll shift off the end, so we won't ever update
> the state of PPIs with indexes above 31.
> 
> This didn't have any visible effects because the currently allocated
> architected PPIs are indexes 0..31, so you'd only see this if for
> some reason a guest was manually marking as pending a PPI in 32..63.
> 
> Fix the type of ppibit to the intended 64 bit width.
> 
> Fixes: 3f79212abae89 ("target/arm: GICv5 cpuif: Implement GICR CDIA command")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/gicv5-cpuif.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

