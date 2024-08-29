Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF2F1C8302B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 10:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjcC4-00054m-TG; Thu, 29 Aug 2024 06:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjcC3-00053a-Ux
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 06:15:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjcC1-0002HE-4y
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 06:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724926550;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=esI0coQTiRztNHYFMbOogBbz/aFpsBG7C6SNMB5SIbM=;
 b=g7dQ5OMHL3gzUxrsKh6WS52Rj+veM4qwvJjCZl+hTNfxo8gVvvhiqXv+Lz3UBX3R9H6p22
 pNS8reiZNZbOAjXvAK1T37mY2rvvum1UwaSVHRbRuG75PLLsNAIIZ84bGlLqh01rnf/5KK
 4ZbOFtvOk2+wLuxTKsVcKBYhqp4obEM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-NQaTFHODMSu_GVcT0_XScA-1; Thu,
 29 Aug 2024 06:15:43 -0400
X-MC-Unique: NQaTFHODMSu_GVcT0_XScA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 783761955D54; Thu, 29 Aug 2024 10:15:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.64])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1168300019C; Thu, 29 Aug 2024 10:15:38 +0000 (UTC)
Date: Thu, 29 Aug 2024 11:15:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v4 15/35] tests/functional: enable pre-emptive caching of
 assets
Message-ID: <ZtBKR205LUm9qvgu@redhat.com>
References: <20240821082748.65853-1-thuth@redhat.com>
 <20240821082748.65853-16-thuth@redhat.com>
 <3a435391-f485-4223-93aa-b937a141db16@linaro.org>
 <2e2c6480-8a43-4606-b500-2e60bf583d00@redhat.com>
 <f126030e-faf9-429e-957d-db503f7e5e33@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f126030e-faf9-429e-957d-db503f7e5e33@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Aug 27, 2024 at 04:24:59PM +0200, Thomas Huth wrote:
> On 27/08/2024 15.16, Thomas Huth wrote:
> > On 23/08/2024 09.28, Philippe Mathieu-Daudé wrote:
> > > Hi,
> > > 
> > > On 21/8/24 10:27, Thomas Huth wrote:
> > > > From: Daniel P. Berrangé <berrange@redhat.com>
> > > > 
> > > > Many tests need to access assets stored on remote sites. We don't want
> > > > to download these during test execution when run by meson, since this
> > > > risks hitting test timeouts when data transfers are slow.
> > > > 
> > > > Add support for pre-emptive caching of assets by setting the env var
> > > > QEMU_TEST_PRECACHE to point to a timestamp file. When this is set,
> > > > instead of running the test, the assets will be downloaded and saved
> > > > to the cache, then the timestamp file created.
> > > > 
> > > > A meson custom target is created as a dependency of each test suite
> > > > to trigger the pre-emptive caching logic before the test runs.
> > > > 
> > > > When run in caching mode, it will locate assets by looking for class
> > > > level variables with a name prefix "ASSET_", and type "Asset".
> > > > 
> > > > At the ninja level
> > > > 
> > > >     ninja test --suite functional
> > > > 
> > > > will speculatively download any assets that are not already cached,
> > > > so it is advisable to set a timeout multiplier.
> > > > 
> > > >     QEMU_TEST_NO_DOWNLOAD=1 ninja test --suite functional
> > > > 
> > > > will fail the test if a required asset is not already cached
> > > > 
> > > >     ninja precache-functional
> > > > 
> > > > will download and cache all assets required by the functional
> > > > tests
> > > > 
> > > > At the make level, precaching is always done by
> > > > 
> > > >     make check-functional
> > > > 
> > > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > > > Tested-by: Richard Henderson <richard.henderson@linaro.org>
> > > > [thuth: Remove the duplicated "path = os.path.basename(...)" line]
> > > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > > ---
> > > >   tests/Makefile.include                 |  3 ++-
> > > >   tests/functional/meson.build           | 33 +++++++++++++++++++++++--
> > > >   tests/functional/qemu_test/asset.py    | 34 ++++++++++++++++++++++++++
> > > >   tests/functional/qemu_test/testcase.py |  7 ++++++
> > > >   4 files changed, 74 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > > > index 66c8cc3123..010369bd3a 100644
> > > > --- a/tests/Makefile.include
> > > > +++ b/tests/Makefile.include
> > > > @@ -161,7 +161,8 @@ $(FUNCTIONAL_TARGETS):
> > > >   .PHONY: check-functional
> > > >   check-functional:
> > > > -    @$(MAKE) SPEED=thorough check-func check-func-quick
> > > > +    @$(NINJA) precache-functional
> > > > +    @QEMU_TEST_NO_DOWNLOAD=1 $(MAKE) SPEED=thorough check-func
> > > > check-func-quick
> > > >   # Consolidated targets
> > > > diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> > > > index 8a8fa0ab99..cef74b82a9 100644
> > > > --- a/tests/functional/meson.build
> > > > +++ b/tests/functional/meson.build
> > > > @@ -33,6 +33,7 @@ tests_x86_64_quick = [
> > > >   tests_x86_64_thorough = [
> > > >   ]
> > > > +precache_all = []
> > > >   foreach speed : ['quick', 'thorough']
> > > >     foreach dir : target_dirs
> > > >       if not dir.endswith('-softmmu')
> > > > @@ -63,11 +64,35 @@ foreach speed : ['quick', 'thorough']
> > > >                                  meson.current_source_dir())
> > > >       foreach test : target_tests
> > > > -      test('func-@0@/@1@'.format(target_base, test),
> > > > +      testname = '@0@-@1@'.format(target_base, test)
> > > > +      testfile = 'test_' + test + '.py'
> > > > +      testpath = meson.current_source_dir() / testfile
> > > > +      teststamp = testname + '.tstamp'
> > > > +      test_precache_env = environment()
> > > > +      test_precache_env.set('QEMU_TEST_PRECACHE',
> > > > meson.current_build_dir() / teststamp)
> > > > +      test_precache_env.set('PYTHONPATH',
> > > > meson.project_source_root() / 'python:' +
> > > > +                                          meson.current_source_dir())
> > > > +      precache = custom_target('func-precache-' + testname,
> > > > +                               output: teststamp,
> > > > +                               command: [python, testpath],
> > > > +                               depend_files: files(testpath),
> > > > +                               build_by_default: false,
> > > > +                               env: test_precache_env)
> > > > +      precache_all += precache
> > > > +
> > > > +      # Ideally we would add 'precache' to 'depends' here, such that
> > > > +      # 'build_by_default: false' lets the pre-caching automatically
> > > > +      # run immediately before the test runs. In practice this is
> > > > +      # broken in meson, with it running the pre-caching in the normal
> > > > +      # compile phase https://github.com/mesonbuild/meson/issues/2518
> > > > +      # If the above bug ever gets fixed, when QEMU changes the min
> > > > +      # meson version, add the 'depends' and remove the custom
> > > > +      # 'run_target' logic below & in Makefile.include
> > > > +      test('func-' + testname,
> > > >              python,
> > > >              depends: [test_deps, test_emulator, emulator_modules],
> > > >              env: test_env,
> > > > -           args: [meson.current_source_dir() / 'test_' + test + '.py'],
> > > > +           args: [testpath],
> > > >              protocol: 'tap',
> > > >              timeout: test_timeouts.get(test, 60),
> > > >              priority: test_timeouts.get(test, 60),
> > > > @@ -75,3 +100,7 @@ foreach speed : ['quick', 'thorough']
> > > >       endforeach
> > > >     endforeach
> > > >   endforeach
> > > > +
> > > > +run_target('precache-functional',
> > > > +           depends: precache_all,
> > > > +           command: ['true'])
> > > > diff --git a/tests/functional/qemu_test/asset.py
> > > > b/tests/functional/qemu_test/asset.py
> > > > index cbeb6278af..9250ff2b06 100644
> > > > --- a/tests/functional/qemu_test/asset.py
> > > > +++ b/tests/functional/qemu_test/asset.py
> > > > @@ -9,6 +9,8 @@
> > > >   import logging
> > > >   import os
> > > >   import subprocess
> > > > +import sys
> > > > +import unittest
> > > >   import urllib.request
> > > >   from pathlib import Path
> > > >   from shutil import copyfileobj
> > > > @@ -62,6 +64,9 @@ def fetch(self):
> > > >                              self.cache_file, self.url)
> > > >               return str(self.cache_file)
> > > > +        if os.environ.get("QEMU_TEST_NO_DOWNLOAD", False):
> > > > +            raise Exception("Asset cache is invalid and
> > > > downloads disabled")
> > > > +
> > > >           self.log.info("Downloading %s to %s...", self.url,
> > > > self.cache_file)
> > > >           tmp_cache_file = self.cache_file.with_suffix(".download")
> > > > @@ -95,3 +100,32 @@ def fetch(self):
> > > >           self.log.info("Cached %s at %s" % (self.url, self.cache_file))
> > > >           return str(self.cache_file)
> > > > +
> > > > +    def precache_test(test):
> > > > +        log = logging.getLogger('qemu-test')
> > > > +        log.setLevel(logging.DEBUG)
> > > > +        handler = logging.StreamHandler(sys.stdout)
> > > > +        handler.setLevel(logging.DEBUG)
> > > > +        formatter = logging.Formatter(
> > > > +            '%(asctime)s - %(name)s - %(levelname)s - %(message)s')
> > > > +        handler.setFormatter(formatter)
> > > > +        log.addHandler(handler)
> > > > +        for name, asset in vars(test.__class__).items():
> > > > +            if name.startswith("ASSET_") and type(asset) == Asset:
> > > > +                log.info("Attempting to cache '%s'" % asset)
> > > > +                asset.fetch()
> > > > +        log.removeHandler(handler)
> > > > +
> > > > +    def precache_suite(suite):
> > > > +        for test in suite:
> > > > +            if isinstance(test, unittest.TestSuite):
> > > > +                Asset.precache_suite(test)
> > > > +            elif isinstance(test, unittest.TestCase):
> > > > +                Asset.precache_test(test)
> > > > +
> > > > +    def precache_suites(path, cacheTstamp):
> > > > +        loader = unittest.loader.defaultTestLoader
> > > > +        tests = loader.loadTestsFromNames([path], None)
> > > > +
> > > > +        with open(cacheTstamp, "w") as fh:
> > > > +            Asset.precache_suite(tests)
> > > 
> > > 
> > > When using multiple jobs (-jN) I'm observing some hangs,
> > > apparently multiple threads trying to download the same file.
> > > The files are eventually downloaded successfully but it takes
> > > longer. Should we acquire some exclusive lock somewhere?
> > 
> > I haven't seen that yet ... what did you exactly run? "make
> > check-functional -jN" ? Or "make check-functional-<target> -jN" ?
> 
> After applying some of your patches, I think I've run now into this problem,
> too: It's because test_aarch64_sbsaref.py and test_aarch64_virt.py try to
> download the same asset in parallel (alpine-standard-3.17.2-aarch64.iso).
> 
> Daniel, any ideas how to fix this in the Asset code?

So when downloading we open a file with a ".download" suffix, write to
that, and then rename it to the final filename.

If we have concurrent usage, both will open the same file and try to
write to it. Assuming both are downloading the same content we would
probably "get lucky" and have a consistent file at the end, but clearly
it is bad to rely on luck.

The lame option is to use NamedTemporaryFile for the teporary file.
This ensures both processes will write to different temp files, and
the final rename is atomic. This guarantees safety, but still has
the double download penalty.

The serious option is to use fcntl.lockf(..., fcntl.LOCK_EX) on the
temp file. If we can't acquire the lock then just immediately close
the temp file (don't delete it) and assume another thread is going to
finish its download.

On windows  we'll need msvcrt.locking(..., msvcrt.LK_WLCK, ...)
instead of fcntl.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


