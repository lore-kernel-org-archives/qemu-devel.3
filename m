Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33947CAC582
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 17:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw2R8-0001fV-CZ; Tue, 09 Sep 2025 13:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uw2QI-0001Ox-UV; Tue, 09 Sep 2025 13:46:51 -0400
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uw2QB-0006Wh-S5; Tue, 09 Sep 2025 13:46:30 -0400
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-80bdff6d1e4so612677385a.3; 
 Tue, 09 Sep 2025 10:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757439978; x=1758044778; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HVmebslavn19U6khLOCktE1kNVuWoxctcQu8xcbC09A=;
 b=HqGr5wb/sbV79CFQRpL44RfPUTqveY2ADEv/eJLWHFiK7vrUJGxvN68YwuFLB4U9xe
 yV9Kp1fpHHVg1BYARBSmFp7BAehk8Jhyty6yngCfDeuKO/j+URnCJlrZhtArQ+vVCwdg
 QoeQqIAu+teB3rV69MUv67a4/8LFOC/VSnImhiiaW+2RtZ7umlHCg1U7nxpT7aIsRq0/
 LaMhJstiY0rxjpNFbP1T3WU9qeUEw+vz7L2yS4o+aBYlIUNc8RKBsnXA8B3X7ABxoenT
 oAti345EWDQqOgpwsF175KMtb9FVxJUgxGXbjsmSuE6xtfRxev55NT5RIR/VHc2vC/a4
 IAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757439978; x=1758044778;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HVmebslavn19U6khLOCktE1kNVuWoxctcQu8xcbC09A=;
 b=j/UP78QY3q/fnBM7qO/kLedY0W21ahCjam/Rt+hDKBbKUVZ7l0tJAk/mA99TCl+SuZ
 9enTTv/E0BUV0lLl5VPeTmE0IonNZ66AqlJCXKgDPctz8EU6XT63Osd0TDyhwosNzCRA
 /CW/+/NtOyokBktHfKFZSClb+lOhWLt5h5y9vJ6g1ALQoHvUfdqxsOLaHpveDquY1a3U
 /YtCmjUGKUQ6zSHcION2Za7lqEI3MWOTKDq9gjAH0Ow3BjR4Q4mB1SYn2zd63QnXfzg7
 3+zpDX+8YcGjPSiKrtetHqpkgubYorS1n93d+7HsHtcGjx+chUcvmZTIYbudmqv2dfYg
 6WNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2nshm0kX67v8M3RvMcV94G33gPu3Vbb8DQPMMOeeuXJ1KMl4jY2U8pFz6TH7bqQRVQdgGxjGv1zVh@nongnu.org
X-Gm-Message-State: AOJu0YwpMdgZD9PXktyH4kLrqbaujeXSjOSmp77WAlTvQJOoYEVsmMST
 yI4tAdHL3A0ycTeHpJMvdSE4A8BOCziqUnfRpi29Ubqd17lckoqFRVKy
X-Gm-Gg: ASbGnct/Ii84RwV3kW/AG5YY2YDAXUZqpby5AjX0RK6YmMq1cq8bVI+JzxP+4OXUJ4+
 kcWpYHVSoLlZijlRSG0qUF3NWUVf790y9QlHfk8Nu8ZgSOx8Hj3oU8eZ/DAJynywc0HUD8wkEUj
 XEQpl8Nsrp0znuVR+Us2bFQkBrC7gqLxZdKK0bC0cJZtSuqMIQk4+6lIvVAJ0f+13p0HA3DPwoh
 QvwVbnOGY+ui4zQVEtVW7Vh/VZ0WnmSyC8E1UgpGyZytyTR7YBNj8UQHGzNFzZmWdeGR9lCxRwb
 JMDCzylesnvPj+Sm0uuL8Xa1EJQZ0ARf6uhR7boWeUAvPcCb96cFaGp7/6L/0sEm4JCs6+R3KtA
 kqBUl2B1xBzWwIZm+kIDZZjGbeYCMJOUjBAiv1mIy6fAWHE6QwPyVnvQ+gVn4yhFMua4X0GkA+K
 8ao7IKxi61VDk=
