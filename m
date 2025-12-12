Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CFFD59D81
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 18:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU7bR-0004fP-6b; Fri, 12 Dec 2025 13:10:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vU7bP-0004ep-I8
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 13:10:51 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vU7bN-0000Lb-Na
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 13:10:51 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 297BE5BF81;
 Fri, 12 Dec 2025 18:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765563048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MBsx7Py/pWnooGYX/byZ5hQI97gsXqX2sQ0FwL2epQ4=;
 b=dYkuUGztUZGY4uXi2j9fzH6r+ubDhUwCgAbeSCbVhm2ViCU93i3xmSbyj6ROmw9ce4icyR
 F2Glliy6OjWE+zr1B+pFhELlJlQEzzPVZiasoIet0kc1kMPDG1Xc0g5t1SuC5RXMjgQkP5
 CtA0aeI2ZPkzwZPN9O5aFaMV423GuoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765563048;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MBsx7Py/pWnooGYX/byZ5hQI97gsXqX2sQ0FwL2epQ4=;
 b=Dxch1lfr2WKqMEPwuFylwDAuV0+YENclIgjjcWr+DIw/06qeMAVIfpQiz86tMRThY0DYVo
 t9o1FQKphyhr1PAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765563048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MBsx7Py/pWnooGYX/byZ5hQI97gsXqX2sQ0FwL2epQ4=;
 b=dYkuUGztUZGY4uXi2j9fzH6r+ubDhUwCgAbeSCbVhm2ViCU93i3xmSbyj6ROmw9ce4icyR
 F2Glliy6OjWE+zr1B+pFhELlJlQEzzPVZiasoIet0kc1kMPDG1Xc0g5t1SuC5RXMjgQkP5
 CtA0aeI2ZPkzwZPN9O5aFaMV423GuoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765563048;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MBsx7Py/pWnooGYX/byZ5hQI97gsXqX2sQ0FwL2epQ4=;
 b=Dxch1lfr2WKqMEPwuFylwDAuV0+YENclIgjjcWr+DIw/06qeMAVIfpQiz86tMRThY0DYVo
 t9o1FQKphyhr1PAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 983773EA63;
 Fri, 12 Dec 2025 18:10:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id q6WEFadaPGkEEAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 12 Dec 2025 18:10:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Tao Tang <tangtao1634@phytium.com.cn>, Paolo Bonzini
 <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eric Auger
 <eric.auger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Chen Baozi
 <chenbaozi@phytium.com.cn>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, Mostafa Saleh
 <smostafa@google.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: Re: [RFC v6 4/4] tests/qtest: Add SMMUv3 bare-metal test using
 iommu-testdev
In-Reply-To: <20251206155203.3015881-5-tangtao1634@phytium.com.cn>
References: <20251206155203.3015881-1-tangtao1634@phytium.com.cn>
 <20251206155203.3015881-5-tangtao1634@phytium.com.cn>
Date: Fri, 12 Dec 2025 15:10:44 -0300
Message-ID: <87ms3nvae3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWELVE(0.00)[15];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Tao Tang <tangtao1634@phytium.com.cn> writes:

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
>     (Non-Secure, Secure, Root, Realm)
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
> Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  tests/qtest/iommu-smmuv3-test.c | 131 ++++++++++++++++++++++++++++++++
>  tests/qtest/meson.build         |   1 +
>  2 files changed, 132 insertions(+)
>  create mode 100644 tests/qtest/iommu-smmuv3-test.c
>
> diff --git a/tests/qtest/iommu-smmuv3-test.c b/tests/qtest/iommu-smmuv3-test.c
> new file mode 100644
> index 0000000000..96f66ee325
> --- /dev/null
> +++ b/tests/qtest/iommu-smmuv3-test.c
> @@ -0,0 +1,131 @@
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

This loop could be replaced with something simpler:

  static void save_fn(QPCIDevice *dev, int devfn, void *data)
  {
      QPCIDevice **pdev = (QPCIDevice **) data;
      *pdev = dev;
  }

  qpci_device_foreach(&gbus->bus, IOMMU_TESTDEV_VENDOR_ID,
                      IOMMU_TESTDEV_DEVICE_ID, save_fn, &dev);

> +    g_assert(dev);
> +
> +    qpci_device_enable(dev);
> +    *bar = qpci_iomap(dev, 0, NULL);
> +    g_assert_false(bar->is_io);
> +
> +    return dev;
> +}
> +
> +static void run_smmuv3_translation(const QSMMUTestConfig *cfg)
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
> +    g_test_message("### SMMUv3 translation mode=%d sec_sid=%d ###",
> +                   cfg->trans_mode, cfg->sec_sid);
> +    qsmmu_run_translation_case(qts, dev, bar, VIRT_SMMU_BASE, cfg);
> +    qtest_quit(qts);
> +}
> +
> +static void test_smmuv3_ns_s1_only(void)
> +{
> +    QSMMUTestConfig cfg = {
> +        .trans_mode = QSMMU_TM_S1_ONLY,
> +        .sec_sid = QSMMU_SEC_SID_NONSECURE,
> +        .dma_iova = QSMMU_IOVA_OR_IPA,
> +        .dma_len = DMA_LEN,
> +        .expected_result = 0,
> +    };
> +
> +    run_smmuv3_translation(&cfg);
> +}
> +
> +static void test_smmuv3_ns_s2_only(void)
> +{
> +    QSMMUTestConfig cfg = {
> +        .trans_mode = QSMMU_TM_S2_ONLY,
> +        .sec_sid = QSMMU_SEC_SID_NONSECURE,
> +        .dma_iova = QSMMU_IOVA_OR_IPA,
> +        .dma_len = DMA_LEN,
> +        .expected_result = 0,
> +    };
> +
> +    run_smmuv3_translation(&cfg);
> +}
> +
> +static void test_smmuv3_ns_nested(void)
> +{
> +    QSMMUTestConfig cfg = {
> +        .trans_mode = QSMMU_TM_NESTED,
> +        .sec_sid = QSMMU_SEC_SID_NONSECURE,
> +        .dma_iova = QSMMU_IOVA_OR_IPA,
> +        .dma_len = DMA_LEN,
> +        .expected_result = 0,
> +    };
> +
> +    run_smmuv3_translation(&cfg);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +    qtest_add_func("/iommu-testdev/translation/ns-s1-only",
> +                   test_smmuv3_ns_s1_only);
> +    qtest_add_func("/iommu-testdev/translation/ns-s2-only",
> +                   test_smmuv3_ns_s2_only);
> +    qtest_add_func("/iommu-testdev/translation/ns-nested",
> +                   test_smmuv3_ns_nested);
> +    return g_test_run();
> +}
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 669d07c06b..e2d2e68092 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -263,6 +263,7 @@ qtests_aarch64 = \
>     config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
>    (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 : []) + \
>    (config_all_devices.has_key('CONFIG_NPCM8XX') ? qtests_npcm8xx : []) + \
> +  (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') ? ['iommu-smmuv3-test'] : []) + \
>    qtests_cxl +                                                                                  \
>    ['arm-cpu-features',
>     'numa-test',

