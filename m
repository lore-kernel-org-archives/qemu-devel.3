Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C46CCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 06:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Blw-0003P3-DX; Mon, 13 Oct 2025 02:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1v8Blt-0003Ov-G6
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 02:11:02 -0400
Received: from [115.124.30.130] (helo=out30-130.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1v8Blq-0005QX-1M
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 02:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1760335831; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=wjnZare1Q2opQ1lfmHWfJ62Q7cpoUOwEIlcdh1/yOHM=;
 b=xKpj0HiIbYF7RFJ8rmd3bImrGyiApKvDl4Smf8uJ4i8r9dCuO1l5RHHfcfaQdQNPKc6CQhXiaerFkj0O4ijI+dsBpDzWF6a6482SNpcl5xjwAdFSo6MhAkVW78mlF9VLRhyGiMpbWw+5NOrtckNuL7bUmaNRLhvuXMcRWznCxl8=
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0Wq.Jf3i_1760335824 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 13 Oct 2025 14:10:30 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: farosas@suse.de
Cc: peterx@redhat.com,
	qemu-devel@nongnu.org
Subject: re: [PATCH v2 06/24] migration: Run a post update routine after
 setting parameters
Date: Mon, 13 Oct 2025 14:10:24 +0800
Message-Id: <20251013061024.31814-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250630195913.28033-7-farosas@suse.de>
References: <20250630195913.28033-7-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.130 (deferred)
Received-SPF: pass client-ip=115.124.30.130;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-130.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

Fabiano Rosas wrote on Mon, 30 Jun 2025 16:58:55 -0300:

> Some migration parameters are updated immediately once they are set
> via migrate-set-parameters. Move that work outside of
> migrate_params_apply() and leave that function with the single
> responsibility of setting s->parameters and not doing any
> side-effects.
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> 
> diff --git a/migration/options.c b/migration/options.c
> index 295367ce92..1f8a977865 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -1083,6 +1083,31 @@ void migrate_params_init(MigrationParameters *params)
>      params->has_direct_io = true;
>  }
>  
> +static void migrate_post_update_params(MigrationParameters *new, Error **errp)
> +{
> +    MigrationState *s = migrate_get_current();
> +
> +    if (new->has_max_bandwidth) {
> +        if (s->to_dst_file && !migration_in_postcopy()) {
> +            migration_rate_set(new->max_bandwidth);
> +        }
> +    }
> +
> +    if (new->has_x_checkpoint_delay) {
> +        colo_checkpoint_delay_set();
> +    }
> +
> +    if (new->has_xbzrle_cache_size) {
> +        xbzrle_cache_resize(new->xbzrle_cache_size, errp);
> +    }
> +
> +    if (new->has_max_postcopy_bandwidth) {
> +        if (s->to_dst_file && migration_in_postcopy()) {
> +            migration_rate_set(new->max_postcopy_bandwidth);
> +        }
> +    }
> +}
> +
>
> diff --git a/migration/ram.c b/migration/ram.c
> index 2140785a05..7432f82bdd 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -174,7 +174,7 @@ static void XBZRLE_cache_unlock(void)
>  /**
>   * xbzrle_cache_resize: resize the xbzrle cache
>   *
> - * This function is called from migrate_params_apply in main
> + * This function is called from migrate_post_update_config in main
>   * thread, possibly while a migration is in progress.  A running
>   * migration may be using the cache and might finish during this call,
>   * hence changes to the cache are protected by XBZRLE.lock().
> -- 

The function is migrate_post_update_params, 
but the comment says migrate_post_update_config.

--
Regards,
Bin Guo


