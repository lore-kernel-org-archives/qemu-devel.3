Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF00D2ED0F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 09:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi7cd-0006AU-1D; Tue, 20 Jan 2026 04:01:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vi7cZ-000659-QZ
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 04:01:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vi7cX-0000g5-OM
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 04:01:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768899713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CeI8GxQ2UTAUV1J0okMEcrnIZ6OgMsTV/S6TGY1jkYs=;
 b=LAqmWHVa2KG9o0WexSUvDpN8y5ekAntwawI9JZPnQG7RFfBzcBIwUA/WK9VRL+KqIU7inS
 w72/nPb3M7bjhy0oaK/k8CbccJm1DJbFiJsdcM5KMkR8Ur7Smvxfp74WzIc3X6EAKyhZau
 QpBPAiZV55Gapl23fSbMms9Vx+cF6gQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-VPjaaJY0PJiSf9KmAImo4w-1; Tue, 20 Jan 2026 04:01:51 -0500
X-MC-Unique: VPjaaJY0PJiSf9KmAImo4w-1
X-Mimecast-MFC-AGG-ID: VPjaaJY0PJiSf9KmAImo4w_1768899710
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4801e3aab32so25318525e9.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 01:01:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768899710; cv=none;
 d=google.com; s=arc-20240605;
 b=XQw3OJXxBRVaNeHG7jHMd+m70nzfP4kMm248kqseHX01WVGC6BsrKQVJv70fbgelym
 e0zlXpLVeW3plqilftkyT0nuDvsqH2pfsZRS8ZaTQreb8kzukA3fUcH0gHE4m3BW+thW
 XyuuhKnHD+AIcr1j5/bkz+dPD7ZlxzfjRgxOJS5ZyaMzsMbcYoqLvvQkz3MqaxOCay/4
 z2980W2BR+YYACAIVb6XTwv+h4VIKVZPOZ7VxVFzZWxgd+kKY4+iQu9H5V8nq/YCQFWH
 WH1WV6zKbFAa9hr5/za5bMIdG74OrTqk2kRElB64h9l5Qplw1DhcEeERfWBMc8rRW3To
 C8sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CeI8GxQ2UTAUV1J0okMEcrnIZ6OgMsTV/S6TGY1jkYs=;
 fh=SJ3HPovJyRUvRbjEYgfW8f8/HsJC2a+l/HOVRBs3/Wg=;
 b=OxkG6/KVwDPrcTb/JRQdqyPd7hX+XXTBOHB93Nv7cL7OGU0jYAJmQ1I5BN45JqhNpm
 57vimtd1gCwHfZsOY9ghaeu2utdjXqHlD2Yd6p5qnWJjO7jzU96xp6BlFCzU3urTJazs
 +qAlOb3rZXPHdRAninaSzkzMbrqrrZHXnkzWB/Fhpn/XxEnABQC1H15+kuNmIOFkmdDy
 GOXvKFuwjG5uFr3DVS7tOz0aqwfbDjtsfyGtwcNGh77i0bVAuQWy/pA3UoyT6QVpl3e1
 CDSco8p+/ruCjYvAfW/1QuhMwsm2RMfgqgMfzNz5VrowYzaY7kQvwmQUxA/LMOfn/DnN
 84iA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768899710; x=1769504510; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CeI8GxQ2UTAUV1J0okMEcrnIZ6OgMsTV/S6TGY1jkYs=;
 b=rk/Dbsbf2RfCpN/0/aS4xroIkn+9gI5xL2eV/vUONHL8qdvenoVJpO6rE7eFXXcdAv
 cQ4+vQewP7J9DKnB7FaPkavknj+LIvseRCNNaKk82a3ibTPEb0lJpZVNc9rvhZOt1iWn
 SA+TTXs2m9gqEfNdXvpmLUb7aho7wOgz2aziPKpelyJQ/ub6oKcf8trKQjgjjBjtUwQu
 uvFCcb3nPzBNx9wxTQSPhnWfTblPcjUJbcowhL5LBVOBhkYyu+hKOkb+p+he+TWgaB0u
 V14EqFb+erRip27vD+RMyhj0805jndG+02fEIn+NDCPlpzdfdQcFZ+a1fUHorJx98cvP
 g/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768899710; x=1769504510;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CeI8GxQ2UTAUV1J0okMEcrnIZ6OgMsTV/S6TGY1jkYs=;
 b=qKu31qvdp6xDORTRHR33jVBmJaZxk431PBbM8L2OgrKXgbHtogH5H0SrOR2Zn4jk2T
 k38ByqRzdRvJ2hAzVXJtfCR2XU+MDx7QMvV+6fbb6zPYyijvTcLYPtb8d04HTirhdBfr
 aHfljpjmpGa6V7MxVh3L+4Y3fWxcRdWGRe24BadIwM9cl6oVExWYQTacfBylc1uyRo4D
 9k4LMa5JWIN4CwJW2r9nqDyPalTQ+ZfTFuAyH2sc6OvT5AacVYhi5IebjW6RuWjOCDRV
 k7Zm9pnSuTQNdsJTE23jFfQfRvx0G2B85CjMJ+KoAZ0uX4W6mJb2JwrghqIiMxhs7N/6
 pQfA==
X-Gm-Message-State: AOJu0YyZhrHZ8cwNHc/fIxhT1Y4iUwTTBJ+RktiAuTdfy2GtscgUyFyK
 YW20wMgXVDq+PylV5yUc3m62dLrIqsvRIYrdb+HEUho56XzrXgZIdf4gWld6pN3r4drW98/H+xr
 80UTWQeZpL1z37r+jkm6sG0ulQdxpZJEeJAhWLKdIqWeymmLOBJi9Wh4wBxuh6AQaOpjMPLndbL
 Z0juV5pyzKLnx2iYEsbCwydXl349GsYng=
X-Gm-Gg: AY/fxX6yMH6UZY0ksDcOMBuvTS3dgyTuotCvkeha1Lvc+27XooFx1uh0gZTMEExJxfL
 sJy+bLbtjT/zM2ETS1Xm7PBJ0S7E0vMmfDilaE8Wpp9wFkddqRdzZYi76anAEINgrtXH24WTns8
 kIWXEHwTZtwd7kUzcg1qOrMNor/xfAmh/MCiijL4ZxkXXFwjRfTDLxgiU7wL8U4cs5aJX6pHkfW
 K/ZM90GXSmUD+xHoNncNlzwWsWHGjAKnNibNvRt4wsOZt9iJbNg9ykU
X-Received: by 2002:a05:600c:4586:b0:477:76cb:4812 with SMTP id
 5b1f17b1804b1-4801e2a50e4mr184417915e9.0.1768899709637; 
 Tue, 20 Jan 2026 01:01:49 -0800 (PST)
X-Received: by 2002:a05:600c:4586:b0:477:76cb:4812 with SMTP id
 5b1f17b1804b1-4801e2a50e4mr184417445e9.0.1768899709225; Tue, 20 Jan 2026
 01:01:49 -0800 (PST)
MIME-Version: 1.0
References: <20260109124043.25019-1-farosas@suse.de>
 <20260109124043.25019-11-farosas@suse.de>
In-Reply-To: <20260109124043.25019-11-farosas@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 20 Jan 2026 14:31:32 +0530
X-Gm-Features: AZwV_Qimz2DWDr5-dGW4I3ZKyMbj17eXgABufDuykTjobD2Pp1tyB0r0Tt_0Kso
Message-ID: <CAE8KmOzfPVKqu5S43aQHfrz+JQCzzKtK6up=ZtVvLNNrjV1kbQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/25] migration: yank: Move register instance earlier
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, 9 Jan 2026 at 18:13, Fabiano Rosas <farosas@suse.de> wrote:
> Move the register_instance call to migrate_prepare() so it can be
> paired with the unregister_instance at migration_cleanup(). Otherwise,
> the cleanup cannot be run when cpr_state_save() fails because the
> instance is registered only after it.
>
> When resuming from a paused postcopy migration, migrate_prepare()
> returns early, but migration_cleanup() doesn't run, so the yank will
> remain paired.
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration.c | 26 ++++++++------------------
>  1 file changed, 8 insertions(+), 18 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 259b60af04..164cb26c48 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2180,11 +2180,12 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
>          return false;
>      }
>
> +    yank_register_instance(MIGRATION_YANK_INSTANCE, &error_abort);
> +
>      return true;
>  }
>
> -static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
> -                               Error **errp);
> +static void qmp_migrate_finish(MigrationAddress *addr, Error **errp);
>
>  static void migrate_hup_add(MigrationState *s, QIOChannel *ioc, GSourceFunc cb,
>                              void *opaque)
> @@ -2209,7 +2210,7 @@ static gboolean qmp_migrate_finish_cb(QIOChannel *channel,
>  {
>      MigrationAddress *addr = opaque;
>
> -    qmp_migrate_finish(addr, false, NULL);
> +    qmp_migrate_finish(addr, NULL);
>
>      cpr_state_close();
>      migrate_hup_delete(migrate_get_current());
> @@ -2221,7 +2222,6 @@ void qmp_migrate(const char *uri, bool has_channels,
>                   MigrationChannelList *channels, bool has_detach, bool detach,
>                   bool has_resume, bool resume, Error **errp)
>  {
> -    bool resume_requested;
>      Error *local_err = NULL;
>      MigrationState *s = migrate_get_current();
>      g_autoptr(MigrationChannel) channel = NULL;
> @@ -2274,8 +2274,7 @@ void qmp_migrate(const char *uri, bool has_channels,
>          return;
>      }
>
> -    resume_requested = has_resume && resume;
> -    if (!migrate_prepare(s, resume_requested, errp)) {
> +    if (!migrate_prepare(s, has_resume && resume, errp)) {
>          /* Error detected, put into errp */
>          return;
>      }
> @@ -2299,28 +2298,22 @@ void qmp_migrate(const char *uri, bool has_channels,
>                          QAPI_CLONE(MigrationAddress, addr));
>
>      } else {
> -        qmp_migrate_finish(addr, resume_requested, errp);
> +        qmp_migrate_finish(addr, errp);
>      }
>
>  out:
>      if (local_err) {
> +        yank_unregister_instance(MIGRATION_YANK_INSTANCE);
>          migration_connect_error_propagate(s, error_copy(local_err));
>          error_propagate(errp, local_err);
>      }
>  }
>
> -static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
> -                               Error **errp)
> +static void qmp_migrate_finish(MigrationAddress *addr, Error **errp)
>  {
>      MigrationState *s = migrate_get_current();
>      Error *local_err = NULL;
>
> -    if (!resume_requested) {
> -        if (!yank_register_instance(MIGRATION_YANK_INSTANCE, errp)) {
> -            return;
> -        }
> -    }
> -
>      if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
>          SocketAddress *saddr = &addr->u.socket;
>          if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
> @@ -2343,9 +2336,6 @@ static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
>      }
>
>      if (local_err) {
> -        if (!resume_requested) {
> -            yank_unregister_instance(MIGRATION_YANK_INSTANCE);
> -        }
>          migration_connect_error_propagate(s, error_copy(local_err));
>          error_propagate(errp, local_err);
>          return;
> --

* Looks good.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


