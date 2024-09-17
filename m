Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D44C3ABDF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 06:26:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqReO-0006Ub-NN; Tue, 17 Sep 2024 02:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1sqReL-0006Py-OQ
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 02:25:22 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1sqReI-0008Ff-H8
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 02:25:21 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3e06853e579so2680885b6e.0
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 23:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726554317; x=1727159117;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4JuUamB5l2v4Heut1Ym/kfOJLl6QfdzCZRU1MAkfwig=;
 b=3e7Ua+keB6ypzxeuEQFu4QQrmkpvHZbshZzmxJDRtmpwvlKwjyTSKjlWVRgJnPyH6W
 d/ZXNZDREBAhK9OcM6mgddjHgNOS0YPWl8oejxAIbJ2b8W6K6rlR8Y/rI+4HZsN5lr6o
 JHL/SffYaNteNj1+pCTcwYsMfGRVmc3qPfHrkrIjBBudjrTIQT23pgMbsQXiXr+t7obX
 XVJ52BFHhl5YHClCzLwnER82kr5yrvucCDzp0BsbXgOeovhFGfmONHWRylVUXIv6mTWl
 yERehDW/ajTVNFOxIT2DHqAFbLpmbqxC1ciEifOvZr9vPOsRCyG4nueAC3B0ntE0MT83
 cugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726554317; x=1727159117;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4JuUamB5l2v4Heut1Ym/kfOJLl6QfdzCZRU1MAkfwig=;
 b=a1J5oPDlHeBt5Aqc3HMVh+uT+wwApD/EP9dEFeOEAgFe88c7oKVKurnSdkyu3r09mh
 PU506pmYYQYAczFwWVW6TG2fPxhLeQQ0Sm8znHIUG/1ZHmx/v7klE1izpwsm6ejC4sCF
 iVjtjp74e18GrvhaUqudZPOVmrqSr0NAFVidrm22KOp0TJatAknUG18OaYJmGJg6X7OJ
 nkEnHcLgjRl/1mjqTdMci3Qkq8AvNH89u0vBl7JOIGn0VFaJSADJFQOOkMgFjTXmu8rZ
 h3NY7nYZN7/VI0sFBauGSYl80NnZG4BiYTQWgRD4SA3T1aCoI7ejjMsNw27XalOOBNn2
 +lGg==
X-Gm-Message-State: AOJu0YxSamtpLBAgBzveIqWxW5pW5xiKodwXQffYDoD2fmHn1HURquKD
 Ge9Ge5WtbQ9enxznPEVhro25dcp4cW8sF3r6+d1oAD1RHjRH2pzRJt3ZleJAp4zA2/b6xzdwJwO
 NIe8V5yyRKJTGbt6k2R9h81CrX2Q8FJiTvzBdrQ==
X-Google-Smtp-Source: AGHT+IENSixNhQN4HUFMAtV1v4swQrAJhTb3f5Jy0znCldWB7Xymbn6XwAVTacp27qFRPrCOUar0NXHiPvMcHvB0aLU=
X-Received: by 2002:a05:6808:199b:b0:3e0:5896:a0cf with SMTP id
 5614622812f47-3e071ae36abmr10372204b6e.35.1726554316707; Mon, 16 Sep 2024
 23:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240916175708.1829059-1-mnissler@rivosinc.com>
 <c7ded7f1-3985-4694-b033-6070911f49dc@ilande.co.uk>
In-Reply-To: <c7ded7f1-3985-4694-b033-6070911f49dc@ilande.co.uk>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Tue, 17 Sep 2024 08:25:06 +0200
Message-ID: <CAGNS4TZP2yOCurhWoskzswDvMjmW7xd4Xeg-dCnEuMc7tAJTsQ@mail.gmail.com>
Subject: Re: [PATCH] mac_dbdma: Remove leftover `dma_memory_unmap` calls
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 John Snow <jsnow@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=mnissler@rivosinc.com; helo=mail-oi1-x233.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Mark, thanks for testing and confirming that this doesn't cause any
obvious breakage.

For my curiosity, which path should this patch take to get into
master? Peter, are you going to respin your pull request with this
included?

On Mon, Sep 16, 2024 at 11:06=E2=80=AFPM Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> On 16/09/2024 18:57, Mattias Nissler wrote:
>
> > These were passing a NULL buffer pointer unconditionally, which happens
> > to behave in a mostly benign way (except for the chance of an excess
> > memory region unref and a bounce buffer leak). Per the function comment=
,
> > this was never meant to be accepted though, and triggers an assertion
> > with the "softmmu: Support concurrent bounce buffers" change.
> >
> > Given that the code in question never sets up any mappings, just remove
> > the unnecessary dma_memory_unmap calls along with the DBDMA_io struct
> > fields that are now entirely unused.
> >
> > Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> > ---
> >   hw/ide/macio.c             | 6 ------
> >   include/hw/ppc/mac_dbdma.h | 4 ----
> >   2 files changed, 10 deletions(-)
> >
> > diff --git a/hw/ide/macio.c b/hw/ide/macio.c
> > index bec2e866d7..99477a3d13 100644
> > --- a/hw/ide/macio.c
> > +++ b/hw/ide/macio.c
> > @@ -119,9 +119,6 @@ static void pmac_ide_atapi_transfer_cb(void *opaque=
, int ret)
> >       return;
> >
> >   done:
> > -    dma_memory_unmap(&address_space_memory, io->dma_mem, io->dma_len,
> > -                     io->dir, io->dma_len);
> > -
> >       if (ret < 0) {
> >           block_acct_failed(blk_get_stats(s->blk), &s->acct);
> >       } else {
> > @@ -202,9 +199,6 @@ static void pmac_ide_transfer_cb(void *opaque, int =
ret)
> >       return;
> >
> >   done:
> > -    dma_memory_unmap(&address_space_memory, io->dma_mem, io->dma_len,
> > -                     io->dir, io->dma_len);
> > -
> >       if (s->dma_cmd =3D=3D IDE_DMA_READ || s->dma_cmd =3D=3D IDE_DMA_W=
RITE) {
> >           if (ret < 0) {
> >               block_acct_failed(blk_get_stats(s->blk), &s->acct);
> > diff --git a/include/hw/ppc/mac_dbdma.h b/include/hw/ppc/mac_dbdma.h
> > index 4a3f644516..c774f6bf84 100644
> > --- a/include/hw/ppc/mac_dbdma.h
> > +++ b/include/hw/ppc/mac_dbdma.h
> > @@ -44,10 +44,6 @@ struct DBDMA_io {
> >       DBDMA_end dma_end;
> >       /* DMA is in progress, don't start another one */
> >       bool processing;
> > -    /* DMA request */
> > -    void *dma_mem;
> > -    dma_addr_t dma_len;
> > -    DMADirection dir;
> >   };
> >
> >   /*
>
> Thanks for looking at this, Matthias. I've given it a quick spin around v=
arious PPC
> Mac images and it looks good to me, so:
>
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>
> My guess is that the current use of dma_memory_unmap() was a misunderstan=
ding/bug
> when porting the macio IDE device over to use the byte-aligned block DMA =
helpers, so
> I think you can also add:
>
> Fixes: be1e343995 ("macio: switch over to new byte-aligned DMA helpers")
>
>
> ATB,
>
> Mark.
>

