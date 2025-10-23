Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7FACCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBt65-0004lI-9q; Thu, 23 Oct 2025 07:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vBt64-0004l1-E8
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:03:08 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vBt5z-0002wG-Vv
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:03:08 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-61feb87fe26so1144162a12.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 04:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761217382; x=1761822182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ofWLNCWOpTkDb5POQq/122JUiRhgUimGeWc+YXbyABo=;
 b=mpLOXm0Mh/2HlybAtXGK1pMh1g4ghNxy13cX4849/TeFa+O9L4HHsIGd/1TdzSO24H
 8DielzRgc8K2/aQtRFzhkWsahv1BePbQQ4Rg9sQy+O+xc70KLhUYNzt1UhYKlIb2ylNy
 CLWfIpwxxLra/CQXiKK9FWiNPkJ+lPw/GnzLfgMuKjVPKNMZZAEQkcrGR9ZqVpKoaODi
 DHemwOlWGyXlUqrkNcOK8dcU89UpdhwqKwO3ZUfFWFB8J2CQZ2VoxNWe7hDRzSE14WKr
 igYdKX8m8BA13wyss3l8xdTqKL6HwPVQ7VsTqRSJ8Hoa83hJdP06/8fP8XO0zzC88ZzN
 xnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761217382; x=1761822182;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ofWLNCWOpTkDb5POQq/122JUiRhgUimGeWc+YXbyABo=;
 b=kR7bURA7qZoEj5RmidhxLptmyLe2mP9Qylkuyqx8IsrHpQo51N0Lv/APlkv5h37Vi8
 /d6KOwnYtYbH+38tn3+/eP2OiSUWnEDdKRkpuDx8HLqtiUE1vgoD4g/UrnURsKPSvez7
 CVMs+2J9reHVZjXS4EjSvy4zZflgNTlDueER4voXmH6+TEU10Ve58tvUxmt/7tq+1K3J
 weP9gNt+2HjXTTZiUgN3bTtVdidu6omrMnIU0QwL38N6OrVjrHIeKelst3F0o+2F9bCh
 HNZhwGA+3Ae+7n4cXG3E1Y+NXLJNgQ5x6PZ+eFStLvuDY+avnTlVgecKqxN+5EhIL/7Y
 WPqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnk29Q0pgyv48vpjG3fz31VZRbNGYi/J/ISiWouYxVLJJw+a556Ep4/GdtxqW9GqPp5rEbPqpgi9EZ@nongnu.org
X-Gm-Message-State: AOJu0YxPhr9AEwBHkaXew1pWuZRdsZ2JecwztLh+uhmAa7ONL+kOjbSi
 B0wxOcDh9QaGkqVH7zTasfo9aaazXZ9Wp9zywjjXKbtjlxNOufStIY6vRmvszLLYcQA=
X-Gm-Gg: ASbGncu2wH56fR6sNxNkIOvA1P2rxdNZfVaaOcDzkoqrJoOHSqHZx5oIkUwF/zLKsmF
 cPfHtRvYjFSeyxEbTO+ZcJ6jXSqDHKaFOyEIoCLpt0t9SpefrJsZvnNaa0/0LTH6dPd8+O540RP
 zZFr3XXHzBwDfWjKD6QQ6ITShMzAKwrHow84E1QcXP7902e+Eo2BYnyI44AYKb06pDwLyuOAysL
 aqD9BLLqN+/19vOgLR1WrmpUkLlJXVz9QUjfMUjMf559Fi7deSkUT+uewts6F7zC18LnosxLTEM
 H3/y0RAiXUzLj36UClWN3Oqtle8dfqtbuFT44x0aeuLCApnGGPZRs1CKkwpn1IMiIN7zOsbOPjT
 hWwtXggkD698vgLUfuaOpZRU4q7GPxuAAVrGwy5TMDo3guGAWD4v74azGTGAgc/7+pmtLE5z3O6
 t4cruoraZjVpQ=
X-Google-Smtp-Source: AGHT+IGkfEHvY08be978kFF4sOs3447TdXaQ8N+AqXKo4Wzi49dgpDM+3xy1DJUv1N8SSybDfHfkRQ==
X-Received: by 2002:a05:6402:2813:b0:63b:f0b3:76d5 with SMTP id
 4fb4d7f45d1cf-63c1f6f615emr24301661a12.35.1761217380657; 
 Thu, 23 Oct 2025 04:03:00 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e3ebcdb14sm1549811a12.16.2025.10.23.04.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 04:02:59 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DD1CF5F8DF;
 Thu, 23 Oct 2025 12:02:58 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: tangtao1634 <tangtao1634@phytium.com.cn>
