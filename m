Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F55CC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 12:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzEc8-0004OD-ET; Mon, 31 Mar 2025 08:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzEc5-0004Ng-Bl
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 08:51:38 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzEc3-0000Wc-TE
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 08:51:37 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso29322455e9.0
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 05:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743425493; x=1744030293; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4k9y3zoPhxwIjkLfasmIyVn6tGX+TjQOdHwLDepng1A=;
 b=IJO2ugG4yhyazLC0suMad68lnQ1tRMliSvgeEiw+HUGFNn98On5Gx7Z6H3mj6Q3JM3
 +rS8jOIFQVkaEj/TaY5fjxYJWNb0n0/92P9je5SrHsDOHffcjvxeBOmvxIntlaCbJd7l
 Mvu+IrBULjvxuTIQqoMDRcMZ/cbwy9bv5+jej4ttzj3HasXhRwvJMS+LxBRyEoiG1+dn
 F3+u+0VdUzMdFaUZQEcRA8vFy0Spm2n/Ss5fTem4NvVYevH4/ulDSN7cTrk6HDdbYkH0
 Us1+ZVWKw1uK+Liclp+6gSMi7VShEVQLaP7YWP+5UbgGyLn3vLDnaYyFkFXnCH1+NN4+
 yV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743425493; x=1744030293;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4k9y3zoPhxwIjkLfasmIyVn6tGX+TjQOdHwLDepng1A=;
 b=IrfZ2iU6Tpr3t2buoJ+tu2z7/RlVOAw9NUIw7SDMi9YdHRmin/cUB/f+5F5P/xQAsW
 Lvcg/orQ3lGAU7FNiooiyXtr98zGSb6U4FmEFBFXoe/pt52+xjtH/K+rwLF2O2NPHBp4
 Q7c8WGmw0FuKBztpXj2lTrnISKXSgN9PhNs7n+/PguUoescNwqKP+sxsQWuGHXNvg0RU
 VbW8aeElUU+rqtwWpC03aDgyaCGA60uFWD/bLJWqjbBSr4364qJCNMyXvg2xKXNw+hwX
 avEQ/bxh20cbejYDkQUipEDm7XCfqCCXJbWIb4qxTNYyWZ+yx/MMY76Q0X9UxBKmSmkG
 hMDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+kJt+T1cVATvqKkL0Y3mGzhFR76HIYB5K8fyaVyTubjFsa7xt5/f1gZ6y7Azn2W2r42CbXI9Jqii1@nongnu.org
X-Gm-Message-State: AOJu0YyLfe5nEU3j8WerXrO8KZpYw8YA06IFnvABGW8t9FL3oCvEvzfj
 1O4Szm98tXKlvGvkmzBUo/xauDrloisOD9jJ7cF0hV2fW8B37mGwOriX+b0wDOk=
X-Gm-Gg: ASbGncsAHY5hWeTiOBrBkHzTShmykb0qymi2q7JyyFrHz8uPshhwUw/qw/dHXavos47
 Abj4xrvV3VWXOX1fRGsuWcfwsu4LnnpE5CTLqP1OAzJDFi+PIikelejebHgWQT8juVBH6YkRTvf
 AljJfZ94suuVy0RlNrpllKotMguMwC1O9A77RWtY19lNHzgPlowSkZpR7jKFTvv/ff4jpWKdunk
 pLkcd0ZcIB3bJcwp6XXujOO9csOrG6jb6UNChRqY52x4P5xbY2OxJmUR87BSGIda9g9iqxEHNTI
 TAhWHE1E+1vvGScLPNCa4il/IXDdEtOZpGUmvpsC85RZkPSa1vn2S07oXqCaCFrbrkip1YjHVv8
 SV+B0a/Ba0Uc6
X-Google-Smtp-Source: AGHT+IGkte/wY6nUvORNxtgXDZ2zbKLE8M8k3P3pgunjgOpUk6RH9Oqbx+VEo4tQrG6YX37CXDplHw==
X-Received: by 2002:a05:600c:3d9b:b0:43d:10c:2f60 with SMTP id
 5b1f17b1804b1-43db62b763dmr80091195e9.24.1743425493628; 
 Mon, 31 Mar 2025 05:51:33 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82dede98sm163822425e9.6.2025.03.31.05.51.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 05:51:33 -0700 (PDT)
Message-ID: <063b3942-1803-4aa2-a93d-8753fa7dc9a9@linaro.org>
Date: Mon, 31 Mar 2025 14:51:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/mips: Require even maskbits in update_pagemask
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: chenhuacai@kernel.org, jiaxun.yang@flygoat.com, arikalo@gmail.com
References: <20250328175526.368121-1-richard.henderson@linaro.org>
 <20250328175526.368121-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250328175526.368121-3-richard.henderson@linaro.org>
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

On 28/3/25 18:55, Richard Henderson wrote:
> The number of bits set in PageMask must be even.
> 
> Fixes: d40b55bc1b86 ("target/mips: Fix PageMask with variable page size")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/mips/tcg/system/cp0_helper.c | 23 ++++++++---------------
>   1 file changed, 8 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


