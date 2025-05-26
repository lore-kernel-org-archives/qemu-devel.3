Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA8EC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 09:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJTwo-0007a5-5W; Mon, 26 May 2025 05:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uJTwi-0007ZY-Dl
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:16:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uJTwg-00029S-Co
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748250992;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gP7bhR/Bz7+K4YlN9kdxnUmT0MNeXQaa2VG/VtrbHus=;
 b=RGLY75opSSprcAubJlpBpXniwTuhoK0hW/XdiD0AHlRGiXzDxq9uzv2Muw20UD486eP+Br
 Y5xhgt/8+ryk9OGps8MS79wt95qe8SUuPGmT1YHY2cD11hMPth0b5SPeiy4Tqg7Wqvj2uC
 l/mDIReKAWDh7Q/Z2Sk7vpbb1kLXik0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-nKNHKGJaM3C5jcXHQLqDMg-1; Mon, 26 May 2025 05:16:30 -0400
X-MC-Unique: nKNHKGJaM3C5jcXHQLqDMg-1
X-Mimecast-MFC-AGG-ID: nKNHKGJaM3C5jcXHQLqDMg_1748250989
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-442dc702850so12733045e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 02:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748250989; x=1748855789;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gP7bhR/Bz7+K4YlN9kdxnUmT0MNeXQaa2VG/VtrbHus=;
 b=df4336FUAHdTGaFJSSsDo8ZmJjnUuVxqSqlJjb/fvfTa48Tm0FZC1BfT7UCXkRSeZj
 biBRC/324UDPmSON7qqLrVG9PTH435kLbif8ABj9VbDnMJRS6YSPIV4RfrC8BWAQAFT5
 E5DfIF/DLI+6krbpZOB9AXO8JJRRw8MreLqAAc7lxvFLKEGiOc9WjGf+Ij/cdMq57lVe
 JHBwvZwqVx2A/rAiblGyrOLLv4+j/Z8ciZ+bOgjwSXdN2KZIne1LGETmukS47QroFxwF
 nKlALuUuRiFCCaHS0BAufLT59qmup36oDdU/9Rf2cDH4W2w+igQyRy0Q22qEmqiael9T
 XiNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYRy1rET0Mnowmc0jc9m8ZXLTpyyyLiPBmxo4/hK/W4sg+dC8UPy9SUh+OxsRpUAyrG36CXRstFHvn@nongnu.org
X-Gm-Message-State: AOJu0YwoxFXVRHpja2JpppjTsgT7fBth3wrawCd4fxlYLGuQNYHftE12
 s5Db20UTf26Ou6w+V6i+Oqc8JMUzpH9euSd0AQ/SW62kN8P1BLQM7A6gXNUvuCUHLW7H9SiI5ox
 GuPa3faqLlYBu5E/UZGmxbDfSGkWEnPyx26wID3qtVk6/lYzcyf+Kbl0y
X-Gm-Gg: ASbGncv56ZuzT8iH/dXSroNswBHnU+o7Dra/sL8X+01kpnWWsX4bUGDpTQyrZQwKr94
 0zOjj10yE4lWSFpjiL/zdNud6jNvad2+WQZBvbId/xL9ab7wAGFu+EYcFr4oNIRxGnKHs+NqYi8
 zduHRSY4SDLtgwqZHiDOMckbxI3VzTWxOKTwBsdPJT41X7Bx+QPlkrZdDjenXT4Z+zMsBuq9KHv
 wO8aHzs7Fugi9zTRnV9GC1nNkpHsGlBGjV6GI+NKVn0hDSGE8ICYS0C2th/N0Egi3frigrWlWbo
 9xpEKEZFQPZmWFgZrhg+01CQhoqRTN3Akb04vC9XNfg15H33KEihnUc4yvk=
X-Received: by 2002:a05:600c:511d:b0:442:cab1:e092 with SMTP id
 5b1f17b1804b1-44c91cc5591mr65988315e9.11.1748250989456; 
 Mon, 26 May 2025 02:16:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQbnwYYoXMAjkFE0O2IA3Q9cVPtgtnptRJ6curAiCPMqn5VXOEJ3VqKr3iXB5hhp+J9u390w==
