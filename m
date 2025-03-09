Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFC0C282D1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 12:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trFdm-000809-Kq; Sun, 09 Mar 2025 08:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trFdU-0007sX-6c
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 08:20:07 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trFdQ-00021G-2H
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 08:20:01 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso1809195e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 05:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741522797; x=1742127597; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SXFui0VdoFr2d0dHdNdBY+8sQ9ZQjKd4FQUjY4Twe6o=;
 b=UElvwB0yimBTCv0mZxF4s+KX1pHxtrOZqRMre9G+MCbwBDzeUyDSNPaFvniboZDGcA
 5iDo/da/C7MRPGGcFFl9RjQIS/7g4TcxGORvLFRQTAb2SFb933uPcpM4TnoJNbpZ+14s
 eSDoQ/S5l6llt0uBFbCvPSdUb9R036NXoAClWsjxvtoeDUoDLcuLyE6t5gsipk9iMW93
 fmnR2TmV81YnzjWT1w5vNZiXsQh8RmblCoO7/fqKWIcLz3B9mcP+YZGLrurBQS16cN/5
 0xiqAqSJCEsJyPC420vyFuFWSUI4NxAsIr3a8GibfU7q384CQY0lVp/Pu4GVouxEwgzc
 YNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741522797; x=1742127597;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SXFui0VdoFr2d0dHdNdBY+8sQ9ZQjKd4FQUjY4Twe6o=;
 b=dTvyTU1DX53tPJ2bYdFDkMDxxUnTSzls6Dr9HGLn9I74TuXS79uhl+iC57x11xWpn4
 IYq9gA7yEYTxaJPg2po/zRXXpWQoFADexpieIus6IoZp5VR61kdx6aGOOjgcjxnZlLE7
 KYFXxq8fuJAR2erdfj5tMQ0g+y1qS9wOddkXB1+LLicWqTVYFfkwlj8CTVHGR32YHzMZ
 zCGoRcYZE/dYA35w40fHPrLn7RcrNOKJan98QJUoz/6nhbT0cQgbWP0jxG4nEFzVM7ZN
 2jG+kzSjtnZd9ePHKNr5mftdQFxpJAnTiu3aQsYDnNfwQoOfjiR+NJ4diRx2PQIPtLzJ
 dMXw==
X-Gm-Message-State: AOJu0YwSUjNmvLinZfrDCxrZN4l+G0LKc9Nxb4tUGUcoPHt0ncsFTCNp
 gX9BBQXvLCi48CbXWmCKm3TYCOvAl+XYXU5vfqqVrWhCGYjjLDPPQn+xik3VOxI=
X-Gm-Gg: ASbGncvGcMSNGBAoY4X7G7rEMY+WudWMyGZFf7oe1HDV/Ha5nR/aKdxGp9fwvdnz5vk
 SGZGXApg3QDcHGKFlwl+bun36kURk11mb9LXb9XBRGzmz34wbQDZlGLxJL5jJGLAXDZaB5Lgt91
 UWb8aPcz9k0eeVoyrII1mO2Bu89y1Qp8/f12bxdQcEsNN/bmQ6q2VJBee8b4+528jIkypyYRaer
 2hm2+UVvm+KRqJVKsJymJWpUY7RGGvKZWOTo0clhCEaNj3yyvfXUwUhNc3zDypjZ46g1+EtkrqG
 mxGq8BT6eTLQM8vLIAJ8DzXixJy+2gCi7lP7BiItSmXhdd1qPsGCt/TzqPFRwCe77Iuhm9qkW1m
 6N4szKebN4URo
X-Google-Smtp-Source: AGHT+IH918KrBlLN5eU8fMRcLMy6zFYbg2aGqUNc1BBgxpyAcSTtii9GVy+MmEqbDACdbwY6xMnUtA==
X-Received: by 2002:a5d:64c3:0:b0:391:31c8:ba58 with SMTP id
 ffacd0b85a97d-39132d16dd6mr7161785f8f.10.1741522797338; 
 Sun, 09 Mar 2025 05:19:57 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c01cd62sm11513220f8f.46.2025.03.09.05.19.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 05:19:56 -0700 (PDT)
Message-ID: <f59df0e2-d6bf-4950-aaf6-02333183501b@linaro.org>
Date: Sun, 9 Mar 2025 13:19:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/14] hw/sd/sdhci: Make quirks a class property
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Guenter Roeck <linux@roeck-us.net>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org
References: <20250308213640.13138-1-philmd@linaro.org>
 <20250308213640.13138-5-philmd@linaro.org>
 <11b37245-5dee-122b-cdfb-dfc820a38661@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <11b37245-5dee-122b-cdfb-dfc820a38661@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 9/3/25 12:43, BALATON Zoltan wrote:
> On Sat, 8 Mar 2025, Philippe Mathieu-Daudé wrote:
>> All TYPE_IMX_USDHC instances use the quirk:
>> move it to the class layer.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> include/hw/sd/sdhci.h |  3 ++-
>> hw/sd/sdhci.c         | 15 +++++++++++++--
>> 2 files changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
>> index c4b20db3877..0616ce3aa59 100644
>> --- a/include/hw/sd/sdhci.h
>> +++ b/include/hw/sd/sdhci.h
>> @@ -95,7 +95,6 @@ struct SDHCIState {
>>
>>     /* Configurable properties */
>>     bool pending_insert_quirk; /* Quirk for Raspberry Pi card insert 
>> int */
>> -    uint32_t quirks;
>>     uint8_t endianness;
>>     uint8_t sd_spec_version;
>>     uint8_t uhs_mode;
>> @@ -112,6 +111,8 @@ typedef struct SDHCIClass {
>>         PCIDeviceClass pci_parent_class;
>>         SysBusDeviceClass sbd_parent_class;
>>     };
>> +
>> +    uint32_t quirks;
>> } SDHCIClass;
>>
>> /*
>> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
>> index 4917a9b3632..2b7eb11a14a 100644
>> --- a/hw/sd/sdhci.c
>> +++ b/hw/sd/sdhci.c
>> @@ -345,6 +345,8 @@ static void sdhci_send_command(SDHCIState *s)
>>     rlen = sdbus_do_command(&s->sdbus, &request, response);
>>
>>     if (s->cmdreg & SDHC_CMD_RESPONSE) {
>> +        SDHCIClass *sc = SYSBUS_SDHCI_GET_CLASS(s);
> 
> I don't like this because it introduces a class look up which may be 
> costly in a function that could be called frequently. Maybe you could 
> just drop this patch and leave the quirk handling as it is. Changing it 
> does not seem to improve the model much.

I thought about it and was expecting a such comment.

Initializing a class field in the instance_init is an anti-pattern,
so I'll keep a cached quirks in SDHCIState.

> Regards,
> BALATON Zoltan


