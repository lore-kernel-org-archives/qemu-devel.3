Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C3FC369A1
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 07:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2QBH-0000BE-G9; Wed, 09 Apr 2025 03:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u2QBA-0000Ak-0j
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 03:49:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u2QB5-0005tp-Lv
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 03:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744184934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/4jn6+e9lrVIOHm23pB3xvcbfrdQt/jZYFGBJr7v7XE=;
 b=GRP55yIH22G6Mwib/102nQwDjNqYJX6hH1nb+FvzvL2qhutuhEXRT/cqCXopQ6lX5llxht
 qE0ZDDZxe4DVhmKvrx4Y+oJMfqZOpkFSCOhn59RMa8TxOVn89QGkOByEPgL3+zIJ2q1+YZ
 6Drz7RgZ9QqSW2HemX8/XmOy+br83vE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-ptfAufRZNsqZUd8XPKHapw-1; Wed,
 09 Apr 2025 03:48:51 -0400
X-MC-Unique: ptfAufRZNsqZUd8XPKHapw-1
X-Mimecast-MFC-AGG-ID: ptfAufRZNsqZUd8XPKHapw_1744184930
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 666741809CA3; Wed,  9 Apr 2025 07:48:50 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.161])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8F74180B488; Wed,  9 Apr 2025 07:48:48 +0000 (UTC)
Date: Wed, 9 Apr 2025 09:48:46 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Pinku Deb Nath <prantoran@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v6] block/file-posix.c: Use pwritev2() with RWF_DSYNC for
 FUA
Message-ID: <Z_YmXu3RVE31KCp6@redhat.com>
References: <20250407154730.23008-1-prantoran@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407154730.23008-1-prantoran@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Am 07.04.2025 um 17:47 hat Pinku Deb Nath geschrieben:
> Full Unit Access (FUA) is an optimization where a disk write with the
> flag set will be persisted to disk immediately instead of potentially
> remaining in the disk's write cache.
> 
> This commit address the todo task
> for using pwritev2() with RWF_DSYNC in the thread pool section of
> raw_co_prw(), if pwritev2() with RWF_DSYNC is available in the host,
> which is always the case for Linux kernel >= 4.7.
> 
> The intent for FUA is indicated with the BDRV_REQ_FUA flag.
> The old code paths are preserved in case BDRV_REQ_FUA is off
> or pwritev2() with RWF_DSYNC is not available.
> 
> Support for disk writes with FUA is handled in qemu_pwritev_fua(),
> which uses pwritev2() with RWF_DSYNC if available, otherwise falls
> back to pwritev2() with no flags followed by flush using
> handle_aiocb_flush().
> 
> If pwritev2() is not implemented, then disk write in the linear FUA
> will fallback to pwrite() + handle_aiocb_flush().
> 
> Signed-off-by: Pinku Deb Nath <prantoran@gmail.com>
> 
> ---
> 
> v5:
> - Use pwritev for unsupported OSes
> 
> v4:
> - Add fallback when qemu_pwritev_fua() returns ENOSYS
> - Similar fallback was not added for handle_aiocb_rw_vector()
> since there is a preadv_present check in handle_aiocb_rw()
> 
> v3:
> - Changed signature to add fd, iov, nr_iov
> - Return -ENOSYS for non-Linux hosts
> 
> v2:
> - Moved handle_aiocb_flush() into qemu_pwritev_fua()
> - In handle_aiocb_rw_linear(), iovec with iovcnt=1 is created
> based on the assumption that there will be only one buffer
> ---
>  block/file-posix.c | 68 ++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 56 insertions(+), 12 deletions(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 56d1972d15..380f709917 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -229,6 +229,7 @@ typedef struct RawPosixAIOData {
>              unsigned long op;
>          } zone_mgmt;
>      };
> +    BdrvRequestFlags flags;
>  } RawPosixAIOData;
>  
>  #if defined(__FreeBSD__) || defined(__FreeBSD_kernel__)
> @@ -1674,6 +1675,20 @@ qemu_pwritev(int fd, const struct iovec *iov, int nr_iov, off_t offset)
>      return pwritev(fd, iov, nr_iov, offset);
>  }
>  
> +static ssize_t
> +qemu_pwritev_fua(int fd, struct iovec *iov, int nr_iov, off_t offset, RawPosixAIOData *aiocb)
> +{
> +#ifdef RWF_DSYNC
> +    return pwritev2(fd, iov, nr_iov, offset, RWF_DSYNC);

If pwritev2() fails with ENOSYS, we'll disable even pwritev(). I think
we should only try pwritev2(), and if it returns ENOSYS, we can execute
the code below with pwritev() + handle_aiocb_flush(), which would then
be outside the #ifdef.

Similar to preadv_present, we can have a bool pwritev2_present to avoid
trying pwritev2() every time when we already know it's not there.

> +#else
> +    ssize_t len = pwritev(fd, iov, nr_iov, offset);
> +    if (len == 0) {

pwritev() doesn't return 0, but the number of written bytes on success
(you even called the result 'len'!), so with len == 0, we would only
flush if someone tries to write at EOF of a block device or something.

> +        len = handle_aiocb_flush(aiocb);
> +    }
> +    return len;
> +#endif
> +}
> +
>  #else
>  
>  static bool preadv_present = false;
> @@ -1690,6 +1705,11 @@ qemu_pwritev(int fd, const struct iovec *iov, int nr_iov, off_t offset)
>      return -ENOSYS;
>  }
>  
> +static ssize_t
> +qemu_pwritev_fua(int fd, struct iovec *iov, int nr_iov, off_t offset, const RawPosixAIOData *aiocb)
> +{
> +    return -ENOSYS;
> +}

