Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC519D4899A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 12:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgitu-0003ct-3h; Fri, 16 Jan 2026 07:26:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vgitn-0003ZR-Kt
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 07:25:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vgitm-0001tc-3i
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 07:25:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768566353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nZ4y8uqCRINEK/ME3gVahYI+u+vDZeh3gltIhi5Zmok=;
 b=Xm+0qa9Mzh9wRdNcCxwQTmIdSYIg1r0VpcYrORgydLxUFOU+1sC0diI9ZoglMwEG/XvcnQ
 TfcR1z6PBejf9h/+Tb3Uodc8560jzCzuq+JDcPUCvBVDs3Pkw6QqNfCc0gz6txU29ubM14
 KBBjt/QQda6h5KtIYGxqoToLPUmhYE8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-CI_7RMGmMoemZy0M_etPFQ-1; Fri, 16 Jan 2026 07:25:47 -0500
X-MC-Unique: CI_7RMGmMoemZy0M_etPFQ-1
X-Mimecast-MFC-AGG-ID: CI_7RMGmMoemZy0M_etPFQ_1768566346
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47d3c9b8c56so28491485e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 04:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768566346; x=1769171146; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nZ4y8uqCRINEK/ME3gVahYI+u+vDZeh3gltIhi5Zmok=;
 b=L6rxtdGrKwl+JWCvYdSYQSoQfnt+/x9+r9E+CGe06t3q0w49JNy66xZjYI8guxuD2h
 dpo6gJPwPuW0W7RHcfnPOkPTrNzGdMP6EPSiKqE7GJ5/UuSytsuVtekb+NhLOm753jMf
 TzQ24KG8iOvrrM2Mk1XBLhgTQ0+9m2b1oW8UaiQMXucOiYZEoNQWUi13OB2HDAk51Ky3
 D0dyqrUG72DzKWVn4TMyaATgKZTGSuSkoTGgMjJTXl1idpamdwTz2xJE3Lm6bFP6qPNr
 kHzlgZYRWC8wjqMu4OIK4dSS/HcPjD+4jtZanLpvGYjGUCqGroGUzHg/wIQN0dP7L7xQ
 bTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768566346; x=1769171146;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nZ4y8uqCRINEK/ME3gVahYI+u+vDZeh3gltIhi5Zmok=;
 b=VkL9nnT8Z4k3/eUu9jrzWFalxtyELgN/IdQF0cGSCXeIL0IAmpmMRV/ARMItnIOYpl
 N4um81uITWTC3WgXWkpuyfvY7LM6dW6pEfB0GMtYK4b0T5piHrMCWIzM7KxcAx14excs
 62BfVB84GvF3+RbvfphJLPK0lmWNKv4VvxlfuWrCHSr36+bcHjwJN70/70R9pctkZNtk
 FL2VQt2dC9mQVbZ1C6ULVlQFz+hPDm9pYKsZZ4OHN5EOxrFoZo8hLPWqGJvdYwSza8j8
 eE8hCj6/SEJ978rJwT8Aw/qXAcQgnBSKcqW3rQUYlk7rRB7jPFb5ecATRoqKkW9zT8KU
 RKUA==
X-Gm-Message-State: AOJu0Yw9mbbAXJlUcscHxustckX38w4cXvnU0uSyA1evjzGUdsicpkal
 LYkWiO4Zm083PuSDraS2EDAMAwb4KLgJlTN4iX7uToGc9iSweM+skaACqbGUL1JvrX4NeAXgi3/
 Hul4+4lAR8fSx5Ox8YEIpKMNgCEO/GtpgNpi6wYyox3DTvbj3jaaLIE5H+Ia+1nUDcWIcEeQTuY
 3Le2BSDdDeMUmMNmS0jEVd/9btH0lO4jM=
X-Gm-Gg: AY/fxX7utCdpW8PNxRWdHyrC6tRHeSeK2e/V/rQTGfMcnu8E5H3dNElxVyF8PZfIpA3
 y2qJXjIKx+0LlhfzBpEFKedz8RsxqACV7Ne6qQ/zedIyr+f9O7GaUxB5iHLrOM3hlcc6pIp7TUY
 8UVl9T7mpglkEDGdQSbVEokGb/V2YvqOeYlA/VH7rva+z+vPyBH+PvDCDWJ7XihFlzIo/kNZZ1V
 oBScGKfq83lXfhueZVIeKeHrpRdfV5YFpCcgHM+GI11TNhS+UwLBBtj
X-Received: by 2002:a05:600c:3495:b0:477:639d:bca2 with SMTP id
 5b1f17b1804b1-4801eaadbd9mr26166275e9.4.1768566345738; 
 Fri, 16 Jan 2026 04:25:45 -0800 (PST)
X-Received: by 2002:a05:600c:3495:b0:477:639d:bca2 with SMTP id
 5b1f17b1804b1-4801eaadbd9mr26166025e9.4.1768566345365; Fri, 16 Jan 2026
 04:25:45 -0800 (PST)
