Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887DAC0218D
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 15:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbhxU-0005TP-4c; Sat, 25 Jan 2025 10:20:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbhxS-0005T1-NE
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:20:26 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbhxR-0003IS-CS
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:20:26 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-215770613dbso38600725ad.2
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 07:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737818424; x=1738423224; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=340HXKDHQWtvy4uOrhN1rY+nvKLCntUPf6k0CjRv8F0=;
 b=qDA3pd6NkivqauakwFyc6w+qpVskTBZkGEUaZWsep8693vlsKRPthGh3bTRsYfF05Q
 2x0x7ZNuKijjie2HSBTi5oE7tC3AMuZ9H090ClLN/8o0bR40+4O1mxl4xqOnO+rwn+P6
 iND4akqSY0WOWPFwmsPXkrRpOE2Vl8OlIC8LujTll1fE8MUBxjTgEFTEfEbrTTmICb68
 8TvlivMV2glQJbGb5ktMTK3ORNjDVqhlvKfXomHFpi18zezis3aSsRZJPJXwg0vud0WB
 rRKVk6dGlHCkDeaAXNfyKvNwRKWFPuK4OikctgHMtDYjPiYotxj4lnCRbEFZhTNYfVr5
 FI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737818424; x=1738423224;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=340HXKDHQWtvy4uOrhN1rY+nvKLCntUPf6k0CjRv8F0=;
 b=EhvDajjKq82Ry0IxOl/Q95kbjKWKtNyAHbdZE5XXNiogQNvJcXKl+pkk610DqcyyBX
 kp9q1GeU/i8PZYLSAMucEy6bu7QX24H7JMIuLz8j42Vs5OL7pRsLMwaKy60ZOJORi8+U
 ZTzYavpvTjVD8eJqYIy3INeeffum5f7i8MLcWz9xDATePH7j3ohpS4ni6hI7rQdp1qFU
 GI8pZJkGjeBuehVX2EYINPCm1zwvnJEeuktoUyevIHBJ7/S9d0JV2yXviwohUMGBQ1i8
 oyVM6pus+b3VoOR9gKle5SaCLWigHVx0v0MIE4Pum/SafHkKNhY9ZrlZK2h2naFkBtNY
 iLbA==
X-Gm-Message-State: AOJu0Yyf9CjhczZWEAjgqaVz4uB6Dhn9PG8YNhAxg6GPrv/3xH4CVBlq
 GIvpDOl/yXG9gFZr42FnXsK9Z7tSQbkLn+GJiYZUm/5BQ+6FeJv/jCcY1RwKhvwfnMgB1v6T4J+
 k
X-Gm-Gg: ASbGncvN/lkDtQQXtNhjdkcqCm/4a8+11jH1hNUM25Mbf+xdvcUglhYvKGvuN8nowLb
 Znch4uu9BhXd7zjnGx//GN/AbEApoyhFy7SWefzo2MJ5WhzgfHQU0fxvKKBhsvH7xyJDWdgRlas
 fsmiusGUmgBzIbCWw6qf6HqyF4p0Ex07luOCe8bvQh0eGPPvThQdsDACfJ/L78M8zDI4bEfHqBz
 qLJyoku8Lhx/SxMko8vRlAAU5k6OGN7CTqIrt/4cAkRxhUWIWI0CW6TcP0eGflYBjjlfoKjVqKp
 2+KXUIqhf5/gYHbzs07FAg==
X-Google-Smtp-Source: AGHT+IFhNJohr6nJMFR3+RpLw9QtUKxSlYalhdBn25SxNKqJ2CIYMG3UfoRunW5jsRrujwe7rUnTbw==
X-Received: by 2002:a17:902:e548:b0:215:e98c:c5bb with SMTP id
 d9443c01a7336-21c3555353dmr531044615ad.28.1737818423722; 
 Sat, 25 Jan 2025 07:20:23 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea3ba3sm33538975ad.58.2025.01.25.07.20.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 07:20:23 -0800 (PST)
Message-ID: <955d9430-90f3-45f0-86af-8cd4e255a7cf@linaro.org>
Date: Sat, 25 Jan 2025 07:20:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/76] target/arm: Remove now-unused vfp.fp_status and
 FPST_FPCR
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-13-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-13-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 1/24/25 08:27, Peter Maydell wrote:
> Now we have moved all the uses of vfp.fp_status and FPST_FPCR
> to either the A32 or A64 fields, we can remove these.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpu.h           | 2 --
>   target/arm/tcg/translate.h | 6 ------
>   target/arm/cpu.c           | 1 -
>   target/arm/vfp_helper.c    | 8 +-------
>   4 files changed, 1 insertion(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

