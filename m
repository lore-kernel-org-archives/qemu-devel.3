Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6553ED10386
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 07:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vO9wu-0005sv-NQ; Wed, 26 Nov 2025 02:28:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vO9wd-0005m4-0Q
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 02:28:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vO9wW-0003Pr-Mp
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 02:28:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764142078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HYFqZyqp+jQ3+RSYMC2vEMyhbn0aloPWgH04bAZjptI=;
 b=c6Vxbr8nq5JWzB/ORo6cjyLwXSMhjZnAq6wxvDfmyob7eDvlA9+5fp2pmSCbzTdv81lsEm
 gzb7EjFtFO1AZzxnppsIUttOuIubv7og4Sr0WSjmVSU88cfzU4QYfVx55/kAzGcg0wnm6y
 D0W3xp/dhVPzdy3AxEbm8NzRUAJxMvg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-XAb4Fn9fPP28UdJEsiE2sg-1; Wed,
 26 Nov 2025 02:27:54 -0500
X-MC-Unique: XAb4Fn9fPP28UdJEsiE2sg-1
X-Mimecast-MFC-AGG-ID: XAb4Fn9fPP28UdJEsiE2sg_1764142073
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 61BA11800372; Wed, 26 Nov 2025 07:27:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9777B1800576; Wed, 26 Nov 2025 07:27:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EF64721E6A27; Wed, 26 Nov 2025 08:27:48 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Juraj Marcin <jmarcin@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Fabiano Rosas <farosas@suse.de>,
 Daniel P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH for-11.0 3/6] migration: Make
 migration_connect_set_error() own the error
In-Reply-To: <20251125204648.857018-4-peterx@redhat.com> (Peter Xu's message
 of "Tue, 25 Nov 2025 15:46:45 -0500")
References: <20251125204648.857018-1-peterx@redhat.com>
 <20251125204648.857018-4-peterx@redhat.com>
Date: Wed, 26 Nov 2025 08:27:48 +0100
Message-ID: <87jyzdfe2z.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> Make migration_connect_set_error() take ownership of the error always.
> Paving way for making migrate_set_error() to take ownership.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/channel.c   | 1 -
>  migration/migration.c | 7 ++++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
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
> index b316ee01ab..4fe69cc2ef 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1575,7 +1575,7 @@ static void migrate_error_free(MigrationState *s)
>      }
>  }
>  
> -static void migration_connect_set_error(MigrationState *s, const Error *error)
> +static void migration_connect_set_error(MigrationState *s, Error *error)

Recommend to rename for the same reason you rename migrate_set_error()
in the last patch.

Bonus: all calls become visible in the patch, easing review.

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
> +        migration_connect_set_error(s, error_copy(local_err));
>          error_propagate(errp, local_err);
>      }
>  }
> @@ -2337,7 +2338,7 @@ static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
>          if (!resume_requested) {
>              yank_unregister_instance(MIGRATION_YANK_INSTANCE);
>          }
> -        migration_connect_set_error(s, local_err);
> +        migration_connect_set_error(s, error_copy(local_err));
>          error_propagate(errp, local_err);
>          return;
>      }

There's one more call in migration_connect().  Doesn't it need an
error_copy() now?  Oh, I see: it doesn't, because its only caller
migration_channel_connect() loses its error_free() in the first hunk.

So, migration_connect() *also* takes ownership now.  The commit message
should cover this.

Aside: I'd be tempted to lift the if (error_in) code from
migration_connect() to migration_channel_connect() and drop the
@error_in parameter.


