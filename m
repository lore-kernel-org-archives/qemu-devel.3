Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFFCCCF2F2
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 12:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhoH9-00060o-Im; Mon, 19 Jan 2026 07:22:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vhoH7-000608-3z
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 07:22:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vhoH4-0003ZR-6Q
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 07:22:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768825344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B+Wd5qOlotX1cWm18nYYGxrzMwpgTcJnkX6y0ZEIXFg=;
 b=Rtt+19QuufsPn1ECB67d283s62T7jo4OLXDOC2YlRZLf89P859nAY45+2o/cdyWJekWXbw
 DkRuMkrMFJdJ1BdKsqRZKm9cbDCm2afGOUQupEOjteb37TE87T/9DpSpY/UBol9k55r0iU
 ElG2R6a1ZRrBjqwl3dS9th2deTGDEmg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-kpMXTHP3O3mvqQleTStwBw-1; Mon, 19 Jan 2026 07:22:21 -0500
X-MC-Unique: kpMXTHP3O3mvqQleTStwBw-1
X-Mimecast-MFC-AGG-ID: kpMXTHP3O3mvqQleTStwBw_1768825340
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47ee71f0244so39566545e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 04:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768825340; x=1769430140; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B+Wd5qOlotX1cWm18nYYGxrzMwpgTcJnkX6y0ZEIXFg=;
 b=sKFqSbLRaiBax9heZHAqXjw+lSDkV4J8N11ZKpisgGtGdN9khp85RbhZ8YDNz0YLFm
 GfVaEpuLK9gE86eH8xLhomWyE/ZkE7QoOzhUFK5JR8iVsXG6P3xCo4zr0bEA3lc0J2qc
 WiNjigf0OmldCU4oMP7IZNeTuTpJzP2k9Y5WUz4fuUGLcyU4gqAhwOauN8VEgQ8S5awx
 TqPqt69EBsAkafuHwKXyQ/FfzSEgp5z1Yp+rB8//at6QmM+cAQp8g1LLWdEsuG0bAFFD
 JY6yYRa5S14FqLXX8ATphhqbQ0o7ToiBVkUBpuND/O0luQgtGIFd1Y8ymSXj+0hq5ou5
 XS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768825340; x=1769430140;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B+Wd5qOlotX1cWm18nYYGxrzMwpgTcJnkX6y0ZEIXFg=;
 b=kxd+1U2dvt6D+uznkWGbcgCGyPNL+Cl6ZzGcnw94IK6m9+EwyslihufOL8+aNnEd38
 TsKt9IjTguGwhrvSjZ/CZMWk6oardRcuMESRVKKW5Ln6t3lmpMRA0nwBT3ltSJG2KmyH
 euWtGSmlk6jnTM1rFNCBRh5yO6pvRVrQ6RY+XGNGYujakjbVT3fp/+ef/VAlvPaKDqXQ
 YpJA4fA0bOsSq6U1AN61ZqptY3wrUe7TwNuyBd6Buw/PS+vtAmTmhU9wBfCZv57NNftM
 9p6FmZoXdhneXAa6tYUUkRGYLMN9ElupbNsRIvKV2LOp+pXrpG8hAs3gJkPrsA65Ko/B
 4jGQ==
X-Gm-Message-State: AOJu0YwMUqZKQn7OQymSIKvpWemhXaCtg81/Qy9bkHMxOZyIIXDS++Vs
 YRZXPwUTFaWQ9sC+bHuf/s4AozToVllSQLXG+xf3otsXMSKP+0MotQlHyVQ+D9FFHQx9cpq1OeZ
 S1Dj40v6j5ktO4e+9HPi9qZAF9YPJR79VaujDhBEVEahzf440L5jRFqO0S5CU4+Nde3EzuM1fzP
 MPX3HZk10EINWThbRSM13a2iZKGDYcOQw=
X-Gm-Gg: AY/fxX4gnuwdOG/dOggo984dBtpEWYUJJfc7Yi5yUSJr0tz/G/mUBL2PdvlaYM6rptd
 deTMRUhXCN49B3zlmiuVJ/q529Khxm4f9A/8G563Q6R9QuJo/eQwMp2Xfjox4zP69k4DoIIKJzC
 mV0R+liHdYBIz94wvKm7uTXJuFwD9SPIGimlqqKkR6UV4wJ3PGA0PTtLa9193innbsyjlnvsHKq
 phjd3mKEj6ruOp30s28URSVYM96tSMXdSqUn0kWAFH0ZBo9HId7AP/f
