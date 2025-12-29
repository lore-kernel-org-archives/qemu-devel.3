Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F62CE92FD7
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 21:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaKU3-0007sU-13; Mon, 29 Dec 2025 16:08:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaKTm-0007rR-GL
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 16:08:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaKTi-0007Jn-Bw
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 16:08:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767042510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hjxSvEhUEgwirgYPIkzu3ItMTRzCZGDgbDzqeZBBdqk=;
 b=RDR5UlbJZsI6XypHZyvGi+mRC8+8SMNdJVhd74hVajO8JrIbxYfKPROy1ZwRQ8vq1eTKbz
 VpKR8/Jarpd/Z30qUjo6NXZizhc8APDvdsXmhxCuTFjmCh7oqLNCRAek7+qBxzcBYcrIeQ
 YiPI9FiGfRE9XYL8lRkmbz2Udhh9Zjk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-6FaZLs3YOoqGDzImyGlMGg-1; Mon, 29 Dec 2025 16:08:29 -0500
X-MC-Unique: 6FaZLs3YOoqGDzImyGlMGg-1
X-Mimecast-MFC-AGG-ID: 6FaZLs3YOoqGDzImyGlMGg_1767042508
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8b245c49d0cso2273252185a.3
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 13:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767042508; x=1767647308; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hjxSvEhUEgwirgYPIkzu3ItMTRzCZGDgbDzqeZBBdqk=;
 b=mXER4qEPl7zttwz1CMvxg6Dwepq7PTG3tH3eNDhmR2cijf8LBnZlAFUhyiYt8dLKzM
 1QcD27+0GMLKAEMQ6xH5E90NscNrKLtFGzYOmM4ojpi9XS1aw4z4ei/0aIoC+OWnoVU2
 5UzeasnXhYhUzg4wnMqbm3lI8pBnHEJUq0HSjb20lJ6uN75LORE9JrauogTlIMBAlQez
 PZW4DBAsBcDuPqmFBY6/HLthduxLqs4MwYEIlGX1CL/bfgZQfJaLBm1YIoX47LbHaLPA
 pfac7aI9w8Khk7fkweVMVofeUyCXAe2MNYW6TIxjbNG+u5kJYsQFt24BAPyVPDamCpF4
 Aj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767042508; x=1767647308;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hjxSvEhUEgwirgYPIkzu3ItMTRzCZGDgbDzqeZBBdqk=;
 b=ubDoPSM5oDNshRpwVjowhUE4VVrMjG1cfe6qLgzIHl7iahUoIT/QvCAfeoiDaOwHAj
 NaJrGWVjhfnROO/paAMoNbElM2RK+JkF+/eO/sVWMHip75z0x2/hakqlkX84W+ohPcmU
 j/ZbfWchFwE3ulF0h2dZMvojX9ALEB7JjL/oXrsqSWi0hmgSAPH3EzQpiwwQA5Ap20xJ
 CdJUBXi6TZWcll19u/gNCCGg5ZPWZw2WbcLox2u1nYyZTlGFZxP9owvrMLKVXZwrFY7t
 LjEJXe/yeT4vrtIF7pSlIcmCOPgyXShe0lRCJLxGB9UNpAK/lpFQY1s17mSUCoSDqL+a
 g6Ag==
X-Gm-Message-State: AOJu0YwjJV3whVgW1fYNxYyagGbkUbY3fIMHQUF8UfJD5i7kHfl2lx9V
 +rpURClUJSkBFvMeieZvfoPUGSAtKgOWLJnE4HiTOXoNagEKGDFcQRJakRZIHTnVAniAmATkDaF
 LleJn8ZiMweumUfiIdQ33g3HSNxey5GykgjOZvawpJIO8AmFSzDuiTnCGl86cpkCI
X-Gm-Gg: AY/fxX4IkIXbKHyFhUTAvcaioOqfNgCzNHUAPtzyzWcsZYvseg7EKpHUx/BHOVNbyQg
 AktchAdU5cRT+KbfPslbayYXhUkgjmkRhjQVd5Y0OSATPLiX9fczFi1PBB+qpUkr2sIb7CbajEz
 MTtYzGtEV7ihz28PYIMy3zbX8kIkZhbGDf1kK9PnN9edQfeujbCLXxLpTxLgN9T+TRkC3qGLxq+
 1TPy/k+1wimihm9Tdt7VWY3wNBsTOE/DaJULt7PIpf15YrM1WtVJP5Ly0F+HKRPhhNpv+0RHjvb
 TnYnbubvBsSt4ABwVcLZA3FGZskecFR0SqnODmoTyau+k1q80iuJdLJEWzUJ5hQGOET/Yp30Mwo
 KSQQ=
