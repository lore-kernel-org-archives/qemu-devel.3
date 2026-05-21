Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BB5CD5BB1
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 12:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ2u0-0006cx-0J; Thu, 21 May 2026 08:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sin99xx@proton.me>) id 1wPz3A-0006rh-Tx
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:46:40 -0400
Received: from mail-08.mail-europe.com ([57.129.93.249])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sin99xx@proton.me>) id 1wPz38-00052K-6t
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=z2lqxtfvl5g3jarz4fjuoiytzq.protonmail; t=1779353190; x=1779612390;
 bh=tkamdrAaDTWrrkR9kYHra8PGsTVyJBEK4fnu2eaMkvw=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=QtjLvqyrO3qtPf6MZSv3xrLLo07ABzY330OTR/nSkfF9vpxVo3Skxz7E3JPLOoDoX
 qFJlkJHIoNg+jj+2LrXA+w+cHNtOlb//n/1o9UpVVgHD68tgMcGDaEshp3CU4MKvF0
 iZfmpbEs96KKzdPhBL3KPeCmKAZjRsHdKCIrUHjofEquN7xeb8RtHdr2BQn+eOfOvu
 LSKdajJnW7emHTEHbOACx7n9hJ9ayYUL+a6riHXThOjrY5sJjr+xaW0eIAj9aGNZ80
 cxCG4opYWxwkvVX8b2PwvZ+6HbMNwXaJ3u9JS5BZ2LNIMvP1U6OEgsQKT/88/jbAlG
 3OlZEk0wTLIoA==
Date: Thu, 21 May 2026 08:46:25 +0000
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
From: sin99xx <sin99xx@proton.me>
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 sin99xx <sinxx198@gmail.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH] 9pfs: fix missing rename lock in v9fs_co_readdir_many
 (CVE-2026-48004)
Message-ID: <10uGXQrj_bUSBIeDEe9II6FlpXrJvu1JWp65PIgCWneOPK-9k9YMBzunh6oPOh-7Y1nQBfMZVALHdh4YUuR25NI7iWJu4_L8uUNqsrFRzg4=@proton.me>
In-Reply-To: <6268548.lOV4Wx5bFT@weasel>
References: <E1wPkYi-000adH-4E@kylie.crudebyte.com> <4735365.LvFx2qVVIh@weasel>
 <CAMX0No0JkKWL2ZPUqD8558FshhSNFJGjy6hsxqVwntRp9F3rUQ@mail.gmail.com>
 <6268548.lOV4Wx5bFT@weasel>
Feedback-ID: 132738630:user:proton
X-Pm-Message-ID: 0ecfd29ab8aef7a0f908585754bcba6d5489b880
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=57.129.93.249; envelope-from=sin99xx@proton.me;
 helo=mail-08.mail-europe.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 21 May 2026 08:53:24 -0400
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

my bad,

Confirmed =E2=80=94 please use this address (sin99xx@proton.me) for the
Signed-off-by and From lines on the patch.

Signed-off-by: sin99xx sin99xx@proton.me

Regards,
sin99xx


Sent from Proton Mail for iOS.

-------- Original Message --------
On Thursday, 05/21/26 at 04:30 Christian Schoenebeck <qemu_oss@crudebyte.co=
m> wrote:
On Wednesday, 20 May 2026 20:26:09 CEST sin99xx wrote:
> Yes, please go ahead and add my Signed-off-by tag. Also, if possible, cou=
ld
> you use this email instead?
> Signed-off-by: sin99xx sin99xx@proton.me

Please confirm by replying with that proton email address then I will repla=
ce
your email address on this patch.

CC-ing qemu-stable, as this patch should be applied on stable branches, too=
.

> On Wed, May 20, 2026 at 2:22=E2=80=AFPM Christian Schoenebeck <
>
> qemu_oss@crudebyte.com> wrote:
> > On Wednesday, 20 May 2026 19:11:25 CEST Christian Schoenebeck wrote:
> > > From: sin99xx <sinxx198@gmail.com>
> > >
> > > v9fs_co_readdir_many() dispatches do_readdir_many() to a worker threa=
d
> > > that reads V9fsFidState's path.data without holding a rename lock.
> > >
> > > A concurrent rename request, e.g. of its parent dir, causes the FID's
> > > absolute path to be altered by freeing the old path string and
> > > assigning a new one. This causes a heap-use-after-free race condition
> > > while do_readdir_many() is still accessing the old object.
> > >
> > > This allows a DoS by an unprivileged guest user.
> > >
> > > Fix this by wrapping the worker thread dispatch block within a pair o=
f
> > > v9fs_path_read_lock() and v9fs_path_unlock() calls, like it's done at
> > > other places.
> > >
> > > Fixes: 2149675b195f ("9pfs: add new function v9fs_co_readdir_many()")
> > > Fixes: CVE-2026-48004
> > > Reported-by: sin99xx <sinxx198@gmail.com>
> > > [Christian Schoenebeck: add commit log message]
> > > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> >
> > sin99xx, I forgot, may I add your Signed-off-by tag?
> >
> >   Signed-off-by: sin99xx <sinxx198@gmail.com>
> >
> > This is required [1] for making you the patch author:
> >
> > "Your patches must include a Signed-off-by: line. This is a hard
> > requirement
> > because it=E2=80=99s how you say =E2=80=9CI=E2=80=99m legally okay to c=
ontribute this and happy
> > for it
> > to go into QEMU=E2=80=9D. For full guidance, read the Code provenance
> > documentation."
> >
> > [1] https://www.qemu.org/docs/master/devel/submitting-a-patch.html
> >
> > > ---
> > >
> > >  hw/9pfs/codir.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/hw/9pfs/codir.c b/hw/9pfs/codir.c
> > > index bce7dd96e9..5568399343 100644
> > > --- a/hw/9pfs/codir.c
> > > +++ b/hw/9pfs/codir.c
> > > @@ -220,13 +220,16 @@ int coroutine_fn v9fs_co_readdir_many(V9fsPDU
> > > *pdu,
> > > V9fsFidState *fidp, bool dostat)
> > >
> > >  {
> > >
> > >      int err =3D 0;
> > >
> > > +    V9fsState *s =3D pdu->s;
> > >
> > >      if (v9fs_request_cancelled(pdu)) {
> > >
> > >          return -EINTR;
> > >
> > >      }
> > >
> > > +    v9fs_path_read_lock(s);
> > >
> > >      v9fs_co_run_in_worker({
> > >
> > >          err =3D do_readdir_many(pdu, fidp, entries, offset, maxsize,
> >
> > dostat);
> >
> > > });
> > > +    v9fs_path_unlock(s);
> > >
> > >      return err;
> > >
> > >  }




