Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C53C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 14:42:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU5qZ-0002tw-Vo; Wed, 17 Jul 2024 10:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sU5qY-0002sl-2b
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 10:41:34 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sU5qP-0007NO-LG
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 10:41:33 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 09B1021958;
 Wed, 17 Jul 2024 14:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721227283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ncvg+b1FG8jEJh80R0RGM5qg+xWJT6hevxK8lNIaaGI=;
 b=XzAGaco1XkcDJxPEbe0ivb/NvvwV8SbgdVQfBpZR+LTxrBv3WVitY7EI7lsSpxTny16RMw
 KDT6r+C8ClUTIiulv3ytfw+O7qXbJt/pFLcA2YJYHylrs6pqHtxdT9qGiWHEXRiQJv50o8
 W1bMSOp/cOSwwGlmOPdKLp47NLKzd9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721227283;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ncvg+b1FG8jEJh80R0RGM5qg+xWJT6hevxK8lNIaaGI=;
 b=qZHfNSeWsS1gP7xdyOj9n+hO7FtUrPETIeYNL/ASjJ6CqK3N44zVrvgGRPTQqDiyN4Kk4r
 szPIBYCwlLeNvABQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721227283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ncvg+b1FG8jEJh80R0RGM5qg+xWJT6hevxK8lNIaaGI=;
 b=XzAGaco1XkcDJxPEbe0ivb/NvvwV8SbgdVQfBpZR+LTxrBv3WVitY7EI7lsSpxTny16RMw
 KDT6r+C8ClUTIiulv3ytfw+O7qXbJt/pFLcA2YJYHylrs6pqHtxdT9qGiWHEXRiQJv50o8
 W1bMSOp/cOSwwGlmOPdKLp47NLKzd9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721227283;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ncvg+b1FG8jEJh80R0RGM5qg+xWJT6hevxK8lNIaaGI=;
 b=qZHfNSeWsS1gP7xdyOj9n+hO7FtUrPETIeYNL/ASjJ6CqK3N44zVrvgGRPTQqDiyN4Kk4r
 szPIBYCwlLeNvABQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79F531368F;
 Wed, 17 Jul 2024 14:41:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EbxEEBLYl2ZvDAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 17 Jul 2024 14:41:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Yichen Wang <yichen.wang@bytedance.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Xu
 <peterx@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 Shivam Kumar <shivam.kumar1@nutanix.com>, "Ho-Ren (Jack) Chuang"
 <horenchuang@bytedance.com>, Yichen Wang <yichen.wang@bytedance.com>
Subject: Re: [PATCH v5 10/13] migration/multifd: Enable DSA offloading in
 multifd sender path.
In-Reply-To: <20240711220451.19780-1-yichen.wang@bytedance.com>
References: <20240711220451.19780-1-yichen.wang@bytedance.com>
Date: Wed, 17 Jul 2024 11:41:19 -0300
Message-ID: <87plrc2i9c.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[17]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
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

Yichen Wang <yichen.wang@bytedance.com> writes:

> From: Hao Xiang <hao.xiang@linux.dev>
>
> Multifd sender path gets an array of pages queued by the migration
> thread. It performs zero page checking on every page in the array.
> The pages are classfied as either a zero page or a normal page. This
> change uses Intel DSA to offload the zero page checking from CPU to
> the DSA accelerator. The sender thread submits a batch of pages to DSA
> hardware and waits for the DSA completion thread to signal for work
> completion.
>
> Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
> ---
>  include/qemu/dsa.h            |   4 +-

This patch should have no changes to dsa code. Put them in the patches
that introduce them.

>  migration/migration.c         |   2 +-
>  migration/multifd-zero-page.c | 100 ++++++++++++++++++++++++++++++++--
>  migration/multifd.c           |  43 ++++++++++++++-
>  migration/multifd.h           |   2 +-
>  util/dsa.c                    |  23 ++++----

Same with these.

