Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0447C021A0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 20:53:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiJit-0003Dd-3p; Wed, 12 Feb 2025 15:52:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tiJiq-0003D6-Un
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 15:52:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tiJip-0004Cv-9y
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 15:52:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739393558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Th+AYWX8dvC10bw3Qem3zOgUmNVIqvBGdHVHNvvXuyQ=;
 b=JZL3PqC62wgBKDnHOqVei/4B0oioZAW+XAkWEZ5Jvn3QTinxacvlEwu3VvdekwlgJ7irRi
 uq92QxU2VLss1jHIbcR8SxOocUM480+m77kIx3Gs3aXQcM2Iy3cgxBEJ1Awj96WjOMrXpu
 snLK70Zhr7x+dyUF1qFRRIl8urqVWQ0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-TYmlOIoNMCmbOYBd75rLZQ-1; Wed,
 12 Feb 2025 15:52:34 -0500
X-MC-Unique: TYmlOIoNMCmbOYBd75rLZQ-1
X-Mimecast-MFC-AGG-ID: TYmlOIoNMCmbOYBd75rLZQ_1739393552
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F996195608B; Wed, 12 Feb 2025 20:52:31 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.168])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30C3E19560A3; Wed, 12 Feb 2025 20:52:27 +0000 (UTC)
Date: Wed, 12 Feb 2025 21:52:25 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com,
 manos.pitsidianakis@linaro.org, qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 09/11] rust/block: Add read support for block drivers
Message-ID: <Z60KCVt38X59J9TN@redhat.com>
References: <20250211214328.640374-1-kwolf@redhat.com>
 <20250211214328.640374-10-kwolf@redhat.com>
 <f515a321-8f76-4d94-97d5-309fba14aa85@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f515a321-8f76-4d94-97d5-309fba14aa85@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Am 12.02.2025 um 16:05 hat Paolo Bonzini geschrieben:
> On 2/11/25 22:43, Kevin Wolf wrote:
> > +/// A request to a block driver
> > +pub enum Request {
> > +    Read { offset: u64, len: u64 },
> > +}
> > +
> 
> Maybe add flags already?
> > +#[allow(dead_code)]
> > +pub enum MappingTarget {
> > +    /// The described blocks are unallocated. Reading from them yields zeros.
> > +    Unmapped,
> > +
> > +    /// The described blocks are stored in a child node.
> > +    Data {
> > +        /// Child node in which the data is stored
> > +        node: (),
> 
> Make it already a *mut BlockDriverState, or *mut BdrvChild?  Or are you worried of
> irritating the borrow checker? :)

Mostly I just didn't need it yet and was too lazy to think about the
details.

The right type would probably be Arc<driver::BdrvChild> (which contains
the raw *mut pointer). But I haven't thought much about how this plays
together with graph changes.

> > +        /// Offset in the child node at which the data is stored
> > +        offset: u64,
> > +    },
> > +}
> > +
> > +/// A mapping for a number of contiguous guest blocks
> > +pub struct Mapping {
> > +    /// Offset of the mapped blocks from the perspective of the guest
> > +    pub offset: u64,
> > +    /// Length of the mapping in bytes
> > +    pub len: u64,
> > +    /// Where the data for the described blocks is stored
> > +    pub target: MappingTarget,
> > +}
> > +
> >   /// A trait for writing block drivers.
> >   ///
> >   /// Types that implement this trait can be registered as QEMU block drivers using the
> > @@ -37,6 +72,11 @@ unsafe fn open(
> >       /// Returns the size of the image in bytes
> >       fn size(&self) -> u64;
> > +
> > +    /// Returns the mapping for the first part of `req`. If the returned mapping is shorter than
> > +    /// the request, the function can be called again with a shortened request to get the mapping
> > +    /// for the remaining part.
> > +    async fn map(&self, req: &Request) -> io::Result<Mapping>;
> 
> I am not sure I like the idea of making this the only way to do a read.

We'll clearly need a way for drivers to have explicit functions when the
blocks aren't just mapped to somewhere else, e.g. with compression or
encryption. (My idea for that was that it would be another MappingTarget
branch.)

But using map() as the primary interface is intentional as it enables a
few things, even though this isn't visible in the code yet. Of course,
that basically every block driver duplicates the same loop is a reason
to unify it, but as you say there are other ways to do that.

One thing map() can do in the common case is provide the caller just a
list of mappings to a file descriptor and an offset. This may in the
future allow some block exports like ublk or fuse to use zero copy
operations. You can't do that if the block driver already does an
explicit read into a buffer.

You can cache mappings outside of the block driver and even of QEMU.
Block exports could tell the kernel that it shouldn't even bother with
going to userspace if a request can be completed using a cached mapping.
Two hosts with shared storage could access the same qcow2 image without
one of them sending all data across the network (like we did in KubeSAN
with NBD), but it's enough if metadata (= mappings) are synchronised.

So I think this is a useful interface to have, even if we don't know
which of the possibilities we'll actually make use of. And it should be
the primary interface, because if you want to do caching, then cache
invalidation must be done properly by block drivers, which is more
likely to go wrong if it's just an additional interface that isn't
normally used.

Kevin


