Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9991C3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 12:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqB6G-0002RK-3v; Mon, 16 Sep 2024 08:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1sqB6D-0002QN-NY
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 08:45:01 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1sqB64-0003GC-09
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 08:45:01 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5e1b5b617b8so1922685eaf.0
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 05:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726490684; x=1727095484;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eMp5SifoMUVFw1GoyilYWrMKO06iBW8KyTKXDYuiS0c=;
 b=EE3qDv71XN5bR5UMuev0in/LJ8DWZSVM/p9gRtvNeLW3g1z2uHl3bIdH3X6YxZaeu2
 VyTjh09sdqqWrX5pMeWuGCWieAZPW8diSAFHRrHb3g1tyzjNOvEipbeKeagC0epWxD7j
 Vtlc89L5NGopN2/CxXn75mTRfMyPKFYgrYjkQ1yH9J4H9uYswX8SSm6uhSPXpGV4Tp+B
 zA2OhLqncXp48iVzLxUazY+dCNeavmha1g772h8voQQ0KLSSJhA+55b4hPiyh7IN2ULv
 r5cy+O6mbwBjZK+pNjO5fVSZ1hXAAPscYAWb1shr2Qg6wmxT81X6uSSX8Gn45UBSq+c4
 bDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726490684; x=1727095484;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eMp5SifoMUVFw1GoyilYWrMKO06iBW8KyTKXDYuiS0c=;
 b=CMzKx6t5UY7zsRtt4QfObdWXjQ23pQ4UBO2bssQkSFIkEDtax7XLQ4tJk8yjXhMgbV
 fc5VSbfWzpnctVjzwuy6JMKAXVEM8pMR83eEFp03rG93oQ32TOW0SGhDxnCb+RSNtN+L
 LjPJOyoK6DQ3wsqBhJYyV/LQW2h8IHEOJFJQ2WI4L1HCgqUDfON9ZkZWfOFJcBN0u3WJ
 9hXXq//v5KC9O7hV8hnm3rYvDtoblVuvefOXHkc40O5us1z54j7AlYjWfnlMuMHiZeV1
 fQOoHeyvqTI+XEaIPXbstPCpi/bKokZ21dWLzs/MREJPw+k6LmB9uJdy+tSJd9L5Sze/
 tazA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWl2dqyDdFSXO5pwRBKGBy6qVtSlvKI5hylC0XC+FuOm2INv0pwueRKhpG7kqv76+pj0bL+6pLHU2jF@nongnu.org
X-Gm-Message-State: AOJu0YzSyLgsYt97xo1ax4s+XQabwcQveNd9MESpfJJFa9Q32ptrVsUf
 bqjIgjcJQI0MbfEWPhvM8eIl9WqtVhezAshO//5hOeNn9cEaNSqQWacWMw3a3fZ5u6HJjVidlXs
 Qmc/TJzx2Ic4yRVVweaSxzu0qYyoeSDGjGYGnug==
X-Google-Smtp-Source: AGHT+IEZnNP7HzAxjbnBpm8hv3hBb4A7c8Cr4sLRPSFe87BQdBHzXx9+/LKa67dqVTJziHKZFfIPxuSZxRZE3A0C9IQ=
X-Received: by 2002:a05:6820:359:b0:5d5:d5e9:4e38 with SMTP id
 006d021491bc7-5e1e6593812mr9425174eaf.2.1726490684572; Mon, 16 Sep 2024
 05:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240909201147.3761639-1-peterx@redhat.com>
 <20240909201147.3761639-2-peterx@redhat.com>
 <441f797f-a377-45de-bfe6-042542c917d8@kaod.org> <ZuRQirmjwWGj1N2D@x1n>
 <CAGNS4TaDVs9eqb9jO5kgi9bL1t1tmc-GywiyP3xpbgFGgvbkLg@mail.gmail.com>
 <0d4c42a4-352d-4b14-905d-ef4839c68ad1@ilande.co.uk>
 <CAFEAcA80SmMbNOhUqgB8h+16RR+d_hOeoVqUCJQZJHvDUtCaYw@mail.gmail.com>
 <10b76006-4cb5-485e-aff2-87c9e511ad2b@ilande.co.uk>
 <CAFEAcA-JxRJx8jXuJu4MSLgWw2Ks=3VN7jR2BGYHxxKMQFJ9wQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-JxRJx8jXuJu4MSLgWw2Ks=3VN7jR2BGYHxxKMQFJ9wQ@mail.gmail.com>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Mon, 16 Sep 2024 14:44:34 +0200
