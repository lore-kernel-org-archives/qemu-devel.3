Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6978CD13C20
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 14:34:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkNex-0007T8-Gb; Mon, 26 Jan 2026 09:33:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vkNem-0007KY-6t
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 09:33:34 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vkNeh-0004NI-4n
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 09:33:29 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 692DC336A2;
 Mon, 26 Jan 2026 14:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769437996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jv3Bl8/Mvc2juIHZouzfg2aSNJhHsVe7RqOTzckp6XY=;
 b=AaA4Nyp1lwuE6hTWH6U8VquXHh+j7IKSQreO/d4gUXAaDhPg29+KFh2G9xrQHp3FZBHpKd
 fffyKeVQBio7YSRRrJuIWRwW4ZYLEzVyslivDH+V+7RreC0X5ZgdT5mQ9aeknjMkYr4qca
 rsHdw4MwiJDhVgeQS3WXG9fU2wfCq/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769437996;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jv3Bl8/Mvc2juIHZouzfg2aSNJhHsVe7RqOTzckp6XY=;
 b=8MGmWiI990pk+bCODJXBgRa+cV15/A8Qvid2xCjnzNeZcgTGJ03r0bNhgXKeUPjtcvsMPY
 QJRv62ai3SUBKYCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769437996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jv3Bl8/Mvc2juIHZouzfg2aSNJhHsVe7RqOTzckp6XY=;
 b=AaA4Nyp1lwuE6hTWH6U8VquXHh+j7IKSQreO/d4gUXAaDhPg29+KFh2G9xrQHp3FZBHpKd
 fffyKeVQBio7YSRRrJuIWRwW4ZYLEzVyslivDH+V+7RreC0X5ZgdT5mQ9aeknjMkYr4qca
 rsHdw4MwiJDhVgeQS3WXG9fU2wfCq/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769437996;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jv3Bl8/Mvc2juIHZouzfg2aSNJhHsVe7RqOTzckp6XY=;
 b=8MGmWiI990pk+bCODJXBgRa+cV15/A8Qvid2xCjnzNeZcgTGJ03r0bNhgXKeUPjtcvsMPY
 QJRv62ai3SUBKYCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D014F139F0;
 Mon, 26 Jan 2026 14:33:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9s4AJCt7d2nXHgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 26 Jan 2026 14:33:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Hailiang
 Zhang <zhanghailiang@xfusion.com>, Markus Armbruster <armbru@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, "Dr. David Alan Gilbert"
 <dave@treblig.org>, Lukas Straub <lukasstraub2@web.de>, Juan Quintela
 <quintela@trasno.org>
Subject: Re: [PATCH v3 04/10] multifd: Add COLO support
In-Reply-To: <20260125-colo_unit_test_multifd-v3-4-ae926ccd8eae@web.de>
References: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
 <20260125-colo_unit_test_multifd-v3-4-ae926ccd8eae@web.de>
Date: Mon, 26 Jan 2026 11:33:13 -0300
Message-ID: <87ms20h2ae.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,web.de];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[12]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com,xfusion.com,fujitsu.com,treblig.org,web.de,trasno.org];
 FREEMAIL_TO(0.00)[web.de,nongnu.org]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
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

> Like in the normal ram_load() path, put the received pages into the
> colo cache and mark the pages in the bitmap so that they will be
> flushed to the guest later.
>



