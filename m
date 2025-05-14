Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6F8C3ABD9
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 14:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFDAm-0007if-7h; Wed, 14 May 2025 10:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uFDAj-0007iI-H5
 for qemu-devel@nongnu.org; Wed, 14 May 2025 10:33:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uFDAh-0006oN-3v
 for qemu-devel@nongnu.org; Wed, 14 May 2025 10:33:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747233201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2m5Ndif0BHqDqK5TmENeUmI8YxC82GP7PbCVBotYVtU=;
 b=Wg1xXnsqb2UI3mV41rFfMtgwb1rG8TyKvnEyCbOHPgsFkqspH6tF937JbH9NhIObnbYzm4
 OP5HDs1JCvKlUZH/E7+UEqdG3lJIS2kbbSuaMzOt381RJeyPIs0I8HR1eFC9Lot8oxf87w
 i2hwavcqvtQJxiLZvN9Jz83xgMrS6lY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-neszeYp4NeyD7QWJfEZBdQ-1; Wed, 14 May 2025 10:33:20 -0400
X-MC-Unique: neszeYp4NeyD7QWJfEZBdQ-1
X-Mimecast-MFC-AGG-ID: neszeYp4NeyD7QWJfEZBdQ_1747233199
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a0bd786a53so2972154f8f.0
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 07:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747233199; x=1747837999;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2m5Ndif0BHqDqK5TmENeUmI8YxC82GP7PbCVBotYVtU=;
 b=uEGsg7tglY92+n6O9fn/YgHrIom50dUV1FiMBV07ms1QTsVkw3r/EzFfK5+hdEcUgE
 s57UBjESwihdddHyO8tkgxYGAiXURDYUIqlalbOc9Lm4RMlrGR9U0cxOn7l9MhU/Xyoh
 MtFRjAPuu/9CmykyW2Ze0ADn+xepxciULQMvXmf7KWhnVm3x1bXRGJwWBBftP+KnClLL
 CZKJM4RhyDkwrA8rQCMJ5MkSKnuNoxyyVxD99mBNp+ghzbrcANrUJb96y4Qv6pIs2go8
 0sK9uU+bQj3jTMUZeAIKv5hVSJg2lans5uLQaNX9r8yHOJhAuF9Ade5+sM40WgeZ9dMj
 duDA==
X-Gm-Message-State: AOJu0YyvrsLeuFXgSZxxUFNeoMHIalU829QMoTusrY9EUX9tM59k2DKK
 /HlA5xnZHctVUoHtUyeUL6h4ek3g1P1jW2XF/tqzT0TOC8ssfgkQV/YAHNlRlc/QexGr41z4oHX
 3NsLJ7WGs9V9WXKsV6CFzmbPJ2TxNvSCsKziKp4UBG+q4IQOFddx67nqnDqz0LzyA2A==
X-Gm-Gg: ASbGncse/SxY0nRLn+kg+rO5L7NaEZwA1YLF0PqNj4kr2atmLQKahV5+R44i7Wjhnpg
 zILNF4OASVyxmS1fOAQH6qSUII8gsSr9cQamTcJ6yEjj2D3AC4xyk7ecTMmE+BmXKTG638wI3/P
 xT93wvcWlIiFnBaDpaRo5i18EoVTRYUPUrpdU02ZtbNJTUEN6HY0VX6B13oMzNLA3FI9/uNiQY/
 C2xFP3uR9xbusDbNB/0oMSo3H+kI3BH8bZz8yhLghcxBSCP9+9tkUj+WRYK/oMdgsPw3ksb5EL8
X-Received: by 2002:a05:6000:1acf:b0:3a1:f653:85dc with SMTP id
 ffacd0b85a97d-3a349952f09mr3328774f8f.58.1747233198959; 
 Wed, 14 May 2025 07:33:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEvTRH6sA1SmNpoR39x7b07mShRJ2DjebioclDbfpmbenOgxaKg/nBUDAE6CBGXGZxd6y/TA==
