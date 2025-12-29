Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67583E92FE1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 21:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaKgv-00047A-BD; Mon, 29 Dec 2025 16:22:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vaKgu-000461-1g
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 16:22:12 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vaKgr-0000fP-Pd
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 16:22:11 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5CFE95BCD3;
 Mon, 29 Dec 2025 21:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767043328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iQFBJXUUhTlANDTeSnhA2qJdD/ZEjGxEpPv48HVj3MU=;
 b=wuhQBwYFVPUIxIQxr0TP5mhQAd8KP+qx4Q/TJHbrtbe4WMbjQl2hzwRZN6PE2sPnbAgl+f
 ZTFal9aBG84fpoGURidqyVbAjFmWbZTC9IsCHO4P+F0pZW0UU+sZ8o6/ljvPe6Ath+p+tc
 A6laJHCNsqLfgP7bWq9RWeXDmetgStg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767043328;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iQFBJXUUhTlANDTeSnhA2qJdD/ZEjGxEpPv48HVj3MU=;
 b=ZYGVQq0cXu9S1kWnP8JZM59ZW6pUSKXNucu4JIoG3RMVtX2sv+WnS5s1zDqo9Zvae1qcdb
 CUtoiyETHCSjS5Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767043328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iQFBJXUUhTlANDTeSnhA2qJdD/ZEjGxEpPv48HVj3MU=;
 b=wuhQBwYFVPUIxIQxr0TP5mhQAd8KP+qx4Q/TJHbrtbe4WMbjQl2hzwRZN6PE2sPnbAgl+f
 ZTFal9aBG84fpoGURidqyVbAjFmWbZTC9IsCHO4P+F0pZW0UU+sZ8o6/ljvPe6Ath+p+tc
 A6laJHCNsqLfgP7bWq9RWeXDmetgStg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767043328;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iQFBJXUUhTlANDTeSnhA2qJdD/ZEjGxEpPv48HVj3MU=;
 b=ZYGVQq0cXu9S1kWnP8JZM59ZW6pUSKXNucu4JIoG3RMVtX2sv+WnS5s1zDqo9Zvae1qcdb
 CUtoiyETHCSjS5Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF719137C3;
 Mon, 29 Dec 2025 21:22:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IUzZH//wUmnCZQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 29 Dec 2025 21:22:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 24/25] migration: Move URI parsing to channel.c
In-Reply-To: <aVLtyglUqAkT4VEI@x1.local>
References: <20251226211930.27565-1-farosas@suse.de>
 <20251226211930.27565-25-farosas@suse.de> <aVLtyglUqAkT4VEI@x1.local>
