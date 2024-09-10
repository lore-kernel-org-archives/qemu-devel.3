Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD01EB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 12:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snzrN-00068j-W5; Tue, 10 Sep 2024 08:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1snzrH-00067M-LQ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:20:36 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1snzrF-0002rJ-5d
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:20:34 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c3c30e6649so660960a12.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 05:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725970831; x=1726575631; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aQ1AGyAt4d5SfLzGUv2zjnWVjYFKrQxvqh1xYv3MDfY=;
 b=w0z8si5rNiH0CUCAGrEChO8DItNXUQ5Jw32cX0hBp8ZKZ/igpYCbkeZ7X426r79+sQ
 mw+yke+1nLUpvJi2GdtmLvB7XMX0TxoXmnIhX6PocMT9oM6UBIcWeypeJd3HoNQ7oBeo
 f+yp841Ws/GNc9Z+HcRHU0VRb4ws18WuwDyuyf/0+nkXybIlK4kfW1aVx6cEmo4IMhrk
 BanzJKDqKJPP6mEaiTz4OHnK1qCimELqFKLAGGi28Ns7vdJR7gEuZhqjcUKGIBWCMPna
 P2O0Eh1iVyLvj/oclPZO0smdyLbgSX6cZlSudlQHzsyJvjOcQWsnurgRMqEHD7ZQT6bR
 WRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725970831; x=1726575631;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aQ1AGyAt4d5SfLzGUv2zjnWVjYFKrQxvqh1xYv3MDfY=;
 b=gSyR0b+mGMHMK5VxD9xaAyfpGrENAPbwfoSRHhZDD/SCbWBEb3+eE6nEHJ2mi/oaIi
 RelDbPzfl8eUio5lUg596sSXhcdaXlUFOORwiiCZxd3BiZoRuxJlFQ+IeB0c95/DqVtN
 VSwE65d1IJr5ZA05y2qK1o/q6zMDNo2E2yNJfdUAYNE22dIyqyUhZwTHY+Q6DX8SeSGF
 E+vN1l5hp8MLL6E4MP/bwn/oGDkntGgmO03Fvu0eFwX4GSwGHcCeEfjk1kdDl0DwKU6X
 hYktvDXgwSdae4uuDx5veD1qShy6XzmA90gMj81ZKGb0Oz1DKTFC05N2O/cDYtzO2IIt
 0X9g==
X-Gm-Message-State: AOJu0YyLBm0vntfMeN5jVgSnk+WEM+8TrRkuo0vJCa850ms/ft9vCiHm
 V7e/h94nsaUUrZxa8cu1TFcuGXKNIxJjlyfVH9s697EgMgvoKQggXc8Wv8WEZ3IWlCU5luelQY0
 b9qB2s3cih2ubDGftpELg+Tm7GN5YQDBPB2anHQ==
X-Google-Smtp-Source: AGHT+IHTrbcOiYYuyyf8pgZbNODrLLNzxdR4J1ZagJOzhMG2z4fUg8lfqP4gVJkm4AMLUWfBNhrvesnCDTh3SLFLBpo=
X-Received: by 2002:a05:6402:2708:b0:5c0:8ea7:3deb with SMTP id
 4fb4d7f45d1cf-5c3dc7bec85mr9873090a12.22.1725970830994; Tue, 10 Sep 2024
 05:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240906180723.503855-1-peter.maydell@linaro.org>
 <20240906180723.503855-3-peter.maydell@linaro.org>
 <3d74779c-7048-4de8-ba6d-e65062b541c5@redhat.com>
In-Reply-To: <3d74779c-7048-4de8-ba6d-e65062b541c5@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Sep 2024 13:20:19 +0100
Message-ID: <CAFEAcA-phvrN5PMRHBBmNeb8wsLRSf9EuGpZMJiKhS_WmqN77w@mail.gmail.com>
Subject: Re: [PATCH 2/2] .gitlab-ci.d/crossbuilds.yml: Force 'make check'
 single threaded for cross-i686-tci
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Tue, 10 Sept 2024 at 13:13, Thomas Huth <thuth@redhat.com> wrote:
>
> On 06/09/2024 20.07, Peter Maydell wrote:
> > The cross-i686-tci CI job is persistently flaky with various tests
> > hitting timeouts.  One theory for why this is happening is that we're
> > running too many tests in parallel and so sometimes a test gets
> > starved of CPU and isn't able to complete within the timeout.
> >
> > Set the MESON_TESTTHREADS environment variable to 1 for this job;
> > this will cause 'meson test' to run only one test at a time.
> >
> > (Note that this relies on the change to meson2make that makes it
> > honour MESON_TESTTHREADS; otherwise it will have no effect.)
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > Seems worth a try -- if this doesn't have an effect then
> > we can revert it, but we'll at least have determined what
> > the problem isn't...
> > ---
> >   .gitlab-ci.d/crossbuilds.yml | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
> > index cb499e4ee0d..ca1db011b11 100644
> > --- a/.gitlab-ci.d/crossbuilds.yml
> > +++ b/.gitlab-ci.d/crossbuilds.yml
> > @@ -70,6 +70,9 @@ cross-i686-tci:
> >       ACCEL: tcg-interpreter
> >       EXTRA_CONFIGURE_OPTS: --target-list=i386-softmmu,i386-linux-user,aarch64-softmmu,aarch64-linux-user,ppc-softmmu,ppc-linux-user --disable-plugins --disable-kvm
> >       MAKE_CHECK_ARGS: check check-tcg
> > +    # Force 'meson test' to run only one test at once, to
> > +    # see whether this reduces the flakiness of this CI job.
> > +    MESON_TESTTHREADS: 1
>
> Can't we simply add "-j1" to the MAKE_CHECK_ARGS line?
>
> According to the man-page of "make":
>
>   "If there is more than one -j option, the last one is effective."
>
> So adding a -j1 should override the previous setting, I think.

You would also be relying on the rune in mtest2make to
pick the last -j option in the list, but luckily I think
it already does that:

.mtestargs += $(subst -j,--num-processes , $(filter-out -j, $(lastword
-j1 $(filter -j%, $(MAKEFLAGS)))))

thanks
-- PMM

