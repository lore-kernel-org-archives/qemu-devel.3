Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B954FC021B8
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:46:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzwN-0001xK-Vw; Tue, 25 Feb 2025 13:46:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmzwH-0001wr-3t
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:45:53 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmzwF-0000EQ-96
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:45:52 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22113560c57so36070155ad.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740509149; x=1741113949; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Yhfoa+Ic2QVKitSjTHUBWal/jTEU3AA4Rm+Tf8toMts=;
 b=k7cMMCj6kOvRKEsEt3t527XH6g1KpJTz7tShS93HfyWN05sQrjjW+1n6iFue34Kx7m
 kYbtj371MZsWozloJdqV06vnYp4Lx/6izl/S+Ihu8e42Nr8v744vl5igL5/Krz/85Z82
 Unmpqzl3jbl41HeLKzdLbx6WcdO8tzrO3QulGWDb5jIH7uD6sH2LFqFemax7/9X2d6z7
 /qqep8fy2YcVL7UocY3T0pBDr94cJnMYJdtlLBDKpx9H+8H8zLHCO6Gj8qiWGoyAwXZs
 fP8/z7uyL9dFYnxKt7h4VeCkWmzJKBnGsomxkHxrf1IKnRkM7D7pUgGnpynDG7k7DmFp
 GZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740509149; x=1741113949;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yhfoa+Ic2QVKitSjTHUBWal/jTEU3AA4Rm+Tf8toMts=;
 b=PKL/qrwmwWXhm0BCM3iKkbLUK8t2JwdN57BqErfHVE3FDnHhq60w9ZiTc1WDQv/Pl7
 T6Iei24/6y9fQx9gmuUF4NeLPdScL5LuhNsY4LMJfZ46XEDyxn/eImDMjuKU3DVIPUkv
 sZ3W4VwbrdRvQ9UquY7IRTPcnW6aJEb/xd1XsYh14ztme+/Ts4PbBW0VMOwOQ/jyO9vx
 +3UT4lyN35NPymJYp+t6ya6vtKUk0UfLlZAhkhgFlQdV3Q8rGtX1dKCJ0qcIBRCXv5tQ
 iuw6a0GFJt8OwnFyLPd0FNSzyAXD1IAIXMXdIlEVnmn+Mu6kew/tyKQR2Qv/uqVTQy5U
 /NKQ==
X-Gm-Message-State: AOJu0YzgpktWOiAEkDca0/C2l9Nxn4fyt9G1G6dxH0pvQskxzkhBewqs
 5ZHzRt22/ASFhMoyeU3ay3qUJDpnI8HUy26bRNp8VJUJJop0/BbpRTlgifk1teMBlJf+SJMMb06
 L
X-Gm-Gg: ASbGncs3U2xEuOe/loNNQFl9a7eiNdWsesSkMdBqk1FaUChcrZ8ZwARWeqJJzHRgsh+
 RoL8EjSVgD3ksMtj6ac7VzfxTE6JUpjMk7M2boezlHtGNS9iZH/bgVO92sDLx3XGRRxBG2N4pvA
 5jPHBxbVy/fjlS5SMcnCWWA6KkHIP56MAh9lYh7FctWQ3hUB/RxV/01r/HQdIiVHtnA/ztGOIeJ
 GoMLecPwOlPhMcMWAb22Tmp/uW3rUj/+8Jc55fOLk2JqHTdTty3zreE7R0wi4uuMlvqNBttOBrf
 YJHfrrs/9XID9jzKUFrYFpFvwexD4sIwBBrO69p+QMAdNGefZbHZNWHVuxUqlx4lsuMtB9StZCi
 x/TwlGPQ=
X-Google-Smtp-Source: AGHT+IEO1pTJH6Zo0YYOrC4vqpQwyWkJ4xTtTRNdwLb+9vwGeh4z8a3Ls4ZDU6QlSx9ZUGqjXIvGfQ==
X-Received: by 2002:a17:903:41ca:b0:21a:8d8c:450d with SMTP id
 d9443c01a7336-221a11abd40mr310690215ad.53.1740509149619; 
 Tue, 25 Feb 2025 10:45:49 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2230a0a3befsm17877905ad.165.2025.02.25.10.45.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 10:45:49 -0800 (PST)
Message-ID: <ca9e7dd3-dd43-43bc-a64e-992344a88a6a@linaro.org>
Date: Tue, 25 Feb 2025 10:45:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] plugins/api: split out time control helpers
To: qemu-devel@nongnu.org
References: <20250225110844.3296991-1-alex.bennee@linaro.org>
 <20250225110844.3296991-10-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250225110844.3296991-10-alex.bennee@linaro.org>
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

On 2/25/25 03:08, Alex Bennée wrote:
> These are only usable in system mode where we control the timer. For
> user-mode make them NOPs.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   plugins/api-system.c | 34 ++++++++++++++++++++++++++++++++++
>   plugins/api-user.c   | 17 +++++++++++++++++
>   plugins/api.c        | 41 -----------------------------------------
>   3 files changed, 51 insertions(+), 41 deletions(-)

Code movement, so,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +static bool has_control;
> +static Error *migration_blocker;
> +
> +const void *qemu_plugin_request_time_control(void)
> +{
> +    if (!has_control) {
> +        has_control = true;
> +        error_setg(&migration_blocker,
> +                   "TCG plugin time control does not support migration");
> +        migrate_add_blocker(&migration_blocker, NULL);
> +        return &has_control;
> +    }
> +    return NULL;
> +}

But I'm really not a fan of either this API, or the duplication between has_control and 
migration_blocker != NULL.


r~

