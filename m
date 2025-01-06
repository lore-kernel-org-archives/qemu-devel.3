Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D7FE77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 21:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUulD-0004wv-5s; Mon, 06 Jan 2025 16:35:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUul3-0004u7-HF
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 16:35:35 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUul0-0004Td-0Z
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 16:35:31 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4361b6f9faeso89629945e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 13:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736199328; x=1736804128; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZAOQKsIOxvNK/ZoKeLWp824sAN055XxTxJmAKig38d4=;
 b=RTmqdZMRLV/neZ4l3FQVxM3DcQKaw6vJswABkA7LVwVt71E2+CCp07fWkl5CU61h/M
 FWZoraoPX+KqqKh8JSJriJMR4jWcMAFc5Oe373tS5LiqRWx/5zR/pimBv7c8pHG9U5Q5
 Wy/Ed0fE5gaU3GTO4EmAEQ409+IzD8kLA2uDuSerW6pQTkLo4DddqJZgO6OlRFj+AIx/
 w8OHDo4G7VA56I80U4LpgcXEEkBYmbgXc8DZs4uDVJ5x4NgSYH//GwcmHEaW+jcGHqO+
 qM4uNwR17lJxaNk3NBSjbmyYRuXHwl7sDZhIwWZ2BUu2iCvpSeTuErFqcGdV/85XsEX7
 x+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736199328; x=1736804128;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZAOQKsIOxvNK/ZoKeLWp824sAN055XxTxJmAKig38d4=;
 b=jlFW461t7yF6+cOAcBOz3Fg7TrX83tWyXwvQbfsMm2Pt6AUZ+VoRE+mZjobG29DfcC
 T/e2fEW+LwKWzjhZRfafXRKizXoXfwvBpun70i2mVAuPpXA9yrOM7prTraOcG8BriXpQ
 yfhrNX6xn3GZjnALcEcJXsrOtdiiRZzqhywe6z2UIZlD/OOEtAMMyYNpfDukJ3SpOLP2
 J65R/P0rZZx1nZnyid2aZn7dmCgu5/qWfT20BV2c72XZ2bvtKdBM/pGosDFcNj/ztJxv
 eAf32d+/HIN8Fsr0JIF0OYBs+5n0IcaTAqrc+kA8sPCeBVij6EkHAvxpm951z47akxJ1
 h6AA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZc4wt6X9+IfdzkWh8+ogQKC/7KNazZHpRkx4R22nsfrdVqUidLB8tGtym9LCAeCNaEQ5FgGd6uIEc@nongnu.org
X-Gm-Message-State: AOJu0YwlsAj34YFgXV5J+puM8Pnf1NLHM/xMeX2m2lDkhbd1M1ork9x2
 pQgyHabzC34pG27KOv7b/U5uKOHPxMc7jjSh9rr2A+8CB4TfN1Zwjlp1osMRDrurgtnImt4At72
 RVEQ=
X-Gm-Gg: ASbGncv1HkNAJloHUq4oaj9/CUwYUB++ywj3XUHWkqUKEEmYX2pcTSDxjUONgdi03AZ
 pIX/qCkE2oeom8dz5YXPNRL2HgssZV1JORD7oPTQPVD8gr7Y+qaB4ea/kCs9mg3S3/kSG+LRU+a
 DYMoKq67QCYWsijuZcYVdv7o0S2AZzMfYYhzjto/GTCkzhINtB1U31/9aExF4Uk0rrD+ESUrz6R
 RYjicsdzFOf4ff+odwt6zFxz3PZVP8gCoR3SRADmDhM45n6JOaBznLYhBCZQG95TisygCxOgtIR
 J2cl8lPWCnObKYZV1RlzdGCl
X-Google-Smtp-Source: AGHT+IHa1KhUbYwpVkAC5ptftbWVvu/b5tepyRUEgc64GjU7Z5RgsPAj6a+dl2bMDD3IFNIaIu1cOg==
X-Received: by 2002:a05:600c:474f:b0:434:f9ad:7222 with SMTP id
 5b1f17b1804b1-436dc1f23acmr6188635e9.7.1736199328334; 
 Mon, 06 Jan 2025 13:35:28 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43661289a18sm575899255e9.37.2025.01.06.13.35.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 13:35:27 -0800 (PST)
Message-ID: <e8025a2a-b00a-42c8-b0c1-0a4901e33bd0@linaro.org>
Date: Mon, 6 Jan 2025 22:35:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/73] tcg: Move fallback tcg_can_emit_vec_op out of line
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
 <20250102180654.1420056-19-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250102180654.1420056-19-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 2/1/25 19:05, Richard Henderson wrote:
> Don't reference TCG_TARGET_MAYBE_vec in a public header.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg.h | 7 -------
>   tcg/tcg.c         | 4 ++++
>   2 files changed, 4 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


