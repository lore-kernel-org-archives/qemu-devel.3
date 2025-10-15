Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBF5CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 02:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8rJH-0007HZ-Iu; Tue, 14 Oct 2025 22:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1v8rJ5-0007Fu-JE
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 22:32:03 -0400
Received: from [115.124.30.101] (helo=out30-101.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1v8rIu-0004gb-Al
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 22:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1760495481; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=p5Ue8vdwtiJkUWGD86zV+nx690zj7ppnrkqoLBzyCTQ=;
 b=WpzCn1K4AAflJ8YtygB9f4Q9sHaXNvhMA/JQYl8MANyL68TBKKxGyMKh7joObRoQh+smNJYrYVcqZl1xOLqxXn84moC1+5a6YdLATUq76JFdVuE9euiXiuLkkYVYrArSnyDI/7FMka7gjKnqROsFyX5CgPktAG6jMzityURX1l0=
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0WqEFqm3_1760495474 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 15 Oct 2025 10:31:20 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: farosas@suse.de
Cc: peterx@redhat.com,
	qemu-devel@nongnu.org
Subject: Re: [PATCH v2 03/24] migration: Normalize tls arguments
Date: Wed, 15 Oct 2025 10:31:14 +0800
Message-Id: <20251015023114.24876-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250630195913.28033-4-farosas@suse.de>
References: <20250630195913.28033-4-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.101 (deferred)
Received-SPF: pass client-ip=115.124.30.101;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-101.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, RDNS_NONE=0.793, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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

Fabiano Rosas wrote on Mon, 30 Jun 2025 16:58:52 -0300:

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
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration-hmp-cmds.c |   7 +-
>  migration/options.c            | 156 ++++++++++++++++++++-------------
>  migration/options.h            |   1 +
>  migration/tls.c                |   2 +-
>  qapi/migration.json            |   6 +-
>  5 files changed, 106 insertions(+), 66 deletions(-)
> 
> +void migrate_tls_opts_free(MigrationParameters *params)
> +{
> +    qapi_free_StrOrNull(params->tls_creds);
> +    qapi_free_StrOrNull(params->tls_hostname);
> +    qapi_free_StrOrNull(params->tls_authz);
> +}
> +
> +/* either non-empty or empty string */
> +static void tls_opt_to_str(StrOrNull **tls_opt)
> +{
> +    StrOrNull *opt = *tls_opt;
> +
> +    if (!opt) {
> +        return;
> +    }
> +
> +    switch (opt->type) {
> +    case QTYPE_QSTRING:
> +        return;
> +    case QTYPE_QNULL:
> +        qobject_unref(opt->u.n);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    opt->type = QTYPE_QSTRING;
> +    opt->u.s = g_strdup("");
> +    *tls_opt = opt;
> +}
> +

Can these two functions be changed to be general, not just for tls?
IMHO: 
void migrate_strornull_opts_free(MigrationParameters *params)
boid strornull_to_str(StrOrNull **the_opt)

In this way, when members of type StrOrNull are added later,
the function can be reused.

--
Bin Guo


