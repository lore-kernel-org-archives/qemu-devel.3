Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36CDACD6E5C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 13:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJXH5-0006Yv-MG; Thu, 13 Nov 2025 08:22:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vJX8h-0005Zu-1H
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 08:13:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vJX8e-000524-Oe
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 08:13:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763039602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OrmjmrqMwcVTOHLZ0KRkSQMHceDpq5Elz/ehEaYDyeg=;
 b=EuJqWyoztEIRe4l01cMdiKg1XFhMTlflootkE0qUVJ/YT3n6RZgkIg6WLpYpOqZx2txY+i
 zGScWGx8YPgrM21RJJlMxv1u8mj/4A8zERaXeAOp8iaPLyTyueJ27b3vr5/Ly3ryAwTpqi
 6YChjwgdho8h3aQUTYVxBzSczbiLTF4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-_91FH27jMeqz8Anw1OqWgQ-1; Thu,
 13 Nov 2025 08:13:21 -0500
X-MC-Unique: _91FH27jMeqz8Anw1OqWgQ-1
X-Mimecast-MFC-AGG-ID: _91FH27jMeqz8Anw1OqWgQ_1763039600
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6925F19560A5; Thu, 13 Nov 2025 13:13:20 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.162])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 81A1919560B9; Thu, 13 Nov 2025 13:13:18 +0000 (UTC)
Date: Thu, 13 Nov 2025 14:13:15 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: =?iso-8859-1?Q?Cl=E9ment?= Chigot <chigot@adacore.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH 0/5] block/vvfat: introduce "size" option
Message-ID: <aRXZa8LhpSHJiqLm@redhat.com>
References: <20250903075721.77623-1-chigot@adacore.com>
 <20251112123844.GA14264@redhat.com> <aRWZr7tjdqKPlCjh@redhat.com>
 <20251113091351.GA1427@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251113091351.GA1427@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 13.11.2025 um 10:13 hat Richard W.M. Jones geschrieben:
> On Thu, Nov 13, 2025 at 09:41:19AM +0100, Kevin Wolf wrote:
> > Am 12.11.2025 um 13:38 hat Richard W.M. Jones geschrieben:
> > > On Wed, Sep 03, 2025 at 09:57:16AM +0200, Clément Chigot wrote:
> > > > The main goal of this series is to introduce a new option "size" within
> > > > the vvfat backend (patch 5). It allows more control over SD cards' size.
> > > > The value for "Number of Heads" and "Sectors per track" are based on SD
> > > > specifications Part 2.
> > > > 
> > > > This series also includes minor patches:
> > > >  - patch 1 introduces another option to remove the Master Boot Record
> > > >    (this is mandatory for QNX)
> > > >  - patch 2-4 are minor improvements easing the introducing of "size"
> > > >    option
> > > > 
> > > > This was tested on with a aarch64-linux kernel taken from
> > > > functional/aarch64/test-virt and on aarch64-qnx over raspi4b with a
> > > > workaround, not included here (the SD bus must be associated to the EMMC2
> > > > port instead of through GPIOs).
> > > > 
> > > > Clément Chigot (5):
> > > >   vvfat: introduce no-mbr option
> > > >   vvfat: move fat_type check prior to size setup
> > > >   vvfat: add a define for SECTOR_SIZE
> > > >   vvfat: move size parameters within driver structure
> > > >   vvfat: add support for "size" options
> > > > 
> > > >  block/vvfat.c | 279 ++++++++++++++++++++++++++++++++++++++------------
> > > >  1 file changed, 213 insertions(+), 66 deletions(-)
> > > 
> > > (Thanks Markus for bringing this thread up)
> > > 
> > > I just wanted to say that a long time ago I wrote an nbdkit plugin
> > > that was intended as a more sane replacement for vfat.
> > 
> > What does it do differently from vvfat? For the read-only part, I
> > thought that vvfat wasn't too bad. Write support is where all the bugs
> > are hiding. But if you have good input, maybe vvfat could be improved.
> 
> There are a bunch of reasons why you'd want the less common drivers to
> be running outside qemu, and not be a part of qemu at all:
> 
>  - It's more secure, not just because it's running in a separate
>    process, but because you can confine the process differently (eg
>    with SELinux).
> 
>  - The command line is far simpler and more intuitive compared to,
>    say, q-s-d.
> 
>  - There's a simple nbd:// URI scheme for these endpoints, and a whole
>    suite of tools for querying, copying and modifying these NBD
>    endpoints, like nbdinfo, nbdcopy, nbddump, nbdsh, (and more).  This
>    is all based on public standards and interoperability tests, with
>    clients in several programming languages.
> 
>  - You can consume NBD elsewhere than just from qemu, including over
>    the network.
> 
>  - Huge array of weird and ugly plugins that wouldn't be desirable or
>    even possible in qemu (because they are proprietary like VDDK, or
>    written in Python or other scripting languages like our AWS
>    support).  Also a much wider choice of programming languages -
>    vvfat might be more tractable if written in a scripting language.
> 
>  - A number of out of tree plugins that companies develop, which we
>    enable because we have hard ABI guarantees, but qemu does not (and
>    I understand why qemu does not do this, and those are good reasons).

Ok, so nothing in particular that the nbdkit floppy plugin does better
than vvfat that could be worth looking at?

I can kind of get the argument that running things in separate processes
is always safer, though in the typical vvfat use case your VM is
trusted, so it doesn't really matter much. So I wouldn't argue using QSD
for this case either, even though it would provide the same isolation.
For human use, the simplicity of use for built-in vvfat is hard to beat.

(Ignoring all the other points that are just generic nbdkit advertising
with no relevance for the vvfat use case.)

> > > Since then several more nbdkit plugins have been added.  They support
> > > arbitrary sizes already.  The first one is the most direct replacement
> > > for vvfat (although it doesn't support writes to the backing
> > > directory, because that feature is insane).
> > 
> > The scenario we discussed here was explicitly read-write.
> 
> Indeed, nbdkit-floppy-plugin doesn't support writes to the backing
> filesystem right now.  Some others I listed in the original email do
> support writes, and you can add a COW layer on top of any of them
> (which is not the same thing of course).

From that list, it seems to be only tmpdisk, which obviously isn't well
suited to be used to copy files between host and guest?

Kevin


