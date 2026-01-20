Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE49D2ED0F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 10:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi8rU-0002iK-VS; Tue, 20 Jan 2026 05:21:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vi8rT-0002aq-3z
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 05:21:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vi8rR-0005Yd-86
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 05:21:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768904480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SYAYzJ8iFmskH8kTFbNnjoeTWsKUq3IoO8nr6nV73uo=;
 b=LqMevTPcEGqnhpu8h/vRCa7u+Pif5dGzor2ud1+g9uP4povfFtWK76+t313OQ0f8ZU9/Qr
 t9BbV9bW3D6ueVOsdVmH3wmrUmRIhcQV5zqzRPWUhAw90E6UQ6q06AAGMyMmomefa8cTnF
 W6eclKYLrIcFbCSHvyhazY/DsQIKy+Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-cy1q7q3TP7qZW-fgoKYfWA-1; Tue, 20 Jan 2026 05:21:18 -0500
X-MC-Unique: cy1q7q3TP7qZW-fgoKYfWA-1
X-Mimecast-MFC-AGG-ID: cy1q7q3TP7qZW-fgoKYfWA_1768904477
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43284f60a8aso4444278f8f.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 02:21:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768904476; cv=none;
 d=google.com; s=arc-20240605;
 b=Qz2j3kvCGBdNG6dvAimEmsq1A/WFRShxqgS7PuG4LHEnNeRVw5e+oaaRuzdyJ6sLDv
 EOIie0bJz6cAmZFrtKIXVslv+fec5OBW5/GOjv16V+FGKUXzUgaX1Xm9Du0PYJuLgiou
 lRE07dqVP0bCBKQciDQlI4iZtRihiu7APjqrVS3HfHFf5URL64aJOI4GHZTDz5vppAaT
 V0v0dzVPblufJykceXqul13gkK3VGIkMf7NXEL6mj7ZI6U6y0vJvW05YXsTCL03jwpWy
 +CfhZMY00DGxFqYClvU+hlU+6tzxYVnTIC6eSM74oDIONyMLkurLxJWHkmnwdI8VB6ic
 vz2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SYAYzJ8iFmskH8kTFbNnjoeTWsKUq3IoO8nr6nV73uo=;
 fh=SJ3HPovJyRUvRbjEYgfW8f8/HsJC2a+l/HOVRBs3/Wg=;
 b=byLCWfqLWHuxI+cc7kaVghHMG1S5Wle8Q9FLLpYACnPxtndASc9pv19yxx3QYCkzSc
 1nYlyULh7KzPOQ3BeE7aymd8bqt3YgkgeSyh5NjnmvGqubU4yJOyja5UTjAetKPW1CV8
 SiwpVsvh9JL6PomPftXyJcJG3Fs3g/BYPFNw+UEDT1QfwfFiaH4wopb8QSpJmsFTOKG3
 IDHvXyOjp+WCdo77p/c4CPJBtsZvHCs/eanyoU7pnseyxylMQphLbLBe4Z5aGmFXOYLv
 /0Rs/qXWId3CkrB6VMq17JOoH101vQ7iFFz1bw4Kl6ZChrLLt+xobmYNRecji0xoBeqa
 lH0A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768904476; x=1769509276; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SYAYzJ8iFmskH8kTFbNnjoeTWsKUq3IoO8nr6nV73uo=;
 b=kzm8+TDROqjp2kDBxKBzHGGUiW388UAJy7l40fUMkwUa6cMx1srnVioZfNxO/27B1o
 NJXZHCcjfp97siNuccvOdl0fTlEv+TOCWUOv4BAobTo+0NL+m1O1w1sgd6Ut5u7F9s6C
 pMDihHEQQ7TEKFdIQRZK1oIZLVjt0Ilc7Xk04jG4o68P2+2IxMGk67aZGu+aLTm4/8sP
 r3IXmmWQONFHJL0bLvPraKUDO3aGMR9v2q1w3ZoIX1JN1lFB8rxbLfZcuYzDFvYiF2iB
 BMWKOCsBQ7IEMGukQAe8Yj9tdtfD07BlTtZGSXzxQLI2knlMkv3AFXy+94iBwowczsgj
 EWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768904476; x=1769509276;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SYAYzJ8iFmskH8kTFbNnjoeTWsKUq3IoO8nr6nV73uo=;
 b=FMQCDJC14ZTW7QaiWS2m61bMTsfYoMTSPRUoOsN3tBFf9QNu4/zpkAIzZXoySI6ZaJ
 4JCiE3SkGKCpiPfbDswwSIE+GEWzs5ePV6qypxe2saf5CerVZafml/21ffob1xjEEbn+
 /BhRdM8FIcGYVc2TwDCXX36SaFk8ZWWyq9ytOmHMU8sPlAshlIdS1jDqM/pn7nsw1dNJ
 2tH3CPO49gPKUix/pi/v+nickzsffeoPpPxufNaS2fbz3HM4WWlo2LG5YIG/2BIM0T7U
 2OS1MuDwMU26pvwdB0Izi9eZiOLK28KV+wlRuMLHUoK0uQkvZHwl7kFHAjF3L/lhXCWn
 KBMA==
