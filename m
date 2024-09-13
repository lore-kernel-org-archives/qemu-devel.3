Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAC8FA3755
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 13:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp6Ov-00039O-Cf; Fri, 13 Sep 2024 09:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp6Or-00034M-C5
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 09:31:49 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp6Op-0004rk-KW
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 09:31:49 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42cbe624c59so8261445e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 06:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726234306; x=1726839106; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jPSAQTcYukJUjVVxLXVWtdSoMx1yeaiBbuE9CLmPLCk=;
 b=G8chxfxxVzZ3gv4gnj3n/fHsYPA7KG2vJgM+F++UE7gJJFW0ecWgKM43W98i84IwvG
 myvkZTDffXsx5GyBtxHpoXFtAL02xBZcHwDzshua7oj0IJOCCyPCesLCARzko5kzaMYE
 97W0IRfguhrJBTIEwGKkDldCwKOaupkJs9KsQUgGi50tFCaxFahZHUCHHEIJuqyRMtgn
 GjIg6bkTribe0oFO+Gi3WF2J9XvxY80Pmrj2vby7slY16J5DlOhWWB8tMKCAVcNqhzu7
 h9bKhWq8ztU09QfRzm3ohDU3KwxRg8ZPtg31wcsPlbFWyOTvQMbDVBn49APFWVqQHPSE
 2b5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726234306; x=1726839106;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jPSAQTcYukJUjVVxLXVWtdSoMx1yeaiBbuE9CLmPLCk=;
 b=DRPhizqeFZXSX8M6LQSPL0RHNFxK6dOxWxcQKfi7+TCue6dDyUED0Xag1l7ru3eghg
 OOjckGEUthHYcVw111ckj4X1t736bPil7f7uAiaVxbWAW6FxSklHEtfz1XU7mLaRC4k4
 Rzel6nJHEjM1Avk+hSs9P+ywODqnsPJ9Lolsb0ri8HGYgxOcNIjTztZYHLJD8Q+GNam8
 TXY7goHMxOconqcpZMmK6osUS9omSwCN9+SOJq+JO1fmT4/dyXR3PcQwYm3L+NtxcRIp
 Bl2pCwUFukMxPruDTW0QorEmfT0+eBntyfnuE+jMvERc1ySIEsytAYpqSYwS49f4BR3U
 resQ==
X-Gm-Message-State: AOJu0YzGfWtzt7/5LdI87MRU1QVe5nc5+es16LAZe4KcN3e8BM8+pNAs
 YxxKEYrOPyhpnKOOLr54SVz8lRzQHjK+iHKt6xc4TaXs2BEEZeRCjRQyGShkUMLUJHFIlwBp8Tl
 l1rQ4PmCErC6WTWoa7IW/VJ0OTJicwN5F2yHfEkHFKPErYVkP
X-Google-Smtp-Source: AGHT+IF4DsVSpCAGgKfBuJG+Tbdirc2pSjCFUj5VQdSqwPXWafXuedv/hnKjT5ZdaqplSPg6hC16U9RJ14tIIi2U6b0=
X-Received: by 2002:a05:6000:1fa7:b0:378:8aaa:9cea with SMTP id
 ffacd0b85a97d-378d624185dmr2243934f8f.45.1726234305552; Fri, 13 Sep 2024
 06:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240912151003.2045031-1-peter.maydell@linaro.org>
 <CAFEAcA-ZuE4B1frfnkpS6yxu_YiTastZ9S_b=4_8zGigRtDeNg@mail.gmail.com>
In-Reply-To: <CAFEAcA-ZuE4B1frfnkpS6yxu_YiTastZ9S_b=4_8zGigRtDeNg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Sep 2024 14:31:34 +0100
Message-ID: <CAFEAcA9sUcspOwWU-huyza4Rp=vw=5wArXBSnV-KDVYm5=8u_g@mail.gmail.com>
Subject: Re: [PATCH v2] .gitlab-ci.d/crossbuilds.yml: Force 'make check'
 single-threaded for cross-i686-tci
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

On Fri, 13 Sept 2024 at 13:24, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 12 Sept 2024 at 16:10, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > The cross-i686-tci CI job is persistently flaky with various tests
> > hitting timeouts.  One theory for why this is happening is that we're
> > running too many tests in parallel and so sometimes a test gets
> > starved of CPU and isn't able to complete within the timeout.
> >
> > (The environment this CI job runs in seems to cause us to default
> > to a parallelism of 9 in the main CI.)
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > If this works we might be able to wind this up to -j2 or -j3,
> > and/or consider whether other CI jobs need something similar.
>
> I gave this a try, but unfortunately the result seems to be
> that the whole job times out:
> https://gitlab.com/qemu-project/qemu/-/jobs/7818441897

...but then this simple retry passed with a runtime of 47 mins:

https://gitlab.com/qemu-project/qemu/-/jobs/7819225200

I'm tempted to commit this as-is, and see whether it helps.
If it doesn't I can always back it off to -j2, and if it does
generate a lot of full-job-timeouts it's only me it's annoying.

Looking at the timed-out job it looks like it just took a lot
longer on the compile phase... (Though it's hard to say because
the fact we use "make all check-build" in our gitlab CI config
means gitlab treats this as all one step when it adds time
annotations, and you can't separate time-for-compile from
time-for-tests.)

-- PMM