Message-ID: <CAGNS4TY_+6pxevcaXGjduMDm2ovYeiqSvL4sQ_zm5y=m1LkLXQ@mail.gmail.com>
Subject: Re: [PULL 1/9] softmmu: Support concurrent bounce buffers
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=mnissler@rivosinc.com; helo=mail-oo1-xc32.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, Sep 16, 2024 at 2:28=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Mon, 16 Sept 2024 at 13:14, Mark Cave-Ayland
> <mark.cave-ayland@ilande.co.uk> wrote:
> >
> > On 16/09/2024 12:44, Peter Maydell wrote:
> >
> > > On Mon, 16 Sept 2024 at 12:29, Mark Cave-Ayland
> > > <mark.cave-ayland@ilande.co.uk> wrote:
> > >> I'm fairly sure that this patch would break MacOS 9 which was the re=
ason that
> > >> dma_memory_unmap() was added here in the first place: what I was fin=
ding was that
> > >> without the dma_memory_unmap() the destination RAM wasn't being inva=
lidated (or
> > >> marked dirty), causing random crashes during boot.
> > >
> > > dma_memory_unmap() of something you never mapped is
> > > definitely wrong. Whatever is going on here, leaving the unmap
> > > call in after you removed the dma_memory_map() call is just
> > > papering over the actual cause of the crashes.
> > >
> > >> Would the issue be solved by adding a corresponding dma_memory_map()=
 beforehand at
> > >> the relevant places in hw/ide/macio.c? If that's required as part of=
 the setup for
> > >> bounce buffers then I can see how not having this present could caus=
e problems.
> > >
> > > The only purpose of this API is sequences of:
> > >    host_ptr =3D dma_memory_map(...);
> > >    access the host_ptr directly;
> > >    dma_memory_unmap(...);
> > >
> > > The bounce-buffer stuff is an internal implementation detail
> > > of making this API work when the DMA is going to a device.
> > >
> > > We need to find whatever the actual cause of the macos failure is.
> > > Mattias' suggested change looks right to me.
> > >
> > > I do wonder if something needs the memory barrier than
> > > unmap does as part of its operation, e.g. in the
> > > implementation of the dma_blk_* functions.
> >
> > It has been a few years now, but I'm fairly sure the issue was that dma=
_blk_read()
> > didn't mark RAM containing code as dirty/invalid, and since MacOS 9 use=
d overlays
> > then it would crash randomly trying to execute stale memory. dma_memory=
_unmap()
> > checks to see if the direction was to RAM, and then marks the memory di=
rty allowing
> > the new code to get picked up after a MMU fault.
>
> dma_blk_io() does its writes into guest memory by doing
> a dma_memory_map()/write-to-host-pointer/dma_memory_unmap()
> sequence, though (this is done in dma_blk_cb()).
>
> More generally there should be *no* path for doing writes to
> guest memory that does not handle the dirty-memory case:
> so if there is one we need to find and fix it.

I concur that it should be the responsibility of the code performing
the DMA write to make sure any invalidation side effects take place
rather than relying on ad-hoc calls taking place later.

Regardless, in the interest of reaching a conclusion here: Mark, can
you provide instructions on how to verify MacOS 9 or alternatively
kindly do a quick test?

Thanks,
Mattias

