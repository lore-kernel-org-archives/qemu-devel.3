Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240A8CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 18:02:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utrnG-0006IE-O2; Wed, 03 Sep 2025 14:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1utrnD-0006H8-Ak; Wed, 03 Sep 2025 14:01:11 -0400
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1utrnA-00074C-90; Wed, 03 Sep 2025 14:01:11 -0400
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7f722cb35fdso22269885a.3; 
 Wed, 03 Sep 2025 11:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756922465; x=1757527265; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/ztvVBpXnzKUtL1bvaBfnThISSC5cs9Y1LFvt07/Tmk=;
 b=dpKChzG5owi9cd7A+/L3NOmYIgiC96bjxeQX37SXll6cvT3jfoHmOuKy0Ytzy2DQzv
 GPhQtgXLC26ljcW4kJCaOmZGMQZOst8wdYvpzySMkmd85YjsiCGxQXPhToMAA+sOkECW
 NzFhLMxNWutAw+mEa3IOaFKdUKer3n7Qiag2wRmi6/dF/pALcAuR7HQNlqViGpx7yp3Y
 kk/WopD/z/jtCha8Kz6N4WMYeNhrvwSRNiPXlfL6CtlSO8hClIn0YFTsvQXRYyNe4fuZ
 Ni5F5L/i2lLKniTj3mt8i6ba2XwB9rtUXyvi/61XckBiuMvoKKxqf2PcBcw2SaHwYJNE
 eIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756922465; x=1757527265;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/ztvVBpXnzKUtL1bvaBfnThISSC5cs9Y1LFvt07/Tmk=;
 b=s8NXZOtxadyf0s8CLgxmO2clnWEf0+iCxechr6En9nQPdO6eeSX9CL48QK1BgDSXKT
 vhlIYK+fT3z4cKi5ncQxULnYX1FvipYhLh///24umQEGtxaf7y4eyhGHeex1/D0Btrr9
 vbviAqc0pFtl0Ndo+Fz5n4dyjdu7Cyt9AKUaxwLZ+v7lf56yn8Obx/Y4DMVrv7Um1A7t
 DFsUYpNz1zF5f/PTHohHtjMM2+yojy6TCC9IHgAJAq5DNM0NGew2datFtHO9fFpKYZq9
 xzqzlMVPI+GZnG72PBRcOY0Oa1EdwOS5vBsoMyceKeYZjVmFfGVPlDk5g1QSrU8DC24L
 svlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqPmQg2RFtejGIAS4XkGQavsxlPSOJJ2zwDzc9FRC7hA0FNMnaetLDLVlYU2ylX+XSa2AKrOKPVrZp@nongnu.org
X-Gm-Message-State: AOJu0YyTm0UyQ99TJ86x5NJ+LtPOx/W7o+TBpRB8Wzg7Dd7mAU0hghbj
 I//6vQvFzzOIefLWe23j+A7iU0wIC9I4UsV2klWKVN1v7xVKVQXjauHN
X-Gm-Gg: ASbGncvdae4hm/PgNd9HmjGV6M7EvklnYCwtRaOpw9LMTxgskshL6vYuxKl1JHinJRC
 h0mueHnaz/UNxeM80KiHzo6Bi1Sax9uRBrOWRdk7AiJV4DubGPaf22KYAgOM//LgqQTzfxNpIyu
 /FVIh52MrP6j185kHxdW87cJl74ZybHeLnMnETVJce2wtCu8NYMseseRE9DyixPACBvnnj+kKc0
 jScGRbZInit1543LNosckzSJ68NkRrdRjWdALosC/X1CJQC7tROz0zhgeTtvAtlVKk4VZ2Rqsf8
 jDbcR13AR/EKiVBdVuzmLNjLTBqFPo6FM4bF0qry2nOe4QjDAZqfIphePUMpkSaApEgm7TrmFAq
 n8hYPINRSQISirGPslYtmbgo/YcDeyEA=
X-Google-Smtp-Source: AGHT+IFFOXO0Gw67wfT3DVFRwx1HqRSrBPW7xCEpUFM9BKwUUkWHQSI7TblNL8GAiSRBXxE+tVHrGQ==
X-Received: by 2002:a05:620a:440b:b0:801:8812:c0ca with SMTP id
 af79cd13be357-8018812c51emr1486653685a.29.1756922459233; 
 Wed, 03 Sep 2025 11:00:59 -0700 (PDT)
