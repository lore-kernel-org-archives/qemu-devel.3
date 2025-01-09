Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688EDE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 11:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVqtd-0003xp-DV; Thu, 09 Jan 2025 06:40:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVqtb-0003xQ-Ul
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 06:40:15 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVqtZ-00007m-O0
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 06:40:15 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-436a03197b2so6122565e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 03:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736422812; x=1737027612; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/GpW8pi5DDmdwrBTd4YRCzdbdOjWSGX1R38gOGZ1JAs=;
 b=m+vzVU1/7h1grTW27k82BMwxV+Gq1dR4bMu5rhEftETLpkjJyFggjbf3J9e8rLLlaN
 GiqfVFPr5CQsfZCUbA9LvtMFsllna8zmpX4o6kuEwbecr/h13usfOHI6msF2HMtxvJ8w
 mvo9/CraMRLXNX89LNR5yc64bgm36y78RQZ2r7pO4dbKr59xXS3QXeqTxCDlwAKI/SjL
 gWiqFpBfRULr4Lm528vYsdw298DuHkAAvTOEfO5SdBpN7qwF8qLv3+XGonO6njtmZXyG
 w8Ak7+rTQKThL1CckDpwBNupRSMS2zMQTPTBQIcuoXSxmHSgcnaQ5CXUxSbrzkotvfKw
 xmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736422812; x=1737027612;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/GpW8pi5DDmdwrBTd4YRCzdbdOjWSGX1R38gOGZ1JAs=;
 b=QCYLa9R9+9uPeKWvCd2jTwVSxE71/KGYdzrwaI4eCN/w+tVeKSrbd1u2DhSesivSYv
 mEkuWHC1iW/aD+EZ31+czPkt5CYDq6YHyGtxDA3pXXlvLNCW+Gy5bDtY248fVVBKNkU1
 5X2B45psd3202gNwe2PRtcNawb3w6ZyrddqqJcwhmGVpK8btf0Mf9+SPayCjdS1mADSK
 3vjtwbhpiuBEbHG6U337BlcANCjIN/HagyH3anUzz2b5NRbdZe2RmLkm0VSeMzfUuRX6
 wsTfAy6PEmpMAXz1ABUbQlNNzuc6H2Us9n4zuMOaz/d71XB276TaafqiCk3qCtcLitI4
 YG5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7Ns2glXo1UROPFU7LmRRaaOpMsJYfX4/XPE5nqWxPA5nxv1BgnjRHpxAUd/0q8obObQnUy4kPcCxh@nongnu.org
X-Gm-Message-State: AOJu0Yyj3LalXbEYREds2MDFPHgl11P6O9dbAKLFpcI7ASHTb3lZdHSo
 ocvRvn+vWaSUyqPJtjlvT2YzthhqzSDfeH415r6KmZyhvETzXiEkrAFp2FLtrR8=
X-Gm-Gg: ASbGncvfulbZ/BRKvkmN6U43dmYSSvTKrC+x4jRU/Y/2B9FQAiw70jlf/qv+Cwa5a6t
 sJ8/e78tuGqNRtb6174ZQwIcCzqCj8tV1CROPLCy3aXWdu5kNfGCRTT0ltRpMl8L86/LNVWiYev
 QlvcJaOpXgSWiPLg7eoJOKgwUbqfDzafq9YfZdk7LlgyiTs6VyMjxP4ePLU3lYDTxLP/RBzw0OK
 hI3GLkoimyvr3iQ0XyG9+9BjsGf5oukR+hudtAwICykQS5FU5d+lWxOB1l23JUJvdI3VcQVG39v
 M3Z+2TbIQTBKVzXhWmUxywJM
X-Google-Smtp-Source: AGHT+IEOUqpdvN+AP1W2k8TwBzF/Q1DdU6pZjKEpuHMX0EJiQWmtUFYT9KZ1sHB4R9r561Kwjn4rIA==
X-Received: by 2002:a05:600c:35c1:b0:434:a468:4a57 with SMTP id
 5b1f17b1804b1-436e26efb22mr51308445e9.26.1736422811716; 
 Thu, 09 Jan 2025 03:40:11 -0800 (PST)
Received: from [192.168.69.102] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b8299sm1583646f8f.74.2025.01.09.03.40.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 03:40:11 -0800 (PST)
Message-ID: <342ca371-3e14-4108-9c45-e15cda51b9ca@linaro.org>
Date: Thu, 9 Jan 2025 12:40:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] hw/sd/sd: Allow for inverting polarities of
 presence and write-protect GPIOs
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Guenter Roeck <linux@roeck-us.net>, Andrey Smirnov
 <andrew.smirnov@gmail.com>, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250108092538.11474-1-shentey@gmail.com>
 <20250108092538.11474-9-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250108092538.11474-9-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Hi Bernhard,

On 8/1/25 10:25, Bernhard Beschow wrote:
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/sd/sd.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)


> @@ -876,8 +878,8 @@ static void sd_reset(DeviceState *dev)
>       sd->cmd_line = true;
>       sd->multi_blk_cnt = 0;
>   
> -    qemu_set_irq(sd->readonly_cb, sd_get_readonly(sd));
> -    qemu_set_irq(sd->inserted_cb, sd_get_inserted(sd));
> +    qemu_set_irq(sd->readonly_cb, sd_get_readonly(sd) ^ sd->readonly_active_low);

Please embed in sd_get_readonly(),

> +    qemu_set_irq(sd->inserted_cb, sd_get_inserted(sd) ^ sd->inserted_active_low);

and sd_get_inserted().

>   }
>   
>   static void sd_cardchange(void *opaque, bool load, Error **errp)
> @@ -896,9 +898,9 @@ static void sd_cardchange(void *opaque, bool load, Error **errp)
>       }
>   
>       if (sd->me_no_qdev_me_kill_mammoth_with_rocks) {
> -        qemu_set_irq(sd->inserted_cb, inserted);
> +        qemu_set_irq(sd->inserted_cb, inserted ^ sd->inserted_active_low);

Use sd_get_inserted(),

>           if (inserted) {
> -            qemu_set_irq(sd->readonly_cb, readonly);
> +            qemu_set_irq(sd->readonly_cb, readonly ^ sd->readonly_active_low);

and sd_get_readonly() here.

>           }
>       } else {
>           sdbus = SD_BUS(qdev_get_parent_bus(dev));
> @@ -2797,6 +2799,8 @@ static void emmc_realize(DeviceState *dev, Error **errp)
>   
>   static const Property sdmmc_common_properties[] = {
>       DEFINE_PROP_DRIVE("drive", SDState, blk),
> +    DEFINE_PROP_BOOL("cd-active-low", SDState, inserted_active_low, false),
> +    DEFINE_PROP_BOOL("wp-active-low", SDState, readonly_active_low, false),
>   };
With the requested changes:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


