Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2506C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 06:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLyjs-0000lS-0a; Mon, 02 Jun 2025 02:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uLyTa-0003RV-2M
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 02:17:00 -0400
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uLyTP-0003Xo-Dh
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 02:16:45 -0400
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-4e59012c7eeso2871918137.1
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 23:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748844996; x=1749449796; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jPdsnRY5+Vx+B0EseW1kn4hEuKxtA+cyMPZCTOqyPyA=;
 b=tJFAsreJe+fJgrZV75mMYDwNJ1KqNR9LF4uJvcONzTi5EcG+gXR5jrP0+WZcpBA+UZ
 nc1vgb+0xHlyJp4bww0KRvo5bLqLaOSSiftNVJfLPP7gDgCuBGHcgOqxrc4NzRLm2TWw
 UKnZtCuSZLrHtPowNffgjmqQoDX1gGwhBHFAlXjDLMTgami9HsMWKpMYFTA0Dn6pr0TL
 StzqtLn+l63nOk2ZEhAHnVrd6WfL+emy+PMZSMdLc5m24EqH6uyykgiuShLNfPxo1wk1
 uplJyZXzu98xOvrchy0ZScd/o+mtXwCJgR4pQVjwSOVCzkugoXVxOsyi4gq5ar4usGt7
 wntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748844996; x=1749449796;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jPdsnRY5+Vx+B0EseW1kn4hEuKxtA+cyMPZCTOqyPyA=;
 b=bfSYOYxudovOj8/vl85RQNUuM7TFk2YWl6ZkRAzt1WWaBInmp0RL5pwbcqZDv5Howp
 WXdavy/lGH12eH/fICPxR5vPbcwLiVaSsM0wUG20gvah/Rbx2CpAb8gPaYZLscBh2Syu
 GIfgaFyxBbPQ/qDp7Qwu1ey4sxqnelPvkdS1tGcJBXx3kw/mhxj0yh0Fph0pt/HvL9Cg
 4TxIh2Am1ZBwOYtiRSELW1MIJNWJrekwbwCpmyL4lcOenu4snZShCWAeQ4PxBdqCzdT8
 s68fPPmdm7bklWoRx4ma+m6A6SI30CFuJ9Ok3aV6q2wdbbP2fs3v2HyY+PfVpteX5Yg5
 cBFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFcg3U4Hnfg0Ga31EJ8eCiWttf8UVKYvImYiiwnqIpqjpMO/HwuCm/7UE0Oz7jsCKROkpcLZzXL3xd@nongnu.org
X-Gm-Message-State: AOJu0YyV1ELZRYLuVvvXRb+yL18gJTEiJA6q9GFq0ye5Xwk9cAIJ1TDE
 +WKMSokU1PS8EIceSqLvWqsXGOCHt7bDiF53ZYyYAVhEZ+AiuVZw9XzJCYStetzVcRY=
X-Gm-Gg: ASbGnct03eZERx8GOjGI6hd0Mz9Xt/3i6sg3zwgR9uzbu9qdJimD5yWkUS0fXaFqJtL
 GBKZn/reyM2mGkskvbECNRnogaBXcsGWlosBfczrCwUqFP+AhFi/1keqq/DOUDjfBcuSIthBds4
 INs5oko3nutwnNGJV6eCNhA4c4G7MAMRpgEpCLPNTxOx4tnyiLA9wFgF0bCr9vvYUkH+hLVRdGM
 g9ROVwePLzu6HajuVEj+qGYqCzw2S/hz5K40kHgR693P/q54P2lrQ2uI6buyY3tHFECukGsvJoq
 qJJiZZPQ7ulwvXVeIr9U3txbe0V+W/VfeEXAPEzofZhoZvWaL/5SfKW+vnTwkew5Dw==
X-Google-Smtp-Source: AGHT+IFdnPEJWTCb5wsXdXvdoOdB501kThHqOiB6OQn7+PTm7RElBHoxTB+v4YKVslukJyWphxK4yA==
X-Received: by 2002:a05:6102:cd3:b0:4e5:fe5e:2be4 with SMTP id
 ada2fe7eead31-4e6e41d9351mr10517951137.22.1748844996624; 
 Sun, 01 Jun 2025 23:16:36 -0700 (PDT)
