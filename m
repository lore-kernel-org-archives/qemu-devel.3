Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75722C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 14:37:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhsOH-0004Ay-19; Wed, 06 Mar 2024 09:37:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rhsOF-0004Ai-RG
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:37:03 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rhsOE-0000jE-2r
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:37:03 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DF7DD76E31;
 Wed,  6 Mar 2024 14:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709735817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wzpm4moMCrZkekS+MbNzkre1f7RV3LS474wvycCr7Uc=;
 b=MljCZEpx+24N+Lijy4RCul4Qq6riM0BDLKSOJxEl0xL7ON2MGcXvgIRnx4QkAj1P9YFsZh
 AzT7ze93YrN1AS8VvnroRqBqLqecpak7BBz7eL0V3UKY4JQrZBuEYRiKkC6Nh3Oslh9vfF
 B+Icx0YrDAYj6vuHeRu+LoSoUED5QDE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709735817;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wzpm4moMCrZkekS+MbNzkre1f7RV3LS474wvycCr7Uc=;
 b=anfnwgcG31zrrTpvjcB8PmumYWb24OPP46QX30Y+5pOzeI4ZHBIJxfhL2w8eFvXRemIK1Y
 /nOFSyNuE7nS5aDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709735815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wzpm4moMCrZkekS+MbNzkre1f7RV3LS474wvycCr7Uc=;
 b=reuN4gAucjb6XFb9Q6v1JY4K2/8EOVWx+8St5zKw3vXqX/aqLJOhOGfArU8j3F/yqM8TLP
 V9NLyYktJEcLFhD8CAR0uy68gITj2SA7A9W4TvrYrDqMvLCWWm9bp0z+JrW+/D16CCP8BE
 3otDgF9Sy6cdBgXqh0q6YrfWz2USKko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709735815;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wzpm4moMCrZkekS+MbNzkre1f7RV3LS474wvycCr7Uc=;
 b=VzyvtLwcx2oCgCs/MZv7eovnmGv9TOojBBZc2Oelu3es2Qg9gfXzNks4GepqsNHBqgjlap
 y6mZbtmfxeEA7fAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C3A613A67;
 Wed,  6 Mar 2024 14:36:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id t7L8CId/6GXJRwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 06 Mar 2024 14:36:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, Het Gala <het.gala@nutanix.com>
Subject: Re: [PATCH v3 4/7] Add migrate_set_ports into migrate_qmp to change
 migration port number
In-Reply-To: <20240306104958.39857-5-het.gala@nutanix.com>
References: <20240306104958.39857-1-het.gala@nutanix.com>
 <20240306104958.39857-5-het.gala@nutanix.com>
Date: Wed, 06 Mar 2024 11:36:52 -0300
Message-ID: <87sf13s9yz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=reuN4gAu;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VzyvtLwc
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[nutanix.com:email,suse.de:dkim,suse.de:email]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: DF7DD76E31
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

> Add a migrate_set_ports() function that from each QDict, fills in
> the port in case it was 0 in the test.
> Handle a list of channels so we can add a negative test that
> passes more than one channel.
>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration-helpers.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index 478c1f259b..df4978bf17 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -17,6 +17,8 @@
>  #include "qapi/qapi-visit-sockets.h"
>  #include "qapi/qobject-input-visitor.h"
>  #include "qapi/error.h"
> +#include "qapi/qmp/qlist.h"
> +

Extra line here. This is unwanted because it sometimes trips git into
thinking there's a conflict here when another patch changes the
surrounding lines.

>  
>  #include "migration-helpers.h"
>  
> @@ -73,6 +75,29 @@ migrate_get_socket_address(QTestState *who, const char *parameter)
>      return result;
>  }
>  
> +static void migrate_set_ports(QTestState *to, QList *channelList)
> +{
> +    g_autofree char *addr = NULL;
> +    g_autofree char *addr_port = NULL;
> +    QListEntry *entry;
> +
> +    addr = migrate_get_socket_address(to, "socket-address");
> +    addr_port = g_strsplit(addr, ":", 3)[2];

Will this always to the right thing when the src/dst use different types
of channels? If there is some kind of mismatch (say one side uses vsock
and the other inet), it's better that this function doesn't touch the
channels dict instead of putting garbage in the port field.

Also what happens if the dst is using unix: or fd:?

> +
> +    QLIST_FOREACH_ENTRY(channelList, entry) {
> +        QDict *channel = qobject_to(QDict, qlist_entry_obj(entry));
> +        QObject *addr_obj = qdict_get(channel, "addr");
> +
> +        if (qobject_type(addr_obj) == QTYPE_QDICT) {
> +            QDict *addrdict = qobject_to(QDict, addr_obj);

You might not need these two lines if at the start you use:

QDict *addr = qdict_get_dict(channel, "addr");

> +            if (qdict_haskey(addrdict, "port") &&
> +            (strcmp(qdict_get_str(addrdict, "port"), "0") == 0)) {
> +                qdict_put_str(addrdict, "port", addr_port);
> +            }
> +        }
> +    }
> +}
> +
>  bool migrate_watch_for_events(QTestState *who, const char *name,
>                                QDict *event, void *opaque)
>  {
> @@ -143,6 +168,7 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
>      if (!uri) {
>          connect_uri = migrate_get_socket_address(to, "socket-address");
>      }
> +    migrate_set_ports(to, NULL);

migrate_set_ports is not prepared to take NULL. This breaks the tests in
this commit. All individual commits should work, otherwise it will break
bisecting.

>      qdict_put_str(args, "uri", uri ? uri : connect_uri);
>  
>      qtest_qmp_assert_success(who,

