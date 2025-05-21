Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDEAC54E90
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 20:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHpv4-0003gc-HT; Wed, 21 May 2025 16:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uHpuu-0003d9-7X
 for qemu-devel@nongnu.org; Wed, 21 May 2025 16:20:00 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uHpuq-00042c-2K
 for qemu-devel@nongnu.org; Wed, 21 May 2025 16:19:55 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22e09f57ed4so81405035ad.0
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 13:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747858789; x=1748463589; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eHG847+hkMf1sdoXbCA9iDurNAwLb5cIo+F2Yg5n8Wg=;
 b=TU5vPYD3KrMNyEz1NHqq30A5/XKiR2RJp6eEtd4XRW0deGPjzWsuP5S3YYwaqsPOwL
 brwESHnXIitnWLtjApjPv/xlakGXP3OcVXYM/8A/S5PRR2YL1tb7kn/7HjhDRQ4OORf5
 JdFnwLiZBFcWaaU+2NkFzDhf0BU7d+3pq3cZUeaug7wbpuIlDMS2TaD2eDvcU++duxV9
 GLGbpJaDo9E2fTRWvEG7nIeswnINAnQ67nrFeKs/d7NIbZYKlXt7YfR1bJ2FVVATuX8Y
 ZvZ3toKbU37dceCCy1aESijGcu+lbtZ7W7q8EKxRVB1qC2hmwP5wXjap6NnJz7ErosBR
 Z6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747858789; x=1748463589;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eHG847+hkMf1sdoXbCA9iDurNAwLb5cIo+F2Yg5n8Wg=;
 b=IvCG+aq04222wOelhEdQYrNkeNo1t9ZyZJ57mrtkWvtZYdOCgdwif0s5K2opA5y29w
 T4ZFd0TYRS7Oo//7P6U+f8reqF0YakW2gBZ7R0w3iATkxd1//0spN+Ps9cUMPiXxPa4g
 rdeCzz7mH2+qPwxZmRdQa8qfBlYFwvKeet0DE0gZ/rs2Ay27j/GStljJ1JaoxPJfkLj7
 IfBIYqF2XC4hdsVAl7Tg9w+cAqcO4iwZz7JbrgAGWWY+IxvdOFLLs6Lf1qg7TtjoUVaf
 aXcnctbslMiZm0SjYnYahrcvv9KzL9lZ7Ib+fbCBkxM3KVbjAPK9CiHLyGV7cM592fYJ
 DZZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX45PKCsKSerJhzHTLYzQg5UGM/5aaXpArdHqASt/6wFrLI6R217pQaVkM+mz03WIWAkw7lSbMwrpJT@nongnu.org
X-Gm-Message-State: AOJu0Ywr+U+y2V1l024MtFYau8K8ImIIdJrn6mTZuV9vRfGX6tWR6ZLE
 GqJhkRVSCWSD0uR5WwZrN2MOZYHpkugSPinjOXDFSKc/eARaO8ON+1bB+1PPqttvqcM=
X-Gm-Gg: ASbGncurHO+o2NfYCzt4cA/dWaIPBCtI3KN/R27VzqI/0pdGryN/JSAz7jf5KYOOIpL
 DmJPQ4k9YhBpww2MB6MGtXvZYbmaxmeOSt9iEGNHmIj93BKRuc7mEQaYoyCWYa8jKQZ7M9lHvKS
 /OtccZ31CvERDC0sKbe4B3qc8XVqjpFeCtxZMKItOPOxP2hCCtjf5hzKc/mZSYW0eQv39hafQFc
 LxPSMEqzdFLzfwXSZCjN755jICAz77pOpetHsd3SPRhtyeLGoHbONIudRn+ObU61Ss+rEjybVYM
 lx3RMJgeJauq3mbjO6K9IpH6mYv/ZPiA/eHrmay+09/9UJZAu9UaBIMWelK9RDxnWKCRpeZELbn
 8bYgSy2sbnyXFC/kqntw+6+TMG8Tq/w==
X-Google-Smtp-Source: AGHT+IF/E+6kHLsWyoaEEXoUI624SA19pk4pG6E7J1Fp5dMN9n1XABcCWZjrB9w+drG4T1TMX45geg==
X-Received: by 2002:a17:902:ea01:b0:231:7fbc:19f3 with SMTP id
 d9443c01a7336-231d4d2068fmr328737685ad.12.1747858788891; 
 Wed, 21 May 2025 13:19:48 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b401:d47f:532e:8fb1:3c49:40da?
 ([2804:7f0:b401:d47f:532e:8fb1:3c49:40da])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4ac93d4sm97094485ad.28.2025.05.21.13.19.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 13:19:48 -0700 (PDT)
