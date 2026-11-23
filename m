Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843E3606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gbGflroP;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=L7QJVGRN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVWjv-0001p6-18; Mon, 23 Nov 2026 11:17:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xVWjt-0001ox-Cl
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 11:17:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xVWjr-0002vl-Ki
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 11:17:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795450672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ATf/w9JAXaQjsy8vfed4omLl10VItLMiiZ/bmoXwK0=;
 b=gbGflroP6VNY+6H64c4p02FBN7ylzPpAmXyaaXnFcuinVZvIn1QgvFfzKaF5ydG4EFm9I6
 GaZ9da5f1kSLR9YF3t4x7bqkVzzOcf9F8RqzHpKRBq88Mes/6LB5QPMjqsrZJv93DgxLeS
 mNsqbkEe/YhCLuNZcZDidLLElzqqX/0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-DGg1swtRMb-aRdCP7FnR2Q-1; Mon, 23 Nov 2026 16:17:49 +0000
X-MC-Unique: DGg1swtRMb-aRdCP7FnR2Q-1
X-Mimecast-MFC-AGG-ID: DGg1swtRMb-aRdCP7FnR2Q_1795450668
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3aed37745bcso3624139a91.1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 08:17:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795450667; cv=none;
 d=google.com; s=arc-20260327;
 b=TNGar4QAoWS3zW6Yy15NFO6lmynAsgHWyLVvxZqkL4uUx1NoiTyli56T5Q0sX74+Av
 o4ORJ4HAR4E94tSkzgo+DOSyLapLfUibUEQrke3zzHBKnAoD+CJug7e2wzWHZyB8eT/m
 y9wZzB0jing3qxSw+PlmUcNBfsuS7P6qou+9z40QV92uEp8OfsBlSc2O3oJVkPup3CU7
 NdLA55S5IymeRMg2x8RIPyn1LpdQxH82nLS8Ul1sTeaSjPS8uZntZ+ArGWL7ckU50MJg
 koPCmKhv9oA9erq6oLASfsjBlIhgdRGzPo7kUZSGO//cmhnTCtHagbT7HLjrtY9jrWBw
 CATg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2ATf/w9JAXaQjsy8vfed4omLl10VItLMiiZ/bmoXwK0=;
 fh=WYdm4gs/Ax4+GRbGMViCVZJauWbTAy2YVE0gMOcD+bc=;
 b=ACsPFJ3ck642b4Y1yVC8TTUJ1zQW1Yj2BrZdth3qnH839iQsjfL3ZbuF+mAYn/jpcy
 t33/ByxHUYCKTWwNk4YgWoxUjc9oE8ztP9rAUbezIUoekpubsR1e1nwvzLoJCjjXQtPD
 YU3eaCpOJZaquR/lgsSEdA0vv6MnklAI0Hp6zOSYSaYQ+IT9u87pdb0VHojUn6KCJPk4
 +V98pYiRaLAL4a9WPRhEd6CThOvEL8WARG00vv7SWerxNTXGYYqtm4SwKRtTKSuffkVb
 Bq57X/BomGU/r26Pg3rMdKCZekc7tpHv3ashD8AbWCB6cKwl7ayFg4u5iMtanA8Qk0bM
 lPFg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795450667; x=1796055467; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2ATf/w9JAXaQjsy8vfed4omLl10VItLMiiZ/bmoXwK0=;
 b=L7QJVGRNcxVAjBBlr5rp8QeL4FOGO5d/8NuY6iW76L3yrToCgi9r9ftjbWwskwrJxr
 HubY6nhZV8mMqQZQtPKl/otZ0znV55TDd4k+cQJQOHyKCCoEzH1WWZkaBRbSCCI0m6na
 xXj3GidhqLGGbiqWgMUkofRxJ/EJHD83mFD1FqFDzjgAsH3HD4PNns+NwBJkX1m04nc8
 uwGraMe4Rg2tWwh0a7EFgMRTPhvjLJbTX6vtLxYDcDImoomoQZlvIBEX96RxzjCN9Q5y
 f7I3ztNNiedAlppVabneRgFz6oEU/bt9N+cx4/J6L4LuEwAaUd6WKKWWnku8lcJoADIA
 wbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795450667; x=1796055467;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2ATf/w9JAXaQjsy8vfed4omLl10VItLMiiZ/bmoXwK0=;
 b=QgG7EKSMUuttXMY/DG56Ih9nWDDtheTMD9X/NMyGxWU4ufQMwENCPMiq9/svOLUwpP
 FKVFIk2W9DO2AzzQLlvLXKejY1BKOpMZqpmLf9s1c3Ji06v1MkPg5iqakzXmmAFTA0yo
 K0gqckMm2M3bBakD183K4j8y8xL/NNTACYZpy1CJ4Yeza6osS1G9IsCUDWCVMDRpgUPF
 qtfP0gGG4uYbl3atyKYa94x7GMDAzjP9bmLVxqK5KvEpZS6Ub3DxJASMlHj6cU7ZdGDF
 8aL05VBKYtLvWRRx/4VSp3kCKQBD1hOyHXijUovywkZ7VJOfpBI7rrkSurRMgjzJUX/x
 o5gQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEwFQtClIkJDiFh5IqcdmmgPoR+JTbBEuhD26ICWYU37wCenR5NSpzDBfPAl+R/buTkWt/xLJi+2Ct8@nongnu.org
