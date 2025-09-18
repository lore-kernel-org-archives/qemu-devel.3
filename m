Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0272CAC5A8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 09:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzAVP-0004lf-Vs; Thu, 18 Sep 2025 05:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzAV3-0004ce-FK
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 05:00:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzAUw-00055o-LL
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 05:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758186011;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mB8MovhUgF421C3VLirG2dtk1kEzpOiiERXV9z8X1Bs=;
 b=bZRZ0uyKF30O/Me0L7Pg0lIkMwB2HamXxyQ5L2OsEU9gWasbxK7wd0SNWTV29MFdAdfA7L
 6G2p4CUFaRI+jC7L1PCuuBPj6WgXcLGg3mTIK2scn5i5ZqatTeY24dSUAgCMlO2C8hgWfR
 M/Hr40DON6j7fk4SEUb2b4P8YUQeSno=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-nPDqe3V1OjygFlgiQdugsg-1; Thu,
 18 Sep 2025 05:00:01 -0400
X-MC-Unique: nPDqe3V1OjygFlgiQdugsg-1
X-Mimecast-MFC-AGG-ID: nPDqe3V1OjygFlgiQdugsg_1758186000
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE8AE1800294; Thu, 18 Sep 2025 08:59:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.161])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98E4A19541B0; Thu, 18 Sep 2025 08:59:54 +0000 (UTC)
Date: Thu, 18 Sep 2025 09:59:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
Cc: Filip Hejsek <filip.hejsek@gmail.com>, amit@kernel.org,
 armbru@redhat.com, eblake@redhat.com, eduardo@habkost.net,
 lvivier@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, mst@redhat.com, noh4hss@gmail.com,
 pbonzini@redhat.com, philmd@linaro.org, qemu-devel@nongnu.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, nsg@linux.ibm.com
Subject: Re: [PATCH v2] char-pty: add support for the terminal size
Message-ID: <aMvKBxaYLR065YKu@redhat.com>
References: <aMq4Ta4aPwRgDrxR@redhat.com>
 <0A6C8C3D-68E7-4E88-BEBE-D653135915DF@gmail.com>
 <aMrfGUfCSWnvkXzT@redhat.com>
 <e2f80c7ad10b8b6376144ba5d959a2ad4739f81c.camel@gmail.com>
 <aMr1sn-LU2f-w49o@redhat.com>
 <15cc6bcd675f2e20efe4fbd6332018a693122b9c.camel@gmail.com>
 <aMvETd_dlUed-nlN@redhat.com>
 <8979fb7f27b9dbe48f6419d515c4d33a77cefe0a.camel@linux.ibm.com>
 <aMvHScAtr3E_H2KB@redhat.com>
 <e6c30d2143147ebf285e69b4a786c0ed0f5212d2.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6c30d2143147ebf285e69b4a786c0ed0f5212d2.camel@linux.ibm.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 18, 2025 at 10:54:45AM +0200, Maximilian Immanuel Brandtner wrote:
> On Thu, 2025-09-18 at 09:48 +0100, Daniel P. Berrangé wrote:
> > On Thu, Sep 18, 2025 at 10:39:28AM +0200, Maximilian Immanuel
> > Brandtner wrote:
> > > On Thu, 2025-09-18 at 09:35 +0100, Daniel P. Berrangé wrote:
> > > > On Wed, Sep 17, 2025 at 08:29:39PM +0200, Filip Hejsek wrote:
> > > > > On Wed, 2025-09-17 at 18:53 +0100, Daniel P. Berrangé wrote:
> > > > > > On Wed, Sep 17, 2025 at 07:11:03PM +0200, Filip Hejsek wrote:
> > > > > > > On Wed, 2025-09-17 at 17:17 +0100, Daniel P. Berrangé
> > > > > > > wrote:
> > > > > > > 
> > > > > > > > We shouldn't send any size info to the guest if the hsot
> > > > > > > > backend
> > > > > > > > does not have it available.
> > > > > > > 
> > > > > > > Does that mean sending 0x0, or not sending anything at all?
> > > > > > > The
> > > > > > > later
> > > > > > > is tricky, because for non-multiport devices it's only
> > > > > > > really
> > > > > > > possible
> > > > > > > by not offering the feature bit, but we don't know upfront
> > > > > > > whether the
> > > > > > > size command will be used.
> > > > 
> > > > What are the semantics in the guest if we sent 0x0 as the size ?
> > > > AFAICT the virtio spec is silent on what '0x0' means.
> > > > 
> > > > It seems like it could conceivably have any behaviour, whether
> > > > a zero-size console, or a console clamped to 1x1 as a min size,
> > > > or a console reset to an arbitrary guest default like 80x24.
> > > 
> > > During testing the kernel resized the tty to 0x0 if VirtIO
> > > instructed
> > > the kernel to resize the tty to 0x0.
> > 
> > If the chardev backends are defaulting to 0x0 for everything except
> > the 'stdio' backend, then this series is surely going to break all
> > existing usage of virtio-console for non-stdio backends ?
> > 
> > What am I missing here ?
> 
> Most applications fall back to 80x24 if the terminal size is 0x0 so
> it's not as big of a dealbreaker as you might think.

I'm not convinced that its a good idea for QEMU to be relying on every
application to be doing that. I can forsee the bug reports from situations
where this doesn't happen and something ends up dividing by zero when
doing an aspect ratio calculation.  Yes, we could point to the app code
and call it buggy, but I think there's a strong case to be made that we
shouldn't have been sending 0x0 to begin with.

> However, I think it would be even better if the patch-set could be
> changed to account for that. After initializing the VirtIO console a
> resize event could be sent to set the initial size (80x24), which might
> later be changed or be left as is.

The problem with QEMU sending 80x24 instead of 0x0 is that the majority
of Linux guests will then treat that as 24x80 due to the historical bug
in Linux drivers. This will probably be even worse than the bugs we get
from sending 0x0.

> If the VIRTIO_CONSOLE_F_SIZE is negotiated(and this feature flag is
> necessary for multiport resize messages not to be ignored) QEMU is
> responsible for setting the initial terminal size.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


