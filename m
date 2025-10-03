Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD063CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 12:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4fDq-0005TE-P4; Fri, 03 Oct 2025 08:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4fDn-0005S7-2n
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 08:49:15 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4fDd-0008Ge-Ni
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 08:49:12 -0400
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-46e3ea0445fso12025755e9.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 05:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759495730; x=1760100530; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eKKpGIFhaAnNKkABrFN8kTPx+B+nseENfrTMzjVqiSw=;
 b=dXXz3hKZrkUtQEDUCTSDes1uRPqi+bNUgZMW/3JD32KZt7sqbBzGdpG2UJKNiwc4zr
 ItcrvEUy6S8VahAMRnGYFAfRENkOeMs+67Bz2T2RGyyTgUXkcc0VUdPM1KMMNG0zzSXQ
 ffvWW8kAP7Rg4HPjfJT5ve/Y9m8tin6VRojTbfiFniDnLDt6EhRuWKZltp6hzcCUywDk
 wnRlcULdaZFXigt0LcBDqeiq6SuuC7Lby3lwXKkKSRCRRryJn7AWzGjvruMcA+Waz4ov
 42YHVMCBdX0nHAFv1Nr/ar0huqSsAA5VTg9priPGXNBrroIqIwEkUq8OBu1Xy2eZMM1O
 RDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759495730; x=1760100530;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eKKpGIFhaAnNKkABrFN8kTPx+B+nseENfrTMzjVqiSw=;
 b=pH7a1W3/cPv+bVROPlbE1h23A/syqQqFbk4KQolutgJtzzh3DK4MvE0h+bqbHR8UWa
 Xo2x1+hab+FACxtf/J+eFbYPUYbD2Pdn5pWJNiW1dzQVqjBcBXPO96K7FCuYW44enT54
 0HhJg1B9k7l9jduYPRDFsJZnzuN00S9DZR79NlYwQvOa/spYqivo029oVQuav7nCFSvS
 c1X/hesK94gyohlDw/Anz4tm2y8p7EqyrgW5kGWdO7tKkSzr+VTvifYmRvBhNch9NyXe
 Quuy34txIi09lx8z1I9VBOe2Sp9oYXkyfXWEqJ+/5kY1am1KiND4AfMOZMab3nBYf/WE
 AsRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZUN14u5pXzQceCgyn2r2fe8ItAG5h98c9v43zPaqJUIlF5//n5RBnj5hV68qUlXr5EM8IbtOPpjRG@nongnu.org
X-Gm-Message-State: AOJu0YyabA5z2FVy3C0Hz6167fPzbCrgcOyvQglbk8oBjDh2YuNioFvS
 3BTXEO3CLRA9dwdDdBITVRV9lSvQ7Oxsy8DSJU9kvGjTJW06S7G3mqm7tOq3vmpjD44=
X-Gm-Gg: ASbGncsPuQnEGt8T0ASQE8cH2eIM60qSp9P7nNkZBt6S03bsk/DR22XZB5gNyAmVW4k
 6wsXGsXUQr1NkyMg7dEfVj3BYWG++Q2o/i56g02LZ/WUyxe20h7/20+5ner5u8UKq/WvXysq8b7
 M3g56SkN0ft9avV6fxwb74AaIpfBSVRhQMVLDWgBpdmGptiQ0lQiaIZnOLIsS7wBmZkQ9MCmzn8
 HOpEdvDUqmM6rZ69MvLjeDOkK0lg7iJM6h1R2ul5G+BjwLxPb09YGVuibOo5N/LepFRmA4Nhooa
 QpInhJUlsDKJdbjH5hdCblRcTRlg7d1KCEcDggEI0n8xnEJ4VRZBML8Ig1igUJuv++P60jwAmj7
 b4ewJLwSKKwAXEFmjW5Y6NQqN5TxyI5jfv6oZRMfV4czWpMlrKIBXWool79yBIAxudIfd2J+GpC
 pJqeslUgT2cEUpcS80JcbIPywhq3Ee
X-Google-Smtp-Source: AGHT+IG60jcQp3Q/xg2SqRGH8uGsUJfDOpxtD+AuoUQpUS70sf8/droB/XiW0ECZtWcZFJ5dNN+Thw==
X-Received: by 2002:a05:600c:a343:b0:459:d451:3364 with SMTP id
 5b1f17b1804b1-46e71144103mr21838005e9.24.1759495729865; 
 Fri, 03 Oct 2025 05:48:49 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e9890sm7950209f8f.32.2025.10.03.05.48.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Oct 2025 05:48:49 -0700 (PDT)
Message-ID: <6a015f1e-f298-4218-8ed7-d590bcc15ab1@linaro.org>
Date: Fri, 3 Oct 2025 14:48:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] aspeed: Don't set 'auto_create_sdcard'
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
References: <20251003103024.1863551-1-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251003103024.1863551-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/10/25 12:30, Cédric Le Goater wrote:
> The Aspeed machines inherited from a 'no_sdcard' attribute when first
> introduced in QEMU. This attribute was later renamed to
> 'auto_create_sdcard' by commit cdc8d7cadaac ("hw/boards: Rename
> no_sdcard -> auto_create_sdcard") and set to 'true'. This has the
> indesirable efect to automatically create SD cards at init time.
> 
> Remove 'auto_create_sdcard' to avoid creating a SD card device.
> 
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Link: https://lore.kernel.org/qemu-devel/20250930142448.1030476-1-clg@redhat.com
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/arm/aspeed.c | 22 ----------------------
>   1 file changed, 22 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