X-Gm-Message-State: APuU4Z9ObXVMpIAzCiCIWvTB4yRzPcGDyBVAQIhGLvqk9RDKoyIdWweT
 Iblm6tEMZXgKfL8i3TxN0AnhRYbF2iYwj1thAQVHhypGy5081dALyoZL7yroJyWcnbCR59wMfd0
 wOnHm/IhcCkFKdLydnUKKzCRvUrraUm1vYsrf8/WmMGHf0D9iPk9HVCE8udzKblT2o4fGYiK8Bs
 stmsDPIZ2CmUtFoVk29n1z5QSRnH04KDA=
X-Gm-Gg: AZFdTZfsY++Q2zWo7ST9rvQOTcNiDQbOOK/89kGDCiZpylY6r1mOuy1mgS1VHpAT7DE
 hVkQ/dU4YJL36mQA383FCLjSaaa3ugi5a5/R80mltXLN7uASaPHkKmlgXygeHb61XALgMmC2Ft5
 e/z8Rv772sjq8+xad46G2SPlI31RTT8Rpz7Lw+pEMq/Dt8T7C6XKiRL2ZNEKa27iQq27wQv5sQq
 J/1mvDdgxNNrXh0GmWYBqnAw+b/tOQ79QQsS28lDAJz4eRNRxwdEpY95q1rEtEdR7hy6rfTirYS
 AOkWdVNRi25fsANbBNKq
X-Received: by 2002:a17:90a:e710:b0:39e:6c68:fd91 with SMTP id
 98e67ed59e1d1-3b41c96151cmr7663943a91.38.1795450667400; 
 Mon, 23 Nov 2026 08:17:47 -0800 (PST)
X-Received: by 2002:a17:90a:e710:b0:39e:6c68:fd91 with SMTP id
 98e67ed59e1d1-3b41c96151cmr7663914a91.38.1795450666951; Mon, 23 Nov 2026
 08:17:46 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-2-pbonzini@redhat.com>
 <CAFEAcA91XU=_hS3iB+0p7hXQ_nvf0YpgNZaKsd=b=fSVaTJDxw@mail.gmail.com>
 <ar_FXE5rzVqKcTc4@redhat.com> <87ik21vy11.fsf@pond.sub.org>
 <CABgObfagz=EvmYtNFBo2xyDdXNkFPK8k0-YGDs7aVS6xRKEJTw@mail.gmail.com>
 <awQisiKRYpQSTmVy@redhat.com> <87a4mzwuqp.fsf@pond.sub.org>
In-Reply-To: <87a4mzwuqp.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 23 Nov 2026 17:17:35 +0100
X-Gm-Features: Aa3M54qYJ8rD5APliQNu91x3-Rf5TxwAd5j5S0VZ7IsjDdCG2KNFOiIsCiswtf8
Message-ID: <CABgObfaELn80BU_b9CjaTqiHx_tCj+8hSh+59FpUk33+osBvDQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 2:19=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
> >> Even larger QMP interfaces may fall under bullet #3 - parts of large
> >> code changes - but you definitely get a vote if there are substantial
> >> changes to code you maintain. No doubt about that! This is just normal
> >> interaction between maintainers; I think we do well in that respect
> >> and I see no reason for LLMs to change that.
> >
> > This is a new situation with LLMs though, and it ties back to the
> > SFC's (IMHO impossible) guidance that is included in this patch:
> >
> >   "the project seeks to both support those contributors who outright re=
ject
> >    generative AI systems, and to not shun those who choose to use them;=
"
> >
> > If the contributor wants to use LLM, and some but not all maintainers
> > do not, then we've got an impossible situation where someone is going
> > to come away quite unhappy.
> >
> > I don't think the proposal to allow pre-arrangement between contributor
> > and /a/ maintainer is workable, unless we accept that manitainers of
> > common code are just going to have to accept the result.

I see your point better now. IMO it's up to the maintainer who
initially agreed to review the patch to understand the issues that
arise. The maintainer can do an initial pre-review of the code, can
take on himself part of the yak shaving, can figure out a way to
reduce the scope back to something manageable, or can just say sorry.

> > There are plenty of examples of series which start off self-contained,
> > but grow into changes in common library code maintained by other
> > people. Often the maintainer of the common code won't get looped in
> > until v5 or v10 posting of a series.
>
> Matches my experience. Such growth is commonly due to
> reviewers demanding improvements.  The reviewers are
> commonly right.

I agree, it cannot be fully anticipated. However, in many other cases,
the changes are there from the beginning, thought to be "small", and
the second maintainer is only looped in late because of that. This is
already an antipattern, and one that (like most bad things) LLMs risk
exacerbating. The maintainer who is first approached can ask to see a
diffstat, loop in other people, etc. both without and with LLMs. And
in many (more?) cases the changes can be expected to stay
self-contained. The series I posted at
https://lore.kernel.org/qemu-devel/20261118122357.659634-1-pbonzini@redhat.=
com/T/
is an example of something that is *really* large but can reasonably
be expected to stay within the scope of a single subsystem. Perhaps
there could be interactions with "make check-python" but those are
very limited.

> > By that point the LLM usage will be present throughout the
> > patch series.  There will be way too much pressure to accept
> > the LLM usage in the common code, for the other maintainers
> > to be able to say no.

On the other hand: people are already reviewing *clearly* LLM-produced
patch series (example
https://lore.kernel.org/qemu-devel/CABgObfbKKSoO1NsyygXUT4O1b+aPZ0SRNUGU55p=
cQphR5s81aQ@mail.gmail.com/T/).
Doesn't that produce the same kind of peer pressure on core
maintainers, in fact even more so because they are not warned in
advance?

Paolo


