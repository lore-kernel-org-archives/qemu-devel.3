Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB7ECCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 09:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8EnM-00071L-J4; Mon, 13 Oct 2025 05:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1v8EnK-0006yJ-BP
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 05:24:42 -0400
Received: from 10.mo548.mail-out.ovh.net ([46.105.77.235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1v8EnE-0004fi-QT
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 05:24:42 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.110.58.167])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4clX3t70bmz6T2W;
 Mon, 13 Oct 2025 09:24:26 +0000 (UTC)
Received: from kaod.org (37.59.142.100) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Mon, 13 Oct
 2025 11:24:26 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R00301b14842-4837-44df-a1a2-391d696616a0,
 2350DB3D6D8EEE81184BB942758C035E74337293) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Mon, 13 Oct 2025 11:24:24 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
CC: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, "Dominique
 Martinet" <asmadeus@codewreck.org>, <qemu-devel@nongnu.org>, "Eric Van
 Hensbergen" <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>,
 <v9fs@lists.linux.dev>, =?UTF-8?B?R8O8bnRoZXI=?= Noack <gnoack@google.com>,
 <linux-security-module@vger.kernel.org>, Jan Kara <jack@suse.cz>, "Amir
 Goldstein" <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>, "Al
 Viro" <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 <linux-fsdevel@vger.kernel.org>, Tingmao Wang <m@maowtm.org>
Subject: Re: [PATCH v2 0/7] fs/9p: Reuse inode based on path (in addition to
 qid)
Message-ID: <20251013112424.6b93659c@bahia>
In-Reply-To: <3061192.c3ltI2prpg@silver>
References: <aMih5XYYrpP559de@codewreck.org>
 <20250917.Eip1ahj6neij@digikod.net>
 <f1228978-dac0-4d1a-a820-5ac9562675d0@maowtm.org>
 <3061192.c3ltI2prpg@silver>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.100]
X-ClientProxiedBy: DAG4EX1.mxp5.local (172.16.2.31) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: 8df15119-2886-4617-99ba-e1d56fd5bb4d
X-Ovh-Tracer-Id: 14216175175088118148
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFx9wyKcRj7cqz7kuCitc0YOsdQGyZ7gTu+k8QCdN2UJaD/m4wfwf1TeZmtMFCwCQ696qaFLNhv1ArnJmBfVFKJ+i7oA431WUslbGABZCqTVFAKGVxscwZrJ8RQC6y31uoYWkhoYG8j1m9X8oNs+EckM0OSwLjUfHiMXTFS24TxAo2EfmhJtZlyJ4Dtm/dWqFb1K56tG84CerG+rp+ZmA4oDfQA+AouTmvQapBdTeMH6fkCu4MmX6/A66nRgN+AOh1Lstzx1CwH4GuXZ+lEHbAsdebqtlV16xLxgVdCQBGU9+uJb+xgKUtx8vfyIesl93n2b7HgHFtDuS/UwhW7/K5LRRXv53T8tqoT/0fu1eb/nUa+d+zoCcMCTJwu83LMXsyNHXMxmaKHxMg9OUURZ7U4NhvLcN+5d71bj/MGmNnhz4+9VaoAdRhD3UUNxWR4Z5ke1SoSSRgUrPZLnigMzA/CthSqTqBBW3JOMMKRtDv8cKfx4rRbw0pH7f3An4dXm3W/ZjaPaqzJd0Fe0DBZ8Sny3wUdgJVaEvJnqPulObp7BG/pVdis2Asa051JFC1MEUkPHaFRqtxyBga+CKW6bn6ZIauf1lSsFcOV2GXjhrwONjMW6zCdEwdAUL5ZTrd5qdgr1n6PLJeeSHOARekpx4jgFkloNsXfl5ws9X3xNwQ41g
DKIM-Signature: a=rsa-sha256; bh=3jYn4YNdYeG7LGg6VH5k0ps8cSfN4dyFLHQu/RiM+CA=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1760347468; v=1;
 b=CFaoHXW6Z73qEnS7Th3BC/jjekF9fuMpiinSF6+z/QkpY7i3AjzwirMEkgzFjSc59jHECDZa
 hwJ5VjY5xLbpSpNTyMkiuhX7u5bAx2yqmo37Q5z0INncZt4wsA1g5/q4VRgvP1DDgjRuPgIR46h
 folX5IoxVTxfWuQPtJ06cYQ2wjGbmAPnb0g5Y9U0n4WN8qgngb+sMCgCDdLbP2AOewtXrO6FTL8
 rJdptJBWetpuXMJPf2JcKpe7CIZkGlIlYXItLR4m7ySh/5a253WPCKAzIHVffwlHKuqj8Iqx4la
 1KBREK2vWIxZEOD3zLlkPG2lUkHQcTym5Guwn5unVGXdg==