X-Received: by 2002:a05:6000:1acf:b0:3a1:f653:85dc with SMTP id
 ffacd0b85a97d-3a349952f09mr3328754f8f.58.1747233198559; 
 Wed, 14 May 2025 07:33:18 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58f3afdsm20250039f8f.60.2025.05.14.07.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 07:33:18 -0700 (PDT)
Date: Wed, 14 May 2025 16:33:16 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Prasad Pandit <ppandit@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 3/3] migration/hmp: Add "info migrate -a", reorg the dump
Message-ID: <lu4vgrxl2b5kgg5jdfnucqfvu2wh3rudhya5jarw2auyh62mge@onoeum25ttzm>
References: <20250513220923.518025-1-peterx@redhat.com>
 <20250513220923.518025-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513220923.518025-4-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Peter

On 2025-05-13 18:09, Peter Xu wrote:
> I did quite some changes to the output of "info migrate".
> 
> The general rule is:
> 
>   - Put important things at the top
>   - Reuse a single line when things are very relevant, hence reducing lines
>     needed to show the results
>   - Remove almost useless ones (e.g. "normal_bytes", while we also have
>     both "page size" and "normal" pages)
>   - Regroup things, so that related fields will show together
>   - etc.
> 
> Before this change, it looks like (one example of a completed case):
> 
> (qemu) info migrate
> globals:
> store-global-state: on
> only-migratable: off
> send-configuration: on
> send-section-footer: on
> send-switchover-start: on
> clear-bitmap-shift: 18
> Migration status: completed
> total time: 122952 ms
> downtime: 76 ms
> setup: 15 ms
> transferred ram: 130825923 kbytes
> throughput: 8717.68 mbps
> remaining ram: 0 kbytes
> total ram: 16777992 kbytes
> duplicate: 997263 pages
> normal: 32622225 pages
> normal bytes: 130488900 kbytes
> dirty sync count: 10
> page size: 4 kbytes
> multifd bytes: 117134260 kbytes
> pages-per-second: 169431
> postcopy request count: 5835
> precopy ram: 15 kbytes
> postcopy ram: 13691151 kbytes
> 
> After this change, giving a few examples:
> 
> NORMAL PRECOPY:
> 
> (qemu) info migrate
> Status: active
> Time (ms): total=14292, setup=13, exp_down=12223
> RAM info:
>   Bandwidth (mbps): 9380.51
>   Sizes (KB): psize=4, total=16777992
>     transferred=15697718, remain=12383520,
>     precopy=2, multifd=15697713, postcopy=0
>   Pages: normal=3913877, zero=599981, rate_per_sec=286769
>   Others: dirty_syncs=2, dirty_pages_rate=264552
> 
> XBZRLE:
> 
> (qemu) info migrate
> Status: active
> Time (ms): total=43973, setup=16, exp_down=75826
> RAM info:
>   Bandwidth (mbps): 1496.08
>   Sizes (KB): psize=4, total=16777992
>     transferred=15156743, remain=12877944,
>     precopy=15156768, multifd=0, postcopy=0
>   Pages: normal=3780458, zero=614029, rate_per_sec=45567
>   Others: dirty_syncs=2, dirty_pages_rate=128624
> XBZRLE: size=67108864, transferred=0, pages=0, miss=188451
>   miss_rate=0.00, encode_rate=0.00, overflow=0
> 
> POSTCOPY:
> 
> (qemu) info migrate
> Status: postcopy-active
> Time (ms): total=40504, setup=14, down=145
> RAM info:
>   Bandwidth (mbps): 6102.65
>   Sizes (KB): psize=4, total=16777992
>     transferred=37673019, remain=2136404,
>     precopy=3, multifd=26108780, postcopy=11563855
>   Pages: normal=9394288, zero=600672, rate_per_sec=185875
>   Others: dirty_syncs=3, dirty_pages_rate=278378, postcopy_req=4078
> 
> COMPLETED:
> 
> (qemu) info migrate
> Status: completed
> Time (ms): total=43708, setup=14, down=145
> RAM info:
>   Bandwidth (mbps): 7464.50
>   Sizes (KB): psize=4, total=16777992
>     transferred=39813725, remain=0,
>     precopy=3, multifd=26108780, postcopy=13704436
>   Pages: normal=9928390, zero=600672, rate_per_sec=167283
>   Others: dirty_syncs=3, postcopy_req=5577
> 
> INCOMING (WHEN TCP LISTENING):
> 
> (qemu) info migrate
> Status: setup
> Sockets: [
>         tcp:0.0.0.0:12345
> ]
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration-hmp-cmds.c | 158 +++++++++++++++++----------------
>  hmp-commands-info.hx           |   6 +-
>  2 files changed, 85 insertions(+), 79 deletions(-)
> 
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 0034dbe47f..c1c10b22ae 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -54,6 +54,7 @@ static void migration_global_dump(Monitor *mon)
>  
>  void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>  {
> +    bool show_all = qdict_get_try_bool(qdict, "all", false);
>      MigrationInfo *info;
>  
>      info = qmp_query_migrate(NULL);
> @@ -68,7 +69,7 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>      }
>  
>      if (info->has_status) {
> -        monitor_printf(mon, "Migration status: %s",
> +        monitor_printf(mon, "Status: %s",
>                         MigrationStatus_str(info->status));
>          if (info->status == MIGRATION_STATUS_FAILED && info->error_desc) {
>              monitor_printf(mon, " (%s)\n", info->error_desc);
> @@ -76,90 +77,111 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>              monitor_printf(mon, "\n");
>          }
>  
> -        monitor_printf(mon, "total time: %" PRIu64 " ms\n",
> -                       info->total_time);
> -        if (info->has_expected_downtime) {
> -            monitor_printf(mon, "expected downtime: %" PRIu64 " ms\n",
> -                           info->expected_downtime);
> -        }
> -        if (info->has_downtime) {
> -            monitor_printf(mon, "downtime: %" PRIu64 " ms\n",
> -                           info->downtime);
> +        if (info->total_time) {
> +            monitor_printf(mon, "Time (ms): total=%" PRIu64,
> +                           info->total_time);
> +            if (info->has_setup_time) {
> +                monitor_printf(mon, ", setup=%" PRIu64,
> +                               info->setup_time);
> +            }
> +            if (info->has_expected_downtime) {
> +                monitor_printf(mon, ", exp_down=%" PRIu64,
> +                               info->expected_downtime);
> +            }
> +            if (info->has_downtime) {
> +                monitor_printf(mon, ", down=%" PRIu64,
> +                               info->downtime);
> +            }
> +            monitor_printf(mon, "\n");
>          }
> -        if (info->has_setup_time) {
> -            monitor_printf(mon, "setup: %" PRIu64 " ms\n",
> -                           info->setup_time);
> +    }
> +
> +    if (info->has_socket_address) {
> +        SocketAddressList *addr;
> +
> +        monitor_printf(mon, "Sockets: [\n");
> +
> +        for (addr = info->socket_address; addr; addr = addr->next) {
> +            char *s = socket_uri(addr->value);
> +            monitor_printf(mon, "\t%s\n", s);
> +            g_free(s);
>          }
> +        monitor_printf(mon, "]\n");
>      }
>  
>      if (info->ram) {
> -        monitor_printf(mon, "transferred ram: %" PRIu64 " kbytes\n",
> -                       info->ram->transferred >> 10);
> -        monitor_printf(mon, "throughput: %0.2f mbps\n",
> +        monitor_printf(mon, "RAM info:\n");
> +        monitor_printf(mon, "  Bandwidth (mbps): %0.2f\n",
>                         info->ram->mbps);

I think the previous name (throughput) was better suited for this
metric. IIUC '->mbps' is the actual amount of data that has been sent
over a period of time, which is exactly the definition of throughput.
Bandwidth, on the other hand, is more of a (theoretical) maximum that
could be sent.

Otherwise, it looks good to me.

Best regards

Juraj Marcin

> -        monitor_printf(mon, "remaining ram: %" PRIu64 " kbytes\n",
> -                       info->ram->remaining >> 10);
> -        monitor_printf(mon, "total ram: %" PRIu64 " kbytes\n",
> +        monitor_printf(mon, "  Sizes (KB): psize=%" PRIu64
> +                       ", total=%" PRIu64 "\n",
> +                       info->ram->page_size >> 10,
>                         info->ram->total >> 10);
> -        monitor_printf(mon, "duplicate: %" PRIu64 " pages\n",
> -                       info->ram->duplicate);
> -        monitor_printf(mon, "normal: %" PRIu64 " pages\n",
> -                       info->ram->normal);
> -        monitor_printf(mon, "normal bytes: %" PRIu64 " kbytes\n",
> -                       info->ram->normal_bytes >> 10);
> -        monitor_printf(mon, "dirty sync count: %" PRIu64 "\n",
> -                       info->ram->dirty_sync_count);
> -        monitor_printf(mon, "page size: %" PRIu64 " kbytes\n",
> -                       info->ram->page_size >> 10);
> -        monitor_printf(mon, "multifd bytes: %" PRIu64 " kbytes\n",
> -                       info->ram->multifd_bytes >> 10);
> -        monitor_printf(mon, "pages-per-second: %" PRIu64 "\n",
> +        monitor_printf(mon, "    transferred=%" PRIu64
> +                       ", remain=%" PRIu64 ",\n",
> +                       info->ram->transferred >> 10,
> +                       info->ram->remaining >> 10);
> +        monitor_printf(mon, "    precopy=%" PRIu64
> +                       ", multifd=%" PRIu64
> +                       ", postcopy=%" PRIu64,
> +                       info->ram->precopy_bytes >> 10,
> +                       info->ram->multifd_bytes >> 10,
> +                       info->ram->postcopy_bytes >> 10);
> +
> +        if (info->vfio) {
> +            monitor_printf(mon, ", vfio=%" PRIu64,
> +                           info->vfio->transferred >> 10);
> +        }
> +        monitor_printf(mon, "\n");
> +
> +        monitor_printf(mon, "  Pages: normal=%" PRIu64 ", zero=%" PRIu64
> +                       ", rate_per_sec=%" PRIu64 "\n",
> +                       info->ram->normal,
> +                       info->ram->duplicate,
>                         info->ram->pages_per_second);
> +        monitor_printf(mon, "  Others: dirty_syncs=%" PRIu64,
> +                       info->ram->dirty_sync_count);
>  
>          if (info->ram->dirty_pages_rate) {
> -            monitor_printf(mon, "dirty pages rate: %" PRIu64 " pages\n",
> +            monitor_printf(mon, ", dirty_pages_rate=%" PRIu64,
>                             info->ram->dirty_pages_rate);
>          }
>          if (info->ram->postcopy_requests) {
> -            monitor_printf(mon, "postcopy request count: %" PRIu64 "\n",
> +            monitor_printf(mon, ", postcopy_req=%" PRIu64,
>                             info->ram->postcopy_requests);
>          }
> -        if (info->ram->precopy_bytes) {
> -            monitor_printf(mon, "precopy ram: %" PRIu64 " kbytes\n",
> -                           info->ram->precopy_bytes >> 10);
> -        }
>          if (info->ram->downtime_bytes) {
> -            monitor_printf(mon, "downtime ram: %" PRIu64 " kbytes\n",
> -                           info->ram->downtime_bytes >> 10);
> -        }
> -        if (info->ram->postcopy_bytes) {
> -            monitor_printf(mon, "postcopy ram: %" PRIu64 " kbytes\n",
> -                           info->ram->postcopy_bytes >> 10);
> +            monitor_printf(mon, ", downtime_ram=%" PRIu64,
> +                           info->ram->downtime_bytes);
>          }
>          if (info->ram->dirty_sync_missed_zero_copy) {
> -            monitor_printf(mon,
> -                           "Zero-copy-send fallbacks happened: %" PRIu64 " times\n",
> +            monitor_printf(mon, ", zerocopy_fallbacks=%" PRIu64,
>                             info->ram->dirty_sync_missed_zero_copy);
>          }
> +        monitor_printf(mon, "\n");
>      }
>  
>      if (info->xbzrle_cache) {
> -        monitor_printf(mon, "cache size: %" PRIu64 " bytes\n",
> -                       info->xbzrle_cache->cache_size);
> -        monitor_printf(mon, "xbzrle transferred: %" PRIu64 " kbytes\n",
> -                       info->xbzrle_cache->bytes >> 10);
> -        monitor_printf(mon, "xbzrle pages: %" PRIu64 " pages\n",
> -                       info->xbzrle_cache->pages);
> -        monitor_printf(mon, "xbzrle cache miss: %" PRIu64 " pages\n",
> -                       info->xbzrle_cache->cache_miss);
> -        monitor_printf(mon, "xbzrle cache miss rate: %0.2f\n",
> -                       info->xbzrle_cache->cache_miss_rate);
> -        monitor_printf(mon, "xbzrle encoding rate: %0.2f\n",
> -                       info->xbzrle_cache->encoding_rate);
> -        monitor_printf(mon, "xbzrle overflow: %" PRIu64 "\n",
> +        monitor_printf(mon, "XBZRLE: size=%" PRIu64
> +                       ", transferred=%" PRIu64
> +                       ", pages=%" PRIu64
> +                       ", miss=%" PRIu64 "\n"
> +                       "  miss_rate=%0.2f"
> +                       ", encode_rate=%0.2f"
> +                       ", overflow=%" PRIu64 "\n",
> +                       info->xbzrle_cache->cache_size,
> +                       info->xbzrle_cache->bytes,
> +                       info->xbzrle_cache->pages,
> +                       info->xbzrle_cache->cache_miss,
> +                       info->xbzrle_cache->cache_miss_rate,
> +                       info->xbzrle_cache->encoding_rate,
>                         info->xbzrle_cache->overflow);
>      }
>  
> +    if (!show_all) {
> +        goto out;
> +    }
> +
>      if (info->has_cpu_throttle_percentage) {
>          monitor_printf(mon, "cpu throttle percentage: %" PRIu64 "\n",
>                         info->cpu_throttle_percentage);
> @@ -191,24 +213,8 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>          g_free(str);
>          visit_free(v);
>      }
> -    if (info->has_socket_address) {
> -        SocketAddressList *addr;
> -
> -        monitor_printf(mon, "socket address: [\n");
> -
> -        for (addr = info->socket_address; addr; addr = addr->next) {
> -            char *s = socket_uri(addr->value);
> -            monitor_printf(mon, "\t%s\n", s);
> -            g_free(s);
> -        }
> -        monitor_printf(mon, "]\n");
> -    }
> -
> -    if (info->vfio) {
> -        monitor_printf(mon, "vfio device transferred: %" PRIu64 " kbytes\n",
> -                       info->vfio->transferred >> 10);
> -    }
>  
> +out:
>      qapi_free_MigrationInfo(info);
>  }
>  
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index c59cd6637b..639a450ee5 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -475,9 +475,9 @@ ERST
>  
>      {
>          .name       = "migrate",
> -        .args_type  = "",
> -        .params     = "",
> -        .help       = "show migration status",
> +        .args_type  = "all:-a",
> +        .params     = "[-a]",
> +        .help       = "show migration status (-a: all, dump all status)",
>          .cmd        = hmp_info_migrate,
>      },
>  
> -- 
> 2.49.0
> 


