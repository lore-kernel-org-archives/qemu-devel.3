Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1BDE63C96
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Jan 2026 09:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjwIi-0003pB-1F; Sun, 25 Jan 2026 04:20:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1vjwIW-0003o9-G5
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 04:20:44 -0500
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1vjwIR-0007kC-8n
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 04:20:43 -0500
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-404308dd5d6so1240491fac.1
 for <qemu-devel@nongnu.org>; Sun, 25 Jan 2026 01:20:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769332833; cv=none;
 d=google.com; s=arc-20240605;
 b=KS4UD0WyQW7AYMN4xGecamnEIsKzJcyl1brL1J6jEnBLUz9P+boac0TMBDQxmGCOKA
 bqMMZrHzNhlpUinDqi9pkwJoxFwjstlmo4K1ef1UsONwAsy56H8ADj7g1H4NLGGCdjbJ
 RQCL+Szy/XRqrJ8rtvKL086J8h2XY3ph/QNfk2UD+JbW6b/mas1a4HGGWvW/UVEcUhoK
 qjEjrhUS2n1kifl6q8zxsHfvwGq86MIczMVqQwol/d8eX4UpVLtHB7EkNf9GcXRwVtXg
 Jn0zcEuPCXK/uMtycaoDhx2VDMah3memst8gcNCAKlE7nVwPhKimFcNbsMgn8LiRG+sL
 /S7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=e3EM9KNIYYfidv2JH7N+rSpr4+4/NlR2c5zII+XXnI4=;
 fh=6p906Df7r+MQxU0jbrPgqhGjy2rPoD/nQOHACRfPVds=;
 b=jftSH5cC1ik6RpMaeQ69B8H6ilev0YEwebKCIgut7IIEXlMnTeTby/n1scEFP5Hmd1
 SOUM1NRlGnPxjchYwsLSOjF419v5DWW3dx1lrOtvJl2+IjmVFfolDjD6B9i3tTK7DzYo
 xJEx3fSoRnAtujBeEgu5ks0PBGFvM6Kgxh7lT7cqkooiCjd/MEdd2q0ceaDjOnG3fNq3
 eKE3GvHEUOnv1U3e7N7pvKkSNHspAjitFfxtSGvU2V0/f3R04OxWQ+7FTHwaj9eFGBdh
 g24OHtJc/4aLwE8FgChVQbeJikSGU6Z3xbGc8iulnG4otbHtah3BqKlHXF0uRnfY0X33
 vEFg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769332833; x=1769937633; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e3EM9KNIYYfidv2JH7N+rSpr4+4/NlR2c5zII+XXnI4=;
 b=KO1/TJeNDdeW29bGaaTwVGP1EMm2cVPlXPDXrxbQZmfe1B5U4g1obza4oWPxIP9OLv
 kMQl7a9tJft3y/F/aKn1EuVCGH2HaHuBOmYlxcKZEvpEPYNIt+yXSXKg4sNdMK+FZcs+
 6nNBWLikvhlDtwAHr7MA7+M8KHj/SRuYQDZDjw/mBnbqYoOk5uXDgdobM9YrYIRhEozd
 6/rvUKBJTStUhACqTgo0VJjmyJWB5YrH+BT0M3JHAoAXTiRViVOBLAYheaZzfeziZOxS
 Nt4muys4KbkH/MWW+LOCnXYA14hDB9MZpTuoyC3Sv/QAVDYZkKzbIcRR89pW0/rGmOyk
 ySpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769332833; x=1769937633;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e3EM9KNIYYfidv2JH7N+rSpr4+4/NlR2c5zII+XXnI4=;
 b=N7TPBC4P0Msqes8O5eHS6toNV+nboS0b+edBPPm/vSaCM3XFd0SAXzegJ1/LLac47a
 6qI7dqLzwiwkXaVuaNXHK16QtRVoGC8WsEGj3VHCYVMXBzQdTZ1z4RkJlSbHRTry+Dab
 ReRHMHjBpGfQZwViJU/2YkAxr/v3vlYeMzya9fZUD9C1pI4pujENxGhx0t/zFve+zNT4
 /Q4G8c4l7i6yTOKFj9DWGV9QZ7e2MXyKoHssIfKQZlkIg8TXKFyJ14vYtO3ICmseE3rw
 ShDIAWYKcvew1Y0r6MyzjSQfPLUclKuw3f/vZVz/EP62ciOJ6Q5dX1TS1DTUti679ydD
 009g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJIxXaXskh51vSd+/9dNrlfnQuCJQBPNrxYSMjv3cTI5egI1YHdrdsmjEwprMYNW07UM87+P69ZZOt@nongnu.org
