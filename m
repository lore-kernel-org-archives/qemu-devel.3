Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861D7F532EF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 08:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4x9B-0002B0-H3; Tue, 24 Mar 2026 04:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1w4x99-0002AC-6i
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 04:29:55 -0400
Received: from mail-dy1-x1343.google.com ([2607:f8b0:4864:20::1343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1w4x97-0003X6-2a
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 04:29:54 -0400
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-2c0ecaae7dfso8317479eec.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 01:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774340991; x=1774945791; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WzmCZnpPp3dNgOv0BjGPEHtaYYUktKoojDUIsjuiHIg=;
 b=oBv0GLgLbSKyK1pqPG+MYmIAZBagn7B4pFQenHUHdBHmJiXsXtIHQeEbDsggdYACJc
 QyFjD/j4N/k5SfDSY/6uJBWYtQpuqkQbDuh6j831b5qDhttB4n2Cc7FHSUegzvPaYPGe
 J3luEuwk/pZE52FuGTwZMymbJRef6a8mKYvhtI/S1vg+0CopPOfW46J+FZH7s2OEXqeQ
 Ksu/ZPHpPO5HYXRjAlmNYUIT7p5NmU4XGvHL5ibbaMRD7K1GyYQS/nzG7qq3tgSXRwh1
 4gyPyHQiq7y1r7I+Bn7bYlurGrAzVGcOsPfUCVlUD1wg6W1Gv8owA/Offj3S8oNtqVmW
 0V2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774340991; x=1774945791;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WzmCZnpPp3dNgOv0BjGPEHtaYYUktKoojDUIsjuiHIg=;
 b=KH2cRuXCVOl7qQmgzaW4rv53MpTEDr5OXlMgcGab399Rjsl0lRRQuYY2G99bh6DvxN
 WpO2R02jhX8ZjLNAMrZlfBBJKYNNeocSAvkr1YlhChCsTvJ8SdMvedTlHW6fyIffED0j
 p1FAkYpOjCBfAL8e8ZOZZnF84Tnc1tOLDDrb8vm1Hyhme0JTd7FvszwB/11kbUwx3f7l
 u5flsBi/Avw6EExDcnGyedZmglr/frX5NAm0xdbQxQBeLMmxTxTmZWCRF0dCoMd7jop6
 DUrnol1KbjYn8Du346mfhtOlsfmNKm8cpdBZYRhQKgQSHBYyjeUshDKYoQ+GHCu9GKLF
 0h0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdQuGGnV2dH3p40StE4pBoxyod56UYWYARq4A5DFJyIU0bXQRZ1PLqqegUCRm4ofU3o0KSJKufUsUe@nongnu.org
X-Gm-Message-State: AOJu0YzpQ0iq9OZj43Dzdx9QnsmsFyFd7oDvs5Rx79TGA1PwzJ11wlKB
 r06Eks/PD/Xfc/JIROWpTT3DFGr9ylFRFVeuKDLR355co4hIoSoTqqUh
X-Gm-Gg: ATEYQzyHr7vOA2y4dRbYy/GBQX2oGY5b86ifeCNVW3mMWJ+Jzjf9aFucVSW5HUans2T
 IckzdzEcHP5S7PhWBuXViPW2V0b8pfkH8lRCXsMJ4Rvrv8wmqIBfdwgmXVftLiAIUePW9aTIcFP
 D+iyhwcvJe88UZoEjsj0P/ueIGKV6EXO+7s05/JwNmCUT32/eWdTKKnRl9Zb/xO6rZ8sCSIP1VF
 uZe6M1bsR0tYx98BP5IopF9XqwCvl8PUJ4VXP7L9bd11ELtZuEfpoFuXCee5pOebjsLZ8eZpBCs
 EXu9/On5UJZmHFP5wJAfv8Ci7wkATVKYtHBjv/6CK1Y0b3qn4pIskXzhSkKoi9pzmqq+jkjCT+9
 aUOBV4MHUatmoQY5UY+R+SJVColPvfomzgC2+smUsEvYmUL+KAXXtYFnmZk+TA9rWSQ1Q6osLg0
 bUxM8/pNj8W/HkRtYt6lMoj/IMWLDDsMSOJV8lEzUF4nO2QA5J3qj9qiYUt9vSWwIU7wvZAUeN3
 w1nbKuLwgXbfBtjucERoHdS1DwYsiw=
X-Received: by 2002:a05:693c:300b:b0:2c0:c63d:e02e with SMTP id
 5a478bee46e88-2c109567365mr7375062eec.3.1774340991230; 
 Tue, 24 Mar 2026 01:29:51 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b14bac4sm19594255eec.4.2026.03.24.01.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 01:29:50 -0700 (PDT)
Date: Tue, 24 Mar 2026 16:29:33 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [RFC v3 4/4] [NOT-MERGE] tests/qtest: add q35 SMM-only x86 attrs
 coverage
Message-ID: <acJKzHQf1AP2iUA2@ZEVORN-PC.localdomain>
References: <20260323133210.1523868-1-tangtao1634@phytium.com.cn>
 <20260323133210.1523868-5-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323133210.1523868-5-tangtao1634@phytium.com.cn>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1343;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1343.google.com
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

On Mon, Mar 23, 2026 at 09:32:10PM +0800, Tao Tang wrote:
> Add a q35-only test path for x86 secure attrs by introducing an optional
> test-only RAM region that is mapped only into the SMM address space.
> 
> The new qtest-x86-attrs-test enables this region with
> `-global mch.x-smm-test-ram=on` and verifies that accesses with the
> `secure` attribute reach the SMM-only region, while default accesses do
> not. This provides the x86 cross-verification that qtest-attrs-test does
> not cover, where normal RAM is visible from both the default and SMM
> address spaces.
> 
> This is a NOT-MERGE commit.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/pci-host/q35.c                  |  24 +++++++
>  include/hw/pci-host/q35.h          |   8 +++
>  tests/qtest/meson.build            |   1 +
>  tests/qtest/qtest-x86-attrs-test.c | 109 +++++++++++++++++++++++++++++
>  4 files changed, 142 insertions(+)
>  create mode 100644 tests/qtest/qtest-x86-attrs-test.c
> 
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index e85e4227b3..5c23375dd6 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -572,6 +572,11 @@ static void mch_realize(PCIDevice *d, Error **errp)
>          return;
>      }
>  
> +    if (mch->enable_smm_test_ram && !mch->has_smm_ranges) {
> +        error_setg(errp, "x-smm-test-ram requires SMM support");
> +        return;
> +    }
> +
>      /* setup pci memory mapping */
>      pc_pci_as_mapping_init(mch->system_memory, mch->pci_address_space);
>  
> @@ -653,6 +658,23 @@ static void mch_realize(PCIDevice *d, Error **errp)
>      memory_region_add_subregion(&mch->smram, MCH_HOST_BRIDGE_SMBASE_ADDR,
>                                  &mch->smbase_window);
>  
> +    if (mch->enable_smm_test_ram) {
> +        /*
> +         * This is a QEMU-specific, test-only region. It is mapped only into
> +         * mch->smram so qtest can verify that x86 secure attrs select the SMM
> +         * address space rather than the default one.
> +         */
> +        memory_region_init_ram(&mch->smm_test_ram, OBJECT(mch),
> +                               "smm-test-ram",
> +                               MCH_HOST_BRIDGE_SMM_TEST_RAM_SIZE, errp);
> +        if (*errp) {
> +            return;
> +        }
if errp is ever NULL this will crash.

The safer pattern is ERRP_GUARD() at the top of mch_realize(),
or a local Error * with error_propagate(). Even for NOT-MERGE
code it is worth getting right since copy-paste propagates
patterns.

> +        memory_region_add_subregion(&mch->smram,
> +                                    MCH_HOST_BRIDGE_SMM_TEST_RAM_BASE,
> +                                    &mch->smm_test_ram);
> +    }
> +
>      object_property_add_const_link(qdev_get_machine(), "smram",
>                                     OBJECT(&mch->smram));
>  }
> @@ -661,6 +683,8 @@ static const Property mch_props[] = {
>      DEFINE_PROP_UINT16("extended-tseg-mbytes", MCHPCIState, ext_tseg_mbytes,
>                         64),
>      DEFINE_PROP_BOOL("smbase-smram", MCHPCIState, has_smram_at_smbase, true),
> +    DEFINE_PROP_BOOL("x-smm-test-ram", MCHPCIState, enable_smm_test_ram,
> +                     false),
>  };
>  
>  static void mch_class_init(ObjectClass *klass, const void *data)
> diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
> index ddafc3f2e3..1ca26f0e63 100644
> --- a/include/hw/pci-host/q35.h
> +++ b/include/hw/pci-host/q35.h
> @@ -49,8 +49,10 @@ struct MCHPCIState {
>      MemoryRegion smram, low_smram, high_smram;
>      MemoryRegion tseg_blackhole, tseg_window;
>      MemoryRegion smbase_blackhole, smbase_window;
> +    MemoryRegion smm_test_ram;
>      bool has_smram_at_smbase;
>      bool has_smm_ranges;
> +    bool enable_smm_test_ram;
>      Range pci_hole;
>      uint64_t below_4g_mem_size;
>      uint64_t above_4g_mem_size;
> @@ -99,6 +101,12 @@ struct Q35PCIHost {
>  #define MCH_HOST_BRIDGE_PCIEXBAR_SIZE          8       /* 64bit register */
>  #define MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT       0xb0000000
>  #define MCH_HOST_BRIDGE_PCIEXBAR_MAX           (0x10000000) /* 256M */
> +/*
> + * Optional qtest-only RAM window used to expose an address that exists only
> + * in the SMM address space, so x86 secure attrs can be cross-checked.
> + */
> +#define MCH_HOST_BRIDGE_SMM_TEST_RAM_BASE      0xfef00000
> +#define MCH_HOST_BRIDGE_SMM_TEST_RAM_SIZE      (64 * KiB)
>  #define MCH_HOST_BRIDGE_PCIEXBAR_ADMSK         Q35_MASK(64, 35, 28)
>  #define MCH_HOST_BRIDGE_PCIEXBAR_128ADMSK      ((uint64_t)(1 << 26))
>  #define MCH_HOST_BRIDGE_PCIEXBAR_64ADMSK       ((uint64_t)(1 << 25))
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 87aa104d23..fcdd95bf7f 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -116,6 +116,7 @@ qtests_i386 = \
>     'cpu-plug-test',
>     'migration-test',
>     'qtest-attrs-test',
> +   'qtest-x86-attrs-test',
>    ]
>  
>  if dbus_display and config_all_devices.has_key('CONFIG_VGA')
> diff --git a/tests/qtest/qtest-x86-attrs-test.c b/tests/qtest/qtest-x86-attrs-test.c
> new file mode 100644
> index 0000000000..d9a67d5309
> --- /dev/null
> +++ b/tests/qtest/qtest-x86-attrs-test.c
> @@ -0,0 +1,109 @@
> +/*
> + * QTest for x86 memory access with transaction attributes
> + *
> + * Verify q35 SMM address-space access with the secure attribute.
> + *
> + * Copyright (c) 2026 Phytium Technology
> + *
> + * Author:
> + *  Tao Tang <tangtao1634@phytium.com.cn>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +
> +#define TEST_ADDR_OFFSET_NS     0x1000ULL
> +#define TEST_X86_BASE           0x0ULL
> +#define TEST_X86_SMM_BASE       0xfef00000ULL
> +
> +#define TEST_ADDR_X86           (TEST_X86_BASE + TEST_ADDR_OFFSET_NS)
> +
> +#define X86_MACHINE_ARGS        "-machine q35,smm=on -m 1G -accel tcg " \
> +                                "-global mch.x-smm-test-ram=on"
> +
> +static void test_x86_scalar_attrs(void)
> +{
> +    QTestState *qts;
> +    uint8_t val;
> +
> +    if (!qtest_has_machine("q35")) {
> +        g_test_skip("q35 machine not available");
> +        return;
> +    }
> +
> +    qts = qtest_init(X86_MACHINE_ARGS);
> +
> +    qtest_writeb_attrs(qts, TEST_ADDR_X86, 0x11, NULL);
> +    val = qtest_readb_attrs(qts, TEST_ADDR_X86, NULL);
> +    g_assert_cmpuint(val, ==, 0x11);
> +
> +    qtest_writeb_attrs(qts, TEST_ADDR_X86 + 0x1, 0x22, "secure");
> +    val = qtest_readb_attrs(qts, TEST_ADDR_X86 + 0x1, "secure");
> +    g_assert_cmpuint(val, ==, 0x22);
> +
> +
nit: extra blank line.

> +    qtest_writeb_attrs(qts, TEST_X86_SMM_BASE + 0x2, 0x33, "secure");
> +    val = qtest_readb_attrs(qts, TEST_X86_SMM_BASE + 0x2, "secure");
> +    g_assert_cmpuint(val, ==, 0x33);
The commit message says "secure accesses reach the
SMM-only region, while default accesses do not", but
the test only checks the secure-can-access half. It
would strengthen the coverage to also verify that a
default (non-secure) read of TEST_X86_SMM_BASE returns
different data or an ERR, confirming the address-space
isolation actually works. Without that, a bug where
both address spaces map the region would pass silently.

Thanks,
Chao
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_x86_bulk_attrs(void)
> +{
> +    QTestState *qts;
> +    uint8_t wbuf[8] = { 1, 2, 3, 4, 5, 6, 7, 8 };
> +    uint8_t rbuf[8];
> +    size_t i;
> +
> +    if (!qtest_has_machine("q35")) {
> +        g_test_skip("q35 machine not available");
> +        return;
> +    }
> +
> +    qts = qtest_init(X86_MACHINE_ARGS);
> +
> +    qtest_memwrite_attrs(qts, TEST_ADDR_X86 + 0x100, wbuf, sizeof(wbuf), NULL);
> +    qtest_memread_attrs(qts, TEST_ADDR_X86 + 0x100, rbuf, sizeof(rbuf), NULL);
> +    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
> +
> +    qtest_memwrite_attrs(qts, TEST_ADDR_X86 + 0x180,
> +                         wbuf, sizeof(wbuf), "secure");
> +    qtest_memread_attrs(qts, TEST_ADDR_X86 + 0x180,
> +                        rbuf, sizeof(rbuf), "secure");
> +    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
> +
> +    qtest_memwrite_attrs(qts, TEST_X86_SMM_BASE + 0x100,
> +                         wbuf, sizeof(wbuf), "secure");
> +    qtest_memread_attrs(qts, TEST_X86_SMM_BASE + 0x100,
> +                        rbuf, sizeof(rbuf), "secure");
> +    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
> +
> +    qtest_memset_attrs(qts, TEST_X86_SMM_BASE + 0x120,
> +                       0x5a, sizeof(rbuf), "secure");
> +    qtest_memread_attrs(qts, TEST_X86_SMM_BASE + 0x120,
> +                        rbuf, sizeof(rbuf), "secure");
> +    for (i = 0; i < sizeof(rbuf); i++) {
> +        g_assert_cmpuint(rbuf[i], ==, 0x5a);
> +    }
> +
> +    qtest_bufwrite_attrs(qts, TEST_X86_SMM_BASE + 0x200,
> +                         wbuf, sizeof(wbuf), "secure");
> +    qtest_bufread_attrs(qts, TEST_X86_SMM_BASE + 0x200,
> +                        rbuf, sizeof(rbuf), "secure");
> +    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
> +
> +    qtest_quit(qts);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    qtest_add_func("/qtest/x86/attrs/scalar", test_x86_scalar_attrs);
> +    qtest_add_func("/qtest/x86/attrs/bulk", test_x86_bulk_attrs);
> +
> +    return g_test_run();
> +}
> -- 
> 2.34.1
> 

