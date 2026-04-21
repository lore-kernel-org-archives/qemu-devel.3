Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB83EF94CB5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 22:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFJkU-0006Kf-Iy; Tue, 21 Apr 2026 18:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFJkT-0006K2-0B
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 18:39:17 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFJkQ-0002NL-UC
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 18:39:16 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2ad9516a653so24684765ad.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 15:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776811152; x=1777415952; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b+1Bfe0n3xmz4i8Ycm22g0rpBfwGidicljo+vzxfI14=;
 b=mIfIdVJaoArvd6KOSOQBoYxgpxOxZay7B8anqzXnR4bibao+mN3lZi0VH06K7UkgmE
 Ct9SBhLpVjR68jduGnOqBYRkABfBt+Fz/Tk/GO7OFOj04LYhH2uNYCEUVjpSgMIi1p1S
 7M5++ywFGQRc/zhGsxm792lTvVK8Kj+CLep+UJ37zT70GWyRXkE0ZEMxcBRrvqHdcJn2
 jS4C6YqZbppXJJgIx/FitCozkktTaa5OBsx5Pg20PehOu8vQ6XjFbOt9OJohl+BUf8Hv
 KPerIaezjrtHlcyRSo7NZXnwsbWq7fZc1KE8v7RiJgLXxeFc2KzAwt5W/gcq9394XDgi
 iXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776811152; x=1777415952;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b+1Bfe0n3xmz4i8Ycm22g0rpBfwGidicljo+vzxfI14=;
 b=sv1D1naiAFcNdxhRWOBglca2vTHiHY3ZTenxp63D8QIa1VwC4K82C8jKyZsXLad4tj
 mM7KbRRPvJgmTmb6yFx8IwvVloJuRO9iSO/t97BYPRnDwj2GLR1FExoGUF/qGp/tdF9d
 qTlMYa+YRWtoBPOfutZM3fak0WozoOEcKypVF6uzbhF3BfOG36dzxhRqbR9FZCUZiZT5
 DW2zaBaahUq9U5ossSifO/hrwJyyN1as53i2pJQ7Dk6JDSxMPLdk77ncI6IvPFSwnViu
 1Gl6z6Q9qxIYN2Pb+nYEM/mdJo17aZuwsYd8/dS/hYYBxwvrnDIu3NuwQiHJa957DsvK
 c6+Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8rAU5Ygekebo1BZs4eSg4T5DZ5l790gLsXtVCHUsMFjmiaW/vnB1LXzMdmjvJZHUskdaS2MFjl4fkg@nongnu.org
X-Gm-Message-State: AOJu0YyucmKA4Y+WQ1Ry1dNv9q3Q05OVeKVPMMAoP3ZNA7SrTH5njwRX
 Bdmsrzb9euKvMqPRef3+JJlpUs/co+uEZPkPZfYtyDbP/L5yib5oV8LlG2tWDhUFuLE=
X-Gm-Gg: AeBDietBionqmJm6N+MaRHiY4JtR28JlE3nRcwgbT1t6Ysf3tOsfncOHTuqUzT25Bfy
 yXzi6vM56YV6wUPUkWZwko3rZARSYZV8t/2dX48+GIq1AW9XEODrGWyv2YPRqll1r2JAGIE7Ubk
 qh5Lo0nNqawH/mLzgS1TPaNDUWWxHpWPB7i2RGEV4Y/scqPL7BAbojSeDdTQ5123+PvKLZMMpik
 o5vEfE9qa9wTOLUdiep2wT97H1SHh6vK8pfEXUEVIYSc6n7L6JrEVuFPNQZSnF3zUr7NnSDhPGt
 ceW3fG4DpuNUj5OWpuCtWNz3pTATrQgN/nfRgSioPaUr1AZwf9tymdDbSCUyroq9u8vikNMawDP
 xKDLi+ifbJ8aYkcFjloeB4bN5to3DiNWambtcjM5qYmA/ist97bp9r5Yx4tJlle8GHHCgnVS713
 EF/r6vO7yUQHdbjVKetBpcGhiALwH5gDPRJj3Ujyk3OgK14Tirwtox
X-Received: by 2002:a17:903:17c3:b0:2b0:708f:4dc7 with SMTP id
 d9443c01a7336-2b5f9f3b367mr220050275ad.29.1776811152335; 
 Tue, 21 Apr 2026 15:39:12 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa2df0asm145459655ad.26.2026.04.21.15.39.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 15:39:11 -0700 (PDT)
Message-ID: <66b0fb99-6783-4324-a0fe-86dc1087ada4@linaro.org>
Date: Wed, 22 Apr 2026 08:39:06 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] tests/tcg/aarch64/system/rme_gdi.c: Very basic
 test of GDI
To: Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20260421-jmac-feat_rme_gdi-v3-0-ecd20c77eae1@linaro.org>
 <20260421-jmac-feat_rme_gdi-v3-4-ecd20c77eae1@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260421-jmac-feat_rme_gdi-v3-4-ecd20c77eae1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/22/26 00:22, Jim MacArthur wrote:
> Simply tests GDI's prerequisites; that if GDI is enabled then
> so are FEAT_RME and FEAT_RME_GPC2.
> 
> Signed-off-by: Jim MacArthur<jim.macarthur@linaro.org>
> ---
>   tests/tcg/aarch64/system/rme_gdi.c | 46 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 46 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

