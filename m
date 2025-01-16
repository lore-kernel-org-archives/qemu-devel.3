Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 829D6C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 17:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYU8f-0007Zw-N9; Thu, 16 Jan 2025 12:58:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYU8d-0007ZC-DL
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 12:58:39 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYU8b-000650-UH
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 12:58:39 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-216395e151bso18522595ad.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 09:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737050316; x=1737655116; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JrIfEXg98xj1RHfKgYcvnpVnX5iGmiAxXmyXd9WAz+Y=;
 b=CwUGBX9OWH5ka+DX7+lwrknKqBGAfd2ixzLa0t3SJMzVrusKyChdIPlmSzM2kGYHbi
 fa0XiD/597Jof2wQuY62ff4H0ShbCAhiP0mU6QMMEIQ+BO1gR+V4weLtnY7Qh9JICokB
 xWC7KMVAw3cI6lUU8SbxjkX0GTlfqTAK0p4z4jP7jJFRjBZKufIjxFP1kS/VLBSbOIfe
 NzloeBnKCZeT33jxl0qt/8ze/Z1dFJ2BfJoys4kFHozhF+DXfGzGtdl61paX3T47eNZJ
 nqamnlfcUJ7zQV2I+6P+20BjPI+lHqui/aOz/VH6KMZ4ebvBtFJNkZ+tgXzmWMMJOlz1
 yllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737050316; x=1737655116;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JrIfEXg98xj1RHfKgYcvnpVnX5iGmiAxXmyXd9WAz+Y=;
 b=st3c9aeD36smJtmGxa3AipRZhidzw2//rcgKi6bX/x8F0YH7PiA2wXsA6zUdQr/I0q
 k1eI2Rr+4tO4A3rTvMyxQBOEuceJ8jkuYzJ7IcMa/t7gOq7dCaJ5+ZEv0EqgLPT43dvg
 Wb6b+XqqJXTJm5yNGaj8mI2IAHyiaWfIrUmA7AOSjfDONmLF6J7toRSIW+QkBG6/Oo9s
 VkKebdMoxIzmWfIcJEk9UuDxa5JGgtA0EprV2VAtlUIk5xkd7JtyyF/+s4ibOfNGamH5
 HATRzKaA+evPieQjvZG6TZ/cZ7VV802xAFQ4PciQK0thlk4inqB3GGLOkjg4xK/Ry6Q7
 8AVw==
X-Gm-Message-State: AOJu0YzKd+7Jp+b62avYFhM/kQTVC/GES22YHlOsHaMEjD94A2ayCQet
 WCw2llJ9h/Qroe5O7GwIjEjYPvZIkyB4B00UoPBJD6n4QDitNhNOHR9rc69wqv4v+Oll+JnVPLE
 i
X-Gm-Gg: ASbGncsbf4upAkdJlbJbSkwSsDzcIdJq/SHh/d4ss8nMHv7XUvft/GbjOnLeeMjojwO
 wUTgGRESNWqbhx6SPzpFjRXEq/dkgclHij5t5H4oFgpsVrzV64QULBFBGkp33PjNGFmtLxeCMnz
 Wu47gsHB6OeegKt5/TE3pUgF/UrCstOdWWPU66KN8Jvv73hlX3w8U9hgn6dGdN2kvoEyQlvHOLi
 NaLNem42ICG8ZSc5J1FBmOoJm+hMXoyOdviFx0iGfztSLz3iIz7nYeyJALNqIGHlqhS2g7U2eMf
 C3NMszr3wWx9QLqZC0iM9Hc=
X-Google-Smtp-Source: AGHT+IGAEcZTXzUHzBuIg21x3JUEzMSKGnF1uIGLGQJOHrVq5AuXfW8pe7gnaQNVzppXP7/5FjHZZw==
X-Received: by 2002:a17:902:ccd2:b0:215:9c06:272a with SMTP id
 d9443c01a7336-21bf0d1c612mr125016675ad.24.1737050316436; 
 Thu, 16 Jan 2025 09:58:36 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-a9bdf0b43aasm313241a12.66.2025.01.16.09.58.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 09:58:36 -0800 (PST)
Message-ID: <e800eeb2-4b60-42bd-be43-3f22f66121db@linaro.org>
Date: Thu, 16 Jan 2025 09:58:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2 08/13] hw/arm/virt: Remove deprecated virt-2.9
 machine
To: qemu-devel@nongnu.org
References: <20250116145944.38028-1-philmd@linaro.org>
 <20250116145944.38028-9-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250116145944.38028-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 1/16/25 06:59, Philippe Mathieu-Daudé wrote:
> This machine has been supported for a period of more than 6 years.
> According to our versioned machine support policy (see commit
> ce80c4fa6ff "docs: document special exception for machine type
> deprecation & removal") it can now be removed.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/virt.c | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 589f3e27ee8..14fc4b100a3 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3560,10 +3560,3 @@ static void virt_machine_2_10_options(MachineClass *mc)
>       mc->ignore_memory_transaction_failures = true;
>   }
>   DEFINE_VIRT_MACHINE(2, 10)
> -
> -static void virt_machine_2_9_options(MachineClass *mc)
> -{
> -    virt_machine_2_10_options(mc);
> -    compat_props_add(mc->compat_props, hw_compat_2_9, hw_compat_2_9_len);
> -}
> -DEFINE_VIRT_MACHINE(2, 9)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

