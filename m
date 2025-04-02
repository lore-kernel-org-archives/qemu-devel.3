Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF39C36010
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 03:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzopJ-0001rk-LC; Tue, 01 Apr 2025 23:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzopD-0001rG-5l
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 23:31:35 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzopB-0003pY-8F
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 23:31:34 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso46227545e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 20:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743564690; x=1744169490; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CujPIjkhOlnkWqCu+Rfx8WsNvtOQeLj1Mtett7H+ZGg=;
 b=mydaO1jKB5HDjGnop78BVHShdq9WXOA8pU4lybbycEgmKApgB0/JHf5bCnC4qPSG7R
 9EN/td2AKdBpfM5x7eH4/cXZ3Xdmyj2YXAj4Lvw6JPbQnI36oHzC7kXUGb2o4likObKF
 69hxjXpweUsL48D/bnp8wmguLoDblXxTpA3CrTBTy0BZa9adq8UIn8jngheoydgMCTGv
 V8ys3lx5Oqbb76hRRQJO3RWlw5hZY3iNgG0bNtJ3JNKPPN1edOmPqgdwmsud4mtPxjBM
 llvwl+ZIglcbzpoI76GlFFmRTVW+i0JHpbu9Kg2N4K/PlAU7n/o1LVPO5xTji4qMIvzS
 MpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743564690; x=1744169490;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CujPIjkhOlnkWqCu+Rfx8WsNvtOQeLj1Mtett7H+ZGg=;
 b=NcWndfjDyHI0rtRvvpuzrggBCCRKcd0EEcLu/I3sUiqbN3sxAlxhBGH9Bx/bXfTdsk
 Lzu03aipk+zXSW4gBvh3AI4w7r7CvRXHTFroOaBP7YFmsUemW2H9OAm6KiV0RgdEwhIt
 Vvk57drgWswURleT97rMxct9n0+igIkvVY356+t9gpaS2xt7dBDbFae7PSwsbUGj29KJ
 6PoA6o361N2NitqUgq3M3CvGBRCXI7H3shyk3RRotYqg21z/NTpOIyxeod/z8rFSyoWL
 tbvKa7/oE1YpjdA83CS63Dlnn6IXNGEwD6wGYoqv9XruBqQxM0xrBmuPDC6h5WVFRAE1
 2/PQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVt15Z1H2hFryYEOQayJXMC883ZUJjHpm1+jl+Ap0RrJifLDv7CjjsdGlyJZTNSrYM0895YD9t90TfN@nongnu.org
X-Gm-Message-State: AOJu0YzkW/H2KxEnfZTRxsOAfrHtwUZMrBIoLZR+6N1fNZ7skUtlFwEv
 zdVVorsJfo4ZQCMB+qC+mfSHS2ZQ2XbLfPe4jy/xYdZKUhW6+qYoS6wk76wAuBE=
X-Gm-Gg: ASbGnctUkDEX5njDxuDkCHIQROeInC5pzgOyGujW/epWor3XyIMybA/raP27OI06o9E
 s76YQcausAkqG0Ce23GLGNWSCkHuwXx43dGAzP0zciHSOTyFJL/icld8ELKu2As/e+QjUC28c9s
 G2uK6D8v6t1x9jsGWQEa/SyjCzKO5RtW11M9p6OqTHpnqUaec4Kb4nGOvoPShqXQ2r5g9DwQAYQ
 oBLvAL0e1QLcL+K33rGLURGfRoRNRaRc2ksDJ2LWlR8XB26idQ4+cn4SYCd6wjWcHzlwrz/hAcE
 Tp/6IHfz4RYvXY8EedJSCKugQhDQSnX6M14jmuM46k0R+zmyh0vuYGZQ//5RUOUWhdbI6Ju5pdP
 Ehf7yKYMZlXXS
X-Google-Smtp-Source: AGHT+IGgC8MDVGkRqw2vbt917abdXWZ3MG1OlSLGeOEkxOX+DZ8OMBXDOpAWTPmY0jfwqNvKSOTMnQ==
X-Received: by 2002:a05:600c:1554:b0:43c:fa24:8721 with SMTP id
 5b1f17b1804b1-43ea7c965ebmr56831035e9.17.1743564690488; 
 Tue, 01 Apr 2025 20:31:30 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43eb613a283sm7175535e9.37.2025.04.01.20.31.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 20:31:29 -0700 (PDT)
Message-ID: <e11f5f2e-0838-4f28-88c1-a7241504d28a@linaro.org>
Date: Wed, 2 Apr 2025 05:31:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/29] include/exec/cpu-all: move compile time check
 for CPUArchState to cpu-target.c
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
 <20250325045915.994760-4-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250325045915.994760-4-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 25/3/25 05:58, Pierrick Bouvier wrote:
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/exec/cpu-all.h | 4 ----
>   cpu-target.c           | 4 ++++
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 74017a5ce7c..b1067259e6b 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -34,8 +34,4 @@
>   
>   #include "cpu.h"

This include ^^^^^^ ...

>   
> -/* Validate correct placement of CPUArchState. */
> -QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
> -QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
> -
>   #endif /* CPU_ALL_H */
> diff --git a/cpu-target.c b/cpu-target.c
> index 519b0f89005..587f24b34e5 100644
> --- a/cpu-target.c
> +++ b/cpu-target.c
> @@ -29,6 +29,10 @@
>   #include "accel/accel-cpu-target.h"
>   #include "trace/trace-root.h"

... is also needed here, otherwise we get:

../../cpu-target.c:30:19: error: offsetof of incomplete type 'ArchCPU' 
(aka 'struct ArchCPU')
    30 | QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
       |                   ^

>   
 > +/* Validate correct placement of CPUArchState. */> 
+QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
> +QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
> +
>   char *cpu_model_from_type(const char *typename)
>   {
>       const char *suffix = "-" CPU_RESOLVING_TYPE;

With "cpu.h" include:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


