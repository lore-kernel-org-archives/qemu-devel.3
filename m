Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85B5C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 17:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thu7o-0005x4-UV; Tue, 11 Feb 2025 12:32:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thu7l-0005wQ-RV
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 12:32:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thu7j-00088O-Jc
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 12:32:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739295157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sDyyNjqocL9CmI1TfesKeg9aKv2kSRuSpLHBRdnv7U8=;
 b=D7Jq2xc4rmdm8C0O3ZpNjqYYTCvPqz3+LAwnVx7KgU2cPQlF5n1gz7Et2Fd+uoICrNuZgp
 c4QFbiJRWTmKQmdYbN1rT+ayrmxh5cEbw+fWtH/WBFe6siDTX3fD8hZVoGhAhqr1Rjy+H4
 5ThMp4ZWlNL9fGsnf/QzRul6X5Yvxt8=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-rGIMXU_NOYSCM7emAc9O2Q-1; Tue, 11 Feb 2025 12:32:36 -0500
X-MC-Unique: rGIMXU_NOYSCM7emAc9O2Q-1
X-Mimecast-MFC-AGG-ID: rGIMXU_NOYSCM7emAc9O2Q
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3f3ba8095a1so1689996b6e.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 09:32:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739295155; x=1739899955;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sDyyNjqocL9CmI1TfesKeg9aKv2kSRuSpLHBRdnv7U8=;
 b=cMCBBRlSp/ojd77f/JQT3KSfGTp/BySeU+y5OMP6a3X7/7DK84p0MrImbX42YJC75k
 6zfRLSXbOqGmPlicIW9nfCdZDvQfOf8081Xio4pPBRn1iRuKRrY7oBbWf8rWJrVeE5ej
 sLpQ1wuGXlQgA0otNxiv7qQBFe+DQPwCHu9wLcz9TXCXqRa4v+T1lPA9pD56XXg6gDCl
 OyEeHgwfpJD1bE/WrA8adY95CZ0IaY1PTpKiD/VfSH1yPqzqJu9cfBAyDBzfbO7Fm6p8
 LnpcQycJEtDnv7IzOQYpWUa7WbRu/fJvdJ+xA+8j7EB/2JI57k656wrjBs3MtYY9dFkN
 6TCw==
X-Gm-Message-State: AOJu0YxPqhxJB+3x8hOXgPxwBkaygCln3oTkRoZjR9xX1w+c4MvBJyxB
 inmvOWUL7SqAAw8aqfNSFeebQA7PYM6lI6JX7lHNZjxGhLbxD0lT9Y8xNGWI6i27uyGL5UxFAfQ
 loWqazCcP9gGA8C6jev8oNmNfwfGRfNHvXCyYkdcxU91hmFsEH/SVL3Va8O7z
X-Gm-Gg: ASbGncu4oNaNnVKWPJkYBo6elJFO79JZefWA6MZa2sQabKVmQeAy0JW0kd8r/dp+BbI
 boZig20IzjBEYIyfzF4Yz3zria2jHVGOas47VmvWblMi4l2pzatNaBRBEekeKlNAw5WcLn4XNPt
 n7XzHwg2HtQ/kjV5NDwEsVcE1C5k2wiSYC1XFlnsMENCIuAH+3ZVO2YHX+RnvtFKd2t6MOC6y8D
 bGAChRt2FIbJ482iB8FSyR1nEHQQ9P8FGLn6oDOIjqDJHLAfBw7VWGybCA=
X-Received: by 2002:a05:6808:17aa:b0:3eb:551c:b67b with SMTP id
 5614622812f47-3f3cd77f055mr224974b6e.38.1739295155177; 
 Tue, 11 Feb 2025 09:32:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5cEBjTOKlDrSggPoAjZiXQeFoyt02qD4OLm5VkrbFFtSuQ+r5A02xALeUsXnacva/zjwTnQ==
X-Received: by 2002:a05:6808:17aa:b0:3eb:551c:b67b with SMTP id
 5614622812f47-3f3cd77f055mr224951b6e.38.1739295154816; 
 Tue, 11 Feb 2025 09:32:34 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc78cad5f2sm2101857eaf.40.2025.02.11.09.32.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 09:32:34 -0800 (PST)
Date: Tue, 11 Feb 2025 12:32:30 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH v2 3/9] migration: Change migrate_fd_ to migration_
Message-ID: <Z6uJruVat6CxdU-I@x1.local>
References: <20250211150136.6781-1-farosas@suse.de>
 <20250211150136.6781-4-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250211150136.6781-4-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Feb 11, 2025 at 12:01:30PM -0300, Fabiano Rosas wrote:
> Remove all instances of _fd_ from the migration generic code. These
> functions have grown over time and the _fd_ part is now just
> confusing.
> 
> migration_fd_error() -> migration_error() makes it a little vague, so
> change it to migration_set_error_state().

I am ok on even renaming all of them if you prefer, but let me comment on
something, as not all of them apply to "fd is old concept"..

> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/channel.c    |  4 ++--
>  migration/migration.c  | 30 +++++++++++++++---------------
>  migration/migration.h  |  2 +-
>  migration/multifd.c    |  2 +-
>  migration/rdma.c       |  2 +-
>  migration/trace-events |  2 +-
>  6 files changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/migration/channel.c b/migration/channel.c
> index f9de064f3b..24a91ef911 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -74,7 +74,7 @@ void migration_channel_connect(MigrationState *s,
>              if (!error) {
>                  /* tls_channel_connect will call back to this
>                   * function after the TLS handshake,
> -                 * so we mustn't call migrate_fd_connect until then
> +                 * so we mustn't call migration_connect until then

migrate_fd_connect() makes some point only because of rdma, which can set
to_dst_file on its own.. which is indeed an fd (if we say fd~=qemufile)..

>                   */
>  
>                  return;
> @@ -89,7 +89,7 @@ void migration_channel_connect(MigrationState *s,
>              qemu_mutex_unlock(&s->qemu_file_lock);
>          }
>      }
> -    migrate_fd_connect(s, error);
> +    migration_connect(s, error);
>      error_free(error);
>  }
>  
> diff --git a/migration/migration.c b/migration/migration.c
> index e37842fdd2..db8d6e8ea7 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1423,12 +1423,12 @@ static void migration_cleanup_json_writer(MigrationState *s)
>      g_clear_pointer(&s->vmdesc, json_writer_free);
>  }
>  
> -static void migrate_fd_cleanup(MigrationState *s)
> +static void migration_cleanup(MigrationState *s)
>  {
>      MigrationEventType type;
>      QEMUFile *tmp = NULL;
>  
> -    trace_migrate_fd_cleanup();
> +    trace_migration_cleanup();
>  
>      migration_cleanup_json_writer(s);
>  
> @@ -1485,9 +1485,9 @@ static void migrate_fd_cleanup(MigrationState *s)
>      yank_unregister_instance(MIGRATION_YANK_INSTANCE);
>  }
>  
> -static void migrate_fd_cleanup_bh(void *opaque)
> +static void migration_cleanup_bh(void *opaque)
>  {
> -    migrate_fd_cleanup(opaque);
> +    migration_cleanup(opaque);
>  }
>  
>  void migrate_set_error(MigrationState *s, const Error *error)
> @@ -1517,7 +1517,7 @@ static void migrate_error_free(MigrationState *s)
>      }
>  }
>  
> -static void migrate_fd_error(MigrationState *s, const Error *error)
> +static void migration_set_error_state(MigrationState *s, const Error *error)

This one also is slightly tricky, on that it is only used when fd connect
fails, so it has:

    assert(s->to_dst_file == NULL);

To avoid it being wrongly used during migration active, maybe rename it to
migration_connect_set_error()?

All look good otherwise.

