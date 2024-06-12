Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F710C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 14:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHOz2-0002iw-Sq; Wed, 12 Jun 2024 10:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sHOz1-0002iC-24
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 10:29:51 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sHOyz-0000Yw-Ab
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 10:29:50 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7D54034504;
 Wed, 12 Jun 2024 14:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718202587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WuCoccR8wGrYfCJ+4uYhLaYtQucqsmGa9164u4vQxxE=;
 b=BaYCzDgcbzJsAD8CbRuI/duVTsmIWdRiwjjdrp70PhZECXqYlixxKtpWtRz44cVupyb4Jo
 UIAKFyNm3HQN0fbVoTFd4unEKwCV0VooFEBmZUlT85eYdklI5hqI+DLAmiX/kw7Y9gUOvA
 wCGepMrmVisOFs5AhaoRdLKm2YxepLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718202587;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WuCoccR8wGrYfCJ+4uYhLaYtQucqsmGa9164u4vQxxE=;
 b=0VGfMDAyQKhvaa7cRLa9enzkCsbyUYYjRXJBZUiNKYAV95YsmkHJt5JWoC49lvCeHJgiZf
 Zy/qwrtie4mhoYAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718202586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WuCoccR8wGrYfCJ+4uYhLaYtQucqsmGa9164u4vQxxE=;
 b=eDCDu4UqgLG8wL5H+BJhuWbpxzhz7OaRAjm/QaO8ga2QPUoxy6MbJplr4nC+aZbTiNWW5e
 t1Mf9oLZiEI5GSzd8vHURo22MnDm+12DPdQAD8+Vh4tZmMvwNzPAHAwwhvKxEfeZuNe129
 xfA4vmsdguuxz8zCKJXYkrEpVNhXtD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718202586;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WuCoccR8wGrYfCJ+4uYhLaYtQucqsmGa9164u4vQxxE=;
 b=9ehnh/rIGYJsxUnLUa3oFouh1pAnuwh5S/5st9sfZ4XBv1IhwPwcqdsoaGnEDDpjqXxWy4
 cBy4n+pLVRCDWXCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0C011372E;
 Wed, 12 Jun 2024 14:29:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id h8xHLdmwaWYmTAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 12 Jun 2024 14:29:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Yuan Liu <yuan1.liu@intel.com>, peterx@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org
Cc: qemu-devel@nongnu.org, yuan1.liu@intel.com, nanhai.zou@intel.com,
 shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH v8 6/7] migration/multifd: implement qpl compression and
 decompression
In-Reply-To: <20240610102110.900410-7-yuan1.liu@intel.com>
References: <20240610102110.900410-1-yuan1.liu@intel.com>
 <20240610102110.900410-7-yuan1.liu@intel.com>
Date: Wed, 12 Jun 2024 11:29:43 -0300
Message-ID: <87jziucjzc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [3.80 / 50.00]; BAYES_SPAM(5.10)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_SEVEN(0.00)[11];
 MID_RHS_MATCH_FROM(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 intel.com:email]
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

> QPL compression and decompression will use IAA hardware path if the IAA
> hardware is available. Otherwise the QPL library software path is used.
>
> The hardware path will automatically fall back to QPL software path if
> the IAA queues are busy. In some scenarios, this may happen frequently,
> such as configuring 4 channels but only one IAA device is available. In
> the case of insufficient IAA hardware resources, retry and fallback can
> help optimize performance:
>
>  1. Retry + SW fallback:
>     total time: 14649 ms
>     downtime: 25 ms
>     throughput: 17666.57 mbps
>     pages-per-second: 1509647
>
>  2. No fallback, always wait for work queues to become available
>     total time: 18381 ms
>     downtime: 25 ms
>     throughput: 13698.65 mbps
>     pages-per-second: 859607
>
> If both the hardware and software paths fail, the uncompressed page is
> sent directly.
>
> Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> ---
>  migration/multifd-qpl.c | 424 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 420 insertions(+), 4 deletions(-)
>
> diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
> index 6791a204d5..9265098ee7 100644
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
> @@ -260,6 +265,225 @@ static void multifd_qpl_send_cleanup(MultiFDSendParams *p, Error **errp)
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
> + * multifd_qpl_prepare_comp_job: prepare the compression job
> + *
> + * Set the compression job parameters and properties.
> + *
> + * @job: pointer to the qpl_job structure
> + * @input: pointer to the input data buffer
> + * @output: pointer to the output data buffer
> + * @size: the page size
> + */
> +static void multifd_qpl_prepare_comp_job(qpl_job *job, uint8_t *input,
> +                                         uint8_t *output, uint32_t size)
> +{
> +    /*
> +     * Set output length to less than the page size to force the job to
> +     * fail in case it compresses to a larger size. We'll send that page
> +     * without compression and skip the decompression operation on the
> +     * destination.
> +     */

This is way better in here!

Reviewed-by: Fabiano Rosas <farosas@suse.de>