Received: from [10.5.0.2] ([86.48.15.239]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-80aabf586c5sm142880385a.60.2025.09.03.11.00.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 11:00:57 -0700 (PDT)
Message-ID: <da5f4b75-2543-4f33-97d9-360c409c6079@gmail.com>
Date: Wed, 3 Sep 2025 14:00:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] export/fuse: add opt to enable FUSE-over-io_uring
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 bernd@bsbernd.com, fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com
References: <20250830025025.3610-1-hibriansong@gmail.com>
 <20250830025025.3610-2-hibriansong@gmail.com>
 <20250903105325.GB106431@fedora>
Content-Language: en-US
From: Brian Song <hibriansong@gmail.com>
In-Reply-To: <20250903105325.GB106431@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=hibriansong@gmail.com; helo=mail-qk1-x72a.google.com
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



On 9/3/25 6:53 AM, Stefan Hajnoczi wrote:
> On Fri, Aug 29, 2025 at 10:50:22PM -0400, Brian Song wrote:
>> This patch adds a new export option for storage-export-daemon to enable
>> FUSE-over-io_uring via the switch io-uring=on|off (disableby default).
>> It also implements the protocol handshake with the Linux kernel
>> during the FUSE-over-io_uring initialization phase.
>>
>> See: https://docs.kernel.org/filesystems/fuse-io-uring.html
>>
>> The kernel documentation describes in detail how FUSE-over-io_uring
>> works. This patch implements the Initial SQE stage shown in thediagram:
>> it initializes one queue per IOThread, each currently supporting a
>> single submission queue entry (SQE). When the FUSE driver sends the
>> first FUSE request (FUSE_INIT), storage-export-daemon calls
>> fuse_uring_start() to complete initialization, ultimately submitting
>> the SQE with the FUSE_IO_URING_CMD_REGISTER command to confirm
>> successful initialization with the kernel.
>>
>> We also added support for multiple IOThreads. The current Linux kernel
>> requires registering $(nproc) queues when setting up FUSE-over-io_uring
>> To let users customize the number of FUSE Queues (i.e., IOThreads),
>> we first create nproc Ring Queues as required by the kernel, then
>> distribute them in a round-robin manner to the FUSE Queues for
>> registration. In addition, to support multiple in-flight requests,
>> we configure each Ring Queue with FUSE_DEFAULT_RING_QUEUE_DEPTH
>> entries/requests.
> 
> The previous paragraph says "each currently supporting a single
> submission queue entry (SQE)" whereas this paragraph says "we configure
> each Ring Queue with FUSE_DEFAULT_RING_QUEUE_DEPTH entries/requests".
> Maybe this paragraph was squashed into the commit description in a later
> step and the previous paragraph can be updated to reflect that multiple
> SQEs are submitted?
> 
>>
>> Suggested-by: Kevin Wolf <kwolf@redhat.com>
>> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Brian Song <hibriansong@gmail.com>
>> ---
>>   block/export/fuse.c                  | 310 +++++++++++++++++++++++++--
>>   docs/tools/qemu-storage-daemon.rst   |  11 +-
>>   qapi/block-export.json               |   5 +-
>>   storage-daemon/qemu-storage-daemon.c |   1 +
>>   util/fdmon-io_uring.c                |   5 +-
>>   5 files changed, 309 insertions(+), 23 deletions(-)
>>
>> diff --git a/block/export/fuse.c b/block/export/fuse.c
>> index c0ad4696ce..19bf9e5f74 100644
>> --- a/block/export/fuse.c
>> +++ b/block/export/fuse.c
>> @@ -48,6 +48,9 @@
>>   #include <linux/fs.h>
>>   #endif
>>   
>> +/* room needed in buffer to accommodate header */
>> +#define FUSE_BUFFER_HEADER_SIZE 0x1000
> 
> Is it possible to write this in a way that shows how the constant is
> calculated? That way the constant would automatically adjust on systems
> where the underlying assumptions have changed (e.g. page size, header
> struct size). This approach is also self-documenting so it's possible to
> understand where the magic number comes from.
> 
> For example:
> 
>    #define FUSE_BUFFER_HEADER_SIZE DIV_ROUND_UP(sizeof(struct fuse_uring_req_header), qemu_real_host_page_size())
> 
> (I'm guessing what the formula you used is, so this example may be
> incorrect...)
> 

