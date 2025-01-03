Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83496E77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 21:00:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTolX-0005cL-C5; Fri, 03 Jan 2025 15:59:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tTolW-0005c6-5L
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 15:59:30 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tTolT-0002sW-PW
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 15:59:29 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 191191F37C;
 Fri,  3 Jan 2025 20:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1735937966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sRv5LoYFJDyfd2HQjpjK6F6hgndou+JnGPz4rwaAelM=;
 b=GWtgpLqaOpTYKSwtBVlsE6m5c63dFPDGPiz/10Rarqqpi5B8xxlgwcQtQoy5hqX5qnyVhs
 akbLWlvoJK7rzxT4AjMxkg9jZBRiv3O2NJUasbD0mG48ZjzoRzIN+m9jVn7dgakTQ9ukIS
 /bCEKiDOk07LGIeyiu33jssnPPiYmQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1735937966;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sRv5LoYFJDyfd2HQjpjK6F6hgndou+JnGPz4rwaAelM=;
 b=jWkFQvFs+612hswn4gsb2UzKysiTaHcj1bhXMQXlgljPIYfA48UxOHFy3HmDoy4MbkbEAg
 8vZYrp68iv5eYmAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1735937965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sRv5LoYFJDyfd2HQjpjK6F6hgndou+JnGPz4rwaAelM=;
 b=D1CZATSzUX0oGVT3JGgrJbfiEWGsPhcfBbVsvUC7RZdkt2iBc27Ss3OVSIVBsoXZM3U6Re
 SKTyW8q0xYySdFiq7IMBW99ISuSk1A9ZwuE/XpIAFG6zde82Z1CKERB4NvOYNIQaa7KiEa
 sR602gM+lOVo9ZO5ICdohsWIc6qRv64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1735937965;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sRv5LoYFJDyfd2HQjpjK6F6hgndou+JnGPz4rwaAelM=;
 b=EBDsPeXhq9mtBCDyOIDNrBgmJQEV3NsnARubGaMOr5lqV996hLUt+M+IpTZPAupXMPqBne
 Ooh7Q2P06Emt2RAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89DF313418;
 Fri,  3 Jan 2025 20:59:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id K1jPE6xPeGfuOwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 03 Jan 2025 20:59:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Yichen Wang <yichen.wang@bytedance.com>, Peter Xu <peterx@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 Shivam Kumar <shivam.kumar1@nutanix.com>, "Ho-Ren (Jack) Chuang"
 <horenchuang@bytedance.com>, Yichen Wang <yichen.wang@bytedance.com>
Subject: Re: [PATCH v9 09/12] migration/multifd: Enable DSA offloading in
 multifd sender path.
In-Reply-To: <20241225005919.26853-10-yichen.wang@bytedance.com>
References: <20241225005919.26853-1-yichen.wang@bytedance.com>
 <20241225005919.26853-10-yichen.wang@bytedance.com>
