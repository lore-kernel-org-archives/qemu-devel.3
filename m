Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A3DCAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 08:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4bCM-0002sF-NW; Fri, 03 Oct 2025 04:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4bCD-0002lV-3J
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 04:31:24 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4bBS-00054q-4u
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 04:31:20 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b90so1136731f8f.0
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 01:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759480221; x=1760085021; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rwuRZW6FgmkQHyMckSYAn+D7EQWqvO+qAeyjKGEmOXo=;
 b=p0iri+QkfBF0GnOdO8wG84hx+qqDNzjGDFbTStbo0vxjAum6Kfu+I+p7QNi0sjxepF
 PidBJfnkiqzarVndhk2fOiiF8LPmZnQgfX3eRF32I/c0H6++UTDh2+3fKft/F2SsbG5G
 ZIoL7EZ/aG/aHAhb7XXYe/CGEjHnNr0z4QxT/iyTdyrUIN7vPQjv926PSuaP9PzsTbqS
 so9/U+roF/5q9kXWYO9+GB0SKlCuY3VRrm0sNV4FjvckjLrh3KkrcQ/JurytEapN6BrO
 8hEGaSlwSMsufXpA+zcvjjiCk4h4DfuK+dkSgWXeO6emPk/rP/VzBekzMw9bzmDBwAp+
 aonw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759480221; x=1760085021;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rwuRZW6FgmkQHyMckSYAn+D7EQWqvO+qAeyjKGEmOXo=;
 b=TMEaPdwAi7cK9NPBIhnRy/MYj0B5BAgOi26i0tYb38S/dpg1izAbTXDgAkmQ9zbhPM
 wuV9i0Ir60Ct8G240hbSK2sYpU5kPn5BaXgsDyqM8nyL1pJzWQvgYU8V9waMhf2hXhgx
 wIhb2m0Qqy38kIB6qdI1ZP2GHfYJErQrOK//YU0RUg5z9MlnT6VISMLY37yMRoGf6dz1
 76LBV3umLW0E1Lk2EHF3lyvr9pwmlvNfJ0YRdprStfoj6+d56aqW9FhRb4p/X2zcMQAU
 ng+nohvQqiHGJCQEf9M0UMAM6OC24Zcr6lnYyg+c6tKircr/wSk5pj5rmd73yfIBwAYz
 jVZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnTXn6Rb09xXgL9XX6GKGhYLKF0+ocWRtI/7QmlXjkKSZRSDdv47whwP2KDMqgQ/DFeGUQfB5equeI@nongnu.org
X-Gm-Message-State: AOJu0YzV+GOWD8dATPUH8rJEzFS6Mp4rafbVWtDQpodd43G6FIfDxhqn
 7sqeHYDOP/dwuZBH1ET8j8TPYefNd44JRiz0yf1Wp2y8Hc/2GHeDWcI61314+iQsZHg=
X-Gm-Gg: ASbGncuk3WjGChVASNIeq1Ad1D9fErhww33JLKxla8JU0STD7fyWMH5DBD4OtStjZgT
 PVcshzKGp46zDzOSa/MM9N8ND2y7DxjkHJMbb8zEdDQKZ5opmnO+8Wlv0b5HUsnPu2Mc7Efjk3l
 w+ppS7FvCnuc57S3u13eGVhjQmQOzx4HJhaXmiXomjlNVLHE/JkHc2ZAJBZJPic0etJ+osRqMdU
 FXd7kDcqDDj3i5ztUqaCnXaYbegE06hxIF6lRZLPAe2HkOUeRPON+IcnTio9e0oJx79qHUYT2x0
 T/Nj5fXyz16ptENXlseesov0KX15DWBjBEizApsig1wto2aEe9pdzYDqVI4srbc4VOfOCbidYh4
 Nn7HhKgjeRA2atLb70VVviZjlWTyBS5YFSeW5+iXchbhbEsd46O5aDp4z1WVrsTfRtHYa1UF0g1
 G1/UMel2YcFFAW62s9Kawe8DxPQnQCJ9kxWKQr/94=
X-Google-Smtp-Source: AGHT+IFl8GMja8YEeD3d95FM8/Zg6YC+4+nl3/eDvuPYBpheuixCNqmeoA2Qv91KuemVs0HcaCfqkQ==
X-Received: by 2002:a05:6000:2386:b0:3ee:1357:e191 with SMTP id
 ffacd0b85a97d-425671a92f2mr961271f8f.30.1759480221060; 
 Fri, 03 Oct 2025 01:30:21 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f083asm6874915f8f.43.2025.10.03.01.30.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Oct 2025 01:30:20 -0700 (PDT)
Message-ID: <94e114ff-25d9-4feb-9c7b-9323ff29c195@linaro.org>
Date: Fri, 3 Oct 2025 10:30:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] aspeed: Set 'auto_create_sdcard' to false
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
References: <20250930142448.1030476-1-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250930142448.1030476-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Hello,

On 30/9/25 16:24, Cédric Le Goater wrote:
> Don't create a default SD card device at init time.
> 
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Fixes: cdc8d7cadaac ("hw/boards: Rename no_sdcard -> auto_create_sdcard")

The "Fixes:" tag doesn't seem appropriate here, since that commit does
not have any logical change.

I suspect Aspeed boards have a pre-existing copy/paste issue, and should
not set the auto_create_sdcard bit, using the default @false value.
Which is what you ended doing :) See commit the following commit,
5824fad4e92 ("hw/boards: Do not create unusable default if=sd drives").

I'd be OK for a v2 with an update description, just removing the lines
in the patch (no need to explicit "auto_create_sdcard = false" since
this is the field we want to eventually remove).

Regards,

Phil.

> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/arm/aspeed.c | 44 ++++++++++++++++++++++----------------------
>   1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index a3659ffea475..0d1f043ac214 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -1450,7 +1450,7 @@ static void aspeed_machine_palmetto_class_init(ObjectClass *oc,
>       amc->spi_model = "mx25l25635f";
>       amc->num_cs    = 1;
>       amc->i2c_init  = palmetto_bmc_i2c_init;
> -    mc->auto_create_sdcard = true;
> +    mc->auto_create_sdcard = false;
>       mc->default_ram_size       = 256 * MiB;
>       aspeed_machine_class_init_cpus_defaults(mc);

