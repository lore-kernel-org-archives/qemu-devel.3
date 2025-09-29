Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF52CAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 14:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Er9-0006iO-IV; Mon, 29 Sep 2025 10:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v3Er8-0006hw-81
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 10:27:58 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v3Eqv-00053R-R4
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 10:27:57 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8A55F35A3C;
 Mon, 29 Sep 2025 14:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759156059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nCmIXlybo0UT2/Da6tTTiKtwwxR7XikyvE0V4c+boGY=;
 b=e/dug/Q6UF59uYEgiNEsomOpmpvb3xnDDFsyq7ZFNDC6mNUtvwcnr8UxK5h1S/2Rxsm+9s
 fnmqIejo8Hdpjsi5bagEdflh9JonpqNEACaXDtZVo9nnmSJA3YfM5k5EkxMxoVtRbaAkyG
 cshAT2VHbfcxoFPExqx4vqbyCjjwuJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759156059;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nCmIXlybo0UT2/Da6tTTiKtwwxR7XikyvE0V4c+boGY=;
 b=Mh2rOyA8PqPmZ9jERTda7lKafRWsJum3iIqLiRe3R2HUu293nIrFCi6clWMhzF69xw9zBL
 i5j5vF26PRMpn3CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759156059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nCmIXlybo0UT2/Da6tTTiKtwwxR7XikyvE0V4c+boGY=;
 b=e/dug/Q6UF59uYEgiNEsomOpmpvb3xnDDFsyq7ZFNDC6mNUtvwcnr8UxK5h1S/2Rxsm+9s
 fnmqIejo8Hdpjsi5bagEdflh9JonpqNEACaXDtZVo9nnmSJA3YfM5k5EkxMxoVtRbaAkyG
 cshAT2VHbfcxoFPExqx4vqbyCjjwuJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759156059;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nCmIXlybo0UT2/Da6tTTiKtwwxR7XikyvE0V4c+boGY=;
 b=Mh2rOyA8PqPmZ9jERTda7lKafRWsJum3iIqLiRe3R2HUu293nIrFCi6clWMhzF69xw9zBL
 i5j5vF26PRMpn3CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0423713A21;
 Mon, 29 Sep 2025 14:27:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tlTJLFqX2mhlMAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 29 Sep 2025 14:27:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Bin Guo <guobin@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com
Subject: Re: [PATCH] migration: Use QAPI_CLONE() instead of duplicating it
 inline
In-Reply-To: <20250929080115.98072-1-guobin@linux.alibaba.com>
References: <20250929080115.98072-1-guobin@linux.alibaba.com>
Date: Mon, 29 Sep 2025 11:27:36 -0300
Message-ID: <87a52dwcyv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Bin Guo <guobin@linux.alibaba.com> writes:

> It's better to use QAPI_CLONE() in qmp_query_migrate_parameters so that
> the code is cleaner.
>

Thanks, but this is a can of worms that needs to be opened very
slowly. Could you help test/review my series instead?

https://lore.kernel.org/r/20250630195913.28033-1-farosas@suse.de

