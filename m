Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87237E64012
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 20:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEEGZ-0004Fp-EY; Thu, 21 Nov 2024 15:59:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tEEGS-0004Eu-9r
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 15:59:01 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tEEGQ-0002cY-Hk
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 15:59:00 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9393D219F3;
 Thu, 21 Nov 2024 20:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732222736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rj0MHl0yYU8w2kWqG6tEdLbTemqwjWRHFT6/12PDwbE=;
 b=Tw0ISNVu2p0jsWuWIRDKKzBvvlVXEd/qS65SYizOeFaqYnksMvDOgFfrHLtByH8kN7itE1
 xnIyExiafehK02fFh1qqPv5KkNkjg9IcdWjK9I9jOaZtgFn6tMQSyT4JCWJntgKOxQuVFq
 k9MbfNTpxHVkxmwG4ibohiL8/yB8wMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732222736;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rj0MHl0yYU8w2kWqG6tEdLbTemqwjWRHFT6/12PDwbE=;
 b=qO9mdaoqftdYugQMT6JfN59L8JZIc1DaGfyRJOgJa2Yr1MWToYf17s2b1lq2NDYUbTri60
 EHdFljoD0WHK3RAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732222736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rj0MHl0yYU8w2kWqG6tEdLbTemqwjWRHFT6/12PDwbE=;
 b=Tw0ISNVu2p0jsWuWIRDKKzBvvlVXEd/qS65SYizOeFaqYnksMvDOgFfrHLtByH8kN7itE1
 xnIyExiafehK02fFh1qqPv5KkNkjg9IcdWjK9I9jOaZtgFn6tMQSyT4JCWJntgKOxQuVFq
 k9MbfNTpxHVkxmwG4ibohiL8/yB8wMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732222736;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rj0MHl0yYU8w2kWqG6tEdLbTemqwjWRHFT6/12PDwbE=;
 b=qO9mdaoqftdYugQMT6JfN59L8JZIc1DaGfyRJOgJa2Yr1MWToYf17s2b1lq2NDYUbTri60
 EHdFljoD0WHK3RAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0EA24137CF;
 Thu, 21 Nov 2024 20:58:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JabzMQ+fP2f1KgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 21 Nov 2024 20:58:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Yichen Wang <yichen.wang@bytedance.com>, Peter Xu <peterx@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 Shivam Kumar <shivam.kumar1@nutanix.com>, "Ho-Ren (Jack) Chuang"
 <horenchuang@bytedance.com>, Yichen Wang <yichen.wang@bytedance.com>
Subject: Re: [PATCH v7 05/12] util/dsa: Implement DSA task asynchronous
 completion thread model.
In-Reply-To: <20241114220132.27399-6-yichen.wang@bytedance.com>
References: <20241114220132.27399-1-yichen.wang@bytedance.com>
 <20241114220132.27399-6-yichen.wang@bytedance.com>
