Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27C6EF48DC
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 08:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqoEa-0006tq-0Z; Fri, 13 Feb 2026 03:09:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1vqoEV-0006tG-80
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 03:08:59 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1vqoEL-00018x-LL
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 03:08:54 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2a7a9b8ed69so5965025ad.2
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 00:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770970126; x=1771574926; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NoNFQzZguoBozaim5Zq7oYqZHrw6zkAgeub8l9bROmE=;
 b=enrbRv6CwFlgw2xRnuWtDngYW6r3sIwqTxKl5+0BvwJbtJz7DyAqnMNQfjhO/ut7ou
 EjSdGbx8Chcg+xVAOedYQIE2xlh3s3/xKr2ggdQy4twIG2AYrVGzzjNpqkuT6IuHpflF
 5qYNj4uj8/OIjRPKtU7dXCgs1fBWoJlIWiS9iRBO9lJ97CvUtsBUl+VAoePmooJYwXuL
 evjVhhSIio9NN6Aqfao05K0/Pd34EHxYDaxL6s3sIBBQux/QxcVXGnPc+6ECEINwsbZJ
 xD/oc2FHSHnlF89vx8a1XK+3yCvETIj4HTxNi6G4fYOr+tyg4NbDgnp1sNxzSFBEluFK
 bcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770970126; x=1771574926;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NoNFQzZguoBozaim5Zq7oYqZHrw6zkAgeub8l9bROmE=;
 b=jMn0OdQIcwcZRv+yyEETXgBalyY5MTXQL+qekGv2ej834M+pfL33yolo6TXg85s35r
 uVP3fpFsgEpOPVUkEP+tZa/SUlYDHsnay1BmpVZX/2WYlJCHJ9wZo2gEsMLm0WYnHHT6
 UDJSsQnqDBSCyAB9ICrmQX+EpjkqeZwao/UMcT5eoFE2WzTanrEiev57ZL42GEQ0oBLK
 4QX7Ngg8OXe0q4icVI6P3kFwr/SULpfQsh665DWZxuiTN0bnkorjNPyfLee3zeonSzsV
 5VKS1smJqondv7UiS9beeyAPrdDJqxdh464tAjENR8dzFoJK76K6zAwXg978SU0O3LGs
 fXHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPscv5MySjr4c3m62vDNZCEOq+mo8keGeTXDk5sB9aAlt1ZSWLfKtR28lZA8ig15HNwCYbmjxi7Hys@nongnu.org
X-Gm-Message-State: AOJu0YxIfFyZ0bnWAEcJvXh0CKsdb2rxM+3W24TJEQ+ZAlIvg534WiND
 0vuTCk/JFKI6O8PjTADWFR/j3Z1rG61Cizwi1M/x99OxiaPan/o3j14y
X-Gm-Gg: AZuq6aJ2IJxzRw8dDn9qKAQWHD+HEXpgX5OtP07y3oXpZ/CdJnmgjg0jJ9IPYEncJOg
 XccaiIKck5zwMRMmBgUSf5VlfNia0d2CmEDra5Shj6xbH3GkVYohaEuiMX4UpvoTV75IGAP71mA
 kYl+iUTk1EKx6QwnJ5TOfRh2D0EhukG9OQHgMkCkYjMSNq3x0HHyH5glgjl06wJV4UKBS4IV6wm
 jv1UTaLe9laexskxs5uwIKYriOiKxHggBDo/Pg2K2BDCA1K8ngRWkFQwNIMN+XEavDVrlYIpgOY
 QSoY8BEqxXOF3urXxT0EAfOyJdVpLblauvVUBKZp6NY7Z2RuuywKO5X1cV7469kFfjt7trxvC83
 3it98oro8cvxiekIQ34G3i76cpYA+WzY87u35tHmvaOq0jylZM7ZTGgA2/cUbvwZ+la8hteKUcq
 Q4CYZMRkt3PsWHgDmuE272I+OljLT/kMByREGBkfdu1GA7NKK39E0w17NjGOn0AA==
X-Received: by 2002:a17:902:da8f:b0:2a3:e7fe:646e with SMTP id
 d9443c01a7336-2ab504e88efmr12219045ad.5.1770970125751; 
 Fri, 13 Feb 2026 00:08:45 -0800 (PST)
