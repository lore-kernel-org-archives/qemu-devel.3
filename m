Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED77CCF9E8
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 15:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stUAO-0000CF-8x; Wed, 25 Sep 2024 11:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1stUAC-0007qI-7e
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:42:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1stUA8-0004uw-RZ
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727278964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ksfjy0IKKVJs0VlxkqANCiObQCnU5t3cSJlWp8f/ZEs=;
 b=hR6tdRUI2Z+v1UkA06c8xMHGqeh6RbL7cwIUHDnNZ6kej6p+1HO4oBIHCaqGZIOx+XoJS3
 8YEbPbjnHKSVcGMK896dlLZ4wQduv6xTnU4WC1vV2Bm3P+R9mqg/fgTHeOqjiNcZU2QAeH
 yDJzzl+fCj+ObyShxXtQQ37tfAkA97g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-RWOfNBKxPQSYIyhXZlxLZw-1; Wed, 25 Sep 2024 11:42:42 -0400
X-MC-Unique: RWOfNBKxPQSYIyhXZlxLZw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-374beb23f35so2793535f8f.0
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 08:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727278961; x=1727883761;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ksfjy0IKKVJs0VlxkqANCiObQCnU5t3cSJlWp8f/ZEs=;
 b=hATGEQz/J1raAM7jNWcy8cyRJWom/MYXwK7MzR4mYjKWWG2ZSLCkNY3MeCiy6mVTjE
 jgRPeY5zf2mYJVKdpHoXQcc7UK6lBC3hCMk7EKUGxOade9NExIDINaq2beSbDNYitGvR
 xv0Ax+eJnfQGMeZH/W6ji85w4htzMC8MkkBjyMIQj5K8KIw14R2vfDEfhmzEh4chnmWX
 Dnn99q6JhfGQ7J4hR5jpv3cfGicRiSNhL91aj6ZQUsowxBe09xDW5gklTC89CyuiV+9f
 Fr/Sf3rHM01b/v2DXlH95wMmKDCVve0l/dpoqLVrVR03myv96wrTLhukilwuW9B2YqIU
 5YQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWU2N+dh4JmaN/CahL8Ua/GFnk9NcdG1eyBl68lVgf4dJxEn7dbqe8KRqLw6C71giaUHIxieUFOu9Ha@nongnu.org
X-Gm-Message-State: AOJu0YxCAQe5kpOoZAbNgHfPBGWSP3m+OFDSwUhccetdIxyeTiWZr58Y
 oIap5eEmYkCAfHgOHqLKp9iencg26YvcuFL17qTzJjDX+zduoyblmhfExZVudMfHk/wILMtXSkL
 4TuEo8vpdUyUPNJ2EUGCxPcpx17TmekeodefMHw5R/iDjf/CnNIG/
X-Received: by 2002:adf:eac9:0:b0:37c:cd91:c455 with SMTP id
 ffacd0b85a97d-37ccd91c6cbmr134468f8f.53.1727278961714; 
 Wed, 25 Sep 2024 08:42:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqld06Hp/gyRMQV3HGGqpCDfhNv5pfDgCFSVlDfN/JFCkgxVM4mqa/PzYTOPiiHVy0+5CxHQ==
X-Received: by 2002:adf:eac9:0:b0:37c:cd91:c455 with SMTP id
 ffacd0b85a97d-37ccd91c6cbmr134459f8f.53.1727278961363; 
 Wed, 25 Sep 2024 08:42:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cbc2c1ef1sm4387346f8f.35.2024.09.25.08.42.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2024 08:42:40 -0700 (PDT)
Message-ID: <e5b77d32-555b-40b8-94cf-95859415df79@redhat.com>
Date: Wed, 25 Sep 2024 17:42:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/23] hw/rtc/ds1338: Prefer DEFINE_TYPES() macro
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
 <20240923093016.66437-22-shentey@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240923093016.66437-22-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Sob is missing.


Thanks,

C.

On 9/23/24 11:30, Bernhard Beschow wrote:
> ---
>   hw/rtc/ds1338.c | 20 ++++++++------------
>   1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/rtc/ds1338.c b/hw/rtc/ds1338.c
> index a5fe221418..6de13caf99 100644
> --- a/hw/rtc/ds1338.c
> +++ b/hw/rtc/ds1338.c
> @@ -14,7 +14,6 @@
>   #include "hw/i2c/i2c.h"
>   #include "migration/vmstate.h"
>   #include "qemu/bcd.h"
> -#include "qemu/module.h"
>   #include "qom/object.h"
>   #include "sysemu/rtc.h"
>   
> @@ -227,16 +226,13 @@ static void ds1338_class_init(ObjectClass *klass, void *data)
>       dc->vmsd = &vmstate_ds1338;
>   }
>   
> -static const TypeInfo ds1338_info = {
> -    .name          = TYPE_DS1338,
> -    .parent        = TYPE_I2C_SLAVE,
> -    .instance_size = sizeof(DS1338State),
> -    .class_init    = ds1338_class_init,
> +static const TypeInfo types[] = {
> +    {
> +        .name          = TYPE_DS1338,
> +        .parent        = TYPE_I2C_SLAVE,
> +        .instance_size = sizeof(DS1338State),
> +        .class_init    = ds1338_class_init,
> +    },
>   };
>   
> -static void ds1338_register_types(void)
> -{
> -    type_register_static(&ds1338_info);
> -}
> -
> -type_init(ds1338_register_types)
> +DEFINE_TYPES(types)


