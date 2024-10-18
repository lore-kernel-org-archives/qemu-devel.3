Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFD8D2FFE0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 09:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1ja0-0004H2-3u; Fri, 18 Oct 2024 05:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1jZf-000496-Ho
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:47:15 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1jZd-0002G4-0u
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:47:10 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c935d99dc5so2047437a12.1
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 02:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729244827; x=1729849627; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mVB74vrHQENJH6UT6acezh0cU5co5ZJhROpwtq8lFf0=;
 b=YiOhMJZB+My397Big/cbFUh8hbGJHnvnbxEU8bifWjh2oXAILOBEJT5KdlGwS3EIHH
 KSxcMSmHoyjIdDGni3r6gGwJR2xiI6Hj1UiL4KVWF0Xw7Z+rlmQrQo3EcEbZRhMIKBgB
 Q9Ob2wlLF+UVLtjFfe6e3cC8kn9Aw1B59L1yZkivBQ0n5KBA0eiBJQP09nPCe/BFbYjJ
 t2G7766arsswtXclWQ32tbYI4PRuy0vWbsdUF3lSReXmiviIr/gpSwceBksUpcFQDmWE
 wTYPjpIZntAKYe1HLqMnr6a4sIuiy60BHUppniTuu9VB2S8U5nqCiqIr31GhMaRIx7jp
 sUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729244827; x=1729849627;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mVB74vrHQENJH6UT6acezh0cU5co5ZJhROpwtq8lFf0=;
 b=ucuTZLTDWFNe4ducq+VuL6s9+dbSF/g6w25gG/4R58GCJ2LaANopOSerBD1NX4H0nX
 YWrzdvPr+v2dPvul9SQHlwtmNI1sBqf0Av/1UxEo03VEYXFEihO8VTNVbfX+eKE5YcOH
 fM71HltENWPpXAbue+9TLtj5oGfx6Sun0EOgGufXpNkxe9hnNktVDOMiudtNfC5wgQfp
 iYMhkLUvEYWKcuo3XiYheqiHWh+mQV3fISCCBs+Dbuc/uWZzD278718GEdixdw1lGXiH
 tzwrkqpXm8sAtgGVh62hYYTsdHblXdSYEmtJzCUZKSVf1u1jq/Abdvn8WDAXsKYgoTwN
 gyjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVI4X8Yu/4AfUEmf44DuK4WHmWp+TUpupBZ3yHa9V7G2qT+EEcGUBCNw0V88NrRN79zItbCApe2mbtQ@nongnu.org
X-Gm-Message-State: AOJu0YxYW31QsgkCcMTKi8gXRIbEoq+AfDRYqODtE5kqJ0E4aUjxRLcj
 eL7/ExjvbVjS2Au9yZRV5WuSaq3fTue1pGcK+EnySRsSPJAKlBCUUsFh59F58Ze4Gue7Dj5GiAg
 sNgLdZV4d8JR27SqK3embHbqh1uU+GPpk0cj2xA==
X-Google-Smtp-Source: AGHT+IEu8K6WS+0vvqeSuuvP1R3H+/YqPQaUqZEXLWimD9DxKR0DUFuDutn+nGnWXuMy49BAP4GC+AF2sn4GC0n6/+o=
X-Received: by 2002:a05:6402:5241:b0:5c9:16e2:4db1 with SMTP id
 4fb4d7f45d1cf-5ca0ac620afmr1294912a12.8.1729244826879; Fri, 18 Oct 2024
 02:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <20241017143211.17771-1-farosas@suse.de>
 <20241017143211.17771-5-farosas@suse.de>
 <ZxEl4zYgHLoLeHCT@redhat.com> <87r08e3d74.fsf@suse.de>
 <ZxIj694WqXwwMRIY@redhat.com>
In-Reply-To: <ZxIj694WqXwwMRIY@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Oct 2024 10:46:55 +0100
Message-ID: <CAFEAcA8XCBrbqGDesL+5su-2Bk_YR1iQ6_X_j9tJZmNK1Kw=pQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] ci: Add check-migration-quick to the clang job
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Fri, 18 Oct 2024 at 10:01, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Thu, Oct 17, 2024 at 01:29:35PM -0300, Fabiano Rosas wrote:
> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
> >
> > > On Thu, Oct 17, 2024 at 11:32:11AM -0300, Fabiano Rosas wrote:
> > >> Recent changes to how we invoke the migration tests have
> > >> (intentionally) caused them to not be part of the check-qtest target
> > >> anymore. Add the check-migration-quick target so we don't lose
> > >> migration code testing in this job.
> > >
> > > But 'check-migration-quick' is only the subset of migration tests,
> > > 'check-migration' is all of the migration tests. So surely this is
> > > a massive regressions in covage in CI pipelines.
> >
> > I'm not sure it is. There are tests there already for all the major
> > parts of the code: precopy, postcopy, multifd, socket. Besides, we can
> > tweak migration-quick to cover spots where we think we're losing
> > coverage.
>
> Each of the tests in migration-test  were added for a good reason,
> generally to address testing gaps where we had functional regressions
> in the past. I don't think its a good idea to stop running such tests
> in CI as gating on new contributions. Any time we've had optional
> tests in QEMU, we've seen repeated regressions in the area in question.
>
> > Since our CI offers nothing in terms of reproducibility or
> > debuggability, I don't think it's productive to have an increasing
> > amount of tests running in CI if that means we'll be dealing with
> > timeouts and intermittent crashes constantly.
>
> Test reliability is a different thing. If a particular test is
> flaky, it needs to either be fixed or disabled. Splitting into
> a fast & slow grouping doesn't address reliability, just hides
> the problem from view.

A lot of the current reliability issue is timeouts -- sometimes
our CI runners just run really slow (I have seen an example where
between a normal and a slow run on the same commit both the
compile and test times were 10x different...) So any test
that is not a fast-to-complete is much much more likely to
hit its timeout if the runner is running slowly. When I am
doing CI testing for merges "migration test timed out again"
is really really common.

> > No disagreement here. But then I'm going to need advice on what to do
> > when other maintainers ask us to stop writing migration tests because
> > they take too long. I cannot send contributors away nor merge code
> > without tests.
>
> In general, I think it is unreasonable for other maintainers to
> tell us to stop adding test coverage for migration, and would
> push back against such a request.

We do not have infinite CI resources, unfortunately. Migration
is competing with everything else for time on CI. You have to
find a balance between "what do we run every time" and "what
do we only run when specifically testing a migration pullreq".
Similarly, there's a lot of iotests but we don't run all of them
for every block backend for every CI job via "make check".

Long test times for tests run under "make check" are also bad
for individual developers -- if I'm running "make check" to
test a target/arm change I've made I don't really want that
to then spend 15 minutes testing the migration code that
I haven't touched and that is vanishingly unlikely to be
affected by my patches.

thanks
-- PMM

