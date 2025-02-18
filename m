Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD7DC02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 11:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkLbU-0005ol-A5; Tue, 18 Feb 2025 06:17:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1tkLbQ-0005o4-TM
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 06:17:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1tkLbO-000591-Ep
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 06:17:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739877441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SlUf+viXXTYLM1n9QT9615QO/y5+q5MUvUOhZnSke3I=;
 b=GafkRu55doz7QN11bk6/4i5yZuC3xzOlSN9+iKo5IMdPGKxuAvbPglrHTlN+HxNe2MRUoB
 4SarVHgvP+Xa9J77d9E6tz1Ioy52MDcBJJdlx9cWTrBtDZwk6ZGlQcTsSxHCfFyWfwMo6g
 DY8fc2pthB3CswN17ojwgkmWVl7OxY4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-_HF4zoTuNlCWtFXtP1Ztdg-1; Tue, 18 Feb 2025 06:17:19 -0500
X-MC-Unique: _HF4zoTuNlCWtFXtP1Ztdg-1
X-Mimecast-MFC-AGG-ID: _HF4zoTuNlCWtFXtP1Ztdg_1739877439
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4398e841963so8212325e9.3
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 03:17:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739877439; x=1740482239;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SlUf+viXXTYLM1n9QT9615QO/y5+q5MUvUOhZnSke3I=;
 b=MafmAfkgGaH7BkaauBHEPOM2xFYcFnhnPaTrKv/9O24zqvrcNY17xTMe/Jdh4rEyJX
 gqojQ77mGziyuGb9vStVCyHvbSbk0Aaku0/Xb6QJDZo67iKa9nn/VKUve60kOBPWAgod
 ++mtwCLJuDhXEV1UmQjMRhO2V+1/bqwy/I8OJav7WUpxuKLaLcCrK4vJhgd7kPs1p5d4
 +6/G+caP4EcTBp5j6ZRBhHrx3t5YmCa0kOP8KNWwGALQvNE6Wulgh/hh3Aw5uNdzrx3C
 fg2tF7AeEN8bUfBgZb4HbAETctPUYkNmco5AHs9Ac/5T2qtp0g7B6/a2e/HtHZgZaDle
 ODkA==
X-Gm-Message-State: AOJu0YzYpQOdp0WvoKGCmouwtwHYzcTL85EMn/6C1zDj2qFat4M8pPr8
 hAISW/SD82oMzF5lL0f/UpkVaxoVhJ/fTxmKMosz3xX9ojxXPjt0vEqP9Ow3vyDbCARjFEalv3v
 Mt8MfDTLFFrM/nSvAAnJOPPZs8+YVnLYJHyOp7+zoKboKzMobKCR7
X-Gm-Gg: ASbGncsYzUTkXLoKoHYZ3YVUlYQiRs5n+mS7ahSg86XD/i2ljcAtc99vmaqLh+n0dSV
 RmhNypI1PntVLVFDdiDIEyfYzt9AYY5s3YSDtPP0ru+jOSAmdLGui4W8yJHyUFeP7T2RbgN9ujh
 o0i4Glgrfm4lXcmW3udv+/Mta8TxOANKq3b60lF7Gwm3mG+KnPXMgvdNgHEoqs9ndRu6Mqc4/3i
 XWWxTmlWnx2D/FRzaUZFNUgfKoREZFuIJY6rVKGOexc5xOHfUmmFSenEydgzKllQuBmCMDNVlnn
 p9vo2fMylfKx91Jd2dLmIiACwQ==
X-Received: by 2002:a05:600c:4750:b0:439:9828:c446 with SMTP id
 5b1f17b1804b1-4399828c67amr4970975e9.11.1739877438635; 
 Tue, 18 Feb 2025 03:17:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+DXCum9ggkpDpdyApx6VU78NelSENIaLHXcfu0/KB6ZuBQHg3gC4oRCJ9yS3mQO2Iuuru9Q==
X-Received: by 2002:a05:600c:4750:b0:439:9828:c446 with SMTP id
 5b1f17b1804b1-4399828c67amr4970635e9.11.1739877438178; 
 Tue, 18 Feb 2025 03:17:18 -0800 (PST)
