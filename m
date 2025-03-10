Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C330C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 22:31:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trldZ-0002Bx-NX; Mon, 10 Mar 2025 18:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1trldX-0002BP-Kc; Mon, 10 Mar 2025 18:30:15 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1trldV-0001Nv-HV; Mon, 10 Mar 2025 18:30:15 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22334203781so103544285ad.0; 
 Mon, 10 Mar 2025 15:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741645809; x=1742250609; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=jypkvFEx5fqpS60yS5p4OFHrD6NPxQOPOfVKqRdXmJc=;
 b=OKFn/FAYtvtp5UoYq0v5KSBQgKsrUxlCIdwUQLVnYOtvjKY1j4KE4/7W6NifpsB5+6
 GzRpViIX45bYS2lmWZTzNbushAfyB+KTJAcs5zqPnrmgR8n+QKcfK7adGE38aCZwFJ03
 BmHjXjmQm1OBowYmAncu7zhcO2kgXg14tGqFn7x5RtmxDsxqyQX6rer83O41mY6WQpof
 SsaArk1MWuko6teFB7LE67xyFsnIEMkSfojoi1cF10K7BcEQ4a2PIPGA/hJkRnnr1sGI
 CBuNVe3uSgJHJYnI02Ep6MZyV+04WJNmIMaQ2lct8IC5I4UtiOZz8XTC0KG3pAOEu58p
 RruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741645809; x=1742250609;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jypkvFEx5fqpS60yS5p4OFHrD6NPxQOPOfVKqRdXmJc=;
 b=V3bpsoRCFmAyu2W+PRxkYjwWqHibgv/J1FI+GGY6Q58/sDHk/E0aBqNz2G4x+4N61j
 DuaRK2a5r2A6s7kWULOiuDhMnSEBNYiew1xZSznjTkR6qPKyXr3zwj/a2NRY8+iL6utz
 okRriztPcDliw429AFcW012dknEvfwZO4as26PHzI4+kREoiJvvBXIB4epvSjkIbFm9Y
 p0oVpCcOmEbM1AMWJvCUxkbCAMBbOJNl1vmwNB96joRsqAWgB8VfOZINIQxpSulYLFMT
 O3X4B9VqkbCxGEqgxhEc60eQsw1lnngMZ/lt08bh+Ou7gmJvbCNnUGV6no0INq0S2r6K
 Ce2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6fdwoqc/YD5rAbUeHeGG9LFCK6WJRNG6vGFg7V2/2UnzRVbEDLrUVXam+cgeAC128esH1v9NwcQ==@nongnu.org,
 AJvYcCXQqk+DuAlVgENaeb7q5HYz9G1RCBucFCdl2eRIDEX7Ankfzf19d0z7XqsAs/ljGLuFVMHZDQe+Epqn+Q==@nongnu.org,
 AJvYcCXi7cOPAT/efRpIsjxcNzE9QdKH7i1W1GQyzygfxU6OwzWIsyPZA3gXunztyU3q/tBoR0v9jy1Uiwc=@nongnu.org
X-Gm-Message-State: AOJu0Yyqxm6HHUrDEY7hBjG8hD6EP5sKGA4QPTaL6cLemCYLqQc+HX6m
 D/OszbDBtOgTl6DQYt0rPvJnkhLkA9pdVT1vsB0TN25t7cWXoUDb
X-Gm-Gg: ASbGncuKt8Fmg+qZpR8kku1Xb/vJbnZBFBF9zFrbOOlQhCoT0vyGF1SkmH0AxbRpQL/
 hwIYjsnyV7c99kbPrwW1nkpBG0BZvplx4Uq+j0LWcseFHox1fyh6ONOtTgs2vWVs+cMZdk/j0F7
 wsKM52XoLnvmYPiIKRAgPtq94uPzb/i7UgnsdcLd0oBmcaghRnDHRv8tlbcMAfWSZxJHVKVEGyJ
 5UWEXvzL2vvlEkZ1SwhWoju9GyLr4dixJHA+Dtrp4X1yGyclPza+6oCVKaI3aIwZdpT/ZE/rCiF
 T/2inxGomGAHVMtXNpwi4EacshymEE4nPC+jcvV/HmmHpBnHUonv+xXAomZSK6UcPAFFXegmU2G
 OlbeiHvVntoOg5e38+g==
X-Google-Smtp-Source: AGHT+IE+jrBZ/3HYTXlXJqFrmsHY4XFjkxRpgekBEQPeqPiGRq1GXe17HbS336DisiUhfJdtiptKdg==
X-Received: by 2002:a05:6a00:8717:b0:734:26c6:26d3 with SMTP id
 d2e1a72fcca58-736ec5f17e6mr1514228b3a.5.1741645808629; 
 Mon, 10 Mar 2025 15:30:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5?
 ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736d820ebacsm2859116b3a.11.2025.03.10.15.30.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 15:30:08 -0700 (PDT)
Message-ID: <79ee0e56-3f43-481a-9e4b-6c8ffd7228ff@roeck-us.net>
Date: Mon, 10 Mar 2025 15:30:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/14] hw/sd/sdhci: Remove unnecessary 'endianness'
 property
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Steven Lee <steven_lee@aspeedtech.com>,
 Joel Stanley <joel@jms.id.au>, Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Troy Lee <leetroy@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-block@nongnu.org,
 Jamin Lin <jamin_lin@aspeedtech.com>
References: <20250310000620.70120-1-philmd@linaro.org>
 <20250310000620.70120-15-philmd@linaro.org>
 <d97b9dd5-e569-636d-8ee7-b1a48c402429@eik.bme.hu>
 <0fa157de-ee4e-4b7f-b08e-bdf65e1840ad@linaro.org>
 <6ecc3790-e5a1-4d02-aefa-c6d632936a6a@roeck-us.net>
 <e58acfaf-5255-4710-ad34-7331401ffa86@linaro.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <e58acfaf-5255-4710-ad34-7331401ffa86@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/10/25 10:31, Philippe Mathieu-Daudé wrote:
...
>>> Oops... I'm surprised tests passed. Do we have coverage for sdhci on
>>> e500 machines? Or are we only testing them via virtio PCI block storage?
>>
>> Not sure if that is what you are asking, but I have been testing it with
>> sdhci-pci for a long time (not this series, though).
> 
> I'm referring to the Freescale eSDHC controller of PPC e500 machines
> (see previous patch).

Turns out I do test that as well. The tests pass with qemu v9.2.2.
With qemu mainline plus this patch series the sdhci controller
fails to initialize. Booting the ppce500 machine gets me a series
of:

mmc0: Reset 0x1 never completed.
mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
mmc0: sdhci: Sys addr:  0x08000000 | Version:  0x00000124
mmc0: sdhci: Blk size:  0x00000800 | Blk cnt:  0x00000000
mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000000
mmc0: sdhci: Present:   0x0000fa01 | Host ctl: 0x00000000
mmc0: sdhci: Power:     0x00000000 | Blk gap:  0x00000000
mmc0: sdhci: Wake-up:   0x00000020 | Clock:    0x00000000
mmc0: sdhci: Timeout:   0x00000080 | Int stat: 0x00000000
mmc0: sdhci: Int enab:  0x3f017f11 | Sig enab: 0x00000000
mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000124
mmc0: sdhci: Caps:      0xb4347805 | Caps_1:   0x00000000
mmc0: sdhci: Cmd:       0x00000000 | Max curr: 0x00000000
mmc0: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
mmc0: sdhci: Host ctl2: 0x00000000
mmc0: sdhci: ============================================
mmc0: Unknown controller version (36). You may experience problems.

Guenter


