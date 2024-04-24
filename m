Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 258F2C10F15
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 17:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzg7Y-0001zn-I3; Wed, 24 Apr 2024 13:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rzg7S-0001yh-0H
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:09:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rzg7P-0005MR-E5
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713978554;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vA8oK5CxRJp84hszs5cQ2U/0pZiazwsxUysXKgZRiso=;
 b=fPQnZLJnImuP5b0oHenUa0/UXg74ue31hTDJgcxVI4SKGQWsHkX6tcWTXmMquEWGpD3Wh3
 dVbSZyLrl1P8SUcg7IvQ+Yc8gPFHN3MikNAY3lN6y3bYKh2y34I19EkXN7dg7R17AngBns
 kiHvS05dHQisDOTimv04s4gHGvc2AWY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-7zxelKadNzukvhKJU7qEvQ-1; Wed,
 24 Apr 2024 13:09:10 -0400
X-MC-Unique: 7zxelKadNzukvhKJU7qEvQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 397B829AC021;
 Wed, 24 Apr 2024 17:09:10 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E68CEC682;
 Wed, 24 Apr 2024 17:09:08 +0000 (UTC)
Date: Wed, 24 Apr 2024 18:09:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Weil <sw@weilnetz.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Timeouts in CI jobs (was: cross-i686-tci CI job is flaky again
 (timeouts): can somebody who cares about TCI investigate?)
Message-ID: <Zik8s6_iNM8u0SZ6@redhat.com>
References: <CAFEAcA92aivDF-LjSrtZH6o4UtgrtcWnM2wuPZA5VOiN6j7KMA@mail.gmail.com>
 <f5926850-670b-43fa-8011-c33ba45d8fc3@weilnetz.de>
 <9692cfcb-ef59-4cec-8452-8bfb859e8a6c@weilnetz.de>
 <50ee3a92-1bb5-4113-8558-281e78b0c2e3@weilnetz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50ee3a92-1bb5-4113-8558-281e78b0c2e3@weilnetz.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Apr 24, 2024 at 06:27:58PM +0200, Stefan Weil via wrote:
> Am 20.04.24 um 22:25 schrieb Stefan Weil:
> > Am 16.04.24 um 14:17 schrieb Stefan Weil:
> > > Am 16.04.24 um 14:10 schrieb Peter Maydell:
> > > 
> > > > The cross-i686-tci job is flaky again, with persistent intermittent
> > > > failures due to jobs timing out.
> > > [...]
> > > > Some of these timeouts are very high -- no test should be taking
> > > > 10 minutes, even given TCI and a slowish CI runner -- which suggests
> > > > to me that there's some kind of intermittent deadlock going on.
> > > > 
> > > > Can somebody who cares about TCI investigate, please, and track
> > > > down whatever this is?
> > > 
> > > I'll have a look.
> > 
> > Short summary:
> > 
> > The "persistent intermittent failures due to jobs timing out" are not
> > related to TCI: they also occur if the same tests are run with the
> > normal TCG. I suggest that the CI tests should run single threaded.
> 
> Hi Paolo,
> 
> I need help from someone who knows the CI and the build and test framework
> better.
> 
> Peter reported intermittent timeouts for the cross-i686-tci job, causing it
> to fail. I can reproduce such timeouts locally, but noticed that they are
> not limited to TCI. The GitLab CI also shows other examples, such as this
> job:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/6700955287
> 
> I think the timeouts are caused by running too many parallel processes
> during testing.
> 
> The CI uses parallel builds:
> 
> make -j$(expr $(nproc) + 1) all check-build $MAKE_CHECK_ARGS

Note that command is running both the compile and test phases of
the job. Overcommitting CPUs for the compile phase is a good
idea to keep CPUs busy while another process is waiting on
I/O, and is almost always safe todo.

Overcommitting CPUs for the test phase is less helpful and
can cause a variety of problems as you say.

> 
> It looks like `nproc` returns 8, and make runs with 9 threads.
> `meson test` uses the same value to run 9 test processes in parallel:
> 
> /builds/qemu-project/qemu/build/pyvenv/bin/meson test  --no-rebuild -t 1
> --num-processes 9 --print-errorlogs
> 
> Since the host can only handle 8 parallel threads, 9 threads might already
> cause some tests to run non-deterministically.

In contributor forks, gitlab CI will be using the public shared
runners. These are Google Cloud VMs, which only have 2 vCPUs.

In the primary QEMU repo, we have a customer runner registered
that uses Azure based VMs. Not sure on the resources we have
configured for them offhand.

The important thing there is that what you see for CI speed in
your fork repo is not neccessarily a match for CI speed in QEMU
upstream repo.

> 
> But if some of the individual tests also use multithreading (according to my
> tests they do so with at least 3 or 4 threads), things get even worse. Then
> there are up to 4 * 9 = 36 threads competing to run on the available 8
> cores.
> 
> In this scenario timeouts are expected and can occur randomly.
> 
> In my tests setting --num-processes to a lower value not only avoided
> timeouts but also reduced the processing overhead without increasing the
> runtime.
> 
> Could we run all tests with `--num-processes 1`?

The question is what impact that has on the overall job execution
time. A lot of our jobs are already quite long, which is bad for
the turnaround time of CI testing.  Reliable CI though is arguably
the #1 priority though, otherwise developers cease trusting it.
We need to find the balance between avoiding timeouts, while having
the shortest pratical job time.  The TCI job you show abuot came
out at 22 minutes, which is not our worst job, so there is some
scope for allowing it to run longer with less parallelism.

Timeouts for individual tests are a relatively  recent change to
QEMU in:

  commit 4156325cd3c205ce77b82de2c48127ccacddaf5b
  Author: Daniel P. Berrangé <berrange@redhat.com>
  Date:   Fri Dec 15 08:03:57 2023 +0100

    mtest2make: stop disabling meson test timeouts

Read the full commit message of that for the background rationale,
but especially this paragraph:

    The main risk of this change is that the individual test timeouts might
    be too short to allow completion in high load scenarios. Thus, there is
    likely to be some short term pain where we have to bump the timeouts for
    certain tests to make them reliable enough. The preceeding few patches
    raised the timeouts for all failures that were immediately apparent
    in GitLab CI.

which highlights the problem you're looking at.

The expectation was that we would need to bump the timeouts for various
tests until we get the the point where they reliably run in GitLab CI,
both forks and upstream.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


