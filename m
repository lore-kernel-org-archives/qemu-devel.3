Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48720C3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 09:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sq83L-0004OT-RW; Mon, 16 Sep 2024 05:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1sq83J-0004Nq-4v
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 05:29:49 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1sq83H-0000P3-6d
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 05:29:48 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3e03a5ed4d7so1621960b6e.1
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 02:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726478985; x=1727083785;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ss2S+YjintUdScAM2LleCv0aK2E+5RpdIrz3Hsi4FG8=;
 b=HH0a1Nuyu8/k8Buf7AQ8zefblKb03yMqMJwFtQcEjTGGrDpCiuLVJbRpZ/9H7cIjJ2
 1ab64t2sW7oUNT5PolQ1FBLkGo07fQdz3XlZkf47S1zB7Rppy7dtOPA4h2XFvHddvOTn
 GX6wxCBjGIr+zm/F4bS4OMrrg8OPWm/HRPi10/5mR3g6HnaS+/zfWGxf/7AE+BqRGqCp
 BW9MpKzgKbebeovBh1oaAm9M2qNa/X4L8mkhHMa2Y/D+ArKU3W2jRg2XJ2R+Is/awuWm
 opHIPyA96SoqNx8VZb3cciVRed3dKDziAg7bkcrD0NPV9C18tnUPdGpqmVKKMkJuKgb0
 RoXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726478985; x=1727083785;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ss2S+YjintUdScAM2LleCv0aK2E+5RpdIrz3Hsi4FG8=;
 b=F+/JfnY0tvAVpumZ2z4yMUDElH71Wloi3za0oixu4IZg1j1tadOXD730InCOnLzDyt
 QtSOFJ95LKWWcEOcRNV3M1LktF2awSZbjMIwddOqNAlbg5QwuIx6fc+X11zTqXnreZkB
 IEL6GE/kAcU59E9n6ctoWjAgcJriEhmTGZKpDO7vPgu7yGYhmkItg+c574nHVH7kwQyT
 +DrlEV+G6sU4pUU/n3ZIgBSxy1DTHE2UHnhXFY+kwuxVsx3GlgB9ZQrDJcwd/NQZbkLn
 tGG6b+5K3nvfsZoeIm/hEpSeNl6pQsPxdenVBpV3My7jLJ4vovJn4E7l+yr7NfF78m+r
 dpWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3E3uxyyB8M6f2nY8poyla+/PKY6+UxtO9KiLeAs7NRDTw1ytOu0nxyIfpqFzXLJ7RHUz5J5/TA/3v@nongnu.org
X-Gm-Message-State: AOJu0Yx/ZQDv2w3Sxj+p4DcqcJ7YEic6mN1ZJ4peA5JB+9ZmhHmhpOG3
 OYTAfzYxlwb8s8E6eMoiCepQEq/eUtB7qOjADc3IxHWjj2+3eJa+Bcfs9seGCcBvxA2IcyHVHjY
 wCr6UNecsWyozgTpt42ExACpXTako/MWUQ5JY5w==
X-Google-Smtp-Source: AGHT+IGUAbt63FeOWbN+HFxNgKH8cRNT3grgoaHvEKXg0tP20ShIy6syKb0rG0IRvLYcoOjToeNGDbyczmZR2h3cu+k=
X-Received: by 2002:a05:6808:218c:b0:3dc:299d:c4fb with SMTP id
 5614622812f47-3e071b15a7emr9414158b6e.40.1726478985144; Mon, 16 Sep 2024
 02:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240819135455.2957406-1-mnissler@rivosinc.com>
 <CAFEAcA-pVJozMoPnUU9TO=0KKH3iR95rf7XLj9EuaM7+Q-VZoQ@mail.gmail.com>
 <ZuRgV7lS75BpDUox@x1n>
 <CAFEAcA9kSi1id2SnQWEPyM44GvSH=tPqf-Unhyk92xdy+xZkJg@mail.gmail.com>
 <CAGNS4Ta6Zcoa_ShNihTqeM+Z4jbk2O2hRTeGddtYq2zwra+xCQ@mail.gmail.com>
 <CAFEAcA8Q50P3Eb8_fJgpYQ21PYoHnoUiDz0NhX5KAma552+=Hw@mail.gmail.com>
