Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BCBC48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 21:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rW0hF-0005kg-EM; Fri, 02 Feb 2024 16:03:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rW0hE-0005jr-4S
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 16:03:36 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rW0hC-0005s6-E9
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 16:03:35 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 916391FD3B;
 Fri,  2 Feb 2024 21:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706907812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r1PZlOjXMRZOp8LP/EeUkmQKUWeo+ZlSv8VSpViX8ac=;
 b=KhI6C7Vet8ft66k24YHTmYQ2rGE8O25mxMDX8kthghASNhMOGDDT2rMhyX8ZSH/ziGBRuG
 bwh6TzFAmHeRA2vArHPVEQge3GASIpDNv4CY/53KbVBP0ZKBzFAFYfEifmfy5Ldwo8AEAp
 +9vxUO/yBnneAWXX6m9fZnsB2+d2PxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706907812;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r1PZlOjXMRZOp8LP/EeUkmQKUWeo+ZlSv8VSpViX8ac=;
 b=cQnZEQZXZEj93OqVVcoNxmN0Dp5VC2+hc/jD77zgwmug6/Y1nEjDSfBw6hIzKJwh2KdkrN
 Ig8h+BvlENcUi7Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706907812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r1PZlOjXMRZOp8LP/EeUkmQKUWeo+ZlSv8VSpViX8ac=;
 b=KhI6C7Vet8ft66k24YHTmYQ2rGE8O25mxMDX8kthghASNhMOGDDT2rMhyX8ZSH/ziGBRuG
 bwh6TzFAmHeRA2vArHPVEQge3GASIpDNv4CY/53KbVBP0ZKBzFAFYfEifmfy5Ldwo8AEAp
 +9vxUO/yBnneAWXX6m9fZnsB2+d2PxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706907812;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r1PZlOjXMRZOp8LP/EeUkmQKUWeo+ZlSv8VSpViX8ac=;
 b=cQnZEQZXZEj93OqVVcoNxmN0Dp5VC2+hc/jD77zgwmug6/Y1nEjDSfBw6hIzKJwh2KdkrN
 Ig8h+BvlENcUi7Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A81A139AB;
 Fri,  2 Feb 2024 21:03:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fyzENKNYvWUSewAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 02 Feb 2024 21:03:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>, Bryan Zhang
 <bryan.zhang@bytedance.com>, peterx@redhat.com, Avihai Horon
 <avihaih@nvidia.com>, Yuan Liu <yuan1.liu@intel.com>, Prasad Pandit
 <ppandit@redhat.com>
Subject: Re: [PATCH v2 21/23] migration/multifd: Stick with send/recv on
 function names
In-Reply-To: <20240202102857.110210-22-peterx@redhat.com>
References: <20240202102857.110210-1-peterx@redhat.com>
 <20240202102857.110210-22-peterx@redhat.com>
Date: Fri, 02 Feb 2024 18:03:29 -0300
Message-ID: <8734uah93y.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

peterx@redhat.com writes:

> From: Peter Xu <peterx@redhat.com>
>
> Most of the multifd code uses send/recv to represent the two sides, but
> some rare cases use save/load.
>
> Since send/recv is the majority, replacing the save/load use cases to use
> send/recv globally.  Now we reach a consensus on the naming.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Good!

Reviewed-by: Fabiano Rosas <farosas@suse.de>

