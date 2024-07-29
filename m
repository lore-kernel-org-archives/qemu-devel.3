Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019F6C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 14:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYQwm-00039j-7U; Mon, 29 Jul 2024 10:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sYQwj-0002zA-Io
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:01:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sYQwh-0000vK-1O
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722261709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C8mElyKMtrGH2TgwBOcoDNaw5OVsHDgslzIoNoUr5ZI=;
 b=I9+8ANGZ2b2deDiwyYOxQfi0SWnsbJQKjFmb/MAjFkGrXZ3ar7W/3NT2XDpF6MHtO3RlPT
 asROdj8SKcdQv1R1TRORyybpP8+2ZAQW9bzRn6/dJsr33CuRCqX9aOWJahZc+IctroNUSB
 KVuR3ODflEGF8ykr+Yx2XnfP9BGaiY0=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-CyqAtG89MCqPwA2vRamhzQ-1; Mon, 29 Jul 2024 10:01:46 -0400
X-MC-Unique: CyqAtG89MCqPwA2vRamhzQ-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-650b621f4cdso56188257b3.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 07:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722261705; x=1722866505;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C8mElyKMtrGH2TgwBOcoDNaw5OVsHDgslzIoNoUr5ZI=;
 b=TVjJgZhRyKmp64XHklvS+DG/iJ1t1iKRTBijlkZjB+3KzAv879LpKkf9l9hW5Clqo0
 IgsX/d7Ffx4nImi+4ew4k7a8RKeHsoQ+d6HJptPUixc1Ee4bprP9QPUfNIIubQi2iZee
 M9ORl3brWB0xL2n/HSm8PiZUSCohvc9ckk2ysFAcF/M7iAP5usLvEZU61OLMfFnwK91F
 f8QL5JkYZvKdZAupDf3x1RSrGktH9dXh/9p3yax3G9MJBDYt2eBDKdJDEaAQfqz5J25p
 1pXrICd2n2rjmYe1AxAvGO5B/XbghJbv9hjKFBC48bxppFof3llF4WVdzxxVMucBkYKi
 6ozg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSK/WGnVGV0jJs+Vx+YToeMC1p5f/w7HKRkA37jWOlxxlOsWDanrMXR9yMg4hGSBYQiP4EB4g56NOqfIEbRxqbHDAwnlU=
X-Gm-Message-State: AOJu0YxmuSWkIawZzzXqX22Wykj6hqSr0O9ComjKSbKP5UtKFSJ/Naf6
 Dscw65Fe/PtOscajG4MJ/cONAxIzIcqDHcHEpiqql9BZT0vZY1gC/K1zqdevCUZibAwmBOHMgC+
 hWa4o9Y7EhHz15Gtyi424D91X0J/WRx25PqTS83FKeg0Gb1si30z0BHW7WswMCkdAvpjLuKG3xB
 Dxub8sXzZOcbYza+MR2/ykI7ThOBk=
X-Received: by 2002:a05:690c:63c6:b0:65f:8218:8b2f with SMTP id
 00721157ae682-67a0a518ef3mr90593137b3.43.1722261705384; 
 Mon, 29 Jul 2024 07:01:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpNWhSmUWERxC4ojScZe/iCegkTO2GlUVbBPtKDHwqC2Ae5YrMVtQlgrxPr53i18ZCqW2iUgWATp1JHrIQ46k=
X-Received: by 2002:a05:690c:63c6:b0:65f:8218:8b2f with SMTP id
 00721157ae682-67a0a518ef3mr90592737b3.43.1722261705041; Mon, 29 Jul 2024
 07:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240716112614.1755692-1-thuth@redhat.com>
 <CA+bd_6LbLbR5hEqUhn5Vutf1k5HsB4Zg=qYF-Tq_pOrxDeWo1A@mail.gmail.com>
 <ZqeOlkYnzSzwNYBL@redhat.com>
In-Reply-To: <ZqeOlkYnzSzwNYBL@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Date: Mon, 29 Jul 2024 10:01:30 -0400
Message-ID: <CA+bd_6J2Et=7g=3tUrSSf7ZwMQO4BrJ3bTKLEjye3WU2resXjw@mail.gmail.com>
Subject: Re: [PATCH v1 00/11] Convert avocado tests to normal Python unittests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jul 29, 2024 at 8:44=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Thu, Jul 25, 2024 at 10:21:54AM -0400, Cleber Rosa wrote:
> > On Tue, Jul 16, 2024 at 7:28=E2=80=AFAM Thomas Huth <thuth@redhat.com> =
wrote:
> > > There have been several attempts to update the test suite in QEMU
> > > to a newer version of Avocado, but so far no attempt has successfully
> > > been merged yet.
> > >
> >
> > So, we've seen in the past an attempt to update Avocado from 88.1 to a
> > regular release, and the troubles it caused, including a revert.  My
> > take was that a LTS version should be used, but during this time,
> > Avocado experienced a rewrite and having it replacing the old
> > implementation in a production level project such as QEMU was tricky.
>
> IMHO the problems with updating avocado in QEMU are a sign that we're
> suffering from excess complexity, as it shouldn't be this difficult to
> update the test harness. That we need to stick on an LTS release to
> protect us from further instability further suggests that we would
> benefit from a much simpler solution here.
>

