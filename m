Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DA1C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 11:35:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfcAX-0000vT-RM; Fri, 03 Jul 2026 07:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfcAS-0000vL-OS
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 07:34:49 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfcAQ-0005Cv-5P
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 07:34:48 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-66493875766so659861d50.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 04:34:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783078482; cv=none;
 d=google.com; s=arc-20260327;
 b=gEk5UL2rDgm/KJPagzSwa8QfzR7XR3BSv1nXb45MzG6QBs+x6RZ8iuqZlqlgzJxuix
 qL2XyQsni4GLcpVr8r2n/2eDx4jbtX2zJvFEfgT7Bt7LHfV227tvzPKio2zgBUcmHz8J
 FenYRkmAGaKgVJZXQM7PXzM1fyWGKm3RSBaQ4y52KR2RgHRG8fUOmL7z0YeUpSSUWA2h
 W4sdISItAuWjQVyFLIsGN+PWtMP6njB+vAEi4e0n9HSBM8jROFO1j0+QmSAOCJMzVQJf
 WqIUPYbXQ4qd0Qs+EAr/d30TxP9xjFr2Z9tfIw7y+GEIW//Yqh4JTosyVWaFA5oze4Pg
 24Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EMcxfXXM4RmngqJOmMjbfXO/3n+yxawrM5ytJnm485I=;
 fh=sWAiQ2wH+5Nb520aBsWWf7QkF1L22uzROvmg9sTu7DM=;
 b=Ixz2ZTjg5BDPiVXyNuy5JR7J/p8tA/lsctf5IeBYY/7A6dgtykVcp6JtWzAuKPw9zG
 MNlmIBaT4fy0iQx2CoBqp58hkPXnF7bLeJl5mGFsPUCjY3beP8QKyFV93S0iu2OR6dvh
 aV1VKLbla85sX8rYrvhzKY9hT+qJxzPyYyhkpJpbo9ep3hTqaH7x/w8WIssCU12Ar6xE
 yzfeVNi8tcOBJu8AXAvNpdOrF6SVXLCsWvnjRtUMxKDWs3gd9nTeg0+i3mGezumUnDH2
 PFN85JZEAwC6d12EFV9PghokAsgwX8dguBxHZE0EybKzyYsMPmD6wU6iGhxCw4zkK0IV
 QNEw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783078482; x=1783683282; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EMcxfXXM4RmngqJOmMjbfXO/3n+yxawrM5ytJnm485I=;
 b=ZvlnVdR3zLAHfYOweJAKNECndjSC4ZQWZ5wybYos3Y4xszcwmOm5WK8ccIFflgw+Rx
 hvqDCcYJuLHLV/HHSTzaJeBgPFOuV6i6vnGekoP0XJ+2naDgL5mK06t9S6Dvmk4tomkC
 M6GuWdEiWALLCtQrtEARaWQ+kFK/k26NLvIsWs8HriKNYsB6PGGDA8eqZaWxTubG3lsr
 Nyl0/nrQ8p5ZV9/yp6PB06q9XCYvQ2xdoRxlBHaecerloIy8N1GlahhUkisUURZgn4kv
 e8ppbg9cZdOI1KwVUvJIwxSz7+IT3KuoWnf6exV9RSp9OO3jqZuVVrsmVR+J5bgXhq2d
 /WbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783078482; x=1783683282;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EMcxfXXM4RmngqJOmMjbfXO/3n+yxawrM5ytJnm485I=;
 b=bAs+ZL3oTqSwpr7vKLB3IuWNpwsDZaM+qHZMz2+K/zPBijmC4F3Q25Lbv3mAnRbOMq
 ZTmXOnU2SlTdkxMPyR/N2K68xvZQ5nBpYWeU7u5aU8/ObVtbP+WJ9f+LwEC+XocScXZz
 O6Xvd2/st6OUp3Y33uyGlCASocChykDKSKAkdvO4Jo33+j/RvTPjFDkreDbfq7/etg2i
 aZOJuAHseAQRXemvYXkLwvR1t1r9ZcEOs3niwx0iYAPBPACbL4dZhI6jV1DavE14RBvI
 l5z76xfsZbcmuPMczgnXCIq580R8QFszxK+xW1t5+Mu8y8uey16C6pMcSGCYZf12zj9u
 BpCQ==
