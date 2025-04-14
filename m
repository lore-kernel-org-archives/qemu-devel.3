Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C5E1C369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 18:13:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4OIS-0005xj-TF; Mon, 14 Apr 2025 14:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u4OIN-0005wp-N9
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 14:12:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u4OIL-0006Da-Ct
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 14:12:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744654350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sbQwDfZgfQw4MhHZU7o3GcdzF0PtsfhG8wCSLcCVIVU=;
 b=UBDClQHOiq2dMvcD6AjAjOzRwjgQMSZ9UOdNMuf2FJ3HqMYlB3tGsUcON9zfhFi/F/jKlz
 W6tdFf0po3oJ48qiQutIB3ZKHQ5hUkxQtWKoJ5Uz+929mCRqYDHjZ0i12Mkq3JNyd+Cgx/
 QZIan2hoJXgXL0Gtxr4RAdLEAawtcH0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-cS_Qri5lMlShTMpnYleqYA-1; Mon,
 14 Apr 2025 14:12:26 -0400
X-MC-Unique: cS_Qri5lMlShTMpnYleqYA-1
X-Mimecast-MFC-AGG-ID: cS_Qri5lMlShTMpnYleqYA_1744654345
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BA9E195605E; Mon, 14 Apr 2025 18:12:24 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.12])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB555180175D; Mon, 14 Apr 2025 18:12:21 +0000 (UTC)
Date: Mon, 14 Apr 2025 13:12:17 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, "open list:raw" <qemu-block@nongnu.org>, 
 "Denis V. Lunev" <den@openvz.org>
Subject: Re: [PATCH 2/6] file-posix: Allow lseek at offset 0 when !want_zero
Message-ID: <6dn2vursoidmgeba4jtdrpy76b4o6ktkvh6l22bykm7cllmahw@hchia4nkjv2s>
References: <20250411010732.358817-8-eblake@redhat.com>
 <20250411010732.358817-10-eblake@redhat.com>
 <2d17f631-40b0-40bc-a4ba-0b507cd39c71@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d17f631-40b0-40bc-a4ba-0b507cd39c71@yandex-team.ru>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Apr 14, 2025 at 08:05:21PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 11.04.25 04:04, Eric Blake wrote:
> > The 'want_zero' parameter to raw_co_block_status() was added so that
> > we can avoid potentially time-consuming lseek(SEEK_DATA) calls
> > throughout the file (working around poor filesystems that have O(n)
> > rather than O(1) extent probing).  But when it comes to learning if a
> > file is completely sparse (for example, it was just created), always
> > claiming that a file is all data without even checking offset 0 breaks
> > what would otherwise be attempts at useful optimizations for a
> > known-zero mirror destination.
> > 
> > Note that this allows file-posix to report a file as completely zero
> > if it was externally created (such as via 'truncate --size=$n file')
> > as entirely sparse; however, it does NOT work for files created
> > internally by blockdev-create.  That's because blockdev-create
> > intentionally does a sequence of truncate(0), truncate(size),
> > allocate_first_block(), in order to make it possible for gluster on
> > XFS to probe the sector size for direct I/O (which doesn't work if the
> > first block is sparse).  That will be addressed in a later patch.
> > 
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > ---
> >   block/file-posix.c | 9 ++++++++-
> >   1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/block/file-posix.c b/block/file-posix.c
> > index 56d1972d156..67e83528cf5 100644
> > --- a/block/file-posix.c
> > +++ b/block/file-posix.c
> > @@ -3217,7 +3217,14 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
> >           return ret;
> >       }
> > 
> > -    if (!want_zero) {
> > +    /*
> > +     * If want_zero is clear, then the caller wants speed over
> > +     * accuracy, and the only place where SEEK_DATA should be
> > +     * attempted is at the start of the file to learn if the file has
> > +     * any data at all (anywhere else, just blindly claim the entire
> > +     * file is data).
> > +     */
> > +    if (!want_zero && offset) {
> >           *pnum = bytes;
> >           *map = offset;
> >           *file = bs;
> 
> Looks like a hack. So we have bdrv_co_is_zero_fast() which do pass want_zero=false to block-status. But in case of mirror, which want to check the whole disk, we actually want want_zero=true, and detect it by offset=0..
> 
> Isn't it better to add a kind of bdrv_is_zero_middle_speed() (which means, don't try to read the data to check, but be free to use suboptimal lseek call or something like this), which will pass want_zero=true, and use it from mirror? Mirror case differs from usage in qcow2 exactly by the fact that we call it only once.

Which is exactly why I wrote patch 4/6 turning the want_zero bool into
an enum so that we are being more explicit in WHY block status is
being requested.

> 
> 
> Another doubt (really weak): can this one extra lseek be so slow, that mirror becomes worse?
> Den, is it right, that problems about slow lseek (that we experienced several years ago) were about qcow2-internals, and nothing related to mirror itself? May one lseek call on mirror target break something?

I'm not worried about one or even two lseek on the destination; what
I'm trying to avoid is an lseek on the destination for every chunk
where the source is doing a write-zeroes request (we're already doing
an lseek on the source as part of the background task of the mirror,
but foreground writes being split into the original and the mirror are
where it really matters that we aren't going slower just because of
the mirror).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


