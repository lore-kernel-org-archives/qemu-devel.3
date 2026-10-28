Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA36606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GJqDYzHw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM8d3-00046R-Ni; Wed, 28 Oct 2026 14:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xM8d1-00045i-KI
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 14:44:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xM8cz-0007Hx-Qo
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 14:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793213040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BTUpCggkjd+KD19+aCjDD15QoX2Q6JYsr0NlZIA6/To=;
 b=GJqDYzHwPOoKiLDdjanaGngLl/YAp7W7v5jm/K61TzdhaInyLrYJ4TmPK5cW7wfHTJ4ySF
 2h9YfXQexT+XrgVkGwF46s+1FXGG5gF4OmWgKEWEqLYUKh32x/kYvS57CKOvAKdl747iTR
 YKsDX6S5C3cofaf/MdvGxJeQBuN9EPw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-0pzs7_S9ONKcWJUZhOqGYQ-1; Wed,
 28 Oct 2026 14:43:50 -0400
X-MC-Unique: 0pzs7_S9ONKcWJUZhOqGYQ-1
X-Mimecast-MFC-AGG-ID: 0pzs7_S9ONKcWJUZhOqGYQ_1793213027
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3FEBB19540CF; Wed, 28 Oct 2026 18:43:47 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 04C901956040; Wed, 28 Oct 2026 18:43:45 +0000 (UTC)
Date: Wed, 28 Oct 2026 14:43:45 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Tim Pambor <timpambor@gmail.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-block@nongnu.org, Raphael Norwitz <rnorwitz@nvidia.com>,
 Brad Smith <brad@comstyle.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH 5/8] vhost-user: enable frontends on any POSIX system
Message-ID: <20261028184345.GB1305253@shajnocz.csb>
References: <20261022-vhost-user-posix-v1-0-0bd4d450d23c@gmail.com>
 <20261022-vhost-user-posix-v1-5-0bd4d450d23c@gmail.com>
 <20261027192445.GC933537@shajnocz.csb>
 <auGyOJGAo8Qivhu8@sgarzare-redhat>
 <20261028123346.GA1217203@shajnocz.csb>
 <auHzRD3kwZlil74F@sgarzare-redhat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auHzRD3kwZlil74F@sgarzare-redhat>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 02:23:55PM +0100, Stefano Garzarella wrote:
> On Wed, Oct 28, 2026 at 08:33:46AM -0400, Stefan Hajnoczi wrote:
> > On Wed, Oct 28, 2026 at 09:32:05AM +0100, Stefano Garzarella wrote:
> > > On Tue, Oct 27, 2026 at 03:24:45PM -0400, Stefan Hajnoczi wrote:
> > > > On Thu, Oct 22, 2026 at 03:47:26PM +0200, Tim Pambor wrote:
> > > > > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> > > > > index 6e05c995f1..788913953d 100644
> > > > > --- a/hw/net/vhost_net.c
> > > > > +++ b/hw/net/vhost_net.c
> > > > > @@ -33,7 +33,13 @@
> > > > >  #include "standard-headers/linux/virtio_ring.h"
> > > > >  #include "hw/virtio/vhost.h"
> > > > >  #include "hw/virtio/virtio-bus.h"
> > > > > +#if defined(__linux__)
> > > > >  #include "linux-headers/linux/vhost.h"
> > > > > +#endif
> > > > > +
> > > > > +#ifndef VHOST_FILE_UNBIND
> > > > > +#define VHOST_FILE_UNBIND -1
> > > > > +#endif
> > > >
> > > > This constant is for hw/virtio/vhost.c's vhost_net_set_backend() API. It
> > > > should be defined along with that API. Define it alongside
> > > > vhost_net_set_backend() in hw/virtio/vhost.h and call it
> > > > VHOST_NET_FILE_UNBIND?
> > > >
> > > 
> > > That constant is defined by a Linux header (see
> > > linux-headers/linux/vhost.h). Are you suggesting to add another constant
> > > that is defined with VHOST_FILE_UNBIND on Linux and -1 on other platforms?
> > 
> > Looking again, we should probably just use -1 instead of a constant
> 
> Yep, this would be fine too.
> I don't remember why I did in this way, maybe to keep the diff smaller
> enough, but I don't have a strong opinion, we can avoid this ifndef and use
> -1 everywhere if you prefer that.

IMO VHOST_FILE_UNBIND doesn't belong in vhost_net.c, so it would be nice
to avoid the #ifndef.

> > since include/standard-headers/linux/vhost_types.h doesn't even define a
> > constant:
> > 
> >  struct vhost_vring_file {
> >  	unsigned int index;
> >  	int fd; /* Pass -1 to unbind from file. */
> > 
> >  };
> > 
> > It's strange that VHOST_FILE_UNBIND was defined in <linux/vhost.h>
> > instead of <linux/vhost_types.h> where struct vhost_vring_file is
> > defined.
> 
> Oh, VHOST_FILE_UNBIND was introduced after struct vhost_vring_file, with
> commit 776f395004d8 ("vhost_vdpa: Support config interrupt in vdpa").
> 
> But I agree that should be moved to vhost_types.h. BTW <linux/vhost.h>
> already includes <linux/vhost_types.h>, so maybe we can fix it without too
> much trouble.

Yes, that change seems safe and will improve things in the long term.

Stefan


