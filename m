Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA40C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 16:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdXdZ-0004NF-MB; Mon, 12 Aug 2024 12:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdXdY-0004Ko-En
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 12:11:12 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdXdT-00071I-Bz
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 12:11:12 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5bb477e3a6dso4349472a12.0
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 09:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723479064; x=1724083864; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Hc2w2iG3UkYhVLoPpMdoBTiz2g2dRwmzU8ANaYcF6Xk=;
 b=UsGgzlgrLWOiz9CWoftDraoin5aDf2Zhfufp9K4qpeE7nhHvev2YeYbQWmhLiDqOMi
 2hq+n6jq9FzBrhPcS9XxPhnPzMaj5UUG0QUEpUBcwRowXZfCPfnLYNDvpbd6ykNgx1Uq
 GFNiNRjCfSgnS5okY5JzfhQdOkS1g7dFqeyLfWFFs5PBuhjK9efYQDI4kIx2fFDApa7z
 mNv2qFa63hsb1IFcj53BzBROEe/5i+tD+XaRqp5joLM2mftwvuMhXwDEEj70eD3THZ5m
 aPe1SxQukIgffUPl/tN4PX2gQAfPDt0y8KxBUrQTdoFbikb9fO4E37XUB4ZYTVES3Eze
 UFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723479064; x=1724083864;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hc2w2iG3UkYhVLoPpMdoBTiz2g2dRwmzU8ANaYcF6Xk=;
 b=vqmketwJ1t2NwJzWnii/iEp/SU+BEuQmgmz0hzBNzNwTbDBxAD6M3HqJpK/QSHQvM0
 8ysKryY5HuVW5VZ5u/RkW2GtNoEiCVrY+004e6Of0mNRjmvYeH7xAGUCHmvKT+Csf50N
 mnYCZg4FcGJp/Cumidy4F5/O9tUWUhUFQZzCrMJsS5WvdJQw/hSJPmkj8qe+zhRXay7J
 OgwX4dOhS6d67zvuMfCikCWs4kHYuPVVGuPmcknyOB2nhtbJ1+t6NB8tlZfHq0F0pGhv
 ptpd/nR1Xsr+X1XVjvWLoSQ/w9z1/z0W6XGK9/Q1pY3xprG3tfryuA67naoxMNKrJFTl
 /u0w==
X-Gm-Message-State: AOJu0Yz6IphTavS2gBcOZw6pLQwoNNv/geZODuShRjaTD/xKBu2G6OBT
 4tNFD+uKXM80/4BWoKZrAdbeG+ITgzj88Y4c2c0DMjkbYhrDS1uREY0joIJadN1zQU9ANvva6Lx
 eiO6gHuowFDjYjzfdP/0l0c5ZhpeAX7sIT8rc7g==
X-Google-Smtp-Source: AGHT+IHeat9FGu2yrOpeIJKQ2r/Iw6e1bIiFXGUhMt4NvKuKKf4PUsiYouEZk1AV8p5Euo3QiRIHOushkEDwroMtTRM=
X-Received: by 2002:a05:6402:51cd:b0:5af:37c0:b5bc with SMTP id
 4fb4d7f45d1cf-5bd44c6a631mr509650a12.28.1723479063876; Mon, 12 Aug 2024
 09:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240805201719.2345596-1-tavip@google.com>
In-Reply-To: <20240805201719.2345596-1-tavip@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Aug 2024 17:10:52 +0100
Message-ID: <CAFEAcA9tUW0DHHOuGJ4sUxu12JMLUMxqW=_9oUHKiiRTenZwKw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/23] NXP i.MX RT595,
 ARM SVD and device model unit tests
To: Octavian Purdila <tavip@google.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, stefanst@google.com, 
 pbonzini@redhat.com, alex.bennee@linaro.org, thuth@redhat.com, 
 marcandre.lureau@redhat.com, alistair@alistair23.me, berrange@redhat.com, 
 philmd@linaro.org, jsnow@redhat.com, crosa@redhat.com, bleal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 5 Aug 2024 at 21:17, Octavian Purdila <tavip@google.com> wrote:
> It also introduces unit tests for device models. To allow accessing
> registers from unit tests a system bus mock is created. The main
> advantage of unit tests for device models over QTest is that device
> models can be tested in isolation and do not require a full qemu
> machine.

On the other hand the disadvantage is that you need to add a
bunch of extra code to mock the interfaces that the device
connects to, and then you compile into the test binary a
subset of C files which weren't written with the expectation
that they got compiled into tests like that, so it feels a
bit brittle. The nice thing about qtest is that it doesn't
need you to do any of that -- you just run the QEMU machine
model and prod the devices it already has.

Do you have examples in this series of tests which you
were able to write with this unit test setup that you
wouldn't have been able to write equivalents of with the
qtest framework ?

thanks
-- PMM

