Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16E2C87FC5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 08:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uerfT-0001V9-Ev; Thu, 24 Jul 2025 04:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uerfL-0001RH-VU
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 04:51:04 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uerfI-0005HD-1J
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 04:51:02 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a4f72cba73so1108063f8f.1
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 01:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753347057; x=1753951857; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UdfYskNqeCkaDvWccq88hHG9qewP7Ta/KOSgAFXFex0=;
 b=Unkdu+XHzYmKYGC1dgpOsrmGg/wP7iZZOPZEsVFuWZbfmNPdlqPDhbJhWGMjBV45ki
 fQlsGOF60DigXxO0SVk5Ng7UWlvWwqbZYPH0EyZt1biGDzeN1jhG1xk+WHRinFzbIepp
 FDfmBwGxN34lRTICmxsjeBGepMj0u6qsQREMXArVOa0Vn6PHfATQzVbQBguSlq2+/veS
 uBxHbKHvdcxRpSRu01eZ9VaJyvnpYD0yROrMlPAHImhK8fr0Z4IPdMrKfaeAjeIq4gU6
 AMqMNg4IIA2MZXRR+V93hwhmDsW6XNNMAHPgpG6fCDobMyWpwZwlHhBxtC6CdCYMlmnf
 1FuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753347057; x=1753951857;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UdfYskNqeCkaDvWccq88hHG9qewP7Ta/KOSgAFXFex0=;
 b=B6rtRcroSteuRwD4yHjO9VFHjgbpeITj9PQXCG5mxXTtm6mXKYbO+mlyjVAd87fdWN
 7orsm9fhQVsaD9u/MSOyTqULWRd1pitd2oeyQWdx5Tb7J4J6art8HlxRIsfYgQkBWc9j
 rjiQnd/8z0lcR7nXQ6iUPsJZGtiPC1yHxCfck4NyWpfNhUewWxkcdXXtLJDuZk4lredm
 ZYAyVG+As7T8G6dQJcnBB3D2sqQp2WR7UYAr3xmNhmsa5WVVPnvbZlSkhta4zxMNUq+4
 /+Ecn0M6EPTg3YmWMRG6NL5qiIh2x3C8xaJx+b1tQjs5G5PkDxGO+K3baa3nxWXeqrQy
 T5ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwpKQ09PVu1vfw+6ONKTe6pb/bVhWDr+Vq45Fc0wtr/6JUHIMtzGVexck3NIA7az2Oqrnm76ats76k@nongnu.org
X-Gm-Message-State: AOJu0YxZ9Fo8FmcYVQ4Zd4ZtiokZno1NX9q5GPraVebCD1hAVgcGv5wf
 yu1YRGAeLMaMsWBCnzjajUcCmI1A+mX5PV5R+ihCQ4T32tkMZe6tquEOIP/BKLXbRvk=
X-Gm-Gg: ASbGncuJh+XhB0O6mXNr41yCqEix4BS51NXh4Hy6RLGHvNkZzq+FdVVG+IBTpZ7HpbF
 pTvSFi8oVIFeJ8fonLzipF1g76uikkFgEvHMmd28d8g26s2wkA79qICuRzufQsdm7ra2aa757M2
 OPJbhMSxj/lTodfKuvbX9mNusaykxFf5yHpZpuLzMy18UdGrbCjcPvbXRSG+IVki7z9qaaw7Pwk
 su7pEBW/pxMLtwWz8jqQ52AkSyVbIUzDknuUiDzacfaCI1cOZ9bS34eeABAWdFZ/hwMcpJ1j63W
 tnJF3cyxTvxXyClSNNAhk5zl1VqMfVsnEj+HxNgv+Qc5812jBMMb8ZF5WoO5hmcB/5yax2pDBio
 Ab9XOn6ZGkq8bbKOEfm0iSBgq4gDs4nYTaagb4H4KkY1MuWS5HH/r/jr3qriONuKBJ2f6xpmLav
 mK
