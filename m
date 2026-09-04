Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822FEC624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 09:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2PtM-00036v-L8; Fri, 04 Sep 2026 05:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x2PtJ-00036l-W7
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 05:07:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x2PtI-0000pZ-0y
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 05:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788512838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jTqCEBISiF7q5OKiVie1ci8PyrFe0fDi7VeOpYdJVoQ=;
 b=evZilPuDWdGk38a+6eSFVeV+b2daZ+CoNstmZjj11XuYRc3SDrvQOsSIV8UprgzSxqw6Qv
 PjcZ22wAjMtxxMEq7X2O9qqVhfjsR8aNLWdKZDSxUgJwE7WI1Tp3vhMirV3sbg3FbXcsfw
 gqo7UV4li2VnmYe73+qn8sol4ewD7wE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-jPdianYnMoCNpY_jv60N6A-1; Fri,
 04 Sep 2026 05:07:14 -0400
X-MC-Unique: jPdianYnMoCNpY_jv60N6A-1
X-Mimecast-MFC-AGG-ID: jPdianYnMoCNpY_jv60N6A_1788512834
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A368B1955F0F; Fri,  4 Sep 2026 09:07:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B5B6180034C; Fri,  4 Sep 2026 09:07:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BD4C721E6A04; Fri, 04 Sep 2026 11:07:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH 15/18] qapi/migration: Remove MigrationParameter
In-Reply-To: <20260902221547.1812481-16-farosas@suse.de> (Fabiano Rosas's
 message of "Wed, 2 Sep 2026 19:15:43 -0300")
References: <20260902221547.1812481-1-farosas@suse.de>
 <20260902221547.1812481-16-farosas@suse.de>
Date: Fri, 04 Sep 2026 11:07:10 +0200
Message-ID: <87bjad9ygx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Fabiano Rosas <farosas@suse.de> writes:

> This enum is convenient in two ways (just how enums work):
>
> 1- It provides the number of migration parameters as its __MAX member.
>
> 2- It allows iterating over an integer range and get a migration
>    parameter name string corresponding to that position in the enum.
>
> The migration code doesn't have the need for (2) anymore.
>
> Balancing the benefit of (1) versus the disadvantage of requiring
> migration.json to be updated in two different places whenever a
> parameter is added, experience shows that the latter churn is enough
> to decide to remove the enum.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/options.c |  6 +-----
>  qapi/migration.json | 36 ------------------------------------
>  2 files changed, 1 insertion(+), 41 deletions(-)
>
> diff --git a/migration/options.c b/migration/options.c
> index 5d17acdd881..f988b181f0e 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -1127,7 +1127,6 @@ static MigrationParameters *migrate_params_from_dict(QDict *d, Error **errp)
>   */
>  static void migrate_mark_all_params_present(MigrationParameters *p)
>  {
> -    int len, n_str_args = 3; /* tls-creds, tls-hostname, tls-authz */
>      bool *has_fields[] = {
>          &p->has_throttle_trigger_threshold, &p->has_cpu_throttle_initial,
>          &p->has_cpu_throttle_increment, &p->has_cpu_throttle_tailslow,
> @@ -1144,10 +1143,7 @@ static void migrate_mark_all_params_present(MigrationParameters *p)
>          &p->has_x_rdma_chunk_size, &p->has_cpr_exec_command,
>      };
>  
> -    len = ARRAY_SIZE(has_fields);
> -    assert(len + n_str_args == MIGRATION_PARAMETER__MAX);
> -
> -    for (int i = 0; i < len; i++) {
> +    for (int i = 0; i < ARRAY_SIZE(has_fields); i++) {
>          *has_fields[i] = true;
>      }
>  }

We lose the guard against forgetting to update has_fields[].  It's the
last user of MigrationParameter.  I agree the guard doesn't justify
keeping MigrationParameter.

The guard is somewhat unclean anyway: it assumes the number of
MigrationParameter values matches the number of MigrationParameters
members.

Add a non-doc comment to MigrationParameters to remind of of updating
has_fields[] when it changes?

We don't have a convenient way to find the number of members.

> diff --git a/qapi/migration.json b/qapi/migration.json
> index b1eaf7b0545..78c6e933cf1 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -796,42 +796,6 @@
>        'bitmaps': [ 'BitmapMigrationBitmapAlias' ]
>    } }
>  
> -##
> -# @MigrationParameter:
> -#
> -# Migration parameters enumeration.  The enumeration values mirror the
> -# members of @MigrationParameters.
> -#
> -# Features:
> -#
> -# @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and
> -#     @x-vcpu-dirty-limit-period are experimental.
> -#
> -# Since: 2.4
> -##
> -{ 'enum': 'MigrationParameter',
> -  'data': ['announce-initial', 'announce-max',
> -           'announce-rounds', 'announce-step',
> -           'throttle-trigger-threshold',
> -           'cpu-throttle-initial', 'cpu-throttle-increment',
> -           'cpu-throttle-tailslow',
> -           'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
> -           'avail-switchover-bandwidth', 'downtime-limit',
> -           { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
> -           'multifd-channels',
> -           'xbzrle-cache-size', 'max-postcopy-bandwidth',
> -           'max-cpu-throttle', 'multifd-compression',
> -           'multifd-zlib-level', 'multifd-zstd-level',
> -           'multifd-qatzip-level',
> -           'block-bitmap-mapping',
> -           { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
> -           'vcpu-dirty-limit',
> -           'mode',
> -           'zero-page-detection',
> -           'direct-io',
> -           { 'name': 'x-rdma-chunk-size', 'features': [ 'unstable' ] },
> -           'cpr-exec-command'] }
> -
>  ##
>  # @migrate-set-parameters:
>  #

Reviewed-by: Markus Armbruster <armbru@redhat.com>


