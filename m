Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1183C10F2845
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 15:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w69IE-0001Rf-Nw; Fri, 27 Mar 2026 11:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w69IB-0001OI-1l
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 11:40:11 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w69I8-0001Dg-J4
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 11:40:10 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 88B515BD9A;
 Fri, 27 Mar 2026 15:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774626005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Du5X0Rd6QmmM3pwqzCM2kpZq2MgX34sdd2CBHs0AL4o=;
 b=zJdii8qaNDX1/8i57gL3XA05crxx8ZjXjjUuZg60q8V3bFvMjYB4QFGdaO0oer7aIU807H
 9tqIoK8VgBQyk5Mfdy5w5KvKXPO+YdLn0pVRrIYAZBtl/bFRQOc3tcFXwXWusH5zZ9S0pX
 VuoZwEdyxGmFH+VxTPX/L/5R2/bE8qc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774626005;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Du5X0Rd6QmmM3pwqzCM2kpZq2MgX34sdd2CBHs0AL4o=;
 b=alrADyNaNqbIhERmvinDtc3B/NPnqMvuMa3b0S2MIbD6ZVtAqjigFdQUgv8WJTCZ5sxZUL
 xTLU3kGjRO3iJaBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774626005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Du5X0Rd6QmmM3pwqzCM2kpZq2MgX34sdd2CBHs0AL4o=;
 b=zJdii8qaNDX1/8i57gL3XA05crxx8ZjXjjUuZg60q8V3bFvMjYB4QFGdaO0oer7aIU807H
 9tqIoK8VgBQyk5Mfdy5w5KvKXPO+YdLn0pVRrIYAZBtl/bFRQOc3tcFXwXWusH5zZ9S0pX
 VuoZwEdyxGmFH+VxTPX/L/5R2/bE8qc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774626005;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Du5X0Rd6QmmM3pwqzCM2kpZq2MgX34sdd2CBHs0AL4o=;
 b=alrADyNaNqbIhERmvinDtc3B/NPnqMvuMa3b0S2MIbD6ZVtAqjigFdQUgv8WJTCZ5sxZUL
 xTLU3kGjRO3iJaBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 242C04A0A2;
 Fri, 27 Mar 2026 15:40:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id h20QOdSkxml6GwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 27 Mar 2026 15:40:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Fengyuan Yu <15fengyuan@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif
 <clement.mathieu--drif@bull.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Tao Tang <tangtao1634@phytium.com.cn>
Cc: qemu-devel@nongnu.org, Chao Liu <chao.liu.zevorn@gmail.com>, Fengyuan Yu
 <15fengyuan@gmail.com>
Subject: Re: [PATCH v3 2/2] tests/qtest: Add Intel IOMMU bare-metal test
In-Reply-To: <ce3c44f3b07734a4f0ee43f55b21c856034af1b1.1774421649.git.15fengyuan@gmail.com>
References: <cover.1774421649.git.15fengyuan@gmail.com>
 <ce3c44f3b07734a4f0ee43f55b21c856034af1b1.1774421649.git.15fengyuan@gmail.com>
Date: Fri, 27 Mar 2026 12:40:03 -0300
Message-ID: <87v7ehgu24.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; TAGGED_RCPT(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCPT_COUNT_SEVEN(0.00)[11];
 FROM_HAS_DN(0.00)[]; FREEMAIL_CC(0.00)[nongnu.org,gmail.com];
 FREEMAIL_TO(0.00)[gmail.com,redhat.com,intel.com,bull.com,phytium.com.cn];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email, imap1.dmz-prg2.suse.org:helo,
 suse.de:mid, suse.de:email]
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

Fengyuan Yu <15fengyuan@gmail.com> writes:

