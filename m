Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37E5D5B844
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 15:30:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVAWb-0006d2-GA; Mon, 15 Dec 2025 10:30:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vVAVO-00067F-E6
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 10:29:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vVAVK-0004Ch-H9
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 10:28:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765812529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=033JI5AS/gUOEu4m0H3+u5w3ybvGCtQqyrTfFGodmTw=;
 b=EucPfyy8xf+ODad3bSQzf4nR+TXr+wJG2Q+RZ5v0eL4G3gxZYQmk20yP4CmZbQKTVFfwd7
 8LGq6dMKgB2bKXMTDapYbHpn0sNF05ZhB/xw1CYgzwsp3ROxMngLxtY9nkow1BvazfyyYL
 UGB/aT5C3MQc/8d/o32luGHSmunptAA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-M1YLvk5HOZC0iW7vf2n7YA-1; Mon,
 15 Dec 2025 10:28:47 -0500
X-MC-Unique: M1YLvk5HOZC0iW7vf2n7YA-1
X-Mimecast-MFC-AGG-ID: M1YLvk5HOZC0iW7vf2n7YA_1765812526
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38C2D1800630; Mon, 15 Dec 2025 15:28:46 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.188])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 437083000225; Mon, 15 Dec 2025 15:28:42 +0000 (UTC)
Date: Mon, 15 Dec 2025 16:28:39 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] migration: Fix a possible crash when halting a guest
 during migration
Message-ID: <aUApJ23dL8JuAayW@redhat.com>
References: <20251208135101.271417-1-thuth@redhat.com>
 <20251208144525.GA1341938@fedora> <87jyyxkna0.fsf@suse.de>
 <5b510f3b-796a-45fb-a63f-e87b02dace61@redhat.com>
 <87jyyrv1br.fsf@suse.de> <aUAQNaA_sW8hxW2Y@redhat.com>
 <e62e8105-7add-45ed-afc2-9d6b1403b135@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e62e8105-7add-45ed-afc2-9d6b1403b135@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 15.12.2025 um 16:11 hat Thomas Huth geschrieben:
> On 15/12/2025 14.42, Kevin Wolf wrote:
> > Am 12.12.2025 um 22:26 hat Fabiano Rosas geschrieben:
> > > Thomas Huth <thuth@redhat.com> writes:
> > > 
> > > > On 08/12/2025 16.26, Fabiano Rosas wrote:
> > > > > Stefan Hajnoczi <stefanha@redhat.com> writes:
> > > > > 
> > > > > > On Mon, Dec 08, 2025 at 02:51:01PM +0100, Thomas Huth wrote:
> > > > > > > From: Thomas Huth <thuth@redhat.com>
> > > > > > > 
> > > > > > > When shutting down a guest that is currently in progress of being
> > > > > > > migrated, there is a chance that QEMU might crash during bdrv_delete().
> > > > > > > The backtrace looks like this:
> > > > > > > 
> > > > > > >    Thread 74 "mig/src/main" received signal SIGSEGV, Segmentation fault.
> > > > > > > 
> > > > > > >    [Switching to Thread 0x3f7de7fc8c0 (LWP 2161436)]
> > > > > > >    0x000002aa00664012 in bdrv_delete (bs=0x2aa00f875c0) at ../../devel/qemu/block.c:5560
> > > > > > >    5560	        QTAILQ_REMOVE(&graph_bdrv_states, bs, node_list);
> > > > > > >    (gdb) bt
> > > > > > >    #0  0x000002aa00664012 in bdrv_delete (bs=0x2aa00f875c0) at ../../devel/qemu/block.c:5560
> > > > > > >    #1  bdrv_unref (bs=0x2aa00f875c0) at ../../devel/qemu/block.c:7170
> > > > > > >    Backtrace stopped: Cannot access memory at address 0x3f7de7f83e0
> > > > > > > 
> > > > > 
> > > > > How does the migration thread reaches here? Is this from
> > > > > migration_block_inactivate()?
> > > > 
> > > > Unfortunately, gdb was not very helpful here (claiming that it cannot access
> > > > the memory and stack anymore), so I had to do some printf debugging. This is
> > > > what seems to happen:
> > > > 
> > > > Main thread: qemu_cleanup() calls  migration_shutdown() -->
> > > > migration_cancel() which signals the migration thread to cancel the migration.
> > > > 
> > > > Migration thread: migration_thread() got kicked out the loop and calls
> > > > migration_iteration_finish(), which tries to get the BQL via bql_lock() but
> > > > that is currently held by another thread, so the migration thread is blocked
> > > > here.
> > > > 
> > > > Main thread: qemu_cleanup() advances to bdrv_close_all() that uses
> > > > blockdev_close_all_bdrv_states() to unref all BDS. The BDS with the name
> > > > 'libvirt-1-storage' gets deleted via bdrv_delete() that way.
> > > > 
> > > 
> > > Has qmp_blockdev_del() ever been called to remove the BDS from the
> > > monitor_bdrv_states list? Otherwise your debugging seems to indicate
> > > blockdev_close_all_bdrv_states() is dropping the last reference to bs,
> > > but it's still accessible from bdrv_next() via
> > > bdrv_next_monitor_owned().
> > 
> > The reference that blockdev_close_all_bdrv_states() drops is the monitor
> > reference. So is this the right fix (completely untested, but matches
> > what qmp_blockdev_del() does)?
> > 
> > Kevin
> > 
> > diff --git a/blockdev.c b/blockdev.c
> > index dbd1d4d3e80..6e86c6262f9 100644
> > --- a/blockdev.c
> > +++ b/blockdev.c
> > @@ -686,6 +686,7 @@ void blockdev_close_all_bdrv_states(void)
> > 
> >       GLOBAL_STATE_CODE();
> >       QTAILQ_FOREACH_SAFE(bs, &monitor_bdrv_states, monitor_list, next_bs) {
> > +        QTAILQ_REMOVE(&monitor_bdrv_states, bs, monitor_list);
> >           bdrv_unref(bs);
> >       }
> >   }
> 
> Thanks a lot, Kevin! This looks like the right fix for me - I gave it
> a try and it fixes the crash indeed!

Good. I think something like your patch would still be good for 11.0.
Having undefined order in shutdown is just asking for trouble. So it
would be good if we could be sure that migration is out of the way when
migration_shutdown() returns.

I sent the above as a proper patch to fix the immediate problem for
10.2.

Kevin


