Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C541CDB481
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 14:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcOwO-0000k8-3N; Wed, 24 Jun 2026 10:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wcOw2-0000jG-B0
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 10:50:38 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wcOvy-0006iN-Rd
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 10:50:38 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 31F9D75EA3;
 Wed, 24 Jun 2026 14:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782312630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3ZZa1pepOkk4XMG3FKXYEmD7JG8E3s9tpbFmfq6jbU4=;
 b=qI3wC3WA4IWciaPCjLy9hmpBUk7In/UOU7j8FFuegoHg1EwgA2ydpuik3/OjUgm+T9m8cd
 qTgOmJgT+d9RpniVVQ9/RNfNMab56CUihcT5et8mj7MveIXRxTfnMFIK3ifGM5p5SdF4EA
 Fo+WzHHT6CBAAzhJVNjh1DV975ncp3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782312630;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3ZZa1pepOkk4XMG3FKXYEmD7JG8E3s9tpbFmfq6jbU4=;
 b=vqdfVyQMPq7+RN3bZFCRKakHCUzzQTBCERlmEOrcCPD7DJpGnAdfM8QDdiT1pnyQh37Ss1
 aXCM2JZzimOVJ0DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782312629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3ZZa1pepOkk4XMG3FKXYEmD7JG8E3s9tpbFmfq6jbU4=;
 b=Eif9Yv3DbGSxKsilfvZUrFc44j9hj1xTsms5+/bqSE3ZxXkyKoPqunLmpoobK8UAdgbyGu
 e5fzsoAt+81zsrMky2nIo/aXdPmFk6y4pjTiy2Qlin/Zpawm4hQNR5uAP2XuMkUb/W1hkT
 OfqnajWviyM4pkQATjfP0YkghGNc3PM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782312629;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3ZZa1pepOkk4XMG3FKXYEmD7JG8E3s9tpbFmfq6jbU4=;
 b=bkV4tkYQLJjIFwlO5YXB+ZX2DlVOw5P7Xpq+OWhyTGARNcbXQu58JUxbvEhFR2wuiU0UKD
 uvW8iD94DO1kdYCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C7834779A8;
 Wed, 24 Jun 2026 14:50:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0XP1JbTuO2qSWQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 24 Jun 2026 14:50:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Aadeshveer Singh <aadeshveer07@gmail.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, Aadeshveer Singh
 <aadeshveer07@gmail.com>
Subject: Re: [RFC PATCH 3/5] migration: add eager load thread for fast
 snapshot load
In-Reply-To: <20260618032010.88755-4-aadeshveer07@gmail.com>
References: <20260618032010.88755-1-aadeshveer07@gmail.com>
 <20260618032010.88755-4-aadeshveer07@gmail.com>
Date: Wed, 24 Jun 2026 11:50:22 -0300
Message-ID: <871pdwouvl.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[gmail.com,nongnu.org];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,mailo.com,saferwall.com,gmail.com];
 RCPT_COUNT_SEVEN(0.00)[8]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Aadeshveer Singh <aadeshveer07@gmail.com> writes:

> In fast snapshot load a thread is needed for actively loading in pages
> along with the fault path so that the guest is not dependent on fault
> thread indefinitely.
>

In the paragraph above, "dependent on fault thread indefinitely" is a
bit vague: it's not clear why that condition might be undesirable or why
it's indefinte.

How is that different from normal postcopy? Is the point that postcopy
will have transferred most of the memory in precopy so the fault thread
has way less pages to deal with whereas here is the opposite, just a few
pages have been potentially loaded with a large chunk still waiting to
be faulted in?

Is this new eager thread something that could be used even for normal
postcopy? Kind of sounds like a separate sub-feature. Does the fast
snapshot work at all without this?

> Add postcopy_ram_eager_load_thread(), for the eager thread which
> iterates over all non ignored blocks calling ram_block_load_eager()
> each. ram_block_load_eager then iterates to load in all pages using
> postcopy_mapped_ram_load_page(), with a different channel, which takes
> care of not loading in pages already loaded by fault thread. On
> completion the thread schedules postcopy_ram_eager_load_bh() to destroy
> the incoming migration state and set states to completed/end.
>

Ok, so that answers my question from the cover letter, we're holding the
migration until all pages have been loaded. So it's yet another reason
to have the eager thread. Still, the fast snapshot load can be fast
while having a slow migration overall I suppose.

To be clear, I'm not arguing against the design, only trying to frame
the dependencies.

