Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F155DD72347
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 08:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjCJL-0003DI-RT; Fri, 23 Jan 2026 03:14:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vjCJJ-0003CP-KI
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 03:14:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vjCJH-0007YP-24
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 03:14:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769156065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WLCS8mUbPsMEaFon1hShnvKrpT5VHmYxW96jmNUIElk=;
 b=RS/sXTLoTB8jpeppurq3Uey0HtUfWIRuMTjQz7M6Iv2q1HeMYCZgs79OfqmqNQJHs+vehO
 ymxprN9Gu5XMqieIjk5spovkvuauoFysHwJ1XUSJjBFQh9DfBUEdpCTinhMxOww38SGc5A
 J+aJ90s4oPepqrRgghIXUFtUeGMEiXw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-TBe4NoDoPBao1viLiACZvg-1; Fri, 23 Jan 2026 03:14:23 -0500
X-MC-Unique: TBe4NoDoPBao1viLiACZvg-1
X-Mimecast-MFC-AGG-ID: TBe4NoDoPBao1viLiACZvg_1769156062
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47ee71f0244so16232325e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 00:14:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769156062; cv=none;
 d=google.com; s=arc-20240605;
 b=iZk4f7a+oZOTXQFvdcWQ9njcxDes5lejC59WyFJ92/qP/P3vfRlitHmx3E3uSjFPL/
 g+sTZ9oVH/qUUxYahmvJC7VpyN4u3ISZEVtvurI0rrtglavw7Gb+tHg9OsJeg1jDwVK8
 cp0IlcV0ct6OACtj7tNVpBtDbInrmdKfHnN1PX5XxHpzwBX0SC5Mkl7XN2YGM8HLjX1l
 ibdZoXsDb1UJ+qvIF72vC38Yx6iYKvKt/i/pMzdkL0t4CsVGDPFMlvqDEXU4fyjN7wna
 PDBrOaY2mctuGhMyimIPEX1wN+GaHqn9jM3jwUi7hvB12dgazGcuKDa+7+RFJji8/5Wb
 sXkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WLCS8mUbPsMEaFon1hShnvKrpT5VHmYxW96jmNUIElk=;
 fh=8jLQ9BF8TzoH/ErGnlkH4vSIZ9SpUVgmQkqZ4x0ADis=;
 b=MXlE6zEeY6LBqGMROWMcWkZ4eFaf4SPcfBG6jSmm4MoXR6TLKFiwykNZzPHH/MBuqM
 1HrfoqkaBiTmxQ6yfb3tFpx0vMK8mUWSIg/GRyin45u9AO90uPmvWn96hv0VZTknO6Tp
 pOMBDCgbeJV8HdqVcpicfyA/P6+GhnrD1o5PYhUTPXdIay/IAz7XLRJmWrOjUV6uh2p0
 xh8zPvJtNkOMDwYzvDbBwmE+SfjFQF9dGCQXYjalGmTOVUYvEE/jj04wNzrQ139KaGHV
 MayOghLA/OHtFCDkJ5RtvMIYtSqfwjzBlDPz7RNgzINwzJt7vyfosDuqrqN3gnj+VAgA
 0E+A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769156062; x=1769760862; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WLCS8mUbPsMEaFon1hShnvKrpT5VHmYxW96jmNUIElk=;
 b=lbLmuJpYNLFoJyavTxVUdfQA9ya4SoSwpDg7KuuONIxgQ2zckmyl284dCuWnKwC8wt
 xmw+2tSJgUZTVRfuPlG4j3REwuoBSgLRJm9D1oE9kuPp/fyzwPAwZEGZSRKTdhEE8yQR
 As0rO/BgAF+w32FDIvGdWKGjm/g/belwWNIHj8nRPnW5+wwHC3/0HIeSWyD8p/OVCKLD
 e04u8BaQhzHRRsIODNHahWnxWP3a9m38SkaAlHfc1G/HrZ15gnQg2GZCR0KQPuA08Ooc
 P+AnFhkkbl6VwGISttOvtG7hl+er+e/SrcBcIVQ0E9i9WnEAbl0YQOGq+tYxsOODh9WF
 yoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769156062; x=1769760862;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WLCS8mUbPsMEaFon1hShnvKrpT5VHmYxW96jmNUIElk=;
 b=mSlQ5EYEFPxYs4102IUeoBpBUmBle8ly+OJQ+B7bCIpCCnZWCp3xpA/56dpOWghymQ
 bhQ7BH0jxzAF/oHhi0ADPdxsJysKLQ8lylVGdONCzuHLSL7TcW/hJmpkPF4yMB9bsusy
 BAklg8iW3BEA5C34aompuQXPoS/3qnmbwmKXTUmVxZpf29h7rTsWdw9i1Hq4lnfiMbqv
 5qU7eiU/IH5BOJS2ewyO3V9QzFbgwo3KvuSC5ZGQk1+S21Tamt5s3loBAixsjyKDbR3a
 SVClScZTX1h1elW7EtqlMc7/klzXJqrUge1tCvS+ITMUJxVWLTQhwbEg9o15VnJks5UN
 tYlQ==
