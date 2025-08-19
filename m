Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D1CCA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 16:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoPF5-00026x-5U; Tue, 19 Aug 2025 12:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoPF3-00026R-O3
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 12:31:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoPF1-0003KT-ES
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 12:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755621078;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=7UxykiOXAAb0WhaJnwN2UAFI5tE9pGwoMYJLMEQs4NU=;
 b=ip5rVsyHntbbq8WItZAOTcKvUb29J7lRpUAmXMjOb77pMN87BRz1bM6p40h5aI8NeZiWK6
 /lTE7Fhc9rEmaz/KRv2v0fAn8fKFqUvbGRIVG3pcytV59jbEOlssyThjwQ7gIzI5fv2FAG
 ARVgIqfWvSIybMvA1pDDoMTxeyQnP9Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-XcP1L3VbP2eSrwXzJjn0EA-1; Tue,
 19 Aug 2025 12:31:16 -0400
X-MC-Unique: XcP1L3VbP2eSrwXzJjn0EA-1
X-Mimecast-MFC-AGG-ID: XcP1L3VbP2eSrwXzJjn0EA_1755621073
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DD721800299; Tue, 19 Aug 2025 16:31:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.237])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C15B13000198; Tue, 19 Aug 2025 16:31:08 +0000 (UTC)
Date: Tue, 19 Aug 2025 17:31:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eli Schwartz <eschwartz93@gmail.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:Rust-related patc..." <qemu-rust@nongnu.org>
Subject: Re: [PATCH] meson: set test programs to not build by default
Message-ID: <aKSmyWRB_Gi3kru_@redhat.com>
References: <20250819154940.2137965-1-eschwartz@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250819154940.2137965-1-eschwartz@gentoo.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 19, 2025 at 11:49:40AM -0400, Eli Schwartz wrote:
> Rather, they are built when running `meson test`. This change is inert
> unless building with meson 1.7, as previous versions of meson build all
> `meson test` dependencies as part of `ninja all` as well.
> 
> See:
> https://mesonbuild.com/Release-notes-for-1-7-0.html#test-targets-no-longer-built-by-default
> 
> An existing comment references this meson issue, with an included bug
> reference, but was written before meson 1.7 fixed the bug. Update the
> comment to change the advice from "if the bug gets fixed" to "when
> bumping the minimum meson version".

I am very much not a fan of projects that do not build test
programs by default.

If a dev is changing code and running 'ninja'/'make' everything
that is affected should be rebuilt to identify any build failures
that may have introduced immediately. This should include all
test binaries, regardless of whether the dev is intending to run
the tests at that time or not.

We already have too many occassions when contributors submit
patches that have tests which fail to pass & this will expand
that problem with contributors submitting patches that fail
to even pass compilation of the tests.

If we want the ability to opt-out of building tests by default
so reduce build time, IMHO that should be behind a 'configure'
flag / meson_options.txt setting.

> 
> Signed-off-by: Eli Schwartz <eschwartz@gentoo.org>
> ---
>  qga/meson.build              | 1 +
>  rust/qemu-api/meson.build    | 1 +
>  tests/fp/meson.build         | 2 ++
>  tests/functional/meson.build | 9 ++++-----
>  tests/qtest/meson.build      | 2 +-
>  tests/unit/meson.build       | 2 +-
>  6 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/qga/meson.build b/qga/meson.build
> index 89a4a8f713..44175ccedd 100644
> --- a/qga/meson.build
> +++ b/qga/meson.build
> @@ -197,6 +197,7 @@ if host_os != 'windows' and not get_option('fuzzing')
>      i = i + 1
>    endforeach
>    qga_ssh_test = executable('qga-ssh-test', srcs,
> +                            build_by_default: false,
>                              dependencies: [qemuutil],
>                              c_args: ['-DQGA_BUILD_UNIT_TEST'])
>  
> diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
> index a090297c45..fec38d6726 100644
> --- a/rust/qemu-api/meson.build
> +++ b/rust/qemu-api/meson.build
> @@ -102,6 +102,7 @@ test('rust-qemu-api-integration',
>      executable(
>          'rust-qemu-api-integration',
>          files('tests/tests.rs', 'tests/vmstate_tests.rs'),
> +        build_by_default: false,
>          override_options: ['rust_std=2021', 'build.rust_std=2021'],
>          rust_args: ['--test'],
>          install: false,
> diff --git a/tests/fp/meson.build b/tests/fp/meson.build
> index 9059a24752..9c50452bf1 100644
> --- a/tests/fp/meson.build
> +++ b/tests/fp/meson.build
> @@ -57,6 +57,7 @@ fpcflags = [
>  fptest = executable(
>    'fp-test',
>    ['fp-test.c', '../../fpu/softfloat.c'],
> +  build_by_default: false,
>    dependencies: [qemuutil, libsoftfloat, libtestfloat, libslowfloat],
>    c_args: fpcflags,
>  )
> @@ -149,6 +150,7 @@ executable(
>  fptestlog2 = executable(
>    'fp-test-log2',
>    ['fp-test-log2.c', '../../fpu/softfloat.c'],
> +  build_by_default: false,
>    dependencies: [qemuutil, libsoftfloat],
>    c_args: fpcflags,
>  )
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 311c6f1806..6d7dc91954 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -408,11 +408,10 @@ foreach speed : ['quick', 'thorough']
>        # Ideally we would add 'precache' to 'depends' here, such that
>        # 'build_by_default: false' lets the pre-caching automatically
>        # run immediately before the test runs. In practice this is
> -      # broken in meson, with it running the pre-caching in the normal
> -      # compile phase https://github.com/mesonbuild/meson/issues/2518
> -      # If the above bug ever gets fixed, when QEMU changes the min
> -      # meson version, add the 'depends' and remove the custom
> -      # 'run_target' logic below & in Makefile.include
> +      # broken in older versions of meson, with it running the
> +      # pre-caching in the normal compile phase. When QEMU changes
> +      # the min meson version to >=1.7, add the 'depends' and remove
> +      # the custom 'run_target' logic below & in Makefile.include
>        test('func-' + testname,
>             python,
>             depends: [test_deps, test_emulator, emulator_modules, plugin_modules],
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 669d07c06b..0a5309005f 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -447,7 +447,7 @@ foreach dir : target_dirs
>          deps += test_ss.all_dependencies()
>        endif
>        qtest_executables += {
> -        test: executable(test, src, dependencies: deps)
> +        test: executable(test, src, build_by_default: false, dependencies: deps)
>        }
>      endif
>  
> diff --git a/tests/unit/meson.build b/tests/unit/meson.build
> index d5248ae51d..af9725a3f8 100644
> --- a/tests/unit/meson.build
> +++ b/tests/unit/meson.build
> @@ -189,7 +189,7 @@ foreach test_name, extra: tests
>      src += test_ss.all_sources()
>      deps += test_ss.all_dependencies()
>    endif
> -  exe = executable(test_name, src, genh, dependencies: deps)
> +  exe = executable(test_name, src, genh, build_by_default: false, dependencies: deps)
>  
>    test(test_name, exe,
>         depends: test_deps.get(test_name, []),
> -- 
> 2.49.1
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


