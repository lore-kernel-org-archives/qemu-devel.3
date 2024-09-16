Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24262C3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 07:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sq6H8-0006Gh-0m; Mon, 16 Sep 2024 03:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1sq6H6-0006GE-G7
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 03:35:56 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1sq6H4-0003q1-7w
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 03:35:56 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-710e1a48130so663045a34.1
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 00:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726472152; x=1727076952;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IUC1WPXTH/KFMy+Brz4MaC0Tgg04q9kzdwCz9Gsku80=;
 b=roThLFgx/lz64vDj09huCb8s3W6ct2iIKPt7G92AK8bI5DINyF1J1KDlSLZp0JqUIk
 RI7psLuUOmCadj0hLDrc6+GfxqaJhBoazuqK4PQ9K+WsVlnvAiWezUrA78mX5lqLiiAS
 rPiQXzZrNeREANVSRIsJR3BC9TJvrhNU9MTWrZLKitp8KN0QcG5Dg+q8Tk4F6L8aOMku
 /rzpLICp6WiUVBGiGovWTQw0NVJqK0f9NOAygpmfuQk3+ENGnhQLjKEwgOqs+fPEpTR+
 TWQ9U0ds2ca9zAt3Ac7blYkyMsR1KZdF/gxM4tDuGAy7qOifqk1DhK4XEok+9VsE8FCu
 6iFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726472152; x=1727076952;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IUC1WPXTH/KFMy+Brz4MaC0Tgg04q9kzdwCz9Gsku80=;
 b=gkyVTHEnAqZn+ryZHL+4l1/ls+ITD5iRm3cC8mnm41zCfTes7Ym3Jl4rf9XJJHfYPd
 6XCMxB+gmGEsQt4HOsmq38cABNn0mhlaGF0AKKVp9D+AhLfxVbdbH+fxPa7h2YvNjJVA
 qMYEHm31R6VY2zzYsahcbvnsOVAXOOkki+kRbsJqxXjiud7i/dDHZrcL9lI+A87az9Ox
 F/d3ES2uiSjwbMU2fJpaLHSCreQKQ2Sx7j07JPC5IVQsTUUxu3k0LHqmIB7oCNSJtwYO
 2Bb7uW/yOj7sdF0yDejWSwF8Uz9CiOwI7MgLtu4shkef7tIeLwcavl9lyt0AkXeUjel7
 b4tQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1FonM6T2hb+p1LOKjHV4ygBMSgjNzdIFnIZPXr3TlFF8C4dJ24J3UU5OkdB2zmd/jMyoC8gYgCOIY@nongnu.org
X-Gm-Message-State: AOJu0YxGnIIbQ2+eTN2h1IBMKO9jRIJNfB8vfh9SK7fuUpPB4QVROq2i
 qQV1Wx+v0idlby+G7b398VcqCwunjFXiykydOm0OUTSy4UD4J9w+I1+jL/bM5nP+xBPZTsKEj4g
 XXUqsDo9506VzZwNYXzrKepkKkcNUFAKoiMe4dw==
X-Google-Smtp-Source: AGHT+IGT7X/ATBYLlhy0o/KPSN/uEKkb1wP+mJA0zaWR6p8GGG8tnVDADKnALULuZFCPrbCdVU/JAiIq+Nek0LHW52w=
X-Received: by 2002:a05:6808:d52:b0:3e0:4db9:8c44 with SMTP id
 5614622812f47-3e07a1246b0mr5514964b6e.27.1726472151637; Mon, 16 Sep 2024
 00:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240819135455.2957406-1-mnissler@rivosinc.com>
 <CAFEAcA-pVJozMoPnUU9TO=0KKH3iR95rf7XLj9EuaM7+Q-VZoQ@mail.gmail.com>
 <ZuRgV7lS75BpDUox@x1n>
 <CAFEAcA9kSi1id2SnQWEPyM44GvSH=tPqf-Unhyk92xdy+xZkJg@mail.gmail.com>
In-Reply-To: <CAFEAcA9kSi1id2SnQWEPyM44GvSH=tPqf-Unhyk92xdy+xZkJg@mail.gmail.com>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Mon, 16 Sep 2024 09:35:40 +0200
Message-ID: <CAGNS4Ta6Zcoa_ShNihTqeM+Z4jbk2O2hRTeGddtYq2zwra+xCQ@mail.gmail.com>
Subject: Re: [PATCH] softmmu: Support concurrent bounce buffers
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, stefanha@redhat.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=mnissler@rivosinc.com; helo=mail-ot1-x331.google.com
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

On Fri, Sep 13, 2024 at 6:47=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Fri, 13 Sept 2024 at 16:55, Peter Xu <peterx@redhat.com> wrote:
> >
> > On Thu, Sep 12, 2024 at 03:27:55PM +0100, Peter Maydell wrote:
> > > Coverity is pretty unhappy about this trick, because it isn't able
> > > to recognise that we can figure out the address of 'bounce'
> > > from the address of 'bounce->buffer' and free it in the
> > > address_space_unmap() code, so it thinks that every use
> > > of address_space_map(), pci_dma_map(), etc, is a memory leak.
> > > We can mark all those as false positives, of course, but it got
> > > me wondering whether maybe we should have this function return
> > > a struct that has all the information address_space_unmap()
> > > needs rather than relying on it being able to figure it out
> > > from the host memory pointer...
> >
> > Indeed that sounds like a viable option.  Looks like we don't have a lo=
t of
> > address_space_map() users.
>
> There's quite a few wrappers of it too, so it's a little hard to count.
> We might want to avoid the memory allocation in the common case
> by having the caller pass in an ASMapInfo struct to be filled
> in rather than having address_space_map() allocate-and-return one.

Hm, this would work, but not only does it complicate the code
consuming address_space_map, but it also increases memory footprint (a
pointer being replaced by a struct of sizeof(BounceBuffer) if done
naively), plus there's an additional pointer indirection (I'm doubtful
whether this can be optimized away by the compiler). I haven't done
any measurements of these effects, so can't say anything definitive,
but this seems pretty costly just to appease coverity...

Is there no way to inform coverity that a resource pointer is being
transmuted into a handle, so it can track that instead? Given that
pointer tricks like this and container_of usage is quite frequent, I
would expect coverity to have a better strategy to handle these rather
than suppressing false positive leak reports?

If coverity can be made to understand this, it seems we should at
least be able to mark the allocation in question as intentional leak
(and thus not to report) at the position in the code where we allocate
the bounce buffer, rather than having to create false positive
suppressions for every caller. Perhaps this would be simplified if we
extract out a function to allocate and initialize the bounce buffer,
and then tell coverity to assume that anything it returns is not a
leak? (My coverity experience is rather limited, just thinking out
loud based on what I've seen in other projects to help static analysis
tools in general)

