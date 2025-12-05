Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7605CD33992
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 17:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRZGJ-0001xw-3W; Fri, 05 Dec 2025 12:06:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vRZGG-0001wS-0Y
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 12:06:28 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vRZGD-0002RG-HB
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 12:06:27 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2984dfae043so24530835ad.0
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 09:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764954384; x=1765559184; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k17l8Cc7WuQ/1u1XVBIjYLjCHRCVIIrINmW4ZtHh7CA=;
 b=wrNr2QHQILNHMPAiUehOQJqj9QmqMNR9uNmifBBS0TNVKNCMoxQUepOSKp0jwEHtTV
 TXkwSTt2gQ4P3U+M+BAZy0CH9ex8ufCXK3Fu+9CGfp+0s3sgQ3DCqYgV93thL93ti3Qe
 VFFqRt6zZ7r4IMJpxkPQuvF+PDiAt0XJO8wu99hn3M/PmHMOMz7DolTGAuuGoCcLAgbf
 j4NBR5b9BGqoj7V8iCLj8xnx6UaKUExrKJ7g81VmnwuWzIOsXamGjAfOmidYWE0D9v4l
 AtTmfOh3HK2qSvf8add1jbfBeAs63l4lMw9PqNVbbrV68plsRPx+tjoDIl9VcGdxBURS
 bg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764954384; x=1765559184;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k17l8Cc7WuQ/1u1XVBIjYLjCHRCVIIrINmW4ZtHh7CA=;
 b=EC7W3n9k4CoU6tmvmFL4CQDGyKn0pFrrZkYXFrjOpxcTfAHBm2C67oFtXKXR3w7Np8
 dZDS+oCJv/PKZnhEHnc/XY2nXMHkbg+sp3jlSwzQEFnFVguCbwDXHaiYDbT0wKeMHZt2
 8zaOcqI9abz2VTHnH9Fno+MEm8RpZ7pcWAdEac4CoOmcVB4ZYyxLE2br8AYGTeEeXkzT
 WAU3kSnVn3yxfb+x+GwFCGGFXUxq5PzSmVmDqv5yxSKVk4nWd59MRgEcRDBZRRJdDveN
 JGErYjE+gRmd7wbKyUHENuFtAhRcANPwQHgXUtWy3YJpcDMQO4vBCw+/ylct2Z0iEiyS
 a+pg==
X-Gm-Message-State: AOJu0Yy2T36CBivjQ043soUty1S7mSJk/mpyW3HO0FiHpkoEAuTNz406
 WtkIbwLxiPMRPR6nBTOF/oYw1m/RuzmxPRmKB/lWFKQ84u0q8VwV02bA20MRBTsRmV4=
X-Gm-Gg: ASbGncsNJV2DLFAdUOgKjQwns6qxklEb8dClDvVJ+VpBFDvhvOg1KUfnfNDrXhmjODj
 MymGJN1dzbyfa6CLPRz3wBe9saOBGQaLhhliBT5lmgwZa52bIBoHMZhOX98WnUGbLznBkph2U5x
 k6z00vs5yrT0F+JJGKDuGwHWl16BJ2ClkTezaaVmzbl9SC21f7SC+BDY8qDU18ZOtw24ST2GyIA
 K+kAjWEba6jogPMjMskHoT6gt5/bAV94Q+5rGt+xCiQShmhF+saODW5FCWgse64EvebbGfwVMhi
 ep31dIQ2Z5EbzYUN4mNesg11KcM7ZXdE3k891arh8tM5BH/6ODa0GTK8Yakv2NVZ7ZIRSKoespZ
 sHSOnrYLQLA5R13isMUpal9WMgj0x9iza9ndxC0zmgxFUMPxWql+yAxhEXEVWRyZhHgX0btYPy/
 Wsr8D74XSGF7GuRY8oVbdM1ov0nk8KRoGlVdpeCrmcZHnKfnw+8Zu+tDU=
