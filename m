Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1903C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 15:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh8xC-0007s2-Vt; Wed, 30 Jul 2025 11:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uh7uR-0008VM-AN
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 10:36:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uh7uO-0002gD-Li
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 10:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753886154;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=/xw8QNpRzTMh9qHMU9PIXySRj6XSjJ34udkk8DtVAHw=;
 b=VX6pIKplYVdAmV8G6/a5odspPgB/m9oG97OUN5xff98dnCxpv/qgQ1BPuLI16UEY7hAOV1
 Jjc3R4FYfMjN2HrzAOinyIzyvmI9NlA0FGKOEt2/sgssoHAkDyGs7hFhW3nfs5KBBSZGnF
 xbN7teT3v06jisbSp76NZer5w6dhjCg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-vSrJIUhOPrux-m2E_gYTaQ-1; Wed,
 30 Jul 2025 10:35:50 -0400
X-MC-Unique: vSrJIUhOPrux-m2E_gYTaQ-1
X-Mimecast-MFC-AGG-ID: vSrJIUhOPrux-m2E_gYTaQ_1753886149
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA27F19560B5; Wed, 30 Jul 2025 14:35:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.92])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0FEE1800242; Wed, 30 Jul 2025 14:35:45 +0000 (UTC)
Date: Wed, 30 Jul 2025 15:35:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Mark Johnston <markj@freebsd.org>
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] 9pfs: Add FreeBSD support
Message-ID: <aIotvmUKh-jtSKWO@redhat.com>
References: <aIEGDjMex-DG-pmr@nuc> <1989897.fkXqvmx5VE@silver>
 <aIos9lb1dBuDBq2E@nuc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aIos9lb1dBuDBq2E@nuc>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Jul 30, 2025 at 10:32:22AM -0400, Mark Johnston wrote:
> On Tue, Jul 29, 2025 at 06:09:35PM +0200, Christian Schoenebeck wrote:
> > On Wednesday, July 23, 2025 5:55:58 PM CEST Mark Johnston wrote:
> > > This is largely derived from existing Darwin support.  FreeBSD
> > > apparently has better support for *at() system calls so doesn't require
> > > workarounds for a missing mknodat().  The implementation has a couple of
> > > warts however:
> > > - The extattr(2) system calls don't support anything akin to
> > >   XATTR_CREATE or XATTR_REPLACE, so a racy workaround is implemented.
> > > - Attribute names cannot begin with "user." on ZFS, so the prefix is
> > >   trimmed off.  FreeBSD's extattr system calls sport an extra
> > >   "namespace" identifier, and attributes created by the 9pfs backend
> > >   live in the universal user namespace, so this seems innocent enough.
> > > 
> > > The 9pfs tests were verified to pass on the UFS, ZFS and tmpfs
> > > filesystems.
> > > 
> > > Signed-off-by: Mark Johnston <markj@FreeBSD.org>
> > 
> > Hi Mark,
> > 
> > first off, the problem is I currently don't have a FreeBSD host to test and
> > won't have the time in near future neither.
> > 
> > So what was your general intention regarding this patch, fire and forget, or
> > would you be around for issues/patches regarding 9pfs FreeBSD support?
> 
> Thank you for taking a look.
> 
> I'll certainly be around to help deal with issues and patches relating
> to 9pfs+FreeBSD hosts.  It's hard to prove that, but for what it's worth
> I use QEMU fairly extensively for FreeBSD development when I can't use
> the native hypervisor, and that's not likely to change anytime soon.
> 
> Would adding myself to MAINTAINERS for virtio-9pfs (or a new
> virtio-9pfs-freebsd category) be appropriate in that case?

> > > diff --git a/hw/9pfs/9p-util-freebsd.c b/hw/9pfs/9p-util-freebsd.c
> > > new file mode 100644
> > > index 0000000000..e649f79d4b
> > > --- /dev/null
> > > +++ b/hw/9pfs/9p-util-freebsd.c
> > > @@ -0,0 +1,124 @@
> > > +/*
> > > + * 9p utilities (FreeBSD Implementation)
> > > + *
> > > + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> > > + * See the COPYING file in the top-level directory.
> > > + */
> > 
> > I think for new source files in QEMU the policy is to use
> > SPDX-License-Identifier: ... now?
> 
> checkpatch.pl does complain about that, yes, but it also qualifies the
> warning with, "unless this file was copied from existing code already
> having such text."  I used 9p-util-darwin.c as a starting point for this
> file, so kept the existing license text.  I can certainly change it
> though.

In that case, this is fine as is.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


