Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A5A7E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 16:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM8Nb-0001Tz-2q; Fri, 13 Dec 2024 11:19:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tM8NX-0001TN-1k
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 11:19:00 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tM8NR-0000Nr-Jz
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 11:18:58 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y8vXf6tCJz6K5wR;
 Sat, 14 Dec 2024 00:13:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 2F1ED140B38;
 Sat, 14 Dec 2024 00:18:39 +0800 (CST)
Received: from localhost (10.47.76.147) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 13 Dec
 2024 17:18:38 +0100
Date: Fri, 13 Dec 2024 16:18:36 +0000
To: Gregory Price <gourry@gourry.net>
CC: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>,
 <svetly.todorov@memverge.com>, <nifan.cxl@gmail.com>
Subject: Re: [PATCH RFC v3 3/3] mhsld: implement MHSLD device
Message-ID: <20241213161836.000073d6@huawei.com>
In-Reply-To: <Z1s-4oPjHPFpnnnK@PC2K9PVX.TheFacebook.com>
References: <20241018161252.8896-1-gourry@gourry.net>
 <20241018161252.8896-4-gourry@gourry.net>
 <20241212174016.0000002a@huawei.com>
 <Z1s-4oPjHPFpnnnK@PC2K9PVX.TheFacebook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.76.147]
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 12 Dec 2024 14:52:02 -0500
Gregory Price <gourry@gourry.net> wrote:

> On Thu, Dec 12, 2024 at 05:40:16PM +0000, Jonathan Cameron via wrote:
> > On Fri, 18 Oct 2024 12:12:52 -0400
> > Gregory Price <gourry@gourry.net> wrote:
> >   
> > > From: Svetly Todorov <svetly.todorov@memverge.com>
> > > 
> > > The shared state file only needs to be intialized once. Even if a guest
> > > dies without clearing the ownership bits associated with its head-ID,
> > > future guests with that ID will clear those bits in cxl_mhsld_realize(),
> > > regardless of whether mhd_init is true or false.  
> > 
> > That sounds like a race condition if not all hosts are brought
> > up before the first add.
> >  
> 
> We weighed this against having to do an external setup like
> 
> # SHMID = ./create_sharedmem.sh
> # ./launch_qemu --shmid=$SHMID
> 
> Which is what the original non-generalized prototype did.
> 
> So yeah, there's a race condition AND a footgun (setting init AFTER
> qemu instances are already using the memory will blow the state away).
> 
> This was intended.
> 
> As you allude to in the next chunk - the only real way to get around
> this is to have an entirely external process serialize access.
>  
> > > 
> > > The following command line options create an MHSLD with 4GB of
> > > backing memory, whose state is tracked in /dev/shm/mhd_metadata.
> > > --mhd-init=true tells this instance to initialize the state as
> > > described above.
> > > 
> > > ./qemu-system_x86-64 \
> > > [... other options ...] \
> > > -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
> > > -device cxl-rp,id=rp0,bus=cxl.0,chassis=0,port=0,slot=0 \
> > > -object memory-backend-ram,id=mem0,size=4G \
> > > -device cxl-mhsld,bus=rp0,num-dc-regions=1,volatile-dc-memdev=mem0,id=cxl-mem0,sn=66667,mhd-head=0,mhd-state_file=mhd_metadata,mhd-init=true \
> > > -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G \
> > > -qmp unix:/tmp/qmp-sock-1,server,nowait
> > > 
> > > Once this guest completes setup, other guests looking to access the
> > > device can be booted with the same configuration options, but with
> > > --mhd-head != 0,
> > > --mhd-init=false,
> > > and a different QMP socket.
> > > 
> > > Signed-off-by: Gregory Price <gourry@gourry.net>
> > > Signed-off-by: Svetly Todorov <svetly.todorov@memverge.com>  
> > 
> > A few trivial things inline.
> > 
> > In general the scheme looks workable but I'm not sure the contraints at setup time
> > etc are suitable for an upstream solution.  Certainly a useful tool to have
> > for kernel development though so I'll try and find time in next few days to apply
> > this on my gitlab tree.
> > 
> > Longer term I think we need a more complex external program or a main / proxy
> > type arrangement so that ordering requirements can be enforce  
> 
> I marginally disagree.  We have to check ownership during memory use.
> 
> We should try not to have an external process dependency for deferencing a
> pointer backed by an emulated DCD device. The current overhead is bad enough.
> 
> The shared memory use here mostly limits that overhead to cache invalidation,
> and keeps the entire system fairly simple.
> 
> All this is to say - we err'd on the side of keeping it simple, even if it
> has a few stupid footguns.  Obviously open to ideas, though.

Need to mess around with it, but I don't in general think each host needs
to see the global protection map - they just need to know what they can access.

I don't think anyone is going to do 2MiB granularity on a real device
(or at least not for bulk capacity) so the necessary data may not be that large.
Obviously the cost of updating it will be higher, but meh, that's not that
common an operation.

> 
> >  and we can have
> > richer info.  Having to chat to each qmp interface independently works fine is
> > also a bit more complex than I think we would eventually want.
> >   
> 
> This is a small component in someone's fabric manager that translates their
> requests into QMP commands.  Whatever we ultimately decide on, the complexity
> here is about the same.

It's the qmp commands to a bunch of different qemu instances pretending to be one
Multi Head device.
Sure we can insert a proxy to act as that one, but then we more or less
have an external process mediating that.

> 
> > Having a solution in place though will make it much easier to move towards
> > an eventual upstreamable solution. This is a great place to start from!
> > 
> > Jonathan
> >   
> > > +/*
> > > + * We limit the number of heads to prevent the shared state
> > > + * region from becoming a major memory hog.  We need 512MB of
> > > + * memory space to track 8-host ownership of 4GB of memory in
> > > + * blocks of 2MB.  This can change if the block size is increased.  
> > 
> > I'm lost what makes up that size?
> >   
> 
> I think the math is wrong here, we may have calculated based on
> a larger capacity.  I need to go back and look at how we came to 512MB.
4TB maybe?

Jonathan
> 
> ~Gregory


