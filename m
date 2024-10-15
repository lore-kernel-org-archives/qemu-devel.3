Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21604CFC277
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 15:01:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0j2c-00039M-Rb; Tue, 15 Oct 2024 11:00:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0j2Y-00038G-CA
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:00:52 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0j2V-0000TN-SE
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:00:49 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-71e74900866so767914b3a.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 08:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729004446; x=1729609246; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UkJtOvglhcxIIQG4scx7ZIRUK9Rm0J13x9EzawJArco=;
 b=hPHUZFHLg4t8BWnzVB2Uh51AFU4cuGvOCckH/o0FNr+AMw9HX/RvZBB+zAw7ukEswE
 ECfVbu3BsnU56rYx4fLHz7WR8KtzO4ht1DZGnWmQz8We7hPrdWg+pyIh4gJKWOSEvJn8
 LoKa2Ul0MH8Fi27Ve1XJ2T8q+NnBA+MhKAOWfZ2XbOlBSRlgLa8AZNXKlpi7h41wmsB/
 2lRrnGmNxh1Jx/GHyn0X3iocH5I0Vy7jCmUzg43piMEHqUtcHGkIYX4IAdSBY2kQHU4F
 rCnxU6sagyrX2UXwrq+a6yjRppZVtPCKrSn4TTBRiFG35d/GNFVbZvtfrl/zchZ7HCdH
 Dxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729004446; x=1729609246;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UkJtOvglhcxIIQG4scx7ZIRUK9Rm0J13x9EzawJArco=;
 b=b61FvAlEoSVbFWa3drHisyRswY1tuLmlZZtr9l/0iH9Im1K8jiuevAh+Iqn33Q0MAt
 Kb+1Mr+zvRA5dtv1HtRul3Hg6n00UVdekQULemwj9RQ+bVmxfrQaaD9RegMVyTuoPo64
 oriMWevO3/K96cO7RP+Pe6sYMx2q8evJ2A1CfInCnbHxDXTGwJNnCpWfziLxdbqd3+c1
 M4ytKdKWjleVPmucn0yzVib4YtzyCrqBCnspf3f78cMFSTMvDHo5vu+KfGmLjiGeB64F
 jMc+/RhjFe26Xy34s8flD23XLI3ozQQRi6LruJMBYgP58QC0Sjy+75g31vB+5I5y+zK8
 xdrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXZVc2qTTxJiaEKj/OTenc7q88VITIcaSl3/NCGlhubhtr/a2ifxfNwxa53jlIf7AEYH1ioXFuEhGL@nongnu.org
X-Gm-Message-State: AOJu0YxmKFWcCajfy+F5gFiOjfjKg2CTYJCF7MuuVJQEqxzDYXkmAmzU
 dCQqvVE2r2YaRjlNTiEyWImeJNQbP85Vw3diPSbMAM2fBVnnqyNxINwRT8ZZy6M=
X-Google-Smtp-Source: AGHT+IFHx8S1BUxbuufzSLQKGt9EV4N8OueH1Tz1pb8A2SwARO8W32vB2ivEkPuIIbPBVbHuthpAsQ==
X-Received: by 2002:a05:6a00:3392:b0:710:5848:8ae1 with SMTP id
 d2e1a72fcca58-71e7da10f78mr936220b3a.4.1729004445991; 
 Tue, 15 Oct 2024 08:00:45 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e77371193sm1372999b3a.21.2024.10.15.08.00.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Oct 2024 08:00:45 -0700 (PDT)
Message-ID: <5fb5f318-6fd0-4390-9314-528acc5d8901@linaro.org>
Date: Tue, 15 Oct 2024 12:00:42 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd/sdcard: Allow user creation of eMMCs
To: Jan Luebbe <jlu@pengutronix.de>, qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20241015135649.4189256-1-jlu@pengutronix.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241015135649.4189256-1-jlu@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x42e.google.com
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

On 15/10/24 10:56, Jan Luebbe wrote:
> For testing eMMC-specific functionality (such as handling boot
> partitions), it would be very useful to attach them to generic VMs such
> as x86_64 via the sdhci-pci device:
>   ...
>   -drive if=none,id=emmc-drive,file=emmc.img,format=raw \
>   -device sdhci-pci \
>   -device emmc,id=emmc0,drive=emmc-drive,boot-partition-size=1048576 \
>   ...
> 
> While most eMMCs are soldered to boards, they can also be connected to
> SD controllers with just a passive adapter, such as:
>   https://docs.radxa.com/en/accessories/emmc-to-usd
>   https://github.com/voltlog/emmc-wfbga153-microsd
> 
> The only change necessary to make the options above work is to avoid
> disabling user_creatable, so do that. The SDHCI-PCI driver in the Linux
> kernel already supports this just fine.
> 
> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
> ---
>   hw/sd/sd.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index a5d2d929a8af..2d3467c3d956 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -2865,8 +2865,6 @@ static void emmc_class_init(ObjectClass *klass, void *data)
>       dc->desc = "eMMC";
>       dc->realize = emmc_realize;
>       device_class_set_props(dc, emmc_properties);
> -    /* Reason: Soldered on board */
> -    dc->user_creatable = false;
>   
>       sc->proto = &sd_proto_emmc;
>   

Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>


