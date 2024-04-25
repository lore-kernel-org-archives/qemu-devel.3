Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB65C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 13:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzz9K-0006VP-L1; Thu, 25 Apr 2024 09:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rzz9I-0006VA-TJ
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 09:28:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rzz9G-0003Mp-1f
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 09:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714051704;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zkkFTc/UpDM91rjQJPokXNy2hlfyGRx5dAlfhCMuLrQ=;
 b=I3DHooWTqo4u2QXJVOW0rLAq8XjaXCJlPSD/o6zQiKh1tzWGQivqc6ze2VeOlanwb/3RIR
 3OlP/fU1bCEE8rEFtxU7YjhEMjxMVH6oeFYfTD0oe5dATxyznk4UADPQECxC53ozhzU6XE
 WCd2KOm0814PSkmy4dEnVjh2MOzUXq8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-XreS7ilbONWj3whVUACUjw-1; Thu, 25 Apr 2024 09:28:21 -0400
X-MC-Unique: XreS7ilbONWj3whVUACUjw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1222802352;
 Thu, 25 Apr 2024 13:28:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A9DBAC68;
 Thu, 25 Apr 2024 13:28:18 +0000 (UTC)
Date: Thu, 25 Apr 2024 14:27:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Weil <sw@weilnetz.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Timeouts in CI jobs
Message-ID: <ZipaNZ5JD_7pM6Xp@redhat.com>
References: <CAFEAcA92aivDF-LjSrtZH6o4UtgrtcWnM2wuPZA5VOiN6j7KMA@mail.gmail.com>
 <f5926850-670b-43fa-8011-c33ba45d8fc3@weilnetz.de>
 <9692cfcb-ef59-4cec-8452-8bfb859e8a6c@weilnetz.de>
 <50ee3a92-1bb5-4113-8558-281e78b0c2e3@weilnetz.de>
 <Zik8s6_iNM8u0SZ6@redhat.com>
 <ec748687-93eb-48cf-af47-419a4389ed6e@weilnetz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec748687-93eb-48cf-af47-419a4389ed6e@weilnetz.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
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

On Wed, Apr 24, 2024 at 08:10:19PM +0200, Stefan Weil wrote:
> Am 24.04.24 um 19:09 schrieb Daniel P. Berrangé:
> 
> > On Wed, Apr 24, 2024 at 06:27:58PM +0200, Stefan Weil via wrote:
> > > I think the timeouts are caused by running too many parallel processes
> > > during testing.
> > > 
> > > The CI uses parallel builds:
> > > 
> > > make -j$(expr $(nproc) + 1) all check-build $MAKE_CHECK_ARGS
> > Note that command is running both the compile and test phases of
> > the job. Overcommitting CPUs for the compile phase is a good
> > idea to keep CPUs busy while another process is waiting on
> > I/O, and is almost always safe todo.
> 
> 
> Thank you for your answer.
> 
> Overcommitting for the build is safe, but in my experience the positive
> effect is typically very small on modern hosts with fast disk I/O and large
> buffer caches.

Fine with typical developer machines, but the shared runners in
gitlab are fairly resource constrained by comparison, and resources
are often under contention from other VMs in their infra.

> And there is also a negative impact because this requires scheduling with
> process switches.
> 
> Therefore I am not so sure that overcommitting is a good idea, especially
> not on cloud servers where the jobs are running in VMs.

As a point of reference, 'ninja' defaults to '$nproc + 2'.

> > 
> > In the primary QEMU repo, we have a customer runner registered
> > that uses Azure based VMs. Not sure on the resources we have
> > configured for them offhand.
> 
> I was talking about the primary QEMU.
> 
> > The important thing there is that what you see for CI speed in
> > your fork repo is not neccessarily a match for CI speed in QEMU
> > upstream repo.
> 
> I did not run tests in my GitLab fork because I still have to figure out how
> to do that.

It is quite simple:

  git remote add gitlab ssh://git@gitlab.com/<yourusername>/qemu
  git push gitlab -o QEMU_CI=2

this immediately runs all pipelines jobs. USe QEMU_CI=1 to not
start any jobs, and let you manually start the subset you are
interested in checking

> My test environment was an older (= slow) VM with 4 cores. I tested with
> different values for --num-processes. As expected higher values raised the
> number of timeouts. And the most interesting result was that
> `--num-processes 1` avoided timeouts, used less CPU time and did not
> increase the duration.
> 
> > > In my tests setting --num-processes to a lower value not only avoided
> > > timeouts but also reduced the processing overhead without increasing the
> > > runtime.
> > > 
> > > Could we run all tests with `--num-processes 1`?
> > The question is what impact that has on the overall job execution
> > time. A lot of our jobs are already quite long, which is bad for
> > the turnaround time of CI testing.  Reliable CI though is arguably
> > the #1 priority though, otherwise developers cease trusting it.
> > We need to find the balance between avoiding timeouts, while having
> > the shortest practical job time.  The TCI job you show about came
> > out at 22 minutes, which is not our worst job, so there is some
> > scope for allowing it to run longer with less parallelism.
> 
> The TCI job terminates after less than 7 minutes in my test runs with less
> parallelism.
> 
> Obviously there are tests which already do their own multithreading, and
> maybe other tests run single threaded. So maybe we need different values for
> `--num-processes` depending on the number of threads which the single tests
> use?

QEMU has differnt test suites too. The unit tests are likely safe
to run fully parallel, but the block I/O tests and qtests are likely
to benefit from serialization, since they all spawn many QEMU processes
as children that will consume multiple CPUs, so we probably don't need
to run the actually test suite in parallel to max out the CPUs. Still
needs testing under gitlab CI to prove the theory.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


