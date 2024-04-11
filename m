Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFD7CD128A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 09:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruqw1-000509-Ce; Thu, 11 Apr 2024 05:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruqvt-0004zi-Fj
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 05:41:27 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruqvr-000281-8X
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 05:41:25 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-417d0194703so4969285e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 02:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712828482; x=1713433282; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Oujz3dDmmZiYKokZJAg4NqnZe3hSV1SY4VZ770nmijI=;
 b=excYnDcB8k4EkJmE91V332wAJnFU85HrYoQKG1gpVdWBLYA62jabj76wHuP17M6oXr
 wexrKGBdHYZTdsQFJC6glT26lRlFTfScVoPiQWdg38lvUml6Ge7uHbV5uznLMMmbr8RN
 HMYEu0uij9khQ4HOmgAfMM6lK6CTkfQ++hWRwxllpvnhHLWVYTzaGDyOtx8lz8WyuJkZ
 o0B4S/CTBzlNh4e6KbdwO8k/XxkdQQNUrSBpYunndJix0pZk4wPAeaOaTbtJBqlSMiVV
 y6rU48MAreWXAETWSOq4xjhUAAgCqiGFcIq7LEGM6ztU4WbfKW62U9Rbro4grBu6xnRO
 9HYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712828482; x=1713433282;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Oujz3dDmmZiYKokZJAg4NqnZe3hSV1SY4VZ770nmijI=;
 b=GGJptGHXqU0eTdzA+z5N404YYyk9vi8HpaM6fKIHMR9daadF/XcFo62HKgtq6zOxcw
 sCTBeKJEjjTTNBppc6wI/6SE7tyAtJ9H5wxa2kxrYvZN2CbeEhzGZ0Ghk8Ci2noyBmHO
 RWwPXmj9H6VW0sjiv94Di1DhYIXCHU+p3mpZ+u7Om2S3qbt4dCGXvPHr0NvxxEO1PNbL
 NnBbHh67fMFFQYESM4jGqk1BdiMgXPKla7GwsRz5zRzqOMKvUGZ2FF1dSUpR8ESglHIu
 0Y46TYI6YdTCgpwddyGzcvXX9LCuUxDxKeby0CMt9GQqJm68GMUqERmL+fT0gYys8DzG
 9yNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgd0i79giTXXyzQysGFa6zCIdMznTuEqvzse4sSMxLfg9JpDvz/Q8XYAvMyVbunPZsKt9gXz/6Gzz0hrIRvSiImSdNlRg=
X-Gm-Message-State: AOJu0YzIwFd2P7ysLnpMre8t2I60YILsh2iT8anqQyXpLHA9bZPwxXrq
 CeDxVlhfsXpqTAKXimbbw4c8XE3U2Wy55k8oIHmB8owB1OJoo73ZUOj5+F2Tdn0=
X-Google-Smtp-Source: AGHT+IFiqB0eoWcG/28idkIKP7+GBYd4ZB3U6M849s/odUisk6TKSF5dkXb4Oyre9PfkpYUJbBu01Q==
X-Received: by 2002:a05:600c:5654:b0:415:6daf:c64b with SMTP id
 js20-20020a05600c565400b004156dafc64bmr4247047wmb.16.1712828481739; 
 Thu, 11 Apr 2024 02:41:21 -0700 (PDT)
Received: from [192.168.202.175] (137.red-88-29-174.dynamicip.rima-tde.net.
 [88.29.174.137]) by smtp.gmail.com with ESMTPSA id
 z11-20020a5d44cb000000b00345920fcb45sm1356748wrr.13.2024.04.11.02.41.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 02:41:21 -0700 (PDT)
Message-ID: <9fbc5825-e414-498a-9f70-2481a34a4411@linaro.org>
Date: Thu, 11 Apr 2024 11:41:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/isa/vt82c686: Keep track of PIRQ/PINT pins separately
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240410222543.0EA534E6005@zero.eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240410222543.0EA534E6005@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 11/4/24 00:25, BALATON Zoltan wrote:
> Move calculation of mask after the switch which sets the function
> number for PIRQ/PINT pins to make sure the state of these pins are
> kept track of separately and IRQ is raised if any of them is active.
> 
> Fixes: 7e01bd80c1 hw/isa/vt82c686: Bring back via_isa_set_irq()
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> Preferably for 9.0 if there will be another RC.
> 
>   hw/isa/vt82c686.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