X-Gm-Message-State: AOJu0Yw//yMh2sSwp0I83JNN9RbMnPGrZizPDc1/66ZXhSwCj+B42733
 lrC1GeYyKcRQ1UjaIo1uRUzEOEM3mAb9TX+l4vfL9W6vtnyQ2foQA6fCt40xYwU/aPg0brKnKlL
 3mk0LXqmGcvUlZlc5AlZp6vBL1VbqSqmYalJr2nix6ag6nX4IlBSULMj3jpXYYfFqmU869dmk1Z
 TnFGe5PkfPv3sJHEqCaRyxETWyM9ojFdc=
X-Gm-Gg: AZuq6aKi/FU46j38FY3bnKdMyif3jyXsTIoYmPTUS5SJOBnVHTV4iyUmW4fkDG6rDsI
 1Av0uezRV2XTELwD4lrDE4StVU/kmD40o3v/6Wl5S+3NyKRaaitiKhGiCTGLiR4K33qD+C5t4/A
 reVGEvLWZThfzXevSrB9XFXlbHt1mEWy7gep8ZLuZ5gX7hhdiELwG3a7ORY68KNiKMVuW1UgdC9
 fZt8dXigseL19aE7Q85EH1FYCRBtcF431tjB6/augltBzDKSW+XUJYE
X-Received: by 2002:a05:600c:198d:b0:47e:e8de:7420 with SMTP id
 5b1f17b1804b1-4804c9af7f2mr32959655e9.22.1769156061891; 
 Fri, 23 Jan 2026 00:14:21 -0800 (PST)
X-Received: by 2002:a05:600c:198d:b0:47e:e8de:7420 with SMTP id
 5b1f17b1804b1-4804c9af7f2mr32959335e9.22.1769156061422; Fri, 23 Jan 2026
 00:14:21 -0800 (PST)
MIME-Version: 1.0
References: <20260122221111.3538536-1-peterx@redhat.com>
In-Reply-To: <20260122221111.3538536-1-peterx@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Fri, 23 Jan 2026 13:44:04 +0530
X-Gm-Features: AZwV_Qgocb1uQckBSZ_TVvh2at9k9W52lk_uCMP9WliUcIKMoBfBLXf8Z4JSKf8
Message-ID: <CAE8KmOz=BtwpaLzzsVfwSbaFAFahqNrBYeDpS6dDTwAU+G+K3Q@mail.gmail.com>
Subject: Re: [PATCH] migration: Introduce migrate_use_return_path()
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Juraj Marcin <jmarcin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
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

On Fri, 23 Jan 2026 at 03:41, Peter Xu <peterx@redhat.com> wrote:
> Introduce a helper to show if we want to enable return path.

* return path -> the return path

> We used to imply that for postcopy-ram, that's not normally how we add cap
> dependencies, however it has been like it for years.  Add some comment and
> stick with it.

/* This reads more suitable for cover-letter. */ Maybe - Postcopy
requires and enables the return path connection, add due comments for
it.

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.h |  1 +
>  migration/migration.c | 15 ++++++++++++++-
>  migration/rdma.c      |  8 +++-----
>  migration/tls.c       |  4 ++--
>  4 files changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/migration/migration.h b/migration/migration.h
> index ccc4e536a5..32c2e70205 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -605,5 +605,6 @@ void migration_bitmap_sync_precopy(bool last_stage);
>  /* migration/block-dirty-bitmap.c */
>  void dirty_bitmap_mig_init(void);
>  bool should_send_vmdesc(void);
> +bool migrate_use_return_path(void);
>
>  #endif
> diff --git a/migration/migration.c b/migration/migration.c
> index 1bcde301f7..f550485ea5 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -109,6 +109,19 @@ static bool close_return_path_on_source(MigrationState *s);
>  static void migration_completion_end(MigrationState *s);
>  static void migrate_hup_delete(MigrationState *s);
>
> +/*
> + * Postcopy-ram will imply return path.

* Postcopy-ram requires and enables the return path connection.

> + * Normally we don't describe capability dependencies like this; we could
> + * have failed the migration request if postcopy-ram is selected withour
> + * return-path.  Said that, we had this as part of postcopy-ram capability
> + * ABI for years.. let's stick with it.
> + */

* withour -> without the

> +bool migrate_use_return_path(void)
> +{
> +    return migrate_postcopy_ram() || migrate_return_path();
> +}
> +

* It would have been nicer if we could include '&&
!rdma->is_return_path' here, but that does not seem doable. Is '&&
!rdma->is_return_path' check really required?

>  static void migration_downtime_start(MigrationState *s)
>  {
>      trace_vmstate_downtime_checkpoint("src-downtime-start");
> @@ -4067,7 +4080,7 @@ void migration_connect(MigrationState *s, Error *error_in)
>       * precopy, only if user specified "return-path" capability would
>       * QEMU uses the return path.
>       */
> -    if (migrate_postcopy_ram() || migrate_return_path()) {
> +    if (migrate_use_return_path()) {
>          open_return_path_on_source(s);
>      }
>
> diff --git a/migration/rdma.c b/migration/rdma.c
> index cced173379..a55c80908c 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -3186,8 +3186,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
>       * initialize the RDMAContext for return path for postcopy after first
>       * connection request reached.
>       */
> -    if ((migrate_postcopy() || migrate_return_path())
> -        && !rdma->is_return_path) {
> +    if (migrate_use_return_path() && !rdma->is_return_path) {
>          rdma_return_path = qemu_rdma_data_init(isock, NULL);

* Here we check && !rdma->is_return_path

>      /* RDMA postcopy need a separate queue pair for return path */
> -    if (migrate_postcopy() || migrate_return_path()) {
> +    if (migrate_use_return_path()) {
>          rdma_return_path = qemu_rdma_data_init(host_port, errp);

* Here we don't check '&& !rdma->is_return_path' ...?

>          if (rdma_return_path == NULL) {
> diff --git a/migration/tls.c b/migration/tls.c
> index 56b5d1cc90..7fb49ddd82 100644
> --- a/migration/tls.c
> +++ b/migration/tls.c
> @@ -90,7 +90,7 @@ void migration_tls_channel_process_incoming(MigrationState *s,
>
>      trace_migration_tls_incoming_handshake_start();
>      qio_channel_set_name(QIO_CHANNEL(tioc), "migration-tls-incoming");
> -    if (migrate_postcopy_ram() || migrate_return_path()) {
> +    if (migrate_use_return_path()) {
>          qio_channel_set_feature(QIO_CHANNEL(tioc),
>                                  QIO_CHANNEL_FEATURE_CONCURRENT_IO);
>      }
> @@ -154,7 +154,7 @@ void migration_tls_channel_connect(MigrationState *s,
>      trace_migration_tls_outgoing_handshake_start(hostname);
>      qio_channel_set_name(QIO_CHANNEL(tioc), "migration-tls-outgoing");
>
> -    if (migrate_postcopy_ram() || migrate_return_path()) {
> +    if (migrate_use_return_path()) {
>          qio_channel_set_feature(QIO_CHANNEL(tioc),
>                                  QIO_CHANNEL_FEATURE_CONCURRENT_IO);
>      }
> --

* Change looks okay.  /* The !rdma->is_return_path check is a little
confusing. */
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


