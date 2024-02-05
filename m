Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE8CC48291
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 10:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWweC-0004Ed-Ug; Mon, 05 Feb 2024 05:56:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rWwe8-0004Cm-7J
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 05:56:16 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rWwe5-0001v9-SB
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 05:56:15 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-55fcceb5f34so4054471a12.3
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 02:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707130571; x=1707735371; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aF6kLr+0j72xWrdGsklTzizqF4d9oC5Eu6iqYJgoggg=;
 b=UJ83khuJXROXKY6AFyOhu9Em02br4IfjiX/1F3P5oqJr4a/Sbc7zPvxe8IBjrbFcgP
 yg0gQ9m/ft73L36hXdkruLYGFaAtIsn2POv+rLlXMWgEtBjfdaMjSs1vmKr8iGBq3asz
 oOZqg0G7bFCJq+iD8tnb16WRdE38lqpHtJUoxG/KfkOe0X0z0k8LMFnWvF80wqIJePc0
 s9rKTxWEG9CnDoax+dWZDDL0P8Dp+vpQa1gadNafPO6G4W2FZ0ziiFw1vwRP3Wo8JdVG
 vIeUimlayGBzCFq+Ab52URYPbJ/2xwrBwTe3hudf7I9vPS1LAt9l8EG6pxwo47QE/9Sy
 70Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707130571; x=1707735371;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aF6kLr+0j72xWrdGsklTzizqF4d9oC5Eu6iqYJgoggg=;
 b=ItJulAPW2urXMaO3NU7+sEYF3PHAPumr0dMYHQ3Qxn/ifaeVmTrFjAwFMM9lCXoHRe
 NQsC2UjCIlVH3kavD0b32CwjqdSk0R6XdI+svbri+I7gzQ1/RuZ1GDnkVy3E4k/ZeI0G
 9DPdid6BFjFC1vPeJihzaNRfRznGdckCHTFbbgrPlPhf7DfMTDh/YVkwyVAIzEtr/5mS
 KTw8xV+puCkEiAM+TQjWbHoWtsqGUPFGcNJOWbK3p6tAz3pHE0aK9U6yhU3ivn/g6BRc
 7sC6MbMH0QVyFCbkryLAKQg8130lscXlj/x7ZCzRjyUiPpvCuzrB7rzTbOBItRdNQ2nv
 Epww==
X-Gm-Message-State: AOJu0YzvEyeuhk+BVzn/85JOoi1Xxnr76k6NtU8WTcjf7nk1MC3gUimk
 1FmBP07sDx+xw9XoDauTG8p137uh1yB2gEq+6zNK7myGs49HYoTE2tpN53rUMWJAUskGs8L4uLd
 NG6nUne9Fe1+C+z0RHw3xWWPaJFiEoBNyYwTkmh2iF1gq4y3H
X-Google-Smtp-Source: AGHT+IEfpTnPz1ibbeXle4QBpLrPOZd5RVOXXzekJqkRdnDaPFfNXyevb3yLP+Y7j9zg0fuZUy5ndgcwIpnb5rnGaCY=
X-Received: by 2002:aa7:d0c3:0:b0:55f:e574:4ea6 with SMTP id
 u3-20020aa7d0c3000000b0055fe5744ea6mr3939220edo.2.1707130571271; Mon, 05 Feb
 2024 02:56:11 -0800 (PST)
MIME-Version: 1.0
References: <20240201164412.785520-1-dwmw2@infradead.org>
 <CAFEAcA9-e=hzN62vkq-P575yMvjqmm1sNwNMswUDnqj1gCRmOA@mail.gmail.com>
 <4e86dd4daebb3c15d1585ff8d7316f61f122d827.camel@infradead.org>
 <CAFEAcA-Xbjpg8NUWnxq7Mkz5b+aUFUTsmZspBqWQ3N9Q76xhYQ@mail.gmail.com>
 <b69aabcd-bbfa-4ed1-9037-00933a756cda@redhat.com>
 <5b188560-d0f4-43c1-8dfc-39ca8420b4c6@redhat.com>
In-Reply-To: <5b188560-d0f4-43c1-8dfc-39ca8420b4c6@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Feb 2024 10:55:59 +0000
Message-ID: <CAFEAcA8SuMX1FozbEWa=_F-PNLAKdd+RWPdmvQD31m+WU-MsNw@mail.gmail.com>
Subject: Re: [PULL 00/47] nic-config.for-upstream queue
To: Thomas Huth <thuth@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 5 Feb 2024 at 10:11, Thomas Huth <thuth@redhat.com> wrote:
>
> On 05/02/2024 07.56, Thomas Huth wrote:
> > On 02/02/2024 16.40, Peter Maydell wrote:
> >> On Fri, 2 Feb 2024 at 15:36, David Woodhouse <dwmw2@infradead.org> wrote:
> >>>
> >>> On Fri, 2024-02-02 at 15:32 +0000, Peter Maydell wrote:
> >>>>
> >>>> This fails "make check' because some of the qom-test and
> >>>> test-hmp checks fail when the QEMU binary segfaults.
> >>>>
> >>>> https://gitlab.com/qemu-project/qemu/-/jobs/6084552256
> >>>> https://gitlab.com/qemu-project/qemu/-/jobs/6084044180
> >>>
> >>> Thanks.  Any idea why that didn't show up in my own pipeline?
> >>> https://gitlab.com/dwmw2/qemu/-/pipelines/1160949234
> >>
> >> I think because the failing runners are the aarch64 and
> >> s390 host ones, which we don't let run for anything
> >> except real merge-pullreq test runs because they're
> >> limited resource. I guess that perhaps we have at some point
> >> said "we don't need to run all the guest architectures
> >> on all jobs"
> >
> > It's rather "we cannot run all the guest architectures on all jobs due to
> > time constraints"
>
> Ah, wait, but we should still run at least "make check" for each target
> architecture...

Yes, this is what I mean -- it's OK to have the target
architecture checks split up between different CI jobs
as long as between the jobs we cover them all, but it's
not so good to be relying on the non-x86 host jobs to
provide part of the coverage.

-- PMM

