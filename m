Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF3EC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 14:19:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSH5v-0002zY-8p; Fri, 12 Jul 2024 10:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sSH5k-0002JW-I2
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:17:46 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sSH5b-0003ge-7q
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:17:40 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 589961FB81;
 Fri, 12 Jul 2024 14:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720793853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iE4d9ZMA9ZOQ7YgW6tSmOuDS57KAu3W2Z+NkZZgCUF4=;
 b=HKBsCNTP5Wq88udL5SEZnvSSNvMAyQ9yXeIdJ4JzVe8WW/wZYpnBzmSpgAXHv+OCLdZ2ya
 qWvBKdHK0ry5L4V5H8+ghCQWgwH9B1R157ZsdpbZ0YxIf97Cx98rF2EHq60wCNXbhD94Aw
 567QmJoq4GSUa4S/dYMOQZ71odAwJzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720793853;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iE4d9ZMA9ZOQ7YgW6tSmOuDS57KAu3W2Z+NkZZgCUF4=;
 b=H1hkXvfZfFXM8wPJRoen9Dprk+Dn9rfMqGN+A9iaNeVPvpZPNLKKzOdhsWaU5l9sLGA8o5
 Ah461+prQxDP6/CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720793853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iE4d9ZMA9ZOQ7YgW6tSmOuDS57KAu3W2Z+NkZZgCUF4=;
 b=HKBsCNTP5Wq88udL5SEZnvSSNvMAyQ9yXeIdJ4JzVe8WW/wZYpnBzmSpgAXHv+OCLdZ2ya
 qWvBKdHK0ry5L4V5H8+ghCQWgwH9B1R157ZsdpbZ0YxIf97Cx98rF2EHq60wCNXbhD94Aw
 567QmJoq4GSUa4S/dYMOQZ71odAwJzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720793853;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iE4d9ZMA9ZOQ7YgW6tSmOuDS57KAu3W2Z+NkZZgCUF4=;
 b=H1hkXvfZfFXM8wPJRoen9Dprk+Dn9rfMqGN+A9iaNeVPvpZPNLKKzOdhsWaU5l9sLGA8o5
 Ah461+prQxDP6/CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD08A1373E;
 Fri, 12 Jul 2024 14:17:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wTIyJPw6kWZXdgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 12 Jul 2024 14:17:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Yichen Wang <yichen.wang@bytedance.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, =?utf-8?Q?M?=
 =?utf-8?Q?arc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>, "Ho-Ren (Jack) Chuang"
 <horenchuang@bytedance.com>, Yichen Wang <yichen.wang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: Re: [PATCH v5 4/5] migration: Introduce 'qatzip' compression method
In-Reply-To: <20240711025229.66260-5-yichen.wang@bytedance.com>
References: <20240711025229.66260-1-yichen.wang@bytedance.com>
 <20240711025229.66260-5-yichen.wang@bytedance.com>
Date: Fri, 12 Jul 2024 11:17:29 -0300
Message-ID: <87zfqmd79i.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-0.30 / 50.00];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[18]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