Date: Fri, 03 Jan 2025 17:59:21 -0300
Message-ID: <87y0zr7gwm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[18]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 bytedance.com:email, suse.de:mid, linux.dev:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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
>  migration/multifd-zero-page.c | 149 ++++++++++++++++++++++++++++++----
>  migration/multifd.c           |  23 +++++-
>  migration/multifd.h           |   6 ++
>  migration/options.c           |  13 +++
>  migration/options.h           |   1 +
>  5 files changed, 176 insertions(+), 16 deletions(-)
>
> diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-page.c
> index f1e988a959..0a4e3fb9bd 100644
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
> @@ -64,23 +89,59 @@ void multifd_send_zero_page_detect(MultiFDSendParams *p)
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
> +int multifd_dsa_setup(MigrationState *s, Error *local_err)
> +{
> +    g_autofree strList *dsa_parameter = g_malloc0(sizeof(strList));
> +    migrate_dsa_accel_path(&dsa_parameter);
> +    if (qemu_dsa_init(dsa_parameter, &local_err)) {
> +        migrate_set_error(s, local_err);
> +        return -1;
> +    } else {
> +        qemu_dsa_start();
> +    }
> +
> +    return 0;
> +}
> +
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
>  }
>  
> +int multifd_dsa_setup(MigrationState *s, Error *local_err)
> +{
> +    g_assert_not_reached();
> +    return -1;
> +}
> +
> +void multifd_dsa_cleanup(void)
> +{
> +    return ;
> +}
> +
> +#endif
> +
>  void multifd_recv_zero_page_process(MultiFDRecvParams *p)
>  {
>      for (int i = 0; i < p->zero_num; i++) {
> @@ -92,3 +153,63 @@ void multifd_recv_zero_page_process(MultiFDRecvParams *p)
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
> index 4f973d70e0..50cdbd21d0 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -13,6 +13,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/cutils.h"
>  #include "qemu/rcu.h"
> +#include "qemu/dsa.h"
>  #include "exec/target_page.h"
>  #include "system/system.h"
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
> @@ -814,6 +819,7 @@ bool multifd_send_setup(void)
>      uint32_t page_count = multifd_ram_page_count();
>      bool use_packets = multifd_use_packets();
>      uint8_t i;
> +    Error *local_err = NULL;
>  
>      if (!migrate_multifd()) {
>          return true;
> @@ -827,9 +833,12 @@ bool multifd_send_setup(void)
>      qatomic_set(&multifd_send_state->exiting, 0);
>      multifd_send_state->ops = multifd_ops[migrate_multifd_compression()];
>  
> +    if (ret) {
> +        goto err;
> +    }

This looks like an artifact of rebase.

> +
>      for (i = 0; i < thread_count; i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
> -        Error *local_err = NULL;
>  
>          qemu_sem_init(&p->sem, 0);
>          qemu_sem_init(&p->sem_sync, 0);
> @@ -863,10 +872,19 @@ bool multifd_send_setup(void)
>          goto err;
>      }

This one as well.

>  
> +    if (s && ret == 0 &&

if (!ret && ...

The migration state pointer will always be live here.

> +        s->parameters.zero_page_detection == ZERO_PAGE_DETECTION_DSA_ACCEL) {
> +        ret = multifd_dsa_setup(s, local_err);
> +    }
> +
> +    if (ret) {
> +        goto err;
> +    }
> +
>      for (i = 0; i < thread_count; i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
> -        Error *local_err = NULL;
>  
> +        p->dsa_batch_task = buffer_zero_batch_task_init(page_count);

We should do something about the case where CONFIG_DSA_OPT=y, but DSA is
nonetheless not enabled. We don't want to go into this function and
allocate a bunch of memory, etc.

Can you check inside buffer_zero_batch_task_init() whether dsa_setup
happened and return early if not?

Alternatively, I'd just repeat the for loop inside the conditional above,
like this:

for (i = 0; i < thread_count; i++) {
    qemu_sem_wait(&multifd_send_state->channels_created);
}

if (ret) {
    goto err;
}

+if (s->parameters.zero_page_detection == ZERO_PAGE_DETECTION_DSA_ACCEL) {
+    ret = multifd_dsa_setup(s, local_err);
+    if (ret) {
+        goto err;
+    }
+
+    for (i = 0; i < thread_count; i++) {
+        MultiFDSendParams *p = &multifd_send_state->params[i];
+        p->dsa_batch_task = buffer_zero_batch_task_init(page_count);
+    }
+}

>          ret = multifd_send_state->ops->send_setup(p, &local_err);
>          if (ret) {
>              migrate_set_error(s, local_err);
> @@ -1047,6 +1065,7 @@ void multifd_recv_cleanup(void)
>              qemu_thread_join(&p->thread);
>          }
>      }
> +    multifd_dsa_cleanup();
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          multifd_recv_cleanup_channel(&multifd_recv_state->params[i]);
>      }
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 50d58c0c9c..da53b0bdfd 100644
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
> @@ -313,6 +317,8 @@ void multifd_send_fill_packet(MultiFDSendParams *p);
>  bool multifd_send_prepare_common(MultiFDSendParams *p);
>  void multifd_send_zero_page_detect(MultiFDSendParams *p);
>  void multifd_recv_zero_page_process(MultiFDRecvParams *p);
> +int multifd_dsa_setup(MigrationState *s, Error *local_err);
> +void multifd_dsa_cleanup(void);
>  
>  static inline void multifd_send_prepare_header(MultiFDSendParams *p)
>  {
> diff --git a/migration/options.c b/migration/options.c
> index 68547b358b..9011e7f6c3 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -817,6 +817,19 @@ const strList *migrate_accel_path(void)
>      return s->parameters.accel_path;
>  }
>  
> +void migrate_dsa_accel_path(strList **dsa_accel_path)
> +{
> +    MigrationState *s = migrate_get_current();
> +    strList *accel_path = s->parameters.accel_path;
> +    strList **tail = dsa_accel_path;
> +    while (accel_path) {
> +        if (strncmp(accel_path->value, "dsa:", 4) == 0) {
> +            QAPI_LIST_APPEND(tail, &accel_path->value[4]);
> +        }
> +        accel_path = accel_path->next;
> +    }
> +}
> +
>  const char *migrate_tls_hostname(void)
>  {
>      MigrationState *s = migrate_get_current();
> diff --git a/migration/options.h b/migration/options.h
> index c994b04cb6..586d091733 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -86,6 +86,7 @@ const char *migrate_tls_hostname(void);
>  uint64_t migrate_xbzrle_cache_size(void);
>  ZeroPageDetection migrate_zero_page_detection(void);
>  const strList *migrate_accel_path(void);
> +void migrate_dsa_accel_path(strList **dsa_accel_path);
>  
>  /* parameters helpers */

