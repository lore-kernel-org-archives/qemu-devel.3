Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB35C83028
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 09:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjbuv-0005dF-P7; Thu, 29 Aug 2024 05:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjbuu-0005cj-Ui
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 05:58:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjbus-00007Q-KK
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 05:58:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724925490;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BWYA5XfoPZHbQGbduotB8/a6K6hA9gUCkQJAfVme9PA=;
 b=ckXcB3kFrKCz/6XQyWYeTaGPMUmV37aVJgjW3blPNWYEJlo3zuDCAqxgW3wgsv8hXsUtN1
 Mo0I3+QJk2PtL++rc+hYzT7fqdpF0WHIBHNHCuwgHaLcqsdJyYQof9cWHJjkdZDGyMtXdg
 hqD9TdZvqYqsyRuK7W/5OLvNskA27sA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-niDkMFpdOkqL9WyuF8anmw-1; Thu,
 29 Aug 2024 05:58:06 -0400
X-MC-Unique: niDkMFpdOkqL9WyuF8anmw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 402FC1955F56; Thu, 29 Aug 2024 09:58:05 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.64])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C11AE1955F1B; Thu, 29 Aug 2024 09:58:02 +0000 (UTC)
Date: Thu, 29 Aug 2024 10:57:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v4 14/35] tests/functional: add a module for handling
 asset download & caching
Message-ID: <ZtBGJzmkmflSze-V@redhat.com>
References: <20240821082748.65853-1-thuth@redhat.com>
 <20240821082748.65853-15-thuth@redhat.com>
 <ab83a55f-6413-4d8e-9fdc-edb5f568d6f4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab83a55f-6413-4d8e-9fdc-edb5f568d6f4@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Aug 21, 2024 at 04:49:42PM +0200, Philippe Mathieu-Daudé wrote:
> On 21/8/24 10:27, Thomas Huth wrote:
> > From: Daniel P. Berrangé <berrange@redhat.com>
> > 
> > The 'Asset' class is a simple module that declares a downloadable
> > asset that can be cached locally. Downloads are stored in the user's
> > home dir at ~/.cache/qemu/download, using a sha256 sum of the URL.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > [thuth: Drop sha1 support, use hash on file content for naming instead of URL,
> >          add the possibility to specify the cache dir via environment variable]
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >   tests/functional/qemu_test/__init__.py |  1 +
> >   tests/functional/qemu_test/asset.py    | 97 ++++++++++++++++++++++++++
> >   2 files changed, 98 insertions(+)
> >   create mode 100644 tests/functional/qemu_test/asset.py
> > 
> > diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
> > index 2f1e0bc70d..db05c8f412 100644
> > --- a/tests/functional/qemu_test/__init__.py
> > +++ b/tests/functional/qemu_test/__init__.py
> > @@ -6,6 +6,7 @@
> >   # later.  See the COPYING file in the top-level directory.
> > +from .asset import Asset
> >   from .config import BUILD_DIR
> >   from .cmd import has_cmd, has_cmds, run_cmd, is_readable_executable_file, \
> >       interrupt_interactive_console_until_pattern, wait_for_console_pattern, \
> > diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
> > new file mode 100644
> > index 0000000000..cbeb6278af
> > --- /dev/null
> > +++ b/tests/functional/qemu_test/asset.py
> > @@ -0,0 +1,97 @@
> > +# Test utilities for fetching & caching assets
> > +#
> > +# Copyright 2024 Red Hat, Inc.
> > +#
> > +# This work is licensed under the terms of the GNU GPL, version 2 or
> > +# later.  See the COPYING file in the top-level directory.
> > +
> > +import hashlib
> > +import logging
> > +import os
> > +import subprocess
> > +import urllib.request
> > +from pathlib import Path
> > +from shutil import copyfileobj
> > +
> > +
> > +# Instances of this class must be declared as class level variables
> > +# starting with a name "ASSET_". This enables the pre-caching logic
> > +# to easily find all referenced assets and download them prior to
> > +# execution of the tests.
> > +class Asset:
> > +
> > +    def __init__(self, url, hashsum):
> > +        self.url = url
> > +        self.hash = hashsum
> > +        cache_dir_env = os.getenv('QEMU_TEST_CACHE_DIR')
> > +        if cache_dir_env:
> > +            self.cache_dir = Path(cache_dir_env, "download")
> > +        else:
> > +            self.cache_dir = Path(Path("~").expanduser(),
> > +                                  ".cache", "qemu", "download")
> > +        self.cache_file = Path(self.cache_dir, hashsum)
> > +        self.log = logging.getLogger('qemu-test')
> > +
> > +    def __repr__(self):
> > +        return "Asset: url=%s hash=%s cache=%s" % (
> > +            self.url, self.hash, self.cache_file)
> > +
> > +    def _check(self, cache_file):
> > +        if self.hash is None:
> > +            return True
> > +        if len(self.hash) == 64:
> > +            sum_prog = 'sha256sum'
> > +        elif len(self.hash) == 128:
> > +            sum_prog = 'sha512sum'
> > +        else:
> > +            raise Exception("unknown hash type")
> > +
> > +        checksum = subprocess.check_output(
> > +            [sum_prog, str(cache_file)]).split()[0]
> > +        return self.hash == checksum.decode("utf-8")
> > +
> > +    def valid(self):
> > +        return self.cache_file.exists() and self._check(self.cache_file)
> > +
> > +    def fetch(self):
> > +        if not self.cache_dir.exists():
> > +            self.cache_dir.mkdir(parents=True, exist_ok=True)
> 
> This doesn't work with QEMU_TEST_CACHE_DIR set to someone else:
> 
>   File
> "/home/philippe.mathieu-daude/qemu/tests/functional/qemu_test/asset.py",
> line 60, in fetch
>     self.cache_dir.mkdir(parents=True, exist_ok=True)
>   File "/usr/lib/python3.10/pathlib.py", line 1175, in mkdir
>     self._accessor.mkdir(self, mode)
> PermissionError: [Errno 13] Permission denied:
> '/home/alex.bennee/.cache/qemu/download'
> ninja: build stopped: subcommand failed.
> 
> Maybe use a getter which falls back to Path("~").expanduser() when
> no access on QEMU_TEST_CACHE_DIR? This happens when downloading a
> new file (the recent MIPS tests I converted) which isn't in Alex's cache:

Is it really valid to point QEMU_TEST_CACHE_DIR to a directory
that you don't have permission to access ? This feels like it
could be classed as invalid usage to me, rather than needing a
workaround.

> 
> 2024-08-21 15:45:48,896 - qemu-test - INFO - Attempting to cache 'Asset: url=https://s3-eu-west-1.amazonaws.com/downloads-mips/mips-downloads/YAMON/yamon-bin-02.22.zip
> hash=eef86f0eed0ef554f041dcd47b87eebea0e6f9f1184ed31f7e9e8b4a803860ab cache=/home/alex.bennee/.cache/download/eef86f0eed0ef554f041dcd47b87eebea0e6f9f1184ed31f7e9e8b4a803860ab'
> 
> > +        if self.valid():
> > +            self.log.debug("Using cached asset %s for %s",
> > +                           self.cache_file, self.url)
> > +            return str(self.cache_file)
> > +
> > +        self.log.info("Downloading %s to %s...", self.url, self.cache_file)
> > +        tmp_cache_file = self.cache_file.with_suffix(".download")
> > +
> > +        try:
> > +            resp = urllib.request.urlopen(self.url)
> > +        except Exception as e:
> > +            self.log.error("Unable to download %s: %s", self.url, e)
> > +            raise
> > +
> > +        try:
> > +            with tmp_cache_file.open("wb+") as dst:
> > +                copyfileobj(resp, dst)
> > +        except:
> > +            tmp_cache_file.unlink()
> > +            raise
> > +        try:
> > +            # Set these just for informational purposes
> > +            os.setxattr(str(tmp_cache_file), "user.qemu-asset-url",
> > +                        self.url.encode('utf8'))
> > +            os.setxattr(str(tmp_cache_file), "user.qemu-asset-hash",
> > +                        self.hash.encode('utf8'))
> > +        except Exception as e:
> > +            self.log.info("Unable to set xattr on %s: %s", tmp_cache_file, e)
> > +            pass
> > +
> > +        if not self._check(tmp_cache_file):
> > +            tmp_cache_file.unlink()
> > +            raise Exception("Hash of %s does not match %s" %
> > +                            (self.url, self.hash))
> > +        tmp_cache_file.replace(self.cache_file)
> > +
> > +        self.log.info("Cached %s at %s" % (self.url, self.cache_file))
> > +        return str(self.cache_file)
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


