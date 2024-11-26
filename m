Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A05AAD6552F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 17:32:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFzPt-0007lC-US; Tue, 26 Nov 2024 12:32:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tFzPr-0007ky-8E
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 12:31:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tFzPo-0007t3-C2
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 12:31:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732642313;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rAgf85YJ/oQ6qg2rbRMZ5VgWa5R/CnWv2YzgwtiUHps=;
 b=cX6VjsMZ84vm5ljjzVDmf2Zid598DnvRyvbBn7HvbFsVUS+wcbUFY+8XE79H5Y4u+jZcIA
 SMh6btEcHlGaVI+QGtxFhQkuchVnUuC3ckNOsXzuebaA3xXx+k2S5t6Bktj9cxdxv+uzgL
 i0/d6IXkPwwtO94k8QpjkGIT1N2Dxfg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-52DuZdnMPBmElik7oMca6Q-1; Tue,
 26 Nov 2024 12:31:42 -0500
X-MC-Unique: 52DuZdnMPBmElik7oMca6Q-1
X-Mimecast-MFC-AGG-ID: 52DuZdnMPBmElik7oMca6Q
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F1F419560BD; Tue, 26 Nov 2024 17:31:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.147])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E024D30001A0; Tue, 26 Nov 2024 17:31:37 +0000 (UTC)
Date: Tue, 26 Nov 2024 17:31:34 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 15/42] tests/functional: enable pre-emptive caching of
 assets
Message-ID: <Z0YF9i2pwBkznkCD@redhat.com>
References: <20240904103923.451847-1-thuth@redhat.com>
 <20240904103923.451847-16-thuth@redhat.com>
 <66bf4784-f1e4-479f-83db-2d4f91c10e48@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66bf4784-f1e4-479f-83db-2d4f91c10e48@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Nov 26, 2024 at 05:44:29PM +0100, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 4/9/24 12:38, Thomas Huth wrote:
> > From: Daniel P. Berrangé <berrange@redhat.com>
> > 
> > Many tests need to access assets stored on remote sites. We don't want
> > to download these during test execution when run by meson, since this
> > risks hitting test timeouts when data transfers are slow.
> > 
> > Add support for pre-emptive caching of assets by setting the env var
> > QEMU_TEST_PRECACHE to point to a timestamp file. When this is set,
> > instead of running the test, the assets will be downloaded and saved
> > to the cache, then the timestamp file created.
> > 
> > A meson custom target is created as a dependency of each test suite
> > to trigger the pre-emptive caching logic before the test runs.
> > 
> > When run in caching mode, it will locate assets by looking for class
> > level variables with a name prefix "ASSET_", and type "Asset".
> > 
> > At the ninja level
> > 
> >     ninja test --suite functional
> > 
> > will speculatively download any assets that are not already cached,
> > so it is advisable to set a timeout multiplier.
> > 
> >     QEMU_TEST_NO_DOWNLOAD=1 ninja test --suite functional
> > 
> > will fail the test if a required asset is not already cached
> > 
> >     ninja precache-functional
> > 
> > will download and cache all assets required by the functional
> > tests
> > 
> > At the make level, precaching is always done by
> > 
> >     make check-functional
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > Tested-by: Richard Henderson <richard.henderson@linaro.org>
> > [thuth: Remove the duplicated "path = os.path.basename(...)" line]
> > Message-ID: <20240830133841.142644-16-thuth@redhat.com>
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >   tests/Makefile.include                 |  3 ++-
> >   tests/functional/meson.build           | 33 +++++++++++++++++++++++--
> >   tests/functional/qemu_test/asset.py    | 34 ++++++++++++++++++++++++++
> >   tests/functional/qemu_test/testcase.py |  7 ++++++
> >   4 files changed, 74 insertions(+), 3 deletions(-)
> 
> 
> > diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
> > index c0e675d847..b329ab7dbe 100644
> > --- a/tests/functional/qemu_test/asset.py
> > +++ b/tests/functional/qemu_test/asset.py
> > @@ -9,6 +9,8 @@
> >   import logging
> >   import os
> >   import subprocess
> > +import sys
> > +import unittest
> >   import urllib.request
> >   from pathlib import Path
> >   from shutil import copyfileobj
> > @@ -62,6 +64,9 @@ def fetch(self):
> >                              self.cache_file, self.url)
> >               return str(self.cache_file)
> > +        if os.environ.get("QEMU_TEST_NO_DOWNLOAD", False):
> > +            raise Exception("Asset cache is invalid and downloads disabled")
> > +
> >           self.log.info("Downloading %s to %s...", self.url, self.cache_file)
> >           tmp_cache_file = self.cache_file.with_suffix(".download")
> > @@ -95,3 +100,32 @@ def fetch(self):
> >           self.log.info("Cached %s at %s" % (self.url, self.cache_file))
> >           return str(self.cache_file)
> > +
> > +    def precache_test(test):
> > +        log = logging.getLogger('qemu-test')
> > +        log.setLevel(logging.DEBUG)
> > +        handler = logging.StreamHandler(sys.stdout)
> > +        handler.setLevel(logging.DEBUG)
> > +        formatter = logging.Formatter(
> > +            '%(asctime)s - %(name)s - %(levelname)s - %(message)s')
> > +        handler.setFormatter(formatter)
> > +        log.addHandler(handler)
> > +        for name, asset in vars(test.__class__).items():
> > +            if name.startswith("ASSET_") and type(asset) == Asset:
> > +                log.info("Attempting to cache '%s'" % asset)
> > +                asset.fetch()
> 
> fetch() can fail [*] (see previous patch, various Exceptions returned).
> 
> What should we do in this case? If we ignore a missing artifact,
> the tests will eventually fail. Better bail out early and save
> credit minutes?

We already do what you describe - 'fetch' will raise an exception
which causes the precache task to fail, and the CI job gets marked
as failed. We don't attempt to run tests if assets are missing.


> > @@ -58,6 +59,12 @@ def tearDown(self):
> >       def main():
> >           path = os.path.basename(sys.argv[0])[:-3]
> > +
> > +        cache = os.environ.get("QEMU_TEST_PRECACHE", None)
> > +        if cache is not None:
> > +            Asset.precache_suites(path, cache)
> > +            return
> > +
> >           tr = pycotap.TAPTestRunner(message_log = pycotap.LogMode.LogToError,
> >                                      test_output_log = pycotap.LogMode.LogToError)
> >           unittest.main(module = None, testRunner = tr, argv=["__dummy__", path])
> 
> [*] Peter reported the following CI failure:
> 
>   https://gitlab.com/qemu-project/qemu/-/jobs/8474928266
> 
> 2024-11-26 14:58:53,170 - qemu-test - ERROR - Unable to download https://apt.armbian.com/pool/main/l/linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb:

This looks to be working as intended. We failed to cache
the asset, and so we stopped the job, without trying to
run the tests.

The only problem I see is that our private CI runner
config is still broken, with no persistent cache provided


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


