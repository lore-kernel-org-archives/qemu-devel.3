Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12019C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 20:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tziLy-0003ya-W7; Tue, 01 Apr 2025 16:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tziLs-0003vn-OP
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 16:36:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tziLr-0003gB-1y
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 16:36:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743539809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=di8HSrR0mgrjMG7FNCixnLGqj5YeO3OvVGaAGclDCos=;
 b=Bp2uVOWw7BpF1QFTzRwtcPk6jNGHjm2rKje1xFKRpj7Zve+isvAKB5+Iv/yw19bCj70aGb
 L2eeX5xJ0MWDcAcbskH3RTrOhnH2lidejiiCbEVRPKtcFhZWZvytg5s6l342/sVEgNmvAc
 f/wHaxi7NGGwm546F+NCowusdZhysg4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-eIpbfmCUMau76XYw4HEpzw-1; Tue,
 01 Apr 2025 16:36:46 -0400
X-MC-Unique: eIpbfmCUMau76XYw4HEpzw-1
X-Mimecast-MFC-AGG-ID: eIpbfmCUMau76XYw4HEpzw_1743539806
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF4A71955DCD; Tue,  1 Apr 2025 20:36:45 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.88])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F1F52195609D; Tue,  1 Apr 2025 20:36:42 +0000 (UTC)
Date: Tue, 1 Apr 2025 15:36:40 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 14/15] fuse: Implement multi-threading
Message-ID: <hd3fxmjcwp5nvaqtv6sgxftkmlvvrobgvyd5w25jlklimjvdja@gboyi4q4ggks>
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-13-hreitz@redhat.com>
 <20250327155557.GN37458@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327155557.GN37458@fedora>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Mar 27, 2025 at 11:55:57AM -0400, Stefan Hajnoczi wrote:
> On Tue, Mar 25, 2025 at 05:06:54PM +0100, Hanna Czenczek wrote:
> > FUSE allows creating multiple request queues by "cloning" /dev/fuse FDs
> > (via open("/dev/fuse") + ioctl(FUSE_DEV_IOC_CLONE)).
> > 
> > We can use this to implement multi-threading.
> > 
> > Note that the interface presented here differs from the multi-queue
> > interface of virtio-blk: The latter maps virtqueues to iothreads, which
> > allows processing multiple virtqueues in a single iothread.  The
> > equivalent (processing multiple FDs in a single iothread) would not make
> > sense for FUSE because those FDs are used in a round-robin fashion by
> > the FUSE kernel driver.  Putting two of them into a single iothread will
> > just create a bottleneck.
> 
> This text might be outdated. virtio-blk's new iothread-vq-mapping
> parameter provides the "array of iothreads" mentioned below and a way to
> assign virtqueues to those IOThreads.
> 

> > +++ b/qapi/block-export.json
> > @@ -179,12 +179,18 @@
> >  #     mount the export with allow_other, and if that fails, try again
> >  #     without.  (since 6.1; default: auto)
> >  #
> > +# @iothreads: Enables multi-threading: Handle requests in each of the
> > +#     given iothreads (instead of the block device's iothread, or the
> > +#     export's "main" iothread).  For this, the FUSE FD is duplicated so
> > +#     there is one FD per iothread.  (since 10.1)
> 
> This option isn't FUSE-specific but FUSE is the first export type to
> support it. Please add it to BlockExportOptions instead and refuse
> export creation when the export type only supports 1 IOThread.
> 
> Eric: Are you interested in implementing support for multiple IOThreads
> in the NBD export? I remember some time ago we talked about NBD
> multi-conn support, although maybe that was for the client rather than
> the server.

The NBD server already supports clients that make requests through
multiple TCP sockets, but right now, that server is not taking
advantage of iothreads to spread the TCP load.

And yes, I am in the middle of working on adding client NBD multi-conn
support (reviving Rich Jones' preliminary patches on what it would
take to have qemu open parallel TCP sockets to a supporting NBD
server), which also will use a round-robin approach (but here, the
round-robin is something we would code up in qemu, rather than the
behavior handed to us by the FUSE kernel layer).  Pinning specific
iothreads to a specific TCP socket may or may not make sense, but I
definitely want to have support for handing a pool of iothreads to an
NBD client that will be using multi-conn.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