> Multifd with COLO is useful to reduce the VM pause time during checkpointing
> for latency sensitive workloads. In such workloads the worst-case latency
> is especially important.
>
> Also, this is already worth it for the precopy phase as it helps with
> converging. Moreover, multifd migration is the preferred way to do migration
> nowadays and this allows to use multifd compression with COLO.
>
> Benchmark:
> Cluster nodes
>  - Intel Xenon E5-2630 v3
>  - 48Gb RAM
>  - 10G Ethernet
> Guest
>  - Windows Server 2016
>  - 6Gb RAM
>  - 4 cores
> Workload
>  - Upload a file to the guest with SMB to simulate moderate
>    memory dirtying
>  - Measure the memory transfer time portion of each checkpoint
>  - 600ms COLO checkpoint interval
>
> Results
> Plain
>  idle mean: 4.50ms 99per: 10.33ms
>  load mean: 24.30ms 99per: 78.05ms
> Multifd-4
>  idle mean: 6.48ms 99per: 10.41ms
>  load mean: 14.12ms 99per: 31.27ms
>
> Evaluation
> While multifd has slightly higher latency when the guest idles, it is
> 10ms faster under load and more importantly it's worst case latency is
> less than 1/2 of plain under load as can be seen in the 99. Percentile.
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  MAINTAINERS                |  1 +
>  migration/meson.build      |  2 +-
>  migration/multifd-colo.c   | 50 ++++++++++++++++++++++++++++++++++++++++++++++
>  migration/multifd-colo.h   | 26 ++++++++++++++++++++++++
>  migration/multifd-nocomp.c | 10 +++++++++-
>  migration/multifd.c        |  8 ++++++++
>  migration/multifd.h        |  5 ++++-
>  7 files changed, 99 insertions(+), 3 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1e9bdd87c3a2f84f3abfc56986cd793976810fdd..883f0a8f4eb92d0bf0f89fcab4674ccc4aed1cc1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3853,6 +3853,7 @@ COLO Framework
>  M: Lukas Straub <lukasstraub2@web.de>
>  S: Maintained
>  F: migration/colo*
> +F: migration/multifd-colo.*
>  F: include/migration/colo.h
>  F: include/migration/failover.h
>  F: docs/COLO-FT.txt
> diff --git a/migration/meson.build b/migration/meson.build
> index c7f39bdb55239ecb0e775c77b90a1aa9e6a4a9ce..c9f0f5f9f2137536497e53e960ce70654ad1b394 100644
> --- a/migration/meson.build
> +++ b/migration/meson.build
> @@ -39,7 +39,7 @@ system_ss.add(files(
>  ), gnutls, zlib)
>  
>  if get_option('replication').allowed()
> -  system_ss.add(files('colo-failover.c', 'colo.c'))
> +  system_ss.add(files('colo-failover.c', 'colo.c', 'multifd-colo.c'))
>  else
>    system_ss.add(files('colo-stubs.c'))
>  endif
> diff --git a/migration/multifd-colo.c b/migration/multifd-colo.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..c47f5044663969e0c9af56da5ec34902d635810a
> --- /dev/null
> +++ b/migration/multifd-colo.c
> @@ -0,0 +1,50 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * multifd colo implementation
> + *
> + * Copyright (c) Lukas Straub <lukasstraub2@web.de>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "exec/target_page.h"
> +#include "qemu/error-report.h"
> +#include "qapi/error.h"
> +#include "ram.h"
> +#include "multifd.h"
> +#include "options.h"
> +#include "io/channel-socket.h"
> +#include "migration/colo.h"
> +#include "multifd-colo.h"
> +#include "system/ramblock.h"
> +
> +void multifd_colo_prepare_recv(MultiFDRecvParams *p)
> +{
> +    /*
> +     * While we're still in precopy state (not yet in colo state), we copy
> +     * received pages to both guest and cache. No need to set dirty bits,
> +     * since guest and cache memory are in sync.
> +     */
> +    if (migration_incoming_in_colo_state()) {

What's the relationship between migration_incoming_in_colo_state() and
migration_incoming_colo_enabled()? ram_load_precopy() checks both. Would
migration_incoming_colo_enabled affect multifd as well?

The multifd recv threads will be running until after
process_incoming_migration_bh(), which is when
migration_incoming_disable_colo() runs.

Also, is the colo_cache guaranteed to be around until multifd threads
exit?

> +        colo_record_bitmap(p->block, p->normal, p->normal_num);
> +        colo_record_bitmap(p->block, p->zero, p->zero_num);
> +    }
> +}
> +
> +void multifd_colo_process_recv(MultiFDRecvParams *p)
> +{
> +    if (!migration_incoming_in_colo_state()) {
> +        for (int i = 0; i < p->normal_num; i++) {
> +            void *guest = p->block->host + p->normal[i];
> +            void *cache = p->host + p->normal[i];
> +            memcpy(guest, cache, multifd_ram_page_size());
> +        }

I see some differences between what ram.c does and what multifd will do
after this patch regarding which flags are checked and order of copies
(code below):

ram.c:

  - migration_incoming_colo_enabled && migration_incoming_in_colo_state:
  Reads from stream into colo_cache.
  
  - migration_incoming_colo_enabled && !migration_incoming_in_colo_state:
  Reads from stream into guest and then memcpy into colo_cache.

  - !migration_incoming_colo_enabled
  Reads from stream into guest.

multifd.c:

  - migrate_colo:
  Reads from stream into colo_cache.
  
  - !migration_incoming_in_colo_state:
  memcpy from colo_cache into guest.

  - !migration_incoming_colo_enabled
  ???

The resulting state should be the same, but I wonder if we want to i) use
the same checks in multifd and ii) when not in colo state, copy first
into guest (using readv) and later memcpy into the colo_cache.