Hi Daniel,

Some other projects using Avocado have picked different, non-LTS
versions, to use as their pinned versions.  The consequences of using
rolling releases versus LTS-like releases is not something specific to
one software package IMO.  The suggestion to use LTS was to minimize
the impact on users writing and running tests, while allowing for only
needed fixes or very important features (say supporting a new Python
version) to be addressed.

> > > Additionally, the whole "make check" test suite in QEMU is using the
> > > meson test runner nowadays, so running the python-based tests via the
> > > Avocodo test runner looks and feels quite like an oddball, requiring
> > > the users to deal with the knowledge of multiple test runners in
> > > parallel (e.g. the timeout settings work completely differently).
> > >
> >
> > Now I believe we can be very much in sync here.  I've thought for a
> > while that there's no reason for Avocado to cooperate or be compatible
> > with Meson.  There's no reason why users can't simply pick how the
> > test gets run.  In fact, with the new Avocado architecture, you don't
> > even need to run "avocado" to run an "avocado-instrumented" test.  You
> > could pretty much run "avocado-runner-avocado-instrumented" with the
> > right parameters through Meson.
>
> Looking back to when we introduced avocado, we still had our original
> home grown build system, and multiple different ways to run integrate
> testing betwen our unit tests / qtests and block iotests. Adding
> avocado to the mix introduced a third way to run tests. All round it
> was rather a mess of inconsistent approaches to testing, but that was
> a fact of life with our old home grown build/test process.
>

Agreed.

> Today we have adopted a much more standardized build system via meson.
> While we do still have the block iotests harness, we now expose every
> test to meson individually to reduce what the intermediate harness
> needs to be involved in doing. Thomas' series here is bringing the same
> simplified integration to our functional tests, such that each functional
> test is known to meson individually. Overall we'll now have a consistent
> approach to integrating tests into meson, without intermediate harnesses
> adding their own logic.
>
> I think this will make it easier for QEMU maintainers to understand how
> the tests are working, and make it easier to maintain them and troublesho=
ot
> failures.
>

I think this is a very good way forward.  I don't think anything
(simple tests here) should depend on what they don't need to depend
on.

> So overall I'm not seeing a compelling reason for us to offer users a
> choice between meson & avocado how they run tests. Such choice is a maint
> burden over the long term, as we need to validate that both options keep
> working. Focusing on a single option reduces the complexity and maint
> work and gives us more flexiblity to evolve the code over time.
>
>

If meson is capable of doing all that can be done right now, then I
believe you're right.  No reason to use duplicate software.  Now, If
you mean that having "single option" may imply duplicating code that
already exists and is maintained elsewhere, into the QEMU repo, then
you're wrong.  This can be easily judged by how easy it is to convert
all current tests and their features (timeout, download management,
etc).

Another level of judgement that I believe would be helpful to the
decision making process here is how this impacts growing the test
coverage.  Tests that manipulate both QEMU and the guest are still
very very simple compared to what can be found on what I'll call "real
life integration testing" of QEMU (read Avocado-VT like tests). But
they present a glimpse of the problem. Having such tests requires a
good amount of code to either be used from a project/repo that
addresses that specifically, or be duplicated inside QEMU.

> > > So instead of trying to update the python-based test suite in QEMU
> > > to a newer version of Avocado, we should maybe try to better integrat=
e
> > > it with the meson test runner instead. Indeed most tests work quite
> > > nicely without the Avocado framework already, as you can see with
> > > this patch series - it does not convert all tests, just a subset so
> > > far, but this already proves that many tests only need small modifi-
> > > cations to work without Avocado.
> > >
> > > Only tests that use the LinuxTest / LinuxDistro and LinuxSSHMixIn
> > > classes (e.g. based on cloud-init images or using SSH) really depend
> > > on the Avocado framework, so we'd need a solution for those if we
> > > want to continue using them. One solution might be to simply use the
> > > required functions from avocado.utils for these tests, and still run
> > > them via the meson test runner instead, but that needs some further
> > > investigation that will be done later.
> > >
> >
> > So, I believe this type of higher level testing is something that
> > needs to remain, and even grow.  Speaking for Red Hat, I see the
> > movement of QE contributing more Avocado-VT style tests into QEMU
> > itself.  This means way more libraries and features that go into a
> > common set of utilities and features (more on that later) than it
> > currently exists in avocado.utils.
>
> The series here is showing how simple it is to adapt our existing
> tests to the new execution approach, so shouldn't have a significant
> impact on ability of people to contribute futher tests in future.
>

I am on the side of the unified execution approach.  But, will it
really be simple to convert all tests?  "Real life integration" tests
too?  I would love to see that, but I can't see how that can be done
without the woes mentioned before (duplicating other code or limiting
the further toolset and capabilities of test writers).

Best regards,
- Cleber.


