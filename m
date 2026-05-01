Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A92DCD3424
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 09:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIkci-0004sn-Nk; Fri, 01 May 2026 05:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIkch-0004sY-0V
 for qemu-devel@nongnu.org; Fri, 01 May 2026 05:57:27 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIkcf-0001GT-2W
 for qemu-devel@nongnu.org; Fri, 01 May 2026 05:57:26 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2b2429f98d0so10324085ad.2
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 02:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777629443; x=1778234243; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M53zaaezspq9ZCsNV7lBKWBaZetG414KB3W2v7/BPbc=;
 b=zVaD4oEi5LiA2Syad2AYGRlvDxadF/yLWPgxUl253NsogjtloKkWVbItzSuiJBY1Co
 rTU6akBXFqJtW9VALdMDyZ3vG59CKyRkL8Y2yLi2WDj1DukGkbsxV681EiQ0fh/N6bf/
 dw2qS6HElnlqjPRlU6tHSyhNp84FiXjzpuNEz5l04B9i6Sv7CnvDNDasfQvLn0eTGQz9
 EnLHERlumgjqlA0+omSZ81cbyn4dmGTmX/Eg0RUYwt/gZZPs16fDZRxkROTy5bgYaAdO
 N+p9vFGSBev1JMm1zU41kyNd+3/tIBHa/Q0f1FnuJJlZA2y+t9bc0lce3AeVOJui9XwP
 rwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777629443; x=1778234243;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M53zaaezspq9ZCsNV7lBKWBaZetG414KB3W2v7/BPbc=;
 b=KaHu2AUD4POr3dozzSOTIvAh06chKYBAsn38/nVQf4GHuh9udLylU7+rXgj0tL0D17
 +frfwjNok8avgIBJpBYzI0CkEvFp2egxwA2KtpNlgym79gG4YF5N2GcPof33dv/7tA2E
 E4dztzCckObKlD11DAog5xMr7h2IEkAdMa0fyRyrqe+wwHWwA1bW9S8cbeX4GJpeNAai
 91640yQNZFoFYP3fYdvSwiNyxaOpuBKjco9ATAq5muJLsnN/U21XTCGW4Xqs4H6jT9oG
 iYo4320rnk4PPQ1Fge30KkQNq8Yd47Nfim9ujOMT8i8sPknxgeWYLr+DP8SIIED+8UjW
 13TA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+4NKtNQRcyr4DzNXNzsk5Mi5bG19keyC+PlbTvwMHiENjKsV7btprhthnz/ZBQ+/iTjTLSlsXYLZUQ@nongnu.org
X-Gm-Message-State: AOJu0YywLFxEObGeZfjDThV4dLF24Ii6xOBB/SyCKJTRApYqv1oMzpAX
 pTyCAQxE7C/yzhAfhNvhIE7IZQWwYKtX/lBOXEmMWpeCzjkk/+0GHndYVLcRZYVZvrpwinapRYH
 3a4IeJRQ=
X-Gm-Gg: AeBDieu6faF0J/lqdW1xAak3K4D62pu9hRM4HTkSeMCzYdhzzyq2BftHuwpUYoFI+KF
 Zv2RG2z4KBjfL6fcMODXWii6z/9od/4Px9U8JzNzIuja7Niz9Gxpfp0BBDQrM6tst/+YfSILNTD
 rRHedPHGMJzpKKXcI/SoxEakX/BqysTQ0SnX1EqmKiniYbLCWEXUt6qLUNXq5x+9Ve++LHHRrW+
 wuqxoLu6rpRKHFsXIPgB7tmcJejOiS2Fr73DpIIy4rtohj+dNg1aVRIcpSWI+76MPXDAEBrsOxs
 NblSj9Mj3j4728NEOQ/jZeRNQqwHb2ulAZNtEF3EU1qvJ6j07hvi56rcFhpgR54n7cDaPc5iC9T
 a3zLaJauOE3+xWoHNM3CzIZJtBmcjqbolR71KbeU6YYMb8M8TpxPKrH4NaJ05xIkmKDoM4RcODb
 R2RAoThbGEJSFRWra1QCASwdzhpTdsPTP46eco990A3pMTAzH6jqqTADwuxL65ihg=
X-Received: by 2002:a17:902:d50d:b0:2b0:7026:24c2 with SMTP id
 d9443c01a7336-2b9a2508467mr70834815ad.36.1777629442836; 
 Fri, 01 May 2026 02:57:22 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b9cae4aae5sm19053595ad.66.2026.05.01.02.57.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2026 02:57:22 -0700 (PDT)
Message-ID: <570055d0-18a4-45a1-bfd2-c3af6b4d4e4b@linaro.org>
Date: Fri, 1 May 2026 19:57:18 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/25] target/arm: Implement translate_for_debug
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
 <20260430093810.2762539-18-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260430093810.2762539-18-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 4/30/26 19:38, Peter Maydell wrote:
> Implement the translate_for_debug method instead of the
> get_phys_addr_attrs_debug one.  This allows us to pass the caller the
> lg_page_size from our internal GetPhysAddrResult struct.
> 
> Awkwardly, translate_for_debug's "true on success" convention
> is the opposite of the one we use internally in ptw.c, so
> we have to be careful about the sense of the return values.
> This corresponds to the way that arm_cpu_tlb_fill_align()
> also has to return true when get_phys_addr() returns false.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Message-id:20260417173105.1648172-17-peter.maydell@linaro.org
> ---
> v1->v2: use 'fault' for the bool variable, not 'ret'
> ---
>   target/arm/cpu.c       |  2 +-
>   target/arm/cpu.h       |  3 ---
>   target/arm/internals.h |  4 ++++
>   target/arm/ptw.c       | 39 +++++++++++++++++++++++----------------
>   4 files changed, 28 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

