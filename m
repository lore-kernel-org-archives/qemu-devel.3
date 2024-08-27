Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6334AC5472F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 14:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1six8E-0006L3-43; Tue, 27 Aug 2024 10:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1six89-0006Ju-Jy
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 10:25:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1six87-0004G4-BJ
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 10:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724768705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IiFqHnTPfwXZdbCzd9Vx5mTnNZV+7BpVCH87nrycXGg=;
 b=IFhaMgmJ099xIMpH86s48RT27+ic3PwUvPkuimh+bgNIdvX6SwAjtejSjACfetLPxSluXr
 vD9wMPn+whvOglSp07+nOqYQkkE3oVDNtfhVeHwUh7CV45dkrcgvBjIAkoPn/l5Dheq4xb
 FYR8R4ec6KpSm916Alh+tfMwwaERmcM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-6hLXwjj-PUa6bkUeN9BEpg-1; Tue, 27 Aug 2024 10:25:03 -0400
X-MC-Unique: 6hLXwjj-PUa6bkUeN9BEpg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4281ca9f4dbso53378345e9.0
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 07:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724768702; x=1725373502;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IiFqHnTPfwXZdbCzd9Vx5mTnNZV+7BpVCH87nrycXGg=;
 b=UZE3OR3tdrUxJ0n5463ZartgPEq5iqBAGcj6W3P2o8FCrBEOmw25u737B/yhDUrBKm
 UxFWHmNL0qLoIeSk8K+MCe3/FaC1YFh2KHY/mREEEnmDiIFv1Pcsm7knKTCBJsPpxn3A
 +2ujTIQtMSqWfeb63MQb6a90DwSTorGnPKmPGU46IbdCSSZkZZ6pm1Mif+VRw2TVwah3
 aR8LgslNSxSRQ49TMpkkMekeTIhuzExqY4Qpvh6rDetq6Ky6XwbHVSBaMup/Q9I8/hJE
 6+wAWUd8tbXwhCADWvq6k+c1Pq/69iRMwAYJqjET2tXdvNUIBnjTkP+/NiW+id+fXvhY
 JK4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjO/Brym6tI8ocaafxaJOjPadSjYLIaj18MJ0l8DdMWT4dmDoaB7ZMoIXs/NbJJRaURZ9JrJmPz6oh@nongnu.org
X-Gm-Message-State: AOJu0YxcM5nD8YaJLxm909LyhL/EUFMz/YrSqTHpKxr6GNRJ6srP74Qr
 lfhJh1v3b2KfCFCvU5v8dtXfJpXzTcKNAVDGqTQDGgq1CVH+vbJIfx2BnIB78NrTIUxHC06b3BY
 /2RVlj4pKMCs6lzz8ngzJQQPfL+Ff62zjF2X9P+GbLMr0Jn5RS2qR
X-Received: by 2002:a05:600c:4715:b0:426:6e8b:3dc5 with SMTP id
 5b1f17b1804b1-42b9ae3aa32mr22123335e9.32.1724768702431; 
 Tue, 27 Aug 2024 07:25:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuHW7viYuEBpybLoJIbnrvjro7HURJpR83BFMD4z+sEtSJNAjYqQhye1uvrJQkePP9+kV6/w==
X-Received: by 2002:a05:600c:4715:b0:426:6e8b:3dc5 with SMTP id
 5b1f17b1804b1-42b9ae3aa32mr22123055e9.32.1724768701813; 
 Tue, 27 Aug 2024 07:25:01 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-179-35.web.vodafone.de.
 [109.43.179.35]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ac517a9absm187959905e9.38.2024.08.27.07.25.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Aug 2024 07:25:01 -0700 (PDT)
Message-ID: <f126030e-faf9-429e-957d-db503f7e5e33@redhat.com>
Date: Tue, 27 Aug 2024 16:24:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/35] tests/functional: enable pre-emptive caching of
 assets
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
References: <20240821082748.65853-1-thuth@redhat.com>
 <20240821082748.65853-16-thuth@redhat.com>
 <3a435391-f485-4223-93aa-b937a141db16@linaro.org>
 <2e2c6480-8a43-4606-b500-2e60bf583d00@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <2e2c6480-8a43-4606-b500-2e60bf583d00@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 27/08/2024 15.16, Thomas Huth wrote:
> On 23/08/2024 09.28, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> On 21/8/24 10:27, Thomas Huth wrote:
>>> From: Daniel P. Berrangé <berrange@redhat.com>
>>>
>>> Many tests need to access assets stored on remote sites. We don't want
>>> to download these during test execution when run by meson, since this
>>> risks hitting test timeouts when data transfers are slow.
>>>
>>> Add support for pre-emptive caching of assets by setting the env var
>>> QEMU_TEST_PRECACHE to point to a timestamp file. When this is set,
>>> instead of running the test, the assets will be downloaded and saved
>>> to the cache, then the timestamp file created.
>>>
>>> A meson custom target is created as a dependency of each test suite
>>> to trigger the pre-emptive caching logic before the test runs.
>>>
>>> When run in caching mode, it will locate assets by looking for class
>>> level variables with a name prefix "ASSET_", and type "Asset".
>>>
>>> At the ninja level
>>>
>>>     ninja test --suite functional
>>>
>>> will speculatively download any assets that are not already cached,
>>> so it is advisable to set a timeout multiplier.
>>>
>>>     QEMU_TEST_NO_DOWNLOAD=1 ninja test --suite functional
>>>
>>> will fail the test if a required asset is not already cached
>>>
>>>     ninja precache-functional
>>>
>>> will download and cache all assets required by the functional
>>> tests
>>>
>>> At the make level, precaching is always done by
>>>
>>>     make check-functional
>>>
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> Tested-by: Richard Henderson <richard.henderson@linaro.org>
>>> [thuth: Remove the duplicated "path = os.path.basename(...)" line]
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   tests/Makefile.include                 |  3 ++-
>>>   tests/functional/meson.build           | 33 +++++++++++++++++++++++--
>>>   tests/functional/qemu_test/asset.py    | 34 ++++++++++++++++++++++++++
>>>   tests/functional/qemu_test/testcase.py |  7 ++++++
>>>   4 files changed, 74 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>>> index 66c8cc3123..010369bd3a 100644
>>> --- a/tests/Makefile.include
>>> +++ b/tests/Makefile.include
>>> @@ -161,7 +161,8 @@ $(FUNCTIONAL_TARGETS):
>>>   .PHONY: check-functional
>>>   check-functional:
>>> -    @$(MAKE) SPEED=thorough check-func check-func-quick
>>> +    @$(NINJA) precache-functional
>>> +    @QEMU_TEST_NO_DOWNLOAD=1 $(MAKE) SPEED=thorough check-func 
>>> check-func-quick
>>>   # Consolidated targets
>>> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
>>> index 8a8fa0ab99..cef74b82a9 100644
>>> --- a/tests/functional/meson.build
>>> +++ b/tests/functional/meson.build
>>> @@ -33,6 +33,7 @@ tests_x86_64_quick = [
>>>   tests_x86_64_thorough = [
>>>   ]
>>> +precache_all = []
>>>   foreach speed : ['quick', 'thorough']
>>>     foreach dir : target_dirs
>>>       if not dir.endswith('-softmmu')
>>> @@ -63,11 +64,35 @@ foreach speed : ['quick', 'thorough']
>>>                                  meson.current_source_dir())
>>>       foreach test : target_tests
>>> -      test('func-@0@/@1@'.format(target_base, test),
>>> +      testname = '@0@-@1@'.format(target_base, test)
>>> +      testfile = 'test_' + test + '.py'
>>> +      testpath = meson.current_source_dir() / testfile
>>> +      teststamp = testname + '.tstamp'
>>> +      test_precache_env = environment()
>>> +      test_precache_env.set('QEMU_TEST_PRECACHE', 
>>> meson.current_build_dir() / teststamp)
>>> +      test_precache_env.set('PYTHONPATH', meson.project_source_root() / 
>>> 'python:' +
>>> +                                          meson.current_source_dir())
>>> +      precache = custom_target('func-precache-' + testname,
>>> +                               output: teststamp,
>>> +                               command: [python, testpath],
>>> +                               depend_files: files(testpath),
>>> +                               build_by_default: false,
>>> +                               env: test_precache_env)
>>> +      precache_all += precache
>>> +
>>> +      # Ideally we would add 'precache' to 'depends' here, such that
>>> +      # 'build_by_default: false' lets the pre-caching automatically
>>> +      # run immediately before the test runs. In practice this is
>>> +      # broken in meson, with it running the pre-caching in the normal
>>> +      # compile phase https://github.com/mesonbuild/meson/issues/2518
>>> +      # If the above bug ever gets fixed, when QEMU changes the min
>>> +      # meson version, add the 'depends' and remove the custom
>>> +      # 'run_target' logic below & in Makefile.include
>>> +      test('func-' + testname,
>>>              python,
>>>              depends: [test_deps, test_emulator, emulator_modules],
>>>              env: test_env,
>>> -           args: [meson.current_source_dir() / 'test_' + test + '.py'],
>>> +           args: [testpath],
>>>              protocol: 'tap',
>>>              timeout: test_timeouts.get(test, 60),
>>>              priority: test_timeouts.get(test, 60),
>>> @@ -75,3 +100,7 @@ foreach speed : ['quick', 'thorough']
>>>       endforeach
>>>     endforeach
>>>   endforeach
>>> +
>>> +run_target('precache-functional',
>>> +           depends: precache_all,
>>> +           command: ['true'])
>>> diff --git a/tests/functional/qemu_test/asset.py 
>>> b/tests/functional/qemu_test/asset.py
>>> index cbeb6278af..9250ff2b06 100644
>>> --- a/tests/functional/qemu_test/asset.py
>>> +++ b/tests/functional/qemu_test/asset.py
>>> @@ -9,6 +9,8 @@
>>>   import logging
>>>   import os
>>>   import subprocess
>>> +import sys
>>> +import unittest
>>>   import urllib.request
>>>   from pathlib import Path
>>>   from shutil import copyfileobj
>>> @@ -62,6 +64,9 @@ def fetch(self):
>>>                              self.cache_file, self.url)
>>>               return str(self.cache_file)
>>> +        if os.environ.get("QEMU_TEST_NO_DOWNLOAD", False):
>>> +            raise Exception("Asset cache is invalid and downloads 
>>> disabled")
>>> +
>>>           self.log.info("Downloading %s to %s...", self.url, 
>>> self.cache_file)
>>>           tmp_cache_file = self.cache_file.with_suffix(".download")
>>> @@ -95,3 +100,32 @@ def fetch(self):
>>>           self.log.info("Cached %s at %s" % (self.url, self.cache_file))
>>>           return str(self.cache_file)
>>> +
>>> +    def precache_test(test):
>>> +        log = logging.getLogger('qemu-test')
>>> +        log.setLevel(logging.DEBUG)
>>> +        handler = logging.StreamHandler(sys.stdout)
>>> +        handler.setLevel(logging.DEBUG)
>>> +        formatter = logging.Formatter(
>>> +            '%(asctime)s - %(name)s - %(levelname)s - %(message)s')
>>> +        handler.setFormatter(formatter)
>>> +        log.addHandler(handler)
>>> +        for name, asset in vars(test.__class__).items():
>>> +            if name.startswith("ASSET_") and type(asset) == Asset:
>>> +                log.info("Attempting to cache '%s'" % asset)
>>> +                asset.fetch()
>>> +        log.removeHandler(handler)
>>> +
>>> +    def precache_suite(suite):
>>> +        for test in suite:
>>> +            if isinstance(test, unittest.TestSuite):
>>> +                Asset.precache_suite(test)
>>> +            elif isinstance(test, unittest.TestCase):
>>> +                Asset.precache_test(test)
>>> +
>>> +    def precache_suites(path, cacheTstamp):
>>> +        loader = unittest.loader.defaultTestLoader
>>> +        tests = loader.loadTestsFromNames([path], None)
>>> +
>>> +        with open(cacheTstamp, "w") as fh:
>>> +            Asset.precache_suite(tests)
>>
>>
>> When using multiple jobs (-jN) I'm observing some hangs,
>> apparently multiple threads trying to download the same file.
>> The files are eventually downloaded successfully but it takes
>> longer. Should we acquire some exclusive lock somewhere?
> 
> I haven't seen that yet ... what did you exactly run? "make check-functional 
> -jN" ? Or "make check-functional-<target> -jN" ?

After applying some of your patches, I think I've run now into this problem, 
too: It's because test_aarch64_sbsaref.py and test_aarch64_virt.py try to 
download the same asset in parallel (alpine-standard-3.17.2-aarch64.iso).

Daniel, any ideas how to fix this in the Asset code?

  Thomas


