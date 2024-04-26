Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCB9C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 12:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0Kj2-0003tb-5d; Fri, 26 Apr 2024 08:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s0Kix-0003li-Ew
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 08:30:44 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s0Kiv-0006SY-Iz
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 08:30:43 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5724f26b8c9so1865222a12.1
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 05:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714134640; x=1714739440; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tmUgqitCbvsapLeYtJfIYcC0IMz2AGFpKyZAxQ4EwQQ=;
 b=o39c0bBSOIe9NhWE0rgW6wT1W+uh/Kqar8IFaz5lklK4ZVchdgw5Hg2am7QF6yDjo1
 VQV/jTn5qOl5fYXRx83XgMB9V8LkiTi9Hbbf1wgoneRnGqXS754GMvmiCQsXfsJCm0Lf
 elXf7xDlSxNp9JkUpDqRTK5y4F0oVuDhQ0JpuZHULYScmsIFYL8kCjglAOT7QB3V5QJU
 XHPToAZEG9JtiGWq32v4wRXldHsrTcGiyLxWUhZ8EGBBMwBiFoQ4Lfok7FUYnO9uNHLO
 ziGXDI8QH3CI7wSsMoxri6W1MIK0CQUP+wpijRVRVJdquSQxyLBe1l028iJr0HEjJSMO
 KtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714134640; x=1714739440;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tmUgqitCbvsapLeYtJfIYcC0IMz2AGFpKyZAxQ4EwQQ=;
 b=pw7cGzMgjNXZMRAZwN8JAX/ynfYLi9EV+bmiAZZA+a4d4QX3qtyMSqnl9R4snc+7sU
 AO77asQNSG+6hOREbrpTi1fvmvUJBjjPb+50O7Oj2JY050uH4i6JcjCCNPTd/G2KLpcu
 hqNwtdCQiwbzCLm+BNwM0lnZY2w1DSIVbcrkwj38l3zNouLkoVPMm2QmdhmzldeSWbtX
 SrHYUR8bj+6Cm1Q59sPBOHr9BhqXQoHxekVI38I8oPsHq3qVK13unD1DzFWEn+vRGiLd
 halsuCUxcvXwVYRgXjEtGgWzp/XrXG1wwDtDNblxCtdWAkHHAXhdJb4HnW+zn12xw6gt
 J1Ww==
X-Gm-Message-State: AOJu0YzhG/Qp3JzoAxyzQ6WHBNwrqeIMdlg9r4P3iW0M5iSfJ8kaIySK
 +RhWxL58wWX0E+6H+BH/RG9har8BVlvyV47b4wY3Yy+26TVEy7NeKaT2kPOT4z/iSkMKHCo5af2
 MfymZG1X7jhDTRdV/z+P3UK5vGGct31Uck/glNg==
X-Google-Smtp-Source: AGHT+IEh1daGaXJH+MmqFMEyXIKC4uqbl3P5f6YLFeAJJUuHs8cmyBtL1eKJzNnXIcQn8UqU1wYtLwTqNCe8tLcAiSY=
X-Received: by 2002:a50:cd19:0:b0:56d:fc50:ec50 with SMTP id
 z25-20020a50cd19000000b0056dfc50ec50mr2282124edi.13.1714134639647; Fri, 26
 Apr 2024 05:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240426113742.654748-1-thuth@redhat.com>
In-Reply-To: <20240426113742.654748-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Apr 2024 13:30:28 +0100
Message-ID: <CAFEAcA_gEyBXecGXP3x=uLJQTaE9=5Ubf0bGeSALskTfFoNQ6g@mail.gmail.com>
Subject: Re: [PATCH] .gitlab-ci.d/cirrus: Remove the netbsd and openbsd jobs
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 26 Apr 2024 at 12:38, Thomas Huth <thuth@redhat.com> wrote:
>
> During the past months, the netbsd and openbsd jobs in the Cirrus-CI
> were broken most of the time - the setup to run a BSD in KVM on Cirrus-CI
> from gitlab via the cirrus-run script was very fragile, and since the
> jobs were not run by default, it used to bitrot very fast.
>
> Now Cirrus-CI also introduce a limit on the amount of free CI minutes
> that you get there, so it is not appealing at all anymore to run
> these BSDs in this setup - it's better to run the checks locally via
> "make vm-build-openbsd" and "make vm-build-netbsd" instead. Thus let's
> remove these CI jobs now.

So what's the plan to keep BSD CI coverage? This seems
like a step backwards towards "the person handling the
pullreq merges has to do some local private ad-hoc testing
too" :-(

thanks
-- PMM

