Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BAB3C3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 17:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAuHm-0006K5-D2; Fri, 02 May 2025 13:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uAuHe-0006IY-Nc
 for qemu-devel@nongnu.org; Fri, 02 May 2025 13:34:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uAuHb-0008IU-7Q
 for qemu-devel@nongnu.org; Fri, 02 May 2025 13:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746207280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=13PXiwidcjY6nWqCrEDP49278zcSms6jyhZ3yRJq7CY=;
 b=eiDM/tIkMShBY2nGtQ9gfg5kPZL+sKirFD+cJEVvgH98HIPoRH/uyFJcYGJLgyPHuW2xh5
 R2j+Vcvgk0AKLL+SsUtuTyf7pxjyKhwRPjs+mpKyIKdKoXvd22G1llyoEPmFESBbcYkOy7
 Pc9dkJH44xr1e+uhNbQ/tDq6sxwBZCE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-_Atg9wzeObGRMilj6jsmCg-1; Fri,
 02 May 2025 13:34:37 -0400
X-MC-Unique: _Atg9wzeObGRMilj6jsmCg-1
X-Mimecast-MFC-AGG-ID: _Atg9wzeObGRMilj6jsmCg_1746207276
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8E2D1800261; Fri,  2 May 2025 17:34:35 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.86])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A707E1956094; Fri,  2 May 2025 17:34:33 +0000 (UTC)
Date: Fri, 2 May 2025 19:34:31 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>
Subject: Re: [BUG, RFC] Block graph deadlock on job-dismiss
Message-ID: <aBUCJ0JKiSmegNDT@redhat.com>
References: <73839c04-7616-407e-b057-80ca69e63f51@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73839c04-7616-407e-b057-80ca69e63f51@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 24.04.2025 um 19:32 hat Andrey Drobyshev geschrieben:
> Hi all,
> 
> There's a bug in block layer which leads to block graph deadlock.
> Notably, it takes place when blockdev IO is processed within a separate
> iothread.
> 
> This was initially caught by our tests, and I was able to reduce it to a
> relatively simple reproducer.  Such deadlocks are probably supposed to
> be covered in iotests/graph-changes-while-io, but this deadlock isn't.
> 
> Basically what the reproducer does is launches QEMU with a drive having
> 'iothread' option set, creates a chain of 2 snapshots, launches
> block-commit job for a snapshot and then dismisses the job, starting
> from the lower snapshot.  If the guest is issuing IO at the same time,
> there's a race in acquiring block graph lock and a potential deadlock.
> 
> Here's how it can be reproduced:
> 
> 1. Run QEMU:
> > SRCDIR=/path/to/srcdir                                                                                                                                         
> >                                                                                 
> > $SRCDIR/build/qemu-system-x86_64 -enable-kvm \                                  
> >   -machine q35 -cpu Nehalem \                                                   
> >   -name guest=alma8-vm,debug-threads=on \                                       
> >   -m 2g -smp 2 \                                                                
> >   -nographic -nodefaults \                                                      
> >   -qmp unix:/var/run/alma8-qmp.sock,server=on,wait=off \                           
> >   -serial unix:/var/run/alma8-serial.sock,server=on,wait=off \                     
> >   -object iothread,id=iothread0 \                                               
> >   -blockdev node-name=disk,driver=qcow2,file.driver=file,file.filename=/path/to/img/alma8.qcow2 \
> >   -device virtio-blk-pci,drive=disk,iothread=iothread0
> 
> 2. Launch IO (random reads) from within the guest:
> > nc -U /var/run/alma8-serial.sock
> > ...
> > [root@alma8-vm ~]# fio --name=randread --ioengine=libaio --direct=1 --bs=4k --size=1G --numjobs=1 --time_based=1 --runtime=300 --group_reporting --rw=randread --iodepth=1 --filename=/testfile
> 
> 3. Run snapshots creation & removal of lower snapshot operation in a
> loop (script attached):
> > while /bin/true ; do ./remove_lower_snap.sh ; done
> 
> And then it occasionally hangs.
> 
> Note: I've tried bisecting this, and looks like deadlock occurs starting
> from the following commit:
> 
> (BAD)  5bdbaebcce virtio: Re-enable notifications after drain
> (GOOD) c42c3833e0 virtio-scsi: Attach event vq notifier with no_poll
> 
> On the latest v10.0.0 it does hang as well.
> 
> 
> Here's backtrace of the main thread:
> 
> > #0  0x00007fc547d427ce in __ppoll (fds=0x557eb79657b0, nfds=1, timeout=<optimized out>, sigmask=0x0) at ../sysdeps/unix/sysv/linux/ppoll.c:43
> > #1  0x0000557eb47d955c in qemu_poll_ns (fds=0x557eb79657b0, nfds=1, timeout=-1) at ../util/qemu-timer.c:329
> > #2  0x0000557eb47b2204 in fdmon_poll_wait (ctx=0x557eb76c5f20, ready_list=0x7ffd94b4edd8, timeout=-1) at ../util/fdmon-poll.c:79
> > #3  0x0000557eb47b1c45 in aio_poll (ctx=0x557eb76c5f20, blocking=true) at ../util/aio-posix.c:730
> > #4  0x0000557eb4621edd in bdrv_do_drained_begin (bs=0x557eb795e950, parent=0x0, poll=true) at ../block/io.c:378
> > #5  0x0000557eb4621f7b in bdrv_drained_begin (bs=0x557eb795e950) at ../block/io.c:391
> > #6  0x0000557eb45ec125 in bdrv_change_aio_context (bs=0x557eb795e950, ctx=0x557eb76c5f20, visited=0x557eb7e06b60 = {...}, tran=0x557eb7a87160, errp=0x0)
> >     at ../block.c:7682
> > #7  0x0000557eb45ebf2b in bdrv_child_change_aio_context (c=0x557eb7964250, ctx=0x557eb76c5f20, visited=0x557eb7e06b60 = {...}, tran=0x557eb7a87160, errp=0x0)
> >     at ../block.c:7608
> > #8  0x0000557eb45ec0c4 in bdrv_change_aio_context (bs=0x557eb79575e0, ctx=0x557eb76c5f20, visited=0x557eb7e06b60 = {...}, tran=0x557eb7a87160, errp=0x0)
> >     at ../block.c:7668
> > #9  0x0000557eb45ebf2b in bdrv_child_change_aio_context (c=0x557eb7e59110, ctx=0x557eb76c5f20, visited=0x557eb7e06b60 = {...}, tran=0x557eb7a87160, errp=0x0)
> >     at ../block.c:7608
> > #10 0x0000557eb45ec0c4 in bdrv_change_aio_context (bs=0x557eb7e51960, ctx=0x557eb76c5f20, visited=0x557eb7e06b60 = {...}, tran=0x557eb7a87160, errp=0x0)
> >     at ../block.c:7668
> > #11 0x0000557eb45ebf2b in bdrv_child_change_aio_context (c=0x557eb814ed80, ctx=0x557eb76c5f20, visited=0x557eb7e06b60 = {...}, tran=0x557eb7a87160, errp=0x0)
> >     at ../block.c:7608
> > #12 0x0000557eb45ee8e4 in child_job_change_aio_ctx (c=0x557eb7c9d3f0, ctx=0x557eb76c5f20, visited=0x557eb7e06b60 = {...}, tran=0x557eb7a87160, errp=0x0)
> >     at ../blockjob.c:157
> > #13 0x0000557eb45ebe2d in bdrv_parent_change_aio_context (c=0x557eb7c9d3f0, ctx=0x557eb76c5f20, visited=0x557eb7e06b60 = {...}, tran=0x557eb7a87160, errp=0x0)
> >     at ../block.c:7592
> > #14 0x0000557eb45ec06b in bdrv_change_aio_context (bs=0x557eb7d74310, ctx=0x557eb76c5f20, visited=0x557eb7e06b60 = {...}, tran=0x557eb7a87160, errp=0x0)
> >     at ../block.c:7661
> > #15 0x0000557eb45dcd7e in bdrv_child_cb_change_aio_ctx
> >     (child=0x557eb8565af0, ctx=0x557eb76c5f20, visited=0x557eb7e06b60 = {...}, tran=0x557eb7a87160, errp=0x0) at ../block.c:1234
> > #16 0x0000557eb45ebe2d in bdrv_parent_change_aio_context (c=0x557eb8565af0, ctx=0x557eb76c5f20, visited=0x557eb7e06b60 = {...}, tran=0x557eb7a87160, errp=0x0)
> >     at ../block.c:7592
> > #17 0x0000557eb45ec06b in bdrv_change_aio_context (bs=0x557eb79575e0, ctx=0x557eb76c5f20, visited=0x557eb7e06b60 = {...}, tran=0x557eb7a87160, errp=0x0)
> >     at ../block.c:7661
> > #18 0x0000557eb45ec1f3 in bdrv_try_change_aio_context (bs=0x557eb79575e0, ctx=0x557eb76c5f20, ignore_child=0x0, errp=0x0) at ../block.c:7715
> > #19 0x0000557eb45e1b15 in bdrv_root_unref_child (child=0x557eb7966f30) at ../block.c:3317
> > #20 0x0000557eb45eeaa8 in block_job_remove_all_bdrv (job=0x557eb7952800) at ../blockjob.c:209
> > #21 0x0000557eb45ee641 in block_job_free (job=0x557eb7952800) at ../blockjob.c:82
> > #22 0x0000557eb45f17af in job_unref_locked (job=0x557eb7952800) at ../job.c:474
> > #23 0x0000557eb45f257d in job_do_dismiss_locked (job=0x557eb7952800) at ../job.c:771
> > #24 0x0000557eb45f25fe in job_dismiss_locked (jobptr=0x7ffd94b4f400, errp=0x7ffd94b4f488) at ../job.c:783
> > --Type <RET> for more, q to quit, c to continue without paging--
> > #25 0x0000557eb45d8e84 in qmp_job_dismiss (id=0x557eb7aa42b0 "commit-snap1", errp=0x7ffd94b4f488) at ../job-qmp.c:138
> > #26 0x0000557eb472f6a3 in qmp_marshal_job_dismiss (args=0x7fc52c00a3b0, ret=0x7fc53c880da8, errp=0x7fc53c880da0) at qapi/qapi-commands-job.c:221
> > #27 0x0000557eb47a35f3 in do_qmp_dispatch_bh (opaque=0x7fc53c880e40) at ../qapi/qmp-dispatch.c:128
> > #28 0x0000557eb47d1cd2 in aio_bh_call (bh=0x557eb79568f0) at ../util/async.c:172
> > #29 0x0000557eb47d1df5 in aio_bh_poll (ctx=0x557eb76c0200) at ../util/async.c:219
> > #30 0x0000557eb47b12f3 in aio_dispatch (ctx=0x557eb76c0200) at ../util/aio-posix.c:436
> > #31 0x0000557eb47d2266 in aio_ctx_dispatch (source=0x557eb76c0200, callback=0x0, user_data=0x0) at ../util/async.c:361
> > #32 0x00007fc549232f4f in g_main_dispatch (context=0x557eb76c6430) at ../glib/gmain.c:3364
> > #33 g_main_context_dispatch (context=0x557eb76c6430) at ../glib/gmain.c:4079
> > #34 0x0000557eb47d3ab1 in glib_pollfds_poll () at ../util/main-loop.c:287
> > #35 0x0000557eb47d3b38 in os_host_main_loop_wait (timeout=0) at ../util/main-loop.c:310
> > #36 0x0000557eb47d3c58 in main_loop_wait (nonblocking=0) at ../util/main-loop.c:589
> > #37 0x0000557eb4218b01 in qemu_main_loop () at ../system/runstate.c:835
> > #38 0x0000557eb46df166 in qemu_default_main (opaque=0x0) at ../system/main.c:50
> > #39 0x0000557eb46df215 in main (argc=24, argv=0x7ffd94b4f8d8) at ../system/main.c:80
> 
> 
> And here's coroutine trying to acquire read lock:
> 
> > (gdb) qemu coroutine reader_queue->entries.sqh_first 
> > #0  0x0000557eb47d7068 in qemu_coroutine_switch (from_=0x557eb7aa48b0, to_=0x7fc537fff508, action=COROUTINE_YIELD) at ../util/coroutine-ucontext.c:321
> > #1  0x0000557eb47d4d4a in qemu_coroutine_yield () at ../util/qemu-coroutine.c:339
> > #2  0x0000557eb47d56c8 in qemu_co_queue_wait_impl (queue=0x557eb59954c0 <reader_queue>, lock=0x7fc53c57de50, flags=0) at ../util/qemu-coroutine-lock.c:60
> > #3  0x0000557eb461fea7 in bdrv_graph_co_rdlock () at ../block/graph-lock.c:231
> > #4  0x0000557eb460c81a in graph_lockable_auto_lock (x=0x7fc53c57dee3) at /home/root/src/qemu/master/include/block/graph-lock.h:213
> > #5  0x0000557eb460fa41 in blk_co_do_preadv_part
> >     (blk=0x557eb84c0810, offset=6890553344, bytes=4096, qiov=0x7fc530006988, qiov_offset=0, flags=BDRV_REQ_REGISTERED_BUF) at ../block/block-backend.c:1339
> > #6  0x0000557eb46104d7 in blk_aio_read_entry (opaque=0x7fc530003240) at ../block/block-backend.c:1619
> > #7  0x0000557eb47d6c40 in coroutine_trampoline (i0=-1213577040, i1=21886) at ../util/coroutine-ucontext.c:175
> > #8  0x00007fc547c2a360 in __start_context () at ../sysdeps/unix/sysv/linux/x86_64/__start_context.S:91
> > #9  0x00007ffd94b4ea40 in  ()
> > #10 0x0000000000000000 in  ()
> 
> 
> So it looks like main thread is processing job-dismiss request and is
> holding write lock taken in block_job_remove_all_bdrv() (frame #20
> above).  At the same time iothread spawns a coroutine which performs IO
> request.  Before the coroutine is spawned, blk_aio_prwv() increases
> 'in_flight' counter for Blk.  Then blk_co_do_preadv_part() (frame #5) is
> trying to acquire the read lock.  But main thread isn't releasing the
> lock as blk_root_drained_poll() returns true since blk->in_flight > 0.
> Here's the deadlock.
> 
> Any comments and suggestions on the subject are welcomed.  Thanks!

I think this is what the blk_wait_while_drained() call was supposed to
address in blk_co_do_preadv_part(). However, with the use of multiple
I/O threads, this is racy.

Do you think that in your case we hit the small race window between the
checks in blk_wait_while_drained() and GRAPH_RDLOCK_GUARD()? Or is there
another reason why blk_wait_while_drained() didn't do its job?

Kevin


