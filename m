Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB190C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 15:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKIN1-0006oL-Py; Wed, 28 May 2025 11:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1uKIMk-0006iT-UE
 for qemu-devel@nongnu.org; Wed, 28 May 2025 11:06:53 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1uKIMi-000597-Ka
 for qemu-devel@nongnu.org; Wed, 28 May 2025 11:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=PzSmM7hwggQhN/l+aMkBl/Fm7z+nd1aT2IW1l5/VZH4=; b=dUBCXfc4tzTfnnbt
 Z2Gqy6i6s/MGjGKU4f/atq84oRhZjiH0GRob7jsrypaW4pFD/aepxaYy5aNxp6/uh+VcfiY78qmzR
 oQDXo7E7fW4PH5ed3qin2p6TmVeurJH/TSgE6ZyIGRblME7ZnJcGjpk6hsbP2JIkcZGi682sDJIJf
 7Op7BOeGlWr4mo1DgkUVFWhSYI/CSdAYd0kN3TC+FaZuiBlCfxhzCp/dJCr+evvuuwsbm3WDGxuoK
 aVQnBBkM5dRyEDO2epcg8gza+U6omsrjjjo8ap7wRnL0zxiXXIWbjkRb8D9OfDHAQTh5kW5FVt9VV
 bWAJ9WXptOUiRkRNfw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1uKIMd-006Dhv-0V;
 Wed, 28 May 2025 15:06:43 +0000
Date: Wed, 28 May 2025 15:06:43 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Subject: Re: [PATCH 01/11] migration/hmp: Reorg "info migrate" once more
Message-ID: <aDcmg3uLri6TfxPm@gallifrey>
References: <20250527215850.1271072-1-peterx@redhat.com>
 <20250527215850.1271072-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20250527215850.1271072-2-peterx@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 15:06:31 up 30 days, 23:20, 1 user, load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
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

* Peter Xu (peterx@redhat.com) wrote:
> Dave suggested the HMP output for "info migrate" can not only leverage the
> lines but also better grouping:
> 
>   https://lore.kernel.org/r/aC4_-nMc7FwsMf9p@gallifrey
> 
> I followed Dave's suggestion, and some more modifications on top:
> 
>   - Added all elements into the picture
> 
>   - Use size_to_str() and drop most of the units: benefit is more friendly
>   to most human eyes, bad side effect is lose of details, but that should
>   be corner case per my uses, and one can still leverage the QMP interface
>   when necessary.
> 
>   - Sub-grouping for "Transfers" ("Channels" and "Page Types").
> 
>   - Better indentations

Thanks,

Acked-by: Dr. David Alan Gilbert <dave@treblig.org>