X-Google-Smtp-Source: AGHT+IFMQI3RLd6VqVHULuTEkaVKMhTmjFvgf0tQYEpRvx0HuxfHE2h0ZVwMmsIBv281bhFFM1iBiQ==
X-Received: by 2002:a05:6214:c22:b0:725:c2b4:3335 with SMTP id
 6a1803df08f44-73921a452acmr156327556d6.4.1757439977536; 
 Tue, 09 Sep 2025 10:46:17 -0700 (PDT)
Received: from [10.36.130.207]
 (wn-campus-nat-129-97-124-207.dynamic.uwaterloo.ca. [129.97.124.207])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-72925b87571sm109273106d6.6.2025.09.09.10.46.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Sep 2025 10:46:17 -0700 (PDT)
Message-ID: <ae10f5c3-af86-4102-a7c6-bc582133464d@gmail.com>
Date: Tue, 9 Sep 2025 13:46:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] export/fuse: add opt to enable FUSE-over-io_uring
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 bernd@bsbernd.com, fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com
References: <20250830025025.3610-1-hibriansong@gmail.com>
 <20250830025025.3610-2-hibriansong@gmail.com>
 <20250903105325.GB106431@fedora>
 <da5f4b75-2543-4f33-97d9-360c409c6079@gmail.com>
 <20250909144804.GC218449@fedora>
Content-Language: en-US
From: Brian Song <hibriansong@gmail.com>
In-Reply-To: <20250909144804.GC218449@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=hibriansong@gmail.com; helo=mail-qk1-x732.google.com
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



On 9/9/25 10:48 AM, Stefan Hajnoczi wrote:
> On Wed, Sep 03, 2025 at 02:00:55PM -0400, Brian Song wrote:
>>
>>
>> On 9/3/25 6:53 AM, Stefan Hajnoczi wrote:
>>> On Fri, Aug 29, 2025 at 10:50:22PM -0400, Brian Song wrote:
>>>> This patch adds a new export option for storage-export-daemon to enable
>>>> FUSE-over-io_uring via the switch io-uring=on|off (disableby default).
>>>> It also implements the protocol handshake with the Linux kernel
>>>> during the FUSE-over-io_uring initialization phase.
>>>>
>>>> See: https://docs.kernel.org/filesystems/fuse-io-uring.html
>>>>
>>>> The kernel documentation describes in detail how FUSE-over-io_uring
>>>> works. This patch implements the Initial SQE stage shown in thediagram:
>>>> it initializes one queue per IOThread, each currently supporting a
>>>> single submission queue entry (SQE). When the FUSE driver sends the
>>>> first FUSE request (FUSE_INIT), storage-export-daemon calls
>>>> fuse_uring_start() to complete initialization, ultimately submitting
>>>> the SQE with the FUSE_IO_URING_CMD_REGISTER command to confirm
>>>> successful initialization with the kernel.
>>>>
>>>> We also added support for multiple IOThreads. The current Linux kernel
>>>> requires registering $(nproc) queues when setting up FUSE-over-io_uring
>>>> To let users customize the number of FUSE Queues (i.e., IOThreads),
>>>> we first create nproc Ring Queues as required by the kernel, then
>>>> distribute them in a round-robin manner to the FUSE Queues for
>>>> registration. In addition, to support multiple in-flight requests,
>>>> we configure each Ring Queue with FUSE_DEFAULT_RING_QUEUE_DEPTH
>>>> entries/requests.
>>>
>>> The previous paragraph says "each currently supporting a single
>>> submission queue entry (SQE)" whereas this paragraph says "we configure
>>> each Ring Queue with FUSE_DEFAULT_RING_QUEUE_DEPTH entries/requests".
>>> Maybe this paragraph was squashed into the commit description in a later
>>> step and the previous paragraph can be updated to reflect that multiple
>>> SQEs are submitted?
>>>
>>>>
>>>> Suggested-by: Kevin Wolf <kwolf@redhat.com>
>>>> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
>>>> Signed-off-by: Brian Song <hibriansong@gmail.com>
>>>> ---
>>>>    block/export/fuse.c                  | 310 +++++++++++++++++++++++++--
>>>>    docs/tools/qemu-storage-daemon.rst   |  11 +-
>>>>    qapi/block-export.json               |   5 +-
>>>>    storage-daemon/qemu-storage-daemon.c |   1 +
>>>>    util/fdmon-io_uring.c                |   5 +-
>>>>    5 files changed, 309 insertions(+), 23 deletions(-)
>>>>
>>>> diff --git a/block/export/fuse.c b/block/export/fuse.c
>>>> index c0ad4696ce..19bf9e5f74 100644
>>>> --- a/block/export/fuse.c
>>>> +++ b/block/export/fuse.c
>>>> @@ -48,6 +48,9 @@
>>>>    #include <linux/fs.h>
>>>>    #endif
>>>> +/* room needed in buffer to accommodate header */
>>>> +#define FUSE_BUFFER_HEADER_SIZE 0x1000
>>>
>>> Is it possible to write this in a way that shows how the constant is
>>> calculated? That way the constant would automatically adjust on systems
>>> where the underlying assumptions have changed (e.g. page size, header
>>> struct size). This approach is also self-documenting so it's possible to
>>> understand where the magic number comes from.
>>>
>>> For example:
>>>
>>>     #define FUSE_BUFFER_HEADER_SIZE DIV_ROUND_UP(sizeof(struct fuse_uring_req_header), qemu_real_host_page_size())
>>>
>>> (I'm guessing what the formula you used is, so this example may be
>>> incorrect...)
>>>
>>
>> In libfuse, the way to calculate the bufsize (for req_payload) is the same
>> as in this patch. For different requests, the request header sizes are not
>> the same, but they should never exceed a certain value. So is that why
>> libfuse has this kind of magic number?
> 
>  From <linux/fuse.h>:
> 
>    #define FUSE_URING_IN_OUT_HEADER_SZ 128
>    #define FUSE_URING_OP_IN_OUT_SZ 128
>    ...
>    struct fuse_uring_req_header {
>            /* struct fuse_in_header / struct fuse_out_header */
>            char in_out[FUSE_URING_IN_OUT_HEADER_SZ];
> 
>            /* per op code header */
>            char op_in[FUSE_URING_OP_IN_OUT_SZ];
> 
>            struct fuse_uring_ent_in_out ring_ent_in_out;
>    };
> 
> The size of struct fuse_uring_req_header is 128 + 128 + (4 * 8) = 288
> bytes. A single 4 KB page easily fits this. I guess that's why 0x1000
> was chosen in libfuse.
> 