> From: Bryan Zhang <bryan.zhang@bytedance.com>
>
> Adds support for 'qatzip' as an option for the multifd compression
> method parameter, and implements using QAT for 'qatzip' compression and
> decompression.
>
> Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
> Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
> ---
>  hw/core/qdev-properties-system.c |   6 +-
>  migration/meson.build            |   1 +
>  migration/multifd-qatzip.c       | 403 +++++++++++++++++++++++++++++++
>  migration/multifd.h              |   5 +-
>  qapi/migration.json              |   3 +
>  tests/qtest/meson.build          |   4 +
>  6 files changed, 419 insertions(+), 3 deletions(-)
>  create mode 100644 migration/multifd-qatzip.c
>
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> index f13350b4fb..eb50d6ec5b 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -659,7 +659,11 @@ const PropertyInfo qdev_prop_fdc_drive_type = {
>  const PropertyInfo qdev_prop_multifd_compression = {
>      .name = "MultiFDCompression",
>      .description = "multifd_compression values, "
> -                   "none/zlib/zstd/qpl/uadk",
> +                   "none/zlib/zstd/qpl/uadk"
> +#ifdef CONFIG_QATZIP
> +                   "/qatzip"
> +#endif

It seems the other accelerators don't need the ifdef. What's different
here?

> +                   ,
>      .enum_table = &MultiFDCompression_lookup,
>      .get = qdev_propinfo_get_enum,
>      .set = qdev_propinfo_set_enum,
> diff --git a/migration/meson.build b/migration/meson.build
> index 5ce2acb41e..c9454c26ae 100644
> --- a/migration/meson.build
> +++ b/migration/meson.build
> @@ -41,6 +41,7 @@ system_ss.add(when: rdma, if_true: files('rdma.c'))
>  system_ss.add(when: zstd, if_true: files('multifd-zstd.c'))
>  system_ss.add(when: qpl, if_true: files('multifd-qpl.c'))
>  system_ss.add(when: uadk, if_true: files('multifd-uadk.c'))
> +system_ss.add(when: qatzip, if_true: files('multifd-qatzip.c'))
>  
>  specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
>                  if_true: files('ram.c',
> diff --git a/migration/multifd-qatzip.c b/migration/multifd-qatzip.c
> new file mode 100644
> index 0000000000..d01d51de8f
> --- /dev/null
> +++ b/migration/multifd-qatzip.c
> @@ -0,0 +1,403 @@
> +/*
> + * Multifd QATzip compression implementation
> + *
> + * Copyright (c) Bytedance
> + *
> + * Authors:
> + *  Bryan Zhang <bryan.zhang@bytedance.com>
> + *  Hao Xiang <hao.xiang@bytedance.com>
> + *  Yichen Wang <yichen.wang@bytedance.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "exec/ramblock.h"
> +#include "qapi/error.h"
> +#include "qemu/error-report.h"
> +#include "qapi/qapi-types-migration.h"
> +#include "options.h"
> +#include "multifd.h"
> +#include <qatzip.h>
> +
> +typedef struct {
> +    /*
> +     * Unique session for use with QATzip API
> +     */
> +    QzSession_T sess;
> +
> +    /*
> +     * For compression: Buffer for pages to compress
> +     * For decompression: Buffer for data to decompress
> +     */
> +    uint8_t *in_buf;
> +    uint32_t in_len;
> +
> +    /*
> +     * For compression: Output buffer of compressed data
> +     * For decompression: Output buffer of decompressed data
> +     */
> +    uint8_t *out_buf;
> +    uint32_t out_len;
> +} QatzipData;
> +
> +/**
> + * qatzip_send_setup: Set up QATzip session and private buffers.
> + *
> + * @param p    Multifd channel params
> + * @param errp Pointer to error, which will be set in case of error
> + * @return     0 on success, -1 on error (and *errp will be set)
> + */
> +static int qatzip_send_setup(MultiFDSendParams *p, Error **errp)
> +{
> +    QatzipData *q;
> +    QzSessionParamsDeflate_T params;
> +    const char *err_msg;
> +    int ret;
> +
> +    q = g_new0(QatzipData, 1);
> +    p->compress_data = q;
> +    /* We need one extra place for the packet header */
> +    p->iov = g_new0(struct iovec, 2);
> +
> +    /* Prefer without sw_fallback because of bad performance with sw_fallback.
> +     * Warn if sw_fallback needs to be used. */

Please run scripts/checkpatch.pl on your series. This style of comments
should have been flagged as non-conformant with our guidelines.

> +    ret = qzInit(&q->sess, false);
> +    if (ret != QZ_OK && ret != QZ_DUPLICATE) {
> +        /* Warn, and try with sw_fallback. */
> +        warn_report("Initilizing QAT with sw_fallback...");

This will warn for each multifd channel, maybe use warn_report_once
instead. Also s/Initilizing/Initializing/ and let's spell out "software
fallback".

> +        ret = qzInit(&q->sess, true);
> +        if (ret != QZ_OK && ret != QZ_DUPLICATE) {
> +            /* Warn, and try with sw_fallback. */
> +            err_msg = "qzInit failed";
> +            goto err_free_q;
> +        }
> +    }
> +
> +    ret = qzGetDefaultsDeflate(&params);
> +    if (ret != QZ_OK) {
> +        err_msg = "qzGetDefaultsDeflate failed";
> +        goto err_close;
> +    }
> +
> +    /* Make sure to use configured QATzip compression level. */
> +    params.common_params.comp_lvl = migrate_multifd_qatzip_level();
> +
> +    ret = qzSetupSessionDeflate(&q->sess, &params);
> +    if (ret != QZ_OK && ret != QZ_DUPLICATE) {
> +        err_msg = "qzSetupSessionDeflate failed";
> +        goto err_close;
> +    }
> +
> +    if (MULTIFD_PACKET_SIZE > UINT32_MAX) {
> +        err_msg = "packet size too large for QAT";
> +        goto err_close;
> +    }
> +
> +    q->in_len = MULTIFD_PACKET_SIZE;
> +    q->in_buf = qzMalloc(q->in_len, 0, PINNED_MEM);
> +    if (!q->in_buf) {
> +        err_msg = "qzMalloc failed";
> +        goto err_close;
> +    }
> +
> +    q->out_len = qzMaxCompressedLength(MULTIFD_PACKET_SIZE, &q->sess);
> +    q->out_buf = qzMalloc(q->out_len, 0, PINNED_MEM);
> +    if (!q->out_buf) {
> +        err_msg = "qzMalloc failed";
> +        goto err_free_inbuf;
> +    }
> +
> +    return 0;
> +
> +err_free_inbuf:
> +    qzFree(q->in_buf);
> +err_close:
> +    qzClose(&q->sess);
> +err_free_q:
> +    g_free(q);
> +    g_free(p->iov);
> +    p->iov = NULL;
> +    p->compress_data = NULL;
> +    error_setg(errp, "multifd %u: %s", p->id, err_msg);
> +    return -1;
> +}
> +
> +/**
> + * qatzip_send_cleanup: Tear down QATzip session and release private buffers.
> + *
> + * @param p    Multifd channel params
> + * @param errp Pointer to error, which will be set in case of error
> + * @return     None
> + */
> +static void qatzip_send_cleanup(MultiFDSendParams *p, Error **errp)
> +{
> +    QatzipData *q = p->compress_data;
> +    const char *err_msg;
> +    int ret;
> +
> +    ret = qzTeardownSession(&q->sess);
> +    if (ret != QZ_OK) {
> +        err_msg = "qzTeardownSession failed";
> +        goto err;
> +    }
> +
> +    ret = qzClose(&q->sess);
> +    if (ret != QZ_OK) {
> +        err_msg = "qzClose failed";
> +        goto err;
> +    }

Can qzClose() be called twice on the same session pointer? It's possible
that we have already failed at multifd_send_setup() and still reach
here.

And what about qzTeardownSession()? Can it cope with an already closed
session?

And what about the sessions that never got created because we might have
exited early at the ops->send_setup() loop?

> +
> +    qzFree(q->in_buf);
> +    q->in_buf = NULL;
> +    qzFree(q->out_buf);
> +    q->out_buf = NULL;

These will double free here if send_setup has already freed.

> +    g_free(p->iov);
> +    p->iov = NULL;
> +    g_free(p->compress_data);
> +    p->compress_data = NULL;
> +    return;
> +
> +err:
> +    error_setg(errp, "multifd %u: %s", p->id, err_msg);
> +}
> +
> +/**
> + * qatzip_send_prepare: Compress pages and update IO channel info.
> + *
> + * @param p    Multifd channel params
> + * @param errp Pointer to error, which will be set in case of error
> + * @return     0 on success, -1 on error (and *errp will be set)
> + */
> +static int qatzip_send_prepare(MultiFDSendParams *p, Error **errp)
> +{
> +    MultiFDPages_t *pages = p->pages;
> +    QatzipData *q = p->compress_data;
> +    int ret;
> +    unsigned int in_len, out_len;
> +
> +    if (!multifd_send_prepare_common(p)) {
> +        goto out;
> +    }
> +
> +    /* Unlike other multifd compression implementations, we use a
> +     * non-streaming API and place all the data into one buffer, rather than
> +     * sending each page to the compression API at a time. */
> +    for (int i = 0; i < pages->normal_num; i++) {
> +        memcpy(q->in_buf + (i * p->page_size),
> +               p->pages->block->host + pages->offset[i],

pages->block->host

> +               p->page_size);
> +    }
> +
> +    in_len = pages->normal_num * p->page_size;
> +    if (in_len > q->in_len) {
> +        error_setg(errp, "multifd %u: unexpectedly large input", p->id);
> +        return -1;
> +    }
> +    out_len = q->out_len;
> +
> +    /*
> +     * Unlike other multifd compression implementations, we use a non-streaming
> +     * API and place all the data into one buffer, rather than sending each page
> +     * to the compression API at a time. Based on initial benchmarks, the
> +     * non-streaming API outperforms the streaming API. Plus, the logic in QEMU
> +     * is friendly to using the non-streaming API anyway. If either of these
> +     * statements becomes no longer true, we can revisit adding a streaming
> +     * implementation.
> +     */
> +    ret = qzCompress(&q->sess, q->in_buf, &in_len, q->out_buf, &out_len, 1);
> +    if (ret != QZ_OK) {
> +        error_setg(errp, "multifd %u: QATzip returned %d instead of QZ_OK",
> +                   p->id, ret);
> +        return -1;
> +    }
> +    if (in_len != pages->normal_num * p->page_size) {
> +        error_setg(errp, "multifd %u: QATzip failed to compress all input",
> +                   p->id);
> +        return -1;
> +    }
> +
> +    p->iov[p->iovs_num].iov_base = q->out_buf;
> +    p->iov[p->iovs_num].iov_len = out_len;
> +    p->iovs_num++;
> +    p->next_packet_size = out_len;
> +
> +out:
> +    p->flags |= MULTIFD_FLAG_QATZIP;
> +    multifd_send_fill_packet(p);
> +    return 0;
> +}
> +
> +/**
> + * qatzip_recv_setup: Set up QATzip session and allocate private buffers.
> + *
> + * @param p    Multifd channel params
> + * @param errp Pointer to error, which will be set in case of error
> + * @return     0 on success, -1 on error (and *errp will be set)
> + */
> +static int qatzip_recv_setup(MultiFDRecvParams *p, Error **errp)
> +{
> +    QatzipData *q;
> +    QzSessionParamsDeflate_T params;
> +    const char *err_msg;
> +    int ret;
> +
> +    q = g_new0(QatzipData, 1);
> +    p->compress_data = q;
> +
> +    /* Prefer without sw_fallback because of bad performance with sw_fallback.
> +     * Warn if sw_fallback needs to be used. */
> +    ret = qzInit(&q->sess, false);
> +    if (ret != QZ_OK && ret != QZ_DUPLICATE) {
> +        /* Warn, and try with sw_fallback. */
> +        warn_report("Initilizing QAT with sw_fallback...");

Same here. Also please add a hint that this is recv and the other one is
send. It helps with debug.

> +        ret = qzInit(&q->sess, true);
> +        if (ret != QZ_OK && ret != QZ_DUPLICATE) {
> +            /* Warn, and try with sw_fallback. */
> +            err_msg = "qzInit failed";
> +            goto err_free_q;
> +        }
> +    }
> +
> +    ret = qzGetDefaultsDeflate(&params);
> +    if (ret != QZ_OK) {
> +        err_msg = "qzGetDefaultsDeflate failed";
> +        goto err_close;
> +    }
> +
> +    ret = qzSetupSessionDeflate(&q->sess, &params);
> +    if (ret != QZ_OK && ret != QZ_DUPLICATE) {
> +        err_msg = "qzSetupSessionDeflate failed";
> +        goto err_close;
> +    }
> +
> +    /*
> +     * Mimic multifd-zlib, which reserves extra space for the
> +     * incoming packet.

I'd put the actual rationale here. It will also help in the future to
spot that this implementation doesn't send uncompressed pages in case
the compression got too big.

> +     */
> +    q->in_len = MULTIFD_PACKET_SIZE * 2;
> +    /* PINNED_MEM is an enum from qatzip headers, which means to use
> +     * kzalloc_node() to allocate memory for QAT DMA purposes. */
> +    q->in_buf = qzMalloc(q->in_len, 0, PINNED_MEM);
> +    if (!q->in_buf) {
> +        err_msg = "qzMalloc failed";
> +        goto err_close;
> +    }
> +
> +    q->out_len = MULTIFD_PACKET_SIZE;
> +    q->out_buf = qzMalloc(q->out_len, 0, PINNED_MEM);
> +    if (!q->out_buf) {
> +        err_msg = "qzMalloc failed";
> +        goto err_free_inbuf;
> +    }
> +
> +    return 0;
> +
> +err_free_inbuf:
> +    qzFree(q->in_buf);
> +err_close:
> +    qzClose(&q->sess);
> +err_free_q:
> +    g_free(q);
> +    p->compress_data = NULL;
> +    error_setg(errp, "multifd %u: %s", p->id, err_msg);

Or maybe put the recv/send information on this string.

> +    return -1;
> +}
> +
> +/**
> + * qatzip_recv_cleanup: Tear down QATzip session and release private buffers.
> + *
> + * @param p    Multifd channel params
> + * @return     None
> + */
> +static void qatzip_recv_cleanup(MultiFDRecvParams *p)
> +{
> +    QatzipData *q = p->compress_data;
> +
> +    /* Ignoring return values here due to function signature. */
> +    qzTeardownSession(&q->sess);
> +    qzClose(&q->sess);
> +    qzFree(q->in_buf);
> +    qzFree(q->out_buf);
> +    g_free(p->compress_data);
> +}
> +
> +
> +/**
> + * qatzip_recv: Decompress pages and copy them to the appropriate
> + * locations.
> + *
> + * @param p    Multifd channel params
> + * @param errp Pointer to error, which will be set in case of error
> + * @return     0 on success, -1 on error (and *errp will be set)
> + */
> +static int qatzip_recv(MultiFDRecvParams *p, Error **errp)
> +{
> +    QatzipData *q = p->compress_data;
> +    int ret;
> +    unsigned int in_len, out_len;
> +    uint32_t in_size = p->next_packet_size;
> +    uint32_t expected_size = p->normal_num * p->page_size;
> +    uint32_t flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
> +
> +    if (in_size > q->in_len) {
> +        error_setg(errp, "multifd %u: received unexpectedly large packet",
> +                   p->id);
> +        return -1;
> +    }
> +
> +    if (flags != MULTIFD_FLAG_QATZIP) {
> +        error_setg(errp, "multifd %u: flags received %x flags expected %x",
> +                   p->id, flags, MULTIFD_FLAG_QATZIP);
> +        return -1;
> +    }
> +
> +    multifd_recv_zero_page_process(p);
> +    if (!p->normal_num) {
> +        assert(in_size == 0);
> +        return 0;
> +    }
> +
> +    ret = qio_channel_read_all(p->c, (void *)q->in_buf, in_size, errp);
> +    if (ret != 0) {
> +        return ret;
> +    }
> +
> +    in_len = in_size;
> +    out_len = q->out_len;
> +    ret = qzDecompress(&q->sess, q->in_buf, &in_len, q->out_buf, &out_len);
> +    if (ret != QZ_OK) {
> +        error_setg(errp, "multifd %u: qzDecompress failed", p->id);
> +        return -1;
> +    }
> +    if (out_len != expected_size) {
> +        error_setg(errp, "multifd %u: packet size received %u size expected %u",
> +                   p->id, out_len, expected_size);
> +        return -1;
> +    }
> +
> +    /* Copy each page to its appropriate location. */
> +    for (int i = 0; i < p->normal_num; i++) {
> +        memcpy(p->host + p->normal[i],
> +               q->out_buf + p->page_size * i,
> +               p->page_size);
> +    }
> +    return 0;
> +}
> +
> +static MultiFDMethods multifd_qatzip_ops = {
> +    .send_setup = qatzip_send_setup,
> +    .send_cleanup = qatzip_send_cleanup,
> +    .send_prepare = qatzip_send_prepare,
> +    .recv_setup = qatzip_recv_setup,
> +    .recv_cleanup = qatzip_recv_cleanup,
> +    .recv = qatzip_recv
> +};
> +
> +static void multifd_qatzip_register(void)
> +{
> +    multifd_register_ops(MULTIFD_COMPRESSION_QATZIP, &multifd_qatzip_ops);
> +}
> +
> +migration_init(multifd_qatzip_register);
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 0ecd6f47d7..adceb65050 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -34,14 +34,15 @@ MultiFDRecvData *multifd_get_recv_data(void);
>  /* Multifd Compression flags */
>  #define MULTIFD_FLAG_SYNC (1 << 0)
>  
> -/* We reserve 4 bits for compression methods */
> -#define MULTIFD_FLAG_COMPRESSION_MASK (0xf << 1)
> +/* We reserve 5 bits for compression methods */
> +#define MULTIFD_FLAG_COMPRESSION_MASK (0x1f << 1)
>  /* we need to be compatible. Before compression value was 0 */
>  #define MULTIFD_FLAG_NOCOMP (0 << 1)
>  #define MULTIFD_FLAG_ZLIB (1 << 1)
>  #define MULTIFD_FLAG_ZSTD (2 << 1)
>  #define MULTIFD_FLAG_QPL (4 << 1)
>  #define MULTIFD_FLAG_UADK (8 << 1)
> +#define MULTIFD_FLAG_QATZIP (16 << 1)
>  
>  /* This value needs to be a multiple of qemu_target_page_size() */
>  #define MULTIFD_PACKET_SIZE (512 * 1024)
> diff --git a/qapi/migration.json b/qapi/migration.json
> index cd08f2f710..42b5363449 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -558,6 +558,8 @@
>  #
>  # @zstd: use zstd compression method.
>  #
> +# @qatzip: use qatzip compression method. (Since 9.1)
> +#
>  # @qpl: use qpl compression method.  Query Processing Library(qpl) is
>  #       based on the deflate compression algorithm and use the Intel
>  #       In-Memory Analytics Accelerator(IAA) accelerated compression
> @@ -570,6 +572,7 @@
>  { 'enum': 'MultiFDCompression',
>    'data': [ 'none', 'zlib',
>              { 'name': 'zstd', 'if': 'CONFIG_ZSTD' },
> +            { 'name': 'qatzip', 'if': 'CONFIG_QATZIP'},
>              { 'name': 'qpl', 'if': 'CONFIG_QPL' },
>              { 'name': 'uadk', 'if': 'CONFIG_UADK' } ] }
>  
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 6508bfb1a2..3068d73e08 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -327,6 +327,10 @@ if gnutls.found()
>    endif
>  endif
>  
> +if qatzip.found()
> +  migration_files += [qatzip]
> +endif
> +
>  qtests = {
>    'bios-tables-test': [io, 'boot-sector.c', 'acpi-utils.c', 'tpm-emu.c'],
>    'cdrom-test': files('boot-sector.c'),

