Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6A0CF2566
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2024 13:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szcNj-0007CP-2U; Sat, 12 Oct 2024 09:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1szcNe-0007C8-V6; Sat, 12 Oct 2024 09:42:02 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1szcNd-0004IP-BU; Sat, 12 Oct 2024 09:42:02 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-37d4fd00574so1535122f8f.0; 
 Sat, 12 Oct 2024 06:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728740519; x=1729345319; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wsupazMnCPw+QOmcribO4MLjxraI3Fs4bmrt2mvfNqM=;
 b=PtiDXxPXAqQVCzQ84kvNcDv0fqdFR/DNH/P+dUzUR38wwb7a//+V/KftM7oH54BmnQ
 FTVhBR290R+HTgn+mql96FfrN9HzwPAgRDkl2pbzjZ2knfO/xypk6VdP3IPSyf/SpO/L
 d5SZSCQXwth2LoEWo7LM7BPunP2G4e9Vp/ENya057dqc9lY85zBh28XHRMUx0T3vTCcj
 m/uo1LdJqUmpN4MRWGRZgQe1iU935MbwmO8RB2jmJcggEpmGF6Qy+F67GsoypbjicmNL
 QkBAksBwr1512quiKRKjMHq2tluRR4Ttt8+wCiBciPjIgbSnR8ICMAk5pxif1JmBrinm
 i0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728740519; x=1729345319;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wsupazMnCPw+QOmcribO4MLjxraI3Fs4bmrt2mvfNqM=;
 b=mdYSt3yGvDsv9aNSkneh9q1keQcVLnFv4lsgSnnzrdMAP2D5S/8BrJ5vHde+pixL3q
 3Y/5cNDDvERo+/yolRlXPegNODKEK7vdYRU+RtN8RKqGwwXQf+wR2iRhYSHBYkh7OrxN
 Dz/+eM7nqiZ+wRF2RqPnZ6gDVcDHyHwnSoldrHlQGIsLBsK3AkbaKAwn89tkAETARW+U
 qp9KN38QFSlHxtUXv6q/EbavCVj0qiDmWQfAlq/8J+Cvip8mkXQ9VB+iuNb3M9dfhFte
 IrDQ90ZXPCvdW10vmhaakInktkuYzPa0CiWoPs+1i+6wT6GvQeHxprp2z3v9t3shpiTL
 7W8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/WVJhETsrwPtStss1h4p9C/YN9FJUufNBAh/OUgl7ItOVyZlv47h1cO3W9VvwkW5ZW20afK1poLU=@nongnu.org,
 AJvYcCUhR18M+07/vytJYlevjfq0LZnHv9NWbZXKiTIoQvQLiY9IUFlX1e8bC2XIK/OeVRwRuGT0JnKZ6JtFfg==@nongnu.org,
 AJvYcCXoL3bkGXpwQBeNp4YmldN4K+EJDXiN8lgdBKT93h8wLq/cfsQToe/jZA9aBSsCx8PCv3f87kmIYA==@nongnu.org
X-Gm-Message-State: AOJu0YxlZbkikTk8oH0BC5W//gO4/UniX/CZT3/Wn8ttdxYuuKYkWQP+
 InysQh72EP4oxyoSr/my3X5loFSgTA0QyshfLjXWxKsG16DEJ5yV
X-Google-Smtp-Source: AGHT+IGfLhGvjkundvEA6bk9Y6DkAO2B67WQmniqI9bzII2NmNCJq1HfZrMVWFDxGioCo9q1JH8JdA==
X-Received: by 2002:adf:e7cf:0:b0:37d:43d1:2064 with SMTP id
 ffacd0b85a97d-37d552d3843mr4445974f8f.30.1728740518457; 
 Sat, 12 Oct 2024 06:41:58 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-011-117-250.77.11.pool.telefonica.de.
 [77.11.117.250]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d4b6bd134sm6386384f8f.41.2024.10.12.06.41.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Oct 2024 06:41:58 -0700 (PDT)
Date: Sat, 12 Oct 2024 13:41:57 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org
Subject: Re: [PATCH v2 2/2] hw/ppc/e500: Reuse TYPE_GPIO_PWR
In-Reply-To: <d094728d-a7bd-4e16-b3c1-82065ca9bf08@linaro.org>
References: <20241005100228.28094-1-shentey@gmail.com>
 <20241005100228.28094-3-shentey@gmail.com>
 <d094728d-a7bd-4e16-b3c1-82065ca9bf08@linaro.org>
Message-ID: <1692441A-C91F-4A87-B8CB-82E42EE815EA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 7=2E Oktober 2024 21:13:22 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <p=
hilmd@linaro=2Eorg>:
>On 5/10/24 07:02, Bernhard Beschow wrote:
>> Taking inspiration from the ARM virt machine, port away from
>> qemu_allocate_irq() by reusing TYPE_GPIO_PWR=2E
>>=20
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>   hw/ppc/e500=2Ec  | 16 ++++------------
>>   hw/ppc/Kconfig |  1 +
>>   2 files changed, 5 insertions(+), 12 deletions(-)
>
>
>> @@ -892,13 +890,6 @@ static DeviceState *ppce500_init_mpic(PPCE500Machi=
neState *pms,
>>       return dev;
>>   }
>>   -static void ppce500_power_off(void *opaque, int line, int on)
>> -{
>> -    if (on) {
>> -        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
>> -    }
>> -}
>> -
>>   void ppce500_init(MachineState *machine)
>>   {
>>       MemoryRegion *address_space_mem =3D get_system_memory();
>> @@ -1086,7 +1077,7 @@ void ppce500_init(MachineState *machine)
>>       sysbus_create_simple("e500-spin", pmc->spin_base, NULL);
>>         if (pmc->has_mpc8xxx_gpio) {
>> -        qemu_irq poweroff_irq;
>> +        DeviceState *gpio_pwr_dev;
>
>Can we keep a reference in PPCE500MachineState?

I considered turning it into an embedded attribute, but decided against it=
, because 1/ the device isn't part of the SoC (and therefore ideally user-c=
reateable), 2/ only used by the ppce500 machine, 3/ would be inconsistent w=
ith surrounding code, and 4/ "gpio-pwr" would require exposing the struct f=
irst (ARM virt also has no embedded attribute)=2E That all seemed like a lo=
t of churn for what I want to achieve which is having the same solution for=
 the same problem across two machines=2E

There is surely a lot of room for cleaning up e500 beyond my e500 cleanup =
series, but unless there is demand for it, I'd stop there (patches welcome)=
=2E Now that this series doesn't touch ARM much it'd actually make sense to=
 merge it there=2E

>
>Otherwise,
>Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>

So, is creating an anonymous device okay for you? Does your R-b stand neve=
rtheless?

Best regards,
Bernhard

>
>>             dev =3D qdev_new("mpc8xxx_gpio");
>>           s =3D SYS_BUS_DEVICE(dev);
>> @@ -1096,8 +1087,9 @@ void ppce500_init(MachineState *machine)
>>                                       sysbus_mmio_get_region(s, 0));
>>             /* Power Off GPIO at Pin 0 */
>> -        poweroff_irq =3D qemu_allocate_irq(ppce500_power_off, NULL, 0)=
;
>> -        qdev_connect_gpio_out(dev, 0, poweroff_irq);
>> +        gpio_pwr_dev =3D sysbus_create_simple("gpio-pwr", -1, NULL);
>> +        qdev_connect_gpio_out(dev, 0, qdev_get_gpio_in_named(gpio_pwr_=
dev,
>> +                                                             "shutdown=
", 0));
>>       }