X-Gm-Message-State: AOJu0YzpcBv42kM7ZSJtb8xFGTwGFVz6hZYSoaA5QufcWDh+7bjRTRvz
 FOTkVKQhcbH0cw74s4QyPL0AEwAG5C9cqTrpp96uOqgyy4yqsEgD84YIDHuPMTOR3aIGZifE/RH
 kercd+vlKY6DwXfKw+xad3wxFNg0cXzV7g0sdVauJCVGRUiKWnu3H2nA=
X-Gm-Gg: AfdE7ckG5ngUcEfOTwQmoMweX2Poqta8owUGZTTveZBFGbxiSxzheKONVPSMeO3boab
 JeXlrpnn67B93vVxWNWJb4KHHICivFlY0YsUQkLO/oRDg4LCjYxyK53CFk9zP76mt4D9dT6Z8f5
 sOKEWK27wmdmP3pbiVxQLOreVqoXNjnb8hNsKAn8bWBAqDr9mEhM01ej1MD90HC2tpPLDJwuBrx
 rkQnFHecmN1elApU/Co8Vqv135EMlRLemfG1mGmH1fN7iVyJOJDm2IWlTAWRY/UIE01utM/dHSj
 3wGSCONH4Bg2g5VLSmzeEVhusxaT7hxz23TCZgjjF0GovLfVa1pQqIwY
X-Received: by 2002:a05:690e:441b:b0:664:dbfc:e46b with SMTP id
 956f58d0204a3-66521961336mr6504577d50.9.1783078481988; Fri, 03 Jul 2026
 04:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
 <20260629120032.1645265-35-peter.maydell@linaro.org>
In-Reply-To: <20260629120032.1645265-35-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2026 12:34:29 +0100
X-Gm-Features: AVVi8CcAKSSAGQ-Pa6f73lfDBOab9verkAsBwY2thThrIcW9x_8Ft32fTzev4Fw
Message-ID: <CAFEAcA-QBiPfgN4YJXD9FQULobpBVNgeJHSqG7Eqg1CzyKTfaA@mail.gmail.com>
Subject: Re: [PULL 34/54] hw/net/can/flexcan: NXP FlexCAN core emulation
To: qemu-devel@nongnu.org
Cc: =?UTF-8?B?TWF0ecOhxaEgQm9iZWs=?= <matyas.bobek@gmail.com>, 
 Pavel Pisa <pisa@fel.cvut.cz>, Bernhard Beschow <shentey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Mon, 29 Jun 2026 at 13:01, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> From: Maty=C3=A1=C5=A1 Bobek <matyas.bobek@gmail.com>
>
> Added the FlexCAN2 emulator implementation core, with
> CAN_FLEXCAN Kconfig flag and MAINTAINERS entry.
>
> FlexCAN2 version can be found in i.MX6 SoCs and others.
>
> More information about the implementation can be found in [1].
>
> Some macro and struct defintions were borrowed from the Linux kernel.
> The original authors agreed with relicensing them to GPL-2.0-or-later on
> the qemu-devel mailing list.
>
> [1] http://dspace.cvut.cz/bitstream/handle/10467/122654/F3-BP-2025-Bobek-=
Matyas-BP_Bobek_FlexCAN_final_4.pdf
>

Hi; Coverity points out some issues with this change; details below.


