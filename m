Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE11D29FAE
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 18:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vREI3-0002V8-B6; Thu, 04 Dec 2025 13:42:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vREI0-0002T7-7E
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 13:42:52 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vREHy-0000po-8G
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 13:42:51 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7b7828bf7bcso1455253b3a.2
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 10:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764873768; x=1765478568; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YsJQ5D4vNAWIRdjPDTSlZmsE2moVrekcWXP/PsnIE2o=;
 b=U3Ik2cTilaVMoeW0LvZPdTyuf2IqMXDEHMJ9qxLa8aheZyWY9xiDk6RQAnaNRfVkDX
 UTaIiANEyWvTw2GZy7cX1rnNAkYSc6pvmgkovcy+NtNuahuCsmzs4JJwsFgBQkY/f//S
 bC2ahvPmvxZUw8surDGNACvqQiIEID3Vfl2ah6+BvtCWyDigvkYE77TQCDemUC/hO/Yy
 26YylGsW4FQZlZnk9HfWqS1OEHlzhLLzxxH2+XnHXN2gG7vl1rbRiLKsAkMiAMWMXoOq
 vWvRaCp384uvk76vXUAWL8jjj1VpqhuVXJDpncFQ/V/7QepoqR1fcj9T3222f8oEpuMM
 BszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764873768; x=1765478568;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YsJQ5D4vNAWIRdjPDTSlZmsE2moVrekcWXP/PsnIE2o=;
 b=RzsVVx3+K+7CCF0RYLphfAXzH4k5EWxwRDBJx4YLiDtqK3gbl+XturglfTy+nNNZLI
 o3QtdTceslIaFaHKGavgWow/cO2wBP2CUM2PcGPTixeYxmajxhaBarkI/C7YT4ov82/u
 wMq3mqdOCfhHa4xKV/BJP6BymAf3P64Asi4bcIEHNFUTzmtD3DubHnnzT2NZ4QonhmLG
 XB8Y27M5/el5BFJnPaAEAZevCbiaE0/FawjF14BqmKoig5KuomHFPhJo4qMjrHe3vJtW
 R4Lph6A21VqL1gVOOIHQ9gisZO75DJCmdG3WfKtEsoWOZne4je6FwOP6aXnKuSGrTRyZ
 to6A==
X-Gm-Message-State: AOJu0YyTShN/zGpTRYClYb/5Ar6SgO0WRQ2Wb20QbxaBnKpToyXQmP1F
 Q1Ft45cDkGNsDJvLJo6Pc6VTuMRKaWUNvRpyulkh2Sg2DGDndAsnlsYgJyTJy8sr/lw=
X-Gm-Gg: ASbGncvrUynF6j0gDa0LxBfBOppyK7H1v+YcIyMPTMRoKYCpPGG4X7EOsGGOxO7nVg9
 FDkGrXlJkfHFppHMTPrbHQE0qvYwV+mOrA06h6WM+E3CZNPwRjZ6Q+qqWTcqCwHddzcmL2bTuK/
 DfBjggHilvI2oqF8TjRRIiRqtEdmpmXk9cZJPLTPuMQznrSFQ1yNTUIyS3IPo9Pe8s0Tmfoy0K4
 WRy0ZrmIL+DgmZzOYvvslwvofJc/fBBoEKr8fCSgFOKxP+vuyyyRZHYeqAPt2JPPR8J6DveOcr1
 4dXNqohcYr6iRwty/zObnRN67tbsIKXLjrj107Qq+sHVvR8WMd3+PO8UpvAwJiy7AByVIOwScwB
 vSFVQZ/+FYhEdWmBPMt1PHPZgw33k6mFrcFhVdPWIl11pLB3eBURsK69YzqchGNtdXiEukWqz+r
 ezqbMqpLMu3QpeeeFdOt32KhoeFW5Fo1fHBYPIEQN9qOXSCjlRS99SQXM=