MIME-Version: 1.0
References: <20260109124043.25019-1-farosas@suse.de>
 <20260109124043.25019-12-farosas@suse.de>
In-Reply-To: <20260109124043.25019-12-farosas@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Fri, 16 Jan 2026 17:55:27 +0530
X-Gm-Features: AZwV_QhTuuQ-uFdolbUVsEU1G97SuQzxY7xxXQJQ5OH_SPn7s1FNwpFEfLCI9bk
Message-ID: <CAE8KmOwGzbRca1TpcQWjYrvd2UiFJ57RVNd8g44-cQdddOKktQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/25] migration: Fold migration_cleanup() into
 migration_connect_error_propagate()
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 9 Jan 2026 at 18:12, Fabiano Rosas <farosas@suse.de> wrote:
> Whenever an error occurs between migrate_init() and the start of
> migration_thread, do cleanup immediately after.

* .. immediately after -> immediately.

> The cleanup at qmp_migrate_finish_cb can also be removed because it
> will always be reached wither via the error path at

* wither -> whether OR either

> qmp_migrate_finish->migration_connect_error_propagate or via the
> migrate_cleanup_bh.
>
> The yank_unregister_instance at qmp_migrate() is now replaced by the
> one at migration_cleanup().
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 164cb26c48..d57cc2dc3b 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1576,15 +1576,21 @@ static void migration_connect_error_propagate(MigrationState *s, Error *error)
>  {
>      MigrationStatus current = s->state;
>      MigrationStatus next = MIGRATION_STATUS_NONE;
> +    bool resume = false;
>
>      switch (current) {
>      case MIGRATION_STATUS_SETUP:
>          next = MIGRATION_STATUS_FAILED;
>          break;
>
> +    case MIGRATION_STATUS_POSTCOPY_PAUSED:
> +        resume = true;
> +        break;
> +
>      case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
>          /* Never fail a postcopy migration; switch back to PAUSED instead */
>          next = MIGRATION_STATUS_POSTCOPY_PAUSED;
> +        resume = true;
>          break;
>
>      case MIGRATION_STATUS_CANCELLING:
> @@ -1609,6 +1615,10 @@ static void migration_connect_error_propagate(MigrationState *s, Error *error)
>      }
>
>      migrate_error_propagate(s, error);
> +
> +    if (!resume) {
> +        migration_cleanup(s);
> +    }
>  }
>
>  void migration_cancel(void)
> @@ -2211,9 +2221,6 @@ static gboolean qmp_migrate_finish_cb(QIOChannel *channel,
>      MigrationAddress *addr = opaque;
>
>      qmp_migrate_finish(addr, NULL);
> -
> -    cpr_state_close();
> -    migrate_hup_delete(migrate_get_current());
>      qapi_free_MigrationAddress(addr);
>      return G_SOURCE_REMOVE;
>  }
> @@ -2222,7 +2229,6 @@ void qmp_migrate(const char *uri, bool has_channels,
>                   MigrationChannelList *channels, bool has_detach, bool detach,
>                   bool has_resume, bool resume, Error **errp)
>  {
> -    Error *local_err = NULL;
>      MigrationState *s = migrate_get_current();
>      g_autoptr(MigrationChannel) channel = NULL;
>      MigrationAddress *addr = NULL;
> @@ -2279,6 +2285,13 @@ void qmp_migrate(const char *uri, bool has_channels,
>          return;
>      }
>
> +    /*
> +     * The migrate_prepare() above calls migrate_init(). From this
> +     * point on, until the end of migration, make sure any failures
> +     * eventually result in a call to migration_cleanup().
> +     */

*  +1

> +    Error *local_err = NULL;
> +
>      if (!cpr_state_save(cpr_channel, &local_err)) {
>          goto out;
>      }
> @@ -2303,7 +2316,6 @@ void qmp_migrate(const char *uri, bool has_channels,
>
>  out:
>      if (local_err) {
> -        yank_unregister_instance(MIGRATION_YANK_INSTANCE);
>          migration_connect_error_propagate(s, error_copy(local_err));
>          error_propagate(errp, local_err);
>      }
> @@ -4026,9 +4038,6 @@ void migration_connect(MigrationState *s, Error *error_in)
>      s->expected_downtime = migrate_downtime_limit();
>      if (error_in) {
>          migration_connect_error_propagate(s, error_in);
> -        if (!resume) {
> -            migration_cleanup(s);
> -        }
>          if (s->error) {
>              error_report_err(error_copy(s->error));
>          }
> @@ -4107,7 +4116,6 @@ void migration_connect(MigrationState *s, Error *error_in)
>
>  fail:
>      migration_connect_error_propagate(s, local_err);
> -    migration_cleanup(s);
>      if (s->error) {
>          error_report_err(error_copy(s->error));
>      }
> --
> 2.51.0

* Change looks okay.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