X-Google-Smtp-Source: AGHT+IF2k5OGL9SAEAu2R2Ok2RyOweun/U70a8bFa9mCuhzXHBjv+4KsKa7IqsANUwxNIvY2t339Rg==
X-Received: by 2002:a17:90b:562f:b0:343:684c:f8ac with SMTP id
 98e67ed59e1d1-349125c16abmr10982861a91.8.1764954383416; 
 Fri, 05 Dec 2025 09:06:23 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3494e852262sm5231922a91.8.2025.12.05.09.06.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Dec 2025 09:06:23 -0800 (PST)
Message-ID: <8f5d0074-3fb9-4d44-99b7-e79b5dda9039@linaro.org>
Date: Fri, 5 Dec 2025 09:06:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC RESEND v5 4/4] tests/qtest: Add SMMUv3 bare-metal test using
 iommu-testdev
To: Tao Tang <tangtao1634@phytium.com.cn>, Paolo Bonzini
 <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20251126154547.1300748-1-tangtao1634@phytium.com.cn>
 <20251126154547.1300748-5-tangtao1634@phytium.com.cn>
 <5d37349b-fbc4-4964-a3e8-d937a64ae232@linaro.org>
 <7370070a-c569-4b77-bd1e-6fc749ba9c90@phytium.com.cn>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <7370070a-c569-4b77-bd1e-6fc749ba9c90@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

