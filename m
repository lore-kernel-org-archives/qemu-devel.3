Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E53BC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 06:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvqul-0005xK-Jr; Mon, 17 Aug 2026 02:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wvquB-0005ti-0A
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 02:33:28 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wvqu7-0004UN-W3
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 02:33:05 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8111c0c7561so36629017b3.3
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 23:33:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786948382; cv=none;
 d=google.com; s=arc-20260327;
 b=WtqwnWokRqeb0obIo0IeBa8YF65yn9LZnDQFLW9/PrlTgz0zezY2s94HgbN62JymnH
 R5c7pEh1Uz68lJm/eb1m6QiP0rMH3onizqUEND0u+9104doFSPqjgcb17LBUa5lOiUYq
 d4qSVp+feqGPupmReN0bUL/9qfU79JyAi82lh2CnL886hB/+cETAvCuMwuakvbqG+pqy
 3sKSzVGVGzRo/Wh+gIqZPby4sBKQpTHEui32V97RR25K2Fo962z02pBaWGrfEs/bJWqQ
 fNV6HxByk1V6krfR2oATzkobG9K1cE+VsbrZiszUu82trJ6SePp9qndlqMZcqIi3Y4dR
 sLAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FcD7iQMxaEVitjqsnWLDUbih8s3iM++atuzz8mv4FPs=;
 fh=EBO+ewaBzcwICwNeTItCWUiUAR27teQwQEsktwcbdbI=;
 b=rRVXUThvkDMbcGBEmEjKYBJuAOkSonMGAL8ouDTcQ6MQ3hx2H3RjrFwgQtRs4Qo4xS
 FIwNrGyYnUWr6MD9P+TwfLJBzUZ+pt9DaShFjwQTzg9SVGKOJfAXnBj7PReORXpYlNdM
 Ozvjdnlku5Jt9lrfE45L1kUqZ9spsPhrFTwkNot2iOcBttgyHrtoiuVlWIQoAwv9e9dY
 SF8CL6/KuaHHo5Dl/QxGJBkDfYzqxtlc5K3IXIz2+e0WM1QZdygQYVim0d6wx788A4eQ
 BZeQJ/92SQD7uzOqa8Ont6xvlfb7M7Ujkqs+ZgzhjDCRHbUXYtTKFN+XKtvj9gZfvBPa
 0OQw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786948382; x=1787553182; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FcD7iQMxaEVitjqsnWLDUbih8s3iM++atuzz8mv4FPs=;
 b=XQu2/IB1DDhQGaENKJWHOO3mYqwxV6S0tSq1KEGWT01SUBCGajrqKvVDpWmmtuwTNO
 BonxfNxvZJbbdlpOFR9HwF7mIwNjk4kk7IPnMy984kAeHa6VhGBMnRJCyEqWOlgPO88t
 RrrS26VIx2aanLVpbo1vtKPizRth+16SuTg+0pw/tziCZt8KwfW4XVmeqCqgJzywamkl
 GUF0H3z1VR9R8q3UlgucpJQClyAhOUPQWt5F3vfjqtZcT2YSUe6bdajvnTX86UsIuNAy
 ojgNk19cjx1o7ri7uXp1Ea7j+0f14DN564D2f2lyO/K+yCXs9b7o4fACSIvfYNO9fV8J
 lBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786948382; x=1787553182;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FcD7iQMxaEVitjqsnWLDUbih8s3iM++atuzz8mv4FPs=;
 b=rO0X3pknSWU/l5nSspBE/fQLl8HViDHOq9fNuusHppNFpscPpGrE0ivf7sL9BYuIhD
 ETxw2AyjiHoskYO3vguA5pyQUt2adaMcW4znLcdO0kOyggn8pfZoKFvcH2KE8uc1XdEN
 5iGttmdb2c747uipET60XlnJzzxQDUgK6XgK3YvsFPKa2zEwMr30Hbjqzmyn67OPc3UX
 eqEB+qKY9C6iGAnsbfwHvgEEQjRyMseze9HJIYwqvVy2GuUOEbWIDfvfi9H1hVQGHe+j
 KjG+7mLMtPCOtJqpL10fzAT1qITRgg0PQEelMypf3Cwpy1KITDvFPLZFMd9Aqo2xwnlr
 3KZA==
