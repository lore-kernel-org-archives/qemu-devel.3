Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21966C369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 07:14:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9fA8-00067s-Vg; Tue, 29 Apr 2025 03:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9fA6-00067b-Q9
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 03:13:50 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9fA4-0004D6-JU
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 03:13:50 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39ac9aea656so6520152f8f.3
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 00:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745910824; x=1746515624; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yehZmGTx7uAqJaLE76x+U27DnExTYI6sNqxGDs8Q0r8=;
 b=Lfpwvoxzu+uRgHB6KqOZfATwiWgqzu90VKTYkxZ10isE7wMa9bO49W550/xemya7dO
 p5mUaoII3J2N8085vz+T37OL0yP2IDI8UEFNz4yoaWlX9Qp2r8V/p7vYdE8gZl+9WDKS
 7UkFY7p6eTelFaCQ01jRT11WmpPzFbWscJA23MUS7aNXAlC4eoObdoUlZRLXlBA536Wn
 bG6AJ5EIYCPN5mCatGd0taTtbEvMx5pJ92d3WDeWLBApH5GNiiosN0wcX4fNSvweWOkI
 y3lirMm62PUhSGZHcX8OmQFx2DTxYt1hk9AwVRGOjUS2Leb6o94Lv3ch2Lmr4cy5Q1I9
 U46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745910824; x=1746515624;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yehZmGTx7uAqJaLE76x+U27DnExTYI6sNqxGDs8Q0r8=;
 b=C6QFn/XAn9zBxqUP1t+G9DKI3vieSrD2mYZSYb9jEulrXuWazr2/D37MmD9ueDKJmW
 0BQXTxxmuFhyFbLFl+xjMlNoYWmlU5z9/1jqvTmreq8QrZRO9Vka5ZeXLAV2ChX1Ildg
 PvOohM/cpKC80FI2ckL5/h/2yWvLeTQ4jsiybYqEUTi8Wx+y0UbjmucXHICuYf9tr+rk
 GyzNNVihBCDYuvrLibYBB1u8WcAg0mOkw5xUrAd64+fUrWHLje9GNFzMEk1CagnSadIo
 U7olIMk+5Y/5PEAL1tMXRufHOabFU3UUlJRuYiefLijiCIRNQqCehu6KfNijVOTwF2Db
 l7lA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX70i62g4e/URXHOP2zrhHGyc+/joxyfIPr4cm1r4rwhTCDM3RJLw1KUX6imLdG3l2stRxsfc1XrRTL@nongnu.org
X-Gm-Message-State: AOJu0Yz53bKUFO9MLfEjKKUcIR+SiYSE7VgTsiYm1Hqp/uGZWGpncqKm
 yXfkzz/be8Lrno6FiRK8DbPHTK/uf9pMe+JWudclJTm1tzQVoX+UwLAaB5VNi+4=
X-Gm-Gg: ASbGncsaKgagBd7TSV+f6WQDbqGo0WeytYo73JqkIec6sReMs/5wBhUO5t5TqokgeEh
 Hu7QQ6kN939bqvm/Ttb//8oZjtPjXoYpZhNrh/WeS2cTmnU5mCSlQssJALGkMuX2rxweGt9ZTa9
 rvZGl51aQP+IA1q3hVNiOuTRLfLlVGX021sQDWAyPKcRk8vBjbyBW2/nkgXzI64kLVgjeH0AWMZ
 +bDuvH6jLB/oIbReyvF3QBhxnPf/dsfzqydXHUldNroW6RQQkGNHJqYK/Cd4Sa39akuZq7UAROZ
 rnT9G/Pk4AaenCtV/VnDj+TsOL/V1gAR3ydsDCJYTS9V949YBamB7Xt+CegKmnGLCneRpIJf9nG
 NONIJvYhXlwE02w==
X-Google-Smtp-Source: AGHT+IF3jDfaiFaE0KiZ5e+08grYBav5IRWcws2yhNnnOdNJAuGgzhyThrFzk7CHNb/gc6OX5zpWeg==
X-Received: by 2002:a5d:4884:0:b0:39c:141a:6c67 with SMTP id
 ffacd0b85a97d-3a08949d731mr1735344f8f.45.1745910824440; 
 Tue, 29 Apr 2025 00:13:44 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073c8c95dsm12856743f8f.3.2025.04.29.00.13.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 00:13:43 -0700 (PDT)
Message-ID: <e178a430-7916-4294-b0c3-60343ce6f023@linaro.org>
Date: Tue, 29 Apr 2025 09:13:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] include/system/hvf: missing vaddr include
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, anjo@rev.ng, richard.henderson@linaro.org
References: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
 <20250429050010.971128-3-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250429050010.971128-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Hi Pierrick,

On 29/4/25 06:59, Pierrick Bouvier wrote:
> On MacOS x86_64:
> In file included from ../target/i386/hvf/x86_task.c:13:
> /Users/runner/work/qemu/qemu/include/system/hvf.h:42:5: error: unknown type name 'vaddr'
>      vaddr pc;
>      ^
> /Users/runner/work/qemu/qemu/include/system/hvf.h:43:5: error: unknown type name 'vaddr'
>      vaddr saved_insn;
>      ^
> /Users/runner/work/qemu/qemu/include/system/hvf.h:45:5: error: type name requires a specifier or qualifier
>      QTAILQ_ENTRY(hvf_sw_breakpoint) entry;
>      ^
> /Users/runner/work/qemu/qemu/include/system/hvf.h:45:18: error: a parameter list without types is only allowed in a function definition
>      QTAILQ_ENTRY(hvf_sw_breakpoint) entry;
>                   ^
> /Users/runner/work/qemu/qemu/include/system/hvf.h:45:36: error: expected ';' at end of declaration list
>      QTAILQ_ENTRY(hvf_sw_breakpoint) entry;
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/system/hvf.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/system/hvf.h b/include/system/hvf.h
> index 730f927f034..356fced63e3 100644
> --- a/include/system/hvf.h
> +++ b/include/system/hvf.h
> @@ -15,6 +15,7 @@
>   
>   #include "qemu/accel.h"
>   #include "qom/object.h"
> +#include "exec/vaddr.h"
>   
>   #ifdef COMPILING_PER_TARGET
>   #include "cpu.h"

What do you think of these changes instead?

https://lore.kernel.org/qemu-devel/20250403235821.9909-27-philmd@linaro.org/

