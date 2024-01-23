Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F53C47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 17:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSKIV-0005TP-JB; Tue, 23 Jan 2024 12:10:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rSKIG-0005Qu-PD
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 12:10:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rSKIE-000138-WB
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 12:10:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706029834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BAkp+BYRjTKdRDDS4zCrFdicWn15E6/a/FmX1uJXkEI=;
 b=KhBVxxVuUIMwRRDMKbKzadJUtccDJ3XEASYB+TzdOHij381usF/90w6FVvX86NmnWgxoDE
 U3FeGz8O+Bt7HUf3USXr5jgX704nlz1QXwX/uyZmDU0HPTuvL83kem1WZrv41oalu1UsVi
 PCbkpTWQVrho0T/geLvFldNCp0L7I+g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-7ubxB0SBMWCXFKSXvsHGOg-1; Tue, 23 Jan 2024 12:10:31 -0500
X-MC-Unique: 7ubxB0SBMWCXFKSXvsHGOg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16A60185A7A8;
 Tue, 23 Jan 2024 17:10:28 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.232])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 578812905;
 Tue, 23 Jan 2024 17:10:27 +0000 (UTC)
Date: Tue, 23 Jan 2024 18:10:26 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PULL 11/33] scsi: only access SCSIDevice->requests from one
 thread
Message-ID: <Za_zAj11uwavd2va@redhat.com>
References: <20231221212339.164439-1-kwolf@redhat.com>
 <20231221212339.164439-12-kwolf@redhat.com>
 <73e752b2-a037-4b10-a903-56fa6ad75c6e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73e752b2-a037-4b10-a903-56fa6ad75c6e@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.327,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Am 23.01.2024 um 17:40 hat Hanna Czenczek geschrieben:
> On 21.12.23 22:23, Kevin Wolf wrote:
> > From: Stefan Hajnoczi<stefanha@redhat.com>
> > 
> > Stop depending on the AioContext lock and instead access
> > SCSIDevice->requests from only one thread at a time:
> > - When the VM is running only the BlockBackend's AioContext may access
> >    the requests list.
> > - When the VM is stopped only the main loop may access the requests
> >    list.
> > 
> > These constraints protect the requests list without the need for locking
> > in the I/O code path.
> > 
> > Note that multiple IOThreads are not supported yet because the code
> > assumes all SCSIRequests are executed from a single AioContext. Leave
> > that as future work.
> > 
> > Signed-off-by: Stefan Hajnoczi<stefanha@redhat.com>
> > Reviewed-by: Eric Blake<eblake@redhat.com>
> > Message-ID:<20231204164259.1515217-2-stefanha@redhat.com>
> > Signed-off-by: Kevin Wolf<kwolf@redhat.com>
> > ---
> >   include/hw/scsi/scsi.h |   7 +-
> >   hw/scsi/scsi-bus.c     | 181 ++++++++++++++++++++++++++++-------------
> >   2 files changed, 131 insertions(+), 57 deletions(-)
> 
> My reproducer for https://issues.redhat.com/browse/RHEL-3934 now breaks more
> often because of this commit than because of the original bug, i.e. when
> repeatedly hot-plugging and unplugging a virtio-scsi and a scsi-hd device,
> this tends to happen when unplugging the scsi-hd:
> 
> {"execute":"device_del","arguments":{"id":"stg0"}}
> {"return": {}}
> qemu-system-x86_64: ../block/block-backend.c:2429: blk_get_aio_context:
> Assertion `ctx == blk->ctx' failed.
> 
> (gdb) bt
> #0  0x00007f32a668d83c in  () at /usr/lib/libc.so.6
> #1  0x00007f32a663d668 in raise () at /usr/lib/libc.so.6
> #2  0x00007f32a66254b8 in abort () at /usr/lib/libc.so.6
> #3  0x00007f32a66253dc in  () at /usr/lib/libc.so.6
> #4  0x00007f32a6635d26 in  () at /usr/lib/libc.so.6
> #5  0x0000556e6b4880a4 in blk_get_aio_context (blk=0x556e6e89ccf0) at
> ../block/block-backend.c:2429
> #6  blk_get_aio_context (blk=0x556e6e89ccf0) at
> ../block/block-backend.c:2417
> #7  0x0000556e6b112d87 in scsi_device_for_each_req_async_bh
> (opaque=0x556e6e2c6d10) at ../hw/scsi/scsi-bus.c:128
> #8  0x0000556e6b5d1966 in aio_bh_poll (ctx=ctx@entry=0x556e6d8aa290) at
> ../util/async.c:218
> #9  0x0000556e6b5bb16a in aio_poll (ctx=0x556e6d8aa290,
> blocking=blocking@entry=true) at ../util/aio-posix.c:722
> #10 0x0000556e6b4564b6 in iothread_run (opaque=opaque@entry=0x556e6d89d920)
> at ../iothread.c:63
> #11 0x0000556e6b5bde58 in qemu_thread_start (args=0x556e6d8aa9b0) at
> ../util/qemu-thread-posix.c:541
> #12 0x00007f32a668b9eb in  () at /usr/lib/libc.so.6
> #13 0x00007f32a670f7cc in  () at /usr/lib/libc.so.6
> 
> I don’t know anything about the problem yet, but as usual, I like
> speculation and discovering how wrong I was later on, so one thing I came
> across that’s funny about virtio-scsi is that requests can happen even while
> a disk is being attached or detached.  That is, Linux seems to probe all
> LUNs when a new virtio-scsi device is being attached, and it won’t stop just
> because a disk is being attached or removed.  So maybe that’s part of the
> problem, that we get a request while the BB is being detached, and
> temporarily in an inconsistent state (BDS context differs from BB context).

I don't know anything about the problem either, but since you already
speculated about the cause, let me speculate about the solution:
Can we hold the graph writer lock for the tran_commit() call in
bdrv_try_change_aio_context()? And of course take the reader lock for
blk_get_aio_context(), but that should be completely unproblematic.

At the first sight I don't see a reason why this would break something,
but I've learnt not to trust my first impression with the graph locking
work...

Of course, I also didn't check if there are more things inside of the
device emulation that need additional locking in this case, too. But
even if so, blk_get_aio_context() should never see an inconsistent
state.

Kevin