Received: from [192.168.0.102] ([179.180.194.137])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-87e2a2a4238sm5715521241.14.2025.06.01.23.16.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Jun 2025 23:16:36 -0700 (PDT)
Message-ID: <09cc2688-ef7f-4dd6-a4ed-a18adb07d35e@linaro.org>
Date: Mon, 2 Jun 2025 03:16:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/25] tests/qtest/bios-tables-test: Keep ACPI PCI
 hotplug off
To: eric.auger@redhat.com, Igor Mammedov <imammedo@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com, pbonzini@redhat.com, Jonathan.Cameron@huawei.com,
 philmd@linaro.org, alex.bennee@linaro.org
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-25-eric.auger@redhat.com>
 <20250528113813.47086516@imammedo.users.ipa.redhat.com>
 <fd44ef37-ef02-4e60-817d-1362c76433b0@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <fd44ef37-ef02-4e60-817d-1362c76433b0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e32;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vs1-xe32.google.com
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

Hi Eric,

On 5/28/25 06:48, Eric Auger wrote:
> Hi Igor,
> 
> On 5/28/25 11:38 AM, Igor Mammedov wrote:
>> On Tue, 27 May 2025 09:40:26 +0200
>> Eric Auger <eric.auger@redhat.com> wrote:
>>
>>> From: Gustavo Romero <gustavo.romero@linaro.org>
>>>
>>> ACPI PCI hotplug is now turned on by default so we need to change the
>>> existing tests to keep it off. However, even setting the ACPI PCI
>>> hotplug off in the existing tests, there will be changes in the ACPI
>>> tables because the _OSC method was modified, hence in the next patch of
>>> this series the blobs are updated accordingly.
>>>
>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> it would be better to test whatever default we end up with.
>> (like x86)
> 
> See my question on patch 2's comment. We intended to have tests for both
> modes (legacy and acpi pcihp). Gustavo added some new tests for the new
> default, namely acpi pcihp. Now I did not really understand your point
> about keeping legacy mode as a default.

I _think_ I understood what Igor is suggesting. In a separate series, that
I've kept in a github branch to not add noise here, I removed the test for
acpi-pcihp=on and just added one for acpi-pcihp=off after we adjust the blobs
for the _OSC change. I added the test before acpi-pcihp=on becomes the default,
since if everything is ok the native test must continue to work after acpi-pcihp=on
becomes the default, as Igor said.

