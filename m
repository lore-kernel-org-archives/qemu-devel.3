Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E223C52D7D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 20:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbnHI-0003Ik-Fp; Wed, 07 Aug 2024 16:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbnHH-0003EM-Bd
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 16:28:59 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbnHF-0006vo-QL
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 16:28:59 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4257d5fc9b7so2724795e9.2
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 13:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723062536; x=1723667336; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QT2gfHLRe7f/fD3s6plaPBDt1lTQ0Qc1qhqWfG3Kv04=;
 b=cnP26r2PHl5FYznqjqgCbEs5XIGWeaY0T7qWrKP6qDpTsE624MLhnOqzNY3rmpfjOy
 6uwPjvA6cBWXmtTiyKZao1nkTjDJFgTUVcSJuwpRmvsAddqCKL4MGjhho+tx8hBmnWMT
 yWsLGRpqySdf49xlBk3spAs5ALks62O2RA1XyfRipv+aFH4jJvgoSZwcGAL2mNqYskFZ
 y5YjlXtLkthtLBIEwxd43x8tkN4fET9zyIlYSbuMEyg/Fro093UPf5p005SJmzOEPofb
 RwdeBtPJWO9EEHisrdMexRNIlbmBNDMdcM/39XF0PL3q5t90VVJJIiE+2CPkb5+0CCKx
 SKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723062536; x=1723667336;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QT2gfHLRe7f/fD3s6plaPBDt1lTQ0Qc1qhqWfG3Kv04=;
 b=TSSl/eZ9aKtixMFpSOvufjEEhuIiAAhdMYRDQwEmAuiu2b8C/D712epZKlxoy5/hHM
 dQsKUFTSXBHArRTuzC3NshcP1bVg8qmdEjcNflmCpdqkb1oCJA2ChKLlw29Cs1VxelMP
 vw0bU3olljcvkGEr0vqXwnnWG51w2d3pXOSIj9qiRZNEn+loz8tWBbrAtHVq2n9AVB+/
 N0arKjoMFYLSfzeA0S2v/BugMdNWK61m6wQmV5AKRcfYXrYJBH4fw+FsJq2Q/7G7CHt7
 EJ3cr83MbyapPztUi9l54dIHdsOEwqN5fVL/jJ+iFJOt7Ejcwz+eu4Z/cXd19iQhtcwi
 26MQ==
X-Gm-Message-State: AOJu0YzOlocYU9GsvyuESVuxDYWUA5att1ZHZHKI5DXytQvqbYV392Wd
 KPar+Dx+Z4KLOlfw8Xfdka2meCk8U2mRg3chYKyLSoaW7uyiaSaLQxV64hNM8dvKVLLEz7CR1GY
 V
X-Google-Smtp-Source: AGHT+IF7USSqeSik17K6oXGelXjF7z8POIvPQ0+bSoUd5gfgAKUdIwA8yx3XK9c1EG633+esyu0Zag==
X-Received: by 2002:a05:600c:3504:b0:427:f196:c549 with SMTP id
 5b1f17b1804b1-428e6b7e954mr188199915e9.23.1723062536037; 
 Wed, 07 Aug 2024 13:28:56 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.120])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429059cb20esm44626315e9.40.2024.08.07.13.28.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Aug 2024 13:28:55 -0700 (PDT)
Message-ID: <736fd225-4c79-4a29-ae31-a7abcfa1331b@linaro.org>
Date: Wed, 7 Aug 2024 22:28:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2 4/4] hw/ssi/pnv_spi: Fixes Coverity CID 1558831
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Alistair Francis <alistair@alistair23.me>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Chalapathi V <chalapathi.v@linux.ibm.com>
References: <20240807202804.56038-1-philmd@linaro.org>
 <20240807202804.56038-5-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240807202804.56038-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 7/8/24 22:28, Philippe Mathieu-Daudé wrote:
> From: Chalapathi V <chalapathi.v@linux.ibm.com>
> 
> In this commit the following coverity scan defect has been fixed
> CID 1558831:  Resource leaks  (RESOURCE_LEAK)
>    Variable "rsp_payload" going out of scope leaks the storage it
>    points to.
> 
> Fixes: Coverity CID 1558831
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> Fixes: b4cb930e40 ("hw/ssi: Extend SPI model")

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> [PMD: Rebased on previous commit (returning earlier)]
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/ssi/pnv_spi.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
> index 05e6afc11e..eadc36fa86 100644
> --- a/hw/ssi/pnv_spi.c
> +++ b/hw/ssi/pnv_spi.c
> @@ -239,6 +239,7 @@ static void transfer(PnvSpi *s, PnvXferBuffer *payload)
>           }
>       }
>       spi_response(s, s->N1_bits, rsp_payload);
> +    pnv_spi_xfer_buffer_free(rsp_payload);
>   }
>   
>   static inline uint8_t get_seq_index(PnvSpi *s)


