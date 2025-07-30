Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1562C83F26
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 21:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhDvB-0003Ls-Ds; Wed, 30 Jul 2025 17:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDed-00047A-Q1
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:44:04 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDec-0000Ns-3V
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:44:03 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-31eb40b050bso277505a91.0
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 13:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753908241; x=1754513041; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t6DcCQMFfcE2XiBGouBemSe1qWTN8iZLRtU+CEFVJRA=;
 b=ulRvrbxIQ1g8K/CsaLxR1UZheH+RDEQL7glFDpI3Rtn+4nKn9Zj6wbZOqE1RkRphcg
 uv7MIU34E4e4H0Vw1KjNXs4SeOUhOhq8LAMU2LlxdCNtgPLpBzAKVKcWo1gMMOZt2ZTn
 EGfnomX+0aiggGjYyeyJmdGmI3boB95KryGu9/GrJjLp9k8nF2ndBvIaIM94o4fmqUlG
 58GRK4vGXTWBHvVSmqtgqO4DMmMtJ/hy7cfBU2oniAKiW/kVaiAtDnDk6rCPZoJNcf98
 pKDo9zoZHddWhRhAKHGF95SnbJSHCCdJazHyPR2bn6S3PIdUyLtkCVA46CIOIO4iHZVo
 +VBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753908241; x=1754513041;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t6DcCQMFfcE2XiBGouBemSe1qWTN8iZLRtU+CEFVJRA=;
 b=McesuBUzb8UKsVSXZK4loWr3fduqhKBjKSDmfwRaIHWTCBQzKiMhed/c/UETZhHFEo
 KPfpCiO1mcdYenvCCmnafsjGw4cPPKtYV9Ev+uIdND1EEAXWGdf/DC7iW+v+DmMAtCWA
 AeRvysTrMhNKSh+C3nV9rrDOqz46dMJH+FVi901ldW2fw4m8gqz/jjcVFrmtz+J0/br9
 9sECUnkddmerKbLH4jfkSvp82qF4DPn1GpSH6rvjj5oX8tb1gea67bgpjtzxmd+fxsEz
 IAu366LC6DtQ4BMm4l4Ioe9UHm9Lj38WTeGkgTv3oqOscSx/Dhh4d8tjkTa/kCw+bfsZ
 jx7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuJHkZuYeE8ZZuehMI4cV7SqWApuM5roFI/NueaTjhI2Q7Gf3ENBJXmooVNqwO2H4KKLv57Ay+z8l8@nongnu.org
X-Gm-Message-State: AOJu0YzZlAt3mAtUhPAzhQCsLuu7+DnINDYJ8WhZekj1v1XLIF3S+0qj
 uyyo9wbES4AI3ZhvomtdF6Xu3jcr1wNzkPnM8n6e4C+VnIFTEREdol5ho1dUwnxGRKM=
X-Gm-Gg: ASbGncvI0R+PN1ITZF4kbXCKmKvoODJ+a3CNjOQshpdJ+z8HfLYlQIHW46OJCs4wY/N
 5Z+BfkkW873t8jLn4iNnS43Oh0SbdoEKmgwMfSN9skHwFC/93egsr5a+A6YagEuPgsrQSFhtIp4
 3eS7XXWI88AQNkg37gZqHM3RWfnMt9PP0LYXd/esvxNV5m7guJnUbeOZzDz+/2YTm22ih8xo+QN
 6GO+/HrYBEs4N9A+3U5MXsnHu7qSNJfqI8DqsDkB3J421JgQmE6RBgofucdqTACSiYTlCheIkLh
 ABRAMDh/QdkUPlWtyOxMJVZwkWS5nCjMtSR1LhAeTwk8H1jUkzrSe+2p+5xj8uCIhQMAmkJPMmB
 cE4Q8RnWQi2PaDALu1l7nB7Yef4ySYHkPQJE=
X-Google-Smtp-Source: AGHT+IGHLE6B6BZ6ZsfXKBfrs3zvkxdfZAZOA3U75CBiP/rrF5BL5bD742KqjcV4oY5Sw6W7qXU1pQ==
X-Received: by 2002:a17:90b:3a08:b0:31e:8203:4b9d with SMTP id
 98e67ed59e1d1-31f5ea4cc0cmr6322365a91.29.1753908240604; 
 Wed, 30 Jul 2025 13:44:00 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32084298fc3sm46474a91.31.2025.07.30.13.43.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 13:44:00 -0700 (PDT)
Message-ID: <8b66b866-eadc-4fef-bb2f-0af4e2300b5c@linaro.org>
Date: Wed, 30 Jul 2025 13:43:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/82] target/arm: Cache NV1 early in get_phys_addr_lpae
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-15-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1032.google.com
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

On 7/27/25 1:01 AM, Richard Henderson wrote:
> We were not using the correct security space in the existing call
> to nv_nv1_enabled, because it may have been modified for NSTable.
> 
> Cache it early, as we will shortly need it elsewhere as well.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/ptw.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


