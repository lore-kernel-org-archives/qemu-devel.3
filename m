Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46732CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 13:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzbZM-0001d0-Pg; Fri, 19 Sep 2025 09:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uzbZI-0001c9-K7
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 09:54:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uzbZC-00028z-Cy
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 09:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758290061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=691UezJ766wNjDYHiAFheFGjS8jEvQmYuxJdVL6iO8I=;
 b=R4DTBnqdrVdPLcFnOzxvLv7ChoIMp2Uh38DV7G1oOO8w926+gCo/fRA8/lFZc6IV2Ckuqi
 Itdba8SI0dAH5Z5V+TXuqy7TCitAeAKZIFumfzI3XcJ+2j6wCxuAzOib0JKrDG0lixiNKO
 JeT6FhccEz4oSkIhq5qoRySdAJo05go=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-NA7tL1trPSCuWKpXxX6Bmw-1; Fri,
 19 Sep 2025 09:54:19 -0400
X-MC-Unique: NA7tL1trPSCuWKpXxX6Bmw-1
X-Mimecast-MFC-AGG-ID: NA7tL1trPSCuWKpXxX6Bmw_1758290058
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCB1119560A7; Fri, 19 Sep 2025 13:54:17 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.40])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8ED2F19560BB; Fri, 19 Sep 2025 13:54:14 +0000 (UTC)
Date: Fri, 19 Sep 2025 15:54:11 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Brian Song <hibriansong@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 bernd@bsbernd.com, fam@euphon.net, hreitz@redhat.com, stefanha@redhat.com
Subject: Re: [PATCH 2/4] export/fuse: process FUSE-over-io_uring requests
Message-ID: <aM1gbPaNMv50mPf-@redhat.com>
References: <20250830025025.3610-1-hibriansong@gmail.com>
 <20250830025025.3610-3-hibriansong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830025025.3610-3-hibriansong@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 30.08.2025 um 04:50 hat Brian Song geschrieben:
> https://docs.kernel.org/filesystems/fuse-io-uring.html
> 
> As described in the kernel documentation, after FUSE-over-io_uring
> initialization and handshake, FUSE interacts with the kernel using
> SQE/CQE to send requests and receive responses. This corresponds to
> the "Sending requests with CQEs" section in the docs.
> 
> This patch implements three key parts: registering the CQE handler
> (fuse_uring_cqe_handler), processing FUSE requests (fuse_uring_co_
> process_request), and sending response results (fuse_uring_send_
> response). It also merges the traditional /dev/fuse request handling
> with the FUSE-over-io_uring handling functions.
> 
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Brian Song <hibriansong@gmail.com>

A general remark first: I think this would be easier to review if it
were split into multiple patches. For example, at the first sight it
looks to me like I'd split at least:

- Factor out fuse_co_process_request_common() from
  fuse_co_process_request(). This would be a pure code movement patch
  with no intention to change the behaviour (i.e. it doesn't add any
  io_uring code yet). It is very common to have such refactoring commits
  in preparation for the addition of a new feature later.

- Change fuse_co_write() to allow a NULL in_place_buf

- Add io_uring request processing

All three are logically independent changes and can be reviewed on their
own. Maybe further splitting is possible that would only become obvious
when looking at the smaller patches.

