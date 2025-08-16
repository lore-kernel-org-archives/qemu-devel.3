Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B14ACA0EE4
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Aug 2025 23:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1unQ64-000083-RJ; Sat, 16 Aug 2025 19:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1unQ63-00007l-8l; Sat, 16 Aug 2025 19:13:59 -0400
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1unQ61-0000Uc-4F; Sat, 16 Aug 2025 19:13:59 -0400
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-70a88ddb1a2so30782566d6.0; 
 Sat, 16 Aug 2025 16:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755386035; x=1755990835; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O/RQkVhbDgPfrt3wbXn04DbyqDxFFtvOIr83uWX4AnE=;
 b=nhuAXVXXVw2w3a6bkFkkig0mUGVdG1NIGuG9SlJzJQPQ5VDtgZsl4Uas43YuoY0QIz
 essYTA57dqTInmghoVulaolaOdoisSGFoqivyBeuXhH6Ux6E+uL2tJmfhYPYb4yy/fIF
 Wcdyl/qOoDnY211WThtGM3UPQG4HAVxcsniq/LPHdgPKDFe+Cl1zdJMdRrog4PsB+4qe
 CSCQkLa+P6RWtggdiZgA/N3jZkIkvsXyvL9jmO93G90dRLakAjd3wbd0jsT7Bg1yp7xD
 cjt8J052SE6/BZvEdGXmiBORr8cBug1nJD1WybtRCS1JAl0O+wa0y9LFXvYsxI7uHrEP
 2DxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755386035; x=1755990835;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O/RQkVhbDgPfrt3wbXn04DbyqDxFFtvOIr83uWX4AnE=;
 b=AgKT6KBGr4vsy7C0tDiAvEkJTLLXgGgO8UMeJ6WJj6zkE9MO5bkv+90JedvuZiSyXp
 +7rats9xZoHWDtoefFS7JIhPP2PII1rbxcAuK7xD8ri6SSvv7p0bv0LPv4VMpKuzYl8o
 cJw4g+HdQFBjZckFdX6ywVS/MRu5/hMF/LBjlu5W5cl+mBau6yYorQj6A7dm9HQwihaO
 trtLt/1X+pVLg8t5wRGH9TkxIt3RKe4ci1I7z4DiiF/4B7S8VYxf1eOSO5SSkYVKslcJ
 qyBAqnObO8tvPkL8VbGO/XvJvgQzZpbJkrRmMin1HqCvXcRDoQUtmWJ5C77fF1bloXXQ
 AMxg==
X-Gm-Message-State: AOJu0Yy6iW6/OBQGtA54AZIBSkK1RG1tkHK5+3AUOlC7dWdtARoHJyqL
 aeBCktHLLHzpUHgBb1DLLPkABrW+sNzCRR//LLsMMB/Z1QdaZXVyPwfe3ykxi37k
X-Gm-Gg: ASbGncvfMzhcapXvsOjQBxjy+WLy9qI22Cz0pC3Nr1ttH49h5wiAE/4u6uhhu1xFN6O
 SG8bKR/aXJH1hKw/79emAiIDBmhQWilCAXB/RQlE3H4uor7byfrQqe5qB9AETYYDWm6IBm+IibC
 IBhm0uiN4ESX0h4Fo6gZfi39qKo+Y5p2pIaPEGnih67Ug9fg+dByCHk5uHk466ZCbBrLkvcclzS
 AvWgs8Yo2xL4k54HRVGMcbpe/COARPfHU9V6cic0Qv8D2ZPIdZULfIBlsUHTOCwTM0sz2hT4IiZ
 Lon/VaRqT0RSHoBxPqkDjMo3dm+dGMT8Vo3cJFm2ZsEI5hIyL0B2FLBCaiRkrwi9aGnXV5ciQmO
 jg4d15gcoZmxCxTdOj/xxAlKqL3xyC/GtG6N137nR5QWoyB/8pe9hqHlUmxIAqjPkQZ+iL1yWq3
 LIStB2
X-Google-Smtp-Source: AGHT+IHch+JUo/D0atnvYZtV6UiDcZsOzi7mx+HRePzSmRdSs3mcQ0P3I/xRINXn7q+H56xpZhNifg==
X-Received: by 2002:a05:6214:1c0e:b0:70b:adc7:b226 with SMTP id
 6a1803df08f44-70badc7c43dmr83239996d6.19.1755386034604; 
 Sat, 16 Aug 2025 16:13:54 -0700 (PDT)
Received: from [10.36.3.90] (wn-campus-nat-129-97-124-90.dynamic.uwaterloo.ca.
 [129.97.124.90]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70bae08c0f9sm24553826d6.11.2025.08.16.16.13.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 Aug 2025 16:13:54 -0700 (PDT)
Message-ID: <beb43845-a761-4031-a7b7-aaca56abb6de@gmail.com>
Date: Sat, 16 Aug 2025 19:13:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] fuse: add FUSE-over-io_uring enable opt and init
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, bernd@bsbernd.com,
 fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com, stefanha@redhat.com
References: <20250815034619.51980-1-hizhisong@gmail.com>
 <20250815034619.51980-2-hizhisong@gmail.com>
Content-Language: en-US
From: Brian Song <hibriansong@gmail.com>
In-Reply-To: <20250815034619.51980-2-hizhisong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f34;
 envelope-from=hibriansong@gmail.com; helo=mail-qv1-xf34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



