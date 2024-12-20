Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF398E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 13:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOcjt-0004WZ-LI; Fri, 20 Dec 2024 08:08:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tOcjr-0004WM-P1; Fri, 20 Dec 2024 08:08:19 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tOcjq-0004n9-0P; Fri, 20 Dec 2024 08:08:19 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AFD7C1F456;
 Fri, 20 Dec 2024 13:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734700093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=75FRap8mgsecJQbUHcEtp4Kt+k+cGrFCtu0z/TAZ4GU=;
 b=LkqK+foyGOt/vTHoo3CEpn5pmLNzeRtCjNRJVXNY2SYCGOu7ta6OQ8D62MosbOseA5NrHk
 SpoUDDooyzJVHDEBLY9F6PQHfi9EEzgPX2AFgJnZ/ulnW5sk+MPoffq9eSRx0XS5LfBtKg
 RoTGod/4ZNIpPAHxENUBagmFad0EXe4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734700093;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=75FRap8mgsecJQbUHcEtp4Kt+k+cGrFCtu0z/TAZ4GU=;
 b=2OUDEmbej+pDy8s9Libr9ElR9YPU8JRDrzrwRQAKOVCDCoFs33f6KmIRWpIVS6tUZzqU6a
 Q8LK1KtW9SqSa5Dw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LkqK+foy;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2OUDEmbe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734700093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=75FRap8mgsecJQbUHcEtp4Kt+k+cGrFCtu0z/TAZ4GU=;
 b=LkqK+foyGOt/vTHoo3CEpn5pmLNzeRtCjNRJVXNY2SYCGOu7ta6OQ8D62MosbOseA5NrHk
 SpoUDDooyzJVHDEBLY9F6PQHfi9EEzgPX2AFgJnZ/ulnW5sk+MPoffq9eSRx0XS5LfBtKg
 RoTGod/4ZNIpPAHxENUBagmFad0EXe4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734700093;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=75FRap8mgsecJQbUHcEtp4Kt+k+cGrFCtu0z/TAZ4GU=;
 b=2OUDEmbej+pDy8s9Libr9ElR9YPU8JRDrzrwRQAKOVCDCoFs33f6KmIRWpIVS6tUZzqU6a
 Q8LK1KtW9SqSa5Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34ED113A63;
 Fri, 20 Dec 2024 13:08:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3Ii/OTxsZWfgMwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 20 Dec 2024 13:08:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org, Alex
 =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Paolo
 Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam
 Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, John
 Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>, Peter Xu <peterx@redhat.com>, "Dr. David Alan
 Gilbert" <dave@treblig.org>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Wainer dos Santos Moschetta
 <wainersm@redhat.com>
Subject: Re: [PATCH 02/17] replay: Fix migration replay_mutex locking
In-Reply-To: <20241220104220.2007786-3-npiggin@gmail.com>
References: <20241220104220.2007786-1-npiggin@gmail.com>
 <20241220104220.2007786-3-npiggin@gmail.com>
Date: Fri, 20 Dec 2024 10:08:10 -0300
Message-ID: <87r062tscl.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: AFD7C1F456
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_TO(0.00)[gmail.com,nongnu.org]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[21];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_CC(0.00)[gmail.com,nongnu.org,linaro.org,redhat.com,ispras.ru,euphon.net,yandex-team.ru,treblig.org,amd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:mid, suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Nicholas Piggin <npiggin@gmail.com> writes:

Hi Nick,

I'm ignorant about replay, but we try to know why were taking the BQL in
the migration code, we move it around sometimes, etc. Can we be a bit
more strict with documentation here so we don't get stuck with a lock
that can't be changed?

> Migration causes a number of events that need to go in the replay
> trace, such as vm state transitions. The replay_mutex lock needs to
> be held for these.
>

Is it practical to explicitly list which events are those?

Are there any tests that exercise this that we could use to validate
changes around this area?

> The simplest approach seems to be just take it up-front when taking
> the bql.

But also the thing asserts if taken inside the BQL, so is the actual
matter here that we _cannot_ take the lock around the proper places?

I also see the replay lock around the main loop, so is it basically bql2
from the perspective of most of QEMU?

>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  migration/migration.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 2eb9e50a263..277fca954c1 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -24,6 +24,7 @@
>  #include "socket.h"
>  #include "sysemu/runstate.h"
>  #include "sysemu/sysemu.h"
> +#include "sysemu/replay.h"
>  #include "sysemu/cpu-throttle.h"
>  #include "rdma.h"
>  #include "ram.h"
> @@ -2518,6 +2519,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>      }
>  
>      trace_postcopy_start();
> +    replay_mutex_lock();
>      bql_lock();
>      trace_postcopy_start_set_run();
>  
> @@ -2629,6 +2631,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>      migration_downtime_end(ms);
>  
>      bql_unlock();
> +    replay_mutex_unlock();
>  
>      if (migrate_postcopy_ram()) {
>          /*
> @@ -2670,6 +2673,7 @@ fail:
>      }
>      migration_call_notifiers(ms, MIG_EVENT_PRECOPY_FAILED, NULL);
>      bql_unlock();
> +    replay_mutex_unlock();
>      return -1;
>  }
>  
> @@ -2721,6 +2725,7 @@ static int migration_completion_precopy(MigrationState *s,
>  {
>      int ret;
>  
> +    replay_mutex_lock();
>      bql_lock();
>  
>      if (!migrate_mode_is_cpr(s)) {
> @@ -2746,6 +2751,7 @@ static int migration_completion_precopy(MigrationState *s,
>                                               s->block_inactive);
>  out_unlock:
>      bql_unlock();
> +    replay_mutex_unlock();
>      return ret;
>  }
>  
> @@ -3633,6 +3639,7 @@ static void *bg_migration_thread(void *opaque)
>  
>      trace_migration_thread_setup_complete();
>  
> +    replay_mutex_lock();
>      bql_lock();
>  
>      if (migration_stop_vm(s, RUN_STATE_PAUSED)) {
> @@ -3666,6 +3673,7 @@ static void *bg_migration_thread(void *opaque)
>       */
>      migration_bh_schedule(bg_migration_vm_start_bh, s);
>      bql_unlock();
> +    replay_mutex_unlock();
>  
>      while (migration_is_active()) {
>          MigIterateState iter_state = bg_migration_iteration_run(s);
> @@ -3695,6 +3703,7 @@ fail:
>          migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
>                  MIGRATION_STATUS_FAILED);
>          bql_unlock();
> +        replay_mutex_unlock();
>      }
>  
>  fail_setup:

