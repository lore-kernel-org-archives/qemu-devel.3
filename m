Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB8BC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 14:39:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0iC7-0001lG-Ob; Fri, 04 Apr 2025 10:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1u0iC5-0001kw-L1
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 10:38:53 -0400
Received: from 5.mo548.mail-out.ovh.net ([188.165.49.213])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1u0iC3-0002Hm-8k
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 10:38:53 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.2.11])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4ZTh736Qwqzyjb;
 Fri,  4 Apr 2025 14:38:39 +0000 (UTC)
Received: from kaod.org (37.59.142.108) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 4 Apr
 2025 16:38:39 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-108S002c48bd4fe-144d-42e7-95f2-6a8062730647,
 9A3F3E2F2DFB301F83D8F6839EB03D9D77BE1221) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Fri, 4 Apr 2025 16:38:37 +0200
From: Greg Kurz <groug@kaod.org>
To: Zheng Huang <hz1624917200@gmail.com>
CC: <qemu-devel@nongnu.org>, Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH] hw/9pfs: add cleanup operation for 9p-synth
Message-ID: <20250404163837.45b0f97e@bahia>
In-Reply-To: <1998899.hlcO8rIAHV@silver>
References: <a4e34adc-a425-4183-bb4f-f1b8197125eb@gmail.com>
 <1998899.hlcO8rIAHV@silver>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.108]
X-ClientProxiedBy: DAG3EX1.mxp5.local (172.16.2.21) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: c9c9f601-c3cd-4438-b1d4-c4304d949b31
X-Ovh-Tracer-Id: 17216979904291707357
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduledujeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgeekjedtveegkeeileffvdetvddvgedtudduiefghffhgfdvhfegjeetkeehfeeknecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrddutdekpdekkedrudejledrledrudehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhnsggprhgtphhtthhopeefpdhrtghpthhtohephhiiudeivdegledujedvtddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhgpohhsshestghruhguvggshihtvgdrtghomhdpoffvtefjohhsthepmhhoheegkegmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=sDvD/azY6vzYGaKpr/rP8KLDa7ay2mGN/XHM8Dqm8RQ=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1743777520; v=1;
 b=hTCVBu5A8E6tCbrg8bXtfpztjbzrKCzB6hUq9a9svmZuhMTlJql4uKK8TLlIXDDh4W+r37Z6
 7p89MK+abPLl1cGpvrzZaxmouXGMtsrJB+99ltlVZlgSWR/rDmDvrizXdta+x/A6XJEFA45GLR1
 0iYps1DkilBJjAOo46Qs6KbsoQceBf1B0sWsqxrXU85SWCicLG4yR3P9b85VEE4l1V6QqUYnuSy
 UiVCSxLKBxLy5e4WZIBP5qa3fays7wIHQ3J1UIGF8aVzn7paaWHB9OzHvnJ8e88ePnG08U6UQAH
 fz0TaRKsF6lthJ1QomtdRBTXxughVM/jmEyBQpUNdOgKg==
Received-SPF: pass client-ip=188.165.49.213; envelope-from=groug@kaod.org;
 helo=5.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Fri, 04 Apr 2025 15:59:54 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Monday, March 31, 2025 3:52:31 PM CEST Zheng Huang wrote:
> > Hi,
> 
> Hi!
> 

Hi Zheng !

We certainly appreciate politeness here but we only want relevant
details in what will become the commit message. Anything else
you want to share that doesn't carry useful information about the
patch itself should go below the '---' after your Signed-off-by.

> > This patch adds a cleanup operation for 9p-synth, which fixes a memory
> > leak bug in synth_init() and other related operations. 
> 
> Which other operations?
> 
> > All child nodes
> > of synth_root need to be freed before the entire filesystem exits.
> 
> I assume this is a theoretical fix, because I currently don't see how this
> could result in memory being leaked in practice. The synth fs driver is just
> used for 9pfs's automated test cases. Shortly after cleanup handler would be
> called, the entire process is torn down anyway, and with that all memory
> being freed automatically.
> 

FWIW it can be considered a good general practice to match every g_new and
friends with a g_free. This would silent any suspicion of memory leak ;-)

> > If you have any better ideas for the implementation, please feel free
> > to share them.
> 
> By using two nested loops in synth_cleanup()? One loop for walking vertically
> (child) and one loop for walking horizontally (sibling). Then you could just
> open code everything within synth_cleanup() instead.
> 
> However I don't see a real reason for this patch in the first place.
> 

We can imagine this could be required if we decide to support hot unplug
of 9p backends but I don't believe this is something we need anytime soon.

> > Signed-off-by: Zheng Huang <hz1624917200@gmail.com>
> > 
> > 
> > ---
> >  hw/9pfs/9p-synth.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> > 
> > diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
> > index 2abaf3a291..ead8b9e3be 100644
> > --- a/hw/9pfs/9p-synth.c
> > +++ b/hw/9pfs/9p-synth.c
> > @@ -24,6 +24,7 @@
> >  #include "qemu/rcu.h"
> >  #include "qemu/rcu_queue.h"
> >  #include "qemu/cutils.h"
> > +#include "qobject/qlist.h"
> >  #include "system/qtest.h"
> >  
> >  /* Root node for synth file system */
> > @@ -136,6 +137,19 @@ int qemu_v9fs_synth_add_file(V9fsSynthNode *parent, int mode,
> >      return 0;
> >  }
> >  
> > +// Must call after get synth_mutex
> > +static void v9fs_recursive_free_node(V9fsSynthNode *node)
> > +{
> > +    V9fsSynthNode *entry;
> > +
> > +    for (entry = QLIST_FIRST(&node->child); entry;) {
> > +        V9fsSynthNode *next = QLIST_NEXT(entry, sibling);
> > +        v9fs_recursive_free_node(entry);
> > +        g_free(entry);
> > +        entry = next;
> > +    }
> > +}
> > +
> >  static void synth_fill_statbuf(V9fsSynthNode *node, struct stat *stbuf)
> >  {
> >      stbuf->st_dev = 0;
> > @@ -615,8 +629,22 @@ static int synth_init(FsContext *ctx, Error **errp)
> >      return 0;
> >  }
> >  
> > +
> > +static void synth_cleanup(FsContext *ctx)
> > +{
> > +    // recursively free all child nodes of synth_root
> > +    // V9fsSynthNode *tmp;
> > +    QEMU_LOCK_GUARD(&synth_mutex);
> > +    v9fs_recursive_free_node(&synth_root);
> > +    // QLIST_FOREACH(tmp, &synth_root.child, sibling) {
> > +    //     v9fs_recursive_free_node(tmp);
> > +    // }
> 
> No commented code in patch submissions, please.
> 
> /Christian
> 
> > +    QLIST_INIT(&synth_root.child);
> > +}
> > +
> >  FileOperations synth_ops = {
> >      .init         = synth_init,
> > +    .cleanup      = synth_cleanup,
> >      .lstat        = synth_lstat,
> >      .readlink     = synth_readlink,
> >      .close        = synth_close,
> > 
> 
> 

Cheers,

-- 
Greg