> Add a qtest suite for the Intel IOMMU (VT-d) device on the Q35 machine.
> The test exercises both Legacy and Scalable translation modes using
> iommu-testdev and the qos-intel-iommu helpers, without requiring any
> guest kernel or firmware.
>
> The test validates:
> - Legacy-mode Root Entry Table and Context Entry Table configuration
> - Scalable-mode Context Entry, PASID Directory, and PASID Table setup
> - Legacy-mode 4-level page table walks for 48-bit address translation
> - Scalable-mode second-level and first-level 4-level page table walks
> - Pass-through mode in both Legacy and Scalable modes
> - DMA transaction execution with memory content verification
>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Signed-off-by: Fengyuan Yu <15fengyuan@gmail.com>
> ---
>  MAINTAINERS                    |   1 +
>  tests/qtest/iommu-intel-test.c | 216 +++++++++++++++++++++++++++++++++
>  tests/qtest/meson.build        |   2 +
>  3 files changed, 219 insertions(+)
>  create mode 100644 tests/qtest/iommu-intel-test.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ba0901bf4f..420f7ab6cf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4016,6 +4016,7 @@ F: hw/i386/intel_iommu_accel.*
>  F: include/hw/i386/intel_iommu.h
>  F: tests/functional/x86_64/test_intel_iommu.py
>  F: tests/qtest/intel-iommu-test.c
> +F: tests/qtest/iommu-intel-test.c
>  
>  AMD-Vi Emulation
>  M: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> diff --git a/tests/qtest/iommu-intel-test.c b/tests/qtest/iommu-intel-test.c
> new file mode 100644
> index 0000000000..a52c45e298
> --- /dev/null
> +++ b/tests/qtest/iommu-intel-test.c
> @@ -0,0 +1,216 @@
> +/*
> + * QTest for Intel IOMMU (VT-d) with iommu-testdev
> + *
> + * This QTest file is used to test the Intel IOMMU with iommu-testdev so that
> + * we can test VT-d without any guest kernel or firmware.
> + *
> + * Copyright (c) 2026 Fengyuan Yu <15fengyuan@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "libqos/pci.h"
> +#include "libqos/pci-pc.h"
> +#include "hw/i386/intel_iommu_internal.h"
> +#include "hw/misc/iommu-testdev.h"
> +#include "libqos/qos-intel-iommu.h"
> +
> +#define DMA_LEN           4
> +
> +static uint64_t intel_iommu_expected_gpa(uint64_t iova)
> +{
> +    return (QVTD_PT_VAL & VTD_PAGE_MASK_4K) + (iova & 0xfff);
> +}
> +
> +static void save_fn(QPCIDevice *dev, int devfn, void *data)
> +{
> +    QPCIDevice **pdev = (QPCIDevice **) data;
> +
> +    *pdev = dev;
> +}
> +
> +static QPCIDevice *setup_qtest_pci_device(QTestState *qts, QPCIBus **pcibus,
> +                                          QPCIBar *bar)
> +{
> +    QPCIDevice *dev = NULL;
> +
> +    *pcibus = qpci_new_pc(qts, NULL);
> +    g_assert(*pcibus != NULL);
> +
> +    qpci_device_foreach(*pcibus, IOMMU_TESTDEV_VENDOR_ID,
> +                        IOMMU_TESTDEV_DEVICE_ID, save_fn, &dev);
> +
> +    g_assert(dev);
> +    qpci_device_enable(dev);
> +    *bar = qpci_iomap(dev, 0, NULL);
> +    g_assert_false(bar->is_io);
> +
> +    return dev;
> +}
> +
> +static const char *qvtd_iommu_args(QVTDTransMode mode)
> +{
> +    switch (mode) {
> +    case QVTD_TM_SCALABLE_FLT:
> +        return "-device intel-iommu,x-scalable-mode=on,x-flts=on ";
> +    case QVTD_TM_SCALABLE_PT:
> +    case QVTD_TM_SCALABLE_SLT:
> +        return "-device intel-iommu,x-scalable-mode=on ";
> +    default:
> +        return "-device intel-iommu ";
> +    }
> +}
> +
> +static bool qvtd_check_caps(QTestState *qts, QVTDTransMode mode)
> +{
> +    uint64_t ecap = qtest_readq(qts,
> +                                Q35_HOST_BRIDGE_IOMMU_ADDR + DMAR_ECAP_REG);
> +
> +    /* All scalable modes require SMTS */
> +    if (qvtd_is_scalable(mode) && !(ecap & VTD_ECAP_SMTS)) {
> +        g_test_skip("ECAP.SMTS not supported");
> +        return false;
> +    }
> +
> +    switch (mode) {
> +    case QVTD_TM_SCALABLE_PT:
> +        if (!(ecap & VTD_ECAP_PT)) {
> +            g_test_skip("ECAP.PT not supported");
> +            return false;
> +        }
> +        break;
> +    case QVTD_TM_SCALABLE_SLT:
> +        if (!(ecap & VTD_ECAP_SSTS)) {
> +            g_test_skip("ECAP.SSTS not supported");
> +            return false;
> +        }
> +        break;
> +    case QVTD_TM_SCALABLE_FLT:
> +        if (!(ecap & VTD_ECAP_FSTS)) {
> +            g_test_skip("ECAP.FSTS not supported");
> +            return false;
> +        }
> +        break;
> +    default:
> +        break;
> +    }
> +
> +    return true;
> +}
> +
> +static void run_intel_iommu_translation(const QVTDTestConfig *cfg)
> +{
> +    QTestState *qts;
> +    QPCIBus *pcibus;
> +    QPCIDevice *dev;
> +    QPCIBar bar;
> +
> +    if (!qtest_has_machine("q35")) {
> +        g_test_skip("q35 machine not available");
> +        return;
> +    }
> +
> +    /* Initialize QEMU environment for Intel IOMMU testing */
> +    qts = qtest_initf("-machine q35 -smp 1 -m 512 -net none "
> +                      "%s -device iommu-testdev",
> +                      qvtd_iommu_args(cfg->trans_mode));
> +
> +    /* Check CAP/ECAP capabilities for required translation mode */
> +    if (!qvtd_check_caps(qts, cfg->trans_mode)) {
> +        qtest_quit(qts);
> +        return;
> +    }
> +
> +    /* Setup and configure IOMMU-testdev PCI device */
> +    dev = setup_qtest_pci_device(qts, &pcibus, &bar);
> +    g_assert(dev);
> +
> +    g_test_message("### Intel IOMMU translation mode=%d ###", cfg->trans_mode);
> +    qvtd_run_translation_case(qts, dev, bar, Q35_HOST_BRIDGE_IOMMU_ADDR, cfg);
> +    g_free(dev);
> +    qpci_free_pc(pcibus);
> +    qtest_quit(qts);
> +}
> +
> +static void test_intel_iommu_legacy_pt(void)
> +{
> +    QVTDTestConfig cfg = {
> +        .trans_mode = QVTD_TM_LEGACY_PT,
> +        .dma_gpa = QVTD_IOVA,  /* pass-through: GPA == IOVA */
> +        .dma_len = DMA_LEN,
> +        .expected_result = 0,
> +    };
> +
> +    run_intel_iommu_translation(&cfg);
> +}
> +
> +static void test_intel_iommu_legacy_trans(void)
> +{
> +    QVTDTestConfig cfg = {
> +        .trans_mode = QVTD_TM_LEGACY_TRANS,
> +        .dma_gpa = intel_iommu_expected_gpa(QVTD_IOVA),
> +        .dma_len = DMA_LEN,
> +        .expected_result = 0,
> +    };
> +
> +    run_intel_iommu_translation(&cfg);
> +}
> +
> +static void test_intel_iommu_scalable_pt(void)
> +{
> +    QVTDTestConfig cfg = {
> +        .trans_mode = QVTD_TM_SCALABLE_PT,
> +        .dma_gpa = QVTD_IOVA,  /* pass-through: GPA == IOVA */
> +        .dma_len = DMA_LEN,
> +        .expected_result = 0,
> +    };
> +
> +    run_intel_iommu_translation(&cfg);
> +}
> +
> +static void test_intel_iommu_scalable_slt(void)
> +{
> +    QVTDTestConfig cfg = {
> +        .trans_mode = QVTD_TM_SCALABLE_SLT,
> +        .dma_gpa = intel_iommu_expected_gpa(QVTD_IOVA),
> +        .dma_len = DMA_LEN,
> +        .expected_result = 0,
> +    };
> +
> +    run_intel_iommu_translation(&cfg);
> +}
> +
> +static void test_intel_iommu_scalable_flt(void)
> +{
> +    QVTDTestConfig cfg = {
> +        .trans_mode = QVTD_TM_SCALABLE_FLT,
> +        .dma_gpa = intel_iommu_expected_gpa(QVTD_IOVA),
> +        .dma_len = DMA_LEN,
> +        .expected_result = 0,
> +    };
> +
> +    run_intel_iommu_translation(&cfg);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    /* Legacy mode tests */
> +    qtest_add_func("/iommu-testdev/intel/legacy-pt",
> +                   test_intel_iommu_legacy_pt);
> +    qtest_add_func("/iommu-testdev/intel/legacy-trans",
> +                   test_intel_iommu_legacy_trans);
> +
> +    /* Scalable mode tests */
> +    qtest_add_func("/iommu-testdev/intel/scalable-pt",
> +                   test_intel_iommu_scalable_pt);
> +    qtest_add_func("/iommu-testdev/intel/scalable-slt",
> +                   test_intel_iommu_scalable_slt);
> +    qtest_add_func("/iommu-testdev/intel/scalable-flt",
> +                   test_intel_iommu_scalable_flt);
> +
> +    return g_test_run();
> +}
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index be4fa627b5..264bce9f81 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -96,6 +96,8 @@ qtests_i386 = \
>    (config_all_devices.has_key('CONFIG_SDHCI_PCI') ? ['fuzz-sdcard-test'] : []) +            \
>    (config_all_devices.has_key('CONFIG_ESP_PCI') ? ['am53c974-test'] : []) +                 \
>    (config_all_devices.has_key('CONFIG_VTD') ? ['intel-iommu-test'] : []) +                 \
> +  (config_all_devices.has_key('CONFIG_VTD') and
> +   config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') ? ['iommu-intel-test'] : []) +      \
>    (host_os != 'windows' and                                                                \
>     config_all_devices.has_key('CONFIG_ACPI_ERST') ? ['erst-test'] : []) +                   \
>    (config_all_devices.has_key('CONFIG_PCIE_PORT') and                                       \

Reviewed-by: Fabiano Rosas <farosas@suse.de>

