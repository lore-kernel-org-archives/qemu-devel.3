Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4633BC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 09:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1retIk-0003Xn-EU; Tue, 27 Feb 2024 03:59:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1retIh-0003Vz-Iz
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:59:00 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1retIf-0005As-QK
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:58:59 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a3d5e77cfbeso705388966b.0
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 00:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709024334; x=1709629134; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DUw2MMJWHD6lnJyIJR8e3zviNgIR3r95MSDekrWFcJc=;
 b=LUuwrOSSFKv4UPql6yHVvW0oj7bz7mh6s/YPgWkS4u3pu5ngT52BkvK69SH0YdvaVg
 xwqq65GasdSMKqEjvmkeUura4+xYMXt1kEv80GWIfBf9SjlcLHqHlNPQyCBbZD58vbtO
 U55ijdz8nZV4T1CIRykD43EDlvnUhTD+f89sWo1Bu91MGjGJC8p9Rj4/n61wMOs4O15X
 hB1vU/Rd0rrzwWObuuk+Ew0kb0bSxEFewXfe3+fYzRj8W6DaIG4xg7cyerj5UKZT9nrT
 +/paMMmnT8mEBW/KEWyPYdDi86oTYvbQxda4nL+nkPgTju0KkFUUMmroKqGrYeF7bTPW
 8+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709024334; x=1709629134;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DUw2MMJWHD6lnJyIJR8e3zviNgIR3r95MSDekrWFcJc=;
 b=fOdEuJEhnEaPkndIlUFQtCFOR3JLxN9sjsGM7ejy4H/mEzMcw5ZJSmY/mCy7LE80Di
 +wgif1f9mvobSkjGTx8FQ+c9zuhWyMOGFvlwOwhfRdPjs3GTJQd0COWO6zWS/zDpRd0p
 2EwglCC8vdIxOLWMS/MH87rQXLazHAcDaZ504UTbvfF1O/qN1cs0lq+t1OwA33YxyzBV
 rTgcVxfCa4VTWmifh0ZB1Y+Gh1clGHypVd3f1VZOz2U6tkarlffscg+WaI6GlFAI70sA
 WpXYtltorjOswO//6z8DjKJ7vVBySRZo5mxlbtifZUj7yY9jfJFFkdWATLdW9Ilv4owi
 QRpw==
X-Gm-Message-State: AOJu0Yw5HmqZM9wSX3u4rkImJnzzwpO3jXvRmI0VcDBzRzzi/I85Eu3O
 pxKe0yOQkSsJh5cbtw0l3FF/h1iUqnVNwtU5p8/MHjRuxrvYCuReGrB8TGUysGg=
X-Google-Smtp-Source: AGHT+IFxi6vum8lat++X0XFaJZrKbv3JXb1JfIYRk6jdfAwSmReVGE8PcjbbKxQtu7KrbhGy/MZVZQ==
X-Received: by 2002:a17:906:5a8b:b0:a43:6146:a905 with SMTP id
 l11-20020a1709065a8b00b00a436146a905mr3691269ejq.24.1709024333793; 
 Tue, 27 Feb 2024 00:58:53 -0800 (PST)
Received: from [192.168.1.102] ([176.176.160.23])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a170906468500b00a3fb4d11809sm546749ejr.204.2024.02.27.00.58.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 00:58:53 -0800 (PST)
Message-ID: <646ec455-6f54-470c-8c77-5e7997b8ce29@linaro.org>
Date: Tue, 27 Feb 2024 09:58:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/41] Split out common part of peripherals
Content-Language: en-US
To: Sergey Kambalin <serg.oker@gmail.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Sergey Kambalin <sergey.kambalin@auriga.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
 <20240226000259.2752893-3-sergey.kambalin@auriga.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240226000259.2752893-3-sergey.kambalin@auriga.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 26/2/24 01:02, Sergey Kambalin wrote:
> Pre-setup for BCM2838 introduction
> 
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/bcm2835_peripherals.c         | 198 +++++++++++++++------------
>   hw/arm/bcm2836.c                     |  24 ++--
>   include/hw/arm/bcm2835_peripherals.h |  29 +++-
>   include/hw/arm/bcm2836.h             |   3 +-
>   4 files changed, 154 insertions(+), 100 deletions(-)
> 
> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
> index d5573fd954..ed38a08a57 100644
> --- a/hw/arm/bcm2835_peripherals.c
> +++ b/hw/arm/bcm2835_peripherals.c
> @@ -30,9 +30,9 @@
>   #define SEPARATE_DMA_IRQ_MAX 10
>   #define ORGATED_DMA_IRQ_COUNT 4
>   
> -static void create_unimp(BCM2835PeripheralState *ps,
> -                         UnimplementedDeviceState *uds,
> -                         const char *name, hwaddr ofs, hwaddr size)
> +void create_unimp(BCMSocPeripheralBaseState *ps,
> +                  UnimplementedDeviceState *uds,
> +                  const char *name, hwaddr ofs, hwaddr size)
>   {
>       object_initialize_child(OBJECT(ps), name, uds, TYPE_UNIMPLEMENTED_DEVICE);
>       qdev_prop_set_string(DEVICE(uds), "name", name);


> diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
> index 0203bb79d8..1fc96218f8 100644
> --- a/include/hw/arm/bcm2835_peripherals.h
> +++ b/include/hw/arm/bcm2835_peripherals.h
> @@ -35,10 +35,13 @@
>   #include "hw/misc/unimp.h"


> +void create_unimp(BCMSocPeripheralBaseState *ps,
> +                  UnimplementedDeviceState *uds,
> +                  const char *name, hwaddr ofs, hwaddr size);

Note for Peter, we should officialize this create_unimp() in "unimp.h",
all we need is the parent object and MR pointer.

> +void bcm_soc_peripherals_common_realize(DeviceState *dev, Error **errp);
> +
>   #endif /* BCM2835_PERIPHERALS_H */

