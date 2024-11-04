Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40402CFB422
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 08:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7stC-0003HT-Ll; Mon, 04 Nov 2024 03:56:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t7stB-0003HB-IH
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 03:56:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t7stA-00014B-0U
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 03:56:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730710603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TIE42L1Bz6CtmU2TKOdmKgHVoTygAA+/2GH8Ip8K5B4=;
 b=LqdSTzMoWxqE0MtgZaqBDehI55gCtakAHSkWx6kTigoZ1Us/KMb9lFupIDUwoQ3j3s61NG
 8h2Pf0dAjxiYGDOJUPuTtyMsD8wQ+1lfsKk10LuH4CM3I1USoE60DTUyprMVTqC63XFTUH
 ygycrl9JETX2Sq9mSIXYPYNVyqQ5p64=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-nZ7XCbhFOzyFspaGTgZk_w-1; Mon, 04 Nov 2024 03:56:41 -0500
X-MC-Unique: nZ7XCbhFOzyFspaGTgZk_w-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7180ab6e01dso3133479a34.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 00:56:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730710600; x=1731315400;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TIE42L1Bz6CtmU2TKOdmKgHVoTygAA+/2GH8Ip8K5B4=;
 b=uJ3vdIoaQWwQJCUeoTZRUkSnbwJCzrlC9TvciE6pvS6G+RS3qH9d/AJPj1A5i61S3F
 +OiGsoZLhRccwLhCX+0tff4PY45prKhCaMlXPAv6cLdPXBWkbIQvgE/zxX4RmqFSkiLu
 l9gH33QoiAMTj6rSggMCWyhzrt1YCscFYzIUVnd2DJXq/Ji+jU+hBqk7XS+lyoI4dLxg
 RMez30bfHbmn9iOHNRMQbLKB1YBkzIeqSP/v3CQXz3tACGy9AzkGs6up1rfK51FEYVmV
 NDtHfQYSUz+SFSyp/e9r6n1f7VnF2atPYnQaw27DUBnBd2Rc/6hTYvQhNIN9//tRIzmc
 Mmzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5fSVCwcUE+GnTIpPb84CruTppA4tVN5o/Ya5ho9f0SxjKetcVE76D8iNJvnSMq1P5p9MqCgX7aJ9c@nongnu.org
X-Gm-Message-State: AOJu0YyGoHR5vREkkpTAWf/vosbghI+VSwzu0whEl2sbADqwRqX56lWv
 vg1PdhcpTGNxL7VLy8jPOem6NDlV8eRHRCKsx0Lj4lZ1PR+WEwod6p0iqCsFLLJiELK3CHhe7T5
 HjWGebFhkfHEA4Qbnh9OmcyTxOPUbNf+I6EQ9yHY87ya+bXGBWX9E
X-Received: by 2002:a05:6808:130a:b0:3e5:d591:c9a9 with SMTP id
 5614622812f47-3e758c3d1b5mr7946210b6e.26.1730710600379; 
 Mon, 04 Nov 2024 00:56:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGS7ujakYW2A1pSNTgj2sFBmGr/9gpTi4h2HS9yMaIundUjXr+nRVJRLUw02cigUNON1zrKHw==
X-Received: by 2002:a05:6808:130a:b0:3e5:d591:c9a9 with SMTP id
 5614622812f47-3e758c3d1b5mr7946197b6e.26.1730710600045; 
 Mon, 04 Nov 2024 00:56:40 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:ecac:5b28:cd98:868a?
 ([2a01:e0a:280:24f0:ecac:5b28:cd98:868a])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3e6611c4a0fsm1956034b6e.34.2024.11.04.00.56.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 00:56:38 -0800 (PST)
Message-ID: <32d8dfe1-b057-4a41-97ea-31e79ae7d750@redhat.com>
Date: Mon, 4 Nov 2024 09:56:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] aspeed: Don't set always boot properties of the emmc
 device
To: =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>
References: <20241102143943.1929177-1-clg@redhat.com>
 <2c4972ed05dd3764301d5c6dead79f0528dee9e5.camel@pengutronix.de>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <2c4972ed05dd3764301d5c6dead79f0528dee9e5.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 11/4/24 09:50, Jan Lübbe wrote:
> On Sat, 2024-11-02 at 15:39 +0100, Cédric Le Goater wrote:
>> Commit e554e45b4478 ("aspeed: Tune eMMC device properties to reflect
>> HW strapping") added support to boot from an eMMC device by setting
>> the boot properties of the eMMC device. This change made the
>> assumption that the device always has boot areas.
>>
>> However, if the machine boots from the flash device (or -kernel) and
>> uses an eMMC device without boot areas, support would be broken. This
>> impacts the ast2600-evb machine which can choose to boot from flash or
>> eMMC using the "boot-emmc" machine option.
>>
>> To provide some flexibility for Aspeed machine users to use different
>> flavors of eMMC devices (with or without boot areas), do not set the
>> eMMC device boot properties when the machine is not configured to boot
>> from eMMC. However, this approach makes another assumption about eMMC
>> devices, namely that eMMC devices from which the machine does not boot
>> do not have boot areas.
>>
>> A preferable alternative would be to add support for user creatable
>> eMMC devices and define the device boot properties on the QEMU command
>> line :
>>
>>    -blockdev node-name=emmc0,driver=file,filename=mmc-ast2600-evb.raw \
>>    -device emmc,bus=sdhci-bus.2,drive=emmc0,boot-partition-size=1048576,boot-config=8
>>
>> This is a global change requiring more thinking. Nevertheless, in the
>> case of the ast2600-evb machine booting from an eMMC device and when
>> default devices are created, the proposed change still makes sense
>> since the device is required to have boot areas.
>>
>> Cc: Jan Luebbe <jlu@pengutronix.de>
>> Fixes: e554e45b4478 ("aspeed: Tune eMMC device properties to reflect
>> HW strapping")
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> Tested-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   hw/arm/aspeed.c | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>> index e161e6b1c582..ac6d8dde71b3 100644
>> --- a/hw/arm/aspeed.c
>> +++ b/hw/arm/aspeed.c
>> @@ -338,7 +338,18 @@ static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo, bool emmc,
>>               return;
>>           }
>>           card = qdev_new(emmc ? TYPE_EMMC : TYPE_SD_CARD);
>> -        if (emmc) {
>> +
>> +        /*
>> +         * Force the boot properties of the eMMC device only when the
>> +         * machine is strapped to boot from eMMC. Without these
>> +         * settings, the machine would not boot.
>> +         *
>> +         * This also allows the machine to use an eMMC device without
>> +         * boot areas when booting from the flash device (or -kernel)
>> +         * Ideally, the device and its properties should be defined on
>> +         * the command line.
>> +         */
>> +        if (emmc && boot_emmc) {
>>               qdev_prop_set_uint64(card, "boot-partition-size", 1 * MiB);
>>               qdev_prop_set_uint8(card, "boot-config",
>>                                   boot_emmc ? 0x1 << 3 : 0x0);
> 
> With the change proposed by Guenter, this looks good to me.

yes. Could you please review v2 them ?

Thanks,

C.


