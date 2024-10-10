Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0131CF11D5
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 12:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syrxw-00014M-KI; Thu, 10 Oct 2024 08:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syrxu-00013y-1w
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 08:08:22 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syrxs-0007Tg-5l
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 08:08:21 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c721803a89so1041054a12.1
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 05:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728562098; x=1729166898; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MBrW6rUtK2cUIBHMV2AHaGOPNeNNk+qPnJSNtq11beU=;
 b=ipUVs+Ee3rOhmu4NQEt01MTqNjGAGt1YBihc2cxj5CBiKamqtTuqB8UW86KDfSqiFT
 u4Vbq0FcxDHBnOpdeMuvuL1B5URo+HWDUco0U49tpe3VV4MFSQC7mSFk8Qy3kWNmq24T
 FTYaNxBRe4xIY7bdel9zWcs5sbPpX/mKzDLmOFRn+ntzfrnEN9G8e/Q7xx5VKerkkMHC
 h4a6QmH/UeNTSLZr8XxZByj3eam8yert/XgOtayLDZ1iycQu/Fy7cQZs3eSfVhbmPQaP
 WrGczP4T2j26oiLPiND/J3p0kuCzrkGJs0hwr6vMUiYWKLRz05qqiD9/GOYDi4M9gYc+
 SvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728562098; x=1729166898;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MBrW6rUtK2cUIBHMV2AHaGOPNeNNk+qPnJSNtq11beU=;
 b=nk892OmDq6UYafMij+kQ8OvRISrk1FK78Su67QTbCdZOwOfayzULXrTY8/D8wHTaE+
 jQt09DHa+x4+CxbLF2vfQPdhBkjfN8HCU0hwMSZBpVqC0eyL7oSTaSf7x2KgMVYc1eNy
 qzm2MgarHu7O9OlyMGOq7fNhCazQ59klZMvKtTV9BrhAmQmtU9ZbIGVZZpZjXmHbtX5O
 nJLpYcJNPdpU06gRVGTmVDHxaTdccKcySBLDAemjG4YDE4pF2vxx3dj5IX+fMQZ/rCZ0
 VlLrI8yQKjZ6uzH/M34JuEhhy1/CN/zs/BHNSa9NOzBAgmaTKmNMNb1UTKxAG9hbEH1X
 2iyw==
X-Gm-Message-State: AOJu0YxtmSE4/8qeCZblodDYP3qDAg9u1QqYcqNcmbcdAcQp9PxYjcT7
 RYnLrbSO7wTANY/UdCDWpAI92Owyvw7ZVwzvkL1jJ0bMKRQg1nBhg+wN7S1q0bKvXtUTM1L+eww
 IMnZrWD6C2favkG670+evs6+h47N+xZICSn5w6aFUeO7NHojS
X-Google-Smtp-Source: AGHT+IHXssH2eGRYAPPbZwTRCumB47WLE+LT0EjD4J9bxWqZYgB3vw/1DF3eK2npz3FmpYX/TrDSQTFdg/YkXOPqu2U=
X-Received: by 2002:a05:6402:40c7:b0:5c9:2a5a:5ed3 with SMTP id
 4fb4d7f45d1cf-5c92a5a6a87mr3738352a12.36.1728562097892; Thu, 10 Oct 2024
 05:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240816132212.3602106-1-peter.maydell@linaro.org>
 <CAFEAcA8XwbB89sNKPJpFRXcFb1esUpRMaeue8e=Wepvpmr9PHw@mail.gmail.com>
 <CAFEAcA-7FGH0gk=g021cdH3NCx+8kJm0ygGMYrjyhB8JHnROMw@mail.gmail.com>
In-Reply-To: <CAFEAcA-7FGH0gk=g021cdH3NCx+8kJm0ygGMYrjyhB8JHnROMw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Oct 2024 13:08:07 +0100
Message-ID: <CAFEAcA_qGBC4PLQGC5Qk9E5HE6kgs92pnkVc3GzHpy4pApzv+g@mail.gmail.com>
Subject: Re: [PATCH for-9.2 0/7] docs/devel: Convert txt files to rST
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

