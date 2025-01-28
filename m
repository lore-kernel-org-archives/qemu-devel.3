Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68AA6C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 19:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcqss-0001VV-Im; Tue, 28 Jan 2025 14:04:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcqsn-0001V6-2e
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 14:04:22 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcqsi-0001Ed-Dy
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 14:04:19 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2166651f752so126792145ad.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 11:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738091055; x=1738695855; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wOVxNRDbNp3BRriYbF80gUZp0Q4Cc8mlqTE1LW3lzhg=;
 b=m3C+MjXz0isfKnZaCrZQpksy6ZRn4uEEMMsjw11+vCQ2fm5xlt+LqeJoCsFomgfgsw
 ZFEHpuHwuAfwRPxL74FQauywlcDpFhnR1d9i8v7xQCL42/jAhEzpvdG5+Gz9oWe7GJCE
 mAeYI9m15BP8UWlqai3lfpkxdU3uckX3hCkfNdsQ8a1H+xbpN2bup1eoqb8ohu9nV2/5
 LywVUc2h3vDz3FURjcKjx457TsAEGIklM98jqj+Xx5GKHmZYSh7bIGdIQOzhsa6kMp0k
 nx3HQ/nIX0Su8gZLRLsQtQAxCqo1pfDCM0hz67SJH2bqoESPtA6MoFGiQ666RUgEUWEs
 VMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738091055; x=1738695855;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wOVxNRDbNp3BRriYbF80gUZp0Q4Cc8mlqTE1LW3lzhg=;
 b=OBCKmRPy+QkZVU2M5/YV7p5k3Dj8I7FrWdnDEGdFUmYBHSsLkldYOALsgTSMLdzQpj
 Q3DyocsQvVcEJRfiZ6Ulb72DrQEEkTnlu4seiYLzOv9autJDD8+otx27ptPjKDUjj1FX
 Q6fKpppvf7gjkeIQm+vbISayxyOuTAFDdhC5Jo4fy25TbC52vOTzKVdH/GbUUXFBzSvr
 w3emlYea/dqpuLmBCQ7RFoHucRDcpedvYpBw+qjITMFac/doVAhBPximGj2YqIwVBuzo
 dxNekYDy89c62MOOuJKf2fAe2Bqp4X/e6RFI+SftwtpJTQJ/jwZM2guKJ5ZASpsdfApk
 eehg==
X-Gm-Message-State: AOJu0YwG1qDVce+VENN9vZcbmMA7dHIJFZUrvof9O1IjIzVV9N7G8I9e
 kiig4mhMrIXo8iRTyDlJTc6XvjV+dCliRExspjoE2hcDxm05OV6gBsepk8EWpieHkvYzEL/1bMb
 P
X-Gm-Gg: ASbGncuc3AEaI8QPGcrUFZfPGsXa6uxDaFLP76VjErb5/xcukHvSJ+ZtUuFEpwAiMTt
 evvJEP2M8AnE9EHLhBiAdVCHZqXkSlFplKxsNnvlhsjUZ0A6h+rOO6wC9uqqONtORenGF1RESc2
 Y2Xn7BbiON+FDvOHZUmyg3nWrYNyKz0/S8ObxDrCiZDUDhudK7SPI4DJRWdHNQHEfLak+qxO96h
 Z7qmyZc95sUPvpCKUkKj9HUVDm7KyNv72ryXXhYIrsGANz8d1ZKgHrzrxXcPERTFRO/30xQ+Sdr
 iz/Xj0NCELT71Ira9yyboUvjeNpjDOR85bB0fi1Tlfoz7Z5uBM61MpoqP73i2zhpqzd2
X-Google-Smtp-Source: AGHT+IH0bSNfU3CGbokZuAF0SnSF/t5/qEr3n4Fh4S0jeUICZqQYgbCpwz/DkU053Jdlk1y1ujTs0A==
X-Received: by 2002:a17:902:d485:b0:216:4853:4c0b with SMTP id
 d9443c01a7336-21dd7deef0bmr2347315ad.33.1738091054639; 
 Tue, 28 Jan 2025 11:04:14 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da414da40sm84600215ad.179.2025.01.28.11.04.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 11:04:14 -0800 (PST)
Message-ID: <1c638a81-d82b-475d-9db9-f1fe014d2ba5@linaro.org>
Date: Tue, 28 Jan 2025 11:04:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] hw/arm/omap1: Inline creation of MMC
To: qemu-devel@nongnu.org
References: <20250128104519.3981448-1-peter.maydell@linaro.org>
 <20250128104519.3981448-7-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250128104519.3981448-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 1/28/25 02:45, Peter Maydell wrote:
> Our style for other conversions of OMAP devices to qdev has been to
> inline the creation and wiring into omap310_mpu_init() -- see for
> instance the handling of omap-intc, omap-gpio and omap_i2c. Do
> the same for omap-mmc.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/arm/omap1.c   | 15 +++++++++++----
>   hw/sd/omap_mmc.c | 22 ----------------------
>   2 files changed, 11 insertions(+), 26 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

