Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13957CA0EFC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 03:32:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoZXv-0005jK-Iy; Tue, 19 Aug 2025 23:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uoZXu-0005iy-FM; Tue, 19 Aug 2025 23:31:30 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uoZXs-0007IB-1f; Tue, 19 Aug 2025 23:31:30 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-30cce8ec298so4953120fac.1; 
 Tue, 19 Aug 2025 20:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755660686; x=1756265486; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fihrPd0/EKeAQyOmu/N+/caq4lPfV22+3E0mreSGw1s=;
 b=UpVxaZWSe74ZbIGHq3Rqt0xB+Ec4Z4cdSvdM2QRZ2uxOKA2JidQGfnee+X9ae4rZHs
 iEuMQLin8kcyPDl1kO0Y3xu1+L+OkyMZPGrHtl2pOi5zOxNZQLZfgxlZQoebJyAppDiE
 KjEFop+c4auu0kMVnTynb+jVptq7iWJBrbBYRkJAkGuULQOqqBgnAdq+ZtmmQq8iRWtE
 oOjYYa6cK+6oGpOFJMnO57bTV6ZPYMVsIztIZr7bdQM/81JzXhxYHIg/ySTBFfFvHvlx
 sUG76i18tP72DpvVXaOUCZsNsM7uoEoA/aRhpO1Q7IhbCOo46Vd3SYQEqIYz4bKrxevV
 W2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755660686; x=1756265486;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fihrPd0/EKeAQyOmu/N+/caq4lPfV22+3E0mreSGw1s=;
 b=lt8mU3eJicEFuK6chB/sepG4frv8X/Nv/SQwqDhqEPQsI19qtLIr0Piirtj8CTW72i
 9mWYrYPJeREsNcbtXNGbQ+6xYuvYAHEgpNdCAPjOxHmd61DG8CkTHxGcWo1T0XSLyo1X
 NM1v/VG6EPtHuRrbt8JRG0sAPfVuSBtMVe1OzcthySsxQACzrhZd7g+sO6RhyPsz38P0
 f36JaMPGD3uz+Lr6psN1kZJh9B+VecBh12vZ0XjDNsg5icEVMJ41DBbjzUivfwmjw+6g
 3jczrOjg666fMGbeh03y0P4epanxHa2rHU+UIdDTvaRIIIjJiCjwQlWrDqYJ9ytOa8F9
 ZNUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUd7SMtHllozykHr2cnJ8gV2x2axO675vywc3je1Bv91I1KIqwUUL+NCmCCqlAWgkcQspnElQZCxM9p@nongnu.org
X-Gm-Message-State: AOJu0YwWkOeplC8NV1ucNOkahSN/YgC2y7GZgOZrcI9zCatEYx7A3nTP
 JuGK9OB74rGEo7VSYxRmuycFexUgkIRad1cEETaPdFL8vSGmKy7bcdWv9KGP1ucDs+ROECtJj2L
 H/JHhuz06QV03+nB2zasYE5ccVQHZ+VQ=
X-Gm-Gg: ASbGncvQmJMGkRl00cmwtupLt/4n5UDgNRy9KjtCDa3yVM85MSg9+3paPvUJJb5BWJl
 JEncnyuf0Z1wVjV4ANFBm40tZgO9vm+LaL1SHFnzrwoHdzxFKxgXkBxjOg43eHeMXbejUtYKLSv
 lM0Js/1R2h4k44iTqrEUZSQy46Z4U811PgL0tqaZfhrTd4jKDbAI/VpFqpZ4kTR0uqX/upXLtE1
 yKc/QE=
X-Google-Smtp-Source: AGHT+IF8LFIXPTNc12z3zXYegjlkM4RPnrdYu5kuApS3AqohPulSHhzWYOQph2CrMCBe+j1eEYuqmP2FRkyUUMDO2Hg=
X-Received: by 2002:a05:6808:1806:b0:434:f1b:1a69 with SMTP id
 5614622812f47-43772017fafmr744073b6e.9.1755660685668; Tue, 19 Aug 2025
 20:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250815034619.51980-1-hizhisong@gmail.com>
 <20250815034619.51980-2-hizhisong@gmail.com>
 <beb43845-a761-4031-a7b7-aaca56abb6de@gmail.com>
 <105d583b-e931-4e60-a113-9a571c18c726@bsbernd.com>
 <a76de187-f181-47d3-a36e-6eb1a865cc5e@gmail.com>
 <4896b694-6f00-49d9-ad8e-04225824eb6c@bsbernd.com>
 <daa0d4eb-363a-4553-8f61-b3aa3ae58600@gmail.com>
