Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F7FD1CDB7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 08:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3ASX-0002tz-SJ; Tue, 22 Oct 2024 04:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t3ASR-0002t6-J8
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:41:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t3ASP-000295-4F
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729586495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CVcULGItE9cy1iwiiBsfRE6we4SnmlmC4IqTL/+FIUE=;
 b=S6NM7DDqWvYW8GKv4IOBfwjHSNIvJjDHSCY3et3Jkqw18vcZCw5vuVg/xNvZjN4a9HCn/X
 vFyC5IOHR4GQz70m9QCutayC1syvbvox6sG0Kr5mjkP2WxsYNAI79OyXR74hocsWb1z8A9
 rHRo3Nqm3IScwkG2JAkvA840pIfXEVg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-izzC86mRNuK4psXt4jPH4g-1; Tue,
 22 Oct 2024 04:41:34 -0400
X-MC-Unique: izzC86mRNuK4psXt4jPH4g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 830A81955F33; Tue, 22 Oct 2024 08:41:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.150])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1308719560AE; Tue, 22 Oct 2024 08:41:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A7B3821E6A28; Tue, 22 Oct 2024 10:41:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  "Dr . David Alan Gilbert" <dave@treblig.org>,
 Juraj Marcin <jmarcin@redhat.com>,  Prasad Pandit <ppandit@redhat.com>,
 Daniel P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Julia Suvorova
 <jusual@redhat.com>,  Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Deprecate query-migrationthreads command
In-Reply-To: <20241021215220.982325-1-peterx@redhat.com> (Peter Xu's message
 of "Mon, 21 Oct 2024 17:52:20 -0400")
References: <20241021215220.982325-1-peterx@redhat.com>
Date: Tue, 22 Oct 2024 10:41:29 +0200
Message-ID: <87froo34xy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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

Peter Xu <peterx@redhat.com> writes:

> Per previous discussion [1,2], this patch deprecates query-migrationthreads
> command.
>
> To summarize, the major reason of the deprecation is due to no sensible way
> to consume the API properly:
>
>   (1) The reported list of threads are incomplete (ignoring destination
>       threads and non-multifd threads).
>
>   (2) For CPU pinning, there's no way to properly pin the threads with
>       the API if the threads will start running right away after migration
>       threads can be queried, so the threads will always run on the default
>       cores for a short window.
>
>   (3) For VM debugging, one can use "-name $VM,debug-threads=on" instead,
>       which will provide proper names for all migration threads.
>
> [1] https://lore.kernel.org/r/20240930195837.825728-1-peterx@redhat.com
> [2] https://lore.kernel.org/r/20241011153417.516715-1-peterx@redhat.com
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  docs/about/deprecated.rst | 8 ++++++++
>  qapi/migration.json       | 6 +++++-
>  migration/threadinfo.c    | 4 ++++
>  3 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index ce38a3d0cf..ffb147e896 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -147,6 +147,14 @@ options are removed in favor of using explicit ``blockdev-create`` and
>  ``blockdev-add`` calls. See :doc:`/interop/live-block-operations` for
>  details.
>  
> +``query-migrationthreads`` (since 9.2)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +To be removed with no replacement, as it reports only a limited set of
> +threads (for example, it only reports source side of multifd threads,
> +without reporting any destination threads, or non-multifd source threads).
> +For debugging purpose, please use ``-name $VM,debug-threads=on`` instead.

This covers commit message items (1) and (3), but not (2).  Observation,
not objection.

> +
>  Incorrectly typed ``device_add`` arguments (since 6.2)
>  ''''''''''''''''''''''''''''''''''''''''''''''''''''''
>  
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 3af6aa1740..a71a9f0cd3 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -2284,12 +2284,16 @@
>  #
>  # Returns information of migration threads
>  #
> +# Features:

Blank line, please.

> +# @deprecated: This command is deprecated with no replacement yet.
> +#
>  # Returns: @MigrationThreadInfo
>  #
>  # Since: 7.2
>  ##
>  { 'command': 'query-migrationthreads',
> -  'returns': ['MigrationThreadInfo'] }
> +  'returns': ['MigrationThreadInfo'],
> +  'features': ['deprecated'] }
>  
>  ##
>  # @snapshot-save:
> diff --git a/migration/threadinfo.c b/migration/threadinfo.c
> index 262990dd75..2867413420 100644
> --- a/migration/threadinfo.c
> +++ b/migration/threadinfo.c
> @@ -13,6 +13,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/queue.h"
>  #include "qemu/lockable.h"
> +#include "qemu/error-report.h"
>  #include "threadinfo.h"
>  
>  QemuMutex migration_threads_lock;
> @@ -52,6 +53,9 @@ MigrationThreadInfoList *qmp_query_migrationthreads(Error **errp)
>      MigrationThread *thread = NULL;
>  
>      QEMU_LOCK_GUARD(&migration_threads_lock);
> +
> +    warn_report("Command 'query-migrationthreads' is deprecated");

We don't normally do this for QMP commands.

Management applications can use -compat deprecated-input=reject to check
they're not sending deprecated commands or arguments.

Suggest to drop.

> +
>      QLIST_FOREACH(thread, &migration_threads, node) {
>          MigrationThreadInfo *info = g_new0(MigrationThreadInfo, 1);
>          info->name = g_strdup(thread->name);

Acked-by: Markus Armbruster <armbru@redhat.com>