X-Gm-Message-State: AOJu0Yw7njzSzJe3oFeaMQdzvjTwWOmOy/+vRqqRuWC3zJQrPC7P5bgM
 1fAbAnTZAglrNzdRz7X53zdtEciQsVTjlSX8EkPS/lQkNJVku3xizHEOYRhc34OPFrq97gZWt8y
 eNGhZnJbFQGe+WLpAOWmhfo+aAYgLaoA=
X-Gm-Gg: AR+sD13u1qX602euCCTUPHnrJobYDNeRw8Qs19LHN7AS+QPnrH6AnfCpPXfCeqFo7Pg
 INVOhLik5UvNiHwrrQLu+/8X05bwx6DsMs/zCRLS7qNEIDd6LZ40pIYR9C8z69e83VjjJUmpgm8
 7lkdTIfp6tR+zrk7+VvrTtGdXFCAZuG13naY07uJWEqPjItIxmlahKMs1oco3qIii+njNZPGyDn
 L7sDYKxkfGMS4U+kvPqFSp7pnkyfGter0G/9EFpFfk8c9LEbfet7v2qaptQd4XjR1iTETNLZBMb
 x8o6VOUC6B9LAaRhX+nVTjRT1w/czLS0ZxnTJVTnUJk=
X-Received: by 2002:a05:690e:1906:b0:668:172a:47a7 with SMTP id
 956f58d0204a3-66c72c7653dmr7681677d50.25.1786948382345; Sun, 16 Aug 2026
 23:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260808182956.290561-1-flamboyant.h.01@gmail.com>
 <20260808182956.290561-2-flamboyant.h.01@gmail.com>
 <CAEUhbmV5hOJuoGjCgLGhMo+BVXNo+RY30D7hP7L9FpdU1Kt5Sw@mail.gmail.com>
In-Reply-To: <CAEUhbmV5hOJuoGjCgLGhMo+BVXNo+RY30D7hP7L9FpdU1Kt5Sw@mail.gmail.com>
From: Kangjie Huang <flamboyant.h.01@gmail.com>
Date: Mon, 17 Aug 2026 14:32:51 +0800
X-Gm-Features: AcwNN1Vk-mQnnGPY2YUST1tDf1C86ujxBLpx3KrBHaWcihQlEIvjC8WGOMG1f9g
Message-ID: <CAAW0U4afZ9Y6_dcypihVTSTWLpe0yVqfndWCOD15jU5xKZQk1g@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] hw/ssi: Add Synopsys DWC SSI standard PIO
 controller
To: Bin Meng <bmeng.cn@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Alistair Francis <alistair@alistair23.me>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Kangjie Huang <flamboyant.h.01@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-yw1-x112f.google.com
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

