Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DBDD5B16F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 13:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV8qV-0003Py-FC; Mon, 15 Dec 2025 08:42:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vV8qQ-0003PI-4J
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 08:42:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vV8qJ-0002Rf-Ov
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 08:42:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765806145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OreHuYCYbwb7uv//PeS+Wk4RFtO7cFifV8NJXlJ/EC4=;
 b=D5zxQh9oMHeglWzq9LCLy+lh4Bgh2CuUDqI4+P7s7WseXQlZmvN6qccPYRExJ0jiaCOBGX
 VartHXnCXBBFDcwMU+w6Bv7d0rc6nAITaHV+Rpq3WYxJ7ym8YdDlshyQCE1ts9+K8IFexa
 IRSd4FUgDSricHrQr7VSn6Yk4BB6/cA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-0AWhfSHyNsKa9VMs44e95w-1; Mon,
 15 Dec 2025 08:42:22 -0500
X-MC-Unique: 0AWhfSHyNsKa9VMs44e95w-1
X-Mimecast-MFC-AGG-ID: 0AWhfSHyNsKa9VMs44e95w_1765806141
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8AFFF195DE49; Mon, 15 Dec 2025 13:42:20 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.188])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 50DEE1800576; Mon, 15 Dec 2025 13:42:16 +0000 (UTC)
Date: Mon, 15 Dec 2025 14:42:13 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] migration: Fix a possible crash when halting a guest
 during migration
Message-ID: <aUAQNaA_sW8hxW2Y@redhat.com>
References: <20251208135101.271417-1-thuth@redhat.com>
 <20251208144525.GA1341938@fedora> <87jyyxkna0.fsf@suse.de>
 <5b510f3b-796a-45fb-a63f-e87b02dace61@redhat.com>
 <87jyyrv1br.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jyyrv1br.fsf@suse.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

Am 12.12.2025 um 22:26 hat Fabiano Rosas geschrieben:
> Thomas Huth <thuth@redhat.com> writes:
> 
> > On 08/12/2025 16.26, Fabiano Rosas wrote:
> >> Stefan Hajnoczi <stefanha@redhat.com> writes:
> >> 
> >>> On Mon, Dec 08, 2025 at 02:51:01PM +0100, Thomas Huth wrote:
> >>>> From: Thomas Huth <thuth@redhat.com>
> >>>>
> >>>> When shutting down a guest that is currently in progress of being
> >>>> migrated, there is a chance that QEMU might crash during bdrv_delete().
> >>>> The backtrace looks like this:
> >>>>
> >>>>   Thread 74 "mig/src/main" received signal SIGSEGV, Segmentation fault.
> >>>>
> >>>>   [Switching to Thread 0x3f7de7fc8c0 (LWP 2161436)]
> >>>>   0x000002aa00664012 in bdrv_delete (bs=0x2aa00f875c0) at ../../devel/qemu/block.c:5560
> >>>>   5560	        QTAILQ_REMOVE(&graph_bdrv_states, bs, node_list);
> >>>>   (gdb) bt
> >>>>   #0  0x000002aa00664012 in bdrv_delete (bs=0x2aa00f875c0) at ../../devel/qemu/block.c:5560
> >>>>   #1  bdrv_unref (bs=0x2aa00f875c0) at ../../devel/qemu/block.c:7170
> >>>>   Backtrace stopped: Cannot access memory at address 0x3f7de7f83e0
> >>>>
> >> 
> >> How does the migration thread reaches here? Is this from
> >> migration_block_inactivate()?
> >
> > Unfortunately, gdb was not very helpful here (claiming that it cannot access 
> > the memory and stack anymore), so I had to do some printf debugging. This is 
> > what seems to happen:
> >
> > Main thread: qemu_cleanup() calls  migration_shutdown() --> 
> > migration_cancel() which signals the migration thread to cancel the migration.
> >
> > Migration thread: migration_thread() got kicked out the loop and calls 
> > migration_iteration_finish(), which tries to get the BQL via bql_lock() but 
> > that is currently held by another thread, so the migration thread is blocked 
> > here.
> >
> > Main thread: qemu_cleanup() advances to bdrv_close_all() that uses 
> > blockdev_close_all_bdrv_states() to unref all BDS. The BDS with the name 
> > 'libvirt-1-storage' gets deleted via bdrv_delete() that way.
> >
> 
> Has qmp_blockdev_del() ever been called to remove the BDS from the
> monitor_bdrv_states list? Otherwise your debugging seems to indicate
> blockdev_close_all_bdrv_states() is dropping the last reference to bs,
> but it's still accessible from bdrv_next() via
> bdrv_next_monitor_owned().

The reference that blockdev_close_all_bdrv_states() drops is the monitor
reference. So is this the right fix (completely untested, but matches
what qmp_blockdev_del() does)?

Kevin

diff --git a/blockdev.c b/blockdev.c
index dbd1d4d3e80..6e86c6262f9 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -686,6 +686,7 @@ void blockdev_close_all_bdrv_states(void)

     GLOBAL_STATE_CODE();
     QTAILQ_FOREACH_SAFE(bs, &monitor_bdrv_states, monitor_list, next_bs) {
+        QTAILQ_REMOVE(&monitor_bdrv_states, bs, monitor_list);
         bdrv_unref(bs);
     }
 }


