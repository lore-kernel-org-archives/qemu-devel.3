Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE5FC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkbH-0006BL-3Y; Mon, 11 Mar 2024 14:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rjkbE-00069w-Jc
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 14:42:12 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rjkbC-0003EQ-Kv
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 14:42:12 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5081334F7A;
 Mon, 11 Mar 2024 18:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710182529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m7Kv1d0cR5zS0FDMRFHyNmP9D3xpZ26aG3MR11hkVmI=;
 b=W1WmdE8vfmD+pKleR9kN7Jjtbi1n7199o7GQwrb3Rj/4ziYHMnzwzd0E9ADz3E5k3Xius3
 hJGM7YTI0Zo17aIns4IYn8dOPk12cfAJwo4hOUggbYNWUWfwKVJ0ijRa20QzjRKvPgL0C3
 bJOMMdvmMJlZ2L6rmjoDZOnCxM6vscw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710182529;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m7Kv1d0cR5zS0FDMRFHyNmP9D3xpZ26aG3MR11hkVmI=;
 b=flqf+suxd3MPZEK1UTwvwot4dwDLx4LmIcFM1ZMMhc+eg6iH+4z6r9gcC+A899cbWVyNuU
 V3n1qj+aMBXA8tCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710182529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m7Kv1d0cR5zS0FDMRFHyNmP9D3xpZ26aG3MR11hkVmI=;
 b=W1WmdE8vfmD+pKleR9kN7Jjtbi1n7199o7GQwrb3Rj/4ziYHMnzwzd0E9ADz3E5k3Xius3
 hJGM7YTI0Zo17aIns4IYn8dOPk12cfAJwo4hOUggbYNWUWfwKVJ0ijRa20QzjRKvPgL0C3
 bJOMMdvmMJlZ2L6rmjoDZOnCxM6vscw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710182529;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m7Kv1d0cR5zS0FDMRFHyNmP9D3xpZ26aG3MR11hkVmI=;
 b=flqf+suxd3MPZEK1UTwvwot4dwDLx4LmIcFM1ZMMhc+eg6iH+4z6r9gcC+A899cbWVyNuU
 V3n1qj+aMBXA8tCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D036413695;
 Mon, 11 Mar 2024 18:42:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jsdOJYBQ72WcQAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 11 Mar 2024 18:42:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, Het Gala <het.gala@nutanix.com>
Subject: Re: [PATCH v4 5/8] Add migrate_set_ports into migrate_qmp to update
 migration port value
In-Reply-To: <20240308205951.111747-6-het.gala@nutanix.com>
References: <20240308205951.111747-1-het.gala@nutanix.com>
 <20240308205951.111747-6-het.gala@nutanix.com>
Date: Mon, 11 Mar 2024 15:42:05 -0300
Message-ID: <87r0ggmwzm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Het Gala <het.gala@nutanix.com> writes:

> migrate_set_get_qdict gets qdict with the dst QEMU parameters

s/set_//

> migrate_set_ports() from list of channels reads each QDict for port,
> and fills the port with correct value in case it was 0 in the test.
>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration-helpers.c | 73 +++++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index 91c8a817d2..7c17d78d6b 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -17,6 +17,8 @@
>  #include "qapi/qapi-visit-sockets.h"
>  #include "qapi/qobject-input-visitor.h"
>  #include "qapi/error.h"
> +#include "qapi/qmp/qlist.h"
> +#include "include/qemu/cutils.h"

Extra "include/" here?

>  
>  #include "migration-helpers.h"
>  
> @@ -49,6 +51,37 @@ static char *SocketAddress_to_str(SocketAddress *addr)
>      }
>  }
>  
> +static QDict *SocketAddress_to_qdict(SocketAddress *addr)
> +{
> +    QDict *dict = qdict_new();
> +
> +    switch (addr->type) {
> +    case SOCKET_ADDRESS_TYPE_INET:
> +        qdict_put_str(dict, "type", "inet");
> +        qdict_put_str(dict, "host", addr->u.inet.host);
> +        qdict_put_str(dict, "port", addr->u.inet.port);
> +        break;
> +    case SOCKET_ADDRESS_TYPE_UNIX:
> +        qdict_put_str(dict, "type", "unix");
> +        qdict_put_str(dict, "path", addr->u.q_unix.path);
> +        break;
> +    case SOCKET_ADDRESS_TYPE_FD:
> +        qdict_put_str(dict, "type", "fd");
> +        qdict_put_str(dict, "str", addr->u.fd.str);
> +        break;
> +    case SOCKET_ADDRESS_TYPE_VSOCK:
> +        qdict_put_str(dict, "type", "vsock");
> +        qdict_put_str(dict, "cid", addr->u.vsock.cid);
> +        qdict_put_str(dict, "port", addr->u.vsock.port);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +        break;
> +    }
> +
> +    return dict;
> +}
> +
>  static SocketAddress *
>  migrate_get_socket_address(QTestState *who, const char *parameter)
>  {
> @@ -83,6 +116,44 @@ migrate_get_connect_uri(QTestState *who, const char *parameter)
>      return connect_uri;
>  }
>  
> +static QDict *
> +migrate_get_connect_qdict(QTestState *who, const char *parameter)
> +{
> +    SocketAddress *addrs;
> +    QDict *connect_qdict;
> +
> +    addrs = migrate_get_socket_address(who, parameter);
> +    connect_qdict = SocketAddress_to_qdict(addrs);
> +
> +    qapi_free_SocketAddress(addrs);
> +    return connect_qdict;
> +}
> +
> +static void migrate_set_ports(QTestState *to, QList *channel_list)
> +{
> +    QDict *addr;
> +    QListEntry *entry;
> +    g_autofree const char *addr_port = NULL;
> +
> +    if (channel_list == NULL) {
> +        return;
> +    }
> +
> +    addr = migrate_get_connect_qdict(to, "socket-address");

addr needs to be freed.

> +
> +    QLIST_FOREACH_ENTRY(channel_list, entry) {
> +        QDict *channel = qobject_to(QDict, qlist_entry_obj(entry));
> +        QDict *addrdict = qdict_get_qdict(channel, "addr");
> +
> +        if (qdict_haskey(addrdict, "port") &&
> +            qdict_haskey(addr, "port") &&
> +            (strcmp(qdict_get_str(addrdict, "port"), "0") == 0)) {
> +                addr_port = qdict_get_str(addr, "port");
> +                qdict_put_str(addrdict, "port", addr_port);
> +        }
> +    }
> +}
> +
>  bool migrate_watch_for_events(QTestState *who, const char *name,
>                                QDict *event, void *opaque)
>  {
> @@ -141,6 +212,7 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
>  {
>      va_list ap;
>      QDict *args;
> +    QList *channel_list = NULL;
>      g_autofree char *connect_uri = NULL;
>  
>      va_start(ap, fmt);
> @@ -151,6 +223,7 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
>      if (!uri) {
>          connect_uri = migrate_get_connect_uri(to, "socket-address");
>      }
> +    migrate_set_ports(to, channel_list);
>      qdict_put_str(args, "uri", uri ? uri : connect_uri);
>  
>      qtest_qmp_assert_success(who,

