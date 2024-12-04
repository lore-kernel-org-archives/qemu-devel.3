Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5299E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 10:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tImtj-0003Aa-8g; Wed, 04 Dec 2024 05:46:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tImte-0003AC-M0
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 05:46:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tImtb-0004yy-Ad
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 05:46:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733309174;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=PdoGhfRDjlR7Ftikb5GvZavl0RdhNSMHmwxYryBtI4o=;
 b=GMw+T1MzaE00gsCf5e0H0sWgioGflqTTimI8W5B9hYd+gCjKxWdQOtXyK9EWrhr8GXMl4R
 OitYxqW0VmrR2BzUW1lo5KmyK5pJy+uFnGgEqf4LXhre0plrWqIlpl9jlYoZ/hwzIKiMKD
 uARjRfz7MrqdJpnw3kDmHzxHT3aVc8c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-yGLuU2RXOWKLl_JOke5VAQ-1; Wed,
 04 Dec 2024 05:46:09 -0500
X-MC-Unique: yGLuU2RXOWKLl_JOke5VAQ-1
X-Mimecast-MFC-AGG-ID: yGLuU2RXOWKLl_JOke5VAQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B37991955DC8; Wed,  4 Dec 2024 10:46:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.92])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5AC6D1956048; Wed,  4 Dec 2024 10:46:07 +0000 (UTC)
Date: Wed, 4 Dec 2024 10:46:03 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 2/5] tests/functional: Extract the find_free_ports()
 function into a helper file
Message-ID: <Z1Ay61hpfABc6n33@redhat.com>
References: <20241204071911.664057-1-thuth@redhat.com>
 <20241204071911.664057-3-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241204071911.664057-3-thuth@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Wed, Dec 04, 2024 at 08:19:08AM +0100, Thomas Huth wrote:
> We'll need this functionality in other functional tests, too, so
> let's extract it into the qemu_test module.
> Also add  an __enter__ and __exit__ function that can be used for
> using this functionality in a locked context, so that tests that
> are running in parallel don't try to compete for the same ports
> later.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/functional/qemu_test/ports.py | 53 +++++++++++++++++++++++++++++
>  tests/functional/test_vnc.py        | 36 +++++---------------
>  2 files changed, 61 insertions(+), 28 deletions(-)
>  create mode 100644 tests/functional/qemu_test/ports.py
> 
> diff --git a/tests/functional/qemu_test/ports.py b/tests/functional/qemu_test/ports.py
> new file mode 100644
> index 0000000000..d235d3432b
> --- /dev/null
> +++ b/tests/functional/qemu_test/ports.py
> @@ -0,0 +1,53 @@
> +#!/usr/bin/env python3
> +#
> +# Simple functional tests for VNC functionality
> +#
> +# Copyright 2018, 2024 Red Hat, Inc.
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +import fcntl
> +import os
> +import socket
> +import sys
> +import tempfile
> +from typing import List
> +
> +class Ports():
> +
> +    PORTS_ADDR = '127.0.0.1'
> +    PORTS_START = 32768
> +    PORTS_END = PORTS_START + 1024
> +
> +    def __enter__(self):
> +        lock_file = os.path.join(tempfile.gettempdir(), "qemu_port_lock")
> +        self.lock_fh = os.open(lock_file, os.O_CREAT)
> +        fcntl.flock(self.lock_fh, fcntl.LOCK_EX)
> +        return self
> +
> +    def __exit__(self, exc_type, exc_value, traceback):
> +        fcntl.flock(self.lock_fh, fcntl.LOCK_UN)
> +        os.close(self.lock_fh)

This code will leave '/tmp/qemu_port_lock' existing forever.... which is
correct, because if you try to unlink it after closing, you'll introduce
a race because the 2nd __enter__ will now be locking an unlinked file,
and a 3rd __enter__ that comes along will create & lock an entirely new
file.

There are ways to make this safe by using stat + fstat either side of
LOCK_EX, in a loop, to detect locking of an unlinked file. That is
overkill though.  It is simpler to just put the lock file in the build
directory IMHO, and thus avoid needing to care about unlinking - that'll
be done when the user purges their build dir.

> +
> +    def check_bind(self, port: int) -> bool:
> +        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
> +            try:
> +                sock.bind((self.PORTS_ADDR, port))
> +            except OSError:
> +                return False
> +
> +        return True
> +
> +    def find_free_ports(self, count: int) -> List[int]:
> +        result = []
> +        for port in range(self.PORTS_START, self.PORTS_END):
> +            if self.check_bind(port):
> +                result.append(port)
> +                if len(result) >= count:
> +                    break
> +        assert len(result) == count
> +        return result
> +
> +    def find_free_port(self) -> int:
> +        return self.find_free_ports(1)[0]
> diff --git a/tests/functional/test_vnc.py b/tests/functional/test_vnc.py
> index b769d3b268..32a81259e4 100755
> --- a/tests/functional/test_vnc.py
> +++ b/tests/functional/test_vnc.py
> @@ -14,22 +14,9 @@
>  from typing import List
>  
>  from qemu_test import QemuSystemTest
> -
> +from qemu_test.ports import Ports
>  
>  VNC_ADDR = '127.0.0.1'
> -VNC_PORT_START = 32768
> -VNC_PORT_END = VNC_PORT_START + 1024
> -
> -
> -def check_bind(port: int) -> bool:
> -    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
> -        try:
> -            sock.bind((VNC_ADDR, port))
> -        except OSError:
> -            return False
> -
> -    return True
> -
>  
>  def check_connect(port: int) -> bool:
>      with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
> @@ -40,18 +27,6 @@ def check_connect(port: int) -> bool:
>  
>      return True
>  
> -
> -def find_free_ports(count: int) -> List[int]:
> -    result = []
> -    for port in range(VNC_PORT_START, VNC_PORT_END):
> -        if check_bind(port):
> -            result.append(port)
> -            if len(result) >= count:
> -                break
> -    assert len(result) == count
> -    return result
> -
> -
>  class Vnc(QemuSystemTest):
>  
>      def test_no_vnc(self):
> @@ -90,8 +65,7 @@ def test_change_password(self):
>          self.vm.cmd('change-vnc-password',
>                      password='new_password')
>  
> -    def test_change_listen(self):
> -        a, b, c = find_free_ports(3)
> +    def do_test_change_listen(self, a, b, c):
>          self.assertFalse(check_connect(a))
>          self.assertFalse(check_connect(b))
>          self.assertFalse(check_connect(c))
> @@ -113,5 +87,11 @@ def test_change_listen(self):
>          self.assertTrue(check_connect(b))
>          self.assertTrue(check_connect(c))
>  
> +    def test_change_listen(self):
> +        with Ports() as ports:
> +            a, b, c = ports.find_free_ports(3)
> +            self.do_test_change_listen(a, b, c)
> +
> +
>  if __name__ == '__main__':
>      QemuSystemTest.main()
> -- 
> 2.47.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


