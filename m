Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50F4C369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 05:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9deU-0005OM-Lc; Tue, 29 Apr 2025 01:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9deS-0005Nu-T1
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 01:37:05 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9deR-0001oW-2J
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 01:37:04 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-39c266c1389so4035144f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 22:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745905021; x=1746509821; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fdxbfOqh2DB6z+OvNYbD+2Iy/ee1tOeEB+GcS9VWkCY=;
 b=CAMZRHbN8XuBZzQu4NpS38UzbA9cYPALIlvP5TujypxCnWhQOHd+jMVLNFMxz0ezZg
 ztSqhQv+SkHOAdccanx5PkiyB8vr2uAWJtcJL23LXwhE4FjyIc0GkbgqXan5qjUTHJoQ
 etoqDkDR9loNDRgDz7uPLLUwH4W3MzHXRkvwV12yHi1yegO/lEcZCuq4z2hfdkq99/uR
 6affJ3iy69/SwqC5JfQRj5TqPulVzdM0o7zvZakL7z8+hQMHyLfqjV7yOrvkXJQv6Tvi
 RJJP8JlGE94/GdiAl8TDCZyV3eEZ+FUhxD+zN04Tcf3AgCMdGB0UrMNKb8xcHeQHlTFg
 T29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745905021; x=1746509821;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fdxbfOqh2DB6z+OvNYbD+2Iy/ee1tOeEB+GcS9VWkCY=;
 b=TiQB7rFFaBKBIFgr1qssZq2qvBEI8c5SsB9NISKRa5/KQ7pdvdxaGq01H7BZQNN3fL
 X2MPfWBHJvp1MYR5aggk9L5AWdq62KgLMcYh516biMjaYZGE+NHxyUS94sG4jQvDH2rT
 c7ZbbvzJKAJH79qCXq8nEXqUDaaCBkLUR/V65LLgwdRgJsQnAKe4FAMS5j3W8/cZMWWb
 DQ6FM9vi280o+1Nhq/zLLleO4PhaFxLEFPQKNKNA9/iBAaFLtAurXtFfd4KnCGKfAdWX
 Jh0ntNvNVFH14atw5DMQ7TUj2Aqgjgd1CIP3FbiBQtYQ6gEapuwfJCELl/R3v3wBN7h+
 FcxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNW4IFP5+nBW9bYnOqvOybNa4pdlAhcfclxG+00Pd1bdpDO4CcG97zel0Qv8i9fwjFgU7E/q8Bc2V0@nongnu.org
X-Gm-Message-State: AOJu0YxFTlqriYWQ/GxUrKSGwpPM8eP3iBKVu7iQow9BsEPp/mKJHnRS
 r6JEhDqFGS9sbMBRXU46Ygqzyx5/XfhKgQ60MVHcPDU9Q2MKOCmYkODfs2YmKYU=
X-Gm-Gg: ASbGncsR5XJzH+xnulBxYr8VQBa1mdavRN/Bg2UKF0nHKvLeTO3ZJ8qaQHjTszMsMQc
 6h7aW60hsXWQwCPQL49lqetZ5g9mvFjeKWDQjEc+OWR9t+DnxRgI58NQ02xPrOIFtui7rlV7Kvy
 ZEwbLrWAILuLwlSx4OypECR0hsxXe0UjGtwEDVgZeS7CJ2qwl6M0mv6kN5Jd13WVeB1XBZhNJhK
 pWj+xR/u0UJN4s3zal7ZlR6nmabbiTD1jqdXs1cAKOMGF3GtCmPG4EeAqeaJriaQaKfuu1oJESU
 Gl4peu3Kq7ngU64Ux4TBoyh5OshmE7FkHuduvctZ1REF0lRtj/5W0Ilovs5nEegIqHumWpLsS5o
 LwwAMXLBxjmgjOg==
X-Google-Smtp-Source: AGHT+IHPSQ2/orz4Fh9+TApHSPnuEOz7ugayFhhxAeqRVwe7oA6djQCIKIaw1NbnQJTqpfETcN8D4w==
X-Received: by 2002:a5d:5850:0:b0:39c:1257:dbab with SMTP id
 ffacd0b85a97d-3a0894a3d64mr1871645f8f.59.1745905020634; 
 Mon, 28 Apr 2025 22:37:00 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5d479sm13271027f8f.92.2025.04.28.22.36.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 22:36:59 -0700 (PDT)
Message-ID: <9aad9038-2154-4734-a110-7a4d432330a2@linaro.org>
Date: Tue, 29 Apr 2025 07:36:58 +0200
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
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


