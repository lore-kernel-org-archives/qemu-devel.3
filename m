Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27243C3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 16:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTOdE-00073P-M0; Mon, 15 Jul 2024 12:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sTOdD-000728-0U
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 12:32:55 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sTOd9-0007uP-TT
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 12:32:54 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 326802124B;
 Mon, 15 Jul 2024 16:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721061169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C2xgsL6pqRPZuC2GrVCqUG0NeOaVti+n7kY9ugeAibk=;
 b=XRHnfc644NamDR0PDGLjA/vMODEr3bBKAsVOfmc7avOOnOLyP5Rs6mNohW315OtgSAI7QM
 rkD/gHGUDLcG34H2/MK5we9XD20C1k62sn8IBySQSCUnOIICII8IQrgX1xwH06byOBt9JQ
 /PYfdn4sT6pzQ9sRlGByu5v/hlg7CWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721061169;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C2xgsL6pqRPZuC2GrVCqUG0NeOaVti+n7kY9ugeAibk=;
 b=8QebKfm8smxIFrb0w7Zeuv2ykOs4OHnVdM5VZ6/7JmyXJmTmK9Y1/G4e8eG/fVtvh04hyn
 Ws5jZHDKIOLEPCCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721061169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C2xgsL6pqRPZuC2GrVCqUG0NeOaVti+n7kY9ugeAibk=;
 b=XRHnfc644NamDR0PDGLjA/vMODEr3bBKAsVOfmc7avOOnOLyP5Rs6mNohW315OtgSAI7QM
 rkD/gHGUDLcG34H2/MK5we9XD20C1k62sn8IBySQSCUnOIICII8IQrgX1xwH06byOBt9JQ
 /PYfdn4sT6pzQ9sRlGByu5v/hlg7CWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721061169;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C2xgsL6pqRPZuC2GrVCqUG0NeOaVti+n7kY9ugeAibk=;
 b=8QebKfm8smxIFrb0w7Zeuv2ykOs4OHnVdM5VZ6/7JmyXJmTmK9Y1/G4e8eG/fVtvh04hyn
 Ws5jZHDKIOLEPCCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4688137EB;
 Mon, 15 Jul 2024 16:32:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 755JGjBPlWaTFAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Jul 2024 16:32:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Yichen Wang <yichen.wang@bytedance.com>
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1"
 <yuan1.liu@intel.com>, "Zou, Nanhai" <nanhai.zou@intel.com>, "Ho-Ren
 (Jack) Chuang" <horenchuang@bytedance.com>, Bryan Zhang
 <bryan.zhang@bytedance.com>
Subject: Re: [External] Re: [PATCH v5 4/5] migration: Introduce 'qatzip'
 compression method
In-Reply-To: <CAHObMVYZZkmu2J5iniM9bf3VUgLDFGdj3Xmk_mgcpD=3YM4BAQ@mail.gmail.com>
References: <20240711025229.66260-1-yichen.wang@bytedance.com>
 <20240711025229.66260-5-yichen.wang@bytedance.com>
 <87zfqmd79i.fsf@suse.de>
 <CAHObMVYZZkmu2J5iniM9bf3VUgLDFGdj3Xmk_mgcpD=3YM4BAQ@mail.gmail.com>
Date: Mon, 15 Jul 2024 13:32:46 -0300
Message-ID: <87ttgqd39t.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[17]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Yichen Wang <yichen.wang@bytedance.com> writes:

> On Fri, Jul 12, 2024 at 7:17=E2=80=AFAM Fabiano Rosas <farosas@suse.de> w=
rote:
>>
>> Yichen Wang <yichen.wang@bytedance.com> writes:
>>
>> > From: Bryan Zhang <bryan.zhang@bytedance.com>
>> >
>> > Adds support for 'qatzip' as an option for the multifd compression
>> > method parameter, and implements using QAT for 'qatzip' compression and
>> > decompression.
>> >
>> > Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
>> > Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
>> > Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
>> > ---
>> >  hw/core/qdev-properties-system.c |   6 +-
>> >  migration/meson.build            |   1 +
>> >  migration/multifd-qatzip.c       | 403 +++++++++++++++++++++++++++++++
>> >  migration/multifd.h              |   5 +-
>> >  qapi/migration.json              |   3 +
>> >  tests/qtest/meson.build          |   4 +
>> >  6 files changed, 419 insertions(+), 3 deletions(-)
>> >  create mode 100644 migration/multifd-qatzip.c
>> >
>> > diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-propertie=
s-system.c
>> > index f13350b4fb..eb50d6ec5b 100644
>> > --- a/hw/core/qdev-properties-system.c
>> > +++ b/hw/core/qdev-properties-system.c
>> > @@ -659,7 +659,11 @@ const PropertyInfo qdev_prop_fdc_drive_type =3D {
>> >  const PropertyInfo qdev_prop_multifd_compression =3D {
>> >      .name =3D "MultiFDCompression",
>> >      .description =3D "multifd_compression values, "
>> > -                   "none/zlib/zstd/qpl/uadk",
>> > +                   "none/zlib/zstd/qpl/uadk"
>> > +#ifdef CONFIG_QATZIP
>> > +                   "/qatzip"
>> > +#endif
>>
>> It seems the other accelerators don't need the ifdef. What's different
>> here?
>
> Just changed and align to other methods. Will fix in next version.
>
>>
>> > +                   ,
>> >      .enum_table =3D &MultiFDCompression_lookup,
>> >      .get =3D qdev_propinfo_get_enum,
>> >      .set =3D qdev_propinfo_set_enum,
>> > diff --git a/migration/meson.build b/migration/meson.build
>> > index 5ce2acb41e..c9454c26ae 100644
>> > --- a/migration/meson.build
>> > +++ b/migration/meson.build
>> > @@ -41,6 +41,7 @@ system_ss.add(when: rdma, if_true: files('rdma.c'))
>> >  system_ss.add(when: zstd, if_true: files('multifd-zstd.c'))
>> >  system_ss.add(when: qpl, if_true: files('multifd-qpl.c'))
>> >  system_ss.add(when: uadk, if_true: files('multifd-uadk.c'))
>> > +system_ss.add(when: qatzip, if_true: files('multifd-qatzip.c'))
>> >
>> >  specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
>> >                  if_true: files('ram.c',
>> > diff --git a/migration/multifd-qatzip.c b/migration/multifd-qatzip.c
>> > new file mode 100644
>> > index 0000000000..d01d51de8f
>> > --- /dev/null
>> > +++ b/migration/multifd-qatzip.c
>> > @@ -0,0 +1,403 @@
>> > +/*
>> > + * Multifd QATzip compression implementation
>> > + *
>> > + * Copyright (c) Bytedance
>> > + *
>> > + * Authors:
>> > + *  Bryan Zhang <bryan.zhang@bytedance.com>
>> > + *  Hao Xiang <hao.xiang@bytedance.com>
>> > + *  Yichen Wang <yichen.wang@bytedance.com>
>> > + *
>> > + * This work is licensed under the terms of the GNU GPL, version 2 or=
 later.
>> > + * See the COPYING file in the top-level directory.
>> > + */
>> > +
>> > +#include "qemu/osdep.h"
>> > +#include "exec/ramblock.h"
>> > +#include "qapi/error.h"
>> > +#include "qemu/error-report.h"
>> > +#include "qapi/qapi-types-migration.h"
>> > +#include "options.h"
>> > +#include "multifd.h"
>> > +#include <qatzip.h>
>> > +
>> > +typedef struct {
>> > +    /*
>> > +     * Unique session for use with QATzip API
>> > +     */
>> > +    QzSession_T sess;
>> > +
>> > +    /*
>> > +     * For compression: Buffer for pages to compress
>> > +     * For decompression: Buffer for data to decompress
>> > +     */
>> > +    uint8_t *in_buf;
>> > +    uint32_t in_len;
>> > +
>> > +    /*
>> > +     * For compression: Output buffer of compressed data
>> > +     * For decompression: Output buffer of decompressed data
>> > +     */
>> > +    uint8_t *out_buf;
>> > +    uint32_t out_len;
>> > +} QatzipData;
>> > +
>> > +/**
>> > + * qatzip_send_setup: Set up QATzip session and private buffers.
>> > + *
>> > + * @param p    Multifd channel params
>> > + * @param errp Pointer to error, which will be set in case of error
>> > + * @return     0 on success, -1 on error (and *errp will be set)
>> > + */
>> > +static int qatzip_send_setup(MultiFDSendParams *p, Error **errp)
>> > +{
>> > +    QatzipData *q;
>> > +    QzSessionParamsDeflate_T params;
>> > +    const char *err_msg;
>> > +    int ret;
>> > +
>> > +    q =3D g_new0(QatzipData, 1);
>> > +    p->compress_data =3D q;
>> > +    /* We need one extra place for the packet header */
>> > +    p->iov =3D g_new0(struct iovec, 2);
>> > +
>> > +    /* Prefer without sw_fallback because of bad performance with sw_=
fallback.
>> > +     * Warn if sw_fallback needs to be used. */
>>
>> Please run scripts/checkpatch.pl on your series. This style of comments
>> should have been flagged as non-conformant with our guidelines.
>
> Sorry for that. Will fix in next version.
>
>>
>> > +    ret =3D qzInit(&q->sess, false);
>> > +    if (ret !=3D QZ_OK && ret !=3D QZ_DUPLICATE) {
>> > +        /* Warn, and try with sw_fallback. */
>> > +        warn_report("Initilizing QAT with sw_fallback...");
>>
>> This will warn for each multifd channel, maybe use warn_report_once
>> instead. Also s/Initilizing/Initializing/ and let's spell out "software
>> fallback".
>>
>
> Will fix in next version.
>
>> > +        ret =3D qzInit(&q->sess, true);
>> > +        if (ret !=3D QZ_OK && ret !=3D QZ_DUPLICATE) {
>> > +            /* Warn, and try with sw_fallback. */
>> > +            err_msg =3D "qzInit failed";
>> > +            goto err_free_q;
>> > +        }
>> > +    }
>> > +
>> > +    ret =3D qzGetDefaultsDeflate(&params);
>> > +    if (ret !=3D QZ_OK) {
>> > +        err_msg =3D "qzGetDefaultsDeflate failed";
>> > +        goto err_close;
>> > +    }
>> > +
>> > +    /* Make sure to use configured QATzip compression level. */
>> > +    params.common_params.comp_lvl =3D migrate_multifd_qatzip_level();
>> > +
>> > +    ret =3D qzSetupSessionDeflate(&q->sess, &params);
>> > +    if (ret !=3D QZ_OK && ret !=3D QZ_DUPLICATE) {
>> > +        err_msg =3D "qzSetupSessionDeflate failed";
>> > +        goto err_close;
>> > +    }
>> > +
>> > +    if (MULTIFD_PACKET_SIZE > UINT32_MAX) {
>> > +        err_msg =3D "packet size too large for QAT";
>> > +        goto err_close;
>> > +    }
>> > +
>> > +    q->in_len =3D MULTIFD_PACKET_SIZE;
>> > +    q->in_buf =3D qzMalloc(q->in_len, 0, PINNED_MEM);
>> > +    if (!q->in_buf) {
>> > +        err_msg =3D "qzMalloc failed";
>> > +        goto err_close;
>> > +    }
>> > +
>> > +    q->out_len =3D qzMaxCompressedLength(MULTIFD_PACKET_SIZE, &q->ses=
s);
>> > +    q->out_buf =3D qzMalloc(q->out_len, 0, PINNED_MEM);
>> > +    if (!q->out_buf) {
>> > +        err_msg =3D "qzMalloc failed";
>> > +        goto err_free_inbuf;
>> > +    }
>> > +
>> > +    return 0;
>> > +
>> > +err_free_inbuf:
>> > +    qzFree(q->in_buf);
>> > +err_close:
>> > +    qzClose(&q->sess);
>> > +err_free_q:
>> > +    g_free(q);
>> > +    g_free(p->iov);
>> > +    p->iov =3D NULL;
>> > +    p->compress_data =3D NULL;
>> > +    error_setg(errp, "multifd %u: %s", p->id, err_msg);
>> > +    return -1;
>> > +}
>> > +
>> > +/**
>> > + * qatzip_send_cleanup: Tear down QATzip session and release private =
buffers.
>> > + *
>> > + * @param p    Multifd channel params
>> > + * @param errp Pointer to error, which will be set in case of error
>> > + * @return     None
>> > + */
>> > +static void qatzip_send_cleanup(MultiFDSendParams *p, Error **errp)
>> > +{
>> > +    QatzipData *q =3D p->compress_data;
>> > +    const char *err_msg;
>> > +    int ret;
>> > +
>> > +    ret =3D qzTeardownSession(&q->sess);
>> > +    if (ret !=3D QZ_OK) {
>> > +        err_msg =3D "qzTeardownSession failed";
>> > +        goto err;
>> > +    }
>> > +
>> > +    ret =3D qzClose(&q->sess);
>> > +    if (ret !=3D QZ_OK) {
>> > +        err_msg =3D "qzClose failed";
>> > +        goto err;
>> > +    }
>>
>> Can qzClose() be called twice on the same session pointer? It's possible
>> that we have already failed at multifd_send_setup() and still reach
>> here.
>>
>> And what about qzTeardownSession()? Can it cope with an already closed
>> session?
>>
>> And what about the sessions that never got created because we might have
>> exited early at the ops->send_setup() loop?
>>
>
> qzTeardownSession() and qzClose() are safe to call on NULL pointers.
> But thanks to your comments which corrected my understanding. These
> patch was wrote under the impression that when setup() failed,
> cleanup() won't be fired. After learning in gdb, apparently I was
> wrong. The cleanup() will be called from another thread, which will be
> called regardless if setup() returns zero or non-zero. I will rewrite
> the setup()/cleanup() logics in my next patchset.
>
>> > +
>> > +    qzFree(q->in_buf);
>> > +    q->in_buf =3D NULL;
>> > +    qzFree(q->out_buf);
>> > +    q->out_buf =3D NULL;
>>
>> These will double free here if send_setup has already freed.
>>
>> > +    g_free(p->iov);
>> > +    p->iov =3D NULL;
>> > +    g_free(p->compress_data);
>> > +    p->compress_data =3D NULL;
>> > +    return;
>> > +
>> > +err:
>> > +    error_setg(errp, "multifd %u: %s", p->id, err_msg);
>> > +}
>> > +
>> > +/**
>> > + * qatzip_send_prepare: Compress pages and update IO channel info.
>> > + *
>> > + * @param p    Multifd channel params
>> > + * @param errp Pointer to error, which will be set in case of error
>> > + * @return     0 on success, -1 on error (and *errp will be set)
>> > + */
>> > +static int qatzip_send_prepare(MultiFDSendParams *p, Error **errp)
>> > +{
>> > +    MultiFDPages_t *pages =3D p->pages;
>> > +    QatzipData *q =3D p->compress_data;
>> > +    int ret;
>> > +    unsigned int in_len, out_len;
>> > +
>> > +    if (!multifd_send_prepare_common(p)) {
>> > +        goto out;
>> > +    }
>> > +
>> > +    /* Unlike other multifd compression implementations, we use a
>> > +     * non-streaming API and place all the data into one buffer, rath=
er than
>> > +     * sending each page to the compression API at a time. */
>> > +    for (int i =3D 0; i < pages->normal_num; i++) {
>> > +        memcpy(q->in_buf + (i * p->page_size),
>> > +               p->pages->block->host + pages->offset[i],
>>
>> pages->block->host
>>
>
> I am not sure if I understand your comment here?

You're holding the pointer to p->pages in the local pages variable. I'm
suggesting you use it instead of p->pages here. In another series[1], we're
looking into changing p->pages into something else and having to change
it all over the code gets bothersome.

1- https://lore.kernel.org/r/20240620212111.29319-2-farosas@suse.de