X-Received: by 2002:a05:620a:4495:b0:8b2:e4f7:bfc9 with SMTP id
 af79cd13be357-8c08f68d65cmr4804802785a.39.1767042508062; 
 Mon, 29 Dec 2025 13:08:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFwedXBagVwcXhRGmbk2u8V99G0kjcdgs9q5DQ31/HhsR8Pj3OYrS5xudTqfxy5oa5k1dvnw==
X-Received: by 2002:a05:620a:4495:b0:8b2:e4f7:bfc9 with SMTP id
 af79cd13be357-8c08f68d65cmr4804799785a.39.1767042507606; 
 Mon, 29 Dec 2025 13:08:27 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c0968935b5sm2457058785a.19.2025.12.29.13.08.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 13:08:27 -0800 (PST)
Date: Mon, 29 Dec 2025 16:08:26 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 24/25] migration: Move URI parsing to channel.c
Message-ID: <aVLtyglUqAkT4VEI@x1.local>
References: <20251226211930.27565-1-farosas@suse.de>
 <20251226211930.27565-25-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251226211930.27565-25-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Dec 26, 2025 at 06:19:26PM -0300, Fabiano Rosas wrote:
> The migrate_uri_parse function is responsible for converting the URI
> string into a MigrationChannel for consumption by the rest of the
> code. Move it to channel.c and add a wrapper that calls both URI and
> channels parsing.
> 
> While here, add some words about the memory management of the
> MigrationChannel object, which is slightly different from
> migrate_uri_parse() and migrate_channels_parse(). The former takes a
> string and has to allocate a MigrationChannel, the latter takes a QAPI
> object that is managed by the QAPI code.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

There're some comments added into migration_connect(), that I still don't
think I fully agree upon.. but the rest looks all good to me.

That's probably to be discussed separately anyway, I think you can take
mine here:

Reviewed-by: Peter Xu <peterx@redhat.com>

> ---
>  migration/channel.c   | 97 +++++++++++++++++++++++++++++++++++++++++--
>  migration/channel.h   |  9 ++--
>  migration/migration.c | 95 ++----------------------------------------
>  3 files changed, 101 insertions(+), 100 deletions(-)
> 
> diff --git a/migration/channel.c b/migration/channel.c
> index 8b43c3d983..d30e29c9b3 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -40,6 +40,12 @@ bool migration_connect(MigrationAddress *addr, bool out, Error **errp)
>      SocketAddress *saddr;
>      ERRP_GUARD();
>  
> +    /*
> +     * This is reached from a QMP command, the transport code below
> +     * must copy the relevant parts of 'addr' before this function
> +     * returns because the QAPI code will free it.
> +     */
> +
>      switch (addr->transport) {
>      case MIGRATION_ADDRESS_TYPE_SOCKET:
>          saddr = &addr->u.socket;
> @@ -318,10 +324,10 @@ int migration_channel_read_peek(QIOChannel *ioc,
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
>      bool single_channel;
> @@ -353,6 +359,15 @@ bool migrate_channels_parse(MigrationChannelList *channels,
>          }
>      }
>  
> +    /*
> +     * These don't technically need to be cloned because they come
> +     * from a QAPI object ('channels'). The top-level caller
> +     * (qmp_migrate) needs to copy the necessary information before
> +     * returning from the QMP command. Cloning here is just to keep
> +     * the interface consistent with migrate_uri_parse() that _does
> +     * not_ take a QAPI object and instead allocates and transfers
> +     * ownership of a MigrationChannel to qmp_migrate.
> +     */
>      if (cpr_channelp) {
>          *cpr_channelp = QAPI_CLONE(MigrationChannel,
>                                     channelv[MIGRATION_CHANNEL_TYPE_CPR]);
> @@ -368,3 +383,77 @@ bool migrate_channels_parse(MigrationChannelList *channels,
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
> index b3276550b7..3724b0493a 100644
> --- a/migration/channel.h
> +++ b/migration/channel.h
> @@ -52,8 +52,9 @@ static inline bool migration_connect_incoming(MigrationAddress *addr,
>      return migration_connect(addr, false, errp);
>  }
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
> index 6064f1e5ea..15d8459a81 100644
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
> @@ -2124,27 +2051,11 @@ void qmp_migrate(const char *uri, bool has_channels,
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
> 2.51.0
> 

-- 
Peter Xu


