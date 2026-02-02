Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03E9E7DEE3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 14:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmv8T-00034d-R3; Mon, 02 Feb 2026 09:42:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vmv8R-00034T-TX
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 09:42:39 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vmv8Q-0001EG-86
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 09:42:39 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A77143E73A;
 Mon,  2 Feb 2026 14:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770043356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tbdDuS+VzcIW25EIwFLmj7u+THyTJTqXVGnHc6b+9XY=;
 b=hJYKbzdmXNXoiN+3tRQovLGodx6wGEKoZbDcwzIlW1YcO/NMMSuDctV9o6y6PbY9oH+hZ1
 ZPn6tbXbo/iJjVHZzVs6FQvgkdvPya7pS2zuWPUaxrP+5NZXn39KFpoAM9yn5N1KZVQebW
 AeusvOcOzHGYuzm1Yjidr3GkoR90HlE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770043356;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tbdDuS+VzcIW25EIwFLmj7u+THyTJTqXVGnHc6b+9XY=;
 b=DEm/xPvXytNqkBWXXKHUb4n2e/nVmNC2/ky/QDQw+ra4Cam98I/l/QDP75QizDs6BRyLNt
 6RZkLxfA4bvR6rBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770043356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tbdDuS+VzcIW25EIwFLmj7u+THyTJTqXVGnHc6b+9XY=;
 b=hJYKbzdmXNXoiN+3tRQovLGodx6wGEKoZbDcwzIlW1YcO/NMMSuDctV9o6y6PbY9oH+hZ1
 ZPn6tbXbo/iJjVHZzVs6FQvgkdvPya7pS2zuWPUaxrP+5NZXn39KFpoAM9yn5N1KZVQebW
 AeusvOcOzHGYuzm1Yjidr3GkoR90HlE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770043356;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tbdDuS+VzcIW25EIwFLmj7u+THyTJTqXVGnHc6b+9XY=;
 b=DEm/xPvXytNqkBWXXKHUb4n2e/nVmNC2/ky/QDQw+ra4Cam98I/l/QDP75QizDs6BRyLNt
 6RZkLxfA4bvR6rBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E7043EA62;
 Mon,  2 Feb 2026 14:42:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id l9V2NNu3gGnlQwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 02 Feb 2026 14:42:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Hailiang
 Zhang <zhanghailiang@xfusion.com>, Markus Armbruster <armbru@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, "Dr. David Alan Gilbert"
 <dave@treblig.org>, Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH v4 05/16] colo: Remove ENABLE_COLO loadvm command functions
In-Reply-To: <20260130-colo_unit_test_multifd-v4-5-7115ab6f0e77@web.de>
References: <20260130-colo_unit_test_multifd-v4-0-7115ab6f0e77@web.de>
 <20260130-colo_unit_test_multifd-v4-5-7115ab6f0e77@web.de>
Date: Mon, 02 Feb 2026 11:42:33 -0300
Message-ID: <87ldhbryue.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,web.de]; RCVD_TLS_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[web.de,nongnu.org];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com,xfusion.com,fujitsu.com,treblig.org,web.de];
 RCPT_COUNT_SEVEN(0.00)[11]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
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

Lukas Straub <lukasstraub2@web.de> writes:

> No need for it anymore now that x-colo capability is required
> on incoming side.
>
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  include/migration/colo.h |  2 --
>  migration/migration.c    | 26 --------------------------
>  migration/savevm.c       | 10 ----------
>  3 files changed, 38 deletions(-)
>
> diff --git a/include/migration/colo.h b/include/migration/colo.h
> index 2496a968cc1ce709f706c0efe57e4f765f163d3c..8f94054a10760d0f2598f080643f45f9944cf051 100644
> --- a/include/migration/colo.h
> +++ b/include/migration/colo.h
> @@ -25,8 +25,6 @@ void migrate_start_colo_process(MigrationState *s);
>  bool migration_in_colo_state(void);
>  
>  /* loadvm */
> -int migration_incoming_enable_colo(Error **errp);
> -void migration_incoming_disable_colo(void);
>  bool migration_incoming_in_colo_state(void);
>  
>  COLOMode get_colo_mode(void);
> diff --git a/migration/migration.c b/migration/migration.c
> index bc8ce64ff5000b0eb634a20b22e5f3e3289b9707..3f3fc5276bb067ae1960e4b675b33208ad641b23 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -604,31 +604,6 @@ int migrate_send_rp_req_pages(MigrationIncomingState *mis,
>      return migrate_send_rp_message_req_pages(mis, rb, start);
>  }
>  
> -static bool migration_colo_enabled;
> -void migration_incoming_disable_colo(void)
> -{
> -    ram_block_discard_disable(false);
> -    migration_colo_enabled = false;
> -}
> -
> -int migration_incoming_enable_colo(Error **errp)
> -{
> -#ifndef CONFIG_REPLICATION
> -    error_setg(errp, "ENABLE_COLO command come in migration stream, but the "
> -               "replication module is not built in");
> -    return -ENOTSUP;
> -#endif
> -
> -    if (!migrate_colo()) {
> -        error_setg(errp, "ENABLE_COLO command come in migration stream"
> -                   ", but x-colo capability is not set");
> -        return -EINVAL;
> -    }
> -
> -    migration_colo_enabled = true;
> -    return 0;
> -}
> -
>  void migrate_add_address(SocketAddress *address)
>  {
>      MigrationIncomingState *mis = migration_incoming_get_current();
> @@ -735,7 +710,6 @@ static void process_incoming_migration_bh(void *opaque)
>              runstate_set(RUN_STATE_PAUSED);
>          }
>      } else if (migrate_colo()) {
> -        migration_incoming_disable_colo();
>          vm_start();
>      } else {
>          runstate_set(global_state_get_runstate());
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 0353ac2d0de819b6547a1f771e6a4c3b8fb1e4ef..413688b75f4bee6cb10878eb51886cf6ba14872d 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2403,13 +2403,6 @@ static int loadvm_handle_recv_bitmap(MigrationIncomingState *mis,
>      return 0;
>  }
>  
> -static int loadvm_process_enable_colo(MigrationIncomingState *mis,
> -                                      Error **errp)
> -{
> -    ERRP_GUARD();
> -    return migration_incoming_enable_colo(errp);
> -}
> -
>  static int loadvm_postcopy_handle_switchover_start(Error **errp)
>  {
>      SaveStateEntry *se;
> @@ -2528,9 +2521,6 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
>      case MIG_CMD_RECV_BITMAP:
>          return loadvm_handle_recv_bitmap(mis, len, errp);
>  
> -    case MIG_CMD_ENABLE_COLO:
> -        return loadvm_process_enable_colo(mis, errp);
> -
>      case MIG_CMD_SWITCHOVER_START:
>          return loadvm_postcopy_handle_switchover_start(errp);
>      }

Reviewed-by: Fabiano Rosas <farosas@suse.de>