> +/**
> + * flexcan_fifo_pop() - Pop message from FIFO and update IRQs
> + * @s: FlexCAN device pointer
> + *
> + * Does not require the queue to be non-empty.
> + */
> +static void flexcan_fifo_pop(FlexcanState *s)
> +{
> +    if (s->regs.fifo.mb_back.can_ctrl !=3D 0) {
> +        /* move queue elements forward */
> +        memmove(&s->regs.fifo.mb_back, &s->regs.fifo.mbs_queue[0],
> +                sizeof(s->regs.fifo.mbs_queue));

CID 1662971: Coverity doesn't like this because mb_back is
only 1 element long and you're copying more than that.

We seem to use these fields only in this function -- did we
really need to specify them as two separate fields rather
than one array so that it's a bit clearer that we're just
copying within what is effectively a single 6 element array?

> +
> +        /* clear the first-in slot */
> +        memset(&s->regs.mbs[FLEXCAN_FIFO_DEPTH - 1], 0,
> +               sizeof(FlexcanRegsMessageBuffer));
> +
> +        trace_flexcan_fifo_pop(DEVICE(s)->canonical_path, 1,
> +                               s->regs.fifo.mb_back.can_ctrl !=3D 0);
> +    } else {
> +        trace_flexcan_fifo_pop(DEVICE(s)->canonical_path, 0, 0);
> +    }
> +
> +    if (s->regs.fifo.mb_back.can_ctrl !=3D 0) {
> +        flexcan_irq_iflag_set(s, I_FIFO_AVAILABLE);
> +    } else {
> +        flexcan_irq_iflag_clear(s, I_FIFO_AVAILABLE);
> +    }
> +}
> +



> +static enum FlexcanRx flexcan_mb_rx(FlexcanState *s, const qemu_can_fram=
e *buf)
> +{
> +    int last_not_free_to_receive_mbid =3D -1;

CID 1662790:

Initially last_not_free_to_receive_mbid is -1.

> +    bool last_not_free_to_receive_locked =3D false;
> +
> +    FlexcanRegsMessageBuffer *first_mb =3D flexcan_get_first_message_buf=
fer(s);
> +    FlexcanRegsMessageBuffer *last_mb =3D flexcan_get_last_enabled_mailb=
ox(s);
> +
> +    for (FlexcanRegsMessageBuffer *mb =3D first_mb;
> +         mb <=3D last_mb; mb++) {
> +        int mbid =3D mb - s->regs.mbs;

In this loop mbid must always be positive, because the bounds on mb
mean it's always somewhere inside the s->regs.mbs array.

> +        enum FlexcanCheck r =3D flexcan_mb_rx_check_mb(s, buf, mbid);
> +        if (r =3D=3D FLEXCAN_CHECK_MB_MATCH) {
> +            flexcan_mb_move_in(s, buf, mb);
> +            flexcan_irq_iflag_set(s, mbid);
> +            return FLEXCAN_RX_SEARCH_ACCEPT;
> +        }
> +
> +        if (r =3D=3D FLEXCAN_CHECK_MB_MATCH_NON_FREE) {
> +            last_not_free_to_receive_mbid =3D mbid;
> +            last_not_free_to_receive_locked =3D false;
> +        } else if (r =3D=3D FLEXCAN_CHECK_MB_MATCH_LOCKED) {
> +            /*
> +             * message buffer is locked,
> +             * we can move in the message after it's unlocked
> +             */
> +            last_not_free_to_receive_mbid =3D mbid;
> +            last_not_free_to_receive_locked =3D true;
> +        }

In the loop body the only places where we assign to
last_not_free_to_receive_mbid are where we set it to mbid.

> +    }
> +
> +    if (last_not_free_to_receive_mbid >=3D -1) {

So when can this condition be false ?

> +        if (last_not_free_to_receive_locked) {
> +            /*
> +             * copy to temporary mailbox (SMB)
> +             * it will be moved in when the mailbox is unlocked
> +             */
> +            s->regs.rx_smb0.can_ctrl =3D
> +                s->regs.mbs[last_not_free_to_receive_mbid].can_id;
> +            flexcan_mb_move_in(s, buf, &s->regs.rx_smb0);
> +            s->smb_target_mbidx =3D last_not_free_to_receive_mbid;
> +            return FLEXCAN_RX_SEARCH_ACCEPT;
> +        }
> +
> +        if (s->regs.mcr & FLEXCAN_MCR_IRMQ) {
> +            flexcan_mb_move_in(s, buf,
> +                               &s->regs.mbs[last_not_free_to_receive_mbi=
d]);

Here we use last_not_free_to_receive_mbid as an index into mbs,
but it could be -1, which will underrun the array.

Should the condition above have been ">=3D 0" ?

> +            flexcan_irq_iflag_set(s, last_not_free_to_receive_mbid);
> +            return FLEXCAN_RX_SEARCH_ACCEPT;
> +        }
> +    }

> +
> +    return FLEXCAN_RX_SEARCH_RETRY;
> +}



