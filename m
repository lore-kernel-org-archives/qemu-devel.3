Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA5DC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 07:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti6xB-0000OF-6d; Wed, 12 Feb 2025 02:14:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ti6x9-0000NR-5W
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 02:14:35 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ti6x6-00008Z-MQ
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 02:14:34 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38dc5764fc0so4931940f8f.3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 23:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739344470; x=1739949270; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xUfQhrZQMsdq9pOGm+RfOm81Wc0eOy+bzhKt6OtEr0o=;
 b=sLiwwCadLAdG7bCH1KMk/xGpN1lvCXfJKWKdYT2HPTbbicM9FvipXsshtfY43EBSLz
 JpTaEBLzcZR9z+TnnzWICyAqIkTq+FK95bX+eU1dcZtaAo9SPfAKaGyFWnWEZUu/vNa5
 3rjgdK/0F/JCLEeCTTR/uVmarlre3VNvie3HUnVk4zFpGh0yNeIVZUjbbZcfc4R2iCvs
 JbI/NBmbZiP5+B3Ls1stE0wcNtrqqkF6lt8MjwhUifaPl4p1P6IpBOdWEyCGifc06mGf
 tm+eAKogM1qW6Av5v3Pf0i5cxpJpBGnLvC5PI/HE4/QIyFqcKlVcp74IwQ5PzDlpdp2G
 d/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739344470; x=1739949270;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xUfQhrZQMsdq9pOGm+RfOm81Wc0eOy+bzhKt6OtEr0o=;
 b=w3n8J6RoPgfajWXPf/ja8sSI1hcUW2xF5Rm71oNkZM6v3G2ZsvhLCnJhg2V6mAlCRW
 a/SJ7eTgKCxuEQI/3lnAypeGcx3shJBDjzilA8IdeUh3EO8lrakCcRLm6sbmZx18mv6J
 PUgS9yuP0edcSEio474vF6H9CBurWUAy9juFBjuPOrEBPkN38LmoofFpvrxDz1nnv+Nu
 J4PWb9ujCsz34jl9twa188tnFKBi6UNH9Ah56qml7JjeDitwM7ZSWJ61ch73IAm2OVW4
 oK2YLhjHIrxYqfqFdZiv0MTwtEE2k1rB3ZGCNyWXgs++/v61gwKUeDnw94b55s2w9SSP
 7miw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjlC0FaxxYEKr1XGstO8AygCb8Y18Wlcp9vx5G8zI4vFsWQW4qyyv/ESb3ek7cNEaNctRTffnPOJGG@nongnu.org
X-Gm-Message-State: AOJu0YwyN9q3Z1ymlvCERhbnQpGCXwr2KvKVTcqFZoIOl+voWYYwEYTD
 tBaaAPZlOw8k9UqSZyvsnciCKKfK5OWMD4wCWQWQoS/xqhIv9KgEHIItWtj3Iw4MRYnh2Nz3Nc6
 3Ml0=
X-Gm-Gg: ASbGncsmrX4QdOKaS0lpuf1qS0689gU/s19Hoqoq81WrSPtwmEFm6cEIqoEGE7ahblR
 tAz1sQaFudg8qbD9H8ia7P1ex1BUM2pHEeGfm+L5iZBuc0s2LCSQgCOIae6JjMbr+eyYqyHBI+j
 DHfHFPXYMMKj8Dgw/04pgRUtH082wrphoxULx2NFCru4K3RvcojVY/yRtJsWbQv+SRrSq2vgut8
 aHbNiyVmmd9DaV7avAaRHVk2Jn6imodwZo6jx7Df/QUpQW8B6bFeiTMwgq4E7fDhHJSsO07nTom
 0xRVJMOJi7XwQzLhT7UVNH+jK40tl52GSbsAgqlEGCjKlFJguccW+ACC+GU=
X-Google-Smtp-Source: AGHT+IERhOJD1K8hZTjOidDjIC6BmXdGBtmBzWtIT9g2P5okHw0aHQc03A+S0BZfD5M1aHIEIt8dvQ==
X-Received: by 2002:a5d:5849:0:b0:38a:8906:6b66 with SMTP id
 ffacd0b85a97d-38dea2e9632mr1599218f8f.38.1739344470208; 
 Tue, 11 Feb 2025 23:14:30 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a058930sm10677995e9.17.2025.02.11.23.14.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2025 23:14:29 -0800 (PST)
Message-ID: <78640754-0185-4b90-84fc-e59b328125f7@linaro.org>
Date: Wed, 12 Feb 2025 08:14:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] tcg: Replace addr{lo, hi}_reg with addr_reg in
 TCGLabelQemuLdst
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250205040341.2056361-1-richard.henderson@linaro.org>
 <20250205040341.2056361-8-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250205040341.2056361-8-richard.henderson@linaro.org>
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

On 5/2/25 05:03, Richard Henderson wrote:
> There is now always only one guest address register.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c                        | 18 +++++++++---------
>   tcg/aarch64/tcg-target.c.inc     |  4 ++--
>   tcg/arm/tcg-target.c.inc         |  4 ++--
>   tcg/i386/tcg-target.c.inc        |  4 ++--
>   tcg/loongarch64/tcg-target.c.inc |  4 ++--
>   tcg/mips/tcg-target.c.inc        |  4 ++--
>   tcg/ppc/tcg-target.c.inc         |  4 ++--
>   tcg/riscv/tcg-target.c.inc       |  4 ++--
>   tcg/s390x/tcg-target.c.inc       |  4 ++--
>   tcg/sparc64/tcg-target.c.inc     |  4 ++--
>   10 files changed, 27 insertions(+), 27 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


