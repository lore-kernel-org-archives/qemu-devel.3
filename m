Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F04DC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 14:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts0Ci-000412-A8; Tue, 11 Mar 2025 10:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1ts0CX-0003tx-1Z
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 10:03:22 -0400
Received: from 7.mo548.mail-out.ovh.net ([46.105.33.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1ts0CU-0003fl-SQ
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 10:03:20 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.2.90])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4ZBwTH4b1Pz10Xl;
 Tue, 11 Mar 2025 14:03:15 +0000 (UTC)
Received: from kaod.org (37.59.142.108) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 11 Mar
 2025 15:03:14 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-108S00200ea69c9-7d51-4af4-bb32-798de7e04bff,
 9EC908457B01BCAD6949D5412F5E8CCE0041A118) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Tue, 11 Mar 2025 15:03:13 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
CC: <qemu-devel@nongnu.org>
Subject: Re: [PATCH 2/4] 9pfs: Don't use file descriptors in core code
Message-ID: <20250311150313.5e3a7e52@bahia>
In-Reply-To: <5513162.Wvc2JcUQ7O@silver>
References: <20250310171101.138380-1-groug@kaod.org>
 <20250310171101.138380-3-groug@kaod.org>
 <5513162.Wvc2JcUQ7O@silver>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.108]
X-ClientProxiedBy: DAG4EX2.mxp5.local (172.16.2.32) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: da0fb949-e877-43ce-8591-b9bc38bdf83e
X-Ovh-Tracer-Id: 4801681629892811162
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddvgeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeegffevudduleetgeeftefhtddtkeeludeuudevtdeuhfdvffeggfevfeefkedtkeenucffohhmrghinhepughirhdrshhtrhgvrghmnecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrddutdekpdekkedrudejledrledrudehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepqhgvmhhupghoshhssegtrhhuuggvsgihthgvrdgtohhmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdpoffvtefjohhsthepmhhoheegkegmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=332BOdzlHxWRjfBirYQxJ0bEkG1XDijW/6Gx9bQM/xc=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1741701796; v=1;
 b=I7zCCtejK0qmDD4EFD9xsvfSUVu3RwMAgSQDDUrMiDfz6lYO+KZXsi55olUmOgjBBjLl0zPG
 BDAUn05kGKDap9KUJGFmn4FLFgij8axk0z0V1ouTxN0fh1QTGi4tlaRCIrEyCgvBhKdL4uSln9Q
 VrToVu703Pp+feInjwC4o2HpmkyBTFcCs4V0T05ABJNG0uL6+bjPG/ekMo0ndSkLRiWfWJEjUcS
 MWzo4tjzgYJSJ2f8HM0qF0lBfnp2Mb5jS+jdYbMT0Ej7pk5s2VNL0yMC7EWsHJA/6uhwJZ5jT9U
 xBRv9SdS51qeXXeFwe2hdE890lPq3hjSNrALdYNCcd+Kw==
Received-SPF: pass client-ip=46.105.33.25; envelope-from=groug@kaod.org;
 helo=7.mo548.mail-out.ovh.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_OTHER_BAD_TLD=0.413, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, 11 Mar 2025 12:13:06 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Monday, March 10, 2025 6:10:59 PM CET Greg Kurz wrote:
> > v9fs_getattr() currently peeks into V9fsFidOpenState to know if a fid
> > has a valid file descriptor or directory stream. Even though the fields
> > are accessible, this is an implementation detail of the local backend
> > that should not be manipulated directly by the server code.
> > 
> > Abstract that with a new has_valid_handle() backend operation.
> > 
> > Make the existing local_fid_fd() helper more robust so that it
> > can cope with P9_FID_NONE or a null directory stream and reuse
> > it.
> > 
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  fsdev/file-op-9p.h |  1 +
> >  hw/9pfs/9p-local.c | 12 +++++++++---
> >  hw/9pfs/9p-synth.c |  6 ++++++
> >  hw/9pfs/9p.c       |  9 ++++++---
> >  4 files changed, 22 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
> > index 4997677460e8..39fee185f4ce 100644
> > --- a/fsdev/file-op-9p.h
> > +++ b/fsdev/file-op-9p.h
> > @@ -164,6 +164,7 @@ struct FileOperations {
> >      int (*renameat)(FsContext *ctx, V9fsPath *olddir, const char *old_name,
> >                      V9fsPath *newdir, const char *new_name);
> >      int (*unlinkat)(FsContext *ctx, V9fsPath *dir, const char *name, int flags);
> > +    bool (*has_valid_handle)(int fid_type, V9fsFidOpenState *fs);
> >  };
> >  
> >  #endif
> > diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> > index c4366c867988..03e5304ef888 100644
> > --- a/hw/9pfs/9p-local.c
> > +++ b/hw/9pfs/9p-local.c
> > @@ -768,11 +768,11 @@ out:
> >  
> >  static int local_fid_fd(int fid_type, V9fsFidOpenState *fs)
> >  {
> > -    int fd;
> > +    int fd = -1;
> >  
> > -    if (fid_type == P9_FID_DIR) {
> > +    if (fid_type == P9_FID_DIR && fs->dir.stream != NULL) {
> >          fd = dirfd(fs->dir.stream);
> > -    } else {
> > +    } else if (fid_type == P9_FID_FILE) {
> >          fd = fs->fd;
> >      }
> 
> Follow-up on previous patch, this could be reduced to:
> 
> static int local_fid_fd(int fid_type, V9fsFidOpenState *fs)
> {
>     if (fid_type == P9_FID_DIR && fs->dir.stream != NULL) {
>         return dirfd(fs->dir.stream);
>     } else if (fid_type == P9_FID_FILE) {
>         return fs->fd;
>     }
>     return -1; /* POSIX invalid file handle */
> }
> 
> or even:
> 
> static int local_fid_fd(int fid_type, V9fsFidOpenState *fs)
> {
>     return (fid_type == P9_FID_DIR && fs->dir.stream != NULL) ?
>                dirfd(fs->dir.stream) :
>                    (fid_type == P9_FID_FILE) ? fs->fd :
>                        -1; /* POSIX invalid file handle */
> }
> 

Yuck, I'll stick to the `if` version ;-)

No sure to understand the meaning of `/* POSIX invalid file handle */` though...

> >  
> > @@ -1576,6 +1576,11 @@ static int local_parse_opts(QemuOpts *opts, FsDriverEntry *fse, Error **errp)
> >      return 0;
> >  }
> >  
> > +static bool local_has_valid_handle(int fid_type, V9fsFidOpenState *fs)
> > +{
> > +    return local_fid_fd(fid_type, fs) != -1;
> > +}
> 
> I would avoid the implied dirfd() call here. It's usually just a libc function
> on user side, so usually no context switch, but who knows if that applies to
> all systems. So adapted to existing code this would be:
> 
> static bool local_has_valid_handle(int fid_type, V9fsFidOpenState *fs)
> {
>     return (fidp->fid_type == P9_FID_FILE && fidp->fs.fd != -1) ||
>            (fidp->fid_type == P9_FID_DIR && fidp->fs.dir.stream != NULL);
> }
> 
> >  FileOperations local_ops = {
> >      .parse_opts = local_parse_opts,
> >      .init  = local_init,
> > @@ -1613,4 +1618,5 @@ FileOperations local_ops = {
> >      .name_to_path = local_name_to_path,
> >      .renameat  = local_renameat,
> >      .unlinkat = local_unlinkat,
> > +    .has_valid_handle = local_has_valid_handle,
> >  };
> > diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
> > index 2abaf3a2918a..fa0b187a1b80 100644
> > --- a/hw/9pfs/9p-synth.c
> > +++ b/hw/9pfs/9p-synth.c
> > @@ -615,6 +615,11 @@ static int synth_init(FsContext *ctx, Error **errp)
> >      return 0;
> >  }
> >  
> > +static bool synth_has_valid_handle(int fid_type, V9fsFidOpenState *fs)
> > +{
> > +    return false;
> > +}
> > +
> 
> I was worried that this would cause the synth tests to fail, but apparently it
> does not break them. So fine.
> 
> >  FileOperations synth_ops = {
> >      .init         = synth_init,
> >      .lstat        = synth_lstat,
> > @@ -650,4 +655,5 @@ FileOperations synth_ops = {
> >      .name_to_path = synth_name_to_path,
> >      .renameat     = synth_renameat,
> >      .unlinkat     = synth_unlinkat,
> > +    .has_valid_handle = synth_has_valid_handle,
> 
> Mabye rather has_valid_file_handle?
> 
> >  };
> > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > index 7cad2bce6209..969fb2f8c494 100644
> > --- a/hw/9pfs/9p.c
> > +++ b/hw/9pfs/9p.c
> > @@ -1574,6 +1574,11 @@ out_nofid:
> >      pdu_complete(pdu, err);
> >  }
> >  
> > +static bool fid_has_valid_handle(V9fsState *s, V9fsFidState *fidp)
> > +{
> > +    return s->ops->has_valid_handle(fidp->fid_type, &fidp->fs);
> > +}
> > +
> >  static void coroutine_fn v9fs_getattr(void *opaque)
> >  {
> >      int32_t fid;
> > @@ -1596,9 +1601,7 @@ static void coroutine_fn v9fs_getattr(void *opaque)
> >          retval = -ENOENT;
> >          goto out_nofid;
> >      }
> > -    if ((fidp->fid_type == P9_FID_FILE && fidp->fs.fd != -1) ||
> > -        (fidp->fid_type == P9_FID_DIR && fidp->fs.dir.stream))
> > -    {
> > +    if (fid_has_valid_handle(pdu->s, fidp)) {
> >          retval = v9fs_co_fstat(pdu, fidp, &stbuf);
> >      } else {
> >          retval = v9fs_co_lstat(pdu, &fidp->path, &stbuf);
> > 
> 
> 



-- 
Greg

