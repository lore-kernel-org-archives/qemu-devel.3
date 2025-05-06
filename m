Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5659C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 08:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCDyX-0006SX-67; Tue, 06 May 2025 04:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uCDyV-0006SF-IE
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:48:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uCDyS-0006kp-4F
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746521302;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QVxZVJ5LX1akRCCymi/wJGGYuvzNmuWxYIFERkzuVV4=;
 b=g/65/WCa0ip4lhB7tT/Yu9FJglwB4rkG0Umskum7fKcQgGDUNA4Ts36wltrfkE2QGUw09x
 y/8drqoNidX2pFFc8MtrqNjX38UMRzdIXCPWqUQBBZm7xfMx2tSYtguQeOfXb1QJzqXDRu
 4zrd4BCp+eJLNMephfbVn6QpeFAyybw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-LnvWI77zNX6SzCTqF38b1w-1; Tue, 06 May 2025 04:48:21 -0400
X-MC-Unique: LnvWI77zNX6SzCTqF38b1w-1
X-Mimecast-MFC-AGG-ID: LnvWI77zNX6SzCTqF38b1w_1746521300
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-acb61452b27so591775866b.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 01:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746521300; x=1747126100;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QVxZVJ5LX1akRCCymi/wJGGYuvzNmuWxYIFERkzuVV4=;
 b=HOnzTHGniBrKJqAKKjeRnX9uN+Nq67Izgpad3lpjfn8zQNsmH/5QJ4c2LM9iW5bXKC
 h2Kz7V0LNI1GaymuGOWjf0TqPNbT8FwND9sQspNq7brXlzxeBYj//yLYu7rjYgERF+Yu
 NU7DKCh4WzsO4Tmf+BYbfUE9oGfSRm+lX37moiNFuQtZ1XG7Edq1vKluCKDW5pdiUPTp
 bxqT+IuyqyChqO3QYsLbDjOibt/kCb371lnrgzU6ifYG5S3lr1GcXF3lm8qnZYRmO7QD
 /CcSKQkesSvP38G8RcT3y40/n7YqWLGSVmEwhn28+BqtmnvbcXO+dSApdoWClqEJrYBm
 KKmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrXPG7zXALi14UgGgsDpwKd5XcJpVdFp+RB/UH294Wge5uHF4eT/ZMVCZCBtF306Ggo+NHz5y5D4U7@nongnu.org
X-Gm-Message-State: AOJu0Yzf5T8BNz8UN2/TGpHFkTrxSEqseSUBsi6+3sgkD7czJ0+DD7zR
 MNVZe8+3gHh9Po7hejpG2+qvYQvLovo6c0xyvXGnBVuj+9qHTVGPHEZi2HQh2t8qi+4V5bXHmOj
 gRojP9/W7ULFf8SeJ7Xcp/QGJS34FyzekByrFKB5tm2nJyy/6mx72BCknbvAG
X-Gm-Gg: ASbGncvKPbw9h15FkCYIsQLHfOg29tMUNnnRs/Gz1uB9oUMDnG2t1PFx1kksKfxAQKp
 UoAmVLZqb+H4N0Soy3ELtvZfATh1oghQHZb1J7qf6wK6/Fyn/DC0WI8BNjQTEQVcptQfnvpVrtw
 8wz5SmAaiJk2ZnkKmP6RhvZvNVc3lLdrhIBS1ThE7RXGOdgYUUGiECiZJUE2kaN064+4jvBKjRw
 J5HzGEZPYwADF8MzkFa5HngP9Y1mthy+VuKEXZKV1DVXRtUzQzfmmbYRpbUt/amspWfQNFqX6dD
 +fOgpXeSrtTUZaCGqX8uHYeoX18DdvPjp44QN0obhAvXiM4zEWJ18B69USY=
X-Received: by 2002:a17:907:c388:b0:acb:1078:9f79 with SMTP id
 a640c23a62f3a-ad1d4536f53mr204630966b.18.1746521299655; 
 Tue, 06 May 2025 01:48:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUCuCYwIYFXGMVcIX1lmUlOTr9QKbHBwebPn+6QVrHnjO0JcRtBn7jgwH/v3GICAIzS7Rj3Q==