In libfuse, the way to calculate the bufsize (for req_payload) is the 
same as in this patch. For different requests, the request header sizes 
are not the same, but they should never exceed a certain value. So is 
that why libfuse has this kind of magic number?

>> +
>>   /* Prevent overly long bounce buffer allocations */
>>   #define FUSE_MAX_READ_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 1 * 1024 * 1024))
>>   /*
>> @@ -63,12 +66,59 @@
>>       (FUSE_MAX_WRITE_BYTES - FUSE_IN_PLACE_WRITE_BYTES)
>>   
>>   typedef struct FuseExport FuseExport;
>> +typedef struct FuseQueue FuseQueue;
>> +
>> +#ifdef CONFIG_LINUX_IO_URING
>> +#define FUSE_DEFAULT_RING_QUEUE_DEPTH 64
>> +#define FUSE_DEFAULT_MAX_PAGES_PER_REQ 32
>> +
>> +typedef struct FuseRingQueue FuseRingQueue;
>> +typedef struct FuseRingEnt {
>> +    /* back pointer */
>> +    FuseRingQueue *rq;
>> +
>> +    /* commit id of a fuse request */
>> +    uint64_t req_commit_id;
> 
> This field is not used in this commit. Please introduce it in the commit
> that uses it so it's easier to review and understand the purpose of this
> field.
> 
>> +
>> +    /* fuse request header and payload */
>> +    struct fuse_uring_req_header req_header;
>> +    void *op_payload;
>> +    size_t req_payload_sz;
> 
> op_payload and req_payload_sz refer to the same buffer, and they are
> submitted alongside req_header. It would be nice to name the fields
> consistently:
> 
>    struct fuse_uring_req_header req_header;
>    void *req_payload;
>    size_t req_payload_sz;
> 
> req_payload and req_payload_sz could be eliminated since they are also
> stored in iov[1].iov_base and .iov_len. If you feel that would be harder
> to understand, then it's okay to keep the duplicate fields.
> 

Makes sense. I followed the design in libfuse. Probably best to just 
leave them in the struct for readability

