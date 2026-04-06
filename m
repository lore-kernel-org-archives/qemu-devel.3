Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCA3F46C46
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 14:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9l3c-0007Tg-RB; Mon, 06 Apr 2026 10:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1w9l3b-0007SK-6n
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 10:36:03 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1w9l3Z-0000UU-Mu
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 10:36:02 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6CB8060123;
 Mon,  6 Apr 2026 14:35:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD72C4CEF7;
 Mon,  6 Apr 2026 14:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775486152;
 bh=G7AQA2CTFus8FTsb4VfwjtrKUfLbIWCgd0Rb/6KJDr4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=i+TL/yP/oyUSRj/mofeQjvMsYqIQebQwGoLR1hJYBgOOQh5qhYhpESd3WMFQaPeQB
 a2/Vnj0B+wNYaEhttu/pcmy4590FEiQG9NQiEYJ521vI9191zqeA4BwadTs9d+8ofS
 YxahFO/m6JAvSeU+1q0ELtFbwTnlpt7xp0GpHdgukwxb9mdIlNv3kIzgLhSoty3+iF
 zO9mHQWni/mSVmCv6zew2KgwUMHGPxeHzf1ZZqXuYx1r4P9j59BjZ1Cc4QlcMLkK7y
 1nFoGxNJZ+21UQCT7NGHAI+08jkgL3Iz4PeG27Z/SZ6dDmHnZJbUB4Ij63sC4EODhS
 Jt/QW8ViLlIPA==
Date: Mon, 6 Apr 2026 16:35:47 +0200
From: Christian Brauner <brauner@kernel.org>
To: Thomas Huth <th.huth+qemu@posteo.eu>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH 5/5] tests/functional: add e2e test for dynamic QMP
 monitor hotplug
Message-ID: <20260406-vorfinanzieren-ausgibt-546b5d19f466@brauner>
References: <20260402-work-qmp-monitor-hotplug-v1-0-6313a5cdd574@kernel.org>
 <20260402-work-qmp-monitor-hotplug-v1-5-6313a5cdd574@kernel.org>
 <20260405200648.1f7c6a3d@tpx1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260405200648.1f7c6a3d@tpx1>
Received-SPF: pass client-ip=172.105.4.254; envelope-from=brauner@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Apr 05, 2026 at 06:06:50PM +0000, Thomas Huth wrote:
>  Hi Christian!
> 
> Am Thu, 02 Apr 2026 23:19:20 +0200
> schrieb Christian Brauner <brauner@kernel.org>:
> 
> > Add a functional test that exercises the full monitor hotplug lifecycle
> > with a real socket connection:
> > 
> > 1. Launch QEMU
> > 2. chardev-add a unix socket chardev
> > 3. monitor-add to attach a QMP monitor to it
> > 4. Connect to the socket, receive the QMP greeting, negotiate
> >    capabilities, and send a query-version command
> > 5. Disconnect, monitor-remove, chardev-remove
> > 6. Repeat the entire cycle a second time to verify cleanup and reuse
> > 
> > This complements the qtest unit tests by verifying that a real QMP
> > client can connect to a dynamically-added monitor and exchange messages.
> > 
> > Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> > ---
> ...
> > diff --git a/tests/functional/generic/test_monitor_hotplug.py b/tests/functional/generic/test_monitor_hotplug.py
> > new file mode 100644
> > index 0000000000..f8f24320c6
> > --- /dev/null
> > +++ b/tests/functional/generic/test_monitor_hotplug.py
> > @@ -0,0 +1,102 @@
> > +#!/usr/bin/env python3
> > +#
> > +# Functional test for dynamic QMP monitor hotplug
> > +#
> > +# Copyright (c) 2026 Christian Brauner
> > +#
> > +# This work is licensed under the terms of the GNU GPL, version 2 or
> > +# later.  See the COPYING file in the top-level directory.
> 
> Please add a SPDX license identifier for new files - otherwise
> scripts/checkpatch.pl will complain.

Ok, done that. :)

> 
> (and bonus points for fixing all warnings from pylint ;-))

Done.

> 
> > +import os
> > +import tempfile
> > +
> > +from qemu.qmp.legacy import QEMUMonitorProtocol
> > +
> > +from qemu_test import QemuSystemTest
> > +
> > +
> > +class MonitorHotplug(QemuSystemTest):
> > +
> > +    def setUp(self):
> > +        super().setUp()
> > +        # Use /tmp to avoid UNIX socket path length limit (108 bytes).
> > +        # The scratch_file() path is too deep for socket names.
> > +        fd, self._sock_path = tempfile.mkstemp(
> > +            prefix='qemu-mon-', suffix='.sock')
> 
> We've got a socket_dir() function in the test framework to create socket
> paths ... could you use that one instead?

Done.

> 
> Apart from that, patch looks fine to me.

Thanks!

