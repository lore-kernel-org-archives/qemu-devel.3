Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D3DC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 15:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUTPt-0001jn-Oo; Thu, 18 Jul 2024 11:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sUTPr-0001jE-L4
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 11:51:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sUTPq-0007sZ-14
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 11:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721317892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=loQavWKThSPQScDIXPzKqDOuBT4uKRgFf1cag6LAa+E=;
 b=OCryVRXi45lGgwKus6GJJo7c/ZQ8FofD/rVeaKK8FoCu6yhaSIFpaFlNgkPSi0dWINm4mF
 iSser46rbWZkPww7POpOEBI1uMgSpxACmHmM7auAZuAdyWPriwybPPgxyjy+zRvtl9mRhB
 bV1pnXm2RNBXJMMbTDyR4ze+ntPIuzU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-v7ihStG9PcmglGaZ4gyiLw-1; Thu,
 18 Jul 2024 11:51:28 -0400
X-MC-Unique: v7ihStG9PcmglGaZ4gyiLw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B3A419560A2; Thu, 18 Jul 2024 15:51:26 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.0])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7E2E3000188; Thu, 18 Jul 2024 15:51:22 +0000 (UTC)
Date: Thu, 18 Jul 2024 17:51:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 vsementsov@yandex-team.ru, pbonzini@redhat.com, eesposit@redhat.com,
 den@virtuozzo.com
Subject: Re: [PATCH v3 1/3] block: zero data data corruption using
 prealloc-filter
Message-ID: <Zpk5-GDaqmD4c-EF@redhat.com>
References: <20240716144123.651476-1-andrey.drobyshev@virtuozzo.com>
 <20240716144123.651476-2-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716144123.651476-2-andrey.drobyshev@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 16.07.2024 um 16:41 hat Andrey Drobyshev geschrieben:
> From: "Denis V. Lunev" <den@openvz.org>
> 
> We have observed that some clusters in the QCOW2 files are zeroed
> while preallocation filter is used.
> 
> We are able to trace down the following sequence when prealloc-filter
> is used:
>     co=0x55e7cbed7680 qcow2_co_pwritev_task()
>     co=0x55e7cbed7680 preallocate_co_pwritev_part()
>     co=0x55e7cbed7680 handle_write()
>     co=0x55e7cbed7680 bdrv_co_do_pwrite_zeroes()
>     co=0x55e7cbed7680 raw_do_pwrite_zeroes()
>     co=0x7f9edb7fe500 do_fallocate()
> 
> Here coroutine 0x55e7cbed7680 is being blocked waiting while coroutine
> 0x7f9edb7fe500 will finish with fallocate of the file area. OK. It is
> time to handle next coroutine, which
>     co=0x55e7cbee91b0 qcow2_co_pwritev_task()
>     co=0x55e7cbee91b0 preallocate_co_pwritev_part()
>     co=0x55e7cbee91b0 handle_write()
>     co=0x55e7cbee91b0 bdrv_co_do_pwrite_zeroes()
>     co=0x55e7cbee91b0 raw_do_pwrite_zeroes()
>     co=0x7f9edb7deb00 do_fallocate()
> 
> The trouble comes here. Coroutine 0x55e7cbed7680 has not advanced
> file_end yet and coroutine 0x55e7cbee91b0 will start fallocate() for
> the same area. This means that if (once fallocate is started inside
> 0x7f9edb7deb00) original fallocate could end and the real write will
> be executed. In that case write() request is handled at the same time
> as fallocate().
> 
> The patch moves s->file_lock assignment before fallocate and that is

s/file_lock/file_end/?

> crucial. The idea is that all subsequent requests into the area
> being preallocation will be issued as just writes without fallocate
> to this area and they will not proceed thanks to overlapping
> requests mechanics. If preallocation will fail, we will just switch
> to the normal expand-by-write behavior and that is not a problem
> except performance.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Tested-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  block/preallocate.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/block/preallocate.c b/block/preallocate.c
> index d215bc5d6d..ecf0aa4baa 100644
> --- a/block/preallocate.c
> +++ b/block/preallocate.c
> @@ -383,6 +383,13 @@ handle_write(BlockDriverState *bs, int64_t offset, int64_t bytes,
>  
>      want_merge_zero = want_merge_zero && (prealloc_start <= offset);
>  
> +    /*
> +     * Assign file_end before making actual preallocation. This will ensure
> +     * that next request performed while preallocation is in progress will
> +     * be passed without preallocation.
> +     */
> +    s->file_end = prealloc_end;
> +
>      ret = bdrv_co_pwrite_zeroes(
>              bs->file, prealloc_start, prealloc_end - prealloc_start,
>              BDRV_REQ_NO_FALLBACK | BDRV_REQ_SERIALISING | BDRV_REQ_NO_WAIT);
> @@ -391,7 +398,6 @@ handle_write(BlockDriverState *bs, int64_t offset, int64_t bytes,
>          return false;
>      }
>  
> -    s->file_end = prealloc_end;
>      return want_merge_zero;
>  }

Until bdrv_co_pwrite_zeroes() completes successfully, the file size is
unchanged. In other words, if anything calls preallocate_co_getlength()
in the meantime, don't we run into...

    ret = bdrv_co_getlength(bs->file->bs);

    if (has_prealloc_perms(bs)) {
        s->file_end = s->zero_start = s->data_end = ret;
    }

...and reset s->file_end back to the old value, re-enabling the bug
you're trying to fix here?

Or do we know that no such code path can be called concurrently for some
reason?

Kevin


