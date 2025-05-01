Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4E9C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 17:25:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAXeM-0006Z8-E6; Thu, 01 May 2025 13:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAXeK-0006WW-Vc
 for qemu-devel@nongnu.org; Thu, 01 May 2025 13:24:41 -0400
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAXeJ-0003lE-Bw
 for qemu-devel@nongnu.org; Thu, 01 May 2025 13:24:40 -0400
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-86192b6946eso38183039f.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 10:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746120278; x=1746725078; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PESa2EWIPe2bExzV3WBntjNQ2/i6tmGJ3AQjvkw3rSM=;
 b=t4KaOlfQ3Df7zk50hH/42DETPlhOa8XatY/OMnaXPoPKnDhStk0yiilEsnu9mc89n7
 hyOZlsShnZpRaKDXLY7ZYbDerGxkpRKeOOGqJ3tKArRGy52e2oEEEWCnlQ9XSQCc9X9V
 X/MQTx4xqVy1Tens9LmlMtsIPGfa/0W96zUxSrB+yiWxCyujhkWI7y5Fty5Gozzd5eif
 9Y1up2f2UksHjs2/MtEURE2RoNbodJXyQtR1Ws8vvufR+Kxofyu45BPTfeEYG1yeDOz2
 ls1zOu0joq4QFoi1KaFpW9AkwHdH68p7lwMg2XwAWZwpkXTJB3oZdX1aHssd+ELVJ7WC
 UKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746120278; x=1746725078;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PESa2EWIPe2bExzV3WBntjNQ2/i6tmGJ3AQjvkw3rSM=;
 b=chI0kn3lbrQdVTekuaoP4BRnzM/GRyIYGVjQOh7I+uUN1TBwNhp+ISh2AsSefWws0s
 pqK1wxgF0dDUPUhGPtSFpsYM2iljTXqHo+fZug71++7vsDx9y9BOkqovPnek7gZVyLZL
 PdKzf1Hs8QimjyVHxXxOa5pegLCJOwewMzVI0rmvMwVq+d0F0M246YAsfBdpMzQBZdS2
 nrGI86+Mh7oQCtnhXYfjLaX1E+0mBROxrPHn4aMo5ckZTqUnVerCS3ACylUToCuC3fVh
 f0FLZxrpMbvtm/TlHS0UFWwLHuvE12atv6h0zTgo+yVXfagjNOnla5kDi4h/bG0wVFTp
 AfoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLm3C46tLfSwR3w2HiB1R/d+NIzkdAVc8sQScfuwMSf4/0E+NhSFmZg1SvRJMJnsGVPAp11NV4qi1u@nongnu.org
X-Gm-Message-State: AOJu0YwIVF2GawDZijTdH+5AoqhctCN/7xtTqWKHy2Dm8ACqCWf5aB7+
 hIqsn0A6bUYm6mG0LSb5+RRXBg/1dQ/EZsqfBsMQRHOcCZFF9CHkLOSC/fBj2u8=
X-Gm-Gg: ASbGncuqOQYyGfRVjzJcfkdNZo7gh5y8kPIZcNBVCrpwuHi0XpidIIxFt2naPb4cgf2
 8Atft0AWHO0RLk3kcQKsvWbGbmNmBDNRDbPK65OW+OBxT9mW6356q5ASDFEidiaKAtT1gydROIx
 PVWAdcLCDCLbz1qcj/oZMtKut5K4jRMgKLNozKor2SqqS0jlCB0dzHulpK4ML7vC63AP7tVhvKU
 LgzHd3GiLeXGXc3nVXhHyRYftcWH1kr6WnmEVos3HCpBQpVbUwwNVL5VSNq+A31ogVbC/oVc7Tw
 Tddvq+5QDAtdh7PcEHgTTn7xKV1PcufJXI+rfO90wDM2xQJs11KHGhiK+7MAkHBCqvP8KEGLji8
 qwCR1vcl5
X-Google-Smtp-Source: AGHT+IHLOjY/1m65VuH1KzdhT6P2Qd/QwW6S391N9sxO9H7J7BGb3llp+ITIgJTFpxDx9jUnVx/gNw==
X-Received: by 2002:a05:6602:6a94:b0:864:4911:f463 with SMTP id
 ca18e2360f4ac-864a228cadcmr448345939f.10.1746120277852; 
 Thu, 01 May 2025 10:24:37 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm19184339f.4.2025.05.01.10.24.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 10:24:37 -0700 (PDT)
Message-ID: <cd84d81c-b66b-4310-a3c1-308203906239@linaro.org>
Date: Thu, 1 May 2025 19:24:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] accel/tcg: Move tlb_vaddr_to_host declaration to
 probe.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250501145520.2695073-1-richard.henderson@linaro.org>
 <20250501145520.2695073-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250501145520.2695073-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d36;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd36.google.com
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

On 1/5/25 16:55, Richard Henderson wrote:
> This is a probing function, not a load/store function.

TIL.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/accel/tcg/cpu-ldst.h | 16 ----------------
>   include/accel/tcg/probe.h    | 16 ++++++++++++++++
>   2 files changed, 16 insertions(+), 16 deletions(-)