Bin Meng <bmeng.cn@gmail.com> =E4=BA=8E2026=E5=B9=B48=E6=9C=8816=E6=97=A5=
=E5=91=A8=E6=97=A5 23:28=E5=86=99=E9=81=93=EF=BC=9A
> > +    case A_TXFLR:
> > +        value =3D fifo32_num_used(&s->tx_fifo);
> > +        if (s->phase =3D=3D DWC_SSI_PHASE_STANDARD_TX_ONLY) {
> > +            dwc_ssi_run_transfer(s);
> > +        }
>
> The modeling of transferring data from TX FIFO needs to be reconsidered.
>
> IIUC, currently the TX-only transfer advances in 64-frame batches
> (DWC_SSI_PIO_TX_BATCH) and, once the phase is
> DWC_SSI_PHASE_STANDARD_TX_ONLY, dwc_ssi_push_tx() deliberately skips
> dwc_ssi_run_transfer(). The remaining FIFO entries only reach the wire
> when the guest reads TXFLR or SR (see below).
>
> What if an interrupt-driven guest that waits for TXE without reading
> those registers stalls once TXFTHR > 0: the FIFO stays above the
> threshold, TXE never asserts, and nothing drains it.
>
> I suggest draining on DR write, like sifive_spi model does. No other
> hw/ssi model advances its TX FIFO on status-register reads. sifive_spi
> flushes the whole TX FIFO synchronously on the TXDATA write
> (sifive_spi_flush_txfifo()), and with a FIFO depth of at most 256
> entries that is cheap. I'd drop DWC_SSI_PIO_TX_BATCH and have every DR
> write run the transfer until the FIFO drains. That also removes the
> asymmetry with the TR path, which already drains fully.
>
> > +        break;
> > +    case A_SR:
> > +        value =3D dwc_ssi_status(s);
> > +        if (s->phase =3D=3D DWC_SSI_PHASE_STANDARD_TX_ONLY) {
> > +            dwc_ssi_run_transfer(s);
> > +        }
> > +        break;

Hi Bin,

Thank you for reviewing the V3 patch. I agree that these issues need to be
fixed. For the TX-only FIFO progress issue, the current 64-frame batching
depends on reads from TXFLR/SR. In IRQ mode, the transfer may stop because =
TXE
is never raised.

While preparing, I found another issue in the K230 vendor Linux native-CS
SPI-mem path. The driver first fills the TX FIFO before enabling SER. It th=
en
reads TXFLR before writing the remaining data:
K230 SDK source:
https://github.com/kendryte/k230_sdk/blob/v2.0/src/little/linux/drivers/spi=
/spi-dw-core-k230.c#L709-L742
    len =3D min(dws->fifo_len, dws->tx_len);
    while (len--)
        dw_write_io_reg(dws, DW_SPI_DR, *buf++);

    len =3D dws->tx_len - ((void *)buf - dws->tx);
    k230_dw_spi_set_cs(spi, false);
    while (len) {
        entries =3D readl_relaxed(dws->regs + DW_SPI_TXFLR);
        if (!entries) {
            dev_err(&dws->master->dev,
                    "CS de-assertion on Tx\n");
            return -EIO;
        }
        room =3D min(dws->fifo_len - entries, len);
        ... write remaining frames to DR ...
    }

For the current K230 profile, fifo_len is 256. When i test a 260-byte
TX-only transfer has
4 bytes left after the first fill. If we remove the 64-frame limit and drai=
n the
FIFO immediately when SER starts the transfer, TXFLR may become zero before
the driver writes these 4 bytes. The driver then returns "CS de-assertion o=
n
Tx". If only DR writes can advance the model, TXFLR may stay full and the
driver will not issue a DR write to create room.

The SDK also says that native CS is controlled automatically: when the TX F=
IFO
has no data left, the controller de-asserts native CS. If the driver refill=
s
the FIFO too late, the transaction may end early.

The K230-specific DWC SSI driver also comments out the generic SPI IRQ setu=
p,
so its standard transfer path uses polling. The generic DWC SSI driver stil=
l
uses IRQ mode when an IRQ is available.

K230 DWC SSI driver:
https://github.com/kendryte/k230_sdk/blob/v2.0/src/little/linux/drivers/spi=
/spi-dw-core-k230.c#L589-L597
Generic DWC SSI driver:
https://github.com/torvalds/linux/blob/8d3ae59288f1e7d58d76558a6ee96d533bc5=
019f/drivers/spi/spi-dw-core.c#L416-L465

We need to fix the FIFO stall in IRQ mode, but the native-CS path must not =
see
TXFLR=3D0 too early. I am not sure how to handle both cases. Could you plea=
se
advise whether we need another way to advance the FIFO=EF=BC=8C
such as a QEMU timer or another mechanism?

Regards,
Kangjie