---
ram.c:

host = host_from_ram_block_offset(block, addr);
if (migration_incoming_colo_enabled()) {
    if (migration_incoming_in_colo_state()) {
        host = colo_cache_from_block_offset(block, addr, true);
    } else {
        host_bak = colo_cache_from_block_offset(block, addr, false);
    }
}
qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
if (host_bak) {
    memcpy(host_bak, host, TARGET_PAGE_SIZE);
}

multifd:

if (migrate_colo()) {
    p->host = p->block->colo_cache;
}

for (int i = 0; i < p->normal_num; i++) {
    p->iov[i].iov_base = p->host + p->normal[i];
}
return qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);

if (!migration_incoming_in_colo_state()) {
    for (int i = 0; i < p->normal_num; i++) {
        void *guest = p->block->host + p->normal[i];
        void *cache = p->host + p->normal[i];
        memcpy(guest, cache, multifd_ram_page_size());
    }
}
---

> +        for (int i = 0; i < p->zero_num; i++) {
> +            void *guest = p->block->host + p->zero[i];
> +            memset(guest, 0, multifd_ram_page_size());
> +        }

At multifd_nocomp_recv, there will be a call to
multifd_recv_zero_page_process(), which by that point will have p->host
== p->block->colo_cache, so it looks like that function will do some
zero page processing in the colo_cache, setting the rb->receivedmap for
pages in the colo_cache and potentially also doing a memcpy. Is this
intended?

I'm thinking that maybe it would overall be better to hook colo directly
in to multifd_nocomp_recv:

static int multifd_nocomp_recv(MultiFDRecvParams *p, Error **errp)
{
    uint32_t flags;

    if (migrate_mapped_ram()) {
        return multifd_file_recv_data(p, errp);
    }

    flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;

    if (flags != MULTIFD_FLAG_NOCOMP) {
        error_setg(errp, "multifd %u: flags received %x flags expected %x",
                   p->id, flags, MULTIFD_FLAG_NOCOMP);
        return -1;
    }

+    if (migration_incoming_colo_enabled() && migration_incoming_in_colo_state()) {
+        p->host = p->block->colo_cache;
+    } // or else{}, depending on how deal with zero pages in the cache

    multifd_recv_zero_page_process(p);

    if (!p->normal_num) {
        return 0;
    }

    for (int i = 0; i < p->normal_num; i++) {
        p->iov[i].iov_base = p->host + p->normal[i];
        p->iov[i].iov_len = multifd_ram_page_size();
        ramblock_recv_bitmap_set_offset(p->block, p->normal[i]);
    }
+    ret = qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
+    if (ret != 0) {
+        return ret;
+    }
+
+    if (migration_incoming_colo_enabled()) {
+        multifd_colo_process_recv();
+    }

    return ret;
}


