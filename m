Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE30D74956
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 02:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5yI9-0000p9-5r; Tue, 29 Oct 2024 22:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t5yI7-0000of-Bx
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 22:18:35 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t5yI5-0004ex-SG
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 22:18:35 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-53b34ed38easo3426765e87.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 19:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730254711; x=1730859511; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vYNg6hKKWSpSdBr1RhBKFNY0TW3DbmNv6pu3nvWdUuo=;
 b=ctqCmPCACtGYqWuXvU7td5YHC8w20zxzP7EaxU6MwjojfH0ThOAivUOqbN67UKfs20
 XDjqPc765xZokENjWVGVvYwUNNMhLX9/YaD2DoR5RFAmU7ysUwOjkBqMWVMMUvUYjwag
 b762iPCS11HmN7BCq2KCH8D955YNjmo1N58B6VtMghYnIqozSkmocArbNR1hJ3DvQeUI
 X24vJ649H6uUSZMAfQhmoU9IjCCg+iAhyQJvRVjGsJd5+6Ro2MtYqENEPxc89O7VULw7
 uSWZptDeMlZqXlyiG7Bd8gA3FRVz5C3ebbIxfzMscx7Ua2V9N9QDszFcDGL8cWr+/1E0
 87zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730254711; x=1730859511;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vYNg6hKKWSpSdBr1RhBKFNY0TW3DbmNv6pu3nvWdUuo=;
 b=AB1+RkbJ5+JddgWJ/ok5DKcLCID0mcPS58/2BYJwUoTELJIcgUJ+8WzUjkKJ1MzdOG
 ciZMbKev4WMLS/3LrV2POsgiBWMscG0aCfJ2Cf//U/0hQwsOovtr8nNLvkeFfY1uMAV5
 R/o33G2KOk9yStKk+byirPXJNDAHS8IiqYuTIdZYM3rrzfWK3QZiI2M1uSHzsDIrMFFw
 MAOHokAmMaBHsldlYG13PL3UptMRd5ay/e3kJs3A6ELW0s+WeTIDigCcQAlnuzjOweE/
 UyIe5W1ph7BpRYJ7T4iyqei1oNB4B3Q8D6+sB5U+Hwq5HgUCi7dHgSMXhz8gGuTNd9kJ
 Ipqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVThclfsfZnhEs9Mikqsk0kgF45ryPVNGS3JiEoiZ9gVFFDjhh0YgkbbIq4W/CGBT5jM+b8Pb7+KTdl@nongnu.org
X-Gm-Message-State: AOJu0Yy35D6Fj2ITMsrzA/m9kX/2bDeiLK3tY3UKQ/G494/RbNMXq2Z8
 EXjsJeua+DPZfg2M31JDTrQEJVbl8qe3jMIX97v0DyXvO0Hw5AFVmGc/9bdoWrE=
X-Google-Smtp-Source: AGHT+IG3jCgNmG+WxpxNI03ppSiUYzmHnaAEnGcWYLl1rA9vAXriOYOF6SB5cD18DRvafAbO3f+Ojg==
X-Received: by 2002:a05:6512:1390:b0:539:e6bf:ca9a with SMTP id
 2adb3069b0e04-53b348b7e12mr6791736e87.6.1730254710116; 
 Tue, 29 Oct 2024 19:18:30 -0700 (PDT)
Received: from [192.168.98.226] ([91.209.212.192])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53bb81906c8sm107258e87.39.2024.10.29.19.18.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Oct 2024 19:18:28 -0700 (PDT)
Message-ID: <1eb668d7-50a1-49ab-b94b-752ad68de2e2@linaro.org>
Date: Tue, 29 Oct 2024 23:18:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/loongarch/boot: Use warn_report when no kernel
 filename
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org,
 jiaxun.yang@flygoat.com, maobibo@loongson.cn, pbonzini@redhat.com,
 armbru@redhat.com, lixianglai@loongson.cn
References: <20241030012359.4040817-1-gaosong@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241030012359.4040817-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 29/10/24 22:23, Song Gao wrote:
> When we run “qemu-system-loongarch64 -qmp stdio -vnc none -S”,
> we get an error message “Need kernel filename” and then we can't use qmp cmd to query some information.
> So, we just throw a warning and then the cpus starts running from address VIRT_FLASH0_BASE.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/loongarch/boot.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)


> @@ -286,8 +286,7 @@ static void loongarch_direct_kernel_boot(struct loongarch_boot_info *info)
>           kernel_addr = load_kernel_info(info);
>       } else {
>           if(!qtest_enabled()) {
> -            error_report("Need kernel filename\n");
> -            exit(1);
> +            warn_report("No kernel provided, booting from flash drive. \n");

Stripping trailing " \n",

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>           }
>       }
>   


