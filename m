Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A64C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 10:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmtPC-0006Q7-2U; Wed, 20 Mar 2024 06:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmtPA-0006Pl-SP
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 06:42:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmtP8-0007Ab-T6
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 06:42:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710931362;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=zFV5s/q1acx2sB/ltJqhZlHPGhbi+aWxq7sQI3et4HQ=;
 b=b/SaqTP5ImNy24Rq6gMBIg5SArDUA10g3bUJfiftF1EXmHwwre/gtQ8Rd1t4bRgILsqs6i
 gaxk3GA+p/6OTw8dffnLqHsYyTBieSZWlam5N2sz4xjku4rnVXfoImfD7dVnqLCwTO9Pr/
 Tn5p85TM991grlJoszC7KPRWPoQHH48=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-p2W_b1LpPliJ7-bTOlCsjg-1; Wed,
 20 Mar 2024 06:42:39 -0400
X-MC-Unique: p2W_b1LpPliJ7-bTOlCsjg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 503083806714;
 Wed, 20 Mar 2024 10:42:39 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 634F7C04120;
 Wed, 20 Mar 2024 10:42:35 +0000 (UTC)
Date: Wed, 20 Mar 2024 10:42:28 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yuan Liu <yuan1.liu@intel.com>
Cc: peterx@redhat.com, farosas@suse.de, qemu-devel@nongnu.org,
 hao.xiang@bytedance.com, bryan.zhang@bytedance.com, nanhai.zou@intel.com
Subject: Re: [PATCH v5 5/7] migration/multifd: implement initialization of
 qpl compression
Message-ID: <Zfq9lBXZWcy3Alhw@redhat.com>
References: <20240319164527.1873891-1-yuan1.liu@intel.com>
 <20240319164527.1873891-6-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240319164527.1873891-6-yuan1.liu@intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 20, 2024 at 12:45:25AM +0800, Yuan Liu wrote:
> the qpl initialization includes memory allocation for compressed
> data and the qpl job initialization.
> 
> the qpl initialization will check whether the In-Memory Analytics
> Accelerator(IAA) hardware is available, if the platform does not
> have IAA hardware or the IAA hardware is not available, the QPL
> compression initialization will fail.
> 
> Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> ---
>  migration/multifd-qpl.c | 243 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 242 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
> index 056a68a060..6de65e9da7 100644
> --- a/migration/multifd-qpl.c
> +++ b/migration/multifd-qpl.c
> @@ -9,12 +9,253 @@
>   * This work is licensed under the terms of the GNU GPL, version 2 or later.
>   * See the COPYING file in the top-level directory.
>   */
> +
>  #include "qemu/osdep.h"
>  #include "qemu/module.h"
> +#include "qapi/error.h"
> +#include "migration.h"
> +#include "multifd.h"
> +#include "qpl/qpl.h"
> +
> +typedef struct {
> +    qpl_job **job_array;
> +    /* the number of allocated jobs */
> +    uint32_t job_num;
> +    /* the size of data processed by a qpl job */
> +    uint32_t data_size;
> +    /* compressed data buffer */
> +    uint8_t *zbuf;
> +    /* the length of compressed data */
> +    uint32_t *zbuf_hdr;
> +} QplData;
> +
> +static void free_zbuf(QplData *qpl)
> +{
> +    if (qpl->zbuf != NULL) {
> +        munmap(qpl->zbuf, qpl->job_num * qpl->data_size);
> +        qpl->zbuf = NULL;
> +    }
> +    if (qpl->zbuf_hdr != NULL) {
> +        g_free(qpl->zbuf_hdr);
> +        qpl->zbuf_hdr = NULL;
> +    }
> +}
> +
> +static int alloc_zbuf(QplData *qpl, uint8_t chan_id, Error **errp)
> +{
> +    int flags = MAP_PRIVATE | MAP_POPULATE | MAP_ANONYMOUS;
> +    uint32_t size = qpl->job_num * qpl->data_size;
> +    uint8_t *buf;
> +
> +    buf = (uint8_t *) mmap(NULL, size, PROT_READ | PROT_WRITE, flags, -1, 0);
> +    if (buf == MAP_FAILED) {
> +        error_setg(errp, "multifd: %u: alloc_zbuf failed, job num %u, size %u",
> +                   chan_id, qpl->job_num, qpl->data_size);
> +        return -1;
> +    }

What's the reason for using mmap here, rather than a normal
malloc ?

> +    qpl->zbuf = buf;
> +    qpl->zbuf_hdr = g_new0(uint32_t, qpl->job_num);
> +    return 0;
> +}
> +
> +static void free_jobs(QplData *qpl)
> +{
> +    for (int i = 0; i < qpl->job_num; i++) {
> +        qpl_fini_job(qpl->job_array[i]);
> +        g_free(qpl->job_array[i]);
> +        qpl->job_array[i] = NULL;
> +    }
> +    g_free(qpl->job_array);
> +    qpl->job_array = NULL;
> +}
> +
> +static int alloc_jobs(QplData *qpl, uint8_t chan_id, Error **errp)
> +{
> +    qpl_status status;
> +    uint32_t job_size = 0;
> +    qpl_job *job = NULL;
> +    /* always use IAA hardware accelerator */
> +    qpl_path_t path = qpl_path_hardware;
> +
> +    status = qpl_get_job_size(path, &job_size);
> +    if (status != QPL_STS_OK) {
> +        error_setg(errp, "multifd: %u: qpl_get_job_size failed with error %d",
> +                   chan_id, status);
> +        return -1;
> +    }
> +    qpl->job_array = g_new0(qpl_job *, qpl->job_num);
> +    for (int i = 0; i < qpl->job_num; i++) {
> +        job = g_malloc0(job_size);
> +        status = qpl_init_job(path, job);
> +        if (status != QPL_STS_OK) {
> +            error_setg(errp, "multifd: %u: qpl_init_job failed with error %d",
> +                       chan_id, status);
> +            free_jobs(qpl);
> +            return -1;
> +        }
> +        qpl->job_array[i] = job;
> +    }
> +    return 0;
> +}
> +
> +static int init_qpl(QplData *qpl, uint32_t job_num, uint32_t data_size,
> +                    uint8_t chan_id, Error **errp)
> +{

IMHO this method should be a normal constructor, it it should
be responsible for allocating 'qpl' struct too, and returning
it, not have the caller allocate it.

> +    qpl->job_num = job_num;
> +    qpl->data_size = data_size;
> +    if (alloc_zbuf(qpl, chan_id, errp) != 0) {
> +        return -1;
> +    }
> +    if (alloc_jobs(qpl, chan_id, errp) != 0) {
> +        free_zbuf(qpl);
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +static void deinit_qpl(QplData *qpl)
> +{
> +    if (qpl != NULL) {
> +        free_jobs(qpl);
> +        free_zbuf(qpl);
> +        qpl->job_num = 0;
> +        qpl->data_size = 0;
> +    }
> +}

This should also free 'qpl' instead of leaving it upto the
caller.

> +
> +/**
> + * qpl_send_setup: setup send side
> + *
> + * Setup each channel with QPL compression.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @errp: pointer to an error
> + */
> +static int qpl_send_setup(MultiFDSendParams *p, Error **errp)
> +{
> +    QplData *qpl;
> +
> +    qpl = g_new0(QplData, 1);
> +    if (init_qpl(qpl, p->page_count, p->page_size, p->id, errp) != 0) {
> +        g_free(qpl);
> +        return -1;
> +    }
> +    p->compress_data = qpl;
> +
> +    assert(p->iov == NULL);
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
> + * qpl_send_cleanup: cleanup send side
> + *
> + * Close the channel and return memory.
> + *
> + * @p: Params for the channel that we are using
> + * @errp: pointer to an error
> + */
> +static void qpl_send_cleanup(MultiFDSendParams *p, Error **errp)
> +{
> +    QplData *qpl = p->compress_data;
> +
> +    deinit_qpl(qpl);
> +    g_free(p->compress_data);
> +    p->compress_data = NULL;
> +}
> +
> +/**
> + * qpl_send_prepare: prepare data to be able to send
> + *
> + * Create a compressed buffer with all the pages that we are going to
> + * send.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @errp: pointer to an error
> + */
> +static int qpl_send_prepare(MultiFDSendParams *p, Error **errp)
> +{
> +    /* Implement in next patch */
> +    return -1;
> +}
> +
> +/**
> + * qpl_recv_setup: setup receive side
> + *
> + * Create the compressed channel and buffer.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @errp: pointer to an error
> + */
> +static int qpl_recv_setup(MultiFDRecvParams *p, Error **errp)
> +{
> +    QplData *qpl;
> +
> +    qpl = g_new0(QplData, 1);
> +    if (init_qpl(qpl, p->page_count, p->page_size, p->id, errp) != 0) {
> +        g_free(qpl);
> +        return -1;
> +    }
> +    p->compress_data = qpl;
> +    return 0;
> +}
> +
> +/**
> + * qpl_recv_cleanup: setup receive side
> + *
> + * Close the channel and return memory.
> + *
> + * @p: Params for the channel that we are using
> + */
> +static void qpl_recv_cleanup(MultiFDRecvParams *p)
> +{
> +    QplData *qpl = p->compress_data;
> +
> +    deinit_qpl(qpl);
> +    g_free(p->compress_data);
> +    p->compress_data = NULL;
> +}
> +
> +/**
> + * qpl_recv: read the data from the channel into actual pages
> + *
> + * Read the compressed buffer, and uncompress it into the actual
> + * pages.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @errp: pointer to an error
> + */
> +static int qpl_recv(MultiFDRecvParams *p, Error **errp)
> +{
> +    /* Implement in next patch */
> +    return -1;
> +}

The qpl library uses 'qpl_' as its name prefix, so using the
same prefix in QEMU is fragile if future APIs are added to
the library.

Please consistently use 'multifd_qpl_' as the prefix for
*every* method in this file.

> +
> +static MultiFDMethods multifd_qpl_ops = {
> +    .send_setup = qpl_send_setup,
> +    .send_cleanup = qpl_send_cleanup,
> +    .send_prepare = qpl_send_prepare,
> +    .recv_setup = qpl_recv_setup,
> +    .recv_cleanup = qpl_recv_cleanup,
> +    .recv = qpl_recv,
> +};
>  
>  static void multifd_qpl_register(void)
>  {
> -    /* noop */
> +    multifd_register_ops(MULTIFD_COMPRESSION_QPL, &multifd_qpl_ops);
>  }
>  
>  migration_init(multifd_qpl_register);
> -- 
> 2.39.3
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


