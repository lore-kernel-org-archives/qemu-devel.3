Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65CCC71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 00:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT8kq-0007mW-KA; Sat, 21 Jun 2025 20:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT8kp-0007mL-Fm
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 20:40:15 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT8kn-0006dU-SS
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 20:40:15 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b31e076f714so2441726a12.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 17:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750552812; x=1751157612; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wiw5YQNBOS5bPRnt4+PzNAyalEBtCG+LiMWVFDPOcB8=;
 b=i0p5GEUmkZScMz0jgGC0OTDVwG5ITKe4do73NTQ/e9aOru5EDOTSyU4+z2ZlutTHOd
 86z/F7y5JBUyRnTm4C42fnbPVnTo7dq0f0rTIgvKHifxuxdHdaAQ5goOL2FYTtrzb1PV
 EbKBUtqaVN1n0U9MOAnzqvnsX1gkLFl72HZLXaPtTNc1LZ1EPcvoK64KlLwsIsXFEXR8
 7l4I2VNl0DUWTGIZRHyYuMH1WadmqqS+yZxuIjf6HNLffwnpN1yvXlXa8P1FZxSd/TIy
 dmZMutemWqC8/ZiuM2dBagANXqEmI1G0T8uyuITyWW7+YtC4M+DgLLHW8zJLSjEPWV39
 Pxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750552812; x=1751157612;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wiw5YQNBOS5bPRnt4+PzNAyalEBtCG+LiMWVFDPOcB8=;
 b=WDi7Rib51VhWN3sQ+Rm5O0dLabSZnbTlmbs5QQdx19OpL8rw/QrEnj1E2BfDtyzsYM
 Qn68z9+uMF+9qn6U+7407XVoguPJymEc/y24ogBQFFiaXyTe2M/mkdaHTwX8KqZlLU9t
 EOu7pw9b8xVhfJ74/c/LgjTrCF//x8+AjtQ5gfjhTGA2sEsvCArqCifhJiJ4Ug8lifcK
 RmDJMqkP+SmJrhIJNBYK3uUdj8ZQmtqCnYB7BJmaCw7U1Zkjj+ngkprgDPD+6l5dkrCW
 shSKPtM7QcSMaxj6Hlyr3Og1gIM8umbtyzbOP49LKznRG4kdx7DbFKBhJ+xv01Y2GXls
 +/LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3d2cN9o/vNgBJCGEji6LdjCxwmp1BS3qWMis6YzNhkd9mo1RFS4ldWzu6LtyVik2OTgdMgEJpe3Nl@nongnu.org
X-Gm-Message-State: AOJu0Yx/JGfB1OKQuL5rjQEI3l7S+5JWCmvhftjIYgFLBMRS18N6PorF
 5yyaljwA5pt+hple+SvftxfrFH4OLEp2mbXqU+2Y7U1/ws5UBIFKc7TQa6TplDwkYuo=
X-Gm-Gg: ASbGncuguIc4BYkYXvb1sm5MHLXIBV5Xp5PqhUPmEYD/yJhXBeG12o4aHUHnYybYXxI
 9UEsFj00Ez+yMFFM2ZNV/naYYhD+4Mpua3LlxZTWMJmEVRoR2ajdVygyZc9q4dmtdP7myXiNVBS
 tBl+N4yrYX22tkIdlvi6RjSXz+HJAXae6pFURlGRm1+gKEKVQf8BwGdEw02VAh7vIk61QFmLK2t
 IZNrHj17vaqtvHwvFxiMvJjKeKRurvvzDPXeJ7ZX75LadvmE+VErZGOIspQdXRtr3j9YWvjVc8R
 x6h1DjK9c70796pHXs6nPW+vyG3vmSB+1ut8EuSd6O1gSFD/qH9hrKZ79DnPcDVoszAsUPBhshq
 41YTGKphAU88MTeoYCUHCU5ctw4bZ
X-Google-Smtp-Source: AGHT+IG7qgCSEC8O9b/901auwDoJCYs8nZO77j2ftLssOcPoWdl8/K4DE5kcJaSVKUKK31miYDFYoQ==
X-Received: by 2002:a17:90b:268a:b0:30a:9feb:1e15 with SMTP id
 98e67ed59e1d1-3159f46d795mr11569705a91.8.1750552811742; 
 Sat, 21 Jun 2025 17:40:11 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f119e350sm4642136a12.28.2025.06.21.17.40.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 17:40:10 -0700 (PDT)
Message-ID: <9c20fdfe-ec1a-4e95-992f-3fab477cefb3@linaro.org>
Date: Sat, 21 Jun 2025 17:40:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/26] target/arm/hvf: Simplify GIC hvf_arch_init_vcpu()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620130709.31073-1-philmd@linaro.org>
 <20250620130709.31073-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620130709.31073-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

On 6/20/25 06:06, Philippe Mathieu-Daudé wrote:
> Only update the ID_AA64PFR0_EL1 register when a GIC is provided.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


