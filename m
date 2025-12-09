Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2436BD3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 14:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSz53-0000Xw-D7; Tue, 09 Dec 2025 09:52:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vSz50-0000XL-S3
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 09:52:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vSz4z-00005n-2X
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 09:52:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765291959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=io7JWqQd9z1Hrtj3lPMQmlaJidHiu62v7e+HMM/aD40=;
 b=WIm1vYrlt/anurnYa6sfJ6E7E8gjMSGSqIu7X0QghSYrajKetyitJqy5tz90FvLmBUxzz/
 HTNq8n3GT909AEwM5ZizkKV3PH6ue6TgM0pJDUE7uQe8qoNaRB6fFNXyJKj4zrhp6nmypd
 F/HssXXAkT9+Cb8cThSObr4+kJMlw+o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-wQ4F-n6hNgawvY96uAWKUA-1; Tue, 09 Dec 2025 09:52:37 -0500
X-MC-Unique: wQ4F-n6hNgawvY96uAWKUA-1
X-Mimecast-MFC-AGG-ID: wQ4F-n6hNgawvY96uAWKUA_1765291956
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477563e531cso37414795e9.1
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 06:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765291956; x=1765896756; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=io7JWqQd9z1Hrtj3lPMQmlaJidHiu62v7e+HMM/aD40=;
 b=ofR7XAjiitOfzKoSOOVRceORIcOLP0K+fivwamAMa0W8NsEf0meGILfgMXZYAho01O
 A9Hp7xVw645cXPwHn0KkLpHgpZ+CcXmmYW1N7WTHFgcQQqHTgmvpgnbUE9mW2HeMydCt
 /25PRYeL7d0KfJJsoJI0h8Nvy9AWN2/nrN5/qFUDyVCrj2licO5YEkhclhVvDGddrtL/
 R8jmBGbK7e2wETNoDJ8N3socRz5Qw5KaBt0/MUgK73593Ig/QEQCi0Np6nq+aEfdbXzM
 V2tGKwECxH5ceYgIdXdBSL/DKQeTPdKGFjQ03XTMIBtSMX3yZUDjX+mjs5eQoW0UPAQu
 JAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765291956; x=1765896756;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=io7JWqQd9z1Hrtj3lPMQmlaJidHiu62v7e+HMM/aD40=;
 b=tUsH1jCWbFT1T2FzUl0gdCRjmBCFcICL6VJICvu86XU50WZ9jxBUCfz8xPpvS1OLiJ
 VRTe2RKiK1euGIpKOhxzLNQ5duLWnvmxbfRd5GryZ+2UwcThuKwCZkMIZDuMWNl06UtU
 T/K9gKH6koj/jU/S+ti67APGtYTES9AoiYKU599XADTQU7GUGFUR0iB+hmdyd8gz+Wid
 z0eZZkGxAcssY6pkii3+8d5FkdQHRNY23eUybVKOBR5mOTXgtosNxybRaYuy6Q5pNZ06
 hWFV2qEd91NxJjFixwCzedgWLo5cP7A1Ai9KFf4IYa1geQf8LMkeh/rOkWmtmEagMthW
 n2lQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWke23L4+pa1gqv1ymapy3TOQn6HgoqBMsorixOtdRrzCWL/7msABXrqsP6SLw0HdOiI7X7W+isIox@nongnu.org
X-Gm-Message-State: AOJu0YwlE5SRmeuG5vmLCz3+Wg9n32XnkRazCEvSUmQ0oZl88kAVD9w+
 Yl9iwrc+vjTvUuocMrGxsTBgz80O78fKDq02MucSgTSxRXKGV2die99UUqe0jXtrrnmsCVwAQww
 24oA4FLrDK3PTtJWOpX9EltqnXAWZqfb36sWjuCOPtx+Eco7iqtuiJZxn