X-Received: by 2002:a05:600c:821b:b0:43c:e70d:4504 with SMTP id
 5b1f17b1804b1-441d0fd2cf7mr16799845e9.19.1746520986293; 
 Tue, 06 May 2025 01:43:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2af32a0sm209759555e9.23.2025.05.06.01.42.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 01:42:51 -0700 (PDT)
Message-ID: <d4cb6d94-fa0e-4905-b1fd-3a0e5c62f44d@redhat.com>
Date: Tue, 6 May 2025 10:42:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 06/24] hw/acpi: Rename and move build_x86_acpi_pci_hotplug
 to pcihp
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com
References: <20250428102628.378046-1-eric.auger@redhat.com>
 <20250428102628.378046-7-eric.auger@redhat.com>
 <ee369c86-3bb5-45d6-a6ca-b1d1573cb115@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <ee369c86-3bb5-45d6-a6ca-b1d1573cb115@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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



On 5/6/25 2:12 AM, Gustavo Romero wrote:
> Hi Eric,
>
> On 4/28/25 07:25, Eric Auger wrote:
>> We plan to reuse build_x86_acpi_pci_hotplug() implementation
>> for ARM so let's move the code to generic pcihp.
>>
>> Associated static aml_pci_pdsm() helper is also moved along.
>> build_x86_acpi_pci_hotplug is renamed into build_acpi_pci_hotplug().
>>
>> No code change intended.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>   hw/i386/acpi-build.h    |   4 -
>>   include/hw/acpi/pcihp.h |   6 ++
>>   hw/acpi/pcihp.c         | 174 +++++++++++++++++++++++++++++++++++++++-
>>   hw/i386/acpi-build.c    | 150 +---------------------------------
>>   4 files changed, 181 insertions(+), 153 deletions(-)
>>
>> diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
>> index 0dce155c8c..8ba3c33e48 100644
>> --- a/hw/i386/acpi-build.h
>> +++ b/hw/i386/acpi-build.h
>> @@ -5,10 +5,6 @@
>>     extern const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio;
>>   -/* PCI Hot-plug registers bases. See
>> docs/spec/acpi_pci_hotplug.txt */
>> -#define ACPI_PCIHP_SEJ_BASE 0x8
>> -#define ACPI_PCIHP_BNMR_BASE 0x10
>> -
>>   void acpi_setup(void);
>>   Object *acpi_get_i386_pci_host(void);
>>   diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
>> index ac21a95913..2da0bc45c9 100644
>> --- a/include/hw/acpi/pcihp.h
>> +++ b/include/hw/acpi/pcihp.h
>> @@ -33,6 +33,10 @@
>>   #define ACPI_PCIHP_IO_BASE_PROP "acpi-pcihp-io-base"
>>   #define ACPI_PCIHP_IO_LEN_PROP "acpi-pcihp-io-len"
>>   +/* PCI Hot-plug registers bases. See
>> docs/spec/acpi_pci_hotplug.txt */
>
> This reference needs to be updated to point to acpi_pci_hotplug.rst.
fixed here and above in the file

Thanks!

