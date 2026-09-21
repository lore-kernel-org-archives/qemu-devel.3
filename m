Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2860C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 10:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8bde-00031m-Gd; Mon, 21 Sep 2026 06:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x8bdb-00031M-Qa
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 06:52:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x8bdY-00075q-LB
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 06:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789987959;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=BQDxkndDEZtRaKqWuNCRNpMnymGdkMpz+fiS3jemXKI=;
 b=K3/J8Kqr/x7Qy/Nogv0l1BcOasLUAmf5cRLVNwxSZfk1iVOPxMBxZ/TJYOjq9G2vF8W7zb
 wtTYJaUC6CW0u1O0PS6JFeZff/rvKxXQZZoH6lRJqbGgJFmTx7rohdoEbEt9a0N+D0RLu8
 CqD5k4sZsqv6sJaRe+ofQz0Dw6yG19I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-hXaWpdYDM7inKKfxY9cnew-1; Mon,
 21 Sep 2026 06:52:35 -0400
X-MC-Unique: hXaWpdYDM7inKKfxY9cnew-1
X-Mimecast-MFC-AGG-ID: hXaWpdYDM7inKKfxY9cnew_1789987954
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4ABC6180257F; Mon, 21 Sep 2026 10:52:34 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4916641B; Mon, 21 Sep 2026 10:52:30 +0000 (UTC)
Date: Mon, 21 Sep 2026 11:52:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH] meson: Fix meson suites invocation from make check
Message-ID: <arEMa6GTGGdIC1rZ@redhat.com>
References: <20260918203153.3874488-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260918203153.3874488-1-farosas@suse.de>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Fri, Sep 18, 2026 at 05:31:52PM -0300, Fabiano Rosas wrote:
> make check is currently by default running tests tagged
> "slow". Running make check with no SPEED variable set should be
> equivalent to SPEED=quick and run the meson 'quick' test setup, which
> explicitly excludes slow tests:

Can you give an example of some tests that you think should not
be running.

I just run 'make check' and looked at two examples

tests/unit/test-crypto-pbkdf.c  skips registering some tests
unless "SPEED=slow" and that correctly skipped them.

tests/qemu-iotests/meson.build skips running 'raw' format tests
unless SPEED=slow, and that appears to be correctly working,
only running qcow2 format tests by default.



> 
>   add_test_setup('quick', exclude_suites: ['slow', 'thorough'] ...
> 
> The problem is that the mtest2make.py script is effectively overriding
> the "meson test --setup" setting by using --suite which takes
> precedence over --setup according to meson documentation.
> 
> Fix by excluding suites directly with the "--no-suite" option while
> generating Makefile.mtest.
> 
> Although the 'exclude_suites' in meson.build are useless for make
> check, they still help when running 'meson test' from the
> command-line, so keep them around.
> 
> For the configure line I'm using:
> 
> make check goes from 1100 to 996 tests
> make SPEED=slow check stays at 2158 tests
> make SPEED=thorough check stays at 2279 tests
> 
> (the rest of the test targets look sane, but maintainers please
> double-check)
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> - With this change we obviously lose coverage in make check. I suggest
>   we use this opportunity to review what gets put in the quick
>   suite.
> 
>   For migration, I want to keep only the smoke tests in make
>   check. I'll send a patch adding them back if this change is
>   accepted.
> 
> - Some of the suffixes from functional tests could probably be removed
>   and rely on having the tests in the proper suite instead. I.e. use
>   'slow' instead of 'foobar_slow'.
> ---
>  scripts/mtest2make.py          | 11 +++++++++--
>  tests/qemu-iotests/meson.build |  2 +-
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
> index 383ea68b16..a61a83f775 100644
> --- a/scripts/mtest2make.py
> +++ b/scripts/mtest2make.py
> @@ -26,6 +26,11 @@ def names(self, base):
>  .speed.slow = $(sort $(filter-out %-thorough, $1))
>  .speed.thorough = $(sort $1)
>  
> +.speed_exclude_suites.quick = --no-suite slow --no-suite thorough \
> +                              --no-suite optional
> +.speed_exclude_suites.slow = --no-suite thorough
> +.speed_exclude_suites.thorough =
> +
>  TIMEOUT_MULTIPLIER ?= 1
>  .mtestargs = --no-rebuild -t $(TIMEOUT_MULTIPLIER)
>  ifneq ($(SPEED), quick)
> @@ -34,7 +39,8 @@ def names(self, base):
>  .mtestargs += $(subst -j,--num-processes , $(filter-out -j, $(lastword -j1 $(filter -j%, $(MAKEFLAGS)))))
>  
>  .check.mtestargs = $(MTESTARGS) $(.mtestargs) $(if $(V),--verbose,--print-errorlogs) \
> -    $(foreach s, $(sort $(.check.mtest-suites)), --suite $s)
> +    $(foreach s, $(sort $(.check.mtest-suites)), --suite $s) \
> +    $(.speed_exclude_suites.$(SPEED))
>  .bench.mtestargs = $(MTESTARGS) $(.mtestargs) --benchmark --verbose \
>      $(foreach s, $(sort $(.bench.mtest-suites)), --suite $s)''')
>  
> @@ -102,7 +108,8 @@ def emit_suite(name, suite, prefix):
>          targets += f' {prefix} {prefix}-report.junit.xml'
>      print(f'ifneq ($(filter {targets}, $(MAKECMDGOALS)),)')
>      # for the "base" suite possibly add FOO-slow and FOO-thorough
> -    print(f".{prefix}.mtest-suites += {name} $(call .speed.$(SPEED), {names})")
> +    print(f".{prefix}.mtest-suites += {name} $(call .speed.$(SPEED), {names}) "
> +          ".speed_exclude_suites.$(SPEED)")
>      print(f'endif')
>  
>  targets = {t['id']: [os.path.relpath(f) for f in t['filename']]
> diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
> index 8857f25f29..34cfcdc53b 100644
> --- a/tests/qemu-iotests/meson.build
> +++ b/tests/qemu-iotests/meson.build
> @@ -68,7 +68,7 @@ foreach driver, speed: qemu_iotests_drivers
>    endif
>  
>    # Every driver gets put in the driver specific suite
> -  suites = ['block-' + driver + '-optional']
> +  suites = ['block-' + driver + '-optional', 'optional']
>    # Any driver tagged quick or slow also gets added to slow
>    # otherwise its tagged thorough
>    if speed != 'thorough'
> -- 
> 2.53.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


