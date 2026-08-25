Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BF2C5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 06:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wykq9-0000Y3-BQ; Tue, 25 Aug 2026 02:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wykq7-0000Xo-9q
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 02:40:55 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wykq3-0001vZ-DV
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 02:40:55 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2d049069377so37712835ad.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 23:40:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787640050; cv=none;
 d=google.com; s=arc-20260327;
 b=eMGZGAlr4ZddtutbcAY/HDUDEGwzlN6UhFCzL09GDoBW5ljE5qA0hBFvk1AF3xe3jJ
 H845GXN7RSx9TdQ55TX1PPUajTyglFWlQrc8OjTSE13NrYIvl/UTnaC3jagyHTffUCVq
 uXwKzAoluwc4zltur3CtCKStMbg5Ne03EvJtUjlXTPs+qoBuzcg36wRD49nLVpDj+lGS
 oBcF5df85KU8o2F6z8W8sdH7uur9Dbd0FtKpMvci2l91xPlcXG+FLJFuLVdrCOhP4gx/
 1/ygfJu5ou1NYD0b+v4PND93sVsN0Ay2Q8t9lFfW9bDkmeVR6ZhgKs+0nY9qPhekfK+H
 sL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7EZ2jHKgWwyjgjTFvIiKy6OWRLbWgQ1pg2I2cDvA9nY=;
 fh=sJ3eX7jjZzOCgqrMn1f9NMjJLvjzC4zgTEsMCrATZ+w=;
 b=qiy8tDYsCtIlVSXfqzeuKqxE6RGHNmQeYSKDkgzOXzStwJI5HEhXtcYC35P2Bs1JZC
 bay9QbckKV66/HzwcVh+HvbxevwCBnCIKSBVZLb7x3MMJXc6vTzRJBVAbxfkrCPUZg+K
 wUkhI+12oLsMOfcmS3h2zaoIDGXYhwK6A4Eg+CqDc/cR5rwEj0QYuuurEh80SvXhjTk+
 8qKM6HsxoeYVnty5nxZP0/n9x9gW3LDCnYvjyk1HHqwbOaEWxDbn4US0AzKzq9TnaaH4
 Qfpjx4ToBt3D0MqLypBUKvkB9ANyFfA4Qrj0FMRSi8mN2BAvJlK/WmssJ1t6j8CKn98r
 MGQQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787640050; x=1788244850; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7EZ2jHKgWwyjgjTFvIiKy6OWRLbWgQ1pg2I2cDvA9nY=;
 b=By/HCdtRiHogoHP1j5vSVtsPUI+YfKzPQ1xsNZZsQMPWSl5vxnxDJnGbbFA1iyxHHj
 yZWkCAHypk+Tx1+oM6as6rgvO6z50uNDObAvIKq+lPXoL+l/qVDsM7vT+dEfJf5zr9GG
 Rw7o0uOoQg9O7uPBuTA3MYeIZ2yjNxNm4jdXNI0llBXwwa68VhSo1dv89Ju3nHX60bgy
 RQ5k/0/9ehwuElkh8zspmy527MnOV1GqLaX2JGQ4URSvcai23fRr3U/JvDJaGgdHLHhY
 ef7aAne1TP67OLZp/aD77LVzs7nx1SOLoMmMdHurYY+F0E/jzpW5cEf4QAQ1ZxF17ack
 cu2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787640050; x=1788244850;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7EZ2jHKgWwyjgjTFvIiKy6OWRLbWgQ1pg2I2cDvA9nY=;
 b=C9dSQ0/e/hwkrQbW3duc3GON00kg6VP+uNpqOC4S0R6KJbytbHmS4Zjo/En6awHL4y
 S92NVmWhhmxt7QP1CIl/1JGoCCqBsThcKrWA/IQd1LHx7bhQcqpL/tcsLlEpQM5TUJr4
 r9We91j+8+SZvosz5smeGSif2TT+IB7q19URWBeQBeXTeMQOQAC2Gnr9Hon2OIn8O797
 ixTYkdapwlQwSk4hORkZzJSvIAcf8kw9AMjNSautl83dGw1YG4BWCQ4Ro16gGZpPw+nU
 pL2oAaXXSdVO98oehG9KoZSg8UBHUW0AAnLLYQ4syaj0KdYuyq1000MZlgRbY8PkYv2M
 Qc4A==
X-Gm-Message-State: AFuF++kOV3gqaGYLkxYyl5TmeBP8Blll8KizsnWmRMSQh7CsfvuIPxBG
 IXIe24zr2lhKyS2+FJk+Du3+Ty3R6mJGe5HMjv3aTnG5Ne1GQTaDs4Zk/pQpYiL00KbZCfn2bCR
 P1fTtZuK80ntXrGdbwrxHcqwCs5wTSco=
X-Gm-Gg: AR+sD10S58o5IUEPBkmbv+/Ghu4hURpJaWU+tfnqgU1QPJ3HBuHcIkfrEYxm4ckOe3u
 N74E+WOmPva8eoZalAIqKFG0E7ir8GaE9qjvqWioQeHbYwnZVPX7I2S0jGN4QYatbJVNNiq3x72
 fXd68oQFDlon8o8JxLDpYoTITVKFLFJiPFbqUeObtgS18BEuvNKb9sNN+RZdysPtOEfo5hAA1CC
 Y+J50sMF4j25eP/6PyrL1B+h08BVJCmZpyPa2C6Cpp+/uEAeOyfV0xoBidn0JM3Elu99Gxp9zOq
 iXlbCJ+E4Tr5xGh1NoGObYwr/rtLGXS4hkP6Kedbe/lNILFPA92lHgdNOBA91gxkclruh4WIhPF
 3
X-Received: by 2002:a17:903:32c3:b0:2cc:777f:d67c with SMTP id
 d9443c01a7336-2d6dcc248c5mr75766735ad.13.1787640049487; Mon, 24 Aug 2026
 23:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
 <20260824054806.2790041-8-alistair.francis@wdc.com>