X-Google-Smtp-Source: AGHT+IFqS5UBidkFbwsotYemq0wZsTAbGD2gBcBdyhwXTbsKX9NMixJyQL5/GYB1WmBZxZdHat/wzg==
X-Received: by 2002:a05:6000:2389:b0:3b7:533f:cb60 with SMTP id
 ffacd0b85a97d-3b77135f90bmr1065995f8f.22.1753347057071; 
 Thu, 24 Jul 2025 01:50:57 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705ce685sm11405335e9.30.2025.07.24.01.50.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 01:50:56 -0700 (PDT)
Message-ID: <a8f89dfb-31a1-45f7-b67d-a54ddccf5e34@linaro.org>
Date: Thu, 24 Jul 2025 10:50:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] hw/i386/amd_iommu: Fix amdvi_write*()
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 eduardo@habkost.net, richard.henderson@linaro.org,
 alejandro.j.jimenez@oracle.com, vasant.hegde@amd.com,
 Ethan MILON <ethan.milon@eviden.com>
References: <20250724064745.4091-1-sarunkod@amd.com>
 <20250724064745.4091-5-sarunkod@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250724064745.4091-5-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 24/7/25 08:47, Sairaj Kodilkar wrote:
> amdvi_write*() function do not preserve the older values of W1C bits in
> the MMIO register. This results in all W1C bits set to 0, when guest
> tries to reset a single bit by writing 1 to it. Fix this by preserving
> W1C bits in the old value of the MMIO register.
> 
> Fixes: d29a09ca68428 ("hw/i386: Introduce AMD IOMMU")
> Suggested-by: Ethan MILON <ethan.milon@eviden.com>
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> ---
>   hw/i386/amd_iommu.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 2183510d227c..bbffd07b4e48 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -124,7 +124,8 @@ static void amdvi_writew(AMDVIState *s, hwaddr addr, uint16_t val)
>       uint16_t w1cmask = lduw_le_p(&s->w1cmask[addr]);
>       uint16_t oldval = lduw_le_p(&s->mmior[addr]);
>       stw_le_p(&s->mmior[addr],
> -            ((oldval & romask) | (val & ~romask)) & ~(val & w1cmask));
> +            ((oldval & (romask | w1cmask)) |
> +             (val & ~romask)) & ~(val & w1cmask));

High code complexity, hard to review. Do you mind introducing
intermediate well-named variables for clarity?

>   }
>   
>   static void amdvi_writel(AMDVIState *s, hwaddr addr, uint32_t val)
> @@ -133,7 +134,8 @@ static void amdvi_writel(AMDVIState *s, hwaddr addr, uint32_t val)
>       uint32_t w1cmask = ldl_le_p(&s->w1cmask[addr]);
>       uint32_t oldval = ldl_le_p(&s->mmior[addr]);
>       stl_le_p(&s->mmior[addr],
> -            ((oldval & romask) | (val & ~romask)) & ~(val & w1cmask));
> +            ((oldval & (romask | w1cmask)) |
> +             (val & ~romask)) & ~(val & w1cmask));
>   }
>   
>   static void amdvi_writeq(AMDVIState *s, hwaddr addr, uint64_t val)
> @@ -142,7 +144,8 @@ static void amdvi_writeq(AMDVIState *s, hwaddr addr, uint64_t val)
>       uint64_t w1cmask = ldq_le_p(&s->w1cmask[addr]);
>       uint64_t oldval = ldq_le_p(&s->mmior[addr]);
>       stq_le_p(&s->mmior[addr],
> -            ((oldval & romask) | (val & ~romask)) & ~(val & w1cmask));
> +            ((oldval & (romask | w1cmask)) |
> +             (val & ~romask)) & ~(val & w1cmask));
>   }
>   
>   /* OR a 64-bit register with a 64-bit value */


