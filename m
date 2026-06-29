Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EA0C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 01:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we1AM-00048D-Qh; Sun, 28 Jun 2026 21:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1we1AL-00047o-Av
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 21:52:05 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1we1AJ-0005ui-Ma
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 21:52:05 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6984169c126so2872796a12.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 18:52:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782697922; cv=none;
 d=google.com; s=arc-20260327;
 b=kvwTxwu6DR51+UybOhprqwTaTzqdfnruYysEv3K3tj642/MMdxRmGAb1UfVaDNoFBu
 Fui/sU3tlVxIOJVLHfxi379GII5Qrtbz9gGTH87lRNLo1Z5MDVul8OazYpREKIXeS5fH
 WzfO4kyYPMfMQafIL3sxmQpfTyrW3vG0TyCHldO/DidaygbGDPSpoy3lq4cdFGbj/am9
 JYH0pXajvW3OgP8HYq5UyiJoThHakoIbGHpXNQ1sym49jvuZfqj3T/vRZp3ClP9o0b1R
 dvsNa2YaqmPYfYu++DcdmxP1wD5wJVuOBXhzQB9RPUurkwj9/dFpLuVvVVyksPMmt4BZ
 pBgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CMqBTCRUbnPotNNJ9L9MwTYdCpIX8sbnIZflPhglVns=;
 fh=rtJ6LEstOJ+xc1WjVUI/6HMi9vdAdPgmpAwNOEXv+NU=;
 b=IwBmwMciCsI32jUeUxqBVJaFd51jeyPSeBdKEsJ4nNF4aSArmeI39TZ32tTdZlmjiG
 GKO5uNGu9++GtXVCxRHNAzTxftoibA0uf0VPtz2DjjsvN6LK0TwksUrFTaHP47uOQYkT
 98CpFbEgW4710WIPKA3cfQpggCz3LLyVdvzrNMEGEk9TfeMvLJcRJ50jiRLHdio0Ga7R
 BykOdOrOuDA17Y7+jbQNuopcfYxkGnRc6GbEKLOqWNtMbijxoRp9qFcwCOrMl2AXQhAx
 /Zp1MmVejmAmh6ox9KT1N9SXZ0pLLcKUYQ3JS7O8h+cVQvLaoofSsM8V6oH9mKzjw5Ua
 kF/Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782697922; x=1783302722; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CMqBTCRUbnPotNNJ9L9MwTYdCpIX8sbnIZflPhglVns=;
 b=aCsxoLzTPr7j8etPWh1kfRohrWGpzbbfhuPZ0F/nk8uuRnm8TOAr5QcxhPeLbIPftX
 vJqhDXR0KZJD9Ct+qvLCplB6ryj2+CKcQu/mGY1qhYu7hZYUyBY9vt6lhGE8u1ZNS5aE
 4GJT/wUfGrO7FbnZ4SlVF30h7SV0L5L7nWxXCLdks6qh2+ojSSvKzGNtg/WlpTrPPKnW
 Him3DICyDJxntSC4HxntjYNdOCuQX3Ry/Y1aL5DNip/ZzAZeNty4YKrDo6cMs/poY8WQ
 AuywZPbqzYKZTqkXWXpFMDJn36j8UQ8d0fi+jkcJmusBcZU/mx18SBjJKQ0esnj4CUR+
 GAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782697922; x=1783302722;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CMqBTCRUbnPotNNJ9L9MwTYdCpIX8sbnIZflPhglVns=;
 b=srtIQ4r5KmrwDa7lCEO5AcuVtGBQjJJjKNkzji06SVB/CIrHvBqZSddXNywnM1Hi2r
 1Z4F7G+l+uoo7HRcJijSK6+AI/Xl7etZyZY1RF/HkGH+cCA2zrW1yg3rBGKCQXptKb1E
 FF+AACgbtycGlvCXBPGHC74qkkwVt0SU88f9wjpwQey4sCR/3APjxh1xBjTE/n9wQdhi
 uVsn5Jhg+RvDKuhielHRCouSKYfZEbv647foBMqKnNPaaUDO0z2Ntqy8AVqUTYUv6K2u
 cqeKaAnQH9ROs6Uscx5DBOtXsXMfxyGx8FNtcn9Zf8+0D+f4neCQreLF6BNQU8t7BT1j
 ig1w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpTeed3JowqBVbQBkHachomC/rFOOHJwA5CC91S61T7+8f8wq01ZlgxNrMIQbKWyKbox35ZAUXK1Ejs@nongnu.org
