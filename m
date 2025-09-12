Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE2FDCAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 14:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux4hB-0005VA-Tz; Fri, 12 Sep 2025 10:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux4h6-0005UR-2E
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 10:24:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux4h2-000390-Oa
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 10:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757687040;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=5LO8a9BthN4thizunY1hOwda9VB0VVQfZZ7SKs8fZQs=;
 b=aNoHh4LQs4LFNDi7JuqE+I0H8bj63gjjmW6qVX22qYl8yD6zJlyucIRWQplMsAXWHT7NCR
 mqIl3uVW3kaIVszo4jfIIjtqY+4Fclaf8Vg0CHs+QpGwMdW4at+bN/vspTjMHelrYupzaM
 8NMTKM1EJH5VgvHLqQ1v3w6uNsokkWo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-zBUs880yNw-VNl6Md5PJiw-1; Fri,
 12 Sep 2025 10:23:54 -0400
X-MC-Unique: zBUs880yNw-VNl6Md5PJiw-1
X-Mimecast-MFC-AGG-ID: zBUs880yNw-VNl6Md5PJiw_1757687033
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27DFF18002C1; Fri, 12 Sep 2025 14:23:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.154])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7453E30002C8; Fri, 12 Sep 2025 14:23:50 +0000 (UTC)
Date: Fri, 12 Sep 2025 15:23:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 hreitz@redhat.com, Maxim Levitsky <mlevitsk@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>
Subject: Re: Some iotests are failing with -luks
Message-ID: <aMQs8pbZZPio0ikL@redhat.com>
References: <425ef990-85cb-4c02-bb41-2f88f939d147@redhat.com>
 <aMGijXg9XIpbbn-v@redhat.com>
 <58d82de4-25ac-48f5-ae80-181faf2bf8cf@redhat.com>
 <aMK8-4-xE0R7AnaK@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aMK8-4-xE0R7AnaK@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Sep 11, 2025 at 02:13:47PM +0200, Kevin Wolf wrote:
> Am 11.09.2025 um 13:21 hat Thomas Huth geschrieben:
> > On 10/09/2025 18.08, Kevin Wolf wrote:
> > > Am 10.09.2025 um 17:16 hat Thomas Huth geschrieben:
> > > > 
> > > >   Hi,
> > > > 
> > > > when running "./check -luks" in the qemu-iotests directory,
> > > > some tests are failing for me:
> > > > 
> > > > 295 296 inactive-node-nbd luks-detached-header
> > > > 
> > > > Is that a known problem already?
> > > 
> > > Not to me anyway.
> > > 
> > > > FWIW, 295 is failing with the following output:
> > > > 
> > > > 295   fail       [17:03:01] [17:03:17]   15.7s                failed, exit status 1
> > > > [...]
> > > > +EWARNING:qemu.machine.machine:qemu received signal 6; command: "/home/thuth/tmp/qemu-build/qemu-system-x86_64 -display none -vga none -chardev socket,id=mon,fd=5 -mon chardev=mon,mode=control -chardev socket,id=qtest,fd=3 -qtest chardev:qtest -accel qtest -nodefaults -display none -accel qtest"
> > > > +EEWARNING:qemu.machine.machine:qemu received signal 6; command: "/home/thuth/tmp/qemu-build/qemu-system-x86_64 -display none -vga none -chardev socket,id=mon,fd=6 -mon chardev=mon,mode=control -chardev socket,id=qtest,fd=3 -qtest chardev:qtest -accel qtest -nodefaults -display none -accel qtest"
> > > > +EEWARNING:qemu.machine.machine:qemu received signal 6; command: "/home/thuth/tmp/qemu-build/qemu-system-x86_64 -display none -vga none -chardev socket,id=mon,fd=10 -mon chardev=mon,mode=control -chardev socket,id=qtest,fd=3 -qtest chardev:qtest -accel qtest -nodefaults -display none -accel qtest"
> > > > +E
> > > > [...]
> > > > 
> > > > etc.
> > > > 
> > > > 296 looks very similar (also a "qemu received signal 6" error),
> > > > but the others look like this:
> > > 
> > > When it gets signal 6 (i.e. SIGABRT), that usually means that you should
> > > have a look at the coredump.
> > 
> > With "-p" I additionally get this error message in the log:
> > 
> > qemu-system-x86_64: ../../devel/qemu/block/graph-lock.c:294:
> >  bdrv_graph_rdlock_main_loop: Assertion `!qemu_in_coroutine()' failed.
> > 
> > With -gdb I can get a back trace that looks like this:
> > 
> > Thread 1 "qemu-system-x86" received signal SIGABRT, Aborted.
> > 0x00007ffff4ba7e9c in __pthread_kill_implementation () from target:/lib64/libc.so.6
> > --Type <RET> for more, q to quit, c to continue without paging--
> > #0  0x00007ffff4ba7e9c in __pthread_kill_implementation () from target:/lib64/libc.so.6
> > #1  0x00007ffff4b4df3e in raise () from target:/lib64/libc.so.6
> > #2  0x00007ffff4b356d0 in abort () from target:/lib64/libc.so.6
> > #3  0x00007ffff4b35639 in __assert_fail_base.cold () from target:/lib64/libc.so.6
> > #4  0x0000555555574eae in bdrv_graph_rdlock_main_loop () at ../../devel/qemu/block/graph-lock.c:294
> > #5  0x0000555555aa2f43 in graph_lockable_auto_lock_mainloop (x=<optimized out>) at /home/thuth/devel/qemu/include/block/graph-lock.h:275
> > #6  block_crypto_read_func (block=<optimized out>, offset=4096, buf=0x555558324100 "", buflen=256000, opaque=0x555558a259d0, errp=0x555558a8c370)
> >     at ../../devel/qemu/block/crypto.c:71
> > #7  0x0000555555a5a308 in qcrypto_block_luks_load_key (block=block@entry=0x555558686ec0, slot_idx=slot_idx@entry=0,
> >     password=password@entry=0x555558626050 "hunter0", masterkey=masterkey@entry=0x55555886b2a0 "",
> >     readfunc=readfunc@entry=0x555555aa2f10 <block_crypto_read_func>, opaque=opaque@entry=0x555558a259d0, errp=0x555558a8c370)
> >     at ../../devel/qemu/crypto/block-luks.c:927
> > #8  0x0000555555a5ba7e in qcrypto_block_luks_find_key (block=0x555558686ec0, password=0x555558626050 "hunter0", masterkey=0x55555886b2a0 "",
> >     readfunc=0x555555aa2f10 <block_crypto_read_func>, opaque=0x555558a259d0, errp=0x555558a8c370) at ../../devel/qemu/crypto/block-luks.c:1045
> > #9  qcrypto_block_luks_amend_add_keyslot (block=0x555558686ec0, readfunc=0x555555aa2f10 <block_crypto_read_func>,
> >     writefunc=0x555555aa2e50 <block_crypto_write_func>, opaque=0x555558a259d0, opts_luks=0x7fffec5fff38, force=<optimized out>, errp=0x555558a8c370)
> >     at ../../devel/qemu/crypto/block-luks.c:1673
> > #10 qcrypto_block_luks_amend_options (block=0x555558686ec0, readfunc=0x555555aa2f10 <block_crypto_read_func>,
> >     writefunc=0x555555aa2e50 <block_crypto_write_func>, opaque=0x555558a259d0, options=0x7fffec5fff30, force=<optimized out>, errp=0x555558a8c370)
> >     at ../../devel/qemu/crypto/block-luks.c:1865
> > #11 0x0000555555aa3852 in block_crypto_amend_options_generic_luks (bs=<optimized out>, amend_options=<optimized out>, force=<optimized out>,
> >     errp=<optimized out>) at ../../devel/qemu/block/crypto.c:949
> > #12 0x0000555555aa38e9 in block_crypto_co_amend_luks (bs=<optimized out>, opts=<optimized out>, force=<optimized out>, errp=<optimized out>)
> >     at ../../devel/qemu/block/crypto.c:1008
> > #13 0x0000555555a96030 in blockdev_amend_run (job=0x555558a8c2b0, errp=0x555558a8c370) at ../../devel/qemu/block/amend.c:52
> > #14 0x0000555555a874ad in job_co_entry (opaque=0x555558a8c2b0) at ../../devel/qemu/job.c:1112
> > #15 0x0000555555bdc41b in coroutine_trampoline (i0=<optimized out>, i1=<optimized out>) at ../../devel/qemu/util/coroutine-ucontext.c:175
> > #16 0x00007ffff4b68f70 in ?? () from target:/lib64/libc.so.6
> > #17 0x00007fffffffc310 in ?? ()
> > #18 0x0000000000000000 in ?? ()
> 
> Hm, so block_crypto_read_func() isn't prepared to be called in coroutine
> context, but block_crypto_co_amend_luks() still calls it from a
> coroutine. The indirection of going through QCrypto won't make it easier
> to fix this properly.

Historically block_crypto_read_func() didn't care/know whether it
was in a coroutine or not. Bisect tells me the regression was caused
by

  commit 1f051dcbdf2e4b6f518db731c84e304b2b9d15ce
  Author: Kevin Wolf <kwolf@redhat.com>
  Date:   Fri Oct 27 17:53:33 2023 +0200

    block: Protect bs->file with graph_lock

which added
 
    GLOBAL_STATE_CODE();
    GRAPH_RDLOCK_GUARD_MAINLOOP();

> It seems to me that while block_crypto_read/write_func are effectively
> no_coroutine_fn, qcrypto_block_amend_options() should really take
> function pointers that can be called from coroutines. It is called from
> both coroutine and non-coroutine code paths, so should the function
> pointers be coroutine_mixed_fn or do we want to change the callers?
>
> Either way, we should add the appropriate coroutine markers to the
> QCrypto interfaces to show the intention at least.

I'm unclear why QCrypto needs to know about coroutines at all ?
It just wants a function pointer that will send or recv a blob
of data. In the case of the block layer these functions end up
doing I/O via the block APIs, but QCrypto doesn't care about
this impl detail.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