X-Received: by 2002:a05:600c:5248:b0:477:b642:9dc9 with SMTP id
 5b1f17b1804b1-4801e3459d3mr132679765e9.28.1768825339728; 
 Mon, 19 Jan 2026 04:22:19 -0800 (PST)
X-Received: by 2002:a05:600c:5248:b0:477:b642:9dc9 with SMTP id
 5b1f17b1804b1-4801e3459d3mr132679265e9.28.1768825339242; Mon, 19 Jan 2026
 04:22:19 -0800 (PST)
MIME-Version: 1.0
References: <20260109124043.25019-1-farosas@suse.de>
 <20260109124043.25019-14-farosas@suse.de>
In-Reply-To: <20260109124043.25019-14-farosas@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 19 Jan 2026 17:52:02 +0530
X-Gm-Features: AZwV_QgdTjJ7MeFRt4A-CZRlHF2QdoEP87JLcZ9TR6Gs_HSN8Rlp2Tll3cOEhgE
Message-ID: <CAE8KmOz4_RAM1QgJUuEwk=68-jwgt25O7vfPNOkce2vvEOED0w@mail.gmail.com>
Subject: Re: [PATCH v3 13/25] migration: Move setting of QEMUFile into
 migration_outgoing|incoming_setup
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

On Fri, 9 Jan 2026 at 18:12, Fabiano Rosas <farosas@suse.de> wrote:
>
> Centralize, on both sides of migration, the setting of the to_src_file
> and from_dst_file QEMUFiles. This will clean up the interface with
> channel.c and rdma.c, allowing those files to stop dealing with
> QEMUFile themselves.
>
> (multifd_recv_new_channel was changed to return bool+errp for
> convenience)
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/channel.c   |  9 +----
>  migration/migration.c | 84 ++++++++++++++++++++++++++-----------------
>  migration/migration.h |  2 ++
>  migration/multifd.c   |  8 +++--
>  migration/multifd.h   |  2 +-
>  5 files changed, 61 insertions(+), 44 deletions(-)
>
> diff --git a/migration/channel.c b/migration/channel.c
> index 26cb7bf059..6acce7b2a2 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -14,7 +14,6 @@
>  #include "channel.h"
>  #include "tls.h"
>  #include "migration.h"
> -#include "qemu-file.h"
>  #include "trace.h"
>  #include "qapi/error.h"
>  #include "io/channel-tls.h"
> @@ -80,14 +79,8 @@ void migration_channel_connect(MigrationState *s, QIOChannel *ioc)
>          return;
>      }
>
> -    QEMUFile *f = qemu_file_new_output(ioc);
> -
>      migration_ioc_register_yank(ioc);
> -
> -    qemu_mutex_lock(&s->qemu_file_lock);
> -    s->to_dst_file = f;
> -    qemu_mutex_unlock(&s->qemu_file_lock);
> -
> +    migration_outgoing_setup(ioc);
>      migration_connect(s);
>  }
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 1ea6125454..b7367eb5cf 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -930,17 +930,56 @@ out:
>      migrate_incoming_unref_outgoing_state();
>  }
>
> -/**
> - * migration_incoming_setup: Setup incoming migration
> - * @f: file for main migration channel
> +static bool migration_has_main_and_multifd_channels(void);
> +
> +/*
> + * Returns whether all the necessary channels to proceed with the
> + * incoming migration have been established without error.
>   */
> -static void migration_incoming_setup(QEMUFile *f)
> +bool migration_incoming_setup(QIOChannel *ioc, uint8_t channel, Error **errp)
>  {
>      MigrationIncomingState *mis = migration_incoming_get_current();
> +    QEMUFile *f;
>
> -    assert(!mis->from_src_file);
> -    mis->from_src_file = f;
> -    qemu_file_set_blocking(f, false, &error_abort);
> +    if (multifd_recv_setup(errp) != 0) {
> +        return false;
> +    }
> +
> +    switch (channel) {
> +    case CH_MAIN:
> +        f = qemu_file_new_input(ioc);
> +        assert(!mis->from_src_file);
> +        mis->from_src_file = f;
> +        qemu_file_set_blocking(f, false, &error_abort);
> +        break;
> +
> +    case CH_MULTIFD:
> +        if (!multifd_recv_new_channel(ioc, errp)) {
> +            return false;
> +        }
> +        break;
> +
> +    case CH_POSTCOPY:
> +        assert(!mis->postcopy_qemufile_dst);
> +        f = qemu_file_new_input(ioc);
> +        postcopy_preempt_new_channel(mis, f);
> +        return false;
> +
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    return migration_has_main_and_multifd_channels();
> +}
> +
> +void migration_outgoing_setup(QIOChannel *ioc)
> +{
> +    MigrationState *s = migrate_get_current();
> +    QEMUFile *f = qemu_file_new_output(ioc);
> +
> +    qemu_mutex_lock(&s->qemu_file_lock);
> +    s->to_dst_file = f;
> +    qemu_mutex_unlock(&s->qemu_file_lock);
>  }

* Shouldn't migration_outgoing_setup() also return bool, to be
consistent with migration_incoming_setup() above?  OR make
migration_incoming_setup() return void.

>  /* Returns true if recovered from a paused migration, otherwise false */
> @@ -988,7 +1027,11 @@ void migration_incoming_process(void)
>
>  void migration_fd_process_incoming(QEMUFile *f)
>  {
> -    migration_incoming_setup(f);
> +    MigrationIncomingState *mis = migration_incoming_get_current();
> +
> +    assert(!mis->from_src_file);
> +    mis->from_src_file = f;
> +    qemu_file_set_blocking(f, false, &error_abort);
>      migration_incoming_process();
>  }

* Is it possible to move above mis->from_src_file = f part to
migration_incoming_setup()?


> @@ -1011,8 +1054,6 @@ static bool migration_has_main_and_multifd_channels(void)
>  void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>  {
>      MigrationIncomingState *mis = migration_incoming_get_current();
> -    Error *local_err = NULL;
> -    QEMUFile *f;
>      uint8_t channel;
>      uint32_t channel_magic = 0;
>      int ret = 0;
> @@ -1066,28 +1107,7 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>          channel = CH_POSTCOPY;
>      }
>
> -    if (multifd_recv_setup(errp) != 0) {
> -        return;
> -    }
> -
> -    if (channel == CH_MAIN) {
> -        f = qemu_file_new_input(ioc);
> -        migration_incoming_setup(f);
> -    } else if (channel == CH_MULTIFD) {
> -        /* Multiple connections */
> -        multifd_recv_new_channel(ioc, &local_err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -            return;
> -        }
> -    } else if (channel == CH_POSTCOPY) {
> -        assert(!mis->postcopy_qemufile_dst);
> -        f = qemu_file_new_input(ioc);
> -        postcopy_preempt_new_channel(mis, f);
> -        return;
> -    }
> -
> -    if (migration_has_main_and_multifd_channels()) {
> +    if (migration_incoming_setup(ioc, channel, errp)) {
>          migration_incoming_process();
>      }
>  }
> diff --git a/migration/migration.h b/migration/migration.h
> index d134881eaf..4dcf299719 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -530,6 +530,8 @@ void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
>  void migration_fd_process_incoming(QEMUFile *f);
>  void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
>  void migration_incoming_process(void);
> +bool migration_incoming_setup(QIOChannel *ioc, uint8_t channel, Error **errp);
> +void migration_outgoing_setup(QIOChannel *ioc);
>
>  bool  migration_has_all_channels(void);
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 3fb1a07ba9..4980ed4f04 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -1521,7 +1521,7 @@ bool multifd_recv_all_channels_created(void)
>   * Try to receive all multifd channels to get ready for the migration.
>   * Sets @errp when failing to receive the current channel.
>   */
> -void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
> +bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
>  {
>      MultiFDRecvParams *p;
>      Error *local_err = NULL;
> @@ -1536,7 +1536,7 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
>                                      "failed to receive packet"
>                                      " via multifd channel %d: ",
>                                      qatomic_read(&multifd_recv_state->count));
> -            return;
> +            return false;
>          }
>          trace_multifd_recv_new_channel(id);
>      } else {
> @@ -1549,7 +1549,7 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
>                     id);
>          multifd_recv_terminate_threads(error_copy(local_err));
>          error_propagate(errp, local_err);
> -        return;
> +        return false;
>      }
>      p->c = ioc;
>      object_ref(OBJECT(ioc));
> @@ -1558,4 +1558,6 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
>      qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
>                         QEMU_THREAD_JOINABLE);
>      qatomic_inc(&multifd_recv_state->count);
> +
> +    return true;
>  }
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 9b6d81e7ed..89a395aef2 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -42,7 +42,7 @@ int multifd_recv_setup(Error **errp);
>  void multifd_recv_cleanup(void);
>  void multifd_recv_shutdown(void);
>  bool multifd_recv_all_channels_created(void);
> -void multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
> +bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
>  void multifd_recv_sync_main(void);
>  int multifd_send_sync_main(MultiFDSyncReq req);
>  bool multifd_queue_page(RAMBlock *block, ram_addr_t offset);
> --

* Change looks okay.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


