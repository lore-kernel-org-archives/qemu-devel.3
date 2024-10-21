Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D9AD17141
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 22:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t30ct-0005J0-JH; Mon, 21 Oct 2024 18:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t30cr-0005HM-DW
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 18:11:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t30cp-00005q-F2
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 18:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729548702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gtXGrparmXIOrkwwKyP0UqmHurw0c3HQhLzvm4cZ1XQ=;
 b=S8F5e7N7rqpW1rpcmA2EcTdLn2Pj0ShOmgip+gqGQIWK/5i2pRy9mpjQv/ypselV6hE5Tq
 hNGW4LaYjoUQ7wFyMSVSWYIsx8WeNA14RjRvFSIK7hjyWn2iAJJv+ktw2IUvzVtThrjtwL
 BVCJeLs6YyaYHbPUvnQq7Fc+zDe7tuk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-un9Y_0GEPG-VTSeMKNy_GA-1; Mon,
 21 Oct 2024 18:11:36 -0400
X-MC-Unique: un9Y_0GEPG-VTSeMKNy_GA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD46D19560B1; Mon, 21 Oct 2024 22:11:34 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.209])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 262E230001A3; Mon, 21 Oct 2024 22:11:30 +0000 (UTC)
Date: Tue, 22 Oct 2024 00:11:28 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, dmitry.fomichev@wdc.com,
 qemu-block@nongnu.org, dlemoal@kernel.org
Subject: Re: [PATCH v2] block/file-posix: optimize append write
Message-ID: <ZxbRkOg6wB37NAxj@redhat.com>
References: <20241004104123.236457-1-faithilikerun@gmail.com>
 <ZxJynt-0ySt3DG7W@redhat.com>
 <CAAAx-8KtfoM+gVRzUjCCLY8vEG=5vcoRGcxBzDDG6DArC8L7tA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAAx-8KtfoM+gVRzUjCCLY8vEG=5vcoRGcxBzDDG6DArC8L7tA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Am 21.10.2024 um 15:21 hat Sam Li geschrieben:
> Kevin Wolf <kwolf@redhat.com> 于2024年10月18日周五 16:37写道：
> >
> > Am 04.10.2024 um 12:41 hat Sam Li geschrieben:
> > > When the file-posix driver emulates append write, it holds the lock
> > > whenever accessing wp, which limits the IO queue depth to one.
> > >
> > > The write IO flow can be optimized to allow concurrent writes. The lock
> > > is held in two cases:
> > > 1. Assumed that the write IO succeeds, update the wp before issuing the
> > > write.
> > > 2. If the write IO fails, report that zone and use the reported value
> > > as the current wp.
> >
> > What happens with the concurrent writes that started later and may not
> > have completed yet? Can we really just reset to the reported value
> > before all other requests have completed, too?
> >
> > > Signed-off-by: Sam Li <faithilikerun@gmail.com>
> > > ---
> > >  block/file-posix.c | 57 ++++++++++++++++++++++++++++++----------------
> > >  1 file changed, 38 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/block/file-posix.c b/block/file-posix.c
> > > index 90fa54352c..a65a23cb2c 100644
> > > --- a/block/file-posix.c
> > > +++ b/block/file-posix.c
> > > @@ -2482,18 +2482,46 @@ static int coroutine_fn raw_co_prw(BlockDriverState *bs, int64_t *offset_ptr,
> > >      BDRVRawState *s = bs->opaque;
> > >      RawPosixAIOData acb;
> > >      int ret;
> > > -    uint64_t offset = *offset_ptr;
> > > +    uint64_t end_offset, end_zone, offset = *offset_ptr;
> > > +    uint64_t *wp;
> >
> > Without CONFIG_BLKZONED, these are unused variables and break the build.
> >
> > They are only used in the first CONFIG_BLKZONED block, so you could just
> > declare them locally there.
> 
> Thanks! Will do.
> 
> >
> > >
> > >      if (fd_open(bs) < 0)
> > >          return -EIO;
> > >  #if defined(CONFIG_BLKZONED)
> > >      if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) &&
> > >          bs->bl.zoned != BLK_Z_NONE) {
> > > -        qemu_co_mutex_lock(&bs->wps->colock);
> > > -        if (type & QEMU_AIO_ZONE_APPEND) {
> > > -            int index = offset / bs->bl.zone_size;
> > > -            offset = bs->wps->wp[index];
> > > +        BlockZoneWps *wps = bs->wps;
> > > +        int index = offset / bs->bl.zone_size;
> > > +
> > > +        qemu_co_mutex_lock(&wps->colock);
> >
> > This is preexisting, but what is the reason for using coroutine locks
> > here? There doesn't seem to be any code running under the lock that can
> > yield, so a normal mutex might be more efficient.
> 
> Using coroutine locks is to avoid blocking in coroutines. QemuMutex
> blocks the thread when the lock is held instead of yielding.

Right, but usually you have to wait only for a very short time until the
mutex is released again and CoMutexes are more expensive then.

You absolutely do need to use CoMutex when the coroutine can yield in
the critical section, but if it can't, the CoMutex is often worse.

Though as I said here...

> > Hm... Looking a bit closer, get_zones_wp() could probably be a
> > coroutine_fn and call hdev_co_ioctl() instead of calling ioctl()
> > directly in order to avoid blocking.

...we should probably use a coroutine version of ioctl() instead of
the blocking one, and then you do need the CoMutex.

> > > +        wp = &wps->wp[index];
> >
> > Also preexisting, but who guarantees that index is within the bounds? A
> > stacked block driver may try to grow the file size.
> 
> Right. It needs to be checked if it's over nr_zones.

Can you send a separate fix for this, please? (Can be both in one
patch series, though.)

> >
> > > +        if (!BDRV_ZT_IS_CONV(*wp)) {
> > > +            if (type & QEMU_AIO_WRITE && offset != *wp) {
> > > +                error_report("write offset 0x%" PRIx64 " is not equal to the wp"
> > > +                             " of zone[%d] 0x%" PRIx64 "", offset, index, *wp);
> >
> > We can't error_report() in an I/O path that can be triggered by the
> > guest, it could result in unbounded log file growth.
> 
> Those error messages show in the err path and are good for debugging
> zoned device emulation.
> 
> I was wondering if there is a better approach to print errors? Use
> error_report_once() to reduce the log?

If it's for debugging, I think trace points are best.

Kevin


