Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40318C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 20:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5XEm-0003H4-FW; Fri, 10 May 2024 16:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s5XEl-0003Gk-2s
 for qemu-devel@nongnu.org; Fri, 10 May 2024 16:53:03 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s5XEi-0003HV-ST
 for qemu-devel@nongnu.org; Fri, 10 May 2024 16:53:02 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A74DF1FD0E;
 Fri, 10 May 2024 20:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715374378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=avoDxbbBc5toDLcPxlFPJ7ZCQTF4EEZ1zr8gqU9BxvA=;
 b=vi1UZ9+mobyxVU45ddPuIqTfvlHH1PtUdbKeyFDBuKoVtoSaSshGvFJ5OANoKuZd5KrN0J
 vKfszUaI7uF2fgLjvtTVbtyupnryFt7CIPe1HhJ1DxyGTcpHiXRa60O3P5+lu2jSRNok9T
 us4HG11a4439ntnHD8S/6e2zTANQvDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715374378;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=avoDxbbBc5toDLcPxlFPJ7ZCQTF4EEZ1zr8gqU9BxvA=;
 b=45TyqAu+QKQ/6OD9PPQw36lvSieMsVJXwNDyqn5bNkxkB/ZL9M4xF//EGz0Lbhvnt0QsJg
 v0Mw5zV545deLMBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715374378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=avoDxbbBc5toDLcPxlFPJ7ZCQTF4EEZ1zr8gqU9BxvA=;
 b=vi1UZ9+mobyxVU45ddPuIqTfvlHH1PtUdbKeyFDBuKoVtoSaSshGvFJ5OANoKuZd5KrN0J
 vKfszUaI7uF2fgLjvtTVbtyupnryFt7CIPe1HhJ1DxyGTcpHiXRa60O3P5+lu2jSRNok9T
 us4HG11a4439ntnHD8S/6e2zTANQvDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715374378;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=avoDxbbBc5toDLcPxlFPJ7ZCQTF4EEZ1zr8gqU9BxvA=;
 b=45TyqAu+QKQ/6OD9PPQw36lvSieMsVJXwNDyqn5bNkxkB/ZL9M4xF//EGz0Lbhvnt0QsJg
 v0Mw5zV545deLMBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30A2C1386E;
 Fri, 10 May 2024 20:52:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id m5FbOimJPmZ1CQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 10 May 2024 20:52:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Yuan Liu <yuan1.liu@intel.com>, peterx@redhat.com
Cc: qemu-devel@nongnu.org, yuan1.liu@intel.com, nanhai.zou@intel.com
Subject: Re: [PATCH v6 5/7] migration/multifd: implement initialization of
 qpl compression
In-Reply-To: <20240505165751.2392198-6-yuan1.liu@intel.com>
References: <20240505165751.2392198-1-yuan1.liu@intel.com>
 <20240505165751.2392198-6-yuan1.liu@intel.com>
Date: Fri, 10 May 2024 17:52:55 -0300
Message-ID: <87le4hfkyg.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, intel.com:email]
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

Yuan Liu <yuan1.liu@intel.com> writes:

> the qpl initialization includes memory allocation for compressed
> data and the qpl job initialization.
>
> the qpl job initialization will check if the In-Memory Analytics
> Accelerator(IAA) device is available and use the IAA device first.
> If the platform does not have IAA device or the IAA device is not
> available, the qpl compression will fallback to the software path.
>
> Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> ---
>  migration/multifd-qpl.c | 272 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 271 insertions(+), 1 deletion(-)
>
> diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
> index 056a68a060..89fa51091a 100644
> --- a/migration/multifd-qpl.c
> +++ b/migration/multifd-qpl.c
> @@ -9,12 +9,282 @@
>   * This work is licensed under the terms of the GNU GPL, version 2 or later.
>   * See the COPYING file in the top-level directory.
>   */
> +
>  #include "qemu/osdep.h"
>  #include "qemu/module.h"
> +#include "qapi/error.h"
> +#include "migration.h"

Where is this used? I think you only need qapi/qapi-types-migration.h

