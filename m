Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1FFC54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 15:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHlod-0005gg-FY; Wed, 21 May 2025 11:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uHloa-0005UV-Iw
 for qemu-devel@nongnu.org; Wed, 21 May 2025 11:57:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uHloY-0008L1-4L
 for qemu-devel@nongnu.org; Wed, 21 May 2025 11:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747843024;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8vWoerbe22bnbOhe9lt5fyTui5zdEqi1vksoDMG+GyA=;
 b=GLtEkYDMQPG7SNjRv0okvgDR2NMTyV8K82+wNSRsIOeNqnz6Fj/6eNigdSbaJTAQy4dJJj
 P9zopGPWm6QGzm6h3lC1RbpY02OBKlGQR2Y7E4D4lgOa3J7XFpt8SoDk5z5t/GoTrKHpQY
 zAnn9h61yfRAbLxnPD+ZziNkXJo8GzQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-Vq_81zsUMTeNkLgwt4mjIg-1; Wed, 21 May 2025 11:57:01 -0400
X-MC-Unique: Vq_81zsUMTeNkLgwt4mjIg-1
X-Mimecast-MFC-AGG-ID: Vq_81zsUMTeNkLgwt4mjIg_1747843018
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-440667e7f92so36412545e9.3
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 08:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747843018; x=1748447818;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8vWoerbe22bnbOhe9lt5fyTui5zdEqi1vksoDMG+GyA=;
 b=EWvf+BsWKoduj3kx5nKLNVrfPMRhcHClwPs+g8CR12oK7EuuSbEZI3ckLVJIqS9CRb
 33jK/3OFjXwT1lpHMqlmsvfE6Voo2t740YOJyURpUk5pg8qqvbRapVZiS9FNM33PPI/Q
 fv3jyAvjBVwBer5r8+q4yyTTAZixQApvBJYCBAyAtPyMGLnxRgBYOZRfQHgVixKj9CkI
 lpF8eSFFxoktIQoyQ0I9/XWKRU1UEJ5fKBRQE1j5iUKB+3SXM7bJPsEz2ThcZW0qRvDN
 4N0MvzL0edvoSrLqP4E4YCjMpRXZqu4/p9HR1eJCh/D2AEq9XnPJLmbn1gUZmK1Fw6i5
 Qf2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVz/GNO4MMm8X5X8hN2eUlJduVaQe5J1Z8jyogGbLLl/zfzMsPqkogm6taJ6ZgoCx96SVXqpmpppbLd@nongnu.org
X-Gm-Message-State: AOJu0Yz2UEn5xL1WBdlaaWdc5wrztZYXQDHWVSeXEw7fRLD9TLG+KkZT
 EOt5MrWntd7tRBLu+9TTkOtClfmZw4GXpgACPAkPa1+rkY5qq3qjEX5CCPP/oGUxq0iF8rL67lC
 hvs5vEZyXDi/2ZlaSJpHed+aE0UQVFFn7Iky1b0VBT07kZXQ41gioHAUe
X-Gm-Gg: ASbGncs1nXlD6UfHGFLIR5/06tXKLKj1RNKeN+xSf8JZDy4Bl2Q6NHaa7hCqJCMIG3l
 pDkR9KASJ3u02B0sKsxvO+sgherR9tkn7ntsWTDJJRz/cS14uSiNWfl3IZwJE71EViP4ILCCS8H
 AOEEPAN5cXhhYrhqPXd95/CvnSM6gdpyz0FVwx+VooqvfmVhB1Jyi7B6Axd+fux2U4NEb9um++P
 5sf2GpA16pAshDQs9jPvbKH6nDnS24qKCApviHIiqVGQa3vdo3Q7aPvua6C/JdhxU+Ci74hV9pB
 sEVyemnOKV8iWdxbmlr1wtU4G9hi5j/J8Oa1jWLP3KsfLCyW9gbSU50FB4Y=
X-Received: by 2002:a05:600c:3f19:b0:43c:fe85:e4ba with SMTP id
 5b1f17b1804b1-442fd63c755mr239284075e9.15.1747843018116; 
 Wed, 21 May 2025 08:56:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE990P3e4XJO4XoHRH+e6AMYD6vZtObXpd9BJ3FdEeZiy68UsveW+p7Vx69XaBw4Q2nhzK69Q==
