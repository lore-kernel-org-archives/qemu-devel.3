Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2ECCD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 08:31:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPynU-0003nv-TZ; Thu, 21 May 2026 04:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wPynT-0003nZ-4F; Thu, 21 May 2026 04:30:27 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wPynR-0007rM-A6; Thu, 21 May 2026 04:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=UvWy8jeyKKeDs6RIRnkD3VYOZoPb0DRof5DWbAMVpjU=; b=LGbTViLlkLSj1fXP55Qw6uhqO3
 I2en0LKb5ENC9hQ8kbrKTkUgl7DH8zlHlPy1VHVU3Qm214wkIvQx4jVQg+jRb07t5X4PmR5j9gQIs
 ws9d5PD2oY0UhKNtoFHFGIbqXDbvzVisyM8Ef4aG9A45srMZ2vw9A1y7LyICJtsPE4wbaKccDqbZb
 HGnYdiKF3A9J05jXxE4cLc9jsxypPB8tzCM20YY5pApBPZWfVPYNvDSYwcHlK4FuWZLxGjzoSuZkn
 I9cD68EOEBZbKdFl6wKajmCuTmyEyXCXpio7Uonmw2SRd8N2TMiWfNfSYS024QnTqhDOES05j7PGZ
 9DToYH3zpH/zKG2T++hLT6RzGTUIFfS9pKIHwcjcfylqLPd9NI8F8UeT/vb+Gn7lPmQ6swmG0GP4H
 z6m3ABqMESLSm9Ix+DPQT9t3EdXQyPrs8m8TQkf65YeHuv7tSUl+s9q9toZDSKXeuvFliLYDuvTOj
 WobwKuWA32y5VCgrLMmBdZ6UchRByiPi4QjxwvvgnGuJHnmi++WIziScQJ064F4vatFbb4j6EUC/Y
 Mv3z8P368lPUwR1AhJrCxa5FERNS8vOJTymfyGMHkrtNq/gpitMrAYp76Lp1Ai2huJklKcvC8e9tc
 gR54PZj2HguYvKqyPbCP5p9/XzCrqnDUdPCW3DPnM=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, sin99xx@proton.me
Cc: sin99xx <sinxx198@gmail.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH] 9pfs: fix missing rename lock in v9fs_co_readdir_many
 (CVE-2026-48004)
Date: Thu, 21 May 2026 10:30:13 +0200
Message-ID: <6268548.lOV4Wx5bFT@weasel>
In-Reply-To: <CAMX0No0JkKWL2ZPUqD8558FshhSNFJGjy6hsxqVwntRp9F3rUQ@mail.gmail.com>
References: <E1wPkYi-000adH-4E@kylie.crudebyte.com> <4735365.LvFx2qVVIh@weasel>
 <CAMX0No0JkKWL2ZPUqD8558FshhSNFJGjy6hsxqVwntRp9F3rUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wednesday, 20 May 2026 20:26:09 CEST sin99xx wrote:
> Yes, please go ahead and add my Signed-off-by tag. Also, if possible, cou=
ld
> you use this email instead?
> Signed-off-by: sin99xx sin99xx@proton.me

Please confirm by replying with that proton email address then I will repla=
ce=20
your email address on this patch.

CC-ing qemu-stable, as this patch should be applied on stable branches, too.

> On Wed, May 20, 2026 at 2:22=E2=80=AFPM Christian Schoenebeck <
>=20
> qemu_oss@crudebyte.com> wrote:
> > On Wednesday, 20 May 2026 19:11:25 CEST Christian Schoenebeck wrote:
> > > From: sin99xx <sinxx198@gmail.com>
> > >=20
> > > v9fs_co_readdir_many() dispatches do_readdir_many() to a worker thread
> > > that reads V9fsFidState's path.data without holding a rename lock.
> > >=20
> > > A concurrent rename request, e.g. of its parent dir, causes the FID's
> > > absolute path to be altered by freeing the old path string and
> > > assigning a new one. This causes a heap-use-after-free race condition
> > > while do_readdir_many() is still accessing the old object.
> > >=20
> > > This allows a DoS by an unprivileged guest user.
> > >=20
> > > Fix this by wrapping the worker thread dispatch block within a pair of
> > > v9fs_path_read_lock() and v9fs_path_unlock() calls, like it's done at
> > > other places.
> > >=20
> > > Fixes: 2149675b195f ("9pfs: add new function v9fs_co_readdir_many()")
> > > Fixes: CVE-2026-48004
> > > Reported-by: sin99xx <sinxx198@gmail.com>
> > > [Christian Schoenebeck: add commit log message]
> > > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> >=20
> > sin99xx, I forgot, may I add your Signed-off-by tag?
> >=20
> >   Signed-off-by: sin99xx <sinxx198@gmail.com>
> >=20
> > This is required [1] for making you the patch author:
> >=20
> > "Your patches must include a Signed-off-by: line. This is a hard
> > requirement
> > because it=E2=80=99s how you say =E2=80=9CI=E2=80=99m legally okay to c=
ontribute this and happy
> > for it
> > to go into QEMU=E2=80=9D. For full guidance, read the Code provenance
> > documentation."
> >=20
> > [1] https://www.qemu.org/docs/master/devel/submitting-a-patch.html
> >=20
> > > ---
> > >=20
> > >  hw/9pfs/codir.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >=20
> > > diff --git a/hw/9pfs/codir.c b/hw/9pfs/codir.c
> > > index bce7dd96e9..5568399343 100644
> > > --- a/hw/9pfs/codir.c
> > > +++ b/hw/9pfs/codir.c
> > > @@ -220,13 +220,16 @@ int coroutine_fn v9fs_co_readdir_many(V9fsPDU
> > > *pdu,
> > > V9fsFidState *fidp, bool dostat)
> > >=20
> > >  {
> > > =20
> > >      int err =3D 0;
> > >=20
> > > +    V9fsState *s =3D pdu->s;
> > >=20
> > >      if (v9fs_request_cancelled(pdu)) {
> > >     =20
> > >          return -EINTR;
> > >     =20
> > >      }
> > >=20
> > > +    v9fs_path_read_lock(s);
> > >=20
> > >      v9fs_co_run_in_worker({
> > >     =20
> > >          err =3D do_readdir_many(pdu, fidp, entries, offset, maxsize,
> >=20
> > dostat);
> >=20
> > > });
> > > +    v9fs_path_unlock(s);
> > >=20
> > >      return err;
> > > =20
> > >  }



