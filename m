Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97D4C02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 12:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc258-0000XM-KT; Sun, 26 Jan 2025 07:49:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc251-0000W8-OE
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 07:49:38 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc250-0007so-B7
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 07:49:35 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2163b0c09afso65270925ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 04:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737895771; x=1738500571; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aTaeGTVEcepvY2w5UhfpXMxlVxrIbaaL1Gl239YZAlQ=;
 b=VXF/U3IyZMWOh1pvqxBMOynX9/r+ttYcy714sdiMGOPEt+svjPfx8fQTdaspRJlVaT
 AwtP6Jjjq0BZBK/Uux3hFP+/yByVOPrHLXmFBSxIaluZJxHrDOjtR5VTkSFcSv1/IvAA
 f3vDimIXrgcd9iuEEvww5kJKLAkW6rvMmWgGxyM2xayPsr7VJmbPQc1wn83APvvw8bHd
 qZ9j9iXSuf0aFrbTlmaJJon14wgX8GP6HKs9LhnKNxsJhh4qAS9Li6JTL6P3AUUju0km
 KXtxQvYf5utia59XgQXEpqCEQ9CpRi0ERczNnaoR2PlI5O6mgt5XQnPL+ZnEYH2TaZ/u
 Fz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737895771; x=1738500571;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aTaeGTVEcepvY2w5UhfpXMxlVxrIbaaL1Gl239YZAlQ=;
 b=LWA3kANFX9r1y81FfMkXAIaQMvjgWwTNAWgZVHSzuqyRL2hc/HIj1hIdhjsXeyyNpg
 c2aj87SirrKb92iP7G2B18A9RUBIlb24aifnHZcpvevIAe0+6mLqQ8y5T+6nvljuClGM
 h93/YSXz7aN7xUD3nyJzXggKiXyd+RrdFy/SNoEoafOwEb9YqE0+fAD7njwjRaF7e9Il
 aIBy9/ssRtEQnbDFCimGwKKI3dxqtoCLguqSUB1HhwV01JmXc6DMMyrjjJTQ0SGyRCQz
 i7DToK3fUmJmWmUVGY7xfUhtf8sAjjQCerde6sVpcFSYjOj1dPL0V7LRqozVeeq/LGIv
 +/Ww==
X-Gm-Message-State: AOJu0Yx3H7JlroM7MI1sbJ75TnH5AowgxjsKpMsIt4Q3+uvnBfr0X0qf
 /LZRSJ0EnX27VdwKqNJr1RlrZMcWc0WMf8onKgMQ5FbMoXfI9/tXtcqG3CZL6A7h5uOEm3WENQ9
 n
X-Gm-Gg: ASbGncs71OLVLMYooioOwm21SEi0TpKO9zbAQVB8nB0bwHRPXb4qZbz+2XneDtVSzL3
 Jx1tbiRjZa/LjuzX0B8U9T11EDNkfi7SndO/K/Eobs8TZCswlnEDrgdxbMhKlY0FLikc+DzApFp
 LXI6XNJau2grKK6rNvorcBp54xAZrlbmBINF2o0I0CcD5xg3BL8ktPLY2V6ghuP+zA+5t6hRzsB
 B0IRq4OwVJ+x+j+3Z/CTtTY7uDkhYFx+04JKIjG6a7u6dbZ83muz1khh0SsRu19oVDTvPpeUFgC
 tmSL1hrl7D9ultlJX/+fj6w=
X-Google-Smtp-Source: AGHT+IERsJwAGR/lVd1hAkTn5NfuMMOtbDT3PtPn9LcmWe1CMyugkAscpH3ZNaNmqZJuuql74hnFsA==
X-Received: by 2002:aa7:88c8:0:b0:728:e9d1:218a with SMTP id
 d2e1a72fcca58-72dafa68ebfmr42837521b3a.17.1737895771503; 
 Sun, 26 Jan 2025 04:49:31 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a6a07ccsm5148960b3a.28.2025.01.26.04.49.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 04:49:31 -0800 (PST)
Message-ID: <1ede35a7-e79c-4ebd-8c2e-556e5dd967be@linaro.org>
Date: Sun, 26 Jan 2025 04:49:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 48/76] target/arm: Implement FPCR.AH semantics for FMINP
 and FMAXP
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-49-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-49-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
> Implement the FPCR.AH semantics for the pairwise floating
> point minimum/maximum insns FMINP and FMAXP.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/helper-sve.h    | 14 ++++++++++++++
>   target/arm/tcg/translate-a64.c | 25 +++++++++++++++++++++----
>   target/arm/tcg/vec_helper.c    | 10 ++++++++++
>   3 files changed, 45 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

