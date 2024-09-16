Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33836C3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 17:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqFp0-0007KP-AP; Mon, 16 Sep 2024 13:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sqFoy-0007Cn-9u; Mon, 16 Sep 2024 13:47:32 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sqFou-0004Xb-9b; Mon, 16 Sep 2024 13:47:31 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 01C6D21AC8;
 Mon, 16 Sep 2024 17:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726508839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5D0CUFG3hh01SH1+0vXevSsTs9eVYvgJoq6tfJbJqt8=;
 b=XuB98Li6kCEDK2BiVIXRrBAuB+YBTML3jelwLjwJ0vSXF7D8x9jMybDAL+uo0W4mkmEQ6U
 tUYdn7tImunbIXRXiAYW0dEeQspblGtZv2fWYNCSKS5/dyRZ4vP5tRTFM/ZQ4dDObT/dyX
 09R5Cl0i2d2AdGbk5Dm1hMTDxr4Ltbg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726508839;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5D0CUFG3hh01SH1+0vXevSsTs9eVYvgJoq6tfJbJqt8=;
 b=ZJvBjZaQWiiz6sfAHkQrB4HCyAIY1ECaDazflZutqn/LCaBvrADDc/3Gtz9AzWTV5n+ICo
 /AZ+wU10ITylViAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nwPit8Ay;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0Gd8qg5U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726508838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5D0CUFG3hh01SH1+0vXevSsTs9eVYvgJoq6tfJbJqt8=;
 b=nwPit8AySFQfqNYih+QL0CEXiiyQ1sIxtTPGNK9F9lShnQy0jPL+FdVkvulgrOJpMnncN5
 oY9JiSsIO6P1rkhicw1whKTBL8ZeQ4afZqsUabfU4iTK5gwQ2oL2H79w9lyQsAMj+KZkIU
 P7iU/mIC49tEqUY49gOVvGFJK9OGkSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726508838;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5D0CUFG3hh01SH1+0vXevSsTs9eVYvgJoq6tfJbJqt8=;
 b=0Gd8qg5U1uDCQqXwWh81XnUk9ga6cSgxpHmE559W/3T3UahhPDWgfpQNf/TyzWLrtMwZ6+
 OkPqF7oinAdZBPDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7249C1397F;
 Mon, 16 Sep 2024 17:47:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Xja0DiVv6GaxbwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 16 Sep 2024 17:47:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, David Hildenbrand
 <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>, Juraj Marcin
 <jmarcin@redhat.com>, Julia Suvorova <jusual@redhat.com>, qemu-stable
 <qemu-stable@nongnu.org>, Zhiyi Guo <zhguo@redhat.com>
Subject: Re: [PATCH v3 1/4] KVM: Dynamic sized kvm memslots array
In-Reply-To: <20240909145413.3748429-2-peterx@redhat.com>
References: <20240909145413.3748429-1-peterx@redhat.com>
 <20240909145413.3748429-2-peterx@redhat.com>
