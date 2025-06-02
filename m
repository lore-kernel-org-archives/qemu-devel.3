Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF70C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 06:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLyiL-0007hw-75; Mon, 02 Jun 2025 02:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uLyJx-0006TS-6I
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 02:07:20 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uLyJs-000216-49
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 02:06:51 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-234d366e5f2so51619905ad.1
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 23:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748844405; x=1749449205; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aHTXPgGA2wdX75p9zmNZ2DjomHcJ6l/Odzw5Xjzr2XE=;
 b=wFmQDvGqRSg9FM9FbNfN5/0RyJT/fbpc3gzAM8f14NxySEDPrcYCN8KUIIY1yqb1eu
 gU7jWSN3fpTSDAnMgpV3vx3w3Nqz8SIx1r6H3HVehL94mQvkFWZPSoUKkQUgsLGobvOH
 6tLyGHeiYuGZLIT364VYAgA77Vb4XqQBHyorEYs2xURDqWJVBkCY6RIltuoZyUAFSOyR
 tDXCKPKx7buW4n8EVrD/6XL01sB1MHk5UhVGxDZ1tzqHkJvPLMXh/5LS/TsVkHm/75TZ
 XNRiuhybkf6dYysQpnuYFdYoO+8XglsezVcFJN2Pz8+qCnpwzarsqxLh0lftM42mPixF
 +sJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748844405; x=1749449205;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aHTXPgGA2wdX75p9zmNZ2DjomHcJ6l/Odzw5Xjzr2XE=;
 b=P8kgDWE0m1X3vRlX/THA/RvfmJYf3P/njIEywfCbheZU4H0CdKM3AsaRXLA2SmQMLV
 Os4MlOXnvohiitFT+vxhyqXDocSvYZiqiaW6qL2lMJ1WhfZsPx+v8otTCL/f67XNjzjb
 JQF4ZevYV8+5z9kWi6u64JKe1srxRqYTWLAmj7QBEzCOWoMVB8JhWKSi4I4NS/wO860P
 WfARQu5WWXMxMDGGd5Omv8yfyBsk6dZTMtn2VkfhV1uB8SYivIP3Pyh6LfAVP0qVN5qX
 E4wcXfGxVSPLz0onEZDA6fvixgN1jX+6u6pEp6hV6GZSDKy+xlKVR/8Zife9ef+dI1DI
 o7PQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSE1iO8ORMCIm0+MoFgWkD3mYCW31sazEMV+ju5s0cgGlh/uZL0YALXK99FwkdOQix8z7x/kxiRNHq@nongnu.org
X-Gm-Message-State: AOJu0YytbUmIAAhzjez/wrwgh6pVgAP2jnKjE7pEQLzHtYbQ5cYbs88U
 A6S8y9KZoxFz4rd1yXMtgzIKp5SHC6pQDXUOxP4N1nu58iKud2JnYz1Gi+QAyjGhhuo=
X-Gm-Gg: ASbGncvEB85c8xdk8psGdLk6AYWocd8qgZ2bLvLtRkklNY8h8/z7tPvTTwKLMAwJTED
 ia31+C2U3I7RGvT6U2ROTpAcfzRQdgrOX6bNQxqTkgbiUudX6lRDryBKp/l8rfq4f2X3jo5pPfe
 7FLDiksnT8cl5qWmjjZPSW744JpI31uYdZh9WXHWbL92B0UiJoRwxowGlQGBpgNcvObuskhiZSO
 QomlRsVznbjq2UUFzgeJ0EgceZJ0q80WRbG8wOTTOLQlqLTkcxcobyMkO8s1918KI6HjGDzr37o
 f10SWn6RY0PMQTycDJvtvo2rlAacg6vzvNQA3lJDfAA+MbtcR2IunKxQXE7uM+oVLw==
X-Google-Smtp-Source: AGHT+IHWUk0o0pKbZyfVxstlnev21S1gv4U7dOIdpKLtQp67t5byhlEL6GTnvsGaJO9+Ek2FpIuDrQ==
X-Received: by 2002:a17:903:41d0:b0:234:d292:be83 with SMTP id
 d9443c01a7336-2355f766d59mr113903425ad.10.1748844405057; 
 Sun, 01 Jun 2025 23:06:45 -0700 (PDT)
Received: from [192.168.0.102] ([179.180.194.137])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506cf5411sm63730525ad.188.2025.06.01.23.06.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Jun 2025 23:06:44 -0700 (PDT)
Message-ID: <bcc200fb-fa45-44ac-9e36-4c829becbf1c@linaro.org>
Date: Mon, 2 Jun 2025 03:06:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/25] tests/qtest/bios-tables-test: Keep ACPI PCI
 hotplug off
