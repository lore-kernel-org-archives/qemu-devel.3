Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D41CFD376
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 13:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOyMp-0005Cl-HM; Fri, 28 Nov 2025 08:18:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vOyMn-0005Cc-Vz
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 08:18:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vOyMm-00085P-B4
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 08:18:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764335907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0jPGA8K7KeUqFd2jncD5ANdSET6/PmUHcSgMce5DqKY=;
 b=C1+wmG6HiPlGmvnUb85Z/ib2sbQL8FLGu4mOAW+tnf4ypCqgKCHn9BICn3SwQpgQQMpU54
 UX3eQ//7pHgjesGBe+kG0swz8Hksk9t1HTGS4sjSAfhBpf2WIwfYZapC4juNCKiqkdGHcl
 ZroJXYDE4jNikY5WvU0IaxXBSSyz+bY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-aXRkxiGFMVWFkHXOAJW-Fg-1; Fri,
 28 Nov 2025 08:18:25 -0500
X-MC-Unique: aXRkxiGFMVWFkHXOAJW-Fg-1
X-Mimecast-MFC-AGG-ID: aXRkxiGFMVWFkHXOAJW-Fg_1764335904
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7B521800250; Fri, 28 Nov 2025 13:18:23 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BFF7830001A4; Fri, 28 Nov 2025 13:18:20 +0000 (UTC)
Date: Fri, 28 Nov 2025 14:18:18 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, peterx@redhat.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, den@virtuozzo.com
Subject: Re: [PATCH 4/4] scripts/qemugdb: coroutine: Add option for obtaining
 detailed trace in coredump
Message-ID: <aSmhGomQvDyiQ57z@redhat.com>
References: <20251125142105.448289-1-andrey.drobyshev@virtuozzo.com>
 <20251125142105.448289-5-andrey.drobyshev@virtuozzo.com>
 <aSggPDzhqem_jxnR@redhat.com> <aSghvhrBXL0xxL1a@redhat.com>
 <ef51cf63-16b1-48c4-8070-0acaf618ef3c@virtuozzo.com>
 <aSh-1_qLRNGCzV9H@redhat.com>
 <ce8c9c03-5dfe-4f0f-8394-e9ba95f0f09a@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce8c9c03-5dfe-4f0f-8394-e9ba95f0f09a@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 28.11.2025 um 13:24 hat Andrey Drobyshev geschrieben:
> On 11/27/25 6:39 PM, Kevin Wolf wrote:
> > Am 27.11.2025 um 15:31 hat Andrey Drobyshev geschrieben:
> >> As for reflink copy, this might've been a great solution.  However, it
> >> would largely depend on the FS used.  E.g. in my system coredumpctl
> >> places uncompressed coredump at /var/tmp, which is mounted as ext4.  And
> >> in this case:
> >>
> >> # cp --reflink /var/tmp/coredump-MQCZQc /root
> >> cp: failed to clone '/root/coredump-MQCZQc' from
> >> '/var/tmp/coredump-MQCZQc': Invalid cross-device link
> >>
> >> # cp --reflink /var/tmp/coredump-MQCZQc /var/tmp/coredump.ref
> >> cp: failed to clone '/var/tmp/coredump.ref' from
> >> '/var/tmp/coredump-MQCZQc': Operation not supported
> >>
> >> Apparently, ext4 doesn't support reflink copy. xfs and btrfs do.  But I
> >> guess our implementation better be FS-agnostic.
> > 
> > Yes, we might still need a slow copy fallback for those filesystems,
> > i.e. essentially a 'cp --reflink=auto'. For myself, coredumps will
> > generally live on XFS, so I would benefit from creating that copy in the
> > same filesystem where the coredump lives, and for you it shouldn't hurt
> > at least.
> > 
> > Another thought... it's a bit crazy, but... we're QEMU, we have our own
> > tools for this. We could create a qcow2 overlay for the coredump and
> > export it using FUSE! :-D (Probably not very practical because you need
> > the right paths for the binaries, but I had to mention it.)
> > 
> > Kevin
> 
> We can surely add reflink copying as a fast path option which we try
> first.  That's cheap to implement.  The real issue is designing a
> sensible fallback approach.

I mean, as far as I am concerned, you can keep what you already have as
the fallback approach. Reflink copy if possible, and otherwise a slow
full copy.

Or if the coredump can be written to, you could do the in-place editing,
though I would save the original content in a file that could survive a
crash. And after finishing the operation, the original content
definitely should be written back.

> As for creating an overlay... That's an interesting option but it would
> require everybody who wants to use this stuff configure their QEMU build
> with --enable-fuse.  We, for instance, don't have it enabled in our
> builds, as I'm sure many others.
> 
> Of course we can think of an NBD export for such an overlay instead of
> FUSE.  But it'll then require root user to write to /dev/nbd0.  Also not
> very acceptable.
> 
> Quick overlayfs mount with lowerdir=/var/tmp could also solve this.  But
> again, root is required.  Not good.
> 
> So the most robust option, I guess, is the one suggested by Daniel:
> copying some kind of minimal viable coredump part/range instead of the
> whole file, which is just enough for producing valid backtrace.  The
> only thing left is figuring out which part to copy.  That might require
> some tricky ELF structure parsing.

All of these solutions are interesting, but honestly feel a bit too
complex for a simple debugging script.

Kevin


