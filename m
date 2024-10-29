Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA874D3A697
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 19:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5sCr-0005En-5R; Tue, 29 Oct 2024 15:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t5sCp-0005E3-51
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 15:48:43 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t5sCn-0006bk-CQ
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 15:48:42 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2fb6110c8faso55157011fa.1
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 12:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730231319; x=1730836119; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1eUy/HuXZtt7qnpHrLy42cyXzpR7eqM+iICWx9uji0o=;
 b=BOaeYgC8EV44JgXFWQsAnuMB4qZU/XVwfybTTy0e3Dcz3FNLR4Yd4Kg4rjUQdzLX3J
 seCDRsIP3xcllMgdIjIcUF2Zfc04NArWZo/M7Bw4AczhpzqStTULmx8EnrRQ7wpSG0rf
 +VJ1bWIjR1Pin9fqFudjpKGf26ZaxZsQFRAvW5j6U6PI1RQmn5J8NdaXYqbXMS/OyTq/
 YvAvLoGV40NZWgvRga25V/qUi/jjkSR5BgJn/mxAiB5RO26Cfmltxn1ZcbtZ59anCJfI
 E9sbCkPHPAFfloYpQ2Te0u3prqFiC3QVeRMVJTHge9pkplk2kjCNbClS9Cycyc+iKKPa
 kdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730231319; x=1730836119;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1eUy/HuXZtt7qnpHrLy42cyXzpR7eqM+iICWx9uji0o=;
 b=dYGj/ee82y+AdSf714euGfFzpPjmzGw48xGSXCV8TW49SFEiLvPv1sTqRrfApHaDzQ
 rEPnUF0tkvnw1P34Mir7iePfnnqxM4PdWGAYjVBN0YxQ/2iJVrfy+zUIA3q8HfzZHNcK
 sFtkhXzSdCeJ2GbvaSofuydAO8GxNz6JhEK/Kb5OiEYTMA002mcoQbVdf/r/Xy5r+w+6
 /NG9ouiCv3QQfBXXEhI6Vqie1YsGHDgtqibUMlx7ZTQVesn86FBXpWdIVTXP9J3W80+R
 NaE/TyqzDxU4BFSbv8d/BOH2mH44cmE8X3jCyTjseqjvruC/MhYmlNWZVtd/mqT2GGOv
 4LsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2v+2AnxhjZKkqR+FNQFzteAQuIkFJKhHWDYARkejO4xGkG69J+i+W6lI8NvnQjczYQ4J7qCbaqyHJ@nongnu.org
X-Gm-Message-State: AOJu0YwWMxrcA0LdetKqm2eZCGbjLhEigBM7uDaR09Z1jgk0c3tWWON5
 Y/+MVnLMVMbMzacFWpVuFNCp11Wf8s3H6jP2Q1I3wlhKCaysIJcTzSxgG3xwDSY=
X-Google-Smtp-Source: AGHT+IFCNO2lsDdHBWzuJOaA6aWwA8lVhhLubSKNwWnCIHh4EymHbQ4ZS5HxbWD4wE4acc7vTe0CWA==
X-Received: by 2002:a2e:b348:0:b0:2fb:6169:c42d with SMTP id
 38308e7fff4ca-2fcbe08deb9mr46297721fa.41.1730231319293; 
 Tue, 29 Oct 2024 12:48:39 -0700 (PDT)
Received: from [192.168.156.226] ([91.223.100.133])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2fd5366ef5dsm330601fa.134.2024.10.29.12.48.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Oct 2024 12:48:37 -0700 (PDT)
Message-ID: <5232854c-c3d7-44c0-ab1d-ed46d8a7b1c9@linaro.org>
Date: Tue, 29 Oct 2024 16:48:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] hw/loongarch/boot: Use warn_report when no kernel
 filename
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org,
 jiaxun.yang@flygoat.com, maobibo@loongson.cn, pbonzini@redhat.com,
 armbru@redhat.com, lixianglai@loongson.cn
References: <20241029093501.3980927-1-gaosong@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241029093501.3980927-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
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

On 29/10/24 06:35, Song Gao wrote:
> When we run “qemu-system-loongarch64 -qmp stdio -vnc none -S”,
> we get an error message “Need kernel filename” and then we can't use qmp cmd to query some information.
> So, we just throw a warning and then the cpus starts running from address VIRT_FLASH0_BASE.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/loongarch/boot.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
> index cb668703bd..9c37abed3a 100644
> --- a/hw/loongarch/boot.c
> +++ b/hw/loongarch/boot.c
> @@ -278,7 +278,7 @@ static void init_boot_rom(struct loongarch_boot_info *info, void *p)
>   static void loongarch_direct_kernel_boot(struct loongarch_boot_info *info)
>   {
>       void *p, *bp;
> -    int64_t kernel_addr = 0;
> +    int64_t kernel_addr = VIRT_FLASH0_BASE;
>       LoongArchCPU *lacpu;
>       CPUState *cs;
>   
> @@ -286,8 +286,7 @@ static void loongarch_direct_kernel_boot(struct loongarch_boot_info *info)
>           kernel_addr = load_kernel_info(info);
>       } else {
>           if(!qtest_enabled()) {
> -            error_report("Need kernel filename\n");
> -            exit(1);
> +            warn_report("Need kernel filename\n");

Either nothing or "No kernel provided, booting from flash drive"?

>           }
>       }
>   


