Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CCAF483E3
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 19:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4kad-0007AY-Rv; Mon, 23 Mar 2026 15:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w4kaa-00079h-5X
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 15:05:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w4kaX-0000Mi-Vy
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 15:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774292721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UXCrf1h2efAtzGOUeCkUjciakbWdoclbc51Baa1LVQQ=;
 b=jRrgAPv2pYKl02Y4aIDKhKK+AtabIbpU8msl3j2rKtYhJYw0+nJP552/X6un+clA1/ZMLp
 K0DX/waOH+lXIozXHa70szUpLdJTGLfQ6rRv+47duA0zQX0YjD7g1hfK05T1+WYymflM1n
 FwntO+hqjLPgGRxn4Cek10Gz1nCVx+s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-yVhy54NsObGG8ULqtshJxw-1; Mon,
 23 Mar 2026 15:05:16 -0400
X-MC-Unique: yVhy54NsObGG8ULqtshJxw-1
X-Mimecast-MFC-AGG-ID: yVhy54NsObGG8ULqtshJxw_1774292715
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A0B718005B6; Mon, 23 Mar 2026 19:05:15 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.184])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7FF7180075B; Mon, 23 Mar 2026 19:05:13 +0000 (UTC)
Date: Mon, 23 Mar 2026 20:05:10 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH for-11.0 3/3] io-uring: Resubmit tails of short writes
Message-ID: <acGO2kZ6Z5cHeWiu@redhat.com>
References: <20260318153206.171494-1-hreitz@redhat.com>
 <20260318153206.171494-4-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318153206.171494-4-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 18.03.2026 um 16:32 hat Hanna Czenczek geschrieben:
> Short writes can happen, too, not just short reads.  The difference to
> aio=native is that the kernel will actually retry the tail of short
> requests internally already -- so it is harder to reproduce.  But if the
> tail of a short request returns an error to the kernel, we will see it
> in userspace still.  To reproduce this, apply the following patch on top
> of the one shown in HEAD^ (again %s/escaped // to apply):
> 
> escaped diff --git a/block/export/fuse.c b/block/export/fuse.c
> escaped index 67dc50a412..2b98489a32 100644
> escaped --- a/block/export/fuse.c
> escaped +++ b/block/export/fuse.c
> @@ -1059,8 +1059,15 @@ fuse_co_read(FuseExport *exp, void **bufptr, uint64_t offset, uint32_t size)
>      int64_t blk_len;
>      void *buf;
>      int ret;
> +    static uint32_t error_size;
> 
> -    size = MIN(size, 4096);
> +    if (error_size == size) {
> +        error_size = 0;
> +        return -EIO;
> +    } else if (size > 4096) {
> +        error_size = size - 4096;
> +        size = 4096;
> +    }
> 
>      /* Limited by max_read, should not happen */
>      if (size > FUSE_MAX_READ_BYTES) {
> @@ -1111,8 +1118,15 @@ fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
>  {
>      int64_t blk_len;
>      int ret;
> +    static uint32_t error_size;
> 
> -    size = MIN(size, 4096);
> +    if (error_size == size) {
> +        error_size = 0;
> +        return -EIO;
> +    } else if (size > 4096) {
> +        error_size = size - 4096;
> +        size = 4096;
> +    }
> 
>      QEMU_BUILD_BUG_ON(FUSE_MAX_WRITE_BYTES > BDRV_REQUEST_MAX_BYTES);
>      /* Limited by max_write, should not happen */
> 
> I know this is a bit artificial because to produce this, there must be
> an I/O error somewhere anyway, but if it does happen, qemu will
> understand it to mean ENOSPC for short writes, which is incorrect.  So I
> believe we need to resubmit the tail to maybe have it succeed now, or at
> least get the correct error code.
> 
> Reproducer as before:
> $ ./qemu-img create -f raw test.raw 8k
> Formatting 'test.raw', fmt=raw size=8192
> $ ./qemu-io -f raw -c 'write -P 42 0 8k' test.raw
> wrote 8192/8192 bytes at offset 0
> 8 KiB, 1 ops; 00.00 sec (64.804 MiB/sec and 8294.9003 ops/sec)
> $ hexdump -C test.raw
> 00000000  2a 2a 2a 2a 2a 2a 2a 2a  2a 2a 2a 2a 2a 2a 2a 2a  |****************|
> *
> 00002000
> $ storage-daemon/qemu-storage-daemon \
>     --blockdev file,node-name=test,filename=test.raw \
>     --export fuse,id=exp,node-name=test,mountpoint=test.raw,writable=true
> 
> $ ./qemu-io --image-opts -c 'read -P 23 0 8k' \
>     driver=file,filename=test.raw,cache.direct=on,aio=io_uring
> read 8192/8192 bytes at offset 0
> 8 KiB, 1 ops; 00.00 sec (58.481 MiB/sec and 7485.5342 ops/sec)
> $ ./qemu-io --image-opts -c 'write -P 23 0 8k' \
>     driver=file,filename=test.raw,cache.direct=on,aio=io_uring
> write failed: No space left on device
> $ hexdump -C test.raw
> 00000000  17 17 17 17 17 17 17 17  17 17 17 17 17 17 17 17  |................|
> *
> 00001000  2a 2a 2a 2a 2a 2a 2a 2a  2a 2a 2a 2a 2a 2a 2a 2a  |****************|
> *
> 00002000
> 
> So short reads already work (because there is code for that), but short
> writes incorrectly produce ENOSPC.  This patch fixes that by
> resubmitting not only the tail of short reads but short writes also.
> 
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>

> @@ -44,6 +44,10 @@ static void luring_prep_sqe(struct io_uring_sqe *sqe, void *opaque)
       uint64_t offset = req->offset;
>      int fd = req->fd;
>      BdrvRequestFlags flags = req->flags;
>  
> +    if (req->resubmit_qiov.iov != NULL) {
> +        qiov = &req->resubmit_qiov;
> +    }
> +

We could have offset = req->offset + req->total_done again instead of
adding them in each case below, like I already commented on linux-aio.c.

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


