Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D91E92FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 18:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaICA-0000fh-5p; Mon, 29 Dec 2025 13:42:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaIC6-0000bF-Os
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:42:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaIC1-0007Wp-VC
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:42:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767033725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q0VpudXbOuwgvKi3M2nVEq4u6PHjiT6r0dq7IP+SJls=;
 b=QUA/gxKB4BXbj7h6NM+lrjUfEG8a4QENv05W8hVAj3TQaWcLkqRSZtqqjDvx8xTJ9mr15Y
 CiHiGZ8GGA6+jVyEsgMrc7CpuWR7k2nWnoLgsllLTu1VoCsbwUITkYHCxo52Ol9y5lgRIi
 THSMQj/2d1axim77N/e2ZEB/af8loI8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-ski6NZXROo2FrpesIPx1AQ-1; Mon, 29 Dec 2025 13:42:03 -0500
X-MC-Unique: ski6NZXROo2FrpesIPx1AQ-1
X-Mimecast-MFC-AGG-ID: ski6NZXROo2FrpesIPx1AQ_1767033723
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8b22d590227so1082465685a.1
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 10:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767033723; x=1767638523; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Q0VpudXbOuwgvKi3M2nVEq4u6PHjiT6r0dq7IP+SJls=;
 b=d9fRh5EB/V0qTP9xLoXK7VDbP5WZg0fTD42CuwFvGoH4zSJ1EWAoeibmUg19grfD4x
 FABWBss+OFaBjWC2lnPlnb5uc7bGvBudIQv0/QQN6lSzvdeBPuseiblet5QNJiWXW+QN
 kVhYBh+kzRz7W80vaqFGS99AoCKk2ONk/pHtw3KTIdEdOvTemEUglcRyo4DvUrkGTCoJ
 k1QsAlrnAClqsbnNLPA98OsRqDAGqqPdoew3bFVl/g2Hm3+ZKkD3ephbaw1hrkttTZBp
 MoVjlUBwugYXUSdjxl7KJeTzc653SIAnTTDZ5N6ycO9nOO1ly4hcw+IrrUb3NOw8sgQh
 WP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767033723; x=1767638523;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q0VpudXbOuwgvKi3M2nVEq4u6PHjiT6r0dq7IP+SJls=;
 b=Hld3Gxk+EqkeAT5J68rDWeJXCinqNto7xH5ZtCY6UY6DzQvgF0Y+XzJRH30J3uoX2l
 pp+EjFaVBVWCUH9kyUNRW8W3LOPwl1yJurfelky1boTG8kBqVxwXXNqREifwjhWH9WxS
 lUjTqrXcui7KnZetR7dPJ5tCFUfuUTPNAsq3Rk3aN5QfFHQOzMwiCBh+Wa22w9QDpXfQ
 ofmNJ0SWlbif8E4t8xaeIZi4bqOgpf4gWXpGU9XJrm/3Z2//sPbxFF9tiDlL4vK6OZvH
 67nuH7KdPuafgdonmE9jAftxRznnQEMOtIKHhdEPtDsm9MR4IVg0fofpqZDHY2UVEmkt
 mp+g==
X-Gm-Message-State: AOJu0YxJVJou4WyDMwhZTE4oG9sb1xRyvNo2SIj8LjCs7EiQWJh5+ZVA
 iQefYFumtBQKYtJc+QQLfK6p2yfPZjUSbDP2gl5c+pBuMY8HZJ4ocJkjTgmWemnqAvyEJbXa0Ru
 wcHdItGBda6PELVya1leQVlkbaAnpDapYyxX3JWUYUoZt5Df4iElP1DNQ
X-Gm-Gg: AY/fxX4ey6Yx5gDgqZ80MUPrEWeBGeSQQ/Ubxl57W4VJYhyTWSYb+mWYE8IIcGzVvA0
 VYBK9KTbTUzZfsgJNuZmLLf8OWDdcze1UB2Lvx2fSaVIHMfggm4bzrG1GmVAJYYUeYVIoaw54YZ
 DMOy+i0wwzXyHryaqUzswMkJlxAl8nGsIKL+e1puQWq0xsZedUszbRqAQEHFdytqM9gR87TMILv
 LoMLNJ662deRGWhLNdovj/7IypE0uUErYZoKQq5CLLzYHQMCpy4AcTMc/YV+Lyb+vBxc/EkNqKB
 FwUipQjXGiP3O12zzWguRrQn+I/gpxcNxnXKWZq+J6iweWT+agiYK2Yt+SLZmeGhSBdoqPpHoNU
 fmXY=
X-Received: by 2002:a05:620a:1a0c:b0:89e:a9ea:a374 with SMTP id
 af79cd13be357-8c08ff20edfmr4359169885a.67.1767033723122; 
 Mon, 29 Dec 2025 10:42:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3VR04jOM6M+lPU6WUQo0AzSw7ZxLR7MV8sCqPzooxBhSCVXKnqjdpg2AuUIslF9VBEMKLvQ==
