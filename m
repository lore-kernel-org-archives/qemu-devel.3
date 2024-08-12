Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D28CC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 12:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdUYt-00004w-VY; Mon, 12 Aug 2024 08:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sdUYf-0008Rj-P9
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 08:54:01 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sdUYY-0001xT-Mu
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 08:53:56 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-530e062217eso5179663e87.1
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 05:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1723467228; x=1724072028; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o5HJOYo3TXG8WGJEUY2mo3Js+BDMfHZ2yadzBsCtmwA=;
 b=PRHAbWBmyV+TgR4mHVdBQ23DR6ynsvW77mxI/1Iz5AzxGq4ZIcaUvZkB3nCdZDLJET
 RBkaWYZgCbrXVS55OCDTW7VCxFA92QcJC6mZVxT05A11Mpt9b2vNuTiqpR+OTqL/PJEf
 D0KnwSg4abU3FJA6WqatXWhZ6MgirAtPBZ0WOm4vdXjo9b2dJQgLw1sd9eTBznuIlQSp
 Duuqad4kTgBJUlbJ5R57sAU5/bqJmEC/360aLqo+Vv/bQ86y6X36uGLEpN8ZTV2UBGh+
 YJigLXkm8KGXk/WIxQk60eDDxqPq8mEacmWkem2DVyAi/Aq6pt5qArU4uHatb0OtWWHq
 5DNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723467228; x=1724072028;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o5HJOYo3TXG8WGJEUY2mo3Js+BDMfHZ2yadzBsCtmwA=;
 b=q73Lqj+8YZx7BX4Wgv9fMyLx/4VVkmioFvz9WFB4UOiDOBSTPmkPXLWEp2T27k25yC
 BbjXrc56CTIU/1vjnK262J3OVGE4BomCBUj6haeWD7kj1IWf62TUAEsgr+booNF5TEin
 Hu20NeXPQYoP6roNOY2FZn0ira2EwOMvfZqQlFg/nnImJmv1jGTIpW3KSDY6qOAJSsh3
 T6gHCtXz6isL+ZUoIG1IyiWXmKJ4ZIR24JORUcOzHTQIp1PbRfF9521Ddp9Qt5311hIC
 uDUP2MQiMYnbcL4z+93H8yhZ5CBPBXcKpmjp3iY+FFnN/L/tJL5U9I5i+zWt7WFg516H
 Z45A==
X-Gm-Message-State: AOJu0YyiJrIalM2Hy/dc4w8yFy6jSsS7E+PF1XqOWaAeGkVE0PmWXXLx
 YAohYtMlyiiQjnR2CuRLzrcdZ6d9TYJqarPT2c8dXwEL7QTqkoL06ulptPwGSEXPw24oiW9SO83
 68pau1C/Oqwn5EuEUgX1sAlKcqx2wjLTQG7NGRA==
X-Google-Smtp-Source: AGHT+IFuSPwa+vkxBABlMSfbiJDTyXgCGqzxL4WXGME+qyCeq5tLogPXTk6deSm3xb48nj/z11QXQx14DiDc+6csC9E=
X-Received: by 2002:a05:6512:3e0e:b0:52c:e1cd:39b7 with SMTP id
 2adb3069b0e04-532136482ffmr24808e87.5.1723467228224; Mon, 12 Aug 2024
 05:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240801140609.26922-1-jim.shu@sifive.com>
 <20240801140609.26922-3-jim.shu@sifive.com>
 <CAFEAcA9aOGichd7qL914QvS841gpTnwQjvR+ujv+91Qu12VJ=Q@mail.gmail.com>
In-Reply-To: <CAFEAcA9aOGichd7qL914QvS841gpTnwQjvR+ujv+91Qu12VJ=Q@mail.gmail.com>
From: Jim Shu <jim.shu@sifive.com>
Date: Mon, 12 Aug 2024 20:53:36 +0800
Message-ID: <CALw707pXXaWZqaPi9Xt8ONT94pGZw5XA5RKQzWFf_g6Y_Oopog@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] hw/dma: xilinx_axidma: Send DMA error IRQ if any
 memory access is failed
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=jim.shu@sifive.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Aug 8, 2024 at 9:34=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> On Thu, 1 Aug 2024 at 15:08, Jim Shu <jim.shu@sifive.com> wrote:
> >
> > The memory transactions from DMA could have bus-error in some cases. If
> > it is failed, DMA device should send error IRQs.
> >
> > Signed-off-by: Jim Shu <jim.shu@sifive.com>
> > ---
> >  hw/dma/trace-events    |  1 +
> >  hw/dma/xilinx_axidma.c | 69 ++++++++++++++++++++++++++++++------------
> >  2 files changed, 50 insertions(+), 20 deletions(-)
> >
> > diff --git a/hw/dma/trace-events b/hw/dma/trace-events
> > index 4c09790f9a..7db38e0e93 100644
> > --- a/hw/dma/trace-events
> > +++ b/hw/dma/trace-events
> > @@ -47,3 +47,4 @@ pl330_iomem_read(uint32_t addr, uint32_t data) "addr:=
 0x%08"PRIx32" data: 0x%08"
