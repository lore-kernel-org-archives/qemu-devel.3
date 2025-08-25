Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A949ACA0FE1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 09:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqTfz-00071e-Q8; Mon, 25 Aug 2025 05:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uqTfi-0006zM-P7
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 05:39:29 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uqTfe-0000Ow-25
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 05:39:25 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3c7ba6c2b2cso895252f8f.1
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 02:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756114758; x=1756719558; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uL4MewPfGpmAXSTAGgHX+e6JFT0fYLvCPKi7tGEA830=;
 b=KmoDq2JHSl+9qOsaC9okSYHTAyfdq4aVXrxO3WtwGWgW0Yw9G79pXTf2kF6vk3g2Wh
 X1hrZP/OY5zRN2pVhbI+eXlmpKrYtHI6bLyfB26wvE6FU+RgCeV5Q+LqE1RrWrpIf9tD
 G7KCAjGPQ6ESpH4Gx5Js/YdqDicYOFZ8ZazUHfXMuSmbq2Ia5NwUIGmlPQO1+Pt6aIMX
 dhebPUSILk9YrGu2fsNPEzcL49nQuQtViOX7VstVOpSOYqEt9MNerWW/vHvMpEybkyt6
 GYo4PUAhy6IUDG4EpDbWSkHGbyZEgYXw8ZWSRQrXxoOsGcvKxR0K4mTbcpd0MsZiqeMX
 3h/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756114758; x=1756719558;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uL4MewPfGpmAXSTAGgHX+e6JFT0fYLvCPKi7tGEA830=;
 b=Wqyd6TUgai79Zb3PVKaiR4rMdrRMTjdqXROn63juufbRvhRAC3oeqrsXRJCfkumR3D
 F4jVWtpAj/TWBis9AJKS92gc9zVQyPuo8OQPYZV9JvFDP1sYV5RNDUJb3PBD50mS+irf
 XXLfcZQcAh00HRSTBDf9XQ7p4/tbDduMxke97ceeRMPIXXBUFbbfz8g+O3zgoBT0Oodk
 phfy10nuI8lsSOKQ/+IwjcrT7P1HbmBO5Mt57JnIp8N88Tc4ngixFachOer/lFKRIgO7
 wXT8bvR9W/l2wkanZYAX0eV6jp1D7y7wVjQj6f18cIje6p6Op2h7o/vkObp8QxS/+Adc
 v0rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlFOilIhnjS6GCsMsum4x33Uxw/1XVtC2sZf8Wob/zlHElBwcVjv8rBfCZ5ZZsOeSrS5Ydg7/howN+@nongnu.org
X-Gm-Message-State: AOJu0YxdvCtAKnpk3N1U+naTzFviwiZ4kSJKbOLodvwNmNd38JwUK2jZ
 nzwwBlpuR5sCHFIX7wuknTsEtAO8cghIwLIdNT6+5CkqOUKBipruIpd27yMGapK0/p8=
X-Gm-Gg: ASbGncvDOefDbNhb6Km/VJCC09/+vQS3mhNvuBKXC9d6Wk8Br0+UEpbFR4sFKUTn64f
 GPYdLZllgfOaPdOxXH30BPOQ048Y+jXit9wvGEE2l3H4HBkhVsunuZ2o2lS+Fze+ZALka8LYMS5
 i3BgKCpabyzRdpfDbtyOkc69P/Vwwoioohp/FsP4lF9khtBGSvpGDYzl5L1cdGQonG5CIc8jsmX
 HluyOBjyBuxV/jSNJUtlt7pWSPFAaC8RcXI7kH94dHy+/IjhLkyQEPBAtbZeeZR4UOqcyDOj/MN
 rkOpISO9xKqdOSRh1evnCoRsUW/W3JUuMYC7scGlkKbtUs8BdQfZEELlHBoGPpWrgP8pUm4xeD5
 aJSlWFtM4MOnJNCIl+maoE848qPfT7Fkpa4mfejcxoKTRwOjKqx6tbz33QpOmNqdtuA==
X-Google-Smtp-Source: AGHT+IFH7uUbxr6eUdjiBdUJmskjnnkgLBniP+B7sguOqZHqkI5ioNblKBq7M5V51eMzKtl7J37/+g==
X-Received: by 2002:a05:6000:2384:b0:3ca:267f:2a18 with SMTP id
 ffacd0b85a97d-3ca267f2c67mr1099308f8f.46.1756114757847; 
 Mon, 25 Aug 2025 02:39:17 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c70e4b9e1fsm11424049f8f.14.2025.08.25.02.39.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Aug 2025 02:39:17 -0700 (PDT)
Message-ID: <6fbcb266-83d0-496f-9ef2-bf00dd9b2629@linaro.org>
Date: Mon, 25 Aug 2025 11:39:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] hw/sd/sdcard: Fix size check for backing block image
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <cover.1756019920.git.jan.kiszka@siemens.com>
 <0d95cffa6131a06404f3cd6ef5951720ce01c37e.1756019920.git.jan.kiszka@siemens.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0d95cffa6131a06404f3cd6ef5951720ce01c37e.1756019920.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 24/8/25 09:18, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> The power-of-2 rule applies to the user data area, not the complete
> block image. The latter can be concatenation of boot partition images
> and the user data.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   hw/sd/sd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


