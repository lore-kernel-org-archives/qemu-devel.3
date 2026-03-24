Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06520E9A762
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 11:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4zaP-0002qv-Rm; Tue, 24 Mar 2026 07:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1w4zaK-0002qb-Qn
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 07:06:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1w4zaI-0003XP-Jh
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 07:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774350364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8VJOHq9MnPvA4PVuR9XbiVsnpDqVhZCTyGaka/FEGlw=;
 b=BiO6Ezfx5WSi/aTXwfw7+OimWCIJQsk6lKMkaWjW5KJUCHrKe4pC+wpz5ivmEkWnPQ+I/W
 WX+Hc+SMqXvSC5eL0nCG8UajHfPfRR/hJ1S+k+qDqS35zDk8clTg35/GjMqNBPUAaz88yG
 ueTr2nHRnrtM8YU6KTpjyxDdD3zjx6k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-BTLt3KTMMrK-KOkxSRvaUg-1; Tue, 24 Mar 2026 07:06:03 -0400
X-MC-Unique: BTLt3KTMMrK-KOkxSRvaUg-1
X-Mimecast-MFC-AGG-ID: BTLt3KTMMrK-KOkxSRvaUg_1774350362
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-486fb29a8b8so47008095e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 04:06:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774350362; cv=none;
 d=google.com; s=arc-20240605;
 b=hD8tP+JlLhSJlPD2TOuSs7GbchLDyqt5qtadNJhOO00ERTmDctPN0eQjqTXhJN0DlT
 +Z9wRGaY4poE5LR2mhEoPdcewYRd8sG85tugYoGrIra+/5dx4KeFvjpBCdTaDXFvBKCj
 okWDtDUg2a+VU0y11pbPqTjDQYltAdTSd7xDsnng105tcn4p7Bs4KpNbConMkKuXPz4O
 IDwijvSa7nftKPSviw17B2IhmQnDBXVFRUzy7Ngn8XBbKee8C7bkW7lCGhuB9R7pGEJm
 hf8b4ti71ZCuMn8AEEZCVTfW5bY9HPWbNUca11PHhXm81n7r5t9bmNVNOr5maI18nsM+
 q9DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8VJOHq9MnPvA4PVuR9XbiVsnpDqVhZCTyGaka/FEGlw=;
 fh=PJ2YM0MCLDpxc+Rr1VwlqTOUmMMZEVsV9MPE+Th47YI=;
 b=CXpKEMRq3lCBGSaVFNASOdlCUZFrpChpoFl9psTEl+YeEDnfdmrskBn8rYHursXW1f
 XM1sMDsCJWrxPUOrklYNrADRiOzafOZcIDxO5A9rjiPh4swBQQgQ/O8JxFQUDfv3VVvG
 7ojFJrpFrdx7V57RC6/i/kcEVFEffhGEGkB77KCIJlX2ihX244gv3dZW4YlS7b+0enwG
 ZZaRXPCEfGadAq3QJYwt4kqT6Npuke7EEE6lPGZ3rUGeE7dH8beZQUuoGKoxCFF3X6cZ
 2OkrboxsYhUKgOm5pO9INt644sy8PB7SNdzjydimHXVlfpj7508HVvGasLTGZLoydAs+
 f0vg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774350362; x=1774955162; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8VJOHq9MnPvA4PVuR9XbiVsnpDqVhZCTyGaka/FEGlw=;
 b=VIyhURe0DJA56iclXKVjL2tYoVjXICVXevhgy3QOERKlA7uHQgWQPHL7fAwaBuYswR
 XpfFUGaRu63T3Z2aYlFIOJw172BsBbiAyBpy4iYZcAmBx7OWg7vyqO+5fIxFCGL4raDT
 iNKozU2CxKHidzqAVr3LUYhI6yvZ+DzIBRggbMv3fnnpe6hHQmqteMAa5TodoJbBP+cT
 ySIfkGWggYNFLRrKnBkHRTVydqD08L1lK7SGH0XuVBPcJH2OETNf3k4R+8C/G4A1ag9x
 lGINnU08Tq1dJqSbnaIN7sbMEaBcr+h+kDJS70uDAoNJqDadUAul+tcmO4sClMpBlMXv
 XPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774350362; x=1774955162;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8VJOHq9MnPvA4PVuR9XbiVsnpDqVhZCTyGaka/FEGlw=;
 b=jZxccMU6m2hHHSFbC5PeITeAn9+ob/W87TqCPeGJ1JvBNZyU3wUbIpliuRxtJvj0Gb
 VKAIT8gV+Z3KToZFB9hME7QJnEextu28sZBl72eU7DDIL7avGJ4HUY3cySM88ehYHhJT
 Pc/TPYJ7w1rbOp3Q33T+igqqDJJHTgu4eWheqKRvVZYHJ6VG1iMAacYHHF1aa3S6gZnC
 Pw5wFRP+o9fhqLihyxZBpjU+dW907WnlDMAn2rI72LNMtVduxJYaY4hnmTSu5Z6If4/S
 u/HWEi1/hE2spWBZKpx9K0Ky6IePLJyG1vXS9pqSCY5zKziH1FMSU69qDG+d1JwopTuN
 xt7Q==
X-Gm-Message-State: AOJu0Yxyakq/nzY3WtAf1sGFkqRPFdn8FZd93v3LGq7CzYO5eEFAafjF
 sVIhq3XUngC4uZMxPP0542mPgS/zj4qD9FWWgdZcGSI5iBEow4IGZJg9Ua0FHlHeIZp4jqkHj4P
 krUYasW7HJ3JPo3xwkrCVTfNH9yncbkQQffo0T9VxfaxvvXXEdtAVp/N/1euE+gfRurDM5fgIVC
 EfpMRO+ma/UfmLWoQWBmr6nBl4vAKBDUc=
X-Gm-Gg: ATEYQzxvmBT2fPIifkqC0GJjflzlzGi1MFSO5h5LavLjq/+m0eMmywTcojghMp169Km
 GZU7HVRWmyvlfe6VJnTgH9L4ppPIGqK7ANnly79Bh0FsstHaY9GEmDz+b2i6GjHR56DL1X1kJSB
 UuECexLRXmclCKP3wFm8slZV7Mr0L22t2uHLg8SIKU5KY44BukDHIgoq2KFZ/RzSB7fOyqPfyiM
 oJL5nIP/UWnoKYZTU0NY8atJaNh6l3TATDzOxPNyP9Ri5ZG9DduC+B6+vlESj3QaiQe
X-Received: by 2002:a05:600c:c167:b0:486:fc5f:1ab9 with SMTP id
 5b1f17b1804b1-486fedcbeb7mr205943215e9.14.1774350361878; 
 Tue, 24 Mar 2026 04:06:01 -0700 (PDT)
X-Received: by 2002:a05:600c:c167:b0:486:fc5f:1ab9 with SMTP id
 5b1f17b1804b1-486fedcbeb7mr205942695e9.14.1774350361328; Tue, 24 Mar 2026
 04:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-8-peterx@redhat.com>
In-Reply-To: <20260319231302.123135-8-peterx@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 24 Mar 2026 16:35:44 +0530
X-Gm-Features: AQROBzAxkwqMZcdTjsKamFTPI7bkpB6K3laxhUAhSmNDKvxeG8ngDLmtelzd81M
Message-ID: <CAE8KmOw46mXdbMRXSRUEHiddsr4dzRKRwYqpmwizWCtqPyFNuw@mail.gmail.com>
Subject: Re: [PATCH RFC 07/12] migration: Introduce stopcopy_bytes in
 save_query_pending()
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>, 
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Joao Martins <joao.m.martins@oracle.com>, Alex Williamson <alex@shazbot.org>, 
 Yishai Hadas <yishaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 Pranav Tyagi <prtyagi@redhat.com>, 
 Zhiyi Guo <zhguo@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 20 Mar 2026 at 04:44, Peter Xu <peterx@redhat.com> wrote:
> Allow modules to report data that can only be migrated after VM is stopped.
>
> When this concept is introduced, we will need to account stopcopy size to
> be part of pending_size as before.
>
> One thing to mention is, when there can be stopcopy size, it means the old
> "pending_size" may not always be able to reach low enough to kickoff an
> slow version of query sync.  While it used to be almost guaranteed to
> happen because if we keep iterating, normally pending_size can go to zero
> for precopy-only because we assume everything reported can be migrated in
> precopy phase.
>
> So we need to make sure QEMU will kickoff a synchronized version of query
> pending when all precopy data is migrated too.  This might be important to
> VFIO to keep making progress even if the downtime cannot yet be satisfied.
>
> So far, this patch should introduce no functional change, as no module yet
> report stopcopy size.
>
> This will pave way for VFIO to properly report its pending data sizes,
> which was actually buggy today.  Will be done in follow up patches.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/migration/register.h | 12 +++++++++
>  migration/migration.c        | 52 ++++++++++++++++++++++++++++++------
>  migration/savevm.c           |  7 +++--
>  migration/trace-events       |  2 +-
>  4 files changed, 62 insertions(+), 11 deletions(-)
>
> diff --git a/include/migration/register.h b/include/migration/register.h
> index 2320c3a981..3824958ba5 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -17,12 +17,24 @@
>  #include "hw/core/vmstate-if.h"
>
>  typedef struct MigPendingData {
> +    /*
> +     * Modules can only update these fields in a query request via its
> +     * save_query_pending() API.
> +     */
>      /* How many bytes are pending for precopy / stopcopy? */
>      uint64_t precopy_bytes;
>      /* How many bytes are pending that can be transferred in postcopy? */
>      uint64_t postcopy_bytes;
> +    /* How many bytes that can only be transferred when VM stopped? */
> +    uint64_t stopcopy_bytes;

* This differentiation of pending bytes into
precopy/postcopy/stopcopy/total could become confusing, because their
intention isn't readily clear. Pending bytes indicates bytes still
pending or waiting to be sent. So is not the case with postcopy_bytes
and stopcopy_bytes and total_bytes. Do we really need this separation?

> +    /*
> +     * Modules should never update these fields.
> +     */
>      /* Is this a fastpath query (which can be inaccurate)? */
>      bool fastpath;

* Fast & slow adjectives generally go with speed, rather than accuracy
or rough estimates. Here its usage is more to decide whether to return
an estimated value OR an accurate value.It'll help to rename it to
something suitable for accuracy/precision.

> +    /* Total pending data */
> +    uint64_t total_bytes;
>  } MigPendingData ;
>
>  /**
> diff --git a/migration/migration.c b/migration/migration.c
> index 99c4d09000..42facb16d1 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3198,6 +3198,44 @@ typedef enum {
>      MIG_ITERATE_BREAK,          /* Break the loop */
>  } MigIterateState;
>
> +/* Are we ready to move to the next iteration phase? */
> +static bool migration_iteration_next_ready(MigrationState *s,
> +                                           MigPendingData *pending)
> +{
> +    /*
> +     * If the estimated values already suggest us to switchover, mark this
> +     * iteration finished, time to do a slow sync.
> +     */
> +    if (pending->total_bytes <= s->threshold_size) {
> +        return true;
> +    }
> +
> +    /*
> +     * Since we may have modules reporting stop-only data, we also want to
> +     * re-query with slow mode if all precopy data is moved over.  This
> +     * will also mark the current iteration done.
> +     *
> +     * This could happen when e.g. a module (like, VFIO) reports stopcopy
> +     * size too large so it will never yet satisfy the downtime with the
> +     * current setup (above check).  Here, slow version of re-query helps
> +     * because we keep trying the best to move whatever we have.
> +     */
> +    if (pending->precopy_bytes == 0) {
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
> +static void migration_iteration_go_next(MigPendingData *pending)
> +{
> +    /*
> +     * Do a slow sync will achieve this.  TODO: move RAM iteration code
> +     * into the core layer.
> +     */
> +    qemu_savevm_query_pending(pending, false);
> +}

* What is _go_next() function used for? To  trigger
migration_bitmap_sync_precopy() call via   _savevm_query_pending(,
false)?

>  /*
>   * Return true if continue to the next iteration directly, false
>   * otherwise.
> @@ -3209,12 +3247,10 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>                          s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
>      bool can_switchover = migration_can_switchover(s);
>      MigPendingData pending = { };
> -    uint64_t pending_size;
>      bool complete_ready;
>
>      /* Fast path - get the estimated amount of pending data */
>      qemu_savevm_query_pending(&pending, true);
> -    pending_size = pending.precopy_bytes + pending.postcopy_bytes;
>
>      if (in_postcopy) {
>          /*
> @@ -3222,7 +3258,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>           * postcopy completion doesn't rely on can_switchover, because when
>           * POSTCOPY_ACTIVE it means switchover already happened.
>           */
> -        complete_ready = !pending_size;
> +        complete_ready = !pending.total_bytes;
>          if (s->state == MIGRATION_STATUS_POSTCOPY_DEVICE &&
>              (s->postcopy_package_loaded || complete_ready)) {
>              /*
> @@ -3242,9 +3278,8 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>           * postcopy started, so ESTIMATE should always match with EXACT
>           * during postcopy phase.
>           */
> -        if (pending_size <= s->threshold_size) {
> -            qemu_savevm_query_pending(&pending, false);
> -            pending_size = pending.precopy_bytes + pending.postcopy_bytes;
> +        if (migration_iteration_next_ready(s, &pending)) {
> +            migration_iteration_go_next(&pending);
>          }
>
>          /* Should we switch to postcopy now? */
> @@ -3264,11 +3299,12 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>           * (2) Pending size is no more than the threshold specified
>           *     (which was calculated from expected downtime)
>           */
> -        complete_ready = can_switchover && (pending_size <= s->threshold_size);
> +        complete_ready = can_switchover &&
> +            (pending.total_bytes <= s->threshold_size);
>      }
>
>      if (complete_ready) {
> -        trace_migration_thread_low_pending(pending_size);
> +        trace_migration_thread_low_pending(pending.total_bytes);
>          migration_completion(s);
>          return MIG_ITERATE_BREAK;
>      }
> diff --git a/migration/savevm.c b/migration/savevm.c
> index b3285d480f..812c72b3e5 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1766,8 +1766,7 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool fastpath)
>  {
>      SaveStateEntry *se;
>
> -    pending->precopy_bytes = 0;
> -    pending->postcopy_bytes = 0;
> +    memset(pending, 0, sizeof(*pending));
>      pending->fastpath = fastpath;
>
>      QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> @@ -1780,7 +1779,11 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool fastpath)
>          se->ops->save_query_pending(se->opaque, pending);
>      }
>
> +    pending->total_bytes = pending->precopy_bytes +
> +        pending->stopcopy_bytes + pending->postcopy_bytes;
> +
>      trace_qemu_savevm_query_pending(fastpath, pending->precopy_bytes,
> +                                    pending->stopcopy_bytes,
>                                      pending->postcopy_bytes);
>  }
>
> diff --git a/migration/trace-events b/migration/trace-events
> index 5f836a8652..175f09f8ad 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -7,7 +7,7 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
>  qemu_loadvm_state_post_main(int ret) "%d"
>  qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
>  qemu_savevm_send_packaged(void) ""
> -qemu_savevm_query_pending(bool fast, uint64_t precopy, uint64_t postcopy) "fast=%d, precopy=%"PRIu64", postcopy=%"PRIu64
> +qemu_savevm_query_pending(bool fast, uint64_t precopy, uint64_t stopcopy, uint64_t postcopy) "fast=%d, precopy=%"PRIu64", stopcopy=%"PRIu64", postcopy=%"PRIu64
>  loadvm_state_switchover_ack_needed(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
>  loadvm_state_setup(void) ""
>  loadvm_state_cleanup(void) ""
> --
> 2.50.1
>
>


