Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389D0C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 15:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6XN9-0006SF-NU; Mon, 13 May 2024 11:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s6XN8-0006S4-If
 for qemu-devel@nongnu.org; Mon, 13 May 2024 11:13:50 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s6XN1-0003Bz-Oh
 for qemu-devel@nongnu.org; Mon, 13 May 2024 11:13:50 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 97BFE34D7C;
 Mon, 13 May 2024 15:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715613220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HtZ7OUum9yrbrNMOGBdQ6Hz+pCHH1uPPJ8J6RkLy75E=;
 b=uOaGBtbb3bTZvWKOGEzKXvEmaIbCHHq7Y41S6V4ZKVpDEjWZase0Jjzuv8H/hvjk1MGTMb
 JDj5wc5GsnZUwbulrJur7RG+LK9x763BU4UKS8+ZoS1jWd39NfsRJr1B/nnmHBQylm0IF4
 bqsxIyORoPXXzL9Kg6pGh8i3NbLwRUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715613220;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HtZ7OUum9yrbrNMOGBdQ6Hz+pCHH1uPPJ8J6RkLy75E=;
 b=+hL1+Gei985OaRnBAKOWiNbVFVp0pIrTKMrjHOOsbk92wM9OcYYENyHYa0yiqbZ7XukT65
 uInH3LxSHXQhc7CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715613220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HtZ7OUum9yrbrNMOGBdQ6Hz+pCHH1uPPJ8J6RkLy75E=;
 b=uOaGBtbb3bTZvWKOGEzKXvEmaIbCHHq7Y41S6V4ZKVpDEjWZase0Jjzuv8H/hvjk1MGTMb
 JDj5wc5GsnZUwbulrJur7RG+LK9x763BU4UKS8+ZoS1jWd39NfsRJr1B/nnmHBQylm0IF4
 bqsxIyORoPXXzL9Kg6pGh8i3NbLwRUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715613220;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HtZ7OUum9yrbrNMOGBdQ6Hz+pCHH1uPPJ8J6RkLy75E=;
 b=+hL1+Gei985OaRnBAKOWiNbVFVp0pIrTKMrjHOOsbk92wM9OcYYENyHYa0yiqbZ7XukT65
 uInH3LxSHXQhc7CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2206013A52;
 Mon, 13 May 2024 15:13:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UHo6NiMuQmazTQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 13 May 2024 15:13:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Yuan Liu <yuan1.liu@intel.com>, peterx@redhat.com
Cc: qemu-devel@nongnu.org, yuan1.liu@intel.com, nanhai.zou@intel.com
Subject: Re: [PATCH v6 6/7] migration/multifd: implement qpl compression and
 decompression
In-Reply-To: <20240505165751.2392198-7-yuan1.liu@intel.com>
References: <20240505165751.2392198-1-yuan1.liu@intel.com>
 <20240505165751.2392198-7-yuan1.liu@intel.com>
Date: Mon, 13 May 2024 12:13:37 -0300
Message-ID: <87ikzhg2xq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Yuan Liu <yuan1.liu@intel.com> writes:

> each qpl job is used to (de)compress a normal page and it can
> be processed independently by the IAA hardware. All qpl jobs
> are submitted to the hardware at once, and wait for all jobs
> completion. If hardware path(IAA) is not available, use software
> for compression and decompression.
>
> Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> ---
>  migration/multifd-qpl.c | 284 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 280 insertions(+), 4 deletions(-)
>
> diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
> index 89fa51091a..9a1fddbdd0 100644
> --- a/migration/multifd-qpl.c
> +++ b/migration/multifd-qpl.c
> @@ -13,6 +13,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/module.h"
>  #include "qapi/error.h"
> +#include "exec/ramblock.h"
>  #include "migration.h"
>  #include "multifd.h"
>  #include "qpl/qpl.h"
> @@ -204,6 +205,139 @@ static void multifd_qpl_send_cleanup(MultiFDSendParams *p, Error **errp)
>      p->iov = NULL;
>  }
>  
> +/**
> + * multifd_qpl_prepare_job: prepare a compression or decompression job
> + *
> + * Prepare a compression or decompression job and configure job attributes
> + * including job compression level and flags.
> + *
> + * @job: pointer to the QplData structure

qpl_job structure

> + * @is_compression: compression or decompression indication
> + * @input: pointer to the input data buffer
> + * @input_len: the length of the input data
> + * @output: pointer to the output data buffer
> + * @output_len: the size of the output data buffer
> + */
> +static void multifd_qpl_prepare_job(qpl_job *job, bool is_compression,
> +                                    uint8_t *input, uint32_t input_len,
> +                                    uint8_t *output, uint32_t output_len)
> +{
> +    job->op = is_compression ? qpl_op_compress : qpl_op_decompress;
> +    job->next_in_ptr = input;
> +    job->next_out_ptr = output;
> +    job->available_in = input_len;
> +    job->available_out = output_len;
> +    job->flags = QPL_FLAG_FIRST | QPL_FLAG_LAST | QPL_FLAG_OMIT_VERIFY;
> +    /* only supports one compression level */
> +    job->level = 1;
> +}
> +
> +/**
> + * multifd_qpl_build_packet: build a qpl compressed data packet
> + *
> + * The qpl compressed data packet consists of two parts, one part stores
> + * the compressed length of each page, and the other part is the compressed
> + * data of each page. The zbuf_hdr stores the compressed length of all pages,
> + * and use a separate IOV to store the compressed data of each page.
> + *
> + * @qpl: pointer to the QplData structure
> + * @p: Params for the channel that we are using
> + * @idx: The index of the compressed length array
> + * @addr: pointer to the compressed data
> + * @len: The length of the compressed data
> + */
> +static void multifd_qpl_build_packet(QplData *qpl, MultiFDSendParams *p,
> +                                     uint32_t idx, uint8_t *addr, uint32_t len)
> +{
> +    qpl->zbuf_hdr[idx] = cpu_to_be32(len);
> +    p->iov[p->iovs_num].iov_base = addr;
> +    p->iov[p->iovs_num].iov_len = len;
> +    p->iovs_num++;
> +    p->next_packet_size += len;
> +}
> +
> +/**
> + * multifd_qpl_compress_pages: compress normal pages
> + *
> + * Each normal page will be compressed independently, and the compression jobs
> + * will be submitted to the IAA hardware in non-blocking mode, waiting for all
> + * jobs to be completed and filling the compressed length and data into the
> + * sending IOVs. If IAA device is not available, the software path is used.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @errp: pointer to an error
> + */
> +static int multifd_qpl_compress_pages(MultiFDSendParams *p, Error **errp)
> +{
> +    qpl_status status;
> +    QplData *qpl = p->compress_data;
> +    MultiFDPages_t *pages = p->pages;
> +    uint8_t *zbuf = qpl->zbuf;
> +    uint8_t *host = pages->block->host;
> +    uint32_t job_num = pages->normal_num;

A bit misleading because job_num is used in the previous patch as a
synonym for page_count. We could change the previous patch to:
multifd_qpl_init(uint32_t page_count, ...

> +    qpl_job *job = NULL;
> +
> +    assert(job_num <= qpl->total_job_num);
> +    /* submit all compression jobs */
> +    for (int i = 0; i < job_num; i++) {
> +        job = qpl->job_array[i];
> +        multifd_qpl_prepare_job(job, true, host + pages->offset[i],
> +                                p->page_size, zbuf, p->page_size - 1);

Isn't the output buffer size == page size, why the -1?

> +        /* if hardware path(IAA) is unavailable, call the software path */

If we're doing the fallback automatically, isn't that what qpl_path_auto
does already? What's the difference betweeen the two approaches?

> +        if (!qpl->iaa_avail) {

This function got a bit convoluted, it's probably worth a check at the
start and a branch to different multifd_qpl_compress_pages_slow()
routine altogether.

> +            status = qpl_execute_job(job);
> +            if (status == QPL_STS_OK) {
> +                multifd_qpl_build_packet(qpl, p, i, zbuf, job->total_out);
> +            } else if (status == QPL_STS_MORE_OUTPUT_NEEDED) {
> +                /* compressed length exceeds page size, send page directly */
> +                multifd_qpl_build_packet(qpl, p, i, host + pages->offset[i],
> +                                         p->page_size);
> +            } else {
> +                error_setg(errp, "multifd %u: qpl_execute_job error %d",
> +                           p->id, status);
> +                return -1;
> +            }
> +            zbuf += p->page_size;
> +            continue;
> +        }
> +retry:
> +        status = qpl_submit_job(job);
> +        if (status == QPL_STS_OK) {
> +            zbuf += p->page_size;
> +        } else if (status == QPL_STS_QUEUES_ARE_BUSY_ERR) {
> +            goto retry;

A retry count here would be nice.

> +        } else {
> +            error_setg(errp, "multifd %u: qpl_submit_job failed with error %d",
> +                       p->id, status);
> +            return -1;
> +        }
> +    }
> +    if (!qpl->iaa_avail) {
> +        goto done;
> +    }
> +    /* wait all jobs to complete for hardware(IAA) path */
> +    for (int i = 0; i < job_num; i++) {
> +        job = qpl->job_array[i];
> +        status = qpl_wait_job(job);
> +        if (status == QPL_STS_OK) {
> +            multifd_qpl_build_packet(qpl, p, i, qpl->zbuf + (p->page_size * i),
> +                                     job->total_out);
> +        } else if (status == QPL_STS_MORE_OUTPUT_NEEDED) {
> +            /* compressed data length exceeds page size, send page directly */
> +            multifd_qpl_build_packet(qpl, p, i, host + pages->offset[i],
> +                                     p->page_size);
> +        } else {
> +            error_setg(errp, "multifd %u: qpl_wait_job failed with error %d",
> +                       p->id, status);
> +            return -1;
> +        }
> +    }
> +done:
> +    return 0;
> +}
> +
>  /**
>   * multifd_qpl_send_prepare: prepare data to be able to send
>   *
> @@ -217,8 +351,28 @@ static void multifd_qpl_send_cleanup(MultiFDSendParams *p, Error **errp)
>   */
>  static int multifd_qpl_send_prepare(MultiFDSendParams *p, Error **errp)
>  {
> -    /* Implement in next patch */
> -    return -1;
> +    QplData *qpl = p->compress_data;
> +    uint32_t hdr_size;
> +
> +    if (!multifd_send_prepare_common(p)) {
> +        goto out;
> +    }
> +
> +    assert(p->pages->normal_num <= qpl->total_job_num);
> +    hdr_size = p->pages->normal_num * sizeof(uint32_t);
> +    /* prepare the header that stores the lengths of all compressed data */
> +    p->iov[1].iov_base = (uint8_t *) qpl->zbuf_hdr;
> +    p->iov[1].iov_len = hdr_size;

Better use p->iovs_num here in case we ever decide to add more stuff to
the front of the array.

> +    p->iovs_num++;
> +    p->next_packet_size += hdr_size;

Here's the first time we're setting this value, right? So just a regular
attribution(=).

> +    if (multifd_qpl_compress_pages(p, errp) != 0) {
> +        return -1;
> +    }
> +
> +out:
> +    p->flags |= MULTIFD_FLAG_QPL;
> +    multifd_send_fill_packet(p);
> +    return 0;
>  }
>  
>  /**
> @@ -256,6 +410,88 @@ static void multifd_qpl_recv_cleanup(MultiFDRecvParams *p)
>      p->compress_data = NULL;
>  }
>  
> +/**
> + * multifd_qpl_decompress_pages: decompress normal pages
> + *
> + * Each compressed page will be decompressed independently, and the
> + * decompression jobs will be submitted to the IAA hardware in non-blocking
> + * mode, waiting for all jobs to be completed and loading the decompressed
> + * data into guest memory. If IAA device is not available, the software path
> + * is used.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @errp: pointer to an error
> + */
> +static int multifd_qpl_decompress_pages(MultiFDRecvParams *p, Error **errp)
> +{
> +    qpl_status status;
> +    qpl_job *job;
> +    QplData *qpl = p->compress_data;
> +    uint32_t job_num = p->normal_num;
> +    uint32_t off = 0;
> +
> +    assert(job_num <= qpl->total_job_num);
> +    /* submit all decompression jobs */
> +    for (int i = 0; i < job_num; i++) {
> +        /* if the data size is the same as the page size, load it directly */
> +        if (qpl->zbuf_hdr[i] == p->page_size) {
> +            memcpy(p->host + p->normal[i], qpl->zbuf + off, p->page_size);
> +            off += p->page_size;
> +            continue;
> +        }
> +        job = qpl->job_array[i];
> +        multifd_qpl_prepare_job(job, false, qpl->zbuf + off, qpl->zbuf_hdr[i],
> +                                p->host + p->normal[i], p->page_size);
> +        /* if hardware path(IAA) is unavailable, call the software path */
> +        if (!qpl->iaa_avail) {
> +            status = qpl_execute_job(job);
> +            if (status == QPL_STS_OK) {
> +                off += qpl->zbuf_hdr[i];
> +                continue;
> +            }
> +            error_setg(errp, "multifd %u: qpl_execute_job failed with error %d",
> +                       p->id, status);
> +            return -1;
> +        }
> +retry:
> +        status = qpl_submit_job(job);
> +        if (status == QPL_STS_OK) {
> +            off += qpl->zbuf_hdr[i];
> +        } else if (status == QPL_STS_QUEUES_ARE_BUSY_ERR) {
> +            goto retry;
> +        } else {
> +            error_setg(errp, "multifd %u: qpl_submit_job failed with error %d",
> +                       p->id, status);
> +            return -1;
> +        }
> +    }
> +    if (!qpl->iaa_avail) {
> +        goto done;
> +    }
> +    /* wait all jobs to complete for hardware(IAA) path */
> +    for (int i = 0; i < job_num; i++) {
> +        if (qpl->zbuf_hdr[i] == p->page_size) {
> +            continue;
> +        }
> +        job = qpl->job_array[i];
> +        status = qpl_wait_job(job);
> +        if (status != QPL_STS_OK) {
> +            error_setg(errp, "multifd %u: qpl_wait_job failed with error %d",
> +                       p->id, status);
> +            return -1;
> +        }
> +        if (job->total_out != p->page_size) {
> +            error_setg(errp, "multifd %u: decompressed len %u, expected len %u",
> +                       p->id, job->total_out, p->page_size);
> +            return -1;
> +        }
> +    }
> +done:
> +    return 0;
> +}
> +
>  /**
>   * multifd_qpl_recv: read the data from the channel into actual pages
>   *
> @@ -269,8 +505,48 @@ static void multifd_qpl_recv_cleanup(MultiFDRecvParams *p)
>   */
>  static int multifd_qpl_recv(MultiFDRecvParams *p, Error **errp)
>  {
> -    /* Implement in next patch */
> -    return -1;
> +    QplData *qpl = p->compress_data;
> +    uint32_t in_size = p->next_packet_size;
> +    uint32_t flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
> +    uint32_t hdr_len = p->normal_num * sizeof(uint32_t);
> +    uint32_t data_len = 0;
> +    int ret;
> +
> +    if (flags != MULTIFD_FLAG_QPL) {
> +        error_setg(errp, "multifd %u: flags received %x flags expected %x",
> +                   p->id, flags, MULTIFD_FLAG_QPL);
> +        return -1;
> +    }
> +    multifd_recv_zero_page_process(p);
> +    if (!p->normal_num) {
> +        assert(in_size == 0);
> +        return 0;
> +    }
> +
> +    /* read compressed data lengths */
> +    assert(hdr_len < in_size);
> +    ret = qio_channel_read_all(p->c, (void *) qpl->zbuf_hdr, hdr_len, errp);
> +    if (ret != 0) {
> +        return ret;
> +    }
> +    assert(p->normal_num <= qpl->total_job_num);

I'm still in doubt whether we should use p->page_count directly all
over. It's nice to move the concept into the QPL domain space, but it
makes less sense in these functions that take MultiFD*Params as
argument.

> +    for (int i = 0; i < p->normal_num; i++) {
> +        qpl->zbuf_hdr[i] = be32_to_cpu(qpl->zbuf_hdr[i]);
> +        data_len += qpl->zbuf_hdr[i];
> +        assert(qpl->zbuf_hdr[i] <= p->page_size);
> +    }
> +
> +    /* read compressed data */
> +    assert(in_size == hdr_len + data_len);
> +    ret = qio_channel_read_all(p->c, (void *) qpl->zbuf, data_len, errp);
> +    if (ret != 0) {
> +        return ret;
> +    }
> +
> +    if (multifd_qpl_decompress_pages(p, errp) != 0) {
> +        return -1;
> +    }
> +    return 0;
>  }
>  
>  static MultiFDMethods multifd_qpl_ops = {

