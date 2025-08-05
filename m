Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F1CC87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 11:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujGBF-0001ge-PD; Tue, 05 Aug 2025 07:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1ujGB0-0001bT-D3
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 07:49:56 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1ujGAy-0000lf-BX
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 07:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=DeANdghr6YRWM2F9v24hE93qEKc1fic5Damib2N+vyo=; b=A1tv1D9tPrGz7qIBJoe6bifYk8
 u+MxrvOblQJlQnJzccmWLXf1AX4xV+nRu+vLqfIFc9tMf1dZIRcx2uOkSUWKhzVCP6fbWIPF6vYnk
 cnweXLJP9rYqOohLYg+Rxgq1YMmIu/Mo8UoS6aXZS/MmjxnIcJ3UyASoXv/zeMPR+sNUPkCM6/LuE
 /rnIVyfls1BNvosRqZKnsf5hOrVMDBtq/MZUTGQ4HoZn0XtlBIsClM3zqf54daNtv34hu6PPXC2jf
 SU/VcT/3stdY2w7/C3EP7woToTMbdvfRoALyuZ2jYoHCtiaxhD3/HaQyxScSslaKjTA4cqTEaJ/KA
 j3AfMbcYcU6uoA0ZP750ucLk8hrgsl8xAGTvQneovZW4JMtMgIaQaL0S9pvtDenxZBdwg3GiU2VD2
 iuiDW80yoVIw71VVsN3c57HZ/U/cB8MpDEiliS1XMnF/Rocwh5G5FZK74GWuiUwmcVpVGgsCSYPpH
 FRI16m210rhUj5T3K15FxdsD9rG/5DJQpUDUZFXAo2fdDVHsVpNe0FTuFYXPXoF/uZIRDxkcwFPwP
 1rMayhg7VILYEx7eDsr5f9637gly/RsYpMR5mFjkOY7QXbQQc22eZG5c91QiQAjtlI075cnTnTu/v
 VhXtIdicaUaeYHH7PBs/52kvENS+6JffuEjjRbY3o=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, Mark Johnston <markj@freebsd.org>
Cc: Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?Marc=2DAndr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH] 9pfs: Add FreeBSD support
Date: Tue, 05 Aug 2025 13:49:44 +0200
Message-ID: <2268148.dRjqHlHdj4@silver>
In-Reply-To: <aIos9lb1dBuDBq2E@nuc>
References: <aIEGDjMex-DG-pmr@nuc> <1989897.fkXqvmx5VE@silver>
 <aIos9lb1dBuDBq2E@nuc>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wednesday, July 30, 2025 4:32:22 PM CEST Mark Johnston wrote:
> On Tue, Jul 29, 2025 at 06:09:35PM +0200, Christian Schoenebeck wrote:
> > On Wednesday, July 23, 2025 5:55:58 PM CEST Mark Johnston wrote:
[...]
> Thank you for taking a look.
> 
> I'll certainly be around to help deal with issues and patches relating
> to 9pfs+FreeBSD hosts.  It's hard to prove that, but for what it's worth
> I use QEMU fairly extensively for FreeBSD development when I can't use
> the native hypervisor, and that's not likely to change anytime soon.
> 
> Would adding myself to MAINTAINERS for virtio-9pfs (or a new
> virtio-9pfs-freebsd category) be appropriate in that case?

Good to hear that you will be around!

I leave it to you whether you want to add yourself as reviewer of patches to
MAINTAINER's 9pfs section.

For other things like adding a virtio-9pfs-freebsd subsection or something,
it's probably a bit too early.

> > > diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
> > > index b9dae8c84c..b85c9934de 100644
> > > --- a/fsdev/file-op-9p.h
> > > +++ b/fsdev/file-op-9p.h
> > > @@ -21,9 +21,11 @@
> > >  
> > >  #ifdef CONFIG_LINUX
> > >  # include <sys/vfs.h>
> > > -#endif
> > > -#ifdef CONFIG_DARWIN
> > > +#elif defined(CONFIG_DARWIN) || defined(CONFIG_FREEBSD)
> > >  # include <sys/param.h>
> > > +# ifdef CONFIG_FREEBSD
> > > +#  undef MACHINE /* work around some unfortunate namespace pollution */
> > > +# endif
> > 
> > Details? :)
> 
> We need sys/mount.h for struct statfs.  sys/mount.h implicitly includes
> sys/param.h, which is really sloppy about polluting the namespace with
> identifiers that only the kernel cares about 99% of the time.  In
> particular, it includes a platform-specific param.h which defines
> 
> #define MACHINE "amd64"
> #define MACHINE_ARCH "amd64"
> 
> among other things.  This conflicts with QEMU's MACHINE macro.
> 
> It's a mess.  I have some local FreeBSD patches to avoid including
> param.h from sys/mount.h, but of course a number of applications have
> come to rely on the pollution, so they all need to be fixed first.
> 
> At some point, I think the block above can become something like
> 
>   #elif defined(CONFIG_DARWIN) || defined(CONFIG_FREEBSD)
>   # ifndef CONFIG_FREEBSD
>   #  include <sys/param.h>
>   # endif
>   # include <sys/mount.h>
> 
> but for now I need this workaround.

OK.

> > >  # include <sys/mount.h>
> > >  #endif
> > >  
> > > diff --git a/fsdev/meson.build b/fsdev/meson.build
> > > index c751d8cb62..95fe816604 100644
> > > --- a/fsdev/meson.build
> > > +++ b/fsdev/meson.build
> > > @@ -5,6 +5,6 @@ fsdev_ss.add(when: ['CONFIG_FSDEV_9P'], if_true: files(
> > >    '9p-marshal.c',
> > >    'qemu-fsdev.c',
> > >  ), if_false: files('qemu-fsdev-dummy.c'))
> > > -if host_os in ['linux', 'darwin']
> > > +if host_os in ['linux', 'darwin', 'freebsd']
> > >    system_ss.add_all(fsdev_ss)
> > >  endif
> > > diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
> > > index 9cd1884224..b3743f6169 100644
> > > --- a/hw/9pfs/9p-synth.c
> > > +++ b/hw/9pfs/9p-synth.c
> > > @@ -451,7 +451,7 @@ static int synth_statfs(FsContext *s, V9fsPath *fs_path,
> > >      stbuf->f_bsize = 512;
> > >      stbuf->f_blocks = 0;
> > >      stbuf->f_files = synth_node_count;
> > > -#ifndef CONFIG_DARWIN
> > > +#if !defined(CONFIG_DARWIN) && !defined(CONFIG_FREEBSD)
> > >      stbuf->f_namelen = NAME_MAX;
> > >  #endif
> > >      return 0;
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

Both ways are fine with me in this case. Do as you find appropriate.

> > Is this source file really specific to exactly FreeBSD? From the name it
> > suggests that potential future support for other BSD flavours would need their
> > own source file.
> 
> Hmm, not really.  Other BSDs seem to implement a compatible syscall
> interface when they implement it at all.  (NetBSD's interface seems to
> be compatible; OpenBSD doesn't appear to implement extattrs at all, and
> DragonflyBSD is missing the extattr_*_fd() variants.)
> 
> FreeBSD appears to be the only one that implements O_PATH, but that
> seems to be optional if I'm reading correctly.
> 
> So, I could preemptively change it to 9p-util-bsd.c, or wait for someone
> to come along and add support for another BSD.

Yeah, that was on nit level as well. It's fine to leave the name, as FreeBSD
is currently the only supported one.

> > > diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
> > > index a1924fe3f0..7315b32591 100644
> > > --- a/hw/9pfs/9p-util.h
> > > +++ b/hw/9pfs/9p-util.h
> > > @@ -21,6 +21,14 @@
> > >  #define O_PATH_9P_UTIL 0
> > >  #endif
> > >  
> > > +#ifdef CONFIG_FREEBSD
> > > +/*
> > > + * FreeBSD does not have these flags, so we can only emulate them (racily).
> > > + */
> > > +#define XATTR_CREATE    0x1
> > > +#define XATTR_REPLACE   0x2
> > > +#endif
> > > +
> > 
> > What do you mean with "racily" here?
> 
> FreeBSD cannot atomically check for the existence of and set an extattr,
> the system call interface simply doesn't support it today.  This means
> that fsetxattrat_nofollow() needs back-to-back system calls to check for
> the existence of an attribute and then potentially set it.

Ah, I was misinterpreting your comment as if it were "racily defining" the
macros. Maybe change the comment to something like "... can only emulate their
intended behaviour (racily) ...".

Thanks!

/Christian



