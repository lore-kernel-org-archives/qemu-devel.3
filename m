Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 932EECD4846
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 04:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smmnN-0008Sw-3V; Sat, 07 Sep 2024 00:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smmnK-0008SC-Rc
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 00:11:30 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smmnJ-0001WF-1t
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 00:11:30 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c3c30e663fso3241680a12.1
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 21:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725682286; x=1726287086; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=be0eAjSb4KBNcqmPR0gH+7HNdLZ1iu0FGVbBkohQ4Pk=;
 b=mYCaqz3kSMu6sJ6oEFs/DsTs/g0WdYGkcVjgsQL9Ag7/5jLPzCxCawN+Vy3jxYHhUa
 C24vpF8uOyJCc18r+gaju1NA8XCy1WdGTypAipEsy7wnc7uZK0FTPnW/Cq4b3WrHKE7t
 +eYmmkT3MSNnYSdUDMgExClNFW3IvqF0Dxx9sIcSgx2BA2AuQaifHT33K/mV+MftFqj5
 X+BIxZSWyN2+4V1aNRjgzzHVJp68tdxs2PpNElixFjWrbOWPlqauJorbPrzftUem6IGU
 SnlJONprpTgP2U77EJjUREpwGiZCyQX0JbBnuMwchdNb4wxMmxFKE59RjVmUnpbyRazq
 45iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725682286; x=1726287086;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=be0eAjSb4KBNcqmPR0gH+7HNdLZ1iu0FGVbBkohQ4Pk=;
 b=h1zxD73aFqD8FVawilnQTjSLuMy6iflfGCZBCdj2qjBdDNWOWnpcFjuDBLUFJDBShw
 ZAe4Q+bfdS1RqxhM2U7Pkg+/RZQAVFpjqOEbkjUwG4VTiWHwoxJGODtBsnnCFIUzm5oz
 YyZvy4gh2KOSCYV8Es8xzYjBvKVdfMSEACBJUXMF7boCD/FMs5xKKhRTiKmrjKKE7EBX
 lHmCa1g5f9h459bwaA1S4uE9+YZbPWrv+sx4NyPSHsjzuo7wgzyHFPRjX11ZEawIuisd
 QJTz4dbrWRTG5KYgo1aOdRyjIsA1m/DnuH1mYtsYb98+o2hEeWMDKtStfHueFv14fJbg
 QNqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVv6RCjfd3bdX8tgUYvGdjEez2hMURBGOCKWfwbRxWSSYNZqylkI85HWjX+/IeDR/JXLk81QFYCMIHE@nongnu.org
X-Gm-Message-State: AOJu0YwYSO5NUoBy6A2K1wKKPtmZGMQITSQeIxAf6mCTjL1YlJ1kAFkR
 blBMkFJ/wWSHJB/u2+lJPtWRnMERgeUNpI359RmohNM+km9FkDOkKUne5/qIaRc=
X-Google-Smtp-Source: AGHT+IGyyzo/7WpO9npyer27HaGVfy57P3taMLwhE8+/57X1iaAd1B4wo/GYrzRnG/6dclJKoY7GsQ==
X-Received: by 2002:a17:907:7e85:b0:a77:cb7d:f361 with SMTP id
 a640c23a62f3a-a8a88843502mr356008766b.43.1725682286090; 
 Fri, 06 Sep 2024 21:11:26 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.197.174])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25835686sm24885366b.18.2024.09.06.21.11.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 21:11:25 -0700 (PDT)
Message-ID: <b8371c9e-b540-4552-9ecc-cb24c2c7ba88@linaro.org>
Date: Sat, 7 Sep 2024 06:11:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] hw/sensor/tmp105: Coding style fixes
To: Guenter Roeck <linux@roeck-us.net>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20240906154911.86803-1-philmd@linaro.org>
 <20240906154911.86803-2-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240906154911.86803-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