On 12/5/25 6:19 AM, Tao Tang wrote:
> Hi Pierrick,
> 
> On 2025/12/5 02:42, Pierrick Bouvier wrote:
>> On 11/26/25 7:45 AM, Tao Tang wrote:
>>> Add a qtest suite that validates ARM SMMUv3 translation without guest
>>> firmware or OS. The tests leverage iommu-testdev to trigger DMA
>>> operations and the qos-smmuv3 library to configure IOMMU translation
>>> structures.
>>>
>>> This test suite targets the virt machine and covers:
>>> - Stage 1 only translation (VA -> PA via CD page tables)
>>> - Stage 2 only translation (IPA -> PA via STE S2 tables)
>>> - Nested translation (VA -> IPA -> PA, Stage 1 + Stage 2)
>>> - Design to extended to support multiple security spaces
>>>       (Non-Secure, Secure, Root, Realm)
>>>
>>> Each test case follows this sequence:
>>> 1. Initialize SMMUv3 with appropriate command/event queues
>>> 2. Build translation tables (STE/CD/PTE) for the target scenario
>>> 3. Configure iommu-testdev with IOVA and DMA attributes via MMIO
>>> 4. Trigger DMA and validate successful translation
>>> 5. Verify data integrity through a deterministic write-read pattern
>>>
>>> This bare-metal approach provides deterministic IOMMU testing with
>>> minimal dependencies, making failures directly attributable to the SMMU
>>> translation path.
>>>
>>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>>> ---
>>>    tests/qtest/iommu-smmuv3-test.c | 114 ++++++++++++++++++++++++++++++++
>>>    tests/qtest/meson.build         |   1 +
>>>    2 files changed, 115 insertions(+)
>>>    create mode 100644 tests/qtest/iommu-smmuv3-test.c
>>>
>>> diff --git a/tests/qtest/iommu-smmuv3-test.c
>>> b/tests/qtest/iommu-smmuv3-test.c
>>> new file mode 100644
>>> index 0000000000..af438ecce0
>>> --- /dev/null
>>> +++ b/tests/qtest/iommu-smmuv3-test.c
>>> @@ -0,0 +1,114 @@
>>> +/*
>>> + * QTest for SMMUv3 with iommu-testdev
>>> + *
>>> + * This QTest file is used to test the SMMUv3 with iommu-testdev so
>>> that we can
>>> + * test SMMUv3 without any guest kernel or firmware.
>>> + *
>>> + * Copyright (c) 2025 Phytium Technology
>>> + *
>>> + * Author:
>>> + *  Tao Tang <tangtao1634@phytium.com.cn>
>>> + *
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "libqtest.h"
>>> +#include "libqos/pci.h"
>>> +#include "libqos/generic-pcihost.h"
>>> +#include "hw/pci/pci_regs.h"
>>> +#include "hw/misc/iommu-testdev.h"
>>> +#include "libqos/qos-smmuv3.h"
>>> +
>>> +#define DMA_LEN           4
>>> +
>>> +/* Test configurations for different SMMU modes and spaces */
>>> +static const QSMMUTestConfig base_test_configs[] = {
>>> +    {
>>> +        .trans_mode = QSMMU_TM_S1_ONLY,
>>> +        .sec_sid = QSMMU_SEC_SID_NONSECURE,
>>> +        .dma_iova = QSMMU_IOVA_OR_IPA,
>>> +        .dma_len = DMA_LEN,
>>> +        .expected_result = 0
>>> +    },
>>> +    {
>>> +        .trans_mode = QSMMU_TM_S2_ONLY,
>>> +        .sec_sid = QSMMU_SEC_SID_NONSECURE,
>>> +        .dma_iova = QSMMU_IOVA_OR_IPA,
>>> +        .dma_len = DMA_LEN,
>>> +        .expected_result = 0
>>> +    },
>>> +    {
>>> +        .trans_mode = QSMMU_TM_NESTED,
>>> +        .sec_sid = QSMMU_SEC_SID_NONSECURE,
>>> +        .dma_iova = QSMMU_IOVA_OR_IPA,
>>> +        .dma_len = DMA_LEN,
>>> +        .expected_result = 0
>>> +    }
>>> +};
>>> +
>>> +static QPCIDevice *setup_qtest_pci_device(QTestState *qts,
>>> QGenericPCIBus *gbus,
>>> +                                          QPCIBar *bar)
>>> +{
>>> +    uint16_t vid, did;
>>> +    QPCIDevice *dev = NULL;
>>> +
>>> +    qpci_init_generic(gbus, qts, NULL, false);
>>> +
>>> +    /* Find device by vendor/device ID to avoid slot surprises. */
>>> +    for (int s = 0; s < 32 && !dev; s++) {
>>> +        for (int fn = 0; fn < 8 && !dev; fn++) {
>>> +            QPCIDevice *cand = qpci_device_find(&gbus->bus,
>>> QPCI_DEVFN(s, fn));
>>> +            if (!cand) {
>>> +                continue;
>>> +            }
>>> +            vid = qpci_config_readw(cand, PCI_VENDOR_ID);
>>> +            did = qpci_config_readw(cand, PCI_DEVICE_ID);
>>> +            if (vid == IOMMU_TESTDEV_VENDOR_ID &&
>>> +                did == IOMMU_TESTDEV_DEVICE_ID) {
>>> +                dev = cand;
>>> +                g_test_message("Found iommu-testdev! devfn: 0x%x",
>>> cand->devfn);
>>> +            } else {
>>> +                g_free(cand);
>>> +            }
>>> +        }
>>> +    }
>>> +    g_assert(dev);
>>> +
>>> +    qpci_device_enable(dev);
>>> +    *bar = qpci_iomap(dev, 0, NULL);
>>> +    g_assert_false(bar->is_io);
>>> +
>>> +    return dev;
>>> +}
>>> +
>>> +static void test_smmuv3_translation(void)
>>> +{
>>> +    QTestState *qts;
>>> +    QGenericPCIBus gbus;
>>> +    QPCIDevice *dev;
>>> +    QPCIBar bar;
>>> +
>>> +    /* Initialize QEMU environment for SMMU testing */
>>> +    qts = qtest_init("-machine
>>> virt,acpi=off,gic-version=3,iommu=smmuv3 "
>>> +                     "-smp 1 -m 512 -cpu max -net none "
>>> +                     "-device iommu-testdev");
>>> +
>>> +    /* Setup and configure PCI device */
>>> +    dev = setup_qtest_pci_device(qts, &gbus, &bar);
>>> +    g_assert(dev);
>>> +
>>> +    /* Run the enhanced translation tests */
>>> +    g_test_message("### Starting SMMUv3 translation tests...###");
>>> +    qsmmu_translation_batch(base_test_configs,
>>> ARRAY_SIZE(base_test_configs),
>>> +                            qts, dev, bar, VIRT_SMMU_BASE);
>>> +    g_test_message("### SMMUv3 translation tests completed
>>> successfully! ###");
>>> +    qtest_quit(qts);
>>> +}
>>> +
>>> +int main(int argc, char **argv)
>>> +{
>>> +    g_test_init(&argc, &argv, NULL);
>>> +    qtest_add_func("/iommu-testdev/translation",
>>> test_smmuv3_translation);
>>
>> Just a simple organization remark, maybe it would be better to have
>> separate tests for each translation setup. It's easier to review in
>> case a failure is found.
>> test_smmuv3_translation could be modified to add a QSMMUTestConfig
>> parameter, and new entry points could be used to define the three setup.
>> What do you think?
>>
>>> +    return g_test_run();
>>> +}
>>> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
>>> index 669d07c06b..e2d2e68092 100644
>>> --- a/tests/qtest/meson.build
>>> +++ b/tests/qtest/meson.build
>>> @@ -263,6 +263,7 @@ qtests_aarch64 = \
>>>       config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ?
>>> ['tpm-tis-i2c-test'] : []) + \
>>>      (config_all_devices.has_key('CONFIG_ASPEED_SOC') ?
>>> qtests_aspeed64 : []) + \
>>>      (config_all_devices.has_key('CONFIG_NPCM8XX') ? qtests_npcm8xx :
>>> []) + \
>>> +  (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') ?
>>> ['iommu-smmuv3-test'] : []) + \
>>>      qtests_cxl + \
>>>      ['arm-cpu-features',
>>>       'numa-test',
>>
>> I ran this qtest, and checked with a coverage enabled build that it
>> was triggering associated code in smmuv3 implementation.
>>
>> Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>
>> For a first version that's great. Later, we might want to generate
>> faults as well, to see that SMMU is correctly reporting an error on
>> incorrect transactions.
>>
>> I don't mind having a complex qos-smmuv3.c with gory details, since we
>> have a clear test here, that is easy to understand and modify.
>>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> 
> Thanks a lot for the review, the test, and the suggestion.
> 
> 
> To be honest, when I wrote the initial version I didn’t really think
> about splitting the tests per mode. I was instead worrying about how to
> correctly call `qsmmu_cleanup_translation` after each translation mode
> to flush all SMMU caches so that the next mode wouldn’t be affected by
> leftover state. Your suggestion of separate test functions actually
> makes this a lot cleaner: each test starts from a fresh QEMU/SMMU state,
> and I don’t need to overthink the cleanup between different modes.
>

I agree with you. The last thing we want is to debug a transient state 
that was not correctly reset. As well, we can remove all the cleanup code.

> 
> I'll refactor test_smmuv3_translation code a bit, but leave everything
> else the same. The refactoring code will be like:
> 
> 
> static void test_smmuv3_ns_s1_only(void)
> {
>       run_smmuv3_translation(&base_test_configs[0]);
> }
> 
> static void test_smmuv3_ns_s2_only(void)
> {
>       run_smmuv3_translation(&base_test_configs[1]);
> }
> 
> static void test_smmuv3_ns_nested(void)
> {
>       run_smmuv3_translation(&base_test_configs[2]);
> }

At this point, you can probably put the config directly in each 
function, having a global array (base_test_configs) does not bring any 
specific value.

> 
> int main(int argc, char **argv)
> {
>       g_test_init(&argc, &argv, NULL);
>       qtest_add_func("/iommu-testdev/translation/ns-s1-only",
>                      test_smmuv3_ns_s1_only);
>       qtest_add_func("/iommu-testdev/translation/ns-s2-only",
>                      test_smmuv3_ns_s2_only);
>       qtest_add_func("/iommu-testdev/translation/ns-nested",
>                      test_smmuv3_ns_nested);
>       return g_test_run();
> }
> 

Looks great like this.

> 
> Thanks again for running the coverage build and for the hint about
> adding fault-oriented tests; I’ll look into extending qos-smmuv3 in that
> direction as a follow-up.
>

You're welcome. To be honest, that's the only way to prove we correctly 
exercise the code. As the setup is quite complicated and needs specific 
SMMU magic, observe coverage is the simplest way to make sure it 
exercise what we want.
As well, coverage can be used in the future to check which part of the 
smmu implementation is not covered by unit tests, so it will be easy to 
enhance them.

Overall, the direction you took with this is good and it will be a 
useful addition for SMMU related work.

> Best regards,
> Tao
> 