To: Igor Mammedov <imammedo@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com,
 pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org,
 alex.bennee@linaro.org
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-25-eric.auger@redhat.com>
 <20250528113813.47086516@imammedo.users.ipa.redhat.com>
 <375cfbd6-e585-4b6d-bf10-6571aa40370e@linaro.org>
 <20250528150239.5f6b63d0@imammedo.users.ipa.redhat.com>
 <6a5776b4-73ef-427b-b4e4-b25031b0ce53@linaro.org>
 <20250530135103.09030cf0@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250530135103.09030cf0@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62e.google.com
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

Hi Igor and Eric,

I'm sending again this to the mailing list since it seems the first one
got lost... I can't find it either in qemu-devel@ or in qemu-arm@ :(

On 5/30/25 08:51, Igor Mammedov wrote:
> On Wed, 28 May 2025 12:04:26 -0300
> Gustavo Romero <gustavo.romero@linaro.org> wrote:
> 
>> Hi Igor,
>>
>> On 5/28/25 10:02, Igor Mammedov wrote:
>>> On Wed, 28 May 2025 09:41:15 -0300
>>> Gustavo Romero <gustavo.romero@linaro.org> wrote:
>>>    
>>>> Hi Igor,
>>>>
>>>> On 5/28/25 06:38, Igor Mammedov wrote:
>>>>> On Tue, 27 May 2025 09:40:26 +0200
>>>>> Eric Auger <eric.auger@redhat.com> wrote:
>>>>>       
>>>>>> From: Gustavo Romero <gustavo.romero@linaro.org>
>>>>>>
>>>>>> ACPI PCI hotplug is now turned on by default so we need to change the
>>>>>> existing tests to keep it off. However, even setting the ACPI PCI
>>>>>> hotplug off in the existing tests, there will be changes in the ACPI
>>>>>> tables because the _OSC method was modified, hence in the next patch of
>>>>>> this series the blobs are updated accordingly.
>>>>>>
>>>>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>>
>>>>> it would be better to test whatever default we end up with.
>>>>> (like x86)
>>>>
>>>> hmm maybe there is a confusion here, Igor. We are actually planning what you
>>>
>>> perhaps, see my reply to Eric about my expectations wrt tests.
>>
>> Yip, I read it before my reply here.
>>
>>
>>> (i.e. default tests shouldn't have any explicit CLI options,
>>> instead it should follow whitelist blobs/set new default patch/update blobs pattern)
>>
>> I see. I agree with that. But this patch is not about the new test. The new test is
>> _not_ in this series. Patches 8/25, 10/25, and 24/25 are _not_ about the new test but
>> about adapting the _legacy tests_ (native acpi) to the situation when ACPI HP becomes
>> the default, because this series makes acpi-pcihp=on the default, hence the CLI option
>> "acpi-pcihp=off" added to them. An update to the blobs are also necessary because of the
>> change in _OSC method, even when acpi-pcihp=off.
>>
>>
>>>> said. This patch and the other two in this series related to the bios-tables-test
>>>> (i.e., patches 8/25 and 10/25) are for actually making the current (legacy) test pass,
>>>> since the new default as per this series will be acpi-pcihp=on. That's why here we're
>>>> adapting the current test here to have acpi-pcihp=off.
>>>>
>>>> The new test that will test for acpi-pcihp=on (the new default) is not in this series
>>>> and we decided to merge it separate. It's in the patch 4/5 and 5/5 of the follow series:
>>
>> We're doing the "blobs/set new default patch/update blobs pattern" in the new test, which
>> we can merge later, once this series is merged, no? The step "set new default" then will
>> not be necessary because the new test will be merged separate, after this series, so when
>> acpi-pcihp=on is already the default.
>>
>> Please note that although we're using acpi-pcihp=on in the new test, it's not necessary,
>> we can dropped this option, making it implicit as you say, and it will work. This is the
>> new test:
>>
>>>> https://mail.gnu.org/archive/html/qemu-devel/2025-05/msg05828.html 4/5
>>>> https://mail.gnu.org/archive/html/qemu-devel/2025-05/msg05827.html 5/5
>>
>>
>> Thus, there are to "acts" of modifying the bios-tables-test:
>>
>> 1) Adapt the current tests to when acpi-pcihp=on becomes the default (hence the addition
>>      to them of "acpi-pcihp=off".
> 
> 
> that's what I disagree with.
> 
> 1) Instead adapting majority of tests to legacy before switching defaults,
> just do whitelist/modify default/update so all of tests run with new default.
> 
> and then
> 
>> There is also the need to update the blobs, but it's because
>>      of the _OSC method change in DSDT table, which will change anyways, even with "acpi-pcihp=off¨,
>>      hence the need for patch 10/25 in this series. This is _done is this series_.
> 
> 
>   
>> 2) Add a new test for testing the default (i.e. acpi-pcihp-on). It follows what you're
>>      saying above: "follow whitelist blobs/set new default patch/update blobs pattern",
>>      because we can drop the acpi-pcihp-on option from the CLI in this test without any
>>      prejudice to test. While the step "set new default patch" was actually done in 1).
> 
> 2) add a separate test case for native pcie hoplug (preferably within this series)
> 
> 3) even better would be to add #2 before #1 (right after 10/25),
> this way will guarantee that old native hotplug tables stay
> the same regardless of followup patches that add ACPI pcihp aml.

