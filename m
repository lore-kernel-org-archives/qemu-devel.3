Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 657F1C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 22:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEz54-0005kh-PB; Wed, 05 Jun 2024 18:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sEz53-0005jG-9k
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 18:26:05 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sEz4z-0000fJ-Vz
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 18:26:05 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5322021A91;
 Wed,  5 Jun 2024 22:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717626358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XgTHDZpiKzrir3oRoDdIdiT7kNJL0BaAoDA7++kX9rg=;
 b=eToe7dh+XziHvi7I9XEl0Jr1T1CflrC8OuH7OnWzUOB7l4MdqFAJT443bycxv4SIO7fqjJ
 eIDA6L0UqI1R1G6JdnoeW4Vo6HCGzmEdVaBbgepGHKtVaDzl/EOEaLNVnjHVhD8zuTef0H
 1KdcFKbP2QM0ezlgWZ6mry25g4MRlpw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717626358;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XgTHDZpiKzrir3oRoDdIdiT7kNJL0BaAoDA7++kX9rg=;
 b=7121/JKbJ36bbnAw+KWbyphQ3hg1+iHpnf4aTzxXpt5/6OR94K5c6uUpN1uCJSW8xRpCzb
 ASuBdmNI5TR9HuDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717626358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XgTHDZpiKzrir3oRoDdIdiT7kNJL0BaAoDA7++kX9rg=;
 b=eToe7dh+XziHvi7I9XEl0Jr1T1CflrC8OuH7OnWzUOB7l4MdqFAJT443bycxv4SIO7fqjJ
 eIDA6L0UqI1R1G6JdnoeW4Vo6HCGzmEdVaBbgepGHKtVaDzl/EOEaLNVnjHVhD8zuTef0H
 1KdcFKbP2QM0ezlgWZ6mry25g4MRlpw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717626358;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XgTHDZpiKzrir3oRoDdIdiT7kNJL0BaAoDA7++kX9rg=;
 b=7121/JKbJ36bbnAw+KWbyphQ3hg1+iHpnf4aTzxXpt5/6OR94K5c6uUpN1uCJSW8xRpCzb
 ASuBdmNI5TR9HuDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C58DB13A24;
 Wed,  5 Jun 2024 22:25:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +aFtIvXlYGa3PwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 05 Jun 2024 22:25:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Yuan Liu <yuan1.liu@intel.com>, peterx@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org
Cc: qemu-devel@nongnu.org, yuan1.liu@intel.com, nanhai.zou@intel.com,
 shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH v7 6/7] migration/multifd: implement qpl compression and
 decompression
In-Reply-To: <20240603154106.764378-7-yuan1.liu@intel.com>
References: <20240603154106.764378-1-yuan1.liu@intel.com>
 <20240603154106.764378-7-yuan1.liu@intel.com>
Date: Wed, 05 Jun 2024 19:25:55 -0300
Message-ID: <87plsvni18.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[11]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Yuan Liu <yuan1.liu@intel.com> writes:

> QPL compression and decompression will use IAA hardware first.
> If IAA hardware is not available, it will automatically fall
> back to QPL software path, if the software job also fails,
> the uncompressed page is sent directly.
>
> Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> ---
>  migration/multifd-qpl.c | 412 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 408 insertions(+), 4 deletions(-)
>
> diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
> index 6791a204d5..18b3384bd5 100644
> --- a/migration/multifd-qpl.c
> +++ b/migration/multifd-qpl.c
> @@ -13,9 +13,14 @@
>  #include "qemu/osdep.h"
>  #include "qemu/module.h"
>  #include "qapi/error.h"
> +#include "qapi/qapi-types-migration.h"
> +#include "exec/ramblock.h"
>  #include "multifd.h"
>  #include "qpl/qpl.h"
>  
> +/* Maximum number of retries to resubmit a job if IAA work queues are full */
> +#define MAX_SUBMIT_RETRY_NUM (3)
> +
>  typedef struct {
>      /* the QPL hardware path job */
>      qpl_job *job;
> @@ -260,6 +265,219 @@ static void multifd_qpl_send_cleanup(MultiFDSendParams *p, Error **errp)
>      p->iov = NULL;
>  }
>  
> +/**
> + * multifd_qpl_prepare_job: prepare the job
> + *
> + * Set the QPL job parameters and properties.
> + *
> + * @job: pointer to the qpl_job structure
> + * @is_compression: indicates compression and decompression
> + * @input: pointer to the input data buffer
> + * @input_len: the length of the input data
> + * @output: pointer to the output data buffer
> + * @output_len: the length of the output data
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
> +    /* only supports compression level 1 */
> +    job->level = 1;
> +}
> +
> +/**
> + * multifd_qpl_prepare_job: prepare the compression job

function name is wrong

> + *
> + * Set the compression job parameters and properties.
> + *
> + * @job: pointer to the qpl_job structure
> + * @input: pointer to the input data buffer
> + * @input_len: the length of the input data
> + * @output: pointer to the output data buffer
> + * @output_len: the length of the output data
> + */
> +static void multifd_qpl_prepare_comp_job(qpl_job *job, uint8_t *input,
> +                                         uint32_t input_len, uint8_t *output,
> +                                         uint32_t output_len)
> +{
> +    multifd_qpl_prepare_job(job, true, input, input_len, output, output_len);
> +}
> +
> +/**
> + * multifd_qpl_prepare_job: prepare the decompression job

here as well

> + *
> + * Set the decompression job parameters and properties.
> + *
> + * @job: pointer to the qpl_job structure
> + * @input: pointer to the input data buffer
> + * @input_len: the length of the input data
> + * @output: pointer to the output data buffer
> + * @output_len: the length of the output data
> + */
> +static void multifd_qpl_prepare_decomp_job(qpl_job *job, uint8_t *input,
> +                                           uint32_t input_len, uint8_t *output,
> +                                           uint32_t output_len)
> +{
> +    multifd_qpl_prepare_job(job, false, input, input_len, output, output_len);
> +}
> +
> +/**
> + * multifd_qpl_fill_iov: fill in the IOV
> + *
> + * Fill in the QPL packet IOV
> + *
> + * @p: Params for the channel being used
> + * @data: pointer to the IOV data
> + * @len: The length of the IOV data
> + */
> +static void multifd_qpl_fill_iov(MultiFDSendParams *p, uint8_t *data,
> +                                 uint32_t len)
> +{
> +    p->iov[p->iovs_num].iov_base = data;
> +    p->iov[p->iovs_num].iov_len = len;
> +    p->iovs_num++;
> +    p->next_packet_size += len;
> +}
> +
> +/**
> + * multifd_qpl_fill_packet: fill the compressed page into the QPL packet
> + *
> + * Fill the compressed page length and IOV into the QPL packet
> + *
> + * @idx: The index of the compressed length array
> + * @p: Params for the channel being used
> + * @data: pointer to the compressed page buffer
> + * @len: The length of the compressed page
> + */
> +static void multifd_qpl_fill_packet(uint32_t idx, MultiFDSendParams *p,
> +                                    uint8_t *data, uint32_t len)
> +{
> +    QplData *qpl = p->compress_data;
> +
> +    qpl->zlen[idx] = cpu_to_be32(len);
> +    multifd_qpl_fill_iov(p, data, len);
> +}
> +
> +/**
> + * multifd_qpl_submit_job: submit a job to the hardware
> + *
> + * Submit a QPL hardware job to the IAA device
> + *
> + * Returns true if the job is submitted successfully, otherwise false.
> + *
> + * @job: pointer to the qpl_job structure
> + */
> +static bool multifd_qpl_submit_job(qpl_job *job)
> +{
> +    qpl_status status;
> +    uint32_t num = 0;
> +
> +retry:
> +    status = qpl_submit_job(job);
> +    if (status == QPL_STS_QUEUES_ARE_BUSY_ERR) {
> +        if (num < MAX_SUBMIT_RETRY_NUM) {
> +            num++;
> +            goto retry;
> +        }
> +    }
> +    return (status == QPL_STS_OK);

How often do we expect this to fail? Will the queues be busy frequently
or is this an unlikely event? I'm thinking whether we really need to
allow a fallback for the hw path. Sorry if this has been discussed
already, I don't remember.

> +}
> +
> +/**
> + * multifd_qpl_compress_pages_slow_path: compress pages using slow path
> + *
> + * Compress the pages using software. If compression fails, the page will
> + * be sent directly.
> + *
> + * @p: Params for the channel being used
> + */
> +static void multifd_qpl_compress_pages_slow_path(MultiFDSendParams *p)
> +{
> +    QplData *qpl = p->compress_data;
> +    uint32_t size = p->page_size;
> +    qpl_job *job = qpl->sw_job;
> +    uint8_t *zbuf = qpl->zbuf;
> +    uint8_t *buf;
> +
> +    for (int i = 0; i < p->pages->normal_num; i++) {
> +        buf = p->pages->block->host + p->pages->offset[i];
> +        /* Set output length to less than the page to reduce decompression */
> +        multifd_qpl_prepare_comp_job(job, buf, size, zbuf, size - 1);
> +        if (qpl_execute_job(job) == QPL_STS_OK) {
> +            multifd_qpl_fill_packet(i, p, zbuf, job->total_out);
> +        } else {
> +            /* send the page directly */

s/directly/uncompressed/

a bit clearer.

> +            multifd_qpl_fill_packet(i, p, buf, size);
> +        }
> +        zbuf += size;
> +    }
> +}
> +
> +/**
> + * multifd_qpl_compress_pages: compress pages
> + *
> + * Submit the pages to the IAA hardware for compression. If hardware
> + * compression fails, it falls back to software compression. If software
> + * compression also fails, the page is sent directly
> + *
> + * @p: Params for the channel being used
> + */
> +static void multifd_qpl_compress_pages(MultiFDSendParams *p)
> +{
> +    QplData *qpl = p->compress_data;
> +    MultiFDPages_t *pages = p->pages;
> +    uint32_t size = p->page_size;
> +    QplHwJob *hw_job;
> +    uint8_t *buf;
> +    uint8_t *zbuf;
> +

Let's document the output size choice more explicitly:

    /*
     * Set output length to less than the page size to force the job to
     * fail in case it compresses to a larger size. We'll send that page
     * without compression and skip the decompression operation on the
     * destination.
     */
     out_size = size - 1;

you can then omit the other comments.

> +    for (int i = 0; i < pages->normal_num; i++) {
> +        buf = pages->block->host + pages->offset[i];
> +        zbuf = qpl->zbuf + (size * i);
> +        hw_job = &qpl->hw_jobs[i];
> +        /* Set output length to less than the page to reduce decompression */
> +        multifd_qpl_prepare_comp_job(hw_job->job, buf, size, zbuf, size - 1);
> +        if (multifd_qpl_submit_job(hw_job->job)) {
> +            hw_job->fallback_sw_path = false;
> +        } else {
> +            hw_job->fallback_sw_path = true;
> +            /* Set output length less than page size to reduce decompression */
> +            multifd_qpl_prepare_comp_job(qpl->sw_job, buf, size, zbuf,
> +                                         size - 1);
> +            if (qpl_execute_job(qpl->sw_job) == QPL_STS_OK) {
> +                hw_job->sw_output = zbuf;
> +                hw_job->sw_output_len = qpl->sw_job->total_out;
> +            } else {
> +                hw_job->sw_output = buf;
> +                hw_job->sw_output_len = size;
> +            }

Hmm, these look a bit cumbersome, would it work if we moved the fallback
qpl_execute_job() down into the other loop? We could then avoid the
extra fields. Something like:

static void multifd_qpl_compress_pages(MultiFDSendParams *p)
{
    QplData *qpl = p->compress_data;
    MultiFDPages_t *pages = p->pages;
    uint32_t out_size, size = p->page_size;
    uint8_t *buf, *zbuf;

    /*
     * Set output length to less than the page size to force the job to
     * fail in case it compresses to a larger size. We'll send that page
     * without compression to skip the decompression operation on the
     * destination.
     */
    out_size = size - 1;

    for (int i = 0; i < pages->normal_num; i++) {
        QplHwJob *hw_job = &qpl->hw_jobs[i];

        hw_job->fallback_sw_path = false;
        buf = pages->block->host + pages->offset[i];
        zbuf = qpl->zbuf + (size * i);

        multifd_qpl_prepare_comp_job(hw_job->job, buf, size, zbuf, out_size);

        if (!multifd_qpl_submit_job(hw_job->job)) {
            hw_job->fallback_sw_path = true;
        }
    }

    for (int i = 0; i < pages->normal_num; i++) {
        QplHwJob *hw_job = &qpl->hw_jobs[i];
        qpl_job *job;

        buf = pages->block->host + pages->offset[i];
        zbuf = qpl->zbuf + (size * i);

        if (hw_job->fallback_sw_path) {
            job = qpl->sw_job;
            multifd_qpl_prepare_comp_job(job, buf, size, zbuf, out_size);
            ret = qpl_execute_job(job);
        } else {            
            job = hw_job->job; 
            ret = qpl_wait_job(job);
        }

        if (ret == QPL_STS_OK) {
            multifd_qpl_fill_packet(i, p, zbuf, job->total_out);
        } else {
            multifd_qpl_fill_packet(i, p, buf, size);
        }
    }
}

> +        }
> +    }
> +
> +    for (int i = 0; i < pages->normal_num; i++) {
> +        buf = pages->block->host + pages->offset[i];
> +        zbuf = qpl->zbuf + (size * i);
> +        hw_job = &qpl->hw_jobs[i];
> +        if (hw_job->fallback_sw_path) {
> +            multifd_qpl_fill_packet(i, p, hw_job->sw_output,
> +                                    hw_job->sw_output_len);
> +            continue;
> +        }
> +        if (qpl_wait_job(hw_job->job) == QPL_STS_OK) {
> +            multifd_qpl_fill_packet(i, p, zbuf, hw_job->job->total_out);
> +        } else {
> +            /* send the page directly */
> +            multifd_qpl_fill_packet(i, p, buf, size);
> +        }
> +    }
> +}
> +
>  /**
>   * multifd_qpl_send_prepare: prepare data to be able to send
>   *
> @@ -273,8 +491,26 @@ static void multifd_qpl_send_cleanup(MultiFDSendParams *p, Error **errp)
>   */
>  static int multifd_qpl_send_prepare(MultiFDSendParams *p, Error **errp)
>  {
> -    /* Implement in next patch */
> -    return -1;
> +    QplData *qpl = p->compress_data;
> +    uint32_t len = 0;
> +
> +    if (!multifd_send_prepare_common(p)) {
> +        goto out;
> +    }
> +
> +    /* The first IOV is used to store the compressed page lengths */
> +    len = p->pages->normal_num * sizeof(uint32_t);
> +    multifd_qpl_fill_iov(p, (uint8_t *) qpl->zlen, len);
> +    if (qpl->hw_avail) {
> +        multifd_qpl_compress_pages(p);
> +    } else {
> +        multifd_qpl_compress_pages_slow_path(p);
> +    }
> +
> +out:
> +    p->flags |= MULTIFD_FLAG_QPL;
> +    multifd_send_fill_packet(p);
> +    return 0;
>  }
>  
>  /**
> @@ -312,6 +548,134 @@ static void multifd_qpl_recv_cleanup(MultiFDRecvParams *p)
>      p->compress_data = NULL;
>  }
>  
> +/**
> + * multifd_qpl_process_and_check_job: process and check a QPL job
> + *
> + * Process the job and check whether the job output length is the
> + * same as the specified length
> + *
> + * Returns true if the job execution succeeded and the output length
> + * is equal to the specified length, otherwise false.
> + *
> + * @job: pointer to the qpl_job structure
> + * @is_hardware: indicates whether the job is a hardware job
> + * @len: Specified output length
> + * @errp: pointer to an error
> + */
> +static bool multifd_qpl_process_and_check_job(qpl_job *job, bool is_hardware,
> +                                              uint32_t len, Error **errp)
> +{
> +    qpl_status status;
> +
> +    status = (is_hardware ? qpl_wait_job(job) : qpl_execute_job(job));
> +    if (status != QPL_STS_OK) {
> +        error_setg(errp, "qpl_execute_job failed with error %d", status);

The error message should also cover qpl_wait_job(), right? Maybe just
use "qpl job failed".

> +        return false;
> +    }
> +    if (job->total_out != len) {
> +        error_setg(errp, "qpl decompressed len %u, expected len %u",
> +                   job->total_out, len);
> +        return false;
> +    }
> +    return true;
> +}
> +
> +/**
> + * multifd_qpl_decompress_pages_slow_path: decompress pages using slow path
> + *
> + * Decompress the pages using software
> + *
> + * Returns 0 on success or -1 on error
> + *
> + * @p: Params for the channel being used
> + * @errp: pointer to an error
> + */
> +static int multifd_qpl_decompress_pages_slow_path(MultiFDRecvParams *p,
> +                                                  Error **errp)
> +{
> +    QplData *qpl = p->compress_data;
> +    uint32_t size = p->page_size;
> +    qpl_job *job = qpl->sw_job;
> +    uint8_t *zbuf = qpl->zbuf;
> +    uint8_t *addr;
> +    uint32_t len;
> +
> +    for (int i = 0; i < p->normal_num; i++) {
> +        len = qpl->zlen[i];
> +        addr = p->host + p->normal[i];
> +        /* the page is uncompressed, load it */
> +        if (len == size) {
> +            memcpy(addr, zbuf, size);
> +            zbuf += size;
> +            continue;
> +        }
> +        multifd_qpl_prepare_decomp_job(job, zbuf, len, addr, size);
> +        if (!multifd_qpl_process_and_check_job(job, false, size, errp)) {
> +            return -1;
> +        }
> +        zbuf += len;
> +    }
> +    return 0;
> +}
> +
> +/**
> + * multifd_qpl_decompress_pages: decompress pages
> + *
> + * Decompress the pages using the IAA hardware. If hardware
> + * decompression fails, it falls back to software decompression.
> + *
> + * Returns 0 on success or -1 on error
> + *
> + * @p: Params for the channel being used
> + * @errp: pointer to an error
> + */
> +static int multifd_qpl_decompress_pages(MultiFDRecvParams *p, Error **errp)
> +{
> +    QplData *qpl = p->compress_data;
> +    uint32_t size = p->page_size;
> +    uint8_t *zbuf = qpl->zbuf;
> +    uint8_t *addr;
> +    uint32_t len;
> +    qpl_job *job;
> +
> +    for (int i = 0; i < p->normal_num; i++) {
> +        addr = p->host + p->normal[i];
> +        len = qpl->zlen[i];
> +        /* the page is uncompressed if received length equals the page size */
> +        if (len == size) {
> +            memcpy(addr, zbuf, size);
> +            zbuf += size;
> +            continue;
> +        }
> +
> +        job = qpl->hw_jobs[i].job;
> +        multifd_qpl_prepare_decomp_job(job, zbuf, len, addr, size);
> +        if (multifd_qpl_submit_job(job)) {
> +            qpl->hw_jobs[i].fallback_sw_path = false;
> +        } else {
> +            qpl->hw_jobs[i].fallback_sw_path = true;
> +            job = qpl->sw_job;
> +            multifd_qpl_prepare_decomp_job(job, zbuf, len, addr, size);
> +            if (!multifd_qpl_process_and_check_job(job, false, size, errp)) {
> +                return -1;
> +            }

Here the same suggestion applies. You created
multifd_qpl_process_and_check_job() but is now calling it twice, which
seems to lose the purpose. If the fallback moves to the loop below, then
you do it all in one place:

    for (int i = 0; i < p->normal_num; i++) {
        bool is_sw = !qpl->hw_jobs[i].fallback_sw_path;

        if (is_sw) {
            job = qpl->sw_job;
            multifd_qpl_prepare_decomp_job(job, zbuf, len, addr, size);
        } else {
            job = qpl->hw_jobs[i].job;
        }

        if (!multifd_qpl_process_and_check_job(job, !is_sw, size, errp)) {
            return -1;
        }
    }

> +        }
> +        zbuf += len;
> +    }
> +
> +    for (int i = 0; i < p->normal_num; i++) {
> +        /* ignore pages that have already been processed */
> +        if (qpl->zlen[i] == size || qpl->hw_jobs[i].fallback_sw_path) {
> +            continue;
> +        }
> +
> +        job = qpl->hw_jobs[i].job;
> +        if (!multifd_qpl_process_and_check_job(job, true, size, errp)) {
> +            return -1;
> +        }
> +    }
> +    return 0;
> +}
>  /**
>   * multifd_qpl_recv: read the data from the channel into actual pages
>   *
> @@ -325,8 +689,48 @@ static void multifd_qpl_recv_cleanup(MultiFDRecvParams *p)
>   */
>  static int multifd_qpl_recv(MultiFDRecvParams *p, Error **errp)
>  {
> -    /* Implement in next patch */
> -    return -1;
> +    QplData *qpl = p->compress_data;
> +    uint32_t in_size = p->next_packet_size;
> +    uint32_t flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
> +    uint32_t len = 0;
> +    uint32_t zbuf_len = 0;
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
> +    /* read compressed page lengths */
> +    len = p->normal_num * sizeof(uint32_t);
> +    assert(len < in_size);
> +    ret = qio_channel_read_all(p->c, (void *) qpl->zlen, len, errp);
> +    if (ret != 0) {
> +        return ret;
> +    }
> +    for (int i = 0; i < p->normal_num; i++) {
> +        qpl->zlen[i] = be32_to_cpu(qpl->zlen[i]);
> +        assert(qpl->zlen[i] <= p->page_size);
> +        zbuf_len += qpl->zlen[i];
> +    }
> +
> +    /* read compressed pages */
> +    assert(in_size == len + zbuf_len);
> +    ret = qio_channel_read_all(p->c, (void *) qpl->zbuf, zbuf_len, errp);
> +    if (ret != 0) {
> +        return ret;
> +    }
> +
> +    if (qpl->hw_avail) {
> +        return multifd_qpl_decompress_pages(p, errp);
> +    }
> +    return multifd_qpl_decompress_pages_slow_path(p, errp);
>  }
>  
>  static MultiFDMethods multifd_qpl_ops = {

