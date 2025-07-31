Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F57CC87FD3
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhbG9-0006et-Vn; Thu, 31 Jul 2025 17:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhb6r-0006EN-PQ
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:46:49 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhb6p-0002I5-BW
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:46:45 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-31ef50d8d57so131698a91.0
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753998402; x=1754603202; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OeWTKQunOxCnE/JCQg8dxHsJdt4pV7Njh08r55in13s=;
 b=eFEmX7lV+uC2NzPMkNMPZqlvSg/kioPXB8Z4xRTz7my7vO1yP+5iDAMyI9sLsENSvM
 smaUwxkEcOwJ+9cM1QdpkJEkmM9b/QDkpj8YfR+UT3Mlp4bF37IGbkfX9ro3qwQrs51b
 m5o4hGR/wvNY3jbG0YEs2PxOsGDb/FCBM4ZT/MJmZNoj1klAbmwBKg5AiAbGXH8iV1VJ
 UZ94SzmReGE0ynVT3BJHaIgl5u32j1LbFLF/tCtfIcRyl0Q9fV+4LEC31dDCHaem5TDF
 +5kDFXyLvYrCQejfjA4p6dz2D7bVijmRtmAoNkZSslXWKwAUr18RfuasaF1bz8S7hrLA
 hUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753998402; x=1754603202;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OeWTKQunOxCnE/JCQg8dxHsJdt4pV7Njh08r55in13s=;
 b=pxsr1HN/vrWGQUJqRWQZ9jKwt0UULKpQxr2zXvUtDYnBivrc5b9oOIMUZ4GiEuKhCR
 hGflDnGW4csa+X1sfV4Ea35QYYBfxYIRAdUw7SJyno1U78CQnKsiv8+upGZ97yMAcFcN
 4VfeZbloiCN0H+/zzP/AlQTkP6o7+yTfAhvHRxO906w6S8la5fEObYta4GEuFXMy6zHy
 SRpXpfTkEPNCTksxF8+8rngAxG0aNRJZpiSqqfm3orhNAdUe6vbcaMYfx4rkK8q+CId2
 XT+P4Tcl/PX2zKnjZkLiChrlqUNZrz6nBHT5Pg6UlOwLsEmyebqbAA1n7vZqFrVG/tse
 fI1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYDvT3MGMOD7QB6CxLmtyqBoiHjfQRKGVbb+UnwqZKXJRMKMm+8BJNywokyAZn1zd5yg63PVoZKRZ8@nongnu.org
X-Gm-Message-State: AOJu0YzQlsWdTV8MOCBs7ET4G7uqEstq0GA6qbuygTYoR0mc7yC/dTDs
 EHWm328FupABGmNS1dHPYz/ulRAKOWyHHGAB6eP/f80YfAgAgIBcQlfciiLIOojw5Es=
X-Gm-Gg: ASbGncvBiewbSZyx2+dH9lh95B05UGu50R7pFmfpb5IpU53DrOJd0mq6BBz5v13Q6By
 kKPUIk3xipVGWppEk8QI0PRtKlhzj6ceUF7lSVnJLEwwu9y/0RObLt1RX515+ter2RlwLkXXMxI
 6tsvytChzBLyslv7Q/RTVKdSds0ubW+Igdd7emLwAeGrzS4xeY9pI2e5TW2fr0ETwhZ+UWGhxPN
 AlxWPXmup6RQ7shMEU5WDCZs37g8Pr96KJXv0QxVL41mPe4Tq+jdu/ATgNBLP9F1veeSU9iPlP9
 Ss1eu0AcYaq5UBeFRofbDLw/DIl/tDcUquioenRgPb4eqi428esZWjT4tNVB6UgqxEpGqj5d9nu
 yRy+1hBagQLU1DhIiCVtDw5JyzmFiMJXA3KE=
X-Google-Smtp-Source: AGHT+IGh58Z4SR8Nu8M+aHcFcZ/7FXQMkDlYZFucb/3qHLsKqg/71mMDDJUIAI4CfIMhV1PAM1kYcw==
X-Received: by 2002:a17:90b:43:b0:311:f99e:7f57 with SMTP id
 98e67ed59e1d1-31f5de494b0mr11254004a91.23.1753998401713; 
 Thu, 31 Jul 2025 14:46:41 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3207ebcfdd7sm2859964a91.16.2025.07.31.14.46.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 14:46:41 -0700 (PDT)
Message-ID: <e22bbc7c-6fcc-4e90-b70d-28b6d087302e@linaro.org>
Date: Thu, 31 Jul 2025 14:46:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 65/82] target/arm: Add gcs record for BLR with PAuth
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-66-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-66-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 31 ++++++++++++++++---------------
>   1 file changed, 16 insertions(+), 15 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


