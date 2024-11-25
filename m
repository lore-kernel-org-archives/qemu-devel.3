Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F94CD58D75
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 18:01:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFdO1-0005ek-BE; Mon, 25 Nov 2024 13:00:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tFdNc-0005TT-Sv
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 13:00:18 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tFdNa-0003CT-KU
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 13:00:12 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E114B211A1;
 Mon, 25 Nov 2024 18:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732557609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0aHyGijHd2W5qErN6Jpkx5UYnQKxEo8EGAbcQVt33CE=;
 b=dZJh1LlKYCQu+3TurD2xtEuz1ixH4WHKNF4kTBd7Z7xkHBXMWQhPxvDu71lvsM6L1eTFyW
 m/0QJSRD6r1SUCxpjNvFwxSWWZ5MIwF3UxAedyfz6fcOqFrBQUq8plYSGdlPAZ+fb98EGc
 +RWJZ1GTpaMv91bug0/Pj09aCyvjDog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732557609;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0aHyGijHd2W5qErN6Jpkx5UYnQKxEo8EGAbcQVt33CE=;
 b=SCy1k8Q+QNN/p4EhAnNHD5EfHVJt//azbRMZb5M6mZxIvca9Mbu3qfYL2Co3vHkts9ccIU
 nccHAltvEODKlbAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mxaLdOJo;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZeV1sKgX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732557608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0aHyGijHd2W5qErN6Jpkx5UYnQKxEo8EGAbcQVt33CE=;
 b=mxaLdOJoyYgKZ/0S6Sk50c3rN7SC/iV4lf4XZ5ZXE3sjXoUUthKI6p/uH4D74ZHt0P/1qj
 Oo0XXK8iG2JgfgprKL0CaQORYsnTc687G5KPgbjJ7GsYYWXz5pxHaNS0NKTFqbwUNvfZgg
 h27KgJ3zvLVyNcpEo0XT6vZKj4KVdOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732557608;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0aHyGijHd2W5qErN6Jpkx5UYnQKxEo8EGAbcQVt33CE=;
 b=ZeV1sKgXgTOeYEC2LIzOae7v61Om1h1HqMNI/jyy6u28/5S4S3zoxAEqwimUbmo+HJTZeQ
 t74bzoz+azWa7ODA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D92D13890;
 Mon, 25 Nov 2024 18:00:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wqVLBSi7RGfCEAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 25 Nov 2024 18:00:08 +0000
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
 <horenchuang@bytedance.com>, Yichen Wang <yichen.wang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: Re: [PATCH v7 07/12] util/dsa: Implement DSA task asynchronous
 submission and wait for completion.
In-Reply-To: <20241114220132.27399-8-yichen.wang@bytedance.com>
References: <20241114220132.27399-1-yichen.wang@bytedance.com>
 <20241114220132.27399-8-yichen.wang@bytedance.com>
Date: Mon, 25 Nov 2024 15:00:05 -0300
Message-ID: <8734jfp522.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: E114B211A1
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[18];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
> * Add a DSA task completion callback.
> * DSA completion thread will call the tasks's completion callback
> on every task/batch task completion.
> * DSA submission path to wait for completion.
> * Implement CPU fallback if DSA is not able to complete the task.
>
> Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
> Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
> ---
>  include/qemu/dsa.h |  14 +++++
>  util/dsa.c         | 125 +++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 135 insertions(+), 4 deletions(-)
>
> diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
> index cb407b8b49..8284804a32 100644
> --- a/include/qemu/dsa.h
> +++ b/include/qemu/dsa.h
> @@ -123,6 +123,20 @@ buffer_zero_batch_task_init(int batch_size);
>   */
>  void buffer_zero_batch_task_destroy(QemuDsaBatchTask *task);
>  
> +/**
> + * @brief Performs buffer zero comparison on a DSA batch task synchronously.
> + *
> + * @param batch_task A pointer to the batch task.
> + * @param buf An array of memory buffers.
> + * @param count The number of buffers in the array.
> + * @param len The buffer length.
> + *
> + * @return Zero if successful, otherwise non-zero.
> + */
> +int
> +buffer_is_zero_dsa_batch_sync(QemuDsaBatchTask *batch_task,
> +                              const void **buf, size_t count, size_t len);
> +
>  #else
>  
>  typedef struct QemuDsaBatchTask {} QemuDsaBatchTask;
> diff --git a/util/dsa.c b/util/dsa.c
> index 408c163195..50f53ec24b 100644
> --- a/util/dsa.c
> +++ b/util/dsa.c
> @@ -433,6 +433,42 @@ poll_completion(struct dsa_completion_record *completion,
>      return 0;
>  }
>  
> +/**
> + * @brief Helper function to use CPU to complete a single
> + *        zero page checking task.
> + *
> + * @param completion A pointer to a DSA task completion record.
> + * @param descriptor A pointer to a DSA task descriptor.
> + * @param result A pointer to the result of a zero page checking.
> + */
> +static void
> +task_cpu_fallback_int(struct dsa_completion_record *completion,
> +                      struct dsa_hw_desc *descriptor, bool *result)
> +{
> +    const uint8_t *buf;
> +    size_t len;
> +
> +    if (completion->status == DSA_COMP_SUCCESS) {
> +        return;
> +    }
> +
> +    /*
> +     * DSA was able to partially complete the operation. Check the
> +     * result. If we already know this is not a zero page, we can
> +     * return now.
> +     */
> +    if (completion->bytes_completed != 0 && completion->result != 0) {
> +        *result = false;
> +        return;
> +    }
> +
> +    /* Let's fallback to use CPU to complete it. */
> +    buf = (const uint8_t *)descriptor->src_addr;
> +    len = descriptor->xfer_size;
> +    *result = buffer_is_zero(buf + completion->bytes_completed,
> +                             len - completion->bytes_completed);
> +}
> +
>  /**
>   * @brief Complete a single DSA task in the batch task.
>   *
> @@ -561,7 +597,7 @@ dsa_completion_loop(void *opaque)
>          (QemuDsaCompletionThread *)opaque;
>      QemuDsaBatchTask *batch_task;
>      QemuDsaDeviceGroup *group = thread_context->group;
> -    int ret;
> +    int ret = 0;
>  
>      rcu_register_thread();
>  
> @@ -829,7 +865,6 @@ buffer_zero_batch_task_set(QemuDsaBatchTask *batch_task,
>   *
>   * @return int Zero if successful, otherwise an appropriate error code.
>   */
> -__attribute__((unused))
>  static int
>  buffer_zero_dsa_async(QemuDsaBatchTask *task,
>                        const void *buf, size_t len)
> @@ -848,7 +883,6 @@ buffer_zero_dsa_async(QemuDsaBatchTask *task,
>   * @param count The number of buffers.
>   * @param len The buffer length.
>   */
> -__attribute__((unused))
>  static int
>  buffer_zero_dsa_batch_async(QemuDsaBatchTask *batch_task,
>                              const void **buf, size_t count, size_t len)
> @@ -879,13 +913,61 @@ buffer_zero_dsa_completion(void *context)
>   *
>   * @param batch_task A pointer to the buffer zero comparison batch task.
>   */
> -__attribute__((unused))
>  static void
>  buffer_zero_dsa_wait(QemuDsaBatchTask *batch_task)
>  {
>      qemu_sem_wait(&batch_task->sem_task_complete);
>  }
>  
> +/**
> + * @brief Use CPU to complete the zero page checking task if DSA
> + *        is not able to complete it.
> + *
> + * @param batch_task A pointer to the batch task.
> + */
> +static void
> +buffer_zero_cpu_fallback(QemuDsaBatchTask *batch_task)
> +{
> +    if (batch_task->task_type == QEMU_DSA_TASK) {
> +        if (batch_task->completions[0].status == DSA_COMP_SUCCESS) {
> +            return;
> +        }
> +        task_cpu_fallback_int(&batch_task->completions[0],
> +                              &batch_task->descriptors[0],
> +                              &batch_task->results[0]);
> +    } else if (batch_task->task_type == QEMU_DSA_BATCH_TASK) {
> +        struct dsa_completion_record *batch_completion =
> +            &batch_task->batch_completion;
> +        struct dsa_completion_record *completion;
> +        uint8_t status;
> +        bool *results = batch_task->results;
> +        uint32_t count = batch_task->batch_descriptor.desc_count;
> +
> +        /* DSA is able to complete the entire batch task. */
> +        if (batch_completion->status == DSA_COMP_SUCCESS) {
> +            assert(count == batch_completion->bytes_completed);
> +            return;
> +        }
> +
> +        /*
> +         * DSA encounters some error and is not able to complete
> +         * the entire batch task. Use CPU fallback.
> +         */
> +        for (int i = 0; i < count; i++) {
> +
> +            completion = &batch_task->completions[i];
> +            status = completion->status;
> +
> +            assert(status == DSA_COMP_SUCCESS ||
> +                status == DSA_COMP_PAGE_FAULT_NOBOF);
> +
> +            task_cpu_fallback_int(completion,
> +                                  &batch_task->descriptors[i],
> +                                  &results[i]);
> +        }
> +    }
> +}
> +
>  /**
>   * @brief Initializes a buffer zero comparison DSA task.
>   *
> @@ -962,3 +1044,38 @@ buffer_zero_batch_task_destroy(QemuDsaBatchTask *task)
>      qemu_sem_destroy(&task->sem_task_complete);
>      qemu_vfree(task);
>  }
> +
> +/**
> + * @brief Performs buffer zero comparison on a DSA batch task synchronously.
> + *
> + * @param batch_task A pointer to the batch task.
> + * @param buf An array of memory buffers.
> + * @param count The number of buffers in the array.
> + * @param len The buffer length.
> + *
> + * @return Zero if successful, otherwise non-zero.
> + */
> +int
> +buffer_is_zero_dsa_batch_sync(QemuDsaBatchTask *batch_task,
> +                              const void **buf, size_t count, size_t len)
> +{
> +    if (count <= 0 || count > batch_task->batch_size) {
> +        return -1;
> +    }
> +
> +    assert(batch_task != NULL);

batch_task is already dereferenced above.

> +    assert(len != 0);
> +    assert(buf != NULL);
> +
> +    if (count == 1) {
> +        /* DSA doesn't take batch operation with only 1 task. */
> +        buffer_zero_dsa_async(batch_task, buf[0], len);
> +    } else {
> +        buffer_zero_dsa_batch_async(batch_task, buf, count, len);
> +    }
> +
> +    buffer_zero_dsa_wait(batch_task);
> +    buffer_zero_cpu_fallback(batch_task);
> +
> +    return 0;
> +}

