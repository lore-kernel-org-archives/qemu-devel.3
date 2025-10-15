Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2830CCD184
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 02:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8r4R-0002Ah-Rk; Tue, 14 Oct 2025 22:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1v8r4O-0002AT-Pv
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 22:16:52 -0400
Received: from [115.124.30.131] (helo=out30-131.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1v8r4H-0002rq-N0
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 22:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1760494571; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=wcVRMWC2NyfDNGZb+r8rMOkkj6DesW0Pxxs3Cx8OVjc=;
 b=b6Ey9mN0ZabYzZisN6zcIrogSg11E5lF7blrI8w0MLFxQJ0KX1V2eWAcXYM0ku67AamvQ/jJPmvh7ukSMsFclwTWkVDnyb9Ch3IAUhAjzNT/dYE4Xq0aaVVwwQw5Sov6cdToosThUU7nCSox3jm8IjxQdMq+T04i48eyYug4FTY=
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0WqEP3yB_1760494564 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 15 Oct 2025 10:16:10 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: farosas@suse.de
Cc: peterx@redhat.com,
	qemu-devel@nongnu.org
Subject: Re: [PATCH v2 14/24] migration: Use visitors in
 migrate_params_test_apply
Date: Wed, 15 Oct 2025 10:16:03 +0800
Message-Id: <20251015021603.21933-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250630195913.28033-15-farosas@suse.de>
References: <20250630195913.28033-15-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.131 (deferred)
Received-SPF: pass client-ip=115.124.30.131;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-131.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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

Fabiano Rosas wrote on Mon, 30 Jun 2025 16:59:03 -0300:

> Convert the code in migrate_params_test_apply() from an open-coded
> copy of every migration parameter to a copy using visitors. The
> current code has conditionals for each parameter's has_* field, which
> is exactly what the visitors do.
> 
> This hides the details of QAPI from the migration code and avoids the
> need to update migrate_params_test_apply() every time a new migration
> parameter is added. Both were very confusing and while the visitor
> code can become a bit involved, there is no need for new contributors
> to ever touch it.
> 
> Change the name of the function to a more direct reference of what it
> does: merging the user params with the temporary copy.
> 
> Move the QAPI_CLONE_MEMBERS into the caller, so QAPI_CLONE can be used
> and there's no need to allocate memory in the migration
> code. Similarly, turn 'tmp' into a pointer so the proper qapi_free_
> routine can be used.
> 
> An extra call to migrate_mark_all_params_present() is now needed
> because the visitors update the has_ field for non-present fields, but
> we actually want them all set so migrate_params_apply() can copy all
> of them.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/options.c | 157 +++++++++++++++-----------------------------
>  1 file changed, 54 insertions(+), 103 deletions(-)
> 
> diff --git a/migration/options.c b/migration/options.c
> index 6619b5f21a..695bec5b8f 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> 
> -static void migrate_params_test_apply(MigrationParameters *params,
> -                                      MigrationParameters *dest)
> +static bool migrate_params_merge(MigrationParameters *dst,
> +
> +    ...
> +    /* read in from src */
> +    v = qobject_output_visitor_new(&ret_out);
> +    ok = visit_type_MigrationParameters(v, NULL, &src, errp);
> +    if (!ok) {
> +        goto out;
>      }
> +    visit_complete(v, &ret_out);
> +    visit_free(v);
>  
> -    if (params->has_max_bandwidth) {
> -        dest->max_bandwidth = params->max_bandwidth;
> +    /*
> +     * Write to dst but leave existing fields intact (except for has_*
> +     * which will be updated according to their presence in src).
> +     */
> +    v = qobject_input_visitor_new(ret_out);
> +    ok = visit_start_struct(v, NULL, NULL, 0, errp);
> +    if (!ok) {
> +        goto out;
>      }
> -
> -    if (params->has_avail_switchover_bandwidth) {
> -        dest->avail_switchover_bandwidth = params->avail_switchover_bandwidth;
> +    ok = visit_type_MigrationParameters_members(v, dst, errp);
> +    if (!ok) {
> +        goto out;
>      }
> -
> -    if (params->has_downtime_limit) {
> -        dest->downtime_limit = params->downtime_limit;
> +    ok = visit_check_struct(v, errp);
> +    visit_end_struct(v, NULL);
> +    if (!ok) {
> +        goto out;
>      }
>  
> -    if (params->has_x_checkpoint_delay) {
> -        dest->x_checkpoint_delay = params->x_checkpoint_delay;
> -    }
> +out:
> +    visit_free(v);
> +    qobject_unref(ret_out);
> +    return ok;
> }

If visit_start_struct is executed successfully, then visit_end_struct
should be executed. IMHO:

    v = qobject_input_visitor_new(ret_out);
    ok = visit_start_struct(v, NULL, NULL, 0, errp);
    if (!ok) {
        goto out;
    }

    ok = visit_type_MigrationParameters_members(v, dst, errp);
    if (!ok) {
        goto out_end;
    }

    ok = visit_check_struct(v, errp);

out_end:
    visit_end_struct(v, NULL);

out:
    visit_free(v);
    qobject_unref(ret_out);

    return ok;
}


>  void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>  {
> -    MigrationParameters tmp;
> +    MigrationState *s = migrate_get_current();
> +    g_autoptr(MigrationParameters) tmp = QAPI_CLONE(MigrationParameters,
> +                                                    &s->parameters);
>  
>      /*
>       * Convert QTYPE_QNULL and NULL to the empty string (""). Even
> @@ -1367,7 +1316,9 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>      tls_opt_to_str(&params->tls_hostname);
>      tls_opt_to_str(&params->tls_authz);
>  
> -    migrate_params_test_apply(params, &tmp);
> +    if (!migrate_params_merge(tmp, params, errp)) {
> +        return;
> +    }
>  
>      /*
>       * Mark block_bitmap_mapping as present now while we have the
> @@ -1377,10 +1328,10 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>          migrate_get_current()->has_block_bitmap_mapping = true;
>      }

s->has_block_bitmap_mapping = true;

>  
> -    if (migrate_params_check(&tmp, errp)) {
> -        migrate_params_apply(&tmp);
> +    if (migrate_params_check(tmp, errp)) {
> +        /* mark all present, so they're all copied */
> +        migrate_mark_all_params_present(tmp);
> +        migrate_params_apply(tmp);
>          migrate_post_update_params(params, errp);
>      }
> -
> -    migrate_tls_opts_free(&tmp);
>  }

--
Bin Guo

