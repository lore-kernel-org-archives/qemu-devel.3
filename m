Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8316CD65531
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 17:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFzKa-0006bH-92; Tue, 26 Nov 2024 12:26:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tFzKU-0006aJ-Nu
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 12:26:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tFzKR-0006fq-0T
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 12:26:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732641979;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TN1XHWmIfo/t+URgGvRHzBwmLVeg5t/XRfnXvkp7SxQ=;
 b=ZrhWI0hNaIItK9cbS1ISrbz/ZlHKaqIpDYpHCxnm0SXiT/Xs3Hils3IfqMwzD9L8KjjPnI
 tD/LuDgFGjUvIhIa8C5M0QQzU6CSYxCmHOj6rr0UzzAhPHHqSThlAO3W1k4WxLYH7IGQ4S
 arattVNTvQ9aokjjNdHx4ht66SOlqNw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-6OXxAaryOyil17OB6pv8Cg-1; Tue,
 26 Nov 2024 12:26:15 -0500
X-MC-Unique: 6OXxAaryOyil17OB6pv8Cg-1
X-Mimecast-MFC-AGG-ID: 6OXxAaryOyil17OB6pv8Cg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 063B01955D55; Tue, 26 Nov 2024 17:26:14 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.147])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 913B6195E483; Tue, 26 Nov 2024 17:26:11 +0000 (UTC)
Date: Tue, 26 Nov 2024 17:26:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 15/42] tests/functional: enable pre-emptive caching of
 assets
Message-ID: <Z0YEsDVqCpEAJ9T6@redhat.com>
References: <20240904103923.451847-1-thuth@redhat.com>
 <20240904103923.451847-16-thuth@redhat.com>
 <66bf4784-f1e4-479f-83db-2d4f91c10e48@linaro.org>
 <CAFEAcA_iem8QN+BDUJPzMrhbYRNmq5GRbX-bqaACdUS1BAkpwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_iem8QN+BDUJPzMrhbYRNmq5GRbX-bqaACdUS1BAkpwQ@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
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

On Tue, Nov 26, 2024 at 04:45:58PM +0000, Peter Maydell wrote:
> On Tue, 26 Nov 2024 at 16:44, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> >
> > Hi,
> >
> > On 4/9/24 12:38, Thomas Huth wrote:
> > > From: Daniel P. Berrangé <berrange@redhat.com>
> > >
> > > Many tests need to access assets stored on remote sites. We don't want
> > > to download these during test execution when run by meson, since this
> > > risks hitting test timeouts when data transfers are slow.
> > >
> > > Add support for pre-emptive caching of assets by setting the env var
> > > QEMU_TEST_PRECACHE to point to a timestamp file. When this is set,
> > > instead of running the test, the assets will be downloaded and saved
> > > to the cache, then the timestamp file created.
> > >
> > > A meson custom target is created as a dependency of each test suite
> > > to trigger the pre-emptive caching logic before the test runs.
> > >
> > > When run in caching mode, it will locate assets by looking for class
> > > level variables with a name prefix "ASSET_", and type "Asset".
> > >
> > > At the ninja level
> > >
> > >     ninja test --suite functional
> > >
> > > will speculatively download any assets that are not already cached,
> > > so it is advisable to set a timeout multiplier.
> > >
> > >     QEMU_TEST_NO_DOWNLOAD=1 ninja test --suite functional
> > >
> > > will fail the test if a required asset is not already cached
> > >
> > >     ninja precache-functional
> > >
> > > will download and cache all assets required by the functional
> > > tests
> > >
> > > At the make level, precaching is always done by
> > >
> > >     make check-functional
> > >
> > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > > Tested-by: Richard Henderson <richard.henderson@linaro.org>
> > > [thuth: Remove the duplicated "path = os.path.basename(...)" line]
> > > Message-ID: <20240830133841.142644-16-thuth@redhat.com>
> > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > ---
> > >   tests/Makefile.include                 |  3 ++-
> > >   tests/functional/meson.build           | 33 +++++++++++++++++++++++--
> > >   tests/functional/qemu_test/asset.py    | 34 ++++++++++++++++++++++++++
> > >   tests/functional/qemu_test/testcase.py |  7 ++++++
> > >   4 files changed, 74 insertions(+), 3 deletions(-)
> >
> >
> > > diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
> > > index c0e675d847..b329ab7dbe 100644
> > > --- a/tests/functional/qemu_test/asset.py
> > > +++ b/tests/functional/qemu_test/asset.py
> > > @@ -9,6 +9,8 @@
> > >   import logging
> > >   import os
> > >   import subprocess
> > > +import sys
> > > +import unittest
> > >   import urllib.request
> > >   from pathlib import Path
> > >   from shutil import copyfileobj
> > > @@ -62,6 +64,9 @@ def fetch(self):
> > >                              self.cache_file, self.url)
> > >               return str(self.cache_file)
> > >
> > > +        if os.environ.get("QEMU_TEST_NO_DOWNLOAD", False):
> > > +            raise Exception("Asset cache is invalid and downloads disabled")
> > > +
> > >           self.log.info("Downloading %s to %s...", self.url, self.cache_file)
> > >           tmp_cache_file = self.cache_file.with_suffix(".download")
> > >
> > > @@ -95,3 +100,32 @@ def fetch(self):
> > >
> > >           self.log.info("Cached %s at %s" % (self.url, self.cache_file))
> > >           return str(self.cache_file)
> > > +
> > > +    def precache_test(test):
> > > +        log = logging.getLogger('qemu-test')
> > > +        log.setLevel(logging.DEBUG)
> > > +        handler = logging.StreamHandler(sys.stdout)
> > > +        handler.setLevel(logging.DEBUG)
> > > +        formatter = logging.Formatter(
> > > +            '%(asctime)s - %(name)s - %(levelname)s - %(message)s')
> > > +        handler.setFormatter(formatter)
> > > +        log.addHandler(handler)
> > > +        for name, asset in vars(test.__class__).items():
> > > +            if name.startswith("ASSET_") and type(asset) == Asset:
> > > +                log.info("Attempting to cache '%s'" % asset)
> > > +                asset.fetch()
> >
> > fetch() can fail [*] (see previous patch, various Exceptions returned).
> >
> > What should we do in this case? If we ignore a missing artifact,
> > the tests will eventually fail. Better bail out early and save
> > credit minutes?
> 
> And more generally, can we arrange to cache these images
> in a way that lets us share them across k8s CI runners?
> Store to local disk doesn't help much there...

THe gitlab shared runners have a global cache that is keyed off the
job name, so it will be reused on each pipeline.

Our private k8s runners were configured without any cache, but IIRC
there was work on enabling a cache, and I would expect that to be
globally shared again, keyed off job name.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


