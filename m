Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB66D49219
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 12:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD1CG-0000UT-D4; Mon, 18 Nov 2024 07:49:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tD1CA-0008TF-CO
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:49:35 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tD1C8-0005Vw-Dz
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:49:33 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5cfaeed515bso2341345a12.1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 04:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731934170; x=1732538970; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5tuYhTk5xkX+QAPB8w45QhCG/O6PqvROoWvuT7r7h18=;
 b=K/+qv7TFbptJLUXMEFmCbcro1IfAaVOw81Y+oTqTUu1CsrXsPi7vTQbFgmbJBiD88L
 JwdFsgAPpZ/I/2qQIRUhfAoyhNeCyOD+KXfPCoc0D1VqAXBE1OMHN8Uld/YJR2FHgw9a
 4UR5aQO3BeanC9EXsRuUy1+vVQ0eUsCrVbJfzHSYICqJayhrNkd8Sikm+LzwaNA0Sl4W
 BXorodpoCosTMtCrkHwI6yjatEOcIRpZZJKM5E7+ZNVbbkTUVc4wFQutt1x5L8hqS2Gy
 /7ZkYZslrQGyXAhl4ZuOSGnJIOPrFL9abaSNuCU0/+dUQqA0OEcI8jKhmUvwnQL5sVy4
 Z5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731934170; x=1732538970;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5tuYhTk5xkX+QAPB8w45QhCG/O6PqvROoWvuT7r7h18=;
 b=L5HLafT/Kkup75fsWMZyJ6q27Zrud7VOqUxBEaAsfQpSNCsVOj/qP+xPGOXRSbWLi6
 fI7mvXNn4Mbu+dn5nI0tcSXsQ3go3VuNm8xQW4k+QQjB13NhbZ7JOUllP57KaxNNJfvg
 K4ANrBmQ+wePjRwpEBctFyFnFEW/WggWPFa9to8KPVwHleob+8JiUj/LKvba3A1i7W/a
 qKJy1k3WjPBld1BPi4hm1hEoccuIN1k/88yU60kUnSiBxmuWVyahiog3SPXl9kxTYVcH
 sziMy3pKLQql/bI815BWNXxWwAhMAK3JKzcBEW/zMZZCHiF/tofl2uuIAyTBQ33PhN52
 tq2g==
X-Gm-Message-State: AOJu0Yx7XtY3/bJiUGhU5SekPmLsG+Vr197ESfQwItObrh2r49A2TeNx
 fRpyDjN0AMDgRetdZ6eeF1ezQZhHm1slc/O4qeSwOVdegowdwwUtcGQqjgd3fCw5DAfCY9Jn6mN
 Fl1i/VBowLdcPHR5zsGIqi2hbLfBDzGmzxMk2HQ==
X-Google-Smtp-Source: AGHT+IEWTd8szsynmIYLrxnBZzSZXsWpg88XlIlNddT0FMdyVWXiIkZaLwAnvzO+paIS/GuDL87W3IwuY8ncs2UM7vo=
X-Received: by 2002:a05:6402:5206:b0:5cf:6093:9377 with SMTP id
 4fb4d7f45d1cf-5cf8fd32361mr8960012a12.23.1731934170628; Mon, 18 Nov 2024
 04:49:30 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA8hHMj0718haB_uZhE-LQF4W9PYrL-na0iznp4ueDsq7g@mail.gmail.com>
 <15635bd3-97fa-4c11-9427-c615d1b57dd1@redhat.com>
In-Reply-To: <15635bd3-97fa-4c11-9427-c615d1b57dd1@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2024 12:49:19 +0000
Message-ID: <CAFEAcA91Kb4foyXJ3hcbqKXkHKae12yO=HcFYSUCFKS0AEG+oQ@mail.gmail.com>
Subject: Re: tests/functional is eating disk space
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Mon, 18 Nov 2024 at 12:10, Thomas Huth <thuth@redhat.com> wrote:
>
> On 18/11/2024 11.57, Peter Maydell wrote:
> > I just ran out of disk space on my dev machine, because:
> >
> > $ du -h build/clang/tests/functional/
> > [...]
> > 11G     build/clang/tests/functional/
>
> That's indeed a lot. I only got 6.9G in my build tree for all targets ... I
> guess there are some stale files lying around, so as a temporary mitigation,
> just try to delete that folder (it should get recreated the next time you
> run the tests).
>
> > The new functional tests seem to be eating disk space.
> >
> > Even the build tree I have that's just arm targets is 7.1GB.
> >
> > Could you have a look at what's happening here?
>
> I am aware of the problem and got it on my TODO list already... I think we
> best should set the "workdir" to a temporary folder that we can remove once
> the test has finished, that will automatically delete all binary assets that
> the test created during its runtime.

Can we provide some kind of option for "keep the temporary
data" too? That's sometimes handy when you want to manually
run the QEMU command the test used as part of debugging
a failing test.

thanks
-- PMM

