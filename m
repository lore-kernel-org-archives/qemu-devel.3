Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B98E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkio-0001VJ-3d; Thu, 12 Dec 2024 10:03:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLkik-0001Uo-Sy
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:03:19 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLkih-00009t-S4
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:03:18 -0500
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-71e2bb84fe3so313070a34.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 07:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734015793; x=1734620593; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iRjrqvwEb+Josk/KDTqY8Ut2q8pNtXrXv0JRiGxkHRg=;
 b=XHauL+YL2qh48Z4n6yWQbWhoq3BHHLAK7jM2KlNjaMWaDC4V7u0LGbTTq6SBbn/9bW
 xFVTvdErpk6PigMR6pqDFZ0OFOYOjNVpmaK3Hetxop/Ng/OZ5+FzVLK+K7ayCkb42oym
 E4bwZdLzNTebjlATtvy8syvyXKYWzJr5uQv44XO8GIVWyPfYtCfCLa0fx4UmtMQFNQyy
 RhIMY1tjkNkL/ESYDzFVFUea/mFUGHpKiSXrJBRkEkUOkJ3oujEFzgLxhXzNTHFWwqD5
 dLkgxPnpZxsi1Juz6L5EO8Bj4166yg7NZEjkQveXrEKLib6GPVNNzDzv5t1s7oUUj3ku
 aJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734015793; x=1734620593;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iRjrqvwEb+Josk/KDTqY8Ut2q8pNtXrXv0JRiGxkHRg=;
 b=mOZc5+twvQANnrg63l4dtr3x3mQEkWadll9HYCq60lLw0oUB2wngr01y3qtGTR2ERn
 vnksJLpaOyM2wLErxV0o3FrgMrGgplyRXIKoXf0Z/FfM3e5WaxDoaLUrvOpxKxH51pAK
 ILnqh10bC1GGnzE3ZyhpctN8Nc9nxsAbXExFYEG2NiGh/3uaSBDkeGA3hjUPWQfT2WWm
 HOOhxTgDjEKS+O+TA9hg4F6NCd3J6sYk0THfvi/0t0u4IVVjxkTFnsXWV6fro60iHkDc
 F2qAxARZlzhl7LwjjBJ//5cAvSe5psNuKvK5mGxl9UBoNQYl90KjeTJdbP1E7x6TP6d1
 bRsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuzkN8HJ+RZ4XdCWgJqwLV/KZdXrOuwnam2A+D18Ze2Hi7M53viLrHI6wF0ovBwECr5lz6wpQd7v7f@nongnu.org
X-Gm-Message-State: AOJu0Yzqie/kMj+DKZRAmMMW29wn5D4YyxYuUP3owOm4DVaW7bQ1CPpr
 yJ/AclGmA3qUfhKBPBxV3HFUBF9ez5CqYLTIovWgSBJsBxvsqcOOjLq0P4RsjKE=
X-Gm-Gg: ASbGncvkVZoG2+9ZHVaFw4RoAGh5QPS2y4c8LHr8XUHDeAUCyOfOa5GRxUGJEuqY5DG
 H77kb4i92Of/o/9icQBDx+qMJY6NGgq9qezhXS0aY/zJAT3d+lIQRO1Qh7xFW9s4rzWty2ODp7F
 QU/T85uPCjGkDs9uA9xNs6B84IcPCCDJxdmG6eL649/+GcX9RQq/KGIvEswtOiJW39gWYByhRNs
 xgNfmXmfqGtk3vR8AVZOulubt824oXfRqRLaojiJW4ntCqZh+Klqocfm3MGCK+RNGQitPbV3ZEU
 uBNm5IfZSokcVmhJ+Fmf2MiTYx1p5xmOYmU=
X-Google-Smtp-Source: AGHT+IGX2imroZIHnFeimIZWrCc0npZDaBcC8o9YRS/AGyYC20ULSJgIkdYHUTESemk1afQg31lhNw==
X-Received: by 2002:a05:6830:f87:b0:71a:5f45:ac3f with SMTP id
 46e09a7af769-71e36e00541mr425290a34.2.1734015793480; 
 Thu, 12 Dec 2024 07:03:13 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71df7d58e03sm1953440a34.38.2024.12.12.07.03.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 07:03:13 -0800 (PST)
Message-ID: <8be1b2ed-5ae8-4308-b2fe-a4badd71efb1@linaro.org>
Date: Thu, 12 Dec 2024 09:03:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] qemu/atomic128: Include missing 'qemu/atomic.h' header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20241212141018.59428-1-philmd@linaro.org>
 <20241212141018.59428-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241212141018.59428-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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

On 12/12/24 08:10, Philippe Mathieu-Daudé wrote:
> qatomic_cmpxchg__nocheck() is declared in "qemu/atomic.h".
> Include it in order to avoid when refactoring unrelated headers:
> 
>      In file included from ../../accel/tcg/tcg-runtime-gvec.c:22:
>      In file included from include/exec/helper-proto-common.h:10:
>      In file included from include/qemu/atomic128.h:61:
>      host/include/generic/host/atomic128-cas.h.inc:23:11: error: call to undeclared function 'qatomic_cmpxchg__nocheck'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>         23 |     r.i = qatomic_cmpxchg__nocheck(ptr_align, c.i, n.i);
>            |           ^
>      1 error generated.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/qemu/atomic128.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/qemu/atomic128.h b/include/qemu/atomic128.h
> index 448fb644799..31e5c48d8fa 100644
> --- a/include/qemu/atomic128.h
> +++ b/include/qemu/atomic128.h
> @@ -13,6 +13,7 @@
>   #ifndef QEMU_ATOMIC128_H
>   #define QEMU_ATOMIC128_H
>   
> +#include "qemu/atomic.h"
>   #include "qemu/int128.h"
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

