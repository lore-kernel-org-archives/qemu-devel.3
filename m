Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9288FC5321D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 22:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shd8Z-0003L6-W3; Fri, 23 Aug 2024 18:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1shd8X-0003KZ-Kv
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 18:52:05 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1shd8V-0004Fr-9f
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 18:52:05 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e026a2238d8so2725453276.0
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 15:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1724453517; x=1725058317; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R2UXU98T/UqBFBs0EnOdjn/yyk+gNgQW5Urm1IUmPC8=;
 b=AskPsH6Bm2drRbCoMCSV+LsY9UkI6hKbvfoRZdIYuwG04O6DWhAX01KFhOO93h6gf5
 CJ60+0yG2r8QHF9YfJy2YkbsjjovNm92R944/3PJXrlrk/sLVU1URnsYXeNjShpwxE0L
 vF0pYPupTxP5mphh+vlx+VbixvUJ1ocyrM0x2AWEfPVNVDglbVtplv6h4pNZ6Q3vG0Ke
 c6kU0zcyAhfBXR5mhaTZKxX2EAuV1RGZhVaDwj/K2yRGkmz0jtStlM0v5YYJ9p6bMbRv
 LIQXvHFHLYVGdtADs2jFQ9+AWpAGz5VJT0PxNvD7+CRbuUb78PewECbhlQfDmXj2PQBZ
 /9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724453517; x=1725058317;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R2UXU98T/UqBFBs0EnOdjn/yyk+gNgQW5Urm1IUmPC8=;
 b=eEGyig5OwbGT2zWCKhhDKZBrp8b6+BTfRQH/kREVz3QwTxvjNukgZm6qo/6inBA1cO
 SU29bZXD2SijRbpvdEtbSIoLuF/4tDOFevNK/kEh3gnfy0eg3DiIspeg8sI+5PUNy953
 P+atOcKOJQnmmb8PFDmbAiZHpo8NiVHdqWxioqHZSDkzFQSgnGlH4FAkOREgwxyTO1SP
 019QsINkg15THERyEFJD0rqt2/8X9ptLnRlqDLojau8NBdCXOViJ8qjJHSXpP/802CEt
 iQn1gI0CvLoaWrZWfnCovrmHY7wt6cSZ5IsdGU53WIVC09dgZ7KsIegZMyOX8k+mQIoP
 Pqnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzyjLgmGL0flEhVgAq60ocrwtPIadeBIRLvmx9iC0vcBjrZmDrJdQJt7UwyAbLVbxzEMAbTC0Khc+j@nongnu.org
X-Gm-Message-State: AOJu0Yysjc21bYcLkgcxxf1eUiRmuo7C9R01CqGG2xGGiChiMAWOhR6z
 AuoAlvPiqqgw6R0pJIjeEsKc8oKbdvGZL3Je+ZW3kLx68x3Uvcky1bm+IuofCyRiIhJt1vwYJZS
 si51LKAfIiMyr10WpZ6mRFZYqWkbDPlbRxbgd6g==
X-Google-Smtp-Source: AGHT+IG8nxsECazhPqhJlzKZ2hxpEx5USfMtrxC8Mkh1VOnkafJv8IJsIDaCYtqfVMrGemYcDdci54wEMP7Cwc/+ltM=
X-Received: by 2002:a05:6902:1b83:b0:e0b:3492:69fa with SMTP id
 3f1490d57ef6-e17a8c45b03mr4488599276.54.1724453516884; Fri, 23 Aug 2024
 15:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240820170907.6788-1-yichen.wang@bytedance.com>
 <20240820170907.6788-5-yichen.wang@bytedance.com>
 <CAE8KmOzK=Qe3nJ_ReRmQr5hkUgoZe9nOBi5G0hByvG3oVuzG+g@mail.gmail.com>
In-Reply-To: <CAE8KmOzK=Qe3nJ_ReRmQr5hkUgoZe9nOBi5G0hByvG3oVuzG+g@mail.gmail.com>
From: Yichen Wang <yichen.wang@bytedance.com>
Date: Fri, 23 Aug 2024 15:51:46 -0700
Message-ID: <CAHObMVZFb+7d8W90TEEzwf=X_RJb238RQG0CEcD_UqboYdhVnA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v8 4/5] migration: Introduce 'qatzip'
 compression method
To: Prasad Pandit <ppandit@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, 
 Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>, 
 "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>, 
 Xiaoning Ding <xiaoning.ding@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=yichen.wang@bytedance.com; helo=mail-yb1-xb2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Aug 22, 2024 at 4:06=E2=80=AFAM Prasad Pandit <ppandit@redhat.com> =
wrote:
>
> Hello,
>
> On Tue, 20 Aug 2024 at 22:40, Yichen Wang <yichen.wang@bytedance.com> wro=
te:
> > +static int qatzip_send_setup(MultiFDSendParams *p, Error **errp)
> > +{
> > +    QatzipData *q;
> > +    QzSessionParamsDeflate_T params;
> > +    const char *err_msg;
> > +    int ret;
> > +
> > +    q =3D g_new0(QatzipData, 1);
> > +    p->compress_data =3D q;
> > +    /* We need one extra place for the packet header */
> > +    p->iov =3D g_new0(struct iovec, 2);
> > +
> > +    /*
> > +     * Initialize QAT device with software fallback by default. This a=
llows
> > +     * QATzip to use CPU path when QAT hardware reaches maximum throug=
hput.
> > +     */
> > +    ret =3D qzInit(&q->sess, true);
> > +    if (ret !=3D QZ_OK && ret !=3D QZ_DUPLICATE) {
> > +        err_msg =3D "qzInit failed";
> > +        goto err;
> > +    }
> > +
> > +    ret =3D qzGetDefaultsDeflate(&params);
> > +    if (ret !=3D QZ_OK) {
> > +        err_msg =3D "qzGetDefaultsDeflate failed";
> > +        goto err;
> > +    }
> > +
> > +    /* Make sure to use configured QATzip compression level. */
> > +    params.common_params.comp_lvl =3D migrate_multifd_qatzip_level();
> > +    ret =3D qzSetupSessionDeflate(&q->sess, &params);
> > +    if (ret !=3D QZ_OK && ret !=3D QZ_DUPLICATE) {
> > +        err_msg =3D "qzSetupSessionDeflate failed";
> > +        goto err;
> > +    }
> > +
> > +    if (MULTIFD_PACKET_SIZE > UINT32_MAX) {
> > +        err_msg =3D "packet size too large for QAT";
> > +        goto err;
> > +    }
> > +
> > +    q->in_len =3D MULTIFD_PACKET_SIZE;
> > +    /*
> > +     * PINNED_MEM is an enum from qatzip headers, which means to use
> > +     * kzalloc_node() to allocate memory for QAT DMA purposes. When QA=
T device
> > +     * is not available or software fallback is used, the malloc flag =
needs to
> > +     * be set as COMMON_MEM.
> > +     */
> > +    q->in_buf =3D qzMalloc(q->in_len, 0, PINNED_MEM);
> > +    if (!q->in_buf) {
> > +        q->in_buf =3D qzMalloc(q->in_len, 0, COMMON_MEM);
> > +        if (!q->in_buf) {
> > +            err_msg =3D "qzMalloc failed";
> > +            goto err;
> > +        }
> > +    }
> > +
> > +    q->out_len =3D qzMaxCompressedLength(MULTIFD_PACKET_SIZE, &q->sess=
);
> > +    q->out_buf =3D qzMalloc(q->out_len, 0, PINNED_MEM);
> > +    if (!q->out_buf) {
> > +        q->out_buf =3D qzMalloc(q->out_len, 0, COMMON_MEM);
> > +        if (!q->out_buf) {
> > +            err_msg =3D "qzMalloc failed";
> > +            goto err;
> > +        }
> > +    }
> > +
> > +    return 0;
> > +
> > +err:
> > +    error_setg(errp, "multifd %u: [sender] %s", p->id, err_msg);
> > +    return -1;
> > +}
>
> * Need to release (g_free OR qatzip_send_cleanup) allocated memory in
> the error (err:) path.
>

