Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDA0C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 07:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3sxt-0000di-14; Mon, 06 May 2024 03:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3sxj-0000bf-Ja
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:40:39 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3sxh-0004EB-MK
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:40:39 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-34e0d8b737eso2248096f8f.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714981236; x=1715586036; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=inEh6Q3uuz9M89pzcpxxaqJLD7S34EpRA+Z7k9AnTQM=;
 b=MUdBxFEcLPthfM1eR7obhfdxeVpR0wcpPC8r3mmVMOZ/JHuxv4Q8KmCNhh6omitnHs
 hrgTjxwpKXJJathghVLe4+aD4RnwCXiKOtYIP46yh+lRnUJEh9kW7x3J6WNcljTsgloY
 77lZYQQaZNqSLELYHskpGu4wxcaKgQKfCKFxhBS/YEZUUM6DTscVYVVXKxztYUfky5Ik
 vvVTAD/7EMtP8zMipV8xxsVGtrgEvSxPY3u7rU4QDq8XZ44OyvGP4Gz5BRinRmlEGKwN
 qEXt7uPQVjKq8gTaMBk+9iJrxdE8ZM7RT8sC0HwUYyUBA8gp+dJpZiztp0Cz85DG2ls/
 ROBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981236; x=1715586036;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=inEh6Q3uuz9M89pzcpxxaqJLD7S34EpRA+Z7k9AnTQM=;
 b=bTiywaQONHOk20NOzXNGIBV97JCyBoCjc8rSwInBfo9npqUMYbffJrvZOUxo6aRYaj
 rALlEPhFlN4xhPTCvrlT6fLevX+0GXVvU01MbHgER886Es7i4R+KhnTKihOfF/F0cPC3
 Mh+ymTWUr4BXe8hRJvp1OwPb8g9PZeGqU6lGBY4K8pNhAinVCC6lzSLmAhGptwgcNgBQ
 dD6oZWjWmRXOl2kikXZzx6EkcdSTMY/uyXbGVm4MrHs/vCcF53q5b6yLAt3ZFFp9Zk4a
 dNi4WetqRAkVjJaunHSzn7vCXRv1ntbXNjH7ELoqkB3dywNYBMj7SnTIf1LKCAO1EZGy
 tUrA==
X-Gm-Message-State: AOJu0YyBIZuzsiFUZ4dq2GeAe0SW31J7zKVlAjfXhXQiP+TWIH+zfm8E
 zeoxhLAXe7izOFNaGeS0wFRaaJ5ooFFnJAFhhOKmkVVvDyCq5chsMY12eFVvDoE=
X-Google-Smtp-Source: AGHT+IFPnC/QiMXcMXEpYepc2pP5o854ryHbU5FzKamaw03JqFfgsTZmfaLDbKrHM+qwbYgUHKgsLg==
X-Received: by 2002:a05:6000:1806:b0:34d:7f59:30b8 with SMTP id
 m6-20020a056000180600b0034d7f5930b8mr7888717wrh.12.1714981235956; 
 Mon, 06 May 2024 00:40:35 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.4])
 by smtp.gmail.com with ESMTPSA id
 s8-20020adfecc8000000b0034dda041ccasm10015048wro.102.2024.05.06.00.40.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 00:40:35 -0700 (PDT)
Message-ID: <f176024a-f69a-4371-9434-59041ceb7958@linaro.org>
Date: Mon, 6 May 2024 09:40:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] hw/arm/bcm2836: Remove unusued struct 'BCM283XClass'
To: "Dr. David Alan Gilbert" <dave@treblig.org>, peter.maydell@linaro.org,
 laurent@vivier.eu
Cc: qemu-devel@nongnu.org, Sergey Kambalin <serg.oker@gmail.com>
References: <20240505171444.333302-1-dave@treblig.org>
 <20240505171444.333302-6-dave@treblig.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240505171444.333302-6-dave@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 5/5/24 19:14, Dr. David Alan Gilbert wrote:
> This struct has been unused since
> Commit f932093ae165 ("hw/arm/bcm2836: Split out common part of BCM283X
> classes")

Rather than "splitting out", commit f932093ae165 duplicated BCM283XClass
as BCM283XBaseClass and left it unmodified.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>   hw/arm/bcm2836.c | 12 ------------
>   1 file changed, 12 deletions(-)
> 
> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> index db191661f2..40a379bc36 100644
> --- a/hw/arm/bcm2836.c
> +++ b/hw/arm/bcm2836.c
> @@ -18,18 +18,6 @@
>   #include "target/arm/cpu-qom.h"
>   #include "target/arm/gtimer.h"
>   
> -struct BCM283XClass {
> -    /*< private >*/
> -    DeviceClass parent_class;
> -    /*< public >*/
> -    const char *name;
> -    const char *cpu_type;
> -    unsigned core_count;
> -    hwaddr peri_base; /* Peripheral base address seen by the CPU */
> -    hwaddr ctrl_base; /* Interrupt controller and mailboxes etc. */
> -    int clusterid;
> -};
> -
>   static Property bcm2836_enabled_cores_property =
>       DEFINE_PROP_UINT32("enabled-cpus", BCM283XBaseState, enabled_cpus, 0);
>   


