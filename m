Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC38C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkJ1-00016V-SZ; Mon, 11 Mar 2024 14:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rjkFd-0005mB-Rb
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 14:19:56 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rjkFc-00070M-4x
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 14:19:53 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 029B534F58;
 Mon, 11 Mar 2024 18:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710181190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oa24s/RmbOuJt2FACdBkY1RkISeZsDK2GPm9lLFLn80=;
 b=eOhfWvLMZahnQB33GjPjy6KTPHts1VLTlF97wIjZnkfWM+yq3Mvz3jajWApyk+hFim8mSG
 4sV2S+09ZULE7jsJ+1ksWJt61MMnqkIss7gERscUlcpTm/d0UhtPGKDCA+e3Z2lAjHhF5x
 qRVLbDWgkb3To2orogO+XiUW1lNqCDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710181190;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oa24s/RmbOuJt2FACdBkY1RkISeZsDK2GPm9lLFLn80=;
 b=igmwz7KviXYMUzWKNCPKdwPs5ltXhATix6xS6+ekOLWBS30xPjWWW2bSG/W1slZeEFyDe1
 6nTnF3z+W/ZF9IBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710181190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oa24s/RmbOuJt2FACdBkY1RkISeZsDK2GPm9lLFLn80=;
 b=eOhfWvLMZahnQB33GjPjy6KTPHts1VLTlF97wIjZnkfWM+yq3Mvz3jajWApyk+hFim8mSG
 4sV2S+09ZULE7jsJ+1ksWJt61MMnqkIss7gERscUlcpTm/d0UhtPGKDCA+e3Z2lAjHhF5x
 qRVLbDWgkb3To2orogO+XiUW1lNqCDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710181190;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oa24s/RmbOuJt2FACdBkY1RkISeZsDK2GPm9lLFLn80=;
 b=igmwz7KviXYMUzWKNCPKdwPs5ltXhATix6xS6+ekOLWBS30xPjWWW2bSG/W1slZeEFyDe1
 6nTnF3z+W/ZF9IBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C61C136BA;
 Mon, 11 Mar 2024 18:19:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eNTyEEVL72XhOQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 11 Mar 2024 18:19:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, Het Gala <het.gala@nutanix.com>
Subject: Re: [PATCH v4 3/8] Replace migrate_get_connect_uri inplace of
 migrate_get_socket_address
In-Reply-To: <20240308205951.111747-4-het.gala@nutanix.com>
References: <20240308205951.111747-1-het.gala@nutanix.com>
 <20240308205951.111747-4-het.gala@nutanix.com>
Date: Mon, 11 Mar 2024 15:19:47 -0300
Message-ID: <87wmq8my0s.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eOhfWvLM;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=igmwz7Kv
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.98 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-2.97)[99.87%];
 MIME_GOOD(-0.10)[text/plain]; RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: 029B534F58
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> migrate_get_socket_address implicitly converts SocketAddress into str.
> Move migrate_get_socket_address inside migrate_get_connect_uri which
> should return the uri string instead.
>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration-helpers.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
>
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index 9af3c7d4d5..3c3fe9d8aa 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -49,12 +49,12 @@ static char *SocketAddress_to_str(SocketAddress *addr)
>      }
>  }
>  
> -static char *
> +static SocketAddress *
>  migrate_get_socket_address(QTestState *who, const char *parameter)
>  {
>      QDict *rsp;
> -    char *result;
>      SocketAddressList *addrs;
> +    SocketAddress *addr;
>      Visitor *iv = NULL;
>      QObject *object;
>  
> @@ -63,14 +63,24 @@ migrate_get_socket_address(QTestState *who, const char *parameter)
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
> +migrate_get_connect_uri(QTestState *who, const char *parameter)
> +{
> +    SocketAddress *addrs;
> +    char *connect_uri;
> +
> +    addrs = migrate_get_socket_address(who, parameter);
> +    connect_uri = SocketAddress_to_str(addrs);
> +
> +    qapi_free_SocketAddress(addrs);
> +    return connect_uri;
>  }
>  
>  bool migrate_watch_for_events(QTestState *who, const char *name,
> @@ -130,7 +140,7 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
>  
>      g_assert(!qdict_haskey(args, "uri"));
>      if (!uri) {
> -        connect_uri = migrate_get_socket_address(to, "socket-address");
> +        connect_uri = migrate_get_connect_uri(to, "socket-address");

What's the point of the "socket-address" argument here? Seems a bit
nonsensical to me to call: migrate_get_socket_address(..., "socket-address").

What about we just suppress this throughout the stack and directly call:

    object = qdict_get(rsp, "socket-address");

