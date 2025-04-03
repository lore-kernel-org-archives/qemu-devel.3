Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3074FC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 18:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Or0-0002x9-BZ; Thu, 03 Apr 2025 13:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u0Oqy-0002wi-D5
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 13:59:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u0Oqu-0005oB-EQ
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 13:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743703183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iE7pcfrnVRmsbuH2BlTOchkPIiQdcfvJKT85pCoHUk4=;
 b=SS3eOWZHUhfZQgroxTxYH3hUYLXrUa+yzaCaDnpZwM6tuNZV7/117oxYLG27CIx4zMSTis
 57+B90EbstXK0PiRKgcWq0xoA2poD4xCkTRQx8i8QiyVJngHMr9K4Dicrstwhss+PhDr+u
 nWlbSR870X9ahwcVqCUWXQQ1pcUMSj4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-zCWNs58sMYCp9UYdHLLjag-1; Thu,
 03 Apr 2025 13:59:40 -0400
X-MC-Unique: zCWNs58sMYCp9UYdHLLjag-1
X-Mimecast-MFC-AGG-ID: zCWNs58sMYCp9UYdHLLjag_1743703179
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 64819180025B; Thu,  3 Apr 2025 17:59:39 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.8])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 572E51801752; Thu,  3 Apr 2025 17:59:35 +0000 (UTC)
Date: Thu, 3 Apr 2025 12:59:33 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 14/15] fuse: Implement multi-threading
Message-ID: <ffuld2pgrw7tfrbbur3qoyu4vokrtj2m5z4offqan276gtziiw@cwyb3j4i4ktp>
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-13-hreitz@redhat.com>
 <20250327155557.GN37458@fedora>
 <hd3fxmjcwp5nvaqtv6sgxftkmlvvrobgvyd5w25jlklimjvdja@gboyi4q4ggks>
 <20250402132033.GA304512@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402132033.GA304512@fedora>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.649,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Apr 02, 2025 at 09:20:33AM -0400, Stefan Hajnoczi wrote:
> > > Eric: Are you interested in implementing support for multiple IOThreads
> > > in the NBD export? I remember some time ago we talked about NBD
> > > multi-conn support, although maybe that was for the client rather than
> > > the server.
> > 
> > The NBD server already supports clients that make requests through
> > multiple TCP sockets, but right now, that server is not taking
> > advantage of iothreads to spread the TCP load.
> > 
> > And yes, I am in the middle of working on adding client NBD multi-conn
> > support (reviving Rich Jones' preliminary patches on what it would
> > take to have qemu open parallel TCP sockets to a supporting NBD
> > server), which also will use a round-robin approach (but here, the
> > round-robin is something we would code up in qemu, rather than the
> > behavior handed to us by the FUSE kernel layer).  Pinning specific
> > iothreads to a specific TCP socket may or may not make sense, but I
> > definitely want to have support for handing a pool of iothreads to an
> > NBD client that will be using multi-conn.
> 
> Here I'm asking Hanna to make the "iothreads" export parameter generic
> for all export types (not just for FUSE). Do you think that the NBD
> export will be able to use the generic parameter or would you prefer an
> NBD-specific export parameter?

I would prefer to use a generic parameter. NBD will already need a
specific parameter on whether to attempt to use multiple TCP sockets
if the server advertises multi-conn.  But how to map those TCP sockets
to iothreads feels like a better fit for a generic iothreads; and
perhaps the NBD parameter can also be made smart enough to auto-set
the number of TCP sockets based on the number of available iothreads
if there is no explicit override.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


