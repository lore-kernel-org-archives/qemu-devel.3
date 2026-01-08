Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E843D185CC
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 10:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdnjL-00068B-8a; Thu, 08 Jan 2026 05:59:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdnjJ-00060q-Jj
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 05:59:01 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdnjI-0007q8-0a
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 05:59:01 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a3e76d0f64so8073365ad.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 02:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767869938; x=1768474738; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0xDsYsZqUfSPlkLSnrNhGJEtuejn3vFQzjuYwP/y/zg=;
 b=Oly+GUl/ZWSMEhvb8iPae8QCxLI1VzB7hIxl0hn64kqeyIJgpaoT6SKqltIue10hZq
 dx5DE1xWqFnnGePLrR7ySnNkFViwC9k//eP27E4Zrq/f64Y4mkWlnWBzf896yqeoXaio
 dMQzfF5spw5t2pjyKdYAO8QxWsROkYmrKQFJEQ73lZw9LJ56pJgqVWOxcS4HlSSDUoso
 kVL1p0C0/Au5hkXCMw6hfvAxhRB+Uvblop+ZVRknxaTUGZcowN3wxHWX3zc8xEzaKqUn
 wKl9GHA4fy2SWqydtuUxEKhiLvbplwCgB8o8MixSKl2D3BBxrCTXQ58fpVHnLIycpHH8
 cjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767869938; x=1768474738;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0xDsYsZqUfSPlkLSnrNhGJEtuejn3vFQzjuYwP/y/zg=;
 b=lpv/BlzIYBJnkBR9y0FlKWtRW8gLPMsM6780+0uKKqihvfWgFKvkb8EP1zmAg/SFpk
 HBCdeoaEJmDDZ6wOPqtTfajsDfqQjxYbGtluiaYfmRku5/1Xita3LrG0fKz8r9y8JK96
 AyviALrHoeY7W4yA/MGbv3OHpaZ/I+4FyOz4hAdoWhZL0zmF89fVtaIbG4W5bKMd7RvC
 dMYLQQBUyMhH3Cu3qRVnuoNasBPTVCW2Xdn6JNTuc9HvCfSzowzauBab5H+QU1miXpvj
 zGccId0rVs1yXXL4fez8at2qb+kTilcIi3hl2PeRojDReC7DOShAUgflGQZ9SB8Ic2Ur
 umbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNdUkUCoy1XOENrhGRWdnSCi/iXv56FHUoyw4mouWU09X+t5/V7bGR/hSVhvwzCEx83gC+DdZooUaf@nongnu.org
X-Gm-Message-State: AOJu0Yx7Ew4F5HZFR+e9mFAS0T72JnPDeboPmANCJiA0kTGd5jqIpAsq
 hfgaQSj4tYQqA8PzvYxAcTZYFXBLBFEvM3d0yL7aP8Rf/fkpLFw7WPnhaABlaNqW7W8=
X-Gm-Gg: AY/fxX7IHz7CyANb7v3RISK/1v7HfjBk9oIf5lvIH3ICMDc/cKdLeDQkGfqjwFJsadK
 asLaVeiaIMwQuVbrCw4HaedjV+o1Lqv2O34EUP59Dt5wqMGPcppkAjveGt+mLP+KcjnZhZjilgv
 7/7pDxiMyChyM50Ulsbk4T4T1oMSuQPohN9lAKEnqqrDD9MjLCZTXLJwUIr3AG9axJXJpt+/lbq
 oCNJVN5rDaqJxgsD/X7jSgGsPpnFtbu1ojrt6LbKVk3GLejmV7iwOtsOyIkxQDzXhdjpB6zysOv
 ywikZBqPYP8xYzatiElIoak64x5qaciVV6lIMPRlIYcNC2magQpcltmd1n2xYsbU4RTw3IQczME
 0R0NqQ9iPdtrBcQgS2l8rLl3FckMT9FuayQMj3mMK0oGoBlaYIcJk6/n5kUEC/v2RtnmVWBJazS
 31IyIfr2L6q6mZK3tbH37bh2Fm/x8FLcf7rfxeKq7e/FlnXSdKKSe5rQ==
X-Google-Smtp-Source: AGHT+IHufp0AXd6x+4xv7BHp2/WJL9nBKNxOm+7kFC9pDNrDDqSeURzCPKVK4OM8SIQUuAu9+yuilw==
X-Received: by 2002:a17:903:fa7:b0:2a0:97ea:b1bd with SMTP id
 d9443c01a7336-2a3e390f68cmr95019855ad.0.1767869938087; 
 Thu, 08 Jan 2026 02:58:58 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cd46a9sm77070005ad.93.2026.01.08.02.58.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 02:58:57 -0800 (PST)
Message-ID: <f5675177-1c71-4ee4-9947-5f55760b4143@linaro.org>
Date: Thu, 8 Jan 2026 11:58:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/50] tcg/ppc64: Rename from ppc
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-13-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260108053018.626690-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x632.google.com
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

On 8/1/26 06:29, Richard Henderson wrote:
> Emphasize that we're generating 64-bit code.
> Drop the explicit rename from meson's cpu.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/{ppc => ppc64}/tcg-target-con-set.h  | 0
>   tcg/{ppc => ppc64}/tcg-target-con-str.h  | 0
>   tcg/{ppc => ppc64}/tcg-target-has.h      | 0
>   tcg/{ppc => ppc64}/tcg-target-mo.h       | 0
>   tcg/{ppc => ppc64}/tcg-target-reg-bits.h | 0
>   tcg/{ppc => ppc64}/tcg-target.h          | 0
>   MAINTAINERS                              | 2 +-
>   meson.build                              | 2 --
>   tcg/{ppc => ppc64}/tcg-target-opc.h.inc  | 0
>   tcg/{ppc => ppc64}/tcg-target.c.inc      | 0
>   10 files changed, 1 insertion(+), 3 deletions(-)
>   rename tcg/{ppc => ppc64}/tcg-target-con-set.h (100%)
>   rename tcg/{ppc => ppc64}/tcg-target-con-str.h (100%)
>   rename tcg/{ppc => ppc64}/tcg-target-has.h (100%)
>   rename tcg/{ppc => ppc64}/tcg-target-mo.h (100%)
>   rename tcg/{ppc => ppc64}/tcg-target-reg-bits.h (100%)
>   rename tcg/{ppc => ppc64}/tcg-target.h (100%)
>   rename tcg/{ppc => ppc64}/tcg-target-opc.h.inc (100%)
>   rename tcg/{ppc => ppc64}/tcg-target.c.inc (100%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