X-Received: by 2002:a05:620a:1a0c:b0:89e:a9ea:a374 with SMTP id
 af79cd13be357-8c08ff20edfmr4359166685a.67.1767033722575; 
 Mon, 29 Dec 2025 10:42:02 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88d99d7e8d4sm241690756d6.41.2025.12.29.10.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 10:42:02 -0800 (PST)
Date: Mon, 29 Dec 2025 13:42:01 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 12/25] migration: Fold migration_cleanup() into
 migration_connect_error_propagate()
Message-ID: <aVLLeZQm376POJ0t@x1.local>
References: <20251226211930.27565-1-farosas@suse.de>
 <20251226211930.27565-13-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251226211930.27565-13-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Fri, Dec 26, 2025 at 06:19:14PM -0300, Fabiano Rosas wrote:
> Whenever an error occurs between migrate_init() and the start of
> migration_thread, do cleanup immediately after.
> 
> This allows the special casing for resume to be removed from
> migration_connect(), that check is now done at
> migration_connect_error_propagate() which already had a case for
> resume.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Didn't spot anything wrong,

Reviewed-by: Peter Xu <peterx@redhat.com>

One nitpick below,

> ---
>  migration/migration.c | 42 +++++++++++++++++++++++++++---------------
>  1 file changed, 27 insertions(+), 15 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 0f1644b276..a66b2d7aaf 100644
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
> @@ -2209,12 +2219,19 @@ static gboolean qmp_migrate_finish_cb(QIOChannel *channel,
>                                        GIOCondition cond,
>                                        void *opaque)
>  {
> +    MigrationState *s = migrate_get_current();
>      MigrationAddress *addr = opaque;
> +    Error *local_err = NULL;
> +
> +    qmp_migrate_finish(addr, &local_err);
> +
> +    if (local_err) {
> +        migration_connect_error_propagate(s, local_err);
> +    }
>  
> -    qmp_migrate_finish(addr, NULL);
>  
>      cpr_state_close();
> -    migrate_hup_delete(migrate_get_current());
> +    migrate_hup_delete(s);

IMHO we should drop these two lines.  For error cases, now they'll be done
in migration_cleanup() above.  Actually for success, it's the same, but in
the cleanup BH.

Maybe there're other cases where we can clean the code a bit on cpr;
there're codes that always does "if (xxx)" and calling them all over the
places, so it's easy to write such code when drafting a feature, but hard
to maintain, because it'll be obscure when it'll really trigger, like this
one.  We can leave the rest for later if there're applicable similar
cleanups.

>      qapi_free_MigrationAddress(addr);
>      return G_SOURCE_REMOVE;
>  }
> @@ -2223,7 +2240,6 @@ void qmp_migrate(const char *uri, bool has_channels,
>                   MigrationChannelList *channels, bool has_detach, bool detach,
>                   bool has_resume, bool resume, Error **errp)
>  {
> -    Error *local_err = NULL;
>      MigrationState *s = migrate_get_current();
>      g_autoptr(MigrationChannel) channel = NULL;
>      MigrationAddress *addr = NULL;
> @@ -2280,6 +2296,13 @@ void qmp_migrate(const char *uri, bool has_channels,
>          return;
>      }
>  
> +    /*
> +     * The migrate_prepare() above calls migrate_init(). From this
> +     * point on, until the end of migration, make sure any failures
> +     * eventually result in a call to migration_cleanup().
> +     */
> +    Error *local_err = NULL;
> +
>      if (!cpr_state_save(cpr_channel, &local_err)) {
>          goto out;
>      }
> @@ -2299,12 +2322,11 @@ void qmp_migrate(const char *uri, bool has_channels,
>                          QAPI_CLONE(MigrationAddress, addr));
>  
>      } else {
> -        qmp_migrate_finish(addr, errp);
> +        qmp_migrate_finish(addr, &local_err);
>      }
>  
>  out:
>      if (local_err) {
> -        yank_unregister_instance(MIGRATION_YANK_INSTANCE);
>          migration_connect_error_propagate(s, error_copy(local_err));
>          error_propagate(errp, local_err);
>      }
> @@ -2335,12 +2357,6 @@ static void qmp_migrate_finish(MigrationAddress *addr, Error **errp)
>      } else {
>          error_setg(&local_err, "uri is not a valid migration protocol");
>      }
> -
> -    if (local_err) {
> -        migration_connect_error_propagate(s, error_copy(local_err));
> -        error_propagate(errp, local_err);
> -        return;
> -    }
>  }
>  
>  void qmp_migrate_cancel(Error **errp)
> @@ -4027,9 +4043,6 @@ void migration_connect(MigrationState *s, Error *error_in)
>      s->expected_downtime = migrate_downtime_limit();
>      if (error_in) {
>          migration_connect_error_propagate(s, error_in);
> -        if (!resume) {
> -            migration_cleanup(s);
> -        }
>          if (s->error) {
>              error_report_err(error_copy(s->error));
>          }
> @@ -4108,7 +4121,6 @@ void migration_connect(MigrationState *s, Error *error_in)
>  
>  fail:
>      migration_connect_error_propagate(s, local_err);
> -    migration_cleanup(s);
>      if (s->error) {
>          error_report_err(error_copy(s->error));
>      }
> -- 
> 2.51.0
> 

-- 
Peter Xu


