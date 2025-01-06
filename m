Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF236E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 21:51:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUv05-0002fp-8Q; Mon, 06 Jan 2025 16:51:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUv03-0002fI-HD
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 16:51:03 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUv01-0005up-RC
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 16:51:03 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso155590515e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 13:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736200260; x=1736805060; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+4ynE84n58+n9bUgpqd0hlIbERudH7iTTDII5qjYS2k=;
 b=oW0tKIa5nB7xDWNh9T0/1C4u0moveiJH1eX53yFmnnbDSNx6kFYRREAuVO9YeXEXOw
 Z0o99TAf537McwJCoXzLVuynxT5wukMQ6GXxKP6qSB33/gUT0eoTR5V6Uy8Kp39jfcPh
 SaHAyxxzZVYxdxFKFjBdTiPDkCJv6iIMxel0ICfe+8BOEHYR286Sxrpk0BOACiATuCQZ
 qA6nCbBJjCbbCXyprO3NBmSWzhPPbTldFzLz5d6qsYu9s95jzMZv2yqtav8dczzUcO8m
 v2Ft8vrIN8mMJXZLb+2l4pSKRH8TEB3Znc9/yvWo7J252IfVwhzYF8ydEv9tG7tt57oB
 w1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736200260; x=1736805060;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+4ynE84n58+n9bUgpqd0hlIbERudH7iTTDII5qjYS2k=;
 b=nZjkxdxWrutTckgqCR+m77S0IJ3Fi2f0gkyhfpcOypJEKlQ6qDIA1RsIZlrHlpEPAD
 nSqQVXQw/2x8aL+f7cOktIH4NNn79khJeyKa3ouTZBLSCk8w+B+4RzDpkp4bZCrSLAQ3
 Km8uIk5Dva38kTnryi+K/NWUB2EL9H9p5x9+aJDAbBN761Vjznexk7PE261pFvLn/Qbm
 qqvIZnmURPLMpEWPum/kBTYBLZ+iZzpiD5uiiGeIXubkCnC+o8kh0n7ZpM9KgoY04mww
 oo/x36X9C0B8fd8DZAwzre2sf1CZn1d97zxT7NsltVMy7xYd5awvMzEuVWOzWRGW0ZDk
 gKOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgGrsZCB5HIqzGn116EGXmDYX1WuwP4dzC8q31bQ+bv1Ko/ONhvQGGpb+rMLolsE235jb3AQMXaPIo@nongnu.org
X-Gm-Message-State: AOJu0YyH8sOnV5ajHlq5TRj35ibowlAz0DyjRKfhxJaZcb/FdZrutk9D
 hQVxjp72x/PBjL11hPBQvl52t/Hi52ifEoer2wZ/Eh5ZbwfDCTo296SidztHrc8D5jAbTPPEnGe
 QTVs=
X-Gm-Gg: ASbGnctcnMZJtBUkKHSoAH+myCmsoFgvii1fnEMe2Wfqgw/bdeHKjAlSynb2rB4zy70
 8BihefkkrcaJQBykhoqabxgjjJyYIYjXFjYNGbAL7ZmuDuahZaZ88f60y1OxPcpRpP9m/DAmNCF
 KRCvHWf1HU7F0MNX8GBv4X5p+NYpjfmn63Tb9DiKK6Dz3da7MDinhdzPTdiYFi0WzSsWdBjaSX5
 hFNcAmisnmdCfhwJmXibx3lSTChH++6wnXkyS4hDxu82k5IgAbAi9tcwZIIxoFBJTZXhmnaPuj8
 xbicx8EY1O/qHbchuZ+KAA0s
X-Google-Smtp-Source: AGHT+IFz4tuYeuxSThCFwgc9PkpUJmXX9/sm/iX+ap3pe8ZTRNIAJA0bHsHttYPuiP7va7bI6edvzQ==
X-Received: by 2002:a05:600c:1d07:b0:434:a684:9b1 with SMTP id
 5b1f17b1804b1-43668548986mr500348655e9.4.1736200260130; 
 Mon, 06 Jan 2025 13:51:00 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366120088esm577101955e9.13.2025.01.06.13.50.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 13:50:59 -0800 (PST)
Message-ID: <6d5ace1b-099c-45f9-a383-365f74e4fe5c@linaro.org>
Date: Mon, 6 Jan 2025 22:50:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/73] tcg: Merge TCG_TARGET_HAS_rot_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
 <20250102180654.1420056-26-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250102180654.1420056-26-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 2/1/25 19:06, Richard Henderson wrote:
> Only the integer opcodes handled here; the vector rotates
> are left for a future patch, as they are split by immediate,
> scalar, and vector shift count.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h            |  8 ++++----
>   tcg/aarch64/tcg-target-has.h     |  3 +--
>   tcg/arm/tcg-target-has.h         |  2 +-
>   tcg/i386/tcg-target-has.h        |  3 +--
>   tcg/loongarch64/tcg-target-has.h |  3 +--
>   tcg/mips/tcg-target-has.h        |  3 +--
>   tcg/ppc/tcg-target-has.h         |  3 +--
>   tcg/riscv/tcg-target-has.h       |  3 +--
>   tcg/s390x/tcg-target-has.h       |  3 +--
>   tcg/sparc64/tcg-target-has.h     |  3 +--
>   tcg/tcg-has.h                    |  1 -
>   tcg/tci/tcg-target-has.h         |  3 +--
>   tcg/tcg-op.c                     | 15 +++++++++------
>   tcg/tcg.c                        |  4 ++--
>   tcg/tci.c                        |  4 ----
>   15 files changed, 25 insertions(+), 36 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


