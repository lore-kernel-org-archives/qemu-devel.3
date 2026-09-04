Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F061C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 11:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2SJY-0006d2-CT; Fri, 04 Sep 2026 07:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1x2SJW-0006cX-7L
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 07:42:34 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1x2SJU-0000a0-MI
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 07:42:33 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-81f3b227a4aso12021357b3.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 04:42:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788522151; cv=none;
 d=google.com; s=arc-20260327;
 b=Xw8izJ8RCRRcAg0HgKQMIxgVuLhApqeS6f7hAZeaBoKjEcpMj57TS7Q3vsu2BdSahZ
 kt3DQXw3mejJNu9CobLI+WXyELzJE/eGEW6SWopJLcaDXI9DAYEBH9rhMkFGmAkgNjRU
 ZZnEs0L9JrlXM7Lw0s2xQpcUHhmtgAjYa14QoKdpMCkPNe9dWG7h8HyHx4l46OEEnU63
 RL/cplhWhXcGCAZCB1cSI3K4QsQZ5zGXiUqbPCm+HkmPWmuyc3TYA/GDF15lyqgblipS
 DUQVDYmVZ7RkGCF+yuxSMv+ZEkSAVzYYqCb2z3hYIUpfhRT4O93PpJKCFMZVOOFefe73
 iEIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iAd0Rdmnv94verc53RvEDIrbiyA0zM1MOMV9bs7laek=;
 fh=pYNDZzvlZhUesMR+jYdKt0uJuC+/d/TOT4qqaKcrzY0=;
 b=B4AuzuAYmFbD4DLl8Js92QjUpytC04IVAiqXBbrWaXrqCf+Tnpl4zQem1cew3HrZN9
 c4GMBMKMG5GO+AJ1ArbQ19pvw3bUloO0/q+vcipKfWKNhBofcP+3Lc0UBOvU20jvXciv
 l8a8o8OoOc+R2eJnltifpFYlA243dOtd0zZPl2sUu3F5icNk4i5fRR2LYA46/pLSjVYO
 RJc4STHa/w6PXwtmAfc7nrDMaEOg6RabZ0GrGfCR+7hsg7LbsW5hKR+w+7reGq8YjmOA
 qGc4Szt3OAkERWzhWY4JQ4QTpizZWyjLaz8g1RGIRXLD7Hs3WrLNNCneFXq1hBa9JfoN
 8hmg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788522151; x=1789126951; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iAd0Rdmnv94verc53RvEDIrbiyA0zM1MOMV9bs7laek=;
 b=jEGH1YCES+SiHVZ2v+/mk7w1SLEvKIKttpNyqqgZ+6WNphAbrdedeHTClALlFJq7CN
 kw9q3ITUsTS39JhGapHVhjIMmHyM1qvaJ8D5Y2RykS/o4lEEGWdWM1yak2uyJu5S516l
 8JCd/LuDqS8uzvdpzD5TlqtYyFaaQeNsedhMxw83nvNX7nirNAu+QPsXRTRlG5tKbHIi
 Ivsy3vGJjgqFCyJCWwZQMK1l2OxNgRXxkRWoNWyXh+8z0QZbPVdg2T9ajFpeQSdr3EHj
 SR7uCJwSQX/+Pe/i903Wf10cyuVZ+xPDuGvPMtPb2DHEQ/TAdIK/SLcrxH2TuhNQAr6r
 GjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788522151; x=1789126951;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iAd0Rdmnv94verc53RvEDIrbiyA0zM1MOMV9bs7laek=;
 b=I24vYWIMmz/llNQ0NptJzCG5/de5/8R1vet2OsYinTJ4ACE35FSIMmNVwHfr2p98cN
 MvWHemq0jSlUCFgD67JNF4/TOazJaKPHGZN3vd1oBDZvxE6HCDGkyaULXrS9jbkGboCO
 YH4e7AFBIpKGrx1S2hiir8bI30+joofUsrBfPCS6JCUJPtrPa7r1D089UsDQLVW2kM1X
 zxGXnQpF0GC+Fq2i94LtfIL6Ez5aKo34c0zhroDyKyBhp29w6fkRo558JnuGcmMu9iq0
 5uC3psqi+N4w/CBuwCI/jH3cEHPLChuvNosdUbYAidaExRjIBSWLVHP3nYJmEOm7RdTl
 xdFA==
