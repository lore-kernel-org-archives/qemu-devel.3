Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D54E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 10:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKxan-0003vk-0j; Tue, 10 Dec 2024 05:35:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tKxaj-0003vD-9e; Tue, 10 Dec 2024 05:35:46 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tKxah-0006nS-5C; Tue, 10 Dec 2024 05:35:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=OqDQ+/PMBm2HDyZlDmLl1RBO8HJ/aE3fD3HFRZJGj34=; b=XEei+iq0n6fZ1SXM5vZesN4BIZ
 5HZis9PHEkNRXpwhSB85xzhwBTnzWZLaWDfYPSVOJYhZICXRs5cOI4748v5iF1Meq1QQGvwpL8Xwd
 x2toBCzrMJ9K/H/LPNRaHWq2blgdD5T6UVrsZdgXxDOJSxDXKctQCvnBO5UDw1M8+eR7l3KlNB3JA
 YhmytARHVftjmze236Yka27o5fW0OOWrXTKaJtLkiLVV74BVT8iqhyyAjFnoy65vNsT3Of4o82ScO
 YksxCvPpTb9/qNKLHEqUhFVKyoe0VXwU5yl2yoqKHCOzVMh21WgqnAj8+SNQ4Gb1iEN+roFtctJBZ
 OVv9e2M5fX7yvgoOdknBWD8XBkIBhIpRHXlocYDLMwXnBhhgerxNFsu36P1UQeC0D9SULmullJPdT
 zsR4zFAzKP/N+ee84pYRjAIRj8WK7g/qzROZmVHxIlCvlcXnwISFIlJnX7b4mVt8MM3Cep2d0tYcE
 6ZeShXM1gpCJzMT8gWDVz/oU4sje4I2u7CyPitbQb9RWJPUnGK2tVUfzjlSGjv3/Kx36VzNwS/+fM
 lWpR8XnLUgZhTShUR80apqQl7cjrHySAYmDVZnoGxOPGr92bgGI1AW4yUR3H/KOU3MmygTIBq9hvJ
 +bId3c9oLTq0pbcjRZGjn4JeAcvxiwEri6uCXdALs=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Dirk Herrendorfer <d.herrendoerfer@de.ibm.com>,
 Yanwu Shen <ywsPlz@gmail.com>, Jietao Xiao <shawtao1125@gmail.com>,
 Jinku Li <jkli@xidian.edu.cn>, Wenbo Shen <shenwenbo@zju.edu.cn>,
 Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] 9pfs: fix regression regarding CVE-2023-2861
Date: Tue, 10 Dec 2024 11:35:36 +0100
Message-ID: <1759927.xNkLErMGIS@silver>
In-Reply-To: <CAFEAcA8dL=pRJf4DNjF_NPR7npfAhUJdNb0n3fyJq=b+oKnWrg@mail.gmail.com>
References: <E1tJWbk-007BH4-OB@kylie.crudebyte.com> <4261493.soTQ3n66jb@silver>
 <CAFEAcA8dL=pRJf4DNjF_NPR7npfAhUJdNb0n3fyJq=b+oKnWrg@mail.gmail.com>
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

On Tuesday, December 10, 2024 11:11:47 AM CET Peter Maydell wrote:
> On Tue, 10 Dec 2024 at 09:57, Christian Schoenebeck
> <qemu_oss@crudebyte.com> wrote:
> >
> > On Friday, December 6, 2024 12:20:29 PM CET Christian Schoenebeck wrote:
> > > The released fix for this CVE:
> > >
> > >   f6b0de53fb8 ("9pfs: prevent opening special files (CVE-2023-2861)")
> > >
> > > caused a regression with security_model=passthrough. When handling a
> > > 'Tmknod' request there was a side effect that 'Tmknod' request could fail
> > > as 9p server was trying to adjust permissions:
> > >
> > >   #6  close_if_special_file (fd=30) at ../hw/9pfs/9p-util.h:140
> > >   #7  openat_file (mode=<optimized out>, flags=2228224,
> > >       name=<optimized out>, dirfd=<optimized out>) at
> > >       ../hw/9pfs/9p-util.h:181
> > >   #8  fchmodat_nofollow (dirfd=dirfd@entry=31,
> > >       name=name@entry=0x5555577ea6e0 "mysocket", mode=493) at
> > >       ../hw/9pfs/9p-local.c:360
> > >   #9  local_set_cred_passthrough (credp=0x7ffbbc4ace10, name=0x5555577ea6e0
> > >       "mysocket", dirfd=31, fs_ctx=0x55555811f528) at
> > >       ../hw/9pfs/9p-local.c:457
> > >   #10 local_mknod (fs_ctx=0x55555811f528, dir_path=<optimized out>,
> > >       name=0x5555577ea6e0 "mysocket", credp=0x7ffbbc4ace10) at
> > >       ../hw/9pfs/9p-local.c:702
> > >   #11 v9fs_co_mknod (pdu=pdu@entry=0x555558121140,
> > >       fidp=fidp@entry=0x5555574c46c0, name=name@entry=0x7ffbbc4aced0,
> > >       uid=1000, gid=1000, dev=<optimized out>, mode=49645,
> > >       stbuf=0x7ffbbc4acef0) at ../hw/9pfs/cofs.c:205
> > >   #12 v9fs_mknod (opaque=0x555558121140) at ../hw/9pfs/9p.c:3711
> > >
> > > That's because server was opening the special file to adjust permissions,
> > > however it was using O_PATH and it would have not returned the file
> > > descriptor to guest. So the call to close_if_special_file() on that branch
> > > was incorrect.
> > >
> > > Let's lift the restriction introduced by f6b0de53fb8 such that it would
> > > allow to open special files on host if O_PATH flag is supplied, not only
> > > for 9p server's own operations as described above, but also for any client
> > > 'Topen' request.
> > >
> > > It is safe to allow opening special files with O_PATH on host, because
> > > O_PATH only allows path based operations on the resulting file descriptor
> > > and prevents I/O such as read() and write() on that file descriptor.
> > >
> > > Fixes: f6b0de53fb8 ("9pfs: prevent opening special files (CVE-2023-2861)")
> > > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2337
> > > Reported-by: Dirk Herrendorfer <d.herrendoerfer@de.ibm.com>
> > > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > > ---
> > >  hw/9pfs/9p-util.h | 27 +++++++++++++++++----------
> > >  1 file changed, 17 insertions(+), 10 deletions(-)
> >
> > Queued on 9p.next:
> > https://github.com/cschoenebeck/qemu/commits/9p.next
> >
> > Let's see if we can still land this in 9.2.
> 
> 9.2 is due to be released today, so this would need to be:
>  * a fix for a critical bug
>  * the bug must be a regression since 9.1
>  * with a clear justification attached for why it's important
>    enough to delay the release
> 
> Commit f6b0de53fb8 was in 9.1, which suggests that this isn't
> a regression since 9.1 ?

Hi Peter,

I just saw there was still one open milestone ticket for 9.2 and assumed the
release to be delayed by one week anyway.

I am not trying to convince you of a delay. So unless somebody objects, just
disregard the PR for now.

Thanks!

/Christian



