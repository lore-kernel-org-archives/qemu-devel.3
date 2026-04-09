Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D64EF364BE
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 21:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAxFL-0003GU-4s; Thu, 09 Apr 2026 17:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wAxFJ-0003GE-DA
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 17:49:05 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wAxFG-0001ZF-Ve
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 17:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=I3+zygPDdrYt1oWBgZV98MSYzKehFQGf3kqAyk4J2Kw=; b=IKPOm9jvQ4NvrCkt
 0aFMPpQbnaDJ/IgKjwY2/w3+y7zBmG/lMokwer3Zh50rD5ZuKxr3lXHljyqTE4ytWevDFjvk1kdBt
 BOGqyK9Hdhldc9OIciU8Khty6iuAjq34bsHX35279EyJ1iTt+DgXhk0nuoNTaW3Zjo4OuZQg80pQr
 3z/OrGX6QCYKF7DnE/jz1FAd7x4DXfUlxZ4hW/zq001/POY33rloygk6VeBntgugVDMVhfA/l1OOi
 hvGhbGvlldup57SRSjDSA3+e3q5kecV2F+AQmTLXJVr4Lf2Bm8c0BrpYyBu3oOwgOPAAL+IoRKGFp
 gQoy1L0IJzuwefd5HQ==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wAxFB-00000007HfO-3lz4;
 Thu, 09 Apr 2026 21:48:57 +0000
Date: Thu, 9 Apr 2026 21:48:57 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH 13/14] migration/qapi: Introduce system-wise "remaining"
 reports
Message-ID: <adgeySiEoXBWRpOl@gallifrey>
References: <20260408165559.157108-1-peterx@redhat.com>
 <20260408165559.157108-14-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20260408165559.157108-14-peterx@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.74+deb13+1-amd64 (x86_64)
X-Uptime: 21:48:18 up 27 days, 23:01,  2 users,  load average: 0.02, 0.03, 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
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

* Peter Xu (peterx@redhat.com) wrote:
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

Of course you realise the next thing people will ask for is being able
to ask *which* vfio device is the one that's busy.

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

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
> -- 
> 2.53.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

