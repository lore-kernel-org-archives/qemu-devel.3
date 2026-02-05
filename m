Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31536E9129A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 09:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnvV8-0006ji-PC; Thu, 05 Feb 2026 04:18:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <15fengyuan@gmail.com>)
 id 1vnvV7-0006iI-1b
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 04:18:13 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <15fengyuan@gmail.com>)
 id 1vnvV5-0006S3-1g
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 04:18:12 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-81f5381d168so851003b3a.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 01:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770283089; x=1770887889; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dNlmnXPHDMBBoepEow0M4rYTyowZw3ng6p31BZyPvHY=;
 b=ZPhnF1Xwq15NK8M8V8a9ZxVHpixGkTAvdMj9bwRds26lDrt7hzuyWVtsyZ9hfajJja
 3BtzYSNvmtn+oLq0T1tWVlFwVXxunTZcGKXQH2bfbw/NvPrvg1ALQam+BlveWU1bGlXs
 9iSXyRr48kwgVqts48EgwZFESP7ZVVNGPJcc01+GgY6n9mD+MG13Eb1HKY2pIlOEA5fE
 g7MUnxaQD09Gb11DBXGY8Y66gDnO6vwzkCIQIOp/9ugMrufPpk20bAAxAq6ouOm96Q3E
 IxGb3zmRWca87r5CeDdydZmtnVZHqAb43UQfIWGlVsN/+aA+1+uLxCYkvOvg9v3Djv0g
 lCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770283089; x=1770887889;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dNlmnXPHDMBBoepEow0M4rYTyowZw3ng6p31BZyPvHY=;
 b=S9JtUJQIvTYvR8/lq9IJ/U1xTJqP41zAbIBpoFZyabG34tPHFTZmXx7CtCVLFvIVJS
 DKrM2PysaKIZfKqDz9Qa7NDjsGzIxtAlskBb1qvYUWicFyvXDpTtDGOobpKDrP25hYTf
 Q4OJjz1pTPDsDsbjt1ORIaZL+Mq3L4GDEK+4Kvwyt0ZCyd6S6plwCHjmHWZt5jDCZj/0
 iX4yq4pe27fcsfomyBdeQBYx50lKApDp0h67vTR30UZTELtJvwGI/KpSVApcUMKZatQB
 sFa2GgVHyKW1XrZWzS54Oob+LBVWVAdpvGcL7MtQ8m75K8w4jlnRBSmsv8/rzRlixSIZ
 7y9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrgj3agNBomzQ05e/mARysKVBCDmSr7bxWYVmOxklZnbm4Fla9utX3j0SQTpJVp4eAkF1EV67QH83t@nongnu.org
X-Gm-Message-State: AOJu0YwN6k393EqgvObZnXr1w3nKEaNskhnGa5FeJYJFAk4oaGqhMmxe
 TZ9r96uxmmfBDiCC13Sa2Ht5q3SMT3LxVf7qHHZx5f+sFutYN6GbCqke
X-Gm-Gg: AZuq6aIysa5L7hdsbYY4VjWeL2jzp1lo+Jl+fbCWYvqczXqSKWHjz7wRiYxHesJVSXO
 CI03+CGL9UHBpQXDmTWY+rfa5HZX9dKD+OOu+ve651khqxnBiEp9E0gf5ieqY85ae/C0VwB5qdC
 CKm3iNQ781XPSbLPQeP9UP6cjJXVpbyYb4WvoVtZwauabPgHz6fswd9sw6SOvseJhRrTEYyJPD0
 h2z+F+MjGrp7aho9aJmX700GA/7CgCW8bnNQaXtP7o6LoxWBc30jNLwnRNaOjTZ9+oy0IxZPSRX
 wh0d59zoIwVfz/gs85WaY2iqWfZ7mF8usTlDH7XWZ0MeXk0npZo4QuZdmRymDlO9tMZbcqCth7q
 bXx/25bCL+YTQS1+lWMjjW/RH5QoSmXgoYvGKob5fl433TTuzJAu9ULOl6kCjcm/9WiqO7pcyTG
 r39wtU7nShIBUQi2Aq0/UAneGb41AikzHu6duGwnF525yhxSrKKDWbLfsrBSWb5PL0VVc=
X-Received: by 2002:a05:6a00:4395:b0:81f:3d13:e079 with SMTP id
 d2e1a72fcca58-8241c4c47abmr5982179b3a.45.1770283088907; 
 Thu, 05 Feb 2026 01:18:08 -0800 (PST)
Received: from ?IPV6:240e:468:788:182d:c9a0:5302:cea5:79d2?
 ([240e:468:788:182d:c9a0:5302:cea5:79d2])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8241d478975sm4824245b3a.52.2026.02.05.01.18.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 01:18:08 -0800 (PST)
Message-ID: <447b5270-586b-4d14-b1a8-7bba9e084491@gmail.com>
Date: Thu, 5 Feb 2026 17:18:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 2/2] tests/qtest: Add Intel IOMMU bare-metal test
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Tao Tang <tangtao1634@phytium.com.cn>,
 qemu-devel@nongnu.org
References: <cover.1770172615.git.15fengyuan@gmail.com>
 <89909ddad9c2b887056344bb93e5407e3639980d.1770172615.git.15fengyuan@gmail.com>
 <aYL4qVS1IEbcoPL2@ZEVORN-PC>
From: Fengyuan <15fengyuan@gmail.com>
In-Reply-To: <aYL4qVS1IEbcoPL2@ZEVORN-PC>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=15fengyuan@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Chao,

Thanks for the review!

On 2/4/2026 3:43 PM, Chao Liu wrote:
> Hi Fengyuan,
> 
> On Wed, Feb 04, 2026 at 11:06:20AM +0800, Fengyuan Yu wrote:
>> Add a qtest suite for the Intel IOMMU (VT-d) device on the Q35 machine.
>> The test exercises pass-through and translated translation modes using
>> iommu-testdev and the qos-intel-iommu helpers.
>>
>> The test validates:
>> - Root Entry Table and Context Entry Table configuration
>> - 4-level page table walks for 48-bit address translation
>> - Pass-through mode (identity mapping)
>> - Translated mode with complete IOVA-to-PA translation
>> - DMA transaction execution with memory content verification
>>
> Good commit message.
> 
>> Signed-off-by: Fengyuan Yu <15fengyuan@gmail.com>
>> ---
>>   tests/qtest/iommu-intel-test.c | 137 +++++++++++++++++++++++++++++++++
>>   tests/qtest/meson.build        |   2 +
>>   2 files changed, 139 insertions(+)
>>   create mode 100644 tests/qtest/iommu-intel-test.c
>>
>> diff --git a/tests/qtest/iommu-intel-test.c b/tests/qtest/iommu-intel-test.c
>> new file mode 100644
>> index 0000000000..9f631be2c5
>> --- /dev/null
>> +++ b/tests/qtest/iommu-intel-test.c
>> @@ -0,0 +1,137 @@
>> +/*
>> + * QTest for Intel IOMMU (VT-d) with iommu-testdev
>> + *
>> + * This QTest file is used to test the Intel IOMMU with iommu-testdev so that
>> + * we can test VT-d without any guest kernel or firmware.
>> + *
>> + * Copyright (c) 2026 Fengyuan Yu <15fengyuan@gmail.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "libqtest.h"
>> +#include "libqos/pci.h"
>> +#include "libqos/pci-pc.h"
>> +#include "hw/pci/pci_regs.h"
>> +#include "hw/misc/iommu-testdev.h"
>> +#include "libqos/qos-intel-iommu.h"
>> +
>> +#define DMA_LEN           4
>> +
>> +/* Test configurations for different Intel IOMMU modes */
>> +static const QVTDTestConfig base_test_configs[] = {
>> +    {
>> +        .trans_mode = QVTD_TM_LEGACY_PT,
>> +        .dma_iova = 0x10100000,  /* Use address in guest RAM range (inside 512MB) */
>> +        .dma_pa = 0x10100000,
>> +        .dma_len = DMA_LEN,
>> +        .expected_result = 0,
>> +        .domain_id = 1,
>> +    },
>> +    {
>> +        .trans_mode = QVTD_TM_LEGACY_TRANS,
>> +        .dma_iova = QVTD_TEST_IOVA,
>> +        .dma_pa = QVTD_TEST_PA,
>> +        .dma_len = DMA_LEN,
>> +        .expected_result = 0,
>> +        .domain_id = 1,
>> +    },
>> +};
>> +
>> +static QPCIDevice *setup_qtest_pci_device(QTestState *qts, QPCIBus **pcibus,
>> +                                          QPCIBar *bar)
>> +{
>> +    uint16_t vid, did;
>> +    QPCIDevice *dev = NULL;
>> +    int device_count = 0;
>> +
>> +    *pcibus = qpci_new_pc(qts, NULL);
>> +    g_assert(*pcibus != NULL);
>> +
>> +    g_test_message("Scanning PCI bus for iommu-testdev (vendor:device = 0x%04x:0x%04x)...",
>> +                   IOMMU_TESTDEV_VENDOR_ID, IOMMU_TESTDEV_DEVICE_ID);
>> +
>> +    /* Find device by vendor/device ID to avoid slot surprises. */
>> +    for (int s = 0; s < 32 && !dev; s++) {
>> +        for (int fn = 0; fn < 8 && !dev; fn++) {
>> +            QPCIDevice *cand = qpci_device_find(*pcibus, QPCI_DEVFN(s, fn));
>> +            if (!cand) {
>> +                continue;
>> +            }
>> +            vid = qpci_config_readw(cand, PCI_VENDOR_ID);
>> +            did = qpci_config_readw(cand, PCI_DEVICE_ID);
>> +
>> +            device_count++;
>> +            g_test_message("  Found PCI device at %02x:%x - vendor:device = 0x%04x:0x%04x",
>> +                           s, fn, vid, did);
>> +
>> +            if (vid == IOMMU_TESTDEV_VENDOR_ID &&
>> +                did == IOMMU_TESTDEV_DEVICE_ID) {
>> +                dev = cand;
>> +                g_test_message("Found iommu-testdev! devfn: 0x%x", cand->devfn);
>> +            } else {
>> +                g_free(cand);
>> +            }
>> +        }
>> +    }
>> +
> 
> This manual PCI bus scanning is verbose. The SMMUv3 test uses
> qpci_device_foreach() which is more concise:
> 
>      qpci_device_foreach(&gbus->bus, IOMMU_TESTDEV_VENDOR_ID,
>                          IOMMU_TESTDEV_DEVICE_ID, save_fn, &dev);
> 
> See iommu-smmuv3-test.c for reference.
> 
Thanks for the review. I'ill improve the PCI bus scanning in v2.

>> +    if (!dev) {
>> +        g_test_message("ERROR: iommu-testdev not found after scanning %d PCI devices", device_count);
>> +        g_test_message("Expected vendor:device = 0x%04x:0x%04x (PCI_VENDOR_ID_REDHAT:PCI_DEVICE_ID_REDHAT_TEST)",
>> +                       IOMMU_TESTDEV_VENDOR_ID, IOMMU_TESTDEV_DEVICE_ID);
>> +        qpci_free_pc(*pcibus);
>> +        *pcibus = NULL;
>> +        g_test_skip("iommu-testdev not found on PCI bus - device may not be compiled or registered");
>> +        return NULL;
>> +    }
>> +
>> +    /* Enable device - iommu-testdev only uses MMIO, not I/O ports */
>> +    uint16_t cmd = qpci_config_readw(dev, PCI_COMMAND);
>> +    cmd |= PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER;
>> +    qpci_config_writew(dev, PCI_COMMAND, cmd);
>> +
>> +    *bar = qpci_iomap(dev, 0, NULL);
>> +    g_assert_false(bar->is_io);
>> +
>> +    return dev;
>> +}
>> +
>> +static void test_intel_iommu_translation(void)
>> +{
>> +    QTestState *qts;
>> +    QPCIBus *pcibus;
>> +    QPCIDevice *dev;
>> +    QPCIBar bar;
>> +
> Please add a machine availability check before qtest_init(), similar to
> what the SMMUv3 test does:
> 
Thanks for the review. I'ill add this check in v2.

>      if (!qtest_has_machine("q35")) {
>          g_test_skip("q35 machine not available");
>          return;
>      }
> 
>> +    /* Initialize QEMU environment for Intel IOMMU testing */
>> +    qts = qtest_init("-machine q35,kernel-irqchip=split "
>> +                     "-accel tcg "
>> +                     "-device intel-iommu,pt=on,aw-bits=48 "
>> +                     "-device iommu-testdev,bus=pcie.0,addr=0x4 "
>> +                     "-m 512");
>> +
>> +    /* Setup and configure PCI device */
>> +    dev = setup_qtest_pci_device(qts, &pcibus, &bar);
>> +    if (!dev) {
>> +        qtest_quit(qts);
>> +        return;
>> +    }
>> +
>> +    /* Run the translation tests */
>> +    g_test_message("### Starting Intel IOMMU translation tests...###");
>> +    qvtd_translation_batch(base_test_configs, ARRAY_SIZE(base_test_configs),
>> +                           qts, dev, bar, Q35_IOMMU_BASE);
>> +    g_test_message("### Intel IOMMU translation tests completed successfully! ###");
>> +
>> +    g_free(dev);
>> +    qpci_free_pc(pcibus);
>> +    qtest_quit(qts);
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +    g_test_init(&argc, &argv, NULL);
>> +    qtest_add_func("/iommu-testdev/intel-translation", test_intel_iommu_translation);
> The test path naming differs from the SMMUv3 convention. For consistency,
> consider splitting into separate test functions and using paths like:
> 
>      qtest_add_func("/iommu-testdev/intel/legacy-pt", test_intel_legacy_pt);
>      qtest_add_func("/iommu-testdev/intel/legacy-trans", test_intel_legacy_trans);
> 
> This makes it easier to run individual test cases and debug failures.
> 
Thanks for the review. I will improve the test cases to make them consistent 
with the SMMUv3 implementation.

>> +    return g_test_run();
>> +}
> Missing newline at end of file. Please run scripts/checkpatch.pl check
> it.
> 
Thanks for the review. I will carefully use scripts/checkpatch.pl to review the 
v2 patch before submitting.

>> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
>> index e2d2e68092..344e836300 100644
>> --- a/tests/qtest/meson.build
>> +++ b/tests/qtest/meson.build
>> @@ -95,6 +95,8 @@ qtests_i386 = \
>>     (config_all_devices.has_key('CONFIG_SDHCI_PCI') ? ['fuzz-sdcard-test'] : []) +            \
>>     (config_all_devices.has_key('CONFIG_ESP_PCI') ? ['am53c974-test'] : []) +                 \
>>     (config_all_devices.has_key('CONFIG_VTD') ? ['intel-iommu-test'] : []) +                 \
>> +  (config_all_devices.has_key('CONFIG_VTD') and
>> +   config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') ? ['iommu-intel-test'] : []) +      \
>>     (host_os != 'windows' and                                                                \
>>      config_all_devices.has_key('CONFIG_ACPI_ERST') ? ['erst-test'] : []) +                   \
>>     (config_all_devices.has_key('CONFIG_PCIE_PORT') and                                       \
>> -- 
>> 2.39.5
>>
> 
> One more thing: the MAINTAINERS entry in patch 1/2 only adds the libqos
> files. Please also add to 'X86 general architecture support':
> 
>      F: tests/qtest/iommu-intel-test.c
> 
> to the IOMMU section.
> 
It seems that 'VT-d Emulation' is more appropriate. I will add it to 'VT-d 
Emulation' first.

Thanks,
Fengyuan

> Overall, this is a nice addition to the IOMMU testing infrastructure.
> 
> Thanks,
> Chao