X-Gm-Message-State: AOJu0Yw4FYpp+zpf0hTj7iXmOLzDNGtVbW4cx8qBxzQ4ypJDsIjrZnFi
 Tbyjpu30rhB2WObxEMDb4lTl5KR6g3I237a1fPWYoE1AwmPdKtGESOe5Q/LqDlXlqqk+cx38IzS
 AlWKY1+j+aNvdVYOTDrn3xsReQrtHBZc=
X-Gm-Gg: AfdE7ckoVll/cjSzK+DhQWQeUY3OvBRX7aRszGORPSrR0tCXl/zbJr24rE5dFtfMPVf
 +2aZDoQtuaARPod7L6OZEDEtWdx009dc3qXy1GX70PwR6Hulbr1u/4ZoYU7rhhx5LTKHsCNAkNC
 4Z7f/Q3m2dE/uFTJWTsO3UNmkRlhdiDDRhcFWevC08xnr9bWHBqD0r++mg8KF52JbvdOGPNNaxx
 4R0gAtIujHa9vC3ctJpyMKI0w/70ZlrSQUFgRLjW/DFcd2inST3M7omTD+s17I24RyUtRNzqtzP
 sDNQHpbfk+oAayQgEG3YD2+ZjxRqj8IppjZbag==
X-Received: by 2002:a05:6402:42d5:b0:698:3b7c:7e37 with SMTP id
 4fb4d7f45d1cf-6983b7c7f56mr4453673a12.33.1782697922307; Sun, 28 Jun 2026
 18:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260616190147.1286316-1-visitorckw@gmail.com>
 <20260616190147.1286316-6-visitorckw@gmail.com>
In-Reply-To: <20260616190147.1286316-6-visitorckw@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Jun 2026 11:51:36 +1000
X-Gm-Features: AVVi8Ccfc-DaiAEW7_omqutxWG8tDvIYBF2EI5rzffMcZiT-WYX_3fQ0e87Otjk
Message-ID: <CAKmqyKMXyrtFeruxxsy2NNTeCeqQfkM4khYuWN+Qu9Zhb0ebMg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] tests/qtest: Add qtest for Milk-V Duo board
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, alistair.francis@wdc.com,
 farosas@suse.de, lvivier@redhat.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu.zevorn@gmail.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, 
 marscheng@google.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Jun 17, 2026 at 5:04=E2=80=AFAM Kuan-Wei Chiu <visitorckw@gmail.com=
> wrote:
>
> Add minimal qtest coverage for the Milk-V Duo machine to validate basic
> MMIO mapping and register access.
>
> Currently tested:
> - Verify DW8250 UART component version and type signatures.
> - Test read/write access to CV1800B clock bypass register.
>
> Tested with:
> $ meson test -C build -v qemu:qtest-riscv64/milkv-duo-test
> [...]
> Ok:                 1
> Fail:               0
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>  MAINTAINERS                  |  1 +
>  tests/qtest/meson.build      |  3 +-
>  tests/qtest/milkv-duo-test.c | 70 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 73 insertions(+), 1 deletion(-)
>  create mode 100644 tests/qtest/milkv-duo-test.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e197dcb5b2..472513537f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1807,6 +1807,7 @@ F: hw/riscv/milkv_duo.c
>  F: include/hw/char/dw8250.h
>  F: include/hw/misc/cv1800b_clk.h
>  F: include/hw/riscv/cv1800b.h
> +F: tests/qtest/milkv-duo-test.c
>
>  RX Machines
>  -----------
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 4897325d84..38acbdc0c8 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -293,7 +293,8 @@ qtests_riscv64 =3D ['riscv-csr-test'] + \
>    (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
>     config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
>     ['iommu-riscv-test'] : []) + \
> -  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
> +  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : []) +=
 \