X-Gm-Message-State: AOJu0Yy0QZEcbsJ24J/aQpr5FbbwcoB011jCPZUVTXgeerAWNGOpG/Y7
 Yxw327f0qL1FlV37ZsI7mR0m9FW55F9aOSwNLKFpcEUB1BZ3PNTuBxjpBwpbXxqndV+QhKf0RrD
 /B5Iey/xm488BzftVNLabxVgGbeE2jtRCKIWy9P/divfyUc5mr547RhG20cDWLLNTpYE2YHvs+2
 oKf95rfk3JzBE+JD3Bsz4B9qFm8TynFNMvszEMFzBQUQ==
X-Gm-Gg: AY/fxX45xCkOh/sMiJ0oy1s4FKSVmmjyJfznap+uakqZg68OzOHfZRQsMb9RUioHPa3
 HtK1GCmNo+lD+AD29RYkiLpQmKWYwJjNc/QLAnkDYISycceMTENkVArDASd8Nh45p7bXSxpeIP+
 fBTgmKJgo5TOhFy6433u8tilngtq8XnIzdKbSs5OId0G56WOhsILnAjvrBxasgNfJIQK8riI+Bp
 oAK458F072dGJGQxtAW1DSUCmgml2GKCU6VYVRm2eIfg/6OfXfIsg08
X-Received: by 2002:a05:600c:1f12:b0:471:14af:c715 with SMTP id
 5b1f17b1804b1-4801e2fc37bmr156945395e9.3.1768904475900; 
 Tue, 20 Jan 2026 02:21:15 -0800 (PST)
X-Received: by 2002:a05:600c:1f12:b0:471:14af:c715 with SMTP id
 5b1f17b1804b1-4801e2fc37bmr156944865e9.3.1768904475227; Tue, 20 Jan 2026
 02:21:15 -0800 (PST)
MIME-Version: 1.0
References: <20260109124043.25019-1-farosas@suse.de>
 <20260109124043.25019-22-farosas@suse.de>
In-Reply-To: <20260109124043.25019-22-farosas@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 20 Jan 2026 15:50:58 +0530
X-Gm-Features: AZwV_Qi-b7PN6rxkrWOU01eSsuu16PuKYJ2knkbKmQG5cHhtl_0XNTyEMt7EtH0
Message-ID: <CAE8KmOzt7c4V2Qd2skjBvVCyeAnsKL9T5BBuk5givA2b8C3N=Q@mail.gmail.com>
Subject: Re: [PATCH v3 21/25] migration: Move URI parsing to channel.c
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

On Fri, 9 Jan 2026 at 18:16, Fabiano Rosas <farosas@suse.de> wrote:
> The migrate_uri_parse function is responsible for converting the URI
> string into a MigrationChannel for consumption by the rest of the
> code. Move it to channel.c and add a wrapper that calls both URI and
> channels parsing.
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/channel.c   | 82 +++++++++++++++++++++++++++++++++++--
>  migration/channel.h   |  9 ++--
>  migration/migration.c | 95 ++-----------------------------------------
>  3 files changed, 86 insertions(+), 100 deletions(-)
>
> diff --git a/migration/channel.c b/migration/channel.c
> index 8b71b3f430..cee78532ea 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -284,10 +284,10 @@ int migration_channel_read_peek(QIOChannel *ioc,
>      return 0;
>  }
>
> -bool migrate_channels_parse(MigrationChannelList *channels,
> -                            MigrationChannel **main_channelp,
> -                            MigrationChannel **cpr_channelp,
> -                            Error **errp)
> +static bool migrate_channels_parse(MigrationChannelList *channels,
> +                                   MigrationChannel **main_channelp,
> +                                   MigrationChannel **cpr_channelp,
> +                                   Error **errp)
>  {
>      MigrationChannel *channelv[MIGRATION_CHANNEL_TYPE__MAX] = { NULL };
>      bool single_channel = cpr_channelp ? false : true;
> @@ -325,3 +325,77 @@ bool migrate_channels_parse(MigrationChannelList *channels,
>
>      return true;
>  }
> +
> +bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
> +                       Error **errp)
> +{
> +    g_autoptr(MigrationChannel) val = g_new0(MigrationChannel, 1);
> +    g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
> +    InetSocketAddress *isock = &addr->u.rdma;
> +    strList **tail = &addr->u.exec.args;
> +
> +    if (strstart(uri, "exec:", NULL)) {
> +        addr->transport = MIGRATION_ADDRESS_TYPE_EXEC;
> +#ifdef WIN32
> +        QAPI_LIST_APPEND(tail, g_strdup(exec_get_cmd_path()));
> +        QAPI_LIST_APPEND(tail, g_strdup("/c"));
> +#else
> +        QAPI_LIST_APPEND(tail, g_strdup("/bin/sh"));
> +        QAPI_LIST_APPEND(tail, g_strdup("-c"));
> +#endif
> +        QAPI_LIST_APPEND(tail, g_strdup(uri + strlen("exec:")));
> +    } else if (strstart(uri, "rdma:", NULL)) {
> +        if (inet_parse(isock, uri + strlen("rdma:"), errp)) {
> +            qapi_free_InetSocketAddress(isock);
> +            return false;
> +        }
> +        addr->transport = MIGRATION_ADDRESS_TYPE_RDMA;
> +    } else if (strstart(uri, "tcp:", NULL) ||
> +                strstart(uri, "unix:", NULL) ||
> +                strstart(uri, "vsock:", NULL) ||
> +                strstart(uri, "fd:", NULL)) {
> +        addr->transport = MIGRATION_ADDRESS_TYPE_SOCKET;
> +        SocketAddress *saddr = socket_parse(uri, errp);
> +        if (!saddr) {
> +            return false;
> +        }
> +        addr->u.socket.type = saddr->type;
> +        addr->u.socket.u = saddr->u;
> +        /* Don't free the objects inside; their ownership moved to "addr" */
> +        g_free(saddr);
> +    } else if (strstart(uri, "file:", NULL)) {
> +        addr->transport = MIGRATION_ADDRESS_TYPE_FILE;
> +        addr->u.file.filename = g_strdup(uri + strlen("file:"));
> +        if (file_parse_offset(addr->u.file.filename, &addr->u.file.offset,
> +                              errp)) {
> +            return false;
> +        }
> +    } else {
> +        error_setg(errp, "unknown migration protocol: %s", uri);
> +        return false;
> +    }
> +
> +    val->channel_type = MIGRATION_CHANNEL_TYPE_MAIN;
> +    val->addr = g_steal_pointer(&addr);
> +    *channel = g_steal_pointer(&val);
> +    return true;
> +}
> +
> +bool migration_channel_parse_input(const char *uri,
> +                                   MigrationChannelList *channels,
> +                                   MigrationChannel **main_channelp,
> +                                   MigrationChannel **cpr_channelp,
> +                                   Error **errp)
> +{
> +    if (!uri == !channels) {
> +        error_setg(errp, "need either 'uri' or 'channels' argument");
> +        return false;
> +    }
> +
> +    if (channels) {
> +        return migrate_channels_parse(channels, main_channelp, cpr_channelp,
> +                                      errp);
> +    } else {
> +        return migrate_uri_parse(uri, main_channelp, errp);
> +    }
> +}
> diff --git a/migration/channel.h b/migration/channel.h
> index 5110fb45a4..a7d0d29058 100644
> --- a/migration/channel.h
> +++ b/migration/channel.h
> @@ -43,8 +43,9 @@ void migration_connect_outgoing(MigrationState *s, MigrationAddress *addr,
>                                  Error **errp);
>  void migration_connect_incoming(MigrationAddress *addr, Error **errp);
>
> -bool migrate_channels_parse(MigrationChannelList *channels,
> -                            MigrationChannel **main_channelp,
> -                            MigrationChannel **cpr_channelp,
> -                            Error **errp);
> +bool migration_channel_parse_input(const char *uri,
> +                                   MigrationChannelList *channels,
> +                                   MigrationChannel **main_channelp,
> +                                   MigrationChannel **cpr_channelp,
> +                                   Error **errp);
>  #endif
> diff --git a/migration/migration.c b/migration/migration.c
> index 98c1f38e8e..52c1bb5da2 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -15,7 +15,6 @@
>
>  #include "qemu/osdep.h"
>  #include "qemu/ctype.h"
> -#include "qemu/cutils.h"
>  #include "qemu/error-report.h"
>  #include "qemu/main-loop.h"
>  #include "migration/blocker.h"
> @@ -659,61 +658,6 @@ bool migrate_is_uri(const char *uri)
>      return *uri == ':';
>  }
>
> -bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
> -                       Error **errp)
> -{
> -    g_autoptr(MigrationChannel) val = g_new0(MigrationChannel, 1);
> -    g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
> -    InetSocketAddress *isock = &addr->u.rdma;
> -    strList **tail = &addr->u.exec.args;
> -
> -    if (strstart(uri, "exec:", NULL)) {
> -        addr->transport = MIGRATION_ADDRESS_TYPE_EXEC;
> -#ifdef WIN32
> -        QAPI_LIST_APPEND(tail, g_strdup(exec_get_cmd_path()));
> -        QAPI_LIST_APPEND(tail, g_strdup("/c"));
> -#else
> -        QAPI_LIST_APPEND(tail, g_strdup("/bin/sh"));
> -        QAPI_LIST_APPEND(tail, g_strdup("-c"));
> -#endif
> -        QAPI_LIST_APPEND(tail, g_strdup(uri + strlen("exec:")));
> -    } else if (strstart(uri, "rdma:", NULL)) {
> -        if (inet_parse(isock, uri + strlen("rdma:"), errp)) {
> -            qapi_free_InetSocketAddress(isock);
> -            return false;
> -        }
> -        addr->transport = MIGRATION_ADDRESS_TYPE_RDMA;
> -    } else if (strstart(uri, "tcp:", NULL) ||
> -                strstart(uri, "unix:", NULL) ||
> -                strstart(uri, "vsock:", NULL) ||
> -                strstart(uri, "fd:", NULL)) {
> -        addr->transport = MIGRATION_ADDRESS_TYPE_SOCKET;
> -        SocketAddress *saddr = socket_parse(uri, errp);
> -        if (!saddr) {
> -            return false;
> -        }
> -        addr->u.socket.type = saddr->type;
> -        addr->u.socket.u = saddr->u;
> -        /* Don't free the objects inside; their ownership moved to "addr" */
> -        g_free(saddr);
> -    } else if (strstart(uri, "file:", NULL)) {
> -        addr->transport = MIGRATION_ADDRESS_TYPE_FILE;
> -        addr->u.file.filename = g_strdup(uri + strlen("file:"));
> -        if (file_parse_offset(addr->u.file.filename, &addr->u.file.offset,
> -                              errp)) {
> -            return false;
> -        }
> -    } else {
> -        error_setg(errp, "unknown migration protocol: %s", uri);
> -        return false;
> -    }
> -
> -    val->channel_type = MIGRATION_CHANNEL_TYPE_MAIN;
> -    val->addr = g_steal_pointer(&addr);
> -    *channel = g_steal_pointer(&val);
> -    return true;
> -}
> -
>  static bool
>  migration_incoming_state_setup(MigrationIncomingState *mis, Error **errp)
>  {
> @@ -744,27 +688,10 @@ static void qemu_setup_incoming_migration(const char *uri, bool has_channels,
>      g_autoptr(MigrationChannel) main_ch = NULL;
>      MigrationIncomingState *mis = migration_incoming_get_current();
>
> -    /*
> -     * Having preliminary checks for uri and channel
> -     */
> -    if (!uri == !channels) {
> -        error_setg(errp, "need either 'uri' or 'channels' argument");
> +    if (!migration_channel_parse_input(uri, channels, &main_ch, NULL, errp)) {
>          return;
>      }
>
> -    if (channels) {
> -        if (!migrate_channels_parse(channels, &main_ch, NULL, errp)) {
> -            return;
> -        }
> -    }
> -
> -    if (uri) {
> -        /* caller uses the old URI syntax */
> -        if (!migrate_uri_parse(uri, &main_ch, errp)) {
> -            return;
> -        }
> -    }
> -
>      /* transport mechanism not suitable for migration? */
>      if (!migration_transport_compatible(main_ch->addr, errp)) {
>          return;
> @@ -2113,27 +2040,11 @@ void qmp_migrate(const char *uri, bool has_channels,
>      g_autoptr(MigrationChannel) main_ch = NULL;
>      g_autoptr(MigrationChannel) cpr_ch = NULL;
>
> -    /*
> -     * Having preliminary checks for uri and channel
> -     */
> -    if (!uri == !channels) {
> -        error_setg(errp, "need either 'uri' or 'channels' argument");
> +    if (!migration_channel_parse_input(uri, channels, &main_ch, &cpr_ch,
> +                                       errp)) {
>          return;
>      }
>
> -    if (channels) {
> -        if (!migrate_channels_parse(channels, &main_ch, &cpr_ch, errp)) {
> -            return;
> -        }
> -    }
> -
> -    if (uri) {
> -        /* caller uses the old URI syntax */
> -        if (!migrate_uri_parse(uri, &main_ch, errp)) {
> -            return;
> -        }
> -    }
> -
>      /* transport mechanism not suitable for migration? */
>      if (!migration_transport_compatible(main_ch->addr, errp)) {
>          return;
> --

* Looks okay.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


