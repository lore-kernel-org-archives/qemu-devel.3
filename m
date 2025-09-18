Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA0FCAC59F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 08:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzA7M-0005ck-Ex; Thu, 18 Sep 2025 04:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzA7K-0005bx-Jl
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:35:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzA7D-0002Al-Nm
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758184539;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LCYo9DL/O2FKTWl5dhmAxETepbfKBpIdDCPBYIBfKSg=;
 b=h5udSBHy2E9ClAUVKYY/VKwvrz1ecVvt5WE6MUHTYjvtUCyytc9LqD2z+NmeFSMV9jvkXp
 5QTaBtXnPsH1TtULmeL3fjK/lmDTm9n5ARFQ+Fi5sCfymSlgdvEW0UNdgv4ED5SkYFd2XN
 mfAr3Lxj4OXaXT0bf+T19KBv93Uz2bE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-xk__1fZcOdev95Q8uLSAkA-1; Thu,
 18 Sep 2025 04:35:36 -0400
X-MC-Unique: xk__1fZcOdev95Q8uLSAkA-1
X-Mimecast-MFC-AGG-ID: xk__1fZcOdev95Q8uLSAkA_1758184534
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D2835180057F; Thu, 18 Sep 2025 08:35:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.161])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F378119560B8; Thu, 18 Sep 2025 08:35:28 +0000 (UTC)
Date: Thu, 18 Sep 2025 09:35:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, amit@kernel.org,
 armbru@redhat.com, eblake@redhat.com, eduardo@habkost.net,
 lvivier@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, mst@redhat.com, noh4hss@gmail.com,
 pbonzini@redhat.com, philmd@linaro.org, qemu-devel@nongnu.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, nsg@linux.ibm.com
Subject: Re: [PATCH v2] char-pty: add support for the terminal size
Message-ID: <aMvETd_dlUed-nlN@redhat.com>
References: <20250915163415.149190-1-maxbr@linux.ibm.com>
 <4c8e1ae5dd16d6ee4bcb42ed25d2987bc2c4a3cc.camel@gmail.com>
 <95142e7fd2a103cfb8d8bea9727117bfe952baec.camel@linux.ibm.com>
 <E0EFD1A6-09E9-481D-82FD-84FD4B45CA9B@gmail.com>
 <aMq4Ta4aPwRgDrxR@redhat.com>
 <0A6C8C3D-68E7-4E88-BEBE-D653135915DF@gmail.com>
 <aMrfGUfCSWnvkXzT@redhat.com>
 <e2f80c7ad10b8b6376144ba5d959a2ad4739f81c.camel@gmail.com>
 <aMr1sn-LU2f-w49o@redhat.com>
 <15cc6bcd675f2e20efe4fbd6332018a693122b9c.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15cc6bcd675f2e20efe4fbd6332018a693122b9c.camel@gmail.com>
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

On Wed, Sep 17, 2025 at 08:29:39PM +0200, Filip Hejsek wrote:
> On Wed, 2025-09-17 at 18:53 +0100, Daniel P. Berrangé wrote:
> > On Wed, Sep 17, 2025 at 07:11:03PM +0200, Filip Hejsek wrote:
> > > On Wed, 2025-09-17 at 17:17 +0100, Daniel P. Berrangé wrote:
> > > 
> > > > We shouldn't send any size info to the guest if the hsot backend
> > > > does not have it available.
> > > 
> > > Does that mean sending 0x0, or not sending anything at all? The later
> > > is tricky, because for non-multiport devices it's only really possible
> > > by not offering the feature bit, but we don't know upfront whether the
> > > size command will be used.

What are the semantics in the guest if we sent 0x0 as the size ?
AFAICT the virtio spec is silent on what '0x0' means.

It seems like it could conceivably have any behaviour, whether
a zero-size console, or a console clamped to 1x1 as a min size,
or a console reset to an arbitrary guest default like 80x24.


> > Nothing at all - is in no difference from current QEMU behaviour.
> 
> As I said, that's not possible with the current semantics of the resize
> command, as we would need to know upfront whether it is going to be
> used.
> 
> To get the exact same behavior as current QEMU, we would need to add
> some way to inform QEMU whether we want to use the resize command (e.g.
> device property).

That is usually unknowable at the time we spawn QEMU.

I'd say that the common case is for guests to get given a console
connected to a UNIX socket. Most of the time the console will not
be used. If it is, then we've no idea whether the client will be
something virtualization-unaware like a plain 'socat', or something
virtualization-aware like libvirt's  'virsh console'.

> Even then, depending on how you interpret the virtio spec, there would
> be a problem with multiport devices if port 0 didn't support size, but
> another port did. Not providing port 0 size can only be done by not
> offering the size feature bit, and then the question is, can you still
> send resize events for the other ports? The spec does not say either
> way.
>
> Note that getting the exact same behavior as current QEMU is still
> possible by disabling the console-size property on the virtio-serial
> device (but it applies to all ports).

Yes, it seems like the spec ties our hands here wrt multiple ports.

I didn't apprepreciate in my previous review that integrating this support
into QEMU was going to imply us /always/ informing the guest about the
requested console size for all ports, regardless of the backend.

I had been under the belief that we were only going to pass size info to
the guest, if the chardev was 'stdio', and for all other chardev backends
no size info would be passed unless we had issued the QMP resize command.

That we will always pass size info the guest regardless of the backend,
across all ports, changes my view about whether it is  reasonable to
enable resize by default given the known Linux guest bug.

The impact of the guest bug is just about tolerable if we were only going
to enable passing size information when the user had chosen 'stdio' backend
as that is relatively rarely used and mostly by ad-hoc dev usage where it
is perhaps easier for users to get a fixed guest kernel.

If we enable this for all ports though, regardless of backend, then I think
we're going to cause too much pain for users with the inverted rows/cols,
as its going to apply in every single deployment of QEMU using virtioconsole.

So IMHO we cannot enable this without explict user opt-in.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