Got it now, hopefully... 🙂

OK, I'm trying to follow what you recommended in 3). I've pushed a series to:

https://github.com/gromero/qemu/commits/v2_20250527_eric_auger_redhat_com/

So, I understand we will need to add/update the blobs at three times,
2 times because of the changes in the DSDT generation (_OSC changes and when
acpi-pci=on) and an additional one because of the new PCIe native hotplug test.

I dropped this patch (Patch 24/25) from the series.

So the overview of the organization would be the following:


3c302f7222 tests/qtest/bios-tables-test: Update DSDT blobs                                   #1c (update blob)    \
671f15f470 hw/arm/virt: Use ACPI PCI hotplug by default                                      #1b (modify default) |--- acpi-pcihp=on
9468f730e1 tests/qtest/bios-tables-test: Prepare for changes in the DSDT table               #1a (whitelist)      /
c9ec0e0226 hw/arm/virt: Plug pcihp hotplug/hotunplug callbacks
dc44749a34 hw/arm/virt: Let virt support pci hotplug/unplug GED event
f667079260 hw/core/sysbus: Introduce sysbus_mmio_map_name() helper
46731e563b hw/acpi/ged: Support migration of AcpiPciHpState
4fa7b0e0f6 hw/acpi/ged: Call pcihp plug callbacks in hotplug handler implementation
587b001876 hw/acpi/ged: Prepare the device to react to PCI hotplug events
b55183d128 hw/arm/virt-acpi-build: Modify the DSDT ACPI table to enable ACPI PCI hotplug
fe4c96b384 hw/i386/acpi-build: Move aml_pci_edsm to a generic place
010c50dbc7 hw/i386/acpi-build: Introduce and use acpi_get_pci_host
5a1be727e6 hw/i386/acpi-build: Move build_append_pci_bus_devices/pcihp_slots to pcihp
14a172e192 hw/i386/acpi-build: Move build_append_notification_callback to pcihp
5110ae8874 hw/acpi/pcihp: Add an AmlRegionSpace arg to build_acpi_pci_hotplug
82c2aef672 hw/i386/acpi-build: Introduce build_append_pcihp_resources() helper
6372fe7eef qtest/bios-tables-test: Update DSDT 'noacpipcihp' variant blob                    #2 (blob update for test), part 2 of 2 (update blob)  ]--- New PCIe native test
6fb29ba18d tests/qtest/bios-tables-test: Add aarch64 PCIe native hotplug test                #2 (pcie native hp test), part 1 of 2 (whitelist)     /
12c63a505e tests/qtest/bios-tables-test: Update DSDT blobs after GPEX _OSC change            Patch 10/25 in this series (update blob)    \
779bd47749 hw/pci-host/gpex-acpi: Use build_pci_host_bridge_osc_method                       Patch  9/25 in this series (modify default) |--- _OSC change
f260fd59c1 tests/qtest/bios-tables-test: Prepare for changes in the DSDT table               Patch  8/25 in this series (whitelist)      /
b000677fd9 hw/i386/acpi-build: Turn build_q35_osc_method into a generic method
a72f87b634 hw/pci-host/gpex-acpi: Propagate hotplug type info from virt machine downto gpex
77a87b6ba3 hw/pci-host/gpex-acpi: Split host bridge OSC and DSM generation
67e4dc2e7b hw/pci-host/gpex-acpi: Add native_pci_hotplug arg to acpi_dsdt_add_pci_osc
b89e69da54 hw/acpi: Rename and move build_x86_acpi_pci_hotplug to pcihp
74f1080a74 hw/arm/virt: Introduce machine state acpi pcihp flags and props
1048082f33 hw/i386/acpi-build: Make aml_pci_device_dsm() static

