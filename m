Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77042C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 03:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMfnA-0006w3-Nv; Wed, 26 Jun 2024 23:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1sMfn9-0006vr-Fy
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 23:27:23 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1sMfn3-0007Tm-Dy
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 23:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719458837; x=1750994837;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=X1OKx0j58/kYfSUFHVWqq+8wF0uGtQAzynrCRuowVTE=;
 b=d38mxuOMmV0jHalM/ZfW2jqVArsh+byr5Zx1RBb/uYkTnk7Lqd8fWXaq
 /9WAQ1EIL5deip5eSLkQIWbuRKg9ar56+AqZklwT7yJusv/7FQ8EP51ef
 WsrTtC+FawctXOwMLUqzU/mdxVGSOD+Rw/ZMF6mGZ9fybJXv9gSXGs9Qe
 +sq5tEETmBpOYR55tkKw+YDHZGC3IVK6PSodNyMxYipb1nj7u2f6dIsM4
 +JdY0pa3uPcRvtMXhL4Jof5RpndMvWqI9AFDD+Fx3jn+jjnCRHHwCb5sf
 eiwXk5de48dH6R5PJMviPIeTXFMaWki/Xz1nZs/e5AZ7kNVT6idKSewJj A==;
X-CSE-ConnectionGUID: fVKmKsRtS0iEv2YSv0pi1w==
X-CSE-MsgGUID: bxMkzb3FQpKW+3S0mh0n6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16693613"
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; d="scan'208";a="16693613"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2024 20:27:12 -0700
X-CSE-ConnectionGUID: 9EvSkudBRNSLznu7xdRPaw==
X-CSE-MsgGUID: 9BgKDmFSSt2UmmK8p/l+3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; d="scan'208";a="44132579"
Received: from leiwang7-mobl.ccr.corp.intel.com (HELO [10.238.208.69])
 ([10.238.208.69])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2024 20:27:11 -0700
Message-ID: <e60bc0c7-dc49-400e-88f1-a30c32943f25@intel.com>
Date: Thu, 27 Jun 2024 11:27:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/7] migration/multifd: Move payload storage out of
 the channel parameters
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
References: <20240620212111.29319-1-farosas@suse.de>
 <20240620212111.29319-7-farosas@suse.de>
From: "Wang, Lei" <lei4.wang@intel.com>
Content-Language: en-US
In-Reply-To: <20240620212111.29319-7-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=lei4.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 6/21/2024 5:21, Fabiano Rosas wrote:> Multifd currently has a simple
scheduling mechanism that distributes
> work to the various channels by providing the client (producer) with a
> memory slot and swapping that slot with free slot from the next idle
> channel (consumer). Or graphically:
> 
> []       <-- multifd_send_state->pages
> [][][][] <-- channels' p->pages pointers
> 
> 1) client fills the empty slot with data:
>   [a]
>   [][][][]
> 
> 2) multifd_send_pages() finds an idle channel and swaps the pointers:
>   [a]
>   [][][][]
>   ^idle
> 
>   []
>   [a][][][]
> 
> 3) client can immediately fill new slot with more data:
>   [b]
>   [a][][][]
> 
> 4) channel processes the data, the channel slot is now free to use
>    again:
>   [b]
>   [][][][]
> 
> This works just fine, except that it doesn't allow different types of
> payloads to be processed at the same time in different channels,
> i.e. the data type of multifd_send_state->pages needs to be the same
> as p->pages. For each new data type different from MultiFDPage_t that
> is to be handled, this logic needs to be duplicated by adding new
> fields to multifd_send_state and to the channels.
> 
> The core of the issue here is that we're using the channel parameters
> (MultiFDSendParams) to hold the storage space on behalf of the multifd
> client (currently ram.c). This is cumbersome because it forces us to
> change multifd_send_pages() to check the data type being handled
> before deciding which field to use.
> 
> One way to solve this is to detach the storage space from the multifd
> channel and put it somewhere else, in control of the multifd
> client. That way, multifd_send_pages() can operate on an opaque
> pointer without needing to be adapted to each new data type. Implement
> this logic with a new "slots" abstraction:
> 
> struct MultiFDSendData {
>     void *opaque;
>     size_t size;
> }
> 
> struct MultiFDSlots {
>     MultiFDSendData **free;   <-- what used to be p->pages
>     MultiFDSendData *active;  <-- what used to be multifd_send_state->pages
> };
> 
> Each multifd client now gets one set of slots to use. The slots are
> passed into multifd_send_pages() (renamed to multifd_send). The
> channels now only hold a pointer to the generic MultiFDSendData, and
> after it's processed that reference can be dropped.
> 
> Or graphically:
> 
> 1) client fills the active slot with data. Channels point to nothing
>    at this point:
>   [a]      <-- active slot
>   [][][][] <-- free slots, one per-channel
> 
>   [][][][] <-- channels' p->data pointers
> 
> 2) multifd_send() swaps the pointers inside the client slot. Channels
>    still point to nothing:
>   []
>   [a][][][]
> 
>   [][][][]
> 
> 3) multifd_send() finds an idle channel and updates its pointer:

It seems the action "finds an idle channel" is in step 2 rather than step 3,
which means the free slot is selected based on the id of the channel found, am I
understanding correctly?

>   []
>   [a][][][]
> 
>   [a][][][]
>   ^idle
> 
> 4) a second client calls multifd_send(), but with it's own slots:
>   []          [b]
>   [a][][][]   [][][][]
> 
>         [a][][][]
> 
> 5) multifd_send() does steps 2 and 3 again:
>   []          []
>   [a][][][]   [][b][][]
> 
>         [a][b][][]
>            ^idle
> 
> 6) The channels continue processing the data and lose/acquire the
> references as multifd_send() updates them. The free lists of each
> client are not affected.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/multifd.c | 119 +++++++++++++++++++++++++++++++-------------
>  migration/multifd.h |  17 +++++++
>  migration/ram.c     |   1 +
>  3 files changed, 102 insertions(+), 35 deletions(-)
> 
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 6fe339b378..f22a1c2e84 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -97,6 +97,30 @@ struct {
>      MultiFDMethods *ops;
>  } *multifd_recv_state;
>  
> +MultiFDSlots *multifd_allocate_slots(void *(*alloc_fn)(void),
> +                                     void (*reset_fn)(void *),
> +                                     void (*cleanup_fn)(void *))
> +{
> +    int thread_count = migrate_multifd_channels();
> +    MultiFDSlots *slots = g_new0(MultiFDSlots, 1);
> +
> +    slots->active = g_new0(MultiFDSendData, 1);
> +    slots->free = g_new0(MultiFDSendData *, thread_count);
> +
> +    slots->active->opaque = alloc_fn();
> +    slots->active->reset = reset_fn;
> +    slots->active->cleanup = cleanup_fn;
> +
> +    for (int i = 0; i < thread_count; i++) {
> +        slots->free[i] = g_new0(MultiFDSendData, 1);
> +        slots->free[i]->opaque = alloc_fn();
> +        slots->free[i]->reset = reset_fn;
> +        slots->free[i]->cleanup = cleanup_fn;
> +    }
> +
> +    return slots;
> +}
> +
>  static bool multifd_use_packets(void)
>  {
>      return !migrate_mapped_ram();
> @@ -313,8 +337,10 @@ void multifd_register_ops(int method, MultiFDMethods *ops)
>  }
>  
>  /* Reset a MultiFDPages_t* object for the next use */
> -static void multifd_pages_reset(MultiFDPages_t *pages)
> +static void multifd_pages_reset(void *opaque)
>  {
> +    MultiFDPages_t *pages = opaque;
> +
>      /*
>       * We don't need to touch offset[] array, because it will be
>       * overwritten later when reused.
> @@ -388,8 +414,9 @@ static int multifd_recv_initial_packet(QIOChannel *c, Error **errp)
>      return msg.id;
>  }
>  
> -static MultiFDPages_t *multifd_pages_init(uint32_t n)
> +static void *multifd_pages_init(void)
>  {
> +    uint32_t n = MULTIFD_PACKET_SIZE / qemu_target_page_size();
>      MultiFDPages_t *pages = g_new0(MultiFDPages_t, 1);
>  
>      pages->allocated = n;
> @@ -398,13 +425,24 @@ static MultiFDPages_t *multifd_pages_init(uint32_t n)
>      return pages;
>  }
>  
> -static void multifd_pages_clear(MultiFDPages_t *pages)
> +static void multifd_pages_clear(void *opaque)
>  {
> +    MultiFDPages_t *pages = opaque;
> +
>      multifd_pages_reset(pages);
>      pages->allocated = 0;
>      g_free(pages->offset);
>      pages->offset = NULL;
> -    g_free(pages);
> +}
> +
> +/* TODO: move these to multifd-ram.c */
> +MultiFDSlots *multifd_ram_send_slots;
> +
> +void multifd_ram_save_setup(void)
> +{
> +    multifd_ram_send_slots = multifd_allocate_slots(multifd_pages_init,
> +                                                    multifd_pages_reset,
> +                                                    multifd_pages_clear);
>  }
>  
>  static void multifd_ram_fill_packet(MultiFDSendParams *p)
> @@ -617,13 +655,12 @@ static void multifd_send_kick_main(MultiFDSendParams *p)
>   *
>   * Returns true if succeed, false otherwise.
>   */
> -static bool multifd_send_pages(void)
> +static bool multifd_send(MultiFDSlots *slots)
>  {
>      int i;
>      static int next_channel;
>      MultiFDSendParams *p = NULL; /* make happy gcc */
> -    MultiFDPages_t *channel_pages;
> -    MultiFDSendData *data = multifd_send_state->data;
> +    MultiFDSendData *active_slot;
>  
>      if (multifd_send_should_exit()) {
>          return false;
> @@ -659,11 +696,24 @@ static bool multifd_send_pages(void)
>       */
>      smp_mb_acquire();
>  
> -    channel_pages = p->data->opaque;
> -    assert(!channel_pages->num);
> +    assert(!slots->free[p->id]->size);
> +
> +    /*
> +     * Swap the slots. The client gets a free slot to fill up for the
> +     * next iteration and the channel gets the active slot for
> +     * processing.
> +     */
> +    active_slot = slots->active;
> +    slots->active = slots->free[p->id];
> +    p->data = active_slot;
> +
> +    /*
> +     * By the next time we arrive here, the channel will certainly
> +     * have consumed the active slot. Put it back on the free list
> +     * now.
> +     */
> +    slots->free[p->id] = active_slot;
>  
> -    multifd_send_state->data = p->data;
> -    p->data = data;
>      /*
>       * Making sure p->data is setup before marking pending_job=true. Pairs
>       * with the qatomic_load_acquire() in multifd_send_thread().
> @@ -687,6 +737,7 @@ static inline bool multifd_queue_full(MultiFDPages_t *pages)
>  static inline void multifd_enqueue(MultiFDPages_t *pages, ram_addr_t offset)
>  {
>      pages->offset[pages->num++] = offset;
> +    multifd_ram_send_slots->active->size += qemu_target_page_size();
>  }
>  
>  /* Returns true if enqueue successful, false otherwise */
> @@ -695,7 +746,7 @@ bool multifd_queue_page(RAMBlock *block, ram_addr_t offset)
>      MultiFDPages_t *pages;
>  
>  retry:
> -    pages = multifd_send_state->data->opaque;
> +    pages = multifd_ram_send_slots->active->opaque;
>  
>      /* If the queue is empty, we can already enqueue now */
>      if (multifd_queue_empty(pages)) {
> @@ -713,7 +764,7 @@ retry:
>       * After flush, always retry.
>       */
>      if (pages->block != block || multifd_queue_full(pages)) {
> -        if (!multifd_send_pages()) {
> +        if (!multifd_send(multifd_ram_send_slots)) {
>              return false;
>          }
>          goto retry;
> @@ -825,10 +876,12 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
>      qemu_sem_destroy(&p->sem_sync);
>      g_free(p->name);
>      p->name = NULL;
> -    multifd_pages_clear(p->data->opaque);
> -    p->data->opaque = NULL;
> -    g_free(p->data);
> -    p->data = NULL;
> +    if (p->data) {
> +        p->data->cleanup(p->data->opaque);
> +        p->data->opaque = NULL;
> +        /* p->data was not allocated by us, just clear the pointer */
> +        p->data = NULL;
> +    }
>      p->packet_len = 0;
>      g_free(p->packet);
>      p->packet = NULL;
> @@ -845,10 +898,6 @@ static void multifd_send_cleanup_state(void)
>      qemu_sem_destroy(&multifd_send_state->channels_ready);
>      g_free(multifd_send_state->params);
>      multifd_send_state->params = NULL;
> -    multifd_pages_clear(multifd_send_state->data->opaque);
> -    multifd_send_state->data->opaque = NULL;
> -    g_free(multifd_send_state->data);
> -    multifd_send_state->data = NULL;
>      g_free(multifd_send_state);
>      multifd_send_state = NULL;
>  }
> @@ -897,14 +946,13 @@ int multifd_send_sync_main(void)
>  {
>      int i;
>      bool flush_zero_copy;
> -    MultiFDPages_t *pages;
>  
>      if (!migrate_multifd()) {
>          return 0;
>      }
> -    pages = multifd_send_state->data->opaque;
> -    if (pages->num) {
> -        if (!multifd_send_pages()) {
> +
> +    if (multifd_ram_send_slots->active->size) {
> +        if (!multifd_send(multifd_ram_send_slots)) {
>              error_report("%s: multifd_send_pages fail", __func__);
>              return -1;
>          }
> @@ -979,13 +1027,11 @@ static void *multifd_send_thread(void *opaque)
>  
>          /*
>           * Read pending_job flag before p->data.  Pairs with the
> -         * qatomic_store_release() in multifd_send_pages().
> +         * qatomic_store_release() in multifd_send().
>           */
>          if (qatomic_load_acquire(&p->pending_job)) {
> -            MultiFDPages_t *pages = p->data->opaque;
> -
>              p->iovs_num = 0;
> -            assert(pages->num);
> +            assert(p->data->size);
>  
>              ret = multifd_send_state->ops->send_prepare(p, &local_err);
>              if (ret != 0) {
> @@ -1008,13 +1054,20 @@ static void *multifd_send_thread(void *opaque)
>              stat64_add(&mig_stats.multifd_bytes,
>                         p->next_packet_size + p->packet_len);
>  
> -            multifd_pages_reset(pages);
>              p->next_packet_size = 0;
>  
> +            /*
> +             * The data has now been sent. Since multifd_send()
> +             * already put this slot on the free list, reset the
> +             * entire slot before releasing the barrier below.
> +             */
> +            p->data->size = 0;
> +            p->data->reset(p->data->opaque);
> +
>              /*
>               * Making sure p->data is published before saying "we're
>               * free".  Pairs with the smp_mb_acquire() in
> -             * multifd_send_pages().
> +             * multifd_send().
>               */
>              qatomic_store_release(&p->pending_job, false);
>          } else {
> @@ -1208,8 +1261,6 @@ bool multifd_send_setup(void)
>      thread_count = migrate_multifd_channels();
>      multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
>      multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
> -    multifd_send_state->data = g_new0(MultiFDSendData, 1);
> -    multifd_send_state->data->opaque = multifd_pages_init(page_count);
>      qemu_sem_init(&multifd_send_state->channels_created, 0);
>      qemu_sem_init(&multifd_send_state->channels_ready, 0);
>      qatomic_set(&multifd_send_state->exiting, 0);
> @@ -1221,8 +1272,6 @@ bool multifd_send_setup(void)
>          qemu_sem_init(&p->sem, 0);
>          qemu_sem_init(&p->sem_sync, 0);
>          p->id = i;
> -        p->data = g_new0(MultiFDSendData, 1);
> -        p->data->opaque = multifd_pages_init(page_count);
>  
>          if (use_packets) {
>              p->packet_len = sizeof(MultiFDPacket_t)
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 2029bfd80a..5230729077 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -17,6 +17,10 @@
>  
>  typedef struct MultiFDRecvData MultiFDRecvData;
>  typedef struct MultiFDSendData MultiFDSendData;
> +typedef struct MultiFDSlots MultiFDSlots;
> +
> +typedef void *(multifd_data_alloc_cb)(void);
> +typedef void (multifd_data_cleanup_cb)(void *);
>  
>  bool multifd_send_setup(void);
>  void multifd_send_shutdown(void);
> @@ -93,8 +97,21 @@ struct MultiFDRecvData {
>  struct MultiFDSendData {
>      void *opaque;
>      size_t size;
> +    /* reset the slot for reuse after successful transfer */
> +    void (*reset)(void *);
> +    void (*cleanup)(void *);
>  };
>  
> +struct MultiFDSlots {
> +    MultiFDSendData **free;
> +    MultiFDSendData *active;
> +};
> +
> +MultiFDSlots *multifd_allocate_slots(void *(*alloc_fn)(void),
> +                                     void (*reset_fn)(void *),
> +                                     void (*cleanup_fn)(void *));
> +void multifd_ram_save_setup(void);
> +
>  typedef struct {
>      /* Fields are only written at creating/deletion time */
>      /* No lock required for them, they are read only */
> diff --git a/migration/ram.c b/migration/ram.c
> index ceea586b06..c33a9dcf3f 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3058,6 +3058,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
>      migration_ops = g_malloc0(sizeof(MigrationOps));
>  
>      if (migrate_multifd()) {
> +        multifd_ram_save_setup();
>          migration_ops->ram_save_target_page = ram_save_target_page_multifd;
>      } else {
>          migration_ops->ram_save_target_page = ram_save_target_page_legacy;

