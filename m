Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99C7C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 14:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6spP-0005ea-8P; Tue, 14 May 2024 10:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s6spM-0005aK-Qs
 for qemu-devel@nongnu.org; Tue, 14 May 2024 10:08:25 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s6spK-00066h-2K
 for qemu-devel@nongnu.org; Tue, 14 May 2024 10:08:24 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3920A22C19;
 Tue, 14 May 2024 14:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715695700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6hkZ16UO061wkehS+Mcj0Rcl7pRdTAAgP9WOotaibB8=;
 b=1xvSwLA+etLePEVQsM2SR6AFdGd91e5nbWN+PJuLhj8pdllKIGDQ/MkK6E99AidKSIi6r7
 ywKl/IQZJdTIwT8RneM1tJEMhFDA+UFciVirVIlqJi1q9yi12uelKzTKt+Y/+SHu9T1/t/
 R1QEQ6WMRrEsrTq6JE9y79Dv3bmNdaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715695700;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6hkZ16UO061wkehS+Mcj0Rcl7pRdTAAgP9WOotaibB8=;
 b=biC66ANMsLbyHyXju+tUgv8CD6eh+O0paCSNSt+jHGQTja+0jy6aK92TnQUDHhtD53U7d1
 ThFUSKgnK/hlqzBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WjPm6Qzd;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=enfgsi9S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715695699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6hkZ16UO061wkehS+Mcj0Rcl7pRdTAAgP9WOotaibB8=;
 b=WjPm6QzdA91yA32pTUEt5xIPXydsqjMN1P7keFwcGTiyaga/kB+sewMi0ApBb1Pas7O6Hg
 BeM0FaH5rrulqAQlFX+1VgbKw2vCdg/e+LLgz9dPpJjyu5jtjQkjRCTUP9mzOBHMU+GWi7
 G3fSy8gvPdfgQj0w2zA+pwI//3gvv+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715695699;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6hkZ16UO061wkehS+Mcj0Rcl7pRdTAAgP9WOotaibB8=;
 b=enfgsi9Sl7UkHxHH0IfnpBqneaQYSSd21rZ9Ru0xCTb0gS3MZKd4ZnQHBqzb+Rk3UOopvs
 agEbcfsgXa9FiNCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B94C4137C3;
 Tue, 14 May 2024 14:08:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ejLOH1JwQ2buNgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 14 May 2024 14:08:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Liu, Yuan1" <yuan1.liu@intel.com>, "peterx@redhat.com" <peterx@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Zou, Nanhai"
 <nanhai.zou@intel.com>
Subject: RE: [PATCH v6 6/7] migration/multifd: implement qpl compression and
 decompression
In-Reply-To: <PH7PR11MB594145F081617DC668B59343A3E32@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240505165751.2392198-1-yuan1.liu@intel.com>
 <20240505165751.2392198-7-yuan1.liu@intel.com> <87ikzhg2xq.fsf@suse.de>
 <PH7PR11MB594145F081617DC668B59343A3E32@PH7PR11MB5941.namprd11.prod.outlook.com>
Date: Tue, 14 May 2024 11:08:15 -0300
Message-ID: <87ttj0ebao.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3920A22C19
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_EQ_ADDR_SOME(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:dkim, suse.de:email]
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

"Liu, Yuan1" <yuan1.liu@intel.com> writes:

>> -----Original Message-----
>> From: Fabiano Rosas <farosas@suse.de>
>> Sent: Monday, May 13, 2024 11:14 PM
>> To: Liu, Yuan1 <yuan1.liu@intel.com>; peterx@redhat.com
>> Cc: qemu-devel@nongnu.org; Liu, Yuan1 <yuan1.liu@intel.com>; Zou, Nanhai
>> <nanhai.zou@intel.com>
>> Subject: Re: [PATCH v6 6/7] migration/multifd: implement qpl compression
>> and decompression
>> 
>> Yuan Liu <yuan1.liu@intel.com> writes:
>> 
>> > each qpl job is used to (de)compress a normal page and it can
>> > be processed independently by the IAA hardware. All qpl jobs
>> > are submitted to the hardware at once, and wait for all jobs
>> > completion. If hardware path(IAA) is not available, use software
>> > for compression and decompression.
>> >
>> > Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
>> > Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
>> > ---
>> >  migration/multifd-qpl.c | 284 +++++++++++++++++++++++++++++++++++++++-
>> >  1 file changed, 280 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
>> > index 89fa51091a..9a1fddbdd0 100644
>> > --- a/migration/multifd-qpl.c
>> > +++ b/migration/multifd-qpl.c
>> > @@ -13,6 +13,7 @@
>> >  #include "qemu/osdep.h"
>> >  #include "qemu/module.h"
>> >  #include "qapi/error.h"
>> > +#include "exec/ramblock.h"
>> >  #include "migration.h"
>> >  #include "multifd.h"
>> >  #include "qpl/qpl.h"
>> > @@ -204,6 +205,139 @@ static void
>> multifd_qpl_send_cleanup(MultiFDSendParams *p, Error **errp)
>> >      p->iov = NULL;
>> >  }
>> >
>> > +/**
>> > + * multifd_qpl_prepare_job: prepare a compression or decompression job
>> > + *
>> > + * Prepare a compression or decompression job and configure job
>> attributes
>> > + * including job compression level and flags.
>> > + *
>> > + * @job: pointer to the QplData structure
>> 
>> qpl_job structure
>
> Thanks for the comment, I will fix this next version.
>
>> > + * @is_compression: compression or decompression indication
>> > + * @input: pointer to the input data buffer
>> > + * @input_len: the length of the input data
>> > + * @output: pointer to the output data buffer
>> > + * @output_len: the size of the output data buffer
>> > + */
>> > +static void multifd_qpl_prepare_job(qpl_job *job, bool is_compression,
>> > +                                    uint8_t *input, uint32_t input_len,
>> > +                                    uint8_t *output, uint32_t
>> output_len)
>> > +{
>> > +    job->op = is_compression ? qpl_op_compress : qpl_op_decompress;
>> > +    job->next_in_ptr = input;
>> > +    job->next_out_ptr = output;
>> > +    job->available_in = input_len;
>> > +    job->available_out = output_len;
>> > +    job->flags = QPL_FLAG_FIRST | QPL_FLAG_LAST | QPL_FLAG_OMIT_VERIFY;
>> > +    /* only supports one compression level */
>> > +    job->level = 1;
>> > +}
>> > +
>> > +/**
>> > + * multifd_qpl_build_packet: build a qpl compressed data packet
>> > + *
>> > + * The qpl compressed data packet consists of two parts, one part
>> stores
>> > + * the compressed length of each page, and the other part is the
>> compressed
>> > + * data of each page. The zbuf_hdr stores the compressed length of all
>> pages,
>> > + * and use a separate IOV to store the compressed data of each page.
>> > + *
>> > + * @qpl: pointer to the QplData structure
>> > + * @p: Params for the channel that we are using
>> > + * @idx: The index of the compressed length array
>> > + * @addr: pointer to the compressed data
>> > + * @len: The length of the compressed data
>> > + */
>> > +static void multifd_qpl_build_packet(QplData *qpl, MultiFDSendParams
>> *p,
>> > +                                     uint32_t idx, uint8_t *addr,
>> uint32_t len)
>> > +{
>> > +    qpl->zbuf_hdr[idx] = cpu_to_be32(len);
>> > +    p->iov[p->iovs_num].iov_base = addr;
>> > +    p->iov[p->iovs_num].iov_len = len;
>> > +    p->iovs_num++;
>> > +    p->next_packet_size += len;
>> > +}
>> > +
>> > +/**
>> > + * multifd_qpl_compress_pages: compress normal pages
>> > + *
>> > + * Each normal page will be compressed independently, and the
>> compression jobs
>> > + * will be submitted to the IAA hardware in non-blocking mode, waiting
>> for all
>> > + * jobs to be completed and filling the compressed length and data into
>> the
>> > + * sending IOVs. If IAA device is not available, the software path is
>> used.
>> > + *
>> > + * Returns 0 for success or -1 for error
>> > + *
>> > + * @p: Params for the channel that we are using
>> > + * @errp: pointer to an error
>> > + */
>> > +static int multifd_qpl_compress_pages(MultiFDSendParams *p, Error
>> **errp)
>> > +{
>> > +    qpl_status status;
>> > +    QplData *qpl = p->compress_data;
>> > +    MultiFDPages_t *pages = p->pages;
>> > +    uint8_t *zbuf = qpl->zbuf;
>> > +    uint8_t *host = pages->block->host;
>> > +    uint32_t job_num = pages->normal_num;
>> 
>> A bit misleading because job_num is used in the previous patch as a
>> synonym for page_count. We could change the previous patch to:
>> multifd_qpl_init(uint32_t page_count, ...
>
> Yes, I will replace job_num with page_count for multifd_qpl_init next version.
>
>> > +    qpl_job *job = NULL;
>> > +
>> > +    assert(job_num <= qpl->total_job_num);
>> > +    /* submit all compression jobs */
>> > +    for (int i = 0; i < job_num; i++) {
>> > +        job = qpl->job_array[i];
>> > +        multifd_qpl_prepare_job(job, true, host + pages->offset[i],
>> > +                                p->page_size, zbuf, p->page_size - 1);
>> 
>> Isn't the output buffer size == page size, why the -1?
>
> I think the compressed data should be smaller than a normal page. 
> If the compressed data size is equal to a normal page, send the original 
> page directly to avoid decompression operation.
>
> If the output buffer size is set to p->page_size, the compressed data size 
> may be greater than or equal to a normal page, then there are two conditions for
> sending a normal page, one is job status == QPL_STS_OK and job->total_out == p->page_size,
> another is job status == QPL_STS_MORE_OUTPUT_NEEDED.
>
> If the output buffer size is p->page_size - 1, only check QPL_STS_MORE_OUTPUT_NEEDED is ok. 
> I will add comments for this in the next version.
>

Thanks.

>> > +        /* if hardware path(IAA) is unavailable, call the software path
>> */
>> 
>> If we're doing the fallback automatically, isn't that what qpl_path_auto
>> does already? What's the difference between the two approaches?
>
> The qpl_path_auto feature currently has some limitations.
>
> Limitation 1: it does not detect IAA device status before job submission, which means
> I need to use qpl_init_job(qpl_path_hardware, ...) first to make sure the hardware path
> is available, then qpl_path_auto can work for software fallback when submitting a job to 
> the IAA fails.
>
> Limitation 2: The job submission API has changed
> For the qpl_path_hardware, the qpl_submit_job is a non-blocking function, only submitting
> a job to IAA work queues, use qpl_wait_job to get the job result.
>
> For qpl_path_software/auto, the qpl_submit_job is a blocking function and returns the job
> result directly,  qpl_wait_job can't get the job result.
>
> In short, the qpl_submit_job/qpl_wait_job APIs do not well support the qpl_path_auto feature.

Please put a summary of this in the commit message so in the future we
can evaluate whether to continue checking for ourselves.

>
>> > +        if (!qpl->iaa_avail) {
>> 
>> This function got a bit convoluted, it's probably worth a check at the
>> start and a branch to different multifd_qpl_compress_pages_slow()
>> routine altogether.
>
> I agree that using multifd_qpl_compress_pages_slow is a better choice.
>
> In my previous thoughts, the QPl software path(or slow path) is only used
> for the unit test and I did not consider fallback to the software path when
> migration start because the QPL software path has no advantage over zstd.
> So when the work queue is full, always try to resubmit the job instead of 
> fallback software path.
>
> I now realize that when IAA hardware throughput is the bottleneck(the work queue is full),
> switching to software may also increase performance.
>
> I will implement the automatically falling back to the software when IAA work
> queue is full into the next version and update the performance data. With the
> increase in mutlfd migration threads, the performance will be better than now.
> Currently, 4 threads will reach the IAA device throughput bottleneck, then increasing
> The number of threads does not increase any performance.
>
>> > +            status = qpl_execute_job(job);
>> > +            if (status == QPL_STS_OK) {
>> > +                multifd_qpl_build_packet(qpl, p, i, zbuf, job-
>> >total_out);
>> > +            } else if (status == QPL_STS_MORE_OUTPUT_NEEDED) {
>> > +                /* compressed length exceeds page size, send page
>> directly */
>> > +                multifd_qpl_build_packet(qpl, p, i, host + pages-
>> >offset[i],
>> > +                                         p->page_size);
>> > +            } else {
>> > +                error_setg(errp, "multifd %u: qpl_execute_job
>> error %d",
>> > +                           p->id, status);
>> > +                return -1;
>> > +            }
>> > +            zbuf += p->page_size;
>> > +            continue;
>> > +        }
>> > +retry:
>> > +        status = qpl_submit_job(job);
>> > +        if (status == QPL_STS_OK) {
>> > +            zbuf += p->page_size;
>> > +        } else if (status == QPL_STS_QUEUES_ARE_BUSY_ERR) {
>> > +            goto retry;
>> 
>> A retry count here would be nice.
>
> As the previous comment, I will switch to multifd_qpl_compress_pages_slow
> When the work queue is full, I will give a performance comparison between
> hardware only and software fallback next version.
>
>> > +        } else {
>> > +            error_setg(errp, "multifd %u: qpl_submit_job failed with
>> error %d",
>> > +                       p->id, status);
>> > +            return -1;
>> > +        }
>> > +    }
>> > +    if (!qpl->iaa_avail) {
>> > +        goto done;
>> > +    }
>> > +    /* wait all jobs to complete for hardware(IAA) path */
>> > +    for (int i = 0; i < job_num; i++) {
>> > +        job = qpl->job_array[i];
>> > +        status = qpl_wait_job(job);
>> > +        if (status == QPL_STS_OK) {
>> > +            multifd_qpl_build_packet(qpl, p, i, qpl->zbuf + (p-
>> >page_size * i),
>> > +                                     job->total_out);
>> > +        } else if (status == QPL_STS_MORE_OUTPUT_NEEDED) {
>> > +            /* compressed data length exceeds page size, send page
>> directly */
>> > +            multifd_qpl_build_packet(qpl, p, i, host + pages-
>> >offset[i],
>> > +                                     p->page_size);
>> > +        } else {
>> > +            error_setg(errp, "multifd %u: qpl_wait_job failed with
>> error %d",
>> > +                       p->id, status);
>> > +            return -1;
>> > +        }
>> > +    }
>> > +done:
>> > +    return 0;
>> > +}
>> > +
>> >  /**
>> >   * multifd_qpl_send_prepare: prepare data to be able to send
>> >   *
>> > @@ -217,8 +351,28 @@ static void
>> multifd_qpl_send_cleanup(MultiFDSendParams *p, Error **errp)
>> >   */
>> >  static int multifd_qpl_send_prepare(MultiFDSendParams *p, Error **errp)
>> >  {
>> > -    /* Implement in next patch */
>> > -    return -1;
>> > +    QplData *qpl = p->compress_data;
>> > +    uint32_t hdr_size;
>> > +
>> > +    if (!multifd_send_prepare_common(p)) {
>> > +        goto out;
>> > +    }
>> > +
>> > +    assert(p->pages->normal_num <= qpl->total_job_num);
>> > +    hdr_size = p->pages->normal_num * sizeof(uint32_t);
>> > +    /* prepare the header that stores the lengths of all compressed
>> data */
>> > +    p->iov[1].iov_base = (uint8_t *) qpl->zbuf_hdr;
>> > +    p->iov[1].iov_len = hdr_size;
>> 
>> Better use p->iovs_num here in case we ever decide to add more stuff to
>> the front of the array.
>
> Get it, I will fix this next version.
>  
>> > +    p->iovs_num++;
>> > +    p->next_packet_size += hdr_size;
>> 
>> Here's the first time we're setting this value, right? So just a regular
>> attribution(=).
>
> Yes, I will fix this next version.
>
>> > +    if (multifd_qpl_compress_pages(p, errp) != 0) {
>> > +        return -1;
>> > +    }
>> > +
>> > +out:
>> > +    p->flags |= MULTIFD_FLAG_QPL;
>> > +    multifd_send_fill_packet(p);
>> > +    return 0;
>> >  }
>> >
>> >  /**
>> > @@ -256,6 +410,88 @@ static void
>> multifd_qpl_recv_cleanup(MultiFDRecvParams *p)
>> >      p->compress_data = NULL;
>> >  }
>> >
>> > +/**
>> > + * multifd_qpl_decompress_pages: decompress normal pages
>> > + *
>> > + * Each compressed page will be decompressed independently, and the
>> > + * decompression jobs will be submitted to the IAA hardware in non-
>> blocking
>> > + * mode, waiting for all jobs to be completed and loading the
>> decompressed
>> > + * data into guest memory. If IAA device is not available, the software
>> path
>> > + * is used.
>> > + *
>> > + * Returns 0 for success or -1 for error
>> > + *
>> > + * @p: Params for the channel that we are using
>> > + * @errp: pointer to an error
>> > + */
>> > +static int multifd_qpl_decompress_pages(MultiFDRecvParams *p, Error
>> **errp)
>> > +{
>> > +    qpl_status status;
>> > +    qpl_job *job;
>> > +    QplData *qpl = p->compress_data;
>> > +    uint32_t job_num = p->normal_num;
>> > +    uint32_t off = 0;
>> > +
>> > +    assert(job_num <= qpl->total_job_num);
>> > +    /* submit all decompression jobs */
>> > +    for (int i = 0; i < job_num; i++) {
>> > +        /* if the data size is the same as the page size, load it
>> directly */
>> > +        if (qpl->zbuf_hdr[i] == p->page_size) {
>> > +            memcpy(p->host + p->normal[i], qpl->zbuf + off, p-
>> >page_size);
>> > +            off += p->page_size;
>> > +            continue;
>> > +        }
>> > +        job = qpl->job_array[i];
>> > +        multifd_qpl_prepare_job(job, false, qpl->zbuf + off, qpl-
>> >zbuf_hdr[i],
>> > +                                p->host + p->normal[i], p->page_size);
>> > +        /* if hardware path(IAA) is unavailable, call the software path
>> */
>> > +        if (!qpl->iaa_avail) {
>> > +            status = qpl_execute_job(job);
>> > +            if (status == QPL_STS_OK) {
>> > +                off += qpl->zbuf_hdr[i];
>> > +                continue;
>> > +            }
>> > +            error_setg(errp, "multifd %u: qpl_execute_job failed with
>> error %d",
>> > +                       p->id, status);
>> > +            return -1;
>> > +        }
>> > +retry:
>> > +        status = qpl_submit_job(job);
>> > +        if (status == QPL_STS_OK) {
>> > +            off += qpl->zbuf_hdr[i];
>> > +        } else if (status == QPL_STS_QUEUES_ARE_BUSY_ERR) {
>> > +            goto retry;
>> > +        } else {
>> > +            error_setg(errp, "multifd %u: qpl_submit_job failed with
>> error %d",
>> > +                       p->id, status);
>> > +            return -1;
>> > +        }
>> > +    }
>> > +    if (!qpl->iaa_avail) {
>> > +        goto done;
>> > +    }
>> > +    /* wait all jobs to complete for hardware(IAA) path */
>> > +    for (int i = 0; i < job_num; i++) {
>> > +        if (qpl->zbuf_hdr[i] == p->page_size) {
>> > +            continue;
>> > +        }
>> > +        job = qpl->job_array[i];
>> > +        status = qpl_wait_job(job);
>> > +        if (status != QPL_STS_OK) {
>> > +            error_setg(errp, "multifd %u: qpl_wait_job failed with
>> error %d",
>> > +                       p->id, status);
>> > +            return -1;
>> > +        }
>> > +        if (job->total_out != p->page_size) {
>> > +            error_setg(errp, "multifd %u: decompressed len %u, expected
>> len %u",
>> > +                       p->id, job->total_out, p->page_size);
>> > +            return -1;
>> > +        }
>> > +    }
>> > +done:
>> > +    return 0;
>> > +}
>> > +
>> >  /**
>> >   * multifd_qpl_recv: read the data from the channel into actual pages
>> >   *
>> > @@ -269,8 +505,48 @@ static void
>> multifd_qpl_recv_cleanup(MultiFDRecvParams *p)
>> >   */
>> >  static int multifd_qpl_recv(MultiFDRecvParams *p, Error **errp)
>> >  {
>> > -    /* Implement in next patch */
>> > -    return -1;
>> > +    QplData *qpl = p->compress_data;
>> > +    uint32_t in_size = p->next_packet_size;
>> > +    uint32_t flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
>> > +    uint32_t hdr_len = p->normal_num * sizeof(uint32_t);
>> > +    uint32_t data_len = 0;
>> > +    int ret;
>> > +
>> > +    if (flags != MULTIFD_FLAG_QPL) {
>> > +        error_setg(errp, "multifd %u: flags received %x flags
>> expected %x",
>> > +                   p->id, flags, MULTIFD_FLAG_QPL);
>> > +        return -1;
>> > +    }
>> > +    multifd_recv_zero_page_process(p);
>> > +    if (!p->normal_num) {
>> > +        assert(in_size == 0);
>> > +        return 0;
>> > +    }
>> > +
>> > +    /* read compressed data lengths */
>> > +    assert(hdr_len < in_size);
>> > +    ret = qio_channel_read_all(p->c, (void *) qpl->zbuf_hdr, hdr_len,
>> errp);
>> > +    if (ret != 0) {
>> > +        return ret;
>> > +    }
>> > +    assert(p->normal_num <= qpl->total_job_num);
>> 
>> I'm still in doubt whether we should use p->page_count directly all
>> over. It's nice to move the concept into the QPL domain space, but it
>> makes less sense in these functions that take MultiFD*Params as
>> argument.
>
> I don't understand what you mean here. Do you plan to remove page_count from MultiFD*Params
> and provide a new API to get the migrated page count?
>

No, I mean that qpl->total_job_num == p->page_count, so we could use
p->page_count in the functions that have MultiFDParams available. Maybe
even drop total_job_num altogether. But I'm debating if it is worth it,
because that makes the code more coupled to multifd and we may not want
that. Let's leave it for now.

>> > +    for (int i = 0; i < p->normal_num; i++) {
>> > +        qpl->zbuf_hdr[i] = be32_to_cpu(qpl->zbuf_hdr[i]);
>> > +        data_len += qpl->zbuf_hdr[i];
>> > +        assert(qpl->zbuf_hdr[i] <= p->page_size);
>> > +    }
>> > +
>> > +    /* read compressed data */
>> > +    assert(in_size == hdr_len + data_len);
>> > +    ret = qio_channel_read_all(p->c, (void *) qpl->zbuf, data_len,
>> errp);
>> > +    if (ret != 0) {
>> > +        return ret;
>> > +    }
>> > +
>> > +    if (multifd_qpl_decompress_pages(p, errp) != 0) {
>> > +        return -1;
>> > +    }
>> > +    return 0;
>> >  }
>> >
>> >  static MultiFDMethods multifd_qpl_ops = {

