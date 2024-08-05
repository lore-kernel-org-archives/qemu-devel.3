Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1ABC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 12:00:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sawNC-0004qZ-OL; Mon, 05 Aug 2024 07:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sawNA-0004nk-NJ
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 07:59:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sawN8-0005fR-Ft
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 07:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722859168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SGMVRffDSeS79H8EkhpOqfk41vYplIpeHBgL6uL/YXg=;
 b=P7zVl76qJb1j1+ZGPjZ6UJ3L9rUDfJAd/Cw9///LQFwEh9J0YbX19qg0J0gAhRk4KpH6Ht
 G7B6k56rDF5wb4wmNpFI0hMqZtEZqqVpBBSuRc/80rjYSCqr3foX3iOdTe8HGnUBI0QWPS
 H6uvEWHQ3g0P9RN8FNc6t9oDRufRZZY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-dELrkOF8NKm10t2d0ehqfQ-1; Mon,
 05 Aug 2024 07:59:26 -0400
X-MC-Unique: dELrkOF8NKm10t2d0ehqfQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D7F91955BED; Mon,  5 Aug 2024 11:59:24 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.224])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C45019560B2; Mon,  5 Aug 2024 11:59:20 +0000 (UTC)
Date: Mon, 5 Aug 2024 13:59:18 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 vsementsov@yandex-team.ru, pbonzini@redhat.com, eesposit@redhat.com
Subject: Re: [PATCH v3 1/3] block: zero data data corruption using
 prealloc-filter
Message-ID: <ZrC-liyd3CL0LXlq@redhat.com>
References: <20240716144123.651476-1-andrey.drobyshev@virtuozzo.com>
 <20240716144123.651476-2-andrey.drobyshev@virtuozzo.com>
 <Zpk5-GDaqmD4c-EF@redhat.com>
 <03492477-fe98-4a3d-a892-7c6a143ee048@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03492477-fe98-4a3d-a892-7c6a143ee048@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 18.07.2024 um 21:46 hat Denis V. Lunev geschrieben:
> On 7/18/24 17:51, Kevin Wolf wrote:
> > Am 16.07.2024 um 16:41 hat Andrey Drobyshev geschrieben:
> > > From: "Denis V. Lunev" <den@openvz.org>
> > > 
> > > We have observed that some clusters in the QCOW2 files are zeroed
> > > while preallocation filter is used.
> > > 
> > > We are able to trace down the following sequence when prealloc-filter
> > > is used:
> > >      co=0x55e7cbed7680 qcow2_co_pwritev_task()
> > >      co=0x55e7cbed7680 preallocate_co_pwritev_part()
> > >      co=0x55e7cbed7680 handle_write()
> > >      co=0x55e7cbed7680 bdrv_co_do_pwrite_zeroes()
> > >      co=0x55e7cbed7680 raw_do_pwrite_zeroes()
> > >      co=0x7f9edb7fe500 do_fallocate()
> > > 
> > > Here coroutine 0x55e7cbed7680 is being blocked waiting while coroutine
> > > 0x7f9edb7fe500 will finish with fallocate of the file area. OK. It is
> > > time to handle next coroutine, which
> > >      co=0x55e7cbee91b0 qcow2_co_pwritev_task()
> > >      co=0x55e7cbee91b0 preallocate_co_pwritev_part()
> > >      co=0x55e7cbee91b0 handle_write()
> > >      co=0x55e7cbee91b0 bdrv_co_do_pwrite_zeroes()
> > >      co=0x55e7cbee91b0 raw_do_pwrite_zeroes()
> > >      co=0x7f9edb7deb00 do_fallocate()
> > > 
> > > The trouble comes here. Coroutine 0x55e7cbed7680 has not advanced
> > > file_end yet and coroutine 0x55e7cbee91b0 will start fallocate() for
> > > the same area. This means that if (once fallocate is started inside
> > > 0x7f9edb7deb00) original fallocate could end and the real write will
> > > be executed. In that case write() request is handled at the same time
> > > as fallocate().
> > > 
> > > The patch moves s->file_lock assignment before fallocate and that is
> > s/file_lock/file_end/?
> > 
> > > crucial. The idea is that all subsequent requests into the area
> > > being preallocation will be issued as just writes without fallocate
> > > to this area and they will not proceed thanks to overlapping
> > > requests mechanics. If preallocation will fail, we will just switch
> > > to the normal expand-by-write behavior and that is not a problem
> > > except performance.
> > > 
> > > Signed-off-by: Denis V. Lunev <den@openvz.org>
> > > Tested-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> > > ---
> > >   block/preallocate.c | 8 +++++++-
> > >   1 file changed, 7 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/block/preallocate.c b/block/preallocate.c
> > > index d215bc5d6d..ecf0aa4baa 100644
> > > --- a/block/preallocate.c
> > > +++ b/block/preallocate.c
> > > @@ -383,6 +383,13 @@ handle_write(BlockDriverState *bs, int64_t offset, int64_t bytes,
> > >       want_merge_zero = want_merge_zero && (prealloc_start <= offset);
> > > +    /*
> > > +     * Assign file_end before making actual preallocation. This will ensure
> > > +     * that next request performed while preallocation is in progress will
> > > +     * be passed without preallocation.
> > > +     */
> > > +    s->file_end = prealloc_end;
> > > +
> > >       ret = bdrv_co_pwrite_zeroes(
> > >               bs->file, prealloc_start, prealloc_end - prealloc_start,
> > >               BDRV_REQ_NO_FALLBACK | BDRV_REQ_SERIALISING | BDRV_REQ_NO_WAIT);
> > > @@ -391,7 +398,6 @@ handle_write(BlockDriverState *bs, int64_t offset, int64_t bytes,
> > >           return false;
> > >       }
> > > -    s->file_end = prealloc_end;
> > >       return want_merge_zero;
> > >   }
> > Until bdrv_co_pwrite_zeroes() completes successfully, the file size is
> > unchanged. In other words, if anything calls preallocate_co_getlength()
> > in the meantime, don't we run into...
> > 
> >      ret = bdrv_co_getlength(bs->file->bs);
> > 
> >      if (has_prealloc_perms(bs)) {
> >          s->file_end = s->zero_start = s->data_end = ret;
> >      }
> > 
> > ...and reset s->file_end back to the old value, re-enabling the bug
> > you're trying to fix here?
> > 
> > Or do we know that no such code path can be called concurrently for some
> > reason?
> > 
> > Kevin
> > 
> After more detailed thinking I tend to disagree.
> Normally we would not hit the problem. Though
> this was not obvious at the beginning :)
> 
> The point in handle_write() where we move
> file_end assignment is reachable only if the
> following code has been executed
> 
>     if (s->data_end < 0) {
>         s->data_end = bdrv_co_getlength(bs->file->bs);
>         if (s->data_end < 0) {
>             return false;
>         }
> 
>         if (s->file_end < 0) {
>             s->file_end = s->data_end;
>         }
>     }
> 
>     if (end <= s->data_end) {
>         return false;
>     }
> 
> which means that s->data_end > 0.
> 
> Thus
> 
> static int64_t coroutine_fn GRAPH_RDLOCK
> preallocate_co_getlength(BlockDriverState *bs)
> {
>     int64_t ret;
>     BDRVPreallocateState *s = bs->opaque;
> 
>     if (s->data_end >= 0) {
>         return s->data_end; <--- we will return here
>     }
> 
>     ret = bdrv_co_getlength(bs->file->bs);
> 
>     if (has_prealloc_perms(bs)) {
>         s->file_end = s->zero_start = s->data_end = ret;
>     }
> 
>     return ret;
> }

I think you're right there. And the other places that update s->file_end
should probably be okay because of the request serialisation.

I'm okay with applying this patch as it seems to fix a corruption, but
the way this whole block driver operates doesn't feel very robust to me.
There seem to be a lot of implicit assumptions that make the code hard
to understand even though it's quite short.

Kevin


