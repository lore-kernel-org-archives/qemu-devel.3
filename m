Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BFEC77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 15:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU616-0003a4-8M; Tue, 24 Jun 2025 11:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uU614-0003Zl-3I
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 11:56:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uU612-00021Y-Jp
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 11:56:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750780614;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/OSL/LcuHhu0TYe397VwHKcVqyQgV01Edt6gbFWcJXo=;
 b=AHzZCCvDW0iuq3/dUrQG8zvb3E/7NYeraM7p/NRxHXEYqnOsi5CgyjdHB5z1ZjYbn+EGO0
 SpBxGjYQnsLQUQ1fZIlvmrYhZPbgY3M5CoK2ZhdVPIFvdJB31ImIq/5SA1zewMTonuKS+U
 XiShb5P6waIoEQDitEvHmlxBzm8v7Go=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-UqIacU-qMH6Bfr_bSUyCsA-1; Tue, 24 Jun 2025 11:56:53 -0400
X-MC-Unique: UqIacU-qMH6Bfr_bSUyCsA-1
X-Mimecast-MFC-AGG-ID: UqIacU-qMH6Bfr_bSUyCsA_1750780612
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4535ee06160so39072115e9.3
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 08:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750780612; x=1751385412;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/OSL/LcuHhu0TYe397VwHKcVqyQgV01Edt6gbFWcJXo=;
 b=I++JnjVi2bbt3oTYHCyzhZVyOQvkiGHFv1zdB8fPKwCg65eFMh/bZFZogjkGZ9jeZd
 3bNse80UWcMBXTZRoMsrVudFJHZ5/6BwlHMuSCEd718G2jcVXC4YbwZh5dzuNi2f3bKx
 UhZjUt3D2E1bKK1BHg0i0Q02VIVeL85BBhY4inIshlHJpM9Inpat0bbRvcHRq5s6W5EA
 QnQskvmDTmx2CW4QRwkLMue54FgSnbSKCxQSO56EGd6hGqu8UB/Xl2aTT29vguX8Zr95
 5vJMQmO5qTauLidJ1IEiE1+NGhBETTxgd22MlgNlKND2+JdWlJCPPRMjBVn5bWuzQCu0
 54OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRokik3D19tj92iGAT2r8I6E4NLWr/Rt0GI9pdAQqnw0TkhFYVGPC9mnA1J6W2fopBiJEh4ek6v8kT@nongnu.org
X-Gm-Message-State: AOJu0YxJudpLov+2bsYVYMGIbaGkE3inJTaPL5iJiQPriXuoNzumjQcI
 FPnVKiyS07u8YXoFJJoTGnjcCfd9twZn/1Gf0aTmobwJjENFWQPjw6blY41h0ofUUw5i8YjOUEh
 UWLpdiZtBWity6/fXTYbKLEj6xuZrslBUTf0QHt0ssNM0kOUDO70a8Ob6
X-Gm-Gg: ASbGncsfIB0W1vnduO9KEYacwgzZbtMwt5jRLgPuaPj1JhDyc3zEAYYSD6CkOyaMvfg
 eJzimBxJdE7PVcUHRhfaNc2pJf3IvfR8o6WcQ7r0IWvvpAMTuwfwJVzBna7MtRmaOSpw5QWlXjI
 0gKxyZAaVt7QJCjSFVF1Qw0XFMVHdiAB9RD+Puh5wvdsL4p5Gwv4JhSAJ0D1+yzl0LmKi4z8Nfr
 ORFFGK9hxZq3Sva+ILqRet/CSIayMZR2nAbdu8ZkBCn4LLtOa1VVYwb3KMLHvhnd1Hju/4gnAq0
 LsCS8gaYVTj/+AUEghZOttoVWycQG5UuXSOYBg9cuxpowYr0Y/AFIhuXWAes7fBi9etZ7A==
X-Received: by 2002:a05:600c:a07:b0:450:d3c6:84d8 with SMTP id
 5b1f17b1804b1-453659caaddmr176392245e9.14.1750780611622; 
 Tue, 24 Jun 2025 08:56:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFT2wuQV+xY6X39q7WR56O8607PSHeG1qAceZ7tZtx5WiGejgpfdZYQD3de4cNPTQQubV/NOg==
X-Received: by 2002:a05:600c:a07:b0:450:d3c6:84d8 with SMTP id
 5b1f17b1804b1-453659caaddmr176392065e9.14.1750780611217; 
 Tue, 24 Jun 2025 08:56:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535ead2339sm183442545e9.28.2025.06.24.08.56.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 08:56:50 -0700 (PDT)
Message-ID: <8b09d9bf-a52e-4680-aeb5-71b6d6cb9925@redhat.com>
Date: Tue, 24 Jun 2025 17:56:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/29] hw/arm/virt: Pass the bus on the ged creation
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, imammedo@redhat.com, gustavo.romero@linaro.org,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com,
 pbonzini@redhat.com, philmd@linaro.org, alex.bennee@linaro.org
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-20-eric.auger@redhat.com>
 <20250620103856.00006903@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250620103856.00006903@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Jonathan,

On 6/20/25 11:38 AM, Jonathan Cameron wrote:
> On Mon, 16 Jun 2025 11:46:48 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
>
>> The bus will be needed on ged realize for acpi pci hp setup.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> I guess doing this in separate patches for previous and this one
> maybe makes it easier to backport the previous if someone just wants
> to enable this on a different arch.  Otherwise I'd have smashed them
> together.

for me it is also a matter of maintainership/reviewer role separataion,
virt and ged being maintained/reviewed by different people. So if you
don't mind, I will keep it separate all the more so I collected R-b's on
each ;-)

Eric
>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> ---
>>  hw/arm/virt.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 08bd808499..2f34877716 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -696,6 +696,7 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
>>  
>>      dev = qdev_new(TYPE_ACPI_GED);
>>      qdev_prop_set_uint32(dev, "ged-event", event);
>> +    object_property_set_link(OBJECT(dev), "bus", OBJECT(vms->bus), &error_abort);
>>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>>  
>>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_ACPI_GED].base);


