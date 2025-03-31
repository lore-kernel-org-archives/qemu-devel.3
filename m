Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE919C3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 15:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzH37-0001Zx-Sx; Mon, 31 Mar 2025 11:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tzH34-0001Zc-Ep
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 11:27:38 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tzH32-0000AX-Al
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 11:27:38 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 20D361F456;
 Mon, 31 Mar 2025 15:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743434854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O1oKdd3nxmkzYEV45rQVvD1036/o99blo4V9a5FEnZo=;
 b=HvnyNqbT064pwGFdCcw51CUbQEQz8ZYZSlWJ3516wwt7q9CnxPbf2ypT66rw1K3HQcjxZS
 eev/Aa82NHgms0uQ++Nu2pJw6999KSsSvdiaSo1i9d9G4OtEI2jKYyd4ZUZhqBoLql55sH
 8PA/87DaehTnMjs/riD2WGO1YLh3DrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743434854;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O1oKdd3nxmkzYEV45rQVvD1036/o99blo4V9a5FEnZo=;
 b=A7w+/uZ+VmJC6UOCiKW+ymqiJc4CcWNQ5alq7GDfiwc9B9oK+SBr6Vg1o+XelLMmfTdhxd
 /B1R0xsMacohWXAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HvnyNqbT;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="A7w+/uZ+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743434854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O1oKdd3nxmkzYEV45rQVvD1036/o99blo4V9a5FEnZo=;
 b=HvnyNqbT064pwGFdCcw51CUbQEQz8ZYZSlWJ3516wwt7q9CnxPbf2ypT66rw1K3HQcjxZS
 eev/Aa82NHgms0uQ++Nu2pJw6999KSsSvdiaSo1i9d9G4OtEI2jKYyd4ZUZhqBoLql55sH
 8PA/87DaehTnMjs/riD2WGO1YLh3DrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743434854;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O1oKdd3nxmkzYEV45rQVvD1036/o99blo4V9a5FEnZo=;
 b=A7w+/uZ+VmJC6UOCiKW+ymqiJc4CcWNQ5alq7GDfiwc9B9oK+SBr6Vg1o+XelLMmfTdhxd
 /B1R0xsMacohWXAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 902FD13A1F;
 Mon, 31 Mar 2025 15:27:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JjbdE2W06mdgSwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 31 Mar 2025 15:27:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, berrange@redhat.com, Prasad Pandit
 <pjp@fedoraproject.org>
Subject: Re: [PATCH v8 3/7] migration: enable multifd and postcopy together
In-Reply-To: <20250318123846.1370312-4-ppandit@redhat.com>
References: <20250318123846.1370312-1-ppandit@redhat.com>
 <20250318123846.1370312-4-ppandit@redhat.com>
Date: Mon, 31 Mar 2025 12:27:30 -0300
Message-ID: <87o6xhkyot.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 20D361F456
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

Prasad Pandit <ppandit@redhat.com> writes:

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
> to the Postcopy phase, the multifd threads cease
> to send data on multifd channels and Postcopy
> threads on the destination request/pull data from
> the source side.
>
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> ---
>  migration/multifd-nocomp.c | 3 ++-
>  migration/multifd.c        | 7 +++++++
>  migration/options.c        | 5 -----
>  migration/ram.c            | 7 +++----
>  4 files changed, 12 insertions(+), 10 deletions(-)
>
> v8:
> - Separate this patch out from earlier patch-2.
>
> v7:
> - https://lore.kernel.org/qemu-devel/20250228121749.553184-1-ppandit@redhat.com/T/#t
>
> diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
> index ffe75256c9..02f8bf8ce8 100644
> --- a/migration/multifd-nocomp.c
> +++ b/migration/multifd-nocomp.c
> @@ -17,6 +17,7 @@
>  #include "migration-stats.h"
>  #include "multifd.h"
>  #include "options.h"
> +#include "migration.h"
>  #include "qapi/error.h"
>  #include "qemu/cutils.h"
>  #include "qemu/error-report.h"
> @@ -399,7 +400,7 @@ int multifd_ram_flush_and_sync(QEMUFile *f)
>      MultiFDSyncReq req;
>      int ret;
>  
> -    if (!migrate_multifd()) {
> +    if (!migrate_multifd() || migration_in_postcopy()) {
>          return 0;
>      }
>  
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 6139cabe44..074d16d07d 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -1379,6 +1379,13 @@ static void *multifd_recv_thread(void *opaque)
>          }
>  
>          if (has_data) {
> +            /*
> +             * multifd thread should not be active and receive data
> +             * when migration is in the Postcopy phase. Two threads
> +             * writing the same memory area could easily corrupt
> +             * the guest state.
> +             */
> +            assert(!migration_in_postcopy());
>              if (is_device_state) {
>                  assert(use_packets);
>                  ret = multifd_device_state_recv(p, &local_err);
> diff --git a/migration/options.c b/migration/options.c
> index b0ac2ea408..48aa6076de 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -491,11 +491,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
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
> index 424df6d9f1..6fd88cbf2a 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1297,7 +1297,7 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
>          pss->page = 0;
>          pss->block = QLIST_NEXT_RCU(pss->block, next);
>          if (!pss->block) {
> -            if (multifd_ram_sync_per_round()) {
> +            if (multifd_ram_sync_per_round() && !migration_in_postcopy()) {

I'd rather not put this check here. multifd_ram_flush_and_sync() will
already return 0 if in postcopy.

>                  QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
>                  int ret = multifd_ram_flush_and_sync(f);
>                  if (ret < 0) {
> @@ -1976,9 +1976,8 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss)
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
>      return ram_save_page(rs, pss);