X-Gm-Message-State: AOJu0YzeoBHBbOf1kuWD4U8zBzAPnl7B07frAPvNy+WUP1Pf5OT9dmqa
 SyNbSlyxPk7SuWK7LsesUdhK1ZdJFcvmSnqEvKoy8ibTaSMj1dWq0XX0pgXtTtf+/ckqz51Hy/1
 hXoyF2NvoJWZE+PSXXKLvAsW3E6jnVTo=
X-Gm-Gg: AZuq6aJns5VjQDUZ+LAgJrpn2NYA0hYm/GMfKAiiLQtH+RMrrCXUAARcNcFeEj/AOpl
 7hNtzklsC2hW0ZtlS4ph6z0D9H9VfvBN3AtrN0f7PUyx6T+TabdPYoz7hCLgBlpQoIDxj+LA9nu
 6KDV94QmRrqFlXfsq381AStPg29x1b4DWGADio8TVnMjFhsK9ldnj3Z0hYgEIQ7DOU2QQWfdIo3
 XCX/0bOPVirJETdN1q107Zfvaho1QhY/LE9D8MqOFb3jyXKhbv9l+AaslEKL2sSwOi9DdYsDKOl
 dLFf
X-Received: by 2002:a4a:e908:0:b0:65d:4d4:e7c0 with SMTP id
 006d021491bc7-662e0466624mr522615eaf.54.1769332832702; Sun, 25 Jan 2026
 01:20:32 -0800 (PST)
MIME-Version: 1.0
References: <20250830025025.3610-1-hibriansong@gmail.com>
 <20250830025025.3610-3-hibriansong@gmail.com>
 <aM1gbPaNMv50mPf-@redhat.com>
In-Reply-To: <aM1gbPaNMv50mPf-@redhat.com>
From: Brian Song <hibriansong@gmail.com>
Date: Sun, 25 Jan 2026 17:20:21 +0800
X-Gm-Features: AZwV_QhWqunCFJuAtQvWkQUEZrwPlV2BEDZy_MSQPwMEweuz4phqfqtkGcnZe54
Message-ID: <CAKWCU7WjspVxfVVS94QJjPAgAdTYSwQPE=Jf5nkmtOo7YOB9Og@mail.gmail.com>
Subject: Re: [PATCH 2/4] export/fuse: process FUSE-over-io_uring requests
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com, 
 bernd@bsbernd.com, fam@euphon.net, hreitz@redhat.com, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=hibriansong@gmail.com; helo=mail-oa1-x31.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Fri, Sep 19, 2025 at 9:54=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> wrote=
