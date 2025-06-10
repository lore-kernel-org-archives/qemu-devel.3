Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E60FBC61DB2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 23:39:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP8XM-0003WJ-WB; Tue, 10 Jun 2025 19:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uP8XH-0003VF-Fw; Tue, 10 Jun 2025 19:37:44 -0400
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uP8XD-0007li-DW; Tue, 10 Jun 2025 19:37:42 -0400
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7d38b84984dso512393085a.0; 
 Tue, 10 Jun 2025 16:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749598656; x=1750203456; darn=nongnu.org;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PAsxjpgbltNizcgPQdZfJQsGNf+/X1QHrs4XCvYT82c=;
 b=WdW/C5gR7s6wRXnTkWFnlm+tJ3UBrZeLxbp0xIeUgtPd+6rLYZYRsvj2yqKYagHYz/
 clW9ulwgkw18kJ0LFzn3Xsg8n/zi8OeocNMQwlKPvAtb41mK678Kq4bkSRmgkGqbhPae
 SBIZd095RMmNp1vzJY4v4UFjjPuWiRdj4JwGzICqgZZPTb7LcBApezhMgM2tlIgyPULb
 Ck0+Dcy6dd2NU2xw2O08hRWO6XU9zMifFUgrFU15YuHkDgkpYKRe76QZ0VN1q99uhvFy
 QWw/Z5hbpW7ROTTP+uHDBdx0gp6YGETxAMyTZ7UJja0f9391hC4Yu7V9uRztZiYxQndN
 qwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749598656; x=1750203456;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PAsxjpgbltNizcgPQdZfJQsGNf+/X1QHrs4XCvYT82c=;
 b=MYqDFr/M1ikw0eAqFjT3iIBA7JMiYL2o4oH3M+8b4HV5NQv1OY11nm5KEVcDl5c5bX
 9ZwB6jUaZEhDhGxPjZS+eEZiNmw9p+7gyaRkHboYk+4TBE9pPvuEHQBfDVs9tluDN/jQ
 r6Q/gKoj7u8/iJzg4mWd5EzNLOSrZe1DD/0yXgk2npIWny5A2XAG4rS4SGB488X6A5DK
 JuQO6TiUdjT+hzXKmuXQsLnFHwq1UfeXXoJejNB6zfNR5ylh3ZTj757hGV6MwLtRKtZj
 BAMfa7jTSNBttljDrveE+UKPHCJbFqKeP9Ysi2dTcnHZt/VmP2qHswqjUEeEc5eThiTF
 qzBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkBxJwbWQJPMWSjTB0+CB4qIG38vBdpnAtVO6mN0pvxr2jp3noDgH+U/uPRcTrL7tuMjAXkMAvsAYv@nongnu.org
X-Gm-Message-State: AOJu0YxfxWGMpbx5Qn+d+BJeIRRG0eXVDCfDs1IkfnDyVX7ZWGrwtU3T
 ZIDazBgyxCj1rPpMwM0xthFZc7SaJiZVLWgsMgiKkuCxksxSNrAP6qhPRb+ijA==
X-Gm-Gg: ASbGnct4yROuHIoPoWgImJ6yebx+IRLhxpSxqoPMX66IwuVP+xPJ49CGkMjMESqbMdY
 gJbJ8xY06uLZ0CA8XTBCjmegcQjPWj/UzZTffcotY9MHz2Y4vflwNIHQH+3HSxEaCjnyctxvEtc
 DBVQGktLEFAVxFqfHif8cp95XK1TS11s38brOYfWogClKn5TqOnNiQqN/ECCHfLN8u6kX3H8No4
 l+A+DewkugcEkcwd4JV8XHCwwWSgqWVVxgg4lFt0MzqCdD8RoAVkqLAEdaGazwpIzqBXPIDAewB
 GpOskDlL6TLsijgMOJE2a+kYQ+s+1cBWVVQ8wnXAQDO2jSC1cOvz4ODrY2ZC+vFmTI9xC90DQ06
 ad3xfLWE9c507t7rgSVtVDENUhLKkmGRkzA4CDDccxVIv7c0=