> +    }
> +}
> diff --git a/migration/multifd-colo.h b/migration/multifd-colo.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..82eaf3f48c47de2f090f9de52f9d57a337d4754a
> --- /dev/null
> +++ b/migration/multifd-colo.h
> @@ -0,0 +1,26 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * multifd colo header
> + *
> + * Copyright (c) Lukas Straub <lukasstraub2@web.de>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef QEMU_MIGRATION_MULTIFD_COLO_H
> +#define QEMU_MIGRATION_MULTIFD_COLO_H
> +
> +#ifdef CONFIG_REPLICATION
> +
> +void multifd_colo_prepare_recv(MultiFDRecvParams *p);
> +void multifd_colo_process_recv(MultiFDRecvParams *p);
> +
> +#else
> +
> +static inline void multifd_colo_prepare_recv(MultiFDRecvParams *p) {}
> +static inline void multifd_colo_process_recv(MultiFDRecvParams *p) {}
> +
> +#endif
> +#endif
> diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
> index 9be79b3b8e00371ebff9e112766c225bec260bf7..9f7a792fa761b3bc30b971b35f464103a61787f0 100644
> --- a/migration/multifd-nocomp.c
> +++ b/migration/multifd-nocomp.c
> @@ -16,6 +16,7 @@
>  #include "file.h"
>  #include "migration-stats.h"
>  #include "multifd.h"
> +#include "multifd-colo.h"
>  #include "options.h"
>  #include "migration.h"
>  #include "qapi/error.h"
> @@ -269,7 +270,6 @@ int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp)
>          return -1;
>      }
>  
> -    p->host = p->block->host;
>      for (i = 0; i < p->normal_num; i++) {
>          uint64_t offset = be64_to_cpu(packet->offset[i]);
>  
> @@ -294,6 +294,14 @@ int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp)
>          p->zero[i] = offset;
>      }
>  
> +    if (migrate_colo()) {
> +        multifd_colo_prepare_recv(p);
> +        assert(p->block->colo_cache);
> +        p->host = p->block->colo_cache;

Can't you just use p->block->colo_cache later? I don't see why p->host
needs to be set beforehand even in the non-colo case.

> +    } else {
> +        p->host = p->block->host;
> +    }
> +
>      return 0;
>  }
>  
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 332e6fc58053462419f3171f6c320ac37648ef7b..220ed8564960fdabc58e4baa069dd252c8ad293c 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -29,6 +29,7 @@
>  #include "qemu-file.h"
>  #include "trace.h"
>  #include "multifd.h"
> +#include "multifd-colo.h"
>  #include "options.h"
>  #include "qemu/yank.h"
>  #include "io/channel-file.h"
> @@ -1258,6 +1259,13 @@ static int multifd_ram_state_recv(MultiFDRecvParams *p, Error **errp)
>      int ret;
>  
>      ret = multifd_recv_state->ops->recv(p, errp);
> +    if (ret != 0) {
> +        return ret;
> +    }
> +
> +    if (migrate_colo()) {
> +        multifd_colo_process_recv(p);
> +    }

Either put all of colo hooks in multifd.c or multifd-nocomp.c. I think
the latter is more appropriate as we have mapped_ram already in
there. Let's drop patch 3 and put this in multifd_nocomp_recv().

>  
>      return ret;
>  }
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 89a395aef2b09a6762c45b5361e0ab63256feff6..fbc35702b062fdc3213ce92baed35994f5967c2b 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -279,7 +279,10 @@ typedef struct {
>      uint64_t packets_recved;
>      /* ramblock */
>      RAMBlock *block;
> -    /* ramblock host address */
> +    /*
> +     * Normally, it points to ramblock's host address.  When COLO
> +     * is enabled, it points to the mirror cache for the ramblock.
> +     */
>      uint8_t *host;
>      /* buffers to recv */
>      struct iovec *iov;

