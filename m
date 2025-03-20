Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353C7C36000
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 11:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvDdA-00027v-2U; Thu, 20 Mar 2025 07:00:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tvDd6-00024F-J4
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 07:00:05 -0400
Received: from 4.mo548.mail-out.ovh.net ([188.165.42.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tvDd2-0007OJ-Bj
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 07:00:04 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.9.184])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4ZJMzb2nSqz11hl;
 Thu, 20 Mar 2025 10:59:55 +0000 (UTC)
Received: from kaod.org (37.59.142.95) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 20 Mar
 2025 11:59:54 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G00187cbd7d4-09fe-456a-a54b-e77b011d4d98,
 634753926966D39EDD754D066B00D0F2EFF7B06B) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Thu, 20 Mar 2025 11:59:38 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
CC: <qemu-devel@nongnu.org>
Subject: Re: [PATCH] 9pfs: fix 'total_open_fd' decrementation
Message-ID: <20250320115938.7a93f3fe@bahia>
In-Reply-To: <2166032.rzx9qK8laY@silver>
References: <E1tuqQb-004R61-AZ@kylie.crudebyte.com> <1820249.RkjqyYWvsj@silver>
 <20250319195251.10cd431d@bahia> <2166032.rzx9qK8laY@silver>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.95]
X-ClientProxiedBy: DAG8EX1.mxp5.local (172.16.2.71) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: 39e28e49-26c3-460e-9225-e0c62e334ace
X-Ovh-Tracer-Id: 17666213967532956058
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeektdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeegkeejtdevgeekieelffdvtedvvdegtdduudeigffhhffgvdfhgeejteekheefkeenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddrleehpdekkedrudejledrledrudehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepqhgvmhhupghoshhssegtrhhuuggvsgihthgvrdgtohhmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdpoffvtefjohhsthepmhhoheegkegmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=QwNAkOy3imNdJ4H23unmkopJ5qkuGtEeq0kT4c5wWtg=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1742468395; v=1;
 b=cUlNq/FPXn9PqM2HXJ1+ToGgX5V/MwEewkLqFzEM0etZ5NNRF1LWqvShyFozLaGgA3oVu7OP
 iYm42iYHwmq8KgYR5SgtjarTaQ2P/iUVijw2/ttuQs54j7HkYU75i/N7SPQJsyBVka2n8yUi/zP
 AZvluxh/CIQg45H3ZrGxx/RNDl9cgHhPADlQhP5r4ocI28Vj+SGJ79R/1wyfKK2XfWWe6PPG1KK
 2PDDT4dxcrn1pd0qOOVPsAqPNL1n6WwOV1gPtuWOVqPXhFMYwP8I/2wxmkhP4NSs1MQXcXefhjC
 MJL3dz/tmHq2LAJt8HVElNzdWPtYs64JEXB8MnCqTLt7w==
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

On Thu, 20 Mar 2025 10:48:11 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Wednesday, March 19, 2025 7:52:51 PM CET Greg Kurz wrote:
> > On Wed, 19 Mar 2025 13:14:27 +0100
> > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > 
> > > On Wednesday, March 19, 2025 11:08:58 AM CET Christian Schoenebeck wrote:
> > > > According to 'man 2 close' errors returned by close() should only be used
> > > > for either diagnostic purposes or for catching data loss due to a previous
> > > > write error, as an error result of close() usually indicates a deferred
> > > > error of a previous write operation.
> > > > 
> > > > Therefore not decrementing 'total_open_fd' on a close() error is wrong
> > > > and would yield in a higher open file descriptor count than actually the
> > > > case, leading to 9p server reclaiming open file descriptors too soon.
> > > > 
> > > > Based-on: <20250312152933.383967-7-groug@kaod.org>
> > > > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > > > ---
> > > >  hw/9pfs/9p.c     | 14 ++++++++------
> > > >  hw/9pfs/codir.c  |  3 ++-
> > > >  hw/9pfs/cofile.c |  3 ++-
> > > >  3 files changed, 12 insertions(+), 8 deletions(-)
> [...]
> > > > diff --git a/hw/9pfs/codir.c b/hw/9pfs/codir.c
> > > > index 2068a4779d..f1fd97c8a7 100644
> > > > --- a/hw/9pfs/codir.c
> > > > +++ b/hw/9pfs/codir.c
> > > > @@ -353,7 +353,8 @@ int coroutine_fn v9fs_co_closedir(V9fsPDU *pdu, V9fsFidOpenState *fs)
> > > >                  err = -errno;
> > > >              }
> > > >          });
> > > > -    if (!err) {
> > > > +    /* 'man 2 close' suggests to ignore close() errors except of EBADF */
> > > > +    if (!err || errno != EBADF) {
> > > >          total_open_fd--;
> > > >      }
> > > >      return err;
> > > 
> > > Or, as EBADF is somewhat unexpected here (assuming v9fs_co_closedir() was
> > > called by checking for a valid file handle), maybe it would make sense to log
> > > this?
> > > 
> > 
> > Getting EBADF could be the result of some unrelated code that closed
> > the fd from another thread or the 9p code using some stale fid structure
> > or some other serious bug. I'd personally g_assert().
> 
> Wouldn't that be too harsh? Killing QEMU should be last resort if continuing
> to run resulted in a security threat or undefined behaviour. I'm not sure that
> would apply here.
> 

Getting EBADF on a file descriptor this code is supposed to own already
smells like undefined behavior IMHO and, hopefully, such an assert should
never trigger, but I understand your concern and it's up to you to decide :-)

> > >     if (unlikely(err && errno == EBADF)) {
> > >         error_report("v9fs_co_closedir() failed with EBADF");  
> > >     } else {
> > >         total_open_fd--;
> > >     }
> > > 
> > > In the sense, if EBADF happens here, it's an indication for a bug in 9p
> > > server.
> 
> 



-- 
Greg

