Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C16ACAC5B8
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Sep 2025 18:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2ZeV-00034T-L5; Sat, 27 Sep 2025 14:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mic@digikod.net>) id 1v2ZeT-00033H-LX
 for qemu-devel@nongnu.org; Sat, 27 Sep 2025 14:28:09 -0400
Received: from smtp-42a9.mail.infomaniak.ch ([84.16.66.169])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mic@digikod.net>) id 1v2ZeK-0004y6-OW
 for qemu-devel@nongnu.org; Sat, 27 Sep 2025 14:28:09 -0400
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cYwtD5xZkzXfY;
 Sat, 27 Sep 2025 20:27:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
 s=20191114; t=1758997668;
 bh=Mhj/EUax+KSAUv+ReFJsSboLBZB2tKC758FHqYfK114=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=z2M6YNCsF2RcPj4q1DUV+GroIYzLA7vqA/MgOruDRXbkE5h8OwZsKFRobsgMLA1Ed
 KGm0Gh6dn7yY6iXQEZSpGblkeLouuVFVOTwW5MOMVzIQtauHcYDmAS38Y225eD3k/2
 jG/EsSlyD+Ae/GE9ttUcxlWiXUaD+BS/cp3zzM3g=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4cYwtC2QQnz9N0; Sat, 27 Sep 2025 20:27:47 +0200 (CEST)
Date: Sat, 27 Sep 2025 20:27:44 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>, Greg Kurz <groug@kaod.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Dominique Martinet <asmadeus@codewreck.org>,
 Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev, 
 =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>,
 linux-security-module@vger.kernel.org, Jan Kara <jack@suse.cz>, 
 Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>, 
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
 linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/7] fs/9p: Reuse inode based on path (in addition to
 qid)
Message-ID: <20250927.ahGhiiy0koo0@digikod.net>
References: <aMih5XYYrpP559de@codewreck.org> <3070012.VW4agfvzBM@silver>
 <f2c94b0a-2f1e-425a-bda1-f2d141acdede@maowtm.org>
 <3774641.iishnSSGpB@silver> <20250917.Eip1ahj6neij@digikod.net>
 <f1228978-dac0-4d1a-a820-5ac9562675d0@maowtm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1228978-dac0-4d1a-a820-5ac9562675d0@maowtm.org>
X-Infomaniak-Routing: alpha
Received-SPF: pass client-ip=84.16.66.169; envelope-from=mic@digikod.net;
 helo=smtp-42a9.mail.infomaniak.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Adding Greg Kurz too.

