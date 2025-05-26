Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1D3C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 13:57:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJYKo-0004mO-QK; Mon, 26 May 2025 09:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uJYKn-0004m4-4t
 for qemu-devel@nongnu.org; Mon, 26 May 2025 09:57:45 -0400
Received: from mail-vk1-xa41.google.com ([2607:f8b0:4864:20::a41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uJYKl-0004YK-1T
 for qemu-devel@nongnu.org; Mon, 26 May 2025 09:57:44 -0400
Received: by mail-vk1-xa41.google.com with SMTP id
 71dfb90a1353d-52dc131419cso399347e0c.2
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 06:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748267861; x=1748872661; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f4SqwSGApR646YlGwX9quEAS77jmoLnsqlENyfssXGc=;
 b=S9zOcBZhjcf5gRnRbaEXPC9F3tC5n9HoypFHRTRpJa07u/0DZ4SqZU/TF/ubwZKYWj
 4tTj2Is5jC4LljsEWf+acPvrNlkXuBejJwrIB1uTMOKPkNLSROv25DjFqGk+hefuf7Ak
 Dmu0bxPsUysHWKRfTIEsLrw3uvNBkQB60e2JSQlqB9R51JKcelAMpychsop20+IZJApG
 ElgdqaFbLZnHLb+bwXts1egsr18XCr8Ozbm33Ha8gh30zCM+hp+pHyWlBbVPYLu2kQ+T
 AYY+2ji9h5+sS4HbjxKFzEA0q6EESLWjyz5G9Eelf+zrEVBWG/AIcfGGsZJVyWoupcpN
 4J3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748267861; x=1748872661;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f4SqwSGApR646YlGwX9quEAS77jmoLnsqlENyfssXGc=;
 b=VsN7J+YZ7P00xvXj83LHRgFEuaXEzyEXDcZ+OdhugBB+Edsx8BcP5YgsyfhLdOtHj+
 z2yIwslYwCCaVcE5UFL8FcOTO88LCQixy8EFAbVQGFCUG2JisfE3BvCLxD5HWMfGAied
 vY2QH9fxl9MXk66HUxSnUUzyvS/LaHipBKz65NY7FfqUFnj1iJ60Qnxs/nHUrUbyYXGe
 7c2FiKy33ErdwobiXcfGS2N5aX6Nl6cOAZWsmP7DQDOgfM+tl4UIM3DbPpBqFE1j8/J0
 21ow4ZZkOxkmKxyoSB5KSDbprP9w7HAuXHa/2lt0PpVMtLt8VjhJuCPU8XuDnqcdNqKz
 VzeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOPTlIOpLp702pktOwEsU7tbnhnH+a5loLFVZTrNrR1VoOit3XPKMjqCXZw+2jo3hYDdb/g9UC1fee@nongnu.org
X-Gm-Message-State: AOJu0YwykXLpD24BnxlFiekSrqseFnzy9ZO2V8Zxp5LZew4fDVHHLRKX
 OpEFBA4LKF7x/50RNybxr2uj+Yx0RUgriSJpunzCvq/TSdvqrU/g3st3A4T1/LNs+sE=
X-Gm-Gg: ASbGncs5CiDoEJ2VvcPy1B/evEyxkYZtA/ELuhzWzF6Cr/6bKjoSEWA3wHqOjPfJzCZ
 ymSp2H0dSTii6AyAWrW8ojsPH0m2kx5QhsSJbqx449Pijl07ydxNICLRFNAxZhuQAqsjeWkVgbc
 OeEpt/LMIF+G+iEazg1grgrn0EuEnj2yU1WS8ofBTlW6pOIYtQhi7sGTfxnaYZNY4HwCQNJlsvk
 ugur/TavYbGzdW3l6L1DHAugmWZsfpiXkplEDU6RQqsQ9cPDABlPLrITCGYmYltNi+nPYoKsin+
 4ktQAHMTyaFj+ykK7kd9GQyGigbMV4LhGm4xmwL5REgWazeXXP34H0XmkC5RX0se+YlxJbBdS6x
 9QythWKBFpu1uJzWXle+CRqBrxj1pQw==
X-Google-Smtp-Source: AGHT+IECYSd1WD78IJWVxygsQmnXFf29sME0AuswPLdcC4ygeHS0nxxtVwopMIvzze7igi+k6px11Q==
X-Received: by 2002:a05:6122:6183:b0:52f:47de:3700 with SMTP id
 71dfb90a1353d-52f47de37a2mr788192e0c.5.1748267861584; 
 Mon, 26 May 2025 06:57:41 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b402:6ba2:d081:510e:25da:56a5?
 ([2804:7f0:b402:6ba2:d081:510e:25da:56a5])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-52dba910d62sm17610961e0c.10.2025.05.26.06.57.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 06:57:41 -0700 (PDT)
Message-ID: <bf0fca88-f113-4dfd-b217-8f9863e3a13c@linaro.org>
Date: Mon, 26 May 2025 10:56:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/22] ACPI PCI Hotplug support on ARM
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org
References: <20250514170431.2786231-1-eric.auger@redhat.com>
 <6b7b0e20-546b-4b72-9489-4468fafb76ba@linaro.org>
 <2fe04c2b-d631-4ea5-9703-d44e50e13016@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <2fe04c2b-d631-4ea5-9703-d44e50e13016@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a41;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vk1-xa41.google.com
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

On 5/26/25 07:21, Eric Auger wrote:
> Hi Gustavo,
> 
> On 5/26/25 7:55 AM, Gustavo Romero wrote:
>> Hi Eric,
>>
>> On 5/14/25 14:00, Eric Auger wrote:
>>> This series enables ACPI PCI hotplug/hotunplug on ARM
>>> and makes it default for 10.1 machine type. This aligns with
>>> x86 q35 machine. Expected benefits should be similar to
>>> those listed in [1].
>>>
>>> It is still possible to disable it using a virt machine
>>> option: virt,acpi-pcihp=off and restore the legacy behavior.
>>>
>>> The infrastructure used in x86 is heavily reused and a
>>> huge part of the series consists in moving code from
>>> hw/i386/acpi-build.c to a generic place and slightly
>>> adapting it to make it usable on ARM. The DSDT table is
>>> augmented to support ACPI PCI hotplug elements.
>>>
>>> On ARM we use use a GED event to notify the OS about
>>> hotplug events.
>>>
>>> I have not noticed any tests/qtest/bios-tables-test failures
>>> neither on x86 nor ARM. x86 DSDT table has not changed.
>>> ARM DSDT table definitively has but there are no tests
>>> impacted. ARM misses hotplug tests that do exist on x86. This
>>> most probably should be considered in the future.
>>
>> I've just posted a v1 for a acpi-pcihp=on test:
>>
>> https://mail.gnu.org/archive/html/qemu-devel/2025-05/msg05824.html
>>
>> The odd thing is that I noticed failures in the existing aarch64
>> acpi tests in tests/qtest/bios-tables-test. At least the rename
>> of the variable 'CTRL' to 'Local0' in the _OSC method should cause
>> a mismatch against the current base DSDT? So I had to handle it
>> via patches 1/5, 2/5, and 3/5. The diff is in the 3/5 commit body.
> 
> Thank you for contributing those tests.
> 
> Hum I think my mistake was to have executed the existing tests in KVM
> acceleration mode only using
> QTEST_QEMU_BINARY=qemu-system-aarch64 tests/qtest/bios-tables-test
> direct execution.
> 
> The failing tests belong to the TCG category I think.
> 
> I will review your tests and if you allow me I may need to include
> patches 1 and 3 in my series to prevent existing tests from failing, of
> course with all your credits.

Yeah, absolutely!

I left some comments on you comments in 3/5 in [0] about the organization
and sequence of the patches, but I think we're in sync :)

[0] https://mail.gnu.org/archive/html/qemu-devel/2025-05/msg05824.html


> Thank you again for reporting the issue!

Np! Glad to help :)