>  6 files changed, 150 insertions(+), 24 deletions(-)
>
> diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
> index fd0305a7c7..a3b502ee41 100644
> --- a/include/qemu/dsa.h
> +++ b/include/qemu/dsa.h
> @@ -83,7 +83,7 @@ typedef struct QemuDsaBatchTask {
>   *
>   * @return int Zero if successful, otherwise non zero.
>   */
> -int qemu_dsa_init(const char *dsa_parameter, Error **errp);
> +int qemu_dsa_init(const strList *dsa_parameter, Error **errp);
>  
>  /**
>   * @brief Start logic to enable using DSA.
> @@ -146,7 +146,7 @@ static inline bool qemu_dsa_is_running(void)
>      return false;
>  }
>  
> -static inline int qemu_dsa_init(const char *dsa_parameter, Error **errp)
> +static inline int qemu_dsa_init(const strList *dsa_parameter, Error **errp)
>  {
>      error_setg(errp, "DSA accelerator is not enabled.");
>      return -1;
> diff --git a/migration/migration.c b/migration/migration.c
> index 3dea06d577..085395b900 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3469,7 +3469,7 @@ static void *migration_thread(void *opaque)
>      object_ref(OBJECT(s));
>      update_iteration_initial_status(s);
>  
> -    if (!multifd_send_setup()) {
> +    if (!multifd_send_setup(&local_err)) {

This is interesting, probably more correct than what we're doing
today. But you need to hoist the error handling out of
multifd_send_setup into here. And put this in a separate patch because
it is an improvement on its own.

>          goto out;
>      }
>  
> diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-page.c

The way git generated this diff makes it hard to review. When this
happens, you can use a different algorithm such as --patience when
generating the patches. Compare git show vs. git show --patience to see
the difference.

> index e1b8370f88..ffb5611d44 100644
> --- a/migration/multifd-zero-page.c
> +++ b/migration/multifd-zero-page.c
> @@ -37,25 +37,84 @@ static void swap_page_offset(ram_addr_t *pages_offset, int a, int b)
>  }
>  
>  /**
> - * multifd_send_zero_page_detect: Perform zero page detection on all pages.
> + * zero_page_detect_cpu: Perform zero page detection using CPU.
>   *
>   * Sorts normal pages before zero pages in p->pages->offset and updates
>   * p->pages->normal_num.

Probably best to carry this part along as well. This is the public
function that people will most likely look at first.

>   *
>   * @param p A pointer to the send params.
>   */
> -void multifd_send_zero_page_detect(MultiFDSendParams *p)
> +static void zero_page_detect_cpu(MultiFDSendParams *p)
> {
>      MultiFDPages_t *pages = p->pages;
>      RAMBlock *rb = pages->block;
>      int i = 0;
>      int j = pages->num - 1;
>  
> -    if (!multifd_zero_page_enabled()) {
> -        pages->normal_num = pages->num;
> +    /*
> +     * Sort the page offset array by moving all normal pages to
> +     * the left and all zero pages to the right of the array.
> +     */
> +    while (i <= j) {
> +        uint64_t offset = pages->offset[i];
> +
> +        if (!buffer_is_zero(rb->host + offset, p->page_size)) {
> +            i++;
> +            continue;
> +        }
> +
> +        swap_page_offset(pages->offset, i, j);
> +        ram_release_page(rb->idstr, offset);
> +        j--;
> +    }
> +
> +    pages->normal_num = i;
> +}
> +
> +
> +#ifdef CONFIG_DSA_OPT
> +
> +static void swap_result(bool *results, int a, int b)
> +{
> +    bool temp;
> +
> +    if (a == b) {
>          return;
>      }
>  
> +    temp = results[a];
> +    results[a] = results[b];
> +    results[b] = temp;
> +}
> +
> +/**
> + * zero_page_detect_dsa: Perform zero page detection using
> + * Intel Data Streaming Accelerator (DSA).
> + *
> + * Sorts normal pages before zero pages in p->pages->offset and updates
> + * p->pages->normal_num.
> + *
> + * @param p A pointer to the send params.
> + */
> +static void zero_page_detect_dsa(MultiFDSendParams *p)
> +{
> +    MultiFDPages_t *pages = p->pages;

Actually use the pages variable all over instead of dereferencing
p->pages again.

> +    RAMBlock *rb = pages->block;
> +    bool *results = p->dsa_batch_task->results;

I think we had a suggestion from Peter to not carry the batch task in
the channel parameters, no?

> +
> +    for (int i = 0; i < p->pages->num; i++) {
> +        p->dsa_batch_task->addr[i] =
> +            (ram_addr_t)(rb->host + p->pages->offset[i]);
> +    }
> +
> +    buffer_is_zero_dsa_batch_sync(p->dsa_batch_task,
> +                                  (const void **)p->dsa_batch_task->addr,
> +                                  p->pages->num,
> +                                  p->page_size);
> +
> +    int i = 0;
> +    int j = pages->num - 1;
> +
>      /*
>       * Sort the page offset array by moving all normal pages to
>       * the left and all zero pages to the right of the array.
> @@ -63,11 +122,12 @@ void multifd_send_zero_page_detect(MultiFDSendParams *p)
>      while (i <= j) {
>          uint64_t offset = pages->offset[i];
>  
> -        if (!buffer_is_zero(rb->host + offset, p->page_size)) {
> +        if (!results[i]) {
>              i++;
>              continue;
>          }
>  
> +        swap_result(results, i, j);
>          swap_page_offset(pages->offset, i, j);
>          ram_release_page(rb->idstr, offset);
>          j--;
> @@ -76,6 +136,15 @@ void multifd_send_zero_page_detect(MultiFDSendParams *p)
>      pages->normal_num = i;
>  }
>  
> +#else
> +
> +static void zero_page_detect_dsa(MultiFDSendParams *p)
> +{
> +    exit(1);

g_assert_not_reached();

> +}
> +
> +#endif
> +
>  void multifd_recv_zero_page_process(MultiFDRecvParams *p)
>  {
>      for (int i = 0; i < p->zero_num; i++) {
> @@ -87,3 +156,24 @@ void multifd_recv_zero_page_process(MultiFDRecvParams *p)
>          }
>      }
>  }
> +
> +/**
> + * multifd_send_zero_page_detect: Perform zero page detection on all pages.
> + *
> + * @param p A pointer to the send params.
> + */
> +void multifd_send_zero_page_detect(MultiFDSendParams *p)
> +{
> +    MultiFDPages_t *pages = p->pages;
> +
> +    if (!multifd_zero_page_enabled()) {
> +        pages->normal_num = pages->num;
> +        return;
> +    }
> +
> +    if (qemu_dsa_is_running()) {
> +        zero_page_detect_dsa(p);
> +    } else {
> +        zero_page_detect_cpu(p);
> +    }
> +}
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 6f8edd4b6a..014fee757a 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -817,6 +817,32 @@ static void multifd_send_cleanup_state(void)
>      multifd_send_state = NULL;
>  }
>  
> +static bool multifd_dsa_setup(MigrationState *s, const char *role, Error **errp)

You don't need MigrationState here. You can call the function only from
multifd_send_setup() and use migrate_zero_page_detection() to check for
DSA.

> +{
> +    /*
> +     * Only setup DSA when needed. Currently, DSA is only used for zero page
> +     * detection, which is only needed on sender side.
> +     */
> +    if (!s ||
> +        s->parameters.zero_page_detection != ZERO_PAGE_DETECTION_DSA_ACCEL) {
> +        return true;
> +    }
> +
> +    const strList *dsa_parameter = migrate_dsa_accel_path();
> +    if (qemu_dsa_init(dsa_parameter, errp)) {
> +        error_setg(errp, "multifd: %s failed to initialize DSA.", role);
> +        return false;
> +    }
> +    qemu_dsa_start();
> +
> +    return true;
> +}
> +
> +static void multifd_dsa_cleanup(void)
> +{
> +    qemu_dsa_cleanup();
> +}

Hmm, these two functions seem to fit better in multifd-zero-page.c.

> +
>  void multifd_send_shutdown(void)
>  {
>      int i;
> @@ -827,6 +853,8 @@ void multifd_send_shutdown(void)
>  
>      multifd_send_terminate_threads();
>  
> +    multifd_dsa_cleanup();
> +
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
>          Error *local_err = NULL;
> @@ -1156,7 +1184,7 @@ static bool multifd_new_send_channel_create(gpointer opaque, Error **errp)
>      return true;
>  }
>  
> -bool multifd_send_setup(void)
> +bool multifd_send_setup(Error **errp)
>  {
>      MigrationState *s = migrate_get_current();
>      Error *local_err = NULL;

Remove this and use errp instead everywhere.

> @@ -1169,6 +1197,10 @@ bool multifd_send_setup(void)
>          return true;
>      }
>  
> +    if (!multifd_dsa_setup(s, "Sender", errp)) {
> +        return false;
> +    }
> +
>      thread_count = migrate_multifd_channels();
>      multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
>      multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
> @@ -1395,6 +1427,7 @@ void multifd_recv_cleanup(void)
>              qemu_thread_join(&p->thread);
>          }
>      }
> +    multifd_dsa_cleanup();
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          multifd_recv_cleanup_channel(&multifd_recv_state->params[i]);
>      }
> @@ -1570,6 +1603,7 @@ int multifd_recv_setup(Error **errp)
>      uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
>      bool use_packets = multifd_use_packets();
>      uint8_t i;
> +    int ret;
>  
>      /*
>       * Return successfully if multiFD recv state is already initialised
> @@ -1579,6 +1613,10 @@ int multifd_recv_setup(Error **errp)
>          return 0;
>      }
>  
> +    if (!multifd_dsa_setup(NULL, "Receiver", errp)) {
> +        return -1;
> +    }

Is there a reason to call this here?

> +
>      thread_count = migrate_multifd_channels();
>      multifd_recv_state = g_malloc0(sizeof(*multifd_recv_state));
>      multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
> @@ -1617,13 +1655,12 @@ int multifd_recv_setup(Error **errp)
>  
>      for (i = 0; i < thread_count; i++) {
>          MultiFDRecvParams *p = &multifd_recv_state->params[i];
> -        int ret;
> -

This is a separate cleanup patch.

>          ret = multifd_recv_state->ops->recv_setup(p, errp);
>          if (ret) {
>              return ret;
>          }
>      }
> +

Avoid introducing extra lines for no reason, this leads to git conflicts
sometimes.

>      return 0;
>  }
>  
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 027f57bf4e..871e3aa063 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -18,7 +18,7 @@
>  
>  typedef struct MultiFDRecvData MultiFDRecvData;
>  
> -bool multifd_send_setup(void);
> +bool multifd_send_setup(Error **errp);
>  void multifd_send_shutdown(void);
>  void multifd_send_channel_created(void);
>  int multifd_recv_setup(Error **errp);
> diff --git a/util/dsa.c b/util/dsa.c
> index 5aba1ae23a..44b1130a51 100644
> --- a/util/dsa.c
> +++ b/util/dsa.c
> @@ -116,27 +116,27 @@ dsa_device_cleanup(QemuDsaDevice *instance)
>   */
>  static int
>  dsa_device_group_init(QemuDsaDeviceGroup *group,
> -                      const char *dsa_parameter,
> +                      const strList *dsa_parameter,
>                        Error **errp)
>  {
> -    if (dsa_parameter == NULL || strlen(dsa_parameter) == 0) {
> -        return 0;
> +    if (dsa_parameter == NULL) {
> +        /* HACKING ALERT. */
> +        /* return 0; */
> +        dsa_parameter = &(strList) {
> +            .value = (char *)"/dev/dsa/wq0.0", .next = NULL
> +        };
>      }
>  
>      int ret = 0;
> -    char *local_dsa_parameter = g_strdup(dsa_parameter);
>      const char *dsa_path[MAX_DSA_DEVICES];
>      int num_dsa_devices = 0;
> -    char delim[2] = " ";
>  
> -    char *current_dsa_path = strtok(local_dsa_parameter, delim);
> -
> -    while (current_dsa_path != NULL) {
> -        dsa_path[num_dsa_devices++] = current_dsa_path;
> +    while (dsa_parameter) {
> +        dsa_path[num_dsa_devices++] = dsa_parameter->value;
>          if (num_dsa_devices == MAX_DSA_DEVICES) {
>              break;
>          }
> -        current_dsa_path = strtok(NULL, delim);
> +        dsa_parameter = dsa_parameter->next;
>      }
>  
>      group->dsa_devices =
> @@ -161,7 +161,6 @@ dsa_device_group_init(QemuDsaDeviceGroup *group,
>      }
>  
>  exit:
> -    g_free(local_dsa_parameter);
>      return ret;
>  }
>  
> @@ -718,7 +717,7 @@ dsa_globals_init(void)
>   *
>   * @return int Zero if successful, otherwise non zero.
>   */
> -int qemu_dsa_init(const char *dsa_parameter, Error **errp)
> +int qemu_dsa_init(const strList *dsa_parameter, Error **errp)
>  {
>      dsa_globals_init();