Date: Mon, 29 Dec 2025 18:22:04 -0300
Message-ID: <87344t7zlv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.992]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[];
 URIBL_BLOCKED(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Peter Xu <peterx@redhat.com> writes:

> On Fri, Dec 26, 2025 at 06:19:26PM -0300, Fabiano Rosas wrote:
>> The migrate_uri_parse function is responsible for converting the URI
>> string into a MigrationChannel for consumption by the rest of the
>> code. Move it to channel.c and add a wrapper that calls both URI and
>> channels parsing.
>> 
>> While here, add some words about the memory management of the
>> MigrationChannel object, which is slightly different from
>> migrate_uri_parse() and migrate_channels_parse(). The former takes a
>> string and has to allocate a MigrationChannel, the latter takes a QAPI
>> object that is managed by the QAPI code.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> There're some comments added into migration_connect(), that I still don't
> think I fully agree upon.. but the rest looks all good to me.
>

You're talking about the comments not being at the right place? I can
duplicate them in migration_connect_outgoing|incoming.

> That's probably to be discussed separately anyway, I think you can take
> mine here:
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
>> ---
>>  migration/channel.c   | 97 +++++++++++++++++++++++++++++++++++++++++--
>>  migration/channel.h   |  9 ++--
>>  migration/migration.c | 95 ++----------------------------------------
>>  3 files changed, 101 insertions(+), 100 deletions(-)
>> 
>> diff --git a/migration/channel.c b/migration/channel.c
>> index 8b43c3d983..d30e29c9b3 100644
>> --- a/migration/channel.c
>> +++ b/migration/channel.c
>> @@ -40,6 +40,12 @@ bool migration_connect(MigrationAddress *addr, bool out, Error **errp)
>>      SocketAddress *saddr;
>>      ERRP_GUARD();
>>  
>> +    /*
>> +     * This is reached from a QMP command, the transport code below
>> +     * must copy the relevant parts of 'addr' before this function
>> +     * returns because the QAPI code will free it.
>> +     */
>> +
>>      switch (addr->transport) {
>>      case MIGRATION_ADDRESS_TYPE_SOCKET:
>>          saddr = &addr->u.socket;
>> @@ -318,10 +324,10 @@ int migration_channel_read_peek(QIOChannel *ioc,
>>      return 0;
>>  }
>>  
>> -bool migrate_channels_parse(MigrationChannelList *channels,
>> -                            MigrationChannel **main_channelp,
>> -                            MigrationChannel **cpr_channelp,
>> -                            Error **errp)
>> +static bool migrate_channels_parse(MigrationChannelList *channels,
>> +                                   MigrationChannel **main_channelp,
>> +                                   MigrationChannel **cpr_channelp,
>> +                                   Error **errp)
>>  {
>>      MigrationChannel *channelv[MIGRATION_CHANNEL_TYPE__MAX] = { NULL };
>>      bool single_channel;
>> @@ -353,6 +359,15 @@ bool migrate_channels_parse(MigrationChannelList *channels,
>>          }
>>      }
>>  
>> +    /*
>> +     * These don't technically need to be cloned because they come
>> +     * from a QAPI object ('channels'). The top-level caller
>> +     * (qmp_migrate) needs to copy the necessary information before
>> +     * returning from the QMP command. Cloning here is just to keep
>> +     * the interface consistent with migrate_uri_parse() that _does
>> +     * not_ take a QAPI object and instead allocates and transfers
>> +     * ownership of a MigrationChannel to qmp_migrate.
>> +     */
>>      if (cpr_channelp) {
>>          *cpr_channelp = QAPI_CLONE(MigrationChannel,
>>                                     channelv[MIGRATION_CHANNEL_TYPE_CPR]);
>> @@ -368,3 +383,77 @@ bool migrate_channels_parse(MigrationChannelList *channels,
>>  
>>      return true;
>>  }
>> +
>> +bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
>> +                       Error **errp)
>> +{
>> +    g_autoptr(MigrationChannel) val = g_new0(MigrationChannel, 1);
>> +    g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
>> +    InetSocketAddress *isock = &addr->u.rdma;
>> +    strList **tail = &addr->u.exec.args;
>> +
>> +    if (strstart(uri, "exec:", NULL)) {
>> +        addr->transport = MIGRATION_ADDRESS_TYPE_EXEC;
>> +#ifdef WIN32
>> +        QAPI_LIST_APPEND(tail, g_strdup(exec_get_cmd_path()));
>> +        QAPI_LIST_APPEND(tail, g_strdup("/c"));
>> +#else
>> +        QAPI_LIST_APPEND(tail, g_strdup("/bin/sh"));
>> +        QAPI_LIST_APPEND(tail, g_strdup("-c"));
>> +#endif
>> +        QAPI_LIST_APPEND(tail, g_strdup(uri + strlen("exec:")));
>> +    } else if (strstart(uri, "rdma:", NULL)) {
>> +        if (inet_parse(isock, uri + strlen("rdma:"), errp)) {
>> +            qapi_free_InetSocketAddress(isock);
>> +            return false;
>> +        }
>> +        addr->transport = MIGRATION_ADDRESS_TYPE_RDMA;
>> +    } else if (strstart(uri, "tcp:", NULL) ||
>> +                strstart(uri, "unix:", NULL) ||
>> +                strstart(uri, "vsock:", NULL) ||
>> +                strstart(uri, "fd:", NULL)) {
>> +        addr->transport = MIGRATION_ADDRESS_TYPE_SOCKET;
>> +        SocketAddress *saddr = socket_parse(uri, errp);
>> +        if (!saddr) {
>> +            return false;
>> +        }
>> +        addr->u.socket.type = saddr->type;
>> +        addr->u.socket.u = saddr->u;
>> +        /* Don't free the objects inside; their ownership moved to "addr" */
>> +        g_free(saddr);
>> +    } else if (strstart(uri, "file:", NULL)) {
>> +        addr->transport = MIGRATION_ADDRESS_TYPE_FILE;
>> +        addr->u.file.filename = g_strdup(uri + strlen("file:"));
>> +        if (file_parse_offset(addr->u.file.filename, &addr->u.file.offset,
>> +                              errp)) {
>> +            return false;
>> +        }
>> +    } else {
>> +        error_setg(errp, "unknown migration protocol: %s", uri);
>> +        return false;
>> +    }
>> +
>> +    val->channel_type = MIGRATION_CHANNEL_TYPE_MAIN;
>> +    val->addr = g_steal_pointer(&addr);
>> +    *channel = g_steal_pointer(&val);
>> +    return true;
>> +}
>> +
>> +bool migration_channel_parse_input(const char *uri,
>> +                                   MigrationChannelList *channels,
>> +                                   MigrationChannel **main_channelp,
>> +                                   MigrationChannel **cpr_channelp,
>> +                                   Error **errp)
>> +{
>> +    if (!uri == !channels) {
>> +        error_setg(errp, "need either 'uri' or 'channels' argument");
>> +        return false;
>> +    }
>> +
>> +    if (channels) {
>> +        return migrate_channels_parse(channels, main_channelp, cpr_channelp,
>> +                                      errp);
>> +    } else {
>> +        return migrate_uri_parse(uri, main_channelp, errp);
>> +    }
>> +}
>> diff --git a/migration/channel.h b/migration/channel.h
>> index b3276550b7..3724b0493a 100644
>> --- a/migration/channel.h
>> +++ b/migration/channel.h
>> @@ -52,8 +52,9 @@ static inline bool migration_connect_incoming(MigrationAddress *addr,
>>      return migration_connect(addr, false, errp);
>>  }
>>  
>> -bool migrate_channels_parse(MigrationChannelList *channels,
>> -                            MigrationChannel **main_channelp,
>> -                            MigrationChannel **cpr_channelp,
>> -                            Error **errp);
>> +bool migration_channel_parse_input(const char *uri,
>> +                                   MigrationChannelList *channels,
>> +                                   MigrationChannel **main_channelp,
>> +                                   MigrationChannel **cpr_channelp,
>> +                                   Error **errp);
>>  #endif
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 6064f1e5ea..15d8459a81 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -15,7 +15,6 @@
>>  
>>  #include "qemu/osdep.h"
>>  #include "qemu/ctype.h"
>> -#include "qemu/cutils.h"
>>  #include "qemu/error-report.h"
>>  #include "qemu/main-loop.h"
>>  #include "migration/blocker.h"
>> @@ -659,61 +658,6 @@ bool migrate_is_uri(const char *uri)
>>      return *uri == ':';
>>  }
>>  
>> -bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
>> -                       Error **errp)
>> -{
>> -    g_autoptr(MigrationChannel) val = g_new0(MigrationChannel, 1);
>> -    g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
>> -    InetSocketAddress *isock = &addr->u.rdma;
>> -    strList **tail = &addr->u.exec.args;
>> -
>> -    if (strstart(uri, "exec:", NULL)) {
>> -        addr->transport = MIGRATION_ADDRESS_TYPE_EXEC;
>> -#ifdef WIN32
>> -        QAPI_LIST_APPEND(tail, g_strdup(exec_get_cmd_path()));
>> -        QAPI_LIST_APPEND(tail, g_strdup("/c"));
>> -#else
>> -        QAPI_LIST_APPEND(tail, g_strdup("/bin/sh"));
>> -        QAPI_LIST_APPEND(tail, g_strdup("-c"));
>> -#endif
>> -        QAPI_LIST_APPEND(tail, g_strdup(uri + strlen("exec:")));
>> -    } else if (strstart(uri, "rdma:", NULL)) {
>> -        if (inet_parse(isock, uri + strlen("rdma:"), errp)) {
>> -            qapi_free_InetSocketAddress(isock);
>> -            return false;
>> -        }
>> -        addr->transport = MIGRATION_ADDRESS_TYPE_RDMA;
>> -    } else if (strstart(uri, "tcp:", NULL) ||
>> -                strstart(uri, "unix:", NULL) ||
>> -                strstart(uri, "vsock:", NULL) ||
>> -                strstart(uri, "fd:", NULL)) {
>> -        addr->transport = MIGRATION_ADDRESS_TYPE_SOCKET;
>> -        SocketAddress *saddr = socket_parse(uri, errp);
>> -        if (!saddr) {
>> -            return false;
>> -        }
>> -        addr->u.socket.type = saddr->type;
>> -        addr->u.socket.u = saddr->u;
>> -        /* Don't free the objects inside; their ownership moved to "addr" */
>> -        g_free(saddr);
>> -    } else if (strstart(uri, "file:", NULL)) {
>> -        addr->transport = MIGRATION_ADDRESS_TYPE_FILE;
>> -        addr->u.file.filename = g_strdup(uri + strlen("file:"));
>> -        if (file_parse_offset(addr->u.file.filename, &addr->u.file.offset,
>> -                              errp)) {
>> -            return false;
>> -        }
>> -    } else {
>> -        error_setg(errp, "unknown migration protocol: %s", uri);
>> -        return false;
>> -    }
>> -
>> -    val->channel_type = MIGRATION_CHANNEL_TYPE_MAIN;
>> -    val->addr = g_steal_pointer(&addr);
>> -    *channel = g_steal_pointer(&val);
>> -    return true;
>> -}
>> -
>>  static bool
>>  migration_incoming_state_setup(MigrationIncomingState *mis, Error **errp)
>>  {
>> @@ -744,27 +688,10 @@ static void qemu_setup_incoming_migration(const char *uri, bool has_channels,
>>      g_autoptr(MigrationChannel) main_ch = NULL;
>>      MigrationIncomingState *mis = migration_incoming_get_current();
>>  
>> -    /*
>> -     * Having preliminary checks for uri and channel
>> -     */
>> -    if (!uri == !channels) {
>> -        error_setg(errp, "need either 'uri' or 'channels' argument");
>> +    if (!migration_channel_parse_input(uri, channels, &main_ch, NULL, errp)) {
>>          return;
>>      }
>>  
>> -    if (channels) {
>> -        if (!migrate_channels_parse(channels, &main_ch, NULL, errp)) {
>> -            return;
>> -        }
>> -    }
>> -
>> -    if (uri) {
>> -        /* caller uses the old URI syntax */
>> -        if (!migrate_uri_parse(uri, &main_ch, errp)) {
>> -            return;
>> -        }
>> -    }
>> -
>>      /* transport mechanism not suitable for migration? */
>>      if (!migration_transport_compatible(main_ch->addr, errp)) {
>>          return;
>> @@ -2124,27 +2051,11 @@ void qmp_migrate(const char *uri, bool has_channels,
>>      g_autoptr(MigrationChannel) main_ch = NULL;
>>      g_autoptr(MigrationChannel) cpr_ch = NULL;
>>  
>> -    /*
>> -     * Having preliminary checks for uri and channel
>> -     */
>> -    if (!uri == !channels) {
>> -        error_setg(errp, "need either 'uri' or 'channels' argument");
>> +    if (!migration_channel_parse_input(uri, channels, &main_ch, &cpr_ch,
>> +                                       errp)) {
>>          return;
>>      }
>>  
>> -    if (channels) {
>> -        if (!migrate_channels_parse(channels, &main_ch, &cpr_ch, errp)) {
>> -            return;
>> -        }
>> -    }
>> -
>> -    if (uri) {
>> -        /* caller uses the old URI syntax */
>> -        if (!migrate_uri_parse(uri, &main_ch, errp)) {
>> -            return;
>> -        }
>> -    }
>> -
>>      /* transport mechanism not suitable for migration? */
>>      if (!migration_transport_compatible(main_ch->addr, errp)) {
>>          return;
>> -- 
>> 2.51.0
>> 

