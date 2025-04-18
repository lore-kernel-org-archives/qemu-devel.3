Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260B8C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 19:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5r44-0005Bz-Fo; Fri, 18 Apr 2025 15:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u5r43-0005BY-2R
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 15:07:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u5r41-0004F6-5R
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 15:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745003268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=umL1FleCSb7+FIsmtAKFNQQdRJIItn4mhJexVdJx69A=;
 b=KRN9m7YWW5P/0pHvhry09UI6ZL9lXEYM24D+2JpUVTYWyMZJa0T6rPIb9/Jr0tb9b2bVc6
 kD9tvbWcbljef/YlY4vnuQEUfBN28cU20n30HO17TlkCKm8+0J7/eOB4Gs1eB1uF7p+c/F
 mXHCGkGIVqnT7oJ2p5RUURU7WJL/xak=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-V92mjJgpOzq3FxaBNQVojA-1; Fri,
 18 Apr 2025 15:07:45 -0400
X-MC-Unique: V92mjJgpOzq3FxaBNQVojA-1
X-Mimecast-MFC-AGG-ID: V92mjJgpOzq3FxaBNQVojA_1745003264
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4DA0D1800877; Fri, 18 Apr 2025 19:07:43 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.121])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D02E19560BA; Fri, 18 Apr 2025 19:07:38 +0000 (UTC)
Date: Fri, 18 Apr 2025 14:07:35 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 vsementsov@yandex-team.ru, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 04/11] block: Add new bdrv_co_is_all_zeroes() function
Message-ID: <3ajsdokbbqy2vw7l4lprq2tg4vuvswgatfqr6v6vb4apzhrdwd@cbbzutjczej2>
References: <20250417184133.105746-13-eblake@redhat.com>
 <20250417184133.105746-17-eblake@redhat.com>
 <20250417203533.GC85491@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417203533.GC85491@fedora>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Apr 17, 2025 at 04:35:33PM -0400, Stefan Hajnoczi wrote:
> On Thu, Apr 17, 2025 at 01:39:09PM -0500, Eric Blake wrote:
> > There are some optimizations that require knowing if an image starts
> > out as reading all zeroes, such as making blockdev-mirror faster by
> > skipping the copying of source zeroes to the destination.  The
> > existing bdrv_co_is_zero_fast() is a good building block for answering
> > this question, but it tends to give an answer of 0 for a file we just
> > created via QMP 'blockdev-create' or similar (such as 'qemu-img create
> > -f raw').  Why?  Because file-posix.c insists on allocating a tiny
> > header to any file rather than leaving it 100% sparse, due to some
> > filesystems that are unable to answer alignment probes on a hole.  But
> > teaching file-posix.c to read the tiny header doesn't scale - the
> > problem of a small header is also visible when libvirt sets up an NBD
> > client to a just-created file on a migration destination host.
> > 
> > So, we need a wrapper function that handles a bit more complexity in a
> > common manner for all block devices - when the BDS is mostly a hole,
> > but has a small non-hole header, it is still worth the time to read
> > that header and check if it reads as all zeroes before giving up and
> > returning a pessimistic answer.
> > 
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > ---
> >  include/block/block-io.h |  2 ++
> >  block/io.c               | 58 ++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 60 insertions(+)
> > 
> > diff --git a/include/block/block-io.h b/include/block/block-io.h
> > index b49e0537dd4..b99cc98d265 100644
> > --- a/include/block/block-io.h
> > +++ b/include/block/block-io.h
> > @@ -161,6 +161,8 @@ bdrv_is_allocated_above(BlockDriverState *bs, BlockDriverState *base,
> > 
> >  int coroutine_fn GRAPH_RDLOCK
> >  bdrv_co_is_zero_fast(BlockDriverState *bs, int64_t offset, int64_t bytes);
> > +int coroutine_fn GRAPH_RDLOCK
> > +bdrv_co_is_all_zeroes(BlockDriverState *bs);
> > 
> >  int GRAPH_RDLOCK
> >  bdrv_apply_auto_read_only(BlockDriverState *bs, const char *errmsg,
> > diff --git a/block/io.c b/block/io.c
> > index 6ef78070915..dc1341e4029 100644
> > --- a/block/io.c
> > +++ b/block/io.c
> > @@ -2778,6 +2778,64 @@ int coroutine_fn bdrv_co_is_zero_fast(BlockDriverState *bs, int64_t offset,
> >      return 1;
> >  }
> > 
> > +/*
> > + * Check @bs (and its backing chain) to see if the entire image is known
> > + * to read as zeroes.
> > + * Return 1 if that is the case, 0 otherwise and -errno on error.
> > + * This test is meant to be fast rather than accurate so returning 0
> > + * does not guarantee non-zero data; however, it can report 1 in more
> 
> False negatives are possible, let's also document that false positives
> are not possible:
> 
>   This test is mean to be fast rather than accurate so returning 0 does
>   not guarantee non-zero data, but returning 1 does guarantee all zero
>   data; ...

Copied from bdrv_co_is_zero_fast, but that wording can use a similar
treatment.

> 
> > + * cases than bdrv_co_is_zero_fast.
> > + */
> > +int coroutine_fn bdrv_co_is_all_zeroes(BlockDriverState *bs)
> > +{
> > +    int ret;
> > +    int64_t pnum, bytes;
> > +    char *buf;
> > +    QEMUIOVector local_qiov;
> > +    IO_CODE();
> > +
> > +    bytes = bdrv_co_getlength(bs);
> > +    if (bytes < 0) {
> > +        return bytes;
> > +    }
> > +
> > +    /* First probe - see if the entire image reads as zero */
> > +    ret = bdrv_co_common_block_status_above(bs, NULL, false, BDRV_BSTAT_ZERO,
> > +                                            0, bytes, &pnum, NULL, NULL,
> > +                                            NULL);
> > +    if (ret < 0) {
> > +        return ret;
> > +    }
> > +    if (ret & BDRV_BLOCK_ZERO) {
> > +        return bdrv_co_is_zero_fast(bs, pnum, bytes - pnum);
> > +    }
> > +
> > +    /*
> > +     * Because of the way 'blockdev-create' works, raw files tend to
> > +     * be created with a non-sparse region at the front to make
> > +     * alignment probing easier.  If the block starts with only a
> > +     * small allocated region, it is still worth the effort to see if
> > +     * the rest of the image is still sparse, coupled with manually
> > +     * reading the first region to see if it reads zero after all.
> > +     */
> > +    if (pnum > qemu_real_host_page_size()) {
> 
> Probably not worth it for the corner case, but replacing
> qemu_real_host_page_size() with 128 KiB would allow this to work on
> images created on different CPU architectures (4 KiB vs 64 KiB page
> sizes).

I picked the original value of qemu_real_host_page_size() based on
file-posix.c's allocate_first_block(); but agree that picking a
constant 64k or even 128k for all platforms (rather than tying it to
the host's page size) won't hurt.  The key point remains that it
should be large enough to account for whatever file-posix.c does, yet
small enough that we aren't negating any potential optimization by the
time spent probing if the image reads as zeroes.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


