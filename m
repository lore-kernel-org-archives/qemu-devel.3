Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E6AC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 05:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trVPy-0006Ju-Ai; Mon, 10 Mar 2025 01:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trVPm-0006JB-Ks; Mon, 10 Mar 2025 01:11:02 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trVPk-0002ZF-1D; Mon, 10 Mar 2025 01:10:58 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-224341bbc1dso35509175ad.3; 
 Sun, 09 Mar 2025 22:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741583454; x=1742188254; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2zAU1ii+f5SgcV5BskkY5nns9kEcYtQVqR3zbz+IKuE=;
 b=GhQC6Or+BuOd2lUBwWIhiW6xLYRCSfO1HGeiuBdBsXkYJLVRmhPj/QLss2Cz/SkRGF
 fNv2BZhjMp+9ba2DDs4qgnDYbnsCC+lwqh6MwPZR2exL8HcMYQdWaFn3sGn12tz0MrwS
 wP5WPIQ9WqFgZHSQCJci8gtGYYU6GFf5h9l+NccCwGzQrfogxzMwvZai6XEDayW6xLfA
 Vo+WUBUOdDc7w3EYuq+SXtdtdeermXmDpn4BiNU5cMVMSUedwmKQbKCP0IJk5PpqvRQ1
 F6nL9dMGxzw9STbxF55fXAXyZHahxs2wiyoH2ZOaIPxmNbKgoCG59OpJCmwi+yrBT9EO
 DY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741583454; x=1742188254;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2zAU1ii+f5SgcV5BskkY5nns9kEcYtQVqR3zbz+IKuE=;
 b=oblVhpyCh3uduyqFLaEuDcdPHJX1WuVjoX7QrTxXV2fXsGLvlUfBauHD9AVikgHT4G
 CGDHoubwV2WGCzZCbASeyIJD7MmlHv3jMCDDF5bK4PSmLE3KEjC+UTytyTH8cYV3wU6y
 0xE05XyFfGMT9PB+lZzHpcYNA1NS6MyWbOu83oPU5ahtnH9OHlTMEVDwnYwQOtEYJ3qn
 aRNWJcHwn79LsblVlk5LHY7VMi1u4FNfh5ihd4aQbfPgxd4QU3YQlg/EHg1L5fOaaSHf
 OuuYzCXbFAlys1PTtson6MDem8elYvu5ormUqz14d1AnmxaJYqB1IfWM47zltcTAzXQ/
 clTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVYhW6vHxpgqDpJ3rQZXu4J44gmNtQnVuxXlX2QbvfVp1tPihlWR0eSB57oyfoPadBlvG5/BeDj2Qb@nongnu.org
X-Gm-Message-State: AOJu0YzYs4pm0yDlisa5HSVZdkE0e2rhLmdHjiPikFJP8mkqFwyuEukM
 n5yJcA7HKb3Gcbqr6wJkmY6vDr6mQcq/Y3zNCrADCiVTYJdM5KT6
X-Gm-Gg: ASbGncv9q6D3yUnafu01Du5Ua+lMJ9eJgeO9KXfyVo87A9zCoqDdQ5RmMQPTP4G3NAo
 zuDkipMGu2CjAGeBoFtVJkXR+pzcA4vku1cYsNacWKvvTcl8kSOA1kTZRYasrseCI04k5tylo5b
 b5jW4GFqhWvvLx/wyFUbE2ytUX2pbs94qVrc2yy402ZHqXb6mGL/ay0fLtZ3nx2UPY0xGJrpXrr
 a6/kqT7XS6wS9M7ThB9+QY7EHHRJdKuct9yRPNnu6pLq3VtQJJUDTP9FZdGSMEujJn1J6eUvq1s
 921A07f7NQRCDnUAVPC3P+1YWawI8/GtEYM0DzmZ
X-Google-Smtp-Source: AGHT+IEId5PN7yp3OvqNilo2UmyuzIXaFzTZd1sBUqmnMPkzumgGPE56eSHXDZfci2CtvnsCE09PMA==
X-Received: by 2002:a05:6a00:23d5:b0:736:a540:c9ad with SMTP id
 d2e1a72fcca58-736aaaefe79mr20754398b3a.20.1741583453918; 
 Sun, 09 Mar 2025 22:10:53 -0700 (PDT)
Received: from localhost ([118.208.151.101]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736a0e659afsm6687434b3a.169.2025.03.09.22.10.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 22:10:53 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Mar 2025 15:10:47 +1000
Message-Id: <D8CBT2ISCDU3.33CSX1MT2IUB3@gmail.com>
Cc: <qemu-ppc@nongnu.org>, <fbarrat@linux.ibm.com>, <milesg@linux.ibm.com>,
 <danielhb413@gmail.com>, <david@gibson.dropbear.id.au>,
 <harshpb@linux.ibm.com>, <thuth@redhat.com>, <lvivier@redhat.com>,
 <pbonzini@redhat.com>
Subject: Re: [PATCH v2 09/14] ppc/xive2: Add support for MMIO operations on
 the NVPG/NVC BAR
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Michael Kowal" <kowal@linux.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20241210000527.9541-1-kowal@linux.ibm.com>
 <20241210000527.9541-17-kowal@linux.ibm.com>
In-Reply-To: <20241210000527.9541-17-kowal@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
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

On Tue Dec 10, 2024 at 10:05 AM AEST, Michael Kowal wrote:
> From: Frederic Barrat <fbarrat@linux.ibm.com>
>
> Add support for the NVPG and NVC BARs.  Access to the BAR pages will
> cause backlog counter operations to either increment or decriment
> the counter.
>
> Also added qtests for the same.
>
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
> ---
>  include/hw/ppc/xive2.h           |   9 ++
>  include/hw/ppc/xive2_regs.h      |   3 +
>  tests/qtest/pnv-xive2-common.h   |   1 +
>  hw/intc/pnv_xive2.c              |  80 +++++++++++++---
>  hw/intc/xive2.c                  |  87 +++++++++++++++++
>  tests/qtest/pnv-xive2-nvpg_bar.c | 154 +++++++++++++++++++++++++++++++
>  tests/qtest/pnv-xive2-test.c     |   3 +
>  hw/intc/trace-events             |   4 +
>  tests/qtest/meson.build          |   3 +-
>  9 files changed, 329 insertions(+), 15 deletions(-)
>  create mode 100644 tests/qtest/pnv-xive2-nvpg_bar.c
>
> diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
> index fc7422fea7..c07e23e1d3 100644
> --- a/include/hw/ppc/xive2.h
> +++ b/include/hw/ppc/xive2.h
> @@ -90,6 +90,15 @@ int xive2_presenter_tctx_match(XivePresenter *xptr, Xi=
veTCTX *tctx,
>                                 uint8_t nvt_blk, uint32_t nvt_idx,
>                                 bool cam_ignore, uint32_t logic_serv);
> =20
> +uint64_t xive2_presenter_nvp_backlog_op(XivePresenter *xptr,
> +                                        uint8_t blk, uint32_t idx,
> +                                        uint16_t offset);
> +
> +uint64_t xive2_presenter_nvgc_backlog_op(XivePresenter *xptr,
> +                                         bool crowd,
> +                                         uint8_t blk, uint32_t idx,
> +                                         uint16_t offset, uint16_t val);
> +
>  /*
>   * XIVE2 END ESBs  (POWER10)
>   */
> diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
> index e88d6eab1e..9bcf7a8a6f 100644
> --- a/include/hw/ppc/xive2_regs.h
> +++ b/include/hw/ppc/xive2_regs.h
> @@ -233,4 +233,7 @@ typedef struct Xive2Nvgc {
>  void xive2_nvgc_pic_print_info(Xive2Nvgc *nvgc, uint32_t nvgc_idx,
>                                 GString *buf);
> =20
> +#define NVx_BACKLOG_OP            PPC_BITMASK(52, 53)
> +#define NVx_BACKLOG_PRIO          PPC_BITMASK(57, 59)
> +
>  #endif /* PPC_XIVE2_REGS_H */
> diff --git a/tests/qtest/pnv-xive2-common.h b/tests/qtest/pnv-xive2-commo=
n.h
> index 9ae34771aa..2077c05ebc 100644
> --- a/tests/qtest/pnv-xive2-common.h
> +++ b/tests/qtest/pnv-xive2-common.h
> @@ -107,5 +107,6 @@ extern void set_end(QTestState *qts, uint32_t index, =
uint32_t nvp_index,
> =20
> =20
>  void test_flush_sync_inject(QTestState *qts);
> +void test_nvpg_bar(QTestState *qts);
> =20
>  #endif /* TEST_PNV_XIVE2_COMMON_H */
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index 41b727d1fb..54abfe3947 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -2202,21 +2202,40 @@ static const MemoryRegionOps pnv_xive2_tm_ops =3D=
 {
>      },
>  };
> =20
> -static uint64_t pnv_xive2_nvc_read(void *opaque, hwaddr offset,
> +static uint64_t pnv_xive2_nvc_read(void *opaque, hwaddr addr,
>                                     unsigned size)
>  {
>      PnvXive2 *xive =3D PNV_XIVE2(opaque);
> +    XivePresenter *xptr =3D XIVE_PRESENTER(xive);
> +    uint32_t page =3D addr >> xive->nvpg_shift;
> +    uint16_t op =3D addr & 0xFFF;
> +    uint8_t blk =3D pnv_xive2_block_id(xive);
> =20
> -    xive2_error(xive, "NVC: invalid read @%"HWADDR_PRIx, offset);
> -    return -1;
> +    if (size !=3D 2) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid nvc load size %d\n=
",
> +                      size);
> +        return -1;
> +    }
> +
> +    return xive2_presenter_nvgc_backlog_op(xptr, true, blk, page, op, 1)=
;
>  }
> =20
> -static void pnv_xive2_nvc_write(void *opaque, hwaddr offset,
> +static void pnv_xive2_nvc_write(void *opaque, hwaddr addr,
>                                  uint64_t val, unsigned size)
>  {
>      PnvXive2 *xive =3D PNV_XIVE2(opaque);
> +    XivePresenter *xptr =3D XIVE_PRESENTER(xive);
> +    uint32_t page =3D addr >> xive->nvc_shift;
> +    uint16_t op =3D addr & 0xFFF;
> +    uint8_t blk =3D pnv_xive2_block_id(xive);
> =20
> -    xive2_error(xive, "NVC: invalid write @%"HWADDR_PRIx, offset);
> +    if (size !=3D 1) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid nvc write size %d\=
n",
> +                      size);
> +        return;
> +    }

It would be nice to convert these accessors to _with_attrs() variants
that can report access errors like this back through the memory
subsystem. I guess that's something for the todo list rather than an
issue with this patch in particular.

> +    /*
> +     * op:
> +     * 0b00 =3D> increment
> +     * 0b01 =3D> decrement
> +     * 0b1- =3D> read
> +     */

Could use define or enum for these like the qtest has...


> +    if (op =3D=3D 0b00 || op =3D=3D 0b01) {
> +        if (op =3D=3D 0b00) {
> +            count +=3D val;
> +        } else {
> +            if (count > val) {
> +                count -=3D val;
> +            } else {
> +                count =3D 0;
> +            }
> +        }
> +        xive2_nvgc_set_backlog(&nvgc, priority, count);
> +        xive2_router_write_nvgc(xrtr, crowd, blk, idx, &nvgc);
> +    }
> +    trace_xive_nvgc_backlog_op(crowd, blk, idx, op, priority, old_count)=
;
> +    return old_count;
> +}
> +
> +uint64_t xive2_presenter_nvp_backlog_op(XivePresenter *xptr,
> +                                        uint8_t blk, uint32_t idx,
> +                                        uint16_t offset)
> +{
> +    Xive2Router *xrtr =3D XIVE2_ROUTER(xptr);
> +    uint8_t priority =3D GETFIELD(NVx_BACKLOG_PRIO, offset);
> +    uint8_t op =3D GETFIELD(NVx_BACKLOG_OP, offset);
> +    Xive2Nvp nvp;
> +    uint8_t ipb, old_ipb, rc;
> +
> +    if (xive2_router_get_nvp(xrtr, blk, idx, &nvp)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVP %x/%x\n", blk, idx)=
;
> +        return -1;
> +    }
> +    if (!xive2_nvp_is_valid(&nvp)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid NVP %x/%x\n", blk,=
 idx);
> +        return -1;
> +    }
> +
> +    old_ipb =3D xive_get_field32(NVP2_W2_IPB, nvp.w2);
> +    ipb =3D old_ipb;
> +    /*
> +     * op:
> +     * 0b00 =3D> set priority bit
> +     * 0b01 =3D> reset priority bit
> +     * 0b1- =3D> read
> +     */
> +    if (op =3D=3D 0b00 || op =3D=3D 0b01) {
> +        if (op =3D=3D 0b00) {
> +            ipb |=3D xive_priority_to_ipb(priority);
> +        } else {
> +            ipb &=3D ~xive_priority_to_ipb(priority);
> +        }
> +        nvp.w2 =3D xive_set_field32(NVP2_W2_IPB, nvp.w2, ipb);
> +        xive2_router_write_nvp(xrtr, blk, idx, &nvp, 2);
> +    }
> +    rc =3D !!(old_ipb & xive_priority_to_ipb(priority));
> +    trace_xive_nvp_backlog_op(blk, idx, op, priority, rc);
> +    return rc;
> +}
> +
>  void xive2_eas_pic_print_info(Xive2Eas *eas, uint32_t lisn, GString *buf=
)
>  {
>      if (!xive2_eas_is_valid(eas)) {
> diff --git a/tests/qtest/pnv-xive2-nvpg_bar.c b/tests/qtest/pnv-xive2-nvp=
g_bar.c
> new file mode 100644
> index 0000000000..10d4962d1e
> --- /dev/null
> +++ b/tests/qtest/pnv-xive2-nvpg_bar.c
> @@ -0,0 +1,154 @@
> +/*
> + * QTest testcase for PowerNV 10 interrupt controller (xive2)
> + *  - Test NVPG BAR MMIO operations
> + *
> + * Copyright (c) 2024, IBM Corporation.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * later. See the COPYING file in the top-level directory.
> + */
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +
> +#include "pnv-xive2-common.h"
> +
> +#define NVPG_BACKLOG_OP_SHIFT   10
> +#define NVPG_BACKLOG_PRIO_SHIFT 4
> +
> +#define XIVE_PRIORITY_MAX       7
> +
> +enum NVx {
> +    NVP,
> +    NVG,
> +    NVC
> +};
> +
> +typedef enum {
> +    INCR_STORE =3D 0b100,
> +    INCR_LOAD  =3D 0b000,
> +    DECR_STORE =3D 0b101,
> +    DECR_LOAD  =3D 0b001,
> +    READ_x     =3D 0b010,
> +    READ_y     =3D 0b011,
> +} backlog_op;
> +
> +static uint32_t nvpg_backlog_op(QTestState *qts, backlog_op op,
> +                                enum NVx type, uint64_t index,
> +                                uint8_t priority, uint8_t delta)
> +{
> +    uint64_t addr, offset;
> +    uint32_t count =3D 0;
> +
> +    switch (type) {
> +    case NVP:
> +        addr =3D XIVE_NVPG_ADDR + (index << (XIVE_PAGE_SHIFT + 1));
> +        break;
> +    case NVG:
> +        addr =3D XIVE_NVPG_ADDR + (index << (XIVE_PAGE_SHIFT + 1)) +
> +            (1 << XIVE_PAGE_SHIFT);
> +        break;
> +    case NVC:
> +        addr =3D XIVE_NVC_ADDR + (index << XIVE_PAGE_SHIFT);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    offset =3D (op & 0b11) << NVPG_BACKLOG_OP_SHIFT;
> +    offset |=3D priority << NVPG_BACKLOG_PRIO_SHIFT;
> +    if (op >> 2) {
> +        qtest_writeb(qts, addr + offset, delta);
> +    } else {
> +        count =3D qtest_readw(qts, addr + offset);
> +    }
> +    return count;
> +}
> +
> +void test_nvpg_bar(QTestState *qts)
> +{
> +    uint32_t nvp_target =3D 0x11;
> +    uint32_t group_target =3D 0x17; /* size 16 */
> +    uint32_t vp_irq =3D 33, group_irq =3D 47;
> +    uint32_t vp_end =3D 3, group_end =3D 97;
> +    uint32_t vp_irq_data =3D 0x33333333;
> +    uint32_t group_irq_data =3D 0x66666666;
> +    uint8_t vp_priority =3D 0, group_priority =3D 5;
> +    uint32_t vp_count[XIVE_PRIORITY_MAX + 1] =3D { 0 };
> +    uint32_t group_count[XIVE_PRIORITY_MAX + 1] =3D { 0 };
> +    uint32_t count, delta;
> +    uint8_t i;
> +
> +    printf("# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
> +    printf("# Testing NVPG BAR operations\n");
> +
> +    set_nvg(qts, group_target, 0);
> +    set_nvp(qts, nvp_target, 0x04);
> +    set_nvp(qts, group_target, 0x04);
> +
> +    /*
> +     * Setup: trigger a VP-specific interrupt and a group interrupt
> +     * so that the backlog counters are initialized to something else
> +     * than 0 for at least one priority level
> +     */
> +    set_eas(qts, vp_irq, vp_end, vp_irq_data);
> +    set_end(qts, vp_end, nvp_target, vp_priority, false /* group */);
> +
> +    set_eas(qts, group_irq, group_end, group_irq_data);
> +    set_end(qts, group_end, group_target, group_priority, true /* group =
*/);
> +
> +    get_esb(qts, vp_irq, XIVE_EOI_PAGE, XIVE_ESB_SET_PQ_00);
> +    set_esb(qts, vp_irq, XIVE_TRIGGER_PAGE, 0, 0);
> +    vp_count[vp_priority]++;
> +
> +    get_esb(qts, group_irq, XIVE_EOI_PAGE, XIVE_ESB_SET_PQ_00);
> +    set_esb(qts, group_irq, XIVE_TRIGGER_PAGE, 0, 0);
> +    group_count[group_priority]++;
> +
> +    /* check the initial counters */
> +    for (i =3D 0; i <=3D XIVE_PRIORITY_MAX; i++) {
> +        count =3D nvpg_backlog_op(qts, READ_x, NVP, nvp_target, i, 0);
> +        g_assert_cmpuint(count, =3D=3D, vp_count[i]);
> +
> +        count =3D nvpg_backlog_op(qts, READ_y, NVG, group_target, i, 0);
> +        g_assert_cmpuint(count, =3D=3D, group_count[i]);
> +    }
> +
> +    /* do a few ops on the VP. Counter can only be 0 and 1 */
> +    vp_priority =3D 2;
> +    delta =3D 7;
> +    nvpg_backlog_op(qts, INCR_STORE, NVP, nvp_target, vp_priority, delta=
);
> +    vp_count[vp_priority] =3D 1;
> +    count =3D nvpg_backlog_op(qts, INCR_LOAD, NVP, nvp_target, vp_priori=
ty, 0);
> +    g_assert_cmpuint(count, =3D=3D, vp_count[vp_priority]);
> +    count =3D nvpg_backlog_op(qts, READ_y, NVP, nvp_target, vp_priority,=
 0);
> +    g_assert_cmpuint(count, =3D=3D, vp_count[vp_priority]);
> +
> +    count =3D nvpg_backlog_op(qts, DECR_LOAD, NVP, nvp_target, vp_priori=
ty, 0);
> +    g_assert_cmpuint(count, =3D=3D, vp_count[vp_priority]);
> +    vp_count[vp_priority] =3D 0;
> +    nvpg_backlog_op(qts, DECR_STORE, NVP, nvp_target, vp_priority, delta=
);
> +    count =3D nvpg_backlog_op(qts, READ_x, NVP, nvp_target, vp_priority,=
 0);
> +    g_assert_cmpuint(count, =3D=3D, vp_count[vp_priority]);

It is a bit confusing because NVP ops AFAIKS are set/clear of a priority
bit. But this has inc/dec. The comment is there and set/clear is basically
incrementing/decrementing a saturating 1-bit counter so it makes sense
but might be good to make this terminology match what the model uses.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> +
> +    /* do a few ops on the group */
> +    group_priority =3D 2;
> +    delta =3D 9;
> +    /* can't go negative */
> +    nvpg_backlog_op(qts, DECR_STORE, NVG, group_target, group_priority, =
delta);
> +    count =3D nvpg_backlog_op(qts, READ_y, NVG, group_target, group_prio=
rity, 0);
> +    g_assert_cmpuint(count, =3D=3D, 0);
> +    nvpg_backlog_op(qts, INCR_STORE, NVG, group_target, group_priority, =
delta);
> +    group_count[group_priority] +=3D delta;
> +    count =3D nvpg_backlog_op(qts, INCR_LOAD, NVG, group_target,
> +                            group_priority, delta);
> +    g_assert_cmpuint(count, =3D=3D, group_count[group_priority]);
> +    group_count[group_priority]++;
> +
> +    count =3D nvpg_backlog_op(qts, DECR_LOAD, NVG, group_target,
> +                            group_priority, delta);
> +    g_assert_cmpuint(count, =3D=3D,  group_count[group_priority]);
> +    group_count[group_priority]--;
> +    count =3D nvpg_backlog_op(qts, READ_x, NVG, group_target, group_prio=
rity, 0);
> +    g_assert_cmpuint(count, =3D=3D, group_count[group_priority]);
> +}
> +
> diff --git a/tests/qtest/pnv-xive2-test.c b/tests/qtest/pnv-xive2-test.c
> index a4d06550ee..a0e9f19313 100644
> --- a/tests/qtest/pnv-xive2-test.c
> +++ b/tests/qtest/pnv-xive2-test.c
> @@ -493,6 +493,9 @@ static void test_xive(void)
>      reset_state(qts);
>      test_flush_sync_inject(qts);
> =20
> +    reset_state(qts);
> +    test_nvpg_bar(qts);
> +
>      qtest_quit(qts);
>  }
> =20
> diff --git a/hw/intc/trace-events b/hw/intc/trace-events
> index 7435728c51..7f362c38b0 100644
> --- a/hw/intc/trace-events
> +++ b/hw/intc/trace-events
> @@ -285,6 +285,10 @@ xive_tctx_tm_read(uint32_t index, uint64_t offset, u=
nsigned int size, uint64_t v
>  xive_presenter_notify(uint8_t nvt_blk, uint32_t nvt_idx, uint8_t ring, u=
int8_t group_level) "found NVT 0x%x/0x%x ring=3D0x%x group_level=3D%d"
>  xive_end_source_read(uint8_t end_blk, uint32_t end_idx, uint64_t addr) "=
END 0x%x/0x%x @0x%"PRIx64
> =20
> +# xive2.c
> +xive_nvp_backlog_op(uint8_t blk, uint32_t idx, uint8_t op, uint8_t prior=
ity, uint8_t rc) "NVP 0x%x/0x%x operation=3D%d priority=3D%d rc=3D%d"
> +xive_nvgc_backlog_op(bool c, uint8_t blk, uint32_t idx, uint8_t op, uint=
8_t priority, uint32_t rc) "NVGC crowd=3D%d 0x%x/0x%x operation=3D%d priori=
ty=3D%d rc=3D%d"
> +
>  # pnv_xive.c
>  pnv_xive_ic_hw_trigger(uint64_t addr, uint64_t val) "@0x%"PRIx64" val=3D=
0x%"PRIx64
> =20
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index bd41c9da5f..f7da3df24b 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -348,7 +348,8 @@ qtests =3D {
>    'ivshmem-test': [rt, '../../contrib/ivshmem-server/ivshmem-server.c'],
>    'migration-test': migration_files,
>    'pxe-test': files('boot-sector.c'),
> -  'pnv-xive2-test': files('pnv-xive2-common.c', 'pnv-xive2-flush-sync.c'=
),
> +  'pnv-xive2-test': files('pnv-xive2-common.c', 'pnv-xive2-flush-sync.c'=
,
> +                          'pnv-xive2-nvpg_bar.c'),
>    'qos-test': [chardev, io, qos_test_ss.apply({}).sources()],
>    'tpm-crb-swtpm-test': [io, tpmemu_files],
>    'tpm-crb-test': [io, tpmemu_files],


