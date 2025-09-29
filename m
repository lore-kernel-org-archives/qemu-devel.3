Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667FDCAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 14:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Ed6-0001qr-4u; Mon, 29 Sep 2025 10:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3Ecz-0001nd-09
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 10:13:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3Ech-0001pL-S5
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 10:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759155175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YRMYBAz0w2K++gOqHDMuqw0dt1wYRTk29PkTuNYgvkY=;
 b=NjTpf9RAJfOalHlQI6FCwK/9vVAcuSmePOl/mQ6rBD/d1Aak5GLuz6MytyR90Ew19uswYk
 Q+kbHYDqoO1DBWaWbUWY2FBf4EbAe+1o2AxpdwKVjmz43h93TQK7xPU9vKHpKLfCfa0/TU
 haGDmdLd6Mt9qC5UUuNUrPztWuQ0kwc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-oETJViAzPUuvDLpo4kwUxw-1; Mon, 29 Sep 2025 10:12:53 -0400
X-MC-Unique: oETJViAzPUuvDLpo4kwUxw-1
X-Mimecast-MFC-AGG-ID: oETJViAzPUuvDLpo4kwUxw_1759155173
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-7fa235e330dso104017646d6.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 07:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759155173; x=1759759973;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YRMYBAz0w2K++gOqHDMuqw0dt1wYRTk29PkTuNYgvkY=;
 b=pCTMslzrP06CQ7CgW+wdthTOUO9QlTBRZBGjyOZHVgSVI/w0lf0xAxVRb5QxTu1Spn
 bQ6FL97IG67OlncsCVBeeJkiG+dZ4LptKzKLbBS8fhjPk+3FWJMp090+sytPUGijmq1u
 5YDdhDdPEtW47DT4o2mxe4RT8YzQ3cKQjisSoy3POyCytZpE0XsISdu8738yHZRmD91z
 /KSwXF2SHdsLjxsxNQB75vcX0ehcRYHFTmaeaypweMUV8vZwTg8xNdBJWEOExlRPgoMp
 KS25+ufK9zbR8h+KKkX0AdQMUkbIsPV/fX23qPO7tU7yV0L+i34GTSKQmuoP0ey1sPZJ
 BbXA==
X-Gm-Message-State: AOJu0YwBUX2sID4v+FyIXf8HXzXK8GBgvrlzywxLaFRnJdSPm4lorjvm
 sCQ5pOdRZOCCD0J6C68uIRz5eahb7WoPto1+UQ+EhBZN/5W9caPZYsDRUxszexAMb+Ehtqx1Anu
 5vzFTMGbYsQPmu3x9cVRWwRUa1zeqfN6HyisihBZ6tdqEJsO9//XbBQUheAg/kaTc
X-Gm-Gg: ASbGncu/k4B11xK1o3SojfIlUHpe8jtdWL1Kk1rVmyUqsjecYwPj7WvaFCuXiqSg4OZ
 j1BMU3HlbrPDFqIwHB7KrHy1PBr99taS1Yf14brQiENhSUWEIZd8lo23bMydbHxwPxvXrQGBuwg
 tAILQQbhwgYLrMBU17+wJhA9+uLZG2x3SR2BglsaQYgDEIsymGxlRe639nYc7ELeLuCJm6rXnpC
 H1R4KPFYhdqzWsGancxqAhHV/lHEELZz02ux1340DWWKXrYrPUQifDNCAF4MjUSx1tRUbiQI/+B
 aq4z0ZpUAcaucjGSSN2Mz3VruZe664lm
X-Received: by 2002:a05:6214:248a:b0:78f:48ef:d8c with SMTP id
 6a1803df08f44-8699ab1097amr9405376d6.22.1759155173072; 
 Mon, 29 Sep 2025 07:12:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZcaIxrq7JVxqa1t59uy0o/KZz/Szhiep6PGBc8SKt3FIOnbfG3vv/ZEw4CCToQqsmeAwR/Q==
X-Received: by 2002:a05:6214:248a:b0:78f:48ef:d8c with SMTP id
 6a1803df08f44-8699ab1097amr9404716d6.22.1759155172349; 
 Mon, 29 Sep 2025 07:12:52 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8013c0951b5sm74938896d6.19.2025.09.29.07.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 07:12:51 -0700 (PDT)
Date: Mon, 29 Sep 2025 10:12:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Bin Guo <guobin@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de
Subject: Re: [PATCH] migration: HMP: Adjust the order of output fields
Message-ID: <aNqT4mJWxdYJt4Wc@x1.local>
References: <20250929021213.28369-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250929021213.28369-1-guobin@linux.alibaba.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Sep 29, 2025 at 10:12:13AM +0800, Bin Guo wrote:
> Adjust the positions of 'tls-authz' and 'max-postcopy-bandwidth' in
> the fields output by the 'info migrate_parameters' command so that
> related fields are next to each other.
> 
> For clarity only, no functional changes.
> 
> Sample output after this commit:
> (qemu) info migrate_parameters
> ...
> max-cpu-throttle: 99
> tls-creds: ''
> tls-hostname: ''
> tls-authz: ''
> max-bandwidth: 134217728 bytes/second
> avail-switchover-bandwidth: 0 bytes/second
> max-postcopy-bandwidth: 0 bytes/second

This can be moved even above "avail-switchover-bandwidth", IMHO.

With that, feel free to take:

Reviewed-by: Peter Xu <peterx@redhat.com>

> downtime-limit: 300 ms
> ...
> 
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>  migration/migration-hmp-cmds.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 0fc21f0647..814221b260 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -353,6 +353,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>          monitor_printf(mon, "%s: '%s'\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_TLS_HOSTNAME),
>              params->tls_hostname);
> +        assert(params->tls_authz);
> +        monitor_printf(mon, "%s: '%s'\n",
> +            MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
> +            params->tls_authz);
>          assert(params->has_max_bandwidth);
>          monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_MAX_BANDWIDTH),
> @@ -361,6 +365,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>          monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_AVAIL_SWITCHOVER_BANDWIDTH),
>              params->avail_switchover_bandwidth);
> +        assert(params->has_max_postcopy_bandwidth);
> +        monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
> +            MigrationParameter_str(MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH),
> +            params->max_postcopy_bandwidth);
>          assert(params->has_downtime_limit);
>          monitor_printf(mon, "%s: %" PRIu64 " ms\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_DOWNTIME_LIMIT),
> @@ -383,12 +391,6 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>          monitor_printf(mon, "%s: %" PRIu64 " bytes\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE),
>              params->xbzrle_cache_size);
> -        monitor_printf(mon, "%s: %" PRIu64 "\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH),
> -            params->max_postcopy_bandwidth);
> -        monitor_printf(mon, "%s: '%s'\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
> -            params->tls_authz);
>  
>          if (params->has_block_bitmap_mapping) {
>              const BitmapMigrationNodeAliasList *bmnal;
> -- 
> 2.39.5
> 
> 

-- 
Peter Xu