Received: from smtpclient.apple (n119237241079.netvigator.com.
 [119.237.241.79]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ab2997b6d0sm75211725ad.73.2026.02.13.00.08.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 13 Feb 2026 00:08:45 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [Patch v4 4/7] fuse: refactor FUSE request handler
From: Brian Song <hibriansong@gmail.com>
In-Reply-To: <20260211212156.GD234157@fedora>
Date: Fri, 13 Feb 2026 16:07:29 +0800
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com, fam@euphon.net,
 bernd@bsbernd.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <96F8FC7D-C7B5-4346-8421-65173B0FAD1A@gmail.com>
References: <20260207120901.17222-1-hibriansong@gmail.com>
 <20260207120901.17222-5-hibriansong@gmail.com>
 <20260211212156.GD234157@fedora>
To: Stefan Hajnoczi <stefanha@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=hibriansong@gmail.com; helo=mail-pl1-x62d.google.com
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



> On Feb 12, 2026, at 05:21, Stefan Hajnoczi <stefanha@redhat.com> =
wrote:
>=20
> On Sat, Feb 07, 2026 at 08:08:58PM +0800, Brian Song wrote:
>> This patch implements the CQE handler for FUSE-over-io_uring. Upon
>> receiving a FUSE request via a Completion Queue Entry (CQE), the
>> handler processes the request and submits the response back to the
>> kernel via the FUSE_IO_URING_CMD_COMMIT_AND_FETCH command.
>>=20
>> Additionally, the request processing logic shared between legacy and
>> io_uring modes has been extracted into =
fuse_co_process_request_common().
>> The execution flow now dispatches requests to the appropriate
>> mode-specific logic based on the uring_started flag.
>>=20
>> Suggested-by: Kevin Wolf <kwolf@redhat.com>
>> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Brian Song <hibriansong@gmail.com>
>> ---
>> block/export/fuse.c | 400 =
+++++++++++++++++++++++++++++++++-----------
>> 1 file changed, 301 insertions(+), 99 deletions(-)
>>=20
>> diff --git a/block/export/fuse.c b/block/export/fuse.c
>> index 867752555a..c117e081cd 100644
>> --- a/block/export/fuse.c
>> +++ b/block/export/fuse.c
>> @@ -138,8 +138,8 @@ struct FuseQueue {
>>      * FUSE_MIN_READ_BUFFER (from linux/fuse.h) bytes.
>>      * This however is just the first part of the buffer; every read =
is given
>>      * a vector of this buffer (which should be enough for all normal =
requests,
>> -     * which we check via the static assertion in =
FUSE_IN_OP_STRUCT()) and the
>> -     * spill-over buffer below.
>> +     * which we check via the static assertion in =
FUSE_IN_OP_STRUCT_LEGACY())
>> +     * and the spill-over buffer below.
>>      * Therefore, the size of this buffer plus =
FUSE_SPILLOVER_BUF_SIZE must be
>>      * FUSE_MIN_READ_BUFFER or more (checked via static assertion =
below).
>>      */
>> @@ -912,6 +912,7 @@ static void coroutine_fn =
co_read_from_fuse_fd(void *opaque)
>>     }
>>=20
>>     fuse_co_process_request(q, spillover_buf);
>> +    qemu_vfree(spillover_buf);
>>=20
>> no_request:
>>     fuse_dec_in_flight(exp);
>> @@ -1684,100 +1685,75 @@ static int fuse_write_buf_response(int fd, =
uint32_t req_id,
>> }
>>=20
>> /*
>> - * For use in fuse_co_process_request():
>> + * For use in fuse_co_process_request_common():
>>  * Returns a pointer to the parameter object for the given operation =
(inside of
>> - * queue->request_buf, which is assumed to hold a fuse_in_header =
first).
>> - * Verifies that the object is complete (queue->request_buf is large =
enough to
>> - * hold it in one piece, and the request length includes the whole =
object).
>> + * in_buf, which is assumed to hold a fuse_in_header first).
>> + * Verifies that the object is complete (in_buf is large enough to =
hold it in
>> + * one piece, and the request length includes the whole object).
>> + * Only performs verification for legacy FUSE.
>>  *
>>  * Note that queue->request_buf may be overwritten after yielding, so =
the
>>  * returned pointer must not be used across a function that may =
yield!
>>  */
>> -#define FUSE_IN_OP_STRUCT(op_name, queue) \
>> +#define FUSE_IN_OP_STRUCT_LEGACY(op_name, queue) \
>>     ({ \
>>         const struct fuse_in_header *__in_hdr =3D \
>>             (const struct fuse_in_header *)(queue)->request_buf; \
>>         const struct fuse_##op_name##_in *__in =3D \
>>             (const struct fuse_##op_name##_in *)(__in_hdr + 1); \
>>         const size_t __param_len =3D sizeof(*__in_hdr) + =
sizeof(*__in); \
>> -        uint32_t __req_len; \
>>         \
>> -        QEMU_BUILD_BUG_ON(sizeof((queue)->request_buf) < =
__param_len); \
>> +        QEMU_BUILD_BUG_ON(sizeof((queue)->request_buf) < \
>> +                          (sizeof(struct fuse_in_header) + \
>> +                           sizeof(struct fuse_##op_name##_in))); \
>>         \
>> -        __req_len =3D __in_hdr->len; \
>> +        uint32_t __req_len =3D __in_hdr->len; \
>>         if (__req_len < __param_len) { \
>>             warn_report("FUSE request truncated (%" PRIu32 " < %zu)", =
\
>>                         __req_len, __param_len); \
>>             ret =3D -EINVAL; \
>> -            break; \
>> +            __in =3D NULL; \
>>         } \
>>         __in; \
>>     })
>>=20
>> /*
>> - * For use in fuse_co_process_request():
>> + * For use in fuse_co_process_request_common():
>>  * Returns a pointer to the return object for the given operation =
(inside of
>>  * out_buf, which is assumed to hold a fuse_out_header first).
>> - * Verifies that out_buf is large enough to hold the whole object.
>> + * Only performs verification for legacy FUSE.
>> + * Note: Buffer size verification is done via static assertions in =
the caller
>> + * (fuse_co_process_request) where out_buf is a local array.
>>  *
>> - * (out_buf should be a char[] array.)
>> + * (out_buf should be a char[] array in the caller.)
>>  */
>> -#define FUSE_OUT_OP_STRUCT(op_name, out_buf) \
>> +#define FUSE_OUT_OP_STRUCT_LEGACY(op_name, out_buf) \
>>     ({ \
>>         struct fuse_out_header *__out_hdr =3D \
>>             (struct fuse_out_header *)(out_buf); \
>>         struct fuse_##op_name##_out *__out =3D \
>>             (struct fuse_##op_name##_out *)(__out_hdr + 1); \
>>         \
>> -        QEMU_BUILD_BUG_ON(sizeof(*__out_hdr) + sizeof(*__out) > \
>> -                          sizeof(out_buf)); \
>> -        \
>>         __out; \
>>     })
>>=20
>> /**
>> - * Process a FUSE request, incl. writing the response.
>> - *
>> - * Note that yielding in any request-processing function can =
overwrite the
>> - * contents of q->request_buf.  Anything that takes a buffer needs =
to take
>> - * care that the content is copied before yielding.
>> - *
>> - * @spillover_buf can contain the tail of a write request too large =
to fit into
>> - * q->request_buf.  This function takes ownership of it (i.e. will =
free it),
>> - * which assumes that its contents will not be overwritten by =
concurrent
>> - * requests (as opposed to q->request_buf).
>> + * Shared helper for FUSE request processing. Handles both legacy =
and io_uring
>> + * paths.
>>  */
>> -static void coroutine_fn
>> -fuse_co_process_request(FuseQueue *q, void *spillover_buf)
>> +static void coroutine_fn fuse_co_process_request_common(
>> +    FuseExport *exp,
>> +    uint32_t opcode,
>> +    uint64_t req_id,
>> +    void *in_buf,
>> +    void *spillover_buf,
>> +    void *out_buf,
>> +    void (*send_response)(void *opaque, uint32_t req_id, int ret,
>> +                          const void *buf, void *out_buf),
>> +    void *opaque /* FuseQueue* or FuseUringEnt* */)
>> {
>> -    FuseExport *exp =3D q->exp;
>> -    uint32_t opcode;
>> -    uint64_t req_id;
>> -    /*
>> -     * Return buffer.  Must be large enough to hold all return =
headers, but does
>> -     * not include space for data returned by read requests.
>> -     * (FUSE_IN_OP_STRUCT() verifies at compile time that out_buf is =
indeed
>> -     * large enough.)
>> -     */
>> -    char out_buf[sizeof(struct fuse_out_header) +
>> -                 MAX_CONST(sizeof(struct fuse_init_out),
>> -                 MAX_CONST(sizeof(struct fuse_open_out),
>> -                 MAX_CONST(sizeof(struct fuse_attr_out),
>> -                 MAX_CONST(sizeof(struct fuse_write_out),
>> -                           sizeof(struct fuse_lseek_out)))))];
>> -    struct fuse_out_header *out_hdr =3D (struct fuse_out_header =
*)out_buf;
>> -    /* For read requests: Data to be returned */
>>     void *out_data_buffer =3D NULL;
>> -    ssize_t ret;
>> -
>> -    /* Limit scope to ensure pointer is no longer used after =
yielding */
>> -    {
>> -        const struct fuse_in_header *in_hdr =3D
>> -            (const struct fuse_in_header *)q->request_buf;
>> -
>> -        opcode =3D in_hdr->opcode;
>> -        req_id =3D in_hdr->unique;
>> -    }
>> +    int ret =3D 0;
>>=20
>> #ifdef CONFIG_LINUX_IO_URING
>>     /*
>> @@ -1794,15 +1770,32 @@ fuse_co_process_request(FuseQueue *q, void =
*spillover_buf)
>>=20
>>     switch (opcode) {
>>     case FUSE_INIT: {
>> -        const struct fuse_init_in *in =3D FUSE_IN_OP_STRUCT(init, =
q);
>> -        ret =3D fuse_co_init(exp, FUSE_OUT_OP_STRUCT(init, out_buf),
>> -                           in->max_readahead, in);
>> +        FuseQueue *q =3D opaque;
>> +        const struct fuse_init_in *in =3D
>> +            FUSE_IN_OP_STRUCT_LEGACY(init, q);
>> +        if (!in) {
>> +            break;
>> +        }
>> +
>> +        struct fuse_init_out *out =3D
>> +            FUSE_OUT_OP_STRUCT_LEGACY(init, out_buf);
>> +
>> +        ret =3D fuse_co_init(exp, out, in->max_readahead, in);
>>         break;
>>     }
>>=20
>> -    case FUSE_OPEN:
>> -        ret =3D fuse_co_open(exp, FUSE_OUT_OP_STRUCT(open, =
out_buf));
>> +    case FUSE_OPEN: {
>> +        struct fuse_open_out *out;
>> +
>> +        if (exp->uring_started) {
>> +            out =3D out_buf;
>> +        } else {
>> +            out =3D FUSE_OUT_OP_STRUCT_LEGACY(open, out_buf);
>> +        }
>=20
> It would be nice to avoid these repetitive code changes. How about
> moving the if (exp->uring_started) logic inside FUSE_IN_OP_STRUCT() =
and
> FUSE_OUT_OP_STRUCT()?

It would be better to leave it as is. Changing FUSE_OUT_OP_STRUCT() is =
easy, but it complicates FUSE_IN_OP_STRUCT() because we'd have to pass =
both in_buf and opaque to handle the assignment.

Since opaque represents either a FuseQueue* or a FuseUringEnt*, wouldn't =
it be confusing to integrate the if (exp->uring_started) check into =
FUSE_IN_OP_STRUCT()? Passing a variable that represents two different =
modes, along with in_buf(used in uring mode), repeatedly could get =
confusing.

>=20
> Also, is it really necessary to make FUSE_IN_OP_STRUCT() return NULL
> instead of using the break statement on error?

I thought it would be more elegant to put the break outside of =
FUSE_IN_OP_STRUCT(), so that it looks more like a function call. But we =
definitely can put it back.

For example, if we move the if (exp->uring_started) logic inside =
FUSE_OUT_OP_STRUCT(), it would be better to pass exp as a parameter =
rather than referencing it directly inside the macro.

>> +
>> +        ret =3D fuse_co_open(exp, out);
>>         break;
>> +    }
>>=20
>>     case FUSE_RELEASE:
>>         ret =3D 0;
>> @@ -1812,37 +1805,105 @@ fuse_co_process_request(FuseQueue *q, void =
*spillover_buf)
>>         ret =3D -ENOENT; /* There is no node but the root node */
>>         break;
>>=20
>> -    case FUSE_GETATTR:
>> -        ret =3D fuse_co_getattr(exp, FUSE_OUT_OP_STRUCT(attr, =
out_buf));
>> +    case FUSE_GETATTR: {
>> +        struct fuse_attr_out *out;
>> +
>> +        if (exp->uring_started) {
>> +            out =3D out_buf;
>> +        } else {
>> +            out =3D FUSE_OUT_OP_STRUCT_LEGACY(attr, out_buf);
>> +        }
>> +
>> +        ret =3D fuse_co_getattr(exp, out);
>>         break;
>> +    }
>>=20
>>     case FUSE_SETATTR: {
>> -        const struct fuse_setattr_in *in =3D =
FUSE_IN_OP_STRUCT(setattr, q);
>> -        ret =3D fuse_co_setattr(exp, FUSE_OUT_OP_STRUCT(attr, =
out_buf),
>> -                              in->valid, in->size, in->mode, =
in->uid, in->gid);
>> +        const struct fuse_setattr_in *in;
>> +        struct fuse_attr_out *out;
>> +
>> +        if (exp->uring_started) {
>> +            in =3D in_buf;
>> +            out =3D out_buf;
>> +        } else {
>> +            FuseQueue *q =3D opaque;
>> +            in =3D FUSE_IN_OP_STRUCT_LEGACY(setattr, q);
>> +            if (!in) {
>> +                break;
>> +            }
>> +
>> +            out =3D FUSE_OUT_OP_STRUCT_LEGACY(attr, out_buf);
>> +        }
>> +
>> +        ret =3D fuse_co_setattr(exp, out, in->valid, in->size, =
in->mode,
>> +                              in->uid, in->gid);
>>         break;
>>     }
>>=20
>>     case FUSE_READ: {
>> -        const struct fuse_read_in *in =3D FUSE_IN_OP_STRUCT(read, =
q);
>> +        const struct fuse_read_in *in;
>> +
>> +        if (exp->uring_started) {
>> +            in =3D in_buf;
>> +        } else {
>> +            FuseQueue *q =3D opaque;
>> +            in =3D FUSE_IN_OP_STRUCT_LEGACY(read, q);
>> +            if (!in) {
>> +                break;
>> +            }
>> +        }
>> +
>>         ret =3D fuse_co_read(exp, &out_data_buffer, in->offset, =
in->size);
>>         break;
>>     }
>>=20
>>     case FUSE_WRITE: {
>> -        const struct fuse_write_in *in =3D FUSE_IN_OP_STRUCT(write, =
q);
>> -        uint32_t req_len;
>> -
>> -        req_len =3D ((const struct fuse_in_header =
*)q->request_buf)->len;
>> -        if (unlikely(req_len < sizeof(struct fuse_in_header) + =
sizeof(*in) +
>> -                               in->size)) {
>> -            warn_report("FUSE WRITE truncated; received %zu bytes of =
%" PRIu32,
>> -                        req_len - sizeof(struct fuse_in_header) - =
sizeof(*in),
>> -                        in->size);
>> -            ret =3D -EINVAL;
>> -            break;
>> -        }
>> +        const struct fuse_write_in *in;
>> +        struct fuse_write_out *out;
>> +        const void *in_place_buf;
>> +        const void *spill_buf;
>> +
>> +        if (exp->uring_started) {
>> +            FuseUringEnt *ent =3D opaque;
>> +
>> +            in =3D in_buf;
>> +            out =3D out_buf;
>> +
>> +            assert(in->size <=3D =
ent->req_header.ring_ent_in_out.payload_sz);
>>=20
>> +            /*
>> +             * In uring mode, the "out_buf" (ent->payload) actually =
holds the
>> +             * input data for WRITE requests.
>> +             */
>> +            in_place_buf =3D NULL;
>> +            spill_buf =3D out_buf;
>> +        } else {
>> +            FuseQueue *q =3D opaque;
>> +            in =3D FUSE_IN_OP_STRUCT_LEGACY(write, q);
>> +            if (!in) {
>> +                break;
>> +            }
>> +
>> +            out =3D FUSE_OUT_OP_STRUCT_LEGACY(write, out_buf);
>> +
>> +            /* Additional check for WRITE: verify the request =
includes data */
>> +            uint32_t req_len =3D
>> +                ((const struct fuse_in_header =
*)(q->request_buf))->len;
>> +
>> +            if (unlikely(req_len < sizeof(struct fuse_in_header) + =
sizeof(*in) +
>> +                        in->size)) {
>> +                warn_report("FUSE WRITE truncated; received %zu =
bytes of %"
>> +                    PRIu32,
>> +                    req_len - sizeof(struct fuse_in_header) - =
sizeof(*in),
>> +                    in->size);
>> +                ret =3D -EINVAL;
>> +                break;
>> +            }
>> +
>> +            /* Legacy buffer setup */
>> +            in_place_buf =3D in + 1;
>> +            spill_buf =3D spillover_buf;
>> +        }
>>         /*
>>          * poll_fuse_fd() has checked that in_hdr->len matches the =
number of
>>          * bytes read, which cannot exceed the max_write value we set
>> @@ -1856,13 +1917,24 @@ fuse_co_process_request(FuseQueue *q, void =
*spillover_buf)
>>          * fuse_co_write() takes care to copy its contents before =
potentially
>>          * yielding.
>>          */
>> -        ret =3D fuse_co_write(exp, FUSE_OUT_OP_STRUCT(write, =
out_buf),
>> -                            in->offset, in->size, in + 1, =
spillover_buf);
>> +        ret =3D fuse_co_write(exp, out, in->offset, in->size,
>> +                            in_place_buf, spill_buf);
>>         break;
>>     }
>>=20
>>     case FUSE_FALLOCATE: {
>> -        const struct fuse_fallocate_in *in =3D =
FUSE_IN_OP_STRUCT(fallocate, q);
>> +        const struct fuse_fallocate_in *in;
>> +
>> +        if (exp->uring_started) {
>> +            in =3D in_buf;
>> +        } else {
>> +            FuseQueue *q =3D opaque;
>> +            in =3D FUSE_IN_OP_STRUCT_LEGACY(fallocate, q);
>> +            if (!in) {
>> +                break;
>> +            }
>> +        }
>> +
>>         ret =3D fuse_co_fallocate(exp, in->offset, in->length, =
in->mode);
>>         break;
>>     }
>> @@ -1877,9 +1949,23 @@ fuse_co_process_request(FuseQueue *q, void =
*spillover_buf)
>>=20
>> #ifdef CONFIG_FUSE_LSEEK
>>     case FUSE_LSEEK: {
>> -        const struct fuse_lseek_in *in =3D FUSE_IN_OP_STRUCT(lseek, =
q);
>> -        ret =3D fuse_co_lseek(exp, FUSE_OUT_OP_STRUCT(lseek, =
out_buf),
>> -                            in->offset, in->whence);
>> +        const struct fuse_lseek_in *in;
>> +        struct fuse_lseek_out *out;
>> +
>> +        if (exp->uring_started) {
>> +            in =3D in_buf;
>> +            out =3D out_buf;
>> +        } else {
>> +            FuseQueue *q =3D opaque;
>> +            in =3D FUSE_IN_OP_STRUCT_LEGACY(lseek, q);
>> +            if (!in) {
>> +                break;
>> +            }
>> +
>> +            out =3D FUSE_OUT_OP_STRUCT_LEGACY(lseek, out_buf);
>> +        }
>> +
>> +        ret =3D fuse_co_lseek(exp, out, in->offset, in->whence);
>>         break;
>>     }
>> #endif
>> @@ -1888,20 +1974,12 @@ fuse_co_process_request(FuseQueue *q, void =
*spillover_buf)
>>         ret =3D -ENOSYS;
>>     }
>>=20
>> -    /* Ignore errors from fuse_write*(), nothing we can do anyway */
>> +    send_response(opaque, req_id, ret, out_data_buffer, out_buf);
>> +
>>     if (out_data_buffer) {
>> -        assert(ret >=3D 0);
>> -        fuse_write_buf_response(q->fuse_fd, req_id, out_hdr,
>> -                                out_data_buffer, ret);
>>         qemu_vfree(out_data_buffer);
>> -    } else {
>> -        fuse_write_response(q->fuse_fd, req_id, out_hdr,
>> -                            ret < 0 ? ret : 0,
>> -                            ret < 0 ? 0 : ret);
>>     }
>>=20
>> -    qemu_vfree(spillover_buf);
>> -
>> #ifdef CONFIG_LINUX_IO_URING
>>     if (unlikely(opcode =3D=3D FUSE_INIT) && uring_initially_enabled) =
{
>>         if (exp->is_uring && !exp->uring_started) {
>> @@ -1910,7 +1988,8 @@ fuse_co_process_request(FuseQueue *q, void =
*spillover_buf)
>>              * If io_uring mode was requested for this export but it =
has not
>>              * been started yet, start it now.
>>              */
>> -            struct fuse_init_out *out =3D FUSE_OUT_OP_STRUCT(init, =
out_buf);
>> +            struct fuse_init_out *out =3D
>> +                FUSE_OUT_OP_STRUCT_LEGACY(init, out_buf);
>>             fuse_uring_start(exp, out);
>>         } else if (ret =3D=3D -EOPNOTSUPP) {
>>             /*
>> @@ -1923,12 +2002,135 @@ fuse_co_process_request(FuseQueue *q, void =
*spillover_buf)
>>     }
>> #endif
>> }
>> +/* Helper to send response for legacy */
>> +static void send_response_legacy(void *opaque, uint32_t req_id, int =
ret,
>> +                                 const void *buf, void *out_buf)
>> +{
>> +    FuseQueue *q =3D (FuseQueue *)opaque;
>> +    struct fuse_out_header *out_hdr =3D (struct fuse_out_header =
*)out_buf;
>> +    if (buf) {
>> +        assert(ret >=3D 0);
>> +        fuse_write_buf_response(q->fuse_fd, req_id, out_hdr, buf, =
ret);
>> +    } else {
>> +        fuse_write_response(q->fuse_fd, req_id, out_hdr,
>> +                            ret < 0 ? ret : 0,
>> +                            ret < 0 ? 0 : ret);
>> +    }
>> +}
>> +
>> +static void coroutine_fn
>> +fuse_co_process_request(FuseQueue *q, void *spillover_buf)
>> +{
>> +    FuseExport *exp =3D q->exp;
>> +    uint32_t opcode;
>> +    uint64_t req_id;
>> +
>> +    /*
>> +     * Return buffer.  Must be large enough to hold all return =
headers, but does
>> +     * not include space for data returned by read requests.
>> +     */
>> +    char out_buf[sizeof(struct fuse_out_header) +
>> +        MAX_CONST(sizeof(struct fuse_init_out),
>> +        MAX_CONST(sizeof(struct fuse_open_out),
>> +        MAX_CONST(sizeof(struct fuse_attr_out),
>> +        MAX_CONST(sizeof(struct fuse_write_out),
>> +                  sizeof(struct fuse_lseek_out)))))] =3D {0};
>> +
>> +    /* Verify that out_buf is large enough for all output structures =
*/
>> +    QEMU_BUILD_BUG_ON(sizeof(struct fuse_out_header) +
>> +        sizeof(struct fuse_init_out) > sizeof(out_buf));
>> +    QEMU_BUILD_BUG_ON(sizeof(struct fuse_out_header) +
>> +        sizeof(struct fuse_open_out) > sizeof(out_buf));
>> +    QEMU_BUILD_BUG_ON(sizeof(struct fuse_out_header) +
>> +        sizeof(struct fuse_attr_out) > sizeof(out_buf));
>> +    QEMU_BUILD_BUG_ON(sizeof(struct fuse_out_header) +
>> +        sizeof(struct fuse_write_out) > sizeof(out_buf));
>> +#ifdef CONFIG_FUSE_LSEEK
>> +    QEMU_BUILD_BUG_ON(sizeof(struct fuse_out_header) +
>> +        sizeof(struct fuse_lseek_out) > sizeof(out_buf));
>> +#endif
>> +
>> +    /* Limit scope to ensure pointer is no longer used after =
yielding */
>> +    {
>> +        const struct fuse_in_header *in_hdr =3D
>> +            (const struct fuse_in_header *)q->request_buf;
>> +
>> +        opcode =3D in_hdr->opcode;
>> +        req_id =3D in_hdr->unique;
>> +    }
>> +
>> +    fuse_co_process_request_common(exp, opcode, req_id, NULL, =
spillover_buf,
>> +                                   out_buf, send_response_legacy, =
q);
>> +}
>>=20
>> #ifdef CONFIG_LINUX_IO_URING
>> +static void fuse_uring_prep_sqe_commit(struct io_uring_sqe *sqe, =
void *opaque)
>> +{
>> +    FuseUringEnt *ent =3D opaque;
>> +    struct fuse_uring_cmd_req *req =3D (void *)&sqe->cmd[0];
>> +
>> +    ent->last_cmd =3D FUSE_IO_URING_CMD_COMMIT_AND_FETCH;
>> +
>> +    fuse_uring_sqe_prepare(sqe, ent->rq->q, ent->last_cmd);
>> +    fuse_uring_sqe_set_req_data(req, ent->rq->rqid, =
ent->req_commit_id);
>> +}
>> +
>> +static void
>> +fuse_uring_send_response(FuseUringEnt *ent, uint32_t req_id, int =
ret,
>> +                         const void *out_data_buffer)
>> +{
>> +    FuseExport *exp =3D ent->rq->q->exp;
>> +
>> +    struct fuse_uring_req_header *rrh =3D &ent->req_header;
>> +    struct fuse_out_header *out_header =3D (struct fuse_out_header =
*)&rrh->in_out;
>> +    struct fuse_uring_ent_in_out *ent_in_out =3D
>> +        (struct fuse_uring_ent_in_out *)&rrh->ring_ent_in_out;
>> +
>> +    /* FUSE_READ */
>> +    if (out_data_buffer && ret > 0) {
>> +        memcpy(ent->req_payload, out_data_buffer, ret);
>> +    }
>> +
>> +    out_header->error  =3D ret < 0 ? ret : 0;
>> +    out_header->unique =3D req_id;
>> +    ent_in_out->payload_sz =3D ret > 0 ? ret : 0;
>> +
>> +    /* Commit and fetch a uring entry */
>> +    blk_exp_ref(&exp->common);
>> +    aio_add_sqe(fuse_uring_prep_sqe_commit, ent, =
&ent->fuse_cqe_handler);
>> +}
>> +
>> +/* Helper to send response for uring */
>> +static void send_response_uring(void *opaque, uint32_t req_id, int =
ret,
>> +                                const void *out_data_buffer, void =
*payload)
>> +{
>> +    FuseUringEnt *ent =3D (FuseUringEnt *)opaque;
>> +
>> +    fuse_uring_send_response(ent, req_id, ret, out_data_buffer);
>> +}
>> +
>> static void coroutine_fn fuse_uring_co_process_request(FuseUringEnt =
*ent)
>> {
>> -    /* TODO */
>> -    (void)ent;
>> +    FuseExport *exp =3D ent->rq->q->exp;
>> +    struct fuse_uring_req_header *rrh =3D &ent->req_header;
>> +    struct fuse_uring_ent_in_out *ent_in_out =3D
>> +        (struct fuse_uring_ent_in_out *)&rrh->ring_ent_in_out;
>> +    struct fuse_in_header *in_hdr =3D
>> +        (struct fuse_in_header *)&rrh->in_out;
>> +    uint32_t opcode =3D in_hdr->opcode;
>> +    uint64_t req_id =3D in_hdr->unique;
>> +
>> +    ent->req_commit_id =3D ent_in_out->commit_id;
>> +
>> +    if (unlikely(ent->req_commit_id =3D=3D 0)) {
>> +        error_report("If this happens kernel will not find the =
response - "
>> +            "it will be stuck forever - better to abort =
immediately.");
>> +        fuse_export_halt(exp);
>> +        return;
>> +    }
>> +
>> +    fuse_co_process_request_common(exp, opcode, req_id, &rrh->op_in,
>> +        NULL, ent->req_payload, send_response_uring, ent);
>> }
>> #endif /* CONFIG_LINUX_IO_URING */
>>=20
>> --
>> 2.43.0



