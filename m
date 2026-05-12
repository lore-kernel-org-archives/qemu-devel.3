Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6BCCD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 15:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMp2H-0000j0-Gc; Tue, 12 May 2026 11:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wMp2F-0000iX-VS
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:28:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wMp2E-0005to-05
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778599716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8pQF14ofNAcwxkve/3UOvGTfXI+c/lfYQNMueaHZfw4=;
 b=O/Vtvs2HsULXCBkIEkrHn1AXzgUS6a7JxTywcP66hNAgRuwadqVpEDRUBCv5Ix75spK0L4
 utw2nsAJoE+MvGKH1BeMXPp+2UiodAu2GST+V/mJdciX5lgiUF5MfUXeVtEumaV+5A5ijx
 tJPmETwktl/pei3rUwnk8dF1jjPVqh8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-uVMlcukxO5uiy1fgt_ImAQ-1; Tue, 12 May 2026 11:28:34 -0400
X-MC-Unique: uVMlcukxO5uiy1fgt_ImAQ-1
X-Mimecast-MFC-AGG-ID: uVMlcukxO5uiy1fgt_ImAQ_1778599714
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8b55b5aa8c7so132070656d6.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 08:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778599714; x=1779204514; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8pQF14ofNAcwxkve/3UOvGTfXI+c/lfYQNMueaHZfw4=;
 b=B8dG7MYG8DQJKJsWEU0t8AYi2I0wdMNxciTkVew3bi0nDMvvXdgIznOA0iFh940NX1
 fYsdj5WWCuO9e2DU8t9oMrNQW+1i/KxQGVBn1Wf7C9inw+dwmKfZ8mXf6P9WHb8L4qKF
 M2CnCgmRYZ4SuPaUSvkxJKfUsYiGaXVhEHzctW/j1kxNS8J8fgql+Y02vHvb7anxZttX
 QeMJpvTcsecj5Y65RGStPUompPIxTAo4bEUnLLYGSN3YbU2XNiV8yAeCY//3NslGD44Y
 OxCbqCuyTCcFj6hBk3ZQly0/3gu1hO8mazk5NxKRs3Cu9jZJeTfZ2pxl6cenvxcB4Nv2
 bL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778599714; x=1779204514;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8pQF14ofNAcwxkve/3UOvGTfXI+c/lfYQNMueaHZfw4=;
 b=PGMvlkSKqbY4smvZKVI6nUswDdjgue+7tfLcMjLI6cCtoU+qiHP66JD8X/S9d7OT5E
 mBdYvpjXu36jFEuhaAGtpE4gPFMP527Poe1KrLMOcCLs3s2/yk5BuAFuYQ/EjXfz48eO
 GChlKPh+8j/y4TnLaMnVxGiTZC3wFoomdTSZsXUUQIrgTvGOrYBEgn9RtxAofcTiqRXW
 cjuH/6CVb/2XPv2M9zQ5FeP1mae0ksJ7ddScYzFgRBFhVv89C9d6IjRF7WyPymTW1XEY
 H8Jsqq6z+MoioPSNQHTRij6wo6cB/ax76CNxwxhaNCCLMchTl6XdZpOmUZwdzhJmG1Iq
 QOYw==
X-Gm-Message-State: AOJu0YyRwMm0GyFbq0s6UQTPSrZo9nSxntR3DYLaYRuEawRSPcIgXhbX
 1hjfK8pkrJOGYVI278d7EuEJot6mxglhx5qbhW6p5Vsq1sn06UDyUDkvQyFU5cP1pURHJr5qwxv
 fONStGVLRy8ngAlLDHKsf4EzlCZlTnZz+RfoMXEhDL8x2cPvCcUtne9GP
