Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03440CCF9E6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 15:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stU9q-0005cB-B3; Wed, 25 Sep 2024 11:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1stU9o-0005Pn-Pe
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:42:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1stU9n-0004ri-5r
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727278942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ss0qqP0aF8g1Yg/SHfIfwuCeYFQ5veN2wXoxkFfmuHI=;
 b=eEYvjxz3mILlG/6HPyvIUH0B8eqFXXtQtQucFu5hI17rnsQKsCdUUqcHAEBjDWYPIcmTmG
 g/tc8S8qeYX3QD6ri3Og1n0fWXa3kkNyyZKw3X6DJPYJX81i2hpotf0KpVJY/nUsFwz9bF
 miI3FfjdIgVUdKbXX5wjDxE8BjTSW24=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-6NRLF0iCOl-brQ2X8X43zw-1; Wed, 25 Sep 2024 11:42:21 -0400
X-MC-Unique: 6NRLF0iCOl-brQ2X8X43zw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42cb5f6708aso44017115e9.2
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 08:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727278940; x=1727883740;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ss0qqP0aF8g1Yg/SHfIfwuCeYFQ5veN2wXoxkFfmuHI=;
 b=Ni2Uf5g1PKGBfzQ4WfeyKRM67g70hkd5W2AHrHD4Q1rfeVgS7GncjjDKlhk0EpBTjs
 0W7Bw8v6hl2zzP4+bTlEMCBXhyjSb63QZIvDjvsrH2OL5Zkp9E53cpn+6PvnOyWQR3GZ
 xuhspIGSbiiZh3XblypOlhAAmhRo0WqI0MIMMMe9A26BpzobcOr7i+RSVNveJChAOts0
 slzQq2Xs7rQHcA2FkkACNuxv4dpJnn04iFYfCD0ukF0hf5RtOZBJAfwF3UkUW+iTwxVK
 u4kAOCyyW9GFozfbhaq7qrXx4ZIkT0+JuBmi9hoeWBYEde9yzcGrkcI869YzQhZzTOQF
 9SPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSPFIcVt3i8XKyv6j3KLf6dLxKmBKvxgaOBXBnzdh04V7cW6xyF1tMxudpHOGc6g4MvWt90FDpmrMx@nongnu.org
X-Gm-Message-State: AOJu0Yy9W07sOiO1nV3F3QUC1pRtNN8N4J8DgAFl1gF1I8dGslWSOMvU
 4t8ZYmMGRfgD7fhbF6/8TAJeGsitTLQtIJWQW1vj8UMF1gEOGvxRmsOWFv14dPjMECd3DV+i2aT
 arGT1KRxh0X5OczOW9GnicNj0MsXZOrQ2PKyZGoQfTl4rkzsUCWVe
X-Received: by 2002:adf:eacc:0:b0:374:c90e:9909 with SMTP id
 ffacd0b85a97d-37cc2477c07mr2135856f8f.28.1727278939907; 
 Wed, 25 Sep 2024 08:42:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFC0oEEBW+W/Jmtd4GObH1k3sesM7NU65j67tYxemwXT5V83Fvj/kh5/ZZSy4YvQKZjq7hI/Q==
X-Received: by 2002:adf:eacc:0:b0:374:c90e:9909 with SMTP id
 ffacd0b85a97d-37cc2477c07mr2135831f8f.28.1727278939478; 
 Wed, 25 Sep 2024 08:42:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e969f90a0sm22343875e9.11.2024.09.25.08.42.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2024 08:42:18 -0700 (PDT)
Message-ID: <f05a5f5b-6f4d-41b5-828e-98ba5fe14834@redhat.com>
Date: Wed, 25 Sep 2024 17:42:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/23] hw/i2c/smbus_eeprom: Prefer DEFINE_TYPES() macro
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
References: <20240923093016.66437-1-shentey@gmail.com>
 <20240923093016.66437-21-shentey@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240923093016.66437-21-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.108,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/23/24 11:30, Bernhard Beschow wrote:
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



> ---
>   hw/i2c/smbus_eeprom.c | 19 ++++++++-----------
>   1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
> index 9e62c27a1a..1d4d9704bf 100644
> --- a/hw/i2c/smbus_eeprom.c
> +++ b/hw/i2c/smbus_eeprom.c
> @@ -151,19 +151,16 @@ static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
>       dc->user_creatable = false;
>   }
>   
> -static const TypeInfo smbus_eeprom_info = {
> -    .name          = TYPE_SMBUS_EEPROM,
> -    .parent        = TYPE_SMBUS_DEVICE,
> -    .instance_size = sizeof(SMBusEEPROMDevice),
> -    .class_init    = smbus_eeprom_class_initfn,
> +static const TypeInfo types[] = {
> +    {
> +        .name          = TYPE_SMBUS_EEPROM,
> +        .parent        = TYPE_SMBUS_DEVICE,
> +        .instance_size = sizeof(SMBusEEPROMDevice),
> +        .class_init    = smbus_eeprom_class_initfn,
> +    },
>   };
>   
> -static void smbus_eeprom_register_types(void)
> -{
> -    type_register_static(&smbus_eeprom_info);
> -}
> -
> -type_init(smbus_eeprom_register_types)
> +DEFINE_TYPES(types)
>   
>   void smbus_eeprom_init_one(I2CBus *smbus, uint8_t address, uint8_t *eeprom_buf)
>   {


