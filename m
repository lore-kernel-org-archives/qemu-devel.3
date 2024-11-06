Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CFCD44D54
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 13:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8fqy-0003pu-O2; Wed, 06 Nov 2024 08:13:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8fqv-0003pF-7Z
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 08:13:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8fqs-0002Ap-Iq
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 08:13:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730898815;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JHPH1oO1dvZD15EvAjYIpIBO9VyCcTJnxIoZDiGtuPc=;
 b=BHWr8XUW7S0IExeXDdAImE58P8hjq2fsy2GUlyd1L0XOsyuL8GB07OemptRvxk76g57pHM
 6A1hrNvfoRK5wX7UM1vVkuHGXEZmyrsUQMWDXDrc4OEA3+4dYh3byDx1tdPpg2ObvK7iwL
 yntp5szVnzzm9BcykqmJb4NLUrf1yRU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-rnghzKPcOPeFcpGheKv0Qw-1; Wed,
 06 Nov 2024 08:13:30 -0500
X-MC-Unique: rnghzKPcOPeFcpGheKv0Qw-1
X-Mimecast-MFC-AGG-ID: rnghzKPcOPeFcpGheKv0Qw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DEB2C1977021; Wed,  6 Nov 2024 13:13:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.180])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DAC930001A6; Wed,  6 Nov 2024 13:13:24 +0000 (UTC)
Date: Wed, 6 Nov 2024 13:13:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 12/22] tests/qtest/migration: Split TLS tests from
 migration-test.c
Message-ID: <ZytrcD51sLUD1Afh@redhat.com>
References: <20241105180837.5990-1-farosas@suse.de>
 <20241105180837.5990-13-farosas@suse.de>
 <ZytP7hMbUkkDS1MX@redhat.com> <87o72s1phk.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o72s1phk.fsf@suse.de>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Nov 06, 2024 at 10:05:59AM -0300, Fabiano Rosas wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Tue, Nov 05, 2024 at 03:08:27PM -0300, Fabiano Rosas wrote:
> >> The migration-test.c file has become unwieldy large. It's quite
> >> confusing to navigate with all the test definitions mixed with hook
> >> definitions. The TLS tests make this worse with ifdef'ery.
> >> 
> >> Since we're planning on having a smaller set of tests to run as smoke
> >> testing on all architectures, I'm taking the time to split some tests
> >> into their own file.
> >> 
> >> Move the TLS tests into a file of their own.
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >>  tests/qtest/meson.build                  |   8 +-
> >>  tests/qtest/migration-test.c             | 788 +---------------------
> >>  tests/qtest/migration/migration-common.h |   6 +
> >>  tests/qtest/migration/tls-tests.c        | 790 +++++++++++++++++++++++
> >>  4 files changed, 803 insertions(+), 789 deletions(-)
> >>  create mode 100644 tests/qtest/migration/tls-tests.c
> >
> >
> >> diff --git a/tests/qtest/migration/migration-common.h b/tests/qtest/migration/migration-common.h
> >> index 8d0081c698..c546e92259 100644
> >> --- a/tests/qtest/migration/tls-tests.c
> >> +++ b/tests/qtest/migration/tls-tests.c
> >
> >
> >> +
> >> +void migration_test_add_tls(MigrationTestEnv *env)
> >> +{
> >> +    tmpfs = env->tmpfs;
> >> +
> >> +    migration_test_add("/migration/precopy/unix/tls/psk",
> >> +                       test_precopy_unix_tls_psk);
> >> +
> >
> > ...snip...
> >
> >> +}
> >
> > Looking at this, and considering the later patch which introduces
> > 'make qtest-<subsystem>' support, I wonder if we actually need to
> > have a single 'migration-test' binary. Why not just add a main()
> > method to this  test-tests.c, and have a 'migration-test-tls'
> > binary ?
> 
> I did that initially, but then I realised it duplicates the -qmp, -util
> and -common helpers into every new test binary. With the current split,
> that would be 7x.
> 
> Another point is that we can't then implement the smoke tests like in
> this series, we'd have to make every migration-foo-test.c choose between
> smoke or full tests individually. Which is doable, but it seemed against
> your and Alex's suggestions of having 2 separate binaries.
> 
> If we're fine with the duplication in the build, I could go back to that
> approach. Each main() function would need to look like this:
>       
>     if (g_test_thorough() || env->has_kvm) {
>         /* add all tests */
>         migration_test_add();
>         migration_test_add();
>         ...
>     } else {
>         /* only the smoke suite */
>         migration_test_add_smoke();
>     }
> 
> >
> > "make qtest-migration" would provoide a way to run the same level
> > of functionality seen when everything was in one 'migration-test'
> > binary.
> 
> Yes... but not quite, because running all tests with gdb or valgrind
> attached is something that I do frequently, e.g.:
> 
> PYTHON=$(which python3.11) \
> QTEST_QEMU_BINARY_SRC=\'valgrind -q --leak-check=full --show-leak-kinds=definite,indirect \
> --sim-hints=lax-ioctls --suppressions=${BASEDIR}/valgrind-suppressions ./qemu-system-${ARCH}\' \
> QTEST_QEMU_BINARY=./qemu-system-${ARCH} ./tests/qtest/migration-test -r /${ARCH}/migration || exit 1
> 
> QTEST_QEMU_BINARY=./qemu-system-x86_64 QTEST_QEMU_BINARY_SRC='gdb -q
> --ex "set pagination off" --ex "set print thread-events off" --ex
> "handle SIGUSR1 noprint" --ex "handle SIGPIPE noprint" --ex "run" --ex
> "quit \$_exitcode" --args ./qemu-system-x86_64'
> ./tests/qtest/migration-test
> 
> This could probably be done with meson directly, if that happens to fit
> their opinionated view of the world, but I'd rather not delve into that.
> On the other hand, maybe it's not a big deal and I can live with only
> running a group of tests with the -r or -p flag instead of all of them.

Ok, what you have proposed here is a clear improvement of the status
quo, and doesn't block any of the suggestions I made. So lets just
not complicate this patch series further.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


