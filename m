Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71274CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 16:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1SeR-0002Aa-Mg; Wed, 24 Sep 2025 12:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1Sdk-0001zc-A9
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 12:46:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1SdY-0001mG-Iq
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 12:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758732390;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nE9nTI2oR0LcYZpNry0xbSvGDrItcfM4GS7FWcD4HcA=;
 b=FG9nuIA+MSu/cg1PhOaYrCi8BhnMwO4Sh2QdPkGDgfMa/rLlTQBmaG10pvh3TXTy6+Obbh
 mfzZQgSimiUxiNNzWaltodpjxyKVjACRZjSAHZFwi+yaxkDW8DU3ynreD6edtPRBIaS0Zi
 /kTgc1ftEa4rmNuAjzy5l6ig/TgP9Z8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-aeTuJRNGO6S4MxZd6plyXQ-1; Wed,
 24 Sep 2025 12:44:42 -0400
X-MC-Unique: aeTuJRNGO6S4MxZd6plyXQ-1
X-Mimecast-MFC-AGG-ID: aeTuJRNGO6S4MxZd6plyXQ_1758732281
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECBF21800578; Wed, 24 Sep 2025 16:44:40 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.136])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED19C1800578; Wed, 24 Sep 2025 16:44:38 +0000 (UTC)
Date: Wed, 24 Sep 2025 17:44:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH] block: fix luks 'amend' when run in coroutine
Message-ID: <aNQf8-jASyIDb07i@redhat.com>
References: <20250919112213.1530079-1-berrange@redhat.com>
 <aNQbNANzZDTljjtz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aNQbNANzZDTljjtz@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Sep 24, 2025 at 06:24:20PM +0200, Kevin Wolf wrote:
> Am 19.09.2025 um 13:22 hat Daniel P. Berrangé geschrieben:
> > Launch QEMU with
> > 
> >   $ qemu-img create \
> >       --object secret,id=sec0,data=123456 \
> >       -f luks -o key-secret=sec0 demo.luks 1g
> > 
> >   $ qemu-system-x86_64 \
> >       --object secret,id=sec0,data=123456 \
> >       -blockdev  driver=luks,key-secret=sec0,file.filename=demo.luks,file.driver=file,node-name=luks
> > 
> > Then in QMP shell attempt
> > 
> >   x-blockdev-amend job-id=fish node-name=luks options={'state':'active','new-secret':'sec0','driver':'luks'}
> > 
> > It will result in an assertion
> > 
> >   #0  __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0) at pthread_kill.c:44
> >   #1  0x00007fad18b73f63 in __pthread_kill_internal (threadid=<optimized out>, signo=6) at pthread_kill.c:89
> >   #2  0x00007fad18b19f3e in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
> >   #3  0x00007fad18b016d0 in __GI_abort () at abort.c:77
> >   #4  0x00007fad18b01639 in __assert_fail_base
> >       (fmt=<optimized out>, assertion=<optimized out>, file=<optimized out>, line=<optimized out>, function=<optimized out>) at assert.c:118
> >   #5  0x00007fad18b120af in __assert_fail (assertion=<optimized out>, file=<optimized out>, line=<optimized out>, function=<optimized out>)
> >       at assert.c:127
> >   #6  0x000055ff74fdbd46 in bdrv_graph_rdlock_main_loop () at ../block/graph-lock.c:260
> >   #7  0x000055ff7548521b in graph_lockable_auto_lock_mainloop (x=<optimized out>)
> >       at /usr/src/debug/qemu-9.2.4-1.fc42.x86_64/include/block/graph-lock.h:266
> >   #8  block_crypto_read_func (block=<optimized out>, offset=4096, buf=0x55ffb6d66ef0 "", buflen=256000, opaque=0x55ffb5edcc30, errp=0x55ffb6f00700)
> >       at ../block/crypto.c:71
> >   #9  0x000055ff75439f8b in qcrypto_block_luks_load_key
> >       (block=block@entry=0x55ffb5edbe90, slot_idx=slot_idx@entry=0, password=password@entry=0x55ffb67dc260 "123456", masterkey=masterkey@entry=0x55ffb5fb0c40 "", readfunc=readfunc@entry=0x55ff754851e0 <block_crypto_read_func>, opaque=opaque@entry=0x55ffb5edcc30, errp=0x55ffb6f00700)
> >       at ../crypto/block-luks.c:927
> >   #10 0x000055ff7543b90f in qcrypto_block_luks_find_key
> >       (block=<optimized out>, password=<optimized out>, masterkey=<optimized out>, readfunc=<optimized out>, opaque=<optimized out>, errp=<optimized out>) at ../crypto/block-luks.c:1045
> >   #11 qcrypto_block_luks_amend_add_keyslot
> >       (block=0x55ffb5edbe90, readfunc=0x55ff754851e0 <block_crypto_read_func>, writefunc=0x55ff75485100 <block_crypto_write_func>, opaque=0x55ffb5edcc3, opts_luks=0x7fad1715aef8, force=<optimized out>, errp=0x55ffb6f00700) at ../crypto/block-luks.c:1673
> >   #12 qcrypto_block_luks_amend_options
> >       (block=0x55ffb5edbe90, readfunc=0x55ff754851e0 <block_crypto_read_func>, writefunc=0x55ff75485100 <block_crypto_write_func>, opaque=0x55ffb5edcc30, options=0x7fad1715aef0, force=<optimized out>, errp=0x55ffb6f00700) at ../crypto/block-luks.c:1865
> >   #13 0x000055ff75485b95 in block_crypto_amend_options_generic_luks
> >       (bs=<optimized out>, amend_options=<optimized out>, force=<optimized out>, errp=<optimized out>) at ../block/crypto.c:949
> >   #14 0x000055ff75485c28 in block_crypto_co_amend_luks (bs=<optimized out>, opts=<optimized out>, force=<optimized out>, errp=<optimized out>)
> >       at ../block/crypto.c:1008
> >   #15 0x000055ff754778e5 in blockdev_amend_run (job=0x55ffb6f00640, errp=0x55ffb6f00700) at ../block/amend.c:52
> >   #16 0x000055ff75468b90 in job_co_entry (opaque=0x55ffb6f00640) at ../job.c:1106
> >   #17 0x000055ff755a0fc2 in coroutine_trampoline (i0=<optimized out>, i1=<optimized out>) at ../util/coroutine-ucontext.c:175
> > 
> > This changes the read/write callbacks to not assert that they
> > are run in mainloop context if already in a coroutine.
> > 
> > Fixes: 1f051dcbdf2e4b6f518db731c84e304b2b9d15ce
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> > 
> > I'm not really sure if this is correct or not, as the docs on the
> > graph lock usage are not very clear on what I should be doing.
> 
> It looks right to me, this should do the trick.

Great.

> > Also I'm wondering if qcow2.c needs work too. When 1f051dc added
> > the GRAPH_RDLOCK_GUARD_MAINLOOP in read_func/write_func for the
> > crypto.c file, it did not do the same with the read_func/write_func
> > for the qcow2.c file, despite them being used from the same call
> > paths AFAICT (both image creation & amend).
> 
> I wondered why we need the GRAPH_RDLOCK_GUARD_MAINLOOP() at all, because
> bdrv_pread() doesn't require it. Just removing it and trying to compile
> gave me the answer: It's for accessing bs->file.
> 
> qcow2 needs the lock, too, but it's marked GRAPH_RDLOCK. So we (or in
> fact probably I myself) decided that all callers already hold the lock.
> Does QCrypto store these function pointers somewhere or are they only
> for the functions that take them as a parameter? All calls to
> qcrypto_block_open() and qcrypto_block_amend_options() in qcow2 are from
> places that are in a coroutine and already hold the lock. So I don't see
> an obvious problem at least.

We don't store the function pointers anywhere - they must be passed in
from the context that needs to use them, so the calling codepaths are
an accurate reflection of the the use context.

> qemu-iotests 295 passes for qcow2 while it crashed for luks, so that's
> probably another indication that the qcow2 code is okay.

Yep, that's good.

> 
> >  block/crypto.c | 30 ++++++++++++++++++++++--------
> >  1 file changed, 22 insertions(+), 8 deletions(-)
> 
> Thanks, applied to the block branch.
> 
> Kevin
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