>  block/export/fuse.c | 457 ++++++++++++++++++++++++++++++--------------
>  1 file changed, 309 insertions(+), 148 deletions(-)
> 
> diff --git a/block/export/fuse.c b/block/export/fuse.c
> index 19bf9e5f74..07f74fc8ec 100644
> --- a/block/export/fuse.c
> +++ b/block/export/fuse.c
> @@ -310,6 +310,47 @@ static const BlockDevOps fuse_export_blk_dev_ops = {
>  };
>  
>  #ifdef CONFIG_LINUX_IO_URING
> +static void coroutine_fn fuse_uring_co_process_request(FuseRingEnt *ent);
> +
> +static void coroutine_fn co_fuse_uring_queue_handle_cqes(void *opaque)
> +{
> +    FuseRingEnt *ent = opaque;
> +    FuseExport *exp = ent->rq->q->exp;
> +
> +    /* Going to process requests */
> +    fuse_inc_in_flight(exp);

I think this can be too late. The in_flight counter must be increased
before we start processing something that must be waited for in a drain.
Can't it happen here that a drain in the main thread already returns
while the CQE is still pending in an iothread, but nothing stops it from
being processed and starting new requests even though we're supossedly
in a drained section now?

> +    /* A ring entry returned */
> +    fuse_uring_co_process_request(ent);
> +
> +    /* Finished processing requests */
> +    fuse_dec_in_flight(exp);
> +}
> +
> +static void fuse_uring_cqe_handler(CqeHandler *cqe_handler)
> +{
> +    FuseRingEnt *ent = container_of(cqe_handler, FuseRingEnt, fuse_cqe_handler);
> +    Coroutine *co;
> +    FuseExport *exp = ent->rq->q->exp;
> +
> +    if (unlikely(exp->halted)) {
> +        return;
> +    }
> +
> +    int err = cqe_handler->cqe.res;
> +
> +    if (err != 0) {
> +        /* -ENOTCONN is ok on umount  */
> +        if (err != -EINTR && err != -EAGAIN &&
> +            err != -ENOTCONN) {

This fits on a single line (but I think the result was that you'll
remove some error codes anway).

> +            fuse_export_halt(exp);
> +        }
> +    } else {
> +        co = qemu_coroutine_create(co_fuse_uring_queue_handle_cqes, ent);
> +        qemu_coroutine_enter(co);
> +    }
> +}
> +
>  static void fuse_uring_sqe_set_req_data(struct fuse_uring_cmd_req *req,
>                      const unsigned int rqid,
>                      const unsigned int commit_id)
> @@ -1213,6 +1254,9 @@ fuse_co_read(FuseExport *exp, void **bufptr, uint64_t offset, uint32_t size)
>   * Data in @in_place_buf is assumed to be overwritten after yielding, so will
>   * be copied to a bounce buffer beforehand.  @spillover_buf in contrast is
>   * assumed to be exclusively owned and will be used as-is.
> + * In FUSE-over-io_uring mode, the actual op_payload content is stored in
> + * @spillover_buf. To ensure this buffer is used for writing, @in_place_buf
> + * is explicitly set to NULL.
>   * Return the number of bytes written to *out on success, and -errno on error.
>   */
>  static ssize_t coroutine_fn
> @@ -1220,8 +1264,8 @@ fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
>                uint64_t offset, uint32_t size,
>                const void *in_place_buf, const void *spillover_buf)
>  {
> -    size_t in_place_size;
> -    void *copied;
> +    size_t in_place_size = 0;
> +    void *copied = NULL;
>      int64_t blk_len;
>      int ret;
>      struct iovec iov[2];
> @@ -1236,10 +1280,12 @@ fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
>          return -EACCES;
>      }
>  
> -    /* Must copy to bounce buffer before potentially yielding */
> -    in_place_size = MIN(size, FUSE_IN_PLACE_WRITE_BYTES);
> -    copied = blk_blockalign(exp->common.blk, in_place_size);
> -    memcpy(copied, in_place_buf, in_place_size);
> +    if (in_place_buf) {
> +        /* Must copy to bounce buffer before potentially yielding */
> +        in_place_size = MIN(size, FUSE_IN_PLACE_WRITE_BYTES);
> +        copied = blk_blockalign(exp->common.blk, in_place_size);
> +        memcpy(copied, in_place_buf, in_place_size);
> +    }
>  
>      /**
>       * Clients will expect short writes at EOF, so we have to limit
> @@ -1263,26 +1309,38 @@ fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
>          }
>      }
>  
> -    iov[0] = (struct iovec) {
> -        .iov_base = copied,
> -        .iov_len = in_place_size,
> -    };
> -    if (size > FUSE_IN_PLACE_WRITE_BYTES) {
> -        assert(size - FUSE_IN_PLACE_WRITE_BYTES <= FUSE_SPILLOVER_BUF_SIZE);
> -        iov[1] = (struct iovec) {
> -            .iov_base = (void *)spillover_buf,
> -            .iov_len = size - FUSE_IN_PLACE_WRITE_BYTES,
> +    if (in_place_buf) {
> +        iov[0] = (struct iovec) {
> +            .iov_base = copied,
> +            .iov_len = in_place_size,
>          };
> -        qemu_iovec_init_external(&qiov, iov, 2);
> +        if (size > FUSE_IN_PLACE_WRITE_BYTES) {
> +            assert(size - FUSE_IN_PLACE_WRITE_BYTES <= FUSE_SPILLOVER_BUF_SIZE);
> +            iov[1] = (struct iovec) {
> +                .iov_base = (void *)spillover_buf,
> +                .iov_len = size - FUSE_IN_PLACE_WRITE_BYTES,
> +            };
> +            qemu_iovec_init_external(&qiov, iov, 2);
> +        } else {
> +            qemu_iovec_init_external(&qiov, iov, 1);
> +        }
>      } else {
> +        /* fuse over io_uring */
> +        iov[0] = (struct iovec) {
> +            .iov_base = (void *)spillover_buf,
> +            .iov_len = size,
> +        };
>          qemu_iovec_init_external(&qiov, iov, 1);
>      }
> +
>      ret = blk_co_pwritev(exp->common.blk, offset, size, &qiov, 0);
>      if (ret < 0) {
>          goto fail_free_buffer;
>      }
>  
> -    qemu_vfree(copied);
> +    if (in_place_buf) {
> +        qemu_vfree(copied);
> +    }
>  
>      *out = (struct fuse_write_out) {
>          .size = size,
> @@ -1290,7 +1348,9 @@ fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
>      return sizeof(*out);
>  
>  fail_free_buffer:
> -    qemu_vfree(copied);
> +    if (in_place_buf) {
> +        qemu_vfree(copied);
> +    }
>      return ret;
>  }
>  
> @@ -1578,173 +1638,151 @@ static int fuse_write_buf_response(int fd, uint32_t req_id,
>      }
>  }
>  
> -/*
> - * For use in fuse_co_process_request():
> - * Returns a pointer to the parameter object for the given operation (inside of
> - * queue->request_buf, which is assumed to hold a fuse_in_header first).
> - * Verifies that the object is complete (queue->request_buf is large enough to
> - * hold it in one piece, and the request length includes the whole object).
> - *
> - * Note that queue->request_buf may be overwritten after yielding, so the
> - * returned pointer must not be used across a function that may yield!
> - */
> -#define FUSE_IN_OP_STRUCT(op_name, queue) \
> +#define FUSE_IN_OP_STRUCT_LEGACY(in_buf) \
>      ({ \
> -        const struct fuse_in_header *__in_hdr = \
> -            (const struct fuse_in_header *)(queue)->request_buf; \
> -        const struct fuse_##op_name##_in *__in = \
> -            (const struct fuse_##op_name##_in *)(__in_hdr + 1); \
> -        const size_t __param_len = sizeof(*__in_hdr) + sizeof(*__in); \
> -        uint32_t __req_len; \
> -        \
> -        QEMU_BUILD_BUG_ON(sizeof((queue)->request_buf) < __param_len); \
> -        \
> -        __req_len = __in_hdr->len; \
> -        if (__req_len < __param_len) { \
> -            warn_report("FUSE request truncated (%" PRIu32 " < %zu)", \
> -                        __req_len, __param_len); \
> -            ret = -EINVAL; \
> -            break; \
> -        } \

This check made sure that we don't access in_buf out of bounds. What is
the replacement for it?

> -        __in; \
> +        (void *)(((struct fuse_in_header *)in_buf) + 1); \
>      })
>  
> -/*
> - * For use in fuse_co_process_request():
> - * Returns a pointer to the return object for the given operation (inside of
> - * out_buf, which is assumed to hold a fuse_out_header first).
> - * Verifies that out_buf is large enough to hold the whole object.
> - *
> - * (out_buf should be a char[] array.)
> - */
> -#define FUSE_OUT_OP_STRUCT(op_name, out_buf) \
> +#define FUSE_OUT_OP_STRUCT_LEGACY(out_buf) \
>      ({ \
> -        struct fuse_out_header *__out_hdr = \
> -            (struct fuse_out_header *)(out_buf); \
> -        struct fuse_##op_name##_out *__out = \
> -            (struct fuse_##op_name##_out *)(__out_hdr + 1); \
> -        \
> -        QEMU_BUILD_BUG_ON(sizeof(*__out_hdr) + sizeof(*__out) > \
> -                          sizeof(out_buf)); \
> -        \
> -        __out; \
> +        (void *)(((struct fuse_out_header *)out_buf) + 1); \
>      })
>  
> -/**
> - * Process a FUSE request, incl. writing the response.
> - *
> - * Note that yielding in any request-processing function can overwrite the
> - * contents of q->request_buf.  Anything that takes a buffer needs to take
> - * care that the content is copied before yielding.
> - *
> - * @spillover_buf can contain the tail of a write request too large to fit into
> - * q->request_buf.  This function takes ownership of it (i.e. will free it),
> - * which assumes that its contents will not be overwritten by concurrent
> - * requests (as opposed to q->request_buf).
> +
> +/*
> + * Shared helper for FUSE request processing. Handles both legacy and io_uring
> + * paths.
>   */
> -static void coroutine_fn
> -fuse_co_process_request(FuseQueue *q, void *spillover_buf)
> +static void coroutine_fn fuse_co_process_request_common(
> +    FuseExport *exp,
> +    uint32_t opcode,
> +    uint64_t req_id,
> +    void *in_buf,
> +    void *spillover_buf,
> +    void *out_buf,
> +    int fd, /* -1 for uring */
> +    void (*send_response)(void *opaque, uint32_t req_id, ssize_t ret,
> +                         const void *buf, void *out_buf),
> +    void *opaque /* FuseQueue* or FuseRingEnt* */)
>  {
> -    FuseExport *exp = q->exp;
> -    uint32_t opcode;
> -    uint64_t req_id;
> -    /*
> -     * Return buffer.  Must be large enough to hold all return headers, but does
> -     * not include space for data returned by read requests.
> -     * (FUSE_IN_OP_STRUCT() verifies at compile time that out_buf is indeed
> -     * large enough.)
> -     */
> -    char out_buf[sizeof(struct fuse_out_header) +
> -                 MAX_CONST(sizeof(struct fuse_init_out),
> -                 MAX_CONST(sizeof(struct fuse_open_out),
> -                 MAX_CONST(sizeof(struct fuse_attr_out),
> -                 MAX_CONST(sizeof(struct fuse_write_out),
> -                           sizeof(struct fuse_lseek_out)))))];
> -    struct fuse_out_header *out_hdr = (struct fuse_out_header *)out_buf;
> -    /* For read requests: Data to be returned */
>      void *out_data_buffer = NULL;
> -    ssize_t ret;
> +    ssize_t ret = 0;
>  
> -    /* Limit scope to ensure pointer is no longer used after yielding */
> -    {
> -        const struct fuse_in_header *in_hdr =
> -            (const struct fuse_in_header *)q->request_buf;
> +    void *op_in_buf = (void *)FUSE_IN_OP_STRUCT_LEGACY(in_buf);
> +    void *op_out_buf = (void *)FUSE_OUT_OP_STRUCT_LEGACY(out_buf);
>  
> -        opcode = in_hdr->opcode;
> -        req_id = in_hdr->unique;
> +#ifdef CONFIG_LINUX_IO_URING
> +    if (opcode != FUSE_INIT && exp->is_uring) {

Maybe add a comment explaining that FUSE_INIT is always delivered
through /dev/fuse, even if we want to enable io_uring?

> +        op_in_buf = (void *)in_buf;
> +        op_out_buf = (void *)out_buf;
>      }
> +#endif
>  
>      switch (opcode) {
>      case FUSE_INIT: {
> -        const struct fuse_init_in *in = FUSE_IN_OP_STRUCT(init, q);
> -        ret = fuse_co_init(exp, FUSE_OUT_OP_STRUCT(init, out_buf),
> -                           in->max_readahead, in->flags);
> +        const struct fuse_init_in *in =
> +            (const struct fuse_init_in *)FUSE_IN_OP_STRUCT_LEGACY(in_buf);
> +
> +        struct fuse_init_out *out =
> +            (struct fuse_init_out *)FUSE_OUT_OP_STRUCT_LEGACY(out_buf);

FUSE_IN_OP_STRUCT_LEGACY() returns a void *, so the explicit casts are
unnecessary. This applies to all of the commands below, too.

> +
> +        ret = fuse_co_init(exp, out, in->max_readahead, in);
>          break;
>      }
>  
> -    case FUSE_OPEN:
> -        ret = fuse_co_open(exp, FUSE_OUT_OP_STRUCT(open, out_buf));
> +    case FUSE_OPEN: {
> +        struct fuse_open_out *out =
> +            (struct fuse_open_out *)op_out_buf;
> +
> +        ret = fuse_co_open(exp, out);
>          break;
> +    }
>  
>      case FUSE_RELEASE:
>          ret = 0;
>          break;
>  
>      case FUSE_LOOKUP:
> -        ret = -ENOENT; /* There is no node but the root node */
> +        ret = -ENOENT;
>          break;

Why are you removing the comment?

>  
> -    case FUSE_GETATTR:
> -        ret = fuse_co_getattr(exp, FUSE_OUT_OP_STRUCT(attr, out_buf));
> +    case FUSE_GETATTR: {
> +        struct fuse_attr_out *out =
> +            (struct fuse_attr_out *)op_out_buf;
> +
> +        ret = fuse_co_getattr(exp, out);
>          break;
> +    }
>  
>      case FUSE_SETATTR: {
> -        const struct fuse_setattr_in *in = FUSE_IN_OP_STRUCT(setattr, q);
> -        ret = fuse_co_setattr(exp, FUSE_OUT_OP_STRUCT(attr, out_buf),
> -                              in->valid, in->size, in->mode, in->uid, in->gid);
> +        const struct fuse_setattr_in *in =
> +            (const struct fuse_setattr_in *)op_in_buf;
> +
> +        struct fuse_attr_out *out =
> +            (struct fuse_attr_out *)op_out_buf;
> +
> +        ret = fuse_co_setattr(exp, out, in->valid, in->size, in->mode,
> +                              in->uid, in->gid);
>          break;
>      }
>  
>      case FUSE_READ: {
> -        const struct fuse_read_in *in = FUSE_IN_OP_STRUCT(read, q);
> +        const struct fuse_read_in *in =
> +            (const struct fuse_read_in *)op_in_buf;
> +
>          ret = fuse_co_read(exp, &out_data_buffer, in->offset, in->size);
>          break;
>      }
>  
>      case FUSE_WRITE: {
> -        const struct fuse_write_in *in = FUSE_IN_OP_STRUCT(write, q);
> -        uint32_t req_len;
> -
> -        req_len = ((const struct fuse_in_header *)q->request_buf)->len;
> -        if (unlikely(req_len < sizeof(struct fuse_in_header) + sizeof(*in) +
> -                               in->size)) {
> -            warn_report("FUSE WRITE truncated; received %zu bytes of %" PRIu32,
> -                        req_len - sizeof(struct fuse_in_header) - sizeof(*in),
> -                        in->size);
> -            ret = -EINVAL;
> -            break;
> +        const struct fuse_write_in *in =
> +            (const struct fuse_write_in *)op_in_buf;
> +
> +        struct fuse_write_out *out =
> +            (struct fuse_write_out *)op_out_buf;
> +
> +#ifdef CONFIG_LINUX_IO_URING
> +        if (!exp->is_uring) {
> +#endif

I wonder if it wouldn't be better to have exp->is_uring available even
without CONFIG_LINUX_IO_URING, it would just always be false. It would
be nice to avoid #ifdefs in the middle of the function if they aren't
strictly necessary.

> +            uint32_t req_len = ((const struct fuse_in_header *)in_buf)->len;
> +
> +            if (unlikely(req_len < sizeof(struct fuse_in_header) + sizeof(*in) +
> +                        in->size)) {
> +                warn_report("FUSE WRITE truncated; received %zu bytes of %"
> +                    PRIu32,
> +                    req_len - sizeof(struct fuse_in_header) - sizeof(*in),
> +                    in->size);
> +                ret = -EINVAL;
> +                break;
> +            }
> +#ifdef CONFIG_LINUX_IO_URING
> +        } else {
> +            assert(in->size <=
> +                ((FuseRingEnt *)opaque)->req_header.ring_ent_in_out.payload_sz);
>          }
> +#endif
>  
> -        /*
> -         * poll_fuse_fd() has checked that in_hdr->len matches the number of
> -         * bytes read, which cannot exceed the max_write value we set
> -         * (FUSE_MAX_WRITE_BYTES).  So we know that FUSE_MAX_WRITE_BYTES >=
> -         * in_hdr->len >= in->size + X, so this assertion must hold.
> -         */
>          assert(in->size <= FUSE_MAX_WRITE_BYTES);

Instead of deleting the comment explaining why this is true, can you
just add a second paragraph explaining why it's true for io_uring, too?

> -        /*
> -         * Passing a pointer to `in` (i.e. the request buffer) is fine because
> -         * fuse_co_write() takes care to copy its contents before potentially
> -         * yielding.
> -         */

Why did you delete this comment? It's still true.

> -        ret = fuse_co_write(exp, FUSE_OUT_OP_STRUCT(write, out_buf),
> -                            in->offset, in->size, in + 1, spillover_buf);
> +        const void *in_place_buf = in + 1;
> +        const void *spill_buf = spillover_buf;
> +
> +#ifdef CONFIG_LINUX_IO_URING
> +        if (exp->is_uring) {
> +            in_place_buf = NULL;
> +            spill_buf = out_buf;
> +        }
> +#endif
> +
> +        ret = fuse_co_write(exp, out, in->offset, in->size,
> +                            in_place_buf, spill_buf);
>          break;
>      }
>  
>      case FUSE_FALLOCATE: {
> -        const struct fuse_fallocate_in *in = FUSE_IN_OP_STRUCT(fallocate, q);
> +        const struct fuse_fallocate_in *in =
> +            (const struct fuse_fallocate_in *)op_in_buf;
> +
>          ret = fuse_co_fallocate(exp, in->offset, in->length, in->mode);
>          break;
>      }

Kevin


