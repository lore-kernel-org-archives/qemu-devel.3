Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6439FC02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 13:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc2Xz-0007Xw-Kz; Sun, 26 Jan 2025 08:19:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2Xw-0007Xb-Fm
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:19:28 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2Xu-0002os-U3
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:19:28 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2166022c5caso54790335ad.2
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 05:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737897565; x=1738502365; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5bC0DQs28jWtxdO3yTCuOncTHR7EzGAnqN267p39VZk=;
 b=VUorP5jMbjdY+Dh36HmeCO+7HGeycARBijA4+1r1rG6yIJIhkIqwhhwIcoaoU/V/i7
 84h4W3DF+Ci2ZHk1gvuQiuwPR6P3TYPxb9xmmIDbXGvMgvJqoP+K+RLngDYj6Gsz/5Y4
 lOxusGkgq6sUXsSC9JaxgR0CD4vauuUqcvGfGT3l+XYIC9hi9+lseZ+2Z7W+R1ff9Zbd
 fTfk4mxx3E+7xHBqQ0Gbu2Ifnez+43sWbQznnqeBZwRgTsyB81Sgd52SWHAvWkv6FuuM
 gtpEj3ARqiLeZhqP62+7hHm6HYGW2hyEd/2f5T0LzhIBH5pQooVcGtoesp/DC6/RxozN
 oqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737897565; x=1738502365;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5bC0DQs28jWtxdO3yTCuOncTHR7EzGAnqN267p39VZk=;
 b=WU2rg1Etr+NGCP8jgOy33kY+f/ERpyNWxNDQx+D2P1btbNHjII3Sx9xqXTWfhNrsCv
 81bJmBxtMiB7tHMINnV+tn0dZXt4daKXhYdgasGIbH/95BaGgTA7moiuv6xvhfXGWEPq
 qTvSywCjCfTz0gX03nMlY5sbeQBQwsnIxOLmQ6qsT1klD+XGuOwP3Ai2Dj9D1DHv1+Md
 7+2qG83uQ9wP/eGLATD2oENT1TXzKOxQOPDxKyLvl0oJJ2ObZzYEFE1raxo9llcyLuJR
 fN2s8A2SF3/GpEdQhtzbykUbzGdW6SyAtCRcpiT2i1z9jovYFBxZgH97R4AHOlRi/09/
 J3Tw==
X-Gm-Message-State: AOJu0Yxh7qUylYoaKj+Rcb95ISU0LC+BSM+iueeTFUz2HlYkFHoK0KQj
 KxFku6dZGF2DHH1Bm8uXGh3HIIn3qZSf5SisQeZ9NV0+rQWbbp1LMvUxNqmnoC2Tp+FzbGI8M4a
 3
X-Gm-Gg: ASbGnct02QcR1MoX29Ns9/b+II2rYFhjARltNd4eYiXJJcqiPDQrVJyz7o+2J0X0+Lm
 LXYpKHQm3UPPeV7dtK6XV0Vz2ePiGnKvtg7I9MEPjcWoYIK+3kw3sg6+9PeMvBYt08zeewqPwqG
 GyxnKL30i64mQgCxROweVsLxl5CYwEBVnE5FDXjUIKrOgzweKG/FsJUAHakumbOVVoHId0Allcc
 tojErZDLDXwQuLSsjfLrahZlK4wc6ob3bTR+HK6fCyQiByZzq23yfSitoApAd75/Xe8np+0EMXj
 b5OVAVh6HD//8wb6Kmd3D+Q=
X-Google-Smtp-Source: AGHT+IHUSPG8Dhh8nkM8mW7my8DGMTGm+GEbcjgjUDdGPkofFX1Wv6/vghrOIkBUVYKDKQ2xLid1OA==
X-Received: by 2002:a05:6a00:2d2a:b0:728:b601:86ee with SMTP id
 d2e1a72fcca58-72dafb9d6ffmr53409369b3a.16.1737897564852; 
 Sun, 26 Jan 2025 05:19:24 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a69fb24sm5164577b3a.8.2025.01.26.05.19.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 05:19:24 -0800 (PST)
Message-ID: <4b83ecea-c198-463c-9cbe-9e1abb058cfc@linaro.org>
Date: Sun, 26 Jan 2025 05:19:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 65/76] target/arm: Handle FPCR.AH in negation step in SVE
 FMLS (vector)
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-66-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-66-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
> Handle the FPCR.AH "don't negate the sign of a NaN" semantics fro the
> SVE FMLS (vector) insns, by providing new helpers for the AH=1 case
> which end up passing fpcr_ah = true to the do_fmla_zpzzz_* functions
> that do the work.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/helper-sve.h    |  21 ++++++
>   target/arm/tcg/sve_helper.c    | 114 +++++++++++++++++++++++++++------
>   target/arm/tcg/translate-sve.c |  18 ++++--
>   3 files changed, 126 insertions(+), 27 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