X-Gm-Gg: ASbGncsjzmG3ypzfgHwfAMm7r2UovZhOVwWf/tJfS/oWl7siUCLwMit8KDSYXw4PE8P
 t6MWzviglQGSRHy2+iMbROSzprYDa5Up4m1mPHTHBHJrdOc4TNbm9KhvMJHEsv793iL7nRJnEli
 Aq8XaoBOwTx1NcNhMhhdAIPDmhaM6DVCYrTUgm1hphosEeca5ExnXpO99TwrmR7BxPGSvCp6JS2
 1XMo+q18WCb9Xia7kl9et+qNP/6/xE1PFW/R2ZIeZVsi0wVUvtK6RRSOMNwVNfXrZLdkHwvVqlD
 WXK8qyOp/Mo/oiGHENYhxe27zRTR3gW53s5gPP9fuN0NXNTJwqtzmUQXxbjlmUnVpP5xsbwncr6
 hE/O5gR5OnyGKfIUKKC0YKWxTK2w+sfgJqklbFrbBlGWaKxh6
X-Received: by 2002:a05:600c:1f90:b0:475:dcbb:7903 with SMTP id
 5b1f17b1804b1-47939dfbf05mr93534185e9.9.1765291956324; 
 Tue, 09 Dec 2025 06:52:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVwg4yQ4nfB2Mge3HiwvS/wUm0izAIVVrmi04AruSDJHOqyjHwMPoFTUc/J2rLm/QRVs0aWg==
X-Received: by 2002:a05:600c:1f90:b0:475:dcbb:7903 with SMTP id
 5b1f17b1804b1-47939dfbf05mr93534025e9.9.1765291955839; 
 Tue, 09 Dec 2025 06:52:35 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a816938d4sm13496865e9.1.2025.12.09.06.52.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 06:52:35 -0800 (PST)
Message-ID: <4dae8293-066f-4354-b50a-05ba4cc9b80f@redhat.com>
Date: Tue, 9 Dec 2025 15:52:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] hw/gpio/aspeed_sgpio: aspeed: Add QOM property
 accessors for SGPIO pins
To: Yubin Zou <yubinz@google.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kane-Chen-AS
 <kane_chen@aspeedtech.com>, Nabih Estefan <nabihestefan@google.com>,
 qemu-arm@nongnu.org
References: <20251209-aspeed-sgpio-v2-0-976e5f5790c2@google.com>
 <20251209-aspeed-sgpio-v2-2-976e5f5790c2@google.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251209-aspeed-sgpio-v2-2-976e5f5790c2@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

The subject needs a fix. Please remove the extra 'aspeed: '.

On 12/9/25 01:01, Yubin Zou wrote:
> This commit adds QOM property accessors for the Aspeed SGPIO pins.

I think you can drop the above sentence from the commit log. It's
redundant with the subject.