X-Received: by 2002:a05:600c:3f19:b0:43c:fe85:e4ba with SMTP id
 5b1f17b1804b1-442fd63c755mr239283755e9.15.1747843017649; 
 Wed, 21 May 2025 08:56:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f73d4b68sm75220025e9.23.2025.05.21.08.56.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 08:56:56 -0700 (PDT)
Message-ID: <2f1d15ea-82fe-4633-9791-ef9a3721b87d@redhat.com>
Date: Wed, 21 May 2025 17:56:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/22] hw/i386/acpi-build: Move aml_pci_edsm to a generic
 place
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org
References: <20250514170431.2786231-1-eric.auger@redhat.com>
 <20250514170431.2786231-15-eric.auger@redhat.com>
 <ad7c7b84-9f12-4767-a349-df47c489c726@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <ad7c7b84-9f12-4767-a349-df47c489c726@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Gustavo,

On 5/21/25 5:26 PM, Gustavo Romero wrote:
> Hi Eric,
>
> On 5/14/25 14:01, Eric Auger wrote:
>> Move aml_pci_edsm to pcihp since we want to reuse that for
>> ARM and acpi-index support.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>   include/hw/acpi/pcihp.h |  2 ++
>>   hw/acpi/pcihp.c         | 53 +++++++++++++++++++++++++++++++++++++++++
>>   hw/i386/acpi-build.c    | 53 -----------------------------------------
>>   3 files changed, 55 insertions(+), 53 deletions(-)
>>
>> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
>> index 4d820b4baf..bc31dbff39 100644
>> --- a/include/hw/acpi/pcihp.h
>> +++ b/include/hw/acpi/pcihp.h
>> @@ -82,6 +82,8 @@ bool build_append_notification_callback(Aml
>> *parent_scope, const PCIBus *bus);
>>     void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus);
>>   +Aml *aml_pci_edsm(void);
>> +
>>   /* Called on reset */
>>   void acpi_pcihp_reset(AcpiPciHpState *s);
>>   diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
>> index d800371ddc..57fe8938b1 100644
>> --- a/hw/acpi/pcihp.c
>> +++ b/hw/acpi/pcihp.c
>> @@ -937,6 +937,59 @@ void build_append_pci_bus_devices(Aml
>> *parent_scope, PCIBus *bus)
>>       }
>>   }
>>   +Aml *aml_pci_edsm(void)
>> +{
>> +    Aml *method, *ifctx;
>> +    Aml *zero = aml_int(0);
>> +    Aml *func = aml_arg(2);
>> +    Aml *ret = aml_local(0);
>> +    Aml *aidx = aml_local(1);
>> +    Aml *params = aml_arg(4);
>> +
>> +    method = aml_method("EDSM", 5, AML_SERIALIZED);
>> +
>> +    /* get supported functions */
>> +    ifctx = aml_if(aml_equal(func, zero));
>> +    {
>> +        /* 1: have supported functions */
>> +        /* 7: support for function 7 */
>> +        const uint8_t caps = 1 | BIT(7);
>> +        build_append_pci_dsm_func0_common(ifctx, ret);
>> +        aml_append(ifctx, aml_store(aml_int(caps), aml_index(ret,
>> zero)));
>> +        aml_append(ifctx, aml_return(ret));
>> +    }
>> +    aml_append(method, ifctx);
>> +
>> +    /* handle specific functions requests */
>> +    /*
>> +     * PCI Firmware Specification 3.1
>> +     * 4.6.7. _DSM for Naming a PCI or PCI Express Device Under
>> +     *        Operating Systems
>> +     */
>> +    ifctx = aml_if(aml_equal(func, aml_int(7)));
>> +    {
>> +       Aml *pkg = aml_package(2);
>> +       aml_append(pkg, zero);
>> +       /* optional, if not impl. should return null string */
>> +       aml_append(pkg, aml_string("%s", ""));
>> +       aml_append(ifctx, aml_store(pkg, ret));
>> +
>> +       /*
>> +        * IASL is fine when initializing Package with computational
>> data,
>> +        * however it makes guest unhappy /it fails to process such
>> AML/.
>> +        * So use runtime assignment to set acpi-index after initializer
>> +        * to make OSPM happy.
>> +        */
>> +       aml_append(ifctx,
>> +           aml_store(aml_derefof(aml_index(params, aml_int(0))),
>> aidx));
>> +       aml_append(ifctx, aml_store(aidx, aml_index(ret, zero)));
>> +       aml_append(ifctx, aml_return(ret));
>> +    }
>> +    aml_append(method, ifctx);
>> +
>> +    return method;
>> +}
>> +
>>   const VMStateDescription vmstate_acpi_pcihp_pci_status = {
>>       .name = "acpi_pcihp_pci_status",
>>       .version_id = 1,
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index bcfba2ccb3..385e75d061 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -322,59 +322,6 @@ build_facs(GArray *table_data)
>>       g_array_append_vals(table_data, reserved, 40); /* Reserved */
>>   }
>>   -static Aml *aml_pci_edsm(void)
>> -{
>> -    Aml *method, *ifctx;
>> -    Aml *zero = aml_int(0);
>> -    Aml *func = aml_arg(2);
>> -    Aml *ret = aml_local(0);
>> -    Aml *aidx = aml_local(1);
>> -    Aml *params = aml_arg(4);
>> -
>> -    method = aml_method("EDSM", 5, AML_SERIALIZED);
>> -
>> -    /* get supported functions */
>> -    ifctx = aml_if(aml_equal(func, zero));
>> -    {
>> -        /* 1: have supported functions */
>> -        /* 7: support for function 7 */
>> -        const uint8_t caps = 1 | BIT(7);
>> -        build_append_pci_dsm_func0_common(ifctx, ret);
>> -        aml_append(ifctx, aml_store(aml_int(caps), aml_index(ret,
>> zero)));
>> -        aml_append(ifctx, aml_return(ret));
>> -    }
>> -    aml_append(method, ifctx);
>> -
>> -    /* handle specific functions requests */
>> -    /*
>> -     * PCI Firmware Specification 3.1
>> -     * 4.6.7. _DSM for Naming a PCI or PCI Express Device Under
>> -     *        Operating Systems
>> -     */
>> -    ifctx = aml_if(aml_equal(func, aml_int(7)));
>> -    {
>> -       Aml *pkg = aml_package(2);
>> -       aml_append(pkg, zero);
>> -       /* optional, if not impl. should return null string */
>> -       aml_append(pkg, aml_string("%s", ""));
>> -       aml_append(ifctx, aml_store(pkg, ret));
>> -
>> -       /*
>> -        * IASL is fine when initializing Package with computational
>> data,
>> -        * however it makes guest unhappy /it fails to process such
>> AML/.
>> -        * So use runtime assignment to set acpi-index after initializer
>> -        * to make OSPM happy.
>> -        */
>> -       aml_append(ifctx,
>> -           aml_store(aml_derefof(aml_index(params, aml_int(0))),
>> aidx));
>> -       aml_append(ifctx, aml_store(aidx, aml_index(ret, zero)));
>> -       aml_append(ifctx, aml_return(ret));
>> -    }
>> -    aml_append(method, ifctx);
>> -
>> -    return method;
>> -}
>> -
>>   /*
>>    * build_prt - Define interrupt routing rules
>>    *
>
> EDSM is not called from anywhere. _DSM method actually calls the PDSM,
> already defined
> in pcihp.c and generated by aml_pci_pdsm(). build_acpi_pci_hotplug(),
> which calls
> aml_pci_pdsm(), properly creates the PDSM method. Then in
> build_append_pcihp_slots()
> the a _DSM is defined per slot and inside it there is a call to PDSM,
> so I understand
> we should actually stick to the PDSM in pcihp.c instead of EDSM.

I see build_append_pci_bus_devices -> aml_pci_static_endpoint_dsm
adds a _DSM method which eventually calls EDSM.

aml_pci_device_dsm builds another _DSM implementation which calls PDSM.

As we use build_append_pci_bus_devices and we are likely to have a _DSM
implementation that calls EDSM method, I think we shall have it in the
aml. What do I miss?

Thank you for the comprehensive review!

Cheers

Eric
>
> EDSM, being used in i386 code, feels a outdated PDSM, so maybe PDSM
> should be used there,
> although a different story or a clean up for later. I'm not sure what
> "static endpoint"
> means in the context of EDSM.
>
> Hence this patch can be dropped in my understanding and:
>
> aml_append(pci0_scope, aml_pci_edsm()) in 15/22 too, without any
> prejudice to the
> hotplugging and unplugging in this series.
>
>
> Cheers,
> Gustavo
>


