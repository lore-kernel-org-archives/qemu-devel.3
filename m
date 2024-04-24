Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98C6C10F15
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 12:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzbZL-0001tC-G0; Wed, 24 Apr 2024 08:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rzbZK-0001t2-1N
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 08:17:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rzbZI-0001Bq-5a
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 08:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713961062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MNqr3IHCfzprWKtVKTZH9+LYj6zgwI9P+4vNxSKeeLk=;
 b=emrh8XdE1s2gTpwgULbB4+i0YXAItnA25VGF5NXkCNiKuVAsBTZJ4la6hkngcIb92fULda
 s/Rad954GxDRocbCwG3UyVC8NJvoeHzMwsUxkSPNUXcSLH5Abq93BLxXSINOQ805+kPtpu
 1QCRVFL33SZYz4IB26AJM2xmY7pg424=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-59R2i3KaMM-i-BGQRx3UCg-1; Wed, 24 Apr 2024 08:17:41 -0400
X-MC-Unique: 59R2i3KaMM-i-BGQRx3UCg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05A808B6BC0;
 Wed, 24 Apr 2024 12:17:41 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.202])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 516571121312;
 Wed, 24 Apr 2024 12:17:39 +0000 (UTC)
Date: Wed, 24 Apr 2024 14:17:38 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: stefanha@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mtosatti@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v4] linux-aio: add IO_CMD_FDSYNC command support
Message-ID: <Zij4YnZxXwXFcnN3@redhat.com>
References: <20240314111628.1508636-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314111628.1508636-1-ppandit@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 14.03.2024 um 12:16 hat Prasad Pandit geschrieben:
> From: Prasad Pandit <pjp@fedoraproject.org>
> 
> Libaio defines IO_CMD_FDSYNC command to sync all outstanding
> asynchronous I/O operations, by flushing out file data to the
> disk storage.
> 
> Enable linux-aio to submit such aio request. This helps to
> reduce latency induced via pthread_create calls by
> thread-pool (aio=threads).
> 
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>

As we discussed in chat, it would be good to be more detailed about the
scenario that we're really concerned about here. The commit message
above sounds like submitting fdsync takes too long, but the real concern
seems to be about the effect that creating and destroying a thread has
on a vcpu by adding a TLB flush. Describing the mechanisms, the sequence
of operations that happen and the problem this causes in more detail
would make the commit message a lot more useful.

>  block/file-posix.c      |  7 +++++++
>  block/linux-aio.c       | 21 ++++++++++++++++++++-
>  include/block/raw-aio.h |  1 +
>  3 files changed, 28 insertions(+), 1 deletion(-)
> 
> v4: New boolean field to indicate if aio_fdsync is available or not.
>     It is set at file open time and checked before AIO_FLUSH call.
>   - https://lists.nongnu.org/archive/html/qemu-devel/2024-03/msg03701.html
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 35684f7e21..78a8cea03b 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -159,6 +159,7 @@ typedef struct BDRVRawState {
>      bool has_discard:1;
>      bool has_write_zeroes:1;
>      bool use_linux_aio:1;
> +    bool has_laio_fdsync:1;
>      bool use_linux_io_uring:1;
>      int page_cache_inconsistent; /* errno from fdatasync failure */
>      bool has_fallocate;
> @@ -718,6 +719,7 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
>          ret = -EINVAL;
>          goto fail;
>      }
> +    s->has_laio_fdsync = laio_has_fdsync(s->fd);

I think this should be conditional on s->use_linux_aio. No point in
probing it if we'll never call it anyway.

Kevin


