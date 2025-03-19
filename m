Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF24C35FFF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 18:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuyXU-0008NM-Oc; Wed, 19 Mar 2025 14:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tuyXL-0008Ml-Kq
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 14:53:09 -0400
Received: from 4.mo548.mail-out.ovh.net ([188.165.42.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tuyXI-0008Nd-Gh
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 14:53:07 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.9.151])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4ZHyWm5XRdzyXZ;
 Wed, 19 Mar 2025 18:52:52 +0000 (UTC)
Received: from kaod.org (37.59.142.96) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 19 Mar
 2025 19:52:52 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R001613e9932-9758-4b2d-ac7b-7c7014d4023d,
 F33E89BC3153CD473BC01823D7E7D50DAC700E32) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Wed, 19 Mar 2025 19:52:51 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
CC: <qemu-devel@nongnu.org>
Subject: Re: [PATCH] 9pfs: fix 'total_open_fd' decrementation
Message-ID: <20250319195251.10cd431d@bahia>
In-Reply-To: <1820249.RkjqyYWvsj@silver>
References: <E1tuqQb-004R61-AZ@kylie.crudebyte.com> <1820249.RkjqyYWvsj@silver>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG7EX1.mxp5.local (172.16.2.61) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: 8e8a671e-217e-47ab-b984-0d268f1aca1c
X-Ovh-Tracer-Id: 1334191390722857370
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeeiuddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeegkeejtdevgeekieelffdvtedvvdegtdduudeigffhhffgvdfhgeejteekheefkeenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddrleeipdekkedrudejledrledrudehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepqhgvmhhupghoshhssegtrhhuuggvsgihthgvrdgtohhmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdpoffvtefjohhsthepmhhoheegkegmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=iYJiybmu5tEwAOXkYlmcLKHgkdTMoQrYKF6nu9NVoJA=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1742410373; v=1;
 b=C6MDFeNq3r7xf3xUJ6oyp+gCbm75N6F0YuL9wL27Ja2ZKtDu9iwyZyuayn04R/rsCg6Aj0OT
 6x2M/HYRAkAs6zvhbCfXe58V5TvBGavS7UU+mhcLbWGUqi6q5/WsJQUd6sPF1JRkui7zHQ6lrjM
 Sci3t5lKr8YQNzcM4WdwL3YDQ9uh5zMbptqZqUTX8RzX7d9WouRImWaRbVXyvZvpInV9y4/CwVe
 R7YzHo38S5S27nP7ucc69sqTp7Lqpb9EWt0diq/KvCS7OYsTvg37+FvRSCVKsQbpDXOdhqgvUFv
 kXnayts3rTX5cuwR1XkDDG1xZNVOV5dFuaECUPtmLPb6g==
Received-SPF: pass client-ip=188.165.42.229; envelope-from=groug@kaod.org;
 helo=4.mo548.mail-out.ovh.net
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

On Wed, 19 Mar 2025 13:14:27 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Wednesday, March 19, 2025 11:08:58 AM CET Christian Schoenebeck wrote:
> > According to 'man 2 close' errors returned by close() should only be used
> > for either diagnostic purposes or for catching data loss due to a previous
> > write error, as an error result of close() usually indicates a deferred
> > error of a previous write operation.
> > 
> > Therefore not decrementing 'total_open_fd' on a close() error is wrong
> > and would yield in a higher open file descriptor count than actually the
> > case, leading to 9p server reclaiming open file descriptors too soon.
> > 
> > Based-on: <20250312152933.383967-7-groug@kaod.org>
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> >  hw/9pfs/9p.c     | 14 ++++++++------
> >  hw/9pfs/codir.c  |  3 ++-
> >  hw/9pfs/cofile.c |  3 ++-
> >  3 files changed, 12 insertions(+), 8 deletions(-)
> > 
> > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > index b22df3aa2b..f4ca8e4db5 100644
> > --- a/hw/9pfs/9p.c
> > +++ b/hw/9pfs/9p.c
> > @@ -434,7 +434,6 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
> >      V9fsFidState *f;
> >      GHashTableIter iter;
> >      gpointer fid;
> > -    int err;
> >      int nclosed = 0;
> >  
> >      /* prevent multiple coroutines running this function simultaniously */
> > @@ -507,13 +506,16 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
> >       */
> >      v9fs_co_run_in_worker({
> >          QSLIST_FOREACH(f, &reclaim_list, reclaim_next) {
> > -            err = (f->fid_type == P9_FID_DIR) ?
> > +            /*
> > +             * 'man 2 close' suggests to ignore close() errors except of EBADF,
> > +             * not checking for EBADF here either as FIDs were picked above by
> > +             * having a valid file descriptor
> > +             */
> > +            (f->fid_type == P9_FID_DIR) ?
> >                  s->ops->closedir(&s->ctx, &f->fs_reclaim) :
> >                  s->ops->close(&s->ctx, &f->fs_reclaim);
> > -            if (!err) {
> > -                /* total_open_fd must only be mutated on main thread */
> > -                nclosed++;
> > -            }
> > +            /* total_open_fd must only be mutated on main thread */
> > +            nclosed++;
> >          }
> >      });
> >      total_open_fd -= nclosed;
> > diff --git a/hw/9pfs/codir.c b/hw/9pfs/codir.c
> > index 2068a4779d..f1fd97c8a7 100644
> > --- a/hw/9pfs/codir.c
> > +++ b/hw/9pfs/codir.c
> > @@ -353,7 +353,8 @@ int coroutine_fn v9fs_co_closedir(V9fsPDU *pdu, V9fsFidOpenState *fs)
> >                  err = -errno;
> >              }
> >          });
> > -    if (!err) {
> > +    /* 'man 2 close' suggests to ignore close() errors except of EBADF */
> > +    if (!err || errno != EBADF) {
> >          total_open_fd--;
> >      }
> >      return err;
> 
> Or, as EBADF is somewhat unexpected here (assuming v9fs_co_closedir() was
> called by checking for a valid file handle), maybe it would make sense to log
> this?
> 

Getting EBADF could be the result of some unrelated code that closed
the fd from another thread or the 9p code using some stale fid structure
or some other serious bug. I'd personally g_assert().

>     if (unlikely(err && errno == EBADF)) {
>         error_report("v9fs_co_closedir() failed with EBADF");  
>     } else {
>         total_open_fd--;
>     }
> 
> In the sense, if EBADF happens here, it's an indication for a bug in 9p
> server.
> 
> > diff --git a/hw/9pfs/cofile.c b/hw/9pfs/cofile.c
> > index 71174c3e4a..1e9f6da42a 100644
> > --- a/hw/9pfs/cofile.c
> > +++ b/hw/9pfs/cofile.c
> > @@ -197,7 +197,8 @@ int coroutine_fn v9fs_co_close(V9fsPDU *pdu, V9fsFidOpenState *fs)
> >                  err = -errno;
> >              }
> >          });
> > -    if (!err) {
> > +    /* 'man 2 close' suggests to ignore close() errors except of EBADF */
> > +    if (!err || errno != EBADF) {
> >          total_open_fd--;
> >      }
> >      return err;
> 
> Same here then.
> 
> /Christian
> 
> 

-- 
Greg

