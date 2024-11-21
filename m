Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B83FE64014
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 20:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEEAW-0000Sh-N3; Thu, 21 Nov 2024 15:52:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tEEAM-0000S1-5M
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 15:52:45 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tEEAJ-0001yh-OQ
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 15:52:41 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9C34821A01;
 Thu, 21 Nov 2024 20:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732222355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DysGWJ2wJw9fD5zGranZ0R4SFngAEuunwmfRExzHNdY=;
 b=jnmLZ37vXG9stA6597P6wUfjoAlt2uROVyZFvc1ULF+k5c/8JWT7ljmoMIBBxwpGlowNm/
 hNx2ls5eaztzYbxxvej9D111/TR/OoAU+k52I46f1E37K6gUJIdi8xr+8ndtdifrpTmMSi
 0NySK144vEH7TCApa/Lj6aaN/piLyvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732222355;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DysGWJ2wJw9fD5zGranZ0R4SFngAEuunwmfRExzHNdY=;
 b=NbNI/Wzt9odf5uIxRWI0PspQqHHfUqBXfqf6ybBoajo5srf4N7Y4KQFE5MzA6Jobu1IxuB
 5h6aQmez10MdWADQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jnmLZ37v;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="NbNI/Wzt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732222355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DysGWJ2wJw9fD5zGranZ0R4SFngAEuunwmfRExzHNdY=;
 b=jnmLZ37vXG9stA6597P6wUfjoAlt2uROVyZFvc1ULF+k5c/8JWT7ljmoMIBBxwpGlowNm/
 hNx2ls5eaztzYbxxvej9D111/TR/OoAU+k52I46f1E37K6gUJIdi8xr+8ndtdifrpTmMSi
 0NySK144vEH7TCApa/Lj6aaN/piLyvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732222355;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DysGWJ2wJw9fD5zGranZ0R4SFngAEuunwmfRExzHNdY=;
 b=NbNI/Wzt9odf5uIxRWI0PspQqHHfUqBXfqf6ybBoajo5srf4N7Y4KQFE5MzA6Jobu1IxuB
 5h6aQmez10MdWADQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 108541368B;
 Thu, 21 Nov 2024 20:52:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hZPjL5KdP2cqKQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 21 Nov 2024 20:52:34 +0000
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
Subject: Re: [PATCH v7 09/12] migration/multifd: Enable DSA offloading in
 multifd sender path.
In-Reply-To: <20241114220132.27399-10-yichen.wang@bytedance.com>
References: <20241114220132.27399-1-yichen.wang@bytedance.com>
 <20241114220132.27399-10-yichen.wang@bytedance.com>