> +   ['milkv-duo-test']
>
>  qos_test_ss =3D ss.source_set()
>  qos_test_ss.add(
> diff --git a/tests/qtest/milkv-duo-test.c b/tests/qtest/milkv-duo-test.c
> new file mode 100644
> index 0000000000..06064b8733
> --- /dev/null
> +++ b/tests/qtest/milkv-duo-test.c
> @@ -0,0 +1,70 @@
> +/*
> + * QTest for Milk-V Duo Board
> + *
> + * Copyright (c) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +
> +#define CV1800B_CLK_BASE            0x03002000
> +#define CV1800B_CLK_BYPASS          0x030
> +#define CV1800B_CLK_BYPASS_RESET    0xFFFFFFFF
> +#define TEST_PATTERN_5A             0x5A5A5A5A
> +#define TEST_PATTERN_A5             0xA5A5A5A5
> +
> +#define CV1800B_UART0_BASE          0x04140000
> +#define DW_UART_UCV                 0xF8
> +#define DW_UART_CTR                 0xFC
> +#define DW_UART_VERSION_3_23A       0x3332332A
> +#define DW_UART_TYPE_SIGNATURE      0x44570110
> +
> +static void test_milkv_duo_uart(void)
> +{
> +    QTestState *qts;
> +    uint32_t component_version;
> +    uint32_t component_type;
> +
> +    qts =3D qtest_init("-M milkv-duo");
> +
> +    component_version =3D qtest_readl(qts, CV1800B_UART0_BASE + DW_UART_=
UCV);
> +    g_assert_cmphex(component_version, =3D=3D, DW_UART_VERSION_3_23A);
> +
> +    component_type =3D qtest_readl(qts, CV1800B_UART0_BASE + DW_UART_CTR=
);
> +    g_assert_cmphex(component_type, =3D=3D, DW_UART_TYPE_SIGNATURE);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_milkv_duo_clk(void)
> +{
> +    QTestState *qts;
> +    uint32_t clk_bypass_val;
> +
> +    qts =3D qtest_init("-M milkv-duo");
> +
> +    clk_bypass_val =3D qtest_readl(qts, CV1800B_CLK_BASE + CV1800B_CLK_B=
YPASS);
> +    g_assert_cmphex(clk_bypass_val, =3D=3D, CV1800B_CLK_BYPASS_RESET);
> +
> +    qtest_writel(qts, CV1800B_CLK_BASE + CV1800B_CLK_BYPASS, TEST_PATTER=
N_5A);
> +    clk_bypass_val =3D qtest_readl(qts, CV1800B_CLK_BASE + CV1800B_CLK_B=
YPASS);
> +    g_assert_cmphex(clk_bypass_val, =3D=3D, TEST_PATTERN_5A);
> +
> +    qtest_writel(qts, CV1800B_CLK_BASE + CV1800B_CLK_BYPASS, TEST_PATTER=
N_A5);
> +    clk_bypass_val =3D qtest_readl(qts, CV1800B_CLK_BASE + CV1800B_CLK_B=
YPASS);
> +    g_assert_cmphex(clk_bypass_val, =3D=3D, TEST_PATTERN_A5);
> +
> +    qtest_quit(qts);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    qtest_add_func("/riscv/milkv-duo/uart", test_milkv_duo_uart);
> +    qtest_add_func("/riscv/milkv-duo/clk", test_milkv_duo_clk);

Thanks for the tests. These are just checking some static values
though. Can you also add a boot test?

Alistair

