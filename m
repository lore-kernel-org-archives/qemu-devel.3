Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DE7CD4F47
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 17:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOf3d-0006FH-2P; Sun, 17 May 2026 13:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOf3a-0006Db-AE
 for qemu-devel@nongnu.org; Sun, 17 May 2026 13:13:38 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOf3Y-0006t9-SA
 for qemu-devel@nongnu.org; Sun, 17 May 2026 13:13:38 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c8021c8c42fso480046a12.3
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 10:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779038015; x=1779642815; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+BrGrX1Prrl6FAxzuSxftgdKyOQQ28fg7sauoUQmdBg=;
 b=y03xsd4Al8SkQoonGMeAFvWusHJ1FC5l5b1LE+bf4CUF8rs4zqZdzwJdCZTwQ+7EzG
 MJSCsokolXufMDvnnHkRsDWw4sr1ILl4QuOCDU/3FMkpf8nP+mHCjq7v6fLU+Ru98q1Q
 V49PEvD7+4I2brfQ/TrOAM2lk/W+40qrnucQfBbYLmRTg0BOmaNP5LiyKhV87k1SW3eY
 bOkVcM+TE3jpltbe3/2dIusruV8+mD8PX51MJRNifKlHPSz+Cr8s8U3fjZqnEo8PcsHi
 fCT/skJ88XESdL+FPzXaCvSwrXf0fHn8LGpFveJiwpyz4mcpiwBlJD9jmiT0/99EF7Qo
 hYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779038015; x=1779642815;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+BrGrX1Prrl6FAxzuSxftgdKyOQQ28fg7sauoUQmdBg=;
 b=cs2uGgWnuZOwCdbvRtVWR9FH7eGz/BdrTOq/e72np3v2JbuJ2rJYMEeYBaz3NKy1HV
 ui4S+d7guhbf0BxUoNGguH3y/JrRXHVl3ZreLiFEvdzQIqHvBlwatTECFLbNS90oDDLB
 xSKfxLWWFDmCH9LvwK2McCKqKqgw2Qv7S9SWjTrDqCpz5pU7mVkL5TFBTxyyfGEGsHz8
 k90zM8y9TIlqyPxkxsFtkRezvQf+I/gZjhLsJvik/XdRpW9kLo14LUi5r0AN+eH/bEhJ
 fDxcnX380xWZrYjd8CdZ0VzcZwsG0znWVvHDJc8Fccb3e+73Wcxo4YHMkmyZNR9V/cz6
 bF/g==
X-Gm-Message-State: AOJu0YwhLSgKqcByAcKZrY/TIE3socsBfOeonlMUvuguLzpJzozp8qEf
 NwhMVvKMTxzBbBGgKOT2kYGctpDr6m++erk+rPRWJKwHK7vAU2X/LyzdTLMLUXqFZhel6fI2m8k
 3IMVa
X-Gm-Gg: Acq92OHGlKnswzSmULHnJKj0fdeLq2v0pbupFrawXKV+XwB1sG3L6HkAa21bg8BKDn3
 tOdrfyIXCvuzP6bTFyWQJvhkqHNtm8tquDzAWVAVxdebD/T99GBOzhEXjasoo6IqHo9ZPaP87HH
 YuUNp5SlWVFJ89Y1VpaI2PItrfx5MdMJLlUMUhQo2b2o8hrGi9NlqX4FJRd4w9hJEEAK8198s9i
 gpJvb+mh+g0viovMsP/D40l73MXxDqGQweIJwi8kYmPyfpy13QRpIIZHNukQc54PtkX6zUFV7hI
 UeQFfq1Pv5CmEe21dBSQecj30Hhzjp3z4Um7OjCCYuFVEjwiaUZAV6OYb7PCFng1ri9gFJqPv4h
 7cm0pIx/F/lhN1wFLkPBHu9ys/Az4miswDFMPGAC4DKAToZWkGmKntY+SPFoPrsyjxkrto2ezHS
 z1YBE9f6E8B93NPixibTHqQ1sTpGcMYWFoH8nQT6YDTPZkBQ4=
X-Received: by 2002:a05:6a00:18a9:b0:82a:f02:7355 with SMTP id
 d2e1a72fcca58-83f33d24d71mr11512618b3a.32.1779038014912; 
 Sun, 17 May 2026 10:13:34 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f1966471dsm12152976b3a.6.2026.05.17.10.13.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2026 10:13:34 -0700 (PDT)
Message-ID: <21a6e20d-0bd5-4889-82fb-7a8a5aafc92e@linaro.org>
Date: Sun, 17 May 2026 10:13:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] hw/dma/omap_dma: Remove support for dma_3_0 and
 dma_3_2
To: qemu-devel@nongnu.org
References: <20260512203414.3633237-1-peter.maydell@linaro.org>
 <20260512203414.3633237-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260512203414.3633237-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/12/26 13:34, Peter Maydell wrote:
> The omap_dma device has support for modelling different variants
> of the DMA block, as enumerated by the omap_dma_model enum:
> 3_0, 3_1 and 3_2. However, our one remaining OMAP SoC always
> passes omap_dma_3_1 into the omap_dma_init() function, so the
> handling for 3_0 and 3_2 is never used.
> 
> Remove the support for the other versions; this lets us
> delete entirely two large functions that were specific
> to 3.2 DMA to the LCD controller, and all their associated
> fields in the omap_dma_lcd_channel_s struct.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/dma/omap_dma.c     | 348 ++----------------------------------------
>   include/hw/arm/omap.h |  28 ----
>   2 files changed, 15 insertions(+), 361 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

