Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B82C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 13:33:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thqNF-0007uw-Bf; Tue, 11 Feb 2025 08:32:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1thqNA-0007uP-NL
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 08:32:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1thqN7-0007D5-Gx
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 08:32:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739280735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KYbRbDR0RIOgUtXcU0k3ebLugfQzdDeA25GqhwSOMYU=;
 b=czyCNQ/ql6cnKq2KGFt/kCyiK+igIHBAbTEnmtq2QsiHn1ddKwDbAzrUuKahD177fQfx42
 4hZ7V9h9KR9WPY8xTDi6QkLJW7xl8FFd0l3ezZJrXA7La2jV5X2TYJX4f8rtFNr6LNPOYz
 ANsjqGXdehcDkqBTrxU7LW8hViJ93c4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-LSxNv2tNM0OIdYhxDaOPuQ-1; Tue, 11 Feb 2025 08:32:13 -0500
X-MC-Unique: LSxNv2tNM0OIdYhxDaOPuQ-1
X-Mimecast-MFC-AGG-ID: LSxNv2tNM0OIdYhxDaOPuQ_1739280733
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38dd91cd38cso1666828f8f.3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 05:32:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739280732; x=1739885532;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KYbRbDR0RIOgUtXcU0k3ebLugfQzdDeA25GqhwSOMYU=;
 b=DIULGptsrJ3tO2BFuTfGplZVHgZv/Z6+PLvlzoDva62ln6daZcpZGKL1Swshf/ZH38
 NZIHhnYYG9xyoONkBPGB1hNh3Z6wy5Gt0qCB8dv8dkwMDXeOZvUF0FVoClwtowEWds0g
 T+NwNigJbSZU3SVoh6yP7cwQ1AME4trgtNdv5JZcnDK2/anE4DZgmw/TR84R7uCsjvcT
 yHhKt7ffH41HmoJypHy6Uim689XdsUQZFqzWBVrJB7lDkX+JnOt8BVEwYlnBe4VJ8r0V
 7gKrxui6PBI/DCwEcXwuAnWop3o2EGk6PnQVUfzzd0+sw8H8421xP/bM5I/ZFy2EU+4L
 ZR3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvzik/hPjZ/VqY/w7kAvS0pSBIxrLauonRwlzFvX4OoswqFCGJrDIntsHkv8xE0hdBjmGyhpXv7ty+@nongnu.org
X-Gm-Message-State: AOJu0YxFqWWg0stG4c65TRTbsbNgnsfWc+0OYA55Aj6XNTP/DjToi8iG
 19Dshwk4sJatfyojhr5tGG0AIbwbXvLTRu/g1N4jofOECvlwYXQ1/hE3WUYKkaUFZLL0Zg+jiEY
 0HtqG0zSUFpwEtCFFRj/hKUJNcSmFKvOmGSdvIL13kMaMMwprLbtG8tHworMT
X-Gm-Gg: ASbGnctBrinnCOXqq83vWBR5dQBAOnJg/76wPDJDtjYhUD1Uv+lHaJROrfM6fP/pXkx
 3YfmrFaa23XeYHcSy0dUidybCjUbfHBtrt+JXTFBRtvPbu9M511AQEiuiNF349zGdGb2OSo42O9
 U0A0WB5t0ncJD51fF0nvvcYfKqjq0LWQS4Bx34wkK8QFbqmc8OxHmwgb7AKvd7FFk6mnRygLY68
 2dqMwjf/ENFHAtWLr0o+4BBViwpC+dAT4DErUv+izTYsAQuk3MEg0JYUPmZCOdx1ZI4N/omGAFN
 HLqlLxo72GW5dgU8kKettScinPxaPA+tjak8n8UZ7fk=
X-Received: by 2002:a05:6000:1ac6:b0:38d:e572:4dc2 with SMTP id
 ffacd0b85a97d-38de5724ecamr2814772f8f.40.1739280732231; 
 Tue, 11 Feb 2025 05:32:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/cc1en2hGuZeXyeeFcRNvsaI4anu1t0umzPE8fF2N83ZB+d/Ipb0XiZpwyQlvkGnetnQhYg==
X-Received: by 2002:a05:6000:1ac6:b0:38d:e572:4dc2 with SMTP id
 ffacd0b85a97d-38de5724ecamr2814741f8f.40.1739280731802; 
 Tue, 11 Feb 2025 05:32:11 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:ecac:5b28:cd98:868a?
 ([2a01:e0a:280:24f0:ecac:5b28:cd98:868a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd07fa80csm10671284f8f.13.2025.02.11.05.32.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2025 05:32:11 -0800 (PST)
Message-ID: <b12fb545-ec6f-424b-a430-27ae7f4da836@redhat.com>
Date: Tue, 11 Feb 2025 14:32:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Add a ppc sam460ex test
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>
References: <20250203092606.491933-1-clg@redhat.com>
 <6b18058c-8c02-4171-abb0-ca7ef7d3fd4a@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <6b18058c-8c02-4171-abb0-ca7ef7d3fd4a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 2/11/25 12:37, Thomas Huth wrote:
> On 03/02/2025 10.26, Cédric Le Goater wrote:
>> The test sequence boots from kernel a sam460ex machine with a
>> virtio-net device to check PCI.
>>
>> The buildroot is built with config :
>>
>>    BR2_powerpc=y
>>    BR2_powerpc_440fp=y
>>
>> and the kernel with the '44x/canyonlands' deconfig and virtio support.
>>
>> Cc: BALATON Zoltan <balaton@eik.bme.hu>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   MAINTAINERS                           |  1 +
>>   tests/functional/meson.build          |  1 +
>>   tests/functional/test_ppc_sam460ex.py | 38 +++++++++++++++++++++++++++
>>   3 files changed, 40 insertions(+)
>>   create mode 100644 tests/functional/test_ppc_sam460ex.py
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 8d30c5bafd87..e4ab6031511b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1555,6 +1555,7 @@ F: pc-bios/canyonlands.dt[sb]
>>   F: pc-bios/u-boot-sam460ex-20100605.bin
>>   F: roms/u-boot-sam460ex
>>   F: docs/system/ppc/amigang.rst
>> +F: tests/functional/test_ppc_sam460ex.py
>>   pegasos2
>>   M: BALATON Zoltan <balaton@eik.bme.hu>
>> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
>> index 868f4a64b60b..6a5f1dc405cb 100644
>> --- a/tests/functional/meson.build
>> +++ b/tests/functional/meson.build
>> @@ -193,6 +193,7 @@ tests_ppc_system_thorough = [
>>     'ppc_40p',
>>     'ppc_amiga',
>>     'ppc_bamboo',
>> +  'ppc_sam460ex',
>>     'ppc_mac',
>>     'ppc_mpc8544ds',
>>     'ppc_tuxrun',
> 
> I'll sort that entry alphabetically into the list, and then pick this patch up for my next pull request.

Indeed. Thanks,

C.


> 
>   Thanks!
>    Thomas
> 


