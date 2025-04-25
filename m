Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3C0C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 19:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Oi8-0002Dc-Lp; Fri, 25 Apr 2025 15:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8Oi7-0002Ba-2O
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 15:27:43 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8Oi5-00058D-Cz
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 15:27:42 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-223fd89d036so35049435ad.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 12:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745609259; x=1746214059; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mhoKuIaCQkkQpnxjJQhzZ05uLMMjrR1geTp+dV9bCG4=;
 b=n8rnTlYRmB+6AWZ1+0fisbnlFIGi8QLaCXu7XGDS4whlBwUqlSD6ZJ43lDJT8P/NAq
 OeldaYkfTrolICa6v6hofzN/pziXK0jvmtLbjbGf79v1sUPucyrqMB+A4QpBcNZGadui
 r8huPwoWxbQBhvVCBBtfql81cKyt7wn5r42eGJp4numjsV93yHjYBSYgnpY48gOctAqj
 7HAuOUP+6Fyt5Szlr1p/rpKdIOPKobU96yR6rQiCZjCjuRxOTG75kjTTG5DlyofU2uq8
 /rM75PW30g+2qCYqe9VSZhGMLFY/tLFFefcRkszerSF6Ims9wfi9d7zal+Dev8+c//Gb
 W9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745609259; x=1746214059;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mhoKuIaCQkkQpnxjJQhzZ05uLMMjrR1geTp+dV9bCG4=;
 b=RO0rsWn8qCxYto+7/PhABt/6cNL/uIXLfUj4IVwL1bXdGqVw1PDLOby/TbwA69CIfZ
 kn/GWLxjk5KFiPdUDYxW8Itig+3oTVnMaQh9Rtgetq8Vv/f3RCQ/GDWL6J8mC5ClvY/0
 TNtH58j6esCJRQxwh3bsYpAeGTp1iFQG0H0JwbMIiNyeHiMgFFUv7plG7aybcZIJMDpX
 NCJYiWHPS6q6S+g7WX4lANHmJoBX1VJVloW+7veB4iz5E6H5ebCWUYFCUb5dsl6lbbi8
 aFv1lHZUsx385trrpFFnfGAyBtbPMQpdJC32cwih1xK0w4YVKvGBPBqrEW6pf7r3GkQZ
 u1xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNwLf337+br1w7GuOEqsay4nSnN5UXULd/llJOaCSHhhpYWUfzqfPFxSKwAqSSC1/X5lUn5NQiURDC@nongnu.org
X-Gm-Message-State: AOJu0YzQKXb1JoaquN6tL+nzqwhr0wLxCpRgMMDx8GAOvvQMKPAcpPXQ
 8qF8ETspx8XC23a+tYfowmXUq0RIwLhaCzC4/+zK0JdaZddce/tspUFv27Q8kBZTNmsyZSqbgBD
 98z5ecA==
X-Gm-Gg: ASbGncsGthzqw9C3WErYKNQdLmp+ZHeLrWc9ZRNLjNG0vAB6A0W6OD5B7f56XJtbtfc
 b+EoRk02tp6XPkQmfDdywAzLARxmCkUxPhAu4AKuJ4mpZcmXVqr6izXkQ+yN2QQUvbxom5WQRhK
 Z8PZBA278RuqFSGDZGEcjr9j8bJThgiV0E+SbW8buxLJTWJZsrjWj1ly3MMgFQ6UWujYUzbGM2i
 1wSyh1fUxLkv9dk1I4PEuDo+p234Yb61jJZZRbKtKTBwZ0rIEr4/B9eg2t21HQCMcPuXRCx3yc2
 A1OQzVQkBFGdHlWoFCHyLFuCUbImmr+HXXJA3VwPJbN87aD4QJh0c2JqfmovhR5v
X-Google-Smtp-Source: AGHT+IHtODwhhCPQat6aGJ9xOBzP+/oMSGL6zyNqrc9uoYl6XZ5s0ORuKNt8+OcLzV5/267N4necYQ==
X-Received: by 2002:a17:902:ef47:b0:21f:4b01:b978 with SMTP id
 d9443c01a7336-22dc6a54a44mr12558955ad.36.1745609259005; 
 Fri, 25 Apr 2025 12:27:39 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15faded690sm3281835a12.71.2025.04.25.12.27.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 12:27:38 -0700 (PDT)
Message-ID: <08e4546a-0236-4950-820c-7ff08159335d@linaro.org>
Date: Fri, 25 Apr 2025 12:27:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] accel/tcg: Add CPUState argument to page_unprotect
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250424011918.599958-1-richard.henderson@linaro.org>
 <20250424011918.599958-2-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250424011918.599958-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

On 4/23/25 18:19, Richard Henderson wrote:
> In the next patch, page_unprotect will need to pass
> the CPUState to tb_invalidate_phys_page_unwind.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/user/page-protection.h | 2 +-
>   accel/tcg/user-exec.c          | 8 +++++---
>   linux-user/elfload.c           | 2 +-
>   3 files changed, 7 insertions(+), 5 deletions(-)
>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