Eric
>
> Otherwise,
>
> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
>
>
> Cheers,
> Gustavo
>
>> +#define ACPI_PCIHP_SEJ_BASE 0x8
>> +#define ACPI_PCIHP_BNMR_BASE 0x10
>> +
>>   typedef struct AcpiPciHpPciStatus {
>>       uint32_t up;
>>       uint32_t down;
>> @@ -69,6 +73,8 @@ void
>> acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>>                                            AcpiPciHpState *s,
>> DeviceState *dev,
>>                                            Error **errp);
>>   +void build_acpi_pci_hotplug(Aml *table, uint64_t pcihp_addr);
>> +
>>   /* Called on reset */
>>   void acpi_pcihp_reset(AcpiPciHpState *s);
>>   diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
>> index 5f79c9016b..35d8c0bfd2 100644
>> --- a/hw/acpi/pcihp.c
>> +++ b/hw/acpi/pcihp.c
>> @@ -26,7 +26,7 @@
>>     #include "qemu/osdep.h"
>>   #include "hw/acpi/pcihp.h"
>> -
>> +#include "hw/acpi/aml-build.h"
>>   #include "hw/pci-host/i440fx.h"
>>   #include "hw/pci/pci.h"
>>   #include "hw/pci/pci_bridge.h"
>> @@ -513,6 +513,178 @@ void acpi_pcihp_init(Object *owner,
>> AcpiPciHpState *s, PCIBus *root_bus,
>>                                      OBJ_PROP_FLAG_READ);
>>   }
>>   +static void build_append_pci_dsm_func0_common(Aml *ctx, Aml *retvar)
>> +{
>> +    Aml *UUID, *ifctx1;
>> +    uint8_t byte_list[1] = { 0 }; /* nothing supported yet */
>> +
>> +    aml_append(ctx, aml_store(aml_buffer(1, byte_list), retvar));
>> +    /*
>> +     * PCI Firmware Specification 3.1
>> +     * 4.6.  _DSM Definitions for PCI
>> +     */
>> +    UUID = aml_touuid("E5C937D0-3553-4D7A-9117-EA4D19C3434D");
>> +    ifctx1 = aml_if(aml_lnot(aml_equal(aml_arg(0), UUID)));
>> +    {
>> +        /* call is for unsupported UUID, bail out */
>> +        aml_append(ifctx1, aml_return(retvar));
>> +    }
>> +    aml_append(ctx, ifctx1);
>> +
>> +    ifctx1 = aml_if(aml_lless(aml_arg(1), aml_int(2)));
>> +    {
>> +        /* call is for unsupported REV, bail out */
>> +        aml_append(ifctx1, aml_return(retvar));
>> +    }
>> +    aml_append(ctx, ifctx1);
>> +}
>> +
>> +static Aml *aml_pci_pdsm(void)
>> +{
>> +    Aml *method, *ifctx, *ifctx1;
>> +    Aml *ret = aml_local(0);
>> +    Aml *caps = aml_local(1);
>> +    Aml *acpi_index = aml_local(2);
>> +    Aml *zero = aml_int(0);
>> +    Aml *one = aml_int(1);
>> +    Aml *not_supp = aml_int(0xFFFFFFFF);
>> +    Aml *func = aml_arg(2);
>> +    Aml *params = aml_arg(4);
>> +    Aml *bnum = aml_derefof(aml_index(params, aml_int(0)));
>> +    Aml *sunum = aml_derefof(aml_index(params, aml_int(1)));
>> +
>> +    method = aml_method("PDSM", 5, AML_SERIALIZED);
>> +
>> +    /* get supported functions */
>> +    ifctx = aml_if(aml_equal(func, zero));
>> +    {
>> +        build_append_pci_dsm_func0_common(ifctx, ret);
>> +
>> +        aml_append(ifctx, aml_store(zero, caps));
>> +        aml_append(ifctx,
>> +            aml_store(aml_call2("AIDX", bnum, sunum), acpi_index));
>> +        /*
>> +         * advertise function 7 if device has acpi-index
>> +         * acpi_index values:
>> +         *            0: not present (default value)
>> +         *     FFFFFFFF: not supported (old QEMU without PIDX reg)
>> +         *        other: device's acpi-index
>> +         */
>> +        ifctx1 = aml_if(aml_lnot(
>> +                     aml_or(aml_equal(acpi_index, zero),
>> +                            aml_equal(acpi_index, not_supp), NULL)
>> +                 ));
>> +        {
>> +            /* have supported functions */
>> +            aml_append(ifctx1, aml_or(caps, one, caps));
>> +            /* support for function 7 */
>> +            aml_append(ifctx1,
>> +                aml_or(caps, aml_shiftleft(one, aml_int(7)), caps));
>> +        }
>> +        aml_append(ifctx, ifctx1);
>> +
>> +        aml_append(ifctx, aml_store(caps, aml_index(ret, zero)));
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
>> +
>> +       aml_append(ifctx, aml_store(aml_call2("AIDX", bnum, sunum),
>> acpi_index));
>> +       aml_append(ifctx, aml_store(pkg, ret));
>> +       /*
>> +        * Windows calls func=7 without checking if it's available,
>> +        * as workaround Microsoft has suggested to return invalid
>> for func7
>> +        * Package, so return 2 elements package but only initialize
>> elements
>> +        * when acpi_index is supported and leave them uninitialized,
>> which
>> +        * leads elements to being Uninitialized ObjectType and
>> should trip
>> +        * Windows into discarding result as an unexpected and
>> prevent setting
>> +        * bogus 'PCI Label' on the device.
>> +        */
>> +       ifctx1 = aml_if(aml_lnot(aml_lor(
>> +                    aml_equal(acpi_index, zero),
>> aml_equal(acpi_index, not_supp)
>> +                )));
>> +       {
>> +           aml_append(ifctx1, aml_store(acpi_index, aml_index(ret,
>> zero)));
>> +           /*
>> +            * optional, if not impl. should return null string
>> +            */
>> +           aml_append(ifctx1, aml_store(aml_string("%s", ""),
>> +                                        aml_index(ret, one)));
>> +       }
>> +       aml_append(ifctx, ifctx1);
>> +
>> +       aml_append(ifctx, aml_return(ret));
>> +    }
>> +
>> +    aml_append(method, ifctx);
>> +    return method;
>> +}
>> +
>> +void build_acpi_pci_hotplug(Aml *table, uint64_t pcihp_addr)
>> +{
>> +    Aml *scope;
>> +    Aml *field;
>> +    Aml *method;
>> +
>> +    scope =  aml_scope("_SB.PCI0");
>> +
>> +    aml_append(scope,
>> +        aml_operation_region("PCST", AML_SYSTEM_IO,
>> aml_int(pcihp_addr), 0x08));
>> +    field = aml_field("PCST", AML_DWORD_ACC, AML_NOLOCK,
>> AML_WRITE_AS_ZEROS);
>> +    aml_append(field, aml_named_field("PCIU", 32));
>> +    aml_append(field, aml_named_field("PCID", 32));
>> +    aml_append(scope, field);
>> +
>> +    aml_append(scope,
>> +        aml_operation_region("SEJ", AML_SYSTEM_IO,
>> +                             aml_int(pcihp_addr +
>> ACPI_PCIHP_SEJ_BASE), 0x04));
>> +    field = aml_field("SEJ", AML_DWORD_ACC, AML_NOLOCK,
>> AML_WRITE_AS_ZEROS);
>> +    aml_append(field, aml_named_field("B0EJ", 32));
>> +    aml_append(scope, field);
>> +
>> +    aml_append(scope,
>> +        aml_operation_region("BNMR", AML_SYSTEM_IO,
>> +                             aml_int(pcihp_addr +
>> ACPI_PCIHP_BNMR_BASE), 0x08));
>> +    field = aml_field("BNMR", AML_DWORD_ACC, AML_NOLOCK,
>> AML_WRITE_AS_ZEROS);
>> +    aml_append(field, aml_named_field("BNUM", 32));
>> +    aml_append(field, aml_named_field("PIDX", 32));
>> +    aml_append(scope, field);
>> +
>> +    aml_append(scope, aml_mutex("BLCK", 0));
>> +
>> +        method = aml_method("PCEJ", 2, AML_NOTSERIALIZED);
>> +    aml_append(method, aml_acquire(aml_name("BLCK"), 0xFFFF));
>> +    aml_append(method, aml_store(aml_arg(0), aml_name("BNUM")));
>> +    aml_append(method,
>> +        aml_store(aml_shiftleft(aml_int(1), aml_arg(1)),
>> aml_name("B0EJ")));
>> +    aml_append(method, aml_release(aml_name("BLCK")));
>> +    aml_append(method, aml_return(aml_int(0)));
>> +    aml_append(scope, method);
>> +
>> +    method = aml_method("AIDX", 2, AML_NOTSERIALIZED);
>> +    aml_append(method, aml_acquire(aml_name("BLCK"), 0xFFFF));
>> +    aml_append(method, aml_store(aml_arg(0), aml_name("BNUM")));
>> +    aml_append(method,
>> +        aml_store(aml_shiftleft(aml_int(1), aml_arg(1)),
>> aml_name("PIDX")));
>> +    aml_append(method, aml_store(aml_name("PIDX"), aml_local(0)));
>> +    aml_append(method, aml_release(aml_name("BLCK")));
>> +    aml_append(method, aml_return(aml_local(0)));
>> +    aml_append(scope, method);
>> +
>> +    aml_append(scope, aml_pci_pdsm());
>> +
>> +    aml_append(table, scope);
>> +}
>> +
>>   const VMStateDescription vmstate_acpi_pcihp_pci_status = {
>>       .name = "acpi_pcihp_pci_status",
>>       .version_id = 1,
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 864f6b5bf8..2d1eea4a1a 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -647,96 +647,6 @@ static bool
>> build_append_notification_callback(Aml *parent_scope,
>>       return !!nr_notifiers;
>>   }
>>   -static Aml *aml_pci_pdsm(void)
>> -{
>> -    Aml *method, *ifctx, *ifctx1;
>> -    Aml *ret = aml_local(0);
>> -    Aml *caps = aml_local(1);
>> -    Aml *acpi_index = aml_local(2);
>> -    Aml *zero = aml_int(0);
>> -    Aml *one = aml_int(1);
>> -    Aml *not_supp = aml_int(0xFFFFFFFF);
>> -    Aml *func = aml_arg(2);
>> -    Aml *params = aml_arg(4);
>> -    Aml *bnum = aml_derefof(aml_index(params, aml_int(0)));
>> -    Aml *sunum = aml_derefof(aml_index(params, aml_int(1)));
>> -
>> -    method = aml_method("PDSM", 5, AML_SERIALIZED);
>> -
>> -    /* get supported functions */
>> -    ifctx = aml_if(aml_equal(func, zero));
>> -    {
>> -        build_append_pci_dsm_func0_common(ifctx, ret);
>> -
>> -        aml_append(ifctx, aml_store(zero, caps));
>> -        aml_append(ifctx,
>> -            aml_store(aml_call2("AIDX", bnum, sunum), acpi_index));
>> -        /*
>> -         * advertise function 7 if device has acpi-index
>> -         * acpi_index values:
>> -         *            0: not present (default value)
>> -         *     FFFFFFFF: not supported (old QEMU without PIDX reg)
>> -         *        other: device's acpi-index
>> -         */
>> -        ifctx1 = aml_if(aml_lnot(
>> -                     aml_or(aml_equal(acpi_index, zero),
>> -                            aml_equal(acpi_index, not_supp), NULL)
>> -                 ));
>> -        {
>> -            /* have supported functions */
>> -            aml_append(ifctx1, aml_or(caps, one, caps));
>> -            /* support for function 7 */
>> -            aml_append(ifctx1,
>> -                aml_or(caps, aml_shiftleft(one, aml_int(7)), caps));
>> -        }
>> -        aml_append(ifctx, ifctx1);
>> -
>> -        aml_append(ifctx, aml_store(caps, aml_index(ret, zero)));
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
>> -
>> -       aml_append(ifctx, aml_store(aml_call2("AIDX", bnum, sunum),
>> acpi_index));
>> -       aml_append(ifctx, aml_store(pkg, ret));
>> -       /*
>> -        * Windows calls func=7 without checking if it's available,
>> -        * as workaround Microsoft has suggested to return invalid
>> for func7
>> -        * Package, so return 2 elements package but only initialize
>> elements
>> -        * when acpi_index is supported and leave them uninitialized,
>> which
>> -        * leads elements to being Uninitialized ObjectType and
>> should trip
>> -        * Windows into discarding result as an unexpected and
>> prevent setting
>> -        * bogus 'PCI Label' on the device.
>> -        */
>> -       ifctx1 = aml_if(aml_lnot(aml_lor(
>> -                    aml_equal(acpi_index, zero),
>> aml_equal(acpi_index, not_supp)
>> -                )));
>> -       {
>> -           aml_append(ifctx1, aml_store(acpi_index, aml_index(ret,
>> zero)));
>> -           /*
>> -            * optional, if not impl. should return null string
>> -            */
>> -           aml_append(ifctx1, aml_store(aml_string("%s", ""),
>> -                                        aml_index(ret, one)));
>> -       }
>> -       aml_append(ifctx, ifctx1);
>> -
>> -       aml_append(ifctx, aml_return(ret));
>> -    }
>> -
>> -    aml_append(method, ifctx);
>> -    return method;
>> -}
>> -
>>   /*
>>    * build_prt - Define interrupt routing rules
>>    *
>> @@ -1227,62 +1137,6 @@ static Aml *build_q35_dram_controller(const
>> AcpiMcfgInfo *mcfg)
>>       return dev;
>>   }
>>   -static void build_x86_acpi_pci_hotplug(Aml *table, uint64_t
>> pcihp_addr)
>> -{
>> -    Aml *scope;
>> -    Aml *field;
>> -    Aml *method;
>> -
>> -    scope =  aml_scope("_SB.PCI0");
>> -
>> -    aml_append(scope,
>> -        aml_operation_region("PCST", AML_SYSTEM_IO,
>> aml_int(pcihp_addr), 0x08));
>> -    field = aml_field("PCST", AML_DWORD_ACC, AML_NOLOCK,
>> AML_WRITE_AS_ZEROS);
>> -    aml_append(field, aml_named_field("PCIU", 32));
>> -    aml_append(field, aml_named_field("PCID", 32));
>> -    aml_append(scope, field);
>> -
>> -    aml_append(scope,
>> -        aml_operation_region("SEJ", AML_SYSTEM_IO,
>> -                             aml_int(pcihp_addr +
>> ACPI_PCIHP_SEJ_BASE), 0x04));
>> -    field = aml_field("SEJ", AML_DWORD_ACC, AML_NOLOCK,
>> AML_WRITE_AS_ZEROS);
>> -    aml_append(field, aml_named_field("B0EJ", 32));
>> -    aml_append(scope, field);
>> -
>> -    aml_append(scope,
>> -        aml_operation_region("BNMR", AML_SYSTEM_IO,
>> -                             aml_int(pcihp_addr +
>> ACPI_PCIHP_BNMR_BASE), 0x08));
>> -    field = aml_field("BNMR", AML_DWORD_ACC, AML_NOLOCK,
>> AML_WRITE_AS_ZEROS);
>> -    aml_append(field, aml_named_field("BNUM", 32));
>> -    aml_append(field, aml_named_field("PIDX", 32));
>> -    aml_append(scope, field);
>> -
>> -    aml_append(scope, aml_mutex("BLCK", 0));
>> -
>> -    method = aml_method("PCEJ", 2, AML_NOTSERIALIZED);
>> -    aml_append(method, aml_acquire(aml_name("BLCK"), 0xFFFF));
>> -    aml_append(method, aml_store(aml_arg(0), aml_name("BNUM")));
>> -    aml_append(method,
>> -        aml_store(aml_shiftleft(aml_int(1), aml_arg(1)),
>> aml_name("B0EJ")));
>> -    aml_append(method, aml_release(aml_name("BLCK")));
>> -    aml_append(method, aml_return(aml_int(0)));
>> -    aml_append(scope, method);
>> -
>> -    method = aml_method("AIDX", 2, AML_NOTSERIALIZED);
>> -    aml_append(method, aml_acquire(aml_name("BLCK"), 0xFFFF));
>> -    aml_append(method, aml_store(aml_arg(0), aml_name("BNUM")));
>> -    aml_append(method,
>> -        aml_store(aml_shiftleft(aml_int(1), aml_arg(1)),
>> aml_name("PIDX")));
>> -    aml_append(method, aml_store(aml_name("PIDX"), aml_local(0)));
>> -    aml_append(method, aml_release(aml_name("BLCK")));
>> -    aml_append(method, aml_return(aml_local(0)));
>> -    aml_append(scope, method);
>> -
>> -    aml_append(scope, aml_pci_pdsm());
>> -
>> -    aml_append(table, scope);
>> -}
>> -
>>   static Aml *build_q35_osc_method(bool enable_native_pcie_hotplug)
>>   {
>>       Aml *if_ctx;
>> @@ -1394,7 +1248,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>>           aml_append(dsdt, sb_scope);
>>             if (pm->pcihp_bridge_en || pm->pcihp_root_en) {
>> -            build_x86_acpi_pci_hotplug(dsdt, pm->pcihp_io_base);
>> +            build_acpi_pci_hotplug(dsdt, pm->pcihp_io_base);
>>           }
>>           build_piix4_pci0_int(dsdt);
>>       } else if (q35) {
>> @@ -1438,7 +1292,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>>           aml_append(dsdt, sb_scope);
>>             if (pm->pcihp_bridge_en) {
>> -            build_x86_acpi_pci_hotplug(dsdt, pm->pcihp_io_base);
>> +            build_acpi_pci_hotplug(dsdt, pm->pcihp_io_base);
>>           }
>>           build_q35_pci0_int(dsdt);
>>       }
>


