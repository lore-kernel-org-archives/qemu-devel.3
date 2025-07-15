Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A22C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 15:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubhpg-0002If-MM; Tue, 15 Jul 2025 11:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubhKW-0006Qt-NP
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 11:12:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubhKS-00022Q-AS
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 11:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752592341;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RTRVF5i21L5rzHSATr+SXh0eP7xrSh6v8YyIXaD2aq8=;
 b=X/eHcMpA6pRElypGi0p6YBifXuH2fNvmLLXMy9CMaoVgyPC2yZgxhHeNCWqfp/bEL+Lark
 ODY3X9f5zsqMRIzt/CDPNhf1uSSw98F0D0EP5D9rywYU+5R8nibhx2mfYKwJF1ftu7ebPN
 iF6u8HaG/wEhnyobB4ve+bGroieytZc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596--DAFJFS2PWyvxYMhNSCfzg-1; Tue,
 15 Jul 2025 11:12:20 -0400
X-MC-Unique: -DAFJFS2PWyvxYMhNSCfzg-1
X-Mimecast-MFC-AGG-ID: -DAFJFS2PWyvxYMhNSCfzg_1752592338
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6DC61956057; Tue, 15 Jul 2025 15:12:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.173])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C39F719560A7; Tue, 15 Jul 2025 15:12:13 +0000 (UTC)
Date: Tue, 15 Jul 2025 16:12:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 09/14] functional: ensure sockets and files are closed
Message-ID: <aHZvye9EfVjsvDj2@redhat.com>
References: <20250715143023.1851000-1-berrange@redhat.com>
 <20250715143023.1851000-10-berrange@redhat.com>
 <97439ae2-5d37-49c2-a9d4-ff2d6aefee3b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97439ae2-5d37-49c2-a9d4-ff2d6aefee3b@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jul 15, 2025 at 05:03:07PM +0200, Thomas Huth wrote:
> On 15/07/2025 16.30, Daniel P. Berrangé wrote:
> > The multiprocess and virtio_gpu tests open sockets but then forget
> > to close them, which triggers resource leak warnings
> > 
> > The virtio_gpu test also fails to close a log file it opens.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   tests/functional/test_multiprocess.py | 3 +++
> >   tests/functional/test_virtio_gpu.py   | 2 ++
> >   2 files changed, 5 insertions(+)
> > 
> > diff --git a/tests/functional/test_multiprocess.py b/tests/functional/test_multiprocess.py
> > index 751cf10e63..92d5207b0e 100755
> > --- a/tests/functional/test_multiprocess.py
> > +++ b/tests/functional/test_multiprocess.py
> > @@ -83,6 +83,9 @@ def do_test(self, kernel_asset, initrd_asset,
> >                                             'cat /sys/bus/pci/devices/*/uevent',
> >                                             'PCI_ID=1000:0012')
> > +        proxy_sock.close()
> > +        remote_sock.close()
> > +
> >       def test_multiprocess(self):
> >           kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
> >           if self.arch == 'x86_64':
> > diff --git a/tests/functional/test_virtio_gpu.py b/tests/functional/test_virtio_gpu.py
> > index 81c9156d63..be96de24da 100755
> > --- a/tests/functional/test_virtio_gpu.py
> > +++ b/tests/functional/test_virtio_gpu.py
> > @@ -108,6 +108,7 @@ def test_vhost_user_vga_virgl(self):
> >               shell=False,
> >               close_fds=False,
> >           )
> > +        self._vug_log_file.close()
> 
> Maybe cleaner to close it at the end of the function?

This was the last place it was needed - just out of sight in the context
of the diff the file is passed to Popen() which connects it to stderr.
So nothing in this test may access the file after this point to avoid
concurent overlapping writes to the same file.

> 
>  Thomas
> 
> 
> >           self.vm.set_console()
> >           self.vm.add_args("-cpu", "host")
> > @@ -135,6 +136,7 @@ def test_vhost_user_vga_virgl(self):
> >                                             "features: +virgl +edid")
> >           self.vm.shutdown()
> >           qemu_sock.close()
> > +        vug_sock.close()
> >           vugp.terminate()
> >           vugp.wait()
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


