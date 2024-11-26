Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CB2D65520
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 16:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFyg5-0002Y4-OA; Tue, 26 Nov 2024 11:44:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFyg2-0002Xq-8e
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 11:44:38 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFyfz-0006ty-1W
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 11:44:36 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3823cf963f1so3677882f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 08:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732639473; x=1733244273; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l9PfU1BMHukcQL/CP9NRUBeOuxFMYttUuh9xUe5Xhiw=;
 b=r/7ZqRj2dSReadvgidArEOM18tH87gUYp2MOIEu3oTwsYT9FKcAajQHopnuI0QGUlQ
 dLqhXyaB82B+U1qSKIlx/wel5YbmoMuujAykMI/afUTlI5hMIDRM3uUE9Ub61Zdbiu2P
 pKN8+UVRtTh5uBzcO3HFTDnPicJ+5oqEojT1RLtyzy4mwX7oQnkdGQ59+UkCh136DBQz
 aERqETd54neb2A1JfFyLKlV2F9rY2agEjAM9VctELH+Rbvm30Za9YTd46UGJ+wYkIgvc
 rIF1FQAr67bXD/87GBhkULa67CR6CdC6hb9CjlEg8cWPaP5SdgC3gunCAwGWn0ONZSsK
 b57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732639473; x=1733244273;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l9PfU1BMHukcQL/CP9NRUBeOuxFMYttUuh9xUe5Xhiw=;
 b=Tud/qLo7l1c/SXJH4/aLz2w8x+zT378hPQTJYchQNQRCpTDk7PARF7556p4ldfWtcK
 9AR50i933BZMT+pKxszchyk/uzGvrAAMHtyOnHqa6ofRmFxlEZcnZdJlJybjueIe3flj
 k4yvn25aKvI42EWs7G/K+b1GGlo1JrwZkEgr1zUryhUbxWQ4S4m2DjMpqYTZny0fvEXJ
 bHzvCMJ2FxAAm5leaChn3hFYuRJ/AuuKFMUv3+jHqt3EeaakjImNokV/wxxUFWh7r+Z2
 fJCXpWW8NVVn/gIEhr1l0i8pcJm3sGbrfAQjpuqh1BgVgALKL+GDiQctR/F574tAMDKj
 7HpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLCHKdh53S3dk1wTNvba8PCRTezuSFjcX7vv5RfgN679Qix6jlBHca6XdbIH7tXTdAEbYTTA9yYeAp@nongnu.org
X-Gm-Message-State: AOJu0YxocxoJ/Jg3gxGqHbaKthvpNDzLmoeMGmEyss/Bds6Q/iYpMysr
 mEXge1B90PSbHOE/5tA+QsQjTk+4EUvP+/FLIIfeGLWtVpztaRNucKmQjTsTP50=
X-Gm-Gg: ASbGncspr+CBrOCFu0ByF36ez5VkXPrdAgv83O0MhEvHoRWqwiifa6NALzttsP4SsdV
 1PkeRB6329nCDT9E86EF3OyGQUOHdFLzBRjU+xsGqYPhK/vh5U+CX4iGnl+pn9CWbo6SkXp0oEn
 dZY139c1AgxuBdsk9c6Tb14LfbK+iFDzTXk/h2/SAE1rwbaky3TyodTpZ9R2FwD84FR7E9KhY1W
 mUR3Odpzwlro99RYeUW7TUrvs/61jWcGDRowFqSmZ2YJwAeCo2wmPEfD4FOZu6I9w==
X-Google-Smtp-Source: AGHT+IHMkojikJ+ewvUXs5bhRznb5ha019qS/k0Vw5oUci4lj+EBO8JRdZuX2ZY5HIZktrMhNt6ung==
X-Received: by 2002:a5d:5889:0:b0:382:4dad:3887 with SMTP id
 ffacd0b85a97d-38260b45c85mr14948556f8f.3.1732639472962; 
 Tue, 26 Nov 2024 08:44:32 -0800 (PST)
Received: from [192.168.69.146] ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbc38afsm13685561f8f.67.2024.11.26.08.44.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 08:44:31 -0800 (PST)
Message-ID: <66bf4784-f1e4-479f-83db-2d4f91c10e48@linaro.org>
Date: Tue, 26 Nov 2024 17:44:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 15/42] tests/functional: enable pre-emptive caching of
 assets
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240904103923.451847-1-thuth@redhat.com>
 <20240904103923.451847-16-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240904103923.451847-16-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Hi,

On 4/9/24 12:38, Thomas Huth wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> Many tests need to access assets stored on remote sites. We don't want
> to download these during test execution when run by meson, since this
> risks hitting test timeouts when data transfers are slow.
> 
> Add support for pre-emptive caching of assets by setting the env var
> QEMU_TEST_PRECACHE to point to a timestamp file. When this is set,
> instead of running the test, the assets will be downloaded and saved
> to the cache, then the timestamp file created.
> 
> A meson custom target is created as a dependency of each test suite
> to trigger the pre-emptive caching logic before the test runs.
> 
> When run in caching mode, it will locate assets by looking for class
> level variables with a name prefix "ASSET_", and type "Asset".
> 
> At the ninja level
> 
>     ninja test --suite functional
> 
> will speculatively download any assets that are not already cached,
> so it is advisable to set a timeout multiplier.
> 
>     QEMU_TEST_NO_DOWNLOAD=1 ninja test --suite functional
> 
> will fail the test if a required asset is not already cached
> 
>     ninja precache-functional
> 
> will download and cache all assets required by the functional
> tests
> 
> At the make level, precaching is always done by
> 
>     make check-functional
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Tested-by: Richard Henderson <richard.henderson@linaro.org>
> [thuth: Remove the duplicated "path = os.path.basename(...)" line]
> Message-ID: <20240830133841.142644-16-thuth@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/Makefile.include                 |  3 ++-
>   tests/functional/meson.build           | 33 +++++++++++++++++++++++--
>   tests/functional/qemu_test/asset.py    | 34 ++++++++++++++++++++++++++
>   tests/functional/qemu_test/testcase.py |  7 ++++++
>   4 files changed, 74 insertions(+), 3 deletions(-)


> diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
> index c0e675d847..b329ab7dbe 100644
> --- a/tests/functional/qemu_test/asset.py
> +++ b/tests/functional/qemu_test/asset.py
> @@ -9,6 +9,8 @@
>   import logging
>   import os
>   import subprocess
> +import sys
> +import unittest
>   import urllib.request
>   from pathlib import Path
>   from shutil import copyfileobj
> @@ -62,6 +64,9 @@ def fetch(self):
>                              self.cache_file, self.url)
>               return str(self.cache_file)
>   
> +        if os.environ.get("QEMU_TEST_NO_DOWNLOAD", False):
> +            raise Exception("Asset cache is invalid and downloads disabled")
> +
>           self.log.info("Downloading %s to %s...", self.url, self.cache_file)
>           tmp_cache_file = self.cache_file.with_suffix(".download")
>   
> @@ -95,3 +100,32 @@ def fetch(self):
>   
>           self.log.info("Cached %s at %s" % (self.url, self.cache_file))
>           return str(self.cache_file)
> +
> +    def precache_test(test):
> +        log = logging.getLogger('qemu-test')
> +        log.setLevel(logging.DEBUG)
> +        handler = logging.StreamHandler(sys.stdout)
> +        handler.setLevel(logging.DEBUG)
> +        formatter = logging.Formatter(
> +            '%(asctime)s - %(name)s - %(levelname)s - %(message)s')
> +        handler.setFormatter(formatter)
> +        log.addHandler(handler)
> +        for name, asset in vars(test.__class__).items():
> +            if name.startswith("ASSET_") and type(asset) == Asset:
> +                log.info("Attempting to cache '%s'" % asset)
> +                asset.fetch()

fetch() can fail [*] (see previous patch, various Exceptions returned).

What should we do in this case? If we ignore a missing artifact,
the tests will eventually fail. Better bail out early and save
credit minutes?