X-Google-Smtp-Source: AGHT+IEZ1aIZoHOoWBbcEbvAwUZ07LnHs9R4t7oOi6KmaX9LFrlvlt6LL9n0U5O/28el1P744FdoTA==
X-Received: by 2002:a05:620a:45a2:b0:7c5:9fd3:a90b with SMTP id
 af79cd13be357-7d3a9602074mr126984185a.47.1749598656159; 
 Tue, 10 Jun 2025 16:37:36 -0700 (PDT)
Received: from [10.36.127.40]
 (wn-campus-nat-129-97-124-40.dynamic.uwaterloo.ca. [129.97.124.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d2669b3b3asm765061585a.103.2025.06.10.16.37.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 16:37:35 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------uuyqaVcvh90y8MxyITfQ0TVr"
Message-ID: <0eb2f89d-7be4-4480-a7e3-1b16344364db@gmail.com>
Date: Tue, 10 Jun 2025 19:37:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/21] fuse: Increase MAX_WRITE_SIZE with a second
 buffer
To: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20250604132813.359438-1-hreitz@redhat.com>
 <20250604132813.359438-22-hreitz@redhat.com>
Content-Language: en-US
From: Brian <hibriansong@gmail.com>
In-Reply-To: <20250604132813.359438-22-hreitz@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=hibriansong@gmail.com; helo=mail-qk1-x732.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------uuyqaVcvh90y8MxyITfQ0TVr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I'm currently working on the fuse over io_uring feature for QEMU
FUSE export. When I submit SQEs to the /dev/fuse file descriptor
during the register phase, the kernel returns an error (in the
fuse_uring_create_ring_ent()). It seems this is because the payload
size (i.e. spillover_buf size, which is FUSE_MAX_WRITE_BYTES (64 *
4k) minus FUSE_IN_PLACE_WRITE_BYTES (4 * 4k)) is smaller than
ring->max_payload_sz (which is 32 pages * 4k).

Do we need to increase the spillover_buf size, or is there any
other workaround?


Brian

On 6/4/25 9:28 AM, Hanna Czenczek wrote:
> We probably want to support larger write sizes than just 4k; 64k seems
> nice.  However, we cannot read partial requests from the FUSE FD, we
> always have to read requests in full; so our read buffer must be large
> enough to accommodate potential 64k writes if we want to support that.
>
> Always allocating FuseRequest objects with 64k buffers in them seems
> wasteful, though.  But we can get around the issue by splitting the
> buffer into two and using readv(): One part will hold all normal (up to
> 4k) write requests and all other requests, and a second part (the
> "spill-over buffer") will be used only for larger write requests.  Each
> FuseQueue has its own spill-over buffer, and only if we find it used
> when reading a request will we move its ownership into the FuseRequest
> object and allocate a new spill-over buffer for the queue.
>
> This way, we get to support "large" write sizes without having to
> allocate big buffers when they aren't used.
>
> Also, this even reduces the size of the FuseRequest objects because the
> read buffer has to have at least FUSE_MIN_READ_BUFFER (8192) bytes; but
> the requests we support are not quite so large (except for >4k writes),
> so until now, we basically had to have useless padding in there.
>
> With the spill-over buffer added, the FUSE_MIN_READ_BUFFER requirement
> is easily met and we can decrease the size of the buffer portion that is
> right inside of FuseRequest.
>
> As for benchmarks, the benefit of this patch can be shown easily by
> writing a 4G image (with qemu-img convert) to a FUSE export:
> - Before this patch: Takes 25.6 s (14.4 s with -t none)
> - After this patch: Takes 4.5 s (5.5 s with -t none)
>
> Reviewed-by: Stefan Hajnoczi<stefanha@redhat.com>
> Signed-off-by: Hanna Czenczek<hreitz@redhat.com>
> ---
>   block/export/fuse.c | 137 ++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 118 insertions(+), 19 deletions(-)
>
> diff --git a/block/export/fuse.c b/block/export/fuse.c
> index cdec31f2a8..908266d101 100644
> --- a/block/export/fuse.c
> +++ b/block/export/fuse.c
> @@ -50,8 +50,17 @@
>   
>   /* Prevent overly long bounce buffer allocations */
>   #define FUSE_MAX_READ_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 1 * 1024 * 1024))
> -/* Small enough to fit in the request buffer */
> -#define FUSE_MAX_WRITE_BYTES (4 * 1024)
> +/*
> + * FUSE_MAX_WRITE_BYTES determines the maximum number of bytes we support in a
> + * write request; FUSE_IN_PLACE_WRITE_BYTES and FUSE_SPILLOVER_BUF_SIZE
> + * determine the split between the size of the in-place buffer in FuseRequest
> + * and the spill-over buffer in FuseQueue.  See FuseQueue.spillover_buf for a
> + * detailed explanation.
> + */
> +#define FUSE_IN_PLACE_WRITE_BYTES (4 * 1024)
> +#define FUSE_MAX_WRITE_BYTES (64 * 1024)
> +#define FUSE_SPILLOVER_BUF_SIZE \
> +    (FUSE_MAX_WRITE_BYTES - FUSE_IN_PLACE_WRITE_BYTES)
>   
>   typedef struct FuseExport FuseExport;
>   
> @@ -67,15 +76,49 @@ typedef struct FuseQueue {
>   
>       /*
>        * The request buffer must be able to hold a full write, and/or at least
> -     * FUSE_MIN_READ_BUFFER (from linux/fuse.h) bytes
> +     * FUSE_MIN_READ_BUFFER (from linux/fuse.h) bytes.
> +     * This however is just the first part of the buffer; every read is given
> +     * a vector of this buffer (which should be enough for all normal requests,
> +     * which we check via the static assertion in FUSE_IN_OP_STRUCT()) and the
> +     * spill-over buffer below.
> +     * Therefore, the size of this buffer plus FUSE_SPILLOVER_BUF_SIZE must be
> +     * FUSE_MIN_READ_BUFFER or more (checked via static assertion below).
> +     */
> +    char request_buf[sizeof(struct fuse_in_header) +
> +                     sizeof(struct fuse_write_in) +
> +                     FUSE_IN_PLACE_WRITE_BYTES];
> +
> +    /*
> +     * When retrieving a FUSE request, the destination buffer must always be
> +     * sufficiently large for the whole request, i.e. with max_write=64k, we
> +     * must provide a buffer that fits the WRITE header and 64 kB of space for
> +     * data.
> +     * We do want to support 64k write requests without requiring them to be
> +     * split up, but at the same time, do not want to do such a large allocation
> +     * for every single request.
> +     * Therefore, the FuseRequest object provides an in-line buffer that is
> +     * enough for write requests up to 4k (and all other requests), and for
> +     * every request that is bigger, we provide a spill-over buffer here (for
> +     * the remaining 64k - 4k = 60k).
> +     * When poll_fuse_fd() reads a FUSE request, it passes these buffers as an
> +     * I/O vector, and then checks the return value (number of bytes read) to
> +     * find out whether the spill-over buffer was used.  If so, it will move the
> +     * buffer to the request, and will allocate a new spill-over buffer for the
> +     * next request.
> +     *
> +     * Free this buffer with qemu_vfree().
>        */
> -    char request_buf[MAX_CONST(
> -        sizeof(struct fuse_in_header) + sizeof(struct fuse_write_in) +
> -             FUSE_MAX_WRITE_BYTES,
> -        FUSE_MIN_READ_BUFFER
> -    )];
> +    void *spillover_buf;
>   } FuseQueue;
>   
> +/*
> + * Verify that FuseQueue.request_buf plus the spill-over buffer together
> + * are big enough to be accepted by the FUSE kernel driver.
> + */
> +QEMU_BUILD_BUG_ON(sizeof(((FuseQueue *)0)->request_buf) +
> +                  FUSE_SPILLOVER_BUF_SIZE <
> +                  FUSE_MIN_READ_BUFFER);
> +
>   struct FuseExport {
>       BlockExport common;
>   
> @@ -131,7 +174,8 @@ static int clone_fuse_fd(int fd, Error **errp);
>   static bool is_regular_file(const char *path, Error **errp);
>   
>   static void read_from_fuse_fd(void *opaque);
> -static void coroutine_fn fuse_co_process_request(FuseQueue *q);
> +static void coroutine_fn
> +fuse_co_process_request(FuseQueue *q, void *spillover_buf);
>   
>   static void fuse_inc_in_flight(FuseExport *exp)
>   {
> @@ -476,12 +520,27 @@ static void coroutine_fn co_read_from_fuse_fd(void *opaque)
>       FuseExport *exp = q->exp;
>       ssize_t ret;
>       const struct fuse_in_header *in_hdr;
> +    struct iovec iov[2];
> +    void *spillover_buf = NULL;
>   
>       if (unlikely(exp->halted)) {
>           goto no_request;
>       }
>   
> -    ret = RETRY_ON_EINTR(read(fuse_fd, q->request_buf, sizeof(q->request_buf)));
> +    /*
> +     * If handling the last request consumed the spill-over buffer, allocate a
> +     * new one.  Align it to the block device's alignment, which admittedly is
> +     * only useful if FUSE_IN_PLACE_WRITE_BYTES is aligned, too.
> +     */
> +    if (unlikely(!q->spillover_buf)) {
> +        q->spillover_buf = blk_blockalign(exp->common.blk,
> +                                          FUSE_SPILLOVER_BUF_SIZE);
> +    }
> +    /* Construct the I/O vector to hold the FUSE request */
> +    iov[0] = (struct iovec) { q->request_buf, sizeof(q->request_buf) };
> +    iov[1] = (struct iovec) { q->spillover_buf, FUSE_SPILLOVER_BUF_SIZE };
> +
> +    ret = RETRY_ON_EINTR(readv(fuse_fd, iov, ARRAY_SIZE(iov)));
>       if (ret < 0 && errno == EAGAIN) {
>           /* No request available */
>           goto no_request;
> @@ -510,7 +569,13 @@ static void coroutine_fn co_read_from_fuse_fd(void *opaque)
>           goto no_request;
>       }
>   
> -    fuse_co_process_request(q);
> +    if (unlikely(ret > sizeof(q->request_buf))) {
> +        /* Spillover buffer used, take ownership */
> +        spillover_buf = q->spillover_buf;
> +        q->spillover_buf = NULL;
> +    }
> +
> +    fuse_co_process_request(q, spillover_buf);
>   
>   no_request:
>       fuse_dec_in_flight(exp);
> @@ -560,6 +625,9 @@ static void fuse_export_delete(BlockExport *blk_exp)
>           if (i > 0 && q->fuse_fd >= 0) {
>               close(q->fuse_fd);
>           }
> +        if (q->spillover_buf) {
> +            qemu_vfree(q->spillover_buf);
> +        }
>       }
>       g_free(exp->queues);
>   
> @@ -869,17 +937,25 @@ fuse_co_read(FuseExport *exp, void **bufptr, uint64_t offset, uint32_t size)
>   }
>   
>   /**
> - * Handle client writes to the exported image.  @buf has the data to be written
> - * and will be copied to a bounce buffer before yielding for the first time.
> + * Handle client writes to the exported image.  @in_place_buf has the first
> + * FUSE_IN_PLACE_WRITE_BYTES bytes of the data to be written, @spillover_buf
> + * contains the rest (if any; NULL otherwise).
> + * Data in @in_place_buf is assumed to be overwritten after yielding, so will
> + * be copied to a bounce buffer beforehand.  @spillover_buf in contrast is
> + * assumed to be exclusively owned and will be used as-is.
>    * Return the number of bytes written to *out on success, and -errno on error.
>    */
>   static ssize_t coroutine_fn
>   fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
> -              uint64_t offset, uint32_t size, const void *buf)
> +              uint64_t offset, uint32_t size,
> +              const void *in_place_buf, const void *spillover_buf)
>   {
> +    size_t in_place_size;
>       void *copied;
>       int64_t blk_len;
>       int ret;
> +    struct iovec iov[2];
> +    QEMUIOVector qiov;
>   
>       /* Limited by max_write, should not happen */
>       if (size > BDRV_REQUEST_MAX_BYTES) {
> @@ -891,8 +967,9 @@ fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
>       }
>   
>       /* Must copy to bounce buffer before potentially yielding */
> -    copied = blk_blockalign(exp->common.blk, size);
> -    memcpy(copied, buf, size);
> +    in_place_size = MIN(size, FUSE_IN_PLACE_WRITE_BYTES);
> +    copied = blk_blockalign(exp->common.blk, in_place_size);
> +    memcpy(copied, in_place_buf, in_place_size);
>   
>       /**
>        * Clients will expect short writes at EOF, so we have to limit
> @@ -916,7 +993,21 @@ fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
>           }
>       }
>   
> -    ret = blk_co_pwrite(exp->common.blk, offset, size, copied, 0);
> +    iov[0] = (struct iovec) {
> +        .iov_base = copied,
> +        .iov_len = in_place_size,
> +    };
> +    if (size > FUSE_IN_PLACE_WRITE_BYTES) {
> +        assert(size - FUSE_IN_PLACE_WRITE_BYTES <= FUSE_SPILLOVER_BUF_SIZE);
> +        iov[1] = (struct iovec) {
> +            .iov_base = (void *)spillover_buf,
> +            .iov_len = size - FUSE_IN_PLACE_WRITE_BYTES,
> +        };
> +        qemu_iovec_init_external(&qiov, iov, 2);
> +    } else {
> +        qemu_iovec_init_external(&qiov, iov, 1);
> +    }
> +    ret = blk_co_pwritev(exp->common.blk, offset, size, &qiov, 0);
>       if (ret < 0) {
>           goto fail_free_buffer;
>       }
> @@ -1275,8 +1366,14 @@ static int fuse_write_buf_response(int fd, uint32_t req_id,
>    * Note that yielding in any request-processing function can overwrite the
>    * contents of q->request_buf.  Anything that takes a buffer needs to take
>    * care that the content is copied before yielding.
> + *
> + * @spillover_buf can contain the tail of a write request too large to fit into
> + * q->request_buf.  This function takes ownership of it (i.e. will free it),
> + * which assumes that its contents will not be overwritten by concurrent
> + * requests (as opposed to q->request_buf).
>    */
> -static void coroutine_fn fuse_co_process_request(FuseQueue *q)
> +static void coroutine_fn
> +fuse_co_process_request(FuseQueue *q, void *spillover_buf)
>   {
>       FuseExport *exp = q->exp;
>       uint32_t opcode;
> @@ -1372,7 +1469,7 @@ static void coroutine_fn fuse_co_process_request(FuseQueue *q)
>            * yielding.
>            */
>           ret = fuse_co_write(exp, FUSE_OUT_OP_STRUCT(write, out_buf),
> -                            in->offset, in->size, in + 1);
> +                            in->offset, in->size, in + 1, spillover_buf);
>           break;
>       }
>   
> @@ -1414,6 +1511,8 @@ static void coroutine_fn fuse_co_process_request(FuseQueue *q)
>                               ret < 0 ? ret : 0,
>                               ret < 0 ? 0 : ret);
>       }
> +
> +    qemu_vfree(spillover_buf);
>   }
>   
>   const BlockExportDriver blk_exp_fuse = {
--------------uuyqaVcvh90y8MxyITfQ0TVr
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html data-lt-installed="true">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body style="padding-bottom: 1px;">
    <p>Hi all,<br>
      <br>
      I'm currently working on the fuse over io_uring feature for QEMU<br>
      FUSE export. When I submit SQEs to the /dev/fuse file descriptor<br>
      during the register phase, the kernel returns an error (in the<br>
      fuse_uring_create_ring_ent()). It seems this is because the
      payload<br>
      size (i.e. spillover_buf size, which is FUSE_MAX_WRITE_BYTES (64 *<br>
      4k) minus FUSE_IN_PLACE_WRITE_BYTES (4 * 4k)) is smaller than<br>
      ring-&gt;max_payload_sz (which is 32 pages * 4k).<br>
      <br>
      Do we need to increase the spillover_buf size, or is there any<br>
      other workaround?<br>
      <br>
      <br>
      Brian<br>
      <br>
    </p>
    <div class="moz-cite-prefix">On 6/4/25 9:28 AM, Hanna Czenczek
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20250604132813.359438-22-hreitz@redhat.com">
      <pre wrap="" class="moz-quote-pre">We probably want to support larger write sizes than just 4k; 64k seems
nice.  However, we cannot read partial requests from the FUSE FD, we
always have to read requests in full; so our read buffer must be large
enough to accommodate potential 64k writes if we want to support that.

Always allocating FuseRequest objects with 64k buffers in them seems
wasteful, though.  But we can get around the issue by splitting the
buffer into two and using readv(): One part will hold all normal (up to
4k) write requests and all other requests, and a second part (the
"spill-over buffer") will be used only for larger write requests.  Each
FuseQueue has its own spill-over buffer, and only if we find it used
when reading a request will we move its ownership into the FuseRequest
object and allocate a new spill-over buffer for the queue.

This way, we get to support "large" write sizes without having to
allocate big buffers when they aren't used.

Also, this even reduces the size of the FuseRequest objects because the
read buffer has to have at least FUSE_MIN_READ_BUFFER (8192) bytes; but
the requests we support are not quite so large (except for &gt;4k writes),
so until now, we basically had to have useless padding in there.

With the spill-over buffer added, the FUSE_MIN_READ_BUFFER requirement
is easily met and we can decrease the size of the buffer portion that is
right inside of FuseRequest.

As for benchmarks, the benefit of this patch can be shown easily by
writing a 4G image (with qemu-img convert) to a FUSE export:
- Before this patch: Takes 25.6 s (14.4 s with -t none)
- After this patch: Takes 4.5 s (5.5 s with -t none)

Reviewed-by: Stefan Hajnoczi <a class="moz-txt-link-rfc2396E" href="mailto:stefanha@redhat.com">&lt;stefanha@redhat.com&gt;</a>
Signed-off-by: Hanna Czenczek <a class="moz-txt-link-rfc2396E" href="mailto:hreitz@redhat.com">&lt;hreitz@redhat.com&gt;</a>
---
 block/export/fuse.c | 137 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 118 insertions(+), 19 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index cdec31f2a8..908266d101 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -50,8 +50,17 @@
 
 /* Prevent overly long bounce buffer allocations */
 #define FUSE_MAX_READ_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 1 * 1024 * 1024))
-/* Small enough to fit in the request buffer */
-#define FUSE_MAX_WRITE_BYTES (4 * 1024)
+/*
+ * FUSE_MAX_WRITE_BYTES determines the maximum number of bytes we support in a
+ * write request; FUSE_IN_PLACE_WRITE_BYTES and FUSE_SPILLOVER_BUF_SIZE
+ * determine the split between the size of the in-place buffer in FuseRequest
+ * and the spill-over buffer in FuseQueue.  See FuseQueue.spillover_buf for a
+ * detailed explanation.
+ */
+#define FUSE_IN_PLACE_WRITE_BYTES (4 * 1024)
+#define FUSE_MAX_WRITE_BYTES (64 * 1024)
+#define FUSE_SPILLOVER_BUF_SIZE \
+    (FUSE_MAX_WRITE_BYTES - FUSE_IN_PLACE_WRITE_BYTES)
 
 typedef struct FuseExport FuseExport;
 
@@ -67,15 +76,49 @@ typedef struct FuseQueue {
 
     /*
      * The request buffer must be able to hold a full write, and/or at least
-     * FUSE_MIN_READ_BUFFER (from linux/fuse.h) bytes
+     * FUSE_MIN_READ_BUFFER (from linux/fuse.h) bytes.
+     * This however is just the first part of the buffer; every read is given
+     * a vector of this buffer (which should be enough for all normal requests,
+     * which we check via the static assertion in FUSE_IN_OP_STRUCT()) and the
+     * spill-over buffer below.
+     * Therefore, the size of this buffer plus FUSE_SPILLOVER_BUF_SIZE must be
+     * FUSE_MIN_READ_BUFFER or more (checked via static assertion below).
+     */
+    char request_buf[sizeof(struct fuse_in_header) +
+                     sizeof(struct fuse_write_in) +
+                     FUSE_IN_PLACE_WRITE_BYTES];
+
+    /*
+     * When retrieving a FUSE request, the destination buffer must always be
+     * sufficiently large for the whole request, i.e. with max_write=64k, we
+     * must provide a buffer that fits the WRITE header and 64 kB of space for
+     * data.
+     * We do want to support 64k write requests without requiring them to be
+     * split up, but at the same time, do not want to do such a large allocation
+     * for every single request.
+     * Therefore, the FuseRequest object provides an in-line buffer that is
+     * enough for write requests up to 4k (and all other requests), and for
+     * every request that is bigger, we provide a spill-over buffer here (for
+     * the remaining 64k - 4k = 60k).
+     * When poll_fuse_fd() reads a FUSE request, it passes these buffers as an
+     * I/O vector, and then checks the return value (number of bytes read) to
+     * find out whether the spill-over buffer was used.  If so, it will move the
+     * buffer to the request, and will allocate a new spill-over buffer for the
+     * next request.
+     *
+     * Free this buffer with qemu_vfree().
      */
-    char request_buf[MAX_CONST(
-        sizeof(struct fuse_in_header) + sizeof(struct fuse_write_in) +
-             FUSE_MAX_WRITE_BYTES,
-        FUSE_MIN_READ_BUFFER
-    )];
+    void *spillover_buf;
 } FuseQueue;
 
+/*
+ * Verify that FuseQueue.request_buf plus the spill-over buffer together
+ * are big enough to be accepted by the FUSE kernel driver.
+ */
+QEMU_BUILD_BUG_ON(sizeof(((FuseQueue *)0)-&gt;request_buf) +
+                  FUSE_SPILLOVER_BUF_SIZE &lt;
+                  FUSE_MIN_READ_BUFFER);
+
 struct FuseExport {
     BlockExport common;
 
@@ -131,7 +174,8 @@ static int clone_fuse_fd(int fd, Error **errp);
 static bool is_regular_file(const char *path, Error **errp);
 
 static void read_from_fuse_fd(void *opaque);
-static void coroutine_fn fuse_co_process_request(FuseQueue *q);
+static void coroutine_fn
+fuse_co_process_request(FuseQueue *q, void *spillover_buf);
 
 static void fuse_inc_in_flight(FuseExport *exp)
 {
@@ -476,12 +520,27 @@ static void coroutine_fn co_read_from_fuse_fd(void *opaque)
     FuseExport *exp = q-&gt;exp;
     ssize_t ret;
     const struct fuse_in_header *in_hdr;
+    struct iovec iov[2];
+    void *spillover_buf = NULL;
 
     if (unlikely(exp-&gt;halted)) {
         goto no_request;
     }
 
-    ret = RETRY_ON_EINTR(read(fuse_fd, q-&gt;request_buf, sizeof(q-&gt;request_buf)));
+    /*
+     * If handling the last request consumed the spill-over buffer, allocate a
+     * new one.  Align it to the block device's alignment, which admittedly is
+     * only useful if FUSE_IN_PLACE_WRITE_BYTES is aligned, too.
+     */
+    if (unlikely(!q-&gt;spillover_buf)) {
+        q-&gt;spillover_buf = blk_blockalign(exp-&gt;common.blk,
+                                          FUSE_SPILLOVER_BUF_SIZE);
+    }
+    /* Construct the I/O vector to hold the FUSE request */
+    iov[0] = (struct iovec) { q-&gt;request_buf, sizeof(q-&gt;request_buf) };
+    iov[1] = (struct iovec) { q-&gt;spillover_buf, FUSE_SPILLOVER_BUF_SIZE };
+
+    ret = RETRY_ON_EINTR(readv(fuse_fd, iov, ARRAY_SIZE(iov)));
     if (ret &lt; 0 &amp;&amp; errno == EAGAIN) {
         /* No request available */
         goto no_request;
@@ -510,7 +569,13 @@ static void coroutine_fn co_read_from_fuse_fd(void *opaque)
         goto no_request;
     }
 
-    fuse_co_process_request(q);
+    if (unlikely(ret &gt; sizeof(q-&gt;request_buf))) {
+        /* Spillover buffer used, take ownership */
+        spillover_buf = q-&gt;spillover_buf;
+        q-&gt;spillover_buf = NULL;
+    }
+
+    fuse_co_process_request(q, spillover_buf);
 
 no_request:
     fuse_dec_in_flight(exp);
@@ -560,6 +625,9 @@ static void fuse_export_delete(BlockExport *blk_exp)
         if (i &gt; 0 &amp;&amp; q-&gt;fuse_fd &gt;= 0) {
             close(q-&gt;fuse_fd);
         }
+        if (q-&gt;spillover_buf) {
+            qemu_vfree(q-&gt;spillover_buf);
+        }
     }
     g_free(exp-&gt;queues);
 
@@ -869,17 +937,25 @@ fuse_co_read(FuseExport *exp, void **bufptr, uint64_t offset, uint32_t size)
 }
 
 /**
- * Handle client writes to the exported image.  @buf has the data to be written
- * and will be copied to a bounce buffer before yielding for the first time.
+ * Handle client writes to the exported image.  @in_place_buf has the first
+ * FUSE_IN_PLACE_WRITE_BYTES bytes of the data to be written, @spillover_buf
+ * contains the rest (if any; NULL otherwise).
+ * Data in @in_place_buf is assumed to be overwritten after yielding, so will
+ * be copied to a bounce buffer beforehand.  @spillover_buf in contrast is
+ * assumed to be exclusively owned and will be used as-is.
  * Return the number of bytes written to *out on success, and -errno on error.
  */
 static ssize_t coroutine_fn
 fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
-              uint64_t offset, uint32_t size, const void *buf)
+              uint64_t offset, uint32_t size,
+              const void *in_place_buf, const void *spillover_buf)
 {
+    size_t in_place_size;
     void *copied;
     int64_t blk_len;
     int ret;
+    struct iovec iov[2];
+    QEMUIOVector qiov;
 
     /* Limited by max_write, should not happen */
     if (size &gt; BDRV_REQUEST_MAX_BYTES) {
@@ -891,8 +967,9 @@ fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
     }
 
     /* Must copy to bounce buffer before potentially yielding */
-    copied = blk_blockalign(exp-&gt;common.blk, size);
-    memcpy(copied, buf, size);
+    in_place_size = MIN(size, FUSE_IN_PLACE_WRITE_BYTES);
+    copied = blk_blockalign(exp-&gt;common.blk, in_place_size);
+    memcpy(copied, in_place_buf, in_place_size);
 
     /**
      * Clients will expect short writes at EOF, so we have to limit
@@ -916,7 +993,21 @@ fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
         }
     }
 
-    ret = blk_co_pwrite(exp-&gt;common.blk, offset, size, copied, 0);
+    iov[0] = (struct iovec) {
+        .iov_base = copied,
+        .iov_len = in_place_size,
+    };
+    if (size &gt; FUSE_IN_PLACE_WRITE_BYTES) {
+        assert(size - FUSE_IN_PLACE_WRITE_BYTES &lt;= FUSE_SPILLOVER_BUF_SIZE);
+        iov[1] = (struct iovec) {
+            .iov_base = (void *)spillover_buf,
+            .iov_len = size - FUSE_IN_PLACE_WRITE_BYTES,
+        };
+        qemu_iovec_init_external(&amp;qiov, iov, 2);
+    } else {
+        qemu_iovec_init_external(&amp;qiov, iov, 1);
+    }
+    ret = blk_co_pwritev(exp-&gt;common.blk, offset, size, &amp;qiov, 0);
     if (ret &lt; 0) {
         goto fail_free_buffer;
     }
@@ -1275,8 +1366,14 @@ static int fuse_write_buf_response(int fd, uint32_t req_id,
  * Note that yielding in any request-processing function can overwrite the
  * contents of q-&gt;request_buf.  Anything that takes a buffer needs to take
  * care that the content is copied before yielding.
+ *
+ * @spillover_buf can contain the tail of a write request too large to fit into
+ * q-&gt;request_buf.  This function takes ownership of it (i.e. will free it),
+ * which assumes that its contents will not be overwritten by concurrent
+ * requests (as opposed to q-&gt;request_buf).
  */
-static void coroutine_fn fuse_co_process_request(FuseQueue *q)
+static void coroutine_fn
+fuse_co_process_request(FuseQueue *q, void *spillover_buf)
 {
     FuseExport *exp = q-&gt;exp;
     uint32_t opcode;
@@ -1372,7 +1469,7 @@ static void coroutine_fn fuse_co_process_request(FuseQueue *q)
          * yielding.
          */
         ret = fuse_co_write(exp, FUSE_OUT_OP_STRUCT(write, out_buf),
-                            in-&gt;offset, in-&gt;size, in + 1);
+                            in-&gt;offset, in-&gt;size, in + 1, spillover_buf);
         break;
     }
 
@@ -1414,6 +1511,8 @@ static void coroutine_fn fuse_co_process_request(FuseQueue *q)
                             ret &lt; 0 ? ret : 0,
                             ret &lt; 0 ? 0 : ret);
     }
+
+    qemu_vfree(spillover_buf);
 }
 
 const BlockExportDriver blk_exp_fuse = {
</pre>
    </blockquote>
  </body>
  <lt-container></lt-container>
</html>

--------------uuyqaVcvh90y8MxyITfQ0TVr--

