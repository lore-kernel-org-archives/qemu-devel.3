Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 378BAD609D3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 17:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVYmy-0000DI-FT; Tue, 16 Dec 2025 12:24:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVYmm-0000Bh-M8
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 12:24:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVYmi-00012C-Jh
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 12:24:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765905867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sBiKL7GSHQPGbTr30+w7UVfTrABt68MayFbd9YdhyVY=;
 b=dVUvyy+vpAoYhe/KOl4mOxkNhwbZZ3nJF6QMHMU94SvNTi3Z5eZ3h74nVw/h53HWyr/gxJ
 1cYDGNS4oG0rj2YmxpecgPz08/h7u1l09mfkZqnCP2Ut3xhoduRnY9LNCL6fPy9NxFaz52
 jPFfs8oknmLOdQl+vH0oBiTooK0Wgrg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-Cb1-Hpd9NfS_g6J4mQeZWA-1; Tue, 16 Dec 2025 12:24:23 -0500
X-MC-Unique: Cb1-Hpd9NfS_g6J4mQeZWA-1
X-Mimecast-MFC-AGG-ID: Cb1-Hpd9NfS_g6J4mQeZWA_1765905863
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8804b991a54so181459146d6.2
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 09:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765905863; x=1766510663; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sBiKL7GSHQPGbTr30+w7UVfTrABt68MayFbd9YdhyVY=;
 b=sKP3hDo9nOXVAHA7yAfr2GG5cRxUf6LoLnb/oX0xrZm0ljjjM+0xuccuiMGH+kPbmI
 lcnQKiZYRSFxhF6PW4fYE9wLAm801Kc9dPPCfwypRr8Ra2Tmb+2Jvrm2hTeK1DU19E60
 bFm7N5fWWPvbuGelk2UHyYKTdvKZTI6L1kyH+TxoNU/gsp+YdIB92mh4Pq9dJdFcs9Gu
 tuCk5mC7tUqKFPb2+CT/4gUNvuWH4nFAbROjlMjh0TUAZKsmOIA5ad6c7lDnGCV+vtub
 JeLq7zgt2d1NB7KFX6IP8VnA2B1Vh4EqFt/lglTjzMoBGh8PdHHXkLxDUooiP2b9LGYe
 yuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765905863; x=1766510663;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sBiKL7GSHQPGbTr30+w7UVfTrABt68MayFbd9YdhyVY=;
 b=YK7lxTNs+s0Bu6tM/mAaIIjpyJgOCdHkRJuvsKYpt0Dv+kDGCS/EHtA9p4DAd28zga
 A71eb0baaGet5mnNIK3SUxgjn570z76QkrqMmblLHlmpUmwUmUAMyXRnXQpu3OfLYN36
 vNLN072ELP4BD6/RvhvMMKT8Pdy86QrjR4qbbFhcjaq/AUVLnSmIbjfXwUCGd61KZjdD
 5O/Tv6Y7PddQv/AqGPxAH7zIYKtBBNCu8pUzVzAI0qdWEJ7DEbhfvdHAGtJX/1SzH2eY
 iuZBAWacrKcmY8H2ya56TgspQfyyoXgo1RrsYxl+F4ednQkre9JkJzYW1krjL/ipNSs8
 HAXQ==
X-Gm-Message-State: AOJu0YzSYykXMLDFA8CkUv3h35SU2IqZExAwo18tEVgInitUcdRdZPVd
 ZCI/Pj2+TQaW33+yszQyd0nC6psJ3LreM67f35yttag7ZQ9Odks5lb5RGh2g74JMKwudP8toP7Y
 P6roZqa5GDo2GcTk329F7DsaNnBUYCRLogcPHK5Un+77jSqGsrIgRru71
