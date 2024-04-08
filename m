Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA65CD1296
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 16:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rts5L-00051r-4V; Mon, 08 Apr 2024 12:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rts5J-00050X-Lp
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 12:43:05 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rts5H-0001PC-S2
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 12:43:05 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-516d2b9cd69so3754569e87.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 09:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712594581; x=1713199381; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nhXA/WbY1Csq/EgUKqT01dExzcf+ODTCCd3ktYaBezQ=;
 b=wuHjXas0V6cNieG2XjTkD53fF+Gl1P8HJBbeladRxhd4C/CNYqwI67/sU91EPRfvnv
 tucdjjlsF6tWls2PNZsBM9gLxE6AjbqK7Ayvm1zSi/QjOaeCaJJRAeTvnsbhF+MHH+PI
 KXd+GYHmyonzDTq0Ws072ja18EuuCKPlxN/basgfeqnWzeUXPQu4AqSM2eHiRZc+aL/4
 YfxEqsv/LDBiIsPjAT2yf3eP00+3Vfb3S1YjL/rWcQxvvKJmU2zJWtrOZ8CQANWZ/ovG
 zcaxBV91VDAMLrcSGXkolfvQJ2EG/f7FtnlJ07XuvELZgE1bEtPIOCzDSyvD6hMqyD0t
 zETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712594581; x=1713199381;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nhXA/WbY1Csq/EgUKqT01dExzcf+ODTCCd3ktYaBezQ=;
 b=Pq8xaELgp7y+AjJsITR5pAG8q8822KvnFZp/Buy5e6aMn4sTza8u1DiEGBDhroJOjA
 /wnS7bciFutwGBw5BiKiA85gI6e863TBYsF4ddajV+JGCUdOTUBz+Z/7juXjRiMElJX2
 Daer7G1U1kmri/78pgNLvJcwp5n/3Lr+G+sJXHoh6l7iF2nI7/UWvi305pQc3T+fdC04
 Db/sx0k0siyJEHWhLuFifOyKWSfO94Ct1pTkzimddQITlw5hjRVbKrVXZTMdmdnezs13
 RUyHw6EvaLKT+M+JH1j/p7jlWOQbLwoASX8vHbG+i25q/LZxnaRwekwyf10JkrCZmph6
 0SSA==
X-Gm-Message-State: AOJu0YwTj+qjgvwyZgUB9OFVltemrE0vp1q/o8nv4+2hTMr7KN1JmnbF
 3MlHnwEtXthQv+fOYWyhgByvmvs4od5GlFWxZsJJ1ARc//JqaEVRVdHFWl2V8I3YptAL2hFMm1D
 vKHrZfspFL6TeuBs1FRGVrrAIx85dfeATZjAhnA==
X-Google-Smtp-Source: AGHT+IH5GodWrp5ZXN7hBSGqCJi0whiAuloIsP8BgzjyeuCXibLzBgWVbUlJ2MSIxup2r26exUPHn+XCsPlRNEXuW8I=
X-Received: by 2002:a19:f615:0:b0:516:cd8e:eda2 with SMTP id
 x21-20020a19f615000000b00516cd8eeda2mr6053284lfe.53.1712594581329; Mon, 08
 Apr 2024 09:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240404085549.16987-1-philmd@linaro.org>
 <CAFEAcA-nrJc_WqTgw2uugqKoOdfoF8-NiKwftZczk38_XR5_CQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-nrJc_WqTgw2uugqKoOdfoF8-NiKwftZczk38_XR5_CQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Apr 2024 17:42:49 +0100
Message-ID: <CAFEAcA9iLiv1XGTGKeopgMa8Y9+8kvptvsb8z2OBeuy+5=NUfg@mail.gmail.com>
Subject: Re: [PATCH-for-9.0] hw/sd/sdhci: Discard excess of data written to
 Buffer Data Port register
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Bin Meng <bin.meng@windriver.com>, Mauro Matteo Cascella <mcascell@redhat.com>,
 qemu-stable@nongnu.org, 
 Alexander Bulekov <alxndr@bu.edu>, Chuhong Yuan <hslester96@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x134.google.com
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

