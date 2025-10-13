Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE64CCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 11:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8H4v-0005HI-IT; Mon, 13 Oct 2025 07:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v8H4s-0005HA-4d
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 07:50:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v8H4i-0000fn-GD
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 07:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760356245;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SWw5AvEcfi5tnUheR9GaVy0Airnn3pkyUtI2BVyUY8k=;
 b=LrVrpshx1fFyKi2dAT+cRUXxnPnTeU3IuoJXQ3aSrsVRN0u0xfNHu/v9upYaqC0NVZFxDa
 VCf2e3ankJ58mLfCA39rvavGu9h44g84PyiudGmluLmmR8qAOZ3+XtJ6xuL6Gwb0cybjzW
 IRBSrZtnt60Yslm7RetvHFx0fpIRIS4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-hL7izNuZO1OWp4aAcLvZdQ-1; Mon,
 13 Oct 2025 07:50:42 -0400
X-MC-Unique: hL7izNuZO1OWp4aAcLvZdQ-1
X-Mimecast-MFC-AGG-ID: hL7izNuZO1OWp4aAcLvZdQ_1760356241
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B2AD195410D; Mon, 13 Oct 2025 11:50:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.40])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C48CC30002CE; Mon, 13 Oct 2025 11:50:39 +0000 (UTC)
Date: Mon, 13 Oct 2025 12:50:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 2/2] tests: Evict stale files in the functional download
 cache after a while
Message-ID: <aOzni0KXA9nysxUA@redhat.com>
References: <20251010093244.807544-1-thuth@redhat.com>
 <20251010093244.807544-3-thuth@redhat.com>
 <aOjW8aJKxNtUf3Py@redhat.com>
 <2cc78a29-6df7-4cfa-86b8-6065869a8a85@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2cc78a29-6df7-4cfa-86b8-6065869a8a85@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Oct 13, 2025 at 01:47:57PM +0200, Thomas Huth wrote:
> On 10/10/2025 11.50, Daniel P. Berrangé wrote:
> > On Fri, Oct 10, 2025 at 11:32:43AM +0200, Thomas Huth wrote:
> > > From: Thomas Huth <thuth@redhat.com>
> > > 
> > > The download cache of the functional tests is currently only growing.
> > > But sometimes tests get removed or changed to use different assets,
> > > thus we should clean up the stale old assets after a while when they
> > > are not in use anymore. So add a script that looks at the time stamps
> > > of the assets and removes them if they haven't been touched for more
> > > than half of a year. Since there might also be some assets around that
> > > have been added to the cache before we added the time stamp files,
> > > assume a default time stamp that is close to the creation date of this
> > > patch, so that we don't delete these files too early.
> > > 
> > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > ---
> > >   MAINTAINERS                       |  1 +
> > >   scripts/clean_functional_cache.py | 47 +++++++++++++++++++++++++++++++
> > >   tests/Makefile.include            |  1 +
> > >   3 files changed, 49 insertions(+)
> > >   create mode 100755 scripts/clean_functional_cache.py
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 84cfd85e1fa..4c468d45337 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -4398,6 +4398,7 @@ M: Thomas Huth <thuth@redhat.com>
> > >   R: Philippe Mathieu-Daudé <philmd@linaro.org>
> > >   R: Daniel P. Berrange <berrange@redhat.com>
> > >   F: docs/devel/testing/functional.rst
> > > +F: scripts/clean_functional_cache.py
> > >   F: tests/functional/qemu_test/
> > >   Windows Hosted Continuous Integration
> > > diff --git a/scripts/clean_functional_cache.py b/scripts/clean_functional_cache.py
> > > new file mode 100755
> > > index 00000000000..e5c4d1acaf3
> > > --- /dev/null
> > > +++ b/scripts/clean_functional_cache.py
> > > @@ -0,0 +1,47 @@
> > > +#!/usr/bin/env python3
> > > +#
> > > +# SPDX-License-Identifier: GPL-2.0-or-later
> > > +#
> > > +"""Delete stale assets from the download cache of the functional tests"""
> > > +
> > > +import os
> > > +import stat
> > > +import sys
> > > +import time
> > > +from pathlib import Path
> > > +
> > > +
> > > +cache_dir_env = os.getenv('QEMU_TEST_CACHE_DIR')
> > > +if cache_dir_env:
> > > +    cache_dir = Path(cache_dir_env, "download")
> > > +else:
> > > +    cache_dir = Path(Path("~").expanduser(), ".cache", "qemu", "download")
> > 
> > This creates a Path object but then doesn't take advantage of
> > any of its functionality, calling os. functions still....
> 
> Ok, you got me, looks like I'm still a python ignorant after one year of
> hacking the functional testing framework ;-) Thanks for the hints how to do
> it better!
> 
> > > +    try:
> > > +        with open(filename + ".stamp", "r", encoding='utf-8') as fh:
> > > +            timestamp = int(fh.read())
> > 
> >     timestamp = file.read_text()
> 
> Hmm, but "file" points to the asset, not to the .stamp file, doesn't it?

Opps, yes, you'll need

  file.with_stem(".stamp").read_text()

> > > +    except FileNotFoundError:
> > > +        # Assume it's an old file that was already in the cache before we
> > > +        # added the code for evicting stale assets. Use the release date
> > > +        # of QEMU v10.1 as a default timestamp.
> > > +        timestamp = time.mktime((2025, 8, 26, 0, 0, 0, 0, 0, 0))
> > 
> > The prev patch will make the precache task create the .stamp for all
> > files that are currently in use by the current branch. So the only
> > thing this does is to prevent us deleting cached files that might
> > still be needed by a different branch. There will be few of them,
> > so if we prematurely delete a handful that's not a big deal. If we
> > switch to checking mtime, this except won't even exist.
> 
> When hunting regressions that have been introduced recently, I often have to
> do bisecting on revisions from the previous 1 or 2 QEMU releases, so I'd
> prefer keeping the assets of the last few months, even if they have been
> removed from the master branch in a very recent commit.

Ok.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