Message-ID: <55ef40d6-f940-4e53-b591-2a1df5f5b5e1@linaro.org>
Date: Wed, 21 May 2025 17:19:26 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/22] hw/i386/acpi-build: Move aml_pci_edsm to a generic
 place
From: Gustavo Romero <gustavo.romero@linaro.org>
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org
References: <20250514170431.2786231-1-eric.auger@redhat.com>
 <20250514170431.2786231-15-eric.auger@redhat.com>
 <ad7c7b84-9f12-4767-a349-df47c489c726@linaro.org>
 <2f1d15ea-82fe-4633-9791-ef9a3721b87d@redhat.com>
 <95bff50a-4da9-4abe-b596-95c64ab85231@linaro.org>
Content-Language: en-US
In-Reply-To: <95bff50a-4da9-4abe-b596-95c64ab85231@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Eric,

On 5/21/25 13:24, Gustavo Romero wrote:
> Hi Eric,
> 
> On 5/21/25 12:56, Eric Auger wrote:
>> Hi Gustavo,
>>
>> On 5/21/25 5:26 PM, Gustavo Romero wrote:
>>> Hi Eric,
>>>
>>> On 5/14/25 14:01, Eric Auger wrote:
>>>> Move aml_pci_edsm to pcihp since we want to reuse that for
>>>> ARM and acpi-index support.
>>>>
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>> ---
>>>>    include/hw/acpi/pcihp.h |  2 ++
>>>>    hw/acpi/pcihp.c         | 53 +++++++++++++++++++++++++++++++++++++++++
>>>>    hw/i386/acpi-build.c    | 53 -----------------------------------------
>>>>    3 files changed, 55 insertions(+), 53 deletions(-)
>>>>
>>>> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
>>>> index 4d820b4baf..bc31dbff39 100644
>>>> --- a/include/hw/acpi/pcihp.h
>>>> +++ b/include/hw/acpi/pcihp.h
>>>> @@ -82,6 +82,8 @@ bool build_append_notification_callback(Aml
>>>> *parent_scope, const PCIBus *bus);
>>>>      void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus);
>>>>    +Aml *aml_pci_edsm(void);
>>>> +
>>>>    /* Called on reset */
>>>>    void acpi_pcihp_reset(AcpiPciHpState *s);
>>>>    diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
>>>> index d800371ddc..57fe8938b1 100644
>>>> --- a/hw/acpi/pcihp.c
>>>> +++ b/hw/acpi/pcihp.c
>>>> @@ -937,6 +937,59 @@ void build_append_pci_bus_devices(Aml
>>>> *parent_scope, PCIBus *bus)
>>>>        }
>>>>    }
>>>>    +Aml *aml_pci_edsm(void)
>>>> +{
>>>> +    Aml *method, *ifctx;
>>>> +    Aml *zero = aml_int(0);
>>>> +    Aml *func = aml_arg(2);
>>>> +    Aml *ret = aml_local(0);
>>>> +    Aml *aidx = aml_local(1);
>>>> +    Aml *params = aml_arg(4);
>>>> +
>>>> +    method = aml_method("EDSM", 5, AML_SERIALIZED);
>>>> +
>>>> +    /* get supported functions */
>>>> +    ifctx = aml_if(aml_equal(func, zero));
>>>> +    {
>>>> +        /* 1: have supported functions */
>>>> +        /* 7: support for function 7 */
>>>> +        const uint8_t caps = 1 | BIT(7);
>>>> +        build_append_pci_dsm_func0_common(ifctx, ret);
>>>> +        aml_append(ifctx, aml_store(aml_int(caps), aml_index(ret,
>>>> zero)));
>>>> +        aml_append(ifctx, aml_return(ret));
>>>> +    }
>>>> +    aml_append(method, ifctx);
>>>> +
>>>> +    /* handle specific functions requests */
>>>> +    /*
>>>> +     * PCI Firmware Specification 3.1
>>>> +     * 4.6.7. _DSM for Naming a PCI or PCI Express Device Under
>>>> +     *        Operating Systems
>>>> +     */
>>>> +    ifctx = aml_if(aml_equal(func, aml_int(7)));
>>>> +    {
>>>> +       Aml *pkg = aml_package(2);
>>>> +       aml_append(pkg, zero);
>>>> +       /* optional, if not impl. should return null string */
>>>> +       aml_append(pkg, aml_string("%s", ""));
>>>> +       aml_append(ifctx, aml_store(pkg, ret));
>>>> +
>>>> +       /*
>>>> +        * IASL is fine when initializing Package with computational
>>>> data,
>>>> +        * however it makes guest unhappy /it fails to process such
>>>> AML/.
>>>> +        * So use runtime assignment to set acpi-index after initializer
>>>> +        * to make OSPM happy.
>>>> +        */
>>>> +       aml_append(ifctx,
>>>> +           aml_store(aml_derefof(aml_index(params, aml_int(0))),
>>>> aidx));
>>>> +       aml_append(ifctx, aml_store(aidx, aml_index(ret, zero)));
>>>> +       aml_append(ifctx, aml_return(ret));
>>>> +    }
>>>> +    aml_append(method, ifctx);
>>>> +
>>>> +    return method;
>>>> +}
>>>> +
>>>>    const VMStateDescription vmstate_acpi_pcihp_pci_status = {
>>>>        .name = "acpi_pcihp_pci_status",
>>>>        .version_id = 1,
>>>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>>>> index bcfba2ccb3..385e75d061 100644
>>>> --- a/hw/i386/acpi-build.c
>>>> +++ b/hw/i386/acpi-build.c
>>>> @@ -322,59 +322,6 @@ build_facs(GArray *table_data)
>>>>        g_array_append_vals(table_data, reserved, 40); /* Reserved */
>>>>    }
>>>>    -static Aml *aml_pci_edsm(void)
>>>> -{
>>>> -    Aml *method, *ifctx;
>>>> -    Aml *zero = aml_int(0);
>>>> -    Aml *func = aml_arg(2);
>>>> -    Aml *ret = aml_local(0);
>>>> -    Aml *aidx = aml_local(1);
>>>> -    Aml *params = aml_arg(4);
>>>> -
>>>> -    method = aml_method("EDSM", 5, AML_SERIALIZED);
>>>> -
>>>> -    /* get supported functions */
>>>> -    ifctx = aml_if(aml_equal(func, zero));
>>>> -    {
>>>> -        /* 1: have supported functions */
>>>> -        /* 7: support for function 7 */
>>>> -        const uint8_t caps = 1 | BIT(7);
>>>> -        build_append_pci_dsm_func0_common(ifctx, ret);
>>>> -        aml_append(ifctx, aml_store(aml_int(caps), aml_index(ret,
>>>> zero)));
>>>> -        aml_append(ifctx, aml_return(ret));
>>>> -    }
>>>> -    aml_append(method, ifctx);
>>>> -
>>>> -    /* handle specific functions requests */
>>>> -    /*
>>>> -     * PCI Firmware Specification 3.1
>>>> -     * 4.6.7. _DSM for Naming a PCI or PCI Express Device Under
>>>> -     *        Operating Systems
>>>> -     */
>>>> -    ifctx = aml_if(aml_equal(func, aml_int(7)));
>>>> -    {
>>>> -       Aml *pkg = aml_package(2);
>>>> -       aml_append(pkg, zero);
>>>> -       /* optional, if not impl. should return null string */
>>>> -       aml_append(pkg, aml_string("%s", ""));
>>>> -       aml_append(ifctx, aml_store(pkg, ret));
>>>> -
>>>> -       /*
>>>> -        * IASL is fine when initializing Package with computational
>>>> data,
>>>> -        * however it makes guest unhappy /it fails to process such
>>>> AML/.
>>>> -        * So use runtime assignment to set acpi-index after initializer
>>>> -        * to make OSPM happy.
>>>> -        */
>>>> -       aml_append(ifctx,
>>>> -           aml_store(aml_derefof(aml_index(params, aml_int(0))),
>>>> aidx));
>>>> -       aml_append(ifctx, aml_store(aidx, aml_index(ret, zero)));
>>>> -       aml_append(ifctx, aml_return(ret));
>>>> -    }
>>>> -    aml_append(method, ifctx);
>>>> -
>>>> -    return method;
>>>> -}
>>>> -
>>>>    /*
>>>>     * build_prt - Define interrupt routing rules
>>>>     *
>>>
>>> EDSM is not called from anywhere. _DSM method actually calls the PDSM,
>>> already defined
>>> in pcihp.c and generated by aml_pci_pdsm(). build_acpi_pci_hotplug(),
>>> which calls
>>> aml_pci_pdsm(), properly creates the PDSM method. Then in
>>> build_append_pcihp_slots()
>>> the a _DSM is defined per slot and inside it there is a call to PDSM,
>>> so I understand
>>> we should actually stick to the PDSM in pcihp.c instead of EDSM.
>>
>> I see build_append_pci_bus_devices -> aml_pci_static_endpoint_dsm
>> adds a _DSM method which eventually calls EDSM.
> 
> Yes, but I meant in the final generated ACPI AML code.
> 
> 
>> aml_pci_device_dsm builds another _DSM implementation which calls PDSM.
>>
>> As we use build_append_pci_bus_devices and we are likely to have a _DSM
>> implementation that calls EDSM method, I think we shall have it in the
>> aml. What do I miss?
> 
> Maybe some condition in build_append_pci_bus_devices() of:
> 
>          if (pdev->acpi_index &&
>              !object_property_get_bool(OBJECT(pdev), "hotpluggable",
>                                        &error_abort)) { ... }
> 
> 
> is not met?
> 
> Does your _DSM method in the machine's ACPI has a call to EDSM? I don't
> see it. In my case it's the PDSM that is being called:
> 
> gromero@xps13:/tmp$ grep -n PDSM dsdt.dsl
> 1910:        Method (PDSM, 5, Serialized)
> 2047:                    Return (PDSM (Arg0, Arg1, Arg2, Arg3, Local0))
> gromero@xps13:/tmp$ grep -n EDSM dsdt.dsl
> 1959:        Method (EDSM, 5, Serialized)
> gromero@xps13:/tmp$
> 
> I also confirmed that PDSM is what is being used by reverting this patch and
> dropping the aml_append(pci0_scope, aml_pci_edsm()); in 15/22.
> 
> But also, why shouldn't we use the PDSM defined already in pcihp.c? This is
> indeed crafted for the acpi-pcihp-hotplug device as I understand it.

Sorry, I see now, the EDSM is actually only for static endpoint PCI devices,
i.e. non-hotpluggable, I see. So PDSM and EDSM serve different purposes, although
similar.

So, my point in the end is (and the one that confused me too) that EDSM can be
present even if it will never be used by any static device, working pretty much
like an ACPI deadcode. Could we avoid this? For instance, just emit EDSM if
a _DSM that relies on it is emitted, like:

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index e87846a1fa..4d6dd3dd96 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -905,8 +905,9 @@ void build_append_pcihp_slots(Aml *parent_scope, PCIBus *bus)
      aml_append(parent_scope, notify_method);
  }
  
-void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus)
+bool build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus)
  {
+    bool has_dsm = false;
      int devfn;
      Aml *dev;
  
@@ -929,11 +930,14 @@ void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus)
              !object_property_get_bool(OBJECT(pdev), "hotpluggable",
                                        &error_abort)) {
              aml_append(dev, aml_pci_static_endpoint_dsm(pdev));
+            has_dsm = true;
          }
  
          /* device descriptor has been composed, add it into parent context */
          aml_append(parent_scope, dev);
      }