X-Gm-Gg: AY/fxX6BwcC/W+0L5inYwRJH3B4BQq3XL4RF/w7Y2DTKJyJmYspaoh1aTcqVDv+YaGN
 ZnRUdOPMgBMADUKx+LpHg2doc2ErQQUFM+5lti07ce0nxY0z0V8QswYZCXb8vIuHJCyXv4G0ieX
 o0MpNlvxIPP5x6237147Ld4sZ24Yj/k5OyfO5lwDP1I+FNyehB0z68PXAe+5hU3KV5sW2xQapFD
 8K5s2jX3Whr2H2l7zX30/9I8EqsnYPXF9FqnghiRRvzaweE8Gr5Q27mmLFBC3tUqmNuXdbDyUG+
 OeusBcYnJlBFLu1/6XP/nr1Y3xM2qXkxv+lkcAuxE5OUQy/CUkJD3TVEeco1UqjffaclISJJmt1
 s75I=
X-Received: by 2002:a05:6214:1309:b0:888:1f18:7a0a with SMTP id
 6a1803df08f44-8887e01e6cfmr254718816d6.23.1765905862725; 
 Tue, 16 Dec 2025 09:24:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8cmDG6RYWFwhRxjGvMTBZD+Q7iBQVDsQ2kedH7luWJyoon55cT2FFF/pOA8cz9LqBC3dwMQ==
X-Received: by 2002:a05:6214:1309:b0:888:1f18:7a0a with SMTP id
 6a1803df08f44-8887e01e6cfmr254718386d6.23.1765905862181; 
 Tue, 16 Dec 2025 09:24:22 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-889a85eaf02sm77451336d6.40.2025.12.16.09.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 09:24:21 -0800 (PST)
Date: Tue, 16 Dec 2025 12:24:20 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 05/51] migration: Normalize tls arguments
Message-ID: <aUGVxIHNbVDba2dc@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-6-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251215220041.12657-6-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Dec 15, 2025 at 06:59:51PM -0300, Fabiano Rosas wrote:
> The migration parameters tls_creds, tls_authz and tls_hostname
> currently have a non-uniform handling. When used as arguments to
> migrate-set-parameters, their type is StrOrNull and when used as
> return value from query-migrate-parameters their type is a plain
> string.
> 
> Not only having to convert between the types is cumbersome, but it
> also creates the issue of requiring two different QAPI types to be
> used, one for each command. MigrateSetParameters is used for
> migrate-set-parameters with the TLS arguments as StrOrNull while
> MigrationParameters is used for query-migrate-parameters with the TLS
> arguments as str.
> 
> Since StrOrNull could be considered a superset of str, change the type
> of the TLS arguments in MigrationParameters to StrOrNull. Also ensure
> that QTYPE_QNULL is never used.
> 
> 1) migrate-set-parameters will always write QTYPE_QSTRING to
>   s->parameters, either an empty or non-empty string.
> 
> 2) query-migrate-parameters will always return a QTYPE_QSTRING, either
>   empty or non-empty.
> 
> 3) the migrate_tls_* helpers will always return a non-empty string or
>   NULL, for the internal migration code's consumption.
> 
> Points (1) and (2) above help simplify the parameters validation and
> the query command handling because s->parameters is already kept in
> the format that query-migrate-parameters (and info migrate_paramters)
> expect. Point (3) is so people don't need to care about StrOrNull in
> migration code.
> 
> This will allow the type duplication to be removed in the next
> patches.
> 
> Note that the type of @tls_creds, @tls-hostname, @tls-authz changes
> from str to StrOrNull in introspection of the query-migrate-parameters
> command. We accept this imprecision to enable de-duplication.
> 
> There's no need to free the TLS options in
> migration_instance_finalize() because they're freed by the qdev
> properties .release method.
> 
> Temporary in this patch:
> migrate_params_test_apply() copies s->parameters into a temporary
> structure, so it's necessary to drop the references to the TLS options
> if they were not set by the user to avoid double-free. This is fixed
> in the next patches.
> 
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

[...]

> @@ -403,6 +403,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>          monitor_printf(mon, "%s: %" PRIu64 " bytes\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE),
>              params->xbzrle_cache_size);
> +        monitor_printf(mon, "%s: %" PRIu64 "\n",
> +            MigrationParameter_str(MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH),
> +            params->max_postcopy_bandwidth);
>  
>          if (params->has_block_bitmap_mapping) {
>              const BitmapMigrationNodeAliasList *bmnal;

This chunk seems to be introduced by accident and removed in patch 18..

After removal, feel free to take:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