The patch was originally written exactly like what you suggest,
cleanup in the error path of the same function. However, later I
realized in gdb that I was wrong. The qatzip_send_cleanup() function
will be called later in another thread in both normal and error paths.
So I revised the patch to this behavior, otherwise I will run into
double free in the error path.

>
> > +static int qatzip_recv_setup(MultiFDRecvParams *p, Error **errp)
> > +{
> > +    QatzipData *q;
> > +    QzSessionParamsDeflate_T params;
> > +    const char *err_msg;
> > +    int ret;
> > +
> > +    q =3D g_new0(QatzipData, 1);
> > +    p->compress_data =3D q;
> > +
> > +    /*
> > +     * Initialize QAT device with software fallback by default. This a=
llows
> > +     * QATzip to use CPU path when QAT hardware reaches maximum throug=
hput.
> > +     */
> > +    ret =3D qzInit(&q->sess, true);
> > +    if (ret !=3D QZ_OK && ret !=3D QZ_DUPLICATE) {
> > +        err_msg =3D "qzInit failed";
> > +        goto err;
> > +    }
> > +
> > +    ret =3D qzGetDefaultsDeflate(&params);
> > +    if (ret !=3D QZ_OK) {
> > +        err_msg =3D "qzGetDefaultsDeflate failed";
> > +        goto err;
> > +    }
> > +
> > +    ret =3D qzSetupSessionDeflate(&q->sess, &params);
> > +    if (ret !=3D QZ_OK && ret !=3D QZ_DUPLICATE) {
> > +        err_msg =3D "qzSetupSessionDeflate failed";
> > +        goto err;
> > +    }
> > +
> > +    /*
> > +     * Reserve extra spaces for the incoming packets. Current implemen=
tation
> > +     * doesn't send uncompressed pages in case the compression gets to=
o big.
> > +     */
> > +    q->in_len =3D MULTIFD_PACKET_SIZE * 2;
> > +    /*
> > +     * PINNED_MEM is an enum from qatzip headers, which means to use
> > +     * kzalloc_node() to allocate memory for QAT DMA purposes. When QA=
T device
> > +     * is not available or software fallback is used, the malloc flag =
needs to
> > +     * be set as COMMON_MEM.
> > +     */
> > +    q->in_buf =3D qzMalloc(q->in_len, 0, PINNED_MEM);
> > +    if (!q->in_buf) {
> > +        q->in_buf =3D qzMalloc(q->in_len, 0, COMMON_MEM);
> > +        if (!q->in_buf) {
> > +            err_msg =3D "qzMalloc failed";
> > +            goto err;
> > +        }
> > +    }
> > +
> > +    q->out_len =3D MULTIFD_PACKET_SIZE;
> > +    q->out_buf =3D qzMalloc(q->out_len, 0, PINNED_MEM);
> > +    if (!q->out_buf) {
> > +        q->out_buf =3D qzMalloc(q->out_len, 0, COMMON_MEM);
> > +        if (!q->out_buf) {
> > +            err_msg =3D "qzMalloc failed";
> > +            goto err;
> > +        }
> > +    }
> > +
> > +    return 0;
> > +
> > +err:
> > +    error_setg(errp, "multifd %u: [receiver] %s", p->id, err_msg);
> > +    return -1;
> > +}
>
> * Need to release (g_free OR qatzip_recv_cleanup) allocated memory in
> the error (err:) path.
>
> Thank you.
> ---
>   - Prasad
>

