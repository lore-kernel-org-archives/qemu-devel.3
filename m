Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F55CA0EE4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 01:16:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoAxD-0003gn-VU; Mon, 18 Aug 2025 21:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uoAx4-0003fZ-Ms; Mon, 18 Aug 2025 21:15:51 -0400
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uoAx2-0001dj-1C; Mon, 18 Aug 2025 21:15:50 -0400
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7e870689dedso339875685a.3; 
 Mon, 18 Aug 2025 18:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755566145; x=1756170945; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UJBnoWNSKBbXK+ihBDF3Va6yINQk8iwX3oAqFA/iBR4=;
 b=GYXOrEXGm7WlVluKmViXrSec0Y/gUMmOdAGRWTBxAJzB5JLaWMlcP6VsW8a8DwlqXz
 s/QcO4dyxLsyOEBGZ9V1eSAwdIR13JI7kZVYc+aArtQXMIaguLb4BynfyzO3A7AiLqQa
 r88dy6coMj4h7G5j2JyjesnhrMv6ruI84KdHfyA8S9FG1NKEWl+oMdCYLalijECFJ0pf
 CZ9IUaThJHhG8nwUr8uWlFtoaEx0lQqZEyYbeadW5ceJFypr6H+uhCtYjV5L5wcjwoNw
 OgMc1u9jlpjPvMPN4WKRjGPsYbDkqp9tkXCV+ZUkkqdH0GCZ+gb2gyycTUsrS49yWTze
 VPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755566145; x=1756170945;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UJBnoWNSKBbXK+ihBDF3Va6yINQk8iwX3oAqFA/iBR4=;
 b=PaWqP/4sXkgg4VesITSAmI+Y4FeGZh9e7nHI8NUcPJjxJApQWm0NbXnR6qT8RRX/iw
 E0Me1vawnJN2Pj8XQqnqw8Sz3n7VHVJ7uvLETCA+q0f+BZixFjTMnsmOpv5HzsAvHBrL
 mzBIDucFvZxKJ07ukuPGhlo5GvOH/9HV7rgA9n9CyRCTX+mruz6YeBlqXsMO09kgokPW
 vBRi0yddYvRswhqUjOgdwg9yxLWULiHWiENuqaYJG52LAO9ibmVIIaTn5ivofGoOHXNP
 rN0FRvtf/ZKnFh927EZcR8RJFw0FBe5DxFBJerVVke6z8mgbJbr/fcyVaOkBGP/bKGQ3
 ICSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpY5ZNyuaoQOwWuYXP1oetftS9m5imHcjKHXFAPhn/vK3uwz1s5Jp9KYTomOME3knS4Lp9mhwu/oI0@nongnu.org
X-Gm-Message-State: AOJu0YyES2FC7mqkDKqhqAbeIXcialuCWuAls3bR8cKyDZ/oLVEQ7cYe
 XQUaKhC0rr1IhBHn8n08wIa0xt448TLDTjcpPnE1wjAUr19Gy+YfKI14
X-Gm-Gg: ASbGncu7fgRGkENJytOga2C+gfzSiqHuq1bEd+fGjojhpSgctaL5CGRDecf8wAdlQYH
 +v8jU1Hr2QBbCdfBandg2zbKbaDlv+fCEWPBWOYV+EswGbx+e4ZRc0HHbN78f67K+KuxYRnkeNU
 bocKdQ+OHonLwLh5Aj/b+AbtkR6VnmdmqxgXMKKUVgZ3PiGQZP+GuNBjH+VIZzD8/i/cFjPUgVa
 eFmQty2/LeBiApehh6oOkz1SNEi/0jFIQl/3/0W8MVX+CJx8jes0Fdly+b1u3QUTdJZwG/OsWOR
 SZM/gHufFqgTfQGTbitz3SLujMPevD9baWPfnzBgXVe9tLtaqMUC3Z/N+RKEIezdmjYKod9buA2
 4S4j7c3Bfc0Ncc1Jjm2jxa5js/R0nThX6qJJn1vSBnp+HvO+hYoM8+J4bR2Fnb5Do2jqRKszcMI
 PqiKQ55ueUShCq
X-Google-Smtp-Source: AGHT+IHEAC+zufidA8BjXt0tsXjNMflClGPEPVVGIThmsypv7ixNUiCIXqadVe1F/zh9VNuJhf1zkQ==
X-Received: by 2002:a05:620a:4556:b0:7e3:4416:fd6 with SMTP id
 af79cd13be357-7e9f3472388mr146478585a.61.1755566145274; 
 Mon, 18 Aug 2025 18:15:45 -0700 (PDT)