> No functional changes intended.
>
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>  migration/options.c | 70 ++-------------------------------------------
>  1 file changed, 3 insertions(+), 67 deletions(-)
>
> diff --git a/migration/options.c b/migration/options.c
> index 4e923a2e07..347d762b03 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -892,81 +892,16 @@ AnnounceParameters *migrate_announce_params(void)
>  
>  MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>  {
> -    MigrationParameters *params;
>      MigrationState *s = migrate_get_current();
>  
> -    /* TODO use QAPI_CLONE() instead of duplicating it inline */
> -    params = g_malloc0(sizeof(*params));
> -    params->has_throttle_trigger_threshold = true;
> -    params->throttle_trigger_threshold = s->parameters.throttle_trigger_threshold;
> -    params->has_cpu_throttle_initial = true;
> -    params->cpu_throttle_initial = s->parameters.cpu_throttle_initial;
> -    params->has_cpu_throttle_increment = true;
> -    params->cpu_throttle_increment = s->parameters.cpu_throttle_increment;
> -    params->has_cpu_throttle_tailslow = true;
> -    params->cpu_throttle_tailslow = s->parameters.cpu_throttle_tailslow;
> -    params->tls_creds = g_strdup(s->parameters.tls_creds);
> -    params->tls_hostname = g_strdup(s->parameters.tls_hostname);
> -    params->tls_authz = g_strdup(s->parameters.tls_authz ?
> -                                 s->parameters.tls_authz : "");
> -    params->has_max_bandwidth = true;
> -    params->max_bandwidth = s->parameters.max_bandwidth;
> -    params->has_avail_switchover_bandwidth = true;
> -    params->avail_switchover_bandwidth = s->parameters.avail_switchover_bandwidth;
> -    params->has_downtime_limit = true;
> -    params->downtime_limit = s->parameters.downtime_limit;
> -    params->has_x_checkpoint_delay = true;
> -    params->x_checkpoint_delay = s->parameters.x_checkpoint_delay;
> -    params->has_multifd_channels = true;
> -    params->multifd_channels = s->parameters.multifd_channels;
> -    params->has_multifd_compression = true;
> -    params->multifd_compression = s->parameters.multifd_compression;
> -    params->has_multifd_zlib_level = true;
> -    params->multifd_zlib_level = s->parameters.multifd_zlib_level;
> -    params->has_multifd_qatzip_level = true;
> -    params->multifd_qatzip_level = s->parameters.multifd_qatzip_level;
> -    params->has_multifd_zstd_level = true;
> -    params->multifd_zstd_level = s->parameters.multifd_zstd_level;
> -    params->has_xbzrle_cache_size = true;
> -    params->xbzrle_cache_size = s->parameters.xbzrle_cache_size;
> -    params->has_max_postcopy_bandwidth = true;
> -    params->max_postcopy_bandwidth = s->parameters.max_postcopy_bandwidth;
> -    params->has_max_cpu_throttle = true;
> -    params->max_cpu_throttle = s->parameters.max_cpu_throttle;
> -    params->has_announce_initial = true;
> -    params->announce_initial = s->parameters.announce_initial;
> -    params->has_announce_max = true;
> -    params->announce_max = s->parameters.announce_max;
> -    params->has_announce_rounds = true;
> -    params->announce_rounds = s->parameters.announce_rounds;
> -    params->has_announce_step = true;
> -    params->announce_step = s->parameters.announce_step;
> -
> -    if (s->parameters.has_block_bitmap_mapping) {
> -        params->has_block_bitmap_mapping = true;
> -        params->block_bitmap_mapping =
> -            QAPI_CLONE(BitmapMigrationNodeAliasList,
> -                       s->parameters.block_bitmap_mapping);
> -    }
> -
> -    params->has_x_vcpu_dirty_limit_period = true;
> -    params->x_vcpu_dirty_limit_period = s->parameters.x_vcpu_dirty_limit_period;
> -    params->has_vcpu_dirty_limit = true;
> -    params->vcpu_dirty_limit = s->parameters.vcpu_dirty_limit;
> -    params->has_mode = true;
> -    params->mode = s->parameters.mode;
> -    params->has_zero_page_detection = true;
> -    params->zero_page_detection = s->parameters.zero_page_detection;
> -    params->has_direct_io = true;
> -    params->direct_io = s->parameters.direct_io;
> -
> -    return params;
> +    return QAPI_CLONE(MigrationParameters, &s->parameters);
>  }
>  
>  void migrate_params_init(MigrationParameters *params)
>  {
>      params->tls_hostname = g_strdup("");
>      params->tls_creds = g_strdup("");
> +    params->tls_authz = g_strdup("");
>  
>      /* Set has_* up only for parameter checks */
>      params->has_throttle_trigger_threshold = true;
> @@ -974,6 +909,7 @@ void migrate_params_init(MigrationParameters *params)
>      params->has_cpu_throttle_increment = true;
>      params->has_cpu_throttle_tailslow = true;
>      params->has_max_bandwidth = true;
> +    params->has_avail_switchover_bandwidth = true;
>      params->has_downtime_limit = true;
>      params->has_x_checkpoint_delay = true;
>      params->has_multifd_channels = true;

