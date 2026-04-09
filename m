Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E386FF364C8
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 22:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAxkh-0008PF-E5; Thu, 09 Apr 2026 18:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wAxke-0008Oo-Ij
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 18:21:28 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wAxkc-0003ns-LD
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 18:21:28 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3781F5BCF6;
 Thu,  9 Apr 2026 22:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775773285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LY3aMi32xfMGySyi7sa6G9Bibaq89EH0Jw9iWgTQ/WY=;
 b=EX3c+BmGSLR0t+FuW9TlPHNgiM8wI22k73LNuSnZrXcXnTQTsc1n+9bNT4wwKNJKLCGWK6
 j17QOQVkN/lTPGY8+CE9hoDMdgJnM+Od1cnEFqcoJn5fX7okYJ/7FhL2wtJBtzo4G/1hlT
 URR+DdZp2/wJ+qO//SZmdaFOaqOACTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775773285;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LY3aMi32xfMGySyi7sa6G9Bibaq89EH0Jw9iWgTQ/WY=;
 b=oPr2uhUPXi/b8vVaKNRCFtDNoNJKvY/8fiu3vCw6fc3QYpzA5igNzDN4dljyAzdML7cSKZ
 S5H9YrlnWC95ZNCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775773285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LY3aMi32xfMGySyi7sa6G9Bibaq89EH0Jw9iWgTQ/WY=;
 b=EX3c+BmGSLR0t+FuW9TlPHNgiM8wI22k73LNuSnZrXcXnTQTsc1n+9bNT4wwKNJKLCGWK6
 j17QOQVkN/lTPGY8+CE9hoDMdgJnM+Od1cnEFqcoJn5fX7okYJ/7FhL2wtJBtzo4G/1hlT
 URR+DdZp2/wJ+qO//SZmdaFOaqOACTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775773285;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LY3aMi32xfMGySyi7sa6G9Bibaq89EH0Jw9iWgTQ/WY=;
 b=oPr2uhUPXi/b8vVaKNRCFtDNoNJKvY/8fiu3vCw6fc3QYpzA5igNzDN4dljyAzdML7cSKZ
 S5H9YrlnWC95ZNCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B93ED4A0B3;
 Thu,  9 Apr 2026 22:21:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2q5+IGQm2Gk4QgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 09 Apr 2026 22:21:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>, =?utf-8?Q?Daniel?=
 =?utf-8?Q?_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Zhiyi Guo
 <zhguo@redhat.com>, Juraj
 Marcin <jmarcin@redhat.com>, Peter Xu <peterx@redhat.com>, Prasad Pandit
 <ppandit@redhat.com>, Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Joao Martins
 <joao.m.martins@oracle.com>, Markus Armbruster <armbru@redhat.com>, Alex
 Williamson <alex@shazbot.org>, "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 13/14] migration/qapi: Introduce system-wise "remaining"
 reports
In-Reply-To: <20260408165559.157108-14-peterx@redhat.com>
References: <20260408165559.157108-1-peterx@redhat.com>
 <20260408165559.157108-14-peterx@redhat.com>
Date: Thu, 09 Apr 2026 19:21:22 -0300
Message-ID: <87v7dz4vx9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[15]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
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

Peter Xu <peterx@redhat.com> writes:

> Currently, mgmt can only query for remaining RAM, not system-wise remaining
> data.  It was not a problem before, because for a very long time RAM was
> the only part that matters.
>
> After VFIO migrations landed upstream, it may not be true anymore
> especially considering that there can be GPU devices that contain GBs of
> device states.
>
> Add a new "remaining" field in query-migrate results, reflecting
> system-wise remaining data, which will include everything (e.g. VFIO).
>
> This information will be useful for mgmt to implement generic way of stall
> detection that covers all system resources.  Say, when system remaining
> data does not decrease anymore for a relatively long period of time, then
> it may mean that there is a challenge of converging, so mgmt can act based
> on how this value changes over time (especially if sampled after each
> migration iteration).
>
> Before this patch, "expected_downtime" almost played this role. For
> example, by monitoring "expected_downtime" at the beginning of each
> iteration can in most cases also reflect the progress of migration
> system-wise.  Said that, "expected_downtime" was always calculated based on
> a bandwidth value that can fluctuate a lot if avail-switchover-bandwidth is
> not used. This new "remaining" field will remove that part of uncertainty
> for mgmt.
>
> With the new field, HMP "info migrate" now reports this:
>
> (qemu) info migrate
> Status:                 active
> Time (ms):              total=12080, setup=14, exp_down=300
> Remaining (bytes):      1.36 GiB        <------------------- newline

Either bytes or GiB. Better to simply remove the "(bytes)" string.

> RAM info:
>   Throughput (Mbps):    840.50
>   Sizes:                pagesize=4 KiB, total=4.02 GiB
>   Transfers:            transferred=1.18 GiB, remain=1.36 GiB
>     Channels:           precopy=1.18 GiB, multifd=0 B, postcopy=0 B
>     Page Types:         normal=307923, zero=388148
>   Page Rates (pps):     transfer=25660
>   Others:               dirty_syncs=1
>
> It should be the same value as RAM's remaining report when VFIO is not
> involved, and it should report more than that when VFIO is involved.
>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Dr. David Alan Gilbert <dave@treblig.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  qapi/migration.json            |  4 ++++
>  migration/migration-hmp-cmds.c |  5 +++++
>  migration/migration.c          | 11 +++++++++++
>  3 files changed, 20 insertions(+)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index e3ad3f0604..a6e24b5685 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -300,6 +300,9 @@
>  #     average memory load of the virtual CPU indirectly.  Note that
>  #     zero means guest doesn't dirty memory.  (Since 8.1)
>  #
> +# @remaining: amount of bytes remaining to be migrated system-wise,
> +#     includes both RAM and all devices (like VFIO).  (Since 11.1)
> +#
>  # Features:
>  #
>  # @unstable: Members @postcopy-latency, @postcopy-vcpu-latency,
> @@ -310,6 +313,7 @@
>  ##
>  { 'struct': 'MigrationInfo',
>    'data': {'*status': 'MigrationStatus', '*ram': 'MigrationRAMStats',
> +           '*remaining': 'uint64',
>             '*vfio': 'VfioStats',
>             '*xbzrle-cache': 'XBZRLECacheStats',
>             '*total-time': 'int',
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 0a193b8f54..721c211086 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -178,6 +178,11 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>          }
>      }
>  
> +    if (info->has_remaining) {
> +        g_autofree char *remaining = size_to_str(info->remaining);
> +        monitor_printf(mon, "Remaining (bytes): \t%s\n", remaining);
> +    }
> +
>      if (info->has_socket_address) {
>          SocketAddressList *addr;
>  
> diff --git a/migration/migration.c b/migration/migration.c
> index 4010e5dcf5..c2aa145106 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1076,6 +1076,16 @@ static void populate_time_info(MigrationInfo *info, MigrationState *s)
>      }
>  }
>  
> +static void populate_global_info(MigrationInfo *info, MigrationState *s)
> +{
> +    MigPendingData data = { };
> +
> +    qemu_savevm_query_pending(&data, false);
> +
> +    info->has_remaining = true;
> +    info->remaining = data.total_bytes;
> +}
> +
>  static void populate_ram_info(MigrationInfo *info, MigrationState *s)
>  {
>      size_t page_size = qemu_target_page_size();
> @@ -1177,6 +1187,7 @@ static void fill_source_migration_info(MigrationInfo *info)
>          /* TODO add some postcopy stats */
>          populate_time_info(info, s);
>          populate_ram_info(info, s);
> +        populate_global_info(info, s);
>          migration_populate_vfio_info(info);
>          break;
>      case MIGRATION_STATUS_COLO:

