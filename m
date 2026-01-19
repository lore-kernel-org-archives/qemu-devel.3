Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D9ECCF2F2
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 12:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhoJU-0007pd-K4; Mon, 19 Jan 2026 07:24:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vhoJO-0007mX-IQ
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 07:24:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vhoJM-0003yo-G6
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 07:24:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768825487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UnBWm1Th2nLRdKtMs5uyt9yiHg4fpVDws5uLvOWAhwQ=;
 b=YBd++lpq+Tb8IFEfdtJLZB7HJDldzISg88ZiTmpz1uS1SeVFqnrpSHHrWDJ4LO7yuqLWLI
 lkr6KGtp50gr07dOMXplf+ggUcssj5OC/XoYvbutnSPQeXZHHmM3fRyA84IfvnFIiyvOCA
 D6DIoFUST2mpcwGnv6Q+WT9qT2RplHM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-o_0w78hkOiaxcsXeMo78dw-1; Mon, 19 Jan 2026 07:24:46 -0500
X-MC-Unique: o_0w78hkOiaxcsXeMo78dw-1
X-Mimecast-MFC-AGG-ID: o_0w78hkOiaxcsXeMo78dw_1768825485
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47d5c7a2f54so36164325e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 04:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768825483; x=1769430283; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UnBWm1Th2nLRdKtMs5uyt9yiHg4fpVDws5uLvOWAhwQ=;
 b=i9c7LmxurW1MT6VZor41DyI5yHohd46EV44ROf1AztLyd5fGdnJTC9tSKxu9iMWKGR
 tB0X8r8/zO3y3Vv/6wbcuRVtDjgc0OCYKiVWxcV9ZmZeVX/0DBsH0Rc7xH3b52lE9fcn
 GZABNY/sBdjaW3yGbtZQWthr+LhrXKQkAVA4awY8VDpcSbLkdJOhyClKsRap7gNjA1UE
 ULbh5qHtx0pYNPIh07O2fzLFNImhNhoD2rOAlzUSvCB7ASynJ0y/6p9jkFdQfJoNdJNW
 ENia2CeDXzd+2g4AOBaTsPhwUfOKthewncg7EcQ4WGDVZwoOyhF3HzN+0QRcd9oBRv8t
 LQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768825483; x=1769430283;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UnBWm1Th2nLRdKtMs5uyt9yiHg4fpVDws5uLvOWAhwQ=;
 b=Iy4n576vJ8+XL8HpkKPZXlA891adlRm9dIkVqJ1hLvxC0YwfbxY5HAWCNBpmJVi05V
 VJU/+w4K+IvjJwKduIixnRorlEKBvfcVvcE1UPcNzx1i6R8UnTBE60FQw13kXDq2wZyE
 9Dlw/Qp8eiUUnlAW9GtBzAZxt1NZwg/t74sz7q00ax69YPhqsGK6hxYXNMPpf2FfC6H4
 K4GlPX5qN98m3Whml9bqg6WH/xp4S1JWURT4cNszR006Roc/7h8+wx8DrRE/UIx1jFyv
 8HLp8q6K7Cb4soZIqDMCbdpp2uhMAElrR9nabn+kbk0mcfigVcg5ZwAQfzrbSYoGfD7X
 QS2Q==
X-Gm-Message-State: AOJu0Yx7uVXslsGUwzpOr/RjKLcO9bh4yMEyzs/DflhHcTJb8chgj6o0
 XJrIXOXwHzVNjdin+f2klbG1t32dLCJISbX8K2uPfOdUQkFVCXZZsCVF1lhaPEuRK02og7xvSBZ
 gT1LmkqYxJbF//XGvKpYdfMX9bDo/FcmXTih0U31n5ev6VOEgnfwiqcyas9iEQPS4L+ho0fuCBD
 zcLSnICQZqGrGvOtb2f8ZMouJuDb8XW4Rbfd43m7zj1g==
X-Gm-Gg: AY/fxX5T0KfnRj4TRChZBW05ApAoN6E/q30900dKpq70AW9k/hoEnoRlUazX96wPKu9
 dN6AZ3HMR6OYm3I5YY2VcvMWmBNenzt0gfeKgzuCf5ZxOL99LqHoa5/UgOiir3MXqiDIjOcRUwc
 De0mT6kKHA8RdD894FN+LGRA3w06O03E9I8QIHNQ83i4uEZwtYICM5GQ8ITCd4EhZQ4OBtBi94u
 0LL4rFhEuqpJZ09KnkXRFqWdy7bsCSMFXZAz0yPZ5yP513iAgRRlvew
X-Received: by 2002:a05:600c:1910:b0:475:ddad:c3a9 with SMTP id
 5b1f17b1804b1-4801e67bceemr140586745e9.13.1768825483519; 
 Mon, 19 Jan 2026 04:24:43 -0800 (PST)
X-Received: by 2002:a05:600c:1910:b0:475:ddad:c3a9 with SMTP id
 5b1f17b1804b1-4801e67bceemr140586325e9.13.1768825483130; Mon, 19 Jan 2026
 04:24:43 -0800 (PST)
MIME-Version: 1.0
References: <20260109124043.25019-1-farosas@suse.de>
 <20260109124043.25019-16-farosas@suse.de>