Received-SPF: pass client-ip=46.105.77.235; envelope-from=groug@kaod.org;
 helo=10.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 29 Sep 2025 15:06:59 +0200
Christian Schoenebeck <linux_oss@crudebyte.com> wrote:

> On Sunday, September 21, 2025 6:24:49 PM CEST Tingmao Wang wrote:
> > On 9/17/25 16:00, Micka=C3=ABl Sala=C3=BCn wrote:
> [...]
>=20
> Hi Greg,
>=20

Hi Christian,

> I'd appreciate comments from your side as well, as you are much on longer=
 on
> the QEMU 9p front than me.
>=20
> I know you won't have the time to read up on the entire thread so I try to
> summarize: basically this is yet another user-after-unlink issue, this ti=
me on
> directories instead of files.
>=20

Thread that never landed in my mailbox actually and it is quite
hard to understand the root problem with the content of this
e-mail actually ;-)

> > So I did some quick debugging and realized that I had a wrong
> > understanding of how fids relates to opened files on the host, under QE=
MU.
> > It turns out that in QEMU's 9p server implementation, a fid does not
> > actually correspond to any opened file descriptors - it merely represen=
ts
> > a (string-based) path that QEMU stores internally.  It only opens the
> > actual file if the client actually does an T(l)open, which is in fact
> > separate from acquiring the fid with T(l)walk.  The reason why renaming
> > file/dirs from the client doesn't break those fids is because QEMU will
> > actually fix those paths when a rename request is processed - c.f.
> > v9fs_fix_fid_paths [1].
>=20
> Correct, that's based on what the 9p protocols define: a FID does not exa=
ctly
> translate to what a file handle is on a local system. Even after acquirin=
g a
> new FID by sending a Twalk request, subsequently client would still need =
to
> send a Topen for server to actually open that file/directory.
>=20
> And yes, QEMU's 9p server "fixes" the path string of a FID if it was moved
> upon client request. If the move happened on host side, outside of server=
's
> knowledge, then this won't happen ATM and hence it would break your use
> case.
>=20
> > It turns out that even if a guest process opens the file with O_PATH, t=
hat
> > file descriptor does not cause an actual Topen, and therefore QEMU does
> > not open the file on the host, and later on reopening that fd with anot=
her
> > mode (via e.g. open("/proc/self/fd/...", O_RDONLY)) will fail if the fi=
le
> > has moved on the host without QEMU's knowledge.  Also, openat will fail=
 if
> > provided with a dir fd that "points" to a moved directory, regardless of
> > whether the fd is opened with O_PATH or not, since path walk in QEMU is
> > completely string-based and does not actually issue openat on the host =
fs
> > [2].
>=20
> I don't think the problem here is the string based walk per se, but rather
> that the string based walk always starts from the export root:
>=20
> https://github.com/qemu/qemu/blob/4975b64efb5aa4248cbc3760312bbe08d6e7163=
8/hw/9pfs/9p-local.c#L64
>=20
> I guess that's something that could be changed in QEMU such that the walk
> starts from FID's fs point, as the code already uses openat() to walk rel=
ative
> to a file descriptor (for security reasons actually), Greg?
>=20

Yes this was introduced for security reasons. In a nutshell, the idea is
to *not* follow symlinks in any element of the path being opened. It thus
naturally starts at the export root for which we have an fd.

> That alone would still not fix your use case though: things being moved on
> host side. For this to work, it would require to already have a fd open on
> host for the FID. This could be done by server for each FID as you sugges=
ted,
> or it could be done by client by opening the FID.
>=20

Can you elaborate on the "things being move on host side" ? With
an example of code that breaks on the client side ?

> Also keep in mind: once the open file descriptor limit on host is exhaust=
ed,
> QEMU is forced to close older open file desciptors to keep the QEMU proce=
ss
> alive. So this might still break what you are trying to achieve there.
>=20

Correct.

> Having said that, I wonder whether it'd be simpler for server to track for
> file tree changes (inotify API) and fix the pathes accordingly for host
> side changes as well?
>=20

The problem is how to have the guest know about such changes, e.g. in
order to invalidate a stale cache entry. 9P doesn't provide any way for
host->client notification.

> /Christian
>=20
>=20

Cheers,

--=20
Greg

