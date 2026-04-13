Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7114EF531CE
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 23:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCQTS-0002wD-Ik; Mon, 13 Apr 2026 19:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCQTQ-0002vm-TB
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 19:13:44 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCQTP-00016L-KE
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 19:13:44 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488971db0fdso48987445e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 16:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776122022; x=1776726822; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eBagoQCA4FTWyyGjduWY06bgHHk0SDGqbr+mNflrSnE=;
 b=vPGU5rab73UVj2hVxP+UFQLz2mrAGssECIfRmQV2DRFGeffG57kZinyyFjY/zOBfyv
 zmmcvE/ze1TTdZlAwlFnoBVHjSz9QIwnpuaLHxjZeh1RZoYo2WPp142ybAZVFuIlofbT
 ZFm50Cp2A5QmjK/7929y4Swk1ZCmHbtzKTEGqrt6BAMl/lEZ4TyEZIjc0/MvWXE1xV4K
 WjECefH+V6zcTj7olcnFL7VsQ26r9dnctgnxoBaQRZsKUcfT3N5RCfa1LnDqnxmDNNV/
 UxS5n/2KJ066sW/xwZJblW91iyLJxIE0453khEFCAHkzyf2miVt88ko8/hwl1jVMusBc
 2GaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776122022; x=1776726822;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eBagoQCA4FTWyyGjduWY06bgHHk0SDGqbr+mNflrSnE=;
 b=hcZsT6QG/qzR6+ifVAahgZXvBdUVNt3DP4exY/YL0UjFyym0YgH2DeUBN2P12S6ALy
 /8iPCAg+KnsMewqbR2YaguQSsDQ0aZSVgNeXYzktHRHWT3Z+AzXwax163TsP6K2rlf9E
 ZTLyh2j9q3YOs8DDIx+Cbatruczi9SCU7y4A5/YK+VC4BxtmiwugFMQLWNdmwdSO5XhH
 i9RDAXnkp43k6bKYbHuHZpQKkmM7um6LtzUDJYfws506G57oylJT37aRI5TUT98WR0wX
 MxBnnEhRUHs/roNVzDORgUNHtazc3dj2jvl4DMgnOeXQJqjdqaRWnkZQoIozVMVWijZH
 ardg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+zx7ACpZPofmp8UkUUeiow9AdCA4T03BbSrnnbcImE1L5pJWTKmGVawtp4o7vVSZD/2jcjF6QqlQ/r@nongnu.org
X-Gm-Message-State: AOJu0YzpCRD12R5V4ULCCLphiiJonRzy9ZprjxhQ/+bfi37PJLeO7AUy
 JzO7zF6WT36/ZHnAFLdKTbnJpERlEtSwcCtoI0fLsAAKmZ32IGJxAoJ8Zgpkv2PEACA=
X-Gm-Gg: AeBDieswsEbqcif38wMIN8UsEdWWfyJbx58awiSX4REFthe2SykrcKbrzHFAgVkc7ln
 aqDdxuUfWeqvAvxD5IJ8nxTJTl3QYyCnV9cohsEmV41XNskslSKpB0OtdOCtjJbDDwLBSqSZzdp
 EtzOZqJpctzDUuBF/njAEsTeoEHlTf+xl+F+m5e59/LqwYLUvGoEJlWycNqcMcJRtcQ4SHpj9kY
 QjmFihzqmE3Rr1kwhRlHTISy218WjXJhqN+BUSsk+n4Z13F8iZsF0BuWQKK6dFT1N2IMJX8Q8Wq
 zkvYM5iHzoSAL+FstUNLybsBlFyAJjiQydLKqizOpnyjNPEfig5h85VjcvDN8nobzw4/IGa11R1
 qHPIWzOWaVHWo95J/Pf+kDfAbCBZMrZM/s+bZqQwcPOo9XF9Vmi0yvaClQuYzTFjMnJ5/TQ0o7J
 uWOhkKoKcDxpmUb8JkrU52p2paoIbEa8tseDbXMMYm2acHiLsquWfEijWBAuF9RloUzA==
X-Received: by 2002:a05:600c:5299:b0:487:1fb4:7e1 with SMTP id
 5b1f17b1804b1-488d6875f3emr201677885e9.22.1776122022176; 
 Mon, 13 Apr 2026 16:13:42 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ede156a1sm1979155e9.2.2026.04.13.16.13.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 16:13:40 -0700 (PDT)
Message-ID: <8bdb52d1-fb04-4478-8a1e-2fb29fdc8edf@linaro.org>
Date: Tue, 14 Apr 2026 01:13:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/65] hw/arm/Kconfig: select ARM_GICV5 for ARM_VIRT
 board
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
 <20260327111700.795099-5-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260327111700.795099-5-peter.maydell@linaro.org>
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

On 27/3/26 12:15, Peter Maydell wrote:
> When building the Arm "virt" board, pull in the GICv5.
> 
> We haven't added support for creating or wiring up the GICv5 in that
> board yet, but adding it to the Kconfig early means that the GICv5
> code will be compiled and so we can have more confidence that the
> individual commits building it up are correct (or at least compile).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
>   hw/arm/Kconfig | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