On 8/14/25 11:46 PM, Brian Song wrote:
> From: Brian Song <hibriansong@gmail.com>
> 
> This patch adds a new export option for storage-export-daemon to enable
> or disable FUSE-over-io_uring via the switch io-uring=on|off (disable
> by default). It also implements the protocol handshake with the Linux
> kernel during the FUSE-over-io_uring initialization phase.
> 
> See: https://docs.kernel.org/filesystems/fuse-io-uring.html
> 
> The kernel documentation describes in detail how FUSE-over-io_uring
> works. This patch implements the Initial SQE stage shown in thediagram:
> it initializes one queue per IOThread, each currently supporting a
> single submission queue entry (SQE). When the FUSE driver sends the
> first FUSE request (FUSE_INIT), storage-export-daemon calls
> fuse_uring_start() to complete initialization, ultimately submitting
> the SQE with the FUSE_IO_URING_CMD_REGISTER command to confirm
> successful initialization with the kernel.
> 
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Brian Song <hibriansong@gmail.com>
> ---
>   block/export/fuse.c                  | 161 ++++++++++++++++++++++++---
>   docs/tools/qemu-storage-daemon.rst   |  11 +-
>   qapi/block-export.json               |   5 +-
>   storage-daemon/qemu-storage-daemon.c |   1 +
>   util/fdmon-io_uring.c                |   5 +-
>   5 files changed, 159 insertions(+), 24 deletions(-)
> 
> diff --git a/block/export/fuse.c b/block/export/fuse.c
> index c0ad4696ce..59fa79f486 100644
> --- a/block/export/fuse.c
> +++ b/block/export/fuse.c
> @@ -48,6 +48,11 @@
>   #include <linux/fs.h>
>   #endif
> 
> +#define FUSE_DEFAULT_MAX_PAGES_PER_REQ 32
> +
> +/* room needed in buffer to accommodate header */
> +#define FUSE_BUFFER_HEADER_SIZE 0x1000
> +
>   /* Prevent overly long bounce buffer allocations */
>   #define FUSE_MAX_READ_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 1 * 1024 * 1024))
>   /*
> @@ -63,12 +68,31 @@
>       (FUSE_MAX_WRITE_BYTES - FUSE_IN_PLACE_WRITE_BYTES)
> 
>   typedef struct FuseExport FuseExport;
> +typedef struct FuseQueue FuseQueue;
> +
> +typedef struct FuseRingEnt {
> +    /* back pointer */
> +    FuseQueue *q;
> +
> +    /* commit id of a fuse request */
> +    uint64_t req_commit_id;
> +
> +    /* fuse request header and payload */
> +    struct fuse_uring_req_header req_header;
> +    void *op_payload;
> +    size_t req_payload_sz;
> +
> +    /* The vector passed to the kernel */
> +    struct iovec iov[2];
> +
> +    CqeHandler fuse_cqe_handler;
> +} FuseRingEnt;
> 
>   /*
>    * One FUSE "queue", representing one FUSE FD from which requests are fetched
>    * and processed.  Each queue is tied to an AioContext.
>    */
> -typedef struct FuseQueue {
> +struct FuseQueue {
>       FuseExport *exp;
> 
>       AioContext *ctx;
> @@ -109,7 +133,12 @@ typedef struct FuseQueue {
>        * Free this buffer with qemu_vfree().
>        */
>       void *spillover_buf;
> -} FuseQueue;
> +
> +#ifdef CONFIG_LINUX_IO_URING
> +    int qid;
> +    FuseRingEnt ent;
> +#endif
> +};
> 
>   /*
>    * Verify that FuseQueue.request_buf plus the spill-over buffer together
> @@ -148,6 +177,7 @@ struct FuseExport {
>       bool growable;
>       /* Whether allow_other was used as a mount option or not */
>       bool allow_other;
> +    bool is_uring;
> 
>       mode_t st_mode;
>       uid_t st_uid;
> @@ -257,6 +287,93 @@ static const BlockDevOps fuse_export_blk_dev_ops = {
>       .drained_poll  = fuse_export_drained_poll,
>   };
> 
> +#ifdef CONFIG_LINUX_IO_URING
> +
> +static void fuse_uring_sqe_set_req_data(struct fuse_uring_cmd_req *req,
> +                    const unsigned int qid,
> +                    const unsigned int commit_id)
> +{
> +    req->qid = qid;
> +    req->commit_id = commit_id;
> +    req->flags = 0;
> +}
> +
> +static void fuse_uring_sqe_prepare(struct io_uring_sqe *sqe, FuseQueue *q,
> +               __u32 cmd_op)
> +{
> +    sqe->opcode = IORING_OP_URING_CMD;
> +
> +    sqe->fd = q->fuse_fd;
> +    sqe->rw_flags = 0;
> +    sqe->ioprio = 0;
> +    sqe->off = 0;
> +
> +    sqe->cmd_op = cmd_op;
> +    sqe->__pad1 = 0;
> +}
> +
> +static void fuse_uring_prep_sqe_register(struct io_uring_sqe *sqe, void *opaque)
> +{
> +    FuseQueue *q = opaque;
> +    struct fuse_uring_cmd_req *req = (void *)&sqe->cmd[0];
> +
> +    fuse_uring_sqe_prepare(sqe, q, FUSE_IO_URING_CMD_REGISTER);
> +
> +    sqe->addr = (uint64_t)(q->ent.iov);
> +    sqe->len = 2;
> +
> +    fuse_uring_sqe_set_req_data(req, q->qid, 0);
> +}
> +
> +static void fuse_uring_submit_register(void *opaque)
> +{
> +    FuseQueue *q = opaque;
> +    FuseExport *exp = q->exp;
> +
> +
> +    aio_add_sqe(fuse_uring_prep_sqe_register, q, &(q->ent.fuse_cqe_handler));

I think there might be a tricky issue with the io_uring integration in 
QEMU. Currently, when the number of IOThreads goes above ~6 or 7, 
there’s a pretty high chance of a hang. I added some debug logging in 
the kernel’s fuse_uring_cmd() registration part, and noticed that the 
number of register calls is less than the total number of entries in the 
queue. In theory, we should be registering each entry for each queue.

On the userspace side, everything seems normal, the number of 
aio_add_sqe() calls matches the number of IOThreads. But here’s the 
weird part: if I add a printf inside the while loop in 
fdmon-io_uring.c::fdmon_io_uring_wait(), suddenly everything works fine, 
and the kernel receives registration requests for all entries as expected.

     do {
         ret = io_uring_submit_and_wait(&ctx->fdmon_io_uring, wait_nr);
         fprintf(stderr, "io_uring_submit_and_wait ret: %d\n", ret);
     } while (ret == -EINTR);

My guess is that printf is just slowing down the loop, or maybe there’s 
some implicit memory barrier happening. Obviously, the right fix isn’t 
to sprinkle fprintfs around. I suspect there might be a subtle 
synchronization/race issue here.

Brian

