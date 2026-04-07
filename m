Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5237CFF5135
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABUt-0006mB-Pk; Tue, 07 Apr 2026 14:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1wABTf-0003uc-5h
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:48:44 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1wA58g-0004D0-7o
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 08:02:40 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ECBC94E436;
 Tue,  7 Apr 2026 12:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775563350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v1NqMuz2A400tAznsQF/Faoy7q3XPRoyNI87TXSiLac=;
 b=xVoEON3eDM9HIQTmNYbH3VobLo4Yo+Ql9zO7vZ8OZLGP6FefUk59rr85JrcPyyfI2Y8s0+
 13VcyKIuPPkiCh/mKoFOrzfyZYjA3gdPmVlGnR57N8VRPUt+Rh/pz0pzUQz4ZBY9DhHSya
 dJOMOIASqRPqKygZJ3tw9r06cmm7qXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775563350;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v1NqMuz2A400tAznsQF/Faoy7q3XPRoyNI87TXSiLac=;
 b=4zYeVi5VgyCd0OVz729CZA/pHJsXqeedE/UiB36MrH41FdTLdh2RdT8pD7/li9Hn3tk35L
 uhhFZQMGkwrlL9Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775563345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v1NqMuz2A400tAznsQF/Faoy7q3XPRoyNI87TXSiLac=;
 b=WEHqTy5mTg3LpCR/wxedyZUPTQTASOSKsKQKymY1tfkgxnKgtbGB7mB8PIMQcL+quMd3AE
 s2MKfS+q3vrAc8JLjdd8YVUOlltqILoIGAtN2ldhKIISSRG5GkpFN7yCO7+IbTfTSl++Gt
 FsCWtj0Ar4PrGJcBaK1WW6XjPJjs8G0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775563345;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v1NqMuz2A400tAznsQF/Faoy7q3XPRoyNI87TXSiLac=;
 b=Up5R5X3bou7tLLpef3ci/r8kCbMhv530Shdd6NrBb5ncSvGzCqQ3ZO/5Qh8C6uzYpl9bRD
 QUQ+sklJzbb99MAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7F644A0B0;
 Tue,  7 Apr 2026 12:02:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eRcAJlHy1Gk2eQAAD6G6ig
 (envelope-from <cfontana@suse.de>); Tue, 07 Apr 2026 12:02:25 +0000
Message-ID: <043e3410-9a58-4102-86a2-177579b63add@suse.de>
Date: Tue, 7 Apr 2026 14:02:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] migration: track timing and received pages in
 MigrationIncomingState
To: Trieu Huynh <vikingtc4@gmail.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
References: <20260405152612.93027-1-viking4@gmail.com>
 <20260405152612.93027-2-viking4@gmail.com>
Content-Language: en-US
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <20260405152612.93027-2-viking4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=cfontana@suse.de; helo=smtp-out1.suse.de
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

Hello,

On 4/5/26 17:26, Trieu Huynh wrote:
> From: Trieu Huynh <vikingtc4@gmail.com>
> 
> Add start_time, total_time, received_normal_pages,
> received_zero_pages, and received_xbzrle_pages to
> MigrationIncomingState.
> 
> start_time is recorded when the incoming state transitions to ACTIVE;
> total_time is recorded when it transitions to COMPLETED. The page
> counters are incremented in ram_load_precopy() as each page type is
> received from the source.
> 
> These fields will be used by a subsequent patch to populate
> fill_destination_migration_info() for the migration COMPLETED case.
> 
> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> ---
>  migration/migration.c |  2 ++
>  migration/migration.h | 17 +++++++++++++++++
>  migration/ram.c       |  3 +++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 5c9aaa6e58..17c9a8b344 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -726,6 +726,7 @@ static void process_incoming_migration_bh(void *opaque)
>       */
>      migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
>                        MIGRATION_STATUS_COMPLETED);
> +    mis->total_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - mis->start_time;
>      migration_incoming_state_destroy();
>  }
>  
> @@ -758,6 +759,7 @@ process_incoming_migration_co(void *opaque)
>      migrate_set_state(&mis->state, MIGRATION_STATUS_SETUP,
>                        MIGRATION_STATUS_ACTIVE);
>  
> +    mis->start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>      mis->loadvm_co = qemu_coroutine_self();
>      ret = qemu_loadvm_state(mis->from_src_file, &local_err);
>      mis->loadvm_co = NULL;
> diff --git a/migration/migration.h b/migration/migration.h
> index b6888daced..cd51ae452c 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -176,6 +176,23 @@ struct MigrationIncomingState {
>      /* PostCopyFD's for external userfaultfds & handlers of shared memory */
>      GArray   *postcopy_remote_fds;
>  
> +    /*
> +     * Timestamps for reporting migration duration via query-migrate on the
> +     * destination. start_time is recorded when the state moves to ACTIVE;
> +     * total_time is recorded when it moves to COMPLETED.
> +     */
> +    int64_t start_time;
> +    int64_t total_time;

nit: since this is a timestamp and these are directly linked to state changes,
why not call these:

int64_t migration_active_ts;
int64_t migration_completed_ts;

or something similar?

Thank you,

Claudio

> +
> +    /*
> +     * Page counters for reporting RAM statistics via query-migrate on the
> +     * destination.  Incremented in ram_load_precopy() as each page type
> +     * is received.
> +     */
> +    uint64_t received_normal_pages;
> +    uint64_t received_zero_pages;
> +    uint64_t received_xbzrle_pages;
> +
>      MigrationStatus state;
>  
>      /*
> diff --git a/migration/ram.c b/migration/ram.c
> index 979751f61b..6646e5daad 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -4417,10 +4417,12 @@ static int ram_load_precopy(QEMUFile *f)
>                  break;
>              }
>              ram_handle_zero(host, TARGET_PAGE_SIZE);
> +            mis->received_zero_pages++;
>              break;
>  
>          case RAM_SAVE_FLAG_PAGE:
>              qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
> +            mis->received_normal_pages++;
>              break;
>  
>          case RAM_SAVE_FLAG_XBZRLE:
> @@ -4430,6 +4432,7 @@ static int ram_load_precopy(QEMUFile *f)
>                  ret = -EINVAL;
>                  break;
>              }
> +            mis->received_xbzrle_pages++;
>              break;
>          case RAM_SAVE_FLAG_MULTIFD_FLUSH:
>              multifd_recv_sync_main();