> +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D I/O handling =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D */
> +static void flexcan_mem_write(void *opaque, hwaddr addr, uint64_t val,
> +                              unsigned size)
> +{
> +    FlexcanState *s =3D opaque;
> +    uint32_t write_mask =3D ((const uint32_t *)
> +        &flexcan_regs_write_mask)[addr / 4];
> +    uint32_t old_value =3D s->regs_raw[addr / 4];
> +
> +    /*
> +     * 0 for bits that can "only be written in Freeze mode as it is bloc=
ked
> +     * by hardware in other modes"
> +     */
> +    const uint32_t freeze_mask_mcr =3D 0xDF54CC80;
> +    const uint32_t freeze_mask_ctrl1 =3D 0x0000E740;
> +
> +    flexcan_trace_mem_op(s, addr, val, size, true);
> +    switch (addr) {
> +    case offsetof(FlexcanRegs, mcr):
> +        if (!(s->regs.mcr & FLEXCAN_MCR_FRZ_ACK)) {
> +            write_mask &=3D freeze_mask_mcr;
> +        }
> +        s->regs.mcr =3D (val & write_mask) | (old_value & ~write_mask);
> +        flexcan_set_mcr(s, old_value);
> +        break;
> +    case offsetof(FlexcanRegs, ctrl):
> +        if (!(s->regs.mcr & FLEXCAN_MCR_FRZ_ACK)) {
> +            write_mask &=3D freeze_mask_ctrl1;
> +        }
> +        s->regs.ctrl =3D (val & write_mask) | (old_value & ~write_mask);
> +        break;
> +    case offsetof(FlexcanRegs, iflag1):
> +        s->regs.iflag1 &=3D ~val;
> +        if ((s->regs.mcr & FLEXCAN_MCR_FEN) &&
> +            (val & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE)) {
> +            flexcan_fifo_pop(s);
> +        }
> +        break;
> +    case offsetof(FlexcanRegs, iflag2):
> +        s->regs.iflag2 &=3D ~val;
> +        break;
> +    case offsetof(FlexcanRegs, ctrl2):
> +        QEMU_FALLTHROUGH;
> +    case offsetof(FlexcanRegs, ecr):
> +        QEMU_FALLTHROUGH;
> +    case offsetof(FlexcanRegs, rxmgmask):
> +        QEMU_FALLTHROUGH;
> +    case offsetof(FlexcanRegs, rx14mask):
> +        QEMU_FALLTHROUGH;
> +    case offsetof(FlexcanRegs, rx15mask):
> +        QEMU_FALLTHROUGH;
> +    case offsetof(FlexcanRegs, rxfgmask):
> +        QEMU_FALLTHROUGH;
> +    case offsetof(FlexcanRegs, rximr[0]) ... offsetof(FlexcanRegs, rximr=
[63]):
> +        /* these registers can only be written in freeze mode */
> +        if (!(s->regs.mcr & FLEXCAN_MCR_FRZ_ACK)) {
> +            break;
> +        }
> +        QEMU_FALLTHROUGH;
> +    default:
> +        s->regs_raw[addr / 4] =3D (val & write_mask) | (old_value & ~wri=
te_mask);
> +
> +        if (addr >=3D offsetof(FlexcanRegs, mb) &&
> +            addr < offsetof(FlexcanRegs, _reserved4)) {
> +            /* access to mailbox */
> +            int mbid =3D (addr - offsetof(FlexcanRegs, mb)) /
> +                            sizeof(FlexcanRegsMessageBuffer);

CID 1662974: This bounds check isn't sufficient to ensure that
mbid is within the bounds of s->regs.mbs[], which flexcan_mb_write()
will access. This is the same as 1662975 below; see that for detail.

> +
> +            if (s->locked_mbidx =3D=3D mbid) {
> +                flexcan_mb_unlock(s);
> +            }
> +
> +            /* check for invalid writes into FIFO region */
> +            if (s->regs.mcr & FLEXCAN_MCR_FEN && mbid < FLEXCAN_FIFO_DEP=
TH) {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "%s: Invalid write to Rx-FIFO structure",
> +                              DEVICE(s)->canonical_path);
> +                return;
> +            }
> +
> +            /* run mailbox processing function on write to control word =
*/
> +            if ((addr & 0xF) =3D=3D 0) {
> +                flexcan_mb_write(s, mbid);
> +            }
> +        }
> +        break;
> +    }
> +
> +    flexcan_irq_update(s);
> +}
> +
> +static uint64_t flexcan_mem_read(void *opqaue, hwaddr addr, unsigned siz=
e)
> +{
> +    FlexcanState *s =3D opqaue;
> +    uint32_t rv =3D s->regs_raw[addr >> 2];
> +
> +    if (addr >=3D offsetof(FlexcanRegs, mb) &&
> +        addr < offsetof(FlexcanRegs, _reserved4)) {
> +        /* reading from mailbox */
> +        hwaddr offset =3D addr - offsetof(FlexcanRegs, mb);
> +        int mbid =3D offset / sizeof(FlexcanRegsMessageBuffer);
> +
> +        if (addr % 16 =3D=3D 0 && s->locked_mbidx !=3D mbid) {
> +            /* reading control word locks the mailbox */
> +            flexcan_mb_unlock(s);
> +            flexcan_mb_lock(s, mbid);
> +            flexcan_irq_update(s);
> +            rv =3D s->regs.mbs[mbid].can_ctrl & ~FLEXCAN_MB_CNT_NOT_SRV;

CID 1662972, 1662975:

Here we guard the bounds on addr based on the struct layout,
where the relevant part is:

    union {                      /* 0x80 - not affected by soft reset */
        uint32_t mb[sizeof(FlexcanRegsMessageBuffer) * FLEXCAN_MAILBOX_COUN=
T];
        FlexcanRegsMessageBuffer mbs[FLEXCAN_MAILBOX_COUNT];
        FlexcanRegsRXFifo fifo;
    };
    uint32_t _reserved4[256];    /* 0x480 */

So we know that 'addr' is inside the union. However, 'mbs' is
not the smallest member of the union, because 'mbs' is 64 * 16 =3D=3D 1024
bytes, but mb is 64 * 16 * 4 =3D=3D 14436 bytes, and fifo is
(6 * 16 + 128 * 4) =3D=3D 608 bytes. So because we only bounded
'mbid' based on the total size of the union, it can be larger
than the size of the mb[] array.

What is the intention here?

As an aside, using unions like this is rather error-prone, because
it is an easy way to introduce endianness bugs. This one happens to
work because all the fields in all the sub-structs end up being
uint32_t, but for instance if there was a uint16_t field in there
somewhere that would be an endianness bug.


> +
> +    } else if (addr =3D=3D offsetof(FlexcanRegs, timer)) {
> +        flexcan_mb_unlock(s);
> +        flexcan_irq_update(s);
> +        rv =3D flexcan_get_timestamp(s, false);
> +    }
> +
> +    flexcan_trace_mem_op(s, addr, rv, size, false);
> +    return rv;
> +}



> +#define FLEXCAN_GENMASK(h, l) (((~(uint32_t)0) >> (31 - (h) + (l))) << (=
l))

Please don't roll your own mask creation macros. We have
MAKE_64BIT_MASK() in bitops.h.

> +/* FLEXCAN CRC Register (CRCR) bits */
> +#define FLEXCAN_CRCR_MBCRC_MASK         FLEXCAN_GENMASK(22, 16)
> +#define FLEXCAN_CRCR_MBCRC(x)           (((x) & FLEXCAN_CRCR_MBCRC_MASK)=
 << 16)

CID 1662973: FLEXCAN_CRCR_MBCRC_MASK is 0x7F0000. That means
that (((x) & FLEXCAN_CRCR_MBCRC_MASK) << 16) will always be 0,
because the field gets shifted off the top of the 32-bit type.

I suspect you meant here
(((x) << 16) & FLEXCAN_CRCR_MBCRC_MASK)

The standard QEMU FIELD macros let you use FIELD_DP32() which
avoids this kind of bug entirely.

thanks
-- PMM

