Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB808D374A5
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 15:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1S89-0005yl-Kw; Thu, 17 Oct 2024 11:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1S87-0005yW-Fl
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:09:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1S85-0000PP-3U
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729177770;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=byNs/YnIi8i76zN9NCzT8WJnEPIev0quFEOa5VG+Jt0=;
 b=D61xZflmcsBW/PIby8ZGvgM/RxEEY+qc7bf7UKlg0725AaqBpqKZwMlinDo993k6txEFwM
 Ke0EBydXJFJ2Ac1UVPyazXmXFi7MiimTdXw0usRot5LmYS2EU5JbdZgPZI3iLfql/enAMv
 FKeTDVOUtmeTbGLWJ7BGLreDOXgUmCI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-8jX06dYKNlSRxt_T6rx7yQ-1; Thu,
 17 Oct 2024 11:09:26 -0400
X-MC-Unique: 8jX06dYKNlSRxt_T6rx7yQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D419E1955D94; Thu, 17 Oct 2024 15:09:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.94])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BEEF51956086; Thu, 17 Oct 2024 15:09:20 +0000 (UTC)
Date: Thu, 17 Oct 2024 16:09:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 1/4] tests/qtest: Add check-migration
Message-ID: <ZxEonPy5m1DjQ3CM@redhat.com>
References: <20241017143211.17771-1-farosas@suse.de>
 <20241017143211.17771-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241017143211.17771-2-farosas@suse.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Oct 17, 2024 at 11:32:08AM -0300, Fabiano Rosas wrote:
> Add two new targets, check-migration and check-migration-quick to
> allow dividing migration tests into a quick set and a slow set. With
> this it'll be possible to reduce the amount of migration tests that
> run by default as part of 'make check'.
> 
> Keep under the 'migration-quick' suite only a few tests to serve as
> sanity check for every build and move the rest under the 'migration'
> suite.

I don't think we should need to have separate make targets
for each speed. I would expect users to be able to run

  $ make check SPEED=thorough
  $ make check-qtest SPEED=thorough

which is how we document doing this for functional tests.

If we want a way to let users more easily run individual
(or a subset of) qtest suites, how about we allow for
some filtering along the lines of:

  $ make check-qtest QTESTS=migration-test

as adding top level make-check-<blah> targets for each
different subset maintainers might want isn't scalable.

> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  meson.build             |  6 +++---
>  tests/Makefile.include  |  2 ++
>  tests/qtest/meson.build | 47 +++++++++++++++++++++++++++++++++--------
>  3 files changed, 43 insertions(+), 12 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 4ea1984fc5..92d38691f9 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3,9 +3,9 @@ project('qemu', ['c'], meson_version: '>=1.1.0',
>                            'b_staticpic=false', 'stdsplit=false', 'optimization=2', 'b_pie=true'],
>          version: files('VERSION'))
>  
> -add_test_setup('quick', exclude_suites: ['slow', 'thorough'], is_default: true)
> -add_test_setup('slow', exclude_suites: ['thorough'], env: ['G_TEST_SLOW=1', 'SPEED=slow'])
> -add_test_setup('thorough', env: ['G_TEST_SLOW=1', 'SPEED=thorough'])
> +add_test_setup('quick', exclude_suites: ['slow', 'thorough', 'migration'], is_default: true)
> +add_test_setup('slow', exclude_suites: ['thorough', 'migration-quick'], env: ['G_TEST_SLOW=1', 'SPEED=slow'])
> +add_test_setup('thorough', exclude_suites: ['migration-quick'], env: ['G_TEST_SLOW=1', 'SPEED=thorough'])
>  
>  meson.add_postconf_script(find_program('scripts/symlink-install-tree.py'))
>  
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 010369bd3a..79c1350bfb 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -11,6 +11,8 @@ check-help:
>  	@echo " $(MAKE) check-qtest              Run qtest tests"
>  	@echo " $(MAKE) check-functional         Run python-based functional tests"
>  	@echo " $(MAKE) check-functional-TARGET  Run functional tests for a given target"
> +	@echo " $(MAKE) check-migration-quick    Run a small set of migration tests"
> +	@echo " $(MAKE) check-migration          Run all migration tests"
>  	@echo " $(MAKE) check-unit               Run qobject tests"
>  	@echo " $(MAKE) check-qapi-schema        Run QAPI schema tests"
>  	@echo " $(MAKE) check-block              Run block tests"
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index b207e38696..27a802474a 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -406,14 +406,43 @@ foreach dir : target_dirs
>          test: executable(test, src, dependencies: deps)
>        }
>      endif
> -    test('qtest-@0@/@1@'.format(target_base, test),
> -         qtest_executables[test],
> -         depends: [test_deps, qtest_emulator, emulator_modules],
> -         env: qtest_env,
> -         args: ['--tap', '-k'],
> -         protocol: 'tap',
> -         timeout: slow_qtests.get(test, 60),
> -         priority: slow_qtests.get(test, 60),
> -         suite: ['qtest', 'qtest-' + target_base])
> +
> +    # The migration-test test runs several slow sub-tests. Add it to
> +    # two separate targets, one for executing a few tests
> +    # (migration-quick) and another for executing the full set
> +    # (migration). This is done to reduce the amount of tests that run
> +    # via make check.
> +    if test == 'migration-test'
> +      foreach opts : [
> +        {
> +          'test-args': ['--tap', '-k', '-m', 'slow'],
> +          'test-suite': ['migration']
> +        },
> +        {
> +          'test-args': ['--tap', '-k', '-m', 'quick'],
> +          'test-suite': ['migration-quick']
> +        }]
> +
> +        test(target_base,
> +             qtest_executables[test],
> +             depends: [test_deps, qtest_emulator, emulator_modules],
> +             env: qtest_env,
> +             args: opts['test-args'],
> +             protocol: 'tap',
> +             timeout: slow_qtests.get(test, 60),
> +             priority: slow_qtests.get(test, 60),
> +             suite: opts['test-suite'])
> +      endforeach
> +    else
> +      test('qtest-@0@/@1@'.format(target_base, test),
> +           qtest_executables[test],
> +           depends: [test_deps, qtest_emulator, emulator_modules],
> +           env: qtest_env,
> +           args: ['--tap', '-k'],
> +           protocol: 'tap',
> +           timeout: slow_qtests.get(test, 60),
> +           priority: slow_qtests.get(test, 60),
> +           suite: ['qtest', 'qtest-' + target_base])
> +    endif
>    endforeach
>  endforeach
> -- 
> 2.35.3
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