In-Reply-To: <daa0d4eb-363a-4553-8f61-b3aa3ae58600@gmail.com>
From: Brian Song <hibriansong@gmail.com>
Date: Tue, 19 Aug 2025 23:31:14 -0400
X-Gm-Features: Ac12FXz62xBeuJN1jmARRHODZJvqclZiOO86liIEz5CqIGSLxd5Lxr6VmCmWIRw
Message-ID: <CAKWCU7XLvEBCs8WE=mFSSsLmV1Yo3PXEnsuDP72NvEwJ_15nSA@mail.gmail.com>
Subject: Re: [PATCH 1/3] fuse: add FUSE-over-io_uring enable opt and init
To: Bernd Schubert <bernd@bsbernd.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, fam@euphon.net, 
 hreitz@redhat.com, kwolf@redhat.com, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=hibriansong@gmail.com; helo=mail-oa1-x2b.google.com
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

On 8/19/25 7:23 PM, Brian Song wrote:
>
>
> On 8/19/25 6:26 PM, Bernd Schubert wrote:
>>
>>
>> On 8/19/25 03:15, Brian Song wrote:
>>>
>>>
>>> On 8/18/25 7:04 PM, Bernd Schubert wrote:
>>>>
>>>>
>>>> On 8/17/25 01:13, Brian Song wrote:
>>>>>
>>>>>
>>>>> On 8/14/25 11:46 PM, Brian Song wrote:
>>>>>> From: Brian Song <hibriansong@gmail.com>
>>>>>>
>>>>>> This patch adds a new export option for storage-export-daemon to
>>>>>> enable
>>>>>> or disable FUSE-over-io_uring via the switch io-uring=3Don|off (disa=
ble
>>>>>> by default). It also implements the protocol handshake with the Linu=
x
>>>>>> kernel during the FUSE-over-io_uring initialization phase.
>>>>>>
>>>>>> See: https://docs.kernel.org/filesystems/fuse-io-uring.html
>>>>>>
>>>>>> The kernel documentation describes in detail how FUSE-over-io_uring
>>>>>> works. This patch implements the Initial SQE stage shown in
>>>>>> thediagram:
>>>>>> it initializes one queue per IOThread, each currently supporting a
>>>>>> single submission queue entry (SQE). When the FUSE driver sends the
>>>>>> first FUSE request (FUSE_INIT), storage-export-daemon calls
>>>>>> fuse_uring_start() to complete initialization, ultimately submitting
>>>>>> the SQE with the FUSE_IO_URING_CMD_REGISTER command to confirm
>>>>>> successful initialization with the kernel.
>>>>>>
>>>>>> Suggested-by: Kevin Wolf <kwolf@redhat.com>
>>>>>> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
>>>>>> Signed-off-by: Brian Song <hibriansong@gmail.com>
>>>>>> ---
>>>>>>     block/export/fuse.c                  | 161 +++++++++++++++++++
>>>>>> +++++---
>>>>>>     docs/tools/qemu-storage-daemon.rst   |  11 +-
>>>>>>     qapi/block-export.json               |   5 +-
>>>>>>     storage-daemon/qemu-storage-daemon.c |   1 +
>>>>>>     util/fdmon-io_uring.c                |   5 +-
>>>>>>     5 files changed, 159 insertions(+), 24 deletions(-)
>>>>>>
>>>>>> diff --git a/block/export/fuse.c b/block/export/fuse.c
>>>>>> index c0ad4696ce..59fa79f486 100644
>>>>>> --- a/block/export/fuse.c
>>>>>> +++ b/block/export/fuse.c
>>>>>> @@ -48,6 +48,11 @@
>>>>>>     #include <linux/fs.h>
>>>>>>     #endif
>>>>>>
>>>>>> +#define FUSE_DEFAULT_MAX_PAGES_PER_REQ 32
>>>>>> +
>>>>>> +/* room needed in buffer to accommodate header */
>>>>>> +#define FUSE_BUFFER_HEADER_SIZE 0x1000
>>>>>> +
>>>>>>     /* Prevent overly long bounce buffer allocations */
>>>>>>     #define FUSE_MAX_READ_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 1 *
>>>>>> 1024 * 1024))
>>>>>>     /*
>>>>>> @@ -63,12 +68,31 @@
>>>>>>         (FUSE_MAX_WRITE_BYTES - FUSE_IN_PLACE_WRITE_BYTES)
>>>>>>
>>>>>>     typedef struct FuseExport FuseExport;
>>>>>> +typedef struct FuseQueue FuseQueue;
>>>>>> +
>>>>>> +typedef struct FuseRingEnt {
>>>>>> +    /* back pointer */
>>>>>> +    FuseQueue *q;
>>>>>> +
>>>>>> +    /* commit id of a fuse request */
>>>>>> +    uint64_t req_commit_id;
>>>>>> +
>>>>>> +    /* fuse request header and payload */
>>>>>> +    struct fuse_uring_req_header req_header;
>>>>>> +    void *op_payload;
>>>>>> +    size_t req_payload_sz;
>>>>>> +
>>>>>> +    /* The vector passed to the kernel */
>>>>>> +    struct iovec iov[2];
>>>>>> +
>>>>>> +    CqeHandler fuse_cqe_handler;
>>>>>> +} FuseRingEnt;
>>>>>>
>>>>>>     /*
>>>>>>      * One FUSE "queue", representing one FUSE FD from which
>>>>>> requests are fetched
>>>>>>      * and processed.  Each queue is tied to an AioContext.
>>>>>>      */
>>>>>> -typedef struct FuseQueue {
>>>>>> +struct FuseQueue {
>>>>>>         FuseExport *exp;
>>>>>>
>>>>>>         AioContext *ctx;
>>>>>> @@ -109,7 +133,12 @@ typedef struct FuseQueue {
>>>>>>          * Free this buffer with qemu_vfree().
>>>>>>          */
>>>>>>         void *spillover_buf;
>>>>>> -} FuseQueue;
>>>>>> +
>>>>>> +#ifdef CONFIG_LINUX_IO_URING
>>>>>> +    int qid;
>>>>>> +    FuseRingEnt ent;
>>>>>> +#endif
>>>>>> +};
>>>>>>
>>>>>>     /*
>>>>>>      * Verify that FuseQueue.request_buf plus the spill-over
>>>>>> buffer together
>>>>>> @@ -148,6 +177,7 @@ struct FuseExport {
>>>>>>         bool growable;
>>>>>>         /* Whether allow_other was used as a mount option or not */
>>>>>>         bool allow_other;
>>>>>> +    bool is_uring;
>>>>>>
>>>>>>         mode_t st_mode;
>>>>>>         uid_t st_uid;
>>>>>> @@ -257,6 +287,93 @@ static const BlockDevOps
>>>>>> fuse_export_blk_dev_ops =3D {
>>>>>>         .drained_poll  =3D fuse_export_drained_poll,
>>>>>>     };
>>>>>>
>>>>>> +#ifdef CONFIG_LINUX_IO_URING
>>>>>> +
>>>>>> +static void fuse_uring_sqe_set_req_data(struct fuse_uring_cmd_req
>>>>>> *req,
>>>>>> +                    const unsigned int qid,
>>>>>> +                    const unsigned int commit_id)
>>>>>> +{
>>>>>> +    req->qid =3D qid;
>>>>>> +    req->commit_id =3D commit_id;
>>>>>> +    req->flags =3D 0;
>>>>>> +}
>>>>>> +
>>>>>> +static void fuse_uring_sqe_prepare(struct io_uring_sqe *sqe,
>>>>>> FuseQueue *q,
>>>>>> +               __u32 cmd_op)
>>>>>> +{
>>>>>> +    sqe->opcode =3D IORING_OP_URING_CMD;
>>>>>> +
>>>>>> +    sqe->fd =3D q->fuse_fd;
>>>>>> +    sqe->rw_flags =3D 0;
>>>>>> +    sqe->ioprio =3D 0;
>>>>>> +    sqe->off =3D 0;
>>>>>> +
>>>>>> +    sqe->cmd_op =3D cmd_op;
>>>>>> +    sqe->__pad1 =3D 0;
>>>>>> +}
>>>>>> +
>>>>>> +static void fuse_uring_prep_sqe_register(struct io_uring_sqe
>>>>>> *sqe, void *opaque)
>>>>>> +{
>>>>>> +    FuseQueue *q =3D opaque;
>>>>>> +    struct fuse_uring_cmd_req *req =3D (void *)&sqe->cmd[0];
>>>>>> +
>>>>>> +    fuse_uring_sqe_prepare(sqe, q, FUSE_IO_URING_CMD_REGISTER);
>>>>>> +
>>>>>> +    sqe->addr =3D (uint64_t)(q->ent.iov);
>>>>>> +    sqe->len =3D 2;
>>>>>> +
>>>>>> +    fuse_uring_sqe_set_req_data(req, q->qid, 0);
>>>>>> +}
>>>>>> +
>>>>>> +static void fuse_uring_submit_register(void *opaque)
>>>>>> +{
>>>>>> +    FuseQueue *q =3D opaque;
>>>>>> +    FuseExport *exp =3D q->exp;
>>>>>> +
>>>>>> +
>>>>>> +    aio_add_sqe(fuse_uring_prep_sqe_register, q, &(q-
>>>>>> >ent.fuse_cqe_handler));
>>>>>
>>>>> I think there might be a tricky issue with the io_uring integration i=
n
>>>>> QEMU. Currently, when the number of IOThreads goes above ~6 or 7,
>>>>> there=E2=80=99s a pretty high chance of a hang. I added some debug lo=
gging in
>>>>> the kernel=E2=80=99s fuse_uring_cmd() registration part, and noticed =
that the
>>>>> number of register calls is less than the total number of entries
>>>>> in the
>>>>> queue. In theory, we should be registering each entry for each queue.
>>>>
>>>> Did you also try to add logging at the top of fuse_uring_cmd()? I
>>>> wonder
>>>> if there is a start up race and if initial commands are just getting
>>>> refused. I had run into issues you are describing in some versions of
>>>> the -rfc patches, but thought that everything was fixed for that.
>>>> I.e. not excluded that there is still a kernel issue left.
>>>>
>>>> Thanks,
>>>> Bernd
>>>>
>>>>
>>>
>>> Yes. I added a printk at the beginning of fuse_uring_cmd(), another at
>>> the beginning of fuse_uring_register(), and one more at the end of
>>> fuse_uring_do_register(). Then I created and registered 20 queues, each
>>> with a single ring entry. It printed 37 times(diff every time) with
>>> opcode FUSE_IO_URING_CMD_REGISTER (would expect 20), and only 6 queues
>>> were registered successfully. The rest of fuse_uring_cmd (x31) exited
>>> inside the if (!fc->initialized) branch in fuse_uring_cmd()
>>>
>>> dmesg: https://gist.github.com/
>>> hibriansong/4eda6e7e92601df497282dcd56fd5470
>>
>> Thank you for the logs, could you try this?
>>
>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>> index 2aa20707f40b..cea57ad5d3ab 100644
>> --- a/fs/fuse/dev_uring.c
>> +++ b/fs/fuse/dev_uring.c
>> @@ -1324,6 +1324,9 @@ int fuse_uring_cmd(struct io_uring_cmd *cmd,
>> unsigned int issue_flags)
>>          if (!fc->connected)
>>                  return -ENOTCONN;
>> +       /* Matches smp_wmb() in fuse_set_initialized() */
>> +       smp_rmb();
>> +
>>          /*
>>           * fuse_uring_register() needs the ring to be initialized,
>>           * we need to know the max payload size
>>
>>
>>
>> Thanks,
>> Bernd
>
> I realized the issue actually comes from QEMU handling the FUSE_INIT
> request. After I processed outargs, I didn't send the response back to
> the kernel before starting the fuse-over-io_uring initialization. So
> it's possible that the 20 registration requests submitted via
> io_uring_cmd() reach the kernel before process_init_reply() has run and
> set fc->initialized =3D 1, which causes fuse_uring_cmd to bail out
> repeatedly.
>
> I also noticed that in libfuse, they first send the init request
> response, then allocate queues and submit the register SQEs. But even
> there, during the fuse-over-io_uring init after sending the response, if
> the kernel hasn't finished process_init_reply() and set fc->initialized
> =3D 1, wouldn't they run into a similar issue fuse_uring_cmd repeatedly
> bailing on register requests because fc->initialized isn't set yet?

Hi Bernd,

Nvm, I think writing to /dev/fuse fd is blocking.

Thanks so much for your feedback!

Best,
Brian