> >
> >  # xilinx_axidma.c
> >  xilinx_axidma_loading_desc_fail(uint32_t res) "error:%u"
> > +xilinx_axidma_storing_desc_fail(uint32_t res) "error:%u"
> > diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
> > index 6aa8c9272c..728246f925 100644
> > --- a/hw/dma/xilinx_axidma.c
> > +++ b/hw/dma/xilinx_axidma.c
> > @@ -194,6 +194,20 @@ static inline int streamid_from_addr(hwaddr addr)
> >      return sid;
> >  }
> >
> > +/* When DMA is error, fill in the register of this Stream. */
> > +static void stream_dma_error(struct Stream *s, MemTxResult result)
> > +{
> > +    if (result =3D=3D MEMTX_DECODE_ERROR) {
> > +        s->regs[R_DMASR] |=3D DMASR_DECERR;
> > +    } else {
> > +        s->regs[R_DMASR] |=3D DMASR_SLVERR;
> > +    }
>
> The MM2S_DMASR described in this doc:
> https://docs.amd.com/r/en-US/pg021_axi_dma/MM2S_DMASR-MM2S-DMA-Status-Reg=
ister-Offset-04h
> has both DMASlvErr/DMADecErr bits and also
> SGSlvErr/SGDecErr bits. Is that the wrong documentation
> for the version of the device we model, or is there
> a situation where we should be setting the other
> SlvErr/DecErr bits when we get an error from our
> memory accesses? Similarly there's a separate
> S2MM_DMASR in those docs which we don't model at all
> (so maybe it is the wrong datasheet...)

I also use this spec (PG021, AXI DMA v7.1). I think it is the right one.

1. For DMASlvErr/DMADecErr & SGSlvErr/SGDecErr
Spec has Scatter/Gather mode & Direct Register mode. It looks like a
HW config instead of SW config.
The SG mode uses MM2S_CURDESC (0x08) / TAIL_DESC (0x10) and direct
mode uses MM2S_SA (0x18) / MM2S_LENGTH (0x28) to transfer.
I think the QEMU model only implements SG mode now (S2MM also).
stream_dma_error() should set SGSlvErr/SGDecErr instead of DMA ones.
I will fix it in v3.

2. For MM2S & S2MM
QEMU has implemented 2 Streams. Stream[0] is MM2S and Stream[1] is S2MM.
The register read/write function will redirect to Stream[0] if addr <
0x30 and Stream[1] if 0x30 <=3D addr < 0x60.
stream_dma_error() is based on Stream* so it could support both MM2S & S2MM=
.

>
> > +
> > +    s->regs[R_DMACR] &=3D ~DMACR_RUNSTOP;
> > +    s->regs[R_DMASR] |=3D DMASR_HALTED;
> > +    s->regs[R_DMASR] |=3D DMASR_ERR_IRQ;
> > +}
>
>
>
> > +
> >  static MemTxResult stream_desc_load(struct Stream *s, hwaddr addr)
> >  {
> >      struct SDesc *d =3D &s->desc;
> > @@ -203,16 +217,7 @@ static MemTxResult stream_desc_load(struct Stream =
*s, hwaddr addr)
> >                                              d, sizeof *d);
> >      if (result !=3D MEMTX_OK) {
> >          trace_xilinx_axidma_loading_desc_fail(result);
> > -
> > -        if (result =3D=3D MEMTX_DECODE_ERROR) {
> > -            s->regs[R_DMASR] |=3D DMASR_DECERR;
> > -        } else {
> > -            s->regs[R_DMASR] |=3D DMASR_SLVERR;
> > -        }
> > -
> > -        s->regs[R_DMACR] &=3D ~DMACR_RUNSTOP;
> > -        s->regs[R_DMASR] |=3D DMASR_HALTED;
> > -        s->regs[R_DMASR] |=3D DMASR_ERR_IRQ;
> > +        stream_dma_error(s, result);
> >          return result;
> >      }
> >
> > @@ -224,17 +229,24 @@ static MemTxResult stream_desc_load(struct Stream=
 *s, hwaddr addr)
> >      return result;
> >  }
> >
> > -static void stream_desc_store(struct Stream *s, hwaddr addr)
> > +static MemTxResult stream_desc_store(struct Stream *s, hwaddr addr)
> >  {
> >      struct SDesc *d =3D &s->desc;
> > +    MemTxResult result;
> >
> >      /* Convert from host endianness into LE.  */
> >      d->buffer_address =3D cpu_to_le64(d->buffer_address);
> >      d->nxtdesc =3D cpu_to_le64(d->nxtdesc);
> >      d->control =3D cpu_to_le32(d->control);
> >      d->status =3D cpu_to_le32(d->status);
> > -    address_space_write(&s->dma->as, addr, MEMTXATTRS_UNSPECIFIED,
> > -                        d, sizeof *d);
> > +    result =3D address_space_write(&s->dma->as, addr, MEMTXATTRS_UNSPE=
CIFIED,
> > +                                 d, sizeof *d);
> > +
> > +    if (result !=3D MEMTX_OK) {
> > +        trace_xilinx_axidma_storing_desc_fail(result);
> > +        stream_dma_error(s, result);
> > +    }
> > +    return result;
> >  }
> >
> >  static void stream_update_irq(struct Stream *s)
> > @@ -294,6 +306,7 @@ static void stream_process_mem2s(struct Stream *s, =
StreamSink *tx_data_dev,
> >      uint32_t txlen, origin_txlen;
> >      uint64_t addr;
> >      bool eop;
> > +    MemTxResult result;
> >
> >      if (!stream_running(s) || stream_idle(s) || stream_halted(s)) {
> >          return;
> > @@ -322,9 +335,14 @@ static void stream_process_mem2s(struct Stream *s,=
 StreamSink *tx_data_dev,
> >              unsigned int len;
> >
> >              len =3D txlen > sizeof s->txbuf ? sizeof s->txbuf : txlen;
> > -            address_space_read(&s->dma->as, addr,
> > -                               MEMTXATTRS_UNSPECIFIED,
> > -                               s->txbuf, len);
> > +            result =3D address_space_read(&s->dma->as, addr,
> > +                                        MEMTXATTRS_UNSPECIFIED,
> > +                                        s->txbuf, len);
> > +            if (result !=3D MEMTX_OK) {
> > +                stream_dma_error(s, result);
> > +                return;
> > +            }
>
> In this function we only use result in the immediately following
> if(), so I think it would be slightly clearer to write them as
>       if (stream_desc_store(...) !=3D MEMTX_OK) {
>           break;
>       }
>
> without the use of the variable.
Thanks for the suggestion. I will fix it in v3.

>
> > +
> >              stream_push(tx_data_dev, s->txbuf, len, eop && len =3D=3D =
txlen);
> >              txlen -=3D len;
> >              addr +=3D len;
> > @@ -336,7 +354,9 @@ static void stream_process_mem2s(struct Stream *s, =
StreamSink *tx_data_dev,
> >
> >          /* Update the descriptor.  */
> >          s->desc.status =3D origin_txlen | SDESC_STATUS_COMPLETE;
> > -        stream_desc_store(s, s->regs[R_CURDESC]);
> > +        if (stream_desc_store(s, s->regs[R_CURDESC]) !=3D MEMTX_OK) {
> > +            break;
> > +        }
> >
> >          /* Advance.  */
> >          prev_d =3D s->regs[R_CURDESC];
> > @@ -354,6 +374,7 @@ static size_t stream_process_s2mem(struct Stream *s=
, unsigned char *buf,
> >      uint32_t prev_d;
> >      unsigned int rxlen;
> >      size_t pos =3D 0;
> > +    MemTxResult result;
> >
> >      if (!stream_running(s) || stream_idle(s) || stream_halted(s)) {
> >          return 0;
> > @@ -375,8 +396,13 @@ static size_t stream_process_s2mem(struct Stream *=
s, unsigned char *buf,
> >              rxlen =3D len;
> >          }
> >
> > -        address_space_write(&s->dma->as, s->desc.buffer_address,
> > -                            MEMTXATTRS_UNSPECIFIED, buf + pos, rxlen);
> > +        result =3D address_space_write(&s->dma->as, s->desc.buffer_add=
ress,
> > +                                     MEMTXATTRS_UNSPECIFIED, buf + pos=
, rxlen);
> > +        if (result !=3D MEMTX_OK) {
> > +            stream_dma_error(s, result);
> > +            break;
> > +        }
> > +
> >          len -=3D rxlen;
> >          pos +=3D rxlen;
> >
> > @@ -389,7 +415,10 @@ static size_t stream_process_s2mem(struct Stream *=
s, unsigned char *buf,
> >
> >          s->desc.status |=3D s->sof << SDESC_STATUS_SOF_BIT;
> >          s->desc.status |=3D SDESC_STATUS_COMPLETE;
> > -        stream_desc_store(s, s->regs[R_CURDESC]);
> > +        result =3D stream_desc_store(s, s->regs[R_CURDESC]);
> > +        if (result !=3D MEMTX_OK) {
> > +            break;
> > +        }
>
> In these two places also we don't need the variable.
Thanks for the suggestion. I will fix it in v3.

>
> >          s->sof =3D eop;
> >
> >          /* Advance.  */
> > --
>
> thanks
> -- PMM