Received: from rh-jmarcin (nat-pool-brq-t.redhat.com. [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439872b5a46sm46928585e9.32.2025.02.18.03.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 03:17:17 -0800 (PST)
Date: Tue, 18 Feb 2025 12:17:14 +0100
From: Juraj Marcin <jmarcin@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de, 
 berrange@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v6 2/4] migration: enable multifd and postcopy together
Message-ID: <3abdrwrfqm2vxbdtprqjckkgwmdb4xf2rcjld6eiljyx5uwepv@plbn2lz6nrug>
References: <20250215123119.814345-1-ppandit@redhat.com>
 <20250215123119.814345-3-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215123119.814345-3-ppandit@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Prasad,

On 2025-02-15 18:01, Prasad Pandit wrote:
> From: Prasad Pandit <pjp@fedoraproject.org>
> 
> Enable Multifd and Postcopy migration together.
> The migration_ioc_process_incoming() routine
> checks magic value sent on each channel and
> helps to properly setup multifd and postcopy
> channels.
> 
> The Precopy and Multifd threads work during the
> initial guest RAM transfer. When migration moves
> to the Postcopy phase, the multifd threads are
> shutdown and Postcopy threads on the destination
> request/pull data from the source side.
> 
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> ---
>  migration/migration.c      | 107 ++++++++++++++++++++-----------------
>  migration/multifd-nocomp.c |   3 +-
>  migration/multifd.c        |   4 +-
>  migration/options.c        |   5 --
>  migration/ram.c            |   7 ++-
>  5 files changed, 64 insertions(+), 62 deletions(-)
> 
> v6:
> - Shutdown multifd threads before postcopy_start()
> - Reorder tests/qtest/migration/ patches
> - Some refactoring of functions
> 
> v5:
> - https://lore.kernel.org/qemu-devel/20250205122712.229151-1-ppandit@redhat.com/T/#t
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 396928513a..38697182e8 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -95,6 +95,9 @@ enum mig_rp_message_type {
>      MIG_RP_MSG_MAX
>  };
>  
> +/* Migration channel types */
> +enum { CH_MAIN, CH_MULTIFD, CH_POSTCOPY };
> +
>  /* When we add fault tolerance, we could have several
>     migrations at once.  For now we don't need to add
>     dynamic creation of migration */
> @@ -959,28 +962,19 @@ void migration_fd_process_incoming(QEMUFile *f)
>      migration_incoming_process();
>  }
>  
> -/*
> - * Returns true when we want to start a new incoming migration process,
> - * false otherwise.
> - */
> -static bool migration_should_start_incoming(bool main_channel)
> +static bool migration_has_main_and_multifd_channels(void)
>  {
> -    /* Multifd doesn't start unless all channels are established */
> -    if (migrate_multifd()) {
> -        return migration_has_all_channels();
> +    MigrationIncomingState *mis = migration_incoming_get_current();
> +    if (!mis->from_src_file) {
> +        /* main channel not established */
> +        return false;
>      }
>  
> -    /* Preempt channel only starts when the main channel is created */
> -    if (migrate_postcopy_preempt()) {
> -        return main_channel;
> +    if (migrate_multifd() && !multifd_recv_all_channels_created()) {
> +        return false;
>      }
>  
> -    /*
> -     * For all the rest types of migration, we should only reach here when
> -     * it's the main channel that's being created, and we should always
> -     * proceed with this channel.
> -     */
> -    assert(main_channel);
> +    /* main channel and all multifd channels are established */
>      return true;
>  }
>  
> @@ -989,13 +983,12 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>      MigrationIncomingState *mis = migration_incoming_get_current();
>      Error *local_err = NULL;
>      QEMUFile *f;
> -    bool default_channel = true;
>      uint32_t channel_magic = 0;
> +    uint8_t channel = CH_MAIN;
>      int ret = 0;
>  
> -    if (migrate_multifd() && !migrate_mapped_ram() &&
> -        !migrate_postcopy_ram() &&
> -        qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
> +    if (!migration_has_main_and_multifd_channels()) {
> +        if (qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
>          /*
>           * With multiple channels, it is possible that we receive channels
>           * out of order on destination side, causing incorrect mapping of
> @@ -1006,42 +999,58 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>           * tls handshake while initializing main channel so with tls this
>           * issue is not possible.
>           */
> -        ret = migration_channel_read_peek(ioc, (void *)&channel_magic,
> -                                          sizeof(channel_magic), errp);
> +            ret = migration_channel_read_peek(ioc, (void *)&channel_magic,
> +                                              sizeof(channel_magic), errp);
> +            if (ret != 0) {
> +                return;
> +            }
>  
> -        if (ret != 0) {
> -            return;
> +            if (channel_magic == cpu_to_be32(QEMU_VM_FILE_MAGIC)) {
> +                channel = CH_MAIN;
> +            } else if (channel_magic == cpu_to_be32(MULTIFD_MAGIC)) {
> +                channel = CH_MULTIFD;
> +            } else if (!mis->from_src_file
> +                        && mis->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
> +                /* reconnect default channel for postcopy recovery */
> +                channel = CH_MAIN;
> +            } else {
> +                error_report("%s: unknown channel magic: %u",
> +                                __func__, channel_magic);

Here, the number reported in the error will have incorrect endianness on
a non-BE system. I think it would be better to convert channel_magic to
the system endianness right after reading it. On top of that, then there
is no need to convert constants with magic numbers when comparing.

> +                return;
> +            }
> +        } else if (mis->from_src_file
> +                && (!strcmp(ioc->name, "migration-tls-incoming")
> +                || !strcmp(ioc->name, "migration-file-incoming"))) {
> +            channel = CH_MULTIFD;
>          }
> -
> -        default_channel = (channel_magic == cpu_to_be32(QEMU_VM_FILE_MAGIC));
> -    } else {
> -        default_channel = !mis->from_src_file;
> +    } else if (mis->from_src_file) {
> +        channel = CH_POSTCOPY;
>      }
>  
>      if (multifd_recv_setup(errp) != 0) {
>          return;
>      }
>  
> -    if (default_channel) {
> +    if (channel == CH_MAIN) {
>          f = qemu_file_new_input(ioc);
>          migration_incoming_setup(f);
> -    } else {
> +    } else if (channel == CH_MULTIFD) {
>          /* Multiple connections */
> -        assert(migration_needs_multiple_sockets());
>          if (migrate_multifd()) {
>              multifd_recv_new_channel(ioc, &local_err);
> -        } else {
> -            assert(migrate_postcopy_preempt());
> -            f = qemu_file_new_input(ioc);
> -            postcopy_preempt_new_channel(mis, f);
>          }
>          if (local_err) {
>              error_propagate(errp, local_err);
>              return;
>          }
> +    } else if (channel == CH_POSTCOPY) {
> +        assert(migrate_postcopy_preempt());
> +        assert(!mis->postcopy_qemufile_dst);
> +        f = qemu_file_new_input(ioc);
> +        postcopy_preempt_new_channel(mis, f);
>      }
>  
> -    if (migration_should_start_incoming(default_channel)) {
> +    if (channel != CH_POSTCOPY && migration_has_main_and_multifd_channels()) {
>          /* If it's a recovery, we're done */
>          if (postcopy_try_recover()) {
>              return;
> @@ -1058,20 +1067,15 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>   */
>  bool migration_has_all_channels(void)
>  {
> +    if (!migration_has_main_and_multifd_channels()) {
> +        return false;
> +    }
> +
>      MigrationIncomingState *mis = migration_incoming_get_current();
> -
> -    if (!mis->from_src_file) {
> +    if (migrate_postcopy_preempt() && !mis->postcopy_qemufile_dst) {
>          return false;
>      }
>  
> -    if (migrate_multifd()) {
> -        return multifd_recv_all_channels_created();
> -    }
> -
> -    if (migrate_postcopy_preempt()) {
> -        return mis->postcopy_qemufile_dst != NULL;
> -    }
> -
>      return true;
>  }
>  
> @@ -1482,6 +1486,8 @@ static void migrate_fd_cleanup(MigrationState *s)
>  
>      assert(!migration_is_active());
>  
> +    file_cleanup_outgoing_migration();
> +    socket_cleanup_outgoing_migration();
>      if (s->state == MIGRATION_STATUS_CANCELLING) {
>          migrate_set_state(&s->state, MIGRATION_STATUS_CANCELLING,
>                            MIGRATION_STATUS_CANCELLED);
> @@ -3373,8 +3379,11 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>      }
>  
>      /* Still a significant amount to transfer */
> -    if (!in_postcopy && must_precopy <= s->threshold_size && can_switchover &&
> -        qatomic_read(&s->start_postcopy)) {
> +    if (!in_postcopy && must_precopy <= s->threshold_size
> +        && can_switchover && qatomic_read(&s->start_postcopy)) {
> +        if (migrate_multifd()) {
> +            multifd_send_shutdown();
> +        }
>          if (postcopy_start(s, &local_err)) {
>              migrate_set_error(s, local_err);
>              error_report_err(local_err);
> diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
> index 1325dba97c..d0edec7cd1 100644
> --- a/migration/multifd-nocomp.c
> +++ b/migration/multifd-nocomp.c
> @@ -16,6 +16,7 @@
>  #include "file.h"
>  #include "multifd.h"
>  #include "options.h"
> +#include "migration.h"
>  #include "qapi/error.h"
>  #include "qemu/cutils.h"
>  #include "qemu/error-report.h"
> @@ -391,7 +392,7 @@ int multifd_ram_flush_and_sync(QEMUFile *f)
>      MultiFDSyncReq req;
>      int ret;
>  
> -    if (!migrate_multifd()) {
> +    if (!migrate_multifd() || migration_in_postcopy()) {
>          return 0;
>      }
>  
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 97ce831775..fa83a43778 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -467,8 +467,6 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
>  
>  static void multifd_send_cleanup_state(void)
>  {
> -    file_cleanup_outgoing_migration();
> -    socket_cleanup_outgoing_migration();
>      qemu_sem_destroy(&multifd_send_state->channels_created);
>      qemu_sem_destroy(&multifd_send_state->channels_ready);
>      g_free(multifd_send_state->params);
> @@ -481,7 +479,7 @@ void multifd_send_shutdown(void)
>  {
>      int i;
>  
> -    if (!migrate_multifd()) {
> +    if (!migrate_multifd() || !multifd_send_state) {
>          return;
>      }
>  
> diff --git a/migration/options.c b/migration/options.c
> index 4db340b502..c4dfe89edd 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -480,11 +480,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>              error_setg(errp, "Postcopy is not compatible with ignore-shared");
>              return false;
>          }
> -
> -        if (new_caps[MIGRATION_CAPABILITY_MULTIFD]) {
> -            error_setg(errp, "Postcopy is not yet compatible with multifd");
> -            return false;
> -        }
>      }
>  
>      if (new_caps[MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT]) {
> diff --git a/migration/ram.c b/migration/ram.c
> index 6f460fd22d..8f22745aba 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1297,7 +1297,7 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
>          pss->page = 0;
>          pss->block = QLIST_NEXT_RCU(pss->block, next);
>          if (!pss->block) {
> -            if (multifd_ram_sync_per_round()) {
> +            if (multifd_ram_sync_per_round() && !migration_in_postcopy()) {
>                  QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
>                  int ret = multifd_ram_flush_and_sync(f);
>                  if (ret < 0) {
> @@ -1971,9 +1971,8 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss)
>          }
>      }
>  
> -    if (migrate_multifd()) {
> -        RAMBlock *block = pss->block;
> -        return ram_save_multifd_page(block, offset);
> +    if (migrate_multifd() && !migration_in_postcopy()) {
> +        return ram_save_multifd_page(pss->block, offset);
>      }
>  
>      if (control_save_page(pss, offset, &res)) {
> --
> 2.48.1
> 
> 


