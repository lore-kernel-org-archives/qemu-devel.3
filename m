Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40063E7716A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 13:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMSOi-00066I-DJ; Sat, 14 Dec 2024 08:41:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMSOe-00065i-BH
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 08:41:29 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMSOb-0000Xl-K3
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 08:41:27 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38633b5dbcfso2917172f8f.2
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2024 05:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734183683; x=1734788483; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l8HT69QtbfQhpFU2wKVMNmKDJzVqtpk3QtxcDOo0QVw=;
 b=JK8+KGl21Ns38LxEWItU690Xf7kX/6KfYcjeu+uBatvwC+QH33TfMvIvT/mjJOxnUM
 rm6eeAsIgFVqq4OnxPaE4nhxdYHpBdik4JMhf4EctbBsHd0fqiWLXs2B7NFTGvcqoSi9
 dx0dg4sfJAy/KgVaB27WksKf2FrYDoOb0cXDsg2qg0GiLnHGVLjaE1F1CeLCmjdGQNdi
 cOlEzBl0VSQ8ms2U41+Nm8PpIRb3zZP233o+zvjrs5u3iNQKvnLl0/IqeNKUTF9jL86T
 rE31WWsg89Xwoh5SLgRV6tCc2H8URlPNuM8LBx0lWS5N8/vtXypKPU/kmgDRrEwMQ1go
 X3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734183683; x=1734788483;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l8HT69QtbfQhpFU2wKVMNmKDJzVqtpk3QtxcDOo0QVw=;
 b=k84mloB5/pG6ud7kqHlH70WZ8M2EVzvLxbkGbjPQ8TBxc5fUdxFDUGVxkL6FrbV7KJ
 6VDZNGCA9tWsw27AKFZw8tAjRF0f9tTDl1/sMWH6T3TnNl4zGxzgVzTN+jZbhwzEdTer
 1TFJTnhtkZKvUsyTc/KdeDcltl49+mL716mO0vvSwj+RnC20nVC2NltlrKeCDajXx5HW
 tfuXKAr+03YaPY09FLPXGsEKdplghzwf0HFat1xoFEmL9BY906Fyp3eZt3J5BldQE4us
 b1ZwTEDDsXlB3T936X6DV3pJ60LhSkW1nfx9UoI3nmM5QUPzgd+DW4395GFuR1wXwFGM
 lekg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUo18/DKp5XZuLp3LNUEDw9rBo8sk7BKttG11/HTQrGRcK4WMk6j2LjjouBS9Ga6djz2WhZ6oSUe+2V@nongnu.org
X-Gm-Message-State: AOJu0YwYVD9U5+XxbsQSbfYAHZOa9s1ZvgSm6+/NkUytWeu/vMWY0cEJ
 tBdPlTDbf9BLaw48Qy0f7YZdyJh27DthWlqu5+Il3fPSjWEeF76LFACiI5Wqx5A=
X-Gm-Gg: ASbGnctfA2AGqbtCCXJQU2z11GojD6BWbd9EmmrxALcvRd4dSUjjHwk9/XHIB3i91Ha
 ochdmFHz0wQRwofUoM+3wpoV2WUvB6aP0gwDbhKaL9JNdaxzjclE+0PHMbS3stKFXwjlGgDUaZn
 /E6SvtiVwiPHjx6Eo1zmlKQajCzMZ6lEPx4bFGsfqR0lOz5UWRdXuHzyycSl9OY2OqwAA0tOeCY
 iV34IHFGB8cBnQfm4ARjrTxq0VtBRyDrSD4t/BhzsEEf58ZrprqYaZk1E+jxBQagXuMMDFkXrNW
 3TBPP9FgH7QQgbxXusu+87H+Zg==
X-Google-Smtp-Source: AGHT+IHMDvrm1GzyZLxe7s53V8BJI0v7LIWzg2SE/4bM6E3YE400fJhbfkveSyMgpuGbA8v6njuvSA==
X-Received: by 2002:a5d:5f50:0:b0:382:3959:f429 with SMTP id
 ffacd0b85a97d-38880ac5f31mr5912265f8f.5.1734183682965; 
 Sat, 14 Dec 2024 05:41:22 -0800 (PST)
Received: from [192.168.224.213] (201.19.205.77.rev.sfr.net. [77.205.19.201])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c805d489sm2627857f8f.88.2024.12.14.05.41.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2024 05:41:21 -0800 (PST)
Message-ID: <808e1429-6c6f-4ff7-9c3d-3f43ebbd94c0@linaro.org>
Date: Sat, 14 Dec 2024 14:41:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 26/34] next-cube: move reset of next-rtc fields from
 next-pc to next-rtc
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, huth@tuxfamily.org,
 qemu-devel@nongnu.org
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
 <20241212114620.549285-27-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241212114620.549285-27-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 12/12/24 12:46, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Thomas Huth <huth@tuxfamily.org>
> ---
>   hw/m68k/next-cube.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)


> +static void next_rtc_reset_hold(Object *obj, ResetType type)
> +{
> +    NeXTRTC *rtc = NEXT_RTC(obj);
> +
> +    rtc->status = 0x90;
> +
> +    /* Load RTC RAM - TODO: provide possibility to load contents from file */
> +    memcpy(rtc->ram, rtc_ram2, 32);
> +}

>   static const TypeInfo next_rtc_info = {
> @@ -1072,11 +1084,6 @@ static void next_pc_reset_hold(Object *obj, ResetType type)
>       s->scr1 = 0x00011102;
>       s->scr2 = 0x00ff0c80;
>       s->old_scr2 = s->scr2;
> -
> -    s->rtc.status = 0x90;
> -
> -    /* Load RTC RAM - TODO: provide possibility to load contents from file */
> -    memcpy(s->rtc.ram, rtc_ram2, 32);

Pre-existing, this looks suspicious to reset RTC device state
during device reset.

>   }
>   
>   static void next_pc_realize(DeviceState *dev, Error **errp)