:
>
> Am 30.08.2025 um 04:50 hat Brian Song geschrieben:
> > https://docs.kernel.org/filesystems/fuse-io-uring.html
> >
> > As described in the kernel documentation, after FUSE-over-io_uring
> > initialization and handshake, FUSE interacts with the kernel using
> > SQE/CQE to send requests and receive responses. This corresponds to
> > the "Sending requests with CQEs" section in the docs.
> >
> > This patch implements three key parts: registering the CQE handler
> > (fuse_uring_cqe_handler), processing FUSE requests (fuse_uring_co_
> > process_request), and sending response results (fuse_uring_send_
> > response). It also merges the traditional /dev/fuse request handling
> > with the FUSE-over-io_uring handling functions.
> >
> > Suggested-by: Kevin Wolf <kwolf@redhat.com>
> > Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Brian Song <hibriansong@gmail.com>
>
> A general remark first: I think this would be easier to review if it
> were split into multiple patches. For example, at the first sight it
> looks to me like I'd split at least:
>
> - Factor out fuse_co_process_request_common() from
>   fuse_co_process_request(). This would be a pure code movement patch
>   with no intention to change the behaviour (i.e. it doesn't add any
>   io_uring code yet). It is very common to have such refactoring commits
>   in preparation for the addition of a new feature later.
>
> - Change fuse_co_write() to allow a NULL in_place_buf
>
> - Add io_uring request processing
>
> All three are logically independent changes and can be reviewed on their
> own. Maybe further splitting is possible that would only become obvious
> when looking at the smaller patches.
>
> >  block/export/fuse.c | 457 ++++++++++++++++++++++++++++++--------------
> >  1 file changed, 309 insertions(+), 148 deletions(-)
> >
> > diff --git a/block/export/fuse.c b/block/export/fuse.c
> > index 19bf9e5f74..07f74fc8ec 100644
> > --- a/block/export/fuse.c
> > +++ b/block/export/fuse.c
> > @@ -310,6 +310,47 @@ static const BlockDevOps fuse_export_blk_dev_ops =
=3D {
> >  };
> >
> >  #ifdef CONFIG_LINUX_IO_URING
> > +static void coroutine_fn fuse_uring_co_process_request(FuseRingEnt *en=
t);
> > +
> > +static void coroutine_fn co_fuse_uring_queue_handle_cqes(void *opaque)
> > +{
> > +    FuseRingEnt *ent =3D opaque;
> > +    FuseExport *exp =3D ent->rq->q->exp;
> > +
> > +    /* Going to process requests */
> > +    fuse_inc_in_flight(exp);
>
> I think this can be too late. The in_flight counter must be increased
> before we start processing something that must be waited for in a drain.
> Can't it happen here that a drain in the main thread already returns
> while the CQE is still pending in an iothread, but nothing stops it from
> being processed and starting new requests even though we're supossedly
> in a drained section now?
>

Yes, you are right. Incrementing in_flight inside the coroutine
introduces a race window where the main thread drain could return
early while a CQE is pending but the coroutine hasn't started yet. I
moved fuse_inc_in_flight() into fuse_uring_cqe_handler() right before
qemu_coroutine_enter(), and also added comments on it.


> > +    /* A ring entry returned */
> > +    fuse_uring_co_process_request(ent);
> > +
> > +    /* Finished processing requests */
> > +    fuse_dec_in_flight(exp);
> > +}
> > +
> > +static void fuse_uring_cqe_handler(CqeHandler *cqe_handler)
> > +{
> > +    FuseRingEnt *ent =3D container_of(cqe_handler, FuseRingEnt, fuse_c=
qe_handler);
> > +    Coroutine *co;
> > +    FuseExport *exp =3D ent->rq->q->exp;
> > +
> > +    if (unlikely(exp->halted)) {
> > +        return;
> > +    }
> > +
> > +    int err =3D cqe_handler->cqe.res;
> > +
> > +    if (err !=3D 0) {
> > +        /* -ENOTCONN is ok on umount  */
> > +        if (err !=3D -EINTR && err !=3D -EAGAIN &&
> > +            err !=3D -ENOTCONN) {
>
> This fits on a single line (but I think the result was that you'll
> remove some error codes anway).
>
> > +            fuse_export_halt(exp);
> > +        }
> > +    } else {
> > +        co =3D qemu_coroutine_create(co_fuse_uring_queue_handle_cqes, =
ent);
> > +        qemu_coroutine_enter(co);
> > +    }
> > +}
> > +
> >  static void fuse_uring_sqe_set_req_data(struct fuse_uring_cmd_req *req=
,
> >                      const unsigned int rqid,
> >                      const unsigned int commit_id)
> > @@ -1213,6 +1254,9 @@ fuse_co_read(FuseExport *exp, void **bufptr, uint=
64_t offset, uint32_t size)
> >   * Data in @in_place_buf is assumed to be overwritten after yielding, =
so will
> >   * be copied to a bounce buffer beforehand.  @spillover_buf in contras=
t is
> >   * assumed to be exclusively owned and will be used as-is.
> > + * In FUSE-over-io_uring mode, the actual op_payload content is stored=
 in
