Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED8BC54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 11:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI3sL-0002CO-NA; Thu, 22 May 2025 07:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uI3sJ-0002C7-OP
 for qemu-devel@nongnu.org; Thu, 22 May 2025 07:14:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uI3sH-0004Nt-4x
 for qemu-devel@nongnu.org; Thu, 22 May 2025 07:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747912446;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CEpuxocpvewqN6jBWWGnIyW2PNWbJRCuhs0Cnxgqz4U=;
 b=TqQUMoJBiDyh1/IsCpLZpP1BDtg5deEcK5uqw8A4vtaWC2N+/y+3k3aR+TaPy0yZGYS1fd
 rgorIVQkvzWEbw5KaA4IuXQzDyn5NJb6NvhTfh2DYlPD4bmHXxHObd5ilnmAjt5JzMzvpL
 shw1HT3wi98D4vt3fpxvzb5U8zpGmKA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-bnHmM538ODKYQA5ee7IuKA-1; Thu,
 22 May 2025 07:14:04 -0400
X-MC-Unique: bnHmM538ODKYQA5ee7IuKA-1
X-Mimecast-MFC-AGG-ID: bnHmM538ODKYQA5ee7IuKA_1747912443
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94D711955DAD; Thu, 22 May 2025 11:14:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.179])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 146051958014; Thu, 22 May 2025 11:14:00 +0000 (UTC)
Date: Thu, 22 May 2025 12:13:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>,
 "yc-core @ yandex-team . ru" <yc-core@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v7 2/2] tests/functional: add memlock tests
Message-ID: <aC8G9aXYQVWxuP1z@redhat.com>
References: <20250521135522.11180-1-dtalexundeer@yandex-team.ru>
 <20250521135522.11180-3-dtalexundeer@yandex-team.ru>
 <430eaa84-5695-4fc2-90d5-d488a204e999@redhat.com>
 <af6b28bd-44cf-4540-b5f8-49d8b2781e13@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af6b28bd-44cf-4540-b5f8-49d8b2781e13@yandex-team.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, May 22, 2025 at 01:51:44PM +0500, Alexandr Moshkov wrote:
> 
> On 5/22/25 12:49, Thomas Huth wrote:
> > On 21/05/2025 15.55, Alexandr Moshkov wrote:
> > > Add new tests to check the correctness of the `-overcommit memlock`
> > > option (possible values: off, on, on-fault) by using
> > > `/proc/{qemu_pid}/smaps` file to check in Size, Rss and Locked fields of
> > > anonymous segments:
> > > 
> > > * if `memlock=off`, then Locked = 0 on every anonymous smaps;
> > > * if `memlock=on`, then Size, Rss and Locked values must be equal for
> > > every anon smaps where Rss is not 0;
> > > * if `memlock=on-fault`, then Rss and Locked must be equal on every anon
> > > smaps and anonymous segment with Rss < Size must exists.
> > > 
> > > Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> > > ---
> > ...
> > > diff --git a/tests/functional/test_memlock.py
> > > b/tests/functional/test_memlock.py
> > > new file mode 100755
> > > index 0000000000..a090e7f9ad
> > > --- /dev/null
> > > +++ b/tests/functional/test_memlock.py
> > > @@ -0,0 +1,107 @@
> > > +#!/usr/bin/env python3
> > > +#
> > > +# Functional test that check overcommit memlock options
> > > +#
> > > +# Copyright (c) Yandex Technologies LLC, 2025
> > > +#
> > > +# Author:
> > > +#  Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> > > +#
> > > +#
> > > +# This work is licensed under the terms of the GNU GPL, version 2 or
> > > +# later.  See the COPYING file in the top-level directory.
> > 
> > I just noticed: New file need a SPDX identifier nowadays to keep
> > scripts/check_patch.pl happy.
> 
> Hello, thanks for reply, i fix that in a moment!
> 
> > 
> > Anyway, I now also tested the patch, but for me, it's not working: After
> > setting ulimit -l to 2G and running the test, I get:
> > 
> > $ ~/devel/qemu/tests/functional/test_memlock.py
> > TAP version 13
> > ok 1 test_memlock.MemlockTest.test_memlock_off
> > Traceback (most recent call last):
> >   File "~/devel/qemu/tests/functional/test_memlock.py", line 60, in
> > test_memlock_on
> >     self.assertTrue(smap['Size'] == smap['Rss'] == smap['Locked'])
> >     ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > AssertionError: False is not true
> > 
> > not ok 2 test_memlock.MemlockTest.test_memlock_on
> > Traceback (most recent call last):
> >   File "~/devel/qemu/tests/functional/test_memlock.py", line 70, in
> > test_memlock_onfault
> >     self.assertTrue(smap['Rss'] == smap['Locked'])
> >     ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > AssertionError: False is not true
> > 
> > not ok 3 test_memlock.MemlockTest.test_memlock_onfault
> > 
> > I added two print statements right in front of the asserts to see the
> > values, and for the first one it shows (after many successfully
> > comparisons):
> > 
> > line 60: 4 == 4 == 0
> > 
> > And similar for the second one:
> > 
> > line 70: 4 == 0
> > 
> > FWIW, this is on Fedora 41.
> > 
> > Looking at the smaps file, it seems like this comes from a shared
> > library:
> > 
> > 7ff16c7c9000-7ff16c7ca000 r--p 00000000 00:2a 29149631
> > /usr/lib64/spa-0.2/support/libspa-support.so
> > Size:                  4 kB
> > KernelPageSize:        4 kB
> > MMUPageSize:           4 kB
> > Rss:                   4 kB
> > Pss:                   0 kB
> > Pss_Dirty:             0 kB
> > Shared_Clean:          4 kB
> > Shared_Dirty:          0 kB
> > Private_Clean:         0 kB
> > Private_Dirty:         0 kB
> > Referenced:            4 kB
> > Anonymous:             0 kB
> > KSM:                   0 kB
> > LazyFree:              0 kB
> > AnonHugePages:         0 kB
> > ShmemPmdMapped:        0 kB
> > FilePmdMapped:         0 kB
> > Shared_Hugetlb:        0 kB
> > Private_Hugetlb:       0 kB
> > Swap:                  0 kB
> > SwapPss:               0 kB
> > Locked:                0 kB
> > THPeligible:           0
> > ProtectionKey:         0
> > 
> > So maybe you've got to ignore the mappings of .so files in your test?
> 
> Oh, this segments are already ignored in _parse_anonymous_smaps(), so this
> segment should not have returned from it.
> 
> Maybe it comes from another segment? Or i have bug in anon segments
> parsing.. I'll take a closer look, thanks.

It is strange that smaps reports regioons as not locked, despite
being resident, as mlockall() claims that it locks *everything*.

None the less, I wonder if using smaps is overkill & more trouble
than it is worth ?

The /proc/$PID/status file is simpler giving a process level overview:

Normal usage:

  VmSize:   378964 kB
  VmLck:         0 kB

mem-lock=on usage:

  VmSize:   378964 kB
  VmLck:    378964 kB

and mem-lock=on-fault will be some value in between the two extremes.

Parsing this seems likely to be more reliable and easier than smaps.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


