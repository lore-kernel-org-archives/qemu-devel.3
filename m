Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADCCFCD5BCF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 07:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRmcp-00024H-Je; Tue, 26 May 2026 03:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRmco-000241-0X
 for qemu-devel@nongnu.org; Tue, 26 May 2026 03:54:54 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRmcm-0001Ql-FU
 for qemu-devel@nongnu.org; Tue, 26 May 2026 03:54:53 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso87861655e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 00:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779782091; x=1780386891; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x5XzM6w1KgUJ0EGSCYnqdxmvLuRwc8fdi6jOh4E2J3E=;
 b=RBzgGptU0waROUtsw8kJFwDiC3snpMt8MAGaXpwsMTRg0kWPBTp/KQjdtjzwdVG/bs
 oGBbrXEe60YLHiWFga54Le0jyr7eIqd0GMFFuw2XG8+pWpNoxKFR4fLe/JOIHbxVS2rH
 9d6imwVxQAFaPNZONOE2l3IR359gXwfLnmJzuEKvOeMxcd8vFGEOiuASeW4df/HWIZqE
 s+BIpCoDUOew3D7RF+7QETzaI5YNppuNlZjeenrOYUDo+m8m8RTragl0ALgufx+f+qq8
 L4PftkUBKvI2DAM593QeC3jWtM+9Tg8DHYc0MeSVcSVJk5b3JsUxZQNlGnQhGKQI74Fr
 lKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779782091; x=1780386891;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x5XzM6w1KgUJ0EGSCYnqdxmvLuRwc8fdi6jOh4E2J3E=;
 b=rWSpfvTlqw4nkXottHRAcaLZpl+JJ7EuU+boSX40tPKgPKVWSYNOJvDMjzwg3apAfk
 OADOVKSiPTPMC2+1OkrMypxhpzkBzudJoKcjYYdXJ8205AONaKHRiPHYI3JChMVNlM+8
 DFPPL2puV0mU164rwpT+26+fDjOMC86DNgKfaspHUCU4/3vTw5wym+rJa9ternT27JZb
 RistadjKYSfZnZUlvZjFJts6Gv5KHQTffWTYALUQfMV57L0EDSUUnSnZt1d1mwk3p6ii
 UWifsD+ITPOn4dQ93wl5CUuSHvrzCK+m+xwqsyZwyxVHxAovBHlDT0KiVxrJeqT9FTrS
 bhLw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/B3WjERFxn5FwSHQQPL2lshaWrPSNHaDkr4YZFiDpy4TF0Mrl5K52DDJL6+ExK0JCJPwDtU2tqCKRK@nongnu.org
X-Gm-Message-State: AOJu0Yws8YcH245Bop5FpntgCJVH/T3tsldVr8DigsA5tSF6lBNBc4g+
 /3dcwlRFTEXGrcZKNjalEFYv/tpKGI5y2zlRUrhyk6iujcThq2IXDDXMFd9FrQ4qMnvPgTFdhdj
 AhXPoRpEGRw==
X-Gm-Gg: Acq92OEsyCTzGCZ5LJsaHk5JRVQvbYvEN34W596NEdPu8R1AAzZsf5ZeEh9/S/esYSU
 i3YmHlcjEyjdqmK7A5aTgnRI210wmsqSvX70eRC4cUkmu2Y+/xSepziv8dMjU2VY9Eq2CBgQKao
 ejD1LWjO6ERroFo5noeBKjWa4/7RpjwGMQOLvvsoRc5UcWYqDAbXfsBtSDZVF6w/L9NnlRX1vwf
 lBLAD8IlQ8jFOCbEHE1j8UwNjPCpRfKlGkaa+sL8rVEjOsd/pokE2a+iXNK420RUhvhm/OQtJVc
 5CO6Wcy8tTm98yU/F967IgV2W5ztWyW4KUWC78xAlhxAKKdkq0PQskuo7kCnjgLT8qnodxf+HW+
 u50PWzk9Hgy4Urqk0npP3QDjQnJl9KJzzuh4pLiyT9OcYNJOk42wzFUg8f9rjKp4LvLvpvXLAcT
 Vjo0b7XiadtPXVZdm1bE6xCD0o57HbWg7ADvankERxYTZy7UjAhnDY2u2i6nN0bCGYmeHSx2bVc
 z2+
X-Received: by 2002:a05:600c:a106:b0:48e:635a:18d2 with SMTP id
 5b1f17b1804b1-490424a0d41mr190350365e9.2.1779782090712; 
 Tue, 26 May 2026 00:54:50 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454c5eb0sm328776535e9.2.2026.05.26.00.54.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 00:54:49 -0700 (PDT)
Message-ID: <bcb8cfb2-6091-4576-be61-22d312805ff0@linaro.org>
Date: Tue, 26 May 2026 09:54:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/bcm2838: Route I2C interrupts to GIC
Content-Language: en-US
To: Nicholas Righi <nicholasrighi@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20260525032634.7754-1-nicholasrighi@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260525032634.7754-1-nicholasrighi@gmail.com>
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

On 25/5/26 05:26, Nicholas Righi wrote:
> The I2C interrupts are only routed to the legacy interrupt controller. This means
> that for modern device trees that use the GIC, the interrupts don't work. This patch
> re-routes the I2C OR'd interrupt from the legacy interrupt controller to the GIC so
> I2C emulation works out of the box with current kernels.
> 
> Testing
> 
> Add these lines to QEMU invocation
> 
> -drive if=none,id=i2c_storage,format=raw,file=eeprom.bin \
> -device at24c-eeprom,bus=i2c-bus.1,address=0x50,drive=i2c_storage,rom-size=4096 \
> 
> note: eeprom.bin is all zeros
> 
> Before this change, running i2c get to read from EEPROM would result in this
> 
> i2cget -y 1 0x50
> Error: Read failed
> 
> After this change, running i2c to read from EEPROM results in this
> 
> i2cget -y 1 0x50
> 0x00
> 
> The eeprom can now also be enabled in the device tree. Before the
> eeprom driver load would fail due to the read failing
> 
> ls -l /sys/bus/i2c/devices/i2c-1/1-0050/ | grep -i eeprom
> -rw------- 1 root root 4096 May 17 16:57 eeprom
> 
> Signed-off-by: Nicholas Righi <nicholasrighi@gmail.com>
> ---
>   hw/arm/bcm2838.c                     | 3 +++
>   include/hw/arm/bcm2838_peripherals.h | 1 +
>   2 files changed, 4 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

