Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51083C83F26
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 21:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhE09-0003vZ-JF; Wed, 30 Jul 2025 17:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDkd-0004O7-Ce
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:50:15 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDka-0001iJ-AO
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:50:14 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-74b56b1d301so152324b3a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 13:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753908610; x=1754513410; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oim56ltJo3UqPI4TgWyi80sLMI+ePqNjeE9BD3Ds0HI=;
 b=MHxJSxq2l4sGcupxiU/TYYsJjM8E5bgh9ihhJ8LbHREKJAlczqo1eH9ApemqW5wgtm
 UgbzM8PInCEsje3solCquuGlK+Qj/xFt69TtP9a/3jALCuFoBntNT5bPr/RTOcBRuzn9
 NbqqGLxojUl+HKsIXTbygTcKoDh6Ze1tk47HEhPhjEgR62uH8J+jV7nF7gztjqH9y0XQ
 1/FJy7CNi008XLiLcYwUbZujgx0ULhR8KgjkGIzHlCy+fJ9EFsygGHrhtzk4j9qGq4Jn
 9d239e9p6vkcMq4kriMepsKihJU+bUW6kOfKxU84NWREaG08HhsxDMtjOgHBxXast6ZL
 A+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753908610; x=1754513410;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oim56ltJo3UqPI4TgWyi80sLMI+ePqNjeE9BD3Ds0HI=;
 b=YQkL6GDF/3eKkcPIuJ0tNu9z67mZuxK1i73LGNx3sAGendkGibcHjM/aw37pEZdZD7
 kSCp6q/DSdhw+k0uWLbGyNiNxYqJ8dfu3GlKYscryHLByginYrResytKyv98CZaBGxck
 V5UXQk+rnazT94qy9dZgbAZNqyaJda5SudJZGD73uH9CZDTWSoJNVKpYsTEhJ2NyTzat
 +AwOvAC0EMu307ece6G+gQF5CGDDZqtMEx68IraFn98p30ihOpuqi8l9//rDoLeZUEhJ
 n05w62Gv9SFkpVBVJwChTRx2Vpza16Vyh67v9ibGFCLqdSXHswBQTDKasD2BKFTnzPvX
 71dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpaB4EpjGwAfg3vHvTU+iUv9u2YR5TwlVRFU574bvdDxUC1cO/FZOLn2FY4Cn0Xjw2bVV9+AmasR6d@nongnu.org
X-Gm-Message-State: AOJu0YwhijW0lpPRPGHpPUbyjwAj8Y7B835AKyR+XYPLCwz74M1TAoF3
 yp+rgcsXcszj0e2mq1mSb3o6BLR8YJinhaIP958WP1k7j/OAR1TI6NGhCYhqbKX0SZE=
X-Gm-Gg: ASbGnct4ZEKg0SNhu6bikRQ/eprF4vNmQ9rdClUuUha/3GX25L5Mx/V3QDMwd/zNB5T
 Qg8w93xwkGn5dJX1dR72nTOGTIDbtEL4bUMiKeu+86cy8J88ZtzbP38fd5/LmNM8wnxw28y4lDd
 eZpO2q2dQkQURReb889HOj+m+bJmFb2gCP3bzSkAsdr32ffsfxV2iHNAL3G0SWbz1dxrBbmIstR
 jmjh7Kc+m82/7tZhWHaqr3M9ZDnpL9tPJBtfscIJyEcXgiM38EGB4FR0fTSALSc+vO6aIPACGWf
 CAa4cOK07v1jGC+rllNtIYt3PTIOYKIfy9tYhCUbZhO0d6wKCySBKOG/4rFMidRhkJeJOehXOTL
 WQnj40nbOg30VWj+gZK0FS6UbcwmDA8FSK04Qq+fgJtXAfQ==
X-Google-Smtp-Source: AGHT+IFP4M6kcfMsXU5TBlwmI23ut8DHF8iB6wobS9ADpRFV+Xg08bpCZcF/AGCrJVPU2crTof0u/g==
X-Received: by 2002:a05:6a00:7082:b0:73e:23be:11fc with SMTP id
 d2e1a72fcca58-76ab32f4c0emr5930988b3a.22.1753908610117; 
 Wed, 30 Jul 2025 13:50:10 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640b2dcdb4sm11333987b3a.100.2025.07.30.13.50.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 13:50:09 -0700 (PDT)
Message-ID: <3def01b8-022f-493e-bdcc-f6936b543573@linaro.org>
Date: Wed, 30 Jul 2025 13:50:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/82] target/arm: Implement dirtybit check for PIE
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-22-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-22-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

On 7/27/25 1:01 AM, Richard Henderson wrote:
> Both S1PIE and S2PIE have a bit to make software tracking
> of dirty pages easier.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/internals.h      |  1 +
>   target/arm/ptw.c            | 16 ++++++++++++++++
>   target/arm/tcg/tlb_helper.c | 12 +++++++++---
>   3 files changed, 26 insertions(+), 3 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