X-Google-Smtp-Source: AGHT+IGgN4/8iSZn+U+KY79AqGavjTWBYfZFO/2a+dd1+YL67QOSG2pAyQyCjcLCr0ThWSoxHJUlCA==
X-Received: by 2002:a05:6300:218f:b0:35a:80f2:fa3c with SMTP id
 adf61e73a8af0-363f5e522f3mr8773452637.31.1764873768223; 
 Thu, 04 Dec 2025 10:42:48 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7e2af939330sm2846210b3a.64.2025.12.04.10.42.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 10:42:47 -0800 (PST)
Message-ID: <5d37349b-fbc4-4964-a3e8-d937a64ae232@linaro.org>
Date: Thu, 4 Dec 2025 10:42:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC RESEND v5 4/4] tests/qtest: Add SMMUv3 bare-metal test using
 iommu-testdev
Content-Language: en-US
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
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251126154547.1300748-5-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

On 11/26/25 7:45 AM, Tao Tang wrote:
> Add a qtest suite that validates ARM SMMUv3 translation without guest
> firmware or OS. The tests leverage iommu-testdev to trigger DMA
> operations and the qos-smmuv3 library to configure IOMMU translation
> structures.
> 
> This test suite targets the virt machine and covers:
> - Stage 1 only translation (VA -> PA via CD page tables)
> - Stage 2 only translation (IPA -> PA via STE S2 tables)
> - Nested translation (VA -> IPA -> PA, Stage 1 + Stage 2)
> - Design to extended to support multiple security spaces
>      (Non-Secure, Secure, Root, Realm)
> 
> Each test case follows this sequence:
> 1. Initialize SMMUv3 with appropriate command/event queues
> 2. Build translation tables (STE/CD/PTE) for the target scenario
> 3. Configure iommu-testdev with IOVA and DMA attributes via MMIO
> 4. Trigger DMA and validate successful translation
> 5. Verify data integrity through a deterministic write-read pattern
> 
> This bare-metal approach provides deterministic IOMMU testing with
> minimal dependencies, making failures directly attributable to the SMMU
> translation path.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>   tests/qtest/iommu-smmuv3-test.c | 114 ++++++++++++++++++++++++++++++++
>   tests/qtest/meson.build         |   1 +
>   2 files changed, 115 insertions(+)
>   create mode 100644 tests/qtest/iommu-smmuv3-test.c
> 
> diff --git a/tests/qtest/iommu-smmuv3-test.c b/tests/qtest/iommu-smmuv3-test.c
> new file mode 100644
> index 0000000000..af438ecce0
> --- /dev/null
> +++ b/tests/qtest/iommu-smmuv3-test.c
> @@ -0,0 +1,114 @@
> +/*
> + * QTest for SMMUv3 with iommu-testdev
> + *
> + * This QTest file is used to test the SMMUv3 with iommu-testdev so that we can
> + * test SMMUv3 without any guest kernel or firmware.
> + *
> + * Copyright (c) 2025 Phytium Technology
> + *
> + * Author:
> + *  Tao Tang <tangtao1634@phytium.com.cn>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "libqos/pci.h"
> +#include "libqos/generic-pcihost.h"
> +#include "hw/pci/pci_regs.h"
> +#include "hw/misc/iommu-testdev.h"
> +#include "libqos/qos-smmuv3.h"
> +
> +#define DMA_LEN           4
> +
> +/* Test configurations for different SMMU modes and spaces */
> +static const QSMMUTestConfig base_test_configs[] = {
> +    {
> +        .trans_mode = QSMMU_TM_S1_ONLY,
> +        .sec_sid = QSMMU_SEC_SID_NONSECURE,
> +        .dma_iova = QSMMU_IOVA_OR_IPA,
> +        .dma_len = DMA_LEN,
> +        .expected_result = 0
> +    },
> +    {
> +        .trans_mode = QSMMU_TM_S2_ONLY,
> +        .sec_sid = QSMMU_SEC_SID_NONSECURE,
> +        .dma_iova = QSMMU_IOVA_OR_IPA,
> +        .dma_len = DMA_LEN,
> +        .expected_result = 0
> +    },
> +    {
> +        .trans_mode = QSMMU_TM_NESTED,
> +        .sec_sid = QSMMU_SEC_SID_NONSECURE,
> +        .dma_iova = QSMMU_IOVA_OR_IPA,
> +        .dma_len = DMA_LEN,
> +        .expected_result = 0
> +    }
> +};
> +
> +static QPCIDevice *setup_qtest_pci_device(QTestState *qts, QGenericPCIBus *gbus,
> +                                          QPCIBar *bar)
> +{
> +    uint16_t vid, did;
> +    QPCIDevice *dev = NULL;
> +
> +    qpci_init_generic(gbus, qts, NULL, false);
> +
> +    /* Find device by vendor/device ID to avoid slot surprises. */
> +    for (int s = 0; s < 32 && !dev; s++) {
> +        for (int fn = 0; fn < 8 && !dev; fn++) {
> +            QPCIDevice *cand = qpci_device_find(&gbus->bus, QPCI_DEVFN(s, fn));
> +            if (!cand) {
> +                continue;
> +            }
> +            vid = qpci_config_readw(cand, PCI_VENDOR_ID);
> +            did = qpci_config_readw(cand, PCI_DEVICE_ID);
> +            if (vid == IOMMU_TESTDEV_VENDOR_ID &&
> +                did == IOMMU_TESTDEV_DEVICE_ID) {
> +                dev = cand;
> +                g_test_message("Found iommu-testdev! devfn: 0x%x", cand->devfn);
> +            } else {
> +                g_free(cand);
> +            }
> +        }
> +    }
> +    g_assert(dev);
> +
> +    qpci_device_enable(dev);
> +    *bar = qpci_iomap(dev, 0, NULL);
> +    g_assert_false(bar->is_io);
> +
> +    return dev;
> +}
> +
> +static void test_smmuv3_translation(void)
> +{
> +    QTestState *qts;
> +    QGenericPCIBus gbus;
> +    QPCIDevice *dev;
> +    QPCIBar bar;
> +
> +    /* Initialize QEMU environment for SMMU testing */
> +    qts = qtest_init("-machine virt,acpi=off,gic-version=3,iommu=smmuv3 "
> +                     "-smp 1 -m 512 -cpu max -net none "
> +                     "-device iommu-testdev");
> +
> +    /* Setup and configure PCI device */
> +    dev = setup_qtest_pci_device(qts, &gbus, &bar);
> +    g_assert(dev);
> +
> +    /* Run the enhanced translation tests */
> +    g_test_message("### Starting SMMUv3 translation tests...###");
> +    qsmmu_translation_batch(base_test_configs, ARRAY_SIZE(base_test_configs),
> +                            qts, dev, bar, VIRT_SMMU_BASE);
> +    g_test_message("### SMMUv3 translation tests completed successfully! ###");
> +    qtest_quit(qts);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +    qtest_add_func("/iommu-testdev/translation", test_smmuv3_translation);

Just a simple organization remark, maybe it would be better to have 
separate tests for each translation setup. It's easier to review in case 
a failure is found.
test_smmuv3_translation could be modified to add a QSMMUTestConfig 
parameter, and new entry points could be used to define the three setup.
What do you think?

> +    return g_test_run();
> +}
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 669d07c06b..e2d2e68092 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -263,6 +263,7 @@ qtests_aarch64 = \
>      config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
>     (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 : []) + \
>     (config_all_devices.has_key('CONFIG_NPCM8XX') ? qtests_npcm8xx : []) + \
> +  (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') ? ['iommu-smmuv3-test'] : []) + \
>     qtests_cxl +                                                                                  \
>     ['arm-cpu-features',
>      'numa-test',

I ran this qtest, and checked with a coverage enabled build that it was 
triggering associated code in smmuv3 implementation.

Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

For a first version that's great. Later, we might want to generate 
faults as well, to see that SMMU is correctly reporting an error on 
incorrect transactions.

I don't mind having a complex qos-smmuv3.c with gory details, since we 
have a clear test here, that is easy to understand and modify.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

