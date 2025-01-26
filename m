Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3638C02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 12:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc2BM-0002u7-3S; Sun, 26 Jan 2025 07:56:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2B9-0002q0-Oi
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 07:55:56 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2B8-0000QF-AQ
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 07:55:55 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21631789fcdso60730395ad.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 04:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737896153; x=1738500953; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6to6x9gtumsaWzaEUBbKRALzyi/43SojDcbdu+LfPLg=;
 b=yRI5JX9EDG0ULnVtJNiNpYD+u+TA69ki2rs0xSeGW02Vq6kr6WA9Dm37qdTgNYZCPl
 fUiDxXy/KbnarY/KoKZ5ztlpjdK6M2bN7tvQKoaU86JRZ+9wPUh2ewDW7u0aqlk40nvw
 oNhGT3AQOIym2CQ8G1rSbhRP9p9B6taRcu43TlA4UbiGqzGu/kQkEQTpNF9V7RhfVa3H
 b4nSgHT5CaDwKpxY/2YsJkVFAntaOL37WWwCYSkjcLYcL49nznxp1LtL0MZhpT0jGpK7
 axVFlkZ8NcnF9FPZmc+XUI2tdqSlSZuo73ycGpBKUq5xOIKvUvFrcp7FooB/D+73cxU5
 1ArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737896153; x=1738500953;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6to6x9gtumsaWzaEUBbKRALzyi/43SojDcbdu+LfPLg=;
 b=lpT5sBbeihKOmTkAU/n7fthGZrpjg5rl54jUY+wRXLWCeMoZVI6sKQEPY/b0NtRcCC
 rL05dEsAFsh4IXaN5McyVTsGgmsb3mkwxh05HuNtVzuDzvjaU3OVhE82wSpWD9JJZs3m
 pY3KxNrwnazuoraqIVM4B4Wh61D6k/ZRxEJI7Uvhn2fg1vCb2sJfeoEF73Oo2VbbATlG
 +yauji5ND4R3sdFhNA5HZWAtby+bMF2weZONfxBmIRZWicZE9wag5puAiMHJsdrfUX2c
 LGeB3pLZE05GLUqR/vCEz6YiA1hYTDC9vezj0/y18SCUNycrQzm1fXrg2yJv/7cQjvF4
 cKzg==
X-Gm-Message-State: AOJu0Yx9Iu/Ih41VUN+XQX0994YjJMMc+FwNOJzD+dXHynVO1mfdgkFr
 EfffjgXA7/gBKBeyPid+r4yM/ZrsCa+4b2uNzOsxFVVWL89mmyN8PAqYeKngb1Elz7qhAcpkIiG
 A
X-Gm-Gg: ASbGncsuT/M1NQTC56drzVJ2EMY8ZX8H8kKhrPRoSjI08HROOXe1HrbMVwLuG5RJ4Cl
 lYpyAqz1iSLty1l6VrPQ0AbZrquCVLX2sXfmIZ28XwNKYvbjudsyaS7/z/HOO/xy81wZFUMzf9G
 xhtdF5483L+GuaalH7KeHp/hqIwEKrEZF57gkneXGhfh17HWj+6eP3FD2WyZRIzKxZhddqdkxon
 hdDsKaxyLpMrl3+NQUeB3ZKHZ02hbPxckW6v4EVlQDIu+dg802rMFZHtStEsthhCxJCJk5WMN9o
 65pAG81IjxAoUKcBP1HevpU=
X-Google-Smtp-Source: AGHT+IGhs3BSe9ZKgt8t0Bqk8Bcj0Z9rIvonC22qGqIu9HRL6GOpkHUwMaiWLCpyredFzEr2eySOrg==
X-Received: by 2002:aa7:8255:0:b0:725:4915:c10 with SMTP id
 d2e1a72fcca58-72f8b3f148cmr15039801b3a.10.1737896152803; 
 Sun, 26 Jan 2025 04:55:52 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a77dad8sm5126047b3a.154.2025.01.26.04.55.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 04:55:52 -0800 (PST)
Message-ID: <d36d0bdb-2ac2-4d34-8c3e-7475fb8ba63d@linaro.org>
Date: Sun, 26 Jan 2025 04:55:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 51/76] target/arm: Implement FPCR.AH semantics for SVE
 FMIN/FMAX vector
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-52-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-52-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
> Implement the FPCR.AH semantics for the SVE FMAX and FMIN
> operations that take two vector operands.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/helper-sve.h    | 14 ++++++++++++++
>   target/arm/tcg/sve_helper.c    |  8 ++++++++
>   target/arm/tcg/translate-sve.c | 17 +++++++++++++++--
>   3 files changed, 37 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