Ping^3 for review (or I'm going to just apply these anyway).

Paolo, I know we discussed this on IRC, but can I get an Acked-by
tag from you for the license clarification in patch 6, please?

thanks
-- PMM

On Thu, 19 Sept 2024 at 13:12, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Ping^2.
>
> In particular: Paolo, it would be helpful if you could
> confirm what license you intended for the lockcnt.c code.
>
> thanks
> -- PMM
>
> On Fri, 6 Sept 2024 at 16:12, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > Ping for review on these docs conversions, please?
> >
> > thanks
> > -- PMM
> >
> > On Fri, 16 Aug 2024 at 14:22, Peter Maydell <peter.maydell@linaro.org> wrote:
> > >
> > > This patchset converts a collection of the remaining txt files in
> > > docs/devel to rST format. At this point in the release cycle
> > > I'm targeting 9.2 for these.
> > >
> > > Patches 1-5 are simple conversions.  In patch 6 I move the
> > > QemuLockCnt APIs to their own header file; this is so that we can
> > > include the kernel-doc generated APIs in lockcnt.rst (since
> > > kernel-doc works on a per-file basis).
> > >
> > > Paolo: can you confirm that you mean GPLv2-or-later for the lockcnt
> > > code?  There's no explicit license comment in either util/lockcnt.c
> > > or include/qemu/thread.h.
> > >
> > > (There's one .txt file left in docs/devel after this, but I don't
> > > think it's very useful so I propose to delete it and will send a
> > > separate patch for that.)
> > >
> > > thanks
> > > -- PMM
> > >
> > > Peter Maydell (7):
> > >   docs/devel/blkdebug: Convert to rST format
> > >   docs/devel/blkverify: Convert to rST format
> > >   docs/devel/lockcnt: Convert to rST format
> > >   docs/devel/multiple-iothreads: Convert to rST format
> > >   docs/devel/rcu: Convert to rST format
> > >   include: Move QemuLockCnt APIs to their own header
> > >   docs/devel/lockcnt: Include kernel-doc API documentation
> > >
> > >  MAINTAINERS                                 |   8 +-
> > >  docs/devel/blkdebug.rst                     | 177 ++++++++++++++++++++
> > >  docs/devel/blkdebug.txt                     | 162 ------------------
> > >  docs/devel/{blkverify.txt => blkverify.rst} |  30 ++--
> > >  docs/devel/index-api.rst                    |   1 +
> > >  docs/devel/index-build.rst                  |   2 +
> > >  docs/devel/index-internals.rst              |   2 +
> > >  docs/devel/{lockcnt.txt => lockcnt.rst}     |  89 +++++-----
> > >  docs/devel/multiple-iothreads.rst           | 139 +++++++++++++++
> > >  docs/devel/multiple-iothreads.txt           | 130 --------------
> > >  docs/devel/{rcu.txt => rcu.rst}             | 172 +++++++++----------
> > >  include/block/aio.h                         |   1 +
> > >  include/hw/core/cpu.h                       |   1 +
> > >  include/qemu/lockcnt.h                      | 130 ++++++++++++++
> > >  include/qemu/thread.h                       | 111 ------------
> > >  accel/accel-blocker.c                       |   1 +
> > >  hw/core/cpu-common.c                        |   1 +
> > >  util/aio-posix.c                            |   1 +
> > >  util/aio-win32.c                            |   1 +
> > >  util/async.c                                |   1 +
> > >  util/fdmon-epoll.c                          |   1 +
> > >  util/lockcnt.c                              |   1 +
> > >  22 files changed, 608 insertions(+), 554 deletions(-)
> > >  create mode 100644 docs/devel/blkdebug.rst
> > >  delete mode 100644 docs/devel/blkdebug.txt
> > >  rename docs/devel/{blkverify.txt => blkverify.rst} (77%)
> > >  rename docs/devel/{lockcnt.txt => lockcnt.rst} (75%)
> > >  create mode 100644 docs/devel/multiple-iothreads.rst
> > >  delete mode 100644 docs/devel/multiple-iothreads.txt
> > >  rename docs/devel/{rcu.txt => rcu.rst} (73%)
> > >  create mode 100644 include/qemu/lockcnt.h