On Mon, 8 Apr 2024 at 13:34, Peter Maydell <peter.maydell@linaro.org> wrote=
:
>
> On Thu, 4 Apr 2024 at 09:56, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.o=
rg> wrote:
> > diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> > index c5e0bc018b..2dd88fa139 100644
> > --- a/hw/sd/sdhci.c
> > +++ b/hw/sd/sdhci.c
> > @@ -552,7 +552,7 @@ static void sdhci_write_block_to_card(SDHCIState *s=
)
> >   * register */
> >  static void sdhci_write_dataport(SDHCIState *s, uint32_t value, unsign=
ed size)
> >  {
> > -    unsigned i;
> > +    unsigned i, available;
> >
> >      /* Check that there is free space left in a buffer */
> >      if (!(s->prnsts & SDHC_SPACE_AVAILABLE)) {
> > @@ -560,6 +560,14 @@ static void sdhci_write_dataport(SDHCIState *s, ui=
nt32_t value, unsigned size)
> >          return;
> >      }
> >
> > +    available =3D s->buf_maxsz - s->data_count;
> > +    if (size > available) {
> > +        qemu_log_mask(LOG_GUEST_ERROR, "SDHC buffer data full (size: %=
"PRIu32")"
> > +                                       " discarding %u byte%s\n",
> > +                                       s->buf_maxsz, size - available,
> > +                                       size - available > 1 ? "s" : ""=
);
> > +        size =3D available; /* Excess data of the last write is ignore=
d. */
> > +    }
> >      for (i =3D 0; i < size; i++) {
> >          s->fifo_buffer[s->data_count] =3D value & 0xFF;
> >          s->data_count++;
>
> So, this will definitely avoid the buffer overrun, and the
> quoted text also suggests that we should not be doing the
> "if sdhci_write_block_to_card() writes the data then keep
> going with the rest of the bytes in the value for the start
> of the new block". (With this change we could move the
> "if (s->data_count >=3D (s->blksize & BLOCK_SIZE_MASK)) ..."
> out of the for() loop and down to the bottom of the function.)
>
> But I'm not sure it fixes the underlying cause of the problem,
> because the repro case isn't writing a multi-byte value, it's
> only writing a single byte.
>
> It looks from the code like if there's no space in the
> buffer then SDHC_SPACE_AVAILABLE should be clear in the
> present-status register, but that has somehow got out of sync.
> The way the repro from the fuzzer toggles the device in and
> out of DMA mode looks suspicious about how that out-of-sync
> situation might have come about.

It looks like the spec says that TRNMOD writes are supposed to
be ignored while the Command Inhibit (DAT) bit is set, which
would forbid this kind of "turn DMA off in the middle of a
DMA transfer" silliness:

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index c5e0bc018b0..9cd887b7f30 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1208,6 +1208,12 @@ sdhci_write(void *opaque, hwaddr offset,
uint64_t val, unsigned size)
         if (!(s->capareg & R_SDHC_CAPAB_SDMA_MASK)) {
             value &=3D ~SDHC_TRNS_DMA;
         }
+
+        /* TRNMOD writes are inhibited while Command Inhibit (DAT) is true=
 */
+        if (s->prnsts & SDHC_DATA_INHIBIT) {
+            mask |=3D 0xffff;
+        }
+
         MASKED_WRITE(s->trnmod, mask, value & SDHC_TRNMOD_MASK);
         MASKED_WRITE(s->cmdreg, mask >> 16, value >> 16);

And if you forbid that TRNMOD write that turns off the DMA
then the write to BDATA is no longer an overrun.

So another approach here would be to do that, plus an assert()
at the point of writing into fifo_buffer[] in case there are
other ways to get there with a bogus SPACE_AVAILABLE setting.
(That way any further bug is only "badly behaved code makes
QEMU assert" rather than an overrun.)

The spec is annoyingly vague about the exact conditions
when writing to the used-in-dma registers like TRNMOD
and the block-size register. Currently we use the
TRANSFERRING_DATA() condition to block writes to BLKSIZE,
and you might have thought TRNMOD would be the same, but
apparently not.

thanks
-- PMM