X-Received: by 2002:a05:600c:511d:b0:442:cab1:e092 with SMTP id
 5b1f17b1804b1-44c91cc5591mr65988065e9.11.1748250989063; 
 Mon, 26 May 2025 02:16:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4d17266d5sm5082921f8f.68.2025.05.26.02.16.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 02:16:28 -0700 (PDT)
Message-ID: <299fa5d3-7e05-4151-ab90-84447b3339cd@redhat.com>
Date: Mon, 26 May 2025 11:16:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/22] hw/i386/acpi-build: Introduce and use
 acpi_get_pci_host
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org
References: <20250514170431.2786231-1-eric.auger@redhat.com>
 <20250514170431.2786231-14-eric.auger@redhat.com>
 <9b996b3a-cc60-499e-a8a6-028f16156180@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <9b996b3a-cc60-499e-a8a6-028f16156180@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 5/20/25 10:00 PM, Gustavo Romero wrote:
> Hi Eric,
>
> On 5/14/25 14:01, Eric Auger wrote:
>> pcihp acpi_set_pci_info() generic code currently uses
>> acpi_get_i386_pci_host() to retrieve the pci host bridge.
>>
>> Let's rename acpi_get_i386_pci_host into acpi_get_pci_host and
>> move it in pci generic code.
>>
>> The helper is augmented with the support of ARM GPEX.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>   include/hw/acpi/pci.h |  2 ++
>>   hw/acpi/pci.c         | 20 ++++++++++++++++++++
>>   hw/acpi/pcihp.c       |  3 ++-
>>   hw/i386/acpi-build.c  | 24 ++++--------------------
>>   4 files changed, 28 insertions(+), 21 deletions(-)
>>
>> diff --git a/include/hw/acpi/pci.h b/include/hw/acpi/pci.h
>> index 4dca22c0e2..310cbd02db 100644
>> --- a/include/hw/acpi/pci.h
>> +++ b/include/hw/acpi/pci.h
>> @@ -41,4 +41,6 @@ void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml
>> *scope);
>>     void build_srat_generic_affinity_structures(GArray *table_data);
>>   +Object *acpi_get_pci_host(void);
>> +
>>   #endif
>> diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
>> index d511a85029..4191886ebe 100644
>> --- a/hw/acpi/pci.c
>> +++ b/hw/acpi/pci.c
>> @@ -26,6 +26,7 @@
>>   #include "qemu/osdep.h"
>>   #include "qemu/error-report.h"
>>   #include "qom/object_interfaces.h"
>> +#include "qom/object.h"
>>   #include "qapi/error.h"
>>   #include "hw/boards.h"
>>   #include "hw/acpi/aml-build.h"
>> @@ -33,6 +34,9 @@
>>   #include "hw/pci/pci_bridge.h"
>>   #include "hw/pci/pci_device.h"
>>   #include "hw/pci/pcie_host.h"
>> +#include "hw/pci-host/i440fx.h"
>> +#include "hw/pci-host/q35.h"
>> +#include "hw/pci-host/gpex.h"
>>     /*
>>    * PCI Firmware Specification, Revision 3.0
>> @@ -301,3 +305,19 @@ void
>> build_srat_generic_affinity_structures(GArray *table_data)
>>       object_child_foreach_recursive(object_get_root(),
>> build_acpi_generic_port,
>>                                      table_data);
>>   }
>> +
>> +Object *acpi_get_pci_host(void)
>> +{
>> +    Object *host;
>> +
>> +    host =
>> object_resolve_type_unambiguous(TYPE_I440FX_PCI_HOST_BRIDGE, NULL);
>> +    if (host) {
>> +        return host;
>> +    }
>> +    host = object_resolve_type_unambiguous(TYPE_Q35_HOST_DEVICE, NULL);
>> +    if (host) {
>> +        return host;
>> +    }
>> +    host = object_resolve_type_unambiguous(TYPE_GPEX_HOST, NULL);
>> +    return host;
>> +}
>> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
>> index 942669ea89..d800371ddc 100644
>> --- a/hw/acpi/pcihp.c
>> +++ b/hw/acpi/pcihp.c
>> @@ -36,6 +36,7 @@
>>   #include "hw/pci-bridge/xio3130_downstream.h"
>>   #include "hw/i386/acpi-build.h"
>>   #include "hw/acpi/acpi.h"
>> +#include "hw/acpi/pci.h"
>>   #include "hw/pci/pci_bus.h"
>>   #include "migration/vmstate.h"
>>   #include "qapi/error.h"
>> @@ -102,7 +103,7 @@ static void *acpi_set_bsel(PCIBus *bus, void
>> *opaque)
>>   static void acpi_set_pci_info(bool has_bridge_hotplug)
>>   {
>>       static bool bsel_is_set;
>> -    Object *host = acpi_get_i386_pci_host();
>> +    Object *host = acpi_get_pci_host();
>>       PCIBus *bus;
>>       BSELInfo info = { .bsel_alloc = ACPI_PCIHP_BSEL_DEFAULT,
>>                         .has_bridge_hotplug = has_bridge_hotplug };
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 06b4b8eed4..bcfba2ccb3 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -269,27 +269,11 @@ static void acpi_get_misc_info(AcpiMiscInfo *info)
>>   #endif
>>   }
>>   -/*
>> - * Because of the PXB hosts we cannot simply query
>> TYPE_PCI_HOST_BRIDGE.
>> - * On i386 arch we only have two pci hosts, so we can look only for
>> them.
>> - */
>> -Object *acpi_get_i386_pci_host(void)
>> -{
>> -    PCIHostState *host;
>> -
>> -    host = PCI_HOST_BRIDGE(object_resolve_path("/machine/i440fx",
>> NULL));
>> -    if (!host) {
>> -        host = PCI_HOST_BRIDGE(object_resolve_path("/machine/q35",
>> NULL));
>> -    }
>> -
>> -    return OBJECT(host);
>> -}
>> -
>
> It's also possible to add a child prop to the TYPE_GPEX_HOST in
> create_pcie, like:
>
> @@ -1510,6 +1510,7 @@ static void create_pcie(VirtMachineState *vms)
>      MachineClass *mc = MACHINE_GET_CLASS(ms);
>  
>      dev = qdev_new(TYPE_GPEX_HOST);
> +    object_property_add_child(OBJECT(vms), "gpex", OBJECT(dev));
>
> then follow to logic in acpi_get_i386_pci_host via:
>
> PCI_HOST_BRIDGE(object_resolve_path("/machine/gpex", NULL))
indeed
>
> but I like better your solution of using the final class types, so:
>
> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>

