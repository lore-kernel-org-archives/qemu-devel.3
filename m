Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1483D116F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 11:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQOmY-0008Sp-B8; Tue, 02 Dec 2025 06:42:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vQOmU-0008PX-Bz
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 06:42:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vQOmS-0000ox-HJ
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 06:42:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764675769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uws2Qxx7YVw76kvPQs2fBAFfwKqlhbobcZOKYWpm1rw=;
 b=LlDE70snQBCCgXBfk82i8i2jxyi999wSphXBFsEU60XExqFW9rP+MyM9cBOX+5OiLbZ2fk
 p/m0pONpeMmTCQ0Xjb2R2ouo6aZUyKleWvxs+ymcE+c+9XdO7d2yGrXnQvn/HUWURyhD7W
 bzSsZmM/g7imRGu937T6O+xQ+0rtLcA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-zl0cWR0JO3-FpwwkcW1EsQ-1; Tue,
 02 Dec 2025 06:42:45 -0500
X-MC-Unique: zl0cWR0JO3-FpwwkcW1EsQ-1
X-Mimecast-MFC-AGG-ID: zl0cWR0JO3-FpwwkcW1EsQ_1764675765
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E57A21956071; Tue,  2 Dec 2025 11:42:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53F2419560A7; Tue,  2 Dec 2025 11:42:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A5B0021E6A27; Tue, 02 Dec 2025 12:42:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH for-11.0 v2 4/7] migration: Make
 migration_connect_set_error() own the error
In-Reply-To: <20251201194510.1121221-5-peterx@redhat.com> (Peter Xu's message
 of "Mon, 1 Dec 2025 14:45:07 -0500")
References: <20251201194510.1121221-1-peterx@redhat.com>
 <20251201194510.1121221-5-peterx@redhat.com>
Date: Tue, 02 Dec 2025 12:42:41 +0100
Message-ID: <87pl8xun2m.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Peter Xu <peterx@redhat.com> writes:

> Make migration_connect_set_error() take ownership of the error always.
> Paving way for making migrate_set_error() to take ownership.
>
> When at it, renaming it to migration_connect_error_propagate(), following
> Error API, to imply the Error object ownership transition.
>
> NOTE: this patch also makes migration_connect() to take ownership of the
> Error passed in.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/channel.c   | 1 -
>  migration/migration.c | 9 +++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/migration/channel.c b/migration/channel.c
> index 462cc183e1..92435fa7f7 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -95,7 +95,6 @@ void migration_channel_connect(MigrationState *s,
>          }
>      }
>      migration_connect(s, error);
> -    error_free(error);
>  }
>  
>  
> diff --git a/migration/migration.c b/migration/migration.c
> index b316ee01ab..0ff8b31a88 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1575,7 +1575,7 @@ static void migrate_error_free(MigrationState *s)
>      }
>  }
>  
> -static void migration_connect_set_error(MigrationState *s, const Error *error)
> +static void migration_connect_error_propagate(MigrationState *s, Error *error)
>  {
>      MigrationStatus current = s->state;
>      MigrationStatus next;
> @@ -1602,6 +1602,7 @@ static void migration_connect_set_error(MigrationState *s, const Error *error)
>  
>      migrate_set_state(&s->state, current, next);
>      migrate_set_error(s, error);
> +    error_free(error);
>  }
>  
>  void migration_cancel(void)
> @@ -2292,7 +2293,7 @@ void qmp_migrate(const char *uri, bool has_channels,
>  
>  out:
>      if (local_err) {
> -        migration_connect_set_error(s, local_err);
> +        migration_connect_error_propagate(s, error_copy(local_err));
>          error_propagate(errp, local_err);
>      }
>  }
> @@ -2337,7 +2338,7 @@ static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
>          if (!resume_requested) {
>              yank_unregister_instance(MIGRATION_YANK_INSTANCE);
>          }
> -        migration_connect_set_error(s, local_err);
> +        migration_connect_error_propagate(s, error_copy(local_err));
>          error_propagate(errp, local_err);
>          return;
>      }
> @@ -4039,7 +4040,7 @@ void migration_connect(MigrationState *s, Error *error_in)
>  
>      s->expected_downtime = migrate_downtime_limit();
>      if (error_in) {
> -        migration_connect_set_error(s, error_in);
> +        migration_connect_error_propagate(s, error_in);
>          if (resume) {
>              /*
>               * Don't do cleanup for resume if channel is invalid, but only dump

Could be split for slightly easier review: first change
migration_connect(), then migrate_set_error().  I doubt it's worth the
bother now.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