In-Reply-To: <20260824054806.2790041-8-alistair.francis@wdc.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 25 Aug 2026 10:40:36 +0400
X-Gm-Features: AcwNN1WlqgX_4UvTGRVCKFpQnqVDqoTBt-fF9eivFGAFNvc3S-Nmd9ub_YV9o-g
Message-ID: <CAJ+F1CJ+RxPZ+5kZkzTPzXG=2_cOWOmn_5tXFC28_4n1YuwD1g@mail.gmail.com>
Subject: Re: [PULL v2 07/96] tests/qtest: add test for K230 gsdma
To: alistair23@gmail.com
Cc: qemu-devel@nongnu.org, Tao Ding <dingtao0430@163.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Junze Cao <caojunze424@gmail.com>, 
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pl1-x633.google.com
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

On Mon, Aug 24, 2026 at 9:55=E2=80=AFAM <alistair23@gmail.com> wrote:
>
> From: Tao Ding <dingtao0430@163.com>
>
> This commit adds test cases for GSDMA.
> Imitate the behavior of the driver, set LLT and sdma registers.
> After the data transmission is completed, check the destination address d=
ata.
>
> Update MAINTAINERS for this test.
>
> Run this qtest:
>     $ mkdir build && cd build && ../configure --target-list=3D"riscv64-so=
ftmmu"
>     $ QTEST_QEMU_BINARY=3D./qemu-system-riscv64   tests/qtest/k230-gsdma-=
test
>
> Signed-off-by: Tao Ding <dingtao0430@163.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Junze Cao <caojunze424@gmail.com>
> Message-ID: <20260808062227.66961-4-dingtao0430@163.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  MAINTAINERS                        |   3 +
>  docs/system/riscv/k230.rst         |   1 +
>  include/hw/misc/k230_decomp_gzip.h |  92 ++++++
>  hw/misc/k230_decomp_gzip.c         | 511 +++++++++++++++++++++++++++++
>  tests/qtest/k230-gsdma-test.c      | 201 ++++++++++++
>  hw/misc/Kconfig                    |   3 +
>  hw/misc/meson.build                |   1 +
>  hw/misc/trace-events               |   8 +-
>  tests/qtest/meson.build            |   2 +-
>  9 files changed, 816 insertions(+), 6 deletions(-)
>  create mode 100644 include/hw/misc/k230_decomp_gzip.h
>  create mode 100644 hw/misc/k230_decomp_gzip.c
>  create mode 100644 tests/qtest/k230-gsdma-test.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 027db78b39..ff804b3310 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1848,13 +1848,16 @@ F: hw/misc/k230_ddr.c
>  F: hw/riscv/k230.c
>  F: hw/watchdog/k230_wdt.c
>  F: hw/dma/k230_gsdma.c
> +F: hw/misc/k230_decomp_gzip.c
>  F: include/hw/misc/k230_ddr.h
>  F: include/hw/riscv/k230.h
>  F: include/hw/watchdog/k230_wdt.h
>  F: include/hw/dma/k230_gsdma.h
> +F: include/hw/misc/k230_decomp_gzip.h
>  F: tests/functional/riscv64/test_k230.py
>  F: tests/qtest/k230-ddr-test.c
>  F: tests/qtest/k230-wdt-test.c
> +F: tests/qtest/k230-gsdma-test.c
>
>  RX Machines
>  -----------
> diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
> index 5cbc0b14bc..237611eddf 100644
> --- a/docs/system/riscv/k230.rst
> +++ b/docs/system/riscv/k230.rst
> @@ -22,6 +22,7 @@ The ``k230`` machine supports the following devices:
>  * 5 UART
>  * K230 DDRC CFG and DDR PHY
>  * System Direct Memory Access (SDMA)
> +* GZIP Decompress Engine (Decomp_gzip)
>
>  Boot options
>  ------------
> diff --git a/include/hw/misc/k230_decomp_gzip.h b/include/hw/misc/k230_de=
comp_gzip.h
> new file mode 100644
> index 0000000000..9911af0095
> --- /dev/null
> +++ b/include/hw/misc/k230_decomp_gzip.h
> @@ -0,0 +1,92 @@
> +/*
> + * K230 Decompress Engine
> + *
> + * Copyright (c) 2026 Tao Ding <dingtao0430@163.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_MISC_K230_DECOMP_GZIP_H
> +#define HW_MISC_K230_DECOMP_GZIP_H
> +
> +#include <zlib.h>
> +#include "hw/core/sysbus.h"
> +
> +#define TYPE_K230_DECOMP_GZIP "riscv.k230.decomp-gzip"
> +OBJECT_DECLARE_SIMPLE_TYPE(K230DecompGzipState, K230_DECOMP_GZIP)
> +
> +/* K230 DECOMP GZIP ACK input */
> +enum {
> +    K230_DECOMP_GZIP_GPIO_DMA_WRITE_ACK,
> +    K230_DECOMP_GZIP_GPIO_DMA_READ_ACK,
> +    K230_DECOMP_GZIP_NUM_GPIOS_IN,
> +};
> +
> +/* K230 DECOMP GZIP REQ output */
> +enum {
> +    K230_DECOMP_GZIP_GPIO_DECOMP_CTRL_EN,
> +    K230_DECOMP_GZIP_GPIO_DMA_WRITE_REQ,
> +    K230_DECOMP_GZIP_GPIO_DMA_READ_REQ,
> +    K230_DECOMP_GZIP_NUM_GPIOS_OUT,
> +};
> +
> +#define K230_DECOMP_GZIP_MMIO_SIZE       0x4000
> +
> +/* K230 DECOMP GZIP Registers map */
> +/* Start decompression controller */
> +#define K230_DECOMP_GZIP_DECOMP_START    0x00
> +/* Source data length register */
> +#define K230_DECOMP_GZIP_GZIP_SRC_SIZE   0x04
> +/* Output data length register */
> +#define K230_DECOMP_GZIP_GZIP_OUT_SIZE   0x08
> +/* Decompress status register */
> +#define K230_DECOMP_GZIP_DECOMP_STAT     0x0c
> +
> +/* Start decompression controller */
> +#define K230_DECOMP_GZIP_START           (1U << 0)
> +
> +#define K230_DECOMP_GZIP_CTRL_EN         (1U << 31)
> +#define K230_DECOMP_GZIP_DMA_IN_MASK     0x7fffffffU
> +
> +#define K230_DECOMP_GZIP_STAT_CRC_OK     (1U << 10)
> +#define K230_DECOMP_GZIP_STAT_STATE_MASK 0xfU
> +
> +#define K230_DECOMP_GZIP_BLOCK_SIZE      0x00020000
> +#define K230_DECOMP_GZIP_SRAM_IN_BASE    0x80000
> +#define K230_DECOMP_GZIP_SRAM_OUT_BASE   0
> +
> +typedef struct K230DecompGzipSlotState {
> +    uint32_t slot;  /* Slot index */
> +    /*
> +     * Data offset in current slot.
> +     * First valid data in input buffer. Last valid data in output buffe=
r.
> +     */
> +    uint32_t current_offset;
> +} K230DecompGzipSlotState;
> +
> +struct K230DecompGzipState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion iomem;
> +    hwaddr sram_base;
> +    qemu_irq signal_out[K230_DECOMP_GZIP_NUM_GPIOS_OUT];
> +    uint32_t decomp_start;
> +    uint32_t gzip_src_size;
> +    uint32_t gzip_out_size;
> +    uint32_t decomp_stat;
> +    K230DecompGzipSlotState input;  /* decomp gzip ring input */
> +    K230DecompGzipSlotState output; /* decomp gzip ring output */
> +    uint32_t total_requested;
> +    uint32_t total_produced;
> +    bool active;
> +    bool in_kick;
> +    bool zstream_inited;
> +    bool stream_end;
> +    /* Read from ring input. */
> +    uint8_t input_buf[K230_DECOMP_GZIP_BLOCK_SIZE];
> +    /* Write to ring output. */
> +    uint8_t output_buf[K230_DECOMP_GZIP_BLOCK_SIZE];
> +    z_stream zs;
> +};
> +
> +#endif
> diff --git a/hw/misc/k230_decomp_gzip.c b/hw/misc/k230_decomp_gzip.c
> new file mode 100644
> index 0000000000..0d8a3b2d2e
> --- /dev/null
> +++ b/hw/misc/k230_decomp_gzip.c
> @@ -0,0 +1,511 @@
> +/*
> + * Kendryte K230 GZIP decompression engine
> + *
> + * Copyright (c) 2026 Tao Ding <dingtao0430@163.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Decompression accelerator is mainly used to implement hardware
> + * GZIP decompression function. (K230 TRM section 15)
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "hw/core/qdev-properties.h"
> +#include "migration/vmstate.h"
> +#include "system/address-spaces.h"
> +#include "hw/core/irq.h"
> +#include "hw/misc/k230_decomp_gzip.h"
> +#include "trace.h"
> +
> +#define GZIP_METHOD_DEFLATE    8
> +#define GZIP_METHOD_VENDOR_9   9
> +
> +#define DEFLATE_BTYPE_DYNAMIC  2
> +
> +#define K230_DECOMP_GZIP_OUTPUT_SLOTS 4
> +#define K230_DECOMP_GZIP_INPUT_SLOTS 2
> +
> +static void k230_decomp_gzip_set_output(K230DecompGzipState *s, int line=
,
> +                                        int level)
> +{
> +    qemu_set_irq(s->signal_out[line], level);
> +}
> +
> +static bool k230_decomp_gzip_read_mem(K230DecompGzipState *s, hwaddr add=
r,
> +                                      void *buf, size_t len)
> +{
> +    MemTxResult ret =3D address_space_read(&address_space_memory,
> +                                         s->sram_base + addr,
> +                                         MEMTXATTRS_UNSPECIFIED, buf, le=
n);
> +
> +    return ret =3D=3D MEMTX_OK;
> +}
> +
> +static bool k230_decomp_gzip_write_mem(K230DecompGzipState *s, hwaddr ad=
dr,
> +                                       const void *buf, size_t len)
> +{
> +    return address_space_write(&address_space_memory, s->sram_base + add=
r,
> +                               MEMTXATTRS_UNSPECIFIED, buf, len) =3D=3D =
MEMTX_OK;
> +}
> +
> +static hwaddr k230_decomp_gzip_output_addr(K230DecompGzipState *s)
> +{
> +    return K230_DECOMP_GZIP_SRAM_OUT_BASE +
> +           s->output.slot * K230_DECOMP_GZIP_BLOCK_SIZE +
> +           s->output.current_offset;
> +}
> +
> +static hwaddr k230_decomp_gzip_input_addr(K230DecompGzipState *s)
> +{
> +    return s->input.slot * K230_DECOMP_GZIP_BLOCK_SIZE +
> +           K230_DECOMP_GZIP_SRAM_IN_BASE;
> +}
> +
> +static uint32_t k230_decomp_gzip_current_input_size(K230DecompGzipState =
*s)
> +{
> +    if (s->total_requested =3D=3D 0) {
> +        return 0;
> +    }
> +
> +    return ((s->total_requested - 1) % K230_DECOMP_GZIP_BLOCK_SIZE) + 1;
> +}
> +
> +static void k230_decomp_gzip_update_ctrl_en(K230DecompGzipState *s)
> +{
> +    int level =3D s->active && !!(s->gzip_src_size & K230_DECOMP_GZIP_CT=
RL_EN);
> +
> +    k230_decomp_gzip_set_output(s, K230_DECOMP_GZIP_GPIO_DECOMP_CTRL_EN,
> +                                level);
> +}
> +
> +static void k230_decomp_gzip_reset_stream(K230DecompGzipState *s)
> +{
> +    if (s->zstream_inited) {
> +        inflateEnd(&s->zs);
> +        s->zstream_inited =3D false;
> +    }
> +    memset(&s->zs, 0, sizeof(s->zs));
> +}
> +
> +static void k230_decomp_gzip_finish(K230DecompGzipState *s, bool crc_ok)
> +{
> +    s->active =3D false;
> +    k230_decomp_gzip_reset_stream(s);
> +    k230_decomp_gzip_update_ctrl_en(s);
> +    if (crc_ok) {
> +        s->decomp_stat |=3D K230_DECOMP_GZIP_STAT_CRC_OK;
> +    } else {
> +        s->decomp_stat &=3D ~K230_DECOMP_GZIP_STAT_CRC_OK;
> +    }
> +}
> +
> +static bool k230_decomp_gzip_load_input(K230DecompGzipState *s,
> +                                        uint32_t addr, uint32_t size)
> +{
> +    s->input.current_offset =3D 0;
> +
> +    return k230_decomp_gzip_read_mem(s, addr, s->input_buf, size);
> +}
> +
> +static bool k230_decomp_gzip_request_input(K230DecompGzipState *s)
> +{
> +    uint32_t total_requested =3D s->total_requested;
> +
> +    k230_decomp_gzip_set_output(s, K230_DECOMP_GZIP_GPIO_DMA_WRITE_REQ, =
1);
> +    if (s->total_requested =3D=3D total_requested) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: dma write request not acknowledged\n",
> +                      TYPE_K230_DECOMP_GZIP);
> +        return false;
> +    }
> +    return true;
> +}
> +
> +static bool k230_decomp_gzip_request_output(K230DecompGzipState *s)
> +{
> +    uint32_t slot =3D s->output.slot;
> +    uint32_t current_offset =3D s->output.current_offset;
> +
> +    k230_decomp_gzip_set_output(s, K230_DECOMP_GZIP_GPIO_DMA_READ_REQ, 1=
);
> +    if (s->output.slot =3D=3D slot &&
> +        s->output.current_offset =3D=3D current_offset) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: dma read request not acknowledged\n",
> +                      TYPE_K230_DECOMP_GZIP);
> +        return false;
> +    }
> +    return true;
> +}
> +
> +static bool k230_decomp_gzip_init_stream(K230DecompGzipState *s)
> +{
> +    uint8_t btype =3D (s->input_buf[10] >> 1) & 0x3;
> +    if (btype !=3D DEFLATE_BTYPE_DYNAMIC) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: unsupported DEFLATE BTYPE %u\n",
> +                      TYPE_K230_DECOMP_GZIP, btype);
> +        return false;
> +    }
> +
> +    /* The compression script for K230 will modify the third byte to 0x9=
 */
