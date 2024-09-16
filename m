Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96FD8C3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 09:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sq7fh-0001Mn-4N; Mon, 16 Sep 2024 05:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sq7ff-0001Fd-2y
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 05:05:23 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sq7fd-0006nm-Ef
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 05:05:22 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c4226a5af8so3662657a12.1
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 02:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726477519; x=1727082319; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KcVFsIezf3rekh22EaVvx4H7uocZC9nm0qD+BPLdntM=;
 b=Bapjd6/psxmgepTNLzwmJYtnHcmB5u4QIwpl9VqE874HJ8YZQMR3y2jp82ixpdJTqQ
 CpMrgbT0zQe6rfov2Tf/b45U+Q87PePEJtuJu/g025ueQi8Vwz2nrlVGPL/AdaVNCCet
 Cfy1exqqmnSaUjYTtH5BZJe+UZM2LkYab5+EsKoU0ZoDvMWoMcUw8LO3HpT42lEmSG63
 6EDltfqhj6GRAwpvWbPXt/D35yQab8rpYGwpu2eTHGWPd6SRPKSP4v8yqcHnr68QBw77
 GVQI+/x8rCTBtuCOlR81u3p7D4cBQBBK0kRQ1KemPUDJBMbwo7URsVZXi8CqJ+x8N/tG
 Xbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726477519; x=1727082319;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KcVFsIezf3rekh22EaVvx4H7uocZC9nm0qD+BPLdntM=;
 b=roi/C9SJxEi+0/bUO7p8gunmwz2qPNghZYmRdz+ZeKg4mzhbCeumrJQJyystMZMVbM
 Gf+HNnvTWLBcGc7fTb77Kd0eLjFXB0xqhgN7sbmUkIEPTNKgp6SkFx3U41pCLQKe7Mb/
 bvGQRqKKPm24Sgyv7pI7jkDJIJhyMrqOwT1YrBNA3eC/ChAWZZH0XqCwhg6XCMBJ2oaB
 D6GbKa8EqG5CubUT4HaT+1CVd7Ihao4W1mkVrr9cTzZ0n4txNFks3PmhYxSJOR7Hw6pl
 XbdP/ReKhBwuHUqjGH+/UzKNWJDuG4uhdsBA5QkmkQF1fMYNBWfdlRBy7O+tOVB4dUR+
 OmYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqUQtqbP3ike2YbHIA79zcsgmbKbD9wnoNdVdiKjyi4Zh84pgJs04H6uqg3liBc7d3E0GhPyuqD0v2@nongnu.org
X-Gm-Message-State: AOJu0YxUygpTbTp51Op3281JQbWEycglw0ZHOOVcrFP14fQf7pypuH84
 YZuZWbTr47ahxAnzn6kh7mO+M8PkXCneELlX1x/BUJyAehC8ZVlwiqjXoYHK6SspnBUsqK1RAoB
 aHB0c2MLThxYS2nTnmroMOXTZAZfkFlTNCHVBnVoR/efwYw9b
X-Google-Smtp-Source: AGHT+IFd7yAeGy4t2jD6gzql6ccxcEvqbLkmJSrW7TajeAAuUVEsGYwEvg9TuwacS8HFwHUq6RhdXNtB5DHJqPMDxq0=
X-Received: by 2002:a05:6402:d1:b0:5a3:a4d7:caf5 with SMTP id
 4fb4d7f45d1cf-5c413e5f5b9mr10079247a12.36.1726477519327; Mon, 16 Sep 2024
 02:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240819135455.2957406-1-mnissler@rivosinc.com>
 <CAFEAcA-pVJozMoPnUU9TO=0KKH3iR95rf7XLj9EuaM7+Q-VZoQ@mail.gmail.com>
 <ZuRgV7lS75BpDUox@x1n>
 <CAFEAcA9kSi1id2SnQWEPyM44GvSH=tPqf-Unhyk92xdy+xZkJg@mail.gmail.com>
 <CAGNS4Ta6Zcoa_ShNihTqeM+Z4jbk2O2hRTeGddtYq2zwra+xCQ@mail.gmail.com>
In-Reply-To: <CAGNS4Ta6Zcoa_ShNihTqeM+Z4jbk2O2hRTeGddtYq2zwra+xCQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Sep 2024 10:05:07 +0100
Message-ID: <CAFEAcA8Q50P3Eb8_fJgpYQ21PYoHnoUiDz0NhX5KAma552+=Hw@mail.gmail.com>
Subject: Re: [PATCH] softmmu: Support concurrent bounce buffers
To: Mattias Nissler <mnissler@rivosinc.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, stefanha@redhat.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Mon, 16 Sept 2024 at 08:35, Mattias Nissler <mnissler@rivosinc.com> wrot=
e:
>
> On Fri, Sep 13, 2024 at 6:47=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> >
> > On Fri, 13 Sept 2024 at 16:55, Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Thu, Sep 12, 2024 at 03:27:55PM +0100, Peter Maydell wrote:
> > > > Coverity is pretty unhappy about this trick, because it isn't able
> > > > to recognise that we can figure out the address of 'bounce'
> > > > from the address of 'bounce->buffer' and free it in the
> > > > address_space_unmap() code, so it thinks that every use
> > > > of address_space_map(), pci_dma_map(), etc, is a memory leak.
> > > > We can mark all those as false positives, of course, but it got
> > > > me wondering whether maybe we should have this function return
> > > > a struct that has all the information address_space_unmap()
> > > > needs rather than relying on it being able to figure it out
> > > > from the host memory pointer...
> > >
> > > Indeed that sounds like a viable option.  Looks like we don't have a =
lot of
> > > address_space_map() users.
> >
> > There's quite a few wrappers of it too, so it's a little hard to count.
> > We might want to avoid the memory allocation in the common case
> > by having the caller pass in an ASMapInfo struct to be filled
> > in rather than having address_space_map() allocate-and-return one.
>
> Hm, this would work, but not only does it complicate the code
> consuming address_space_map, but it also increases memory footprint (a
> pointer being replaced by a struct of sizeof(BounceBuffer) if done
> naively), plus there's an additional pointer indirection (I'm doubtful
> whether this can be optimized away by the compiler). I haven't done
> any measurements of these effects, so can't say anything definitive,
> but this seems pretty costly just to appease coverity...
>
> Is there no way to inform coverity that a resource pointer is being
> transmuted into a handle, so it can track that instead? Given that
> pointer tricks like this and container_of usage is quite frequent, I
> would expect coverity to have a better strategy to handle these rather
> than suppressing false positive leak reports?

It's not purely that I want to appease Coverity. I also
think for human readers that the current trick with passing
back a pointer into host memory and relying on being able to
get back to either the MR or to the bounce-buffer struct
from that is pretty tricky. Would we have designed it that
way if we weren't starting with the pre-existing address_space_map()
function signature?

thanks
-- PMM