> +#include "multifd.h"
> +#include "qpl/qpl.h"
> +
> +typedef struct {
> +    qpl_job **job_array;
> +    /* the number of allocated jobs */
> +    uint32_t total_job_num;
> +    /* compressed data buffer */
> +    uint8_t *zbuf;
> +    /* the length of compressed data */
> +    uint32_t *zbuf_hdr;
> +    /* the status of IAA device */
> +    bool iaa_avail;
> +} QplData;
> +
> +/**
> + * check_iaa_avail: check if IAA device is available
> + *
> + * If the system does not have an IAA device, the IAA device is
> + * not enabled or the IAA work queue is not configured as a shared
> + * mode, the QPL hardware path initialization will fail.
> + *
> + * Returns true if IAA device is available, otherwise false.
> + */
> +static bool check_iaa_avail(void)
> +{
> +    qpl_job *job = NULL;
> +    uint32_t job_size = 0;
> +    qpl_path_t path = qpl_path_hardware;
> +
> +    if (qpl_get_job_size(path, &job_size) != QPL_STS_OK) {
> +        return false;
> +    }
> +    job = g_malloc0(job_size);
> +    if (qpl_init_job(path, job) != QPL_STS_OK) {
> +        g_free(job);
> +        return false;
> +    }
> +    g_free(job);
> +    return true;
> +}
> +
> +/**
> + * multifd_qpl_free_jobs: cleanup jobs
> + *
> + * Free all job resources.
> + *
> + * @qpl: pointer to the QplData structure
> + */
> +static void multifd_qpl_free_jobs(QplData *qpl)
> +{
> +    assert(qpl != NULL);
> +    for (int i = 0; i < qpl->total_job_num; i++) {
> +        qpl_fini_job(qpl->job_array[i]);
> +        g_free(qpl->job_array[i]);
> +        qpl->job_array[i] = NULL;
> +    }
> +    g_free(qpl->job_array);
> +    qpl->job_array = NULL;
> +}
> +
> +/**
> + * multifd_qpl_init_jobs: initialize jobs
> + *
> + * Initialize all jobs
> + *
> + * @qpl: pointer to the QplData structure
> + * @chan_id: multifd channel number
> + * @errp: pointer to an error
> + */
> +static int multifd_qpl_init_jobs(QplData *qpl, uint8_t chan_id, Error **errp)
> +{
> +    qpl_path_t path;
> +    qpl_status status;
> +    uint32_t job_size = 0;
> +    qpl_job *job = NULL;
> +
> +    path = qpl->iaa_avail ? qpl_path_hardware : qpl_path_software;
> +    status = qpl_get_job_size(path, &job_size);
> +    if (status != QPL_STS_OK) {
> +        error_setg(errp, "multifd: %u: qpl_get_job_size failed with error %d",
> +                   chan_id, status);
> +        return -1;
> +    }
> +    qpl->job_array = g_new0(qpl_job *, qpl->total_job_num);
> +    for (int i = 0; i < qpl->total_job_num; i++) {
> +        job = g_malloc0(job_size);
> +        status = qpl_init_job(path, job);
> +        if (status != QPL_STS_OK) {
> +            error_setg(errp, "multifd: %u: qpl_init_job failed with error %d",
> +                       chan_id, status);
> +            multifd_qpl_free_jobs(qpl);
> +            return -1;
> +        }
> +        qpl->job_array[i] = job;
> +    }
> +    return 0;
> +}
> +
> +/**
> + * multifd_qpl_init: initialize QplData structure
> + *
> + * Allocate and initialize a QplData structure
> + *
> + * Returns QplData pointer for success or NULL for error
> + *
> + * @job_num: pointer to the QplData structure
> + * @job_size: the buffer size of the job
> + * @chan_id: multifd channel number
> + * @errp: pointer to an error
> + */
> +static QplData *multifd_qpl_init(uint32_t job_num, uint32_t job_size,
> +                                 uint8_t chan_id, Error **errp)
> +{
> +    QplData *qpl;
> +
> +    qpl = g_new0(QplData, 1);
> +    qpl->total_job_num = job_num;
> +    qpl->iaa_avail = check_iaa_avail();
> +    if (multifd_qpl_init_jobs(qpl, chan_id, errp) != 0) {
> +        g_free(qpl);
> +        return NULL;
> +    }
> +    qpl->zbuf = g_malloc0(job_size * job_num);
> +    qpl->zbuf_hdr = g_new0(uint32_t, job_num);
> +    return qpl;
> +}
> +
> +/**
> + * multifd_qpl_deinit: cleanup QplData structure
> + *
> + * Free jobs, comprssed buffers and QplData structure
> + *
> + * @qpl: pointer to the QplData structure
> + */
> +static void multifd_qpl_deinit(QplData *qpl)
> +{
> +    if (qpl != NULL) {
> +        multifd_qpl_free_jobs(qpl);
> +        g_free(qpl->zbuf_hdr);
> +        g_free(qpl->zbuf);
> +        g_free(qpl);
> +    }
> +}
> +
> +/**
> + * multifd_qpl_send_setup: setup send side
> + *
> + * Setup each channel with QPL compression.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @errp: pointer to an error
> + */
> +static int multifd_qpl_send_setup(MultiFDSendParams *p, Error **errp)
> +{
> +    QplData *qpl;
> +
> +    qpl = multifd_qpl_init(p->page_count, p->page_size, p->id, errp);
> +    if (!qpl) {
> +        return -1;
> +    }
> +    p->compress_data = qpl;
> +
> +    /*
> +     * Each page will be compressed independently and sent using an IOV. The
> +     * additional two IOVs are used to store packet header and compressed data
> +     * length
> +     */
> +    p->iov = g_new0(struct iovec, p->page_count + 2);
> +    return 0;
> +}
> +
> +/**
> + * multifd_qpl_send_cleanup: cleanup send side
> + *
> + * Close the channel and return memory.
> + *
> + * @p: Params for the channel that we are using
> + * @errp: pointer to an error
> + */
> +static void multifd_qpl_send_cleanup(MultiFDSendParams *p, Error **errp)
> +{
> +    multifd_qpl_deinit(p->compress_data);
> +    p->compress_data = NULL;
> +    g_free(p->iov);
> +    p->iov = NULL;
> +}
> +
> +/**
> + * multifd_qpl_send_prepare: prepare data to be able to send
> + *
> + * Create a compressed buffer with all the pages that we are going to
> + * send.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @errp: pointer to an error
> + */
> +static int multifd_qpl_send_prepare(MultiFDSendParams *p, Error **errp)
> +{
> +    /* Implement in next patch */
> +    return -1;
> +}
> +
> +/**
> + * multifd_qpl_recv_setup: setup receive side
> + *
> + * Create the compressed channel and buffer.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @errp: pointer to an error
> + */
> +static int multifd_qpl_recv_setup(MultiFDRecvParams *p, Error **errp)
> +{
> +    QplData *qpl;
> +
> +    qpl = multifd_qpl_init(p->page_count, p->page_size, p->id, errp);
> +    if (!qpl) {
> +        return -1;
> +    }
> +    p->compress_data = qpl;
> +    return 0;
> +}
> +
> +/**
> + * multifd_qpl_recv_cleanup: setup receive side
> + *
> + * Close the channel and return memory.
> + *
> + * @p: Params for the channel that we are using
> + */
> +static void multifd_qpl_recv_cleanup(MultiFDRecvParams *p)
> +{
> +    multifd_qpl_deinit(p->compress_data);
> +    p->compress_data = NULL;
> +}
> +
> +/**
> + * multifd_qpl_recv: read the data from the channel into actual pages
> + *
> + * Read the compressed buffer, and uncompress it into the actual
> + * pages.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @errp: pointer to an error
> + */
> +static int multifd_qpl_recv(MultiFDRecvParams *p, Error **errp)
> +{
> +    /* Implement in next patch */
> +    return -1;
> +}
> +
> +static MultiFDMethods multifd_qpl_ops = {
> +    .send_setup = multifd_qpl_send_setup,
> +    .send_cleanup = multifd_qpl_send_cleanup,
> +    .send_prepare = multifd_qpl_send_prepare,
> +    .recv_setup = multifd_qpl_recv_setup,
> +    .recv_cleanup = multifd_qpl_recv_cleanup,
> +    .recv = multifd_qpl_recv,
> +};
>  
>  static void multifd_qpl_register(void)
>  {
> -    /* noop */
> +    multifd_register_ops(MULTIFD_COMPRESSION_QPL, &multifd_qpl_ops);
>  }
>  
>  migration_init(multifd_qpl_register);