>> +
>> +    /* The vector passed to the kernel */
>> +    struct iovec iov[2];
>> +
>> +    CqeHandler fuse_cqe_handler;
>> +} FuseRingEnt;
>> +
>> +struct FuseRingQueue {
> 
> A comment would be nice here to explain that the kernel requires one
> FuseRingQueue per host CPU and this concept is independent of /dev/fuse
> (FuseQueue).
> 
>> +    int rqid;
>> +
>> +    /* back pointer */
>> +    FuseQueue *q;
>> +    FuseRingEnt *ent;
>> +
>> +    /* List entry for ring_queues */
>> +    QLIST_ENTRY(FuseRingQueue) next;
>> +};
>> +
>> +/*
>> + * Round-robin distribution of ring queues across FUSE queues.
>> + * This structure manages the mapping between kernel ring queues and user
>> + * FUSE queues.
>> + */
>> +typedef struct FuseRingQueueManager {
>> +    FuseRingQueue *ring_queues;
>> +    int num_ring_queues;
>> +    int num_fuse_queues;
>> +} FuseRingQueueManager;
>> +#endif
> 
> It's easy to forget which #ifdef we're inside after a few lines, so it
> helps to indicate that in a comment:
> 
> #endif /* CONFIG_LINUX_IO_URING */
> 
>>   
>>   /*
>>    * One FUSE "queue", representing one FUSE FD from which requests are fetched
>>    * and processed.  Each queue is tied to an AioContext.
>>    */
>> -typedef struct FuseQueue {
>> +struct FuseQueue {
>>       FuseExport *exp;
>>   
>>       AioContext *ctx;
>> @@ -109,15 +159,11 @@ typedef struct FuseQueue {
>>        * Free this buffer with qemu_vfree().
>>        */
>>       void *spillover_buf;
>> -} FuseQueue;
>>   
>> -/*
>> - * Verify that FuseQueue.request_buf plus the spill-over buffer together
>> - * are big enough to be accepted by the FUSE kernel driver.
>> - */
>> -QEMU_BUILD_BUG_ON(sizeof(((FuseQueue *)0)->request_buf) +
>> -                  FUSE_SPILLOVER_BUF_SIZE <
>> -                  FUSE_MIN_READ_BUFFER);
> 
> Why was this removed, it's probably still necessary in the non-io_uring
> case (which is compiled in even when CONFIG_LINUX_IO_URING is defined)?
> 

You can check Hanna’s patch. In fuse_co_process_request, Hanna 
introduced this check when using FUSE_OUT_OP_STRUCT to cast void *buf 
into the corresponding in/out header for the given operation.

But in the v2 patch, we merged the legacy process_request and the uring 
version into one. This caused the legacy path to pass the array into the 
common function as a pointer. Now, when we do the buf header size check, 
what gets checked is just the pointer size.

#define FUSE_OUT_OP_STRUCT(op_name, out_buf) \
     ({ \
         struct fuse_out_header *__out_hdr = \
             (struct fuse_out_header *)(out_buf); \
         struct fuse_##op_name##_out *__out = \
             (struct fuse_##op_name##_out *)(__out_hdr + 1); \
         \
         QEMU_BUILD_BUG_ON(sizeof(*__out_hdr) + sizeof(*__out) > \
                           sizeof(out_buf)); \
         \
         __out; \
     })


>> +#ifdef CONFIG_LINUX_IO_URING
>> +    QLIST_HEAD(, FuseRingQueue) ring_queue_list;
>> +#endif
>> +};
>>   
>>   struct FuseExport {
>>       BlockExport common;
>> @@ -133,7 +179,7 @@ struct FuseExport {
>>        */
>>       bool halted;
>>   
>> -    int num_queues;
>> +    size_t num_queues;
>>       FuseQueue *queues;
>>       /*
>>        * True if this export should follow the generic export's AioContext.
>> @@ -149,6 +195,12 @@ struct FuseExport {
>>       /* Whether allow_other was used as a mount option or not */
>>       bool allow_other;
>>   
>> +#ifdef CONFIG_LINUX_IO_URING
>> +    bool is_uring;
>> +    size_t ring_queue_depth;
>> +    FuseRingQueueManager *ring_queue_manager;
>> +#endif
>> +
>>       mode_t st_mode;
>>       uid_t st_uid;
>>       gid_t st_gid;
>> @@ -205,7 +257,7 @@ static void fuse_attach_handlers(FuseExport *exp)
>>           return;
>>       }
>>   
>> -    for (int i = 0; i < exp->num_queues; i++) {
>> +    for (size_t i = 0; i < exp->num_queues; i++) {
>>           aio_set_fd_handler(exp->queues[i].ctx, exp->queues[i].fuse_fd,
>>                              read_from_fuse_fd, NULL, NULL, NULL,
>>                              &exp->queues[i]);
>> @@ -257,6 +309,189 @@ static const BlockDevOps fuse_export_blk_dev_ops = {
>>       .drained_poll  = fuse_export_drained_poll,
>>   };
>>   
>> +#ifdef CONFIG_LINUX_IO_URING
>> +static void fuse_uring_sqe_set_req_data(struct fuse_uring_cmd_req *req,
>> +                    const unsigned int rqid,
>> +                    const unsigned int commit_id)
>> +{
>> +    req->qid = rqid;
>> +    req->commit_id = commit_id;
>> +    req->flags = 0;
>> +}
>> +
>> +static void fuse_uring_sqe_prepare(struct io_uring_sqe *sqe, FuseQueue *q,
>> +               __u32 cmd_op)
>> +{
>> +    sqe->opcode = IORING_OP_URING_CMD;
>> +
>> +    sqe->fd = q->fuse_fd;
>> +    sqe->rw_flags = 0;
>> +    sqe->ioprio = 0;
>> +    sqe->off = 0;
>> +
>> +    sqe->cmd_op = cmd_op;
>> +    sqe->__pad1 = 0;
>> +}
>> +
>> +static void fuse_uring_prep_sqe_register(struct io_uring_sqe *sqe, void *opaque)
>> +{
>> +    FuseRingEnt *ent = opaque;
>> +    struct fuse_uring_cmd_req *req = (void *)&sqe->cmd[0];
>> +
>> +    fuse_uring_sqe_prepare(sqe, ent->rq->q, FUSE_IO_URING_CMD_REGISTER);
>> +
>> +    sqe->addr = (uint64_t)(ent->iov);
>> +    sqe->len = 2;
>> +
>> +    fuse_uring_sqe_set_req_data(req, ent->rq->rqid, 0);
>> +}
>> +
>> +static void fuse_uring_submit_register(void *opaque)
>> +{
>> +    FuseRingEnt *ent = opaque;
>> +    FuseExport *exp = ent->rq->q->exp;
> 
> This variable is unused in this commit? Does this commit compile for
> you? Usually the compiler warns about unused variables.
> 

The first version was a large single patch. I split it with git, and 
this variable is now used in a different patch

>> +
>> +
>> +    aio_add_sqe(fuse_uring_prep_sqe_register, ent, &(ent->fuse_cqe_handler));
>> +}
>> +
>> +/**
>> + * Distribute ring queues across FUSE queues using round-robin algorithm.
>> + * This ensures even distribution of kernel ring queues across user-specified
>> + * FUSE queues.
>> + */
>> +static
>> +FuseRingQueueManager *fuse_ring_queue_manager_create(int num_fuse_queues,
>> +                                                    size_t ring_queue_depth,
>> +                                                    size_t bufsize)
>> +{
>> +    int num_ring_queues = get_nprocs();
> 
> The kernel code uses num_possible_cpus() in
> fs/fuse/dev_uring.c:fuse_uring_create() so I think this should be
> get_nprocs_conf() instead of get_nprocs().
> 
>> +    FuseRingQueueManager *manager = g_new(FuseRingQueueManager, 1);
>> +
>> +    if (!manager) {
> 
> g_new() never returns NULL, so you can remove this if statement. If
> memory cannot be allocated then the process will abort.
> 
>> +        return NULL;
>> +    }
>> +
>> +    manager->ring_queues = g_new(FuseRingQueue, num_ring_queues);
>> +    manager->num_ring_queues = num_ring_queues;
>> +    manager->num_fuse_queues = num_fuse_queues;
>> +
>> +    if (!manager->ring_queues) {
> 
> Same here.
> 
>> +        g_free(manager);
>> +        return NULL;
>> +    }
>> +
>> +    for (int i = 0; i < num_ring_queues; i++) {
>> +        FuseRingQueue *rq = &manager->ring_queues[i];
>> +        rq->rqid = i;
>> +        rq->ent = g_new(FuseRingEnt, ring_queue_depth);
>> +
>> +        if (!rq->ent) {
> 
> Same here.
> 
>> +            for (int j = 0; j < i; j++) {
>> +                g_free(manager->ring_queues[j].ent);
>> +            }
>> +            g_free(manager->ring_queues);
>> +            g_free(manager);
>> +            return NULL;
>> +        }
>> +
>> +        for (size_t j = 0; j < ring_queue_depth; j++) {
>> +            FuseRingEnt *ent = &rq->ent[j];
>> +            ent->rq = rq;
>> +            ent->req_payload_sz = bufsize - FUSE_BUFFER_HEADER_SIZE;
>> +            ent->op_payload = g_malloc0(ent->req_payload_sz);
>> +
>> +            if (!ent->op_payload) {
> 
> Same here.
> 
>> +                for (size_t k = 0; k < j; k++) {
>> +                    g_free(rq->ent[k].op_payload);
>> +                }
>> +                g_free(rq->ent);
>> +                for (int k = 0; k < i; k++) {
>> +                    g_free(manager->ring_queues[k].ent);
>> +                }
>> +                g_free(manager->ring_queues);
>> +                g_free(manager);
> 
> Where are these structures freed in the normal lifecycle of a FUSE
> export? I only see this error handling code, but nothing is freed when
> the export is shut down.


Same here. The first version was a large single patch. I split it with 
git, and we do cleanup in a different patch

> 
>> +                return NULL;
>> +            }
>> +
>> +            ent->iov[0] = (struct iovec) {
>> +                &(ent->req_header),
>> +                sizeof(struct fuse_uring_req_header)
>> +            };
>> +            ent->iov[1] = (struct iovec) {
>> +                ent->op_payload,
>> +                ent->req_payload_sz
>> +            };
>> +
>> +            ent->fuse_cqe_handler.cb = fuse_uring_cqe_handler;
>> +        }
>> +    }
>> +
>> +    return manager;
>> +}
>> +
>> +static
>> +void fuse_distribute_ring_queues(FuseExport *exp, FuseRingQueueManager *manager)
>> +{
>> +    int queue_index = 0;
>> +
>> +    for (int i = 0; i < manager->num_ring_queues; i++) {
>> +        FuseRingQueue *rq = &manager->ring_queues[i];
>> +
>> +        rq->q = &exp->queues[queue_index];
>> +        QLIST_INSERT_HEAD(&(rq->q->ring_queue_list), rq, next);
>> +
>> +        queue_index = (queue_index + 1) % manager->num_fuse_queues;
>> +    }
>> +}
>> +
>> +static
>> +void fuse_schedule_ring_queue_registrations(FuseExport *exp,
>> +                                            FuseRingQueueManager *manager)
>> +{
>> +    for (int i = 0; i < manager->num_fuse_queues; i++) {
>> +        FuseQueue *q = &exp->queues[i];
>> +        FuseRingQueue *rq;
>> +
>> +        QLIST_FOREACH(rq, &q->ring_queue_list, next) {
>> +            for (int j = 0; j < exp->ring_queue_depth; j++) {
>> +                aio_bh_schedule_oneshot(q->ctx, fuse_uring_submit_register,
>> +                                        &(rq->ent[j]));
>> +            }
>> +        }
>> +    }
>> +}
>> +
>> +static void fuse_uring_start(FuseExport *exp, struct fuse_init_out *out)
>> +{
>> +    /*
>> +     * Since we didn't enable the FUSE_MAX_PAGES feature, the value of
>> +     * fc->max_pages should be FUSE_DEFAULT_MAX_PAGES_PER_REQ, which is set by
>> +     * the kernel by default. Also, max_write should not exceed
>> +     * FUSE_DEFAULT_MAX_PAGES_PER_REQ * PAGE_SIZE.
>> +     */
>> +    size_t bufsize = out->max_write + FUSE_BUFFER_HEADER_SIZE;
>> +
>> +    if (!(out->flags & FUSE_MAX_PAGES)) {
>> +        bufsize = FUSE_DEFAULT_MAX_PAGES_PER_REQ * qemu_real_host_page_size()
>> +                         + FUSE_BUFFER_HEADER_SIZE;
>> +    }
>> +
>> +    exp->ring_queue_manager = fuse_ring_queue_manager_create(
>> +        exp->num_queues, exp->ring_queue_depth, bufsize);
>> +
>> +    if (!exp->ring_queue_manager) {
>> +        error_report("Failed to create ring queue manager");
>> +        return;
>> +    }
>> +
>> +    /* Distribute ring queues across FUSE queues using round-robin */
>> +    fuse_distribute_ring_queues(exp, exp->ring_queue_manager);
>> +
>> +    fuse_schedule_ring_queue_registrations(exp, exp->ring_queue_manager);
>> +}
>> +#endif
>> +
>>   static int fuse_export_create(BlockExport *blk_exp,
>>                                 BlockExportOptions *blk_exp_args,
>>                                 AioContext *const *multithread,
>> @@ -270,6 +505,11 @@ static int fuse_export_create(BlockExport *blk_exp,
>>   
>>       assert(blk_exp_args->type == BLOCK_EXPORT_TYPE_FUSE);
>>   
>> +#ifdef CONFIG_LINUX_IO_URING
>> +    exp->is_uring = args->io_uring;
>> +    exp->ring_queue_depth = FUSE_DEFAULT_RING_QUEUE_DEPTH;
>> +#endif
>> +
>>       if (multithread) {
>>           /* Guaranteed by common export code */
>>           assert(mt_count >= 1);
>> @@ -283,6 +523,10 @@ static int fuse_export_create(BlockExport *blk_exp,
>>                   .exp = exp,
>>                   .ctx = multithread[i],
>>                   .fuse_fd = -1,
>> +#ifdef CONFIG_LINUX_IO_URING
>> +                .ring_queue_list =
>> +                    QLIST_HEAD_INITIALIZER(exp->queues[i].ring_queue_list),
>> +#endif
>>               };
>>           }
>>       } else {
>> @@ -296,6 +540,10 @@ static int fuse_export_create(BlockExport *blk_exp,
>>               .exp = exp,
>>               .ctx = exp->common.ctx,
>>               .fuse_fd = -1,
>> +#ifdef CONFIG_LINUX_IO_URING
>> +            .ring_queue_list =
>> +                QLIST_HEAD_INITIALIZER(exp->queues[0].ring_queue_list),
>> +#endif
>>           };
>>       }
>>   
>> @@ -685,17 +933,39 @@ static bool is_regular_file(const char *path, Error **errp)
>>    */
>>   static ssize_t coroutine_fn
>>   fuse_co_init(FuseExport *exp, struct fuse_init_out *out,
>> -             uint32_t max_readahead, uint32_t flags)
>> +             uint32_t max_readahead, const struct fuse_init_in *in)
>>   {
>> -    const uint32_t supported_flags = FUSE_ASYNC_READ | FUSE_ASYNC_DIO;
>> +    uint64_t supported_flags = FUSE_ASYNC_READ | FUSE_ASYNC_DIO
>> +                                     | FUSE_INIT_EXT;
>> +    uint64_t outargflags = 0;
>> +    uint64_t inargflags = in->flags;
>> +
>> +    ssize_t ret = 0;
>> +
>> +    if (inargflags & FUSE_INIT_EXT) {
>> +        inargflags = inargflags | (uint64_t) in->flags2 << 32;
>> +    }
>> +
>> +#ifdef CONFIG_LINUX_IO_URING
>> +    if (exp->is_uring) {
>> +        if (inargflags & FUSE_OVER_IO_URING) {
>> +            supported_flags |= FUSE_OVER_IO_URING;
>> +        } else {
>> +            exp->is_uring = false;
>> +            ret = -ENODEV;
>> +        }
>> +    }
>> +#endif
>> +
>> +    outargflags = inargflags & supported_flags;
>>   
>>       *out = (struct fuse_init_out) {
>>           .major = FUSE_KERNEL_VERSION,
>>           .minor = FUSE_KERNEL_MINOR_VERSION,
>>           .max_readahead = max_readahead,
>>           .max_write = FUSE_MAX_WRITE_BYTES,
>> -        .flags = flags & supported_flags,
>> -        .flags2 = 0,
>> +        .flags = outargflags,
>> +        .flags2 = outargflags >> 32,
>>   
>>           /* libfuse maximum: 2^16 - 1 */
>>           .max_background = UINT16_MAX,
>> @@ -717,7 +987,7 @@ fuse_co_init(FuseExport *exp, struct fuse_init_out *out,
>>           .map_alignment = 0,
>>       };
>>   
>> -    return sizeof(*out);
>> +    return ret < 0 ? ret : sizeof(*out);
>>   }
>>   
>>   /**
>> @@ -1506,6 +1776,14 @@ fuse_co_process_request(FuseQueue *q, void *spillover_buf)
>>           fuse_write_buf_response(q->fuse_fd, req_id, out_hdr,
>>                                   out_data_buffer, ret);
>>           qemu_vfree(out_data_buffer);
>> +#ifdef CONFIG_LINUX_IO_URING
>> +    /* Handle FUSE-over-io_uring initialization */
>> +    if (unlikely(opcode == FUSE_INIT && exp->is_uring)) {
>> +        struct fuse_init_out *out =
>> +            (struct fuse_init_out *)FUSE_OUT_OP_STRUCT(out_buf);
>> +        fuse_uring_start(exp, out);
> 
> Is there any scenario where FUSE_INIT can be received multiple times?
> Maybe if the FUSE file system is umounted and mounted again? I want to
> check that this doesn't leak previously allocated ring state.
> 

I don't think so, even in a multi-threaded FUSE setup, the kernel only 
sends a single FUSE_INIT to userspace. In the legacy mode, whichever 
thread receives that request can handle it and initialize FUSE-over-io_uring



