Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7543BC0218F
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2025 12:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teZM1-0001Rs-DQ; Sun, 02 Feb 2025 07:45:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1teZLy-0001RU-Ny
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 07:45:34 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1teZLw-0005aD-Fh
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 07:45:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=X0EzwJCsmnkAVajE0RQn9zpHntN9hVxCElX6MFP7Qgo=; b=XFvBvKAO/imtPSBC
 Z0d4VZCLP3KQRzLZPaberb+FmG22lLAOY2ALrDBtlHg6ea8MR1D+oBCMfTLfmOLV58J4NXtCkS8KR
 S06dom2Gp9Ps3kpV9lUaZxCzfx00GWaMr40+O2droe74VpDdC8N6oDn55t7qS2276m1X2be9N6hc0
 9kTz7bfIPoz4MgsrkL3o7hCTipD3FLLZlKiYJKsx/SxFIvulYCF+3PZG+zaAExISbCiYhzPDFlHUr
 A8ZezF3rsvj/kRHXOttvDeHmKd9+uDTZM4OdGRGCfdsQ409IP3TN3y6FdcugIHXvfF0LD6dT9na+n
 cTlxjYHpN1HK/NSEEQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1teZLm-00D7Py-0n;
 Sun, 02 Feb 2025 12:45:22 +0000
Date: Sun, 2 Feb 2025 12:45:22 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 09/33] migration: postcopy_ram_listen_thread() needs
 to take BQL for some calls
Message-ID: <Z59o4u9zui3CPrkm@gallifrey>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <139bf266dbd1e25a1e5a050ecb82e3e59120d705.1738171076.git.maciej.szmigiero@oracle.com>
 <Z57TPqhRYY4V14BE@gallifrey>
 <d3a27b10-a7a6-4aa6-97ad-9c39f49df4fc@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <d3a27b10-a7a6-4aa6-97ad-9c39f49df4fc@maciej.szmigiero.name>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 12:23:59 up 269 days, 23:38,  2 users,  load average: 0.03, 0.05,
 0.01
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

* Maciej S. Szmigiero (mail@maciej.szmigiero.name) wrote:
> On 2.02.2025 03:06, Dr. David Alan Gilbert wrote:
> > * Maciej S. Szmigiero (mail@maciej.szmigiero.name) wrote:
> > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > > 
> > > postcopy_ram_listen_thread() is a free running thread, so it needs to
> > > take BQL around function calls to migration methods requiring BQL.
> > > 
> > > qemu_loadvm_state_main() needs BQL held since it ultimately calls
> > > "load_state" SaveVMHandlers.
> > > 
> > > migration_incoming_state_destroy() needs BQL held since it ultimately calls
> > > "load_cleanup" SaveVMHandlers.
> > > 
> > > Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> > > ---
> > >   migration/savevm.c | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/migration/savevm.c b/migration/savevm.c
> > > index b0b74140daea..0ceea9638cc1 100644
> > > --- a/migration/savevm.c
> > > +++ b/migration/savevm.c
> > > @@ -2013,7 +2013,9 @@ static void *postcopy_ram_listen_thread(void *opaque)
> > >        * in qemu_file, and thus we must be blocking now.
> > >        */
> > >       qemu_file_set_blocking(f, true);
> > > +    bql_lock();
> > >       load_res = qemu_loadvm_state_main(f, mis);
> > > +    bql_unlock();
> > 
> > Doesn't that leave that held for a heck of a long time?
> 
> Yes, and it effectively broke "postcopy recover" test but I
> think the reason for that is qemu_loadvm_state_main() and
> its children don't drop BQL while waiting for I/O.
> 
> I've described this case in more detail in my reply to Fabiano here:
> https://lore.kernel.org/qemu-devel/0a09e627-955e-4f26-8d08-0192ecd250a8@maciej.szmigiero.name/

While it might be the cause in this case, my feeling is it's more fundamental
here - it's the whole reason that postcopy has a separate ram listen
thread.  As the destination is running, after it loads it's devices
and as it starts up the destination will be still loading RAM 
(and other postcopiable devices) potentially for quite a while.
Holding the bql around the ram listen thread means that the
execution of the destination won't be able to take that lock
until the postcopy load has finished; so while that might apparently
complete, it'll lead to the destination stalling until that's finished
which defeats the whole point of postcopy.
That last one probably won't fail a test but it will lead to a long stall
if you give it a nice big guest with lots of RAM that it's rapidly
changing.

> I still think that "load_state" SaveVMHandlers need to be called
> with BQL held since implementations apparently expect it that way:
> for example, I think PCI device configuration restore calls
> address space manipulation methods which abort() if called
> without BQL held.

However, the only devices that *should* be arriving on the channel
that the postcopy_ram_listen_thread is reading from are those
that are postcopiable (i.e. RAM and hmm block's dirty_bitmap).
Those load handlers are safe to be run while the other devices
are being changed.   Note the *should* - you could add a check
to fail if any other device arrives on that channel.

> I have previously even submitted a patch to explicitly document
> "load_state" SaveVMHandler as requiring BQL (which was also
> included in the previous version of this patch set) and it
> received a "Reviewed-by:" tag:
> https://lore.kernel.org/qemu-devel/6976f129df610c8207da4e531c8c0475ec204fa4.1730203967.git.maciej.szmigiero@oracle.com/
> https://lore.kernel.org/qemu-devel/e1949839932efaa531e2fe63ac13324e5787439c.1731773021.git.maciej.szmigiero@oracle.com/
> https://lore.kernel.org/qemu-devel/87o732bti7.fsf@suse.de/

It happens!
You could make this safer by having a load_state and a load_state_postcopy
member, and only mark the load_state as requiring the lock.

> It's also worth noting that COLO equivalent of postcopy
> incoming thread (colo_process_incoming_thread()) explicitly
> takes BQL around qemu_loadvm_state_main():
> >     bql_lock();
> >     cpu_synchronize_all_states();
> >     ret = qemu_loadvm_state_main(mis->from_src_file, mis);
> >     bql_unlock();
> 

It's not a straight equivalent; it's about a decade since I've
thought about COLO, so I can't quite remember when that thread
runs.

> > That RAM loading has to happen in parallel with the loading of
> > devices doesn't it - especially if one of the devices
> > being loaded touches RAM.
> > 
> > (I wish this series had a description in the cover letter!)
> 
> I guess you mean "more detailed description" since there's
> a paragraph about this patch in this series cover letter change log:
> > * postcopy_ram_listen_thread() now takes BQL around function calls that
> > ultimately call migration methods requiring BQL.
> > This fixes one of QEMU tests failing when explicitly BQL-sensitive code
> > is added later to these methods.

I meant a higher level description of what the series is doing.

Dave

> 
> > Dave
> 
> Thanks,
> Maciej
> 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