Yes, the two iovecs in the ring entry: one refers to the general request 
header (fuse_uring_req_header) and the other refers to the payload. The 
variable bufsize represents the space for these two objects and is used 
to calculate the payload size in case max_write changes.

Alright, let me document the buffer usage. It's been a while since I 
started this, so I don’t fully remember how the buffer works here.

>>
>>>> +
>>>>    /* Prevent overly long bounce buffer allocations */
>>>>    #define FUSE_MAX_READ_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 1 * 1024 * 1024))
>>>>    /*
>>>> @@ -63,12 +66,59 @@
>>>>        (FUSE_MAX_WRITE_BYTES - FUSE_IN_PLACE_WRITE_BYTES)
>>>>    typedef struct FuseExport FuseExport;
>>>> +typedef struct FuseQueue FuseQueue;
>>>> +
>>>> +#ifdef CONFIG_LINUX_IO_URING
>>>> +#define FUSE_DEFAULT_RING_QUEUE_DEPTH 64
>>>> +#define FUSE_DEFAULT_MAX_PAGES_PER_REQ 32
>>>> +
>>>> +typedef struct FuseRingQueue FuseRingQueue;
>>>> +typedef struct FuseRingEnt {
>>>> +    /* back pointer */
>>>> +    FuseRingQueue *rq;
>>>> +
>>>> +    /* commit id of a fuse request */
>>>> +    uint64_t req_commit_id;
>>>
>>> This field is not used in this commit. Please introduce it in the commit
>>> that uses it so it's easier to review and understand the purpose of this
>>> field.
>>>
>>>> +
>>>> +    /* fuse request header and payload */
>>>> +    struct fuse_uring_req_header req_header;
>>>> +    void *op_payload;
>>>> +    size_t req_payload_sz;
>>>
>>> op_payload and req_payload_sz refer to the same buffer, and they are
>>> submitted alongside req_header. It would be nice to name the fields
>>> consistently:
>>>
>>>     struct fuse_uring_req_header req_header;
>>>     void *req_payload;
>>>     size_t req_payload_sz;
>>>
>>> req_payload and req_payload_sz could be eliminated since they are also
>>> stored in iov[1].iov_base and .iov_len. If you feel that would be harder
>>> to understand, then it's okay to keep the duplicate fields.
>>>
>>
>> Makes sense. I followed the design in libfuse. Probably best to just leave
>> them in the struct for readability
>>
>>>> +
>>>> +    /* The vector passed to the kernel */
>>>> +    struct iovec iov[2];
>>>> +
>>>> +    CqeHandler fuse_cqe_handler;
>>>> +} FuseRingEnt;
>>>> +
>>>> +struct FuseRingQueue {
>>>
>>> A comment would be nice here to explain that the kernel requires one
>>> FuseRingQueue per host CPU and this concept is independent of /dev/fuse
>>> (FuseQueue).
>>>
>>>> +    int rqid;
>>>> +
>>>> +    /* back pointer */
>>>> +    FuseQueue *q;
>>>> +    FuseRingEnt *ent;
>>>> +
>>>> +    /* List entry for ring_queues */
>>>> +    QLIST_ENTRY(FuseRingQueue) next;
>>>> +};
>>>> +
>>>> +/*
>>>> + * Round-robin distribution of ring queues across FUSE queues.
>>>> + * This structure manages the mapping between kernel ring queues and user
>>>> + * FUSE queues.
>>>> + */
>>>> +typedef struct FuseRingQueueManager {
>>>> +    FuseRingQueue *ring_queues;
>>>> +    int num_ring_queues;
>>>> +    int num_fuse_queues;
>>>> +} FuseRingQueueManager;
>>>> +#endif
>>>
>>> It's easy to forget which #ifdef we're inside after a few lines, so it
>>> helps to indicate that in a comment:
>>>
>>> #endif /* CONFIG_LINUX_IO_URING */
>>>
>>>>    /*
>>>>     * One FUSE "queue", representing one FUSE FD from which requests are fetched
>>>>     * and processed.  Each queue is tied to an AioContext.
>>>>     */
>>>> -typedef struct FuseQueue {
>>>> +struct FuseQueue {
>>>>        FuseExport *exp;
>>>>        AioContext *ctx;
>>>> @@ -109,15 +159,11 @@ typedef struct FuseQueue {
>>>>         * Free this buffer with qemu_vfree().
>>>>         */
>>>>        void *spillover_buf;
>>>> -} FuseQueue;
>>>> -/*
>>>> - * Verify that FuseQueue.request_buf plus the spill-over buffer together
>>>> - * are big enough to be accepted by the FUSE kernel driver.
>>>> - */
>>>> -QEMU_BUILD_BUG_ON(sizeof(((FuseQueue *)0)->request_buf) +
>>>> -                  FUSE_SPILLOVER_BUF_SIZE <
>>>> -                  FUSE_MIN_READ_BUFFER);
>>>
>>> Why was this removed, it's probably still necessary in the non-io_uring
>>> case (which is compiled in even when CONFIG_LINUX_IO_URING is defined)?
>>>
>>
>> You can check Hanna’s patch. In fuse_co_process_request, Hanna introduced
>> this check when using FUSE_OUT_OP_STRUCT to cast void *buf into the
>> corresponding in/out header for the given operation.
>>
>> But in the v2 patch, we merged the legacy process_request and the uring
>> version into one. This caused the legacy path to pass the array into the
>> common function as a pointer. Now, when we do the buf header size check,
>> what gets checked is just the pointer size.
>>
>> #define FUSE_OUT_OP_STRUCT(op_name, out_buf) \
>>      ({ \
>>          struct fuse_out_header *__out_hdr = \
>>              (struct fuse_out_header *)(out_buf); \
>>          struct fuse_##op_name##_out *__out = \
>>              (struct fuse_##op_name##_out *)(__out_hdr + 1); \
>>          \
>>          QEMU_BUILD_BUG_ON(sizeof(*__out_hdr) + sizeof(*__out) > \
>>                            sizeof(out_buf)); \
>>          \
>>          __out; \
>>      })
> 
> Your patch does not change how ->request_buf is used by the non-io_uring
> code path. ->request_buf needs to fit at least FUSE_MIN_READ_BUFFER
> bytes so I think this QEMU_BUILD_BUG_ON() should not be deleted.
> 

Oh, I misread and thought you were mentioning the QEMU_BUILD_BUG_ON 
deleted in FUSE_IN/OUT_OP_STRUCT_LEGACY. Yes, I mistakenly deleted the 
static assertion for the read buffer and will put it back.

>>
>>
>>>> +#ifdef CONFIG_LINUX_IO_URING
>>>> +    QLIST_HEAD(, FuseRingQueue) ring_queue_list;
>>>> +#endif
>>>> +};
>>>>    struct FuseExport {
>>>>        BlockExport common;
>>>> @@ -133,7 +179,7 @@ struct FuseExport {
>>>>         */
>>>>        bool halted;
>>>> -    int num_queues;
>>>> +    size_t num_queues;
>>>>        FuseQueue *queues;
>>>>        /*
>>>>         * True if this export should follow the generic export's AioContext.
>>>> @@ -149,6 +195,12 @@ struct FuseExport {
>>>>        /* Whether allow_other was used as a mount option or not */
>>>>        bool allow_other;
>>>> +#ifdef CONFIG_LINUX_IO_URING
>>>> +    bool is_uring;
>>>> +    size_t ring_queue_depth;
>>>> +    FuseRingQueueManager *ring_queue_manager;
>>>> +#endif
>>>> +
>>>>        mode_t st_mode;
>>>>        uid_t st_uid;
>>>>        gid_t st_gid;
>>>> @@ -205,7 +257,7 @@ static void fuse_attach_handlers(FuseExport *exp)
>>>>            return;
>>>>        }
>>>> -    for (int i = 0; i < exp->num_queues; i++) {
>>>> +    for (size_t i = 0; i < exp->num_queues; i++) {
>>>>            aio_set_fd_handler(exp->queues[i].ctx, exp->queues[i].fuse_fd,
>>>>                               read_from_fuse_fd, NULL, NULL, NULL,
>>>>                               &exp->queues[i]);
>>>> @@ -257,6 +309,189 @@ static const BlockDevOps fuse_export_blk_dev_ops = {
>>>>        .drained_poll  = fuse_export_drained_poll,
>>>>    };
>>>> +#ifdef CONFIG_LINUX_IO_URING
>>>> +static void fuse_uring_sqe_set_req_data(struct fuse_uring_cmd_req *req,
>>>> +                    const unsigned int rqid,
>>>> +                    const unsigned int commit_id)
>>>> +{
>>>> +    req->qid = rqid;
>>>> +    req->commit_id = commit_id;
>>>> +    req->flags = 0;
>>>> +}
>>>> +
>>>> +static void fuse_uring_sqe_prepare(struct io_uring_sqe *sqe, FuseQueue *q,
>>>> +               __u32 cmd_op)
>>>> +{
>>>> +    sqe->opcode = IORING_OP_URING_CMD;
>>>> +
>>>> +    sqe->fd = q->fuse_fd;
>>>> +    sqe->rw_flags = 0;
>>>> +    sqe->ioprio = 0;
>>>> +    sqe->off = 0;
>>>> +
>>>> +    sqe->cmd_op = cmd_op;
>>>> +    sqe->__pad1 = 0;
>>>> +}
>>>> +
>>>> +static void fuse_uring_prep_sqe_register(struct io_uring_sqe *sqe, void *opaque)
>>>> +{
>>>> +    FuseRingEnt *ent = opaque;
>>>> +    struct fuse_uring_cmd_req *req = (void *)&sqe->cmd[0];
>>>> +
>>>> +    fuse_uring_sqe_prepare(sqe, ent->rq->q, FUSE_IO_URING_CMD_REGISTER);
>>>> +
>>>> +    sqe->addr = (uint64_t)(ent->iov);
>>>> +    sqe->len = 2;
>>>> +
>>>> +    fuse_uring_sqe_set_req_data(req, ent->rq->rqid, 0);
>>>> +}
>>>> +
>>>> +static void fuse_uring_submit_register(void *opaque)
>>>> +{
>>>> +    FuseRingEnt *ent = opaque;
>>>> +    FuseExport *exp = ent->rq->q->exp;
>>>
>>> This variable is unused in this commit? Does this commit compile for
>>> you? Usually the compiler warns about unused variables.
>>>
>>
>> The first version was a large single patch. I split it with git, and this
>> variable is now used in a different patch
>>
>>>> +
>>>> +
>>>> +    aio_add_sqe(fuse_uring_prep_sqe_register, ent, &(ent->fuse_cqe_handler));
>>>> +}
>>>> +
>>>> +/**
>>>> + * Distribute ring queues across FUSE queues using round-robin algorithm.
>>>> + * This ensures even distribution of kernel ring queues across user-specified
>>>> + * FUSE queues.
>>>> + */
>>>> +static
>>>> +FuseRingQueueManager *fuse_ring_queue_manager_create(int num_fuse_queues,
>>>> +                                                    size_t ring_queue_depth,
>>>> +                                                    size_t bufsize)
>>>> +{
>>>> +    int num_ring_queues = get_nprocs();
>>>
>>> The kernel code uses num_possible_cpus() in
>>> fs/fuse/dev_uring.c:fuse_uring_create() so I think this should be
>>> get_nprocs_conf() instead of get_nprocs().
>>>
>>>> +    FuseRingQueueManager *manager = g_new(FuseRingQueueManager, 1);
>>>> +
>>>> +    if (!manager) {
>>>
>>> g_new() never returns NULL, so you can remove this if statement. If
>>> memory cannot be allocated then the process will abort.
>>>
>>>> +        return NULL;
>>>> +    }
>>>> +
>>>> +    manager->ring_queues = g_new(FuseRingQueue, num_ring_queues);
>>>> +    manager->num_ring_queues = num_ring_queues;
>>>> +    manager->num_fuse_queues = num_fuse_queues;
>>>> +
>>>> +    if (!manager->ring_queues) {
>>>
>>> Same here.
>>>
>>>> +        g_free(manager);
>>>> +        return NULL;
>>>> +    }
>>>> +
>>>> +    for (int i = 0; i < num_ring_queues; i++) {
>>>> +        FuseRingQueue *rq = &manager->ring_queues[i];
>>>> +        rq->rqid = i;
>>>> +        rq->ent = g_new(FuseRingEnt, ring_queue_depth);
>>>> +
>>>> +        if (!rq->ent) {
>>>
>>> Same here.
>>>
>>>> +            for (int j = 0; j < i; j++) {
>>>> +                g_free(manager->ring_queues[j].ent);
>>>> +            }
>>>> +            g_free(manager->ring_queues);
>>>> +            g_free(manager);
>>>> +            return NULL;
>>>> +        }
>>>> +
>>>> +        for (size_t j = 0; j < ring_queue_depth; j++) {
>>>> +            FuseRingEnt *ent = &rq->ent[j];
>>>> +            ent->rq = rq;
>>>> +            ent->req_payload_sz = bufsize - FUSE_BUFFER_HEADER_SIZE;
>>>> +            ent->op_payload = g_malloc0(ent->req_payload_sz);
>>>> +
>>>> +            if (!ent->op_payload) {
>>>
>>> Same here.
>>>
>>>> +                for (size_t k = 0; k < j; k++) {
>>>> +                    g_free(rq->ent[k].op_payload);
>>>> +                }
>>>> +                g_free(rq->ent);
>>>> +                for (int k = 0; k < i; k++) {
>>>> +                    g_free(manager->ring_queues[k].ent);
>>>> +                }
>>>> +                g_free(manager->ring_queues);
>>>> +                g_free(manager);
>>>
>>> Where are these structures freed in the normal lifecycle of a FUSE
>>> export? I only see this error handling code, but nothing is freed when
>>> the export is shut down.
>>
>>
>> Same here. The first version was a large single patch. I split it with git,
>> and we do cleanup in a different patch
> 
> It's easier for reviewers and safer for backports if each patch is
> self-contained with the cleanup code included in the same patch where
> the resource is created. If you make changes to the patch organization
> in the next revision then it would be nice to included the cleanup in
> this patch.
> 
>>
>>>
>>>> +                return NULL;
>>>> +            }
>>>> +
>>>> +            ent->iov[0] = (struct iovec) {
>>>> +                &(ent->req_header),
>>>> +                sizeof(struct fuse_uring_req_header)
>>>> +            };
>>>> +            ent->iov[1] = (struct iovec) {
>>>> +                ent->op_payload,
>>>> +                ent->req_payload_sz
>>>> +            };
>>>> +
>>>> +            ent->fuse_cqe_handler.cb = fuse_uring_cqe_handler;
>>>> +        }
>>>> +    }
>>>> +
>>>> +    return manager;
>>>> +}
>>>> +
>>>> +static
>>>> +void fuse_distribute_ring_queues(FuseExport *exp, FuseRingQueueManager *manager)
>>>> +{
>>>> +    int queue_index = 0;
>>>> +
>>>> +    for (int i = 0; i < manager->num_ring_queues; i++) {
>>>> +        FuseRingQueue *rq = &manager->ring_queues[i];
>>>> +
>>>> +        rq->q = &exp->queues[queue_index];
>>>> +        QLIST_INSERT_HEAD(&(rq->q->ring_queue_list), rq, next);
>>>> +
>>>> +        queue_index = (queue_index + 1) % manager->num_fuse_queues;
>>>> +    }
>>>> +}
>>>> +
>>>> +static
>>>> +void fuse_schedule_ring_queue_registrations(FuseExport *exp,
>>>> +                                            FuseRingQueueManager *manager)
>>>> +{
>>>> +    for (int i = 0; i < manager->num_fuse_queues; i++) {
>>>> +        FuseQueue *q = &exp->queues[i];
>>>> +        FuseRingQueue *rq;
>>>> +
>>>> +        QLIST_FOREACH(rq, &q->ring_queue_list, next) {
>>>> +            for (int j = 0; j < exp->ring_queue_depth; j++) {
>>>> +                aio_bh_schedule_oneshot(q->ctx, fuse_uring_submit_register,
>>>> +                                        &(rq->ent[j]));
>>>> +            }
>>>> +        }
>>>> +    }
>>>> +}
>>>> +
>>>> +static void fuse_uring_start(FuseExport *exp, struct fuse_init_out *out)
>>>> +{
>>>> +    /*
>>>> +     * Since we didn't enable the FUSE_MAX_PAGES feature, the value of
>>>> +     * fc->max_pages should be FUSE_DEFAULT_MAX_PAGES_PER_REQ, which is set by
>>>> +     * the kernel by default. Also, max_write should not exceed
>>>> +     * FUSE_DEFAULT_MAX_PAGES_PER_REQ * PAGE_SIZE.
>>>> +     */
>>>> +    size_t bufsize = out->max_write + FUSE_BUFFER_HEADER_SIZE;
>>>> +
>>>> +    if (!(out->flags & FUSE_MAX_PAGES)) {
>>>> +        bufsize = FUSE_DEFAULT_MAX_PAGES_PER_REQ * qemu_real_host_page_size()
>>>> +                         + FUSE_BUFFER_HEADER_SIZE;
>>>> +    }
>>>> +
>>>> +    exp->ring_queue_manager = fuse_ring_queue_manager_create(
>>>> +        exp->num_queues, exp->ring_queue_depth, bufsize);
>>>> +
>>>> +    if (!exp->ring_queue_manager) {
>>>> +        error_report("Failed to create ring queue manager");
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    /* Distribute ring queues across FUSE queues using round-robin */
>>>> +    fuse_distribute_ring_queues(exp, exp->ring_queue_manager);
>>>> +
>>>> +    fuse_schedule_ring_queue_registrations(exp, exp->ring_queue_manager);
>>>> +}
>>>> +#endif
>>>> +
>>>>    static int fuse_export_create(BlockExport *blk_exp,
>>>>                                  BlockExportOptions *blk_exp_args,
>>>>                                  AioContext *const *multithread,
>>>> @@ -270,6 +505,11 @@ static int fuse_export_create(BlockExport *blk_exp,
>>>>        assert(blk_exp_args->type == BLOCK_EXPORT_TYPE_FUSE);
>>>> +#ifdef CONFIG_LINUX_IO_URING
>>>> +    exp->is_uring = args->io_uring;
>>>> +    exp->ring_queue_depth = FUSE_DEFAULT_RING_QUEUE_DEPTH;
>>>> +#endif
>>>> +
>>>>        if (multithread) {
>>>>            /* Guaranteed by common export code */
>>>>            assert(mt_count >= 1);
>>>> @@ -283,6 +523,10 @@ static int fuse_export_create(BlockExport *blk_exp,
>>>>                    .exp = exp,
>>>>                    .ctx = multithread[i],
>>>>                    .fuse_fd = -1,
>>>> +#ifdef CONFIG_LINUX_IO_URING
>>>> +                .ring_queue_list =
>>>> +                    QLIST_HEAD_INITIALIZER(exp->queues[i].ring_queue_list),
>>>> +#endif
>>>>                };
>>>>            }
>>>>        } else {
>>>> @@ -296,6 +540,10 @@ static int fuse_export_create(BlockExport *blk_exp,
>>>>                .exp = exp,
>>>>                .ctx = exp->common.ctx,
>>>>                .fuse_fd = -1,
>>>> +#ifdef CONFIG_LINUX_IO_URING
>>>> +            .ring_queue_list =
>>>> +                QLIST_HEAD_INITIALIZER(exp->queues[0].ring_queue_list),
>>>> +#endif
>>>>            };
>>>>        }
>>>> @@ -685,17 +933,39 @@ static bool is_regular_file(const char *path, Error **errp)
>>>>     */
>>>>    static ssize_t coroutine_fn
>>>>    fuse_co_init(FuseExport *exp, struct fuse_init_out *out,
>>>> -             uint32_t max_readahead, uint32_t flags)
>>>> +             uint32_t max_readahead, const struct fuse_init_in *in)
>>>>    {
>>>> -    const uint32_t supported_flags = FUSE_ASYNC_READ | FUSE_ASYNC_DIO;
>>>> +    uint64_t supported_flags = FUSE_ASYNC_READ | FUSE_ASYNC_DIO
>>>> +                                     | FUSE_INIT_EXT;
>>>> +    uint64_t outargflags = 0;
>>>> +    uint64_t inargflags = in->flags;
>>>> +
>>>> +    ssize_t ret = 0;
>>>> +
>>>> +    if (inargflags & FUSE_INIT_EXT) {
>>>> +        inargflags = inargflags | (uint64_t) in->flags2 << 32;
>>>> +    }
>>>> +
>>>> +#ifdef CONFIG_LINUX_IO_URING
>>>> +    if (exp->is_uring) {
>>>> +        if (inargflags & FUSE_OVER_IO_URING) {
>>>> +            supported_flags |= FUSE_OVER_IO_URING;
>>>> +        } else {
>>>> +            exp->is_uring = false;
>>>> +            ret = -ENODEV;
>>>> +        }
>>>> +    }
>>>> +#endif
>>>> +
>>>> +    outargflags = inargflags & supported_flags;
>>>>        *out = (struct fuse_init_out) {
>>>>            .major = FUSE_KERNEL_VERSION,
>>>>            .minor = FUSE_KERNEL_MINOR_VERSION,
>>>>            .max_readahead = max_readahead,
>>>>            .max_write = FUSE_MAX_WRITE_BYTES,
>>>> -        .flags = flags & supported_flags,
>>>> -        .flags2 = 0,
>>>> +        .flags = outargflags,
>>>> +        .flags2 = outargflags >> 32,
>>>>            /* libfuse maximum: 2^16 - 1 */
>>>>            .max_background = UINT16_MAX,
>>>> @@ -717,7 +987,7 @@ fuse_co_init(FuseExport *exp, struct fuse_init_out *out,
>>>>            .map_alignment = 0,
>>>>        };
>>>> -    return sizeof(*out);
>>>> +    return ret < 0 ? ret : sizeof(*out);
>>>>    }
>>>>    /**
>>>> @@ -1506,6 +1776,14 @@ fuse_co_process_request(FuseQueue *q, void *spillover_buf)
>>>>            fuse_write_buf_response(q->fuse_fd, req_id, out_hdr,
>>>>                                    out_data_buffer, ret);
>>>>            qemu_vfree(out_data_buffer);
>>>> +#ifdef CONFIG_LINUX_IO_URING
>>>> +    /* Handle FUSE-over-io_uring initialization */
>>>> +    if (unlikely(opcode == FUSE_INIT && exp->is_uring)) {
>>>> +        struct fuse_init_out *out =
>>>> +            (struct fuse_init_out *)FUSE_OUT_OP_STRUCT(out_buf);
>>>> +        fuse_uring_start(exp, out);
>>>
>>> Is there any scenario where FUSE_INIT can be received multiple times?
>>> Maybe if the FUSE file system is umounted and mounted again? I want to
>>> check that this doesn't leak previously allocated ring state.
>>>
>>
>> I don't think so, even in a multi-threaded FUSE setup, the kernel only sends
>> a single FUSE_INIT to userspace. In the legacy mode, whichever thread
>> receives that request can handle it and initialize FUSE-over-io_uring
> 
> Okay. Please add an assertion to fuse_uring_start() to catch the case
> where it is called twice.
> 
> Thanks,
> Stefan


