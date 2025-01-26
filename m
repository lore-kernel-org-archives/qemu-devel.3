Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92254C02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 13:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc2eU-0002eu-3q; Sun, 26 Jan 2025 08:26:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2eP-0002eb-BG
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:26:09 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2eN-0003eP-Pa
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:26:09 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21619108a6bso59564225ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 05:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737897966; x=1738502766; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q9BYJP7Moh30TGYLe4PAQjqeJ+jMGwionj1+p/Gv9BA=;
 b=PhOR7AiOC3L8cq39SkbgehSLDzM5EwEz4CieHrATWC2vEe6kJdNxjgG5yeImrnPmvw
 oVmaKQy2rk9Zb+L5PUQsp6UAuC8CriZyNgSy9oB4YjpUY/TyH1qcFQB5tusjpr+O728I
 yKs6WuFVoarTOMgLltEx+Ggm0MXTl/K2RhJU/Dq9agnXmwC8eR63dM57ZD73RJ+3NSX4
 eoseMGH4qHSpkWjOBZv4L+LNDqDK5raxwhontHhktBB9skez7vptBzx+wcE6wI3qdcso
 b47QrWVjePVJQs6DMQkS7GABHzLsSk1ZD+WUSdRAEqNMe0VAV1tLsiI6c+Z68M3ADN6i
 7ofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737897966; x=1738502766;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q9BYJP7Moh30TGYLe4PAQjqeJ+jMGwionj1+p/Gv9BA=;
 b=tjNp8gnCMSsLgw35lA7c4CtAQZ8h4oT6oNN0nanh33C2PoCt1k+t7JvY2Peo+8/28r
 ilGDzGGIp/55mmDe30bomAya7IhE0sSLLnSeqO2ngYhbJqY2Ed//luQK5taRsCyIiE4V
 dwn+zsFyE9zjIksMKJz3q5A/lBKqGWzyS4DNWcYVIPNk+0HzVzMRNI0jjrYLNcAY8XK0
 U9JhfZjjNSy2+gcIdHYseZD7gK2p5m1GpcJ3u1HlrhM4TYJFJXfDlbsBmw9ruAelsJ01
 n4JhtM8aQ/8KrKeOPblgAChQXaU8SEsyVrJwy3HWKVpCDmkoWMsIQguCXrDXTWN6JPkC
 mMDg==
X-Gm-Message-State: AOJu0YwPWALGPZ42s0xAJ009REiWEbsn2LE0Zn0RvqMJoNEEkFMswDj3
 N+DU/3aGXRulc7S/gzG0m7bzIsceTL0/wcZcLjPE7Qxg2bGS0dc/EBk1u5WVxjxwhZuFCHpgYPU
 k
X-Gm-Gg: ASbGncuLovlh3kf2ENtfRpTuqEoBoxLnZGTRdTYPKm/ztib1rO1d5y4/i2VqNQJsW6h
 a0rucntKYuq2tflSU+hguZKhH2sctxzgMu3nIwbRkXuQviNgPRulWYV8Zu0aerl64PteQoUAJ+s
 ssmFhULWXyXbpMCWt3z1QH0+uWhXoEOB9+7ndZ2OHhobAtt8odOlBb+HgpOqcqz6cWJdXKxCknc
 7KNtJZEMvDseSi7En2WWtXkyyoIRmUvR3s+ekLo9SKdWh1a4z6py5u7o2TsnaUKhJXGbIwmImSs
 C5kHXAuKvDeCgIv41NkpIO4=
X-Google-Smtp-Source: AGHT+IG95g1SYm/CXuAdwp/a/wgu+m+tdG7a5d44f2r54cg+E/6BQ/dFgAI6DN0ljkQOhnkgyLbidQ==
X-Received: by 2002:aa7:8887:0:b0:72d:3b2e:fef9 with SMTP id
 d2e1a72fcca58-72dafb9e7c6mr54281936b3a.20.1737897965927; 
 Sun, 26 Jan 2025 05:26:05 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a78e3e5sm5368032b3a.172.2025.01.26.05.26.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 05:26:05 -0800 (PST)
Message-ID: <3351d45e-749a-404f-a47c-dacf5475cbce@linaro.org>
Date: Sun, 26 Jan 2025 05:26:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 70/76] target/arm: Implement increased precision FRECPE
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-71-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-71-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/25 08:28, Peter Maydell wrote:
> Implement the increased precision variation of FRECPE.  In the
> pseudocode this corresponds to the handling of the
> "increasedprecision" boolean in the FPRecipEstimate() and
> RecipEstimate() functions.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/vfp_helper.c | 54 +++++++++++++++++++++++++++++++++++------
>   1 file changed, 46 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