In-Reply-To: <CAFEAcA8Q50P3Eb8_fJgpYQ21PYoHnoUiDz0NhX5KAma552+=Hw@mail.gmail.com>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Mon, 16 Sep 2024 11:29:34 +0200
Message-ID: <CAGNS4TasT2=sLWbDwhk2hpX0nNJJCwF=Yd5WrYGUDj=R2AGbjw@mail.gmail.com>
Subject: Re: [PATCH] softmmu: Support concurrent bounce buffers
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, stefanha@redhat.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=mnissler@rivosinc.com; helo=mail-oi1-x233.google.com
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

On Mon, Sep 16, 2024 at 11:05=E2=80=AFAM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> On Mon, 16 Sept 2024 at 08:35, Mattias Nissler <mnissler@rivosinc.com> wr=
ote:
> >
> > On Fri, Sep 13, 2024 at 6:47=E2=80=AFPM Peter Maydell <peter.maydell@li=
naro.org> wrote:
> > >
> > > On Fri, 13 Sept 2024 at 16:55, Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > On Thu, Sep 12, 2024 at 03:27:55PM +0100, Peter Maydell wrote:
> > > > > Coverity is pretty unhappy about this trick, because it isn't abl=
e
> > > > > to recognise that we can figure out the address of 'bounce'
> > > > > from the address of 'bounce->buffer' and free it in the
> > > > > address_space_unmap() code, so it thinks that every use
> > > > > of address_space_map(), pci_dma_map(), etc, is a memory leak.
> > > > > We can mark all those as false positives, of course, but it got
> > > > > me wondering whether maybe we should have this function return
> > > > > a struct that has all the information address_space_unmap()
> > > > > needs rather than relying on it being able to figure it out
> > > > > from the host memory pointer...
> > > >
> > > > Indeed that sounds like a viable option.  Looks like we don't have =
a lot of
> > > > address_space_map() users.
> > >
> > > There's quite a few wrappers of it too, so it's a little hard to coun=
t.
> > > We might want to avoid the memory allocation in the common case
> > > by having the caller pass in an ASMapInfo struct to be filled
> > > in rather than having address_space_map() allocate-and-return one.
> >
> > Hm, this would work, but not only does it complicate the code
> > consuming address_space_map, but it also increases memory footprint (a
> > pointer being replaced by a struct of sizeof(BounceBuffer) if done
> > naively), plus there's an additional pointer indirection (I'm doubtful
> > whether this can be optimized away by the compiler). I haven't done
> > any measurements of these effects, so can't say anything definitive,
> > but this seems pretty costly just to appease coverity...
> >
> > Is there no way to inform coverity that a resource pointer is being
> > transmuted into a handle, so it can track that instead? Given that
> > pointer tricks like this and container_of usage is quite frequent, I
> > would expect coverity to have a better strategy to handle these rather
> > than suppressing false positive leak reports?
>
> It's not purely that I want to appease Coverity. I also
> think for human readers that the current trick with passing
> back a pointer into host memory and relying on being able to
> get back to either the MR or to the bounce-buffer struct
> from that is pretty tricky. Would we have designed it that
> way if we weren't starting with the pre-existing address_space_map()
> function signature?

Identifying a mapping by its address seems pretty natural to me for
callers of the API, at least as long as the address is all that the
caller ever needs. The solution I implemented didn't/doesn't seem
overly complicated to me, and I am hoping it wouldn't overwhelm anyone
else who has worked with container_of (which seems to be used
liberally in qemu). But at the end of the day it's a matter of
personal taste and the background of the person writing the code, so
I'll readily admit that this is personal opinion, and if qemu does
prefer a different style then by all means we should change it and
I'll be happy to help with that.