> The `aspeed_sgpio_get_pin` and `aspeed_sgpio_set_pin` functions are
> implemented to get and set the level of individual SGPIO pins. These
> are then exposed as boolean properties on the SGPIO device object.
> 
> Signed-off-by: Yubin Zou <yubinz@google.com>
> ---
>   hw/gpio/aspeed_sgpio.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 78 insertions(+)
> 
> diff --git a/hw/gpio/aspeed_sgpio.c b/hw/gpio/aspeed_sgpio.c
> index 8676fa7ced134f1f62dc9e30b42c5fe6db3de268..efa7e574abe87e33e58ac88dba5e3469c6702b83 100644
> --- a/hw/gpio/aspeed_sgpio.c
> +++ b/hw/gpio/aspeed_sgpio.c
> @@ -91,6 +91,73 @@ static void aspeed_sgpio_2700_write(void *opaque, hwaddr offset, uint64_t data,
>       }
>   }
>   
> +static bool aspeed_sgpio_get_pin_level(AspeedSGPIOState *s, int pin)
> +{
> +    uint32_t value = s->ctrl_regs[pin >> 1];
> +    bool is_input = !(pin % 2);
> +    uint32_t bit_mask = 0;
> +
> +    if (is_input) {
> +        bit_mask = SGPIO_SERIAL_IN_VAL_MASK;
> +    } else {
> +        bit_mask = SGPIO_SERIAL_OUT_VAL_MASK;
> +    }
> +
> +    return value & bit_mask;
> +}
> +
> +static void aspeed_sgpio_set_pin_level(AspeedSGPIOState *s, int pin, bool level)
> +{
> +    uint32_t value = s->ctrl_regs[pin >> 1];
> +    bool is_input = !(pin % 2);
> +    uint32_t bit_mask = 0;
> +
> +    if (is_input) {
> +        bit_mask = SGPIO_SERIAL_IN_VAL_MASK;
> +    } else {
> +        bit_mask = SGPIO_SERIAL_OUT_VAL_MASK;
> +    }
> +
> +    if (level) {
> +        value |= bit_mask;
> +    } else {
> +        value &= ~bit_mask;
> +    }
> +    s->ctrl_regs[pin >> 1] = value;
> +}
> +
> +static void aspeed_sgpio_get_pin(Object *obj, Visitor *v, const char *name,
> +                                void *opaque, Error **errp)
> +{
> +    bool level = true;
> +    int pin = 0xfff;
> +    AspeedSGPIOState *s = ASPEED_SGPIO(obj);
> +
> +    if (sscanf(name, "sgpio%d", &pin) != 1) {
> +        error_setg(errp, "%s: error reading %s", __func__, name);
> +        return;
> +    }
> +    level = aspeed_sgpio_get_pin_level(s, pin);
> +    visit_type_bool(v, name, &level, errp);
> +}
> +
> +static void aspeed_sgpio_set_pin(Object *obj, Visitor *v, const char *name,
> +                                void *opaque, Error **errp)
> +{
> +    bool level;
> +    int pin = 0xfff;
> +    AspeedSGPIOState *s = ASPEED_SGPIO(obj);
> +
> +    if (!visit_type_bool(v, name, &level, errp)) {
> +        return;
> +    }
> +    if (sscanf(name, "sgpio%d", &pin) != 1) {
> +        error_setg(errp, "%s: error reading %s", __func__, name);
> +        return;
> +    }
> +    aspeed_sgpio_set_pin_level(s, pin, level);
> +}
> +
>   static const MemoryRegionOps aspeed_gpio_2700_ops = {
>     .read       = aspeed_sgpio_2700_read,
>     .write      = aspeed_sgpio_2700_write,
> @@ -114,6 +181,16 @@ static void aspeed_sgpio_realize(DeviceState *dev, Error **errp)
>       sysbus_init_mmio(sbd, &s->iomem);
>   }
>   
> +static void aspeed_sgpio_init(Object *obj)
> +{
> +    for (int i = 0; i < ASPEED_SGPIO_MAX_PIN_PAIR * 2; i++) {
> +        char *name = g_strdup_printf("sgpio%d", i);

You could use a g_autofree variable and drop the g_free below.

How about using a "%03d" format in the printf and sscanf too ?

C.

> +        object_property_add(obj, name, "bool", aspeed_sgpio_get_pin,
> +                            aspeed_sgpio_set_pin, NULL, NULL);
> +        g_free(name);
> +    }
> +}
> +
>   static void aspeed_sgpio_class_init(ObjectClass *klass, const void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -143,6 +220,7 @@ static const TypeInfo aspeed_sgpio_ast2700_info = {
>     .name           = TYPE_ASPEED_SGPIO "-ast2700",
>     .parent         = TYPE_ASPEED_SGPIO,
>     .class_init     = aspeed_sgpio_2700_class_init,
> +  .instance_init  = aspeed_sgpio_init,
>   };
>   
>   static void aspeed_sgpio_register_types(void)
> 


