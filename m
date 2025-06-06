Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD84C5B555
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 15:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNYxZ-0002Cw-T7; Fri, 06 Jun 2025 11:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uNYxW-0002Ci-O7
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 11:26:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uNYxU-0000EE-WC
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 11:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749223575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EHptpcAwiYkORg4zspzI4teCQa+fliFEArRwYiLpLPM=;
 b=Hwcw+4e+RUT74oq+Bwcdv0OAF89FR3k3kkNexf0YgYrmu0O5autwoPKJ4B5K/obrAALXoQ
 4/mSw6ZoCeJAGOorjfq00IMbvsYTw29tMoFU/5rUBdY1F+Vtq4pySRIRjUsknKJ6JIXUXg
 adZU0Sj/Z24PF1riE4RgAyw0sTgK2do=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-rLyr_bFWP22_q92-nE7gGQ-1; Fri, 06 Jun 2025 11:26:12 -0400
X-MC-Unique: rLyr_bFWP22_q92-nE7gGQ-1
X-Mimecast-MFC-AGG-ID: rLyr_bFWP22_q92-nE7gGQ_1749223572
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6fad9167e4cso40780616d6.1
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 08:26:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749223572; x=1749828372;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EHptpcAwiYkORg4zspzI4teCQa+fliFEArRwYiLpLPM=;
 b=JzN38vf1StFXi9j8Do0nhWLg12dYt8+GfOwe2lXF+TwdNJWGn1sY5TMEMtmBDb7gXB
 Jv29bmZ8mMQbPdRth6YJrp1PEuIq6HdXVgVZvV8a8+qzXRGCFnZoKLrtsqcyMzrDHwzq
 NWLrMW0TlXIrB0hYAEvrPx9E1NjIrI38pUVZXCvkT+JWbXDz89DM02pFBXfs3HmwxKvk
 QGXzF5WlneIybeLHt0NcN5IyCRohoM3QezY11OADytyqEuRR/oTg3Uc7vWyivMBM4o09
 PQnU32uuZXKAznTVOnCKiOwWp5Jr4gfSeqSYwVEez1OIXmRBQDJHrDll4vcmrBxdb3Ia
 LV+A==
X-Gm-Message-State: AOJu0YxuyFcC4P9OcyGPdEgiuMi/jjwfdKbtHScW/uAI14fjmHtZkju2
 Gmdf8K5A/jBYdzr19pTJvmTbSQxcMrkfV41BAppaP5pZkItwd9gUtgdo92hhzvaI1V6XiAHjelB
 1070dAh8a+x07FaRmrqi0dgFs455Y3fCvRUSUhpAOKdV+cq6X8e8BcaG4
X-Gm-Gg: ASbGncuzB0mAqYQrR0LG9i3wexGhTp9xC55k/t2lc3+tLJV2OaVIKUryDGMc1563pgk
 m95vHR2A8tWchprA+hwS8Gsl18UF0VATfrb2lQaS8UbRr+cnA/7FH8d6k7kPXqrR6KuGI7KfRF9
 RCIZ1kGdmYprutcRSy4m6RIwq9/Eun47eArzYLdQXk2fRwKLGLHxEA5sfzLSNmOrssPVJLv96Si
 xBMRpqDmA+shp4gtYUMuBJJBLRftwr3R94gUfZwhs+6Y5Addm81WZvkV/h8GgBKYVE1dpFPglH8
 Jos=
X-Received: by 2002:a05:6214:19cd:b0:6fa:9a6a:7d03 with SMTP id
 6a1803df08f44-6fb08f69f31mr68507896d6.7.1749223571960; 
 Fri, 06 Jun 2025 08:26:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwgQPYiLfbQ+IAfV1qpft1RXJCpiL7EA/qbM3eUeLrykgmfupLDY+T4pXsF+dqMU6IE03Q4Q==