> +    if (s->input_buf[2] =3D=3D GZIP_METHOD_VENDOR_9) {
> +        s->input_buf[2] =3D GZIP_METHOD_DEFLATE;
> +    }
> +
> +    if (inflateInit2(&s->zs, 15 + 16) !=3D Z_OK) {
> +        return false;
> +    }
> +
> +    s->zstream_inited =3D true;
> +    return true;
> +}
> +
> +static bool k230_decomp_gzip_run_inflate(K230DecompGzipState *s)
> +{
> +    uint32_t output_size =3D s->gzip_out_size;
> +    uint32_t current_input_size =3D k230_decomp_gzip_current_input_size(=
s);
> +    uint32_t avail_in;
> +    uint32_t avail_out;
> +    uint32_t consumed;
> +    uint32_t produced;
> +    int ret;
> +
> +    avail_in =3D current_input_size - s->input.current_offset;
> +    avail_out =3D K230_DECOMP_GZIP_BLOCK_SIZE - s->output.current_offset=
;
> +
> +    s->zs.next_in =3D s->input_buf + s->input.current_offset;
> +    s->zs.avail_in =3D avail_in;
> +    s->zs.next_out =3D s->output_buf;
> +    s->zs.avail_out =3D avail_out;
> +
> +    ret =3D inflate(&s->zs, Z_NO_FLUSH);
> +    if (ret !=3D Z_OK && ret !=3D Z_STREAM_END && ret !=3D Z_BUF_ERROR) =
{
> +        return false;
> +    }
> +
> +    consumed =3D avail_in - s->zs.avail_in;
> +    produced =3D avail_out - s->zs.avail_out;
> +
> +    if (produced) {
> +        if (s->total_produced + produced > output_size ||
> +            !k230_decomp_gzip_write_mem(s, k230_decomp_gzip_output_addr(=
s),
> +                                        s->output_buf, produced)) {
> +            return false;
> +        }
> +        s->output.current_offset +=3D produced;
> +        s->total_produced +=3D produced;
> +    }
> +
> +    if (consumed) {
> +        s->input.current_offset +=3D consumed;
> +    }
> +
> +    if (ret =3D=3D Z_STREAM_END) {
> +        s->stream_end =3D true;
> +        if (s->total_produced !=3D output_size) {
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
> +
> +static void k230_decomp_gzip_kick(K230DecompGzipState *s)
> +{
> +    if (!s->active || s->in_kick) {
> +        return;
> +    }
> +
> +    uint32_t input_size =3D s->gzip_src_size & K230_DECOMP_GZIP_DMA_IN_M=
ASK;
> +    s->in_kick =3D true;
> +    while (s->active) {
> +        uint32_t current_input_size =3D k230_decomp_gzip_current_input_s=
ize(s);
> +        /* Output is full or last block */
> +        if (s->output.current_offset =3D=3D K230_DECOMP_GZIP_BLOCK_SIZE =
||
> +            (s->stream_end && s->output.current_offset !=3D 0)) {
> +            if (!k230_decomp_gzip_request_output(s)) {
> +                k230_decomp_gzip_finish(s, false);
> +                break;
> +            }
> +            continue;
> +        }
> +
> +        if (!s->zstream_inited) {
> +            if (!k230_decomp_gzip_request_input(s) ||
> +                !k230_decomp_gzip_init_stream(s)) {
> +                k230_decomp_gzip_finish(s, false);
> +                break;
> +            }
> +            continue;
> +        }
> +
> +        /* Transfer finish */
> +        if (s->stream_end) {
> +            k230_decomp_gzip_finish(s,
> +                                    s->total_produced =3D=3D s->gzip_out=
_size);
> +            break;
> +        }
> +
> +        /* Input buf has has been fully decompreed, need request more */
> +        if (s->input.current_offset =3D=3D current_input_size) {
> +            if (s->total_requested < input_size) {
> +                if (!k230_decomp_gzip_request_input(s)) {
> +                    k230_decomp_gzip_finish(s, false);
> +                    break;
> +                }
> +                continue;
> +            }
> +            k230_decomp_gzip_finish(s, false);
> +            break;
> +        }
> +
> +        /* Decompress the data, input buf or output buf are consumed in =
one block */
> +        if (!k230_decomp_gzip_run_inflate(s)) {
> +            k230_decomp_gzip_finish(s, false);
> +            break;
> +        }
> +    }
> +    s->in_kick =3D false;
> +}
> +
> +static void k230_decomp_gzip_handle_ack(void *opaque, int n, int level)
> +{
> +    K230DecompGzipState *s =3D opaque;
> +
> +    if (!level || !s->active) {
> +        return;
> +    }
> +
> +    switch (n) {
> +    case K230_DECOMP_GZIP_GPIO_DMA_WRITE_ACK:
> +    {
> +        uint32_t input_size =3D s->gzip_src_size & K230_DECOMP_GZIP_DMA_=
IN_MASK;
> +        uint32_t chunk =3D MIN(K230_DECOMP_GZIP_BLOCK_SIZE,
> +                             input_size - s->total_requested);
> +
> +        if (!k230_decomp_gzip_load_input(s, k230_decomp_gzip_input_addr(=
s),
> +                                         chunk)) {
> +            k230_decomp_gzip_finish(s, false);
> +            return;
> +        }
> +        s->total_requested +=3D chunk;
> +        s->input.slot =3D (s->input.slot + 1) % K230_DECOMP_GZIP_INPUT_S=
LOTS;
> +        break;
> +    }
> +    case K230_DECOMP_GZIP_GPIO_DMA_READ_ACK:
> +        if (s->output.current_offset =3D=3D 0) {
> +            k230_decomp_gzip_finish(s, false);
> +            return;
> +        }
> +        s->output.slot =3D (s->output.slot + 1) % K230_DECOMP_GZIP_OUTPU=
T_SLOTS;
> +        s->output.current_offset =3D 0;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: invalid DMA acknowledgment signal %d\n",
> +                      TYPE_K230_DECOMP_GZIP, n);
> +        return;
> +    }
> +
> +    k230_decomp_gzip_kick(s);
> +}
> +
> +static void k230_decomp_gzip_start(K230DecompGzipState *s)
> +{
> +    uint32_t input_size =3D s->gzip_src_size & K230_DECOMP_GZIP_DMA_IN_M=
ASK;
> +
> +    k230_decomp_gzip_reset_stream(s);
> +    s->decomp_stat &=3D ~K230_DECOMP_GZIP_STAT_CRC_OK;
> +    s->total_requested =3D 0;
> +    s->total_produced =3D 0;
> +    s->stream_end =3D false;
> +    memset(&s->input, 0, sizeof(s->input));
> +    memset(&s->output, 0, sizeof(s->output));
> +
> +    if (!(s->gzip_src_size & K230_DECOMP_GZIP_CTRL_EN) ||
> +        input_size =3D=3D 0 || s->gzip_out_size =3D=3D 0) {
> +        k230_decomp_gzip_finish(s, false);
> +        return;
> +    }
> +
> +    s->active =3D true;
> +    k230_decomp_gzip_update_ctrl_en(s);
> +    k230_decomp_gzip_kick(s);
> +}
> +
> +static uint64_t k230_decomp_gzip_read(void *opaque, hwaddr offset,
> +                                      unsigned size)
> +{
> +    K230DecompGzipState *s =3D opaque;
> +    uint64_t value =3D 0;
> +
> +    switch (offset) {
> +    case K230_DECOMP_GZIP_DECOMP_START:
> +        value =3D s->decomp_start & ~K230_DECOMP_GZIP_START; /* start bi=
t is write only */
> +        break;
> +    case K230_DECOMP_GZIP_GZIP_SRC_SIZE:
> +        value =3D s->gzip_src_size;
> +        break;
> +    case K230_DECOMP_GZIP_GZIP_OUT_SIZE:
> +        value =3D s->gzip_out_size;
> +        break;
> +    case K230_DECOMP_GZIP_DECOMP_STAT:
> +        value =3D s->decomp_stat;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: bad read offset 0x%" HWADDR_PRIx "\n",
> +                      TYPE_K230_DECOMP_GZIP, offset);
> +        break;
> +    }
> +
> +    trace_k230_decomp_gzip_read(offset, size, value);
> +    return value;
> +}
> +
> +static void k230_decomp_gzip_write(void *opaque, hwaddr offset,
> +                                   uint64_t value, unsigned size)
> +{
> +    K230DecompGzipState *s =3D opaque;
> +
> +    trace_k230_decomp_gzip_write(offset, size, value);
> +
> +    switch (offset) {
> +    case K230_DECOMP_GZIP_DECOMP_START:
> +        s->decomp_start =3D value;
> +        if (value & K230_DECOMP_GZIP_START) {
> +            k230_decomp_gzip_start(s);
> +        }
> +        break;
> +    case K230_DECOMP_GZIP_GZIP_SRC_SIZE:
> +        s->gzip_src_size =3D value;
> +        k230_decomp_gzip_update_ctrl_en(s);
> +        break;
> +    case K230_DECOMP_GZIP_GZIP_OUT_SIZE:
> +        s->gzip_out_size =3D value;
> +        break;
> +    case K230_DECOMP_GZIP_DECOMP_STAT:
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: bad write offset 0x%" HWADDR_PRIx "\n",
> +                      TYPE_K230_DECOMP_GZIP, offset);
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps k230_decomp_gzip_ops =3D {
> +    .read =3D k230_decomp_gzip_read,
> +    .write =3D k230_decomp_gzip_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .valid.min_access_size =3D 4,
> +    .valid.max_access_size =3D 4,
> +    .impl.min_access_size =3D 4,
> +    .impl.max_access_size =3D 4,
> +};
> +
> +static const VMStateDescription vmstate_k230_decomp_gzip_slot =3D {
> +    .name =3D "k230.decomp-gzip.slot",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (const VMStateField[]) {
> +        VMSTATE_UINT32(slot, K230DecompGzipSlotState),
> +        VMSTATE_UINT32(current_offset, K230DecompGzipSlotState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription vmstate_k230_decomp_gzip =3D {
> +    .name =3D "k230.decomp-gzip",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (const VMStateField[]) {
> +        VMSTATE_UINT32(decomp_start, K230DecompGzipState),
> +        VMSTATE_UINT32(gzip_src_size, K230DecompGzipState),
> +        VMSTATE_UINT32(gzip_out_size, K230DecompGzipState),
> +        VMSTATE_UINT32(decomp_stat, K230DecompGzipState),
> +        VMSTATE_STRUCT(input, K230DecompGzipState, 1,
> +                       vmstate_k230_decomp_gzip_slot,
> +                       K230DecompGzipSlotState),
> +        VMSTATE_STRUCT(output, K230DecompGzipState, 1,
> +                       vmstate_k230_decomp_gzip_slot,
> +                       K230DecompGzipSlotState),
> +        VMSTATE_UINT32(total_requested, K230DecompGzipState),
> +        VMSTATE_UINT32(total_produced, K230DecompGzipState),
> +        VMSTATE_BOOL(active, K230DecompGzipState),
> +        VMSTATE_BOOL(in_kick, K230DecompGzipState),
> +        VMSTATE_BOOL(zstream_inited, K230DecompGzipState),
> +        VMSTATE_BOOL(stream_end, K230DecompGzipState),
> +        VMSTATE_UINT8_ARRAY(input_buf, K230DecompGzipState,
> +                            K230_DECOMP_GZIP_BLOCK_SIZE),
> +        VMSTATE_UINT8_ARRAY(output_buf, K230DecompGzipState,
> +                            K230_DECOMP_GZIP_BLOCK_SIZE),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void k230_decomp_gzip_reset_hold(Object *obj, ResetType type)
> +{
> +    K230DecompGzipState *s =3D K230_DECOMP_GZIP(obj);
> +
> +    k230_decomp_gzip_reset_stream(s);
> +    memset(&s->zs, 0, sizeof(s->zs));
> +    s->decomp_start =3D 0;
> +    s->gzip_src_size =3D 0;
> +    s->gzip_out_size =3D 0;
> +    s->decomp_stat =3D 0;
> +    memset(&s->input, 0, sizeof(s->input));
> +    memset(&s->output, 0, sizeof(s->output));
> +    s->total_requested =3D 0;
> +    s->total_produced =3D 0;
> +    s->active =3D false;
> +    s->in_kick =3D false;
> +    s->stream_end =3D false;
> +}
> +
> +static void k230_decomp_gzip_realize(DeviceState *dev, Error **errp)
> +{
> +    K230DecompGzipState *s =3D K230_DECOMP_GZIP(dev);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> +
> +    memory_region_init_io(&s->iomem, OBJECT(dev), &k230_decomp_gzip_ops,=
 s,
> +                          TYPE_K230_DECOMP_GZIP,
> +                          K230_DECOMP_GZIP_MMIO_SIZE);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +    qdev_init_gpio_in(dev, k230_decomp_gzip_handle_ack,
> +                      K230_DECOMP_GZIP_NUM_GPIOS_IN);
> +    qdev_init_gpio_out(dev, s->signal_out,
> +                       K230_DECOMP_GZIP_NUM_GPIOS_OUT);
> +}
> +
> +static const Property k230_decomp_gzip_properties[] =3D {
> +    DEFINE_PROP_UINT64("sram-base", K230DecompGzipState, sram_base, 0),
> +};
> +
> +static void k230_decomp_gzip_class_init(ObjectClass *oc, const void *dat=
a)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> +    ResettableClass *rc =3D RESETTABLE_CLASS(oc);
> +
> +    dc->realize =3D k230_decomp_gzip_realize;
> +    rc->phases.hold =3D k230_decomp_gzip_reset_hold;
> +    device_class_set_props(dc, k230_decomp_gzip_properties);
> +    dc->vmsd =3D &vmstate_k230_decomp_gzip;
> +    dc->desc =3D "Kendryte K230 GZIP decompression engine";
> +}
> +
> +static const TypeInfo k230_decomp_gzip_info =3D {
> +    .name =3D TYPE_K230_DECOMP_GZIP,
> +    .parent =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(K230DecompGzipState),
> +    .class_init =3D k230_decomp_gzip_class_init,
> +};
> +
> +static void k230_decomp_gzip_register_types(void)
> +{
> +    type_register_static(&k230_decomp_gzip_info);
> +}
> +
> +type_init(k230_decomp_gzip_register_types)
> diff --git a/tests/qtest/k230-gsdma-test.c b/tests/qtest/k230-gsdma-test.=
c
> new file mode 100644
> index 0000000000..44d4248739
> --- /dev/null
> +++ b/tests/qtest/k230-gsdma-test.c
> @@ -0,0 +1,201 @@
> +/*
> + * QTest testcase for K230 GSDMA
> + *
> + * Copyright (c) 2026 Tao Ding <dingtao0430@163.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/bitops.h"
> +#include "exec/hwaddr.h"
> +#include "hw/dma/k230_gsdma.h"
> +#include "libqtest.h"
> +
> +#define K230_GSDMA_BASE              0x80800000
> +#define TEST_LLT_ADDR0               0x10000
> +#define TEST_LLT_ADDR1               0x10040
> +#define TEST_LLT_ADDR2               0x10080
> +
> +#define TEST_SRC_ADDR0               0x20000
> +#define TEST_SRC_ADDR1               0x22000
> +#define TEST_SRC_ADDR2               0x23000
> +#define TEST_DST_ADDR0               0x30000
> +#define TEST_DST_ADDR1               0x32000
> +#define TEST_DST_ADDR2               0x33000
> +
> +static inline uint64_t gsdma_reg(hwaddr off)
> +{
> +    return K230_GSDMA_BASE + off;
> +}
> +
> +static inline uint64_t gsdma_ch_reg(unsigned int ch, hwaddr off)
> +{
> +    return K230_GSDMA_BASE + K230_GSDMA_CH_BASE +
> +           ch * K230_GSDMA_CH_STRIDE + off;
> +}
> +
> +static void write_sdma_llt_node_full(QTestState *qts, hwaddr addr,
> +                                     uint32_t cfg, hwaddr src,
> +                                     uint32_t size, hwaddr dst,
> +                                     hwaddr next)
> +{
> +    qtest_writel(qts, addr + offsetof(K230GSDMALLT, cfg), cfg);
> +    qtest_writel(qts, addr + offsetof(K230GSDMALLT, src_addr), src);
> +    qtest_writel(qts, addr + offsetof(K230GSDMALLT, line_size), size);
> +    qtest_writel(qts, addr + offsetof(K230GSDMALLT, line_cfg), 0x1);
> +    qtest_writel(qts, addr + offsetof(K230GSDMALLT, dst_addr), dst);
> +    qtest_writel(qts, addr + offsetof(K230GSDMALLT, next_llt_addr), next=
);
> +}
> +
> +static void write_sdma_llt_node(QTestState *qts, hwaddr addr, uint32_t c=
fg,
> +                                uint32_t next)
> +{
> +    write_sdma_llt_node_full(qts, addr, cfg, 0x11110000, 0x200,
> +                             0x22220000, next);
> +}
> +
> +static void fill_pattern(uint8_t *buf, size_t size, uint8_t seed)
> +{
> +    for (size_t i =3D 0; i < size; i++) {
> +        buf[i] =3D seed + i * 37;
> +    }
> +}
> +
> +static void test_global_registers(void)
> +{
> +    QTestState *qts =3D qtest_init("-machine k230");
> +
> +    g_assert_cmphex(qtest_readl(qts, gsdma_reg(K230_GSDMA_DMA_CFG)), =3D=
=3D,
> +                    K230_GSDMA_DMA_CFG_RESET);
> +
> +    qtest_writel(qts, gsdma_reg(K230_GSDMA_DMA_CH_EN), 0xff);
> +    g_assert_cmphex(qtest_readl(qts, gsdma_reg(K230_GSDMA_DMA_CH_EN)), =
=3D=3D,
> +                    K230_GSDMA_DMA_CH_EN_MASK);
> +
> +    qtest_writel(qts, gsdma_reg(K230_GSDMA_DMA_INT_MASK), 0x12345);
> +    g_assert_cmphex(qtest_readl(qts, gsdma_reg(K230_GSDMA_DMA_INT_MASK))=
, =3D=3D,
> +                    0x12345);
> +
> +    qtest_writel(qts, gsdma_reg(K230_GSDMA_DMA_CFG), 0xa5a5a5a5);
> +    g_assert_cmphex(qtest_readl(qts, gsdma_reg(K230_GSDMA_DMA_CFG)), =3D=
=3D,
> +                    0xa5a5a5a5);
> +
> +    qtest_writel(qts, gsdma_reg(K230_GSDMA_DMA_WEIGHT), 0xff55aa55);
> +    g_assert_cmphex(qtest_readl(qts, gsdma_reg(K230_GSDMA_DMA_WEIGHT)), =
=3D=3D,
> +                    0x55aa55);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_sdma_pause_resume(void)
> +{
> +    uint32_t int_stat;
> +    QTestState *qts =3D qtest_init("-machine k230");
> +
> +    write_sdma_llt_node(qts, TEST_LLT_ADDR0, K230_GSDMA_LLT_PAUSE,
> +                        TEST_LLT_ADDR1);
> +    write_sdma_llt_node(qts, TEST_LLT_ADDR1, K230_GSDMA_LLT_NODE_INTR, 0=
);
> +
> +    qtest_writel(qts, gsdma_reg(K230_GSDMA_DMA_CH_EN), BIT(0));
> +    qtest_writel(qts, gsdma_ch_reg(0, K230_GSDMA_CH_LLT_SADDR), TEST_LLT=
_ADDR0);
> +    qtest_writel(qts, gsdma_ch_reg(0, K230_GSDMA_CH_CTL), K230_GSDMA_CTL=
_START);
> +
> +    g_assert_cmphex(qtest_readl(qts, gsdma_ch_reg(0, K230_GSDMA_CH_STATU=
S)), =3D=3D,
> +                    K230_GSDMA_SDMA_STATUS_PAUSE);
> +    g_assert_cmphex(qtest_readl(qts, gsdma_ch_reg(0, K230_GSDMA_CH_CURRE=
NT_LLT)),
> +                    =3D=3D, TEST_LLT_ADDR0);
> +
> +    int_stat =3D qtest_readl(qts, gsdma_reg(K230_GSDMA_DMA_INT_STAT));
> +    g_assert_cmphex(int_stat & K230_GSDMA_SDMA_PAUSE_INT(0), =3D=3D,
> +                    K230_GSDMA_SDMA_PAUSE_INT(0));
> +    g_assert_cmphex(int_stat & K230_GSDMA_SDMA_DONE_INT(0), =3D=3D, 0);
> +
> +    qtest_writel(qts, gsdma_reg(K230_GSDMA_DMA_INT_STAT), int_stat);
> +    qtest_writel(qts, gsdma_ch_reg(0, K230_GSDMA_CH_CTL), K230_GSDMA_CTL=
_RESUME);
> +
> +    g_assert_cmphex(qtest_readl(qts, gsdma_ch_reg(0, K230_GSDMA_CH_STATU=
S)), =3D=3D,
> +                    0);
> +    g_assert_cmphex(qtest_readl(qts, gsdma_ch_reg(0, K230_GSDMA_CH_CURRE=
NT_LLT)),
> +                    =3D=3D, TEST_LLT_ADDR1);
> +
> +    int_stat =3D qtest_readl(qts, gsdma_reg(K230_GSDMA_DMA_INT_STAT));
> +    g_assert_cmphex(int_stat & K230_GSDMA_SDMA_DONE_INT(0), =3D=3D,
> +                    K230_GSDMA_SDMA_DONE_INT(0));
> +    g_assert_cmphex(int_stat & K230_GSDMA_SDMA_ITEM_INT(0), =3D=3D,
> +                    K230_GSDMA_SDMA_ITEM_INT(0));
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_sdma_three_llt_copy(void)
> +{
> +    uint8_t src0[0x1000];
> +    uint8_t src1[1];
> +    uint8_t src2[511];
> +    uint8_t dst0[sizeof(src0)];
> +    uint8_t dst1[sizeof(src1)];
> +    uint8_t dst2[sizeof(src2)];
> +    uint32_t int_stat;
> +    QTestState *qts =3D qtest_init("-machine k230");
> +
> +    fill_pattern(src0, sizeof(src0), 0x10);
> +    fill_pattern(src1, sizeof(src1), 0x31);
> +    fill_pattern(src2, sizeof(src2), 0x52);
> +    memset(dst0, 0xa5, sizeof(dst0));
> +    memset(dst1, 0xa5, sizeof(dst1));
> +    memset(dst2, 0xa5, sizeof(dst2));
> +
> +    qtest_memwrite(qts, TEST_SRC_ADDR0, src0, sizeof(src0));
> +    qtest_memwrite(qts, TEST_SRC_ADDR1, src1, sizeof(src1));
> +    qtest_memwrite(qts, TEST_SRC_ADDR2, src2, sizeof(src2));
> +    qtest_memwrite(qts, TEST_DST_ADDR0, dst0, sizeof(dst0));
> +    qtest_memwrite(qts, TEST_DST_ADDR1, dst1, sizeof(dst1));
> +    qtest_memwrite(qts, TEST_DST_ADDR2, dst2, sizeof(dst2));
> +
> +    write_sdma_llt_node_full(qts, TEST_LLT_ADDR0, 0, TEST_SRC_ADDR0,
> +                             sizeof(src0), TEST_DST_ADDR0, TEST_LLT_ADDR=
1);
> +    write_sdma_llt_node_full(qts, TEST_LLT_ADDR1, 0, TEST_SRC_ADDR1,
> +                             sizeof(src1), TEST_DST_ADDR1, TEST_LLT_ADDR=
2);
> +    write_sdma_llt_node_full(qts, TEST_LLT_ADDR2, 0, TEST_SRC_ADDR2,
> +                             sizeof(src2), TEST_DST_ADDR2, 0);
> +
> +    qtest_writel(qts, gsdma_reg(K230_GSDMA_DMA_CH_EN), BIT(0));
> +    qtest_writel(qts, gsdma_ch_reg(0, K230_GSDMA_CH_LLT_SADDR), TEST_LLT=
_ADDR0);
> +    qtest_writel(qts, gsdma_ch_reg(0, K230_GSDMA_CH_CTL), K230_GSDMA_CTL=
_START);
> +
> +    g_assert_cmphex(qtest_readl(qts, gsdma_ch_reg(0, K230_GSDMA_CH_STATU=
S)), =3D=3D,
> +                    0);
> +    g_assert_cmphex(qtest_readl(qts, gsdma_ch_reg(0, K230_GSDMA_CH_CURRE=
NT_LLT)),
> +                    =3D=3D, TEST_LLT_ADDR2);
> +
> +    int_stat =3D qtest_readl(qts, gsdma_reg(K230_GSDMA_DMA_INT_STAT));
> +    g_assert_cmphex(int_stat & K230_GSDMA_SDMA_DONE_INT(0), =3D=3D,
> +                    K230_GSDMA_SDMA_DONE_INT(0));
> +    g_assert_cmphex(int_stat & K230_GSDMA_SDMA_PAUSE_INT(0), =3D=3D, 0);
> +
> +    memset(dst0, 0, sizeof(dst0));
> +    memset(dst1, 0, sizeof(dst1));
> +    memset(dst2, 0, sizeof(dst2));
> +    qtest_memread(qts, TEST_DST_ADDR0, dst0, sizeof(dst0));
> +    qtest_memread(qts, TEST_DST_ADDR1, dst1, sizeof(dst1));
> +    qtest_memread(qts, TEST_DST_ADDR2, dst2, sizeof(dst2));
> +
> +    g_assert_cmpmem(dst0, sizeof(dst0), src0, sizeof(src0));
> +    g_assert_cmpmem(dst1, sizeof(dst1), src1, sizeof(src1));
> +    g_assert_cmpmem(dst2, sizeof(dst2), src2, sizeof(src2));
> +
> +    qtest_quit(qts);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    qtest_add_func("/k230-gsdma/global-registers", test_global_registers=
);
> +    qtest_add_func("/k230-gsdma/sdma-pause-resume", test_sdma_pause_resu=
me);
> +    qtest_add_func("/k230-gsdma/sdma-three-llt-copy",
> +                   test_sdma_three_llt_copy);
> +
> +    return g_test_run();
> +}
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index b8860dd3e7..46e3c03cc8 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -260,4 +260,7 @@ config XLNX_ZYNQ_DDRC
>  config AXIADO_CLK
>      bool
>
> +config K230_DECOMP_GZIP
> +    bool
> +
>  source macio/Kconfig
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index cbeecbf1e0..54e07aacda 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -38,6 +38,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: fi=
les('sifive_e_prci.c'))
>  system_ss.add(when: 'CONFIG_SIFIVE_E_AON', if_true: files('sifive_e_aon.=
c'))
>  system_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.=
c'))
>  system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prc=
i.c'))
> +system_ss.add(when: 'CONFIG_K230_DECOMP_GZIP', if_true: files('k230_deco=
mp_gzip.c'))
>
>  subdir('macio')
>
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 2d6d2238c5..16db4ba0cc 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -443,8 +443,6 @@ iommu_testdev_dma_verify(uint32_t expected, uint32_t =
actual) "expected=3D0x%x actu
>  iommu_testdev_dma_result(uint32_t result) "DMA completed result=3D0x%x"
>  iommu_testdev_dma_armed(bool armed) "armed=3D%d"
>
> -# vmlaunchupdate.c
> -launch_update_write(void) ""
> -vmlaunch_reset_enter(void) ""
> -vm_launchupdate_finalize(void) ""
> -restore_host_x86_igvm(void) ""
> +# k230_decomp_gzip.c
> +k230_decomp_gzip_read(uint64_t offset, unsigned int size, uint64_t value=
) "K230 DECOMP GZIP read: [0x%"PRIx64"] size %u -> 0x%"PRIx64
> +k230_decomp_gzip_write(uint64_t offset, unsigned int size, uint64_t valu=
e) "K230 DECOMP GZIP write: [0x%"PRIx64"] size %u <- 0x%"PRIx64

../hw/misc/vmlaunchupdate.c: In function =E2=80=98restore_host_x86_igvm=E2=
=80=99:
../hw/misc/vmlaunchupdate.c:151:5: error: implicit declaration of
function =E2=80=98trace_restore_host_x86_igvm=E2=80=99; did you mean
=E2=80=98restore_host_x86_igvm=E2=80=99? [-Wimplicit-function-declaration]
  151 |     trace_restore_host_x86_igvm();
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~

bad conflict resolution, probably

> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 663a66bded..84756ba823 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -300,7 +300,7 @@ qtests_riscv64 =3D ['riscv-csr-test'] + \
>     config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
>     ['iommu-riscv-test'] : []) + \
>    (config_all_devices.has_key('CONFIG_K230') ?
> -   ['k230-ddr-test', 'k230-wdt-test'] : [])
> +   ['k230-ddr-test', 'k230-wdt-test', 'k230-gsdma-test'] : [])
>
>  qtests_hexagon =3D ['boot-serial-test', 'l2vic-test', 'qct-qtimer-test']
>
> --
> 2.54.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