Cheers,
Gustavo
  
> Eric
> 
> 
> 
> 
>>
>> Cheers,
>> Gustavo
>>
>>> Best Regards
>>>
>>> Eric
>>>
>>> This series can be found at:
>>> https://github.com/eauger/qemu/tree/arm-acpi-pcihp-v1
>>>
>>> previous RFC:
>>> https://github.com/eauger/qemu/tree/arm-acpi-pcihp-rfc
>>>
>>> History:
>>> RFC -> v1:
>>> - First 3 trivial patches were pulled separately
>>> - Fix of the register region size (0x18), ie. ACPI_PCIHP_SIZE
>>> - addition of aml_pci_edsm which was not called in RFC
>>> - acpi-index feature is now fixed. vms->bus was not set on
>>>     acpi_pcihp_init. The init sequence is still hacky though. Suggestions
>>>     appreciated.
>>>
>>> [1] [PATCH v6 0/6] Use ACPI PCI hot-plug for Q35
>>> https://lore.kernel.org/all/20210713004205.775386-1-jusual@redhat.com/
>>>
>>>
>>> Eric Auger (22):
>>>     hw/i386/acpi-build: Make aml_pci_device_dsm() static
>>>     hw/arm/virt: Introduce machine state acpi pcihp flags and props
>>>     hw/acpi: Rename and move build_x86_acpi_pci_hotplug to pcihp
>>>     hw/pci-host/gpex-acpi: Add native_pci_hotplug arg to
>>>       acpi_dsdt_add_pci_osc
>>>     hw/pci-host/gpex-acpi: Split host bridge OSC and DSM generation
>>>     hw/pci-host/gpex-acpi: Propagate hotplug type info from virt machine
>>>       downto gpex
>>>     hw/i386/acpi-build: Turn build_q35_osc_method into a generic method
>>>     hw/pci-host/gpex-acpi: Use build_pci_host_bridge_osc_method
>>>     hw/i386/acpi-build: Introduce build_append_pcihp_resources() helper
>>>     hw/acpi/pcihp: Add an AmlRegionSpace arg to build_acpi_pci_hotplug
>>>     hw/i386/acpi-build: Move build_append_notification_callback to pcihp
>>>     hw/i386/acpi-build: Move build_append_pci_bus_devices/pcihp_slots to
>>>       pcihp
>>>     hw/i386/acpi-build: Introduce and use acpi_get_pci_host
>>>     hw/i386/acpi-build: Move aml_pci_edsm to a generic place
>>>     hw/arm/virt-acpi-build: Modify the DSDT ACPI table to enable ACPI PCI
>>>       hotplug
>>>     hw/acpi/ged: Prepare the device to react to PCI hotplug events
>>>     hw/acpi/ged: Call pcihp plug callbacks in hotplug handler
>>>       implementation
>>>     hw/acpi/ged: Support migration of AcpiPciHpState
>>>     hw/core/sysbus: Introduce sysbus_mmio_map_name() helper
>>>     hw/arm/virt: Let virt support pci hotplug/unplug GED event
>>>     hw/arm/virt: Plug pcihp hotplug/hotunplug callbacks
>>>     hw/arm/virt: Use ACPI PCI hotplug by default
>>>
>>>    hw/i386/acpi-build.h                   |   4 -
>>>    include/hw/acpi/aml-build.h            |   2 +
>>>    include/hw/acpi/generic_event_device.h |   5 +
>>>    include/hw/acpi/pci.h                  |   4 +-
>>>    include/hw/acpi/pcihp.h                |  19 +-
>>>    include/hw/arm/virt.h                  |   4 +
>>>    include/hw/pci-host/gpex.h             |   1 +
>>>    include/hw/sysbus.h                    |   1 +
>>>    hw/acpi/aml-build.c                    |  50 +++
>>>    hw/acpi/generic_event_device.c         |  55 +++
>>>    hw/acpi/pci.c                          |  20 +
>>>    hw/acpi/pcihp.c                        | 482 ++++++++++++++++++++-
>>>    hw/arm/virt-acpi-build.c               |  27 ++
>>>    hw/arm/virt.c                          | 107 ++++-
>>>    hw/core/sysbus.c                       |  11 +
>>>    hw/i386/acpi-build.c                   | 552 +------------------------
>>>    hw/pci-host/gpex-acpi.c                |  75 +---
>>>    hw/arm/Kconfig                         |   2 +
>>>    18 files changed, 806 insertions(+), 615 deletions(-)
>>>
>>
> 


