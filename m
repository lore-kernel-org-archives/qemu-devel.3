Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872B9CCD1A7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 16:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAsxk-00073K-IB; Mon, 20 Oct 2025 12:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vAsxh-00072r-Qz
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 12:42:21 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vAsxf-000488-Pn
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 12:42:21 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-784a5f53e60so9425777b3.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 09:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760978537; x=1761583337; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=na7rpojVDz80IWBgk5QXvuTQoFVEqDNNgl7UDB+ik2E=;
 b=VZsfzzWbdCvckh8s1J84G4AvheklXWIJCVGqiWict7v+j0BZVXCXPLRbUbIEBQH7dD
 vgYM1YT8O+mKU/45pTE5at6doV+p5BL8di6qDWz25uRbgby8TJSv1+4takR7lHeDsIoL
 FutLtZtI3B71tAzYs/DO8+5aijBtf6Ixqs/en5zMyN1wt2hDs0ubVfXvj4oQX3PZH50a
 ENqclQ4lKRxypZpm6yuG6PXX+uNDO+wuxZvBkLjf9UZ0xms2th4f5eY+Orx+2+zJyX+i
 ow95qwGYq8Tx4lQiDNrhcsMl10+YIueT8tcE5Z6/M5Y89ry3Y8BrPklVwbTEktfvBcYH
 ugHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760978537; x=1761583337;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=na7rpojVDz80IWBgk5QXvuTQoFVEqDNNgl7UDB+ik2E=;
 b=tatWt812MeHCWUQvvChs1jisJ72uQ+Syz4dCNLr2SsSAAj8M3swRZAZ/y0Insi56+I
 SUYqRAZHGVtKSrUFyGgMmxGo9Nzh6edV5Ac41F81mCiRyuikg1wm7FXEf6Kvx8GRWQwV
 /C1goNIjQu0fuiTQIauVjOEUcqnhuX7n/Hfrnna0j1T7wUlpSYKpgk/2q8/JAAy4Dbvv
 RuoOQ4aJlLemH9tbcjv2ydy8nVjdaZoOuVxjbt+UOQQJDOwxz5+MyhFYJE/evPxdnaO8
 XLfnkoxh57fyuRCM8FvQkW+sKQ+8+j9JOW7SyrRmPl6e+YEMIGXnTAmK0MNlGGGXnkLS
 rG/w==
X-Gm-Message-State: AOJu0YxL+uv5TYohR8CvQI2hSV0Gi1ZU03K4Q9mueeHNjKf1GizmKckn
 FNlZZ+KkEDhfzkDCf+AqY5M54XIDkY0bggBzwdO8p56i+TdqAEbhGSpaQ3ZA5TNYWzfRb2tmLWp
 tPpq6a/AM4M+vvRBCOxJaEp+0aMOVLbfh9Ek6izNllg==
X-Gm-Gg: ASbGncsZgEJYzP7M/AMbmRym4/WoI4/ZoPwbB2Cl/1iYj4WJf82c6KzLlIzzC61hc0B
 aPIkmfCFEwWSbrbua1pf0Qli94mq3z3XJ5ZvsDci6fjppVDbMJElBO3q9l18utlu2MvsuHzdIID
 DPKJUEOYSFg1Hp85CLPAynuu6PK3x0dx9v7GIBgctcS0nPLpXUFIbWKIas9YG/vdGa5kqqP7Frf
 hCfl5apxYgzY+zc0EMDD1un+T6NgAJfWzUiKHgjdeNipgXovFcsf0FXyfU0zTEhd8g8JGz9
X-Google-Smtp-Source: AGHT+IHf57vYWL2VgpnKSP+o1fLmY73HCR19RY0nd5txpVesjMnMA5t3IHz/TSTE6I4JBLMQLrPTo+T5aenJuAp7aHM=
X-Received: by 2002:a53:b6cb:0:b0:636:d3a:30d6 with SMTP id
 956f58d0204a3-63e161c63cfmr6783413d50.35.1760978537100; Mon, 20 Oct 2025
 09:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA-OmqRTqwYZ2WCeqFu=zxG65t6WSfKR=NthfpazrjzpzA@mail.gmail.com>
 <f4f426c0-7470-8764-9faf-abecf610b557@eik.bme.hu>
In-Reply-To: <f4f426c0-7470-8764-9faf-abecf610b557@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Oct 2025 17:42:05 +0100
X-Gm-Features: AS18NWBe0IAGjlzrMq_WLpi6pZFNQCrOb0eHn6N87mVwlLmuKMr_JyfWBygJHL8
Message-ID: <CAFEAcA-usDuRU6sNdWmgWxFbHXkePnPGYocDafc=LPAUVbj4PA@mail.gmail.com>
Subject: Re: QEMU Summit Minutes 2025
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Fri, 17 Oct 2025 at 13:53, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Fri, 17 Oct 2025, Peter Maydell wrote:
> > Release tarballs
> > ----------------
> >
> > - Our release tarballs are quite large, and 85% of them is just the
> >  source of EDK2 which we include as the corresponding source for the
> >  EDK2 ROM blobs. This seems a bit silly, since most consumers of the
> >  tarball are either:
> >   - downstream distros who will want to build their own ROM blobs
> >     from the real upstream sources
> >   - end users who don't want to build the ROM blobs at all
> >
> > - We could perhaps usefully split the tarballs so that the ROM sources
> >  and the ROM blobs are in their own tarballs and only people who need
> >  them download them.
>
> Wouldn't this be solved by splitting off the EDK2 version QEMU needs into
> a separate project (something like qemu-edk2) and make that a separate
> dependency?

EDK2 is only special here because it happens to be huge. If
we're going to not have "one single huge tarball" then the question
is "what should the split be?".

> > - Relatedly, it would be nice for the ROM blobs to be trivially
> >  regenerable by anybody, rather than the current ad-hoc "some
> >  trusted person builds a binary locally and we commit it to git"
> >  setup. This should be much easier in these days of containers than
> >  it was when we first started committing compiled blobs to git.
>
> Having blobs is a big conveniece that would be preferable to keep as most
> of the time people don't need to rebuild blobs if they just want to run a
> machine and even if changing a machine they don't need to touch the
> firmware so it's only a few people who may want to install cross compilers
> or a container to rebuild blobs and it would be nice to save others that
> hassle.

Yeah. I think we would still commit the compiled blobs to git;
this bullet point is more about "make it more reproducible
so anybody, or perhaps our CI system in an automated job,
can create the blobs to be committed".

One idea I think that was suggested in the meeting was that
we could make our build system say "if the blobs aren't present
locally, download the blob tarball the way we do for various other
dependencies we might download at build time". That would make
things "just work" for most people while maintaining the separation
of blobs and blob-sources from QEMU's actual sources.

> > - However, nothing is fundamentally broken with our current setup, so
> >  unless anybody who really wants to do this work is going to step
> >  up we probably won't do anything ;-)

But also notice this part -- if anybody wants to tackle the
problem they get to define it and also do requirements
collection...

-- PMM