On 6/9/24 17:49, Philippe Mathieu-Daudé wrote:
> From: Guenter Roeck <linux@roeck-us.net>
> 
> Coding style asks for no space between variable and "++". The next patch
> in this series will change one of those assignments. Instead of changing
> just one with that patch, change all of them for consistency.
> 
> While at it, also fix other coding style problems reported by checkpatch.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/sensor/tmp105.c | 44 ++++++++++++++++++++++++--------------------
>   1 file changed, 24 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
> index a8730d0b7f..ad97c9684c 100644
> --- a/hw/sensor/tmp105.c
> +++ b/hw/sensor/tmp105.c
> @@ -29,16 +29,17 @@
>   
>   static void tmp105_interrupt_update(TMP105State *s)
>   {
> -    qemu_set_irq(s->pin, s->alarm ^ ((~s->config >> 2) & 1));	/* POL */
> +    qemu_set_irq(s->pin, s->alarm ^ ((~s->config >> 2) & 1));   /* POL */
>   }
>   
>   static void tmp105_alarm_update(TMP105State *s)
>   {
> -    if ((s->config >> 0) & 1) {					/* SD */
> -        if ((s->config >> 7) & 1)				/* OS */
> -            s->config &= ~(1 << 7);				/* OS */
> -        else
> +    if ((s->config >> 0) & 1) {                                 /* SD */
> +        if ((s->config >> 7) & 1) {                             /* OS */
> +            s->config &= ~(1 << 7);                             /* OS */
> +        } else {
>               return;
> +        }
>       }
>   
>       if (s->config >> 1 & 1) {
> @@ -89,7 +90,8 @@ static void tmp105_get_temperature(Object *obj, Visitor *v, const char *name,
>       visit_type_int(v, name, &value, errp);
>   }
>   
> -/* Units are 0.001 centigrades relative to 0 C.  s->temperature is 8.8
> +/*
> + * Units are 0.001 centigrades relative to 0 C.  s->temperature is 8.8
>    * fixed point, so units are 1/256 centigrades.  A simple ratio will do.
>    */
>   static void tmp105_set_temperature(Object *obj, Visitor *v, const char *name,
> @@ -118,30 +120,30 @@ static void tmp105_read(TMP105State *s)
>   {
>       s->len = 0;
>   
> -    if ((s->config >> 1) & 1) {					/* TM */
> +    if ((s->config >> 1) & 1) {                                 /* TM */
>           s->alarm = 0;
>           tmp105_interrupt_update(s);
>       }
>   
>       switch (s->pointer & 3) {
>       case TMP105_REG_TEMPERATURE:
> -        s->buf[s->len ++] = (((uint16_t) s->temperature) >> 8);
> -        s->buf[s->len ++] = (((uint16_t) s->temperature) >> 0) &
> -                (0xf0 << ((~s->config >> 5) & 3));		/* R */
> +        s->buf[s->len++] = (((uint16_t) s->temperature) >> 8);
> +        s->buf[s->len++] = (((uint16_t) s->temperature) >> 0) &
> +                (0xf0 << ((~s->config >> 5) & 3));              /* R */
>           break;
>   
>       case TMP105_REG_CONFIG:
> -        s->buf[s->len ++] = s->config;
> +        s->buf[s->len++] = s->config;
>           break;
>   
>       case TMP105_REG_T_LOW:
> -        s->buf[s->len ++] = ((uint16_t) s->limit[0]) >> 8;
> -        s->buf[s->len ++] = ((uint16_t) s->limit[0]) >> 0;
> +        s->buf[s->len++] = ((uint16_t) s->limit[0]) >> 8;
> +        s->buf[s->len++] = ((uint16_t) s->limit[0]) >> 0;
>           break;
>   
>       case TMP105_REG_T_HIGH:
> -        s->buf[s->len ++] = ((uint16_t) s->limit[1]) >> 8;
> -        s->buf[s->len ++] = ((uint16_t) s->limit[1]) >> 0;
> +        s->buf[s->len++] = ((uint16_t) s->limit[1]) >> 8;
> +        s->buf[s->len++] = ((uint16_t) s->limit[1]) >> 0;
>           break;
>       }
>   }
> @@ -153,18 +155,20 @@ static void tmp105_write(TMP105State *s)
>           break;
>   
>       case TMP105_REG_CONFIG:
> -        if (s->buf[0] & ~s->config & (1 << 0))			/* SD */
> +        if (s->buf[0] & ~s->config & (1 << 0)) {                /* SD */
>               printf("%s: TMP105 shutdown\n", __func__);
> +        }
>           s->config = s->buf[0];
> -        s->faults = tmp105_faultq[(s->config >> 3) & 3];	/* F */
> +        s->faults = tmp105_faultq[(s->config >> 3) & 3];        /* F */
>           tmp105_alarm_update(s);
>           break;
>   
>       case TMP105_REG_T_LOW:
>       case TMP105_REG_T_HIGH:
> -        if (s->len >= 3)
> +        if (s->len >= 3) {
>               s->limit[s->pointer & 1] = (int16_t)
>                       ((((uint16_t) s->buf[0]) << 8) | s->buf[1]);
> +        }
>           tmp105_alarm_update(s);
>           break;
>       }
> @@ -175,7 +179,7 @@ static uint8_t tmp105_rx(I2CSlave *i2c)
>       TMP105State *s = TMP105(i2c);
>   
>       if (s->len < 2) {
> -        return s->buf[s->len ++];
> +        return s->buf[s->len++];
>       } else {
>           return 0xff;
>       }
> @@ -215,7 +219,7 @@ static int tmp105_post_load(void *opaque, int version_id)
>   {
>       TMP105State *s = opaque;
>   
> -    s->faults = tmp105_faultq[(s->config >> 3) & 3];		/* F */
> +    s->faults = tmp105_faultq[(s->config >> 3) & 3];            /* F */
>   
>       tmp105_interrupt_update(s);
>       return 0;


