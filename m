Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFB5CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 14:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yD8-0005zm-MO; Wed, 01 Oct 2025 10:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3yD4-0005yw-Dh
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 10:53:40 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3yCk-0006Zs-AI
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 10:53:38 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-781db5068b8so8845b3a.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 07:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759330392; x=1759935192; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RUIBMsGbpBirshXci8yDqtrrhh2APnLJK2FCM4aOCAg=;
 b=HD+0B16Jtp0ZA1h+0xjgDkgSyMs3qx71Y6mmy3LnQuanrkovpBIC2ZoXzy4B/7dQGQ
 08PWcVxvCR3TMbnRXbZTDn4jo5aVt0it9+s/1rAaPIGOUNQr/mTv8awO9Qc2gjPS2CXm
 EGH7PGaZ6z5BuMSJ204boeKpMqFNHMnGf9GAGsruLgJ3aUmgzod0oj+mGS2m5X588pOf
 jCpkZNDXxwqPyh8mFCfUyI6i9M4pYh3Ykv1usYfYsnn4v3HhWpIIDcjokwZ86FMJZe7T
 DOG/AcKfhXGEX6/5AmwHLNlAJ4PhozZJbotmm0mFM/Vx1RFlm+ExxMIgI/2+3/xLxb1h
 L6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759330392; x=1759935192;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RUIBMsGbpBirshXci8yDqtrrhh2APnLJK2FCM4aOCAg=;
 b=Zqc3wpBsYZYJJPz2t3lttY0rwTxAz/KfQIbvUwcA51UsKmJtoH4hjWMtlryHq7vIw0
 UdeCHrGqiMdlIOuK+pGJHH6usSVvBBtnCI0YzBYe+GP3x6PZTCULKipTxHHacpdMIw+R
 mp0PW4ezV7UoXD65AXOqYJs65GqxIfthGycVJ/hVmmVW3YgWc5DcBtJSg9ESzHELln7G
 AnMLmgQEg8cG1DErwm/qobeWzY6Iv03aklnDcDOs4RBfyQ7YRGpBw4wvSCf4kEeH9HU5
 wxrKwfM5jQ4S/PprHO6+8ErePyoSrFdqMSXWQiqf3XdzD7yUb6MUzxwPpot6hKD/SqmX
 7AnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZyIv/Ji3RQdanDCAPo2poyKmzZuMt42YCb+Ze//7yPGHD5/v6HqDSs7Mp3vrnjq7yGQG7f3A/Upy6@nongnu.org
X-Gm-Message-State: AOJu0YyTdeGr/UssIjKnp1fNXAt81JW+ycxw4snvgto69UBzpZXjJUn7
 A5q+sViXIJp+xHZXgJXIjeSn6FkN7zDPyGtmvAEeOlrGT1Q896u6Tykeh82TiUln2LM=
X-Gm-Gg: ASbGnctoS0Wh2pQ6m/Fq7UNFigZSkwbgej5KlkOO4NnHhxwivIqAgxst+TAz5YYFV/g
 UgRnzBzfFM6EDMztjlX9v/yMXRd4YiPfggTxdN9QEy9HrgxQqLAYY7LJ/sOgvq1h03NgpCHdrNd
 zYt4QTiqJcoSkwYH1+IbGN07f1mokrxuNTyz6rBLblqyEE7+C8SJKuuvzpqRpNgo8KeKYTCLOTN
 jLtJMwOShww09NRLSyM9Fp7GkTX2dBZaB9888PxtXIWnuENdMeEc20+kE5w/nE4jWY9W/dDcwYs
 dQKtCjU5A6KNzCCGK2APBxNsJIx9a/GZRKQ1L32nNK2dcEABewlYLNg3r569lvbH7AVYcmiAq9f
 dmmgWamB4h6srM1LpK+aNjLsF5XLx5cirSo7Pu3kIfxfYzs0H6UOxRM4bb+aXjojKdaMOfL+AW3
 ukC9lXr2FJ9ytKT2fQRMZKi/3r7sjdoDI=
X-Google-Smtp-Source: AGHT+IFYUEVKIhmSzTvTy0qSoHp8xpPC58R4hbKJA+iVcGy7Hl1D+c8W9pDfIzsGuH1FerIYhBpm7A==
X-Received: by 2002:a05:6a21:e92:b0:2e2:3e68:6e59 with SMTP id
 adf61e73a8af0-321dacc3c78mr5382626637.15.1759330391675; 
 Wed, 01 Oct 2025 07:53:11 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345?
 ([2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c55bdefesm16230174a12.49.2025.10.01.07.53.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 07:53:11 -0700 (PDT)
Message-ID: <931e7d7c-8c86-43cc-9e3b-aa4ba89cfa28@linaro.org>
Date: Wed, 1 Oct 2025 07:53:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/25] hw: Remove unnecessary 'system/ram_addr.h' header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20251001082127.65741-1-philmd@linaro.org>
 <20251001082127.65741-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251001082127.65741-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/1/25 01:21, Philippe Mathieu-Daudé wrote:
> None of these files require definition exposed by "system/ram_addr.h",
> remove its inclusion.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/ppc/spapr.c                    | 1 -
>   hw/ppc/spapr_caps.c               | 1 -
>   hw/ppc/spapr_pci.c                | 1 -
>   hw/remote/memory.c                | 1 -
>   hw/remote/proxy-memory-listener.c | 1 -
>   hw/s390x/s390-virtio-ccw.c        | 1 -
>   hw/vfio/spapr.c                   | 1 -
>   hw/virtio/virtio-mem.c            | 1 -
>   8 files changed, 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