+
+    return has_dsm;
  }
  
  Aml *aml_pci_edsm(void)
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 05a754d368..e4788c03ed 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -844,15 +844,22 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
      if (vms->acpi_pcihp) {
          Aml *pci0_scope = aml_scope("\\_SB.PCI0");
  
-        aml_append(pci0_scope, aml_pci_edsm());
          build_acpi_pci_hotplug(dsdt, AML_SYSTEM_MEMORY,
                                 memmap[VIRT_ACPI_PCIHP].base);
          build_append_pcihp_resources(pci0_scope,
                                       memmap[VIRT_ACPI_PCIHP].base,
                                       memmap[VIRT_ACPI_PCIHP].size);
  
-        /* Scan all PCI buses. Generate tables to support hotplug. */
-        build_append_pci_bus_devices(pci0_scope, vms->bus);
+        /*
+         * Scan all PCI buses and devices. Generate tables to support static
+         * endpoint devices and hotplug.
+         */
+        /* Generate tables for static endpoints. */
+        if (build_append_pci_bus_devices(pci0_scope, vms->bus)) {
+            /* Has a _DSM method that requires a EDSM method. */
+            aml_append(pci0_scope, aml_pci_edsm());
+        }
+        /* Generate tables for PCI buses/slots/ */
          if (object_property_find(OBJECT(vms->bus), ACPI_PCIHP_PROP_BSEL)) {
              build_append_pcihp_slots(pci0_scope, vms->bus);
          }
diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
index bda5ea24b5..25cc39f4ab 100644
--- a/include/hw/acpi/pcihp.h
+++ b/include/hw/acpi/pcihp.h
@@ -82,7 +82,7 @@ void build_append_pcihp_resources(Aml *table,
                                    uint64_t io_addr, uint64_t io_len);
  bool build_append_notification_callback(Aml *parent_scope, const PCIBus *bus);
  
-void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus);
+bool build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus);
  
  Aml *aml_pci_edsm(void);


Another question that I have is: could you please share a QEMU command line option
that generates a static endpoint PCI device that matches the criteria for the emission
of the _DSM method accordingly to build_append_pci_bus_devices()?


Cheers,
Gustavo