See notes on the right for when the blobs are updated or added in the
series. The new test for PCIe native hotplug (I prefer not calling it legacy,
since it's not really legacy; it's just an alternative better in some scenarios,
specially in virtualization) is now in the series (#2), "right after 10/25".

Is something like that that you want?


Cheers,
Gustavo

> 
>> Cheers,
>> Gustavo
>>
>>>> https://mail.gnu.org/archive/html/qemu-devel/2025-05/msg05828.html 4/5
>>>> https://mail.gnu.org/archive/html/qemu-devel/2025-05/msg05827.html 5/5
>>>>
>>>>
>>>> Cheers,
>>>> Gustavo
>>>>   
>>>>>>
>>>>>> ---
>>>>>>
>>>>>> [Eric] also added acpi-pcihp=off to test_acpi_aarch64_virt_tcg_numamem
>>>>>> ---
>>>>>>     tests/qtest/bios-tables-test.c | 13 +++++++++----
>>>>>>     1 file changed, 9 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
>>>>>> index 0a333ec435..6379dba714 100644
>>>>>> --- a/tests/qtest/bios-tables-test.c
>>>>>> +++ b/tests/qtest/bios-tables-test.c
>>>>>> @@ -1626,7 +1626,7 @@ static void test_acpi_aarch64_virt_tcg_memhp(void)
>>>>>>         };
>>>>>>     
>>>>>>         data.variant = ".memhp";
>>>>>> -    test_acpi_one(" -machine nvdimm=on"
>>>>>> +    test_acpi_one(" -machine nvdimm=on,acpi-pcihp=off"
>>>>>>                       " -cpu cortex-a57"
>>>>>>                       " -m 256M,slots=3,maxmem=1G"
>>>>>>                       " -object memory-backend-ram,id=ram0,size=128M"
>>>>>> @@ -1747,7 +1747,8 @@ static void test_acpi_aarch64_virt_tcg_numamem(void)
>>>>>>         };
>>>>>>     
>>>>>>         data.variant = ".numamem";
>>>>>> -    test_acpi_one(" -cpu cortex-a57"
>>>>>> +    test_acpi_one(" -machine acpi-pcihp=off"
>>>>>> +                  " -cpu cortex-a57"
>>>>>>                       " -object memory-backend-ram,id=ram0,size=128M"
>>>>>>                       " -numa node,memdev=ram0",
>>>>>>                       &data);
>>>>>> @@ -1775,7 +1776,8 @@ static void test_acpi_aarch64_virt_tcg_pxb(void)
>>>>>>          * to solve the conflicts.
>>>>>>          */
>>>>>>         data.variant = ".pxb";
>>>>>> -    test_acpi_one(" -device pcie-root-port,chassis=1,id=pci.1"
>>>>>> +    test_acpi_one(" -machine acpi-pcihp=off"
>>>>>> +                  " -device pcie-root-port,chassis=1,id=pci.1"
>>>>>>                       " -device virtio-scsi-pci,id=scsi0,bus=pci.1"
>>>>>>                       " -drive file="
>>>>>>                       "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2,"
>>>>>> @@ -1846,7 +1848,7 @@ static void test_acpi_aarch64_virt_tcg_acpi_hmat(void)
>>>>>>     
>>>>>>         data.variant = ".acpihmatvirt";
>>>>>>     
>>>>>> -    test_acpi_one(" -machine hmat=on"
>>>>>> +    test_acpi_one(" -machine hmat=on,acpi-pcihp=off"
>>>>>>                       " -cpu cortex-a57"
>>>>>>                       " -smp 4,sockets=2"
>>>>>>                       " -m 384M"
>>>>>> @@ -2123,6 +2125,7 @@ static void test_acpi_aarch64_virt_tcg(void)
>>>>>>         data.smbios_cpu_max_speed = 2900;
>>>>>>         data.smbios_cpu_curr_speed = 2700;
>>>>>>         test_acpi_one("-cpu cortex-a57 "
>>>>>> +                  "-machine acpi-pcihp=off "
>>>>>>                       "-smbios type=4,max-speed=2900,current-speed=2700", &data);
>>>>>>         free_test_data(&data);
>>>>>>     }
>>>>>> @@ -2142,6 +2145,7 @@ static void test_acpi_aarch64_virt_tcg_topology(void)
>>>>>>         };
>>>>>>     
>>>>>>         test_acpi_one("-cpu cortex-a57 "
>>>>>> +                  "-machine acpi-pcihp=off "
>>>>>>                       "-smp sockets=1,clusters=2,cores=2,threads=2", &data);
>>>>>>         free_test_data(&data);
>>>>>>     }
>>>>>> @@ -2227,6 +2231,7 @@ static void test_acpi_aarch64_virt_viot(void)
>>>>>>         };
>>>>>>     
>>>>>>         test_acpi_one("-cpu cortex-a57 "
>>>>>> +                  "-machine acpi-pcihp=off "
>>>>>>                       "-device virtio-iommu-pci", &data);
>>>>>>         free_test_data(&data);
>>>>>>     }
>>>>>       
>>>>   
>>>    
>>
> 


