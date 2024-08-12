Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF5C2C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 18:40:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdZxm-0001dr-Pj; Mon, 12 Aug 2024 14:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1sdZxj-0001cl-0K
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 14:40:11 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1sdZxh-0008KV-2T
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 14:40:10 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3684e8220f9so2628297f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 11:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1723488007; x=1724092807; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rF418gmjx4SjooVpfdgVEelVbtXR1QDkywT9usen5X4=;
 b=N0Z0JkD2zHLolCCMqKvK1SNdo7jLqIg9v0cFxG0dGVUC4dulNOphSXrFNxZIp6laqU
 XspkBQjsK3UOz7RZzRZ7f+4owVZeQ2j98x1ZnnQEKuoqqZQSax3WWjwYcGb6US4nihr4
 E4qkFwWSMuN0W62RM/Flhg7WOoSV/xIxoHVit8FtzSOEcsG6lG7Jh0vQxRcAhEVZTUQo
 ZKX0y5dNMKjN+4BprsRk+0Ggl09UWhaxdVXqdSDtp0hytB0MQAUGDfWeNxqYPcQOhxBb
 vXZD1M0sW4newh5MvtgpKs3/bEbUzMICnbJ3vMFsqUqhUHcgqJPTEfNfTdk8XWQh+TcH
 wMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723488007; x=1724092807;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rF418gmjx4SjooVpfdgVEelVbtXR1QDkywT9usen5X4=;
 b=alxCFvKitTkpZ7bNH7dXTntvW/QXpYwN52TzFd7pqkNjxWizEaGjaws6KbqbXN+JoX
 37d0QIGHP2DKYrU/SPFEZ3EqCFElFhwqhokTKRkt6SrgakY6nVXmdLObKHOnF+v6zykc
 l2z3h/cZ/Qy+wk5D3rhntZ9CFAhhaaiNJAG3qn1PfwMj0brEQmc9aOHrPNKtlmr8bv/O
 dNZzBEQPOe5u2FcRYd4Pb9NeFozMhMojU1tQnIpO1A8T9Nh9RjTboFGGZ0obQmdAT2KS
 Sc06EKhJZgWYrlA4zAyU+iOh8gqUS3V08yBfhGvyE8069vgQELHCvkHvfYqsSHnCKf6K
 QgxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwn6DlCbo5/GBkqKjm87rkPXbFsYf4/UstZI4tVdWu5ALaYogeSChFSjnNd2Nd4+CxHC70pZ8UYUXX7qsTokdK3yP2JPo=
X-Gm-Message-State: AOJu0YzumElhLbCEMKwCxYdCOEpl982FKY0bVQriABLbu4L6dwAh6qJn
 1l0c8vKshLT9QU95jIAZgBwH2+HZw/R54Z0i3oxKTm1soX/smWtNVk9PVpTBNWzD7RzsEQGqib6
 5wb2ln8bTvMnejJ+SIpLaKOAnLHLwhVsyETMV
X-Google-Smtp-Source: AGHT+IHT2yYHFMAIKDS2jK6y/5ndIwLr6HSXC8D7VCqXXv1C6p42RpeONg5iOr7ZHiRSAXlBYgT+RAYnxHNsgG+S9Cs=
X-Received: by 2002:adf:ef0f:0:b0:368:3562:7c76 with SMTP id
 ffacd0b85a97d-3716e42c619mr397781f8f.3.1723488006702; Mon, 12 Aug 2024
 11:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240805201719.2345596-1-tavip@google.com>
 <CAFEAcA9tUW0DHHOuGJ4sUxu12JMLUMxqW=_9oUHKiiRTenZwKw@mail.gmail.com>
 <Zro207XTHFILvRoe@redhat.com>
In-Reply-To: <Zro207XTHFILvRoe@redhat.com>
From: Octavian Purdila <tavip@google.com>
Date: Mon, 12 Aug 2024 11:39:55 -0700
Message-ID: <CAGWr4cSndr-mQ34cp5-AJiqFQxq522J2K-7W3jAGyUdLARLg8Q@mail.gmail.com>
Subject: Re: [RFC PATCH 00/23] NXP i.MX RT595,
 ARM SVD and device model unit tests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, 
 stefanst@google.com, pbonzini@redhat.com, alex.bennee@linaro.org, 
 thuth@redhat.com, marcandre.lureau@redhat.com, alistair@alistair23.me, 
 philmd@linaro.org, jsnow@redhat.com, crosa@redhat.com, bleal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=tavip@google.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Mon, Aug 12, 2024 at 9:22=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Mon, Aug 12, 2024 at 05:10:52PM +0100, Peter Maydell wrote:
> > On Mon, 5 Aug 2024 at 21:17, Octavian Purdila <tavip@google.com> wrote:
> > > It also introduces unit tests for device models. To allow accessing
> > > registers from unit tests a system bus mock is created. The main
> > > advantage of unit tests for device models over QTest is that device
> > > models can be tested in isolation and do not require a full qemu
> > > machine.
> >
> > On the other hand the disadvantage is that you need to add a
> > bunch of extra code to mock the interfaces that the device
> > connects to, and then you compile into the test binary a
> > subset of C files which weren't written with the expectation
> > that they got compiled into tests like that, so it feels a
> > bit brittle. The nice thing about qtest is that it doesn't
> > need you to do any of that -- you just run the QEMU machine
> > model and prod the devices it already has.
>
> Yep, mocking often ends up being rather a double-edged sword.
> You can do some really powerful things with it, and in particular
> it can enable you test scenarios / code paths that are hard or
> impractical to exercise with regular functional tests where fault
> injection is difficult/impossible.
>
> The cost of this though is that the mocks can pose a significant
> ongoing maint burden on anyone who refactors code in future, as
> the mocks need to evolve in lockstep with the code refactoring.
>
> 12 months down the line, it can be hard for another maintainer
> to understand the full purpose of the mocks & thus even harder
> to know what todo as they refactor the code. The future burden
> of mocks rarely falls on the person who creates them in the
> first place.
>

I agree that there are potentially maintenance issues. For what is
worth, AFAIR, we only ran into one breaking change in about 3 years
for which we used this approach which was also simple to fix (gpio was
removed from hwcore so we had to pull in gpio.c directly).

> > Do you have examples in this series of tests which you
> > were able to write with this unit test setup that you
> > wouldn't have been able to write equivalents of with the
> > qtest framework ?
>

No, I think all of the tests in the patch set could be written in qtest.