Anyways, please see my last reply to Igor in this thread (for some reason
I can't find the reply either in qemu-devel@ or qemu-arm@)... I'm pasting
below the main part just in case (the branch and the overview for the tests
location in the series):

https://github.com/gromero/qemu/commits/v2_20250527_eric_auger_redhat_com/

3c302f7222 tests/qtest/bios-tables-test: Update DSDT blobs                                   #1c (update blob)    \
671f15f470 hw/arm/virt: Use ACPI PCI hotplug by default                                      #1b (modify default) | acpi-pcihp=on
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
6372fe7eef qtest/bios-tables-test: Update DSDT 'noacpipcihp' variant blob                    #2 (blob update for test), part 2 of 2 (update blob)  ] New PCIe native test
6fb29ba18d tests/qtest/bios-tables-test: Add aarch64 PCIe native hotplug test                #2 (pcie native hp test), part 1 of 2 (whitelist)     /
12c63a505e tests/qtest/bios-tables-test: Update DSDT blobs after GPEX _OSC change            Patch 10/25 in this series (update blob)    \
779bd47749 hw/pci-host/gpex-acpi: Use build_pci_host_bridge_osc_method                       Patch  9/25 in this series (modify default) | _OSC change
f260fd59c1 tests/qtest/bios-tables-test: Prepare for changes in the DSDT table               Patch  8/25 in this series (whitelist)      /
b000677fd9 hw/i386/acpi-build: Turn build_q35_osc_method into a generic method
a72f87b634 hw/pci-host/gpex-acpi: Propagate hotplug type info from virt machine downto gpex
77a87b6ba3 hw/pci-host/gpex-acpi: Split host bridge OSC and DSM generation
67e4dc2e7b hw/pci-host/gpex-acpi: Add native_pci_hotplug arg to acpi_dsdt_add_pci_osc
b89e69da54 hw/acpi: Rename and move build_x86_acpi_pci_hotplug to pcihp
74f1080a74 hw/arm/virt: Introduce machine state acpi pcihp flags and props
1048082f33 hw/i386/acpi-build: Make aml_pci_device_dsm() static

Feel free to cherry-pick the tests and adjust them as you did before.

I'll be off this week returning on June 9.


Cheers,
Gustavo

> Thanks
> 
> Eric
>>
>>> ---
>>>
>>> [Eric] also added acpi-pcihp=off to test_acpi_aarch64_virt_tcg_numamem
>>> ---
>>>   tests/qtest/bios-tables-test.c | 13 +++++++++----
>>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
>>> index 0a333ec435..6379dba714 100644
>>> --- a/tests/qtest/bios-tables-test.c
>>> +++ b/tests/qtest/bios-tables-test.c
>>> @@ -1626,7 +1626,7 @@ static void test_acpi_aarch64_virt_tcg_memhp(void)
>>>       };
>>>   
>>>       data.variant = ".memhp";
>>> -    test_acpi_one(" -machine nvdimm=on"
>>> +    test_acpi_one(" -machine nvdimm=on,acpi-pcihp=off"
>>>                     " -cpu cortex-a57"
>>>                     " -m 256M,slots=3,maxmem=1G"
>>>                     " -object memory-backend-ram,id=ram0,size=128M"
>>> @@ -1747,7 +1747,8 @@ static void test_acpi_aarch64_virt_tcg_numamem(void)
>>>       };
>>>   
>>>       data.variant = ".numamem";
>>> -    test_acpi_one(" -cpu cortex-a57"
>>> +    test_acpi_one(" -machine acpi-pcihp=off"
>>> +                  " -cpu cortex-a57"
>>>                     " -object memory-backend-ram,id=ram0,size=128M"
>>>                     " -numa node,memdev=ram0",
>>>                     &data);
>>> @@ -1775,7 +1776,8 @@ static void test_acpi_aarch64_virt_tcg_pxb(void)
>>>        * to solve the conflicts.
>>>        */
>>>       data.variant = ".pxb";
>>> -    test_acpi_one(" -device pcie-root-port,chassis=1,id=pci.1"
>>> +    test_acpi_one(" -machine acpi-pcihp=off"
>>> +                  " -device pcie-root-port,chassis=1,id=pci.1"
>>>                     " -device virtio-scsi-pci,id=scsi0,bus=pci.1"
>>>                     " -drive file="
>>>                     "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2,"
>>> @@ -1846,7 +1848,7 @@ static void test_acpi_aarch64_virt_tcg_acpi_hmat(void)
>>>   
>>>       data.variant = ".acpihmatvirt";
>>>   
>>> -    test_acpi_one(" -machine hmat=on"
>>> +    test_acpi_one(" -machine hmat=on,acpi-pcihp=off"
>>>                     " -cpu cortex-a57"
>>>                     " -smp 4,sockets=2"
>>>                     " -m 384M"
>>> @@ -2123,6 +2125,7 @@ static void test_acpi_aarch64_virt_tcg(void)
>>>       data.smbios_cpu_max_speed = 2900;
>>>       data.smbios_cpu_curr_speed = 2700;
>>>       test_acpi_one("-cpu cortex-a57 "
>>> +                  "-machine acpi-pcihp=off "
>>>                     "-smbios type=4,max-speed=2900,current-speed=2700", &data);
>>>       free_test_data(&data);
>>>   }
>>> @@ -2142,6 +2145,7 @@ static void test_acpi_aarch64_virt_tcg_topology(void)
>>>       };
>>>   
>>>       test_acpi_one("-cpu cortex-a57 "
>>> +                  "-machine acpi-pcihp=off "
>>>                     "-smp sockets=1,clusters=2,cores=2,threads=2", &data);
>>>       free_test_data(&data);
>>>   }
>>> @@ -2227,6 +2231,7 @@ static void test_acpi_aarch64_virt_viot(void)
>>>       };
>>>   
>>>       test_acpi_one("-cpu cortex-a57 "
>>> +                  "-machine acpi-pcihp=off "
>>>                     "-device virtio-iommu-pci", &data);
>>>       free_test_data(&data);
>>>   }
> 