> +        log.removeHandler(handler)
> +
> +    def precache_suite(suite):
> +        for test in suite:
> +            if isinstance(test, unittest.TestSuite):
> +                Asset.precache_suite(test)
> +            elif isinstance(test, unittest.TestCase):
> +                Asset.precache_test(test)
> +
> +    def precache_suites(path, cacheTstamp):
> +        loader = unittest.loader.defaultTestLoader
> +        tests = loader.loadTestsFromNames([path], None)
> +
> +        with open(cacheTstamp, "w") as fh:
> +            Asset.precache_suite(tests)
> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> index b2dd863c6e..18314be9d1 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -21,6 +21,7 @@
>   from qemu.machine import QEMUMachine
>   from qemu.utils import kvm_available, tcg_available
>   
> +from .asset import Asset
>   from .cmd import run_cmd
>   from .config import BUILD_DIR
>   
> @@ -58,6 +59,12 @@ def tearDown(self):
>   
>       def main():
>           path = os.path.basename(sys.argv[0])[:-3]
> +
> +        cache = os.environ.get("QEMU_TEST_PRECACHE", None)
> +        if cache is not None:
> +            Asset.precache_suites(path, cache)
> +            return
> +
>           tr = pycotap.TAPTestRunner(message_log = pycotap.LogMode.LogToError,
>                                      test_output_log = pycotap.LogMode.LogToError)
>           unittest.main(module = None, testRunner = tr, argv=["__dummy__", path])

[*] Peter reported the following CI failure:

   https://gitlab.com/qemu-project/qemu/-/jobs/8474928266

2024-11-26 14:58:53,170 - qemu-test - ERROR - Unable to download 
https://apt.armbian.com/pool/main/l/linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb: 
HTTP Error 418:
Traceback (most recent call last):
   File "/builds/qemu-project/qemu/tests/functional/test_arm_bpim2u.py", 
line 186, in <module>
     LinuxKernelTest.main()
   File 
"/builds/qemu-project/qemu/tests/functional/qemu_test/testcase.py", line 
76, in main
     Asset.precache_suites(path, cache)
   File "/builds/qemu-project/qemu/tests/functional/qemu_test/asset.py", 
line 180, in precache_suites
     Asset.precache_suite(tests)
   File "/builds/qemu-project/qemu/tests/functional/qemu_test/asset.py", 
line 171, in precache_suite
     Asset.precache_suite(test)
   File "/builds/qemu-project/qemu/tests/functional/qemu_test/asset.py", 
line 171, in precache_suite
     Asset.precache_suite(test)
   File "/builds/qemu-project/qemu/tests/functional/qemu_test/asset.py", 
line 173, in precache_suite
     Asset.precache_test(test)
   File "/builds/qemu-project/qemu/tests/functional/qemu_test/asset.py", 
line 165, in precache_test
     asset.fetch()
   File "/builds/qemu-project/qemu/tests/functional/qemu_test/asset.py", 
line 113, in fetch
     with urllib.request.urlopen(self.url) as resp:
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File "/usr/lib/python3.11/urllib/request.py", line 216, in urlopen
     return opener.open(url, data, timeout)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File "/usr/lib/python3.11/urllib/request.py", line 525, in open
     response = meth(req, response)
                ^^^^^^^^^^^^^^^^^^^
   File "/usr/lib/python3.11/urllib/request.py", line 634, in http_response
     response = self.parent.error(
                ^^^^^^^^^^^^^^^^^^
   File "/usr/lib/python3.11/urllib/request.py", line 557, in error
     result = self._call_chain(*args)
              ^^^^^^^^^^^^^^^^^^^^^^^
   File "/usr/lib/python3.11/urllib/request.py", line 496, in _call_chain
     result = func(*args)
              ^^^^^^^^^^^
   File "/usr/lib/python3.11/urllib/request.py", line 749, in http_error_302
     return self.parent.open(new, timeout=req.timeout)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File "/usr/lib/python3.11/urllib/request.py", line 525, in open
     response = meth(req, response)
                ^^^^^^^^^^^^^^^^^^^
   File "/usr/lib/python3.11/urllib/request.py", line 634, in http_response
     response = self.parent.error(
                ^^^^^^^^^^^^^^^^^^
   File "/usr/lib/python3.11/urllib/request.py", line 563, in error
     return self._call_chain(*args)
            ^^^^^^^^^^^^^^^^^^^^^^^
   File "/usr/lib/python3.11/urllib/request.py", line 496, in _call_chain
     result = func(*args)
              ^^^^^^^^^^^
   File "/usr/lib/python3.11/urllib/request.py", line 643, in 
http_error_default
     raise HTTPError(req.full_url, code, msg, hdrs, fp)
urllib.error.HTTPError: HTTP Error 418:
ninja: build stopped: subcommand failed.


