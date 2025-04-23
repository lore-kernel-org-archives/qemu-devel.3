Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E33BBC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 10:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7X3G-0005lN-DV; Wed, 23 Apr 2025 06:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7X3D-0005fZ-Ae
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:09:55 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7X3B-0002qw-IZ
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:09:55 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cfdc2c8c9so34732905e9.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 03:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745402992; x=1746007792; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eTp9oQieq1vw+eP/rWoIE7wAxrnFXNli2Hzl6D4tCyI=;
 b=mXwmrirm/7ifn2+fpUL02P5ErTHAWdGVjBxGsS4O4G6W5U4BqEEMZYklffMj6rn+Hx
 6CrWTAKV73BQjpj5oDDiobV7KNJyRTrZSus0T3hOEOr5wapobEn47uGXtGfMqyN+VI8g
 /xBuJR1zza9/1k9VINgdveAgp5P11d2qa8NK2J+V7oYJ52nyzARBNQcfEhPleJiSnFSt
 0m6Any0knU0e9i+yccOC8wG/Pp2QisdwOYyGNKYuzv75XU/gQu2I5y8UYLsqU2tHW2Vk
 PyzB+94hWhlMx74nRjxSd/jAzGfxQ6urWWQh6e9F5pFLy6u9cWMpgt1MOHa3hQLjradh
 1eGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745402992; x=1746007792;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eTp9oQieq1vw+eP/rWoIE7wAxrnFXNli2Hzl6D4tCyI=;
 b=d978nlRKnlrqUP2HdPv/kCVwDhT1SnYLC3RXmCJsC0kkHLObFj8s9tHqXHY2cvL3o9
 +jVrVjaiLr5yswDAUuJNi1BDKDKDaygQT8Tj5OXs3aMMxS6C9vo0Or1A/p1ZGgGqfjzs
 uo7+D/B5UAAjikJUyzEyLWyyh4gXB32KmQibX82B9Tcka61carqz/vsb6tob9kMZ43Qw
 qVKd4k630b9iPmMSMtfTfb2bmgPMRXJxTDMr5Hw72p/gtgUoc9vgTtTm0TbuSnP9fdBo
 ta+MYaFzpbIZNO7vq5vwifNOnr0gaIbkqCHppMqLbnpNFuq72Sdk0j9+NpmIqHwH/lNW
 ResQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfsmMRtYNh4SgJzhiWqxyvuW+sUDXWe0HGriFnREq3P+N1YYBsCN2XSm/wZVJIkOoW+wpLrmHsfkB5@nongnu.org
X-Gm-Message-State: AOJu0YxAASMNsXA2BmCE+K7Uq1+h2BpxQfenP38WEMOeh7d6Dar0KGgs
 41opOzBPL3IiCOG6OGdufqBNPtpOod76cQDH+/78HDi4Mu5YtlhHEPUyeP6gben0odAammt69vg
 G
X-Gm-Gg: ASbGncuG9Awb6dsm/CoHSr001WMsUZjiZ7fQpWqvyVHQQ+JcoLQHluKuzzOI8X9wMSc
 WA//btHwhBJlZ1KJDgmUfmphGaqS2oYVBtLv4RSfzJIuhZHnGUPOTwOAiNcdWP8+Ry3FDDKWqO+
 uHpcO4oRgQA5eZBWnvykFn4Hlb4D134fogv9/v0q70dUCgdnprkrmKcXnBI89U5jWOPgpJXN3Sn
 VBH0C/DkrckUWshPzYAqc5pKjTc4Al/xio0dS9XKXbK8lmtEwYO0XsOj8ci8qOt7LBKunPMsrFH
 5oGzgtpRtloakdOj9MaNoLXwC8CX2B1Xam6yyP/esLUSwR7Qy4Mx9sVkG7yti8P8rhzb0Ermhba
 i7VOfPgGr
X-Google-Smtp-Source: AGHT+IF2q4vuy7ODxVYXonQYf6lmAtQ03RGotDfOTYzNph3J8rfTyWsvNQ7JN21UsMuv0+NNmssCDw==
X-Received: by 2002:a05:600c:1554:b0:43c:ee62:33f5 with SMTP id
 5b1f17b1804b1-4406ac1fd90mr156312385e9.27.1745402991851; 
 Wed, 23 Apr 2025 03:09:51 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092d224fcsm20391645e9.9.2025.04.23.03.09.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 03:09:51 -0700 (PDT)
Message-ID: <292eb63f-7bb0-4d7a-9d62-256c37af3ad0@linaro.org>
Date: Wed, 23 Apr 2025 12:09:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 098/147] include/exec: Redefine tlb-flags with absolute
 values
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-99-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-99-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 22/4/25 21:27, Richard Henderson wrote:
> Don't base the values on TARGET_PAGE_BITS_MIN, but do verify
> that TLB_FLAGS_MASK does not overlap minimum page size.
> All targets now have the same placement for these flags,
> simplifying mmu management when we enable heterogenus systems.

Typo "heterogeneous".

> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/tlb-flags.h | 68 +++++++++++++++++++---------------------
>   accel/tcg/cputlb.c       |  2 ++
>   2 files changed, 34 insertions(+), 36 deletions(-)

Excellent!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


