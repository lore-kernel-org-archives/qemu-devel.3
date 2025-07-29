Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E00C83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 16:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugnMF-0001oZ-CD; Tue, 29 Jul 2025 12:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ugmyH-0008CN-G0
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 12:14:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ugmxr-0000GA-6u
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 12:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753805592;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=PMOUUnM82vHuegNESWpa8MUTEEj901US8wcaXTNC51Q=;
 b=Kh2qhkTDnTvacZX0GisAnEvZCHJzPSYLznQpsCw+++j768p+QponWRDaRfE4xOlp+yvXlk
 64yObSGD4On5xmMVJLFzubP6lSpysn+JVkizlV4DbCiCfd6Brf7VFHeFdVAGyLELLtBJKM
 hqkiYdBYr1iO8rkLScCw6PZ4VPTjj3o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-jOqeZUdzP6i1B0UORQngng-1; Tue,
 29 Jul 2025 12:13:11 -0400
X-MC-Unique: jOqeZUdzP6i1B0UORQngng-1
X-Mimecast-MFC-AGG-ID: jOqeZUdzP6i1B0UORQngng_1753805590
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA5E61800446; Tue, 29 Jul 2025 16:13:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.12])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD8581800288; Tue, 29 Jul 2025 16:13:06 +0000 (UTC)
Date: Tue, 29 Jul 2025 17:13:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, Mark Johnston <markj@freebsd.org>,
 Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] 9pfs: Add FreeBSD support
Message-ID: <aIjzD76zstbZcjtX@redhat.com>
References: <aIEGDjMex-DG-pmr@nuc>
 <1989897.fkXqvmx5VE@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1989897.fkXqvmx5VE@silver>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Jul 29, 2025 at 06:09:35PM +0200, Christian Schoenebeck wrote:
> On Wednesday, July 23, 2025 5:55:58 PM CEST Mark Johnston wrote:
> > This is largely derived from existing Darwin support.  FreeBSD
> > apparently has better support for *at() system calls so doesn't require
> > workarounds for a missing mknodat().  The implementation has a couple of
> > warts however:
> > - The extattr(2) system calls don't support anything akin to
> >   XATTR_CREATE or XATTR_REPLACE, so a racy workaround is implemented.
> > - Attribute names cannot begin with "user." on ZFS, so the prefix is
> >   trimmed off.  FreeBSD's extattr system calls sport an extra
> >   "namespace" identifier, and attributes created by the 9pfs backend
> >   live in the universal user namespace, so this seems innocent enough.
> > 
> > The 9pfs tests were verified to pass on the UFS, ZFS and tmpfs
> > filesystems.
> > 
> > Signed-off-by: Mark Johnston <markj@FreeBSD.org>
> 
> Hi Mark,
> 
> first off, the problem is I currently don't have a FreeBSD host to test and
> won't have the time in near future neither.
> 
> So what was your general intention regarding this patch, fire and forget, or
> would you be around for issues/patches regarding 9pfs FreeBSD support?
> 
> > ---
> >  fsdev/file-op-9p.h        |   6 +-
> >  fsdev/meson.build         |   2 +-
> >  hw/9pfs/9p-synth.c        |   2 +-
> >  hw/9pfs/9p-util-freebsd.c | 124 ++++++++++++++++++++++++++++++++++++++
> >  hw/9pfs/9p-util.h         |  19 ++++--
> >  hw/9pfs/9p.c              |  16 ++++-
> >  hw/9pfs/meson.build       |   2 +
> >  include/qemu/xattr.h      |   6 +-
> >  meson.build               |   8 +--
> >  9 files changed, 170 insertions(+), 15 deletions(-)
> >  create mode 100644 hw/9pfs/9p-util-freebsd.c

> > diff --git a/hw/9pfs/9p-util-freebsd.c b/hw/9pfs/9p-util-freebsd.c
> > new file mode 100644
> > index 0000000000..e649f79d4b
> > --- /dev/null
> > +++ b/hw/9pfs/9p-util-freebsd.c
> > @@ -0,0 +1,124 @@
> > +/*
> > + * 9p utilities (FreeBSD Implementation)
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> > + * See the COPYING file in the top-level directory.
> > + */
> 
> I think for new source files in QEMU the policy is to use
> SPDX-License-Identifier: ... now?

Yes, checkpatch.pl should complain both about the missing SPDX tag
and about this license blurb which would be redundant if SPDX were
present.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


