Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC687E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 06:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIjD8-0008I1-CX; Wed, 04 Dec 2024 01:50:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tIjD2-0008H9-M1
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 01:50:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tIjCz-0008MW-1C
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 01:50:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733294999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=J1E8R3dW6tV138ZRkbVrPlUAn7vvGa4J37rC1Eiqw2c=;
 b=ClMdFs3SesxtjoUsJYrPcq+ldg3Nai2JSZod8S4uNFgm0vAkpfFNkqo3FvCKxPvcGCmsUh
 B/6+ihr9S0ZBlp5jIcodRgkCWdJCJ1zGjyxlbIGsHSc/6nYm1x0lT8L/NrwyYfuipEaCbE
 mk0Lug0LxVMPqCnKma0r2sJmth2eNac=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-M3yjpoqEPy-79y8TPPFksQ-1; Wed, 04 Dec 2024 01:49:58 -0500
X-MC-Unique: M3yjpoqEPy-79y8TPPFksQ-1
X-Mimecast-MFC-AGG-ID: M3yjpoqEPy-79y8TPPFksQ
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ffd953e192so51756921fa.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 22:49:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733294997; x=1733899797;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J1E8R3dW6tV138ZRkbVrPlUAn7vvGa4J37rC1Eiqw2c=;
 b=nPA4m//vny2DL96YdBsRc3dtclQSmWcqLw06nuw+wC1pwYrENINNQNGbvtgSblHy1I
 aZxcI4S44eIswRbnQTOnlzIt+iAP9Y7JG2qscgsY2YX+JVfl7gDjbi51TC1OaqTjfwr+
 O87kbCn2C8jgnhcYjuJe1VfXqN486rAbcxsBcM/wCk2KHv/+p1NJ2vCFY/5ASPYUFwtz
 5AnthaXkI2Kk3lLYzqRZdugO3JR97OTh3ktMA/v0M5dydgrj+6IrbTAmUGeWh/C7Rzvi
 lQwH/z8SBE46M3tEhPcCEwzobe6/tHh2JG5LctX5R69BoR+gWpVwYr5jDZqiOgX+UG8y
 o23w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrfvs8X6Zm19tNuzyAX4GQMFPS3s3mjNwr/vCwJvOHaYs6bSEhTI1c9HF4Gawus3XvCKcec6ENSEcR@nongnu.org
X-Gm-Message-State: AOJu0YwQhJAg2keIz2xSi1jtMwEkAHkAUZl+1uHopzMlNV4v0ojp/iGi
 Q8Q6VDVrUKDeK86JxPLRPmNDle8Co8JaO1rxidTTtjkjp3kN/g7NfQ3NQRkGh2Lg3rjZ0cTRCRg
 oZ77wjblm8/Vxd/IHiFyEVMPndOYDWXoDkGvTgtEm/X9szxHKYD35
X-Gm-Gg: ASbGnctFFwshk2oglH+610SA5ZtTYfyd/e9AQJ4dSFl3lQtB4CYJGSmHz9mrVVOuxuU
 ZoYvGX90OTuZ0YiKvjRNitaG5oEyC7C6selnlwCbnUU4p3W75WfolP7375uXF6tctNnFkp5k/DA
 LYBvmAeQpHuWqjsKIAPL/uHxJpTq5R8HD0N/sxZgVDKL1Uzc8kn7COIkDS4qHMCtLgKVceFoCj8
 JBrpRrYxY6GDA69BgpCi580ubPK568a0/BpiJVxLUOKGrFphK1AVOkJCKoSTH40imgT551RzF8u
 ukBVzw==
X-Received: by 2002:a05:6512:1048:b0:53e:1c7b:618e with SMTP id
 2adb3069b0e04-53e1c7b6255mr1023186e87.10.1733294996623; 
 Tue, 03 Dec 2024 22:49:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgPwxGY+1eC+/eLMmrtBR8WPWPFY5ticvC6HoCVYJqC8skKCzjLQRMa8RVyKWHIz7H+JjJZg==
X-Received: by 2002:a05:6512:1048:b0:53e:1c7b:618e with SMTP id
 2adb3069b0e04-53e1c7b6255mr1023167e87.10.1733294996241; 
 Tue, 03 Dec 2024 22:49:56 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-199.web.vodafone.de.
 [109.42.51.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa5997d5646sm697355766b.62.2024.12.03.22.49.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 22:49:55 -0800 (PST)
Message-ID: <d24c3fb5-4edd-491d-b651-a13a1f7aacec@redhat.com>
Date: Wed, 4 Dec 2024 07:49:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 v2 01/13] hw/pci: Do not declare PCIBus::flags
 mask as enum
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241126112212.64524-1-philmd@linaro.org>
 <20241126112212.64524-2-philmd@linaro.org>
 <ab884d96-6648-4888-962c-35a6b1d90857@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ab884d96-6648-4888-962c-35a6b1d90857@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 27/11/2024 10.37, Philippe Mathieu-Daudé wrote:
> On 26/11/24 12:22, Philippe Mathieu-Daudé wrote:
>> We use PCIBus::flags to mask various flags. It is not
>> an enum, and doing so confuses static analyzers. Rename
>> the enum as singular. Use a generic unsigned type for
>> the mask.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/pci/pci_bus.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
>> index 22613125462..6ecfe2e06d5 100644
>> --- a/include/hw/pci/pci_bus.h
>> +++ b/include/hw/pci/pci_bus.h
>> @@ -19,7 +19,7 @@ struct PCIBusClass {
>>       uint16_t (*numa_node)(PCIBus *bus);
>>   };
>> -enum PCIBusFlags {
>> +enum PCIBusFlag {
>>       /* This bus is the root of a PCI domain */
>>       PCI_BUS_IS_ROOT                                         = 0x0001,
>>       /* PCIe extended configuration space is accessible on this bus */
> 
> (more diff context:)
> 
>          PCI_BUS_EXTENDED_CONFIG_SPACE                           = 0x0002,
>         /* This is a CXL Type BUS */
>         PCI_BUS_CXL                                          = 0x0004,
> 
> Enum would be the [0, 1, 2] bits. Since we define bitmask and use
> bitmask arguments in the code, shouldn't we simply replace that
> enum by #define?

Agreed, this rather sounds like #defines than an enum to me, too.

  Thomas


