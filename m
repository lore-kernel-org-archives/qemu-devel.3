Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F53C54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 15:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHlL8-0001J1-Nd; Wed, 21 May 2025 11:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uHlL6-0001IZ-RW
 for qemu-devel@nongnu.org; Wed, 21 May 2025 11:26:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uHlL3-0003zo-TT
 for qemu-devel@nongnu.org; Wed, 21 May 2025 11:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747841195;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=FdYCJ0SUes3d1COc13cXXd6tCZhBFhk4CZT3W8rg7HI=;
 b=PBpgXazhbpHw1bjc83GbAGFaKdP3+uT8vY4IKfAy9Q+9T8tsVYMs/efECIQMB4JRiPIko5
 OLToo+F8KQPcDO+H46WMuFZ5UjXJyTbJyGEWySH9EkZbHd+bfbtnmA/cd9XqJetjhhEo1T
 xnJNvPfz3fNrHNcY2KMZyOqwf0IoTds=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82---A3kUbWOQOFBivW_i4Fbw-1; Wed,
 21 May 2025 11:26:31 -0400
X-MC-Unique: --A3kUbWOQOFBivW_i4Fbw-1
X-Mimecast-MFC-AGG-ID: --A3kUbWOQOFBivW_i4Fbw_1747841190
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 008DB1956095; Wed, 21 May 2025 15:26:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.129])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 223CE19560AB; Wed, 21 May 2025 15:26:27 +0000 (UTC)
Date: Wed, 21 May 2025 16:26:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] tests/functional: Set 'pc' machine type instead of
 relying on the default
Message-ID: <aC3woEjL0UxXYavt@redhat.com>
References: <20250521151323.155232-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250521151323.155232-1-thuth@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
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

On Wed, May 21, 2025 at 05:13:23PM +0200, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> In case the default machine has not been compiled into the QEMU
> binary, the vnc and the cpu_hotplug_props test are currently
> failing. Add a set_machine('pc') here to make sure that the tests
> are correctly skipped in case the machine is not available.

Hmmm, this is making this test be tied exclusively to x86.
If we can't ever omit the machine, then effectively all
our tests have to be tied to a specific target arch ?

What scenario did you find that 'pc' wasn't compiled
into QEMU  x86 targets ?  Shouldn't a new defualt
machine have been picked, or should our test harness
be picking a default for each targets if no 'set_machine'
call is present, to preserve target portability ?


> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/functional/test_pc_cpu_hotplug_props.py | 1 +
>  tests/functional/test_vnc.py                  | 4 ++++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/tests/functional/test_pc_cpu_hotplug_props.py b/tests/functional/test_pc_cpu_hotplug_props.py
> index 9d5a37cb170..2bed8ada023 100755
> --- a/tests/functional/test_pc_cpu_hotplug_props.py
> +++ b/tests/functional/test_pc_cpu_hotplug_props.py
> @@ -26,6 +26,7 @@
>  class OmittedCPUProps(QemuSystemTest):
>  
>      def test_no_die_id(self):
> +        self.set_machine('pc')
>          self.vm.add_args('-nodefaults', '-S')
>          self.vm.add_args('-smp', '1,sockets=2,cores=2,threads=2,maxcpus=8')
>          self.vm.add_args('-device', 'qemu64-x86_64-cpu,socket-id=1,core-id=0,thread-id=0')
> diff --git a/tests/functional/test_vnc.py b/tests/functional/test_vnc.py
> index 5c0ee5f9272..cbb01f00c7b 100755
> --- a/tests/functional/test_vnc.py
> +++ b/tests/functional/test_vnc.py
> @@ -31,6 +31,7 @@ def check_connect(port: int) -> bool:
>  class Vnc(QemuSystemTest):
>  
>      def test_no_vnc_change_password(self):
> +        self.set_machine('pc')
>          self.vm.add_args('-nodefaults', '-S')
>          self.vm.launch()
>  
> @@ -62,6 +63,7 @@ def launch_guarded(self):
>                  raise excp
>  
>      def test_change_password_requires_a_password(self):
> +        self.set_machine('pc')
>          self.vm.add_args('-nodefaults', '-S', '-vnc', ':1,to=999')
>          self.launch_guarded()
>          self.assertTrue(self.vm.qmp('query-vnc')['return']['enabled'])
> @@ -74,6 +76,7 @@ def test_change_password_requires_a_password(self):
>                           'Could not set password')
>  
>      def test_change_password(self):
> +        self.set_machine('pc')
>          self.vm.add_args('-nodefaults', '-S', '-vnc', ':1,to=999,password=on')
>          self.launch_guarded()
>          self.assertTrue(self.vm.qmp('query-vnc')['return']['enabled'])
> @@ -103,6 +106,7 @@ def do_test_change_listen(self, a, b, c):
>          self.assertTrue(check_connect(c))
>  
>      def test_change_listen(self):
> +        self.set_machine('pc')
>          with Ports() as ports:
>              a, b, c = ports.find_free_ports(3)
>              self.do_test_change_listen(a, b, c)
> -- 
> 2.49.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


