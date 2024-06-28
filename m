Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C930AC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 16:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNEK8-0005zF-W5; Fri, 28 Jun 2024 12:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNEK6-0005yj-ID
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 12:19:42 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNEJq-0004KO-K9
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 12:19:42 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7163489149eso588607a12.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 09:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719591565; x=1720196365; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8jddPX1Sy3S0HIJO0eVbjQbtZ6XfvaPDC2EhC2uiiYc=;
 b=P4djWTqTvplgR0xYeWkwiuDZ9vH/dOe6EHYVNFEH8GGB8EOqREkSxpw1BGXoY0qWW6
 MKHxO+nS5gzCAMonojGOKqxCPdqx1g8wilKFpzmnWd1lFTmT1VpiKUAF9Ugb4qSUIAr9
 VkPdajbksl8MevhUdcvoY78y3saxGeMeyFrJWBa7aA7Y0OQBstkrzItvG44A7ud3nV4B
 SLvgpv6APPCZ8L8k1GmQ0avOYGvgB7SvpwrYqElnezksUO9Kmpl8hYqmxEwA624ChnMC
 Enjq+RbMvx1oGK6p4gt1U5xYlLsB4ec8fOmuXAsrA1Z1L8jo0RsrVctYGtOn9MigyHLY
 Tavw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719591565; x=1720196365;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8jddPX1Sy3S0HIJO0eVbjQbtZ6XfvaPDC2EhC2uiiYc=;
 b=VYruVVeADAuUkSn11waGDXwgy7H0dR5VgMA66WLxfE/7HHkIKsuqUXigciVl0TmktC
 l2qFXRFN3yFrAp7k5Up0sy5DOQYKevzXByj2VjpbtPeccp8Br615Ktdnkr78Qk3Be3d+
 zga2lMsC7Cm0W5IRQt8L86khgibUGzhc7mPufdRXtdGDVPWeMDSPWDos777FNtL3SToB
 eCzJSctjhPyyQ1j96tNE6/y3mMVRFi3kM/dvWW5aYTrXk4JgHTKBItQgGFJYOQ0Lp5KJ
 9hH/kn8znKFZOymXuhhh43j75Db38jnVayDWEQRDQP4zZGmGdpoRSYws+tLPOzvPguuc
 QL/Q==
X-Gm-Message-State: AOJu0YxCNSnitZfOIqoCxx3mPfwzpNAjbLkT9pb4U5XPvp0XTZIhj/ma
 XaQThuByss3HNPFiL6UrvptfEXgeWdUdHOBca8FDsIvhvToHUNyi399bsRx5bSQ=
X-Google-Smtp-Source: AGHT+IHO4QmYk+doRzsTwexhfSb397fo2jgYjWfUavOnox04lI/kdqK9cLdOTLwQlF7PITgBhkLlhw==
X-Received: by 2002:a05:6a20:3b27:b0:1be:c967:311d with SMTP id
 adf61e73a8af0-1bec9673319mr6982493637.35.1719591564650; 
 Fri, 28 Jun 2024 09:19:24 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70833fb4ee6sm1623371b3a.52.2024.06.28.09.19.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 09:19:24 -0700 (PDT)
Message-ID: <352a9155-206e-400b-a907-50d275f90a05@linaro.org>
Date: Fri, 28 Jun 2024 09:19:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util/cpuinfo-ppc: Add FreeBSD support
To: Brad Smith <brad@comstyle.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Warner Losh <imp@bsdimp.com>
References: <Zn4ZIYX0uxwHf3I-@humpty.home.comstyle.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <Zn4ZIYX0uxwHf3I-@humpty.home.comstyle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 6/27/24 19:00, Brad Smith wrote:
> util/cpuinfo-ppc: Add FreeBSD support
> 
> Signed-off-by: Brad Smith <brad@comstyle.com>
> ---
> With corrected sign-off.
> 
> Also this was based on the tcg-next branch.
> 
>   util/cpuinfo-ppc.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/util/cpuinfo-ppc.c b/util/cpuinfo-ppc.c
> index 47af55aa0c..0ad634b46f 100644
> --- a/util/cpuinfo-ppc.c
> +++ b/util/cpuinfo-ppc.c
> @@ -14,6 +14,11 @@
>   #  include "elf.h"
>   # endif
>   #endif
> +#ifdef __FreeBSD__
> +# include <machine/cpu.h>
> +# define PPC_FEATURE2_ARCH_3_1		0

I assume freebsd will eventually add this bit.
Perhaps better with ifndef?


r~

> +# define PPC_FEATURE2_VEC_CRYPTO	PPC_FEATURE2_HAS_VEC_CRYPTO
> +#endif
>   
>   unsigned cpuinfo;
>   
> @@ -28,7 +33,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
>   
>       info = CPUINFO_ALWAYS;
>   
> -#ifdef CONFIG_LINUX
> +#if defined(CONFIG_LINUX) || defined(__FreeBSD__)
>       unsigned long hwcap = qemu_getauxval(AT_HWCAP);
>       unsigned long hwcap2 = qemu_getauxval(AT_HWCAP2);
>   