Received: from [10.36.251.101]
 (wn-campus-nat-129-97-124-101.dynamic.uwaterloo.ca. [129.97.124.101])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70ba9370894sm61281446d6.59.2025.08.18.18.15.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Aug 2025 18:15:44 -0700 (PDT)
Message-ID: <a76de187-f181-47d3-a36e-6eb1a865cc5e@gmail.com>
Date: Mon, 18 Aug 2025 21:15:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] fuse: add FUSE-over-io_uring enable opt and init
To: Bernd Schubert <bernd@bsbernd.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, fam@euphon.net,
 hreitz@redhat.com, kwolf@redhat.com, stefanha@redhat.com
References: <20250815034619.51980-1-hizhisong@gmail.com>
 <20250815034619.51980-2-hizhisong@gmail.com>
 <beb43845-a761-4031-a7b7-aaca56abb6de@gmail.com>
 <105d583b-e931-4e60-a113-9a571c18c726@bsbernd.com>
Content-Language: en-US
From: Brian Song <hibriansong@gmail.com>
In-Reply-To: <105d583b-e931-4e60-a113-9a571c18c726@bsbernd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::729;
 envelope-from=hibriansong@gmail.com; helo=mail-qk1-x729.google.com
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



On 8/18/25 7:04 PM, Bernd Schubert wrote:
> 
> 
> On 8/17/25 01:13, Brian Song wrote:
>>
>>
>> On 8/14/25 11:46 PM, Brian Song wrote:
>>> From: Brian Song <hibriansong@gmail.com>
>>>
>>> This patch adds a new export option for storage-export-daemon to enable
>>> or disable FUSE-over-io_uring via the switch io-uring=on|off (disable
>>> by default). It also implements the protocol handshake with the Linux
>>> kernel during the FUSE-over-io_uring initialization phase.
>>>
>>> See: https://docs.kernel.org/filesystems/fuse-io-uring.html
>>>
>>> The kernel documentation describes in detail how FUSE-over-io_uring
>>> works. This patch implements the Initial SQE stage shown in thediagram:
>>> it initializes one queue per IOThread, each currently supporting a
>>> single submission queue entry (SQE). When the FUSE driver sends the
>>> first FUSE request (FUSE_INIT), storage-export-daemon calls
>>> fuse_uring_start() to complete initialization, ultimately submitting
>>> the SQE with the FUSE_IO_URING_CMD_REGISTER command to confirm
>>> successful initialization with the kernel.
>>>
>>> Suggested-by: Kevin Wolf <kwolf@redhat.com>
>>> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> Signed-off-by: Brian Song <hibriansong@gmail.com>
>>> ---
>>>    block/export/fuse.c                  | 161 ++++++++++++++++++++++++---
>>>    docs/tools/qemu-storage-daemon.rst   |  11 +-
>>>    qapi/block-export.json               |   5 +-
>>>    storage-daemon/qemu-storage-daemon.c |   1 +
>>>    util/fdmon-io_uring.c                |   5 +-
>>>    5 files changed, 159 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/block/export/fuse.c b/block/export/fuse.c
>>> index c0ad4696ce..59fa79f486 100644
>>> --- a/block/export/fuse.c
>>> +++ b/block/export/fuse.c
>>> @@ -48,6 +48,11 @@
>>>    #include <linux/fs.h>
>>>    #endif
>>>
>>> +#define FUSE_DEFAULT_MAX_PAGES_PER_REQ 32
>>> +
>>> +/* room needed in buffer to accommodate header */
>>> +#define FUSE_BUFFER_HEADER_SIZE 0x1000
>>> +
>>>    /* Prevent overly long bounce buffer allocations */
>>>    #define FUSE_MAX_READ_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 1 * 1024 * 1024))
>>>    /*
>>> @@ -63,12 +68,31 @@
>>>        (FUSE_MAX_WRITE_BYTES - FUSE_IN_PLACE_WRITE_BYTES)
>>>
>>>    typedef struct FuseExport FuseExport;
>>> +typedef struct FuseQueue FuseQueue;
>>> +
>>> +typedef struct FuseRingEnt {
>>> +    /* back pointer */
>>> +    FuseQueue *q;
>>> +
>>> +    /* commit id of a fuse request */
>>> +    uint64_t req_commit_id;
>>> +
>>> +    /* fuse request header and payload */
>>> +    struct fuse_uring_req_header req_header;
>>> +    void *op_payload;
>>> +    size_t req_payload_sz;
>>> +
>>> +    /* The vector passed to the kernel */
>>> +    struct iovec iov[2];
>>> +
>>> +    CqeHandler fuse_cqe_handler;
>>> +} FuseRingEnt;
>>>
>>>    /*
>>>     * One FUSE "queue", representing one FUSE FD from which requests are fetched
>>>     * and processed.  Each queue is tied to an AioContext.
>>>     */
>>> -typedef struct FuseQueue {
>>> +struct FuseQueue {
>>>        FuseExport *exp;
>>>
>>>        AioContext *ctx;
>>> @@ -109,7 +133,12 @@ typedef struct FuseQueue {
>>>         * Free this buffer with qemu_vfree().
>>>         */
>>>        void *spillover_buf;
>>> -} FuseQueue;
>>> +
>>> +#ifdef CONFIG_LINUX_IO_URING
>>> +    int qid;
>>> +    FuseRingEnt ent;
>>> +#endif
>>> +};
>>>
>>>    /*
>>>     * Verify that FuseQueue.request_buf plus the spill-over buffer together
>>> @@ -148,6 +177,7 @@ struct FuseExport {
>>>        bool growable;
>>>        /* Whether allow_other was used as a mount option or not */
>>>        bool allow_other;
>>> +    bool is_uring;
>>>
>>>        mode_t st_mode;
>>>        uid_t st_uid;
>>> @@ -257,6 +287,93 @@ static const BlockDevOps fuse_export_blk_dev_ops = {
>>>        .drained_poll  = fuse_export_drained_poll,
>>>    };
>>>
>>> +#ifdef CONFIG_LINUX_IO_URING
>>> +
>>> +static void fuse_uring_sqe_set_req_data(struct fuse_uring_cmd_req *req,
>>> +                    const unsigned int qid,
>>> +                    const unsigned int commit_id)
>>> +{
>>> +    req->qid = qid;
>>> +    req->commit_id = commit_id;
>>> +    req->flags = 0;
>>> +}
>>> +
>>> +static void fuse_uring_sqe_prepare(struct io_uring_sqe *sqe, FuseQueue *q,
>>> +               __u32 cmd_op)
>>> +{
>>> +    sqe->opcode = IORING_OP_URING_CMD;
>>> +
>>> +    sqe->fd = q->fuse_fd;
>>> +    sqe->rw_flags = 0;
>>> +    sqe->ioprio = 0;
>>> +    sqe->off = 0;
>>> +
>>> +    sqe->cmd_op = cmd_op;
>>> +    sqe->__pad1 = 0;
>>> +}
>>> +
>>> +static void fuse_uring_prep_sqe_register(struct io_uring_sqe *sqe, void *opaque)
>>> +{
>>> +    FuseQueue *q = opaque;
>>> +    struct fuse_uring_cmd_req *req = (void *)&sqe->cmd[0];
>>> +
>>> +    fuse_uring_sqe_prepare(sqe, q, FUSE_IO_URING_CMD_REGISTER);
>>> +
>>> +    sqe->addr = (uint64_t)(q->ent.iov);
>>> +    sqe->len = 2;
>>> +
>>> +    fuse_uring_sqe_set_req_data(req, q->qid, 0);
>>> +}
>>> +
>>> +static void fuse_uring_submit_register(void *opaque)
>>> +{
>>> +    FuseQueue *q = opaque;
>>> +    FuseExport *exp = q->exp;
>>> +
>>> +
>>> +    aio_add_sqe(fuse_uring_prep_sqe_register, q, &(q->ent.fuse_cqe_handler));
>>
>> I think there might be a tricky issue with the io_uring integration in
>> QEMU. Currently, when the number of IOThreads goes above ~6 or 7,
>> there’s a pretty high chance of a hang. I added some debug logging in
>> the kernel’s fuse_uring_cmd() registration part, and noticed that the
>> number of register calls is less than the total number of entries in the
>> queue. In theory, we should be registering each entry for each queue.
> 
> Did you also try to add logging at the top of fuse_uring_cmd()? I wonder
> if there is a start up race and if initial commands are just getting
> refused. I had run into issues you are describing in some versions of
> the -rfc patches, but thought that everything was fixed for that.
> I.e. not excluded that there is still a kernel issue left.
> 
> Thanks,
> Bernd
> 
> 

Yes. I added a printk at the beginning of fuse_uring_cmd(), another at 
the beginning of fuse_uring_register(), and one more at the end of 
fuse_uring_do_register(). Then I created and registered 20 queues, each 
with a single ring entry. It printed 37 times(diff every time) with 
opcode FUSE_IO_URING_CMD_REGISTER (would expect 20), and only 6 queues 
were registered successfully. The rest of fuse_uring_cmd (x31) exited 
inside the if (!fc->initialized) branch in fuse_uring_cmd()

dmesg: https://gist.github.com/hibriansong/4eda6e7e92601df497282dcd56fd5470

Thanks,
Brian