X-Gm-Gg: Acq92OFz2L+MMDhvRZ/35M05u57LvVDH6m3PYwBnp5WcGWdIIROd2C73LkZlJMreB05
 eEroA2ZBmomZiMT1yE+gwy+h+lVfRrLKRvZWDr3T3BBHyUsOKD/Y2AaPNIjD/d9wznK4Aody3Sy
 oONScTPW/+o6MR7wKi9yL3Ezu+6GCgM397NS+kG9BwsVAScW71o5D4/m/39U467HoRXnPCeIxnC
 RJbtiSXMn/pAAobfKNZV6WiD+5BQfdkiiqlBPmjOOAgBI+PWwCROIQrWKMQOr9CRN+JoNQiaA7U
 YrgStjkrovQLIE6dlWExbM/mavmN8s6qYvh6bAFLE/7diXFT/9T59Q4/rpZK4pffGZWMSLI7bhQ
 hQG9L0EHVAutrhFhskF4HpFx5gb6pukULaeSJJTFxP7zWU4k=
X-Received: by 2002:a0c:f105:0:b0:8ae:6835:11a2 with SMTP id
 6a1803df08f44-8c660f0a847mr41637616d6.9.1778599714068; 
 Tue, 12 May 2026 08:28:34 -0700 (PDT)
X-Received: by 2002:a0c:f105:0:b0:8ae:6835:11a2 with SMTP id
 6a1803df08f44-8c660f0a847mr41637186d6.9.1778599713613; 
 Tue, 12 May 2026 08:28:33 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf88247a3csm122696016d6.11.2026.05.12.08.28.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 08:28:33 -0700 (PDT)
Date: Tue, 12 May 2026 11:28:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de
Subject: Re: [PATCH] [migration] Replace current_migration with
 migrate_get_current()
Message-ID: <agNHH9p8oYp4g97Y@x1.local>
References: <20260512095959.736285-2-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260512095959.736285-2-aadeshveer07@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 12, 2026 at 03:30:00PM +0530, Aadeshveer Singh wrote:

For subject, please use "migration: " as prefix.

> Replaces the direct accesses to global variable `current_migration`
> with `migrate_get_current()` to ensure safety and
> consistency across systems.

Safety shouldn't be a major concern, but maybe it helps consistency.

> 
> Note: Following this only direct access to `current_migration` will be
> * `migrate_get_current()` itself
> * `migration_object_init()` initializes `current_migration`
> * `migration_is_running()`, as there might be a case where this function
>   is called by a thread before object initialization
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> ---
>  migration/migration.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index ecc69dc4d2..f3a96b1949 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -321,7 +321,7 @@ void migration_object_init(void)
>  
>      current_incoming->exit_on_error = INMIGRATE_DEFAULT_EXIT_ON_ERROR;
>  
> -    migration_object_check(current_migration, &error_fatal);
> +    migration_object_check(migrate_get_current(), &error_fatal);

IMHO we can still keep this one as-is, when in obj init path.

>  
>      ram_mig_init();
>      dirty_bitmap_mig_init();
> @@ -385,7 +385,7 @@ void migration_shutdown(void)
>       * stop the migration using this structure
>       */
>      migration_cancel();
> -    object_unref(OBJECT(current_migration));
> +    object_unref(OBJECT(migrate_get_current()));

Maybe keep this one too?  Just to pair with the init function.

>  
>      /*
>       * Cancel outgoing migration of dirty bitmaps. It should
> @@ -1029,7 +1029,7 @@ bool migration_is_running(void)
>  
>  static bool migration_is_active(void)
>  {
> -    MigrationState *s = current_migration;
> +    MigrationState *s = migrate_get_current();
>  
>      return (s->state == MIGRATION_STATUS_ACTIVE ||
>              s->state == MIGRATION_STATUS_POSTCOPY_DEVICE ||
> @@ -1634,7 +1634,7 @@ bool migration_in_bg_snapshot(void)
>  
>  bool migration_thread_is_self(void)
>  {
> -    MigrationState *s = current_migration;
> +    MigrationState *s = migrate_get_current();
>  
>      return qemu_thread_is_self(&s->thread);
>  }
> @@ -3062,7 +3062,7 @@ static MigThrError postcopy_pause(MigrationState *s)
>  
>  void migration_file_set_error(int ret, Error *err)
>  {
> -    MigrationState *s = current_migration;
> +    MigrationState *s = migrate_get_current();
>  
>      WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
>          if (s->to_dst_file) {
> -- 
> 2.54.0
> 

-- 
Peter Xu