In-Reply-To: <20260109124043.25019-16-farosas@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 19 Jan 2026 17:54:25 +0530
X-Gm-Features: AZwV_Qiw68gZtp60i3PH8Wu-YFmAD6pqRapckW-laev6CGKpbPKePnWZnb2o0D4
Message-ID: <CAE8KmOzBayEwPEOgVr9Gw8rp8tX8+NLD+Rtzj2FvB+0kh6=e9A@mail.gmail.com>
Subject: Re: [PATCH v3 15/25] migration: Start incoming from channel.c
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
> Leave migration_ioc_process_incoming to do only the channel
> identification process and move the migration start into
> channel.c. Both routines will be renamed in the next patches to better
> reflect their usage.
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/channel.c   | 12 ++++++++++--
>  migration/channel.h   |  5 +++--
>  migration/migration.c | 13 +++++--------
>  migration/migration.h |  3 ++-
>  4 files changed, 20 insertions(+), 13 deletions(-)
>
> diff --git a/migration/channel.c b/migration/channel.c
> index 6acce7b2a2..b8d757c17b 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -33,6 +33,7 @@ void migration_channel_process_incoming(QIOChannel *ioc)
>  {
>      MigrationIncomingState *mis = migration_incoming_get_current();
>      Error *local_err = NULL;
> +    MigChannelType ch;
>
>      trace_migration_set_incoming_channel(
>          ioc, object_get_typename(OBJECT(ioc)));
> @@ -41,9 +42,16 @@ void migration_channel_process_incoming(QIOChannel *ioc)
>          migration_tls_channel_process_incoming(ioc, &local_err);
>      } else {
>          migration_ioc_register_yank(ioc);
> -        migration_ioc_process_incoming(ioc, &local_err);
> -    }
> +        ch = migration_ioc_process_incoming(ioc, &local_err);
> +        if (!ch) {
> +            goto out;
> +        }
>
> +        if (migration_incoming_setup(ioc, ch, &local_err)) {
> +            migration_incoming_process();
> +        }
> +    }
> +out:
>      if (local_err) {
>          error_report_err(local_err);
>          migrate_set_state(&mis->state, mis->state, MIGRATION_STATUS_FAILED);
> diff --git a/migration/channel.h b/migration/channel.h
> index 93dedbf52b..b361e1c838 100644
> --- a/migration/channel.h
> +++ b/migration/channel.h
> @@ -19,11 +19,12 @@
>  #include "io/channel.h"
>
>  /* Migration channel types */
> -enum {
> +typedef enum {
> +    CH_NONE,
>      CH_MAIN,
>      CH_MULTIFD,
>      CH_POSTCOPY
> -};
> +} MigChannelType;
>
>  void migration_channel_process_incoming(QIOChannel *ioc);
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 7d56d73769..a052b99a19 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1038,10 +1038,10 @@ static bool migration_has_main_and_multifd_channels(void)
>      return true;
>  }
>
> -void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
> +MigChannelType migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>  {
>      MigrationIncomingState *mis = migration_incoming_get_current();
> -    uint8_t channel;
> +    MigChannelType channel = CH_NONE;
>      uint32_t channel_magic = 0;
>      int ret = 0;
>
> @@ -1060,7 +1060,7 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>              ret = migration_channel_read_peek(ioc, (void *)&channel_magic,
>                                                sizeof(channel_magic), errp);
>              if (ret != 0) {
> -                return;
> +                goto out;
>              }
>
>              channel_magic = be32_to_cpu(channel_magic);
> @@ -1075,7 +1075,6 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>                  channel = CH_MAIN;
>              } else {
>                  error_setg(errp, "unknown channel magic: %u", channel_magic);
> -                return;
>              }
>          } else if (mis->from_src_file && migrate_multifd()) {
>              /*
> @@ -1087,16 +1086,14 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>              channel = CH_MAIN;
>          } else {
>              error_setg(errp, "non-peekable channel used without multifd");
> -            return;
>          }
>      } else {
>          assert(migrate_postcopy_preempt());
>          channel = CH_POSTCOPY;
>      }
>
> -    if (migration_incoming_setup(ioc, channel, errp)) {
> -        migration_incoming_process();
> -    }
> +out:
> +    return channel;
>  }
>
>  /**
> diff --git a/migration/migration.h b/migration/migration.h
> index cd6cfd62ba..b55cc40613 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -28,6 +28,7 @@
>  #include "postcopy-ram.h"
>  #include "system/runstate.h"
>  #include "migration/misc.h"
> +#include "channel.h"
>
>  #define  MIGRATION_THREAD_SNAPSHOT          "mig/snapshot"
>  #define  MIGRATION_THREAD_DIRTY_RATE        "mig/dirtyrate"
> @@ -527,7 +528,7 @@ struct MigrationState {
>  void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
>                         MigrationStatus new_state);
>
> -void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
> +MigChannelType migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
>  void migration_incoming_process(void);
>  bool migration_incoming_setup(QIOChannel *ioc, uint8_t channel, Error **errp);
>  void migration_outgoing_setup(QIOChannel *ioc);
> --

* Looks right.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