On Sun, Sep 21, 2025 at 05:24:49PM +0100, Tingmao Wang wrote:
> On 9/17/25 16:00, Mickaël Salaün wrote:
> > On Wed, Sep 17, 2025 at 11:52:35AM +0200, Christian Schoenebeck wrote:
> >> On Wednesday, September 17, 2025 1:59:21 AM CEST Tingmao Wang wrote:
> >>> On 9/16/25 20:22, Christian Schoenebeck wrote:
> >>>> On Tuesday, September 16, 2025 4:01:40 PM CEST Tingmao Wang wrote:
> >> [...]
> >>>> I see that you are proposing an option for your proposed qid based
> >>>> re-using of dentries. I don't think it should be on by default though,
> >>>> considering what we already discussed (e.g. inodes recycled by ext4, but
> >>>> also not all 9p servers handling inode collisions).
> >>>
> >>> Just to be clear, this approach (Landlock holding a fid reference, then
> >>> using the qid as a key to search for rules when a Landlocked process
> >>> accesses the previously remembered file, possibly after the file has been
> >>> moved on the server) would only be in Landlock, and would only affect
> >>> Landlock, not 9pfs (so not sure what you meant by "re-using of dentries").
> >>>
> >>> The idea behind holding a fid reference within Landlock is that, because
> >>> we have the file open, the inode would not get recycled in ext4, and thus
> >>> no other file will reuse the qid, until we close that reference (when the
> >>> Landlock domain terminates, or when the 9p filesystem is unmounted)
> >>
> >> So far I only had a glimpse on your kernel patches and had the impression that 
> >> they are changing behaviour for all users, since you are touching dentry 
> >> lookup.
> > 
> > I think we should not hold dentries because:
> > - they reference other dentries (i.e. a file hierarchy),
> > - they block umount and I'm convinced the VFS (and users) are not going
> >   to like long-lived dentries,
> > - Landlock and inotify don't need dentries, just inodes.
> > 
> > I'm wondering why fid are referenced by dentries instead of inodes.
> > 
> > The need for Landlock is to be able to match an inode with a previously
> > seen one.  Not all LSM hooks (nor VFS internals) always have access to
> > dentries, but they do have access to inodes.
> > 
> >>
> >>>> For all open FIDs QEMU retains a descriptor to the file/directory.
> >>>>
> >>>> Which 9p message do you see sent to server, Trename or Trenameat?
> >>>>
> >>>> Does this always happen to you or just sometimes, i.e. under heavy load?
> >>>
> >>> Always happen, see log: (no Trename since the rename is done on the host)
> >> [...]
> >>> Somehow if I rename in the guest, it all works, even though it's using the
> >>> same fid 2 (and it didn't ask QEMU to walk the new path)
> >>
> >> Got it. Even though QEMU *should* hold a file descriptor (or a DIR* stream, 
> > 
> > It's reasonable to assume that QEMU and other should hold opened fid In
> > practice, this might not always be the case, but let's move on and
> > consider that a 9p server bug.
> > 
> > Landlock and fanotify need some guarantees on opened files, and we
> > cannot consider every server bug.  For Landlock, inode may get an
> > "ephemeral tag" (with the Landlock object mechanism) to match previously
> > seen inodes.  In a perfect world, Landlock could keep a reference on 9p
> > inodes (as for other filesystems) and these inodes would always match
> > the same file.  In practice this is not the case, but the 9p client
> > requirements and the Landlock requirements are not exactly the same.
> > 
> > A 9p client (the kernel) wants to safely deal with duplicated qid, which
> > should not happen but still happen in practice as explained before.
> > On the other side, Landlock wants to not deny access to allowed files
> > (currently identified by their inodes), but I think it would be
> > reasonable to allow access theoretically denied (i.e. not allowed to be
> > precise, because of the denied by default mechanism) files because of a
> > 9p server bug mishandling qid (e.g. mapping them to recycled ext4
> > inodes).
> > 
> > All that to say that it looks reasonable for Landlock to trust the
> > filesystem, and by that I mean all its dependencies, including the 9p
> > server, to not have bugs.
> > 
> > Another advantage to rely on qid and server-side opened files is that we
> > get (in theory) the same semantic as when Landlock is used with local
> > filesystems (e.g. files moved on the server should still be correctly
> > identified by Landlock on the client).
> > 
> >> which should imply a file descriptor), there is still a path string stored at 
> >> V9fsFidState and that path being processed at some places, probably because 
> >> there are path based and FID based variants (e.g Trename vs. Trenameat). Maybe 
> >> that clashes somewhere, not sure. So I fear you would need to debug this.
> > 
> > Good to know that it is not a legitimate behavior for a 9p client.
> 
> So I did some quick debugging and realized that I had a wrong
> understanding of how fids relates to opened files on the host, under QEMU.
> It turns out that in QEMU's 9p server implementation, a fid does not
> actually correspond to any opened file descriptors - it merely represents
> a (string-based) path that QEMU stores internally.  It only opens the
> actual file if the client actually does an T(l)open, which is in fact
> separate from acquiring the fid with T(l)walk.  The reason why renaming
> file/dirs from the client doesn't break those fids is because QEMU will
> actually fix those paths when a rename request is processed - c.f.
> v9fs_fix_fid_paths [1].
> 
> It turns out that even if a guest process opens the file with O_PATH, that
> file descriptor does not cause an actual Topen, and therefore QEMU does
> not open the file on the host, and later on reopening that fd with another
> mode (via e.g. open("/proc/self/fd/...", O_RDONLY)) will fail if the file
> has moved on the host without QEMU's knowledge.  Also, openat will fail if
> provided with a dir fd that "points" to a moved directory, regardless of
> whether the fd is opened with O_PATH or not, since path walk in QEMU is
> completely string-based and does not actually issue openat on the host fs
> [2].
> 
> I'm not sure if this was is intentional in QEMU - it would seem to me that
> a fid should translate to a fd (maybe opened with just O_PATH) on the
> host, and path walks based on that fid should be done via openat with this
> fd, which will also "automatically" handle renames without QEMU needing to
> fixup the string paths?

I agree, it would make sense for QEMU to map fid to FD+O_PATH.  That
would avoid the kind of issues you mentioned.

Christian, Greg, what do you think?

> 
> In any case, this probably means that even if Landlock were to hold a fid
> reference, and QEMU does qid remapping, that's still not enough to
> guarantees that we won't have a different, unrelated file ending up with
> the same qid, at least under ext4.
> 
> I'm not sure what's the way forward - would Landlock need to actually
> "open" the files (or do something that will cause a Topen to be issued by
> v9fs)?

> Alternatively if we believe this to be a QEMU issue, maybe
> Landlock don't need to work around it and should just hold fids (and use
> QIDs to key the rules) anyway despite server quirks like these.  This can
> perhaps then be fixed in QEMU?

Yes, I think it would make sense for Landlock to open and keep open a
fid (and hopefully the related remote file).  However, the v9fs umount
should be handled gracefully the same way Landlock tag inodes are
handled.  This should come with a QEMU patch to fix the consistency
issue.

> 
> (I guess the fact that QEMU is doing path tracking in the first place does
> gives more precedent for justifying doing path tracking in v9fs as well,
> but maybe that's the wrong way to think about it)

Anyway, if QEMU does it, wouldn't it be the same for Landlock to just
rely on fid?  If QEMU uses FD+O_PATH, then Landlock would work even for
server-moved files.

> 
> Test programs: openat.c [3], open_procselffd.c [4]
> 
> 
> [1]: https://gitlab.com/qemu-project/qemu/-/blob/44f51c1a3cf435daa82eb757740b59b1fd4fe71c/hw/9pfs/9p.c#L3403
> [2]: https://gitlab.com/qemu-project/qemu/-/blob/371a269ff8ce561c28e4fa03bb49e4940f990637/hw/9pfs/9p-local.c#L1243
> [3]: https://fileshare.maowtm.org/9pfs-landlock-fix/20250921/openat.c
> [4]: https://fileshare.maowtm.org/9pfs-landlock-fix/20250921/open_procselffd.c
> 

