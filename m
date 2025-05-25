Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A27C54E90
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 15:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJDI9-0003IA-OL; Sun, 25 May 2025 11:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJDI8-0003DF-5A
 for qemu-devel@nongnu.org; Sun, 25 May 2025 11:29:36 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJDI6-00081z-K1
 for qemu-devel@nongnu.org; Sun, 25 May 2025 11:29:35 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-442eb5d143eso16426285e9.0
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 08:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748186973; x=1748791773; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kNRV5007pB5JZY6Hx7pZSfOPig2zDQ44ViAP9ujmIzw=;
 b=mlOoh9v2VdC6KRK2CCVqinKfbeS09I4P3UTeztjalT7mtWydrSTDDqpRobK5MX2XJD
 yqsfBjnSsFqpeuwF/TvLqp4hn33bpEu9c9s+iq4VgH5rKfxQY3P9JVvDwcROi6mBmcWZ
 M3mYuRHdhK16f47EXd7ajhikP1+azXNnKcWzS7SaXexfh436RIlNWQfV+fmYKzKuqs7y
 /BohcGtYJsrj/yuDw0S1fF9rfToXfEP4Y5DwfP7xHAxBWMpXhkRbdd6ieBwIHN9jofxM
 dRCrvRUEsplh0X+ce5wFiUjjaZFQBBszIBjiDqbzeLzuU6ZZjCPGu5ayIpW93lZ9PyKw
 quyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748186973; x=1748791773;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kNRV5007pB5JZY6Hx7pZSfOPig2zDQ44ViAP9ujmIzw=;
 b=jO4tBJO8bpcGKcyEFVCwUj/BWz8JUUa50v3nkApEqk4dZhvVk0mOLXusGARo9aovWk
 z6hgQw0VKFiPyClXgbWD29HO2SeDQt41dhG27LbzUYFPgh+ZC5WGzXgAgQajc43F/Z5f
 LuFuHEB5TWuaRhlEUKggpVu8p+0FMvGxqMpbrfnqVYOWe01G+SjjItdD56BkNS+6zUTF
 A73mk9LvGnLqFioXtbQR2f5gzl6+qKK6xo8cwmP5EEbMM/beIeEdhPwsPE7BDcuSSG5S
 V40qIepKrPNzhvVXEYI/BIEbOzRHKHeLVEIb+rnCXqIb55GD2qANVKeOFzJ7X5gc9JGA
 oyuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkIBYIfTfQpwFOhc7jjth7ccY5/ItExP13/c4yr2MMTEGiJeb6nMlvkTdH7AFPrVZD52eiRllp8TWA@nongnu.org
X-Gm-Message-State: AOJu0YxmQmL+lXEn6uP3nlSZm8bb1bgt2rU7x/tTod3lybDFpwjIV606
 iObYiqkXa+ieQWMVmcMqoYWOxihVMK4sD+TfoGwG3f9Aq2N+ibdbTtfCkV4boyeOHvQ=
X-Gm-Gg: ASbGnctOATZwyOy6LY1wVBQ5Fc6SHT09by11Q/2ovQ7CJJ/1z8m8bYwb8vxhiSXmuX2
 F3b3+mq7zWGLAqSc8brcxj0zrqYSQcBfKSBU72uSsAj+sroo5Ufiw0mSOn+bgc24uVwYWCbVxqI
 uuqh+a57bZfLmk9oZLKH4j62w8E7OmaDZs4dEeEGNpq5eFSbMduBcksmM9pZCgZfAonXcId2XIw
 mEGdOYI2oD3FG9jFcBR3PbRcSWniTGetlQ3yhSm0/SDHn4un6kCVHXMTNryE+gTb+03IVZTQZSf
 JwxwWt3zl/dmee3QPIMAeZSmxvMZggx+kJ+NHDWitJJtRGB4UkR2OaursnK55XFP/wZnWA5DmfQ
 aFpwhEwSpJFdfU8nINHY8rYtaBK0=
X-Google-Smtp-Source: AGHT+IGwa/dFkOGO4e9CFbD/vStrIJSE5SRxUkuBlGmLgp+BuqX5CJZY4gIK2Mveff1ZNlVw4qNQgw==
X-Received: by 2002:a05:6000:4282:b0:3a0:b4a7:6e56 with SMTP id
 ffacd0b85a97d-3a4cb4c59b7mr4766976f8f.56.1748186972913; 
 Sun, 25 May 2025 08:29:32 -0700 (PDT)
Received: from [10.132.0.213] (17.red-95-127-33.staticip.rima-tde.net.
 [95.127.33.17]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cbb90a5bsm5305302f8f.56.2025.05.25.08.29.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 May 2025 08:29:32 -0700 (PDT)
Message-ID: <770ad604-f365-4f4d-b8a6-aec6412e5c4f@linaro.org>
Date: Sun, 25 May 2025 17:29:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/22] hw/i386/acpi-build: Make aml_pci_device_dsm() static
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com
References: <20250514170431.2786231-1-eric.auger@redhat.com>
 <20250514170431.2786231-2-eric.auger@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250514170431.2786231-2-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 14/5/25 18:00, Eric Auger wrote:
> No need to export aml_pci_device_dsm() as it is only used
> in hw/i386/acpi-build.c.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   include/hw/acpi/pci.h | 1 -
>   hw/i386/acpi-build.c  | 2 +-
>   2 files changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


