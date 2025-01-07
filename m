Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34AD6E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 10:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV6wj-0000op-R0; Tue, 07 Jan 2025 05:36:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV6wb-0000oT-C7
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 05:36:17 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV6wZ-000588-NU
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 05:36:17 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-436a03197b2so57329505e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 02:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736246174; x=1736850974; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YO7GPG8PL/NjGKffH1bCyMMDz7CUr7kO/YwswYTvIes=;
 b=Lmf1OZh23GxG2BuUYeYPg004vfIo5eOxzq1vJ1i+2GAZuni/d4mVxSyoGBvLb2UmB+
 RaLqv3T0PspEZtuvAy2lQYM3xb3V8ZcKy9rGbJEW72Tu8F9HOEJ13cx0z0YKWfADJ2gx
 KdexPrYhr6hL+BvPam3sgNIYAN/MneammJFlKD5tCDw0dHU9Jsg+703TdifXei53I/Uz
 9piEjpY1Jxbrf3FVim0DBFhBTgqfBxmXQX/IiEOEStdu0nrTqlnQcazZaYL67KRQhpze
 s+ZKLNKw5zs/tQhZHWKHyCYfjHYVGRDfkd92Y2XEImiHyXcrFqneFQPtYHp5YpN8xWCn
 RF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736246174; x=1736850974;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YO7GPG8PL/NjGKffH1bCyMMDz7CUr7kO/YwswYTvIes=;
 b=aK7mgQM7p7+vWcFbB/O3NryQCENzmHrgRJS+xTxtne6Alj+AgsGlbOlSPV/fNMbTmj
 rbCvxbDHgJhqDXpkjSS/tHiM8C+Zg4ZsoWqex1dqN2+h2LQ9orYdLgbO9fjIoCYbwlct
 w+PsAC7aFPa26A7thGvp/U6nrDLTUWKj+duXB1ZxIdNfiiR6qV3WB8Gi3CWhIiNrfzsW
 V5DPY3fASZ/N6pkOr8secsV4vwiVBWtANn0wPFBgsY5goaSjIiXqRNYpjN1eADrlGrji
 S0/rh28eH0YFwMRGS82VT76AATKbG4wlPR6HXS+cGYdflhQh/WyM4uCbTwZtOMWjR2wY
 sxQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2O+BwVO1QdE4y/krcLlo82TbHKSdg6S+AM6DfJHEiLqvztfy0FOkvkmRhenTqZnXYJh6FNFBNBj3X@nongnu.org
X-Gm-Message-State: AOJu0YxLDpLOPxS6DVDjqtLJRwuzhhClZe6Vdaz2eJy9IlGZN4nhocoZ
 wNrblTmjFJKX25497Rpl33cw1DKhleB0V13FR+DYwtMHS1BSBqUV3q7Q64hLpqQ=
X-Gm-Gg: ASbGncsxsRQX/CHZYiYP3L3x9imJ0KIUzAGR2bLLl1ENXJy9FJHzMDZfAQXE+dfct9+
 mYPHZUC9v2Sm74sMdeYl6qJwWwiBd0wuztNtCMgLQofiLKoS/cudQv/l84ukEimwMzgzkGG2oDt
 S2K5CO1eEdYl9lPGmkLkJeqyAK1eUE0QmXWW1IANhEKwJb90hEyD7nxRLUvy7pDOZZ7pVE8qEiV
 ZNYf/MSJHyyWQkiB+rofarjIu3Boo/5sw7F6t89rKve6md0434H6JQlOOcYGTRkwuhuGnNoCC+7
 /Md/lrXDH+6pW+ihe+dba7aA
X-Google-Smtp-Source: AGHT+IGLWEQAKzC/bW+nRuSuSrEtZ6uTHlpcmaU/FosBQXtfEdOcam7QfXRoNq+pDgvLvtAu8TZn4w==
X-Received: by 2002:a05:600c:46c7:b0:434:a1d3:a331 with SMTP id
 5b1f17b1804b1-43668b5f36amr497217185e9.22.1736246173655; 
 Tue, 07 Jan 2025 02:36:13 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436dcc8f8dfsm12601425e9.0.2025.01.07.02.36.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 02:36:13 -0800 (PST)
Message-ID: <4b846383-83bf-4252-a172-95604f2f585b@linaro.org>
Date: Tue, 7 Jan 2025 11:36:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hw/sd/sdhci: Fix data transfer did not complete if
 data size is bigger than SDMA Buffer Boundary
To: Bernhard Beschow <shentey@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Jamin Lin via <qemu-devel@nongnu.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 "open list:SD (Secure Card)" <qemu-block@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20241213031205.641009-1-jamin_lin@aspeedtech.com>
 <20241213031205.641009-3-jamin_lin@aspeedtech.com>
 <D62F06C8-5247-4FBC-82A9-9127352B30A6@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <D62F06C8-5247-4FBC-82A9-9127352B30A6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 7/1/25 08:10, Bernhard Beschow wrote:
> 
> 
> Am 13. Dezember 2024 03:12:05 UTC schrieb Jamin Lin via <qemu-devel@nongnu.org>:
>> According to the design of sdhci_sdma_transfer_multi_blocks, if the
>> "s->blkcnt * 512" was bigger than the SDMA Buffer boundary, it break the
>> while loop of data transfer and set SDHC_NISEN_DMA in the normal interrupt
>> status to notify the firmware that this SDMA boundary buffer Transfer Complete
>> and firmware should set the system address of the next SDMA boundary buffer
>> for the remained data transfer.
>>
>> However, after firmware set the system address of the next SDMA boundary buffer
>> in the SDMA System Address Register(0x00), SDHCI model did not restart the data
>> transfer, again. Finally, firmware break the data transfer because firmware
>> did not receive the either "DMA Interrupt" or "Transfer Complete Interrupt"
>>from SDHCI model.
> 
> I ran into a similar problem in u-boot, too. Apparently its Freescale uSDHCI driver expects the SD command to fill the whole buffer. Here are some thoughts:
> 
> AFAIU, the SDMA buffer needs to be big enough to hold all s->blkcnt * s->blksize bytes and a guest would typically expect the SD command to fill the buffer in one go (please correct me if I'm wrong). Furthermore, I believe on real hardware the command would run in the background, allowing the guest to do real work rather than wait. After all, the block attributes register allows for up to 4GiB to be filled on some hardware (again, please correct me if I'm wrong).
> 
> The problem is that sdhci_sdma_transfer_multi_blocks() blocks QEMU, i.e. does not run in the background. If a guest asks for huge amounts of data to be transferred, then this would disturb emulation and QEMU would freeze for a while. To avoid that, it seems to me as if the implementation chooses to exit the while loop prematurely, relying on the guest to poke it again. This, unfortunately, doesn't work for all guests. So ideally, sdhci_sdma_transfer_multi_blocks() should read all data and run in the background, e.g. in a thread or in even in a coroutine? What do you think?

Yes, ideally this would be using the "system/dma.h" API,
dma_blk_io() and dma_buf_read/dma_buf_write(). Current
implementation was a good enough start, then nobody had
time to improve.

> 
> Best regards,
> Bernhard


