Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE48BE77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 12:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV8ud-0007Bi-00; Tue, 07 Jan 2025 07:42:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tV8uY-0007BE-Db
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 07:42:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tV8uV-0004E7-RV
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 07:42:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736253734;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qfVJMxLX0yK3zBExqW0wBPdz2eGbMTcGtktm1jzQd1o=;
 b=Ns80one5/gJrV4O46dJNTvo5YRCGpvQqJp/CFXKpdoeNBPjL44ehaSmxxqY7rsHpXs7ecL
 8IbFTlnJM4hTw1bIgUrCqawkZY+nMYVOgxUUFzxMAeXhIXy7zHh2wACIXkXFyEzWjNBg/q
 eraJw9t1TpWvRb7KGtiU0cWGg5mUZwo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-tCWu2IlBPvaiGG-YC0EGQg-1; Tue,
 07 Jan 2025 07:42:10 -0500
X-MC-Unique: tCWu2IlBPvaiGG-YC0EGQg-1
X-Mimecast-MFC-AGG-ID: tCWu2IlBPvaiGG-YC0EGQg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C0F51956046; Tue,  7 Jan 2025 12:42:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.64])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B9261955EB4; Tue,  7 Jan 2025 12:42:07 +0000 (UTC)
Date: Tue, 7 Jan 2025 12:42:03 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] tests/functional/test_x86_64_hotplug_cpu: Fix race
 condition during unplug
Message-ID: <Z30hG1PxfEPjq9Td@redhat.com>
References: <20250107115245.52755-1-thuth@redhat.com>
 <Z30WlysSx4-L-YSs@redhat.com>
 <ab03dc76-14fe-4da3-97b9-b7da5bb154d0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab03dc76-14fe-4da3-97b9-b7da5bb154d0@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jan 07, 2025 at 01:03:52PM +0100, Thomas Huth wrote:
> On 07/01/2025 12.57, Daniel P. Berrangé wrote:
> > On Tue, Jan 07, 2025 at 12:52:45PM +0100, Thomas Huth wrote:
> > > When unplugging the CPU, the test tries to check for a successful
> > > unplug by changing to the /sys/devices/system/cpu/cpu1 directory
> > > to see whether that fails. However, the "cd" could be faster than
> > > the unplug operation in the kernel, so there is a race condition
> > > and the test sometimes fails here.
> > > Fix it by trying to change the directory in a loop until the the
> > > CPU has really been unplugged.
> > > 
> > > Reported-by: Stefan Hajnoczi <stefanha@gmail.com>
> > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > ---
> > >   tests/functional/test_x86_64_hotplug_cpu.py | 6 ++++--
> > >   1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tests/functional/test_x86_64_hotplug_cpu.py b/tests/functional/test_x86_64_hotplug_cpu.py
> > > index b1d5156c72..7b9200ac2e 100755
> > > --- a/tests/functional/test_x86_64_hotplug_cpu.py
> > > +++ b/tests/functional/test_x86_64_hotplug_cpu.py
> > > @@ -59,11 +59,13 @@ def test_hotplug(self):
> > >                                             'cd /sys/devices/system/cpu/cpu1',
> > >                                             'cpu1#')
> > > +        exec_command_and_wait_for_pattern(self, 'cd ..', prompt)
> > 
> > Is this actually needed ? Are we keeping the CPU from being unplugged by
> > being in that dir ? If so, why isn't it also needed in the while loop
> > below ?
> 
> I added it to make the console output less confusing (otherwise it's still
> shown in the prompt after the CPU has been unplugged)... but I can also
> remove this line again if you prefer it?

No, i'm not that fussed.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


