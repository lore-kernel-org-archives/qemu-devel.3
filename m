Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D512C3DA49
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2024 05:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSsAv-0007nB-5T; Sun, 14 Jul 2024 01:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sSsAs-0007mg-Pi
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 01:53:31 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sSsAp-0001DX-C2
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 01:53:30 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e04289a2536so3042547276.1
 for <qemu-devel@nongnu.org>; Sat, 13 Jul 2024 22:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720936400; x=1721541200; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aYkq677DSxfMwqahYhQPbn0fu9GxyRrXF7VdVJpVDwo=;
 b=E88Z279KYY4P9yJC+nzxFK51tJZ0SD7jSbRvEWSzUGbFfgWyX0f6Bk47itEf3XihnF
 N6bl5vdUq4HA/hLbDTImFyrhSMuNTic1AP+/9h7rvL3ZYX9RVes2JoB5L2AbMcrb2HCo
 M4olfQliQp+yjFquakYHhZ5RHDSMibuHKVee9Br245SXvsemUSndInNtCv1IiOyOQCa8
 j5XUkTUNYa3kAWx8XaXkeESoMWM7gq33AhsD5kaOmYWJ9oOjrFQwBIC3EBvPwF53+D0p
 JnBy5eqp5zX3d0ihVObLLHzrUwUwksCryBK+wm+fe90tbsXfQF8R+EJnXRbgeO+NXLWB
 3Q6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720936400; x=1721541200;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aYkq677DSxfMwqahYhQPbn0fu9GxyRrXF7VdVJpVDwo=;
 b=DHzslSnUQ/aOBaF5jUBtuhpwvUP222RFsII4p1Wr5/YYtTPQC9dnYroqV+crAQz33d
 MWy7MKBNcvk7/mRQRl/nI03qJOREP6BKPSFWz45BFTrC+1AtCOsDr6C9C5zz7jWzhJvt
 cpoYmBOgJBKDPNv+qM8R81MjJOvexQ+F09AaiQ2JhsuGvZu2jFsOBe7xNRYg/Bvtuws5
 zt/6/DZH0qbhlCazA/mEvIG6u17ongaA91FQiYygMArGBHfzal1Bgnqyb0ktt4H7Cf5m
 IelnL21XwPr73Qjy8LdMfNd/P/lHV4KXNSqoMhwj7AA6kwg/0S9MrFrKrAzXPr0L+Qdj
 RkAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8ANdI/id9207z5JT6Ms0xNbS2iv7SSlJILOCQ6PcofQBhPC0fUWE90I0TKIMGyCXP+3ijhGUU2iNtXCNPplJx1B+uzBg=
X-Gm-Message-State: AOJu0YwVUW2udIEDqV4YfZFUop0za7FLLLjin76g1TjBqUqdzWJvYkiU
 hGCLeHsJLXljX358Kk4fJ/imyJNcd2o3fGQXRcYN+Gt6ZJuc7eSw6Btxif7xwel89sB7ItcgDkP
 ycFkVX4vpQjD4k+57q9/wMUQfcCeIYstjAGKwZg==
X-Google-Smtp-Source: AGHT+IHeb0Wb8w1LeJDcadDgvkfbFr7Bf+iwP7f2/PFG3Vh5YMHqf+9yXHXuVT8f3I6jWkjs2BHXI3KsfUaHpowm4n8=
X-Received: by 2002:a05:6902:e08:b0:dfd:a524:2dec with SMTP id
 3f1490d57ef6-e058a8cb9f6mr5563829276.25.1720936400048; Sat, 13 Jul 2024
 22:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240711025229.66260-1-yichen.wang@bytedance.com>
 <20240711025229.66260-5-yichen.wang@bytedance.com> <87zfqmd79i.fsf@suse.de>
In-Reply-To: <87zfqmd79i.fsf@suse.de>
From: Yichen Wang <yichen.wang@bytedance.com>
Date: Sat, 13 Jul 2024 22:53:09 -0700
Message-ID: <CAHObMVYZZkmu2J5iniM9bf3VUgLDFGdj3Xmk_mgcpD=3YM4BAQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 4/5] migration: Introduce 'qatzip'
 compression method
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 Hao Xiang <hao.xiang@linux.dev>, 
 "Liu, Yuan1" <yuan1.liu@intel.com>, "Zou, Nanhai" <nanhai.zou@intel.com>, 
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=yichen.wang@bytedance.com; helo=mail-yb1-xb2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, Jul 12, 2024 at 7:17=E2=80=AFAM Fabiano Rosas <farosas@suse.de> wro=
te:
>
> Yichen Wang <yichen.wang@bytedance.com> writes:
>
> > From: Bryan Zhang <bryan.zhang@bytedance.com>
> >
> > Adds support for 'qatzip' as an option for the multifd compression
> > method parameter, and implements using QAT for 'qatzip' compression and
> > decompression.
> >
> > Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
> > Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> > Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
> > ---
> >  hw/core/qdev-properties-system.c |   6 +-
> >  migration/meson.build            |   1 +
> >  migration/multifd-qatzip.c       | 403 +++++++++++++++++++++++++++++++
> >  migration/multifd.h              |   5 +-
> >  qapi/migration.json              |   3 +
> >  tests/qtest/meson.build          |   4 +
> >  6 files changed, 419 insertions(+), 3 deletions(-)
> >  create mode 100644 migration/multifd-qatzip.c
> >
> > diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties=
-system.c
> > index f13350b4fb..eb50d6ec5b 100644
> > --- a/hw/core/qdev-properties-system.c
> > +++ b/hw/core/qdev-properties-system.c
> > @@ -659,7 +659,11 @@ const PropertyInfo qdev_prop_fdc_drive_type =3D {
> >  const PropertyInfo qdev_prop_multifd_compression =3D {
> >      .name =3D "MultiFDCompression",
> >      .description =3D "multifd_compression values, "
> > -                   "none/zlib/zstd/qpl/uadk",
> > +                   "none/zlib/zstd/qpl/uadk"
> > +#ifdef CONFIG_QATZIP
> > +                   "/qatzip"
> > +#endif
>
> It seems the other accelerators don't need the ifdef. What's different
> here?

Just changed and align to other methods. Will fix in next version.

>
> > +                   ,
> >      .enum_table =3D &MultiFDCompression_lookup,
> >      .get =3D qdev_propinfo_get_enum,
> >      .set =3D qdev_propinfo_set_enum,
> > diff --git a/migration/meson.build b/migration/meson.build
> > index 5ce2acb41e..c9454c26ae 100644
> > --- a/migration/meson.build
> > +++ b/migration/meson.build
> > @@ -41,6 +41,7 @@ system_ss.add(when: rdma, if_true: files('rdma.c'))
> >  system_ss.add(when: zstd, if_true: files('multifd-zstd.c'))
> >  system_ss.add(when: qpl, if_true: files('multifd-qpl.c'))
> >  system_ss.add(when: uadk, if_true: files('multifd-uadk.c'))
> > +system_ss.add(when: qatzip, if_true: files('multifd-qatzip.c'))
> >
> >  specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
> >                  if_true: files('ram.c',
> > diff --git a/migration/multifd-qatzip.c b/migration/multifd-qatzip.c
> > new file mode 100644
> > index 0000000000..d01d51de8f
> > --- /dev/null
> > +++ b/migration/multifd-qatzip.c
> > @@ -0,0 +1,403 @@
> > +/*
> > + * Multifd QATzip compression implementation
> > + *
> > + * Copyright (c) Bytedance
> > + *
> > + * Authors:
> > + *  Bryan Zhang <bryan.zhang@bytedance.com>
> > + *  Hao Xiang <hao.xiang@bytedance.com>
> > + *  Yichen Wang <yichen.wang@bytedance.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> > + * See the COPYING file in the top-level directory.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "exec/ramblock.h"
> > +#include "qapi/error.h"
> > +#include "qemu/error-report.h"
> > +#include "qapi/qapi-types-migration.h"
> > +#include "options.h"
> > +#include "multifd.h"
> > +#include <qatzip.h>
> > +
> > +typedef struct {
> > +    /*
> > +     * Unique session for use with QATzip API
> > +     */
> > +    QzSession_T sess;
> > +
> > +    /*
> > +     * For compression: Buffer for pages to compress
> > +     * For decompression: Buffer for data to decompress
> > +     */
> > +    uint8_t *in_buf;
> > +    uint32_t in_len;
> > +
> > +    /*
> > +     * For compression: Output buffer of compressed data
> > +     * For decompression: Output buffer of decompressed data
> > +     */
> > +    uint8_t *out_buf;
> > +    uint32_t out_len;
> > +} QatzipData;
> > +
> > +/**
> > + * qatzip_send_setup: Set up QATzip session and private buffers.
> > + *
> > + * @param p    Multifd channel params
> > + * @param errp Pointer to error, which will be set in case of error
> > + * @return     0 on success, -1 on error (and *errp will be set)
> > + */
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
> > +    /* Prefer without sw_fallback because of bad performance with sw_f=
allback.
> > +     * Warn if sw_fallback needs to be used. */
>
> Please run scripts/checkpatch.pl on your series. This style of comments
> should have been flagged as non-conformant with our guidelines.

Sorry for that. Will fix in next version.

>
> > +    ret =3D qzInit(&q->sess, false);
> > +    if (ret !=3D QZ_OK && ret !=3D QZ_DUPLICATE) {
> > +        /* Warn, and try with sw_fallback. */
> > +        warn_report("Initilizing QAT with sw_fallback...");
>
> This will warn for each multifd channel, maybe use warn_report_once
> instead. Also s/Initilizing/Initializing/ and let's spell out "software
> fallback".
>

Will fix in next version.

> > +        ret =3D qzInit(&q->sess, true);
> > +        if (ret !=3D QZ_OK && ret !=3D QZ_DUPLICATE) {
> > +            /* Warn, and try with sw_fallback. */
> > +            err_msg =3D "qzInit failed";
> > +            goto err_free_q;
> > +        }
> > +    }
> > +
> > +    ret =3D qzGetDefaultsDeflate(&params);
> > +    if (ret !=3D QZ_OK) {
> > +        err_msg =3D "qzGetDefaultsDeflate failed";
> > +        goto err_close;
> > +    }
> > +
> > +    /* Make sure to use configured QATzip compression level. */
> > +    params.common_params.comp_lvl =3D migrate_multifd_qatzip_level();
> > +
> > +    ret =3D qzSetupSessionDeflate(&q->sess, &params);
> > +    if (ret !=3D QZ_OK && ret !=3D QZ_DUPLICATE) {
> > +        err_msg =3D "qzSetupSessionDeflate failed";
> > +        goto err_close;
> > +    }
> > +
> > +    if (MULTIFD_PACKET_SIZE > UINT32_MAX) {
> > +        err_msg =3D "packet size too large for QAT";
> > +        goto err_close;
> > +    }
> > +
> > +    q->in_len =3D MULTIFD_PACKET_SIZE;
> > +    q->in_buf =3D qzMalloc(q->in_len, 0, PINNED_MEM);
> > +    if (!q->in_buf) {
> > +        err_msg =3D "qzMalloc failed";
> > +        goto err_close;
> > +    }
> > +
> > +    q->out_len =3D qzMaxCompressedLength(MULTIFD_PACKET_SIZE, &q->sess=
);
> > +    q->out_buf =3D qzMalloc(q->out_len, 0, PINNED_MEM);
> > +    if (!q->out_buf) {
> > +        err_msg =3D "qzMalloc failed";
> > +        goto err_free_inbuf;
> > +    }
> > +
> > +    return 0;
> > +
> > +err_free_inbuf:
> > +    qzFree(q->in_buf);
> > +err_close:
> > +    qzClose(&q->sess);
> > +err_free_q:
> > +    g_free(q);
> > +    g_free(p->iov);
> > +    p->iov =3D NULL;
> > +    p->compress_data =3D NULL;
> > +    error_setg(errp, "multifd %u: %s", p->id, err_msg);
> > +    return -1;
> > +}
> > +
> > +/**
> > + * qatzip_send_cleanup: Tear down QATzip session and release private b=
uffers.
> > + *
> > + * @param p    Multifd channel params
> > + * @param errp Pointer to error, which will be set in case of error
> > + * @return     None
> > + */
> > +static void qatzip_send_cleanup(MultiFDSendParams *p, Error **errp)
> > +{
> > +    QatzipData *q =3D p->compress_data;
> > +    const char *err_msg;
> > +    int ret;
> > +
> > +    ret =3D qzTeardownSession(&q->sess);
> > +    if (ret !=3D QZ_OK) {
> > +        err_msg =3D "qzTeardownSession failed";
> > +        goto err;
> > +    }
> > +
> > +    ret =3D qzClose(&q->sess);
> > +    if (ret !=3D QZ_OK) {
> > +        err_msg =3D "qzClose failed";
> > +        goto err;
> > +    }
>
> Can qzClose() be called twice on the same session pointer? It's possible
> that we have already failed at multifd_send_setup() and still reach
> here.
>
> And what about qzTeardownSession()? Can it cope with an already closed
> session?
>
> And what about the sessions that never got created because we might have
> exited early at the ops->send_setup() loop?
>

qzTeardownSession() and qzClose() are safe to call on NULL pointers.
But thanks to your comments which corrected my understanding. These
patch was wrote under the impression that when setup() failed,
cleanup() won't be fired. After learning in gdb, apparently I was
wrong. The cleanup() will be called from another thread, which will be
called regardless if setup() returns zero or non-zero. I will rewrite
the setup()/cleanup() logics in my next patchset.

> > +
> > +    qzFree(q->in_buf);
> > +    q->in_buf =3D NULL;
> > +    qzFree(q->out_buf);
> > +    q->out_buf =3D NULL;
>
> These will double free here if send_setup has already freed.
>
> > +    g_free(p->iov);
> > +    p->iov =3D NULL;
> > +    g_free(p->compress_data);
> > +    p->compress_data =3D NULL;
> > +    return;
> > +
> > +err:
> > +    error_setg(errp, "multifd %u: %s", p->id, err_msg);
> > +}
> > +
> > +/**
> > + * qatzip_send_prepare: Compress pages and update IO channel info.
> > + *
> > + * @param p    Multifd channel params
> > + * @param errp Pointer to error, which will be set in case of error
> > + * @return     0 on success, -1 on error (and *errp will be set)
> > + */
> > +static int qatzip_send_prepare(MultiFDSendParams *p, Error **errp)
> > +{
> > +    MultiFDPages_t *pages =3D p->pages;
> > +    QatzipData *q =3D p->compress_data;
> > +    int ret;
> > +    unsigned int in_len, out_len;
> > +
> > +    if (!multifd_send_prepare_common(p)) {
> > +        goto out;
> > +    }
> > +
> > +    /* Unlike other multifd compression implementations, we use a
> > +     * non-streaming API and place all the data into one buffer, rathe=
r than
> > +     * sending each page to the compression API at a time. */
> > +    for (int i =3D 0; i < pages->normal_num; i++) {
> > +        memcpy(q->in_buf + (i * p->page_size),
> > +               p->pages->block->host + pages->offset[i],
>
> pages->block->host
>

I am not sure if I understand your comment here?

> > +               p->page_size);
> > +    }
> > +
> > +    in_len =3D pages->normal_num * p->page_size;
> > +    if (in_len > q->in_len) {
> > +        error_setg(errp, "multifd %u: unexpectedly large input", p->id=
);
> > +        return -1;
> > +    }
> > +    out_len =3D q->out_len;
> > +
> > +    /*
> > +     * Unlike other multifd compression implementations, we use a non-=
streaming
> > +     * API and place all the data into one buffer, rather than sending=
 each page
> > +     * to the compression API at a time. Based on initial benchmarks, =
the
> > +     * non-streaming API outperforms the streaming API. Plus, the logi=
c in QEMU
> > +     * is friendly to using the non-streaming API anyway. If either of=
 these
> > +     * statements becomes no longer true, we can revisit adding a stre=
aming
> > +     * implementation.
> > +     */
> > +    ret =3D qzCompress(&q->sess, q->in_buf, &in_len, q->out_buf, &out_=
len, 1);
> > +    if (ret !=3D QZ_OK) {
> > +        error_setg(errp, "multifd %u: QATzip returned %d instead of QZ=
_OK",
> > +                   p->id, ret);
> > +        return -1;
> > +    }
> > +    if (in_len !=3D pages->normal_num * p->page_size) {
> > +        error_setg(errp, "multifd %u: QATzip failed to compress all in=
put",
> > +                   p->id);
> > +        return -1;
> > +    }
> > +
> > +    p->iov[p->iovs_num].iov_base =3D q->out_buf;
> > +    p->iov[p->iovs_num].iov_len =3D out_len;
> > +    p->iovs_num++;
> > +    p->next_packet_size =3D out_len;
> > +
> > +out:
> > +    p->flags |=3D MULTIFD_FLAG_QATZIP;
> > +    multifd_send_fill_packet(p);
> > +    return 0;
> > +}
> > +
> > +/**
> > + * qatzip_recv_setup: Set up QATzip session and allocate private buffe=
rs.
> > + *
> > + * @param p    Multifd channel params
> > + * @param errp Pointer to error, which will be set in case of error
> > + * @return     0 on success, -1 on error (and *errp will be set)
> > + */
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
> > +    /* Prefer without sw_fallback because of bad performance with sw_f=
allback.
> > +     * Warn if sw_fallback needs to be used. */
> > +    ret =3D qzInit(&q->sess, false);
> > +    if (ret !=3D QZ_OK && ret !=3D QZ_DUPLICATE) {
> > +        /* Warn, and try with sw_fallback. */
> > +        warn_report("Initilizing QAT with sw_fallback...");
>
> Same here. Also please add a hint that this is recv and the other one is
> send. It helps with debug.

Will fix in next version.

>
> > +        ret =3D qzInit(&q->sess, true);
> > +        if (ret !=3D QZ_OK && ret !=3D QZ_DUPLICATE) {
> > +            /* Warn, and try with sw_fallback. */
> > +            err_msg =3D "qzInit failed";
> > +            goto err_free_q;
> > +        }
> > +    }
> > +
> > +    ret =3D qzGetDefaultsDeflate(&params);
> > +    if (ret !=3D QZ_OK) {
> > +        err_msg =3D "qzGetDefaultsDeflate failed";
> > +        goto err_close;
> > +    }
> > +
> > +    ret =3D qzSetupSessionDeflate(&q->sess, &params);
> > +    if (ret !=3D QZ_OK && ret !=3D QZ_DUPLICATE) {
> > +        err_msg =3D "qzSetupSessionDeflate failed";
> > +        goto err_close;
> > +    }
> > +
> > +    /*
> > +     * Mimic multifd-zlib, which reserves extra space for the
> > +     * incoming packet.
>
> I'd put the actual rationale here. It will also help in the future to
> spot that this implementation doesn't send uncompressed pages in case
> the compression got too big.

Will fix in next version.

>
> > +     */
> > +    q->in_len =3D MULTIFD_PACKET_SIZE * 2;
> > +    /* PINNED_MEM is an enum from qatzip headers, which means to use
> > +     * kzalloc_node() to allocate memory for QAT DMA purposes. */
> > +    q->in_buf =3D qzMalloc(q->in_len, 0, PINNED_MEM);
> > +    if (!q->in_buf) {
> > +        err_msg =3D "qzMalloc failed";
> > +        goto err_close;
> > +    }
> > +
> > +    q->out_len =3D MULTIFD_PACKET_SIZE;
> > +    q->out_buf =3D qzMalloc(q->out_len, 0, PINNED_MEM);
> > +    if (!q->out_buf) {
> > +        err_msg =3D "qzMalloc failed";
> > +        goto err_free_inbuf;
> > +    }
> > +
> > +    return 0;
> > +
> > +err_free_inbuf:
> > +    qzFree(q->in_buf);
> > +err_close:
> > +    qzClose(&q->sess);
> > +err_free_q:
> > +    g_free(q);
> > +    p->compress_data =3D NULL;
> > +    error_setg(errp, "multifd %u: %s", p->id, err_msg);
>
> Or maybe put the recv/send information on this string.
>

Will fix in next version.

> > +    return -1;
> > +}
> > +
> > +/**
> > + * qatzip_recv_cleanup: Tear down QATzip session and release private b=
uffers.
> > + *
> > + * @param p    Multifd channel params
> > + * @return     None
> > + */
> > +static void qatzip_recv_cleanup(MultiFDRecvParams *p)
> > +{
> > +    QatzipData *q =3D p->compress_data;
> > +
> > +    /* Ignoring return values here due to function signature. */
> > +    qzTeardownSession(&q->sess);
> > +    qzClose(&q->sess);
> > +    qzFree(q->in_buf);
> > +    qzFree(q->out_buf);
> > +    g_free(p->compress_data);
> > +}
> > +
> > +
> > +/**
> > + * qatzip_recv: Decompress pages and copy them to the appropriate
> > + * locations.
> > + *
> > + * @param p    Multifd channel params
> > + * @param errp Pointer to error, which will be set in case of error
> > + * @return     0 on success, -1 on error (and *errp will be set)
> > + */
> > +static int qatzip_recv(MultiFDRecvParams *p, Error **errp)
> > +{
> > +    QatzipData *q =3D p->compress_data;
> > +    int ret;
> > +    unsigned int in_len, out_len;
> > +    uint32_t in_size =3D p->next_packet_size;
> > +    uint32_t expected_size =3D p->normal_num * p->page_size;
> > +    uint32_t flags =3D p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
> > +
> > +    if (in_size > q->in_len) {
> > +        error_setg(errp, "multifd %u: received unexpectedly large pack=
et",
> > +                   p->id);
> > +        return -1;
> > +    }
> > +
> > +    if (flags !=3D MULTIFD_FLAG_QATZIP) {
> > +        error_setg(errp, "multifd %u: flags received %x flags expected=
 %x",
> > +                   p->id, flags, MULTIFD_FLAG_QATZIP);
> > +        return -1;
> > +    }
> > +
> > +    multifd_recv_zero_page_process(p);
> > +    if (!p->normal_num) {
> > +        assert(in_size =3D=3D 0);
> > +        return 0;
> > +    }
> > +
> > +    ret =3D qio_channel_read_all(p->c, (void *)q->in_buf, in_size, err=
p);
> > +    if (ret !=3D 0) {
> > +        return ret;
> > +    }
> > +
> > +    in_len =3D in_size;
> > +    out_len =3D q->out_len;
> > +    ret =3D qzDecompress(&q->sess, q->in_buf, &in_len, q->out_buf, &ou=
t_len);
> > +    if (ret !=3D QZ_OK) {
> > +        error_setg(errp, "multifd %u: qzDecompress failed", p->id);
> > +        return -1;
> > +    }
> > +    if (out_len !=3D expected_size) {
> > +        error_setg(errp, "multifd %u: packet size received %u size exp=
ected %u",
> > +                   p->id, out_len, expected_size);
> > +        return -1;
> > +    }
> > +
> > +    /* Copy each page to its appropriate location. */
> > +    for (int i =3D 0; i < p->normal_num; i++) {
> > +        memcpy(p->host + p->normal[i],
> > +               q->out_buf + p->page_size * i,
> > +               p->page_size);
> > +    }
> > +    return 0;
> > +}
> > +
> > +static MultiFDMethods multifd_qatzip_ops =3D {
> > +    .send_setup =3D qatzip_send_setup,
> > +    .send_cleanup =3D qatzip_send_cleanup,
> > +    .send_prepare =3D qatzip_send_prepare,
> > +    .recv_setup =3D qatzip_recv_setup,
> > +    .recv_cleanup =3D qatzip_recv_cleanup,
> > +    .recv =3D qatzip_recv
> > +};
> > +
> > +static void multifd_qatzip_register(void)
> > +{
> > +    multifd_register_ops(MULTIFD_COMPRESSION_QATZIP, &multifd_qatzip_o=
ps);
> > +}
> > +
> > +migration_init(multifd_qatzip_register);
> > diff --git a/migration/multifd.h b/migration/multifd.h
> > index 0ecd6f47d7..adceb65050 100644
> > --- a/migration/multifd.h
> > +++ b/migration/multifd.h
> > @@ -34,14 +34,15 @@ MultiFDRecvData *multifd_get_recv_data(void);
> >  /* Multifd Compression flags */
> >  #define MULTIFD_FLAG_SYNC (1 << 0)
> >
> > -/* We reserve 4 bits for compression methods */
> > -#define MULTIFD_FLAG_COMPRESSION_MASK (0xf << 1)
> > +/* We reserve 5 bits for compression methods */
> > +#define MULTIFD_FLAG_COMPRESSION_MASK (0x1f << 1)
> >  /* we need to be compatible. Before compression value was 0 */
> >  #define MULTIFD_FLAG_NOCOMP (0 << 1)
> >  #define MULTIFD_FLAG_ZLIB (1 << 1)
> >  #define MULTIFD_FLAG_ZSTD (2 << 1)
> >  #define MULTIFD_FLAG_QPL (4 << 1)
> >  #define MULTIFD_FLAG_UADK (8 << 1)
> > +#define MULTIFD_FLAG_QATZIP (16 << 1)
> >
> >  /* This value needs to be a multiple of qemu_target_page_size() */
> >  #define MULTIFD_PACKET_SIZE (512 * 1024)
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index cd08f2f710..42b5363449 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -558,6 +558,8 @@
> >  #
> >  # @zstd: use zstd compression method.
> >  #
> > +# @qatzip: use qatzip compression method. (Since 9.1)
> > +#
> >  # @qpl: use qpl compression method.  Query Processing Library(qpl) is
> >  #       based on the deflate compression algorithm and use the Intel
> >  #       In-Memory Analytics Accelerator(IAA) accelerated compression
> > @@ -570,6 +572,7 @@
> >  { 'enum': 'MultiFDCompression',
> >    'data': [ 'none', 'zlib',
> >              { 'name': 'zstd', 'if': 'CONFIG_ZSTD' },
> > +            { 'name': 'qatzip', 'if': 'CONFIG_QATZIP'},
> >              { 'name': 'qpl', 'if': 'CONFIG_QPL' },
> >              { 'name': 'uadk', 'if': 'CONFIG_UADK' } ] }
> >
> > diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> > index 6508bfb1a2..3068d73e08 100644
> > --- a/tests/qtest/meson.build
> > +++ b/tests/qtest/meson.build
> > @@ -327,6 +327,10 @@ if gnutls.found()
> >    endif
> >  endif
> >
> > +if qatzip.found()
> > +  migration_files +=3D [qatzip]
> > +endif
> > +
> >  qtests =3D {
> >    'bios-tables-test': [io, 'boot-sector.c', 'acpi-utils.c', 'tpm-emu.c=
'],
> >    'cdrom-test': files('boot-sector.c'),