OK thanks! I described that change in the commit msg because it was
effectively not properly described.

Cheers

Eric
>
>
> Cheers,
> Gustavo
>
>>   static void acpi_get_pci_holes(Range *hole, Range *hole64)
>>   {
>>       Object *pci_host;
>>   -    pci_host = acpi_get_i386_pci_host();
>> +    pci_host = acpi_get_pci_host();
>>         if (!pci_host) {
>>           return;
>> @@ -1245,7 +1229,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>>         sb_scope = aml_scope("\\_SB");
>>       {
>> -        Object *pci_host = acpi_get_i386_pci_host();
>> +        Object *pci_host = acpi_get_pci_host();
>>             if (pci_host) {
>>               PCIBus *pbus = PCI_HOST_BRIDGE(pci_host)->bus;
>> @@ -1306,7 +1290,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>>       if (pm->pcihp_bridge_en || pm->pcihp_root_en) {
>>           bool has_pcnt;
>>   -        Object *pci_host = acpi_get_i386_pci_host();
>> +        Object *pci_host = acpi_get_pci_host();
>>           PCIBus *b = PCI_HOST_BRIDGE(pci_host)->bus;
>>             scope = aml_scope("\\_SB.PCI0");
>> @@ -1946,7 +1930,7 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
>>       Object *pci_host;
>>       QObject *o;
>>   -    pci_host = acpi_get_i386_pci_host();
>> +    pci_host = acpi_get_pci_host();
>>       if (!pci_host) {
>>           return false;
>>       }
>


