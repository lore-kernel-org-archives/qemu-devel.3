Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A22FC54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 12:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl78j-0007uD-GF; Fri, 15 Mar 2024 08:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rl78h-0007sc-Uh
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 08:58:24 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rl78e-0004e5-3f
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 08:58:21 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 533DB1FB63;
 Fri, 15 Mar 2024 12:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710507498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x8mS4vVLpuNnr3MxW5DQVecyZwsQAw2vQLiSKkxf6uo=;
 b=GbUA5wU8p32Jnbp0Mca536hsNYcAffIFHiY9XOoOiwnjoRM/QOjWefz4PAiK0p1CjFzLci
 PBlQ9PlfvmuQ4EA2Cs4viMBDR8o+zGz2vp08XahyTQSdjxrwsWCLLeZU2ND7v4/NMfahu9
 l8tCiZY1tISAUUJON5K4Kt+1GVjyI+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710507498;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x8mS4vVLpuNnr3MxW5DQVecyZwsQAw2vQLiSKkxf6uo=;
 b=u35K1UqU19yqGBH8kDz0auT8bWeCdPCZr9e0HeKFAUSgdiabqkARB1yJUKdL0AO6tISTpv
 qbzLN2NSwHGaDcDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710507498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x8mS4vVLpuNnr3MxW5DQVecyZwsQAw2vQLiSKkxf6uo=;
 b=GbUA5wU8p32Jnbp0Mca536hsNYcAffIFHiY9XOoOiwnjoRM/QOjWefz4PAiK0p1CjFzLci
 PBlQ9PlfvmuQ4EA2Cs4viMBDR8o+zGz2vp08XahyTQSdjxrwsWCLLeZU2ND7v4/NMfahu9
 l8tCiZY1tISAUUJON5K4Kt+1GVjyI+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710507498;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x8mS4vVLpuNnr3MxW5DQVecyZwsQAw2vQLiSKkxf6uo=;
 b=u35K1UqU19yqGBH8kDz0auT8bWeCdPCZr9e0HeKFAUSgdiabqkARB1yJUKdL0AO6tISTpv
 qbzLN2NSwHGaDcDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D00C41368C;
 Fri, 15 Mar 2024 12:58:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id i5RuJelF9GWLIAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 15 Mar 2024 12:58:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, Het Gala <het.gala@nutanix.com>
Subject: Re: [PATCH v7 3/8] tests/qtest/migration: Replace
 migrate_get_connect_uri inplace of migrate_get_socket_address
In-Reply-To: <20240312202634.63349-4-het.gala@nutanix.com>
References: <20240312202634.63349-1-het.gala@nutanix.com>
 <20240312202634.63349-4-het.gala@nutanix.com>
Date: Fri, 15 Mar 2024 09:58:15 -0300
Message-ID: <871q8b8xeg.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Authentication-Results: smtp-out2.suse.de;
	none
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

> Refactor migrate_get_socket_address to internally utilize 'socket-address'
> parameter, reducing redundancy in the function definition.
>
> migrate_get_socket_address implicitly converts SocketAddress into str.
> Move migrate_get_socket_address inside migrate_get_connect_uri which
> should return the uri string instead.
>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration-helpers.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index 3e8c19c4de..8806dc841e 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -48,28 +48,37 @@ static char *SocketAddress_to_str(SocketAddress *addr)
>      }
>  }
>  
> -static char *
> -migrate_get_socket_address(QTestState *who, const char *parameter)
> +static SocketAddress *migrate_get_socket_address(QTestState *who)
>  {
>      QDict *rsp;
> -    char *result;
>      SocketAddressList *addrs;
> +    SocketAddress *addr;
>      Visitor *iv = NULL;
>      QObject *object;
>  
>      rsp = migrate_query(who);
> -    object = qdict_get(rsp, parameter);
> +    object = qdict_get(rsp, "socket-address");

Just a heads up, none of what I'm about to say applies to current
master.

This can return NULL if there is no socket-address, such as with a file
migration. Then the visitor code below just barfs. It would be nice if
we touched this up eventually.

I only noticed this because I was fiddling with the file migration API
and this series helped me a lot to test my changes. So thanks for that,
Het.

Another point is: we really need to encourage people to write tests
using the new channels API. I added the FileMigrationArgs with the
'offset' as a required parameter, not even knowing optional parameters
were a thing. So it's obviously not enough to write support for the new
API if no tests ever touch it.

>  
>      iv = qobject_input_visitor_new(object);
>      visit_type_SocketAddressList(iv, NULL, &addrs, &error_abort);
> +    addr = addrs->value;
>      visit_free(iv);
>  
> -    /* we are only using a single address */
> -    result = SocketAddress_to_str(addrs->value);
> -
> -    qapi_free_SocketAddressList(addrs);
>      qobject_unref(rsp);
> -    return result;
> +    return addr;
> +}
> +
> +static char *
> +migrate_get_connect_uri(QTestState *who)
> +{
> +    SocketAddress *addrs;
> +    char *connect_uri;
> +
> +    addrs = migrate_get_socket_address(who);
> +    connect_uri = SocketAddress_to_str(addrs);
> +
> +    qapi_free_SocketAddress(addrs);
> +    return connect_uri;
>  }
>  
>  bool migrate_watch_for_events(QTestState *who, const char *name,
> @@ -129,7 +138,7 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
>  
>      g_assert(!qdict_haskey(args, "uri"));
>      if (!uri) {
> -        connect_uri = migrate_get_socket_address(to, "socket-address");
> +        connect_uri = migrate_get_connect_uri(to);
>      }
>      qdict_put_str(args, "uri", uri ? uri : connect_uri);

