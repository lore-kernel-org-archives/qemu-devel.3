Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532F0C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 06:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWUEb-0005im-Dv; Tue, 01 Jul 2025 02:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uWUEW-0005gg-3j
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 02:12:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uWUEQ-00020i-NH
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 02:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751350355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rHm8QtJomVdIIomRwvQkD2iJ0uJq7s/y8MEor/5vG/U=;
 b=XoyIxOA1YQMhqWs6aFj6dtcS/T1Nv8dvhyVPWN6M2OkK4WPv/3X8rimOvpu80Kp1ZRAw5g
 spQ7J4dMlpfalAujG0Hpl09zAav1zkdpx0GbQ+bUCo+OVjJskLyOo+XqO3i3kNbHuy3E4+
 RpvI3JQd3qwyu8iN2uWbiSLvm8o53z8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-6B5PUjQANXy1WBz3nHMYyg-1; Tue,
 01 Jul 2025 02:12:32 -0400
X-MC-Unique: 6B5PUjQANXy1WBz3nHMYyg-1
X-Mimecast-MFC-AGG-ID: 6B5PUjQANXy1WBz3nHMYyg_1751350351
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0EE17180120E; Tue,  1 Jul 2025 06:12:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B51BE19560AB; Tue,  1 Jul 2025 06:12:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F1D4021E6A27; Tue, 01 Jul 2025 08:12:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v2 01/24] migration: Fix leak of block_bitmap_mapping
In-Reply-To: <20250630195913.28033-2-farosas@suse.de> (Fabiano Rosas's message
 of "Mon, 30 Jun 2025 16:58:50 -0300")
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-2-farosas@suse.de>
Date: Tue, 01 Jul 2025 08:12:27 +0200
Message-ID: <87h5zw4eyc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Fabiano Rosas <farosas@suse.de> writes:

> Caught by inspection, but ASAN also reports:
>
> Direct leak of 16 byte(s) in 1 object(s) allocated from:
>  #0 in malloc
>  #1 in g_malloc
>  #2 in g_memdup
>  #3 in qapi_clone_start_struct ../qapi/qapi-clone-visitor.c:40:12
>  #4 in qapi_clone_start_list ../qapi/qapi-clone-visitor.c:59:12
>  #5 in visit_start_list ../qapi/qapi-visit-core.c:80:10
>  #6 in visit_type_BitmapMigrationNodeAliasList qapi/qapi-visit-migration.c:639:10
>  #7 in migrate_params_apply ../migration/options.c:1407:13
>  #8 in qmp_migrate_set_parameters ../migration/options.c:1463:5
>  #9 in qmp_marshal_migrate_set_parameters qapi/qapi-commands-migration.c:214:5
>  #10 in do_qmp_dispatch_bh ../qapi/qmp-dispatch.c:128:5

migration_instance_finalize() runs when a TYPE_MIGRATION object dies, we
have just one such object, pointed to by @current_migration, and it
lives until QEMU shuts down.

So this is as harmless as they get.  Please mentions this in the commit
message, to guide backporters.

> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 4098870bce..7ec60d97f9 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -4050,6 +4050,7 @@ static void migration_instance_finalize(Object *obj)
>  {
>      MigrationState *ms = MIGRATION_OBJ(obj);
>  
> +    qapi_free_BitmapMigrationNodeAliasList(ms->parameters.block_bitmap_mapping);
>      qemu_mutex_destroy(&ms->error_mutex);
>      qemu_mutex_destroy(&ms->qemu_file_lock);
>      qemu_sem_destroy(&ms->wait_unplug_sem);

With an adjusted commit message:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


