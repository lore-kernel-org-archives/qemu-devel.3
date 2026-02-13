Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83C5EF48E6
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 08:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqojm-0005uY-Fc; Fri, 13 Feb 2026 03:41:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1vqojk-0005to-6o
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 03:41:16 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1vqoji-0000m5-9q
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 03:41:15 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-8230c2d3128so361126b3a.0
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 00:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770972072; x=1771576872; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y/gl3wRxyC5yZEKsnB8ArEFY4C0mZvX/qOmoKVtFSvg=;
 b=cCDu2Lv9mUxO9HzVN7AH+qlw2J+JUdP1Y3kZbZ6uNhSIA8J4iycjKSfWwXT7h3H0Yq
 9b6IFxnf59dUQvR5uR12lTsY3VYp/MsrrVQM/6wbW75Rf7cbFTsvfpcPiJ6036mhwsGW
 dMoJlnyMq58RO1jpo7zMb7/VAcMGGWVKpdnoJ0WkKnAOBqJslkgrwW2kxFm56Sl9ho2v
 6eXgpbNyx2UEIhuvKW9nhPyoQzGdKfq+fBZ64oKHHKJ6/HzjlFdgieVn/oe28hI6793X
 xQFywsmqZ0lAgYbQ3xAfZR8HZ17EsXA27T5F4purIyn5P4TkXhmM6XiKtra0en7m50i7
 dl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770972072; x=1771576872;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y/gl3wRxyC5yZEKsnB8ArEFY4C0mZvX/qOmoKVtFSvg=;
 b=vzcMI89bziSBHK1YI6010/Ai0ALHvXhbCUd8q520ZWztZybVu4ziltG730ejCAbOKd
 a8sU/lKm4rzZBFeTo20rGRcl+/nPpKp04xhVbZn84BGEVWdrFdHjwMiLxr/wOW+z4/LW
 5QvP2fNZeaqdIZwYDYrOCAs32sB6jMAZHUmBJmlWEjfTOCQEIQ9whUvLMRJGU54/9bY8
 coicKFRTwbrlXDthaMLidn2mHWcFxCEbscpaL4CiB+5KJaSS695+89mvUQwnfg5NSS/L
 IVCODUd5rVxGaCS8YYtfB0yzy2WsCtmWjvxFN+ve5nBMU0fa+lBItBTTtsVx+UYWB9ql
 GwKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWACfCSmvnkFU8z7EhPIHgCfivJbiqCTyDaQzzaW1oQ6Q5biVR+PVTglfEK17J3q/c9+2Mi856iTzjY@nongnu.org
X-Gm-Message-State: AOJu0YxJSw0rxXF920Qw0n1s27dNLYZT+J30mUK53nUgaHNkfE9QM80D
 KigTBk5TwWceHCdpVfnNyKowUjUCbCZ6Cr9dWsCft0CLZG66TNYKwINL
X-Gm-Gg: AZuq6aKX/l96d+95+q9rB0cJvHRveKtiEP0a6vqAaDSUFzlR6TWYkLJ9HhB5/6jsjr1
 u2YvVmdf7leinzenKdcGD0gP4OuTwGemTIMSFjJasOjjFcbsd9kLOJ9PoqyPFwG7MEPtMqDFS/4
 /Cz5PNWQs3xoREkTPGvwcGVuQ+XFee3l3YWcPUmcTidUVQtO1D6QJ5H7QCaDcnqKG/U5PQ0FkmU
 ku6jjsAggHB+2fvVl+LbzfBjlJjbq+IypxVlootItXumKj9vP5eOF+HDI4IHFty2Ads+GI8AZTh
 FtOvJPH0gdKVGMGhOf4mJajZeOLHGybAMIwHCH3dmW3hCLKMF+EO/jTtpQrfllXpmSSNFmIDGgw
 K8v3dkArXp4iDfIPy7t11NEyo1ebX+peGkhT0OHRzpiaY2gLnog7IaLpvMT7o2cLKSA4VafdHo9
 sD3FBkk3x4zmkALIcNQhCabhL1NgQJsZyB90Y2tfjKxo1PpCdgStiqNMhtiDh0qQ==
X-Received: by 2002:a05:6a20:e347:b0:35f:b243:46cb with SMTP id
 adf61e73a8af0-3946c6df211mr1133878637.12.1770972072444; 
 Fri, 13 Feb 2026 00:41:12 -0800 (PST)