Date: Thu, 21 Nov 2024 17:50:21 -0300
Message-ID: <87iksgpb02.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 9C34821A01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWELVE(0.00)[17];
 MISSING_XM_UA(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
>  migration/multifd-zero-page.c | 129 ++++++++++++++++++++++++++++++----
>  migration/multifd.c           |  29 +++++++-
>  migration/multifd.h           |   5 ++
>  3 files changed, 147 insertions(+), 16 deletions(-)
>
> diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-page.c
> index f1e988a959..639aed9f6b 100644
> --- a/migration/multifd-zero-page.c
> +++ b/migration/multifd-zero-page.c
> @@ -21,7 +21,9 @@
>  
>  static bool multifd_zero_page_enabled(void)
>  {
> -    return migrate_zero_page_detection() == ZERO_PAGE_DETECTION_MULTIFD;
> +    ZeroPageDetection curMethod = migrate_zero_page_detection();
> +    return (curMethod == ZERO_PAGE_DETECTION_MULTIFD ||
> +            curMethod == ZERO_PAGE_DETECTION_DSA_ACCEL);
>  }
>  
>  static void swap_page_offset(ram_addr_t *pages_offset, int a, int b)
> @@ -37,26 +39,49 @@ static void swap_page_offset(ram_addr_t *pages_offset, int a, int b)
>      pages_offset[b] = temp;
>  }
>  
> +#ifdef CONFIG_DSA_OPT
> +
> +static void swap_result(bool *results, int a, int b)
> +{
> +    bool temp;
> +
> +    if (a == b) {
> +        return;
> +    }
> +
> +    temp = results[a];
> +    results[a] = results[b];
> +    results[b] = temp;
> +}
> +
>  /**
> - * multifd_send_zero_page_detect: Perform zero page detection on all pages.
> + * zero_page_detect_dsa: Perform zero page detection using
> + * Intel Data Streaming Accelerator (DSA).
>   *
> - * Sorts normal pages before zero pages in p->pages->offset and updates
> - * p->pages->normal_num.
> + * Sorts normal pages before zero pages in pages->offset and updates
> + * pages->normal_num.
>   *
>   * @param p A pointer to the send params.
>   */
> -void multifd_send_zero_page_detect(MultiFDSendParams *p)
> +static void zero_page_detect_dsa(MultiFDSendParams *p)
>  {
>      MultiFDPages_t *pages = &p->data->u.ram;
>      RAMBlock *rb = pages->block;
> -    int i = 0;
> -    int j = pages->num - 1;
> +    bool *results = p->dsa_batch_task->results;
>  
> -    if (!multifd_zero_page_enabled()) {
> -        pages->normal_num = pages->num;
> -        goto out;
> +    for (int i = 0; i < pages->num; i++) {
> +        p->dsa_batch_task->addr[i] =
> +            (ram_addr_t)(rb->host + pages->offset[i]);
>      }
>  
> +    buffer_is_zero_dsa_batch_sync(p->dsa_batch_task,
> +                                  (const void **)p->dsa_batch_task->addr,
> +                                  pages->num,
> +                                  multifd_ram_page_size());
> +
> +    int i = 0;
> +    int j = pages->num - 1;
> +
>      /*
>       * Sort the page offset array by moving all normal pages to
>       * the left and all zero pages to the right of the array.
> @@ -64,23 +89,39 @@ void multifd_send_zero_page_detect(MultiFDSendParams *p)
>      while (i <= j) {
>          uint64_t offset = pages->offset[i];
>  
> -        if (!buffer_is_zero(rb->host + offset, multifd_ram_page_size())) {
> +        if (!results[i]) {
>              i++;
>              continue;
>          }
>  
> +        swap_result(results, i, j);
>          swap_page_offset(pages->offset, i, j);
>          ram_release_page(rb->idstr, offset);
>          j--;
>      }
>  
>      pages->normal_num = i;
> +}
>  
> -out:
> -    stat64_add(&mig_stats.normal_pages, pages->normal_num);
> -    stat64_add(&mig_stats.zero_pages, pages->num - pages->normal_num);
> +void multifd_dsa_cleanup(void)
> +{
> +    qemu_dsa_cleanup();
> +}
> +
> +#else
> +
> +static void zero_page_detect_dsa(MultiFDSendParams *p)
> +{
> +    g_assert_not_reached();
> +}
> +
> +void multifd_dsa_cleanup(void)
> +{
> +    return ;
>  }
>  
> +#endif
> +
>  void multifd_recv_zero_page_process(MultiFDRecvParams *p)
>  {
>      for (int i = 0; i < p->zero_num; i++) {
> @@ -92,3 +133,63 @@ void multifd_recv_zero_page_process(MultiFDRecvParams *p)
>          }
>      }
>  }
> +
> +/**
> + * zero_page_detect_cpu: Perform zero page detection using CPU.
> + *
> + * Sorts normal pages before zero pages in p->pages->offset and updates
> + * p->pages->normal_num.
> + *
> + * @param p A pointer to the send params.
> + */
> +static void zero_page_detect_cpu(MultiFDSendParams *p)
> +{
> +    MultiFDPages_t *pages = &p->data->u.ram;
> +    RAMBlock *rb = pages->block;
> +    int i = 0;
> +    int j = pages->num - 1;
> +
> +    /*
> +     * Sort the page offset array by moving all normal pages to
> +     * the left and all zero pages to the right of the array.
> +     */
> +    while (i <= j) {
> +        uint64_t offset = pages->offset[i];
> +
> +        if (!buffer_is_zero(rb->host + offset, multifd_ram_page_size())) {
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
> +/**
> + * multifd_send_zero_page_detect: Perform zero page detection on all pages.
> + *
> + * @param p A pointer to the send params.
> + */
> +void multifd_send_zero_page_detect(MultiFDSendParams *p)
> +{
> +    MultiFDPages_t *pages = &p->data->u.ram;
> +
> +    if (!multifd_zero_page_enabled()) {
> +        pages->normal_num = pages->num;
> +        goto out;
> +    }
> +
> +    if (qemu_dsa_is_running()) {
> +        zero_page_detect_dsa(p);
> +    } else {
> +        zero_page_detect_cpu(p);
> +    }
> +
> +out:
> +    stat64_add(&mig_stats.normal_pages, pages->normal_num);
> +    stat64_add(&mig_stats.zero_pages, pages->num - pages->normal_num);
> +}
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 4374e14a96..689acceff2 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -13,6 +13,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/cutils.h"
>  #include "qemu/rcu.h"
> +#include "qemu/dsa.h"
>  #include "exec/target_page.h"
>  #include "sysemu/sysemu.h"
>  #include "exec/ramblock.h"
> @@ -462,6 +463,8 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
>      p->name = NULL;
>      g_free(p->data);
>      p->data = NULL;
> +    buffer_zero_batch_task_destroy(p->dsa_batch_task);
> +    p->dsa_batch_task = NULL;
>      p->packet_len = 0;
>      g_free(p->packet);
>      p->packet = NULL;
> @@ -493,6 +496,8 @@ void multifd_send_shutdown(void)
>  
>      multifd_send_terminate_threads();
>  
> +    multifd_dsa_cleanup();
> +
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
>          Error *local_err = NULL;
> @@ -814,11 +819,31 @@ bool multifd_send_setup(void)
>      uint32_t page_count = multifd_ram_page_count();
>      bool use_packets = multifd_use_packets();
>      uint8_t i;
> +    Error *local_err = NULL;
>  
>      if (!migrate_multifd()) {
>          return true;
>      }
>  
> +    if (s &&
> +        s->parameters.zero_page_detection == ZERO_PAGE_DETECTION_DSA_ACCEL) {
> +        // Populate the dsa device path from accel-path

scripts/checkpatch.pl would have rejected this.

> +        const strList *accel_path = migrate_accel_path();
> +        g_autofree strList *dsa_parameter = g_malloc0(sizeof(strList));
> +        strList **tail = &dsa_parameter;
> +        while (accel_path) {
> +            if (strncmp(accel_path->value, "dsa:", 4) == 0) {
> +                QAPI_LIST_APPEND(tail, &accel_path->value[4]);
> +            }
> +            accel_path = accel_path->next;
> +        }

The parsing of the parameter should be in options.c. In fact, Peter
suggested in v4 to make all of this a multifd_dsa_send_setup() or
multifd_dsa_init(), I think that's a good idea.

> +        if (qemu_dsa_init(dsa_parameter, &local_err)) {
> +            ret = -1;

migrate_set_error(s, local_err);
goto err;

> +        } else {
> +            qemu_dsa_start();
> +        }
> +    }
> +
>      thread_count = migrate_multifd_channels();
>      multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
>      multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
> @@ -829,12 +854,12 @@ bool multifd_send_setup(void)
>  
>      for (i = 0; i < thread_count; i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
> -        Error *local_err = NULL;
>  
>          qemu_sem_init(&p->sem, 0);
>          qemu_sem_init(&p->sem_sync, 0);
>          p->id = i;
>          p->data = multifd_send_data_alloc();
> +        p->dsa_batch_task = buffer_zero_batch_task_init(page_count);
>  
>          if (use_packets) {
>              p->packet_len = sizeof(MultiFDPacket_t)
> @@ -865,7 +890,6 @@ bool multifd_send_setup(void)
>  
>      for (i = 0; i < thread_count; i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
> -        Error *local_err = NULL;
>  
>          ret = multifd_send_state->ops->send_setup(p, &local_err);
>          if (ret) {
> @@ -1047,6 +1071,7 @@ void multifd_recv_cleanup(void)
>              qemu_thread_join(&p->thread);
>          }
>      }
> +    multifd_dsa_cleanup();
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          multifd_recv_cleanup_channel(&multifd_recv_state->params[i]);
>      }
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 50d58c0c9c..e293ddbc1d 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -15,6 +15,7 @@
>  
>  #include "exec/target_page.h"
>  #include "ram.h"
> +#include "qemu/dsa.h"
>  
>  typedef struct MultiFDRecvData MultiFDRecvData;
>  typedef struct MultiFDSendData MultiFDSendData;
> @@ -155,6 +156,9 @@ typedef struct {
>      bool pending_sync;
>      MultiFDSendData *data;
>  
> +    /* Zero page checking batch task */
> +    QemuDsaBatchTask *dsa_batch_task;
> +
>      /* thread local variables. No locking required */
>  
>      /* pointer to the packet */
> @@ -313,6 +317,7 @@ void multifd_send_fill_packet(MultiFDSendParams *p);
>  bool multifd_send_prepare_common(MultiFDSendParams *p);
>  void multifd_send_zero_page_detect(MultiFDSendParams *p);
>  void multifd_recv_zero_page_process(MultiFDRecvParams *p);
> +void multifd_dsa_cleanup(void);
>  
>  static inline void multifd_send_prepare_header(MultiFDSendParams *p)
>  {

