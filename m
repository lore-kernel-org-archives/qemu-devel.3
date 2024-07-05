Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD400C30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 13:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPj26-00005o-4W; Fri, 05 Jul 2024 09:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPj1o-0008Vd-OA
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 09:31:10 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPj1i-0005b1-1r
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 09:31:06 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4255fc43f1cso11368945e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 06:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720186258; x=1720791058; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rAWhOlclustTpT3pp7nEOPwAHtyW7n4b3R8XFBiyFKI=;
 b=pOIVU28pdiSkvrYOv4jdqCf0eBb4+CCjoPlzc3W6mVFOqHmzAQYXFHuX82WPTSdOXy
 DgOSqPoRk1J78gYdtUMS/t6/bJvqSryotImsF8A3uGO7yeYrU8ymJP7hXHVMQ+Fy1xkb
 /MhQJm5f/uXRjjyuhBDaNPEAlFzEz2B5oqCKtK3ptx+pfnFSLScfk1NYQzUH8+C9WTXE
 NmXlh4VYKrwCIJx38sXxncxuDV9/aPE7uRsKg3+BuxMPf2WTKUDSRyMRI3Yck3ssesCi
 2rrCgCoGU5yQuZNX5ETZYpbU/IplEJmvhjF9GDQI4nkv72g+eLogEbTuDON47D93z/tW
 e/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720186258; x=1720791058;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rAWhOlclustTpT3pp7nEOPwAHtyW7n4b3R8XFBiyFKI=;
 b=NBpexm2ge6jdhRUDzOeXv0E67hjbuE54yA2Gbkbm4PYZ4brsgeoPioLvBCHtZa+F13
 vC+bdNiBMVhvpOske4EpQikQwWZGiJCeRuf00COLtj/u5f9CshYhOHQZ1ZGEorrJ6mX3
 mifm6xvyt5ft8hKolVZYHCCFGbqlwFyVbcRBqAiiDOQ8+Bs2G0YYnW6XBiS8BA5sOLpN
 qaUEttAmtOHzwqlvCnsBy/hu1a1MhN6/ooco2Dqrsqt/4Dy59cuwisyf0OjaHGy1jPlc
 REJQ1jN9lMoCzMtky2hydn4TBKM4IPEsuNlP0fTlIX9dp28yEWQVeRSyND8zhXJK4LE+
 BSLA==
X-Gm-Message-State: AOJu0YxPBOu6ojRC3CX/kDH25hVyqODyGyyQit1ZwIxqlsA/TlAHmZAt
 BqGVF30roQ/MXQwNo544cFciygqCXKUtSssVxsyBqkEpHphbgwq5aHthnLU8lDz4JyUAzvNSKq7
 V
X-Google-Smtp-Source: AGHT+IEz8cHrn1PdFOn/Z573Z9S0ohQAsElYN2ckQQn2rf5gzYLG7Px/JPO0meC33/iE1hC2gk3jCw==
X-Received: by 2002:a05:600c:2e06:b0:426:554a:e0bf with SMTP id
 5b1f17b1804b1-426554afed5mr11058105e9.16.1720186258294; 
 Fri, 05 Jul 2024 06:30:58 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.163.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a21cbc6sm63458545e9.24.2024.07.05.06.30.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jul 2024 06:30:57 -0700 (PDT)
Message-ID: <2422e01a-cdea-4ec8-9e83-5418e905ef76@linaro.org>
Date: Fri, 5 Jul 2024 15:30:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v46 0/5] hw/sd/sdcard: Cleanups before adding eMMC support
To: qemu-devel@nongnu.org, Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Luc Michel <luc.michel@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, qemu-block@nongnu.org, Eduardo Habkost <eduardo@habkost.net>
References: <20240703134356.85972-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240703134356.85972-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 3/7/24 15:43, Philippe Mathieu-Daudé wrote:
> (patches from v42 already reviewed not reposted)
> 
> Since v45:
> - RAZ/WI on GEN_CMD (Luc & Manos)
> - Rename sd_cmd_SEND_OP_COND
> - Introduce TYPE_SDMMC_COMMON
> 
> Philippe Mathieu-Daudé (5):
>    hw/sd/sdcard: Use spec v3.01 by default
>    hw/sd/sdcard: Add sd_cmd_GEN_CMD handler (CMD56)
>    hw/sd/sdcard: Rename sd_cmd_SEND_OP_COND handler
>    hw/sd/sdcard: Introduce set_csd/set_cid handlers
>    hw/sd/sdcard: Extract TYPE_SDMMC_COMMON from TYPE_SD_CARD

Per 
https://lore.kernel.org/qemu-devel/c434c7e88153a134bc6ba2dc202595211702398c.camel@codeconstruct.com.au/
Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>

:)