Cc: pbonzini@redhat.com,  farosas@suse.de,  lvivier@redhat.com,  Eric Auger
 <eric.auger@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Chen Baozi
 <chenbaozi@phytium.com.cn>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
Subject: Re: [RFC v2 2/2] tests/qtest: add SMMUv3 smoke test using
 smmu-testdev DMA source
In-Reply-To: <20250930165340.42788-3-tangtao1634@phytium.com.cn> (tangtao's
 message of "Wed, 1 Oct 2025 00:53:40 +0800")
References: <20250930165340.42788-1-tangtao1634@phytium.com.cn>
 <20250930165340.42788-3-tangtao1634@phytium.com.cn>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Thu, 23 Oct 2025 12:02:58 +0100
Message-ID: <87jz0lnan1.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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

tangtao1634 <tangtao1634@phytium.com.cn> writes:

> From: Tao Tang <tangtao1634@phytium.com.cn>
>
> Introduce a bare-metal qtest that drives the new smmu-testdev to exercise
> the SMMUv3 emulation without guest firmware or drivers. The test programs
> a minimal Non-Secure context (STE/CD/PTE), triggers a DMA, and asserts
> translation results.
>
> Motivation
> ----------
> SMMU testing in emulation often requires a large software stack and a
> realistic PCIe fabric, which adds flakiness and obscures failures. This
> qtest keeps the surface small and deterministic by using a hermetic DMA
> source that feeds the SMMU directly.
>
> What the test covers
> --------------------
> * Builds a Non-Secure STE/CD/PTE for a chosen stream_id/ssid.
> * Primes source and destination host buffers.
> * Kicks a DMA via smmu-testdev and waits for completion.
> * Verifies translated access and payload equality.
>
> Non-goals and scope limits
> --------------------------
> * Secure bank flows are omitted because Secure SMMU support is still RFC.
>   A local Secure test exists and can be posted once the upstream series
>   lands.
> * PCIe discovery, MSI/INTx, ATS/PRI, and driver bring-up are out of scope
>   as smmu-testdev is not a realistic PCIe Endpoint nor a platform device.
>
> Rationale for a dedicated path
> ------------------------------
> Using a generic PCI or virtio device would still require driver init and a
> richer bus model, undermining determinism for this focused purpose. This
> qtest, paired with smmu-testdev, keeps failures attributable to the SMMU
> translation path.
>
> Finally we document the smmu-testdev device in docs/specs.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  docs/specs/index.rst             |   1 +
>  docs/specs/smmu-testdev.rst      |  45 ++++++
>  tests/qtest/meson.build          |   1 +
>  tests/qtest/smmu-testdev-qtest.c | 238 +++++++++++++++++++++++++++++++
>  4 files changed, 285 insertions(+)
>  create mode 100644 docs/specs/smmu-testdev.rst
>  create mode 100644 tests/qtest/smmu-testdev-qtest.c
>
> diff --git a/docs/specs/index.rst b/docs/specs/index.rst
> index f19d73c9f6..47a18c48f1 100644
> --- a/docs/specs/index.rst
> +++ b/docs/specs/index.rst
> @@ -39,3 +39,4 @@ guest hardware that is specific to QEMU.
>     riscv-iommu
>     riscv-aia
>     aspeed-intc
> +   smmu-testdev
> \ No newline at end of file
> diff --git a/docs/specs/smmu-testdev.rst b/docs/specs/smmu-testdev.rst
> new file mode 100644
> index 0000000000..2599b46e4f
> --- /dev/null
> +++ b/docs/specs/smmu-testdev.rst
> @@ -0,0 +1,45 @@
> +smmu-testdev =E2=80=94 Minimal SMMUv3 DMA test device
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Overview
> +--------
> +``smmu-testdev`` is a tiny, test-only DMA source intended to exercise the
> +SMMUv3 emulation without booting firmware or a guest OS. It lets tests
> +populate STE/CD/PTE with known values and trigger a DMA that flows throu=
gh
> +the SMMU translation path. It is **not** a faithful PCIe endpoint nor a
> +platform device and must be considered a QEMU-internal test vehicle.
> +
> +Status
> +------
> +* Location: ``hw/misc/smmu-testdev.c``
> +* Build guard: ``CONFIG_SMMU_TESTDEV``
> +* Default machines: none (tests instantiate it explicitly)
> +* Intended use: qtests under ``tests/qtest/smmu-testdev-qtest.c``
> +
> +Running the qtest
> +-----------------
> +The smoke test ships with this device and is the recommended entry point=
::
> +
> +    QTEST_QEMU_BINARY=3Dqemu-system-aarch64 ./tests/qtest/smmu-testdev-q=
test
> +     --tap -k
> +
> +This programs a minimal Non-Secure SMMU context, kicks a DMA, and verifi=
es
> +translation + data integrity.
> +
> +Instantiation (advanced)
> +------------------------
> +The device is not wired into any board by default. For ad-hoc experiment=
s,
> +tests (or developers) can create it dynamically via qtest or the QEMU
> +monitor. It exposes a single MMIO window that the test drives directly.
> +
> +Limitations
> +-----------
> +* Non-Secure bank only in this version; Secure SMMU tests are planned on=
ce
> +  upstream Secure support lands.
> +* No PCIe discovery, MSI, ATS/PRI, or driver bring-up is modeled.
> +* The device is test-only; do not rely on it for machine realism.
> +
> +See also
> +--------
> +* ``tests/qtest/smmu-testdev-qtest.c`` =E2=80=94 the companion smoke test
> +* SMMUv3 emulation and documentation under ``hw/arm/smmu*``
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 669d07c06b..bcdb51e141 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -263,6 +263,7 @@ qtests_aarch64 =3D \
>     config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test=
'] : []) + \
>    (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 : [=
]) + \
>    (config_all_devices.has_key('CONFIG_NPCM8XX') ? qtests_npcm8xx : []) +=
 \
