Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE25C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 17:02:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZZAp-0002a1-Hd; Thu, 01 Aug 2024 13:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZZAf-0002W1-9e
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:01:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZZAc-0003MQ-Qf
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722531653;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FAPOHpgR1rlppHkVZwm24AUL5VzrImG+dlMjIOkZCXo=;
 b=GnEBVWW1fiCVXDdQgolcLv2KqaJuX89Be7TlgXRFpTe5yHV/tSww7GPbJzj09+ZYkECq6T
 HAtXgm1/cUXrwFtweNZFx7buFeCzPWVIJhVGM4VMs5M1HhWtL0TY1FNSZCuOP+N09EkVEl
 +kMNP2f2xd6Ig0c8DCieJBggVjzbNB0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-lU1ZvgxIOu2f4mboJ1enWQ-1; Thu,
 01 Aug 2024 13:00:49 -0400
X-MC-Unique: lU1ZvgxIOu2f4mboJ1enWQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ACFDC1955D4F; Thu,  1 Aug 2024 17:00:47 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.109])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8AF69195605A; Thu,  1 Aug 2024 17:00:43 +0000 (UTC)
Date: Thu, 1 Aug 2024 18:00:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 08/24] tests/functional: add a module for handling
 asset download & caching
Message-ID: <Zqu_OGRE_uTtof79@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-9-berrange@redhat.com>
 <b9a55935-ccf6-4f13-9437-52608afc0db3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9a55935-ccf6-4f13-9437-52608afc0db3@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
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

On Thu, Aug 01, 2024 at 06:20:58PM +0200, Philippe Mathieu-Daudé wrote:
> On 30/7/24 19:03, Daniel P. Berrangé wrote:
> > The 'Asset' class is a simple module that declares a downloadable
> > asset that can be cached locally. Downloads are stored in the user's
> > home dir at ~/.cache/qemu/download, using a sha256 sum of the URL.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   tests/functional/qemu_test/__init__.py |  1 +
> >   tests/functional/qemu_test/asset.py    | 96 ++++++++++++++++++++++++++
> >   2 files changed, 97 insertions(+)
> >   create mode 100644 tests/functional/qemu_test/asset.py
> > 
> > diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
> > index 2f1e0bc70d..db05c8f412 100644
> > --- a/tests/functional/qemu_test/__init__.py
> > +++ b/tests/functional/qemu_test/__init__.py
> > @@ -6,6 +6,7 @@
> >   # later.  See the COPYING file in the top-level directory.
> > +from .asset import Asset
> 
> For next patch?
> 
> >   from .config import BUILD_DIR
> >   from .cmd import has_cmd, has_cmds, run_cmd, is_readable_executable_file, \
> >       interrupt_interactive_console_until_pattern, wait_for_console_pattern, \
> > diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
> > new file mode 100644
> > index 0000000000..6432da2e0b
> > --- /dev/null
> > +++ b/tests/functional/qemu_test/asset.py
> > @@ -0,0 +1,96 @@
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
> > +    def __init__(self, url, hash):
> > +        self.url = url
> > +        self.hash = hash
> > +        self.cache_dir = Path(Path("~").expanduser(),
> > +                              ".cache", "qemu", "download")
> > +        self.cache_file = Path(self.cache_dir,
> > +                               hashlib.sha256(url.encode("utf-8")).hexdigest())
> > +        self.log = logging.getLogger('qemu-test')
> > +
> > +    def __repr__(self):
> > +        return "Asset: url=%s hash=%s cache=%s" % (
> > +            self.url, self.hash, self.cache_file)
> > +
> > +    def _check(self, cache_file):
> > +        if self.hash is None:
> > +            return True
> > +        if len(self.hash) == 40:
> > +            sum_prog = 'sha1sum'
> > +        elif len(self.hash) == 64:
> > +            sum_prog = 'sha256sum'
> 
> Do we want to support these? Should we declare them deprecated
> and emit a warning?

Oh thanks for the reminder. I wanted to standardize on sha256 ,since
sha1 is broken and sha512 is overkill.

Since I've run the tests once I've got everything download and can
now trivially generate the sha256 for everything we need.

> 
> > +        elif len(self.hash) == 128:
> > +            sum_prog = 'sha512sum'
> > +        else:
> > +            raise Exception("unknown hash type")
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Very nice :)
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


