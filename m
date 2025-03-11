Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39EF2C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 14:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts0B0-0002mH-Ir; Tue, 11 Mar 2025 10:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1ts0Az-0002lr-KA
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 10:01:45 -0400
Received: from 5.mo548.mail-out.ovh.net ([188.165.49.213])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1ts0Aw-0003U2-L5
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 10:01:45 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.140.27])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4ZBwRJ0mByz11jn;
 Tue, 11 Mar 2025 14:01:32 +0000 (UTC)
Received: from kaod.org (37.59.142.106) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 11 Mar
 2025 15:01:31 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R00675ca5ee7-4c5d-4e79-8003-b337f08c9908,
 9EC908457B01BCAD6949D5412F5E8CCE0041A118) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Tue, 11 Mar 2025 15:01:30 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
CC: <qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/4] 9pfs: local : Introduce local_fid_fd() helper
Message-ID: <20250311150130.7a875e63@bahia>
In-Reply-To: <23860256.nhtPhaig3F@silver>
References: <20250310171101.138380-1-groug@kaod.org>
 <20250310171101.138380-2-groug@kaod.org>
 <23860256.nhtPhaig3F@silver>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG3EX2.mxp5.local (172.16.2.22) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: 6fb14d6e-1564-47ec-aa55-83c813a0c624
X-Ovh-Tracer-Id: 4772408230763993498
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddvgeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeegkeejtdevgeekieelffdvtedvvdegtdduudeigffhhffgvdfhgeejteekheefkeenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddruddtiedpkeekrddujeelrdelrdduheegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdpnhgspghrtghpthhtohepvddprhgtphhtthhopehqvghmuhgpohhsshestghruhguvggshihtvgdrtghomhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdfovfetjfhoshhtpehmohehgeekmgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=BYHvSyoavqBNeHhqzMwCgTmbF3iSrIl7dW8MsJaV718=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1741701692; v=1;
 b=Vf6LcewmVRfEFuL/7KNxMcFs+sIPjLQWT4G44dF1oVHzGb3tkxHuQSVPTfRyM0nSHOGA2la9
 y5zghGVNq6Pe43LpAfoXNG7ndzJq1JIIezbgtkp3XmdnoSar7VzqU4ZuGSop3TywpuHoISjH2Dw
 /6OsrfXGFnrNhLfUanWfzaGFn903hvTb9of0IIwIX8iXRb6AGEo2INz0wNLNihFSbQOwvlsg0IK
 2wSh4FstE052Sessj9ziH0LaykCw1cTiAdK59d3pxfDJ3/oseaaZd7AW5PlaWyBsUioCLFv0VqU
 KDHMe6/p1pSgAExCQbCmpFwAeVpPQHT9/gHsRabES3MQg==
Received-SPF: pass client-ip=188.165.49.213; envelope-from=groug@kaod.org;
 helo=5.mo548.mail-out.ovh.net
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

On Tue, 11 Mar 2025 11:58:28 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Monday, March 10, 2025 6:10:58 PM CET Greg Kurz wrote:
> > Factor out duplicated code to a single helper. More users to come.
> > 
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/9pfs/9p-local.c | 21 +++++++++++----------
> >  1 file changed, 11 insertions(+), 10 deletions(-)
> > 
> > diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> > index 928523afcc6c..c4366c867988 100644
> > --- a/hw/9pfs/9p-local.c
> > +++ b/hw/9pfs/9p-local.c
> > @@ -766,10 +766,9 @@ out:
> >      return err;
> >  }
> >  
> > -static int local_fstat(FsContext *fs_ctx, int fid_type,
> > -                       V9fsFidOpenState *fs, struct stat *stbuf)
> > +static int local_fid_fd(int fid_type, V9fsFidOpenState *fs)
> >  {
> > -    int err, fd;
> > +    int fd;
> >  
> >      if (fid_type == P9_FID_DIR) {
> >          fd = dirfd(fs->dir.stream);
> > @@ -777,6 +776,14 @@ static int local_fstat(FsContext *fs_ctx, int fid_type,
> >          fd = fs->fd;
> >      }
> >  
> > +    return fd;
> > +}
> 
> Maybe simplifying this like:
> 
> static int local_fid_fd(int fid_type, V9fsFidOpenState *fs)
> {
>     if (fid_type == P9_FID_DIR) {
>         return dirfd(fs->dir.stream);
>     } else {
>         return fs->fd;
>     }
> }
> 
> or even just:
> 
> static int local_fid_fd(int fid_type, V9fsFidOpenState *fs)
> {
>     return (fid_type == P9_FID_DIR) ? dirfd(fs->dir.stream) : return fs->fd;
> }
> 

I'll go for you suggestion with the `if`. It is clearer than the ternary
expression and it is easier to put a breakpoint. I'm pretty sure all three
result in the same assembly code anyway.

> /Christian
> 
> > +
> > +static int local_fstat(FsContext *fs_ctx, int fid_type,
> > +                       V9fsFidOpenState *fs, struct stat *stbuf)
> > +{
> > +    int err, fd = local_fid_fd(fid_type, fs);
> > +
> >      err = fstat(fd, stbuf);
> >      if (err) {
> >          return err;
> > @@ -1167,13 +1174,7 @@ out:
> >  static int local_fsync(FsContext *ctx, int fid_type,
> >                         V9fsFidOpenState *fs, int datasync)
> >  {
> > -    int fd;
> > -
> > -    if (fid_type == P9_FID_DIR) {
> > -        fd = dirfd(fs->dir.stream);
> > -    } else {
> > -        fd = fs->fd;
> > -    }
> > +    int fd = local_fid_fd(fid_type, fs);
> >  
> >      if (datasync) {
> >          return qemu_fdatasync(fd);
> > 
> 
> 



-- 
Greg

