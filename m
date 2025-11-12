Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1034ECCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 07:56:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ5hN-00013X-86; Wed, 12 Nov 2025 02:55:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJ5hL-00012l-Fw
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 02:55:23 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJ5hJ-0003Mn-1i
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 02:55:23 -0500
Received: by mail-wr1-x443.google.com with SMTP id
 ffacd0b85a97d-42b3c5defb2so286752f8f.2
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 23:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762934119; x=1763538919; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nw8wFDSvvu2DkvDsw2K1w1i9L0H4bUpZzGs2ijp0Sfo=;
 b=MsHCcgUmlT/9SOChaEj0IBX6T//YxZklaNjfCUWhx4b+8smE40+gN9/KDyuI21nE+n
 qh4pZbzQgoiEXel89VBsP09CUhH/wMn82REE+31E0A2pfaLb2sSjyMOqcKaDuCZg4o6d
 3Agfty9Cm0erxb2LencE1WLxJmuQQPEbl+Yjs8cn6WZ7JUKOIFPbHdL50lg7VGAVVABY
 BnSJPWkv5gGiYPcqU9mkS/Iqu3e0dpYUEIDwt9yqjX1AUxNSgfv4fHWRZu6DW92srakZ
 B0SRU220be1pXem2+jwQXdAjuOUb6KkfODGoSI9P2RZipWIRyqhTwPFTaLEZpMQlIwXj
 FuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762934119; x=1763538919;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nw8wFDSvvu2DkvDsw2K1w1i9L0H4bUpZzGs2ijp0Sfo=;
 b=VRdGkOhJS5/5P2qFUgBMyEHPWCi9TYZFsKAwYaoXxorlU9Xvgyspp5Ry2x4/DyzStq
 DgneMR2J7XNZke3AMWfyMOv6jWByEQPqx+wqLKUtyhaPvpPg4W1mwzHVOyog95FOs6Bj
 kEq24rlB7pykSTbq0q/iekDjhKKPK895tm90/WMCxiM7hWYzECvHmK6o/PHSuhL7BNzY
 g8TLBihrrPt9TDk30MviUrizJmPFxGpfZZ17YasWHTy0rii6RSKKhkhxlEnDxG21Yzgu
 fJuX3MGJmCY3MyQYcMsHoOn6f45k1fNP7BOaDKxGA7FB3kVnMIVK11PfxLKxmiQWgxcn
 JndA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWonwCDe2OIfMnKuX89UNXiSWQvlbdo1RISJb9MeD2dFfzNxuKgmp9HQE8bkdcx/Dy4k8Da4/dnKA8e@nongnu.org
X-Gm-Message-State: AOJu0YyNUBAkphFbDrECO5M2ivn2y6NJ91VROkpnl3+NLfkgZScsQDm2
 08sduw64zofDz0QO11rwZctliOnsKkRLafXNln8FgFz/lLngJUGYAQFs2lfqzQXWJSE=
X-Gm-Gg: ASbGncs1jye+9g9+15b+FILq+etuCWe77o8vrBWwUvLEfG/ih2YbNHgUCNouGLMSpqk
 NLu2NwP4tW6SSdsz3GHj1/DzYUQKN60J0l0zyPCpKi9obi5jTIinkUvehUB7Rbt1Zbu5/gWYLAa
 S+42yjRi94Y6IrwqXoqa5STX/2ki7iIRjuA9NBgwb8wCTnXPZebKOMhUhQhXFup/zTQsZ53bLbh
 422+157kewo1i7CWLN+2DrQN9P3ytm48pRis5dik7+gjMq4SKGCG2gtK6PA4Ows1XNP31RVwdeI
 QdvqlX0aBcZ6bZwA41ZZYHFZPpiVVFR4LZmLx1cgV86H0V6DcA96Ogzm5dc7GWOc6IkgYKx4Q6i
 C0FZk3e8hDjQLhbuAXb6o/eEp6Xe86i+JFghF7TyakliI2CqtiagfbuMA6GQa/Ne0EDkN8x+wmO
 pF/s/2lvraXcbtUHsSUOCcYGFFcaxLB2kutw2djJrCT7Q97P6u
X-Google-Smtp-Source: AGHT+IHe1otTG847OLw8JC+LHwGvbLQbjJU6m+PDRbAJ2vnHwOQcD9xW8R4Io0UCbwl1jSX+TNPjTQ==
X-Received: by 2002:a5d:64e3:0:b0:427:454:43b4 with SMTP id
 ffacd0b85a97d-42b4bda5512mr1555640f8f.48.1762934118866; 
 Tue, 11 Nov 2025 23:55:18 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42ac679d544sm33646804f8f.46.2025.11.11.23.55.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Nov 2025 23:55:18 -0800 (PST)
Message-ID: <40558cb0-f786-41a6-8717-1806809a19b7@linaro.org>
Date: Wed, 12 Nov 2025 08:55:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/sd: Fix incorrect idle state reporting in R1
 response for SPI mode
Content-Language: en-US
To: Bin Meng <bmeng.cn@gmail.com>, QEMU <qemu-devel@nongnu.org>
Cc: Tom Rini <trini@konsulko.com>
References: <20251110110507.1641042-1-bmeng.cn@gmail.com>
 <20251110110507.1641042-2-bmeng.cn@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251110110507.1641042-2-bmeng.cn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x443.google.com
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

On 10/11/25 12:05, Bin Meng wrote:
> Since commit b66f73a0 ("hw/sd: Add SDHC support for SD card SPI-mode"),
> the CARD_POWER_UP bit in the OCR register has been set after reset.
> Therefore, checking this bit against zero in sd_response_r1_make() to
> determine the card’s idle state is incorrect in SPI mode. As a result,
> QEMU makes the U-Boot mmc-spi driver believe the card never leaves the
> reset state.
> 
> Fixes: 1585ab9f ("hw/sd/sdcard: Fill SPI response bits in card code")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2945
> Reported-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> ---
> 
>   hw/sd/sd.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