Date: Mon, 16 Sep 2024 14:47:14 -0300
Message-ID: <871q1j1of1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 01C6D21AC8
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[11]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[nongnu.org:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> Zhiyi reported an infinite loop issue in VFIO use case.  The cause of that
> was a separate discussion, however during that I found a regression of
> dirty sync slowness when profiling.
>
> Each KVMMemoryListerner maintains an array of kvm memslots.  Currently it's
> statically allocated to be the max supported by the kernel.  However after
> Linux commit 4fc096a99e ("KVM: Raise the maximum number of user memslots"),
> the max supported memslots reported now grows to some number large enough
> so that it may not be wise to always statically allocate with the max
> reported.
>
> What's worse, QEMU kvm code still walks all the allocated memslots entries
> to do any form of lookups.  It can drastically slow down all memslot
> operations because each of such loop can run over 32K times on the new
> kernels.
>
> Fix this issue by making the memslots to be allocated dynamically.
>
> Here the initial size was set to 16 because it should cover the basic VM
> usages, so that the hope is the majority VM use case may not even need to
> grow at all (e.g. if one starts a VM with ./qemu-system-x86_64 by default
> it'll consume 9 memslots), however not too large to waste memory.
>
> There can also be even better way to address this, but so far this is the
> simplest and should be already better even than before we grow the max
> supported memslots.  For example, in the case of above issue when VFIO was
> attached on a 32GB system, there are only ~10 memslots used.  So it could
> be good enough as of now.
>
> In the above VFIO context, measurement shows that the precopy dirty sync
> shrinked from ~86ms to ~3ms after this patch applied.  It should also apply
> to any KVM enabled VM even without VFIO.
>
> NOTE: we don't have a FIXES tag for this patch because there's no real
> commit that regressed this in QEMU. Such behavior existed for a long time,
> but only start to be a problem when the kernel reports very large
> nr_slots_max value.  However that's pretty common now (the kernel change
> was merged in 2021) so we attached cc:stable because we'll want this change
> to be backported to stable branches.
>
> Cc: qemu-stable <qemu-stable@nongnu.org>
> Reported-by: Zhiyi Guo <zhguo@redhat.com>
> Tested-by: Zhiyi Guo <zhguo@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/sysemu/kvm_int.h |  1 +
>  accel/kvm/kvm-all.c      | 99 ++++++++++++++++++++++++++++++++++------
>  accel/kvm/trace-events   |  1 +
>  3 files changed, 86 insertions(+), 15 deletions(-)
>
> diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
> index 1d8fb1473b..48e496b3d4 100644
> --- a/include/sysemu/kvm_int.h
> +++ b/include/sysemu/kvm_int.h
> @@ -46,6 +46,7 @@ typedef struct KVMMemoryListener {
>      MemoryListener listener;
>      KVMSlot *slots;
>      unsigned int nr_used_slots;
> +    unsigned int nr_slots_allocated;
>      int as_id;
>      QSIMPLEQ_HEAD(, KVMMemoryUpdate) transaction_add;
>      QSIMPLEQ_HEAD(, KVMMemoryUpdate) transaction_del;
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 75d11a07b2..c51a3f18db 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -69,6 +69,9 @@
>  #define KVM_GUESTDBG_BLOCKIRQ 0
>  #endif
>  
> +/* Default num of memslots to be allocated when VM starts */
> +#define  KVM_MEMSLOTS_NR_ALLOC_DEFAULT                      16
> +
>  struct KVMParkedVcpu {
>      unsigned long vcpu_id;
>      int kvm_fd;
> @@ -165,6 +168,57 @@ void kvm_resample_fd_notify(int gsi)
>      }
>  }
>  
> +/**
> + * kvm_slots_grow(): Grow the slots[] array in the KVMMemoryListener
> + *
> + * @kml: The KVMMemoryListener* to grow the slots[] array
> + * @nr_slots_new: The new size of slots[] array
> + *
> + * Returns: True if the array grows larger, false otherwise.
> + */
> +static bool kvm_slots_grow(KVMMemoryListener *kml, unsigned int nr_slots_new)
> +{
> +    unsigned int i, cur = kml->nr_slots_allocated;
> +    KVMSlot *slots;
> +
> +    if (nr_slots_new > kvm_state->nr_slots) {
> +        nr_slots_new = kvm_state->nr_slots;
> +    }
> +
> +    if (cur >= nr_slots_new) {
> +        /* Big enough, no need to grow, or we reached max */
> +        return false;
> +    }
> +
> +    if (cur == 0) {
> +        slots = g_new0(KVMSlot, nr_slots_new);
> +    } else {
> +        assert(kml->slots);
> +        slots = g_renew(KVMSlot, kml->slots, nr_slots_new);
> +        /*
> +         * g_renew() doesn't initialize extended buffers, however kvm
> +         * memslots require fields to be zero-initialized. E.g. pointers,
> +         * memory_size field, etc.
> +         */
> +        memset(&slots[cur], 0x0, sizeof(slots[0]) * (nr_slots_new - cur));
> +    }
> +
> +    for (i = cur; i < nr_slots_new; i++) {
> +        slots[i].slot = i;
> +    }
> +
> +    kml->slots = slots;
> +    kml->nr_slots_allocated = nr_slots_new;
> +    trace_kvm_slots_grow(cur, nr_slots_new);
> +
> +    return true;
> +}
> +
> +static bool kvm_slots_double(KVMMemoryListener *kml)
> +{
> +    return kvm_slots_grow(kml, kml->nr_slots_allocated * 2);
> +}
> +
>  unsigned int kvm_get_max_memslots(void)
>  {
>      KVMState *s = KVM_STATE(current_accel());
> @@ -193,15 +247,26 @@ unsigned int kvm_get_free_memslots(void)
>  /* Called with KVMMemoryListener.slots_lock held */
>  static KVMSlot *kvm_get_free_slot(KVMMemoryListener *kml)
>  {
> -    KVMState *s = kvm_state;
> +    unsigned int n;
>      int i;
>  
> -    for (i = 0; i < s->nr_slots; i++) {
> +    for (i = 0; i < kml->nr_slots_allocated; i++) {
>          if (kml->slots[i].memory_size == 0) {
>              return &kml->slots[i];
>          }
>      }
>  
> +    /*
> +     * If no free slots, try to grow first by doubling.  Cache the old size
> +     * here to avoid another round of search: if the grow succeeded, it
> +     * means slots[] now must have the existing "n" slots occupied,
> +     * followed by one or more free slots starting from slots[n].
> +     */
> +    n = kml->nr_slots_allocated;
> +    if (kvm_slots_double(kml)) {
> +        return &kml->slots[n];
> +    }
> +
>      return NULL;
>  }
>  
> @@ -222,10 +287,9 @@ static KVMSlot *kvm_lookup_matching_slot(KVMMemoryListener *kml,
>                                           hwaddr start_addr,
>                                           hwaddr size)
>  {
> -    KVMState *s = kvm_state;
>      int i;
>  
> -    for (i = 0; i < s->nr_slots; i++) {
> +    for (i = 0; i < kml->nr_slots_allocated; i++) {
>          KVMSlot *mem = &kml->slots[i];
>  
>          if (start_addr == mem->start_addr && size == mem->memory_size) {
> @@ -267,7 +331,7 @@ int kvm_physical_memory_addr_from_host(KVMState *s, void *ram,
>      int i, ret = 0;
>  
>      kvm_slots_lock();
> -    for (i = 0; i < s->nr_slots; i++) {
> +    for (i = 0; i < kml->nr_slots_allocated; i++) {
>          KVMSlot *mem = &kml->slots[i];
>  
>          if (ram >= mem->ram && ram < mem->ram + mem->memory_size) {
> @@ -1071,7 +1135,7 @@ static int kvm_physical_log_clear(KVMMemoryListener *kml,
>  
>      kvm_slots_lock();
>  
> -    for (i = 0; i < s->nr_slots; i++) {
> +    for (i = 0; i < kml->nr_slots_allocated; i++) {
>          mem = &kml->slots[i];
>          /* Discard slots that are empty or do not overlap the section */
>          if (!mem->memory_size ||
> @@ -1719,12 +1783,8 @@ static void kvm_log_sync_global(MemoryListener *l, bool last_stage)
>      /* Flush all kernel dirty addresses into KVMSlot dirty bitmap */
>      kvm_dirty_ring_flush();
>  
> -    /*
> -     * TODO: make this faster when nr_slots is big while there are
> -     * only a few used slots (small VMs).
> -     */
>      kvm_slots_lock();
> -    for (i = 0; i < s->nr_slots; i++) {
> +    for (i = 0; i < kml->nr_slots_allocated; i++) {
>          mem = &kml->slots[i];
>          if (mem->memory_size && mem->flags & KVM_MEM_LOG_DIRTY_PAGES) {
>              kvm_slot_sync_dirty_pages(mem);
> @@ -1839,12 +1899,9 @@ void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
>  {
>      int i;
>  
> -    kml->slots = g_new0(KVMSlot, s->nr_slots);
>      kml->as_id = as_id;
>  
> -    for (i = 0; i < s->nr_slots; i++) {
> -        kml->slots[i].slot = i;
> -    }
> +    kvm_slots_grow(kml, KVM_MEMSLOTS_NR_ALLOC_DEFAULT);
>  
>      QSIMPLEQ_INIT(&kml->transaction_add);
>      QSIMPLEQ_INIT(&kml->transaction_del);
> @@ -2461,6 +2518,18 @@ static int kvm_init(MachineState *ms)
>          s->nr_slots = 32;
>      }

If !s->nr_slots, this 32 here^ will always be smaller than 16, so the
code below will always trigger.

>  
> +    /*
> +     * A VM will at least require a few memslots to work, or it can even
> +     * fail to boot.  Make sure the supported value is always at least
> +     * larger than what we will initially allocate.

The commit message says 16 was chosen to cover basic usage, which is
fine. But here we're disallowing anything smaller. Shouldn't QEMU always
respect what KVM decided? Of course, setting aside bugs or other
scenarios that could result in the ioctl returning 0. Could some kernel
implementation at some point want to reduce the max number of memslots
and then get effectively denied because QEMU thinks otherwise?

> +     */
> +    if (s->nr_slots < KVM_MEMSLOTS_NR_ALLOC_DEFAULT) {
> +        ret = -EINVAL;
> +        fprintf(stderr, "KVM max supported number of slots (%d) too small\n",
> +                s->nr_slots);
> +        goto err;
> +    }
> +
>      s->nr_as = kvm_check_extension(s, KVM_CAP_MULTI_ADDRESS_SPACE);
>      if (s->nr_as <= 1) {
>          s->nr_as = 1;
> diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
> index 37626c1ac5..ad2ae6fca5 100644
> --- a/accel/kvm/trace-events
> +++ b/accel/kvm/trace-events
> @@ -36,3 +36,4 @@ kvm_io_window_exit(void) ""
>  kvm_run_exit_system_event(int cpu_index, uint32_t event_type) "cpu_index %d, system_even_type %"PRIu32
>  kvm_convert_memory(uint64_t start, uint64_t size, const char *msg) "start 0x%" PRIx64 " size 0x%" PRIx64 " %s"
>  kvm_memory_fault(uint64_t start, uint64_t size, uint64_t flags) "start 0x%" PRIx64 " size 0x%" PRIx64 " flags 0x%" PRIx64
> +kvm_slots_grow(unsigned int old, unsigned int new) "%u -> %u"