> ---
>  migration/multifd.h   | 10 +++++-----
>  migration/migration.c | 12 ++++++------
>  migration/multifd.c   | 10 +++++-----
>  3 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/migration/multifd.h b/migration/multifd.h
> index a320c53a6f..9b40a53cb6 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -13,11 +13,11 @@
>  #ifndef QEMU_MIGRATION_MULTIFD_H
>  #define QEMU_MIGRATION_MULTIFD_H
>  
> -int multifd_save_setup(Error **errp);
> -void multifd_save_cleanup(void);
> -int multifd_load_setup(Error **errp);
> -void multifd_load_cleanup(void);
> -void multifd_load_shutdown(void);
> +int multifd_send_setup(Error **errp);
> +void multifd_send_shutdown(void);
> +int multifd_recv_setup(Error **errp);
> +void multifd_recv_cleanup(void);
> +void multifd_recv_shutdown(void);
>  bool multifd_recv_all_channels_created(void);
>  void multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
>  void multifd_recv_sync_main(void);
> diff --git a/migration/migration.c b/migration/migration.c
> index d5f705ceef..ba99772e76 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -311,7 +311,7 @@ void migration_incoming_state_destroy(void)
>  {
>      struct MigrationIncomingState *mis = migration_incoming_get_current();
>  
> -    multifd_load_cleanup();
> +    multifd_recv_cleanup();
>      compress_threads_load_cleanup();
>  
>      if (mis->to_src_file) {
> @@ -662,7 +662,7 @@ static void process_incoming_migration_bh(void *opaque)
>  
>      trace_vmstate_downtime_checkpoint("dst-precopy-bh-announced");
>  
> -    multifd_load_shutdown();
> +    multifd_recv_shutdown();
>  
>      dirty_bitmap_mig_before_vm_start();
>  
> @@ -759,7 +759,7 @@ fail:
>                        MIGRATION_STATUS_FAILED);
>      qemu_fclose(mis->from_src_file);
>  
> -    multifd_load_cleanup();
> +    multifd_recv_cleanup();
>      compress_threads_load_cleanup();
>  
>      exit(EXIT_FAILURE);
> @@ -885,7 +885,7 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>          default_channel = !mis->from_src_file;
>      }
>  
> -    if (multifd_load_setup(errp) != 0) {
> +    if (multifd_recv_setup(errp) != 0) {
>          return;
>      }
>  
> @@ -1331,7 +1331,7 @@ static void migrate_fd_cleanup(MigrationState *s)
>          }
>          bql_lock();
>  
> -        multifd_save_cleanup();
> +        multifd_send_shutdown();
>          qemu_mutex_lock(&s->qemu_file_lock);
>          tmp = s->to_dst_file;
>          s->to_dst_file = NULL;
> @@ -3623,7 +3623,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>          return;
>      }
>  
> -    if (multifd_save_setup(&local_err) != 0) {
> +    if (multifd_send_setup(&local_err) != 0) {
>          migrate_set_error(s, local_err);
>          error_report_err(local_err);
>          migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
> diff --git a/migration/multifd.c b/migration/multifd.c
> index e2dd2f6e04..130f86a1fb 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -663,7 +663,7 @@ static void multifd_send_cleanup_state(void)
>      multifd_send_state = NULL;
>  }
>  
> -void multifd_save_cleanup(void)
> +void multifd_send_shutdown(void)
>  {
>      int i;
>  
> @@ -965,7 +965,7 @@ static void multifd_new_send_channel_create(gpointer opaque)
>      socket_send_channel_create(multifd_new_send_channel_async, opaque);
>  }
>  
> -int multifd_save_setup(Error **errp)
> +int multifd_send_setup(Error **errp)
>  {
>      int thread_count;
>      uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
> @@ -1063,7 +1063,7 @@ static void multifd_recv_terminate_threads(Error *err)
>      }
>  }
>  
> -void multifd_load_shutdown(void)
> +void multifd_recv_shutdown(void)
>  {
>      if (migrate_multifd()) {
>          multifd_recv_terminate_threads(NULL);
> @@ -1098,7 +1098,7 @@ static void multifd_recv_cleanup_state(void)
>      multifd_recv_state = NULL;
>  }
>  
> -void multifd_load_cleanup(void)
> +void multifd_recv_cleanup(void)
>  {
>      int i;
>  
> @@ -1213,7 +1213,7 @@ static void *multifd_recv_thread(void *opaque)
>      return NULL;
>  }
>  
> -int multifd_load_setup(Error **errp)
> +int multifd_recv_setup(Error **errp)
>  {
>      int thread_count;
>      uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();

