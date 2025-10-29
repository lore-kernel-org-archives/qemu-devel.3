Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4786CCD1BF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 07:58:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE14e-0000Wo-Gf; Wed, 29 Oct 2025 03:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE14Q-0000RJ-G1
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 03:58:14 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE14L-0002m2-Vn
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 03:58:13 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b3c2db014easo323209666b.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 00:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761724686; x=1762329486; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gN14jhxPp3x68oCV0O4XL2sH4eaKsDY4UNImc2uskIE=;
 b=AJFV1eSUOl8FJcZxqJ+SubSRC20YeI2xE4JjQ61U4093bmTTlRCrXpKt9imHB7kbj2
 65S+xJvMU4GqWsg+Qpd657VN05XdPwfh95opNQW9pGl4CvUsMYm7M2ZSP/Lml9ELRDlp
 PzGtnylwf40kZohsBMJT5DErmTKOdnW4fdinIzPk0aaEt+bEXMCp3YiSEifwn7EwGSeI
 jV6r4gzITFh3IgzyN28pQIYV8BM+jk1DHss1P+kJZQRA1GTynyWcDv+9pdRx2WK2jPa9
 gUtBE+z3VtC6U+TKN8IyxlKmCGjjEAD8j0wxcWx6i3Jf6K4a4qZdkQ7qORtNrT/vjy/R
 85oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761724686; x=1762329486;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gN14jhxPp3x68oCV0O4XL2sH4eaKsDY4UNImc2uskIE=;
 b=aFZ8S+QlQXr623dLx73TFmizdT3FWV64TiaILwzpcRDReJlu6apf4qM0+RcPTs13jb
 /Nt2FMcT1b6cbUNosXPTVHZDmzOz5ndvUzRCJuHcythHZQ/SgLiJ9od0KHjKI83akaQk
 CnwPPNw2i7qAUgx5CUiQx6r2czmT497TYk3b0mNQFJLu68/8uCmAAkrAaYp5fPYoN5Be
 rVCB4HJf8Od8Qn6Nztafn6t2JIPXRhksuROuqWRNK0aQALZiSYj6RfOIJ3YfrKo+oqPJ
 +95emNOFKdL5p1r9AgdhbhiitNKpEwEwwN/yoeVeFLkapkf/Q3JIDmnLuq3r5SsVJgoV
 cwCQ==
X-Gm-Message-State: AOJu0Yyt9pK0V+lV/SaoIB47Rj0rP5TJV6EbL2/tHI15PWpbczInxNGd
 VrdMWkbbaanj9hQQryGF9y5HK5E2WYyCuNkwk9p27n/gvFxg7O/L3HYvr2Gxu3lm3onFmY9T05F
 WFnAxEHs=
X-Gm-Gg: ASbGnctY5rnLJb6asjbc3nIVL+OddYl+rrax9KNwzYc2G6fl3wwh0rQZhOd2nYJDFHN
 xY4szpRMPwHn4WgzR4pKRWAuphFwVbiR/EwROE2S0gfWP+CYDhawiJG4bxc01paZqDBHy+eIE43
 IQH3MTal5p33RwB/uYX4ke9BCDyA6OpnGacbmDPshg2S7G0LOst6Qn4CE4SGKuKWjT4jKZiKlEk
 jW4FhAgbPfTT/kHRYqcKtTO2BC1ozVUBfheRGOEp6CVYvbtS1UM3Vnbfz2n6ZkL2kCowV5Kuh2o
 SAWTc2xib2Gu57BMTMvwzwDjBWNY3yF6P9+uzUGolojzregpsJC34knInvl0haja07jvLI/kQIE
 EdFr0rc5uUcEUOQLHMb3dKvmfQOXsNOw6+Gu+KGVA4zNPFW3OfFBtAfyXrTyJ1Q2OXygDZO8L9U
 ZSYFxsSxhvUzlE5LgH
X-Google-Smtp-Source: AGHT+IG1EMaC0/iuOoV90Y/NAYZmjOQ/vmn8+CctL4XkjpBO8VgEKqKJNsgR9cAwgV5l5pchzJAgDw==
X-Received: by 2002:a17:907:7249:b0:b6d:b9cd:7df4 with SMTP id
 a640c23a62f3a-b703d5238f9mr209823466b.38.1761724685598; 
 Wed, 29 Oct 2025 00:58:05 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d85308039sm1362989666b.8.2025.10.29.00.58.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 00:58:05 -0700 (PDT)
Message-ID: <95dc2b35-65cc-44af-886e-3207c11c2517@linaro.org>
Date: Wed, 29 Oct 2025 08:58:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/25] hw/nvme/ctrl: Use memory_region_size()
To: qemu-devel@nongnu.org
References: <20251028181300.41475-1-philmd@linaro.org>
 <20251028181300.41475-9-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251028181300.41475-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62d.google.com
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

On 10/28/25 19:12, Philippe Mathieu-Daudé wrote:
> MemoryRegion::size is private data of MemoryRegion,
> use the proper memory_region_size() getter to get it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/nvme/ctrl.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