>  {
>      MigrationStatus current = s->state;
>      MigrationStatus next;
> @@ -2198,7 +2198,7 @@ void qmp_migrate(const char *uri, bool has_channels,
>  
>  out:
>      if (local_err) {
> -        migrate_fd_error(s, local_err);
> +        migration_set_error_state(s, local_err);
>          error_propagate(errp, local_err);
>      }
>  }
> @@ -2243,7 +2243,7 @@ static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
>          if (!resume_requested) {
>              yank_unregister_instance(MIGRATION_YANK_INSTANCE);
>          }
> -        migrate_fd_error(s, local_err);
> +        migration_set_error_state(s, local_err);
>          error_propagate(errp, local_err);
>          return;
>      }
> @@ -3427,7 +3427,7 @@ static void migration_iteration_finish(MigrationState *s)
>          break;
>      }
>  
> -    migration_bh_schedule(migrate_fd_cleanup_bh, s);
> +    migration_bh_schedule(migration_cleanup_bh, s);
>      bql_unlock();
>  }
>  
> @@ -3455,7 +3455,7 @@ static void bg_migration_iteration_finish(MigrationState *s)
>          break;
>      }
>  
> -    migration_bh_schedule(migrate_fd_cleanup_bh, s);
> +    migration_bh_schedule(migration_cleanup_bh, s);
>      bql_unlock();
>  }
>  
> @@ -3837,7 +3837,7 @@ fail_setup:
>      return NULL;
>  }
>  
> -void migrate_fd_connect(MigrationState *s, Error *error_in)
> +void migration_connect(MigrationState *s, Error *error_in)
>  {
>      Error *local_err = NULL;
>      uint64_t rate_limit;
> @@ -3847,24 +3847,24 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>      /*
>       * If there's a previous error, free it and prepare for another one.
>       * Meanwhile if migration completes successfully, there won't have an error
> -     * dumped when calling migrate_fd_cleanup().
> +     * dumped when calling migration_cleanup().
>       */
>      migrate_error_free(s);
>  
>      s->expected_downtime = migrate_downtime_limit();
>      if (error_in) {
> -        migrate_fd_error(s, error_in);
> +        migration_set_error_state(s, error_in);
>          if (resume) {
>              /*
>               * Don't do cleanup for resume if channel is invalid, but only dump
>               * the error.  We wait for another channel connect from the user.
>               * The error_report still gives HMP user a hint on what failed.
> -             * It's normally done in migrate_fd_cleanup(), but call it here
> +             * It's normally done in migration_cleanup(), but call it here
>               * explicitly.
>               */
>              error_report_err(error_copy(s->error));
>          } else {
> -            migrate_fd_cleanup(s);
> +            migration_cleanup(s);
>          }
>          return;
>      }
> @@ -3944,7 +3944,7 @@ fail:
>      migrate_set_error(s, local_err);
>      migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
>      error_report_err(local_err);
> -    migrate_fd_cleanup(s);
> +    migration_cleanup(s);
>  }
>  
>  static void migration_class_init(ObjectClass *klass, void *data)
> diff --git a/migration/migration.h b/migration/migration.h
> index 3547420c52..76afef34c4 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -484,7 +484,7 @@ bool  migration_has_all_channels(void);
>  void migrate_set_error(MigrationState *s, const Error *error);
>  bool migrate_has_error(MigrationState *s);
>  
> -void migrate_fd_connect(MigrationState *s, Error *error_in);
> +void migration_connect(MigrationState *s, Error *error_in);
>  
>  int migration_call_notifiers(MigrationState *s, MigrationEventType type,
>                               Error **errp);
> diff --git a/migration/multifd.c b/migration/multifd.c
> index ab73d6d984..d7ea8668ad 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -444,7 +444,7 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
>           * channels have no I/O handler callback registered when reaching
>           * here, because migration thread will wait for all multifd channel
>           * establishments to complete during setup.  Since
> -         * migrate_fd_cleanup() will be scheduled in main thread too, all
> +         * migration_cleanup() will be scheduled in main thread too, all
>           * previous callbacks should guarantee to be completed when
>           * reaching here.  See multifd_send_state.channels_created and its
>           * usage.  In the future, we could replace this with an assert
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 855753c671..76fb034923 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -4174,7 +4174,7 @@ void rdma_start_outgoing_migration(void *opaque,
>  
>      s->to_dst_file = rdma_new_output(rdma);
>      s->rdma_migration = true;
> -    migrate_fd_connect(s, NULL);
> +    migration_connect(s, NULL);
>      return;
>  return_path_err:
>      qemu_rdma_cleanup(rdma);
> diff --git a/migration/trace-events b/migration/trace-events
> index d22600abe6..58c0f07f5b 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -154,7 +154,7 @@ multifd_set_outgoing_channel(void *ioc, const char *ioctype, const char *hostnam
>  
>  # migration.c
>  migrate_set_state(const char *new_state) "new state %s"
> -migrate_fd_cleanup(void) ""
> +migration_cleanup(void) ""
>  migrate_error(const char *error_desc) "error=%s"
>  migration_cancel(void) ""
>  migrate_handle_rp_req_pages(const char *rbname, size_t start, size_t len) "in %s at 0x%zx len 0x%zx"
> -- 
> 2.35.3
> 

-- 
Peter Xu


