Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3C1C27C53
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 14:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEs5b-0000j0-Mm; Wed, 05 Jun 2024 10:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sEs5a-0000iW-Io
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 10:58:10 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sEs5Y-00089R-FV
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 10:58:10 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B093521AC7;
 Wed,  5 Jun 2024 14:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717599486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VkKjecMsE5IEeRSvc04idQm3UKbavwFQTLqlMINHX54=;
 b=vh0p8bhjSx3lcxRu+dxs8e2Mrn6kI4pLUYj3CXw0PqmJf6zCZFXpZopa0bBUObhP3F/37H
 8aVDRlxwAcNWW82cPYTj9naULrgnPtCZIMYyGUPUeOwFWN5SxeRPOi68SQASZYsRdMX61w
 C5eeHF14mhs1V5+MPX/6EKKFw8piG6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717599486;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VkKjecMsE5IEeRSvc04idQm3UKbavwFQTLqlMINHX54=;
 b=xEPXyZah2OeWAlGurcPFlJxunM71q/9W146ohurBZ13RwE8VQTFg7aHrGzm634EOQE/I1e
 VGnoPsGuc8sbf/DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717599485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VkKjecMsE5IEeRSvc04idQm3UKbavwFQTLqlMINHX54=;
 b=TyesXl9fTkFk/Ktx6pVHwuFcXQrD6yvWCM55t2IdFhaz0eFsUveDRsj2J2vPDmWiGK0S8C
 vF31/UkivQmmXIYhsosax+AhpAQJNfctTumAxe/dD9BejGmSQl5i8jALvTRLV8EJ2gO2Sa
 zXd0sEzSfMX2E1zHPoMQdZ75TJHsUpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717599485;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VkKjecMsE5IEeRSvc04idQm3UKbavwFQTLqlMINHX54=;
 b=bcaWQ8WCzPBy+bLg1wABTioRd7lUrUb4sneGQwAONaJT8wPv1nYK6NPdcQ/d3ayGY6xibB
 YciGkC6I2Ld0BhDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3563D13A42;
 Wed,  5 Jun 2024 14:58:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Ci37Ovx8YGblPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 05 Jun 2024 14:58:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 peterx@redhat.com, yuan1.liu@intel.com
Cc: qemu-devel@nongnu.org, linuxarm@huawei.com, linwenkai6@hisilicon.com,
 zhangfei.gao@linaro.org, huangchenghai2@huawei.com
Subject: Re: [PATCH 4/7] migration/multifd: Add UADK initialization
In-Reply-To: <20240529094435.11140-5-shameerali.kolothum.thodi@huawei.com>
References: <20240529094435.11140-1-shameerali.kolothum.thodi@huawei.com>
 <20240529094435.11140-5-shameerali.kolothum.thodi@huawei.com>
Date: Wed, 05 Jun 2024 11:58:02 -0300
Message-ID: <87zfrzfnd1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[8]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email, imap1.dmz-prg2.suse.org:helo,
 nongnu.org:email]
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

Shameer Kolothum via <qemu-devel@nongnu.org> writes:

> Initialize UADK session and allocate buffers required. The actual
> compression/decompression will only be done in a subsequent patch.
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  migration/multifd-uadk.c | 207 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 206 insertions(+), 1 deletion(-)
>
> diff --git a/migration/multifd-uadk.c b/migration/multifd-uadk.c
> index c2bb07535b..3172e4d5ca 100644
> --- a/migration/multifd-uadk.c
> +++ b/migration/multifd-uadk.c
> @@ -12,9 +12,214 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/module.h"
> +#include "qapi/error.h"
> +#include "migration.h"
> +#include "multifd.h"
> +#include "options.h"
> +#include "uadk/wd_comp.h"
> +#include "uadk/wd_sched.h"
> +
> +struct wd_data {
> +    handle_t handle;
> +    uint8_t *buf;
> +    uint32_t *buf_hdr;
> +};
> +
> +static bool uadk_hw_initialised(void)

The first time this is called it will actually do the initialization,
no? If so, it should be uadk_hw_init().