> Add postcopy_ram_eager_load_setup() to create the thread. Added joining
> logic in postcopy_incoming_cleanup().
>
> Add tracepoints for entry and exit to eager load thread.
>
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> ---
>  migration/migration.h    |  5 +++
>  migration/postcopy-ram.c | 75 ++++++++++++++++++++++++++++++++++++++++
>  migration/postcopy-ram.h |  2 ++
>  migration/trace-events   |  2 ++
>  4 files changed, 84 insertions(+)
>
> diff --git a/migration/migration.h b/migration/migration.h
> index 841f49b215..7bb54a6584 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -42,6 +42,7 @@
>  #define  MIGRATION_THREAD_DST_FAULT         "mig/dst/fault"
>  #define  MIGRATION_THREAD_DST_LISTEN        "mig/dst/listen"
>  #define  MIGRATION_THREAD_DST_PREEMPT       "mig/dst/preempt"
> +#define  MIGRATION_THREAD_DST_EAGER         "mig/dst/eager"
>  
>  struct PostcopyBlocktimeContext;
>  typedef struct ThreadPool ThreadPool;
> @@ -120,6 +121,10 @@ struct MigrationIncomingState {
>      bool           have_listen_thread;
>      QemuThread     listen_thread;
>  
> +    /* Thread to load pages eagerly in fast snapshot load case */
> +    bool have_eager_load_thread;
> +    QemuThread eager_load_thread;
> +
>      /* For the kernel to send us notifications */
>      int       userfault_fd;
>      /* To notify the fault_thread to wake, e.g., when need to quit */
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 1ec20a07dd..0ee294a381 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -2289,9 +2289,84 @@ int postcopy_incoming_cleanup(MigrationIncomingState *mis)
>          mis->have_listen_thread = false;
>      }
>  
> +    if (mis->have_eager_load_thread) {
> +        qemu_thread_join(&mis->eager_load_thread);
> +        mis->have_eager_load_thread = false;
> +    }
> +
>      if (migrate_postcopy_ram()) {
>          rc = postcopy_ram_incoming_cleanup(mis);
>      }
>  
>      return rc;
>  }
> +
> +/*
> + * Called by postcopy_ram_eager_load_thread over all blocks to load in all the
> + * pending pages of given ram block
> + */
> +static int ram_block_load_eager(RAMBlock *rb, void *opaque)
> +{
> +    MigrationIncomingState *mis = opaque;
> +    void *host = qemu_ram_get_host_addr(rb);
> +    void *target;
> +    int ret = 0;
> +
> +    for (ram_addr_t page_loc = 0; page_loc < rb->used_length;
> +         page_loc += TARGET_PAGE_SIZE) {
> +        target = (uint8_t *)host + page_loc;
> +        ret = postcopy_mapped_ram_load_page(mis, rb, page_loc, (uint64_t)target,
> +                                            0);
> +        if (ret) {
> +            break;
> +        }
> +    }
> +    return ret;
> +}
> +
> +/*
> + * Bottom half for fast snapshot load, scheduled by eager load thread
> + */
> +static void postcopy_ram_eager_load_bh(void *opaque)
> +{
> +    MigrationIncomingState *mis = opaque;
> +    postcopy_state_set(POSTCOPY_INCOMING_END);
> +    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> +                      MIGRATION_STATUS_COMPLETED);
> +    migration_incoming_state_destroy();
> +}
> +
> +/*
> + * Used by fast snapshot load to eagerly load in all pages of RAM and schedule
> + * cleanup after entire RAM is loaded
> + */
> +static void *postcopy_ram_eager_load_thread(void *opaque)
> +{
> +    MigrationIncomingState *mis = opaque;
> +
> +    trace_postcopy_ram_eager_load_thread_entry();
> +    rcu_register_thread();
> +    qemu_event_set(&mis->thread_sync_event);
> +
> +    if (foreach_not_ignored_block(ram_block_load_eager, mis)) {
> +        error_report("ram_block_load_eager failed");
> +    }
> +
> +    migration_bh_schedule(postcopy_ram_eager_load_bh, mis);
> +
> +    rcu_unregister_thread();
> +    trace_postcopy_ram_eager_load_thread_exit();
> +    return NULL;
> +}
> +
> +/*
> + * Create thread for eager loading in fast snapshot load case
> + */
> +int postcopy_ram_eager_load_setup(MigrationIncomingState *mis)
> +{
> +    postcopy_thread_create(
> +        mis, &mis->eager_load_thread, MIGRATION_THREAD_DST_EAGER,
> +        postcopy_ram_eager_load_thread, QEMU_THREAD_JOINABLE);
> +    mis->have_eager_load_thread = true;
> +    return 0;
> +}
> diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
> index a080dd65a7..b3ba42e447 100644
> --- a/migration/postcopy-ram.h
> +++ b/migration/postcopy-ram.h
> @@ -202,4 +202,6 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
>  int postcopy_incoming_setup(MigrationIncomingState *mis, Error **errp);
>  int postcopy_incoming_cleanup(MigrationIncomingState *mis);
>  
> +int postcopy_ram_eager_load_setup(MigrationIncomingState *mis);
> +
>  #endif
> diff --git a/migration/trace-events b/migration/trace-events
> index de99d976ab..38f11e1e9f 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -314,6 +314,8 @@ postcopy_blocktime_tid_cpu_map(int cpu, uint32_t tid) "cpu: %d, tid: %u"
>  postcopy_blocktime_begin(uint64_t addr, uint64_t time, int cpu, bool exists) "addr: 0x%" PRIx64 ", time: %" PRIu64 ", cpu: %d, exist: %d"
>  postcopy_blocktime_end(uint64_t addr, uint64_t time, int affected_cpu, int affected_non_cpus) "addr: 0x%" PRIx64 ", time: %" PRIu64 ", affected_cpus: %d, affected_non_cpus: %d"
>  postcopy_blocktime_end_one(int cpu, uint8_t left_faults) "cpu: %d, left_faults: %" PRIu8
> +postcopy_ram_eager_load_thread_entry(void) ""
> +postcopy_ram_eager_load_thread_exit(void) ""
>  
>  # exec.c
>  migration_exec_outgoing(const char *cmd) "cmd=%s"

