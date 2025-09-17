Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873BACAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 13:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uysGm-00083K-UY; Wed, 17 Sep 2025 09:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uysGi-00082R-KR
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 09:32:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uysGf-0002Nj-Mh
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 09:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758115934;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Nm9JHXX+cF1mL0tpmj5jv3MrE6LAhAhVmv2LEuFznPM=;
 b=S5nm4DL+pMMhLYskXe5JqzVilj+KAa1uqaiCYYJpIp8YQJf8LwsE46rCB03fDYgKltk2HI
 vhGcqwJWKsu/lANL0ArpNICxd4k+bU4Ud1RPyPbX6IIf/4Iq41CYvclcDbdRFi4+7K8bMc
 YffE2wK1Vcu+UAK1sRBMdcfx5FxQg7w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-sY3mVj0eNJ-CAO6EEDiFjQ-1; Wed,
 17 Sep 2025 09:32:10 -0400
X-MC-Unique: sY3mVj0eNJ-CAO6EEDiFjQ-1
X-Mimecast-MFC-AGG-ID: sY3mVj0eNJ-CAO6EEDiFjQ_1758115928
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 177621956094; Wed, 17 Sep 2025 13:32:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.195])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 78912300018D; Wed, 17 Sep 2025 13:32:01 +0000 (UTC)
Date: Wed, 17 Sep 2025 14:31:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, amit@kernel.org,
 armbru@redhat.com, eblake@redhat.com, eduardo@habkost.net,
 lvivier@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, mst@redhat.com, noh4hss@gmail.com,
 pbonzini@redhat.com, philmd@linaro.org, qemu-devel@nongnu.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, nsg@linux.ibm.com
Subject: Re: [PATCH v2] char-pty: add support for the terminal size
Message-ID: <aMq4Ta4aPwRgDrxR@redhat.com>
References: <20250915162535.147642-1-maxbr@linux.ibm.com>
 <20250915163415.149190-1-maxbr@linux.ibm.com>
 <4c8e1ae5dd16d6ee4bcb42ed25d2987bc2c4a3cc.camel@gmail.com>
 <95142e7fd2a103cfb8d8bea9727117bfe952baec.camel@linux.ibm.com>
 <E0EFD1A6-09E9-481D-82FD-84FD4B45CA9B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E0EFD1A6-09E9-481D-82FD-84FD4B45CA9B@gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

On Wed, Sep 17, 2025 at 03:09:50PM +0200, Filip Hejsek wrote:
> 
> 
> On September 17, 2025 11:39:55 AM GMT+02:00, Maximilian Immanuel Brandtner <maxbr@linux.ibm.com> wrote:
> > On Tue, 2025-09-16 at 00:02 +0200, Filip Hejsek wrote:
> > > On Mon, 2025-09-15 at 18:34 +0200, Maximilian Immanuel Brandtner
> > > wrote:
> > > > Update the terminal size upon SIGWINCH delivery.
> > > > 
> > > > Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
> > > 
> > > I don't think this will work, because SIGWINCH is only delivered for
> > > the process' controling terminal. Unfortunately I don't think there
> > > is
> > > any way to get size notifications for arbitrary terminal.
> > 
> > In that case there are two solutions:
> > 1. make qemu the controlling process of the pty (this has the
> > disadvantage of QEMU being quit when the pty is closed)
> 
> A bigger disadvantage is that a process can only have one controlling terminal, and a terminal can only be the controlling terminal for a single session (and only sends signals to the foreground process group of that session). It would require forking a process for each pty, and I don't even know if the master end can have its own session.
> 
> > 2. create a timer polling every eg 100ms to check if the winsize has
> > changed
> > 
> > I would go with the second approach then
> 
> Me too, the timer is a bit unfortunate, but it's probably the less bad option.

I don't think we want a timer polling for an situation that will very
rarely arise.  We already add the 'chardev_resize' QMP command, which is
a good enough way to kick QEMU to re-read the size.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