> +{
> +    char alg[] = "zlib";
> +    int ret;
> +
> +    ret = wd_comp_init2(alg, SCHED_POLICY_RR, TASK_HW);
> +    if (ret && ret != -WD_EEXIST) {
> +        return false;
> +    } else {
> +        return true;
> +    }
> +}
> +
> +static struct wd_data *multifd_uadk_init_sess(uint32_t count,
> +                                              uint32_t page_size,
> +                                              bool compress, Error **errp)
> +{
> +    struct wd_comp_sess_setup ss = {0};
> +    struct sched_params param = {0};
> +    uint32_t size = count * page_size;
> +    struct wd_data *wd;
> +
> +    if (!uadk_hw_initialised()) {
> +        error_setg(errp, "multifd: UADK hardware not available");

Does the lib provide a software fallback path that we could use like QPL
does?

> +        return NULL;
> +    }
> +
> +    wd = g_new0(struct wd_data, 1);
> +    ss.alg_type = WD_ZLIB;
> +    if (compress) {
> +        ss.op_type = WD_DIR_COMPRESS;
> +        /* Add an additional page for handling output > input */
> +        size += page_size;
> +    } else {
> +        ss.op_type = WD_DIR_DECOMPRESS;
> +    }
> +    param.type = ss.op_type;
> +    ss.sched_param = &param;

What about window size and compression level? Don't we need to set them
here? What do they default to?

> +
> +    wd->handle = wd_comp_alloc_sess(&ss);
> +    if (!wd->handle) {
> +        error_setg(errp, "multifd: failed wd_comp_alloc_sess");
> +        goto out;
> +    }
> +
> +    wd->buf = g_try_malloc(size);
> +    if (!wd->buf) {
> +        error_setg(errp, "multifd: out of mem for uadk buf");
> +        goto out_free_sess;
> +    }
> +    wd->buf_hdr = g_new0(uint32_t, count);
> +    return wd;
> +
> +out_free_sess:
> +    wd_comp_free_sess(wd->handle);
> +out:
> +    wd_comp_uninit2();
> +    g_free(wd);
> +    return NULL;
> +}
> +
> +static void multifd_uadk_uninit_sess(struct wd_data *wd)
> +{
> +    wd_comp_free_sess(wd->handle);
> +    wd_comp_uninit2();
> +    g_free(wd->buf);
> +    g_free(wd->buf_hdr);
> +    g_free(wd);
> +}
> +
> +/**
> + * multifd_uadk_send_setup: setup send side
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @errp: pointer to an error
> + */
> +static int multifd_uadk_send_setup(MultiFDSendParams *p, Error **errp)
> +{
> +    struct wd_data *wd;
> +
> +    wd = multifd_uadk_init_sess(p->page_count, p->page_size, true, errp);
> +    if (!wd) {
> +        return -1;
> +    }
> +
> +    p->compress_data = wd;
> +    assert(p->iov == NULL);
> +    /*
> +     * Each page will be compressed independently and sent using an IOV. The
> +     * additional two IOVs are used to store packet header and compressed data
> +     * length
> +     */
> +
> +    p->iov = g_new0(struct iovec, p->page_count + 2);
> +    return 0;
> +}
> +
> +/**
> + * multifd_uadk_send_cleanup: cleanup send side
> + *
> + * Close the channel and return memory.
> + *
> + * @p: Params for the channel that we are using
> + * @errp: pointer to an error
> + */
> +static void multifd_uadk_send_cleanup(MultiFDSendParams *p, Error **errp)
> +{
> +    struct wd_data *wd = p->compress_data;
> +
> +    multifd_uadk_uninit_sess(wd);
> +    p->compress_data = NULL;
> +}
> +
> +/**
> + * multifd_uadk_send_prepare: prepare data to be able to send
> + *
> + * Create a compressed buffer with all the pages that we are going to
> + * send.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @errp: pointer to an error
> + */
> +static int multifd_uadk_send_prepare(MultiFDSendParams *p, Error **errp)
> +{
> +    return -1;
> +}
> +
> +/**
> + * multifd_uadk_recv_setup: setup receive side
> + *
> + * Create the compressed channel and buffer.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @errp: pointer to an error
> + */
> +static int multifd_uadk_recv_setup(MultiFDRecvParams *p, Error **errp)
> +{
> +    struct wd_data *wd;
> +
> +    wd = multifd_uadk_init_sess(p->page_count, p->page_size, false, errp);
> +    if (!wd) {
> +        return -1;
> +    }
> +    p->compress_data = wd;
> +    return 0;
> +}
> +
> +/**
> + * multifd_uadk_recv_cleanup: setup receive side
> + *
> + * For no compression this function does nothing.

This line makes no sense here.

> + *
> + * @p: Params for the channel that we are using
> + */
> +static void multifd_uadk_recv_cleanup(MultiFDRecvParams *p)
> +{
> +    struct wd_data *wd = p->compress_data;
> +
> +    multifd_uadk_uninit_sess(wd);
> +    p->compress_data = NULL;
> +}
> +
> +/**
> + * multifd_uadk_recv: read the data from the channel into actual pages
> + *
> + * Read the compressed buffer, and uncompress it into the actual
> + * pages.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @errp: pointer to an error
> + */
> +static int multifd_uadk_recv(MultiFDRecvParams *p, Error **errp)
> +{
> +    return -1;
> +}
> +
> +static MultiFDMethods multifd_uadk_ops = {
> +    .send_setup = multifd_uadk_send_setup,
> +    .send_cleanup = multifd_uadk_send_cleanup,
> +    .send_prepare = multifd_uadk_send_prepare,
> +    .recv_setup = multifd_uadk_recv_setup,
> +    .recv_cleanup = multifd_uadk_recv_cleanup,
> +    .recv = multifd_uadk_recv,
> +};
>  
>  static void multifd_uadk_register(void)
>  {
> -    /* noop for now */
> +    multifd_register_ops(MULTIFD_COMPRESSION_UADK, &multifd_uadk_ops);
>  }
>  migration_init(multifd_uadk_register);