This is inconsistent with the interface of the function above. The
function above returns -1 with errno set on error, this one directly
returns a negative errno code. We need to pick one interface and stick
to it.

The existing definitions for qemu_preadv() are misleading because they
have the same problem - but they are never actually called because
preadv_present is always false. But qemu_pwritev_fua() is called below
in handle_aiocb_rw_linear() without checking preadv_present, so it
doesn't have the same excuse.

If you check a new pwritev2_present in handle_aiocb_rw_linear() and
initialise it as false in this #else block, then what we return here
doesn't matter any more and you can keep it consistent with the other
(misleading) functions.

(I think we should actually replace the existing return -ENOSYS with
g_assert_not_reached(), but that is for a separate patch.)

>  #endif
>  
>  static ssize_t handle_aiocb_rw_vector(RawPosixAIOData *aiocb)
> @@ -1698,10 +1718,16 @@ static ssize_t handle_aiocb_rw_vector(RawPosixAIOData *aiocb)
>  
>      len = RETRY_ON_EINTR(
>          (aiocb->aio_type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) ?
> -            qemu_pwritev(aiocb->aio_fildes,
> -                           aiocb->io.iov,
> -                           aiocb->io.niov,
> -                           aiocb->aio_offset) :
> +            (aiocb->flags &  BDRV_REQ_FUA) ?

Double space.

> +                qemu_pwritev_fua(aiocb->aio_fildes,
> +                                aiocb->io.iov,
> +                                aiocb->io.niov,
> +                                aiocb->aio_offset,
> +                                aiocb) :
> +                qemu_pwritev(aiocb->aio_fildes,
> +                            aiocb->io.iov,
> +                            aiocb->io.niov,
> +                            aiocb->aio_offset) :
>              qemu_preadv(aiocb->aio_fildes,
>                            aiocb->io.iov,
>                            aiocb->io.niov,
> @@ -1727,10 +1753,31 @@ static ssize_t handle_aiocb_rw_linear(RawPosixAIOData *aiocb, char *buf)
>  
>      while (offset < aiocb->aio_nbytes) {
>          if (aiocb->aio_type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) {
> -            len = pwrite(aiocb->aio_fildes,
> -                         (const char *)buf + offset,
> -                         aiocb->aio_nbytes - offset,
> -                         aiocb->aio_offset + offset);
> +            if (aiocb->flags & BDRV_REQ_FUA) {
> +                struct iovec iov = {
> +                    .iov_base = buf + offset,
> +                    .iov_len = aiocb->aio_nbytes - offset,
> +                };
> +                len = qemu_pwritev_fua(aiocb->aio_fildes,
> +                                    &iov,
> +                                    1,
> +                                    aiocb->aio_offset + offset,
> +                                    aiocb);
> +                if (len == -ENOSYS) {

This requires checking errno instead, like other instances in this
function do.

> +                    len = pwrite(aiocb->aio_fildes,
> +                                (const char *)buf + offset,
> +                                aiocb->aio_nbytes - offset,
> +                                aiocb->aio_offset + offset);
> +                    if (len == 0) {

Same problem as above with len == 0.

> +                        len = handle_aiocb_flush(aiocb);
> +                    }
> +                }
> +            } else {
> +                len = pwrite(aiocb->aio_fildes,
> +                            (const char *)buf + offset,
> +                            aiocb->aio_nbytes - offset,
> +                            aiocb->aio_offset + offset);
> +            }
>          } else {
>              len = pread(aiocb->aio_fildes,
>                          buf + offset,
> @@ -2539,14 +2586,11 @@ static int coroutine_fn raw_co_prw(BlockDriverState *bs, int64_t *offset_ptr,
>              .iov            = qiov->iov,
>              .niov           = qiov->niov,
>          },
> +        .flags          = flags,
>      };
>  
>      assert(qiov->size == bytes);
>      ret = raw_thread_pool_submit(handle_aiocb_rw, &acb);
> -    if (ret == 0 && (flags & BDRV_REQ_FUA)) {
> -        /* TODO Use pwritev2() instead if it's available */
> -        ret = raw_co_flush_to_disk(bs);
> -    }
>      goto out; /* Avoid the compiler err of unused label */
>  
>  out:

Kevin