> > + * @spillover_buf. To ensure this buffer is used for writing, @in_plac=
e_buf
> > + * is explicitly set to NULL.
> >   * Return the number of bytes written to *out on success, and -errno o=
n error.
> >   */
> >  static ssize_t coroutine_fn
> > @@ -1220,8 +1264,8 @@ fuse_co_write(FuseExport *exp, struct fuse_write_=
out *out,
> >                uint64_t offset, uint32_t size,
> >                const void *in_place_buf, const void *spillover_buf)
> >  {
> > -    size_t in_place_size;
> > -    void *copied;
> > +    size_t in_place_size =3D 0;
> > +    void *copied =3D NULL;
> >      int64_t blk_len;
> >      int ret;
> >      struct iovec iov[2];
> > @@ -1236,10 +1280,12 @@ fuse_co_write(FuseExport *exp, struct fuse_writ=
e_out *out,
> >          return -EACCES;
> >      }
> >
> > -    /* Must copy to bounce buffer before potentially yielding */
> > -    in_place_size =3D MIN(size, FUSE_IN_PLACE_WRITE_BYTES);
> > -    copied =3D blk_blockalign(exp->common.blk, in_place_size);
> > -    memcpy(copied, in_place_buf, in_place_size);
> > +    if (in_place_buf) {
> > +        /* Must copy to bounce buffer before potentially yielding */
> > +        in_place_size =3D MIN(size, FUSE_IN_PLACE_WRITE_BYTES);
> > +        copied =3D blk_blockalign(exp->common.blk, in_place_size);
> > +        memcpy(copied, in_place_buf, in_place_size);
> > +    }
> >
> >      /**
> >       * Clients will expect short writes at EOF, so we have to limit
> > @@ -1263,26 +1309,38 @@ fuse_co_write(FuseExport *exp, struct fuse_writ=
e_out *out,
> >          }
> >      }
> >
> > -    iov[0] =3D (struct iovec) {
> > -        .iov_base =3D copied,
> > -        .iov_len =3D in_place_size,
> > -    };
> > -    if (size > FUSE_IN_PLACE_WRITE_BYTES) {
> > -        assert(size - FUSE_IN_PLACE_WRITE_BYTES <=3D FUSE_SPILLOVER_BU=
F_SIZE);
> > -        iov[1] =3D (struct iovec) {
> > -            .iov_base =3D (void *)spillover_buf,
> > -            .iov_len =3D size - FUSE_IN_PLACE_WRITE_BYTES,
> > +    if (in_place_buf) {
> > +        iov[0] =3D (struct iovec) {
> > +            .iov_base =3D copied,
> > +            .iov_len =3D in_place_size,
> >          };
> > -        qemu_iovec_init_external(&qiov, iov, 2);
> > +        if (size > FUSE_IN_PLACE_WRITE_BYTES) {
> > +            assert(size - FUSE_IN_PLACE_WRITE_BYTES <=3D FUSE_SPILLOVE=
R_BUF_SIZE);
> > +            iov[1] =3D (struct iovec) {
> > +                .iov_base =3D (void *)spillover_buf,
> > +                .iov_len =3D size - FUSE_IN_PLACE_WRITE_BYTES,
> > +            };
> > +            qemu_iovec_init_external(&qiov, iov, 2);
> > +        } else {
> > +            qemu_iovec_init_external(&qiov, iov, 1);
> > +        }
> >      } else {
> > +        /* fuse over io_uring */
> > +        iov[0] =3D (struct iovec) {
> > +            .iov_base =3D (void *)spillover_buf,
> > +            .iov_len =3D size,
> > +        };
> >          qemu_iovec_init_external(&qiov, iov, 1);
> >      }
> > +
> >      ret =3D blk_co_pwritev(exp->common.blk, offset, size, &qiov, 0);
> >      if (ret < 0) {
> >          goto fail_free_buffer;
> >      }
> >
> > -    qemu_vfree(copied);
> > +    if (in_place_buf) {
> > +        qemu_vfree(copied);
> > +    }
> >
> >      *out =3D (struct fuse_write_out) {
> >          .size =3D size,
> > @@ -1290,7 +1348,9 @@ fuse_co_write(FuseExport *exp, struct fuse_write_=
out *out,
> >      return sizeof(*out);
> >
> >  fail_free_buffer:
> > -    qemu_vfree(copied);
> > +    if (in_place_buf) {
> > +        qemu_vfree(copied);
> > +    }
> >      return ret;
> >  }
> >
> > @@ -1578,173 +1638,151 @@ static int fuse_write_buf_response(int fd, ui=
nt32_t req_id,
> >      }
> >  }
> >
> > -/*
> > - * For use in fuse_co_process_request():
> > - * Returns a pointer to the parameter object for the given operation (=
inside of
> > - * queue->request_buf, which is assumed to hold a fuse_in_header first=
).
> > - * Verifies that the object is complete (queue->request_buf is large e=
nough to
> > - * hold it in one piece, and the request length includes the whole obj=
ect).
> > - *
> > - * Note that queue->request_buf may be overwritten after yielding, so =
the
> > - * returned pointer must not be used across a function that may yield!
> > - */
> > -#define FUSE_IN_OP_STRUCT(op_name, queue) \
> > +#define FUSE_IN_OP_STRUCT_LEGACY(in_buf) \
> >      ({ \
> > -        const struct fuse_in_header *__in_hdr =3D \
> > -            (const struct fuse_in_header *)(queue)->request_buf; \
> > -        const struct fuse_##op_name##_in *__in =3D \
> > -            (const struct fuse_##op_name##_in *)(__in_hdr + 1); \
> > -        const size_t __param_len =3D sizeof(*__in_hdr) + sizeof(*__in)=
; \
> > -        uint32_t __req_len; \
> > -        \
> > -        QEMU_BUILD_BUG_ON(sizeof((queue)->request_buf) < __param_len);=
 \
> > -        \
> > -        __req_len =3D __in_hdr->len; \
> > -        if (__req_len < __param_len) { \
> > -            warn_report("FUSE request truncated (%" PRIu32 " < %zu)", =
\
> > -                        __req_len, __param_len); \
> > -            ret =3D -EINVAL; \
> > -            break; \
> > -        } \
>
> This check made sure that we don't access in_buf out of bounds. What is
> the replacement for it?
>

In the previous patch series, we split the request processing for
Traditional FUSE and FUSE-over-io_uring into two separate functions.
This made it easy to use FUSE_IN_OP_STRUCT(op_name, queue) in the
Traditional path. We just manually passed the op_name string and queue
for each opcode to handle checks.

However, since we discussed merging these two processing functions, we
are now extracting the op_in_buf and op_out_buf for both modes right
at the start of the function.

If we want to keep the overflow checks in FUSE_IN_OP_STRUCT_LEGACY, we
have two options:

1. Pass the opcode into FUSE_IN_OP_STRUCT_LEGACY and check the size of
fuse_##op_name##_in by implementing switch cases.
2. Or instead of fetching buffers globally at the start, we handle the
buffer extraction (for both Traditional and Uring) inside every single
opcode case in process function. This would allow us to reuse Hanna's
FUSE_IN_OP_STRUCT(op_name, queue).

But here's the thing: If we have to add a switch case in
FUSE_IN_OP_STRUCT_LEGACY to check sizeof((queue)->request_buf) >=3D
__param_len, it means updating two places (the process function and
the legacy struct) for every new operation. And if we end up branching
off for Traditional vs. Uring inside every opcode just to reuse
FUSE_IN_OP_STRUCT, why merge the functions? Wouldn't keeping them
separate be much cleaner?

My current idea is to handle the retrieval of operation-specific
in/out buffers (struct fuse_##op_name##_in) for both modes inside each
individual operation block. This allows us to reuse Hanna's
FUSE_IN_OP_STRUCT(op_name, queue) for the traditional mode. Does it
make sense?

> > -        __in; \
> > +        (void *)(((struct fuse_in_header *)in_buf) + 1); \
> >      })
> >
> > -/*
> > - * For use in fuse_co_process_request():
> > - * Returns a pointer to the return object for the given operation (ins=
ide of
> > - * out_buf, which is assumed to hold a fuse_out_header first).
> > - * Verifies that out_buf is large enough to hold the whole object.
> > - *
> > - * (out_buf should be a char[] array.)
> > - */
> > -#define FUSE_OUT_OP_STRUCT(op_name, out_buf) \
> > +#define FUSE_OUT_OP_STRUCT_LEGACY(out_buf) \
> >      ({ \
> > -        struct fuse_out_header *__out_hdr =3D \
> > -            (struct fuse_out_header *)(out_buf); \
> > -        struct fuse_##op_name##_out *__out =3D \
> > -            (struct fuse_##op_name##_out *)(__out_hdr + 1); \
> > -        \
> > -        QEMU_BUILD_BUG_ON(sizeof(*__out_hdr) + sizeof(*__out) > \
> > -                          sizeof(out_buf)); \
> > -        \
> > -        __out; \
> > +        (void *)(((struct fuse_out_header *)out_buf) + 1); \
> >      })
> >
> > -/**
> > - * Process a FUSE request, incl. writing the response.
> > - *
> > - * Note that yielding in any request-processing function can overwrite=
 the
> > - * contents of q->request_buf.  Anything that takes a buffer needs to =
take
> > - * care that the content is copied before yielding.
> > - *
> > - * @spillover_buf can contain the tail of a write request too large to=
 fit into
> > - * q->request_buf.  This function takes ownership of it (i.e. will fre=
e it),
> > - * which assumes that its contents will not be overwritten by concurre=
nt
> > - * requests (as opposed to q->request_buf).
> > +
> > +/*
> > + * Shared helper for FUSE request processing. Handles both legacy and =
io_uring
> > + * paths.
> >   */
> > -static void coroutine_fn
> > -fuse_co_process_request(FuseQueue *q, void *spillover_buf)
> > +static void coroutine_fn fuse_co_process_request_common(
> > +    FuseExport *exp,
> > +    uint32_t opcode,
> > +    uint64_t req_id,
> > +    void *in_buf,
> > +    void *spillover_buf,
> > +    void *out_buf,
> > +    int fd, /* -1 for uring */
> > +    void (*send_response)(void *opaque, uint32_t req_id, ssize_t ret,
> > +                         const void *buf, void *out_buf),
> > +    void *opaque /* FuseQueue* or FuseRingEnt* */)
> >  {
> > -    FuseExport *exp =3D q->exp;
> > -    uint32_t opcode;
> > -    uint64_t req_id;
> > -    /*
> > -     * Return buffer.  Must be large enough to hold all return headers=
, but does
> > -     * not include space for data returned by read requests.
> > -     * (FUSE_IN_OP_STRUCT() verifies at compile time that out_buf is i=
ndeed
> > -     * large enough.)
> > -     */
> > -    char out_buf[sizeof(struct fuse_out_header) +
> > -                 MAX_CONST(sizeof(struct fuse_init_out),
> > -                 MAX_CONST(sizeof(struct fuse_open_out),
> > -                 MAX_CONST(sizeof(struct fuse_attr_out),
> > -                 MAX_CONST(sizeof(struct fuse_write_out),
> > -                           sizeof(struct fuse_lseek_out)))))];
> > -    struct fuse_out_header *out_hdr =3D (struct fuse_out_header *)out_=
buf;
> > -    /* For read requests: Data to be returned */
> >      void *out_data_buffer =3D NULL;
> > -    ssize_t ret;
> > +    ssize_t ret =3D 0;
> >
> > -    /* Limit scope to ensure pointer is no longer used after yielding =
*/
> > -    {
> > -        const struct fuse_in_header *in_hdr =3D
> > -            (const struct fuse_in_header *)q->request_buf;
> > +    void *op_in_buf =3D (void *)FUSE_IN_OP_STRUCT_LEGACY(in_buf);
> > +    void *op_out_buf =3D (void *)FUSE_OUT_OP_STRUCT_LEGACY(out_buf);
> >
> > -        opcode =3D in_hdr->opcode;
> > -        req_id =3D in_hdr->unique;
> > +#ifdef CONFIG_LINUX_IO_URING
> > +    if (opcode !=3D FUSE_INIT && exp->is_uring) {
>
> Maybe add a comment explaining that FUSE_INIT is always delivered
> through /dev/fuse, even if we want to enable io_uring?
>
> > +        op_in_buf =3D (void *)in_buf;
> > +        op_out_buf =3D (void *)out_buf;
> >      }
> > +#endif
> >
> >      switch (opcode) {
> >      case FUSE_INIT: {
> > -        const struct fuse_init_in *in =3D FUSE_IN_OP_STRUCT(init, q);
> > -        ret =3D fuse_co_init(exp, FUSE_OUT_OP_STRUCT(init, out_buf),
> > -                           in->max_readahead, in->flags);
> > +        const struct fuse_init_in *in =3D
> > +            (const struct fuse_init_in *)FUSE_IN_OP_STRUCT_LEGACY(in_b=
uf);
> > +
> > +        struct fuse_init_out *out =3D
> > +            (struct fuse_init_out *)FUSE_OUT_OP_STRUCT_LEGACY(out_buf)=
;
>
> FUSE_IN_OP_STRUCT_LEGACY() returns a void *, so the explicit casts are
> unnecessary. This applies to all of the commands below, too.
>
> > +
> > +        ret =3D fuse_co_init(exp, out, in->max_readahead, in);
> >          break;
> >      }
> >
> > -    case FUSE_OPEN:
> > -        ret =3D fuse_co_open(exp, FUSE_OUT_OP_STRUCT(open, out_buf));
> > +    case FUSE_OPEN: {
> > +        struct fuse_open_out *out =3D
> > +            (struct fuse_open_out *)op_out_buf;
> > +
> > +        ret =3D fuse_co_open(exp, out);
> >          break;
> > +    }
> >
> >      case FUSE_RELEASE:
> >          ret =3D 0;
> >          break;
> >
> >      case FUSE_LOOKUP:
> > -        ret =3D -ENOENT; /* There is no node but the root node */
> > +        ret =3D -ENOENT;
> >          break;
>
> Why are you removing the comment?
>

There were few places I accidentally deleted some comments during code clea=
nup

> >
> > -    case FUSE_GETATTR:
> > -        ret =3D fuse_co_getattr(exp, FUSE_OUT_OP_STRUCT(attr, out_buf)=
);
> > +    case FUSE_GETATTR: {
> > +        struct fuse_attr_out *out =3D
> > +            (struct fuse_attr_out *)op_out_buf;
> > +
> > +        ret =3D fuse_co_getattr(exp, out);
> >          break;
> > +    }
> >
> >      case FUSE_SETATTR: {
> > -        const struct fuse_setattr_in *in =3D FUSE_IN_OP_STRUCT(setattr=
, q);
> > -        ret =3D fuse_co_setattr(exp, FUSE_OUT_OP_STRUCT(attr, out_buf)=
,
> > -                              in->valid, in->size, in->mode, in->uid, =
in->gid);
> > +        const struct fuse_setattr_in *in =3D
> > +            (const struct fuse_setattr_in *)op_in_buf;
> > +
> > +        struct fuse_attr_out *out =3D
> > +            (struct fuse_attr_out *)op_out_buf;
> > +
> > +        ret =3D fuse_co_setattr(exp, out, in->valid, in->size, in->mod=
e,
> > +                              in->uid, in->gid);
> >          break;
> >      }
> >
> >      case FUSE_READ: {
> > -        const struct fuse_read_in *in =3D FUSE_IN_OP_STRUCT(read, q);
> > +        const struct fuse_read_in *in =3D
> > +            (const struct fuse_read_in *)op_in_buf;
> > +
> >          ret =3D fuse_co_read(exp, &out_data_buffer, in->offset, in->si=
ze);
> >          break;
> >      }
> >
> >      case FUSE_WRITE: {
> > -        const struct fuse_write_in *in =3D FUSE_IN_OP_STRUCT(write, q)=
;
> > -        uint32_t req_len;
> > -
> > -        req_len =3D ((const struct fuse_in_header *)q->request_buf)->l=
en;
> > -        if (unlikely(req_len < sizeof(struct fuse_in_header) + sizeof(=
*in) +
> > -                               in->size)) {
> > -            warn_report("FUSE WRITE truncated; received %zu bytes of %=
" PRIu32,
> > -                        req_len - sizeof(struct fuse_in_header) - size=
of(*in),
> > -                        in->size);
> > -            ret =3D -EINVAL;
> > -            break;
> > +        const struct fuse_write_in *in =3D
> > +            (const struct fuse_write_in *)op_in_buf;
> > +
> > +        struct fuse_write_out *out =3D
> > +            (struct fuse_write_out *)op_out_buf;
> > +
> > +#ifdef CONFIG_LINUX_IO_URING
> > +        if (!exp->is_uring) {
> > +#endif
>
> I wonder if it wouldn't be better to have exp->is_uring available even
> without CONFIG_LINUX_IO_URING, it would just always be false. It would
> be nice to avoid #ifdefs in the middle of the function if they aren't
> strictly necessary.
>
> > +            uint32_t req_len =3D ((const struct fuse_in_header *)in_bu=
f)->len;
> > +
> > +            if (unlikely(req_len < sizeof(struct fuse_in_header) + siz=
eof(*in) +
> > +                        in->size)) {
> > +                warn_report("FUSE WRITE truncated; received %zu bytes =
of %"
> > +                    PRIu32,
> > +                    req_len - sizeof(struct fuse_in_header) - sizeof(*=
in),
> > +                    in->size);
> > +                ret =3D -EINVAL;
> > +                break;
> > +            }
> > +#ifdef CONFIG_LINUX_IO_URING
> > +        } else {
> > +            assert(in->size <=3D
> > +                ((FuseRingEnt *)opaque)->req_header.ring_ent_in_out.pa=
yload_sz);
> >          }
> > +#endif
> >
> > -        /*
> > -         * poll_fuse_fd() has checked that in_hdr->len matches the num=
ber of
> > -         * bytes read, which cannot exceed the max_write value we set
> > -         * (FUSE_MAX_WRITE_BYTES).  So we know that FUSE_MAX_WRITE_BYT=
ES >=3D
> > -         * in_hdr->len >=3D in->size + X, so this assertion must hold.
> > -         */
> >          assert(in->size <=3D FUSE_MAX_WRITE_BYTES);
>
> Instead of deleting the comment explaining why this is true, can you
> just add a second paragraph explaining why it's true for io_uring, too?
>
> > -        /*
> > -         * Passing a pointer to `in` (i.e. the request buffer) is fine=
 because
> > -         * fuse_co_write() takes care to copy its contents before pote=
ntially
> > -         * yielding.
> > -         */
>
> Why did you delete this comment? It's still true.
>
> > -        ret =3D fuse_co_write(exp, FUSE_OUT_OP_STRUCT(write, out_buf),
> > -                            in->offset, in->size, in + 1, spillover_bu=
f);
> > +        const void *in_place_buf =3D in + 1;
> > +        const void *spill_buf =3D spillover_buf;
> > +
> > +#ifdef CONFIG_LINUX_IO_URING
> > +        if (exp->is_uring) {
> > +            in_place_buf =3D NULL;
> > +            spill_buf =3D out_buf;
> > +        }
> > +#endif
> > +
> > +        ret =3D fuse_co_write(exp, out, in->offset, in->size,
> > +                            in_place_buf, spill_buf);
> >          break;
> >      }
> >
> >      case FUSE_FALLOCATE: {
> > -        const struct fuse_fallocate_in *in =3D FUSE_IN_OP_STRUCT(fallo=
cate, q);
> > +        const struct fuse_fallocate_in *in =3D
> > +            (const struct fuse_fallocate_in *)op_in_buf;
> > +
> >          ret =3D fuse_co_fallocate(exp, in->offset, in->length, in->mod=
e);
> >          break;
> >      }
>
> Kevin
>