Date: Thu, 21 Nov 2024 17:58:53 -0300
Message-ID: <87cyiopalu.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[17]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> From: Hao Xiang <hao.xiang@linux.dev>
>
> * Create a dedicated thread for DSA task completion.
> * DSA completion thread runs a loop and poll for completed tasks.
> * Start and stop DSA completion thread during DSA device start stop.
>
> User space application can directly submit task to Intel DSA
> accelerator by writing to DSA's device memory (mapped in user space).
> Once a task is submitted, the device starts processing it and write
> the completion status back to the task. A user space application can
> poll the task's completion status to check for completion. This change
> uses a dedicated thread to perform DSA task completion checking.
>
> Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
> ---
>  include/qemu/dsa.h |   1 +
>  util/dsa.c         | 274 ++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 274 insertions(+), 1 deletion(-)
>
> diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
> index 04ee8924ab..d24567f0be 100644
> --- a/include/qemu/dsa.h
> +++ b/include/qemu/dsa.h
> @@ -69,6 +69,7 @@ typedef struct QemuDsaBatchTask {
>      QemuDsaTaskType task_type;
>      QemuDsaTaskStatus status;
>      int batch_size;
> +    bool *results;
>      QSIMPLEQ_ENTRY(QemuDsaBatchTask) entry;
>  } QemuDsaBatchTask;
>  
> diff --git a/util/dsa.c b/util/dsa.c
> index b55fa599f0..c3ca71df86 100644
> --- a/util/dsa.c
> +++ b/util/dsa.c
> @@ -33,9 +33,20 @@
>  #define DSA_WQ_PORTAL_SIZE 4096
>  #define DSA_WQ_DEPTH 128
>  #define MAX_DSA_DEVICES 16
> +#define DSA_COMPLETION_THREAD "qemu_dsa_completion"
> +
> +typedef struct {
> +    bool stopping;
> +    bool running;
> +    QemuThread thread;
> +    int thread_id;
> +    QemuSemaphore sem_init_done;
> +    QemuDsaDeviceGroup *group;
> +} QemuDsaCompletionThread;
>  
>  uint32_t max_retry_count;
>  static QemuDsaDeviceGroup dsa_group;
> +static QemuDsaCompletionThread completion_thread;
>  
>  
>  /**
> @@ -403,6 +414,265 @@ submit_batch_wi_async(QemuDsaBatchTask *batch_task)
>      return dsa_task_enqueue(device_group, batch_task);
>  }
>  
> +/**
> + * @brief Poll for the DSA work item completion.
> + *
> + * @param completion A pointer to the DSA work item completion record.
> + * @param opcode The DSA opcode.
> + *
> + * @return Zero if successful, non-zero otherwise.
> + */
> +static int
> +poll_completion(struct dsa_completion_record *completion,
> +                enum dsa_opcode opcode)
> +{
> +    uint8_t status;
> +    uint64_t retry = 0;
> +
> +    while (true) {
> +        /* The DSA operation completes successfully or fails. */
> +        status = completion->status;
> +        if (status == DSA_COMP_SUCCESS ||
> +            status == DSA_COMP_PAGE_FAULT_NOBOF ||
> +            status == DSA_COMP_BATCH_PAGE_FAULT ||
> +            status == DSA_COMP_BATCH_FAIL) {
> +            break;
> +        } else if (status != DSA_COMP_NONE) {
> +            error_report("DSA opcode %d failed with status = %d.",
> +                    opcode, status);
> +            return 1;
> +        }
> +        retry++;
> +        if (retry > max_retry_count) {
> +            error_report("DSA wait for completion retry %lu times.", retry);
> +            return 1;
> +        }
> +        _mm_pause();
> +    }
> +
> +    return 0;
> +}
> +
> +/**
> + * @brief Complete a single DSA task in the batch task.
> + *
> + * @param task A pointer to the batch task structure.
> + *
> + * @return Zero if successful, otherwise non-zero.
> + */
> +static int
> +poll_task_completion(QemuDsaBatchTask *task)
> +{
> +    assert(task->task_type == QEMU_DSA_TASK);
> +
> +    struct dsa_completion_record *completion = &task->completions[0];
> +    uint8_t status;
> +    int ret;
> +
> +    ret = poll_completion(completion, task->descriptors[0].opcode);
> +    if (ret != 0) {
> +        goto exit;
> +    }
> +
> +    status = completion->status;
> +    if (status == DSA_COMP_SUCCESS) {
> +        task->results[0] = (completion->result == 0);
> +        goto exit;
> +    }
> +
> +    assert(status == DSA_COMP_PAGE_FAULT_NOBOF);
> +
> +exit:
> +    return ret;
> +}
> +
> +/**
> + * @brief Poll a batch task status until it completes. If DSA task doesn't
> + *        complete properly, use CPU to complete the task.
> + *
> + * @param batch_task A pointer to the DSA batch task.
> + *
> + * @return Zero if successful, otherwise non-zero.
> + */
> +static int
> +poll_batch_task_completion(QemuDsaBatchTask *batch_task)
> +{
> +    struct dsa_completion_record *batch_completion =
> +        &batch_task->batch_completion;
> +    struct dsa_completion_record *completion;
> +    uint8_t batch_status;
> +    uint8_t status;
> +    bool *results = batch_task->results;
> +    uint32_t count = batch_task->batch_descriptor.desc_count;
> +    int ret;
> +
> +    ret = poll_completion(batch_completion,
> +                          batch_task->batch_descriptor.opcode);
> +    if (ret != 0) {
> +        goto exit;
> +    }
> +
> +    batch_status = batch_completion->status;
> +
> +    if (batch_status == DSA_COMP_SUCCESS) {
> +        if (batch_completion->bytes_completed == count) {
> +            /*
> +             * Let's skip checking for each descriptors' completion status
> +             * if the batch descriptor says all succedded.
> +             */
> +            for (int i = 0; i < count; i++) {
> +                assert(batch_task->completions[i].status == DSA_COMP_SUCCESS);
> +                results[i] = (batch_task->completions[i].result == 0);
> +            }
> +            goto exit;
> +        }
> +    } else {
> +        assert(batch_status == DSA_COMP_BATCH_FAIL ||
> +            batch_status == DSA_COMP_BATCH_PAGE_FAULT);
> +    }
> +
> +    for (int i = 0; i < count; i++) {
> +
> +        completion = &batch_task->completions[i];
> +        status = completion->status;
> +
> +        if (status == DSA_COMP_SUCCESS) {
> +            results[i] = (completion->result == 0);
> +            continue;
> +        }
> +
> +        assert(status == DSA_COMP_PAGE_FAULT_NOBOF);
> +
> +        if (status != DSA_COMP_PAGE_FAULT_NOBOF) {
> +            error_report("Unexpected DSA completion status = %u.", status);

Unreachable with the assert above.

With that fixed:

Reviewed-by: Fabiano Rosas <farosas@suse.de>

