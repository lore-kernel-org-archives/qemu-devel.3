Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1799CA0ED3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 07:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slkCq-0006Ua-TP; Wed, 04 Sep 2024 03:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1slkCp-0006U6-NM
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 03:13:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1slkCn-0004P8-8T
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 03:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725434007;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ukw6/zzlE1EDLQwBaifqbwmT9by9oZAgte8hve1TF9Y=;
 b=TQkHE+prHtaB8+0w+A5/6fLn/rKrMW8inu5AMoLHdHuHv8g4bd9XXrOiaSXR6iTrKseHKp
 eXSFpFZwbuqez+QUuLIOA6cYvmLiJdOgXhdp8QS1VcCLdsTMfox/ggEwYwDxhpQb1KTe8L
 99hkqvJfo6xqAfvX8xu7ic3NyP138OQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-jnFbFS6wNhStfpKHtk9hBw-1; Wed,
 04 Sep 2024 03:13:23 -0400
X-MC-Unique: jnFbFS6wNhStfpKHtk9hBw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DADB41955F41; Wed,  4 Sep 2024 07:13:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69B8219560A3; Wed,  4 Sep 2024 07:13:20 +0000 (UTC)
Date: Wed, 4 Sep 2024 08:13:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/functional/test_vnc: Reduce raciness in
 find_free_ports()
Message-ID: <ZtgIec4AEpmXO9WO@redhat.com>
References: <20240903143553.16877-1-philmd@linaro.org>
 <ZtciHTFGPtUlMKM_@redhat.com>
 <73ba8035-9fa6-440e-9ca9-0b6934525489@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73ba8035-9fa6-440e-9ca9-0b6934525489@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Sep 04, 2024 at 08:20:12AM +0200, Thomas Huth wrote:
> On 03/09/2024 16.50, Daniel P. Berrangé wrote:
> > On Tue, Sep 03, 2024 at 04:35:53PM +0200, Philippe Mathieu-Daudé wrote:
> > > Pass the port range as argument. In order to reduce races
> > > when looking for free ports, use a per-target per-process
> > > base port (based on the target built-in hash).
> > > 
> > > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > ---
> > > Based-on: <20240830133841.142644-33-thuth@redhat.com>
> > > ---
> > >   tests/functional/test_vnc.py | 12 ++++++++----
> > >   1 file changed, 8 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/tests/functional/test_vnc.py b/tests/functional/test_vnc.py
> > > index b769d3b268..508db0709d 100755
> > > --- a/tests/functional/test_vnc.py
> > > +++ b/tests/functional/test_vnc.py
> > > @@ -10,6 +10,7 @@
> > >   # This work is licensed under the terms of the GNU GPL, version 2 or
> > >   # later.  See the COPYING file in the top-level directory.
> > > +import os
> > >   import socket
> > >   from typing import List
> > > @@ -18,7 +19,6 @@
> > >   VNC_ADDR = '127.0.0.1'
> > >   VNC_PORT_START = 32768
> > > -VNC_PORT_END = VNC_PORT_START + 1024
> > >   def check_bind(port: int) -> bool:
> > > @@ -41,9 +41,10 @@ def check_connect(port: int) -> bool:
> > >       return True
> > > -def find_free_ports(count: int) -> List[int]:
> > > +# warning, racy function
> > > +def find_free_ports(portrange, count: int) -> List[int]:
> > >       result = []
> > > -    for port in range(VNC_PORT_START, VNC_PORT_END):
> > > +    for port in portrange:
> > >           if check_bind(port):
> > >               result.append(port)
> > >               if len(result) >= count:
> > > @@ -91,7 +92,10 @@ def test_change_password(self):
> > >                       password='new_password')
> > >       def test_change_listen(self):
> > > -        a, b, c = find_free_ports(3)
> > > +        per_arch_port_base = abs((os.getpid() + hash(self.arch)) % (10 ** 4))
> > > +        port_start = VNC_PORT_START + per_arch_port_base
> > > +        port_stop = port_start + 100
> > > +        a, b, c = find_free_ports(range(port_start, port_stop), 3)
> > >           self.assertFalse(check_connect(a))
> > >           self.assertFalse(check_connect(b))
> > >           self.assertFalse(check_connect(c))
> > 
> > As your comment says, this is still racey, and its also not too
> > nice to read & understand this logic. How about we just make
> > test_vnc.py be serialized wrt itself ?
> 
> We'll likely have more tests that need a free port in the future...
> tests/avocado/migration.py and tests/avocado/reverse_debugging.py use
> find_free_ports(), too, so we should maybe think of a logic that avoids
> clashes between different tests, too.

Create a context manager that holds a fcntl lockfile on disk, while
giving you a free port ?

   class FreePort:
     def __enter__(self):
        self.num = find_free_port()
	..acquire fcntl lock...

     def __exit__(self):
        ...release fcntl lock..

Letting tests do

  with FreePort() as port:
      ..do some test that uses port.num....


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