X-Received: by 2002:a05:6214:19cd:b0:6fa:9a6a:7d03 with SMTP id
 6a1803df08f44-6fb08f69f31mr68507496d6.7.1749223571592; 
 Fri, 06 Jun 2025 08:26:11 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09aba071sm12647586d6.24.2025.06.06.08.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 08:26:10 -0700 (PDT)
Date: Fri, 6 Jun 2025 11:26:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH 09/21] migration: Extract code to mark all parameters as
 present
Message-ID: <aEMIkKbRsmW_DEMM@x1.local>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-10-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250603013810.4772-10-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Jun 02, 2025 at 10:37:58PM -0300, Fabiano Rosas wrote:
> MigrationParameters needs to have all of its has_* fields marked as
> true when used as the return of query_migrate_parameters because the
> corresponding QMP command has all of its members non-optional by
> design, despite them being marked as optional in migration.json.
> 
> Extract this code into a function and make it assert if any field is
> missing. With this we ensure future changes will not inadvertently
> leave any parameters missing.
> 
> Also assert that s->parameters _does not_ have any of its has_* fields
> set. This structure is internal to the migration code and it should
> not rely on the QAPI-generate has_* fields. We might want to store
> migration parameters differently in the future.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/options.c | 74 ++++++++++++++++++++++++++++-----------------
>  1 file changed, 46 insertions(+), 28 deletions(-)
> 
> diff --git a/migration/options.c b/migration/options.c
> index e2e3ab717f..dd62e726cb 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -936,6 +936,40 @@ static void tls_option_set_str(StrOrNull **dstp, StrOrNull *src)
>      }
>  }
>  
> +static void migrate_mark_all_params_present(MigrationParameters *p)
> +{
> +    int len, n_str_args = 3; /* tls-creds, tls-hostname, tls-authz */

Could you remind me why we don't set has_*=true for these three?

> +    bool *has_fields[] = {
> +        &p->has_throttle_trigger_threshold, &p->has_cpu_throttle_initial,
> +        &p->has_cpu_throttle_increment, &p->has_cpu_throttle_tailslow,
> +        &p->has_max_bandwidth, &p->has_avail_switchover_bandwidth,
> +        &p->has_downtime_limit, &p->has_x_checkpoint_delay,
> +        &p->has_multifd_channels, &p->has_multifd_compression,
> +        &p->has_multifd_zlib_level, &p->has_multifd_qatzip_level,
> +        &p->has_multifd_zstd_level, &p->has_xbzrle_cache_size,
> +        &p->has_max_postcopy_bandwidth, &p->has_max_cpu_throttle,
> +        &p->has_announce_initial, &p->has_announce_max, &p->has_announce_rounds,
> +        &p->has_announce_step, &p->has_block_bitmap_mapping,
> +        &p->has_x_vcpu_dirty_limit_period, &p->has_vcpu_dirty_limit,
> +        &p->has_mode, &p->has_zero_page_detection, &p->has_direct_io,
> +    };
> +
> +    /*
> +     * The has_* fields of MigrationParameters are used by QAPI to
> +     * inform whether an optional struct member is present. Keep this
> +     * decoupled from the internal usage (not QAPI) by leaving the
> +     * has_* fields of s->parameters unused.
> +     */
> +    assert(p != &(migrate_get_current())->parameters);

This is OK, I'm not sure whether we're over-cautious though.. but..

> +
> +    len = ARRAY_SIZE(has_fields);
> +    assert(len + n_str_args == MIGRATION_PARAMETER__MAX);

.. I definitely like this assert.

> +
> +    for (int i = 0; i < len; i++) {
> +        *has_fields[i] = true;
> +    }
> +}
> +
>  MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>  {
>      MigrationParameters *params;
> @@ -943,68 +977,52 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>  
>      /* TODO use QAPI_CLONE() instead of duplicating it inline */
>      params = g_malloc0(sizeof(*params));
> -    params->has_throttle_trigger_threshold = true;
> +
>      params->throttle_trigger_threshold = s->parameters.throttle_trigger_threshold;
> -    params->has_cpu_throttle_initial = true;
>      params->cpu_throttle_initial = s->parameters.cpu_throttle_initial;
> -    params->has_cpu_throttle_increment = true;
>      params->cpu_throttle_increment = s->parameters.cpu_throttle_increment;
> -    params->has_cpu_throttle_tailslow = true;
>      params->cpu_throttle_tailslow = s->parameters.cpu_throttle_tailslow;
>  
>      tls_option_set_str(&params->tls_creds, s->parameters.tls_creds);
>      tls_option_set_str(&params->tls_hostname, s->parameters.tls_hostname);
>      tls_option_set_str(&params->tls_authz, s->parameters.tls_authz);
>  
> -    params->has_max_bandwidth = true;
>      params->max_bandwidth = s->parameters.max_bandwidth;
> -    params->has_avail_switchover_bandwidth = true;
>      params->avail_switchover_bandwidth = s->parameters.avail_switchover_bandwidth;
> -    params->has_downtime_limit = true;
>      params->downtime_limit = s->parameters.downtime_limit;
> -    params->has_x_checkpoint_delay = true;
>      params->x_checkpoint_delay = s->parameters.x_checkpoint_delay;
> -    params->has_multifd_channels = true;
>      params->multifd_channels = s->parameters.multifd_channels;
> -    params->has_multifd_compression = true;
>      params->multifd_compression = s->parameters.multifd_compression;
> -    params->has_multifd_zlib_level = true;
>      params->multifd_zlib_level = s->parameters.multifd_zlib_level;
> -    params->has_multifd_qatzip_level = true;
>      params->multifd_qatzip_level = s->parameters.multifd_qatzip_level;
> -    params->has_multifd_zstd_level = true;
>      params->multifd_zstd_level = s->parameters.multifd_zstd_level;
> -    params->has_xbzrle_cache_size = true;
>      params->xbzrle_cache_size = s->parameters.xbzrle_cache_size;
> -    params->has_max_postcopy_bandwidth = true;
>      params->max_postcopy_bandwidth = s->parameters.max_postcopy_bandwidth;
> -    params->has_max_cpu_throttle = true;
>      params->max_cpu_throttle = s->parameters.max_cpu_throttle;
> -    params->has_announce_initial = true;
>      params->announce_initial = s->parameters.announce_initial;
> -    params->has_announce_max = true;
>      params->announce_max = s->parameters.announce_max;
> -    params->has_announce_rounds = true;
>      params->announce_rounds = s->parameters.announce_rounds;
> -    params->has_announce_step = true;
>      params->announce_step = s->parameters.announce_step;
> -
> -    params->has_block_bitmap_mapping = true;
>      params->block_bitmap_mapping =
>          QAPI_CLONE(BitmapMigrationNodeAliasList,
>                     s->parameters.block_bitmap_mapping);
> -
> -    params->has_x_vcpu_dirty_limit_period = true;
>      params->x_vcpu_dirty_limit_period = s->parameters.x_vcpu_dirty_limit_period;
> -    params->has_vcpu_dirty_limit = true;
>      params->vcpu_dirty_limit = s->parameters.vcpu_dirty_limit;
> -    params->has_mode = true;
>      params->mode = s->parameters.mode;
> -    params->has_zero_page_detection = true;
>      params->zero_page_detection = s->parameters.zero_page_detection;
> -    params->has_direct_io = true;
>      params->direct_io = s->parameters.direct_io;
>  
> +    /*
> +     * query-migrate-parameters expects all members of
> +     * MigrationParameters to be present, but we cannot mark them
> +     * non-optional in QAPI because the structure is also used for
> +     * migrate-set-parameters, which needs the optionality. Force all
> +     * parameters to be seen as present now. Note that this depends on
> +     * some form of default being set for every member of
> +     * MigrationParameters, currently done during qdev init using
> +     * migration_properties defined in this file.
> +     */
> +    migrate_mark_all_params_present(params);
>      return params;
>  }
>  
> -- 
> 2.35.3
> 

-- 
Peter Xu


