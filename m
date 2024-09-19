Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A83CE8D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 12:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srG27-0001sy-PZ; Thu, 19 Sep 2024 08:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srG25-0001dz-F4
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 08:13:13 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srG23-0001x8-L3
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 08:13:13 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c2561e8041so1027269a12.2
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 05:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726747989; x=1727352789; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TzMpZCVB9NHqLGK27a3PvRT37LkciyTprpfonu/P71g=;
 b=Xgc6886reKur3dDq9WzoNqTbnxCo8hQG1zMZdTu05AQle6ruo7pXiDt35y7fMXr61x
 80rT75VTBrOWKmSrrGIWrLhALOVzqQNkLIffTq1b7CDPyJhhCHUIkCOUpbPfh7LDemEZ
 4zDXO401M8HBIXAXjwiXAezUT8aSVUlGH6djk/l1fakX1k4BL/BkRVBTySiQnPzC+Stk
 ZuABpWZSzMMY+oAkS5Zj42kRmFQzKdgtRIH8gl+zoz8Bl0JxlwxqKXk2jGJA3oBZzrsw
 ytjF2ZTrY5KtCebElciuYQlDCPNbmvhTieg0NJOLbXiwISgY0Sgtn+kzR9/q1ddRL8dK
 m7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726747989; x=1727352789;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TzMpZCVB9NHqLGK27a3PvRT37LkciyTprpfonu/P71g=;
 b=a64wmX0odU99O0VCX0hFo1eFjY8eISH1UBE04Simjohx++HsUUlOfpN/zCIEO00WCG
 Xskz4KwG1e0Ji2duJYQCK8oQvrt3q10cXy5biZp1T3JLUjQk2h8+NtY3eMxiya9C1AT8
 1VrNCoJx58aLK3zEN6k4zfhy6G4JNPKlrr5AzhTtN68IErxyXEk9RTaDbD+DvSAyQTpS
 oKujvTFD+xD62Ab8wcL4NcqwoH3MZYG5oQmux1VdA3lZefH0zk4dcSnWiIk9RzrC7fgU
 bNIYCURhWaVu7F4Df51FWoz3t6wuvz8Gg/qbGVDwu5q6zVA5EW3g4mUEGCQ6ZyUNJDqU
 DiHw==
X-Gm-Message-State: AOJu0YwwtfSpk+7nOayqnoQ3QM8Dfk/2Z/JBHUVwmv6yrzbbrI3xtryu
 hM+xvxR+4CW49EUVLP2Kp5KqjhfA0q6h1IwT+rn+Dn+DZk69ThaEINoog1Ym2DqyjU1mSlN7ic1
 ZADBTiYzjta3xmdBPYLpM1CgHxDPTj14GunIbE49iPQGQadUn
X-Google-Smtp-Source: AGHT+IF9dxO4aL99tV4mmWRmOEiU0wPshWJJp2xg/4DDqOyap6PAeFmVLne8/DCsfgAazK2TB9itNfl/qZvxb0Ncdg8=
X-Received: by 2002:a05:6402:3511:b0:5c4:2efe:c9e3 with SMTP id
 4fb4d7f45d1cf-5c42efeccffmr14464697a12.17.1726747989491; Thu, 19 Sep 2024
 05:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240816132212.3602106-1-peter.maydell@linaro.org>
 <CAFEAcA8XwbB89sNKPJpFRXcFb1esUpRMaeue8e=Wepvpmr9PHw@mail.gmail.com>
In-Reply-To: <CAFEAcA8XwbB89sNKPJpFRXcFb1esUpRMaeue8e=Wepvpmr9PHw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Sep 2024 13:12:57 +0100
Message-ID: <CAFEAcA-7FGH0gk=g021cdH3NCx+8kJm0ygGMYrjyhB8JHnROMw@mail.gmail.com>
Subject: Re: [PATCH for-9.2 0/7] docs/devel: Convert txt files to rST
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

Ping^2.

In particular: Paolo, it would be helpful if you could
confirm what license you intended for the lockcnt.c code.

thanks
-- PMM

On Fri, 6 Sept 2024 at 16:12, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Ping for review on these docs conversions, please?
>
> thanks
> -- PMM
>
> On Fri, 16 Aug 2024 at 14:22, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > This patchset converts a collection of the remaining txt files in
> > docs/devel to rST format. At this point in the release cycle
> > I'm targeting 9.2 for these.
> >
> > Patches 1-5 are simple conversions.  In patch 6 I move the
> > QemuLockCnt APIs to their own header file; this is so that we can
> > include the kernel-doc generated APIs in lockcnt.rst (since
> > kernel-doc works on a per-file basis).
> >
> > Paolo: can you confirm that you mean GPLv2-or-later for the lockcnt
> > code?  There's no explicit license comment in either util/lockcnt.c
> > or include/qemu/thread.h.
> >
> > (There's one .txt file left in docs/devel after this, but I don't
> > think it's very useful so I propose to delete it and will send a
> > separate patch for that.)
> >
> > thanks
> > -- PMM
> >
> > Peter Maydell (7):
> >   docs/devel/blkdebug: Convert to rST format
> >   docs/devel/blkverify: Convert to rST format
> >   docs/devel/lockcnt: Convert to rST format
> >   docs/devel/multiple-iothreads: Convert to rST format
> >   docs/devel/rcu: Convert to rST format
> >   include: Move QemuLockCnt APIs to their own header
> >   docs/devel/lockcnt: Include kernel-doc API documentation
> >
> >  MAINTAINERS                                 |   8 +-
> >  docs/devel/blkdebug.rst                     | 177 ++++++++++++++++++++
> >  docs/devel/blkdebug.txt                     | 162 ------------------
> >  docs/devel/{blkverify.txt => blkverify.rst} |  30 ++--
> >  docs/devel/index-api.rst                    |   1 +
> >  docs/devel/index-build.rst                  |   2 +
> >  docs/devel/index-internals.rst              |   2 +
> >  docs/devel/{lockcnt.txt => lockcnt.rst}     |  89 +++++-----
> >  docs/devel/multiple-iothreads.rst           | 139 +++++++++++++++
> >  docs/devel/multiple-iothreads.txt           | 130 --------------
> >  docs/devel/{rcu.txt => rcu.rst}             | 172 +++++++++----------
> >  include/block/aio.h                         |   1 +
> >  include/hw/core/cpu.h                       |   1 +
> >  include/qemu/lockcnt.h                      | 130 ++++++++++++++
> >  include/qemu/thread.h                       | 111 ------------
> >  accel/accel-blocker.c                       |   1 +
> >  hw/core/cpu-common.c                        |   1 +
> >  util/aio-posix.c                            |   1 +
> >  util/aio-win32.c                            |   1 +
> >  util/async.c                                |   1 +
> >  util/fdmon-epoll.c                          |   1 +
> >  util/lockcnt.c                              |   1 +
> >  22 files changed, 608 insertions(+), 554 deletions(-)
> >  create mode 100644 docs/devel/blkdebug.rst
> >  delete mode 100644 docs/devel/blkdebug.txt
> >  rename docs/devel/{blkverify.txt => blkverify.rst} (77%)
> >  rename docs/devel/{lockcnt.txt => lockcnt.rst} (75%)
> >  create mode 100644 docs/devel/multiple-iothreads.rst
> >  delete mode 100644 docs/devel/multiple-iothreads.txt
> >  rename docs/devel/{rcu.txt => rcu.rst} (73%)
> >  create mode 100644 include/qemu/lockcnt.h

