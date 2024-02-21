Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A61ACC48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoaV-0008Sm-Te; Wed, 21 Feb 2024 10:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcoPl-0006DD-Bh
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:21:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rclON-00032e-Qb
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 07:08:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708517283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0EBh+xv5H6WGacyPuyUU4qOiPGvzcOIXjAFokD2rarI=;
 b=DlMUBQLZinYr88qHLc2WkTIueVQDebmHeVbKSpNRw84A4SKSf/EUNrT/8dwpHfuVCqcC5Z
 VzJ7GPpJjnmRACwNzbl1yxjA9VH4v+mu22HMHgpIbU2ETT5G0F5Fj7dn+FIr5ohGCghSV4
 rvHHOfr04WoWGIvdLe+uJHug6yiyR3s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-Z0MeJWdNP-6BrizmblRDhQ-1; Wed,
 21 Feb 2024 07:07:59 -0500
X-MC-Unique: Z0MeJWdNP-6BrizmblRDhQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97DE83C0F229;
 Wed, 21 Feb 2024 12:07:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 428D510800;
 Wed, 21 Feb 2024 12:07:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1ACA521E6740; Wed, 21 Feb 2024 13:07:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: pbonzini@redhat.com,  berrange@redhat.com,  eduardo@habkost.net,
 peterx@redhat.com,  farosas@suse.de,  eblake@redhat.com,
 thuth@redhat.com,  lvivier@redhat.com,  qemu-devel@nongnu.org,
 jdenemar@redhat.com
Subject: Re: [PATCH v2 6/7] migration/multifd: Add zero pages and zero bytes
 counter to migration status interface.
In-Reply-To: <20240216224002.1476890-7-hao.xiang@bytedance.com> (Hao Xiang's
 message of "Fri, 16 Feb 2024 22:40:01 +0000")
References: <20240216224002.1476890-1-hao.xiang@bytedance.com>
 <20240216224002.1476890-7-hao.xiang@bytedance.com>
Date: Wed, 21 Feb 2024 13:07:54 +0100
Message-ID: <87plwqt3z9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hao Xiang <hao.xiang@bytedance.com> writes:

> This change extends the MigrationStatus interface to track zero pages
> and zero bytes counter.
>
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> ---
>  migration/migration-hmp-cmds.c      |  4 ++++
>  migration/migration.c               |  2 ++
>  qapi/migration.json                 | 15 ++++++++++++++-
>  tests/migration/guestperf/engine.py |  2 ++
>  4 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 7e96ae6ffd..abe035c9f2 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -111,6 +111,10 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>                         info->ram->normal);
>          monitor_printf(mon, "normal bytes: %" PRIu64 " kbytes\n",
>                         info->ram->normal_bytes >> 10);
> +        monitor_printf(mon, "zero: %" PRIu64 " pages\n",
> +                       info->ram->zero);
> +        monitor_printf(mon, "zero bytes: %" PRIu64 " kbytes\n",
> +                       info->ram->zero_bytes >> 10);
>          monitor_printf(mon, "dirty sync count: %" PRIu64 "\n",
>                         info->ram->dirty_sync_count);
>          monitor_printf(mon, "page size: %" PRIu64 " kbytes\n",
> diff --git a/migration/migration.c b/migration/migration.c
> index ab21de2cad..1968ea7075 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1112,6 +1112,8 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
>      info->ram->skipped = 0;
>      info->ram->normal = stat64_get(&mig_stats.normal_pages);
>      info->ram->normal_bytes = info->ram->normal * page_size;
> +    info->ram->zero = stat64_get(&mig_stats.zero_pages);
> +    info->ram->zero_bytes = info->ram->zero * page_size;
>      info->ram->mbps = s->mbps;
>      info->ram->dirty_sync_count =
>          stat64_get(&mig_stats.dirty_sync_count);
> diff --git a/qapi/migration.json b/qapi/migration.json
> index e2450b92d4..892875da18 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -63,6 +63,10 @@
>  #     between 0 and @dirty-sync-count * @multifd-channels.  (since
>  #     7.1)
>  #
> +# @zero: number of zero pages (since 9.0)
> +#
> +# @zero-bytes: number of zero bytes sent (since 9.0)

Awfully terse.  How are these two related?

Recommend to name the first one @zero-pages.

> +#
>  # Features:
>  #
>  # @deprecated: Member @skipped is always zero since 1.5.3
> @@ -81,7 +85,8 @@
>             'multifd-bytes': 'uint64', 'pages-per-second': 'uint64',
>             'precopy-bytes': 'uint64', 'downtime-bytes': 'uint64',
>             'postcopy-bytes': 'uint64',
> -           'dirty-sync-missed-zero-copy': 'uint64' } }
> +           'dirty-sync-missed-zero-copy': 'uint64',
> +           'zero': 'int', 'zero-bytes': 'int' } }

Please use 'size' for byte counts such as @zero-bytes.

>  
>  ##
>  # @XBZRLECacheStats:
> @@ -332,6 +337,8 @@
>  #           "duplicate":123,
>  #           "normal":123,
>  #           "normal-bytes":123456,
> +#           "zero":123,
> +#           "zero-bytes":123456,
>  #           "dirty-sync-count":15
>  #         }
>  #      }
> @@ -358,6 +365,8 @@
>  #             "duplicate":123,
>  #             "normal":123,
>  #             "normal-bytes":123456,
> +#             "zero":123,
> +#             "zero-bytes":123456,
>  #             "dirty-sync-count":15
>  #          }
>  #       }
> @@ -379,6 +388,8 @@
>  #             "duplicate":123,
>  #             "normal":123,
>  #             "normal-bytes":123456,
> +#             "zero":123,
> +#             "zero-bytes":123456,
>  #             "dirty-sync-count":15
>  #          },
>  #          "disk":{
> @@ -405,6 +416,8 @@
>  #             "duplicate":10,
>  #             "normal":3333,
>  #             "normal-bytes":3412992,
> +#             "zero":3333,
> +#             "zero-bytes":3412992,
>  #             "dirty-sync-count":15
>  #          },
>  #          "xbzrle-cache":{
> diff --git a/tests/migration/guestperf/engine.py b/tests/migration/guestperf/engine.py
> index 608d7270f6..75315b99b7 100644
> --- a/tests/migration/guestperf/engine.py
> +++ b/tests/migration/guestperf/engine.py
> @@ -92,6 +92,8 @@ def _migrate_progress(self, vm):
>                  info["ram"].get("skipped", 0),
>                  info["ram"].get("normal", 0),
>                  info["ram"].get("normal-bytes", 0),
> +                info["ram"].get("zero", 0);
> +                info["ram"].get("zero-bytes", 0);
>                  info["ram"].get("dirty-pages-rate", 0),
>                  info["ram"].get("mbps", 0),
>                  info["ram"].get("dirty-sync-count", 0)