X-Forwarded-Encrypted: i=1;
 AKwUvBztyPMwuJm2SFAcJ0izJWFG/iWPC1tH0PSObhN0VAaE8uumNPUDQ48czS9v3syTrhduGS/g7w7LHBNX@nongnu.org
X-Gm-Message-State: AFuF++lIybvQqrm1x1pUBOVXtiXtu1q1RsmDM3Lc9X6tT3NMUdTf0XLy
 6AhPG9q48uPpJQ8OL3LCCJgDa0hd9lQm7JvHHws7M2O2uppCRhnVgs/hQBLejP5qfvFxPCEX8iT
 iUlr8Y5FCOG0kHNolncCmf8bObGeJYJk=
X-Gm-Gg: AYBFou03hwiKyH/W+/kq7xwtf8erxxPzSGREmlOi0OYmsO83IUZam5euB2EHOCnmPmC
 aj2iW5QkRxzRp3w89+5bDi5dbdwBfY+zPNYh30ZCL0+T/d/oXNYd0XKXs+2GMlwwNJh8WJHeaFw
 mJAcX5DS6eH3oOjizV517/sNV2l8u8XRVbwxV7arfflDC3Y598ul5gfevLB6Pjis5iazLGQWNko
 y7bHWKVaBh7yuh2g0uH/cNQsQ8wkF0h/Ces+R2KFZOm9QnaItOipwbZhKTNCo0jiFfpybIt92Gg
 VHFqq1z3O21VyXjg1xKGlKMDIsnhE8nK0aty6kTdnOcQ5yyb/AbVrRcgdBQ=
X-Received: by 2002:a81:8a87:0:b0:853:c23e:9077 with SMTP id
 00721157ae682-87127e23f73mr22495437b3.26.1788522151377; Fri, 04 Sep 2026
 04:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260903112532.3276678-1-bin.meng@processmission.com>
 <20260903112532.3276678-5-bin.meng@processmission.com>
 <fcdbdc94-49d3-4fe5-a91e-95a41038c382@oss.qualcomm.com>
In-Reply-To: <fcdbdc94-49d3-4fe5-a91e-95a41038c382@oss.qualcomm.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 4 Sep 2026 19:42:21 +0800
X-Gm-Features: AcwNN1XMOEQe-zowCD0U8pZinGvBB8JecmHmrI4ebs8uJyiGl1JMyLRtqoOzGII
Message-ID: <CAEUhbmU3vHPjFRbyOQ-mAAUqzse9QMVdm_yjb8fk1+848gCqDg@mail.gmail.com>
Subject: Re: [PATCH 04/33] hw/sd: Add Synopsys DesignWare MCI controller
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x1136.google.com
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

Hi Philippe,

On Thu, Sep 3, 2026 at 11:07=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Hi Bin,
>
> On 3/9/26 13:24, Bin Meng wrote:
> > The Synopsys DesignWare Mobile Storage Host predates SDHCI and uses
> > a distinct MCI programming interface. It is integrated by Samsung
> > Exynos, Rockchip, HiSilicon, and Altera/Intel SoCFPGA platforms,
> > among others.
> >
> > Add a reusable controller model based on the DesignWare Mobile Storage
> > Host 2.40a databook. Cover command and response handling, PIO FIFO
> > aliases, reset and interrupt semantics, card state, and the standard
> > 32-bit internal descriptor DMA engine. Also support the later 64-bit
> > descriptor layout used by vendor variants.
> >
> > Expose class hooks and immutable configuration fields so vendor
> > extensions can reuse the common implementation.
> >
> > Signed-off-by: Bin Meng <bin.meng@processmission.com>
> > ---
> >
> >   MAINTAINERS            |    2 +
> >   hw/sd/Kconfig          |    5 +
> >   hw/sd/dw_mci.c         | 1382 +++++++++++++++++++++++++++++++++++++++=
+
> >   hw/sd/meson.build      |    1 +
> >   include/hw/sd/dw_mci.h |   74 +++
> >   5 files changed, 1464 insertions(+)
> >   create mode 100644 hw/sd/dw_mci.c
> >   create mode 100644 include/hw/sd/dw_mci.h
> Please enable scripts/git.orderfile to ease review.

Have done that for my local QEMU repo.

>
>
> > +REG32(ENABLE_SHIFT, 0x110)
>
>
> > +static const VMStateDescription dw_mci_vmsd =3D {
> > +    .name =3D TYPE_DW_MCI,
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .post_load =3D dw_mci_post_load,
> > +    .fields =3D (const VMStateField[]) {
> > +        VMSTATE_UINT32_ARRAY(regs, DwMciState, DW_MCI_REG_COUNT),
> > +        VMSTATE_UINT8_ARRAY(fifo, DwMciState, DW_MCI_FIFO_MAX_BYTES),
> > +        VMSTATE_UINT32(fifo_head, DwMciState),
> > +        VMSTATE_UINT32(fifo_len, DwMciState),
> > +        VMSTATE_UINT32(transfer_remaining, DwMciState),
> > +        VMSTATE_UINT64(idmac_desc_addr, DwMciState),
> > +        VMSTATE_BOOL(transfer_active, DwMciState),
> > +        VMSTATE_BOOL(transfer_write, DwMciState),
> > +        VMSTATE_BOOL(transfer_send_stop, DwMciState),
> > +        VMSTATE_BOOL(idmac_suspended, DwMciState),
> > +        VMSTATE_BOOL(idmac_fatal, DwMciState),
> > +        VMSTATE_BOOL(card_inserted, DwMciState),
> > +        VMSTATE_BOOL(card_readonly, DwMciState),
> > +        VMSTATE_END_OF_LIST()
> > +    },
> > +};
>
>
> > +#define DW_MCI_MMIO_SIZE      0x1000
> > +#define DW_MCI_REG_COUNT      (DW_MCI_MMIO_SIZE / sizeof(uint32_t))
>
> At a glance, less than 70 registers are addressed but you
> map and allocate more than 1000, which end being migrated.
>
> Maybe we can start with fewer (96?) registers, still mapping
> the whole 4K region?

Makes sense. Will fix in v2.

>
> > +#define DW_MCI_FIFO_MAX_WORDS 2048
> > +#define DW_MCI_FIFO_MAX_BYTES (DW_MCI_FIFO_MAX_WORDS * sizeof(uint32_t=
))
> > +
> > +struct DwMciState {
> > +    SysBusDevice parent_obj;
> > +
> > +    MemoryRegion iomem;
> > +    SDBus sdbus;
> > +    qemu_irq irq;
> > +
> > +    uint32_t regs[DW_MCI_REG_COUNT];
> > +    RegisterInfo regs_info[DW_MCI_REG_COUNT];
> > +
> > +    uint8_t fifo[DW_MCI_FIFO_MAX_BYTES];
> > +    uint32_t fifo_head;
> > +    uint32_t fifo_len;
> > +    uint32_t transfer_remaining;
> > +    uint64_t idmac_desc_addr;
> > +    bool transfer_active;
> > +    bool transfer_write;
> > +    bool transfer_send_stop;
> > +    bool idmac_suspended;
> > +    bool idmac_fatal;
> > +    bool card_inserted;
> > +    bool card_readonly;
> > +
> > +    uint32_t verid;
> > +    uint32_t hcon;
> > +    uint32_t data_offset;
> > +    uint32_t fifo_depth;
> > +};

Regards,
Bin