Received: from smtpclient.apple (n119237241079.netvigator.com.
 [119.237.241.79]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6e197d74cdsm6584473a12.18.2026.02.13.00.41.09
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 13 Feb 2026 00:41:12 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [Patch v4 2/7] fuse: io_uring mode init
From: Brian Song <hibriansong@gmail.com>
In-Reply-To: <20260211205611.GB234157@fedora>
Date: Fri, 13 Feb 2026 16:40:37 +0800
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com, fam@euphon.net,
 bernd@bsbernd.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <54840DCC-9355-41B1-AD68-E1E3DC808D0F@gmail.com>
References: <20260207120901.17222-1-hibriansong@gmail.com>
 <20260207120901.17222-3-hibriansong@gmail.com>
 <20260211205611.GB234157@fedora>
To: Stefan Hajnoczi <stefanha@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=hibriansong@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



> On Feb 12, 2026, at 04:56, Stefan Hajnoczi <stefanha@redhat.com> =
wrote:
>=20
> On Sat, Feb 07, 2026 at 08:08:56PM +0800, Brian Song wrote:
>> +typedef struct FuseUringEnt {
>> +    /* back pointer */
>> +    FuseUringQueue *rq;
>> +
>> +    /* commit id of a fuse request */
>> +    uint64_t req_commit_id;
>=20
> This field is only read by fuse_uring_resubmit() in this patch, never
> assigned. Maybe some code later in the patch series should be squashed
> into this patch so that this field is initialized somewhere?
>=20

Yes, req_commit_id is assigned in fuse_uring_co_process_request(), so I =
left it empty in this patch.
For the same reason, I will probably keep fuse_uring_resubmit() empty =
for now and introduce req_commit_id later.

> Also, is it possible to drop req_commit_id and read from the existing
> req_header.ring_ent_in_out.commit_id field instead?

Of course. I just did the same as in libfuse.

Both members, req_commit_id and payload_sz, of struct fuse_ring_ent are =
already present in req_header, but we need to dereference multiple times =
to access them. That is probably why these duplicated members exist =
here.

I think I will remove req_commit_id and req_payload_sz from struct =
FuseUringEnt and add a comment indicating where they can be found.

>=20
>> +static void fuse_uring_cqe_handler(CqeHandler *cqe_handler)
>> +{
>> +    Coroutine *co;
>> +    FuseUringEnt *ent =3D
>> +        container_of(cqe_handler, FuseUringEnt, fuse_cqe_handler);
>> +    FuseExport *exp =3D ent->rq->q->exp;
>> +
>> +    if (unlikely(exp->halted)) {
>> +        return;
>=20
> Missing blk_exp_unref()?

Yes, missed one in this patch..

>=20
>> +    }
>> +
>> +    int err =3D cqe_handler->cqe.res;
>> +
>> +    if (unlikely(err !=3D 0)) {
>> +        switch (err) {
>> +        case -EAGAIN:
>> +        case -EINTR:
>> +            aio_add_sqe(fuse_uring_resubmit, ent, =
&ent->fuse_cqe_handler);
>> +            break;
>> +        case -ENOTCONN:
>> +            /* Connection already gone */
>> +            break;
>> +        default:
>> +            fuse_export_halt(exp);
>> +            break;
>> +        }
>> +
>> +        /* A uring entry returned */
>> +        blk_exp_unref(&exp->common);
>> +    } else {
>> +        co =3D qemu_coroutine_create(co_fuse_uring_queue_handle_cqe, =
ent);
>> +        /* Account this request as in-flight */
>> +        fuse_inc_in_flight(exp);
>> +        qemu_coroutine_enter(co);
>> +    }
>> +}
>> +
>> +static void
>> +fuse_uring_sqe_set_req_data(struct fuse_uring_cmd_req *req,
>> +                            const unsigned int rqid,
>> +                            const unsigned int commit_id)
>> +{
>> +    req->qid =3D rqid;
>> +    req->commit_id =3D commit_id;
>> +    req->flags =3D 0;
>> +}
>> +
>> +static void
>> +fuse_uring_sqe_prepare(struct io_uring_sqe *sqe, FuseQueue *q, __u32 =
cmd_op)
>> +{
>> +    sqe->opcode =3D IORING_OP_URING_CMD;
>> +
>> +    sqe->fd =3D q->fuse_fd;
>> +    sqe->rw_flags =3D 0;
>> +    sqe->ioprio =3D 0;
>> +    sqe->off =3D 0;
>> +
>> +    sqe->cmd_op =3D cmd_op;
>> +    sqe->__pad1 =3D 0;
>> +}
>> +
>> +static void fuse_uring_prep_sqe_register(struct io_uring_sqe *sqe, =
void *opaque)
>> +{
>> +    FuseUringEnt *ent =3D opaque;
>> +    struct fuse_uring_cmd_req *req =3D (void *)&sqe->cmd[0];
>> +
>> +    ent->last_cmd =3D FUSE_IO_URING_CMD_REGISTER;
>> +    fuse_uring_sqe_prepare(sqe, ent->rq->q, ent->last_cmd);
>> +
>> +    sqe->addr =3D (uint64_t)(ent->iov);
>> +    sqe->len =3D 2;
>> +
>> +    fuse_uring_sqe_set_req_data(req, ent->rq->rqid, 0);
>> +}
>> +
>> +static void fuse_uring_resubmit(struct io_uring_sqe *sqe, void =
*opaque)
>> +{
>> +    FuseUringEnt *ent =3D opaque;
>> +    struct fuse_uring_cmd_req *req =3D (void *)&sqe->cmd[0];
>> +
>> +    fuse_uring_sqe_prepare(sqe, ent->rq->q, ent->last_cmd);
>> +
>> +    switch (ent->last_cmd) {
>> +    case FUSE_IO_URING_CMD_REGISTER:
>> +        sqe->addr =3D (uint64_t)(ent->iov);
>> +        sqe->len =3D 2;
>> +        fuse_uring_sqe_set_req_data(req, ent->rq->rqid, 0);
>> +        break;
>> +    case FUSE_IO_URING_CMD_COMMIT_AND_FETCH:
>> +        fuse_uring_sqe_set_req_data(req, ent->rq->rqid, =
ent->req_commit_id);
>> +        break;
>> +    default:
>> +        error_report("Unknown command type: %d", ent->last_cmd);
>> +        break;
>> +    }
>> +}
>> +
>> +static void fuse_uring_submit_register(void *opaque)
>> +{
>> +    FuseUringQueue *rq =3D opaque;
>> +    FuseExport *exp =3D rq->q->exp;
>> +
>> +    for (int j =3D 0; j < exp->uring_queue_depth; j++) {
>> +        /* Register a uring entry */
>> +        blk_exp_ref(&exp->common);
>> +
>> +        aio_add_sqe(fuse_uring_prep_sqe_register, &rq->ent[j],
>> +                    &rq->ent[j].fuse_cqe_handler);
>> +    }
>> +}
>> +
>> +/**
>> + * Distribute uring queues across FUSE queues in the round-robin =
manner.
>> + * This ensures even distribution of kernel uring queues across =
user-specified
>> + * FUSE queues.
>> + *
>> + * num_uring_queues > num_fuse_queues: Each IOThread manages =
multiple uring
>> + * queues (multi-queue mapping).
>> + * num_uring_queues < num_fuse_queues: Excess IOThreads remain idle =
with no
>> + * assigned uring queues.
>> + */
>> +static void fuse_uring_setup_queues(FuseExport *exp, size_t bufsize)
>> +{
>> +    int num_uring_queues =3D get_nprocs_conf();
>> +
>> +    exp->num_uring_queues =3D num_uring_queues;
>> +    exp->uring_queues =3D g_new(FuseUringQueue, num_uring_queues);
>> +
>> +    for (int i =3D 0; i < num_uring_queues; i++) {
>> +        FuseUringQueue *rq =3D &exp->uring_queues[i];
>> +        rq->rqid =3D i;
>> +        rq->ent =3D g_new(FuseUringEnt, exp->uring_queue_depth);
>> +
>> +        for (int j =3D 0; j < exp->uring_queue_depth; j++) {
>> +            FuseUringEnt *ent =3D &rq->ent[j];
>> +            ent->rq =3D rq;
>> +            ent->req_payload_sz =3D bufsize - =
FUSE_BUFFER_HEADER_SIZE;
>> +            ent->req_payload =3D g_malloc0(ent->req_payload_sz);
>=20
> I don't see a corresponding g_free() in this patch? Exports can be
> deleted at runtime, so this memory must be freed.
>=20
>> +
>> +            ent->iov[0] =3D (struct iovec) {
>> +                &ent->req_header,
>> +                sizeof(struct fuse_uring_req_header)
>> +            };
>> +            ent->iov[1] =3D (struct iovec) {
>> +                ent->req_payload,
>> +                ent->req_payload_sz
>> +            };
>> +
>> +            ent->fuse_cqe_handler.cb =3D fuse_uring_cqe_handler;
>> +        }
>> +
>> +        /* Distribute uring queues across FUSE queues */
>> +        rq->q =3D &exp->queues[i % exp->num_fuse_queues];
>> +        QLIST_INSERT_HEAD(&(rq->q->uring_queue_list), rq, next);
>> +    }
>> +}
>> +
>> +static void
>> +fuse_schedule_ring_queue_registrations(FuseExport *exp)
>> +{
>> +    for (int i =3D 0; i < exp->num_fuse_queues; i++) {
>> +        FuseQueue *q =3D &exp->queues[i];
>> +        FuseUringQueue *rq;
>> +
>> +        QLIST_FOREACH(rq, &q->uring_queue_list, next) {
>> +            aio_bh_schedule_oneshot(q->ctx, =
fuse_uring_submit_register, rq);
>> +        }
>> +    }
>> +}
>> +
>> +static void fuse_uring_start(FuseExport *exp, struct fuse_init_out =
*out)
>> +{
>> +    assert(!exp->uring_started);
>> +    exp->uring_started =3D true;
>> +
>> +    /*
>> +     * Since we dont't enable the FUSE_MAX_PAGES feature, the value =
of
>=20
> s/dont't/don't/


