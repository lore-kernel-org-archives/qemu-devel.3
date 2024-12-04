Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A65E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 06:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIii9-0003Wj-Hp; Wed, 04 Dec 2024 01:18:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIii7-0003WQ-Kg
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 01:18:07 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIii6-0005Hf-4W
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 01:18:07 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-385ddcfc97bso4355148f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 22:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733293084; x=1733897884; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Troi4Kqlqh8bf//v0GHKUZIajHZoWJPuHNZwYtF2RKc=;
 b=Zbar3AFhRHhaYoJp0L9WPCCEnT5RraMCd3yYFy7zjl+brbs454OPVu7W+BYvQ0B07E
 GJtC41+beQPS4+OFeb9D6G7lEaly5nygO8V4vfswiQ2opoDen8c4ugAOx6Wtrpv32ap1
 HYjDw4k8elwoHOkIFijpqkdAmBBro52pDfSfQB6gc6GCNzmkfwoAeNzxqiFJTGWKMlKb
 OirEOD0NYr2joieWDkBQz7X1hnkF1rYSoBhfT6lsPDACVGGSirMesBE0NUcMg/at6lvg
 /asId/IDi4be0pqJbb0YCs9IAXB1MG81vnd+LBE4xL1EdBm/ambF6llpIvfSHdZvfYMc
 ZjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733293084; x=1733897884;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Troi4Kqlqh8bf//v0GHKUZIajHZoWJPuHNZwYtF2RKc=;
 b=kXbAfqk96Q5sfNHoXuYiYa/eEC3cbEeedts3SXdMaWZUhEs15VlF+UQCxw7aaJPisQ
 OKLhmzVjU6CaC80mJNEUv2QOpoKnGltRPEcotdRMMjMXlLyJkk3BeGDVWoKkQotVlgDf
 /EmbN0F8uUI3ATMeUTxOTtjJfc2CBEnAiaMN13GgnMXm7gSjC9CWva0y5bte/MRNYlyN
 oJBgwYc20mArz9PX9pk0QY23tDH3RpzGUZQ/656pq3IpnUvILlx5Apfer65WhXfsLHRt
 IpU8gRZcRRqgnkzD9EBxdd8yO4AtLsqoso96oDM3RyKjyxXs8mTXB2aC6Ysv2Z4fQSw3
 Ln5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIMXXa8W3fqlcSdC80kiDJlLrbHU3K7LKCOE0n/4T5z5FlkSvJq1FdzFI1h8UNy0OqU++MC2xegGKR@nongnu.org
X-Gm-Message-State: AOJu0Yyro+WKenPqdcj2EmPTyL4NTI5tBSM03OBj+/x58fZK/Jp0DHT6
 FugKXaTmBVmwX7PXp6b9UxR9KlT578Mwx78TPd8EDuxaYv8UdTaEkMrbQbpCyL8=
X-Gm-Gg: ASbGnctY4dpcmOA6ywg9svfD+fJRjGDBKOy27z6y4TPfTVnZsiq51y6l+BsjrshQRVR
 h9XJ5h1RnyrUKWnfVfWr9VfrleUrpGEol8KSmGkZZSPQ9CNilAWI4+3d9agUu6nBVszX6QDcYuN
 Hb9hQcPg9ruUNWBZDe4+W5gD9J4jU+JYkiYnMDc+RbaJ7OX8KHp8rtuwJZIkGcR+HkeLPTKC3B0
 sjJ0YfE/UsT71lzvHZg4+exKW88rRy0RRlwT3U0aurx3EVcb1ETJFfHyKDjnUBO/EDWOqv9uRJ2
 lZRqXkUJVeQzBWeNTmss
X-Google-Smtp-Source: AGHT+IH4FoEQFBL4xXSPBrJlYcE2GjX9uwR9LzczftOgnQGKwhjg7HOOVjh2aT1SJe+Ac04lMylkBg==
X-Received: by 2002:a05:6000:1a86:b0:385:f527:be6d with SMTP id
 ffacd0b85a97d-385fd423e63mr4893144f8f.36.1733293084226; 
 Tue, 03 Dec 2024 22:18:04 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385df74157asm14799455f8f.0.2024.12.03.22.18.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 22:18:03 -0800 (PST)
Message-ID: <915f5ad0-0ecf-4a50-9ff0-c854935b3088@linaro.org>
Date: Wed, 4 Dec 2024 07:18:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] softfloat: Remove which from parts_pick_nan_muladd
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20241203203949.483774-1-richard.henderson@linaro.org>
 <20241203203949.483774-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241203203949.483774-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 3/12/24 21:39, Richard Henderson wrote:
> Assign the pointer return value to 'a' directly,
> rather than going through an intermediary index.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat-parts.c.inc | 32 ++++++++++----------------------
>   1 file changed, 10 insertions(+), 22 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


