Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 509F0D116F3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 07:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQhRL-0006L1-JZ; Wed, 03 Dec 2025 02:38:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vQhRK-0006Km-4T
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 02:38:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vQhRH-0002cs-Og
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 02:38:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764747493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2HCN2vGpTIuX/SVU+BrdaVDO6DZpxwI3TaztM236nZc=;
 b=jWvfG0yW4PdQOrUX3WsacU/raqNak8QpCRje74RkXdF5le6BExTZWHUAPZ6GBan2JHyxDX
 edjU0Fp+3AXOr9Dn7mIXEt/XL6eK2fTZ0j3bLuiW3I3I1fI14YDQlgLhJVmQzWbM/5oe2S
 SnKBCs1lVSgWS4sHZBjck7CS9D30/8E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-127-tsopJPn5MNWmG8IKvYPcGQ-1; Wed,
 03 Dec 2025 02:38:10 -0500
X-MC-Unique: tsopJPn5MNWmG8IKvYPcGQ-1
X-Mimecast-MFC-AGG-ID: tsopJPn5MNWmG8IKvYPcGQ_1764747489
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA4871800654; Wed,  3 Dec 2025 07:38:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D30B30001A2; Wed,  3 Dec 2025 07:38:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9239421E6A27; Wed, 03 Dec 2025 08:38:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  berrange@redhat.com,  farosas@suse.de,
 vsementsov@yandex-team.ru,  armbru@redhat.com,
 marcandre.lureau@redhat.com,  jmarcin@redhat.com
Subject: Re: [PATCH for-11.0 v2 8/7] migration: Use error_propagate() in
 migrate_error_propagate()
In-Reply-To: <20251202175317.1186544-1-peterx@redhat.com> (Peter Xu's message
 of "Tue, 2 Dec 2025 12:53:17 -0500")
References: <20251201194510.1121221-1-peterx@redhat.com>
 <20251202175317.1186544-1-peterx@redhat.com>
Date: Wed, 03 Dec 2025 08:38:05 +0100
Message-ID: <87ecpcqale.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> It improves readability, as suggested by Markus.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 70813e5006..d55fde222a 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1555,12 +1555,7 @@ void migrate_error_propagate(MigrationState *s, Error *error)
>  {
>      QEMU_LOCK_GUARD(&s->error_mutex);
>      trace_migrate_error(error_get_pretty(error));
> -
> -    if (!s->error) {
> -        s->error = error;
> -    } else {
> -        error_free(error);
> -    }
> +    error_propagate(&s->error, error);
>  }
>  
>  bool migrate_has_error(MigrationState *s)

Reviewed-by: Markus Armbruster <armbru@redhat.com>