> +  (config_all_devices.has_key('CONFIG_SMMU_TESTDEV') ? ['smmu-testdev-qt=
est'] : []) + \
>    qtests_cxl +                                                          =
                        \
>    ['arm-cpu-features',
>     'numa-test',
> diff --git a/tests/qtest/smmu-testdev-qtest.c b/tests/qtest/smmu-testdev-=
qtest.c
> new file mode 100644
> index 0000000000..d89e45757b
> --- /dev/null
> +++ b/tests/qtest/smmu-testdev-qtest.c
> @@ -0,0 +1,238 @@
> +/*
> + * QTest for smmu-testdev
> + *
> + * This QTest file is used to test the smmu-testdev so that we can test =
SMMU
> + * without any guest kernel or firmware.
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
> +#include "hw/misc/smmu-testdev.h"
> +
> +#define VIRT_SMMU_BASE    0x0000000009050000ULL
> +#define DMA_LEN           0x20U
> +
> +static inline uint64_t smmu_bank_base(uint64_t base, SMMUTestDevSpace sp)
> +{
> +    /* Map only the Non-Secure bank for now; future domains may offset. =
*/
> +    (void)sp;
> +    return base;
> +}
> +
> +static uint32_t expected_dma_result(uint32_t mode,
> +                                    SMMUTestDevSpace s1_space,
> +                                    SMMUTestDevSpace s2_space)
> +{
> +    (void)mode;
> +    if (s1_space !=3D STD_SPACE_NONSECURE || s2_space !=3D STD_SPACE_NON=
SECURE) {
> +        return STD_DMA_ERR_TX_FAIL;
> +    }
> +    return 0u;
> +}
> +
> +static void smmu_prog_bank(QTestState *qts, uint64_t B, SMMUTestDevSpace=
 sp)
> +{
> +    g_assert_cmpuint(sp, =3D=3D, STD_SPACE_NONSECURE);
> +    /* Program minimal SMMUv3 state in a given control bank. */
> +    qtest_writel(qts, B + 0x0044, 0x80000000); /* GBPA UPDATE */
> +    qtest_writel(qts, B + 0x0020, 0x0);       /* CR0 */
> +    qtest_writel(qts, B + 0x0028, 0x0d75);    /* CR1 */
> +    {
> +        /* CMDQ_BASE: add address-space offset (S/NS/Root/Realm). */
> +        uint64_t v =3D 0x400000000e16b00aULL + std_space_offset(sp);
> +        qtest_writeq(qts, B + 0x0090, v);
> +    }
> +    qtest_writel(qts, B + 0x009c, 0x0);       /* CMDQ_CONS */
> +    qtest_writel(qts, B + 0x0098, 0x0);       /* CMDQ_PROD */
> +    {
> +        /* EVENTQ_BASE: add address-space offset (S/NS/Root/Realm). */
> +        uint64_t v =3D 0x400000000e17000aULL + std_space_offset(sp);
> +        qtest_writeq(qts, B + 0x00a0, v);
> +    }
> +    qtest_writel(qts, B + 0x00a8, 0x0);       /* EVENTQ_PROD */
> +    qtest_writel(qts, B + 0x00ac, 0x0);       /* EVENTQ_CONS */
> +    qtest_writel(qts, B + 0x0088, 0x5);       /* STRTAB_BASE_CFG */
> +    {
> +        /* STRTAB_BASE: add address-space offset (S/NS/Root/Realm). */
> +        uint64_t v =3D 0x400000000e179000ULL + std_space_offset(sp);
> +        qtest_writeq(qts, B + 0x0080, v);
> +    }
> +    qtest_writel(qts, B + 0x003C, 0x1);       /* INIT */
> +    qtest_writel(qts, B + 0x0020, 0xD);       /* CR0 */
> +}
> +
> +static void smmu_prog_minimal(QTestState *qts, SMMUTestDevSpace space)
> +{
> +    /* Always program Non-Secure bank, then the requested space. */
> +    uint64_t ns_base =3D smmu_bank_base(VIRT_SMMU_BASE, STD_SPACE_NONSEC=
URE);
> +    smmu_prog_bank(qts, ns_base, STD_SPACE_NONSECURE);
> +
> +    uint64_t sp_base =3D smmu_bank_base(VIRT_SMMU_BASE, space);
> +    if (sp_base !=3D ns_base) {
> +        smmu_prog_bank(qts, sp_base, space);
> +    }
> +}
> +
> +static uint32_t poll_dma_result(QPCIDevice *dev, QPCIBar bar,
> +                                QTestState *qts)
> +{
> +    /* Trigger side effects (DMA) via REG_ID read once. */
> +    (void)qpci_io_readl(dev, bar, STD_REG_ID);
> +
> +    /* Poll until not BUSY, then return the result. */
> +    for (int i =3D 0; i < 1000; i++) {
> +        uint32_t r =3D qpci_io_readl(dev, bar, STD_REG_DMA_RESULT);
> +        if (r !=3D STD_DMA_RESULT_BUSY) {
> +            return r;
> +        }
> +        /* Small backoff to avoid busy spinning. */
> +        g_usleep(1000);
> +    }
> +    /* Timeout treated as failure-like non-zero. */
> +    return STD_DMA_RESULT_BUSY;
> +}
> +
> +static void test_mmio_access(void)
> +{
> +    QTestState *qts;
> +    QGenericPCIBus gbus;
> +    QPCIDevice *dev;
> +    QPCIBar bar;
> +    uint8_t buf[DMA_LEN];
> +    uint32_t attr_ns;
> +    qts =3D qtest_init("-machine virt,acpi=3Doff,gic-version=3D3,iommu=
=3Dsmmuv3 " \
> +                     "-display none -smp 1  -m 512 -cpu max -net none "
> +                     "-device smmu-testdev,device=3D0x0,function=3D0x1 "=
);
> +
> +    qpci_init_generic(&gbus, qts, NULL, false);
> +
> +    /* Find device by vendor/device ID to avoid slot surprises. */
> +    dev =3D NULL;

might as well init when you declare.

> +    for (int slot =3D 0; slot < 32 && !dev; slot++) {
> +        for (int fn =3D 0; fn < 8 && !dev; fn++) {
> +            QPCIDevice *cand =3D qpci_device_find(&gbus.bus,
> +                                               QPCI_DEVFN(slot, fn));
> +            if (!cand) {
> +                continue;
> +            }
> +            uint16_t vid =3D qpci_config_readw(cand, PCI_VENDOR_ID);
> +            uint16_t did =3D qpci_config_readw(cand, PCI_DEVICE_ID);
> +            if (vid =3D=3D 0x1b36 && did =3D=3D 0x0005) {
> +                dev =3D cand;
> +            } else {
> +                g_free(cand);
> +            }
> +        }
> +    }
> +    g_assert_nonnull(dev);

surely g_assert(dev) would do.

> +
> +    qpci_device_enable(dev);
> +    bar =3D qpci_iomap(dev, 0, NULL);
> +    g_assert_false(bar.is_io);
> +
> +    /* Baseline attribute reads. */
> +    attr_ns =3D qpci_io_readl(dev, bar, STD_REG_ATTR_NS);
> +    g_assert_cmpuint(attr_ns, =3D=3D, 0x2);
> +
> +    /* Program SMMU base and DMA parameters. */
> +    qpci_io_writel(dev, bar, STD_REG_SMMU_BASE_LO, (uint32_t)VIRT_SMMU_B=
ASE);
> +    qpci_io_writel(dev, bar, STD_REG_SMMU_BASE_HI,
> +                   (uint32_t)(VIRT_SMMU_BASE >> 32));
> +    qpci_io_writel(dev, bar, STD_REG_DMA_IOVA_LO, (uint32_t)STD_IOVA);
> +    qpci_io_writel(dev, bar, STD_REG_DMA_IOVA_HI,
> +                   (uint32_t)(STD_IOVA >> 32));
> +    qpci_io_writel(dev, bar, STD_REG_DMA_LEN, DMA_LEN);
> +    qpci_io_writel(dev, bar, STD_REG_DMA_DIR, 0); /* device -> host */
> +
> +    qtest_memset(qts, STD_IOVA, 0x00, DMA_LEN);
> +    qtest_memread(qts, STD_IOVA, buf, DMA_LEN);
> +
> +    /* Refresh attrs via write to ensure legacy functionality still work=
s. */
> +    qpci_io_writel(dev, bar, STD_REG_ID, 0x1);
> +    /*
> +     * invoke translation builder for multiple
> +     * stage/security-space combinations (readable/refactored).
> +     */
> +    const uint32_t modes[] =3D { 0u, 1u, 2u }; /* Stage1, Stage2, Nested=
 stage */
> +    const SMMUTestDevSpace spaces[] =3D { STD_SPACE_NONSECURE };

top of block.

> +    /* Use attrs-DMA path for end-to-end */
> +    qpci_io_writel(dev, bar, STD_REG_DMA_MODE, 1);
> +    for (size_t mi =3D 0; mi < sizeof(modes) / sizeof(modes[0]); mi++) {
> +        const SMMUTestDevSpace *s1_set =3D NULL;
> +        size_t s1_count =3D 0;
> +        const SMMUTestDevSpace *s2_set =3D NULL;
> +        size_t s2_count =3D 0;
> +
> +        switch (modes[mi]) {
> +        case 0u:
> +        case 1u:
> +        case 2u:
> +            s1_set =3D spaces;
> +            s1_count =3D sizeof(spaces) / sizeof(spaces[0]);
> +            s2_set =3D spaces;
> +            s2_count =3D sizeof(spaces) / sizeof(spaces[0]);
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +
> +        for (size_t si =3D 0; si < s1_count; si++) {
> +            for (size_t sj =3D 0; sj < s2_count; sj++) {
> +                qpci_io_writel(dev, bar, STD_REG_TRANS_MODE, modes[mi]);
> +                qpci_io_writel(dev, bar, STD_REG_S1_SPACE, s1_set[si]);
> +                qpci_io_writel(dev, bar, STD_REG_S2_SPACE, s2_set[sj]);
> +                qpci_io_writel(dev, bar, STD_REG_TRANS_DBELL, 0x2);
> +                qpci_io_writel(dev, bar, STD_REG_TRANS_DBELL, 0x1);
> +
> +                uint32_t st =3D qpci_io_readl(dev, bar,
> +                                            STD_REG_TRANS_STATUS);
> +                g_test_message("build: stage=3D%s s1=3D%s s2=3D%s status=
=3D0x%x",
> +                                std_mode_to_str(modes[mi]),
> +                                std_space_to_str(s1_set[si]),
> +                                std_space_to_str(s2_set[sj]), st);
> +                /* Program SMMU registers in selected control bank. */
> +                smmu_prog_minimal(qts, s1_set[si]);
> +
> +                /* End-to-end DMA using tx_space per mode. */
> +                SMMUTestDevSpace tx_space =3D
> +                    (modes[mi] =3D=3D 0u) ? s1_set[si] : s2_set[sj];
> +                uint32_t dma_attrs =3D ((uint32_t)tx_space << 1);
> +                qpci_io_writel(dev, bar, STD_REG_DMA_ATTRS,
> +                                dma_attrs);
> +                qpci_io_writel(dev, bar, STD_REG_DMA_DBELL, 1);
> +                /* Wait for DMA completion and assert success. */
> +                {
> +                    uint32_t dr =3D poll_dma_result(dev, bar, qts);
> +                    uint32_t exp =3D expected_dma_result(modes[mi],
> +                                                        spaces[si],
> +                                                        spaces[sj]);
> +                    g_assert_cmpuint(dr, =3D=3D, exp);
> +                    g_test_message("polling end. attrs=3D0x%x res=3D0x%x=
",
> +                                   dma_attrs, dr);
> +                }
> +                /* Clear CD/STE/PTE built by the device for next round. =
*/
> +                qpci_io_writel(dev, bar, STD_REG_TRANS_CLEAR, 1);
> +                g_test_message("clear cache end.");
> +            }
> +        }
> +    }

I suspect this function could be broken up a bit as new tests are added
and functionality shared?

> +
> +    qtest_quit(qts);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +    qtest_add_func("/smmu-testdev/mmio", test_mmio_access);
> +    return g_test_run();
> +}

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