> Sample output:
> 
> (qemu) info migrate
> Status:                 postcopy-active
> Time (ms):              total=47317, setup=5, down=8
> RAM info:
>   Throughput (Mbps):    1342.83
>   Sizes:                pagesize=4 KiB, total=4.02 GiB
>   Transfers:            transferred=1.41 GiB, remain=2.46 GiB
>     Channels:           precopy=15.2 MiB, multifd=0 B, postcopy=1.39 GiB
>     Page Types:         normal=367713, zero=41195
>   Page Rates (pps):     transfer=40900, dirty=4
>   Others:               dirty_syncs=2, postcopy_req=57503
> 
> Cc: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
> Suggested-by: Dr. David Alan Gilbert <dave@treblig.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration-hmp-cmds.c | 59 ++++++++++++++++++----------------
>  1 file changed, 31 insertions(+), 28 deletions(-)
> 
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index e8a563c7d8..367ff6037f 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -69,7 +69,7 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>      }
>  
>      if (info->has_status) {
> -        monitor_printf(mon, "Status: %s",
> +        monitor_printf(mon, "Status: \t\t%s",
>                         MigrationStatus_str(info->status));
>          if (info->status == MIGRATION_STATUS_FAILED && info->error_desc) {
>              monitor_printf(mon, " (%s)\n", info->error_desc);
> @@ -78,7 +78,7 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>          }
>  
>          if (info->total_time) {
> -            monitor_printf(mon, "Time (ms): total=%" PRIu64,
> +            monitor_printf(mon, "Time (ms): \t\ttotal=%" PRIu64,
>                             info->total_time);
>              if (info->has_setup_time) {
>                  monitor_printf(mon, ", setup=%" PRIu64,
> @@ -110,48 +110,51 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>      }
>  
>      if (info->ram) {
> +        g_autofree char *str_psize = size_to_str(info->ram->page_size);
> +        g_autofree char *str_total = size_to_str(info->ram->total);
> +        g_autofree char *str_transferred = size_to_str(info->ram->transferred);
> +        g_autofree char *str_remaining = size_to_str(info->ram->remaining);
> +        g_autofree char *str_precopy = size_to_str(info->ram->precopy_bytes);
> +        g_autofree char *str_multifd = size_to_str(info->ram->multifd_bytes);
> +        g_autofree char *str_postcopy = size_to_str(info->ram->postcopy_bytes);
> +
>          monitor_printf(mon, "RAM info:\n");
> -        monitor_printf(mon, "  Throughput (Mbps): %0.2f\n",
> +        monitor_printf(mon, "  Throughput (Mbps): \t%0.2f\n",
>                         info->ram->mbps);
> -        monitor_printf(mon, "  Sizes (KiB): pagesize=%" PRIu64
> -                       ", total=%" PRIu64 ",\n",
> -                       info->ram->page_size >> 10,
> -                       info->ram->total >> 10);
> -        monitor_printf(mon, "    transferred=%" PRIu64
> -                       ", remain=%" PRIu64 ",\n",
> -                       info->ram->transferred >> 10,
> -                       info->ram->remaining >> 10);
> -        monitor_printf(mon, "    precopy=%" PRIu64
> -                       ", multifd=%" PRIu64
> -                       ", postcopy=%" PRIu64,
> -                       info->ram->precopy_bytes >> 10,
> -                       info->ram->multifd_bytes >> 10,
> -                       info->ram->postcopy_bytes >> 10);
> +        monitor_printf(mon, "  Sizes: \t\tpagesize=%s, total=%s\n",
> +                       str_psize, str_total);
> +        monitor_printf(mon, "  Transfers: \t\ttransferred=%s, remain=%s\n",
> +                       str_transferred, str_remaining);
> +        monitor_printf(mon, "    Channels: \t\tprecopy=%s, "
> +                       "multifd=%s, postcopy=%s",
> +                       str_precopy, str_multifd, str_postcopy);
>  
>          if (info->vfio) {
> -            monitor_printf(mon, ", vfio=%" PRIu64,
> -                           info->vfio->transferred >> 10);
> +            g_autofree char *str_vfio = size_to_str(info->vfio->transferred);
> +
> +            monitor_printf(mon, ", vfio=%s", str_vfio);
>          }
>          monitor_printf(mon, "\n");
>  
> -        monitor_printf(mon, "  Pages: normal=%" PRIu64 ", zero=%" PRIu64
> -                       ", rate_per_sec=%" PRIu64 "\n",
> -                       info->ram->normal,
> -                       info->ram->duplicate,
> +        monitor_printf(mon, "    Page Types: \tnormal=%" PRIu64
> +                       ", zero=%" PRIu64 "\n",
> +                       info->ram->normal, info->ram->duplicate);
> +        monitor_printf(mon, "  Page Rates (pps): \ttransfer=%" PRIu64,
>                         info->ram->pages_per_second);
> -        monitor_printf(mon, "  Others: dirty_syncs=%" PRIu64,
> -                       info->ram->dirty_sync_count);
> -
>          if (info->ram->dirty_pages_rate) {
> -            monitor_printf(mon, ", dirty_pages_rate=%" PRIu64,
> +            monitor_printf(mon, ", dirty=%" PRIu64,
>                             info->ram->dirty_pages_rate);
>          }
> +        monitor_printf(mon, "\n");
> +
> +        monitor_printf(mon, "  Others: \t\tdirty_syncs=%" PRIu64,
> +                       info->ram->dirty_sync_count);
>          if (info->ram->postcopy_requests) {
>              monitor_printf(mon, ", postcopy_req=%" PRIu64,
>                             info->ram->postcopy_requests);
>          }
>          if (info->ram->downtime_bytes) {
> -            monitor_printf(mon, ", downtime_ram=%" PRIu64,
> +            monitor_printf(mon, ", downtime_bytes=%" PRIu64,
>                             info->ram->downtime_bytes);
>          }
>          if (info->ram->dirty_sync_missed_zero_copy) {
> -- 
> 2.49.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

